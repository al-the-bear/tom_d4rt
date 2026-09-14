// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION POINT — Deep Demo
// ============================================================================
//
// SelectionPoint is a small, immutable data class that describes the
// exact position and characteristics of a single selection handle.
// It lives inside SelectionGeometry (as startSelectionPoint and
// endSelectionPoint) and carries three pieces of information:
//
//   • localPosition  — Offset in the Selectable's coordinate space
//   • lineHeight     — height of the text line at the handle position
//   • handleType     — TextSelectionHandleType (left, right, collapsed)
//
// The SelectableRegion reads these values and uses them to:
//   1. Position the drag-handle overlays
//   2. Size the handles proportionally to the text
//   3. Choose the correct visual style (left / right / collapsed)
//
// Color theme : Copper (#BF360C) / Peach (#FFCCBC)
// Helper prefix: _sp
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _spCopper = Color(0xFFBF360C);
const Color _spPeach = Color(0xFFFFCCBC);
const Color _spDarkCopper = Color(0xFF870000);
const Color _spLightPeach = Color(0xFFFFF3E0);
const Color _spBurnt = Color(0xFFD84315);
const Color _spCream = Color(0xFFFFF8E1);
const Color _spCharcoal = Color(0xFF212121);
const Color _spTeal = Color(0xFF00897B);
const Color _spBlue = Color(0xFF1565C0);
const Color _spGold = Color(0xFFFFD600);
const Color _spMint = Color(0xFF2E7D32);
const Color _spSlate = Color(0xFF455A64);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _spSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_spCopper, _spDarkCopper],
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

Widget _spNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _spLightPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _spPeach, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _spCopper, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _spCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _spCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _spCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _spPeach,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _spSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _spCopper,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _spDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _spPeach.withValues(alpha: 0.6),
  );
}

Widget _spTag(String label, Color bg, {Color textColor = Colors.white}) {
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
Widget _spBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '1. What Is SelectionPoint?',
        subtitle: 'The exact coordinates for a selection handle',
      ),
      const SizedBox(height: 12),
      _spNote(
        'SelectionPoint is a tiny but critical data class.  It answers '
        'three questions about a selection handle:\n\n'
        '• WHERE is it? → localPosition (Offset)\n'
        '• HOW TALL is the text there? → lineHeight (double)\n'
        '• WHICH DIRECTION does it face? → handleType',
      ),
      _spNote(
        'Each SelectionGeometry contains up to two SelectionPoints — one '
        'for the start handle and one for the end handle.  When the '
        'selection is collapsed (cursor), both points are at the same '
        'position with handleType = collapsed.',
        icon: Icons.place,
      ),

      // Visual: The data class card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _spCopper, width: 2),
          boxShadow: [
            BoxShadow(
              color: _spCopper.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.place, color: _spCopper, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'SelectionPoint',
                  style: TextStyle(
                    color: _spDarkCopper,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                _spTag('immutable', _spCopper),
              ],
            ),
            const SizedBox(height: 14),
            _spFieldRow('localPosition', 'Offset', 'Where the handle tip sits'),
            const SizedBox(height: 4),
            _spFieldRow('lineHeight', 'double', 'Text line height at this point'),
            const SizedBox(height: 4),
            _spFieldRow('handleType', 'TextSelectionHandleType', 'Visual handle style'),
          ],
        ),
      ),

      _spCodeBlock(
        'const SelectionPoint({\n'
        '  required this.localPosition,\n'
        '  required this.lineHeight,\n'
        '  required this.handleType,\n'
        '});',
      ),
    ],
  );
}

