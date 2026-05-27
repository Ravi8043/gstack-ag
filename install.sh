#!/usr/bin/env bash
# gstack-ag installer — installs GStack for Antigravity 2.0
# Usage: curl -fsSL https://raw.githubusercontent.com/Ravi8043/gstack-ag/main/install.sh | bash
set -e

# ─── Constants ────────────────────────────────────────────────
REPO_URL="https://github.com/Ravi8043/gstack-ag.git"
REPO_RAW="https://raw.githubusercontent.com/Ravi8043/gstack-ag/main"
PLUGIN_NAME="gstack-ag"
VERSION="1.0.0"

# ─── Color helpers (no-color safe) ────────────────────────────
if [ -t 1 ] && [ "${NO_COLOR:-}" = "" ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  MAGENTA='\033[0;35m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  DIM='\033[2m'
  RESET='\033[0m'
else
  RED='' GREEN='' YELLOW='' BLUE='' MAGENTA='' CYAN='' BOLD='' DIM='' RESET=''
fi

info()  { printf "${BLUE}▸${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}✓${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}⚠${RESET} %s\n" "$*" >&2; }
error() { printf "${RED}✗${RESET} %s\n" "$*" >&2; }
die()   { error "$*"; exit 1; }

# ─── OS Detection ─────────────────────────────────────────────
detect_os() {
  case "$(uname -s)" in
    Darwin*)          OS="macos" ;;
    Linux*)           OS="linux" ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
                      OS="windows-wsl" ;;
    *)                OS="unknown" ;;
  esac
}

# ─── Resolve plugin directory ─────────────────────────────────
resolve_plugin_dir() {
  # Antigravity 2.0 standard plugin directory
  if [ "$OS" = "windows-wsl" ]; then
    # WSL/MSYS: use Windows-style home if available, else fall back
    if [ -n "${USERPROFILE:-}" ]; then
      local win_home
      win_home="$(cygpath -u "$USERPROFILE" 2>/dev/null || echo "$HOME")"
      PLUGIN_DIR="$win_home/.gemini/config/plugins/$PLUGIN_NAME"
    else
      PLUGIN_DIR="$HOME/.gemini/config/plugins/$PLUGIN_NAME"
    fi
  else
    PLUGIN_DIR="$HOME/.gemini/config/plugins/$PLUGIN_NAME"
  fi
}

# ─── Parse flags ──────────────────────────────────────────────
FORCE=0
UNINSTALL=0
while [ $# -gt 0 ]; do
  case "$1" in
    --force)     FORCE=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    --help|-h)
      echo "gstack-ag installer v${VERSION}"
      echo ""
      echo "Usage:"
      echo "  curl -fsSL ${REPO_RAW}/install.sh | bash"
      echo "  bash install.sh [--force] [--uninstall]"
      echo ""
      echo "Options:"
      echo "  --force      Overwrite existing installation"
      echo "  --uninstall  Remove gstack-ag from your system"
      echo "  --help       Show this help message"
      exit 0
      ;;
    *) shift ;;
  esac
done

# ─── Banner ───────────────────────────────────────────────────
print_banner() {
  printf "\n"
  printf "${MAGENTA}${BOLD}"
  printf "   ██████╗ ███████╗████████╗ █████╗  ██████╗██╗  ██╗\n"
  printf "  ██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝\n"
  printf "  ██║  ███╗███████╗   ██║   ███████║██║     █████╔╝ \n"
  printf "  ██║   ██║╚════██║   ██║   ██╔══██║██║     ██╔═██╗ \n"
  printf "  ╚██████╔╝███████║   ██║   ██║  ██║╚██████╗██║  ██╗\n"
  printf "   ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝\n"
  printf "${RESET}"
  printf "${DIM}  for Antigravity 2.0 · v${VERSION}${RESET}\n"
  printf "\n"
}

# ─── Uninstall ────────────────────────────────────────────────
if [ "$UNINSTALL" -eq 1 ]; then
  detect_os
  resolve_plugin_dir
  print_banner
  if [ -d "$PLUGIN_DIR" ]; then
    info "Removing gstack-ag from $PLUGIN_DIR"
    rm -rf "$PLUGIN_DIR"
    ok "gstack-ag has been uninstalled"
    printf "\n  ${DIM}The following commands are no longer available:${RESET}\n"
    printf "  ${DIM}  /gstack-office-hours  /gstack-review  /gstack-qa  /gstack-ship ...${RESET}\n\n"
  else
    warn "gstack-ag is not installed at $PLUGIN_DIR"
  fi
  exit 0
