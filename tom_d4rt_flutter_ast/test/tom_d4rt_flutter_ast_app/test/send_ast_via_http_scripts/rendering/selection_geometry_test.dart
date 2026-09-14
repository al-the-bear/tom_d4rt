// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION GEOMETRY — Deep Demo
// ============================================================================
//
// SelectionGeometry is the immutable data class that every Selectable
// publishes via its `value` property (a ValueListenable).  It tells
// the SelectableRegion everything it needs to know about the current
// selection state inside a particular selectable:
//
//   • status       – SelectionStatus.none / .collapsed / .uncollapsed
//   • hasContent   – whether the selectable has any content at all
//   • startSelectionPoint – where the start handle goes (SelectionPoint?)
//   • endSelectionPoint   – where the end handle goes   (SelectionPoint?)
//
// SelectableRegion listens to geometry changes from every registered
// Selectable and uses this information to:
//   1. Position the drag handles (start & end)
//   2. Show/hide the selection toolbar (copy, etc.)
//   3. Determine which selectables are part of the current selection
//
// SelectionPoint itself carries:
//   • localPosition – Offset of the handle in the selectable's coords
//   • lineHeight    – height of the text line (for handle sizing)
//   • handleType    – TextSelectionHandleType (left, right, collapsed)
//
// This demo visualises all the geometry concepts, shows how different
// selection states look, and demonstrates the relationship between
// SelectionGeometry and the visible selection UI.
//
// Color theme : Indigo (#3F51B5) / Periwinkle (#9FA8DA)
// Helper prefix: _sg
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _sgIndigo = Color(0xFF3F51B5);
const Color _sgPeriwinkle = Color(0xFF9FA8DA);
const Color _sgDarkIndigo = Color(0xFF1A237E);
const Color _sgLightPeriwinkle = Color(0xFFE8EAF6);
const Color _sgDeepPurple = Color(0xFF283593);
const Color _sgIce = Color(0xFFF5F5FA);
const Color _sgNavy = Color(0xFF0D1B3E);
const Color _sgAmber = Color(0xFFFFC107);
const Color _sgCoral = Color(0xFFEF5350);
const Color _sgMint = Color(0xFF4CAF50);
const Color _sgSlate = Color(0xFF546E7A);
const Color _sgSunflower = Color(0xFFFFD740);

// ---------------------------------------------------------------------------
// Reusable helpers — unique to this demo
// ---------------------------------------------------------------------------

Widget _sgSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_sgIndigo, _sgDarkIndigo],
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
            letterSpacing: 0.4,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _sgNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _sgLightPeriwinkle,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _sgPeriwinkle, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _sgIndigo, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _sgNavy,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sgCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _sgNavy,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _sgPeriwinkle,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _sgFieldRow(String field, String desc, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            field,
            style: TextStyle(
              color: color ?? _sgDeepPurple,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _sgNavy,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sgSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _sgIndigo,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _sgDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _sgPeriwinkle.withValues(alpha: 0.4),
  );
}

