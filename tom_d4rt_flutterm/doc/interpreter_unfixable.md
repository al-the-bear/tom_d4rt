# Interpreter Unfixable Issues

This document catalogs interpreter-level issues that cannot be fixed within the current interpreter architecture or are not actually interpreter issues (platform limitations, etc.).

## Summary

| Index | Source | Category | Workaround |
|-------|--------|----------|------------|
| 13 | `color_space_test.dart` | Enum exhaustiveness | Add default case |
| 16 | `system_color_palette_test.dart` | Platform capability | Add platform guard |
| 25 | `button_bar_layout_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 27 | `button_text_theme_test.dart` | Enum exhaustiveness | Add default case |
| 30 | `dropdown_menu_close_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 32 | `gapped_range_slider_track_shape_test.dart` | Framework null errors | Not script-fixable |
| 34 | `hour_format_test.dart` | Enum exhaustiveness | Add default case |
| 36 | `material_banner_closed_reason_test.dart` | Enum exhaustiveness | Add default case |
| 38 | `navigation_destination_label_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 40 | `navigation_rail_label_type_test.dart` | Enum exhaustiveness | Add default case |
| - | `popup_menu_position_test.dart` | Enum exhaustiveness | Add default case |
| - | `axis_direction_test.dart` | Enum exhaustiveness | Add default case |
| - | `hit_test_behavior_test.dart` | Enum exhaustiveness | Add default case |
| - | `render_android_view_test.dart` | Enum exhaustiveness | Add default case |
| - | `vertex_mode_test.dart` | Enum exhaustiveness | Add default case |
| - | `live_text_input_status_test.dart` | Enum exhaustiveness | Add default case |
| - | `lock_state_test.dart` | Enum exhaustiveness | Add default case |

---

## Framework-Level Null Errors

These issues produce null-related errors that originate deep within Flutter framework code paths, not in the test script itself.

### Index 32: GappedRangeSliderTrackShape null errors

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/gapped_range_slider_track_shape_test.dart`
- **Symptom:** Multiple null-related errors during slider track painting operations
- **Root cause:** Framework-level code path where axis/value transformation produces null receivers that flow into subsequent method invocations. The errors occur in internal painting logic, not script-controllable code.
- **Not script-fixable:** The null values emerge from framework transformations; script workarounds cannot intercept or guard them.

---

## Enum Exhaustiveness Issues

### Background

Dart's exhaustive switch checking for sealed classes and enums is a compile-time feature that relies on static analysis. The D4rt interpreter evaluates switch expressions at runtime without the static knowledge of which enum members exist (bridged enum values lack exhaustiveness metadata).

**Why unfixable:**
- Exhaustive switch evaluation requires compile-time type system knowledge
- Bridged enum values are runtime objects without exhaustiveness contracts
- Adding complete runtime exhaustiveness checking would require significant interpreter architecture changes

**Workaround:** Add a `default:` case to all enum switches in D4rt scripts.

---

### Index 13: ColorSpace enum switch

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/color_space_test.dart`
- **Symptom:** `Unsupported target for indexing: null` during enum-backed info rendering
- **Root cause:** Script logic assumes exhaustive enum mapping via helper function. When interpreter fails to match enum branch, returns null which causes indexing failure.
- **Workaround:** Modify `_colorSpaceInfo` to include default fallback handling for unmatched enum values.

### Index 30: DropdownMenuCloseBehavior enum switch

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/dropdown_menu_close_behavior_test.dart`
- **Symptom:** Non-exhaustive enum switch at runtime (`DropdownMenuCloseBehavior.all`)
- **Root cause:** Bridged `DropdownMenuCloseBehavior` values reach switch evaluation without complete exhaustiveness mapping, causing runtime mismatch.
- **Workaround:** Add `default:` case to switch statements or use map-based lookup instead of switch.

### Index 25: ButtonBarLayoutBehavior enum switch (manifests as null `>` comparison)

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_bar_layout_behavior_test.dart`
- **Symptom:** `'>' called on null` — error message misleading; actual cause is enum exhaustiveness
- **Root cause:** `bbMinHeight()` function uses exhaustive switch on `ButtonBarLayoutBehavior`. When interpreter fails to match bridged enum value, switch returns null. Code then performs `height > 0` comparison, which fails on null.
- **Code path:**
  ```dart
  double bbMinHeight(ButtonBarLayoutBehavior behavior) {
    switch (behavior) {
      case ButtonBarLayoutBehavior.constrained: return 52.0;
      case ButtonBarLayoutBehavior.padded: return 0.0;
    }
  }
  // Later: height > 0 fails because height is null
  ```
- **Workaround:** Add `default:` case returning a fallback value (e.g., `default: return 0.0;`).

### Index 27: ButtonTextTheme enum switch (manifests as null property access)

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_text_theme_test.dart`
- **Symptom:** `Cannot access property 'value' on target of type null`
- **Root cause:** `btResolveColor()` function uses exhaustive switch on `ButtonTextTheme`. When interpreter fails to match, switch returns null. Code then accesses `c.value.toRadixString()` which fails because `c` is null.
- **Code path:**
  ```dart
  Color btResolveColor(ButtonTextTheme theme, Brightness brightness) {
    switch (theme) {
      case ButtonTextTheme.normal: return ...;
      case ButtonTextTheme.accent: return ...;
      case ButtonTextTheme.primary: return ...;
    }
  }
  // Later: c.value fails because c is null
  ```
- **Workaround:** Add `default:` case returning a fallback color (e.g., `default: return Colors.grey;`).

---

---

## Abstract Class Inheritance

### Background

