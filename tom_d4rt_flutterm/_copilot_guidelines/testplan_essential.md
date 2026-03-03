# Test Plan: Essential Classes

**Priority: ESSENTIAL**
**Total classes: 254**
**Test scripts: 107 (all passing)**

Core classes that must be tested first - used in virtually every Flutter application.

### Hardening Notes

Scripts hardened after GEN-076 audit:
- `rendering/layers_test.dart` — Replaced duplicate OpacityLayer section with LeaderLayer/FollowerLayer tests (PhysicalModelLayer not bridged)
- `gestures/details_test.dart` — Restored OffsetPair.fromEventPosition using PointerDownEvent

### Additional Coverage Scripts

12 scripts exist in essential_classes_test.dart beyond the testplan entries:
- `dart_ui/color_test.dart`, `offset_test.dart`, `rect_test.dart`, `size_test.dart` — dedicated single-class tests supplementing combined primitives/geometry scripts
- `painting/edge_insets_test.dart` — additional EdgeInsets coverage beyond edgeinsets_test.dart
- `material/datatable_test.dart`, `expansion_test.dart`, `stepper_test.dart` — important-tier classes (tracked in testplan_important.md)
- `widgets/cliprrect_test.dart`, `opacity_test.dart`, `transform_test.dart`, `wrap_test.dart` — important-tier classes (tracked in testplan_important.md)

---

## widgets (45 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Container | All-in-one layout widget | widgets/container_test.dart | pass | pass |
| Center | Center alignment | widgets/center_test.dart | pass | pass |
| Padding | Padding wrapper | widgets/padding_test.dart | pass | pass |
| Align | Alignment wrapper | widgets/align_test.dart | pass | pass |
| Row | Horizontal layout | widgets/row_test.dart | pass | pass |
| Column | Vertical layout | widgets/column_test.dart | pass | pass |
| Expanded | Flex expansion | widgets/expanded_test.dart | pass | pass |
| Flexible | Flex sizing | widgets/flexible_test.dart | pass | pass |
| SizedBox | Fixed size box | widgets/sized_box_test.dart | pass | pass |
| Text | Text display | widgets/text_test.dart | pass | pass |
| RichText | Rich text display | widgets/richtext_test.dart | pass | pass |
| Icon | Icon display | widgets/icon_test.dart | pass | pass |
| Image | Image display | widgets/image_test.dart | pass | pass |
| Scaffold | App scaffold | widgets/scaffold_test.dart | pass | pass |
| AppBar | App bar | widgets/appbar_test.dart | pass | pass |
| ListView | Scrollable list | widgets/listview_test.dart | pass | pass |
| GridView | Scrollable grid | widgets/gridview_test.dart | pass | pass |
| SingleChildScrollView | Scrollable container | widgets/singlechildscrollview_test.dart | pass | pass |
| Stack | Layered layout | widgets/stack_test.dart | pass | pass |
| Positioned | Stack positioning | widgets/positioned_test.dart | pass | pass |
| GestureDetector | Gesture handling | widgets/gesturedetector_test.dart | pass | pass |
| InkWell | Material tap effect | widgets/inkwell_test.dart | pass | pass |
| Navigator | Navigation | widgets/navigator_test.dart | pass | pass |
| PageView | Page scrolling | widgets/pageview_test.dart | pass | pass |
| Form | Form container | widgets/form_test.dart | pass | pass |
| FormField | Form field base | widgets/form_test.dart | pass | pass |
| TextFormField | Text input field | widgets/form_test.dart | pass | pass |
| TextField | Basic text input | widgets/textfield_test.dart | pass | pass |
| EditableText | Low-level text edit | widgets/textfield_test.dart | pass | pass |
| FocusNode | Focus management | widgets/focusnode_test.dart | pass | pass |
| FocusScope | Focus scoping | widgets/focusnode_test.dart | pass | pass |
| StatelessWidget | Stateless base | widgets/statefulwidget_test.dart | pass | pass |
| StatefulWidget | Stateful base | widgets/statefulwidget_test.dart | pass | pass |
| State | Widget state | widgets/statefulwidget_test.dart | pass | pass |
| BuildContext | Build context | widgets/statefulwidget_test.dart | pass | pass |
| Key | Widget identity | widgets/key_test.dart | pass | pass |
| GlobalKey | Global widget key | widgets/key_test.dart | pass | pass |
| ValueKey | Value-based key | widgets/key_test.dart | pass | pass |
| UniqueKey | Unique widget key | widgets/key_test.dart | pass | pass |
| ChangeNotifier | State notification | widgets/changenotifier_test.dart | pass | pass |
| ValueNotifier | Single value state | widgets/changenotifier_test.dart | pass | pass |
| Animation | Animation base | widgets/animation_test.dart | pass | pass |
| AnimationController | Animation control | widgets/animation_test.dart | pass | pass |
| Tween | Value interpolation | widgets/animation_test.dart | pass | pass |
| Curve | Animation curve | widgets/animation_test.dart | pass | pass |

