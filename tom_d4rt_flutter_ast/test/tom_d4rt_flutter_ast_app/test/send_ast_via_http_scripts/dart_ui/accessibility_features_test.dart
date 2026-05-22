// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt AST deep visual demo for dart:ui AccessibilityFeatures.
//
// Design plan
// -----------
// AccessibilityFeatures is a read-only struct surfaced by the platform via
// PlatformDispatcher.instance.accessibilityFeatures. Because the AST runner
// executes a static snapshot, we cannot poll the live flags; instead we
// present each flag (accessibleNavigation, invertColors, disableAnimations,
// boldText, reduceMotion, highContrast, onOffSwitchLabels) as a labelled
// hypothetical scenario with diagnostic preview cards.
//
// Sections:
//   1. Header gradient banner with feature roll-call.
//   2. Flag overview cards (purpose + UI guidance per flag).
//   3. Before/after preview panels for each flag (visual mockups).
//   4. Decision table mapping flag combinations to recommended responses.
//   5. Recipe section: code snippets and policy descriptions per flag.
//   6. Compatibility matrix - which Flutter widgets honour which flag.
//   7. Glossary + key takeaways.
//
// All composition is via plain Material widgets - no async, no Timer, no
// dialogs/navigation. The widget tree is fully static so the AST runner
// can serialize the build.
import 'package:flutter/material.dart';

void main() => runApp(const AccessibilityFeaturesDemoApp());

// ---------------------------------------------------------------------------
// Data records
// ---------------------------------------------------------------------------

class _FlagSpec {
  const _FlagSpec({
    required this.id,
    required this.label,
    required this.purpose,
    required this.guidance,
    required this.icon,
    required this.accent,
  });
  final String id;
  final String label;
  final String purpose;
  final String guidance;
  final IconData icon;
  final Color accent;
}

class _DecisionRow {
  const _DecisionRow({
    required this.combo,
    required this.scenario,
    required this.response,
    required this.priority,
  });
  final String combo;
  final String scenario;
  final String response;
  final int priority; // 1..3
}

class _RecipeSpec {
  const _RecipeSpec({
    required this.flag,
    required this.policy,
    required this.snippet,
  });
  final String flag;
  final String policy;
  final String snippet;
}

class _MatrixCell {
  const _MatrixCell({required this.honoured, required this.note});
  final bool honoured;
  final String note;
}

// Centralized list of all flags, declared once so every section can refer to
// the same canonical labels/colors/icons without drifting out of sync.
const List<_FlagSpec> _kFlagSpecs = <_FlagSpec>[
  _FlagSpec(
    id: 'accessibleNavigation',
    label: 'Accessible Navigation',
    purpose:
        'A screen reader, switch control or other assistive tech is driving '
        'navigation. Focus order and semantic boundaries must be precise.',
    guidance:
        'Expose meaningful Semantics labels, group related controls, and '
        'avoid implicit gestures. Provide explicit affordances for every '
        'tappable region; never rely on hover or proximity alone.',
    icon: Icons.accessibility_new,
    accent: Color(0xFF1B5E20),
  ),
  _FlagSpec(
    id: 'invertColors',
    label: 'Invert Colors',
    purpose:
        'The OS is inverting screen colors (often for low-vision users or '
        'reduced glare). Photographs and rasters look strange when inverted.',
    guidance:
        'Wrap images, video previews, and rich photographic content in a '
        'second inversion so the result is right-side-up. Do not invert UI '
        'chrome; the platform already inverts it.',
    icon: Icons.invert_colors,
    accent: Color(0xFF1565C0),
  ),
  _FlagSpec(
    id: 'disableAnimations',
    label: 'Disable Animations',
    purpose:
        'The user has requested that animations be suppressed entirely. '
        'Movement causes nausea, distraction, or cognitive overload.',
    guidance:
        'Skip implicit transitions, set Duration.zero where possible, and '
        'replace cross-fades with hard cuts. Keep essential progress feedback '
        'but render it without motion (e.g. step counters instead of bars).',
    icon: Icons.motion_photos_off,
    accent: Color(0xFFD84315),
  ),
  _FlagSpec(
    id: 'boldText',
    label: 'Bold Text',
    purpose:
        'Operating system has been asked to render text in a heavier weight. '
        'Often used by users with mild visual impairment.',
    guidance:
        'Apply FontWeight.w700 to body copy. Recheck layouts: bold runs '
        'wider, so make sure ellipsis/overflow handles still look right and '
        'no inline buttons collide with labels.',
    icon: Icons.format_bold,
    accent: Color(0xFF4527A0),
  ),
  _FlagSpec(
    id: 'reduceMotion',
    label: 'Reduce Motion',
    purpose:
        'Less aggressive than disableAnimations: still allow short, '
        'functional transitions but suppress decorative or parallax motion.',
    guidance:
        'Trim animation durations by ~50%, drop spring/elastic curves in '
        'favor of linear, remove parallax. Cross-fades are usually fine; '
        'long swooping page transitions are not.',
    icon: Icons.slow_motion_video,
    accent: Color(0xFFAD1457),
  ),
  _FlagSpec(
    id: 'highContrast',
    label: 'High Contrast',
    purpose:
        'User has requested elevated contrast between background and '
        'foreground - typical of low-vision or bright-environment use.',
    guidance:
        'Switch ColorScheme to a high-contrast variant. Strengthen borders, '
        'thicken focus rings, ensure text meets WCAG AAA against backgrounds.',
    icon: Icons.contrast,
    accent: Color(0xFF263238),
  ),
  _FlagSpec(
    id: 'onOffSwitchLabels',
    label: 'On/Off Switch Labels',
    purpose:
        'iOS-style accessibility option: switches should display textual '
        'I and O markers in addition to color/position.',
    guidance:
        'Augment Switch widgets with visible ON/OFF text. Do not rely on '
        'color alone to communicate state; the marker is a redundancy that '
        'matters for color-blind and low-vision users.',
    icon: Icons.toggle_on,
    accent: Color(0xFF00695C),
  ),
];

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------

