#!/usr/bin/env bash
#
# idle_timeout.sh — run a command with an IDLE-OUTPUT watchdog.
#
# Why: the D4rt Flutter corpus drives a long-lived companion app over a local
# HTTP server. When that transport wedges, `flutter test` can sit in silence
# for the full per-file backstop (timeout 900) — and sometimes it never even
# reaches the first test. The per-test `--timeout 70s` doesn't help when no
# test is running yet. This watchdog watches the *output* itself: if the
# command produces NO new output for IDLE seconds, the whole run is killed so
# the file fails fast instead of burning the wall-clock backstop.
#
# IDLE defaults to 70s — above the ~55s build-timeout max-silence — so a single
# slow-but-progressing test is never killed, but a true stall (or a cold hang
# before the first test) is caught quickly.
#
# Usage:
#   idle_timeout.sh <idle_seconds> <logfile> -- <command> [args...]
#
# Behaviour:
#   - Streams the command's merged stdout+stderr to <logfile> AND mirrors it
#     live to this script's stdout (tee-like).
#   - The command runs in its own process group (set -m); on an idle stall the
#     ENTIRE group is signalled (SIGTERM, then SIGKILL) so `flutter test` and
#     any child it spawned are torn down together — no orphaned wedge.
#   - Exit code: the command's own exit code on normal completion; 124 (the
#     GNU `timeout` convention) when the watchdog killed it for going idle.
#
# Stall detection is based on the logfile's modification time, polled every
# few seconds. This is intentionally fd-agnostic: it does not rely on pipe EOF,
# which a lingering child holding the output fd open could withhold forever.
set -uo pipefail

if [ "$#" -lt 3 ]; then
  echo "usage: idle_timeout.sh <idle_seconds> <logfile> -- <command...>" >&2
  exit 2
fi

idle="$1"; shift
logfile="$1"; shift
if [ "$1" = "--" ]; then shift; fi
if [ "$#" -lt 1 ]; then
  echo "idle_timeout.sh: no command given" >&2
  exit 2
fi

# Poll cadence: how often we re-check the logfile mtime. Small enough to react
# promptly, large enough to be negligible overhead. Worst-case kill latency is
# idle + POLL seconds.
POLL="${IDLE_POLL:-5}"

# Portable "seconds since epoch of file mtime": BSD/macOS `stat -f %m`,
# GNU/Linux `stat -c %Y`. Falls back to now (treats unreadable file as fresh).
_mtime() {
  stat -f %m "$1" 2>/dev/null || stat -c %Y "$1" 2>/dev/null || date +%s
}

# Create/truncate the logfile up front so both the command (append) and the
# live mirror (tail) have a file to attach to with no race.
: > "$logfile"

# Job control: each background job becomes its own process group, so a negative
# PID (-pgid) signals the whole tree, not just the leader.
set -m

# Run the command, merging stderr into stdout, appending to the logfile.
"$@" >> "$logfile" 2>&1 &
cmd_pid=$!

# Live console mirror. -n +1 so we stream from the very first byte.
tail -n +1 -f "$logfile" 2>/dev/null &
tail_pid=$!

idle_killed=""

_kill_group() {
  # SIGTERM the group, give it up to ~5s to unwind, then SIGKILL.
  kill -TERM -- "-${cmd_pid}" 2>/dev/null
  local n=0
  while [ "$n" -lt 10 ]; do
    kill -0 "$cmd_pid" 2>/dev/null || return
    sleep 0.5
    n=$((n + 1))
  done
  kill -KILL -- "-${cmd_pid}" 2>/dev/null
}

# Watchdog loop: while the command is alive, kill it if the logfile has not
# changed for `idle` seconds.
while kill -0 "$cmd_pid" 2>/dev/null; do
  sleep "$POLL"
  now="$(date +%s)"
  mt="$(_mtime "$logfile")"
  if [ "$((now - mt))" -ge "$idle" ]; then
    # Log-only: the live `tail -f` mirror echoes it to the console once.
    printf '== idle_timeout: no output for >=%ss — killing test run (process group %s) ==\n' \
      "$idle" "$cmd_pid" >> "$logfile"
    idle_killed=1
    _kill_group
    break
  fi
done

# Harvest the command's exit code (returns immediately if already reaped/killed).
wait "$cmd_pid" 2>/dev/null
rc=$?

# Let the mirror flush the final lines, then stop it.
sleep 0.3
kill "$tail_pid" 2>/dev/null
wait "$tail_pid" 2>/dev/null

if [ -n "$idle_killed" ]; then
  rc=124
fi
exit "$rc"
