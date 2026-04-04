# Test Script Context

This document describes the execution context for D4rt Flutter test scripts in the `tom_d4rt_flutterm` project.

## Test App Architecture

The test app (`tom_d4rt_flutterm_app`) is a Flutter desktop application that:

1. Runs an HTTP server on port **4247**
2. Receives D4rt AST bundles via POST to `/build`
3. Executes the `build(BuildContext context)` function from the script
4. Renders the returned Widget in the app's UI
5. Captures framework errors via `FlutterError.onError`
6. Reports results back via HTTP response

## Widget Rendering Context

Test widgets are rendered inside the following layout hierarchy:

```
Scaffold
└── body: Column
    ├── Container (server status bar)
    ├── Container (control bar with pause/play/good/bad buttons)
    ├── TabBar (Widget / Source tabs)
    ├── Expanded (flex: 3) ← ~60% of remaining height
    │   └── TabBarView
    │       └── Container (margin: 8, with border decoration)
    │           └── [YOUR TEST WIDGET HERE]
    └── Expanded (flex: 2) ← log panels
```

## Constraints Applied to Test Widgets

The test widget receives:

| Constraint | Value |
|------------|-------|
| **Width** | `screen_width - 16px` (8px margin on each side) |
| **Height** | Bounded, approximately **60% of available space** after AppBar, status bar, control bar, and tab bar |
| **Min/Max** | Both bounded (not infinite) |

### Important Implications

1. **Vertical overflow**: If your widget returns a `Column` with children that exceed the available height (~400-500px on typical desktop), you'll get a "RenderFlex overflowed on the bottom" error.

2. **Horizontal constraints**: Width is fixed and bounded. Widgets get proper horizontal constraints.

3. **No Scaffold context**: The test widget is rendered inside the app's Scaffold, so test scripts should NOT return their own Scaffold (unless testing Scaffold specifically).

## Test Script Requirements

### Required Function

Every test script **must** contain:

```dart
Widget build(BuildContext context) {
  return YourWidget(...);
}
```

### Common Patterns

#### For Content That May Exceed Available Height

Wrap in `SingleChildScrollView`:

```dart
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Many widgets...
      ],
    ),
  );
}
```

#### For Column with Fixed-Size Children

Use `mainAxisSize: MainAxisSize.min`:

```dart
Widget build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,  // Don't expand to fill available space
    children: [
      Text('Item 1'),
      Text('Item 2'),
    ],
  );
}
```

## Common Error Causes

### 1. RenderFlex Overflowed on Bottom

**Cause**: Column children exceed available height (~400-500px)

**Fix**: Wrap Column in `SingleChildScrollView`

### 2. BoxConstraints Has Negative Minimum Height

**Cause**: Usually occurs with `CupertinoTextField` or similar widgets that expect an unconstrained parent or specific layout context. The test harness provides bounded constraints which some widgets don't handle well.

**Note**: This is often a **valid test case** - it reveals that certain widgets need specific layout contexts.

### 3. RenderBox Was Not Laid Out (NEEDS-LAYOUT)

**Cause**: A widget's render object wasn't laid out before being accessed. Often cascades from negative height constraints.

**Note**: Same as above - usually reveals widget requirements, not test script bugs.

### 4. Type 'List<Object?>' Not Subtype of 'List<Widget>'

**Cause**: **D4rt interpreter bug** - generic type inference fails for callback return types.

**Workaround**: Add explicit type annotation:
```dart
// Instead of:
headerSliverBuilder: (context, _) => [SliverAppBar()]

// Use:
headerSliverBuilder: (context, _) => <Widget>[SliverAppBar()]
```

### 5. Unbounded Width in Row

**Cause**: Widget with flex behavior (like DropdownMenu) placed in Row without constraints.

**Fix**: Use `Wrap` instead of `Row`, or wrap flex widgets in `Expanded`/`Flexible`.

## Categories of Test Errors

| Error Type | Test Script Fix? | Notes |
|------------|------------------|-------|
| Overflow (bottom) | **Yes** | Wrap in SingleChildScrollView |
| Overflow (right) | **Yes** | Use Wrap or add constraints |
| Negative height | *Sometimes* | May be valid test finding for constrained widgets |
| Needs layout | *Sometimes* | Usually cascades from constraint issues |
| Type mismatch | **Yes** | Add explicit type annotations (D4rt workaround) |

## Test Script Development Tips

1. **Keep content minimal**: Test the feature, not the layout
2. **Use scrollable containers**: When in doubt, wrap in SingleChildScrollView
3. **Explicit types**: Always use explicit generic types in callbacks for D4rt
4. **Test locally first**: Run the test app manually to see rendering issues
5. **Check constraints**: Use `LayoutBuilder` to debug constraint issues

## Related Documentation

- [interpreter_issues.md](interpreter_issues.md) - D4rt interpreter limitations
- Test harness source: `test/tom_d4rt_flutterm_app/lib/main.dart`
