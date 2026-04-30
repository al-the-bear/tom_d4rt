# Test Plan: Hardly Relevant Classes

**Priority: HARDLY RELEVANT**
**Total classes: 1108**
**Coverage: 1049/1108 classes scripted, 59 tp-only skipped**

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

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AbstractLayoutBuilder | Layout builder base | classified | scripted |
| ActionDispatcher | Action dispatch | classified | scripted |
| ActionListener | Action listener | classified | scripted |
| ActivateAction | Activate action | classified | scripted |
| ActivateIntent | Activate intent | classified | scripted |
| AlignTransition | Transition | classified | scripted |
| AndroidOverscrollIndicator | AndroidOverscrollIndicator | sdk | scripted |
| AndroidViewSurface | Surface | classified | scripted |
| AnimatedGridState | Grid state | classified | scripted |
| AnimatedListState | List state | classified | scripted |
| AnimatedPositionedDirectional | Directional | classified | scripted |
| AnimatedWidgetBaseState | State | classified | scripted |
| AnnotatedRegion | Region | classified | scripted |
| AppKitView | AppKitView | sdk | scripted |
| AppLifecycleListener | AppLifecycleListener | sdk | scripted |
| AsyncSnapshot | Async snapshot | classified | scripted |
| AutocompleteFirstOptionIntent | First option | classified | scripted |
| AutocompleteHighlightedOption | Autocomplete | classified | scripted |
| AutocompleteLastOptionIntent | AutocompleteLastOptionIntent | sdk | scripted |
| AutocompleteNextOptionIntent | Next option | classified | scripted |
| AutocompleteNextPageOptionIntent | AutocompleteNextPageOptionIntent | sdk | scripted |
| AutocompletePreviousOptionIntent | Prev option | classified | scripted |
| AutocompletePreviousPageOptionIntent | AutocompletePreviousPageOptionIntent | sdk | scripted |
| AutofillContextAction | AutofillContextAction | sdk | scripted |
| AutofillGroupState | Autofill state | classified | scripted |
| AutomaticKeepAliveClientMixin | Keep alive mixin | classified | scripted |
| AutovalidateMode | AutovalidateMode | sdk | scripted |
| BackButtonListener | Back button | classified | scripted |
| BackdropGroup | BackdropGroup | sdk | scripted |
| BallisticScrollActivity | Scroll activity | classified | scripted |
| BannerLocation | BannerLocation | sdk | scripted |
| BannerPainter | Banner painter | classified | scripted |
| BaseWindowController | BaseWindowController | sdk | scripted |
| BorderRadiusTween | Radius tween | classified | scripted |
| BorderTween | Border tween | classified | scripted |
| BottomNavigationBarItem | BottomNavigationBarItem | sdk | scripted |
| BouncingScrollSimulation | Bounce sim | classified | scripted |
| BoxConstraintsTween | Constraints tween | classified | scripted |
| BoxScrollView | Scroll view base | classified | scripted |
| ButtonActivateIntent | Button activate | classified | scripted |
| CallbackShortcuts | Callback shortcuts | classified | scripted |
| CapturedThemes | Captured themes | classified | scripted |
| ChangeReportingBehavior | ChangeReportingBehavior | sdk | scripted |
| CharacterActivator | Char activator | classified | scripted |
| CharacterRange | Char range | tp-only | tp-only |
| Characters | String characters | tp-only | tp-only |
| ChildBackButtonDispatcher | Child dispatcher | classified | scripted |
| ChildVicinity | Child location | classified | scripted |
| ClampingScrollSimulation | Clamp sim | classified | scripted |
| ClipRSuperellipse | ClipRSuperellipse | sdk | scripted |
| ClipboardStatus | ClipboardStatus | sdk | scripted |
| ClipboardStatusNotifier | Clipboard status | classified | scripted |
| ConnectionState | ConnectionState | sdk | scripted |
| ConstrainedLayoutBuilder | ConstrainedLayoutBuilder | sdk | scripted |
| ConstraintsTransformBox | ConstraintsTransformBox | sdk | scripted |
| ContextAction | ContextAction | sdk | scripted |
| ContextMenuButtonType | ContextMenuButtonType | sdk | scripted |
| CopySelectionTextIntent | CopySelectionTextIntent | sdk | scripted |
| CrossFadeState | CrossFadeState | sdk | scripted |
| DebugCreator | DebugCreator | sdk | scripted |
| DecoratedSliver | DecoratedSliver | sdk | scripted |
| DecorationTween | DecorationTween | sdk | scripted |
| DefaultPlatformMenuDelegate | DefaultPlatformMenuDelegate | sdk | scripted |
| DefaultSelectionStyle | DefaultSelectionStyle | sdk | scripted |
| DefaultTextEditingShortcuts | DefaultTextEditingShortcuts | sdk | scripted |
| DefaultTextStyleTransition | DefaultTextStyleTransition | sdk | scripted |
| DefaultTransitionDelegate | DefaultTransitionDelegate | sdk | scripted |
| DeleteCharacterIntent | DeleteCharacterIntent | sdk | scripted |
| DeleteToLineBreakIntent | DeleteToLineBreakIntent | sdk | scripted |
| DeleteToNextWordBoundaryIntent | DeleteToNextWordBoundaryIntent | sdk | scripted |
| DesktopTextSelectionToolbarLayoutDelegate | DesktopTextSelectionToolbarLayoutDelegate | sdk | scripted |
| DevToolsDeepLinkProperty | DevToolsDeepLinkProperty | sdk | scripted |
| DeviceOrientationBuilder | DeviceOrientationBuilder | sdk | scripted |
| DiagonalDragBehavior | DiagonalDragBehavior | sdk | scripted |
| DialogWindow | DialogWindow | sdk | scripted |
| DialogWindowController | DialogWindowController | sdk | scripted |
| DialogWindowControllerDelegate | DialogWindowControllerDelegate | sdk | scripted |
| DialogWindowControllerLinux | DialogWindowControllerLinux | sdk | scripted |
| DialogWindowControllerMacOS | DialogWindowControllerMacOS | sdk | scripted |
| DialogWindowControllerWin32 | DialogWindowControllerWin32 | sdk | scripted |
| DirectionalCaretMovementIntent | DirectionalCaretMovementIntent | sdk | scripted |
| DirectionalFocusAction | DirectionalFocusAction | sdk | scripted |
| DirectionalFocusIntent | DirectionalFocusIntent | sdk | scripted |
| DirectionalFocusTraversalPolicyMixin | DirectionalFocusTraversalPolicyMixin | sdk | scripted |
| DirectionalTextEditingIntent | DirectionalTextEditingIntent | sdk | scripted |
| DisableWidgetInspectorScope | DisableWidgetInspectorScope | sdk | scripted |
| DismissAction | DismissAction | sdk | scripted |
| DismissDirection | DismissDirection | sdk | scripted |
| DismissIntent | DismissIntent | sdk | scripted |
| DismissMenuAction | DismissMenuAction | sdk | scripted |
| DismissUpdateDetails | DismissUpdateDetails | sdk | scripted |
| Dismissible | Dismissible | sdk | scripted |
| DisposableBuildContext | DisposableBuildContext | sdk | scripted |
| DoNothingAction | DoNothingAction | sdk | scripted |
| DoNothingAndStopPropagationIntent | DoNothingAndStopPropagationIntent | sdk | scripted |
| DoNothingAndStopPropagationTextIntent | DoNothingAndStopPropagationTextIntent | sdk | scripted |
| DoNothingIntent | DoNothingIntent | sdk | scripted |
| DragBoundary | DragBoundary | sdk | scripted |
| DragBoundaryDelegate | DragBoundaryDelegate | sdk | scripted |
| DragScrollActivity | DragScrollActivity | sdk | scripted |
| DragTargetDetails | DragTargetDetails | sdk | scripted |
| DraggableDetails | DraggableDetails | sdk | scripted |
| DraggableScrollableActuator | DraggableScrollableActuator | sdk | scripted |
| DraggableScrollableController | DraggableScrollableController | sdk | scripted |
| DraggableScrollableNotification | DraggableScrollableNotification | sdk | scripted |
| DrivenScrollActivity | DrivenScrollActivity | sdk | scripted |
| EdgeDraggingAutoScroller | EdgeDraggingAutoScroller | sdk | scripted |
| EdgeInsetsGeometryTween | EdgeInsetsGeometryTween | sdk | scripted |
| EdgeInsetsTween | EdgeInsetsTween | sdk | scripted |
| EditableTextTapOutsideIntent | EditableTextTapOutsideIntent | sdk | scripted |
| EditableTextTapUpOutsideIntent | EditableTextTapUpOutsideIntent | sdk | scripted |
| EmptyTextSelectionControls | EmptyTextSelectionControls | sdk | scripted |
| EnableWidgetInspectorScope | EnableWidgetInspectorScope | sdk | scripted |
| ExcludeFocus | ExcludeFocus | sdk | scripted |
| ExcludeFocusTraversal | ExcludeFocusTraversal | sdk | scripted |
| ExpandSelectionToDocumentBoundaryIntent | ExpandSelectionToDocumentBoundaryIntent | sdk | scripted |
| ExpandSelectionToLineBreakIntent | ExpandSelectionToLineBreakIntent | sdk | scripted |
| Expansible | Expansible | sdk | scripted |
| ExpansibleController | ExpansibleController | sdk | scripted |
| ExtendSelectionByCharacterIntent | ExtendSelectionByCharacterIntent | sdk | scripted |
| ExtendSelectionByPageIntent | ExtendSelectionByPageIntent | sdk | scripted |
| ExtendSelectionToDocumentBoundaryIntent | ExtendSelectionToDocumentBoundaryIntent | sdk | scripted |
| ExtendSelectionToLineBreakIntent | ExtendSelectionToLineBreakIntent | sdk | scripted |
| ExtendSelectionToNextParagraphBoundaryIntent | ExtendSelectionToNextParagraphBoundaryIntent | sdk | scripted |
| ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent | ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent | sdk | scripted |
| ExtendSelectionToNextWordBoundaryIntent | ExtendSelectionToNextWordBoundaryIntent | sdk | scripted |
| ExtendSelectionToNextWordBoundaryOrCaretLocationIntent | ExtendSelectionToNextWordBoundaryOrCaretLocationIntent | sdk | scripted |
| ExtendSelectionVerticallyToAdjacentLineIntent | ExtendSelectionVerticallyToAdjacentLineIntent | sdk | scripted |
| ExtendSelectionVerticallyToAdjacentPageIntent | ExtendSelectionVerticallyToAdjacentPageIntent | sdk | scripted |
| Feedback | Feedback | sdk | scripted |
| FixedScrollMetrics | FixedScrollMetrics | sdk | scripted |
| Flex | Flex | sdk | scripted |
| FloatingHeaderSnapMode | FloatingHeaderSnapMode | sdk | scripted |
| FocusAttachment | FocusAttachment | sdk | scripted |
| FocusHighlightMode | FocusHighlightMode | sdk | scripted |
| FocusHighlightStrategy | FocusHighlightStrategy | sdk | scripted |
| FocusOrder | FocusOrder | sdk | scripted |
| FocusScopeNode | FocusScopeNode | sdk | scripted |
| FocusTraversalOrder | FocusTraversalOrder | sdk | scripted |
| FractionalTranslation | FractionalTranslation | sdk | scripted |
| GestureRecognizerFactory | GestureRecognizerFactory | sdk | scripted |
| GestureRecognizerFactoryWithHandlers | GestureRecognizerFactoryWithHandlers | sdk | scripted |
| GlobalObjectKey | GlobalObjectKey | sdk | scripted |
| HeroController | HeroController | sdk | scripted |
| HeroControllerScope | HeroControllerScope | sdk | scripted |
| HeroFlightDirection | HeroFlightDirection | sdk | scripted |
| HoldScrollActivity | HoldScrollActivity | sdk | scripted |
| IOSSystemContextMenuItem | IOSSystemContextMenuItem | sdk | scripted |
| IOSSystemContextMenuItemCopy | IOSSystemContextMenuItemCopy | sdk | scripted |
| IOSSystemContextMenuItemCustom | IOSSystemContextMenuItemCustom | sdk | scripted |
| IOSSystemContextMenuItemCut | IOSSystemContextMenuItemCut | sdk | scripted |
| IOSSystemContextMenuItemLiveText | IOSSystemContextMenuItemLiveText | sdk | scripted |
| IOSSystemContextMenuItemLookUp | IOSSystemContextMenuItemLookUp | sdk | scripted |
| IOSSystemContextMenuItemPaste | IOSSystemContextMenuItemPaste | sdk | scripted |
| IOSSystemContextMenuItemSearchWeb | IOSSystemContextMenuItemSearchWeb | sdk | scripted |
| IOSSystemContextMenuItemSelectAll | IOSSystemContextMenuItemSelectAll | sdk | scripted |
| IOSSystemContextMenuItemShare | IOSSystemContextMenuItemShare | sdk | scripted |
| IconData | IconData | sdk | scripted |
| IconDataProperty | IconDataProperty | sdk | scripted |
| IconThemeData | IconThemeData | sdk | scripted |
| IdleScrollActivity | IdleScrollActivity | sdk | scripted |
| IgnoreBaseline | IgnoreBaseline | sdk | scripted |
| ImageIcon | ImageIcon | sdk | scripted |
| ImgElementPlatformView | ImgElementPlatformView | sdk | scripted |
| IndexedSlot | IndexedSlot | sdk | scripted |
| InheritedModelElement | InheritedModelElement | sdk | scripted |
| InspectorButton | InspectorButton | sdk | scripted |
| InspectorButtonVariant | InspectorButtonVariant | sdk | scripted |
| InspectorReferenceData | InspectorReferenceData | sdk | scripted |
| InspectorSelection | InspectorSelection | sdk | scripted |
| InspectorSerializationDelegate | InspectorSerializationDelegate | sdk | scripted |
| KeepAliveHandle | KeepAliveHandle | sdk | scripted |
| KeepAliveNotification | KeepAliveNotification | sdk | scripted |
| KeyEventResult | KeyEventResult | sdk | scripted |
| KeySet | KeySet | sdk | scripted |
| KeyboardListener | KeyboardListener | sdk | scripted |
| LabeledGlobalKey | LabeledGlobalKey | sdk | scripted |
| LayoutId | LayoutId | sdk | scripted |
| LexicalFocusOrder | LexicalFocusOrder | sdk | scripted |
| LiveTextInputStatus | LiveTextInputStatus | sdk | scripted |
| LiveTextInputStatusNotifier | LiveTextInputStatusNotifier | sdk | scripted |
| LocalHistoryEntry | LocalHistoryEntry | sdk | scripted |
| LocalizationsResolver | LocalizationsResolver | sdk | scripted |
| LockState | LockState | sdk | scripted |
| LogicalKeySet | LogicalKeySet | sdk | scripted |
| LookupBoundary | LookupBoundary | sdk | scripted |
| Matrix4Tween | Matrix4Tween | sdk | scripted |
| MatrixTransition | MatrixTransition | sdk | scripted |
| MenuController | MenuController | sdk | scripted |
| MenuSerializableShortcut | MenuSerializableShortcut | sdk | scripted |
| MetaData | MetaData | sdk | scripted |
| ModalBarrier | ModalBarrier | sdk | scripted |
| MultiSelectableSelectionContainerDelegate | MultiSelectableSelectionContainerDelegate | sdk | scripted |
| NavigationMode | NavigationMode | sdk | scripted |
| NavigationNotification | NavigationNotification | sdk | scripted |
| NavigatorPopHandler | NavigatorPopHandler | sdk | scripted |
| NestedScrollViewState | NestedScrollViewState | sdk | scripted |
| NestedScrollViewViewport | NestedScrollViewViewport | sdk | scripted |
| NextFocusAction | NextFocusAction | sdk | scripted |
| NextFocusIntent | NextFocusIntent | sdk | scripted |
| NotifiableElementMixin | NotifiableElementMixin | sdk | scripted |
| Notification | Notification | sdk | scripted |
| NumericFocusOrder | NumericFocusOrder | sdk | scripted |
| ObjectKey | ObjectKey | sdk | scripted |
| OptionsViewOpenDirection | OptionsViewOpenDirection | sdk | scripted |
| OrderedTraversalPolicy | OrderedTraversalPolicy | sdk | scripted |
| Orientation | Orientation | sdk | scripted |
| OrientationBuilder | OrientationBuilder | sdk | scripted |
| OverflowBarAlignment | OverflowBarAlignment | sdk | scripted |
| OverlayChildLayoutInfo | OverlayChildLayoutInfo | sdk | scripted |
| OverlayChildLocation | OverlayChildLocation | sdk | scripted |
| OverlayPortal | OverlayPortal | sdk | scripted |
| OverlayPortalController | OverlayPortalController | sdk | scripted |
| OverlayRoute | OverlayRoute | sdk | scripted |
| OverlayState | OverlayState | sdk | scripted |
| OverscrollIndicatorNotification | OverscrollIndicatorNotification | sdk | scripted |
| OverscrollNotification | OverscrollNotification | sdk | scripted |
| Page | Page | sdk | scripted |
| PageMetrics | PageMetrics | sdk | scripted |
| PageRouteBuilder | PageRouteBuilder | sdk | scripted |
| PanAxis | PanAxis | sdk | scripted |
| PasteTextIntent | PasteTextIntent | sdk | scripted |
| PlatformMenuDelegate | PlatformMenuDelegate | sdk | scripted |
| PlatformProvidedMenuItemType | PlatformProvidedMenuItemType | sdk | scripted |
| PlatformRouteInformationProvider | PlatformRouteInformationProvider | sdk | scripted |
| PlatformSelectableRegionContextMenu | PlatformSelectableRegionContextMenu | sdk | scripted |
| PlatformViewCreationParams | PlatformViewCreationParams | sdk | scripted |
| PopEntry | PopEntry | sdk | scripted |
| PopNavigatorRouterDelegateMixin | PopNavigatorRouterDelegateMixin | sdk | scripted |
| PopupWindow | PopupWindow | sdk | scripted |
| PopupWindowController | PopupWindowController | sdk | scripted |
| PopupWindowControllerDelegate | PopupWindowControllerDelegate | sdk | scripted |
| PredictiveBackRoute | PredictiveBackRoute | sdk | scripted |
| PreferredSize | PreferredSize | sdk | scripted |
| PreferredSizeWidget | PreferredSizeWidget | sdk | scripted |
| PreviousFocusAction | PreviousFocusAction | sdk | scripted |
| PreviousFocusIntent | PreviousFocusIntent | sdk | scripted |
| PrioritizedAction | PrioritizedAction | sdk | scripted |
| PrioritizedIntents | PrioritizedIntents | sdk | scripted |
| RadioClient | RadioClient | sdk | scripted |
| RadioGroupRegistry | RadioGroupRegistry | sdk | scripted |
| RawAutocomplete | RawAutocomplete | sdk | scripted |
| RawDialogRoute | RawDialogRoute | sdk | scripted |
| RawGestureDetector | RawGestureDetector | sdk | scripted |
| RawGestureDetectorState | RawGestureDetectorState | sdk | scripted |
| RawImage | RawImage | sdk | scripted |
| RawKeyboardListener | RawKeyboardListener | sdk | scripted |
| RawMenuAnchor | RawMenuAnchor | sdk | scripted |
| RawMenuAnchorGroup | RawMenuAnchorGroup | sdk | scripted |
| RawMenuOverlayInfo | RawMenuOverlayInfo | sdk | scripted |
| RawRadio | RawRadio | sdk | scripted |
| RawScrollbarState | RawScrollbarState | sdk | scripted |
| RawTooltip | RawTooltip | sdk | scripted |
| RawTooltipState | RawTooltipState | sdk | scripted |
| RawWebImage | RawWebImage | sdk | scripted |
| ReadingOrderTraversalPolicy | ReadingOrderTraversalPolicy | sdk | scripted |
| RedoTextIntent | RedoTextIntent | sdk | scripted |
| RegularWindow | RegularWindow | sdk | scripted |
| RegularWindowController | RegularWindowController | sdk | scripted |
| RegularWindowControllerDelegate | RegularWindowControllerDelegate | sdk | scripted |
| RegularWindowControllerLinux | RegularWindowControllerLinux | sdk | scripted |
| RegularWindowControllerMacOS | RegularWindowControllerMacOS | sdk | scripted |
| RegularWindowControllerWin32 | RegularWindowControllerWin32 | sdk | scripted |
| RelativePositionedTransition | RelativePositionedTransition | sdk | scripted |
| RelativeRectTween | RelativeRectTween | sdk | scripted |
| RenderAbstractLayoutBuilderMixin | RenderAbstractLayoutBuilderMixin | sdk | scripted |
| RenderNestedScrollViewViewport | RenderNestedScrollViewViewport | sdk | scripted |
| RenderObjectToWidgetAdapter | RenderObjectToWidgetAdapter | sdk | scripted |
| RenderObjectToWidgetElement | RenderObjectToWidgetElement | sdk | scripted |
| RenderSliverOverlapAbsorber | RenderSliverOverlapAbsorber | sdk | scripted |
| RenderSliverOverlapInjector | RenderSliverOverlapInjector | sdk | scripted |
| RenderTapRegion | RenderTapRegion | sdk | scripted |
| RenderTapRegionSurface | RenderTapRegionSurface | sdk | scripted |
| RenderTreeRootElement | RenderTreeRootElement | sdk | scripted |
| RenderTwoDimensionalViewport | RenderTwoDimensionalViewport | sdk | scripted |
| RenderWebImage | RenderWebImage | sdk | scripted |
| ReorderableDelayedDragStartListener | ReorderableDelayedDragStartListener | sdk | scripted |
| ReorderableDragStartListener | ReorderableDragStartListener | sdk | scripted |
| ReorderableList | ReorderableList | sdk | scripted |
| ReorderableListState | ReorderableListState | sdk | scripted |
| RepeatMode | RepeatMode | sdk | scripted |
| RepeatingAnimationBuilder | RepeatingAnimationBuilder | sdk | scripted |
| ReplaceTextIntent | ReplaceTextIntent | sdk | scripted |
| RequestFocusAction | RequestFocusAction | sdk | scripted |
| RequestFocusIntent | RequestFocusIntent | sdk | scripted |
| RestorableBoolN | RestorableBoolN | sdk | scripted |
| RestorableChangeNotifier | RestorableChangeNotifier | sdk | scripted |
| RestorableDateTimeN | RestorableDateTimeN | sdk | scripted |
| RestorableDoubleN | RestorableDoubleN | sdk | scripted |
| RestorableEnumN | RestorableEnumN | sdk | scripted |
| RestorableIntN | RestorableIntN | sdk | scripted |
| RestorableListenable | RestorableListenable | sdk | scripted |
| RestorableNum | RestorableNum | sdk | scripted |
| RestorableNumN | RestorableNumN | sdk | scripted |
| RestorableRouteFuture | RestorableRouteFuture | sdk | scripted |
| RestorableStringN | RestorableStringN | sdk | scripted |
| RootBackButtonDispatcher | RootBackButtonDispatcher | sdk | scripted |
| RootElementMixin | RootElementMixin | sdk | scripted |
| RootRenderObjectElement | RootRenderObjectElement | sdk | scripted |
| RouteAware | RouteAware | sdk | scripted |
| RouteInformation | RouteInformation | sdk | scripted |
| RouteInformationReportingType | RouteInformationReportingType | sdk | scripted |
| RouteObserver | RouteObserver | sdk | scripted |
| RoutePopDisposition | RoutePopDisposition | sdk | scripted |
| RouteTransitionRecord | RouteTransitionRecord | sdk | scripted |
| RouterConfig | RouterConfig | sdk | scripted |
| ScrollActivity | ScrollActivity | sdk | scripted |
| ScrollActivityDelegate | ScrollActivityDelegate | sdk | scripted |
| ScrollAwareImageProvider | ScrollAwareImageProvider | sdk | scripted |
| ScrollContext | ScrollContext | sdk | scripted |
| ScrollDecelerationRate | ScrollDecelerationRate | sdk | scripted |
| ScrollDragController | ScrollDragController | sdk | scripted |
| ScrollEndNotification | ScrollEndNotification | sdk | scripted |
| ScrollHoldController | ScrollHoldController | sdk | scripted |
| ScrollIncrementDetails | ScrollIncrementDetails | sdk | scripted |
| ScrollIncrementType | ScrollIncrementType | sdk | scripted |
| ScrollMetricsNotification | ScrollMetricsNotification | sdk | scripted |
| ScrollNotificationObserver | ScrollNotificationObserver | sdk | scripted |
| ScrollNotificationObserverState | ScrollNotificationObserverState | sdk | scripted |
| ScrollPositionAlignmentPolicy | ScrollPositionAlignmentPolicy | sdk | scripted |
| ScrollPositionWithSingleContext | ScrollPositionWithSingleContext | sdk | scripted |
| ScrollStartNotification | ScrollStartNotification | sdk | scripted |
| ScrollToDocumentBoundaryIntent | ScrollToDocumentBoundaryIntent | sdk | scripted |
| ScrollUpdateNotification | ScrollUpdateNotification | sdk | scripted |
| ScrollView | ScrollView | sdk | scripted |
| ScrollViewKeyboardDismissBehavior | ScrollViewKeyboardDismissBehavior | sdk | scripted |
| ScrollableDetails | ScrollableDetails | sdk | scripted |
| ScrollbarOrientation | ScrollbarOrientation | sdk | scripted |
| ScrollbarPainter | ScrollbarPainter | sdk | scripted |
| SelectAction | SelectAction | sdk | scripted |
| SelectAllTextIntent | SelectAllTextIntent | sdk | scripted |
| SelectIntent | SelectIntent | sdk | scripted |
| SelectableRegionSelectionStatus | SelectableRegionSelectionStatus | sdk | scripted |
| SelectableRegionSelectionStatusScope | SelectableRegionSelectionStatusScope | sdk | scripted |
| SelectableRegionState | SelectableRegionState | sdk | scripted |
| SelectionContainerDelegate | SelectionContainerDelegate | sdk | scripted |
| SelectionDetails | SelectionDetails | sdk | scripted |
| SelectionListenerNotifier | SelectionListenerNotifier | sdk | scripted |
| SelectionRegistrarScope | SelectionRegistrarScope | sdk | scripted |
| SemanticsDebugger | SemanticsDebugger | sdk | scripted |
| SemanticsGestureDelegate | SemanticsGestureDelegate | sdk | scripted |
| SensitiveContent | SensitiveContent | sdk | scripted |
| SensitiveContentHost | SensitiveContentHost | sdk | scripted |
| ShortcutActivator | ShortcutActivator | sdk | scripted |
| ShortcutManager | ShortcutManager | sdk | scripted |
| ShortcutMapProperty | ShortcutMapProperty | sdk | scripted |
| ShortcutRegistrar | ShortcutRegistrar | sdk | scripted |
| ShortcutRegistry | ShortcutRegistry | sdk | scripted |
| ShortcutRegistryEntry | ShortcutRegistryEntry | sdk | scripted |
| ShortcutSerialization | ShortcutSerialization | sdk | scripted |
| SingleActivator | SingleActivator | sdk | scripted |
| SizeChangedLayoutNotification | SizeChangedLayoutNotification | sdk | scripted |
| SizeChangedLayoutNotifier | SizeChangedLayoutNotifier | sdk | scripted |
| SizedOverflowBox | SizedOverflowBox | sdk | scripted |
| SliverAnimatedGridState | SliverAnimatedGridState | sdk | scripted |
| SliverAnimatedListState | SliverAnimatedListState | sdk | scripted |
| SliverChildBuilderDelegate | SliverChildBuilderDelegate | sdk | scripted |
| SliverChildDelegate | SliverChildDelegate | sdk | scripted |
| SliverChildListDelegate | SliverChildListDelegate | sdk | scripted |
| SliverEnsureSemantics | SliverEnsureSemantics | sdk | scripted |
| SliverFadeTransition | SliverFadeTransition | sdk | scripted |
| SliverMultiBoxAdaptorElement | SliverMultiBoxAdaptorElement | sdk | scripted |
| SliverMultiBoxAdaptorWidget | SliverMultiBoxAdaptorWidget | sdk | scripted |
| SliverOverlapAbsorber | SliverOverlapAbsorber | sdk | scripted |
| SliverOverlapAbsorberHandle | SliverOverlapAbsorberHandle | sdk | scripted |
| SliverOverlapInjector | SliverOverlapInjector | sdk | scripted |
| SliverPersistentHeaderDelegate | SliverPersistentHeaderDelegate | sdk | scripted |
| SliverReorderableListState | SliverReorderableListState | sdk | scripted |
| SliverWithKeepAliveWidget | SliverWithKeepAliveWidget | sdk | scripted |
| SlottedContainerRenderObjectMixin | SlottedContainerRenderObjectMixin | sdk | scripted |
| SlottedMultiChildRenderObjectWidget | SlottedMultiChildRenderObjectWidget | sdk | scripted |
| SlottedMultiChildRenderObjectWidgetMixin | SlottedMultiChildRenderObjectWidgetMixin | sdk | scripted |
| SlottedRenderObjectElement | SlottedRenderObjectElement | sdk | scripted |
| SnapshotController | SnapshotController | sdk | scripted |
| SnapshotMode | SnapshotMode | sdk | scripted |
| SnapshotPainter | SnapshotPainter | sdk | scripted |
| SnapshotWidget | SnapshotWidget | sdk | scripted |
| StandardComponentType | StandardComponentType | sdk | scripted |
| StaticSelectionContainerDelegate | StaticSelectionContainerDelegate | sdk | scripted |
| StatusTransitionWidget | StatusTransitionWidget | sdk | scripted |
| StreamBuilderBase | StreamBuilderBase | sdk | scripted |
| StretchEffect | StretchEffect | sdk | scripted |
| SystemContextMenu | SystemContextMenu | sdk | scripted |
| SystemTextScaler | SystemTextScaler | sdk | scripted |
| TapRegionRegistry | TapRegionRegistry | sdk | scripted |
| TextSelectionGestureDetectorBuilder | TextSelectionGestureDetectorBuilder | sdk | scripted |
| TextSelectionGestureDetectorBuilderDelegate | TextSelectionGestureDetectorBuilderDelegate | sdk | scripted |
| TextSelectionHandleControls | TextSelectionHandleControls | sdk | scripted |
| TextSelectionToolbarLayoutDelegate | TextSelectionToolbarLayoutDelegate | sdk | scripted |
| TextStyleTween | TextStyleTween | sdk | scripted |
| Texture | Texture | sdk | scripted |
| TickerModeData | TickerModeData | sdk | scripted |
| ToggleablePainter | ToggleablePainter | sdk | scripted |
| ToggleableStateMixin | ToggleableStateMixin | sdk | scripted |
| ToolbarItemsParentData | ToolbarItemsParentData | sdk | scripted |
| ToolbarOptions | ToolbarOptions | sdk | scripted |
| TooltipPositionContext | TooltipPositionContext | sdk | scripted |
| TooltipWindow | TooltipWindow | sdk | scripted |
| TooltipWindowController | TooltipWindowController | sdk | scripted |
| TooltipWindowControllerDelegate | TooltipWindowControllerDelegate | sdk | scripted |
| TrackingScrollController | TrackingScrollController | sdk | scripted |
| TransformationController | TransformationController | sdk | scripted |
| TransitionDelegate | TransitionDelegate | sdk | scripted |
| TransitionRoute | TransitionRoute | sdk | scripted |
| TransposeCharactersIntent | TransposeCharactersIntent | sdk | scripted |
| TraversalDirection | TraversalDirection | sdk | scripted |
| TraversalEdgeBehavior | TraversalEdgeBehavior | sdk | scripted |
| TreeSliver | TreeSliver | sdk | scripted |
| TreeSliverController | TreeSliverController | sdk | scripted |
| TreeSliverNode | TreeSliverNode | sdk | scripted |
| TreeSliverStateMixin | TreeSliverStateMixin | sdk | scripted |
| TwoDimensionalChildBuilderDelegate | TwoDimensionalChildBuilderDelegate | sdk | scripted |
| TwoDimensionalChildDelegate | TwoDimensionalChildDelegate | sdk | scripted |
| TwoDimensionalChildListDelegate | TwoDimensionalChildListDelegate | sdk | scripted |
| TwoDimensionalChildManager | TwoDimensionalChildManager | sdk | scripted |
| TwoDimensionalScrollView | TwoDimensionalScrollView | sdk | scripted |
| TwoDimensionalScrollable | TwoDimensionalScrollable | sdk | scripted |
| TwoDimensionalScrollableState | TwoDimensionalScrollableState | sdk | scripted |
| TwoDimensionalViewport | TwoDimensionalViewport | sdk | scripted |
| TwoDimensionalViewportParentData | TwoDimensionalViewportParentData | sdk | scripted |
| UndoHistoryState | UndoHistoryState | sdk | scripted |
| UndoHistoryValue | UndoHistoryValue | sdk | scripted |
| UndoTextIntent | UndoTextIntent | sdk | scripted |
| UnfocusDisposition | UnfocusDisposition | sdk | scripted |
| UniqueWidget | UniqueWidget | sdk | scripted |
| UnmanagedRestorationScope | UnmanagedRestorationScope | sdk | scripted |
| UpdateSelectionIntent | UpdateSelectionIntent | sdk | scripted |
| UserScrollNotification | UserScrollNotification | sdk | scripted |
| ViewportElementMixin | ViewportElementMixin | sdk | scripted |
| ViewportNotificationMixin | ViewportNotificationMixin | sdk | scripted |
| VoidCallbackAction | VoidCallbackAction | sdk | scripted |
| VoidCallbackIntent | VoidCallbackIntent | sdk | scripted |
| WeakMap | WeakMap | sdk | scripted |
| WebBrowserDetection | WebBrowserDetection | sdk | scripted |
| WidgetInspectorService | WidgetInspectorService | sdk | scripted |
| WidgetInspectorServiceExtensions | WidgetInspectorServiceExtensions | sdk | scripted |
| WidgetOrderTraversalPolicy | WidgetOrderTraversalPolicy | sdk | scripted |
| WidgetState | WidgetState | sdk | scripted |
| WidgetStateBorderSide | WidgetStateBorderSide | sdk | scripted |
| WidgetStateColor | WidgetStateColor | sdk | scripted |
| WidgetStateMapper | WidgetStateMapper | sdk | scripted |
| WidgetStateMouseCursor | WidgetStateMouseCursor | sdk | scripted |
| WidgetStateOutlinedBorder | WidgetStateOutlinedBorder | sdk | scripted |
| WidgetStatePropertyAll | WidgetStatePropertyAll | sdk | scripted |
| WidgetStateTextStyle | WidgetStateTextStyle | sdk | scripted |
| WidgetStatesConstraint | WidgetStatesConstraint | sdk | scripted |
| WidgetToRenderBoxAdapter | WidgetToRenderBoxAdapter | sdk | scripted |
| WidgetsLocalizations | WidgetsLocalizations | sdk | scripted |
| WidgetsServiceExtensions | WidgetsServiceExtensions | sdk | scripted |
| WindowPositioner | WindowPositioner | sdk | scripted |
| WindowPositionerAnchor | WindowPositionerAnchor | sdk | scripted |
| WindowPositionerConstraintAdjustment | WindowPositionerConstraintAdjustment | sdk | scripted |
| WindowScope | WindowScope | sdk | scripted |
| WindowingOwner | WindowingOwner | sdk | scripted |
| WindowingOwnerLinux | WindowingOwnerLinux | sdk | scripted |
| WindowingOwnerMacOS | WindowingOwnerMacOS | sdk | scripted |
| WindowingOwnerWin32 | WindowingOwnerWin32 | sdk | scripted |

