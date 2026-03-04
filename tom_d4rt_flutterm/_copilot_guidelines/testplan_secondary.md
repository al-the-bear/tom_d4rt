# Test Plan: Secondary Classes

**Priority: SECONDARY**
**Total classes: 590**
**Covered so far: ~950 classes in 145 scripts (Batches 1-9)**

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

## Batch 6-9 Progress (24 scripts — all remaining named classes)

| Package | Script | Classes Covered | Status |
|---------|--------|----------------|--------|
| widgets | element_types_test.dart | RenderObjectElement, ComponentElement, StatefulElement, StatelessElement, ProxyElement, ParentDataElement, InheritedElement, LeafRenderObjectWidget (8) | CREATED |
| widgets | render_object_widgets_adv_test.dart | SingleChildRenderObjectWidget, MultiChildRenderObjectWidget, SlottedContainerRenderObjectMixin, SlottedRenderObjectWidget, SlottedMultiChildRenderObjectWidget, PreferredSizeWidget, PlaceholderSpan, RawImage (8) | CREATED |
| widgets | platform_menu_widgets_test.dart | DefaultPlatformMenuDelegate, PlatformMenuBar, PlatformMenu, PlatformMenuItem, PlatformMenuDelegate, DefaultTextStyleTransition, RawMagnifier, RawKeyboardListener (8) | CREATED |
| widgets | scroll_position_types_test.dart | ScrollPosition, ScrollPositionWithSingleContext, ScrollContext, ScrollActivity, IdleScrollActivity, DrivenScrollActivity, HoldScrollActivity, DragScrollActivity (8) | CREATED |
| widgets | scroll_controllers_types_test.dart | BallisticScrollActivity, ScrollDragController, ScrollHoldController, ScrollAction, KeyboardDismissBehavior, TwoDimensionalScrollView, TwoDimensionalChildDelegate, TwoDimensionalViewport (8) | CREATED |
| widgets | selection_types_test.dart | TwoDimensionalScrollable, SelectionContainer, SelectableRegion, SelectionRegistrar, SelectionRegistrarScope, SelectionEvent, SelectionHandler, SelectionOverlay (8) | CREATED |
| widgets | text_editing_adv_test.dart | TextSelectionGestureDetector, TextSelectionGestureDetectorBuilder, EditableTextState, BlacklistingTextInputFormatter, WhitelistingTextInputFormatter, SelectionHandleType, SliverChildDelegate, SliverAnimatedGrid (8) | CREATED |
| widgets | restoration_adv_test.dart | RestorableProperty, RestorableEnumN, RestorationMixin, RestorationBucket, RestorationManager, UndoHistoryState, RawGestureDetectorState, SemanticsGestureDelegate (8) | CREATED |
| widgets | shortcuts_actions_adv_test.dart | ShortcutActivator, ShortcutManager, ShortcutRegistry, ShortcutRegistryEntry, DoNothingAndStopPropagationIntent, DoNothingAndStopPropagationAction, PrioritizedAction, ContextAction (8) | CREATED |
| widgets | autofill_context_adv_test.dart | OverrideAction, AutofillGroupState, AutofillClient, AutofillScope, EditableTextContextMenuBuilder, ContextMenuController, ContextMenuRegion, ContextMenuArea (8) | CREATED |
| material | scaffold_fab_test.dart | ScaffoldFeatureController, FabTopOffsetY, FabFloatOffsetY, FabDockedOffsetY, EndFloatFabLocation, CenterFloatFabLocation, EndDockedFabLocation, CenterDockedFabLocation, EndTopFabLocation, StartTopFabLocation, EndContainedFabLocation (11) | CREATED |
| material | button_styles_misc_test.dart | ButtonBarTheme, ButtonStyleButton, RaisedButton, FlatButton, OutlineButton, MaterialBannerAction, NavigationIndicatorTransition, PopupMenuItemState, PopupMenuItemSelected (9) | CREATED |
| material | autocomplete_chips_test.dart | showDateRangePicker, RestorableTimeOfDay, AutocompleteOptionsBuilder, AutocompleteFieldViewBuilder, AutocompleteOptionsViewBuilder, AutocompleteOnSelected, TappableChipAttributes, DisabledChipAttributes, CheckableChipAttributes (9) | CREATED |
| gestures | gesture_callbacks_test.dart | GestureRecognizerCallback, RecognizerCallback, GestureDragStartCallback, GestureDragUpdateCallback, GestureDragEndCallback, GestureDragCancelCallback, GestureDragDownCallback, GestureScaleStartCallback, GestureScaleUpdateCallback (9) | CREATED |
| gestures | gesture_callbacks_adv_test.dart | GestureScaleEndCallback, GestureLongPressCallback, GestureLongPressStartCallback, GestureLongPressMoveUpdateCallback, GestureLongPressEndCallback, IOSScrollViewFlingVelocityTracker, MacOSScrollViewFlingVelocityTracker, MultiTouchDragStrategy (8) | CREATED |
| rendering | render_mixins_test.dart | RenderObjectWithChildMixin, ContainerRenderObjectMixin, ContainerParentDataMixin, RenderIndexedStack, RenderBoxAdapter, RenderSemanticsAnnotations, RenderBlockSemantics, RenderExcludeSemantics, RenderMergeSemantics (9) | CREATED |
| rendering | render_layers_pipeline_test.dart | RenderAnnotatedRegion, RenderFollowerLayer, RenderLeaderLayer, PipelineManifold, PerformanceOverlayLayer, ImageFilterLayer, ColorFilterLayer, PlatformViewLayer, TreeOwner (9) | CREATED |
| services | restoration_platform_test.dart | RestorationMemento, RestorationData, RestorationCallback, PlatformMenu, PlatformProvidedMenu, PlatformMenuItemGroup, PlatformProvidedMenuItem (7) | CREATED |
| services | key_events_adv_test.dart | TextInputConnection, TextInput, RawKeyEventData, KeyData, BrowserContextMenu, LiveText, LiveTextInputStatusNotifier (7) | CREATED |
| painting | image_stream_adv_test.dart | BeveledRectangleBorder, ResizeImage, ResizeImageKey, OneFrameImageStreamCompleter, MultiFrameImageStreamCompleter, ImageErrorListener, ImageCacheStatus, ImageInfo (8) | CREATED |
| cupertino | cupertino_misc_adv_test.dart | CupertinoLocalizations, CupertinoPageRoute, showCupertinoModalPopup, showCupertinoDialog, CupertinoSliverNavigationBar, CupertinoSegmentedControl, CupertinoSlidingSegmentedControl, CupertinoTextSelectionControls (8) | CREATED |
| dart_ui | dart_ui_misc_adv_test.dart | ImmutableBuffer, ImageDescriptor, KeyEventType, KeyEventDeviceType, SemanticsAction, SemanticsUpdateBuilder, SemanticsUpdate (7) | CREATED |
| animation | animation_misc_adv_test.dart | AnimationStatusListener, Tween/AnimatedValue, AnimatedEvaluation, SpringDescription, BoundedFrictionSimulation, Priority, SchedulerPhase (7) | CREATED |
| foundation | foundation_misc_adv_test.dart | TargetPlatform, TargetPlatformVariant, DiagnosticsNode, DiagnosticsProperty, DiagnosticPropertiesBuilder (5) | CREATED |

---

**Test harness:** `test/secondary_classes_test.dart` (145 tests total: 38 batch 1 + 29 batch 2 + 22 batch 3 + 16 batch 4 + 16 batch 5 + 24 batch 6-9)
**Total classes covered:** ~950 (all named classes covered ✅)
**Requires:** Test app running on port 4247

---


**Requires:** Test app running on port 4247

---

