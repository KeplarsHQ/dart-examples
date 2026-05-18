# Keplars Dart Examples

Dart examples for integrating [Keplars](https://keplars.com) email service.

## SDK Install

```bash
dart pub add keplars
```

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

## Examples

### SDK Example (`sdk-example/`) — Recommended

Full Shelf HTTP server demo using the official Dart SDK. Covers transactional emails, bulk/scheduled marketing emails, webhook signature verification, and priority queue usage.

[View SDK Example →](./sdk-example/)

### API Example (`api-example/`)

Minimal script sending a single email via raw HTTP using the `http` package — no SDK required.

[View API Example →](./api-example/)

### SMTP Example (`smtp-example/`)

Minimal script sending a single email via SMTP using the `mailer` package — no SDK required.

[View SMTP Example →](./smtp-example/)

## Quick Start

```bash
cd sdk-example
cp .env.example .env
dart pub get
dart run bin/server.dart
```

Server starts on `http://localhost:8080`.

## Prerequisites

- Dart 3.0+
- A Keplars API key ([get one here](https://dash.keplars.com))

## Related Examples

- [Go Examples](https://github.com/KeplarsHQ/go-examples) — Gin
- [Ruby Examples](https://github.com/KeplarsHQ/ruby-examples) — Sinatra
- [Python Examples](https://github.com/KeplarsHQ/python-examples) — FastAPI
- [Node.js Examples](https://github.com/KeplarsHQ/nodejs-examples) — Express

## License

MIT
