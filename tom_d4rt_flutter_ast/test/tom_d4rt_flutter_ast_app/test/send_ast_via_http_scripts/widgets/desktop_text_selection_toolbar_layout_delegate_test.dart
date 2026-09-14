// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: DesktopTextSelectionToolbarLayoutDelegate
//
// DesktopTextSelectionToolbarLayoutDelegate is a SingleChildLayoutDelegate
// used to position the desktop text-selection toolbar. It determines where
// the floating Cut / Copy / Paste toolbar appears relative to the text
// selection anchor point, ensuring it stays on-screen.
//
// This demo visualises:
//   1. How SingleChildLayoutDelegate works and its contract
//   2. Anchor-based positioning relative to selection handles
//   3. On-screen clamping and overflow prevention
//   4. Toolbar sizing constraints from getConstraintsForChild
//   5. Offset calculation logic in getPositionForChild
//   6. Comparison of desktop vs mobile toolbar placement strategies
//   7. Toolbar content layout (button arrangement)
//   8. Edge-case handling (short lines, near-screen-edge selections)
//   9. Integration with SelectionOverlay and TextSelectionControls
//
// All visualisations are built with standard Flutter widgets—no actual
// desktop platform calls are required.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Pink / Rose
// ---------------------------------------------------------------------------
const Color _tlPrimary = Color(0xFFC2185B);
const Color _tlPrimaryLight = Color(0xFFE91E63);
const Color _tlAccent = Color(0xFFFF80AB);
const Color _tlAccentDark = Color(0xFFAD1457);
const Color _tlSurface = Color(0xFFFCE4EC);
const Color _tlSurfaceDark = Color(0xFFF8BBD0);
const Color _tlOnPrimary = Color(0xFFFFFFFF);
const Color _tlTextDark = Color(0xFF880E4F);
const Color _tlTextMedium = Color(0xFFAD1457);
const Color _tlDivider = Color(0xFFF48FB1);
const Color _tlBlue = Color(0xFF1565C0);
const Color _tlGreen = Color(0xFF2E7D32);
const Color _tlOrange = Color(0xFFE65100);
const Color _tlGrey = Color(0xFF757575);

// ---------------------------------------------------------------------------
// Helper: section title bar
// ---------------------------------------------------------------------------
Widget _tlSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _tlPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _tlTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _tlDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge chip
// ---------------------------------------------------------------------------
Widget _tlBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _tlInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _tlPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _tlSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _tlTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _tlTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: simulated toolbar widget
// ---------------------------------------------------------------------------
Widget _tlToolbarButton(String label, IconData icon, {bool enabled = true}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Color(0xFFEEEEEE),
      border: Border.all(color: enabled ? _tlDivider : Color(0xFFE0E0E0)),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: enabled ? _tlPrimary : _tlGrey),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: enabled ? _tlTextDark : _tlGrey, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: code-style text
