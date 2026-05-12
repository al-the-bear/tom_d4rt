// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for SystemChrome,
// SystemUiOverlayStyle, SystemUiMode and AnnotatedRegion overlay control
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Local descriptive records — purely declarative metadata. We never call into
// SystemChrome itself; we only render swatches and explanatory text that
// document its surface area.
// ---------------------------------------------------------------------------

class _OverlayStyleSpec {
  final String name;
  final String purpose;
  final Color statusBarColor;
  final Brightness statusBarBrightness;
  final Brightness statusBarIconBrightness;
  final Color systemNavigationBarColor;
  final Brightness systemNavigationBarIconBrightness;
  final Color systemNavigationBarDividerColor;
  final bool? systemStatusBarContrastEnforced;
  final bool? systemNavigationBarContrastEnforced;

  const _OverlayStyleSpec({
    required this.name,
    required this.purpose,
    required this.statusBarColor,
    required this.statusBarBrightness,
    required this.statusBarIconBrightness,
    required this.systemNavigationBarColor,
    required this.systemNavigationBarIconBrightness,
    required this.systemNavigationBarDividerColor,
    required this.systemStatusBarContrastEnforced,
    required this.systemNavigationBarContrastEnforced,
  });

  SystemUiOverlayStyle toStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      systemNavigationBarDividerColor: systemNavigationBarDividerColor,
      systemStatusBarContrastEnforced: systemStatusBarContrastEnforced,
      systemNavigationBarContrastEnforced: systemNavigationBarContrastEnforced,
    );
  }
}

class _UiModeSpec {
  final SystemUiMode mode;
  final String label;
  final String synopsis;
  final String behaviour;
  final List<String> visibleBars;
  final Color tone;

  const _UiModeSpec({
    required this.mode,
    required this.label,
    required this.synopsis,
    required this.behaviour,
    required this.visibleBars,
    required this.tone,
  });
}

class _OrientationSpec {
  final DeviceOrientation orientation;
  final String label;
  final String iconRune;
  final double aspectRatio;
  final Color tone;
  final String hint;

  const _OrientationSpec({
    required this.orientation,
    required this.label,
    required this.iconRune,
    required this.aspectRatio,
    required this.tone,
    required this.hint,
  });
}

class _LifecycleSpec {
  final AppLifecycleState state;
  final String label;
  final String description;
  final Color tone;
  final IconData icon;

  const _LifecycleSpec({
    required this.state,
    required this.label,
    required this.description,
    required this.tone,
    required this.icon,
  });
}

class _OverlaySpec {
  final SystemUiOverlay overlay;
  final String label;
  final String body;
  final Color tone;

  const _OverlaySpec({
    required this.overlay,
    required this.label,
    required this.body,
    required this.tone,
  });
}