---

## material (60 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| MaterialApp | Material application | material/materialapp_test.dart | pass | pass |
| Scaffold | App structure | material/scaffold_test.dart | pass | pass |
| AppBar | Top app bar | widgets/appbar_test.dart | pass | pass |
| BottomNavigationBar | Bottom navigation | material/bottomnavigationbar_test.dart | pass | pass |
| NavigationBar | Navigation bar | material/navigation_test.dart | pass | pass |
| NavigationRail | Navigation rail | material/navigation_test.dart | pass | pass |
| NavigationDrawer | Navigation drawer | material/navigation_test.dart | pass | pass |
| Drawer | Side drawer | material/navigation_test.dart | pass | pass |
| FloatingActionButton | FAB | material/floatingactionbutton_test.dart | pass | pass |
| ElevatedButton | Elevated button | material/elevated_button_test.dart | pass | pass |
| TextButton | Text button | material/text_button_test.dart | pass | pass |
| OutlinedButton | Outlined button | material/buttons_test.dart | pass | pass |
| IconButton | Icon button | material/buttons_test.dart | pass | pass |
| FilledButton | Filled button | material/buttons_test.dart | pass | pass |
| Card | Card container | material/card_test.dart | pass | pass |
| ListTile | List tile | material/listtile_test.dart | pass | pass |
| Text | Text widget | widgets/text_test.dart | pass | pass |
| TextField | Text input | material/formcontrols_test.dart | pass | pass |
| TextFormField | Form text | material/formcontrols_test.dart | pass | pass |
| Checkbox | Checkbox | material/formcontrols_test.dart | pass | pass |
| Radio | Radio button | material/formcontrols_test.dart | pass | pass |
| Switch | Toggle switch | material/formcontrols_test.dart | pass | pass |
| Slider | Slider | material/formcontrols_test.dart | pass | pass |
| DropdownButton | Dropdown | material/dropdown_test.dart | pass | pass |
| DropdownMenu | Dropdown menu | material/dropdown_test.dart | pass | pass |
| PopupMenuButton | Popup menu | material/dropdown_test.dart | pass | pass |
| Dialog | Dialog base | material/dialog_test.dart | pass | pass |
| AlertDialog | Alert dialog | material/dialog_test.dart | pass | pass |
| SimpleDialog | Simple dialog | material/dialog_test.dart | pass | pass |
| BottomSheet | Bottom sheet | material/dialog_test.dart | pass | pass |
| SnackBar | Snackbar message | material/dialog_test.dart | pass | pass |
| MaterialBanner | Banner message | material/materialbanner_test.dart | pass | pass |
| TabBar | Tab bar | material/tabs_test.dart | pass | pass |
| Tab | Tab widget | material/tabs_test.dart | pass | pass |
| TabBarView | Tab content | material/tabs_test.dart | pass | pass |
| DefaultTabController | Tab controller | material/tabs_test.dart | pass | pass |
| Chip | Chip widget | material/chips_test.dart | pass | pass |
| InputChip | Input chip | material/chips_test.dart | pass | pass |
| FilterChip | Filter chip | material/chips_test.dart | pass | pass |
| ChoiceChip | Choice chip | material/chips_test.dart | pass | pass |
| ActionChip | Action chip | material/chips_test.dart | pass | pass |
| CircularProgressIndicator | Circular progress | material/progress_test.dart | pass | pass |
| LinearProgressIndicator | Linear progress | material/progress_test.dart | pass | pass |
| Tooltip | Tooltip | material/tooltip_badge_test.dart | pass | pass |
| Divider | Divider line | material/divider_test.dart | pass | pass |
| Icon | Icon display | material/icon_test.dart | pass | pass |
| Theme | Theme widget | material/theme_test.dart | pass | pass |
| ThemeData | Theme data | material/theme_test.dart | pass | pass |
| ColorScheme | Color scheme | material/theme_test.dart | pass | pass |
| MaterialColor | Material color | material/materialcolor_test.dart | pass | pass |
| MaterialAccentColor | Accent color | material/materialcolor_test.dart | pass | pass |
| TextTheme | Text theme | material/theme_test.dart | pass | pass |
| IconTheme | Icon theme | material/icontheme_test.dart | pass | pass |
| ButtonStyle | Button styling | material/buttonstyle_test.dart | pass | pass |
| InputDecoration | Input decoration | material/inputdecoration_test.dart | pass | pass |
| InputBorder | Input border | material/inputdecoration_test.dart | pass | pass |
| OutlineInputBorder | Outline border | material/inputdecoration_test.dart | pass | pass |
| UnderlineInputBorder | Underline border | material/inputdecoration_test.dart | pass | pass |
| SearchBar | Search bar | material/search_test.dart | pass | pass |
| SearchAnchor | Search anchor | material/search_test.dart | pass | pass |

