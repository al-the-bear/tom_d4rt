#!/usr/bin/env bash
# The repo-wide guards of THIS package, and nothing else.
#
#     ./test/run_guard_tests.sh
#
# A repo-wide guard asserts something about code it does not live beside:
# pubspecs and locks across the repository, formatting of both mirrored trees,
# stdlib twin identity, release hygiene, the doc/ vs testlog/ split. Those are
# the checks a session wants before a commit, and before this script they were
# reachable only through the whole suite or a hand-typed file list.
#
# FILES ARE SELECTED BY THE BANNER, not listed. Every such test opens with a
# `// REPO-WIDE GUARD (<package>)` line within its first twelve lines — the
# same window `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` checks —
# so a guard added tomorrow is run tomorrow without an edit here, and a list
# cannot go stale because there is none.
#
# Measured 2026-09-25: tom_d4rt 30 files / 205 checks in ~24 s against ~67 s
# for its whole suite; tom_d4rt_ast 7 files / 42 checks in ~14 s, where the
# whole suite is itself only ~12 s. The script is worth having in both anyway:
# it is a NAME the verification protocol and a failure message can point at,
# which a pipeline typed by hand is not.
#
# This file is identical in tom_d4rt and tom_d4rt_ast; nothing in it names a
# package. There is deliberately no .ps1 twin until the Flutter twins' Windows
# runners have been verified on a Windows host (sce172).

set -uo pipefail
cd "$(dirname "$0")/.."

files=()
while IFS= read -r f; do
  if head -n 12 "$f" | grep -q '^// REPO-WIDE GUARD ('; then
    files+=("$f")
  fi
done < <(find test -name '*_test.dart' -not -path '*/.dart_tool/*' | sort)

package=$(basename "$PWD")
if [ "${#files[@]}" -eq 0 ]; then
  # An empty selection must not read as a pass: it means the banner convention
  # or this script's reading of it changed, not that nothing needs checking.
  echo "no REPO-WIDE GUARD file found under $package/test — nothing was checked" >&2
  exit 1
fi

echo "== $package: ${#files[@]} repo-wide guard file(s)"
out=$(dart test "${files[@]}" 2>&1)
status=$?

# The quest's reading rule: read pass / skip / fail, all three. A rising skip
# count is a regression even when nothing fails.
last=$(printf '%s\n' "$out" | grep -E '^[0-9]+:[0-9]+ \+[0-9]+' | tail -n 1)
pass=$(printf '%s' "$last" | sed -nE 's/^[0-9:]+ \+([0-9]+).*/\1/p')
skip=$(printf '%s' "$last" | sed -nE 's/^[0-9:]+ \+[0-9]+ ~([0-9]+).*/\1/p')
fail=$(printf '%s' "$last" | sed -nE 's/^[0-9:]+ \+[0-9]+( ~[0-9]+)? -([0-9]+).*/\2/p')

if [ "$status" -ne 0 ]; then
  echo "failing:"
  printf '%s\n' "$out" | grep -E '\[E\]$' | sed -E 's/^[0-9:]+ \+[0-9]+( ~[0-9]+)? -[0-9]+: /  /' | sort -u
fi
echo "pass / skip / fail: ${pass:-0} / ${skip:-0} / ${fail:-0}"
exit "$status"