## widgets (183 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AlwaysScrollableScrollPhysics | Always scroll | test_widgets_alwaysscrollablescrollphysics.dart | - | - |
| AndroidView | Android view | test_widgets_android_view.dart | - | - |
| AnimatedAlign | Animated align | test_widgets_animated_align.dart | - | - |
| AnimatedCrossFade | Cross fade | test_widgets_animated_cross_fade.dart | - | - |
| AnimatedDefaultTextStyle | Animated text style | test_widgets_animateddefaulttextstyle.dart | - | - |
| AnimatedFractionallySizedBox | Animated fraction | test_widgets_animated_fractionally_sized_box.dart | - | - |
| AnimatedModalBarrier | Modal barrier | test_widgets_animated_modal_barrier.dart | - | - |
| AnimatedPhysicalModel | Animated physical | test_widgets_animated_physical_model.dart | - | - |
| AnimatedRotation | Animated rotation | test_widgets_animated_rotation.dart | - | - |
| AnimatedScale | Animated scale | test_widgets_animated_scale.dart | - | - |
| AnimatedSlide | Animated slide | test_widgets_animated_slide.dart | - | - |
| AnimatedSwitcher | Switcher | test_widgets_animated_switcher.dart | - | - |
| AutofillGroup | Autofill group | test_widgets_autofillgroup.dart | - | - |
| BackdropFilter | Backdrop filter | test_widgets_backdropfilter.dart | - | - |
| BouncingScrollPhysics | iOS scroll physics | test_widgets_bouncingscrollphysics.dart | - | - |
| BuildOwner | Build owner | test_widgets_build_owner.dart | - | - |
| BuildScope | Build scope | test_widgets_build_scope.dart | - | - |
| CheckedModeBanner | Debug banner | test_widgets_checkedmodebanner.dart | - | - |
| ClampingScrollPhysics | Android scroll physics | test_widgets_clampingscrollphysics.dart | - | - |
| ColorFiltered | Color filtered | test_widgets_colorfiltered.dart | - | - |
| ComponentElement | Component element | test_widgets_componentelement.dart | - | - |
| CompositedTransformFollower | Transform follower | test_widgets_composited_transform_follower.dart | - | - |
| CompositedTransformTarget | Transform target | test_widgets_composited_transform_target.dart | - | - |
| ContentInsertionConfiguration | Content insertion | test_widgets_content_insertion_configuration.dart | - | - |
| ContextMenuButtonItem | Context button | test_widgets_contextmenubuttonitem.dart | - | - |
| ContextMenuController | Context controller | test_widgets_contextmenucontroller.dart | - | - |
| DefaultAssetBundle | Default asset bundle | test_widgets_defaultassetbundle.dart | - | - |
| DefaultTextHeightBehavior | Text height | test_widgets_default_text_height_behavior.dart | - | - |
| DefaultTextStyle | Default text style | test_widgets_defaulttextstyle.dart | - | - |
| Directionality | Text direction | test_widgets_directionality.dart | - | - |
| DisplayFeatureSubScreen | Feature subscreen | test_widgets_displayfeaturesubscreen.dart | - | - |
| DualTransitionBuilder | Dual transition | test_widgets_dual_transition_builder.dart | - | - |
| EditableTextState | Editable state | test_widgets_editabletextstate.dart | - | - |
| Element | Widget element | test_widgets_element.dart | - | - |
| FadeInImage | Fade-in images | test_widgets_fade_in_image.dart | - | - |
| FixedExtentMetrics | Extent metrics | test_widgets_fixed_extent_metrics.dart | - | - |
| FixedExtentScrollController | Extent controller | test_widgets_fixed_extent_scroll_controller.dart | - | - |
| FixedExtentScrollPhysics | Fixed extent | test_widgets_fixed_extent_scroll_physics.dart | - | - |
| GlowingOverscrollIndicator | Glow overscroll | test_widgets_glowing_overscroll_indicator.dart | - | - |
| GridPaper | Grid paper | test_widgets_gridpaper.dart | - | - |
| HtmlElementView | Web view | test_widgets_html_element_view.dart | - | - |
| ImageFiltered | Image filtered | test_widgets_imagefiltered.dart | - | - |
| ImplicitlyAnimatedWidget | Implicit animation | test_widgets_implicitly_animated_widget.dart | - | - |
| ImplicitlyAnimatedWidgetState | Implicit state | test_widgets_implicitly_animated_widget_state.dart | - | - |
| IndexedStack | Indexed stack | test_widgets_indexed_stack.dart | - | - |
| InheritedElement | Inherited element | test_widgets_inheritedelement.dart | - | - |
| InheritedModel | Inherited model | test_widgets_inherited_model.dart | - | - |
| InheritedNotifier | Inherited notifier | test_widgets_inheritednotifier.dart | - | - |
| InheritedTheme | Inherited theme | test_widgets_inherited_theme.dart | - | - |
| InheritedWidget | Inherited widget | test_widgets_inherited_widget.dart | - | - |
| KeyedSubtree | Keyed subtree | test_widgets_keyedsubtree.dart | - | - |
| LeafRenderObjectElement | Leaf element | test_widgets_leaf_render_object_element.dart | - | - |
| LeafRenderObjectWidget | Leaf render widget | test_widgets_leafrenderobjectwidget.dart | - | - |
| ListWheelChildBuilderDelegate | Builder delegate | test_widgets_list_wheel_child_builder_delegate.dart | - | - |
| ListWheelChildDelegate | Child delegate | test_widgets_list_wheel_child_delegate.dart | - | - |
| ListWheelChildListDelegate | List delegate | test_widgets_list_wheel_child_list_delegate.dart | - | - |
| ListWheelChildLoopingListDelegate | Looping delegate | test_widgets_list_wheel_child_looping_list_delegate.dart | - | - |
| ListWheelElement | Wheel element | test_widgets_list_wheel_element.dart | - | - |
| ListWheelScrollView | Wheel scroll | test_widgets_list_wheel_scroll_view.dart | - | - |
| ListWheelViewport | Wheel viewport | test_widgets_list_wheel_viewport.dart | - | - |
| MagnifierController | Magnifier controller | test_widgets_magnifiercontroller.dart | - | - |
| MagnifierDecoration | Magnifier decoration | test_widgets_magnifierdecoration.dart | - | - |
| MagnifierInfo | Magnifier info | test_widgets_magnifier_info.dart | - | - |
| MultiChildRenderObjectElement | Multi element | test_widgets_multi_child_render_object_element.dart | - | - |
| MultiChildRenderObjectWidget | Multi child render | test_widgets_multichildrenderobjectwidget.dart | - | - |
| NavigationToolbar | Nav toolbar | test_widgets_navigation_toolbar.dart | - | - |
| NeverScrollableScrollPhysics | Never scroll | test_widgets_neverscrollablescrollphysics.dart | - | - |
| OverflowBar | Overflow bar | test_widgets_overflow_bar.dart | - | - |
| OverflowBox | Overflow box | test_widgets_overflow_box.dart | - | - |
| PageScrollPhysics | Page scroll | test_widgets_pagescrollphysics.dart | - | - |
| PageStorage | Page storage | test_widgets_pagestorage.dart | - | - |
| PageStorageBucket | Page bucket | test_widgets_pagestoragebucket.dart | - | - |
| PageStorageKey | Page storage key | test_widgets_pagestoragekey.dart | - | - |
| ParentDataElement | Parent data element | test_widgets_parentdataelement.dart | - | - |
| ParentDataWidget | Parent data | test_widgets_parent_data_widget.dart | - | - |
| PerformanceOverlay | Perf overlay | test_widgets_performance_overlay.dart | - | - |
| PhysicalModel | Physical model | test_widgets_physicalmodel.dart | - | - |
| PhysicalShape | Physical shape | test_widgets_physicalshape.dart | - | - |
| PinnedHeaderSliver | Pinned header | test_widgets_pinned_header_sliver.dart | - | - |
| Placeholder | Placeholder widget | test_widgets_placeholder.dart | - | - |
| PlatformMenu | Platform menu | test_services_platformmenu.dart | - | - |
| PlatformMenuBar | Platform menu bar | test_widgets_platformmenubar.dart | - | - |
| PlatformMenuItem | Platform menu item | test_widgets_platformmenuitem.dart | - | - |
| PlatformMenuItemGroup | Menu group | test_services_platformmenuitemgroup.dart | - | - |
| PlatformProvidedMenuItem | Provided item | test_services_platformprovidedmenuitem.dart | - | - |
| PlatformViewLink | View link | test_widgets_platform_view_link.dart | - | - |
| PlatformViewSurface | View surface | test_widgets_platform_view_surface.dart | - | - |
| PopScope | Pop scope | test_widgets_popscope.dart | - | - |
| PositionedDirectional | RTL positioned | test_widgets_positioned_directional.dart | - | - |
| PrimaryScrollController | Primary scroll | test_widgets_primaryscrollcontroller.dart | - | - |
| ProxyElement | Proxy element | test_widgets_proxyelement.dart | - | - |
| ProxyWidget | Proxy widget | test_widgets_proxy_widget.dart | - | - |
| RadioGroup | Radio group | test_widgets_radio_group.dart | - | - |
| RangeMaintainingScrollPhysics | Range maintaining | test_widgets_rangemaintainingscrollphysics.dart | - | - |
| RawMagnifier | Low-level magnifier | test_widgets_rawmagnifier.dart | - | - |
| RawView | Raw view | test_widgets_raw_view.dart | - | - |
| RenderObjectElement | Render object element | test_widgets_renderobjectelement.dart | - | - |
| RenderObjectWidget | Render object widget | test_widgets_renderobjectwidget.dart | - | - |
| RestorableBool | Restorable bool | test_widgets_restorable_bool.dart | - | - |
| RestorableDateTime | Restorable datetime | test_widgets_restorabledatetime.dart | - | - |
| RestorableDouble | Restorable double | test_widgets_restorable_double.dart | - | - |
| RestorableEnum | Restorable enum | test_widgets_restorableenum.dart | - | - |
| RestorableInt | Restorable int | test_widgets_restorable_int.dart | - | - |
| RestorableProperty | Restorable property | test_widgets_restorableproperty.dart | - | - |
| RestorableString | Restorable string | test_widgets_restorablestring.dart | - | - |
| RestorableTextEditingController | Restorable controller | test_widgets_restorabletexteditingcontroller.dart | - | - |
| RestorableValue | Restorable value | test_widgets_restorablevalue.dart | - | - |
| RestorationMixin | Restoration mixin | test_widgets_restorationmixin.dart | - | - |
| RestorationScope | Restoration scope | test_widgets_restorationscope.dart | - | - |
| RootElement | Root element | test_widgets_root_element.dart | - | - |
| RootRestorationScope | Root restoration | test_widgets_rootrestorationscope.dart | - | - |
| RootWidget | Root widget | test_widgets_root_widget.dart | - | - |
| ScrollAction | Scroll action | test_widgets_scrollaction.dart | - | - |
| ScrollBehavior | Scroll behavior | test_widgets_scrollbehavior.dart | - | - |
| ScrollConfiguration | Scroll configuration | test_widgets_scrollconfiguration.dart | - | - |
| ScrollIntent | Scroll intent | test_widgets_scrollintent.dart | - | - |
| ScrollMetrics | Scroll metrics | test_widgets_scrollmetrics.dart | - | - |
| ScrollPhysics | Scroll physics | test_widgets_scrollphysics.dart | - | - |
| ScrollPosition | Scroll position | test_widgets_scrollposition.dart | - | - |
| Scrollable | Scrollable widget | test_widgets_scrollable.dart | - | - |
| ScrollableState | Scrollable state | test_widgets_scrollable_state.dart | - | - |
| SelectableRegion | Selectable region | test_widgets_selectableregion.dart | - | - |
| SelectionContainer | Selection container | test_widgets_selectioncontainer.dart | - | - |
| SelectionListener | Selection listener | test_widgets_selection_listener.dart | - | - |
| SelectionOverlay | Selection overlay | test_widgets_selectionoverlay.dart | - | - |
| ShaderMask | Shader mask | test_widgets_shadermask.dart | - | - |
| SharedAppData | Shared app data | test_widgets_shared_app_data.dart | - | - |
| ShrinkWrappingViewport | Shrink viewport | test_widgets_shrink_wrapping_viewport.dart | - | - |
| SingleChildRenderObjectElement | Single element | test_widgets_single_child_render_object_element.dart | - | - |
| SingleChildRenderObjectWidget | Single child render | test_widgets_singlechildrenderobjectwidget.dart | - | - |
| SingleTickerProviderStateMixin | Single ticker | test_widgets_single_ticker_provider_state_mixin.dart | - | - |
| SliverAnimatedGrid | Animated sliver grid | test_widgets_sliveranimatedgrid.dart | - | - |
| SliverAnimatedList | Animated sliver list | test_widgets_sliveranimatedlist.dart | - | - |
| SliverAnimatedOpacity | Animated opacity | test_widgets_sliveranimatedopacity.dart | - | - |
| SliverConstrainedCrossAxis | Constrained cross | test_widgets_sliver_constrained_cross_axis.dart | - | - |
| SliverCrossAxisExpanded | Cross expanded | test_widgets_sliver_cross_axis_expanded.dart | - | - |
| SliverCrossAxisGroup | Cross axis group | test_widgets_slivercrossaxisgroup.dart | - | - |
| SliverFloatingHeader | Floating header | test_widgets_sliver_floating_header.dart | - | - |
| SliverIgnorePointer | Sliver ignore pointer | test_widgets_sliverignorepointer.dart | - | - |
| SliverLayoutBuilder | Layout builder | test_widgets_sliverlayoutbuilder.dart | - | - |
| SliverMainAxisGroup | Main axis group | test_widgets_slivermainaxisgroup.dart | - | - |
| SliverOffstage | Sliver offstage | test_widgets_sliver_offstage.dart | - | - |
| SliverPrototypeExtentList | Prototype list | test_widgets_sliverprototypeextentlist.dart | - | - |
| SliverReorderableList | Reorderable sliver | test_widgets_sliverreorderablelist.dart | - | - |
| SliverResizingHeader | Resizing header | test_widgets_sliver_resizing_header.dart | - | - |
| SliverSafeArea | Sliver safe area | test_widgets_sliversafearea.dart | - | - |
| SliverSemantics | Sliver semantics | test_widgets_sliver_semantics.dart | - | - |
| SliverVisibility | Sliver visibility | test_widgets_slivervisibility.dart | - | - |
| Spacer | Spacer widget | test_widgets_spacer.dart | - | - |
| SpellCheckConfiguration | Spell config | test_widgets_spellcheckconfiguration.dart | - | - |
| StatefulElement | Stateful element | test_widgets_statefulelement.dart | - | - |
| StatelessElement | Stateless element | test_widgets_statelesselement.dart | - | - |
| StretchingOverscrollIndicator | Stretch overscroll | test_widgets_stretching_overscroll_indicator.dart | - | - |
| TableCell | Table cell | test_widgets_table_cell.dart | - | - |
| TableRow | Table row | test_widgets_table_row.dart | - | - |
| TapRegion | Tap region | test_widgets_tap_region.dart | - | - |
| TapRegionSurface | Tap surface | test_widgets_tap_region_surface.dart | - | - |
| TextFieldTapRegion | Text tap region | test_widgets_text_field_tap_region.dart | - | - |
| TextMagnifierConfiguration | Magnifier config | test_widgets_textmagnifierconfiguration.dart | - | - |
| TextSelectionControls | Text controls | test_widgets_textselectioncontrols.dart | - | - |
| TextSelectionGestureDetector | Selection gesture | test_widgets_textselectiongesturedetector.dart | - | - |
| TextSelectionOverlay | Selection overlay | test_widgets_text_selection_overlay.dart | - | - |
| TextSelectionToolbarAnchors | Toolbar anchors | test_widgets_text_selection_toolbar_anchors.dart | - | - |
| TickerMode | Ticker mode | test_widgets_ticker_mode.dart | - | - |
| TickerProviderStateMixin | Ticker mixin | test_widgets_ticker_provider_state_mixin.dart | - | - |
| Title | App title | test_widgets_title.dart | - | - |
| TooltipTriggerMode | Trigger mode | test_widgets_tooltip_trigger_mode.dart | - | - |
| TweenAnimationBuilder | Tween builder | test_widgets_tween_animation_builder.dart | - | - |
| UiKitView | iOS view | test_widgets_ui_kit_view.dart | - | - |
| UndoHistory | Undo history widget | test_widgets_undohistory.dart | - | - |
| UndoHistoryController | Undo history | test_widgets_undohistorycontroller.dart | - | - |
| View | View widget | test_widgets_view.dart | - | - |
| ViewAnchor | View anchor | test_widgets_view_anchor.dart | - | - |
| ViewCollection | View collection | test_widgets_view_collection.dart | - | - |
| Viewport | Viewport widget | test_widgets_viewport.dart | - | - |
| Widget | Widget base | test_widgets_widget.dart | - | - |
| WidgetInspector | Widget inspector | test_widgets_widget_inspector.dart | - | - |
| WidgetSpan | Widget in text | test_widgets_widgetspan.dart | - | - |
| WidgetsApp | Widgets app | test_widgets_widgets_app.dart | - | - |
| WidgetsBinding | Widgets binding | test_widgets_widgets_binding.dart | - | - |
| WidgetsBindingObserver | Binding observer | test_widgets_widgets_binding_observer.dart | - | - |
| WidgetsFlutterBinding | Flutter binding | test_widgets_widgets_flutter_binding.dart | - | - |
| WillPopScope | Will pop scope | test_widgets_willpopscope.dart | - | - |

