# Same-Name Bridged Classes — Resolution Rule

Two bridge packages may each declare a class with the same simple name. The
canonical case in this workspace is `MarkdownParser`, declared by both
`package:tom_doc_scanner/src/markdown_parser.dart` and
`package:tom_md2latex/src/markdown_parser.dart`. Both barrels are registered
into the same interpreter, so one name reaches two unrelated native classes.

This document states how that is resolved, what the generator must emit for the
resolution to work, and why the rule is what it is. It applies to `tom_d4rt`
and `tom_d4rt_ast` alike — the two runtimes implement it identically.

## The rule

1. **Registration is qualified by source URI.** Every bridged class is
   registered together with the canonical URI of the library that *declares*
   it — not the barrel it is exported through.
2. **A bare name resolves when it is unambiguous.** One class under a name (or
   the same class arriving twice through different barrels) resolves as before.
   Nothing about the common case changes.
3. **A bare name is rejected when it is ambiguous.** Two *different* native
   classes under one name in the same scope make the bare name an error, not an
   arbitrary pick. The interpreter throws `AmbiguousBridgedNameException`,
   naming both declaring URIs and the qualified forms that would work.
4. **`<package>.Name` is the escape hatch.** Both classes stay reachable:
   `tom_doc_scanner.MarkdownParser.generateId(...)` and
   `tom_md2latex.MarkdownParser.toLatex(...)` each reach their declaring
   library. The qualifier is the package name derived from the source URI, and
   it needs no import prefix directive — which matters because `.d4rt` replay
   files cannot carry import directives.
5. **An ambiguity is only raised when the script has a remedy.** If the
   colliding registrations cannot be told apart by package qualifier (no source
   URI, or two classes from the same package), the legacy last-registration-wins
   behaviour stands and a warning is logged. An error whose remedy does not
   exist would be worse than the arbitrary pick it replaces.
6. **A `dart:*` declaration loses to a non-platform one.** Dart's
   platform-library precedence: `dart:ui`'s `TextStyle` and painting's are two
   classes, yet naming `TextStyle` with both in scope is legal and means
   painting's. Only peers — package vs package, or platform vs platform — leave
   a name without a winner. The shadowed platform class stays reachable as
   `ui.TextStyle`.
7. **The verdict is judged over what the reading script imports.** An
   environment can hold more candidates than a script sees — the
   `tom_core_d4rt` binary registers every package it bridges, and
   `D4rtRunner`'s warm parent registers every bridged class of every library
   by name. So a lookup that meets an ambiguous name narrows the candidates to
   the packages the reading module's unprefixed imports reach (the imported
   library's own package, or that of any declaration the import made visible,
   honouring `show` / `hide` — `Environment.recordUnprefixedImport`). One left
   is the class the script means; several are still ambiguous, reported with
   just those; none, or no import record at all (a replay that imports
   everything, an environment used directly), keeps the registry's verdict.

This mirrors Dart itself: importing two libraries that both export `Foo` is
legal; *referring* to the bare `Foo` afterwards is the error, and the fix is a
prefix.

## Why the ambiguity is reported at the reference, not at registration

The interpreter is handed every bridge barrel up front, unprefixed — the
`tom_core_d4rt` binary registers all of its packages into one environment before
any script runs. Erroring at registration would fail every script the moment two
packages happen to share a name, including scripts that never mention it.

So registration records the ambiguity and `Environment.lookup` raises it, at the
point where a script actually names the class. A script that never writes
`MarkdownParser` is unaffected by the clash.

## Import-over-ambient vs import-vs-import

There is one pre-existing behaviour the rule must not break (GEN-100): an
`import` deliberately *overrides* an ambient pre-registered binding, so that
`import 'package:flutter/painting.dart'` gives the script `painting.TextStyle`
rather than the ambient `dart:ui` one. That is import-vs-ambient and stays
"import wins".

Two *imports* that each bring a different class under one name are peers, and
Dart rejects the bare name rather than picking one. The environment tracks which
bindings arrived through an import merge (`_importedBridgeNames`) precisely to
tell the two situations apart.

## What the generator must emit

The generated `…_bridges.b.dart` already carries everything the rule needs:

| Emitted member | Role |
| -------------- | ---- |
| `classSourceUris()` | `name → declaring library URI`. The map the whole rule keys off. |
| `registerBridges()` | Passes `sourceUri: classSources[entry.key]` to `registerBridgedClassLazy`. |
| `bridgeReExports()` | Lets the loader distinguish a re-export from a second declaration. |
| `extensionSourceUris()` | `<name>@<onType> → declaring library URI`, for extensions. |

