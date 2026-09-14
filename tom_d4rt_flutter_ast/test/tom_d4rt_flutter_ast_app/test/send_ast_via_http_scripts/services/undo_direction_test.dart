// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: UndoDirection enum from package:flutter/services.dart
//
// Subject: UndoDirection { undo, redo }
//   - Used by UndoManager and the embedder to communicate undo/redo intents
//     coming from the platform (iOS shake-to-undo, hardware/software keyboards,
//     macOS Edit menu, Android keyboard shortcuts, etc.).
//   - Surfaces in TextInputClient.handlePlatformUndo(UndoDirection direction)
//     and is the discriminator inside UndoTextIntent / UndoHistory state
//     processing.
//
// This script is purely declarative: it never actually calls UndoManager or
// pushes channel messages. Every "history stack" you see is a hand-rolled mock
// rendered as widgets, so the demo can be replayed deterministically by the
// d4rt interpreter without touching real platform plumbing.
//
// File layout (sections):
//   1. Hero header with platform pill row
//   2. Concept diagram   (history stack with cursor + arrows)
//   3. Per-value cards   (undo / redo)
//   4. Mock history stack (8 chips + cursor)
//   5. Worked example flow ("Hello", undo x3, redo x2)
//   6. UndoHistory + UndoTextIntent integration sketch (pseudocode)
//   7. Recipes (text editor / drawing app / form rollback)
//   8. Pitfalls and gotchas
//   9. Footer with file path + ASCII summary box
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('UndoDirection deep demo executing');
  print('flutter/services UndoDirection enum has '
      '${UndoDirection.values.length} values');

  for (final value in UndoDirection.values) {
    print('  UndoDirection.${value.name} (index=${value.index})');
  }
  print('first=${UndoDirection.values.first.name} '
      'last=${UndoDirection.values.last.name}');

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
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
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
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(Icons.history, size: 40.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UndoDirection',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${UndoDirection.values.length} values',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'The discriminator the platform sends when it asks Flutter to undo '
          'or redo. This is the entire enum — two values, but the wiring '
          'around it spans UndoManager, UndoHistory, UndoTextIntent and the '
          'shake/keyboard/menu bridges of every host OS.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _platformPill('iOS', '⇠ shake / ⌘Z', Color(0xFF42A5F5)),
            _platformPill('macOS', '⌘Z / ⇧⌘Z', Color(0xFF7E57C2)),
            _platformPill('Android', 'IME shortcut', Color(0xFF26A69A)),
            _platformPill('Web', 'Browser UA', Color(0xFFEF5350)),
            _platformPill('Linux', 'Ctrl+Z', Color(0xFFFFA726)),
            _platformPill('Windows', 'Ctrl+Z', Color(0xFF66BB6A)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Concept diagram — history stack with cursor + arrows
  // ============================================================
  print('=== Section 2: Concept diagram ===');

  final conceptDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF9FA8DA), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
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
            Icon(Icons.account_tree, color: Color(0xFF3F51B5)),
            SizedBox(width: 8.0),
            Text(
              'Conceptual Model: a linear history with a cursor',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Every undoable widget keeps a list of previous states and a cursor '
          'pointing at the "current" one. UndoDirection.undo decrements the '
          'cursor; UndoDirection.redo increments it. Edits past the cursor '
          'truncate the future tail.',
          style: TextStyle(fontSize: 13.0, height: 1.4),
        ),
        SizedBox(height: 18.0),
        // Inline ASCII-ish diagram, rendered as styled tiles
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _conceptTile('S0', Color(0xFFB39DDB), false),
            _conceptDash(),
            _conceptTile('S1', Color(0xFF9575CD), false),
            _conceptDash(),
            _conceptTile('S2', Color(0xFF7E57C2), true), // cursor
            _conceptDash(),
            _conceptTile('S3', Color(0xFFB0BEC5), false),
            _conceptDash(),
            _conceptTile('S4', Color(0xFFCFD8DC), false),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEF9A9A), Color(0xFFE57373)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'UndoDirection.undo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Text('cursor at S2',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Color(0xFF4A148C),
                  fontWeight: FontWeight.bold,
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA5D6A7), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'UndoDirection.redo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18.0),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (undo, redo)
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final undoCard = _valueCard(
    name: 'undo',
    index: UndoDirection.undo.index,
    title: 'Step backward in history',
    description:
        'Move the cursor to the previous state. The platform sends this when '
        'the user requests an undo through any host UI (keyboard shortcut, '
        'menu, shake gesture, accessibility command).',
    semantics: const [
      'Pre: cursor > 0',
      'Post: cursor := cursor - 1',
      'Effect: editor restores prior snapshot',
      'No-op when at the bottom of the stack',
    ],
    shortcuts: const [
      ['iOS', 'Shake device · ⌘Z (hardware kbd)'],
      ['macOS', 'Edit menu · ⌘Z'],
      ['Android', 'Ctrl+Z (kbd) · IME hint'],
      ['Web', 'Browser-controlled (UA)'],
      ['Linux', 'Ctrl+Z'],
      ['Windows', 'Ctrl+Z'],
    ],
    accent: Color(0xFFD32F2F),
    accentSoft: Color(0xFFFFCDD2),
    accentDark: Color(0xFFB71C1C),
    icon: Icons.undo,
    arrow: '←',
    gradientColors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
  );

  final redoCard = _valueCard(
    name: 'redo',
    index: UndoDirection.redo.index,
    title: 'Step forward in history',
    description:
        'Move the cursor to the next state, replaying an action the user '
        'previously undid. The redo half is invalidated as soon as a fresh '
        'edit is committed past the cursor.',
    semantics: const [
      'Pre: cursor < history.length - 1',
      'Post: cursor := cursor + 1',
      'Effect: editor re-applies stashed snapshot',
      'No-op when no future entries exist',
    ],
    shortcuts: const [
      ['iOS', '3-finger swipe right · ⇧⌘Z'],
      ['macOS', 'Edit menu · ⇧⌘Z'],
      ['Android', 'Ctrl+Y / Ctrl+Shift+Z'],
      ['Web', 'Browser-controlled (UA)'],
      ['Linux', 'Ctrl+Shift+Z / Ctrl+Y'],
      ['Windows', 'Ctrl+Y'],
    ],
    accent: Color(0xFF388E3C),
    accentSoft: Color(0xFFC8E6C9),
    accentDark: Color(0xFF1B5E20),
    icon: Icons.redo,
    arrow: '→',
    gradientColors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
  );

  // ============================================================
  // SECTION 4: Visual history stack mockup (8 chips + cursor)
  // ============================================================
  print('=== Section 4: Visual history stack ===');

  final mockOps = <Map<String, dynamic>>[
    {'op': 'insert "H"', 'color': Color(0xFFEF5350), 'icon': Icons.text_fields},
    {'op': 'insert "e"', 'color': Color(0xFFAB47BC), 'icon': Icons.text_fields},
    {'op': 'insert "l"', 'color': Color(0xFF5C6BC0), 'icon': Icons.text_fields},
    {'op': 'insert "l"', 'color': Color(0xFF42A5F5), 'icon': Icons.text_fields},
    {'op': 'insert "o"', 'color': Color(0xFF26A69A), 'icon': Icons.text_fields},
    {'op': 'space', 'color': Color(0xFF66BB6A), 'icon': Icons.space_bar},
    {'op': 'paste "world"', 'color': Color(0xFFFFA726), 'icon': Icons.paste},
    {'op': 'bold range', 'color': Color(0xFFEC407A), 'icon': Icons.format_bold},
  ];
  // cursor is currently at index 5 in this mock — undo took us back twice
  const cursorAt = 5;
  print('Mock history has ${mockOps.length} entries; cursor at $cursorAt');

  final mockChips = <Widget>[];
  for (var i = 0; i < mockOps.length; i++) {
    final op = mockOps[i];
    final isCursor = i == cursorAt;
    final isFuture = i > cursorAt;
    mockChips.add(_historyChip(
      label: '${i + 1}. ${op['op']}',
      color: op['color'] as Color,
      icon: op['icon'] as IconData,
      isCursor: isCursor,
      isFuture: isFuture,
    ));
  }

  final historyStackVisual = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
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
            Icon(Icons.layers, color: Colors.cyanAccent),
            SizedBox(width: 8.0),
            Text(
              'Mock history stack (cursor at #${cursorAt + 1})',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '${mockOps.length} ops',
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: mockChips,
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _legendDot(Colors.cyanAccent, 'past — replayed'),
            SizedBox(width: 14.0),
            _legendDot(Colors.amberAccent, 'cursor'),
            SizedBox(width: 14.0),
            _legendDot(Colors.white24, 'future — re-doable'),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          '// UndoDirection.undo  → cursor--   (greys out the rightmost active)\n'
          '// UndoDirection.redo  → cursor++   (lights up the next greyed one)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Worked example flow — type "Hello", undo x3, redo x2
  // ============================================================
  print('=== Section 5: Worked example flow ===');

  // A frame is one snapshot of the editor at a point in time.
  // We hand-roll the snapshots so the demo is fully deterministic.
  final flowFrames = <Map<String, dynamic>>[
    {
      'label': 'Type "H"',
      'text': 'H',
      'cursor': 0,
      'action': 'edit',
      'note': 'history grows: ["", "H"], cursor=1',
    },
    {
      'label': 'Type "He"',
      'text': 'He',
      'cursor': 1,
      'action': 'edit',
      'note': 'history grows: [..., "He"], cursor=2',
    },
    {
      'label': 'Type "Hel"',
      'text': 'Hel',
      'cursor': 2,
      'action': 'edit',
      'note': 'history grows: [..., "Hel"], cursor=3',
    },
    {
      'label': 'Type "Hell"',
      'text': 'Hell',
      'cursor': 3,
      'action': 'edit',
      'note': 'history grows: [..., "Hell"], cursor=4',
    },
    {
      'label': 'Type "Hello"',
      'text': 'Hello',
      'cursor': 4,
      'action': 'edit',
      'note': 'history grows: [..., "Hello"], cursor=5',
    },
    {
      'label': 'undo #1',
      'text': 'Hell',
      'cursor': 3,
      'action': 'undo',
      'note': 'UndoDirection.undo  cursor 5 → 4',
    },
    {
      'label': 'undo #2',
      'text': 'Hel',
      'cursor': 2,
      'action': 'undo',
      'note': 'UndoDirection.undo  cursor 4 → 3',
    },
    {
      'label': 'undo #3',
      'text': 'He',
      'cursor': 1,
      'action': 'undo',
      'note': 'UndoDirection.undo  cursor 3 → 2',
    },
    {
      'label': 'redo #1',
      'text': 'Hel',
      'cursor': 2,
      'action': 'redo',
      'note': 'UndoDirection.redo  cursor 2 → 3',
    },
    {
      'label': 'redo #2',
      'text': 'Hell',
      'cursor': 3,
      'action': 'redo',
      'note': 'UndoDirection.redo  cursor 3 → 4',
    },
  ];

  final flowFrameWidgets = <Widget>[];
  for (var i = 0; i < flowFrames.length; i++) {
    final f = flowFrames[i];
    flowFrameWidgets.add(_flowFrameCard(
      step: i + 1,
      label: f['label'] as String,
      text: f['text'] as String,
      cursor: f['cursor'] as int,
      action: f['action'] as String,
      note: f['note'] as String,
    ));
  }
  print('Flow has ${flowFrames.length} frames');

  final workedExample = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFFB300), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
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
            Icon(Icons.auto_stories, color: Color(0xFFE65100)),
            SizedBox(width: 8.0),
            Text(
              'Worked example: type "Hello", undo×3, redo×2',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Each card below is the editor snapshot at that step. The bar at '
          'the bottom shows the history stack and where the cursor sits. '
          'No real controllers run — the snapshots are precomputed.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: flowFrameWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: UndoHistory + UndoTextIntent integration sketch
  // ============================================================
  print('=== Section 6: UndoHistory + UndoTextIntent ===');

  final integrationSketch = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.integration_instructions, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              'Integration: UndoHistory<T> · UndoTextIntent · Actions',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'UndoHistory<T> wraps a ValueListenable<T> and tracks past/future '
          'snapshots. When the platform sends a UndoTextIntent containing an '
          'UndoDirection, an Action handler routes it to the right history.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13.0, height: 1.4),
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// pseudocode — DO NOT execute\n'
          'UndoHistory<TextEditingValue>(\n'
          '  controller: undoController,\n'
          '  value: textController,\n'
          '  onTriggered: (TextEditingValue v) {\n'
          '    textController.value = v;\n'
          '  },\n'
          '  child: TextField(controller: textController),\n'
          ');',
          Color(0xFF81D4FA),
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Action wiring (Flutter framework side)\n'
          'class _UndoTextAction extends Action<UndoTextIntent> {\n'
          '  @override\n'
          '  void invoke(UndoTextIntent intent) {\n'
          '    switch (intent.direction) {\n'
          '      case UndoDirection.undo: history.undo(); break;\n'
          '      case UndoDirection.redo: history.redo(); break;\n'
          '    }\n'
          '  }\n'
          '}',
          Color(0xFFA5D6A7),
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Embedder side (reference, not invoked here)\n'
          'class _MyClient implements TextInputClient {\n'
          '  @override\n'
          '  void handlePlatformUndo(UndoDirection direction) {\n'
          '    // Same dispatch — direction is the only payload.\n'
          '  }\n'
          '}',
          Color(0xFFFFAB91),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes — text editor / drawing / form rollback
  // ============================================================
  print('=== Section 7: Recipes ===');

  final recipeTextEditor = _recipeCard(
    title: 'Text editor',
    icon: Icons.edit_note,
    accent: Color(0xFF1565C0),
    accentSoft: Color(0xFFBBDEFB),
    body: 'Wrap the TextField in UndoHistory<TextEditingValue>. The platform '
        'will route ⌘Z / Ctrl+Z / shake-to-undo into UndoTextIntent with the '
        'right UndoDirection automatically.',
    mock: _mockTextEditor(),
    bullets: const [
      'undo: previous TextEditingValue',
      'redo: re-applies the rolled-back value',
      'history clears on focus loss in some platforms',
    ],
  );

  final recipeDrawingApp = _recipeCard(
    title: 'Drawing app',
    icon: Icons.brush,
    accent: Color(0xFF6A1B9A),
    accentSoft: Color(0xFFE1BEE7),
    body: 'Each stroke is a snapshot of List<Stroke>. UndoDirection.undo '
        'pops the last stroke, redo pushes it back. For huge canvases, store '
        'reverse-deltas instead of full snapshots.',
    mock: _mockDrawingCanvas(),
    bullets: const [
      'undo: pop last stroke',
      'redo: push popped stroke back',
      'clearing the canvas should snapshot too',
    ],
  );

  final recipeFormRollback = _recipeCard(
    title: 'Form rollback',
    icon: Icons.assignment_returned,
    accent: Color(0xFF2E7D32),
    accentSoft: Color(0xFFC8E6C9),
    body: 'Snapshot the whole form model on each meaningful change. Hooking '
        'into the platform undo channel lets users rewind a form across '
        'multiple fields with a single ⌘Z, not just per-field.',
    mock: _mockFormRollback(),
    bullets: const [
      'undo: previous form snapshot',
      'redo: forward snapshot if no edit happened',
      'snapshots can be coalesced by debounce window',
    ],
  );

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFB71C1C), Color(0xFF880E4F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.amberAccent),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls — read these before shipping',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          icon: Icons.cleaning_services,
          title: 'Clearing history',
          body: 'Calling UndoHistoryController.value = … or rebuilding the '
              'widget on a new key wipes the stack. Both undo and redo '
              'become no-ops until new edits arrive.',
        ),
        _pitfallRow(
          icon: Icons.delete_sweep,
          title: 'Redo invalidation after edit',
          body: 'A fresh edit while cursor < length-1 truncates the future. '
              'The user can no longer redo — make sure your UI greys out the '
              'redo affordance to match.',
        ),
        _pitfallRow(
          icon: Icons.layers_clear,
          title: 'Multi-controller scenarios',
          body: 'Each TextField has its own UndoHistory. The platform sends '
              'the intent to the focused client only. If you swap focus '
              'between fields, the user effectively jumps between separate '
              'undo timelines — communicate this clearly.',
        ),
        _pitfallRow(
          icon: Icons.devices_other,
          title: 'Platform inconsistency',
          body: 'iOS shake-to-undo confirms via dialog; macOS sends without '
              'prompt; Android relies on IME. Do not assume a uniform UX.',
        ),
        _pitfallRow(
          icon: Icons.bolt,
          title: 'Snapshot cost',
          body: 'Large editor states snapshotted on every keystroke can OOM. '
              'Coalesce edits into idle windows or store reverse-deltas.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer with file path + ASCII summary box
  // ============================================================
  print('=== Section 9: Footer ===');

  const filePath =
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
      'send_ast_via_http_scripts/services/undo_direction_test.dart';
  const asciiBox =
      '+----------------------------------------------------------+\n'
      '|  enum UndoDirection                                      |\n'
      '|    undo (idx=0)   <-- step backward through history      |\n'
      '|    redo (idx=1)   --> step forward  through history      |\n'
      '|                                                          |\n'
      '|  carried by UndoTextIntent · routed by UndoHistory       |\n'
      '|  emitted by UndoManager  ·  delivered via TextInput      |\n'
      '+----------------------------------------------------------+';

  final footer = Container(
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF212121), Color(0xFF424242)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent),
            SizedBox(width: 8.0),
            Text(
              'Reference card',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.greenAccent.shade700, width: 1.0),
          ),
          child: Text(
            asciiBox,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            filePath,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent,
            ),
          ),
        ),
      ],
    ),
  );

  print('UndoDirection deep demo finished assembling layout');

  // ============================================================
  // Final composition
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 24.0),
        _sectionHeader('1. Conceptual model', Icons.account_tree,
            Color(0xFF3F51B5)),
        conceptDiagram,
        SizedBox(height: 20.0),
        _sectionHeader('2. Per-value cards', Icons.swap_horiz,
            Color(0xFF6A1B9A)),
        SizedBox(height: 8.0),
        undoCard,
        SizedBox(height: 12.0),
        redoCard,
        SizedBox(height: 20.0),
        _sectionHeader('3. Mock history stack', Icons.layers,
            Color(0xFF00838F)),
        historyStackVisual,
        SizedBox(height: 20.0),
        _sectionHeader('4. Worked example', Icons.auto_stories,
            Color(0xFFE65100)),
        workedExample,
        SizedBox(height: 20.0),
        _sectionHeader('5. UndoHistory + UndoTextIntent',
            Icons.integration_instructions, Color(0xFF1565C0)),
        integrationSketch,
        SizedBox(height: 20.0),
        _sectionHeader('6. Recipe — Text editor', Icons.edit_note,
            Color(0xFF1565C0)),
        recipeTextEditor,
        SizedBox(height: 16.0),
        _sectionHeader('7. Recipe — Drawing app', Icons.brush,
            Color(0xFF6A1B9A)),
        recipeDrawingApp,
        SizedBox(height: 16.0),
        _sectionHeader('8. Recipe — Form rollback',
            Icons.assignment_returned, Color(0xFF2E7D32)),
        recipeFormRollback,
        SizedBox(height: 20.0),
        _sectionHeader('9. Pitfalls', Icons.warning_amber,
            Color(0xFFB71C1C)),
        pitfalls,
        footer,
      ],
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Container(
          height: 2.0,
          width: 40.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.0)],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _platformPill(String name, String shortcut, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          shortcut,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontFamily: 'monospace',
            fontSize: 10.0,
          ),
        ),
      ],
    ),
  );
}

