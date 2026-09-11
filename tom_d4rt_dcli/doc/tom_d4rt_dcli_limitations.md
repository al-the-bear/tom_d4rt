# tom_d4rt_dcli — Limitations (delta)

> **Delta on the interpreter canon.** D4rt language- and interpreter-level
> limits are owned by the canonical
> [`tom_d4rt/doc/d4rt_limitations.md`](../../tom_d4rt/doc/d4rt_limitations.md)
> and are not repeated here. This file documents only the limitations
> **specific to the DCli REPL surface** — currently one upstream `dcli` bug,
> below. It stems from the `dcli` package, not from the D4rt interpreter.

**Affects:** `isWritable`, `isReadable` and `isExecutable` in scripts, and 13
tests in `test/permissions_test.dart`
**Status:** upstream `dcli` bug (<https://github.com/onepub-dev/dcli>), present
in 8.4.2 (used here) and 10.0.0; a fix has been prepared for upstream

---

## Issue 1: DCli permission checks use the session login name, not the process user

### What a script sees

In a process started outside a login session, `isWritable(path)` returns
`false` for a file the script itself just created, and `isReadable` /
`isExecutable` can be wrong the same way for any file whose "other" bits do not
grant the access. That covers the common ways of running dcli today:

- **macOS:** anything descended from an app launched from the Dock or by
  launchd — a terminal inside VS Code, an agent, a test runner. There the
  session's login name is `root`.
- **Linux, and macOS without a terminal:** CI jobs, cron, `ssh host 'dcli …'`.
  There `getlogin()` fails, and dcli takes that to mean `root`.

A login shell (Terminal.app, an interactive `ssh` session) is not affected.
`Shell.current.loggedInUser` shows which case you are in: it names the logged-in
user — `root` in the affected sessions — while `id -un` names the process user.

### Root cause

`_checkPermission` in `dcli/lib/src/functions/is.dart` falls back from the
"other" bits to the group and owner bits by comparing NAMES with
`Shell.current.loggedInUser`:

```dart
final user = Shell.current.loggedInUser;     // the session login name
// ...
} else if (owner) {
  if (user == ownerName) { access = true; }  // "root" == "alexiskyaw" -> false
}
```

`loggedInUser` comes from `getlogin()`, which reports who LOGGED IN, not who the
process IS. Measured on macOS in an affected session: `getlogin()` returned
`root` while `geteuid()` was 501 and named the actual user.

The fix is in the access check, not in `loggedInUser`: decide ownership and
group membership by the process's effective uid, gid and supplementary groups.
Measured against a 34-test permission suite in an affected session: dcli 8.4.2
and 10.0.0 unpatched pass 21 and fail 13; 10.0.0 with that change passes all
34. Changing only `_whoami()` to fall back to `whoami` on `ENXIO` does not help
on macOS, because there `getlogin()` does not fail — it answers `root`.

### How the tests handle it

The 13 owner-dependent tests in `test/permissions_test.dart` run through
`ownerTest`, which skips them — with the reason — exactly when
`Shell.current.loggedInUser` differs from `id -un`, the bug's precondition. In a
login shell they run, on any platform. A tripwire test asserts the bug is still
there whenever the skips are active, so an upgraded dcli that fixes it fails the
tripwire instead of leaving the tests skipped for nothing.

### Affected tests

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
