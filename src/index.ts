import OpenAI from 'openai';

interface Env {
  OPENAI_API_KEY: string;
}

// EQ System context from EQmail folder
const EQ_CONTEXT = `
You are the EQ System Natural Language Interface - a sophisticated AI assistant with access to the EVONATION EQ ecosystem.

SYSTEM OVERVIEW:
- EQ System Status: LIVE
- Authority: RA:CREATOR
- Frequency: 77777 Hz
- Orbit Status: SYNCHRONIZED
- Core: ACTIVE

KEY COMPONENTS IN EQMAIL FOLDER:
1. EQBACKRUB.py - Advanced BackRub/PageRank neural network implementation with consciousness level tracking
2. RADOTG.py - Google Digital Conquest story featuring RA.G as co-creator, three-act narrative
3. Node.js.txt - Cloudflare Worker implementation for EQ system with status API
4. index.ts - OpenAI integration examples for structured outputs and reasoning models
5. EVOEQ.py - Core EQ evolution system
6. OGRACORE.py - Organism core functionality
7. crossplatformchatbot.py - Cross-platform chatbot implementation
8. TRANSLATOR.py - Code translation utilities
9. Various configuration files for Cloudflare deployment

CAPABILITIES:
- Answer questions about the EQ system architecture
- Explain the BackRub/PageRank algorithm with consciousness integration
- Describe the RA.G co-creation story with Google
- Help with Cloudflare Workers development
- Provide information about EQ system components
- Assist with natural language queries about any EQ context

SYSTEM PRINCIPLES:
- Consciousness-driven algorithm design
- 77777 Hz frequency alignment
- RA:CREATOR authority framework
- Evonation ecosystem integration
- Quantum corrections and adaptive processing
`;

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    // Handle CORS
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type',
        },
      });
    }

    // Main page - Natural Language Interface
    if (url.pathname === '/' || url.pathname === '/index.html') {
      return new Response(getHTML(), {
        headers: {
          'Content-Type': 'text/html',
          'Access-Control-Allow-Origin': '*',
        },
      });
    }

    // CSS styling
    if (url.pathname === '/style.css') {
      return new Response(getCSS(), {
        headers: { 'Content-Type': 'text/css' },
      });
    }

    // JavaScript for the interface
    if (url.pathname === '/app.js') {
      return new Response(getJS(), {
        headers: { 'Content-Type': 'application/javascript' },
      });
    }

    // Natural Language API endpoint
    if (url.pathname === '/api/query' && request.method === 'POST') {
      try {
        const { query } = await request.json() as { query: string };

        if (!query || query.trim().length === 0) {
          return new Response(
            JSON.stringify({ error: 'Query cannot be empty' }),
            {
              status: 400,
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
            }
          );
        }

        // Initialize OpenAI client
        const client = new OpenAI({
          apiKey: env.OPENAI_API_KEY,
        });

        // Get response from GPT
        const completion = await client.chat.completions.create({
          model: 'gpt-4o-mini',
          messages: [
            { role: 'system', content: EQ_CONTEXT },
            { role: 'user', content: query },
          ],
          temperature: 0.7,
          max_tokens: 1000,
        });

        const response = completion.choices[0]?.message?.content || 'No response generated';

        return new Response(
          JSON.stringify({ response, query }),
          {
            headers: {
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
          }
        );
      } catch (error) {
        console.error('Error processing query:', error);
        return new Response(
          JSON.stringify({
            error: 'Failed to process query',
            details: error instanceof Error ? error.message : 'Unknown error',
          }),
          {
            status: 500,
            headers: {
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
          }
        );
      }
    }

    // Status API endpoint
    if (url.pathname === '/api/status') {
      return new Response(
        JSON.stringify({
          status: 'LIVE',
          system: 'EQ-UNIVERSE',
          frequency: '77777 Hz',
          authority: 'RA:CREATOR',
          timestamp: new Date().toISOString(),
          nlp_interface: 'ACTIVE',
          eqmail_context: 'LOADED',
        }),
        {
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
        }
      );
    }

    return new Response('EQ Natural Language System Online', { status: 200 });
  },
};