dynamic build(BuildContext context) {
  print('=== SystemChrome deep visual demo starting ===');
  print('Flutter version: descriptive only — no setters invoked.');

  // -------------------------------------------------------------------------
  // SECTION 1 — SystemUiOverlayStyle catalog
  // -------------------------------------------------------------------------
  print('--- Section 1: SystemUiOverlayStyle catalog ---');

  final List<_OverlayStyleSpec> styleCatalog = <_OverlayStyleSpec>[
    const _OverlayStyleSpec(
      name: 'lightContent',
      purpose: 'Light icons over a dark status bar — typical of dark apps.',
      statusBarColor: Color(0xFF101418),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF101418),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFF22272E),
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ),
    const _OverlayStyleSpec(
      name: 'darkContent',
      purpose: 'Dark icons over a bright status bar — used by light themes.',
      statusBarColor: Color(0xFFFFFFFF),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF6F7F9),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color(0xFFE5E7EB),
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
    const _OverlayStyleSpec(
      name: 'edgeToEdgeTranslucent',
      purpose:
          'Transparent bars to enable edge-to-edge layouts under SystemUiMode.edgeToEdge.',
      statusBarColor: Color(0x00000000),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0x00000000),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0x00000000),
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
    const _OverlayStyleSpec(
      name: 'oceanic',
      purpose: 'Brand-tinted bars matching a cool cyan colour scheme.',
      statusBarColor: Color(0xFF015A6E),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF023246),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFF014A60),
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ),
    const _OverlayStyleSpec(
      name: 'sunrise',
      purpose: 'Warm gradient bars frequently used during onboarding flows.',
      statusBarColor: Color(0xFFFFE9C7),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFFFCB87),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color(0xFFE3A85B),
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
    const _OverlayStyleSpec(
      name: 'forest',
      purpose: 'Deep green pair for outdoor / nature themed sections.',
      statusBarColor: Color(0xFF14532D),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF052E16),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFF166534),
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ),
    const _OverlayStyleSpec(
      name: 'sepia',
      purpose: 'Reading-friendly cream tone for long-form content.',
      statusBarColor: Color(0xFFF4ECD8),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFE9DEC0),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color(0xFFD3C39A),
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
    const _OverlayStyleSpec(
      name: 'monochromeContrast',
      purpose:
          'High-contrast black/white pair used for accessibility scenarios.',
      statusBarColor: Color(0xFF000000),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFFFFFFFF),
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ),
  ];

  print('Catalog size: ${styleCatalog.length}');
  for (int i = 0; i < styleCatalog.length; i++) {
    final spec = styleCatalog[i];
    print('  [$i] ${spec.name} -> statusBar=${spec.statusBarColor.value}');
  }

  // Hand-authored "custom" SystemUiOverlayStyle constructed in line. This is
  // documented separately so the rendered card can highlight per-field
  // semantics.
  final SystemUiOverlayStyle customStyle = const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF6750A4),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF1E1B26),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF3F3949),
    systemStatusBarContrastEnforced: true,
    systemNavigationBarContrastEnforced: true,
  );
  print('Custom style statusBar=${customStyle.statusBarColor?.value}');
  print(
    'Custom style navBar=${customStyle.systemNavigationBarColor?.value}',
  );

  final List<Widget> styleCards = <Widget>[];
  for (int i = 0; i < styleCatalog.length; i++) {
    final _OverlayStyleSpec spec = styleCatalog[i];
    styleCards.add(_buildStyleCard(index: i, spec: spec));
  }

  final Widget section1 = _sectionShell(
    title: 'SystemUiOverlayStyle catalog',
    subtitle:
        'Each card is a declarative SystemUiOverlayStyle. It documents every '
        'field but never calls SystemChrome.setSystemUIOverlayStyle.',
    accent: const Color(0xFF6750A4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        _styleAnatomyLegend(),
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: styleCards,
        ),
        const SizedBox(height: 18),
        _customStyleBanner(customStyle),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 — SystemUiMode comparison strip
  // -------------------------------------------------------------------------
  print('--- Section 2: SystemUiMode comparison ---');

  final List<_UiModeSpec> modeCatalog = <_UiModeSpec>[
    const _UiModeSpec(
      mode: SystemUiMode.manual,
      label: 'manual',
      synopsis:
          'You choose exactly which overlays are visible via setEnabledSystemUIMode(manual, overlays:[...]).',
      behaviour:
          'Status & navigation bars only appear when explicitly listed in the overlays argument.',
      visibleBars: <String>['custom subset of SystemUiOverlay'],
      tone: Color(0xFF1F2937),
    ),
    const _UiModeSpec(
      mode: SystemUiMode.leanBack,
      label: 'leanBack',
      synopsis:
          'Fullscreen mode where bars reappear on any touch and stay visible briefly.',
      behaviour: 'Best for short-form video — gentle reveal, easy to dismiss.',
      visibleBars: <String>['none until tap', 'temporary status', 'temporary nav'],
      tone: Color(0xFF334155),
    ),
    const _UiModeSpec(
      mode: SystemUiMode.immersive,
      label: 'immersive',
      synopsis: 'Fullscreen with a swipe-from-edge gesture to reveal bars.',
      behaviour:
          'Reveal requires swipe from edge; bars auto-hide after a short timeout.',
      visibleBars: <String>['none', 'swipe-revealed temporary'],
      tone: Color(0xFF1E3A8A),
    ),
    const _UiModeSpec(
      mode: SystemUiMode.immersiveSticky,
      label: 'immersiveSticky',
      synopsis:
          'Like immersive but the swipe gesture only shows translucent bars.',
      behaviour:
          'Translucent overlays appear briefly without interrupting input — ideal for games.',
      visibleBars: <String>['translucent overlays on swipe'],
      tone: Color(0xFF111827),
    ),
    const _UiModeSpec(
      mode: SystemUiMode.edgeToEdge,
      label: 'edgeToEdge',
      synopsis:
          'Draws behind the system bars so they remain visible but transparent.',
      behaviour:
          'Use with a SystemUiOverlayStyle that has transparent statusBarColor / systemNavigationBarColor.',
      visibleBars: <String>['translucent status', 'translucent nav'],
      tone: Color(0xFF065F46),
    ),
  ];

  for (int i = 0; i < modeCatalog.length; i++) {
    print('  mode[$i] = ${modeCatalog[i].mode}');
  }
  print('SystemUiMode.values length = ${SystemUiMode.values.length}');

  final List<Widget> modeCards = <Widget>[];
  for (int i = 0; i < modeCatalog.length; i++) {
    modeCards.add(_buildModeCard(index: i, spec: modeCatalog[i]));
  }

  final Widget section2 = _sectionShell(
    title: 'SystemUiMode comparison',
    subtitle:
        'Five enum values, five very different fullscreen experiences. '
        'These are descriptive — no setEnabledSystemUIMode call is made.',
    accent: const Color(0xFF0EA5E9),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        Text(
          'Pseudocode example (NOT executed):\n'
          'SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 14),
        ...modeCards,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 — DeviceOrientation reference grid
  // -------------------------------------------------------------------------
  print('--- Section 3: DeviceOrientation reference ---');

  final List<_OrientationSpec> orientationCatalog = <_OrientationSpec>[
    const _OrientationSpec(
      orientation: DeviceOrientation.portraitUp,
      label: 'portraitUp',
      iconRune: 'A',
      aspectRatio: 9 / 16,
      tone: Color(0xFF2563EB),
      hint: 'Home button at the bottom. Default for most phones.',
    ),
    const _OrientationSpec(
      orientation: DeviceOrientation.portraitDown,
      label: 'portraitDown',
      iconRune: 'V',
      aspectRatio: 9 / 16,
      tone: Color(0xFF7C3AED),
      hint: 'Upside-down portrait. Rarely enabled by default.',
    ),
    const _OrientationSpec(
      orientation: DeviceOrientation.landscapeLeft,
      label: 'landscapeLeft',
      iconRune: '<',
      aspectRatio: 16 / 9,
      tone: Color(0xFFDB2777),
      hint: 'Home button to the right (device tilted counter-clockwise).',
    ),
    const _OrientationSpec(
      orientation: DeviceOrientation.landscapeRight,
      label: 'landscapeRight',
      iconRune: '>',
      aspectRatio: 16 / 9,
      tone: Color(0xFFEA580C),
      hint: 'Home button to the left (device tilted clockwise).',
    ),
  ];

  for (int i = 0; i < orientationCatalog.length; i++) {
    print(
      '  orientation[$i] = ${orientationCatalog[i].orientation} hint=${orientationCatalog[i].hint}',
    );
  }
  print(
    'DeviceOrientation.values has ${DeviceOrientation.values.length} entries.',
  );

  final List<Widget> orientationTiles = <Widget>[];
  for (int i = 0; i < orientationCatalog.length; i++) {
    orientationTiles.add(_buildOrientationTile(orientationCatalog[i]));
  }

  final Widget section3 = _sectionShell(
    title: 'DeviceOrientation reference',
    subtitle:
        'The four enum values you can pass to '
        'SystemChrome.setPreferredOrientations. Phone outlines drawn via '
        'CustomPaint — not real frames.',
    accent: const Color(0xFFDB2777),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        Text(
          'Pseudocode example (NOT executed):\n'
          'SystemChrome.setPreferredOrientations(<DeviceOrientation>[\n'
          '  DeviceOrientation.portraitUp,\n'
          '  DeviceOrientation.landscapeLeft,\n'
          ']);',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: orientationTiles,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 — AnnotatedRegion live mock
  // -------------------------------------------------------------------------
  print('--- Section 4: AnnotatedRegion<SystemUiOverlayStyle> live mock ---');

  // The AnnotatedRegion below is purely declarative — Flutter just publishes
  // the value to the layer tree, no platform channel call is forced.
  final SystemUiOverlayStyle nestedStyleA = styleCatalog[0].toStyle();
  final SystemUiOverlayStyle nestedStyleB = styleCatalog[3].toStyle();
  final SystemUiOverlayStyle nestedStyleC = styleCatalog[4].toStyle();
  print('Inner annotated regions configured with three layered styles.');
  print('  A=${nestedStyleA.statusBarColor?.value}');
  print('  B=${nestedStyleB.statusBarColor?.value}');
  print('  C=${nestedStyleC.statusBarColor?.value}');

  final Widget annotatedDemo = AnnotatedRegion<SystemUiOverlayStyle>(
    value: nestedStyleA,
    sized: false,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Outer AnnotatedRegion: lightContent style',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'AnnotatedRegion lets Flutter publish a SystemUiOverlayStyle '
            'to the layer tree. Nested regions override their parents.',
          ),
          const SizedBox(height: 12),
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: nestedStyleB,
            sized: true,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: nestedStyleB.statusBarColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Inner AnnotatedRegion: oceanic style',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Setting sized:true makes the region apply to the '
                    'painted bounds. Setting sized:false (the outer one) '
                    'covers the entire screen.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: nestedStyleC,
                    sized: true,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: nestedStyleC.statusBarColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Deepest AnnotatedRegion: sunrise style',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontWeight: FontWeight.w700,
                        ),
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
  );

  final Widget section4 = _sectionShell(
    title: 'AnnotatedRegion<SystemUiOverlayStyle>',
    subtitle:
        'Three nested AnnotatedRegions demonstrate how the deepest style '
        'wins when bars overlap the painted bounds.',
    accent: const Color(0xFF14B8A6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        annotatedDemo,
        const SizedBox(height: 16),
        _annotatedRegionFieldTable(),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 — System bars anatomy painted via CustomPaint
  // -------------------------------------------------------------------------
  print('--- Section 5: system bars anatomy ---');

  final List<_OverlaySpec> overlayCatalog = <_OverlaySpec>[
    const _OverlaySpec(
      overlay: SystemUiOverlay.top,
      label: 'SystemUiOverlay.top',
      body:
          'The status bar — clock, signal indicators, notification icons.',
      tone: Color(0xFF111827),
    ),
    const _OverlaySpec(
      overlay: SystemUiOverlay.bottom,
      label: 'SystemUiOverlay.bottom',
      body:
          'The navigation bar — back, home, recents (or gesture pill).',
      tone: Color(0xFF1F2937),
    ),
  ];

  for (int i = 0; i < overlayCatalog.length; i++) {
    print(
      '  overlay[$i] = ${overlayCatalog[i].overlay} label=${overlayCatalog[i].label}',
    );
  }
  print(
    'SystemUiOverlay.values has ${SystemUiOverlay.values.length} entries.',
  );

  final Widget anatomyDiagram = AspectRatio(
    aspectRatio: 9 / 16,
    child: CustomPaint(
      painter: const _SystemBarsAnatomyPainter(),
      child: const SizedBox.expand(),
    ),
  );

  final List<Widget> overlayCards = <Widget>[];
  for (int i = 0; i < overlayCatalog.length; i++) {
    overlayCards.add(_buildOverlayCard(overlayCatalog[i]));
  }

  final Widget section5 = _sectionShell(
    title: 'System bars anatomy',
    subtitle:
        'Painted phone diagram annotates which surfaces the SystemUiOverlay '
        'enum entries control.',
    accent: const Color(0xFFEAB308),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: anatomyDiagram,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: overlayCards,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _overlaySetExamples(),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 — AppLifecycleState reference card
  // -------------------------------------------------------------------------
  print('--- Section 6: AppLifecycleState reference ---');

  final List<_LifecycleSpec> lifecycleCatalog = <_LifecycleSpec>[
    const _LifecycleSpec(
      state: AppLifecycleState.resumed,
      label: 'resumed',
      description:
          'App is visible and responding to user input. Use this state to '
          'resume animations, re-acquire camera, etc.',
      tone: Color(0xFF16A34A),
      icon: Icons.play_circle_fill,
    ),
    const _LifecycleSpec(
      state: AppLifecycleState.inactive,
      label: 'inactive',
      description:
          'App is in an inactive state (e.g. phone call in iOS, split screen '
          'on Android). Pause non-essential work.',
      tone: Color(0xFFEAB308),
      icon: Icons.pause_circle_filled,
    ),
    const _LifecycleSpec(
      state: AppLifecycleState.paused,
      label: 'paused',
      description:
          'App is not visible to the user. Stop animations, throttle CPU '
          'usage. May still be running in background.',
      tone: Color(0xFFEA580C),
      icon: Icons.pause,
    ),
    const _LifecycleSpec(
      state: AppLifecycleState.detached,
      label: 'detached',
      description:
          'Flutter engine is running without a view. Save state and close '
          'resources. Will be terminated soon by the OS.',
      tone: Color(0xFFDC2626),
      icon: Icons.close,
    ),
    const _LifecycleSpec(
      state: AppLifecycleState.hidden,
      label: 'hidden',
      description:
          'All views are hidden (e.g. iOS app is in background but engine '
          'not yet paused). Treat similarly to paused.',
      tone: Color(0xFF6366F1),
      icon: Icons.visibility_off,
    ),
  ];

  for (int i = 0; i < lifecycleCatalog.length; i++) {
    print('  lifecycle[$i] = ${lifecycleCatalog[i].state}');
  }
  print(
    'AppLifecycleState.values has ${AppLifecycleState.values.length} entries.',
  );

  final List<Widget> lifecycleCards = <Widget>[];
  for (int i = 0; i < lifecycleCatalog.length; i++) {
    lifecycleCards.add(_buildLifecycleCard(i, lifecycleCatalog[i]));
  }

  final Widget section6 = _sectionShell(
    title: 'AppLifecycleState reference',
    subtitle:
        'WidgetsBinding emits these states. SystemChrome behaviour often '
        'reacts to them (e.g. restoring bars when paused -> resumed).',
    accent: const Color(0xFF22C55E),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        ...lifecycleCards,
        const SizedBox(height: 12),
        _lifecycleFlowDiagram(),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 — SystemUiChangeCallback explainer
  // -------------------------------------------------------------------------
  print('--- Section 7: SystemUiChangeCallback ---');

  final Widget callbackBox = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFEF9C3),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFEAB308)),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'typedef SystemUiChangeCallback = Future<void> Function(bool systemOverlaysAreVisible);',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFF713F12),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Use SystemChrome.setSystemUIChangeCallback to learn when the user '
          'has triggered the system bars to reappear (e.g. when in '
          'immersive modes). The callback receives whether overlays are now '
          'visible.',
          style: TextStyle(color: Color(0xFF713F12)),
        ),
        SizedBox(height: 10),
        Text(
          'Typical usage in pseudocode:\n'
          'SystemChrome.setSystemUIChangeCallback((bool visible) async {\n'
          '  if (visible) restoreUiState();\n'
          '  else enterCleanFullscreen();\n'
          '});',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFF713F12),
          ),
        ),
      ],
    ),
  );

  final Widget section7 = _sectionShell(
    title: 'SystemUiChangeCallback',
    subtitle:
        'The callback signature surfaced by SystemChrome to react to user-'
        'driven bar visibility changes.',
    accent: const Color(0xFFEAB308),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        callbackBox,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // Combine into a single AnnotatedRegion-wrapped Scaffold
  // -------------------------------------------------------------------------
  print('--- Combining sections into final Scaffold ---');

  final SystemUiOverlayStyle rootStyle = customStyle;
  print('Root AnnotatedRegion uses style with sized=false.');

  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: rootStyle,
    sized: false,
    child: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('SystemChrome deep visual demo'),
        backgroundColor: const Color(0xFF1E1B26),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _heroBanner(),
          const SizedBox(height: 20),
          section1,
          const SizedBox(height: 24),
          section2,
          const SizedBox(height: 24),
          section3,
          const SizedBox(height: 24),
          section4,
          const SizedBox(height: 24),
          section5,
          const SizedBox(height: 24),
          section6,
          const SizedBox(height: 24),
          section7,
          const SizedBox(height: 32),
          _footerCard(),
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper builders (top-level functions — keep them simple and stateless).
// ---------------------------------------------------------------------------

Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x140F172A),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 32,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

