# Test Plan: Important Classes

**Priority: IMPORTANT**
**Total classes: 607**

Commonly used classes for intermediate Flutter development - test after essential classes.

---

## widgets (120 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| Wrap | Wrapping layout | widgets/wrap_test.dart | created | - |
| Table | Table layout | widgets/table_test.dart | created | - |
| ListBody | List body | test_widgets_listbody.dart | - | - |
| Flow | Flow layout | test_widgets_flow.dart | - | - |
| CustomScrollView | Custom scrolling | widgets/customscrollview_test.dart | created | - |
| NestedScrollView | Nested scrolling | test_widgets_nestedscrollview.dart | - | - |
| ScrollController | Scroll control | test_widgets_scrollcontroller.dart | - | - |
| PageController | Page control | test_widgets_pagecontroller.dart | - | - |
| TabController | Tab control | test_widgets_tabcontroller.dart | - | - |
| AnimatedContainer | Animated container | widgets/animatedcontainer_test.dart | created | - |
| AnimatedOpacity | Animated opacity | widgets/animatedopacity_test.dart | created | - |
| AnimatedPadding | Animated padding | test_widgets_animatedpadding.dart | - | - |
| AnimatedPositioned | Animated position | test_widgets_animatedpositioned.dart | - | - |
| AnimatedSize | Animated size | test_widgets_animatedsize.dart | - | - |
| AnimatedBuilder | Generic animation | test_widgets_animatedbuilder.dart | - | - |
| AnimatedWidget | Animated widget base | test_widgets_animatedwidget.dart | - | - |
| FadeTransition | Fade animation | widgets/fadetransition_test.dart | created | - |
| ScaleTransition | Scale animation | widgets/scaletransition_test.dart | created | - |
| RotationTransition | Rotation animation | widgets/rotationtransition_test.dart | created | - |
| SlideTransition | Slide animation | widgets/slidetransition_test.dart | created | - |
| SizeTransition | Size animation | widgets/rotationtransition_test.dart | created | - |
| PositionedTransition | Position animation | widgets/rotationtransition_test.dart | created | - |
| DecoratedBoxTransition | Decoration animation | widgets/rotationtransition_test.dart | created | - |
| Hero | Hero animation | widgets/hero_test.dart | created | - |
| HeroMode | Hero enabling | test_widgets_heromode.dart | - | - |
| SafeArea | Safe area insets | widgets/safearea_test.dart | created | - |
| MediaQuery | Device info | widgets/mediaquery_test.dart | created | - |
| MediaQueryData | Device info data | widgets/mediaquery_test.dart | created | - |
| Visibility | Visibility control | widgets/visibility_test.dart | created | - |
| Offstage | Offstage positioning | widgets/offstage_test.dart | created | - |
| Opacity | Opacity control | test_widgets_opacity.dart | - | - |
| ClipRect | Rectangle clipping | test_widgets_cliprect.dart | - | - |
| ClipRRect | Rounded clipping | test_widgets_cliprrect.dart | - | - |
| ClipOval | Oval clipping | test_widgets_clipoval.dart | - | - |
| ClipPath | Path clipping | test_widgets_clippath.dart | - | - |
| DecoratedBox | Decoration box | widgets/decoratedbox_test.dart | created | - |
| ColoredBox | Colored box | widgets/decoratedbox_test.dart | created | - |
| Transform | Transformations | test_widgets_transform.dart | - | - |
| RotatedBox | Rotated box | widgets/decoratedbox_test.dart | created | - |
| FractionallySizedBox | Fractional sizing | test_widgets_fractionallysizedbox.dart | - | - |
| FittedBox | Fitted content | widgets/constrainedbox_test.dart | created | - |
| AspectRatio | Aspect ratio | widgets/constrainedbox_test.dart | created | - |
| ConstrainedBox | Constraints | widgets/constrainedbox_test.dart | created | - |
| UnconstrainedBox | No constraints | test_widgets_unconstrainedbox.dart | - | - |
| LimitedBox | Limited size | test_widgets_limitedbox.dart | - | - |
| IntrinsicWidth | Intrinsic width | widgets/constrainedbox_test.dart | created | - |
| IntrinsicHeight | Intrinsic height | widgets/constrainedbox_test.dart | created | - |
| Baseline | Baseline alignment | test_widgets_baseline.dart | - | - |
| CustomPaint | Custom painting | widgets/custompaint_test.dart | created | - |
| CustomMultiChildLayout | Multi layout | test_widgets_custommultichildlayout.dart | - | - |
| CustomSingleChildLayout | Single layout | test_widgets_customsinglechildlayout.dart | - | - |
| LayoutBuilder | Layout building | widgets/layoutbuilder_test.dart | created | - |
| Builder | Widget building | widgets/builder_test.dart | created | - |
| StatefulBuilder | Stateful building | widgets/builder_test.dart | created | - |
| FutureBuilder | Future building | test_widgets_futurebuilder.dart | - | - |
| StreamBuilder | Stream building | test_widgets_streambuilder.dart | - | - |
| ValueListenableBuilder | Value listenable | test_widgets_valuelistenablebuilder.dart | - | - |
| ListenableBuilder | Listenable building | test_widgets_listenablebuilder.dart | - | - |
| AnimatedList | Animated list | widgets/animatedlist_test.dart | created | - |
| AnimatedGrid | Animated grid | test_widgets_animatedgrid.dart | - | - |
| ReorderableListView | Reorderable list | test_widgets_reorderablelistview.dart | - | - |
| Draggable | Draggable widget | widgets/draggable_test.dart | created | - |
| DragTarget | Drop target | widgets/draggable_test.dart | created | - |
| LongPressDraggable | Long press drag | widgets/draggable_test.dart | created | - |
| DraggableScrollableSheet | Draggable sheet | test_widgets_draggablescrollablesheet.dart | - | - |
| InteractiveViewer | Pan/zoom viewer | widgets/interactiveviewer_test.dart | created | - |
| IgnorePointer | Ignore touches | widgets/absorbpointer_test.dart | created | - |
| AbsorbPointer | Absorb touches | widgets/absorbpointer_test.dart | created | - |
| Listener | Pointer events | test_widgets_listener.dart | - | - |
| MouseRegion | Mouse events | widgets/absorbpointer_test.dart | created | - |
| RepaintBoundary | Repaint boundary | widgets/absorbpointer_test.dart | created | - |
| Semantics | Accessibility | test_widgets_semantics.dart | - | - |
| MergeSemantics | Merge semantics | test_widgets_mergesemantics.dart | - | - |
| ExcludeSemantics | Exclude semantics | test_widgets_excludesemantics.dart | - | - |
| BlockSemantics | Block semantics | test_widgets_blocksemantics.dart | - | - |
| IndexedSemantics | Indexed semantics | test_widgets_indexedsemantics.dart | - | - |
| Tooltip | Tooltips | test_widgets_tooltip.dart | - | - |
| Overlay | Overlay layer | test_widgets_overlay.dart | - | - |
| OverlayEntry | Overlay entry | test_widgets_overlayentry.dart | - | - |
| ModalRoute | Modal routing | test_widgets_modalroute.dart | - | - |
| PageRoute | Page routing | test_widgets_pageroute.dart | - | - |
| PopupRoute | Popup routing | test_widgets_popuproute.dart | - | - |
| Route | Base route | test_widgets_route.dart | - | - |
| RouteSettings | Route settings | test_widgets_routesettings.dart | - | - |
| NavigatorState | Navigator state | test_widgets_navigatorstate.dart | - | - |
| NavigatorObserver | Navigation observer | test_widgets_navigatorobserver.dart | - | - |
| BackButtonDispatcher | Back button | test_widgets_backbuttondispatcher.dart | - | - |
| Router | Declarative routing | test_widgets_router.dart | - | - |
| RouterDelegate | Router delegate | test_widgets_routerdelegate.dart | - | - |
| RouteInformationParser | Route parsing | test_widgets_routeinformationparser.dart | - | - |
| RouteInformationProvider | Route provider | test_widgets_routeinformationprovider.dart | - | - |
| LocalHistoryRoute | Local history | test_widgets_localhistoryroute.dart | - | - |
| Localizations | Localization | test_widgets_localizations.dart | - | - |
| LocalizationsDelegate | Locale delegate | test_widgets_localizationsdelegate.dart | - | - |
| DefaultWidgetsLocalizations | Default locale | test_widgets_defaultwidgetslocalizations.dart | - | - |
| Actions | Action handling | test_widgets_actions.dart | - | - |
| Shortcuts | Keyboard shortcuts | test_widgets_shortcuts.dart | - | - |
| Intent | User intent | test_widgets_intent.dart | - | - |
| Action | Action handler | test_widgets_action.dart | - | - |
| CallbackAction | Callback action | test_widgets_callbackaction.dart | - | - |
| FocusableActionDetector | Focus action | test_widgets_focusableactiondetector.dart | - | - |
| FocusTraversalGroup | Focus traversal | test_widgets_focustraversalgroup.dart | - | - |
| FocusTraversalPolicy | Traversal policy | test_widgets_focustraversalpolicy.dart | - | - |
| FocusManager | Focus manager | test_widgets_focusmanager.dart | - | - |
| Focus | Focus widget | test_widgets_focus.dart | - | - |
| FocusScope | Focus scope widget | test_widgets_focusscope.dart | - | - |
| FormState | Form state | test_widgets_formstate.dart | - | - |
| FormFieldState | Field state | test_widgets_formfieldstate.dart | - | - |
| TextEditingController | Text controller | test_widgets_texteditingcontroller.dart | - | - |
| ScrollNotification | Scroll notification | test_widgets_scrollnotification.dart | - | - |
| NotificationListener | Notification listener | test_widgets_notificationlistener.dart | - | - |
| LayoutChangedNotification | Layout notification | test_widgets_layoutchangednotification.dart | - | - |
| KeepAlive | Keep alive | test_widgets_keepalive.dart | - | - |
| AutomaticKeepAlive | Auto keep alive | test_widgets_automatickeepalive.dart | - | - |
| SliverList | Sliver list | widgets/sliverlist_test.dart | created | - |
| SliverGrid | Sliver grid | widgets/sliverlist_test.dart | created | - |
| SliverFixedExtentList | Fixed extent | test_widgets_sliverfixedextentlist.dart | - | - |
| SliverVariedExtentList | Varied extent | test_widgets_slivervariedextentlist.dart | - | - |
| SliverFillRemaining | Fill remaining | test_widgets_sliverfillremaining.dart | - | - |
| SliverFillViewport | Fill viewport | test_widgets_sliverfillviewport.dart | - | - |
| SliverToBoxAdapter | Box adapter | widgets/customscrollview_test.dart | created | - |
| SliverPadding | Sliver padding | widgets/sliverlist_test.dart | created | - |
| SliverOpacity | Sliver opacity | test_widgets_sliveropacity.dart | - | - |
| SliverPersistentHeader | Persistent header | test_widgets_sliverpersistentheader.dart | - | - |
| SliverAppBar | Sliver app bar | test_widgets_sliverappbar.dart | - | - |
| SnackBar | Snackbar message | test_widgets_snackbar.dart | - | - |
| Banner | Debug banner | test_widgets_banner.dart | - | - |
| ErrorWidget | Error display | test_widgets_errorwidget.dart | - | - |