---

## material (110 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ActionIconThemeData | Action icon data | test_material_action_icon_theme_data.dart | - | - |
| AdaptiveTextSelectionToolbar | Adaptive toolbar | test_widgets_adaptivetextselectiontoolbar.dart | - | - |
| AppBarThemeData | App bar data | test_material_app_bar_theme_data.dart | - | - |
| BadgeThemeData | Badge data | test_material_badge_theme_data.dart | - | - |
| BaseRangeSliderTrackShape | Base range track | test_material_base_range_slider_track_shape.dart | - | - |
| BaseSliderTrackShape | Base track | test_material_base_slider_track_shape.dart | - | - |
| BottomAppBarThemeData | Bottom data | test_material_bottom_app_bar_theme_data.dart | - | - |
| BottomSheetThemeData | Sheet data | test_material_bottom_sheet_theme_data.dart | - | - |
| ButtonState | Button state | test_material_button_state.dart | - | - |
| ButtonStyleButton | Style button | test_material_buttonstylebutton.dart | - | - |
| CalendarDelegate | Calendar delegate | test_material_calendar_delegate.dart | - | - |
| CardThemeData | Card data | test_material_card_theme_data.dart | - | - |
| CheckboxListTile | Checkbox tile | test_material_checkbox_list_tile.dart | - | - |
| CheckboxThemeData | Checkbox data | test_material_checkbox_theme_data.dart | - | - |
| CheckmarkableChipAttributes | Checkmarkable | test_material_checkmarkable_chip_attributes.dart | - | - |
| ChipAnimationStyle | Chip animation | test_material_chip_animation_style.dart | - | - |
| ChipAttributes | Chip attributes | test_material_chipattributes.dart | - | - |
| ChipThemeData | Chip theme data | test_material_chipthemedata.dart | - | - |
| Colors | Color constants | test_material_colors.dart | - | - |
| ControlsDetails | Controls details | test_material_controls_details.dart | - | - |
| DataTableSource | Data source | test_material_data_table_source.dart | - | - |
| DataTableTheme | Table theme | test_material_data_table_theme.dart | - | - |
| DataTableThemeData | Table data | test_material_data_table_theme_data.dart | - | - |
| DatePickerThemeData | Date data | test_material_date_picker_theme_data.dart | - | - |
| DateRangePickerDialog | Range dialog | test_material_daterangepickerdialog.dart | - | - |
| DateTimeRange | Date range | test_material_datetimerange.dart | - | - |
| DateUtils | Date utilities | test_material_dateutils.dart | - | - |
| DefaultMaterialLocalizations | Default locale | test_material_default_material_localizations.dart | - | - |
| DeletableChipAttributes | Deletable chip | test_material_deletablechipattributes.dart | - | - |
| DesktopTextSelectionControls | Desktop controls | test_material_desktop_text_selection_controls.dart | - | - |
| DesktopTextSelectionToolbar | Desktop toolbar | test_material_desktop_text_selection_toolbar.dart | - | - |
| DesktopTextSelectionToolbarButton | Desktop button | test_material_desktop_text_selection_toolbar_button.dart | - | - |
| DialogThemeData | Dialog data | test_material_dialog_theme_data.dart | - | - |
| DisabledChipAttributes | Disabled chip | test_material_disabledchipattributes.dart | - | - |
| DividerThemeData | Divider data | test_material_divider_theme_data.dart | - | - |
| DrawerThemeData | Drawer data | test_material_drawer_theme_data.dart | - | - |
| DropdownMenuThemeData | Dropdown data | test_material_dropdown_menu_theme_data.dart | - | - |
| ExpansionTileThemeData | Expansion data | test_material_expansion_tile_theme_data.dart | - | - |
| FilledButtonThemeData | Filled data | test_material_filled_button_theme_data.dart | - | - |
| FloatingActionButtonAnimator | FAB animator | test_material_floatingactionbuttonanimator.dart | - | - |
| FloatingActionButtonLocation | FAB location | test_material_floatingactionbuttonlocation.dart | - | - |
| FloatingActionButtonThemeData | FAB data | test_material_floating_action_button_theme_data.dart | - | - |
| GlobalMaterialLocalizations | Global locale | test_material_global_material_localizations.dart | - | - |
| IconButtonThemeData | Icon data | test_material_icon_button_theme_data.dart | - | - |
| InputDecorationTheme | Input theme | test_material_inputdecorationtheme.dart | - | - |
| InputDecoratorState | Decorator state | test_material_input_decorator_state.dart | - | - |
| ListTileThemeData | Tile data | test_material_list_tile_theme_data.dart | - | - |
| MaterialApp.router | Router app | test_material_material_app.router.dart | - | - |
| MaterialBannerThemeData | Banner data | test_material_material_banner_theme_data.dart | - | - |
| MaterialButton | Material button | test_material_materialbutton.dart | - | - |
| MaterialLocalizations | Localization | test_material_material_localizations.dart | - | - |
| MaterialTextSelectionControls | Material controls | test_material_material_text_selection_controls.dart | - | - |
| MaterialType | Material type | test_material_materialtype.dart | - | - |
| MenuBarThemeData | Menu bar data | test_material_menu_bar_theme_data.dart | - | - |
| MenuStyle | Menu style | test_material_menu_style.dart | - | - |
| MenuThemeData | Menu data | test_material_menu_theme_data.dart | - | - |
| MonthPickerSelector | Month selector | test_material_month_picker_selector.dart | - | - |
| NavigationBarThemeData | Nav data | test_material_navigation_bar_theme_data.dart | - | - |
| NavigationDrawerThemeData | Nav drawer data | test_material_navigation_drawer_theme_data.dart | - | - |
| NavigationRailThemeData | Rail data | test_material_navigation_rail_theme_data.dart | - | - |
| OutlinedButtonThemeData | Outlined data | test_material_outlined_button_theme_data.dart | - | - |
| PopupMenuThemeData | Popup data | test_material_popup_menu_theme_data.dart | - | - |
| ProgressIndicatorThemeData | Progress data | test_material_progress_indicator_theme_data.dart | - | - |
| RadioListTile | Radio tile | test_material_radio_list_tile.dart | - | - |
| RadioThemeData | Radio data | test_material_radio_theme_data.dart | - | - |
| RangeLabels | Range labels | test_material_range_labels.dart | - | - |
| RangeSlider | Range slider | test_material_range_slider.dart | - | - |
| RangeSliderThumbShape | Range thumb | test_material_range_slider_thumb_shape.dart | - | - |
| RangeSliderTickMarkShape | Range tick | test_material_range_slider_tick_mark_shape.dart | - | - |
| RangeSliderTrackShape | Range track | test_material_range_slider_track_shape.dart | - | - |
| RangeSliderValueIndicatorShape | Range indicator | test_material_range_slider_value_indicator_shape.dart | - | - |
| RangeValues | Range values | test_material_range_values.dart | - | - |
| RawMaterialButton | Raw material button | test_material_rawmaterialbutton.dart | - | - |
| RectangularSliderTrackShape | Rect track | test_material_rectangular_slider_track_shape.dart | - | - |
| RoundSliderOverlayShape | Round overlay | test_material_round_slider_overlay_shape.dart | - | - |
| RoundSliderThumbShape | Round thumb | test_material_round_slider_thumb_shape.dart | - | - |
| RoundSliderTickMarkShape | Round tick | test_material_round_slider_tick_mark_shape.dart | - | - |
| RoundedRectSliderTrackShape | Rounded track | test_material_rounded_rect_slider_track_shape.dart | - | - |
| ScaffoldFeatureController | Feature controller | test_material_scaffoldfeaturecontroller.dart | - | - |
| ScaffoldMessenger | Messenger | test_material_scaffoldmessenger.dart | - | - |
| ScaffoldMessengerState | Messenger state | test_material_scaffoldmessengerstate.dart | - | - |
| ScaffoldState | Scaffold state | test_material_scaffoldstate.dart | - | - |
| SearchBarThemeData | Search data | test_material_search_bar_theme_data.dart | - | - |
| SearchViewThemeData | Search view data | test_material_search_view_theme_data.dart | - | - |
| SegmentedButtonThemeData | Segment data | test_material_segmented_button_theme_data.dart | - | - |
| SelectableChipAttributes | Selectable chip | test_material_selectablechipattributes.dart | - | - |
| SliderComponentShape | Component shape | test_material_slider_component_shape.dart | - | - |
| SliderThemeData | Slider data | test_material_slider_theme_data.dart | - | - |
| SliderTickMarkShape | Tick shape | test_material_slider_tick_mark_shape.dart | - | - |
| SliderTrackShape | Track shape | test_material_slider_track_shape.dart | - | - |
| SnackBarAction | Snackbar action | test_material_snackbaraction.dart | - | - |
| SnackBarBehavior | Snackbar behavior | test_material_snackbarbehavior.dart | - | - |
| SnackBarClosedReason | Snackbar reason | test_material_snackbarclosedeason.dart | - | - |
| SpellCheckSuggestionsToolbar | Spell suggestions | test_material_spell_check_suggestions_toolbar.dart | - | - |
| StepState | Step state | test_material_step_state.dart | - | - |
| StepperType | Stepper type | test_material_stepper_type.dart | - | - |
| SwitchListTile | Switch tile | test_material_switch_list_tile.dart | - | - |
| SwitchThemeData | Switch data | test_material_switch_theme_data.dart | - | - |
| TabBarIndicatorSize | Indicator size | test_material_tabbarindicatorsize.dart | - | - |
| TabBarThemeData | Tab data | test_material_tab_bar_theme_data.dart | - | - |
| TextButtonThemeData | Text data | test_material_text_button_theme_data.dart | - | - |
| TextSelectionThemeData | Selection data | test_widgets_textselectionthemedata.dart | - | - |
| TextSelectionToolbar | Selection toolbar | test_material_text_selection_toolbar.dart | - | - |
| TextSelectionToolbarTextButton | Toolbar button | test_material_text_selection_toolbar_text_button.dart | - | - |
| TimePickerThemeData | Time data | test_material_time_picker_theme_data.dart | - | - |
| TooltipThemeData | Tooltip data | test_material_tooltip_theme_data.dart | - | - |
| TooltipVisibility | Visibility | test_material_tooltip_visibility.dart | - | - |
| Typography | Typography styles | test_material_typography.dart | - | - |
| VisualDensity | Visual density | test_material_visualdensity.dart | - | - |
| YearPickerSelector | Year selector | test_material_year_picker_selector.dart | - | - |

