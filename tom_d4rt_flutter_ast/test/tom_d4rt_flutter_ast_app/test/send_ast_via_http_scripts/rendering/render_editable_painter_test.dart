// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// RenderEditablePainter — Deep Demo
// ----------------------------------------------------------------------------
// `RenderEditablePainter` is the abstract base used by `RenderEditable` to
// draw decorations on top of (or below) editable text content. Subclasses
// paint things like the caret, selection rectangles, IME composing
// underlines, and (when enabled) debug rulers.
//
//   abstract class RenderEditablePainter extends ChangeNotifier {
//     void paint(Canvas canvas, Size size, RenderEditable renderEditable);
//     bool shouldRepaint(RenderEditablePainter? oldDelegate);
//   }
//
// Because constructing a real `RenderEditable` from interpreted demo code is
// impractical, we exercise the *observable effects* through real
// `TextField`s plus illustrative `CustomPainter` overlays that simulate what
// a `RenderEditablePainter` subclass would draw.
// ============================================================================

// ----------------------------------------------------------------------------
// Stable controllers — declared at top-level so they survive rebuilds and
// the harness does not have to manage State for us. These are demo
// scaffolding; no disposal is required.
// ----------------------------------------------------------------------------
final TextEditingController _selCtrlA = TextEditingController(
  text: 'Highlight me with a pastel selection color.',
)..selection = const TextSelection(baseOffset: 0, extentOffset: 9);

final TextEditingController _selCtrlB = TextEditingController(
  text: 'A different selection color for a different mood.',
)..selection = const TextSelection(baseOffset: 12, extentOffset: 27);

final TextEditingController _selCtrlC = TextEditingController(
  text: 'Selection painters compose on top of the glyph layer.',
)..selection = const TextSelection(baseOffset: 0, extentOffset: 9);

final TextEditingController _selCtrlD = TextEditingController(
  text: 'Each TextSelectionThemeData feeds the painter pipeline.',
)..selection = const TextSelection(baseOffset: 5, extentOffset: 22);

final TextEditingController _selCtrlE = TextEditingController(
  text: 'Selection rects are computed by RenderEditable and drawn by the painter.',
)..selection = const TextSelection(baseOffset: 0, extentOffset: 16);

final TextEditingController _selCtrlF = TextEditingController(
  text: 'Painter sees the laid-out TextPainter and draws above the text.',
)..selection = const TextSelection(baseOffset: 18, extentOffset: 30);

final TextEditingController _curCtrlA = TextEditingController(
  text: 'Caret style A — thin, blue, rounded.',
);
final TextEditingController _curCtrlB = TextEditingController(
  text: 'Caret style B — thick orange.',
);
final TextEditingController _curCtrlC = TextEditingController(
  text: 'Caret style C — green, square edges.',
);
final TextEditingController _curCtrlD = TextEditingController(
  text: 'Caret style D — red, very wide.',
);
final TextEditingController _curCtrlE = TextEditingController(
  text: 'Caret style E — purple, custom height.',
);
final TextEditingController _curCtrlF = TextEditingController(
  text: 'Caret style F — teal, narrow rounded.',
);

final TextEditingController _overlayCtrl = TextEditingController(
  text: 'A foreground CustomPaint can simulate what RenderEditablePainter does.',
);

final TextEditingController _composingCtrl = TextEditingController(
  text: 'IME compose region: hellö wörld',
);

final TextEditingController _debugGridCtrl = TextEditingController(
  text: 'Debug grid pretends to be RenderEditable internals.',
);

final TextEditingController _multilineCtrl = TextEditingController(
  text:
      'Multi-line painter demo.\n'
      'A RenderEditablePainter sees one Size and the full glyph layout.\n'
      'It can paint per-line decorations such as wavy underlines, mention\n'
      'chips, or syntax-aware highlights — all on the same Canvas.',
)..selection = const TextSelection(baseOffset: 0, extentOffset: 60);

final TextEditingController _searchCtrl = TextEditingController(
  text: 'Search-style highlighter painters underline matches in real time.',
);

final TextEditingController _syntaxCtrl = TextEditingController(
  text: 'final width = MediaQuery.of(context).size.width;',
);

final TextEditingController _mentionCtrl = TextEditingController(
  text: 'Ping @alex and @taylor about the painter PR.',
);

