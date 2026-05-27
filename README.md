# gstack-ag

**This project is a plugin for Antigravity of GStack.** 

It brings over 50 GStack slash commands directly into your Antigravity agent workflow. This plugin injects an entire suite of tools covering product strategy, design consultation, QA, system health checks, context management, and deployment.

---

## ⚠️ Important Note on Command Names

You will notice that the skills in this repository are named with a `gstack-` prefix (e.g., `gstack-office-hours`). However, **Antigravity strips prefixes or registers the internal command name rather than the folder name.** 

This means that if a folder is named `gstack-office-hours`, the runtime will expose it simply as `/office-hours`. This is an Antigravity runtime behavior, so when you use these commands in the chat interface, you often drop the `gstack-` prefix.

## Extensive List of Skills (Slash Commands)

This plugin registers the following 52 slash commands (internal names exposed by Antigravity) to use within your agent:

### Core & Context Management
- `/gstack`
- `/context-restore`
- `/context-save`
- `/sync-gbrain`
- `/setup-gbrain`
- `/pair-agent`

### Planning & Spec
- `/autoplan`
- `/spec`
- `/plan-ceo-review`
- `/plan-design-review`
- `/plan-devex-review`
- `/plan-eng-review`
- `/plan-tune`

### Review & Health
- `/review`
- `/design-review`
- `/devex-review`
- `/health`
- `/cso`
- `/careful`

### UI/UX, Design & Browser
- `/design-consultation`
- `/design-html`
- `/design-shotgun`
- `/browse`
- `/open-gstack-browser`
- `/setup-browser-cookies`
- `/scrape`

### QA & Testing
- `/qa`
- `/qa-only`
- `/ios-qa`

### iOS Development
- `/ios-clean`
- `/ios-design-review`
- `/ios-fix`
- `/ios-sync`

### Release & Deploy
- `/ship`
- `/setup-deploy`
- `/land-and-deploy`
- `/document-release`
- `/landing-report`
- `/canary`

### Utilities & Other
- `/office-hours`
- `/investigate`
- `/document-generate`
- `/make-pdf`
- `/learn`
- `/benchmark`
- `/benchmark-models`
- `/freeze`
- `/unfreeze`
- `/guard`
- `/retro`
- `/skillify`
- `/upgrade`

*(Note: Depending on how Antigravity registers them, some commands may still require the `gstack-` prefix. Check your Antigravity slash commands menu after installation).*

---

## Installation Guide

The plugin needs to be installed in your Antigravity plugins directory: `~/.gemini/config/plugins/gstack-ag/`.

### macOS / Linux

For Unix-based systems, installation is straightforward since the filesystem is unified.

**One-Line Install:**
```bash
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash
```

### Windows

**⚠️ CRITICAL WARNING FOR WINDOWS USERS: The Filesystem Split**

If you run the `curl ... | bash` command inside a Unix-like shell on Windows (such as **Git Bash, WSL, MSYS2, or MinGW**), you are likely to experience a "successful" installation where the commands do not actually appear in Antigravity.

**Why this happens:**
You have TWO separate environments on your machine:
1. **Windows World**: Your actual Antigravity app runs natively in Windows and looks for plugins at `C:\Users\<YourUser>\.gemini\config\plugins`.
2. **Linux/Git-Bash World**: When you run the install script inside a Linux-like shell, the shell expands `~/.gemini/config/plugins` to its internal virtual environment (e.g., `/home/<YourUser>/.gemini/config/plugins`).

Your installer writes into the Linux world, but your Antigravity app reads from the Windows world. The plugin successfully installs, but into a folder Antigravity cannot see.

**The Fix: Manual Clone via Windows CMD / PowerShell**

To guarantee the plugin is installed in the native Windows path where Antigravity expects it, **avoid the curl script**. Instead, manually clone the repository directly using the standard Windows Command Prompt (CMD) or PowerShell:

```cmd
cd %USERPROFILE%\.gemini\config\plugins
git clone https://github.com/Ravi8043/gstack-ag.git
```

This ensures the repository is cloned natively into `C:\Users\<YourUser>\.gemini\config\plugins\gstack-ag`, aligning the filesystem paths perfectly.

---

## Agent Workflows & Personas

Under the hood, these commands map to specific Antigravity workflow profiles. The plugin includes several pre-configured agent personas found in the `workflows/` directory:

- **`ceo_planner.json`**: Blunt YC partner who kills scope creep. (Used for planning/office hours)
- **`lead_eng.json`**: Battle-scarred principal engineer with 15 years on-call experience. (Used for deep code reviews)
- **`qa_bot.json`**: Adversarial QA lead who breaks everything. (Used for extensive QA testing)
- **`release_mgr.json`**: Methodical delivery engineer who blocks bad releases. (Used for shipping)

When a command is triggered, Antigravity spins up a subagent with the appropriate persona and context.

---

## Updating

If you installed via `git clone`:

```bash
# On macOS/Linux:
cd ~/.gemini/config/plugins/gstack-ag
git pull

# On Windows (CMD/PowerShell):
cd %USERPROFILE%\.gemini\config\plugins\gstack-ag
git pull
```

---

## Uninstalling

To uninstall, simply delete the plugin directory:

```bash
# On macOS/Linux:
rm -rf ~/.gemini/config/plugins/gstack-ag

# On Windows (PowerShell):
Remove-Item -Recurse -Force $HOME\.gemini\config\plugins\gstack-ag
```

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS | ✅ Fully supported |
| Linux | ✅ Fully supported |
| Windows | ✅ Supported (Manual `git clone` recommended over WSL/Git Bash) |

---