Widget _sgTag(String label, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
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
// Section 1 — Overview
// ---------------------------------------------------------------------------
Widget _sgBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '1. What Is SelectionGeometry?',
        subtitle: 'The "report card" that every Selectable publishes',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'SelectionGeometry is an immutable data class that describes the '
        'current selection state inside a single Selectable render object.  '
        'Think of it as the Selectable telling the system: "here is where '
        'my handles are, here is my selection status, and here is whether '
        'I contain any content."',
      ),
      _sgNote(
        'Every Selectable exposes a ValueListenable<SelectionGeometry> '
        'through its value property.  The SelectableRegion listens to '
        'these geometry changes and uses them to position drag handles, '
        'show/hide the context menu, and coordinate selection across '
        'multiple selectables.',
        icon: Icons.visibility,
      ),

      // Visual: The geometry as a data card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _sgIndigo, width: 2),
          boxShadow: [
            BoxShadow(
              color: _sgIndigo.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.data_object, color: _sgIndigo, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'SelectionGeometry',
                  style: TextStyle(
                    color: _sgDarkIndigo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                _sgTag('immutable', _sgIndigo),
              ],
            ),
            const SizedBox(height: 14),
            _sgFieldRow('status', 'SelectionStatus — none, collapsed, uncollapsed'),
            _sgFieldRow('hasContent', 'bool — does this Selectable have content?'),
            _sgFieldRow('startSelectionPoint', 'SelectionPoint? — start handle'),
            _sgFieldRow('endSelectionPoint', 'SelectionPoint? — end handle'),
            const Divider(color: _sgPeriwinkle, height: 20),
            _sgFieldRow('hasSelection', 'bool (getter) — status ≠ .none', color: _sgSlate),
          ],
        ),
      ),

      _sgNote(
        'Key insight: SelectionGeometry is local to one Selectable.  The '
        'SelectableRegion merges geometry from multiple selectables to '
        'determine the overall selection state — e.g. the start handle '
        'may come from Selectable A and the end handle from Selectable C.',
        icon: Icons.merge_type,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2 — SelectionStatus Enum
// ---------------------------------------------------------------------------
Widget _sgBuildStatusEnum() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '2. SelectionStatus Enum',
        subtitle: 'The three possible states of selection within a Selectable',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'The status field is a SelectionStatus enum with exactly three values.  '
        'It tells the system whether this Selectable has no selection, a '
        'collapsed cursor (zero-width), or an actual range of selected content.',
      ),

      // Visual: Three states as side-by-side cards
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // None
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sgIce,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sgSlate, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _sgSlate,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.block, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '.none',
                      style: TextStyle(
                        color: _sgSlate,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'No selection at all.\nNo handles shown.\nDefault state.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _sgNavy,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Mock text with no selection
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _sgPeriwinkle),
                      ),
                      child: const Text(
                        'Hello world',
                        style: TextStyle(
                          color: _sgNavy,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Collapsed
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sgIce,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sgAmber, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: _sgAmber,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '|',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '.collapsed',
                      style: TextStyle(
                        color: _sgAmber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Cursor position.\nZero-width.\nOne handle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _sgNavy,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Mock text with cursor
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _sgPeriwinkle),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Hel',
                            style: TextStyle(color: _sgNavy, fontSize: 12),
                          ),
                          Container(
                            width: 2,
                            height: 16,
                            color: _sgAmber,
                          ),
                          const Text(
                            'lo world',
                            style: TextStyle(color: _sgNavy, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Uncollapsed
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sgIce,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sgIndigo, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: _sgIndigo,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.select_all, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '.uncollapsed',
                      style: TextStyle(
                        color: _sgIndigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Range selected.\nTwo handles.\nContent highlighted.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _sgNavy,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Mock text with highlight
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _sgPeriwinkle),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'He',
                            style: TextStyle(color: _sgNavy, fontSize: 12),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            color: _sgIndigo.withValues(alpha: 0.25),
                            child: const Text(
                              'llo wo',
                              style: TextStyle(color: _sgNavy, fontSize: 12),
                            ),
                          ),
                          const Text(
                            'rld',
                            style: TextStyle(color: _sgNavy, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      _sgCodeSnippet(
        'enum SelectionStatus {\n'
        '  none,        // no selection\n'
        '  collapsed,   // cursor without range\n'
        '  uncollapsed, // actual range selected\n'
        '}\n'
        '\n'
        '// Check if any selection exists:\n'
        '// geometry.hasSelection ==\n'
        '//   geometry.status != .none',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — SelectionPoint
// ---------------------------------------------------------------------------
Widget _sgBuildSelectionPoint() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '3. SelectionPoint — Handle Positioning',
        subtitle: 'Where exactly to place each drag handle',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'Each handle (start and end) is described by a SelectionPoint, which '
        'carries three pieces of information: the local offset, the line '
        'height at that position, and the handle type.',
      ),
      _sgCodeSnippet(
        'class SelectionPoint {\n'
        '  final Offset localPosition;\n'
        '  final double lineHeight;\n'
        '  final TextSelectionHandleType\n'
        '      handleType;\n'
        '}',
      ),
      _sgSubtitle('localPosition'),
      _sgNote(
        'The offset in the Selectable\'s local coordinate system.  '
        'This is the exact point where the handle\'s tip should appear — '
        'typically at the baseline of the text, at the left edge (for start) '
        'or right edge (for end) of the selection.',
        icon: Icons.place,
      ),
      _sgSubtitle('lineHeight'),
      _sgNote(
        'The height of the text line at the handle position.  This is used '
        'to size the handle appropriately — taller lines get taller handles '
        'so the handle visually matches the text height.',
        icon: Icons.height,
      ),
      _sgSubtitle('handleType'),
      _sgNote(
        'One of the three TextSelectionHandleType values: left, right, or '
        'collapsed.  This determines the visual style of the handle.',
        icon: Icons.drag_handle,
      ),

      // Visual: Handle types comparison
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo),
        ),
        child: Column(
          children: [
            const Text(
              'TextSelectionHandleType',
              style: TextStyle(
                color: _sgDarkIndigo,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _sgHandleDemo('left', const Color(0xFF2196F3), true, false),
                _sgHandleDemo('right', const Color(0xFFE91E63), false, false),
                _sgHandleDemo('collapsed', const Color(0xFFFF9800), false, true),
              ],
            ),
          ],
        ),
      ),

      // Visual: Handle placement on text
      _sgSubtitle('Handle Placement on Text'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _sgIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgPeriwinkle),
        ),
        child: Column(
          children: [
            // Mock text line with handles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Start handle (left type)
                Column(
                  children: [
                    const Text(
                      'The ',
                      style: TextStyle(color: _sgNavy, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                // Start handle indicator
                Column(
                  children: [
                    Container(
                      width: 2,
                      height: 18,
                      color: _sgIndigo,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _sgIndigo,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                // Selected text
                Container(
                  color: _sgIndigo.withValues(alpha: 0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: const Text(
                    'quick brown',
                    style: TextStyle(color: _sgNavy, fontSize: 14),
                  ),
                ),
                // End handle indicator
                Column(
                  children: [
                    Container(
                      width: 2,
                      height: 18,
                      color: _sgIndigo,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _sgIndigo,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                const Text(
                  ' fox',
                  style: TextStyle(color: _sgNavy, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _sgTag('start: left', _sgIndigo),
                const SizedBox(width: 20),
                _sgTag('end: right', _sgIndigo),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'localPosition marks where each handle sits\n'
              'lineHeight determines handle vertical extent',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _sgSlate,
                fontSize: 11,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _sgHandleDemo(String label, Color color, bool isLeft, bool isCollapsed) {
  return Column(
    children: [
      // Handle shape
      if (isCollapsed)
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        )
      else
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? const Radius.circular(12) : Radius.zero,
              topRight: isLeft ? Radius.zero : const Radius.circular(12),
              bottomLeft: const Radius.circular(12),
              bottomRight: const Radius.circular(12),
            ),
          ),
        ),
      Container(
        width: 2,
        height: isCollapsed ? 20 : 24,
        color: color,
      ),
      const SizedBox(height: 6),
      Text(
        '.$label',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontFamily: 'monospace',
        ),
      ),
      Text(
        isCollapsed ? 'cursor' : isLeft ? 'start' : 'end',
        style: const TextStyle(
          color: _sgSlate,
          fontSize: 10,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Geometry Creation
// ---------------------------------------------------------------------------
Widget _sgBuildCreation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '4. Creating SelectionGeometry',
        subtitle: 'How Selectables construct their geometry objects',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'SelectionGeometry is constructed via its const constructor.  '
        'A Selectable creates a new instance every time its selection '
        'state changes and notifies its ValueNotifier listeners.',
      ),
      _sgCodeSnippet(
        '// No selection\n'
        'const SelectionGeometry(\n'
        '  status: SelectionStatus.none,\n'
        '  hasContent: true,\n'
        ')\n'
        '\n'
        '// Collapsed cursor at offset (50,10)\n'
        'SelectionGeometry(\n'
        '  status: SelectionStatus.collapsed,\n'
        '  hasContent: true,\n'
        '  startSelectionPoint: SelectionPoint(\n'
        '    localPosition: Offset(50, 10),\n'
        '    lineHeight: 16.0,\n'
        '    handleType:\n'
        '      TextSelectionHandleType.collapsed,\n'
        '  ),\n'
        '  endSelectionPoint: SelectionPoint(\n'
        '    localPosition: Offset(50, 10),\n'
        '    lineHeight: 16.0,\n'
        '    handleType:\n'
        '      TextSelectionHandleType.collapsed,\n'
        '  ),\n'
        ')',
      ),
      _sgSubtitle('Convenience Constants'),
      _sgNote(
        'SelectionGeometry provides a convenient static constant '
        'for the most common case — no selection and no content:',
      ),
      _sgCodeSnippet(
        'static const SelectionGeometry empty =\n'
        '    SelectionGeometry(\n'
        '      status: SelectionStatus.none,\n'
        '      hasContent: false,\n'
        '    );',
      ),

      // Visual: Geometry state machine
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _sgIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo),
        ),
        child: Column(
          children: [
            const Text(
              'Geometry State Transitions',
              style: TextStyle(
                color: _sgDarkIndigo,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // State: empty
            _sgStateBox('empty', 'No content, no selection', _sgSlate),
            _sgTransitionArrow('hasContent = true'),
            _sgStateBox('none', 'Has content, no selection', _sgPeriwinkle),
            _sgTransitionArrow('Tap → cursor'),
            _sgStateBox('collapsed', 'Cursor at position (one point)', _sgAmber),
            _sgTransitionArrow('Drag → range'),
            _sgStateBox('uncollapsed', 'Range selected (two points)', _sgIndigo),
            _sgTransitionArrow('ClearSelectionEvent'),
            _sgStateBox('none', 'Back to no selection', _sgPeriwinkle),
          ],
        ),
      ),
    ],
  );
}

Widget _sgStateBox(String label, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  color: _sgNavy,
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

Widget _sgTransitionArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_downward, color: _sgSlate, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _sgSlate,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — How SelectableRegion Uses Geometry
// ---------------------------------------------------------------------------
Widget _sgBuildRegionUsage() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '5. How SelectableRegion Uses Geometry',
        subtitle: 'Merging geometry from multiple Selectables',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'When a selection spans multiple Selectables (e.g. across multiple '
        'paragraphs), the SelectableRegion needs to determine:\n\n'
        '• Which Selectable owns the start handle?\n'
        '• Which Selectable owns the end handle?\n'
        '• Are there Selectables in-between that are fully selected?\n\n'
        'It does this by listening to each Selectable\'s geometry.',
        icon: Icons.merge,
      ),

      // Visual: Multi-selectable geometry merging
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Cross-Selectable Geometry',
              style: TextStyle(
                color: _sgDarkIndigo,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),

            // Selectable A — partial selection at end
            _sgSelectableBlock(
              'Selectable A',
              'The quick brown fox',
              'The quick ',
              'brown fox',
              _sgIndigo,
              showStartHandle: true,
              showEndHandle: false,
            ),
            const SizedBox(height: 8),
            // Selectable B — fully selected
            _sgSelectableBlock(
              'Selectable B',
              'jumps over the lazy',
              '',
              'jumps over the lazy',
              _sgAmber,
              showStartHandle: false,
              showEndHandle: false,
              fullySelected: true,
            ),
            const SizedBox(height: 8),
            // Selectable C — partial selection at start
            _sgSelectableBlock(
              'Selectable C',
              'dog and the cat',
              'dog',
              ' and the cat',
              _sgCoral,
              showStartHandle: false,
              showEndHandle: true,
            ),

            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _sgLightPeriwinkle,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Text(
                    'SelectableRegion reads:',
                    style: TextStyle(
                      color: _sgDarkIndigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Start handle → from Selectable A\'s geometry\n'
                    'End handle → from Selectable C\'s geometry\n'
                    'Selectable B → fully selected (both points at edges)',
                    style: TextStyle(
                      color: _sgNavy,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      _sgNote(
        'The SelectableRegion iterates through registered Selectables in '
        'paint order. For each one with hasSelection: true, it checks '
        'the startSelectionPoint and endSelectionPoint to determine which '
        'selectable "owns" each handle.  The first selectable with a start '
        'point gets the start handle, and the last with an end point gets '
        'the end handle.',
        icon: Icons.sort,
      ),
    ],
  );
}

Widget _sgSelectableBlock(
  String label,
  String fullText,
  String beforeSelection,
  String selectedText,
  Color color, {
  bool showStartHandle = false,
  bool showEndHandle = false,
  bool fullySelected = false,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            const Spacer(),
            if (fullySelected)
              _sgTag('fully selected', color)
            else if (showStartHandle)
              _sgTag('has start handle', color)
            else if (showEndHandle)
              _sgTag('has end handle', color),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            if (showStartHandle) _sgMiniHandle(_sgIndigo),
            if (beforeSelection.isNotEmpty)
              Text(
                beforeSelection,
                style: const TextStyle(color: _sgNavy, fontSize: 13),
              ),
            Container(
              color: _sgIndigo.withValues(alpha: 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                selectedText,
                style: const TextStyle(color: _sgNavy, fontSize: 13),
              ),
            ),
            if (showEndHandle) _sgMiniHandle(_sgCoral),
          ],
        ),
      ],
    ),
  );
}

Widget _sgMiniHandle(Color color) {
  return Container(
    width: 8,
    height: 18,
    margin: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Geometry During Drag Gesture
// ---------------------------------------------------------------------------
Widget _sgBuildDragSequence() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '6. Geometry Changes During Drag',
        subtitle: 'How geometry evolves as the user drags to select',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'When the user performs a long-press-drag to select text, the '
        'SelectionGeometry changes in a specific sequence.  Understanding '
        'this sequence is crucial for implementing custom Selectables.',
        icon: Icons.gesture,
      ),

      // Visual: Timeline of geometry changes
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _sgIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo),
        ),
        child: Column(
          children: [
            const Text(
              'Selection Gesture Timeline',
              style: TextStyle(
                color: _sgDarkIndigo,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _sgTimelineStep(
              1,
              'Long Press Start',
              'Status: none → collapsed\n'
                  'Both points = tap position\n'
                  'handleType: collapsed',
              _sgAmber,
              Icons.touch_app,
            ),
            _sgTimelineConnector(),
            _sgTimelineStep(
              2,
              'Word Selected',
              'Status: collapsed → uncollapsed\n'
                  'Start point = word start\n'
                  'End point = word end',
              _sgMint,
              Icons.text_fields,
            ),
            _sgTimelineConnector(),
            _sgTimelineStep(
              3,
              'Drag Begins',
              'SelectionEdgeUpdateEvent dispatched\n'
                  'End point tracks finger\n'
                  'Start point stays',
              _sgIndigo,
              Icons.pan_tool,
            ),
            _sgTimelineConnector(),
            _sgTimelineStep(
              4,
              'Cross Boundary',
              'Geometry for this Selectable: end at edge\n'
                  'Next Selectable starts reporting geometry\n'
                  'pushHandleLayers() transfers handle',
              _sgCoral,
              Icons.exit_to_app,
            ),
            _sgTimelineConnector(),
            _sgTimelineStep(
              5,
              'Lift Finger',
              'Final geometry committed\n'
                  'Toolbar appears (Copy, etc.)\n'
                  'Handles remain draggable',
              _sgDeepPurple,
              Icons.check_circle,
            ),
          ],
        ),
      ),
      _sgNote(
        'At each step, the Selectable creates a new SelectionGeometry '
        'and notifies via its ValueNotifier.  The SelectableRegion '
        'reacts to each notification to update the overlay, handles, '
        'and toolbar.',
        icon: Icons.autorenew,
      ),
    ],
  );
}

Widget _sgTimelineStep(
  int step,
  String title,
  String desc,
  Color color,
  IconData icon,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _sgTag('Step $step', color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(
                color: _sgNavy,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _sgTimelineConnector() {
  return Row(
    children: [
      const SizedBox(width: 17),
      Container(width: 2, height: 12, color: _sgPeriwinkle),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Visual Demo: SelectionArea Showcase
// ---------------------------------------------------------------------------
Widget _sgBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '7. Visual Demo — Selection in Action',
        subtitle: 'Interactive selection areas demonstrating geometry',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'These SelectionAreas demonstrate the geometry system working '
        'end-to-end.  Every Text widget inside registers as a Selectable '
        'and publishes SelectionGeometry through its value property.',
      ),

      // Demo 1: Article-style content
      _sgSubtitle('Article Layout'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _sgIndigo,
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
                  _sgTag('geometry active', _sgMint),
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
                      'Understanding SelectionGeometry',
                      style: TextStyle(
                        color: _sgDarkIndigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'When you select this text, each RenderParagraph creates '
                      'a new SelectionGeometry with the exact handle positions.  '
                      'The startSelectionPoint and endSelectionPoint describe where '
                      'the handles should appear in local coordinates.',
                      style: TextStyle(
                        color: _sgNavy.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _sgAmber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: _sgAmber, width: 3),
                        ),
                      ),
                      child: const Text(
                        'The lineHeight property in each SelectionPoint ensures '
                        'that handles scale appropriately for different text sizes.',
                        style: TextStyle(
                          color: _sgNavy,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'When selection crosses from one paragraph to another, the '
                      'first paragraph reports its end point at the text edge, '
                      'and the next paragraph reports its start point.  The '
                      'SelectableRegion reconciles these into a seamless experience.',
                      style: TextStyle(
                        color: _sgNavy.withValues(alpha: 0.9),
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

      // Demo 2: Mixed sizes
      _sgSubtitle('Different Text Sizes (Different lineHeight)'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgDeepPurple, width: 2),
        ),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Large Title — lineHeight ≈ 28',
                  style: TextStyle(
                    color: _sgDarkIndigo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Medium subtitle — lineHeight ≈ 20',
                  style: TextStyle(
                    color: _sgSlate,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Normal body text — lineHeight ≈ 14.  The handle size adapts '
                  'to the line height at the selection point.',
                  style: TextStyle(
                    color: _sgNavy.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tiny caption — lineHeight ≈ 10',
                  style: TextStyle(
                    color: _sgSlate,
                    fontSize: 10,
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
// Section 8 — hasContent Property
// ---------------------------------------------------------------------------
Widget _sgBuildHasContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '8. The hasContent Property',
        subtitle: 'When a Selectable is empty vs invisible',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'The hasContent field tells the SelectableRegion whether this '
        'Selectable actually has anything to select.  This is different '
        'from the selection status — a Selectable can have content but '
        'no active selection (status: .none, hasContent: true).',
        icon: Icons.content_paste,
      ),

      // Visual: hasContent vs status matrix
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _sgIndigo),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _sgIndigo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'hasContent',
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
                      'status',
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
                      'What It Means',
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
            _sgMatrixRow('false', 'none', 'Empty selectable — no content at all', false),
            _sgMatrixRow('true', 'none', 'Has content, nothing selected yet', true),
            _sgMatrixRow('true', 'collapsed', 'Has content, cursor placed (no range)', false),
            _sgMatrixRow('true', 'uncollapsed', 'Has content, range is selected', true),
          ],
        ),
      ),

      _sgNote(
        'Why it matters: When hasContent is false, the Selectable is skipped '
        'during event dispatch.  The system won\'t try to place a selection '
        'inside an empty container.  This avoids wasted computation and '
        'ensures handles don\'t appear on empty content.',
        icon: Icons.speed,
      ),

      // Visual example: empty vs populated
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                height: 100,
                decoration: BoxDecoration(
                  color: _sgCoral.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sgCoral),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.block, color: _sgCoral, size: 24),
                    const SizedBox(height: 6),
                    const Text(
                      'hasContent: false',
                      style: TextStyle(
                        color: _sgCoral,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Skipped by system',
                      style: TextStyle(color: _sgSlate, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                height: 100,
                decoration: BoxDecoration(
                  color: _sgMint.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _sgMint),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: _sgMint, size: 24),
                    const SizedBox(height: 6),
                    const Text(
                      'hasContent: true',
                      style: TextStyle(
                        color: _sgMint,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Participates in selection',
                      style: TextStyle(color: _sgSlate, fontSize: 10),
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

Widget _sgMatrixRow(String hasContent, String status, String meaning, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _sgLightPeriwinkle.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            hasContent,
            style: TextStyle(
              color: hasContent == 'true' ? _sgMint : _sgCoral,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '.$status',
            style: const TextStyle(
              color: _sgDarkIndigo,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            meaning,
            style: const TextStyle(
              color: _sgNavy,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — pushHandleLayers Connection
// ---------------------------------------------------------------------------
Widget _sgBuildPushHandleLayers() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '9. Geometry → pushHandleLayers()',
        subtitle: 'How geometry drives handle layer placement',
      ),
      const SizedBox(height: 12),
      _sgNote(
        'After reading the geometry, SelectableRegion calls pushHandleLayers() '
        'on the Selectable that owns each handle.  This creates LeaderLayers '
        'in the compositing tree so that the handle overlays (FollowerLayers) '
        'stay positioned at the correct point.',
        icon: Icons.link,
      ),
      _sgCodeSnippet(
        '// SelectableRegion pseudo-code:\n'
        '// 1. Read geometry from each selectable\n'
        '// 2. Find who owns start handle\n'
        'startOwner.pushHandleLayers(\n'
        '  startHandleLayerLink,  // non-null\n'
        '  null,                  // not end\n'
        ');\n'
        '// 3. Find who owns end handle\n'
        'endOwner.pushHandleLayers(\n'
        '  null,                  // not start\n'
        '  endHandleLayerLink,    // non-null\n'
        ');\n'
        '// 4. All others: remove any links\n'
        'others.pushHandleLayers(null, null);',
      ),

      // Visual: Layer linking diagram
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _sgIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sgIndigo),
        ),
        child: Column(
          children: [
            const Text(
              'Handle Overlay Architecture',
              style: TextStyle(
                color: _sgDarkIndigo,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            // Compositing tree
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Render tree
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _sgIndigo.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _sgIndigo.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _sgTag('Render Tree', _sgIndigo),
                        const SizedBox(height: 8),
                        _sgLayerBox('Selectable A', 'LeaderLayer\n(start handle)', _sgMint),
                        const SizedBox(height: 6),
                        _sgLayerBox('Selectable B', '(no layers)', _sgSlate),
                        const SizedBox(height: 6),
                        _sgLayerBox('Selectable C', 'LeaderLayer\n(end handle)', _sgCoral),
                      ],
                    ),
                  ),
                ),
                // Arrow
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      const Icon(Icons.arrow_forward, color: _sgAmber, size: 24),
                      const Text(
                        'LayerLink',
                        style: TextStyle(
                          color: _sgAmber,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Right: Overlay
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _sgAmber.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _sgAmber.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _sgTag('Overlay', _sgAmber),
                        const SizedBox(height: 8),
                        _sgLayerBox('Start Handle', 'FollowerLayer\ntracks start', _sgMint),
                        const SizedBox(height: 6),
                        _sgLayerBox('End Handle', 'FollowerLayer\ntracks end', _sgCoral),
                        const SizedBox(height: 6),
                        _sgLayerBox('Toolbar', 'Positioned\nbetween handles', _sgDeepPurple),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      _sgNote(
        'The key elegance: the LeaderLayer is in the Selectable\'s compositing '
        'subtree, so it automatically transforms with scrolling, layout changes, '
        'and animations.  The FollowerLayer in the overlay just follows — no '
        'manual coordinate math needed.',
        icon: Icons.auto_awesome,
      ),
    ],
  );
}

Widget _sgLayerBox(String title, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _sgNavy,
            fontSize: 9,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Patterns & Best Practices
// ---------------------------------------------------------------------------
Widget _sgBuildBestPractices() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sgSectionHeader(
        '10. Patterns & Best Practices',
        subtitle: 'Working effectively with SelectionGeometry',
      ),
      const SizedBox(height: 12),

      _sgSubtitle('Listening to Geometry Changes'),
      _sgNote(
        'When building custom widgets that react to selection state, listen '
        'to the Selectable\'s value property.  For example, showing '
        'a word count of selected text or highlighting the source paragraph.',
        icon: Icons.hearing,
      ),
      _sgCodeSnippet(
        '// In a custom Selectable implementation:\n'
        'final _geometryNotifier =\n'
        '    ValueNotifier(SelectionGeometry.empty);\n'
        '\n'
        '@override\n'
        'ValueListenable<SelectionGeometry>\n'
        '    get value => _geometryNotifier;\n'
        '\n'
        'void _updateGeometry() {\n'
        '  _geometryNotifier.value =\n'
        '      SelectionGeometry(\n'
        '    status: _computeStatus(),\n'
        '    hasContent: _hasContent,\n'
        '    startSelectionPoint: _startPoint,\n'
        '    endSelectionPoint: _endPoint,\n'
        '  );\n'
        '}',
      ),

      _sgSubtitle('Geometry for Custom Selectables'),
      _sgNote(
        'If implementing a custom Selectable render object:\n\n'
        '1. Always report hasContent truthfully\n'
        '2. Ensure localPosition is in YOUR coordinate space\n'
        '3. Set lineHeight to the visual "unit" at that position\n'
        '4. Use the correct handleType (left for start, right for end)\n'
        '5. Notify listeners synchronously after any change',
        icon: Icons.build,
      ),

      _sgSubtitle('Performance Tips'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _sgSunflower.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _sgSunflower),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: _sgAmber, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Performance Notes',
                  style: TextStyle(
                    color: _sgNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '• Avoid creating new SelectionGeometry on every frame — only '
              'update when the actual selection state changes.\n\n'
              '• The ValueNotifier comparison uses == by default.  '
              'SelectionGeometry implements == based on all fields, so '
              'identical values won\'t trigger unnecessary rebuilds.\n\n'
              '• Keep localPosition computation tight — it runs on every '
              'event during drag gestures, which fire at 60+ Hz.',
              style: TextStyle(
                color: _sgNavy,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),

      _sgSubtitle('Summary'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_sgIndigo, _sgDarkIndigo],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _sgSunflower, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionGeometry — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _sgSummaryItem(
              'Data Class',
              'Immutable snapshot of a Selectable\'s selection state.',
            ),
            _sgSummaryItem(
              'Four Fields',
              'status, hasContent, startSelectionPoint, endSelectionPoint.',
            ),
            _sgSummaryItem(
              'SelectionPoint',
              'localPosition + lineHeight + handleType for each handle.',
            ),
            _sgSummaryItem(
              'Published',
              'Via ValueListenable — SelectableRegion listens and reacts.',
            ),
            _sgSummaryItem(
              'Merged',
              'SelectableRegion combines geometry from multiple selectables.',
            ),
            _sgSummaryItem(
              'Drives Handles',
              'Geometry positions trigger pushHandleLayers + overlay updates.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _sgSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: _sgSunflower,
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
                    color: _sgPeriwinkle,
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
  print('--- SelectionGeometry Deep Demo ---');
  print('Demonstrates the SelectionGeometry data class that every');
  print('Selectable publishes to describe its selection state.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionGeometry?');
  print('  2.  SelectionStatus Enum');
  print('  3.  SelectionPoint — Handle Positioning');
  print('  4.  Creating SelectionGeometry');
  print('  5.  How SelectableRegion Uses Geometry');
  print('  6.  Geometry Changes During Drag');
  print('  7.  Visual Demo — Selection in Action');
  print('  8.  The hasContent Property');
  print('  9.  Geometry → pushHandleLayers()');
  print(' 10.  Patterns & Best Practices');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _sgIndigo,
      scaffoldBackgroundColor: _sgIce,
      appBarTheme: const AppBarTheme(
        backgroundColor: _sgDarkIndigo,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionGeometry — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _sgPeriwinkle.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.data_object, size: 14),
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
            _sgBuildOverview(),
            _sgDivider(),

            _sgBuildStatusEnum(),
            _sgDivider(),

            _sgBuildSelectionPoint(),
            _sgDivider(),

            _sgBuildCreation(),
            _sgDivider(),

            _sgBuildRegionUsage(),
            _sgDivider(),

            _sgBuildDragSequence(),
            _sgDivider(),

            _sgBuildLiveDemo(),
            _sgDivider(),

            _sgBuildHasContent(),
            _sgDivider(),

            _sgBuildPushHandleLayers(),
            _sgDivider(),

            _sgBuildBestPractices(),
          ],
        ),
      ),
    ),
  );
}
