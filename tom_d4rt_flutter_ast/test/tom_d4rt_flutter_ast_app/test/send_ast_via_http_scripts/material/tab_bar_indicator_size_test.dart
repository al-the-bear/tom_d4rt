// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Tests TabBarIndicatorSize from package:flutter/material.dart
// Deep Demo: Visual demonstration of the TabBarIndicatorSize enum.
//
// TabBarIndicatorSize controls how wide the underline indicator under each
// selected tab is drawn. There are two values:
//   - TabBarIndicatorSize.tab    -> indicator spans the full tab cell width
//   - TabBarIndicatorSize.label  -> indicator spans only the visible label/text
//
// This demo paints a series of mock TabBars (no live TabController) so the
// difference between the two values is visible at a glance and across many
// tab counts and label widths. Animations are stubbed out with
// AlwaysStoppedAnimation<double> + Duration.zero so the demo renders
// deterministically inside the d4rt AST runner.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabBarIndicatorSize Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  // The hero introduces the enum at a glance: name, two values, and a
  // single sentence description. We use a dramatic gradient + shadow so
  // the section stands out even when the file is rendered far from the
  // top of a long scroll view.
  print('=== Section 1: Hero header ===');

  final heroAnim = AlwaysStoppedAnimation<double>(1.0);
  final heroDuration = Duration.zero;
  print('Hero anim status=${heroAnim.status} duration=$heroDuration');

  final heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.30),
          blurRadius: 32.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tab, size: 48.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TabBarIndicatorSize',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    'enum  -  package:flutter/material.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text(
            'Controls how wide the selection underline of a TabBar is drawn:\n'
            'tab => full tab-cell width    label => only the label/text width',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _heroChip('values: 2', Colors.amberAccent),
            SizedBox(width: 8.0),
            _heroChip('default: tab', Colors.lightGreenAccent),
            SizedBox(width: 8.0),
            _heroChip('used by: TabBar', Colors.cyanAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / enum signature
  // ============================================================
  // The anatomy section presents the formal enum surface: the values
  // collection, .name, .index, and the comparison the runtime uses when
  // TabBar paints. It is intentionally code-flavoured so a reader can
  // map the visual demo back to the API.
  print('=== Section 2: Anatomy ===');

  for (final v in TabBarIndicatorSize.values) {
    print('TabBarIndicatorSize.${v.name} index=${v.index}');
  }
  print('values.length=${TabBarIndicatorSize.values.length}');
  print('first=${TabBarIndicatorSize.values.first} '
      'last=${TabBarIndicatorSize.values.last}');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyanAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'enum signature',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeLine('enum TabBarIndicatorSize {', Colors.pink.shade200),
        _codeLine('  tab,    // index 0  - default', Colors.amber.shade200),
        _codeLine('  label,  // index 1', Colors.amber.shade200),
        _codeLine('}', Colors.pink.shade200),
        SizedBox(height: 12.0),
        Container(
          height: 1.0,
          color: Colors.white12,
        ),
        SizedBox(height: 12.0),
        Text(
          'Runtime view',
          style: TextStyle(
            color: Colors.lightGreenAccent,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        _codeLine(
          'TabBarIndicatorSize.values.length == '
              '${TabBarIndicatorSize.values.length}',
          Colors.white70,
        ),
        _codeLine(
          'TabBarIndicatorSize.values.first.name == '
              '"${TabBarIndicatorSize.values.first.name}"',
          Colors.white70,
        ),
        _codeLine(
          'TabBarIndicatorSize.values.last.name  == '
              '"${TabBarIndicatorSize.values.last.name}"',
          Colors.white70,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (tab vs label)
  // ============================================================
  // Each enum value gets a dedicated card with a description, an icon,
  // and a small inline preview that shows just the indicator behaviour
  // as a stand-alone shape. The cards are colour-coded so they are easy
  // to tie back to the rest of the demo.
  print('=== Section 3: Per-value cards ===');

  final tabValueCard = _enumValueCard(
    title: 'TabBarIndicatorSize.tab',
    subtitle: 'index 0  -  default value',
    description:
        'The selection underline spans the entire width of the tab cell, '
        'including any horizontal padding. This is the classic Material 2 '
        'look and is what you get if you do not set indicatorSize at all.',
    seed: Colors.indigo,
    icon: Icons.crop_landscape,
    indicatorBuilder: (color) => Container(
      height: 3.0,
      width: 200.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
    ),
    cellWidth: 200.0,
    indicatorWidth: 200.0,
  );

  final labelValueCard = _enumValueCard(
    title: 'TabBarIndicatorSize.label',
    subtitle: 'index 1',
    description:
        'The selection underline only spans the label - typically just the '
        'text glyphs. Padding is excluded. This is the Material 3 default '
        'feel and works best when you want a tighter, more typographic '
        'underline.',
    seed: Colors.teal,
    icon: Icons.text_fields,
    indicatorBuilder: (color) => Container(
      height: 3.0,
      width: 90.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
    ),
    cellWidth: 200.0,
    indicatorWidth: 90.0,
  );

  // ============================================================
  // SECTION 4: Mock TabBar gallery
  // ============================================================
  // The gallery paints six mock tab bars side by side: three tab counts
  // (3, 4, 5) crossed with the two enum values. Each row is a fully
  // composed visual that shows how the indicator scales with both the
  // number of tabs and the label width, without any TabController or
  // animation activity.
  print('=== Section 4: Mock TabBar gallery ===');

  final galleryRows = <Widget>[];
  final galleryConfigs = [
    {
      'labels': ['Home', 'Search', 'Profile'],
      'selected': 0,
      'seed': Colors.indigo,
    },
    {
      'labels': ['Inbox', 'Sent', 'Drafts', 'Spam'],
      'selected': 2,
      'seed': Colors.deepOrange,
    },
    {
      'labels': ['News', 'Sports', 'Tech', 'Music', 'Art'],
      'selected': 3,
      'seed': Colors.green,
    },
  ];

  for (final config in galleryConfigs) {
    final labels = (config['labels'] as List).cast<String>();
    final selected = config['selected'] as int;
    final seed = config['seed'] as MaterialColor;
    print('gallery row: tabs=${labels.length} selected=$selected '
        'label="${labels[selected]}"');

    galleryRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [seed.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: seed.shade200, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: seed.withValues(alpha: 0.15),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.view_carousel, color: seed.shade700, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  '${labels.length} tabs - selected: "${labels[selected]}"',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: seed.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'TabBarIndicatorSize.tab',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 4.0),
            _mockTabBar(
              labels: labels,
              selectedIndex: selected,
              indicatorMode: TabBarIndicatorSize.tab,
              seed: seed,
            ),
            SizedBox(height: 12.0),
            Text(
              'TabBarIndicatorSize.label',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 4.0),
            _mockTabBar(
              labels: labels,
              selectedIndex: selected,
              indicatorMode: TabBarIndicatorSize.label,
              seed: seed,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Indicator-bound diagrams
  // ============================================================
  // The bound diagrams show, abstractly, what rectangle the indicator is
  // told to fill. They draw the tab cell as a faint rectangle, then
  // overlay the indicator rectangle in a vivid colour so the difference
  // is unambiguous. Padding and the label box are also drawn to make the
  // claim "tab includes padding, label does not" visually concrete.
  print('=== Section 5: Indicator-bound diagrams ===');

  final boundDiagrams = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What rectangle does the indicator fill?',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Faint outer = tab cell. Solid inner = label box. Coloured strip = '
          'indicator under the selected tab.',
          style: TextStyle(fontSize: 11.0, color: Colors.brown.shade700),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _boundDiagram(
              label: 'tab',
              indicatorWidth: 220.0,
              cellWidth: 220.0,
              labelWidth: 110.0,
              seed: Colors.indigo,
            ),
            _boundDiagram(
              label: 'label',
              indicatorWidth: 110.0,
              cellWidth: 220.0,
              labelWidth: 110.0,
              seed: Colors.teal,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Mental model: "tab" = paint along the cell rect; "label" = paint '
            'along the label rect. Padding lives in the cell rect, never the '
            'label rect, which is why it disappears in label mode.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.brown.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison matrix
  // ============================================================
  // The matrix collapses the per-value information into a tabular form
  // so a reader can pick the right value purely on requirements.
  print('=== Section 6: Comparison matrix ===');

  final comparisonMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'tab vs label - feature matrix',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _matrixRow(
          ['Aspect', 'tab', 'label'],
          isHeader: true,
        ),
        _matrixRow(
            ['Indicator width', 'cell width', 'label/text width']),
        _matrixRow(['Includes padding', 'yes', 'no']),
        _matrixRow(
            ['Default in TabBar', 'yes (M2)', 'M3 visual default']),
        _matrixRow(
            ['Best for', 'wide spaced tabs', 'typographic emphasis']),
        _matrixRow(['Scrollable tabs', 'works', 'works']),
        _matrixRow(['Custom indicator', 'works', 'works (uses label rect)']),
        _matrixRow(['Hit target', 'unchanged', 'unchanged']),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes (TabBar.indicatorSize)
  // ============================================================
  // Three small recipes show realistic uses: a plain TabBar with the
  // default, a TabBar with explicit label sizing, and a TabBar with a
  // custom UnderlineTabIndicator + indicatorSize.
  print('=== Section 7: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.lightBlueAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes - TabBar.indicatorSize',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recipeBlock(
          'Default - implicit tab',
          'TabBar(\n'
              '  tabs: const [Tab(text: "One"), Tab(text: "Two")],\n'
              '  // indicatorSize defaults to TabBarIndicatorSize.tab\n'
              ')',
          Colors.amber.shade200,
        ),
        SizedBox(height: 10.0),
        _recipeBlock(
          'Tight typographic look',
          'TabBar(\n'
              '  indicatorSize: TabBarIndicatorSize.label,\n'
              '  tabs: const [Tab(text: "Inbox"), Tab(text: "Archive")],\n'
              ')',
          Colors.tealAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _recipeBlock(
          'Custom indicator + label sizing',
          'TabBar(\n'
              '  indicatorSize: TabBarIndicatorSize.label,\n'
              '  indicator: UnderlineTabIndicator(\n'
              '    borderSide: BorderSide(width: 3.0),\n'
              '  ),\n'
              '  tabs: const [Tab(text: "A"), Tab(text: "B"), Tab(text: "C")],\n'
              ')',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  // Pitfalls are the practical "gotchas" that bite developers when they
  // pick a value without thinking about layout and label widths.
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          'Padding is invisible in label mode',
          'If you rely on labelPadding to space tabs, the indicator will look '
              'shorter than expected. Switch to tab if a wider underline is '
              'wanted.',
          Icons.format_align_center,
        ),
        _pitfallTile(
          'Variable label widths look uneven',
          'Mixing short and long labels in label mode produces underlines of '
              'wildly different widths. Use tab to keep them uniform.',
          Icons.linear_scale,
        ),
        _pitfallTile(
          'Scrollable tabs amplify the difference',
          'isScrollable: true gives each tab its own intrinsic width. label '
              'mode then closely follows the text, while tab follows the '
              'whole scrolled cell.',
          Icons.swap_horiz,
        ),
        _pitfallTile(
          'Custom indicator + tab can clip',
          'A UnderlineTabIndicator with insets behaves differently against a '
              'cell rect vs a label rect. Test both modes when you write a '
              'custom Decoration.',
          Icons.brush,
        ),
        _pitfallTile(
          'Icon-only Tabs',
          'For Tab(icon: ...) without text, label mode underlines just the '
              'icon glyph rect, which is often too narrow. Prefer tab here.',
          Icons.emoji_emotions,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  // The footer wraps the demo with a hand-drawn ASCII summary that
  // restates the tab vs label distinction in pure characters - useful
  // when this script is rendered as plain text in a log.
  print('=== Section 9: ASCII footer ===');

  const ascii = ''
      '+---------------------------------------------------------+\n'
      '|             TabBarIndicatorSize  -  cheat sheet         |\n'
      '+---------------------------------------------------------+\n'
      '|  tab    : [   Padding [LABEL] Padding   ]               |\n'
      '|           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                |\n'
      '|           indicator covers the whole cell               |\n'
      '|                                                         |\n'
      '|  label  : [   Padding [LABEL] Padding   ]               |\n'
      '|                       ^^^^^^^                            |\n'
      '|                       indicator covers only the label   |\n'
      '+---------------------------------------------------------+\n'
      '|  Default     : tab                                      |\n'
      '|  Values      : 2  (tab=0, label=1)                      |\n'
      '|  Used by     : TabBar.indicatorSize                     |\n'
      '+---------------------------------------------------------+';

  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.greenAccent.shade100,
        height: 1.25,
      ),
    ),
  );

  print('TabBarIndicatorSize Deep Demo completed successfully');

  // ============================================================
  // Compose the full layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            _sectionTitle('1. Anatomy / enum signature', Icons.functions),
            anatomy,
            SizedBox(height: 24.0),
            _sectionTitle('2. Per-value cards', Icons.style),
            tabValueCard,
            SizedBox(height: 12.0),
            labelValueCard,
            SizedBox(height: 24.0),
            _sectionTitle('3. Mock TabBar gallery', Icons.view_carousel),
            ...galleryRows,
            SizedBox(height: 24.0),
            _sectionTitle('4. Indicator-bound diagrams', Icons.crop),
            boundDiagrams,
            SizedBox(height: 24.0),
            _sectionTitle('5. Comparison matrix', Icons.table_chart),
            comparisonMatrix,
            SizedBox(height: 24.0),
            _sectionTitle('6. Recipes', Icons.menu_book),
            recipes,
            SizedBox(height: 24.0),
            _sectionTitle('7. Pitfalls', Icons.warning_amber),
            pitfalls,
            SizedBox(height: 24.0),
            _sectionTitle('8. ASCII cheat sheet', Icons.terminal),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------------

/// Builds a small white-on-translucent chip used inside the hero header.
Widget _heroChip(String text, Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: accent.withValues(alpha: 0.85), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: accent,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

/// Builds a section title row with a coloured icon and bold text. The
/// styling is uniform across the demo so a reader can scan section
/// boundaries quickly.
Widget _sectionTitle(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.30),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 16.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Single line of monospaced "code" rendered inside the dark anatomy
/// container.
Widget _codeLine(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.35,
      ),
    ),
  );
}

/// A card describing one TabBarIndicatorSize value. The card is itself
/// a tiny composition of header, prose, and a stand-alone preview of
/// the indicator alone.
Widget _enumValueCard({
  required String title,
  required String subtitle,
  required String description,
  required MaterialColor seed,
  required IconData icon,
  required Widget Function(Color color) indicatorBuilder,
  required double cellWidth,
  required double indicatorWidth,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [seed.shade50, seed.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: seed.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: seed.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: seed.shade600,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: seed.withValues(alpha: 0.40),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: seed.shade900,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: seed.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'preview - cell ${cellWidth.toInt()}px, '
                'indicator ${indicatorWidth.toInt()}px',
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.grey.shade700,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                width: cellWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: (cellWidth - indicatorWidth) / 2.0,
                    vertical: 6.0),
                decoration: BoxDecoration(
                  color: seed.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: seed.shade200,
                    width: 1.0,
                  ),
                ),
                child: indicatorBuilder(seed.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Paints a row of mock tabs that visually behaves like a TabBar with
/// the requested indicator mode. We do not use a real TabBar/
/// TabController so the demo is render-only and deterministic.
Widget _mockTabBar({
  required List<String> labels,
  required int selectedIndex,
  required TabBarIndicatorSize indicatorMode,
  required MaterialColor seed,
}) {
  final tabCells = <Widget>[];
  for (int i = 0; i < labels.length; i++) {
    final isSelected = i == selectedIndex;
    final color = isSelected ? seed.shade700 : Colors.grey.shade600;
    tabCells.add(
      Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              alignment: Alignment.center,
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: color,
                ),
              ),
            ),
            if (isSelected)
              indicatorMode == TabBarIndicatorSize.tab
                  ? Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        color: seed.shade700,
                        borderRadius: BorderRadius.circular(2.0),
                        boxShadow: [
                          BoxShadow(
                            color: seed.withValues(alpha: 0.35),
                            blurRadius: 4.0,
                            offset: Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              _approxLabelInset(labels[i])),
                      height: 3.0,
                      decoration: BoxDecoration(
                        color: seed.shade700,
                        borderRadius: BorderRadius.circular(2.0),
                        boxShadow: [
                          BoxShadow(
                            color: seed.withValues(alpha: 0.35),
                            blurRadius: 4.0,
                            offset: Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                    ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Row(children: tabCells),
  );
}

/// Approximates how much horizontal inset to apply to a label-mode
/// indicator so it visually sits under just the text. We do not have
/// access to a TextPainter here, so we estimate the inset from the
/// label's character count.
double _approxLabelInset(String label) {
  // Average glyph ~ 8 px at fontSize 13. Cell padding ~ 12 px. Pick a
  // value that is always positive and looks tight under realistic
  // labels.
  final chars = label.length;
  final approxLabel = chars * 8.0;
  final approxCell = approxLabel + 24.0; // includes padding
  final inset = (approxCell - approxLabel) / 2.0 + 2.0;
  return inset.clamp(6.0, 28.0);
}

/// Diagram that overlays a coloured strip on a faint cell rectangle to
/// show the indicator's bound rect for a given value.
Widget _boundDiagram({
  required String label,
  required double indicatorWidth,
  required double cellWidth,
  required double labelWidth,
  required MaterialColor seed,
}) {
  return Column(
    children: [
      Text(
        'TabBarIndicatorSize.$label',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: seed.shade800,
          fontFamily: 'monospace',
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: cellWidth + 4.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Cell rect
            Container(
              width: cellWidth,
              height: 56.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade100,
                    Colors.grey.shade50,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Container(
                  width: labelWidth,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: seed.shade100,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      color: seed.shade300,
                      width: 1.0,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'LABEL',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: seed.shade800,
                    ),
                  ),
                ),
              ),
            ),
            // Indicator strip (bottom)
            Positioned(
              bottom: 4.0,
              child: Container(
                width: indicatorWidth,
                height: 5.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [seed.shade400, seed.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(2.5),
                  boxShadow: [
                    BoxShadow(
                      color: seed.withValues(alpha: 0.40),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        'indicator: ${indicatorWidth.toInt()}px / cell: ${cellWidth.toInt()}px',
        style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700),
      ),
    ],
  );
}

/// Single row in the comparison matrix. Three flexible cells with
/// optional header styling.
Widget _matrixRow(List<String> cells, {bool isHeader = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: isHeader ? Colors.indigo.shade100 : null,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            cells[0],
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              color:
                  isHeader ? Colors.indigo.shade900 : Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            cells[1],
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color:
                  isHeader ? Colors.indigo.shade900 : Colors.indigo.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            cells[2],
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color:
                  isHeader ? Colors.indigo.shade900 : Colors.teal.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Inline recipe block shown in the recipes section with a coloured
/// title and a dark-themed code body.
Widget _recipeBlock(String title, String code, Color titleColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: titleColor.withValues(alpha: 0.45),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Single pitfall list item - icon, title, body.
Widget _pitfallTile(String title, String body, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade300, width: 1.0),
          ),
          child: Icon(icon, color: Colors.red.shade700, size: 16.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade900,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
