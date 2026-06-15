#!/usr/bin/env bash
# Linux: compile the example runner and open a shell with it on PATH.
#
# The example entry files start with a shebang line:
#
#     #!/usr/bin/env run_example
#
# For that to work, a real `run_example` binary has to be discoverable on PATH —
# exactly how `tom_d4rt_dcli` ships a compiled `dcli` that executes a script
# passed as its argument. This script builds that binary and drops you into a
# shell where it is on PATH, so you can run an example file directly:
#
#     ./she_bang_linux.sh
#     # ...then, inside the spawned shell:
#     cd example/calculator
#     ./main.dart                  # runs the demo
#     ./main.dart "(2 + 3) * 4"    # evaluates one expression
#
set -euo pipefail
cd "$(dirname "$0")"
root="$PWD"

if [ ! -d .dart_tool ]; then
  echo "Fetching dependencies (first run)..." >&2
  dart pub get
fi

echo "Compiling bin/run_example ..." >&2
dart compile exe bin/run_example.dart -o bin/run_example

export PATH="$root/bin:$PATH"

cat <<'MSG'

  ┌──────────────────────────────────────────────────────────────────┐
  │  run_example is now on PATH in this shell.                         │
  │                                                                    │
  │  Go to an example folder and run its main.dart directly — the      │
  │  shebang line  #!/usr/bin/env run_example  makes it executable:    │
  │                                                                    │
  │      cd example/calculator                                         │
  │      ./main.dart                  # runs the demo                  │
  │      ./main.dart "(2 + 3) * 4"    # evaluates one expression       │
  │                                                                    │
  │  Type 'exit' to leave this shell.                                  │
  └──────────────────────────────────────────────────────────────────┘

MSG

# Open the user's login shell (bash by default on most Linux distros) so it
# behaves like a normal terminal. PATH was exported above, so run_example is
# visible inside it.
exec "${SHELL:-/bin/bash}"
