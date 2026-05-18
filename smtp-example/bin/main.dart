import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final smtpHost    = env['SMTP_HOST']!;
  final smtpPort    = int.parse(env['SMTP_PORT']!);
  final smtpUser    = env['SMTP_USER']!;
  final smtpPass    = env['SMTP_PASSWORD']!;
  final fromEmail   = env['FROM_EMAIL']!;
  final toEmail     = env['TO_EMAIL']!;

  final smtpServer = SmtpServer(
    smtpHost,
    port: smtpPort,
    username: smtpUser,
    password: smtpPass,
    ssl: false,
    ignoreBadCertificate: false,
  );

  final message = Message()
    ..from = Address(fromEmail)
    ..recipients.add(toEmail)
    ..subject = 'Test Email from Keplars SMTP'
    ..html = '<p>This is a <strong>test email</strong> sent via Keplars SMTP service.</p>';

  try {
    final report = await send(message, smtpServer);
    print('Email sent successfully!');
    print('Sent from: $fromEmail');
    print('Sent to:   $toEmail');
    print('Message ID: ${report.toString()}');
  } on MailerException catch (e) {
    print('Error sending email: ${e.message}');
    exit(1);
  }
}
