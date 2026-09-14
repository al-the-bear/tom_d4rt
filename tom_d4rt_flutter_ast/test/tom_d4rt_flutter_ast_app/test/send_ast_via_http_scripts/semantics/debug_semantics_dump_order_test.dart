// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demo for DebugSemanticsDumpOrder
// from package:flutter/semantics.dart. Renders an extensive,
// hand-authored visual catalog illustrating how the two enum
// values (inverseHitTest, traversalOrder) reorder the dumped
// semantics tree, complete with anatomy diagrams, comparisons,
// pitfalls, debugging workflows, accessibility recipes and an
// ASCII reference footer.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Static motion only: AlwaysStoppedAnimation + Duration.zero
  // ============================================================
  final Animation<double> heroPulse = AlwaysStoppedAnimation<double>(0.85);
  final Animation<double> sectionFade = AlwaysStoppedAnimation<double>(0.92);
  final Animation<double> nodeReveal = AlwaysStoppedAnimation<double>(0.78);
  final Animation<double> arrowMotion = AlwaysStoppedAnimation<double>(0.65);
  final Duration noMotion = Duration.zero;

  // ============================================================
  // Reference data
  // ============================================================
  final List<DebugSemanticsDumpOrder> allOrders = DebugSemanticsDumpOrder.values;
  final DebugSemanticsDumpOrder firstOrder = allOrders.first;
  final DebugSemanticsDumpOrder lastOrder = allOrders.last;

  final Map<DebugSemanticsDumpOrder, Map<String, dynamic>> orderMeta = {
    DebugSemanticsDumpOrder.inverseHitTest: {
      'title': 'inverseHitTest',
      'subtitle': 'Hit-test responder priority',
      'icon': Icons.touch_app,
      'primary': Colors.deepOrange,
      'secondary': Colors.amber,
      'tagline': 'Last child first, first child last',
      'use': 'Mirrors paint stacking when investigating gesture conflicts.',
      'order_label': '4 -> 3 -> 2 -> 1',
      'gradient_begin': Alignment.topLeft,
      'gradient_end': Alignment.bottomRight,
    },
    DebugSemanticsDumpOrder.traversalOrder: {
      'title': 'traversalOrder',
      'subtitle': 'Assistive navigation order',
      'icon': Icons.accessibility_new,
      'primary': Colors.indigo,
      'secondary': Colors.cyan,
      'tagline': 'Reading order, top to bottom',
      'use': 'Reflects how TalkBack/VoiceOver swipe-next visits the UI.',
      'order_label': '1 -> 2 -> 3 -> 4',
      'gradient_begin': Alignment.topRight,
      'gradient_end': Alignment.bottomLeft,
    },
  };

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.purple.shade600,
          Colors.deepOrange.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Opacity(
              opacity: heroPulse.value,
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 2.0,
                  ),
                ),
                child: Icon(
                  Icons.account_tree,
                  size: 48.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DebugSemanticsDumpOrder',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'How debugDumpSemanticsTree() decides who prints first',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        Row(
          children: [
            _heroChip('enum', Icons.menu_book, Colors.amber),
            SizedBox(width: 8.0),
            _heroChip(
              '${allOrders.length} values',
              Icons.list_alt,
              Colors.cyanAccent,
            ),
            SizedBox(width: 8.0),
            _heroChip('semantics.dart', Icons.code, Colors.lightGreenAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a semantics dump
  // ============================================================
  final Widget anatomySection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Anatomy of a Dump Line',
          Icons.biotech,
          Colors.indigo.shade800,
        ),
        SizedBox(height: 16.0),
        Text(
          'Every node in debugDumpSemanticsTree() output looks like:',
          style: TextStyle(fontSize: 13.0, color: Colors.indigo.shade700),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Text(
            'SemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 360.0, 64.0), label: "Inbox", actions: [tap])',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.lightGreenAccent.shade400,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _anatomyChip('SemanticsNode#7', 'unique id', Colors.amber.shade700),
            _anatomyChip(
              'Rect.fromLTRB',
              'paint bounds',
              Colors.lightBlue.shade700,
            ),
            _anatomyChip('label:', 'screen reader text', Colors.green.shade700),
            _anatomyChip(
              'actions:',
              'gestures bound',
              Colors.deepPurple.shade400,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.indigo.shade300, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.indigo.shade800,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The childOrder argument controls indentation order, not the node format.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.indigo.shade900,
                    fontWeight: FontWeight.w600,
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
  // SECTION 3: Per-value cards (one per enum value)
  // ============================================================
  final List<Widget> valueCards = <Widget>[];
  for (final DebugSemanticsDumpOrder order in allOrders) {
    final Map<String, dynamic> meta = orderMeta[order]!;
    final Color primary = meta['primary'] as Color;
    final Color secondary = meta['secondary'] as Color;

    valueCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primary.withValues(alpha: 0.18),
              secondary.withValues(alpha: 0.28),
              primary.withValues(alpha: 0.08),
            ],
            begin: meta['gradient_begin'] as Alignment,
            end: meta['gradient_end'] as Alignment,
          ),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: primary, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.35),
              blurRadius: 14.0,
              offset: Offset(0.0, 8.0),
            ),
            BoxShadow(
              color: secondary.withValues(alpha: 0.2),
              blurRadius: 22.0,
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
                      colors: [primary, secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.55),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(
                    meta['icon'] as IconData,
                    size: 36.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DebugSemanticsDumpOrder.${meta['title']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: primary,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        meta['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: primary.withValues(alpha: 0.85),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'index ${order.index}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: primary.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.format_quote, color: primary, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      meta['tagline'] as String,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.0),
            Text(
              'When to use',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: primary.withValues(alpha: 0.85),
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              meta['use'] as String,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.0),
            // Visual reorder strip
            _reorderStrip(order, primary, secondary),
            SizedBox(height: 14.0),
            // Mock dump output
            _mockDumpOutput(order, primary),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Side-by-side comparison
  // ============================================================
  final Widget comparisonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'inverseHitTest vs traversalOrder',
          Icons.compare_arrows,
          Colors.deepOrange.shade800,
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _comparisonColumn(
                'inverseHitTest',
                Colors.deepOrange,
                <Map<String, String>>[
                  {
                    'q': 'Print order',
                    'a': 'Last painted child first',
                  },
                  {
                    'q': 'Mental model',
                    'a': 'Stacked cards top-down',
                  },
                  {
                    'q': 'Useful for',
                    'a': 'Gesture / hit-test routing',
                  },
                  {
                    'q': 'Pairs with',
                    'a': 'HitTestBehavior, Listener',
                  },
                  {
                    'q': 'Warning',
                    'a': 'Not the screen reader order!',
                  },
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Container(width: 2.0, height: 240.0, color: Colors.amber.shade400),
            SizedBox(width: 12.0),
            Expanded(
              child: _comparisonColumn(
                'traversalOrder',
                Colors.indigo,
                <Map<String, String>>[
                  {
                    'q': 'Print order',
                    'a': 'Reading order top-down',
                  },
                  {
                    'q': 'Mental model',
                    'a': 'Newspaper columns',
                  },
                  {
                    'q': 'Useful for',
                    'a': 'A11y review / focus order',
                  },
                  {
                    'q': 'Pairs with',
                    'a': 'Semantics, OrdinalSortKey',
                  },
                  {
                    'q': 'Warning',
                    'a': 'Not paint / hit-test order!',
                  },
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Accessibility recipes
  // ============================================================
  final Widget accessibilityRecipes = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.teal.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Accessibility Recipes',
          Icons.accessibility,
          Colors.green.shade800,
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          step: 1,
          title: 'Verify swipe-next order matches design',
          body:
              'Use traversalOrder to dump and confirm logical reading flow.',
          color: Colors.green.shade600,
        ),
        SizedBox(height: 10.0),
        _recipeCard(
          step: 2,
          title: 'Hunt down missing semantics labels',
          body:
              'Look for SemanticsNode lines without label: in either order dump.',
          color: Colors.teal.shade600,
        ),
        SizedBox(height: 10.0),
        _recipeCard(
          step: 3,
          title: 'Resolve gesture conflicts',
          body:
              'Switch to inverseHitTest to see who actually wins the tap event.',
          color: Colors.deepOrange.shade500,
        ),
        SizedBox(height: 10.0),
        _recipeCard(
          step: 4,
          title: 'Validate OrdinalSortKey results',
          body:
              'OrdinalSortKey only affects traversalOrder, never hit-test order.',
          color: Colors.indigo.shade600,
        ),
        SizedBox(height: 10.0),
        _recipeCard(
          step: 5,
          title: 'Compare both dumps',
          body:
              'Diverging trees often indicate a missing or misplaced Semantics widget.',
          color: Colors.purple.shade600,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pitfalls
  // ============================================================
  final Widget pitfallsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade100],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Common Pitfalls',
          Icons.warning_amber_rounded,
          Colors.red.shade800,
        ),
        SizedBox(height: 16.0),
        _pitfallTile(
          'Mixing the two orders',
          'Engineers often assume traversalOrder matches paint order. It does not.',
          Icons.swap_horiz,
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          'Forgetting Stack ordering',
          'In a Stack, paint order is bottom-to-top while inverseHitTest is top-to-bottom.',
          Icons.layers,
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          'Hidden ExcludeSemantics',
          'A node may be invisible in BOTH dumps; check for ExcludeSemantics ancestors.',
          Icons.visibility_off,
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          'Tab order != visual order',
          'Custom OrdinalSortKey reorders only traversalOrder, never inverseHitTest.',
          Icons.sort,
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          'Asynchronous content',
          'Streamed widgets may be missing from the dump if they have not built yet.',
          Icons.hourglass_empty,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Hit-test order vs traversal order diagram
  // ============================================================
  final Widget orderDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade50,
          Colors.blue.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Visual Reorder Diagram',
          Icons.account_tree,
          Colors.deepPurple.shade800,
        ),
        SizedBox(height: 16.0),
        Text(
          'Same parent SemanticsNode, four children, two orderings:',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _diagramColumn(
                'inverseHitTest',
                Colors.deepOrange,
                <int>[4, 3, 2, 1],
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              width: 40.0,
              child: Column(
                children: [
                  Icon(
                    Icons.swap_horiz,
                    color: Colors.deepPurple.shade400,
                    size: 32.0,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'vs',
                    style: TextStyle(
                      color: Colors.deepPurple.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _diagramColumn(
                'traversalOrder',
                Colors.indigo,
                <int>[1, 2, 3, 4],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Debugging workflows
  // ============================================================
  final Widget workflowsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade100, Colors.cyan.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.blueGrey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Debugging Workflows',
          Icons.build_circle_outlined,
          Colors.blueGrey.shade800,
        ),
        SizedBox(height: 16.0),
        _workflowStep(
          1,
          'flutter run',
          'Launch the app under test. Hot reload preserves the tree.',
          Colors.blue.shade600,
        ),
        _workflowConnector(),
        _workflowStep(
          2,
          'enable semantics',
          'Press "S" in flutter run, or call SemanticsBinding.instance.ensureSemantics().',
          Colors.teal.shade600,
        ),
        _workflowConnector(),
        _workflowStep(
          3,
          'debugDumpSemanticsTree(traversalOrder)',
          'Dump for accessibility review and OrdinalSortKey verification.',
          Colors.indigo.shade600,
        ),
        _workflowConnector(),
        _workflowStep(
          4,
          'debugDumpSemanticsTree(inverseHitTest)',
          'Dump for hit-test routing and gesture priority debugging.',
          Colors.deepOrange.shade600,
        ),
        _workflowConnector(),
        _workflowStep(
          5,
          'diff outputs',
          'Side-by-side diff exposes mismatches between paint and reading order.',
          Colors.purple.shade600,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Code samples
  // ============================================================
  final Widget codeSamples = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
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
            Icon(Icons.terminal, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Code Samples',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// Default a11y dump (traversalOrder)\n'
          'debugDumpSemanticsTree();',
          Colors.lightGreenAccent.shade400,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Hit-test investigation\n'
          'debugDumpSemanticsTree(\n'
          '  DebugSemanticsDumpOrder.inverseHitTest,\n'
          ');',
          Colors.amberAccent.shade200,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Programmatic enumeration\n'
          'for (final order in DebugSemanticsDumpOrder.values) {\n'
          '  print("\${order.name} -> index \${order.index}");\n'
          '}',
          Colors.cyanAccent.shade400,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Switch on enum exhaustively\n'
          'final label = switch (order) {\n'
          '  DebugSemanticsDumpOrder.inverseHitTest => "hit",\n'
          '  DebugSemanticsDumpOrder.traversalOrder => "read",\n'
          '};',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Quick reference table
  // ============================================================
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Quick Reference',
          Icons.bookmark_outlined,
          Colors.purple.shade800,
        ),
        SizedBox(height: 14.0),
        _refRow(
          'Enum',
          'DebugSemanticsDumpOrder',
          Colors.purple.shade700,
          true,
        ),
        _refRow(
          'Library',
          'package:flutter/semantics.dart',
          Colors.indigo.shade700,
          false,
        ),
        _refRow('Total values', '${allOrders.length}', Colors.teal.shade700, true),
        _refRow(
          'First',
          'DebugSemanticsDumpOrder.${firstOrder.name} (index ${firstOrder.index})',
          Colors.deepOrange.shade700,
          false,
        ),
        _refRow(
          'Last',
          'DebugSemanticsDumpOrder.${lastOrder.name} (index ${lastOrder.index})',
          Colors.pink.shade700,
          true,
        ),
        _refRow(
          'Default arg',
          'traversalOrder',
          Colors.green.shade700,
          false,
        ),
        _refRow(
          'Used by',
          'debugDumpSemanticsTree, SemanticsNode.toStringDeep',
          Colors.blueGrey.shade700,
          true,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.only(top: 18.0, bottom: 32.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
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
            Icon(Icons.text_snippet, color: Colors.tealAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ASCII Reference',
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          '+----------------------------------------------------+\n'
          '|        DebugSemanticsDumpOrder Cheatsheet          |\n'
          '+----------------------------------------------------+\n'
          '|                                                    |\n'
          '|  inverseHitTest  ->  4 - 3 - 2 - 1   (reverse)     |\n'
          '|  traversalOrder  ->  1 - 2 - 3 - 4   (forward)     |\n'
          '|                                                    |\n'
          '|  paint stack ......... last painted = on top       |\n'
          '|  reader swipe ........ first labelled = first      |\n'
          '|                                                    |\n'
          '|       /\\          tap                              |\n'
          '|      /  \\        +---+                             |\n'
          '|     / 4  \\       | 1 |  swipe next                 |\n'
          '|    /------\\      +---+      |                      |\n'
          '|   / 3      \\     | 2 |      v                      |\n'
          '|  /----------\\    +---+   +---+                     |\n'
          '|  | 2 |   | 1 |   | 3 |   | 4 |                     |\n'
          '|  +---+   +---+   +---+   +---+                     |\n'
          '|                                                    |\n'
          '+----------------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade400,
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose final scaffold
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Opacity(
        opacity: sectionFade.value,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 18.0),
              _label(
                'Section 1 - Anatomy',
                Icons.biotech,
                Colors.indigo.shade700,
              ),
              anatomySection,
              SizedBox(height: 6.0),
              _label(
                'Section 2 - Per-value cards',
                Icons.style,
                Colors.deepOrange.shade700,
              ),
              ...valueCards,
              SizedBox(height: 6.0),
              _label(
                'Section 3 - Side by side',
                Icons.compare_arrows,
                Colors.amber.shade800,
              ),
              comparisonSection,
              SizedBox(height: 6.0),
              _label(
                'Section 4 - Visual reorder',
                Icons.account_tree,
                Colors.deepPurple.shade700,
              ),
              orderDiagram,
              SizedBox(height: 6.0),
              _label(
                'Section 5 - Accessibility recipes',
                Icons.accessibility,
                Colors.green.shade700,
              ),
              accessibilityRecipes,
              SizedBox(height: 6.0),
              _label(
                'Section 6 - Pitfalls',
                Icons.warning_amber_rounded,
                Colors.red.shade700,
              ),
              pitfallsSection,
              SizedBox(height: 6.0),
              _label(
                'Section 7 - Debugging workflows',
                Icons.build_circle_outlined,
                Colors.blueGrey.shade800,
              ),
              workflowsSection,
              SizedBox(height: 6.0),
              _label(
                'Section 8 - Code samples',
                Icons.terminal,
                Colors.cyan.shade800,
              ),
              codeSamples,
              SizedBox(height: 6.0),
              _label(
                'Section 9 - Quick reference',
                Icons.bookmark_outlined,
                Colors.purple.shade800,
              ),
              quickReference,
              SizedBox(height: 6.0),
              _label(
                'Section 10 - ASCII footer',
                Icons.text_snippet,
                Colors.teal.shade800,
              ),
              asciiFooter,
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

Widget _heroChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
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

Widget _sectionHeading(String text, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(icon, color: color, size: 22.0),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _label(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: 4.0, top: 14.0, bottom: 4.0),
    child: Row(
      children: [
        Icon(icon, size: 16.0, color: color),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyChip(String token, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          token,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          desc,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _reorderStrip(
  DebugSemanticsDumpOrder order,
  Color primary,
  Color secondary,
) {
  final List<int> ids = order == DebugSemanticsDumpOrder.inverseHitTest
      ? <int>[4, 3, 2, 1]
      : <int>[1, 2, 3, 4];
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: primary.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (int idx = 0; idx < ids.length; idx++) ...[
          _reorderTile(ids[idx], primary, secondary),
          if (idx < ids.length - 1)
            Icon(Icons.chevron_right, color: primary, size: 18.0),
        ],
      ],
    ),
  );
}

Widget _reorderTile(int id, Color primary, Color secondary) {
  return Container(
    width: 44.0,
    height: 44.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.45),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '#$id',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
  );
}

Widget _mockDumpOutput(DebugSemanticsDumpOrder order, Color color) {
  final List<int> ids = order == DebugSemanticsDumpOrder.inverseHitTest
      ? <int>[4, 3, 2, 1]
      : <int>[1, 2, 3, 4];
  final StringBuffer buf = StringBuffer();
  buf.writeln('SemanticsNode#0(root)');
  for (int i = 0; i < ids.length; i++) {
    final int id = ids[i];
    final String prefix = i == ids.length - 1 ? ' \\-' : ' |-';
    buf.writeln('$prefix SemanticsNode#$id(label: "Item $id")');
  }
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      buf.toString().trimRight(),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.lightGreenAccent.shade400,
        height: 1.4,
      ),
    ),
  );
}

Widget _comparisonColumn(
  String title,
  Color color,
  List<Map<String, String>> rows,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
      ),
      SizedBox(height: 10.0),
      for (final Map<String, String> row in rows) ...[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row['q'] ?? '',
                style: TextStyle(
                  fontSize: 10.0,
                  color: color.withValues(alpha: 0.8),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                row['a'] ?? '',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}

Widget _recipeCard({
  required int step,
  required String title,
  required String body,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
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
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile(String title, String body, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red.shade400, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _diagramColumn(String title, Color color, List<int> ids) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 10.0),
        for (int i = 0; i < ids.length; i++) ...[
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.6),
                  color.withValues(alpha: 0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Text(
                  '#${ids[i]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  'SemanticsNode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          if (i < ids.length - 1)
            Icon(
              Icons.arrow_downward,
              color: color.withValues(alpha: 0.7),
              size: 14.0,
            ),
        ],
      ],
    ),
  );
}

Widget _workflowStep(int idx, String cmd, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$idx',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  cmd,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _workflowConnector() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
    child: Container(
      width: 2.0,
      height: 16.0,
      color: Colors.blueGrey.shade300,
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _refRow(String key, String value, Color color, bool tinted) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: tinted ? color.withValues(alpha: 0.08) : Colors.transparent,
      borderRadius: BorderRadius.circular(6.0),
    ),
    margin: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}