Widget _spFieldRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: _spCopper,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(
            name,
            style: const TextStyle(
              color: _spDarkCopper,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            type,
            style: const TextStyle(
              color: _spSlate,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _spCharcoal,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — localPosition
// ---------------------------------------------------------------------------
Widget _spBuildLocalPosition() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '2. localPosition — Where The Handle Goes',
        subtitle: 'An Offset in the Selectable\'s local coordinate space',
      ),
      const SizedBox(height: 12),
      _spNote(
        'The localPosition is an Offset relative to the Selectable\'s '
        'own coordinate system (i.e., the render object\'s local coords, '
        'where (0,0) is the top-left corner of the render object).  '
        'The SelectableRegion converts this to global coords using '
        'localToGlobal() to position the handle overlay.',
      ),

      // Visual: coordinate space demo
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Coordinate Space Visualization',
              style: TextStyle(
                color: _spDarkCopper,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            // Simulated text block with coordinate markers
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: _spLightPeach,
                border: Border.all(color: _spCopper),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  // Origin marker
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      color: _spCopper,
                      child: const Text(
                        '(0,0)',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                  // Text content
                  const Positioned(
                    left: 10,
                    top: 15,
                    child: Text(
                      'The quick brown fox jumps',
                      style: TextStyle(color: _spCharcoal, fontSize: 14),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    top: 40,
                    child: Text(
                      'over the lazy dog today',
                      style: TextStyle(color: _spCharcoal, fontSize: 14),
                    ),
                  ),
                  // Start handle marker at "brown"
                  Positioned(
                    left: 93,
                    top: 12,
                    child: Column(
                      children: [
                        Container(
                          width: 2,
                          height: 18,
                          color: _spBlue,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: _spBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // End handle marker at "dog"
                  Positioned(
                    left: 163,
                    top: 37,
                    child: Column(
                      children: [
                        Container(
                          width: 2,
                          height: 18,
                          color: _spBurnt,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: _spBurnt,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Selection highlight line 1
                  Positioned(
                    left: 93,
                    top: 15,
                    child: Container(
                      width: 172,
                      height: 18,
                      color: _spCopper.withValues(alpha: 0.15),
                    ),
                  ),
                  // Selection highlight line 2
                  Positioned(
                    left: 10,
                    top: 40,
                    child: Container(
                      width: 153,
                      height: 18,
                      color: _spCopper.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _spBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Start: (93, 30)  ',
                  style: TextStyle(color: _spBlue, fontSize: 11, fontFamily: 'monospace'),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _spBurnt,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'End: (163, 55)',
                  style: TextStyle(color: _spBurnt, fontSize: 11, fontFamily: 'monospace'),
                ),
              ],
            ),
          ],
        ),
      ),

      _spNote(
        'The localPosition is typically at the bottom of the text baseline '
        '(or the end of the character), so the handle visual extends '
        'downward from that point.  The exact position depends on the '
        'TextPainter\'s getOffsetForCaret or similar methods.',
        icon: Icons.vertical_align_bottom,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — lineHeight
// ---------------------------------------------------------------------------
Widget _spBuildLineHeight() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '3. lineHeight — Scaling Handles to Text',
        subtitle: 'Making handles proportional to the content',
      ),
      const SizedBox(height: 12),
      _spNote(
        'The lineHeight property tells the handle overlay how tall the '
        'text line is at the handle position.  This ensures handles '
        'scale visually with different text sizes — a headline gets '
        'a taller handle than a caption.',
      ),

      // Visual: Different text sizes with proportional handles
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Handle Height Scales with lineHeight',
              style: TextStyle(
                color: _spDarkCopper,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            _spLineHeightDemo('Headline', 28.0, 24),
            const SizedBox(height: 14),
            _spLineHeightDemo('Subtitle', 20.0, 18),
            const SizedBox(height: 14),
            _spLineHeightDemo('Body text', 16.0, 14),
            const SizedBox(height: 14),
            _spLineHeightDemo('Caption', 12.0, 11),
          ],
        ),
      ),

      _spNote(
        'When a selection spans text of different sizes (e.g. a heading '
        'and body text), the start handle and end handle can have '
        'different lineHeights.  The handle visuals adapt independently.',
        icon: Icons.height,
      ),

      // Visual: Cross-size selection
      _spSubtitle('Cross-Size Selection'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper, width: 2),
        ),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Large Title (lineHeight ≈ 28)',
                  style: TextStyle(
                    color: _spDarkCopper,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Normal body text (lineHeight ≈ 16).  When you select '
                  'from the title into this paragraph, the start handle '
                  'is taller than the end handle.',
                  style: TextStyle(
                    color: _spCharcoal.withValues(alpha: 0.9),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tiny footer (lineHeight ≈ 10)',
                  style: TextStyle(
                    color: _spSlate,
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

Widget _spLineHeightDemo(String label, double lineHeight, double fontSize) {
  return Row(
    children: [
      // Handle visualization
      Column(
        children: [
          Container(
            width: 3,
            height: lineHeight,
            color: _spCopper,
          ),
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: _spCopper,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      const SizedBox(width: 14),
      // Text sample
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _spLightPeach,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: _spCharcoal,
                  fontSize: fontSize,
                ),
              ),
              const Spacer(),
              _spTag('lineHeight: ${lineHeight.toInt()}', _spCopper),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — handleType
// ---------------------------------------------------------------------------
Widget _spBuildHandleType() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '4. handleType — Visual Handle Style',
        subtitle: 'TextSelectionHandleType: left, right, collapsed',
      ),
      const SizedBox(height: 12),
      _spNote(
        'The handleType determines the visual appearance of the selection '
        'handle.  There are exactly three types, and each communicates '
        'a different semantic meaning to the user.',
      ),

      // Visual: Three handle types side by side
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _spHandleTypeCard(
                'left',
                'Start of a text range selection.\nHandle extends to the left.',
                Icons.arrow_back,
                _spBlue,
                true,
                false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _spHandleTypeCard(
                'right',
                'End of a text range selection.\nHandle extends to the right.',
                Icons.arrow_forward,
                _spBurnt,
                false,
                false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _spHandleTypeCard(
                'collapsed',
                'Cursor position (no range).\nSingle centered handle.',
                Icons.drag_indicator,
                _spGold,
                false,
                true,
              ),
            ),
          ],
        ),
      ),

      _spCodeBlock(
        'enum TextSelectionHandleType {\n'
        '  left,      // start handle (LTR)\n'
        '  right,     // end handle (LTR)\n'
        '  collapsed, // cursor (0-width)\n'
        '}\n'
        '\n'
        '// The naming follows LTR convention:\n'
        '// "left" means the handle that is on\n'
        '// the left side of the selection.\n'
        '// In RTL text, it\'s still the START.',
      ),

      _spNote(
        'On iOS, collapsed handles appear as a small circle at the cursor '
        'position.  On Android, it\'s a teardrop.  The handleType tells '
        'the MaterialSelectionControls or CupertinoSelectionControls '
        'widget which visual to paint.',
        icon: Icons.phone_android,
      ),

      // Visual: Handle placement in context
      _spSubtitle('Handles in Context'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _spCream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper),
        ),
        child: Column(
          children: [
            // Range selection example
            const Text(
              'Range Selection — Two Handles',
              style: TextStyle(
                color: _spDarkCopper,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left handle
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: _spBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    Container(width: 2, height: 18, color: _spBlue),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: _spCopper.withValues(alpha: 0.2),
                  child: const Text(
                    'selected text here',
                    style: TextStyle(color: _spCharcoal, fontSize: 14),
                  ),
                ),
                // Right handle
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: _spBurnt,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    Container(width: 2, height: 18, color: _spBurnt),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _spTag('.left', _spBlue),
                const SizedBox(width: 60),
                _spTag('.right', _spBurnt),
              ],
            ),
            const SizedBox(height: 20),
            // Collapsed selection example
            const Text(
              'Collapsed Cursor — One Handle',
              style: TextStyle(
                color: _spDarkCopper,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'some te',
                  style: TextStyle(color: _spCharcoal, fontSize: 14),
                ),
                Column(
                  children: [
                    Container(width: 2, height: 18, color: _spGold),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: _spGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'xt here',
                  style: TextStyle(color: _spCharcoal, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _spTag('.collapsed', _spGold),
          ],
        ),
      ),
    ],
  );
}

Widget _spHandleTypeCard(
  String name,
  String desc,
  IconData icon,
  Color color,
  bool isLeft,
  bool isCollapsed,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        // Handle visualization
        if (isCollapsed)
          Column(
            children: [
              Container(width: 2, height: 22, color: color),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          )
        else
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: isLeft ? const Radius.circular(14) : Radius.zero,
                    topRight: !isLeft ? const Radius.circular(14) : Radius.zero,
                    bottomLeft: const Radius.circular(14),
                    bottomRight: const Radius.circular(14),
                  ),
                ),
              ),
              Container(width: 2, height: 24, color: color),
            ],
          ),
        const SizedBox(height: 10),
        Text(
          '.$name',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _spCharcoal,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — How SelectionPoint Is Consumed
// ---------------------------------------------------------------------------
Widget _spBuildConsumption() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '5. How SelectionPoint Is Used',
        subtitle: 'The journey from data class to visible handle',
      ),
      const SizedBox(height: 12),
      _spNote(
        'SelectionPoint doesn\'t do anything by itself — it\'s pure data.  '
        'Here\'s how the system consumes it:',
        icon: Icons.route,
      ),

      // Visual: Pipeline
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _spCream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper),
        ),
        child: Column(
          children: [
            _spPipelineStep(
              1,
              'Selectable creates SelectionPoint',
              'After processing a selection event, the render object '
              'computes the handle position and creates a SelectionPoint.',
              _spCopper,
            ),
            _spPipelineArrow(),
            _spPipelineStep(
              2,
              'Wrapped in SelectionGeometry',
              'The SelectionPoint is placed as startSelectionPoint '
              'or endSelectionPoint in the geometry.',
              _spBurnt,
            ),
            _spPipelineArrow(),
            _spPipelineStep(
              3,
              'Geometry published via ValueNotifier',
              'The Selectable\'s value property notifies listeners '
              'that the geometry has changed.',
              _spTeal,
            ),
            _spPipelineArrow(),
            _spPipelineStep(
              4,
              'SelectableRegion reads the point',
              'Extracts localPosition and converts to global coords.  '
              'Uses lineHeight to size the handle overlay.',
              _spBlue,
            ),
            _spPipelineArrow(),
            _spPipelineStep(
              5,
              'Handle overlay positioned',
              'A FollowerLayer tracks the LeaderLayer placed at '
              'localPosition.  The handle widget renders using handleType.',
              _spMint,
            ),
          ],
        ),
      ),
      _spCodeBlock(
        '// In SelectableRegion (simplified):\n'
        'final point = selectable.value\n'
        '    .endSelectionPoint;\n'
        'if (point != null) {\n'
        '  final global = selectable\n'
        '      .localToGlobal(point.localPosition);\n'
        '  _endHandle.updatePosition(global);\n'
        '  _endHandle.lineHeight =\n'
        '      point.lineHeight;\n'
        '  _endHandle.type = point.handleType;\n'
        '}',
      ),
    ],
  );
}

