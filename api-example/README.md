# Keplars API Example (Dart)

This example demonstrates how to send emails using the Keplars REST API with the Dart `http` package.

## Prerequisites

- Dart SDK 3.0 or higher
- Keplars account with API key

## Setup

1. Install dependencies:
```bash
dart pub get
```

2. Copy `.env.example` to `.env` and configure your credentials:
```bash
cp .env.example .env
```

3. Edit `.env` with your Keplars API credentials:
```env
API_BASE_URL=https://api.keplars.com/api/v1/public
API_KEY=kms_your_key_here
TO_EMAIL=recipient@example.com
USER_NAME=your-username
```

## Usage

```bash
dart run bin/main.dart
```

The script will send an instant email and display the results in the console.

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `API_BASE_URL` | Keplars API base URL | `https://api.keplars.com/api/v1/public` |
| `API_KEY` | Your Keplars API key (starts with `kms_`) | `kms_xxxx` |
| `TO_EMAIL` | Recipient email address | `recipient@example.com` |
| `USER_NAME` | Username for personalization | `your-username` |

## API Endpoint

The example uses the `/send-email/instant` endpoint which sends emails immediately.

### Request Format

```json
{
  "to": ["recipient@example.com"],
  "subject": "Email Subject",
  "body": "<h1>HTML content</h1>",
  "is_html": true
}
```

## Authentication

The API uses Bearer token authentication:

```
Authorization: Bearer kms_xxxx
```

## Troubleshooting

- **401 Unauthorized**: Check that your `API_KEY` is correct and starts with `kms_`
- **400 Bad Request**: Verify request payload format matches the API specification
- **Network errors**: Ensure `API_BASE_URL` is correct and you have internet connectivity
