// ignore_for_file: avoid_print
// D4rt deep-demo: WrapCrossAlignment — Plum / Berry theme, prefix wc
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget wcSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF6A1B9A), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFF4A148C))),
        ),
      ],
    ),
  );
}

Widget wcChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12.0)),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget wcInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140.0,
          child: Text(label, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF4A148C)))),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 12.0, color: Color(0xFF6A5B7B)))),
      ],
    ),
  );
}

Widget wcCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(color: Color(0xFFF3E5F5), borderRadius: BorderRadius.circular(6.0)),
    child: Text(code, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF4A148C))),
  );
}

Widget wcAlignmentBox(String label, Color bg, {double w = 40.0, double h = 40.0}) {
  return Container(
    width: w, height: h,
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4.0)),
    child: Center(child: Text(label, textAlign: TextAlign.center,
        style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w600, color: Colors.white))),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] WrapCrossAlignment Deep Demo');
  print('  Controls cross-axis alignment within Wrap rows/columns');

  final wcTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.wrap_text, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('WrapCrossAlignment',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('How children align on the cross axis within each run of a Wrap',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFCE93D8))),
        SizedBox(height: 8.0),
        Wrap(children: [
          wcChip('start', Color(0xFF8E24AA)),
          wcChip('end', Color(0xFF7B1FA2)),
          wcChip('center', Color(0xFF6A1B9A)),
        ]),
      ],
    ),
  );

  // ── Section 2: Enum Values Overview ──────────────────────────
  print('\n[2] WrapCrossAlignment Values');
  for (final wca in WrapCrossAlignment.values) {
    print('  ${wca.name}: index=${wca.index}');
  }

  final alignValues = <Map<String, dynamic>>[
    {'value': WrapCrossAlignment.start, 'icon': Icons.align_vertical_top,
     'color': Color(0xFF8E24AA), 'desc': 'Children placed at start of cross axis in each run'},
    {'value': WrapCrossAlignment.end, 'icon': Icons.align_vertical_bottom,
     'color': Color(0xFF7B1FA2), 'desc': 'Children placed at end of cross axis in each run'},
    {'value': WrapCrossAlignment.center, 'icon': Icons.align_vertical_center,
     'color': Color(0xFF6A1B9A), 'desc': 'Children centered on cross axis in each run'},
  ];

  final wcEnumSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: alignValues.map((av) {
        final wca = av['value'] as WrapCrossAlignment;
        return Container(
          width: 100.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: (av['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(av['icon'] as IconData, color: av['color'] as Color, size: 28.0),
              SizedBox(height: 4.0),
              Text(wca.name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: av['color'] as Color)),
              Text('index: ${wca.index}', style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF6A5B7B))),
              SizedBox(height: 2.0),
              Text(av['desc'] as String, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.0, color: Color(0xFF6A5B7B))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 3: Visual — start ────────────────────────────────
  print('\n[3] WrapCrossAlignment.start Visual');

  final wcStartSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Children align to the top (horizontal) or left (vertical) of each run',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF8E24AA).withValues(alpha: 0.3)),
          ),
          child: Wrap(
            spacing: 6.0, runSpacing: 6.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              wcAlignmentBox('A', Color(0xFF8E24AA), h: 50.0),
              wcAlignmentBox('B', Color(0xFF7B1FA2), h: 30.0),
              wcAlignmentBox('C', Color(0xFF6A1B9A), h: 60.0),
              wcAlignmentBox('D', Color(0xFF4A148C), h: 20.0),
              wcAlignmentBox('E', Color(0xFF8E24AA), h: 45.0),
              wcAlignmentBox('F', Color(0xFF7B1FA2), h: 35.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text('All items align to the TOP of each run', style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B))),
        SizedBox(height: 8.0),
        wcCodeBlock('Wrap(\n  crossAxisAlignment: WrapCrossAlignment.start,\n  children: [...],\n)'),
      ],
    ),
  );

  // ── Section 4: Visual — end ──────────────────────────────────
  print('\n[4] WrapCrossAlignment.end Visual');

  final wcEndSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Children align to the bottom (horizontal) or right (vertical) of each run',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF7B1FA2).withValues(alpha: 0.3)),
          ),
          child: Wrap(
            spacing: 6.0, runSpacing: 6.0,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              wcAlignmentBox('A', Color(0xFF8E24AA), h: 50.0),
              wcAlignmentBox('B', Color(0xFF7B1FA2), h: 30.0),
              wcAlignmentBox('C', Color(0xFF6A1B9A), h: 60.0),
              wcAlignmentBox('D', Color(0xFF4A148C), h: 20.0),
              wcAlignmentBox('E', Color(0xFF8E24AA), h: 45.0),
              wcAlignmentBox('F', Color(0xFF7B1FA2), h: 35.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text('All items align to the BOTTOM of each run', style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B))),
      ],
    ),
  );

  // ── Section 5: Visual — center ───────────────────────────────
  print('\n[5] WrapCrossAlignment.center Visual');

  final wcCenterSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Children vertically centered within each run',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF6A1B9A).withValues(alpha: 0.3)),
          ),
          child: Wrap(
            spacing: 6.0, runSpacing: 6.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              wcAlignmentBox('A', Color(0xFF8E24AA), h: 50.0),
              wcAlignmentBox('B', Color(0xFF7B1FA2), h: 30.0),
              wcAlignmentBox('C', Color(0xFF6A1B9A), h: 60.0),
              wcAlignmentBox('D', Color(0xFF4A148C), h: 20.0),
              wcAlignmentBox('E', Color(0xFF8E24AA), h: 45.0),
              wcAlignmentBox('F', Color(0xFF7B1FA2), h: 35.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text('All items CENTERED vertically within each run', style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B))),
      ],
    ),
  );

  // ── Section 6: Side-by-Side Comparison ───────────────────────
  print('\n[6] Side-by-Side Comparison');

  Widget wcComparisonPanel(WrapCrossAlignment align, Color accent) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(align.name, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: accent)),
            SizedBox(height: 4.0),
            Wrap(
              spacing: 3.0, runSpacing: 3.0,
              crossAxisAlignment: align,
              children: [
                wcAlignmentBox('1', accent, w: 28.0, h: 40.0),
                wcAlignmentBox('2', accent.withValues(alpha: 0.7), w: 28.0, h: 20.0),
                wcAlignmentBox('3', accent.withValues(alpha: 0.5), w: 28.0, h: 50.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final wcCompareSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Row(
      children: [
        wcComparisonPanel(WrapCrossAlignment.start, Color(0xFF8E24AA)),
        SizedBox(width: 6.0),
        wcComparisonPanel(WrapCrossAlignment.center, Color(0xFF6A1B9A)),
        SizedBox(width: 6.0),
        wcComparisonPanel(WrapCrossAlignment.end, Color(0xFF4A148C)),
      ],
    ),
  );

  // ── Section 7: Vertical Wrap ─────────────────────────────────
  print('\n[7] Vertical Wrap with CrossAlignment');

  final wcVerticalSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('When direction is Axis.vertical, cross-axis is horizontal',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: WrapCrossAlignment.values.map((wca) {
            final colors = [Color(0xFF8E24AA), Color(0xFF7B1FA2), Color(0xFF6A1B9A)];
            return Container(
              width: 100.0, height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Color(0xFFCE93D8)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(wca.name, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700, color: Color(0xFF4A148C))),
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 3.0, runSpacing: 3.0,
                      crossAxisAlignment: wca,
                      children: [
                        wcAlignmentBox('', colors[0], w: 20.0, h: 30.0),
                        wcAlignmentBox('', colors[1], w: 35.0, h: 20.0),
                        wcAlignmentBox('', colors[2], w: 15.0, h: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 6.0),
        Text('Vertical: start = LEFT, center = MIDDLE, end = RIGHT',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B))),
      ],
    ),
  );

  // ── Section 8: With Spacing & RunSpacing ─────────────────────
  print('\n[8] Spacing and RunSpacing');

  final spacingVals = <Map<String, dynamic>>[
    {'spacing': 4.0, 'runSpacing': 4.0, 'label': 'Tight'},
    {'spacing': 12.0, 'runSpacing': 12.0, 'label': 'Normal'},
    {'spacing': 20.0, 'runSpacing': 20.0, 'label': 'Wide'},
  ];

  final wcSpacingSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spacing affects gaps between items; runSpacing between runs',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        ...spacingVals.map((sv) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${sv['label']} — spacing: ${(sv['spacing'] as double).toStringAsFixed(0)}, runSpacing: ${(sv['runSpacing'] as double).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF4A148C))),
                SizedBox(height: 4.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                  child: Wrap(
                    spacing: sv['spacing'] as double,
                    runSpacing: sv['runSpacing'] as double,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      wcAlignmentBox('1', Color(0xFF8E24AA), h: 35.0),
                      wcAlignmentBox('2', Color(0xFF7B1FA2), h: 25.0),
                      wcAlignmentBox('3', Color(0xFF6A1B9A), h: 40.0),
                      wcAlignmentBox('4', Color(0xFF4A148C), h: 30.0),
                      wcAlignmentBox('5', Color(0xFF8E24AA), h: 38.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 9: WrapAlignment (main axis) ─────────────────────
  print('\n[9] WrapAlignment — Main Axis Partner');
  for (final wa in WrapAlignment.values) {
    print('  ${wa.name}: index=${wa.index}');
  }

  final mainAligns = <Map<String, dynamic>>[
    {'value': WrapAlignment.start, 'color': Color(0xFF8E24AA), 'desc': 'Items packed at start'},
    {'value': WrapAlignment.center, 'color': Color(0xFF7B1FA2), 'desc': 'Items centered'},
    {'value': WrapAlignment.end, 'color': Color(0xFF6A1B9A), 'desc': 'Items packed at end'},
    {'value': WrapAlignment.spaceBetween, 'color': Color(0xFF4A148C), 'desc': 'Even space between'},
    {'value': WrapAlignment.spaceAround, 'color': Color(0xFF8E24AA), 'desc': 'Equal space around each'},
    {'value': WrapAlignment.spaceEvenly, 'color': Color(0xFF7B1FA2), 'desc': 'Equal space everywhere'},
  ];

  final wcMainAlignSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WrapAlignment controls main-axis distribution (partner to cross-axis)',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 8.0),
        ...mainAligns.map((ma) {
          final wa = ma['value'] as WrapAlignment;
          return Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: Row(
              children: [
                Container(width: 8.0, height: 8.0,
                  decoration: BoxDecoration(color: ma['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 8.0),
                SizedBox(width: 100.0,
                  child: Text('.${wa.name}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                      fontFamily: 'monospace', color: ma['color'] as Color))),
                Expanded(child: Text(ma['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B)))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 10: runAlignment ─────────────────────────────────
  print('\n[10] runAlignment — Run Distribution');

  final wcRunAlignSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('runAlignment distributes runs on the cross axis (like mainAxisAlignment for runs)',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Properties:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF4A148C))),
                    SizedBox(height: 4.0),
                    Text('alignment → along main axis\ncrossAxis → items within run\nrunAlignment → runs within wrap',
                        style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF6A5B7B))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Difference:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF4A148C))),
                    SizedBox(height: 4.0),
                    Text('crossAxisAlignment\n  → within ONE run\nrunAlignment\n  → between ALL runs',
                        style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF6A5B7B))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        wcCodeBlock('Wrap(\n  alignment: WrapAlignment.center,\n  crossAxisAlignment: WrapCrossAlignment.center,\n  runAlignment: WrapAlignment.spaceEvenly,\n)'),
      ],
    ),
  );

  // ── Section 11: Mixed Heights Demo ───────────────────────────
  print('\n[11] Mixed Heights — Cross Alignment Effect');

  final wcMixedSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cross alignment is most visible with mixed-height children',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Wrap(
            spacing: 8.0, runSpacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              wcAlignmentBox('XS', Color(0xFF8E24AA), w: 50.0, h: 20.0),
              wcAlignmentBox('LG', Color(0xFF7B1FA2), w: 70.0, h: 60.0),
              wcAlignmentBox('MD', Color(0xFF6A1B9A), w: 60.0, h: 40.0),
              wcAlignmentBox('XL', Color(0xFF4A148C), w: 80.0, h: 70.0),
              wcAlignmentBox('SM', Color(0xFF8E24AA), w: 45.0, h: 30.0),
              wcAlignmentBox('MD', Color(0xFF7B1FA2), w: 55.0, h: 45.0),
              wcAlignmentBox('XS', Color(0xFF6A1B9A), w: 40.0, h: 18.0),
              wcAlignmentBox('LG', Color(0xFF4A148C), w: 65.0, h: 55.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text('Varying sizes clearly show center alignment effect',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF6A5B7B))),
      ],
    ),
  );

  // ── Section 12: Chip/Tag Pattern ─────────────────────────────
  print('\n[12] Real-World: Chip/Tag Layout');

  final tags = ['Flutter', 'Dart', 'Wrap', 'Cross', 'Align', 'Demo', 'Layout', 'Widget', 'UI', 'Berry'];

  final wcTagSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Wrap is commonly used for chip/tag layouts',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0, runSpacing: 6.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: tags.asMap().entries.map((entry) {
            final shade = Color.lerp(Color(0xFF8E24AA), Color(0xFF4A148C), entry.key / tags.length)!;
            return Chip(
              label: Text(entry.value, style: TextStyle(fontSize: 11.0, color: Colors.white)),
              backgroundColor: shade,
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              side: BorderSide.none,
            );
          }).toList(),
        ),
        SizedBox(height: 8.0),
        wcCodeBlock('Wrap(\n  spacing: 8.0,\n  runSpacing: 6.0,\n  crossAxisAlignment: WrapCrossAlignment.center,\n  children: tags.map((t) => Chip(label: Text(t))).toList(),\n)'),
      ],
    ),
  );

  // ── Section 13: textDirection & verticalDirection ─────────────
  print('\n[13] textDirection & verticalDirection');

  final wcDirectionSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text and vertical direction affect how start/end are interpreted',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF4A148C))),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    Text('LTR + start', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF8E24AA))),
                    SizedBox(height: 4.0),
                    Wrap(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 3.0,
                      children: [
                        wcAlignmentBox('1', Color(0xFF8E24AA), w: 24.0, h: 30.0),
                        wcAlignmentBox('2', Color(0xFF7B1FA2), w: 24.0, h: 20.0),
                        wcAlignmentBox('3', Color(0xFF6A1B9A), w: 24.0, h: 40.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    Text('RTL + end', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF6A1B9A))),
                    SizedBox(height: 4.0),
                    Wrap(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 3.0,
                      children: [
                        wcAlignmentBox('1', Color(0xFF8E24AA), w: 24.0, h: 30.0),
                        wcAlignmentBox('2', Color(0xFF7B1FA2), w: 24.0, h: 20.0),
                        wcAlignmentBox('3', Color(0xFF6A1B9A), w: 24.0, h: 40.0),
                      ],
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

  // ── Section 14: Wrap Properties Table ────────────────────────
  print('\n[14] Complete Wrap Properties');

  final wrapProps = <Map<String, dynamic>>[
    {'prop': 'direction', 'type': 'Axis', 'desc': 'Main axis direction (horizontal/vertical)'},
    {'prop': 'alignment', 'type': 'WrapAlignment', 'desc': 'Main-axis alignment within each run'},
    {'prop': 'spacing', 'type': 'double', 'desc': 'Gap between children on main axis'},
    {'prop': 'runAlignment', 'type': 'WrapAlignment', 'desc': 'Cross-axis distribution of runs'},
    {'prop': 'runSpacing', 'type': 'double', 'desc': 'Gap between runs'},
    {'prop': 'crossAxisAlignment', 'type': 'WrapCrossAlignment', 'desc': 'Cross-axis alignment within each run'},
    {'prop': 'textDirection', 'type': 'TextDirection?', 'desc': 'Text direction for main axis'},
    {'prop': 'verticalDirection', 'type': 'VerticalDirection', 'desc': 'Vertical run stacking order'},
    {'prop': 'clipBehavior', 'type': 'Clip', 'desc': 'How to clip overflowing children'},
  ];

  final wcPropsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      children: wrapProps.asMap().entries.map((entry) {
        final wp = entry.value;
        final shade = Color.lerp(Color(0xFF8E24AA), Color(0xFF4A148C), entry.key / wrapProps.length)!;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 4.0),
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border(left: BorderSide(color: shade, width: 3.0)),
          ),
          child: Row(
            children: [
              SizedBox(width: 120.0,
                child: Text(wp['prop'] as String,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, fontFamily: 'monospace', color: shade))),
              wcChip(wp['type'] as String, shade.withValues(alpha: 0.6)),
              Expanded(child: Text(wp['desc'] as String, style: TextStyle(fontSize: 9.0, color: Color(0xFF6A5B7B)))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: Equality & Comparison ────────────────────────
  print('\n[15] Equality & Comparison');
  final eq1 = WrapCrossAlignment.start == WrapCrossAlignment.start;
  final eq2 = WrapCrossAlignment.start == WrapCrossAlignment.end;
  print('  start == start: $eq1');
  print('  start == end: $eq2');

  final wcEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wcInfoRow('start == start:', eq1.toString()),
        wcInfoRow('start == end:', eq2.toString()),
        wcInfoRow('start.index:', WrapCrossAlignment.start.index.toString()),
        wcInfoRow('center.index:', WrapCrossAlignment.center.index.toString()),
        wcInfoRow('end.index:', WrapCrossAlignment.end.index.toString()),
        wcInfoRow('values.length:', WrapCrossAlignment.values.length.toString()),
        SizedBox(height: 8.0),
        wcCodeBlock('switch (crossAlignment) {\n  case WrapCrossAlignment.start:\n    // align to top of run\n  case WrapCrossAlignment.center:\n    // align to center of run\n  case WrapCrossAlignment.end:\n    // align to bottom of run\n}'),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  3 values: start, center, end');
  print('  Controls cross-axis alignment WITHIN each run');

  final wcSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('WrapCrossAlignment Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: WrapCrossAlignment.values.map((wca) {
            return Column(
              children: [
                Container(
                  width: 48.0, height: 48.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(wca.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white))),
                ),
                SizedBox(height: 4.0),
                Text('.${wca.name}', style: TextStyle(fontSize: 11.0, color: Color(0xFFCE93D8))),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0, runSpacing: 4.0, alignment: WrapAlignment.center,
          children: [
            wcChip('Cross-axis', Color(0xFF8E24AA)),
            wcChip('Within run', Color(0xFF7B1FA2)),
            wcChip('start/center/end', Color(0xFF6A1B9A)),
            wcChip('Horizontal & Vertical', Color(0xFF4A148C)),
          ],
        ),
      ],
    ),
  );

  print('\nWrapCrossAlignment Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wcTitleSection,
        wcSectionHeader('Enum Values', Icons.list),
        wcEnumSection,
        wcSectionHeader('start Alignment', Icons.align_vertical_top),
        wcStartSection,
        wcSectionHeader('end Alignment', Icons.align_vertical_bottom),
        wcEndSection,
        wcSectionHeader('center Alignment', Icons.align_vertical_center),
        wcCenterSection,
        wcSectionHeader('Side-by-Side', Icons.compare),
        wcCompareSection,
        wcSectionHeader('Vertical Wrap', Icons.swap_horiz),
        wcVerticalSection,
        wcSectionHeader('Spacing & RunSpacing', Icons.space_bar),
        wcSpacingSection,
        wcSectionHeader('WrapAlignment', Icons.format_align_center),
        wcMainAlignSection,
        wcSectionHeader('runAlignment', Icons.view_column),
        wcRunAlignSection,
        wcSectionHeader('Mixed Heights', Icons.height),
        wcMixedSection,
        wcSectionHeader('Chip/Tag Pattern', Icons.label),
        wcTagSection,
        wcSectionHeader('Direction Effects', Icons.swap_horizontal_circle),
        wcDirectionSection,
        wcSectionHeader('Wrap Properties', Icons.settings),
        wcPropsSection,
        wcSectionHeader('Equality', Icons.compare_arrows),
        wcEqualitySection,
        SizedBox(height: 8.0),
        wcSummarySection,
      ],
    ),
  );
}
