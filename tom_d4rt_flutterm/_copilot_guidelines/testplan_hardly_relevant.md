# Test Plan: Hardly Relevant Classes

**Priority: HARDLY RELEVANT**
**Total classes: 1108**
**Covered: 0 scripts (no test scripts created yet)**

Classes with very limited bridging value — internal implementations, platform-specific,
render objects with no direct widget counterpart, or highly specialized framework internals.
Test only if all higher-priority classes are complete.

**Source classification:**
- **classified** — Individually named and classified in testpriority files
- **sdk** — Found in Flutter SDK source but not individually classified in testpriority files
- **tp-only** — Classified by testpriority but not found in current Flutter SDK (possibly deprecated, renamed, or from a different SDK version)

---

## widgets (457 classes)
*Sources: 35 classified, 420 from SDK, 2 testpriority-only*

| Class | Description | Source |
|-------|-------------|--------|
| AbstractLayoutBuilder | Layout builder base | classified |
| ActionDispatcher | Action dispatch | classified |
| ActionListener | Action listener | classified |
| ActivateAction | Activate action | classified |
| ActivateIntent | Activate intent | classified |
| AlignTransition | Transition | classified |
| AndroidOverscrollIndicator | AndroidOverscrollIndicator | sdk |
| AndroidViewSurface | Surface | classified |
| AnimatedGridState | Grid state | classified |
| AnimatedListState | List state | classified |
| AnimatedPositionedDirectional | Directional | classified |
| AnimatedWidgetBaseState | State | classified |
| AnnotatedRegion | Region | classified |
| AppKitView | AppKitView | sdk |
| AppLifecycleListener | AppLifecycleListener | sdk |
| AsyncSnapshot | Async snapshot | classified |
| AutocompleteFirstOptionIntent | First option | classified |
| AutocompleteHighlightedOption | Autocomplete | classified |
| AutocompleteLastOptionIntent | AutocompleteLastOptionIntent | sdk |
| AutocompleteNextOptionIntent | Next option | classified |
| AutocompleteNextPageOptionIntent | AutocompleteNextPageOptionIntent | sdk |
| AutocompletePreviousOptionIntent | Prev option | classified |
| AutocompletePreviousPageOptionIntent | AutocompletePreviousPageOptionIntent | sdk |
| AutofillContextAction | AutofillContextAction | sdk |
| AutofillGroupState | Autofill state | classified |
| AutomaticKeepAliveClientMixin | Keep alive mixin | classified |
| AutovalidateMode | AutovalidateMode | sdk |
| BackButtonListener | Back button | classified |
| BackdropGroup | BackdropGroup | sdk |
| BallisticScrollActivity | Scroll activity | classified |
| BannerLocation | BannerLocation | sdk |
| BannerPainter | Banner painter | classified |
| BaseWindowController | BaseWindowController | sdk |
| BorderRadiusTween | Radius tween | classified |
| BorderTween | Border tween | classified |
| BottomNavigationBarItem | BottomNavigationBarItem | sdk |
| BouncingScrollSimulation | Bounce sim | classified |
| BoxConstraintsTween | Constraints tween | classified |
| BoxScrollView | Scroll view base | classified |
| ButtonActivateIntent | Button activate | classified |
| CallbackShortcuts | Callback shortcuts | classified |
| CapturedThemes | Captured themes | classified |
| ChangeReportingBehavior | ChangeReportingBehavior | sdk |
| CharacterActivator | Char activator | classified |
| CharacterRange | Char range | tp-only |
| Characters | String characters | tp-only |
| ChildBackButtonDispatcher | Child dispatcher | classified |
| ChildVicinity | Child location | classified |
| ClampingScrollSimulation | Clamp sim | classified |
| ClipRSuperellipse | ClipRSuperellipse | sdk |
| ClipboardStatus | ClipboardStatus | sdk |
| ClipboardStatusNotifier | Clipboard status | classified |
| ConnectionState | ConnectionState | sdk |
| ConstrainedLayoutBuilder | ConstrainedLayoutBuilder | sdk |
| ConstraintsTransformBox | ConstraintsTransformBox | sdk |
| ContextAction | ContextAction | sdk |
| ContextMenuButtonType | ContextMenuButtonType | sdk |
| CopySelectionTextIntent | CopySelectionTextIntent | sdk |
| CrossFadeState | CrossFadeState | sdk |
| DebugCreator | DebugCreator | sdk |
| DecoratedSliver | DecoratedSliver | sdk |
| DecorationTween | DecorationTween | sdk |
| DefaultPlatformMenuDelegate | DefaultPlatformMenuDelegate | sdk |
| DefaultSelectionStyle | DefaultSelectionStyle | sdk |
| DefaultTextEditingShortcuts | DefaultTextEditingShortcuts | sdk |
| DefaultTextStyleTransition | DefaultTextStyleTransition | sdk |
| DefaultTransitionDelegate | DefaultTransitionDelegate | sdk |
| DeleteCharacterIntent | DeleteCharacterIntent | sdk |
| DeleteToLineBreakIntent | DeleteToLineBreakIntent | sdk |
| DeleteToNextWordBoundaryIntent | DeleteToNextWordBoundaryIntent | sdk |
| DesktopTextSelectionToolbarLayoutDelegate | DesktopTextSelectionToolbarLayoutDelegate | sdk |
| DevToolsDeepLinkProperty | DevToolsDeepLinkProperty | sdk |
| DeviceOrientationBuilder | DeviceOrientationBuilder | sdk |
| DiagonalDragBehavior | DiagonalDragBehavior | sdk |
| DialogWindow | DialogWindow | sdk |
| DialogWindowController | DialogWindowController | sdk |
| DialogWindowControllerDelegate | DialogWindowControllerDelegate | sdk |
| DialogWindowControllerLinux | DialogWindowControllerLinux | sdk |
| DialogWindowControllerMacOS | DialogWindowControllerMacOS | sdk |
| DialogWindowControllerWin32 | DialogWindowControllerWin32 | sdk |
| DirectionalCaretMovementIntent | DirectionalCaretMovementIntent | sdk |
| DirectionalFocusAction | DirectionalFocusAction | sdk |
| DirectionalFocusIntent | DirectionalFocusIntent | sdk |
| DirectionalFocusTraversalPolicyMixin | DirectionalFocusTraversalPolicyMixin | sdk |
| DirectionalTextEditingIntent | DirectionalTextEditingIntent | sdk |
| DisableWidgetInspectorScope | DisableWidgetInspectorScope | sdk |
| DismissAction | DismissAction | sdk |
| DismissDirection | DismissDirection | sdk |
| DismissIntent | DismissIntent | sdk |
| DismissMenuAction | DismissMenuAction | sdk |
| DismissUpdateDetails | DismissUpdateDetails | sdk |
| Dismissible | Dismissible | sdk |
| DisposableBuildContext | DisposableBuildContext | sdk |
| DoNothingAction | DoNothingAction | sdk |
| DoNothingAndStopPropagationIntent | DoNothingAndStopPropagationIntent | sdk |
| DoNothingAndStopPropagationTextIntent | DoNothingAndStopPropagationTextIntent | sdk |
| DoNothingIntent | DoNothingIntent | sdk |
| DragBoundary | DragBoundary | sdk |
| DragBoundaryDelegate | DragBoundaryDelegate | sdk |
| DragScrollActivity | DragScrollActivity | sdk |
| DragTargetDetails | DragTargetDetails | sdk |
| DraggableDetails | DraggableDetails | sdk |
| DraggableScrollableActuator | DraggableScrollableActuator | sdk |
| DraggableScrollableController | DraggableScrollableController | sdk |
| DraggableScrollableNotification | DraggableScrollableNotification | sdk |
| DrivenScrollActivity | DrivenScrollActivity | sdk |
| EdgeDraggingAutoScroller | EdgeDraggingAutoScroller | sdk |
| EdgeInsetsGeometryTween | EdgeInsetsGeometryTween | sdk |
| EdgeInsetsTween | EdgeInsetsTween | sdk |
| EditableTextTapOutsideIntent | EditableTextTapOutsideIntent | sdk |
| EditableTextTapUpOutsideIntent | EditableTextTapUpOutsideIntent | sdk |
| EmptyTextSelectionControls | EmptyTextSelectionControls | sdk |
| EnableWidgetInspectorScope | EnableWidgetInspectorScope | sdk |
| ExcludeFocus | ExcludeFocus | sdk |
| ExcludeFocusTraversal | ExcludeFocusTraversal | sdk |
| ExpandSelectionToDocumentBoundaryIntent | ExpandSelectionToDocumentBoundaryIntent | sdk |
| ExpandSelectionToLineBreakIntent | ExpandSelectionToLineBreakIntent | sdk |
| Expansible | Expansible | sdk |
| ExpansibleController | ExpansibleController | sdk |
| ExtendSelectionByCharacterIntent | ExtendSelectionByCharacterIntent | sdk |
| ExtendSelectionByPageIntent | ExtendSelectionByPageIntent | sdk |
| ExtendSelectionToDocumentBoundaryIntent | ExtendSelectionToDocumentBoundaryIntent | sdk |
| ExtendSelectionToLineBreakIntent | ExtendSelectionToLineBreakIntent | sdk |
| ExtendSelectionToNextParagraphBoundaryIntent | ExtendSelectionToNextParagraphBoundaryIntent | sdk |
| ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent | ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent | sdk |
| ExtendSelectionToNextWordBoundaryIntent | ExtendSelectionToNextWordBoundaryIntent | sdk |
| ExtendSelectionToNextWordBoundaryOrCaretLocationIntent | ExtendSelectionToNextWordBoundaryOrCaretLocationIntent | sdk |
| ExtendSelectionVerticallyToAdjacentLineIntent | ExtendSelectionVerticallyToAdjacentLineIntent | sdk |
| ExtendSelectionVerticallyToAdjacentPageIntent | ExtendSelectionVerticallyToAdjacentPageIntent | sdk |
| Feedback | Feedback | sdk |
| FixedScrollMetrics | FixedScrollMetrics | sdk |
| Flex | Flex | sdk |
| FloatingHeaderSnapMode | FloatingHeaderSnapMode | sdk |
| FocusAttachment | FocusAttachment | sdk |
| FocusHighlightMode | FocusHighlightMode | sdk |
| FocusHighlightStrategy | FocusHighlightStrategy | sdk |
| FocusOrder | FocusOrder | sdk |
| FocusScopeNode | FocusScopeNode | sdk |
| FocusTraversalOrder | FocusTraversalOrder | sdk |
| FractionalTranslation | FractionalTranslation | sdk |
| GestureRecognizerFactory | GestureRecognizerFactory | sdk |
| GestureRecognizerFactoryWithHandlers | GestureRecognizerFactoryWithHandlers | sdk |
| GlobalObjectKey | GlobalObjectKey | sdk |
| HeroController | HeroController | sdk |
| HeroControllerScope | HeroControllerScope | sdk |
| HeroFlightDirection | HeroFlightDirection | sdk |
| HoldScrollActivity | HoldScrollActivity | sdk |
| IOSSystemContextMenuItem | IOSSystemContextMenuItem | sdk |
| IOSSystemContextMenuItemCopy | IOSSystemContextMenuItemCopy | sdk |
| IOSSystemContextMenuItemCustom | IOSSystemContextMenuItemCustom | sdk |
| IOSSystemContextMenuItemCut | IOSSystemContextMenuItemCut | sdk |
| IOSSystemContextMenuItemLiveText | IOSSystemContextMenuItemLiveText | sdk |
| IOSSystemContextMenuItemLookUp | IOSSystemContextMenuItemLookUp | sdk |
| IOSSystemContextMenuItemPaste | IOSSystemContextMenuItemPaste | sdk |
| IOSSystemContextMenuItemSearchWeb | IOSSystemContextMenuItemSearchWeb | sdk |
| IOSSystemContextMenuItemSelectAll | IOSSystemContextMenuItemSelectAll | sdk |
| IOSSystemContextMenuItemShare | IOSSystemContextMenuItemShare | sdk |
| IconData | IconData | sdk |
| IconDataProperty | IconDataProperty | sdk |
| IconThemeData | IconThemeData | sdk |
| IdleScrollActivity | IdleScrollActivity | sdk |
| IgnoreBaseline | IgnoreBaseline | sdk |
| ImageIcon | ImageIcon | sdk |
| ImgElementPlatformView | ImgElementPlatformView | sdk |
| IndexedSlot | IndexedSlot | sdk |
| InheritedModelElement | InheritedModelElement | sdk |
| InspectorButton | InspectorButton | sdk |
| InspectorButtonVariant | InspectorButtonVariant | sdk |
| InspectorReferenceData | InspectorReferenceData | sdk |
| InspectorSelection | InspectorSelection | sdk |
| InspectorSerializationDelegate | InspectorSerializationDelegate | sdk |
| KeepAliveHandle | KeepAliveHandle | sdk |
| KeepAliveNotification | KeepAliveNotification | sdk |
| KeyEventResult | KeyEventResult | sdk |
| KeySet | KeySet | sdk |
| KeyboardListener | KeyboardListener | sdk |
| LabeledGlobalKey | LabeledGlobalKey | sdk |
| LayoutId | LayoutId | sdk |
| LexicalFocusOrder | LexicalFocusOrder | sdk |
| LiveTextInputStatus | LiveTextInputStatus | sdk |
| LiveTextInputStatusNotifier | LiveTextInputStatusNotifier | sdk |
| LocalHistoryEntry | LocalHistoryEntry | sdk |
| LocalizationsResolver | LocalizationsResolver | sdk |
| LockState | LockState | sdk |
| LogicalKeySet | LogicalKeySet | sdk |
| LookupBoundary | LookupBoundary | sdk |
| Matrix4Tween | Matrix4Tween | sdk |
| MatrixTransition | MatrixTransition | sdk |
| MenuController | MenuController | sdk |
| MenuSerializableShortcut | MenuSerializableShortcut | sdk |
| MetaData | MetaData | sdk |
| ModalBarrier | ModalBarrier | sdk |
| MultiSelectableSelectionContainerDelegate | MultiSelectableSelectionContainerDelegate | sdk |
| NavigationMode | NavigationMode | sdk |
| NavigationNotification | NavigationNotification | sdk |
| NavigatorPopHandler | NavigatorPopHandler | sdk |
| NestedScrollViewState | NestedScrollViewState | sdk |
| NestedScrollViewViewport | NestedScrollViewViewport | sdk |
| NextFocusAction | NextFocusAction | sdk |
| NextFocusIntent | NextFocusIntent | sdk |
| NotifiableElementMixin | NotifiableElementMixin | sdk |
| Notification | Notification | sdk |
| NumericFocusOrder | NumericFocusOrder | sdk |
| ObjectKey | ObjectKey | sdk |
| OptionsViewOpenDirection | OptionsViewOpenDirection | sdk |
| OrderedTraversalPolicy | OrderedTraversalPolicy | sdk |
| Orientation | Orientation | sdk |
| OrientationBuilder | OrientationBuilder | sdk |
| OverflowBarAlignment | OverflowBarAlignment | sdk |
| OverlayChildLayoutInfo | OverlayChildLayoutInfo | sdk |
| OverlayChildLocation | OverlayChildLocation | sdk |
| OverlayPortal | OverlayPortal | sdk |
| OverlayPortalController | OverlayPortalController | sdk |
| OverlayRoute | OverlayRoute | sdk |
| OverlayState | OverlayState | sdk |
| OverscrollIndicatorNotification | OverscrollIndicatorNotification | sdk |
| OverscrollNotification | OverscrollNotification | sdk |
| Page | Page | sdk |
| PageMetrics | PageMetrics | sdk |
| PageRouteBuilder | PageRouteBuilder | sdk |
| PanAxis | PanAxis | sdk |
| PasteTextIntent | PasteTextIntent | sdk |
| PlatformMenuDelegate | PlatformMenuDelegate | sdk |
| PlatformProvidedMenuItemType | PlatformProvidedMenuItemType | sdk |
| PlatformRouteInformationProvider | PlatformRouteInformationProvider | sdk |
| PlatformSelectableRegionContextMenu | PlatformSelectableRegionContextMenu | sdk |
| PlatformViewCreationParams | PlatformViewCreationParams | sdk |
| PopEntry | PopEntry | sdk |
| PopNavigatorRouterDelegateMixin | PopNavigatorRouterDelegateMixin | sdk |
| PopupWindow | PopupWindow | sdk |
| PopupWindowController | PopupWindowController | sdk |
| PopupWindowControllerDelegate | PopupWindowControllerDelegate | sdk |
| PredictiveBackRoute | PredictiveBackRoute | sdk |
| PreferredSize | PreferredSize | sdk |
| PreferredSizeWidget | PreferredSizeWidget | sdk |
| PreviousFocusAction | PreviousFocusAction | sdk |
| PreviousFocusIntent | PreviousFocusIntent | sdk |
| PrioritizedAction | PrioritizedAction | sdk |
| PrioritizedIntents | PrioritizedIntents | sdk |
| RadioClient | RadioClient | sdk |
| RadioGroupRegistry | RadioGroupRegistry | sdk |
| RawAutocomplete | RawAutocomplete | sdk |
| RawDialogRoute | RawDialogRoute | sdk |
| RawGestureDetector | RawGestureDetector | sdk |
| RawGestureDetectorState | RawGestureDetectorState | sdk |
| RawImage | RawImage | sdk |
| RawKeyboardListener | RawKeyboardListener | sdk |
| RawMenuAnchor | RawMenuAnchor | sdk |
| RawMenuAnchorGroup | RawMenuAnchorGroup | sdk |
| RawMenuOverlayInfo | RawMenuOverlayInfo | sdk |
| RawRadio | RawRadio | sdk |
| RawScrollbarState | RawScrollbarState | sdk |
| RawTooltip | RawTooltip | sdk |
| RawTooltipState | RawTooltipState | sdk |
| RawWebImage | RawWebImage | sdk |
| ReadingOrderTraversalPolicy | ReadingOrderTraversalPolicy | sdk |
| RedoTextIntent | RedoTextIntent | sdk |
| RegularWindow | RegularWindow | sdk |
| RegularWindowController | RegularWindowController | sdk |
| RegularWindowControllerDelegate | RegularWindowControllerDelegate | sdk |
| RegularWindowControllerLinux | RegularWindowControllerLinux | sdk |
| RegularWindowControllerMacOS | RegularWindowControllerMacOS | sdk |
| RegularWindowControllerWin32 | RegularWindowControllerWin32 | sdk |
| RelativePositionedTransition | RelativePositionedTransition | sdk |
| RelativeRectTween | RelativeRectTween | sdk |
| RenderAbstractLayoutBuilderMixin | RenderAbstractLayoutBuilderMixin | sdk |
| RenderNestedScrollViewViewport | RenderNestedScrollViewViewport | sdk |
| RenderObjectToWidgetAdapter | RenderObjectToWidgetAdapter | sdk |
| RenderObjectToWidgetElement | RenderObjectToWidgetElement | sdk |
| RenderSliverOverlapAbsorber | RenderSliverOverlapAbsorber | sdk |
| RenderSliverOverlapInjector | RenderSliverOverlapInjector | sdk |
| RenderTapRegion | RenderTapRegion | sdk |
| RenderTapRegionSurface | RenderTapRegionSurface | sdk |
| RenderTreeRootElement | RenderTreeRootElement | sdk |
| RenderTwoDimensionalViewport | RenderTwoDimensionalViewport | sdk |
| RenderWebImage | RenderWebImage | sdk |
| ReorderableDelayedDragStartListener | ReorderableDelayedDragStartListener | sdk |
| ReorderableDragStartListener | ReorderableDragStartListener | sdk |
| ReorderableList | ReorderableList | sdk |
| ReorderableListState | ReorderableListState | sdk |
| RepeatMode | RepeatMode | sdk |
| RepeatingAnimationBuilder | RepeatingAnimationBuilder | sdk |
| ReplaceTextIntent | ReplaceTextIntent | sdk |
| RequestFocusAction | RequestFocusAction | sdk |
| RequestFocusIntent | RequestFocusIntent | sdk |
| RestorableBoolN | RestorableBoolN | sdk |
| RestorableChangeNotifier | RestorableChangeNotifier | sdk |
| RestorableDateTimeN | RestorableDateTimeN | sdk |
| RestorableDoubleN | RestorableDoubleN | sdk |
| RestorableEnumN | RestorableEnumN | sdk |
| RestorableIntN | RestorableIntN | sdk |
| RestorableListenable | RestorableListenable | sdk |
| RestorableNum | RestorableNum | sdk |
| RestorableNumN | RestorableNumN | sdk |
| RestorableRouteFuture | RestorableRouteFuture | sdk |
| RestorableStringN | RestorableStringN | sdk |
| RootBackButtonDispatcher | RootBackButtonDispatcher | sdk |
| RootElementMixin | RootElementMixin | sdk |
| RootRenderObjectElement | RootRenderObjectElement | sdk |
| RouteAware | RouteAware | sdk |
| RouteInformation | RouteInformation | sdk |
| RouteInformationReportingType | RouteInformationReportingType | sdk |
| RouteObserver | RouteObserver | sdk |
| RoutePopDisposition | RoutePopDisposition | sdk |
| RouteTransitionRecord | RouteTransitionRecord | sdk |
| RouterConfig | RouterConfig | sdk |
| ScrollActivity | ScrollActivity | sdk |
| ScrollActivityDelegate | ScrollActivityDelegate | sdk |
| ScrollAwareImageProvider | ScrollAwareImageProvider | sdk |
| ScrollContext | ScrollContext | sdk |
| ScrollDecelerationRate | ScrollDecelerationRate | sdk |
| ScrollDragController | ScrollDragController | sdk |
| ScrollEndNotification | ScrollEndNotification | sdk |
| ScrollHoldController | ScrollHoldController | sdk |
| ScrollIncrementDetails | ScrollIncrementDetails | sdk |
| ScrollIncrementType | ScrollIncrementType | sdk |
| ScrollMetricsNotification | ScrollMetricsNotification | sdk |
| ScrollNotificationObserver | ScrollNotificationObserver | sdk |
| ScrollNotificationObserverState | ScrollNotificationObserverState | sdk |
| ScrollPositionAlignmentPolicy | ScrollPositionAlignmentPolicy | sdk |
| ScrollPositionWithSingleContext | ScrollPositionWithSingleContext | sdk |
| ScrollStartNotification | ScrollStartNotification | sdk |
| ScrollToDocumentBoundaryIntent | ScrollToDocumentBoundaryIntent | sdk |
| ScrollUpdateNotification | ScrollUpdateNotification | sdk |
| ScrollView | ScrollView | sdk |
| ScrollViewKeyboardDismissBehavior | ScrollViewKeyboardDismissBehavior | sdk |
| ScrollableDetails | ScrollableDetails | sdk |
| ScrollbarOrientation | ScrollbarOrientation | sdk |
| ScrollbarPainter | ScrollbarPainter | sdk |
| SelectAction | SelectAction | sdk |
| SelectAllTextIntent | SelectAllTextIntent | sdk |
| SelectIntent | SelectIntent | sdk |
| SelectableRegionSelectionStatus | SelectableRegionSelectionStatus | sdk |
| SelectableRegionSelectionStatusScope | SelectableRegionSelectionStatusScope | sdk |
| SelectableRegionState | SelectableRegionState | sdk |
| SelectionContainerDelegate | SelectionContainerDelegate | sdk |
| SelectionDetails | SelectionDetails | sdk |
| SelectionListenerNotifier | SelectionListenerNotifier | sdk |
| SelectionRegistrarScope | SelectionRegistrarScope | sdk |
| SemanticsDebugger | SemanticsDebugger | sdk |
| SemanticsGestureDelegate | SemanticsGestureDelegate | sdk |
| SensitiveContent | SensitiveContent | sdk |
| SensitiveContentHost | SensitiveContentHost | sdk |
| ShortcutActivator | ShortcutActivator | sdk |
| ShortcutManager | ShortcutManager | sdk |
| ShortcutMapProperty | ShortcutMapProperty | sdk |
| ShortcutRegistrar | ShortcutRegistrar | sdk |
| ShortcutRegistry | ShortcutRegistry | sdk |
| ShortcutRegistryEntry | ShortcutRegistryEntry | sdk |
| ShortcutSerialization | ShortcutSerialization | sdk |
| SingleActivator | SingleActivator | sdk |
| SizeChangedLayoutNotification | SizeChangedLayoutNotification | sdk |
| SizeChangedLayoutNotifier | SizeChangedLayoutNotifier | sdk |
| SizedOverflowBox | SizedOverflowBox | sdk |
| SliverAnimatedGridState | SliverAnimatedGridState | sdk |
| SliverAnimatedListState | SliverAnimatedListState | sdk |
| SliverChildBuilderDelegate | SliverChildBuilderDelegate | sdk |
| SliverChildDelegate | SliverChildDelegate | sdk |
| SliverChildListDelegate | SliverChildListDelegate | sdk |
| SliverEnsureSemantics | SliverEnsureSemantics | sdk |
| SliverFadeTransition | SliverFadeTransition | sdk |
| SliverMultiBoxAdaptorElement | SliverMultiBoxAdaptorElement | sdk |
| SliverMultiBoxAdaptorWidget | SliverMultiBoxAdaptorWidget | sdk |
| SliverOverlapAbsorber | SliverOverlapAbsorber | sdk |
| SliverOverlapAbsorberHandle | SliverOverlapAbsorberHandle | sdk |
| SliverOverlapInjector | SliverOverlapInjector | sdk |
| SliverPersistentHeaderDelegate | SliverPersistentHeaderDelegate | sdk |
| SliverReorderableListState | SliverReorderableListState | sdk |
| SliverWithKeepAliveWidget | SliverWithKeepAliveWidget | sdk |
| SlottedContainerRenderObjectMixin | SlottedContainerRenderObjectMixin | sdk |
| SlottedMultiChildRenderObjectWidget | SlottedMultiChildRenderObjectWidget | sdk |
| SlottedMultiChildRenderObjectWidgetMixin | SlottedMultiChildRenderObjectWidgetMixin | sdk |
| SlottedRenderObjectElement | SlottedRenderObjectElement | sdk |
| SnapshotController | SnapshotController | sdk |
| SnapshotMode | SnapshotMode | sdk |
| SnapshotPainter | SnapshotPainter | sdk |
| SnapshotWidget | SnapshotWidget | sdk |
| StandardComponentType | StandardComponentType | sdk |
| StaticSelectionContainerDelegate | StaticSelectionContainerDelegate | sdk |
| StatusTransitionWidget | StatusTransitionWidget | sdk |
| StreamBuilderBase | StreamBuilderBase | sdk |
| StretchEffect | StretchEffect | sdk |
| SystemContextMenu | SystemContextMenu | sdk |
| SystemTextScaler | SystemTextScaler | sdk |
| TapRegionRegistry | TapRegionRegistry | sdk |
| TextSelectionGestureDetectorBuilder | TextSelectionGestureDetectorBuilder | sdk |
| TextSelectionGestureDetectorBuilderDelegate | TextSelectionGestureDetectorBuilderDelegate | sdk |
| TextSelectionHandleControls | TextSelectionHandleControls | sdk |
| TextSelectionToolbarLayoutDelegate | TextSelectionToolbarLayoutDelegate | sdk |
| TextStyleTween | TextStyleTween | sdk |
| Texture | Texture | sdk |
| TickerModeData | TickerModeData | sdk |
| ToggleablePainter | ToggleablePainter | sdk |
| ToggleableStateMixin | ToggleableStateMixin | sdk |
| ToolbarItemsParentData | ToolbarItemsParentData | sdk |
| ToolbarOptions | ToolbarOptions | sdk |
| TooltipPositionContext | TooltipPositionContext | sdk |
| TooltipWindow | TooltipWindow | sdk |
| TooltipWindowController | TooltipWindowController | sdk |
| TooltipWindowControllerDelegate | TooltipWindowControllerDelegate | sdk |
| TrackingScrollController | TrackingScrollController | sdk |
| TransformationController | TransformationController | sdk |
| TransitionDelegate | TransitionDelegate | sdk |
| TransitionRoute | TransitionRoute | sdk |
| TransposeCharactersIntent | TransposeCharactersIntent | sdk |
| TraversalDirection | TraversalDirection | sdk |
| TraversalEdgeBehavior | TraversalEdgeBehavior | sdk |
| TreeSliver | TreeSliver | sdk |
| TreeSliverController | TreeSliverController | sdk |
| TreeSliverNode | TreeSliverNode | sdk |
| TreeSliverStateMixin | TreeSliverStateMixin | sdk |
| TwoDimensionalChildBuilderDelegate | TwoDimensionalChildBuilderDelegate | sdk |
| TwoDimensionalChildDelegate | TwoDimensionalChildDelegate | sdk |
| TwoDimensionalChildListDelegate | TwoDimensionalChildListDelegate | sdk |
| TwoDimensionalChildManager | TwoDimensionalChildManager | sdk |
| TwoDimensionalScrollView | TwoDimensionalScrollView | sdk |
| TwoDimensionalScrollable | TwoDimensionalScrollable | sdk |
| TwoDimensionalScrollableState | TwoDimensionalScrollableState | sdk |
| TwoDimensionalViewport | TwoDimensionalViewport | sdk |
| TwoDimensionalViewportParentData | TwoDimensionalViewportParentData | sdk |
| UndoHistoryState | UndoHistoryState | sdk |
| UndoHistoryValue | UndoHistoryValue | sdk |
| UndoTextIntent | UndoTextIntent | sdk |
| UnfocusDisposition | UnfocusDisposition | sdk |
| UniqueWidget | UniqueWidget | sdk |
| UnmanagedRestorationScope | UnmanagedRestorationScope | sdk |
| UpdateSelectionIntent | UpdateSelectionIntent | sdk |
| UserScrollNotification | UserScrollNotification | sdk |
| ViewportElementMixin | ViewportElementMixin | sdk |
| ViewportNotificationMixin | ViewportNotificationMixin | sdk |
| VoidCallbackAction | VoidCallbackAction | sdk |
| VoidCallbackIntent | VoidCallbackIntent | sdk |
| WeakMap | WeakMap | sdk |
| WebBrowserDetection | WebBrowserDetection | sdk |
| WidgetInspectorService | WidgetInspectorService | sdk |
| WidgetInspectorServiceExtensions | WidgetInspectorServiceExtensions | sdk |
| WidgetOrderTraversalPolicy | WidgetOrderTraversalPolicy | sdk |
| WidgetState | WidgetState | sdk |
| WidgetStateBorderSide | WidgetStateBorderSide | sdk |
| WidgetStateColor | WidgetStateColor | sdk |
| WidgetStateMapper | WidgetStateMapper | sdk |
| WidgetStateMouseCursor | WidgetStateMouseCursor | sdk |
| WidgetStateOutlinedBorder | WidgetStateOutlinedBorder | sdk |
| WidgetStatePropertyAll | WidgetStatePropertyAll | sdk |
| WidgetStateTextStyle | WidgetStateTextStyle | sdk |
| WidgetStatesConstraint | WidgetStatesConstraint | sdk |
| WidgetToRenderBoxAdapter | WidgetToRenderBoxAdapter | sdk |
| WidgetsLocalizations | WidgetsLocalizations | sdk |
| WidgetsServiceExtensions | WidgetsServiceExtensions | sdk |
| WindowPositioner | WindowPositioner | sdk |
| WindowPositionerAnchor | WindowPositionerAnchor | sdk |
| WindowPositionerConstraintAdjustment | WindowPositionerConstraintAdjustment | sdk |
| WindowScope | WindowScope | sdk |
| WindowingOwner | WindowingOwner | sdk |
| WindowingOwnerLinux | WindowingOwnerLinux | sdk |
| WindowingOwnerMacOS | WindowingOwnerMacOS | sdk |
| WindowingOwnerWin32 | WindowingOwnerWin32 | sdk |

