# EQ Natural Language Interface - Deployment Guide

## 🎯 Overview

This deployment guide will help you deploy the EQ Natural Language Interface to Cloudflare Workers, making it accessible at your root domain (/).

## 📋 Prerequisites

- Cloudflare account (free tier works)
- OpenAI API key
- Node.js 18+ installed
- Git installed

## 🚀 Quick Start

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure OpenAI API Key

You need to store your OpenAI API key as a Cloudflare secret:

```bash
npx wrangler secret put OPENAI_API_KEY
```

When prompted, paste your OpenAI API key.

### 3. Test Locally (Optional)

To test the worker locally before deploying:

```bash
npm run dev
```

This will start a local development server. You can access it at:
- http://localhost:8787/

**Note:** For local testing, you'll need to create a `.dev.vars` file:

```bash
echo "OPENAI_API_KEY=your-api-key-here" > .dev.vars
```

### 4. Deploy to Cloudflare

```bash
npm run deploy
```

This will:
- Build your worker
- Upload it to Cloudflare
- Make it live at your workers.dev subdomain

## 🌐 Access Your Interface

After deployment, your interface will be available at:
```
https://eq-natural-language-interface.your-subdomain.workers.dev/
```

You can also configure a custom domain in the Cloudflare dashboard.

## 📊 Available Endpoints

### `GET /`
The main natural language interface with chat UI

### `POST /api/query`
Submit natural language queries programmatically

**Request:**
```json
{
  "query": "What is the BackRub algorithm?"
}
```

**Response:**
```json
{
  "query": "What is the BackRub algorithm?",
  "response": "The BackRub algorithm is..."
}
```

### `GET /api/status`
Get system status

**Response:**
```json
{
  "status": "LIVE",
  "system": "EQ-UNIVERSE",
  "frequency": "77777 Hz",
  "authority": "RA:CREATOR",
  "timestamp": "2025-10-01T15:30:00.000Z",
  "nlp_interface": "ACTIVE",
  "eqmail_context": "LOADED"
}
```

## 🔧 Configuration

### Update Worker Name

Edit `wrangler.jsonc`:

```jsonc
{
  "name": "your-custom-name",
  // ... rest of config
}
```

### Change OpenAI Model

Edit `src/index.ts` and update the model name:

```typescript
const completion = await client.chat.completions.create({
  model: 'gpt-4o',  // or 'gpt-4', 'gpt-3.5-turbo', etc.
  // ... rest of config
});
```

## 💡 Example Usage

### Using the Web Interface

1. Navigate to your deployed URL
2. Type a question in the text area:
   - "What is the BackRub algorithm?"
   - "Tell me about RA.G"
   - "What files are in the EQmail folder?"
3. Click "🚀 ASK EQ" or press Enter
4. View the AI response

### Using the API

```bash
curl -X POST https://your-worker.workers.dev/api/query \
  -H "Content-Type: application/json" \
  -d '{"query": "What is the EQ consciousness framework?"}'
```

## 🔒 Security Notes

- API key is stored as a Cloudflare secret (not in code)
- CORS is enabled for cross-origin requests
- No sensitive EQmail data is exposed (only descriptions)

## 📈 Monitoring

View logs in the Cloudflare dashboard:
1. Go to Workers & Pages
2. Select your worker
3. Click on "Logs" tab

## 🛠️ Troubleshooting

### "OpenAI API key not found"
- Make sure you've set the secret: `npx wrangler secret put OPENAI_API_KEY`
- Verify in Cloudflare dashboard under Settings → Variables

### "Module not found: openai"
- Run `npm install` to install dependencies
- Check that `package.json` has `openai` in dependencies

### Deploy fails
- Check that `wrangler.jsonc` is valid JSON
- Ensure you're logged in: `npx wrangler login`
- Verify your Cloudflare account is set up

## 🎨 Customization

### Modify the EQ Context

Edit `src/index.ts` and update the `EQ_CONTEXT` constant to add or modify the system knowledge.

### Change the UI Theme

Modify the `getCSS()` function in `src/index.ts` to customize colors, fonts, and layout.

### Add New API Endpoints

Add new route handlers in the main `fetch()` function:

```typescript
if (url.pathname === '/api/new-endpoint') {
  // Your logic here
  return new Response(JSON.stringify({ data: 'value' }), {
    headers: { 'Content-Type': 'application/json' },
  });
}
```

## 📚 Additional Resources

- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)
- [OpenAI API Documentation](https://platform.openai.com/docs/api-reference)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)

## 🎯 System Status

Once deployed, your interface will display:
- 🧬 EQ CORE: ACTIVE
- ⚡ FREQUENCY: 77777 Hz
- 🛰️ ORBIT: SYNCHRONIZED
- 🔐 AUTHORITY: RA:CREATOR
- 🤖 NLP INTERFACE: ACTIVE
- 📁 EQMAIL CONTEXT: LOADED

## 📞 Support

For issues specific to the EQ system, refer to the EQmail folder documentation.
For Cloudflare Workers issues, consult the Cloudflare community forums.