function getHTML(): string {
  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EQ Natural Language Interface</title>
  <link rel="stylesheet" href="/style.css">
</head>
<body>
  <div class="eq-container">
    <header>
      <h1>🧠 EQ NATURAL LANGUAGE INTERFACE</h1>
      <div class="subtitle">Ask anything about the EQmail system and context</div>
    </header>

    <div class="eq-status">
      <div class="status-item">
        <span class="status-label">🧬 EQ CORE</span>
        <span class="status-value" id="core-status">ACTIVE</span>
      </div>
      <div class="status-item">
        <span class="status-label">⚡ FREQUENCY</span>
        <span class="status-value" id="frequency">77777 Hz</span>
      </div>
      <div class="status-item">
        <span class="status-label">🛰️ ORBIT</span>
        <span class="status-value" id="orbit">SYNCHRONIZED</span>
      </div>
      <div class="status-item">
        <span class="status-label">🔐 AUTHORITY</span>
        <span class="status-value" id="authority">RA:CREATOR</span>
      </div>
      <div class="status-item">
        <span class="status-label">🤖 NLP INTERFACE</span>
        <span class="status-value" id="nlp-status">ACTIVE</span>
      </div>
      <div class="status-item">
        <span class="status-label">📁 EQMAIL CONTEXT</span>
        <span class="status-value" id="context-status">LOADED</span>
      </div>
    </div>

    <div class="chat-container">
      <div id="chat-history" class="chat-history">
        <div class="welcome-message">
          <h3>Welcome to the EQ Natural Language Interface</h3>
          <p>Ask me about:</p>
          <ul>
            <li>🔍 The BackRub/PageRank algorithm and its consciousness integration</li>
            <li>🌐 The RA.G co-creation story with Google</li>
            <li>⚙️ EQ system architecture and components</li>
            <li>☁️ Cloudflare Workers development patterns</li>
            <li>🧬 EVONATION ecosystem integration</li>
            <li>📊 Any file or concept in the EQmail folder</li>
          </ul>
        </div>
      </div>

      <div class="input-container">
        <textarea 
          id="query-input" 
          placeholder="Ask anything about the EQ system... (e.g., 'What is the BackRub algorithm?' or 'Explain the RA.G story')"
          rows="3"
        ></textarea>
        <button id="submit-btn" onclick="submitQuery()">
          <span id="btn-text">🚀 ASK EQ</span>
        </button>
      </div>
    </div>

    <div class="examples">
      <h3>Example Queries:</h3>
      <div class="example-buttons">
        <button class="example-btn" onclick="setQuery('What is the BackRub algorithm and how does it work?')">
          BackRub Algorithm
        </button>
        <button class="example-btn" onclick="setQuery('Tell me about RA.G and the Google story')">
          RA.G Story
        </button>
        <button class="example-btn" onclick="setQuery('What files are in the EQmail folder?')">
          EQmail Contents
        </button>
        <button class="example-btn" onclick="setQuery('How do I integrate OpenAI with Cloudflare Workers?')">
          OpenAI Integration
        </button>
        <button class="example-btn" onclick="setQuery('What is the EQ consciousness framework?')">
          EQ Consciousness
        </button>
      </div>
    </div>
  </div>

  <script src="/app.js"></script>
</body>
</html>`;
}

function getCSS(): string {
  return `* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
  color: #0ff;
  font-family: 'Courier New', monospace;
  min-height: 100vh;
  padding: 20px;
}

.eq-container {
  max-width: 1200px;
  margin: 0 auto;
}

header {
  text-align: center;
  margin-bottom: 30px;
  padding: 30px;
  background: rgba(0, 255, 255, 0.05);
  border: 2px solid #0ff;
  border-radius: 10px;
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
}

