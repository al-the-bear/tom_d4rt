// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PointerCancelEvent from gestures
// Deep Demo: Visual demonstration of PointerCancelEvent — the cancel-counterpart
// to PointerDown/Move/Up. Constructed across all PointerDeviceKind values,
// rendered as field-anatomy cards, lifecycle flowchart, device-kind catalog,
// use-case panels, Listener integration, and a footguns gallery.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('PointerCancelEvent Deep Demo executing');

  // ============================================================
  // SECTION 1: Construct a baseline PointerCancelEvent
  // ============================================================
  print('=== Section 1: Baseline PointerCancelEvent ===');

  PointerCancelEvent baseline;
  String baselineNote;
  try {
    baseline = PointerCancelEvent(
      timeStamp: Duration(milliseconds: 1234),
      pointer: 7,
      kind: PointerDeviceKind.touch,
      device: 1,
      position: Offset(120.0, 80.0),
      buttons: 0,
      obscured: false,
      pressureMin: 0.0,
      pressureMax: 1.0,
      distance: 0.0,
      distanceMax: 0.0,
      size: 0.5,
      radiusMajor: 8.0,
      radiusMinor: 8.0,
      radiusMin: 0.0,
      radiusMax: 16.0,
      orientation: 0.0,
      tilt: 0.0,
      embedderId: 0,
    );
    baselineNote = 'Constructed with full field set.';
  } catch (e) {
    baseline = PointerCancelEvent();
    baselineNote = 'Fallback: minimal constructor (full set rejected).';
  }
  print('baseline.runtimeType: ${baseline.runtimeType}');
  print('baseline.position: ${baseline.position}');
  print('baseline note: $baselineNote');

  // ============================================================
  // SECTION 2: Header / Title Banner
  // ============================================================
  print('=== Section 2: Header banner ===');

  final Widget header = Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade500,
          Colors.blue.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
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
            Icon(Icons.cancel_presentation, size: 40.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'PointerCancelEvent',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The cancel-counterpart of PointerUpEvent. Fired when the gesture '
          'system reclaims a pointer: arena handoff, palm rejection, lost '
          'tracking, or platform interruption.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'extends PointerEvent  •  package:flutter/gestures.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Anatomy diagram — every field, grouped by category
  // ============================================================
  print('=== Section 3: Anatomy diagram ===');

  final List<Widget> timingFields = <Widget>[
    _fieldChip('timeStamp', 'Duration', '1234ms', Colors.cyan),
    _fieldChip('pointer', 'int', '7', Colors.cyan),
    _fieldChip('embedderId', 'int', '0', Colors.cyan),
    _fieldChip('viewId', 'int', '0', Colors.cyan),
  ];
  final List<Widget> positionFields = <Widget>[
    _fieldChip('position', 'Offset', '(120, 80)', Colors.green),
    _fieldChip('localPosition', 'Offset', '(120, 80)', Colors.green),
    _fieldChip('delta', 'Offset', '(0, 0)', Colors.green),
    _fieldChip('localDelta', 'Offset', '(0, 0)', Colors.green),
  ];
  final List<Widget> deviceFields = <Widget>[
    _fieldChip('kind', 'PointerDeviceKind', 'touch', Colors.orange),
    _fieldChip('device', 'int', '1', Colors.orange),
    _fieldChip('buttons', 'int', '0', Colors.orange),
    _fieldChip('obscured', 'bool', 'false', Colors.orange),
  ];
  final List<Widget> pressureFields = <Widget>[
    _fieldChip('pressureMin', 'double', '0.0', Colors.pink),
    _fieldChip('pressureMax', 'double', '1.0', Colors.pink),
    _fieldChip('distance', 'double', '0.0', Colors.pink),
    _fieldChip('distanceMax', 'double', '0.0', Colors.pink),
    _fieldChip('size', 'double', '0.5', Colors.pink),
    _fieldChip('radiusMajor', 'double', '8.0', Colors.pink),
    _fieldChip('radiusMinor', 'double', '8.0', Colors.pink),
    _fieldChip('radiusMin', 'double', '0.0', Colors.pink),
    _fieldChip('radiusMax', 'double', '16.0', Colors.pink),
    _fieldChip('orientation', 'double', '0.0', Colors.pink),
    _fieldChip('tilt', 'double', '0.0', Colors.pink),
  ];

  final Widget anatomy = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a PointerCancelEvent',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          'All fields inherited from PointerEvent, grouped by concern.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        _categorySection('Timing & Identity', Icons.schedule, Colors.cyan,
            timingFields),
        SizedBox(height: 12.0),
        _categorySection(
            'Position & Motion', Icons.place, Colors.green, positionFields),
        SizedBox(height: 12.0),
        _categorySection('Device & Buttons', Icons.mouse, Colors.orange,
            deviceFields),
        SizedBox(height: 12.0),
        _categorySection('Pressure & Geometry', Icons.touch_app, Colors.pink,
            pressureFields),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Lifecycle flowchart
  // ============================================================
  print('=== Section 4: Lifecycle flowchart ===');

  final Widget lifecycle = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pointer Lifecycle',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          'A pointer always begins with Down and ends with Up OR Cancel.',
          style: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade700),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _lifecycleNode('Down', Icons.arrow_downward, Colors.green),
            _arrow(Colors.green),
            _lifecycleNode('Move', Icons.swap_horiz, Colors.blue),
            _arrow(Colors.blue),
            _lifecycleBranch(),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legendRow(
                  Colors.teal, 'Up: user-initiated, gesture succeeds.'),
              SizedBox(height: 6.0),
              _legendRow(Colors.red.shade400,
                  'Cancel: framework reclaims, gesture aborts.'),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Device-kind catalog
  // ============================================================
  print('=== Section 5: Device-kind catalog ===');

  final List<Map<String, dynamic>> deviceKinds = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': PointerDeviceKind.touch,
      'icon': Icons.touch_app,
      'color': Colors.green,
      'label': 'touch',
      'note': 'Finger on screen.',
    },
    <String, dynamic>{
      'kind': PointerDeviceKind.mouse,
      'icon': Icons.mouse,
      'color': Colors.blue,
      'label': 'mouse',
      'note': 'Desktop pointer.',
    },
    <String, dynamic>{
      'kind': PointerDeviceKind.stylus,
      'icon': Icons.edit,
      'color': Colors.purple,
      'label': 'stylus',
      'note': 'Pen / digital ink.',
    },
    <String, dynamic>{
      'kind': PointerDeviceKind.invertedStylus,
      'icon': Icons.brush,
      'color': Colors.deepPurple,
      'label': 'invertedStylus',
      'note': 'Eraser end.',
    },
    <String, dynamic>{
      'kind': PointerDeviceKind.trackpad,
      'icon': Icons.track_changes,
      'color': Colors.teal,
      'label': 'trackpad',
      'note': 'Multi-touch trackpad.',
    },
    <String, dynamic>{
      'kind': PointerDeviceKind.unknown,
      'icon': Icons.help_outline,
      'color': Colors.grey,
      'label': 'unknown',
      'note': 'Unclassified device.',
    },
  ];

  final List<Widget> deviceKindCards = <Widget>[];
  for (final Map<String, dynamic> info in deviceKinds) {
    final PointerDeviceKind kind = info['kind'] as PointerDeviceKind;
    final IconData icon = info['icon'] as IconData;
    final Color color = info['color'] as Color;
    final String label = info['label'] as String;
    final String note = info['note'] as String;

    PointerCancelEvent ev;
    String posText;
    try {
      ev = PointerCancelEvent(
        kind: kind,
        pointer: 100 + deviceKindCards.length,
        device: deviceKindCards.length,
        position: Offset(40.0 * deviceKindCards.length, 50.0),
      );
      posText = ev.position.toString();
    } catch (e) {
      ev = PointerCancelEvent();
      posText = '(concept)';
    }
    print('catalog -> kind=$label pointer=${ev.pointer}');

    deviceKindCards.add(_deviceKindCard(label, icon, color, note, posText));
  }

  final Widget deviceCatalog = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerDeviceKind Catalog',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          'PointerCancelEvent constructed once per device kind.',
          style: TextStyle(fontSize: 12.0, color: Colors.orange.shade900),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: deviceKindCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Event cards — concrete events with key fields
  // ============================================================
  print('=== Section 6: Event card grid ===');

  final List<Map<String, dynamic>> sampleEvents = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Touch cancel — finger lifted off-screen',
      'pointer': 1,
      'device': 0,
      'kind': PointerDeviceKind.touch,
      'pos': Offset(50.0, 80.0),
      'buttons': 0,
      'color': Colors.green,
    },
    <String, dynamic>{
      'title': 'Mouse cancel — drag arena lost',
      'pointer': 42,
      'device': 1,
      'kind': PointerDeviceKind.mouse,
      'pos': Offset(220.0, 140.0),
      'buttons': 1,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'title': 'Stylus cancel — palm rejection',
      'pointer': 11,
      'device': 2,
      'kind': PointerDeviceKind.stylus,
      'pos': Offset(310.0, 95.0),
      'buttons': 0,
      'color': Colors.purple,
    },
    <String, dynamic>{
      'title': 'Trackpad cancel — multi-touch handoff',
      'pointer': 73,
      'device': 3,
      'kind': PointerDeviceKind.trackpad,
      'pos': Offset(180.0, 200.0),
      'buttons': 0,
      'color': Colors.teal,
    },
  ];

  final List<Widget> eventCards = <Widget>[];
  for (final Map<String, dynamic> spec in sampleEvents) {
    final int pointer = spec['pointer'] as int;
    final int device = spec['device'] as int;
    final PointerDeviceKind kind = spec['kind'] as PointerDeviceKind;
    final Offset pos = spec['pos'] as Offset;
    final int buttons = spec['buttons'] as int;
    final Color color = spec['color'] as Color;
    final String title = spec['title'] as String;

    PointerCancelEvent ev;
    try {
      ev = PointerCancelEvent(
        pointer: pointer,
        device: device,
        kind: kind,
        position: pos,
        buttons: buttons,
      );
    } catch (e) {
      ev = PointerCancelEvent();
    }
    print('eventCard -> $title  pointer=${ev.pointer}');
    eventCards.add(_eventCard(title, ev, color));
  }

  final Widget eventGrid = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
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
          'Concrete Cancel Events',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: eventCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Use cases
  // ============================================================
  print('=== Section 7: Use cases ===');

  final List<Map<String, dynamic>> useCases = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.swap_horiz,
      'color': Colors.indigo,
      'title': 'Gesture Arena Loss',
      'body':
          'A pan recognizer is competing with a drag in the arena. The drag '
              'wins; the pan recognizer receives PointerCancelEvent and bails.',
    },
    <String, dynamic>{
      'icon': Icons.refresh,
      'color': Colors.teal,
      'title': 'Pull-to-Refresh Interruption',
      'body':
          'User starts a pull-down, then a system overlay steals focus. '
              'RefreshIndicator gets cancel and resets without firing onRefresh.',
    },
    <String, dynamic>{
      'icon': Icons.delete_sweep,
      'color': Colors.red,
      'title': 'Swipe-to-Dismiss Cancellation',
      'body':
          'Dismissible drag is interrupted by an incoming Route push. The '
              'tile snaps back rather than dismissing.',
    },
    <String, dynamic>{
      'icon': Icons.group,
      'color': Colors.deepOrange,
      'title': 'Multi-Touch Handoff',
      'body':
          'A second finger triggers a scale gesture; the original tap '
              'recognizer receives cancel because tap lost arena ownership.',
    },
  ];

  final List<Widget> useCaseTiles = <Widget>[];
  for (final Map<String, dynamic> uc in useCases) {
    useCaseTiles.add(_useCaseTile(
      uc['icon'] as IconData,
      uc['color'] as Color,
      uc['title'] as String,
      uc['body'] as String,
    ));
  }

  final Widget useCasesPanel = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.lightBlue.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use Cases',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: useCaseTiles),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Listener integration
  // ============================================================
  print('=== Section 8: Listener integration ===');

  final Listener listenerWidget = Listener(
    onPointerDown: (PointerDownEvent _) {
      print('listener: down received (not fired in this demo)');
    },
    onPointerMove: (PointerMoveEvent _) {},
    onPointerUp: (PointerUpEvent _) {},
    onPointerCancel: (PointerCancelEvent ev) {
      print('listener.onPointerCancel pointer=${ev.pointer}');
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: 220.0,
      height: 90.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade300, Colors.deepOrange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.45),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Text(
        'Listener\nonPointerCancel',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
  );

  final Widget listenerSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.1),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listener.onPointerCancel',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          'Wire a callback at the raw-pointer layer (no recognizer needed).',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listenerWidget,
            SizedBox(width: 16.0),
            Expanded(
              child: _codeBlock(
                'Listener(\n'
                '  onPointerCancel: (ev) {\n'
                '    // reset gesture state\n'
                '    // suppress success callback\n'
                '  },\n'
                '  child: child,\n'
                ')',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final List<Map<String, String>> footguns = <Map<String, String>>[
    <String, String>{
      'title': 'Recognizer never claimed arena',
      'body':
          'GestureDetector callbacks may not fire onCancel if the recognizer '
              'never won. Cancel still arrives at Listener — handle there.',
    },
    <String, String>{
      'title': 'position vs localPosition',
      'body':
          'They differ when ancestors apply transforms. Never assume equality; '
              'use localPosition for hit-test-relative coordinates.',
    },
    <String, String>{
      'title': 'delta is zero on cancel',
      'body':
          'A cancel does not move the pointer; delta and localDelta are always '
              'Offset.zero. Read the last move event for trajectory.',
    },
    <String, String>{
      'title': 'Cancel may be silently swallowed',
      'body':
          'A child Listener with HitTestBehavior.opaque can absorb cancels '
              'without forwarding. Use translucent or deferToChild deliberately.',
    },
  ];

  final List<Widget> footgunTiles = <Widget>[];
  for (final Map<String, String> fg in footguns) {
    footgunTiles.add(_footgunTile(fg['title']!, fg['body']!));
  }

  final Widget footgunsPanel = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.red.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.2),
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
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Column(children: footgunTiles),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Comparison table — Down / Move / Up / Cancel
  // ============================================================
  print('=== Section 10: Event comparison table ===');

  final Widget comparisonTable = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerEvent Subclass Comparison',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _headerCell('Event', 130.0),
            _headerCell('Origin', 130.0),
            _headerCell('Ends seq?', 90.0),
            _headerCell('delta?', 70.0),
          ],
        ),
        _comparisonRow('PointerDownEvent', 'User', 'No', 'Yes', Colors.green),
        _comparisonRow('PointerMoveEvent', 'User', 'No', 'Yes', Colors.blue),
        _comparisonRow('PointerUpEvent', 'User', 'Yes', 'Last', Colors.teal),
        _comparisonRow('PointerCancelEvent', 'Framework', 'Yes', 'Zero',
            Colors.red),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Field readout from baseline event
  // ============================================================
  print('=== Section 11: Baseline field readout ===');

  final Widget readout = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'baseline.toString() — runtime readout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        _readoutLine('runtimeType', baseline.runtimeType.toString()),
        _readoutLine('pointer', baseline.pointer.toString()),
        _readoutLine('device', baseline.device.toString()),
        _readoutLine('kind', baseline.kind.toString()),
        _readoutLine('position', baseline.position.toString()),
        _readoutLine('localPosition', baseline.localPosition.toString()),
        _readoutLine('delta', baseline.delta.toString()),
        _readoutLine('buttons', baseline.buttons.toString()),
        _readoutLine('obscured', baseline.obscured.toString()),
        _readoutLine('pressureMin', baseline.pressureMin.toString()),
        _readoutLine('pressureMax', baseline.pressureMax.toString()),
        _readoutLine('size', baseline.size.toString()),
        _readoutLine('orientation', baseline.orientation.toString()),
        _readoutLine('tilt', baseline.tilt.toString()),
        _readoutLine('embedderId', baseline.embedderId.toString()),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Final scaffold
  // ============================================================
  print('=== Section 12: Compose Scaffold ===');

  print('PointerCancelEvent Deep Demo build complete');

  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          header,
          SizedBox(height: 20.0),
          anatomy,
          SizedBox(height: 20.0),
          lifecycle,
          SizedBox(height: 20.0),
          deviceCatalog,
          SizedBox(height: 20.0),
          eventGrid,
          SizedBox(height: 20.0),
          useCasesPanel,
          SizedBox(height: 20.0),
          listenerSection,
          SizedBox(height: 20.0),
          footgunsPanel,
          SizedBox(height: 20.0),
          comparisonTable,
          SizedBox(height: 20.0),
          readout,
          SizedBox(height: 24.0),
          Center(
            child: Text(
              'PointerCancelEvent Deep Demo',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _fieldChip(String name, String type, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: color,
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          '= $value',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget _categorySection(
    String title, IconData icon, Color color, List<Widget> chips) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: chips),
      ],
    ),
  );
}