---

## material (180 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| MaterialState | Widget state | test_material_materialstate.dart | - | - |
| MaterialStateProperty | State property | test_material_materialstateproperty.dart | - | - |
| WidgetStateProperty | Widget state | test_material_widgetstateproperty.dart | - | - |
| WidgetStatesController | States controller | test_material_widgetstatescontroller.dart | - | - |
| ButtonTheme | Button theming | test_material_buttontheme.dart | - | - |
| ButtonThemeData | Button theme data | test_material_buttonthemedata.dart | - | - |
| ElevatedButtonTheme | Elevated theme | test_material_elevatedbuttontheme.dart | - | - |
| ElevatedButtonThemeData | Elevated data | test_material_elevatedbuttonthemedata.dart | - | - |
| TextButtonTheme | Text button theme | test_material_textbuttontheme.dart | - | - |
| OutlinedButtonTheme | Outlined theme | test_material_outlinedbuttontheme.dart | - | - |
| FilledButtonTheme | Filled theme | test_material_filledbuttontheme.dart | - | - |
| IconButtonTheme | Icon button theme | test_material_iconbuttontheme.dart | - | - |
| FloatingActionButtonTheme | FAB theme | test_material_floatingactionbuttontheme.dart | - | - |
| AppBarTheme | App bar theme | test_material_appbartheme.dart | - | - |
| BottomAppBarTheme | Bottom bar theme | test_material_bottomappbartheme.dart | - | - |
| NavigationBarTheme | Nav bar theme | test_material_navigationbartheme.dart | - | - |
| NavigationRailTheme | Nav rail theme | test_material_navigationrailtheme.dart | - | - |
| DrawerTheme | Drawer theme | test_material_drawertheme.dart | - | - |
| ListTileTheme | Tile theme | test_material_listtiletheme.dart | - | - |
| CardTheme | Card theme | test_material_cardtheme.dart | - | - |
| ChipTheme | Chip theme | test_material_chiptheme.dart | - | - |
| TooltipTheme | Tooltip theme | test_material_tooltiptheme.dart | - | - |
| DividerTheme | Divider theme | test_material_dividertheme.dart | - | - |
| DialogTheme | Dialog theme | test_material_dialogtheme.dart | - | - |
| BottomSheetTheme | Sheet theme | test_material_bottomsheettheme.dart | - | - |
| SnackBarTheme | Snackbar theme | test_material_snackbartheme.dart | - | - |
| TabBarTheme | Tab theme | test_material_tabbartheme.dart | - | - |
| SliderTheme | Slider theme | test_material_slidertheme.dart | - | - |
| SwitchTheme | Switch theme | test_material_switchtheme.dart | - | - |
| CheckboxTheme | Checkbox theme | test_material_checkboxtheme.dart | - | - |
| RadioTheme | Radio theme | test_material_radiotheme.dart | - | - |
| ProgressIndicatorTheme | Progress theme | test_material_progressindicatortheme.dart | - | - |
| DatePickerTheme | Date picker theme | test_material_datepickertheme.dart | - | - |
| TimePickerTheme | Time picker theme | test_material_timepickertheme.dart | - | - |
| PopupMenuTheme | Popup theme | test_material_popupmenutheme.dart | - | - |
| MenuTheme | Menu theme | test_material_menutheme.dart | - | - |
| MenuBarTheme | Menu bar theme | test_material_menubartheme.dart | - | - |
| DropdownMenuTheme | Dropdown theme | test_material_dropdownmenutheme.dart | - | - |
| SearchBarTheme | Search theme | test_material_searchbartheme.dart | - | - |
| SearchViewTheme | Search view theme | test_material_searchviewtheme.dart | - | - |
| ExpansionTileTheme | Expansion theme | test_material_expansiontiletheme.dart | - | - |
| SegmentedButtonTheme | Segment theme | test_material_segmentedbuttontheme.dart | - | - |
| BadgeTheme | Badge theme | test_material_badgetheme.dart | - | - |
| ActionIconTheme | Action icon theme | test_material_actionicontheme.dart | - | - |
| BottomAppBar | Bottom app bar | material/bottomappbar_test.dart | created | - |
| NavigationDestination | Nav destination | test_material_navigationdestination.dart | - | - |
| NavigationRailDestination | Rail destination | test_material_navigationraildestination.dart | - | - |
| NavigationDrawerDestination | Drawer destination | test_material_navigationdrawerdestination.dart | - | - |
| DrawerHeader | Drawer header | test_material_drawerheader.dart | - | - |
| UserAccountsDrawerHeader | User header | test_material_useraccountsdrawerheader.dart | - | - |
| AboutListTile | About tile | test_material_aboutlisttile.dart | - | - |
| AboutDialog | About dialog | test_material_aboutdialog.dart | - | - |
| LicensePage | License page | test_material_licensepage.dart | - | - |
| showDialog | Show dialog | test_material_showdialog.dart | - | - |
| showModalBottomSheet | Modal sheet | test_material_showmodalbottomsheet.dart | - | - |
| showBottomSheet | Bottom sheet | test_material_showbottomsheet.dart | - | - |
| showMenu | Show menu | test_material_showmenu.dart | - | - |
| showDatePicker | Date picker | test_material_showdatepicker.dart | - | - |
| showTimePicker | Time picker | test_material_showtimepicker.dart | - | - |
| showSearch | Show search | test_material_showsearch.dart | - | - |
| DatePickerDialog | Date dialog | test_material_datepickerdialog.dart | - | - |
| TimePickerDialog | Time dialog | test_material_timepickerdialog.dart | - | - |
| CalendarDatePicker | Calendar picker | test_material_calendardatepicker.dart | - | - |
| YearPicker | Year picker | test_material_yearpicker.dart | - | - |
| MonthPicker | Month picker | test_material_monthpicker.dart | - | - |
| CupertinoDatePicker | iOS date picker | test_material_cupertinodatepicker.dart | - | - |
| MenuAnchor | Menu anchor | test_material_menuanchor.dart | - | - |
| MenuBar | Menu bar | test_material_menubar.dart | - | - |
| MenuItemButton | Menu item | test_material_menuitembutton.dart | - | - |
| SubmenuButton | Submenu | test_material_submenubutton.dart | - | - |
| CheckboxMenuButton | Checkbox menu | test_material_checkboxmenubutton.dart | - | - |
| RadioMenuButton | Radio menu | test_material_radiomenubutton.dart | - | - |
| DropdownButtonFormField | Dropdown form | test_material_dropdownbuttonformfield.dart | - | - |
| ExpansionTile | Expansion tile | test_material_expansiontile.dart | - | - |
| ExpansionPanelList | Panel list | test_material_expansionpanellist.dart | - | - |
| ExpansionPanel | Expansion panel | test_material_expansionpanel.dart | - | - |
| DataTable | Data table | test_material_datatable.dart | - | - |
| DataRow | Data row | test_material_datarow.dart | - | - |
| DataColumn | Data column | test_material_datacolumn.dart | - | - |
| DataCell | Data cell | test_material_datacell.dart | - | - |
| PaginatedDataTable | Paginated table | test_material_paginateddatatable.dart | - | - |
| Stepper | Stepper widget | test_material_stepper.dart | - | - |
| Step | Step item | test_material_step.dart | - | - |
| SegmentedButton | Segmented button | material/segmentedbutton_test.dart | created | - |
| ButtonSegment | Button segment | test_material_buttonsegment.dart | - | - |
| Badge | Badge widget | test_material_badge.dart | - | - |
| FlutterLogo | Flutter logo | test_material_flutterlogo.dart | - | - |
| CircleAvatar | Circle avatar | material/circleavatar_test.dart | created | - |
| Material | Material widget | test_material_material.dart | - | - |
| InkWell | Ink ripple | test_material_inkwell.dart | - | - |
| InkResponse | Ink response | test_material_inkresponse.dart | - | - |
| Ink | Ink widget | test_material_ink.dart | - | - |
| SelectableText | Selectable text | material/selectabletext_test.dart | created | - |
| ReorderableListView | Reorderable list | test_material_reorderablelistview.dart | - | - |
| ToggleButtons | Toggle buttons | material/togglebuttons_test.dart | created | - |
| AnimatedIcon | Animated icon | test_material_animatedicon.dart | - | - |
| AnimatedIcons | Icon animations | test_material_animatedicons.dart | - | - |
| RefreshIndicator | Pull to refresh | test_material_refreshindicator.dart | - | - |
| Scrollbar | Scrollbar | material/scrollbar_test.dart | created | - |
| RawScrollbar | Raw scrollbar | test_material_rawscrollbar.dart | - | - |
| InteractiveInkFeature | Ink feature | test_material_interactiveinkfeature.dart | - | - |
| InkHighlight | Ink highlight | test_material_inkhighlight.dart | - | - |
| InkSplash | Ink splash | test_material_inksplash.dart | - | - |
| InkRipple | Ink ripple | test_material_inkripple.dart | - | - |
| InkFeature | Ink feature base | test_material_inkfeature.dart | - | - |
| MaterialInkController | Ink controller | test_material_materialinkcontroller.dart | - | - |
| SliverAppBar | Sliver app bar | material/sliverappbar_test.dart | created | - |
| FlexibleSpaceBar | Flexible space | material/sliverappbar_test.dart | created | - |
| StretchyHeaderBar | Stretchy header | test_material_stretchyheaderbar.dart | - | - |
| MergeableMaterial | Mergeable | test_material_mergeablematerial.dart | - | - |
| MaterialGap | Material gap | test_material_materialgap.dart | - | - |
| MaterialSlice | Material slice | test_material_materialslice.dart | - | - |
| TextSelectionTheme | Selection theme | test_material_textselectiontheme.dart | - | - |
| TimeOfDay | Time of day | test_material_timeofday.dart | - | - |
| MaterialPageRoute | Page route | test_material_materialpageroute.dart | - | - |
| MaterialPage | Material page | test_material_materialpage.dart | - | - |
| MaterialRouteTransitionMixin | Route transition | test_material_materialroutetransitionmixin.dart | - | - |
| PageTransitionsTheme | Page transitions | test_material_pagetransitionstheme.dart | - | - |
| PageTransitionsBuilder | Transition builder | test_material_pagetransitionsbuilder.dart | - | - |
| FadeUpwardsPageTransitionsBuilder | Fade upwards | test_material_fadeupwardspagetransitionsbuilder.dart | - | - |
| OpenUpwardsPageTransitionsBuilder | Open upwards | test_material_openupwardspagetransitionsbuilder.dart | - | - |
| ZoomPageTransitionsBuilder | Zoom transition | test_material_zoompagetransitionsbuilder.dart | - | - |
| CupertinoPageTransitionsBuilder | iOS transition | test_material_cupertinopagetransitionsbuilder.dart | - | - |
| PredictiveBackPageTransitionsBuilder | Predictive back | test_material_predictivebackpagetransitionsbuilder.dart | - | - |
| ScrollbarTheme | Scrollbar theme | test_material_scrollbartheme.dart | - | - |
| MaterialBannerTheme | Banner theme | test_material_materialbannertheme.dart | - | - |
| progressIndicatorTheme | Progress theme | test_material_progressindicatortheme2.dart | - | - |
| TextFieldTheme | Text field theme | test_material_textfieldtheme.dart | - | - |

