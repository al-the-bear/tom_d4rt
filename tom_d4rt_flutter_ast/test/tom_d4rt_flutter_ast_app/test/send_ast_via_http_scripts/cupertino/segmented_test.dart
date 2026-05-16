// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Cupertino Segmented Selector Gallery
// Theme: "iOS Segmented Selector Gallery"
// A visual field guide to CupertinoSegmentedControl and CupertinoSlidingSegmentedControl,
// covering colors, custom children, sliding variants, theming, accessibility, layout, and recipes.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ============================================================================
// HELPER: Hero header banner
// ============================================================================
Widget _heroHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6), Color(0xFFBF5AF2)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(CupertinoIcons.square_split_2x1_fill,
                  color: Colors.white, size: 32.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('iOS Segmented Selector Gallery',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2)),
                  SizedBox(height: 4.0),
                  Text('A visual field guide to Cupertino segmented controls',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(spacing: 8.0, runSpacing: 8.0, children: [
          _heroChip('CupertinoSegmentedControl'),
          _heroChip('CupertinoSlidingSegmentedControl'),
          _heroChip('selectedColor'),
          _heroChip('unselectedColor'),
          _heroChip('borderColor'),
          _heroChip('pressedColor'),
          _heroChip('thumbColor'),
          _heroChip('groupValue'),
          _heroChip('onValueChanged'),
        ]),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.22),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.0),
    ),
    child: Text(label,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace')),
  );
}

// ============================================================================
// HELPER: Section banner
// ============================================================================
Widget _sectionBanner(int n, String title, String subtitle, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [accent.withOpacity(0.96), accent.withOpacity(0.62)],
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.22),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Text(n.toString().padLeft(2, '0'),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 17.0)),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 2.0),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Concept overview
// ============================================================================
Widget _conceptOverview() {
  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFD1D1D6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(CupertinoIcons.info_circle_fill,
              color: Color(0xFF0A84FF), size: 22.0),
          SizedBox(width: 10.0),
          Text('Concept Overview',
              style: TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 12.0),
        Text(
            'Cupertino segmented controls offer two complementary flavors. The classic '
            'CupertinoSegmentedControl mirrors iOS 12 styling: bordered pill, full-color '
            'selected segment. The sliding variant mirrors iOS 13+ styling: rounded plate '
            'with a floating thumb that animates between segments.',
            style: TextStyle(
                color: Color(0xFF3A3A3C), fontSize: 13.5, height: 1.45)),
        SizedBox(height: 14.0),
        _bulletLine(CupertinoIcons.circle_fill, Color(0xFF0A84FF),
            'children: Map<T, Widget> — at least two entries are required.'),
        _bulletLine(CupertinoIcons.circle_fill, Color(0xFF30D158),
            'groupValue: T? — currently selected key (null for none).'),
        _bulletLine(CupertinoIcons.circle_fill, Color(0xFFFF9F0A),
            'onValueChanged: ValueChanged<T> — invoked when a segment is tapped.'),
        _bulletLine(CupertinoIcons.circle_fill, Color(0xFFBF5AF2),
            'Classic adds selectedColor, unselectedColor, borderColor, pressedColor.'),
        _bulletLine(CupertinoIcons.circle_fill, Color(0xFFFF375F),
            'Sliding adds backgroundColor and thumbColor.'),
      ],
    ),
  );
}

Widget _bulletLine(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.only(top: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(icon, color: color, size: 9.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Recipe card
// ============================================================================
Widget _recipeCard(
    String title, String description, List<String> snippet, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withOpacity(0.45), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.20),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(13.0)),
          ),
          child: Row(children: [
            Icon(CupertinoIcons.doc_text_fill,
                color: accent, size: 16.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text('Recipe: $title',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800)),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Text(description,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  height: 1.45,
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF0D0D0F),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withOpacity(0.30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: snippet
                .map((line) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5),
                      child: Text(line,
                          style: TextStyle(
                              color: accent.withOpacity(0.95),
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                              height: 1.35)),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Comparison table
// ============================================================================
Widget _comparisonTable(
    String title, List<List<String>> rows, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.0),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.16),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(13.0)),
          ),
          child: Row(children: [
            Icon(CupertinoIcons.table, color: accent, size: 16.0),
            SizedBox(width: 8.0),
            Text(title,
                style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800)),
          ]),
        ),
        ...rows.asMap().entries.map((entry) {
          final idx = entry.key;
          final row = entry.value;
          final isHeader = idx == 0;
          return Container(
            padding:
                EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isHeader
                  ? accent.withOpacity(0.06)
                  : (idx.isEven ? Color(0xFFF8F8FA) : Colors.white),
              border: Border(
                top: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
              ),
            ),
            child: Row(
              children: row
                  .map((cell) => Expanded(
                        child: Text(cell,
                            style: TextStyle(
                                color: isHeader
                                    ? accent
                                    : Color(0xFF1C1C1E),
                                fontSize: isHeader ? 11.5 : 11.5,
                                fontWeight: isHeader
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                fontFamily: isHeader ? null : 'monospace')),
                      ))
                  .toList(),
            ),
          );
        }),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Demo frame (wraps a control in a labeled card)
