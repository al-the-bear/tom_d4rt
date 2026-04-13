// ignore_for_file: avoid_print
// D4rt test script: Deep demo for AxisDirection from painting
// Demonstrates the 4 scroll-direction enum values, axis mapping,
// flip operations, and reversed-direction semantics with rich visuals.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AxisDirection Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color adPrimary = Color(0xFF546E7A); // blue-grey 600
  final Color adAccent = Color(0xFF78909C); // blue-grey 400
  final Color adSurface = Color(0xFFECEFF1); // blue-grey 50
  final Color adUpColor = Color(0xFF1565C0); // blue 800
  final Color adDownColor = Color(0xFFE65100); // orange 900
  final Color adLeftColor = Color(0xFF2E7D32); // green 800
  final Color adRightColor = Color(0xFF6A1B9A); // purple 800
  final Color adDark = Color(0xFF263238); // blue-grey 900

  Color adColorFor(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return adUpColor;
      case AxisDirection.down:
        return adDownColor;
      case AxisDirection.left:
        return adLeftColor;
      case AxisDirection.right:
        return adRightColor;
      default: // D4RT-LIMITATION: enum exhaustiveness
        return adUpColor;
    }
  }

  IconData adIconFor(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return Icons.arrow_upward;
      case AxisDirection.down:
        return Icons.arrow_downward;
      case AxisDirection.left:
        return Icons.arrow_back;
      case AxisDirection.right:
        return Icons.arrow_forward;
      default: // D4RT-LIMITATION: enum exhaustiveness
        return Icons.arrow_upward;
    }
  }

  Widget adBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11.0, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget adSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [adPrimary, adAccent],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  Widget adCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: adPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: adPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget adInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 130.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: adDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? adPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final adTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [adDark, adPrimary, adAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: adDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.explore, size: 48.0, color: Colors.white),
        SizedBox(height: 10.0),
        Text('AxisDirection',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text('painting library — enum',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 13.0,
                fontStyle: FontStyle.italic)),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Describes the direction along an axis in which content '
            'is ordered or scrolled. Used by Viewport, Scrollable, '
            'and Sliver families to determine growth direction.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Compass Rose — 4 Directions at a Glance
  // ============================================================
  print('=== Section 2: Compass Rose ===');

  Widget adCompassArm(AxisDirection d, Alignment align) {
    final c = adColorFor(d);
    return Align(
      alignment: align,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: c, width: 2.0),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(adIconFor(d), color: c, size: 26.0),
          Text(d.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 9.0, fontWeight: FontWeight.bold, color: c)),
        ]),
      ),
    );
  }

  final adCompass = adCard(Column(children: [
    Text('Direction Compass',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('All four AxisDirection values arranged spatially',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    SizedBox(
      height: 200.0,
      child: Stack(
        children: [
          // centre dot
          Center(
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: adDark,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // up
          Align(
            alignment: Alignment.topCenter,
            child: adCompassArm(AxisDirection.up, Alignment.topCenter),
          ),
          // down
          Align(
            alignment: Alignment.bottomCenter,
            child: adCompassArm(AxisDirection.down, Alignment.bottomCenter),
          ),
          // left
          Align(
            alignment: Alignment.centerLeft,
            child: adCompassArm(AxisDirection.left, Alignment.centerLeft),
          ),
          // right
          Align(
            alignment: Alignment.centerRight,
            child: adCompassArm(AxisDirection.right, Alignment.centerRight),
          ),
        ],
      ),
    ),
  ]));

  // ============================================================
  // SECTION 3: Enum Value Detail Cards
  // ============================================================
  print('=== Section 3: Enum Detail Cards ===');

  final adDetailCards = <Widget>[];
  for (final d in AxisDirection.values) {
    final c = adColorFor(d);
    final axis = axisDirectionToAxis(d);
    final reversed = axisDirectionIsReversed(d);
    final flipped = flipAxisDirection(d);
    print('  ${d.name}: axis=$axis, reversed=$reversed, flipped=${flipped.name}');

    adDetailCards.add(Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.withValues(alpha: 0.05), c.withValues(alpha: 0.13)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: c.withValues(alpha: 0.4)),
      ),
      child: Row(children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: c, width: 2.0),
          ),
          child: Center(
              child: Icon(adIconFor(d), color: c, size: 30.0)),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(d.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: c)),
              SizedBox(height: 4.0),
              Row(children: [
                adBadge('index ${d.index}', c),
                SizedBox(width: 6.0),
                adBadge(axis == Axis.vertical ? 'vertical' : 'horizontal', adPrimary),
                SizedBox(width: 6.0),
                adBadge(reversed ? 'reversed' : 'natural', reversed ? Colors.red.shade700 : Colors.teal.shade700),
              ]),
              SizedBox(height: 6.0),
              Text('flip → ${flipped.name}',
                  style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
            ],
          ),
        ),
      ]),
    ));
  }

  // ============================================================
  // SECTION 4: Axis Mapping — axisDirectionToAxis()
  // ============================================================
  print('=== Section 4: Axis Mapping ===');

  Widget adAxisGroup(String axisLabel, Color groupColor,
      List<AxisDirection> members) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: groupColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: groupColor.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Text('Axis.$axisLabel',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: groupColor)),
        SizedBox(height: 8.0),
        ...members.map((d) {
          final c = adColorFor(d);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(children: [
              Icon(adIconFor(d), size: 18.0, color: c),
              SizedBox(width: 6.0),
              Text(d.name,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: c)),
            ]),
          );
        }),
      ]),
    );
  }

  final adAxisMapping = adCard(Column(children: [
    Text('axisDirectionToAxis()',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('Maps each AxisDirection to its parent Axis',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: adAxisGroup(
            'vertical',
            Color(0xFF00695C),
            [AxisDirection.up, AxisDirection.down]),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: adAxisGroup(
            'horizontal',
            Color(0xFF4527A0),
            [AxisDirection.left, AxisDirection.right]),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 5: Reversed Direction Analysis
  // ============================================================
  print('=== Section 5: Reversed Direction Analysis ===');

  final adReversedRows = <TableRow>[];
  adReversedRows.add(TableRow(children: [
    Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Direction',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0, color: adDark))),
    Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Axis',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0, color: adDark))),
    Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Reversed?',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0, color: adDark))),
    Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Meaning',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0, color: adDark))),
  ]));

  final adReversedInfo = <Map<String, String>>[
    {'dir': 'up', 'axis': 'vertical', 'rev': 'YES',
      'meaning': 'Content grows upward (index 0 at bottom)'},
    {'dir': 'down', 'axis': 'vertical', 'rev': 'NO',
      'meaning': 'Natural top-to-bottom (index 0 at top)'},
    {'dir': 'left', 'axis': 'horizontal', 'rev': 'YES',
      'meaning': 'Content grows leftward (index 0 at right)'},
    {'dir': 'right', 'axis': 'horizontal', 'rev': 'NO',
      'meaning': 'Natural left-to-right (index 0 at left)'},
  ];
  for (final info in adReversedInfo) {
    final revColor = info['rev'] == 'YES'
        ? Colors.red.shade700
        : Colors.teal.shade700;
    adReversedRows.add(TableRow(
      decoration: BoxDecoration(
        color: revColor.withValues(alpha: 0.04),
      ),
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(info['dir']!,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600))),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(info['axis']!,
                style: TextStyle(fontSize: 12.0))),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(info['rev']!,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: revColor))),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(info['meaning']!,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700))),
      ],
    ));
  }

  final adReversedTable = adCard(Column(children: [
    Text('axisDirectionIsReversed()',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('"Reversed" means content grows opposite to the natural reading order',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Table(
      border: TableBorder.all(color: adPrimary.withValues(alpha: 0.2)),
      columnWidths: {
        0: FixedColumnWidth(70.0),
        1: FixedColumnWidth(80.0),
        2: FixedColumnWidth(72.0),
        3: FlexColumnWidth(),
      },
      children: adReversedRows,
    ),
  ]));

  // ============================================================
  // SECTION 6: flipAxisDirection() Visual
  // ============================================================
  print('=== Section 6: flipAxisDirection Visual ===');

  Widget adFlipCard(AxisDirection from) {
    final to = flipAxisDirection(from);
    final fc = adColorFor(from);
    final tc = adColorFor(to);
    print('  flip(${from.name}) = ${to.name}');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: adPrimary.withValues(alpha: 0.2)),
      ),
      child: Row(children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: fc.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(color: fc),
          ),
          child: Center(child: Icon(adIconFor(from), color: fc, size: 22.0)),
        ),
        SizedBox(width: 8.0),
        Text(from.name,
            style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.w600, color: fc)),
        Expanded(
          child: Center(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 30.0, height: 2.0, color: adPrimary.withValues(alpha: 0.4)),
              Icon(Icons.swap_horiz, size: 20.0, color: adPrimary),
              Container(width: 30.0, height: 2.0, color: adPrimary.withValues(alpha: 0.4)),
            ]),
          ),
        ),
        Text(to.name,
            style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.w600, color: tc)),
        SizedBox(width: 8.0),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: tc.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(color: tc),
          ),
          child: Center(child: Icon(adIconFor(to), color: tc, size: 22.0)),
        ),
      ]),
    );
  }

  final adFlipSection = adCard(Column(children: [
    Text('flipAxisDirection()',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('Returns the AxisDirection pointing in the opposite direction',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 10.0),
    ...AxisDirection.values.map((d) => adFlipCard(d)),
  ]));

  // ============================================================
  // SECTION 7: Scroll Simulation — visual list mock
  // ============================================================
  print('=== Section 7: Scroll Simulation ===');

  Widget adScrollMock(AxisDirection dir, {double width = 140.0, double height = 120.0}) {
    final c = adColorFor(dir);
    final isVert = axisDirectionToAxis(dir) == Axis.vertical;
    final reversed = axisDirectionIsReversed(dir);

    List<String> items = ['Item 0', 'Item 1', 'Item 2', 'Item 3'];
    if (reversed) items = items.reversed.toList();

    final children = items.map((label) {
      return Container(
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: c.withValues(alpha: 0.3)),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 9.0, color: c, fontWeight: FontWeight.w500)),
      );
    }).toList();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c, width: 1.5),
      ),
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(adIconFor(dir), size: 14.0, color: c),
            SizedBox(width: 4.0),
            Text(dir.name,
                style: TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.bold, color: c)),
          ]),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: isVert
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children),
          ),
        ),
      ]),
    );
  }

  final adScrollSection = adCard(Column(children: [
    Text('Scroll Direction Visualization',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('Each box shows how items order when scrolled in that AxisDirection',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: AxisDirection.values.map((d) => adScrollMock(d)).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 8: GrowthDirection Relationship
  // ============================================================
  print('=== Section 8: GrowthDirection Relationship ===');

  final adGrowthSection = adCard(Column(children: [
    Text('Relationship with GrowthDirection',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('A Viewport combines AxisDirection with GrowthDirection to decide '
        'where new slivers are painted',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: adSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        adInfoRow('AxisDirection', 'Which way the viewport grows'),
        adInfoRow('GrowthDirection', 'forward (add to end) or reverse (add to start)'),
        Divider(color: adPrimary.withValues(alpha: 0.2)),
        adInfoRow('forward + down', 'Typical top-to-bottom list'),
        adInfoRow('forward + right', 'Typical left-to-right row'),
        adInfoRow('reverse + down', 'Pinned header at bottom'),
        adInfoRow('reverse + up', 'Chat message list pattern'),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 9: Usage in Common Widgets
  // ============================================================
  print('=== Section 9: Usage in Common Widgets ===');

  final adUsageData = <Map<String, String>>[
    {'widget': 'ListView', 'prop': 'scrollDirection + reverse',
      'note': 'Translates to AxisDirection internally'},
    {'widget': 'GridView', 'prop': 'scrollDirection + reverse',
      'note': 'Same as ListView for main-axis'},
    {'widget': 'CustomScrollView', 'prop': 'scrollDirection + reverse',
      'note': 'Builds Viewport with AxisDirection'},
    {'widget': 'Viewport', 'prop': 'axisDirection (direct)',
      'note': 'Core rendering widget; owns the enum'},
    {'widget': 'RenderSliver', 'prop': 'constraints.axisDirection',
      'note': 'Received via SliverConstraints'},
    {'widget': 'ScrollPosition', 'prop': 'axisDirection',
      'note': 'Tracks the scroll physics direction'},
    {'widget': 'Scrollbar', 'prop': 'Derived from scroll position',
      'note': 'Draws indicator on matching edge'},
  ];

  final adUsageRows = <TableRow>[
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('Widget / Class',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: adDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Property',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: adDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: adDark))),
    ]),
  ];
  for (var i = 0; i < adUsageData.length; i++) {
    final u = adUsageData[i];
    adUsageRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven
            ? Colors.white
            : adSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(u['widget']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: adPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(u['prop']!,
            style: TextStyle(fontSize: 11.0))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(u['note']!,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600))),
      ],
    ));
  }

  final adUsageTable = adCard(Column(children: [
    Text('Widget Usage Map',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: adPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(120.0),
        1: FixedColumnWidth(140.0),
        2: FlexColumnWidth(),
      },
      children: adUsageRows,
    ),
  ]));

  // ============================================================
  // SECTION 10: Reverse Parameter → AxisDirection Conversion
  // ============================================================
  print('=== Section 10: reverse Flag Conversion ===');

  Widget adConversionRow(String scrollDir, bool reverse, AxisDirection result) {
    final c = adColorFor(result);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Row(children: [
        SizedBox(
          width: 90.0,
          child: Text('Axis.$scrollDir',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          width: 70.0,
          child: Text('reverse: $reverse',
              style: TextStyle(fontSize: 11.0,
                  color: reverse ? Colors.red.shade600 : Colors.grey.shade600)),
        ),
        Icon(Icons.arrow_right_alt, size: 18.0, color: adPrimary),
        SizedBox(width: 4.0),
        Icon(adIconFor(result), size: 16.0, color: c),
        SizedBox(width: 4.0),
        Text(result.name,
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: c)),
      ]),
    );
  }

  final adConversion = adCard(Column(children: [
    Text('scrollDirection + reverse → AxisDirection',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('How ListView/GridView resolve the direction enum',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 10.0),
    adConversionRow('vertical', false, AxisDirection.down),
    adConversionRow('vertical', true, AxisDirection.up),
    adConversionRow('horizontal', false, AxisDirection.right),
    adConversionRow('horizontal', true, AxisDirection.left),
  ]));

  // ============================================================
  // SECTION 11: Portrait of Each Direction — visual block arrows
  // ============================================================
  print('=== Section 11: Direction Portraits ===');

  Widget adPortrait(AxisDirection d, String explanation) {
    final c = adColorFor(d);
    return Container(
      width: 140.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [c.withValues(alpha: 0.06), c.withValues(alpha: 0.16)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: c.withValues(alpha: 0.35)),
      ),
      child: Column(children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [c.withValues(alpha: 0.25), c.withValues(alpha: 0.05)],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(adIconFor(d), color: c, size: 28.0)),
        ),
        SizedBox(height: 6.0),
        Text(d.name,
            style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 6.0),
        Text(explanation,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
      ]),
    );
  }

  final adPortraits = adCard(Column(children: [
    Text('Direction Portraits',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 10.0),
    Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      alignment: WrapAlignment.center,
      children: [
        adPortrait(AxisDirection.up,
            'Content scrolls upward.\nIndex 0 is at the bottom.'),
        adPortrait(AxisDirection.down,
            'Default ListView direction.\nIndex 0 is at the top.'),
        adPortrait(AxisDirection.left,
            'Right-to-left scroll.\nUsed for RTL layouts.'),
        adPortrait(AxisDirection.right,
            'Default horizontal scroll.\nIndex 0 is at the left.'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 12: textDirection & AxisDirection interplay
  // ============================================================
  print('=== Section 12: TextDirection Interplay ===');

  final adTextDirSection = adCard(Column(children: [
    Text('TextDirection Interplay',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 4.0),
    Text('textDirectionToAxisDirection() converts TextDirection to AxisDirection',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: adRightColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: adRightColor.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Text('TextDirection.ltr',
                style: TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: adRightColor)),
            SizedBox(height: 6.0),
            Icon(Icons.arrow_forward, color: adRightColor, size: 28.0),
            SizedBox(height: 4.0),
            Text('→ AxisDirection.right',
                style: TextStyle(fontSize: 11.0, color: adRightColor)),
            SizedBox(height: 2.0),
            Text('(English, German, …)',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: adLeftColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: adLeftColor.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Text('TextDirection.rtl',
                style: TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: adLeftColor)),
            SizedBox(height: 6.0),
            Icon(Icons.arrow_back, color: adLeftColor, size: 28.0),
            SizedBox(height: 4.0),
            Text('→ AxisDirection.left',
                style: TextStyle(fontSize: 11.0, color: adLeftColor)),
            SizedBox(height: 2.0),
            Text('(Arabic, Hebrew, …)',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 13: Practical Patterns
  // ============================================================
  print('=== Section 13: Practical Patterns ===');

  final adPatternsSection = adCard(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Practical Patterns',
          style: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
      SizedBox(height: 10.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: adUpColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: adUpColor.withValues(alpha: 0.2)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Chat App (reverse list)',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: adUpColor)),
          SizedBox(height: 4.0),
          Text('ListView(reverse: true) → AxisDirection.up\n'
              'Newest message at the bottom, scrolls up to see history.',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: adRightColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: adRightColor.withValues(alpha: 0.2)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Horizontal Carousel',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: adRightColor)),
          SizedBox(height: 4.0),
          Text('ListView(scrollDirection: Axis.horizontal) → AxisDirection.right\n'
              'Cards scroll left/right in natural LTR direction.',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: adDownColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: adDownColor.withValues(alpha: 0.2)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Standard Feed / Timeline',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: adDownColor)),
          SizedBox(height: 4.0),
          Text('ListView() → AxisDirection.down (default)\n'
              'Content flows top-to-bottom like a news feed or social timeline.',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
    ],
  ));

  // ============================================================
  // SECTION 14: Equality & Comparison
  // ============================================================
  print('=== Section 14: Equality & Comparison ===');

  final adEq1 = AxisDirection.up == AxisDirection.up;
  final adEq2 = AxisDirection.up == AxisDirection.down;
  final adIdx = AxisDirection.right.index;
  print('  up == up: $adEq1');
  print('  up == down: $adEq2');
  print('  right.index: $adIdx');

  final adEqualitySection = adCard(Column(children: [
    Text('Enum Equality & Index',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 10.0),
    adInfoRow('up == up', '$adEq1', valueColor: Colors.teal.shade700),
    adInfoRow('up == down', '$adEq2', valueColor: Colors.red.shade700),
    adInfoRow('values.length', '${AxisDirection.values.length}'),
    Divider(color: adPrimary.withValues(alpha: 0.15)),
    adInfoRow('up.index', '${AxisDirection.up.index}'),
    adInfoRow('right.index', '${AxisDirection.right.index}'),
    adInfoRow('down.index', '${AxisDirection.down.index}'),
    adInfoRow('left.index', '${AxisDirection.left.index}'),
  ]));

  // ============================================================
  // SECTION 15: Helper Functions Summary
  // ============================================================
  print('=== Section 15: Helper Functions Summary ===');

  final adHelperData = [
    {'fn': 'axisDirectionToAxis()', 'desc': 'Maps to Axis.horizontal or Axis.vertical'},
    {'fn': 'axisDirectionIsReversed()', 'desc': 'true for up and left (opposite of natural reading)'},
    {'fn': 'flipAxisDirection()', 'desc': 'Returns the opposite direction on the same axis'},
    {'fn': 'textDirectionToAxisDirection()', 'desc': 'Converts TextDirection.ltr/rtl to right/left'},
  ];

  final adHelperCards = adHelperData.map((h) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: adSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: adPrimary.withValues(alpha: 0.15)),
      ),
      child: Row(children: [
        Icon(Icons.functions, size: 18.0, color: adPrimary),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(h['fn']!,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: adDark)),
                Text(h['desc']!,
                    style: TextStyle(
                        fontSize: 11.0, color: Colors.grey.shade600)),
              ]),
        ),
      ]),
    );
  }).toList();

  final adHelperSection = adCard(Column(children: [
    Text('Helper Functions',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: adDark)),
    SizedBox(height: 10.0),
    ...adHelperCards,
  ]));

  // ============================================================
  // SECTION 16: Complete Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary Dashboard ===');

  final adSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [adDark, adPrimary],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('AxisDirection — Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 12.0),
      Row(children: [
        Expanded(child: Column(children: [
          Text('4', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('values', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('2', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('axes', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('4', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('helpers', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('2', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('reversed', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
      ]),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'AxisDirection is the low-level foundation for all scrollable layout '
          'in Flutter. While most developers interact with it indirectly via '
          'scrollDirection and reverse parameters, understanding the enum is '
          'essential for custom Viewport and Sliver implementations.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('AxisDirection Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        adTitleSection,
        SizedBox(height: 16.0),
        // 2 Compass
        adSectionHeader('Direction Compass', Icons.explore),
        adCompass,
        // 3 Detail Cards
        adSectionHeader('Enum Values', Icons.list_alt),
        ...adDetailCards,
        // 4 Axis Mapping
        adSectionHeader('Axis Mapping', Icons.swap_vert),
        adAxisMapping,
        // 5 Reversed
        adSectionHeader('Reversed Analysis', Icons.compare_arrows),
        adReversedTable,
        // 6 Flip
        adSectionHeader('Flip Direction', Icons.swap_horiz),
        adFlipSection,
        // 7 Scroll
        adSectionHeader('Scroll Simulation', Icons.view_list),
        adScrollSection,
        // 8 Growth
        adSectionHeader('GrowthDirection', Icons.trending_up),
        adGrowthSection,
        // 9 Usage
        adSectionHeader('Widget Usage', Icons.widgets),
        adUsageTable,
        // 10 Conversion
        adSectionHeader('Reverse Flag Conversion', Icons.transform),
        adConversion,
        // 11 Portraits
        adSectionHeader('Direction Portraits', Icons.portrait),
        adPortraits,
        // 12 TextDirection
        adSectionHeader('TextDirection Interplay', Icons.text_rotation_none),
        adTextDirSection,
        // 13 Patterns
        adSectionHeader('Practical Patterns', Icons.pattern),
        adPatternsSection,
        // 14 Equality
        adSectionHeader('Equality & Index', Icons.check_circle_outline),
        adEqualitySection,
        // 15 Helpers
        adSectionHeader('Helper Functions', Icons.functions),
        adHelperSection,
        // 16 Summary
        SizedBox(height: 8.0),
        adSummarySection,
      ],
    ),
  );
}
