// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionResult enum from package:flutter/rendering.dart
// Deep Demo: Visual demonstration of the SelectionResult enum that drives
// child-traversal decisions inside the SelectionContainer / Selectable system.
//
// SelectionResult is the answer a Selectable returns when its parent dispatches
// a SelectionEvent (start/end/clear/granularity-aware update). The parent uses
// the returned value to decide whether to stop, to keep walking forward, to
// keep walking backward, or to defer the decision to the next layout pass.
//
// Values covered (5 in total):
//   - SelectionResult.next      -> parent should advance to the next child
//   - SelectionResult.previous  -> parent should rewind to the previous child
//   - SelectionResult.end       -> selection terminates inside this Selectable
//   - SelectionResult.pending   -> child cannot decide yet (waiting on layout)
//   - SelectionResult.none      -> child is not selectable / event was ignored
//
// Verified against:
//   lib/src/bridges/rendering_bridges.b.dart
//     - BridgedEnumDefinition<SelectionResult>(name: 'SelectionResult', ...)
//     - dispatchSelectionEvent: 'SelectionResult dispatchSelectionEvent(...)'
//     - getResultBasedOnRect: 'SelectionResult getResultBasedOnRect(...)'

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================
// Top-level entry point used by the d4rt http-script harness.
// ============================================================
dynamic build(BuildContext context) {
  print('SelectionResult Deep Demo executing');
  print('Flutter rendering enum: SelectionResult.values.length = '
      '${SelectionResult.values.length}');

  // ------------------------------------------------------------
  // Section 1: HERO HEADER
  // ------------------------------------------------------------
  print('=== Section 1: Hero Header ===');
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 18.0),
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
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.text_fields,
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
                    'SelectionResult',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'package:flutter/rendering.dart',
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
        Text(
          'How a Selectable answers its parent SelectionContainer when a '
          'SelectionEvent is dispatched. The returned enum decides whether the '
          'parent moves forward, rewinds, terminates, defers, or skips the '
          'child entirely.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('5 enum values', Icons.list_alt),
            _heroChip('returned by Selectable', Icons.touch_app),
            _heroChip('drives traversal', Icons.alt_route),
            _heroChip('selection plumbing', Icons.account_tree),
          ],
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 2: CONCEPT PRIMER
  // ------------------------------------------------------------
  print('=== Section 2: Concept Primer ===');
  final conceptPrimer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
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
            Icon(Icons.school, color: Colors.indigo.shade700),
            SizedBox(width: 8.0),
            Text(
              'Why a result enum exists',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _primerParagraph(
          'A SelectionContainer holds many Selectable children (paragraph '
          'spans, list items, custom widgets). When the user drags a '
          'selection, the container dispatches the same SelectionEvent down '
          'to each candidate child by calling dispatchSelectionEvent.',
        ),
        SizedBox(height: 10.0),
        _primerParagraph(
          'A simple boolean ("did you handle it?") is not enough. The parent '
          'also needs to know which way to keep walking, whether the child is '
          'still computing, and whether the gesture should stop right here. '
          'SelectionResult encodes all of those in a single return value.',
        ),
        SizedBox(height: 10.0),
        _primerParagraph(
          'Mental model: each Selectable behaves like a node in a doubly '
          'linked list. The enum is the navigation arrow that node hands '
          'back: keep going, turn around, you found me, wait, or skip me.',
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'abstract class Selectable {\n'
            '  SelectionResult dispatchSelectionEvent(SelectionEvent e);\n'
            '  // ... position, geometry, content getters\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyan.shade200,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 3: PER-VALUE CARDS
  // ------------------------------------------------------------
  print('=== Section 3: Per-Value Cards ===');
  final valueCards = <Widget>[];
  final valueData = <Map<String, Object>>[
    {
      'value': SelectionResult.next,
      'label': 'NEXT',
      'icon': Icons.arrow_forward,
      'color': Colors.green,
      'meaning':
          'The selection edge passed completely through this child. Move on.',
      'parentAction':
          'Parent advances its iterator to the next child and dispatches the '
              'same event again.',
      'returnedWhen':
          'A text span finished consuming a forward drag and the cursor exited '
              'on its trailing side.',
    },
    {
      'value': SelectionResult.previous,
      'label': 'PREVIOUS',
      'icon': Icons.arrow_back,
      'color': Colors.orange,
      'meaning':
          'The selection edge passed completely through this child going the '
              'other way. Walk back.',
      'parentAction':
          'Parent rewinds its iterator to the previous child and dispatches '
              'the event again.',
      'returnedWhen':
          'A reverse drag exited on the leading side, or selectWord landed '
              'before this Selectable\'s start.',
    },
    {
      'value': SelectionResult.end,
      'label': 'END',
      'icon': Icons.adjust,
      'color': Colors.blue,
      'meaning':
          'The selection edge landed inside this Selectable. Stop here.',
      'parentAction':
          'Parent stops walking. The current child owns the active edge and '
              'will paint the highlight.',
      'returnedWhen':
          'A tap or drag landed on a glyph belonging to this Selectable; '
              'getResultBasedOnRect returned end.',
    },
    {
      'value': SelectionResult.pending,
      'label': 'PENDING',
      'icon': Icons.hourglass_top,
      'color': Colors.amber.shade800,
      'meaning':
          'The child cannot decide yet (still laying out, async content, '
              'off-screen lazy list).',
      'parentAction':
          'Parent keeps the event queued and re-dispatches it after the next '
              'layout pass.',
      'returnedWhen':
          'A SliverList item that has not yet been built, or a custom widget '
              'awaiting an ImageStream/network result.',
    },
    {
      'value': SelectionResult.none,
      'label': 'NONE',
      'icon': Icons.block,
      'color': Colors.grey.shade700,
      'meaning':
          'This Selectable cannot or will not respond to the event at all.',
      'parentAction':
          'Parent treats the child as inert and continues with the next '
              'candidate, leaving any prior decision intact.',
      'returnedWhen':
          'A purely decorative widget registered as Selectable, or an event '
              'type the child does not recognise.',
    },
  ];

  for (final data in valueData) {
    final value = data['value'] as SelectionResult;
    final color = data['color'] as Color;
    print('SelectionResult.${value.name} - index ${value.index}');
    valueCards.add(_buildValueCard(value, data, color));
  }
  print('Built ${valueCards.length} per-value cards');

  // ------------------------------------------------------------
  // Section 4: TRAVERSAL FLOW DIAGRAM
  // ------------------------------------------------------------
  print('=== Section 4: Traversal Flow Diagram ===');
  final traversalFlow = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selection traversal flow',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Parent dispatches once. Child answers with a SelectionResult. '
          'The arrow below shows what the parent does next.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 18.0),
        // Parent box
        _flowParentBox(),
        SizedBox(height: 8.0),
        Center(
          child: Icon(
            Icons.arrow_downward,
            color: Colors.teal.shade400,
            size: 28.0,
          ),
        ),
        // Child row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _flowChildBox('Child A', Colors.green),
            _flowChildBox('Child B', Colors.amber.shade700),
            _flowChildBox('Child C', Colors.blue),
            _flowChildBox('Child D', Colors.deepPurple),
          ],
        ),
        SizedBox(height: 18.0),
        // Result-to-action arrows table
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            children: [
              _flowRow(SelectionResult.next, 'iterator++   (forward walk)',
                  Colors.green),
              _flowDivider(),
              _flowRow(SelectionResult.previous,
                  'iterator--   (rewind walk)', Colors.orange),
              _flowDivider(),
              _flowRow(SelectionResult.end,
                  'stop walking, attach edge here', Colors.blue),
              _flowDivider(),
              _flowRow(SelectionResult.pending,
                  'queue event, retry after layout', Colors.amber.shade800),
              _flowDivider(),
              _flowRow(SelectionResult.none,
                  'skip child, keep prior decision', Colors.grey.shade700),
            ],
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 5: MOCK PARAGRAPH WITH MULTI-SPAN SELECTION
  // ------------------------------------------------------------
  print('=== Section 5: Mock Paragraph Multi-Span ===');
  final spans = <_MockSpan>[
    _MockSpan('The ', SelectionResult.next, Colors.green),
    _MockSpan('quick ', SelectionResult.next, Colors.green),
    _MockSpan('brown ', SelectionResult.end, Colors.blue),
    _MockSpan('fox ', SelectionResult.previous, Colors.orange),
    _MockSpan('jumps ', SelectionResult.pending, Colors.amber.shade800),
    _MockSpan('over ', SelectionResult.none, Colors.grey.shade600),
    _MockSpan('the ', SelectionResult.next, Colors.green),
    _MockSpan('lazy ', SelectionResult.end, Colors.blue),
    _MockSpan('dog.', SelectionResult.none, Colors.grey.shade600),
  ];

  final mockParagraph = Container(
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
          color: Colors.deepPurple.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_color_text, color: Colors.deepPurple.shade700),
            SizedBox(width: 8.0),
            Text(
              'Multi-span selection illustration',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Each span is its own Selectable. The colour shows what the span '
          'returns when the parent dispatches the event.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: [
            for (final span in spans) _buildMockSpanChip(span),
          ],
        ),
        SizedBox(height: 16.0),
        // Traversal arrow strip
        Row(
          children: [
            for (var i = 0; i < spans.length; i++)
              Expanded(
                child: _spanArrow(spans[i]),
              ),
          ],
        ),
        SizedBox(height: 12.0),
        // Legend
        Wrap(
          spacing: 10.0,
          runSpacing: 6.0,
          children: [
            for (final v in SelectionResult.values) _spanLegendChip(v),
          ],
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 6: RECIPES
  // ------------------------------------------------------------
  print('=== Section 6: Recipes ===');
  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
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
          color: Colors.black.withValues(alpha: 0.35),
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
            Icon(Icons.menu_book, color: Colors.cyan.shade300),
            SizedBox(width: 8.0),
            Text(
              'Three small recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _recipeBlock(
          'Recipe 1 - end on first hit',
          'A custom Selectable that always claims the selection as soon as '
              'the event\'s point lands inside its rect. Good for atomic '
              'widgets like a chip or a token that should not be split.',
          '@override\n'
              'SelectionResult dispatchSelectionEvent(SelectionEvent e) {\n'
              '  if (e is SelectionEdgeUpdateEvent) {\n'
              '    final hit = bounds.contains(e.globalPosition);\n'
              '    if (hit) {\n'
              '      _attachEdge(e);\n'
              '      return SelectionResult.end;\n'
              '    }\n'
              '  }\n'
              '  return SelectionResult.next;\n'
              '}',
          Colors.blue.shade300,
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          'Recipe 2 - pending while waiting for layout',
          'A lazy list tile that has not produced a RenderBox yet. Returning '
              'pending tells the parent "ask me again next frame" rather '
              'than guessing.',
          'SelectionResult dispatchSelectionEvent(SelectionEvent e) {\n'
              '  if (!_hasLaidOut) {\n'
              '    _scheduleRebuild();\n'
              '    return SelectionResult.pending;\n'
              '  }\n'
              '  return _resolve(e);\n'
              '}',
          Colors.amber.shade300,
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          'Recipe 3 - none for a non-selectable widget',
          'A divider, an icon, or a decorative container that participates '
              'in the SelectionContainer for layout reasons but has no text '
              'to select.',
          'SelectionResult dispatchSelectionEvent(SelectionEvent e) {\n'
              '  // No text, no glyphs. Always skip me.\n'
              '  return SelectionResult.none;\n'
              '}',
          Colors.grey.shade300,
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 7: COMPARISON vs SelectionStatus
  // ------------------------------------------------------------
  print('=== Section 7: SelectionResult vs SelectionStatus ===');
  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.deepOrange.shade700),
            SizedBox(width: 8.0),
            Text(
              'SelectionResult vs SelectionStatus',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Both enums sit in the same selection subsystem but answer very '
          'different questions.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _compareCard(
                'SelectionResult',
                'Returned by Selectable.dispatchSelectionEvent.',
                'Tells the PARENT how to keep traversing children after this '
                    'one answered.',
                ['next', 'previous', 'end', 'pending', 'none'],
                Colors.indigo,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _compareCard(
                'SelectionStatus',
                'Reported by SelectionGeometry.status.',
                'Describes the OVERALL state of the selection inside a '
                    'SelectionContainer (collapsed vs uncollapsed).',
                ['none', 'collapsed', 'uncollapsed'],
                Colors.deepOrange,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: Text(
            'Rule of thumb: SelectionResult is a navigation instruction, '
            'SelectionStatus is a snapshot. One is "what do I do next", the '
            'other is "what does the world look like right now".',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepOrange.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 8: PITFALLS
  // ------------------------------------------------------------
  print('=== Section 8: Pitfalls ===');
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and infinite loops',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfall(
          'Returning next when the event already passed the last child',
          'The parent walks off the end of its iterator and may dispatch a '
              'synthetic event back from the start. Symptom: the highlight '
              'flickers between the first and last span.',
        ),
        _pitfall(
          'Returning previous after returning next for the same event',
          'The parent ping-pongs between two children, each one telling the '
              'other "go that way". You will see CPU pegged and the gesture '
              'never settling.',
        ),
        _pitfall(
          'Returning end without storing the edge',
          'You told the parent to stop here, but did not remember which '
              'glyph received the edge. Subsequent paint passes will draw a '
              'highlight that snaps to (0,0) of the Selectable.',
        ),
        _pitfall(
          'Returning pending forever',
          'If the child never finishes laying out, the parent keeps '
              're-dispatching forever. Always pair pending with a concrete '
              'rebuild trigger (markNeedsLayout or scheduleFrame).',
        ),
        _pitfall(
          'Returning none when you actually wanted next',
          'none means "I am inert". The parent will skip you AND not advance '
              'its own walk based on you. Use next when you simply did not '
              'contain the edge but the walk should continue.',
        ),
      ],
    ),
  );

  // ------------------------------------------------------------
  // Section 9: FOOTER
  // ------------------------------------------------------------
  print('=== Section 9: Footer ===');
  final footer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.blueGrey.shade900],
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
        Text(
          '+----------------------------------------------------------+\n'
          '|  SelectionResult - rendering/selection.dart              |\n'
          '|  values: next | previous | end | pending | none          |\n'
          '|  used by: Selectable.dispatchSelectionEvent              |\n'
          '|  sibling: SelectionStatus (geometry-level)               |\n'
          '+----------------------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.greenAccent.shade400,
            height: 1.35,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'File: test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts'
          '/rendering/selection_result_test.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Bridge: lib/src/bridges/rendering_bridges.b.dart '
          '(BridgedEnumDefinition<SelectionResult>)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );

  print('SelectionResult Deep Demo completed successfully');
  print('Total sections rendered: 9');

  // ============================================================
  // Compose the page
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 24.0),
        _sectionTitle('1. Concept primer'),
        conceptPrimer,
        SizedBox(height: 24.0),
        _sectionTitle('2. Per-value cards'),
        Wrap(
          alignment: WrapAlignment.center,
          children: valueCards,
        ),
        SizedBox(height: 24.0),
        _sectionTitle('3. Traversal flow'),
        traversalFlow,
        SizedBox(height: 24.0),
        _sectionTitle('4. Multi-span selection'),
        mockParagraph,
        SizedBox(height: 24.0),
        _sectionTitle('5. Recipes'),
        recipes,
        SizedBox(height: 24.0),
        _sectionTitle('6. SelectionResult vs SelectionStatus'),
        comparison,
        SizedBox(height: 24.0),
        _sectionTitle('7. Pitfalls'),
        pitfalls,
        SizedBox(height: 24.0),
        _sectionTitle('8. Footer'),
        footer,
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: Colors.white),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _primerParagraph(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.chevron_right, size: 18.0, color: Colors.indigo.shade400),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.indigo.shade900,
            height: 1.45,
          ),
        ),
      ),
    ],
  );
}