// ---------------------------------------------------------------------------
Widget _tlCode(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: _tlSurfaceDark,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _tlPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: SingleChildLayoutDelegate Overview
// ---------------------------------------------------------------------------
Widget _tlSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _tlSectionTitle('1 · SingleChildLayoutDelegate Overview', Icons.architecture),
      _tlInfoCard(
        'What is a SingleChildLayoutDelegate?',
        'An abstract class that defines how a SingleChildLayoutDelegate positions '
            'and sizes its single child. Subclasses override getSize(), '
            'getConstraintsForChild(), getPositionForChild(), and '
            'shouldRelayout() to control layout behaviour.',
        Icons.straighten,
      ),
      _tlInfoCard(
        'DesktopTextSelectionToolbarLayoutDelegate',
        'This specific delegate positions the desktop text-selection toolbar '
            'relative to a given anchor point (typically the selection start). '
            'It ensures the toolbar fits within the screen bounds and adjusts '
            'its offset to avoid overflow.',
        Icons.text_fields,
        accent: _tlAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delegate contract', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                _tlCode('getSize()'),
                SizedBox(width: 8),
                Expanded(child: Text('Full overlay area', style: TextStyle(fontSize: 11, color: _tlTextMedium))),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                _tlCode('getConstraintsForChild()'),
                SizedBox(width: 8),
                Expanded(child: Text('Loose constraints for toolbar', style: TextStyle(fontSize: 11, color: _tlTextMedium))),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                _tlCode('getPositionForChild()'),
                SizedBox(width: 8),
                Expanded(child: Text('Clamped anchor offset', style: TextStyle(fontSize: 11, color: _tlTextMedium))),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                _tlCode('shouldRelayout()'),
                SizedBox(width: 8),
                Expanded(child: Text('Checks anchor change', style: TextStyle(fontSize: 11, color: _tlTextMedium))),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Anchor-Based Positioning
// ---------------------------------------------------------------------------
Widget _tlSection2Anchoring() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('2 · Anchor-Based Positioning', Icons.my_location),
      _tlInfoCard(
        'Selection anchor point',
        'The toolbar is positioned relative to an anchor Offset provided by '
            'the text editing system. This offset typically points to the top-left '
            'of the selection, just above the first selected line.',
        Icons.gps_fixed,
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Stack(
          children: [
            // Simulated text lines
            Positioned(
              left: 16, top: 40,
              child: Text('The quick brown fox jumps over', style: TextStyle(fontSize: 13, color: _tlGrey)),
            ),
            Positioned(
              left: 16, top: 58,
              child: Row(
                children: [
                  Text('the ', style: TextStyle(fontSize: 13, color: _tlGrey)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    color: _tlAccent.withValues(alpha: 0.4),
                    child: Text('lazy dog and the cat', style: TextStyle(fontSize: 13, color: _tlTextDark)),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16, top: 76,
              child: Text('sat on the mat yesterday.', style: TextStyle(fontSize: 13, color: _tlGrey)),
            ),
            // Anchor point indicator
            Positioned(
              left: 46, top: 42,
              child: Column(
                children: [
                  Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: _tlPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: _tlOnPrimary, width: 2),
                    ),
                  ),
                  Container(width: 1, height: 20, color: _tlPrimary),
                ],
              ),
            ),
            // Toolbar positioned above the anchor
            Positioned(
              left: 30, top: 8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  border: Border.all(color: _tlDivider),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _tlToolbarButton('Cut', Icons.content_cut),
                    SizedBox(width: 2),
                    _tlToolbarButton('Copy', Icons.content_copy),
                    SizedBox(width: 2),
                    _tlToolbarButton('Paste', Icons.content_paste),
                  ],
                ),
              ),
            ),
            // Label
            Positioned(
              right: 12, top: 8,
              child: _tlBadge('anchor', _tlPrimary, _tlOnPrimary),
            ),
            // Info
            Positioned(
              left: 16, bottom: 12,
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: _tlTextMedium),
                  SizedBox(width: 4),
                  Text('Toolbar floats above the selection anchor', style: TextStyle(fontSize: 10, color: _tlTextMedium, fontStyle: FontStyle.italic)),
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
// Section 3: On-Screen Clamping
// ---------------------------------------------------------------------------
Widget _tlSection3Clamping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('3 · On-Screen Clamping', Icons.fit_screen),
      _tlInfoCard(
        'Overflow prevention',
        'getPositionForChild() clamps the toolbar offset so it never extends '
            'beyond the overlay boundaries. If the anchor is near the left edge, '
            'the toolbar shifts right; near the right edge it shifts left; near '
            'the top it may appear below the selection instead.',
        Icons.border_outer,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          children: [
            Text('Clamping scenarios', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 10),
            // Left edge
            _tlClampRow('Left edge', 'Toolbar shifts rightward', Icons.arrow_forward, _tlBlue),
            SizedBox(height: 6),
            // Right edge
            _tlClampRow('Right edge', 'Toolbar shifts leftward', Icons.arrow_back, _tlPrimary),
            SizedBox(height: 6),
            // Top edge
            _tlClampRow('Top edge', 'Toolbar appears below', Icons.arrow_downward, _tlGreen),
            SizedBox(height: 6),
            // Normal
            _tlClampRow('Normal', 'Toolbar above anchor', Icons.arrow_upward, _tlOrange),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _tlSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clamping formula', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 6),
            _tlCode('x = clamp(anchor.dx, 0, overlay.width - toolbar.width)'),
            SizedBox(height: 4),
            _tlCode('y = clamp(anchor.dy - toolbar.height, 0, overlay.height)'),
            SizedBox(height: 6),
            Text(
              'The x-offset is clamped between 0 and the maximum position that '
              'keeps the toolbar fully visible. The y-offset places it above the '
              'anchor, falling back to below when space is insufficient.',
              style: TextStyle(fontSize: 11, color: _tlTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _tlClampRow(String scenario, String behaviour, IconData arrow, Color color) {
  return Row(
    children: [
      Container(
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
        child: Text(scenario, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
      ),
      SizedBox(width: 8),
      Icon(arrow, size: 16, color: color),
      SizedBox(width: 8),
      Expanded(child: Text(behaviour, style: TextStyle(fontSize: 11, color: _tlTextMedium))),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Toolbar Sizing Constraints
// ---------------------------------------------------------------------------
Widget _tlSection4Constraints() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('4 · Toolbar Sizing Constraints', Icons.straighten),
      _tlInfoCard(
        'getConstraintsForChild()',
        'Returns BoxConstraints.loose(size) — the toolbar can be any size up to '
            'the full overlay dimensions. This allows the toolbar to measure its '
            'preferred size based on its content (buttons), then the delegate '
            'positions the result.',
        Icons.aspect_ratio,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constraint flow', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _tlSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _tlPrimary.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Parent constraints', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _tlPrimary)),
                        SizedBox(height: 4),
                        Text('max: 400 × 800', style: TextStyle(fontSize: 11, color: _tlTextDark)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 18, color: _tlTextMedium),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _tlSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _tlAccentDark.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Child constraints', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _tlAccentDark)),
                        SizedBox(height: 4),
                        Text('0–400 × 0–800', style: TextStyle(fontSize: 11, color: _tlTextDark)),
                        Text('(loose)', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 18, color: _tlTextMedium),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _tlSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _tlGreen.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Toolbar size', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _tlGreen)),
                        SizedBox(height: 4),
                        Text('220 × 36', style: TextStyle(fontSize: 11, color: _tlTextDark)),
                        Text('(intrinsic)', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: getPositionForChild Logic
// ---------------------------------------------------------------------------
Widget _tlSection5Position() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('5 · getPositionForChild() Logic', Icons.pin_drop),
      _tlInfoCard(
        'Position calculation',
        'The delegate computes the toolbar offset as: x = anchor.dx clamped '
            'within [padding, overlay.width - toolbar.width - padding]. '
            'y = anchor.dy - toolbar.height - verticalOffset, clamped to keep '
            'the toolbar on screen.',
        Icons.calculate,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step-by-step', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 8),
            _tlStepRow(1, 'Receive anchor offset from selection', _tlPrimary),
            _tlStepRow(2, 'Subtract toolbar height + gap', _tlAccentDark),
            _tlStepRow(3, 'Clamp x to [0, overlay.width - toolbar.width]', _tlBlue),
            _tlStepRow(4, 'Clamp y to [0, overlay.height - toolbar.height]', _tlGreen),
            _tlStepRow(5, 'Return Offset(clampedX, clampedY)', _tlOrange),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        height: 160,
        decoration: BoxDecoration(
          color: _tlSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Stack(
          children: [
            // Overlay area label
            Positioned(left: 8, top: 8, child: Text('Overlay area', style: TextStyle(fontSize: 10, color: _tlGrey))),
            // Anchor
            Positioned(
              left: 140, top: 90,
              child: Container(
                width: 10, height: 10,
                decoration: BoxDecoration(color: _tlPrimary, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              left: 126, top: 104,
              child: Text('anchor', style: TextStyle(fontSize: 9, color: _tlPrimary, fontWeight: FontWeight.w600)),
            ),
            // Dashed line up
            Positioned(
              left: 144, top: 50,
              child: Container(width: 1, height: 40, color: _tlPrimary.withValues(alpha: 0.4)),
            ),
            // Toolbar
            Positioned(
              left: 80, top: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
                  border: Border.all(color: _tlPrimary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.content_cut, size: 12, color: _tlPrimary),
                    SizedBox(width: 8),
                    Icon(Icons.content_copy, size: 12, color: _tlPrimary),
                    SizedBox(width: 8),
                    Icon(Icons.content_paste, size: 12, color: _tlPrimary),
                    SizedBox(width: 8),
                    Icon(Icons.select_all, size: 12, color: _tlPrimary),
                  ],
                ),
              ),
            ),
            // Dimension arrows
            Positioned(
              right: 12, top: 20,
              child: Column(
                children: [
                  _tlBadge('y = anchor.dy - h - gap', _tlAccentDark, _tlOnPrimary),
                  SizedBox(height: 40),
                  _tlBadge('x = clamp(anchor.dx)', _tlBlue, _tlOnPrimary),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _tlStepRow(int step, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22, height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text('$step', style: TextStyle(fontSize: 10, color: _tlOnPrimary, fontWeight: FontWeight.w700)),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(desc, style: TextStyle(fontSize: 11, color: _tlTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: Desktop vs Mobile Toolbar Placement
// ---------------------------------------------------------------------------
Widget _tlSection6Comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('6 · Desktop vs Mobile Placement', Icons.devices),
      _tlInfoCard(
        'Platform differences',
        'Desktop toolbars appear as compact buttons near the selection. Mobile '
            'toolbars use a bubble or popover above the selection with larger touch '
            'targets. Different layout delegates handle each strategy.',
        Icons.compare,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tlSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _tlPrimary.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.desktop_windows, size: 24, color: _tlPrimary),
                    SizedBox(height: 6),
                    Text('Desktop', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _tlTextDark)),
                    SizedBox(height: 6),
                    Text('• Compact buttons', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Right-click context', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Mouse-sized targets', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Anchored to cursor', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tlSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _tlBlue.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.phone_android, size: 24, color: _tlBlue),
                    SizedBox(height: 6),
                    Text('Mobile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _tlTextDark)),
                    SizedBox(height: 6),
                    Text('• Bubble popup', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Long-press trigger', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Large touch targets', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
                    Text('• Above selection', style: TextStyle(fontSize: 10, color: _tlTextMedium)),
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
// Section 7: Toolbar Content Layout
// ---------------------------------------------------------------------------
Widget _tlSection7Content() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('7 · Toolbar Content Layout', Icons.view_column),
      _tlInfoCard(
        'Button arrangement',
        'The toolbar child typically consists of a Row of TextSelectionToolbarButton '
            'widgets. Each button has an icon and label. The delegate does not '
            'control the internal layout—only the toolbar\'s position and size '
            'constraints.',
        Icons.table_rows,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Standard toolbar buttons', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _tlToolbarButton('Cut', Icons.content_cut),
                _tlToolbarButton('Copy', Icons.content_copy),
                _tlToolbarButton('Paste', Icons.content_paste),
                _tlToolbarButton('Select All', Icons.select_all),
              ],
            ),
            SizedBox(height: 12),
            Text('Contextual buttons', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _tlToolbarButton('Look Up', Icons.search),
                _tlToolbarButton('Share...', Icons.share),
                _tlToolbarButton('Translate', Icons.translate),
                _tlToolbarButton('Custom', Icons.extension, enabled: false),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: _tlTextMedium),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Disabled buttons show when the action is unavailable (e.g. nothing to paste)',
                    style: TextStyle(fontSize: 10, color: _tlTextMedium, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Edge Cases
// ---------------------------------------------------------------------------
Widget _tlSection8EdgeCases() {
  final cases = <Map<String, dynamic>>[
    {'title': 'Near top edge', 'desc': 'Toolbar flips below the selection', 'icon': Icons.vertical_align_top, 'color': _tlPrimary},
    {'title': 'Near right edge', 'desc': 'Toolbar left-aligns to selection end', 'icon': Icons.align_horizontal_right, 'color': _tlBlue},
    {'title': 'Very short line', 'desc': 'Toolbar centres above available text', 'icon': Icons.short_text, 'color': _tlGreen},
    {'title': 'Multi-line selection', 'desc': 'Anchored to the first line\'s midpoint', 'icon': Icons.format_line_spacing, 'color': _tlOrange},
    {'title': 'Empty selection', 'desc': 'Toolbar appears at cursor caret position', 'icon': Icons.text_rotation_none, 'color': _tlAccentDark},
    {'title': 'RTL text', 'desc': 'Anchor adjusts to start of RTL selection', 'icon': Icons.format_textdirection_r_to_l, 'color': Color(0xFF6A1B9A)},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('8 · Edge Cases', Icons.warning_amber),
      _tlInfoCard(
        'Boundary handling',
        'The delegate handles numerous edge cases to ensure the toolbar remains '
            'accessible. Screen rotation, keyboard appearance, and overlapping '
            'UI elements can all affect the available space.',
        Icons.border_style,
      ),
      ...cases.map((c) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: c['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(c['icon'] as IconData, size: 18, color: c['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
                  SizedBox(height: 2),
                  Text(c['desc'] as String, style: TextStyle(fontSize: 11, color: _tlTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Integration with SelectionOverlay
// ---------------------------------------------------------------------------
Widget _tlSection9Integration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tlSectionTitle('9 · Integration with SelectionOverlay', Icons.layers),
      _tlInfoCard(
        'SelectionOverlay binding',
        'TextSelectionOverlay creates a CustomSingleChildLayout with this '
            'delegate. The overlay provides the anchor, and TextSelectionControls '
            'supplies the toolbar builder. The delegate is recreated when the '
            'anchor position changes.',
        Icons.link,
      ),
      _tlInfoCard(
        'shouldRelayout()',
        'Returns true when the anchor offset differs from the previous delegate. '
            'This triggers a re-layout pass that repositions the toolbar smoothly '
            'as the user adjusts the selection handles.',
        Icons.refresh,
        accent: _tlAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlDivider),
        ),
        child: Column(
          children: [
            Text('Component chain', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tlTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _tlBadge('EditableText', _tlPrimary, _tlOnPrimary)),
                Icon(Icons.arrow_forward, size: 14, color: _tlTextMedium),
                Expanded(child: _tlBadge('SelectionOverlay', _tlAccentDark, _tlOnPrimary)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _tlBadge('CustomSingleChildLayout', _tlBlue, _tlOnPrimary)),
                Icon(Icons.arrow_forward, size: 14, color: _tlTextMedium),
                Expanded(child: _tlBadge('ToolbarLayoutDelegate', _tlGreen, _tlOnPrimary)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_downward, size: 14, color: _tlTextMedium),
              ],
            ),
            SizedBox(height: 4),
            _tlBadge('Positioned Toolbar', _tlOrange, _tlOnPrimary),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_tlPrimary.withValues(alpha: 0.08), _tlAccent.withValues(alpha: 0.1)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tlPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.text_fields, size: 32, color: _tlPrimary),
            SizedBox(height: 8),
            Text(
              'DesktopTextSelectionToolbarLayoutDelegate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _tlTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Precisely positions the desktop selection toolbar via anchor-based '
              'calculation with on-screen clamping, integrating seamlessly with '
              'Flutter\'s text editing overlay system.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _tlTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_tlPrimary, _tlPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.text_fields, color: _tlOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'DesktopTextSelectionToolbar\nLayoutDelegate',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _tlOnPrimary,
                        letterSpacing: 0.3,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Anchor-based toolbar positioning with on-screen clamping',
                style: TextStyle(fontSize: 12, color: _tlOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _tlSection1Overview(),
        _tlSection2Anchoring(),
        _tlSection3Clamping(),
        _tlSection4Constraints(),
        _tlSection5Position(),
        _tlSection6Comparison(),
        _tlSection7Content(),
        _tlSection8EdgeCases(),
        _tlSection9Integration(),

        SizedBox(height: 24),
      ],
    ),
  );
}
