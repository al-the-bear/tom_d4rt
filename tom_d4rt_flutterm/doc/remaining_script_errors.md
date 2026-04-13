# Remaining Script Errors Summary

This document catalogs tests that have complex script-level issues requiring detailed examination. These are NOT generator or interpreter issues — they are script template, architecture, or lifecycle timing issues.

## Script Template / Architecture Issues

These tests have been flagged for script-level examination due to recurring template patterns, late-initialization issues, or complex architecture defects that are script-side rather than bridge/interpreter-side.

### Non-Immediate Script Issue

| # | Filename | Issue Index | Issue Type | Status |
|---|----------|-------------|------------|--------|
| 1 | widgets/scroll_notification_observer_state_test.dart | 176 | SCRIPT-LATE-INIT-TEMPLATE (`_tabCtrl` variant) | **FIXED** |

**Fix applied:**
1. Changed `late final TabController _tabCtrl;` + initState assignment to inline: `late final TabController _tabCtrl = TabController(length: 3, vsync: this);`
2. Removed `AutomaticKeepAliveClientMixin` from all three tab state classes (caused "Cannot call super method 'build'" error)
3. Removed associated `wantKeepAlive` overrides and `super.build(context)` calls

### Intentionally Skipped Interactive Tests

These tests were previously skipped because they require interactive user input. With the new `/interact` endpoint and `InteractionController`, these tests can now be automated using programmatic gesture simulation.

**New test file:** `test/interactive_tests_test.dart`

| # | Filename | Issue Index | Status |
|---|----------|-------------|--------|
| 1 | material/showdialog_test.dart | 272 | Can use `tapText` to tap buttons |
| 2 | material/showbottomsheet_test.dart | 273 | Can use `tapText` to tap list items |
| 3 | material/showmenu_test.dart | 274 | Can use `tapText` to select menu items |
| 4 | cupertino/showdatepicker_test.dart | 275 | Can use `drag` for date selection |
| 5 | cupertino/showtimepicker_test.dart | 276 | Can use `drag` for time selection |

**Interaction API** (via `/interact` endpoint):

```dart
// After sending a script that shows a dialog:
await SendTestRunner.sendAndInteract(
  'material/showdialog_test.dart',
  actions: [
    {'type': 'waitFrames', 'frames': 30},
    {'type': 'tapText', 'text': 'OK'},
  ],
);
```

Supported actions:
- `waitFrames` / `waitMillis` - Wait for animations
- `tapAt` - Tap at screen coordinates
- `tapText` - Find and tap widget by text
- `tapType` - Find and tap widget by type
- `tapIcon` - Find and tap Icon by icon name
- `dismiss` - Tap in corner to dismiss modal
- `drag` / `dragVertical` - Simulate drag gestures
- `back` - Press back button

## Recurring Template Defect Patterns

The following recurring script architecture patterns were identified and fixed across batches 19-77. While these scripts are now passing, they represent systemic template issues that should be addressed at the template generation level:

### Late-Initialization Pattern Variants

1. **`_tabController` variant** (batches 28-30, 38-40, 44)
   - Direct lifecycle-dependent state-context coupling
   - Late fields read before guaranteed initialization

2. **`_tabs` variant** (batches 31-35, 41-43, 77)
   - Same defect family with different field name
   - Template-level architecture issue

3. **`_tabCtrl` variant** (batches 35-39)
   - Naming variation of the same architecture-level issue
   - Requires template rules to prevent

4. **`_loggingManager` variant** (batch 39)
   - Another variable-name variant of uninitialized late state

5. **`_dispatcher` variant** (batch 55)
   - Same pattern in action dispatcher context

### Architecture Issues by Category

| Category | Description | Affected Batches |
|----------|-------------|------------------|
| Scene-state coupling | Context-dependent values retrieved indirectly from framework state | 19, 20, 21, 22 |
| Implicit lifecycle member access | Indirect access to `State.widget` through interpreted object paths | 21, 22, 23, 24, 29-35 |
| Missing finite layout constraints | Unbounded layout composition in composition-heavy scenes | 22, 23, 24 |
| Late variable initialization | Late variables read before initialization under interpreted timing | 21 |

## Summary

- **Non-immediate script issues:** 1 (idx 176) — **NOW FIXED**
- **Interactive tests (now automatable):** 5 (idx 272-276)
- **Total script-level issues:** 6 (1 fixed, 5 have automation path)

**Note:** The 5 interactive tests now have a path forward using the `InteractionController` and `/interact` HTTP endpoint. See `test/interactive_tests_test.dart` for examples.

The remaining script issues are either already addressed via script rewrites (for immediate fixes) or are architectural patterns that should be prevented at template generation time rather than fixed in the interpreter or bridge generator.