Widget _lifecycleNode(String label, IconData icon, Color color) {
  return Container(
    width: 70.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.7),
          color,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}

Widget _arrow(Color color) {
  return Container(
    width: 30.0,
    height: 4.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(2.0),
    ),
  );
}

Widget _lifecycleBranch() {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          _arrow(Colors.teal),
          _lifecycleNode('Up', Icons.arrow_upward, Colors.teal),
        ],
      ),
      SizedBox(height: 8.0),
      Row(
        children: <Widget>[
          _arrow(Colors.red.shade400),
          _lifecycleNode('Cancel', Icons.cancel, Colors.red.shade400),
        ],
      ),
    ],
  );
}

Widget _legendRow(Color color, String text) {
  return Row(
    children: <Widget>[
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade900),
        ),
      ),
    ],
  );
}

Widget _deviceKindCard(
    String label, IconData icon, Color color, String note, String posText) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 24.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          note,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'pos: $posText',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _eventCard(String title, PointerCancelEvent ev, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 4.0,
          children: <Widget>[
            _evField('pointer', ev.pointer.toString(), color),
            _evField('device', ev.device.toString(), color),
            _evField('kind', ev.kind.toString().split('.').last, color),
            _evField('position', ev.position.toString(), color),
            _evField('buttons', ev.buttons.toString(), color),
          ],
        ),
      ],
    ),
  );
}

Widget _evField(String name, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      '$name: $value',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
      ),
    ),
  );
}

Widget _useCaseTile(IconData icon, Color color, String title, String body) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _footgunTile(String title, String body) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bug_report,
                color: Colors.red.shade700, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _headerCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      border: Border.all(color: Colors.grey.shade900),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    ),
  );
}

Widget _comparisonRow(
    String name, String origin, String ends, String delta, Color color) {
  return Row(
    children: <Widget>[
      _dataCell(name, 130.0, color, monospace: true, bold: true),
      _dataCell(origin, 130.0, Colors.grey.shade700),
      _dataCell(ends, 90.0, Colors.grey.shade700),
      _dataCell(delta, 70.0, Colors.grey.shade700),
    ],
  );
}

Widget _dataCell(String text, double width, Color color,
    {bool monospace = false, bool bold = false}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: monospace ? 'monospace' : null,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: 11.0,
        color: color,
      ),
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.5,
        color: Colors.greenAccent.shade100,
        height: 1.35,
      ),
    ),
  );
}

Widget _readoutLine(String name, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
        Text(
          '= ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amberAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
}
