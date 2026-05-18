# Keplars SMTP Example (Dart)

This example demonstrates how to send emails using the Keplars SMTP service with the Dart `mailer` package.

## Prerequisites

- Dart SDK 3.0 or higher
- Keplars account with SMTP credentials

## Setup

1. Install dependencies:
```bash
dart pub get
```

2. Copy `.env.example` to `.env` and configure your credentials:
```bash
cp .env.example .env
```

3. Edit `.env` with your Keplars SMTP credentials:
```env
SMTP_HOST=smtp.keplars.com
SMTP_PORT=2525
SMTP_USER=your-username
SMTP_PASSWORD=your-password
FROM_EMAIL=noreply@yourdomain.com
TO_EMAIL=recipient@example.com
```

## Usage

```bash
dart run bin/main.dart
```

The script will send a test email and display the results in the console.

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `SMTP_HOST` | Keplars SMTP server hostname | `smtp.keplars.com` |
| `SMTP_PORT` | SMTP port number | `2525` |
| `SMTP_USER` | Your Keplars username | `your-username` |
| `SMTP_PASSWORD` | Your Keplars password | `your-password` |
| `FROM_EMAIL` | Sender email address | `noreply@yourdomain.com` |
| `TO_EMAIL` | Recipient email address | `recipient@example.com` |

## Features

- Send HTML emails via SMTP
- PLAIN authentication via `mailer` package
- Async/await support

## Troubleshooting

- **Connection timeout**: Verify `SMTP_HOST` and `SMTP_PORT` are correct
- **Authentication failed**: Check `SMTP_USER` and `SMTP_PASSWORD`
- **Email not delivered**: Ensure `FROM_EMAIL` is authorized in your Keplars account
