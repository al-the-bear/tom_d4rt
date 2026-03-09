# Known macOS Test Failures in tom_d4rt_dcli

**Date:** 2026-03-09
**Affects:** 14 tests (13 permissions, 1 directory operations)
**Status:** Not fixing — upstream DCli bug + macOS filesystem behavior

---

## Issue 1: DCli `isWritable` Returns `false` on macOS (13 tests)

**Affected file:** `test/permissions_test.dart` (13 tests marked `[fails on Macos]`)

### Root Cause: DCli `_whoami()` Bug

DCli's `_whoami()` function in `posix_shell.dart` incorrectly identifies the current user as `"root"` on macOS when running from the Dart VM.

**The buggy code** — `dcli-8.4.2/lib/src/shell/posix_shell.dart` lines 358–374:

```dart
String _whoami() {
  String? user;
  if (isPosixSupported) {
    try {
      user = getlogin();
    } on PosixException catch (e) {
      if (e.code == ENXIO) {
        // no controlling terminal so we must be root.  // <-- WRONG ASSUMPTION
        user = 'root';
      }
    }
  }

  /// fall back to whoami if nothing else works.
  user ??= 'whoami'.firstLine;
  verbose(() => 'whoami: $user');
  return user!;
}
```

**The bug:** When `getlogin()` throws `PosixException(ENXIO)`, DCli sets `user = 'root'` instead of leaving `user` as `null` and letting it fall through to the `'whoami'.firstLine` fallback. The correct fix would be:

```dart
// Just leave user = null so the whoami fallback runs
on PosixException catch (e) {
  if (e.code == ENXIO) {
    // no controlling terminal — fall through to whoami
  }
}
```

**Why `getlogin()` fails on macOS:** The Dart VM process does not have an associated utmp/utmpx login record. C's `getlogin()` relies on this record, which macOS only maintains for direct terminal sessions. This affects **all** Dart programs on macOS (not just `dart test`):

```
$ dart run my_script.dart
loggedInUser: root     # WRONG — should be "alexiskyaw"

$ whoami
alexiskyaw             # CORRECT — whoami uses different mechanism
```

**How this breaks permission checks** — `dcli-8.4.2/lib/src/functions/is.dart` lines 49–117:

```dart
bool _checkPermission(String path, int permissionBitMask) {
  final user = Shell.current.loggedInUser;  // Returns "root" on macOS
  // ...
  final stat0 = posix.stat(path);
  ownerName = posix.getUserNameByUID(stat0.uid);  // Returns "alexiskyaw"
  // ...
  } else if (owner) {
    if (user == ownerName) {  // "root" == "alexiskyaw" → false!
      access = true;
    }
  }
  return access;  // Returns false when it should be true
}
```

### Platform Behavior Comparison

| Platform | `loggedInUser` implementation | Works in Dart VM? |
|----------|------------------------------|-------------------|
| **Linux** | `getlogin()` via posix package | Yes — Linux keeps utmp records across process trees |
| **macOS** | `getlogin()` via posix package | **No** — ENXIO, falls to `'root'` instead of `whoami` fallback |
| **Windows** | `env['USERNAME']` | Yes — just reads the environment variable |

### Affected Tests

| # | Test Name | Group |
|---|-----------|-------|
| 1 | returns true for writable file | isWritable |
| 2 | returns true for writable directory | isWritable |
| 3 | can write to writable file | isWritable |
| 4 | makes file writable | chmod via shell |
| 5 | handles directory permissions | chmod via shell |
| 6 | mode 644 - rw-r--r-- | permission modes |
| 7 | mode 755 - rwxr-xr-x | permission modes |
| 8 | mode 600 - rw------- | permission modes |
| 9 | mode 700 - rwx------ | permission modes |
| 10 | hidden files are accessible | special permissions |
| 11 | symlink permissions follow target | special permissions |
| 12 | create config file with restricted permissions | real-world scenarios |
| 13 | check before writing | real-world scenarios |

---

## Issue 2: Case-Insensitive Filesystem on macOS (1 test)

**Affected file:** `test/directory_operations_test.dart` (1 test marked `[fails on Macos]`)

### Root Cause

The test creates two files `FILE.TXT` and `file.txt` in the same directory, then expects `find('*.txt', caseSensitive: false)` to return 2 results.

On macOS APFS (case-insensitive by default), `FILE.TXT` and `file.txt` are the **same file** — the second `touch()` overwrites the first. Only 1 file exists, so the find returns 1 instead of 2.

This is a test design issue specific to macOS — it works on Linux (ext4 is case-sensitive).

### Affected Test

| # | Test Name | Group |
|---|-----------|-------|
| 1 | case-insensitive matching when specified | find |

---

## Resolution

These failures are not fixed — they are annotated with `[fails on Macos]` in test descriptions so they can be identified and filtered. The upstream DCli bug should be reported/fixed in the `dcli` package.
