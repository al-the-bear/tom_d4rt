# tom_ast_model Limitations (delta)

> **Delta file.** `tom_ast_model` is a pure, serializable **data model** — it
> runs no Dart code and parses no source, so the *interpreter* and *parser*
> limitations do not apply to it. Those are documented once in the canonical
> reference:
>
> **→ [tom_d4rt/doc/d4rt_limitations.md](../../tom_d4rt/doc/d4rt_limitations.md)**
>
> A tree expressed in this model is subject to every interpreter limitation
> there once a runtime (`tom_d4rt_ast` / `tom_d4rt_exec`) executes it, and to
> the parser/conversion limits of `tom_ast_generator` when it is produced. This
> file lists only the limitations of the **data model itself** — of which there
> are very few.

## Model-specific deltas

### M-1 — Syntax, not semantics

The model is a **syntactic** mirror of the analyzer AST. It carries no resolved
types, no element bindings, no const values, and no semantic-error information.
Fields such as `resolvedSlot` / `declSlot` are interpreter binding *hints*
computed by a separate pass and merely stored here; the model neither computes
nor validates them. Do not expect `tom_ast_model` to tell you whether a program
is type-correct — only what it syntactically *is*.

### M-2 — Coverage tracks the analyzer's node set at model-build time

The node hierarchy mirrors the Dart analyzer AST as of the SDK this package is
built against. A Dart syntax newer than that — or any analyzer node type not
yet mirrored — has no typed counterpart; on deserialization it surfaces as a
`_SUnknownNode` (preserving `nodeType`, offset, and length) rather than a typed
node. This is intentional forward-compatibility, but such nodes are inert: tools
and runtimes cannot act on them meaningfully. Keep the model version-aligned
with the `tom_ast_generator` producing your trees.

### M-3 — JSON contract is the compatibility boundary

Round-trip fidelity is defined by the `toJson()` / `fromJson()` contract and the
`"nodeType"` discriminator, **not** by Dart object identity. Two trees are
"equal" iff their JSON forms match (`equals()` / `operator ==` compare the
serialized maps). A bundle's portability therefore depends on producer and
consumer sharing a compatible `tom_ast_model` version: a field added or renamed
between versions changes the JSON shape. Keep the model, `tom_ast_generator`,
and the consuming `tom_d4rt_ast` runtime version-aligned (mirrors
`tom_ast_generator` delta G-4 and `tom_d4rt_ast` delta D-4).

## No other deltas

Beyond the points above, `tom_ast_model` has no project-specific limitations.
It is a zero-dependency data contract; all execution behaviour and language
coverage belong to the runtimes that consume it — see the canonical reference
linked at the top.