---

## material (167 classes)
*Sources: 1 classified, 165 from SDK, 1 testpriority-only*

| Class | Description | Source |
|-------|-------------|--------|
| ActionChipTheme | Action theme | tp-only |
| Adaptation | Adaptation | sdk |
| AnimatedIconData | AnimatedIconData | sdk |
| AnimatedTheme | Theme | classified |
| Autocomplete | Autocomplete | sdk |
| BackButton | BackButton | sdk |
| BackButtonIcon | BackButtonIcon | sdk |
| BottomNavigationBarLandscapeLayout | BottomNavigationBarLandscapeLayout | sdk |
| BottomNavigationBarTheme | BottomNavigationBarTheme | sdk |
| BottomNavigationBarThemeData | BottomNavigationBarThemeData | sdk |
| BottomNavigationBarType | BottomNavigationBarType | sdk |
| ButtonBar | ButtonBar | sdk |
| ButtonBarLayoutBehavior | ButtonBarLayoutBehavior | sdk |
| ButtonBarTheme | ButtonBarTheme | sdk |
| ButtonBarThemeData | ButtonBarThemeData | sdk |
| ButtonTextTheme | ButtonTextTheme | sdk |
| CarouselController | CarouselController | sdk |
| CarouselScrollPhysics | CarouselScrollPhysics | sdk |
| CarouselView | CarouselView | sdk |
| CarouselViewTheme | CarouselViewTheme | sdk |
| CarouselViewThemeData | CarouselViewThemeData | sdk |
| CheckedPopupMenuItem | CheckedPopupMenuItem | sdk |
| CloseButton | CloseButton | sdk |
| CloseButtonIcon | CloseButtonIcon | sdk |
| CollapseMode | CollapseMode | sdk |
| CupertinoBasedMaterialThemeData | CupertinoBasedMaterialThemeData | sdk |
| DatePickerEntryMode | DatePickerEntryMode | sdk |
| DatePickerMode | DatePickerMode | sdk |
| DayPeriod | DayPeriod | sdk |
| DialogRoute | DialogRoute | sdk |
| DrawerAlignment | DrawerAlignment | sdk |
| DrawerButton | DrawerButton | sdk |
| DrawerButtonIcon | DrawerButtonIcon | sdk |
| DrawerController | DrawerController | sdk |
| DrawerControllerState | DrawerControllerState | sdk |
| DropRangeSliderValueIndicatorShape | DropRangeSliderValueIndicatorShape | sdk |
| DropSliderValueIndicatorShape | DropSliderValueIndicatorShape | sdk |
| DropdownButtonHideUnderline | DropdownButtonHideUnderline | sdk |
| DropdownMenuCloseBehavior | DropdownMenuCloseBehavior | sdk |
| DropdownMenuEntry | DropdownMenuEntry | sdk |
| DropdownMenuFormField | DropdownMenuFormField | sdk |
| DropdownMenuItem | DropdownMenuItem | sdk |
| Durations | Durations | sdk |
| DynamicSchemeVariant | DynamicSchemeVariant | sdk |
| Easing | Easing | sdk |
| ElevationOverlay | ElevationOverlay | sdk |
| EndDrawerButton | EndDrawerButton | sdk |
| EndDrawerButtonIcon | EndDrawerButtonIcon | sdk |
| ExpandIcon | ExpandIcon | sdk |
| ExpansionPanelRadio | ExpansionPanelRadio | sdk |
| FabCenterOffsetX | FabCenterOffsetX | sdk |
| FabContainedOffsetY | FabContainedOffsetY | sdk |
| FabDockedOffsetY | FabDockedOffsetY | sdk |
| FabEndOffsetX | FabEndOffsetX | sdk |
| FabFloatOffsetY | FabFloatOffsetY | sdk |
| FabMiniOffsetAdjustment | FabMiniOffsetAdjustment | sdk |
| FabStartOffsetX | FabStartOffsetX | sdk |
| FabTopOffsetY | FabTopOffsetY | sdk |
| FadeForwardsPageTransitionsBuilder | FadeForwardsPageTransitionsBuilder | sdk |
| FlexibleSpaceBarSettings | FlexibleSpaceBarSettings | sdk |
| FloatingLabelAlignment | FloatingLabelAlignment | sdk |
| FloatingLabelBehavior | FloatingLabelBehavior | sdk |
| GappedRangeSliderTrackShape | GappedRangeSliderTrackShape | sdk |
| GappedSliderTrackShape | GappedSliderTrackShape | sdk |
| GregorianCalendarDelegate | GregorianCalendarDelegate | sdk |
| GridTile | GridTile | sdk |
| GridTileBar | GridTileBar | sdk |
| HandleRangeSliderThumbShape | HandleRangeSliderThumbShape | sdk |
| HandleThumbShape | HandleThumbShape | sdk |
| HourFormat | HourFormat | sdk |
| IconAlignment | IconAlignment | sdk |
| Icons | Icons | sdk |
| InkDecoration | InkDecoration | sdk |
| InkSparkle | InkSparkle | sdk |
| InputDatePickerFormField | InputDatePickerFormField | sdk |
| InputDecorationThemeData | InputDecorationThemeData | sdk |
| InputDecorator | InputDecorator | sdk |
| InteractiveInkFeatureFactory | InteractiveInkFeatureFactory | sdk |
| ListTileControlAffinity | ListTileControlAffinity | sdk |
| ListTileStyle | ListTileStyle | sdk |
| ListTileTitleAlignment | ListTileTitleAlignment | sdk |
| Magnifier | Magnifier | sdk |
| MaterialBannerClosedReason | MaterialBannerClosedReason | sdk |
| MaterialPointArcTween | MaterialPointArcTween | sdk |
| MaterialRectArcTween | MaterialRectArcTween | sdk |
| MaterialRectCenterArcTween | MaterialRectCenterArcTween | sdk |
| MaterialScrollBehavior | MaterialScrollBehavior | sdk |
| MaterialStateMixin | MaterialStateMixin | sdk |
| MaterialStateOutlineInputBorder | MaterialStateOutlineInputBorder | sdk |
| MaterialStateUnderlineInputBorder | MaterialStateUnderlineInputBorder | sdk |
| MaterialTapTargetSize | MaterialTapTargetSize | sdk |
| MaterialTextSelectionHandleControls | MaterialTextSelectionHandleControls | sdk |
| MenuAcceleratorCallbackBinding | MenuAcceleratorCallbackBinding | sdk |
| MenuAcceleratorLabel | MenuAcceleratorLabel | sdk |
| MenuButtonTheme | MenuButtonTheme | sdk |
| MenuButtonThemeData | MenuButtonThemeData | sdk |
| MergeableMaterialItem | MergeableMaterialItem | sdk |
| ModalBottomSheetRoute | ModalBottomSheetRoute | sdk |
| NavigationDestinationLabelBehavior | NavigationDestinationLabelBehavior | sdk |
| NavigationDrawerTheme | NavigationDrawerTheme | sdk |
| NavigationIndicator | NavigationIndicator | sdk |
| NavigationRailLabelType | NavigationRailLabelType | sdk |
| NoSplash | NoSplash | sdk |
| PaddleRangeSliderValueIndicatorShape | PaddleRangeSliderValueIndicatorShape | sdk |
| PaddleSliderValueIndicatorShape | PaddleSliderValueIndicatorShape | sdk |
| PaginatedDataTableState | PaginatedDataTableState | sdk |
| PersistentBottomSheetController | PersistentBottomSheetController | sdk |
| PlatformAdaptiveIcons | PlatformAdaptiveIcons | sdk |
| PopupMenuButtonState | PopupMenuButtonState | sdk |
| PopupMenuDivider | PopupMenuDivider | sdk |
| PopupMenuEntry | PopupMenuEntry | sdk |
| PopupMenuItem | PopupMenuItem | sdk |
| PopupMenuItemState | PopupMenuItemState | sdk |
| PopupMenuPosition | PopupMenuPosition | sdk |
| PredictiveBackFullscreenPageTransitionsBuilder | PredictiveBackFullscreenPageTransitionsBuilder | sdk |
| ProgressIndicator | ProgressIndicator | sdk |
| RawChip | RawChip | sdk |
| RectangularRangeSliderTrackShape | RectangularRangeSliderTrackShape | sdk |
| RectangularRangeSliderValueIndicatorShape | RectangularRangeSliderValueIndicatorShape | sdk |
| RectangularSliderValueIndicatorShape | RectangularSliderValueIndicatorShape | sdk |
| RefreshIndicatorState | RefreshIndicatorState | sdk |
| RefreshIndicatorStatus | RefreshIndicatorStatus | sdk |
| RefreshIndicatorTriggerMode | RefreshIndicatorTriggerMode | sdk |
| RefreshProgressIndicator | RefreshProgressIndicator | sdk |
| RestorableTimeOfDay | RestorableTimeOfDay | sdk |
| RoundRangeSliderThumbShape | RoundRangeSliderThumbShape | sdk |
| RoundRangeSliderTickMarkShape | RoundRangeSliderTickMarkShape | sdk |
| RoundedRectRangeSliderTrackShape | RoundedRectRangeSliderTrackShape | sdk |
| RoundedRectRangeSliderValueIndicatorShape | RoundedRectRangeSliderValueIndicatorShape | sdk |
| RoundedRectSliderValueIndicatorShape | RoundedRectSliderValueIndicatorShape | sdk |
| ScaffoldGeometry | ScaffoldGeometry | sdk |
| ScaffoldPrelayoutGeometry | ScaffoldPrelayoutGeometry | sdk |
| ScriptCategory | ScriptCategory | sdk |
| ScrollbarThemeData | ScrollbarThemeData | sdk |
| SearchController | SearchController | sdk |
| SearchDelegate | SearchDelegate | sdk |
| SegmentedButtonState | SegmentedButtonState | sdk |
| SelectionArea | SelectionArea | sdk |
| SelectionAreaState | SelectionAreaState | sdk |
| ShapeBorderTween | ShapeBorderTween | sdk |
| ShowValueIndicator | ShowValueIndicator | sdk |
| SimpleDialogOption | SimpleDialogOption | sdk |
| SliderInteraction | SliderInteraction | sdk |
| SnackBarThemeData | SnackBarThemeData | sdk |
| SpellCheckSuggestionsToolbarLayoutDelegate | SpellCheckSuggestionsToolbarLayoutDelegate | sdk |
| StandardFabLocation | StandardFabLocation | sdk |
| StepStyle | StepStyle | sdk |
| StretchMode | StretchMode | sdk |
| TabAlignment | TabAlignment | sdk |
| TabIndicatorAnimation | TabIndicatorAnimation | sdk |
| TabPageSelector | TabPageSelector | sdk |
| TabPageSelectorIndicator | TabPageSelectorIndicator | sdk |
| TableRowInkWell | TableRowInkWell | sdk |
| TappableChipAttributes | TappableChipAttributes | sdk |
| TextMagnifier | TextMagnifier | sdk |
| ThemeDataTween | ThemeDataTween | sdk |
| ThemeExtension | ThemeExtension | sdk |
| ThemeMode | ThemeMode | sdk |
| Thumb | Thumb | sdk |
| TimeOfDayFormat | TimeOfDayFormat | sdk |
| TimePickerEntryMode | TimePickerEntryMode | sdk |
| ToggleButtonsTheme | ToggleButtonsTheme | sdk |
| ToggleButtonsThemeData | ToggleButtonsThemeData | sdk |
| TooltipState | TooltipState | sdk |
| UnderlineTabIndicator | UnderlineTabIndicator | sdk |
| VerticalDivider | VerticalDivider | sdk |
| WidgetStateInputBorder | WidgetStateInputBorder | sdk |

