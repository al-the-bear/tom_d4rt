// ignore_for_file: avoid_print
// Deep demo: TextSelectionHandleType
// Demonstrates the TextSelectionHandleType enum — the three shapes
// of draggable text selection handles: left, right, and collapsed.
import 'package:flutter/material.dart';

// ─── palette: Brown / Warm Tan ────────────────────────────────────
const Color _shBrown = Color(0xFF4E342E);
const Color _shTan = Color(0xFFEFEBE9);
const Color _shAccent = Color(0xFF8D6E63);
const Color _shDark = Color(0xFF212121);
const Color _shGood = Color(0xFF2E7D32);
const Color _shBlue = Color(0xFF1565C0);
const Color _shPurple = Color(0xFF6A1B9A);
const Color _shRed = Color(0xFFC62828);
const Color _shTeal = Color(0xFF00796B);

// ─── text helpers ─────────────────────────────────────────────────
Widget _shTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _shBrown,
              letterSpacing: 0.3)),
    );

Widget _shSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _shAccent)),
    );

Widget _shBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _shCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _shDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFBCAAA4),
              height: 1.5)),
    );

Widget _shNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _shTan,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _shBrown.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _shBrown),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _shBrown, height: 1.4)),
          ),
        ],
      ),
    );

Widget _shDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _shBrown.withValues(alpha: 0.12)),
    );

Widget _shBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _shAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _shTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _shLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _shBrown,
        letterSpacing: 0.2));

Widget _shSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── handle visual builders ───────────────────────────────────────

/// A mock text selection handle pointing left (teardrop leans left).
Widget _shHandleLeft(Color c, {double size = 24}) => SizedBox(
      width: size,
      height: size * 1.4,
      child: CustomPaint(painter: _ShHandlePainter(c, _ShHandleDir.left)),
    );

/// A mock text selection handle pointing right (teardrop leans right).
Widget _shHandleRight(Color c, {double size = 24}) => SizedBox(
      width: size,
      height: size * 1.4,
      child: CustomPaint(painter: _ShHandlePainter(c, _ShHandleDir.right)),
    );

/// A mock collapsed handle (vertical line with circle).
Widget _shHandleCollapsed(Color c, {double size = 24}) => SizedBox(
      width: size,
      height: size * 1.4,
      child: CustomPaint(painter: _ShHandlePainter(c, _ShHandleDir.collapsed)),
    );

enum _ShHandleDir { left, right, collapsed }

class _ShHandlePainter extends CustomPainter {
  final Color color;
  final _ShHandleDir dir;
  const _ShHandlePainter(this.color, this.dir);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final r = size.width / 2;