// ============================================================================
Widget _demoFrame(String caption, Color accent, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [accent.withOpacity(0.08), accent.withOpacity(0.18)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withOpacity(0.45), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 6.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          SizedBox(width: 10.0),
          Text(caption,
              style: TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFE5E5EA)),
          ),
          child: child,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: CLASSIC SEGMENTED CONTROL — BASIC
// ============================================================================
Widget _section1() {
  final accent = Color(0xFF0A84FF);
  final palette = {
    'primary': Color(0xFF0A84FF),
    'soft': Color(0xFFCCE4FF),
    'ink': Color(0xFF003C8F),
  };

  // Day / Week / Month picker — the canonical chart range selector.
  final basic = CupertinoSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('Day')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('Week')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('Month')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(1, 'Classic Segmented — Basic',
          'CupertinoSegmentedControl with integer keys', accent),
      _demoFrame('Chart range picker (Day / Week / Month)', accent, basic),
      _recipeCard(
        'Integer-keyed segmented control',
        'Use int keys when the segments are an ordered enum-like range. '
            'Wrap each label in Padding for comfortable touch targets.',
        [
          'CupertinoSegmentedControl<int>(',
          '  children: {',
          '    0: Text("Day"),',
          '    1: Text("Week"),',
          '    2: Text("Month"),',
          '  },',
          '  groupValue: selectedRange,',
          '  onValueChanged: (v) => setRange(v),',
          ')',
        ],
        accent,
      ),
      _comparisonTable(
          'Anatomy of the classic control',
          [
            ['Property', 'Type', 'Used by section'],
            ['children', 'Map<T, Widget>', '1, 2, 3, 7'],
            ['groupValue', 'T?', '1, 2, 3, 7'],
            ['onValueChanged', 'ValueChanged<T>', 'all sections'],
            ['selectedColor', 'Color?', '2, 6'],
            ['unselectedColor', 'Color?', '2, 6'],
            ['borderColor', 'Color?', '2, 6'],
            ['pressedColor', 'Color?', '2, 6'],
          ],
          accent),
    ],
  );
}

// ============================================================================
// SECTION 2: CLASSIC SEGMENTED — CUSTOM COLORS
// ============================================================================
Widget _section2() {
  final accent = Color(0xFF30D158);

  final greenTheme = CupertinoSegmentedControl<String>(
    children: {
      'a': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Alpha')),
      'b': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Beta')),
      'c': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Gamma')),
    },
    groupValue: 'a',
    onValueChanged: (v) {},
    selectedColor: CupertinoColors.systemGreen,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemGreen,
    pressedColor: CupertinoColors.systemGreen.withOpacity(0.20),
  );

  final orangeTheme = CupertinoSegmentedControl<String>(
    children: {
      'x': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Low')),
      'y': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Med')),
      'z': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('High')),
    },
    groupValue: 'y',
    onValueChanged: (v) {},
    selectedColor: CupertinoColors.systemOrange,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemOrange,
    pressedColor: CupertinoColors.systemOrange.withOpacity(0.20),
  );

  final pinkTheme = CupertinoSegmentedControl<String>(
    children: {
      '1': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Hearts')),
      '2': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Likes')),
      '3': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Saves')),
    },
    groupValue: '3',
    onValueChanged: (v) {},
    selectedColor: CupertinoColors.systemPink,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemPink,
    pressedColor: CupertinoColors.systemPink.withOpacity(0.20),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(
          2,
          'Classic Segmented — Color Themes',
          'selectedColor + unselectedColor + borderColor + pressedColor',
          accent),
      _demoFrame('Green theme (Alpha / Beta / Gamma)', accent, greenTheme),
      _demoFrame(
          'Orange theme (Low / Med / High)', Color(0xFFFF9F0A), orangeTheme),
      _demoFrame('Pink theme (Hearts / Likes / Saves)',
          Color(0xFFFF375F), pinkTheme),
      _recipeCard(
        'Theming with the four color slots',
        'The classic control exposes four color knobs. Keep selectedColor '
            'and borderColor in the same family for visual cohesion.',
        [
          'CupertinoSegmentedControl<String>(',
          '  selectedColor: CupertinoColors.systemGreen,',
          '  unselectedColor: CupertinoColors.white,',
          '  borderColor: CupertinoColors.systemGreen,',
          '  pressedColor: CupertinoColors.systemGreen',
          '      .withOpacity(0.20),',
          '  children: { ... },',
          '  groupValue: groupValue,',
          '  onValueChanged: onValueChanged,',
          ')',
        ],
        accent,
      ),
      _comparisonTable(
          'Color slot semantics',
          [
            ['Slot', 'When', 'Tip'],
            ['selectedColor', 'fills the active segment', 'use brand hue'],
            ['unselectedColor', 'fills inactive segments', 'usually white'],
            ['borderColor', 'paints outer border', 'match selectedColor'],
            ['pressedColor', 'tap feedback fill', 'use 20% selected'],
          ],
          accent),
    ],
  );
}

