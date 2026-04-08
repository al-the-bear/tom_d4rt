// ignore_for_file: avoid_print, unused_element
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION EDGE UPDATE EVENT — Deep Demo
// ============================================================================
//
// SelectionEdgeUpdateEvent is a concrete subclass of SelectionEvent
// that is dispatched when the user's gesture moves a selection edge
// (the start handle or the end handle) to a new position.
//
// It carries:
//   • globalPosition — the Offset in global coordinates where the
//     selection edge should be placed
//   • type           — SelectionEventType (.startEdgeUpdate or
//                      .endEdgeUpdate) indicating which edge moved
//   • granularity    — TextGranularity (.character, .word, .line,
//                      .document) determining the selection snap level
//
// This event is the PRIMARY mechanism through which user gestures
// (drag, double-tap-drag, triple-click-drag) are communicated to
// Selectable widgets.  Each Selectable receives this event and
// uses the globalPosition to compute the nearest character offset,
// then updates its internal selection state accordingly.
//
// Color theme : Amber (#FFA000) / Gold (#FFD54F)
// Helper prefix: _se
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _seAmber = Color(0xFFFFA000);
const Color _seGold = Color(0xFFFFD54F);
const Color _seDarkAmber = Color(0xFFE68900);
const Color _seLightGold = Color(0xFFFFF8E1);
const Color _seBrown = Color(0xFF795548);
const Color _seIvory = Color(0xFFFFFDF5);
const Color _seCharcoal = Color(0xFF37322D);
const Color _seTeal = Color(0xFF00897B);
const Color _seIndigo = Color(0xFF3949AB);
const Color _seRose = Color(0xFFE91E63);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _seSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_seAmber, _seDarkAmber],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _seInfoCard(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _seLightGold,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _seGold, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _seAmber, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _seCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _seCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _seCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _seGold,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _seDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _seGold.withValues(alpha: 0.4),
  );
}

Widget _seBadge(String label, Color bgColor, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _seSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _seAmber,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _seKeyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            key,
            style: const TextStyle(
              color: _seBrown,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _seCharcoal,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Overview
// ---------------------------------------------------------------------------
Widget _seBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '1. What Is SelectionEdgeUpdateEvent?',
        subtitle: 'The event dispatched when a selection edge moves',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'SelectionEdgeUpdateEvent is the most common selection event '
        'in Flutter\'s rendering-layer selection system.  It fires '
        'continuously as the user drags a selection handle or '
        'performs a drag-to-select gesture.',
      ),
      _seCodeBlock(
        'class SelectionEdgeUpdateEvent extends SelectionEvent {\n'
        '  const SelectionEdgeUpdateEvent.forStart({\n'
        '    required this.globalPosition,\n'
        '    this.granularity = TextGranularity.character,\n'
        '  }) : type = SelectionEventType.startEdgeUpdate;\n'
        '\n'
        '  const SelectionEdgeUpdateEvent.forEnd({\n'
        '    required this.globalPosition,\n'
        '    this.granularity = TextGranularity.character,\n'
        '  }) : type = SelectionEventType.endEdgeUpdate;\n'
        '\n'
        '  final Offset globalPosition;\n'
        '  final TextGranularity granularity;\n'
        '  final SelectionEventType type;\n'
        '}',
      ),
      _seInfoCard(
        'Think of it as the system telling each Selectable widget:\n\n'
        '"The user just moved the [start/end] selection edge to this '
        'position on screen.  Please figure out which character is '
        'closest and update your selection accordingly."',
        icon: Icons.touch_app,
      ),

      // Visual: User drag → event
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _seIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Gesture → Event Flow',
              style: TextStyle(
                color: _seDarkAmber,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            _seFlowStep(Icons.pan_tool, 'User drags finger on text', _seRose),
            _seFlowArrow(),
            _seFlowStep(Icons.location_on, 'GestureDetector reports global (x, y)', _seIndigo),
            _seFlowArrow(),
            _seFlowStep(Icons.send, 'SelectionEdgeUpdateEvent created', _seAmber),
            _seFlowArrow(),
            _seFlowStep(Icons.widgets, 'Dispatched to all Selectables', _seTeal),
            _seFlowArrow(),
            _seFlowStep(Icons.highlight, 'Each Selectable updates its selection', _seBrown),
          ],
        ),
      ),
    ],
  );
}

