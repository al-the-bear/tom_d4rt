// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DelayedMultiDragGestureRecognizer
// Deep Demo: Visual demonstration of the delayed multi-drag gesture
// recognizer showing the patient long-press-then-drag lifecycle, custom
// delays, comparisons against immediate / horizontal / vertical drag
// recognizers, real-world reorderable list illustration and footguns.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DelayedMultiDragGestureRecognizer Deep Demo executing');

  // ============================================================
  // Theme palette
  // ============================================================
  final Color violetDeep = Color(0xFF4A148C);
  final Color violetMid = Color(0xFF6A1B9A);
  final Color violetSoft = Color(0xFF9C27B0);
  final Color violetPale = Color(0xFFE1BEE7);
  final Color amber = Color(0xFFFFA000);
  final Color teal = Color(0xFF00897B);
  final Color crimson = Color(0xFFC62828);
  final Color slate = Color(0xFF37474F);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          violetDeep,
          violetMid,
          violetSoft,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: violetDeep.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: violetSoft.withValues(alpha: 0.3),
          blurRadius: 30.0,
          offset: Offset(0.0, 16.0),
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
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
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
                    'DelayedMultiDragGestureRecognizer',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.0),
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
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Text(
            'Recognises a multi-touch drag that begins only after the '
            'pointer has been held for a configurable delay. Default delay '
            'is kLongPressTimeout (500ms). Used for "press-then-drag" '
            'patterns such as rearranging list items.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.95),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildHierarchyChip('GestureRecognizer'),
            Icon(Icons.arrow_forward, color: Colors.white70, size: 16.0),
            _buildHierarchyChip('MultiDragGestureRecognizer'),
            Icon(Icons.arrow_forward, color: Colors.white70, size: 16.0),
            _buildHierarchyChip('DelayedMultiDragGestureRecognizer'),
          ],
        ),
      ],
    ),
  );
  print('Built title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram (pointer-down -> delay -> drag)
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomySteps = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app_outlined,
      'label': 'Pointer Down',
      'detail': 'addPointer(event)',
      'color': teal,
    },
    {
      'icon': Icons.hourglass_empty,
      'label': 'Start Delay',
      'detail': 'Timer(delay)',
      'color': amber,
    },
    {
      'icon': Icons.balance,
      'label': 'Resolve Arena',
      'detail': 'accept gesture',
      'color': violetSoft,
    },
    {
      'icon': Icons.open_with,
      'label': 'Drag Start',
      'detail': 'onStart(position)',
      'color': violetDeep,
    },
  ];

  final anatomyPills = <Widget>[];
  for (int i = 0; i < anatomySteps.length; i++) {
    final step = anatomySteps[i];
    anatomyPills.add(_buildAnatomyPill(
      step['icon'] as IconData,
      step['label'] as String,
      step['detail'] as String,
      step['color'] as Color,
    ));
    if (i < anatomySteps.length - 1) {
      anatomyPills.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(
            Icons.arrow_forward,
            color: violetMid,
            size: 22.0,
          ),
        ),
      );
    }
  }

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          violetPale.withValues(alpha: 0.4),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetSoft.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetSoft.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2 — Anatomy of a Delayed Drag',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Pointer-down → delay timer → resolve arena → drag start',
          style: TextStyle(
            fontSize: 12.0,
            color: violetMid,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: anatomyPills,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: violetDeep.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: violetDeep.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          child: Text(
            'Internally, createNewPointerState() returns a private '
            '_DelayedPointerState that schedules a Timer when the pointer '
            'is added. If the pointer moves before the timer fires the '
            'gesture is rejected; if the timer completes while the finger '
            'is still down, the recognizer claims the arena.',
            style: TextStyle(
              fontSize: 11.5,
              color: slate,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built anatomy diagram with ${anatomySteps.length} stages');

  // ============================================================
  // SECTION 3: Constructor parameter chips
  // ============================================================
  print('=== Section 3: Constructor Parameters ===');

  final paramChips = <Widget>[
    _buildParamChip(
      'delay',
      'Duration',
      'kLongPressTimeout (500ms)',
      Icons.hourglass_bottom,
      violetDeep,
      'Hold time before drag is accepted.',
    ),
    _buildParamChip(
      'debugOwner',
      'Object?',
      'null',
      Icons.bug_report,
      teal,
      'Identifies the recognizer in debug output.',
    ),
    _buildParamChip(
      'supportedDevices',
      'Set<PointerDeviceKind>?',
      'null = all',
      Icons.mouse,
      amber,
      'Restricts which input devices fire the gesture.',
    ),
    _buildParamChip(
      'allowedButtonsFilter',
      'AllowedButtonsFilter?',
      'primary button',
      Icons.tune,
      violetSoft,
      'Predicate that filters which buttons may engage.',
    ),
  ];

  final paramSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          violetPale.withValues(alpha: 0.5),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3 — Constructor Parameters',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'DelayedMultiDragGestureRecognizer({...})',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: violetMid,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: paramChips,
        ),
      ],
    ),
  );
  print('Built ${paramChips.length} parameter chips');

  // ============================================================
  // SECTION 4: Lifecycle states timeline
  // ============================================================
  print('=== Section 4: Lifecycle Timeline ===');

  final timelineSteps = <Map<String, dynamic>>[
    {
      't': '0 ms',
      'state': 'idle',
      'note': 'Recognizer waits for addPointer().',
      'color': Colors.grey.shade500,
    },
    {
      't': '0 ms',
      'state': 'pointerDown',
      'note': 'Pointer registered. Delay timer scheduled.',
      'color': teal,
    },
    {
      't': '100 ms',
      'state': 'waiting',
      'note': 'Timer ticking. Movement may reject the gesture.',
      'color': amber,
    },
    {
      't': '300 ms',
      'state': 'waiting',
      'note': 'Still patient. Other recognisers may win the arena.',
      'color': amber,
    },
    {
      't': '500 ms',
      'state': 'accepted',
      'note': 'kLongPressTimeout expired → arena claimed.',
      'color': violetSoft,
    },
    {
      't': '500+ ms',
      'state': 'dragging',
      'note': 'onStart fires; subsequent pointer events drive the drag.',
      'color': violetDeep,
    },
    {
      't': 'release',
      'state': 'finished',
      'note': 'Pointer up → drag ends.',
      'color': slate,
    },
  ];

  final timelineRows = <Widget>[];
  for (final step in timelineSteps) {
    timelineRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          children: [
            Container(
              width: 70.0,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: (step['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: (step['color'] as Color).withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: Text(
                step['t'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: step['color'] as Color,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: step['color'] as Color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (step['color'] as Color).withValues(alpha: 0.5),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            SizedBox(
              width: 100.0,
              child: Text(
                step['state'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: step['color'] as Color,
                ),
              ),
            ),
            Expanded(
              child: Text(
                step['note'] as String,
                style: TextStyle(
                  fontSize: 11.5,
                  color: slate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final lifecycleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          violetPale.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetSoft.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4 — Lifecycle Timeline (default 500 ms)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 12.0),
        Column(
          children: timelineRows,
        ),
      ],
    ),
  );
  print('Built lifecycle timeline with ${timelineSteps.length} entries');

  // ============================================================
  // SECTION 5: Custom delays — four colored timeline strips
  // ============================================================
  print('=== Section 5: Custom Delays ===');

  final delayVariants = <Map<String, dynamic>>[
    {
      'ms': 200,
      'label': '200 ms',
      'tag': 'snappy',
      'note': 'Minimal pause — risk of tap conflicts.',
      'color': Color(0xFFEF5350),
    },
    {
      'ms': 500,
      'label': '500 ms',
      'tag': 'default',
      'note': 'kLongPressTimeout. Balanced for most cases.',
      'color': violetSoft,
    },
    {
      'ms': 1000,
      'label': '1000 ms',
      'tag': 'deliberate',
      'note': 'Confirms intent for destructive operations.',
      'color': Color(0xFF3949AB),
    },
    {
      'ms': 2000,
      'label': '2000 ms',
      'tag': 'patient',
      'note': 'Long hold — feels sluggish; rare use cases.',
      'color': Color(0xFF1565C0),
    },
  ];

  final delayStrips = <Widget>[];
  // Use 2 s as the visual scale.
  const double maxMs = 2000.0;
  for (final variant in delayVariants) {
    final int ms = variant['ms'] as int;
    final Color c = variant['color'] as Color;
    final double fraction = ms / maxMs;
    delayStrips.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: c.withValues(alpha: 0.6),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    variant['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    variant['tag'] as String,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    variant['note'] as String,
                    style: TextStyle(fontSize: 11.0, color: slate),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              height: 18.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        c.withValues(alpha: 0.6),
                        c,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                    boxShadow: [
                      BoxShadow(
                        color: c.withValues(alpha: 0.45),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final customDelaySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          violetPale.withValues(alpha: 0.4),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetSoft.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetSoft.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5 — Custom Delay Comparison',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Strip width is proportional to delay (max scale 2000 ms)',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: violetMid,
          ),
        ),
        SizedBox(height: 12.0),
        Column(children: delayStrips),
      ],
    ),
  );
  print('Built ${delayVariants.length} delay variants');

  // ============================================================
  // SECTION 6: Comparison with siblings
  // ============================================================
  print('=== Section 6: Recognizer Comparison ===');

  final comparisonRows = <Widget>[
    _buildComparisonRow(
      'DelayedMultiDragGestureRecognizer',
      'configurable delay',
      'multi-touch drag after hold',
      'reorderable lists, edit handles',
      violetDeep,
      Icons.hourglass_bottom,
      isHighlighted: true,
    ),
    _buildComparisonRow(
      'ImmediateMultiDragGestureRecognizer',
      'no delay',
      'multi-touch drag at slop',
      'free-form drag canvases',
      teal,
      Icons.flash_on,
    ),
    _buildComparisonRow(
      'HorizontalMultiDragGestureRecognizer',
      'no delay',
      'horizontal-only drag',
      'card swipe, scroll-x',
      amber,
      Icons.swap_horiz,
    ),
    _buildComparisonRow(
      'VerticalMultiDragGestureRecognizer',
      'no delay',
      'vertical-only drag',
      'pull-to-refresh, scroll-y',
      Color(0xFF3949AB),
      Icons.swap_vert,
    ),
  ];

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          violetPale.withValues(alpha: 0.35),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6 — Comparison with Sibling Recognizers',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 12.0),
        Column(children: comparisonRows),
      ],
    ),
  );
  print('Built ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 7: Use cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'icon': Icons.reorder,
      'title': 'Rearrangeable Lists',
      'note': 'ReorderableListView and ReorderableSliverList rely on a '
          '500ms delay before lifting the dragged item.',
      'color': violetDeep,
    },
    {
      'icon': Icons.pan_tool,
      'title': 'Drag-to-Pick',
      'note': 'Press a card to "pick it up" and place it elsewhere on the '
          'canvas (kanban boards, photo trays).',
      'color': teal,
    },
    {
      'icon': Icons.grid_on,
      'title': 'Password Pattern Grids',
      'note': 'Wait briefly to confirm the user wants to start a pattern '
          'rather than tap a single dot.',
      'color': amber,
    },
    {
      'icon': Icons.edit,
      'title': 'Edit-Mode Handles',
      'note': 'Long-press to enter edit mode, then drag handles to '
          'rearrange or resize widgets.',
      'color': violetSoft,
    },
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCases) {
    useCaseCards.add(_buildUseCaseCard(
      uc['icon'] as IconData,
      uc['title'] as String,
      uc['note'] as String,
      uc['color'] as Color,
    ));
  }

  final useCaseSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          violetPale.withValues(alpha: 0.5),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetSoft.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetSoft.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7 — Common Use Cases',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: useCaseCards,
        ),
      ],
    ),
  );
  print('Built ${useCases.length} use-case cards');

  // ============================================================
  // SECTION 8: RawGestureDetector code block
  // ============================================================
  print('=== Section 8: RawGestureDetector Snippet ===');

  final codeText =
      '''RawGestureDetector(
  gestures: <Type, GestureRecognizerFactory>{
    DelayedMultiDragGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<
            DelayedMultiDragGestureRecognizer>(
      () => DelayedMultiDragGestureRecognizer(
        delay: const Duration(milliseconds: 500),
        debugOwner: this,
      ),
      (DelayedMultiDragGestureRecognizer instance) {
        instance.onStart = (Offset position) {
          // Return a Drag implementation; null cancels.
          return MyItemDrag(start: position);
        };
      },
    ),
  },
  child: child,
);''';

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A1A2E),
          Color(0xFF16213E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                'section 8 — registering the recognizer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            codeText,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFFE0E0FF),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built RawGestureDetector code block');

  // ============================================================
  // SECTION 9: Real-world example — fake reorderable list
  // ============================================================
  print('=== Section 9: Reorderable List Mock ===');

  final mockItems = <Map<String, dynamic>>[
    {'icon': Icons.inbox, 'title': 'Inbox', 'subtitle': '12 unread'},
    {'icon': Icons.star, 'title': 'Starred', 'subtitle': '3 marked'},
    {'icon': Icons.send, 'title': 'Sent', 'subtitle': 'last today 09:14'},
    {'icon': Icons.drafts, 'title': 'Drafts', 'subtitle': '2 drafts'},
    {'icon': Icons.archive, 'title': 'Archive', 'subtitle': '146 items'},
    {'icon': Icons.delete_outline, 'title': 'Trash', 'subtitle': 'auto-purge 30d'},
  ];

  final mockRows = <Widget>[];
  for (int i = 0; i < mockItems.length; i++) {
    final item = mockItems[i];
    final bool highlighted = i == 2;
    mockRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: highlighted
                ? [
                    violetSoft.withValues(alpha: 0.25),
                    violetDeep.withValues(alpha: 0.25),
                  ]
                : [
                    Colors.white,
                    Colors.grey.shade100,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: highlighted
                ? violetSoft.withValues(alpha: 0.6)
                : Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: violetSoft.withValues(alpha: 0.3),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              Icons.drag_indicator,
              size: 20.0,
              color: highlighted ? violetDeep : Colors.grey.shade500,
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: highlighted
                    ? violetSoft.withValues(alpha: 0.3)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 20.0,
                color: highlighted ? violetDeep : slate,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: highlighted ? violetDeep : slate,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    item['subtitle'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: highlighted
                          ? violetMid
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: highlighted
                    ? violetDeep
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 11.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'press 500ms',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  final reorderableMock = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          violetPale.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9 — Mock Reorderable List',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: violetDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each row shows the press-500ms hint badge that tells the user '
          'a delay is needed before the drag begins. Highlighted row is '
          'the "lifted" item.',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: violetMid,
          ),
        ),
        SizedBox(height: 12.0),
        Column(children: mockRows),
      ],
    ),
  );
  print('Built ${mockItems.length} mock reorderable rows');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Map<String, dynamic>>[
    {
      'title': 'Too-short delay',
      'note': 'Tap recognisers may still be active — every quick touch '
          'risks accidentally starting a drag.',
      'color': crimson,
      'icon': Icons.flash_on,
    },
    {
      'title': 'Too-long delay',
      'note': 'Users get frustrated waiting. Visual feedback is essential '
          'when delay > 700 ms.',
      'color': Color(0xFFD84315),
      'icon': Icons.hourglass_full,
    },
    {
      'title': 'Multi-touch interference',
      'note': 'A second finger arriving before the timer fires can cancel '
          'the gesture in some arenas.',
      'color': Color(0xFF6A1B9A),
      'icon': Icons.touch_app,
    },
    {
      'title': 'supportedDevices misuse',
      'note': 'Restricting to PointerDeviceKind.touch silently excludes '
          'desktop trackpads and styluses.',
      'color': Color(0xFF1565C0),
      'icon': Icons.mouse,
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    footgunCards.add(_buildFootgunCard(
      fg['title'] as String,
      fg['note'] as String,
      fg['color'] as Color,
      fg['icon'] as IconData,
    ));
  }

  final footgunSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFEBEE),
          Color(0xFFFFF3E0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: crimson.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: crimson.withValues(alpha: 0.2),
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
            Icon(Icons.warning_amber_rounded, color: crimson, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Section 10 — Footguns to Avoid',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: crimson,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: footgunCards,
        ),
      ],
    ),
  );
  print('Built ${footguns.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap & decision matrix
  // ============================================================
  print('=== Section 11: Recap ===');

  final decisionRows = <Widget>[
    _buildDecisionRow(
      'Need long-press confirmation before drag?',
      'Yes',
      'DelayedMultiDragGestureRecognizer',
      violetDeep,
    ),
    _buildDecisionRow(
      'Need drag to start instantly?',
      'No delay',
      'ImmediateMultiDragGestureRecognizer',
      teal,
    ),
    _buildDecisionRow(
      'Need single-axis horizontal drag?',
      'Horizontal',
      'HorizontalMultiDragGestureRecognizer',
      amber,
    ),
    _buildDecisionRow(
      'Need single-axis vertical drag?',
      'Vertical',
      'VerticalMultiDragGestureRecognizer',
      Color(0xFF3949AB),
    ),
    _buildDecisionRow(
      'Need full pan with scale/rotation?',
      'Pan/Scale',
      'ScaleGestureRecognizer',
      violetSoft,
    ),
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          violetDeep,
          violetMid,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: violetDeep.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Section 11 — Decision Matrix & Recap',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          child: Column(children: decisionRows),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Bottom line: pick DelayedMultiDragGestureRecognizer when the '
            'UX needs the user to explicitly commit before dragging — '
            'reorderable lists, edit handles, and any "press to grab" '
            'pattern. Tune the delay carefully and surface visual feedback '
            'so the user knows the gesture is being processed.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built recap card');

  // ============================================================
  // Static instance metadata (does not start a real gesture)
  // ============================================================
  print('=== Static instance summary ===');
  final probe = DelayedMultiDragGestureRecognizer();
  print('Default delay: ${probe.delay}');
  print('Runtime type:  ${probe.runtimeType}');
  probe.dispose();

  final probe2 = DelayedMultiDragGestureRecognizer(
    delay: Duration(milliseconds: 1000),
  );
  print('Custom delay: ${probe2.delay}');
  probe2.dispose();

  print('DelayedMultiDragGestureRecognizer Deep Demo finished');

  // ============================================================
  // Final assembly
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF6F0FA),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomyDiagram,
          paramSection,
          lifecycleSection,
          customDelaySection,
          comparisonSection,
          useCaseSection,
          codeBlock,
          reorderableMock,
          footgunSection,
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

