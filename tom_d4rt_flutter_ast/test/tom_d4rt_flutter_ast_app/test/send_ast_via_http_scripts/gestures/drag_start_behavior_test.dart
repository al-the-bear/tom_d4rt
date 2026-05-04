// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: DragStartBehavior enum from package:flutter/gestures.dart.
// Deep Demo: Visual exploration of DragStartBehavior.down vs DragStartBehavior.start,
// the slop threshold, pointer-trajectory diagrams, side-by-side timelines, common
// recipes (Draggable, Scrollable, Slider) and pitfalls when picking a value.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragStartBehavior Deep Demo executing');

  // ============================================================
  // Enum sanity prints (kept for parity with the canonical stub).
  // ============================================================
  print('DragStartBehavior values:');
  for (final value in DragStartBehavior.values) {
    print('  ${value.name} -> index ${value.index}');
  }
  print('DragStartBehavior has ${DragStartBehavior.values.length} values');

  final firstValue = DragStartBehavior.values.first;
  final lastValue = DragStartBehavior.values.last;
  print('First: $firstValue (index ${firstValue.index})');
  print('Last : $lastValue (index ${lastValue.index})');

  // Map every enum value to a fixed colour palette and didactic copy.
  // Using AlwaysStoppedAnimation<double> so any motion is "frozen" (rule 7).
  final downIntensity = AlwaysStoppedAnimation<double>(1.0);
  final startIntensity = AlwaysStoppedAnimation<double>(1.0);
  final frozenDuration = Duration.zero;
  print('Frozen duration for all motion: $frozenDuration');
  print('Frozen down intensity: ${downIntensity.value}');
  print('Frozen start intensity: ${startIntensity.value}');

  // ============================================================
  // SECTION 1: Hero header
  // ------------------------------------------------------------
  // The header introduces the topic and reminds the reader that
  // DragStartBehavior is purely about *when* a drag is reported
  // as having begun. It does NOT change pointer routing; it only
  // shifts the moment that onDragStart (or its specialisations)
  // fires inside a recogniser's lifecycle.
  // ============================================================
  print('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.deepPurple.shade500,
          Colors.pink.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.pinkAccent.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swipe, color: Colors.white, size: 56.0),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DragStartBehavior',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'When does a drag *officially* begin? On the first contact, or '
          'only after the pointer travels past the slop threshold? Pick the '
          'wrong answer and your draggable jitters; pick the right one and '
          'it feels invisible.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _heroChip('enum', Colors.white24, Colors.white),
            _heroChip('2 values', Colors.white24, Colors.white),
            _heroChip('down', Colors.tealAccent.shade100, Colors.teal.shade900),
            _heroChip('start', Colors.amber.shade100, Colors.brown.shade900),
          ],
        ),
      ],
    ),
  );
  print('Hero header constructed.');

  // ============================================================
  // SECTION 2: Anatomy / enum signature
  // ------------------------------------------------------------
  // Show the literal Dart signature so readers can reason about
  // what the enum *is*. Including the full source-shape (just the
  // declaration, not the implementation) makes the rest of the
  // demo grounded in an actual API rather than a metaphor.
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.menu_book, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'enum signature',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'enum DragStartBehavior {\n'
          '  /// Set the initial offset, at the position where the first\n'
          '  /// down event was detected.\n'
          '  down,\n'
          '\n'
          '  /// Set the initial position at the position where this gesture\n'
          '  /// recognizer wins the arena (after the slop threshold is\n'
          '  /// exceeded).\n'
          '  start,\n'
          '}',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 12.0),
        Text(
          'Both values exist because the gesture arena defers commitment '
          'until enough evidence has accumulated. "down" reports the contact '
          'point; "start" reports the point at which this recogniser won '
          'against its competitors and therefore "really" started dragging.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _signaturePill('values.length', '2', Colors.cyan),
            SizedBox(width: 8.0),
            _signaturePill('first', 'down', Colors.teal),
            SizedBox(width: 8.0),
            _signaturePill('last', 'start', Colors.amber),
          ],
        ),
      ],
    ),
  );
  print('Anatomy block constructed.');

  // ============================================================
  // SECTION 3: Per-value cards
  // ------------------------------------------------------------
  // One large card per enum value. We hand-write copy that
  // contrasts the *moment* each value reports the drag start,
  // and what consequence that has on offset deltas reported to
  // listeners.
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final downCard = _valueCard(
    title: 'DragStartBehavior.down',
    subtitle: 'Fires on first contact',
    accent: Colors.teal,
    icon: Icons.touch_app,
    bullets: const [
      'Initial offset is the pointer-down position.',
      'Subsequent deltas are measured from that exact pixel.',
      'Feels "stuck to the finger" — zero perceived lag.',
      'Risks accidental drags from a tap that drifts a few px.',
    ],
    snippet: 'GestureDetector(\n'
        '  dragStartBehavior: DragStartBehavior.down,\n'
        '  onPanUpdate: (d) => print(d.delta),\n'
        ')',
    timeline: const [
      _TimelineSpec('t=0  ms', 'pointer DOWN     ', 'drag start fires', true),
      _TimelineSpec('t=8  ms', 'pointer move 2px ', 'delta reported  ', false),
      _TimelineSpec('t=24 ms', 'pointer move 18px', 'delta reported  ', false),
    ],
  );

  final startCard = _valueCard(
    title: 'DragStartBehavior.start',
    subtitle: 'Fires after slop threshold',
    accent: Colors.amber.shade800,
    icon: Icons.center_focus_strong,
    bullets: const [
      'Initial offset is the position where the recogniser wins.',
      'Movement before the threshold is *discarded* from deltas.',
      'No accidental drag-while-tapping; cleaner discrimination.',
      'Drag may visibly "snap" to the finger after threshold cross.',
    ],
    snippet: 'GestureDetector(\n'
        '  dragStartBehavior: DragStartBehavior.start,\n'
        '  onPanUpdate: (d) => print(d.delta),\n'
        ')',
    timeline: const [
      _TimelineSpec('t=0  ms', 'pointer DOWN     ', '(no callback)   ', false),
      _TimelineSpec('t=8  ms', 'pointer move 2px ', '(no callback)   ', false),
      _TimelineSpec('t=24 ms', 'pointer move 18px', 'drag start fires', true),
    ],
  );
  print('Per-value cards constructed.');

  // ============================================================
  // SECTION 4: Pointer-trajectory CustomPainter
  // ------------------------------------------------------------
  // Draws the slop circle and a sample pointer trajectory across
  // it. The circle is the "kTouchSlop" radius; once the pointer
  // crosses it, that's the moment DragStartBehavior.start would
  // fire. DragStartBehavior.down would fire at the centre dot.
  // ============================================================
  print('=== Section 4: Pointer trajectory painter ===');

  final trajectory = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade100.withValues(alpha: 0.6),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pointer trajectory & slop threshold',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The dotted ring is the slop radius (~18 logical px). '
          '"down" fires at the centre dot; "start" fires the instant the '
          'pointer crosses the ring.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.indigo.shade800,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Center(
          child: SizedBox(
            width: 320.0,
            height: 220.0,
            child: CustomPaint(
              painter: _SlopPainter(
                slopRadius: 60.0,
                trajectory: const [
                  Offset(0.0, 0.0),
                  Offset(8.0, -4.0),
                  Offset(20.0, -10.0),
                  Offset(36.0, -18.0),
                  Offset(58.0, -28.0),
                  Offset(82.0, -36.0),
                  Offset(110.0, -42.0),
                ],
                downColor: Colors.teal,
                startColor: Colors.amber.shade800,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _legendDot(Colors.teal, 'down fires here'),
            SizedBox(width: 16.0),
            _legendDot(Colors.amber.shade800, 'start fires here'),
            SizedBox(width: 16.0),
            _legendDot(Colors.grey.shade600, 'slop boundary'),
          ],
        ),
      ],
    ),
  );
  print('Trajectory painter built.');

  // ============================================================
  // SECTION 5: Side-by-side timeline comparison
  // ------------------------------------------------------------
  // Both behaviours plotted against the same wall-clock so the
  // reader can see exactly which frames produce callbacks under
  // each setting. Helpful for debugging "why did onDragStart not
  // fire on the first frame?" type questions.
  // ============================================================
  print('=== Section 5: Side-by-side timeline ===');

  final timeline = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade100.withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Side-by-side timeline',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _timelineColumn(
                'down',
                Colors.teal,
                const [
                  _TickSpec(0, 'DOWN', true),
                  _TickSpec(1, 'move +2px', false),
                  _TickSpec(2, 'move +6px', false),
                  _TickSpec(3, 'move +12px', false),
                  _TickSpec(4, 'move +18px', false),
                  _TickSpec(5, 'move +24px', false),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _timelineColumn(
                'start',
                Colors.amber.shade800,
                const [
                  _TickSpec(0, 'DOWN (silent)', false),
                  _TickSpec(1, 'move +2px', false),
                  _TickSpec(2, 'move +6px', false),
                  _TickSpec(3, 'move +12px', false),
                  _TickSpec(4, 'CROSS slop', true),
                  _TickSpec(5, 'move +24px', false),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Filled circles mark frames that produced a drag-start callback. '
            'Notice "down" emits on frame 0 immediately; "start" stays silent '
            'until the pointer crosses the slop boundary on frame 4.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Timeline comparison built.');

  // ============================================================
  // SECTION 6: Recipes — Draggable, Scrollable, Slider
  // ------------------------------------------------------------
  // Concrete copy-pasteable patterns for the three widgets that
  // most often expose dragStartBehavior. Each recipe explains
  // *why* a particular default is sensible.
  // ============================================================
  print('=== Section 6: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.shade100.withValues(alpha: 0.6),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipes',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _recipe(
          'Draggable<T>',
          'Use start so a quick tap on the chip never accidentally '
              'starts dragging. The user pays a few milliseconds for clarity.',
          'Draggable<int>(\n'
              '  data: 42,\n'
              '  dragStartBehavior: DragStartBehavior.start,\n'
              '  feedback: Material(child: Chip(label: Text("42"))),\n'
              '  child: Chip(label: Text("42")),\n'
              ')',
          Colors.green.shade800,
        ),
        SizedBox(height: 10.0),
        _recipe(
          'Scrollable / ListView',
          'Use down for buttery, glued-to-finger scrolling. The slop '
              'is enforced by the gesture arena anyway, but the offset '
              'should align with the pointer-down position.',
          'ListView(\n'
              '  dragStartBehavior: DragStartBehavior.down,\n'
              '  children: items,\n'
              ')',
          Colors.green.shade800,
        ),
        SizedBox(height: 10.0),
        _recipe(
          'Slider',
          'Sliders default to start so a tap on the track jumps cleanly '
              'to the new value without smearing through the slop region.',
          'Slider(\n'
              '  value: v, min: 0, max: 100,\n'
              '  dragStartBehavior: DragStartBehavior.start,\n'
              '  onChanged: (x) => setState(() => v = x),\n'
              ')',
          Colors.green.shade800,
        ),
      ],
    ),
  );
  print('Recipes constructed.');

  // ============================================================
  // SECTION 7: Pitfalls
  // ------------------------------------------------------------
  // Concrete failure modes, each tagged with the symptom the
  // user/customer is most likely to report. These are drawn from
  // real bug threads in the Flutter issue tracker.
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pitfalls',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _pitfall(
          symptom: 'My item jumps the moment I touch it',
          cause: 'down was used on a Draggable; the first delta includes '
              'the finger\'s natural micro-jitter at contact time.',
          fix: 'Switch to DragStartBehavior.start — the recogniser '
              'discards pre-arena movement.',
        ),
        SizedBox(height: 10.0),
        _pitfall(
          symptom: 'Slider snaps weirdly far on tap',
          cause: 'down was forced on a Slider; the initial delta is '
              'computed from the finger\'s landing point, then immediately '
              'mapped to the track value.',
          fix: 'Stick with the default DragStartBehavior.start so the '
              'value tracks finger movement, not finger contact.',
        ),
        SizedBox(height: 10.0),
        _pitfall(
          symptom: 'List scrolls feel laggy after the first frame',
          cause: 'start was used on a Scrollable; the first ~18px of '
              'movement are silently absorbed.',
          fix: 'Use DragStartBehavior.down for scrollables so the '
              'content moves in lockstep with the finger from frame 0.',
        ),
        SizedBox(height: 10.0),
        _pitfall(
          symptom: 'Tests using flutter_test\'s drag() seem off-by-slop',
          cause: 'WidgetTester.drag uses kDragSlopDefault. If the widget '
              'under test mixes down with start, callbacks may double-fire '
              'or miss.',
          fix: 'Pin dragStartBehavior explicitly in the widget under test '
              'and pass touchSlopX / touchSlopY arguments where needed.',
        ),
      ],
    ),
  );
  print('Pitfalls block constructed.');

  // ============================================================
  // SECTION 8: Comparison matrix
  // ------------------------------------------------------------
  // A compact, scannable table that summarises every dimension
  // we discussed above. Useful as a "cheat sheet" once the rest
  // of the demo has been read.
  // ============================================================
  print('=== Section 8: Comparison matrix ===');

  final matrix = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comparison matrix',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        _matrixRow(
          ['Dimension', 'down', 'start'],
          isHeader: true,
        ),
        _matrixRow(const [
          'Initial offset',
          'pointer-down position',
          'arena-win position',
        ]),
        _matrixRow(const [
          'First callback',
          'frame 0',
          'after slop crossed',
        ]),
        _matrixRow(const [
          'Pre-slop deltas',
          'reported',
          'discarded',
        ]),
        _matrixRow(const [
          'Feel',
          'sticky / immediate',
          'crisp / discrete',
        ]),
        _matrixRow(const [
          'Best for',
          'Scrollables, drawing',
          'Draggable, Slider',
        ]),
        _matrixRow(const [
          'Risk',
          'accidental drag on tap',
          'visible snap to finger',
        ]),
        _matrixRow(const [
          'Test impact',
          'flutter_test ok',
          'tune touchSlopX/Y',
        ]),
      ],
    ),
  );
  print('Comparison matrix constructed.');

  // ============================================================
  // SECTION 9: ASCII footer
  // ------------------------------------------------------------
  // A monospaced sketch summarising the slop boundary, the two
  // firing moments, and a tidy sign-off. Hand-drawn ASCII has
  // historically aged better than any rasterised diagram.
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  final footer = Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'ascii sketch',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '          + - - - - - - - - +\n'
          '         /                   \\\n'
          '        /        SLOP         \\\n'
          '       (    o\u2014\u2014\u2014\u2014\u2014\u2014\u2014>X     )   X = start fires here\n'
          '        \\        |            /    o = down fires here\n'
          '         \\       |           /\n'
          '          + - - -|- - - - - +\n'
          '                 |\n'
          '            pointer-down\n'
          '\n'
          '  down  : initial offset = o, deltas measured from o\n'
          '  start : initial offset = X, deltas measured from X\n'
          '\n'
          '  Choose down  for scrollables, sketching surfaces.\n'
          '  Choose start for draggables, sliders, drag-handles.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade100,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          '— end of DragStartBehavior deep demo —',
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
            fontSize: 12.0,
          ),
        ),
      ],
    ),
  );
  print('ASCII footer constructed.');

  print('DragStartBehavior Deep Demo completed successfully');

  // ============================================================
  // Compose the final tree. Per requirement #4 the build returns
  // a MaterialApp -> Scaffold -> body. No interaction widgets.
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 24.0),
              _sectionTitle('1. Anatomy & enum signature'),
              anatomy,
              SizedBox(height: 24.0),
              _sectionTitle('2. Per-value cards'),
              downCard,
              SizedBox(height: 12.0),
              startCard,
              SizedBox(height: 24.0),
              _sectionTitle('3. Pointer trajectory & slop'),
              trajectory,
              SizedBox(height: 24.0),
              _sectionTitle('4. Side-by-side timeline'),
              timeline,
              SizedBox(height: 24.0),
              _sectionTitle('5. Recipes'),
              recipes,
              SizedBox(height: 24.0),
              _sectionTitle('6. Pitfalls'),
              pitfalls,
              SizedBox(height: 24.0),
              _sectionTitle('7. Comparison matrix'),
              matrix,
              SizedBox(height: 24.0),
              _sectionTitle('8. ASCII summary'),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