Widget _seFlowStep(IconData icon, String desc, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          desc,
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
    ],
  );
}

Widget _seFlowArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 10),
    child: Icon(Icons.arrow_downward, color: _seGold, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Fields Breakdown
// ---------------------------------------------------------------------------
Widget _seBuildFields() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '2. Fields Breakdown',
        subtitle: 'globalPosition, type, and granularity',
      ),
      const SizedBox(height: 12),

      // Field 1: globalPosition
      _seSubheading('Field 1: globalPosition (Offset)'),
      _seInfoCard(
        'The position of the selection edge in global (screen) coordinates.  '
        'Each Selectable converts this to local coordinates to determine '
        'which character is closest to this position.',
        icon: Icons.location_on,
      ),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _seIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber),
        ),
        child: Column(
          children: [
            const Text(
              'Global vs Local Coordinates',
              style: TextStyle(color: _seDarkAmber, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _seCoordBox(
                    'Global',
                    'Relative to screen top-left',
                    'Offset(242.5, 387.3)',
                    _seAmber,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: _seBrown),
                ),
                Expanded(
                  child: _seCoordBox(
                    'Local',
                    'Relative to widget top-left',
                    'Offset(126.5, 18.0)',
                    _seTeal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Field 2: type
      _seSubheading('Field 2: type (SelectionEventType)'),
      _seInfoCard(
        'Indicates which edge of the selection moved.  There are two '
        'relevant values for SelectionEdgeUpdateEvent:\n\n'
        '• startEdgeUpdate — the start handle was dragged\n'
        '• endEdgeUpdate — the end handle was dragged',
        icon: Icons.swap_horiz,
      ),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _seIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber),
        ),
        child: Row(
          children: [
            Expanded(
              child: _seEdgeTypeCard(
                'startEdgeUpdate',
                'Left handle or drag start',
                Icons.arrow_back,
                _seIndigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _seEdgeTypeCard(
                'endEdgeUpdate',
                'Right handle or drag end',
                Icons.arrow_forward,
                _seRose,
              ),
            ),
          ],
        ),
      ),

      // Field 3: granularity
      _seSubheading('Field 3: granularity (TextGranularity)'),
      _seInfoCard(
        'Determines the unit of selection snap.  Different gestures '
        'trigger different granularities:\n\n'
        '• character — normal drag (character-by-character)\n'
        '• word — double-tap then drag\n'
        '• line — triple-click on desktop\n'
        '• document — Ctrl+A / Cmd+A',
        icon: Icons.format_size,
      ),

      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _seAmber),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _seAmber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Granularity', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Gesture', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Behavior', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            _seGranularityRow('character', 'Single tap + drag', 'Selects one char at a time', false),
            _seGranularityRow('word', 'Double tap + drag', 'Snaps to whole words', true),
            _seGranularityRow('line', 'Triple click', 'Selects entire line', false),
            _seGranularityRow('document', 'Ctrl+A / Cmd+A', 'Selects everything', true),
          ],
        ),
      ),
    ],
  );
}

Widget _seCoordBox(String title, String desc, String example, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(color: _seCharcoal, fontSize: 10)),
        const SizedBox(height: 6),
        Text(example, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _seEdgeTypeCard(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 6),
        Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)),
        const SizedBox(height: 4),
        Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: _seCharcoal, fontSize: 10)),
      ],
    ),
  );
}

