// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION EVENT — Deep Demo
// ============================================================================
//
// SelectionEvent is the abstract base class for the command language used
// by Flutter's rendering-layer selection system.  Every interaction that
// changes text selection — a tap, a drag, a keyboard shortcut — is
// translated into a SelectionEvent subclass and dispatched through the
// tree of Selectable render objects.
//
// The class hierarchy:
//
//   SelectionEvent (abstract)
//   ├── SelectAllSelectionEvent       (Ctrl+A — select everything)
//   ├── ClearSelectionEvent           (tap away — deselect)
//   ├── SelectionEdgeUpdateEvent      (drag / initial tap — move edge)
//   ├── GranularlyExtendSelectionEvent (Shift+Arrow — word/line extend)
//   └── DirectionallyExtendSelectionEvent (Shift+Up/Down — spatial extend)
//
// Each Selectable receives events via dispatchSelectionEvent() and must
// return a SelectionResult (next, end, or pending) to indicate how the
// event was consumed.
//
// This demo visually explores every event type, demonstrates the dispatch
// flow, and shows how the system converts user gestures into events.
//
// Color theme : Magenta (#9C27B0) / Orchid (#CE93D8)
// Helper prefix: _sv
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _svMagenta = Color(0xFF9C27B0);
const Color _svOrchid = Color(0xFFCE93D8);
const Color _svDarkMagenta = Color(0xFF6A0080);
const Color _svLightOrchid = Color(0xFFF3E5F5);
const Color _svPlum = Color(0xFF4A148C);
const Color _svCharcoal = Color(0xFF311B3A);
const Color _svAmber = Color(0xFFFFB300);
const Color _svTeal = Color(0xFF00897B);
const Color _svCoral = Color(0xFFE53935);
const Color _svSky = Color(0xFF42A5F5);
const Color _svMint = Color(0xFF66BB6A);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _svSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_svMagenta, _svDarkMagenta],
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
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _svInfoCard(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _svLightOrchid,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _svOrchid, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _svMagenta, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _svCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _svCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _svPlum,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _svOrchid,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _svSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _svMagenta,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _svDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _svOrchid.withValues(alpha: 0.4),
  );
}