// ===============================================================
// Helper widgets & data classes below.
// ===============================================================

class _TimelineSpec {
  final String t;
  final String pointer;
  final String callback;
  final bool fires;
  const _TimelineSpec(this.t, this.pointer, this.callback, this.fires);
}

class _TickSpec {
  final int frame;
  final String label;
  final bool fires;
  const _TickSpec(this.frame, this.label, this.fires);
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0, top: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.indigo.shade900,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _heroChip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: fg,
      ),
    ),
  );
}

Widget _signaturePill(String key, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$key:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white12, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _valueCard({
  required String title,
  required String subtitle,
  required Color accent,
  required IconData icon,
  required List<String> bullets,
  required String snippet,
  required List<_TimelineSpec> timeline,
}) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 28.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: accent.withValues(alpha: 0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final bullet in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, size: 16.0, color: accent),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black87,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 12.0),
        _codeBlock(snippet, Colors.greenAccent.shade100),
        SizedBox(height: 12.0),
        Text(
          'frame-by-frame:',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 6.0),
        for (final spec in timeline)
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: spec.fires
                  ? accent.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: spec.fires ? accent : Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  spec.fires ? Icons.flash_on : Icons.radio_button_unchecked,
                  size: 14.0,
                  color: spec.fires ? accent : Colors.grey.shade500,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '${spec.t}  |  ${spec.pointer}  ->  ${spec.callback}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.black87,
                      fontWeight:
                          spec.fires ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _legendDot(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 6.0),
      Text(text, style: TextStyle(fontSize: 11.0, color: Colors.black87)),
    ],
  );
}