Widget _seGranularityRow(String granularity, String gesture, String behavior, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _seLightGold.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(granularity, style: const TextStyle(color: _seDarkAmber, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)),
        ),
        Expanded(
          flex: 2,
          child: Text(gesture, style: const TextStyle(color: _seCharcoal, fontSize: 11)),
        ),
        Expanded(
          flex: 3,
          child: Text(behavior, style: const TextStyle(color: _seCharcoal, fontSize: 11)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Named Constructors
// ---------------------------------------------------------------------------
Widget _seBuildConstructors() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '3. Named Constructors',
        subtitle: 'forStart() and forEnd() — the two ways to create this event',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'SelectionEdgeUpdateEvent provides two named constructors '
        'that set the type automatically, making intent crystal clear.',
      ),

      // Side-by-side
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _seIndigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _seIndigo, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_back, color: _seIndigo, size: 16),
                        const SizedBox(width: 6),
                        const Text(
                          '.forStart()',
                          style: TextStyle(color: _seIndigo, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Creates an event that moves the START edge of the selection.\n\n'
                      'Type is automatically set to SelectionEventType.startEdgeUpdate',
                      style: TextStyle(color: _seCharcoal, fontSize: 11, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    _seBadge('Start Edge', _seIndigo),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _seRose.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _seRose, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: _seRose, size: 16),
                        const SizedBox(width: 6),
                        const Text(
                          '.forEnd()',
                          style: TextStyle(color: _seRose, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Creates an event that moves the END edge of the selection.\n\n'
                      'Type is automatically set to SelectionEventType.endEdgeUpdate',
                      style: TextStyle(color: _seCharcoal, fontSize: 11, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    _seBadge('End Edge', _seRose),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      _seCodeBlock(
        '// Start edge moved to position (100, 200)\n'
        'final startEvent = SelectionEdgeUpdateEvent.forStart(\n'
        '  globalPosition: Offset(100, 200),\n'
        ');\n'
        '\n'
        '// End edge moved with word granularity\n'
        'final endEvent = SelectionEdgeUpdateEvent.forEnd(\n'
        '  globalPosition: Offset(300, 200),\n'
        '  granularity: TextGranularity.word,\n'
        ');',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Event Dispatch Pipeline
// ---------------------------------------------------------------------------
Widget _seBuildPipeline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '4. Event Dispatch Pipeline',
        subtitle: 'From user gesture to selection update',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'SelectionEdgeUpdateEvent flows through a specific pipeline.  '
        'Understanding this pipeline is key to understanding how '
        'Flutter\'s selection system works.',
        icon: Icons.account_tree,
      ),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _seIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Complete Pipeline',
              style: TextStyle(color: _seDarkAmber, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 14),
            _sePipelineCard('1', 'GestureDetector', 'Detects pan/drag gestures from user input', Icons.touch_app, _seRose),
            _sePipelineConnector(),
            _sePipelineCard('2', 'SelectableRegion', 'Creates SelectionEdgeUpdateEvent\nwith global position', Icons.spatial_tracking, _seAmber),
            _sePipelineConnector(),
            _sePipelineCard('3', 'Selectables.forEach', 'Event dispatched to each registered\nSelectable via dispatchSelectionEvent', Icons.send, _seTeal),
            _sePipelineConnector(),
            _sePipelineCard('4', 'Hit Test', 'Selectable converts global→local\ncoords and checks if position is within', Icons.gps_fixed, _seIndigo),
            _sePipelineConnector(),
            _sePipelineCard('5', 'Offset Computation', 'Determines nearest character offset\nfor the given local position', Icons.text_fields, _seBrown),
            _sePipelineConnector(),
            _sePipelineCard('6', 'Selection Update', 'Updates internal selection range\nNotifies parent of geometry change', Icons.update, _seAmber),
          ],
        ),
      ),

      _seCodeBlock(
        '// Inside a Selectable implementation:\n'
        'SelectionResult dispatchSelectionEvent(\n'
        '  SelectionEvent event,\n'
        ') {\n'
        '  if (event is SelectionEdgeUpdateEvent) {\n'
        '    return _handleEdgeUpdate(event);\n'
        '  }\n'
        '  // ... handle other event types\n'
        '}\n'
        '\n'
        'SelectionResult _handleEdgeUpdate(\n'
        '  SelectionEdgeUpdateEvent event,\n'
        ') {\n'
        '  final localPos = globalToLocal(\n'
        '    event.globalPosition,\n'
        '  );\n'
        '  final offset = getOffsetForPosition(localPos);\n'
        '  // Update selection based on edge type\n'
        '  if (event.type == SelectionEventType\n'
        '      .startEdgeUpdate) {\n'
        '    _startOffset = offset;\n'
        '  } else {\n'
        '    _endOffset = offset;\n'
        '  }\n'
        '  return SelectionResult.end;\n'
        '}',
      ),
    ],
  );
}

