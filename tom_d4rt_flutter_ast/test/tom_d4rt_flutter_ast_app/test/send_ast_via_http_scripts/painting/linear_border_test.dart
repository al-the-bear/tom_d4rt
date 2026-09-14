// D4rt test script: Tests LinearBorder from painting.
// Deep visual demo of LinearBorder and LinearBorderEdge with hero header,
// anatomy diagram, edge variants, edge-property deep dive, side-width sweep,
// color pairing, lerp snapshots, comparison with other ShapeBorders, real-
// world button/tile examples, RTL/lerp caveats, and a takeaway footer.
import 'package:flutter/material.dart';

// ============================================================
// Top-level helper value classes (no leading underscores on
// instance fields; private to library only).
// ============================================================

class EdgeVariant {
  const EdgeVariant({
    required this.label,
    required this.source,
    required this.description,
    required this.shape,
    required this.tint,
  });

  final String label;
  final String source;
  final String description;
  final LinearBorder shape;
  final Color tint;
}

class SizePanel {
  const SizePanel({
    required this.size,
    required this.title,
    required this.shape,
  });

  final double size;
  final String title;
  final LinearBorder shape;
}

class AlignmentPanel {
  const AlignmentPanel({
    required this.alignment,
    required this.title,
    required this.shape,
  });

  final double alignment;
  final String title;
  final LinearBorder shape;
}

class WidthSweepEntry {
  const WidthSweepEntry({required this.width, required this.shape});

  final double width;
  final LinearBorder shape;
}

class ColorPairing {
  const ColorPairing({
    required this.name,
    required this.surface,
    required this.foreground,
    required this.shape,
  });

  final String name;
  final Color surface;
  final Color foreground;
  final LinearBorder shape;
}

class LerpFrame {
  const LerpFrame({required this.t, required this.shape});

  final double t;
  final ShapeBorder? shape;
}

class ComparisonEntry {
  const ComparisonEntry({
    required this.title,
    required this.shape,
    required this.summary,
  });

  final String title;
  final ShapeBorder shape;
  final String summary;
}

class CaveatEntry {
  const CaveatEntry({required this.heading, required this.body});

  final String heading;
  final String body;
}

