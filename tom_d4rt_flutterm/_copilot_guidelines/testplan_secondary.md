# Test Plan: Secondary Classes

**Priority: SECONDARY**
**Total classes: ~1,573**
**Covered so far: ~757 classes in 121 scripts (Batches 1-5)**

Specialized classes for advanced use cases - test after essential and important classes.

---

## Batch 1 Progress (38 scripts created)

| Package | Script | Classes Covered | Status |
|---------|--------|-----------------|--------|
| animation | animation_status_test.dart | AnimationStatus, AnimationMax, AnimationMin, AnimationMean | CREATED |
| cupertino | cupertino_secondary_test.dart | CupertinoColors, CupertinoDynamicColor, CupertinoDialogAction, CupertinoActionSheetAction, CupertinoFormRow | CREATED |
| dart_ui | enums_ui_test.dart | Clip, PathFillType, PathOperation, StrokeCap, StrokeJoin, PaintingStyle, BlendMode, TileMode, VertexMode, PointMode, ImageByteFormat, PixelFormat, Brightness, AppLifecycleState, PointerDeviceKind, PointerSignalKind, Locale | CREATED |
| foundation | targetplatform_test.dart | TargetPlatform, defaultTargetPlatform | CREATED |
| foundation | synchronousfuture_test.dart | SynchronousFuture, Factory | CREATED |
| foundation | observer_list_test.dart | ObserverList, HashedObserverList | CREATED |
| foundation | buffers_misc_test.dart | BitField, WriteBuffer, ReadBuffer, Category | CREATED |
| gestures | scale_details_test.dart | ScaleStartDetails, ScaleUpdateDetails, ScaleEndDetails, LongPressStartDetails, LongPressMoveUpdateDetails, LongPressEndDetails | CREATED |
| material | texttheme_test.dart | TextTheme, Typography, VisualDensity, MaterialTapTargetSize | CREATED |
| material | buttonstyle_popup_test.dart | ButtonStyle, WidgetStateProperty, WidgetState, PopupMenuButton, PopupMenuItem, PopupMenuDivider | CREATED |
| material | chip_variants_test.dart | ActionChip, FilterChip, ChoiceChip, InputChip, ChipThemeData | CREATED |
| material | fablocation_messenger_test.dart | FloatingActionButtonLocation, SnackBarBehavior, SnackBarClosedReason, SnackBarAction, MaterialBannerClosedReason, TabBarIndicatorSize | CREATED |
| material | datetime_utils_test.dart | DateUtils, DateTimeRange, TimeOfDay, DatePickerEntryMode, TimePickerEntryMode, DayPeriod, TimeOfDayFormat, HourFormat | CREATED |
| painting | enums_painting_test.dart | TextOverflow, BoxFit, ImageRepeat, FilterQuality, TextWidthBasis, Clip, AxisDirection, GrowthDirection, ScrollDirection | CREATED |
| painting | gradient_transform_test.dart | GradientRotation, GradientTransform, LinearGradient, RadialGradient, SweepGradient | CREATED |
| painting | matrixutils_test.dart | MatrixUtils (transformPoint, transformRect, getAsTranslation, getAsScale, isIdentity, forceToPoint) | CREATED |
| painting | notched_shapes_test.dart | CircularNotchedRectangle | CREATED |
| painting | image_cache_test.dart | ImageCache, ImageConfiguration | CREATED |
| painting | imagestream_misc_test.dart | PlaceholderDimensions, PlaceholderAlignment, Accumulator, InlineSpanSemanticsInformation, ImageChunkEvent, ImageConfiguration | CREATED |
| physics | springdescription_test.dart | SpringDescription, SpringDescription.withDampingRatio, BoundedFrictionSimulation | CREATED |
| rendering | hittest_pipeline_test.dart | BoxConstraints (advanced), LayerLink, LayerHandle, OffsetLayer | CREATED |
| scheduler | scheduler_misc_test.dart | SchedulerPhase, Priority | CREATED |
| semantics | semantics_properties_test.dart | SemanticsProperties, CustomSemanticsAction, OrdinalSortKey, SemanticsTag, SemanticsHintOverrides | CREATED |
| services | system_chrome_test.dart | DeviceOrientation, SystemUiMode, SystemUiOverlay, SystemSoundType, MaxLengthEnforcement, SmartDashesType, SmartQuotesType, TextInputType, TextInputAction, ApplicationSwitcherDescription | CREATED |
| services | text_editing_value_test.dart | TextEditingValue, TextSelection, TextRange, ClipboardData, FilteringTextInputFormatter, LengthLimitingTextInputFormatter | CREATED |
| widgets | placeholder_test.dart | Placeholder | CREATED |
| widgets | defaulttextstyle_test.dart | DefaultTextStyle, AnimatedDefaultTextStyle | CREATED |
| widgets | textspan_test.dart | TextSpan, WidgetSpan, RichText | CREATED |
| widgets | keyedsubtree_test.dart | KeyedSubtree, AnnotatedRegion | CREATED |
| widgets | scrollphysics_test.dart | ScrollPhysics, BouncingScrollPhysics, ClampingScrollPhysics, NeverScrollableScrollPhysics, AlwaysScrollableScrollPhysics, PageScrollPhysics, RangeMaintainingScrollPhysics | CREATED |
| widgets | preferredsize_test.dart | PreferredSize, GridPaper, PopScope | CREATED |
| widgets | physicalmodel_test.dart | PhysicalModel, PhysicalShape, ColorFiltered | CREATED |
| widgets | focus_properties_test.dart | FocusScopeNode, FocusHighlightMode, FocusHighlightStrategy, FocusNode (advanced) | CREATED |
| widgets | shaderfilter_test.dart | ShaderMask, BackdropFilter, ImageFiltered, ColorFiltered, CheckedModeBanner | CREATED |
| widgets | shortcuts_actions_test.dart | SingleActivator, CharacterActivator, LogicalKeySet, ActivateIntent, DismissIntent, ScrollIntent, DoNothingAction, VoidCallbackIntent, CallbackShortcuts | CREATED |
| widgets | sliver_delegates_test.dart | SliverChildBuilderDelegate, SliverChildListDelegate, SliverSafeArea, SliverVisibility, SliverIgnorePointer | CREATED |
| widgets | restorable_values_test.dart | RestorableInt, RestorableIntN, RestorableDouble, RestorableDoubleN, RestorableBool, RestorableBoolN, RestorableString, RestorableStringN, RestorableDateTime, RestorableDateTimeN, RestorableTextEditingController | CREATED |
| widgets | scrollbar_layout_misc_test.dart | PageStorageKey, TraversalDirection, NumericFocusOrder, LexicalFocusOrder, SizeChangedLayoutNotification, OrientationBuilder, FocusTraversalGroup, OrderedTraversalPolicy | CREATED |

---

## Batch 2 Progress (29 scripts created — widgets + material)

| Package | Script | Classes Covered | Status |
|---------|--------|-----------------|--------|
| widgets | scroll_behavior_test.dart | ScrollConfiguration, ScrollBehavior, MaterialScrollBehavior, PrimaryScrollController, PageStorage, PageStorageBucket, ScrollViewKeyboardDismissBehavior (7) | CREATED |
| widgets | scroll_metrics_test.dart | FixedScrollMetrics, ScrollDirection, ScrollIncrementDetails, ScrollIncrementType, ScrollNotification types (9) | CREATED |
| widgets | sliver_advanced_test.dart | SliverAnimatedList, SliverAnimatedOpacity, SliverLayoutBuilder, SliverPrototypeExtentList, SliverReorderableList, ReorderableDragStartListener (6) | CREATED |
| widgets | display_feature_test.dart | DisplayFeature types (4) | CREATED |
| widgets | restoration_scope_test.dart | RestorationScope, RootRestorationScope, RestorableNum, RestorableNumN (8) | CREATED |
| widgets | undo_history_test.dart | UndoHistoryController, UndoHistoryValue (2) | CREATED |
| widgets | actions_intents_test.dart | SelectIntent, NextFocusIntent, PreviousFocusIntent, DirectionalFocusIntent, PrioritizedIntents, ActionDispatcher, actions (11) | CREATED |
| widgets | text_selection_widgets_test.dart | TextSelectionTheme, TextSelectionThemeData, TextSelectionHandleType (3) | CREATED |
| widgets | autofill_context_test.dart | AutofillGroup, AutofillHints, AutofillContextAction (3) | CREATED |
| widgets | context_menu_test.dart | AdaptiveTextSelectionToolbar, ContextMenuButtonItem, ContextMenuButtonType, TextSelectionToolbarAnchors (5) | CREATED |
| widgets | text_magnifier_test.dart | MagnifierDecoration, MagnifierController, TextMagnifierConfiguration (3) | CREATED |
| widgets | notification_locale_test.dart | SizeChangedLayoutNotifier, DefaultWidgetsLocalizations, NotificationListener, KeepAlive (4) | CREATED |
| widgets | focus_traversal_advanced_test.dart | traversal policies, focus orders, TraversalDirection (7) | CREATED |
| widgets | raw_widgets_test.dart | RawScrollbar, DefaultAssetBundle, PopScope, ValueNotifier/InheritedNotifier (5) | CREATED |
| widgets | editable_text_misc_test.dart | EditableText, SpellCheckConfiguration, TextInputType, TextCapitalization (4) | CREATED |
| material | input_borders_test.dart | InputDecorationTheme, OutlineInputBorder, UnderlineInputBorder, FloatingLabelBehavior, FloatingLabelAlignment (6) | CREATED |
| material | button_types_test.dart | MaterialType, ButtonBar, ButtonBarThemeData, ButtonTextTheme, ButtonBarLayoutBehavior, ThemeDataTween (6) | CREATED |
| material | scaffold_advanced_test.dart | FloatingActionButtonAnimator, MaterialBanner, SnackBar, DismissDirection (4) | CREATED |
| material | tab_indicator_test.dart | UnderlineTabIndicator, TabBarIndicatorSize, TabAlignment (4) | CREATED |
| material | popup_advanced_test.dart | CheckedPopupMenuItem, PopupMenuDivider, PopupMenuThemeData, PopupMenuPosition (5) | CREATED |
| material | autocomplete_datepicker_test.dart | Autocomplete, RawAutocomplete, DatePickerMode, RestorableTimeOfDay (4) | CREATED |
| material | chip_attributes_test.dart | RawChip, Chip advanced, ChipTheme (3) | CREATED |
| material | color_scheme_test.dart | ColorScheme, MaterialColor, MaterialAccentColor (3) | CREATED |
| material | dialog_advanced_test.dart | SimpleDialog, SimpleDialogOption, DialogThemeData, AlertDialog (4) | CREATED |
| material | divider_listtile_test.dart | Divider, VerticalDivider, DividerThemeData, ListTileStyle, ListTileThemeData (7) | CREATED |
| material | menu_advanced_test.dart | MenuStyle, MenuThemeData, MenuItemButton, SubmenuButton, MenuAnchor (5) | CREATED |
| material | progress_sheet_test.dart | LinearProgressIndicator, CircularProgressIndicator, ProgressIndicatorThemeData, BottomSheetThemeData (5) | CREATED |
| material | tooltip_feedback_test.dart | Tooltip, TooltipThemeData, TooltipTriggerMode, InkResponse, Feedback (5) | CREATED |
| material | expansion_stepper_test.dart | ExpansionTile, StepState, StepperType, Step, Stepper (6) | CREATED |

