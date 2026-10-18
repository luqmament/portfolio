#!/bin/sh
# ============================================================
# setup-hooks.sh — Install pre-commit hook for this repo
#
# Usage: sh setup-hooks.sh
# ============================================================

echo ""
echo "🔐 Setting up pre-commit security hooks..."

# Check if we're in a git repo
if [ ! -d .git ]; then
  echo "❌ Not in a git repository. Run this from the repo root."
  exit 1
fi

# Check if .githooks directory exists
if [ ! -d .githooks ]; then
  echo "❌ .githooks/ directory not found."
  exit 1
fi

# Configure git to use .githooks as the hooks directory
git config core.hooksPath .githooks

# Make the hook executable
chmod +x .githooks/pre-commit

echo ""
echo "✅ Pre-commit hook installed successfully!"
echo ""
echo "   Hook path: .githooks/pre-commit"
echo "   Config:    core.hooksPath = .githooks"
echo ""
echo "   The hook will run automatically before every commit"
echo "   and block commits containing:"
echo "   - Sensitive filenames (.env, .pem, .key, etc.)"
echo "   - GitHub tokens (ghp_...)"
echo "   - AWS access keys (AKIA...)"
echo "   - Hardcoded API keys and secrets"
echo ""
