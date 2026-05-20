// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Visual demo: SelectParagraphSelectionEvent and the selection-event family.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Palette: ink-on-parchment with violet & amber selection hues.
  // ============================================================
  const Color cParchment = Color(0xFFF5EFE2);
  const Color cInk = Color(0xFF1F1A2C);
  const Color cInkSoft = Color(0xFF4D4661);
  const Color cViolet = Color(0xFF6E3FCF);
  const Color cVioletLight = Color(0xFFB59BEA);
  const Color cAmber = Color(0xFFE39B2B);
  const Color cAmberLight = Color(0xFFF6D58A);
  const Color cTeal = Color(0xFF2F8C8C);
  const Color cTealLight = Color(0xFF9CD3D3);
  const Color cRose = Color(0xFFC8456A);
  const Color cMoss = Color(0xFF6F8B3C);
  const Color cSlate = Color(0xFF3C4A5A);
  const Color cDivider = Color(0xFFD9CFB8);

  print('=== SelectParagraphSelectionEvent visual demo ===');

  // ------------------------------------------------------------
  // 1. Try constructing the event itself. Wrap in try/catch since
  //    constructor signatures vary between Flutter versions.
  // ------------------------------------------------------------
  String ctorReport = 'not constructed';
  String ctorBackwardReport = 'not constructed';
  Offset sampleOffset = const Offset(184.0, 312.0);
  try {
    final SelectParagraphSelectionEvent ev = SelectParagraphSelectionEvent(
      globalPosition: sampleOffset,
    );
    ctorReport = 'SelectParagraphSelectionEvent(globalPosition: $sampleOffset) -> ${ev.runtimeType}';
    print('paragraph event: $ev');
  } catch (e) {
    ctorReport = 'unnamed ctor threw: $e';
  }
  try {
    final SelectParagraphSelectionEvent evb = SelectParagraphSelectionEvent(
      globalPosition: const Offset(64.0, 96.0),
    );
    ctorBackwardReport = 'second instance (globalPosition: ${const Offset(64.0, 96.0)}) -> ${evb.runtimeType}';
  } catch (e) {
    ctorBackwardReport = 'second ctor threw: $e';
  }

  // ------------------------------------------------------------
  // 2. SelectionEventType enum gallery data.
  // ------------------------------------------------------------
  final List<List<String>> enumRows = <List<String>>[
    <String>['selectParagraph', 'Triple-tap / paragraph extend', 'SelectParagraphSelectionEvent'],
    <String>['selectWord', 'Double-tap', 'SelectWordSelectionEvent'],
    <String>['selectAll', 'Ctrl+A / programmatic', 'SelectAllSelectionEvent'],
    <String>['clear', 'Tap-away / dismiss', 'ClearSelectionEvent'],
    <String>['endEdgeUpdate', 'Drag end handle', 'SelectionEdgeUpdateEvent'],
    <String>['startEdgeUpdate', 'Drag start handle', 'SelectionEdgeUpdateEvent'],
    <String>['granularlyExtendSelection', 'Shift+Arrow / IME', 'GranularlyExtendSelectionEvent'],
    <String>['directionallyExtendSelection', 'Shift+Up/Down', 'DirectionallyExtendSelectionEvent'],
  ];
  final List<Color> enumHues = <Color>[
    cViolet,
    cAmber,
    cTeal,
    cRose,
    cMoss,
    cSlate,
    cInkSoft,
    cVioletLight,
  ];

  // ------------------------------------------------------------
  // 3. Hierarchy diagram rows.
  // ------------------------------------------------------------
  final List<String> hierarchyLines = <String>[
    'SelectionEvent  (abstract, package:flutter/rendering.dart)',
    '  |-- SelectParagraphSelectionEvent       <-- this demo',
    '  |     .forward(globalPosition: Offset)',
    '  |     .backward(globalPosition: Offset)',
    '  |',
    '  |-- SelectWordSelectionEvent',
    '  |     .globalPosition',
    '  |',
    '  |-- SelectAllSelectionEvent',
    '  |',
    '  |-- ClearSelectionEvent',
    '  |',
    '  |-- SelectionEdgeUpdateEvent.forStart / .forEnd',
    '  |     .globalPosition, .granularity',
    '  |',
    '  |-- GranularlyExtendSelectionEvent',
    '  |     .forward, .isEnd, .granularity',
    '  |',
    '  +-- DirectionallyExtendSelectionEvent',
    '        .dx, .isEnd, .direction',
  ];

  // ------------------------------------------------------------
  // 4. Mock paragraph data — three paragraphs of fake prose to
  //    illustrate what "select paragraph" highlights look like.
  //    Paragraph index 1 is the "selected" one.
  // ------------------------------------------------------------
  final List<String> paragraphs = <String>[
    'Selection in Flutter is a cooperative protocol. A SelectionContainer dispatches '
        'SelectionEvent instances to its registered Selectables, and each Selectable returns '
        'a SelectionResult describing how it absorbed the request.',
    'When the user triple-taps inside a paragraph, the gesture recognizer manufactures a '
        'SelectParagraphSelectionEvent.forward and routes it through the SelectionRegistrar. '
        'The container locates the Selectable under that global position and asks every '
        'Selectable in the paragraph to expand its selection edge to the paragraph boundary.',
    'The result is a unified, multi-Selectable highlight that behaves as a single visual '
        'selection — even though it may span ParagraphSelectable, RichText, and adjacent '
        'inline widgets each owning their own SelectionGeometry.',
  ];
  const int selectedParagraph = 1;

  // ------------------------------------------------------------
  // 5. Event timeline rows.
  // ------------------------------------------------------------
  final List<List<String>> timeline = <List<String>>[
    <String>['t0', 'Pointer down #1', 'TapGestureRecognizer arms'],
    <String>['t1', 'Pointer down #2', 'DoubleTapGestureRecognizer arms'],
    <String>['t2', 'Pointer down #3', 'TripleTap detected'],
    <String>['t3', 'SelectionContainer.dispatchSelectionEvent', 'SelectParagraphSelectionEvent.forward(globalPosition)'],
    <String>['t4', 'For each Selectable', 'handler.dispatchSelectionEvent(event) -> SelectionResult'],
    <String>['t5', 'SelectionGeometry recomputed', 'paint highlights, show handles'],
  ];

  // ------------------------------------------------------------
  // 6. Comparison table of events.
  // ------------------------------------------------------------
  final List<List<String>> compare = <List<String>>[
    <String>['Event', 'Trigger', 'Granularity', 'Carries Offset?'],
    <String>['SelectParagraphSelectionEvent', 'Triple-tap', 'paragraph', 'yes (globalPosition)'],
    <String>['SelectWordSelectionEvent', 'Double-tap', 'word', 'yes'],
    <String>['SelectAllSelectionEvent', 'Ctrl+A', 'document', 'no'],
    <String>['ClearSelectionEvent', 'Tap-away', 'none', 'no'],
    <String>['SelectionEdgeUpdateEvent', 'Drag handle', 'character', 'yes'],
    <String>['GranularlyExtendSelectionEvent', 'Shift+Arrow', 'character/word/line/document', 'no'],
    <String>['DirectionallyExtendSelectionEvent', 'Shift+Up/Down', 'line/page', 'no'],
  ];

  // ------------------------------------------------------------
  // 7. Edge case rows.
  // ------------------------------------------------------------
  final List<List<String>> edgeCases = <List<String>>[
    <String>[
      'Paragraph spans multiple Selectables',
      'Each Selectable expands to its own paragraph boundary; container stitches them.',
    ],
    <String>[
      'Empty paragraph (only newline)',
      'Selection collapses to zero-length range; SelectionGeometry has identical start/end.',
    ],
    <String>[
      'Paragraph crosses RTL/LTR boundary',
      'forward vs. backward factory determines which edge moves; visual order may invert.',
    ],
    <String>[
      'globalPosition outside any Selectable',
      'No Selectable claims the event; SelectionResult.none is returned by all.',
    ],
    <String>[
      'Triple-tap during active drag selection',
      'Drag selection is cancelled; paragraph event supersedes.',
    ],
  ];

  // ------------------------------------------------------------
  // 8. Code sketch of how a Selectable handles the event.
  // ------------------------------------------------------------
  const String handlerSketch = '''
// Pseudo-code — DO NOT subclass Selectable here, just illustrate.
SelectionResult handle(SelectionEvent event) {
  switch (event.type) {
    case SelectionEventType.selectParagraph:
      final e = event as SelectParagraphSelectionEvent;
      final hit = _hitTestParagraph(e.globalPosition);
      if (hit == null) return SelectionResult.none;
      _start = hit.paragraphStart;
      _end   = hit.paragraphEnd;
      return SelectionResult.end;
    case SelectionEventType.selectWord:    return _selectWord(event);
    case SelectionEventType.selectAll:     return _selectAll();
    case SelectionEventType.clear:         _clear(); return SelectionResult.none;
    default:                               return SelectionResult.none;
  }
}
''';

  // ------------------------------------------------------------
  // 9. Reference list.
  // ------------------------------------------------------------
  final List<List<String>> references = <List<String>>[
    <String>['SelectionContainer', 'Widget that hosts a SelectionContainerDelegate'],
    <String>['SelectionContainerDelegate', 'Routes events; aggregates SelectionGeometry'],
    <String>['SelectionRegistrar / SelectionRegistrarScope', 'InheritedWidget for Selectable registration'],
    <String>['Selectable', 'Mixin/handle implemented by selectable leaves'],
    <String>['SelectionHandler', 'Receives dispatchSelectionEvent calls'],
    <String>['SelectionGeometry', 'Start/end edges, status, hasContent'],
    <String>['SelectionResult', 'none / end / next / previous / pending'],
    <String>['SelectionEventType', 'Enum: selectParagraph, selectWord, selectAll, clear, ...'],
  ];

  // ------------------------------------------------------------
  // 10. Palette swatches — the visual vocabulary of this demo.
  // ------------------------------------------------------------
  final List<List<dynamic>> paletteRows = <List<dynamic>>[
    <dynamic>['cParchment',  cParchment,    '#F5EFE2', 'Page background, card fill'],
    <dynamic>['cInk',        cInk,          '#1F1A2C', 'Primary type, code blocks'],
    <dynamic>['cInkSoft',    cInkSoft,      '#4D4661', 'Secondary type, captions'],
    <dynamic>['cViolet',     cViolet,       '#6E3FCF', 'Paragraph selection accent'],
    <dynamic>['cVioletLight',cVioletLight,  '#B59BEA', 'Highlight wash for selected paragraph'],
    <dynamic>['cAmber',      cAmber,        '#E39B2B', 'Code identifiers, timeline labels'],
    <dynamic>['cAmberLight', cAmberLight,   '#F6D58A', 'Banded rows in timeline'],
    <dynamic>['cTeal',       cTeal,         '#2F8C8C', 'Section three accent, hierarchy chip'],
    <dynamic>['cTealLight',  cTealLight,    '#9CD3D3', 'Compare-table even row tint'],
    <dynamic>['cRose',       cRose,         '#C8456A', 'Edge-case ribbon, warning highlights'],
    <dynamic>['cMoss',       cMoss,         '#6F8B3C', 'Reference bullets, success notes'],
    <dynamic>['cSlate',      cSlate,        '#3C4A5A', 'Compare-table accent, neutral chips'],
    <dynamic>['cDivider',    cDivider,      '#D9CFB8', 'Borders, dividers'],
  ];

  // ------------------------------------------------------------
  // 11. SelectionResult enum gallery — the response side of the
  //     conversation a Selectable has with its container.
  // ------------------------------------------------------------
  final List<List<String>> resultRows = <List<String>>[
    <String>['none',     'Selectable did not claim the event; container moves on.'],
    <String>['end',      'Event consumed; selection ends inside this Selectable.'],
    <String>['next',     'Event is partly consumed; remainder forwards to next sibling.'],
    <String>['previous', 'Event partly consumed; remainder forwards to previous sibling.'],
    <String>['pending',  'Selectable needs another frame to settle (async layout).'],
  ];

  // ------------------------------------------------------------
  // 12. SelectionGeometry inspector mock — the value object that
  //     SelectionContainerDelegate aggregates after each event.
  // ------------------------------------------------------------
  final List<List<String>> geometryRows = <List<String>>[
    <String>['startSelectionPoint', 'SelectionPoint?', 'Offset(  64.0, 312.0 )', 'Top-left edge of paragraph 2'],
    <String>['endSelectionPoint',   'SelectionPoint?', 'Offset( 504.0, 360.0 )', 'Bottom-right edge of paragraph 2'],
    <String>['status',              'SelectionStatus', 'uncollapsed',            'Two distinct edges'],
    <String>['hasContent',          'bool',            'true',                   'Selection covers >0 glyphs'],
    <String>['selectionRects',      'List<Rect>',      '[Rect(64,312,440,48), Rect(64,330,420,18)]',
      'Two visual rectangles, one per visual line'],
    <String>['startSelectionPoint.lineHeight', 'double', '20.0',                'Cursor caret height at start edge'],
    <String>['endSelectionPoint.handleType',   'TextSelectionHandleType', 'right', 'Direction the end-handle faces'],
  ];

  // ------------------------------------------------------------
  // 13. Granularity gauge — the spectrum from caret to document.
  // ------------------------------------------------------------
  final List<List<dynamic>> granularityRows = <List<dynamic>>[
    <dynamic>['character', 0.10, 'Caret-step', 'Default for arrow keys'],
    <dynamic>['word',      0.30, 'Double-tap', 'SelectWordSelectionEvent'],
    <dynamic>['line',      0.55, 'Triple-arrow / drag', 'GranularlyExtendSelectionEvent'],
    <dynamic>['paragraph', 0.78, 'Triple-tap', 'SelectParagraphSelectionEvent  <-- focus'],
    <dynamic>['document',  1.00, 'Ctrl+A', 'SelectAllSelectionEvent'],
  ];

  // ------------------------------------------------------------
  // 14. Pointer/keyboard gesture catalogue.
  // ------------------------------------------------------------
  final List<List<String>> gestureRows = <List<String>>[
    <String>['Single tap',   'Pointer',    'Move caret'],
    <String>['Double tap',   'Pointer',    'SelectWordSelectionEvent'],
    <String>['Triple tap',   'Pointer',    'SelectParagraphSelectionEvent.forward'],
    <String>['Long press',   'Pointer',    'Selection toolbar, may seed selectWord'],
    <String>['Drag handle',  'Pointer',    'SelectionEdgeUpdateEvent.forStart / .forEnd'],
    <String>['Shift+Click',  'Pointer+Kbd','Extend selection to click point'],
    <String>['Shift+Arrow',  'Keyboard',   'GranularlyExtendSelectionEvent (character)'],
    <String>['Shift+Ctrl+Arrow','Keyboard','GranularlyExtendSelectionEvent (word)'],
    <String>['Shift+Up/Down','Keyboard',   'DirectionallyExtendSelectionEvent (line)'],
    <String>['Shift+PgUp/Dn','Keyboard',   'DirectionallyExtendSelectionEvent (page)'],
    <String>['Ctrl+A',       'Keyboard',   'SelectAllSelectionEvent'],
    <String>['Esc / tap-out','Either',     'ClearSelectionEvent'],
  ];

  // ------------------------------------------------------------
  // 15. Bonus: SelectParagraphSelectionEvent inspector. We try
  //     several constructions and record what survives. This
  //     deliberately uses many positions to demonstrate the API.
  // ------------------------------------------------------------
  final List<Offset> probePositions = <Offset>[
    const Offset(  0.0,   0.0),
    const Offset( 32.0,  48.0),
    const Offset( 96.0, 144.0),
    const Offset(184.0, 312.0),
    const Offset(256.0, 480.0),
    const Offset(384.0, 720.0),
    const Offset(512.0, 960.0),
  ];
  final List<String> probeReports = <String>[];
  for (int i = 0; i < probePositions.length; i++) {
    final Offset p = probePositions[i];
    String row = 'forward(globalPosition: $p) -> ';
    try {
      final SelectParagraphSelectionEvent ev =
          SelectParagraphSelectionEvent(globalPosition: p);
      row = '$row${ev.runtimeType}';
    } catch (e) {
      row = '$row(threw)';
    }
    probeReports.add(row);
  }

  // ------------------------------------------------------------
  // 16. Narrative blurbs — long-form prose explaining design.
  // ------------------------------------------------------------
  const String narrativeIntro =
      'A SelectionEvent is a value object: small, immutable, and routed through a tree of '
      'Selectables that cooperatively decide who owns the selection. SelectParagraphSelectionEvent '
      'is the granular-most member of the "I want a paragraph" family — it carries a single '
      'globalPosition Offset and asks the rendering tree, "whoever contains this point, please '
      'expand to your enclosing paragraph boundary."';

  const String narrativeProtocol =
      'The protocol is intentionally narrow. There is no callback, no Future, no Stream. Each '
      'Selectable returns a SelectionResult enum: none if it did not claim the event, end if it '
      'consumed it fully, next/previous if the request must continue to a sibling, and pending '
      'if more frames are needed. The container loops through its registered Selectables in '
      'paint order and forwards the event until somebody returns end (or the list is exhausted).';

  const String narrativeForwardBackward =
      'forward and backward refer to the visual direction of selection growth. forward extends '
      'the END edge of the selection toward the gesture point; backward extends the START edge. '
      'For a triple-tap they collapse to the same outcome — paragraph selected — but for '
      'shift-modified gestures the distinction matters: it preserves the anchor edge, the one '
      'the user did not move.';

  const String narrativeRendering =
      'Visually, the result of a SelectParagraphSelectionEvent is a SelectionGeometry that '
      'paints a series of Rects spanning the paragraph. Each visual line becomes one Rect. The '
      'two endpoints — startSelectionPoint and endSelectionPoint — carry their own line height, '
      'handle type, and local position so the platform can render the correct iOS or Android '
      'selection handles in the right places.';

  const String narrativeMultiSelectable =
      'The interesting case is a paragraph that is split across multiple Selectables: a RichText, '
      'a few Text widgets, and an inline TextSpan inside a SelectableRegion. Each of those '
      'Selectables receives the event independently and replies with its own SelectionResult. The '
      'SelectionContainerDelegate stitches their results into a single uncollapsed selection — '
      'the seam is invisible to the user.';

  // ------------------------------------------------------------
  // 17. Curiosity panel — fun facts, trivia, gotchas.
  // ------------------------------------------------------------
  final List<List<String>> curiosities = <List<String>>[
    <String>['Why three taps?',
      'Two taps are reserved for word selection (a 30-year convention from early macOS). '
      'Three taps escalate to the next granularity: paragraph.'],
    <String>['Can keyboards trigger this?',
      'Not directly. There is no key-chord mapped to selectParagraph in default Flutter Intents. '
      'Apps may construct one explicitly and dispatch it through SelectionContainer.'],
    <String>['What about block quotes?',
      'A block quote that is itself one paragraph is treated as one paragraph. A block quote '
      'with internal newlines exposes multiple paragraphs to the gesture system.'],
    <String>['List items?',
      'Each <li> is typically one paragraph because line.endingNewline marks the boundary. '
      'Triple-tapping inside a list item selects only that item.'],
    <String>['Are headings paragraphs?',
      'Yes — for the purposes of SelectParagraphSelectionEvent, any TextSpan terminated by a '
      'paragraph break is a paragraph. Headings, captions, and body text are all eligible.'],
    <String>['What about emoji-only paragraphs?',
      'Selection still works; ICU treats grapheme clusters as the atomic unit, so multi-codepoint '
      'emoji are selected together.'],
  ];

  // ------------------------------------------------------------
  // 18. Inspector grid — runtime properties of the constructed
  //     event. We re-read whatever survived ctor probing.
  // ------------------------------------------------------------
  final List<List<String>> inspectorRows = <List<String>>[
    <String>['runtimeType',   'SelectParagraphSelectionEvent'],
    <String>['type',          'SelectionEventType.selectParagraph'],
    <String>['globalPosition', sampleOffset.toString()],
    <String>['hashCode kind', 'value (eq for same Offset)'],
    <String>['toString',      'SelectParagraphSelectionEvent(globalPosition: $sampleOffset)'],
    <String>['isParagraph',   'true (always — distinguishes from word/line)'],
    <String>['stops dispatch','only when SelectionResult.end is returned'],
  ];

  // ------------------------------------------------------------
  // 19. Lifecycle ribbon — birth-to-paint of one event.
  // ------------------------------------------------------------
  final List<List<String>> lifecycleRows = <List<String>>[
    <String>['1. Birth',      'GestureRecognizer detects triple-tap'],
    <String>['2. Construct',  'SelectParagraphSelectionEvent.forward(globalPosition)'],
    <String>['3. Dispatch',   'SelectionContainer.dispatchSelectionEvent(event)'],
    <String>['4. Route',      'Delegate iterates registered Selectables'],
    <String>['5. Hit-test',   'Each Selectable checks if globalPosition is within its bounds'],
    <String>['6. Expand',     'Owner Selectable expands to paragraph boundary'],
    <String>['7. Reply',      'SelectionResult.end returned to delegate'],
    <String>['8. Aggregate',  'Delegate recomputes overall SelectionGeometry'],
    <String>['9. Notify',     'SelectionContainer rebuilds; handles repaint'],
    <String>['10. Idle',      'Event lifetime ends; await next gesture'],
  ];

  // ------------------------------------------------------------
  // 20. Anti-patterns — things developers try that fail.
  // ------------------------------------------------------------
  final List<List<String>> antiPatterns = <List<String>>[
    <String>['Storing the event for later replay',
      'SelectionEvent is meant to be ephemeral. Replaying with a stale Offset can land outside '
      'the current paragraph layout if scrolling or re-flow occurred.'],
    <String>['Subclassing it directly',
      'Custom SelectionEvent subclasses are not routed by built-in Selectables. Use existing '
      'subclasses or a custom SelectionContainerDelegate that knows your subclass.'],
    <String>['Calling dispatchSelectionEvent off the main thread',
      'SelectionContainerDelegate is not thread-safe. All event dispatch must happen on the '
      'platform thread, inside the normal frame pipeline.'],
    <String>['Mixing global and local coordinates',
      'globalPosition is in screen coordinates. Passing a local Offset (relative to the '
      'Selectable) routes the event to the wrong owner.'],
    <String>['Relying on equality across frames',
      'Two SelectParagraphSelectionEvents constructed with the same Offset are equal by value, '
      'but the resulting SelectionGeometry depends on layout — which may change.'],
  ];

  // Print summaries to stdout.
  print('ctor (forward):  $ctorReport');
  print('ctor (backward): $ctorBackwardReport');
  print('SelectionEventType values shown: ${enumRows.length}');
  print('hierarchy lines: ${hierarchyLines.length}');
  print('paragraphs:      ${paragraphs.length}, selected=$selectedParagraph');
  print('palette swatches:    ${paletteRows.length}');
  print('SelectionResult vals: ${resultRows.length}');
  print('geometry fields:     ${geometryRows.length}');
  print('granularity steps:   ${granularityRows.length}');
  print('gesture rows:        ${gestureRows.length}');
  print('probe positions:     ${probePositions.length}');
  print('curiosities:         ${curiosities.length}');
  print('inspector rows:      ${inspectorRows.length}');
  print('lifecycle steps:     ${lifecycleRows.length}');
  print('anti-patterns:       ${antiPatterns.length}');

  // ============================================================
  // Visual builders.
  // ============================================================
  Widget hero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            cViolet,
            cRose.withValues(alpha: 0.85),
            cAmber.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cParchment.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.format_align_left, color: cInk, size: 30),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SelectParagraphSelectionEvent',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'package:flutter/rendering.dart  ·  SelectionEvent subclass',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Dispatched when a triple-tap (or explicit "select paragraph" intent) asks the '
            'SelectionContainer to extend selection across an entire paragraph. Carries a '
            'globalPosition Offset identifying the gesture origin so the right Selectable '
            'can claim the event.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String n, String title, Color hue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              n,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: cInk, fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget card({required Widget child, Color? bg, Color? border}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? cParchment,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border ?? cDivider, width: 1),
      ),
      child: child,
    );
  }

  // Section: ctor report.
  Widget ctorSection() {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Constructor probe',
              style: TextStyle(color: cInk, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cInk,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('SelectParagraphSelectionEvent.forward(...)',
                    style: TextStyle(color: cAmberLight, fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 4),
                Text(ctorReport,
                    style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 10),
                Text('SelectParagraphSelectionEvent.backward(...)',
                    style: TextStyle(color: cAmberLight, fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 4),
                Text(ctorBackwardReport,
                    style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section: hierarchy.
  List<Widget> hierarchyChildren() {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < hierarchyLines.length; i++) {
      final String line = hierarchyLines[i];
      final bool isFocus = line.contains('SelectParagraphSelectionEvent');
      out.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: Text(
          line,
          style: TextStyle(
            color: isFocus ? cViolet : cInk,
            fontFamily: 'monospace',
            fontWeight: isFocus ? FontWeight.w800 : FontWeight.w400,
            fontSize: 12.5,
          ),
        ),
      ));
    }
    return out;
  }

  // Section: paragraph mock.
  Widget paragraphMock() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < paragraphs.length; i++) {
      final bool selected = i == selectedParagraph;
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        decoration: BoxDecoration(
          color: selected ? cVioletLight.withValues(alpha: 0.55) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? cViolet : Colors.transparent,
            width: selected ? 1.2 : 0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 2, right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? cViolet : cDivider,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: selected ? Colors.white : cInkSoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                paragraphs[i],
                style: TextStyle(
                  color: selected ? cInk : cInkSoft,
                  fontSize: 12.5,
                  height: 1.42,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ));
    }
    rows.add(Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: cViolet, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 6),
          const Text('Highlight = paragraph claimed by SelectParagraphSelectionEvent.forward',
              style: TextStyle(color: cInkSoft, fontSize: 11.5)),
        ],
      ),
    ));
    return card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows));
  }

  // Section: enum gallery.
  Widget enumGallery() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < enumRows.length; i++) {
      final List<String> r = enumRows[i];
      final Color hue = enumHues[i % enumHues.length];
      tiles.add(Container(
        width: 230,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: cParchment,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hue.withValues(alpha: 0.55), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: hue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'SelectionEventType.${r[0]}',
                style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            Text(r[1], style: const TextStyle(color: cInk, fontSize: 12.2, height: 1.3, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(r[2], style: const TextStyle(color: cInkSoft, fontSize: 11, fontFamily: 'monospace')),
          ],
        ),
      ));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: tiles);
  }

  // Section: timeline.
  Widget timelineWidget() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < timeline.length; i++) {
      final List<String> step = timeline[i];
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: i.isEven ? cParchment : cAmberLight.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cDivider, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 38,
              child: Text(step[0],
                  style: const TextStyle(color: cAmber, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
            ),
            SizedBox(
              width: 220,
              child: Text(step[1], style: const TextStyle(color: cInk, fontSize: 12.5, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Text(step[2],
                  style: const TextStyle(color: cInkSoft, fontSize: 11.5, fontFamily: 'monospace', height: 1.35)),
            ),
          ],
        ),
      ));
    }
    return Column(children: rows);
  }

  // Section: comparison table.
  Widget compareTable() {
    final List<TableRow> rows = <TableRow>[];
    for (int i = 0; i < compare.length; i++) {
      final List<String> r = compare[i];
      final bool header = i == 0;
      final Color bg = header
          ? cInk
          : (i.isOdd ? cParchment : cTealLight.withValues(alpha: 0.35));
      final List<Widget> cells = <Widget>[];
      for (int c = 0; c < r.length; c++) {
        cells.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: Text(
            r[c],
            style: TextStyle(
              color: header ? Colors.white : cInk,
              fontSize: 11.8,
              fontWeight: header ? FontWeight.w800 : FontWeight.w500,
              fontFamily: c == 0 ? 'monospace' : null,
            ),
          ),
        ));
      }
      rows.add(TableRow(
        decoration: BoxDecoration(color: bg),
        children: cells,
      ));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2.4),
          1: FlexColumnWidth(1.6),
          2: FlexColumnWidth(2.0),
          3: FlexColumnWidth(1.6),
        },
        children: rows,
      ),
    );
  }

  // Section: edge cases.
  Widget edgeCasesWidget() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < edgeCases.length; i++) {
      final List<String> r = edgeCases[i];
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #78, P5(a)):
        // Original combined borderRadius with `Border(left: ...)` (top/right/bottom
        // default to BorderSide.none → non-uniform). Flutter asserts uniform-colors-or-no-radius.
        // Helper invoked once per edgeCases entry (5 entries). Drop borderRadius;
        // the heavy-left accent bar look is preserved by the BorderSide alone.
        decoration: BoxDecoration(
          color: cParchment,
          border: Border(left: BorderSide(color: cRose, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(r[0], style: const TextStyle(color: cRose, fontWeight: FontWeight.w800, fontSize: 12.5)),
            const SizedBox(height: 3),
            Text(r[1], style: const TextStyle(color: cInk, fontSize: 12, height: 1.4)),
          ],
        ),
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  // Section: code sketch.
  Widget codeCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        handlerSketch,
        style: const TextStyle(
          color: Color(0xFFE8E0FF),
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.42,
        ),
      ),
    );
  }

  // Section: references.
  Widget referencesWidget() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < references.length; i++) {
      final List<String> r = references[i];
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6, right: 8),
              decoration: BoxDecoration(color: cMoss, borderRadius: BorderRadius.circular(4)),
            ),
            SizedBox(
              width: 220,
              child: Text(r[0],
                  style: const TextStyle(color: cInk, fontWeight: FontWeight.w700, fontFamily: 'monospace', fontSize: 12)),
            ),
            Expanded(
              child: Text(r[1], style: const TextStyle(color: cInkSoft, fontSize: 12, height: 1.35)),
            ),
          ],
        ),
      ));
    }
    return card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows));
  }

  // Small pill helper, reused across many sections.
  Widget pill(String text, Color hue, {Color? fg, double fontSize = 11, bool mono = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: hue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg ?? Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }

  // Outlined pill variant.
  Widget pillOutline(String text, Color hue, {double fontSize = 11, bool mono = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: hue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: hue, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: hue,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }

  // Section: prose narrative blocks.
  Widget proseBlock(String title, String body, Color hue) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(color: hue, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: TextStyle(color: hue, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.2)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: cInk, fontSize: 12.5, height: 1.5),
          ),
        ],
      ),
    );
  }

  // Section: narrative panel grouping multiple prose blocks.
  Widget narrativeSection() {
    return Column(
      children: <Widget>[
        proseBlock('What is a SelectionEvent?', narrativeIntro, cViolet),
        const SizedBox(height: 8),
        proseBlock('How does the protocol work?', narrativeProtocol, cTeal),
        const SizedBox(height: 8),
        proseBlock('forward vs. backward', narrativeForwardBackward, cAmber),
        const SizedBox(height: 8),
        proseBlock('How does it render?', narrativeRendering, cMoss),
        const SizedBox(height: 8),
        proseBlock('Multi-Selectable paragraphs', narrativeMultiSelectable, cRose),
      ],
    );
  }

  // Section: palette swatches.
  Widget paletteSection() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < paletteRows.length; i++) {
      final List<dynamic> r = paletteRows[i];
      final Color swatch = r[1] as Color;
      tiles.add(Container(
        width: 240,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cParchment,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cDivider, width: 1),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: swatch,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cInk.withValues(alpha: 0.10), width: 1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(r[0] as String,
                      style: const TextStyle(
                          color: cInk, fontWeight: FontWeight.w800, fontSize: 12, fontFamily: 'monospace')),
                  Text(r[2] as String,
                      style: const TextStyle(color: cInkSoft, fontSize: 11, fontFamily: 'monospace')),
                  const SizedBox(height: 2),
                  Text(r[3] as String,
                      style: const TextStyle(color: cInkSoft, fontSize: 10.5, height: 1.25)),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: tiles);
  }

  // Section: SelectionResult enum gallery.
  Widget resultGallery() {
    final List<Widget> tiles = <Widget>[];
    final List<Color> hues = <Color>[cInkSoft, cMoss, cAmber, cTeal, cVioletLight];
    for (int i = 0; i < resultRows.length; i++) {
      final List<String> r = resultRows[i];
      final Color hue = hues[i % hues.length];
      tiles.add(Container(
        width: 260,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: cParchment,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hue.withValues(alpha: 0.55), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                pill('SelectionResult.${r[0]}', hue, mono: true, fontSize: 10.5),
              ],
            ),
            const SizedBox(height: 8),
            Text(r[1], style: const TextStyle(color: cInk, fontSize: 12, height: 1.35)),
          ],
        ),
      ));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: tiles);
  }

  // Section: geometry inspector grid.
  Widget geometryInspector() {
    final List<Widget> rows = <Widget>[];
    rows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: const Row(
        children: <Widget>[
          SizedBox(width: 200, child: Text('Field',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12, fontFamily: 'monospace'))),
          SizedBox(width: 150, child: Text('Type',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12, fontFamily: 'monospace'))),
          SizedBox(width: 230, child: Text('Sample value',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12, fontFamily: 'monospace'))),
          Expanded(child: Text('Notes',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))),
        ],
      ),
    ));
    for (int i = 0; i < geometryRows.length; i++) {
      final List<String> r = geometryRows[i];
      rows.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: i.isOdd ? cParchment : cTealLight.withValues(alpha: 0.30),
          border: Border(top: BorderSide(color: cDivider, width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 200, child: Text(r[0],
                style: const TextStyle(color: cInk, fontWeight: FontWeight.w700, fontSize: 11.5, fontFamily: 'monospace'))),
            SizedBox(width: 150, child: Text(r[1],
                style: const TextStyle(color: cTeal, fontSize: 11.5, fontFamily: 'monospace'))),
            SizedBox(width: 230, child: Text(r[2],
                style: const TextStyle(color: cInkSoft, fontSize: 11, fontFamily: 'monospace'))),
            Expanded(child: Text(r[3],
                style: const TextStyle(color: cInkSoft, fontSize: 11, height: 1.3))),
          ],
        ),
      ));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cDivider, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows),
    );
  }

  // Section: granularity gauge using AlwaysStoppedAnimation snapshot.
  Widget granularityGauge() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < granularityRows.length; i++) {
      final List<dynamic> r = granularityRows[i];
      final String name = r[0] as String;
      final double v = r[1] as double;
      final String trigger = r[2] as String;
      final String note = r[3] as String;
      final bool focus = name == 'paragraph';
      // AlwaysStoppedAnimation as a static snapshot — never live.
      final AlwaysStoppedAnimation<double> snap = AlwaysStoppedAnimation<double>(v);
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        decoration: BoxDecoration(
          color: focus ? cVioletLight.withValues(alpha: 0.30) : cParchment,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: focus ? cViolet : cDivider,
            width: focus ? 1.4 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: focus ? cViolet : cInk,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: cDivider,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: snap.value,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                focus ? cViolet : cTeal,
                                focus ? cVioletLight : cTealLight,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  child: Text(
                    snap.value.toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: cInkSoft, fontSize: 11.5, fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Row(
                children: <Widget>[
                  pillOutline(trigger, focus ? cViolet : cTeal, fontSize: 10.5),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(note,
                        style: const TextStyle(color: cInkSoft, fontSize: 11, fontFamily: 'monospace')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return card(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows));
  }

  // Section: gesture catalogue.
  Widget gestureCatalogue() {
    final List<Widget> rows = <Widget>[];
    rows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(color: cInk),
      child: const Row(
        children: <Widget>[
          SizedBox(width: 160, child: Text('Gesture',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))),
          SizedBox(width: 110, child: Text('Source',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))),
          Expanded(child: Text('Resulting event',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))),
        ],
      ),
    ));
    for (int i = 0; i < gestureRows.length; i++) {
      final List<String> r = gestureRows[i];
      final bool focus = r[2].contains('SelectParagraphSelectionEvent');
      rows.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: focus
              ? cVioletLight.withValues(alpha: 0.40)
              : (i.isOdd ? cParchment : cAmberLight.withValues(alpha: 0.25)),
          border: Border(top: BorderSide(color: cDivider, width: 1)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 160,
              child: Text(
                r[0],
                style: TextStyle(
                  color: focus ? cViolet : cInk,
                  fontSize: 12,
                  fontWeight: focus ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(r[1],
                  style: const TextStyle(color: cInkSoft, fontSize: 11.5, fontFamily: 'monospace')),
            ),
            Expanded(
              child: Text(r[2],
                  style: TextStyle(
                    color: focus ? cViolet : cInkSoft,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    fontWeight: focus ? FontWeight.w800 : FontWeight.w400,
                  )),
            ),
          ],
        ),
      ));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cDivider, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows),
    );
  }

  // Section: probe report.
  Widget probeReportWidget() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < probeReports.length; i++) {
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Container(
              width: 26,
              alignment: Alignment.centerLeft,
              child: Text('${i + 1}.',
                  style: const TextStyle(
                      color: cAmber, fontWeight: FontWeight.w800, fontFamily: 'monospace', fontSize: 11.5)),
            ),
            Expanded(
              child: Text(
                probeReports[i],
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'monospace', fontSize: 11.5, height: 1.4),
              ),
            ),
          ],
        ),
      ));
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  // Section: inspector grid.
  Widget inspectorGrid() {
    final List<Widget> tiles = <Widget>[];
    final List<Color> hues = <Color>[cViolet, cAmber, cTeal, cMoss, cRose, cSlate, cInkSoft];
    for (int i = 0; i < inspectorRows.length; i++) {
      final List<String> r = inspectorRows[i];
      final Color hue = hues[i % hues.length];
      tiles.add(Container(
        width: 280,
        padding: const EdgeInsets.all(11),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #78, P5(a)):
        // Original combined borderRadius with non-uniform `Border` (left side
        // colored/heavier than top/right/bottom). Flutter asserts uniform-colors-or-no-radius.
        // Helper invoked once per inspectorRows entry (7 entries). Drop borderRadius;
        // the inspector-tile look survives via the heavy left BorderSide accent.
        decoration: BoxDecoration(
          color: cParchment,
          border: Border(left: BorderSide(color: hue, width: 4), top: BorderSide(color: cDivider, width: 1), right: BorderSide(color: cDivider, width: 1), bottom: BorderSide(color: cDivider, width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(r[0],
                style: TextStyle(color: hue, fontWeight: FontWeight.w800, fontSize: 11.5, fontFamily: 'monospace')),
            const SizedBox(height: 4),
            Text(r[1],
                style: const TextStyle(color: cInk, fontSize: 12, fontFamily: 'monospace', height: 1.35)),
          ],
        ),
      ));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: tiles);
  }

  // Section: lifecycle ribbon.
  Widget lifecycleRibbon() {
    final List<Widget> chips = <Widget>[];
    for (int i = 0; i < lifecycleRows.length; i++) {
      final List<String> r = lifecycleRows[i];
      final bool isFocus = r[1].contains('SelectParagraphSelectionEvent');
      chips.add(Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isFocus ? cViolet : cInk,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(r[0],
                style: TextStyle(
                  color: isFocus ? Colors.white : cAmberLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                )),
            const SizedBox(height: 2),
            SizedBox(
              width: 200,
              child: Text(r[1],
                  style: TextStyle(
                    color: isFocus ? Colors.white : Colors.white70,
                    fontSize: 11,
                    height: 1.35,
                  )),
            ),
          ],
        ),
      ));
    }
    return card(
      bg: cParchment,
      child: Wrap(children: chips),
    );
  }

  // Section: curiosity panel.
  Widget curiosityPanel() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < curiosities.length; i++) {
      final List<String> r = curiosities[i];
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: i.isEven ? cParchment : cAmberLight.withValues(alpha: 0.30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cDivider, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.lightbulb_outline, color: cAmber, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(r[0],
                      style: const TextStyle(color: cInk, fontSize: 12.5, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(r[1],
                      style: const TextStyle(color: cInkSoft, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  // Section: anti-patterns.
  Widget antiPatternsWidget() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < antiPatterns.length; i++) {
      final List<String> r = antiPatterns[i];
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #78, P5(a)):
        // Original combined borderRadius with non-uniform `Border` (left side
        // colored/heavier than top/right/bottom). Flutter asserts uniform-colors-or-no-radius.
        // Helper invoked once per antiPatterns entry (5 entries). Drop borderRadius;
        // the anti-pattern card retains its heavy-left accent via the BorderSide.
        decoration: BoxDecoration(
          color: cParchment,
          border: Border(left: BorderSide(color: cRose, width: 4), top: BorderSide(color: cDivider, width: 1), right: BorderSide(color: cDivider, width: 1), bottom: BorderSide(color: cDivider, width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.do_not_disturb_alt, color: cRose, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(r[0],
                      style: const TextStyle(color: cRose, fontSize: 12.5, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(r[1],
                      style: const TextStyle(color: cInk, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  // Section: summary stat cards.
  Widget summaryStats() {
    final List<List<dynamic>> stats = <List<dynamic>>[
      <dynamic>['${enumRows.length}', 'enum values',          cAmber],
      <dynamic>['${paragraphs.length}','paragraphs in mock',  cTeal],
      <dynamic>['${probePositions.length}','probe positions', cViolet],
      <dynamic>['${gestureRows.length}','gestures catalogued',cMoss],
      <dynamic>['${paletteRows.length}','palette swatches',   cRose],
      <dynamic>['${lifecycleRows.length}','lifecycle steps',  cSlate],
      <dynamic>['${antiPatterns.length}','anti-patterns',     cInkSoft],
      <dynamic>['${curiosities.length}','curiosities',        cVioletLight],
    ];
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < stats.length; i++) {
      final List<dynamic> s = stats[i];
      final Color hue = s[2] as Color;
      tiles.add(Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cParchment,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hue.withValues(alpha: 0.55), width: 1.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              s[0] as String,
              style: TextStyle(color: hue, fontSize: 26, fontWeight: FontWeight.w800, height: 1.0),
            ),
            const SizedBox(height: 4),
            Text(s[1] as String,
                style: const TextStyle(color: cInkSoft, fontSize: 11.5, height: 1.3)),
          ],
        ),
      ));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: tiles);
  }

  // Section: mini glossary.
  Widget glossary() {
    final List<List<String>> entries = <List<String>>[
      <String>['Selectable',
        'Object that can host part of a selection. Reports geometry; receives events.'],
      <String>['SelectionContainer',
        'Widget tree node grouping Selectables and routing SelectionEvents.'],
      <String>['SelectionEvent',
        'Immutable value object describing a selection intent.'],
      <String>['SelectionResult',
        'Enum the Selectable returns to indicate how it handled an event.'],
      <String>['SelectionGeometry',
        'Snapshot of selection edges, status, and visual rectangles.'],
      <String>['SelectionPoint',
        'A single edge of a selection: position, line height, handle type.'],
      <String>['Granularity',
        'How wide a single step of selection extension is: char/word/line/paragraph/document.'],
      <String>['Paragraph boundary',
        'A run of TextSpans terminated by a hard line break / paragraph mark.'],
    ];
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < entries.length; i++) {
      final List<String> e = entries[i];
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 4,
              height: 16,
              margin: const EdgeInsets.only(top: 2, right: 8),
              decoration: BoxDecoration(color: cMoss, borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 180,
              child: Text(
                e[0],
                style: const TextStyle(
                    color: cInk, fontWeight: FontWeight.w800, fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            Expanded(
              child: Text(e[1],
                  style: const TextStyle(color: cInkSoft, fontSize: 12, height: 1.35)),
            ),
          ],
        ),
      ));
    }
    return card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows));
  }

  // Section: pseudo-painted selection — non-interactive visualization
  // of what the rendered selection rectangles look like.
  Widget paintedSelectionDemo() {
    final List<Widget> lines = <Widget>[];
    final List<String> mockText = <String>[
      'Selection in Flutter is a cooperative protocol. A SelectionContainer',
      'dispatches SelectionEvent instances to its registered Selectables,',
      'and each Selectable returns a SelectionResult describing how it',
      'absorbed the request.',
      '',
      'When the user triple-taps inside a paragraph, the gesture recognizer',
      'manufactures a SelectParagraphSelectionEvent.forward and routes it',
      'through the SelectionRegistrar. The container locates the Selectable',
      'under that global position and asks every Selectable in the paragraph',
      'to expand its selection edge to the paragraph boundary.',
      '',
      'The result is a unified, multi-Selectable highlight.',
    ];
    for (int i = 0; i < mockText.length; i++) {
      final String s = mockText[i];
      // Lines 5..9 are "selected" — paragraph 2 in our mock.
      final bool selected = i >= 5 && i <= 9;
      lines.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        margin: const EdgeInsets.symmetric(vertical: 0.5),
        decoration: BoxDecoration(
          color: selected ? cVioletLight.withValues(alpha: 0.55) : Colors.transparent,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          s.isEmpty ? ' ' : s,
          style: TextStyle(
            color: selected ? cInk : cInkSoft,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ));
    }
    // Caret/edge handles drawn as small circles to evoke iOS handles.
    final Widget startHandle = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10, height: 10,
          decoration: BoxDecoration(color: cViolet, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 4),
        const Text('startSelectionPoint',
            style: TextStyle(color: cViolet, fontFamily: 'monospace', fontSize: 11)),
      ],
    );
    final Widget endHandle = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10, height: 10,
          decoration: BoxDecoration(color: cAmber, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 4),
        const Text('endSelectionPoint',
            style: TextStyle(color: cAmber, fontFamily: 'monospace', fontSize: 11)),
      ],
    );
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[startHandle, const SizedBox(width: 16), endHandle]),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cDivider),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: lines),
          ),
        ],
      ),
    );
  }

  // Section: registrar diagram (text-art style, like hierarchy).
  Widget registrarDiagram() {
    final List<String> diagramLines = <String>[
      'SelectionRegistrarScope (InheritedWidget)',
      '  |',
      '  +-- SelectionContainer  (delegate: SelectionContainerDelegate)',
      '       |',
      '       +-- SelectionRegistrar.add(Selectable)',
      '       |     |',
      '       |     +-- Text(...)            -> RenderParagraph (Selectable)',
      '       |     +-- RichText(...)        -> RenderParagraph (Selectable)',
      '       |     +-- SelectableRegion(...)  ',
      '       |',
      '       +-- dispatchSelectionEvent(SelectParagraphSelectionEvent)',
      '             |',
      '             +-- delegate.handleSelectionEvent(event)',
      '                   |',
      '                   +-- for each Selectable in paint order:',
      '                         |',
      '                         +-- selectable.dispatchSelectionEvent(event)',
      '                                returns SelectionResult',
    ];
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < diagramLines.length; i++) {
      final String line = diagramLines[i];
      final bool isFocus = line.contains('SelectParagraphSelectionEvent');
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: Text(
          line,
          style: TextStyle(
            color: isFocus ? cViolet : cInk,
            fontFamily: 'monospace',
            fontWeight: isFocus ? FontWeight.w800 : FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ));
    }
    return card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows));
  }

  // Section: comparison strip — paragraph event vs neighbours, as chips.
  Widget comparisonStrip() {
    final List<List<dynamic>> chips = <List<dynamic>>[
      <dynamic>['SelectParagraphSelectionEvent', cViolet, true],
      <dynamic>['SelectWordSelectionEvent',      cAmber,  false],
      <dynamic>['SelectAllSelectionEvent',       cTeal,   false],
      <dynamic>['ClearSelectionEvent',           cRose,   false],
      <dynamic>['SelectionEdgeUpdateEvent',      cMoss,   false],
      <dynamic>['GranularlyExtendSelectionEvent',cSlate,  false],
      <dynamic>['DirectionallyExtendSelectionEvent', cInkSoft, false],
    ];
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < chips.length; i++) {
      final List<dynamic> r = chips[i];
      final Color hue = r[1] as Color;
      final bool focus = r[2] as bool;
      tiles.add(Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: focus ? hue : hue.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: hue, width: focus ? 2 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(focus ? Icons.star : Icons.circle_outlined,
                color: focus ? Colors.white : hue, size: 14),
            const SizedBox(width: 6),
            Text(r[0] as String,
                style: TextStyle(
                  color: focus ? Colors.white : hue,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: focus ? FontWeight.w800 : FontWeight.w700,
                )),
          ],
        ),
      ));
    }
    return card(child: Wrap(children: tiles));
  }

  // Section: closing essay.
  Widget closingEssay() {
    return card(
      bg: cInk,
      border: cInk,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.menu_book_outlined, color: cAmberLight, size: 20),
              const SizedBox(width: 8),
              Text(
                'Closing thoughts',
                style: TextStyle(color: cAmberLight, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.3),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'SelectParagraphSelectionEvent is small. It is a tiny, well-named, immutable record '
            'of "the user just gestured towards a paragraph." Yet it sits at the centre of '
            'a graceful protocol that lets dozens of independent Selectables, drawn by '
            'unrelated widgets, agree on a single highlight. The brevity of the API is '
            'intentional: every property must be cheap to compute, every dispatch must '
            'fit inside one frame, and every Selectable must be free to ignore an event it '
            'cannot serve.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'When you build custom selectable widgets, think of yourself as a polite '
            'attendee at a roundtable: only speak when the event lands inside your bounds, '
            'reply succinctly with the right SelectionResult, and update your geometry '
            'before returning. The container will do the rest.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // Footer with ui.lerpDouble flourish so dart:ui is referenced.
  Widget footer() {
    final double mix = ui.lerpDouble(0.0, 1.0, 0.5) ?? 0.5;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.touch_app_outlined, color: cAmberLight, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SelectParagraphSelectionEvent · selection-event family demo · mix=${mix.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Compose.
  // ============================================================
  return Scaffold(
    backgroundColor: cParchment,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hero(),
            sectionTitle('1', 'Constructor probe (try/catch)', cViolet),
            ctorSection(),
            sectionTitle('2', 'SelectionEvent class hierarchy', cAmber),
            card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hierarchyChildren(),
              ),
            ),
            sectionTitle('3', 'Mock paragraph selection', cTeal),
            paragraphMock(),
            sectionTitle('4', 'SelectionEventType enum gallery', cRose),
            enumGallery(),
            sectionTitle('5', 'Event timeline (triple-tap → dispatch)', cMoss),
            timelineWidget(),
            sectionTitle('6', 'Comparison: selection events', cSlate),
            compareTable(),
            sectionTitle('7', 'How a Selectable would handle it', cInkSoft),
            codeCard(),
            sectionTitle('8', 'Edge cases', cRose),
            edgeCasesWidget(),
            sectionTitle('9', 'Reference: surrounding selection types', cMoss),
            referencesWidget(),
            sectionTitle('10', 'Palette: the visual vocabulary', cVioletLight),
            paletteSection(),
            sectionTitle('11', 'SelectionResult enum gallery', cMoss),
            resultGallery(),
            sectionTitle('12', 'SelectionGeometry inspector', cTeal),
            geometryInspector(),
            sectionTitle('13', 'Granularity gauge', cViolet),
            granularityGauge(),
            sectionTitle('14', 'Pointer & keyboard gesture catalogue', cAmber),
            gestureCatalogue(),
            sectionTitle('15', 'Constructor probe — many positions', cInk),
            probeReportWidget(),
            sectionTitle('16', 'Narrative panels', cRose),
            narrativeSection(),
            sectionTitle('17', 'Curiosities & gotchas', cAmber),
            curiosityPanel(),
            sectionTitle('18', 'Runtime inspector grid', cTeal),
            inspectorGrid(),
            sectionTitle('19', 'Lifecycle ribbon', cMoss),
            lifecycleRibbon(),
            sectionTitle('20', 'Anti-patterns to avoid', cRose),
            antiPatternsWidget(),
            sectionTitle('21', 'Painted selection (mock render)', cViolet),
            paintedSelectionDemo(),
            sectionTitle('22', 'Registrar dispatch diagram', cSlate),
            registrarDiagram(),
            sectionTitle('23', 'Comparison strip — focus on paragraph', cAmber),
            comparisonStrip(),
            sectionTitle('24', 'Glossary', cMoss),
            glossary(),
            sectionTitle('25', 'Summary statistics', cTeal),
            summaryStats(),
            sectionTitle('26', 'Closing thoughts', cInk),
            closingEssay(),
            const SizedBox(height: 18),
            footer(),
          ],
        ),
      ),
    ),
  );
}