Widget _spPipelineStep(int num, String title, String desc, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$num',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
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
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              style: const TextStyle(
                color: _spCharcoal,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _spPipelineArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 13, top: 2, bottom: 2),
    child: Icon(Icons.arrow_downward, color: _spPeach, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Visual: Multi-Line Selection Points
// ---------------------------------------------------------------------------
Widget _spBuildMultiLineDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '6. Multi-Line Selection Points',
        subtitle: 'How points change as selection grows',
      ),
      const SizedBox(height: 12),
      _spNote(
        'As a selection grows, the startSelectionPoint stays at the '
        'beginning of the selection while the endSelectionPoint '
        'moves forward.  Here is a visual simulation of a selection '
        'expanding line by line.',
      ),

      // Visual: 3-state comparison
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _spSelectionStateCard(
              'State 1: Single word selected',
              'The quick [brown] fox jumps over\nthe lazy dog in the meadow.',
              'Offset(85, 28)',
              'Offset(135, 28)',
              _spCopper,
            ),
            const SizedBox(height: 10),
            _spSelectionStateCard(
              'State 2: Selection extends to end of line',
              'The quick [brown fox jumps over]\nthe lazy dog in the meadow.',
              'Offset(85, 28)',
              'Offset(285, 28)',
              _spBurnt,
            ),
            const SizedBox(height: 10),
            _spSelectionStateCard(
              'State 3: Selection crosses to second line',
              'The quick [brown fox jumps over\nthe lazy dog] in the meadow.',
              'Offset(85, 28)',
              'Offset(120, 48)',
              _spTeal,
            ),
          ],
        ),
      ),

      _spNote(
        'Notice: when the end handle crosses to the next line, the '
        'endSelectionPoint\'s Y coordinate jumps but the X shifts back '
        'to the beginning of the next line.  The handleType stays .right '
        'for the end handle throughout.',
        icon: Icons.insights,
      ),
    ],
  );
}