---

## cupertino (33 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| CupertinoAnimatedBuilder | Builder | test_cupertino_cupertino_animated_builder.dart | - | - |
| CupertinoAnimatedCrossFade | Cross fade | test_cupertino_cupertino_animated_cross_fade.dart | - | - |
| CupertinoBottomTabScaffold | Tab scaffold | test_cupertino_cupertino_bottom_tab_scaffold.dart | - | - |
| CupertinoDebugPaint | Debug paint | test_cupertino_cupertino_debug_paint.dart | - | - |
| CupertinoDynamicType | Dynamic type | test_cupertino_cupertino_dynamic_type.dart | - | - |
| CupertinoErrorWidget | Error widget | test_cupertino_cupertino_error_widget.dart | - | - |
| CupertinoFullscreenDialog | Dialog | test_cupertino_cupertino_fullscreen_dialog.dart | - | - |
| CupertinoHeroRect | Hero rect | test_cupertino_cupertino_hero_rect.dart | - | - |
| CupertinoMagnifierController | Magnifier controller | test_cupertino_cupertino_magnifier_controller.dart | - | - |
| CupertinoPage | Page widget | test_cupertino_cupertino_page.dart | - | - |
| CupertinoPickerConfiguration | Picker config | test_cupertino_cupertino_picker_configuration.dart | - | - |
| CupertinoPickerDefaultSelectionOverlay | Selection overlay | test_cupertino_cupertino_picker_default_selection_overlay.dart | - | - |
| CupertinoPickerDialogMode | Dialog mode | test_cupertino_cupertino_picker_dialog_mode.dart | - | - |
| CupertinoPickerScrollController | Scroll controller | test_cupertino_cupertino_picker_scroll_controller.dart | - | - |
| CupertinoResizeImage | Resize image | test_cupertino_cupertino_resize_image.dart | - | - |
| CupertinoScaffoldBackgroundColor | BG color | test_cupertino_cupertino_scaffold_background_color.dart | - | - |
| CupertinoScrollBehavior | Cupertino scroll | test_widgets_cupertinoscrollbehavior.dart | - | - |
| CupertinoSegmentedControlStyle | Segmented style | test_cupertino_cupertinosegmentedcontrolstyle.dart | - | - |
| CupertinoSegmentedControlTheme | Control theme | test_cupertino_cupertino_segmented_control_theme.dart | - | - |
| CupertinoSheetAnimation | Sheet animation | test_cupertino_cupertino_sheet_animation.dart | - | - |
| CupertinoSheetConfiguration | Sheet config | test_cupertino_cupertino_sheet_configuration.dart | - | - |
| CupertinoSheetDragDetails | Drag details | test_cupertino_cupertino_sheet_drag_details.dart | - | - |
| CupertinoSheetRoute | Sheet route | test_cupertino_cupertino_sheet_route.dart | - | - |
| CupertinoSheetTransition | Sheet transition | test_cupertino_cupertino_sheet_transition.dart | - | - |
| CupertinoSlidingSegmentedControlTheme | Sliding theme | test_cupertino_cupertino_sliding_segmented_control_theme.dart | - | - |
| CupertinoSpellCheckSuggestionsToolbar | Spell toolbar | test_cupertino_cupertino_spell_check_suggestions_toolbar.dart | - | - |
| CupertinoStatusBar | Status bar | test_cupertino_cupertino_status_bar.dart | - | - |
| CupertinoTargetPlatform | Target platform | test_cupertino_cupertino_target_platform.dart | - | - |
| CupertinoTextMagnifier | Text magnifier | test_cupertino_cupertino_text_magnifier.dart | - | - |
| CupertinoTextMagnifierConfiguration | Magnifier config | test_cupertino_cupertino_text_magnifier_configuration.dart | - | - |
| CupertinoTextSelectionControls | iOS controls | test_cupertino_cupertino_text_selection_controls.dart | - | - |
| CupertinoTransitions | Transitions | test_cupertino_cupertino_transitions.dart | - | - |
| ObstructingPreferredSizeWidget | Obstructing widget | test_cupertino_obstructing_preferred_size_widget.dart | - | - |

