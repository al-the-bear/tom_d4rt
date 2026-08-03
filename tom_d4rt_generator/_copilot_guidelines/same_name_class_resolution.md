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

## Writing scripts against a colliding name

```dart
// Ambiguous — both packages are registered, so this is an error.
MarkdownParser.generateId('Hello World');

// Qualified — reaches the declaring library, no import directive needed.
tom_doc_scanner.MarkdownParser.generateId('Hello World');
tom_md2latex.MarkdownParser.toLatex('Hello World');
```

A script that imports **only one** of the two libraries keeps using the bare
name; the ambiguity exists only where both are in scope.

## Tests that pin the rule

| Test | Location |
| ---- | -------- |
| `AMBIG-1` … `AMBIG-6` | `tom_d4rt/test/environment_lazy_bridge_test.dart`, mirrored in `tom_d4rt_ast/test/environment_lazy_bridge_test.dart` |
| `B2-CLASH-1` … `B2-CLASH-4` | `tom_d4rt/test/bridge/same_name_bridge_sourceuri_test.dart` |

`AMBIG-4` (same native type via two barrels is *not* ambiguous) and `AMBIG-5`
(an unqualifiable collision keeps last-wins) are the two that keep the rule from
over-reaching; do not relax them.
