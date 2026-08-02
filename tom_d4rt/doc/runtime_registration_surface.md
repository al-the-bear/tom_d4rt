# Runtime Registration Surface (VM)

`tom_d4rt` is the analyzer-based VM interpreter. Its runtime registration
surface is **identical** to the web-capable twin's, so this document does not
restate it — read the canonical reference:

> **`tom_d4rt_ast/doc/runtime_registration_surface.md`**

That covers the nine `D4.register*` sinks, the `BridgedClass` supertype
mechanism + transitive walk + last-match-wins proxy filter, the
`extractBridgedArg<T>` resolution order, the RC-9 State-proxy field
fallbacks, and the process-global **package pool + warm parent**
(`providePackage`, § 5) — all of which exist identically here (in
`lib/src/generator/d4.dart`, `lib/src/bridge/bridged_types.dart`,
`lib/src/runtime_types.dart`, and `lib/src/d4rt_base.dart` for the pool),
offset only by a constant comment-block delta.

## VM-only specifics

The only functional differences are in the downstream manual registration file
`tom_d4rt_flutter/lib/src/d4rt_runtime_registrations.dart` versus its web twin:

- **`_InterpretedKeepAliveState`** (`with AutomaticKeepAliveClientMixin`) and
  its `_usesAutomaticKeepAliveClientMixin` walk + proxy-factory dispatch are
  present here but **absent in `tom_d4rt_flutter_ast`**. This is accidental
  drift (the web twin is behind), tracked to converge via the generator's
  `mixinVariants:` State family.
- **`RouterDelegate<Object>`** is used here, where the web twin uses
  `RouterDelegate<dynamic>`. One is wrong; the two must be reconciled.
