// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of CupertinoPicker and
// CupertinoPicker.builder advanced configurations.
//
// Showcases the full parameter surface of CupertinoPicker including
// itemExtent, magnification, useMagnifier, squeeze, diameterRatio,
// backgroundColor, scrollController (FixedExtentScrollController) and
// selectionOverlay (CupertinoPickerDefaultSelectionOverlay), plus the
// CupertinoPicker.builder constructor with itemBuilder for fully
// custom row widgets.
//
// Constraints: static `dynamic build(BuildContext context)`, no
// setState, no animations, no mutable state, no `runApp` / `main`.
// Each picker keeps a non-const FixedExtentScrollController seeded
// with `initialItem` so a meaningful row is highlighted without any
// callback. All `onSelectedItemChanged` callbacks are no-ops `(int _)
// {}`. Must pass `flutter analyze` with zero issues. The d4rt
// static-only sandbox does not drive scroll animations, so each
// picker is rendered in a SizedBox-bound area with a fixed height.
//
// Stays material-free: only `package:flutter/cupertino.dart` is
// imported, and all icons come from `CupertinoIcons`.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'Cupertino Picker Advanced',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Advanced CupertinoPicker'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeroSection(),
            _buildIntroCard(),
            _buildDefaultConfigSection(),
            _buildMagnificationSection(),
            _buildSqueezeTighterSection(),
            _buildSqueezeLooserSection(),
            _buildCustomItemExtentSection(),
            _buildBuilderVariantSection(),
            _buildDiameterRatioSection(),
            _buildBackgroundColorSection(),
            _buildSelectionOverlaySection(),
            _buildAnatomyCountdownTimerSection(),
            _buildAnatomyTemperatureUnitSection(),
            _buildAnatomyFontWeightChooserSection(),
            _buildComparisonGuideSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Hero Section: Cupertino Picker brand header with stacked silhouettes
// ============================================================================

Widget _buildHeroSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5E5CE6),
          Color(0xFFAF52DE),
          Color(0xFFFF2D55),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x405E5CE6),
          blurRadius: 32,
          offset: Offset(0, 16),
        ),
        BoxShadow(
          color: Color(0x33FF2D55),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: const [
            _PrivateHeroBadge(
              icon: CupertinoIcons.slider_horizontal_3,
              label: 'PICKER GALLERY',
            ),
            Spacer(),
            Icon(
              CupertinoIcons.sparkles,
              color: Color(0xFFFFFFFF),
              size: 28,
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Cupertino Picker',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Wheel selection, the Apple way',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 22),
        const _PrivateHeroSilhouettes(),
      ],
    ),
  );
}

// ============================================================================
// Intro Card
// ============================================================================

