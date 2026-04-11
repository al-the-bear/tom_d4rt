# 20260411-1207-issue-analysis Error Analysis (Batch-0)

## Scope

Batch-0 is interpreted as the first batch in the summary table (Batch-1 rows):

- essential_classes_test.dart
- important_classes_test.dart
- secondary_classes_test.dart
- hardly_relevant_classes_1_test.dart
- hardly_relevant_classes_2_test.dart

## Batch-0 Inventory Analysis (missing vs stray)

Reference-set extraction from the 5 batch-0 suite files produced:

- Referenced script paths: 1334
- Missing referenced scripts: 1
- Existing scripts not referenced by batch-0 suites (stray candidates): 655

### Missing referenced scripts

| Script path | Evidence | Classification | Required action |
|---|---|---|---|
| painting/asset_bundle_image_provider_test.dart | Referenced in test/hardly_relevant_classes_2_test.dart but absent in test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/painting/ | Missing file | Create script file and keep status as `No | No | No | Needs to be created` until implemented |

### Stray candidates (batch-local only)

These files are present in send_ast_via_http_scripts but not referenced by the batch-0 suite list. They are not globally missing; they are outside this batch scope.

Top package buckets among 655 stray candidates:

- widgets: 454
- rendering: 96
- services: 89
- semantics: 10
- scheduler: 4
- material: 1
- dart_ui: 1

Representative examples:

- dart_ui/display_feature_test.dart
- material/stepper_state_test.dart
- rendering/alignment_geometry_tween_test.dart
- rendering/annotation_result_test.dart
- services/autofill_hints_test.dart
- widgets/display_feature_sub_screen_test.dart

## Error Category Classification (Batch-0 logs)

| Category | Typical log signature(s) | Batch-0 evidence | Ownership | Action |
|---|---|---|---|---|
| Script-side parameter/contract issues | Invalid parameter or framework constructor/assert contract violations | `PopupMenuButton` child+icon assertion, null `Text.data`, null `Vertices.positions`, invalid `DragEndDetails.primaryVelocity` patterns in hardly_relevant_classes_1/2 logs | Script/demo definitions | Tighten demo inputs and constructor arguments; add null guards and valid parameter combinations |
| Bridge/generator type mapping gaps | Type cast mismatch and unresolved bridge APIs | `List<Object?>` -> `List<Widget>` cast, `Expected Widget but got InterpretedInstance`, `cannot convert List to List<ThemeExtension<dynamic>>`, unresolved import `package:flutter_test/flutter_test.dart` not bridged, missing bridged `whereType`/`new` members | Bridge definitions + generator | Add/adjust bridge signatures, generic conversion rules, and exposed members/extensions |
| Interpreter/runtime semantic limitations | Non-exhaustive switch on enum values, state-member resolution failures | `Switch expression was not exhaustive` for `DropdownMenuCloseBehavior.all`, `MaterialBannerClosedReason.dismiss`, `NavigationDestinationLabelBehavior.alwaysShow`, `NavigationRailLabelType.none`; repeated `Undefined property 'widget'` and late-init access failures | Interpreter core | Extend enum switch handling and state/member resolution behavior; track as interpreter limitation bucket |
| Framework/layout noise in demos | Render/layout assertions and overflow blocks | `_RenderEditableCustomPaint ... was not laid out`, `hasSize` assertions, and overflow entries in essential/important/hardly_relevant suites | Test script layout + harness expectations | Keep as non-transport failure bucket; reduce noisy layouts in demos where practical |
| Transport cascade after first hard runtime break | One HTTP header-close followed by repeated connection-refused | In secondary_classes_test.log: first `HttpException: Connection closed before full header`, then many `SocketException: Connection refused` transport failures | Runtime process stability | Treat downstream transport failures as cascade effects; prioritize the first hard runtime error in the suite |

## Per-suite Summary (Batch-0)

| Suite | Summary metrics | Primary diagnosis |
|---|---|---|
| essential_classes_test.dart | E=0, FW=4, TR=0, OV=4 | No explicit [E] failures; mostly framework/layout and overflow noise |
| important_classes_test.dart | E=3, FW=7, TR=0, OV=0 | Mixed script contract errors and bridge type-mapping issues |
| secondary_classes_test.dart | E=150, FW=47, TR=290, OV=39 | Interpreter/bridge runtime failures followed by major transport cascade |
| hardly_relevant_classes_1_test.dart | E=10, FW=7, TR=0, OV=4 | Script constructor contract issues plus bridge/runtime type failures |
| hardly_relevant_classes_2_test.dart | E=19, FW=21, TR=0, OV=14 | Non-exhaustive switch limitations and bridge type/import resolution gaps |

## Conclusion

Batch-0 failures are not a single-source problem. The dominant remediation areas are:

1. Interpreter semantics (enum switch exhaustiveness and state/member resolution).
2. Bridge/generator type conversion and API coverage.
3. Script-level contract cleanup for invalid constructor input combinations.

Missing file handling for this batch is currently limited to:

- painting/asset_bundle_image_provider_test.dart (must be created).