---

## material (167 classes)
*Sources: 1 classified, 165 from SDK, 1 testpriority-only*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| ActionChipTheme | Action theme | tp-only | tp-only |
| Adaptation | Adaptation | sdk | scripted |
| AnimatedIconData | AnimatedIconData | sdk | scripted |
| AnimatedTheme | Theme | classified | scripted |
| Autocomplete | Autocomplete | sdk | scripted |
| BackButton | BackButton | sdk | scripted |
| BackButtonIcon | BackButtonIcon | sdk | scripted |
| BottomNavigationBarLandscapeLayout | BottomNavigationBarLandscapeLayout | sdk | scripted |
| BottomNavigationBarTheme | BottomNavigationBarTheme | sdk | scripted |
| BottomNavigationBarThemeData | BottomNavigationBarThemeData | sdk | scripted |
| BottomNavigationBarType | BottomNavigationBarType | sdk | scripted |
| ButtonBar | ButtonBar | sdk | scripted |
| ButtonBarLayoutBehavior | ButtonBarLayoutBehavior | sdk | scripted |
| ButtonBarTheme | ButtonBarTheme | sdk | scripted |
| ButtonBarThemeData | ButtonBarThemeData | sdk | scripted |
| ButtonTextTheme | ButtonTextTheme | sdk | scripted |
| CarouselController | CarouselController | sdk | scripted |
| CarouselScrollPhysics | CarouselScrollPhysics | sdk | scripted |
| CarouselView | CarouselView | sdk | scripted |
| CarouselViewTheme | CarouselViewTheme | sdk | scripted |
| CarouselViewThemeData | CarouselViewThemeData | sdk | scripted |
| CheckedPopupMenuItem | CheckedPopupMenuItem | sdk | scripted |
| CloseButton | CloseButton | sdk | scripted |
| CloseButtonIcon | CloseButtonIcon | sdk | scripted |
| CollapseMode | CollapseMode | sdk | scripted |
| CupertinoBasedMaterialThemeData | CupertinoBasedMaterialThemeData | sdk | scripted |
| DatePickerEntryMode | DatePickerEntryMode | sdk | scripted |
| DatePickerMode | DatePickerMode | sdk | scripted |
| DayPeriod | DayPeriod | sdk | scripted |
| DialogRoute | DialogRoute | sdk | scripted |
| DrawerAlignment | DrawerAlignment | sdk | scripted |
| DrawerButton | DrawerButton | sdk | scripted |
| DrawerButtonIcon | DrawerButtonIcon | sdk | scripted |
| DrawerController | DrawerController | sdk | scripted |
| DrawerControllerState | DrawerControllerState | sdk | scripted |
| DropRangeSliderValueIndicatorShape | DropRangeSliderValueIndicatorShape | sdk | scripted |
| DropSliderValueIndicatorShape | DropSliderValueIndicatorShape | sdk | scripted |
| DropdownButtonHideUnderline | DropdownButtonHideUnderline | sdk | scripted |
| DropdownMenuCloseBehavior | DropdownMenuCloseBehavior | sdk | scripted |
| DropdownMenuEntry | DropdownMenuEntry | sdk | scripted |
| DropdownMenuFormField | DropdownMenuFormField | sdk | scripted |
| DropdownMenuItem | DropdownMenuItem | sdk | scripted |
| Durations | Durations | sdk | scripted |
| DynamicSchemeVariant | DynamicSchemeVariant | sdk | scripted |
| Easing | Easing | sdk | scripted |
| ElevationOverlay | ElevationOverlay | sdk | scripted |
| EndDrawerButton | EndDrawerButton | sdk | scripted |
| EndDrawerButtonIcon | EndDrawerButtonIcon | sdk | scripted |
| ExpandIcon | ExpandIcon | sdk | scripted |
| ExpansionPanelRadio | ExpansionPanelRadio | sdk | scripted |
| FabCenterOffsetX | FabCenterOffsetX | sdk | scripted |
| FabContainedOffsetY | FabContainedOffsetY | sdk | scripted |
| FabDockedOffsetY | FabDockedOffsetY | sdk | scripted |
| FabEndOffsetX | FabEndOffsetX | sdk | scripted |
| FabFloatOffsetY | FabFloatOffsetY | sdk | scripted |
| FabMiniOffsetAdjustment | FabMiniOffsetAdjustment | sdk | scripted |
| FabStartOffsetX | FabStartOffsetX | sdk | scripted |
| FabTopOffsetY | FabTopOffsetY | sdk | scripted |
| FadeForwardsPageTransitionsBuilder | FadeForwardsPageTransitionsBuilder | sdk | scripted |
| FlexibleSpaceBarSettings | FlexibleSpaceBarSettings | sdk | scripted |
| FloatingLabelAlignment | FloatingLabelAlignment | sdk | scripted |
| FloatingLabelBehavior | FloatingLabelBehavior | sdk | scripted |
| GappedRangeSliderTrackShape | GappedRangeSliderTrackShape | sdk | scripted |
| GappedSliderTrackShape | GappedSliderTrackShape | sdk | scripted |
| GregorianCalendarDelegate | GregorianCalendarDelegate | sdk | scripted |
| GridTile | GridTile | sdk | scripted |
| GridTileBar | GridTileBar | sdk | scripted |
| HandleRangeSliderThumbShape | HandleRangeSliderThumbShape | sdk | scripted |
| HandleThumbShape | HandleThumbShape | sdk | scripted |
| HourFormat | HourFormat | sdk | scripted |
| IconAlignment | IconAlignment | sdk | scripted |
| Icons | Icons | sdk | scripted |
| InkDecoration | InkDecoration | sdk | scripted |
| InkSparkle | InkSparkle | sdk | scripted |
| InputDatePickerFormField | InputDatePickerFormField | sdk | scripted |
| InputDecorationThemeData | InputDecorationThemeData | sdk | scripted |
| InputDecorator | InputDecorator | sdk | scripted |
| InteractiveInkFeatureFactory | InteractiveInkFeatureFactory | sdk | scripted |
| ListTileControlAffinity | ListTileControlAffinity | sdk | scripted |
| ListTileStyle | ListTileStyle | sdk | scripted |
| ListTileTitleAlignment | ListTileTitleAlignment | sdk | scripted |
| Magnifier | Magnifier | sdk | scripted |
| MaterialBannerClosedReason | MaterialBannerClosedReason | sdk | scripted |
| MaterialPointArcTween | MaterialPointArcTween | sdk | scripted |
| MaterialRectArcTween | MaterialRectArcTween | sdk | scripted |
| MaterialRectCenterArcTween | MaterialRectCenterArcTween | sdk | scripted |
| MaterialScrollBehavior | MaterialScrollBehavior | sdk | scripted |
| MaterialStateMixin | MaterialStateMixin | sdk | scripted |
| MaterialStateOutlineInputBorder | MaterialStateOutlineInputBorder | sdk | scripted |
| MaterialStateUnderlineInputBorder | MaterialStateUnderlineInputBorder | sdk | scripted |
| MaterialTapTargetSize | MaterialTapTargetSize | sdk | scripted |
| MaterialTextSelectionHandleControls | MaterialTextSelectionHandleControls | sdk | scripted |
| MenuAcceleratorCallbackBinding | MenuAcceleratorCallbackBinding | sdk | scripted |
| MenuAcceleratorLabel | MenuAcceleratorLabel | sdk | scripted |
| MenuButtonTheme | MenuButtonTheme | sdk | scripted |
| MenuButtonThemeData | MenuButtonThemeData | sdk | scripted |
| MergeableMaterialItem | MergeableMaterialItem | sdk | scripted |
| ModalBottomSheetRoute | ModalBottomSheetRoute | sdk | scripted |
| NavigationDestinationLabelBehavior | NavigationDestinationLabelBehavior | sdk | scripted |
| NavigationDrawerTheme | NavigationDrawerTheme | sdk | scripted |
| NavigationIndicator | NavigationIndicator | sdk | scripted |
| NavigationRailLabelType | NavigationRailLabelType | sdk | scripted |
| NoSplash | NoSplash | sdk | scripted |
| PaddleRangeSliderValueIndicatorShape | PaddleRangeSliderValueIndicatorShape | sdk | scripted |
| PaddleSliderValueIndicatorShape | PaddleSliderValueIndicatorShape | sdk | scripted |
| PaginatedDataTableState | PaginatedDataTableState | sdk | scripted |
| PersistentBottomSheetController | PersistentBottomSheetController | sdk | scripted |
| PlatformAdaptiveIcons | PlatformAdaptiveIcons | sdk | scripted |
| PopupMenuButtonState | PopupMenuButtonState | sdk | scripted |
| PopupMenuDivider | PopupMenuDivider | sdk | scripted |
| PopupMenuEntry | PopupMenuEntry | sdk | scripted |
| PopupMenuItem | PopupMenuItem | sdk | scripted |
| PopupMenuItemState | PopupMenuItemState | sdk | scripted |
| PopupMenuPosition | PopupMenuPosition | sdk | scripted |
| PredictiveBackFullscreenPageTransitionsBuilder | PredictiveBackFullscreenPageTransitionsBuilder | sdk | scripted |
| ProgressIndicator | ProgressIndicator | sdk | scripted |
| RawChip | RawChip | sdk | scripted |
| RectangularRangeSliderTrackShape | RectangularRangeSliderTrackShape | sdk | scripted |
| RectangularRangeSliderValueIndicatorShape | RectangularRangeSliderValueIndicatorShape | sdk | scripted |
| RectangularSliderValueIndicatorShape | RectangularSliderValueIndicatorShape | sdk | scripted |
| RefreshIndicatorState | RefreshIndicatorState | sdk | scripted |
| RefreshIndicatorStatus | RefreshIndicatorStatus | sdk | scripted |
| RefreshIndicatorTriggerMode | RefreshIndicatorTriggerMode | sdk | scripted |
| RefreshProgressIndicator | RefreshProgressIndicator | sdk | scripted |
| RestorableTimeOfDay | RestorableTimeOfDay | sdk | scripted |
| RoundRangeSliderThumbShape | RoundRangeSliderThumbShape | sdk | scripted |
| RoundRangeSliderTickMarkShape | RoundRangeSliderTickMarkShape | sdk | scripted |
| RoundedRectRangeSliderTrackShape | RoundedRectRangeSliderTrackShape | sdk | scripted |
| RoundedRectRangeSliderValueIndicatorShape | RoundedRectRangeSliderValueIndicatorShape | sdk | scripted |
| RoundedRectSliderValueIndicatorShape | RoundedRectSliderValueIndicatorShape | sdk | scripted |
| ScaffoldGeometry | ScaffoldGeometry | sdk | scripted |
| ScaffoldPrelayoutGeometry | ScaffoldPrelayoutGeometry | sdk | scripted |
| ScriptCategory | ScriptCategory | sdk | scripted |
| ScrollbarThemeData | ScrollbarThemeData | sdk | scripted |
| SearchController | SearchController | sdk | scripted |
| SearchDelegate | SearchDelegate | sdk | scripted |
| SegmentedButtonState | SegmentedButtonState | sdk | scripted |
| SelectionArea | SelectionArea | sdk | scripted |
| SelectionAreaState | SelectionAreaState | sdk | scripted |
| ShapeBorderTween | ShapeBorderTween | sdk | scripted |
| ShowValueIndicator | ShowValueIndicator | sdk | scripted |
| SimpleDialogOption | SimpleDialogOption | sdk | scripted |
| SliderInteraction | SliderInteraction | sdk | scripted |
| SnackBarThemeData | SnackBarThemeData | sdk | scripted |
| SpellCheckSuggestionsToolbarLayoutDelegate | SpellCheckSuggestionsToolbarLayoutDelegate | sdk | scripted |
| StandardFabLocation | StandardFabLocation | sdk | scripted |
| StepStyle | StepStyle | sdk | scripted |
| StretchMode | StretchMode | sdk | scripted |
| TabAlignment | TabAlignment | sdk | scripted |
| TabIndicatorAnimation | TabIndicatorAnimation | sdk | scripted |
| TabPageSelector | TabPageSelector | sdk | scripted |
| TabPageSelectorIndicator | TabPageSelectorIndicator | sdk | scripted |
| TableRowInkWell | TableRowInkWell | sdk | scripted |
| TappableChipAttributes | TappableChipAttributes | sdk | scripted |
| TextMagnifier | TextMagnifier | sdk | scripted |
| ThemeDataTween | ThemeDataTween | sdk | scripted |
| ThemeExtension | ThemeExtension | sdk | scripted |
| ThemeMode | ThemeMode | sdk | scripted |
| Thumb | Thumb | sdk | scripted |
| TimeOfDayFormat | TimeOfDayFormat | sdk | scripted |
| TimePickerEntryMode | TimePickerEntryMode | sdk | scripted |
| ToggleButtonsTheme | ToggleButtonsTheme | sdk | scripted |
| ToggleButtonsThemeData | ToggleButtonsThemeData | sdk | scripted |
| TooltipState | TooltipState | sdk | scripted |
| UnderlineTabIndicator | UnderlineTabIndicator | sdk | scripted |
| VerticalDivider | VerticalDivider | sdk | scripted |
| WidgetStateInputBorder | WidgetStateInputBorder | sdk | scripted |

