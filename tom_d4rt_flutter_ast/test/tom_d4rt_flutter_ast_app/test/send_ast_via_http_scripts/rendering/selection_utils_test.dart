// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION UTILS — Deep Demo
// ============================================================================
//
// SelectionUtils is a utility class containing static helper methods that
// the Flutter selection framework uses internally.  These methods handle
// the low-level geometry calculations that make text selection work
// smoothly:
//
//   • getResultBasedOnRect(Rect, Offset) → SelectionResult
//       Given a bounding rect and a drag point, determines whether the
//       point falls inside, before, or after the rect — returning the
//       appropriate SelectionResult (end, next, previous).
//
//   • adjustDragOffset(Rect, Offset, TextDirection) → Offset
//       Adjusts a raw drag position so that it maps correctly to the
//       nearest text position within a selectable, accounting for
//       text direction (LTR vs RTL).
//
//   • getBoundingBox(List<Rect>) → Rect
//       Merges multiple inline selection boxes into a single bounding
//       rectangle — used to compute toolbar placement.
//
// These utilities are the invisible glue between user gestures and the
// selection system.  Understanding them clarifies why selections behave
// the way they do — especially near boundaries and when crossing between
// different Selectable objects.
//
// Color theme : Navy (#0D47A1) / Sky (#90CAF9)
// Helper prefix: _su
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _suNavy = Color(0xFF0D47A1);
const Color _suSky = Color(0xFF90CAF9);
const Color _suDarkNavy = Color(0xFF0A1929);
const Color _suLightSky = Color(0xFFE3F2FD);
const Color _suAzure = Color(0xFF1565C0);
const Color _suIce = Color(0xFFF5F8FC);
const Color _suSteel = Color(0xFF455A64);
const Color _suAmber = Color(0xFFFFC107);
const Color _suCoral = Color(0xFFEF5350);
const Color _suMint = Color(0xFF4CAF50);
const Color _suViolet = Color(0xFF7B1FA2);
const Color _suGold = Color(0xFFFFD740);

// ---------------------------------------------------------------------------
// Reusable helpers — unique to this demo
// ---------------------------------------------------------------------------

Widget _suSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_suNavy, _suDarkNavy],
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

Widget _suNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _suLightSky,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _suSky, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _suNavy, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _suDarkNavy,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _suCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _suDarkNavy,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _suSky,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _suSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _suNavy,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _suDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _suSky.withValues(alpha: 0.4),
  );
}

Widget _suTag(String label, Color bg, {Color textColor = Colors.white}) {
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
Widget _suBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '1. What Is SelectionUtils?',
        subtitle: 'Static utility methods for selection geometry',
      ),
      const SizedBox(height: 12),
      _suNote(
        'SelectionUtils is an abstract final class — you never instantiate '
        'it.  It serves as a namespace for static methods that perform '
        'the low-level geometry calculations the selection system depends '
        'on.  Without these utilities, the framework would not know how '
        'to map a finger drag to the correct text position.',
      ),
      _suNote(
        'Three main utilities:\n\n'
        '• getResultBasedOnRect — maps a drag point relative to a rect '
        'to a SelectionResult\n'
        '• adjustDragOffset — corrects raw drag positions for text direction\n'
        '• getBoundingBox — merges multiple selection rects into one',
        icon: Icons.build_circle,
      ),

      // Visual: The three utilities as cards
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _suUtilCard(
                'getResult\nBasedOnRect',
                Icons.crop_free,
                'Point → Result',
                _suNavy,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _suUtilCard(
                'adjustDrag\nOffset',
                Icons.touch_app,
                'Raw → Corrected',
                _suAzure,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _suUtilCard(
                'getBounding\nBox',
                Icons.crop_landscape,
                'Many → One Rect',
                _suViolet,
              ),
            ),
          ],
        ),
      ),

      _suCodeBlock(
        'abstract final class SelectionUtils {\n'
        '  static SelectionResult\n'
        '      getResultBasedOnRect(\n'
        '    Rect rect, Offset point) { ... }\n'
        '\n'
        '  static Offset adjustDragOffset(\n'
        '    Rect rect, Offset point,\n'
        '    TextDirection direction) { ... }\n'
        '\n'
        '  static Rect getBoundingBox(\n'
        '    List<Rect> boxes) { ... }\n'
        '}',
      ),
    ],
  );
}