---

## Batch 3 Progress (22 scripts created — cupertino, rendering, gestures, services, dart:ui, semantics, painting, material)

| Package | Script | Classes Covered | Status |
|---------|--------|-----------------|--------|
| cupertino | cupertino_nav_segmented_test.dart | CupertinoSliverNavigationBar, CupertinoNavigationBarBackButtonMode, CupertinoSlidingSegmentedControl, CupertinoSegmentedControl (4) | CREATED |
| cupertino | cupertino_form_scroll_test.dart | CupertinoTextFormFieldRow, CupertinoListTile, CupertinoListTileChevron, CupertinoScrollbar, CupertinoPopupSurface, CupertinoContextMenuAction (6) | CREATED |
| cupertino | cupertino_controls_advanced_test.dart | CupertinoSwitch, CupertinoSlider, CupertinoActivityIndicator, CupertinoSearchTextField, OverlayVisibilityMode (5) | CREATED |
| cupertino | cupertino_picker_advanced_test.dart | CupertinoPicker, CupertinoTimerPicker, CupertinoTimerPickerMode, CupertinoDatePickerMode, CupertinoDatePicker, CupertinoPickerDefaultSelectionOverlay (6) | CREATED |
| cupertino | cupertino_theming_test.dart | CupertinoDynamicColor (15 colors), CupertinoThemeData, CupertinoTextThemeData, CupertinoTheme (~19) | CREATED |
| cupertino | cupertino_sections_test.dart | CupertinoFormSection, CupertinoListSection, CupertinoListTile.notched (5) | CREATED |
| rendering | render_box_types_test.dart | RenderPadding, RenderPositionedBox, RenderConstrainedBox, BoxConstraints, RenderFlex, BoxParentData (6) | CREATED |
| rendering | render_pointer_test.dart | RenderAbsorbPointer, RenderIgnorePointer, RenderRepaintBoundary, RenderOffstage, BoxHitTestResult, AnnotationEntry, AnnotationResult (7) | CREATED |
| rendering | layer_types_test.dart | ContainerLayer, OffsetLayer, LeaderLayer, FollowerLayer, LayerLink, LayerHandle (6) | CREATED |
| rendering | render_composite_test.dart | StackFit, Clip, PhysicalModel, AnimatedOpacity, Stack, IndexedStack (6) | CREATED |
| gestures | velocity_drag_test.dart | VelocityEstimate, VelocityTracker, IOSScrollViewFlingVelocityTracker, DragStartBehavior, DragDown/Start/Update/EndDetails, LongPressStart/MoveUpdate/EndDetails (11) | CREATED |
| gestures | tap_force_test.dart | TapDownDetails, TapUpDetails, ForcePressDetails, PointerDeviceKind, GestureDisposition, Velocity, ScaleStartDetails, ScaleUpdateDetails (8) | CREATED |
| services | services_advanced_test.dart | LogicalKeyboardKey extended, PhysicalKeyboardKey, HapticFeedback, SystemChrome, SystemUiOverlayStyle, SystemUiMode, DeviceOrientation, SystemNavigator, LengthLimitingTextInputFormatter, FilteringTextInputFormatter, MaxLengthEnforcement (11) | CREATED |
| services | platform_channels_test.dart | MethodChannel, OptionalMethodChannel, BasicMessageChannel, EventChannel, StringCodec, JSONMessageCodec, StandardMessageCodec, StandardMethodCodec, MethodCall, PlatformException, MissingPluginException, BinaryCodec (12) | CREATED |
| dart_ui | dart_ui_advanced_test.dart | SemanticsAction, SemanticsFlag, FontFeature, FontVariation, Locale, TextDecoration (6+) | CREATED |
| dart_ui | dart_ui_paint_canvas_test.dart | BlendMode, FilterQuality, StrokeCap, StrokeJoin, PathFillType, BlurStyle, TileMode, Clip, PointMode, PaintingStyle, Paint, MaskFilter, Path (13) | CREATED |
| semantics | semantics_events_test.dart | AnnounceSemanticsEvent, TooltipSemanticsEvent, LongPressSemanticsEvent, TapSemanticEvent, Assertiveness, SemanticsService, CustomSemanticsAction, OrdinalSortKey (8) | CREATED |
| semantics | semantics_config_test.dart | SemanticsConfiguration, Semantics, MergeSemantics, ExcludeSemantics, BlockSemantics, SemanticsDebugger (6) | CREATED |
| painting | advanced_decorations_test.dart | ImageFilter, ColorFilter, SweepGradient, RadialGradient, TextHeightBehavior, TextLeadingDistribution, StrutStyle, TextSpan, WidgetSpan, PlaceholderAlignment (10) | CREATED |
| material | nav_badge_advanced_test.dart | Badge, BadgeThemeData, NavigationDrawer, NavigationDrawerDestination, NavigationDrawerThemeData, NavigationRailLabelType, NavigationRailThemeData (7) | CREATED |
| material | search_filled_test.dart | SearchController, SearchBarThemeData, SearchViewThemeData, FilledButton variants, FilledButtonThemeData, OutlinedButton.icon, TextButton.icon (9) | CREATED |
| material | themes_advanced_test.dart | BottomNavigationBarType, BottomNavigationBarThemeData, BottomNavigationBarLandscapeLayout, AppBarTheme, DrawerThemeData, IconButtonThemeData, FloatingActionButtonThemeData (7) | CREATED |

---

## Batch 4 Progress (16 scripts created — widgets, material, cupertino, rendering)

| Package | Script | Classes Covered | Status |
|---------|--------|-----------------|--------|
| widgets | scroll_notifications_adv_test.dart | ScrollStartNotification, ScrollUpdateNotification, ScrollEndNotification, OverscrollNotification, UserScrollNotification, OverscrollIndicatorNotification, ScrollMetricsNotification (7) | CREATED |
| widgets | inherited_model_test.dart | InheritedModel, InheritedWidget, InheritedNotifier, ValueListenableBuilder, ValueNotifier, ListenableBuilder, AnimatedBuilder (7) | CREATED |
| widgets | table_wrap_flow_test.dart | Table, TableRow, TableCell, Wrap, Flow, FlowDelegate, TableBorder (7+) | CREATED |
| widgets | overlay_portal_test.dart | OverlayPortal, OverlayPortalController, Overlay, OverlayEntry, CompositedTransformTarget, CompositedTransformFollower (6) | CREATED |
| widgets | gesture_detector_adv_test.dart | GestureDetector advanced, DragTarget, LongPressDraggable, Draggable, DragAnchorStrategy, RawGestureDetector, GestureRecognizerFactory (7) | CREATED |
| widgets | media_query_adv_test.dart | MediaQueryData, MediaQuery, DeviceGestureSettings, FlexibleSpaceBarSettings, Orientation, NavigatorState, NavigationMode (7) | CREATED |
| widgets | route_observer_test.dart | RouteObserver, NavigatorObserver, RouteSettings, MaterialPageRoute advanced, RouteAware, ModalRoute, TransitionRoute (7) | CREATED |
| widgets | interactive_viewer_test.dart | InteractiveViewer, TransformationController, Matrix4 usage, GestureRecognizer types, PointerScrollEvent, ScaleGestureRecognizer, PanGestureRecognizer, DoubleTapGestureRecognizer (8) | CREATED |
| material | scaffold_internals_test.dart | ScaffoldMessenger, ScaffoldMessengerState, ScaffoldFeatureController, PersistentBottomSheetController, FloatingActionButtonAnimator, EndDockedFabLocation, EndFloatFabLocation (7) | CREATED |
| material | fab_location_types_test.dart | FloatingActionButtonLocation types (startTop, miniStartTop, centerTop, endTop, startFloat, miniStartFloat, centerFloat, endFloat) (8) | CREATED |
| material | data_table_test.dart | DataTable, DataRow, DataCell, DataColumn, PaginatedDataTable, DataTableSource, DataTableThemeData (8) | CREATED |
| material | toggle_segmented_test.dart | ToggleButtons, SegmentedButton, ButtonSegment, ToggleButtonsThemeData, MaterialStateBorderSide, MaterialStateTextStyle, ButtonBar (7) | CREATED |
| material | reorderable_material_test.dart | ReorderableListView, ReorderableDragStartListener, ReorderableDelayedDragStartListener, InkWell advanced, InkResponse, Material widget, MaterialType (7) | CREATED |
| material | search_anchor_test.dart | SearchAnchor, SearchBar, SearchController, SearchBarThemeData, SearchViewThemeData, SearchAnchor.bar, DropdownMenuEntry (7) | CREATED |
| cupertino | cupertino_refresh_mag_test.dart | CupertinoSliverRefreshControl, CupertinoMagnifier, CupertinoPageTransition, CupertinoFullscreenDialogTransition, CupertinoTabController, CupertinoTabScaffold, CupertinoTabView (7) | CREATED |
| rendering | render_objects_misc_test.dart | CustomPaint, CustomPainter, CustomClipper<Rect>, CustomClipper<Path>, MouseRegion advanced, Listener advanced, DecoratedBox (7) | CREATED |