---

## foundation (16 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AggregatedTimedBlock | Aggregated timing | test_foundation_aggregated_timed_block.dart | - | - |
| AggregatedTimings | Timing aggregation | test_foundation_aggregated_timings.dart | - | - |
| BitField | Bit manipulation | test_foundation_bitfield.dart | - | - |
| FlutterTimeline | Timeline events | test_foundation_flutter_timeline.dart | - | - |
| HashedObserverList | Hashed observers | test_foundation_hashedobserverlist.dart | - | - |
| ObserverList | Observer list | test_foundation_observerlist.dart | - | - |
| PartialStackFrame | Partial frame info | test_foundation_partial_stack_frame.dart | - | - |
| PersistentHashMap | Immutable hash map | test_foundation_persistent_hash_map.dart | - | - |
| ReadBuffer | Read buffer | test_foundation_readbuffer.dart | - | - |
| RepetitiveStackFrameFilter | Repetitive frame filter | test_foundation_repetitive_stack_frame_filter.dart | - | - |
| StackFilter | Stack filtering | test_foundation_stack_filter.dart | - | - |
| StackFrame | Stack frame info | test_foundation_stack_frame.dart | - | - |
| SynchronousFuture | Sync future | test_foundation_synchronousfuture.dart | - | - |
| TimedBlock | Timed code block | test_foundation_timed_block.dart | - | - |
| Unicode | Unicode utilities | test_foundation_unicode.dart | - | - |
| WriteBuffer | Write buffer | test_foundation_writebuffer.dart | - | - |

---