Widget _heroBanner() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF6750A4), Color(0xFF1E1B26)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'SystemChrome surface area',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A descriptive tour of SystemUiOverlayStyle, SystemUiMode, '
          'SystemUiOverlay, DeviceOrientation, AnnotatedRegion and '
          'AppLifecycleState. No setters are invoked — this script is safe '
          'to run inside a hot-reload context.',
          style: TextStyle(color: Colors.white70, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _footerCard() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(20),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'About this demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'The demo is intentionally read-only. SystemChrome calls touch the '
          'platform channel and are inherently asynchronous, which is not '
          'supported in this analyzer-free interpreter slice. AnnotatedRegion '
          'is the supported declarative path.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _styleAnatomyLegend() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'SystemUiOverlayStyle fields',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        SizedBox(height: 6),
        _LegendRow(
          label: 'statusBarColor',
          description:
              'Android-only background colour of the status bar. iOS ignores.',
        ),
        _LegendRow(
          label: 'statusBarBrightness',
          description:
              'iOS-only — the brightness of the bar itself. Affects icon tint.',
        ),
        _LegendRow(
          label: 'statusBarIconBrightness',
          description:
              'Android-only — the brightness of status bar foreground icons.',
        ),
        _LegendRow(
          label: 'systemNavigationBarColor',
          description: 'Background colour of the navigation bar (Android).',
        ),
        _LegendRow(
          label: 'systemNavigationBarIconBrightness',
          description:
              'Brightness of the nav bar icons — needed for contrast on Android Q+.',
        ),
        _LegendRow(
          label: 'systemNavigationBarDividerColor',
          description: 'Thin divider line above the nav bar (Android P+).',
        ),
        _LegendRow(
          label: 'systemStatusBarContrastEnforced',
          description:
              'If true, Android forces a scrim behind translucent status bars.',
        ),
        _LegendRow(
          label: 'systemNavigationBarContrastEnforced',
          description:
              'If true, Android forces a scrim behind translucent nav bars.',
        ),
      ],
    ),
  );
}

