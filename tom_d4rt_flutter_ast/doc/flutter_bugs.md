# Flutter Test-Environment Issues Encountered in d4rt Demo Scripts

Catalogue of crashes / hangs that surfaced while running d4rt scripts
through the `tom_d4rt_flutterm_app` test app. Each entry distinguishes
the symptom, what triggers it, what does NOT trigger it, and the
recommended workaround for demo scripts. These are **Flutter / engine /
test-bundle limitations**, not d4rt interpreter bugs — the same widget
tree compiled natively into the same Linux test app would behave the
same way.

When you discover a new one, add a section here with the same shape.
The eventual goal is a "Demo-Script Authoring Guide" that bundles these
caveats up-front so authors can avoid the patterns.

---

## TextStyle pitfalls in the test app

### `fontFamily: 'monospace'` + multi-line text → native engine crash

**Symptom**
- Test app process dies mid-build: `Lost connection to device.` /
  `HttpException: Connection closed before full header was received`.
- Subsequent tests in the same `flutter test` invocation cascade-fail
  because the test app is gone.

**Trigger**
- A `Text(...)` whose `data` contains a `\n` (multi-line)
- AND `style: TextStyle(fontFamily: 'monospace', ...)` (or any other
  font name not bundled into the Linux test app's assets).
- The combination is required — either alone is fine.

**Confirmed in script**
- `widgets/directionality_test.dart` (3 occurrences, fixed by removing
  `fontFamily: 'monospace'`).

**Bisect log**

| Variant | Result |
|---|---|
| `Text('one\ntwo')` (no style) | PASS |
| `Text('one line two', style: TextStyle(fontFamily: 'monospace'))` | PASS |
| `Text('one\ntwo', style: TextStyle(fontFamily: 'Roboto'))` | PASS |
| **`Text('one\ntwo', style: TextStyle(fontFamily: 'monospace'))`** | **CRASH** |

**Root cause (likely)**
- The Linux test-app build does not bundle a `monospace` font.
- Single-line text falls back silently; multi-line layout hits the
  fallback path twice and the engine SIGABRTs in the line-breaker.

**Workaround**
- Drop `fontFamily: 'monospace'` from the `TextStyle` (the rest of the
  styling — size, height, weight — is fine).
- If the demo really needs monospaced look, bundle a real font (e.g.
  `RobotoMono`) in the test app's `pubspec.yaml` assets.

---

### `fontWeight: FontWeight.w800` (and other extreme weights) → crash

> **Status: needs reproduction.** Recorded from prior debugging where
> several scripts that styled text with `FontWeight.w400` ran fine but
> `FontWeight.w800` crashed. Re-bisect when the next affected script
> is hit and fill in the symptom / trigger / workaround sections with
> exact details and a minimal repro.

**Likely cause**
- Same family as the monospace bug: the test-app font bundle does not
  contain glyph variants at the requested weight. Some weights resolve
  to a fallback; others abort.

**Workaround pending verification**
- Stay at the standard weights actually shipped with the bundled fonts
  (`w400`, `w500`, `w700`).

---

## How to recognise a Flutter test-environment crash vs a d4rt bug

| Sign | Likely class |
|---|---|
| Test app log ends with `Lost connection to device.` or `HttpException: Connection closed` | Native crash in the test app (engine/font/layout). Try the script in a fresh `flutter run -d linux` outside `flutter test` — if it crashes there too, it's the engine. |
| `httpMs` huge (>30s) but `status=success` later | Slow render path (often setState / Ticker loop). Not a hard crash — interpreter or bridge issue. |
| `[BISECT v…] build()` printed but no further script output before crash | Crash happens AFTER the script's top-level `build()` returns and Flutter starts laying out — points at native widget rendering, not the interpreter. |
| Script never even prints `build()` started | Bundle-side crash (parsing, AST decode, or interpreter init). |

---

## Workflow when a script crashes the test app

1. Back up the script: `cp <script> /tmp/<name>.original`.
2. Replace with a minimal `MaterialApp + Scaffold + Text` to confirm
   the test app itself is healthy under that name.
3. Restore from backup, then bisect by removing top-level scenes /
   classes in halves until the smallest still-crashing version is
   isolated.
4. Inside the smallest reproducer, peel off one feature at a time
   (style attribute, child widget, callback, etc.) until the actual
   trigger is identified.
5. Add an entry here once the trigger and workaround are confirmed.
6. Apply the fix to the original script, restore everything else,
   re-run, and verify.