---

## cupertino (67 classes)
*Sources: 14 from SDK, 53 testpriority-only*

| Class | Description | Source |
|-------|-------------|--------|
| CupertinoButtonSize | CupertinoButtonSize | sdk |
| CupertinoDesktopTextSelectionControls | CupertinoDesktopTextSelectionControls | sdk |
| CupertinoExpansionTile | CupertinoExpansionTile | sdk |
| CupertinoFocusHalo | CupertinoFocusHalo | sdk |
| CupertinoLinearActivityIndicator | CupertinoLinearActivityIndicator | sdk |
| CupertinoListSectionType | CupertinoListSectionType | sdk |
| CupertinoListTileChevron | CupertinoListTileChevron | sdk |
| CupertinoRenderActivityIndicator | Render indicator | tp-only |
| CupertinoRenderCheckbox | Render checkbox | tp-only |
| CupertinoRenderContextMenu | Render menu | tp-only |
| CupertinoRenderDatePicker | Render picker | tp-only |
| CupertinoRenderListTile | Render tile | tp-only |
| CupertinoRenderNavigationBar | Render nav | tp-only |
| CupertinoRenderPicker | Render picker | tp-only |
| CupertinoRenderRadio | Render radio | tp-only |
| CupertinoRenderScrollbar | Render scroll | tp-only |
| CupertinoRenderSearchTextField | Render search | tp-only |
| CupertinoRenderSegmentedControl | Render segment | tp-only |
| CupertinoRenderSlider | Render slider | tp-only |
| CupertinoRenderSlidingSegmentedControl | Render sliding | tp-only |
| CupertinoRenderSwitch | Render switch | tp-only |
| CupertinoRenderTabBar | Render tab | tp-only |
| CupertinoRenderTextField | Render field | tp-only |
| CupertinoRenderTimerPicker | Render timer | tp-only |
| CupertinoTextSelectionHandleControls | CupertinoTextSelectionHandleControls | sdk |
| CupertinoThumbPainter | CupertinoThumbPainter | sdk |
| ExpansionTileTransitionMode | ExpansionTileTransitionMode | sdk |
| InheritedCupertinoTheme | InheritedCupertinoTheme | sdk |
| NavigationBarBottomMode | NavigationBarBottomMode | sdk |
| OverlayVisibilityMode | OverlayVisibilityMode | sdk |
| RestorableCupertinoTabController | RestorableCupertinoTabController | sdk |
| _ActionSheetActionState | Private state | tp-only |
| _ActionSheetState | Private state | tp-only |
| _ActivityIndicatorState | Private state | tp-only |
| _AlertDialogRouteLayout | Private layout | tp-only |
| _AlertDialogState | Private state | tp-only |
| _ButtonState | Private state | tp-only |
| _CheckboxState | Private state | tp-only |
| _ContextMenuActionState | Private state | tp-only |
| _ContextMenuState | Private state | tp-only |
| _DatePickerState | Private state | tp-only |
| _DialogActionState | Private state | tp-only |
| _FormRowState | Private state | tp-only |
| _FormSectionState | Private state | tp-only |
| _ListSectionState | Private state | tp-only |
| _ListTileState | Private state | tp-only |
| _ModalBottomSheetState | Private state | tp-only |
| _NavigationBarState | Private state | tp-only |
| _PageScaffoldState | Private state | tp-only |
| _PickerState | Private state | tp-only |
| _PopupSurfaceState | Private state | tp-only |
| _RadioState | Private state | tp-only |
| _RefreshControlState | Private state | tp-only |
| _RoutedSheetState | Private state | tp-only |
| _ScrollbarState | Private state | tp-only |
| _SearchTextFieldState | Private state | tp-only |
| _SegmentedControlState | Private state | tp-only |
| _SheetRouteState | Private state | tp-only |
| _SliderState | Private state | tp-only |
| _SlidingSegmentedControlState | Private state | tp-only |
| _SwitchState | Private state | tp-only |
| _TabBarState | Private state | tp-only |
| _TabScaffoldState | Private state | tp-only |
| _TabViewState | Private state | tp-only |
| _TextFieldState | Private state | tp-only |
| _TextFormFieldRowState | Private state | tp-only |
| _TimerPickerState | Private state | tp-only |