---

## cupertino (120 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| DefaultCupertinoLocalizations | Default locale | test_cupertino_defaultcupertinolocalizations.dart | - | - |
| GlobalCupertinoLocalizations | Global locale | test_cupertino_globalcupertinolocalizations.dart | - | - |
| CupertinoApp.router | Router app | test_cupertino_cupertinoapp_router.dart | - | - |
| CupertinoModalPopupRoute | Modal route | test_cupertino_cupertinomodalpopuproute.dart | - | - |
| CupertinoDialogRoute | Dialog route | test_cupertino_cupertinodialogr oute.dart | - | - |
| CupertinoNavigationBarBackButton | Back button | test_cupertino_cupertinonavigationbarbackbutton.dart | - | - |
| CupertinoSliverRefreshControl | Refresh control | test_cupertino_cupertinosliverrefreshcontrol.dart | - | - |
| CupertinoRefreshSliver | Refresh sliver | test_cupertino_cupertinorefreshsliver.dart | - | - |
| RefreshCallback | Refresh callback | test_cupertino_refreshcallback.dart | - | - |
| RefreshIndicatorMode | Indicator mode | test_cupertino_refreshindicatormode.dart | - | - |
| CupertinoMagnifier | Magnifier | test_cupertino_cupertinomagnifier.dart | - | - |
| CupertinoAdaptiveTextSelectionToolbar | Text toolbar | test_cupertino_cupertinoadaptivetextselectiontoolbar.dart | - | - |
| CupertinoTextSelectionToolbar | Selection toolbar | test_cupertino_cupertinotextselectiontoolbar.dart | - | - |
| CupertinoTextSelectionToolbarButton | Toolbar button | test_cupertino_cupertinotextselectiontoolbarbutton.dart | - | - |
| CupertinoDesktopTextSelectionToolbar | Desktop toolbar | test_cupertino_cupertinodesktoptextselectiontoolbar.dart | - | - |
| CupertinoDesktopTextSelectionToolbarButton | Desktop button | test_cupertino_cupertinodesktoptextselectiontoolbarbutton.dart | - | - |
| CupertinoSpellCheckSuggestionsToolbarButton | Spell button | test_cupertino_cupertinospellchecksuggestionstoolbarbutton.dart | - | - |
| CupertinoDatePickerMode | Picker mode | test_cupertino_cupertinodatepickermode.dart | - | - |
| CupertinoTimerPickerMode | Timer mode | test_cupertino_cupertinotimerpickermode.dart | - | - |
| DatePickerDateOrder | Date order | test_cupertino_datepickerdateorder.dart | - | - |
| DatePickerDateTimeOrder | DateTime order | test_cupertino_datepickerdatetimeorder.dart | - | - |
| CupertinoMenuDivider | Menu divider | test_cupertino_cupertinomenudivider.dart | - | - |
| CupertinoMenuItem | Menu item | test_cupertino_cupertinomenuitem.dart | - | - |
| CupertinoMenuLargeDivider | Large divider | test_cupertino_cupertinomenulargedivider.dart | - | - |
| CupertinoMenuTitle | Menu title | test_cupertino_cupertinomenutitle.dart | - | - |
| CupertinoPulldownMenuItem | Pulldown item | test_cupertino_cupertinopulldownmenuitem.dart | - | - |
| CupertinoPulldownMenuDivider | Pulldown divider | test_cupertino_cupertinopulldownmenudivider.dart | - | - |
| CupertinoPulldownMenuTitle | Pulldown title | test_cupertino_cupertinopulldownmenutitle.dart | - | - |
| CupertinoPulldownButton | Pulldown button | test_cupertino_cupertinopulldownbutton.dart | - | - |
| CupertinoMenuAnchor | Menu anchor | test_cupertino_cupertinomenuanchor.dart | - | - |
| CupertinoMenuTheme | Menu theme | test_cupertino_cupertinomenutheme.dart | - | - |
| CupertinoMenuThemeData | Menu theme data | test_cupertino_cupertinomenuthemedata.dart | - | - |
| CupertinoInheritedTheme | Inherited theme | test_cupertino_cupertinoinheritedtheme.dart | - | - |
| CupertinoUserInterfaceLevel | UI level | test_cupertino_cupertinouserinterfacelevel.dart | - | - |
| CupertinoUserInterfaceLevelData | UI level data | test_cupertino_cupertinouserinterfaceleveldata.dart | - | - |
| CupertinoOverrideTheme | Override theme | test_cupertino_cupertinooverridetheme.dart | - | - |
| CupertinoTextFieldConfiguration | Field config | test_cupertino_cupertinotextfieldconfiguration.dart | - | - |
| CupertinoTextFieldDecorator | Field decorator | test_cupertino_cupertinotextfielddecorator.dart | - | - |
| CupertinoTextFieldTheme | Field theme | test_cupertino_cupertinotextfieldtheme.dart | - | - |
| CupertinoTextFieldThemeData | Field theme data | test_cupertino_cupertinotextfieldthemedata.dart | - | - |
| CupertinoSwitchTheme | Switch theme | test_cupertino_cupertinoswitchtheme.dart | - | - |
| CupertinoSwitchThemeData | Switch theme data | test_cupertino_cupertinoswitchthemedata.dart | - | - |
| CupertinoCheckboxTheme | Checkbox theme | test_cupertino_cupertinocheckboxtheme.dart | - | - |
| CupertinoCheckboxThemeData | Checkbox data | test_cupertino_cupertinocheckboxthemedata.dart | - | - |
| CupertinoRadioTheme | Radio theme | test_cupertino_cupertinoradiotheme.dart | - | - |
| CupertinoRadioThemeData | Radio data | test_cupertino_cupertinoradiothemedata.dart | - | - |
| CupertinoSliderTheme | Slider theme | test_cupertino_cupertinoslidertheme.dart | - | - |
| CupertinoSliderThemeData | Slider data | test_cupertino_cupertinosliderthemedata.dart | - | - |
| CupertinoActivityIndicatorTheme | Indicator theme | test_cupertino_cupertinoactivityindicatortheme.dart | - | - |
| CupertinoActivityIndicatorThemeData | Indicator data | test_cupertino_cupertinoactivityindicatorthemedata.dart | - | - |
| CupertinoButtonTheme | Button theme | test_cupertino_cupertinobuttontheme.dart | - | - |
| CupertinoButtonThemeData | Button data | test_cupertino_cupertinobuttonthemedata.dart | - | - |
| CupertinoButtonConfig | Button config | test_cupertino_cupertinobuttonconfig.dart | - | - |
| CupertinoButtonColor | Button color | test_cupertino_cupertinobuttoncolor.dart | - | - |
| CupertinoTabBarTheme | Tab theme | test_cupertino_cupertinotabbartheme.dart | - | - |
| CupertinoTabBarThemeData | Tab data | test_cupertino_cupertinotabbarthemedata.dart | - | - |
| CupertinoNavigationBarTheme | Nav theme | test_cupertino_cupertinonavigationbartheme.dart | - | - |
| CupertinoNavigationBarThemeData | Nav data | test_cupertino_cupertinonavigationbarthemedata.dart | - | - |
| CupertinoListSectionTheme | List theme | test_cupertino_cupertinolistsectiontheme.dart | - | - |
| CupertinoListSectionThemeData | List data | test_cupertino_cupertinolistsectionthemedata.dart | - | - |
| CupertinoListTileTheme | Tile theme | test_cupertino_cupertinolisttiletheme.dart | - | - |
| CupertinoListTileThemeData | Tile data | test_cupertino_cupertinolisttilethemedata.dart | - | - |
| CupertinoFormSectionTheme | Form theme | test_cupertino_cupertinoformsectiontheme.dart | - | - |
| CupertinoFormSectionThemeData | Form data | test_cupertino_cupertinoformsectionthemedata.dart | - | - |
| CupertinoContextMenuTheme | Context theme | test_cupertino_cupertinocontextmenutheme.dart | - | - |
| CupertinoContextMenuThemeData | Context data | test_cupertino_cupertinocontextmenuthemedata.dart | - | - |
| CupertinoPickerTheme | Picker theme | test_cupertino_cupertinopickertheme.dart | - | - |
| CupertinoPickerThemeData | Picker data | test_cupertino_cupertinopickerthemedata.dart | - | - |
| CupertinoDatePickerTheme | Date theme | test_cupertino_cupertinodatepickertheme.dart | - | - |
| CupertinoDatePickerThemeData | Date data | test_cupertino_cupertinodatepickerthemedata.dart | - | - |
| CupertinoActionSheetTheme | Action theme | test_cupertino_cupertinoactionsheettheme.dart | - | - |
| CupertinoActionSheetThemeData | Action data | test_cupertino_cupertinoactionsheetthemedata.dart | - | - |
| CupertinoAlertDialogTheme | Alert theme | test_cupertino_cupertinoalertdialogtheme.dart | - | - |
| CupertinoAlertDialogThemeData | Alert data | test_cupertino_cupertinoalertdialogthemedata.dart | - | - |
| CupertinoScrollbarTheme | Scroll theme | test_cupertino_cupertinoscrollbartheme.dart | - | - |
| CupertinoScrollbarThemeData | Scroll data | test_cupertino_cupertinoscrollbarthemedata.dart | - | - |
| CupertinoIconTheme | Icon theme | test_cupertino_cupertinoicontheme.dart | - | - |
| CupertinoIconThemeData | Icon data | test_cupertino_cupertinoiconthemedata.dart | - | - |
| NoDefaultCupertinoThemeData | No default | test_cupertino_nodefaultcupertinothemedata.dart | - | - |
| MaterialBasedCupertinoThemeData | Material based | test_cupertino_materialbasedcupertinothemedata.dart | - | - |
| BottomTabBarVisibility | Tab visibility | test_cupertino_bottomtabbarvisibility.dart | - | - |
| CupertinoTabController | Tab controller | test_cupertino_cupertinotabcontroller.dart | - | - |
| CupertinoRouteTransitionMixin | Route mixin | test_cupertino_cupertinoroutetransitionmixin.dart | - | - |
| CupertinoPageScaffoldBackgroundColor | BG color | test_cupertino_cupertinopagescaffoldbackgroundcolor.dart | - | - |

