#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(git rev-parse --show-toplevel)"

echo "?? Starting unified lint setup …"

############################
# 1) Node / npm / Commitlint
############################
if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
  echo "??  Installing Node LTS + npm (apt) …"
  sudo apt update && sudo apt -y install nodejs npm
fi

# Initialise npm only if package.json is absent
[[ -f "$REPO_ROOT/package.json" ]] || npm init -y

npm install --save-dev @commitlint/{cli,config-conventional} husky >/dev/null

cat > commitlint.config.js <<'CFG'
module.exports = { extends: ['@commitlint/config-conventional'] };
CFG

npx husky install
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit "$1"'

#########################################
# 2) Python virtualenv + pre-commit hooks
#########################################
if [[ ! -d "$REPO_ROOT/.venv" ]]; then
  echo "?? Creating Python venv …"
  python3 -m venv .venv
fi
source .venv/bin/activate
pip install --upgrade pip >/dev/null
pip install pre-commit >/dev/null

cat > .pre-commit-config.yaml <<'YAML'
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.79.0
    hooks: [ { id: terraform_fmt }, { id: terraform_validate }, { id: terraform_docs } ]
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.32.2
    hooks: [ { id: markdownlint } ]
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
YAML

pre-commit install

################################
# 3) One-time smoke-test commit
################################
if ! git rev-parse --verify -q lint-setup-test &>/dev/null; then
  echo "?? Running smoke-test commit …"
  git checkout -qb lint-setup-test
  echo "# Test file for linting setup" > lint-test.txt
  git add lint-test.txt
  if git commit -m "test: verify lint setup" ; then
    echo "? Commit passed hooks."
  else
    echo "? Commit failed hooks — check output above."
    exit 1
  fi
  # Clean up
  git checkout - &&
  git branch -D lint-setup-test &&
  rm lint-test.txt
fi

echo "?? All set! Conventional commits, Husky, and pre-commit Terraform/Markdown linters are live."