---

## foundation (37 classes)
*Sources: 9 classified, 27 from SDK, 1 testpriority-only*

| Class | Description | Source |
|-------|-------------|--------|
| AbstractNode | AbstractNode | sdk |
| CachingIterable | CachingIterable | sdk |
| Category | Internal category | classified |
| DiagnosticLevel | DiagnosticLevel | sdk |
| Diagnosticable | Diagnosticable | sdk |
| DiagnosticableNode | DiagnosticableNode | sdk |
| DiagnosticableTree | DiagnosticableTree | sdk |
| DiagnosticableTreeMixin | DiagnosticableTreeMixin | sdk |
| DiagnosticableTreeNode | DiagnosticableTreeNode | sdk |
| DiagnosticsBlock | DiagnosticsBlock | sdk |
| DiagnosticsProperty | DiagnosticsProperty | sdk |
| DiagnosticsSerializationDelegate | DiagnosticsSerializationDelegate | sdk |
| DiagnosticsStackTrace | Stack diagnostics | classified |
| DiagnosticsTreeStyle | DiagnosticsTreeStyle | sdk |
| DocumentationIcon | Doc icon annotation | classified |
| DoubleProperty | DoubleProperty | sdk |
| EnumProperty | EnumProperty | sdk |
| ErrorSpacer | Error formatting | classified |
| Factory | Factory | sdk |
| FlagProperty | FlagProperty | sdk |
| FlagsSummary | FlagsSummary | sdk |
| FlutterMemoryAllocations | Memory tracking | classified |
| FoundationServiceExtensions | FoundationServiceExtensions | sdk |
| Immutable | Immutability annotation | tp-only |
| IntProperty | IntProperty | sdk |
| IterableProperty | IterableProperty | sdk |
| MessageProperty | MessageProperty | sdk |
| ObjectCreated | Object lifecycle | classified |
| ObjectDisposed | Object lifecycle | classified |
| ObjectEvent | Object events | classified |
| ObjectFlagProperty | ObjectFlagProperty | sdk |
| PercentProperty | PercentProperty | sdk |
| StringProperty | StringProperty | sdk |
| Summary | Summary annotation | classified |
| TargetPlatform | TargetPlatform | sdk |
| TextTreeConfiguration | TextTreeConfiguration | sdk |
| TextTreeRenderer | TextTreeRenderer | sdk |