---

## cupertino (67 classes)
*Sources: 14 from SDK, 53 testpriority-only*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| CupertinoButtonSize | CupertinoButtonSize | sdk | scripted |
| CupertinoDesktopTextSelectionControls | CupertinoDesktopTextSelectionControls | sdk | scripted |
| CupertinoExpansionTile | CupertinoExpansionTile | sdk | scripted |
| CupertinoFocusHalo | CupertinoFocusHalo | sdk | scripted |
| CupertinoLinearActivityIndicator | CupertinoLinearActivityIndicator | sdk | scripted |
| CupertinoListSectionType | CupertinoListSectionType | sdk | scripted |
| CupertinoListTileChevron | CupertinoListTileChevron | sdk | scripted |
| CupertinoRenderActivityIndicator | Render indicator | tp-only | tp-only |
| CupertinoRenderCheckbox | Render checkbox | tp-only | tp-only |
| CupertinoRenderContextMenu | Render menu | tp-only | tp-only |
| CupertinoRenderDatePicker | Render picker | tp-only | tp-only |
| CupertinoRenderListTile | Render tile | tp-only | tp-only |
| CupertinoRenderNavigationBar | Render nav | tp-only | tp-only |
| CupertinoRenderPicker | Render picker | tp-only | tp-only |
| CupertinoRenderRadio | Render radio | tp-only | tp-only |
| CupertinoRenderScrollbar | Render scroll | tp-only | tp-only |
| CupertinoRenderSearchTextField | Render search | tp-only | tp-only |
| CupertinoRenderSegmentedControl | Render segment | tp-only | tp-only |
| CupertinoRenderSlider | Render slider | tp-only | tp-only |
| CupertinoRenderSlidingSegmentedControl | Render sliding | tp-only | tp-only |
| CupertinoRenderSwitch | Render switch | tp-only | tp-only |
| CupertinoRenderTabBar | Render tab | tp-only | tp-only |
| CupertinoRenderTextField | Render field | tp-only | tp-only |
| CupertinoRenderTimerPicker | Render timer | tp-only | tp-only |
| CupertinoTextSelectionHandleControls | CupertinoTextSelectionHandleControls | sdk | scripted |
| CupertinoThumbPainter | CupertinoThumbPainter | sdk | scripted |
| ExpansionTileTransitionMode | ExpansionTileTransitionMode | sdk | scripted |
| InheritedCupertinoTheme | InheritedCupertinoTheme | sdk | scripted |
| NavigationBarBottomMode | NavigationBarBottomMode | sdk | scripted |
| OverlayVisibilityMode | OverlayVisibilityMode | sdk | scripted |
| RestorableCupertinoTabController | RestorableCupertinoTabController | sdk | scripted |
| _ActionSheetActionState | Private state | tp-only | tp-only |
| _ActionSheetState | Private state | tp-only | tp-only |
| _ActivityIndicatorState | Private state | tp-only | tp-only |
| _AlertDialogRouteLayout | Private layout | tp-only | tp-only |
| _AlertDialogState | Private state | tp-only | tp-only |
| _ButtonState | Private state | tp-only | tp-only |
| _CheckboxState | Private state | tp-only | tp-only |
| _ContextMenuActionState | Private state | tp-only | tp-only |
| _ContextMenuState | Private state | tp-only | tp-only |
| _DatePickerState | Private state | tp-only | tp-only |
| _DialogActionState | Private state | tp-only | tp-only |
| _FormRowState | Private state | tp-only | tp-only |
| _FormSectionState | Private state | tp-only | tp-only |
| _ListSectionState | Private state | tp-only | tp-only |
| _ListTileState | Private state | tp-only | tp-only |
| _ModalBottomSheetState | Private state | tp-only | tp-only |
| _NavigationBarState | Private state | tp-only | tp-only |
| _PageScaffoldState | Private state | tp-only | tp-only |
| _PickerState | Private state | tp-only | tp-only |
| _PopupSurfaceState | Private state | tp-only | tp-only |
| _RadioState | Private state | tp-only | tp-only |
| _RefreshControlState | Private state | tp-only | tp-only |
| _RoutedSheetState | Private state | tp-only | tp-only |
| _ScrollbarState | Private state | tp-only | tp-only |
| _SearchTextFieldState | Private state | tp-only | tp-only |
| _SegmentedControlState | Private state | tp-only | tp-only |
| _SheetRouteState | Private state | tp-only | tp-only |
| _SliderState | Private state | tp-only | tp-only |
| _SlidingSegmentedControlState | Private state | tp-only | tp-only |
| _SwitchState | Private state | tp-only | tp-only |
| _TabBarState | Private state | tp-only | tp-only |
| _TabScaffoldState | Private state | tp-only | tp-only |
| _TabViewState | Private state | tp-only | tp-only |
| _TextFieldState | Private state | tp-only | tp-only |
| _TextFormFieldRowState | Private state | tp-only | tp-only |
| _TimerPickerState | Private state | tp-only | tp-only |

