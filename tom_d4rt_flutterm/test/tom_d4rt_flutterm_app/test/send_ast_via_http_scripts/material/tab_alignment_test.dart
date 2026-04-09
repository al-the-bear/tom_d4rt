// ignore_for_file: avoid_print
// D4rt deep demo: TabAlignment — controls how tabs are positioned
// within a TabBar (start, startOffset, fill, center).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabAlignment deep demo executing');
  print('=' * 60);

  for (final v in TabAlignment.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${TabAlignment.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const taPrimary = Color(0xFFC2603B);   // terracotta
  const taAccent = Color(0xFFD4845A);    // clay
  const taLight = Color(0xFFFBECE4);     // pale clay
  const taDark = Color(0xFF8B3A20);      // deep terracotta
  const taSurface = Color(0xFFFFFAF7);
  const taOnSurface = Color(0xFF3E2723);
  const taMuted = Color(0xFF795548);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> taAlignments = [
    {
      'value': 'start',
      'title': 'Start',
      'desc': 'Tabs are aligned to the start edge of the TabBar. '
          'Only valid when isScrollable is true. Tabs begin at '
          'the leading edge with no offset.',
      'scrollable': 'Required (isScrollable: true)',
      'layout': 'Tabs packed at start, may leave trailing space',
      'm3default': 'Default for scrollable tabs in M3',
    },
    {
      'value': 'startOffset',
      'title': 'Start Offset',
      'desc': 'Similar to start but adds a leading offset (52dp by '
          'default in Material 3). This gives the first tab a '
          'comfortable inset from the edge.',
      'scrollable': 'Required (isScrollable: true)',
      'layout': 'Tabs start at 52dp inset from leading edge',
      'm3default': 'Alternative scrollable layout',
    },
    {
      'value': 'fill',
      'title': 'Fill',
      'desc': 'Tabs expand equally to fill the entire TabBar width. '
          'Each tab occupies the same proportion of available space. '
          'Only valid when isScrollable is false.',
      'scrollable': 'Required (isScrollable: false)',
      'layout': 'All tabs have equal width spanning full bar',
      'm3default': 'Default for non-scrollable tabs in M3',
    },
    {
      'value': 'center',
      'title': 'Center',
      'desc': 'Tabs are centred within the available space. Tab widths '
          'are intrinsic and the group is horizontally centred. Only '
          'valid when isScrollable is true.',
      'scrollable': 'Required (isScrollable: true)',
      'layout': 'Tab group centred, equal padding on both sides',
      'm3default': 'Design-focused layout option',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget taSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: taAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: taPrimary.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [taPrimary, taDark],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget taLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: taOnSurface)),
    );
  }

  Widget taBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: taMuted, height: 1.5)),
    );
  }

  Widget taChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? taLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: taAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget taDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: taAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Tab bar with given alignment
  Widget taTabBarDemo({
    required TabAlignment alignment,
    required String label,
    required bool isScrollable,
    List<String> tabs = const ['Home', 'Search', 'Profile'],
    String? note,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: taAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: taLight,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: taPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700)),
                ),
                taChip(isScrollable ? 'scrollable' : 'fixed'),
              ],
            ),
          ),
          DefaultTabController(
            length: tabs.length,
            child: TabBar(
              isScrollable: isScrollable,
              tabAlignment: alignment,
              labelColor: taDark,
              unselectedLabelColor: taMuted,
              indicatorColor: taPrimary,
              tabs: [for (final t in tabs) Tab(text: t)],
            ),
          ),
          if (note != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Text(note,
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: taMuted)),
            ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: taSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [taDark, taPrimary, taAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TabAlignment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Controls the horizontal alignment and layout '
                  'strategy of tabs within a TabBar.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    taChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    taChip('TabBar',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    taChip('Material 3',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          taSection('Enum Overview',
            children: [
              taBody(
                'TabAlignment is an enum introduced in Flutter 3.14 as '
                'part of Material 3 TabBar improvements. It specifies '
                'how tabs are positioned horizontally: packed at start, '
                'centred, or expanded to fill the full width.'),
              taBody(
                'The alignment interacts with TabBar.isScrollable: '
                'some modes require scrollable tabs, others require '
                'fixed tabs. Mismatching causes an assertion error.'),
              Wrap(
                children: [
                  for (final v in TabAlignment.values)
                    taChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final a in taAlignments)
            taSection(a['title']!,
              children: [
                taLabel('Value'),
                taChip('TabAlignment.${a['value']}'),
                const SizedBox(height: 8),
                taLabel('Description'),
                taBody(a['desc']!),
                taLabel('isScrollable Requirement'),
                taBody(a['scrollable']!),
                taLabel('Layout Behaviour'),
                taBody(a['layout']!),
                taLabel('Material 3 Note'),
                taBody(a['m3default']!),
              ],
            ),

          // ── 4. Live TabBar Demos — Individual ────────────────
          taSection('Live TabBars — Each Alignment',
            children: [
              taBody(
                'Each TabBar below demonstrates a different alignment. '
                'Notice how tabs occupy space differently:'),
              taTabBarDemo(
                alignment: TabAlignment.start,
                label: 'TabAlignment.start',
                isScrollable: true,
                note: 'Tabs packed at the start edge. Scrollable.',
              ),
              taTabBarDemo(
                alignment: TabAlignment.startOffset,
                label: 'TabAlignment.startOffset',
                isScrollable: true,
                note: '52dp leading offset before first tab. Scrollable.',
              ),
              taTabBarDemo(
                alignment: TabAlignment.fill,
                label: 'TabAlignment.fill',
                isScrollable: false,
                note: 'Tabs expand to fill full width. Fixed.',
              ),
              taTabBarDemo(
                alignment: TabAlignment.center,
                label: 'TabAlignment.center',
                isScrollable: true,
                note: 'Tab group centred in available space. Scrollable.',
              ),
            ],
          ),

          // ── 5. Side-by-Side Comparison ───────────────────────
          taSection('Side-by-Side: Scrollable Alignments',
            children: [
              taBody(
                'Comparing the three scrollable alignments with '
                'identical tabs. The difference is visible at the '
                'leading edge and overall position:'),
              for (final pair in [
                {'alignment': TabAlignment.start, 'name': 'start'},
                {'alignment': TabAlignment.startOffset, 'name': 'startOffset'},
                {'alignment': TabAlignment.center, 'name': 'center'},
              ])
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(pair['name'] as String,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 3,
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: taLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TabBar(
                              isScrollable: true,
                              tabAlignment:
                                  pair['alignment'] as TabAlignment,
                              labelColor: taDark,
                              unselectedLabelColor: taMuted,
                              indicatorColor: taPrimary,
                              tabs: const [
                                Tab(text: 'Tab A'),
                                Tab(text: 'Tab B'),
                                Tab(text: 'Tab C'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 6. Many Tabs Demo ────────────────────────────────
          taSection('Many Tabs — Scrollable Behaviour',
            children: [
              taBody(
                'With many tabs, scrollable modes show their strength. '
                'fill mode is not suitable for many tabs as each tab '
                'becomes very narrow.'),
              taTabBarDemo(
                alignment: TabAlignment.start,
                label: '7 tabs — start alignment',
                isScrollable: true,
                tabs: [
                  'Dashboard',
                  'Analytics',
                  'Reports',
                  'Settings',
                  'Users',
                  'Billing',
                  'Support',
                ],
                note: 'Scrollable tabs flow from the start. Swipe to see more.',
              ),
              taTabBarDemo(
                alignment: TabAlignment.fill,
                label: '3 tabs — fill alignment',
                isScrollable: false,
                tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
                note: 'Each tab gets 1/3 of available width.',
              ),
              taTabBarDemo(
                alignment: TabAlignment.fill,
                label: '5 tabs — fill alignment (narrow)',
                isScrollable: false,
                tabs: ['A', 'B', 'C', 'D', 'E'],
                note: 'With more tabs, each tab label gets squeezed.',
              ),
            ],
          ),

          // ── 7. isScrollable Compatibility ────────────────────
          taSection('isScrollable Compatibility Matrix',
            child: Table(
              border: TableBorder.all(
                  color: taAccent.withValues(alpha: 0.3), width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  decoration:
                      BoxDecoration(color: taPrimary.withValues(alpha: 0.1)),
                  children: [
                    for (final h in [
                      'Alignment',
                      'Scrollable',
                      'Fixed',
                    ])
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(h,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 11)),
                      ),
                  ],
                ),
                for (final row in [
                  ['start', '✓', '✗ assertion'],
                  ['startOffset', '✓', '✗ assertion'],
                  ['fill', '✗ assertion', '✓'],
                  ['center', '✓', '✗ assertion'],
                ])
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(row[0],
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: taDark)),
                      ),
                      for (int i = 1; i < 3; i++)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(row[i],
                              style: TextStyle(
                                  fontSize: 11,
                                  color: row[i].startsWith('✓')
                                      ? Colors.green.shade700
                                      : Colors.red.shade600)),
                        ),
                    ],
                  ),
              ],
            ),
          ),

          // ── 8. Width Distribution Visualiser ─────────────────
          taSection('Width Distribution Visualiser',
            children: [
              taBody(
                'How tab width is allocated across the bar:'),
              for (final layout in [
                {
                  'name': 'fill',
                  'widths': [0.333, 0.333, 0.333],
                  'labels': ['Tab 1', 'Tab 2', 'Tab 3'],
                  'desc': 'Equal fractions of total width',
                },
                {
                  'name': 'start',
                  'widths': [0.18, 0.2, 0.16],
                  'labels': ['Home', 'Search', 'Me'],
                  'desc': 'Intrinsic widths, left-aligned',
                },
                {
                  'name': 'center',
                  'widths': [0.18, 0.2, 0.16],
                  'labels': ['Home', 'Search', 'Me'],
                  'desc': 'Intrinsic widths, centred group',
                },
              ]) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: taLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(layout['name'] as String,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: taAccent.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            if (layout['name'] == 'center')
                              Expanded(
                                flex: 23,
                                child: Container(),
                              ),
                            for (int i = 0;
                                i < (layout['widths'] as List).length;
                                i++)
                              Expanded(
                                flex: (((layout['widths'] as List)[i]
                                            as double) *
                                        100)
                                    .toInt(),
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color.lerp(
                                        taPrimary, taAccent, i * 0.3),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    (layout['labels'] as List)[i]
                                        as String,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            if (layout['name'] == 'center')
                              Expanded(
                                flex: 23,
                                child: Container(),
                              ),
                            if (layout['name'] == 'start')
                              Expanded(
                                flex: 46,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(layout['desc'] as String,
                          style: TextStyle(
                              fontSize: 11, color: taMuted)),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // ── 9. Material 2 vs 3 ──────────────────────────────
          taSection('Material 2 vs Material 3 Defaults',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: taLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Material 2',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final fact in [
                            'No tabAlignment property',
                            'Scrollable: tabs at start',
                            'Fixed: tabs fill width',
                            'No startOffset option',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text('• $fact',
                                  style: TextStyle(
                                      fontSize: 11, color: taMuted)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: taLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Material 3',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final fact in [
                            'tabAlignment property added',
                            'Scrollable default: startOffset',
                            'Fixed default: fill',
                            'center and start options',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text('• $fact',
                                  style: TextStyle(
                                      fontSize: 11, color: taMuted)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 10. TabBar Customisation ─────────────────────────
          taSection('TabBar Customisation Properties',
            children: [
              taBody(
                'tabAlignment works alongside these TabBar properties:'),
              for (final prop in [
                ['tabAlignment', 'Horizontal alignment of tabs'],
                ['isScrollable', 'Whether tabs can scroll horizontally'],
                ['indicatorSize', 'TabBarIndicatorSize.tab or .label'],
                ['indicatorColor', 'Colour of the selection indicator'],
                ['labelColor', 'Colour of the selected tab label'],
                ['unselectedLabelColor', 'Colour of unselected labels'],
                ['dividerColor', 'Colour of the bottom divider'],
                ['dividerHeight', 'Height of the bottom divider'],
                ['padding', 'Internal padding around all tabs'],
                ['labelPadding', 'Padding around each tab label'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: taPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 12, color: taMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 11. Responsive Layout ────────────────────────────
          taSection('Responsive Layout Guidance',
            children: [
              taBody(
                'The alignment choice should respond to the available '
                'width and number of tabs:'),
              for (final guide in [
                {
                  'scenario': 'Narrow screen, few tabs (2-4)',
                  'recommendation': 'fill',
                  'reason': 'Tabs expand to use full width efficiently.',
                },
                {
                  'scenario': 'Wide screen, few tabs (2-4)',
                  'recommendation': 'center',
                  'reason': 'Centred tabs look balanced on wide displays.',
                },
                {
                  'scenario': 'Any width, many tabs (5+)',
                  'recommendation': 'start or startOffset',
                  'reason': 'Scrollable layout prevents tabs from being '
                      'too narrow.',
                },
                {
                  'scenario': 'App bar tabs matching title',
                  'recommendation': 'startOffset',
                  'reason': 'The 52dp offset aligns visually with the '
                      'AppBar.title default padding.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: taLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(guide['scenario']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      taChip(guide['recommendation']!),
                      const SizedBox(height: 4),
                      Text(guide['reason']!,
                          style: TextStyle(fontSize: 11, color: taMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          taSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Assertion: fill + isScrollable:true',
                  'detail':
                      'TabAlignment.fill requires isScrollable: false. '
                      'Using fill with scrollable tabs throws an '
                      'assertion error at runtime.',
                },
                {
                  'title': 'Assertion: start + isScrollable:false',
                  'detail':
                      'TabAlignment.start, startOffset, and center require '
                      'isScrollable: true. Fixed tabs only support fill.',
                },
                {
                  'title': 'TabBarView length mismatch',
                  'detail':
                      'tabAlignment does not affect TabBarView but the '
                      'tab count must match. Different alignment may change '
                      'the visual impression of tab selection.',
                },
                {
                  'title': 'Missing DefaultTabController',
                  'detail':
                      'TabBar requires a TabController or '
                      'DefaultTabController ancestor. This is independent '
                      'of alignment but often forgotten.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: taPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: taDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: taMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Guide ───────────────────────────────
          taSection('Decision Guide',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: taLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      '1. How many tabs?',
                      '   ≤ 4 tabs → Can fit on screen?',
                      '     YES → Do you want equal width?',
                      '           YES → fill (isScrollable: false)',
                      '           NO  → center (isScrollable: true)',
                      '     NO  → start (isScrollable: true)',
                      '   > 4 tabs → Must scroll',
                      '     Need offset? → startOffset',
                      '     Otherwise   → start',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. RTL Considerations ───────────────────────────
          taSection('RTL (Right-to-Left) Behaviour',
            children: [
              taBody(
                'Tab alignment respects the ambient text direction. '
                'In RTL layouts:'),
              for (final item in [
                '"start" aligns to the RIGHT edge (logical start).',
                '"startOffset" adds the offset from the RIGHT edge.',
                '"center" stays centred — no change.',
                '"fill" still fills the full width — no change.',
                'The indicator animation reverses direction.',
                'Tab order visually reverses (first tab at right).',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('→ ',
                          style: TextStyle(
                              color: taPrimary,
                              fontWeight: FontWeight.w700)),
                      Expanded(
                        child: Text(item,
                            style: TextStyle(fontSize: 12, color: taMuted)),
                      ),
                    ],
                  ),
                ),
              taDivider(),
              taBody(
                'Always test TabBar in both LTR and RTL to ensure '
                'alignment behaves as expected. Use Directionality '
                'widget to test:'),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          taSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'TabBar',
                  'rel': 'Primary widget using tabAlignment',
                },
                {
                  'name': 'TabBar.secondary',
                  'rel': 'Secondary tab bar variant (same alignment)',
                },
                {
                  'name': 'DefaultTabController',
                  'rel': 'Provides TabController to descendants',
                },
                {
                  'name': 'TabBarView',
                  'rel': 'Content area linked to tab selection',
                },
                {
                  'name': 'TabBarIndicatorSize',
                  'rel': 'Controls indicator width (.tab vs .label)',
                },
                {
                  'name': 'TabBarTheme',
                  'rel': 'Theme-level tab styling defaults',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: taDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: taMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          taSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: taPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${TabAlignment.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: taDark)),
                            const Text('Enum Values',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: taAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('10',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: taDark)),
                            const Text('Live TabBars',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: taLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('3',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: taDark)),
                            const Text('Width Diagrams',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: taLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TabAlignment brings explicit control over tab '
                    'positioning in Material 3. Match the right '
                    'alignment to your tab count, screen width, '
                    'and design intent.',
                    style: TextStyle(
                        fontSize: 12, color: taMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: taDark,
            child: Column(
              children: [
                const Text('TabAlignment Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Terracotta/Clay theme  •  Batch 61  •  '
                  '${TabAlignment.values.length} enum values  •  '
                  '10 live TabBars',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