// ============================================================================
// SECTION 3: CLASSIC SEGMENTED — CUSTOM CHILDREN (TEXT + ICON)
// ============================================================================
Widget _section3() {
  final accent = Color(0xFFFF9F0A);

  Widget cell(IconData icon, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0),
          SizedBox(width: 6.0),
          Text(label),
        ],
      ),
    );
  }

  final richChildren = CupertinoSegmentedControl<int>(
    children: {
      0: cell(CupertinoIcons.house_fill, 'Home'),
      1: cell(CupertinoIcons.search, 'Search'),
      2: cell(CupertinoIcons.person_fill, 'Me'),
    },
    groupValue: 0,
    onValueChanged: (v) {},
  );

  final twoLine = CupertinoSegmentedControl<int>(
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('USD',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13.0)),
            Text('Dollar',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF8E8E93))),
          ],
        ),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('EUR',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13.0)),
            Text('Euro',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF8E8E93))),
          ],
        ),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('JPY',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13.0)),
            Text('Yen',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF8E8E93))),
          ],
        ),
      ),
    },
    groupValue: 1,
    onValueChanged: (v) {},
    selectedColor: CupertinoColors.systemIndigo,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemIndigo,
    pressedColor: CupertinoColors.systemIndigo.withOpacity(0.20),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(3, 'Classic Segmented — Rich Children',
          'Icons, two-line text, and combinations', accent),
      _demoFrame('Icon + label cells', accent, richChildren),
      _demoFrame(
          'Two-line cells (code + name)', Color(0xFF5856D6), twoLine),
      _recipeCard(
        'Building rich segment cells',
        'Wrap each child in Padding(symmetric horizontal: 12, vertical: 6). '
            'Use Row(mainAxisSize: min) for icon+label, Column for two-line.',
        [
          'children: {',
          '  0: Padding(',
          '    padding: EdgeInsets.symmetric(',
          '        horizontal: 12, vertical: 6),',
          '    child: Row(',
          '      mainAxisSize: MainAxisSize.min,',
          '      children: [',
          '        Icon(CupertinoIcons.house_fill, size: 14),',
          '        SizedBox(width: 6),',
          '        Text("Home"),',
          '      ],',
          '    ),',
          '  ),',
          '}',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 4: SLIDING SEGMENTED — BASIC
// ============================================================================
Widget _section4() {
  final accent = Color(0xFFBF5AF2);

  final calls = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('All')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('Missed')),
    },
    groupValue: 0,
    onValueChanged: (v) {},
  );

  final tabs = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Posts')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Reels')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Tags')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(4, 'Sliding Segmented — Basic',
          'CupertinoSlidingSegmentedControl iOS 13+ styling', accent),
      _demoFrame('Two-segment recent-calls toggle', accent, calls),
      _demoFrame('Three-segment profile tabs', accent, tabs),
      _recipeCard(
        'Sliding segmented control — default style',
        'No color params required — the control adopts the system grey '
            'plate and white thumb, matching iOS Settings.',
        [
          'CupertinoSlidingSegmentedControl<int>(',
          '  children: {',
          '    0: Text("All"),',
          '    1: Text("Missed"),',
          '  },',
          '  groupValue: filter,',
          '  onValueChanged: (v) => setFilter(v),',
          ')',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 5: SLIDING SEGMENTED — CUSTOM COLORS
// ============================================================================
Widget _section5() {
  final accent = Color(0xFFFF375F);

  final pinkBg = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Posts')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Reels')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Tags')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
    backgroundColor: CupertinoColors.systemPink.withOpacity(0.18),
    thumbColor: CupertinoColors.white,
  );

  final tealBg = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Day')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Night')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
    backgroundColor: CupertinoColors.systemTeal.withOpacity(0.20),
    thumbColor: CupertinoColors.systemTeal,
  );

  final indigoBg = CupertinoSlidingSegmentedControl<String>(
    children: {
      'small': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('S')),
      'medium': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('M')),
      'large': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('L')),
      'xlarge': Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('XL')),
    },
    groupValue: 'medium',
    onValueChanged: (v) {},
    backgroundColor: CupertinoColors.systemIndigo.withOpacity(0.18),
    thumbColor: CupertinoColors.white,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(5, 'Sliding Segmented — Color Themes',
          'backgroundColor + thumbColor combinations', accent),
      _demoFrame('Pink plate, white thumb', accent, pinkBg),
      _demoFrame('Teal plate, teal thumb', Color(0xFF64D2FF), tealBg),
      _demoFrame('Indigo plate, size selector', Color(0xFF5E5CE6), indigoBg),
      _recipeCard(
        'Tinted sliding control',
        'Use a subtle tinted backgroundColor (15–20% opacity) and a high '
            'contrast thumbColor for crisp affordance on tinted surfaces.',
        [
          'CupertinoSlidingSegmentedControl<int>(',
          '  backgroundColor: CupertinoColors.systemPink',
          '      .withOpacity(0.18),',
          '  thumbColor: CupertinoColors.white,',
          '  children: { ... },',
          '  groupValue: tab,',
          '  onValueChanged: (v) => setTab(v),',
          ')',
        ],
        accent,
      ),
      _comparisonTable(
          'Classic vs Sliding color knobs',
          [
            ['Aspect', 'Classic', 'Sliding'],
            ['Plate background', 'unselectedColor', 'backgroundColor'],
            ['Active segment', 'selectedColor', 'thumbColor'],
            ['Border', 'borderColor', '(none)'],
            ['Tap feedback', 'pressedColor', '(auto)'],
            ['Number of knobs', '4', '2'],
          ],
          accent),
    ],
  );
}

