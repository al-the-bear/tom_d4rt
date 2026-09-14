// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MultiDragPointerState (abstract) from gestures
// Deep Demo: Visual descriptive demonstration of per-pointer state tracking
// inside MultiDragGestureRecognizer subclasses.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragPointerState Deep Demo executing');

  // ============================================================
  // Theme palette: cyan/blue telemetry/state theme
  // ============================================================
  final Color tealDeep = Color(0xFF006064);
  final Color tealMid = Color(0xFF00838F);
  final Color tealLight = Color(0xFF00ACC1);
  final Color cyanGlow = Color(0xFF26C6DA);
  final Color cyanBright = Color(0xFF4DD0E1);
  final Color skyTint = Color(0xFFB2EBF2);
  final Color paperTint = Color(0xFFE0F7FA);
  final Color amberAccent = Color(0xFFFFB300);
  final Color amberSoft = Color(0xFFFFE082);
  final Color rejectRed = Color(0xFFE53935);
  final Color acceptGreen = Color(0xFF43A047);
  final Color slate = Color(0xFF263238);
  final Color slateMuted = Color(0xFF455A64);

  // ============================================================
  // Shared style helpers (used as values, not as widget builders)
  // ============================================================
  final TextStyle headStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: tealDeep,
    letterSpacing: 0.6,
  );
  final TextStyle subHeadStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: tealMid,
  );
  final TextStyle bodyStyle = TextStyle(
    fontSize: 12.5,
    color: slate,
    height: 1.35,
  );
  final TextStyle codeStyle = TextStyle(
    fontSize: 11.5,
    fontFamily: 'monospace',
    color: tealDeep,
  );
  final TextStyle tinyMuted = TextStyle(
    fontSize: 10.5,
    color: slateMuted,
    fontStyle: FontStyle.italic,
  );

  // ============================================================
  // Touch the type at runtime (no instantiation - it's abstract)
  // ============================================================
  final ImmediateMultiDragGestureRecognizer immediate =
      ImmediateMultiDragGestureRecognizer();
  final HorizontalMultiDragGestureRecognizer horizontal =
      HorizontalMultiDragGestureRecognizer();
  final VerticalMultiDragGestureRecognizer vertical =
      VerticalMultiDragGestureRecognizer();
  final DelayedMultiDragGestureRecognizer delayed =
      DelayedMultiDragGestureRecognizer();
  print('Recognizer families instantiated:');
  print('  immediate: ${immediate.runtimeType}');
  print('  horizontal: ${horizontal.runtimeType}');
  print('  vertical: ${vertical.runtimeType}');
  print('  delayed: ${delayed.runtimeType}');
  immediate.dispose();
  horizontal.dispose();
  vertical.dispose();
  delayed.dispose();

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  final Widget section1 = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid, tealLight, cyanGlow],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: cyanGlow.withValues(alpha: 0.35),
          blurRadius: 36.0,
          offset: Offset(0.0, 0.0),
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
                  width: 1.4,
                ),
              ),
              child: Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MultiDragPointerState',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart  -  abstract class',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.5,
                      fontFamily: 'monospace',
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
            color: Colors.black.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1.0,
            ),
          ),
          child: Text(
            'Per-pointer state object created by MultiDragGestureRecognizer\n'
            'subclasses (Immediate, Horizontal, Vertical, Delayed). It tracks\n'
            'each finger separately - one MultiDragPointerState per pointer -\n'
            'until the recognizer wins or loses the gesture arena.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.45,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _chip('abstract', Colors.white, amberAccent),
            _chip('per-pointer', Colors.white, cyanBright),
            _chip('arena-aware', Colors.white, acceptGreen),
            _chip('internal API', Colors.white, slateMuted),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram - the 5 fields
  // ============================================================
  final List<Map<String, String>> anatomyFields = [
    {
      'label': 'initialPosition',
      'type': 'Offset',
      'desc': 'Global pointer-down location',
      'example': 'Offset(120, 240)',
    },
    {
      'label': 'pendingDelta',
      'type': 'Offset?',
      'desc': 'Accumulated movement since touch start',
      'example': 'Offset(15, 5)',
    },
    {
      'label': 'lastPendingEventTimestamp',
      'type': 'Duration?',
      'desc': 'Timestamp of the most recent move event',
      'example': '0:00:01.250000',
    },
    {
      'label': 'kind',
      'type': 'PointerDeviceKind',
      'desc': 'touch / mouse / stylus / trackpad',
      'example': 'PointerDeviceKind.touch',
    },
    {
      'label': 'gestureSettings',
      'type': 'DeviceGestureSettings?',
      'desc': 'Platform tuning (touch slop)',
      'example': 'touchSlop: 18.0',
    },
  ];

  final List<Widget> anatomyRows = [];
  for (int i = 0; i < anatomyFields.length; i++) {
    final Map<String, String> f = anatomyFields[i];
    final bool even = i % 2 == 0;
    anatomyRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: even
                ? [paperTint, skyTint]
                : [skyTint, cyanBright.withValues(alpha: 0.45)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tealLight, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: tealLight.withValues(alpha: 0.18),
              blurRadius: 6.0,
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tealDeep,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['label']!,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: tealDeep,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    f['type']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: amberAccent,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(f['desc']!, style: bodyStyle),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(f['example']!, style: codeStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section2 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '02  -  Anatomy of a Pointer State',
    subtitle: 'Five fields per active finger',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: anatomyRows,
    ),
  );

  // ============================================================
  // SECTION 3: Subclass family tree
  // ============================================================
  final Widget familyRoot = Container(
    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'MultiDragPointerState',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'abstract',
          style: TextStyle(
            color: amberSoft,
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  Widget childNode(String title, String parent, Color accent, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.18),
              accent.withValues(alpha: 0.35),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: accent, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: accent, size: 24.0),
            SizedBox(height: 6.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'used by',
              style: TextStyle(fontSize: 9.0, color: slateMuted),
            ),
            Text(
              parent,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.5,
                color: slateMuted,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget arrowRow = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Expanded(child: _verticalArrow(tealMid)),
        Expanded(child: _verticalArrow(tealMid)),
        Expanded(child: _verticalArrow(tealMid)),
        Expanded(child: _verticalArrow(tealMid)),
      ],
    ),
  );

  final Widget section3 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '03  -  Subclass Family Tree',
    subtitle: 'Four concrete pointer-state variants',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      children: [
        Center(child: familyRoot),
        arrowRow,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            childNode(
              '_ImmediatePointerState',
              'ImmediateMultiDrag',
              cyanGlow,
              Icons.flash_on,
            ),
            childNode(
              '_HorizontalPointerState',
              'HorizontalMultiDrag',
              acceptGreen,
              Icons.swap_horiz,
            ),
            childNode(
              '_VerticalPointerState',
              'VerticalMultiDrag',
              amberAccent,
              Icons.swap_vert,
            ),
            childNode(
              '_DelayedPointerState',
              'DelayedMultiDrag',
              tealLight,
              Icons.timer,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: skyTint,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: tealLight, width: 1.0),
          ),
          child: Text(
            'All four classes are private (_-prefix). They are constructed '
            'inside the recognizer\'s createNewPointerState method - never '
            'directly. They differ only in their resolution criteria.',
            style: bodyStyle,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Lifecycle timeline
  // ============================================================
  final List<Map<String, dynamic>> lifecycleSteps = [
    {
      'step': 'pointer-down',
      'desc': 'Recognizer creates a state instance via createNewPointerState',
      'icon': Icons.fiber_manual_record,
      'color': tealLight,
    },
    {
      'step': 'tracking',
      'desc': 'Each pointer-move accumulates pendingDelta',
      'icon': Icons.timeline,
      'color': cyanGlow,
    },
    {
      'step': 'check resolution',
      'desc': 'checkForResolutionAfterMove decides accept/wait',
      'icon': Icons.gavel,
      'color': amberAccent,
    },
    {
      'step': 'accepted()',
      'desc': 'Arena won - obtain a Drag from _client and replay deltas',
      'icon': Icons.check_circle,
      'color': acceptGreen,
    },
    {
      'step': 'rejected()',
      'desc': 'Arena lost - drop pending state quietly',
      'icon': Icons.cancel,
      'color': rejectRed,
    },
    {
      'step': 'dispose()',
      'desc': 'Pointer up or cancel - free the state object',
      'icon': Icons.delete_sweep,
      'color': slateMuted,
    },
  ];

  final List<Widget> timelineNodes = [];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final Map<String, dynamic> s = lifecycleSteps[i];
    final Color c = s['color'] as Color;
    timelineNodes.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [c.withValues(alpha: 0.95), c],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: c.withValues(alpha: 0.5),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Icon(s['icon'] as IconData,
                    color: Colors.white, size: 20.0),
              ),
              if (i != lifecycleSteps.length - 1)
                Container(width: 3.0, height: 28.0, color: tealLight),
            ],
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    c.withValues(alpha: 0.12),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: c.withValues(alpha: 0.55)),
                boxShadow: [
                  BoxShadow(
                    color: c.withValues(alpha: 0.18),
                    blurRadius: 5.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}.  ${s['step']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: c,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(s['desc'] as String, style: bodyStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section4 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '04  -  State Lifecycle Timeline',
    subtitle: 'Pointer-down to dispose - six discrete phases',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: timelineNodes,
    ),
  );

  // ============================================================
  // SECTION 5: Field reference table
  // ============================================================
  final List<List<String>> referenceRows = [
    ['initialPosition', 'Offset', 'ctor (down)', 'never'],
    ['pendingDelta', 'Offset?', 'each move', 'on accept'],
    ['lastPendingEventTimestamp', 'Duration?', 'each move', 'on accept'],
    ['kind', 'PointerDeviceKind', 'ctor', 'never'],
    ['gestureSettings', 'DeviceGestureSettings?', 'ctor', 'never'],
    ['_client', 'Drag?', 'on accept', 'on dispose'],
    ['_arenaEntry', 'GestureArenaEntry?', 'on add', 'on resolve'],
  ];

  final TableRow header = TableRow(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    children: [
      _tableHead('field'),
      _tableHead('type'),
      _tableHead('set when'),
      _tableHead('cleared'),
    ],
  );

  final List<TableRow> dataRows = [header];
  for (int r = 0; r < referenceRows.length; r++) {
    final List<String> row = referenceRows[r];
    final bool zebra = r % 2 == 0;
    dataRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: zebra ? paperTint : Colors.white,
        ),
        children: [
          _tableCell(row[0], code: true, color: tealDeep),
          _tableCell(row[1], code: true, color: amberAccent),
          _tableCell(row[2]),
          _tableCell(row[3]),
        ],
      ),
    );
  }

  final Widget section5 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '05  -  Field Reference Table',
    subtitle: 'Lifecycle window for every observable property',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tealLight, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: tealMid.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(3.0),
            1: FlexColumnWidth(3.0),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(2.0),
          },
          children: dataRows,
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 6: Pending delta accumulation diagram
  // ============================================================
  final List<Map<String, dynamic>> deltaTrace = [
    {
      'event': 'down',
      'pos': 'Offset(0, 0)',
      'delta': 'null',
      'note': 'state created; pendingDelta still null',
    },
    {
      'event': 'move +1',
      'pos': 'Offset(10, 0)',
      'delta': 'Offset(10, 0)',
      'note': 'first move sets pendingDelta',
    },
    {
      'event': 'move +2',
      'pos': 'Offset(15, 5)',
      'delta': 'Offset(15, 5)',
      'note': 'cumulative since touch start',
    },
    {
      'event': 'accepted',
      'pos': 'Offset(15, 5)',
      'delta': 'replayed -> null',
      'note': '_client.update(delta); pendingDelta cleared',
    },
    {
      'event': 'move +3',
      'pos': 'Offset(20, 8)',
      'delta': 'forwarded',
      'note': 'subsequent moves go straight to Drag',
    },
  ];

  final List<Widget> deltaWidgets = [];
  for (int i = 0; i < deltaTrace.length; i++) {
    final Map<String, dynamic> step = deltaTrace[i];
    deltaWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: cyanGlow.withValues(alpha: 0.55)),
        ),
        child: Row(
          children: [
            Container(
              width: 70.0,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tealDeep,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                step['event'] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 3,
              child: Text(step['pos'] as String, style: codeStyle),
            ),
            Icon(Icons.arrow_forward, size: 14.0, color: tealMid),
            SizedBox(width: 6.0),
            Expanded(
              flex: 3,
              child: Text(
                step['delta'] as String,
                style: codeStyle.copyWith(color: amberAccent),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(step['note'] as String, style: tinyMuted),
            ),
          ],
        ),
      ),
    );
  }

  final Widget pathDiagram = Container(
    height: 130.0,
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [skyTint, cyanBright.withValues(alpha: 0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tealLight, width: 1.0),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 12.0,
          top: 95.0,
          child: _pointDot('A (0,0)', tealDeep),
        ),
        Positioned(
          left: 130.0,
          top: 95.0,
          child: _pointDot('B (10,0)', tealMid),
        ),
        Positioned(
          left: 250.0,
          top: 70.0,
          child: _pointDot('C (15,5)', amberAccent),
        ),
        Positioned(
          left: 380.0,
          top: 50.0,
          child: _pointDot('D (20,8)', acceptGreen),
        ),
        Positioned(
          left: 50.0,
          top: 105.0,
          child: Container(width: 80.0, height: 2.0, color: tealMid),
        ),
        Positioned(
          left: 170.0,
          top: 95.0,
          child: Transform.rotate(
            angle: -0.2,
            child: Container(width: 80.0, height: 2.0, color: amberAccent),
          ),
        ),
        Positioned(
          left: 290.0,
          top: 75.0,
          child: Transform.rotate(
            angle: -0.15,
            child: Container(width: 90.0, height: 2.0, color: acceptGreen),
          ),
        ),
        Positioned(
          right: 6.0,
          top: 6.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text('drag path', style: tinyMuted),
          ),
        ),
      ],
    ),
  );

  final Widget section6 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '06  -  Pending Delta Accumulation',
    subtitle: 'pendingDelta buffers movement until arena resolves',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        pathDiagram,
        ...deltaWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Per-subclass differences (4 cards)
  // ============================================================
  final List<Map<String, dynamic>> variantCards = [
    {
      'name': 'Immediate',
      'icon': Icons.flash_on,
      'color': cyanGlow,
      'accept':
          'Accepts on first non-zero pointer move - no slop, no direction.',
      'use': 'Drag-and-drop reordering; floating action handles.',
      'beware': 'Will compete aggressively with scrollables.',
    },
    {
      'name': 'Horizontal',
      'icon': Icons.swap_horiz,
      'color': acceptGreen,
      'accept': 'Accepts when |dx| > kPanSlop and dx dominates dy.',
      'use': 'Side-swipe panels; horizontal carousels.',
      'beware': 'Loses to PageView until slop threshold crossed.',
    },
    {
      'name': 'Vertical',
      'icon': Icons.swap_vert,
      'color': amberAccent,
      'accept': 'Accepts when |dy| > kPanSlop and dy dominates dx.',
      'use': 'Pull-to-dismiss sheets; reorderable lists.',
      'beware': 'Conflicts with vertical Scrollable parents.',
    },
    {
      'name': 'Delayed',
      'icon': Icons.timer,
      'color': tealLight,
      'accept': 'Accepts after kLongPressTimeout if pointer stayed put.',
      'use': 'Long-press to drag (WhatsApp message reorder).',
      'beware': 'User must wait - feedback widget should signal readiness.',
    },
  ];

  final List<Widget> variantWidgets = [];
  for (int i = 0; i < variantCards.length; i++) {
    final Map<String, dynamic> v = variantCards[i];
    final Color c = v['color'] as Color;
    variantWidgets.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              c.withValues(alpha: 0.18),
              c.withValues(alpha: 0.32),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: c, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.3),
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
                    color: c.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(v['icon'] as IconData, color: c, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    v['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: tealDeep,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _kvRow('accept:', v['accept'] as String, bodyStyle, tealMid),
            SizedBox(height: 6.0),
            _kvRow('use:', v['use'] as String, bodyStyle, acceptGreen),
            SizedBox(height: 6.0),
            _kvRow('beware:', v['beware'] as String, bodyStyle, rejectRed),
          ],
        ),
      ),
    );
  }

  final Widget section7 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '07  -  Per-Subclass Acceptance Rules',
    subtitle: 'Each variant overrides checkForResolutionAfterMove',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Wrap(
      alignment: WrapAlignment.start,
      children: variantWidgets,
    ),
  );

  // ============================================================
  // SECTION 8: Real-world use case - 3-finger reorder
  // ============================================================
  final List<Map<String, dynamic>> fingers = [
    {
      'id': 'pointer #1',
      'pos': 'Offset(120, 240)',
      'delta': 'Offset(0, -42)',
      'kind': 'touch',
      'state': 'accepted',
      'color': acceptGreen,
    },
    {
      'id': 'pointer #2',
      'pos': 'Offset(200, 290)',
      'delta': 'Offset(2, -38)',
      'kind': 'touch',
      'state': 'accepted',
      'color': acceptGreen,
    },
    {
      'id': 'pointer #3',
      'pos': 'Offset(310, 320)',
      'delta': 'Offset(-1, -45)',
      'kind': 'touch',
      'state': 'tracking',
      'color': amberAccent,
    },
  ];

  final List<Widget> fingerCards = [];
  for (int i = 0; i < fingers.length; i++) {
    final Map<String, dynamic> f = fingers[i];
    final Color c = f['color'] as Color;
    fingerCards.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                c.withValues(alpha: 0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: c, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: c.withValues(alpha: 0.25),
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
                  Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: c.withValues(alpha: 0.5),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    f['id'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: tealDeep,
                    ),
                  ),
                ],
              ),
              Divider(color: tealLight.withValues(alpha: 0.4), height: 14.0),
              Text('initialPosition', style: tinyMuted),
              Text(f['pos'] as String, style: codeStyle),
              SizedBox(height: 4.0),
              Text('pendingDelta', style: tinyMuted),
              Text(
                f['delta'] as String,
                style: codeStyle.copyWith(color: amberAccent),
              ),
              SizedBox(height: 4.0),
              Text('kind', style: tinyMuted),
              Text(f['kind'] as String, style: codeStyle),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  f['state'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget mockGesture = Container(
    height: 200.0,
    margin: EdgeInsets.only(bottom: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid, slate],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          left: 16.0,
          top: 12.0,
          child: Text(
            'Mock screen   -   3-finger reorder grip',
            style: TextStyle(
              color: skyTint,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Positioned(left: 100.0, top: 130.0, child: _fingerDot(acceptGreen, '1')),
        Positioned(left: 200.0, top: 150.0, child: _fingerDot(acceptGreen, '2')),
        Positioned(left: 310.0, top: 165.0, child: _fingerDot(amberAccent, '3')),
        Positioned(
          left: 40.0,
          bottom: 10.0,
          child: Text(
            'ImmediateMultiDragGestureRecognizer  -  3 active states',
            style: TextStyle(
              color: cyanBright,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  final Widget section8 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '08  -  Real-World: 3-Finger Reorder',
    subtitle: 'Three concurrent MultiDragPointerState instances',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        mockGesture,
        Row(children: fingerCards),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: skyTint,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: tealLight, width: 1.0),
          ),
          child: Text(
            'Each pointer owns one MultiDragPointerState. The recognizer maps '
            'pointer ID -> state in an internal Map. Disposing the recognizer '
            'walks the map and disposes every state.',
            style: bodyStyle,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  final List<Map<String, String>> footguns = [
    {
      'title': 'Forgetting accepted() / rejected()',
      'desc':
          'Custom subclass that wins the arena but never calls accepted() '
              'will leak pending deltas - the Drag never starts.',
    },
    {
      'title': 'initialPosition vs current position',
      'desc':
          'initialPosition is frozen at pointer-down. Current position must '
              'be reconstructed as initialPosition + pendingDelta (until '
              'accept replays it).',
    },
    {
      'title': 'pendingDelta is null at start',
      'desc':
          'Right after construction pendingDelta is null, not Offset.zero. '
              'Always null-check before reading.',
    },
    {
      'title': 'Resolving twice',
      'desc':
          'Calling accepted then rejected (or vice versa) on the same state '
              'corrupts the arena entry - guard with a local flag.',
    },
    {
      'title': 'Holding state past dispose()',
      'desc':
          'After dispose() the _client Drag is null. Capturing the state in '
              'a closure and using it later throws.',
    },
  ];

  final List<Widget> footgunWidgets = [];
  for (int i = 0; i < footguns.length; i++) {
    final Map<String, String> g = footguns[i];
    footgunWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rejectRed.withValues(alpha: 0.08),
              amberSoft.withValues(alpha: 0.55),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: rejectRed.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: rejectRed.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: rejectRed, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    g['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: rejectRed,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(g['desc']!, style: bodyStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section9 = _sectionShell(
    paperTint: paperTint,
    tealDeep: tealDeep,
    tealLight: tealLight,
    cyanGlow: cyanGlow,
    title: '09  -  Footguns',
    subtitle: 'Common mistakes when subclassing or inspecting state',
    headStyle: headStyle,
    subHeadStyle: subHeadStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: footgunWidgets,
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  final Widget section10 = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid, tealLight, cyanGlow],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: cyanGlow.withValues(alpha: 0.4),
          blurRadius: 30.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              '10  -  Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapBullet(
          'Per-pointer ledger',
          'One MultiDragPointerState per active finger; lives only as long '
              'as the pointer.',
        ),
        _recapBullet(
          'Five observable fields',
          'initialPosition, pendingDelta, lastPendingEventTimestamp, kind, '
              'gestureSettings.',
        ),
        _recapBullet(
          'Four concrete shapes',
          'Immediate, Horizontal, Vertical, Delayed - each with its own '
              'acceptance criterion.',
        ),
        _recapBullet(
          'Arena driven',
          'Lifecycle bound to GestureArenaEntry: accepted() spawns Drag, '
              'rejected() drops state.',
        ),
        _recapBullet(
          'Internal API',
          'You touch it only when authoring a custom MultiDragGestureRecognizer.',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Mental model: a pointer-down event materialises a small ledger; '
            'every move stamps the ledger; arena verdict either replays the '
            'ledger to a Drag or discards it; pointer-up disposes the ledger.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('Sections assembled: 10');
  print('MultiDragPointerState Deep Demo build complete');

  return Scaffold(
    backgroundColor: paperTint,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper widgets / functions
// ============================================================

Widget _chip(String label, Color fg, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: fg.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _verticalArrow(Color color) {
  return Column(
    children: [
      Container(width: 2.0, height: 24.0, color: color),
      Icon(Icons.arrow_drop_down, color: color, size: 18.0),
    ],
  );
}

Widget _sectionShell({
  required Color paperTint,
  required Color tealDeep,
  required Color tealLight,
  required Color cyanGlow,
  required String title,
  required String subtitle,
  required TextStyle headStyle,
  required TextStyle subHeadStyle,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, paperTint],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealLight.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: cyanGlow.withValues(alpha: 0.18),
          blurRadius: 24.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: headStyle),
        SizedBox(height: 2.0),
        Text(subtitle, style: subHeadStyle),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 2.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tealDeep, cyanGlow, Colors.transparent],
            ),
          ),
        ),
        body,
      ],
    ),
  );
}

Widget _tableHead(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _tableCell(String text, {bool code = false, Color? color}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: code ? 'monospace' : null,
        fontSize: 11.5,
        color: color ?? Color(0xFF263238),
      ),
    ),
  );
}

Widget _pointDot(String label, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 9.5,
          color: color,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 2.0),
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.6),
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _kvRow(String key, String value, TextStyle bodyStyle, Color keyColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 60.0,
        child: Text(
          key,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            color: keyColor,
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(child: Text(value, style: bodyStyle)),
    ],
  );
}

Widget _fingerDot(Color color, String tag) {
  return Container(
    width: 56.0,
    height: 56.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [Colors.white.withValues(alpha: 0.95), color],
      ),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.7),
          blurRadius: 14.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Text(
      tag,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF263238),
        fontSize: 18.0,
      ),
    ),
  );
}

Widget _recapBullet(String head, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0, right: 8.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.7),
                blurRadius: 5.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 12.5, height: 1.4),
              children: [
                TextSpan(
                  text: '$head:  ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