Widget _timelineColumn(String title, Color accent, List<_TickSpec> ticks) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.20),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DragStartBehavior.$title',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 10.0),
        for (final tick in ticks)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: tick.fires ? accent : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: accent, width: 2.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  'f${tick.frame}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    tick.label,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black87,
                      fontWeight:
                          tick.fires ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _recipe(String title, String body, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restaurant_menu, color: accent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: accent,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required String symptom,
  required String cause,
  required String fix,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                symptom,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: 'cause: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              TextSpan(text: cause),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: 'fix: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              TextSpan(text: fix),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _matrixRow(List<String> cells, {bool isHeader = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: isHeader
          ? Colors.cyan.shade200.withValues(alpha: 0.6)
          : Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: isHeader ? Colors.cyan.shade700 : Colors.cyan.shade100,
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            cells[0],
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.w900 : FontWeight.w600,
              fontSize: 12.0,
              color: Colors.cyan.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[1],
            style: TextStyle(
              fontFamily: isHeader ? null : 'monospace',
              fontWeight: isHeader ? FontWeight.w900 : FontWeight.normal,
              fontSize: 12.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[2],
            style: TextStyle(
              fontFamily: isHeader ? null : 'monospace',
              fontWeight: isHeader ? FontWeight.w900 : FontWeight.normal,
              fontSize: 12.0,
              color: Colors.orange.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SlopPainter extends CustomPainter {
  final double slopRadius;
  final List<Offset> trajectory;
  final Color downColor;
  final Color startColor;

  _SlopPainter({
    required this.slopRadius,
    required this.trajectory,
    required this.downColor,
    required this.startColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.35, size.height * 0.6);

    // Background grid for context.
    final gridPaint = Paint()
      ..color = Colors.indigo.shade100
      ..strokeWidth = 0.6;
    for (double x = 0; x <= size.width; x += 16.0) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += 16.0) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Slop ring (dotted-ish: short arc segments).
    final ringPaint = Paint()
      ..color = Colors.grey.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    const segments = 32;
    for (var i = 0; i < segments; i += 2) {
      final a0 = (i / segments) * 6.2831853;
      final a1 = ((i + 1) / segments) * 6.2831853;
      final p0 = Offset(
        center.dx + slopRadius * _cosApprox(a0),
        center.dy + slopRadius * _sinApprox(a0),
      );
      final p1 = Offset(
        center.dx + slopRadius * _cosApprox(a1),
        center.dy + slopRadius * _sinApprox(a1),
      );
      canvas.drawLine(p0, p1, ringPaint);
    }

    // Trajectory polyline.
    final pathPaint = Paint()
      ..color = Colors.indigo.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < trajectory.length - 1; i++) {
      final p0 = center + trajectory[i];
      final p1 = center + trajectory[i + 1];
      canvas.drawLine(p0, p1, pathPaint);
    }

    // Trajectory sample dots.
    final dotPaint = Paint()..color = Colors.indigo.shade300;
    for (final t in trajectory) {
      canvas.drawCircle(center + t, 2.5, dotPaint);
    }

    // "down" marker at centre.
    final downPaint = Paint()..color = downColor;
    canvas.drawCircle(center, 7.0, downPaint);
    final downRing = Paint()
      ..color = downColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, 12.0, downRing);

    // Find first trajectory point outside the slop ring -> "start" marker.
    Offset? crossing;
    for (final t in trajectory) {
      final d = _hypotApprox(t.dx, t.dy);
      if (d >= slopRadius) {
        crossing = center + t;
        break;
      }
    }
    if (crossing != null) {
      final startPaint = Paint()..color = startColor;
      canvas.drawCircle(crossing, 7.0, startPaint);
      final startRing = Paint()
        ..color = startColor.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(crossing, 12.0, startRing);
    }
  }

  // Lightweight trig substitutes so the script stays standalone-friendly.
  double _cosApprox(double a) {
    // Taylor around 0 with periodic reduction.
    var x = a % 6.2831853;
    if (x > 3.1415926) x -= 6.2831853;
    final x2 = x * x;
    return 1 - x2 / 2 + (x2 * x2) / 24 - (x2 * x2 * x2) / 720;
  }

  double _sinApprox(double a) {
    var x = a % 6.2831853;
    if (x > 3.1415926) x -= 6.2831853;
    final x2 = x * x;
    return x - (x * x2) / 6 + (x * x2 * x2) / 120 - (x * x2 * x2 * x2) / 5040;
  }

  double _hypotApprox(double x, double y) {
    // Simple sqrt via Newton iteration to avoid dart:math dependency in
    // the trimmed d4rt sandbox; converges very fast for our magnitudes.
    final s = x * x + y * y;
    if (s == 0) return 0;
    var r = s;
    for (var i = 0; i < 8; i++) {
      r = 0.5 * (r + s / r);
    }
    return r;
  }

  @override
  bool shouldRepaint(covariant _SlopPainter old) =>
      old.slopRadius != slopRadius ||
      old.trajectory != trajectory ||
      old.downColor != downColor ||
      old.startColor != startColor;
}