// ----------------------------------------------------------------------------
// Custom painters used to *simulate* what a RenderEditablePainter draws.
// ----------------------------------------------------------------------------

/// Paints a translucent "fake selection" rectangle that overlays a TextField.
/// In a real RenderEditablePainter, the selection rects come from
/// `RenderEditable.getBoxesForSelection(...)`; here we use fixed offsets to
/// mimic the rendered effect.
class _FakeSelectionRectPainter extends CustomPainter {
  _FakeSelectionRectPainter({
    required this.start,
    required this.end,
    required this.color,
    required this.lineHeight,
  });

  final double start;
  final double end;
  final Color color;
  final double lineHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final Rect r = Rect.fromLTWH(start, 0, end - start, lineHeight);
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _FakeSelectionRectPainter old) {
    // Mirror RenderEditablePainter.shouldRepaint contract: only repaint if
    // any decoration-affecting field changed.
    return old.start != start ||
        old.end != end ||
        old.color != color ||
        old.lineHeight != lineHeight;
  }
}

/// Paints an animated "blinking caret" rectangle on top of a fake field.
/// Demonstrates that RenderEditablePainter is a `ChangeNotifier`: the
/// blink phase calls `notifyListeners()` and triggers a repaint without
/// requesting layout.
class _CaretBlinkPainter extends CustomPainter {
  _CaretBlinkPainter({
    required this.phase,
    required this.x,
    required this.height,
    required this.color,
    required this.width,
    required this.radius,
  }) : super(repaint: phase);

  final Animation<double> phase;
  final double x;
  final double height;
  final Color color;
  final double width;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // 0..1 sawtooth -> on for first half, off for second half.
    final double t = phase.value;
    final bool visible = t < 0.5;
    if (!visible) {
      return;
    }
    final Paint p = Paint()..color = color;
    final Rect rect = Rect.fromLTWH(
      x,
      (size.height - height) / 2,
      width,
      height,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant _CaretBlinkPainter old) {
    return old.phase != phase ||
        old.x != x ||
        old.height != height ||
        old.color != color ||
        old.width != width ||
        old.radius != radius;
  }
}

/// Paints a dashed/dotted underline beneath a substring to simulate
/// the IME composing decoration.
class _ComposingUnderlinePainter extends CustomPainter {
  _ComposingUnderlinePainter({
    required this.start,
    required this.end,
    required this.baselineY,
    required this.color,
    this.thickness = 1.6,
  });

  final double start;
  final double end;
  final double baselineY;
  final Color color;
  final double thickness;
  static const double dashWidth = 4;
  static const double dashGap = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;
    double x = start;
    while (x < end) {
      final double next = (x + dashWidth).clamp(start, end);
      canvas.drawLine(Offset(x, baselineY), Offset(next, baselineY), paint);
      x = next + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _ComposingUnderlinePainter old) {
    return old.start != start ||
        old.end != end ||
        old.baselineY != baselineY ||
        old.color != color ||
        old.thickness != thickness;
  }
}

/// Paints a fake "RenderEditable debug ruler" — a baseline line, a top-of-
/// glyph line, and a vertical character grid. Purely illustrative.
class _DebugGridPainter extends CustomPainter {
  const _DebugGridPainter({
    required this.charWidth,
    required this.lineHeight,
    required this.baselineFraction,
    required this.color,
  });

  final double charWidth;
  final double lineHeight;
  final double baselineFraction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint thin = Paint()
      ..color = color.withOpacity(0.45)
      ..strokeWidth = 0.5;
    final Paint baseline = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    // Vertical grid (character columns).
    for (double x = 0; x < size.width; x += charWidth) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), thin);
    }

    // Horizontal grid (lines).
    for (double y = 0; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thin);
      // Baseline within each line.
      final double by = y + (lineHeight * baselineFraction);
      canvas.drawLine(Offset(0, by), Offset(size.width, by), baseline);
    }
  }

  @override
  bool shouldRepaint(covariant _DebugGridPainter old) {
    return old.charWidth != charWidth ||
        old.lineHeight != lineHeight ||
        old.baselineFraction != baselineFraction ||
        old.color != color;
  }
}