---

## foundation (37 classes)
*Sources: 9 classified, 27 from SDK, 1 testpriority-only*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AbstractNode | AbstractNode | sdk | scripted |
| CachingIterable | CachingIterable | sdk | scripted |
| Category | Internal category | classified | scripted |
| DiagnosticLevel | DiagnosticLevel | sdk | scripted |
| Diagnosticable | Diagnosticable | sdk | scripted |
| DiagnosticableNode | DiagnosticableNode | sdk | scripted |
| DiagnosticableTree | DiagnosticableTree | sdk | scripted |
| DiagnosticableTreeMixin | DiagnosticableTreeMixin | sdk | scripted |
| DiagnosticableTreeNode | DiagnosticableTreeNode | sdk | scripted |
| DiagnosticsBlock | DiagnosticsBlock | sdk | scripted |
| DiagnosticsProperty | DiagnosticsProperty | sdk | scripted |
| DiagnosticsSerializationDelegate | DiagnosticsSerializationDelegate | sdk | scripted |
| DiagnosticsStackTrace | Stack diagnostics | classified | scripted |
| DiagnosticsTreeStyle | DiagnosticsTreeStyle | sdk | scripted |
| DocumentationIcon | Doc icon annotation | classified | scripted |
| DoubleProperty | DoubleProperty | sdk | scripted |
| EnumProperty | EnumProperty | sdk | scripted |
| ErrorSpacer | Error formatting | classified | scripted |
| Factory | Factory | sdk | scripted |
| FlagProperty | FlagProperty | sdk | scripted |
| FlagsSummary | FlagsSummary | sdk | scripted |
| FlutterMemoryAllocations | Memory tracking | classified | scripted |
| FoundationServiceExtensions | FoundationServiceExtensions | sdk | scripted |
| Immutable | Immutability annotation | tp-only | tp-only |
| IntProperty | IntProperty | sdk | scripted |
| IterableProperty | IterableProperty | sdk | scripted |
| MessageProperty | MessageProperty | sdk | scripted |
| ObjectCreated | Object lifecycle | classified | scripted |
| ObjectDisposed | Object lifecycle | classified | scripted |
| ObjectEvent | Object events | classified | scripted |
| ObjectFlagProperty | ObjectFlagProperty | sdk | scripted |
| PercentProperty | PercentProperty | sdk | scripted |
| StringProperty | StringProperty | sdk | scripted |
| Summary | Summary annotation | classified | scripted |
| TargetPlatform | TargetPlatform | sdk | scripted |
| TextTreeConfiguration | TextTreeConfiguration | sdk | scripted |
| TextTreeRenderer | TextTreeRenderer | sdk | scripted |

