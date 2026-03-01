# Test Plan: Essential Classes

**Priority: ESSENTIAL**
**Total classes: 254**

Core classes that must be tested first - used in virtually every Flutter application.

---

## widgets (45 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Container | All-in-one layout widget | widgets/container_test.dart | created | - |
| Center | Center alignment | widgets/center_test.dart | created | - |
| Padding | Padding wrapper | widgets/padding_test.dart | created | - |
| Align | Alignment wrapper | widgets/align_test.dart | created | - |
| Row | Horizontal layout | widgets/row_test.dart | created | - |
| Column | Vertical layout | widgets/column_test.dart | created | - |
| Expanded | Flex expansion | widgets/expanded_test.dart | created | - |
| Flexible | Flex sizing | widgets/flexible_test.dart | created | - |
| SizedBox | Fixed size box | widgets/sized_box_test.dart | created | - |
| Text | Text display | widgets/text_test.dart | created | - |
| RichText | Rich text display | widgets/richtext_test.dart | created | - |
| Icon | Icon display | widgets/icon_test.dart | created | - |
| Image | Image display | widgets/image_test.dart | created | - |
| Scaffold | App scaffold | widgets/scaffold_test.dart | created | - |
| AppBar | App bar | widgets/appbar_test.dart | created | - |
| ListView | Scrollable list | widgets/listview_test.dart | created | - |
| GridView | Scrollable grid | widgets/gridview_test.dart | created | - |
| SingleChildScrollView | Scrollable container | widgets/singlechildscrollview_test.dart | created | - |
| Stack | Layered layout | widgets/stack_test.dart | created | - |
| Positioned | Stack positioning | widgets/positioned_test.dart | created | - |
| GestureDetector | Gesture handling | widgets/gesturedetector_test.dart | created | - |
| InkWell | Material tap effect | widgets/inkwell_test.dart | created | - |
| Navigator | Navigation | widgets/navigator_test.dart | created | - |
| PageView | Page scrolling | widgets/pageview_test.dart | created | - |
| Form | Form container | widgets/form_test.dart | created | - |
| FormField | Form field base | widgets/form_test.dart | created | - |
| TextFormField | Text input field | widgets/form_test.dart | created | - |
| TextField | Basic text input | widgets/textfield_test.dart | created | - |
| EditableText | Low-level text edit | widgets/textfield_test.dart | created | - |
| FocusNode | Focus management | widgets/focusnode_test.dart | created | - |
| FocusScope | Focus scoping | widgets/focusnode_test.dart | created | - |
| StatelessWidget | Stateless base | widgets/statefulwidget_test.dart | created | - |
| StatefulWidget | Stateful base | widgets/statefulwidget_test.dart | created | - |
| State | Widget state | widgets/statefulwidget_test.dart | created | - |
| BuildContext | Build context | widgets/statefulwidget_test.dart | created | - |
| Key | Widget identity | widgets/key_test.dart | created | - |
| GlobalKey | Global widget key | widgets/key_test.dart | created | - |
| ValueKey | Value-based key | widgets/key_test.dart | created | - |
| UniqueKey | Unique widget key | widgets/key_test.dart | created | - |
| ChangeNotifier | State notification | widgets/changenotifier_test.dart | created | - |
| ValueNotifier | Single value state | widgets/changenotifier_test.dart | created | - |
| Animation | Animation base | widgets/animation_test.dart | created | - |
| AnimationController | Animation control | widgets/animation_test.dart | created | - |
| Tween | Value interpolation | widgets/animation_test.dart | created | - |
| Curve | Animation curve | widgets/animation_test.dart | created | - |

---

