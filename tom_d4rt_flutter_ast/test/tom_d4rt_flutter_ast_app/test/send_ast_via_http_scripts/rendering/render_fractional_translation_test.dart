// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for FractionalTranslation /
// RenderFractionalTranslation. Shows fractional offsets, hit testing,
// fractional-vs-pixel comparison, real-world recipes, and a static
// multi-frame animation explainer.
import 'package:flutter/material.dart';

// ============================================================
// Helper: section panel with title + description
// ============================================================
Widget _panel({
  required String title,
  required String description,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFDCCFF8), width: 1.2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x18000000),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Color(0xFF4A2A8C),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF5C4F76),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

// ============================================================
// Helper: dark code panel
// ============================================================
Widget _codePanel({required String label, required String code, Color accent = const Color(0xFF80DEEA)}) {
  return Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF383852)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: accent, size: 18.0),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Color(0xFFB7E4C7),
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: a 100x100 reference frame containing a 40x40 origin
// ghost and a FractionalTranslation-shifted box on top of it.
// ============================================================
Widget _refFrame({
  required Offset translation,
  required Color color,
  required String label,
  double size = 120.0,
  double box = 44.0,
  bool transformHitTests = true,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xFFF6F1FF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFCEBDF4)),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // axes
        Positioned.fill(
          child: CustomPaint(painter: _GridPainter()),
        ),
        // origin ghost
        Positioned(
          left: (size - box) / 2,
          top: (size - box) / 2,
          child: Container(
            width: box,
            height: box,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF8D82A8),
                style: BorderStyle.solid,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white.withValues(alpha: 0.4),
            ),
            child: const Center(
              child: Text(
                'orig',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF72678D),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        // translated box
        Positioned(
          left: (size - box) / 2,
          top: (size - box) / 2,
          child: FractionalTranslation(
            translation: translation,
            transformHitTests: transformHitTests,
            child: Container(
              width: box,
              height: box,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: simple grid painter for the reference frame
// ============================================================
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE3D9F7)
      ..strokeWidth = 0.6;
    const step = 12.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // center cross
    final cross = Paint()
      ..color = const Color(0xFF9F8AD6)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      cross,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      cross,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================
// Helper: labeled cell with caption under a widget
// ============================================================
Widget _captioned({required Widget child, required String caption, required String sub}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      child,
      const SizedBox(height: 8.0),
      Text(
        caption,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
          color: Color(0xFF3F2A75),
        ),
      ),
      Text(
        sub,
        style: const TextStyle(
          fontSize: 11.0,
          color: Color(0xFF6E5E91),
        ),
      ),
    ],
  );
}

