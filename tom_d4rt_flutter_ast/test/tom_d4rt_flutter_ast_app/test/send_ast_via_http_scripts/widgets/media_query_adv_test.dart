// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element, sort_child_properties_last
// D4rt test script: Deep Demo - MediaQuery Advanced Patterns
// Comprehensive demonstration of MediaQueryData, MediaQuery static helpers,
// override scopes (removePadding / removeViewInsets / removeViewPadding /
// copyWith), the granular .xxxOf(context) accessors, plus comparison with
// LayoutBuilder and OrientationBuilder.
import 'dart:ui' show DisplayFeature;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: DOSSIER — Read the actual ambient MediaQueryData
  // ============================================================================

  final liveMq = MediaQuery.of(context);

  final dossier = <Map<String, dynamic>>[
    {
      'topic': 'What is MediaQuery?',
      'detail':
          'An InheritedWidget that exposes information about the current '
          'media (the size of the window, padding from system intrusions, '
          'platform brightness, and accessibility settings).',
    },
    {
      'topic': 'When to read it?',
      'detail':
          'Whenever your layout must adapt to physical screen properties: '
          'phone vs tablet sizing, dark mode awareness, padding around '
          'notches, or the keyboard intrusion height.',
    },
    {
      'topic': 'Performance pitfall',
      'detail':
          'MediaQuery.of(context) subscribes the caller to ALL MediaQueryData '
          'changes. Prefer the granular .sizeOf, .paddingOf, '
          '.platformBrightnessOf helpers — they rebuild only when that single '
          'aspect changes.',
    },
    {
      'topic': 'Override scopes',
      'detail':
          'MediaQuery(data: ..., child: ...) creates a synthetic scope; '
          'descendant widgets see the new data. Used widely by Scaffold to '
          'hide consumed insets from children.',
    },
    {
      'topic': 'Removal constructors',
      'detail':
          'MediaQuery.removePadding / removeViewInsets / removeViewPadding '
          'wrap a child with a scope where chosen sides are zeroed — '
          'preventing double-counting of safe-area insets.',
    },
  ];

  // ============================================================================
  // SECTION 2: ANATOMY — Every MediaQueryData field, what it is, who writes it
  // ============================================================================

  final anatomy = <Map<String, String>>[
    {
      'field': 'size',
      'type': 'Size',
      'origin': 'Window logical size',
      'note': 'Width and height of the physical viewport in logical pixels.',
    },
    {
      'field': 'devicePixelRatio',
      'type': 'double',
      'origin': 'Display engine',
      'note': 'Physical pixels per logical pixel. Drives Image asset choice.',
    },
    {
      'field': 'textScaler',
      'type': 'TextScaler',
      'origin': 'OS accessibility',
      'note': 'Replaces textScaleFactor — non-linear text scaling supported.',
    },
    {
      'field': 'platformBrightness',
      'type': 'Brightness',
      'origin': 'OS theme',
      'note': 'Light or dark — drives ThemeMode.system resolution.',
    },
    {
      'field': 'padding',
      'type': 'EdgeInsets',
      'origin': 'Hardware notches/bars',
      'note': 'Persistent safe areas (e.g. status bar, home indicator).',
    },
    {
      'field': 'viewInsets',
      'type': 'EdgeInsets',
      'origin': 'Transient intrusions',
      'note': 'Soft keyboard. Subtract from layout to keep content visible.',
    },
    {
      'field': 'viewPadding',
      'type': 'EdgeInsets',
      'origin': 'OS UI overlay',
      'note': 'Physical padding ignoring transient insets like keyboard.',
    },
    {
      'field': 'systemGestureInsets',
      'type': 'EdgeInsets',
      'origin': 'Gesture nav',
      'note': 'Regions where OS may consume gestures (back swipe).',
    },
    {
      'field': 'alwaysUse24HourFormat',
      'type': 'bool',
      'origin': 'Locale',
      'note': 'User prefers 24h clock display.',
    },
    {
      'field': 'accessibleNavigation',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'A screen reader / similar a11y tool is active.',
    },
    {
      'field': 'invertColors',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'OS-level color inversion is enabled.',
    },
    {
      'field': 'highContrast',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'User prefers increased contrast.',
    },
    {
      'field': 'onOffSwitchLabels',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'User wants explicit on/off labels for switches.',
    },
    {
      'field': 'disableAnimations',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'Reduce-motion preference.',
    },
    {
      'field': 'boldText',
      'type': 'bool',
      'origin': 'A11y',
      'note': 'User wants increased font weight.',
    },
    {
      'field': 'navigationMode',
      'type': 'NavigationMode',
      'origin': 'Theme',
      'note': 'traditional vs directional focus.',
    },
    {
      'field': 'orientation',
      'type': 'Orientation',
      'origin': 'Derived from size',
      'note': 'portrait if height >= width, else landscape.',
    },
    {
      'field': 'displayFeatures',
      'type': 'List<DisplayFeature>',
      'origin': 'Foldables',
      'note': 'Hinges/folds geometry for dual-screen devices.',
    },
  ];

  // ============================================================================
  // SECTION 3: LIVE INSPECTOR — read from MediaQuery.of and from .xxxOf
  // ============================================================================

  final inspector = <Map<String, String>>[
    {
      'label': 'size (via of)',
      'value':
          '${liveMq.size.width.toStringAsFixed(1)} × '
          '${liveMq.size.height.toStringAsFixed(1)}',
      'helper': 'MediaQuery.of(context).size',
    },
    {
      'label': 'size (via sizeOf)',
      'value':
          '${MediaQuery.sizeOf(context).width.toStringAsFixed(1)} × '
          '${MediaQuery.sizeOf(context).height.toStringAsFixed(1)}',
      'helper': 'MediaQuery.sizeOf(context)',
    },
    {
      'label': 'devicePixelRatio',
      'value': liveMq.devicePixelRatio.toStringAsFixed(2),
      'helper': 'MediaQuery.devicePixelRatioOf(context)',
    },
    {
      'label': 'textScaler (via of)',
      'value': liveMq.textScaler.toString(),
      'helper': 'MediaQuery.of(context).textScaler',
    },
    {
      'label': 'textScaler (via textScalerOf)',
      'value': MediaQuery.textScalerOf(context).toString(),
      'helper': 'MediaQuery.textScalerOf(context)',
    },
    {
      'label': 'platformBrightness',
      'value': MediaQuery.platformBrightnessOf(context).name,
      'helper': 'MediaQuery.platformBrightnessOf(context)',
    },
    {
      'label': 'padding',
      'value': MediaQuery.paddingOf(context).toString(),
      'helper': 'MediaQuery.paddingOf(context)',
    },
    {
      'label': 'viewInsets',
      'value': MediaQuery.viewInsetsOf(context).toString(),
      'helper': 'MediaQuery.viewInsetsOf(context)',
    },
    {
      'label': 'viewPadding',
      'value': MediaQuery.viewPaddingOf(context).toString(),
      'helper': 'MediaQuery.viewPaddingOf(context)',
    },
    {
      'label': 'orientation',
      'value': MediaQuery.orientationOf(context).name,
      'helper': 'MediaQuery.orientationOf(context)',
    },
    {
      'label': 'systemGestureInsets',
      'value': liveMq.systemGestureInsets.toString(),
      'helper': 'MediaQuery.of(context).systemGestureInsets',
    },
    {
      'label': 'alwaysUse24HourFormat',
      'value': liveMq.alwaysUse24HourFormat.toString(),
      'helper': 'MediaQuery.alwaysUse24HourFormatOf',
    },
    {
      'label': 'accessibleNavigation',
      'value': liveMq.accessibleNavigation.toString(),
      'helper': 'MediaQuery.accessibleNavigationOf',
    },
    {
      'label': 'invertColors',
      'value': liveMq.invertColors.toString(),
      'helper': 'MediaQuery.invertColorsOf',
    },
    {
      'label': 'highContrast',
      'value': liveMq.highContrast.toString(),
      'helper': 'MediaQuery.highContrastOf',
    },
    {
      'label': 'disableAnimations',
      'value': liveMq.disableAnimations.toString(),
      'helper': 'MediaQuery.disableAnimationsOf',
    },
    {
      'label': 'boldText',
      'value': liveMq.boldText.toString(),
      'helper': 'MediaQuery.boldTextOf',
    },
    {
      'label': 'navigationMode',
      'value': liveMq.navigationMode.name,
      'helper': 'MediaQuery.navigationModeOf',
    },
    {
      'label': 'displayFeatures',
      'value': '${liveMq.displayFeatures.length} feature(s)',
      'helper': 'MediaQuery.of(context).displayFeatures',
    },
  ];

  // Also probe maybeOf — useful when no MediaQuery is present.
  final maybeOf = MediaQuery.maybeOf(context);
  final maybeOfResult = maybeOf != null
      ? 'present (size=${maybeOf.size})'
      : 'null';

  // ============================================================================
  // SECTION 4: OVERRIDE DEMOS — synthetic MediaQueryData via MediaQuery widget
  // ============================================================================

  final overrides = <Map<String, dynamic>>[
    {
      'name': 'Tablet portrait',
      'size': Size(820.0, 1180.0),
      'dpr': 2.0,
      'scale': 1.0,
      'brightness': Brightness.light,
    },
    {
      'name': 'Phone landscape',
      'size': Size(844.0, 390.0),
      'dpr': 3.0,
      'scale': 1.0,
      'brightness': Brightness.light,
    },
    {
      'name': 'Desktop window',
      'size': Size(1440.0, 900.0),
      'dpr': 1.0,
      'scale': 1.0,
      'brightness': Brightness.light,
    },
    {
      'name': 'A11y large text',
      'size': Size(412.0, 892.0),
      'dpr': 2.75,
      'scale': 1.6,
      'brightness': Brightness.light,
    },
    {
      'name': 'Dark mode small',
      'size': Size(360.0, 640.0),
      'dpr': 2.0,
      'scale': 0.9,
      'brightness': Brightness.dark,
    },
  ];

  // ============================================================================
  // SECTION 5: REMOVE PADDING / VIEW INSETS / VIEW PADDING SHOWCASE
  // ============================================================================

  // Synthesize a base MediaQueryData that has chunky paddings/insets so the
  // before/after contrast is clearly visible.
  final synthBase = MediaQueryData(
    size: Size(360.0, 640.0),
    devicePixelRatio: 2.0,
    textScaler: TextScaler.linear(1.0),
    platformBrightness: Brightness.light,
    padding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 28.0),
    viewPadding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 28.0),
    viewInsets: EdgeInsets.only(bottom: 280.0),
    systemGestureInsets: EdgeInsets.symmetric(horizontal: 20.0),
    alwaysUse24HourFormat: false,
    accessibleNavigation: false,
    invertColors: false,
    highContrast: false,
    onOffSwitchLabels: false,
    disableAnimations: false,
    boldText: false,
    navigationMode: NavigationMode.traditional,
    displayFeatures: <DisplayFeature>[],
  );

  final removalDemos = <Map<String, dynamic>>[
    {
      'title': 'baseline',
      'padding': synthBase.padding.toString(),
      'viewInsets': synthBase.viewInsets.toString(),
      'viewPadding': synthBase.viewPadding.toString(),
    },
    {
      'title': 'removePadding(top)',
      'padding': synthBase.removePadding(removeTop: true).padding.toString(),
      'viewInsets': synthBase
          .removePadding(removeTop: true)
          .viewInsets
          .toString(),
      'viewPadding': synthBase
          .removePadding(removeTop: true)
          .viewPadding
          .toString(),
    },
    {
      'title': 'removePadding(all)',
      'padding': synthBase
          .removePadding(
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: true,
          )
          .padding
          .toString(),
      'viewInsets': synthBase
          .removePadding(
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: true,
          )
          .viewInsets
          .toString(),
      'viewPadding': synthBase
          .removePadding(
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: true,
          )
          .viewPadding
          .toString(),
    },
    {
      'title': 'removeViewInsets(bottom)',
      'padding': synthBase
          .removeViewInsets(removeBottom: true)
          .padding
          .toString(),
      'viewInsets': synthBase
          .removeViewInsets(removeBottom: true)
          .viewInsets
          .toString(),
      'viewPadding': synthBase
          .removeViewInsets(removeBottom: true)
          .viewPadding
          .toString(),
    },
    {
      'title': 'removeViewPadding(top)',
      'padding': synthBase
          .removeViewPadding(removeTop: true)
          .padding
          .toString(),
      'viewInsets': synthBase
          .removeViewPadding(removeTop: true)
          .viewInsets
          .toString(),
      'viewPadding': synthBase
          .removeViewPadding(removeTop: true)
          .viewPadding
          .toString(),
    },
  ];

  // ============================================================================
  // SECTION 6: COPYWITH CASCADE — apply transformations and snapshot each step
  // ============================================================================

  final step0 = synthBase;
  final step1 = step0.copyWith(size: Size(720.0, 1280.0));
  final step2 = step1.copyWith(platformBrightness: Brightness.dark);
  final step3 = step2.copyWith(textScaler: TextScaler.linear(1.3));
  final step4 = step3.copyWith(
    padding: EdgeInsets.zero,
    viewInsets: EdgeInsets.zero,
  );
  final step5 = step4.copyWith(
    boldText: true,
    highContrast: true,
    accessibleNavigation: true,
  );

  final cascade = <Map<String, dynamic>>[
    {'step': 0, 'label': 'start', 'data': step0},
    {'step': 1, 'label': '+ resize 720x1280', 'data': step1},
    {'step': 2, 'label': '+ dark brightness', 'data': step2},
    {'step': 3, 'label': '+ 1.3x text', 'data': step3},
    {'step': 4, 'label': '+ zero insets', 'data': step4},
    {'step': 5, 'label': '+ a11y bundle', 'data': step5},
  ];

  // ============================================================================
  // SECTION 7: ORIENTATION SWITCHER — portrait vs landscape comparison
  // ============================================================================

  final orientationDemos = <Map<String, dynamic>>[
    {
      'size': Size(412.0, 892.0),
      'expected': Orientation.portrait,
      'label': 'tall phone',
    },
    {
      'size': Size(892.0, 412.0),
      'expected': Orientation.landscape,
      'label': 'rotated phone',
    },
    {
      'size': Size(820.0, 1180.0),
      'expected': Orientation.portrait,
      'label': 'tablet portrait',
    },
    {
      'size': Size(1180.0, 820.0),
      'expected': Orientation.landscape,
      'label': 'tablet landscape',
    },
    {
      'size': Size(640.0, 640.0),
      'expected': Orientation.portrait,
      'label': 'square (tie)',
    },
  ];

  // ============================================================================
  // SECTION 8: LAYOUTBUILDER vs MediaQuery.sizeOf
  // ============================================================================

  final lbVsMq = <Map<String, String>>[
    {
      'aspect': 'Scope',
      'mediaQuery': 'window-level — every consumer sees the same size',
      'layoutBuilder': 'parent-imposed — sees only the constraints we receive',
    },
    {
      'aspect': 'Rebuild trigger',
      'mediaQuery': 'rebuilds on any MediaQueryData change',
      'layoutBuilder': 'rebuilds on parent constraint changes',
    },
    {
      'aspect': 'Use for',
      'mediaQuery': 'global breakpoints (phone vs tablet)',
      'layoutBuilder': 'fine-grained per-region adaptive layout',
    },
    {
      'aspect': 'Cheap variant',
      'mediaQuery': 'MediaQuery.sizeOf — aspect-scoped',
      'layoutBuilder': 'always recomputes per layout pass',
    },
    {
      'aspect': 'Safe areas',
      'mediaQuery': 'aware (padding / viewInsets)',
      'layoutBuilder': 'unaware — must combine with MediaQuery.paddingOf',
    },
  ];

  // ============================================================================
  // SECTION 9: RECIPE CARDS — practical patterns
  // ============================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'R1 — Adaptive breakpoint',
      'snippet':
          'final w = MediaQuery.sizeOf(context).width;\n'
          'final isWide = w >= 600.0;\n'
          'return isWide ? WideLayout() : NarrowLayout();',
      'note':
          'sizeOf re-runs only when size actually changes — perfect for app '
          'shells that switch between rail and bottom-nav.',
    },
    {
      'title': 'R2 — Keyboard-aware bottom padding',
      'snippet':
          'final kb = MediaQuery.viewInsetsOf(context).bottom;\n'
          'return Padding(\n'
          '  padding: EdgeInsets.only(bottom: kb),\n'
          '  child: child,\n'
          ');',
      'note':
          'viewInsets.bottom is the soft-keyboard height. Useful for floating '
          'composers that should sit above the keyboard.',
    },
    {
      'title': 'R3 — Theme-from-platform brightness',
      'snippet':
          'final b = MediaQuery.platformBrightnessOf(context);\n'
          'final colors = b == Brightness.dark ? darkColors : lightColors;',
      'note':
          'Subscribes only to brightness — your widget never rebuilds on size '
          'changes.',
    },
    {
      'title': 'R4 — Respect text-scale accessibility',
      'snippet':
          'final ts = MediaQuery.textScalerOf(context);\n'
          'return Text(label, textScaler: ts);',
      'note':
          'Never hard-code textScaleFactor:1.0 — it overrides accessibility '
          'preferences. Use textScalerOf instead.',
    },
    {
      'title': 'R5 — Strip padding for a sub-tree',
      'snippet':
          'return MediaQuery.removePadding(\n'
          '  context: context,\n'
          '  removeTop: true,\n'
          '  child: ListView(...),\n'
          ');',
      'note':
          'Prevents a nested ListView from double-counting status bar '
          'padding when its parent already accounted for it.',
    },
    {
      'title': 'R6 — Override DPR for a screenshot',
      'snippet':
          'return MediaQuery(\n'
          '  data: MediaQuery.of(context).copyWith(\n'
          '    devicePixelRatio: 1.0,\n'
          '  ),\n'
          '  child: child,\n'
          ');',
      'note':
          'Useful for snapshot golden tests where you want crisp 1:1 rendering '
          'regardless of host DPR.',
    },
    {
      'title': 'R7 — Square-aware orientation',
      'snippet':
          'final o = MediaQuery.orientationOf(context);\n'
          'return Flex(\n'
          '  direction: o == Orientation.landscape\n'
          '      ? Axis.horizontal : Axis.vertical,\n'
          '  children: ...);',
      'note':
          'Orientation flips on rotation — orientationOf scopes the rebuild '
          'to just that aspect.',
    },
    {
      'title': 'R8 — Safe-area aware Container',
      'snippet':
          'final p = MediaQuery.paddingOf(context);\n'
          'return Padding(padding: p, child: child);',
      'note':
          'When SafeArea is too heavy or you want to scope a single side, '
          'paddingOf is the leanest hook.',
    },
  ];

  // ============================================================================
  // SECTION 10: COMPARISON TABLE — read-via-of / read-via-sizeOf / LayoutBuilder
  // ============================================================================

  final comparison = <Map<String, String>>[
    {
      'method': 'MediaQuery.of(ctx)',
      'reads': 'ALL fields',
      'rebuilds': 'On any MediaQueryData change',
      'cost': 'Expensive — wide subscription',
    },
    {
      'method': 'MediaQuery.sizeOf(ctx)',
      'reads': 'size only',
      'rebuilds': 'On size change',
      'cost': 'Cheap — narrow aspect',
    },
    {
      'method': 'MediaQuery.paddingOf(ctx)',
      'reads': 'padding only',
      'rebuilds': 'On padding change',
      'cost': 'Cheap — narrow aspect',
    },
    {
      'method': 'MediaQuery.viewInsetsOf(ctx)',
      'reads': 'viewInsets only',
      'rebuilds': 'On viewInsets change (keyboard)',
      'cost': 'Cheap — narrow aspect',
    },
    {
      'method': 'MediaQuery.platformBrightnessOf(ctx)',
      'reads': 'brightness only',
      'rebuilds': 'On brightness change',
      'cost': 'Cheap — narrow aspect',
    },
    {
      'method': 'MediaQuery.orientationOf(ctx)',
      'reads': 'orientation only',
      'rebuilds': 'On rotation',
      'cost': 'Cheap — narrow aspect',
    },
    {
      'method': 'LayoutBuilder',
      'reads': 'parent constraints',
      'rebuilds': 'On layout pass',
      'cost': 'Per-region — independent of MediaQuery',
    },
    {
      'method': 'OrientationBuilder',
      'reads': 'orientation from parent',
      'rebuilds': 'On orientation flip via layout',
      'cost': 'Layout-derived, not MediaQuery-derived',
    },
  ];

  // ============================================================================
  // SECTION 11: GLOSSARY
  // ============================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'Logical pixel',
      'meaning':
          'Resolution-independent unit. Multiply by devicePixelRatio to get '
          'physical pixels.',
    },
    {
      'term': 'Safe area',
      'meaning':
          'The region of the screen not obscured by hardware features (notches, '
          'rounded corners) or system UI (status / nav bars).',
    },
    {
      'term': 'View insets',
      'meaning':
          'Transient intrusions, primarily the soft keyboard. Vary over time.',
    },
    {
      'term': 'View padding',
      'meaning':
          'The full safe-area padding ignoring keyboard intrusions. '
          'paddingOf == viewPaddingOf when keyboard is closed.',
    },
    {
      'term': 'Text scaler',
      'meaning':
          'Non-linear text scaling function. Modern replacement for the '
          'deprecated textScaleFactor scalar.',
    },
    {
      'term': 'Display feature',
      'meaning':
          'Hardware regions like folds or hinges on dual-screen / foldable '
          'devices.',
    },
    {
      'term': 'maybeOf',
      'meaning':
          'Returns null when no MediaQuery is present, rather than asserting. '
          'Useful in tests and ungrounded subtrees.',
    },
    {
      'term': 'Aspect subscription',
      'meaning':
          'Pattern of subscribing only to a single field, implemented by the '
          'xxxOf static helpers. Reduces unnecessary rebuilds.',
    },
    {
      'term': 'Removal scope',
      'meaning':
          'A MediaQuery sub-tree where specific sides of padding / viewInsets / '
          'viewPadding have been zeroed for descendants.',
    },
    {
      'term': 'NavigationMode',
      'meaning':
          'traditional vs directional focus traversal — affects how the focus '
          'system interprets arrow keys.',
    },
  ];

  // ============================================================================
  // BUILD UI
  // ============================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== HEADER =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF004D40), Color(0xFF00796B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MediaQuery — Advanced',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Deep Demo: every field, every helper, '
                        'every override',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFB2DFDB),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: [
                          _pill('MediaQueryData'),
                          _pill('of / maybeOf'),
                          _pill('sizeOf / paddingOf'),
                          _pill('removePadding'),
                          _pill('copyWith'),
                          _pill('orientationOf'),
                          _pill('LayoutBuilder'),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.0),

                // ===== SECTION 1: DOSSIER =====
                _sectionTitle('1. Dossier — what MediaQuery does for you'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF80CBC4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final d in dossier)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00796B),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      d['topic'] as String,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF004D40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  d['detail'] as String,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    height: 1.45,
                                    color: Color(0xFF263238),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 2: ANATOMY =====
                _sectionTitle('2. Anatomy of MediaQueryData'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFB0BEC5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'field',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'type',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'origin',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              'note',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      for (final a in anatomy)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  a['field']!,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004D40),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  a['type']!,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontFamily: 'monospace',
                                    color: Color(0xFF1565C0),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  a['origin']!,
                                  style: TextStyle(fontSize: 10.5),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  a['note']!,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    height: 1.4,
                                    color: Color(0xFF455A64),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 3: LIVE INSPECTOR =====
                _sectionTitle('3. Live inspector — values from THIS context'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFFFD54F)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MediaQuery.maybeOf(context) → $maybeOfResult',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6D4C41),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      for (final row in inspector)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Color(0xFFFFE082)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    row['label']!,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D4037),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    row['value']!,
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF1A237E),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    row['helper']!,
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF6D4C41),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 4: OVERRIDE DEMOS =====
                _sectionTitle(
                  '4. Override demos — synthesize MediaQueryData scopes',
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF9FA8DA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Each card wraps a Builder in MediaQuery(data: …). '
                        'The Builder reads via MediaQuery.of and reports back '
                        'what it sees — proving the override is local.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF303F9F),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      for (final ov in overrides)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: MediaQuery(
                            data: MediaQueryData(
                              size: ov['size'] as Size,
                              devicePixelRatio: ov['dpr'] as double,
                              textScaler: TextScaler.linear(
                                ov['scale'] as double,
                              ),
                              platformBrightness: ov['brightness'] as Brightness,
                              padding: EdgeInsets.zero,
                              viewInsets: EdgeInsets.zero,
                              viewPadding: EdgeInsets.zero,
                              systemGestureInsets: EdgeInsets.zero,
                              alwaysUse24HourFormat: false,
                              accessibleNavigation: false,
                              invertColors: false,
                              highContrast: false,
                              onOffSwitchLabels: false,
                              disableAnimations: false,
                              boldText: false,
                              navigationMode: NavigationMode.traditional,
                              displayFeatures: <DisplayFeature>[],
                            ),
                            child: Builder(
                              builder: (ctx) {
                                final m = MediaQuery.of(ctx);
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            ov['name'] as String,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1A237E),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.0,
                                              vertical: 2.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: m.platformBrightness ==
                                                      Brightness.dark
                                                  ? Color(0xFF263238)
                                                  : Color(0xFFFFE082),
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Text(
                                              m.platformBrightness.name,
                                              style: TextStyle(
                                                fontSize: 9.0,
                                                color:
                                                    m.platformBrightness ==
                                                            Brightness.dark
                                                        ? Color(0xFFFFFFFF)
                                                        : Color(0xFF5D4037),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.0),
                                      Text(
                                        'size=${m.size.width.toStringAsFixed(0)}'
                                        '×${m.size.height.toStringAsFixed(0)}'
                                        '  dpr=${m.devicePixelRatio}'
                                        '  scaler=${m.textScaler}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'orientation=${m.orientation.name}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                          color: Color(0xFF00695C),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 5: REMOVAL SCOPES =====
                _sectionTitle(
                  '5. removePadding / removeViewInsets / removeViewPadding',
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFEF9A9A)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baseline synthetic MediaQueryData with status-bar '
                        'padding, soft-keyboard inset, and view-padding. '
                        'Each row shows the result of applying a removal.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'op',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'padding',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'viewInsets',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'viewPadding',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Color(0xFFEF9A9A)),
                      for (final r in removalDemos)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  r['title'] as String,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    color: Color(0xFFB71C1C),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['padding'] as String,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['viewInsets'] as String,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['viewPadding'] as String,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 12.0),
                      // Side-by-side widget showcase via the actual widget
                      // constructors.
                      Text(
                        'Widget-level constructors (descendants see zeroed sides):',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      MediaQuery(
                        data: synthBase,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: Builder(
                                builder: (c) => _removalRow(
                                  'removePadding(top+bottom)',
                                  MediaQuery.paddingOf(c).toString(),
                                ),
                              ),
                            ),
                            MediaQuery.removeViewInsets(
                              context: context,
                              removeBottom: true,
                              child: Builder(
                                builder: (c) => _removalRow(
                                  'removeViewInsets(bottom)',
                                  MediaQuery.viewInsetsOf(c).toString(),
                                ),
                              ),
                            ),
                            MediaQuery.removeViewPadding(
                              context: context,
                              removeLeft: true,
                              removeRight: true,
                              child: Builder(
                                builder: (c) => _removalRow(
                                  'removeViewPadding(left+right)',
                                  MediaQuery.viewPaddingOf(c).toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 6: COPYWITH CASCADE =====
                _sectionTitle('6. copyWith cascade'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFCE93D8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final c in cascade)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF7B1FA2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${c['step']}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        c['label'] as String,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4A148C),
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'size=${(c['data'] as MediaQueryData).size}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      Text(
                                        'brightness='
                                        '${(c['data'] as MediaQueryData).platformBrightness.name}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      Text(
                                        'textScaler='
                                        '${(c['data'] as MediaQueryData).textScaler}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      Text(
                                        'padding='
                                        '${(c['data'] as MediaQueryData).padding}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      Text(
                                        'boldText='
                                        '${(c['data'] as MediaQueryData).boldText}'
                                        '  highContrast='
                                        '${(c['data'] as MediaQueryData).highContrast}',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 7: ORIENTATION SWITCHER =====
                _sectionTitle('7. Orientation switcher'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF90CAF9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Each row uses a synthetic MediaQuery(size: …) and an '
                        'OrientationBuilder that reports its parent-derived '
                        'orientation. The MediaQuery.orientationOf result is '
                        'shown alongside.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      for (final o in orientationDemos)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: MediaQuery(
                            data: synthBase.copyWith(size: o['size'] as Size),
                            child: Builder(
                              builder: (ctx) {
                                final ori = MediaQuery.orientationOf(ctx);
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          o['label'] as String,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          (o['size'] as Size).toString(),
                                          style: TextStyle(
                                            fontSize: 10.5,
                                            fontFamily: 'monospace',
                                          ),
                                        ),
                                      ),
                                      _badge(
                                        ori.name,
                                        ori == Orientation.portrait
                                            ? Color(0xFF1976D2)
                                            : Color(0xFFF57C00),
                                      ),
                                      SizedBox(width: 6.0),
                                      _badge(
                                        ori == (o['expected'] as Orientation)
                                            ? 'OK'
                                            : 'X',
                                        ori == (o['expected'] as Orientation)
                                            ? Color(0xFF4CAF50)
                                            : Color(0xFFF44336),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 8: LAYOUTBUILDER vs MEDIAQUERY =====
                _sectionTitle('8. LayoutBuilder vs MediaQuery.sizeOf'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F8E9),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFAED581)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'aspect',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'MediaQuery.sizeOf',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF33691E),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'LayoutBuilder',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6A1B9A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      for (final row in lbVsMq)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  row['aspect']!,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  row['mediaQuery']!,
                                  style: TextStyle(fontSize: 10.5),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  row['layoutBuilder']!,
                                  style: TextStyle(fontSize: 10.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 10.0),
                      // Live demo: LayoutBuilder + MediaQuery side-by-side.
                      Container(
                        height: 80.0,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: LayoutBuilder(
                          builder: (ctx, constraints) {
                            final mq = MediaQuery.sizeOf(ctx);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LayoutBuilder constraints: '
                                  '${constraints.maxWidth.toStringAsFixed(1)} × '
                                  '${constraints.maxHeight.toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color(0xFF6A1B9A),
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'MediaQuery.sizeOf: '
                                  '${mq.width.toStringAsFixed(1)} × '
                                  '${mq.height.toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color(0xFF33691E),
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  '⇒ they differ — the LB sees only what its '
                                  'parent grants, MQ sees the full window.',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF455A64),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 9: RECIPE CARDS =====
                _sectionTitle('9. Recipe cards'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEBE9),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFA1887F)),
                  ),
                  child: Column(
                    children: [
                      for (final r in recipes)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Color(0xFFD7CCC8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r['title']!,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4E342E),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF263238),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    r['snippet']!,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontFamily: 'monospace',
                                      color: Color(0xFFB0BEC5),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  r['note']!,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color(0xFF5D4037),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 10: COMPARISON TABLE =====
                _sectionTitle('10. Comparison — accessor cost matrix'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFB0BEC5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              'method',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'reads',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'rebuilds',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'cost',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      for (final r in comparison)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['method']!,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1565C0),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  r['reads']!,
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['rebuilds']!,
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  r['cost']!,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF455A64),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 11: GLOSSARY =====
                _sectionTitle('11. Glossary'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE1F5FE),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF81D4FA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final g in glossary)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140.0,
                                child: Text(
                                  g['term']!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF01579B),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  g['meaning']!,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    height: 1.45,
                                    color: Color(0xFF263238),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 12: FINAL COMPOSED TREE =====
                _sectionTitle('12. Final composed tree — overrides in action'),
                MediaQuery(
                  data: synthBase.copyWith(
                    size: Size(420.0, 720.0),
                    platformBrightness: Brightness.dark,
                    textScaler: TextScaler.linear(1.2),
                  ),
                  child: Builder(
                    builder: (ctx) {
                      final m = MediaQuery.of(ctx);
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF263238),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Composed override scope',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB2EBF2),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'inside this MediaQuery, descendants see:',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF80CBC4),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            _darkInfoRow('size', '${m.size}'),
                            _darkInfoRow('brightness', m.platformBrightness.name),
                            _darkInfoRow('textScaler', m.textScaler.toString()),
                            _darkInfoRow('padding', m.padding.toString()),
                            _darkInfoRow('orientation', m.orientation.name),
                            SizedBox(height: 12.0),
                            // A nested removePadding inside the override.
                            MediaQuery.removePadding(
                              context: ctx,
                              removeTop: true,
                              removeBottom: true,
                              child: Builder(
                                builder: (c2) {
                                  final inner = MediaQuery.paddingOf(c2);
                                  return Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF37474F),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      'nested removePadding(top+bottom) ⇒ '
                                      'padding=$inner',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontFamily: 'monospace',
                                        color: Color(0xFFB0BEC5),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SUMMARY =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF004D40), Color(0xFF00796B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      _summaryItem('MediaQuery.of read', 'OK'),
                      _summaryItem('MediaQuery.maybeOf', 'OK'),
                      _summaryItem('granular xxxOf helpers', 'OK'),
                      _summaryItem('synthetic MediaQuery scopes', 'OK'),
                      _summaryItem('removePadding / removeViewInsets', 'OK'),
                      _summaryItem('removeViewPadding', 'OK'),
                      _summaryItem('copyWith cascade', 'OK'),
                      _summaryItem('orientation switching', 'OK'),
                      _summaryItem('LayoutBuilder comparison', 'OK'),
                      SizedBox(height: 12.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'MediaQuery advanced demo: rendered',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),
                Center(
                  child: Text(
                    'Deep Demo • MediaQuery • Flutter Widgets',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// HELPERS
// ----------------------------------------------------------------------------

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF004D40),
      ),
    ),
  );
}

Widget _pill(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11.0, color: Color(0xFFFFFFFF)),
    ),
  );
}

Widget _badge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _removalRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(fontSize: 10.5, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _darkInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFFE0F2F1),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryItem(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