    switch (dir) {
      case _ShHandleDir.left:
        // Circle at bottom-left, stem goes up-right
        canvas.drawCircle(Offset(r, size.height - r), r, paint);
        canvas.drawRect(
            Rect.fromLTWH(r - 2, 0, 4, size.height - r), paint);
      case _ShHandleDir.right:
        // Circle at bottom-right, stem goes up-left
        canvas.drawCircle(Offset(r, size.height - r), r, paint);
        canvas.drawRect(
            Rect.fromLTWH(r - 2, 0, 4, size.height - r), paint);
      case _ShHandleDir.collapsed:
        // Circle at bottom center, thin stem up
        canvas.drawCircle(Offset(r, size.height - r), r * 0.7, paint);
        canvas.drawRect(
            Rect.fromLTWH(r - 1.5, 0, 3, size.height - r), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A mock text field with selection handles displayed.
Widget _shTextField(
    {required String before,
    required String selected,
    required String after,
    required bool showLeft,
    required bool showRight,
    required bool showCollapsed,
    Color handleColor = _shBlue}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _shBrown.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(before,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            if (showLeft) _shHandleLeft(handleColor, size: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              color: handleColor.withValues(alpha: 0.25),
              child: Text(selected,
                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
            ),
            if (showRight) _shHandleRight(handleColor, size: 16),
            if (showCollapsed) _shHandleCollapsed(handleColor, size: 16),
            Text(after,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ],
    ),
  );
}

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _shBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_shBrown, Color(0xFF5D4037)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.text_fields_outlined, size: 48, color: _shTan),
          const SizedBox(height: 10),
          const Text('TextSelectionHandleType',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('The shape of draggable text selection handles',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _shTag('rendering', _shAccent),
              _shTag('enum', _shBlue),
              _shTag('text selection', _shPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _shWhatIs() => [
      _shTitle('§2  What Is TextSelectionHandleType?'),
      _shBody(
          'TextSelectionHandleType is an enum that identifies which type '
          'of selection handle to display. When you select text on a touch '
          'device, two teardrop-shaped handles appear at the selection '
          'boundaries. When the cursor is at a single position, a '
          'collapsed handle appears.'),
      _shCode(
          'enum TextSelectionHandleType {\n'
          '  left,       // handle at start of selection\n'
          '  right,      // handle at end of selection\n'
          '  collapsed,  // handle at cursor (no selection)\n'
          '}'),
      _shBody(
          'This enum is used by TextSelectionControls and '
          'SelectionOverlay to build the correct visual handle shape.'),
    ];

// ─── §3 The three handle types ───────────────────────────────────
List<Widget> _shThreeTypes() => [
      _shDivider(),
      _shTitle('§3  The Three Handle Types'),
      _shSubtitle('left'),
      _shBody(
          'The handle displayed at the START of a text selection. '
          'Visually it is a teardrop or lollipop shape that leans to '
          'the left, indicating you can drag it leftward to expand '
          'the selection.'),
      _shBullet('Position', 'Start (lowest offset) of selected text'),
      _shBullet('Shape', 'Teardrop pointing left or upward-left'),
      _shSubtitle('right'),
      _shBody(
          'The handle displayed at the END of a text selection. '
          'Leans to the right, indicating rightward drag expands '
          'the selection.'),
      _shBullet('Position', 'End (highest offset) of selected text'),
      _shBullet('Shape', 'Teardrop pointing right or upward-right'),
      _shSubtitle('collapsed'),
      _shBody(
          'The handle displayed when there is no selection — just a '
          'cursor position. Usually a thin vertical line with a small '
          'circle or diamond at the bottom.'),
      _shBullet('Position', 'At the cursor (selection start == end)'),
      _shBullet('Shape', 'Thin stem with circular grab area'),
      _shNote(
          'The visual appearance of handles is platform-specific. '
          'Material and Cupertino render them differently. The enum '
          'just identifies WHICH handle to draw.'),
    ];

// ─── §4 Visual: left handle ──────────────────────────────────────
List<Widget> _shLeftVisual() => [
      _shDivider(),
      _shTitle('§4  Visual: Left Handle (Selection Start)'),
      _shBody(
          'The left handle sits at the beginning of a text selection. '
          'Drag it to change where the selection starts:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _shLabel('Selection start handle'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _shHandleLeft(_shBlue, size: 36),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TextSelectionHandleType.left',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _shBrown)),
                    const SizedBox(height: 4),
                    _shSmall('Teardrop shape, leans toward start'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _shTextField(
              before: 'The quick ',
              selected: 'brown fox',
              after: ' jumps',
              showLeft: true,
              showRight: false,
              showCollapsed: false,
            ),
            _shSmall('Left handle marks where "brown fox" starts'),
          ],
        ),
      ),
      _shCode(
          'Widget buildHandle(BuildContext context,\n'
          '    TextSelectionHandleType type, double textLineHeight) {\n'
          '  if (type == TextSelectionHandleType.left) {\n'
          '    return _buildLeftTeardrop(textLineHeight);\n'
          '  }\n'
          '  // ...\n'
          '}'),
    ];

// ─── §5 Visual: right handle ─────────────────────────────────────
List<Widget> _shRightVisual() => [
      _shDivider(),
      _shTitle('§5  Visual: Right Handle (Selection End)'),
      _shBody(
          'The right handle sits at the end of the selection. Drag it '
          'to extend or shrink the selection toward the right:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _shLabel('Selection end handle'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _shHandleRight(_shPurple, size: 36),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TextSelectionHandleType.right',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _shBrown)),
                    const SizedBox(height: 4),
                    _shSmall('Teardrop shape, leans toward end'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _shTextField(
              before: 'The quick ',
              selected: 'brown fox',
              after: ' jumps',
              showLeft: false,
              showRight: true,
              showCollapsed: false,
              handleColor: _shPurple,
            ),
            _shSmall('Right handle marks where "brown fox" ends'),
          ],
        ),
      ),
    ];

