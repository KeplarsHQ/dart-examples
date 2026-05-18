# Keplars Dart SDK Example

Shelf demo showing idiomatic Dart integration with the [Keplars](https://keplars.com) email SDK using native `async/await` and `Future`.

## Requirements

- Dart 3.0+
- A Keplars API key ([get one here](https://dash.keplars.com))

## SDK Dependency

```bash
dart pub add keplars
```

Or add to your `pubspec.yaml`:

```yaml
dependencies:
  keplars: ^1.10.5
```

Then import and use:

```dart
import 'package:keplars/keplars.dart';

final keplars = Keplars(apiKey: 'kms_your_api_key');

final resp = await keplars.emails.sendInstant(SendEmailRequest(
  to: 'user@example.com',
  from: 'hello@yourdomain.com',
  subject: 'Hello!',
  html: '<h1>Hello World</h1>',
));
```

## Setup

```bash
cd sdk-example
cp .env.example .env
dart pub get
```

Set your API key in `.env`:

```bash
KEPLARS_API_KEY=kms_your_key_here
```

Run:

```bash
dart run bin/server.dart
```

Server starts on `http://localhost:8080`.

## Project Structure

```
sdk-example/
├── bin/
│   └── server.dart          Entry point
└── lib/
    └── routes/
        ├── email_routes.dart    Transactional + marketing endpoints
        └── webhook_routes.dart  Webhook receiver with HMAC-SHA256 verification
```

## API Endpoints

### Transactional Emails

**Send welcome email:**
```bash
curl -X POST http://localhost:8080/api/emails/welcome \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","firstName":"Jane"}'
```

**Send OTP:**
```bash
curl -X POST http://localhost:8080/api/emails/otp \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","otp":"847291"}'
```

**Send password reset:**
```bash
curl -X POST http://localhost:8080/api/emails/password-reset \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","resetLink":"https://yourapp.com/reset/abc123"}'
```

**Send order confirmation:**
```bash
curl -X POST http://localhost:8080/api/emails/order-confirmation \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","orderId":"ORD-9921","total":"$49.99"}'
```

### Marketing Emails

**Send newsletter (bulk):**
```bash
curl -X POST http://localhost:8080/api/emails/newsletter \
  -H "Content-Type: application/json" \
  -d '{
    "recipients": ["a@example.com","b@example.com"],
    "subject": "Our Monthly Update",
    "html": "<h1>Hello!</h1>"
  }'
```

**Schedule newsletter:**
```bash
curl -X POST http://localhost:8080/api/emails/newsletter/schedule \
  -H "Content-Type: application/json" \
  -d '{
    "recipients": ["a@example.com","b@example.com"],
    "subject": "Weekend Deal",
    "html": "<h1>Special offer!</h1>",
    "scheduledFor": "2025-06-01T09:00:00Z"
  }'
```

### Webhooks

Point your Keplars webhook URL to:
```
POST https://your-server.com/webhooks/keplars
```

Set the webhook secret in `.env`:
```bash
KEPLARS_WEBHOOK_SECRET=your_webhook_secret
```

Supported events: `email.delivered`, `email.bounced`, `email.complained`, `email.opened`, `email.clicked`, `email.failed`

## Priority Queue

| Use Case | Method | Priority |
|---|---|---|
| OTP, auth codes | `sendInstant` | Instant (fastest) |
| Password reset, alerts | `sendHigh` | High |
| Welcome, notifications | `send` | Async |
| Newsletters, campaigns | `sendBulk` | Bulk |

## Related Examples

- [Go Examples](https://github.com/KeplarsHQ/go-examples) — Gin
- [Ruby Examples](https://github.com/KeplarsHQ/ruby-examples) — Sinatra
- [Kotlin Examples](https://github.com/KeplarsHQ/kotlin-examples) — Ktor + coroutines
- [Node.js Examples](https://github.com/KeplarsHQ/nodejs-examples) — Express

## License

MIT
