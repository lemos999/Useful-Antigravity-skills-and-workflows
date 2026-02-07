---
description: Telegram → IDE AI auto-response system - Complete installation and configuration guide
---

# Telegram Bridge Setup

Complete guide to set up automatic AI responses for Telegram messages using Antigravity IDE models.

---

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Prerequisites](#prerequisites)
3. [Phase 1: Proxy Installation](#phase-1-proxy-installation)
4. [Phase 2: OpenClaw Installation](#phase-2-openclaw-installation)
5. [Phase 3: Configuration](#phase-3-configuration)
6. [Phase 4: Gateway Startup](#phase-4-gateway-startup)
7. [Phase 5: Telegram Pairing](#phase-5-telegram-pairing)
8. [Daily Operations](#daily-operations)
9. [Troubleshooting](#troubleshooting)
10. [Reference Files](#reference-files)

---

## Architecture Overview

```
┌─────────────────┐     ┌─────────────────────────┐     ┌─────────────────────────┐
│   📱 Telegram   │────▶│  🦞 OpenClaw Gateway    │────▶│  🔌 antigravity-claude  │
│     Message     │     │      (port 18789)       │     │      -proxy (8080)      │
└─────────────────┘     └─────────────────────────┘     └─────────────────────────┘
                                                                    │
                                                                    ▼
┌─────────────────┐     ┌─────────────────────────┐     ┌─────────────────────────┐
│   📱 Telegram   │◀────│  🦞 OpenClaw Gateway    │◀────│  🤖 Antigravity IDE     │
│   Auto-Reply    │     │                         │     │  Models (Claude/Gemini) │
└─────────────────┘     └─────────────────────────┘     └─────────────────────────┘
```

**Components:**
| Component | Role | Port |
|-----------|------|------|
| antigravity-claude-proxy | Exposes IDE models as OpenAI-compatible API | 8080 |
| OpenClaw Gateway | Bridges Telegram to AI backend | 18789 |
| Antigravity IDE | Provides Claude/Gemini models | N/A |

---

## Prerequisites

### Automated Setup (Recommended)
You can automatically check and install all required tools by running the included script:

```powershell
powershell -ExecutionPolicy Bypass -File "Antisingularity\install\check_env.ps1"
```

This script will install:
- **Node.js** (LTS)
- **Git**
- **Python** (3.12 or higher)

### Manual Setup (If Script Fails)
- **Node.js** v18.0.0 or higher
- **Git** (for cloning repositories)
- **Python** v3.12 or higher (Check with `python --version`)
- **Antigravity IDE** running with logged-in account

### Required Credentials
- **Telegram Bot Token** from [@BotFather](https://t.me/BotFather)

### How to Get Telegram Bot Token
1. Open Telegram and search for `@BotFather`
2. Send `/newbot` command
3. Follow prompts to name your bot
4. Copy the API token (format: `1234567890:ABCdefGHIjklMNOpqrsTUVwxyz`)

---

## Phase 1: Proxy Installation

### Step 1.1: Clone Repository (Optional - for reference)
```powershell
git clone https://github.com/badrisnarayanan/antigravity-claude-proxy.git
```

### Step 1.2: Install Globally
// turbo
```powershell
npm install -g antigravity-claude-proxy@latest
```

### Step 1.3: Restore Credentials (Optional)
If you have backed up credentials in `Antisingularity\credentials\proxy-accounts.json`, restore them now:

```powershell
if (Test-Path "Antisingularity\credentials\proxy-accounts.json") {
    $Dest = "$env:USERPROFILE\.config\antigravity-proxy"
    New-Item -ItemType Directory -Path $Dest -Force | Out-Null
    Copy-Item "Antisingularity\credentials\proxy-accounts.json" "$Dest\accounts.json" -Force
    Write-Host "✅ Credentials restored."
} else {
    Write-Host "ℹ️  No credential backup found. Skipping restore."
}
```

### Step 1.4: Start Proxy Server
```powershell
antigravity-claude-proxy start
```

> ⚠️ **Keep this terminal window open** - closing it stops the proxy.

### Step 1.4: Verify Installation
1. Open browser: `http://localhost:8080`
2. Check **Dashboard** tab:
   - Total Accounts: 1+
   - Active: 1+
3. Check **Accounts** tab:
   - Status should show "Operational" (green)

### Step 1.5: Link Account (if not auto-detected)
1. Go to **Accounts** tab
2. Click **"Add Account"**
3. Select **"Connect Google Account"**
4. Complete OAuth flow
5. Verify account shows "Operational"

### Step 1.6: Verify Available Models
1. Go to **Models** tab
2. Confirm models are available:
   - `claude-sonnet-4-5` (green status)
   - `gemini-3-flash` (green status)
3. Note quota percentages (should be >0%)

---

## Phase 2: OpenClaw Installation

### Step 2.1: Install Globally
// turbo
```powershell
npm install -g openclaw@latest
```

### Step 2.2: Run Doctor (Directory Setup)
```powershell
openclaw doctor
```

**Interactive Prompts - Respond as follows:**

| Prompt | Response | Key |
|--------|----------|-----|
| "Generate and configure a gateway token now?" | Yes | `Enter` |
| "Create C:\Users\{USER}\.openclaw now?" | Yes | `y` + `Enter` |
| "Create Session store dir...?" | Yes | `Enter` |
| "Create OAuth dir...?" | Yes | `Enter` |
| "Enable zsh shell completion...?" | No | `n` + `Enter` |
| "Install gateway service now?" | No | `n` + `Enter` |

### Step 2.3: Run Onboard (Telegram Setup)
```powershell
openclaw onboard
```

**Interactive Prompts - Respond as follows:**

| Prompt | Response | Action |
|--------|----------|--------|
| "I understand this is powerful..." | Yes | `y` + `Enter` |
| "Onboarding mode" | QuickStart | `Enter` |
| "Model/auth provider" | Anthropic | Arrow keys to select, `Enter` |
| "Anthropic auth method" | Anthropic API key | `Enter` |
| "Enter Anthropic API key" | test | Type `test` + `Enter` |
| "Default model" | Keep current | `Enter` |
| "Select channel" | Telegram (Bot API) | `Enter` |
| "Enter Telegram bot token" | Your token | Paste token + `Enter` |
| "Configure skills now?" | No | `n` + `Enter` |
| "Enable zsh shell completion?" | No | `n` + `Enter` |

---

## Phase 3: Configuration

### Step 3.1: Locate Config File
```powershell
# Windows path
%USERPROFILE%\.openclaw\openclaw.json

# Or open with VS Code
code $env:USERPROFILE\.openclaw\openclaw.json
```

### Step 3.2: Complete Configuration Template

Replace entire file content with this template:

```json
{
  "messages": {
    "ackReactionScope": "group-mentions"
  },
  "models": {
    "mode": "merge",
    "providers": {
      "antigravity-proxy": {
        "baseUrl": "http://127.0.0.1:8080",
        "apiKey": "test",
        "api": "anthropic-messages",
        "models": [
          {
            "id": "claude-sonnet-4-5",
            "name": "Claude Sonnet 4.5 (Proxy)"
          },
          {
            "id": "gemini-3-flash",
            "name": "Gemini 3 Flash (Proxy)"
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "maxConcurrent": 4,
      "model": {
        "primary": "antigravity-proxy/claude-sonnet-4-5"
      },
      "subagents": {
        "maxConcurrent": 8
      },
      "compaction": {
        "mode": "safeguard"
      },
      "workspace": "C:\\Users\\YOUR_USERNAME\\.openclaw\\workspace"
    }
  },
  "gateway": {
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "YOUR_GATEWAY_TOKEN_FROM_ONBOARD"
    },
    "port": 18789,
    "bind": "loopback",
    "tailscale": {
      "mode": "off",
      "resetOnExit": false
    }
  },
  "auth": {
    "profiles": {
      "anthropic:default": {
        "provider": "anthropic",
        "mode": "api_key"
      }
    }
  },
  "plugins": {
    "entries": {
      "telegram": {
        "enabled": true
      }
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "botToken": "YOUR_TELEGRAM_BOT_TOKEN"
    }
  },
  "wizard": {
    "lastRunAt": "2026-02-07T00:00:00.000Z",
    "lastRunVersion": "2026.2.3-1",
    "lastRunCommand": "onboard",
    "lastRunMode": "local"
  },
  "meta": {
    "lastTouchedVersion": "2026.2.3-1",
    "lastTouchedAt": "2026-02-07T00:00:00.000Z"
  }
}
```

### Step 3.3: Required Replacements

| Placeholder | Replace With | Example |
|-------------|--------------|---------|
| `YOUR_USERNAME` | Windows username | `Lemos` |
| `YOUR_GATEWAY_TOKEN_FROM_ONBOARD` | Token from onboard step | `e42a75fc837363e7f82dc28b8edb855c3481fb616944e52d` |
| `YOUR_TELEGRAM_BOT_TOKEN` | BotFather token | `8413661068:AAFgjBh_B92QmdvH7WQvT701ubJHkFtllvw` |

### Step 3.4: Critical Configuration Notes

> ⚠️ **MUST USE `127.0.0.1`** - Do NOT use `localhost`!
> DNS resolution issues cause connection failures with `localhost`.

> ⚠️ **DO NOT ADD** these fields to models array (causes config errors):
> - `inputTypes`
> - `reasoning`
> - `contextWindow`

---

## Phase 4: Gateway Startup

### Step 4.1: Open New Terminal
Keep the proxy terminal open and open a **second** terminal.

### Step 4.2: Start Gateway
```powershell
openclaw gateway run
```

### Step 4.3: Verify Startup
Success logs should show:
```
🦞 OpenClaw 2026.x.x
[telegram] starting provider (@YOUR_BOT_NAME)
[telegram] autoSelectFamily=false
```

> ⚠️ **Keep this terminal window open** - closing it stops the gateway.

---

## Phase 5: Telegram Pairing

### Step 5.1: Initiate Pairing
1. Open Telegram
2. Find your bot (search `@YOUR_BOT_NAME`)
3. Send any message (e.g., "hello")

### Step 5.2: Receive Pairing Code
Bot will reply:
```
OpenClaw: access not configured.
Your Telegram user id: XXXXXXXXXX
Pairing code: XXXXXXXX
```

### Step 5.3: Approve Pairing
Run in terminal:
```powershell
openclaw pairing approve telegram <PAIRING_CODE>
```

Example:
```powershell
openclaw pairing approve telegram ZB6VNF6M
```

### Step 5.4: Verify Success
Send another message to your bot → Receive AI auto-response!

---

## Daily Operations

### Startup Sequence

**Terminal 1 - Proxy:**
```powershell
antigravity-claude-proxy start
```

**Terminal 2 - Gateway:**
```powershell
openclaw gateway run
```

### Shutdown Sequence
Press `Ctrl+C` in each terminal to gracefully stop.

### Quick Status Check
```powershell
# Check proxy status
curl http://localhost:8080/health

# Check channels
openclaw channels status
```

---

## Troubleshooting

### HTTP 401: invalid x-api-key
**Cause:** OpenClaw not using proxy provider
**Solution:** Verify `models.providers.antigravity-proxy` section exists in config

### Connection Refused
**Cause:** Proxy not running
**Solution:** Start proxy before gateway: `antigravity-claude-proxy start`

### Invalid Config Error
**Cause:** Invalid schema fields
**Solution:** Remove `inputTypes`, `reasoning`, `contextWindow` from models array

### Pairing Required Message
**Cause:** Telegram user not approved
**Solution:** Run `openclaw pairing approve telegram <CODE>`

### localhost Connection Fails
**Cause:** DNS resolution issue
**Solution:** Use `127.0.0.1` instead of `localhost` in config

### No Models Available in Proxy
**Cause:** Account not linked
**Solution:** 
1. Open `http://localhost:8080`
2. Go to Accounts → Add Account
3. Complete Google OAuth

---

## Reference Files

### Credentials Storage
```
Antisingularity/credentials/telegram-bridge.env
```

### Configuration File
```
%USERPROFILE%\.openclaw\openclaw.json
```

### Proxy Repository
```
Antisingularity/../antigravity-claude-proxy/
```

### Proxy Dashboard
```
http://localhost:8080
```

### Important Ports
| Service | Port |
|---------|------|
| Proxy Server | 8080 |
| Proxy Dashboard | 8080 |
| OpenClaw Gateway | 18789 |

---

## Quick Reference Card

```
┌────────────────────────────────────────────────────┐
│           TELEGRAM BRIDGE QUICK START              │
├────────────────────────────────────────────────────┤
│  1. antigravity-claude-proxy start     (Terminal 1)│
│  2. openclaw gateway run               (Terminal 2)│
│                                                    │
│  First-time only:                                  │
│  3. Send message to bot                            │
│  4. openclaw pairing approve telegram <CODE>       │
└────────────────────────────────────────────────────┘
```

---

## Backup & Restore

### Backing up Credentials
The proxy stores account connections (including OAuth tokens) in a JSON file.
Backup this file to save your logged-in accounts:

```powershell
Copy-Item -Path "$env:USERPROFILE\.config\antigravity-proxy\accounts.json" -Destination "Antisingularity\credentials\proxy-accounts.json"
```

### Restoring Credentials
To restore your accounts on a new machine or session:

```powershell
# Create config directory if it doesn't exist
New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\antigravity-proxy" -Force

# Restore file
Copy-Item -Path "Antisingularity\credentials\proxy-accounts.json" -Destination "$env:USERPROFILE\.config\antigravity-proxy\accounts.json" -Force
```
