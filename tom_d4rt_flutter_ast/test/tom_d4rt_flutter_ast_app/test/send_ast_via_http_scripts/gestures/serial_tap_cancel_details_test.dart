// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for SerialTapCancelDetails from gestures.
// Cumulative tap-count carrier surfaced when a serial tap is cancelled.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapCancelDetails Deep Demo executing');

  // ============================================================
  // Real instances we re-use across the demo
  // ============================================================
  final d1 = SerialTapCancelDetails(count: 1);
  final d2 = SerialTapCancelDetails(count: 2);
  final d3 = SerialTapCancelDetails(count: 3);
  final d4 = SerialTapCancelDetails(count: 4);
  final d7 = SerialTapCancelDetails(count: 7);
  final d12 = SerialTapCancelDetails(count: 12);
  final allDetails = <SerialTapCancelDetails>[d1, d2, d3, d4, d7, d12];

  print('Created ${allDetails.length} SerialTapCancelDetails instances');
  for (var i = 0; i < allDetails.length; i++) {
    print('  details[$i] -> count=${allDetails[i].count}');
  }

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.indigo.shade400,
          Colors.amber.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.30),
          blurRadius: 28.0,
          offset: Offset(0.0, 14.0),
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
              ),
              child: Icon(
                Icons.touch_app_outlined,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SerialTapCancelDetails',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Cumulative tap-count carrier when a serial tap is cancelled',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram of the count field
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.6),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy: a single int payload',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.indigo.shade400, width: 2.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SerialTapCancelDetails',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        color: Colors.indigo.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.indigo.shade200,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.numbers,
                            size: 16.0,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            'int count',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              color: Colors.indigo.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 1.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade100,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'default 1',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(
              Icons.arrow_forward,
              color: Colors.indigo.shade400,
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.teal.shade400, width: 1.6),
                ),
                child: Column(
                  children: [
                    Text(
                      '1-indexed',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'first tap = 1',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Text(
            'count carries the position of the cancelled tap inside the burst. '
            'A count of 3 means: the first two taps already fired '
            '(onSerialTapDown then onSerialTapUp twice), the third tap was '
            'started, and was then cancelled before it completed.',
            style: TextStyle(fontSize: 12.0, color: Colors.brown.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Six instance cards
  // ============================================================
  print('=== Section 3: Instance cards ===');
  final instanceCards = <Widget>[];
  final captions = <String>[
    'first tap',
    'double tap',
    'triple tap',
    'quad tap',
    'rapid burst',
    'gamepad-mash',
  ];
  for (var i = 0; i < allDetails.length; i++) {
    final d = allDetails[i];
    final caption = captions[i];
    final hue = Colors.indigo.shade400;
    final accent = i.isEven ? Colors.amber.shade600 : Colors.teal.shade600;
    instanceCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.indigo.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: hue.withValues(alpha: 0.4), width: 1.4),
          boxShadow: [
            BoxShadow(
              color: hue.withValues(alpha: 0.18),
              blurRadius: 8.0,
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
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(Icons.touch_app, size: 16.0, color: accent),
                ),
                SizedBox(width: 8.0),
                Text(
                  '#${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: hue,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    caption,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.30),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SerialTapCancelDetails(',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.cyan.shade300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        Text(
                          'count: ',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.pink.shade200,
                          ),
                        ),
                        Text(
                          '${d.count}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.amber.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ',',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.cyan.shade300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'count = ',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: hue.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: hue.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${d.count}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      color: hue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // visualization of count as dots
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: _dotsForCount(d.count, accent),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Lifecycle timeline
  // ============================================================
  print('=== Section 4: Lifecycle timeline ===');
  final lifecycleSteps = <Map<String, Object>>[
    {
      'idx': 1,
      'title': 'tap1.down',
      'desc': 'Pointer hits surface. SerialTapDownDetails(count: 1) fires.',
      'icon': Icons.south_east,
      'color': Colors.green,
    },
    {
      'idx': 2,
      'title': 'tap1.up',
      'desc': 'Pointer released cleanly. SerialTapUpDetails(count: 1) fires.',
      'icon': Icons.north_east,
      'color': Colors.blue,
    },
    {
      'idx': 3,
      'title': 'tap2.down',
      'desc':
          'Within the chain window, second tap begins. SerialTapDownDetails(count: 2) fires.',
      'icon': Icons.south_east,
      'color': Colors.green,
    },
    {
      'idx': 4,
      'title': 'cancel',
      'desc':
          'Pointer drifts beyond slop OR the arena rejects → tap2 is cancelled.',
      'icon': Icons.cancel,
      'color': Colors.red,
    },
    {
      'idx': 5,
      'title': 'onSerialTapCancel',
      'desc':
          'Recognizer invokes the callback with SerialTapCancelDetails(count: 2).',
      'icon': Icons.notifications_active,
      'color': Colors.purple,
    },
  ];
  final timelineNodes = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final isLast = i == lifecycleSteps.length - 1;
    timelineNodes.add(_timelineRow(step, isLast));
  }
  final lifecycleTimeline = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.teal.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
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
            Icon(Icons.timeline, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Lifecycle: how cancel surfaces',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...timelineNodes,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Comparison vs siblings
  // ============================================================
  print('=== Section 5: Comparison table ===');
  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'vs SerialTapDownDetails / SerialTapUpDetails',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.indigo.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _cmpHeader('Type', 170.0),
              _cmpHeader('count', 60.0),
              _cmpHeader('position', 70.0),
              _cmpHeader('kind', 60.0),
              _cmpHeader('fires when', 0.0, expand: true),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _cmpRow(
          'SerialTapDownDetails',
          true,
          true,
          true,
          'pointer first contacts surface',
          Colors.green.shade50,
          Colors.green.shade700,
        ),
        _cmpRow(
          'SerialTapUpDetails',
          true,
          true,
          true,
          'tap completed cleanly',
          Colors.blue.shade50,
          Colors.blue.shade700,
        ),
        _cmpRow(
          'SerialTapCancelDetails',
          true,
          false,
          false,
          'a tap in the burst is cancelled',
          Colors.red.shade50,
          Colors.red.shade700,
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade800, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Cancel is the lightest of the three: just a count. It '
                  'tells you which tap inside the burst was killed, but not '
                  'where or how.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.brown.shade900,
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
  // SECTION 6: Gesture-arena explainer
  // ============================================================
  print('=== Section 6: Arena explainer ===');
  final arenaScenarios = <Map<String, Object>>[
    {
      'title': 'slop exceeded',
      'icon': Icons.open_with,
      'color': Colors.red.shade400,
      'desc':
          'Pointer drifted past kPrimaryButtonSlop before lift. Tap rejected; cancel fires with the in-progress count.',
    },
    {
      'title': 'lost arena',
      'icon': Icons.gavel,
      'color': Colors.deepOrange.shade400,
      'desc':
          'Another recognizer (drag, scroll, long-press) won the gesture arena. The serial tap is force-cancelled.',
    },
    {
      'title': 'chain timeout',
      'icon': Icons.hourglass_disabled,
      'color': Colors.purple.shade400,
      'desc':
          'Time between consecutive taps exceeded kDoubleTapTimeout. The pending serial tap is cancelled.',
    },
  ];
  final arenaCards = <Widget>[];
  for (var i = 0; i < arenaScenarios.length; i++) {
    final s = arenaScenarios[i];
    arenaCards.add(_arenaCard(s));
  }
  final arenaExplainer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
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
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red.shade700,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Three triggers in the arena',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(spacing: 12.0, runSpacing: 12.0, children: arenaCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Real-world mock — tap counter UI
  // ============================================================
  print('=== Section 7: Real-world mock ===');
  final mockStates = <Map<String, Object>>[
    {'count': 0, 'label': 'idle', 'cancelled': false},
    {'count': 1, 'label': 'first tap', 'cancelled': false},
    {'count': 2, 'label': 'second tap', 'cancelled': false},
    {'count': 3, 'label': 'third tap', 'cancelled': true},
  ];
  final mockTiles = <Widget>[];
  for (var i = 0; i < mockStates.length; i++) {
    final st = mockStates[i];
    mockTiles.add(_mockStateTile(st));
  }
  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
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
            Icon(Icons.devices, color: Colors.teal.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world mock: tap counter',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(spacing: 12.0, runSpacing: 12.0, children: mockTiles),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'When the burst is cancelled at tap #3, the recognizer '
                  'delivers SerialTapCancelDetails(count: 3) and the UI '
                  'rolls back to its committed state.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.teal.shade900,
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
  // SECTION 8: Usage code block
  // ============================================================
  print('=== Section 8: Usage code ===');
  final usageCode = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Wiring SerialTapGestureRecognizer',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeLine('final recognizer = SerialTapGestureRecognizer()', Colors.white),
        _codeLine('  ..onSerialTapDown = (SerialTapDownDetails d) {',
            Colors.lightBlueAccent.shade100),
        _codeLine("      print('down #\${d.count} at \${d.globalPosition}');",
            Colors.green.shade300),
        _codeLine('    }', Colors.white),
        _codeLine('  ..onSerialTapUp = (SerialTapUpDetails d) {',
            Colors.lightBlueAccent.shade100),
        _codeLine("      print('up   #\${d.count} at \${d.globalPosition}');",
            Colors.green.shade300),
        _codeLine('    }', Colors.white),
        _codeLine(
          '  ..onSerialTapCancel = (SerialTapCancelDetails d) {',
          Colors.amber.shade300,
        ),
        _codeLine(
          "      print('cancelled at tap #\${d.count}');",
          Colors.green.shade300,
        ),
        _codeLine('      _rollbackToCount(d.count - 1);',
            Colors.pinkAccent.shade100),
        _codeLine('    };', Colors.white),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.cyan.withValues(alpha: 0.30)),
          ),
          child: Text(
            '// d.count is 1-indexed; subtract 1 to know how many taps committed.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyan.shade200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');
  final footgunEntries = <Map<String, Object>>[
    {
      'title': 'count is always >= 1',
      'desc':
          'There is no zero-count cancel. The first cancel inside a burst already carries count: 1.',
      'icon': Icons.exposure_plus_1,
    },
    {
      'title': 'cancel is not release',
      'desc':
          'onSerialTapCancel is a rejection, not a successful tap. Do not commit state changes here.',
      'icon': Icons.block,
    },
    {
      'title': 'no identity across bursts',
      'desc':
          'Each burst restarts at count: 1. Do not key UI state on count alone across timeouts.',
      'icon': Icons.repeat_on,
    },
    {
      'title': 'cancel fires before next down',
      'desc':
          'Order is guaranteed: cancel arrives before any subsequent SerialTapDownDetails for a fresh burst.',
      'icon': Icons.compare_arrows,
    },
    {
      'title': 'debounce vs cancel',
      'desc':
          'A timeout-cancel and a user-debounce look identical at the API level — only the count tells you how far the user got.',
      'icon': Icons.hourglass_bottom,
    },
  ];
  final footgunRows = <Widget>[];
  for (var i = 0; i < footgunEntries.length; i++) {
    footgunRows.add(_footgunRow(i + 1, footgunEntries[i]));
  }
  final footgunsCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
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
            Icon(
              Icons.dangerous_outlined,
              color: Colors.deepOrange.shade800,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Footguns to remember',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...footgunRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');
  final recapBullets = <String>[
    'SerialTapCancelDetails carries a single int field: count.',
    'count is 1-indexed and identifies which tap of the burst was cancelled.',
    'The class is the cancel sibling of SerialTapDownDetails / SerialTapUpDetails.',
    'It surfaces from onSerialTapCancel inside SerialTapGestureRecognizer.',
    'Use d.count - 1 to know how many taps committed before the cancel.',
  ];
  final recapRows = <Widget>[];
  for (var i = 0; i < recapBullets.length; i++) {
    recapRows.add(_recapRow(i + 1, recapBullets[i]));
  }
  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.indigo.shade400,
          Colors.teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...recapRows,
      ],
    ),
  );

  // ============================================================
  // Final layout
  // ============================================================
  print('SerialTapCancelDetails Deep Demo completed successfully');
  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeading('1. Title banner'),
          _sectionNote(
              'A SerialTapCancelDetails is the cancel-side payload of the serial-tap gesture. It carries a single integer.'),
          SizedBox(height: 16.0),
          _sectionHeading('2. Anatomy'),
          anatomy,
          SizedBox(height: 16.0),
          _sectionHeading('3. Six real instances'),
          _sectionNote(
              'Real SerialTapCancelDetails objects with count = 1, 2, 3, 4, 7, 12.'),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: instanceCards),
          SizedBox(height: 16.0),
          _sectionHeading('4. Lifecycle timeline'),
          lifecycleTimeline,
          SizedBox(height: 16.0),
          _sectionHeading('5. Compare with siblings'),
          comparisonTable,
          SizedBox(height: 16.0),
          _sectionHeading('6. Three arena triggers'),
          arenaExplainer,
          SizedBox(height: 16.0),
          _sectionHeading('7. Real-world mock'),
          realWorldMock,
          SizedBox(height: 16.0),
          _sectionHeading('8. Usage'),
          usageCode,
          SizedBox(height: 16.0),
          _sectionHeading('9. Footguns'),
          footgunsCard,
          SizedBox(height: 16.0),
          _sectionHeading('10. Recap'),
          recapCard,
          SizedBox(height: 32.0),
          // Footer signature with raw counts
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_outlined,
                  color: Colors.indigo,
                  size: 18.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Demo built from ${allDetails.length} real '
                    'SerialTapCancelDetails instances '
                    '(counts: ${d1.count}, ${d2.count}, ${d3.count}, '
                    '${d4.count}, ${d7.count}, ${d12.count}).',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade800,
                      fontFamily: 'monospace',
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

// ============================================================
// Top-level helpers (no classes allowed in d4rt sandbox)
// ============================================================

Widget _sectionHeading(String text) {
  return Container(
    margin: EdgeInsets.only(top: 4.0, bottom: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.transparent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(
        left: BorderSide(color: Colors.indigo.shade400, width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _sectionNote(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.grey.shade700,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

List<Widget> _dotsForCount(int count, Color color) {
  // cap visual to 12 dots
  final shown = count > 12 ? 12 : count;
  final dots = <Widget>[];
  for (var i = 0; i < shown; i++) {
    dots.add(
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 3.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
  if (count > 12) {
    dots.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          '+${count - 12}',
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
  return dots;
}

Widget _timelineRow(Map<String, Object> step, bool isLast) {
  final color = step['color'] as Color;
  final icon = step['icon'] as IconData;
  final title = step['title'] as String;
  final desc = step['desc'] as String;
  final idx = step['idx'] as int;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$idx',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          if (!isLast)
            Container(
              width: 2.0,
              height: 36.0,
              color: color.withValues(alpha: 0.4),
            ),
        ],
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: isLast ? 0.0 : 8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color.withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.10),
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
                  Icon(icon, color: color, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                desc,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _cmpHeader(String text, double width, {bool expand = false}) {
  final child = Text(
    text,
    style: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.bold,
      color: Colors.indigo.shade900,
    ),
  );
  if (expand) {
    return Expanded(child: child);
  }
  return SizedBox(width: width, child: child);
}

Widget _cmpRow(
  String type,
  bool hasCount,
  bool hasPos,
  bool hasKind,
  String fires,
  Color bg,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 170.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 60.0, child: _cmpFlag(hasCount)),
        SizedBox(width: 70.0, child: _cmpFlag(hasPos)),
        SizedBox(width: 60.0, child: _cmpFlag(hasKind)),
        Expanded(
          child: Text(
            fires,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _cmpFlag(bool yes) {
  return Icon(
    yes ? Icons.check_circle : Icons.remove_circle_outline,
    color: yes ? Colors.green.shade600 : Colors.grey.shade400,
    size: 16.0,
  );
}

Widget _arenaCard(Map<String, Object> s) {
  final color = s['color'] as Color;
  final icon = s['icon'] as IconData;
  final title = s['title'] as String;
  final desc = s['desc'] as String;
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
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
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(icon, color: color, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          desc,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

Widget _mockStateTile(Map<String, Object> st) {
  final count = st['count'] as int;
  final label = st['label'] as String;
  final cancelled = st['cancelled'] as bool;
  final color = cancelled ? Colors.red : Colors.teal;
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: cancelled
            ? [Colors.red.shade100, Colors.red.shade50]
            : [Colors.teal.shade100, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.30),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        if (cancelled)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Cancelled at #$count',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade600,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              count == 0 ? 'waiting' : 'committed',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _codeLine(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: color,
        height: 1.35,
      ),
    ),
  );
}

Widget _footgunRow(int idx, Map<String, Object> entry) {
  final title = entry['title'] as String;
  final desc = entry['desc'] as String;
  final icon = entry['icon'] as IconData;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.deepOrange.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.10),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade600,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$idx',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16.0, color: Colors.deepOrange.shade700),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapRow(int idx, String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26.0,
          height: 26.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$idx',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
