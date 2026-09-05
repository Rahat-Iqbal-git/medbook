#!/usr/bin/env bash

set -euo pipefail

readonly project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_root"

run_check() {
  local label="$1"
  shift

  printf '\n==> %s\n' "$label"
  "$@"
}

run_check "Install dependencies" flutter pub get
run_check "Check formatting" dart format --output=none --set-exit-if-changed lib test
run_check "Analyze" flutter analyze lib test
run_check "Bloc lint" dart run bloc_tools:bloc lint .
run_check \
  "Run tests with coverage" \
  very_good test \
  -j 4 \
  --optimization \
  --coverage \
  --min-coverage 80 \
  --report-on lib \
  --collect-coverage-from imports \
  --show-uncovered \
  --test-randomize-ordering-seed random

printf '\nAll local CI checks passed.\n'