// ─── §6 Visual: collapsed handle ─────────────────────────────────
List<Widget> _shCollapsedVisual() => [
      _shDivider(),
      _shTitle('§6  Visual: Collapsed Handle (Cursor)'),
      _shBody(
          'When no text is selected (cursor is at a single point), the '
          'collapsed handle appears. This helps users position the cursor '
          'precisely on touch devices:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _shLabel('Cursor handle (no selection)'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _shHandleCollapsed(_shTeal, size: 36),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TextSelectionHandleType.collapsed',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _shBrown)),
                    const SizedBox(height: 4),
                    _shSmall('Thin stem with grab circle'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _shTextField(
              before: 'The quick ',
              selected: '',
              after: 'brown fox jumps',
              showLeft: false,
              showRight: false,
              showCollapsed: true,
              handleColor: _shTeal,
            ),
            _shSmall('Collapsed handle at cursor between words'),
          ],
        ),
      ),
      _shNote(
          'On desktop platforms, the collapsed handle is typically not '
          'shown, as the mouse cursor serves the same purpose. It is '
          'mainly useful on touch devices.'),
    ];

// ─── §7 Full selection ───────────────────────────────────────────
List<Widget> _shFullSelection() => [
      _shDivider(),
      _shTitle('§7  Full Selection With Both Handles'),
      _shBody(
          'A complete text selection shows both left and right handles. '
          'The user drags either handle to adjust the range:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _shLabel('Both handles visible during selection'),
            const SizedBox(height: 10),
            _shTextField(
              before: 'Hello ',
              selected: 'beautiful world',
              after: '!',
              showLeft: true,
              showRight: true,
              showCollapsed: false,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _shBrown.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _shHandleLeft(_shBlue, size: 14),
                            const SizedBox(width: 4),
                            const Text('left',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: _shBlue)),
                          ],
                        ),
                        _shSmall('offset: 6'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _shBrown.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _shHandleRight(_shBlue, size: 14),
                            const SizedBox(width: 4),
                            const Text('right',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: _shBlue)),
                          ],
                        ),
                        _shSmall('offset: 21'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      _shBody(
          'When the user drags a handle past the other, the handles swap '
          'types — what was "left" becomes "right" and vice versa, '
          'preserving the invariant that left.offset < right.offset.'),
    ];

// ─── §8 Platform differences ─────────────────────────────────────
List<Widget> _shPlatform() => [
      _shDivider(),
      _shTitle('§8  Platform Differences'),
      _shBody(
          'The enum values are the same everywhere, but the visual '
          'rendering differs by platform:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Material row
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: _shLabel('Material'),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          _shHandleLeft(_shBlue, size: 22),
                          const SizedBox(height: 2),
                          _shSmall('left'),
                        ],
                      ),
                      Column(
                        children: [
                          _shHandleRight(_shBlue, size: 22),
                          const SizedBox(height: 2),
                          _shSmall('right'),
                        ],
                      ),
                      Column(
                        children: [
                          _shHandleCollapsed(_shBlue, size: 22),
                          const SizedBox(height: 2),
                          _shSmall('collapsed'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Cupertino row
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: _shLabel('Cupertino'),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 2,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _shRed,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: _shRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 2),
                          _shSmall('left'),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: _shRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _shRed,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          const SizedBox(height: 2),
                          _shSmall('right'),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 2,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _shRed,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          const SizedBox(height: 2),
                          _shSmall('collapsed'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shPlatRow('Platform', 'left/right', 'collapsed', isHeader: true),
            _shPlatRow('Material', 'Teardrop with circle', 'Circle + stem'),
            _shPlatRow('Cupertino', 'Line + circle', 'Thin vertical line'),
            _shPlatRow('Desktop', 'Arrow cursor', 'I-beam cursor'),
          ],
        ),
      ),
      _shBody(
          'On desktop platforms, handles are not shown at all. The mouse '
          'cursor changes shape instead (I-beam, arrow, etc.).'),
    ];