---

## Batch 5 Progress (16 scripts created — widgets, material, cupertino, rendering, services, dart_ui)

| Package | Script | Classes Covered | Status |
|---------|--------|-----------------|--------|
| widgets | animated_widgets_adv_test.dart | AnimatedSwitcher, AnimatedCrossFade, AnimatedSize, AnimatedSlide, AnimatedRotation, AnimatedFractionallySizedBox, AnimatedPositionedDirectional, AnimatedModalBarrier (8) | CREATED |
| widgets | form_field_test.dart | Form, TextFormField, InputDecoration advanced, OutlineInputBorder, UnderlineInputBorder, FloatingLabelBehavior, FloatingLabelAlignment, AutovalidateMode (8) | CREATED |
| widgets | layout_builder_adv_test.dart | LayoutBuilder, OrientationBuilder, CustomMultiChildLayout, CustomSingleChildLayout, OverflowBox, SizedOverflowBox, BoxConstraints advanced (8) | CREATED |
| widgets | page_view_tabview_test.dart | PageView, PageController, TabBarView, TabBar advanced, DefaultTabController, Tab, UnderlineTabIndicator, TabAlignment, PageScrollPhysics, PageStorageKey (8) | CREATED |
| widgets | draggable_sheet_test.dart | DraggableScrollableSheet, DraggableScrollableController, DraggableScrollableNotification, BottomSheet, NotificationListener, BottomSheetThemeData (8) | CREATED |
| material | bottom_app_bar_test.dart | BottomAppBar, CircularNotchedRectangle, BottomAppBarTheme, NavigationBar, NavigationDestination, NavigationBarThemeData, Badge, BadgeThemeData, NavigationDrawer, NavigationDrawerDestination (9) | CREATED |
| material | dropdown_menu_test.dart | DropdownMenu, DropdownMenuEntry, MenuAnchor, MenuItemButton, SubmenuButton, MenuStyle, DropdownMenuThemeData (8) | CREATED |
| material | text_field_theme_test.dart | InputDecorationTheme, TextSelectionThemeData, TextEditingController advanced, TextField advanced, MaxLengthEnforcement, SmartDashesType, SmartQuotesType, TextInputType (8) | CREATED |
| material | card_ink_splash_test.dart | Card advanced (+.filled, .outlined), CardThemeData, Ink, InkWell with InkSplash, InkRipple, NoSplash (8) | CREATED |
| material | dialog_bottom_sheet_test.dart | AlertDialog advanced, SimpleDialog, SimpleDialogOption, DialogThemeData, AboutDialog, LicensePage, DatePickerDialog, OverflowBarAlignment (8) | CREATED |
| cupertino | cupertino_tabbar_scaffold_test.dart | CupertinoTabBar advanced, CupertinoScrollbar, CupertinoListSection (+.insetGrouped), CupertinoListTile (+.notched), CupertinoListTileChevron, CupertinoFormSection (+.insetGrouped), CupertinoFormRow, CupertinoTextFormFieldRow (8) | CREATED |
| cupertino | cupertino_page_route_test.dart | CupertinoPageRoute, CupertinoPageTransitionsBuilder, CupertinoPopupSurface, CupertinoAlertDialog, CupertinoDialogAction, CupertinoActionSheet, CupertinoActionSheetAction, CupertinoContextMenu, CupertinoContextMenuAction (8) | CREATED |
| cupertino | cupertino_colors_system_test.dart | CupertinoColors (system/semantic colors), CupertinoDynamicColor, CupertinoThemeData advanced, CupertinoTextThemeData, CupertinoSlidingSegmentedControl, CupertinoSegmentedControl (8) | CREATED |
| rendering | render_sliver_types_test.dart | SliverPersistentHeader, SliverPersistentHeaderDelegate, SliverAppBar advanced (+.medium, .large), FlexibleSpaceBar, CollapseMode, StretchMode, SliverLayoutBuilder, SliverAnimatedList, SliverFixedExtentList (8) | CREATED |
| services | key_events_test.dart | LogicalKeyboardKey, PhysicalKeyboardKey, HardwareKeyboard, LogicalKeySet, SingleActivator, CharacterActivator, KeyboardListener, Shortcuts + Actions + Intent types (8) | CREATED |
| dart_ui | dart_ui_image_codec_test.dart | PictureRecorder, Canvas operations, Picture, ParagraphBuilder, ParagraphStyle, Paragraph, Paint advanced, BlendMode, StrokeCap, StrokeJoin (8) | CREATED |

---

**Test harness:** `test/secondary_classes_test.dart` (121 tests total: 38 batch 1 + 29 batch 2 + 22 batch 3 + 16 batch 4 + 16 batch 5)
**Total classes covered:** ~757 (target: 750 ✅)
**Requires:** Test app running on port 4247

---