---

## foundation (12 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| FlutterError | Error handling | test_foundation_fluttererror.dart | - | - |
| FlutterErrorDetails | Error details | test_foundation_fluttererrordetails.dart | - | - |
| ErrorDescription | Error description | test_foundation_errordescription.dart | - | - |
| ErrorHint | Error hints | test_foundation_errorhint.dart | - | - |
| ErrorSummary | Error summary | test_foundation_errorsummary.dart | - | - |
| DiagnosticsNode | Debug diagnostics | test_foundation_diagnosticsnode.dart | - | - |
| DiagnosticPropertiesBuilder | Building diagnostics | test_foundation_diagnosticpropertiesbuilder.dart | - | - |
| BindingBase | Binding base class | test_foundation_bindingbase.dart | - | - |
| LicenseEntry | License information | test_foundation_licenseentry.dart | - | - |
| LicenseEntryWithLineBreaks | License with formatting | test_foundation_licenseentrywithlinebreaks.dart | - | - |
| LicenseRegistry | License registry | test_foundation_licenseregistry.dart | - | - |
| LicenseParagraph | License paragraph | test_foundation_licenseparagraph.dart | - | - |

---

## painting (24 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| TextPainter | Low-level text rendering | test_painting_textpainter.dart | - | - |
| TextSelection | Text selection range | test_painting_textselection.dart | - | - |
| TextScaler | Text scaling | test_painting_textscaler.dart | - | - |
| TextAlignVertical | Vertical text alignment | test_painting_textalignvertical.dart | - | - |
| StrutStyle | Line height control | test_painting_strutstyle.dart | - | - |
| RoundedRectangleBorder | Rounded rectangle shape | test_painting_roundedrectangleborder.dart | - | - |
| CircleBorder | Circular shape | test_painting_circleborder.dart | - | - |
| StadiumBorder | Stadium/pill shape | test_painting_stadiumborder.dart | - | - |
| BeveledRectangleBorder | Beveled corners | test_painting_beveledrectangleborder.dart | - | - |
| ContinuousRectangleBorder | Smooth corners | test_painting_continuousrectangleborder.dart | - | - |
| OvalBorder | Oval shape | test_painting_ovalborder.dart | - | - |
| RadialGradient | Radial color gradients | test_painting_radialgradient.dart | - | - |
| SweepGradient | Angular gradients | test_painting_sweepgradient.dart | - | - |
| DecorationImage | Image in decoration | test_painting_decorationimage.dart | - | - |
| ShapeDecoration | Shape-based decoration | test_painting_shapedecoration.dart | - | - |
| ImageProvider | Base image provider | test_painting_imageprovider.dart | - | - |
| MemoryImage | In-memory images | test_painting_memoryimage.dart | - | - |
| FileImage | File-based images | test_painting_fileimage.dart | - | - |
| ExactAssetImage | Exact resolution assets | test_painting_exactassetimage.dart | - | - |
| FractionalOffset | Fractional positioning | test_painting_fractionaloffset.dart | - | - |
| HSLColor | HSL color representation | test_painting_hslcolor.dart | - | - |
| HSVColor | HSV color representation | test_painting_hsvcolor.dart | - | - |
| ColorSwatch | Color palette | test_painting_colorswatch.dart | - | - |
| Matrix4 | 4x4 transformation matrix | test_painting_matrix4.dart | - | - |