// ============================================================================
// SECTION 6: SLIDING SEGMENTED — ICONS AND COMPOUND CHILDREN
// ============================================================================
Widget _section6() {
  final accent = Color(0xFF64D2FF);

  final iconOnly = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Icon(CupertinoIcons.list_bullet, size: 18.0)),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Icon(CupertinoIcons.square_grid_2x2, size: 18.0)),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Icon(CupertinoIcons.map, size: 18.0)),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  final iconLabel = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.sun_max_fill,
                size: 14.0, color: Color(0xFFFF9F0A)),
            SizedBox(width: 6.0),
            Text('Light'),
          ],
        ),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.moon_fill,
                size: 14.0, color: Color(0xFF5E5CE6)),
            SizedBox(width: 6.0),
            Text('Dark'),
          ],
        ),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.circle_lefthalf_fill,
                size: 14.0, color: Color(0xFF8E8E93)),
            SizedBox(width: 6.0),
            Text('Auto'),
          ],
        ),
      ),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(6, 'Sliding Segmented — Compound Children',
          'Icon-only and icon+label patterns', accent),
      _demoFrame('Icon-only view switcher', accent, iconOnly),
      _demoFrame('Icon + label appearance picker',
          Color(0xFF5E5CE6), iconLabel),
      _recipeCard(
        'Icon-only segmented controls',
        'When using icon-only cells, give each one consistent horizontal '
            'padding (≥10) so the thumb has equal segments. Use 14–18 px icons.',
        [
          'children: {',
          '  0: Padding(',
          '    padding: EdgeInsets.symmetric(',
          '        horizontal: 12, vertical: 6),',
          '    child: Icon(',
          '        CupertinoIcons.list_bullet, size: 18),',
          '  ),',
          '  1: ... ,',
          '}',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 7: EDGE CASES — BOOLEAN, NULL SELECTION, MANY SEGMENTS
// ============================================================================
Widget _section7() {
  final accent = Color(0xFF8E8E93);

  final boolToggle = CupertinoSlidingSegmentedControl<bool>(
    children: {
      true: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
          child: Text('On')),
      false: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
          child: Text('Off')),
    },
    groupValue: true,
    onValueChanged: (v) {},
  );

  final nullSelection = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('None')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Selected')),
    },
    groupValue: null,
    onValueChanged: (v) {},
  );

  final manyClassic = CupertinoSegmentedControl<int>(
    children: {
      for (var i = 0; i < 5; i++)
        i: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text('S$i'),
        ),
    },
    groupValue: 2,
    onValueChanged: (v) {},
  );

  final manySliding = CupertinoSlidingSegmentedControl<int>(
    children: {
      for (var i = 0; i < 6; i++)
        i: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: Text('${i + 1}',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
    },
    groupValue: 3,
    onValueChanged: (v) {},
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(7, 'Edge Cases',
          'Booleans, null groupValue, many segments', accent),
      _demoFrame('Boolean on/off (sliding)', Color(0xFF30D158), boolToggle),
      _demoFrame('Null groupValue — no selection',
          Color(0xFF8E8E93), nullSelection),
      _demoFrame(
          'Five-segment classic', Color(0xFF0A84FF), manyClassic),
      _demoFrame(
          'Six-segment sliding rating', Color(0xFFFF9F0A), manySliding),
      _recipeCard(
        'Booleans as the key type',
        'A boolean-keyed sliding control is a great alternative to '
            'Switch when the two states need explicit labels.',
        [
          'CupertinoSlidingSegmentedControl<bool>(',
          '  children: {',
          '    true: Text("On"),',
          '    false: Text("Off"),',
          '  },',
          '  groupValue: enabled,',
          '  onValueChanged: (v) => setEnabled(v),',
          ')',
        ],
        accent,
      ),
      _comparisonTable(
          'Segment count guidance',
          [
            ['Count', 'Use case', 'Caveat'],
            ['2', 'Filter on/off, polarity', 'consider Switch'],
            ['3', 'tab-like grouping', 'sweet spot'],
            ['4', 'sizing S/M/L/XL', 'shrink labels'],
            ['5–6', 'discrete scale', 'sliding only'],
            ['>6', 'avoid', 'use a Picker'],
          ],
          accent),
    ],
  );
}