---

## cupertino (45 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| CupertinoApp | iOS application | cupertino/cupertinoapp_test.dart | pass | pass |
| CupertinoPageScaffold | Page scaffold | cupertino/scaffold_test.dart | pass | pass |
| CupertinoTabScaffold | Tab scaffold | cupertino/scaffold_test.dart | pass | pass |
| CupertinoNavigationBar | Navigation bar | cupertino/scaffold_test.dart | pass | pass |
| CupertinoSliverNavigationBar | Sliver nav bar | cupertino/scaffold_test.dart | pass | pass |
| CupertinoTabBar | Tab bar | cupertino/scaffold_test.dart | pass | pass |
| CupertinoTabView | Tab view | cupertino/scaffold_test.dart | pass | pass |
| CupertinoButton | Button widget | cupertino/button_test.dart | pass | pass |
| CupertinoTextField | Text field | cupertino/textfield_test.dart | pass | pass |
| CupertinoSearchTextField | Search field | cupertino/textfield_test.dart | pass | pass |
| CupertinoAlertDialog | Alert dialog | cupertino/dialog_test.dart | pass | pass |
| CupertinoActionSheet | Action sheet | cupertino/dialog_test.dart | pass | pass |
| CupertinoActionSheetAction | Action item | cupertino/dialog_test.dart | pass | pass |
| CupertinoDialogAction | Dialog action | cupertino/dialog_test.dart | pass | pass |
| CupertinoPopupSurface | Popup surface | cupertino/dialog_test.dart | pass | pass |
| CupertinoPicker | Picker widget | cupertino/picker_test.dart | pass | pass |
| CupertinoDatePicker | Date picker | cupertino/picker_test.dart | pass | pass |
| CupertinoTimerPicker | Timer picker | cupertino/picker_test.dart | pass | pass |
| CupertinoTheme | Theme widget | cupertino/theme_test.dart | pass | pass |
| CupertinoThemeData | Theme data | cupertino/theme_test.dart | pass | pass |
| CupertinoTextThemeData | Text theme | cupertino/theme_test.dart | pass | pass |
| CupertinoColors | Color constants | cupertino/theme_test.dart | pass | pass |
| CupertinoDynamicColor | Dynamic color | cupertino/theme_test.dart | pass | pass |
| CupertinoSwitch | Toggle switch | cupertino/controls_test.dart | pass | pass |
| CupertinoSlider | Slider | cupertino/controls_test.dart | pass | pass |
| CupertinoActivityIndicator | Activity indicator | cupertino/controls_test.dart | pass | pass |
| CupertinoContextMenu | Context menu | cupertino/contextmenu_test.dart | pass | pass |
| CupertinoContextMenuAction | Menu action | cupertino/contextmenu_test.dart | pass | pass |
| CupertinoScrollbar | Scrollbar | cupertino/contextmenu_test.dart | pass | pass |
| CupertinoFormSection | Form section | cupertino/form_test.dart | pass | pass |
| CupertinoFormRow | Form row | cupertino/form_test.dart | pass | pass |
| CupertinoTextFormFieldRow | Text form row | cupertino/form_test.dart | pass | pass |
| CupertinoListSection | List section | cupertino/list_test.dart | pass | pass |
| CupertinoListTile | List tile | cupertino/list_test.dart | pass | pass |
| CupertinoCheckbox | Checkbox | cupertino/controls_test.dart | pass | pass |
| CupertinoRadio | Radio button | cupertino/controls_test.dart | pass | pass |
| CupertinoSlidingSegmentedControl | Segmented control | cupertino/segmented_test.dart | pass | pass |
| CupertinoSegmentedControl | Segmented control | cupertino/segmented_test.dart | pass | pass |
| showCupertinoDialog | Show dialog | cupertino/dialog_test.dart | pass | pass |
| showCupertinoModalPopup | Modal popup | cupertino/dialog_test.dart | pass | pass |
| CupertinoPageRoute | Page route | cupertino/route_test.dart | pass | pass |
| CupertinoPageTransition | Page transition | cupertino/route_test.dart | pass | pass |
| CupertinoFullscreenDialogTransition | Dialog transition | cupertino/route_test.dart | pass | pass |
| CupertinoIcons | Icon set | cupertino/icons_test.dart | pass | pass |
| CupertinoLocalizations | Localization | cupertino/icons_test.dart | pass | pass |

