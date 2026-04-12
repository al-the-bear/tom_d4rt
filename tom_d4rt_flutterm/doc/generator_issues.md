# Generator Issues

batch: 0

- No batch-0 entries required bridge-generator deep analysis.
- All batch-0 issues were marked immediate-fix and were handled directly in script/harness code.

batch: 1

issue-index: 6

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/test_scripts/animation/reverse_tween_test.dart`
- Symptom: `dart run` path failed when attempting generic bridge construction of `ReverseTween<T>`, especially for `Color`-typed tween flows.
- Immediate outcome: script now constructs reversed tween behavior through explicit typed reversal fallback (`Tween<double>` / `ColorTween`) when generic `ReverseTween` bridge usage is not viable.
- Deep analysis:
	- The generated bridge/runtime path does not reliably support generic constructor routing for `ReverseTween<T>` with type-specialized tween semantics.
	- `Tween.transform` on base `Tween` cannot safely handle all subtype lerp contracts (notably `Color`), so fallback must preserve subtype-specific tween classes.
	- This indicates a generator-level gap in generic constructor/materialization support and subtype-aware tween reconstruction.
- Follow-up recommendation:
	- In bridge generation, add explicit support for `ReverseTween<T>` construction dispatch with retained concrete tween subtype metadata.
	- Add generator/runtime tests that cover `ReverseTween<double>`, `ReverseTween<Color>`, and additional common typed tweens to prevent regression.

batch: 2

issue-index: 14

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/key_event_type_test.dart`
- Symptom: Runtime warning `Undefined property or method 'label' on bridged instance of 'Key'.`
- Immediate outcome: script now uses local helper mapping for event/device labels, removing direct `.label` member dependency in the harness.
- Deep analysis:
	- The bridge surface currently does not expose all label-style members needed by this script path.
	- This is a bridge coverage gap, not a layout/rendering issue.
	- The script workaround is valid for immediate stabilization, but it does not expand bridge API coverage.
- Follow-up recommendation:
	- Add/verify bridge member exposure for key-related label access in the relevant `dart:ui` key bridge definitions.
	- Add focused regression tests for key/device label access so missing-member regressions are caught early.

batch: 3

issue-index: 17

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/vertex_mode_test.dart`
- Symptom: Runtime warnings from bridged `Vertices` construction: `Invalid parameter "positions": expected List<Offset>, got null`.
- Immediate outcome: script now guarantees non-null `positions`/`colors` defaults and explicit mode dispatch, removing warnings in harness execution.
- Deep analysis:
	- Constructor argument extraction/coercion in the bridge path is brittle when mode dispatch fails or yields incomplete argument state.
	- The script-side guard prevents null constructor args, but the bridge should still defensively validate/coerce typed list arguments.
- Follow-up recommendation:
	- Harden bridge constructor adapters for `Vertices` to reject null typed lists early with clearer diagnostics and optional safe defaults.
	- Add regression coverage for all `VertexMode` variants with constructor argument validation.

issue-index: 18, 19

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/foundation/object_created_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/foundation/object_disposed_test.dart`
- Symptom: Runtime failure `Object is not callable (no default constructor bridge found)`.
- Immediate outcome: scripts now use `_safeObject(...)` fallback to avoid direct dependency on missing `Object()` bridge constructor support.
- Deep analysis:
	- This is a shared bridge/runtime coverage gap for root/core class constructor availability.
	- Multiple lifecycle scripts fail on the same missing default-constructor path, confirming a central bridge deficiency rather than isolated script misuse.
	- Script fallback unblocks tests but does not restore canonical `Object()` constructor semantics.
- Follow-up recommendation:
	- Add default constructor bridge support (or explicit native fallback) for `Object()` and validate in all object-lifecycle scripts.
	- Add core-constructor smoke tests for other root classes to avoid similar gaps.