Widget _shPlatRow(String plat, String lr, String col,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10.5,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _shBrown : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 70, child: Text(plat, style: style)),
        Expanded(child: Text(lr, style: style)),
        Expanded(child: Text(col, style: style)),
      ],
    ),
  );
}

// ─── §9 How the framework chooses handle type ────────────────────
List<Widget> _shFramework() => [
      _shDivider(),
      _shTitle('§9  How The Framework Chooses Handle Type'),
      _shBody(
          'The SelectionOverlay decides which handle type to use based '
          'on the TextSelection:'),
      _shCode(
          'TextSelectionHandleType _chooseType(\n'
          '    TextPosition position, TextSelection selection) {\n'
          '  if (selection.isCollapsed) {\n'
          '    return TextSelectionHandleType.collapsed;\n'
          '  }\n'
          '  if (position == selection.base) {\n'
          '    // LTR: base is start => left handle\n'
          '    return TextSelectionHandleType.left;\n'
          '  }\n'
          '  return TextSelectionHandleType.right;\n'
          '}'),
      _shSubtitle('RTL text'),
      _shBody(
          'For right-to-left text, the mapping is reversed. The "left" '
          'handle (selection start) appears on the right side of the '
          'screen, and "right" handle on the left. The enum always means '
          'start/end of selection, not screen position.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _shTan,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shLabel('Selection state => handle type'),
            const SizedBox(height: 8),
            _shStateRow('isCollapsed == true', 'collapsed'),
            _shStateRow('At selection.base (LTR)', 'left'),
            _shStateRow('At selection.extent (LTR)', 'right'),
            _shStateRow('At selection.base (RTL)', 'right'),
            _shStateRow('At selection.extent (RTL)', 'left'),
          ],
        ),
      ),
      _shNote(
          'The handle type determines the shape built by '
          'TextSelectionControls.buildHandle(). The overlay passes the '
          'type to the build method along with the line height.'),
    ];

Widget _shStateRow(String state, String type) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(state,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black87)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _shAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(type,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _shBrown,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _shSummary() => [
      _shDivider(),
      _shTitle('§10  Summary'),
      _shBody(
          'TextSelectionHandleType is a small but essential enum that '
          'bridges the text selection model and its visual representation. '
          'Three values cover every selection state.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _shBrown.withValues(alpha: 0.08),
              _shTan,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shBrown.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _shBrown)),
            const SizedBox(height: 10),
            _shSumPt('left',
                'Selection start handle — teardrop shape at base offset'),
            _shSumPt('right',
                'Selection end handle — teardrop shape at extent offset'),
            _shSumPt('collapsed',
                'Cursor handle — shown when no text is selected'),
            _shSumPt('Platform visual',
                'Material, Cupertino, and desktop each render differently'),
            _shSumPt('Swap on drag',
                'Handles swap types if dragged past each other'),
            _shSumPt('RTL aware',
                'Enum means start/end, not screen left/right'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _shBrown,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TextSelectionHandleType Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _shSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _shGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _shBrown)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shBanner(),
        const SizedBox(height: 20),
        ..._shWhatIs(),
        ..._shThreeTypes(),
        ..._shLeftVisual(),
        ..._shRightVisual(),
        ..._shCollapsedVisual(),
        ..._shFullSelection(),
        ..._shPlatform(),
        ..._shFramework(),
        ..._shSummary(),
      ],
    ),
  );
}
