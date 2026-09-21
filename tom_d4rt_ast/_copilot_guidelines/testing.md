# tom_d4rt_ast — Testing Guidelines

**This is not a copy of `tom_d4rt`'s `testing.md`, and it must not become
one.** Most of that document's content is false of this package: it describes
a suite that runs Dart source through an analyzer front end, and this package
has no analyzer and cannot parse. What is shared — the test-id format, the
known-gap convention, testkit baselines — is named here with a pointer rather
than restated, so it cannot drift.

The conventions below are this tree's own. Every one of them existed as
folklore before it was written down, and at least one was rediscovered the
expensive way: SCD49 met the `-AST-` infix in a doc comment and had to work
out that the divergence from the reference's wording was correct rather than
drift.

---

## What this package can and cannot test

`tom_d4rt_ast` interprets pre-parsed `SAstNode` trees. It has no parser, so
**no test here can run a script from source.** That single fact shapes
everything else:

| Question | Where it is answered |
| -------- | -------------------- |
| does the interpreter behave correctly on a script? | `tom_d4rt` (analyzer front end), and `tom_d4rt_exec` for this interpreter |
| does a bridge register, resolve, and dispatch? | here, by driving the adapter or the `Environment` directly |
| does a script's NAME reach the right bridge? | here, by hand-building a bundle — see below |

A behavioural claim about this interpreter that needs a script belongs in
`tom_d4rt_exec`, which pairs this runtime with the analyzer. Note DGUC6: exec
resolves `tom_d4rt_ast` **from pub.dev**, so such a test certifies the
published interpreter, not the working tree.

---

## Script-level tests: hand-build the bundle

A test that must ask what a *script* sees builds an `AstBundle` by hand and
runs it through `D4rtRunner`. The pattern is
`test/runtime/scd5a_script_level_ambiguity_test.dart`:

```dart
AstBundle bundle(List<String> imports) {
  const entry = 'package:t/main.dart';
  // ... SMethodInvocation / SFunctionDeclaration built node by node ...
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [for (final uri in imports) importOf(uri)],
        declarations: [mainFn],
      ),
    },
  );
}
```

**Why it is worth the verbosity.** tcca19 shipped with every unit test green
and broke 17 base-corpus scripts, because every ambiguity test built an
`Environment` by hand and asked what the registry decided about candidates the
test itself supplied. None ran a script. A hand-built bundle carries real
import directives, so the question asked is the one the corpus asks.

**When to reach for it:** any change to how a NAME resolves — `Environment`
lookup, bridge registration, the ambiguity rule, import/export merging,
prefixes, shadowing. The quest overview makes a script-level test mandatory
for that class of change, in both trees.

---

## Case ids carry an `-AST-` infix

A case that is this tree's counterpart of a reference case keeps the reference
id and inserts `AST`:

```
tom_d4rt          F-SCC50-1
tom_d4rt_ast      F-SCC50-AST-1
```

Measured 2026-09-21: **469 case ids** across 82 id families use it. The infix
is what lets a reader — and a grep — tell the two trees' results apart in a
log, a baseline CSV or a commit message, where the package name is often not
in view.

Cases with no counterpart take a plain id. The infix is not decoration: it
claims a pairing, so do not add it to a case that stands alone here.

---

## The dependency and platform constraints are testable, and tested

This package is what a **Flutter app ships**, so two properties are load-
bearing and both have guards:

* **`lib/` must not reach `dart:io`.** `test/web_safety_test.dart`
  (`F-DFUB12-1..3`) walks every public library's import graph, resolving
  conditional imports, and fails if any path reaches it. Its third case is the
  anti-vacuity control: it asserts the walk actually follows conditional
  imports rather than stopping at them.
* **`lib/` must not import `dart:mirrors`.** It does not, and the four
  mentions of mirrors in `lib/` are comments explaining why a member is
  reflected some other way.

**`tool/` and `test/` are exempt from the mirrors rule, deliberately.**
`tool/stdlib_member_audit.dart` reflects the SDK to decide which members a
bridge is missing, and `scd51_member_coverage_test.dart` and
`scc24_native_name_coverage_test.dart` use mirrors to read the bridge model.
Dev-time code is not shipped, so the constraint that makes this package
web-safe does not apply to it. SCD51 established that boundary; do not "fix" a
mirrors import in `tool/` or `test/` by removing it.

Runtime dependencies are `tom_ast_model` and `archive`, and the `tom_ast_model`
constraint is upper-bounded on purpose — a breaking change to the model is a
breaking change here, and an open constraint would let pub pair an interpreter
with a model it cannot read.

---

## Shared conventions, not restated here

These are identical in both trees. Read them in
[`../../tom_d4rt/_copilot_guidelines/testing.md`](../../tom_d4rt/_copilot_guidelines/testing.md):

| Convention | Section there |
| ---------- | ------------- |
| test id format `ID: description [date] (result)` | Test ID Convention |
| testkit baselines and the result column | Test Results Tracking |
| recording a known gap (`KNOWN-GAP(<id>)` / `WONT-FIX`) | Recording a known gap |
| naming groups after a contract, never a status | Naming groups |
| the `(FAIL)` suffix is always a stale label | The `(FAIL)` suffix |

Two notes on how they land here:

* the known-gap markers are enforced across THREE trees by `F-SCC6-5` in
  `tom_d4rt_exec`, this one included. Measured 2026-09-21, this package has no
  markers at all.
* `(SKIP)` tags are checked against real skips by `sce89_skip_tag_agreement_test`
  in `tom_d4rt`, which reads this tree's corpus as well as its own — it needs
  `package:analyzer`, which this package cannot depend on.

---

## What guards this tree from the outside

Several guards about this package live elsewhere, because they need the
analyzer or need to compare two trees. Knowing where they are saves rewriting
one here:

| Guard | Lives in | Asserts |
| ----- | -------- | ------- |
| `F-SCD49-*` | `tom_d4rt` | the two stdlib trees are code-identical bar recorded points |
| `F-SCD199-*` | `tom_d4rt` | the two interpreters agree member by member |
| `F-SCD51-5/6` | `tom_d4rt` | the member-gap sets agree, and the chain walk reproduces the probe |
| `F-SCC6-*` | `tom_d4rt_exec` | the conformance corpora agree; markers; guideline drift |
| `F-SCE89-*` | `tom_d4rt` | a `(SKIP)` tag and a real skip agree, in both trees |

`grep -rn 'REPO-WIDE GUARD' */test` from the repo root lists every such file
and what it asserts.

---

## Running the suite

```bash
cd tom_d4rt_ast
dart test                 # ~950 cases, about ten seconds
dart test -j 4            # the usual full run
```

There is no companion app and no corpus here — those belong to the Flutter
twins. A change to this interpreter that needs corpus evidence has to be
published first; the quest overview's verification protocol says how.