---

## painting (31 classes)
*Sources: 17 classified, 14 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| Accumulator | Internal accumulation | classified |
| AssetBundleImageKey | Asset cache key | classified |
| AssetBundleImageProvider | Asset image base | classified |
| Axis | Axis | sdk |
| AxisDirection | AxisDirection | sdk |
| BorderStyle | BorderStyle | sdk |
| BoxFit | BoxFit | sdk |
| BoxShape | BoxShape | sdk |
| ClipContext | Clipping context | classified |
| ColorProperty | Diagnostics property | classified |
| FittedSizes | Fitted size calculation | classified |
| FlutterLogoStyle | FlutterLogoStyle | sdk |
| ImageRepeat | ImageRepeat | sdk |
| ImageSizeInfo | Image size debugging | classified |
| ImageStreamCompleterHandle | Stream handle | classified |
| InlineSpan | Inline text span | classified |
| InlineSpanSemanticsInformation | Span semantics | classified |
| MatrixUtils | Matrix utilities | classified |
| MultiFrameImageStreamCompleter | Multi-frame images | classified |
| NetworkImageLoadException | Network error | classified |
| OneFrameImageStreamCompleter | Single-frame images | classified |
| PaintingBinding | Painting binding | classified |
| RenderComparison | RenderComparison | sdk |
| ResizeImagePolicy | ResizeImagePolicy | sdk |
| ShaderWarmUp | Shader precompilation | classified |
| TextOverflow | TextOverflow | sdk |
| TextWidthBasis | TextWidthBasis | sdk |
| TransformProperty | Transform diagnostics | classified |
| VerticalDirection | VerticalDirection | sdk |
| WebHtmlElementStrategy | WebHtmlElementStrategy | sdk |
| WebImageInfo | WebImageInfo | sdk |