/// Paints multi-line selection rectangles. Approximates what a real
/// RenderEditablePainter would paint after `getBoxesForSelection` returned
/// per-line rects.
class _MultiLineSelectionPainter extends CustomPainter {
  _MultiLineSelectionPainter({
    required this.lineRects,
    required this.color,
  });

  final List<Rect> lineRects;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()..color = color;
    for (final Rect r in lineRects) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(3)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MultiLineSelectionPainter old) {
    return old.color != color || old.lineRects != lineRects;
  }
}

/// Diagram painter for the hero card: visualises the layered painter stack.
class _PainterStackDiagram extends CustomPainter {
  const _PainterStackDiagram();

  @override
  void paint(Canvas canvas, Size size) {
    final List<_StackLayer> layers = <_StackLayer>[
      _StackLayer('RenderEditable.paint', const Color(0xFFE8EAF6)),
      _StackLayer('Background painter', const Color(0xFFC5CAE9)),
      _StackLayer('Selection rects', const Color(0xFFFFE082)),
      _StackLayer('Glyphs (TextPainter)', const Color(0xFFB3E5FC)),
      _StackLayer('Composing underline', const Color(0xFFCE93D8)),
      _StackLayer('Caret', const Color(0xFFFFAB91)),
      _StackLayer('Foreground painter', const Color(0xFF80CBC4)),
    ];
    final double layerHeight = size.height / layers.length;
    for (int i = 0; i < layers.length; i++) {
      final Rect r = Rect.fromLTWH(
        0,
        i * layerHeight,
        size.width,
        layerHeight - 2,
      );
      final Paint p = Paint()..color = layers[i].color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        p,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: layers[i].label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width - 16);
      tp.paint(canvas, Offset(8, r.top + (r.height - tp.height) / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _PainterStackDiagram oldDelegate) => false;
}

class _StackLayer {
  const _StackLayer(this.label, this.color);
  final String label;
  final Color color;
}

// ----------------------------------------------------------------------------
// Section helpers (purely visual scaffolding).
// ----------------------------------------------------------------------------
Widget _section({
  required String title,
  required String subtitle,
  required Color accent,
  required List<Widget> children,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: accent.withOpacity(0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.18),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(fontSize: 12.5)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: Colors.black54),
        ),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5))),
      ],
    ),
  );
}

Widget _codeBlock(String code, {Color background = const Color(0xFFF1F3F4)}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.black12),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.35,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section builders.
// ----------------------------------------------------------------------------

Widget _heroIntro() {
  return _section(
    title: '1. RenderEditablePainter — at a glance',
    subtitle:
        'Foreground/background painters that decorate the editable text '
        'rendered by RenderEditable. They draw the caret, selection, '
        'composing underline, and any custom adornments.',
    accent: const Color(0xFF3F51B5),
    children: <Widget>[
      _codeBlock(
        'abstract class RenderEditablePainter extends ChangeNotifier {\n'
        '  void paint(Canvas canvas, Size size, RenderEditable renderEditable);\n'
        '  bool shouldRepaint(RenderEditablePainter? oldDelegate);\n'
        '}',
      ),
      const SizedBox(height: 8),
      const Text(
        'Layered painter stack inside an editable field:',
        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 220,
        child: CustomPaint(painter: const _PainterStackDiagram()),
      ),
      const SizedBox(height: 8),
      _bullet(
        'Background painter draws BEFORE the glyphs (e.g. line highlight).',
      ),
      _bullet(
        'Foreground painter draws AFTER the glyphs (caret, custom badges).',
      ),
      _bullet(
        'The painter receives the same Size and the live RenderEditable, '
        'so it can call getBoxesForSelection / getOffsetForCaret.',
      ),
    ],
  );
}