// ============================================================================
// SECTION 8: LAYOUT — ROWS, COLUMNS, FULL-WIDTH, ALIGNMENT
// ============================================================================
Widget _section8() {
  final accent = Color(0xFF34C759);

  final centered = Center(
    child: CupertinoSlidingSegmentedControl<int>(
      children: {
        0: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Text('Map')),
        1: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Text('List')),
      },
      groupValue: 0,
      onValueChanged: (v) {},
    ),
  );

  final inRow = Row(
    children: [
      Icon(CupertinoIcons.slider_horizontal_3,
          color: Color(0xFF34C759), size: 18.0),
      SizedBox(width: 12.0),
      Expanded(
        child: CupertinoSlidingSegmentedControl<int>(
          children: {
            0: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Off')),
            1: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Low')),
            2: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Med')),
            3: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('High')),
          },
          groupValue: 2,
          onValueChanged: (v) {},
        ),
      ),
    ],
  );

  final stacked = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('Sort by',
          style: TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 12.0,
              fontWeight: FontWeight.w700)),
      SizedBox(height: 8.0),
      CupertinoSlidingSegmentedControl<String>(
        children: {
          'recent': Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: Text('Recent')),
          'name': Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: Text('Name')),
          'size': Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: Text('Size')),
        },
        groupValue: 'name',
        onValueChanged: (v) {},
      ),
      SizedBox(height: 14.0),
      Text('Direction',
          style: TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 12.0,
              fontWeight: FontWeight.w700)),
      SizedBox(height: 8.0),
      CupertinoSlidingSegmentedControl<String>(
        children: {
          'asc': Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.arrow_up, size: 14.0),
                  SizedBox(width: 4.0),
                  Text('Asc'),
                ],
              )),
          'desc': Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.arrow_down, size: 14.0),
                  SizedBox(width: 4.0),
                  Text('Desc'),
                ],
              )),
        },
        groupValue: 'asc',
        onValueChanged: (v) {},
      ),
    ],
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(8, 'Layout Patterns',
          'Row, column, centered, full-width contexts', accent),
      _demoFrame('Centered in available space', accent, centered),
      _demoFrame('Embedded in a Row with leading icon',
          Color(0xFF30D158), inRow),
      _demoFrame('Stacked filters in a Column',
          Color(0xFF64D2FF), stacked),
      _recipeCard(
        'Embedding inside a Row',
        'Wrap the segmented control in Expanded when laid out beside an icon '
            'or label so it consumes the remaining horizontal space.',
        [
          'Row(children: [',
          '  Icon(CupertinoIcons.slider_horizontal_3,',
          '      size: 18),',
          '  SizedBox(width: 12),',
          '  Expanded(',
          '    child: CupertinoSlidingSegmentedControl(',
          '      ...',
          '    ),',
          '  ),',
          '])',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 9: THEMING — DARK SURFACES, GRADIENT BACKDROPS
// ============================================================================
Widget _section9() {
  final accent = Color(0xFF1C1C1E);

  final onDark = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: CupertinoSlidingSegmentedControl<int>(
      children: {
        0: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Music',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
        1: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Podcast',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
        2: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Radio',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
      },
      groupValue: 0,
      onValueChanged: (v) {},
      backgroundColor: Color(0xFF2C2C2E),
      thumbColor: Color(0xFFE5E5EA),
    ),
  );

  final onGradient = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF375F), Color(0xFFFF9F0A)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: CupertinoSlidingSegmentedControl<String>(
      children: {
        'red': Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Red',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
        'green': Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Green',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
        'blue': Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('Blue',
                style: TextStyle(color: Color(0xFF1C1C1E)))),
      },
      groupValue: 'green',
      onValueChanged: (v) {},
      backgroundColor: Colors.white.withOpacity(0.25),
      thumbColor: Colors.white,
    ),
  );

  final classicOnDark = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF000000),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: CupertinoSegmentedControl<int>(
      children: {
        0: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('1H')),
        1: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('1D')),
        2: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('1W')),
        3: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            child: Text('1M')),
      },
      groupValue: 1,
      onValueChanged: (v) {},
      selectedColor: CupertinoColors.systemYellow,
      unselectedColor: Color(0xFF1C1C1E),
      borderColor: CupertinoColors.systemYellow,
      pressedColor: CupertinoColors.systemYellow.withOpacity(0.30),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(9, 'Theming Surfaces',
          'Sliding & classic on dark and gradient backdrops', accent),
      _demoFrame('Sliding on dark surface', Color(0xFF1C1C1E), onDark),
      _demoFrame('Sliding on gradient backdrop',
          Color(0xFFFF375F), onGradient),
      _demoFrame('Classic on black with yellow accent',
          Color(0xFFFFD60A), classicOnDark),
      _recipeCard(
        'Adapting to dark surfaces',
        'On dark surfaces, prefer the sliding variant with a tinted dark '
            'backgroundColor and a near-white thumbColor. Always ensure the '
            'segment label color contrasts with the thumb.',
        [
          'CupertinoSlidingSegmentedControl<int>(',
          '  backgroundColor: Color(0xFF2C2C2E),',
          '  thumbColor: Color(0xFFE5E5EA),',
          '  children: {',
          '    0: Text("Music",',
          '        style: TextStyle(',
          '            color: Color(0xFF1C1C1E))),',
          '    ...',
          '  },',
          ')',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 10: ACCESSIBILITY CONSIDERATIONS
// ============================================================================
Widget _section10() {
  final accent = Color(0xFFFFD60A);

  final largeText = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Text('Small',
              style: TextStyle(
                  fontSize: 17.0, fontWeight: FontWeight.w600))),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Text('Medium',
              style: TextStyle(
                  fontSize: 17.0, fontWeight: FontWeight.w600))),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Text('Large',
              style: TextStyle(
                  fontSize: 17.0, fontWeight: FontWeight.w600))),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  final highContrast = CupertinoSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('A',
              style: TextStyle(fontWeight: FontWeight.w800))),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('B',
              style: TextStyle(fontWeight: FontWeight.w800))),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text('C',
              style: TextStyle(fontWeight: FontWeight.w800))),
    },
    groupValue: 0,
    onValueChanged: (v) {},
    selectedColor: Color(0xFF000000),
    unselectedColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFF000000),
    pressedColor: Color(0xFF8E8E93),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(10, 'Accessibility',
          'Touch targets, contrast, dynamic type', accent),
      _demoFrame('Larger text + roomy padding for dynamic type',
          accent, largeText),
      _demoFrame('Black-on-white for maximum contrast',
          Color(0xFF000000), highContrast),
      _recipeCard(
        'Accessibility checklist',
        'Cupertino segmented controls have a fixed minimum height. Inflate '
            'cell padding (vertical >= 8) so the touch target meets the 44-pt '
            'rule. Use FontWeight.w600+ and high-contrast colors.',
        [
          '// Comfortable touch targets',
          'children: {',
          '  0: Padding(',
          '    padding: EdgeInsets.symmetric(',
          '        horizontal: 18, vertical: 10),',
          '    child: Text("Small",',
          '        style: TextStyle(',
          '            fontSize: 17,',
          '            fontWeight: FontWeight.w600)),',
          '  ),',
          '}',
        ],
        accent,
      ),
      _comparisonTable(
          'Accessibility quick check',
          [
            ['Concern', 'Target', 'Lever'],
            ['Touch height', '>= 44 pt', 'cell vertical padding'],
            ['Color contrast', '4.5:1 text', 'selectedColor / thumb'],
            ['Dynamic type', 'fontSize 17+', 'TextStyle.fontSize'],
            ['Label weight', '600+', 'TextStyle.fontWeight'],
            ['Segment count', '<=4 labels', 'reduce or use Picker'],
          ],
          accent),
    ],
  );
}

