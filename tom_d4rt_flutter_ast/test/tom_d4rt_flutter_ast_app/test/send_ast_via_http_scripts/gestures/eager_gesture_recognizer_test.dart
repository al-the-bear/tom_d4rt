// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for EagerGestureRecognizer from gestures
// Visual demonstration of eager arena resolution, lifecycle, integration,
// footguns, and decision matrix.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EagerGestureRecognizer Deep Demo executing');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade700,
          Colors.deepOrange.shade600,
          Colors.red.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.35),
          blurRadius: 32.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.flash_on, size: 64.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'EagerGestureRecognizer',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Wins the gesture arena IMMEDIATELY',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'No competition. No waiting. No rejection.\n'
            'Pointer arrives -> arena resolved -> done.',
            textAlign: TextAlign.center,
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
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy of the Gesture Arena
  // ============================================================
  print('=== Section 2: Arena Anatomy ===');

  final arenaAnatomy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Arena Anatomy', Colors.deepOrange),
        SizedBox(height: 12.0),
        Text(
          'A pointer down opens an arena. Every recogniser receives the '
          'event and either declares interest, defers, or eventually '
          'wins/loses. EagerGestureRecognizer skips the negotiation.',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '   Pointer Down\n'
            '        |\n'
            '        v\n'
            '  +-----------------+\n'
            '  |  GESTURE ARENA  |\n'
            '  +--------+--------+\n'
            '           |\n'
            '   +-------+--------+\n'
            '   |       |        |\n'
            ' [Tap]  [Pan]  [Eager*]   *resolves accepted INSTANTLY\n'
            '   |       |        |\n'
            '   v       v        v\n'
            ' wait    wait    WIN now\n'
            '   x       x       OK',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.amber.shade300,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created arena anatomy diagram');

  // ============================================================
  // SECTION 3: Class Hierarchy Chip Row
  // ============================================================
  print('=== Section 3: Class Hierarchy ===');

  final hierarchyRow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade200],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade500, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Class Hierarchy', Colors.deepOrange),
        SizedBox(height: 12.0),
        Text(
          'Two parallel branches diverge at OneSequenceGestureRecognizer:',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 16.0),
        // Top: GestureRecognizer root
        Center(child: _buildHierarchyChip('GestureRecognizer', Colors.brown)),
        SizedBox(height: 8.0),
        Center(
          child: Icon(
            Icons.arrow_downward,
            color: Colors.brown.shade400,
            size: 22.0,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: _buildHierarchyChip(
            'OneSequenceGestureRecognizer',
            Colors.brown.shade700,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.subdirectory_arrow_right, color: Colors.blueGrey),
            Icon(Icons.subdirectory_arrow_right, color: Colors.deepOrange),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                _buildHierarchyChip('TapGestureRecognizer', Colors.blueGrey),
                SizedBox(height: 6.0),
                _buildHierarchyChip(
                  'PanGestureRecognizer',
                  Colors.blueGrey.shade400,
                ),
                SizedBox(height: 6.0),
                _buildHierarchyChip(
                  'ScaleGestureRecognizer',
                  Colors.blueGrey.shade300,
                ),
                SizedBox(height: 6.0),
                Text(
                  '(deferred / negotiated)',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.blueGrey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                _buildHierarchyChip(
                  'EagerGestureRecognizer',
                  Colors.deepOrange,
                ),
                SizedBox(height: 6.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.deepOrange, width: 1.0),
                  ),
                  child: Text(
                    'no payload, no callback',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.deepOrange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  '(eager / instant)',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.deepOrange.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
  print('Created hierarchy row');

  // ============================================================
  // SECTION 4: Lifecycle States
  // ============================================================
  print('=== Section 4: Lifecycle States ===');

  final lifecycleSteps = [
    {
      'n': 1,
      'title': 'Pointer Down',
      'desc': 'Framework routes the new pointer to all hit-tested recognisers.',
      'color': Colors.blue,
    },
    {
      'n': 2,
      'title': 'addAllowedPointer(event)',
      'desc': 'Framework asks recogniser if this pointer interests it.',
      'color': Colors.indigo,
    },
    {
      'n': 3,
      'title': 'startTrackingPointer',
      'desc': 'Eager hooks the pointer route to receive subsequent events.',
      'color': Colors.purple,
    },
    {
      'n': 4,
      'title': 'resolve(GestureDisposition.accepted)',
      'desc': 'Eager declares immediate victory; siblings are rejected.',
      'color': Colors.deepOrange,
    },
    {
      'n': 5,
      'title': 'didStopTrackingLastPointer',
      'desc': 'On pointer up, eager unhooks and the sequence ends.',
      'color': Colors.orange,
    },
    {
      'n': 6,
      'title': 'dispose()',
      'desc': 'When the owning widget unmounts, recogniser is disposed.',
      'color': Colors.brown,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    final color = step['color'] as Color;
    lifecycleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.6),
            width: 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${step['n']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.brown.shade900,
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

  final lifecycleSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Lifecycle States', Colors.deepOrange),
        SizedBox(height: 10.0),
        Text(
          'EagerGestureRecognizer collapses the typical multi-frame negotiation '
          'into a single synchronous declaration:',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 12.0),
        ...lifecycleCards,
      ],
    ),
  );
  print('Created lifecycle steps');

  // ============================================================
  // SECTION 5: Use Case 1 - Force Pan Inside Greedy Parent
  // ============================================================
  print('=== Section 5: Use Case 1 ===');

  final useCase1 = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Use Case 1: Steal from a greedy parent', Colors.red),
        SizedBox(height: 10.0),
        Text(
          'A horizontal ListView swallows pan gestures. Your child wants to '
          'pan vertically. Wrap the child in RawGestureDetector with an '
          'EagerGestureRecognizer to claim the pointer before the ListView '
          'wins.',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _buildScenarioBox(
                'WITHOUT eager',
                'ListView wins',
                'Child never sees pan',
                Colors.grey,
                Icons.block,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildScenarioBox(
                'WITH eager',
                'Child wins instantly',
                'ListView is rejected',
                Colors.deepOrange,
                Icons.flash_on,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created use case 1');

  // ============================================================
  // SECTION 6: Use Case 2 - Listener Touch Capture
  // ============================================================
  print('=== Section 6: Use Case 2 ===');

  final useCase2 = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade100, Colors.red.shade100],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip(
          'Use Case 2: Prevent ancestor dismissal',
          Colors.deepOrange,
        ),
        SizedBox(height: 10.0),
        Text(
          'Inside a Drawer or BottomSheet, taps on a custom canvas widget '
          'should not dismiss the surrounding modal. Add an Eager recogniser '
          'so the canvas claims the pointer first - the modal never sees it.',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepOrange.shade300),
          ),
          child: Column(
            children: [
              _buildLayerRow('Modal route (taps dismiss)', Colors.grey, 0),
              _buildLayerRow('BottomSheet content', Colors.amber, 1),
              _buildLayerRow(
                'Custom canvas + EagerRecognizer',
                Colors.deepOrange,
                2,
              ),
              _buildLayerRow('Pointer arrives here ->', Colors.red, 3),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created use case 2');

  // ============================================================
  // SECTION 7: Side-by-side Arena Timelines
  // ============================================================
  print('=== Section 7: Arena Timelines ===');

  final timelines = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.brown.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.brown.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Arena timelines: deferred vs eager', Colors.brown),
        SizedBox(height: 14.0),
        Text(
          'Deferred winner (e.g. PanGestureRecognizer):',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            _buildPill('down', Colors.blue),
            _buildPill('move', Colors.blue.shade300),
            _buildPill('move', Colors.blue.shade300),
            _buildPill('move', Colors.blue.shade300),
            _buildPill('slop>', Colors.indigo),
            _buildPill('accept', Colors.green),
            _buildPill('drag', Colors.green.shade300),
            _buildPill('up', Colors.teal),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Eager winner (EagerGestureRecognizer):',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            _buildPill('down', Colors.deepOrange),
            _buildPill('ACCEPT!', Colors.red),
            _buildPill('move', Colors.deepOrange.shade300),
            _buildPill('move', Colors.deepOrange.shade300),
            _buildPill('move', Colors.deepOrange.shade300),
            _buildPill('move', Colors.deepOrange.shade300),
            _buildPill('up', Colors.amber.shade700),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade400),
          ),
          child: Text(
            'Note: deferred recognisers wait for a slop threshold or other '
            'evidence before declaring victory. Eager declares accept on the '
            'very first frame after the pointer is allowed.',
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.brown.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created arena timelines');

  // ============================================================
  // SECTION 8: RawGestureDetector Integration Code
  // ============================================================
  print('=== Section 8: RawGestureDetector Integration ===');

  final integrationCode = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
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
            Icon(Icons.code, color: Colors.amber.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Integration with RawGestureDetector',
              style: TextStyle(
                color: Colors.amber.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          'RawGestureDetector(\n'
          '  behavior: HitTestBehavior.opaque,\n'
          '  gestures: <Type, GestureRecognizerFactory>{\n'
          '    EagerGestureRecognizer:\n'
          '      GestureRecognizerFactoryWithHandlers<\n'
          '        EagerGestureRecognizer\n'
          '      >(\n'
          '        () => EagerGestureRecognizer(),\n'
          '        (EagerGestureRecognizer instance) {\n'
          '          // No callbacks: it just claims the pointer.\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: const MyCanvas(),\n'
          ');',
          Colors.amber.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Combined with a Tap recogniser - eager STILL wins\n'
          '// because it resolves before the tap can decide.\n'
          'gestures: {\n'
          '  EagerGestureRecognizer:\n'
          '    GestureRecognizerFactoryWithHandlers<\n'
          '      EagerGestureRecognizer>(\n'
          '      () => EagerGestureRecognizer(),\n'
          '      (r) {},\n'
          '    ),\n'
          '  TapGestureRecognizer: ...\n'
          '}',
          Colors.cyan.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Disposal is automatic when the host widget unmounts.\n'
          '// You only call dispose() yourself if you instantiated\n'
          '// the recogniser outside of a factory.\n'
          'final eager = EagerGestureRecognizer();\n'
          '// ... use it ...\n'
          'eager.dispose();',
          Colors.lightGreenAccent,
        ),
      ],
    ),
  );
  print('Created integration code');

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footgunData = [
    {
      'title': 'Sibling starvation',
      'desc':
          'Eager rejects every other recogniser in the SAME arena. Sibling '
          'tap or longpress detectors will never fire while eager is mounted.',
      'icon': Icons.do_not_disturb_on,
      'color': Colors.red,
    },
    {
      'title': 'Swallowing route gestures',
      'desc':
          'PageRoute back-swipes, drawer drags, scroll bubbling - all of these '
          'depend on parent recognisers winning the arena. Eager kills them.',
      'icon': Icons.swipe_left,
      'color': Colors.deepOrange,
    },
    {
      'title': 'No payload, no callbacks',
      'desc':
          'Eager has no onTap / onPan analog. If you need data, pair it with '
          'a Listener (PointerEvent stream) or use a real recogniser instead.',
      'icon': Icons.report_off,
      'color': Colors.amber.shade800,
    },
    {
      'title': 'Hit-test surprises',
      'desc':
          'Forgetting HitTestBehavior.opaque means transparent regions still '
          'fall through; eager only claims pointers it actually receives.',
      'icon': Icons.visibility_off,
      'color': Colors.brown,
    },
    {
      'title': 'Wrong tool for the job',
      'desc':
          'If you really wanted a tap or pan handler, eager is the wrong '
          'choice - it gives you a single accept and zero gesture semantics.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footgunData) {
    final color = fg['color'] as Color;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.6),
            width: 1.4,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(fg['icon'] as IconData, color: color, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.brown.shade900,
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

  final footgunSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Footguns', Colors.red),
        SizedBox(height: 10.0),
        Text(
          'Eager is a heavy hammer. The most common defects come from using '
          'it where a normal recogniser was expected.',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 12.0),
        ...footgunCards,
      ],
    ),
  );
  print('Created footgun section');

  // ============================================================
  // SECTION 10: Decision Matrix
  // ============================================================
  print('=== Section 10: Decision Matrix ===');

  final decisionRows = [
    {
      'scenario': 'Need tap detection',
      'eager': 'NO',
      'tap': 'YES',
      'pan': 'no',
    },
    {
      'scenario': 'Need pan/drag deltas',
      'eager': 'NO',
      'tap': 'no',
      'pan': 'YES',
    },
    {
      'scenario': 'Block ancestor scrolling',
      'eager': 'YES',
      'tap': 'maybe',
      'pan': 'maybe',
    },
    {
      'scenario': 'Absorb pointer entirely',
      'eager': 'YES',
      'tap': 'no',
      'pan': 'no',
    },
    {
      'scenario': 'Custom hit area, no semantics',
      'eager': 'YES',
      'tap': 'no',
      'pan': 'no',
    },
    {
      'scenario': 'Long-press menu',
      'eager': 'NO',
      'tap': 'no',
      'pan': 'no',
    },
    {
      'scenario': 'Gesture combiner / arena tie-break',
      'eager': 'YES',
      'tap': 'no',
      'pan': 'no',
    },
  ];

  final decisionMatrix = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.deepOrange.shade100],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleChip('Decision Matrix', Colors.deepOrange),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade300,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildDecisionHeader('Scenario', 180.0),
              _buildDecisionHeader('Eager', 60.0),
              _buildDecisionHeader('Tap', 60.0),
              _buildDecisionHeader('Pan', 60.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (final row in decisionRows)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.deepOrange.shade200,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildDecisionScenario(row['scenario'] as String, 180.0),
                _buildDecisionVerdict(row['eager'] as String, 60.0),
                _buildDecisionVerdict(row['tap'] as String, 60.0),
                _buildDecisionVerdict(row['pan'] as String, 60.0),
              ],
            ),
          ),
      ],
    ),
  );
  print('Created decision matrix');

  // ============================================================
  // SECTION 11: Recap
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapItems = [
    'Eager wins the arena synchronously on addAllowedPointer.',
    'It has no payload and no callbacks - just claim and end.',
    'Use it to absorb taps, block parents, or freeze the arena.',
    'Avoid it when you actually need tap/pan/longpress semantics.',
    'Always pair it with HitTestBehavior.opaque on the host detector.',
    'Disposal is automatic when used via GestureRecognizerFactory.',
  ];

  final recapCards = <Widget>[];
  for (var i = 0; i < recapItems.length; i++) {
    recapCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepOrange.shade300, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.withValues(alpha: 0.15),
              blurRadius: 5.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.check, color: Colors.white, size: 16.0),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                recapItems[i],
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.brown.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final recapSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade300,
          Colors.deepOrange.shade300,
          Colors.red.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.5),
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
            Icon(Icons.auto_awesome, color: Colors.white, size: 28.0),
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
        ...recapCards,
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'TL;DR  -  EagerGestureRecognizer is the "I take it" button '
            'for the gesture arena. Powerful, simple, and easy to misuse.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created recap section');

  // Probe the recogniser type once just to demonstrate its existence
  // (no live arena, no setState).
  final eagerProbe = EagerGestureRecognizer();
  print('Probe runtimeType: ${eagerProbe.runtimeType}');
  eagerProbe.dispose();
  print('Probe disposed');

  print('EagerGestureRecognizer Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.amber.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _buildSectionLabel('1. Title Banner', Colors.deepOrange),
          SizedBox(height: 8.0),
          _buildSectionLabel('2. Anatomy of the Gesture Arena', Colors.amber),
          arenaAnatomy,
          SizedBox(height: 24.0),
          _buildSectionLabel('3. Class Hierarchy', Colors.orange),
          hierarchyRow,
          SizedBox(height: 24.0),
          _buildSectionLabel('4. Lifecycle States', Colors.deepOrange),
          lifecycleSection,
          SizedBox(height: 24.0),
          _buildSectionLabel('5. Use Case 1 - Steal from greedy parent',
              Colors.red),
          useCase1,
          SizedBox(height: 24.0),
          _buildSectionLabel('6. Use Case 2 - Prevent ancestor dismissal',
              Colors.deepOrange),
          useCase2,
          SizedBox(height: 24.0),
          _buildSectionLabel('7. Arena Timelines', Colors.brown),
          timelines,
          SizedBox(height: 24.0),
          _buildSectionLabel('8. RawGestureDetector Integration',
              Colors.amber),
          integrationCode,
          SizedBox(height: 24.0),
          _buildSectionLabel('9. Footguns', Colors.red),
          footgunSection,
          SizedBox(height: 24.0),
          _buildSectionLabel('10. Decision Matrix', Colors.deepOrange),
          decisionMatrix,
          SizedBox(height: 24.0),
          _buildSectionLabel('11. Recap', Colors.deepOrange),
          recapSection,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// =================================================================
// Helper widgets
// =================================================================

// Helper: section label badge
Widget _buildSectionLabel(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

// Helper: title chip used inside each card
Widget _buildTitleChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );
}