Widget _anatomyCard() {
  return _section(
    title: '2. Anatomy of a typical RenderEditablePainter',
    subtitle:
        'Most subclasses of RenderEditablePainter draw one or more of the '
        'decorations below. Each can be enabled/disabled independently.',
    accent: const Color(0xFF00897B),
    children: const <Widget>[
      _AnatomyRow(
        icon: Icons.short_text,
        title: 'Caret',
        description:
            'The blinking text-insertion bar. Width / radius / color come '
            'from EditableText cursor properties.',
      ),
      _AnatomyRow(
        icon: Icons.highlight,
        title: 'Selection rectangles',
        description:
            'One rect per line spanned by the selection, drawn under the '
            'glyphs. Color comes from TextSelectionThemeData.selectionColor.',
      ),
      _AnatomyRow(
        icon: Icons.format_underlined,
        title: 'IME composing underline',
        description:
            'Dashed underline beneath the text the IME is currently composing '
            '(typed but not yet committed).',
      ),
      _AnatomyRow(
        icon: Icons.grid_4x4,
        title: 'Debug rulers / grid',
        description:
            'Optional overlays for diagnosing layout issues, e.g. baselines, '
            'line height, character grid. Off in release builds.',
      ),
      _AnatomyRow(
        icon: Icons.flash_on,
        title: 'Custom adornments',
        description:
            'Mention chips, search highlights, syntax-highlighter glow — '
            'anything that depends on the live glyph layout.',
      ),
    ],
  );
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.14),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: Colors.teal.shade700),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _selectionColorShowcase() {
  final List<_SelectionTile> tiles = <_SelectionTile>[
    _SelectionTile(
      label: 'Pastel blue',
      color: const Color(0x553F51B5),
      controller: _selCtrlA,
    ),
    _SelectionTile(
      label: 'Lemon',
      color: const Color(0x55FFEB3B),
      controller: _selCtrlB,
    ),
    _SelectionTile(
      label: 'Mint',
      color: const Color(0x5500BFA5),
      controller: _selCtrlC,
    ),
    _SelectionTile(
      label: 'Coral',
      color: const Color(0x55FF7043),
      controller: _selCtrlD,
    ),
    _SelectionTile(
      label: 'Lavender',
      color: const Color(0x55B39DDB),
      controller: _selCtrlE,
    ),
    _SelectionTile(
      label: 'Sky',
      color: const Color(0x5503A9F4),
      controller: _selCtrlF,
    ),
  ];
  return _section(
    title: '3. TextField selection-color showcase',
    subtitle:
        'Six TextFields, each with a different TextSelectionThemeData. Behind '
        'the scenes the same kind of painter draws the highlighted rect; only '
        'the color differs.',
    accent: const Color(0xFFAD1457),
    children: <Widget>[
      _codeBlock(
        'Theme(\n'
        '  data: Theme.of(context).copyWith(\n'
        '    textSelectionTheme: TextSelectionThemeData(\n'
        '      selectionColor: Color(0x553F51B5),\n'
        '    ),\n'
        '  ),\n'
        '  child: TextField(controller: ctrl),\n'
        ')',
      ),
      const SizedBox(height: 6),
      ...tiles.map((_SelectionTile t) => _selectionTile(t)),
    ],
  );
}

class _SelectionTile {
  const _SelectionTile({
    required this.label,
    required this.color,
    required this.controller,
  });
  final String label;
  final Color color;
  final TextEditingController controller;
}

