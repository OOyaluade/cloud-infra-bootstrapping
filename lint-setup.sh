#!/bin/bash

set -e

echo "?? Checking for Node.js and npm..."
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  echo "?? Node.js or npm not found. Installing them..."
  sudo apt update && sudo apt install -y nodejs npm
else
  echo "? Node.js and npm are already installed."
fi

echo "?? Initializing npm project..."
npm init -y

echo "?? Installing Commitlint and Husky..."
npm install --save-dev @commitlint/{cli,config-conventional} husky

echo "?? Creating commitlint config..."
echo "module.exports = { extends: ['@commitlint/config-conventional'] };" > commitlint.config.js

echo "?? Setting up Husky..."
npx husky install
npm pkg set scripts.prepare="husky install"

echo "?? Creating commit-msg hook..."
mkdir -p .husky
cat << 'EOF' > .husky/commit-msg
#!/bin/sh
. "$(dirname -- "$0")/_/husky.sh"
npx --no -- commitlint --edit "$1"
EOF
chmod +x .husky/commit-msg

# -----------------------------------
# ?? Add Python-based pre-commit setup
# -----------------------------------
echo "?? Checking for Python and pip..."
if ! command -v python3 &> /dev/null || ! command -v pip &> /dev/null; then
  echo "?? Python or pip not found. Installing..."
  sudo apt update && sudo apt install -y python3 python3-pip
else
  echo "? Python and pip are already installed."
fi

echo "?? Installing pre-commit..."
pip3 install --user pre-commit

echo "?? Creating .pre-commit-config.yaml..."
cat << 'EOF' > .pre-commit-config.yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.79.0
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_docs
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.32.2
    hooks:
      - id: markdownlint
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
EOF

echo "?? Installing pre-commit hooks..."
~/.local/bin/pre-commit install

echo "? All set! Conventional commits + Terraform/YAML/Markdown linting are now enforced."