## material (60 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| MaterialApp | Material application | material/materialapp_test.dart | created | - |
| Scaffold | App structure | material/scaffold_test.dart | created | - |
| AppBar | Top app bar | widgets/appbar_test.dart | created | - |
| BottomNavigationBar | Bottom navigation | material/bottomnavigationbar_test.dart | created | - |
| NavigationBar | Navigation bar | material/navigation_test.dart | created | - |
| NavigationRail | Navigation rail | material/navigation_test.dart | created | - |
| NavigationDrawer | Navigation drawer | material/navigation_test.dart | created | - |
| Drawer | Side drawer | material/navigation_test.dart | created | - |
| FloatingActionButton | FAB | material/floatingactionbutton_test.dart | created | - |
| ElevatedButton | Elevated button | material/elevated_button_test.dart | created | - |
| TextButton | Text button | material/text_button_test.dart | created | - |
| OutlinedButton | Outlined button | material/buttons_test.dart | created | - |
| IconButton | Icon button | material/buttons_test.dart | created | - |
| FilledButton | Filled button | material/buttons_test.dart | created | - |
| Card | Card container | material/card_test.dart | created | - |
| ListTile | List tile | material/listtile_test.dart | created | - |
| Text | Text widget | widgets/text_test.dart | created | - |
| TextField | Text input | material/formcontrols_test.dart | created | - |
| TextFormField | Form text | material/formcontrols_test.dart | created | - |
| Checkbox | Checkbox | material/formcontrols_test.dart | created | - |
| Radio | Radio button | material/formcontrols_test.dart | created | - |
| Switch | Toggle switch | material/formcontrols_test.dart | created | - |
| Slider | Slider | material/formcontrols_test.dart | created | - |
| DropdownButton | Dropdown | material/dropdown_test.dart | created | - |
| DropdownMenu | Dropdown menu | material/dropdown_test.dart | created | - |
| PopupMenuButton | Popup menu | material/dropdown_test.dart | created | - |
| Dialog | Dialog base | material/dialog_test.dart | created | - |
| AlertDialog | Alert dialog | material/dialog_test.dart | created | - |
| SimpleDialog | Simple dialog | material/dialog_test.dart | created | - |
| BottomSheet | Bottom sheet | material/dialog_test.dart | created | - |
| SnackBar | Snackbar message | material/dialog_test.dart | created | - |
| MaterialBanner | Banner message | material/materialbanner_test.dart | created | - |
| TabBar | Tab bar | material/tabs_test.dart | created | - |
| Tab | Tab widget | material/tabs_test.dart | created | - |
| TabBarView | Tab content | material/tabs_test.dart | created | - |
| DefaultTabController | Tab controller | material/tabs_test.dart | created | - |
| Chip | Chip widget | material/chips_test.dart | created | - |
| InputChip | Input chip | material/chips_test.dart | created | - |
| FilterChip | Filter chip | material/chips_test.dart | created | - |
| ChoiceChip | Choice chip | material/chips_test.dart | created | - |
| ActionChip | Action chip | material/chips_test.dart | created | - |
| CircularProgressIndicator | Circular progress | material/progress_test.dart | created | - |
| LinearProgressIndicator | Linear progress | material/progress_test.dart | created | - |
| Tooltip | Tooltip | material/tooltip_badge_test.dart | created | - |
| Divider | Divider line | material/divider_test.dart | created | - |
| Icon | Icon display | material/icon_test.dart | created | - |
| Theme | Theme widget | material/theme_test.dart | created | - |
| ThemeData | Theme data | material/theme_test.dart | created | - |
| ColorScheme | Color scheme | material/theme_test.dart | created | - |
| MaterialColor | Material color | material/materialcolor_test.dart | created | - |
| MaterialAccentColor | Accent color | material/materialcolor_test.dart | created | - |
| TextTheme | Text theme | material/theme_test.dart | created | - |
| IconTheme | Icon theme | material/icontheme_test.dart | created | - |
| ButtonStyle | Button styling | material/buttonstyle_test.dart | created | - |
| InputDecoration | Input decoration | material/inputdecoration_test.dart | created | - |
| InputBorder | Input border | material/inputdecoration_test.dart | created | - |
| OutlineInputBorder | Outline border | material/inputdecoration_test.dart | created | - |
| UnderlineInputBorder | Underline border | material/inputdecoration_test.dart | created | - |
| SearchBar | Search bar | material/search_test.dart | created | - |
| SearchAnchor | Search anchor | material/search_test.dart | created | - |

---