dynamic build(BuildContext context) {
  // ============================================================
  // Palette — a teal / emerald scheme that contrasts the indigo
  // showcase used elsewhere in the suite.
  // ============================================================
  const Color paletteTeal = Color(0xFF0F766E);
  const Color paletteEmerald = Color(0xFF059669);
  const Color paletteMint = Color(0xFF10B981);
  const Color paletteSeafoam = Color(0xFF34D399);
  const Color paletteSurface = Color(0xFFECFDF5);
  const Color paletteEdge = Color(0xFF6EE7B7);
  const Color paletteDeep = Color(0xFF064E3B);
  const Color paletteAmber = Color(0xFFF59E0B);
  const Color paletteRose = Color(0xFFE11D48);
  const Color paletteSlate = Color(0xFF475569);

  // ============================================================
  // SECTION 1: Hero header
  // Title strip with multi-stop gradient and two layered shadows.
  // ============================================================

  final Widget heroHeader = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 26.0, 28.0, 26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.45, 0.78, 1.0],
        colors: <Color>[
          paletteDeep,
          paletteTeal,
          paletteEmerald,
          paletteSeafoam,
        ],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: paletteEmerald.withValues(alpha: 0.30),
          blurRadius: 36.0,
          offset: const Offset(0.0, 22.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                Icons.linear_scale,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'LinearBorder',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'A ShapeBorder that paints hairlines along selected edges',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final String tag in const <String>[
              'painting',
              'OutlinedBorder',
              'ShapeBorder',
              'RTL aware',
              'lerp friendly',
            ])
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: const Text(
            "package:flutter/painting.dart  ->  LinearBorder",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram — labelled rectangle with arrows
  // pointing to start / end / top / bottom edges.
  // ============================================================

  Widget edgeLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget arrow(IconData icon) {
    return Icon(icon, size: 22.0, color: paletteSlate);
  }

  final Widget anatomyDiagram = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: paletteSurface,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteEmerald.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of a LinearBorder',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Each edge slot accepts an optional LinearBorderEdge.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            edgeLabel('top', paletteTeal),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            arrow(Icons.arrow_downward),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                edgeLabel('start', paletteEmerald),
                const SizedBox(height: 4.0),
                arrow(Icons.arrow_forward),
              ],
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                height: 110.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: paletteDeep, width: 1.4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'rectangle',
                  style: TextStyle(
                    color: paletteDeep,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                arrow(Icons.arrow_back),
                const SizedBox(height: 4.0),
                edgeLabel('end', paletteEmerald),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            arrow(Icons.arrow_upward),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            edgeLabel('bottom', paletteTeal),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: const Text(
            "LinearBorder(\n"
            "  side: BorderSide(color: ..., width: ...),\n"
            "  start: LinearBorderEdge(size: ..., alignment: ...),\n"
            "  end:    LinearBorderEdge(size: ..., alignment: ...),\n"
            "  top:    LinearBorderEdge(size: ..., alignment: ...),\n"
            "  bottom: LinearBorderEdge(size: ..., alignment: ...),\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: paletteDeep,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Edge variants showcase
  // Wrap of 4 cards; each renders a button using one of the
  // convenience constructors and shows source code + description.
  // ============================================================

  final List<EdgeVariant> edgeVariants = <EdgeVariant>[
    EdgeVariant(
      label: 'LinearBorder.start',
      source: 'LinearBorder.start(\n'
          '  side: BorderSide(color: teal, width: 2),\n'
          ')',
      description:
          'Paints a single hairline along the leading edge. In LTR layouts '
          'this is the left side; in RTL layouts it flips automatically. '
          'Useful for highlighting active list rows or section markers.',
      shape: LinearBorder.start(
        side: BorderSide(color: paletteTeal, width: 2.0),
      ),
      tint: paletteTeal,
    ),
    EdgeVariant(
      label: 'LinearBorder.end',
      source: 'LinearBorder.end(\n'
          '  side: BorderSide(color: emerald, width: 2),\n'
          ')',
      description:
          'Mirror of .start: paints the trailing edge only. Good for '
          'right-aligned chips or badges that need a thin terminator without '
          'enclosing the full bounds of the widget.',
      shape: LinearBorder.end(
        side: BorderSide(color: paletteEmerald, width: 2.0),
      ),
      tint: paletteEmerald,
    ),
    EdgeVariant(
      label: 'LinearBorder.top',
      source: 'LinearBorder.top(\n'
          '  side: BorderSide(color: mint, width: 2),\n'
          ')',
      description:
          'Renders only the top edge. Frequently used to create grouped '
          'visual containers — a card whose top edge is accented while the '
          'remaining sides are flush against neighbour content.',
      shape: LinearBorder.top(
        side: BorderSide(color: paletteMint, width: 2.0),
      ),
      tint: paletteMint,
    ),
    EdgeVariant(
      label: 'LinearBorder.bottom',
      source: 'LinearBorder.bottom(\n'
          '  side: BorderSide(color: deep, width: 2),\n'
          ')',
      description:
          'Renders only the bottom edge. The classic choice for tab '
          'indicators and underlined buttons. Combines well with InkWell '
          'and FilledButton.tonal styling.',
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 2.0),
      ),
      tint: paletteDeep,
    ),
  ];

  Widget edgeVariantCard(EdgeVariant v) {
    return Container(
      width: 280.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: v.tint.withValues(alpha: 0.35), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: v.tint.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: v.tint,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  v.label,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: paletteDeep,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              shape: v.shape,
              foregroundColor: v.tint,
              side: BorderSide(color: v.tint, width: 2.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 14.0,
              ),
            ),
            child: const Text('Demonstrate'),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: paletteSurface,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: paletteEdge, width: 1.0),
            ),
            child: Text(
              v.source,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: paletteDeep,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            v.description,
            style: TextStyle(
              fontSize: 12.5,
              color: paletteSlate,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget edgeVariantsSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteEmerald.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Edge variant constructors',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each convenience constructor shortcuts a single-edge LinearBorder.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final EdgeVariant v in edgeVariants) edgeVariantCard(v),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: LinearBorderEdge deep dive
  // (a) size sweep at 0.25, 0.5, 0.75, 1.0
  // (b) alignment sweep at -1.0, 0.0, 1.0
  // ============================================================

  final List<SizePanel> sizePanels = <SizePanel>[
    SizePanel(
      size: 0.25,
      title: 'size: 0.25',
      shape: LinearBorder(
        side: BorderSide(color: paletteTeal, width: 2.5),
        bottom: const LinearBorderEdge(size: 0.25, alignment: 0.0),
      ),
    ),
    SizePanel(
      size: 0.50,
      title: 'size: 0.50',
      shape: LinearBorder(
        side: BorderSide(color: paletteEmerald, width: 2.5),
        bottom: const LinearBorderEdge(size: 0.50, alignment: 0.0),
      ),
    ),
    SizePanel(
      size: 0.75,
      title: 'size: 0.75',
      shape: LinearBorder(
        side: BorderSide(color: paletteMint, width: 2.5),
        bottom: const LinearBorderEdge(size: 0.75, alignment: 0.0),
      ),
    ),
    SizePanel(
      size: 1.00,
      title: 'size: 1.00',
      shape: LinearBorder(
        side: BorderSide(color: paletteDeep, width: 2.5),
        bottom: const LinearBorderEdge(size: 1.00, alignment: 0.0),
      ),
    ),
  ];

  Widget sizePanel(SizePanel p) {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteEdge, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            p.title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: paletteDeep,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: p.shape,
              shadows: <BoxShadow>[
                BoxShadow(
                  color: paletteTeal.withValues(alpha: 0.10),
                  blurRadius: 4.0,
                  offset: const Offset(0.0, 2.0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 18.0,
            ),
            alignment: Alignment.center,
            child: Text(
              '${(p.size * 100).round()}%',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: paletteDeep,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Bottom edge fills ${(p.size * 100).round()}% of available width.',
            style: TextStyle(fontSize: 11.5, color: paletteSlate, height: 1.3),
          ),
        ],
      ),
    );
  }

  final List<AlignmentPanel> alignmentPanels = <AlignmentPanel>[
    AlignmentPanel(
      alignment: -1.0,
      title: 'alignment: -1.0',
      shape: LinearBorder(
        side: BorderSide(color: paletteTeal, width: 3.0),
        bottom: const LinearBorderEdge(size: 0.4, alignment: -1.0),
      ),
    ),
    AlignmentPanel(
      alignment: 0.0,
      title: 'alignment:  0.0',
      shape: LinearBorder(
        side: BorderSide(color: paletteEmerald, width: 3.0),
        bottom: const LinearBorderEdge(size: 0.4, alignment: 0.0),
      ),
    ),
    AlignmentPanel(
      alignment: 1.0,
      title: 'alignment:  1.0',
      shape: LinearBorder(
        side: BorderSide(color: paletteMint, width: 3.0),
        bottom: const LinearBorderEdge(size: 0.4, alignment: 1.0),
      ),
    ),
  ];

  Widget alignmentPanel(AlignmentPanel p) {
    return Container(
      width: 230.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteEdge, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            p.title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: paletteDeep,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: ShapeDecoration(
              color: paletteSurface,
              shape: p.shape,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 22.0,
            ),
            alignment: Alignment.center,
            child: Text(
              p.alignment.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: paletteDeep,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            p.alignment < 0.0
                ? 'Anchored at the leading edge.'
                : (p.alignment > 0.0
                    ? 'Anchored at the trailing edge.'
                    : 'Centered along the edge.'),
            style: TextStyle(fontSize: 11.5, color: paletteSlate, height: 1.3),
          ),
        ],
      ),
    );
  }

  final Widget edgePropertyDeepDive = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteEmerald.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'LinearBorderEdge deep dive',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each LinearBorderEdge is parameterised by size (0..1) and '
          'alignment (-1..1).',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: paletteSurface,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: Text(
            'size sweep — width portion of the edge',
            style: TextStyle(
              fontSize: 12.0,
              color: paletteDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final SizePanel p in sizePanels) sizePanel(p),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: paletteSurface,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: Text(
            'alignment sweep — anchor of the edge segment',
            style: TextStyle(
              fontSize: 12.0,
              color: paletteDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final AlignmentPanel p in alignmentPanels) alignmentPanel(p),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: BorderSide width sweep
  // 0.5, 1.0, 1.5, 2.5, 4.0
  // ============================================================

  final List<WidthSweepEntry> widths = <WidthSweepEntry>[
    WidthSweepEntry(
      width: 0.5,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 0.5),
      ),
    ),
    WidthSweepEntry(
      width: 1.0,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 1.0),
      ),
    ),
    WidthSweepEntry(
      width: 1.5,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 1.5),
      ),
    ),
    WidthSweepEntry(
      width: 2.5,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 2.5),
      ),
    ),
    WidthSweepEntry(
      width: 4.0,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteDeep, width: 4.0),
      ),
    ),
  ];

  Widget widthEntry(WidthSweepEntry w) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            shape: w.shape,
            foregroundColor: paletteDeep,
            side: BorderSide(color: paletteDeep, width: w.width),
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 14.0,
            ),
          ),
          child: Text('w=${w.width}'),
        ),
        const SizedBox(height: 6.0),
        Text(
          '${w.width.toStringAsFixed(1)} px',
          style: TextStyle(
            fontSize: 11.0,
            color: paletteSlate,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  final Widget widthSweepSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          paletteSurface,
          Colors.white,
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BorderSide width sweep',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'A LinearBorder respects BorderSide.width — sweep five buttons '
          'from 0.5 to 4.0 px.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 18.0,
          runSpacing: 14.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (final WidthSweepEntry w in widths) widthEntry(w),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Color / surface pairing
  // 6 buttons each with a different BorderSide color, illustrating
  // how the same edge reads on light / dark / accent surfaces.
  // ============================================================

  final List<ColorPairing> colorPairings = <ColorPairing>[
    ColorPairing(
      name: 'teal on white',
      surface: Colors.white,
      foreground: paletteTeal,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteTeal, width: 2.0),
      ),
    ),
    ColorPairing(
      name: 'emerald on mint',
      surface: paletteSurface,
      foreground: paletteEmerald,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteEmerald, width: 2.0),
      ),
    ),
    ColorPairing(
      name: 'amber on deep',
      surface: paletteDeep,
      foreground: paletteAmber,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteAmber, width: 2.0),
      ),
    ),
    ColorPairing(
      name: 'rose on slate',
      surface: paletteSlate,
      foreground: paletteRose,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteRose, width: 2.0),
      ),
    ),
    ColorPairing(
      name: 'white on emerald',
      surface: paletteEmerald,
      foreground: Colors.white,
      shape: const LinearBorder(
        side: BorderSide(color: Colors.white, width: 2.0),
        bottom: LinearBorderEdge(size: 1.0, alignment: 0.0),
      ),
    ),
    ColorPairing(
      name: 'mint on deep',
      surface: paletteDeep,
      foreground: paletteSeafoam,
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteSeafoam, width: 2.0),
      ),
    ),
  ];

  Widget colorPairingCard(ColorPairing p) {
    final bool darkSurface =
        ThemeData.estimateBrightnessForColor(p.surface) == Brightness.dark;
    final Color label = darkSurface ? Colors.white : paletteDeep;
    return Container(
      width: 220.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            p.name,
            style: TextStyle(
              fontSize: 12.0,
              color: label.withValues(alpha: 0.85),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              shape: p.shape,
              foregroundColor: p.foreground,
              side: BorderSide(color: p.foreground, width: 2.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
            child: const Text('Action'),
          ),
        ],
      ),
    );
  }

  final Widget colorPairingSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Color / surface pairings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Same shape, different palette. Reads well on light or dark '
          'surfaces when contrast is preserved.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final ColorPairing p in colorPairings) colorPairingCard(p),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Lerp showcase
  // Static frames of LinearBorder.lerp(a, b, t) at t in
  // {0.0, 0.25, 0.5, 0.75, 1.0}. No animation.
  // ============================================================

  final LinearBorder lerpA = LinearBorder(
    side: BorderSide(color: paletteTeal, width: 1.0),
    bottom: const LinearBorderEdge(size: 0.20, alignment: -1.0),
  );

  final LinearBorder lerpB = LinearBorder(
    side: BorderSide(color: paletteRose, width: 4.0),
    bottom: const LinearBorderEdge(size: 1.0, alignment: 1.0),
  );

  final List<LerpFrame> lerpFrames = <LerpFrame>[
    LerpFrame(t: 0.00, shape: ShapeBorder.lerp(lerpA, lerpB, 0.00)),
    LerpFrame(t: 0.25, shape: ShapeBorder.lerp(lerpA, lerpB, 0.25)),
    LerpFrame(t: 0.50, shape: ShapeBorder.lerp(lerpA, lerpB, 0.50)),
    LerpFrame(t: 0.75, shape: ShapeBorder.lerp(lerpA, lerpB, 0.75)),
    LerpFrame(t: 1.00, shape: ShapeBorder.lerp(lerpA, lerpB, 1.00)),
  ];

  Widget lerpFrameCard(LerpFrame frame) {
    final ShapeBorder? shape = frame.shape;
    return Container(
      width: 150.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: paletteEdge, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            't = ${frame.t.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: paletteDeep,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8.0),
          if (shape != null)
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: shape,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 18.0,
              ),
              alignment: Alignment.center,
              child: Text(
                'frame',
                style: TextStyle(
                  fontSize: 13.0,
                  color: paletteDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Text(
                'null',
                style: TextStyle(
                  fontSize: 13.0,
                  color: paletteSlate,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const SizedBox(height: 6.0),
          Text(
            shape == null
                ? 'lerp returned null'
                : shape.runtimeType.toString(),
            style: TextStyle(
              fontSize: 10.5,
              color: paletteSlate,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  final Widget lerpShowcaseSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          paletteSurface,
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Static lerp snapshots',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Five frames of ShapeBorder.lerp(a, b, t) (which routes through '
          'LinearBorder.lerpFrom / lerpTo) at evenly spaced t values. No '
          'animation — these are pure interpolation snapshots.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteDeep,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            "a = LinearBorder(side: teal/1.0,  bottom: size 0.20, align -1.0)\n"
            "b = LinearBorder(side: rose/4.0, bottom: size 1.00, align +1.0)",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final LerpFrame f in lerpFrames) lerpFrameCard(f),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Comparison panel — LinearBorder vs other borders
  // ============================================================

  final List<ComparisonEntry> comparisonEntries = <ComparisonEntry>[
    ComparisonEntry(
      title: 'LinearBorder.bottom',
      shape: LinearBorder.bottom(
        side: BorderSide(color: paletteTeal, width: 2.0),
      ),
      summary:
          'Hairline only on the bottom edge. Hugs other borders flush — great '
          'for tab indicators or list separators.',
    ),
    ComparisonEntry(
      title: 'OutlineInputBorder',
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: paletteTeal, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      summary:
          'Full rounded rectangle outline. Built for text fields; reserves '
          'space for label notches.',
    ),
    ComparisonEntry(
      title: 'RoundedRectangleBorder',
      shape: RoundedRectangleBorder(
        side: BorderSide(color: paletteTeal, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      summary:
          'Standard rounded rectangle outline; always closes around the full '
          'shape — no per-edge selectivity.',
    ),
    ComparisonEntry(
      title: 'BeveledRectangleBorder',
      shape: BeveledRectangleBorder(
        side: BorderSide(color: paletteTeal, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      summary:
          'Like rounded, but corners are straight 45° bevels rather than '
          'arcs. Always all four edges.',
    ),
    ComparisonEntry(
      title: 'StadiumBorder',
      shape: StadiumBorder(
        side: BorderSide(color: paletteTeal, width: 2.0),
      ),
      summary:
          'Pill-shaped border with hemispherical caps. Always closed; cannot '
          'isolate edges.',
    ),
  ];

  Widget comparisonCard(ComparisonEntry entry) {
    return Container(
      width: 240.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: paletteEdge, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: paletteEmerald.withValues(alpha: 0.10),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            entry.title,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: paletteDeep,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: ShapeDecoration(
              color: paletteSurface,
              shape: entry.shape,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 18.0,
            ),
            alignment: Alignment.center,
            child: Text(
              'sample',
              style: TextStyle(
                fontSize: 13.0,
                color: paletteDeep,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            entry.summary,
            style: TextStyle(
              fontSize: 11.5,
              color: paletteSlate,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparisonSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'LinearBorder vs other ShapeBorders',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Same content rendered with five different ShapeBorders for visual '
          'comparison.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final ComparisonEntry e in comparisonEntries)
              comparisonCard(e),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world examples
  // (a) Cancel / Confirm pair with start/end accents
  // (b) Tab strip with LinearBorder.bottom indicator
  // (c) ListTile-style row with start accent
  // ============================================================

  final Widget cancelButton = OutlinedButton(
    onPressed: null,
    style: OutlinedButton.styleFrom(
      shape: LinearBorder.start(
        side: BorderSide(color: paletteRose, width: 3.0),
      ),
      foregroundColor: paletteRose,
      side: BorderSide(color: paletteRose, width: 3.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 26.0,
        vertical: 14.0,
      ),
    ),
    child: const Text('Cancel'),
  );

  final Widget confirmButton = FilledButton(
    onPressed: null,
    style: FilledButton.styleFrom(
      shape: LinearBorder.end(
        side: BorderSide(color: paletteDeep, width: 3.0),
      ),
      backgroundColor: paletteEmerald,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 26.0,
        vertical: 14.0,
      ),
    ),
    child: const Text('Confirm'),
  );

  Widget tabEntry({required String label, required bool active}) {
    return Container(
      decoration: ShapeDecoration(
        shape: active
            ? LinearBorder.bottom(
                side: BorderSide(color: paletteEmerald, width: 3.0),
              )
            : LinearBorder.bottom(
                side: BorderSide(
                  color: paletteEdge.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 12.0,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.0,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          color: active ? paletteDeep : paletteSlate,
        ),
      ),
    );
  }

  final Widget tabStrip = Row(
    children: <Widget>[
      tabEntry(label: 'Overview', active: true),
      tabEntry(label: 'Details', active: false),
      tabEntry(label: 'History', active: false),
      tabEntry(label: 'Settings', active: false),
    ],
  );

  Widget listRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: ShapeDecoration(
        color: paletteSurface,
        shape: LinearBorder.start(
          side: BorderSide(color: paletteEmerald, width: 3.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 12.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: paletteEmerald.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 20.0, color: paletteEmerald),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: paletteDeep,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: paletteSlate,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 20.0, color: paletteSlate),
        ],
      ),
    );
  }

  final Widget realWorldSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          paletteSurface,
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteEmerald.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Real-world examples',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Cancel/Confirm pair, tab strip, and a list row — each anchored '
          'with selective edges.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Action pair',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: paletteDeep,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  cancelButton,
                  const SizedBox(width: 14.0),
                  confirmButton,
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Cancel uses .start (leading edge accent in the destructive '
                'rose), Confirm uses .end (trailing edge accent in deep '
                'emerald).',
                style: TextStyle(fontSize: 11.5, color: paletteSlate),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Tab strip',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: paletteDeep,
                ),
              ),
              const SizedBox(height: 10.0),
              tabStrip,
              const SizedBox(height: 8.0),
              Text(
                'Active tab uses LinearBorder.bottom with a thicker '
                'BorderSide — inactive tabs share a lighter divider.',
                style: TextStyle(fontSize: 11.5, color: paletteSlate),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteEdge, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'List rows with leading accent',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: paletteDeep,
                ),
              ),
              const SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  listRow(
                    icon: Icons.flash_on,
                    title: 'Quick action',
                    subtitle: 'Trigger common task',
                  ),
                  const SizedBox(height: 8.0),
                  listRow(
                    icon: Icons.settings,
                    title: 'Configure',
                    subtitle: 'Adjust workspace settings',
                  ),
                  const SizedBox(height: 8.0),
                  listRow(
                    icon: Icons.cloud_upload,
                    title: 'Sync now',
                    subtitle: 'Push pending changes',
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Each row uses LinearBorder.start to draw a vertical accent '
                'on the leading edge — a more delicate alternative to a '
                'full rounded rectangle.',
                style: TextStyle(fontSize: 11.5, color: paletteSlate),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Caveats — theming, RTL, and lerp identity
  // ============================================================

  final List<CaveatEntry> caveats = <CaveatEntry>[
    const CaveatEntry(
      heading: 'Theming considerations',
      body:
          'LinearBorder draws using the BorderSide.color you supply directly '
          '— it does not consult ThemeData like Material primary/onPrimary. '
          'When integrating with theming you typically derive the color from '
          'Theme.of(context).colorScheme yourself and pass it explicitly.',
    ),
    const CaveatEntry(
      heading: 'RTL behaviour for start / end',
      body:
          'The start and end edges are directional — LinearBorder reads the '
          'ambient TextDirection. In LTR layouts start == left and end == '
          'right; in RTL these swap automatically. Use top / bottom when you '
          'need physical edges that do NOT mirror under RTL.',
    ),
    const CaveatEntry(
      heading: 'Lerp identity rules',
      body:
          'Use ShapeBorder.lerp(a, b, t) which dispatches to LinearBorder. '
          'lerpFrom / lerpTo. Lerping with a null input collapses the border '
          'gracefully; lerping between two LinearBorders interpolates side '
          'and each edge slot independently.',
    ),
    const CaveatEntry(
      heading: 'Mixing with Material',
      body:
          'When a LinearBorder is used as the shape of a Material '
          '(FilledButton, Card, etc.), the Material may still draw its own '
          'background fill. Combine the LinearBorder shape with '
          'shape-aware decoration so background and border stay in sync.',
    ),
    const CaveatEntry(
      heading: 'Hit testing',
      body:
          'LinearBorder is a shape only — it does not change hit-testing '
          'bounds. Even when only a partial edge is drawn, the underlying '
          'widget remains hit-testable across its full rectangular bounds.',
    ),
  ];

  Widget caveatCard(CaveatEntry c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: paletteEdge.withValues(alpha: 0.7),
          width: 1.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: paletteEmerald.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: paletteAmber.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.info_outline,
              size: 18.0,
              color: paletteAmber,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  c.heading,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: paletteDeep,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  c.body,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: paletteSlate,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget caveatsSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paletteSurface,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Caveats and pitfalls',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: paletteDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Watch points when adopting LinearBorder in a real codebase.',
          style: TextStyle(fontSize: 12.5, color: paletteSlate),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: <Widget>[
            for (final CaveatEntry c in caveats) caveatCard(c),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Footer — takeaways
  // ============================================================

  Widget takeawayPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24.0, 22.0, 24.0, 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          paletteDeep,
          paletteTeal,
          paletteEmerald,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteDeep.withValues(alpha: 0.40),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.bookmark_border, color: Colors.white, size: 26.0),
            const SizedBox(width: 10.0),
            const Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'LinearBorder lets you paint hairline accents on selected edges '
          'instead of enclosing the full shape. Pick the right edge for the '
          'job and let LinearBorderEdge.size and alignment fine-tune the '
          'visual weight.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            takeawayPill('selective edges'),
            takeawayPill('directional start/end'),
            takeawayPill('lerp friendly'),
            takeawayPill('tab indicators'),
            takeawayPill('list accents'),
            takeawayPill('hairline aesthetics'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Compose all sections inside a Scaffold + SingleChildScrollView
  // ============================================================

  Widget sectionSpacer() => const SizedBox(height: 22.0);

  return Scaffold(
    backgroundColor: paletteSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          sectionSpacer(),
          anatomyDiagram,
          sectionSpacer(),
          edgeVariantsSection,
          sectionSpacer(),
          edgePropertyDeepDive,
          sectionSpacer(),
          widthSweepSection,
          sectionSpacer(),
          colorPairingSection,
          sectionSpacer(),
          lerpShowcaseSection,
          sectionSpacer(),
          comparisonSection,
          sectionSpacer(),
          realWorldSection,
          sectionSpacer(),
          caveatsSection,
          sectionSpacer(),
          footer,
        ],
      ),
    ),
  );
}