Widget _svPill(String label, Color color, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
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

// ---------------------------------------------------------------------------
// Section 1 — What Is SelectionEvent?
// ---------------------------------------------------------------------------
Widget _svBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '1. What Is SelectionEvent?',
        subtitle: 'The abstract command language for content selection',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'SelectionEvent is the abstract base class for all commands that '
        'the selection system dispatches to Selectable render objects.  '
        'Think of it as the "vocabulary" for selection — every user gesture '
        '(tap, drag, keyboard shortcut) is translated into a SelectionEvent '
        'and sent through the render tree.',
        icon: Icons.event,
      ),
      _svInfoCard(
        'SelectionEvent itself has just one property: type, which is a '
        'SelectionEventType enum.  The concrete subclasses add the '
        'specific data each kind of event needs (position, direction, '
        'granularity, etc.).',
        icon: Icons.class_outlined,
      ),
      _svCodeSnippet(
        'abstract class SelectionEvent {\n'
        '  const SelectionEvent(this.type);\n'
        '\n'
        '  /// The type of this event.\n'
        '  final SelectionEventType type;\n'
        '}',
      ),

      // Visual: SelectionEvent as the hub connecting gestures to selectables
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _svLightOrchid,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _svMagenta, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'SelectionEvent as Communication Hub',
              style: TextStyle(
                color: _svDarkMagenta,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Top row: User gestures
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _svGestureChip(Icons.touch_app, 'Tap', _svAmber),
                _svGestureChip(Icons.swipe, 'Drag', _svCoral),
                _svGestureChip(Icons.keyboard, 'Keyboard', _svSky),
                _svGestureChip(Icons.menu, 'Menu', _svMint),
              ],
            ),
            const SizedBox(height: 8),
            // Arrows down
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            // Center: SelectionEvent
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: _svMagenta,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'SelectionEvent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Arrows down
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
                const Icon(Icons.arrow_downward, color: _svMagenta, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            // Bottom row: Selectable objects
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _svSelectableBox('Text A'),
                _svSelectableBox('Text B'),
                _svSelectableBox('Text C'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _svGestureChip(IconData icon, String label, Color color) {
  return Column(
    children: [
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _svSelectableBox(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: _svDarkMagenta,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.text_fields, color: _svOrchid, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — The Event Type Enum
// ---------------------------------------------------------------------------
Widget _svBuildEventTypes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '2. SelectionEventType Enum',
        subtitle: 'The type field that categorises every event',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'Every SelectionEvent carries a type field of type SelectionEventType.  '
        'This allows receivers to quickly switch on the event kind without '
        'checking is-type casts.  However, in practice most code uses the '
        'concrete subclass directly.',
      ),
      _svCodeSnippet(
        'enum SelectionEventType {\n'
        '  startEdgeUpdate,   // drag start handle\n'
        '  endEdgeUpdate,     // drag end handle\n'
        '  clear,             // deselect all\n'
        '  selectAll,         // select all content\n'
        '  selectWord,        // double-tap word\n'
        '  selectParagraph,   // triple-tap paragraph\n'
        '  granularlyExtend,  // Shift+arrow extend\n'
        '  directionallyExtend, // Shift+Up/Down\n'
        '}',
      ),

      // Visual: Enum values as colored tiles
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svMagenta),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _svEnumTile('startEdgeUpdate', _svAmber, Icons.drag_handle),
            _svEnumTile('endEdgeUpdate', _svCoral, Icons.drag_handle),
            _svEnumTile('clear', Colors.grey, Icons.clear),
            _svEnumTile('selectAll', _svMagenta, Icons.select_all),
            _svEnumTile('selectWord', _svTeal, Icons.text_fields),
            _svEnumTile('selectParagraph', _svSky, Icons.notes),
            _svEnumTile('granularlyExtend', _svMint, Icons.keyboard_arrow_right),
            _svEnumTile('directionallyExtend', _svPlum, Icons.open_with),
          ],
        ),
      ),
      _svInfoCard(
        'The type enum is primarily used internally by the selection system.  '
        'The more important distinction for developers is the concrete '
        'subclass, which carries the actual data needed to process the event.',
        icon: Icons.lightbulb_outline,
      ),
    ],
  );
}

Widget _svEnumTile(String label, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — The Complete Event Hierarchy
// ---------------------------------------------------------------------------
Widget _svBuildHierarchy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '3. The Complete Event Hierarchy',
        subtitle: 'All concrete subclasses of SelectionEvent',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'SelectionEvent has five direct concrete subclasses in the Flutter '
        'framework.  Each one encodes a fundamentally different kind of '
        'selection action.',
      ),

      // Visual: Hierarchy tree
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _svLightOrchid,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _svMagenta, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Root
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _svMagenta,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'SelectionEvent (abstract)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Branches
            _svHierarchyBranch(
              'SelectAllSelectionEvent',
              'No parameters — just the command to select all',
              _svAmber,
              Icons.select_all,
            ),
            _svHierarchyBranch(
              'ClearSelectionEvent',
              'No parameters — just the command to deselect',
              Colors.grey,
              Icons.clear,
            ),
            _svHierarchyBranch(
              'SelectionEdgeUpdateEvent',
              'globalPosition, type (start/end), granularity',
              _svCoral,
              Icons.touch_app,
            ),
            _svHierarchyBranch(
              'GranularlyExtendSelectionEvent',
              'forward/backward, granularity (char/word/line/doc)',
              _svTeal,
              Icons.keyboard,
            ),
            _svHierarchyBranch(
              'DirectionallyExtendSelectionEvent',
              'direction (up/down/left/right), isEnd flag',
              _svSky,
              Icons.open_with,
            ),
          ],
        ),
      ),
      _svSubheading('Event Data Comparison'),

      // Comparison table
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _svMagenta),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _svMagenta,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Triggered By',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _svTableRow('SelectAll', '(none)', 'Ctrl+A / Cmd+A', false),
            _svTableRow('Clear', '(none)', 'Tap outside', true),
            _svTableRow('EdgeUpdate', 'position, edge', 'Drag handle', false),
            _svTableRow('GranularlyExtend', 'dir, granularity', 'Shift+Arrow', true),
            _svTableRow('DirectionallyExtend', 'direction, isEnd', 'Shift+Up/Down', false),
          ],
        ),
      ),
    ],
  );
}