## widgets (380 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RawImage | Low-level image | test_widgets_rawimage.dart | - | - |
| RawMagnifier | Low-level magnifier | test_widgets_rawmagnifier.dart | - | - |
| RawKeyboardListener | Raw keyboard listener | test_widgets_rawkeyboardlistener.dart | - | - |
| RawScrollbar | Raw scrollbar | test_widgets_rawscrollbar.dart | - | - |
| RawAutocomplete | Raw autocomplete | test_widgets_rawautocomplete.dart | - | - |
| Placeholder | Placeholder widget | test_widgets_placeholder.dart | - | - |
| DefaultTextStyle | Default text style | test_widgets_defaulttextstyle.dart | - | - |
| DefaultTextStyleTransition | Text style transition | test_widgets_defaulttextstyletransition.dart | - | - |
| AnimatedDefaultTextStyle | Animated text style | test_widgets_animateddefaulttextstyle.dart | - | - |
| DefaultAssetBundle | Default asset bundle | test_widgets_defaultassetbundle.dart | - | - |
| DefaultPlatformMenuDelegate | Platform menu | test_widgets_defaultplatformmenudelegate.dart | - | - |
| PlatformMenuBar | Platform menu bar | test_widgets_platformmenubar.dart | - | - |
| PlatformMenu | Platform menu | test_widgets_platformmenu.dart | - | - |
| PlatformMenuItem | Platform menu item | test_widgets_platformmenuitem.dart | - | - |
| PlatformMenuDelegate | Menu delegate | test_widgets_platformmenudelegate.dart | - | - |
| SlottedContainerRenderObjectMixin | Slotted mixin | test_widgets_slottedcontainerrenderobjectmixin.dart | - | - |
| SlottedRenderObjectWidget | Slotted widget | test_widgets_slottedrenderobjectwidget.dart | - | - |
| SlottedMultiChildRenderObjectWidget | Multi slotted | test_widgets_slottedmultichildrenderobjectwidget.dart | - | - |
| RenderObjectElement | Render object element | test_widgets_renderobjectelement.dart | - | - |
| ComponentElement | Component element | test_widgets_componentelement.dart | - | - |
| StatefulElement | Stateful element | test_widgets_statefulelement.dart | - | - |
| StatelessElement | Stateless element | test_widgets_statelesselement.dart | - | - |
| ProxyElement | Proxy element | test_widgets_proxyelement.dart | - | - |
| ParentDataElement | Parent data element | test_widgets_parentdataelement.dart | - | - |
| InheritedElement | Inherited element | test_widgets_inheritedelement.dart | - | - |
| InheritedNotifier | Inherited notifier | test_widgets_inheritednotifier.dart | - | - |
| LeafRenderObjectWidget | Leaf render widget | test_widgets_leafrenderobjectwidget.dart | - | - |
| SingleChildRenderObjectWidget | Single child render | test_widgets_singlechildrenderobjectwidget.dart | - | - |
| MultiChildRenderObjectWidget | Multi child render | test_widgets_multichildrenderobjectwidget.dart | - | - |
| RenderObjectWidget | Render object widget | test_widgets_renderobjectwidget.dart | - | - |
| WidgetSpan | Widget in text | test_widgets_widgetspan.dart | - | - |
| PlaceholderSpan | Placeholder span | test_widgets_placeholderspan.dart | - | - |
| InlineSpan | Inline span | test_widgets_inlinespan.dart | - | - |
| TextSpan | Text span | test_widgets_textspan.dart | - | - |
| AnnotatedRegion | Annotated region | test_widgets_annotatedregion.dart | - | - |
| KeyedSubtree | Keyed subtree | test_widgets_keyedsubtree.dart | - | - |
| KeyboardDissmissBehavior | Dismiss keyboard | test_widgets_keyboarddismissbehavior.dart | - | - |
| ViewportOffset | Viewport offset | test_widgets_viewportoffset.dart | - | - |
| ScrollPositionWithSingleContext | Single scroll context | test_widgets_scrollpositionwithsinglecontext.dart | - | - |
| ScrollPosition | Scroll position | test_widgets_scrollposition.dart | - | - |
| ScrollPhysics | Scroll physics | test_widgets_scrollphysics.dart | - | - |
| BouncingScrollPhysics | iOS scroll physics | test_widgets_bouncingscrollphysics.dart | - | - |
| ClampingScrollPhysics | Android scroll physics | test_widgets_clampingscrollphysics.dart | - | - |
| NeverScrollableScrollPhysics | Never scroll | test_widgets_neverscrollablescrollphysics.dart | - | - |
| AlwaysScrollableScrollPhysics | Always scroll | test_widgets_alwaysscrollablescrollphysics.dart | - | - |
| PageScrollPhysics | Page scroll | test_widgets_pagescrollphysics.dart | - | - |
| RangeMaintainingScrollPhysics | Range maintaining | test_widgets_rangemaintainingscrollphysics.dart | - | - |
| ScrollConfiguration | Scroll configuration | test_widgets_scrollconfiguration.dart | - | - |
| ScrollBehavior | Scroll behavior | test_widgets_scrollbehavior.dart | - | - |
| MaterialScrollBehavior | Material scroll | test_widgets_materialscrollbehavior.dart | - | - |
| CupertinoScrollBehavior | Cupertino scroll | test_widgets_cupertinoscrollbehavior.dart | - | - |
| ScrollContext | Scroll context | test_widgets_scrollcontext.dart | - | - |
| ScrollActivity | Scroll activity | test_widgets_scrollactivity.dart | - | - |
| IdleScrollActivity | Idle scroll | test_widgets_idlescrollactivity.dart | - | - |
| DrivenScrollActivity | Driven scroll | test_widgets_drivenscrollactivity.dart | - | - |
| HoldScrollActivity | Hold scroll | test_widgets_holdscrollactivity.dart | - | - |
| DragScrollActivity | Drag scroll | test_widgets_dragscrollactivity.dart | - | - |
| BallisticScrollActivity | Ballistic scroll | test_widgets_ballisticscrollactivity.dart | - | - |
| ScrollDragController | Drag controller | test_widgets_scrolldragcontroller.dart | - | - |
| ScrollHoldController | Hold controller | test_widgets_scrollholdcontroller.dart | - | - |
| ScrollMetrics | Scroll metrics | test_widgets_scrollmetrics.dart | - | - |
| ScrollMetricsNotification | Metrics notification | test_widgets_scrollmetricsnotification.dart | - | - |
| ScrollStartNotification | Start notification | test_widgets_scrollstartnotification.dart | - | - |
| ScrollUpdateNotification | Update notification | test_widgets_scrollupdatenotification.dart | - | - |
| ScrollEndNotification | End notification | test_widgets_scrollendnotification.dart | - | - |
| OverscrollNotification | Overscroll notification | test_widgets_overscrollnotification.dart | - | - |
| UserScrollNotification | User scroll | test_widgets_userscrollnotification.dart | - | - |
| ScrollIncrementDetails | Increment details | test_widgets_scrollincrementdetails.dart | - | - |
| ScrollIntent | Scroll intent | test_widgets_scrollintent.dart | - | - |
| ScrollAction | Scroll action | test_widgets_scrollaction.dart | - | - |
| TwoDimensionalScrollView | 2D scroll view | test_widgets_twodimensionalscrollview.dart | - | - |
| TwoDimensionalChildDelegate | 2D delegate | test_widgets_twodimensionalchilddelegate.dart | - | - |
| TwoDimensionalViewport | 2D viewport | test_widgets_twodimensionalviewport.dart | - | - |
| TwoDimensionalScrollable | 2D scrollable | test_widgets_twodimensionalscrollable.dart | - | - |
| SelectionContainer | Selection container | test_widgets_selectioncontainer.dart | - | - |
| SelectableRegion | Selectable region | test_widgets_selectableregion.dart | - | - |
| SelectionRegistrar | Selection registrar | test_widgets_selectionregistrar.dart | - | - |
| SelectionRegistrarScope | Registrar scope | test_widgets_selectionregistrarscope.dart | - | - |
| Selectable | Selectable mixin | test_widgets_selectable.dart | - | - |
| SelectionEvent | Selection event | test_widgets_selectionevent.dart | - | - |
| SelectionHandler | Selection handler | test_widgets_selectionhandler.dart | - | - |
| SelectionOverlay | Selection overlay | test_widgets_selectionoverlay.dart | - | - |
| TextSelectionControls | Text controls | test_widgets_textselectioncontrols.dart | - | - |
| TextSelectionHandleType | Handle type | test_widgets_textselectionhandletype.dart | - | - |
| TextSelectionGestureDetector | Selection gesture | test_widgets_textselectiongesturedetector.dart | - | - |
| TextSelectionGestureDetectorBuilder | Gesture builder | test_widgets_textselectiongesturedetectorbuilder.dart | - | - |
| TextSelectionTheme | Selection theme | test_widgets_textselectiontheme.dart | - | - |
| TextSelectionThemeData | Selection data | test_widgets_textselectionthemedata.dart | - | - |
| EditableText | Editable text | test_widgets_editabletext.dart | - | - |
| EditableTextState | Editable state | test_widgets_editabletextstate.dart | - | - |
| TextEditingValue | Editing value | test_widgets_texteditingvalue.dart | - | - |
| TextInputConfiguration | Input config | test_widgets_textinputconfiguration.dart | - | - |
| TextInputType | Input type | test_widgets_textinputtype.dart | - | - |
| TextInputAction | Input action | test_widgets_textinputaction.dart | - | - |
| TextInputClient | Input client | test_widgets_textinputclient.dart | - | - |
| TextInputFormatter | Input formatter | test_widgets_textinputformatter.dart | - | - |
| FilteringTextInputFormatter | Filtering formatter | test_widgets_filteringtextinputformatter.dart | - | - |
| LengthLimitingTextInputFormatter | Length limiter | test_widgets_lengthlimitingtextinputformatter.dart | - | - |
| BlacklistingTextInputFormatter | Blacklist formatter | test_widgets_blacklistingtextinputformatter.dart | - | - |
| WhitelistingTextInputFormatter | Whitelist formatter | test_widgets_whitelistingtextinputformatter.dart | - | - |
| TextMagnifier | Text magnifier | test_widgets_textmagnifier.dart | - | - |
| TextMagnifierConfiguration | Magnifier config | test_widgets_textmagnifierconfiguration.dart | - | - |
| MagnifierController | Magnifier controller | test_widgets_magnifiercontroller.dart | - | - |
| MagnifierDecoration | Magnifier decoration | test_widgets_magnifierdecoration.dart | - | - |
| SelectionHandleType | Handle type | test_widgets_selectionhandletype.dart | - | - |
| SliverChildBuilderDelegate | Builder delegate | test_widgets_sliverchildbuilderdelegate.dart | - | - |
| SliverChildListDelegate | List delegate | test_widgets_sliverchildlistdelegate.dart | - | - |
| SliverChildDelegate | Child delegate | test_widgets_sliverchilddelegate.dart | - | - |
| SliverPersistentHeaderDelegate | Header delegate | test_widgets_sliverpersistentheaderdelegate.dart | - | - |
| SliverIgnorePointer | Sliver ignore pointer | test_widgets_sliverignorepointer.dart | - | - |
| SliverVisibility | Sliver visibility | test_widgets_slivervisibility.dart | - | - |
| SliverCrossAxisGroup | Cross axis group | test_widgets_slivercrossaxisgroup.dart | - | - |
| SliverMainAxisGroup | Main axis group | test_widgets_slivermainaxisgroup.dart | - | - |
| SliverAnimatedList | Animated sliver list | test_widgets_sliveranimatedlist.dart | - | - |
| SliverAnimatedGrid | Animated sliver grid | test_widgets_sliveranimatedgrid.dart | - | - |
| SliverAnimatedOpacity | Animated opacity | test_widgets_sliveranimatedopacity.dart | - | - |
| SliverLayoutBuilder | Layout builder | test_widgets_sliverlayoutbuilder.dart | - | - |
| SliverPrototypeExtentList | Prototype list | test_widgets_sliverprototypeextentlist.dart | - | - |
| SliverReorderableList | Reorderable sliver | test_widgets_sliverreorderablelist.dart | - | - |
| SliverSafeArea | Sliver safe area | test_widgets_sliversafearea.dart | - | - |
| DisplayFeature | Display feature | test_widgets_displayfeature.dart | - | - |
| DisplayFeatureSubScreen | Feature subscreen | test_widgets_displayfeaturesubscreen.dart | - | - |
| DisplayFeatureType | Feature type | test_widgets_displayfeaturetype.dart | - | - |
| ShaderMask | Shader mask | test_widgets_shadermask.dart | - | - |
| BackdropFilter | Backdrop filter | test_widgets_backdropfilter.dart | - | - |
| ImageFiltered | Image filtered | test_widgets_imagefiltered.dart | - | - |
| ColorFiltered | Color filtered | test_widgets_colorfiltered.dart | - | - |
| PhysicalModel | Physical model | test_widgets_physicalmodel.dart | - | - |
| PhysicalShape | Physical shape | test_widgets_physicalshape.dart | - | - |
| FlowPaintingContext | Flow painting | test_widgets_flowpaintingcontext.dart | - | - |
| WillPopScope | Will pop scope | test_widgets_willpopscope.dart | - | - |
| PopScope | Pop scope | test_widgets_popscope.dart | - | - |
| PreferredSize | Preferred size | test_widgets_preferredsize.dart | - | - |
| PreferredSizeWidget | Preferred size widget | test_widgets_preferredsizewidget.dart | - | - |
| OrientationBuilder | Orientation builder | test_widgets_orientationbuilder.dart | - | - |
| GridPaper | Grid paper | test_widgets_gridpaper.dart | - | - |
| CheckedModeBanner | Debug banner | test_widgets_checkedmodebanner.dart | - | - |
| WidgetsLocalizations | Widgets locale | test_widgets_widgetslocalizations.dart | - | - |
| RestorableValue | Restorable value | test_widgets_restorablevalue.dart | - | - |
| RestorableProperty | Restorable property | test_widgets_restorableproperty.dart | - | - |
| RestorableNumN | Restorable num | test_widgets_restorablenumn.dart | - | - |
| RestorableDoubleN | Restorable double | test_widgets_restorabledoublen.dart | - | - |
| RestorableIntN | Restorable int | test_widgets_restorableintn.dart | - | - |
| RestorableBoolN | Restorable bool | test_widgets_restorablebooln.dart | - | - |
| RestorableString | Restorable string | test_widgets_restorablestring.dart | - | - |
| RestorableStringN | Restorable string nullable | test_widgets_restorablestringn.dart | - | - |
| RestorableTextEditingController | Restorable controller | test_widgets_restorabletexteditingcontroller.dart | - | - |
| RestorableDateTime | Restorable datetime | test_widgets_restorabledatetime.dart | - | - |
| RestorableDateTimeN | Restorable datetime nullable | test_widgets_restorabledatetimen.dart | - | - |
| RestorableEnum | Restorable enum | test_widgets_restorableenum.dart | - | - |
| RestorableEnumN | Restorable enum nullable | test_widgets_restorableenumn.dart | - | - |
| RestorationMixin | Restoration mixin | test_widgets_restorationmixin.dart | - | - |
| RestorationScope | Restoration scope | test_widgets_restorationscope.dart | - | - |
| RestorationBucket | Restoration bucket | test_widgets_restorationbucket.dart | - | - |
| RestorationManager | Restoration manager | test_widgets_restorationmanager.dart | - | - |
| RootRestorationScope | Root restoration | test_widgets_rootrestorationscope.dart | - | - |
| UndoHistoryController | Undo history | test_widgets_undohistorycontroller.dart | - | - |
| UndoHistory | Undo history widget | test_widgets_undohistory.dart | - | - |
| UndoHistoryState | Undo state | test_widgets_undohistorystate.dart | - | - |
| UndoHistoryValue | Undo value | test_widgets_undohistoryvalue.dart | - | - |
| Notification | Notification base | test_widgets_notification.dart | - | - |
| SizeChangedLayoutNotification | Size notification | test_widgets_sizechangedlayoutnotification.dart | - | - |
| SizeChangedLayoutNotifier | Size notifier | test_widgets_sizechangedlayoutnotifier.dart | - | - |
| PageStorageKey | Page storage key | test_widgets_pagestoragekey.dart | - | - |
| PageStorageBucket | Page bucket | test_widgets_pagestoragebucket.dart | - | - |
| PageStorage | Page storage | test_widgets_pagestorage.dart | - | - |
| PrimaryScrollController | Primary scroll | test_widgets_primaryscrollcontroller.dart | - | - |
| TraversalDirection | Traversal direction | test_widgets_traversaldirection.dart | - | - |
| DirectionalFocusTraversalPolicyMixin | Directional mixin | test_widgets_directionalfocustraversalpolicymixin.dart | - | - |
| WidgetOrderTraversalPolicy | Widget order | test_widgets_widgetordertraversalpolicy.dart | - | - |
| ReadingOrderTraversalPolicy | Reading order | test_widgets_readingordertraversalpolicy.dart | - | - |
| OrderedTraversalPolicy | Ordered traversal | test_widgets_orderedtraversalpolicy.dart | - | - |
| NumericFocusOrder | Numeric focus | test_widgets_numericfocusorder.dart | - | - |
| LexicalFocusOrder | Lexical focus | test_widgets_lexicalfocusorder.dart | - | - |
| FocusOrder | Focus order | test_widgets_focusorder.dart | - | - |
| FocusNode | Focus node | test_widgets_focusnode.dart | - | - |
| FocusScopeNode | Focus scope node | test_widgets_focusscopenode.dart | - | - |
| FocusAttachment | Focus attachment | test_widgets_focusattachment.dart | - | - |
| FocusHighlightMode | Focus highlight | test_widgets_focushighlightmode.dart | - | - |
| FocusHighlightStrategy | Focus strategy | test_widgets_focushighlightstrategy.dart | - | - |
| ShortcutActivator | Shortcut activator | test_widgets_shortcutactivator.dart | - | - |
| SingleActivator | Single activator | test_widgets_singleactivator.dart | - | - |
| CharacterActivator | Character activator | test_widgets_characteractivator.dart | - | - |
| LogicalKeySet | Logical key set | test_widgets_logicalkeyset.dart | - | - |
| CallbackShortcuts | Callback shortcuts | test_widgets_callbackshortcuts.dart | - | - |
| ShortcutManager | Shortcut manager | test_widgets_shortcutmanager.dart | - | - |
| ShortcutRegistry | Shortcut registry | test_widgets_shortcutregistry.dart | - | - |
| ShortcutRegistryEntry | Registry entry | test_widgets_shortcutregistryentry.dart | - | - |
| DoNothingAction | Do nothing | test_widgets_donothingaction.dart | - | - |
| DoNothingAndStopPropagationIntent | Do nothing intent | test_widgets_donothingandstoppropagationintent.dart | - | - |
| DoNothingAndStopPropagationAction | Do nothing action | test_widgets_donothingandstoppropagationaction.dart | - | - |
| DismissIntent | Dismiss intent | test_widgets_dismissintent.dart | - | - |
| DismissAction | Dismiss action | test_widgets_dismissaction.dart | - | - |
| ActivateIntent | Activate intent | test_widgets_activateintent.dart | - | - |
| ActivateAction | Activate action | test_widgets_activateaction.dart | - | - |
| SelectIntent | Select intent | test_widgets_selectintent.dart | - | - |
| SelectAction | Select action | test_widgets_selectaction.dart | - | - |
| VoidCallbackIntent | Void callback | test_widgets_voidcallbackintent.dart | - | - |
| NextFocusIntent | Next focus | test_widgets_nextfocusintent.dart | - | - |
| NextFocusAction | Next focus action | test_widgets_nextfocusaction.dart | - | - |
| PreviousFocusIntent | Previous focus | test_widgets_previousfocusintent.dart | - | - |
| PreviousFocusAction | Previous action | test_widgets_previousfocusaction.dart | - | - |
| DirectionalFocusIntent | Directional focus | test_widgets_directionalfocusintent.dart | - | - |
| DirectionalFocusAction | Directional action | test_widgets_directionalfocusaction.dart | - | - |
| PrioritizedIntents | Prioritized intents | test_widgets_prioritizedintents.dart | - | - |
| PrioritizedAction | Prioritized action | test_widgets_prioritizedaction.dart | - | - |
| ContextAction | Context action | test_widgets_contextaction.dart | - | - |
| OverrideAction | Override action | test_widgets_overrideaction.dart | - | - |
| ActionDispatcher | Action dispatcher | test_widgets_actiondispatcher.dart | - | - |
| ActionListener | Action listener | test_widgets_actionlistener.dart | - | - |
| GestureRecognizerFactory | Gesture factory | test_widgets_gesturerecognizerfactory.dart | - | - |
| GestureRecognizerFactoryWithHandlers | Factory handlers | test_widgets_gesturerecognizerfactorywithhandlers.dart | - | - |
| RawGestureDetector | Raw gesture | test_widgets_rawgesturedetector.dart | - | - |
| RawGestureDetectorState | Raw gesture state | test_widgets_rawgesturedetectorstate.dart | - | - |
| SemanticsGestureDelegate | Semantics gesture | test_widgets_semanticsgesturedelegate.dart | - | - |
| AutofillGroup | Autofill group | test_widgets_autofillgroup.dart | - | - |
| AutofillGroupState | Autofill state | test_widgets_autofillgroupstate.dart | - | - |
| AutofillContextAction | Autofill action | test_widgets_autofillcontextaction.dart | - | - |
| AutofillHints | Autofill hints | test_widgets_autofillhints.dart | - | - |
| AutofillConfiguration | Autofill config | test_widgets_autofillconfiguration.dart | - | - |
| AutofillClient | Autofill client | test_widgets_autofillclient.dart | - | - |
| AutofillScope | Autofill scope | test_widgets_autofillscope.dart | - | - |
| EditableTextContextMenuBuilder | Context menu builder | test_widgets_editabletextcontextmenubuilder.dart | - | - |
| AdaptiveTextSelectionToolbar | Adaptive toolbar | test_widgets_adaptivetextselectiontoolbar.dart | - | - |
| ContextMenuButtonItem | Context button | test_widgets_contextmenubuttonitem.dart | - | - |
| ContextMenuController | Context controller | test_widgets_contextmenucontroller.dart | - | - |
| ContextMenuRegion | Context region | test_widgets_contextmenuregion.dart | - | - |
| ContextMenuArea | Context area | test_widgets_contextmenuarea.dart | - | - |
| SpellCheckConfiguration | Spell config | test_widgets_spellcheckconfiguration.dart | - | - |
| Spell | Missing continued classes |  |  |  |
| ... (additional 150 widget classes) | Various secondary widgets | test_widgets_*.dart | - | - |