Widget _sePipelineCard(
  String number, String title, String desc, IconData icon, Color color,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(desc, style: const TextStyle(color: _seCharcoal, fontSize: 11, height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sePipelineConnector() {
  return const Padding(
    padding: EdgeInsets.only(left: 14),
    child: Icon(Icons.arrow_downward, color: _seGold, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Granularity Visualization
// ---------------------------------------------------------------------------
Widget _seBuildGranularityDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '5. Granularity In Action',
        subtitle: 'How different granularities affect selection snapping',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'The granularity field determines how the Selectable snaps the '
        'selection edge to text boundaries.  Higher granularities '
        'select larger units even if the drag position is in the middle.',
      ),

      // Character granularity
      _seSubheading('Character Granularity'),
      _seGranularityVisual(
        'The quick brown fox jumps over',
        [
          _SeHighlight(0, 3, 'The'),
          _SeHighlight(4, 9, 'quick'),
          _SeHighlight(10, 15, 'brown'),
        ],
        'Each character boundary is a potential snap point',
        _seAmber,
        selectedChars: {0, 1, 2, 3, 4, 5, 6},
      ),

      // Word granularity
      _seSubheading('Word Granularity'),
      _seGranularityVisual(
        'The quick brown fox jumps over',
        [
          _SeHighlight(0, 3, 'The'),
          _SeHighlight(4, 9, 'quick'),
          _SeHighlight(10, 15, 'brown'),
        ],
        'Selection snaps to word boundaries (double-tap drag)',
        _seTeal,
        selectedChars: {0, 1, 2, 3, 4, 5, 6, 7, 8},
      ),

      // Line granularity
      _seSubheading('Line Granularity'),
      _seGranularityVisual(
        'The quick brown fox jumps over',
        [
          _SeHighlight(0, 30, 'entire line'),
        ],
        'Entire line selected regardless of position (triple-click)',
        _seIndigo,
        selectedChars: Set.from(List.generate(30, (i) => i)),
      ),

      _seInfoCard(
        'The Selectable implementation must interpret the granularity '
        'and snap the computed offset accordingly.  For word granularity, '
        'it expands to include the entire word containing the position.  '
        'For line, it includes the entire line.',
        icon: Icons.rule,
      ),
    ],
  );
}

class _SeHighlight {
  const _SeHighlight(this.start, this.end, this.label);
  final int start;
  final int end;
  final String label;
}

Widget _seGranularityVisual(
  String text,
  List<_SeHighlight> highlights,
  String description,
  Color color, {
  Set<int> selectedChars = const {},
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _seIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 1,
          runSpacing: 4,
          children: [
            for (int i = 0; i < text.length; i++)
              Container(
                width: 18,
                height: 26,
                decoration: BoxDecoration(
                  color: selectedChars.contains(i)
                      ? color.withValues(alpha: 0.2)
                      : Colors.white,
                  border: Border.all(
                    color: selectedChars.contains(i)
                        ? color
                        : _seGold.withValues(alpha: 0.3),
                    width: selectedChars.contains(i) ? 1.5 : 0.5,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    text[i],
                    style: TextStyle(
                      color: selectedChars.contains(i) ? color : _seCharcoal,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: selectedChars.contains(i) ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: color, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Continuous Dispatch
// ---------------------------------------------------------------------------
Widget _seBuildContinuousDispatch() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '6. Continuous Dispatch During Drag',
        subtitle: 'Events fire rapidly as the user moves their finger',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'SelectionEdgeUpdateEvent is NOT a one-time event.  During a '
        'drag gesture, it fires continuously — potentially 60+ times '
        'per second — with each new global position.  This is what '
        'makes selection feel smooth and responsive.',
        icon: Icons.speed,
      ),

      // Visual: Timeline of events during drag
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _seIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Events During a Single Drag',
              style: TextStyle(color: _seDarkAmber, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            _seTimelineEvent('t=0ms', 'forEnd(globalPosition: Offset(100, 50))', _seAmber),
            _seTimelineEvent('t=16ms', 'forEnd(globalPosition: Offset(112, 50))', _seTeal),
            _seTimelineEvent('t=32ms', 'forEnd(globalPosition: Offset(125, 51))', _seAmber),
            _seTimelineEvent('t=48ms', 'forEnd(globalPosition: Offset(140, 52))', _seTeal),
            _seTimelineEvent('t=64ms', 'forEnd(globalPosition: Offset(158, 53))', _seAmber),
            _seTimelineEvent('...', '(continues until finger lifts)', _seBrown),
          ],
        ),
      ),

      _seInfoCard(
        'This rapid-fire dispatch is why Selectable implementations '
        'must be FAST.  The globalToLocal conversion, offset computation, '
        'and selection state update all happen in each frame.  Expensive '
        'operations in dispatchSelectionEvent will cause jank.',
        icon: Icons.warning_amber,
      ),

      _seCodeBlock(
        '// Performance-critical path in Selectable:\n'
        'SelectionResult dispatchSelectionEvent(event) {\n'
        '  // This runs 60+ times/second during drag!\n'
        '  final local = globalToLocal(event.globalPosition);\n'
        '  final offset = _getCharOffset(local); // Must be O(1)\n'
        '  _updateSelection(offset);\n'
        '  return SelectionResult.end;\n'
        '}',
      ),
    ],
  );
}

Widget _seTimelineEvent(String time, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            time,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Container(
          width: 8, height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _seCharcoal,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — SelectionResult
// ---------------------------------------------------------------------------
Widget _seBuildSelectionResult() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '7. SelectionResult Return Value',
        subtitle: 'How Selectables communicate their selection state back',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'When a Selectable processes a SelectionEdgeUpdateEvent, it '
        'returns a SelectionResult that tells the SelectableRegion '
        'whether the selection edge is within, before, or after '
        'this Selectable\'s content.',
      ),

      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _seAmber),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _seAmber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Text(
                'SelectionResult Values',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            _seResultCard(
              'SelectionResult.end',
              'The edge position falls within this Selectable — selection '
              'processing can stop for this edge.',
              Icons.check_circle,
              _seTeal,
            ),
            Container(height: 1, color: _seGold.withValues(alpha: 0.3)),
            _seResultCard(
              'SelectionResult.previous',
              'The edge position is BEFORE this Selectable — the previous '
              'Selectable in order should handle it.',
              Icons.arrow_upward,
              _seIndigo,
            ),
            Container(height: 1, color: _seGold.withValues(alpha: 0.3)),
            _seResultCard(
              'SelectionResult.next',
              'The edge position is AFTER this Selectable — the next '
              'Selectable in order should handle it.',
              Icons.arrow_downward,
              _seRose,
            ),
            Container(height: 1, color: _seGold.withValues(alpha: 0.3)),
            _seResultCard(
              'SelectionResult.pending',
              'The Selectable cannot determine the result yet — typically '
              'used during layout computation.',
              Icons.hourglass_empty,
              _seBrown,
            ),
          ],
        ),
      ),

      _seInfoCard(
        'SelectionResult is crucial for multi-widget selection.  When '
        'a selection spans three Text widgets, the middle one returns '
        'SelectionResult.end (it contains the edge), while the others '
        'return previous/next to indicate they are fully selected.',
        icon: Icons.widgets,
      ),
    ],
  );
}

