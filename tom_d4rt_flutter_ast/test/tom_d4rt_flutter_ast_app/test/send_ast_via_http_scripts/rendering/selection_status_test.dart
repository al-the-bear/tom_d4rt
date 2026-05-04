// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep instructive demo for SelectionStatus from rendering.
//
// Subject: `SelectionStatus` lives in `package:flutter/rendering.dart` and
// captures the *current state* of an active selection. It is a tiny enum:
//
//   - SelectionStatus.uncollapsed -> caret has spread; there is a real range.
//   - SelectionStatus.collapsed   -> a caret is present, but start == end.
//   - SelectionStatus.none        -> no caret, no selection at all.
//
// Where it shows up:
//
//   - On `SelectionGeometry.status`, returned by `Selectable.value` and the
//     children of a `SelectionContainer`.
//   - Indirectly drives toolbars, copy buttons, caret blinking and IME
//     interactions: an editor whose status is `none` should not blink a caret
//     at all; an editor whose status is `collapsed` blinks but offers no copy;
//     and an editor whose status is `uncollapsed` is the only one that should
//     enable Cut / Copy / share / format actions on the selection toolbar.
//
// This file is intentionally one of those slow, scroll-down "concept maps"
// that you can drop in front of a teammate to explain what the enum is for in
// one sitting -- without having to draw on a whiteboard.
//
// A peer demo for `SelectionResult` is being authored simultaneously. There
// is real overlap, so the recurring theme of *this* file is:
//
//   "Status describes WHAT the selection is right now (its shape),
//    while SelectionResult describes WHERE the parent should go next."
//
// Keep that line in mind whenever the two enums get muddled in code review.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('SelectionStatus Deep Demo executing');
  print('Flutter exposes ${SelectionStatus.values.length} status values.');
  for (final s in SelectionStatus.values) {
    print('  SelectionStatus.${s.name} (index ${s.index})');
  }

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF512DA8),
          Color(0xFF7B1FA2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
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
                    'SelectionStatus',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart',
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Text(
            'Status describes WHAT the selection currently is. '
            'It does not steer the parent SelectionContainer -- that is '
            'SelectionResult\'s job. Three values, one purpose: tell the UI '
            'whether to draw nothing, a caret, or a real range.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('enum', Icons.code, Color(0xFF80DEEA)),
            _heroChip('rendering', Icons.layers, Color(0xFFFFE082)),
            _heroChip('SelectionGeometry', Icons.straighten, Color(0xFFCE93D8)),
            _heroChip('Selectable', Icons.touch_app, Color(0xFFA5D6A7)),
            _heroChip('${SelectionStatus.values.length} values',
                Icons.tag, Color(0xFFFFAB91)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Concept primer -- where SelectionStatus lives
  // ============================================================
  print('=== Section 2: Concept primer ===');

  final conceptPrimer = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFEDE7F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF7986CB), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF7986CB).withValues(alpha: 0.25),
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
            Icon(Icons.account_tree,
                color: Color(0xFF1A237E), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'From SelectionGeometry to SelectionStatus',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'When Flutter renders selectable text it produces a '
          'SelectionGeometry every time the selection might have changed. '
          'That object describes the current shape of the selection: where '
          'the start handle sits, where the end handle sits, the rectangles '
          'painted under the selected glyphs, whether the SelectionContainer '
          'currently has any content -- and a single status field that '
          'collapses all of that into one of three possibilities.',
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF9FA8DA), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _primerLine(
                Icons.crop_free,
                'SelectionContainer',
                'Owns one or more Selectables and aggregates their geometry.',
                Color(0xFF3F51B5),
              ),
              SizedBox(height: 8.0),
              _primerLine(
                Icons.text_format,
                'Selectable',
                'Reports a SelectionGeometry via its `value` getter.',
                Color(0xFF7B1FA2),
              ),
              SizedBox(height: 8.0),
              _primerLine(
                Icons.straighten,
                'SelectionGeometry',
                'Holds startPoint, endPoint, rects, hasContent, and status.',
                Color(0xFF00897B),
              ),
              SizedBox(height: 8.0),
              _primerLine(
                Icons.flag,
                'SelectionStatus',
                'Single enum field that summarises geometry into 3 states.',
                Color(0xFFC62828),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb,
                  color: Color(0xFFE65100), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Mental model: SelectionGeometry is the "where", '
                  'SelectionStatus is the "what". The toolbar logic only '
                  'looks at status; the painter looks at the rects.',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Color(0xFFBF360C),
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
  // SECTION 3: Per-value cards
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final valueCards = <Widget>[];
  final valueDescriptors = <_StatusDescriptor>[
    _StatusDescriptor(
      status: SelectionStatus.uncollapsed,
      headline: 'A real range is selected',
      subline: 'start != end -- toolbar is enabled',
      icon: Icons.format_color_text,
      color: Color(0xFF2E7D32),
      accent: Color(0xFFA5D6A7),
      mockText:
          'The quick brown fox JUMPS OVER the lazy dog beside the river.',
      caretStart: 20,
      caretEnd: 30,
      whenItAppears: const [
        'User drags across glyphs with the mouse or a finger.',
        'IME / accessibility expands a caret into a word or sentence.',
        'A test calls SelectableRegion.selectAll() programmatically.',
      ],
    ),
    _StatusDescriptor(
      status: SelectionStatus.collapsed,
      headline: 'A caret is parked at one offset',
      subline: 'start == end -- visible caret, no range',
      icon: Icons.text_fields,
      color: Color(0xFFEF6C00),
      accent: Color(0xFFFFCC80),
      mockText: 'Hello, world|',
      caretStart: 12,
      caretEnd: 12,
      whenItAppears: const [
        'User taps once into editable text to position the caret.',
        'After hitting backspace until the selection collapses.',
        'Double-clicking deselects but leaves a caret behind.',
      ],
    ),
    _StatusDescriptor(
      status: SelectionStatus.none,
      headline: 'There is no selection at all',
      subline: 'no caret -- not blinking, not drawn',
      icon: Icons.block,
      color: Color(0xFF6A1B9A),
      accent: Color(0xFFCE93D8),
      mockText: 'Read-only paragraph rendered without focus.',
      caretStart: -1,
      caretEnd: -1,
      whenItAppears: const [
        'Initial state of a fresh SelectionContainer with no children.',
        'Focus moves away and the field clears its selection.',
        'A non-editable Text inside a region nobody is hovering.',
      ],
    ),
  ];

  for (final d in valueDescriptors) {
    print(
      'Card built for SelectionStatus.${d.status.name} (index ${d.status.index})',
    );
    valueCards.add(_statusValueCard(d));
  }

  // ============================================================
  // SECTION 4: Visual state machine
  // ============================================================
  print('=== Section 4: State machine ===');

  final stateMachine = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE0F7FA), Color(0xFFE1F5FE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF26C6DA), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00ACC1).withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The status state machine',
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A typical user session walks through these states many times. '
          'Notice that none(0) is the resting state, collapsed(1) is the '
          'caret state, and uncollapsed(2) is the only one that should '
          'enable selection-toolbar actions.',
          style: TextStyle(fontSize: 12.0, height: 1.4),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _stateNode(
              'NONE',
              SelectionStatus.none,
              Icons.block,
              Color(0xFF6A1B9A),
            ),
            _stateArrow('tap', Color(0xFFEF6C00)),
            _stateNode(
              'COLLAPSED',
              SelectionStatus.collapsed,
              Icons.text_fields,
              Color(0xFFEF6C00),
            ),
            _stateArrow('drag', Color(0xFF2E7D32)),
            _stateNode(
              'UNCOLLAPSED',
              SelectionStatus.uncollapsed,
              Icons.format_color_text,
              Color(0xFF2E7D32),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF80DEEA), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _transitionRow(
                'none', 'collapsed',
                'User taps once to place a caret', Color(0xFFEF6C00),
              ),
              _transitionRow(
                'collapsed', 'uncollapsed',
                'User drags or shift+arrows to grow the range',
                Color(0xFF2E7D32),
              ),
              _transitionRow(
                'uncollapsed', 'collapsed',
                'User clicks once inside the range, dropping the selection',
                Color(0xFFEF6C00),
              ),
              _transitionRow(
                'collapsed', 'none',
                'Field loses focus or content is cleared',
                Color(0xFF6A1B9A),
              ),
              _transitionRow(
                'uncollapsed', 'none',
                'Tap outside the SelectionContainer entirely',
                Color(0xFF6A1B9A),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Comparison with SelectionResult
  // ============================================================
  print('=== Section 5: Comparison with SelectionResult ===');

  final comparisonSection = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFEBEE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFFAB91), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFF7043).withValues(alpha: 0.25),
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
            Icon(Icons.compare_arrows,
                color: Color(0xFFBF360C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'SelectionStatus vs SelectionResult',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'These two enums sit next to each other in selection.dart and get '
          'confused constantly. Status describes WHAT the selection looks '
          'like right now; result tells the parent WHERE TO GO during a '
          'dispatch. They never appear in the same getter.',
          style: TextStyle(fontSize: 13.0, height: 1.45),
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
          ),
          child: Column(
            children: [
              _compareRow(
                'Question',
                'What is the selection?',
                'How should the parent steer next?',
                bold: true,
              ),
              _compareRow(
                'Lives on',
                'SelectionGeometry.status',
                'returned from handleSelectionEvent()',
              ),
              _compareRow(
                'Values',
                'none / collapsed / uncollapsed',
                'pending / next / previous / end / none',
              ),
              _compareRow(
                'Reads',
                'Toolbars, caret painters, copy buttons',
                'SelectionContainer dispatch loop',
              ),
              _compareRow(
                'Updates on',
                'Every selection change',
                'Every selection event handled',
              ),
              _compareRow(
                'Persistence',
                'Sticks around between events',
                'Transient response to a single event',
                isLast: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFCDD2),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE57373), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: Color(0xFFB71C1C), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'If you ever find yourself comparing a status to '
                  '`SelectionResult.next` -- stop. They are different '
                  'types and the code path is wrong.',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Color(0xFF7F0000),
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
  // SECTION 6: Recipe -- caret blink only when collapsed
  // ============================================================
  print('=== Section 6: Recipe -- caret blink ===');

  final recipeBlink = _recipeCard(
    title: 'Recipe 1: blink the caret only when collapsed',
    color: Color(0xFFEF6C00),
    accent: Color(0xFFFFE0B2),
    icon: Icons.text_fields,
    body:
        'A caret painter has no business blinking when there is no selection '
        'at all -- it just wastes paint cycles. Conversely, while the user '
        'has a real range, a blinking caret is visually noisy. So the canonical '
        'pattern is: enable the blink animator only when status is collapsed.',
    code:
        '// Inside an EditableText-like widget\n'
        'void _refreshCaretBlink(SelectionStatus status) {\n'
        '  final shouldBlink = status == SelectionStatus.collapsed;\n'
        '  if (shouldBlink) {\n'
        '    _caretController.repeat(reverse: true);\n'
        '  } else {\n'
        '    _caretController.stop();\n'
        '    _caretController.value = 0.0; // hide\n'
        '  }\n'
        '}',
    bullets: const [
      'none -> stop; we should not even draw the caret rectangle.',
      'collapsed -> repeat; this is the only blinking state.',
      'uncollapsed -> stop; range visualisation already shows the position.',
    ],
  );

  // ============================================================
  // SECTION 7: Recipe -- copy button only when uncollapsed
  // ============================================================
  print('=== Section 7: Recipe -- copy button ===');

  final recipeCopy = _recipeCard(
    title: 'Recipe 2: enable Copy only when uncollapsed',
    color: Color(0xFF2E7D32),
    accent: Color(0xFFC8E6C9),
    icon: Icons.copy,
    body:
        'A selection toolbar should never offer Copy / Cut / Share when there '
        'is nothing to act on. Status gives a single, declarative gate. Wire '
        'the buttons to `status == SelectionStatus.uncollapsed` and let the '
        'rebuild flow handle the rest.',
    code:
        'Widget buildToolbar(SelectionGeometry geometry, VoidCallback onCopy) {\n'
        '  final hasRange = geometry.status == SelectionStatus.uncollapsed;\n'
        '  return Row(\n'
        '    children: <Widget>[\n'
        '      TextButton(\n'
        '        onPressed: hasRange ? onCopy : null,\n'
        '        child: const Text(\'Copy\'),\n'
        '      ),\n'
        '      TextButton(\n'
        '        onPressed: hasRange ? () => doCut() : null,\n'
        '        child: const Text(\'Cut\'),\n'
        '      ),\n'
        '    ],\n'
        '  );\n'
        '}',
    bullets: const [
      'none / collapsed -> all action buttons are disabled.',
      'uncollapsed -> the toolbar lights up.',
      'No need to inspect the actual rect; status is the contract.',
    ],
  );

  // ============================================================
  // SECTION 8: Recipe -- cursor placement when none
  // ============================================================
  print('=== Section 8: Recipe -- cursor placement ===');

  final recipePlacement = _recipeCard(
    title: 'Recipe 3: cursor placement when status is none',
    color: Color(0xFF6A1B9A),
    accent: Color(0xFFE1BEE7),
    icon: Icons.mouse,
    body:
        'A widget that wants to show the I-beam cursor only when text is '
        'actually present should treat status none as a hard reset: hide the '
        'cursor, drop any hover state, and let the parent decide whether to '
        'spawn a fresh caret on next tap.',
    code:
        'MouseCursor cursorFor(SelectionGeometry geometry) {\n'
        '  switch (geometry.status) {\n'
        '    case SelectionStatus.none:\n'
        '      return SystemMouseCursors.basic;\n'
        '    case SelectionStatus.collapsed:\n'
        '    case SelectionStatus.uncollapsed:\n'
        '      return SystemMouseCursors.text;\n'
        '  }\n'
        '}',
    bullets: const [
      'none is the only "you are not over selectable text" branch.',
      'collapsed and uncollapsed both deserve the I-beam.',
      'The exhaustive switch makes future enum additions a compile error.',
    ],
  );

  // ============================================================
  // SECTION 9: Pitfalls
  // ============================================================
  print('=== Section 9: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFCE4EC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE57373), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFE53935).withValues(alpha: 0.22),
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
            Icon(Icons.report_problem,
                color: Color(0xFFB71C1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallTile(
          'none vs empty selection',
          'A SelectionContainer that has zero selectable children reports '
          '`status == SelectionStatus.none` AND `hasContent == false`. A '
          'container with content but nothing currently picked also reports '
          'none, but with `hasContent == true`. Read both fields when you '
          'need to distinguish "nothing here" from "nothing chosen".',
          Color(0xFFB71C1C),
        ),
        _pitfallTile(
          'programmatic vs user selection',
          'Calling `SelectableRegion.selectAll()` flips the status straight '
          'to uncollapsed without ever passing through collapsed. Do not '
          'rely on intermediate states inside golden tests -- assert on '
          'the final status instead.',
          Color(0xFFAD1457),
        ),
        _pitfallTile(
          'collapsed != caret blinking',
          'Status is purely descriptive; it does not animate by itself. If '
          'your caret is not blinking when collapsed, double-check that you '
          'wired an Animation listener -- the enum cannot do that for you.',
          Color(0xFF6A1B9A),
        ),
        _pitfallTile(
          'using status for navigation',
          'Status answers WHAT, not WHERE. Routing dispatched events through '
          '`status == SelectionStatus.uncollapsed` instead of inspecting '
          '`SelectionResult` will subtly break multi-child containers where '
          'one Selectable owns the range and the others contribute nothing.',
          Color(0xFF4A148C),
        ),
        _pitfallTile(
          'forgetting the third branch',
          'Three values, three switch arms. Adding an if/else for collapsed '
          'and uncollapsed and ignoring none is the most common bug; use a '
          'switch so the analyzer enforces exhaustiveness.',
          Color(0xFF311B92),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: API surface cheat sheet
  // ============================================================
  print('=== Section 10: API surface ===');

  final apiSurface = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
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
            Icon(Icons.terminal,
                color: Color(0xFF80DEEA), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'enum SelectionStatus -- at a glance',
              style: TextStyle(
                color: Color(0xFF80DEEA),
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeLine(
          'SelectionStatus.values.length',
          '${SelectionStatus.values.length}',
        ),
        _codeLine(
          'SelectionStatus.values.first',
          SelectionStatus.values.first.toString(),
        ),
        _codeLine(
          'SelectionStatus.values.last',
          SelectionStatus.values.last.toString(),
        ),
        for (final s in SelectionStatus.values)
          _codeLine(
            'SelectionStatus.${s.name}.index',
            '${s.index}',
          ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// SelectionGeometry exposes status as a non-nullable getter\n'
            'SelectionStatus get status; // never null\n'
            '\n'
            '// Idiomatic exhaustive switch\n'
            'switch (geometry.status) {\n'
            '  case SelectionStatus.none:        return _buildEmpty();\n'
            '  case SelectionStatus.collapsed:   return _buildCaret();\n'
            '  case SelectionStatus.uncollapsed: return _buildRange();\n'
            '}',
            style: TextStyle(
              color: Color(0xFFB2EBF2),
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Footer
  // ============================================================
  print('=== Section 11: Footer ===');

  final footer = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF311B92)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.4),
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
            Icon(Icons.insert_drive_file,
                color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'File',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
            'send_ast_via_http_scripts/rendering/selection_status_test.dart',
            style: TextStyle(
              color: Color(0xFFB39DDB),
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          child: Text(
            // ASCII box recap.
            '+----------------------------------------------------------+\n'
            '|                  SelectionStatus recap                   |\n'
            '+----------------------------------------------------------+\n'
            '|  none        -> nothing to draw, no caret, no range      |\n'
            '|  collapsed   -> single caret, start == end               |\n'
            '|  uncollapsed -> real range, toolbar enabled              |\n'
            '+----------------------------------------------------------+\n'
            '|  status answers WHAT  /  result answers WHERE-TO-GO      |\n'
            '+----------------------------------------------------------+',
            style: TextStyle(
              color: Color(0xFFE1BEE7),
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('SelectionStatus Deep Demo built all sections successfully');

  // ============================================================
  // Final composition
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        _sectionTitle('1. Concept primer'),
        conceptPrimer,
        _sectionTitle('2. The three values, in detail'),
        ...valueCards,
        _sectionTitle('3. State machine'),
        stateMachine,
        _sectionTitle('4. SelectionStatus vs SelectionResult'),
        comparisonSection,
        _sectionTitle('5. Recipe: caret blink only when collapsed'),
        recipeBlink,
        _sectionTitle('6. Recipe: copy button only when uncollapsed'),
        recipeCopy,
        _sectionTitle('7. Recipe: cursor placement when none'),
        recipePlacement,
        _sectionTitle('8. Pitfalls'),
        pitfalls,
        _sectionTitle('9. API surface'),
        apiSurface,
        SizedBox(height: 8.0),
        footer,
        SizedBox(height: 12.0),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Helper data record (avoids StatefulWidget while keeping cards tidy)
// ------------------------------------------------------------------
class _StatusDescriptor {
  const _StatusDescriptor({
    required this.status,
    required this.headline,
    required this.subline,
    required this.icon,
    required this.color,
    required this.accent,
    required this.mockText,
    required this.caretStart,
    required this.caretEnd,
    required this.whenItAppears,
  });

  final SelectionStatus status;
  final String headline;
  final String subline;
  final IconData icon;
  final Color color;
  final Color accent;
  final String mockText;
  final int caretStart;
  final int caretEnd;
  final List<String> whenItAppears;
}

// ------------------------------------------------------------------
// Section title helper
// ------------------------------------------------------------------
Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 28.0, bottom: 10.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 24.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B1FA2), Color(0xFF1A237E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Hero chip
// ------------------------------------------------------------------
Widget _heroChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: color.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Concept primer line
// ------------------------------------------------------------------
Widget _primerLine(IconData icon, String title, String body, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: color, size: 18.0),
      ),
      SizedBox(width: 10.0),
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
            SizedBox(height: 2.0),
            Text(
              body,
              style: TextStyle(fontSize: 12.0, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ------------------------------------------------------------------
// Per-value card with mock paragraph + caret/range visualisation
// ------------------------------------------------------------------
Widget _statusValueCard(_StatusDescriptor d) {
  return Container(
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          d.accent.withValues(alpha: 0.25),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: d.color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: d.color.withValues(alpha: 0.25),
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
                color: d.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: d.color, width: 1.0),
              ),
              child: Icon(d.icon, color: d.color, size: 24.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SelectionStatus.${d.status.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: d.color,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    d.headline,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    d.subline,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: d.color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'index ${d.status.index}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: d.color.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mock paragraph (rendered visualisation):',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              _buildMockParagraph(d),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: d.accent.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.event, color: d.color, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    'When this status appears',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: d.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              for (final w in d.whenItAppears)
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  - ',
                        style: TextStyle(
                          color: d.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          w,
                          style: TextStyle(
                            fontSize: 12.0,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Mock paragraph -- draws caret or range stripe over fake text.
// ------------------------------------------------------------------
Widget _buildMockParagraph(_StatusDescriptor d) {
  // For "none" we draw greyed text without anything else.
  if (d.status == SelectionStatus.none) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        d.mockText,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13.0,
          color: Colors.grey.shade600,
          height: 1.6,
        ),
      ),
    );
  }

  // For collapsed and uncollapsed we slice the text into segments.
  final text = d.mockText;
  final start = d.caretStart.clamp(0, text.length);
  final end = d.caretEnd.clamp(0, text.length);
  final pre = text.substring(0, start);
  final mid = start == end ? '' : text.substring(start, end);
  final post = text.substring(end);

  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: d.color.withValues(alpha: 0.5)),
    ),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13.0,
          color: Colors.black87,
          height: 1.6,
        ),
        children: [
          TextSpan(text: pre),
          if (start == end)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                width: 2.0,
                height: 16.0,
                color: d.color,
              ),
            )
          else
            TextSpan(
              text: mid,
              style: TextStyle(
                backgroundColor: d.accent.withValues(alpha: 0.85),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          TextSpan(text: post),
        ],
      ),
    ),
  );
}

// ------------------------------------------------------------------
// State machine helpers
// ------------------------------------------------------------------
Widget _stateNode(
  String label,
  SelectionStatus status,
  IconData icon,
  Color color,
) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.32),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, size: 26.0, color: color),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'index ${status.index}',
          style: TextStyle(
            fontSize: 9.0,
            fontFamily: 'monospace',
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _stateArrow(String label, Color color) {
  return Column(
    children: [
      Icon(Icons.arrow_forward, color: color, size: 20.0),
      SizedBox(height: 2.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _transitionRow(
  String from,
  String to,
  String trigger,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.45)),
          ),
          child: Text(
            from,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.east, size: 14.0, color: color),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.45)),
          ),
          child: Text(
            to,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            trigger,
            style: TextStyle(fontSize: 12.0, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Comparison row
// ------------------------------------------------------------------
Widget _compareRow(
  String label,
  String left,
  String right, {
  bool bold = false,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom: BorderSide(color: Color(0xFFFFE0B2), width: 1.0),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFBF360C),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              left,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: Color(0xFF1B5E20),
                height: 1.4,
              ),
            ),
          ),
        ),
        Container(
          width: 1.0,
          height: 24.0,
          color: Color(0xFFFFB74D),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              right,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: Color(0xFF0D47A1),
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Recipe card
// ------------------------------------------------------------------
Widget _recipeCard({
  required String title,
  required Color color,
  required Color accent,
  required IconData icon,
  required String body,
  required String code,
  required List<String> bullets,
}) {
  return Container(
    margin: EdgeInsets.only(top: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent.withValues(alpha: 0.4), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(body, style: TextStyle(fontSize: 13.0, height: 1.5)),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFB2EBF2),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle,
                    size: 14.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Pitfall tile
// ------------------------------------------------------------------
Widget _pitfallTile(String title, String body, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
        top: BorderSide(color: color.withValues(alpha: 0.2)),
        right: BorderSide(color: color.withValues(alpha: 0.2)),
        bottom: BorderSide(color: color.withValues(alpha: 0.2)),
      ),
    ),
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
        Text(body, style: TextStyle(fontSize: 12.0, height: 1.4)),
      ],
    ),
  );
}

// ------------------------------------------------------------------
// Code line for the API surface block
// ------------------------------------------------------------------
Widget _codeLine(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFB39DDB),
            ),
          ),
        ),
        Text(
          ' => ',
          style: TextStyle(
            color: Color(0xFFFFAB91),
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFA5D6A7),
            ),
          ),
        ),
      ],
    ),
  );
}
