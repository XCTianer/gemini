# OAuth Setup Guide

## Environment Variables

This project requires Google OAuth credentials to be configured via environment variables. Create a `.env` file in the root directory with the following variables:

```bash
# Google OAuth Configuration
GOOGLE_OAUTH_CLIENT_ID=your_google_oauth_client_id_here
GOOGLE_OAUTH_CLIENT_SECRET=your_google_oauth_client_secret_here
```

## Getting Google OAuth Credentials

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Google+ API
4. Go to "Credentials" in the left sidebar
5. Click "Create Credentials" → "OAuth 2.0 Client IDs"
6. Choose "Desktop application" as the application type
7. Give it a name and click "Create"
8. Copy the Client ID and Client Secret to your `.env` file

## Security Notes

- Never commit your `.env` file to version control
- The `.env` file is already included in `.gitignore`
- Keep your OAuth credentials secure and don't share them publicly

## Usage

After setting up the environment variables, the application will automatically use them for OAuth authentication. 