# gstack-ag

**To be completely honest, this project is just a plugin for Antigravity of GStack.** 

It brings over 50 GStack slash commands directly into your Antigravity agent workflow. Rather than just being 4 opinionated skills, this plugin injects an entire suite of tools covering product strategy, design consultation, QA, system health checks, context management, and deployment.

---

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash
```

This installs gstack-ag as an Antigravity 2.0 plugin at `~/.gemini/config/plugins/gstack-ag/`.

### Requirements

- **git** — for cloning the repository
- **Antigravity 2.0** — the Gemini agent runtime

### Options

```bash
# Force reinstall (overwrites existing installation)
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash -s -- --force

# Uninstall
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash -s -- --uninstall
```

---

## Extensive List of Skills (Slash Commands)

This plugin registers the following 52 slash commands to use within Antigravity:

### Core & Context Management
- `/gstack`
- `/gstack-context-restore`
- `/gstack-context-save`
- `/gstack-sync-gbrain`
- `/gstack-setup-gbrain`
- `/gstack-pair-agent`

### Planning & Spec
- `/gstack-autoplan`
- `/gstack-spec`
- `/gstack-plan-ceo-review`
- `/gstack-plan-design-review`
- `/gstack-plan-devex-review`
- `/gstack-plan-eng-review`
- `/gstack-plan-tune`

### Review & Health
- `/gstack-review`
- `/gstack-design-review`
- `/gstack-devex-review`
- `/gstack-health`
- `/gstack-cso`
- `/gstack-careful`

### UI/UX, Design & Browser
- `/gstack-design-consultation`
- `/gstack-design-html`
- `/gstack-design-shotgun`
- `/gstack-browse`
- `/gstack-open-gstack-browser`
- `/gstack-setup-browser-cookies`
- `/gstack-scrape`

### QA & Testing
- `/gstack-qa`
- `/gstack-qa-only`
- `/gstack-ios-qa`

### iOS Development
- `/gstack-ios-clean`
- `/gstack-ios-design-review`
- `/gstack-ios-fix`
- `/gstack-ios-sync`

### Release & Deploy
- `/gstack-ship`
- `/gstack-setup-deploy`
- `/gstack-land-and-deploy`
- `/gstack-document-release`
- `/gstack-landing-report`
- `/gstack-canary`

### Utilities & Other
- `/gstack-office-hours`
- `/gstack-investigate`
- `/gstack-document-generate`
- `/gstack-make-pdf`
- `/gstack-learn`
- `/gstack-benchmark`
- `/gstack-benchmark-models`
- `/gstack-freeze`
- `/gstack-unfreeze`
- `/gstack-guard`
- `/gstack-retro`
- `/gstack-skillify`
- `/gstack-upgrade`

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

If you installed via git clone (the default):

```bash
cd ~/.gemini/config/plugins/gstack-ag
git pull
```

Or force reinstall:

```bash
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash -s -- --force
```

---

## Uninstalling

```bash
curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash -s -- --uninstall
```

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS | ✅ Fully supported |
| Linux | ✅ Fully supported |
| Windows (WSL/Git Bash) | ✅ Supported via MSYS/WSL path translation |

---

## License

MIT — see [LICENSE](LICENSE) for details.
