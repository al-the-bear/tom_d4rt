// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests GestureDisposition from package:flutter/gestures.dart
// Deep Demo: Visual demonstration of the GestureDisposition enum, the gesture
// arena, and how recognizers vote to take ownership of pointer streams.
//
// GestureDisposition is the smallest yet most consequential enum in Flutter's
// gesture system. With only two values (`accepted` and `rejected`) it controls
// the entire arbitration protocol that decides which recognizer gets to claim
// a pointer sequence. This file demonstrates the enum surface, the arena
// resolution flow, contestant cards, recipes, and the most common pitfalls.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureDisposition Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero Header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.touch_app, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'GestureDisposition',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How recognizers claim or release a pointer in the arena',
          style: TextStyle(fontSize: 14.0, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white54, width: 1.0),
          ),
          child: Text(
            'package:flutter/gestures.dart',
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
  print('Hero header constructed');

  // ============================================================
  // SECTION 2: Anatomy & Enum Signature
  // ============================================================
  print('=== Section 2: Anatomy ===');

  for (final value in GestureDisposition.values) {
    print('GestureDisposition.${value.name} - index ${value.index}');
  }
  print('Total values: ${GestureDisposition.values.length}');

  final anatomyBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Enum Signature',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'enum GestureDisposition {\n'
          '  accepted, // I want this pointer sequence\n'
          '  rejected, // I do not want this pointer sequence\n'
          '}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'A recognizer reports its decision to the GestureArenaManager via '
          'resolve(). The arena collects every contestant\'s vote and decides '
          'who - if anyone - wins the pointer sequence.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.4),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildBadge('Total values', '${GestureDisposition.values.length}',
                Colors.purpleAccent),
            _buildBadge('First',
                GestureDisposition.values.first.name, Colors.greenAccent),
            _buildBadge('Last',
                GestureDisposition.values.last.name, Colors.redAccent),
            _buildBadge('Type', 'enum', Colors.amberAccent),
          ],
        ),
      ],
    ),
  );
  print('Anatomy block constructed');

  // ============================================================
  // SECTION 3: Per-Value Cards
  // ============================================================
  print('=== Section 3: Per-Value Cards ===');

  final dispositionCards = <Widget>[];
  final dispositionData = [
    {
      'value': GestureDisposition.accepted,
      'icon': Icons.thumb_up,
      'color': Colors.green,
      'tagline': 'I claim this pointer',
      'detail':
          'The recognizer is confident the gesture matches. The arena sweeps '
              'and assigns the pointer sequence to this contestant. All other '
              'contestants for the same pointer are forced to reject.',
      'callsite': 'resolve(GestureDisposition.accepted)',
      'progress': 1.0,
    },
    {
      'value': GestureDisposition.rejected,
      'icon': Icons.do_not_disturb,
      'color': Colors.red,
      'tagline': 'I am out of the running',
      'detail':
          'The recognizer is sure this pointer sequence is not its gesture. '
              'It withdraws from the arena, freeing the pointer for others. '
              'If a recognizer is the last one standing, it wins by default.',
      'callsite': 'resolve(GestureDisposition.rejected)',
      'progress': 0.0,
    },
  ];

  for (final data in dispositionData) {
    final value = data['value'] as GestureDisposition;
    final color = data['color'] as MaterialColor;
    final progress = data['progress'] as double;
    final progressAnim = AlwaysStoppedAnimation<double>(progress);
    print(
        'Card: GestureDisposition.${value.name} -> ${data['tagline']}');
    dispositionCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 12.0,
              offset: Offset(0.0, 6.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
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
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child:
                      Icon(data['icon'] as IconData, color: color, size: 32.0),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GestureDisposition.${value.name}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        'index: ${value.index}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                data['tagline'] as String,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              data['detail'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            SizedBox(height: 14.0),
            // Animated-but-stationary progress bar showing claim level.
            Container(
              height: 10.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progressAnim.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.shade300, color.shade700],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                data['callsite'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${dispositionCards.length} disposition cards');

  // ============================================================
  // SECTION 4: Gesture Arena Diagram (CustomPainter)
  // ============================================================
  print('=== Section 4: Gesture Arena Diagram ===');

  final arenaDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stadium, color: Colors.orange.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'The Gesture Arena',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A pointer down opens an arena. Recognizers join as contestants. '
          'Each may resolve(accepted) or resolve(rejected) at any time.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Colors.brown.shade700),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 220.0,
          child: CustomPaint(
            painter: _ArenaPainter(
              progress: AlwaysStoppedAnimation<double>(1.0).value,
            ),
            child: Container(),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: [
            _buildContestantChip('Tap', Colors.green, true),
            _buildContestantChip('DoubleTap', Colors.red, false),
            _buildContestantChip('LongPress', Colors.red, false),
            _buildContestantChip('HorizontalDrag', Colors.red, false),
            _buildContestantChip('VerticalDrag', Colors.red, false),
          ],
        ),
      ],
    ),
  );
  print('Arena diagram constructed');

  // ============================================================
  // SECTION 5: Decision Flow Timeline
  // ============================================================
  print('=== Section 5: Decision Flow Timeline ===');

  final timelineSteps = <Map<String, Object>>[
    {
      't': '0 ms',
      'event': 'Pointer down',
      'detail': 'A finger touches the screen. The framework opens an arena.',
      'color': Colors.blueGrey,
      'icon': Icons.fiber_manual_record,
    },
    {
      't': '1 ms',
      'event': 'Recognizers join',
      'detail':
          'Tap, DoubleTap, LongPress, HorizontalDrag, VerticalDrag enter.',
      'color': Colors.indigo,
      'icon': Icons.group_add,
    },
    {
      't': '8 ms',
      'event': 'HorizontalDrag rejects',
      'detail':
          'Movement is mostly vertical. resolve(GestureDisposition.rejected).',
      'color': Colors.red,
      'icon': Icons.do_not_disturb,
    },
    {
      't': '15 ms',
      'event': 'DoubleTap rejects',
      'detail':
          'No prior tap was recorded. resolve(GestureDisposition.rejected).',
      'color': Colors.red,
      'icon': Icons.do_not_disturb,
    },
    {
      't': '40 ms',
      'event': 'Pointer up',
      'detail': 'Finger lifts. Tap is eligible to claim the pointer.',
      'color': Colors.amber,
      'icon': Icons.fiber_smart_record,
    },
    {
      't': '41 ms',
      'event': 'Tap accepts',
      'detail':
          'resolve(GestureDisposition.accepted). Tap wins, others swept out.',
      'color': Colors.green,
      'icon': Icons.thumb_up,
    },
    {
      't': '42 ms',
      'event': 'onTap fires',
      'detail': 'The TapGestureRecognizer dispatches the gesture callback.',
      'color': Colors.teal,
      'icon': Icons.celebration,
    },
  ];

  final timeline = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.teal.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.teal.shade800),
            SizedBox(width: 8.0),
            Text(
              'Resolution Timeline',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (int i = 0; i < timelineSteps.length; i++)
          _buildTimelineRow(
            timelineSteps[i],
            isLast: i == timelineSteps.length - 1,
          ),
      ],
    ),
  );
  print('Timeline constructed with ${timelineSteps.length} steps');

  // ============================================================
  // SECTION 6: Recipes (resolve / acceptGesture / rejectGesture)
  // ============================================================
  print('=== Section 6: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
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
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.amberAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipe Gallery',
              style: TextStyle(
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeCard(
          'Recipe 1: resolve()',
          'Most common path. From inside a custom recognizer, vote in the arena.',
          'class MyRecognizer extends OneSequenceGestureRecognizer {\n'
              '  @override\n'
              '  void handleEvent(PointerEvent event) {\n'
              '    if (matchesMyGesture(event)) {\n'
              '      resolve(GestureDisposition.accepted);\n'
              '    } else if (cannotPossiblyMatch(event)) {\n'
              '      resolve(GestureDisposition.rejected);\n'
              '    }\n'
              '  }\n'
              '}',
          Colors.greenAccent,
        ),
        SizedBox(height: 14.0),
        _buildRecipeCard(
          'Recipe 2: acceptGesture()',
          'Called by the arena when YOU win. Trigger your callback here.',
          '@override\n'
              'void acceptGesture(int pointer) {\n'
              '  // We won the arena - fire the callback.\n'
              '  if (onMyGesture != null) {\n'
              '    invokeCallback("onMyGesture", onMyGesture!);\n'
              '  }\n'
              '}',
          Colors.cyanAccent,
        ),
        SizedBox(height: 14.0),
        _buildRecipeCard(
          'Recipe 3: rejectGesture()',
          'Called by the arena when YOU lose. Clean up state.',
          '@override\n'
              'void rejectGesture(int pointer) {\n'
              '  // Someone else won - reset.\n'
              '  _candidatePointer = null;\n'
              '  _stopTracker();\n'
              '}',
          Colors.pinkAccent,
        ),
        SizedBox(height: 14.0),
        _buildRecipeCard(
          'Recipe 4: Eager accept via GestureRecognizer.resolve',
          'Some recognizers (PanGestureRecognizer over slop threshold) resolve '
              'eagerly the moment they exceed their detection threshold.',
          'if (deltaSinceStart.distance > kTouchSlop) {\n'
              '  resolve(GestureDisposition.accepted);\n'
              '} // ...otherwise stay in the arena and keep listening',
          Colors.amberAccent,
        ),
      ],
    ),
  );
  print('Recipe gallery constructed');

  // ============================================================
  // SECTION 7: Pitfalls (race conditions, eager vs lazy)
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & Anti-Patterns',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildPitfallTile(
          'Race conditions',
          'Two recognizers both call resolve(GestureDisposition.accepted) in '
              'the same microtask. The arena resolves in registration order, '
              'so the later recognizer\'s acceptance is converted to a '
              'rejection. Make sure callbacks do not assume both will fire.',
          Icons.flash_on,
          Colors.red,
        ),
        _buildPitfallTile(
          'Eager vs lazy acceptance',
          'Eager recognizers (drag, scale) accept as soon as their threshold '
              'is met. Lazy recognizers (tap) wait for pointer-up. Mixing '
              'them inside the same widget can cause the eager one to always '
              'win, suppressing taps unexpectedly.',
          Icons.speed,
          Colors.deepOrange,
        ),
        _buildPitfallTile(
          'Forgetting to call resolve()',
          'A recognizer that never resolves keeps the pointer stuck in the '
              'arena until the sequence ends. The arena will sweep on '
              'pointer-up, but onTap-style callbacks may misfire.',
          Icons.bug_report,
          Colors.amber,
        ),
        _buildPitfallTile(
          'Resolving twice',
          'After resolve() is called once, subsequent calls are ignored. Do '
              'not rely on resolve(rejected) "undoing" a previous accepted.',
          Icons.repeat,
          Colors.purple,
        ),
        _buildPitfallTile(
          'GestureDetector vs RawGestureDetector',
          'GestureDetector wires up standard recognizers. To customize the '
              'arena vote (e.g. always accept) you must drop down to '
              'RawGestureDetector with a custom GestureFactory.',
          Icons.build,
          Colors.indigo,
        ),
      ],
    ),
  );
  print('Pitfalls constructed');

  // ============================================================
  // SECTION 8: Comparison / Usage Table
  // ============================================================
  print('=== Section 8: Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.grey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'accepted vs rejected at a glance',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Aspect', 130.0),
              _buildHeaderCell('accepted', 110.0),
              _buildHeaderCell('rejected', 110.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildTableRow('Meaning', 'I claim the pointer', 'I withdraw'),
        _buildTableRow('Effect on others', 'They are forced to reject',
            'No direct effect'),
        _buildTableRow('When called', 'Threshold met / pointer up',
            'Cannot match anymore'),
        _buildTableRow('Triggers callback', 'Yes - acceptGesture()',
            'No - rejectGesture()'),
        _buildTableRow(
            'Reversible', 'Subsequent calls ignored', 'Subsequent calls ignored'),
        _buildTableRow('Sweep behavior', 'Sweeps competitors',
            'Self-removes from arena'),
        _buildTableRow('Common example', 'Tap on pointer-up',
            'Drag dropped below slop'),
      ],
    ),
  );
  print('Comparison table constructed');

  // ============================================================
  // SECTION 9: ASCII Footer
  // ============================================================
  print('=== Section 9: ASCII Footer ===');

  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '/* GestureDisposition - quick reference */',
          style: TextStyle(
            color: Colors.green.shade300,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          '+--------------------------------------------------+\n'
          '|             GESTURE ARENA RESOLUTION             |\n'
          '+--------------------------------------------------+\n'
          '|                                                  |\n'
          '|  Pointer down --> [Arena opens]                  |\n'
          '|                                                  |\n'
          '|  Recognizers --> resolve(accepted | rejected)    |\n'
          '|                                                  |\n'
          '|  +----------+        +----------+                |\n'
          '|  |  TAP     | -----> | accepted | -> WINS        |\n'
          '|  +----------+        +----------+                |\n'
          '|  |  DRAG    | -----> | rejected | -> OUT         |\n'
          '|  +----------+        +----------+                |\n'
          '|  |  LONG    | -----> | rejected | -> OUT         |\n'
          '|  +----------+        +----------+                |\n'
          '|                                                  |\n'
          '|  acceptGesture(pointer) on winner                |\n'
          '|  rejectGesture(pointer) on losers                |\n'
          '|                                                  |\n'
          '+--------------------------------------------------+',
          style: TextStyle(
            color: Colors.cyan.shade200,
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.25,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Icon(Icons.info_outline,
                color: Colors.amberAccent, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Two values. One arena. Every pointer in Flutter passes '
                'through this enum.',
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('ASCII footer constructed');

  print('GestureDisposition Deep Demo completed successfully');

  // ============================================================
  // Final assembly
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            Text(
              '1. Anatomy & Enum Signature',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'GestureDisposition is a tiny enum, but it is the contract '
              'between gesture recognizers and the gesture arena. Each '
              'recognizer must eventually emit one of these two values per '
              'pointer sequence so that the arena can decide a winner.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            anatomyBlock,
            SizedBox(height: 24.0),
            Text(
              '2. Per-Value Cards',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Each value carries its own intent. Below the cards show the '
              'idiomatic call site, the visual claim level (zero for '
              'rejected, full for accepted), and a short explanation.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: dispositionCards,
            ),
            SizedBox(height: 24.0),
            Text(
              '3. The Gesture Arena',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'The arena is the umpire. It collects every recognizer\'s '
              'disposition for a single pointer and decides the winner. '
              'The diagram below uses CustomPainter to draw the arena ring '
              'with all five contestants. Only one (Tap) is accepted; the '
              'others have already rejected.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            arenaDiagram,
            SizedBox(height: 24.0),
            Text(
              '4. Decision Flow Timeline',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Resolution unfolds over a few milliseconds. Each row in the '
              'timeline is a discrete event: pointer down, contestant join, '
              'rejection, acceptance, and finally callback dispatch.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            timeline,
            SizedBox(height: 24.0),
            Text(
              '5. Recipes',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'These four recipes cover 99% of real-world recognizer code: '
              'how to vote, what to do on win, what to do on loss, and the '
              'eager-accept pattern used by drags and scales.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            recipes,
            SizedBox(height: 24.0),
            Text(
              '6. Pitfalls',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Most arena bugs come from a handful of repeating mistakes. '
              'Read these before writing a custom recognizer.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            pitfalls,
            SizedBox(height: 24.0),
            Text(
              '7. Comparison Table',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Side-by-side reference of the two values. Use this when you '
              'need a quick refresher inside a code review.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            comparisonTable,
            SizedBox(height: 24.0),
            Text(
              '8. ASCII Footer',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pin this diagram to your wall.',
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
            ),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _buildBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildContestantChip(String name, MaterialColor color, bool winner) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade100, color.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade700, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          winner ? Icons.emoji_events : Icons.do_not_disturb,
          color: color.shade900,
          size: 14.0,
        ),
        SizedBox(width: 6.0),
        Text(
          name,
          style: TextStyle(
            color: color.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          winner ? 'accepted' : 'rejected',
          style: TextStyle(
            color: color.shade900,
            fontFamily: 'monospace',
            fontSize: 10.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineRow(Map<String, Object> step, {required bool isLast}) {
  final color = step['color'] as Color;
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(step['icon'] as IconData, color: color, size: 18.0),
            ),
            if (!isLast)
              Expanded(
                child: Container(
                  width: 2.0,
                  color: color.withValues(alpha: 0.4),
                ),
              ),
          ],
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0.0 : 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        step['t'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        step['event'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  step['detail'] as String,
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard(
  String title,
  String prose,
  String code,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
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
            color: accent,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          prose,
          style: TextStyle(color: Colors.white70, fontSize: 12.0, height: 1.4),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: accent,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallTile(
  String title,
  String detail,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                detail,
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
  );
}

Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _buildTableRow(String aspect, String accepted, String rejected) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            aspect,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            accepted,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade800),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            rejected,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.red.shade800),
          ),
        ),
      ],
    ),
  );
}

// CustomPainter for the gesture arena diagram. Draws a circular ring with
// five contestant nodes - the green one (Tap) is the winner, the rest are
// rejected.
class _ArenaPainter extends CustomPainter {
  _ArenaPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final radius = (size.shortestSide / 2.0) - 30.0;

    // Outer ring (arena boundary).
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..shader = LinearGradient(
        colors: [Colors.orange.shade300, Colors.amber.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, ringPaint);

    // Inner soft fill.
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber.shade50.withValues(alpha: 0.6);
    canvas.drawCircle(center, radius - 4.0, fillPaint);

    // Center label "ARENA".
    final tp = TextPainter(
      text: TextSpan(
        text: 'ARENA',
        style: TextStyle(
          color: Colors.orange.shade900,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2.0, tp.height / 2.0));

    // Sub-label.
    final sub = TextPainter(
      text: TextSpan(
        text: 'pointer #1',
        style: TextStyle(
          color: Colors.brown.shade600,
          fontSize: 10.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    sub.paint(
      canvas,
      center - Offset(sub.width / 2.0, sub.height / 2.0 - 16.0),
    );

    // Five contestants arranged around the ring.
    final contestants = <_ArenaContestant>[
      _ArenaContestant('Tap', Colors.green, true),
      _ArenaContestant('DoubleTap', Colors.red, false),
      _ArenaContestant('LongPress', Colors.red, false),
      _ArenaContestant('HDrag', Colors.red, false),
      _ArenaContestant('VDrag', Colors.red, false),
    ];

    for (int i = 0; i < contestants.length; i++) {
      final angle = (-90.0 + (360.0 / contestants.length) * i) *
          3.1415926535 /
          180.0;
      final pos = Offset(
        center.dx + radius * 0.85 * progress * _cos(angle),
        center.dy + radius * 0.85 * progress * _sin(angle),
      );

      final contestant = contestants[i];

      // Connecting line to center.
      final linePaint = Paint()
        ..color = contestant.color.withValues(alpha: 0.4)
        ..strokeWidth = contestant.winner ? 3.0 : 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawLine(center, pos, linePaint);

      // Contestant disc.
      final discPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            contestant.color.withValues(alpha: 0.6),
            contestant.color.withValues(alpha: 1.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromCircle(center: pos, radius: 18.0));
      canvas.drawCircle(pos, 18.0, discPaint);

      // White ring around winner for emphasis.
      if (contestant.winner) {
        final crown = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = Colors.amber.shade800;
        canvas.drawCircle(pos, 22.0, crown);
      }

      // Label.
      final labelPainter = TextPainter(
        text: TextSpan(
          text: contestant.name,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final labelPos = Offset(
        pos.dx - labelPainter.width / 2.0,
        pos.dy + 22.0,
      );
      labelPainter.paint(canvas, labelPos);
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaPainter oldDelegate) =>
      oldDelegate.progress != progress;

  // Tiny trig helpers to avoid pulling in dart:math.
  double _cos(double r) {
    // Taylor series approximation around 0; sufficient for layout positions.
    final x = ((r % (2 * 3.1415926535)) + 2 * 3.1415926535) %
        (2 * 3.1415926535);
    final y = x - 3.1415926535;
    final y2 = y * y;
    return -(1.0 -
        y2 / 2.0 +
        y2 * y2 / 24.0 -
        y2 * y2 * y2 / 720.0 +
        y2 * y2 * y2 * y2 / 40320.0);
  }

  double _sin(double r) => _cos(r - 3.1415926535 / 2.0);
}

class _ArenaContestant {
  _ArenaContestant(this.name, this.color, this.winner);
  final String name;
  final MaterialColor color;
  final bool winner;
}