Widget _seResultCard(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: _seCharcoal,
                  fontSize: 12,
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

// ---------------------------------------------------------------------------
// Section 8 — Live Demo
// ---------------------------------------------------------------------------
Widget _seBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '8. Live Selection Demo',
        subtitle: 'SelectionEdgeUpdateEvent drives selection in these widgets',
      ),
      const SizedBox(height: 12),
      _seInfoCard(
        'Select text below.  As you drag, SelectionEdgeUpdateEvent objects '
        'are being generated and dispatched to each Text widget continuously.',
        icon: Icons.select_all,
      ),

      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _seAmber, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: _seAmber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Drag to select — events fire continuously',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _seBadge('live', _seTeal),
                ],
              ),
            ),
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SelectionEdgeUpdateEvent in Action',
                      style: TextStyle(
                        color: _seDarkAmber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'As you drag your finger or mouse across this text, the '
                      'SelectableRegion creates a continuous stream of '
                      'SelectionEdgeUpdateEvent objects.  Each event carries '
                      'the current position of your drag point.',
                      style: TextStyle(
                        color: _seCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _seAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: _seAmber, width: 3),
                        ),
                      ),
                      child: const Text(
                        'Try double-tapping a word — this triggers a word-level '
                        'granularity event that selects the entire word.  Then '
                        'try triple-clicking (desktop only) for line selection.',
                        style: TextStyle(
                          color: _seBrown,
                          fontSize: 13,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Each Text widget independently processes the events and '
                      'returns a SelectionResult telling the system whether '
                      'the edge falls within its bounds or not.',
                      style: TextStyle(
                        color: _seCharcoal,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Comparison with Other Events
// ---------------------------------------------------------------------------
Widget _seBuildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '9. Event Type Comparison',
        subtitle: 'How SelectionEdgeUpdateEvent relates to other events',
      ),
      const SizedBox(height: 12),

      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _seAmber),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _seAmber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 3, child: Text('Event Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  Expanded(flex: 2, child: Text('Trigger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  Expanded(flex: 3, child: Text('Purpose', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                ],
              ),
            ),
            _seEventRow('EdgeUpdateEvent', 'Drag gesture', 'Move start/end edge', false),
            _seEventRow('SelectAllEvent', 'Ctrl+A', 'Select all content', true),
            _seEventRow('ClearSelectionEvent', 'Tap away', 'Remove selection', false),
            _seEventRow('GranularlyExtendEvent', 'Shift+arrow', 'Extend by granularity', true),
            _seEventRow('DirectionallyExtendEvent', 'Shift+Up/Dn', 'Extend directionally', false),
          ],
        ),
      ),

      _seInfoCard(
        'SelectionEdgeUpdateEvent is by far the most frequently fired.  '
        'It accounts for the vast majority of selection events because '
        'it fires continuously during drag.  The others are typically '
        'one-shot events triggered by keyboard shortcuts.',
        icon: Icons.bar_chart,
      ),
    ],
  );
}