## painting (32 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AutomaticNotchedShape | Auto-notched shape | test_painting_automatic_notched_shape.dart | - | - |
| BorderDirectional | RTL-aware border | test_painting_border_directional.dart | - | - |
| BoxBorder | Base box border | test_painting_box_border.dart | - | - |
| BoxPainter | Decoration painter | test_painting_box_painter.dart | - | - |
| CircularNotchedRectangle | FAB notch | test_painting_circularnotchedrectangle.dart | - | - |
| Decoration | Base decoration | test_painting_decoration.dart | - | - |
| DecorationImagePainter | Image painter | test_painting_decoration_image_painter.dart | - | - |
| FlutterLogoDecoration | Flutter logo | test_painting_flutter_logo_decoration.dart | - | - |
| Gradient | Base gradient | test_painting_gradient.dart | - | - |
| GradientRotation | Gradient rotation | test_painting_gradientrotation.dart | - | - |
| GradientTransform | Gradient transform | test_painting_gradienttransform.dart | - | - |
| ImageCache | Image cache | test_painting_imagecache.dart | - | - |
| ImageCacheStatus | Cache status | test_painting_imagecachestatus.dart | - | - |
| ImageChunkEvent | Chunk event | test_painting_imagechunkevent.dart | - | - |
| ImageConfiguration | Image config | test_painting_imageconfiguration.dart | - | - |
| ImageInfo | Image info | test_painting_imageinfo.dart | - | - |
| ImageStream | Image stream | test_painting_imagestream.dart | - | - |
| ImageStreamCompleter | Image completer | test_painting_imagestreamcompleter.dart | - | - |
| ImageStreamListener | Image listener | test_painting_imagestreamlistener.dart | - | - |
| LinearBorder | Linear border | test_painting_linear_border.dart | - | - |
| LinearBorderEdge | Linear border edge | test_painting_linear_border_edge.dart | - | - |
| NotchedShape | Shape with notch | test_painting_notched_shape.dart | - | - |
| OutlinedBorder | Shape with outline | test_painting_outlined_border.dart | - | - |
| PlaceholderDimensions | Placeholder dimensions | test_painting_placeholderdimensions.dart | - | - |
| PlaceholderSpan | Placeholder span | test_widgets_placeholderspan.dart | - | - |
| ResizeImage | Resize image | test_painting_resizeimage.dart | - | - |
| ResizeImageKey | Resize key | test_painting_resizeimagekey.dart | - | - |
| RoundedSuperellipseBorder | Superellipse border | test_painting_rounded_superellipse_border.dart | - | - |
| ShapeBorder | Base shape border | test_painting_shape_border.dart | - | - |
| StarBorder | Star shape | test_painting_star_border.dart | - | - |
| Vector2 | 2D vector | test_painting_vector2.dart | - | - |
| WordBoundary | Word boundary detection | test_painting_word_boundary.dart | - | - |

---

## rendering (107 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| BoxHitTestEntry | Hit entry | test_rendering_boxhittestentry.dart | - | - |
| BoxHitTestResult | Hit test | test_rendering_boxhittestresult.dart | - | - |
| ClipPathLayer | Clip path layer | test_rendering_clip_path_layer.dart | - | - |
| ClipRSuperellipseLayer | Superellipse clip | test_rendering_clip_r_superellipse_layer.dart | - | - |
| ColorFilterLayer | Color filter layer | test_rendering_color_filter_layer.dart | - | - |
| Constraints | Base constraints | test_rendering_constraints.dart | - | - |
| ContainerBoxParentData | Container parent | test_rendering_containerboxparentdata.dart | - | - |
| ContainerRenderObjectMixin | Container mixin | test_rendering_containerrenderobjectmixin.dart | - | - |
| CustomPainterSemantics | Painter semantics | test_rendering_custom_painter_semantics.dart | - | - |
| DebugOverflowIndicatorMixin | Overflow debug | test_rendering_debug_overflow_indicator_mixin.dart | - | - |
| FollowerLayer | Follower layer | test_rendering_followerlayer.dart | - | - |
| KeepAliveParentDataMixin | Keep alive data | test_rendering_keep_alive_parent_data_mixin.dart | - | - |
| LayerHandle | Layer handle | test_rendering_layerhandle.dart | - | - |
| LayerLink | Layer link | test_rendering_layerlink.dart | - | - |
| LeaderLayer | Leader layer | test_rendering_leaderlayer.dart | - | - |
| ListBodyParentData | List body data | test_rendering_list_body_parent_data.dart | - | - |
| ListWheelParentData | Wheel parent data | test_rendering_list_wheel_parent_data.dart | - | - |
| MouseTracker | Mouse tracking | test_rendering_mouse_tracker.dart | - | - |
| ParentData | Base parent data | test_rendering_parent_data.dart | - | - |
| PerformanceOverlayLayer | Perf layer | test_rendering_performanceoverlaylayer.dart | - | - |
| PictureLayer | Picture layer | test_rendering_picturelayer.dart | - | - |
| PlatformViewLayer | Platform view | test_rendering_platformviewlayer.dart | - | - |
| RelayoutWhenSystemFontsChangeMixin | Font relayout | test_rendering_relayout_when_system_fonts_change_mixin.dart | - | - |
| RenderAbsorbPointer | Absorb pointer | test_rendering_renderabsorbpointer.dart | - | - |
| RenderAligningShiftedBox | Aligning shifted | test_rendering_render_aligning_shifted_box.dart | - | - |
| RenderAnimatedOpacity | Animated opacity | test_rendering_renderanimatedopacity.dart | - | - |
| RenderAnimatedSize | Animated size | test_rendering_render_animated_size.dart | - | - |
| RenderAnnotatedRegion | Annotated region | test_rendering_renderannotatedregion.dart | - | - |
| RenderBackdropFilter | Backdrop filter | test_rendering_render_backdrop_filter.dart | - | - |
| RenderBaseline | Baseline | test_rendering_render_baseline.dart | - | - |
| RenderBlockSemantics | Block semantics | test_rendering_renderblocksemantics.dart | - | - |
| RenderBoxContainerDefaultsMixin | Container defaults | test_rendering_render_box_container_defaults_mixin.dart | - | - |
| RenderConstrainedOverflowBox | Overflow box | test_rendering_renderconstrainedoverflowbox.dart | - | - |
| RenderConstraintsTransformBox | Constraints transform | test_rendering_render_constraints_transform_box.dart | - | - |
| RenderCustomMultiChildLayoutBox | Custom multi layout | test_rendering_render_custom_multi_child_layout_box.dart | - | - |
| RenderCustomPaint | Custom paint | test_rendering_rendercustompaint.dart | - | - |
| RenderCustomSingleChildLayoutBox | Custom single layout | test_rendering_render_custom_single_child_layout_box.dart | - | - |
| RenderEditable | Editable text | test_rendering_rendereditable.dart | - | - |
| RenderErrorBox | Error display | test_rendering_render_error_box.dart | - | - |
| RenderExcludeSemantics | Exclude semantics | test_rendering_renderexcludesemantics.dart | - | - |
| RenderFollowerLayer | Follower layer | test_rendering_renderfollowerlayer.dart | - | - |
| RenderFractionalTranslation | Fractional translation | test_rendering_render_fractional_translation.dart | - | - |
| RenderFractionallySizedOverflowBox | Fractional overflow | test_rendering_render_fractionally_sized_overflow_box.dart | - | - |
| RenderIgnoreBaseline | Ignore baseline | test_rendering_render_ignore_baseline.dart | - | - |
| RenderIgnorePointer | Ignore pointer | test_rendering_renderignorepointer.dart | - | - |
| RenderIndexedSemantics | Indexed semantics | test_rendering_render_indexed_semantics.dart | - | - |
| RenderIndexedStack | Indexed stack | test_rendering_renderindexedstack.dart | - | - |
| RenderLeaderLayer | Leader layer | test_rendering_renderleaderlayer.dart | - | - |
| RenderListWheelViewport | Wheel viewport | test_rendering_render_list_wheel_viewport.dart | - | - |
| RenderMergeSemantics | Merge semantics | test_rendering_rendermergesemantics.dart | - | - |
| RenderMetaData | Meta data | test_rendering_render_meta_data.dart | - | - |
| RenderMouseRegion | Mouse region | test_rendering_rendermouseregion.dart | - | - |
| RenderObjectWithChildMixin | Child mixin | test_rendering_renderobjectwithchildmixin.dart | - | - |
| RenderOffstage | Offstage render | test_rendering_renderoffstage.dart | - | - |
| RenderPhysicalModel | Physical model | test_rendering_renderphysicalmodel.dart | - | - |
| RenderPhysicalShape | Physical shape | test_rendering_renderphysicalshape.dart | - | - |
| RenderPointerListener | Pointer listener | test_rendering_renderpointerlistener.dart | - | - |
| RenderProxyBoxMixin | Proxy mixin | test_rendering_render_proxy_box_mixin.dart | - | - |
| RenderProxyBoxWithHitTestBehavior | Proxy with behavior | test_rendering_render_proxy_box_with_hit_test_behavior.dart | - | - |
| RenderRepaintBoundary | Repaint boundary | test_rendering_renderrepaintboundary.dart | - | - |
| RenderRotatedBox | Rotated box | test_rendering_render_rotated_box.dart | - | - |
| RenderSemanticsAnnotations | Semantics | test_rendering_rendersemanticsannotation.dart | - | - |
| RenderSemanticsGestureHandler | Gesture semantics | test_rendering_render_semantics_gesture_handler.dart | - | - |
| RenderShaderMask | Shader mask | test_rendering_render_shader_mask.dart | - | - |
| RenderShrinkWrappingViewport | Shrink viewport | test_rendering_render_shrink_wrapping_viewport.dart | - | - |
| RenderSizedOverflowBox | Sized overflow | test_rendering_render_sized_overflow_box.dart | - | - |
| RenderSliverAnimatedOpacity | Animated opacity | test_rendering_render_sliver_animated_opacity.dart | - | - |
| RenderSliverFillRemaining | Fill remaining | test_rendering_render_sliver_fill_remaining.dart | - | - |
| RenderSliverFillViewport | Fill viewport | test_rendering_render_sliver_fill_viewport.dart | - | - |
| RenderSliverFixedExtentList | Fixed extent list | test_rendering_render_sliver_fixed_extent_list.dart | - | - |
| RenderSliverFloatingPersistentHeader | Floating header | test_rendering_render_sliver_floating_persistent_header.dart | - | - |
| RenderSliverHelpers | Sliver helpers | test_rendering_render_sliver_helpers.dart | - | - |
| RenderSliverIgnorePointer | Sliver ignore | test_rendering_render_sliver_ignore_pointer.dart | - | - |
| RenderSliverMultiBoxAdaptor | Multi box adaptor | test_rendering_render_sliver_multi_box_adaptor.dart | - | - |
| RenderSliverOffstage | Sliver offstage | test_rendering_render_sliver_offstage.dart | - | - |
| RenderSliverPersistentHeader | Persistent header | test_rendering_render_sliver_persistent_header.dart | - | - |
| RenderSliverPinnedPersistentHeader | Pinned header | test_rendering_render_sliver_pinned_persistent_header.dart | - | - |
| RenderSliverScrollingPersistentHeader | Scrolling header | test_rendering_render_sliver_scrolling_persistent_header.dart | - | - |
| RenderSliverToBoxAdapter | Box adapter | test_rendering_render_sliver_to_box_adapter.dart | - | - |
| RenderSliverVariedExtentList | Varied extent list | test_rendering_render_sliver_varied_extent_list.dart | - | - |
| RenderSliverWithKeepAliveMixin | Keep alive sliver | test_rendering_render_sliver_with_keep_alive_mixin.dart | - | - |
| RenderTreeSliver | Tree sliver | test_rendering_render_tree_sliver.dart | - | - |
| RenderViewportBase | Viewport base | test_rendering_render_viewport_base.dart | - | - |
| RendererBinding | Renderer binding | test_rendering_renderer_binding.dart | - | - |
| RenderingFlutterBinding | Flutter binding | test_rendering_rendering_flutter_binding.dart | - | - |
| Selectable | Selectable mixin | test_widgets_selectable.dart | - | - |
| SelectedContent | Selected content | test_rendering_selected_content.dart | - | - |
| SelectionGeometry | Selection geometry | test_rendering_selection_geometry.dart | - | - |
| SelectionPoint | Selection point | test_rendering_selection_point.dart | - | - |
| SelectionRegistrar | Selection registrar | test_widgets_selectionregistrar.dart | - | - |
| SemanticsAnnotationsMixin | Semantics mixin | test_rendering_semantics_annotations_mixin.dart | - | - |
| ShaderMaskLayer | Shader mask | test_rendering_shadermasklayer.dart | - | - |
| ShapeBorderClipper | Shape clipper | test_rendering_shape_border_clipper.dart | - | - |
| SliverGridGeometry | Grid geometry | test_rendering_sliver_grid_geometry.dart | - | - |
| SliverGridLayout | Grid layout | test_rendering_sliver_grid_layout.dart | - | - |
| SliverGridRegularTileLayout | Regular tile layout | test_rendering_sliver_grid_regular_tile_layout.dart | - | - |
| SliverHitTestEntry | Sliver hit entry | test_rendering_sliver_hit_test_entry.dart | - | - |
| SliverHitTestResult | Sliver hit test | test_rendering_sliver_hit_test_result.dart | - | - |
| SliverLayoutDimensions | Layout dimensions | test_rendering_sliver_layout_dimensions.dart | - | - |
| SliverLogicalParentData | Logical sliver data | test_rendering_sliver_logical_parent_data.dart | - | - |
| SliverMultiBoxAdaptorParentData | Multi box data | test_rendering_sliver_multi_box_adaptor_parent_data.dart | - | - |
| SliverPhysicalParentData | Physical sliver data | test_rendering_sliver_physical_parent_data.dart | - | - |
| TableCellParentData | Table cell data | test_rendering_table_cell_parent_data.dart | - | - |
| TextParentData | Text parent data | test_rendering_text_parent_data.dart | - | - |
| TextSelectionPoint | Selection point | test_rendering_text_selection_point.dart | - | - |
| TextureLayer | Texture layer | test_rendering_texturelayer.dart | - | - |
| WrapParentData | Wrap parent data | test_rendering_wrap_parent_data.dart | - | - |