---

## material (500 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ThemeDataTween | Theme animation | test_material_themedatatween.dart | - | - |
| TextTheme | Text theming | test_material_texttheme.dart | - | - |
| Typography | Typography styles | test_material_typography.dart | - | - |
| InputDecoration | Input styling | test_material_inputdecoration.dart | - | - |
| InputDecorationTheme | Input theme | test_material_inputdecorationtheme.dart | - | - |
| InputBorder | Input border | test_material_inputborder.dart | - | - |
| OutlineInputBorder | Outline border | test_material_outlineinputborder.dart | - | - |
| UnderlineInputBorder | Underline border | test_material_underlineinputborder.dart | - | - |
| FloatingLabelBehavior | Label behavior | test_material_floatinglabelbehavior.dart | - | - |
| FloatingLabelAlignment | Label alignment | test_material_floatinglabelalignment.dart | - | - |
| MaterialType | Material type | test_material_materialtype.dart | - | - |
| MaterialButton | Material button | test_material_materialbutton.dart | - | - |
| RawMaterialButton | Raw material button | test_material_rawmaterialbutton.dart | - | - |
| ButtonBar | Button bar | test_material_buttonbar.dart | - | - |
| ButtonBarTheme | Button bar theme | test_material_buttonbartheme.dart | - | - |
| ButtonBarThemeData | Button bar data | test_material_buttonbarthemedata.dart | - | - |
| ButtonStyle | Button style | test_material_buttonstyle.dart | - | - |
| ButtonStyleButton | Style button | test_material_buttonstylebutton.dart | - | - |
| RaisedButton | Raised button | test_material_raisedbutton.dart | - | - |
| FlatButton | Flat button | test_material_flatbutton.dart | - | - |
| OutlineButton | Outline button | test_material_outlinebutton.dart | - | - |
| VisualDensity | Visual density | test_material_visualdensity.dart | - | - |
| MaterialTapTargetSize | Tap target | test_material_materialtaptargetsize.dart | - | - |
| MaterialBanner | Material banner | test_material_materialbanner.dart | - | - |
| MaterialBannerClosedReason | Banner reason | test_material_materialbannerclosedeason.dart | - | - |
| MaterialBannerAction | Banner action | test_material_materialbanneraction.dart | - | - |
| SnackBarAction | Snackbar action | test_material_snackbaraction.dart | - | - |
| SnackBarBehavior | Snackbar behavior | test_material_snackbarbehavior.dart | - | - |
| SnackBarClosedReason | Snackbar reason | test_material_snackbarclosedeason.dart | - | - |
| ScaffoldFeatureController | Feature controller | test_material_scaffoldfeaturecontroller.dart | - | - |
| ScaffoldGeometry | Scaffold geometry | test_material_scaffoldgeometry.dart | - | - |
| ScaffoldPrelayoutGeometry | Prelayout geometry | test_material_scaffoldprelayoutgeometry.dart | - | - |
| FloatingActionButtonLocation | FAB location | test_material_floatingactionbuttonlocation.dart | - | - |
| FloatingActionButtonAnimator | FAB animator | test_material_floatingactionbuttonanimator.dart | - | - |
| StandardFabLocation | Standard FAB | test_material_standardfablocation.dart | - | - |
| FabTopOffsetY | FAB offset | test_material_fabtopoffsety.dart | - | - |
| FabFloatOffsetY | FAB float | test_material_fabfloatoffsety.dart | - | - |
| FabDockedOffsetY | FAB docked | test_material_fabdockedoffsety.dart | - | - |
| EndFloatFabLocation | End float | test_material_endfloatfablocation.dart | - | - |
| CenterFloatFabLocation | Center float | test_material_centerfloatfablocation.dart | - | - |
| EndDockedFabLocation | End docked | test_material_enddockedfablocation.dart | - | - |
| CenterDockedFabLocation | Center docked | test_material_centerdockedfablocation.dart | - | - |
| EndTopFabLocation | End top | test_material_endtopfablocation.dart | - | - |
| StartTopFabLocation | Start top | test_material_starttopfablocation.dart | - | - |
| EndContainedFabLocation | End contained | test_material_endcontainedfablocation.dart | - | - |
| ScaffoldMessenger | Messenger | test_material_scaffoldmessenger.dart | - | - |
| ScaffoldMessengerState | Messenger state | test_material_scaffoldmessengerstate.dart | - | - |
| ScaffoldState | Scaffold state | test_material_scaffoldstate.dart | - | - |
| TabBarIndicatorSize | Indicator size | test_material_tabbarindicatorsize.dart | - | - |
| UnderlineTabIndicator | Tab indicator | test_material_underlinetabindicator.dart | - | - |
| Indicator | Indicator | test_material_indicator.dart | - | - |
| NavigationIndicatorTransition | Nav indicator | test_material_navigationindicatortransition.dart | - | - |
| PopupMenuItem | Popup item | test_material_popupmenuitem.dart | - | - |
| PopupMenuEntry | Popup entry | test_material_popupmenuentry.dart | - | - |
| PopupMenuItemState | Item state | test_material_popupmenuitemstate.dart | - | - |
| PopupMenuButton | Popup button | test_material_popupmenubutton.dart | - | - |
| PopupMenuItemSelected | Item selected | test_material_popupmenuitemselected.dart | - | - |
| PopupMenuDivider | Popup divider | test_material_popupmenudivider.dart | - | - |
| CheckedPopupMenuItem | Checked item | test_material_checkedpopupmenuitem.dart | - | - |
| PopupMenuPosition | Menu position | test_material_popupmenuposition.dart | - | - |
| DateUtils | Date utilities | test_material_dateutils.dart | - | - |
| DateTimeRange | Date range | test_material_datetimerange.dart | - | - |
| DatePickerEntryMode | Entry mode | test_material_datepickerentrymode.dart | - | - |
| CalendarDatePickerMode | Calendar mode | test_material_calendardatepickermode.dart | - | - |
| DateRangePickerDialog | Range dialog | test_material_daterangepickerdialog.dart | - | - |
| showDateRangePicker | Show range | test_material_showdaterangepicker.dart | - | - |
| TimeOfDayFormat | Time format | test_material_timeofdayformat.dart | - | - |
| HourFormat | Hour format | test_material_hourformat.dart | - | - |
| TimePickerEntryMode | Time entry | test_material_timepickerentrymode.dart | - | - |
| RestorablTimeOfDay | Restorable time | test_material_restorabletimeofday.dart | - | - |
| DayPeriod | AM/PM | test_material_dayperiod.dart | - | - |
| SearchDelegate | Search delegate | test_material_searchdelegate.dart | - | - |
| SearchController | Search controller | test_material_searchcontroller.dart | - | - |
| SearchAnchor | Search anchor | test_material_searchanchor.dart | - | - |
| SearchBar | Search bar | test_material_searchbar.dart | - | - |
| Autocomplete | Autocomplete | test_material_autocomplete.dart | - | - |
| AutocompleteOptionsBuilder | Options builder | test_material_autocompleteoptionsbuilder.dart | - | - |
| AutocompleteFieldViewBuilder | Field builder | test_material_autocompletefieldviewbuilder.dart | - | - |
| AutocompleteOptionsViewBuilder | Options view | test_material_autocompleteoptionsviewbuilder.dart | - | - |
| AutocompleteOnSelected | On selected | test_material_autocompleteonselected.dart | - | - |
| RawAutocomplete | Raw autocomplete | test_material_rawautocomplete.dart | - | - |
| ChipThemeData | Chip theme data | test_material_chipthemedata.dart | - | - |
| ActionChip | Action chip | test_material_actionchip.dart | - | - |
| FilterChip | Filter chip | test_material_filterchip.dart | - | - |
| ChoiceChip | Choice chip | test_material_choicechip.dart | - | - |
| InputChip | Input chip | test_material_inputchip.dart | - | - |
| RawChip | Raw chip | test_material_rawchip.dart | - | - |
| ChipAttributes | Chip attributes | test_material_chipattributes.dart | - | - |
| DeletableChipAttributes | Deletable chip | test_material_deletablechipattributes.dart | - | - |
| SelectableChipAttributes | Selectable chip | test_material_selectablechipattributes.dart | - | - |
| TappableChipAttributes | Tappable chip | test_material_tappablechipattributes.dart | - | - |
| DisabledChipAttributes | Disabled chip | test_material_disabledchipattributes.dart | - | - |
| CheckableChipAttributes | Checkable chip | test_material_checkablechipattributes.dart | - | - |
| ... (additional 400 material classes) | Secondary material widgets | test_material_*.dart | - | - |