Widget _selectionTile(_SelectionTile t) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: t.color.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.black26),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                t.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (BuildContext context) => Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: t.color,
                ),
              ),
              child: TextField(
                controller: t.controller,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _cursorStylingGallery() {
  final List<_CursorTile> tiles = <_CursorTile>[
    _CursorTile(
      label: 'Thin blue, rounded',
      color: Colors.blue,
      width: 1.5,
      radius: 3,
      controller: _curCtrlA,
    ),
    _CursorTile(
      label: 'Thick orange',
      color: Colors.orange,
      width: 4,
      radius: 0,
      controller: _curCtrlB,
    ),
    _CursorTile(
      label: 'Green square edges',
      color: Colors.green,
      width: 2.0,
      radius: 0,
      height: 18,
      controller: _curCtrlC,
    ),
    _CursorTile(
      label: 'Wide red',
      color: Colors.red,
      width: 6,
      radius: 1,
      controller: _curCtrlD,
    ),
    _CursorTile(
      label: 'Tall purple',
      color: Colors.purple,
      width: 2,
      radius: 4,
      height: 26,
      controller: _curCtrlE,
    ),
    _CursorTile(
      label: 'Narrow teal rounded',
      color: Colors.teal,
      width: 1,
      radius: 6,
      controller: _curCtrlF,
    ),
  ];
  return _section(
    title: '4. Cursor styling gallery',
    subtitle:
        'TextField cursorColor / cursorWidth / cursorRadius / cursorHeight '
        'flow into the painter that draws the caret rect each blink phase.',
    accent: const Color(0xFF6A1B9A),
    children: <Widget>[
      _codeBlock(
        'TextField(\n'
        '  controller: ctrl,\n'
        '  cursorColor: Colors.orange,\n'
        '  cursorWidth: 4,\n'
        '  cursorRadius: Radius.zero,\n'
        '  cursorHeight: 22,\n'
        ')',
      ),
      ...tiles.map(_cursorTile),
    ],
  );
}

class _CursorTile {
  const _CursorTile({
    required this.label,
    required this.color,
    required this.width,
    required this.radius,
    required this.controller,
    this.height,
  });
  final String label;
  final Color color;
  final double width;
  final double radius;
  final double? height;
  final TextEditingController controller;
}

Widget _cursorTile(_CursorTile t) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            t.label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: t.controller,
            cursorColor: t.color,
            cursorWidth: t.width,
            cursorRadius: Radius.circular(t.radius),
            cursorHeight: t.height,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _customSelectionRectOverlay() {
  return _section(
    title: '5. Custom selection-rect overlay',
    subtitle:
        'A Stack of a TextField + a foreground CustomPaint. The CustomPainter '
        'simulates the rect a custom RenderEditablePainter subclass would '
        'draw on top of the glyphs.',
    accent: const Color(0xFF1E88E5),
    children: <Widget>[
      _codeBlock(
        'Stack(\n'
        '  children: [\n'
        '    TextField(controller: ctrl),\n'
        '    Positioned.fill(\n'
        '      child: IgnorePointer(\n'
        '        child: CustomPaint(painter: _FakeSelectionRectPainter(...)),\n'
        '      ),\n'
        '    ),\n'
        '  ],\n'
        ')',
      ),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          double start = 60;
          double end = 180;
          Color color = const Color(0x553F51B5);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('start: ', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: 240,
                      value: start,
                      onChanged: (double v) => setState(() => start = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('end: ', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: 320,
                      value: end,
                      onChanged: (double v) => setState(() => end = v),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  for (final Color c in <Color>[
                    const Color(0x553F51B5),
                    const Color(0x55FF7043),
                    const Color(0x5500BFA5),
                    const Color(0x55B39DDB),
                  ])
                    GestureDetector(
                      onTap: () => setState(() => color = c),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: c.withOpacity(1.0),
                          border: Border.all(
                            color: c.value == color.value
                                ? Colors.black
                                : Colors.black26,
                            width: c.value == color.value ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: <Widget>[
                  TextField(
                    controller: _overlayCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _FakeSelectionRectPainter(
                          start: start,
                          end: end,
                          color: color,
                          lineHeight: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'In a real subclass, start/end come from\n'
                'renderEditable.getBoxesForSelection(selection).',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

Widget _caretBlinkSimulator() {
  return _section(
    title: '6. Caret blink simulator',
    subtitle:
        'A CustomPainter driven by an AnimationController shows the cadence '
        'at which RenderEditablePainter.notifyListeners() fires when the '
        'caret toggles.',
    accent: const Color(0xFFE65100),
    children: <Widget>[
      _codeBlock(
        'class _CaretPainter extends RenderEditablePainter {\n'
        '  _CaretPainter(this.blink) {\n'
        '    blink.addListener(notifyListeners); // triggers paint\n'
        '  }\n'
        '  final ValueNotifier<bool> blink;\n'
        '  @override\n'
        '  void paint(Canvas canvas, Size size, RenderEditable r) {\n'
        '    if (!blink.value) return;\n'
        '    final caretRect = r.getLocalRectForCaret(r.selection!.extent);\n'
        '    canvas.drawRect(caretRect, Paint()..color = Colors.blue);\n'
        '  }\n'
        '}',
      ),
      _CaretBlinkExample(),
      const SizedBox(height: 6),
      _bullet(
        'The painter does NOT call markNeedsLayout — only notifyListeners().',
      ),
      _bullet(
        'RenderEditable subscribes and schedules a single repaint phase.',
      ),
      _bullet(
        'shouldRepaint can return false when only the blink phase changed, '
        'because the Listenable already drives the repaint via super.repaint.',
      ),
    ],
  );
}

class _CaretBlinkExample extends StatefulWidget {
  @override
  State<_CaretBlinkExample> createState() => _CaretBlinkExampleState();
}

class _CaretBlinkExampleState extends State<_CaretBlinkExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Animated caret over a static text-line mock:',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Text(
                  'Hello caret world',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 14),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _CaretBlinkPainter(
                      phase: _ctrl,
                      x: 110,
                      height: 18,
                      color: Colors.deepOrange,
                      width: 2.0,
                      radius: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _composingUnderlineSimulation() {
  return _section(
    title: '7. Composing underline simulation',
    subtitle:
        'A CustomPainter draws a dashed underline below a portion of the '
        'TextField — exactly what an IME composing region looks like.',
    accent: const Color(0xFF8E24AA),
    children: <Widget>[
      _codeBlock(
        '// IME state surfaces composing range as TextRange.\n'
        'controller.value = TextEditingValue(\n'
        '  text: "hello",\n'
        '  composing: TextRange(start: 0, end: 5),\n'
        ');',
      ),
      Stack(
        children: <Widget>[
          TextField(
            controller: _composingCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _ComposingUnderlinePainter(
                  start: 152,
                  end: 220,
                  baselineY: 33,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      _bullet(
        'Real composing painter reads renderEditable.text.composingRange '
        'and converts it into per-line rects.',
      ),
      _bullet(
        'Many platforms also draw a thin solid underline in addition to the '
        'dashed one (e.g. Android IME).',
      ),
    ],
  );
}

Widget _debugGridPainter() {
  return _section(
    title: '8. Debug grid painter',
    subtitle:
        'When debugPaintEditableLayoutEnabled-style flags are on, an internal '
        'painter overlays a baseline / line-height / character grid.',
    accent: const Color(0xFF455A64),
    children: <Widget>[
      _codeBlock(
        '// Pseudo-code from a debug RenderEditablePainter:\n'
        'void paint(Canvas c, Size size, RenderEditable r) {\n'
        '  final lineHeight = r.preferredLineHeight;\n'
        '  for (var y = 0.0; y < size.height; y += lineHeight) {\n'
        '    c.drawLine(Offset(0, y), Offset(size.width, y), guidePaint);\n'
        '  }\n'
        '}',
      ),
      Stack(
        children: <Widget>[
          SizedBox(
            height: 64,
            child: TextField(
              controller: _debugGridCtrl,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _DebugGridPainter(
                  charWidth: 8,
                  lineHeight: 24,
                  baselineFraction: 0.78,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      _bullet('Vertical lines: character columns (constant for monospace).'),
      _bullet('Horizontal lines: line boxes from preferredLineHeight.'),
      _bullet('Bolder horizontal line: text baseline within each line.'),
    ],
  );
}

Widget _multiLineSelection() {
  return _section(
    title: '9. Multi-line selection',
    subtitle:
        'A multiline TextField with a long pre-selected region. The fake '
        'painter draws one rect per visible line — exactly the shape '
        'getBoxesForSelection returns.',
    accent: const Color(0xFF00838F),
    children: <Widget>[
      _codeBlock(
        'final boxes = renderEditable.getBoxesForSelection(\n'
        '  controller.selection,\n'
        ');\n'
        'for (final box in boxes) {\n'
        '  canvas.drawRect(box.toRect(), selectionPaint);\n'
        '}',
      ),
      Stack(
        children: <Widget>[
          TextField(
            controller: _multilineCtrl,
            maxLines: 6,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MultiLineSelectionPainter(
                  color: const Color(0x33FFC107),
                  lineRects: const <Rect>[
                    Rect.fromLTWH(8, 8, 220, 20),
                    Rect.fromLTWH(8, 30, 320, 20),
                    Rect.fromLTWH(8, 52, 280, 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      _bullet(
        'The painter should NOT assume one rect per line — bidi text and '
        'wrapping can produce multiple rects per visual line.',
      ),
      _bullet(
        'Selection rects are computed in local coordinates and clipped by '
        'RenderEditable.size.',
      ),
    ],
  );
}

Widget _shouldRepaintDemo() {
  return _section(
    title: '10. shouldRepaint demonstration',
    subtitle:
        'shouldRepaint controls whether the painter is invoked again after a '
        'rebuild. Returning false when nothing changed avoids GPU work.',
    accent: const Color(0xFF558B2F),
    children: <Widget>[
      _codeBlock(
        '@override\n'
        'bool shouldRepaint(RenderEditablePainter? old) {\n'
        '  if (old is! _MyPainter) return true;\n'
        '  return old.color != color || old.thickness != thickness;\n'
        '}',
      ),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          double thickness = 2;
          int paintCount = 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('thickness: ', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      min: 0.5,
                      max: 8,
                      value: thickness,
                      onChanged: (double v) {
                        setState(() {
                          thickness = v;
                          paintCount++;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(
                'Repaints triggered: $paintCount',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              Container(
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomPaint(
                  painter: _ComposingUnderlinePainter(
                    start: 8,
                    end: 200,
                    baselineY: 28,
                    color: Colors.green,
                    thickness: thickness,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Underline thickness',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

Widget _changeNotifierRole() {
  return _section(
    title: '11. ChangeNotifier role',
    subtitle:
        'RenderEditablePainter extends ChangeNotifier so it can drive paints '
        'without re-layout. Subclasses call notifyListeners() whenever a '
        'decoration-affecting field changes.',
    accent: const Color(0xFF0097A7),
    children: <Widget>[
      _codeBlock(
        'class _BlinkPainter extends RenderEditablePainter {\n'
        '  bool _on = true;\n'
        '  bool get on => _on;\n'
        '  set on(bool v) {\n'
        '    if (_on == v) return;\n'
        '    _on = v;\n'
        '    notifyListeners(); // triggers RenderEditable.markNeedsPaint\n'
        '  }\n'
        '}',
      ),
      _bullet(
        'RenderEditable adds itself as a listener to every painter in '
        'foregroundPainter / backgroundPainter slots.',
      ),
      _bullet(
        'When notifyListeners() fires, RenderEditable calls markNeedsPaint() '
        '— never markNeedsLayout(). That is why caret blinks are cheap.',
      ),
      _bullet(
        'The framework also dispatches the listener through Listenable.merge '
        'when a painter wraps a Ticker or AnimationController.',
      ),
    ],
  );
}

Widget _realWorldUseCases() {
  return _section(
    title: '12. Real-world use cases',
    subtitle:
        'Three illustrative previews of what production RenderEditablePainter '
        'subclasses look like, with no real implementation.',
    accent: const Color(0xFFD84315),
    children: <Widget>[
      const Text(
        '12a. Code search highlighter',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      Stack(
        children: <Widget>[
          TextField(
            controller: _searchCtrl,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MultiLineSelectionPainter(
                  color: const Color(0x66FFEB3B),
                  lineRects: const <Rect>[
                    Rect.fromLTWH(0, 8, 60, 20),
                    Rect.fromLTWH(115, 8, 90, 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text(
        '12b. Mention chip overlay',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      Stack(
        children: <Widget>[
          TextField(
            controller: _mentionCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MultiLineSelectionPainter(
                  color: const Color(0x553F51B5),
                  lineRects: const <Rect>[
                    Rect.fromLTWH(38, 8, 38, 20),
                    Rect.fromLTWH(94, 8, 56, 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text(
        '12c. Tiny syntax-highlighter glow',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      Stack(
        children: <Widget>[
          TextField(
            controller: _syntaxCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MultiLineSelectionPainter(
                  color: const Color(0x440091EA),
                  lineRects: const <Rect>[
                    Rect.fromLTWH(0, 8, 38, 20),
                    Rect.fromLTWH(82, 8, 100, 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _decisionCard() {
  return _section(
    title: '13. Decision card — when to subclass what',
    subtitle:
        'Pick the lowest-level abstraction that covers your use case. Most '
        'apps never need to subclass RenderEditablePainter directly.',
    accent: const Color(0xFF5D4037),
    children: const <Widget>[
      _DecisionRow(
        choice: 'RenderEditablePainter',
        when:
            'You need access to the live RenderEditable, glyph-level '
            'measurements (getBoxesForSelection, getLocalRectForCaret), or '
            'must blend below/above the glyphs.',
      ),
      _DecisionRow(
        choice: 'Custom CustomPainter overlay',
        when:
            'You only need to draw shapes whose positions you can compute '
            'externally (e.g. a fixed badge in the corner).',
      ),
      _DecisionRow(
        choice: 'TextSpan / RichText',
        when:
            'You only need styled text — colours, weights, decorations. No '
            'overlay needed.',
      ),
      _DecisionRow(
        choice: 'TextSelectionTheme / cursorColor',
        when:
            'You only need to retheme caret + selection — the framework '
            'painter handles the rest.',
      ),
      _DecisionRow(
        choice: 'SelectionToolbarLayoutDelegate',
        when:
            'You are customising the floating toolbar above selections, not '
            'the rectangles themselves.',
      ),
    ],
  );
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({required this.choice, required this.when});
  final String choice;
  final String when;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              choice,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5D4037),
              ),
            ),
          ),
          Expanded(child: Text(when, style: const TextStyle(fontSize: 12.5))),
        ],
      ),
    );
  }
}

Widget _referenceTable() {
  return _section(
    title: '14. Reference table',
    subtitle:
        'Public API of RenderEditablePainter. The contract is small but '
        'powerful: two methods plus the inherited ChangeNotifier surface.',
    accent: const Color(0xFF1565C0),
    children: <Widget>[
      DataTable(
        headingRowHeight: 30,
        dataRowMinHeight: 28,
        dataRowMaxHeight: 60,
        columnSpacing: 16,
        columns: const <DataColumn>[
          DataColumn(label: Text('Member')),
          DataColumn(label: Text('Signature')),
          DataColumn(label: Text('Notes')),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('paint')),
              DataCell(
                Text(
                  'void paint(Canvas, Size, RenderEditable)',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(Text('Called for every paint pass.')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('shouldRepaint')),
              DataCell(
                Text(
                  'bool shouldRepaint(RenderEditablePainter?)',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(Text('Diff vs old delegate; false skips the paint.')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('addListener')),
              DataCell(
                Text(
                  'void addListener(VoidCallback)',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(Text('Inherited from ChangeNotifier.')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('removeListener')),
              DataCell(
                Text(
                  'void removeListener(VoidCallback)',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(Text('Inherited from ChangeNotifier.')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('notifyListeners')),
              DataCell(
                Text(
                  'void notifyListeners()',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(
                Text(
                  'Drives RenderEditable.markNeedsPaint() without layout.',
                ),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('dispose')),
              DataCell(
                Text(
                  'void dispose()',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              DataCell(Text('Inherited from ChangeNotifier.')),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _footer() {
  return _section(
    title: '15. References',
    subtitle:
        'See the dartdoc for these classes for the canonical contract and '
        'caveats.',
    accent: const Color(0xFF37474F),
    children: const <Widget>[
      _RefRow(
        symbol: 'RenderEditable',
        path: 'package:flutter/rendering.dart',
        notes: 'Owns layout + paint pipeline; hosts the painter slots.',
      ),
      _RefRow(
        symbol: 'EditableText',
        path: 'package:flutter/widgets.dart',
        notes: 'Widget that wires controller, focus, and theming.',
      ),
      _RefRow(
        symbol: 'TextField',
        path: 'package:flutter/material.dart',
        notes: 'Material wrapper around EditableText.',
      ),
      _RefRow(
        symbol: 'TextSelectionThemeData',
        path: 'package:flutter/material.dart',
        notes: 'Provides selectionColor + cursorColor used by painters.',
      ),
      _RefRow(
        symbol: 'TextEditingController',
        path: 'package:flutter/widgets.dart',
        notes: 'Carries text + selection + composing range fed to painter.',
      ),
    ],
  );
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.symbol,
    required this.path,
    required this.notes,
  });
  final String symbol;
  final String path;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                symbol,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                path,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Colors.black54,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          Text(notes, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Entry point.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== RenderEditablePainter Deep Demo ===');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderEditablePainter — Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF3F51B5),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderEditablePainter — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'A guided tour of RenderEditablePainter — the abstract '
                'foreground/background painter that decorates editable text.',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              _heroIntro(),
              _anatomyCard(),
              _selectionColorShowcase(),
              _cursorStylingGallery(),
              _customSelectionRectOverlay(),
              _caretBlinkSimulator(),
              _composingUnderlineSimulation(),
              _debugGridPainter(),
              _multiLineSelection(),
              _shouldRepaintDemo(),
              _changeNotifierRole(),
              _realWorldUseCases(),
              _decisionCard(),
              _referenceTable(),
              _footer(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  '© Tom Agent Container — RenderEditablePainter demo',
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}