class _LegendRow extends StatelessWidget {
  final String label;
  final String description;

  const _LegendRow({required this.label, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF6750A4),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 12.5,
                  height: 1.4,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStyleCard({required int index, required _OverlayStyleSpec spec}) {
  return Container(
    width: 260,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF6750A4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                spec.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          spec.purpose,
          style: const TextStyle(fontSize: 11.5, color: Color(0xFF475569)),
        ),
        const SizedBox(height: 10),
        // Status bar swatch
        Container(
          height: 28,
          decoration: BoxDecoration(
            color: spec.statusBarColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          alignment: Alignment.center,
          child: Text(
            'status bar — ${spec.statusBarIconBrightness == Brightness.light ? "light icons" : "dark icons"}',
            style: TextStyle(
              fontSize: 10,
              color: spec.statusBarIconBrightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        // Body placeholder
        Container(
          height: 56,
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'content area',
            style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
          ),
        ),
        Container(
          height: 28,
          decoration: BoxDecoration(
            color: spec.systemNavigationBarColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(6),
            ),
            border: Border(
              left: BorderSide(color: spec.systemNavigationBarDividerColor),
              right: BorderSide(color: spec.systemNavigationBarDividerColor),
              bottom: BorderSide(color: spec.systemNavigationBarDividerColor),
              top: BorderSide(color: spec.systemNavigationBarDividerColor),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'nav bar — ${spec.systemNavigationBarIconBrightness == Brightness.light ? "light icons" : "dark icons"}',
            style: TextStyle(
              fontSize: 10,
              color: spec.systemNavigationBarIconBrightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _kv('statusBarColor', _hex(spec.statusBarColor)),
        _kv('statusBarBrightness', spec.statusBarBrightness.name),
        _kv('statusBarIconBrightness', spec.statusBarIconBrightness.name),
        _kv('systemNavigationBarColor', _hex(spec.systemNavigationBarColor)),
        _kv(
          'systemNavigationBarIconBrightness',
          spec.systemNavigationBarIconBrightness.name,
        ),
        _kv(
          'systemNavigationBarDividerColor',
          _hex(spec.systemNavigationBarDividerColor),
        ),
        _kv(
          'systemStatusBarContrastEnforced',
          '${spec.systemStatusBarContrastEnforced}',
        ),
        _kv(
          'systemNavigationBarContrastEnforced',
          '${spec.systemNavigationBarContrastEnforced}',
        ),
      ],
    ),
  );
}

Widget _kv(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            k,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF64748B),
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            v,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF0F172A),
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

String _hex(Color c) {
  final int v = c.value;
  final String hex = v.toRadixString(16).padLeft(8, '0').toUpperCase();
  return '#$hex';
}

Widget _customStyleBanner(SystemUiOverlayStyle style) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          style.statusBarColor ?? Colors.black,
          style.systemNavigationBarColor ?? Colors.black,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.palette, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Custom inline SystemUiOverlayStyle',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'A brand-specific style assembled directly inside build(). '
                'Status bar: ${_hex(style.statusBarColor ?? Colors.transparent)} • '
                'Nav bar: ${_hex(style.systemNavigationBarColor ?? Colors.transparent)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildModeCard({required int index, required _UiModeSpec spec}) {
  final List<Widget> bars = <Widget>[];
  for (int i = 0; i < spec.visibleBars.length; i++) {
    bars.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: <Widget>[
            const Text('• ', style: TextStyle(color: Colors.white70)),
            Expanded(
              child: Text(
                spec.visibleBars[i],
                style: const TextStyle(color: Colors.white70, fontSize: 11.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: spec.tone,
      borderRadius: BorderRadius.circular(14),
    ),
    padding: const EdgeInsets.all(14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'SystemUiMode.${spec.label}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                spec.synopsis,
                style: const TextStyle(color: Colors.white, fontSize: 12.5),
              ),
              const SizedBox(height: 4),
              Text(
                spec.behaviour,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Visible bars:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ...bars,
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildOrientationTile(_OrientationSpec spec) {
  return Container(
    width: 220,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: spec.tone,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                spec.iconRune,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                spec.label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: AspectRatio(
            aspectRatio: spec.aspectRatio,
            child: CustomPaint(
              painter: _PhoneOutlinePainter(tone: spec.tone),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          spec.hint,
          style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
        ),
      ],
    ),
  );
}

class _PhoneOutlinePainter extends CustomPainter {
  final Color tone;
  const _PhoneOutlinePainter({required this.tone});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint body = Paint()
      ..color = tone.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    final Paint outline = Paint()
      ..color = tone
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      const Radius.circular(14),
    );
    canvas.drawRRect(rrect, body);
    canvas.drawRRect(rrect, outline);

    // Notch
    final Paint notch = Paint()..color = tone.withOpacity(0.25);
    final double notchW = size.width * 0.32;
    final double notchH = size.height * 0.03;
    final Rect notchRect = Rect.fromLTWH(
      (size.width - notchW) / 2,
      6,
      notchW,
      notchH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(notchRect, const Radius.circular(4)),
      notch,
    );

    // Home indicator
    final Paint home = Paint()..color = tone.withOpacity(0.5);
    final double homeW = size.width * 0.4;
    final double homeH = 3.5;
    final Rect homeRect = Rect.fromLTWH(
      (size.width - homeW) / 2,
      size.height - homeH - 6,
      homeW,
      homeH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(homeRect, const Radius.circular(2)),
      home,
    );
  }

  @override
  bool shouldRepaint(covariant _PhoneOutlinePainter oldDelegate) {
    return oldDelegate.tone != tone;
  }
}

Widget _annotatedRegionFieldTable() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'AnnotatedRegion<T> constructor fields',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        SizedBox(height: 8),
        _LegendRow(
          label: 'value',
          description:
              'The metadata to publish. For system chrome, this is a SystemUiOverlayStyle.',
        ),
        _LegendRow(
          label: 'child',
          description:
              'The widget that owns the region. Painted bounds determine where T applies when sized:true.',
        ),
        _LegendRow(
          label: 'sized',
          description:
              'If true (default), region applies only to child bounds. If false, applies to whole screen.',
        ),
      ],
    ),
  );
}

Widget _buildOverlayCard(_OverlaySpec spec) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: spec.tone,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          spec.label,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          spec.body,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    ),
  );
}

