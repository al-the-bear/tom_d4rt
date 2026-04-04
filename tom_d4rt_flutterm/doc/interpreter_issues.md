# D4rt Interpreter Issues

This document tracks D4rt interpreter bugs and limitations discovered during Flutter widget testing.

## Issue #1: Generic Type Inference in Callback Return Types

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: Available

### Description

The D4rt interpreter fails to infer generic types correctly for list literals returned from callback functions. When a callback returns a list literal `[...]`, the interpreter infers `List<Object?>` instead of the expected type based on context (e.g., `List<Widget>`).

### Reproduction

```dart
// This fails with: type 'List<Object?>' is not a subtype of type 'List<Widget>'
NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) => [
    SliverAppBar(title: Text('Title')),
  ],
  body: Container(),
)
```

### Error Message

```
type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

### Affected Test Files

| File | Line | Construct |
|------|------|-----------|
| [nested_scroll_view_state_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/nested_scroll_view_state_test.dart) | ~20 | `headerSliverBuilder: (ctx, _) => [...]` |
| [nestedscrollview_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/nestedscrollview_test.dart) | ~20, ~50, ~76, ~102 | `headerSliverBuilder: (ctx, _) => [...]` |
| [render_nested_scroll_view_viewport_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_nested_scroll_view_viewport_test.dart) | ~20, ~59, ~87, ~136, ~175 | `headerSliverBuilder: (ctx, _) => [...]` |

### Workaround

Add explicit type annotation to the list literal:

```dart
// Use explicit <Widget>[] type annotation
NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
    SliverAppBar(title: Text('Title')),
  ],
  body: Container(),
)
```

### Root Cause Analysis

The interpreter appears to:
1. Evaluate the callback body independently
2. Infer the list literal type as `List<Object?>` (most general)
3. Attempt to cast the result to the expected return type
4. Fail because `List<Object?>` is not a subtype of `List<Widget>`

Native Dart handles this correctly by inferring the list type from the callback's expected return type.

### Similar Patterns to Watch

Any callback returning a list literal may exhibit this issue:

```dart
// Potentially affected patterns:
itemBuilder: (context, index) => [Widget1(), Widget2()][index]
children: () => [Widget1(), Widget2()]
tabs: items.map((e) => [Tab(text: e)]).expand((x) => x).toList()
```

---

## Issue Tracking Notes

When adding new issues:

1. Assign sequential issue numbers (#1, #2, etc.)
2. Include: Status, Severity, Discovered date, Workaround availability
3. Provide minimal reproduction code
4. List all affected test files with line numbers
5. Document the workaround clearly
6. Add root cause analysis if known