class AccessibilityFeaturesDemoApp extends StatelessWidget {
  const AccessibilityFeaturesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('AccessibilityFeatures Deep Demo executing');

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B5E20),
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(useMaterial3: true, colorScheme: scheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AccessibilityFeatures Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 32.0),
              _buildSection1Overview(scheme),
              const SizedBox(height: 36.0),
              _buildSection2BeforeAfter(scheme),
              const SizedBox(height: 36.0),
              _buildSection3DecisionTable(scheme),
              const SizedBox(height: 36.0),
              _buildSection4Recipes(scheme),
              const SizedBox(height: 36.0),
              _buildSection5CompatibilityMatrix(scheme),
              const SizedBox(height: 36.0),
              _buildSection6GlossaryAndTakeaways(scheme),
              const SizedBox(height: 24.0),
              _buildFooter(scheme),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Header banner
  // -------------------------------------------------------------------------
  Widget _buildHeaderBanner(ColorScheme scheme) {
    print('=== Section 0: Header banner ===');
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Icon(
                  Icons.accessibility_new,
                  size: 36.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'dart:ui AccessibilityFeatures',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Seven platform-level accessibility flags '
                      'and how Flutter UI should respond to them.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: scheme.onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              for (final _FlagSpec f in _kFlagSpecs)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.onPrimary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: scheme.onPrimary.withValues(alpha: 0.4),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(f.icon, size: 14.0, color: scheme.onPrimary),
                      const SizedBox(width: 6.0),
                      Text(
                        f.id,
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 1 - Flag overview cards
  // -------------------------------------------------------------------------
  Widget _buildSection1Overview(ColorScheme scheme) {
    print('=== Section 1: Flag overview cards ===');

    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < _kFlagSpecs.length; i++) {
      final _FlagSpec f = _kFlagSpecs[i];
      cards.add(_buildFlagOverviewCard(scheme, f, i + 1));
    }
    print('Built ${cards.length} overview cards');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 1: Flag overview', scheme),
        const SizedBox(height: 12.0),
        _sectionLeadIn(
          'Each flag in AccessibilityFeatures is a boolean. The platform '
          'flips it; the app reacts. The cards below describe the contract.',
          scheme,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: cards,
        ),
      ],
    );
  }

  Widget _buildFlagOverviewCard(
    ColorScheme scheme,
    _FlagSpec f,
    int index,
  ) {
    return Container(
      width: 320.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: f.accent.withValues(alpha: 0.4),
          width: 1.4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: f.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(f.icon, color: f.accent, size: 22.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      f.label,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    Text(
                      'Flag #$index  /  ${f.id}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _labelledBlock(
            scheme,
            'Purpose',
            f.purpose,
            f.accent.withValues(alpha: 0.10),
            f.accent,
          ),
          const SizedBox(height: 8.0),
          _labelledBlock(
            scheme,
            'UI guidance',
            f.guidance,
            scheme.secondaryContainer.withValues(alpha: 0.55),
            scheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 2 - Before / after preview panels
  // -------------------------------------------------------------------------
  Widget _buildSection2BeforeAfter(ColorScheme scheme) {
    print('=== Section 2: Before/after previews ===');

    final List<Widget> tiles = <Widget>[
      _previewAccessibleNavigation(scheme),
      _previewInvertColors(scheme),
      _previewDisableAnimations(scheme),
      _previewBoldText(scheme),
      _previewReduceMotion(scheme),
      _previewHighContrast(scheme),
      _previewOnOffSwitchLabels(scheme),
    ];
    print('Built ${tiles.length} before/after tiles');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 2: Before / after panels', scheme),
        const SizedBox(height: 12.0),
        _sectionLeadIn(
          'The left column shows the default look. The right column shows '
          'the same UI when the corresponding accessibility flag is on. '
          'Both states are rendered as static previews.',
          scheme,
        ),
        const SizedBox(height: 16.0),
        Column(children: tiles),
      ],
    );
  }

  Widget _previewAccessibleNavigation(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Default focus order',
      <Widget>[
        _fakeListTile(scheme, Icons.home, 'Home'),
        _fakeListTile(scheme, Icons.search, 'Search'),
        _fakeListTile(scheme, Icons.person, 'Profile'),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Reader-friendly focus rings',
      <Widget>[
        _fakeListTile(scheme, Icons.home, 'Home', focus: true),
        _fakeListTile(scheme, Icons.search, 'Search'),
        _fakeListTile(scheme, Icons.person, 'Profile'),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[0],
      before: before,
      after: after,
      caption:
          'When accessibleNavigation is on, every tappable region gets a '
          'visible focus ring and explicit Semantics labels for the reader.',
    );
  }

  Widget _previewInvertColors(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Photo (default)',
      <Widget>[
        _fakePhoto(scheme, inverted: false),
        const SizedBox(height: 8.0),
        Text(
          'Sunset over the bay',
          style: TextStyle(color: scheme.onSurface, fontSize: 12.0),
        ),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Wrapped: re-inverted photo',
      <Widget>[
        _fakePhoto(scheme, inverted: true),
        const SizedBox(height: 8.0),
        Text(
          'Sunset over the bay',
          style: TextStyle(color: scheme.onSurface, fontSize: 12.0),
        ),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[1],
      before: before,
      after: after,
      caption:
          'Without intervention the OS inverts the photo and it looks alien. '
          'A second inversion on the image widget keeps it natural while '
          'leaving UI chrome inverted by the OS.',
    );
  }

  Widget _previewDisableAnimations(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Cross-fade transition',
      <Widget>[
        _fakeMotionTrace(scheme, count: 6, fading: true),
        const SizedBox(height: 8.0),
        Text(
          'Duration: 350ms ease-in-out',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11.0),
        ),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Hard cut, no movement',
      <Widget>[
        _fakeMotionTrace(scheme, count: 1, fading: false),
        const SizedBox(height: 8.0),
        Text(
          'Duration: 0ms',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11.0),
        ),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[2],
      before: before,
      after: after,
      caption:
          'When disableAnimations is on, route and AnimatedContainer durations '
          'should collapse to zero. The visual updates instantly, with no '
          'intermediate frames.',
    );
  }

  Widget _previewBoldText(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Default weight',
      <Widget>[
        Text(
          'Tap any item to open',
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Long description body copy '
          'that wraps across multiple lines for layout testing.',
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Bold weight (w700)',
      <Widget>[
        Text(
          'Tap any item to open',
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Long description body copy '
          'that wraps across multiple lines for layout testing.',
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[3],
      before: before,
      after: after,
      caption:
          'Bold text widens runs. Always retest fixed-width chips, ellipsis '
          'columns and inline buttons. Headings rarely need adjustment, body '
          'copy almost always does.',
    );
  }

  Widget _previewReduceMotion(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Spring + parallax',
      <Widget>[
        _fakeSpringCurve(scheme, springy: true),
        const SizedBox(height: 8.0),
        Text(
          'Curves.elasticOut, 600ms',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11.0),
        ),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Linear, short',
      <Widget>[
        _fakeSpringCurve(scheme, springy: false),
        const SizedBox(height: 8.0),
        Text(
          'Curves.linear, 200ms',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11.0),
        ),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[4],
      before: before,
      after: after,
      caption:
          'reduceMotion is gentler than disableAnimations - functional '
          'transitions remain, but spring/elastic curves and parallax '
          'backdrops are replaced with short linear interpolations.',
    );
  }

  Widget _previewHighContrast(ColorScheme scheme) {
    final ColorScheme highContrast = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF000000),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF003C8F),
      onSecondary: Color(0xFFFFFFFF),
      tertiary: Color(0xFFAD1457),
      onTertiary: Color(0xFFFFFFFF),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      surfaceContainerHighest: Color(0xFFE0E0E0),
      onSurfaceVariant: Color(0xFF1A1A1A),
      outline: Color(0xFF000000),
      shadow: Color(0xFF000000),
      primaryContainer: Color(0xFFE0E0E0),
      onPrimaryContainer: Color(0xFF000000),
      secondaryContainer: Color(0xFFD7E3F4),
      onSecondaryContainer: Color(0xFF000000),
      tertiaryContainer: Color(0xFFFFC0CB),
      onTertiaryContainer: Color(0xFF000000),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF000000),
      inverseSurface: Color(0xFF000000),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFFFFFFFF),
      surfaceTint: Color(0xFF000000),
    );

    final Widget before = _swatchRow(scheme, scheme);
    final Widget after = _swatchRow(scheme, highContrast);
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[5],
      before: _phoneFrame(scheme, 'Default scheme', <Widget>[before]),
      after: _phoneFrame(scheme, 'High-contrast scheme', <Widget>[after]),
      caption:
          'Swap to a ColorScheme with maximum text/background contrast and '
          'thick outlines. Borders that were 1px should become 2px; focus '
          'rings should jump from subtle to unmissable.',
    );
  }

  Widget _previewOnOffSwitchLabels(ColorScheme scheme) {
    final Widget before = _phoneFrame(
      scheme,
      'Default Switch',
      <Widget>[
        _fakeSwitch(scheme, on: true, showLabel: false),
        const SizedBox(height: 6.0),
        _fakeSwitch(scheme, on: false, showLabel: false),
      ],
    );
    final Widget after = _phoneFrame(
      scheme,
      'Switch with I / O labels',
      <Widget>[
        _fakeSwitch(scheme, on: true, showLabel: true),
        const SizedBox(height: 6.0),
        _fakeSwitch(scheme, on: false, showLabel: true),
      ],
    );
    return _beforeAfter(
      scheme,
      flag: _kFlagSpecs[6],
      before: before,
      after: after,
      caption:
          'Switches add textual ON/OFF markers (I and O). This protects '
          'color-blind users who cannot reliably distinguish the green and '
          'grey thumb states.',
    );
  }

  // -------------------------------------------------------------------------
  // Section 3 - Decision table
  // -------------------------------------------------------------------------
  Widget _buildSection3DecisionTable(ColorScheme scheme) {
    print('=== Section 3: Decision table ===');

    const List<_DecisionRow> rows = <_DecisionRow>[
      _DecisionRow(
        combo: 'accessibleNavigation only',
        scenario: 'Screen reader without visual aids',
        response:
            'Explicit Semantics labels everywhere; never rely on visual '
            'feedback alone.',
        priority: 1,
      ),
      _DecisionRow(
        combo: 'invertColors + highContrast',
        scenario: 'Low-vision user, inverted + boosted contrast',
        response:
            'Re-invert photos and apply the high-contrast color scheme. '
            'Verify no double-inversion in nested theming.',
        priority: 1,
      ),
      _DecisionRow(
        combo: 'disableAnimations',
        scenario: 'Motion sensitivity / vestibular disorder',
        response:
            'All Duration values become Duration.zero. AnimatedSwitcher '
            'uses no transition.',
        priority: 1,
      ),
      _DecisionRow(
        combo: 'reduceMotion (alone)',
        scenario: 'Mild motion sensitivity',
        response:
            'Halve durations, swap curves to Curves.linear, remove parallax.',
        priority: 2,
      ),
      _DecisionRow(
        combo: 'boldText',
        scenario: 'Low-vision text emphasis',
        response:
            'FontWeight.w700 on body text; rerun layout overflow checks.',
        priority: 2,
      ),
      _DecisionRow(
        combo: 'boldText + highContrast',
        scenario: 'Stacked visual aids',
        response:
            'Both must coexist; verify focus ring contrast against the new '
            'background and ensure bold text still fits in chips.',
        priority: 1,
      ),
      _DecisionRow(
        combo: 'onOffSwitchLabels',
        scenario: 'Color-blind support',
        response:
            'Render ON/OFF tags on every Switch; also applies to custom '
            'toggle widgets.',
        priority: 2,
      ),
      _DecisionRow(
        combo: 'disableAnimations + accessibleNavigation',
        scenario: 'Reader + motion-sensitive user',
        response:
            'No transitions, plus Semantics announcements should replace '
            'animated focus pulses.',
        priority: 1,
      ),
      _DecisionRow(
        combo: 'all flags on',
        scenario: 'Maximum accommodation',
        response:
            'Theme = high-contrast, weight = w700, duration = 0, semantics '
            'verbose, switches labelled, photos re-inverted.',
        priority: 1,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 3: Decision table', scheme),
        const SizedBox(height: 12.0),
        _sectionLeadIn(
          'Real users rarely enable a single flag in isolation. The decision '
          'table below maps common combinations to the recommended UI '
          'response.',
          scheme,
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: scheme.outlineVariant,
              width: 1.0,
            ),
          ),
          child: Column(
            children: <Widget>[
              _decisionHeaderRow(scheme),
              for (int i = 0; i < rows.length; i++)
                _decisionRow(scheme, rows[i], i.isEven),
            ],
          ),
        ),
      ],
    );
  }

  Widget _decisionHeaderRow(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(13.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Combination',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Scenario',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Recommended response',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
          ),
          SizedBox(
            width: 72.0,
            child: Text(
              'Priority',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decisionRow(ColorScheme scheme, _DecisionRow row, bool zebra) {
    final Color priorityColor;
    final String priorityLabel;
    switch (row.priority) {
      case 1:
        priorityColor = scheme.error;
        priorityLabel = 'P1';
        break;
      case 2:
        priorityColor = scheme.tertiary;
        priorityLabel = 'P2';
        break;
      default:
        priorityColor = scheme.secondary;
        priorityLabel = 'P3';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: zebra
            ? scheme.surface
            : scheme.surfaceContainerHigh.withValues(alpha: 0.6),
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.combo,
              style: TextStyle(
                fontFamily: 'monospace',
                color: scheme.primary,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.scenario,
              style: TextStyle(color: scheme.onSurface, fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              row.response,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            width: 72.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: priorityColor.withValues(alpha: 0.55),
                  ),
                ),
                child: Text(
                  priorityLabel,
                  style: TextStyle(
                    color: priorityColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 4 - Recipes (policy + snippet per flag)
  // -------------------------------------------------------------------------
  Widget _buildSection4Recipes(ColorScheme scheme) {
    print('=== Section 4: Recipes ===');

    const List<_RecipeSpec> recipes = <_RecipeSpec>[
      _RecipeSpec(
        flag: 'accessibleNavigation',
        policy:
            'Wrap every interactive region in a Semantics widget; promote '
            'implicit gestures to explicit buttons.',
        snippet:
            'final a11y = MediaQuery.accessibleNavigationOf(context);\n'
            'return Semantics(\n'
            '  button: true,\n'
            '  label: a11y ? "Open profile" : null,\n'
            '  child: InkWell(\n'
            '    onTap: openProfile,\n'
            '    child: const Icon(Icons.person),\n'
            '  ),\n'
            ');',
      ),
      _RecipeSpec(
        flag: 'invertColors',
        policy:
            'Wrap photographic assets in ColorFiltered with an inversion '
            'matrix so the OS-level inversion is cancelled out.',
        snippet:
            'return ColorFiltered(\n'
            '  colorFilter: const ColorFilter.matrix(<double>[\n'
            '    -1,  0,  0, 0, 255,\n'
            '     0, -1,  0, 0, 255,\n'
            '     0,  0, -1, 0, 255,\n'
            '     0,  0,  0, 1,   0,\n'
            '  ]),\n'
            '  child: Image.asset("assets/photo.png"),\n'
            ');',
      ),
      _RecipeSpec(
        flag: 'disableAnimations',
        policy:
            'Collapse durations to Duration.zero. Use AnimationController '
            'with duration scaled by a guard.',
        snippet:
            'final disabled = MediaQuery.disableAnimationsOf(context);\n'
            'final controller = AnimationController(\n'
            '  vsync: this,\n'
            '  duration: disabled\n'
            '    ? Duration.zero\n'
            '    : const Duration(milliseconds: 350),\n'
            ');',
      ),
      _RecipeSpec(
        flag: 'boldText',
        policy:
            'Adopt MediaQuery.boldTextOverride or check the flag and apply '
            'FontWeight.w700 to text styles.',
        snippet:
            'final bold = MediaQuery.boldTextOf(context);\n'
            'return Text(\n'
            '  "Hello",\n'
            '  style: TextStyle(\n'
            '    fontWeight: bold ? FontWeight.w700 : FontWeight.w400,\n'
            '  ),\n'
            ');',
      ),
      _RecipeSpec(
        flag: 'reduceMotion',
        policy:
            'Soften, do not eliminate. Swap spring curves for linear and '
            'halve the duration.',
        snippet:
            'final reduce = MediaQuery.of(context).accessibilityFeatures\n'
            '  .reduceMotion;\n'
            'final curve = reduce ? Curves.linear : Curves.elasticOut;\n'
            'final dur = reduce\n'
            '  ? const Duration(milliseconds: 150)\n'
            '  : const Duration(milliseconds: 350);\n'
            'AnimatedContainer(duration: dur, curve: curve, ...);',
      ),
      _RecipeSpec(
        flag: 'highContrast',
        policy:
            'Swap to a high-contrast ColorScheme. Bump outline thickness.',
        snippet:
            'final hc = MediaQuery.highContrastOf(context);\n'
            'final scheme = hc\n'
            '  ? buildHighContrastScheme()\n'
            '  : buildDefaultScheme();\n'
            'return Theme(\n'
            '  data: ThemeData(colorScheme: scheme),\n'
            '  child: child,\n'
            ');',
      ),
      _RecipeSpec(
        flag: 'onOffSwitchLabels',
        policy:
            'Show explicit ON/OFF labels next to or inside each switch.',
        snippet:
            'final labelled = MediaQuery.onOffSwitchLabelsOf(context);\n'
            'return Row(\n'
            '  children: <Widget>[\n'
            '    Switch(value: v, onChanged: onChange),\n'
            '    if (labelled)\n'
            '      Text(v ? "ON" : "OFF"),\n'
            '  ],\n'
            ');',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 4: Recipes', scheme),
        const SizedBox(height: 12.0),
        _sectionLeadIn(
          'Each recipe describes the response policy and a representative '
          'code snippet. Snippets are hypothetical - the actual flag values '
          'cannot be read in this static execution context.',
          scheme,
        ),
        const SizedBox(height: 16.0),
        Column(
          children: <Widget>[
            for (final _RecipeSpec r in recipes) _recipeCard(scheme, r),
          ],
        ),
      ],
    );
  }

  Widget _recipeCard(ColorScheme scheme, _RecipeSpec r) {
    _FlagSpec? spec;
    for (final _FlagSpec f in _kFlagSpecs) {
      if (f.id == r.flag) {
        spec = f;
        break;
      }
    }
    final IconData icon = spec?.icon ?? Icons.help_outline;
    final Color accent = spec?.accent ?? scheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: accent, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    r.flag,
                    style: TextStyle(
                      color: accent,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Text(
                    'Recipe',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Policy',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  r.policy,
                  style: TextStyle(color: scheme.onSurface, fontSize: 13.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1F1A),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                r.snippet,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFFB9F6CA),
                  fontSize: 11.5,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 5 - Compatibility matrix
  // -------------------------------------------------------------------------
  Widget _buildSection5CompatibilityMatrix(ColorScheme scheme) {
    print('=== Section 5: Compatibility matrix ===');

    // Each widget row shows whether each flag affects it.
    final List<String> widgetRows = <String>[
      'Text',
      'Image',
      'Switch',
      'AnimatedContainer',
      'PageRoute (default)',
      'InkWell',
      'Theme',
    ];

    final Map<String, List<_MatrixCell>> data = <String, List<_MatrixCell>>{
      'Text': <_MatrixCell>[
        _MatrixCell(honoured: true, note: 'reader reads label'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'auto bold via MQ'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'colour shift'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
      'Image': <_MatrixCell>[
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 're-invert needed'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
      'Switch': <_MatrixCell>[
        _MatrixCell(honoured: true, note: 'reads on/off state'),
        _MatrixCell(honoured: true, note: 'theme inverted'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'thumb weight'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'border thickens'),
        _MatrixCell(honoured: true, note: 'I/O labels added'),
      ],
      'AnimatedContainer': <_MatrixCell>[
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'duration -> zero'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'duration halved'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
      'PageRoute (default)': <_MatrixCell>[
        _MatrixCell(honoured: true, note: 'announces route'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'transition off'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'cross-fade only'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
      'InkWell': <_MatrixCell>[
        _MatrixCell(honoured: true, note: 'focus ring shown'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'splash dampened'),
        _MatrixCell(honoured: true, note: 'border thickens'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
      'Theme': <_MatrixCell>[
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'colours flipped'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'text weights bumped'),
        _MatrixCell(honoured: false, note: 'no effect'),
        _MatrixCell(honoured: true, note: 'whole scheme swap'),
        _MatrixCell(honoured: false, note: 'no effect'),
      ],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 5: Widget compatibility matrix', scheme),
        const SizedBox(height: 12.0),
        _sectionLeadIn(
          'Which built-in Material widgets are sensitive to which flag. '
          'A filled cell means the widget visibly changes when the flag '
          'is on.',
          scheme,
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: scheme.outlineVariant,
              width: 1.0,
            ),
          ),
          child: Column(
            children: <Widget>[
              _matrixHeader(scheme),
              for (int i = 0; i < widgetRows.length; i++)
                _matrixRow(
                  scheme,
                  widgetRows[i],
                  data[widgetRows[i]]!,
                  i.isEven,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _matrixHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(13.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              'Widget',
              style: TextStyle(
                color: scheme.onTertiaryContainer,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
          ),
          for (final _FlagSpec f in _kFlagSpecs)
            Expanded(
              child: Tooltip(
                message: f.label,
                child: Center(
                  child: Icon(
                    f.icon,
                    color: scheme.onTertiaryContainer,
                    size: 18.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _matrixRow(
    ColorScheme scheme,
    String widgetName,
    List<_MatrixCell> cells,
    bool zebra,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: zebra
            ? scheme.surface
            : scheme.surfaceContainerHigh.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 0.6),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              widgetName,
              style: TextStyle(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
          ),
          for (final _MatrixCell c in cells)
            Expanded(
              child: Center(
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: c.honoured
                        ? scheme.primary.withValues(alpha: 0.85)
                        : scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: c.honoured
                          ? scheme.primary
                          : scheme.outlineVariant,
                    ),
                  ),
                  child: Icon(
                    c.honoured ? Icons.check : Icons.remove,
                    color: c.honoured
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                    size: 14.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 6 - Glossary + takeaways
  // -------------------------------------------------------------------------
  Widget _buildSection6GlossaryAndTakeaways(ColorScheme scheme) {
    print('=== Section 6: Glossary and takeaways ===');

    final List<List<String>> glossary = <List<String>>[
      <String>[
        'AccessibilityFeatures',
        'Immutable bitmask-like struct exposing all platform a11y flags.',
      ],
      <String>[
        'PlatformDispatcher',
        'Engine-level entry point. accessibilityFeatures lives there.',
      ],
      <String>[
        'MediaQuery.accessibleNavigationOf',
        'Convenience getter that triggers rebuilds when the flag changes.',
      ],
      <String>[
        'Semantics widget',
        'Annotates a sub-tree with labels and roles for assistive tech.',
      ],
      <String>[
        'WCAG AAA',
        'Highest contrast tier in the W3C accessibility guidelines.',
      ],
      <String>[
        'Vestibular disorder',
        'Inner-ear condition aggravated by on-screen motion.',
      ],
      <String>[
        'Cross-fade',
        'Opacity-only transition - usually acceptable under reduceMotion.',
      ],
      <String>[
        'Parallax',
        'Layered scrolling at different rates - banned under reduceMotion.',
      ],
      <String>[
        'Color inversion matrix',
        '4x5 matrix passed to ColorFilter.matrix to flip RGB channels.',
      ],
      <String>[
        'High-contrast scheme',
        'ColorScheme whose foreground/background pairs meet AAA contrast.',
      ],
    ];

    final List<List<String>> takeaways = <List<String>>[
      <String>[
        'Read flags via MediaQuery',
        'Never call PlatformDispatcher directly from widgets - the MediaQuery '
            'getters trigger rebuilds when the platform flips a flag.',
      ],
      <String>[
        'Treat the flags as guidance, not strict rules',
        'They describe user intent. The exact implementation is up to the '
            'app - reduceMotion can keep cross-fades, disableAnimations '
            'cannot.',
      ],
      <String>[
        'Combine flags carefully',
        'highContrast + boldText changes layout twice. Test the combination.',
      ],
      <String>[
        'Default to safety',
        'When unsure, err toward the more accessible variant. The cost is '
            'low; the user benefit is large.',
      ],
      <String>[
        'AST snapshot reminder',
        'In this AST execution we cannot read live flags - the previews '
            'above are hypothetical illustrations of each state.',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle('Section 6: Glossary and takeaways', scheme),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Glossary',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10.0),
              for (final List<String> pair in glossary)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 220.0,
                        child: Text(
                          pair[0],
                          style: TextStyle(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          pair[1],
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.primaryContainer,
                scheme.tertiaryContainer.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.lightbulb,
                    color: scheme.onPrimaryContainer,
                    size: 22.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Key takeaways',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              for (int i = 0; i < takeaways.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 28.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: scheme.onPrimaryContainer.withValues(
                            alpha: 0.15,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: scheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              takeaways[i][0],
                              style: TextStyle(
                                color: scheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              takeaways[i][1],
                              style: TextStyle(
                                color: scheme.onPrimaryContainer.withValues(
                                  alpha: 0.85,
                                ),
                                fontSize: 12.5,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Footer
  // -------------------------------------------------------------------------
  Widget _buildFooter(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.menu_book, size: 18.0, color: scheme.primary),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'End of demo. AccessibilityFeatures is intentionally read-only; '
              'the application reacts, the platform decides.',
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Shared helpers
  // -------------------------------------------------------------------------

  Widget _sectionTitle(String text, ColorScheme scheme) {
    return Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLeadIn(String text, ColorScheme scheme) {
    return Text(
      text,
      style: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 13.5,
        height: 1.5,
      ),
    );
  }

  Widget _labelledBlock(
    ColorScheme scheme,
    String label,
    String body,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: foreground,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            body,
            style: TextStyle(
              color: foreground,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _beforeAfter(
    ColorScheme scheme, {
    required _FlagSpec flag,
    required Widget before,
    required Widget after,
    required String caption,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: flag.accent.withValues(alpha: 0.5),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(flag.icon, color: flag.accent, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                flag.label,
                style: TextStyle(
                  color: flag.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: flag.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  flag.id,
                  style: TextStyle(
                    color: flag.accent,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _stateChip(scheme, 'Before (flag off)', Colors.grey),
                    const SizedBox(height: 6.0),
                    before,
                  ],
                ),
              ),
              const SizedBox(width: 14.0),
              Icon(
                Icons.arrow_forward,
                color: scheme.onSurfaceVariant,
                size: 22.0,
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _stateChip(scheme, 'After (flag on)', flag.accent),
                    const SizedBox(height: 6.0),
                    after,
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, color: flag.accent, size: 16.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    caption,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 12.0,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateChip(ColorScheme scheme, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11.0,
        ),
      ),
    );
  }

  // -----------------------------------------------------------------
  // Mock visual primitives used across the before/after panels.
  // -----------------------------------------------------------------

  Widget _phoneFrame(
    ColorScheme scheme,
    String caption,
    List<Widget> body,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fakeListTile(
    ColorScheme scheme,
    IconData icon,
    String label, {
    bool focus = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: focus
            ? scheme.primary.withValues(alpha: 0.12)
            : scheme.surface,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: focus ? scheme.primary : scheme.outlineVariant,
          width: focus ? 2.0 : 0.8,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
            color: focus ? scheme.primary : scheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              color: focus ? scheme.primary : scheme.onSurface,
              fontSize: 12.0,
              fontWeight: focus ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fakePhoto(ColorScheme scheme, {required bool inverted}) {
    // A stylized "photo" using gradients - the inverted version flips the
    // brightness of the gradient so the demo conveys what re-inversion
    // achieves visually.
    final List<Color> normal = <Color>[
      const Color(0xFFFFE082),
      const Color(0xFFFF8A65),
      const Color(0xFF1E88E5),
      const Color(0xFF0D47A1),
    ];
    final List<Color> flipped = <Color>[
      const Color(0xFF001F7F),
      const Color(0xFF00759A),
      const Color(0xFF00759A),
      const Color(0xFFFFFFB2),
    ];
    final List<Color> palette = inverted ? normal : flipped;
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: palette,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            inverted ? 're-inverted' : 'OS inverted',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 9.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _fakeMotionTrace(
    ColorScheme scheme, {
    required int count,
    required bool fading,
  }) {
    final List<Widget> dots = <Widget>[];
    for (int i = 0; i < count; i++) {
      final double opacity = fading ? (i + 1) / count : 1.0;
      dots.add(
        Container(
          margin: const EdgeInsets.only(right: 4.0),
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: opacity),
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: dots,
    );
  }

  Widget _fakeSpringCurve(ColorScheme scheme, {required bool springy}) {
    // Static visualisation of a curve - springy version draws an overshoot,
    // non-springy version draws a straight line.
    return SizedBox(
      height: 50.0,
      child: CustomPaint(
        painter: _CurvePainter(
          color: scheme.primary,
          springy: springy,
        ),
        size: const Size(double.infinity, 50.0),
      ),
    );
  }

  Widget _swatchRow(ColorScheme base, ColorScheme target) {
    final List<Color> swatches = <Color>[
      target.primary,
      target.onPrimary,
      target.secondary,
      target.tertiary,
      target.surface,
      target.onSurface,
      target.error,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (final Color c in swatches)
          Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: base.outlineVariant,
                width: 0.8,
              ),
            ),
          ),
      ],
    );
  }

  Widget _fakeSwitch(
    ColorScheme scheme, {
    required bool on,
    required bool showLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: on
                ? scheme.primary
                : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: on ? scheme.primary : scheme.outline,
              width: 1.2,
            ),
          ),
          child: Stack(
            children: <Widget>[
              if (showLabel)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'I',
                          style: TextStyle(
                            color: on
                                ? scheme.onPrimary
                                : scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w800,
                            fontSize: 11.0,
                          ),
                        ),
                        Text(
                          'O',
                          style: TextStyle(
                            color: on
                                ? scheme.onPrimary
                                : scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w800,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Align(
                alignment:
                    on ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          on ? 'enabled' : 'disabled',
          style: TextStyle(
            color: on ? scheme.primary : scheme.onSurfaceVariant,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Custom painter: draw a stylized animation curve. Static drawing only -
// no animation, this is one frame.
// ---------------------------------------------------------------------------

class _CurvePainter extends CustomPainter {
  _CurvePainter({required this.color, required this.springy});
  final Color color;
  final bool springy;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0.0, size.height - 1.0),
      Offset(size.width, size.height - 1.0),
      axis,
    );
    final Paint curve = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    final Path path = Path();
    if (springy) {
      // Overshoot then settle.
      path.moveTo(0.0, size.height);
      path.cubicTo(
        size.width * 0.25, size.height * 0.1,
        size.width * 0.55, -size.height * 0.1,
        size.width * 0.65, size.height * 0.3,
      );
      path.cubicTo(
        size.width * 0.75, size.height * 0.6,
        size.width * 0.85, size.height * 0.2,
        size.width, size.height * 0.4,
      );
    } else {
      // Straight linear interpolation.
      path.moveTo(0.0, size.height);
      path.lineTo(size.width, size.height * 0.4);
    }
    canvas.drawPath(path, curve);
  }

  @override
  bool shouldRepaint(covariant _CurvePainter old) =>
      old.color != color || old.springy != springy;
}