---

## rendering (60 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| RenderProxyBox | Proxy render box | test_rendering_renderproxybox.dart | - | - |
| RenderOpacity | Opacity render | test_rendering_renderopacity.dart | - | - |
| RenderTransform | Transform render | test_rendering_rendertransform.dart | - | - |
| RenderClipRect | Clip rect | test_rendering_rendercliprect.dart | - | - |
| RenderClipRRect | Clip rounded rect | test_rendering_rendercliprrect.dart | - | - |
| RenderClipOval | Clip oval | test_rendering_renderclipoval.dart | - | - |
| RenderClipPath | Clip path | test_rendering_renderclippath.dart | - | - |
| RenderImage | Image render | test_rendering_renderimage.dart | - | - |
| RenderParagraph | Text render | test_rendering_renderparagraph.dart | - | - |
| RenderShiftedBox | Shifted box | test_rendering_rendershiftedbox.dart | - | - |
| RenderAspectRatio | Aspect ratio | test_rendering_renderaspectratio.dart | - | - |
| RenderFittedBox | Fitted box | test_rendering_renderfittedbox.dart | - | - |
| RenderLimitedBox | Limited box | test_rendering_renderlimitedbox.dart | - | - |
| RenderIntrinsicWidth | Intrinsic width | test_rendering_renderintrinsicwidth.dart | - | - |
| RenderIntrinsicHeight | Intrinsic height | test_rendering_renderintrinsicheight.dart | - | - |
| RenderWrap | Wrap layout | test_rendering_renderwrap.dart | - | - |
| RenderTable | Table layout | test_rendering_rendertable.dart | - | - |
| RenderFlow | Flow layout | test_rendering_renderflow.dart | - | - |
| RenderListBody | List body | test_rendering_renderlistbody.dart | - | - |
| RenderView | Root view | test_rendering_renderview.dart | - | - |
| RenderViewport | Scroll viewport | test_rendering_renderviewport.dart | - | - |
| RenderSliver | Base sliver | test_rendering_rendersliver.dart | - | - |
| RenderSliverList | Sliver list | test_rendering_rendersliverlist.dart | - | - |
| RenderSliverGrid | Sliver grid | test_rendering_renderslivergrid.dart | - | - |
| RenderSliverPadding | Sliver padding | test_rendering_rendersliverpadding.dart | - | - |
| RenderSliverOpacity | Sliver opacity | test_rendering_rendersliveriopacity.dart | - | - |
| SliverConstraints | Sliver constraints | test_rendering_sliverconstraints.dart | - | - |
| SliverGeometry | Sliver geometry | test_rendering_slivergeometry.dart | - | - |
| SliverGridDelegate | Grid delegate | test_rendering_slivergriddelegate.dart | - | - |
| SliverGridDelegateWithFixedCrossAxisCount | Fixed count grid | test_rendering_slivergriddelegatewithfixedcrossaxiscount.dart | - | - |
| SliverGridDelegateWithMaxCrossAxisExtent | Max extent grid | test_rendering_slivergriddelegatewithmaxcrossaxisextent.dart | - | - |
| OpacityLayer | Opacity layer | test_rendering_opacitylayer.dart | - | - |
| TransformLayer | Transform layer | test_rendering_transformlayer.dart | - | - |
| ClipRectLayer | Clip rect layer | test_rendering_cliprectlayer.dart | - | - |
| ClipRRectLayer | Clip rounded layer | test_rendering_cliprrectlayer.dart | - | - |
| ImageFilterLayer | Image filter layer | test_rendering_imagefilterlayer.dart | - | - |
| BackdropFilterLayer | Backdrop filter | test_rendering_backdropfilterlayer.dart | - | - |
| RelativeRect | Relative positioning | test_rendering_relativerect.dart | - | - |
| BoxShadow | Box shadows | test_rendering_boxshadow.dart | - | - |
| Border | Border styling | test_rendering_border.dart | - | - |
| BorderSide | Border side | test_rendering_borderside.dart | - | - |
| LinearGradient | Linear gradient | test_rendering_lineargradient.dart | - | - |
| RadialGradient | Radial gradient | test_rendering_radialgradient.dart | - | - |
| Gradient | Base gradient | test_rendering_gradient.dart | - | - |
| ImageProvider | Image provider | test_rendering_imageprovider.dart | - | - |
| AssetImage | Asset images | test_rendering_assetimage.dart | - | - |
| NetworkImage | Network images | test_rendering_networkimage.dart | - | - |
| DecorationImage | Decoration image | test_rendering_decorationimage.dart | - | - |
| CustomPainter | Custom painting | test_rendering_custompainter.dart | - | - |
| CustomClipper | Custom clipping | test_rendering_customclipper.dart | - | - |
| SingleChildLayoutDelegate | Single layout | test_rendering_singlechildlayoutdelegate.dart | - | - |
| MultiChildLayoutDelegate | Multi layout | test_rendering_multichildlayoutdelegate.dart | - | - |
| FlowDelegate | Flow layout delegate | test_rendering_flowdelegate.dart | - | - |
| StackParentData | Stack parent data | test_rendering_stackparentdata.dart | - | - |
| FlexParentData | Flex parent data | test_rendering_flexparentdata.dart | - | - |
| SliverGridParentData | Grid parent data | test_rendering_slivergridparentdata.dart | - | - |
| TableColumnWidth | Table column width | test_rendering_tablecolumnwidth.dart | - | - |
| FixedColumnWidth | Fixed column | test_rendering_fixedcolumnwidth.dart | - | - |
| FlexColumnWidth | Flex column | test_rendering_flexcolumnwidth.dart | - | - |
| IntrinsicColumnWidth | Intrinsic column | test_rendering_intrinsiccolumnwidth.dart | - | - |

