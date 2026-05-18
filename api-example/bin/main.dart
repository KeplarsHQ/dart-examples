import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final apiBaseUrl  = env['API_BASE_URL']!;
  final apiKey      = env['API_KEY']!;
  final toEmail     = env['TO_EMAIL']!;
  final userName    = env['USER_NAME']!;

  final response = await http.post(
    Uri.parse('$apiBaseUrl/send-email/instant'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'to': [toEmail],
      'subject': 'Welcome $userName!',
      'body': '<h1>Welcome $userName!</h1><p>Thank you for joining our platform.</p>',
      'is_html': true,
    }),
  );

  final result = jsonDecode(response.body);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    print('Email sent successfully!');
    print('Response: $result');
  } else {
    print('Error sending email (status ${response.statusCode}): $result');
    exit(1);
  }
}
