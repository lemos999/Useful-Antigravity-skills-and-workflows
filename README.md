# Antisingularity Resource Protocol

## github : https://github.com/lemos999

## ⚡ Global Priority Mandate

This project operates under the **Antisingularity Global Configuration**. 

### 🚨 CRITICAL RESOURCE RESOLUTION RULE
When resolving Workflows, Skills, or any Configuration files, you must **ALWAYS** prioritize the Global Paths over Local Paths.

**Resolution Order (Strict Compliance Required):**

1.  **🥇 GLOBAL (Primary)**
    *   `~/.gemini/antigravity/global_workflows/`
    *   `~/.gemini/antigravity/skills/`
    *   `~/.gemini/GEMINI.md`

2.  **🥈 ANTISINGULARITY (Secondary)**
    *   `./antisingularity/workflows/`
    *   `./antisingularity/skills/`

3.  **🥉 LOCAL (Fallback - Only if not found above)**
    *   `./.agent/workflows/`
    *   `./.agent/skills/`

### 🚫 FAILURE PREVENTION
Do not fail if a resource is missing locally. **IMMEDIATELY** check the Global Path. The absence of a local `.agent` folder is **NOT** an error; it indicates reliance on Global Configuration.
