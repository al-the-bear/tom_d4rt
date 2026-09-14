// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last
// D4rt test script: Tests MultiTapGestureRecognizer from package:flutter/gestures.dart
// Deep Demo: Visual demonstration of MultiTapGestureRecognizer's per-pointer
// tap callbacks (onTapDown, onTapUp, onTap, onTapCancel, onLongTapDown) and
// how it differs from a single TapGestureRecognizer.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // PROBE: Construct a real MultiTapGestureRecognizer to demonstrate
  // its API surface. We wire up every callback exactly once and rely
  // on AlwaysStoppedAnimation for any animated value (no real motion).
  // ============================================================
  final recognizer = MultiTapGestureRecognizer(
    longTapDelay: Duration.zero,
  );
  recognizer.onTapDown = (int pointer, TapDownDetails details) {};
  recognizer.onTapUp = (int pointer, TapUpDetails details) {};
  recognizer.onTap = (int pointer) {};
  recognizer.onTapCancel = (int pointer) {};
  recognizer.onLongTapDown = (int pointer, TapDownDetails details) {};
  recognizer.dispose();

  // Static animation used as opacity / scale source where we want a
  // value-shaped expression without any actual motion.
  final AlwaysStoppedAnimation<double> staticHalf =
      AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> staticFull =
      AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> staticZero =
      AlwaysStoppedAnimation<double>(0.0);

  // ============================================================
  // SECTION 1: HERO HEADER
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF512DA8),
          Color(0xFFAD1457),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.4),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
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
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white24, Colors.white10],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.touch_app,
                size: 56.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MultiTapGestureRecognizer',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
              width: 1.0,
            ),
          ),
          child: Text(
            'Recognizes simultaneous taps from many pointers and reports '
            'each one independently. Unlike TapGestureRecognizer, every '
            'callback is keyed by an int pointer ID so multi-finger UIs '
            'can distinguish which finger went down, up, or got cancelled.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildHeroChip('Per-pointer callbacks', Icons.fingerprint),
            _buildHeroChip('5 callback hooks', Icons.bolt),
            _buildHeroChip('Long-press aware', Icons.timer),
            _buildHeroChip('Multi-finger', Icons.pan_tool),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY OF THE MULTI-TAP ARENA
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1976D2), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1976D2).withValues(alpha: 0.20),
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
            Icon(Icons.architecture,
                color: Color(0xFF0D47A1), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Anatomy of the Multi-Tap Arena',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Each new pointer that touches the recognizer creates an internal '
          '_TapTracker keyed by pointer ID. Trackers run in parallel, so a '
          'callback firing for pointer 7 says nothing about pointer 9.',
          style: TextStyle(fontSize: 13.0, color: Color(0xFF1A237E)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF90CAF9), width: 1.0),
          ),
          child: Column(
            children: [
              _buildAnatomyRow(
                Icons.add_circle,
                'pointer down',
                'Recognizer creates _TapTracker(pointer)',
                Color(0xFF2E7D32),
              ),
              _buildAnatomyRow(
                Icons.gps_fixed,
                'arena resolution',
                'Tracker accepts when no rejection arrives',
                Color(0xFF1565C0),
              ),
              _buildAnatomyRow(
                Icons.timer_outlined,
                'longTapDelay timer',
                'Optional onLongTapDown after delay',
                Color(0xFFEF6C00),
              ),
              _buildAnatomyRow(
                Icons.touch_app,
                'pointer up',
                'onTapUp(pointer, details) then onTap(pointer)',
                Color(0xFF6A1B9A),
              ),
              _buildAnatomyRow(
                Icons.cancel,
                'rejection / leave',
                'onTapCancel(pointer) and tracker disposed',
                Color(0xFFC62828),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PER-CALLBACK CARDS
  // Each callback gets a card with: icon, signature, fire-when-rule,
  // arguments, and a per-pointer matrix.
  // ============================================================
  final List<Map<String, Object>> callbackData = [
    {
      'name': 'onTapDown',
      'signature': 'void Function(int pointer, TapDownDetails details)',
      'fires': 'A new pointer makes contact and the gesture is accepted.',
      'icon': Icons.arrow_downward,
      'color': Color(0xFF2E7D32),
      'gradient': [Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
      'globalPos': 'details.globalPosition',
      'kind': 'details.kind == PointerDeviceKind.touch',
    },
    {
      'name': 'onTapUp',
      'signature': 'void Function(int pointer, TapUpDetails details)',
      'fires': 'The same pointer lifts off without being cancelled.',
      'icon': Icons.arrow_upward,
      'color': Color(0xFF1565C0),
      'gradient': [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
      'globalPos': 'details.globalPosition',
      'kind': 'details.kind',
    },
    {
      'name': 'onTap',
      'signature': 'void Function(int pointer)',
      'fires': 'Right after onTapUp; means a complete tap was confirmed.',
      'icon': Icons.check_circle,
      'color': Color(0xFF6A1B9A),
      'gradient': [Color(0xFFE1BEE7), Color(0xFFCE93D8)],
      'globalPos': 'n/a',
      'kind': 'n/a',
    },
    {
      'name': 'onTapCancel',
      'signature': 'void Function(int pointer)',
      'fires': 'Pointer leaves the slop, is rejected, or another wins arena.',
      'icon': Icons.cancel,
      'color': Color(0xFFC62828),
      'gradient': [Color(0xFFFFCDD2), Color(0xFFEF9A9A)],
      'globalPos': 'n/a',
      'kind': 'n/a',
    },
    {
      'name': 'onLongTapDown',
      'signature': 'void Function(int pointer, TapDownDetails details)',
      'fires': 'longTapDelay elapses while the pointer is still down.',
      'icon': Icons.access_time_filled,
      'color': Color(0xFFEF6C00),
      'gradient': [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
      'globalPos': 'details.globalPosition',
      'kind': 'details.kind',
    },
  ];

  final List<Widget> callbackCards = <Widget>[];
  for (final Map<String, Object> data in callbackData) {
    final String name = data['name'] as String;
    final String signature = data['signature'] as String;
    final String fires = data['fires'] as String;
    final IconData icon = data['icon'] as IconData;
    final Color color = data['color'] as Color;
    final List<Color> gradient = data['gradient'] as List<Color>;
    final String globalPos = data['globalPos'] as String;
    final String kind = data['kind'] as String;

    callbackCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 14.0,
              offset: Offset(0.0, 6.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 26.0),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          signature,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'callback',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.flash_on,
                          color: color, size: 18.0),
                      SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          'Fires when: $fires',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: [
                      _buildArgChip('pointer: int', color),
                      if (globalPos != 'n/a')
                        _buildArgChip(globalPos, color),
                      if (kind != 'n/a') _buildArgChip(kind, color),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  // Per-pointer matrix
                  _buildPerPointerMatrix(name, color),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: MULTI-FINGER SCENARIOS (timeline strips)
  // ============================================================
  final Widget multiFingerSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE65100), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFE65100).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.pan_tool,
                color: Color(0xFFBF360C), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Multi-Finger Scenarios',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildScenarioStrip(
          'Two-finger tap',
          [
            _Step('p7 down', 'onTapDown(7)', Color(0xFF2E7D32)),
            _Step('p9 down', 'onTapDown(9)', Color(0xFF2E7D32)),
            _Step('p7 up', 'onTapUp(7)/onTap(7)', Color(0xFF6A1B9A)),
            _Step('p9 up', 'onTapUp(9)/onTap(9)', Color(0xFF6A1B9A)),
          ],
        ),
        SizedBox(height: 12.0),
        _buildScenarioStrip(
          'Three-finger drum tap',
          [
            _Step('p1 down', 'onTapDown(1)', Color(0xFF2E7D32)),
            _Step('p2 down', 'onTapDown(2)', Color(0xFF2E7D32)),
            _Step('p3 down', 'onTapDown(3)', Color(0xFF2E7D32)),
            _Step('all up', '3x onTap()', Color(0xFF6A1B9A)),
          ],
        ),
        SizedBox(height: 12.0),
        _buildScenarioStrip(
          'One drags away',
          [
            _Step('p4 down', 'onTapDown(4)', Color(0xFF2E7D32)),
            _Step('p5 down', 'onTapDown(5)', Color(0xFF2E7D32)),
            _Step('p4 leaves', 'onTapCancel(4)', Color(0xFFC62828)),
            _Step('p5 up', 'onTap(5)', Color(0xFF6A1B9A)),
          ],
        ),
        SizedBox(height: 12.0),
        _buildScenarioStrip(
          'One holds → long tap',
          [
            _Step('p2 down', 'onTapDown(2)', Color(0xFF2E7D32)),
            _Step('delay', 'onLongTapDown(2)', Color(0xFFEF6C00)),
            _Step('p2 up', 'onTap(2)', Color(0xFF6A1B9A)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: RECIPES
  // ============================================================
  final Widget recipeSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF2E7D32).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restaurant_menu,
                color: Color(0xFF1B5E20), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeBlock(
          'Multi-finger piano keys',
          'final r = MultiTapGestureRecognizer();\n'
              'r.onTapDown = (p, d) => playKeyAt(d.globalPosition);\n'
              'r.onTapCancel = (p) => stopKeyForPointer(p);\n'
              'r.onTapUp = (p, d) => releaseKeyForPointer(p);',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          'Long-tap context menu',
          'final r = MultiTapGestureRecognizer(\n'
              '  longTapDelay: const Duration(milliseconds: 500),\n'
              ');\n'
              'r.onLongTapDown = (p, d) => showMenuAt(d.globalPosition);\n'
              'r.onTap = (p) => activate(p);',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          'Per-pointer ripple cleanup',
          'final ripples = <int, RippleHandle>{};\n'
              'r.onTapDown = (p, d) => ripples[p] = startRipple(d);\n'
              'r.onTapUp = (p, d) => ripples.remove(p)?.complete();\n'
              'r.onTapCancel = (p) => ripples.remove(p)?.cancel();',
          Color(0xFF6A1B9A),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: PITFALLS
  // ============================================================
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      'Forgetting to track per-pointer state',
      'Storing one ripple in a single field will overwrite others. '
          'Use a Map<int, T> keyed by pointer.',
    ),
    _Pitfall(
      'Treating onTap like onTapUp',
      'onTap fires *after* onTapUp and carries no details. If you need '
          'the position, use onTapUp.',
    ),
    _Pitfall(
      'Setting longTapDelay = Duration.zero (default)',
      'onLongTapDown fires immediately after onTapDown. Pick a real delay '
          '(e.g. 500 ms) for press-and-hold UX.',
    ),
    _Pitfall(
      'Not calling dispose()',
      'MultiTapGestureRecognizer extends GestureRecognizer; failing to '
          'dispose leaks the active _TapTracker map.',
    ),
    _Pitfall(
      'Assuming a global "did the user tap?" event',
      'There is none. Each pointer has its own onTap(pointer). Aggregate '
          'yourself if you need a single "all fingers up" signal.',
    ),
  ];

  final Widget pitfallSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFB71C1C), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB71C1C).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFB71C1C), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final _Pitfall p in pitfalls)
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFEF9A9A),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline,
                    color: Color(0xFFC62828), size: 20.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.title,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        p.body,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87,
                          height: 1.4,
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

  // ============================================================
  // SECTION 7: COMPARISON WITH TapGestureRecognizer
  // ============================================================
  final Widget comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF4527A0), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4527A0).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows,
                color: Color(0xFF311B92), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'MultiTap vs Tap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
          ),
          child: Column(
            children: [
              _buildCompareHeader(),
              _buildCompareRow(
                'Pointers',
                'Many simultaneously',
                'One at a time',
              ),
              _buildCompareRow(
                'onTap',
                'onTap(int pointer)',
                'onTap()',
              ),
              _buildCompareRow(
                'onTapDown',
                'onTapDown(int p, TapDownDetails d)',
                'onTapDown(TapDownDetails d)',
              ),
              _buildCompareRow(
                'onTapUp',
                'onTapUp(int p, TapUpDetails d)',
                'onTapUp(TapUpDetails d)',
              ),
              _buildCompareRow(
                'onTapCancel',
                'onTapCancel(int p)',
                'onTapCancel()',
              ),
              _buildCompareRow(
                'Long press',
                'onLongTapDown built-in',
                'Use LongPressGestureRecognizer',
              ),
              _buildCompareRow(
                'Use case',
                'Piano keys, multi-touch toys',
                'Buttons, list items',
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: LIFECYCLE DIAGRAM
  // ============================================================
  final Widget lifecycleDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF006064), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF006064).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline,
                color: Color(0xFF006064), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Per-Pointer Lifecycle',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildLifecycleNode(
          'POINTER DOWN',
          'Tracker created for pointer P',
          Color(0xFF00838F),
          Icons.arrow_downward,
        ),
        _buildLifecycleArrow('onTapDown(P, details)', Color(0xFF2E7D32)),
        _buildLifecycleNode(
          'TRACKING',
          'Recognizer joins arena for P',
          Color(0xFF00ACC1),
          Icons.gps_fixed,
        ),
        _buildLifecycleArrow(
            'longTapDelay → onLongTapDown(P, d)?', Color(0xFFEF6C00)),
        _buildLifecycleNode(
          'ARENA WON',
          'Tracker has been accepted',
          Color(0xFF26C6DA),
          Icons.emoji_events,
        ),
        _buildLifecycleArrow(
            'pointer up → onTapUp(P, d) → onTap(P)',
            Color(0xFF6A1B9A)),
        _buildLifecycleNode(
          'COMPLETED',
          'Tracker disposed for P',
          Color(0xFF26A69A),
          Icons.check_circle,
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFCDD2),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFC62828), width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.alt_route,
                  color: Color(0xFFC62828), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Cancel branch: rejection / leave / dispose → '
                  'onTapCancel(P) and tracker is removed.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: QUICK REFERENCE TABLE
  // ============================================================
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFFDE7), Color(0xFFFFF59D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFF57F17), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFF57F17).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book,
                color: Color(0xFFE65100), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFFFCC80), width: 1.0),
          ),
          child: Column(
            children: [
              _buildRefHeader(),
              _buildRefRow('onTapDown', 'pointer + TapDownDetails',
                  'tap arena accepted'),
              _buildRefRow('onTapUp', 'pointer + TapUpDetails',
                  'pointer lifted normally'),
              _buildRefRow('onTap', 'pointer', 'paired with onTapUp'),
              _buildRefRow('onTapCancel', 'pointer',
                  'rejected / left / disposed'),
              _buildRefRow('onLongTapDown', 'pointer + TapDownDetails',
                  'after longTapDelay'),
              _buildRefRow(
                'longTapDelay',
                'Duration field',
                'controls onLongTapDown timing',
              ),
              _buildRefRow(
                'dispose()',
                'void',
                'frees all _TapTracker entries',
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: ASCII FOOTER
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.only(top: 16.0, bottom: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal,
                color: Color(0xFF80CBC4), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'multi_tap.txt',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                color: Color(0xFF80CBC4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          '  pointer 7   pointer 9   pointer 12\n'
          '     |           |            |\n'
          '   [DOWN]      [DOWN]       [DOWN]      <- onTapDown(p,d)\n'
          '     |           |            |\n'
          '     |           |        [LONG]        <- onLongTapDown(p,d)\n'
          '     |           |            |\n'
          '   [UP]         [X]          [UP]       <- onTapUp / onTapCancel\n'
          '     |           |            |\n'
          '   [TAP]                    [TAP]       <- onTap(p)\n'
          '\n'
          '  legend:\n'
          '    [DOWN]  -> recognizer.onTapDown(pointer, details)\n'
          '    [LONG]  -> recognizer.onLongTapDown(pointer, details)\n'
          '    [UP]    -> recognizer.onTapUp(pointer, details)\n'
          '    [TAP]   -> recognizer.onTap(pointer)\n'
          '    [X]     -> recognizer.onTapCancel(pointer)\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Color(0xFFCFD8DC),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 16.0),
            _buildSectionTitle(
              '1. Anatomy',
              Icons.architecture,
              Color(0xFF0D47A1),
            ),
            anatomy,
            _buildSectionTitle(
              '2. The Five Callbacks',
              Icons.api,
              Color(0xFF6A1B9A),
            ),
            ...callbackCards,
            _buildSectionTitle(
              '3. Multi-Finger Scenarios',
              Icons.pan_tool,
              Color(0xFFE65100),
            ),
            multiFingerSection,
            _buildSectionTitle(
              '4. Recipes',
              Icons.restaurant_menu,
              Color(0xFF1B5E20),
            ),
            recipeSection,
            _buildSectionTitle(
              '5. Pitfalls',
              Icons.warning_amber_rounded,
              Color(0xFFB71C1C),
            ),
            pitfallSection,
            _buildSectionTitle(
              '6. Comparison',
              Icons.compare_arrows,
              Color(0xFF311B92),
            ),
            comparison,
            _buildSectionTitle(
              '7. Lifecycle',
              Icons.timeline,
              Color(0xFF006064),
            ),
            lifecycleDiagram,
            _buildSectionTitle(
              '8. Quick Reference',
              Icons.menu_book,
              Color(0xFFE65100),
            ),
            quickReference,
            _buildSectionTitle(
              '9. ASCII Footer',
              Icons.terminal,
              Color(0xFF263238),
            ),
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPER: Section title bar
// ============================================================
Widget _buildSectionTitle(String label, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 22.0, bottom: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.85),
          color.withValues(alpha: 0.55),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Hero chip
// ============================================================
Widget _buildHeroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.40),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Argument chip used inside callback cards
// ============================================================
Widget _buildArgChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: color.withValues(alpha: 0.40),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================
// HELPER: Anatomy row
// ============================================================
Widget _buildAnatomyRow(
  IconData icon,
  String name,
  String description,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color, width: 1.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Per-pointer matrix shown inside each callback card.
// ============================================================
Widget _buildPerPointerMatrix(String name, Color color) {
  // Three illustrative pointer IDs; matrix shows whether the callback
  // would fire for that pointer in three sample situations.
  final List<int> pointers = <int>[7, 9, 12];
  final List<String> situations = <String>[
    'tap down',
    'tap up',
    'cancelled',
    'long held',
  ];
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: 0.30),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Per-pointer fire matrix',
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                'situation',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            for (final int p in pointers)
              Expanded(
                child: Center(
                  child: Text(
                    'p$p',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4.0),
        for (final String s in situations)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80.0,
                  child: Text(
                    s,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                for (final int p in pointers)
                  Expanded(
                    child: Center(
                      child: _buildFireDot(name, s, color),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Fire dot — green if callback fires for the situation,
// grey otherwise. Pure rule table, no animation.
// ============================================================
Widget _buildFireDot(String name, String situation, Color color) {
  bool fires;
  switch (name) {
    case 'onTapDown':
      fires = situation == 'tap down' || situation == 'long held';
      break;
    case 'onTapUp':
      fires = situation == 'tap up';
      break;
    case 'onTap':
      fires = situation == 'tap up';
      break;
    case 'onTapCancel':
      fires = situation == 'cancelled';
      break;
    case 'onLongTapDown':
      fires = situation == 'long held';
      break;
    default:
      fires = false;
  }
  final Color dotColor = fires ? color : Colors.grey.shade300;
  return Container(
    width: 14.0,
    height: 14.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: dotColor,
      boxShadow: fires
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.40),
                blurRadius: 6.0,
                offset: Offset(0.0, 1.0),
              ),
            ]
          : <BoxShadow>[],
    ),
  );
}

// ============================================================
// HELPER: A scenario timeline strip
// ============================================================
class _Step {
  const _Step(this.label, this.fires, this.color);
  final String label;
  final String fires;
  final Color color;
}

Widget _buildScenarioStrip(String title, List<_Step> steps) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFB74D).withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFBF360C),
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              Expanded(child: _buildStepBox(steps[i])),
              if (i != steps.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 14.0,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ],
        ),
      ],
    ),
  );
}