---

## painting (31 classes)
*Sources: 17 classified, 14 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| Accumulator | Internal accumulation | classified | scripted |
| AssetBundleImageKey | Asset cache key | classified | scripted |
| AssetBundleImageProvider | Asset image base | classified | scripted |
| Axis | Axis | sdk | scripted |
| AxisDirection | AxisDirection | sdk | scripted |
| BorderStyle | BorderStyle | sdk | scripted |
| BoxFit | BoxFit | sdk | scripted |
| BoxShape | BoxShape | sdk | scripted |
| ClipContext | Clipping context | classified | scripted |
| ColorProperty | Diagnostics property | classified | scripted |
| FittedSizes | Fitted size calculation | classified | scripted |
| FlutterLogoStyle | FlutterLogoStyle | sdk | scripted |
| ImageRepeat | ImageRepeat | sdk | scripted |
| ImageSizeInfo | Image size debugging | classified | scripted |
| ImageStreamCompleterHandle | Stream handle | classified | scripted |
| InlineSpan | Inline text span | classified | scripted |
| InlineSpanSemanticsInformation | Span semantics | classified | scripted |
| MatrixUtils | Matrix utilities | classified | scripted |
| MultiFrameImageStreamCompleter | Multi-frame images | classified | scripted |
| NetworkImageLoadException | Network error | classified | scripted |
| OneFrameImageStreamCompleter | Single-frame images | classified | scripted |
| PaintingBinding | Painting binding | classified | scripted |
| RenderComparison | RenderComparison | sdk | scripted |
| ResizeImagePolicy | ResizeImagePolicy | sdk | scripted |
| ShaderWarmUp | Shader precompilation | classified | scripted |
| TextOverflow | TextOverflow | sdk | scripted |
| TextWidthBasis | TextWidthBasis | sdk | scripted |
| TransformProperty | Transform diagnostics | classified | scripted |
| VerticalDirection | VerticalDirection | sdk | scripted |
| WebHtmlElementStrategy | WebHtmlElementStrategy | sdk | scripted |
| WebImageInfo | WebImageInfo | sdk | scripted |