---

## rendering (95 classes)
*Sources: 64 classified, 31 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| AlignmentGeometryTween | Alignment tween | classified |
| AlignmentTween | Alignment tween | classified |
| AnnotatedRegionLayer | Annotated layer | classified |
| AnnotationEntry | Annotation entry | classified |
| AnnotationResult | Annotation result | classified |
| BackdropKey | Backdrop key | classified |
| CacheExtentStyle | CacheExtentStyle | sdk |
| ChildLayoutHelper | Layout helper | classified |
| ClearSelectionEvent | Clear selection | classified |
| ContainerParentDataMixin | ContainerParentDataMixin | sdk |
| CrossAxisAlignment | CrossAxisAlignment | sdk |
| DecorationPosition | DecorationPosition | sdk |
| DiagnosticsDebugCreator | Debug creator | classified |
| DirectionallyExtendSelectionEvent | Directional extend | classified |
| FlexFit | FlexFit | sdk |
| FloatingHeaderSnapConfiguration | Header snap config | classified |
| FlowPaintingContext | Flow context | classified |
| FlowParentData | Flow parent data | classified |
| FractionColumnWidth | Fraction column | classified |
| FractionalOffsetTween | Offset tween | classified |
| GranularlyExtendSelectionEvent | Granular extend | classified |
| GrowthDirection | GrowthDirection | sdk |
| HitTestBehavior | HitTestBehavior | sdk |
| ImageFilterConfig | Filter config | classified |
| ImageFilterContext | Filter context | classified |
| ListWheelChildManager | Wheel manager | classified |
| MainAxisAlignment | MainAxisAlignment | sdk |
| MainAxisSize | MainAxisSize | sdk |
| MaxColumnWidth | Max column | classified |
| MinColumnWidth | Min column | classified |
| MultiChildLayoutParentData | MultiChildLayoutParentData | sdk |
| OverScrollHeaderStretchConfiguration | Stretch config | classified |
| OverflowBoxFit | OverflowBoxFit | sdk |
| PerformanceOverlayOption | PerformanceOverlayOption | sdk |
| PersistentHeaderShowOnScreenConfiguration | Show on screen | classified |
| PipelineManifold | Pipeline manifold | classified |
| PlaceholderSpanIndexSemanticsTag | Placeholder tag | classified |
| PlatformViewHitTestBehavior | PlatformViewHitTestBehavior | sdk |
| PlatformViewRenderBox | Platform view box | classified |
| RenderAbstractViewport | Abstract viewport | classified |
| RenderAndroidView | Android view | classified |
| RenderAnimatedOpacityMixin | RenderAnimatedOpacityMixin | sdk |
| RenderAnimatedSizeState | RenderAnimatedSizeState | sdk |
| RenderAppKitView | macOS view | classified |
| RenderClipRSuperellipse | Clip superellipse | classified |
| RenderDarwinPlatformView | Darwin view | classified |
| RenderDecoratedSliver | RenderDecoratedSliver | sdk |
| RenderEditablePainter | Editable painter | classified |
| RenderInlineChildrenContainerDefaults | Inline defaults | classified |
| RenderObjectWithLayoutCallbackMixin | Layout callback | classified |
| RenderPerformanceOverlay | RenderPerformanceOverlay | sdk |
| RenderProxySliver | Proxy sliver | classified |
| RenderSliverBoxChildManager | Box child manager | classified |
| RenderSliverConstrainedCrossAxis | Constrained cross | classified |
| RenderSliverCrossAxisGroup | Cross axis group | classified |
| RenderSliverEdgeInsetsPadding | Edge insets padding | classified |
| RenderSliverFillRemainingAndOverscroll | Overscroll remaining | classified |
| RenderSliverFillRemainingWithScrollable | Scrollable remaining | classified |
| RenderSliverFixedExtentBoxAdaptor | Fixed extent adaptor | classified |
| RenderSliverFloatingPinnedPersistentHeader | Floating pinned | classified |
| RenderSliverMainAxisGroup | Main axis group | classified |
| RenderSliverSemanticsAnnotations | Sliver semantics | classified |
| RenderSliverSingleBoxAdapter | Single box adapter | classified |
| RenderUiKitView | iOS view | classified |
| RenderingServiceExtensions | RenderingServiceExtensions | sdk |
| RevealedOffset | Revealed offset | classified |
| ScrollDirection | ScrollDirection | sdk |
| SelectAllSelectionEvent | Select all | classified |
| SelectParagraphSelectionEvent | Select paragraph | classified |
| SelectWordSelectionEvent | Select word | classified |
| SelectedContentRange | Content range | classified |
| SelectionEdgeUpdateEvent | Edge update | classified |
| SelectionEvent | Selection event | classified |
| SelectionEventType | SelectionEventType | sdk |
| SelectionExtendDirection | SelectionExtendDirection | sdk |
| SelectionHandler | Selection handler | classified |
| SelectionRegistrant | Selection registrant | classified |
| SelectionResult | SelectionResult | sdk |
| SelectionStatus | SelectionStatus | sdk |
| SelectionUtils | Selection utils | classified |
| SliverLogicalContainerParentData | Logical container | classified |
| SliverPaintOrder | SliverPaintOrder | sdk |
| SliverPhysicalContainerParentData | Physical container | classified |
| StackFit | StackFit | sdk |
| TableBorder | Table border | classified |
| TableCellVerticalAlignment | TableCellVerticalAlignment | sdk |
| TextGranularity | TextGranularity | sdk |
| TextSelectionHandleType | TextSelectionHandleType | sdk |
| TextureBox | Texture box | classified |
| TreeSliverIndentationType | Tree indent | classified |
| TreeSliverNodeParentData | Tree node data | classified |
| VerticalCaretMovementRun | Caret movement | classified |
| WrapAlignment | WrapAlignment | sdk |
| WrapCrossAlignment | WrapCrossAlignment | sdk |
| const | const | sdk |

