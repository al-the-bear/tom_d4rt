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