**Extensions are keyed by name AND on-type** (scd8_ahcm), because the name alone
does not identify one: two libraries may each declare `extension Helpers`, and a
name-keyed map keeps only the last — registering one extension against the
other's URI. `registerBridges()` re-spells the same key from the
`BridgedExtensionDefinition` it is registering, so the two halves are one wire
format and move together. That definition carries the name and the on-type and
nothing else, so two extensions sharing BOTH cannot be separated at the lookup
site at all: the generator emits one entry and reports the other as a warning
naming both libraries, rather than emitting a duplicate map key. Classes do not
need the same treatment — a class's `sourceUri` is passed at its own
registration rather than looked up by key.

**Do not fix a collision by renaming one of the two classes in the generator
config.** Renaming is a workaround that the next collision defeats, and it
changes the name a script must use for reasons that have nothing to do with the
script. The registry distinguishes the classes; the script qualifies when it has
to.

### Why there is no generation-time collision report

A generator run sees exactly one package. Two packages colliding is only visible
where they are registered *together*, which is the interpreter, at runtime.
That is where the diagnostic lives: a `Logger.warn` at the colliding
registration ("declared by more than one library; unqualified use is now an
error…") and the `AmbiguousBridgedNameException` at the reference. A
generation-time report would need a workspace-wide index the generator does not
have and could not keep current.

The extension warning above is not a counter-example: it fires for two
extensions the SAME run emits into one file, which is exactly the collision a
single run can see. A cross-package one still cannot be.

## Writing scripts against a colliding name

```dart
// Ambiguous — both packages are registered, so this is an error.
MarkdownParser.generateId('Hello World');

// Qualified — reaches the declaring library, no import directive needed.
tom_doc_scanner.MarkdownParser.generateId('Hello World');
tom_md2latex.MarkdownParser.toLatex('Hello World');
```

A script that imports **only one** of the two libraries keeps using the bare
name; the ambiguity exists only where both are in scope (rule 7) — including
when the class reaches the script through a registry rather than through the
import's own export surface.

## Tests that pin the rule

| Test | Location | Kind |
| ---- | -------- | ---- |
| `AMBIG-1` … `AMBIG-6` | `tom_d4rt/test/environment_lazy_bridge_test.dart`, mirrored in `tom_d4rt_ast/test/environment_lazy_bridge_test.dart` | registration |
| `AMBIG-P1` … `AMBIG-P5` (platform precedence) | same files | registration |
| `AMBIG-S1` … `AMBIG-S7` (import scope) | same files | registration + import record |
| `B2-CLASH-1` … `B2-CLASH-4` | `tom_d4rt/test/bridge/same_name_bridge_sourceuri_test.dart`, ported to `tom_d4rt_exec` | script |
| `F-SCD5A-1` … `F-SCD5A-3` (TextStyle pair, import-over-ambient) | `tom_d4rt/test/bridge/scd5a_script_level_ambiguity_test.dart`, ported to `tom_d4rt_exec` | script |
| `F-SCD4A-AST-1` … `F-SCD4A-AST-3` (package pair through the runner baseline) | `tom_d4rt_ast/test/runtime/scd4a_ambiguity_import_scope_test.dart` | script (runner bundle) |
| `F-SCD5A-AST-1` … `F-SCD5A-AST-4` (the tcca19 corpus shape, TextStyle, import-over-ambient) | `tom_d4rt_ast/test/runtime/scd5a_script_level_ambiguity_test.dart` | script (runner bundle) |
| `G-EXTKEY-1` … `G-EXTKEY-5` (the emitted extension key, both halves of it) | `tom_d4rt_generator/test/extension_source_uri_key_test.dart` | generation |

`AMBIG-4` (same native type via two barrels is *not* ambiguous) and `AMBIG-5`
(an unqualifiable collision keeps last-wins) are the two that keep the rule from
over-reaching; do not relax them. `AMBIG-2` and `AMBIG-P4` pin the rejection of
peers in scope; the scope rule narrows what counts as in scope, not the
verdict.

## Changing the rule

tcca19 (tom_d4rt 1.27.0 / tom_d4rt_ast 0.19.0) broke 17 of the 927 base-corpus
scripts with `Ambiguous Name Error: TextStyle` and shipped with every test
green, because the tests were all registration-level: they asked what the
registry decides about candidates the test supplied, never whether a script
naming the class reaches it. So a change to this rule needs both of:

- **A script-level test** — bridges registered on a real interpreter, a script
  with real import directives, an assertion on which class the bare name
  reached. `tom_d4rt` runs source; `tom_d4rt_ast` runs a hand-built bundle
  through `D4rtRunner` (the `scd5a_*` files above are the pattern).
  F-SCD5A-1 and F-SCD5A-AST-1/2 go red when platform precedence is removed —
  that is the regression class this requirement exists for.
- **A corpus run after publishing** — both Flutter twins' base corpus, serially,
  with the companion-app locks at the new release, recorded under
  `Verification runs` in `tom_d4rt_flutter_ast/doc/interpreter_issues.md`. The
  d4rt quest overview states this for every name-resolution change.