Widget _buildValueCard(
  SelectionResult value,
  Map<String, Object> data,
  Color color,
) {
  final label = data['label'] as String;
  final icon = data['icon'] as IconData;
  final meaning = data['meaning'] as String;
  final parentAction = data['parentAction'] as String;
  final returnedWhen = data['returnedWhen'] as String;
  return Container(
    width: 320.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
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
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: color, size: 28.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'SelectionResult.${value.name}  (index ${value.index})',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _cardField('Meaning', meaning, color),
        SizedBox(height: 8.0),
        _cardField('Parent action', parentAction, color),
        SizedBox(height: 8.0),
        _cardField('Returned when', returnedWhen, color),
        SizedBox(height: 12.0),
        _mockHighlight(value, color),
      ],
    ),
  );
}

Widget _cardField(String title, String body, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: color.withValues(alpha: 0.85),
        ),
      ),
      SizedBox(height: 2.0),
      Text(
        body,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    ],
  );
}

Widget _mockHighlight(SelectionResult value, Color color) {
  // Visual: a paragraph fragment with a highlight band drawn differently for
  // each result.
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mock highlight',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            for (var i = 0; i < 8; i++)
              _highlightSlice(i, value, color),
          ],
        ),
      ],
    ),
  );
}

Widget _highlightSlice(int i, SelectionResult value, Color color) {
  // The "selection edge" sits at slot 4 in this mocked paragraph.
  Color slot;
  switch (value) {
    case SelectionResult.next:
      slot = i <= 7 && i >= 0 && i < 8 && i < 8
          ? (i < 8 ? color.withValues(alpha: 0.7) : Colors.transparent)
          : Colors.transparent;
      slot = color.withValues(alpha: 0.6); // entire slice highlighted (passed)
      break;
    case SelectionResult.previous:
      slot = Colors.transparent; // already moved back, nothing here yet
      break;
    case SelectionResult.end:
      slot = i <= 4 ? color.withValues(alpha: 0.65) : Colors.transparent;
      break;
    case SelectionResult.pending:
      slot = i.isEven
          ? color.withValues(alpha: 0.35)
          : color.withValues(alpha: 0.15);
      break;
    case SelectionResult.none:
      slot = Colors.transparent;
      break;
  }
  return Expanded(
    child: Container(
      height: 18.0,
      margin: EdgeInsets.symmetric(horizontal: 1.0),
      decoration: BoxDecoration(
        color: slot,
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 0.5,
        ),
      ),
    ),
  );
}

