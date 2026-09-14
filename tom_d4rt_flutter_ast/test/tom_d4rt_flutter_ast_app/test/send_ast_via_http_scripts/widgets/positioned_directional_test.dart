// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PositionedDirectional widget
// Demonstrates PositionedDirectional: a Directionality-aware version
// of Positioned for use inside Stack widgets. Instead of left/right,
// it uses start/end which automatically flip in RTL layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PositionedDirectional Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PositionedDirectional?
  // ============================================================
  // PositionedDirectional is a convenience widget that wraps
  // Positioned and replaces left/right with start/end. In a
  // left-to-right (LTR) layout, start maps to left and end maps
  // to right. In a right-to-left (RTL) layout, start maps to
  // right and end maps to left. This makes Stack-based layouts
  // automatically adapt to the text direction.
  //
  // Parameters:
  //   start: beginning edge (left in LTR, right in RTL)
  //   end: trailing edge (right in LTR, left in RTL)
  //   top: distance from top
  //   bottom: distance from bottom
  //   width: child width
  //   height: child height
  print('=== Section 1: PositionedDirectional Basics ===');

  // Basic LTR example — start is left, end is right
  final ltrBasic = Container(
    width: double.infinity,
    height: 160.0,
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // LTR label
          Positioned(
            top: 4.0,
            left: 4.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade700,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'LTR',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Start-positioned element
          PositionedDirectional(
            start: 16.0,
            top: 40.0,
            child: Container(
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blue.shade400),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'start: 16',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Text(
                    '→ left: 16',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // End-positioned element
          PositionedDirectional(
            end: 16.0,
            top: 40.0,
            child: Container(
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.green.shade400),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'end: 16',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  Text(
                    '→ right: 16',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom center element
          PositionedDirectional(
            start: 16.0,
            end: 16.0,
            bottom: 12.0,
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.purple.shade400),
              ),
              alignment: Alignment.center,
              child: Text(
                'start: 16 + end: 16 → stretches full width',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created basic LTR PositionedDirectional example');

  final section1 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Colors.indigo, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PositionedDirectional Basics',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PositionedDirectional replaces Positioned\'s left/right '
            'with start/end. In LTR layouts, start=left and end=right. '
            'In RTL layouts, they swap. Use it to make Stack layouts '
            'adapt automatically to the text direction.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ),
        SizedBox(height: 16.0),
        ltrBasic,
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Key parameters:\n'
            '• start — leading edge (left in LTR, right in RTL)\n'
            '• end — trailing edge (right in LTR, left in RTL)\n'
            '• top, bottom — same as Positioned\n'
            '• width, height — same as Positioned',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: LTR vs RTL Comparison
  // ============================================================
  print('=== Section 2: LTR vs RTL Side by Side ===');

  // Side by side: same PositionedDirectional layout in LTR and RTL
  final ltrRtlComparison = Row(
    children: [
      Expanded(
        child: _buildDirectionalStack(TextDirection.ltr),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: _buildDirectionalStack(TextDirection.rtl),
      ),
    ],
  );

  print('Created LTR vs RTL side-by-side comparison');

  final section2 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.teal, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'LTR vs RTL Comparison',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The same PositionedDirectional layout automatically mirrors '
          'in RTL mode. The "start" element swaps from left to right, '
          'and "end" swaps from right to left. All other properties '
          '(top, bottom, width, height) remain unchanged.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ltrRtlComparison,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Notification Badge Pattern
  // ============================================================
  print('=== Section 3: Notification Badges ===');

  // PositionedDirectional is perfect for floating badges,
  // notification dots, and overlays that need to be on the
  // "end" side regardless of text direction.
  final badgeExamplesLtr = Directionality(
    textDirection: TextDirection.ltr,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBadgeIcon(Icons.mail, '3', Colors.blue),
        _buildBadgeIcon(Icons.notifications, '12', Colors.red),
        _buildBadgeIcon(Icons.shopping_cart, '5', Colors.green),
        _buildBadgeIcon(Icons.chat, '99+', Colors.purple),
      ],
    ),
  );

  final badgeExamplesRtl = Directionality(
    textDirection: TextDirection.rtl,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBadgeIcon(Icons.mail, '3', Colors.blue),
        _buildBadgeIcon(Icons.notifications, '12', Colors.red),
        _buildBadgeIcon(Icons.shopping_cart, '5', Colors.green),
        _buildBadgeIcon(Icons.chat, '99+', Colors.purple),
      ],
    ),
  );

  print('Created notification badge examples');

  final section3 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.red, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Notification Badges',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Notification badges should appear on the "end" side of icons. '
          'Using PositionedDirectional with end: 0 ensures the badge '
          'automatically moves to the correct corner in RTL layouts.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LTR — badges on top-right:',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              badgeExamplesLtr,
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RTL — badges on top-left:',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              badgeExamplesRtl,
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Card Overlay Layout
  // ============================================================
  print('=== Section 4: Card Overlays ===');

  // Practical layout: image card with overlaid labels and buttons
  // that adjust for directionality.
  final cardOverlayLtr = Directionality(
    textDirection: TextDirection.ltr,
    child: _buildOverlayCard('LTR'),
  );

  final cardOverlayRtl = Directionality(
    textDirection: TextDirection.rtl,
    child: _buildOverlayCard('RTL'),
  );

  print('Created card overlay examples in LTR and RTL');

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.credit_card, color: Colors.amber.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Card Overlay Layouts',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PositionedDirectional is ideal for overlay elements on cards — '
          'favorite buttons, price tags, category labels, "new" badges. '
          'Each element stays on the correct edge in both LTR and RTL.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(child: cardOverlayLtr),
            SizedBox(width: 12.0),
            Expanded(child: cardOverlayRtl),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Positioned vs PositionedDirectional
  // ============================================================
  print('=== Section 5: Positioned vs PositionedDirectional ===');

  // Side by side comparison showing how regular Positioned
  // does NOT adapt to RTL, while PositionedDirectional does.
  final positionedComparison = Column(
    children: [
      // Positioned — does NOT flip in RTL
      Container(
        margin: EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Positioned (left: 10) — does NOT flip in RTL:',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10.0,
                            top: 10.0,
                            child: _buildPosLabel('left:10', Colors.red, 'LTR'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10.0,
                            top: 10.0,
                            child: _buildPosLabel('left:10', Colors.red, 'RTL'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // PositionedDirectional — DOES flip in RTL
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PositionedDirectional (start: 10) — DOES flip in RTL:',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade700,
            ),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Stack(
                      children: [
                        PositionedDirectional(
                          start: 10.0,
                          top: 10.0,
                          child: _buildPosLabel('start:10', Colors.green, 'LTR'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Stack(
                      children: [
                        PositionedDirectional(
                          start: 10.0,
                          top: 10.0,
                          child: _buildPosLabel('start:10', Colors.green, 'RTL'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  print('Created Positioned vs PositionedDirectional comparison');

  final section5 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Positioned vs PositionedDirectional',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Regular Positioned uses absolute left/right and ignores '
          'text direction entirely. PositionedDirectional adapts: '
          'start maps to left in LTR and right in RTL. This is '
          'critical for internationalized apps.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        positionedComparison,
        SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parameter mapping:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• Positioned(left: x) → always x from left edge\n'
                '• Positioned(right: x) → always x from right edge\n'
                '• PositionedDirectional(start: x) → x from leading edge\n'
                '• PositionedDirectional(end: x) → x from trailing edge',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Complex Layout — Dashboard Widget
  // ============================================================
  print('=== Section 6: Dashboard Overlay Widget ===');

  // A practical dashboard card with multiple overlaid elements
  // using PositionedDirectional for full RTL support.
  final dashboardLtr = Directionality(
    textDirection: TextDirection.ltr,
    child: _buildDashboardCard(),
  );

  final dashboardRtl = Directionality(
    textDirection: TextDirection.rtl,
    child: _buildDashboardCard(),
  );

  print('Created dashboard overlay widgets in LTR and RTL');

  final section6 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: Colors.blue.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Dashboard Overlay Widget',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A complex overlay layout with status indicators, action '
          'buttons, and labels — all using PositionedDirectional for '
          'automatic RTL adaptation. The same code renders correctly '
          'for both Arabic (RTL) and English (LTR) users.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Text(
          'Left-to-Right:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        dashboardLtr,
        SizedBox(height: 16.0),
        Text(
          'Right-to-Left:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.orange.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        dashboardRtl,
      ],
    ),
  );

  // ============================================================
  // Final Assembly
  // ============================================================
  print('=== Assembling final layout ===');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade800, Colors.orange.shade500],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PositionedDirectional',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Directionality-aware Positioned for Stack layouts. '
                'Uses start/end instead of left/right for automatic '
                'RTL support in internationalized applications.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.orange.shade100,
                ),
              ),
            ],
          ),
        ),
        section1,
        SizedBox(height: 8.0),
        section2,
        SizedBox(height: 8.0),
        section3,
        SizedBox(height: 8.0),
        section4,
        SizedBox(height: 8.0),
        section5,
        SizedBox(height: 8.0),
        section6,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildDirectionalStack(TextDirection direction) {
  final isLtr = direction == TextDirection.ltr;
  final label = isLtr ? 'LTR' : 'RTL';
  final labelColor = isLtr ? Colors.blue : Colors.orange;

  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: labelColor.shade100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isLtr ? Icons.format_textdirection_l_to_r : Icons.format_textdirection_r_to_l,
              size: 16.0,
              color: labelColor.shade700,
            ),
            SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: labelColor.shade800,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 140.0,
        decoration: BoxDecoration(
          color: labelColor.shade50,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
          border: Border.all(color: labelColor.shade200),
        ),
        child: Directionality(
          textDirection: direction,
          child: Stack(
            children: [
              // Start-positioned
              PositionedDirectional(
                start: 8.0,
                top: 8.0,
                child: Container(
                  width: 60.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),
              // End-positioned
              PositionedDirectional(
                end: 8.0,
                top: 8.0,
                child: Container(
                  width: 60.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'END',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ),
              // Bottom stretch
              PositionedDirectional(
                start: 8.0,
                end: 8.0,
                bottom: 8.0,
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'start + end = stretch',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildBadgeIcon(IconData icon, String count, MaterialColor color) {
  return SizedBox(
    width: 56.0,
    height: 56.0,
    child: Stack(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          margin: EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: color.shade700, size: 26.0),
        ),
        PositionedDirectional(
          end: 0.0,
          top: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: count.length > 2 ? 4.0 : 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverlayCard(String dirLabel) {
  return Container(
    height: 180.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          // Background — simulated image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.landscape,
              size: 64.0,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          // Direction label (absolute)
          Positioned(
            left: 8.0,
            top: 8.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                dirLabel,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Favorite button — end/top
          PositionedDirectional(
            end: 8.0,
            top: 8.0,
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite,
                size: 18.0,
                color: Colors.red.shade400,
              ),
            ),
          ),
          // Category label — start/bottom
          PositionedDirectional(
            start: 8.0,
            bottom: 40.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'Nature',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Title bar — start to end
          PositionedDirectional(
            start: 0.0,
            end: 0.0,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.black54,
              child: Text(
                'Mountain Sunrise',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPosLabel(String text, MaterialColor color, String dir) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.shade200,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade400),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        Text(
          dir,
          style: TextStyle(fontSize: 8.0, color: color.shade600),
        ),
      ],
    ),
  );
}

Widget _buildDashboardCard() {
  return Container(
    height: 160.0,
    decoration: BoxDecoration(
      color: Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Stack(
      children: [
        // Background pattern
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF283593)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        // Status indicator — top start
        PositionedDirectional(
          start: 12.0,
          top: 12.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
        // Settings icon — top end
        PositionedDirectional(
          end: 12.0,
          top: 10.0,
          child: Icon(Icons.settings, color: Colors.white38, size: 20.0),
        ),
        // Main content — center
        PositionedDirectional(
          start: 12.0,
          top: 40.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$12,847',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Total Revenue',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        // Trend indicator — end center
        PositionedDirectional(
          end: 12.0,
          top: 48.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, color: Colors.greenAccent, size: 14.0),
                SizedBox(width: 4.0),
                Text(
                  '+12.5%',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Bottom bar — start to end
        PositionedDirectional(
          start: 12.0,
          end: 12.0,
          bottom: 12.0,
          child: Container(
            height: 36.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.0,
                  color: Colors.white38,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