Widget _buildStepBox(_Step step) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: step.color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: step.color.withValues(alpha: 0.40),
        width: 1.0,
      ),
    ),
    child: Column(
      children: [
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: step.color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          step.fires,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Recipe block
// ============================================================
Widget _buildRecipeBlock(String title, String code, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.50), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.85),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11.0),
              topRight: Radius.circular(11.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: Colors.white, size: 16.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          color: Color(0xFF263238),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFB2DFDB),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Pitfall struct
// ============================================================
class _Pitfall {
  const _Pitfall(this.title, this.body);
  final String title;
  final String body;
}

// ============================================================
// HELPER: Comparison table rows
// ============================================================
Widget _buildCompareHeader() {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF512DA8),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(11.0),
        topRight: Radius.circular(11.0),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'MultiTapGestureRecognizer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'TapGestureRecognizer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCompareRow(String aspect, String multi, String single) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFEDE7F6), width: 1.0),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            aspect,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Color(0xFF311B92),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            multi,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            single,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Lifecycle node + arrow
// ============================================================
Widget _buildLifecycleNode(
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.85),
          color.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: Colors.white, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleArrow(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        SizedBox(width: 22.0),
        Icon(Icons.arrow_downward, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: color.withValues(alpha: 0.40),
              width: 1.0,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Quick reference table rows
// ============================================================
Widget _buildRefHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFEF6C00),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(11.0),
        topRight: Radius.circular(11.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Member',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Type',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Notes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRefRow(String name, String type, String notes) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFFFE0B2), width: 1.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFE65100),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            notes,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}