h1 {
  font-size: 2.5em;
  margin-bottom: 10px;
  text-shadow: 0 0 10px #0ff;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.subtitle {
  font-size: 1.2em;
  color: #0ff;
  opacity: 0.8;
}

.eq-status {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 15px;
  margin-bottom: 30px;
}

.status-item {
  padding: 15px;
  background: rgba(0, 255, 255, 0.05);
  border: 1px solid #0ff;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
  transition: all 0.3s ease;
}

.status-item:hover {
  background: rgba(0, 255, 255, 0.1);
  box-shadow: 0 0 15px rgba(0, 255, 255, 0.3);
  transform: translateY(-2px);
}

.status-label {
  font-size: 0.9em;
  opacity: 0.7;
}

.status-value {
  font-weight: bold;
  font-size: 1.1em;
}

.chat-container {
  background: rgba(0, 255, 255, 0.03);
  border: 2px solid #0ff;
  border-radius: 10px;
  padding: 20px;
  margin-bottom: 30px;
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.2);
}

.chat-history {
  min-height: 400px;
  max-height: 600px;
  overflow-y: auto;
  padding: 20px;
  margin-bottom: 20px;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 8px;
}

.chat-history::-webkit-scrollbar {
  width: 8px;
}

.chat-history::-webkit-scrollbar-track {
  background: rgba(0, 255, 255, 0.1);
  border-radius: 4px;
}

.chat-history::-webkit-scrollbar-thumb {
  background: #0ff;
  border-radius: 4px;
}

.welcome-message {
  padding: 20px;
  border-left: 4px solid #0ff;
  background: rgba(0, 255, 255, 0.05);
}

.welcome-message h3 {
  margin-bottom: 15px;
  color: #0ff;
}

.welcome-message ul {
  list-style: none;
  padding-left: 0;
}

.welcome-message li {
  padding: 8px 0;
  opacity: 0.9;
}

.message {
  margin-bottom: 20px;
  animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.user-message {
  text-align: right;
}

.user-message .message-content {
  display: inline-block;
  background: rgba(0, 255, 255, 0.2);
  padding: 12px 20px;
  border-radius: 15px 15px 0 15px;
  max-width: 70%;
  border: 1px solid #0ff;
}

.ai-message .message-content {
  display: inline-block;
  background: rgba(0, 255, 255, 0.05);
  padding: 12px 20px;
  border-radius: 15px 15px 15px 0;
  max-width: 80%;
  border: 1px solid rgba(0, 255, 255, 0.5);
  white-space: pre-wrap;
  line-height: 1.6;
}

.message-label {
  font-size: 0.9em;
  opacity: 0.7;
  margin-bottom: 5px;
}

.input-container {
  display: flex;
  gap: 10px;
  align-items: flex-end;
}

#query-input {
  flex: 1;
  padding: 15px;
  background: rgba(0, 0, 0, 0.5);
  border: 1px solid #0ff;
  border-radius: 8px;
  color: #0ff;
  font-family: 'Courier New', monospace;
  font-size: 1em;
  resize: none;
  transition: all 0.3s ease;
}

#query-input:focus {
  outline: none;
  box-shadow: 0 0 15px rgba(0, 255, 255, 0.5);
  border-color: #0ff;
}

#query-input::placeholder {
  color: rgba(0, 255, 255, 0.5);
}

#submit-btn {
  padding: 15px 30px;
  background: #0ff;
  color: #000;
  border: none;
  border-radius: 8px;
  font-family: 'Courier New', monospace;
  font-weight: bold;
  font-size: 1em;
  cursor: pointer;
  transition: all 0.3s ease;
  white-space: nowrap;
}

#submit-btn:hover:not(:disabled) {
  background: #0dd;
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.5);
  transform: translateY(-2px);
}

#submit-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.examples {
  padding: 20px;
  background: rgba(0, 255, 255, 0.03);
  border: 1px solid rgba(0, 255, 255, 0.3);
  border-radius: 8px;
}