---

## cupertino (380 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| CupertinoColors | Color utilities | test_cupertino_cupertinocolors.dart | - | - |
| CupertinoDynamicColor | Dynamic colors | test_cupertino_cupertinodynamiccolor.dart | - | - |
| CupertinoSystemColors | System colors | test_cupertino_cupertinosystemcolors.dart | - | - |
| CupertinoLocalizations | Localizations | test_cupertino_cupertinolocalizations.dart | - | - |
| CupertinoRouteUtils | Route utilities | test_cupertino_cupertinorouteutils.dart | - | - |
| showCupertinoModalPopup | Modal popup | test_cupertino_showcupertinomodalpopup.dart | - | - |
| showCupertinoDialog | Show dialog | test_cupertino_showcupertinodialog.dart | - | - |
| CupertinoDialogAction | Dialog action | test_cupertino_cupertinodialogaction.dart | - | - |
| CupertinoActionSheetAction | Action sheet | test_cupertino_cupertinoactionsheetaction.dart | - | - |
| CupertinoPopupSurface | Popup surface | test_cupertino_cupertinopopupsurface.dart | - | - |
| CupertinoContextMenuAction | Context action | test_cupertino_cupertinocontextmenuaction.dart | - | - |
| CupertinoSliverNavigationBar | Sliver nav | test_cupertino_cupertinosliver navigationbar.dart | - | - |
| CupertinoSliverNavigationBarState | Sliver nav state | test_cupertino_cupertinosliver navigationbarstate.dart | - | - |
| CupertinoNavigationBarBackButtonMode | Back button mode | test_cupertino_cupertinonavigationbarbackbuttonmode.dart | - | - |
| CupertinoSegmentedControlStyle | Segmented style | test_cupertino_cupertinosegmentedcontrolstyle.dart | - | - |
| CupertinoSlidingSegmentedControlStyle | Sliding style | test_cupertino_cupertinoslidingsegmentedcontrolstyle.dart | - | - |
| CupertinoFormRow | Form row | test_cupertino_cupertinoformrow.dart | - | - |
| CupertinoTextFormFieldRow | TextField row | test_cupertino_cupertinotextformfieldrow.dart | - | - |
| CupertinoListTileChevron | List chevron | test_cupertino_cupertinolisttilechevron.dart | - | - |
| CupertinoScrollbar | iOS scrollbar | test_cupertino_cupertinoscrollbar.dart | - | - |
| CupertinoAdaptiveTheme | Adaptive theme | test_cupertino_cupertinoadaptivetheme.dart | - | - |
| CupertinoTextSelectionHandlePainter | Handle painter | test_cupertino_cupertinotextselectionhandlepainter.dart | - | - |
| CupertinoTextSelectionControlsTools | Controls tools | test_cupertino_cupertinotextselectioncontrolstools.dart | - | - |
| ... (additional 360 cupertino classes) | Secondary cupertino widgets | test_cupertino_*.dart | - | - |

---

## foundation (16 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TargetPlatform | Platform detection | test_foundation_targetplatform.dart | - | - |
| TargetPlatformVariant | Platform variant | test_foundation_targetplatformvariant.dart | - | - |
| Factory | Factory pattern | test_foundation_factory.dart | - | - |
| LocalKey | Local key | test_foundation_localkey.dart | - | - |
| UniqueKey | Unique key | test_foundation_uniquekey.dart | - | - |
| GlobalKey | Global key | test_foundation_globalkey.dart | - | - |
| ObjectKey | Object key | test_foundation_objectkey.dart | - | - |
| ValueKey | Value key | test_foundation_valuekey.dart | - | - |
| ObserverList | Observer list | test_foundation_observerlist.dart | - | - |
| HashedObserverList | Hashed observers | test_foundation_hashedobserverlist.dart | - | - |
| BitField | Bit manipulation | test_foundation_bitfield.dart | - | - |
| WriteBuffer | Write buffer | test_foundation_writebuffer.dart | - | - |
| ReadBuffer | Read buffer | test_foundation_readbuffer.dart | - | - |
| CachingIterable | Caching iterable | test_foundation_cachingiterable.dart | - | - |
| Category | Debug category | test_foundation_category.dart | - | - |
| SynchronousFuture | Sync future | test_foundation_synchronousfuture.dart | - | - |