---

## foundation (8 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Key | Widget identity | foundation/key_test.dart | pass | pass |
| LocalKey | Local widget identity | foundation/key_test.dart | pass | pass |
| ValueKey | Value-based key | foundation/key_test.dart | pass | pass |
| UniqueKey | Unique widget key | foundation/key_test.dart | pass | pass |
| ChangeNotifier | State change notification | foundation/notifier_test.dart | pass | pass |
| ValueNotifier | Single value notification | foundation/notifier_test.dart | pass | pass |
| Listenable | Base listenable interface | foundation/notifier_test.dart | pass | pass |
| ValueListenable | Value listenable interface | foundation/notifier_test.dart | pass | pass |

---

## painting (18 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| EdgeInsets | Padding/margin | painting/edgeinsets_test.dart | pass | pass |
| EdgeInsetsDirectional | RTL-aware padding | painting/edgeinsets_test.dart | pass | pass |
| EdgeInsetsGeometry | Base padding class | painting/edgeinsets_test.dart | pass | pass |
| Alignment | Widget alignment | painting/alignment_test.dart | pass | pass |
| AlignmentDirectional | RTL-aware alignment | painting/alignment_test.dart | pass | pass |
| AlignmentGeometry | Base alignment class | painting/alignment_test.dart | pass | pass |
| BorderRadius | Corner rounding | painting/border_radius_test.dart | pass | pass |
| BorderRadiusDirectional | RTL-aware corners | painting/border_radius_test.dart | pass | pass |
| BorderRadiusGeometry | Base border radius | painting/border_radius_test.dart | pass | pass |
| BoxDecoration | Container styling | painting/box_decoration_test.dart | pass | pass |
| Border | Border styling | painting/border_test.dart | pass | pass |
| BorderSide | Individual border side | painting/border_test.dart | pass | pass |
| TextStyle | Text formatting | painting/textstyle_test.dart | pass | pass |
| TextSpan | Rich text spans | painting/textstyle_test.dart | pass | pass |
| AssetImage | Asset image loading | - | not-testable | D4rt sandbox lacks asset access |
| NetworkImage | URL image loading | - | not-testable | D4rt sandbox lacks network access |
| LinearGradient | Linear color gradients | painting/gradient_shadow_test.dart | pass | pass |
| BoxShadow | Drop shadows | painting/gradient_shadow_test.dart | pass | pass |

---