---

## rendering (95 classes)
*Sources: 64 classified, 31 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AlignmentGeometryTween | Alignment tween | classified | scripted |
| AlignmentTween | Alignment tween | classified | scripted |
| AnnotatedRegionLayer | Annotated layer | classified | scripted |
| AnnotationEntry | Annotation entry | classified | scripted |
| AnnotationResult | Annotation result | classified | scripted |
| BackdropKey | Backdrop key | classified | scripted |
| CacheExtentStyle | CacheExtentStyle | sdk | scripted |
| ChildLayoutHelper | Layout helper | classified | scripted |
| ClearSelectionEvent | Clear selection | classified | scripted |
| ContainerParentDataMixin | ContainerParentDataMixin | sdk | scripted |
| CrossAxisAlignment | CrossAxisAlignment | sdk | scripted |
| DecorationPosition | DecorationPosition | sdk | scripted |
| DiagnosticsDebugCreator | Debug creator | classified | scripted |
| DirectionallyExtendSelectionEvent | Directional extend | classified | scripted |
| FlexFit | FlexFit | sdk | scripted |
| FloatingHeaderSnapConfiguration | Header snap config | classified | scripted |
| FlowPaintingContext | Flow context | classified | scripted |
| FlowParentData | Flow parent data | classified | scripted |
| FractionColumnWidth | Fraction column | classified | scripted |
| FractionalOffsetTween | Offset tween | classified | scripted |
| GranularlyExtendSelectionEvent | Granular extend | classified | scripted |
| GrowthDirection | GrowthDirection | sdk | scripted |
| HitTestBehavior | HitTestBehavior | sdk | scripted |
| ImageFilterConfig | Filter config | classified | scripted |
| ImageFilterContext | Filter context | classified | scripted |
| ListWheelChildManager | Wheel manager | classified | scripted |
| MainAxisAlignment | MainAxisAlignment | sdk | scripted |
| MainAxisSize | MainAxisSize | sdk | scripted |
| MaxColumnWidth | Max column | classified | scripted |
| MinColumnWidth | Min column | classified | scripted |
| MultiChildLayoutParentData | MultiChildLayoutParentData | sdk | scripted |
| OverScrollHeaderStretchConfiguration | Stretch config | classified | scripted |
| OverflowBoxFit | OverflowBoxFit | sdk | scripted |
| PerformanceOverlayOption | PerformanceOverlayOption | sdk | scripted |
| PersistentHeaderShowOnScreenConfiguration | Show on screen | classified | scripted |
| PipelineManifold | Pipeline manifold | classified | scripted |
| PlaceholderSpanIndexSemanticsTag | Placeholder tag | classified | scripted |
| PlatformViewHitTestBehavior | PlatformViewHitTestBehavior | sdk | scripted |
| PlatformViewRenderBox | Platform view box | classified | scripted |
| RenderAbstractViewport | Abstract viewport | classified | scripted |
| RenderAndroidView | Android view | classified | scripted |
| RenderAnimatedOpacityMixin | RenderAnimatedOpacityMixin | sdk | scripted |
| RenderAnimatedSizeState | RenderAnimatedSizeState | sdk | scripted |
| RenderAppKitView | macOS view | classified | scripted |
| RenderClipRSuperellipse | Clip superellipse | classified | scripted |
| RenderDarwinPlatformView | Darwin view | classified | scripted |
| RenderDecoratedSliver | RenderDecoratedSliver | sdk | scripted |
| RenderEditablePainter | Editable painter | classified | scripted |
| RenderInlineChildrenContainerDefaults | Inline defaults | classified | scripted |
| RenderObjectWithLayoutCallbackMixin | Layout callback | classified | scripted |
| RenderPerformanceOverlay | RenderPerformanceOverlay | sdk | scripted |
| RenderProxySliver | Proxy sliver | classified | scripted |
| RenderSliverBoxChildManager | Box child manager | classified | scripted |
| RenderSliverConstrainedCrossAxis | Constrained cross | classified | scripted |
| RenderSliverCrossAxisGroup | Cross axis group | classified | scripted |
| RenderSliverEdgeInsetsPadding | Edge insets padding | classified | scripted |
| RenderSliverFillRemainingAndOverscroll | Overscroll remaining | classified | scripted |
| RenderSliverFillRemainingWithScrollable | Scrollable remaining | classified | scripted |
| RenderSliverFixedExtentBoxAdaptor | Fixed extent adaptor | classified | scripted |
| RenderSliverFloatingPinnedPersistentHeader | Floating pinned | classified | scripted |
| RenderSliverMainAxisGroup | Main axis group | classified | scripted |
| RenderSliverSemanticsAnnotations | Sliver semantics | classified | scripted |
| RenderSliverSingleBoxAdapter | Single box adapter | classified | scripted |
| RenderUiKitView | iOS view | classified | scripted |
| RenderingServiceExtensions | RenderingServiceExtensions | sdk | scripted |
| RevealedOffset | Revealed offset | classified | scripted |
| ScrollDirection | ScrollDirection | sdk | scripted |
| SelectAllSelectionEvent | Select all | classified | scripted |
| SelectParagraphSelectionEvent | Select paragraph | classified | scripted |
| SelectWordSelectionEvent | Select word | classified | scripted |
| SelectedContentRange | Content range | classified | scripted |
| SelectionEdgeUpdateEvent | Edge update | classified | scripted |
| SelectionEvent | Selection event | classified | scripted |
| SelectionEventType | SelectionEventType | sdk | scripted |
| SelectionExtendDirection | SelectionExtendDirection | sdk | scripted |
| SelectionHandler | Selection handler | classified | scripted |
| SelectionRegistrant | Selection registrant | classified | scripted |
| SelectionResult | SelectionResult | sdk | scripted |
| SelectionStatus | SelectionStatus | sdk | scripted |
| SelectionUtils | Selection utils | classified | scripted |
| SliverLogicalContainerParentData | Logical container | classified | scripted |
| SliverPaintOrder | SliverPaintOrder | sdk | scripted |
| SliverPhysicalContainerParentData | Physical container | classified | scripted |
| StackFit | StackFit | sdk | scripted |
| TableBorder | Table border | classified | scripted |
| TableCellVerticalAlignment | TableCellVerticalAlignment | sdk | scripted |
| TextGranularity | TextGranularity | sdk | scripted |
| TextSelectionHandleType | TextSelectionHandleType | sdk | scripted |
| TextureBox | Texture box | classified | scripted |
| TreeSliverIndentationType | Tree indent | classified | scripted |
| TreeSliverNodeParentData | Tree node data | classified | scripted |
| VerticalCaretMovementRun | Caret movement | classified | scripted |
| WrapAlignment | WrapAlignment | sdk | scripted |
| WrapCrossAlignment | WrapCrossAlignment | sdk | scripted |
| const | const | sdk | scripted |