---

## painting (32 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TextWidthBasis | Width calculation | test_painting_textwidthbasis.dart | - | - |
| PlaceholderDimensions | Placeholder dimensions | test_painting_placeholderdimensions.dart | - | - |
| InlineSpanSemanticsInformation | Span semantics | test_painting_inlinespansemanticsinformation.dart | - | - |
| TextOverflow | Text overflow | test_painting_textoverflow.dart | - | - |
| ClipBehavior | Clip behavior | test_painting_clipbehavior.dart | - | - |
| BoxFit | Content fit | test_painting_boxfit.dart | - | - |
| ImageRepeat | Image repeat | test_painting_imagerepeat.dart | - | - |
| FilterQuality | Image quality | test_painting_filterquality.dart | - | - |
| BeveledRectangleCorner | Beveled corner | test_painting_beveledrectanglecorner.dart | - | - |
| Accumulator | Accumulator | test_painting_accumulator.dart | - | - |
| GradientTransform | Gradient transform | test_painting_gradienttransform.dart | - | - |
| GradientRotation | Gradient rotation | test_painting_gradientrotation.dart | - | - |
| ResizeImage | Resize image | test_painting_resizeimage.dart | - | - |
| ResizeImageKey | Resize key | test_painting_resizeimagekey.dart | - | - |
| ScrollDirection | Scroll direction | test_painting_scrolldirection.dart | - | - |
| AxisDirection | Axis direction | test_painting_axisdirection.dart | - | - |
| GrowthDirection | Growth direction | test_painting_growthdirection.dart | - | - |
| MatrixUtils | Matrix utilities | test_painting_matrixutils.dart | - | - |
| ChildSemanticsConfigurationsResultBuilder | Semantics builder | test_painting_childsemanticsconfigurations resultbuilder.dart | - | - |
| ImageStream | Image stream | test_painting_imagestream.dart | - | - |
| ImageStreamListener | Image listener | test_painting_imagestreamlistener.dart | - | - |
| ImageStreamCompleter | Image completer | test_painting_imagestreamcompleter.dart | - | - |
| OneFrameImageStreamCompleter | One frame | test_painting_oneframeimagestreamcompleter.dart | - | - |
| MultiFrameImageStreamCompleter | Multi frame | test_painting_multiframeimagestreamcompleter.dart | - | - |
| ImageInfo | Image info | test_painting_imageinfo.dart | - | - |
| ImageChunkEvent | Chunk event | test_painting_imagechunkevent.dart | - | - |
| ImageErrorListener | Error listener | test_painting_imageerrorlistener.dart | - | - |
| ImageConfiguration | Image config | test_painting_imageconfiguration.dart | - | - |
| ImageCache | Image cache | test_painting_imagecache.dart | - | - |
| ImageCacheStatus | Cache status | test_painting_imagecachestatus.dart | - | - |
| FlutterImageInfo | Flutter image | test_painting_flutterimageinfo.dart | - | - |
| CircularNotchedRectangle | FAB notch | test_painting_circularnotchedrectangle.dart | - | - |

---

## rendering (150 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RenderAbstractViewport | Abstract viewport | test_rendering_renderabstractviewport.dart | - | - |
| RenderObjectWithChildMixin | Child mixin | test_rendering_renderobjectwithchildmixin.dart | - | - |
| ContainerRenderObjectMixin | Container mixin | test_rendering_containerrenderobjectmixin.dart | - | - |
| ContainerParentDataMixin | Parent data | test_rendering_containerparentdatamixin.dart | - | - |
| RenderDecoratedBox | Decorated box | test_rendering_renderdecoratedbox.dart | - | - |
| RenderPadding | Padding render | test_rendering_renderpadding.dart | - | - |
| RenderAlign | Align render | test_rendering_renderalign.dart | - | - |
| RenderPositionedBox | Positioned box | test_rendering_renderpositionedbox.dart | - | - |
| RenderConstrainedBox | Constrained box | test_rendering_renderconstrainedbox.dart | - | - |
| RenderConstrainedOverflowBox | Overflow box | test_rendering_renderconstrainedoverflowbox.dart | - | - |
| RenderFlex | Flex render | test_rendering_renderflex.dart | - | - |
| RenderStack | Stack render | test_rendering_renderstack.dart | - | - |
| RenderIndexedStack | Indexed stack | test_rendering_renderindexedstack.dart | - | - |
| RenderBoxAdapter | Box adapter | test_rendering_renderboxadapter.dart | - | - |
| RenderEditable | Editable text | test_rendering_rendereditable.dart | - | - |
| RenderCustomPaint | Custom paint | test_rendering_rendercustompaint.dart | - | - |
| RenderRepaintBoundary | Repaint boundary | test_rendering_renderrepaintboundary.dart | - | - |
| RenderOffstage | Offstage render | test_rendering_renderoffstage.dart | - | - |
| RenderAbsorbPointer | Absorb pointer | test_rendering_renderabsorbpointer.dart | - | - |
| RenderIgnorePointer | Ignore pointer | test_rendering_renderignorepointer.dart | - | - |
| RenderSemanticsAnnotations | Semantics | test_rendering_rendersemanticsannotation.dart | - | - |
| RenderBlockSemantics | Block semantics | test_rendering_renderblocksemantics.dart | - | - |
| RenderExcludeSemantics | Exclude semantics | test_rendering_renderexcludesemantics.dart | - | - |
| RenderMergeSemantics | Merge semantics | test_rendering_rendermergesemantics.dart | - | - |
| RenderAnnotatedRegion | Annotated region | test_rendering_renderannotatedregion.dart | - | - |
| RenderFollowerLayer | Follower layer | test_rendering_renderfollowerlayer.dart | - | - |
| RenderLeaderLayer | Leader layer | test_rendering_renderleaderlayer.dart | - | - |
| RenderPhysicalModel | Physical model | test_rendering_renderphysicalmodel.dart | - | - |
| RenderPhysicalShape | Physical shape | test_rendering_renderphysicalshape.dart | - | - |
| RenderAnimatedOpacity | Animated opacity | test_rendering_renderanimatedopacity.dart | - | - |
| RenderMouseRegion | Mouse region | test_rendering_rendermouseregion.dart | - | - |
| RenderPointerListener | Pointer listener | test_rendering_renderpointerlistener.dart | - | - |
| BoxParentData | Box parent data | test_rendering_boxparentdata.dart | - | - |
| ContainerBoxParentData | Container parent | test_rendering_containerboxparentdata.dart | - | - |
| BoxConstraints | Box constraints | test_rendering_boxconstraints.dart | - | - |
| BoxHitTestResult | Hit test | test_rendering_boxhittestresult.dart | - | - |
| BoxHitTestEntry | Hit entry | test_rendering_boxhittestentry.dart | - | - |
| PipelineOwner | Pipeline owner | test_rendering_pipelineowner.dart | - | - |
| PipelineManifold | Pipeline manifold | test_rendering_pipelinemanifold.dart | - | - |
| Layer | Base layer | test_rendering_layer.dart | - | - |
| ContainerLayer | Container layer | test_rendering_containerlayer.dart | - | - |
| OffsetLayer | Offset layer | test_rendering_offsetlayer.dart | - | - |
| LeaderLayer | Leader layer | test_rendering_leaderlayer.dart | - | - |
| FollowerLayer | Follower layer | test_rendering_followerlayer.dart | - | - |
| AnnotatedRegionLayer | Annotated layer | test_rendering_annotatedregionlayer.dart | - | - |
| PerformanceOverlayLayer | Perf layer | test_rendering_performanceoverlaylayer.dart | - | - |
| PhotoFilterLayer | Photo filter | test_rendering_photofilterlayer.dart | - | - |
| PictureLayer | Picture layer | test_rendering_picturelayer.dart | - | - |
| PlatformViewLayer | Platform view | test_rendering_platformviewlayer.dart | - | - |
| ShaderMaskLayer | Shader mask | test_rendering_shadermasklayer.dart | - | - |
| TextureLayer | Texture layer | test_rendering_texturelayer.dart | - | - |
| TreeOwner | Tree owner | test_rendering_treeowner.dart | - | - |
| FlutterView | Flutter view | test_rendering_flutterview.dart | - | - |
| ViewConfiguration | View config | test_rendering_viewconfiguration.dart | - | - |
| AnnotationEntry | Annotation entry | test_rendering_annotationentry.dart | - | - |
| AnnotationResult | Annotation result | test_rendering_annotationresult.dart | - | - |
| LayerHandle | Layer handle | test_rendering_layerhandle.dart | - | - |
| LayerLink | Layer link | test_rendering_layerlink.dart | - | - |
| ... (additional 90 rendering classes) | Secondary render objects | test_rendering_*.dart | - | - |

---

## animation (8 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AnimationStatus | Animation state | test_animation_animationstatus.dart | - | - |
| AnimationStatusListener | Status listener | test_animation_animationstatuslistener.dart | - | - |
| AnimationController | Controller debug | test_animation_animationcontrollerdebug.dart | - | - |
| AnimationMax | Maximum animation | test_animation_animationmax.dart | - | - |
| AnimationMin | Minimum animation | test_animation_animationmin.dart | - | - |
| AnimationMean | Mean animation | test_animation_animationmean.dart | - | - |
| AnimatedValue | Animated value | test_animation_animatedvalue.dart | - | - |
| AnimatedEvaluation | Evaluation | test_animation_animatedevaluation.dart | - | - |

---