## cupertino (45 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| CupertinoApp | iOS application | cupertino/cupertinoapp_test.dart | created | - |
| CupertinoPageScaffold | Page scaffold | cupertino/scaffold_test.dart | created | - |
| CupertinoTabScaffold | Tab scaffold | cupertino/scaffold_test.dart | created | - |
| CupertinoNavigationBar | Navigation bar | cupertino/scaffold_test.dart | created | - |
| CupertinoSliverNavigationBar | Sliver nav bar | cupertino/scaffold_test.dart | created | - |
| CupertinoTabBar | Tab bar | cupertino/scaffold_test.dart | created | - |
| CupertinoTabView | Tab view | cupertino/scaffold_test.dart | created | - |
| CupertinoButton | Button widget | cupertino/button_test.dart | created | - |
| CupertinoTextField | Text field | cupertino/textfield_test.dart | created | - |
| CupertinoSearchTextField | Search field | cupertino/textfield_test.dart | created | - |
| CupertinoAlertDialog | Alert dialog | cupertino/dialog_test.dart | created | - |
| CupertinoActionSheet | Action sheet | cupertino/dialog_test.dart | created | - |
| CupertinoActionSheetAction | Action item | cupertino/dialog_test.dart | created | - |
| CupertinoDialogAction | Dialog action | cupertino/dialog_test.dart | created | - |
| CupertinoPopupSurface | Popup surface | cupertino/dialog_test.dart | created | - |
| CupertinoPicker | Picker widget | cupertino/picker_test.dart | created | - |
| CupertinoDatePicker | Date picker | cupertino/picker_test.dart | created | - |
| CupertinoTimerPicker | Timer picker | cupertino/picker_test.dart | created | - |
| CupertinoTheme | Theme widget | cupertino/theme_test.dart | created | - |
| CupertinoThemeData | Theme data | cupertino/theme_test.dart | created | - |
| CupertinoTextThemeData | Text theme | cupertino/theme_test.dart | created | - |
| CupertinoColors | Color constants | cupertino/theme_test.dart | created | - |
| CupertinoDynamicColor | Dynamic color | cupertino/theme_test.dart | created | - |
| CupertinoSwitch | Toggle switch | cupertino/controls_test.dart | created | - |
| CupertinoSlider | Slider | cupertino/controls_test.dart | created | - |
| CupertinoActivityIndicator | Activity indicator | cupertino/controls_test.dart | created | - |
| CupertinoContextMenu | Context menu | cupertino/contextmenu_test.dart | created | - |
| CupertinoContextMenuAction | Menu action | cupertino/contextmenu_test.dart | created | - |
| CupertinoScrollbar | Scrollbar | cupertino/contextmenu_test.dart | created | - |
| CupertinoFormSection | Form section | cupertino/form_test.dart | created | - |
| CupertinoFormRow | Form row | cupertino/form_test.dart | created | - |
| CupertinoTextFormFieldRow | Text form row | cupertino/form_test.dart | created | - |
| CupertinoListSection | List section | cupertino/list_test.dart | created | - |
| CupertinoListTile | List tile | cupertino/list_test.dart | created | - |
| CupertinoCheckbox | Checkbox | cupertino/controls_test.dart | created | - |
| CupertinoRadio | Radio button | cupertino/controls_test.dart | created | - |
| CupertinoSlidingSegmentedControl | Segmented control | cupertino/segmented_test.dart | created | - |
| CupertinoSegmentedControl | Segmented control | cupertino/segmented_test.dart | created | - |
| showCupertinoDialog | Show dialog | cupertino/dialog_test.dart | created | - |
| showCupertinoModalPopup | Modal popup | cupertino/dialog_test.dart | created | - |
| CupertinoPageRoute | Page route | cupertino/route_test.dart | created | - |
| CupertinoPageTransition | Page transition | cupertino/route_test.dart | created | - |
| CupertinoFullscreenDialogTransition | Dialog transition | cupertino/route_test.dart | created | - |
| CupertinoIcons | Icon set | cupertino/icons_test.dart | created | - |
| CupertinoLocalizations | Localization | cupertino/icons_test.dart | created | - |

---

