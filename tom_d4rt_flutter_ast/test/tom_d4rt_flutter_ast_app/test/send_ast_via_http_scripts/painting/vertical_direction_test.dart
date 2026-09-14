// ignore_for_file: avoid_print
// D4rt deep-demo: VerticalDirection — Grape / Violet theme, prefix vd
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget vdSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF6B3FA0), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A2D73),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget vdChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget vdInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A2D73))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF7B5EA8))),
        ),
      ],
    ),
  );
}

Widget vdNumberBox(int num, Color color) {
  return Container(
    width: 40.0,
    height: 32.0,
    margin: EdgeInsets.symmetric(vertical: 2.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text('$num',
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white)),
  );
}

Widget vdDirectionColumn(String label, VerticalDirection dir, Color accent) {
  final boxColors = [
    Color(0xFF8B5CF6),
    Color(0xFF9B7AE0),
    Color(0xFFA78BCA),
    Color(0xFFB9A3D8),
  ];
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: accent)),
        SizedBox(height: 6.0),
        Column(
          verticalDirection: dir,
          children: [
            for (int i = 0; i < 4; i++) vdNumberBox(i + 1, boxColors[i]),
          ],
        ),
        SizedBox(height: 4.0),
        Icon(
          dir == VerticalDirection.down
              ? Icons.arrow_downward
              : Icons.arrow_upward,
          color: accent,
          size: 18.0,
        ),
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('VerticalDirection Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] VerticalDirection Overview');
  print('  Enum for vertical layout direction');
  print('  2 values: up, down');
  print('  Used in Column, Flex, ListBody');

  final vdTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6B3FA0), Color(0xFF4A2D73)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_vert, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('VerticalDirection',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
            'Controls whether children are laid out from top-to-bottom '
            'or bottom-to-top in vertical flex layouts',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFD4C4F0))),
        SizedBox(height: 6.0),
        Row(
          children: [
            vdChip('up', Color(0xFF9B7AE0)),
            vdChip('down', Color(0xFFA78BCA)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Two Values ───────────────────────────────────
  print('\n[2] The Two Directions');
  for (final v in VerticalDirection.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final vdTwoValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(
                left: BorderSide(color: Color(0xFF6B3FA0), width: 4.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_upward, color: Color(0xFF6B3FA0), size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('up',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A2D73))),
                    Text('Children laid out from bottom to top',
                        style: TextStyle(
                            fontSize: 11.0, color: Color(0xFF7B5EA8))),
                    Text('First child placed at bottom of container',
                        style: TextStyle(
                            fontSize: 10.0, color: Color(0xFF9B7AE0))),
                  ],
                ),
              ),
              Text('index: 0',
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF999999))),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(
                left: BorderSide(color: Color(0xFF9B7AE0), width: 4.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_downward, color: Color(0xFF9B7AE0), size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('down',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A2D73))),
                    Text('Children laid out from top to bottom (default)',
                        style: TextStyle(
                            fontSize: 11.0, color: Color(0xFF7B5EA8))),
                    Text('First child placed at top of container',
                        style: TextStyle(
                            fontSize: 10.0, color: Color(0xFF9B7AE0))),
                  ],
                ),
              ),
              Text('index: 1',
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF999999))),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 3: Live Column Demo ──────────────────────────────
  print('\n[3] Live Column Demo');
  print('  Showing same 4 children in both directions');

  final vdLiveDemo = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      children: [
        Text('Same children [1,2,3,4] rendered in both directions',
            style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: vdDirectionColumn(
                    'down (default)',
                    VerticalDirection.down,
                    Color(0xFF9B7AE0))),
            SizedBox(width: 12.0),
            Expanded(
                child: vdDirectionColumn(
                    'up (reversed)',
                    VerticalDirection.up,
                    Color(0xFF6B3FA0))),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Notice: "up" renders the same children in reverse visual order. '
            'Child 1 appears at the bottom, child 4 at the top.',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF7B5EA8)),
          ),
        ),
      ],
    ),
  );

  // ── Section 4: Column Widget Integration ─────────────────────
  print('\n[4] Column Widget Integration');
  print('  Column.verticalDirection defaults to down');
  print('  Setting to up reverses child order visually');

  final vdColumnUsage = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Column Property',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        vdInfoRow('Property:', 'Column.verticalDirection'),
        vdInfoRow('Type:', 'VerticalDirection'),
        vdInfoRow('Default:', 'VerticalDirection.down'),
        vdInfoRow('Inherited from:', 'Flex widget'),
        vdInfoRow('Affects:', 'Child ordering, alignment anchor'),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFEDE5F7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Column(\n'
            '  verticalDirection: VerticalDirection.up,\n'
            '  children: [\n'
            '    Text("First (now at bottom)"),\n'
            '    Text("Second"),\n'
            '    Text("Third (now at top)"),\n'
            '  ],\n'
            ')',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF4A2D73)),
          ),
        ),
      ],
    ),
  );

  // ── Section 5: MainAxisAlignment Interaction ─────────────────
  print('\n[5] MainAxisAlignment Interaction');
  print('  down + start = top edge');
  print('  up + start = bottom edge');
  print('  "start" meaning flips with direction');

  final mainAxisData = <Map<String, dynamic>>[
    {
      'dir': 'down',
      'align': 'start',
      'meaning': 'Children packed to top',
      'color': Color(0xFF9B7AE0),
    },
    {
      'dir': 'up',
      'align': 'start',
      'meaning': 'Children packed to bottom',
      'color': Color(0xFF6B3FA0),
    },
    {
      'dir': 'down',
      'align': 'end',
      'meaning': 'Children packed to bottom',
      'color': Color(0xFF9B7AE0),
    },
    {
      'dir': 'up',
      'align': 'end',
      'meaning': 'Children packed to top',
      'color': Color(0xFF6B3FA0),
    },
  ];

  final vdMainAxisSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      children: [
        Text(
            '"start" and "end" meanings flip based on verticalDirection',
            style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        ...mainAxisData.map((m) => Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 6.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  vdChip(m['dir'] as String, m['color'] as Color),
                  SizedBox(width: 4.0),
                  Text('+ ${m['align']}',
                      style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF4A2D73))),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_right,
                      color: Color(0xFF6B3FA0), size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Text(m['meaning'] as String,
                        style: TextStyle(
                            fontSize: 11.0, color: Color(0xFF7B5EA8))),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // ── Section 6: CrossAxisAlignment Interaction ────────────────
  print('\n[6] CrossAxisAlignment Interaction');
  print('  CrossAxisAlignment is NOT affected by verticalDirection');
  print('  start/end remain left/right regardless');

  final vdCrossAxisSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CrossAxisAlignment is Unaffected',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vdInfoRow('cross.start:', 'Always left (LTR)'),
              vdInfoRow('cross.end:', 'Always right (LTR)'),
              vdInfoRow('cross.center:', 'Always horizontally centered'),
              vdInfoRow('cross.stretch:', 'Always full width'),
              SizedBox(height: 6.0),
              Text(
                'VerticalDirection only affects the main axis (vertical) '
                'positioning and ordering, not the cross axis (horizontal).',
                style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF9B7AE0)),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 7: Practical Use Cases ───────────────────────────
  print('\n[7] Practical Use Cases');
  print('  Chat (newest at bottom): down or up depending on scroll');
  print('  Stack-like display: up');
  print('  Standard lists: down');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Chat Messages',
      'icon': Icons.chat_bubble_outline,
      'dir': 'down',
      'color': Color(0xFF6B3FA0),
      'desc': 'Messages flow top to bottom, newest last',
    },
    {
      'title': 'Reversed Chat',
      'icon': Icons.forum,
      'dir': 'up',
      'color': Color(0xFF9B7AE0),
      'desc': 'Messages grow upward from bottom anchor',
    },
    {
      'title': 'Bottom Sheet Stack',
      'icon': Icons.layers,
      'dir': 'up',
      'color': Color(0xFF6B3FA0),
      'desc': 'Items stack from bottom edge upward',
    },
    {
      'title': 'Standard Form',
      'icon': Icons.article,
      'dir': 'down',
      'color': Color(0xFF9B7AE0),
      'desc': 'Form fields flow top to bottom naturally',
    },
    {
      'title': 'Timeline (reversed)',
      'icon': Icons.schedule,
      'dir': 'up',
      'color': Color(0xFF6B3FA0),
      'desc': 'Oldest events at top, newest at bottom',
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications,
      'dir': 'down',
      'color': Color(0xFF9B7AE0),
      'desc': 'New notification at top, older below',
    },
  ];

  final vdUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: useCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Color(0xFFD4C4F0).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData,
                      color: uc['color'] as Color, size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(
                      child: Text(uc['title'] as String,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF4A2D73)))),
                ],
              ),
              SizedBox(height: 4.0),
              vdChip(uc['dir'] as String, uc['color'] as Color),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF7B5EA8))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: Flex Widget Usage ─────────────────────────────
  print('\n[8] Flex Widget Usage');
  print('  Column extends Flex (axis: vertical)');
  print('  Flex.verticalDirection works identically');
  print('  Row ignores verticalDirection (horizontal axis)');

  final vdFlexSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flex Family Widgets',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        _vdFlexCard('Column', 'Uses verticalDirection',
            'Children ordered top→bottom or bottom→top',
            Color(0xFF6B3FA0)),
        _vdFlexCard('Row', 'Ignores verticalDirection',
            'Uses textDirection for horizontal ordering',
            Color(0xFF9B7AE0)),
        _vdFlexCard('Flex(vertical)', 'Uses verticalDirection',
            'Equivalent to Column with explicit axis',
            Color(0xFF6B3FA0)),
        _vdFlexCard('Flex(horizontal)', 'Ignores verticalDirection',
            'Equivalent to Row — uses textDirection',
            Color(0xFF9B7AE0)),
      ],
    ),
  );

  // ── Section 9: Switch Pattern ────────────────────────────────
  print('\n[9] Switch Pattern');
  final testDir = VerticalDirection.up;
  switch (testDir) {
    case VerticalDirection.up:
      print('  → Bottom to top');
    case VerticalDirection.down:
      print('  → Top to bottom');
  }

  final vdSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFEDE5F7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final flow = switch (dir) {\n'
            '  VerticalDirection.up\n'
            '    => "Bottom to top",\n'
            '  VerticalDirection.down\n'
            '    => "Top to bottom",\n'
            '};',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF4A2D73)),
          ),
        ),
        SizedBox(height: 8.0),
        ...VerticalDirection.values.map((v) {
          final desc = switch (v) {
            VerticalDirection.up => 'Children flow bottom → top',
            VerticalDirection.down => 'Children flow top → bottom',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right,
                    color: Color(0xFF6B3FA0), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFF7B5EA8))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 10: Visual Flow Arrows ───────────────────────────
  print('\n[10] Visual Flow Arrows');
  print('  down: ↓ 1 → 2 → 3');
  print('  up:   ↑ 3 → 2 → 1');

  final vdFlowArrows = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Text('down ↓',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF9B7AE0))),
                SizedBox(height: 6.0),
                _vdFlowItem('Child A', Color(0xFF8B5CF6)),
                Icon(Icons.arrow_downward,
                    color: Color(0xFF9B7AE0), size: 14.0),
                _vdFlowItem('Child B', Color(0xFF9B7AE0)),
                Icon(Icons.arrow_downward,
                    color: Color(0xFF9B7AE0), size: 14.0),
                _vdFlowItem('Child C', Color(0xFFA78BCA)),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Text('up ↑',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B3FA0))),
                SizedBox(height: 6.0),
                _vdFlowItem('Child C', Color(0xFFA78BCA)),
                Icon(Icons.arrow_upward,
                    color: Color(0xFF6B3FA0), size: 14.0),
                _vdFlowItem('Child B', Color(0xFF9B7AE0)),
                Icon(Icons.arrow_upward,
                    color: Color(0xFF6B3FA0), size: 14.0),
                _vdFlowItem('Child A', Color(0xFF8B5CF6)),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ── Section 11: Comparison Table ─────────────────────────────
  print('\n[11] Comparison Table');
  print('  down: default, top-to-bottom, start=top');
  print('  up: reversed, bottom-to-top, start=bottom');

  final vdCompTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 70.0,
                child: Text('Aspect',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                        color: Color(0xFF4A2D73)))),
            Expanded(
                child: Text('down',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                        color: Color(0xFF9B7AE0)))),
            Expanded(
                child: Text('up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                        color: Color(0xFF6B3FA0)))),
          ],
        ),
        Divider(color: Color(0xFFD4C4F0)),
        _vdCompRow('Default?', 'Yes', 'No'),
        _vdCompRow('Flow', 'Top → Bottom', 'Bottom → Top'),
        _vdCompRow('"start"', 'Top edge', 'Bottom edge'),
        _vdCompRow('"end"', 'Bottom edge', 'Top edge'),
        _vdCompRow('First child', 'At top', 'At bottom'),
        _vdCompRow('Last child', 'At bottom', 'At top'),
      ],
    ),
  );

  // ── Section 12: Equality & Hashing ───────────────────────────
  print('\n[12] Equality & Hashing');
  print('  up == up: ${VerticalDirection.up == VerticalDirection.up}');
  print('  up == down: ${VerticalDirection.up == VerticalDirection.down}');

  final vdEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vdInfoRow('up == up:',
            '${VerticalDirection.up == VerticalDirection.up}'),
        vdInfoRow('up == down:',
            '${VerticalDirection.up == VerticalDirection.down}'),
        vdInfoRow('hashCode up:', '${VerticalDirection.up.hashCode}'),
        vdInfoRow('hashCode down:', '${VerticalDirection.down.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFD4C4F0)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: VerticalDirection.values
              .toSet()
              .map((v) => vdChip(v.name, Color(0xFF6B3FA0)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 13: Related Enums ────────────────────────────────
  print('\n[13] Related Enums');
  print('  Axis — horizontal vs vertical');
  print('  TextDirection — LTR vs RTL (horizontal direction)');
  print('  VerticalDirection — up vs down (vertical direction)');

  final vdRelatedSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Direction Enum Family',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        SizedBox(height: 8.0),
        _vdRelatedCard('Axis', 'horizontal | vertical',
            'Which axis a widget operates on', Color(0xFF6B3FA0)),
        _vdRelatedCard('TextDirection', 'ltr | rtl',
            'Horizontal direction for text and layout', Color(0xFF9B7AE0)),
        _vdRelatedCard('VerticalDirection', 'up | down',
            'Vertical direction for flex layout', Color(0xFF6B3FA0)),
        _vdRelatedCard('AxisDirection', 'up | right | down | left',
            'Combines Axis + direction into single value',
            Color(0xFF9B7AE0)),
      ],
    ),
  );

  // ── Section 14: Code Patterns ────────────────────────────────
  print('\n[14] Common Code Patterns');

  final vdPatterns = <Map<String, String>>[
    {
      'title': 'Reversed Column',
      'code': 'Column(\n'
          '  verticalDirection:\n'
          '    VerticalDirection.up,\n'
          '  mainAxisAlignment:\n'
          '    MainAxisAlignment.start,\n'
          '  // "start" is now bottom!\n'
          '  children: items,\n'
          ')',
    },
    {
      'title': 'Chat-Style Layout',
      'code': 'ListView(\n'
          '  reverse: true,\n'
          '  // Internally uses VerticalDirection.up\n'
          '  children: messages,\n'
          ')',
    },
    {
      'title': 'Conditional Direction',
      'code': 'Column(\n'
          '  verticalDirection: isReversed\n'
          '    ? VerticalDirection.up\n'
          '    : VerticalDirection.down,\n'
          '  children: children,\n'
          ')',
    },
  ];

  final vdPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Column(
      children: vdPatterns.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p['title']!,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B3FA0))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEDE5F7),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF4A2D73))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: Live Alignment Combos ────────────────────────
  print('\n[15] Live Alignment Combos');
  print('  4 combos: down+start, down+end, up+start, up+end');

  final combos = <Map<String, dynamic>>[
    {
      'dir': VerticalDirection.down,
      'align': MainAxisAlignment.start,
      'label': 'down + start',
    },
    {
      'dir': VerticalDirection.down,
      'align': MainAxisAlignment.end,
      'label': 'down + end',
    },
    {
      'dir': VerticalDirection.up,
      'align': MainAxisAlignment.start,
      'label': 'up + start',
    },
    {
      'dir': VerticalDirection.up,
      'align': MainAxisAlignment.end,
      'label': 'up + end',
    },
  ];

  final vdComboSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE5F7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD4C4F0)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: combos.map((c) {
        return Container(
          width: 140.0,
          height: 130.0,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Color(0xFFD4C4F0).withValues(alpha: 0.6)),
          ),
          child: Column(
            children: [
              Text(c['label'] as String,
                  style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B3FA0))),
              SizedBox(height: 4.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F0FA),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    verticalDirection: c['dir'] as VerticalDirection,
                    mainAxisAlignment: c['align'] as MainAxisAlignment,
                    children: [
                      Container(
                          width: 28.0,
                          height: 14.0,
                          margin: EdgeInsets.symmetric(vertical: 1.0),
                          color: Color(0xFF8B5CF6)),
                      Container(
                          width: 28.0,
                          height: 14.0,
                          margin: EdgeInsets.symmetric(vertical: 1.0),
                          color: Color(0xFF9B7AE0)),
                      Container(
                          width: 28.0,
                          height: 14.0,
                          margin: EdgeInsets.symmetric(vertical: 1.0),
                          color: Color(0xFFA78BCA)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Total values: ${VerticalDirection.values.length}');
  print('  Default: down');
  print('  Used in: Column, Flex, ListBody');

  final vdSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A2D73), Color(0xFF6B3FA0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('VerticalDirection Dashboard',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${VerticalDirection.values.length}',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4C4F0))),
                Text('Values',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFBFA8E0))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.arrow_downward,
                    color: Color(0xFFD4C4F0), size: 28.0),
                Text('Default: down',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFBFA8E0))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.view_column,
                    color: Color(0xFFD4C4F0), size: 28.0),
                Text('Used in: Column',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFBFA8E0))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          alignment: WrapAlignment.center,
          children: VerticalDirection.values
              .map((v) => vdChip(v.name, Color(0xFF9B7AE0)))
              .toList(),
        ),
      ],
    ),
  );

  print('\nVerticalDirection Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        vdTitleSection,
        SizedBox(height: 16.0),
        // 2 Two Values
        vdSectionHeader('The Two Directions', Icons.swap_vert),
        vdTwoValues,
        // 3 Live Demo
        vdSectionHeader('Live Column Demo', Icons.view_column),
        vdLiveDemo,
        // 4 Column Usage
        vdSectionHeader('Column Widget Integration', Icons.text_snippet),
        vdColumnUsage,
        // 5 MainAxis
        vdSectionHeader('MainAxisAlignment Interaction', Icons.vertical_align_center),
        vdMainAxisSection,
        // 6 CrossAxis
        vdSectionHeader('CrossAxisAlignment (Unaffected)', Icons.horizontal_rule),
        vdCrossAxisSection,
        // 7 Use Cases
        vdSectionHeader('Practical Use Cases', Icons.auto_awesome),
        vdUseCaseSection,
        // 8 Flex
        vdSectionHeader('Flex Widget Family', Icons.account_tree),
        vdFlexSection,
        // 9 Switch
        vdSectionHeader('Switch Pattern', Icons.alt_route),
        vdSwitchSection,
        // 10 Flow Arrows
        vdSectionHeader('Visual Flow Arrows', Icons.compare_arrows),
        vdFlowArrows,
        // 11 Comparison
        vdSectionHeader('Mode Comparison', Icons.table_chart),
        vdCompTable,
        // 12 Equality
        vdSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        vdEqualitySection,
        // 13 Related
        vdSectionHeader('Related Direction Enums', Icons.device_hub),
        vdRelatedSection,
        // 14 Patterns
        vdSectionHeader('Common Code Patterns', Icons.code),
        vdPatternsSection,
        // 15 Combos
        vdSectionHeader('Live Alignment Combos', Icons.grid_view),
        vdComboSection,
        // 16 Summary
        SizedBox(height: 8.0),
        vdSummarySection,
      ],
    ),
  );
}

// ── Top-level helpers ───────────────────────────────────────────
Widget _vdFlexCard(
    String widget, String status, String detail, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2D73))),
        Text(status,
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: accent)),
        Text(detail,
            style: TextStyle(
                fontSize: 10.0, color: Color(0xFF7B5EA8))),
      ],
    ),
  );
}

Widget _vdFlowItem(String label, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    margin: EdgeInsets.symmetric(vertical: 2.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(label,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: Colors.white)),
  );
}

Widget _vdCompRow(String aspect, String downVal, String upVal) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        SizedBox(
            width: 70.0,
            child: Text(aspect,
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A2D73)))),
        Expanded(
            child: Text(downVal,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.0, color: Color(0xFF7B5EA8)))),
        Expanded(
            child: Text(upVal,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.0, color: Color(0xFF7B5EA8)))),
      ],
    ),
  );
}

Widget _vdRelatedCard(
    String name, String values, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4A2D73))),
              Text(values,
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: accent)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF7B5EA8))),
            ],
          ),
        ),
      ],
    ),
  );
}
