// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests DragStartDetails from package:flutter/gestures.dart
// Deep Demo: Visual demonstration of DragStartDetails — the payload that
// onDragStart / onPanStart / onHorizontalDragStart / onVerticalDragStart
// callbacks receive when a drag gesture begins.
//
// DragStartDetails captures the *initial* contact point of a drag:
//   - globalPosition : screen-space coordinates (top-left of the window)
//   - localPosition  : coordinates relative to the receiving widget
//   - sourceTimeStamp: the input event timestamp (nullable Duration)
//   - kind           : the input device kind (touch, mouse, stylus, ...)
//
// This demo constructs a gallery of DragStartDetails instances representing
// different input scenarios, then visualises the start-points on a canvas
// with crosshair overlays, breaks each field into an annotated card, lays
// the start-timestamps on a horizontal time-axis and concludes with recipes
// (GestureDetector.onPanStart, Draggable.onDragStarted) and pitfalls.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragStartDetails Deep Demo executing');

  // ============================================================
  // DATA: A gallery of DragStartDetails instances representing
  // different drag-origin scenarios.  Each one models a realistic
  // drag-start event we want to inspect.
  // ============================================================
  print('=== Data: building DragStartDetails sample gallery ===');

  final samples = <Map<String, Object?>>[
    {
      'label': 'Touch — top-left',
      'details': DragStartDetails(
        globalPosition: const Offset(48.0, 64.0),
        localPosition: const Offset(8.0, 12.0),
        sourceTimeStamp: const Duration(milliseconds: 120),
        kind: PointerDeviceKind.touch,
      ),
      'color': Colors.teal,
      'icon': Icons.touch_app,
      'note': 'Finger contact near the top-left of a card.',
    },
    {
      'label': 'Mouse — centre',
      'details': DragStartDetails(
        globalPosition: const Offset(180.0, 140.0),
        localPosition: const Offset(60.0, 40.0),
        sourceTimeStamp: const Duration(milliseconds: 480),
        kind: PointerDeviceKind.mouse,
      ),
      'color': Colors.indigo,
      'icon': Icons.mouse,
      'note': 'Mouse press inside a draggable list tile.',
    },
    {
      'label': 'Stylus — sketch',
      'details': DragStartDetails(
        globalPosition: const Offset(240.0, 90.0),
        localPosition: const Offset(120.0, 30.0),
        sourceTimeStamp: const Duration(milliseconds: 920),
        kind: PointerDeviceKind.stylus,
      ),
      'color': Colors.deepPurple,
      'icon': Icons.edit,
      'note': 'Pen down on a drawing canvas.',
    },
    {
      'label': 'Trackpad — scrub',
      'details': DragStartDetails(
        globalPosition: const Offset(120.0, 220.0),
        localPosition: const Offset(20.0, 100.0),
        sourceTimeStamp: const Duration(milliseconds: 1340),
        kind: PointerDeviceKind.trackpad,
      ),
      'color': Colors.orange,
      'icon': Icons.swipe,
      'note': 'Two-finger trackpad drag in a timeline.',
    },
    {
      'label': 'Inverted stylus',
      'details': DragStartDetails(
        globalPosition: const Offset(300.0, 260.0),
        localPosition: const Offset(180.0, 130.0),
        sourceTimeStamp: const Duration(milliseconds: 1810),
        kind: PointerDeviceKind.invertedStylus,
      ),
      'color': Colors.pink,
      'icon': Icons.brush,
      'note': 'Eraser end of a stylus on a sketchpad.',
    },
    {
      'label': 'Touch — far corner',
      'details': DragStartDetails(
        globalPosition: const Offset(360.0, 320.0),
        localPosition: const Offset(240.0, 200.0),
        sourceTimeStamp: const Duration(milliseconds: 2275),
        kind: PointerDeviceKind.touch,
      ),
      'color': Colors.green,
      'icon': Icons.fingerprint,
      'note': 'Thumb contact at the bottom-right of a tile.',
    },
    {
      'label': 'No timestamp',
      'details': DragStartDetails(
        globalPosition: const Offset(80.0, 300.0),
        localPosition: const Offset(8.0, 180.0),
        kind: PointerDeviceKind.unknown,
      ),
      'color': Colors.blueGrey,
      'icon': Icons.help_outline,
      'note': 'Synthetic event — sourceTimeStamp omitted.',
    },
    {
      'label': 'localPosition default',
      'details': DragStartDetails(
        globalPosition: const Offset(220.0, 50.0),
        // localPosition not given → defaults to globalPosition
        sourceTimeStamp: const Duration(milliseconds: 60),
      ),
      'color': Colors.cyan,
      'icon': Icons.place,
      'note': 'localPosition is omitted; it falls back to globalPosition.',
    },
  ];

  for (final s in samples) {
    final d = s['details'] as DragStartDetails;
    print(
      '${s['label']}: global=${d.globalPosition}, local=${d.localPosition}, '
      'kind=${d.kind}, ts=${d.sourceTimeStamp}',
    );
  }

  // ============================================================
  // SECTION 1: Hero header
  // The hero introduces the class and frames the rest of the demo.
  // ============================================================
  print('=== Section 1: hero header ===');

  final hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF1E3A8A),
          Color(0xFF7C3AED),
          Color(0xFFDB2777),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.pan_tool_alt,
                color: Colors.white,
                size: 44.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'DragStartDetails',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Payload delivered to onDragStart / onPanStart callbacks at the '
          'instant a drag gesture is recognised.  It captures where the '
          'pointer is, both globally and locally, when the drag began, and '
          'which kind of input device produced it.',
          style: TextStyle(fontSize: 14.0, color: Colors.white, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const [
            _HeroPill(text: 'globalPosition', icon: Icons.public),
            _HeroPill(text: 'localPosition', icon: Icons.crop_free),
            _HeroPill(text: 'sourceTimeStamp', icon: Icons.schedule),
            _HeroPill(text: 'kind', icon: Icons.devices),
          ],
        ),
      ],
    ),
  );
  print('Hero built');

  // ============================================================
  // SECTION 2: Anatomy / constructor signature.
  // We render the constructor signature line-by-line, annotating each
  // parameter with its role.  This grounds the rest of the demo.
  // ============================================================
  print('=== Section 2: anatomy ===');

  final anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Constructor anatomy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildAnatomyLine(
          'DragStartDetails({',
          'class begins; all params are named',
          Colors.cyan.shade200,
        ),
        _buildAnatomyLine(
          '  this.sourceTimeStamp,',
          'Duration? — input event timestamp',
          Colors.amber.shade300,
        ),
        _buildAnatomyLine(
          '  this.globalPosition = Offset.zero,',
          'Offset — screen-space contact point',
          Colors.greenAccent.shade100,
        ),
        _buildAnatomyLine(
          '  Offset? localPosition,',
          'defaults to globalPosition if null',
          Colors.lightBlueAccent.shade100,
        ),
        _buildAnatomyLine(
          '  this.kind,',
          'PointerDeviceKind? — touch / mouse / stylus / ...',
          Colors.pinkAccent.shade100,
        ),
        _buildAnatomyLine(
          '})',
          'end of constructor',
          Colors.cyan.shade200,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.cyan.shade800, width: 1.0),
          ),
          child: Text(
            'All four fields are final.  The instance is immutable: once the '
            'gesture system hands you a DragStartDetails, you can read but '
            'never mutate its fields.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy built');

  // ============================================================
  // SECTION 3: Sample-instance gallery.
  // For every entry in `samples` we render a card showing the four
  // fields side by side and a coloured chip for the device kind.
  // ============================================================
  print('=== Section 3: sample gallery ===');

  final galleryCards = <Widget>[];
  for (final s in samples) {
    final d = s['details'] as DragStartDetails;
    final color = s['color'] as Color;
    final icon = s['icon'] as IconData;
    final label = s['label'] as String;
    final note = s['note'] as String;

    galleryCards.add(
      Container(
        width: 260.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.7), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  backgroundColor: color.withValues(alpha: 0.22),
                  child: Icon(icon, color: color, size: 20.0),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _buildFieldRow(
              'global', d.globalPosition.toString(), Colors.green.shade700),
            _buildFieldRow(
              'local', d.localPosition.toString(), Colors.blue.shade700),
            _buildFieldRow(
              'tsμs',
              d.sourceTimeStamp == null
                  ? 'null'
                  : '${d.sourceTimeStamp!.inMilliseconds} ms',
              Colors.orange.shade700,
            ),
            _buildFieldRow(
              'kind',
              d.kind == null ? 'null' : d.kind!.name,
              Colors.purple.shade700,
            ),
            const SizedBox(height: 8.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                note,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color.withValues(alpha: 0.95),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${galleryCards.length} sample cards');

  // ============================================================
  // SECTION 4: Crosshair canvas.
  // We hand all sample globalPositions to a CustomPainter that draws
  // each one as a labelled crosshair on a grid.  This is purely
  // informational — there is no animation.
  // ============================================================
  print('=== Section 4: crosshair canvas ===');

  final crosshairPoints = <_CrosshairPoint>[];
  for (final s in samples) {
    final d = s['details'] as DragStartDetails;
    crosshairPoints.add(_CrosshairPoint(
      offset: d.globalPosition,
      color: s['color'] as Color,
      label: s['label'] as String,
    ));
  }

  final crosshairCanvas = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Colors.indigo.shade700, size: 20.0),
            const SizedBox(width: 6.0),
            Text(
              'globalPosition crosshair canvas',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 360.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade200, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CustomPaint(
              painter: _CrosshairPainter(crosshairPoints),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Each crosshair marks a recorded globalPosition.  In a real app the '
          'plane is the device window, with (0,0) at the top-left.',
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Crosshair canvas built');

  // ============================================================
  // SECTION 5: Field-by-field breakdown cards.
  // One card per field with its purpose, type, default, and the
  // sample values pulled from the gallery.
  // ============================================================
  print('=== Section 5: field breakdown ===');

  final fieldCards = <Widget>[
    _buildFieldCard(
      title: 'globalPosition',
      type: 'Offset',
      defaultValue: 'Offset.zero',
      icon: Icons.public,
      color: Colors.green,
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.green.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      description:
          'Pointer position in screen-space, i.e. relative to the top-left '
          'of the application window.  Useful when a drag has to address '
          'something outside the receiving widget — for example, an '
          'OverlayEntry.',
      samples: [
        for (final s in samples)
          (s['details'] as DragStartDetails).globalPosition.toString(),
      ],
    ),
    _buildFieldCard(
      title: 'localPosition',
      type: 'Offset',
      defaultValue: 'globalPosition (when null)',
      icon: Icons.crop_free,
      color: Colors.blue,
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.blue.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      description:
          'Pointer position in the coordinate space of the widget that '
          'received the gesture.  This is the value you usually want when '
          'placing a marker inside the dragged widget.  When omitted in the '
          'constructor it falls back to globalPosition — that is why test '
          'fixtures often pass only globalPosition.',
      samples: [
        for (final s in samples)
          (s['details'] as DragStartDetails).localPosition.toString(),
      ],
    ),
    _buildFieldCard(
      title: 'sourceTimeStamp',
      type: 'Duration?',
      defaultValue: 'null',
      icon: Icons.schedule,
      color: Colors.orange,
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.orange.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      description:
          'Timestamp of the original pointer event that started the drag, '
          'expressed as a Duration since an arbitrary epoch chosen by the '
          'engine.  It is nullable because synthetic events may omit it.  '
          'Subtract two timestamps to compute deltas — never compare them as '
          'wall-clock times.',
      samples: [
        for (final s in samples)
          () {
            final d = s['details'] as DragStartDetails;
            return d.sourceTimeStamp == null
                ? 'null'
                : '${d.sourceTimeStamp!.inMilliseconds} ms';
          }(),
      ],
    ),
    _buildFieldCard(
      title: 'kind',
      type: 'PointerDeviceKind?',
      defaultValue: 'null',
      icon: Icons.devices,
      color: Colors.purple,
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.purple.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      description:
          'Identifies the input device that originated the drag — touch, '
          'mouse, stylus, invertedStylus, trackpad or unknown.  Use it to '
          'tailor behaviour (e.g. enable hover affordances only for mouse, '
          'or pressure curves only for stylus).',
      samples: [
        for (final s in samples)
          () {
            final d = s['details'] as DragStartDetails;
            return d.kind == null ? 'null' : d.kind!.name;
          }(),
      ],
    ),
  ];
  print('Built ${fieldCards.length} field cards');

  // ============================================================
  // SECTION 6: Time-axis diagram.
  // sourceTimeStamp values from the gallery are placed on a
  // horizontal axis to make their ordering visible.
  // ============================================================
  print('=== Section 6: time-axis diagram ===');

  // Compute time bounds.
  int maxMs = 0;
  for (final s in samples) {
    final d = s['details'] as DragStartDetails;
    final ts = d.sourceTimeStamp;
    if (ts != null && ts.inMilliseconds > maxMs) {
      maxMs = ts.inMilliseconds;
    }
  }
  if (maxMs == 0) {
    maxMs = 1;
  }
  final timelineMarkers = <Widget>[];
  for (final s in samples) {
    final d = s['details'] as DragStartDetails;
    final ts = d.sourceTimeStamp;
    final color = s['color'] as Color;
    final label = s['label'] as String;
    final fraction = ts == null ? 0.0 : ts.inMilliseconds / maxMs;
    timelineMarkers.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 14.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade200,
                          Colors.grey.shade300,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: fraction.clamp(0.0, 1.0),
                    child: Container(
                      height: 14.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.4),
                            color,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.35),
                            blurRadius: 4.0,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 70.0,
              child: Text(
                ts == null ? 'null' : '${ts.inMilliseconds} ms',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final timeAxis = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade100, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.deepOrange.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'sourceTimeStamp on a horizontal axis',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        ...timelineMarkers,
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Bar length = sourceTimeStamp / max(sourceTimeStamp).  Null '
            'timestamps render as zero-length bars.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.deepOrange.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Time-axis built');

  // ============================================================
  // SECTION 7: Recipes — concrete code snippets that create or
  // consume DragStartDetails in real-world Flutter code.
  // ============================================================
  print('=== Section 7: recipes ===');

  final recipes = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.40),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildRecipeBlock(
          title: 'GestureDetector.onPanStart',
          accent: Colors.cyanAccent.shade100,
          code: 'GestureDetector(\n'
              '  onPanStart: (DragStartDetails d) {\n'
              '    print(\'started at \${d.localPosition}\');\n'
              '    setState(() => origin = d.localPosition);\n'
              '  },\n'
              '  child: ...,\n'
              ')',
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          title: 'Horizontal drag — read kind',
          accent: Colors.greenAccent.shade100,
          code: 'GestureDetector(\n'
              '  onHorizontalDragStart: (d) {\n'
              '    final isMouse = d.kind == PointerDeviceKind.mouse;\n'
              '    if (isMouse) cursor = SystemMouseCursors.grabbing;\n'
              '  },\n'
              '  child: ...,\n'
              ')',
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          title: 'Draggable.onDragStarted (bridge)',
          accent: Colors.orangeAccent.shade100,
          code: 'Draggable<T>(\n'
              '  data: payload,\n'
              '  onDragStarted: () {\n'
              '    // No DragStartDetails here — wrap with\n'
              '    // GestureDetector to receive the position.\n'
              '  },\n'
              '  feedback: ...,\n'
              '  child: ...,\n'
              ')',
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          title: 'Constructing for tests',
          accent: Colors.pinkAccent.shade100,
          code: 'final fixture = DragStartDetails(\n'
              '  globalPosition: const Offset(40, 60),\n'
              '  sourceTimeStamp: const Duration(milliseconds: 12),\n'
              '  kind: PointerDeviceKind.touch,\n'
              ');',
        ),
      ],
    ),
  );
  print('Recipes built');

  // ============================================================
  // SECTION 8: Pitfalls.
  // Common mistakes when working with DragStartDetails.
  // ============================================================
  print('=== Section 8: pitfalls ===');

  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildPitfall(
          icon: Icons.swap_horiz,
          color: Colors.red.shade400,
          title: 'Mixing up global and local positions',
          body:
              'globalPosition is in window coordinates, localPosition in widget '
              'coordinates.  Using the wrong one will look correct on small '
              'screens (where they are close) and break on large layouts.',
        ),
        _buildPitfall(
          icon: Icons.timer_off,
          color: Colors.deepOrange.shade400,
          title: 'Treating sourceTimeStamp as wall-clock time',
          body:
              'It is a Duration since an engine epoch, not since the Unix '
              'epoch.  Only differences between two timestamps are meaningful.',
        ),
        _buildPitfall(
          icon: Icons.help_outline,
          color: Colors.orange.shade700,
          title: 'Ignoring null sourceTimeStamp',
          body:
              'Synthetic events (e.g. accessibility, tests) may set it to '
              'null.  Always null-check before reading inMilliseconds.',
        ),
        _buildPitfall(
          icon: Icons.devices_other,
          color: Colors.amber.shade800,
          title: 'Treating kind as non-null',
          body:
              'kind is nullable.  Code that switches on it must handle the '
              'null case (or default to PointerDeviceKind.unknown).',
        ),
        _buildPitfall(
          icon: Icons.edit_off,
          color: Colors.brown.shade400,
          title: 'Trying to mutate the instance',
          body:
              'All four fields are final.  Make a new DragStartDetails if you '
              'need to adjust a value (e.g. for replay tooling).',
        ),
        _buildPitfall(
          icon: Icons.touch_app,
          color: Colors.pink.shade400,
          title: 'Forgetting Draggable does not pass details',
          body:
              'Draggable.onDragStarted has no arguments.  Wrap with a '
              'GestureDetector if you need DragStartDetails.',
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 9: ASCII footer.
  // A monospace, ASCII-art footer that summarises the four fields
  // in a compact, terminal-friendly way.  Pure decoration.
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  const asciiArt = ''
      '+--------------------------------------------------+\n'
      '|              DragStartDetails                    |\n'
      '+--------------------------------------------------+\n'
      '|  globalPosition  : Offset (window)               |\n'
      '|  localPosition   : Offset (widget) — defaults to |\n'
      '|                    globalPosition                |\n'
      '|  sourceTimeStamp : Duration?  (engine epoch)     |\n'
      '|  kind            : PointerDeviceKind?            |\n'
      '+--------------------------------------------------+\n'
      '|   onPanStart  ----+                              |\n'
      '|   onDragStart ----+--->  DragStartDetails        |\n'
      '|   onH/VDragStart -+                              |\n'
      '+--------------------------------------------------+\n';

  final asciiFooter = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.50),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent.shade400, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'tldr — drag_start_details.txt',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.greenAccent.shade400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.greenAccent.shade100,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
  print('ASCII footer built');

  // ============================================================
  // Animation discipline check.
  // Even though this demo has no live motion, we still construct a
  // few AlwaysStoppedAnimation<double> instances and Duration.zero
  // values to demonstrate that the demo respects the "no real
  // animation" rule from the d4rt-flutter-ast convention.
  // ============================================================
  print('=== Animation discipline: AlwaysStoppedAnimation ===');
  final stillProgress = AlwaysStoppedAnimation<double>(0.5);
  final stillFade = AlwaysStoppedAnimation<double>(1.0);
  const stillDuration = Duration.zero;
  print(
    'still: progress=${stillProgress.value} '
    'fade=${stillFade.value} duration=$stillDuration',
  );

  print('DragStartDetails Deep Demo completed successfully');

  // ============================================================
  // Final layout — wrap everything in a MaterialApp / Scaffold.
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hero,
              const SizedBox(height: 24.0),
              _SectionTitle(
                index: '1',
                title: 'Anatomy & constructor signature',
                color: Colors.indigo,
              ),
              anatomy,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '2',
                title: 'Sample-instance gallery',
                color: Colors.teal,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: galleryCards,
              ),
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '3',
                title: 'Crosshair canvas (globalPosition)',
                color: Colors.indigo,
              ),
              crosshairCanvas,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '4',
                title: 'Field-by-field breakdown',
                color: Colors.deepPurple,
              ),
              ...fieldCards,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '5',
                title: 'sourceTimeStamp time-axis',
                color: Colors.deepOrange,
              ),
              timeAxis,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '6',
                title: 'Recipes',
                color: Colors.cyan,
              ),
              recipes,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '7',
                title: 'Pitfalls',
                color: Colors.red,
              ),
              pitfalls,
              const SizedBox(height: 28.0),
              _SectionTitle(
                index: '8',
                title: 'ASCII footer',
                color: Colors.green,
              ),
              asciiFooter,
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// SUPPORT WIDGETS / HELPERS
// ============================================================

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: Colors.white),
          const SizedBox(width: 6.0),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.index,
    required this.title,
    required this.color,
  });
  final String index;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.40),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              index,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Renders one annotated line of the constructor signature.
