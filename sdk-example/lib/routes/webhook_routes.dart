import 'dart:convert';
import 'package:keplars/keplars.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void registerWebhookRoutes(Router router, String webhookSecret) {
  router.post('/webhooks/keplars', (Request req) async {
    final signature = req.headers['x-keplars-signature'] ?? '';
    final timestamp = req.headers['x-keplars-timestamp'] ?? '';
    final rawBody = await req.readAsString();

    if (!verifyWebhookSignature(rawBody, signature, timestamp, webhookSecret)) {
      return Response(401, body: jsonEncode({'error': 'Invalid signature'}));
    }

    final payload = jsonDecode(rawBody) as Map<String, dynamic>;
    final event = payload['event'] as String?;
    final data = payload['data'] as Map<String, dynamic>? ?? {};

    switch (event) {
      case 'email.delivered':
        print('Email delivered: ${data['job_id']}');
      case 'email.bounced':
        print('Email bounced: ${data['job_id']} reason: ${data['reason']}');
      case 'email.complained':
        print('Spam complaint: ${data['job_id']}');
      case 'email.opened':
        print('Email opened: ${data['job_id']}');
      case 'email.clicked':
        print('Link clicked: ${data['job_id']} url: ${data['url']}');
      case 'email.failed':
        print('Email failed: ${data['job_id']} reason: ${data['reason']}');
      default:
        print('Unknown event: $event');
    }

    return Response.ok(jsonEncode({'received': true}), headers: {'content-type': 'application/json'});
  });
}