---

## animation (4 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AnimationMax | Maximum animation | test_animation_animationmax.dart | - | - |
| AnimationMean | Mean animation | test_animation_animationmean.dart | - | - |
| AnimationMin | Minimum animation | test_animation_animationmin.dart | - | - |
| AnimationWithParentMixin | Parent animation mixin | test_animation_animation_with_parent_mixin.dart | - | - |

---

## gestures (25 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| BaseTapAndDragGestureRecognizer | Base tap+drag | test_gestures_base_tap_and_drag_gesture_recognizer.dart | - | - |
| DelayedMultiDragGestureRecognizer | Delayed multi-drag | test_gestures_delayed_multi_drag_gesture_recognizer.dart | - | - |
| DeviceGestureSettings | Device settings | test_gestures_device_gesture_settings.dart | - | - |
| Drag | Drag callback | test_gestures_drag.dart | - | - |
| DragGestureRecognizer | Base drag recognizer | test_gestures_drag_gesture_recognizer.dart | - | - |
| EagerGestureRecognizer | Eager recognizer | test_gestures_eager_gesture_recognizer.dart | - | - |
| HorizontalMultiDragGestureRecognizer | Horizontal multi-drag | test_gestures_horizontal_multi_drag_gesture_recognizer.dart | - | - |
| ImmediateMultiDragGestureRecognizer | Immediate multi-drag | test_gestures_immediate_multi_drag_gesture_recognizer.dart | - | - |
| LongPressDownDetails | Long press down | test_gestures_long_press_down_details.dart | - | - |
| MultiDragGestureRecognizer | Multi-pointer drag | test_gestures_multi_drag_gesture_recognizer.dart | - | - |
| MultiDragPointerState | Multi-drag state | test_gestures_multi_drag_pointer_state.dart | - | - |
| MultiTapGestureRecognizer | Multi-tap | test_gestures_multi_tap_gesture_recognizer.dart | - | - |
| PositionedGestureDetails | Positioned details | test_gestures_positioned_gesture_details.dart | - | - |
| SerialTapCancelDetails | Serial tap cancel | test_gestures_serial_tap_cancel_details.dart | - | - |
| SerialTapDownDetails | Serial tap down | test_gestures_serial_tap_down_details.dart | - | - |
| SerialTapGestureRecognizer | Serial taps | test_gestures_serial_tap_gesture_recognizer.dart | - | - |
| SerialTapUpDetails | Serial tap up | test_gestures_serial_tap_up_details.dart | - | - |
| TapAndHorizontalDragGestureRecognizer | Tap and horizontal | test_gestures_tap_and_horizontal_drag_gesture_recognizer.dart | - | - |
| TapAndPanGestureRecognizer | Tap and pan | test_gestures_tap_and_pan_gesture_recognizer.dart | - | - |
| TapDragDownDetails | Tap drag down | test_gestures_tap_drag_down_details.dart | - | - |
| TapDragEndDetails | Tap drag end | test_gestures_tap_drag_end_details.dart | - | - |
| TapDragStartDetails | Tap drag start | test_gestures_tap_drag_start_details.dart | - | - |
| TapDragUpDetails | Tap drag up | test_gestures_tap_drag_up_details.dart | - | - |
| TapDragUpdateDetails | Tap drag update | test_gestures_tap_drag_update_details.dart | - | - |
| VerticalMultiDragGestureRecognizer | Vertical multi-drag | test_gestures_vertical_multi_drag_gesture_recognizer.dart | - | - |

