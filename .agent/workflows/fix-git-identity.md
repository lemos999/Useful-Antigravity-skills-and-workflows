---
description: Resolve 'Author identity unknown' errors by configuring Git user identity (Global/Local).
---

# Fix Git Identity ('Author identity unknown')

This workflow helps you resolve the error where Git refuses to commit because it doesn't know who you are.

## 1. Diagnosis
**Error Message**: 
> *** Please tell me who you are.
> Run ... to set your account's default identity.
> fatal: unable to auto-detect email address...

## 2. Solution A: Global Configuration (Recommended)
Sets the identity for **ALL** repositories on this machine. Use this if this is your personal computer.

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 3. Solution B: Local Configuration (Project Specific)
Sets the identity **ONLY** for the current repository. Use this for work projects or if you need a specific identity for a single repo.

1. Navigate to the project root.
2. Run:
   ```bash
   git config user.name "Project Specific Name"
   git config user.email "work@example.com"
   ```

## 4. Verification
Check if the settings are applied correctly:

```bash
# Check global settings
git config --global --list

# Check local settings (inside a repo)
git config --local --list
```