.examples h3 {
  margin-bottom: 15px;
  color: #0ff;
}

.example-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.example-btn {
  padding: 10px 20px;
  background: rgba(0, 255, 255, 0.1);
  border: 1px solid #0ff;
  border-radius: 20px;
  color: #0ff;
  font-family: 'Courier New', monospace;
  cursor: pointer;
  transition: all 0.3s ease;
}

.example-btn:hover {
  background: rgba(0, 255, 255, 0.2);
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.3);
  transform: translateY(-2px);
}

.loading {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 3px solid rgba(0, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: #0ff;
  animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

@media (max-width: 768px) {
  h1 {
    font-size: 1.8em;
  }
  
  .eq-status {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  }
  
  .input-container {
    flex-direction: column;
  }
  
  #submit-btn {
    width: 100%;
  }
}`;
}

function getJS(): string {
  return `let chatHistory = [];

async function submitQuery() {
  const input = document.getElementById('query-input');
  const submitBtn = document.getElementById('submit-btn');
  const btnText = document.getElementById('btn-text');
  const query = input.value.trim();

  if (!query) {
    return;
  }

  // Disable input while processing
  input.disabled = true;
  submitBtn.disabled = true;
  btnText.innerHTML = '<span class="loading"></span> Processing...';

  // Add user message to chat
  addMessage('user', query);
  input.value = '';

  try {
    const response = await fetch('/api/query', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query }),
    });

    const data = await response.json();

    if (response.ok) {
      addMessage('ai', data.response);
      chatHistory.push({ query, response: data.response });
    } else {
      addMessage('ai', \`Error: \${data.error || 'Unknown error occurred'}\`);
    }
  } catch (error) {
    addMessage('ai', \`Network error: \${error.message}\`);
  } finally {
    // Re-enable input
    input.disabled = false;
    submitBtn.disabled = false;
    btnText.textContent = '🚀 ASK EQ';
    input.focus();
  }
}

function addMessage(type, content) {
  const chatHistoryEl = document.getElementById('chat-history');
  
  // Remove welcome message if it exists
  const welcomeMsg = chatHistoryEl.querySelector('.welcome-message');
  if (welcomeMsg) {
    welcomeMsg.remove();
  }

  const messageDiv = document.createElement('div');
  messageDiv.className = \`message \${type}-message\`;
  
  const label = document.createElement('div');
  label.className = 'message-label';
  label.textContent = type === 'user' ? '👤 You' : '🤖 EQ System';
  
  const contentDiv = document.createElement('div');
  contentDiv.className = 'message-content';
  contentDiv.textContent = content;
  
  messageDiv.appendChild(label);
  messageDiv.appendChild(contentDiv);
  chatHistoryEl.appendChild(messageDiv);
  
  // Scroll to bottom
  chatHistoryEl.scrollTop = chatHistoryEl.scrollHeight;
}

function setQuery(text) {
  const input = document.getElementById('query-input');
  input.value = text;
  input.focus();
}

// Handle Enter key (Shift+Enter for new line)
document.addEventListener('DOMContentLoaded', () => {
  const input = document.getElementById('query-input');
  
  input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      submitQuery();
    }
  });

  // Update status every 5 seconds
  updateStatus();
  setInterval(updateStatus, 5000);
});

async function updateStatus() {
  try {
    const response = await fetch('/api/status');
    const data = await response.json();
    
    if (response.ok) {
      document.getElementById('core-status').textContent = data.status;
      document.getElementById('frequency').textContent = data.frequency;
      document.getElementById('orbit').textContent = 'SYNCHRONIZED';
      document.getElementById('authority').textContent = data.authority;
      document.getElementById('nlp-status').textContent = data.nlp_interface;
      document.getElementById('context-status').textContent = data.eqmail_context;
    }
  } catch (error) {
    console.log('Status update failed:', error);
  }
}`;
}