---

## animation (30 classes)
*Sources: 4 classified, 26 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AnimationBehavior | AnimationBehavior | sdk | scripted |
| AnimationEagerListenerMixin | Eager listener mixin | classified | scripted |
| AnimationLazyListenerMixin | Lazy listener mixin | classified | scripted |
| AnimationLocalListenersMixin | Local listeners mixin | classified | scripted |
| AnimationLocalStatusListenersMixin | Status listeners mixin | classified | scripted |
| AnimationStatus | AnimationStatus | sdk | scripted |
| CatmullRomCurve | CatmullRomCurve | sdk | scripted |
| CatmullRomSpline | CatmullRomSpline | sdk | scripted |
| ColorTween | ColorTween | sdk | scripted |
| ConstantTween | ConstantTween | sdk | scripted |
| Cubic | Cubic | sdk | scripted |
| Curve2D | Curve2D | sdk | scripted |
| Curve2DSample | Curve2DSample | sdk | scripted |
| CurveTween | CurveTween | sdk | scripted |
| Curves | Curves | sdk | scripted |
| ElasticInCurve | ElasticInCurve | sdk | scripted |
| ElasticInOutCurve | ElasticInOutCurve | sdk | scripted |
| ElasticOutCurve | ElasticOutCurve | sdk | scripted |
| FlippedCurve | FlippedCurve | sdk | scripted |
| IntTween | IntTween | sdk | scripted |
| Interval | Interval | sdk | scripted |
| ParametricCurve | ParametricCurve | sdk | scripted |
| RectTween | RectTween | sdk | scripted |
| ReverseTween | ReverseTween | sdk | scripted |
| SawTooth | SawTooth | sdk | scripted |
| SizeTween | SizeTween | sdk | scripted |
| Split | Split | sdk | scripted |
| StepTween | StepTween | sdk | scripted |
| ThreePointCubic | ThreePointCubic | sdk | scripted |
| Threshold | Threshold | sdk | scripted |

---

## gestures (46 classes)
*Sources: 13 classified, 31 from SDK, 2 testpriority-only*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| BaseTapGestureRecognizer | BaseTapGestureRecognizer | sdk | scripted |
| DragDownDetails | DragDownDetails | sdk | scripted |
| DragStartBehavior | DragStartBehavior | sdk | scripted |
| DragStartDetails | DragStartDetails | sdk | scripted |
| FlutterErrorDetailsForPointerEventDispatcher | Error details | classified | scripted |
| GestureDisposition | GestureDisposition | sdk | scripted |
| GestureRecognizer | GestureRecognizer | sdk | scripted |
| GestureRecognizerState | GestureRecognizerState | sdk | scripted |
| HitTestDispatcher | HitTestDispatcher | sdk | scripted |
| HitTestable | HitTestable | sdk | scripted |
| IOSScrollViewFlingVelocityTracker | IOSScrollViewFlingVelocityTracker | sdk | scripted |
| LeastSquaresSolver | Math solver | classified | scripted |
| MacOSScrollViewFlingVelocityTracker | MacOSScrollViewFlingVelocityTracker | sdk | scripted |
| Matrix4 | Transform matrix | tp-only | tp-only |
| MultitouchDragStrategy | MultitouchDragStrategy | sdk | scripted |
| OffsetPair | OffsetPair | sdk | scripted |
| OneSequenceGestureRecognizer | OneSequenceGestureRecognizer | sdk | scripted |
| PointerAddedEvent | PointerAddedEvent | sdk | scripted |
| PointerCancelEvent | Pointer cancel | classified | scripted |
| PointerDownEvent | Pointer down | classified | scripted |
| PointerEnterEvent | PointerEnterEvent | sdk | scripted |
| PointerEvent | Base pointer event | classified | scripted |
| PointerEventConverter | Event conversion | classified | scripted |
| PointerEventResampler | Event resampling | classified | scripted |
| PointerExitEvent | PointerExitEvent | sdk | scripted |
| PointerHoverEvent | PointerHoverEvent | sdk | scripted |
| PointerMoveEvent | PointerMoveEvent | sdk | scripted |
| PointerPanZoomEndEvent | PointerPanZoomEndEvent | sdk | scripted |
| PointerPanZoomStartEvent | Pan zoom start | classified | scripted |
| PointerPanZoomUpdateEvent | PointerPanZoomUpdateEvent | sdk | scripted |
| PointerRemovedEvent | PointerRemovedEvent | sdk | scripted |
| PointerScaleEvent | PointerScaleEvent | sdk | scripted |
| PointerScrollEvent | PointerScrollEvent | sdk | scripted |
| PointerScrollInertiaCancelEvent | PointerScrollInertiaCancelEvent | sdk | scripted |
| PointerSignalEvent | Pointer signal | classified | scripted |
| PointerSignalResolver | Signal resolution | classified | scripted |
| PointerUpEvent | Pointer up | classified | scripted |
| PolynomialFit | Polynomial fitting | classified | scripted |
| PrimaryPointerGestureRecognizer | PrimaryPointerGestureRecognizer | sdk | scripted |
| SamplingClock | Sampling clock | classified | scripted |
| TapAndDragGestureRecognizer | TapAndDragGestureRecognizer | sdk | scripted |
| TapGestureRecognizer | TapGestureRecognizer | sdk | scripted |
| TapMoveDetails | TapMoveDetails | sdk | scripted |
| Vector3 | 3D vector | tp-only | tp-only |
| VelocityEstimate | VelocityEstimate | sdk | scripted |
| VelocityTracker | VelocityTracker | sdk | scripted |

---