Widget _buildIntroCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Row(
          children: [
            Icon(
              CupertinoIcons.info_circle_fill,
              color: Color(0xFF007AFF),
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'About this gallery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Each card below renders one CupertinoPicker (or '
          'CupertinoPicker.builder) configured to highlight a single '
          'parameter. Every picker uses its own FixedExtentScrollController '
          'so the wheel rests on a meaningful row without callbacks.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF3C3C43),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Default config — months, itemExtent: 32
// ============================================================================

Widget _buildDefaultConfigSection() {
  final controller = FixedExtentScrollController(initialItem: 4);
  const months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return _PrivateSection(
    accent: const Color(0xFF34C759),
    icon: CupertinoIcons.calendar,
    title: 'Default configuration',
    subtitle: 'itemExtent: 32, magnification: 1.0, useMagnifier: false',
    body: SizedBox(
      height: 180,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 32,
        magnification: 1.0,
        useMagnifier: false,
        squeeze: 1.45,
        diameterRatio: 1.07,
        backgroundColor: const Color(0xFFFFFFFF),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final month in months)
            Center(
              child: Text(
                month,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'Default itemExtent is the typical 32pt row used in iOS pickers.',
      'No magnifier means the centered row is rendered identically to others.',
    ],
  );
}

// ============================================================================
// Section: Magnification on — years 2010..2030
// ============================================================================

Widget _buildMagnificationSection() {
  final controller = FixedExtentScrollController(initialItem: 16);
  final years = <int>[for (int y = 2010; y <= 2030; y++) y];
  return _PrivateSection(
    accent: const Color(0xFF007AFF),
    icon: CupertinoIcons.search_circle_fill,
    title: 'Magnification on',
    subtitle: 'magnification: 1.2, useMagnifier: true',
    body: SizedBox(
      height: 200,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 36,
        magnification: 1.2,
        useMagnifier: true,
        squeeze: 1.2,
        diameterRatio: 1.2,
        backgroundColor: const Color(0xFFF2F2F7),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final y in years)
            Center(
              child: Text(
                y.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'magnification scales the centered row to draw the eye.',
      'useMagnifier: true paints a subtle lens overlay above the row.',
    ],
  );
}

// ============================================================================
// Section: Squeeze tighter — fonts, squeeze: 1.45
// ============================================================================

Widget _buildSqueezeTighterSection() {
  final controller = FixedExtentScrollController(initialItem: 2);
  const fonts = <String>[
    'San Francisco',
    'Helvetica',
    'Avenir',
    'Menlo',
    'New York',
    'Courier',
    'Georgia',
    'Optima',
    'Palatino',
    'Times New Roman',
  ];
  return _PrivateSection(
    accent: const Color(0xFFAF52DE),
    icon: CupertinoIcons.textformat_size,
    title: 'Squeeze: tighter (1.45)',
    subtitle: 'Rows compress vertically for a denser wheel',
    body: SizedBox(
      height: 190,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 34,
        magnification: 1.1,
        useMagnifier: true,
        squeeze: 1.45,
        diameterRatio: 1.07,
        backgroundColor: const Color(0xFFFFFFFF),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final f in fonts)
            Center(
              child: Text(
                f,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'A squeeze > 1.0 packs more rows into the same wheel area.',
      'Useful for long lists where dense scanning beats per-row clarity.',
    ],
  );
}

// ============================================================================
// Section: Squeeze looser — cities, squeeze: 1.0
// ============================================================================

Widget _buildSqueezeLooserSection() {
  final controller = FixedExtentScrollController(initialItem: 3);
  const cities = <String>[
    'Cupertino',
    'Tokyo',
    'Berlin',
    'Sydney',
    'Buenos Aires',
    'Reykjavik',
    'Cape Town',
    'New York',
    'Mumbai',
    'Singapore',
    'Stockholm',
    'Lima',
  ];
  return _PrivateSection(
    accent: const Color(0xFFFF9500),
    icon: CupertinoIcons.globe,
    title: 'Squeeze: looser (1.0)',
    subtitle: 'Rows breathe, fewer rows visible at once',
    body: SizedBox(
      height: 200,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 38,
        magnification: 1.15,
        useMagnifier: true,
        squeeze: 1.0,
        diameterRatio: 1.07,
        backgroundColor: const Color(0xFFFFF9F2),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final c in cities)
            Center(
              child: Text(
                c,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'squeeze: 1.0 is the airiest setting — minimum perspective compression.',
      'Pairs nicely with magnification for clearly-visible centered values.',
    ],
  );
}

// ============================================================================
// Section: Custom itemExtent — pricing tiers, 50pt rows
// ============================================================================

Widget _buildCustomItemExtentSection() {
  final controller = FixedExtentScrollController(initialItem: 1);
  const tiers = <String>[
    'Starter — \$0/mo',
    'Pro — \$9/mo',
    'Team — \$29/mo',
    'Business — \$79/mo',
    'Enterprise — Custom',
  ];
  return _PrivateSection(
    accent: const Color(0xFFFF2D55),
    icon: CupertinoIcons.tag_fill,
    title: 'Custom itemExtent (50pt)',
    subtitle: 'Tall rows for premium aesthetics',
    body: SizedBox(
      height: 220,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 50,
        magnification: 1.1,
        useMagnifier: true,
        squeeze: 1.05,
        diameterRatio: 1.2,
        backgroundColor: const Color(0xFFFFFFFF),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final t in tiers)
            Center(
              child: Text(
                t,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'A larger itemExtent gives each row more room to feature icons or '
          'multi-line content.',
      'Helpful when rows must double as marketing-style cards.',
    ],
  );
}

// ============================================================================
// Section: CupertinoPicker.builder variant — colorful icon cards per row
// ============================================================================

Widget _buildBuilderVariantSection() {
  final controller = FixedExtentScrollController(initialItem: 3);
  return _PrivateSection(
    accent: const Color(0xFF5856D6),
    icon: CupertinoIcons.square_grid_2x2_fill,
    title: 'CupertinoPicker.builder',
    subtitle: 'itemBuilder produces colorful per-row cards',
    body: SizedBox(
      height: 240,
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: 56,
        magnification: 1.1,
        useMagnifier: true,
        squeeze: 1.1,
        diameterRatio: 1.3,
        backgroundColor: const Color(0xFFFFFFFF),
        onSelectedItemChanged: (int _) {},
        childCount: _PrivateBuilderRow.entries.length,
        itemBuilder: (BuildContext context, int index) {
          final entry = _PrivateBuilderRow.entries[index];
          return _PrivateBuilderRow(entry: entry);
        },
      ),
    ),
    notes: const [
      'CupertinoPicker.builder defers row construction to itemBuilder, '
          'which is more efficient for very long lists.',
      'childCount must be supplied so the wheel knows the total length.',
    ],
  );
}

// ============================================================================
// Section: Diameter ratio playground — 0.7 vs 1.4 side by side
// ============================================================================

Widget _buildDiameterRatioSection() {
  final left = FixedExtentScrollController(initialItem: 2);
  final right = FixedExtentScrollController(initialItem: 4);
  const planets = <String>[
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
  ];
  return _PrivateSection(
    accent: const Color(0xFF32ADE6),
    icon: CupertinoIcons.circle_grid_3x3_fill,
    title: 'diameterRatio playground',
    subtitle: '0.7 (curvy) vs 1.4 (flatter)',
    body: SizedBox(
      height: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE5F4FF),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'diameterRatio: 0.7',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: left,
                      itemExtent: 34,
                      magnification: 1.1,
                      useMagnifier: true,
                      squeeze: 1.2,
                      diameterRatio: 0.7,
                      backgroundColor: const Color(0xFFFFFFFF),
                      onSelectedItemChanged: (int _) {},
                      children: <Widget>[
                        for (final p in planets)
                          Center(
                            child: Text(
                              p,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1C1C1E),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFE9F0),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'diameterRatio: 1.4',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: right,
                      itemExtent: 34,
                      magnification: 1.1,
                      useMagnifier: true,
                      squeeze: 1.2,
                      diameterRatio: 1.4,
                      backgroundColor: const Color(0xFFFFFFFF),
                      onSelectedItemChanged: (int _) {},
                      children: <Widget>[
                        for (final p in planets)
                          Center(
                            child: Text(
                              p,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1C1C1E),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    notes: const [
      'Smaller diameterRatio = a more pronounced cylinder curve.',
      'Larger diameterRatio = flatter, almost-flat list look.',
    ],
  );
}

// ============================================================================
// Section: Background color theming — dark-on-dark and light-on-light
// ============================================================================

Widget _buildBackgroundColorSection() {
  final dark = FixedExtentScrollController(initialItem: 1);
  final light = FixedExtentScrollController(initialItem: 3);
  const moods = <String>[
    'Calm',
    'Focus',
    'Energetic',
    'Sleep',
    'Workout',
    'Meditation',
  ];
  return _PrivateSection(
    accent: const Color(0xFF1C1C1E),
    icon: CupertinoIcons.paintbrush_fill,
    title: 'Background color theming',
    subtitle: 'Dark-on-dark and light-on-light pickers',
    body: SizedBox(
      height: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Dark mode',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: dark,
                      itemExtent: 34,
                      magnification: 1.1,
                      useMagnifier: true,
                      squeeze: 1.2,
                      diameterRatio: 1.07,
                      backgroundColor: const Color(0xFF000000),
                      onSelectedItemChanged: (int _) {},
                      children: <Widget>[
                        for (final m in moods)
                          Center(
                            child: Text(
                              m,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBE6),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14FFD60A),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Light mode',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: light,
                      itemExtent: 34,
                      magnification: 1.1,
                      useMagnifier: true,
                      squeeze: 1.2,
                      diameterRatio: 1.07,
                      backgroundColor: const Color(0xFFFFFFFF),
                      onSelectedItemChanged: (int _) {},
                      children: <Widget>[
                        for (final m in moods)
                          Center(
                            child: Text(
                              m,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1C1C1E),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    notes: const [
      'backgroundColor opaque values disable the auto-fade gradient at the '
          'top and bottom of the wheel.',
      'A null backgroundColor lets parent surfaces show through.',
    ],
  );
}

// ============================================================================
// Section: Selection-overlay gallery — customised colors
// ============================================================================

Widget _buildSelectionOverlaySection() {
  final blue = FixedExtentScrollController(initialItem: 2);
  final pink = FixedExtentScrollController(initialItem: 4);
  final green = FixedExtentScrollController(initialItem: 1);
  const numbers = <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
  ];
  return _PrivateSection(
    accent: const Color(0xFFFFD60A),
    icon: CupertinoIcons.square_stack_3d_up_fill,
    title: 'selectionOverlay gallery',
    subtitle: 'CupertinoPickerDefaultSelectionOverlay with theme tints',
    body: SizedBox(
      height: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _PrivateOverlayCard(
              label: 'Indigo tint',
              accent: const Color(0xFF5E5CE6),
              picker: CupertinoPicker(
                scrollController: blue,
                itemExtent: 34,
                magnification: 1.1,
                useMagnifier: true,
                squeeze: 1.2,
                diameterRatio: 1.07,
                backgroundColor: const Color(0xFFFFFFFF),
                selectionOverlay:
                    const CupertinoPickerDefaultSelectionOverlay(
                  background: Color(0x335E5CE6),
                  capStartEdge: true,
                  capEndEdge: true,
                ),
                onSelectedItemChanged: (int _) {},
                children: <Widget>[
                  for (final n in numbers)
                    Center(child: Text(n, style: _PrivateOverlayCard.style)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _PrivateOverlayCard(
              label: 'Pink tint',
              accent: const Color(0xFFFF2D55),
              picker: CupertinoPicker(
                scrollController: pink,
                itemExtent: 34,
                magnification: 1.1,
                useMagnifier: true,
                squeeze: 1.2,
                diameterRatio: 1.07,
                backgroundColor: const Color(0xFFFFFFFF),
                selectionOverlay:
                    const CupertinoPickerDefaultSelectionOverlay(
                  background: Color(0x33FF2D55),
                  capStartEdge: true,
                  capEndEdge: true,
                ),
                onSelectedItemChanged: (int _) {},
                children: <Widget>[
                  for (final n in numbers)
                    Center(child: Text(n, style: _PrivateOverlayCard.style)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _PrivateOverlayCard(
              label: 'Mint tint',
              accent: const Color(0xFF34C759),
              picker: CupertinoPicker(
                scrollController: green,
                itemExtent: 34,
                magnification: 1.1,
                useMagnifier: true,
                squeeze: 1.2,
                diameterRatio: 1.07,
                backgroundColor: const Color(0xFFFFFFFF),
                selectionOverlay:
                    const CupertinoPickerDefaultSelectionOverlay(
                  background: Color(0x3334C759),
                  capStartEdge: false,
                  capEndEdge: false,
                ),
                onSelectedItemChanged: (int _) {},
                children: <Widget>[
                  for (final n in numbers)
                    Center(child: Text(n, style: _PrivateOverlayCard.style)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    notes: const [
      'CupertinoPickerDefaultSelectionOverlay paints the highlight under '
          'the centered row.',
      'capStartEdge / capEndEdge round the corresponding side of the pill.',
    ],
  );
}

// ============================================================================
// Anatomy: Countdown timer — minutes and seconds picker
// ============================================================================

Widget _buildAnatomyCountdownTimerSection() {
  final mins = FixedExtentScrollController(initialItem: 12);
  final secs = FixedExtentScrollController(initialItem: 30);
  return _PrivateSection(
    accent: const Color(0xFFFF9500),
    icon: CupertinoIcons.timer_fill,
    title: 'Anatomy: Countdown timer',
    subtitle: 'Minutes + seconds, side-by-side wheels',
    body: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFE5B4),
            Color(0xFFFFD60A),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33FF9500),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      height: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                const Text(
                  'minutes',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: mins,
                    itemExtent: 36,
                    magnification: 1.2,
                    useMagnifier: true,
                    squeeze: 1.1,
                    diameterRatio: 1.07,
                    backgroundColor: const Color(0x00000000),
                    onSelectedItemChanged: (int _) {},
                    children: <Widget>[
                      for (int i = 0; i < 60; i++)
                        Center(
                          child: Text(
                            i.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1C1C1E),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: <Widget>[
                const Text(
                  'seconds',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: secs,
                    itemExtent: 36,
                    magnification: 1.2,
                    useMagnifier: true,
                    squeeze: 1.1,
                    diameterRatio: 1.07,
                    backgroundColor: const Color(0x00000000),
                    onSelectedItemChanged: (int _) {},
                    children: <Widget>[
                      for (int i = 0; i < 60; i++)
                        Center(
                          child: Text(
                            i.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1C1C1E),
                            ),
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
    notes: const [
      'Two CupertinoPickers can be composed for fixed-shape compound '
          'inputs like timers.',
      'For real timer UI, prefer CupertinoTimerPicker which already '
          'composes mm:ss / h:mm:ss internally.',
    ],
  );
}

// ============================================================================
// Anatomy: Temperature unit chooser
// ============================================================================

Widget _buildAnatomyTemperatureUnitSection() {
  final controller = FixedExtentScrollController(initialItem: 1);
  const units = <String>['Celsius (\u00B0C)', 'Fahrenheit (\u00B0F)', 'Kelvin (K)'];
  return _PrivateSection(
    accent: const Color(0xFF32ADE6),
    icon: CupertinoIcons.thermometer,
    title: 'Anatomy: Temperature unit',
    subtitle: 'Three-row chooser with magnification',
    body: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE5F4FF),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2232ADE6),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      height: 200,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 44,
        magnification: 1.25,
        useMagnifier: true,
        squeeze: 1.0,
        diameterRatio: 1.5,
        backgroundColor: const Color(0x00000000),
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Color(0x3332ADE6),
          capStartEdge: true,
          capEndEdge: true,
        ),
        onSelectedItemChanged: (int _) {},
        children: <Widget>[
          for (final u in units)
            Center(
              child: Text(
                u,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
        ],
      ),
    ),
    notes: const [
      'Short fixed lists work well in CupertinoPicker; use bigger '
          'itemExtent for accessibility.',
      'A flat diameterRatio (1.5) keeps just three rows on screen at once.',
    ],
  );
}

// ============================================================================
// Anatomy: Font weight chooser
// ============================================================================

Widget _buildAnatomyFontWeightChooserSection() {
  final controller = FixedExtentScrollController(initialItem: 4);
  return _PrivateSection(
    accent: const Color(0xFFAF52DE),
    icon: CupertinoIcons.bold,
    title: 'Anatomy: Font weight chooser',
    subtitle: 'Builder variant with live-styled rows',
    body: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF6E9FF),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33AF52DE),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      height: 230,
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: 44,
        magnification: 1.15,
        useMagnifier: true,
        squeeze: 1.05,
        diameterRatio: 1.2,
        backgroundColor: const Color(0x00000000),
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Color(0x33AF52DE),
        ),
        onSelectedItemChanged: (int _) {},
        childCount: _PrivateWeightRow.weights.length,
        itemBuilder: (BuildContext context, int index) {
          return _PrivateWeightRow(index: index);
        },
      ),
    ),
    notes: const [
      'CupertinoPicker.builder lets each row preview its own selection — '
          'each weight is rendered with its actual FontWeight.',
      'Combine with a tinted selectionOverlay for a polished feel.',
    ],
  );
}

// ============================================================================
// Comparison guide — when to choose which control
// ============================================================================

Widget _buildComparisonGuideSection() {
  return Container(
    margin: const EdgeInsets.only(top: 8, bottom: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.lightbulb_fill,
              color: Color(0xFFFFD60A),
              size: 22,
            ),
            SizedBox(width: 10),
            Text(
              'When to choose what',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        _PrivateGuideRow(
          title: 'CupertinoPicker',
          body: 'Use when the platform is iOS / iPadOS, the value space is '
              'medium-sized (10..200 items) and the user expects native '
              'wheel feel. Always wrap in a fixed-height container.',
          color: Color(0xFF007AFF),
          icon: CupertinoIcons.slider_horizontal_3,
        ),
        SizedBox(height: 10),
        _PrivateGuideRow(
          title: 'DropdownButton',
          body: 'Reach for a Material DropdownButton when the value space '
              'is small (< 8 items) and you want a compact form-style '
              'control that does not occupy permanent vertical space.',
          color: Color(0xFF34C759),
          icon: CupertinoIcons.chevron_down_circle_fill,
        ),
        SizedBox(height: 10),
        _PrivateGuideRow(
          title: 'showCupertinoModalPopup<int>',
          body: 'Use a modal popup hosting a CupertinoPicker when the '
              'value space is large (> 200 items) or selection is rare — '
              'keeps the main canvas clean and surfaces a focused choice.',
          color: Color(0xFFFF2D55),
          icon: CupertinoIcons.square_stack_fill,
        ),
        SizedBox(height: 10),
        _PrivateGuideRow(
          title: 'CupertinoPicker.builder',
          body: 'Pick this constructor over the children-based one when '
              'the list is dynamic, very long, or each row is expensive '
              'to materialise eagerly.',
          color: Color(0xFFAF52DE),
          icon: CupertinoIcons.layers_alt_fill,
        ),
      ],
    ),
  );
}

// ============================================================================
// Private widgets
// ============================================================================

class _PrivateHeroBadge extends StatelessWidget {
  const _PrivateHeroBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: const Color(0xFFFFFFFF), size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroSilhouettes extends StatelessWidget {
  const _PrivateHeroSilhouettes();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: const <Widget>[
          _PrivateSilhouette(
            offset: Offset(-90, 12),
            width: 110,
            height: 96,
            color: Color(0x40FFFFFF),
            tint: Color(0xFFFFD60A),
          ),
          _PrivateSilhouette(
            offset: Offset(90, 12),
            width: 110,
            height: 96,
            color: Color(0x40FFFFFF),
            tint: Color(0xFF32ADE6),
          ),
          _PrivateSilhouette(
            offset: Offset(0, 0),
            width: 130,
            height: 116,
            color: Color(0x66FFFFFF),
            tint: Color(0xFFFFFFFF),
          ),
        ],
      ),
    );
  }
}

class _PrivateSilhouette extends StatelessWidget {
  const _PrivateSilhouette({
    required this.offset,
    required this.width,
    required this.height,
    required this.color,
    required this.tint,
  });

  final Offset offset;
  final double width;
  final double height;
  final Color color;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Container(
          width: width - 24,
          height: 18,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _PrivateSection extends StatelessWidget {
  const _PrivateSection({
    required this.accent,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.notes,
  });

  final Color accent;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget body;
  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.95),
                  accent.withValues(alpha: 0.65),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, color: const Color(0xFFFFFFFF), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xCCFFFFFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: body,
          ),
          if (notes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final note in notes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            color: accent,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              note,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: Color(0xFF3C3C43),
                              ),
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
    );
  }
}

class _PrivateBuilderEntry {
  const _PrivateBuilderEntry({
    required this.label,
    required this.icon,
    required this.color,
  });
  final String label;
  final IconData icon;
  final Color color;
}

class _PrivateBuilderRow extends StatelessWidget {
  const _PrivateBuilderRow({required this.entry});

  final _PrivateBuilderEntry entry;

  static const List<_PrivateBuilderEntry> entries = <_PrivateBuilderEntry>[
    _PrivateBuilderEntry(
      label: 'Photos',
      icon: CupertinoIcons.photo_fill,
      color: Color(0xFFFF9500),
    ),
    _PrivateBuilderEntry(
      label: 'Music',
      icon: CupertinoIcons.music_note_2,
      color: Color(0xFFFF2D55),
    ),
    _PrivateBuilderEntry(
      label: 'Books',
      icon: CupertinoIcons.book_fill,
      color: Color(0xFF34C759),
    ),
    _PrivateBuilderEntry(
      label: 'Maps',
      icon: CupertinoIcons.map_fill,
      color: Color(0xFF007AFF),
    ),
    _PrivateBuilderEntry(
      label: 'Mail',
      icon: CupertinoIcons.envelope_fill,
      color: Color(0xFF5E5CE6),
    ),
    _PrivateBuilderEntry(
      label: 'Calendar',
      icon: CupertinoIcons.calendar,
      color: Color(0xFFFFD60A),
    ),
    _PrivateBuilderEntry(
      label: 'Camera',
      icon: CupertinoIcons.camera_fill,
      color: Color(0xFFAF52DE),
    ),
    _PrivateBuilderEntry(
      label: 'Notes',
      icon: CupertinoIcons.doc_text_fill,
      color: Color(0xFFFF9F0A),
    ),
    _PrivateBuilderEntry(
      label: 'Files',
      icon: CupertinoIcons.folder_fill,
      color: Color(0xFF32ADE6),
    ),
    _PrivateBuilderEntry(
      label: 'Health',
      icon: CupertinoIcons.heart_fill,
      color: Color(0xFFFF375F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              entry.color.withValues(alpha: 0.95),
              entry.color.withValues(alpha: 0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: entry.color.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: <Widget>[
            Icon(entry.icon, color: const Color(0xFFFFFFFF), size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                entry.label,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xFFFFFFFF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateOverlayCard extends StatelessWidget {
  const _PrivateOverlayCard({
    required this.label,
    required this.accent,
    required this.picker,
  });

  final String label;
  final Color accent;
  final Widget picker;

  static const TextStyle style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1C1C1E),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.25), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(child: picker),
        ],
      ),
    );
  }
}

class _PrivateWeightRow extends StatelessWidget {
  const _PrivateWeightRow({required this.index});

  final int index;

  static const List<FontWeight> weights = <FontWeight>[
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];

  static const List<String> labels = <String>[
    'Thin',
    'ExtraLight',
    'Light',
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
    'ExtraBold',
    'Black',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        labels[index],
        style: TextStyle(
          fontSize: 20,
          fontWeight: weights[index],
          color: const Color(0xFF1C1C1E),
        ),
      ),
    );
  }
}

class _PrivateGuideRow extends StatelessWidget {
  const _PrivateGuideRow({
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });

  final String title;
  final String body;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEDEF), width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: const Color(0xFFFFFFFF), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF3C3C43),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
