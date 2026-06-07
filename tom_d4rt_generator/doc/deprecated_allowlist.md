# Per-symbol `@Deprecated` allowlist (A.5 / MCI#32)

By default the bridge generator **skips every `@Deprecated` element** so the
bridge surface stays aligned with the non-deprecated API
(`ElementModeExtractor.generateDeprecatedElements = false`). A script that
legitimately depends on a single deprecated SDK symbol therefore sees it as
"undefined" (OPEN issue **A.5**, limits entry **U12**). The historical escape
hatch was the all-or-nothing boolean `generateDeprecatedElements: true`, which
floods the bridge with *every* deprecated member of the module.

The **per-symbol allowlist** is the middle ground: opt **one** deprecated symbol
back in by simple name, leaving the rest excluded.

> **One-line summary:** add `deprecatedAllowlist: [SymbolName]` to a buildkit
> `ModuleConfig` to bridge that one deprecated symbol without flipping the whole
> module to `generateDeprecatedElements: true`. Empty (the default) ⇒ no change.

---

## The mechanism

### 1. The config knob — `ModuleConfig.deprecatedAllowlist`

A per-module `List<String>` of **simple symbol names**
(`bridge_config.dart`), default empty:

```yaml
modules:
  - name: material
    barrelImport: package:flutter/material.dart
    outputPath: lib/src/bridges/material_bridges.b.dart
    # Opt two deprecated symbols back in; everything else deprecated stays out.
    deprecatedAllowlist:
      - RaisedButton
      - FlatButton
```

The list round-trips through `ModuleConfig.fromJson` / `toJson` (the key is
omitted from JSON when empty, so existing configs serialize unchanged). It is
unioned into `PackageInfo` and threaded to
`BridgeGenerator.deprecatedAllowlist`.

### 2. The decision site — `ElementModeExtractor._isDeprecatedExcluded`

```dart
bool _isDeprecatedExcluded(Element element, String? name) {
  if (generateDeprecatedElements) return false;          // flag wins: include all
  if (!_hasDeprecatedAnnotation(element)) return false;  // not deprecated: keep
  if (name != null && deprecatedAllowlist.contains(name)) return false; // opted in
  return true;                                           // deprecated + not listed: skip
}
```

The order matters: the boolean `generateDeprecatedElements` short-circuits
first (include everything), then the per-symbol allowlist provides the
fine-grained opt-in.

### 3. Granularity — top-level simple names only

`_isDeprecatedExcluded` is consulted at the **top-level declaration** extraction
sites: type alias, enum, extension, function, top-level getter, top-level
setter, top-level variable, and class. The match is on the element's **simple
name**, so `deprecatedAllowlist: [LegacyWidget]` opts in the `LegacyWidget`
class. There is no member-level granularity — you cannot allowlist a single
deprecated *method* on an otherwise-live class; a class's members follow the
class's own emission. (If a deprecated member ever needs surgical control, use a
`@D4rtUserBridge` override — see [user_bridge_user_guide.md](user_bridge_user_guide.md).)

---

## The byte-identical default guarantee

With `generateDeprecatedElements: false` (the default) **and** an empty
`deprecatedAllowlist` (the default), `_isDeprecatedExcluded` returns `true` for
every deprecated element — exactly the historical policy. Adding the
`deprecatedAllowlist:` key to a module with an empty list, or leaving it out
entirely, produces **byte-identical** output. The feature is fully opt-in: no
committed `*.b.dart` changes until a consumer lists a symbol and regenerates.

---

## How to use it

1. **Identify the deprecated symbol** the script needs (the analyzer/IDE marks
   it deprecated; the generated bridge omits it). Confirm it is a **top-level**
   declaration in the module's barrel.
2. **Add its simple name** to that module's `deprecatedAllowlist` in
   `buildkit.yaml`.
3. **Regenerate** the module's bridges (`dart run tom_d4rt_generator:d4rtgen`).
   The symbol now appears in the `*.b.dart`; every other deprecated symbol stays
   excluded.
4. **Verify** the script resolves the symbol and the unrelated bridges are
   unchanged.

### When the allowlist does not fit

- **Member-level control** (a deprecated method on a live class): not supported
  by the allowlist; use a `@D4rtUserBridge` override.
- **Bulk inclusion** (a module that is mostly legacy API): prefer the boolean
  `generateDeprecatedElements: true`.

---

## Tests

`test/deprecated_allowlist_test.dart` drives the policy through the full
`BridgeGenerator` pipeline against `test/fixtures/deprecated_allowlist_source.dart`
(one deprecated + one live symbol per top-level category):

| Test | Asserts |
|------|---------|
| `G-DEP-1` | flag **off** + empty allowlist ⇒ all `@Deprecated` symbols excluded; live symbols present. |
| `G-DEP-2` | flag **on** ⇒ all deprecated symbols emitted. |
| `G-DEP-3` | allowlist `{LegacyWidget, legacyFunction}` ⇒ those two emitted, the rest stay excluded. |
| `G-DEP-4` | the default policy (flag off, empty allowlist) is **byte-identical across repeated generations** — pins the determinism the "byte-identical regen" guarantee depends on. |

All pass under `dart test test/deprecated_allowlist_test.dart`.

---

## Status — shipped core vs. deferred regeneration tail

| Part | State |
|------|-------|
| Config knob + `fromJson`/`toJson` + `PackageInfo` union + extractor decision site | **Shipped** (empty default → byte-identical). |
| Unit tests (`G-DEP-1..4`) | **Shipped, green.** |
| This documentation | **Shipped.** |
| Both-twin byte-identical regen (proving the default changes no committed `.b.dart`) | **Deferred** — entangled with the stale committed `.b.dart` baseline that already churns ~16 files on a no-op regen of `tom_d4rt_flutter_ast`; a clean scoped diff is blocked until that baseline is reconciled under the serial base-test gate. |
| End-to-end integration of one allowlisted deprecated symbol + serial flutter base-test gate | **Deferred** — `flutter test` in the twins must run serially (shared HTTP companion app); the activating script must run green under both runtimes before the symbol's allowlisting can be committed. |

The deferred tail is tracked in `_ai/quests/d4rt/todo_impossible.md` (#10) and
`_ai/quests/d4rt/completion_steps.d4rt.md` (OPEN A.5).