Widget _svHierarchyBranch(String name, String desc, Color color, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, top: 6, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 2,
          color: _svMagenta,
        ),
        const SizedBox(width: 6),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
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
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  color: _svCharcoal,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _svTableRow(String event, String data, String trigger, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _svLightOrchid.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            event,
            style: const TextStyle(
              color: _svDarkMagenta,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            data,
            style: const TextStyle(
              color: _svCharcoal,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            trigger,
            style: const TextStyle(
              color: _svCharcoal,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Event Dispatch Flow
// ---------------------------------------------------------------------------
Widget _svBuildDispatchFlow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '4. Event Dispatch Flow',
        subtitle: 'How events travel from gesture to response',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'The dispatch flow follows a clear path:\n\n'
        '1. User performs a gesture (tap, drag, key press)\n'
        '2. SelectableRegion converts gesture into SelectionEvent\n'
        '3. Event is dispatched to each registered Selectable\n'
        '4. Each Selectable returns a SelectionResult\n'
        '5. SelectableRegion uses results to update the overlay',
        icon: Icons.arrow_forward,
      ),

      // Visual: Flowchart
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _svMagenta, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Dispatch Flow',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            _svFlowStep('User Gesture', 'Pan / tap / key press', _svAmber, Icons.pan_tool),
            _svFlowArrow(),
            _svFlowStep('SelectableRegion', 'Converts to SelectionEvent', _svMagenta, Icons.transform),
            _svFlowArrow(),
            _svFlowStep('dispatchSelectionEvent()', 'Called on each Selectable', _svTeal, Icons.call_split),
            _svFlowArrow(),
            // Fork: three selectables
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _svFlowMiniBox('Selectable 1\n→ next', _svSky),
                _svFlowMiniBox('Selectable 2\n→ end', _svCoral),
                _svFlowMiniBox('Selectable 3\n→ (skipped)', Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            _svFlowArrow(),
            _svFlowStep('Update Overlay', 'Handles + highlight redrawn', _svMint, Icons.layers),
          ],
        ),
      ),
      _svSubheading('SelectionResult'),
      _svInfoCard(
        'Each Selectable returns a SelectionResult from dispatchSelectionEvent():\n\n'
        '• next — This selectable did not fully consume the event.  '
        'Continue to the next sibling.\n'
        '• end — This selectable consumed the event.  The selection edge '
        'ends here.  Stop dispatching.\n'
        '• pending — The selectable is still processing (rare, for async).',
        icon: Icons.call_merge,
      ),

      // Visual: SelectionResult states
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: _svResultCard(
                'next',
                'Pass through',
                'Event not consumed here',
                _svSky,
                Icons.arrow_forward,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _svResultCard(
                'end',
                'Consumed',
                'Selection edge stops here',
                _svCoral,
                Icons.stop,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _svResultCard(
                'pending',
                'Deferred',
                'Still processing (async)',
                _svAmber,
                Icons.hourglass_empty,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _svFlowStep(String title, String desc, Color color, IconData icon) {
  return Container(
    width: 240,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _svFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Icon(Icons.arrow_downward, color: _svMagenta, size: 22),
  );
}

Widget _svFlowMiniBox(String text, Color color) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _svResultCard(
  String title,
  String subtitle,
  String desc,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 13,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _svCharcoal,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — SelectAllSelectionEvent Deep Dive
// ---------------------------------------------------------------------------
Widget _svBuildSelectAll() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '5. SelectAllSelectionEvent',
        subtitle: 'The simplest event — select everything',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'SelectAllSelectionEvent is the most minimal event.  It has no '
        'additional parameters beyond the inherited type field.  When '
        'dispatched, every Selectable should select all of its content.',
        icon: Icons.select_all,
      ),
      _svCodeSnippet(
        'class SelectAllSelectionEvent\n'
        '    extends SelectionEvent {\n'
        '  const SelectAllSelectionEvent()\n'
        '    : super(SelectionEventType.selectAll);\n'
        '}',
      ),

      // Visual: Before and after select-all
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svAmber, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Select All — Before & After',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            // Before
            Row(
              children: [
                _svPill('BEFORE', Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _svLightOrchid,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'The quick brown fox jumps over the lazy dog.',
                      style: TextStyle(color: _svCharcoal, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Icon(Icons.arrow_downward, color: _svAmber, size: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _svPill('SelectAllSelectionEvent dispatched', _svAmber),
            ),
            const Icon(Icons.arrow_downward, color: _svAmber, size: 20),
            const SizedBox(height: 8),
            // After
            Row(
              children: [
                _svPill('AFTER', _svAmber),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _svAmber.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _svAmber, width: 2),
                    ),
                    child: const Text(
                      'The quick brown fox jumps over the lazy dog.',
                      style: TextStyle(
                        color: _svDarkMagenta,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'All content selected — every Selectable highlights everything',
              style: TextStyle(
                color: _svCharcoal,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6 — ClearSelectionEvent Deep Dive
// ---------------------------------------------------------------------------
Widget _svBuildClear() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '6. ClearSelectionEvent',
        subtitle: 'Deselect all content',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'ClearSelectionEvent is the complement of SelectAllSelectionEvent.  '
        'Also parameter-less, it instructs every Selectable to clear its '
        'selection.  Typically triggered when the user taps outside the '
        'current selection area.',
        icon: Icons.clear,
      ),
      _svCodeSnippet(
        'class ClearSelectionEvent\n'
        '    extends SelectionEvent {\n'
        '  const ClearSelectionEvent()\n'
        '    : super(SelectionEventType.clear);\n'
        '}',
      ),

      // Visual: Selected → clear → empty
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            // Selected state
            Expanded(
              child: Column(
                children: [
                  _svPill('Selected', _svCoral),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _svCoral.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _svCoral),
                    ),
                    child: const Text(
                      'Some text\nwith selection',
                      style: TextStyle(
                        color: _svCharcoal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Icon(Icons.arrow_forward, color: Colors.grey, size: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Cleared state
            Expanded(
              child: Column(
                children: [
                  _svPill('Cleared', Colors.grey),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _svLightOrchid,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Some text\nwithout selection',
                      style: TextStyle(
                        color: _svCharcoal,
                        fontSize: 12,
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
  );
}

// ---------------------------------------------------------------------------
// Section 7 — SelectionEdgeUpdateEvent Deep Dive
// ---------------------------------------------------------------------------
Widget _svBuildEdgeUpdate() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '7. SelectionEdgeUpdateEvent',
        subtitle: 'The workhorse — moving selection edges by position',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'SelectionEdgeUpdateEvent is dispatched when the user drags a '
        'selection handle or performs the initial tap that starts a '
        'selection.  It carries a globalPosition (Offset) and a type '
        '(startEdge or endEdge) so each Selectable can determine which '
        'character boundary to snap to.',
        icon: Icons.swipe,
      ),
      _svCodeSnippet(
        'class SelectionEdgeUpdateEvent\n'
        '    extends SelectionEvent {\n'
        '  const SelectionEdgeUpdateEvent.forStart({\n'
        '    required this.globalPosition,\n'
        '    this.granularity =\n'
        '        TextGranularity.character,\n'
        '  }) : super(\n'
        '    SelectionEventType.startEdgeUpdate);\n'
        '\n'
        '  const SelectionEdgeUpdateEvent.forEnd({\n'
        '    required this.globalPosition,\n'
        '    this.granularity =\n'
        '        TextGranularity.character,\n'
        '  }) : super(\n'
        '    SelectionEventType.endEdgeUpdate);\n'
        '\n'
        '  final Offset globalPosition;\n'
        '  final TextGranularity granularity;\n'
        '}',
      ),

      // Visual: Edge update demonstration
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svCoral, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Edge Update — Start vs End Handle',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            // Text with handles
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _svLightOrchid,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Text(
                    'Hello ',
                    style: TextStyle(color: _svCharcoal, fontSize: 14),
                  ),
                  // Start handle
                  Column(
                    children: [
                      Container(
                        width: 2,
                        height: 20,
                        color: _svTeal,
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: _svTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: _svMagenta.withValues(alpha: 0.3),
                    child: const Text(
                      'beautiful ',
                      style: TextStyle(
                        color: _svDarkMagenta,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // End handle
                  Column(
                    children: [
                      Container(
                        width: 2,
                        height: 20,
                        color: _svCoral,
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: _svCoral,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'world',
                    style: TextStyle(color: _svCharcoal, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: _svTeal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Start handle (forStart)',
                      style: TextStyle(
                        color: _svTeal,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: _svCoral,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'End handle (forEnd)',
                      style: TextStyle(
                        color: _svCoral,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      _svSubheading('TextGranularity'),
      _svInfoCard(
        'The granularity field on SelectionEdgeUpdateEvent specifies how '
        'precisely the edge should snap:\n\n'
        '• character — snap to nearest character boundary (default)\n'
        '• word — snap to word boundary (double-tap-drag)\n'
        '• line — snap to line boundary\n'
        '• document — snap to document start/end',
        icon: Icons.tune,
      ),

      // Visual: Granularity examples
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _svGranularityExample(
              'character',
              'H|e|l|l|o| |W|o|r|l|d',
              _svMagenta,
            ),
            const SizedBox(height: 6),
            _svGranularityExample(
              'word',
              '|Hello| |World|',
              _svTeal,
            ),
            const SizedBox(height: 6),
            _svGranularityExample(
              'line',
              '|Hello World  (entire line)|',
              _svSky,
            ),
            const SizedBox(height: 6),
            _svGranularityExample(
              'document',
              '|All content in document|',
              _svAmber,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _svGranularityExample(String label, String example, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            example,
            style: const TextStyle(
              color: _svCharcoal,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — GranularlyExtendSelectionEvent
// ---------------------------------------------------------------------------
Widget _svBuildGranularlyExtend() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '8. GranularlyExtendSelectionEvent',
        subtitle: 'Shift+Arrow — extending selection by units',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'GranularlyExtendSelectionEvent extends an existing selection by a '
        'specified granularity unit in a specified direction.  This is the '
        'event generated when the user holds Shift and presses arrow keys '
        'on desktop, or uses VoiceOver/TalkBack selection gestures.',
        icon: Icons.keyboard,
      ),
      _svCodeSnippet(
        'class GranularlyExtendSelectionEvent\n'
        '    extends SelectionEvent {\n'
        '  const GranularlyExtendSelectionEvent({\n'
        '    required this.forward,\n'
        '    required this.isEnd,\n'
        '    required this.granularity,\n'
        '  }) : super(SelectionEventType\n'
        '            .granularlyExtend);\n'
        '\n'
        '  final bool forward;\n'
        '  final bool isEnd;\n'
        '  final TextGranularity granularity;\n'
        '}',
      ),

      // Visual: Step-by-step extension
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svTeal, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shift+Right Arrow (character granularity)',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _svExtensionStep('Step 0', 'Hello |world', 'Cursor at position 6', Colors.grey),
            _svExtensionStep('Step 1', 'Hello [w]orld', 'Shift+Right: extend by 1 char', _svTeal),
            _svExtensionStep('Step 2', 'Hello [wo]rld', 'Shift+Right: extend by 1 char', _svTeal),
            _svExtensionStep('Step 3', 'Hello [wor]ld', 'Shift+Right: extend by 1 char', _svTeal),
            const SizedBox(height: 8),
            const Text(
              'Each Shift+Right generates a GranularlyExtendSelectionEvent\n'
              'with forward=true, granularity=character',
              style: TextStyle(
                color: _svCharcoal,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),

      // Visual: Word-level extension
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svMint, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ctrl+Shift+Right (word granularity)',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _svExtensionStep('Step 0', 'Hello |world of code', 'Cursor at "world"', Colors.grey),
            _svExtensionStep('Step 1', 'Hello [world] of code', 'Extend: 1 word forward', _svMint),
            _svExtensionStep('Step 2', 'Hello [world of] code', 'Extend: 1 more word', _svMint),
            _svExtensionStep('Step 3', 'Hello [world of code]', 'Extend: 1 more word', _svMint),
          ],
        ),
      ),
    ],
  );
}

Widget _svExtensionStep(String label, String text, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: _svCharcoal,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
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
// Section 9 — DirectionallyExtendSelectionEvent
// ---------------------------------------------------------------------------
Widget _svBuildDirectionallyExtend() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '9. DirectionallyExtendSelectionEvent',
        subtitle: 'Shift+Up/Down — spatial extension across lines',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'DirectionallyExtendSelectionEvent extends the selection in a '
        'spatial direction — up, down, left, or right.  Unlike granular '
        'extension (which works in text units), this one is position-based, '
        'meaning it can extend across different Selectables (e.g., from '
        'one paragraph to the next).',
        icon: Icons.open_with,
      ),
      _svCodeSnippet(
        'class DirectionallyExtendSelectionEvent\n'
        '    extends SelectionEvent {\n'
        '  const DirectionallyExtendSelectionEvent({\n'
        '    required this.dx,\n'
        '    required this.direction,\n'
        '    required this.isEnd,\n'
        '  }) : super(SelectionEventType\n'
        '            .directionallyExtend);\n'
        '\n'
        '  final double dx;  // horizontal position\n'
        '  final SelectionExtendDirection direction;\n'
        '  final bool isEnd;\n'
        '}',
      ),

      // Visual: Multi-line selection extension
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svSky, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Shift+Down — Extending Across Lines',
              style: TextStyle(
                color: _svDarkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _svLineBlock('Line 1: The quick brown fox', false, false),
            _svLineBlock('Line 2: jumps over the lazy', false, true),
            _svLineBlock('Line 3: dog and then runs', true, false),
            _svLineBlock('Line 4: far away quickly', false, false),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _svPill('Cursor at line 2', _svSky),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_downward, color: _svSky, size: 16),
                const SizedBox(width: 8),
                _svPill('Selection extends to line 3', _svMagenta),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Direction: previousLine / nextLine / forward / backward',
              style: TextStyle(
                color: _svCharcoal,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),

      // Visual: Direction enum
      _svSubheading('SelectionExtendDirection'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _svLightOrchid,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _svOrchid),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 80),
                _svDirectionBox('previousLine', _svSky),
                const SizedBox(width: 80),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _svDirectionBox('backward', _svTeal),
                Container(
                  width: 60,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _svMagenta,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Cursor',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                _svDirectionBox('forward', _svMint),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 80),
                _svDirectionBox('nextLine', _svCoral),
                const SizedBox(width: 80),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _svLineBlock(String text, bool isHighlighted, bool hasCursor) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      color: isHighlighted
          ? _svMagenta.withValues(alpha: 0.15)
          : (hasCursor
              ? _svSky.withValues(alpha: 0.1)
              : Colors.transparent),
      borderRadius: BorderRadius.circular(4),
      border: hasCursor
          ? Border.all(color: _svSky, width: 1)
          : (isHighlighted
              ? Border.all(color: _svMagenta.withValues(alpha: 0.4))
              : null),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: _svCharcoal,
        fontSize: 12,
        fontFamily: 'monospace',
        fontWeight: isHighlighted || hasCursor ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _svDirectionBox(String label, Color color) {
  return Container(
    width: 80,
    height: 36,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Gesture-to-Event Mapping
// ---------------------------------------------------------------------------
Widget _svBuildGestureMapping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '10. Gesture-to-Event Mapping',
        subtitle: 'How user interactions become SelectionEvents',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'SelectableRegion translates raw user gestures into the appropriate '
        'SelectionEvent subclass.  Here is the mapping for common gestures:',
        icon: Icons.gesture,
      ),

      // Visual: Gesture mapping table
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _svMagenta),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _svMagenta,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Gesture',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'SelectionEvent',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Platform',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _svGestureRow('Long press', 'EdgeUpdate (character)', 'Mobile', false),
            _svGestureRow('Long press + drag', 'EdgeUpdate (character)', 'Mobile', true),
            _svGestureRow('Double tap', 'EdgeUpdate (word)', 'Both', false),
            _svGestureRow('Triple tap', 'EdgeUpdate (paragraph)', 'Both', true),
            _svGestureRow('Click + drag', 'EdgeUpdate (character)', 'Desktop', false),
            _svGestureRow('Tap outside', 'ClearSelectionEvent', 'Both', true),
            _svGestureRow('Ctrl+A / Cmd+A', 'SelectAllSelectionEvent', 'Desktop', false),
            _svGestureRow('Shift+Arrow', 'GranularlyExtend', 'Desktop', true),
            _svGestureRow('Shift+Ctrl+Arrow', 'GranularlyExtend (word)', 'Desktop', false),
            _svGestureRow('Shift+Up/Down', 'DirectionallyExtend', 'Desktop', true),
          ],
        ),
      ),

      _svSubheading('Mobile vs Desktop'),
      _svInfoCard(
        'Flutter\'s selection system adapts to the platform.  On mobile, '
        'long-press starts selection and produces EdgeUpdate events.  '
        'On desktop, click-and-drag with Shift for extension produces '
        'GranularlyExtend or DirectionallyExtend events.  The core '
        'SelectionEvent types are the same — only the gesture that triggers '
        'them differs.',
        icon: Icons.devices,
      ),

      // Visual: Platform comparison
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _svAmber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _svAmber),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.phone_android, color: _svAmber, size: 28),
                    const SizedBox(height: 6),
                    const Text(
                      'Mobile',
                      style: TextStyle(
                        color: _svAmber,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '• Long press → EdgeUpdate\n'
                      '• Drag handles → EdgeUpdate\n'
                      '• Double tap → word select\n'
                      '• Toolbar → SelectAll/Copy',
                      style: TextStyle(
                        color: _svCharcoal.withValues(alpha: 0.8),
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _svSky.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _svSky),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.desktop_windows, color: _svSky, size: 28),
                    const SizedBox(height: 6),
                    const Text(
                      'Desktop',
                      style: TextStyle(
                        color: _svSky,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '• Click+drag → EdgeUpdate\n'
                      '• Shift+Arrow → Granular\n'
                      '• Shift+Up/Down → Directional\n'
                      '• Ctrl+A → SelectAll',
                      style: TextStyle(
                        color: _svCharcoal.withValues(alpha: 0.8),
                        fontSize: 10,
                        height: 1.5,
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

Widget _svGestureRow(String gesture, String event, String platform, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    color: isAlt ? _svLightOrchid.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            gesture,
            style: const TextStyle(
              color: _svCharcoal,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            event,
            style: const TextStyle(
              color: _svDarkMagenta,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            platform,
            style: const TextStyle(
              color: _svCharcoal,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Live Selection Demo
// ---------------------------------------------------------------------------
Widget _svBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '11. Live Selection Demo',
        subtitle: 'Interactive SelectionArea with styled content',
      ),
      const SizedBox(height: 12),
      _svInfoCard(
        'This section demonstrates SelectionEvent in action through actual '
        'SelectionArea widgets.  Every selection gesture you perform here '
        'generates SelectionEvent instances dispatched to Selectable '
        'render objects behind the scenes.',
        icon: Icons.play_arrow,
      ),

      // Demo 1: Article
      _svSubheading('Demo A: Article Content'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svMagenta, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _svMagenta,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.article, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Selectable Article',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _svPill('events active', _svAmber),
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
                      'How SelectionEvent Drives Selection',
                      style: TextStyle(
                        color: _svDarkMagenta,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Every interaction you make with this text — tapping, '
                      'dragging, using keyboard shortcuts — creates a '
                      'SelectionEvent that flows through the rendering tree.',
                      style: TextStyle(
                        color: _svCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'The SelectionEvent base class defines the contract: '
                      'each event carries a type enum and the concrete subclass '
                      'adds specific data.  This polymorphic design allows the '
                      'system to handle all selection patterns through a single '
                      'dispatch method.',
                      style: TextStyle(
                        color: _svCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _svAmber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: _svAmber, width: 4),
                        ),
                      ),
                      child: const Text(
                        '"SelectionEvent is the single language that unifies all '
                        'selection interactions across platforms, devices, and '
                        'accessibility modes."',
                        style: TextStyle(
                          color: _svDarkMagenta,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Demo 2: Sequential paragraphs
      _svSubheading('Demo B: Cross-Paragraph Selection'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _svTeal, width: 2),
        ),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _svTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Paragraph 1: SelectionEdgeUpdateEvent is dispatched when '
                    'you start dragging.  The globalPosition tells each '
                    'Selectable where the finger or cursor is.',
                    style: TextStyle(
                      color: _svCharcoal,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _svMagenta.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Paragraph 2: As the drag crosses from one paragraph '
                    'to another, the first Selectable returns '
                    'SelectionResult.next, and the dispatch continues to '
                    'this Selectable.',
                    style: TextStyle(
                      color: _svCharcoal,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _svSky.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Paragraph 3: The Selectable where the drag ends returns '
                    'SelectionResult.end, and the dispatch stops.  All three '
                    'paragraphs show their selection highlight.',
                    style: TextStyle(
                      color: _svCharcoal,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 12 — Best Practices & Summary
// ---------------------------------------------------------------------------
Widget _svBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _svSectionHeader(
        '12. Best Practices & Summary',
        subtitle: 'Working effectively with SelectionEvents',
      ),
      const SizedBox(height: 12),
      _svSubheading('For Widget Developers'),
      _svInfoCard(
        '✓  Wrap content in SelectionArea — events are handled automatically\n'
        '✓  Use separate SelectionAreas for independent selection regions\n'
        '✓  Test both mobile (long-press) and desktop (click-drag) gestures\n'
        '✗  Don\'t try to create or dispatch SelectionEvents manually\n'
        '✗  Don\'t mix SelectableText with SelectionArea (they conflict)',
        icon: Icons.checklist,
      ),
      _svSubheading('For Framework / Custom Widget Developers'),
      _svInfoCard(
        '✓  Handle all event types in dispatchSelectionEvent()\n'
        '✓  Return SelectionResult.next if event is outside your bounds\n'
        '✓  Return SelectionResult.end if your content consumes the edge\n'
        '✓  Update SelectionGeometry whenever selection changes\n'
        '✓  Use switch/case on event.type for efficient routing',
        icon: Icons.code,
      ),

      // Summary card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_svMagenta, _svPlum],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _svAmber, size: 20),
                SizedBox(width: 8),
                Text(
                  'SelectionEvent — Key Takeaways',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _svSummaryBullet(
              'Base Class',
              'SelectionEvent is the abstract base with a type '
              'enum and five concrete subclasses.',
            ),
            _svSummaryBullet(
              'Event Types',
              'SelectAll, Clear, EdgeUpdate, GranularlyExtend, '
              'DirectionallyExtend — covering all selection patterns.',
            ),
            _svSummaryBullet(
              'Dispatch',
              'Events flow through Selectables via dispatchSelectionEvent().  '
              'Each returns a SelectionResult.',
            ),
            _svSummaryBullet(
              'Platform',
              'Same event types on mobile and desktop — only the triggering '
              'gesture differs.',
            ),
            _svSummaryBullet(
              'Automatic',
              'Widget developers rarely interact with SelectionEvent '
              'directly — SelectionArea handles everything.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _svSummaryBullet(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: _svAmber,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(
                    color: _svOrchid,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: desc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                    height: 1.4,
                  ),
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
// Main build function — entry point for d4rt interpreter
// ============================================================================
dynamic build(BuildContext context) {
  print('--- SelectionEvent Deep Demo ---');
  print('Demonstrates the abstract SelectionEvent base class and');
  print('its five concrete subclasses in the rendering-layer');
  print('selection system.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionEvent?');
  print('  2.  SelectionEventType Enum');
  print('  3.  The Complete Event Hierarchy');
  print('  4.  Event Dispatch Flow');
  print('  5.  SelectAllSelectionEvent');
  print('  6.  ClearSelectionEvent');
  print('  7.  SelectionEdgeUpdateEvent');
  print('  8.  GranularlyExtendSelectionEvent');
  print('  9.  DirectionallyExtendSelectionEvent');
  print(' 10.  Gesture-to-Event Mapping');
  print(' 11.  Live Selection Demo');
  print(' 12.  Best Practices & Summary');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _svMagenta,
      scaffoldBackgroundColor: _svLightOrchid,
      appBarTheme: const AppBarTheme(
        backgroundColor: _svDarkMagenta,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionEvent — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _svOrchid.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.event, size: 14),
                SizedBox(width: 4),
                Text(
                  'Rendering',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _svBuildOverview(),
            _svDivider(),
            _svBuildEventTypes(),
            _svDivider(),
            _svBuildHierarchy(),
            _svDivider(),
            _svBuildDispatchFlow(),
            _svDivider(),
            _svBuildSelectAll(),
            _svDivider(),
            _svBuildClear(),
            _svDivider(),
            _svBuildEdgeUpdate(),
            _svDivider(),
            _svBuildGranularlyExtend(),
            _svDivider(),
            _svBuildDirectionallyExtend(),
            _svDivider(),
            _svBuildGestureMapping(),
            _svDivider(),
            _svBuildLiveDemo(),
            _svDivider(),
            _svBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
