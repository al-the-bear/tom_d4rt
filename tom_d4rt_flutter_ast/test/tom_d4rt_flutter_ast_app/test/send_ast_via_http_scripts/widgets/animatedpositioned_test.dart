// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep-demo script: AnimatedPositioned anatomy & parameter space
// Single-frame static rendering: every Stack shows the "target" position
// where the AnimatedPositioned would land after a rebuild. A ghost outline
// marks the conceptual "from" position to imply motion.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedPositioned Deep Demo executing');

  // Theme colours: rose / pink palette (layout-energy)
  final Color rose50 = Color(0xFFFFF1F2);
  final Color rose100 = Color(0xFFFFE4E6);
  final Color rose200 = Color(0xFFFECDD3);
  final Color rose300 = Color(0xFFFDA4AF);
  final Color rose400 = Color(0xFFFB7185);
  final Color rose500 = Color(0xFFF43F5E);
  final Color rose600 = Color(0xFFE11D48);
  final Color rose700 = Color(0xFFBE123C);
  final Color rose800 = Color(0xFF9F1239);
  final Color rose900 = Color(0xFF881337);
  final Color pink400 = Color(0xFFEC4899);
  final Color pink600 = Color(0xFFDB2777);
  final Color pink800 = Color(0xFF9D174D);
  final Color fuchsia400 = Color(0xFFE879F9);
  final Color fuchsia600 = Color(0xFFC026D3);
  final Color slate100 = Color(0xFFF1F5F9);
  final Color slate300 = Color(0xFFCBD5E1);
  final Color slate500 = Color(0xFF64748B);
  final Color slate700 = Color(0xFF334155);
  final Color slate900 = Color(0xFF0F172A);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [rose600, pink600, fuchsia600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: rose500.withValues(alpha: 0.45),
          blurRadius: 22.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: pink600.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Colors.white, size: 44.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'AnimatedPositioned',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Implicit animation between Stack-positioned target rects',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white.withValues(alpha: 0.92),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _pill('child of Stack', Colors.white),
            _pill('implicit', Colors.white),
            _pill('Tween-driven', Colors.white),
            _pill('left/top/right/bottom', Colors.white),
            _pill('width/height', Colors.white),
            _pill('curve + duration', Colors.white),
          ],
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final Widget anatomyStack = Container(
    height: 280.0,
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [rose50, rose100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: rose300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: rose300.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Stack viewport label
        Positioned(
          left: 8.0,
          top: 6.0,
          child: Text(
            'Stack viewport',
            style: TextStyle(
              fontSize: 11.0,
              color: rose700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        // FROM ghost outline (conceptual previous position)
        Positioned(
          left: 18.0,
          top: 30.0,
          width: 90.0,
          height: 60.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: rose400.withValues(alpha: 0.5),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                'FROM',
                style: TextStyle(
                  fontSize: 11.0,
                  color: rose400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Arrow icon
        Positioned(
          left: 130.0,
          top: 100.0,
          child: Icon(Icons.arrow_forward, color: rose700, size: 32.0),
        ),
        // TO target — animated positioned
        AnimatedPositioned(
          left: 180.0,
          top: 150.0,
          width: 130.0,
          height: 80.0,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rose500, pink600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: rose500.withValues(alpha: 0.5),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'TO',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Side legend
        Positioned(
          right: 8.0,
          top: 36.0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: rose300, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _legendDot('left/top', rose700),
                _legendDot('right/bottom', pink600),
                _legendDot('width/height', fuchsia600),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: Constructor parameter chips
  // ============================================================
  print('=== Section 3: Constructor parameters ===');

  final List<Map<String, dynamic>> ctorParams = [
    {'name': 'left', 'type': 'double?', 'desc': 'distance from Stack left'},
    {'name': 'top', 'type': 'double?', 'desc': 'distance from Stack top'},
    {'name': 'right', 'type': 'double?', 'desc': 'distance from Stack right'},
    {
      'name': 'bottom',
      'type': 'double?',
      'desc': 'distance from Stack bottom',
    },
    {'name': 'width', 'type': 'double?', 'desc': 'fixed child width'},
    {'name': 'height', 'type': 'double?', 'desc': 'fixed child height'},
    {
      'name': 'duration',
      'type': 'Duration',
      'desc': 'tween length (required)',
    },
    {'name': 'curve', 'type': 'Curve', 'desc': 'easing curve, default linear'},
    {'name': 'child', 'type': 'Widget', 'desc': 'positioned subtree'},
    {'name': 'onEnd', 'type': 'VoidCallback?', 'desc': 'fires on settle'},
  ];

  final List<Widget> chipWidgets = <Widget>[];
  for (final Map<String, dynamic> p in ctorParams) {
    chipWidgets.add(
      Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [rose100, rose200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: rose400, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: rose300.withValues(alpha: 0.45),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              p['name'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: rose800,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                p['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: rose700,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              p['desc'] as String,
              style: TextStyle(fontSize: 11.0, color: slate700),
            ),
          ],
        ),
      ),
    );
  }
  print('Constructor chips: ${chipWidgets.length}');

  // ============================================================
  // SECTION 4: Parameter combos
  // ============================================================
  print('=== Section 4: Parameter combos ===');

  final Widget comboLeftTop = _comboPanel(
    title: 'left + top',
    formula: 'left: 16, top: 16',
    color: rose500,
    bg1: rose50,
    bg2: rose100,
    border: rose300,
    body: Stack(
      children: [
        _ghostBox(left: 80.0, top: 70.0, width: 64.0, height: 48.0),
        AnimatedPositioned(
          left: 16.0,
          top: 16.0,
          width: 64.0,
          height: 48.0,
          duration: Duration(milliseconds: 300),
          child: _targetBlock(rose500, pink600, 'L+T'),
        ),
      ],
    ),
  );

  final Widget comboRightBottom = _comboPanel(
    title: 'right + bottom',
    formula: 'right: 16, bottom: 16',
    color: pink600,
    bg1: rose100,
    bg2: rose200,
    border: rose400,
    body: Stack(
      children: [
        _ghostBox(left: 24.0, top: 24.0, width: 64.0, height: 48.0),
        AnimatedPositioned(
          right: 16.0,
          bottom: 16.0,
          width: 64.0,
          height: 48.0,
          duration: Duration(milliseconds: 300),
          child: _targetBlock(pink600, rose700, 'R+B'),
        ),
      ],
    ),
  );

  final Widget comboLeftRight = _comboPanel(
    title: 'left + right (stretch)',
    formula: 'left: 8, right: 8, top: 60',
    color: fuchsia600,
    bg1: rose50,
    bg2: rose100,
    border: rose300,
    body: Stack(
      children: [
        _ghostBox(left: 30.0, top: 20.0, width: 60.0, height: 40.0),
        AnimatedPositioned(
          left: 8.0,
          right: 8.0,
          top: 60.0,
          height: 36.0,
          duration: Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [fuchsia600, pink600],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                'STRETCH',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget comboTopBottom = _comboPanel(
    title: 'top + bottom (vertical stretch)',
    formula: 'top: 8, bottom: 8, left: 60',
    color: rose700,
    bg1: rose100,
    bg2: rose200,
    border: rose400,
    body: Stack(
      children: [
        _ghostBox(left: 18.0, top: 18.0, width: 40.0, height: 50.0),
        AnimatedPositioned(
          top: 8.0,
          bottom: 8.0,
          left: 60.0,
          width: 36.0,
          duration: Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rose700, rose500],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'STRETCH',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget comboFullSix = _comboPanel(
    title: 'full 6-arg (over-constrained — error)',
    formula: 'all six set: invalid',
    color: rose800,
    bg1: rose50,
    bg2: rose100,
    border: rose300,
    body: Stack(
      children: [
        _ghostBox(left: 14.0, top: 14.0, width: 60.0, height: 60.0),
        AnimatedPositioned(
          left: 12.0,
          top: 30.0,
          width: 70.0,
          height: 50.0,
          duration: Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rose800, pink800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.yellow, width: 2.0),
            ),
            child: Center(
              child: Icon(Icons.warning_amber, color: Colors.white, size: 22.0),
            ),
          ),
        ),
        Positioned(
          right: 6.0,
          bottom: 6.0,
          child: Text(
            'use ≤2 per axis',
            style: TextStyle(
              fontSize: 10.0,
              color: rose800,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Combo panels: 5');

  // ============================================================
  // SECTION 5: Duration variants
  // ============================================================
  print('=== Section 5: Duration variants ===');

  final List<Map<String, dynamic>> durations = [
    {'ms': 100, 'label': '100ms — snap', 'left': 12.0, 'top': 12.0},
    {'ms': 300, 'label': '300ms — UI default', 'left': 60.0, 'top': 30.0},
    {'ms': 800, 'label': '800ms — soft', 'left': 110.0, 'top': 60.0},
    {'ms': 2000, 'label': '2000ms — slow', 'left': 150.0, 'top': 90.0},
  ];

  final List<Widget> durationStacks = <Widget>[];
  for (final Map<String, dynamic> d in durations) {
    final int ms = d['ms'] as int;
    final double tx = d['left'] as double;
    final double ty = d['top'] as double;
    durationStacks.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [rose50, rose100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: rose300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: rose300.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timer, size: 16.0, color: rose700),
                SizedBox(width: 4.0),
                Text(
                  d['label'] as String,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: rose800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: rose200, width: 1.0),
              ),
              child: Stack(
                children: [
                  _ghostBox(left: 8.0, top: 8.0, width: 48.0, height: 36.0),
                  AnimatedPositioned(
                    left: tx,
                    top: ty,
                    width: 48.0,
                    height: 36.0,
                    duration: Duration(milliseconds: ms),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [rose500, pink600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          '${ms}ms',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Duration stacks: ${durationStacks.length}');

  // ============================================================
  // SECTION 6: Curve variants
  // ============================================================
  print('=== Section 6: Curve variants ===');

  final List<Map<String, dynamic>> curves = [
    {'curve': Curves.linear, 'label': 'linear', 'color': rose400},
    {'curve': Curves.easeIn, 'label': 'easeIn', 'color': rose500},
    {'curve': Curves.easeOut, 'label': 'easeOut', 'color': rose600},
    {'curve': Curves.easeInOut, 'label': 'easeInOut', 'color': pink600},
    {'curve': Curves.bounceOut, 'label': 'bounceOut', 'color': fuchsia600},
    {'curve': Curves.elasticOut, 'label': 'elasticOut', 'color': pink800},
  ];

  final List<Widget> curveStacks = <Widget>[];
  for (final Map<String, dynamic> c in curves) {
    final Curve curve = c['curve'] as Curve;
    final Color cc = c['color'] as Color;
    curveStacks.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cc.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: cc.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: cc.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                c['label'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: cc,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: rose50,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Stack(
                children: [
                  _ghostBox(left: 8.0, top: 24.0, width: 40.0, height: 30.0),
                  AnimatedPositioned(
                    left: 110.0,
                    top: 24.0,
                    width: 40.0,
                    height: 30.0,
                    duration: Duration(milliseconds: 600),
                    curve: curve,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cc,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Curve stacks: ${curveStacks.length}');

  // ============================================================
  // SECTION 7: .fromRect() factory
  // ============================================================
  print('=== Section 7: .fromRect() factory ===');

  final Widget fromRectA = Container(
    width: 240.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [rose50, pink400.withValues(alpha: 0.15)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: rose400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: rose300.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AnimatedPositioned.fromRect',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: rose800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'rect: Rect.fromLTWH(20, 20, 80, 60)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: slate700,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 130.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              _ghostBox(left: 100.0, top: 60.0, width: 60.0, height: 40.0),
              AnimatedPositioned.fromRect(
                rect: Rect.fromLTWH(20.0, 20.0, 80.0, 60.0),
                duration: Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [rose500, pink600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      'Rect',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget fromRectB = Container(
    width: 240.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [rose50, fuchsia400.withValues(alpha: 0.15)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: fuchsia400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: fuchsia400.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AnimatedPositioned.fromRect',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: pink800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'rect: Rect.fromLTRB(120, 60, 200, 110)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: slate700,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 130.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              _ghostBox(left: 18.0, top: 18.0, width: 50.0, height: 36.0),
              AnimatedPositioned.fromRect(
                rect: Rect.fromLTRB(120.0, 60.0, 200.0, 110.0),
                duration: Duration(milliseconds: 700),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fuchsia600, pink600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      'LTRB',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('fromRect panels: 2');

  // ============================================================
  // SECTION 8: Real-world mocks
  // ============================================================
  print('=== Section 8: Real-world mocks ===');

  // Mock 8a: tile reveal animation
  final Widget mockTile = _mockPanel(
    title: 'Tile reveal',
    desc: 'card slides in from offscreen-right when item appears',
    color: rose500,
    body: Stack(
      children: [
        Positioned(
          left: 8.0,
          top: 8.0,
          right: 8.0,
          height: 28.0,
          child: Container(
            decoration: BoxDecoration(
              color: rose100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'List header',
                style: TextStyle(fontSize: 11.0, color: rose800),
              ),
            ),
          ),
        ),
        _ghostBox(left: 220.0, top: 50.0, width: 180.0, height: 40.0),
        AnimatedPositioned(
          left: 8.0,
          top: 50.0,
          right: 8.0,
          height: 40.0,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rose400, pink600],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  color: rose500.withValues(alpha: 0.4),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Revealed tile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Mock 8b: drawer toggle
  final Widget mockDrawer = _mockPanel(
    title: 'Drawer toggle',
    desc: 'side drawer animates from left: -180 to left: 0',
    color: pink600,
    body: Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: rose50.withValues(alpha: 0.5),
          ),
        ),
        _ghostBox(left: -180.0, top: 0.0, width: 180.0, height: 110.0),
        AnimatedPositioned(
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
          width: 180.0,
          duration: Duration(milliseconds: 280),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rose600, pink800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: rose700.withValues(alpha: 0.5),
                  blurRadius: 8.0,
                  offset: Offset(2.0, 0.0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu, color: Colors.white, size: 20.0),
                  SizedBox(height: 8.0),
                  Text(
                    'Drawer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'menu',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Mock 8c: FAB transition
  final Widget mockFab = _mockPanel(
    title: 'FAB transition',
    desc: 'bottom-right anchor; size grows on action',
    color: fuchsia600,
    body: Stack(
      children: [
        _ghostBox(right: 16.0, bottom: 16.0, width: 48.0, height: 48.0),
        AnimatedPositioned(
          right: 16.0,
          bottom: 16.0,
          width: 80.0,
          height: 80.0,
          duration: Duration(milliseconds: 320),
          curve: Curves.elasticOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [fuchsia400, pink600, rose700],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: fuchsia600.withValues(alpha: 0.5),
                  blurRadius: 12.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Icon(Icons.add, color: Colors.white, size: 36.0),
          ),
        ),
      ],
    ),
  );

  // Mock 8d: menu slide-in
  final Widget mockMenu = _mockPanel(
    title: 'Menu slide-in',
    desc: 'top: -120 → top: 0 reveals dropdown',
    color: rose700,
    body: Stack(
      children: [
        _ghostBox(left: 30.0, top: -120.0, width: 220.0, height: 80.0),
        AnimatedPositioned(
          left: 30.0,
          top: 0.0,
          width: 220.0,
          height: 80.0,
          duration: Duration(milliseconds: 280),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border.all(color: rose400, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: rose400.withValues(alpha: 0.4),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Column(
              children: [
                _menuRow('Option A', Icons.tune, rose700),
                _menuRow('Option B', Icons.star_outline, rose700),
                _menuRow('Option C', Icons.delete_outline, rose700),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Real-world mocks: 4');

  // ============================================================
  // SECTION 9: Comparison vs sibling widgets
  // ============================================================
  print('=== Section 9: Comparison ===');

  final List<Map<String, dynamic>> comparisons = [
    {
      'name': 'Positioned',
      'desc': 'static placement; no animation, snaps instantly',
      'icon': Icons.push_pin_outlined,
      'color': slate500,
    },
    {
      'name': 'AnimatedPositioned',
      'desc': 'implicit animation between LTRB/WH changes',
      'icon': Icons.swap_horiz,
      'color': rose600,
    },
    {
      'name': 'AnimatedPositionedDirectional',
      'desc': 'RTL-aware: uses start/end instead of left/right',
      'icon': Icons.format_textdirection_l_to_r,
      'color': pink600,
    },
    {
      'name': 'AnimatedAlign',
      'desc': 'animates Align.alignment; fits any parent, not Stack-only',
      'icon': Icons.center_focus_strong,
      'color': fuchsia600,
    },
    {
      'name': 'Hero',
      'desc': 'cross-route shared element; not a Stack interpolation',
      'icon': Icons.flight_takeoff,
      'color': rose800,
    },
  ];

  final List<Widget> compareCards = <Widget>[];
  for (final Map<String, dynamic> cmp in comparisons) {
    final Color cc = cmp['color'] as Color;
    compareCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cc.withValues(alpha: 0.08),
              cc.withValues(alpha: 0.16),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cc.withValues(alpha: 0.6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: cc.withValues(alpha: 0.2),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: cc.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(cmp['icon'] as IconData, color: cc, size: 24.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cmp['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: cc,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    cmp['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: slate700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Comparison cards: ${compareCards.length}');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final List<Map<String, dynamic>> footguns = [
    {
      'icon': Icons.warning_amber,
      'title': 'Must be inside a Stack',
      'body':
          'AnimatedPositioned outside a Stack throws "ParentDataWidget incorrect ancestor".',
    },
    {
      'icon': Icons.refresh,
      'title': 'Parent rebuild required',
      'body':
          'Implicit animations only fire when the widget is rebuilt with new params. setState in an ancestor is required.',
    },
    {
      'icon': Icons.swap_calls,
      'title': 'left → right swap re-jumps',
      'body':
          'Swapping which side is null (left vs right) cannot tween; the layout snaps to the new constraint.',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'onEnd fires on every settle',
      'body':
          'onEnd is called once per completed tween — also when the widget settles with no visible change.',
    },
    {
      'icon': Icons.straighten,
      'title': 'Avoid over-constraining',
      'body':
          'Setting all of left+right+width (or top+bottom+height) is illegal: only two of the three on each axis.',
    },
    {
      'icon': Icons.timer_off,
      'title': 'Zero duration is a snap',
      'body':
          'Duration.zero is allowed but defeats the purpose — it snaps without interpolation.',
    },
  ];

  final List<Widget> footgunCards = <Widget>[];
  for (final Map<String, dynamic> fg in footguns) {
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade50, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.orange.shade300, width: 1.3),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade200.withValues(alpha: 0.45),
              blurRadius: 5.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              fg['icon'] as IconData,
              color: Colors.orange.shade800,
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['body'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: slate700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Footgun cards: ${footgunCards.length}');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap card ===');

  final Widget recapCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [rose700, pink800, slate900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: rose700.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: slate900.withValues(alpha: 0.3),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapRow(
          '1.',
          'AnimatedPositioned animates Stack-position changes implicitly.',
        ),
        _recapRow(
          '2.',
          'It MUST be a child of Stack — uses StackParentData.',
        ),
        _recapRow(
          '3.',
          'Set at most two of left/right/width per axis; same for vertical.',
        ),
        _recapRow(
          '4.',
          'duration is required; curve defaults to Curves.linear.',
        ),
        _recapRow(
          '5.',
          'Rebuild with new params to retrigger; setState higher up.',
        ),
        _recapRow(
          '6.',
          '.fromRect(rect:) is sugar for left/top/width/height.',
        ),
        _recapRow(
          '7.',
          'onEnd fires once per settle — even on no-op tweens.',
        ),
        _recapRow(
          '8.',
          'Use AnimatedPositionedDirectional for RTL-aware layouts.',
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'declarative target → tween-driven actual',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Recap card created');

  print('AnimatedPositioned Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: rose50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy', Icons.crop_free, rose700),
          SizedBox(height: 8.0),
          anatomyStack,
          SizedBox(height: 12.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [slate100, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: slate300, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: slate300.withValues(alpha: 0.4),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How it works',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: rose900,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'On rebuild with new params, the rect tweens FROM → TO over '
                  '"duration" using "curve". The Stack viewport defines the '
                  'coordinate frame.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: slate700,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 28.0),
          _sectionHeader('2. Constructor parameters', Icons.tune, rose700),
          SizedBox(height: 8.0),
          Wrap(children: chipWidgets),
          SizedBox(height: 28.0),
          _sectionHeader(
            '3. Parameter combos',
            Icons.dashboard_customize,
            rose700,
          ),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              comboLeftTop,
              comboRightBottom,
              comboLeftRight,
              comboTopBottom,
              comboFullSix,
            ],
          ),
          SizedBox(height: 28.0),
          _sectionHeader('4. Duration variants', Icons.timer, rose700),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: durationStacks),
          SizedBox(height: 28.0),
          _sectionHeader(
            '5. Curve variants',
            Icons.show_chart,
            rose700,
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: curveStacks),
          SizedBox(height: 28.0),
          _sectionHeader(
            '6. .fromRect() factory',
            Icons.crop_square,
            rose700,
          ),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: [fromRectA, fromRectB],
          ),
          SizedBox(height: 28.0),
          _sectionHeader('7. Real-world mocks', Icons.apps, rose700),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: [mockTile, mockDrawer, mockFab, mockMenu],
          ),
          SizedBox(height: 28.0),
          _sectionHeader(
            '8. Comparison vs siblings',
            Icons.compare_arrows,
            rose700,
          ),
          SizedBox(height: 8.0),
          Column(children: compareCards),
          SizedBox(height: 28.0),
          _sectionHeader(
            '9. Footguns & gotchas',
            Icons.warning_amber,
            rose700,
          ),
          SizedBox(height: 8.0),
          Column(children: footgunCards),
          SizedBox(height: 28.0),
          _sectionHeader('10. Recap', Icons.summarize, rose700),
          SizedBox(height: 8.0),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _pill(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _legendDot(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _ghostBox({
  double? left,
  double? top,
  double? right,
  double? bottom,
  required double width,
  required double height,
}) {
  return Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Color(0xFFFDA4AF).withValues(alpha: 0.55),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: Text(
          'ghost',
          style: TextStyle(
            fontSize: 9.0,
            color: Color(0xFFBE123C).withValues(alpha: 0.65),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ),
  );
}

Widget _targetBlock(Color a, Color b, String label) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [a, b],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: a.withValues(alpha: 0.45),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _comboPanel({
  required String title,
  required String formula,
  required Color color,
  required Color bg1,
  required Color bg2,
  required Color border,
  required Widget body,
}) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bg1, bg2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            formula,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 130.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: body,
        ),
      ],
    ),
  );
}

Widget _mockPanel({
  required String title,
  required String desc,
  required Color color,
  required Widget body,
}) {
  return Container(
    width: 280.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.20),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 7.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.smart_display, color: color, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          desc,
          style: TextStyle(
            fontSize: 10.5,
            color: Color(0xFF334155),
            height: 1.3,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 140.0,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: body,
        ),
      ],
    ),
  );
}

Widget _menuRow(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    child: Row(
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(fontSize: 11.0, color: color),
        ),
      ],
    ),
  );
}

Widget _sectionHeader(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _recapRow(String num, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            num,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white.withValues(alpha: 0.95),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