## foundation (8 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Key | Widget identity | foundation/key_test.dart | created | - |
| LocalKey | Local widget identity | foundation/key_test.dart | created | - |
| ValueKey | Value-based key | foundation/key_test.dart | created | - |
| UniqueKey | Unique widget key | foundation/key_test.dart | created | - |
| ChangeNotifier | State change notification | foundation/notifier_test.dart | created | - |
| ValueNotifier | Single value notification | foundation/notifier_test.dart | created | - |
| Listenable | Base listenable interface | foundation/notifier_test.dart | created | - |
| ValueListenable | Value listenable interface | foundation/notifier_test.dart | created | - |

---

## painting (18 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| EdgeInsets | Padding/margin | painting/edgeinsets_test.dart | created | - |
| EdgeInsetsDirectional | RTL-aware padding | painting/edgeinsets_test.dart | created | - |
| EdgeInsetsGeometry | Base padding class | painting/edgeinsets_test.dart | created | - |
| Alignment | Widget alignment | painting/alignment_test.dart | created | - |
| AlignmentDirectional | RTL-aware alignment | painting/alignment_test.dart | created | - |
| AlignmentGeometry | Base alignment class | painting/alignment_test.dart | created | - |
| BorderRadius | Corner rounding | painting/border_radius_test.dart | created | - |
| BorderRadiusDirectional | RTL-aware corners | painting/border_radius_test.dart | created | - |
| BorderRadiusGeometry | Base border radius | painting/border_radius_test.dart | created | - |
| BoxDecoration | Container styling | painting/box_decoration_test.dart | created | - |
| Border | Border styling | painting/border_test.dart | created | - |
| BorderSide | Individual border side | painting/border_test.dart | created | - |
| TextStyle | Text formatting | painting/textstyle_test.dart | created | - |
| TextSpan | Rich text spans | painting/textstyle_test.dart | created | - |
| AssetImage | Asset image loading | - | not-testable | D4rt sandbox lacks asset access |
| NetworkImage | URL image loading | - | not-testable | D4rt sandbox lacks network access |
| LinearGradient | Linear color gradients | painting/gradient_shadow_test.dart | created | - |
| BoxShadow | Drop shadows | painting/gradient_shadow_test.dart | created | - |

---

## rendering (25 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RenderBox | Box layout model | - | not-testable | Low-level render objects need render test harness |
| RenderObject | Base render object | - | not-testable | Low-level render objects need render test harness |
| BoxConstraints | Box layout constraints | rendering/boxconstraints_test.dart | created | - |
| EdgeInsets | Padding/margin | painting/edgeinsets_test.dart | created | - |
| EdgeInsetsGeometry | Base edge insets | painting/edgeinsets_test.dart | created | - |
| Alignment | Alignment positioning | painting/alignment_test.dart | created | - |
| AlignmentGeometry | Base alignment | painting/alignment_test.dart | created | - |
| BorderRadius | Corner rounding | painting/border_radius_test.dart | created | - |
| BoxDecoration | Box styling | painting/box_decoration_test.dart | created | - |
| RenderFlex | Flex layout (Row/Column) | - | not-testable | Low-level render objects need render test harness |
| RenderStack | Stack layout | - | not-testable | Low-level render objects need render test harness |
| RenderPadding | Padding render | - | not-testable | Low-level render objects need render test harness |
| RenderPositionedBox | Alignment render | - | not-testable | Low-level render objects need render test harness |
| RenderConstrainedBox | Constrained render | - | not-testable | Low-level render objects need render test harness |
| RenderDecoratedBox | Decorated render | - | not-testable | Low-level render objects need render test harness |
| PaintingContext | Painting context | - | not-testable | Low-level render objects need render test harness |
| BoxParentData | Box parent data | rendering/viewport_test.dart | created | - |
| Layer | Base layer | rendering/layers_test.dart | created | - |f
| ContainerLayer | Layer container | rendering/layers_test.dart | created | - |
| OffsetLayer | Offset layer | rendering/layers_test.dart | created | - |
| PipelineOwner | Render pipeline | - | not-testable | Low-level render objects need render test harness |
| ViewConfiguration | View config | - | not-testable | Low-level render objects need render test harness |
| ViewportOffset | Scroll offset | rendering/viewport_test.dart | created | - |
| TextPainter | Text painting | rendering/textpainter_test.dart | created | - |
| TextStyle | Text styling | painting/textstyle_test.dart | created | - |