## rendering (25 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RenderBox | Box layout model | - | not-testable | Low-level render objects need render test harness |
| RenderObject | Base render object | - | not-testable | Low-level render objects need render test harness |
| BoxConstraints | Box layout constraints | rendering/boxconstraints_test.dart | pass | pass |
| EdgeInsets | Padding/margin | painting/edgeinsets_test.dart | pass | pass |
| EdgeInsetsGeometry | Base edge insets | painting/edgeinsets_test.dart | pass | pass |
| Alignment | Alignment positioning | painting/alignment_test.dart | pass | pass |
| AlignmentGeometry | Base alignment | painting/alignment_test.dart | pass | pass |
| BorderRadius | Corner rounding | painting/border_radius_test.dart | pass | pass |
| BoxDecoration | Box styling | painting/box_decoration_test.dart | pass | pass |
| RenderFlex | Flex layout (Row/Column) | - | not-testable | Low-level render objects need render test harness |
| RenderStack | Stack layout | - | not-testable | Low-level render objects need render test harness |
| RenderPadding | Padding render | - | not-testable | Low-level render objects need render test harness |
| RenderPositionedBox | Alignment render | - | not-testable | Low-level render objects need render test harness |
| RenderConstrainedBox | Constrained render | - | not-testable | Low-level render objects need render test harness |
| RenderDecoratedBox | Decorated render | - | not-testable | Low-level render objects need render test harness |
| PaintingContext | Painting context | - | not-testable | Low-level render objects need render test harness |
| BoxParentData | Box parent data | rendering/viewport_test.dart | pass | pass |
| Layer | Base layer | rendering/layers_test.dart | pass | pass |
| ContainerLayer | Layer container | rendering/layers_test.dart | pass | pass |
| OffsetLayer | Offset layer | rendering/layers_test.dart | pass | pass |
| PipelineOwner | Render pipeline | - | not-testable | Low-level render objects need render test harness |
| ViewConfiguration | View config | - | not-testable | Low-level render objects need render test harness |
| ViewportOffset | Scroll offset | rendering/viewport_test.dart | pass | pass |
| TextPainter | Text painting | rendering/textpainter_test.dart | pass | pass |
| TextStyle | Text styling | painting/textstyle_test.dart | pass | pass |

---

## animation (6 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AnimationController | Animation control | widgets/animation_test.dart | pass | pass |
| Animation | Base animation class | widgets/animation_test.dart | pass | pass |
| Curve | Easing curves | animation/curve_test.dart | pass | pass |
| CurvedAnimation | Animation with curve | animation/curve_test.dart | pass | pass |
| Tween | Value interpolation | animation/tween_test.dart | pass | pass |
| TickerProvider | Frame callbacks | scheduler/ticker_test.dart | pass | pass |

---

## gestures (10 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TapDownDetails | Tap down info | gestures/details_test.dart | pass | pass |
| TapUpDetails | Tap up info | gestures/details_test.dart | pass | pass |
| DragEndDetails | Drag end info | gestures/details_test.dart | pass | pass |
| DragUpdateDetails | Drag update info | gestures/details_test.dart | pass | pass |
| LongPressStartDetails | Long press start | gestures/details_test.dart | pass | pass |
| LongPressEndDetails | Long press end | gestures/details_test.dart | pass | pass |
| LongPressMoveUpdateDetails | Long press move | gestures/details_test.dart | pass | pass |
| ScaleStartDetails | Scale gesture start | gestures/details_test.dart | pass | pass |
| ScaleUpdateDetails | Scale gesture update | gestures/details_test.dart | pass | pass |
| ScaleEndDetails | Scale gesture end | gestures/details_test.dart | pass | pass |

---

## services (12 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Clipboard | System clipboard access | - | not-testable | Requires platform channel |
| ClipboardData | Clipboard content | - | not-testable | Requires platform channel |
| SystemChrome | System UI control | - | not-testable | Requires platform channel |
| SystemNavigator | System navigation | - | not-testable | Requires platform channel |
| SystemSound | System sounds | - | not-testable | Requires platform channel |
| HapticFeedback | Vibration feedback | - | not-testable | Requires platform channel |
| AssetBundle | Asset loading | - | not-testable | Requires platform channel |
| MethodChannel | Platform method calls | - | not-testable | Requires platform channel |
| MethodCall | Method invocation | - | not-testable | Requires platform channel |
| TextInputFormatter | Input formatting | services/textformatter_test.dart | pass | pass |
| FilteringTextInputFormatter | Text filtering | services/textformatter_test.dart | pass | pass |
| LengthLimitingTextInputFormatter | Length limits | services/textformatter_test.dart | pass | pass |