---

## animation (30 classes)
*Sources: 4 classified, 26 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| AnimationBehavior | AnimationBehavior | sdk |
| AnimationEagerListenerMixin | Eager listener mixin | classified |
| AnimationLazyListenerMixin | Lazy listener mixin | classified |
| AnimationLocalListenersMixin | Local listeners mixin | classified |
| AnimationLocalStatusListenersMixin | Status listeners mixin | classified |
| AnimationStatus | AnimationStatus | sdk |
| CatmullRomCurve | CatmullRomCurve | sdk |
| CatmullRomSpline | CatmullRomSpline | sdk |
| ColorTween | ColorTween | sdk |
| ConstantTween | ConstantTween | sdk |
| Cubic | Cubic | sdk |
| Curve2D | Curve2D | sdk |
| Curve2DSample | Curve2DSample | sdk |
| CurveTween | CurveTween | sdk |
| Curves | Curves | sdk |
| ElasticInCurve | ElasticInCurve | sdk |
| ElasticInOutCurve | ElasticInOutCurve | sdk |
| ElasticOutCurve | ElasticOutCurve | sdk |
| FlippedCurve | FlippedCurve | sdk |
| IntTween | IntTween | sdk |
| Interval | Interval | sdk |
| ParametricCurve | ParametricCurve | sdk |
| RectTween | RectTween | sdk |
| ReverseTween | ReverseTween | sdk |
| SawTooth | SawTooth | sdk |
| SizeTween | SizeTween | sdk |
| Split | Split | sdk |
| StepTween | StepTween | sdk |
| ThreePointCubic | ThreePointCubic | sdk |
| Threshold | Threshold | sdk |

---

## gestures (46 classes)
*Sources: 13 classified, 31 from SDK, 2 testpriority-only*

| Class | Description | Source |
|-------|-------------|--------|
| BaseTapGestureRecognizer | BaseTapGestureRecognizer | sdk |
| DragDownDetails | DragDownDetails | sdk |
| DragStartBehavior | DragStartBehavior | sdk |
| DragStartDetails | DragStartDetails | sdk |
| FlutterErrorDetailsForPointerEventDispatcher | Error details | classified |
| GestureDisposition | GestureDisposition | sdk |
| GestureRecognizer | GestureRecognizer | sdk |
| GestureRecognizerState | GestureRecognizerState | sdk |
| HitTestDispatcher | HitTestDispatcher | sdk |
| HitTestable | HitTestable | sdk |
| IOSScrollViewFlingVelocityTracker | IOSScrollViewFlingVelocityTracker | sdk |
| LeastSquaresSolver | Math solver | classified |
| MacOSScrollViewFlingVelocityTracker | MacOSScrollViewFlingVelocityTracker | sdk |
| Matrix4 | Transform matrix | tp-only |
| MultitouchDragStrategy | MultitouchDragStrategy | sdk |
| OffsetPair | OffsetPair | sdk |
| OneSequenceGestureRecognizer | OneSequenceGestureRecognizer | sdk |
| PointerAddedEvent | PointerAddedEvent | sdk |
| PointerCancelEvent | Pointer cancel | classified |
| PointerDownEvent | Pointer down | classified |
| PointerEnterEvent | PointerEnterEvent | sdk |
| PointerEvent | Base pointer event | classified |
| PointerEventConverter | Event conversion | classified |
| PointerEventResampler | Event resampling | classified |
| PointerExitEvent | PointerExitEvent | sdk |
| PointerHoverEvent | PointerHoverEvent | sdk |
| PointerMoveEvent | PointerMoveEvent | sdk |
| PointerPanZoomEndEvent | PointerPanZoomEndEvent | sdk |
| PointerPanZoomStartEvent | Pan zoom start | classified |
| PointerPanZoomUpdateEvent | PointerPanZoomUpdateEvent | sdk |
| PointerRemovedEvent | PointerRemovedEvent | sdk |
| PointerScaleEvent | PointerScaleEvent | sdk |
| PointerScrollEvent | PointerScrollEvent | sdk |
| PointerScrollInertiaCancelEvent | PointerScrollInertiaCancelEvent | sdk |
| PointerSignalEvent | Pointer signal | classified |
| PointerSignalResolver | Signal resolution | classified |
| PointerUpEvent | Pointer up | classified |
| PolynomialFit | Polynomial fitting | classified |
| PrimaryPointerGestureRecognizer | PrimaryPointerGestureRecognizer | sdk |
| SamplingClock | Sampling clock | classified |
| TapAndDragGestureRecognizer | TapAndDragGestureRecognizer | sdk |
| TapGestureRecognizer | TapGestureRecognizer | sdk |
| TapMoveDetails | TapMoveDetails | sdk |
| Vector3 | 3D vector | tp-only |
| VelocityEstimate | VelocityEstimate | sdk |
| VelocityTracker | VelocityTracker | sdk |

---

## services (89 classes)
*Sources: 16 classified, 73 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| AndroidMotionEvent | Android motion | classified |
| AndroidPointerCoords | Android coords | classified |
| AndroidPointerProperties | Android properties | classified |
| ApplicationSwitcherDescription | App switcher | classified |
| AutofillClient | AutofillClient | sdk |
| AutofillHints | AutofillHints | sdk |
| AutofillScopeMixin | AutofillScopeMixin | sdk |
| BackgroundIsolateBinaryMessenger | BackgroundIsolateBinaryMessenger | sdk |
| BinaryMessenger | Binary messaging | classified |
| ContentSensitivity | ContentSensitivity | sdk |
| DeferredComponent | Deferred loading | classified |
| DeltaTextInputClient | DeltaTextInputClient | sdk |
| DeviceOrientation | DeviceOrientation | sdk |
| FloatingCursorDragState | FloatingCursorDragState | sdk |
| GLFWKeyHelper | GLFWKeyHelper | sdk |
| GtkKeyHelper | GtkKeyHelper | sdk |
| IOSSystemContextMenuItemData | IOSSystemContextMenuItemData | sdk |
| IOSSystemContextMenuItemDataCopy | IOSSystemContextMenuItemDataCopy | sdk |
| IOSSystemContextMenuItemDataCustom | IOSSystemContextMenuItemDataCustom | sdk |
| IOSSystemContextMenuItemDataCut | IOSSystemContextMenuItemDataCut | sdk |
| IOSSystemContextMenuItemDataLiveText | IOSSystemContextMenuItemDataLiveText | sdk |
| IOSSystemContextMenuItemDataLookUp | IOSSystemContextMenuItemDataLookUp | sdk |
| IOSSystemContextMenuItemDataPaste | IOSSystemContextMenuItemDataPaste | sdk |
| IOSSystemContextMenuItemDataSearchWeb | IOSSystemContextMenuItemDataSearchWeb | sdk |
| IOSSystemContextMenuItemDataSelectAll | IOSSystemContextMenuItemDataSelectAll | sdk |
| IOSSystemContextMenuItemDataShare | IOSSystemContextMenuItemDataShare | sdk |
| KeyDataTransitMode | KeyDataTransitMode | sdk |
| KeyDownEvent | KeyDownEvent | sdk |
| KeyEvent | KeyEvent | sdk |
| KeyEventManager | KeyEventManager | sdk |
| KeyHelper | KeyHelper | sdk |
| KeyMessage | KeyMessage | sdk |
| KeyRepeatEvent | KeyRepeatEvent | sdk |
| KeyUpEvent | KeyUpEvent | sdk |
| KeyboardKey | KeyboardKey | sdk |
| KeyboardLockMode | KeyboardLockMode | sdk |
| KeyboardSide | KeyboardSide | sdk |
| MaxLengthEnforcement | MaxLengthEnforcement | sdk |
| MessageCodec | Message codec base | classified |
| MethodCodec | Method codec base | classified |
| MissingPluginException | Plugin error | classified |
| ModifierKey | ModifierKey | sdk |
| MouseCursorManager | Cursor manager | classified |
| MouseCursorSession | Cursor session | classified |
| MouseTrackerAnnotation | Mouse tracking | classified |
| PlatformException | Platform error | classified |
| RawFloatingCursorPoint | RawFloatingCursorPoint | sdk |
| RawKeyDownEvent | RawKeyDownEvent | sdk |
| RawKeyEvent | RawKeyEvent | sdk |
| RawKeyEventData | RawKeyEventData | sdk |
| RawKeyEventDataAndroid | RawKeyEventDataAndroid | sdk |
| RawKeyEventDataFuchsia | RawKeyEventDataFuchsia | sdk |
| RawKeyEventDataIos | RawKeyEventDataIos | sdk |
| RawKeyEventDataLinux | RawKeyEventDataLinux | sdk |
| RawKeyEventDataMacOs | RawKeyEventDataMacOs | sdk |
| RawKeyEventDataWeb | RawKeyEventDataWeb | sdk |
| RawKeyEventDataWindows | RawKeyEventDataWindows | sdk |
| RawKeyUpEvent | RawKeyUpEvent | sdk |
| RawKeyboard | RawKeyboard | sdk |
| RestorationBucket | RestorationBucket | sdk |
| ScribbleClient | ScribbleClient | sdk |
| SelectionChangedCause | SelectionChangedCause | sdk |
| SelectionRect | SelectionRect | sdk |
| SensitiveContentService | Sensitive content | classified |
| ServicesServiceExtensions | ServicesServiceExtensions | sdk |
| SmartDashesType | SmartDashesType | sdk |
| SmartQuotesType | SmartQuotesType | sdk |
| SwipeEdge | SwipeEdge | sdk |
| SystemContextMenuClient | Context menu | classified |
| SystemContextMenuController | SystemContextMenuController | sdk |
| SystemSoundType | SystemSoundType | sdk |
| SystemUiMode | SystemUiMode | sdk |
| SystemUiOverlay | SystemUiOverlay | sdk |
| TextCapitalization | TextCapitalization | sdk |
| TextEditingDeltaDeletion | TextEditingDeltaDeletion | sdk |
| TextEditingDeltaInsertion | TextEditingDeltaInsertion | sdk |
| TextEditingDeltaNonTextUpdate | TextEditingDeltaNonTextUpdate | sdk |
| TextEditingDeltaReplacement | TextEditingDeltaReplacement | sdk |
| TextEditingValue | TextEditingValue | sdk |
| TextInput | TextInput | sdk |
| TextInputAction | TextInputAction | sdk |
| TextInputClient | TextInputClient | sdk |
| TextInputConfiguration | TextInputConfiguration | sdk |
| TextInputConnection | TextInputConnection | sdk |
| TextInputControl | TextInputControl | sdk |
| TextInputType | TextInputType | sdk |
| TextSelection | Text selection | classified |
| TextSelectionDelegate | TextSelectionDelegate | sdk |
| UndoDirection | UndoDirection | sdk |