---

## animation (6 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AnimationController | Animation control | widgets/animation_test.dart | created | - |
| Animation | Base animation class | widgets/animation_test.dart | created | - |
| Curve | Easing curves | animation/curve_test.dart | created | - |
| CurvedAnimation | Animation with curve | animation/curve_test.dart | created | - |
| Tween | Value interpolation | animation/tween_test.dart | created | - |
| TickerProvider | Frame callbacks | scheduler/ticker_test.dart | created | - |

---

## gestures (10 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TapDownDetails | Tap down info | gestures/details_test.dart | created | - |
| TapUpDetails | Tap up info | gestures/details_test.dart | created | - |
| DragEndDetails | Drag end info | gestures/details_test.dart | created | - |
| DragUpdateDetails | Drag update info | gestures/details_test.dart | created | - |
| LongPressStartDetails | Long press start | gestures/details_test.dart | created | - |
| LongPressEndDetails | Long press end | gestures/details_test.dart | created | - |
| LongPressMoveUpdateDetails | Long press move | gestures/details_test.dart | created | - |
| ScaleStartDetails | Scale gesture start | gestures/details_test.dart | created | - |
| ScaleUpdateDetails | Scale gesture update | gestures/details_test.dart | created | - |
| ScaleEndDetails | Scale gesture end | gestures/details_test.dart | created | - |

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
| TextInputFormatter | Input formatting | services/textformatter_test.dart | created | - |
| FilteringTextInputFormatter | Text filtering | services/textformatter_test.dart | created | - |
| LengthLimitingTextInputFormatter | Length limits | services/textformatter_test.dart | created | - |

---

## dart:ui (17 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Color | Color representation | dart_ui/primitives_test.dart | created | - |
| Offset | 2D point positioning | dart_ui/primitives_test.dart | created | - |
| Size | Width/height dimensions | dart_ui/primitives_test.dart | created | - |
| Rect | Rectangle geometry | dart_ui/geometry_test.dart | created | - |
| RRect | Rounded rectangle | dart_ui/geometry_test.dart | created | - |
| Radius | Corner radius | dart_ui/primitives_test.dart | created | - |
| Paint | Drawing style/color | dart_ui/paint_test.dart | created | - |
| Path | Vector paths | dart_ui/geometry_test.dart | created | - |
| Canvas | Drawing surface | - | not-testable | Requires render context |
| Image | Bitmap images | - | not-testable | Requires asset/network access |
| TextStyle | Text styling | dart_ui/text_test.dart | created | - |
| Paragraph | Text layout | dart_ui/text_test.dart | created | - |
| ParagraphBuilder | Text construction | dart_ui/text_test.dart | created | - |
| Locale | Language/region | dart_ui/primitives_test.dart | created | - |
| FontWeight | Text weight | dart_ui/primitives_test.dart | created | - |
| Shadow | Drop shadows | dart_ui/primitives_test.dart | created | - |
| Gradient | Color gradients | dart_ui/paint_test.dart | created | - |

---

## semantics (4 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SemanticsProperties | Accessibility properties | semantics/semantics_test.dart | created | - |
| SemanticsConfiguration | Semantics config | semantics/semantics_test.dart | created | - |
| SemanticsNode | Accessibility tree node | - | not-testable | Low-level semantics API |
| CustomSemanticsAction | Custom a11y action | semantics/semantics_test.dart | created | - |

---

## scheduler (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TickerProvider | Frame tick provider | scheduler/ticker_test.dart | created | - |
| Ticker | Frame callback ticker | scheduler/ticker_test.dart | created | - |

---

## physics (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SpringDescription | Spring physics parameters | physics/spring_test.dart | created | - |
| Tolerance | Simulation tolerance | physics/spring_test.dart | created | - |

---

## Summary

| Package | Count |
|---------|-------|
| widgets | 45 |
| material | 60 |
| cupertino | 45 |
| foundation | 8 |
| painting | 18 |
| rendering | 25 |
| animation | 6 |
| gestures | 10 |
| services | 12 |
| dart:ui | 17 |
| semantics | 4 |
| scheduler | 2 |
| physics | 2 |
| **Total** | **254** |