---

## dart:ui (17 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Color | Color representation | dart_ui/primitives_test.dart | pass | pass |
| Offset | 2D point positioning | dart_ui/primitives_test.dart | pass | pass |
| Size | Width/height dimensions | dart_ui/primitives_test.dart | pass | pass |
| Rect | Rectangle geometry | dart_ui/geometry_test.dart | pass | pass |
| RRect | Rounded rectangle | dart_ui/geometry_test.dart | pass | pass |
| Radius | Corner radius | dart_ui/primitives_test.dart | pass | pass |
| Paint | Drawing style/color | dart_ui/paint_test.dart | pass | pass |
| Path | Vector paths | dart_ui/geometry_test.dart | pass | pass |
| Canvas | Drawing surface | - | not-testable | Requires render context |
| Image | Bitmap images | - | not-testable | Requires asset/network access |
| TextStyle | Text styling | dart_ui/text_test.dart | pass | pass |
| Paragraph | Text layout | dart_ui/text_test.dart | pass | pass |
| ParagraphBuilder | Text construction | dart_ui/text_test.dart | pass | pass |
| Locale | Language/region | dart_ui/primitives_test.dart | pass | pass |
| FontWeight | Text weight | dart_ui/primitives_test.dart | pass | pass |
| Shadow | Drop shadows | dart_ui/primitives_test.dart | pass | pass |
| Gradient | Color gradients | dart_ui/paint_test.dart | pass | pass |

---

## semantics (4 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SemanticsProperties | Accessibility properties | semantics/semantics_test.dart | pass | pass |
| SemanticsConfiguration | Semantics config | semantics/semantics_test.dart | pass | pass |
| SemanticsNode | Accessibility tree node | - | not-testable | Low-level semantics API |
| CustomSemanticsAction | Custom a11y action | semantics/semantics_test.dart | pass | pass |

---

## scheduler (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TickerProvider | Frame tick provider | scheduler/ticker_test.dart | pass | pass |
| Ticker | Frame callback ticker | scheduler/ticker_test.dart | pass | pass |

---

## physics (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SpringDescription | Spring physics parameters | physics/spring_test.dart | pass | pass |
| Tolerance | Simulation tolerance | physics/spring_test.dart | pass | pass |

---

## proxies (5 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| D4rtCustomPainter | Proxy for CustomPainter delegate | proxies/custompaint_proxy_test.dart | pass | pass |
| D4rtCustomClipper | Proxy for CustomClipper delegate | proxies/customclipper_proxy_test.dart | pass | pass |
| D4rtFlowDelegate | Proxy for FlowDelegate | proxies/flowdelegate_proxy_test.dart | pass | pass |
| D4rtMultiChildLayoutDelegate | Proxy for MultiChildLayoutDelegate | proxies/multichildlayout_proxy_test.dart | pass | pass |
| D4rtSingleChildLayoutDelegate | Proxy for SingleChildLayoutDelegate | proxies/singlechildlayout_proxy_test.dart | pass | pass |

---

## Summary

| Package | Count | Testable | Pass | Not-testable |
|---------|-------|----------|------|--------------|
| widgets | 45 | 45 | 45 | 0 |
| material | 60 | 60 | 60 | 0 |
| cupertino | 45 | 45 | 45 | 0 |
| foundation | 8 | 8 | 8 | 0 |
| painting | 18 | 16 | 16 | 2 |
| rendering | 25 | 14 | 14 | 11 |
| animation | 6 | 6 | 6 | 0 |
| gestures | 10 | 10 | 10 | 0 |
| services | 12 | 3 | 3 | 9 |
| dart:ui | 17 | 15 | 15 | 2 |
| semantics | 4 | 3 | 3 | 1 |
| scheduler | 2 | 2 | 2 | 0 |
| physics | 2 | 2 | 2 | 0 |
| proxies | 5 | 5 | 5 | 0 |
| **Total** | **259** | **234** | **234** | **25** |
