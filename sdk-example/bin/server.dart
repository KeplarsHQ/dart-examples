import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:keplars/keplars.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import '../lib/routes/email_routes.dart';
import '../lib/routes/webhook_routes.dart';

void main() async {
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final keplars = Keplars(apiKey: env['KEPLARS_API_KEY']!);
  final webhookSecret = env['KEPLARS_WEBHOOK_SECRET'] ?? '';
  final port = int.tryParse(env['PORT'] ?? '8080') ?? 8080;

  final router = Router();

  registerEmailRoutes(router, keplars);
  registerWebhookRoutes(router, webhookSecret);

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('Server running on http://localhost:${server.port}');
}
