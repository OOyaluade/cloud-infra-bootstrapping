#!/bin/bash

# One-click setup for commitlint + husky

echo "📦 Initializing npm project..."
npm init -y

echo "📥 Installing commitlint and husky..."
npm install --save-dev @commitlint/{cli,config-conventional} husky

echo "⚙️ Creating commitlint config..."
echo "module.exports = { extends: ['@commitlint/config-conventional'] };" > commitlint.config.js

echo "🚀 Setting up Husky..."
npx husky install
npm pkg set scripts.prepare="husky install"
mkdir -p .husky
echo '#!/bin/sh
. "$(dirname -- "$0")/_/husky.sh"
npx --no -- commitlint --edit "$1"' > .husky/commit-msg
chmod +x .husky/commit-msg

echo "✅ Setup complete. You now have commit message linting enforced!"