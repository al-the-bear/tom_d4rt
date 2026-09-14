// D4rt test script: Deep Demo - Border / BorderSide / BoxBorder
// Comprehensive visual demonstration of border + shape APIs:
// Border, BorderSide, BoxBorder, Border.all, Border.symmetric,
// BorderDirectional, BorderRadius, RoundedRectangleBorder, CircleBorder,
// StadiumBorder, BeveledRectangleBorder, ContinuousRectangleBorder.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE
  // ===========================================================================

  const Color paletteInk = Color(0xFF15171F);
  const Color paletteInkSoft = Color(0xFF454A5A);
  const Color paletteAccent = Color(0xFF4F46E5);
  const Color paletteAccentSoft = Color(0xFFE0E7FF);
  const Color paletteRose = Color(0xFFE11D74);
  const Color paletteRoseSoft = Color(0xFFFCE4EC);
  const Color paletteTeal = Color(0xFF0F766E);
  const Color paletteTealSoft = Color(0xFFCCFBF1);
  const Color paletteAmber = Color(0xFFB45309);
  const Color paletteAmberSoft = Color(0xFFFEF3C7);
  const Color paletteCrimson = Color(0xFFB91C1C);
  const Color paletteCrimsonSoft = Color(0xFFFEE2E2);
  const Color paletteEmerald = Color(0xFF047857);
  const Color paletteEmeraldSoft = Color(0xFFD1FAE5);
  const Color paletteSlate = Color(0xFF334155);
  const Color paletteSlateSoft = Color(0xFFE2E8F0);
  const Color paletteIndigo = Color(0xFF312E81);
  const Color paletteIndigoSoft = Color(0xFFE0E7FF);
  const Color paletteSurface = Color(0xFFF8FAFC);
  const Color paletteSurfaceAlt = Color(0xFFF1F5F9);
  const Color paletteOutline = Color(0xFFCBD5E1);

  // ===========================================================================
  // SHARED HELPERS
  // ===========================================================================

  Widget buildSectionHeader({
    required int number,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 4.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.92),
            color.withValues(alpha: 0.62),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1.4,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'SECTION ${number.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 11.0,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNarrative(String text, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: (color ?? paletteSurfaceAlt).withValues(alpha: 0.6),
        // No borderRadius: the Border below is non-uniform (left-side only),
        // and BoxDecoration asserts uniform colors when borderRadius is set.
        border: const Border(
          left: BorderSide(color: paletteAccent, width: 4.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: paletteInk,
          fontSize: 13.0,
          height: 1.5,
        ),
      ),
    );
  }

  Widget buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: border, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: border.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: const TextStyle(
              color: paletteInkSoft,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12.0),
          child,
        ],
      ),
    );
  }

  Widget swatchTile({
    required Widget content,
    required String caption,
    Color? captionColor,
  }) {
    return Container(
      width: 170.0,
      margin: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          content,
          const SizedBox(height: 6.0),
          Text(
            caption,
            style: TextStyle(
              color: captionColor ?? paletteInkSoft,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1E1B4B),
          Color(0xFF4338CA),
          Color(0xFF9333EA),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.crop_square,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Border + Shape — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'BorderSide, Border, BorderDirectional, BorderRadius, '
                    'RoundedRectangleBorder, CircleBorder, StadiumBorder, '
                    'BeveledRectangleBorder, ContinuousRectangleBorder — '
                    'every shape rendered live by D4rt.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            buildBadge('Border', Colors.white),
            buildBadge('BorderSide', Colors.white),
            buildBadge('Border.all', Colors.white),
            buildBadge('Border.symmetric', Colors.white),
            buildBadge('BorderDirectional', Colors.white),
            buildBadge('BorderRadius', Colors.white),
            buildBadge('CircleBorder', Colors.white),
            buildBadge('StadiumBorder', Colors.white),
            buildBadge('BeveledRectangleBorder', Colors.white),
            buildBadge('ContinuousRectangleBorder', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 — Border.all variants: width
  // ===========================================================================

  Widget borderAllSwatch(double width, Color color) {
    return Container(
      width: 110.0,
      height: 90.0,
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: width),
      ),
      alignment: Alignment.center,
      child: Text(
        '${width.toStringAsFixed(1)} px',
        style: TextStyle(
          color: color,
          fontSize: 13.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final List<double> section1Widths = <double>[
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    4.5,
    6.0,
    8.0,
    10.0,
    14.0,
  ];

  final List<Widget> section1Tiles = List<Widget>.generate(
    section1Widths.length,
    (int i) {
      final double w = section1Widths[i];
      final List<Color> palette = <Color>[
        paletteAccent,
        paletteRose,
        paletteTeal,
        paletteAmber,
        paletteCrimson,
        paletteEmerald,
        paletteSlate,
        paletteIndigo,
        paletteAccent,
        paletteRose,
      ];
      return swatchTile(
        content: borderAllSwatch(w, palette[i % palette.length]),
        caption: 'Border.all width ${w.toStringAsFixed(1)}',
      );
    },
  );

  final Widget section1Grid = Wrap(children: section1Tiles);

  // ===========================================================================
  // SECTION 2 — Border.all variants: color + style
  // ===========================================================================

  Widget styleSwatch({
    required Color color,
    required double width,
    required BorderStyle style,
    required String label,
  }) {
    return Container(
      width: 130.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: width, style: style),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final Widget section2Grid = Wrap(
    children: <Widget>[
      swatchTile(
        content: styleSwatch(
          color: paletteAccent,
          width: 2.0,
          style: BorderStyle.solid,
          label: 'solid 2.0',
        ),
        caption: 'BorderStyle.solid',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteRose,
          width: 4.0,
          style: BorderStyle.solid,
          label: 'solid 4.0',
        ),
        caption: 'thicker solid',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteTeal,
          width: 1.0,
          style: BorderStyle.none,
          label: 'none 1.0',
        ),
        caption: 'BorderStyle.none',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteAmber,
          width: 0.0,
          style: BorderStyle.solid,
          label: 'hairline 0.0',
        ),
        caption: 'width 0 hairline',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteCrimson,
          width: 5.0,
          style: BorderStyle.solid,
          label: 'solid 5.0',
        ),
        caption: 'heavy crimson',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteEmerald,
          width: 3.0,
          style: BorderStyle.solid,
          label: 'solid 3.0',
        ),
        caption: 'emerald edge',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteSlate,
          width: 6.0,
          style: BorderStyle.solid,
          label: 'solid 6.0',
        ),
        caption: 'slate frame',
      ),
      swatchTile(
        content: styleSwatch(
          color: paletteIndigo,
          width: 2.5,
          style: BorderStyle.solid,
          label: 'solid 2.5',
        ),
        caption: 'indigo accent',
      ),
    ],
  );

  // ===========================================================================
  // SECTION 3 — Border with different top/bottom/left/right BorderSides
  // ===========================================================================

  Widget perSideTile({
    required String title,
    required Border border,
    required Color fill,
  }) {
    return Container(
      width: 200.0,
      height: 110.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: fill,
        border: border,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: paletteInk,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  final Widget section3Grid = Wrap(
    children: <Widget>[
      perSideTile(
        title: 'top only (rose 4px)',
        border: const Border(
          top: BorderSide(color: paletteRose, width: 4.0),
        ),
        fill: paletteRoseSoft,
      ),
      perSideTile(
        title: 'bottom only (teal 5px)',
        border: const Border(
          bottom: BorderSide(color: paletteTeal, width: 5.0),
        ),
        fill: paletteTealSoft,
      ),
      perSideTile(
        title: 'left only (amber 6px)',
        border: const Border(
          left: BorderSide(color: paletteAmber, width: 6.0),
        ),
        fill: paletteAmberSoft,
      ),
      perSideTile(
        title: 'right only (crimson 3px)',
        border: const Border(
          right: BorderSide(color: paletteCrimson, width: 3.0),
        ),
        fill: paletteCrimsonSoft,
      ),
      perSideTile(
        title: 'top + bottom (emerald 4px)',
        border: const Border(
          top: BorderSide(color: paletteEmerald, width: 4.0),
          bottom: BorderSide(color: paletteEmerald, width: 4.0),
        ),
        fill: paletteEmeraldSoft,
      ),
      perSideTile(
        title: 'left + right (slate 4px)',
        border: const Border(
          left: BorderSide(color: paletteSlate, width: 4.0),
          right: BorderSide(color: paletteSlate, width: 4.0),
        ),
        fill: paletteSlateSoft,
      ),
      perSideTile(
        title: 'mixed colour quartet',
        border: const Border(
          top: BorderSide(color: paletteAccent, width: 3.0),
          right: BorderSide(color: paletteRose, width: 3.0),
          bottom: BorderSide(color: paletteTeal, width: 3.0),
          left: BorderSide(color: paletteAmber, width: 3.0),
        ),
        fill: paletteSurface,
      ),
      perSideTile(
        title: 'mixed width quartet',
        border: const Border(
          top: BorderSide(color: paletteIndigo, width: 1.0),
          right: BorderSide(color: paletteIndigo, width: 2.0),
          bottom: BorderSide(color: paletteIndigo, width: 4.0),
          left: BorderSide(color: paletteIndigo, width: 8.0),
        ),
        fill: paletteIndigoSoft,
      ),
      perSideTile(
        title: 'three sides (no top)',
        border: const Border(
          right: BorderSide(color: paletteAccent, width: 3.0),
          bottom: BorderSide(color: paletteAccent, width: 3.0),
          left: BorderSide(color: paletteAccent, width: 3.0),
        ),
        fill: paletteAccentSoft,
      ),
      perSideTile(
        title: 'three sides (no bottom)',
        border: const Border(
          top: BorderSide(color: paletteRose, width: 3.0),
          right: BorderSide(color: paletteRose, width: 3.0),
          left: BorderSide(color: paletteRose, width: 3.0),
        ),
        fill: paletteRoseSoft,
      ),
      perSideTile(
        title: 'thick top accent',
        border: const Border(
          top: BorderSide(color: paletteCrimson, width: 10.0),
          bottom: BorderSide(color: paletteOutline, width: 1.0),
          left: BorderSide(color: paletteOutline, width: 1.0),
          right: BorderSide(color: paletteOutline, width: 1.0),
        ),
        fill: paletteSurface,
      ),
      perSideTile(
        title: 'accent rail (left thick)',
        border: const Border(
          top: BorderSide(color: paletteOutline, width: 1.0),
          bottom: BorderSide(color: paletteOutline, width: 1.0),
          left: BorderSide(color: paletteTeal, width: 8.0),
          right: BorderSide(color: paletteOutline, width: 1.0),
        ),
        fill: paletteTealSoft,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 4 — Border.symmetric
  // ===========================================================================

  Widget symmetricTile({
    required String title,
    required Border border,
    required Color fill,
    required Color titleColor,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: fill,
        border: border,
        // No borderRadius: most callers pass Border.symmetric variants that
        // leave one axis as BorderSide.none, producing non-uniform colors.
        // BoxDecoration would then assert.
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: titleColor,
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final Widget section4Grid = Wrap(
    children: <Widget>[
      symmetricTile(
        title: 'symmetric vertical 4px',
        border: const Border.symmetric(
          vertical: BorderSide(color: paletteAccent, width: 4.0),
        ),
        fill: paletteAccentSoft,
        titleColor: paletteAccent,
      ),
      symmetricTile(
        title: 'symmetric horizontal 4px',
        border: const Border.symmetric(
          horizontal: BorderSide(color: paletteRose, width: 4.0),
        ),
        fill: paletteRoseSoft,
        titleColor: paletteRose,
      ),
      symmetricTile(
        title: 'symmetric h+v',
        border: const Border.symmetric(
          vertical: BorderSide(color: paletteTeal, width: 3.0),
          horizontal: BorderSide(color: paletteEmerald, width: 3.0),
        ),
        fill: paletteTealSoft,
        titleColor: paletteTeal,
      ),
      symmetricTile(
        title: 'thin vertical 1px',
        border: const Border.symmetric(
          vertical: BorderSide(color: paletteAmber, width: 1.0),
        ),
        fill: paletteAmberSoft,
        titleColor: paletteAmber,
      ),
      symmetricTile(
        title: 'thick horizontal 8px',
        border: const Border.symmetric(
          horizontal: BorderSide(color: paletteCrimson, width: 8.0),
        ),
        fill: paletteCrimsonSoft,
        titleColor: paletteCrimson,
      ),
      symmetricTile(
        title: 'soft slate frame',
        border: const Border.symmetric(
          vertical: BorderSide(color: paletteSlate, width: 2.0),
          horizontal: BorderSide(color: paletteSlate, width: 2.0),
        ),
        fill: paletteSlateSoft,
        titleColor: paletteSlate,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 5 — BorderDirectional with TextDirection variations
  // ===========================================================================

  Widget directionalTile({
    required String title,
    required BorderDirectional border,
    required TextDirection direction,
    required Color fill,
    required Color titleColor,
  }) {
    return Container(
      width: 220.0,
      height: 110.0,
      margin: const EdgeInsets.all(6.0),
      child: Directionality(
        textDirection: direction,
        child: Container(
          decoration: BoxDecoration(
            color: fill,
            border: border,
          ),
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 8.0, 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  final Widget section5Grid = Wrap(
    children: <Widget>[
      directionalTile(
        title: 'start LTR (accent)',
        border: const BorderDirectional(
          start: BorderSide(color: paletteAccent, width: 6.0),
        ),
        direction: TextDirection.ltr,
        fill: paletteAccentSoft,
        titleColor: paletteAccent,
      ),
      directionalTile(
        title: 'start RTL (accent)',
        border: const BorderDirectional(
          start: BorderSide(color: paletteAccent, width: 6.0),
        ),
        direction: TextDirection.rtl,
        fill: paletteAccentSoft,
        titleColor: paletteAccent,
      ),
      directionalTile(
        title: 'end LTR (rose)',
        border: const BorderDirectional(
          end: BorderSide(color: paletteRose, width: 6.0),
        ),
        direction: TextDirection.ltr,
        fill: paletteRoseSoft,
        titleColor: paletteRose,
      ),
      directionalTile(
        title: 'end RTL (rose)',
        border: const BorderDirectional(
          end: BorderSide(color: paletteRose, width: 6.0),
        ),
        direction: TextDirection.rtl,
        fill: paletteRoseSoft,
        titleColor: paletteRose,
      ),
      directionalTile(
        title: 'all four (LTR)',
        border: const BorderDirectional(
          top: BorderSide(color: paletteTeal, width: 3.0),
          end: BorderSide(color: paletteEmerald, width: 3.0),
          bottom: BorderSide(color: paletteTeal, width: 3.0),
          start: BorderSide(color: paletteEmerald, width: 3.0),
        ),
        direction: TextDirection.ltr,
        fill: paletteTealSoft,
        titleColor: paletteTeal,
      ),
      directionalTile(
        title: 'all four (RTL)',
        border: const BorderDirectional(
          top: BorderSide(color: paletteTeal, width: 3.0),
          end: BorderSide(color: paletteEmerald, width: 3.0),
          bottom: BorderSide(color: paletteTeal, width: 3.0),
          start: BorderSide(color: paletteEmerald, width: 3.0),
        ),
        direction: TextDirection.rtl,
        fill: paletteTealSoft,
        titleColor: paletteTeal,
      ),
      directionalTile(
        title: 'start + top LTR',
        border: const BorderDirectional(
          top: BorderSide(color: paletteAmber, width: 4.0),
          start: BorderSide(color: paletteAmber, width: 4.0),
        ),
        direction: TextDirection.ltr,
        fill: paletteAmberSoft,
        titleColor: paletteAmber,
      ),
      directionalTile(
        title: 'start + top RTL',
        border: const BorderDirectional(
          top: BorderSide(color: paletteAmber, width: 4.0),
          start: BorderSide(color: paletteAmber, width: 4.0),
        ),
        direction: TextDirection.rtl,
        fill: paletteAmberSoft,
        titleColor: paletteAmber,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 6 — Dashed approximation via stacked containers
  // ===========================================================================

  Widget dashedHorizontalRow({
    required int dashes,
    required Color color,
    required double dashWidth,
    required double gap,
    required double thickness,
  }) {
    return SizedBox(
      height: thickness,
      child: Row(
        children: List<Widget>.generate(dashes * 2 - 1, (int i) {
          if (i.isOdd) {
            return SizedBox(width: gap);
          }
          return Container(
            width: dashWidth,
            height: thickness,
            color: color,
          );
        }),
      ),
    );
  }

  Widget dashedTile({
    required Color color,
    required String title,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(6.0),
      color: color.withValues(alpha: 0.06),
      child: Stack(
        children: <Widget>[
          // Cluster H #14: dash counts sized to fit the padded 208×108
          // inner Stack. Horizontal: 11 dashes × 12 + 10 gaps × 6 = 192 ≤
          // 208. Vertical: 7 dashes × 10 + 6 gaps × 6 = 106 ≤ 108. Earlier
          // counts (12 horizontal × 8 vertical) overflowed by 2 px right
          // and 14 px bottom, generating 32 RenderFlex framework errors.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: dashedHorizontalRow(
              dashes: 11,
              color: color,
              dashWidth: 12.0,
              gap: 6.0,
              thickness: 2.5,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: dashedHorizontalRow(
              dashes: 11,
              color: color,
              dashWidth: 12.0,
              gap: 6.0,
              thickness: 2.5,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Column(
              children: List<Widget>.generate(7 * 2 - 1, (int i) {
                if (i.isOdd) {
                  return const SizedBox(height: 6.0);
                }
                return Container(
                  width: 2.5,
                  height: 10.0,
                  color: color,
                );
              }),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Column(
              children: List<Widget>.generate(7 * 2 - 1, (int i) {
                if (i.isOdd) {
                  return const SizedBox(height: 6.0);
                }
                return Container(
                  width: 2.5,
                  height: 10.0,
                  color: color,
                );
              }),
            ),
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section6Grid = Wrap(
    children: <Widget>[
      dashedTile(color: paletteAccent, title: 'accent dashed'),
      dashedTile(color: paletteRose, title: 'rose dashed'),
      dashedTile(color: paletteTeal, title: 'teal dashed'),
      dashedTile(color: paletteAmber, title: 'amber dashed'),
      dashedTile(color: paletteCrimson, title: 'crimson dashed'),
      dashedTile(color: paletteEmerald, title: 'emerald dashed'),
      dashedTile(color: paletteSlate, title: 'slate dashed'),
      dashedTile(color: paletteIndigo, title: 'indigo dashed'),
    ],
  );

  // ===========================================================================
  // SECTION 7 — Gradient borders via DecoratedBox stack
  // ===========================================================================

  Widget gradientBorderTile({
    required List<Color> gradient,
    required String title,
    double thickness = 4.0,
    double radius = 18.0,
  }) {
    return Container(
      width: 230.0,
      height: 110.0,
      margin: const EdgeInsets.all(6.0),
      padding: EdgeInsets.all(thickness),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: paletteSurface,
          borderRadius: BorderRadius.circular(radius - thickness),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: gradient.first,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  final Widget section7Grid = Wrap(
    children: <Widget>[
      gradientBorderTile(
        gradient: const <Color>[paletteAccent, paletteRose],
        title: 'accent → rose',
      ),
      gradientBorderTile(
        gradient: const <Color>[paletteTeal, paletteEmerald],
        title: 'teal → emerald',
      ),
      gradientBorderTile(
        gradient: const <Color>[paletteAmber, paletteCrimson],
        title: 'amber → crimson',
      ),
      gradientBorderTile(
        gradient: const <Color>[paletteIndigo, paletteAccent],
        title: 'indigo → accent',
        thickness: 3.0,
      ),
      gradientBorderTile(
        gradient: const <Color>[
          Color(0xFFF59E0B),
          Color(0xFFEF4444),
          Color(0xFF8B5CF6),
        ],
        title: 'tri-stop sunset',
        thickness: 5.0,
        radius: 22.0,
      ),
      gradientBorderTile(
        gradient: const <Color>[
          Color(0xFF06B6D4),
          Color(0xFF3B82F6),
          Color(0xFF8B5CF6),
        ],
        title: 'cool tri-stop',
        thickness: 5.0,
        radius: 22.0,
      ),
      gradientBorderTile(
        gradient: const <Color>[Color(0xFF111827), Color(0xFF6B7280)],
        title: 'mono grey',
        thickness: 2.0,
        radius: 10.0,
      ),
      gradientBorderTile(
        gradient: const <Color>[Color(0xFF14B8A6), Color(0xFFA7F3D0)],
        title: 'mint fade',
        thickness: 6.0,
        radius: 28.0,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 8 — BorderRadius variants
  // ===========================================================================

  Widget radiusTile({
    required BorderRadius radius,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 200.0,
      height: 110.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: radius,
        border: Border.all(color: color, width: 2.0),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final Widget section8Grid = Wrap(
    children: <Widget>[
      radiusTile(
        radius: BorderRadius.zero,
        title: 'zero',
        color: paletteSlate,
      ),
      radiusTile(
        radius: BorderRadius.circular(4.0),
        title: 'circular(4)',
        color: paletteAccent,
      ),
      radiusTile(
        radius: BorderRadius.circular(12.0),
        title: 'circular(12)',
        color: paletteAccent,
      ),
      radiusTile(
        radius: BorderRadius.circular(24.0),
        title: 'circular(24)',
        color: paletteRose,
      ),
      radiusTile(
        radius: BorderRadius.circular(48.0),
        title: 'circular(48)',
        color: paletteTeal,
      ),
      radiusTile(
        radius: const BorderRadius.all(Radius.elliptical(40.0, 18.0)),
        title: 'elliptical 40×18',
        color: paletteEmerald,
      ),
      radiusTile(
        radius: const BorderRadius.only(
          topLeft: Radius.circular(28.0),
          bottomRight: Radius.circular(28.0),
        ),
        title: 'only TL+BR',
        color: paletteCrimson,
      ),
      radiusTile(
        radius: const BorderRadius.only(
          topRight: Radius.circular(28.0),
          bottomLeft: Radius.circular(28.0),
        ),
        title: 'only TR+BL',
        color: paletteAmber,
      ),
      radiusTile(
        radius: const BorderRadius.only(topLeft: Radius.circular(40.0)),
        title: 'only TL=40',
        color: paletteIndigo,
      ),
      radiusTile(
        radius: const BorderRadius.only(topRight: Radius.circular(40.0)),
        title: 'only TR=40',
        color: paletteIndigo,
      ),
      radiusTile(
        radius: const BorderRadius.only(bottomLeft: Radius.circular(40.0)),
        title: 'only BL=40',
        color: paletteIndigo,
      ),
      radiusTile(
        radius: const BorderRadius.only(bottomRight: Radius.circular(40.0)),
        title: 'only BR=40',
        color: paletteIndigo,
      ),
      radiusTile(
        radius: const BorderRadius.horizontal(left: Radius.circular(30.0)),
        title: 'horizontal left',
        color: paletteAccent,
      ),
      radiusTile(
        radius: const BorderRadius.horizontal(right: Radius.circular(30.0)),
        title: 'horizontal right',
        color: paletteAccent,
      ),
      radiusTile(
        radius: const BorderRadius.horizontal(
          left: Radius.circular(20.0),
          right: Radius.circular(20.0),
        ),
        title: 'horizontal both',
        color: paletteRose,
      ),
      radiusTile(
        radius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        title: 'vertical top',
        color: paletteTeal,
      ),
      radiusTile(
        radius: const BorderRadius.vertical(bottom: Radius.circular(30.0)),
        title: 'vertical bottom',
        color: paletteTeal,
      ),
      radiusTile(
        radius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
          bottom: Radius.circular(20.0),
        ),
        title: 'vertical both',
        color: paletteEmerald,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 9 — RoundedRectangleBorder
  // ===========================================================================

  Widget rrBorderTile({
    required RoundedRectangleBorder shape,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      child: Material(
        color: color.withValues(alpha: 0.16),
        shape: shape,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final Widget section9Grid = Wrap(
    children: <Widget>[
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: paletteAccent, width: 2.0),
        ),
        title: 'radius 8 + side',
        color: paletteAccent,
      ),
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: paletteRose, width: 3.0),
        ),
        title: 'radius 20 + side',
        color: paletteRose,
      ),
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
          side: const BorderSide(color: paletteTeal, width: 4.0),
        ),
        title: 'radius 36 + side',
        color: paletteTeal,
      ),
      rrBorderTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            bottomRight: Radius.circular(28.0),
          ),
          side: BorderSide(color: paletteAmber, width: 3.0),
        ),
        title: 'asym corners',
        color: paletteAmber,
      ),
      rrBorderTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(40.0, 16.0)),
          side: BorderSide(color: paletteCrimson, width: 2.5),
        ),
        title: 'elliptical corners',
        color: paletteCrimson,
      ),
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
          side: const BorderSide(color: paletteSlate, width: 1.0),
        ),
        title: 'tight 2 px radius',
        color: paletteSlate,
      ),
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(64.0),
          side: const BorderSide(color: paletteEmerald, width: 4.0),
        ),
        title: 'huge radius 64',
        color: paletteEmerald,
      ),
      rrBorderTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(color: paletteIndigo, width: 6.0),
        ),
        title: 'thick side 6 px',
        color: paletteIndigo,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 10 — CircleBorder, StadiumBorder
  // ===========================================================================

  Widget shapeBox({
    required ShapeBorder shape,
    required String title,
    required Color color,
    double width = 220.0,
    double height = 120.0,
  }) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(6.0),
      child: Material(
        color: color.withValues(alpha: 0.16),
        shape: shape,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  final Widget section10Grid = Wrap(
    children: <Widget>[
      shapeBox(
        shape: const CircleBorder(
          side: BorderSide(color: paletteAccent, width: 3.0),
        ),
        title: 'CircleBorder 3px',
        color: paletteAccent,
        width: 140.0,
        height: 140.0,
      ),
      shapeBox(
        shape: const CircleBorder(
          side: BorderSide(color: paletteRose, width: 6.0),
        ),
        title: 'CircleBorder 6px',
        color: paletteRose,
        width: 140.0,
        height: 140.0,
      ),
      shapeBox(
        shape: const CircleBorder(
          side: BorderSide(color: paletteTeal, width: 1.0),
        ),
        title: 'CircleBorder hairline',
        color: paletteTeal,
        width: 140.0,
        height: 140.0,
      ),
      shapeBox(
        shape: const CircleBorder(
          eccentricity: 0.7,
          side: BorderSide(color: paletteAmber, width: 4.0),
        ),
        title: 'eccentric 0.7',
        color: paletteAmber,
        width: 180.0,
        height: 120.0,
      ),
      shapeBox(
        shape: const CircleBorder(
          eccentricity: 0.95,
          side: BorderSide(color: paletteEmerald, width: 4.0),
        ),
        title: 'eccentric 0.95',
        color: paletteEmerald,
        width: 220.0,
        height: 120.0,
      ),
      shapeBox(
        shape: const StadiumBorder(
          side: BorderSide(color: paletteIndigo, width: 2.0),
        ),
        title: 'StadiumBorder 2px',
        color: paletteIndigo,
      ),
      shapeBox(
        shape: const StadiumBorder(
          side: BorderSide(color: paletteCrimson, width: 4.0),
        ),
        title: 'StadiumBorder 4px',
        color: paletteCrimson,
      ),
      shapeBox(
        shape: const StadiumBorder(
          side: BorderSide(color: paletteSlate, width: 6.0),
        ),
        title: 'StadiumBorder 6px',
        color: paletteSlate,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 11 — BeveledRectangleBorder
  // ===========================================================================

  Widget beveledTile({
    required BeveledRectangleBorder shape,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      child: Material(
        color: color.withValues(alpha: 0.18),
        shape: shape,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  final Widget section11Grid = Wrap(
    children: <Widget>[
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          side: BorderSide(color: paletteAccent, width: 2.0),
        ),
        title: 'bevel 8 / side 2',
        color: paletteAccent,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          side: BorderSide(color: paletteRose, width: 3.0),
        ),
        title: 'bevel 16 / side 3',
        color: paletteRose,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
          side: BorderSide(color: paletteTeal, width: 4.0),
        ),
        title: 'bevel 28 / side 4',
        color: paletteTeal,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            bottomRight: Radius.circular(28.0),
          ),
          side: BorderSide(color: paletteAmber, width: 3.0),
        ),
        title: 'asym bevel TL+BR',
        color: paletteAmber,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          ),
          side: BorderSide(color: paletteCrimson, width: 3.0),
        ),
        title: 'asym bevel TR+BL',
        color: paletteCrimson,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          side: BorderSide(color: paletteSlate, width: 2.0),
        ),
        title: 'bevel 0 (square)',
        color: paletteSlate,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(48.0)),
          side: BorderSide(color: paletteEmerald, width: 5.0),
        ),
        title: 'huge bevel 48',
        color: paletteEmerald,
      ),
      beveledTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(36.0),
            bottomLeft: Radius.circular(36.0),
            bottomRight: Radius.circular(12.0),
          ),
          side: BorderSide(color: paletteIndigo, width: 3.0),
        ),
        title: 'mixed corners',
        color: paletteIndigo,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 12 — ContinuousRectangleBorder
  // ===========================================================================

  Widget continuousTile({
    required ContinuousRectangleBorder shape,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      child: Material(
        color: color.withValues(alpha: 0.18),
        shape: shape,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  final Widget section12Grid = Wrap(
    children: <Widget>[
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          side: BorderSide(color: paletteAccent, width: 2.0),
        ),
        title: 'continuous 8',
        color: paletteAccent,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: paletteRose, width: 3.0),
        ),
        title: 'continuous 20',
        color: paletteRose,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          side: BorderSide(color: paletteTeal, width: 4.0),
        ),
        title: 'continuous 40',
        color: paletteTeal,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
          side: BorderSide(color: paletteEmerald, width: 4.0),
        ),
        title: 'continuous 60',
        color: paletteEmerald,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          side: BorderSide(color: paletteAmber, width: 3.0),
        ),
        title: 'TL+BR asym',
        color: paletteAmber,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          ),
          side: BorderSide(color: paletteCrimson, width: 3.0),
        ),
        title: 'TR+BL asym',
        color: paletteCrimson,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          side: BorderSide(color: paletteIndigo, width: 3.0),
        ),
        title: 'continuous top',
        color: paletteIndigo,
      ),
      continuousTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(50.0)),
          side: BorderSide(color: paletteSlate, width: 3.0),
        ),
        title: 'continuous right',
        color: paletteSlate,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 13 — OutlinedButton with custom shapes
  // ===========================================================================

  Widget outlinedButtonTile({
    required OutlinedBorder shape,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: color.withValues(alpha: 0.08),
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
          side: BorderSide(color: color, width: 2.0),
          shape: shape,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  final Widget section13Grid = Wrap(
    children: <Widget>[
      outlinedButtonTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        label: 'Rounded 8',
        color: paletteAccent,
      ),
      outlinedButtonTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        label: 'Rounded 28',
        color: paletteRose,
      ),
      outlinedButtonTile(
        shape: const StadiumBorder(),
        label: 'Stadium',
        color: paletteTeal,
      ),
      outlinedButtonTile(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        label: 'Beveled 14',
        color: paletteAmber,
      ),
      outlinedButtonTile(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
        label: 'Continuous 28',
        color: paletteEmerald,
      ),
      outlinedButtonTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
        ),
        label: 'Asym corners',
        color: paletteCrimson,
      ),
      outlinedButtonTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        label: 'Sharp zero',
        color: paletteSlate,
      ),
      outlinedButtonTile(
        shape: const StadiumBorder(),
        label: 'Stadium indigo',
        color: paletteIndigo,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 14 — Card with shapes
  // ===========================================================================

  Widget shapedCard({
    required ShapeBorder shape,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 260.0,
      margin: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 3.0,
        color: color.withValues(alpha: 0.08),
        shape: shape,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 32.0,
                    height: 32.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.style,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: paletteInkSoft,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget section14Grid = Wrap(
    children: <Widget>[
      shapedCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: paletteAccent, width: 1.5),
        ),
        title: 'Rounded 8',
        subtitle: 'Card with a tight RoundedRectangleBorder.',
        color: paletteAccent,
      ),
      shapedCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(color: paletteRose, width: 1.5),
        ),
        title: 'Rounded 24',
        subtitle: 'A larger radius lifts cards visually.',
        color: paletteRose,
      ),
      shapedCard(
        shape: const StadiumBorder(
          side: BorderSide(color: paletteTeal, width: 1.5),
        ),
        title: 'StadiumBorder',
        subtitle: 'Pill-shaped card for hero callouts.',
        color: paletteTeal,
      ),
      shapedCard(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: paletteAmber, width: 1.5),
        ),
        title: 'Beveled 20',
        subtitle: 'Crisp diagonal cuts at each corner.',
        color: paletteAmber,
      ),
      shapedCard(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
          side: BorderSide(color: paletteEmerald, width: 1.5),
        ),
        title: 'Continuous 36',
        subtitle: 'Squircle-style continuous curves.',
        color: paletteEmerald,
      ),
      shapedCard(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0),
          ),
          side: BorderSide(color: paletteCrimson, width: 1.5),
        ),
        title: 'Asym corners',
        subtitle: 'Top-left and bottom-right rounded.',
        color: paletteCrimson,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 15 — Chip with shapes
  // ===========================================================================

  Widget shapedChip({
    required OutlinedBorder shape,
    required String label,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Chip(
        label: Text(label),
        labelStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
        ),
        backgroundColor: color.withValues(alpha: 0.12),
        side: BorderSide(color: color, width: 1.4),
        shape: shape,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      ),
    );
  }

  final Widget section15Grid = Wrap(
    children: <Widget>[
      shapedChip(
        shape: const StadiumBorder(),
        label: 'Stadium chip',
        color: paletteAccent,
      ),
      shapedChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        label: 'Rounded 6',
        color: paletteRose,
      ),
      shapedChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        label: 'Rounded 12',
        color: paletteTeal,
      ),
      shapedChip(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        label: 'Beveled 10',
        color: paletteAmber,
      ),
      shapedChip(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        label: 'Continuous 16',
        color: paletteEmerald,
      ),
      shapedChip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        label: 'Asym chip',
        color: paletteCrimson,
      ),
      shapedChip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        label: 'Sharp chip',
        color: paletteSlate,
      ),
      shapedChip(
        shape: const StadiumBorder(),
        label: 'Indigo pill',
        color: paletteIndigo,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 16 — Material with shapes (elevation playground)
  // ===========================================================================

  Widget shapedMaterial({
    required ShapeBorder shape,
    required double elevation,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 220.0,
      height: 130.0,
      margin: const EdgeInsets.all(6.0),
      child: Material(
        color: color.withValues(alpha: 0.18),
        elevation: elevation,
        shadowColor: color.withValues(alpha: 0.4),
        shape: shape,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'elevation ${elevation.toStringAsFixed(1)}',
                style: TextStyle(
                  color: color.withValues(alpha: 0.8),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget section16Grid = Wrap(
    children: <Widget>[
      shapedMaterial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: paletteAccent, width: 1.2),
        ),
        elevation: 0.0,
        title: 'Flat rounded',
        color: paletteAccent,
      ),
      shapedMaterial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: paletteAccent, width: 1.2),
        ),
        elevation: 2.0,
        title: 'Low elev',
        color: paletteAccent,
      ),
      shapedMaterial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: paletteAccent, width: 1.2),
        ),
        elevation: 6.0,
        title: 'Med elev',
        color: paletteAccent,
      ),
      shapedMaterial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: paletteAccent, width: 1.2),
        ),
        elevation: 12.0,
        title: 'High elev',
        color: paletteAccent,
      ),
      shapedMaterial(
        shape: const StadiumBorder(
          side: BorderSide(color: paletteRose, width: 1.2),
        ),
        elevation: 4.0,
        title: 'Stadium 4',
        color: paletteRose,
      ),
      shapedMaterial(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          side: BorderSide(color: paletteAmber, width: 1.2),
        ),
        elevation: 6.0,
        title: 'Beveled 6',
        color: paletteAmber,
      ),
      shapedMaterial(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          side: BorderSide(color: paletteEmerald, width: 1.2),
        ),
        elevation: 8.0,
        title: 'Continuous 8',
        color: paletteEmerald,
      ),
      shapedMaterial(
        shape: const CircleBorder(
          side: BorderSide(color: paletteIndigo, width: 1.2),
        ),
        elevation: 5.0,
        title: 'Circle 5',
        color: paletteIndigo,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 17 — BoxBorder polymorphism + showcase
  // ===========================================================================

  Widget boxBorderTile({
    required BoxBorder border,
    required String title,
    required Color fill,
    required Color color,
    BorderRadius? radius,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      width: 220.0,
      height: 120.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: fill,
        border: border,
        borderRadius: shape == BoxShape.rectangle ? radius : null,
        shape: shape,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final Widget section17Grid = Wrap(
    children: <Widget>[
      boxBorderTile(
        border: Border.all(color: paletteAccent, width: 3.0),
        title: 'Border.all rect',
        fill: paletteAccentSoft,
        color: paletteAccent,
        radius: BorderRadius.circular(10.0),
      ),
      boxBorderTile(
        border: Border.all(color: paletteRose, width: 3.0),
        title: 'Border.all circle',
        fill: paletteRoseSoft,
        color: paletteRose,
        shape: BoxShape.circle,
      ),
      boxBorderTile(
        border: const Border(
          top: BorderSide(color: paletteTeal, width: 4.0),
          bottom: BorderSide(color: paletteEmerald, width: 4.0),
        ),
        title: 'top+bottom only',
        fill: paletteTealSoft,
        color: paletteTeal,
        // No radius: Border has non-uniform colors (teal/emerald).
      ),
      boxBorderTile(
        border: const BorderDirectional(
          start: BorderSide(color: paletteAmber, width: 6.0),
          end: BorderSide(color: paletteCrimson, width: 6.0),
        ),
        title: 'directional rails',
        fill: paletteAmberSoft,
        color: paletteAmber,
      ),
      boxBorderTile(
        border: Border.all(color: paletteSlate, width: 2.0),
        title: 'circle rect 2px',
        fill: paletteSlateSoft,
        color: paletteSlate,
        shape: BoxShape.circle,
      ),
      boxBorderTile(
        border: const Border.symmetric(
          vertical: BorderSide(color: paletteIndigo, width: 5.0),
        ),
        title: 'sym vertical 5',
        fill: paletteIndigoSoft,
        color: paletteIndigo,
        // No radius: Border.symmetric(vertical:) leaves top/bottom as
        // BorderSide.none, which produces non-uniform colors vs. the
        // colored verticals — borderRadius would trip the assertion.
      ),
    ],
  );

  // ===========================================================================
  // SECTION 18 — BorderSide constructors showcase
  // ===========================================================================

  Widget borderSideTile({
    required BorderSide side,
    required String title,
    required Color color,
    required String description,
  }) {
    return Container(
      width: 250.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: paletteSurface,
              border: Border(top: side, bottom: side, left: side, right: side),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              color: paletteInkSoft,
              fontSize: 11.0,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section18Grid = Wrap(
    children: <Widget>[
      borderSideTile(
        side: const BorderSide(color: paletteAccent, width: 2.0),
        title: 'default solid',
        color: paletteAccent,
        description:
            'BorderSide(color: paletteAccent, width: 2.0) — the canonical '
            'solid stroke.',
      ),
      borderSideTile(
        side: const BorderSide(color: paletteRose, width: 4.0),
        title: 'wider stroke',
        color: paletteRose,
        description:
            'A wider stroke at 4 px reads as a strong outline rather than a '
            'subtle accent.',
      ),
      borderSideTile(
        side: BorderSide.none,
        title: 'BorderSide.none',
        color: paletteSlate,
        description:
            'BorderSide.none yields the absence of a side — useful for '
            'overriding inherited sides selectively.',
      ),
      borderSideTile(
        side: const BorderSide(
          color: paletteAmber,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        title: 'explicit solid',
        color: paletteAmber,
        description:
            'BorderStyle.solid is the default; passing it explicitly is '
            'occasionally helpful in metadata-driven code.',
      ),
      borderSideTile(
        side: const BorderSide(
          color: paletteTeal,
          width: 0.0,
          style: BorderStyle.solid,
        ),
        title: 'hairline 0.0',
        color: paletteTeal,
        description:
            'A width of 0 maps to a single device pixel — the thinnest '
            'visible stroke.',
      ),
      borderSideTile(
        side: const BorderSide(
          color: paletteEmerald,
          width: 2.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        title: 'strokeAlign inside',
        color: paletteEmerald,
        description:
            'strokeAlignInside places the stroke entirely within the shape '
            'bounds.',
      ),
      borderSideTile(
        side: const BorderSide(
          color: paletteCrimson,
          width: 2.0,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        title: 'strokeAlign center',
        color: paletteCrimson,
        description:
            'strokeAlignCenter straddles the shape boundary — the default '
            'for outlined Material widgets.',
      ),
      borderSideTile(
        side: const BorderSide(
          color: paletteIndigo,
          width: 2.0,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        title: 'strokeAlign outside',
        color: paletteIndigo,
        description:
            'strokeAlignOutside draws the stroke entirely outside the shape '
            'fill — visually expands the geometry.',
      ),
    ],
  );

  // ===========================================================================
  // SECTION 19 — Composition gallery (combined showcase)
  // ===========================================================================

  Widget compositionCard({
    required Color color,
    required String title,
    required String body,
    required ShapeBorder shape,
    required IconData icon,
  }) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.all(8.0),
      child: Material(
        color: color.withValues(alpha: 0.10),
        shape: shape,
        elevation: 3.0,
        shadowColor: color.withValues(alpha: 0.4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: color.withValues(alpha: 0.45),
                          blurRadius: 8.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 22.0),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                body,
                style: const TextStyle(
                  color: paletteInk,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget section19Grid = Wrap(
    children: <Widget>[
      compositionCard(
        color: paletteAccent,
        title: 'Quick start',
        body:
            'Pair RoundedRectangleBorder(borderRadius: 16) with a 1.5px '
            'BorderSide to get a friendly outlined panel that works in any '
            'colour scheme.',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: paletteAccent, width: 1.5),
        ),
        icon: Icons.flash_on,
      ),
      compositionCard(
        color: paletteRose,
        title: 'Hero callout',
        body:
            'StadiumBorder turns a rectangular block into a pill, ideal for '
            'short hero messages or call-to-action banners.',
        shape: const StadiumBorder(
          side: BorderSide(color: paletteRose, width: 1.5),
        ),
        icon: Icons.star,
      ),
      compositionCard(
        color: paletteAmber,
        title: 'Industrial tile',
        body:
            'BeveledRectangleBorder lends a technical, blueprint-like vibe. '
            'Increase the radius to dramatise the diagonal cuts.',
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: paletteAmber, width: 1.5),
        ),
        icon: Icons.precision_manufacturing,
      ),
      compositionCard(
        color: paletteEmerald,
        title: 'Squircle softness',
        body:
            'ContinuousRectangleBorder produces a smooth squircle. Best for '
            'app-like UIs where corners should be felt, not seen.',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
          side: BorderSide(color: paletteEmerald, width: 1.5),
        ),
        icon: Icons.water_drop,
      ),
      compositionCard(
        color: paletteCrimson,
        title: 'Diagonal accent',
        body:
            'Asymmetric corners (top-left + bottom-right) give a directional '
            'feel — great for highlighting a primary action card.',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            bottomRight: Radius.circular(28.0),
          ),
          side: BorderSide(color: paletteCrimson, width: 1.5),
        ),
        icon: Icons.swap_calls,
      ),
      compositionCard(
        color: paletteIndigo,
        title: 'Compact pill',
        body:
            'A StadiumBorder with elevation 3 reads as a chip-card hybrid — '
            'perfect for compact dashboard widgets.',
        shape: const StadiumBorder(
          side: BorderSide(color: paletteIndigo, width: 1.5),
        ),
        icon: Icons.tag,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 20 — Design tokens palette
  // ===========================================================================

  Widget paletteSwatch(String name, Color color) {
    return Container(
      width: 130.0,
      margin: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 56.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.08),
                width: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            name,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
            style: const TextStyle(
              color: paletteInkSoft,
              fontSize: 10.5,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section20Palette = Wrap(
    children: <Widget>[
      paletteSwatch('accent', paletteAccent),
      paletteSwatch('accent-soft', paletteAccentSoft),
      paletteSwatch('rose', paletteRose),
      paletteSwatch('rose-soft', paletteRoseSoft),
      paletteSwatch('teal', paletteTeal),
      paletteSwatch('teal-soft', paletteTealSoft),
      paletteSwatch('amber', paletteAmber),
      paletteSwatch('amber-soft', paletteAmberSoft),
      paletteSwatch('crimson', paletteCrimson),
      paletteSwatch('crimson-soft', paletteCrimsonSoft),
      paletteSwatch('emerald', paletteEmerald),
      paletteSwatch('emerald-soft', paletteEmeraldSoft),
      paletteSwatch('slate', paletteSlate),
      paletteSwatch('slate-soft', paletteSlateSoft),
      paletteSwatch('indigo', paletteIndigo),
      paletteSwatch('indigo-soft', paletteIndigoSoft),
      paletteSwatch('ink', paletteInk),
      paletteSwatch('ink-soft', paletteInkSoft),
      paletteSwatch('surface', paletteSurface),
      paletteSwatch('surface-alt', paletteSurfaceAlt),
      paletteSwatch('outline', paletteOutline),
    ],
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================

  return Scaffold(
    backgroundColor: paletteSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,

          buildSectionHeader(
            number: 1,
            title: 'Border.all — width spectrum',
            subtitle:
                'The most common Border constructor, swept from 0.5 to 14 px.',
            icon: Icons.line_weight,
            color: paletteAccent,
          ),
          buildNarrative(
            'Border.all(color, width, style) creates a Border whose four '
            'sides share the same BorderSide. Increase the width to add '
            'weight, decrease for elegance. A width of zero renders a '
            'hairline (one device pixel).',
          ),
          sectionShell(
            title: 'Width sweep',
            subtitle: 'Ten Container tiles using Border.all only.',
            surface: paletteSurface,
            border: paletteOutline,
            titleColor: paletteAccent,
            child: section1Grid,
          ),

          buildSectionHeader(
            number: 2,
            title: 'BorderStyle — solid / none / hairline',
            subtitle:
                'The style enum and the special zero-width hairline case.',
            icon: Icons.format_paint,
            color: paletteRose,
          ),
          buildNarrative(
            'BorderStyle is currently a closed enum with two values — solid '
            'and none. Setting style to none turns a side invisible while '
            'preserving its width contribution to layout calculations.',
          ),
          sectionShell(
            title: 'Style variations',
            subtitle: 'Compare solid, none and width-zero hairlines.',
            surface: paletteRoseSoft,
            border: paletteRose,
            titleColor: paletteRose,
            child: section2Grid,
          ),

          buildSectionHeader(
            number: 3,
            title: 'Border per side — top / bottom / left / right',
            subtitle:
                'The default Border constructor with selectively-set sides.',
            icon: Icons.border_clear,
            color: paletteTeal,
          ),
          buildNarrative(
            'When you set only some of the four BorderSide parameters of '
            'the default Border constructor, the others default to '
            'BorderSide.none. This makes it ideal for separators, '
            'underlines or single-side accents.',
          ),
          sectionShell(
            title: 'Per-side gallery',
            subtitle:
                'Eleven tiles each showcasing a unique combination of sides.',
            surface: paletteTealSoft,
            border: paletteTeal,
            titleColor: paletteTeal,
            child: section3Grid,
          ),

          buildSectionHeader(
            number: 4,
            title: 'Border.symmetric — horizontal × vertical',
            subtitle: 'A shortcut for matching horizontal and vertical sides.',
            icon: Icons.compare_arrows,
            color: paletteAmber,
          ),
          buildNarrative(
            'Border.symmetric(horizontal: BorderSide, vertical: BorderSide) '
            'fans out one or two sides to four. Pass only horizontal for a '
            'top/bottom rule, or only vertical for left/right rails.',
          ),
          sectionShell(
            title: 'Symmetric gallery',
            subtitle: 'Vertical-only, horizontal-only and combined forms.',
            surface: paletteAmberSoft,
            border: paletteAmber,
            titleColor: paletteAmber,
            child: section4Grid,
          ),

          buildSectionHeader(
            number: 5,
            title: 'BorderDirectional — start / end',
            subtitle:
                'Direction-aware borders that flip for LTR and RTL layouts.',
            icon: Icons.swap_horiz,
            color: paletteCrimson,
          ),
          buildNarrative(
            'BorderDirectional uses start / end instead of left / right, '
            'so the same widget tree paints the correct edge in either '
            'reading direction. Wrap with Directionality to see the flip.',
          ),
          sectionShell(
            title: 'Directional flip cases',
            subtitle: 'Same border, LTR vs RTL — left/right swap.',
            surface: paletteCrimsonSoft,
            border: paletteCrimson,
            titleColor: paletteCrimson,
            child: section5Grid,
          ),

          buildSectionHeader(
            number: 6,
            title: 'Dashed approximation',
            subtitle:
                'Dashes built by stacking small Containers — pure widgets.',
            icon: Icons.more_horiz,
            color: paletteEmerald,
          ),
          buildNarrative(
            'BoxDecoration does not paint dashed borders out of the box. '
            'A common widget-only approximation stacks rows and columns of '
            'tiny rectangles along each edge — no CustomPainter required.',
          ),
          sectionShell(
            title: 'Dashed gallery',
            subtitle:
                'Each tile uses Positioned + Container rectangles for dashes.',
            surface: paletteEmeraldSoft,
            border: paletteEmerald,
            titleColor: paletteEmerald,
            child: section6Grid,
          ),

          buildSectionHeader(
            number: 7,
            title: 'Gradient borders via padding sandwich',
            subtitle:
                'Outer gradient Container wrapping an inner surface Container.',
            icon: Icons.gradient,
            color: paletteIndigo,
          ),
          buildNarrative(
            'A native "gradient BorderSide" does not exist. The widget-only '
            'recipe wraps the content in a Container whose decoration is a '
            'gradient, and uses padding to reveal a thin frame around an '
            'inner solid-coloured Container.',
          ),
          sectionShell(
            title: 'Gradient frames',
            subtitle: 'Eight gradient combinations from subtle to vibrant.',
            surface: paletteIndigoSoft,
            border: paletteIndigo,
            titleColor: paletteIndigo,
            child: section7Grid,
          ),

          buildSectionHeader(
            number: 8,
            title: 'BorderRadius constructors',
            subtitle:
                'zero, circular, all, only, horizontal, vertical, elliptical.',
            icon: Icons.rounded_corner,
            color: paletteAccent,
          ),
          buildNarrative(
            'BorderRadius exposes every common corner combination as a '
            'dedicated constructor — circular for the round-everywhere case, '
            'only for asymmetric corners, horizontal / vertical for axis '
            'pairs, and a generic all for explicit Radius objects.',
          ),
          sectionShell(
            title: 'Radius gallery',
            subtitle: 'Eighteen tiles covering every constructor.',
            surface: paletteSurface,
            border: paletteAccent,
            titleColor: paletteAccent,
            child: section8Grid,
          ),

          buildSectionHeader(
            number: 9,
            title: 'RoundedRectangleBorder',
            subtitle:
                'ShapeBorder with a BorderRadius + BorderSide combination.',
            icon: Icons.crop_din,
            color: paletteRose,
          ),
          buildNarrative(
            'RoundedRectangleBorder is the ShapeBorder counterpart to a '
            'BoxDecoration with borderRadius + border. Use it on Material, '
            'Card, OutlinedButton.styleFrom(shape: ...), or anywhere a '
            'ShapeBorder is requested.',
          ),
          sectionShell(
            title: 'RoundedRectangleBorder gallery',
            subtitle: 'Plain, asymmetric, elliptical and hairline variants.',
            surface: paletteRoseSoft,
            border: paletteRose,
            titleColor: paletteRose,
            child: section9Grid,
          ),

          buildSectionHeader(
            number: 10,
            title: 'CircleBorder & StadiumBorder',
            subtitle: 'The two rounded extremes — pure circle and pill.',
            icon: Icons.circle_outlined,
            color: paletteTeal,
          ),
          buildNarrative(
            'CircleBorder paints a perfect circle (or an ellipse via '
            'eccentricity). StadiumBorder paints a rectangle with fully '
            'rounded short edges — the classic "pill" outline.',
          ),
          sectionShell(
            title: 'Circle & stadium gallery',
            subtitle:
                'Width sweeps, eccentricity for ellipses, stadium pills.',
            surface: paletteTealSoft,
            border: paletteTeal,
            titleColor: paletteTeal,
            child: section10Grid,
          ),

          buildSectionHeader(
            number: 11,
            title: 'BeveledRectangleBorder',
            subtitle:
                'Replaces each rounded corner with a straight diagonal cut.',
            icon: Icons.crop_square,
            color: paletteAmber,
          ),
          buildNarrative(
            'BeveledRectangleBorder draws a rectangle whose corners are '
            'truncated by straight lines. The radius arg controls the cut '
            'depth. Great for industrial, technical or arcade aesthetics.',
          ),
          sectionShell(
            title: 'Beveled gallery',
            subtitle: 'Symmetric and asymmetric beveled shapes.',
            surface: paletteAmberSoft,
            border: paletteAmber,
            titleColor: paletteAmber,
            child: section11Grid,
          ),

          buildSectionHeader(
            number: 12,
            title: 'ContinuousRectangleBorder',
            subtitle:
                'Smooth squircle curves — softer than a rounded rectangle.',
            icon: Icons.rounded_corner,
            color: paletteEmerald,
          ),
          buildNarrative(
            'ContinuousRectangleBorder draws a rectangle whose corners flow '
            'into the sides via continuous curvature, like the iOS app icon '
            'silhouette. Increase the radius to dramatise the squircle.',
          ),
          sectionShell(
            title: 'Continuous gallery',
            subtitle: 'Symmetric and asymmetric squircle variants.',
            surface: paletteEmeraldSoft,
            border: paletteEmerald,
            titleColor: paletteEmerald,
            child: section12Grid,
          ),

          buildSectionHeader(
            number: 13,
            title: 'OutlinedButton with custom shapes',
            subtitle:
                'OutlinedButton.styleFrom(shape: <ShapeBorder>) in action.',
            icon: Icons.smart_button,
            color: paletteCrimson,
          ),
          buildNarrative(
            'Every OutlinedBorder subclass we have seen can be plugged into '
            'OutlinedButton.styleFrom(shape: ...). Below, eight buttons '
            'show the visual difference each shape contributes — same '
            'side, same colour, just different geometry.',
          ),
          sectionShell(
            title: 'Outlined button shapes',
            subtitle: 'Rounded, stadium, beveled, continuous, asymmetric…',
            surface: paletteCrimsonSoft,
            border: paletteCrimson,
            titleColor: paletteCrimson,
            child: section13Grid,
          ),

          buildSectionHeader(
            number: 14,
            title: 'Card with shapes',
            subtitle:
                'Card.shape accepts any ShapeBorder — try them side by side.',
            icon: Icons.crop_portrait,
            color: paletteIndigo,
          ),
          buildNarrative(
            'A Cards default shape is a RoundedRectangleBorder with a small '
            'radius. Replace shape to give your dashboard a distinctive '
            'vibe — pills, squircles, asymmetric corners or bevels.',
          ),
          sectionShell(
            title: 'Shaped card gallery',
            subtitle: 'Six cards demonstrating five distinct ShapeBorder '
                'subclasses.',
            surface: paletteIndigoSoft,
            border: paletteIndigo,
            titleColor: paletteIndigo,
            child: section14Grid,
          ),

          buildSectionHeader(
            number: 15,
            title: 'Chip with shapes',
            subtitle:
                'Chip.shape: a quick way to vary tags, filters and labels.',
            icon: Icons.label,
            color: paletteAccent,
          ),
          buildNarrative(
            'Chips ship with a StadiumBorder by default. Swap shape to '
            'create rounded, beveled, continuous or sharp-edged chip '
            'variants — useful for distinguishing categories at a glance.',
          ),
          sectionShell(
            title: 'Shaped chip gallery',
            subtitle: 'Eight chip silhouettes side by side.',
            surface: paletteSurface,
            border: paletteAccent,
            titleColor: paletteAccent,
            child: section15Grid,
          ),

          buildSectionHeader(
            number: 16,
            title: 'Material with shapes (elevation)',
            subtitle:
                'Material.shape + elevation — shadow follows the silhouette.',
            icon: Icons.layers,
            color: paletteRose,
          ),
          buildNarrative(
            'Material widgets generate their drop shadow from the supplied '
            'shape. Combine an exotic ShapeBorder with an elevation to see '
            'the shadow conform — circles cast circular shadows, stadiums '
            'cast pill shadows, and so on.',
          ),
          sectionShell(
            title: 'Elevation × shape',
            subtitle: 'A grid that varies both elevation and shape.',
            surface: paletteRoseSoft,
            border: paletteRose,
            titleColor: paletteRose,
            child: section16Grid,
          ),

          buildSectionHeader(
            number: 17,
            title: 'BoxBorder polymorphism',
            subtitle:
                'Border + BorderDirectional both implement BoxBorder.',
            icon: Icons.compare,
            color: paletteTeal,
          ),
          buildNarrative(
            'BoxBorder is the abstract base shared by Border (LTR-agnostic) '
            'and BorderDirectional (locale-aware). Anywhere a BoxBorder is '
            'accepted — BoxDecoration.border in particular — you can pass '
            'either. Below, a mixed gallery demonstrates the polymorphism.',
          ),
          sectionShell(
            title: 'BoxBorder gallery',
            subtitle:
                'Rectangles and circles with Border and BorderDirectional.',
            surface: paletteTealSoft,
            border: paletteTeal,
            titleColor: paletteTeal,
            child: section17Grid,
          ),

          buildSectionHeader(
            number: 18,
            title: 'BorderSide deep dive',
            subtitle:
                'color, width, style, strokeAlign and BorderSide.none.',
            icon: Icons.straighten,
            color: paletteAmber,
          ),
          buildNarrative(
            'BorderSide is the atomic unit every Border is composed of. '
            'It controls colour, width, style and stroke alignment relative '
            'to the painted shape. The strokeAlign constants influence '
            'whether the stroke lives inside, centered on or outside the '
            'shape boundary.',
          ),
          sectionShell(
            title: 'BorderSide configurations',
            subtitle:
                'Eight tiles, each pinned to one constructor parameter.',
            surface: paletteAmberSoft,
            border: paletteAmber,
            titleColor: paletteAmber,
            child: section18Grid,
          ),

          buildSectionHeader(
            number: 19,
            title: 'Composition gallery',
            subtitle: 'Putting it all together — six finished design cards.',
            icon: Icons.collections,
            color: paletteEmerald,
          ),
          buildNarrative(
            'Real-world UIs rarely use a single border feature in isolation. '
            'These six cards combine BorderSide width, ShapeBorder geometry, '
            'soft fill colour, Material elevation and Border.all icon '
            'badges into cohesive, ready-to-ship blocks.',
          ),
          sectionShell(
            title: 'Composed cards',
            subtitle: 'Realistic dashboards and callouts.',
            surface: paletteEmeraldSoft,
            border: paletteEmerald,
            titleColor: paletteEmerald,
            child: section19Grid,
          ),

          buildSectionHeader(
            number: 20,
            title: 'Design tokens',
            subtitle:
                'The complete colour palette used throughout this demo.',
            icon: Icons.palette,
            color: paletteIndigo,
          ),
          sectionShell(
            title: 'Palette',
            subtitle:
                '21 swatches with their hex values for easy reproduction.',
            surface: paletteIndigoSoft,
            border: paletteIndigo,
            titleColor: paletteIndigo,
            child: section20Palette,
          ),

          const SizedBox(height: 32.0),

          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  paletteIndigo.withValues(alpha: 0.92),
                  paletteAccent.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: paletteIndigo.withValues(alpha: 0.4),
                  blurRadius: 18.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 32.0,
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Demo complete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Border, BorderSide, Border.all, Border.symmetric, '
                        'BorderDirectional, BorderStyle, BorderRadius, '
                        'BoxBorder, RoundedRectangleBorder, CircleBorder, '
                        'StadiumBorder, BeveledRectangleBorder and '
                        'ContinuousRectangleBorder — all rendered live.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
