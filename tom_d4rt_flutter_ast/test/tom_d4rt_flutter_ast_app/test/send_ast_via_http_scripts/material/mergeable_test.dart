// D4rt test script: Deep visual demo for MergeableMaterial / MaterialGap / MaterialSlice
// Covers MergeableMaterial properties (elevation, mainAxis, hasDividers, dividerColor),
// MaterialSlice with LocalKey + color, MaterialGap size variations,
// and real-world patterns: FAQ accordion, banner-style group, settings list.
import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {

  // ============================================================
  // PALETTE / TOKENS
  // ============================================================
  final Color brandPrimary = Color(0xFF3F51B5);
  final Color brandAccent = Color(0xFF00BCD4);
  final Color brandSurface = Color(0xFFF5F7FB);
  final Color brandInk = Color(0xFF1A1F36);
  final Color brandMuted = Color(0xFF6B7280);


  // ============================================================
  // SECTION 0: Hero Header
  // ============================================================

  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [brandPrimary, brandAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: brandPrimary.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.view_agenda, color: Colors.white, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MergeableMaterial',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Slices, gaps, and animated merging behavior',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List<Widget>.generate(6, (int i) {
            final List<String> labels = [
              'MaterialSlice',
              'MaterialGap',
              'elevation',
              'mainAxis',
              'hasDividers',
              'dividerColor',
            ];
            final List<IconData> icons = [
              Icons.layers,
              Icons.space_bar,
              Icons.layers_outlined,
              Icons.swap_horiz,
              Icons.horizontal_rule,
              Icons.color_lens,
            ];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[i], color: Colors.white, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    labels[i],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 1: Conceptual cards — slice vs gap
  // ============================================================

  final List<Map<String, dynamic>> conceptDescriptors = [
    {
      'title': 'MaterialSlice',
      'subtitle': 'A visible, merge-aware piece',
      'desc': 'Carries a LocalKey identity and child content. '
          'Adjacent slices merge into a single shared Material surface.',
      'icon': Icons.layers,
      'color': brandPrimary,
    },
    {
      'title': 'MaterialGap',
      'subtitle': 'An animated separator',
      'desc': 'Inserts space between slices, splitting them into '
          'separate Material surfaces. The size is animated when changed.',
      'icon': Icons.space_bar,
      'color': brandAccent,
    },
    {
      'title': 'MergeableMaterial',
      'subtitle': 'The orchestrator',
      'desc': 'Hosts a list of MergeableMaterialItem children and '
          'animates between merged and separated states.',
      'icon': Icons.dashboard_customize,
      'color': Color(0xFF8B5CF6),
    },
  ];

  final List<Widget> conceptCards = List<Widget>.generate(
    conceptDescriptors.length,
    (int i) {
      final Map<String, dynamic> d = conceptDescriptors[i];
      final Color color = d['color'] as Color;
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: color.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(d['icon'] as IconData, color: color, size: 24.0),
              ),
              SizedBox(height: 12.0),
              Text(
                d['title'] as String,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                d['subtitle'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: brandMuted,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                d['desc'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: brandInk,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // ============================================================
  // SECTION 2: Baseline — simple slices, no gaps
  // ============================================================

  final List<String> baselineLabels = [
    'First slice',
    'Second slice',
    'Third slice',
    'Fourth slice',
  ];
  final List<IconData> baselineIcons = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
  ];

  final Widget baselineDemo = MergeableMaterial(
    children: List<MergeableMaterialItem>.generate(
      baselineLabels.length,
      (int i) => MaterialSlice(
        key: ValueKey<String>('baseline_slice_$i'),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: brandPrimary.withValues(alpha: 0.12),
            child: Icon(baselineIcons[i], color: brandPrimary),
          ),
          title: Text(
            baselineLabels[i],
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('LocalKey: baseline_slice_$i'),
          trailing: Icon(Icons.chevron_right, color: brandMuted),
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 3: Gap-separated groups
  // ============================================================

  final List<MergeableMaterialItem> gapItems = <MergeableMaterialItem>[];
  final List<List<String>> groups = [
    ['Inbox', 'Starred', 'Snoozed'],
    ['Drafts', 'Sent', 'Outbox'],
    ['Spam', 'Trash'],
  ];
  final List<IconData> groupIcons = [
    Icons.inbox,
    Icons.send,
    Icons.delete_outline,
  ];

  for (int g = 0; g < groups.length; g++) {
    if (g > 0) {
      gapItems.add(MaterialGap(
        key: ValueKey<String>('gap_group_$g'),
        size: 18.0,
      ));
    }
    final List<String> group = groups[g];
    for (int i = 0; i < group.length; i++) {
      gapItems.add(MaterialSlice(
        key: ValueKey<String>('group_${g}_item_$i'),
        child: ListTile(
          leading: Icon(groupIcons[g], color: brandPrimary),
          title: Text(group[i]),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: brandPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '${(g + 1) * (i + 1) * 3}',
              style: TextStyle(
                fontSize: 11.0,
                color: brandPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ));
    }
  }

  final Widget gapGroupsDemo = MergeableMaterial(
    children: gapItems,
  );

  // ============================================================
  // SECTION 4: Variable gap sizes
  // ============================================================

  final List<double> gapSizes = [4.0, 8.0, 12.0, 20.0, 32.0];
  final List<MergeableMaterialItem> varGapItems = <MergeableMaterialItem>[];
  for (int i = 0; i < gapSizes.length + 1; i++) {
    varGapItems.add(MaterialSlice(
      key: ValueKey<String>('vargap_slice_$i'),
      color: i.isEven
          ? brandPrimary.withValues(alpha: 0.04)
          : brandAccent.withValues(alpha: 0.04),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: brandPrimary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brandPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Slice ${i + 1}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    i < gapSizes.length
                        ? 'Gap below: ${gapSizes[i].toStringAsFixed(0)} px'
                        : 'Last slice (no gap after)',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: brandMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.height, color: brandMuted, size: 18.0),
          ],
        ),
      ),
    ));
    if (i < gapSizes.length) {
      varGapItems.add(MaterialGap(
        key: ValueKey<String>('vargap_gap_$i'),
        size: gapSizes[i],
      ));
    }
  }

  final Widget varGapDemo = MergeableMaterial(
    children: varGapItems,
  );

  // ============================================================
  // SECTION 5: Elevation variants
  // ============================================================

  final List<double> elevations = [0.0, 1.0, 2.0, 4.0, 8.0, 12.0, 16.0];
  final List<Widget> elevationCards = List<Widget>.generate(
    elevations.length,
    (int i) {
      final double elev = elevations[i];
      return Container(
        width: 150.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: brandPrimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'elevation: ${elev.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: brandPrimary,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            MergeableMaterial(
              elevation: elev,
              children: <MergeableMaterialItem>[
                MaterialSlice(
                  key: ValueKey<String>('elev_${elev}_a'),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.layers,
                          size: 18.0,
                          color: brandPrimary,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Slice A',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialGap(key: ValueKey<String>('elev_${elev}_gap')),
                MaterialSlice(
                  key: ValueKey<String>('elev_${elev}_b'),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.layers_outlined,
                          size: 18.0,
                          color: brandAccent,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Slice B',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  // ============================================================
  // SECTION 6: hasDividers toggle showcase
  // ============================================================

  final List<bool> dividerFlags = [true, false];
  final List<Widget> dividerCompare = List<Widget>.generate(
    dividerFlags.length,
    (int i) {
      final bool flag = dividerFlags[i];
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    flag ? Icons.horizontal_rule : Icons.block,
                    color: flag ? brandPrimary : brandMuted,
                    size: 18.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    'hasDividers: $flag',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: flag ? brandPrimary : brandMuted,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              MergeableMaterial(
                hasDividers: flag,
                children: List<MergeableMaterialItem>.generate(
                  4,
                  (int j) => MaterialSlice(
                    key: ValueKey<String>('div_${flag}_$j'),
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.label,
                        color: flag ? brandPrimary : brandMuted,
                      ),
                      title: Text('Row ${j + 1}'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // ============================================================
  // SECTION 7: dividerColor showcase
  // ============================================================

  final List<Map<String, dynamic>> dividerColorDescriptors = [
    {'name': 'Crimson', 'color': Color(0xFFE53935)},
    {'name': 'Emerald', 'color': Color(0xFF43A047)},
    {'name': 'Amber', 'color': Color(0xFFFB8C00)},
    {'name': 'Indigo', 'color': brandPrimary},
  ];
  final List<Widget> dividerColorCards = List<Widget>.generate(
    dividerColorDescriptors.length,
    (int i) {
      final Map<String, dynamic> d = dividerColorDescriptors[i];
      final Color color = d['color'] as Color;
      return Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  d['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            MergeableMaterial(
              dividerColor: color,
              children: List<MergeableMaterialItem>.generate(
                3,
                (int j) => MaterialSlice(
                  key: ValueKey<String>('dc_${d['name']}_$j'),
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.brightness_1,
                      size: 12.0,
                      color: color,
                    ),
                    title: Text('Item ${j + 1}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  // ============================================================
  // SECTION 8: MaterialSlice color tinting
  // ============================================================

  final List<Map<String, dynamic>> tintSwatches = [
    {'name': 'Sky', 'color': Color(0xFFE3F2FD), 'accent': Color(0xFF1E88E5)},
    {'name': 'Mint', 'color': Color(0xFFE8F5E9), 'accent': Color(0xFF43A047)},
    {'name': 'Peach', 'color': Color(0xFFFFF3E0), 'accent': Color(0xFFFB8C00)},
    {'name': 'Lavender', 'color': Color(0xFFEDE7F6), 'accent': Color(0xFF8B5CF6)},
  ];

  final List<Widget> tintCards = List<Widget>.generate(
    tintSwatches.length,
    (int i) {
      final Map<String, dynamic> swatch = tintSwatches[i];
      final Color tint = swatch['color'] as Color;
      final Color accent = swatch['accent'] as Color;
      final String name = swatch['name'] as String;
      return Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: brandSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: brandPrimary.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: accent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            MergeableMaterial(
              children: <MergeableMaterialItem>[
                MaterialSlice(
                  key: ValueKey<String>('tint_${name}_a'),
                  color: tint,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.brush, color: accent),
                    title: Text('Tinted slice'),
                  ),
                ),
                MaterialSlice(
                  key: ValueKey<String>('tint_${name}_b'),
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.layers, color: accent),
                    title: Text('Default slice'),
                  ),
                ),
                MaterialSlice(
                  key: ValueKey<String>('tint_${name}_c'),
                  color: tint,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.brush_outlined, color: accent),
                    title: Text('Tinted slice'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  // ============================================================
  // SECTION 9: mainAxis horizontal demo
  // ============================================================

  final List<Map<String, dynamic>> horizontalSliceData = [
    {'icon': Icons.wb_sunny, 'label': 'Sun', 'color': Color(0xFFFFB300)},
    {'icon': Icons.cloud, 'label': 'Cloud', 'color': Color(0xFF90A4AE)},
    {'icon': Icons.thunderstorm, 'label': 'Storm', 'color': Color(0xFF5C6BC0)},
    {'icon': Icons.ac_unit, 'label': 'Snow', 'color': Color(0xFF4DD0E1)},
  ];

  final Widget horizontalDemo = SizedBox(
    height: 96.0,
    child: MergeableMaterial(
      mainAxis: Axis.horizontal,
      children: List<MergeableMaterialItem>.generate(
        horizontalSliceData.length * 2 - 1,
        (int i) {
          if (i.isOdd) {
            return MaterialGap(
              key: ValueKey<String>('h_gap_${i ~/ 2}'),
              size: 16.0,
            );
          }
          final Map<String, dynamic> d = horizontalSliceData[i ~/ 2];
          final Color color = d['color'] as Color;
          return MaterialSlice(
            key: ValueKey<String>('h_slice_${i ~/ 2}'),
            child: Container(
              width: 120.0,
              padding: EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(d['icon'] as IconData, color: color, size: 32.0),
                  SizedBox(height: 6.0),
                  Text(
                    d['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  final Widget horizontalNoGaps = SizedBox(
    height: 80.0,
    child: MergeableMaterial(
      mainAxis: Axis.horizontal,
      children: List<MergeableMaterialItem>.generate(
        5,
        (int i) {
          final List<Color> palette = [
            brandPrimary,
            brandAccent,
            Color(0xFF8B5CF6),
            Color(0xFFFB8C00),
            Color(0xFF43A047),
          ];
          return MaterialSlice(
            key: ValueKey<String>('hn_slice_$i'),
            color: palette[i].withValues(alpha: 0.08),
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(14.0),
              child: Center(
                child: Text(
                  'Tab ${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: palette[i],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );

  // ============================================================
  // SECTION 10: Real-world FAQ accordion pattern
  // ============================================================

  final List<Map<String, String>> faqData = [
    {
      'q': 'What is MergeableMaterial?',
      'a': 'A Material widget that animates the merging and splitting '
          'of its slice children, separated by optional gaps.',
    },
    {
      'q': 'How do I separate slices visually?',
      'a': 'Insert a MaterialGap between MaterialSlice items. The gap '
          'animates open and closed as it is inserted or removed.',
    },
    {
      'q': 'Why does each item need a key?',
      'a': 'Both MaterialSlice and MaterialGap require a LocalKey so '
          'MergeableMaterial can track them across animation frames.',
    },
    {
      'q': 'Can I use it horizontally?',
      'a': 'Yes — set mainAxis to Axis.horizontal. Slices are then '
          'laid out left-to-right and gaps insert horizontal spacing.',
    },
    {
      'q': 'What controls the merge timing?',
      'a': 'MergeableMaterial animates merges using the standard '
          'theme animation duration whenever slices or gaps change.',
    },
  ];

  final List<MergeableMaterialItem> faqItems = <MergeableMaterialItem>[];
  for (int i = 0; i < faqData.length; i++) {
    if (i > 0) {
      faqItems.add(MaterialGap(
        key: ValueKey<String>('faq_gap_$i'),
        size: 10.0,
      ));
    }
    final Map<String, String> entry = faqData[i];
    final bool isOpen = i == 0 || i == 2;
    faqItems.add(MaterialSlice(
      key: ValueKey<String>('faq_slice_$i'),
      color: isOpen
          ? brandPrimary.withValues(alpha: 0.04)
          : Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: brandPrimary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'Q',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: brandPrimary,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    entry['q'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: brandInk,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.expand_less : Icons.expand_more,
                  color: brandMuted,
                ),
              ],
            ),
            if (isOpen) ...[
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 3.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: brandAccent,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        entry['a'] ?? '',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: brandMuted,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ));
  }

  final Widget faqDemo = MergeableMaterial(
    elevation: 1,
    children: faqItems,
  );

  // ============================================================
  // SECTION 11: Banner-style group with header/footer
  // ============================================================

  final List<Map<String, dynamic>> announcements = [
    {
      'icon': Icons.rocket_launch,
      'title': 'New release available',
      'body': 'Version 2.4.0 introduces dynamic theming and faster startup.',
      'color': brandPrimary,
    },
    {
      'icon': Icons.security,
      'title': 'Security advisory',
      'body': 'Rotate API tokens before the end of the month.',
      'color': Color(0xFFE53935),
    },
    {
      'icon': Icons.celebration,
      'title': 'Anniversary update',
      'body': 'Thanks for one year of using MergeableMaterial demos!',
      'color': Color(0xFF8B5CF6),
    },
  ];

  final List<MergeableMaterialItem> bannerItems = <MergeableMaterialItem>[];

  // Header slice
  bannerItems.add(MaterialSlice(
    key: ValueKey<String>('banner_header'),
    color: brandPrimary,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Row(
        children: [
          Icon(Icons.campaign, color: Colors.white),
          SizedBox(width: 10.0),
          Text(
            'Announcements',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              letterSpacing: 0.3,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              '${announcements.length} new',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  ));

  for (int i = 0; i < announcements.length; i++) {
    final Map<String, dynamic> a = announcements[i];
    final Color color = a['color'] as Color;
    bannerItems.add(MaterialSlice(
      key: ValueKey<String>('banner_item_$i'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(a['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brandInk,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    a['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: brandMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: brandMuted, size: 14.0),
          ],
        ),
      ),
    ));
  }

  // Footer slice (after gap)
  bannerItems.add(MaterialGap(
    key: ValueKey<String>('banner_footer_gap'),
    size: 12.0,
  ));
  bannerItems.add(MaterialSlice(
    key: ValueKey<String>('banner_footer'),
    color: brandSurface,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: brandMuted, size: 16.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Footer is a separate Material surface, separated by a gap.',
              style: TextStyle(
                fontSize: 11.5,
                color: brandMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  ));

  final Widget bannerDemo = MergeableMaterial(
    elevation: 2,
    children: bannerItems,
  );

  // ============================================================
  // SECTION 12: Settings list
  // ============================================================

  final List<Map<String, dynamic>> settingsSections = [
    {
      'title': 'Account',
      'icon': Icons.person,
      'color': brandPrimary,
      'items': [
        {'icon': Icons.email, 'label': 'Email', 'value': 'alice@example.com'},
        {'icon': Icons.lock, 'label': 'Password', 'value': '••••••••'},
        {'icon': Icons.phone, 'label': 'Phone', 'value': '+1 (555) 0102'},
      ],
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications,
      'color': brandAccent,
      'items': [
        {'icon': Icons.mail, 'label': 'Email alerts', 'value': 'On'},
        {'icon': Icons.sms, 'label': 'SMS alerts', 'value': 'Off'},
        {'icon': Icons.notifications_active, 'label': 'Push', 'value': 'On'},
      ],
    },
    {
      'title': 'Privacy',
      'icon': Icons.shield,
      'color': Color(0xFF43A047),
      'items': [
        {'icon': Icons.public, 'label': 'Public profile', 'value': 'Off'},
        {'icon': Icons.history, 'label': 'Activity log', 'value': 'On'},
      ],
    },
  ];

  final List<MergeableMaterialItem> settingsItems = <MergeableMaterialItem>[];
  for (int s = 0; s < settingsSections.length; s++) {
    final Map<String, dynamic> section = settingsSections[s];
    final Color sectionColor = section['color'] as Color;
    final List<dynamic> items = section['items'] as List<dynamic>;

    if (s > 0) {
      settingsItems.add(MaterialGap(
        key: ValueKey<String>('settings_gap_$s'),
        size: 16.0,
      ));
    }

    // Section header slice
    settingsItems.add(MaterialSlice(
      key: ValueKey<String>('settings_header_$s'),
      color: sectionColor.withValues(alpha: 0.08),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Icon(section['icon'] as IconData, color: sectionColor, size: 18.0),
            SizedBox(width: 10.0),
            Text(
              section['title'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 0.6,
                color: sectionColor,
              ),
            ),
          ],
        ),
      ),
    ));

    for (int i = 0; i < items.length; i++) {
      final Map<String, dynamic> item = items[i] as Map<String, dynamic>;
      settingsItems.add(MaterialSlice(
        key: ValueKey<String>('settings_${s}_item_$i'),
        child: ListTile(
          leading: Icon(item['icon'] as IconData, color: sectionColor),
          title: Text(
            item['label'] as String,
            style: TextStyle(fontSize: 13.5),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['value'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: brandMuted,
                ),
              ),
              SizedBox(width: 4.0),
              Icon(Icons.chevron_right, color: brandMuted, size: 18.0),
            ],
          ),
        ),
      ));
    }
  }

  final Widget settingsDemo = MergeableMaterial(
    elevation: 1,
    children: settingsItems,
  );

  // ============================================================
  // SECTION 13: Property combination matrix
  // ============================================================

  final List<Map<String, dynamic>> combos = [
    {
      'elev': 0,
      'div': true,
      'gaps': false,
      'label': 'flat / dividers / no gaps',
    },
    {
      'elev': 0,
      'div': false,
      'gaps': false,
      'label': 'flat / no dividers / no gaps',
    },
    {
      'elev': 2,
      'div': true,
      'gaps': true,
      'label': 'low elev / dividers / gaps',
    },
    {
      'elev': 6,
      'div': false,
      'gaps': true,
      'label': 'high elev / no dividers / gaps',
    },
  ];

  final List<Widget> comboTiles = List<Widget>.generate(
    combos.length,
    (int i) {
      final Map<String, dynamic> c = combos[i];
      final double elev = (c['elev'] as int).toDouble();
      final bool div = c['div'] as bool;
      final bool gaps = c['gaps'] as bool;

      final List<MergeableMaterialItem> children = <MergeableMaterialItem>[];
      for (int j = 0; j < 3; j++) {
        if (j > 0 && gaps) {
          children.add(MaterialGap(
            key: ValueKey<String>('combo_${i}_gap_$j'),
            size: 10.0,
          ));
        }
        children.add(MaterialSlice(
          key: ValueKey<String>('combo_${i}_slice_$j'),
          child: ListTile(
            dense: true,
            leading: Icon(
              Icons.album,
              color: brandPrimary,
              size: 18.0,
            ),
            title: Text('Row ${j + 1}'),
          ),
        ));
      }

      return Container(
        width: 260.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: brandPrimary.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c['label'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: brandPrimary,
              ),
            ),
            SizedBox(height: 6.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: [
                _chip('elev: $elev', brandPrimary),
                _chip(div ? 'dividers' : 'no dividers',
                    div ? brandAccent : brandMuted),
                _chip(gaps ? 'gaps' : 'no gaps',
                    gaps ? Color(0xFF8B5CF6) : brandMuted),
              ],
            ),
            SizedBox(height: 8.0),
            MergeableMaterial(
              elevation: elev,
              hasDividers: div,
              children: children,
            ),
          ],
        ),
      );
    },
  );

  // ============================================================
  // SECTION 14: Numeric ladder (math.sqrt based subtitles)
  // ============================================================

  final List<MergeableMaterialItem> ladderItems = <MergeableMaterialItem>[];
  for (int i = 1; i <= 7; i++) {
    if (i > 1 && i % 3 == 1) {
      ladderItems.add(MaterialGap(
        key: ValueKey<String>('ladder_gap_$i'),
        size: 14.0,
      ));
    }
    final double sqrtV = math.sqrt(i.toDouble());
    ladderItems.add(MaterialSlice(
      key: ValueKey<String>('ladder_$i'),
      child: ListTile(
        leading: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brandPrimary, brandAccent],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '$i',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text('Step $i'),
        subtitle: Text('sqrt($i) = ${sqrtV.toStringAsFixed(3)}'),
        trailing: SizedBox(
          width: 60.0,
          height: 6.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: brandMuted.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (sqrtV / math.sqrt(7.0)).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: brandPrimary,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  final Widget ladderDemo = MergeableMaterial(
    children: ladderItems,
  );

  // ============================================================
  // SECTION 15: Summary key takeaways
  // ============================================================

  final List<Map<String, dynamic>> takeaways = [
    {
      'icon': Icons.layers,
      'title': 'Slices are Material surfaces',
      'desc': 'Adjacent MaterialSlice items share a single Material '
          'surface — corners only round at the outermost edges.',
      'color': brandPrimary,
    },
    {
      'icon': Icons.space_bar,
      'title': 'Gaps split surfaces',
      'desc': 'Insert MaterialGap to break slices into distinct '
          'Material surfaces, with an animated separator.',
      'color': brandAccent,
    },
    {
      'icon': Icons.vpn_key,
      'title': 'LocalKey is mandatory',
      'desc': 'Every MaterialSlice and MaterialGap needs a stable '
          'LocalKey so animations can track items across rebuilds.',
      'color': Color(0xFF8B5CF6),
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Works on either axis',
      'desc': 'mainAxis flips the layout between vertical lists and '
          'horizontal segmented rails.',
      'color': Color(0xFF43A047),
    },
    {
      'icon': Icons.tune,
      'title': 'Tune visuals + timing',
      'desc': 'elevation, hasDividers, dividerColor and per-slice '
          'colors tailor the appearance to your design.',
      'color': Color(0xFFFB8C00),
    },
  ];

  final List<Widget> takeawayWidgets = List<Widget>.generate(
    takeaways.length,
    (int i) {
      final Map<String, dynamic> t = takeaways[i];
      final Color color = t['color'] as Color;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(t['icon'] as IconData, color: color, size: 20.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    t['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: brandInk,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  final Widget summaryPanel = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          brandPrimary.withValues(alpha: 0.12),
          brandAccent.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: brandPrimary.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: brandPrimary),
            SizedBox(width: 8.0),
            Text(
              'Key Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: brandPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...takeawayWidgets,
      ],
    ),
  );

  // ============================================================
  // Assemble final scaffold
  // ============================================================

  return Scaffold(
    backgroundColor: brandSurface,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            _sectionTitle(
              '1. Concepts',
              'Slices, gaps, and the merging container',
              Icons.school,
              brandPrimary,
            ),
            SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: conceptCards,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '2. Baseline slices',
              'A list of MaterialSlice children sharing one surface',
              Icons.view_list,
              brandPrimary,
            ),
            SizedBox(height: 12.0),
            baselineDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '3. Gap-separated groups',
              'MaterialGap splits content into distinct surfaces',
              Icons.format_line_spacing,
              brandAccent,
            ),
            SizedBox(height: 12.0),
            gapGroupsDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '4. Variable gap sizes',
              'Each MaterialGap can declare its own size',
              Icons.height,
              Color(0xFF8B5CF6),
            ),
            SizedBox(height: 12.0),
            varGapDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '5. Elevation variants',
              'The same content rendered at multiple z-levels',
              Icons.layers_outlined,
              brandPrimary,
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: elevationCards,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '6. hasDividers toggle',
              'Compare divider lines between merged slices',
              Icons.horizontal_rule,
              Color(0xFF43A047),
            ),
            SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dividerCompare,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '7. dividerColor showcase',
              'Tint the dividers between merged slices',
              Icons.color_lens,
              Color(0xFFFB8C00),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: dividerColorCards,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '8. MaterialSlice color tinting',
              'Use MaterialSlice.color to tint individual slices',
              Icons.brush,
              brandAccent,
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: tintCards,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '9. mainAxis horizontal',
              'Lay out slices left-to-right with horizontal gaps',
              Icons.swap_horiz,
              Color(0xFF8B5CF6),
            ),
            SizedBox(height: 12.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: horizontalDemo,
            ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: horizontalNoGaps,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '10. FAQ accordion',
              'A common pattern: question/answer rows with gaps',
              Icons.quiz,
              brandPrimary,
            ),
            SizedBox(height: 12.0),
            faqDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '11. Banner-style group',
              'Branded header, content rows, separated footer',
              Icons.campaign,
              brandAccent,
            ),
            SizedBox(height: 12.0),
            bannerDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '12. Settings list',
              'Sectioned settings UI built from slices and gaps',
              Icons.settings,
              Color(0xFF43A047),
            ),
            SizedBox(height: 12.0),
            settingsDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '13. Property combination matrix',
              'Mix elevation, dividers and gaps to see the variations',
              Icons.grid_view,
              Color(0xFFFB8C00),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: comboTiles,
            ),
            SizedBox(height: 28.0),
            _sectionTitle(
              '14. Numeric ladder',
              'Slices with rich trailing widgets and computed subtitles',
              Icons.stairs,
              brandPrimary,
            ),
            SizedBox(height: 12.0),
            ladderDemo,
            SizedBox(height: 28.0),
            _sectionTitle(
              '15. Summary',
              'Key takeaways for using MergeableMaterial in practice',
              Icons.flag,
              Color(0xFF8B5CF6),
            ),
            SizedBox(height: 12.0),
            summaryPanel,
            SizedBox(height: 32.0),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'MergeableMaterial Deep Demo completed.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: brandMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _sectionTitle(
  String number,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}