Widget _conceptTile(String label, Color color, bool isCursor) {
  return Container(
    width: 56.0,
    height: 56.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      border: isCursor
          ? Border.all(color: Color(0xFFFFC107), width: 3.0)
          : Border.all(color: Colors.transparent, width: 0.0),
      boxShadow: isCursor
          ? [
              BoxShadow(
                color: Color(0xFFFFC107).withValues(alpha: 0.6),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ]
          : null,
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
  );
}

Widget _conceptDash() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Container(
      width: 16.0,
      height: 2.0,
      color: Color(0xFF7E57C2),
    ),
  );
}

Widget _valueCard({
  required String name,
  required int index,
  required String title,
  required String description,
  required List<String> semantics,
  required List<List<String>> shortcuts,
  required Color accent,
  required Color accentSoft,
  required Color accentDark,
  required IconData icon,
  required String arrow,
  required List<Color> gradientColors,
}) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
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
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, accentDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.5),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 30.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UndoDirection.$name',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: accentDark,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: accentDark.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'idx $index   $arrow',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          description,
          style: TextStyle(fontSize: 13.0, height: 1.45),
        ),
        SizedBox(height: 14.0),
        // Semantics block
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.functions, color: accent, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Semantics',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: accentDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              for (final s in semantics)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(color: accentDark)),
                      Expanded(
                        child: Text(
                          s,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: accentDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Shortcuts block
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: accentSoft.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, color: accent, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Platform shortcuts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: accentDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              for (final row in shortcuts)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70.0,
                        child: Text(
                          row[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5,
                            color: accentDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row[1],
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: Colors.black87,
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

Widget _historyChip({
  required String label,
  required Color color,
  required IconData icon,
  required bool isCursor,
  required bool isFuture,
}) {
  final effectiveColor = isFuture ? Colors.white24 : color;
  final textColor = isFuture ? Colors.white54 : Colors.white;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isFuture
            ? [Colors.white10, Colors.white12]
            : [effectiveColor, effectiveColor.withValues(alpha: 0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: isCursor
          ? Border.all(color: Colors.amberAccent, width: 2.5)
          : Border.all(color: Colors.transparent, width: 0.0),
      boxShadow: isCursor
          ? [
              BoxShadow(
                color: Colors.amberAccent.withValues(alpha: 0.6),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ]
          : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: textColor, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: isCursor ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isCursor) ...[
          SizedBox(width: 6.0),
          Icon(Icons.place, color: Colors.amberAccent, size: 14.0),
        ],
      ],
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 11.0,
        ),
      ),
    ],
  );
}

Widget _flowFrameCard({
  required int step,
  required String label,
  required String text,
  required int cursor,
  required String action,
  required String note,
}) {
  final isUndo = action == 'undo';
  final isRedo = action == 'redo';
  final actionColor = isUndo
      ? Color(0xFFD32F2F)
      : isRedo
          ? Color(0xFF388E3C)
          : Color(0xFF1976D2);
  final actionIcon = isUndo
      ? Icons.undo
      : isRedo
          ? Icons.redo
          : Icons.keyboard;

  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: actionColor.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: actionColor.withValues(alpha: 0.2),
          blurRadius: 6.0,
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
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: actionColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(actionIcon, size: 14.0, color: actionColor),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: actionColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        // Mock editor field
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Row(
            children: [
              Text(
                text.isEmpty ? '∅' : text,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
              Container(
                width: 2.0,
                height: 14.0,
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                color: actionColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'cursor at history index $cursor',
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: actionColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            note,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: actionColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF0A1929),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _recipeCard({
  required String title,
  required IconData icon,
  required Color accent,
  required Color accentSoft,
  required String body,
  required Widget mock,
  required List<String> bullets,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, accentSoft.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
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
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: accent, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: accent,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(body, style: TextStyle(fontSize: 12.5, height: 1.4)),
        SizedBox(height: 12.0),
        mock,
        SizedBox(height: 12.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, size: 14.0, color: accent),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(fontSize: 11.5, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// Mock UI: text editor
Widget _mockTextEditor() {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, size: 14.0, color: Color(0xFF1565C0)),
            SizedBox(width: 6.0),
            Text(
              'TextField (focus)',
              style: TextStyle(
                  fontSize: 10.0, color: Color(0xFF1565C0)),
            ),
            Spacer(),
            _mockChip('⌘Z', Color(0xFFD32F2F)),
            SizedBox(width: 4.0),
            _mockChip('⇧⌘Z', Color(0xFF388E3C)),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'The quick brown fox|',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
        ),
      ],
    ),
  );
}

// Mock UI: drawing canvas
Widget _mockDrawingCanvas() {
  return Container(
    height: 80.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 12.0, top: 14.0,
          child: Container(
            width: 50.0, height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFF6A1B9A),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        Positioned(
          left: 30.0, top: 32.0,
          child: Container(
            width: 80.0, height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFEC407A),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        Positioned(
          left: 60.0, top: 50.0,
          child: Container(
            width: 30.0, height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFEF5350).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        Positioned(
          right: 8.0, top: 6.0,
          child: _mockChip('undoable: 3', Color(0xFF6A1B9A)),
        ),
      ],
    ),
  );
}

// Mock UI: form rollback
Widget _mockFormRollback() {
  return Column(
    children: [
      _mockFormRow('Name', 'Ada Lovelace', Color(0xFF2E7D32)),
      SizedBox(height: 4.0),
      _mockFormRow('Email', 'ada@analyt.engine', Color(0xFF2E7D32)),
      SizedBox(height: 4.0),
      _mockFormRow('Notes', 'pioneered programming', Color(0xFF2E7D32)),
    ],
  );
}

Widget _mockFormRow(String label, String value, Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 60.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
          ),
        ),
      ],
    ),
  );
}

Widget _mockChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9.5,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _pitfallRow({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.amberAccent, size: 18.0),
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
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.white.withValues(alpha: 0.85),
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