Widget _flowParentBox() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade400, width: 2.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_tree, color: Colors.teal.shade800),
        SizedBox(width: 8.0),
        Text(
          'SelectionContainer (parent)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(width: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'dispatchSelectionEvent(e)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _flowChildBox(String label, Color color) {
  return Container(
    width: 86.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(Icons.text_snippet, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'Selectable',
          style: TextStyle(
            fontSize: 9.0,
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _flowRow(SelectionResult value, String action, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 110.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color),
          ),
          child: Text(
            value.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(Icons.east, color: color, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            action,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _flowDivider() {
  return Divider(height: 4.0, color: Colors.teal.shade100);
}

Widget _buildMockSpanChip(_MockSpan span) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: span.color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: span.color.withValues(alpha: 0.6)),
    ),
    child: Text(
      span.text,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _spanArrow(_MockSpan span) {
  IconData icon;
  switch (span.result) {
    case SelectionResult.next:
      icon = Icons.east;
      break;
    case SelectionResult.previous:
      icon = Icons.west;
      break;
    case SelectionResult.end:
      icon = Icons.flag;
      break;
    case SelectionResult.pending:
      icon = Icons.hourglass_empty;
      break;
    case SelectionResult.none:
      icon = Icons.remove;
      break;
  }
  return Column(
    children: [
      Icon(icon, color: span.color, size: 18.0),
      Text(
        span.result.name,
        style: TextStyle(
          fontSize: 9.0,
          color: span.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _spanLegendChip(SelectionResult value) {
  Color color;
  switch (value) {
    case SelectionResult.next:
      color = Colors.green;
      break;
    case SelectionResult.previous:
      color = Colors.orange;
      break;
    case SelectionResult.end:
      color = Colors.blue;
      break;
    case SelectionResult.pending:
      color = Colors.amber.shade800;
      break;
    case SelectionResult.none:
      color = Colors.grey.shade700;
      break;
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          value.name,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _recipeBlock(
  String title,
  String description,
  String code,
  Color codeColor,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: codeColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareCard(
  String title,
  String oneLiner,
  String purpose,
  List<String> values,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          oneLiner,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          purpose,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            for (final v in values)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  v,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: color,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900,
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

class _MockSpan {
  final String text;
  final SelectionResult result;
  final Color color;
  const _MockSpan(this.text, this.result, this.color);
}