// ============================================================================
// SECTION 11: CLASSIC VS SLIDING — SIDE BY SIDE
// ============================================================================
Widget _section11() {
  final accent = Color(0xFF5856D6);

  final classicSample = CupertinoSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Map')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Sat')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Trans')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  final slidingSample = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Map')),
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Sat')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Text('Trans')),
    },
    groupValue: 1,
    onValueChanged: (v) {},
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(11, 'Classic vs Sliding',
          'Same data, two visual languages', accent),
      _demoFrame('Classic (iOS 12 style)', accent, classicSample),
      _demoFrame('Sliding (iOS 13+ style)',
          Color(0xFFBF5AF2), slidingSample),
      _comparisonTable(
          'Style comparison',
          [
            ['Trait', 'Classic', 'Sliding'],
            ['Visual era', 'iOS 12', 'iOS 13+'],
            ['Outer border', 'yes', 'no'],
            ['Active fill', 'segment', 'thumb'],
            ['Tap feedback', 'pressedColor', 'thumb scale'],
            ['Custom colors', '4 slots', '2 slots'],
            ['Best for', 'forms', 'tab-like'],
            ['Looks modern', 'classic', 'modern'],
          ],
          accent),
      _recipeCard(
        'Picking between the two',
        'Reach for the sliding variant for tab-like top-of-screen filters. '
            'Reach for the classic variant inside dense forms where the '
            'bordered, fill-on-select look reads better.',
        [
          '// Tab-like filter at top of screen',
          'CupertinoSlidingSegmentedControl<int>(...);',
          '',
          '// Dense form picker',
          'CupertinoSegmentedControl<int>(',
          '  selectedColor: ..., borderColor: ...,',
          '  children: { ... });',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 12: REAL-WORLD COMPOSITION (CARD WITH FILTERS)
// ============================================================================
Widget _section12() {
  final accent = Color(0xFFFF9F0A);

  final card = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16.0,
            offset: Offset(0.0, 4.0))
      ],
      border: Border.all(color: Color(0xFFE5E5EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Icon(CupertinoIcons.chart_bar_fill,
              color: Color(0xFFFF9F0A), size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text('Activity',
                style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800)),
          ),
          Icon(CupertinoIcons.ellipsis,
              color: Color(0xFF8E8E93), size: 18.0),
        ]),
        SizedBox(height: 14.0),
        CupertinoSlidingSegmentedControl<int>(
          children: {
            0: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Day')),
            1: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Week')),
            2: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Month')),
            3: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Year')),
          },
          groupValue: 1,
          onValueChanged: (v) {},
        ),
        SizedBox(height: 16.0),
        Container(
          height: 110.0,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF4E5),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bar(40.0, Color(0xFFFF9F0A)),
              _bar(72.0, Color(0xFFFF9F0A)),
              _bar(54.0, Color(0xFFFF9F0A)),
              _bar(88.0, Color(0xFFFF9F0A)),
              _bar(48.0, Color(0xFFFF9F0A)),
              _bar(66.0, Color(0xFFFF9F0A)),
              _bar(82.0, Color(0xFFFF9F0A)),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        CupertinoSegmentedControl<String>(
          children: {
            'steps': Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Steps')),
            'cals': Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Cals')),
            'dist': Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Dist')),
          },
          groupValue: 'steps',
          onValueChanged: (v) {},
          selectedColor: CupertinoColors.systemOrange,
          unselectedColor: CupertinoColors.white,
          borderColor: CupertinoColors.systemOrange,
          pressedColor: CupertinoColors.systemOrange.withOpacity(0.20),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(12, 'Real-World Composition',
          'Card with two segmented controls (sliding + classic)', accent),
      _demoFrame('Activity widget', accent, card),
      _recipeCard(
        'Combining both styles in one card',
        'A common pattern: a top-level sliding control selects the time '
            'range, and a bordered classic control selects the metric. The '
            'visual hierarchy signals which control is primary.',
        [
          'Column(children: [',
          '  CupertinoSlidingSegmentedControl<int>(',
          '    children: {0: Day, 1: Week, 2: Month, 3: Year},',
          '    groupValue: range,',
          '    onValueChanged: (v) => setRange(v),',
          '  ),',
          '  Chart(),',
          '  CupertinoSegmentedControl<String>(',
          '    selectedColor: ..., borderColor: ...,',
          '    children: {"steps": Steps, ...},',
          '  ),',
          '])',
        ],
        accent,
      ),
    ],
  );
}

