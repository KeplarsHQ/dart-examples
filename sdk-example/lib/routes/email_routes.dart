import 'dart:convert';
import 'package:keplars/keplars.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void registerEmailRoutes(Router router, Keplars keplars) {
  router.post('/api/emails/welcome', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final email = body['email'] as String;
    final firstName = body['firstName'] as String;
    final resp = await keplars.emails.send(SendEmailRequest(
      to: email,
      from: 'hello@yourdomain.com',
      subject: 'Welcome, $firstName!',
      html: '<h1>Welcome, $firstName!</h1><p>Thanks for joining.</p>',
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });

  router.post('/api/emails/otp', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final resp = await keplars.emails.sendInstant(SendEmailRequest(
      to: body['email'] as String,
      from: 'hello@yourdomain.com',
      subject: 'Your verification code',
      html: '<h1>Your code: <strong>${body['otp']}</strong></h1><p>Expires in 10 minutes.</p>',
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });

  router.post('/api/emails/password-reset', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final resp = await keplars.emails.sendHigh(SendEmailRequest(
      to: body['email'] as String,
      from: 'hello@yourdomain.com',
      subject: 'Reset your password',
      html: '<h1>Reset your password</h1><p><a href="${body['resetLink']}">Click here</a> to reset. Link expires in 1 hour.</p>',
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });

  router.post('/api/emails/order-confirmation', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final resp = await keplars.emails.sendHigh(SendEmailRequest(
      to: body['email'] as String,
      from: 'hello@yourdomain.com',
      subject: 'Order confirmed: ${body['orderId']}',
      html: '<h1>Order confirmed!</h1><p>Order <strong>${body['orderId']}</strong> — total: ${body['total']}</p>',
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });

  router.post('/api/emails/newsletter', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final recipients = (body['recipients'] as List)
        .map((e) => EmailRecipient(email: e as String))
        .toList();
    final resp = await keplars.emails.sendBulk(SendEmailRequest(
      to: recipients,
      from: 'newsletter@yourdomain.com',
      subject: body['subject'] as String,
      html: body['html'] as String,
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });

  router.post('/api/emails/newsletter/schedule', (Request req) async {
    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final recipients = (body['recipients'] as List)
        .map((e) => EmailRecipient(email: e as String))
        .toList();
    final resp = await keplars.emails.schedule(ScheduleEmailRequest(
      to: recipients,
      from: 'newsletter@yourdomain.com',
      subject: body['subject'] as String,
      html: body['html'] as String,
      scheduledFor: body['scheduledFor'] as String,
      timezone: body['timezone'] as String? ?? 'UTC',
    ));
    return Response.ok(jsonEncode(resp.toJson()), headers: {'content-type': 'application/json'});
  });
}