## services (89 classes)
*Sources: 16 classified, 73 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AndroidMotionEvent | Android motion | classified | scripted |
| AndroidPointerCoords | Android coords | classified | scripted |
| AndroidPointerProperties | Android properties | classified | scripted |
| ApplicationSwitcherDescription | App switcher | classified | scripted |
| AutofillClient | AutofillClient | sdk | scripted |
| AutofillHints | AutofillHints | sdk | scripted |
| AutofillScopeMixin | AutofillScopeMixin | sdk | scripted |
| BackgroundIsolateBinaryMessenger | BackgroundIsolateBinaryMessenger | sdk | scripted |
| BinaryMessenger | Binary messaging | classified | scripted |
| ContentSensitivity | ContentSensitivity | sdk | scripted |
| DeferredComponent | Deferred loading | classified | scripted |
| DeltaTextInputClient | DeltaTextInputClient | sdk | scripted |
| DeviceOrientation | DeviceOrientation | sdk | scripted |
| FloatingCursorDragState | FloatingCursorDragState | sdk | scripted |
| GLFWKeyHelper | GLFWKeyHelper | sdk | scripted |
| GtkKeyHelper | GtkKeyHelper | sdk | scripted |
| IOSSystemContextMenuItemData | IOSSystemContextMenuItemData | sdk | scripted |
| IOSSystemContextMenuItemDataCopy | IOSSystemContextMenuItemDataCopy | sdk | scripted |
| IOSSystemContextMenuItemDataCustom | IOSSystemContextMenuItemDataCustom | sdk | scripted |
| IOSSystemContextMenuItemDataCut | IOSSystemContextMenuItemDataCut | sdk | scripted |
| IOSSystemContextMenuItemDataLiveText | IOSSystemContextMenuItemDataLiveText | sdk | scripted |
| IOSSystemContextMenuItemDataLookUp | IOSSystemContextMenuItemDataLookUp | sdk | scripted |
| IOSSystemContextMenuItemDataPaste | IOSSystemContextMenuItemDataPaste | sdk | scripted |
| IOSSystemContextMenuItemDataSearchWeb | IOSSystemContextMenuItemDataSearchWeb | sdk | scripted |
| IOSSystemContextMenuItemDataSelectAll | IOSSystemContextMenuItemDataSelectAll | sdk | scripted |
| IOSSystemContextMenuItemDataShare | IOSSystemContextMenuItemDataShare | sdk | scripted |
| KeyDataTransitMode | KeyDataTransitMode | sdk | scripted |
| KeyDownEvent | KeyDownEvent | sdk | scripted |
| KeyEvent | KeyEvent | sdk | scripted |
| KeyEventManager | KeyEventManager | sdk | scripted |
| KeyHelper | KeyHelper | sdk | scripted |
| KeyMessage | KeyMessage | sdk | scripted |
| KeyRepeatEvent | KeyRepeatEvent | sdk | scripted |
| KeyUpEvent | KeyUpEvent | sdk | scripted |
| KeyboardKey | KeyboardKey | sdk | scripted |
| KeyboardLockMode | KeyboardLockMode | sdk | scripted |
| KeyboardSide | KeyboardSide | sdk | scripted |
| MaxLengthEnforcement | MaxLengthEnforcement | sdk | scripted |
| MessageCodec | Message codec base | classified | scripted |
| MethodCodec | Method codec base | classified | scripted |
| MissingPluginException | Plugin error | classified | scripted |
| ModifierKey | ModifierKey | sdk | scripted |
| MouseCursorManager | Cursor manager | classified | scripted |
| MouseCursorSession | Cursor session | classified | scripted |
| MouseTrackerAnnotation | Mouse tracking | classified | scripted |
| PlatformException | Platform error | classified | scripted |
| RawFloatingCursorPoint | RawFloatingCursorPoint | sdk | scripted |
| RawKeyDownEvent | RawKeyDownEvent | sdk | scripted |
| RawKeyEvent | RawKeyEvent | sdk | scripted |
| RawKeyEventData | RawKeyEventData | sdk | scripted |
| RawKeyEventDataAndroid | RawKeyEventDataAndroid | sdk | scripted |
| RawKeyEventDataFuchsia | RawKeyEventDataFuchsia | sdk | scripted |
| RawKeyEventDataIos | RawKeyEventDataIos | sdk | scripted |
| RawKeyEventDataLinux | RawKeyEventDataLinux | sdk | scripted |
| RawKeyEventDataMacOs | RawKeyEventDataMacOs | sdk | scripted |
| RawKeyEventDataWeb | RawKeyEventDataWeb | sdk | scripted |
| RawKeyEventDataWindows | RawKeyEventDataWindows | sdk | scripted |
| RawKeyUpEvent | RawKeyUpEvent | sdk | scripted |
| RawKeyboard | RawKeyboard | sdk | scripted |
| RestorationBucket | RestorationBucket | sdk | scripted |
| ScribbleClient | ScribbleClient | sdk | scripted |
| SelectionChangedCause | SelectionChangedCause | sdk | scripted |
| SelectionRect | SelectionRect | sdk | scripted |
| SensitiveContentService | Sensitive content | classified | scripted |
| ServicesServiceExtensions | ServicesServiceExtensions | sdk | scripted |
| SmartDashesType | SmartDashesType | sdk | scripted |
| SmartQuotesType | SmartQuotesType | sdk | scripted |
| SwipeEdge | SwipeEdge | sdk | scripted |
| SystemContextMenuClient | Context menu | classified | scripted |
| SystemContextMenuController | SystemContextMenuController | sdk | scripted |
| SystemSoundType | SystemSoundType | sdk | scripted |
| SystemUiMode | SystemUiMode | sdk | scripted |
| SystemUiOverlay | SystemUiOverlay | sdk | scripted |
| TextCapitalization | TextCapitalization | sdk | scripted |
| TextEditingDeltaDeletion | TextEditingDeltaDeletion | sdk | scripted |
| TextEditingDeltaInsertion | TextEditingDeltaInsertion | sdk | scripted |
| TextEditingDeltaNonTextUpdate | TextEditingDeltaNonTextUpdate | sdk | scripted |
| TextEditingDeltaReplacement | TextEditingDeltaReplacement | sdk | scripted |
| TextEditingValue | TextEditingValue | sdk | scripted |
| TextInput | TextInput | sdk | scripted |
| TextInputAction | TextInputAction | sdk | scripted |
| TextInputClient | TextInputClient | sdk | scripted |
| TextInputConfiguration | TextInputConfiguration | sdk | scripted |
| TextInputConnection | TextInputConnection | sdk | scripted |
| TextInputControl | TextInputControl | sdk | scripted |
| TextInputType | TextInputType | sdk | scripted |
| TextSelection | Text selection | classified | scripted |
| TextSelectionDelegate | TextSelectionDelegate | sdk | scripted |
| UndoDirection | UndoDirection | sdk | scripted |

---

## dart:ui (75 classes)
*Sources: 27 classified, 48 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AppExitResponse | AppExitResponse | sdk | scripted |
| AppExitType | AppExitType | sdk | scripted |
| AppLifecycleState | AppLifecycleState | sdk | scripted |
| BackdropFilterEngineLayer | Backdrop filter layer | classified | scripted |
| BlendMode | BlendMode | sdk | scripted |
| BlurStyle | BlurStyle | sdk | scripted |
| BoxHeightStyle | BoxHeightStyle | sdk | scripted |
| BoxWidthStyle | BoxWidthStyle | sdk | scripted |
| CallbackHandle | Callback registration | classified | scripted |
| ChannelBuffers | Platform channel buffers | classified | scripted |
| CheckedState | CheckedState | sdk | scripted |
| Clip | Clip | sdk | scripted |
| ClipOp | ClipOp | sdk | scripted |
| ClipPathEngineLayer | Clip path layer | classified | scripted |
| ClipRRectEngineLayer | Clip rounded rect layer | classified | scripted |
| ClipRSuperellipseEngineLayer | Clip superellipse layer | classified | scripted |
| ClipRectEngineLayer | Clip rect layer | classified | scripted |
| ColorFilterEngineLayer | Color filter layer | classified | scripted |
| ColorSpace | ColorSpace | sdk | scripted |
| DartPerformanceMode | DartPerformanceMode | sdk | scripted |
| DartPluginRegistrant | Plugin registration | classified | scripted |
| DisplayFeatureState | DisplayFeatureState | sdk | scripted |
| DisplayFeatureType | DisplayFeatureType | sdk | scripted |
| EngineLayer | Base engine layer | classified | scripted |
| FilterQuality | FilterQuality | sdk | scripted |
| FontStyle | FontStyle | sdk | scripted |
| FragmentProgram | Fragment shader program | classified | scripted |
| FragmentShader | Fragment shader instance | classified | scripted |
| FramePhase | FramePhase | sdk | scripted |
| ImageByteFormat | ImageByteFormat | sdk | scripted |
| ImageFilterEngineLayer | Image filter layer | classified | scripted |
| ImageSamplerSlot | Shader image sampler | classified | scripted |
| IsolateNameServer | Isolate communication | classified | scripted |
| KeyEventDeviceType | KeyEventDeviceType | sdk | scripted |
| KeyEventType | KeyEventType | sdk | scripted |
| OffsetEngineLayer | Offset layer | classified | scripted |
| OpacityEngineLayer | Opacity layer | classified | scripted |
| PaintingStyle | PaintingStyle | sdk | scripted |
| PathFillType | PathFillType | sdk | scripted |
| PathOperation | PathOperation | sdk | scripted |
| PictureRasterizationException | Picture error | classified | scripted |
| PixelFormat | PixelFormat | sdk | scripted |
| PlaceholderAlignment | PlaceholderAlignment | sdk | scripted |
| PluginUtilities | Plugin utilities | classified | scripted |
| PointMode | PointMode | sdk | scripted |
| PointerChange | PointerChange | sdk | scripted |
| PointerDeviceKind | PointerDeviceKind | sdk | scripted |
| PointerSignalKind | PointerSignalKind | sdk | scripted |
| RootIsolateToken | Root isolate token | classified | scripted |
| SemanticsHitTestBehavior | SemanticsHitTestBehavior | sdk | scripted |
| SemanticsInputType | SemanticsInputType | sdk | scripted |
| SemanticsRole | SemanticsRole | sdk | scripted |
| SemanticsValidationResult | SemanticsValidationResult | sdk | scripted |
| ShaderMaskEngineLayer | Shader mask layer | classified | scripted |
| SingletonFlutterWindow | SingletonFlutterWindow | sdk | scripted |
| StrokeCap | StrokeCap | sdk | scripted |
| StrokeJoin | StrokeJoin | sdk | scripted |
| SystemColorPalette | System color palette | classified | scripted |
| TargetPixelFormat | TargetPixelFormat | sdk | scripted |
| TextAffinity | TextAffinity | sdk | scripted |
| TextAlign | TextAlign | sdk | scripted |
| TextBaseline | TextBaseline | sdk | scripted |
| TextDecorationStyle | TextDecorationStyle | sdk | scripted |
| TextDirection | TextDirection | sdk | scripted |
| TextLeadingDistribution | TextLeadingDistribution | sdk | scripted |
| TileMode | TileMode | sdk | scripted |
| TransformEngineLayer | Transform layer | classified | scripted |
| Tristate | Tristate | sdk | scripted |
| UniformFloatSlot | Shader uniform slot | classified | scripted |
| UniformVec2Slot | Shader vec2 slot | classified | scripted |
| UniformVec3Slot | Shader vec3 slot | classified | scripted |
| UniformVec4Slot | Shader vec4 slot | classified | scripted |
| VertexMode | VertexMode | sdk | scripted |
| ViewFocusDirection | ViewFocusDirection | sdk | scripted |
| ViewFocusState | ViewFocusState | sdk | scripted |

---

## semantics (9 classes)
*Sources: 1 classified, 8 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| AccessibilityFocusBlockType | AccessibilityFocusBlockType | sdk | scripted |
| AnnounceSemanticsEvent | AnnounceSemanticsEvent | sdk | scripted |
| Assertiveness | Assertiveness | sdk | scripted |
| AttributedStringProperty | Diagnostics property | classified | scripted |
| DebugSemanticsDumpOrder | DebugSemanticsDumpOrder | sdk | scripted |
| FocusSemanticEvent | FocusSemanticEvent | sdk | scripted |
| LongPressSemanticsEvent | LongPressSemanticsEvent | sdk | scripted |
| TapSemanticEvent | TapSemanticEvent | sdk | scripted |
| TooltipSemanticsEvent | TooltipSemanticsEvent | sdk | scripted |

---

## scheduler (3 classes)
*Sources: 3 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| Priority | Priority | sdk | scripted |
| SchedulerPhase | SchedulerPhase | sdk | scripted |
| SchedulerServiceExtensions | SchedulerServiceExtensions | sdk | scripted |

---

## physics (2 classes)
*Sources: 1 classified, 1 from SDK*

| Class | Description | Source | Status |
|-------|-------------|--------|--------|
| BoundedFrictionSimulation | Bounded friction | classified | scripted |
| SpringType | SpringType | sdk | scripted |

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
