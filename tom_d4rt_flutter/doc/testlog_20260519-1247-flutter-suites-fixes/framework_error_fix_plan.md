# Framework-error fix plan — `20260519-1247-flutter-suites-fixes` (tom_d4rt_flutter_test)

The canonical plan is maintained in the **AST project** because
both projects share the same script tree via
`SendTestRunner.scriptsPath`:

> `../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts`

Fixing a script there fixes the banner in both projects'
baseline logs simultaneously. Keeping two copies of a 138-item
numbered list would invite drift, so this project's copy is a
pointer rather than a duplicate.

## Canonical document

[`../../../tom_d4rt_flutter_ast/doc/testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`](../../../tom_d4rt_flutter_ast/doc/testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md)

## Verification protocol — repeat from the test project

After each batch of script fixes (the cadence is defined in the
AST-project doc), run the regression sweep **also** in this
project — serial only, never parallel:

```bash
cd tom_d4rt_flutter_test
flutter test test/essential_classes_test.dart \
  test/important_classes_test.dart \
  test/secondary_classes_test.dart
```

Confirm banner counts drop in this project's log set as well.
The two project log sets must reach banner-zero in lockstep —
if one stays high while the other clears, that signals a
project-local issue (interpreter sync drift between
`tom_d4rt` and `tom_d4rt_ast`) rather than a script bug.

## Closing this plan

When all 138 items are checked in the canonical doc, run a
fresh full 14-suite matrix (`ztmp/step11/run_baseline.sh
<project_dir> <new_baseline_id>`) on **both** projects, produce
a `testlog_<id>-banner-zero/` baseline pair, and add a
`**Closed YYYY-MM-DD by commit <sha>.**` footer to the
canonical doc.