class _SystemBarsAnatomyPainter extends CustomPainter {
  const _SystemBarsAnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint frame = Paint()
      ..color = const Color(0xFF111827)
      ..style = PaintingStyle.fill;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(28),
    );
    canvas.drawRRect(rrect, frame);

    // Screen area
    final double inset = 8;
    final Paint screen = Paint()..color = const Color(0xFFF8FAFC);
    final RRect screenRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        inset,
        inset,
        size.width - inset * 2,
        size.height - inset * 2,
      ),
      const Radius.circular(20),
    );
    canvas.drawRRect(screenRect, screen);

    // Status bar zone
    final Paint statusZone = Paint()..color = const Color(0xFF6750A4);
    final RRect statusRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(inset, inset, size.width - inset * 2, 36),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
    );
    canvas.drawRRect(statusRect, statusZone);

    // Status bar label
    final TextPainter statusLabel = TextPainter(
      text: const TextSpan(
        text: 'SystemUiOverlay.top',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    statusLabel.layout();
    statusLabel.paint(
      canvas,
      Offset(
        (size.width - statusLabel.width) / 2,
        inset + (36 - statusLabel.height) / 2,
      ),
    );

    // Nav bar zone
    final Paint navZone = Paint()..color = const Color(0xFF0EA5E9);
    final RRect navRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        inset,
        size.height - inset - 36,
        size.width - inset * 2,
        36,
      ),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    );
    canvas.drawRRect(navRect, navZone);

    final TextPainter navLabel = TextPainter(
      text: const TextSpan(
        text: 'SystemUiOverlay.bottom',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    navLabel.layout();
    navLabel.paint(
      canvas,
      Offset(
        (size.width - navLabel.width) / 2,
        size.height - inset - 36 + (36 - navLabel.height) / 2,
      ),
    );

    // Body label
    final TextPainter bodyLabel = TextPainter(
      text: const TextSpan(
        text: 'app body\n(SafeArea + AnnotatedRegion)',
        style: TextStyle(
          color: Color(0xFF334155),
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    bodyLabel.layout(maxWidth: size.width - inset * 2);
    bodyLabel.paint(
      canvas,
      Offset(
        (size.width - bodyLabel.width) / 2,
        (size.height - bodyLabel.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _SystemBarsAnatomyPainter oldDelegate) {
    return false;
  }
}

Widget _overlaySetExamples() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBEB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFCD34D)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Common overlay sets (descriptive only)',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'manual, []                 — hide both bars\n'
          'manual, [SystemUiOverlay.top]    — status only\n'
          'manual, [SystemUiOverlay.bottom] — nav only\n'
          'manual, SystemUiOverlay.values   — both bars',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
        SizedBox(height: 6),
        Text(
          'In production these would be the second argument to '
          'SystemChrome.setEnabledSystemUIMode. This demo does NOT call it.',
          style: TextStyle(fontSize: 12, color: Color(0xFF92400E)),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleCard(int index, _LifecycleSpec spec) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: spec.tone),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: spec.tone,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(spec.icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'AppLifecycleState.${spec.label}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: spec.tone.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '#$index',
                      style: TextStyle(
                        color: spec.tone,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                spec.description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF334155),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleFlowDiagram() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF0FDF4),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFBBF7D0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Typical lifecycle flow',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'launch -> resumed -> inactive -> paused -> hidden -> detached',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
        SizedBox(height: 6),
        Text(
          'Note: the engine may skip "hidden" on older platforms. Always '
          'handle resumed/paused at minimum to flush + restore state.',
          style: TextStyle(fontSize: 12, color: Color(0xFF166534)),
        ),
      ],
    ),
  );
}