---

## animation (10 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| AnimationStyle | Animation styling | test_animation_animationstyle.dart | - | - |
| AlwaysStoppedAnimation | Static animation value | test_animation_alwaysstoppedanimation.dart | - | - |
| Animatable | Base animatable | test_animation_animatable.dart | - | - |
| CompoundAnimation | Combined animations | test_animation_compoundanimation.dart | - | - |
| ProxyAnimation | Animation proxy | test_animation_proxyanimation.dart | - | - |
| ReverseAnimation | Reversed animation | test_animation_reverseanimation.dart | - | - |
| TrainHoppingAnimation | Animation switching | test_animation_trainhoppinganimation.dart | - | - |
| TweenSequence | Sequenced tweens | test_animation_tweensequence.dart | - | - |
| TweenSequenceItem | Sequence item | test_animation_tweensequenceitem.dart | - | - |
| FlippedTweenSequence | Reversed sequence | test_animation_flippedtweensequence.dart | - | - |

---

## gestures (18 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| HorizontalDragGestureRecognizer | Horizontal drag | test_gestures_horizontaldraggesturerecognizer.dart | - | - |
| VerticalDragGestureRecognizer | Vertical drag | test_gestures_verticaldraggesturerecognizer.dart | - | - |
| PanGestureRecognizer | Pan gesture | test_gestures_pangesturerecognizer.dart | - | - |
| ScaleGestureRecognizer | Scale/pinch gesture | test_gestures_scalegesturerecognizer.dart | - | - |
| LongPressGestureRecognizer | Long press | test_gestures_longpressgesturerecognizer.dart | - | - |
| DoubleTapGestureRecognizer | Double tap | test_gestures_doubletapgesturerecognizer.dart | - | - |
| ForcePressGestureRecognizer | Force press (3D Touch) | test_gestures_forcepressgesturerecognizer.dart | - | - |
| ForcePressDetails | Force press info | test_gestures_forcepressdetails.dart | - | - |
| Velocity | Movement velocity | test_gestures_velocity.dart | - | - |
| GestureBinding | Gesture binding | test_gestures_gesturebinding.dart | - | - |
| PointerRouter | Event routing | test_gestures_pointerrouter.dart | - | - |
| HitTestResult | Hit testing result | test_gestures_hittestresult.dart | - | - |
| HitTestEntry | Hit test entry | test_gestures_hittestentry.dart | - | - |
| HitTestTarget | Hit test target | test_gestures_hittesttarget.dart | - | - |
| GestureArenaManager | Gesture disambiguation | test_gestures_gesturearenamanager.dart | - | - |
| GestureArenaEntry | Arena entry | test_gestures_gesturearenaentry.dart | - | - |
| GestureArenaMember | Arena member | test_gestures_gesturearenamenber.dart | - | - |
| GestureArenaTeam | Arena team | test_gestures_gesturearenateam.dart | - | - |