Widget _suUtilCard(String title, IconData icon, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _suSteel,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — getResultBasedOnRect
// ---------------------------------------------------------------------------
Widget _suBuildGetResult() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '2. getResultBasedOnRect()',
        subtitle: 'Mapping a point\'s position relative to a rect to a SelectionResult',
      ),
      const SizedBox(height: 12),
      _suNote(
        'When a Selectable receives a SelectionEdgeUpdateEvent, it needs to '
        'determine whether the drag point falls inside its bounds, above/before, '
        'or below/after.  getResultBasedOnRect() does exactly that — it takes '
        'the selectable\'s bounding rect and the event\'s globalPosition, then '
        'returns one of the SelectionResult values.',
      ),

      _suSubtitle('SelectionResult Outcomes'),
      _suCodeBlock(
        'SelectionResult getResultBasedOnRect(\n'
        '  Rect rect, Offset point\n'
        ') {\n'
        '  if (rect.contains(point))\n'
        '    → SelectionResult.end\n'
        '  if (point.dy < rect.top)\n'
        '    → SelectionResult.previous\n'
        '  if (point.dy > rect.bottom)\n'
        '    → SelectionResult.next\n'
        '  // Same vertical band:\n'
        '  if (point.dx < rect.left)\n'
        '    → SelectionResult.previous\n'
        '  → SelectionResult.next\n'
        '}',
      ),

      // Visual: Coordinate grid showing point positions
      _suSubtitle('Visual: Point Positions and Results'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _suNavy, width: 2),
          boxShadow: [
            BoxShadow(
              color: _suNavy.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Region Map — getResultBasedOnRect',
              style: TextStyle(
                color: _suDarkNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),

            // Grid layout showing regions
            SizedBox(
              height: 220,
              child: Column(
                children: [
                  // Top row: "previous" zone
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _suAmber.withValues(alpha: 0.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border.all(
                        color: _suAmber.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_upward,
                              color: _suAmber, size: 16),
                          const SizedBox(width: 6),
                          const Text(
                            'previous',
                            style: TextStyle(
                              color: _suAmber,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _suTag('dy < rect.top', _suAmber),
                        ],
                      ),
                    ),
                  ),
                  // Middle row: left=previous, center=end, right=next
                  Expanded(
                    child: Row(
                      children: [
                        // Left: previous
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: _suCoral.withValues(alpha: 0.1),
                            border: Border.all(
                              color: _suCoral.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back,
                                    color: _suCoral, size: 14),
                                Text(
                                  'previous',
                                  style: TextStyle(
                                    color: _suCoral,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  'dx < left',
                                  style: TextStyle(
                                    color: _suCoral,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Center: end (inside rect)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _suMint.withValues(alpha: 0.15),
                              border: Border.all(color: _suMint, width: 2),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle,
                                      color: _suMint, size: 28),
                                  SizedBox(height: 4),
                                  Text(
                                    'end',
                                    style: TextStyle(
                                      color: _suMint,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'rect.contains(point)',
                                    style: TextStyle(
                                      color: _suMint,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Right: next
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: _suViolet.withValues(alpha: 0.1),
                            border: Border.all(
                              color: _suViolet.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_forward,
                                    color: _suViolet, size: 14),
                                Text(
                                  'next',
                                  style: TextStyle(
                                    color: _suViolet,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  'dx > right',
                                  style: TextStyle(
                                    color: _suViolet,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bottom row: "next" zone
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _suNavy.withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      border: Border.all(
                        color: _suNavy.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_downward,
                              color: _suNavy, size: 16),
                          const SizedBox(width: 6),
                          const Text(
                            'next',
                            style: TextStyle(
                              color: _suNavy,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _suTag('dy > rect.bottom', _suNavy),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The rect represents a Selectable\'s bounding box.\n'
              'The point is the drag position from the gesture.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _suSteel,
                fontSize: 11,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
      _suNote(
        'Why "end"?  When the point is inside the rect, this selectable '
        'claims the selection — the search ends here.  "previous" and "next" '
        'mean the system should look at earlier or later selectables in '
        'paint order.',
        icon: Icons.lightbulb_outline,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — SelectionResult Enum
// ---------------------------------------------------------------------------
Widget _suBuildSelectionResult() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '3. SelectionResult Enum',
        subtitle: 'The four possible outcomes of dispatch',
      ),
      const SizedBox(height: 12),
      _suNote(
        'When a SelectionHandler dispatches a selection event, it returns '
        'a SelectionResult to tell the system what happened.  The system '
        'uses this to decide whether to continue searching for the right '
        'selectable or stop.',
      ),

      // Four result cards
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _suResultCard(
                    'end',
                    'Selection handled — stop here.  The point is inside '
                        'this selectable\'s bounds.',
                    _suMint,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _suResultCard(
                    'next',
                    'Point is after this selectable.  Try the next one '
                        'in paint order.',
                    _suViolet,
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _suResultCard(
                    'previous',
                    'Point is before this selectable.  Try an earlier one '
                        'in paint order.',
                    _suCoral,
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _suResultCard(
                    'pending',
                    'Cannot determine yet — sub-selectables need to be '
                        'consulted first.',
                    _suAmber,
                    Icons.hourglass_empty,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      _suCodeBlock(
        'enum SelectionResult {\n'
        '  end,       // claimed — search stops\n'
        '  next,      // look forward\n'
        '  previous,  // look backward\n'
        '  pending,   // sub-dispatch needed\n'
        '}',
      ),

      _suNote(
        'getResultBasedOnRect() only returns end, next, or previous — never '
        'pending.  The pending value is used by composite selectables that '
        'need to dispatch events to their children before knowing the result.',
        icon: Icons.warning_amber,
      ),
    ],
  );
}

Widget _suResultCard(
    String label, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(
              '.$label',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          desc,
          style: const TextStyle(
            color: _suDarkNavy,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — adjustDragOffset
// ---------------------------------------------------------------------------
Widget _suBuildAdjustDrag() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '4. adjustDragOffset()',
        subtitle: 'Correcting raw drag positions for accurate text mapping',
      ),
      const SizedBox(height: 12),
      _suNote(
        'When a user drags to select text, their finger often overshoots '
        'the actual text bounds.  adjustDragOffset() clamps the drag '
        'position to the selectable\'s rect so that it maps to a real '
        'text position.  It also accounts for TextDirection — in RTL '
        'text, the "start" is on the right side.',
      ),
      _suCodeBlock(
        'static Offset adjustDragOffset(\n'
        '  Rect rect,\n'
        '  Offset point,\n'
        '  TextDirection direction,\n'
        ') {\n'
        '  // Vertical clamping:\n'
        '  //   - above rect → clamp to top edge\n'
        '  //   - below rect → clamp to bottom edge\n'
        '  //\n'
        '  // Horizontal clamping:\n'
        '  //   - depends on TextDirection\n'
        '  //   - LTR: left = start, right = end\n'
        '  //   - RTL: right = start, left = end\n'
        '  return clamped;\n'
        '}',
      ),

      // Visual: drag offset correction
      _suSubtitle('Visual: Drag Offset Correction'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _suIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _suNavy),
        ),
        child: Column(
          children: [
            const Text(
              'How adjustDragOffset() Works',
              style: TextStyle(
                color: _suDarkNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),

            // Mock text area with drag positions
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  // The text rect
                  Positioned(
                    left: 40,
                    top: 40,
                    right: 40,
                    bottom: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _suSky.withValues(alpha: 0.2),
                        border: Border.all(color: _suNavy, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Selectable text area',
                          style: TextStyle(
                            color: _suDarkNavy,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Raw drag position (outside)
                  Positioned(
                    left: 10,
                    top: 12,
                    child: Column(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: _suCoral,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'raw',
                          style: TextStyle(
                            color: _suCoral,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow from raw to corrected
                  Positioned(
                    left: 24,
                    top: 18,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 2,
                          color: _suAmber,
                        ),
                        const Icon(Icons.arrow_forward,
                            color: _suAmber, size: 12),
                      ],
                    ),
                  ),
                  // Corrected position (on rect edge)
                  Positioned(
                    left: 40,
                    top: 38,
                    child: Column(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: _suMint,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'adjusted',
                          style: TextStyle(
                            color: _suMint,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Another raw → adjusted pair on bottom-right
                  Positioned(
                    right: 8,
                    bottom: 10,
                    child: Column(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: _suCoral,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'raw',
                          style: TextStyle(
                            color: _suCoral,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 40,
                    bottom: 38,
                    child: Column(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: _suMint,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'adjusted',
                          style: TextStyle(
                            color: _suMint,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _suCoral,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Raw finger position  ',
                    style: TextStyle(fontSize: 10, color: _suSteel)),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _suMint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Adjusted position',
                    style: TextStyle(fontSize: 10, color: _suSteel)),
              ],
            ),
          ],
        ),
      ),

      // LTR vs RTL comparison
      _suSubtitle('TextDirection Matters'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _suNavy.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _suNavy.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    _suTag('LTR', _suNavy),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('start',
                            style: TextStyle(
                                color: _suMint,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward,
                            color: _suSteel, size: 14),
                        const SizedBox(width: 4),
                        const Text('end',
                            style: TextStyle(
                                color: _suCoral,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _suMint.withValues(alpha: 0.3),
                            _suCoral.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Hello World →',
                          style: TextStyle(
                              color: _suDarkNavy, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _suViolet.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: _suViolet.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    _suTag('RTL', _suViolet),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('end',
                            style: TextStyle(
                                color: _suCoral,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_back,
                            color: _suSteel, size: 14),
                        const SizedBox(width: 4),
                        const Text('start',
                            style: TextStyle(
                                color: _suMint,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _suCoral.withValues(alpha: 0.3),
                            _suMint.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          '← مرحبا بالعالم',
                          style: TextStyle(
                              color: _suDarkNavy, fontSize: 11),
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
      const SizedBox(height: 12),
      _suNote(
        'In LTR text, overshooting to the left means "before the start" and '
        'the offset clamps to the left edge.  In RTL text, the same leftward '
        'overshoot means "past the end" — the offset clamps differently.  '
        'adjustDragOffset handles this transparently.',
        icon: Icons.swap_horiz,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5 — getBoundingBox
// ---------------------------------------------------------------------------
Widget _suBuildGetBoundingBox() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '5. getBoundingBox()',
        subtitle: 'Merging multiple selection rects into one bounding box',
      ),
      const SizedBox(height: 12),
      _suNote(
        'Selected text often spans multiple lines.  Each line produces its '
        'own selection rect (an "inline box").  getBoundingBox() takes a list '
        'of these rects and returns a single Rect that encloses all of them — '
        'used to position the selection toolbar.',
      ),

      // Visual: Multiple line rects → one bounding rect
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _suAzure, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Multi-Line Selection Bounding',
              style: TextStyle(
                color: _suDarkNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),

            // Before: multiple rects
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input: individual rects
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _suIce,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _suSky),
                    ),
                    child: Column(
                      children: [
                        _suTag('Input: List<Rect>', _suAzure),
                        const SizedBox(height: 10),
                        // Line 1 selection
                        Row(
                          children: [
                            const SizedBox(width: 30),
                            Expanded(
                              child: Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _suNavy.withValues(alpha: 0.2),
                                  border: Border.all(
                                      color: _suNavy.withValues(alpha: 0.5)),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Center(
                                  child: Text('line 1 box',
                                      style: TextStyle(
                                          fontSize: 9, color: _suNavy)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Line 2 selection
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _suNavy.withValues(alpha: 0.2),
                                  border: Border.all(
                                      color: _suNavy.withValues(alpha: 0.5)),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Center(
                                  child: Text('line 2 box',
                                      style: TextStyle(
                                          fontSize: 9, color: _suNavy)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Line 3 selection
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _suNavy.withValues(alpha: 0.2),
                                  border: Border.all(
                                      color: _suNavy.withValues(alpha: 0.5)),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Center(
                                  child: Text('line 3 box',
                                      style: TextStyle(
                                          fontSize: 9, color: _suNavy)),
                                ),
                              ),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Arrow
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Icon(Icons.arrow_forward,
                      color: _suAmber, size: 28),
                ),
                // Output: single bounding rect
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _suIce,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _suSky),
                    ),
                    child: Column(
                      children: [
                        _suTag('Output: Rect', _suMint),
                        const SizedBox(height: 10),
                        Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: _suMint.withValues(alpha: 0.15),
                            border: Border.all(color: _suMint, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('bounding box',
                                    style: TextStyle(
                                      color: _suMint,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    )),
                                Text('enclosing all lines',
                                    style: TextStyle(
                                      color: _suSteel,
                                      fontSize: 9,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _suLightSky,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'The toolbar sits centered above the bounding box.\n'
                'Without merging, the system wouldn\'t know where to place it.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _suDarkNavy,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),

      _suCodeBlock(
        'static Rect getBoundingBox(\n'
        '  List<Rect> boxes,\n'
        ') {\n'
        '  // Returns Rect that encompasses all boxes:\n'
        '  //   left   = min(all lefts)\n'
        '  //   top    = min(all tops)\n'
        '  //   right  = max(all rights)\n'
        '  //   bottom = max(all bottoms)\n'
        '}',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Dispatch Flow: How Utils Fit In
// ---------------------------------------------------------------------------
Widget _suBuildDispatchFlow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '6. How Utils Fit in the Selection Pipeline',
        subtitle: 'From user gesture to final selection',
      ),
      const SizedBox(height: 12),
      _suNote(
        'These utility methods are called at specific points in the selection '
        'pipeline.  Understanding the flow clarifies when each utility fires.',
        icon: Icons.account_tree,
      ),

      // Visual: Pipeline diagram
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _suIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _suNavy),
        ),
        child: Column(
          children: [
            const Text(
              'Selection Pipeline',
              style: TextStyle(
                color: _suDarkNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),

            _suPipelineStep(
              1,
              'User Gesture',
              'Long press or drag detected by GestureDetector',
              _suSteel,
              Icons.touch_app,
              null,
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              2,
              'SelectableRegion',
              'Creates SelectionEdgeUpdateEvent with globalPosition',
              _suAzure,
              Icons.api,
              null,
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              3,
              'dispatchSelectionEvent()',
              'Each Selectable receives the event in paint order',
              _suNavy,
              Icons.send,
              null,
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              4,
              'getResultBasedOnRect()',
              'Selectable checks if point is inside its bounds',
              _suMint,
              Icons.crop_free,
              'SelectionUtils',
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              5,
              'adjustDragOffset()',
              'The claiming Selectable clamps the point to its text',
              _suAmber,
              Icons.straighten,
              'SelectionUtils',
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              6,
              'Update Geometry',
              'Selectable publishes new SelectionGeometry',
              _suViolet,
              Icons.data_object,
              null,
            ),
            _suPipelineArrow(),
            _suPipelineStep(
              7,
              'getBoundingBox()',
              'SelectableRegion computes toolbar position',
              _suCoral,
              Icons.crop_landscape,
              'SelectionUtils',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _suPipelineStep(
  int step,
  String title,
  String desc,
  Color color,
  IconData icon,
  String? utilLabel,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$step. $title',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                if (utilLabel != null) ...[
                  const SizedBox(width: 6),
                  _suTag(utilLabel, color),
                ],
              ],
            ),
            Text(
              desc,
              style: const TextStyle(
                color: _suDarkNavy,
                fontSize: 11,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _suPipelineArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
    child: Icon(Icons.arrow_downward, color: _suSteel, size: 14),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Visual Demo: Selection Areas
// ---------------------------------------------------------------------------
Widget _suBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '7. Visual Demo — Selection Utils in Action',
        subtitle: 'SelectionAreas demonstrating the utility methods',
      ),
      const SizedBox(height: 12),
      _suNote(
        'These interactive selection areas show the utility methods working '
        'behind the scenes.  When you select text, getResultBasedOnRect() '
        'routes the event; adjustDragOffset() clamps the drag; '
        'getBoundingBox() positions the toolbar.',
      ),

      // Demo 1: Multi-paragraph article
      _suSubtitle('Multi-Paragraph Selection'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _suNavy, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _suNavy,
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
                    'Cross-Paragraph Selection',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _suTag('getResultBasedOnRect', _suMint),
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
                      'The Role of SelectionUtils',
                      style: TextStyle(
                        color: _suDarkNavy,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'When you drag across these paragraphs, each RenderParagraph '
                      'calls getResultBasedOnRect() to check if the drag point falls '
                      'inside its bounds.  The first paragraph that returns '
                      'SelectionResult.end claims the selection edge.',
                      style: TextStyle(
                        color: _suDarkNavy.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Meanwhile, adjustDragOffset() is working behind the scenes '
                      'to ensure that even if your finger drifts outside the text '
                      'bounds, the selection still maps to a valid text character.  '
                      'This is why selection feels forgiving on mobile.',
                      style: TextStyle(
                        color: _suDarkNavy.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _suAmber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: _suAmber, width: 3),
                        ),
                      ),
                      child: const Text(
                        'Notice: when selection spans multiple paragraphs, '
                        'getBoundingBox() computes the enclosing rect for all '
                        'selected lines to position the floating toolbar.',
                        style: TextStyle(
                          color: _suDarkNavy,
                          fontSize: 13,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
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

      // Demo 2: Varied text sizes
      _suSubtitle('Varied Text Sizes — adjustDragOffset'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _suAzure, width: 2),
        ),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Large Title Text',
                  style: TextStyle(
                    color: _suDarkNavy,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Subtitle text — medium size.',
                  style: TextStyle(
                    color: _suSteel,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Normal body text.  adjustDragOffset() works regardless of '
                  'text size — it always clamps to the selectable\'s rect.',
                  style: TextStyle(
                    color: _suDarkNavy.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tiny caption — the offset correction scales with the bounding rect.',
                  style: TextStyle(
                    color: _suSteel,
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
// Section 8 — Edge Cases
// ---------------------------------------------------------------------------
Widget _suBuildEdgeCases() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '8. Edge Cases and Boundary Conditions',
        subtitle: 'How the utilities handle tricky situations',
      ),
      const SizedBox(height: 12),

      // Table of edge cases
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _suNavy),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _suNavy,
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
                      'Scenario',
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
                      'Method',
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
                      'Behavior',
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
            _suEdgeRow(
              'Point exactly on rect edge',
              'getResult...',
              'Returns .end (edges are inclusive)',
              false,
            ),
            _suEdgeRow(
              'Point on rect corner',
              'getResult...',
              'Returns .end (corner is inside)',
              true,
            ),
            _suEdgeRow(
              'Empty rect (zero size)',
              'getResult...',
              'Returns .next (nothing to select)',
              false,
            ),
            _suEdgeRow(
              'Single-line selection',
              'getBounding...',
              'Returns that line\'s rect unchanged',
              true,
            ),
            _suEdgeRow(
              'Point diagonal to rect',
              'getResult...',
              'Vertical check first; if same band, horizontal',
              false,
            ),
            _suEdgeRow(
              'Drag far outside rect',
              'adjustDrag...',
              'Clamps to nearest rect edge',
              true,
            ),
            _suEdgeRow(
              'Mixed RTL/LTR text',
              'adjustDrag...',
              'Uses TextDirection from the Selectable',
              false,
            ),
          ],
        ),
      ),

      _suNote(
        'The vertical-first check order in getResultBasedOnRect() is '
        'important: it means a point that is both above and to the right '
        'of the rect returns "previous" (based on vertical position), '
        'not "next" (based on horizontal).  This matches the natural '
        'reading flow: above means earlier content.',
        icon: Icons.priority_high,
      ),

      // Visual: Priority of checks
      _suSubtitle('Check Priority in getResultBasedOnRect'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _suIce,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _suSky),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _suCheckPriority(1, 'contains(point)', 'Inside → end', _suMint),
            _suCheckPriority(2, 'dy < rect.top', 'Above → previous', _suAmber),
            _suCheckPriority(3, 'dy > rect.bottom', 'Below → next', _suViolet),
            _suCheckPriority(
                4, 'dx < rect.left', 'Left (same band) → previous', _suCoral),
            _suCheckPriority(
                5, 'else', 'Right (same band) → next', _suNavy),
          ],
        ),
      ),
    ],
  );
}

Widget _suEdgeRow(
    String scenario, String method, String behavior, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _suLightSky.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            scenario,
            style: const TextStyle(
              color: _suDarkNavy,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            method,
            style: const TextStyle(
              color: _suAzure,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            behavior,
            style: const TextStyle(
              color: _suSteel,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _suCheckPriority(
    int order, String check, String result, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$order',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 130,
          child: Text(
            check,
            style: const TextStyle(
              color: _suDarkNavy,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Text(
          result,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Practical Integration Examples
// ---------------------------------------------------------------------------
Widget _suBuildIntegration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '9. Integration — Where Utils Are Called',
        subtitle: 'Concrete call sites in the Flutter framework',
      ),
      const SizedBox(height: 12),
      _suNote(
        'These utility methods are used in several key places within the '
        'Flutter framework.  Knowing the call sites helps debug selection '
        'issues — if selection doesn\'t work correctly, one of these '
        'call sites is likely the root cause.',
        icon: Icons.location_on,
      ),

      // Call site cards
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _suCallSiteCard(
              'RenderParagraph.dispatchSelectionEvent()',
              'Calls getResultBasedOnRect to check if the event\'s '
                  'global position falls within this paragraph\'s bounds.  '
                  'If it does, calls adjustDragOffset to get the precise '
                  'text offset.',
              _suNavy,
              Icons.text_fields,
            ),
            const SizedBox(height: 8),
            _suCallSiteCard(
              'SelectableRegion._updateSelectionToolbar()',
              'Gathers selection rects from the active selectable '
                  'and calls getBoundingBox to determine where to '
                  'position the floating context menu (Copy, etc.).',
              _suAzure,
              Icons.content_copy,
            ),
            const SizedBox(height: 8),
            _suCallSiteCard(
              'MultiSelectableSelectionContainerDelegate',
              'Uses getResultBasedOnRect to route selection events '
                  'to the correct child selectable when iterating '
                  'through its children list.',
              _suViolet,
              Icons.view_list,
            ),
            const SizedBox(height: 8),
            _suCallSiteCard(
              'ScrollableSelectionContainerDelegate',
              'Extends the above delegate, using adjustDragOffset '
                  'to account for scroll position when the selection '
                  'extends beyond the visible viewport.',
              _suMint,
              Icons.swap_vert,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _suCallSiteCard(
    String title, String desc, Color color, IconData icon) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: _suDarkNavy,
                  fontSize: 11,
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
// Section 10 — Summary
// ---------------------------------------------------------------------------
Widget _suBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _suSectionHeader(
        '10. Summary & Key Takeaways',
        subtitle: 'The invisible plumbing of text selection',
      ),
      const SizedBox(height: 12),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_suNavy, _suDarkNavy],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _suGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionUtils — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _suSummaryBullet(
              'Static Utility Class',
              'Abstract final — never instantiated, just a namespace for '
                  'static helpers.',
            ),
            _suSummaryBullet(
              'getResultBasedOnRect',
              'Maps a point\'s position relative to a rect to end, next, or '
                  'previous.  Vertical check takes priority over horizontal.',
            ),
            _suSummaryBullet(
              'adjustDragOffset',
              'Clamps over-shot drag positions to the selectable\'s rect.  '
                  'Respects TextDirection for LTR/RTL text.',
            ),
            _suSummaryBullet(
              'getBoundingBox',
              'Merges multiple inline selection rects into a single bounding '
                  'rect for toolbar positioning.',
            ),
            _suSummaryBullet(
              'Pipeline Integration',
              'Called by RenderParagraph, SelectableRegion, and the multi-'
                  'selectable delegates during event dispatch.',
            ),
            _suSummaryBullet(
              'Invisible Glue',
              'You rarely call these directly.  They work behind the scenes '
                  'to make text selection feel smooth and forgiving.',
            ),
          ],
        ),
      ),

      // Final note
      _suNote(
        'SelectionUtils demonstrates a common Flutter pattern: low-level '
        'geometry utilities encapsulated in a static class, keeping the '
        'main classes (SelectableRegion, RenderParagraph) clean and focused '
        'on their primary responsibilities.',
        icon: Icons.auto_awesome,
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _suSummaryBullet(String title, String desc) {
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
            color: _suGold,
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
                    color: _suSky,
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
  print('--- SelectionUtils Deep Demo ---');
  print('Demonstrates the static utility methods in SelectionUtils');
  print('that power the Flutter selection system\'s geometry calculations.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionUtils?');
  print('  2.  getResultBasedOnRect()');
  print('  3.  SelectionResult Enum');
  print('  4.  adjustDragOffset()');
  print('  5.  getBoundingBox()');
  print('  6.  How Utils Fit in the Selection Pipeline');
  print('  7.  Visual Demo — Selection Utils in Action');
  print('  8.  Edge Cases and Boundary Conditions');
  print('  9.  Integration — Where Utils Are Called');
  print(' 10.  Summary & Key Takeaways');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _suNavy,
      scaffoldBackgroundColor: _suIce,
      appBarTheme: const AppBarTheme(
        backgroundColor: _suDarkNavy,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionUtils — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _suSky.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.build, size: 14),
                SizedBox(width: 4),
                Text(
                  'Utility',
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
            _suBuildOverview(),
            _suDivider(),

            _suBuildGetResult(),
            _suDivider(),

            _suBuildSelectionResult(),
            _suDivider(),

            _suBuildAdjustDrag(),
            _suDivider(),

            _suBuildGetBoundingBox(),
            _suDivider(),

            _suBuildDispatchFlow(),
            _suDivider(),

            _suBuildLiveDemo(),
            _suDivider(),

            _suBuildEdgeCases(),
            _suDivider(),

            _suBuildIntegration(),
            _suDivider(),

            _suBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