// Helper: hierarchy chip
Widget _buildHierarchyChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// Helper: scenario box used in use case sections
Widget _buildScenarioBox(
  String title,
  String result,
  String detail,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 30.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          result,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.brown.shade700,
          ),
        ),
      ],
    ),
  );
}

// Helper: stacked layer row used in Use Case 2
Widget _buildLayerRow(String label, Color color, int depth) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(
      horizontal: 12.0 + depth * 8.0,
      vertical: 7.0,
    ),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.layers, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: timeline pill
Widget _buildPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 3.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// Helper: code block for monospace dark snippets
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white24, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// Helper: decision matrix header
Widget _buildDecisionHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    ),
  );
}

// Helper: decision matrix scenario cell
Widget _buildDecisionScenario(String text, double width) {
  return SizedBox(
    width: width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: Colors.brown.shade900,
        ),
      ),
    ),
  );
}

// Helper: decision matrix verdict cell
Widget _buildDecisionVerdict(String verdict, double width) {
  Color color;
  IconData icon;
  switch (verdict) {
    case 'YES':
      color = Colors.green.shade700;
      icon = Icons.check_circle;
      break;
    case 'NO':
      color = Colors.red.shade700;
      icon = Icons.cancel;
      break;
    case 'maybe':
      color = Colors.amber.shade800;
      icon = Icons.help_outline;
      break;
    default:
      color = Colors.grey.shade600;
      icon = Icons.remove_circle_outline;
  }
  return SizedBox(
    width: width,
    child: Column(
      children: [
        Icon(icon, color: color, size: 18.0),
        Text(
          verdict,
          style: TextStyle(
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