Widget _seEventRow(String type, String trigger, String purpose, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _seLightGold.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(flex: 3, child: Text(type, style: const TextStyle(color: _seDarkAmber, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10))),
        Expanded(flex: 2, child: Text(trigger, style: const TextStyle(color: _seCharcoal, fontSize: 11))),
        Expanded(flex: 3, child: Text(purpose, style: const TextStyle(color: _seCharcoal, fontSize: 11))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Summary
// ---------------------------------------------------------------------------
Widget _seBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _seSectionHeader(
        '10. Summary',
        subtitle: 'Key takeaways about SelectionEdgeUpdateEvent',
      ),
      const SizedBox(height: 12),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_seAmber, _seDarkAmber],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'SelectionEdgeUpdateEvent — Takeaways',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _seSummaryItem('Most common event', 'Fired continuously during every drag gesture'),
            _seSummaryItem('Three fields', 'globalPosition, type (start/end), granularity'),
            _seSummaryItem('Named constructors', 'forStart() and forEnd() set type automatically'),
            _seSummaryItem('Performance critical', 'Fires 60+ times/sec — handlers must be fast'),
            _seSummaryItem('Returns SelectionResult', 'end/previous/next tells system where edge landed'),
            _seSummaryItem('Granularity aware', 'char/word/line/document snapping built in'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _seSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(color: _seGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(color: _seGold, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                TextSpan(
                  text: desc,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Main build function
// ============================================================================
dynamic build(BuildContext context) {
  print('--- SelectionEdgeUpdateEvent Deep Demo ---');
  print('Demonstrates the SelectionEdgeUpdateEvent from');
  print('Flutter\'s rendering-layer selection system.');
  print('');
  print('Sections:');
  print('  1. What Is SelectionEdgeUpdateEvent?');
  print('  2. Fields Breakdown');
  print('  3. Named Constructors');
  print('  4. Event Dispatch Pipeline');
  print('  5. Granularity In Action');
  print('  6. Continuous Dispatch During Drag');
  print('  7. SelectionResult Return Value');
  print('  8. Live Selection Demo');
  print('  9. Event Type Comparison');
  print('  10. Summary');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _seAmber,
      scaffoldBackgroundColor: _seIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _seDarkAmber,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionEdgeUpdateEvent — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _seGold.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.gesture, size: 14),
                SizedBox(width: 4),
                Text('Rendering', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _seBuildOverview(),
            _seDivider(),
            _seBuildFields(),
            _seDivider(),
            _seBuildConstructors(),
            _seDivider(),
            _seBuildPipeline(),
            _seDivider(),
            _seBuildGranularityDemo(),
            _seDivider(),
            _seBuildContinuousDispatch(),
            _seDivider(),
            _seBuildSelectionResult(),
            _seDivider(),
            _seBuildLiveDemo(),
            _seDivider(),
            _seBuildComparison(),
            _seDivider(),
            _seBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