Widget _buildHierarchyChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildAnatomyPill(
  IconData icon,
  String label,
  String detail,
  Color color,
) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(height: 6.0),
        Text(
          label,
          textAlign: TextAlign.center,
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
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildParamChip(
  String name,
  String type,
  String defaultVal,
  IconData icon,
  Color color,
  String note,
) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
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
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
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
        SizedBox(height: 6.0),
        Text(
          'default: $defaultVal',
          style: TextStyle(
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          note,
          style: TextStyle(fontSize: 11.0, color: Colors.black87, height: 1.3),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String name,
  String delay,
  String behavior,
  String useCase,
  Color color,
  IconData icon, {
  bool isHighlighted = false,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isHighlighted
            ? [
                color.withValues(alpha: 0.18),
                color.withValues(alpha: 0.32),
              ]
            : [
                Colors.white,
                Colors.grey.shade100,
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: isHighlighted ? color : Colors.grey.shade300,
        width: isHighlighted ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
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
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: [
                  _buildMiniBadge('delay: $delay', color),
                  _buildMiniBadge(behavior, color),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'Use: $useCase',
                style: TextStyle(fontSize: 11.0, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
      ),
    ),
  );
}

Widget _buildUseCaseCard(
  IconData icon,
  String title,
  String note,
  Color color,
) {
  return Container(
    width: 240.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFootgunCard(
  String title,
  String note,
  Color color,
  IconData icon,
) {
  return Container(
    width: 240.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecisionRow(
  String question,
  String answer,
  String recommendation,
  Color accent,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.help_outline, color: Colors.white70, size: 16.0),
        SizedBox(width: 6.0),
        Expanded(
          flex: 5,
          child: Text(
            question,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          flex: 5,
          child: Text(
            recommendation,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