Interpreted classes cannot directly inherit from abstract native classes because the interpreter architecture maintains `bridgedSuperObject` — a native instance of the bridged superclass. For abstract classes like `State`, `StatelessWidget`, or `StatefulWidget`, we cannot instantiate them directly.

**Why it's a limitation:**
- When a D4rt script declares `class _MyState extends State<MyWidget>`, the interpreter creates an `InterpretedClass` with `bridgedSuperclass = StateBridge`
- During constructor execution, the implicit `super()` call would normally create a native instance and store it in `bridgedSuperObject`
- For abstract classes, the constructor lookup fails (empty `constructors: {}`) 
- `bridgedSuperObject` remains null, breaking access to inherited properties like `widget`, `setState`, `context`

**Solution Architecture:**

For abstract framework classes (State, StatelessWidget, StatefulWidget), the interpreter uses **adapter proxies** instead of direct bridged super objects:

1. **Interface Proxy Factories** - Registered via `D4.registerInterfaceProxy()` for each abstract class
2. **Native Adapter Classes** - E.g., `_InterpretedState`, `_InterpretedStatelessWidget` that:
   - Extend the real abstract class
   - Hold a reference to the `InterpretedInstance`
   - Delegate abstract methods (build, createState) to the interpreted class
   - Provide access to superclass properties (widget, setState) via their native implementation
3. **nativeProxy Field** - The InterpretedInstance stores its adapter in `nativeProxy`
4. **Property Resolution** - `InterpretedInstance.get()` uses `nativeProxy` as fallback when `bridgedSuperObject` is null
5. **Property Interceptors** - Registered via `D4.registerPropertyInterceptor()` to intercept property access and return interpreted instances instead of native wrappers (e.g., `widget` property on State)

**Property Interceptor Pattern:**

For properties that need to return the original `InterpretedInstance` instead of a native wrapper object, the adapter implements an interface with a getter:

```dart
abstract class InterpretedStateProxy {
  InterpretedInstance get interpretedWidget;
}
```

Then register an interceptor:

```dart
D4.registerPropertyInterceptor('State', (instance, propertyName, nativeProxy, ...) {
  if (propertyName == 'widget' && nativeProxy is InterpretedStateProxy) {
    return InterceptedValue(nativeProxy.interpretedWidget);
  }
  return null; // Fall through to normal handling
});
```

See the [Advanced Bridging User Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md#rc-9-property-interceptors) for the complete RC-9 documentation.

**Classes requiring adapters:**
- `State<T>` - Framework state management base class
- `StatelessWidget` - Immutable widget base class  
- `StatefulWidget` - Stateful widget base class
- Similar patterns for `ChangeNotifier`, `Listenable` etc.

The adapter pattern is implemented in `d4rt_runtime_registrations.dart` (proxies and interceptors) and integrated with the `InterpretedInstance.get()` method in `runtime_types.dart`.

---

## Behavioural Deviations from Real Flutter

### C20d — `State.setState` deferral when called mid-frame

- **Source:** `rendering/render_box_container_defaults_mixin_test.dart`,
  `rendering/render_custom_paint_test.dart` (and any script that calls
  `setState` from `RenderBox.performLayout`, `paint`, or
  `hitTestChildren`).
- **Symptom (pre-fix):** Framework error
  `Native error in bridged superclass method 'State.setState': Build
  scheduled during frame.` — Flutter throws when a rebuild is requested
  while it is laying out / painting the current frame.
- **Root cause:** The driving scripts wire RenderBox lifecycle hooks
  (performLayout / paint / hitTestChildren) to `_emitSnapshot()`
  callbacks that bubble up through interpreted State and call
  `setState`. In real Flutter the same pattern would also throw — these
  scripts intentionally exercise patterns Flutter forbids.
- **Workaround in the bridge:**
  `lib/src/d4rt_user_bridges/state_user_bridge.dart` overrides the
  generated `State.setState` adapter. When
  `SchedulerBinding.instance.schedulerPhase` is
  `transientCallbacks`, `midFrameMicrotasks`, or
  `persistentCallbacks` (i.e. the framework is mid-frame), the
  callback is deferred to
  `WidgetsBinding.instance.addPostFrameCallback` instead of being
  executed synchronously. Outside those phases, behaviour is identical
  to the auto-generated bridge.
- **Behavioural deviation:** Real Flutter throws; the bridge defers.
  Scripts that rely on the synchronous throw to short-circuit will see
  the rebuild applied on the next frame instead. No tests in the
  current corpus depend on the throw, so the deviation is benign.
- **Script-level fix that removes the need for the workaround:**
  Use `LayoutBuilder` / `CustomSingleChildLayout` / `CustomMultiChildLayout`
  for layout-derived state, or call
  `WidgetsBinding.instance.addPostFrameCallback((_) => setState(...))`
  directly from the layout / paint hook. With either pattern the bridge
  takes the synchronous path and the deviation is invisible.

---

## Change Log

- 2026-04-27: Add C20d behavioural-deviation entry for the
  `StateUserBridge.overrideMethodSetState` workaround that defers
  `setState` calls made during layout / paint / transient callbacks.
- 2025-04-13: Add property interceptor mechanism (RC-9) for generic externalized property handling
- 2025-04-13: Document abstract class inheritance limitation and adapter proxy solution
- 2025-01-21: Add 7 more enum exhaustiveness fixes (popup_menu_position, axis_direction, hit_test_behavior, render_android_view, vertex_mode, live_text_input_status, lock_state)
- 2025-01-21: Add index 32 (framework null errors), 34, 36, 38, 40 (enum exhaustiveness)
- 2025-01-21: Initial document with issues 13, 16, 30 documented