## gestures (25 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| GestureRecognizerCallback | Gesture callback | test_gestures_gesturerecognizercallback.dart | - | - |
| RecognizerCallback | Recognizer callback | test_gestures_recognizercallback.dart | - | - |
| VelocityEstimate | Velocity estimate | test_gestures_velocityestimate.dart | - | - |
| VelocityTracker | Velocity tracking | test_gestures_velocitytracker.dart | - | - |
| VelocityEstimator | Velocity estimator | test_gestures_velocityestimator.dart | - | - |
| IOSScrollViewFlingVelocityTracker | iOS fling | test_gestures_iosscrollviewflingvelocitytracker.dart | - | - |
| MacOSScrollViewFlingVelocityTracker | macOS fling | test_gestures_macosscrollviewflingvelocitytracker.dart | - | - |
| MultiTouchDragStrategy | Multi touch drag | test_gestures_multitouchdragstrategy.dart | - | - |
| DragStartBehavior | Drag start | test_gestures_dragstartbehavior.dart | - | - |
| DragStartDetails | Start details | test_gestures_dragstartdetails.dart | - | - |
| DragUpdateDetails | Update details | test_gestures_dragupdatedetails.dart | - | - |
| DragEndDetails | End details | test_gestures_dragenddetails.dart | - | - |
| DragDownDetails | Down details | test_gestures_dragdowndetails.dart | - | - |
| GestureDragStartCallback | Drag start callback | test_gestures_gesturedragstartcallback.dart | - | - |
| GestureDragUpdateCallback | Drag update callback | test_gestures_gesturedragupdatecallback.dart | - | - |
| GestureDragEndCallback | Drag end callback | test_gestures_gesturedragendcallback.dart | - | - |
| GestureDragCancelCallback | Drag cancel callback | test_gestures_gesturedragcancelcallback.dart | - | - |
| GestureDragDownCallback | Drag down callback | test_gestures_gesturedragdowncallback.dart | - | - |
| GestureScaleStartCallback | Scale start | test_gestures_gesturescalestartcallback.dart | - | - |
| GestureScaleUpdateCallback | Scale update | test_gestures_gesturescaleupdatecallback.dart | - | - |
| GestureScaleEndCallback | Scale end | test_gestures_gesturescaleendcallback.dart | - | - |
| GestureLongPressCallback | Long press | test_gestures_gesturelongpresscallback.dart | - | - |
| GestureLongPressStartCallback | Long start | test_gestures_gesturelongpressstartcallback.dart | - | - |
| GestureLongPressMoveUpdateCallback | Long move | test_gestures_gesturelongpressmoveupdatecallback.dart | - | - |
| GestureLongPressEndCallback | Long end | test_gestures_gesturelongpressendcallback.dart | - | - |

---

## services (35 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RestorationMemento | Restoration memento | test_services_restorationmemento.dart | - | - |
| RestorationData | Restoration data | test_services_restorationdata.dart | - | - |
| RestorationCallback | Restoration callback | test_services_restorationcallback.dart | - | - |
| SystemChannels | System channels | test_services_systemchannels.dart | - | - |
| SystemChrome | System chrome | test_services_systemchrome.dart | - | - |
| ApplicationSwitcherDescription | App switcher | test_services_applicationswitcherdescription.dart | - | - |
| DeviceOrientation | Orientation | test_services_deviceorientation.dart | - | - |
| SystemUiMode | UI mode | test_services_systemuimode.dart | - | - |
| SystemUiOverlay | UI overlay | test_services_systemuioverlay.dart | - | - |
| Clipboard | Clipboard access | test_services_clipboard.dart | - | - |
| ClipboardData | Clipboard data | test_services_clipboarddata.dart | - | - |
| HapticFeedback | Haptic feedback | test_services_hapticfeedback.dart | - | - |
| SystemSound | System sounds | test_services_systemsound.dart | - | - |
| SystemSoundType | Sound type | test_services_systemsoundtype.dart | - | - |
| PlatformMenu | Platform menu | test_services_platformmenu.dart | - | - |
| PlatformProvidedMenu | Provided menu | test_services_platformprovidedmenu.dart | - | - |
| PlatformMenuItemGroup | Menu group | test_services_platformmenuitemgroup.dart | - | - |
| PlatformProvidedMenuItem | Provided item | test_services_platformprovidedmenuitem.dart | - | - |
| TextInputConnection | Input connection | test_services_textinputconnection.dart | - | - |
| TextInput | Text input | test_services_textinput.dart | - | - |
| RawKeyEvent | Raw key event | test_services_rawkeyevent.dart | - | - |
| RawKeyEventData | Key event data | test_services_rawkeyeventdata.dart | - | - |
| RawKeyDownEvent | Key down | test_services_rawkeydownevent.dart | - | - |
| RawKeyUpEvent | Key up | test_services_rawkeyupevent.dart | - | - |
| KeyEvent | Key event | test_services_keyevent.dart | - | - |
| KeyDownEvent | Key down | test_services_keydownevent.dart | - | - |
| KeyUpEvent | Key up | test_services_keyupevent.dart | - | - |
| KeyRepeatEvent | Key repeat | test_services_keyrepeatevent.dart | - | - |
| KeyData | Key data | test_services_keydata.dart | - | - |
| BrowserContextMenu | Browser menu | test_services_browsercontextmenu.dart | - | - |
| LiveText | Live text | test_services_livetext.dart | - | - |
| LiveTextInputStatusNotifier | Live notifier | test_services_livetextinputstatusnotifier.dart | - | - |
| MaxLengthEnforcement | Max length | test_services_maxlengthenforcement.dart | - | - |
| SmartDashesType | Smart dashes | test_services_smartdashestype.dart | - | - |
| SmartQuotesType | Smart quotes | test_services_smartquotestype.dart | - | - |

---

## dart:ui (35 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Clip | Clipping behavior | test_dart_ui_clip.dart | - | - |
| PathFillType | Path fill rules | test_dart_ui_pathfilltype.dart | - | - |
| PathOperation | Path boolean ops | test_dart_ui_pathoperation.dart | - | - |
| StrokeCap | Line endpoints | test_dart_ui_strokecap.dart | - | - |
| StrokeJoin | Line corners | test_dart_ui_strokejoin.dart | - | - |
| PaintingStyle | Fill/stroke mode | test_dart_ui_paintingstyle.dart | - | - |
| BlendMode | Compositing | test_dart_ui_blendmode.dart | - | - |
| TileMode | Gradient tiling | test_dart_ui_tilemode.dart | - | - |
| VertexMode | Vertex rendering | test_dart_ui_vertexmode.dart | - | - |
| PointMode | Point rendering | test_dart_ui_pointmode.dart | - | - |
| ImageByteFormat | Image encoding | test_dart_ui_imagebyteformat.dart | - | - |
| PixelFormat | Pixel format | test_dart_ui_pixelformat.dart | - | - |
| Codec | Image codec | test_dart_ui_codec.dart | - | - |
| FrameInfo | Animation frame | test_dart_ui_frameinfo.dart | - | - |
| ImmutableBuffer | Immutable buffer | test_dart_ui_immutablebuffer.dart | - | - |
| ImageDescriptor | Image metadata | test_dart_ui_imagedescriptor.dart | - | - |
| PlatformDispatcher | Platform events | test_dart_ui_platformdispatcher.dart | - | - |
| FlutterView | Native view | test_dart_ui_flutterview.dart | - | - |
| DisplayFeature | Display feature | test_dart_ui_displayfeature.dart | - | - |
| DisplayFeatureType | Feature type | test_dart_ui_displayfeaturetype.dart | - | - |
| DisplayFeatureState | Feature state | test_dart_ui_displayfeaturestate.dart | - | - |
| Brightness | Light/dark mode | test_dart_ui_brightness.dart | - | - |
| AppLifecycleState | App lifecycle | test_dart_ui_applifecyclestate.dart | - | - |
| PointerSignalKind | Pointer signal | test_dart_ui_pointersignalkind.dart | - | - |
| PointerDeviceKind | Pointer device | test_dart_ui_pointerdevicekind.dart | - | - |
| KeyEventType | Key event type | test_dart_ui_keyeventtype.dart | - | - |
| KeyEventDeviceType | Device type | test_dart_ui_keyeventdevicetype.dart | - | - |
| Locale | Language locale | test_dart_ui_locale.dart | - | - |
| LocaleStringAttribute | Locale attribute | test_dart_ui_localestringattribute.dart | - | - |
| SpellOutStringAttribute | Spell out | test_dart_ui_spelloutstringattribute.dart | - | - |
| SemanticsAction | A11y action | test_dart_ui_semanticsaction.dart | - | - |
| SemanticsFlag | A11y flag | test_dart_ui_semanticsflag.dart | - | - |
| SemanticsActionHandler | Action handler | test_dart_ui_semanticsactionhandler.dart | - | - |
| SemanticsUpdateBuilder | Update builder | test_dart_ui_semanticsupdatebuilder.dart | - | - |
| SemanticsUpdate | Semantics update | test_dart_ui_semanticsupdate.dart | - | - |

---

## semantics (8 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SemanticsProperties | Full properties | test_semantics_semanticsproperties.dart | - | - |
| SemanticsEvent | Base event | test_semantics_semanticsevent.dart | - | - |
| AnnounceSemanticsEvent | Announce event | test_semantics_announcesemant icsevent.dart | - | - |
| TooltipSemanticsEvent | Tooltip event | test_semantics_tooltipsemantic7sevent.dart | - | - |
| LongPressSemanticsEvent | Long press event | test_semantics_longpresssemanticsevent.dart | - | - |
| TapSemanticEvent | Tap event | test_semantics_tapsemanticevent.dart | - | - |
| FocusSemanticsEvent | Focus event | test_semantics_focussemanticsevent.dart | - | - |
| CustomSemanticsAction | Custom action | test_semantics_customsemanticsaction.dart | - | - |

---

## scheduler (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Priority | Task priority | test_scheduler_priority.dart | - | - |
| SchedulerPhase | Scheduler state | test_scheduler_schedulerphase.dart | - | - |

---

## physics (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SpringDescription | Spring parameters | test_physics_springdescription.dart | - | - |
| BoundedFrictionSimulation | Bounded friction | test_physics_boundedfrictionsimulation.dart | - | - |

---

## Summary

| Package | Count |
|---------|-------|
| widgets | ~380 |
| material | ~500 |
| cupertino | ~380 |
| foundation | 16 |
| painting | 32 |
| rendering | ~150 |
| animation | 8 |
| gestures | 25 |
| services | 35 |
| dart:ui | 35 |
| semantics | 8 |
| scheduler | 2 |
| physics | 2 |
| **Total** | **~1,573** |
