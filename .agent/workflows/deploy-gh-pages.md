---
description: Deploy a Vite project to GitHub Pages with automated authentication handling.
---

# GitHub Pages Deployment Workflow

This workflow guides you through deploying a static site (Vite/React/Vue/Vanilla) to GitHub Pages, covering configuration, repository creation, and authentication.

## 1. Project Configuration
**Effect**: Ensures assets load correctly on the deployed site.

1. Create/Update `vite.config.js`:
   ```javascript
   import { defineConfig } from 'vite';
   
   export default defineConfig({
     base: './', // Relative paths for assets
     build: {
       outDir: 'docs', // GitHub Pages loves the /docs folder
     }
   });
   ```

2. Update `.gitignore`:
   ```text
   node_modules
   .DS_Store
   .env
   dist
   ```
   *(Note: Do NOT ignore `docs` if using the /docs folder method)*

## 2. Build & Initialize Git
**Effect**: Prepares the production build and local repository.

// turbo
1. Run Build:
   ```bash
   npm run build
   ```

2. Initialize Git:
   ```bash
   git init
   git add .
   git commit -m "Prepare for deployment"
   ```

## 3. Create GitHub Repository
**Method A: Using GitHub CLI (Recommended)**
```bash
gh repo create my-project --public --source=. --remote=origin
```

**Method B: Browser (Manual)**
1. Go to `github.com/new`.
2. Name the repo.
3. Copy the HTTPS URL (e.g., `https://github.com/user/repo.git`).
4. Link it:
   ```bash
   git remote add origin https://github.com/user/repo.git
   ```

## 4. Authentication (If Prompted)
**Scenario**: If `git push` fails or hangs on authentication.

1. **Browser Auth**: If a popup appears, click "Sign in with your browser" -> "Authorize".
2. **Token Auth (Fallback)**:
   - Go to [GitHub Tokens](https://github.com/settings/tokens/new?scopes=repo).
   - Generate a token with `repo` scope.
   - Inject into remote URL:
     ```bash
     git remote set-url origin https://USER:TOKEN@github.com/USER/REPO.git
     ```

## 5. Deployment
**Effect**: Pushes code and sets live.

1. Push to GitHub:
   ```bash
   git branch -M main
   git push -u origin main --force
   ```

2. Configure Pages (Browser):
   - Go to Repo Settings -> **Pages**.
   - **Source**: Deploy from a branch.
   - **Branch**: `main` / `/docs` folder.
   - Click **Save**.

## 6. Verification
- Wait 1-2 minutes.
- Check the URL provided in the Pages settings (e.g., `https://user.github.io/repo/`).