Widget _buildAnatomyLine(String code, String comment, Color codeColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 240.0,
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: codeColor,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 4.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: codeColor.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            comment,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// Single field row inside a sample-gallery card.
Widget _buildFieldRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 50.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

// Field breakdown card.
Widget _buildFieldCard({
  required String title,
  required String type,
  required String defaultValue,
  required IconData icon,
  required Color color,
  required LinearGradient gradient,
  required String description,
  required List<String> samples,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'default: $defaultValue',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample values from the gallery',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: [
                  for (final v in samples)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        v,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Recipe code block.
Widget _buildRecipeBlock({
  required String title,
  required Color accent,
  required String code,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.grey.shade100,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// Pitfall row.
Widget _buildPitfall({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
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
  );
}

// ============================================================
// Crosshair canvas
// ============================================================

class _CrosshairPoint {
  const _CrosshairPoint({
    required this.offset,
    required this.color,
    required this.label,
  });
  final Offset offset;
  final Color color;
  final String label;
}

class _CrosshairPainter extends CustomPainter {
  _CrosshairPainter(this.points);
  final List<_CrosshairPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    // Background grid.
    final gridPaint = Paint()
      ..color = Colors.indigo.shade100
      ..strokeWidth = 0.6;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Compute scale: map the largest sample coordinate into the canvas.
    double maxX = 1.0;
    double maxY = 1.0;
    for (final p in points) {
      if (p.offset.dx > maxX) maxX = p.offset.dx;
      if (p.offset.dy > maxY) maxY = p.offset.dy;
    }
    final scaleX = (size.width - 40.0) / maxX;
    final scaleY = (size.height - 40.0) / maxY;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    // Draw crosshairs.
    for (final p in points) {
      final cx = 20.0 + p.offset.dx * scale;
      final cy = 20.0 + p.offset.dy * scale;
      final crosshair = Paint()
        ..color = p.color
        ..strokeWidth = 1.6;
      // Horizontal arm.
      canvas.drawLine(
        Offset(cx - 12.0, cy),
        Offset(cx + 12.0, cy),
        crosshair,
      );
      // Vertical arm.
      canvas.drawLine(
        Offset(cx, cy - 12.0),
        Offset(cx, cy + 12.0),
        crosshair,
      );
      // Centre dot with halo.
      final halo = Paint()..color = p.color.withValues(alpha: 0.20);
      canvas.drawCircle(Offset(cx, cy), 10.0, halo);
      final dot = Paint()..color = p.color;
      canvas.drawCircle(Offset(cx, cy), 3.0, dot);

      // Label.
      final tp = TextPainter(
        text: TextSpan(
          text: p.label,
          style: TextStyle(
            color: p.color,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: 140.0);
      tp.paint(canvas, Offset(cx + 12.0, cy + 4.0));

      // Coordinate caption underneath.
      final cap = TextPainter(
        text: TextSpan(
          text: '(${p.offset.dx.toStringAsFixed(0)}, '
              '${p.offset.dy.toStringAsFixed(0)})',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 9.0,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      cap.layout(maxWidth: 140.0);
      cap.paint(canvas, Offset(cx + 12.0, cy + 18.0));
    }

    // Border.
    final border = Paint()
      ..color = Colors.indigo.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