---

## services (25 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ServicesBinding | Services binding | test_services_servicesbinding.dart | - | - |
| SystemUiOverlayStyle | Status bar styling | test_services_systemuioverlaystyle.dart | - | - |
| BasicMessageChannel | Basic messaging | test_services_basicmessagechannel.dart | - | - |
| EventChannel | Stream events | test_services_eventchannel.dart | - | - |
| OptionalMethodChannel | Optional methods | test_services_optionalmethodchannel.dart | - | - |
| StandardMethodCodec | Standard codec | test_services_standardmethodcodec.dart | - | - |
| StandardMessageCodec | Standard messages | test_services_standardmessagecodec.dart | - | - |
| JSONMethodCodec | JSON codec | test_services_jsonmethodcodec.dart | - | - |
| JSONMessageCodec | JSON messages | test_services_jsonmessagecodec.dart | - | - |
| BinaryCodec | Binary codec | test_services_binarycodec.dart | - | - |
| StringCodec | String codec | test_services_stringcodec.dart | - | - |
| KeyboardInsertedContent | Keyboard content | test_services_keyboardinsertedcontent.dart | - | - |
| HardwareKeyboard | Keyboard events | test_services_hardwarekeyboard.dart | - | - |
| LogicalKeyboardKey | Logical keys | test_services_logicalkeyboardkey.dart | - | - |
| PhysicalKeyboardKey | Physical keys | test_services_physicalkeyboardkey.dart | - | - |
| MouseCursor | Mouse cursor | test_services_mousecursor.dart | - | - |
| SystemMouseCursor | System cursors | test_services_systemmousecursor.dart | - | - |
| SystemMouseCursors | Cursor constants | test_services_systemmousecursors.dart | - | - |
| TextBoundary | Text boundaries | test_services_textboundary.dart | - | - |
| CharacterBoundary | Character bounds | test_services_characterboundary.dart | - | - |
| LineBoundary | Line bounds | test_services_lineboundary.dart | - | - |
| ParagraphBoundary | Paragraph bounds | test_services_paragraphboundary.dart | - | - |
| DocumentBoundary | Document bounds | test_services_documentboundary.dart | - | - |
| TextEditingDelta | Editing changes | test_services_texteditingdelta.dart | - | - |
| SpellCheckResults | Spell check | test_services_spellcheckresults.dart | - | - |