---

## dart:ui (75 classes)
*Sources: 27 classified, 48 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| AppExitResponse | AppExitResponse | sdk |
| AppExitType | AppExitType | sdk |
| AppLifecycleState | AppLifecycleState | sdk |
| BackdropFilterEngineLayer | Backdrop filter layer | classified |
| BlendMode | BlendMode | sdk |
| BlurStyle | BlurStyle | sdk |
| BoxHeightStyle | BoxHeightStyle | sdk |
| BoxWidthStyle | BoxWidthStyle | sdk |
| CallbackHandle | Callback registration | classified |
| ChannelBuffers | Platform channel buffers | classified |
| CheckedState | CheckedState | sdk |
| Clip | Clip | sdk |
| ClipOp | ClipOp | sdk |
| ClipPathEngineLayer | Clip path layer | classified |
| ClipRRectEngineLayer | Clip rounded rect layer | classified |
| ClipRSuperellipseEngineLayer | Clip superellipse layer | classified |
| ClipRectEngineLayer | Clip rect layer | classified |
| ColorFilterEngineLayer | Color filter layer | classified |
| ColorSpace | ColorSpace | sdk |
| DartPerformanceMode | DartPerformanceMode | sdk |
| DartPluginRegistrant | Plugin registration | classified |
| DisplayFeatureState | DisplayFeatureState | sdk |
| DisplayFeatureType | DisplayFeatureType | sdk |
| EngineLayer | Base engine layer | classified |
| FilterQuality | FilterQuality | sdk |
| FontStyle | FontStyle | sdk |
| FragmentProgram | Fragment shader program | classified |
| FragmentShader | Fragment shader instance | classified |
| FramePhase | FramePhase | sdk |
| ImageByteFormat | ImageByteFormat | sdk |
| ImageFilterEngineLayer | Image filter layer | classified |
| ImageSamplerSlot | Shader image sampler | classified |
| IsolateNameServer | Isolate communication | classified |
| KeyEventDeviceType | KeyEventDeviceType | sdk |
| KeyEventType | KeyEventType | sdk |
| OffsetEngineLayer | Offset layer | classified |
| OpacityEngineLayer | Opacity layer | classified |
| PaintingStyle | PaintingStyle | sdk |
| PathFillType | PathFillType | sdk |
| PathOperation | PathOperation | sdk |
| PictureRasterizationException | Picture error | classified |
| PixelFormat | PixelFormat | sdk |
| PlaceholderAlignment | PlaceholderAlignment | sdk |
| PluginUtilities | Plugin utilities | classified |
| PointMode | PointMode | sdk |
| PointerChange | PointerChange | sdk |
| PointerDeviceKind | PointerDeviceKind | sdk |
| PointerSignalKind | PointerSignalKind | sdk |
| RootIsolateToken | Root isolate token | classified |
| SemanticsHitTestBehavior | SemanticsHitTestBehavior | sdk |
| SemanticsInputType | SemanticsInputType | sdk |
| SemanticsRole | SemanticsRole | sdk |
| SemanticsValidationResult | SemanticsValidationResult | sdk |
| ShaderMaskEngineLayer | Shader mask layer | classified |
| SingletonFlutterWindow | SingletonFlutterWindow | sdk |
| StrokeCap | StrokeCap | sdk |
| StrokeJoin | StrokeJoin | sdk |
| SystemColorPalette | System color palette | classified |
| TargetPixelFormat | TargetPixelFormat | sdk |
| TextAffinity | TextAffinity | sdk |
| TextAlign | TextAlign | sdk |
| TextBaseline | TextBaseline | sdk |
| TextDecorationStyle | TextDecorationStyle | sdk |
| TextDirection | TextDirection | sdk |
| TextLeadingDistribution | TextLeadingDistribution | sdk |
| TileMode | TileMode | sdk |
| TransformEngineLayer | Transform layer | classified |
| Tristate | Tristate | sdk |
| UniformFloatSlot | Shader uniform slot | classified |
| UniformVec2Slot | Shader vec2 slot | classified |
| UniformVec3Slot | Shader vec3 slot | classified |
| UniformVec4Slot | Shader vec4 slot | classified |
| VertexMode | VertexMode | sdk |
| ViewFocusDirection | ViewFocusDirection | sdk |
| ViewFocusState | ViewFocusState | sdk |

---

## semantics (9 classes)
*Sources: 1 classified, 8 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| AccessibilityFocusBlockType | AccessibilityFocusBlockType | sdk |
| AnnounceSemanticsEvent | AnnounceSemanticsEvent | sdk |
| Assertiveness | Assertiveness | sdk |
| AttributedStringProperty | Diagnostics property | classified |
| DebugSemanticsDumpOrder | DebugSemanticsDumpOrder | sdk |
| FocusSemanticEvent | FocusSemanticEvent | sdk |
| LongPressSemanticsEvent | LongPressSemanticsEvent | sdk |
| TapSemanticEvent | TapSemanticEvent | sdk |
| TooltipSemanticsEvent | TooltipSemanticsEvent | sdk |

---

## scheduler (3 classes)
*Sources: 3 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| Priority | Priority | sdk |
| SchedulerPhase | SchedulerPhase | sdk |
| SchedulerServiceExtensions | SchedulerServiceExtensions | sdk |

---

## physics (2 classes)
*Sources: 1 classified, 1 from SDK*

| Class | Description | Source |
|-------|-------------|--------|
| BoundedFrictionSimulation | Bounded friction | classified |
| SpringType | SpringType | sdk |

---

## Summary

| Package | Classified | SDK-only | TP-only | Total |
|---------|-----------|----------|---------|-------|
| widgets | 35 | 420 | 2 | 457 |
| material | 1 | 165 | 1 | 167 |
| cupertino | 0 | 14 | 53 | 67 |
| foundation | 9 | 27 | 1 | 37 |
| painting | 17 | 14 | 0 | 31 |
| rendering | 64 | 31 | 0 | 95 |
| animation | 4 | 26 | 0 | 30 |
| gestures | 13 | 31 | 2 | 46 |
| services | 16 | 73 | 0 | 89 |
| dart:ui | 27 | 48 | 0 | 75 |
| semantics | 1 | 8 | 0 | 9 |
| scheduler | 0 | 3 | 0 | 3 |
| physics | 1 | 1 | 0 | 2 |
| **Total** | **188** | **861** | **59** | **1108** |

---

*Generated from Flutter SDK analysis cross-referenced with testpriority files.*
*Flutter SDK: /srv/flutter/flutter/ — 1108 unique hardly relevant classes across 0 packages.*