// ============================================================
// Helper: small summary row inside the final summary panel
// ============================================================
Widget _summaryItem({
  required IconData icon,
  required String title,
  required String desc,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF4A4458),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// MAIN BUILD
// ============================================================
dynamic build(BuildContext context) {
  print('=== RenderFractionalTranslation Deep Demo ===');

  // ============================================================
  // SECTION 1: Basic fractional offsets
  // ============================================================
  print('--- Section 1: Basic fractional offsets ---');

  final basicOffsets = <Map<String, dynamic>>[
    {
      'offset': const Offset(0.0, 0.0),
      'color': const Color(0xFF6A42CC),
      'label': '0,0',
      'caption': 'Offset(0, 0)',
      'sub': 'Identity — no shift',
    },
    {
      'offset': const Offset(0.5, 0.0),
      'color': const Color(0xFF2196F3),
      'label': '+½ x',
      'caption': 'Offset(0.5, 0)',
      'sub': 'Half-width to the right',
    },
    {
      'offset': const Offset(-0.5, 0.5),
      'color': const Color(0xFFE53935),
      'label': '-½,½',
      'caption': 'Offset(-0.5, 0.5)',
      'sub': 'Left ½, down ½',
    },
    {
      'offset': const Offset(1.0, 1.0),
      'color': const Color(0xFFFB8C00),
      'label': '+1,+1',
      'caption': 'Offset(1, 1)',
      'sub': 'Full child shift diag.',
    },
  ];

  final basicWidgets = <Widget>[];
  for (final entry in basicOffsets) {
    basicWidgets.add(
      _captioned(
        child: _refFrame(
          translation: entry['offset'] as Offset,
          color: entry['color'] as Color,
          label: entry['label'] as String,
        ),
        caption: entry['caption'] as String,
        sub: entry['sub'] as String,
      ),
    );
  }
  print('Built ${basicWidgets.length} basic offset cards');

  // ============================================================
  // SECTION 2: transformHitTests explainer
  // ============================================================
  print('--- Section 2: transformHitTests explainer ---');

  final hitTestRows = <Widget>[
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _refFrame(
          translation: const Offset(0.6, -0.3),
          color: const Color(0xFF26A69A),
          label: 'true',
          // ignore: avoid_redundant_argument_values
          transformHitTests: true,
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'transformHitTests: true (default)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Hit testing is performed on the translated position. '
                'A user tapping the visible box hits the box, exactly as '
                'they expect from the painted output.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF4A4458),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    const SizedBox(height: 18.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _refFrame(
          translation: const Offset(0.6, -0.3),
          color: const Color(0xFFC62828),
          label: 'false',
          transformHitTests: false,
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'transformHitTests: false',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                  color: Color(0xFFB71C1C),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Paint is offset but hit testing happens at the original, '
                'untranslated position. Useful for purely decorative shifts '
                'where the original area must still receive input.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF4A4458),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ];

  final hitTestCode = _codePanel(
    label: 'transformHitTests usage',
    code: 'FractionalTranslation(\n'
        '  translation: const Offset(0.6, -0.3),\n'
        '  transformHitTests: true,  // default\n'
        '  child: badge,\n'
        ')\n\n'
        'FractionalTranslation(\n'
        '  translation: const Offset(0.6, -0.3),\n'
        '  transformHitTests: false, // paint-only shift\n'
        '  child: decorativeMark,\n'
        ')',
  );
  print('Built hitTest explainer (${hitTestRows.length} rows)');

  // ============================================================
  // SECTION 3: Fractional vs pixel translation
  // ============================================================
  print('--- Section 3: Fractional vs pixel translation ---');

  Widget pixelFrame() {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE6C97A)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Positioned(
            left: 38.0,
            top: 38.0,
            child: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF8D82A8)),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white.withValues(alpha: 0.4),
              ),
              child: const Center(
                child: Text(
                  'orig',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF72678D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 38.0,
            top: 38.0,
            child: Transform.translate(
              offset: const Offset(22.0, -22.0),
              child: Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFB8C00),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'px',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final compareRow = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    alignment: WrapAlignment.center,
    children: [
      _captioned(
        child: _refFrame(
          translation: const Offset(0.5, -0.5),
          color: const Color(0xFF6A42CC),
          label: 'frac',
        ),
        caption: 'FractionalTranslation',
        sub: 'Offset(0.5, -0.5) of child',
      ),
      _captioned(
        child: pixelFrame(),
        caption: 'Transform.translate',
        sub: 'Offset(22, -22) px',
      ),
    ],
  );

  final compareCode = _codePanel(
    label: 'Fractional vs pixel',
    code: '// fractional — relative to the child\n'
        'FractionalTranslation(\n'
        '  translation: const Offset(0.5, -0.5),\n'
        '  child: badge,\n'
        ')\n\n'
        '// pixel — absolute, ignores child size\n'
        'Transform.translate(\n'
        '  offset: const Offset(22, -22),\n'
        '  child: badge,\n'
        ')',
    accent: const Color(0xFFFFB74D),
  );

  final compareNotes = Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFFFCC80)),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Color(0xFFEF6C00)),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'When the child resizes, fractional offsets follow; pixel '
                'offsets stay constant.',
                style: TextStyle(
                  color: Color(0xFFBF360C),
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            Icon(Icons.architecture, color: Color(0xFFEF6C00)),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Use fractional translation for badges, tooltip nubs and '
                'overlay marks that must scale with the host.',
                style: TextStyle(
                  color: Color(0xFFBF360C),
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Built fractional vs pixel comparison');

  // ============================================================
  // SECTION 4: Real-world recipes
  // ============================================================
  print('--- Section 4: Real-world recipes ---');

  // 4a. Overlapping cards
  Widget cardStack() {
    Widget tile(Color c, String label, Offset translation) {
      return FractionalTranslation(
        translation: translation,
        child: Container(
          width: 110.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 8.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 260.0,
      height: 130.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 30.0,
            top: 30.0,
            child: tile(const Color(0xFF6A42CC), 'Card A',
                const Offset(0.0, 0.0)),
          ),
          Positioned(
            left: 30.0,
            top: 30.0,
            child: tile(
                const Color(0xFF2196F3), 'Card B', const Offset(0.4, 0.2)),
          ),
          Positioned(
            left: 30.0,
            top: 30.0,
            child: tile(
                const Color(0xFFEC407A), 'Card C', const Offset(0.8, 0.4)),
          ),
        ],
      ),
    );
  }

  // 4b. Tooltip nub
  Widget tooltipWithNub() {
    return SizedBox(
      width: 220.0,
      height: 110.0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: const Color(0xFF263238),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Tooltip text',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
          Positioned(
            top: 20.0 + 38.0, // bottom of tooltip box
            child: FractionalTranslation(
              translation: const Offset(0.0, -0.5),
              child: Transform.rotate(
                angle: 0.7853981633974483, // 45°
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  color: const Color(0xFF263238),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4c. Decorative offset corner
  Widget decorativeOffset() {
    return SizedBox(
      width: 200.0,
      height: 120.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 200.0,
            height: 120.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: const Color(0xFFCE93D8)),
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: FractionalTranslation(
              translation: const Offset(0.3, -0.3),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF8E24AA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 14.0,
            top: 18.0,
            child: Text(
              'Featured Card',
              style: TextStyle(
                color: Color(0xFF6A1B9A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            left: 14.0,
            top: 46.0,
            child: SizedBox(
              width: 170.0,
              child: Text(
                'A small NEW chip floats with a fractional offset relative '
                'to its host corner.',
                style: TextStyle(
                  color: Color(0xFF4A148C),
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4d. Sliding tile reveal
  Widget slidingTileReveal() {
    return Container(
      width: 280.0,
      height: 100.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: const Color(0xFFC8E6C9)),
            ),
            const Positioned(
              left: 12.0,
              top: 24.0,
              child: Text(
                'Secret content revealed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
            const Positioned(
              left: 12.0,
              top: 48.0,
              child: Text(
                'Slide the tile to peek',
                style: TextStyle(color: Color(0xFF1B5E20)),
              ),
            ),
            Positioned.fill(
              child: FractionalTranslation(
                translation: const Offset(-0.35, 0.0),
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xFF388E3C)),
                  child: const Center(
                    child: Text(
                      'Drag me',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final realWorldGrid = Wrap(
    spacing: 18.0,
    runSpacing: 18.0,
    alignment: WrapAlignment.center,
    children: [
      _captioned(
        child: cardStack(),
        caption: 'Overlapping cards',
        sub: 'Cascade with Offset(n*0.4, n*0.2)',
      ),
      _captioned(
        child: tooltipWithNub(),
        caption: 'Tooltip nub',
        sub: 'Offset(0, -0.5) on rotated square',
      ),
      _captioned(
        child: decorativeOffset(),
        caption: 'Decorative corner chip',
        sub: 'Offset(0.3, -0.3) from corner',
      ),
      _captioned(
        child: slidingTileReveal(),
        caption: 'Sliding tile reveal',
        sub: 'Offset(-0.35, 0)',
      ),
    ],
  );

  final realWorldCode = _codePanel(
    label: 'Real-world recipes',
    code: '// overlapping cards (cascade)\n'
        'for (final i in [0, 1, 2])\n'
        '  FractionalTranslation(\n'
        '    translation: Offset(i * 0.4, i * 0.2),\n'
        '    child: cardTile,\n'
        '  );\n\n'
        '// tooltip nub: a small rotated square\n'
        '// translated by -½ of its height upward\n'
        'FractionalTranslation(\n'
        '  translation: const Offset(0, -0.5),\n'
        '  child: Transform.rotate(\n'
        '    angle: pi / 4,\n'
        '    child: const SizedBox.square(\n'
        '      dimension: 14,\n'
        '      child: ColoredBox(color: Colors.black87),\n'
        '    ),\n'
        '  ),\n'
        ');',
    accent: const Color(0xFFCE93D8),
  );

  print('Built real-world recipes grid');

  // ============================================================
  // SECTION 5: Animated FractionalTranslation explainer (static frames)
  // ============================================================
  print('--- Section 5: Animated frames explainer ---');

  final frames = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final frameWidgets = <Widget>[];
  for (final t in frames) {
    final dx = -0.5 + t * 1.5; // -0.5 -> 1.0
    frameWidgets.add(
      _captioned(
        child: _refFrame(
          translation: Offset(dx, 0.0),
          color: Color.lerp(
            const Color(0xFF6A42CC),
            const Color(0xFFEC407A),
            t,
          )!,
          label: 't=${t.toStringAsFixed(2)}',
          size: 110.0,
          box: 42.0,
        ),
        caption: 'frame ${(t * 100).toStringAsFixed(0)}%',
        sub: 'dx = ${dx.toStringAsFixed(2)}',
      ),
    );
  }

  final animatedCode = _codePanel(
    label: 'Animated with AnimatedBuilder',
    code: 'AnimatedBuilder(\n'
        '  animation: controller,\n'
        '  builder: (context, child) {\n'
        '    final dx = lerpDouble(-0.5, 1.0, controller.value)!;\n'
        '    return FractionalTranslation(\n'
        '      translation: Offset(dx, 0),\n'
        '      child: child,\n'
        '    );\n'
        '  },\n'
        '  child: const Badge(),\n'
        ');',
    accent: const Color(0xFFFFD180),
  );

  // ============================================================
  // SECTION 6: Behavior table
  // ============================================================
  print('--- Section 6: Behavior table ---');

  TableRow tableRow(String a, String b, String c, {bool header = false}) {
    final style = TextStyle(
      fontWeight: header ? FontWeight.bold : FontWeight.normal,
      color: header ? const Color(0xFF4A2A8C) : const Color(0xFF4A4458),
      fontSize: 12.5,
    );
    Widget cell(String s) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 8.0),
          child: Text(s, style: style),
        );
    return TableRow(
      decoration: header
          ? const BoxDecoration(color: Color(0xFFEDE2FF))
          : null,
      children: [cell(a), cell(b), cell(c)],
    );
  }

  final behaviorTable = Table(
    border: TableBorder.all(color: const Color(0xFFCEBDF4), width: 1.0),
    columnWidths: const {
      0: FlexColumnWidth(1.4),
      1: FlexColumnWidth(2.0),
      2: FlexColumnWidth(2.0),
    },
    children: [
      tableRow('Property', 'FractionalTranslation', 'Transform.translate',
          header: true),
      tableRow('Units', 'fraction of child size', 'absolute pixels'),
      tableRow('Hit testing',
          'configurable via transformHitTests', 'always uses transform'),
      tableRow('Layout', 'no layout change', 'no layout change'),
      tableRow(
          'Resizes with child', 'yes', 'no — stays at fixed pixel offset'),
      tableRow('Typical use', 'badges, tooltip nubs, overlays',
          'pan effects, parallax, drag offsets'),
    ],
  );

  // ============================================================
  // SECTION 7: Final summary panel
  // ============================================================
  print('--- Section 7: Summary ---');

  final summaryPanel = Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        const SizedBox(height: 10.0),
        _summaryItem(
          icon: Icons.zoom_in_map,
          title: 'Fractional offsets',
          desc: 'Translation is expressed in fractions of child size.',
          color: const Color(0xFF6A42CC),
        ),
        _summaryItem(
          icon: Icons.touch_app,
          title: 'transformHitTests',
          desc: 'true → taps follow paint, false → original area receives hits.',
          color: const Color(0xFF00897B),
        ),
        _summaryItem(
          icon: Icons.compare_arrows,
          title: 'Fractional vs pixel',
          desc: 'Fractional adapts to size; Transform.translate is absolute.',
          color: const Color(0xFFEF6C00),
        ),
        _summaryItem(
          icon: Icons.stars,
          title: 'Real-world',
          desc: 'Badges, tooltip nubs, decorative chips, sliding reveals.',
          color: const Color(0xFFC2185B),
        ),
        _summaryItem(
          icon: Icons.animation,
          title: 'Animatable',
          desc: 'Drive Offset with a Tween / AnimatedBuilder for motion.',
          color: const Color(0xFF1565C0),
        ),
      ],
    ),
  );

  // ============================================================
  // Layout — single scroll view with header + numbered sections
  // ============================================================
  final header = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF6A42CC), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33311B92),
          blurRadius: 14.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Colors.white, size: 38.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'RenderFractionalTranslation Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'FractionalTranslation shifts child paint coordinates by fractions '
          'of the child size. Below: basic offsets, hit-test behavior, '
          'fractional-vs-pixel comparison, real-world recipes, animated '
          'frames, and a behavior table.',
          style: TextStyle(color: Color(0xFFE1D5FF), fontSize: 13.0, height: 1.4),
        ),
      ],
    ),
  );

  Widget sectionTitle(String s) => Padding(
        padding: const EdgeInsets.only(top: 22.0, bottom: 6.0),
        child: Text(
          s,
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
      );

  final body = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        sectionTitle('1. Basic Fractional Offsets'),
        _panel(
          title: 'Identity, half-width, mixed and full shifts',
          description:
              'Each frame shows the original "orig" square and the '
              'FractionalTranslation child painted on top. Translation is '
              'expressed as a fraction of the child size, so changing the '
              'child size also changes the visual offset.',
          child: Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            alignment: WrapAlignment.center,
            children: basicWidgets,
          ),
        ),
        _codePanel(
          label: 'Basic API',
          code: 'FractionalTranslation(\n'
              '  translation: const Offset(0.5, 0.0),\n'
              '  child: child,\n'
              ');\n\n'
              '// Offsets used above:\n'
              '//   (0, 0)    -> identity\n'
              '//   (0.5, 0)  -> right half\n'
              '//   (-0.5, .5)-> left half + down half\n'
              '//   (1, 1)    -> shifted one full child diagonally',
        ),
        sectionTitle('2. transformHitTests: true vs false'),
        _panel(
          title: 'Visual offset vs input region',
          description:
              'FractionalTranslation can either move the hit region with the '
              'paint (default) or keep the hit region anchored at the '
              'pre-translation position. This decides where taps land.',
          child: Column(children: hitTestRows),
        ),
        hitTestCode,
        sectionTitle('3. Fractional vs Pixel Translation'),
        _panel(
          title: 'FractionalTranslation vs Transform.translate',
          description:
              'Same visual offset, fundamentally different scaling behavior. '
              'Fractional follows child size, pixel does not.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              compareRow,
              compareCode,
              compareNotes,
            ],
          ),
        ),
        sectionTitle('4. Real-World Recipes'),
        _panel(
          title: 'Common UI patterns powered by fractional offsets',
          description:
              'Badges, tooltip nubs, decorative chips and sliding-tile '
              'reveals all benefit from offsets that scale with the host.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [realWorldGrid, realWorldCode],
          ),
        ),
        sectionTitle('5. Animated Fractional Translation (static frames)'),
        _panel(
          title: 'Frames at t = 0, 0.25, 0.5, 0.75, 1',
          description:
              'A real animation would drive the translation Offset via an '
              'AnimatedBuilder. The static frames below show how the visual '
              'progresses as dx interpolates from -0.5 to 1.0.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 14.0,
                runSpacing: 14.0,
                alignment: WrapAlignment.center,
                children: frameWidgets,
              ),
              animatedCode,
            ],
          ),
        ),
        sectionTitle('6. Behavior Table'),
        _panel(
          title: 'FractionalTranslation vs Transform.translate at a glance',
          description:
              'A quick comparison of the two translation widgets. The same '
              'paint result with different scaling semantics.',
          child: behaviorTable,
        ),
        sectionTitle('7. Summary'),
        summaryPanel,
        const SizedBox(height: 18.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            'Deep demo completed: fractional offsets give responsive, '
            'size-aware translation for badges, overlays, callouts and '
            'micro-layout adjustments — without ever touching layout itself.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF655A7C),
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  print('=== RenderFractionalTranslation Deep Demo built successfully ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF6A42CC),
      scaffoldBackgroundColor: const Color(0xFFF7F4FF),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      body: SafeArea(child: body),
    ),
  );
}
