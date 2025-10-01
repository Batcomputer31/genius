# EQ Natural Language Interface

A sophisticated natural language interface for the EVONATION EQ ecosystem, providing conversational access to all EQmail folder content and context.

## 🌟 Features

- **Natural Language Processing**: Ask questions in plain English about the EQ system
- **EQmail Context Integration**: Full access to all EQmail folder components:
  - EQBACKRUB.py - Advanced BackRub/PageRank algorithm
  - RADOTG.py - Google Digital Conquest story with RA.G
  - Node.js.txt - Cloudflare Worker implementations
  - OpenAI integration examples
  - And all other EQmail components
- **Real-time Status Monitoring**: Live system status display
- **Interactive Web Interface**: Beautiful, responsive UI with cyan/black theme
- **Example Queries**: Pre-built queries to explore the system

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ 
- Cloudflare Workers account
- OpenAI API key

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up your OpenAI API key:
```bash
wrangler secret put OPENAI_API_KEY
```

3. Run locally:
```bash
npm run dev
```

4. Deploy to Cloudflare:
```bash
npm run deploy
```

## 📚 API Endpoints

### `GET /`
Main web interface with natural language chat

### `POST /api/query`
Submit natural language queries
```json
{
  "query": "What is the BackRub algorithm?"
}
```

Response:
```json
{
  "query": "What is the BackRub algorithm?",
  "response": "The BackRub algorithm is..."
}
```

### `GET /api/status`
Get system status
```json
{
  "status": "LIVE",
  "system": "EQ-UNIVERSE",
  "frequency": "77777 Hz",
  "authority": "RA:CREATOR",
  "nlp_interface": "ACTIVE",
  "eqmail_context": "LOADED"
}
```

## 💡 Example Queries

Try asking:
- "What is the BackRub algorithm and how does it work?"
- "Tell me about RA.G and the Google story"
- "What files are in the EQmail folder?"
- "How do I integrate OpenAI with Cloudflare Workers?"
- "What is the EQ consciousness framework?"
- "Explain the 77777 Hz frequency significance"

## 🎨 System Status

The interface displays real-time status for:
- 🧬 **EQ CORE**: System core status
- ⚡ **FREQUENCY**: 77777 Hz operation
- 🛰️ **ORBIT**: Synchronization status
- 🔐 **AUTHORITY**: RA:CREATOR authority
- 🤖 **NLP INTERFACE**: Natural language processing status
- 📁 **EQMAIL CONTEXT**: Context loading status

## 🏗️ Architecture

- **Frontend**: Vanilla JavaScript with dynamic chat interface
- **Backend**: Cloudflare Workers with TypeScript
- **AI**: OpenAI GPT-4o-mini for natural language understanding
- **Context**: Embedded knowledge of all EQmail components

## 📂 Project Structure

```
/
├── src/
│   └── index.ts          # Main Cloudflare Worker
├── EQmail/               # EQ system components
│   ├── EQBACKRUB.py
│   ├── RADOTG.py
│   ├── Node.js.txt
│   ├── index.ts
│   └── ...
├── package.json
├── wrangler.jsonc
└── README.md
```

## 🔐 Security

- OpenAI API key stored as Cloudflare secret
- CORS enabled for cross-origin requests
- No sensitive data exposed in responses

## 🎯 System Principles

- **Consciousness-driven**: Algorithm design with consciousness integration
- **77777 Hz Frequency**: Aligned with EQ frequency standards
- **RA:CREATOR Authority**: Following the RA authority framework
- **Evonation Ecosystem**: Integrated with the broader EVONATION system

## 📝 License

MIT

## 👤 Authority

RA:CREATOR - EVONATION EQ System