---

## services (35 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AndroidViewController | Android views | test_services_android_view_controller.dart | - | - |
| AppKitViewController | macOS views | test_services_app_kit_view_controller.dart | - | - |
| AssetManifest | Asset manifest | test_services_asset_manifest.dart | - | - |
| AssetMetadata | Asset metadata | test_services_asset_metadata.dart | - | - |
| AutofillConfiguration | Autofill config | test_widgets_autofillconfiguration.dart | - | - |
| AutofillScope | Autofill scope | test_widgets_autofillscope.dart | - | - |
| BrowserContextMenu | Browser menu | test_services_browsercontextmenu.dart | - | - |
| CachingAssetBundle | Cached assets | test_services_caching_asset_bundle.dart | - | - |
| DarwinPlatformViewController | Darwin views | test_services_darwin_platform_view_controller.dart | - | - |
| DefaultProcessTextService | Default processing | test_services_default_process_text_service.dart | - | - |
| DefaultSpellCheckService | Default spell check | test_services_default_spell_check_service.dart | - | - |
| ExpensiveAndroidViewController | Expensive Android | test_services_expensive_android_view_controller.dart | - | - |
| FlutterVersion | Flutter version | test_services_flutter_version.dart | - | - |
| FontLoader | Font loading | test_services_font_loader.dart | - | - |
| HybridAndroidViewController | Hybrid Android | test_services_hybrid_android_view_controller.dart | - | - |
| LiveText | Live text | test_services_livetext.dart | - | - |
| NetworkAssetBundle | Network assets | test_services_network_asset_bundle.dart | - | - |
| PlatformAssetBundle | Platform assets | test_services_platform_asset_bundle.dart | - | - |
| PlatformViewController | View controller | test_services_platform_view_controller.dart | - | - |
| PlatformViewsRegistry | View registry | test_services_platform_views_registry.dart | - | - |
| PlatformViewsService | Platform views | test_services_platform_views_service.dart | - | - |
| PredictiveBackEvent | Predictive back | test_services_predictive_back_event.dart | - | - |
| ProcessTextAction | Process action | test_services_process_text_action.dart | - | - |
| ProcessTextService | Text processing | test_services_process_text_service.dart | - | - |
| RestorationManager | Restoration manager | test_widgets_restorationmanager.dart | - | - |
| Scribe | Text scribe | test_services_scribe.dart | - | - |
| SpellCheckService | Spell checking | test_services_spell_check_service.dart | - | - |
| SuggestionSpan | Suggestion span | test_services_suggestion_span.dart | - | - |
| SurfaceAndroidViewController | Surface Android | test_services_surface_android_view_controller.dart | - | - |
| SystemChannels | System channels | test_services_systemchannels.dart | - | - |
| TextLayoutMetrics | Text metrics | test_services_text_layout_metrics.dart | - | - |
| TextureAndroidViewController | Texture Android | test_services_texture_android_view_controller.dart | - | - |
| UiKitViewController | iOS views | test_services_ui_kit_view_controller.dart | - | - |
| UndoManager | Undo system | test_services_undo_manager.dart | - | - |
| UndoManagerClient | Undo client | test_services_undo_manager_client.dart | - | - |

---

## dart:ui (36 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AccessibilityFeatures | Accessibility settings | test_dart_ui_accessibility_features.dart | - | - |
| Brightness | Light/dark mode | test_dart_ui_brightness.dart | - | - |
| Codec | Image codec | test_dart_ui_codec.dart | - | - |
| Display | Display information | test_dart_ui_display.dart | - | - |
| DisplayFeature | Display feature | test_dart_ui_displayfeature.dart | - | - |
| FlutterView | Native view | test_dart_ui_flutterview.dart | - | - |
| FrameData | Frame data | test_dart_ui_frame_data.dart | - | - |
| FrameInfo | Animation frame | test_dart_ui_frameinfo.dart | - | - |
| FrameTiming | Frame performance | test_dart_ui_frame_timing.dart | - | - |
| GestureSettings | Gesture configuration | test_dart_ui_gesture_settings.dart | - | - |
| ImageDescriptor | Image metadata | test_dart_ui_imagedescriptor.dart | - | - |
| ImmutableBuffer | Immutable buffer | test_dart_ui_immutablebuffer.dart | - | - |
| KeyData | Key data | test_services_keydata.dart | - | - |
| LocaleStringAttribute | Locale attribute | test_dart_ui_localestringattribute.dart | - | - |
| OffsetBase | Base class for Offset | test_dart_ui_offset_base.dart | - | - |
| PathMetric | Individual path segment | test_dart_ui_path_metric.dart | - | - |
| PathMetricIterator | Path iteration | test_dart_ui_path_metric_iterator.dart | - | - |
| PathMetrics | Path measurement | test_dart_ui_path_metrics.dart | - | - |
| PlatformDispatcher | Platform events | test_dart_ui_platformdispatcher.dart | - | - |
| PointerData | Touch/mouse events | test_dart_ui_pointer_data.dart | - | - |
| PointerDataPacket | Batched pointer events | test_dart_ui_pointer_data_packet.dart | - | - |
| RSuperellipse | Superellipse shapes | test_dart_ui_r_superellipse.dart | - | - |
| Scene | Rendered scene | test_dart_ui_scene.dart | - | - |
| SceneBuilder | Scene graph construction | test_dart_ui_scene_builder.dart | - | - |
| SemanticsAction | A11y action | test_dart_ui_semanticsaction.dart | - | - |
| SemanticsActionEvent | Accessibility events | test_dart_ui_semantics_action_event.dart | - | - |
| SemanticsFlag | A11y flag | test_dart_ui_semanticsflag.dart | - | - |
| SemanticsFlags | Accessibility flag set | test_dart_ui_semantics_flags.dart | - | - |
| SemanticsUpdate | Semantics update | test_dart_ui_semanticsupdate.dart | - | - |
| SemanticsUpdateBuilder | Update builder | test_dart_ui_semanticsupdatebuilder.dart | - | - |
| SpellOutStringAttribute | Spell out | test_dart_ui_spelloutstringattribute.dart | - | - |
| StringAttribute | Text attributes | test_dart_ui_string_attribute.dart | - | - |
| SystemColor | System color access | test_dart_ui_system_color.dart | - | - |
| TargetImageSize | Image sizing | test_dart_ui_target_image_size.dart | - | - |
| ViewConstraints | View size constraints | test_dart_ui_view_constraints.dart | - | - |
| ViewFocusEvent | Focus events | test_dart_ui_view_focus_event.dart | - | - |

---

## semantics (6 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ChildSemanticsConfigurationsResult | Child configs | test_semantics_child_semantics_configurations_result.dart | - | - |
| ChildSemanticsConfigurationsResultBuilder | Config builder | test_semantics_child_semantics_configurations_result_builder.dart | - | - |
| SemanticsBinding | Semantics binding | test_semantics_semantics_binding.dart | - | - |
| SemanticsEvent | Base event | test_semantics_semanticsevent.dart | - | - |
| SemanticsHandle | Semantics handle | test_semantics_semantics_handle.dart | - | - |
| SemanticsLabelBuilder | Label building | test_semantics_semantics_label_builder.dart | - | - |

---

## scheduler (1 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| PerformanceModeRequestHandle | Performance mode | test_scheduler_performance_mode_request_handle.dart | - | - |

---

## physics (2 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ClampedSimulation | Clamped simulation | test_physics_clamped_simulation.dart | - | - |
| GravitySimulation | Gravity physics | test_physics_gravity_simulation.dart | - | - |

---

## Summary

| Package | Count |
|---------|-------|
| widgets | 183 |
| material | 110 |
| cupertino | 33 |
| foundation | 16 |
| painting | 32 |
| rendering | 107 |
| animation | 4 |
| gestures | 25 |
| services | 35 |
| dart:ui | 36 |
| semantics | 6 |
| scheduler | 1 |
| physics | 2 |
| **Total** | **590** |