Widget _spSelectionStateCard(
  String title,
  String content,
  String startOffset,
  String endOffset,
  Color color,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _spPeach),
          ),
          child: Text(
            content,
            style: const TextStyle(
              color: _spCharcoal,
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _spTag('start: $startOffset', _spBlue),
            const SizedBox(width: 8),
            _spTag('end: $endOffset', color),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — RTL and BiDi Considerations
// ---------------------------------------------------------------------------
Widget _spBuildRtlConsiderations() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '7. RTL & Bidirectional Text',
        subtitle: 'How handleType changes for different text directions',
      ),
      const SizedBox(height: 12),
      _spNote(
        'In RTL (right-to-left) text, the "start" of the selection is on '
        'the right and the "end" is on the left.  However, the handleType '
        'names remain the same — .left always means the handle on the '
        'left side of the screen, and .right means the right side.  '
        'The mapping between start/end and left/right flips with text direction.',
        icon: Icons.swap_horiz,
      ),

      // Visual: LTR vs RTL comparison
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper),
        ),
        child: Column(
          children: [
            // LTR example
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _spBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _spBlue.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _spTag('LTR', _spBlue),
                      const SizedBox(width: 8),
                      const Text(
                        'English: left-to-right',
                        style: TextStyle(color: _spBlue, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '.left',
                            style: TextStyle(color: _spBlue, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const Text('= start', style: TextStyle(color: _spSlate, fontSize: 9)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: _spBlue.withValues(alpha: 0.15),
                        child: const Text(
                          'Hello World',
                          style: TextStyle(color: _spCharcoal, fontSize: 14),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            '.right',
                            style: TextStyle(color: _spBurnt, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const Text('= end', style: TextStyle(color: _spSlate, fontSize: 9)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // RTL example
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _spTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _spTeal.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _spTag('RTL', _spTeal),
                      const SizedBox(width: 8),
                      const Text(
                        'Arabic/Hebrew: right-to-left',
                        style: TextStyle(color: _spTeal, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '.left',
                            style: TextStyle(color: _spBlue, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const Text('= end', style: TextStyle(color: _spSlate, fontSize: 9)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: _spTeal.withValues(alpha: 0.15),
                        child: const Text(
                          'مرحبا بالعالم',
                          style: TextStyle(color: _spCharcoal, fontSize: 14),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            '.right',
                            style: TextStyle(color: _spBurnt, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const Text('= start', style: TextStyle(color: _spSlate, fontSize: 9)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      _spNote(
        'This is why the handleType is crucial — it tells the handle '
        'widget which visual direction to face, independent of which '
        'end of the selection (start or end) it represents.',
        icon: Icons.directions,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Live Selection Demo
// ---------------------------------------------------------------------------
Widget _spBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '8. Live Selection Demo',
        subtitle: 'See SelectionPoint in action across different content',
      ),
      const SizedBox(height: 12),
      _spNote(
        'Each selectable Text widget in these areas publishes '
        'SelectionPoints through its geometry.  Try selecting across '
        'different text sizes and styles.',
      ),

      // Demo: Rich content
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spCopper, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _spCopper,
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
                    'Rich Content Selection',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _spTag('multiple lineHeights', _spPeach, textColor: _spDarkCopper),
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
                      'Chapter One',
                      style: TextStyle(
                        color: _spDarkCopper,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A Journey Through SelectionPoints',
                      style: TextStyle(
                        color: _spCopper.withValues(alpha: 0.7),
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Every character position in this text maps to a potential '
                      'SelectionPoint.  The localPosition is computed from the '
                      'TextPainter\'s layout, and the lineHeight comes from the '
                      'font metrics at that character.',
                      style: TextStyle(
                        color: _spCharcoal.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _spLightPeach,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Note: When the selection crosses from the large heading '
                        'into this smaller body text, the end handle shrinks to '
                        'match the new lineHeight.  This is SelectionPoint at work.',
                        style: TextStyle(
                          color: _spCharcoal,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '— Attribution in tiny text',
                      style: TextStyle(
                        color: _spSlate,
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
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Summary
// ---------------------------------------------------------------------------
Widget _spBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSectionHeader(
        '9. Summary & Key Takeaways',
        subtitle: 'SelectionPoint in a nutshell',
      ),
      const SizedBox(height: 12),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_spCopper, _spDarkCopper],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _spGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionPoint — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _spSummaryItem('Three Fields', 'localPosition, lineHeight, handleType.'),
            _spSummaryItem('localPosition', 'Offset in the Selectable\'s local coords.'),
            _spSummaryItem('lineHeight', 'Scales handle height to text size.'),
            _spSummaryItem('handleType', 'left, right, or collapsed visual style.'),
            _spSummaryItem('Consumed by', 'SelectableRegion → handle overlay.'),
            _spSummaryItem('RTL Aware', 'handleType is about screen position, not text direction.'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _spSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(color: _spGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$title — ',
                style: const TextStyle(
                  color: _spPeach,
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
            ]),
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
  print('--- SelectionPoint Deep Demo ---');
  print('Demonstrates the SelectionPoint data class that describes');
  print('where drag handles should be positioned.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionPoint?');
  print('  2.  localPosition — Where The Handle Goes');
  print('  3.  lineHeight — Scaling Handles to Text');
  print('  4.  handleType — Visual Handle Style');
  print('  5.  How SelectionPoint Is Used');
  print('  6.  Multi-Line Selection Points');
  print('  7.  RTL & Bidirectional Text');
  print('  8.  Live Selection Demo');
  print('  9.  Summary & Key Takeaways');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _spCopper,
      scaffoldBackgroundColor: _spCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _spDarkCopper,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionPoint — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _spPeach.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.place, size: 14),
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
            _spBuildOverview(),
            _spDivider(),
            _spBuildLocalPosition(),
            _spDivider(),
            _spBuildLineHeight(),
            _spDivider(),
            _spBuildHandleType(),
            _spDivider(),
            _spBuildConsumption(),
            _spDivider(),
            _spBuildMultiLineDemo(),
            _spDivider(),
            _spBuildRtlConsiderations(),
            _spDivider(),
            _spBuildLiveDemo(),
            _spDivider(),
            _spBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
