# Antisingularity (Useful Antigravity Skills & Workflows)

A collection of power-user workflows and skills for the Antigravity IDE, including the **Telegram Bridge** for connecting AI models to Telegram.

## 🚀 Quick Start (Installation)

1.  **Clone this repository**
    ```bash
    git clone https://github.com/lemos999/Useful-Antigravity-skills-and-workflows.git
    ```

2.  **Open the folder in Antigravity IDE**

3.  **Run the automated setup workflow**
    Type the following slash command in the chat:
    ```
    @/telegram-bridge
    ```

4.  **Follow the AI instructions**
    - The agent will check your environment (Python 3.12+, Node.js, Git) automatically.
    - It will guide you through installing `antigravity-claude-proxy` and `openclaw`.
    - It will help you pair your Telegram bot.

---

## 📂 Included Components

- **Workflows (`.agent/workflows`)**:
  - `telegram-bridge`: End-to-end setup guide for Telegram integration.
  - `go-build`, `code-review`: specialized dev workflows.
- **Skills (`.agent/skills`)**:
  - Specialized prompts for specific engineering tasks.
- **Install Scripts (`install/`)**:
  - `check_env.ps1`: Automated environment verification script.

## 🔗 References
- **Proxy**: [antigravity-claude-proxy](https://github.com/badrisnarayanan/antigravity-claude-proxy)
- **Gateway**: [openclaw](https://github.com/openclaw/openclaw)