fi

# ─── Pre-flight checks ───────────────────────────────────────
detect_os
resolve_plugin_dir
print_banner

info "Detected OS: ${BOLD}${OS}${RESET}"
info "Install target: ${BOLD}${PLUGIN_DIR}${RESET}"

# Check git
if ! command -v git >/dev/null 2>&1; then
  die "git is required but not installed. Install it from https://git-scm.com/"
fi
ok "git found: $(git --version | head -1)"

# ─── Handle existing installation ────────────────────────────
if [ -d "$PLUGIN_DIR" ]; then
  if [ "$FORCE" -eq 1 ]; then
    warn "Existing installation found — overwriting (--force)"
    rm -rf "$PLUGIN_DIR"
  else
    # Check if it's a git repo we can update
    if [ -d "$PLUGIN_DIR/.git" ]; then
      info "Existing installation found — updating via git pull"
      (cd "$PLUGIN_DIR" && git pull --ff-only origin main 2>/dev/null) && {
        ok "Updated to latest version"
        printf "\n"
        print_success
        exit 0
      } || {
        warn "git pull failed — use --force to reinstall"
        exit 1
      }
    else
      die "gstack-ag is already installed at $PLUGIN_DIR. Use --force to overwrite."
    fi
  fi
fi

# ─── Install ─────────────────────────────────────────────────
# Ensure parent directory exists
mkdir -p "$(dirname "$PLUGIN_DIR")"

info "Cloning gstack-ag repository..."
if git clone --depth 1 "$REPO_URL" "$PLUGIN_DIR" 2>/dev/null; then
  ok "Repository cloned successfully"
else
  # Fallback: if git clone fails (e.g., private repo), try archive download
  warn "git clone failed — trying archive download..."
  ARCHIVE_URL="https://github.com/Ravi8043/gstack-ag/archive/refs/heads/main.tar.gz"
  mkdir -p "$PLUGIN_DIR"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$ARCHIVE_URL" | tar -xz -C "$PLUGIN_DIR" --strip-components=1
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$ARCHIVE_URL" | tar -xz -C "$PLUGIN_DIR" --strip-components=1
  else
    die "Neither curl nor wget is available. Cannot download archive."
  fi
  ok "Archive downloaded and extracted"
fi

# ─── Validate installation ───────────────────────────────────
VALID=1
for f in plugin.json; do
  if [ ! -f "$PLUGIN_DIR/$f" ]; then
    error "Missing file: $f"
    VALID=0
  fi
done

if [ ! -d "$PLUGIN_DIR/skills" ]; then
  error "Missing directory: skills/"
  VALID=0
fi

if [ "$VALID" -eq 0 ]; then
  die "Installation validation failed — some files are missing"
fi
ok "All files validated"

# ─── Success ──────────────────────────────────────────────────
print_success() {
  printf "\n"
  printf "  ${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
  printf "  ${GREEN}${BOLD}  ✅  gstack-ag installed successfully!${RESET}\n"
  printf "  ${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
  printf "\n"
  printf "  ${BOLD}Available commands (40+ skills installed):${RESET}\n"
  printf "\n"
  printf "  ${CYAN}/gstack-office-hours${RESET}  ${DIM}─${RESET}  YC-partner product strategy session\n"
  printf "  ${CYAN}/gstack-review${RESET}       ${DIM}─${RESET}  Parallel code audit subagent\n"
  printf "  ${CYAN}/gstack-qa${RESET}           ${DIM}─${RESET}  Browser-based UI/UX flow testing\n"
  printf "  ${CYAN}/gstack-ship${RESET}         ${DIM}─${RESET}  Pre-deploy checks + changelog generation\n"
  printf "  ${CYAN}... and many more!${RESET}\n"
  printf "\n"
  printf "  ${DIM}Installed to: ${PLUGIN_DIR}${RESET}\n"
  printf "  ${DIM}Update:       cd ${PLUGIN_DIR} && git pull${RESET}\n"
  printf "  ${DIM}Uninstall:    bash install.sh --uninstall${RESET}\n"
  printf "\n"
}

print_success