---

## dart:ui (23 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| ParagraphStyle | Paragraph formatting | test_dart_ui_paragraphstyle.dart | - | - |
| ParagraphConstraints | Text layout constraints | test_dart_ui_paragraphconstraints.dart | - | - |
| StrutStyle | Line height control | test_dart_ui_strutstyle.dart | - | - |
| TextBox | Text measurement | test_dart_ui_textbox.dart | - | - |
| TextDecoration | Underline/strikethrough | test_dart_ui_textdecoration.dart | - | - |
| TextHeightBehavior | Line height behavior | test_dart_ui_textheightbehavior.dart | - | - |
| TextPosition | Cursor position in text | test_dart_ui_textposition.dart | - | - |
| TextRange | Text selection range | test_dart_ui_textrange.dart | - | - |
| ColorFilter | Color transformations | test_dart_ui_colorfilter.dart | - | - |
| ImageFilter | Blur and matrix effects | test_dart_ui_imagefilter.dart | - | - |
| MaskFilter | Blur effects | test_dart_ui_maskfilter.dart | - | - |
| Shader | Custom shaders | test_dart_ui_shader.dart | - | - |
| ImageShader | Image-based shaders | test_dart_ui_imageshader.dart | - | - |
| Picture | Recorded drawing commands | test_dart_ui_picture.dart | - | - |
| PictureRecorder | Recording canvas operations | test_dart_ui_picturerecorder.dart | - | - |
| Vertices | Custom vertex drawing | test_dart_ui_vertices.dart | - | - |
| FontFeature | OpenType font features | test_dart_ui_fontfeature.dart | - | - |
| FontVariation | Variable font axes | test_dart_ui_fontvariation.dart | - | - |
| LineMetrics | Text line measurements | test_dart_ui_linemetrics.dart | - | - |
| GlyphInfo | Individual glyph data | test_dart_ui_glyphinfo.dart | - | - |
| RSTransform | Rotation/scale transform | test_dart_ui_rstransform.dart | - | - |
| Tangent | Path tangent info | test_dart_ui_tangent.dart | - | - |
| ViewPadding | Safe area insets | test_dart_ui_viewpadding.dart | - | - |

---

## semantics (8 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SemanticsService | Accessibility services | test_semantics_semanticsservice.dart | - | - |
| SemanticsOwner | Semantics tree owner | test_semantics_semanticsowner.dart | - | - |
| SemanticsData | Accessibility data | test_semantics_semanticsdata.dart | - | - |
| SemanticsHintOverrides | Hint overrides | test_semantics_semanticshintoverrides.dart | - | - |
| SemanticsTag | Tagging for semantics | test_semantics_semanticstag.dart | - | - |
| SemanticsSortKey | Sort ordering | test_semantics_semanticssortkey.dart | - | - |
| OrdinalSortKey | Numeric sort key | test_semantics_ordinalsortkey.dart | - | - |
| AttributedString | Attributed text | test_semantics_attributedstring.dart | - | - |

---

## scheduler (3 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SchedulerBinding | Scheduler binding | test_scheduler_schedulerbinding.dart | - | - |
| TickerFuture | Ticker completion future | test_scheduler_tickerfuture.dart | - | - |
| TickerCanceled | Ticker cancellation | test_scheduler_tickercanceled.dart | - | - |

---

## physics (4 classes)

| Class | Description | Test File | Status | Result |
|-------|-------------|-----------|--------|--------|
| SpringSimulation | Spring physics simulation | test_physics_springsimulation.dart | - | - |
| ScrollSpringSimulation | Scroll spring physics | test_physics_scrollspringsimulation.dart | - | - |
| FrictionSimulation | Friction deceleration | test_physics_frictionsimulation.dart | - | - |
| Simulation | Base simulation class | test_physics_simulation.dart | - | - |

---

## Summary

| Package | Count |
|---------|-------|
| widgets | 120 |
| material | 180 |
| cupertino | 120 |
| foundation | 12 |
| painting | 24 |
| rendering | 60 |
| animation | 10 |
| gestures | 18 |
| services | 25 |
| dart:ui | 23 |
| semantics | 8 |
| scheduler | 3 |
| physics | 4 |
| **Total** | **607** |