Widget _bar(double h, Color color) {
  return Container(
    width: 14.0,
    height: h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
    ),
  );
}

// ============================================================================
// GLOSSARY
// ============================================================================
Widget _glossary() {
  Widget entry(String term, String def, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Text(term,
                style: TextStyle(
                    color: color,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace'),
                textAlign: TextAlign.center),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(def,
                style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 12.0,
                    height: 1.4,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFD1D1D6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(CupertinoIcons.book_fill,
              color: Color(0xFF5E5CE6), size: 22.0),
          SizedBox(width: 10.0),
          Text('Glossary',
              style: TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 10.0),
        entry('children', 'Map<T, Widget>; one entry per segment, min 2.',
            Color(0xFF0A84FF)),
        entry('groupValue',
            'Currently selected key, or null for no selection.',
            Color(0xFF30D158)),
        entry('onValueChanged',
            'ValueChanged<T> callback fired on segment tap.',
            Color(0xFFFF9F0A)),
        entry('selectedColor',
            'Classic only — fill of the active segment.',
            Color(0xFFBF5AF2)),
        entry('unselectedColor',
            'Classic only — fill of inactive segments.', Color(0xFF5856D6)),
        entry('borderColor',
            'Classic only — color of the outer border.', Color(0xFFFF375F)),
        entry('pressedColor',
            'Classic only — fill during tap feedback.', Color(0xFF64D2FF)),
        entry('backgroundColor',
            'Sliding only — color of the rounded plate.', Color(0xFF34C759)),
        entry('thumbColor',
            'Sliding only — color of the floating thumb.', Color(0xFFFFD60A)),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================
Widget _epilogue() {
  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF5E5CE6), Color(0xFFBF5AF2), Color(0xFFFF375F)],
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(CupertinoIcons.sparkles, color: Colors.white, size: 26.0),
          SizedBox(width: 10.0),
          Text('Epilogue',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 14.0),
        Text(
            'You have toured twelve segmented control patterns: from a plain '
            'three-tab classic control to the iOS 13+ sliding flavor, through '
            'color themes, rich children, layout contexts, accessibility '
            'tuning, and a real-world activity card composing both styles.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                height: 1.5,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 12.0),
        Text(
            'Treat the two variants as one design family: the classic gives '
            'you the bordered, four-color theming control for dense forms; '
            'the sliding gives you the modern, two-color thumb control for '
            'tab-like switching. Pick one per surface and keep it consistent.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                height: 1.5,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Text(
              'End of gallery — CupertinoSegmentedControl & CupertinoSlidingSegmentedControl',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================
dynamic build(BuildContext context) {
  print('Cupertino Segmented Selector Gallery — deep demo build');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'iOS Segmented Selector Gallery',
    home: Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroHeader(),
            _conceptOverview(),
            _section1(),
            _section2(),
            _section3(),
            _section4(),
            _section5(),
            _section6(),
            _section7(),
            _section8(),
            _section9(),
            _section10(),
            _section11(),
            _section12(),
            _glossary(),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}
