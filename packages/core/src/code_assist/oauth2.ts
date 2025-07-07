//  OAuth Client ID used to initiate OAuth2Client class.
// TODO: Replace with your own OAuth Client ID
export const OAUTH_CLIENT_ID = process.env.GOOGLE_OAUTH_CLIENT_ID || 'YOUR_OAUTH_CLIENT_ID';

// OAuth Secret value used to initiate OAuth2Client class.
// TODO: Replace with your own OAuth Client Secret
export const OAUTH_CLIENT_SECRET = process.env.GOOGLE_OAUTH_CLIENT_SECRET || 'YOUR_OAUTH_CLIENT_SECRET';

// OAuth Scopes for Cloud Code authorization.
export const OAUTH_SCOPES = [
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/userinfo.email',
];
