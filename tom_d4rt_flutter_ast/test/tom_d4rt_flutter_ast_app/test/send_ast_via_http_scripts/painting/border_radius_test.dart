// D4rt test script: Deep visual demo for BorderRadius from painting library.
//
// BorderRadius describes how the four corners of a rectangular box should be
// rounded. It is a critical geometry primitive — every Material card, chip,
// dialog, modal sheet and pill button in the framework reduces to a
// BorderRadius applied to a BoxDecoration or a ShapeBorder. The class also
// has a directional sibling (BorderRadiusDirectional) for RTL safety, an
// elliptical Radius variant, a static lerp, and arithmetic operators
// (+, -, *, /, ~/, %) inherited from BorderRadiusGeometry.
//
// This demo systematically renders every constructor and every operator on
// real Containers so that the visual outcome of each call is immediately
// obvious. The structure is:
//
//   1. Hero header (rose to coral gradient).
//   2. Constructor catalog (.all, .circular, .only, .vertical, .horizontal,
//      .zero) with code label.
//   3. Per-corner showcase (each corner isolated).
//   4. Symmetric showcase (top, bottom, left, right halves).
//   5. Radius sweep (0..32 in 8 steps).
//   6. Elliptical radius (x vs y).
//   7. lerp showcase (5 frames between zero and circular(32)).
//   8. BorderRadiusDirectional (LTR vs RTL via Directionality).
//   9. Operators (+, *, -).
//  10. Comparison panel (BoxDecoration vs ShapeBorder).
//  11. Real-world examples (chip, asymmetric card, tab strip, modal).
//  12. Caveats (5 cards).
//  13. Footer takeaways.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------
  // PALETTE: rose / coral / peach.
  // ---------------------------------------------------------------------
  const Color roseDeep = Color(0xFFB71C5C);
  const Color roseMid = Color(0xFFE91E63);
  const Color roseSoft = Color(0xFFF8BBD0);
  const Color coralDeep = Color(0xFFD84315);
  const Color coralMid = Color(0xFFFF7043);
  const Color coralSoft = Color(0xFFFFCCBC);
  const Color peachDeep = Color(0xFFE65100);
  const Color peachMid = Color(0xFFFFB74D);
  const Color peachSoft = Color(0xFFFFE0B2);
  const Color cardSurface = Color(0xFFFFF8F5);
  const Color codeBg = Color(0xFF1F1B24);
  const Color codeFg = Color(0xFFE8E0E0);

  // ---------------------------------------------------------------------
  // SHADOW CATALOG.
  // ---------------------------------------------------------------------
  final BoxShadow shadowSoft = BoxShadow(
    color: roseMid.withValues(alpha: 0.22),
    blurRadius: 14.0,
    offset: const Offset(0.0, 6.0),
  );
  final BoxShadow shadowHard = BoxShadow(
    color: roseDeep.withValues(alpha: 0.32),
    blurRadius: 22.0,
    offset: const Offset(0.0, 10.0),
  );
  final BoxShadow shadowCoral = BoxShadow(
    color: coralMid.withValues(alpha: 0.30),
    blurRadius: 18.0,
    offset: const Offset(0.0, 8.0),
  );
  final BoxShadow shadowPeach = BoxShadow(
    color: peachDeep.withValues(alpha: 0.22),
    blurRadius: 12.0,
    offset: const Offset(0.0, 5.0),
  );
  final BoxShadow shadowDark = BoxShadow(
    color: Colors.black.withValues(alpha: 0.30),
    blurRadius: 16.0,
    offset: const Offset(0.0, 7.0),
  );

  // ---------------------------------------------------------------------
  // HELPER BUILDERS — pure functions, no state.
  // ---------------------------------------------------------------------

  Widget sectionHeader(
    String number,
    String title,
    IconData icon,
    Color tint,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            tint.withValues(alpha: 0.95),
            tint.withValues(alpha: 0.65),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[shadowSoft],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'SECTION $number',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: tint,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Icon(icon, color: Colors.white, size: 22.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String text, Color color, {Color? textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          color: textColor ?? color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget codeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: codeBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1.0,
        ),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          color: codeFg,
          height: 1.45,
        ),
      ),
    );
  }

  Widget caption(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.0,
          fontFamily: 'monospace',
          color: roseDeep.withValues(alpha: 0.85),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget paragraph(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.0,
          height: 1.5,
          color: color ?? const Color(0xFF3A2A2A),
        ),
      ),
    );
  }

  Widget cardFrame({
    required Widget child,
    EdgeInsets? padding,
    Color? color,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color ?? cardSurface,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[shadowPeach],
        border: Border.all(
          color: roseSoft.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: child,
    );
  }

  // Render a sample box of fixed size with the given BorderRadius and tint.
  // The fill color makes the radius visually obvious; a thin dark border
  // emphasises the shape's outline.
  Widget radiusSample(
    BorderRadiusGeometry radius,
    Color tint, {
    double width = 100.0,
    double height = 100.0,
    String? label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                tint.withValues(alpha: 0.95),
                tint.withValues(alpha: 0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: radius is BorderRadius ? radius : null,
            border: Border.all(
              color: tint.withValues(alpha: 0.85),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[shadowPeach],
          ),
          child: Center(
            child: label == null
                ? null
                : Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // Sample box that resolves directional radii against a TextDirection.
  Widget directionalSample(
    BorderRadiusDirectional radius,
    TextDirection direction,
    Color tint, {
    double width = 110.0,
    double height = 110.0,
    String? label,
  }) {
    final BorderRadius resolved = radius.resolve(direction);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            tint.withValues(alpha: 0.95),
            tint.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: resolved,
        border: Border.all(color: tint.withValues(alpha: 0.85), width: 1.5),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Center(
        child: label == null
            ? null
            : Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // SECTION 1 — HERO HEADER.
  // ---------------------------------------------------------------------
  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 18.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[roseDeep, roseMid, coralMid, coralDeep],
        stops: <double>[0.0, 0.4, 0.75, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[shadowHard],
    ),
    child: Row(
      children: <Widget>[
        // Rounded-square icon tile.
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.42),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.rounded_corner,
            size: 38.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'BorderRadius',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'painting / geometry / corner-rounding',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.92),
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: <Widget>[
                  chip('all', Colors.white, textColor: roseDeep),
                  chip('circular', Colors.white, textColor: roseDeep),
                  chip('only', Colors.white, textColor: roseDeep),
                  chip('vertical', Colors.white, textColor: roseDeep),
                  chip('horizontal', Colors.white, textColor: roseDeep),
                  chip('zero', Colors.white, textColor: roseDeep),
                  chip('lerp', Colors.white, textColor: roseDeep),
                  chip('directional', Colors.white, textColor: roseDeep),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 2 — CONSTRUCTOR CATALOG.
  // Six framed boxes, each demonstrating one constructor with a 100x100
  // Container + source-code label.
  // ---------------------------------------------------------------------
  Widget catalogEntry(
    String title,
    String code,
    BorderRadius radius,
    Color tint,
  ) {
    return Container(
      width: 156.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: roseSoft.withValues(alpha: 0.7), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8.0),
          Center(child: radiusSample(radius, tint, label: null)),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: codeBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: codeFg,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget constructorCatalog = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Constructor catalog',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Six factory constructors cover every common case. Each renders a '
          '100x100 Container with the resulting radius applied. The source '
          'code under the box reproduces the exact call.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            catalogEntry(
              'BorderRadius.all',
              'BorderRadius.all(\n'
                  '  Radius.circular(20),\n'
                  ')',
              const BorderRadius.all(Radius.circular(20.0)),
              roseMid,
            ),
            catalogEntry(
              'BorderRadius.circular',
              'BorderRadius\n'
                  '  .circular(20)',
              BorderRadius.circular(20.0),
              coralMid,
            ),
            catalogEntry(
              'BorderRadius.only',
              'BorderRadius.only(\n'
                  '  topLeft: r(24),\n'
                  '  bottomRight: r(24),\n'
                  ')',
              const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
              peachMid,
            ),
            catalogEntry(
              'BorderRadius.vertical',
              'BorderRadius.vertical(\n'
                  '  top: r(24),\n'
                  ')',
              const BorderRadius.vertical(top: Radius.circular(24.0)),
              roseDeep,
            ),
            catalogEntry(
              'BorderRadius.horizontal',
              'BorderRadius.horizontal(\n'
                  '  left: r(24),\n'
                  ')',
              const BorderRadius.horizontal(left: Radius.circular(24.0)),
              coralDeep,
            ),
            catalogEntry(
              'BorderRadius.zero',
              'BorderRadius.zero',
              BorderRadius.zero,
              peachDeep,
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 3 — PER-CORNER SHOWCASE.
  // Four panels, each isolating one corner with .only(<corner>: 24).
  // ---------------------------------------------------------------------
  Widget cornerPanel(String title, BorderRadius radius, Color tint) {
    return Container(
      width: 156.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          radiusSample(radius, tint, label: null),
          caption('only($title: r(24))'),
        ],
      ),
    );
  }

  final Widget cornerShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Per-corner showcase',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'BorderRadius.only lets each corner be rounded independently. Below, '
          'a 24-pixel radius is applied to one corner at a time — useful for '
          'tabs, drawers and asymmetric cards.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: <Widget>[
            cornerPanel(
              'topLeft',
              const BorderRadius.only(topLeft: Radius.circular(24.0)),
              roseMid,
            ),
            cornerPanel(
              'topRight',
              const BorderRadius.only(topRight: Radius.circular(24.0)),
              coralMid,
            ),
            cornerPanel(
              'bottomLeft',
              const BorderRadius.only(bottomLeft: Radius.circular(24.0)),
              peachMid,
            ),
            cornerPanel(
              'bottomRight',
              const BorderRadius.only(bottomRight: Radius.circular(24.0)),
              roseDeep,
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 4 — SYMMETRIC SHOWCASE (vertical / horizontal halves).
  // ---------------------------------------------------------------------
  Widget halfPanel(String title, String code, BorderRadius radius, Color tint) {
    return Container(
      width: 156.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          radiusSample(radius, tint, label: null),
          caption(code),
        ],
      ),
    );
  }

  final Widget symmetricShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Symmetric showcase',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'vertical and horizontal apply the same Radius to a pair of corners. '
          'They are short-hand for an equivalent .only(...) call but read more '
          'fluently and are const-friendly.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: <Widget>[
            halfPanel(
              'top only',
              'vertical(top: r(28))',
              const BorderRadius.vertical(top: Radius.circular(28.0)),
              roseMid,
            ),
            halfPanel(
              'bottom only',
              'vertical(bottom: r(28))',
              const BorderRadius.vertical(bottom: Radius.circular(28.0)),
              coralMid,
            ),
            halfPanel(
              'left only',
              'horizontal(left: r(28))',
              const BorderRadius.horizontal(left: Radius.circular(28.0)),
              peachMid,
            ),
            halfPanel(
              'right only',
              'horizontal(right: r(28))',
              const BorderRadius.horizontal(right: Radius.circular(28.0)),
              roseDeep,
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 5 — RADIUS SWEEP (0..32 in 8 steps).
  // ---------------------------------------------------------------------
  Widget sweepBox(double r, Color tint) {
    return Container(
      width: 64.0,
      height: 64.0,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            tint.withValues(alpha: 0.95),
            tint.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(r),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Center(
        child: Text(
          r.toInt().toString(),
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  final Widget radiusSweep = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Radius sweep 0 -> 32',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Eight 64x64 boxes show how a uniform circular radius scales from a '
          'sharp rectangle to a near-round shape. At ~half the side length the '
          'box becomes a full pill / circle.',
        ),
        const SizedBox(height: 10.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            sweepBox(0.0, roseMid),
            sweepBox(4.0, roseMid),
            sweepBox(8.0, coralMid),
            sweepBox(12.0, coralMid),
            sweepBox(16.0, peachMid),
            sweepBox(20.0, peachMid),
            sweepBox(28.0, roseDeep),
            sweepBox(32.0, roseDeep),
          ],
        ),
        const SizedBox(height: 8.0),
        codeBlock(
          'for (final r in <double>[0, 4, 8, 12, 16, 20, 28, 32])\n'
          '  Container(\n'
          '    decoration: BoxDecoration(\n'
          '      borderRadius: BorderRadius.circular(r),\n'
          '    ),\n'
          '  );',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 6 — ELLIPTICAL RADIUS.
  // ---------------------------------------------------------------------
  Widget ellipticalCard(String title, double rx, double ry, Color tint) {
    return Container(
      width: 168.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: 130.0,
            height: 70.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  tint.withValues(alpha: 0.95),
                  tint.withValues(alpha: 0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.elliptical(rx, ry)),
              boxShadow: <BoxShadow>[shadowPeach],
            ),
          ),
          caption('elliptical($rx, $ry)'),
        ],
      ),
    );
  }

  final Widget ellipticalShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Elliptical radius',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Radius.elliptical(x, y) lets the horizontal and vertical curve '
          'lengths differ. Useful for capsule shapes (rx = height) and for '
          'organic UI accents.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            ellipticalCard('wide', 40.0, 12.0, roseMid),
            ellipticalCard('tall', 12.0, 40.0, coralMid),
            ellipticalCard('round', 20.0, 20.0, peachMid),
            ellipticalCard('mixed', 30.0, 8.0, roseDeep),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 7 — LERP SHOWCASE.
  // BorderRadius.lerp(zero, circular(32), t) for t in [0, 0.25, 0.5, 0.75, 1].
  // ---------------------------------------------------------------------
  Widget lerpFrame(double t, Color tint) {
    final BorderRadius? r = BorderRadius.lerp(
      BorderRadius.zero,
      BorderRadius.circular(32.0),
      t,
    );
    return Container(
      width: 90.0,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 78.0,
            height: 78.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  tint.withValues(alpha: 0.95),
                  tint.withValues(alpha: 0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: r ?? BorderRadius.zero,
              boxShadow: <BoxShadow>[shadowPeach],
            ),
            child: Center(
              child: Text(
                't=${t.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget lerpShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'BorderRadius.lerp showcase',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'lerp(a, b, t) linearly interpolates each corner. Below, five frames '
          'tween BorderRadius.zero and BorderRadius.circular(32) at '
          't = 0, 0.25, 0.5, 0.75, 1. AnimatedContainer uses the same '
          'mechanism under the hood.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            lerpFrame(0.0, roseMid),
            lerpFrame(0.25, roseMid),
            lerpFrame(0.5, coralMid),
            lerpFrame(0.75, peachMid),
            lerpFrame(1.0, roseDeep),
          ],
        ),
        const SizedBox(height: 8.0),
        codeBlock(
          'BorderRadius.lerp(\n'
          '  BorderRadius.zero,\n'
          '  BorderRadius.circular(32),\n'
          '  t,\n'
          ');',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 8 — DIRECTIONAL (LTR vs RTL).
  // ---------------------------------------------------------------------
  const BorderRadiusDirectional directional = BorderRadiusDirectional.only(
    topStart: Radius.circular(24.0),
    bottomEnd: Radius.circular(24.0),
  );

  Widget directionalFrame(String title, TextDirection direction, Color tint) {
    return Container(
      width: 168.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.5), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          Directionality(
            textDirection: direction,
            child: directionalSample(directional, direction, tint),
          ),
          caption(
            direction == TextDirection.ltr
                ? 'resolve(LTR): TL + BR'
                : 'resolve(RTL): TR + BL',
          ),
        ],
      ),
    );
  }

  final Widget directionalShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'BorderRadiusDirectional',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Directional radii use topStart, topEnd, bottomStart, bottomEnd. '
          'When resolved against TextDirection.ltr they map to topLeft + '
          'bottomRight; under TextDirection.rtl they flip to topRight + '
          'bottomLeft. Same call, mirrored result.',
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            directionalFrame('LTR layout', TextDirection.ltr, roseMid),
            directionalFrame('RTL layout', TextDirection.rtl, coralMid),
          ],
        ),
        const SizedBox(height: 4.0),
        codeBlock(
          'const BorderRadiusDirectional.only(\n'
          '  topStart: Radius.circular(24),\n'
          '  bottomEnd: Radius.circular(24),\n'
          ').resolve(Directionality.of(context));',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 9 — OPERATORS (+, *, -).
  // ---------------------------------------------------------------------
  final BorderRadius opA = BorderRadius.circular(8.0);
  final BorderRadius opB = const BorderRadius.only(
    topLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(20.0),
  );

  // BorderRadiusGeometry.add returns a BorderRadiusGeometry; the concrete
  // subtype is BorderRadius when both operands are BorderRadius. We resolve
  // through TextDirection.ltr to obtain a concrete BorderRadius for use in
  // BoxDecoration.borderRadius.
  final BorderRadius opAdd = opA.add(opB).resolve(TextDirection.ltr);
  final BorderRadius opSub = opB.subtract(opA).resolve(TextDirection.ltr);
  final BorderRadius opMul = opB * 1.5;

  Widget operatorCard(
    String title,
    String code,
    BorderRadius before,
    BorderRadius after,
    Color tint,
  ) {
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  radiusSample(before, tint, width: 70.0, height: 70.0),
                  caption('before'),
                ],
              ),
              Icon(
                Icons.arrow_forward,
                color: tint.withValues(alpha: 0.7),
                size: 18.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  radiusSample(after, tint, width: 70.0, height: 70.0),
                  caption('after'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: codeBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: codeFg,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget operatorShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Operators: add, multiply, subtract',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'BorderRadius inherits arithmetic from BorderRadiusGeometry: + (add), '
          '- (subtract), *, /, ~/, %. Below, three operators are applied to '
          'the same operands. The resulting geometry is resolved through '
          'TextDirection.ltr to materialise a concrete BorderRadius.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            operatorCard(
              'add (a + b)',
              'circular(8).add(\n'
                  '  only(tl:20, br:20),\n'
                  ').resolve(ltr)',
              opB,
              opAdd,
              roseMid,
            ),
            operatorCard(
              'multiply (b * 1.5)',
              'only(tl:20, br:20)\n'
                  '  * 1.5',
              opB,
              opMul,
              coralMid,
            ),
            operatorCard(
              'subtract (b - a)',
              'only(tl:20, br:20)\n'
                  '  .subtract(\n'
                  '    circular(8),\n'
                  '  ).resolve(ltr)',
              opB,
              opSub,
              peachMid,
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 10 — COMPARISON: BoxDecoration.borderRadius vs ShapeDecoration
  // vs RoundedRectangleBorder.
  // ---------------------------------------------------------------------
  Widget comparisonCard(String title, String code, Widget sample, Color tint) {
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: tint,
            ),
          ),
          const SizedBox(height: 10.0),
          sample,
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: codeBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: codeFg,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparisonShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Where BorderRadius shows up',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Three Flutter primitives consume a BorderRadius. They render the '
          'same outline but expose different capabilities (custom paint, '
          'shadows, ink reactions, semantic shape).',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            comparisonCard(
              'BoxDecoration',
              'BoxDecoration(\n'
                  '  borderRadius:\n'
                  '   circular(20),\n'
                  ')',
              radiusSample(BorderRadius.circular(20.0), roseMid),
              roseMid,
            ),
            comparisonCard(
              'ShapeDecoration',
              'ShapeDecoration(\n'
                  '  shape:\n'
                  '   RoundedRect(\n'
                  '    radius: r(20),\n'
                  '   ),\n'
                  ')',
              Container(
                width: 100.0,
                height: 100.0,
                decoration: ShapeDecoration(
                  color: coralMid,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadows: <BoxShadow>[shadowCoral],
                ),
              ),
              coralMid,
            ),
            comparisonCard(
              'Material shape',
              'Material(\n'
                  '  shape:\n'
                  '   RoundedRect(\n'
                  '    radius: r(20),\n'
                  '   ),\n'
                  ')',
              Material(
                color: peachMid,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 4.0,
                child: const SizedBox(width: 100.0, height: 100.0),
              ),
              peachMid,
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 11 — REAL-WORLD EXAMPLES.
  // Chip pill, asymmetric card, tab strip, modal sheet.
  // ---------------------------------------------------------------------
  final Widget chipPill = Container(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[roseMid, coralMid],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(999.0),
      boxShadow: <BoxShadow>[shadowSoft],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(Icons.star, size: 14.0, color: Colors.white),
        SizedBox(width: 6.0),
        Text(
          'Featured',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 12.0,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );

  final Widget asymmetricCard = Container(
    width: 240.0,
    height: 80.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          coralMid.withValues(alpha: 0.95),
          peachMid.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28.0),
        bottomRight: Radius.circular(28.0),
        topRight: Radius.circular(6.0),
        bottomLeft: Radius.circular(6.0),
      ),
      boxShadow: <BoxShadow>[shadowCoral],
    ),
    child: const Center(
      child: Text(
        'Asymmetric card',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 15.0,
          letterSpacing: 0.4,
        ),
      ),
    ),
  );

  Widget tabSegment(String label, Color tint, BorderRadius radius) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(color: tint, borderRadius: radius),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  final Widget tabStrip = Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      tabSegment(
        'Active',
        roseMid,
        const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      const SizedBox(width: 4.0),
      tabSegment(
        'Inactive',
        coralMid.withValues(alpha: 0.55),
        const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      const SizedBox(width: 4.0),
      tabSegment(
        'Inactive',
        coralMid.withValues(alpha: 0.55),
        const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
    ],
  );

  final Widget modalSheet = Container(
    width: 280.0,
    height: 130.0,
    decoration: BoxDecoration(
      color: cardSurface,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28.0),
        topRight: Radius.circular(28.0),
      ),
      boxShadow: <BoxShadow>[shadowDark],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          width: 40.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: roseSoft,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Modal bottom sheet',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'top corners rounded only',
          style: TextStyle(
            fontSize: 12.0,
            color: roseDeep.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );

  final Widget realWorldShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Real-world examples',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        paragraph(
          'Most production UI shapes are just BorderRadius applied to a sized '
          'Container. Below: a pill chip (huge radius), an asymmetric card '
          '(diagonal corners), a tab strip (top corners only), a modal sheet '
          '(top corners only with shadow).',
        ),
        const SizedBox(height: 14.0),
        Center(child: chipPill),
        const SizedBox(height: 14.0),
        Center(child: asymmetricCard),
        const SizedBox(height: 14.0),
        Center(child: tabStrip),
        const SizedBox(height: 14.0),
        Center(child: modalSheet),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 12 — CAVEATS.
  // ---------------------------------------------------------------------
  Widget caveatCard(String title, String body, IconData icon, Color tint) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #59, P5(a)):
    // Original used an asymmetric Border (left: 4-dp tint accent, t/r/b: 1-dp
    // grey hairline) combined with borderRadius: 12 — Flutter asserts uniform
    // BorderSide.color when a radius is present. Refactored to uniform
    // Border.all(grey hairline) + ClipRRect(12) + IntrinsicHeight > Row(stretch)
    // with a 4-dp coloured accent Container as the left band. Considered P5(b)
    // (capture-and-assert) but rejected: Section 12 (Caveats) describes other
    // BorderRadius rules (directional vs absolute, RTL, max radius, clip,
    // performance) — none of them is the uniform-colors rule, so the offending
    // border pattern is incidental chrome, not a deliberate demonstration.
    // Same rationale as item 58 (border_directional_test.dart).
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: <BoxShadow>[shadowPeach],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4.0, color: tint),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: cardSurface,
                    border: Border.all(
                      color: roseSoft.withValues(alpha: 0.6),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: tint.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(icon, color: tint, size: 20.0),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800,
                                color: tint,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              body,
                              style: const TextStyle(
                                fontSize: 12.0,
                                height: 1.5,
                                color: Color(0xFF3A2A2A),
                              ),
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
      ),
    );
  }

  final Widget caveatsShowcase = cardFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Caveats',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: roseDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        caveatCard(
          'Directional vs absolute',
          'BorderRadius uses topLeft/topRight which never flip; '
              'BorderRadiusDirectional uses topStart/topEnd which DO flip with '
              'TextDirection. Mixing the two via add() is allowed but the '
              'result is BorderRadiusGeometry — call resolve(direction) before '
              'using it as BoxDecoration.borderRadius.',
          Icons.swap_horiz,
          roseMid,
        ),
        caveatCard(
          'RTL implications',
          'If your UI ships in RTL locales (Arabic, Hebrew, Persian), prefer '
              'BorderRadiusDirectional for shapes whose visual side is bound '
              'to the start/end of text (drawer, leading icon, breadcrumb). '
              'Use absolute BorderRadius only when the visual must NEVER mirror.',
          Icons.translate,
          coralMid,
        ),
        caveatCard(
          'Max radius vs box size',
          'When the radius exceeds half the smallest side, the renderer clamps '
              'corners so they meet at the centre — you get a pill / circle. '
              'For deterministic capsule shapes use Radius.circular(height / 2) '
              'or BorderRadius.circular(double.infinity) on a clipping widget.',
          Icons.crop_square,
          peachMid,
        ),
        caveatCard(
          'Clip interaction',
          'BorderRadius set on BoxDecoration only rounds the painted shape, '
              'not children. To round overflow content (Image, Ink) you also '
              'need ClipRRect, ClipPath, or Material(clipBehavior: ...). '
              'Without clipping, child widgets paint over the rounded corners.',
          Icons.crop,
          roseDeep,
        ),
        caveatCard(
          'Performance on large radii',
          'Very large radii combined with heavy effects (gradients, shadows, '
              'BackdropFilter) force the rasteriser to use saveLayer, which is '
              'expensive. For static large pills, prefer ShapeDecoration with a '
              'StadiumBorder, or pre-bake the shape via a custom CustomPainter.',
          Icons.speed,
          coralDeep,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // SECTION 13 — FOOTER.
  // ---------------------------------------------------------------------
  Widget takeaway(IconData icon, String text, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16.0, color: tint),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFF3A2A2A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          roseSoft.withValues(alpha: 0.65),
          coralSoft.withValues(alpha: 0.65),
          peachSoft.withValues(alpha: 0.65),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[shadowSoft],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: roseDeep,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.summarize,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: roseDeep,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        takeaway(
          Icons.check_circle,
          'BorderRadius is a 4-corner geometry primitive built on Radius; '
              'every constructor is a convenience over BorderRadius.only.',
          roseDeep,
        ),
        takeaway(
          Icons.check_circle,
          'Prefer BorderRadiusDirectional whenever the visual depends on '
              'reading direction; resolve(TextDirection) materialises it into '
              'an absolute BorderRadius.',
          coralDeep,
        ),
        takeaway(
          Icons.check_circle,
          'BorderRadius.lerp drives all radius animations (AnimatedContainer, '
              'PhysicalShape, decoration tweens); it interpolates each corner '
              'independently.',
          peachDeep,
        ),
        takeaway(
          Icons.check_circle,
          'Operators (+, -, *, /) come from BorderRadiusGeometry; combining '
              'absolute and directional radii returns a Geometry that must be '
              'resolved before painting.',
          roseMid,
        ),
        takeaway(
          Icons.check_circle,
          'BorderRadius only rounds painting — clip children separately with '
              'ClipRRect or Material(clipBehavior: hardEdge) to avoid overflow '
              'past the corners.',
          coralMid,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // FINAL ASSEMBLY.
  // ---------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFFFF3EE),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            heroHeader,
            sectionHeader('02', 'Constructor catalog', Icons.widgets, roseMid),
            constructorCatalog,
            sectionHeader(
              '03',
              'Per-corner showcase',
              Icons.crop_free,
              coralMid,
            ),
            cornerShowcase,
            sectionHeader(
              '04',
              'Symmetric showcase',
              Icons.view_agenda,
              peachMid,
            ),
            symmetricShowcase,
            sectionHeader('05', 'Radius sweep', Icons.tune, roseDeep),
            radiusSweep,
            sectionHeader(
              '06',
              'Elliptical radius',
              Icons.blur_circular,
              coralDeep,
            ),
            ellipticalShowcase,
            sectionHeader(
              '07',
              'BorderRadius.lerp',
              Icons.gradient,
              peachDeep,
            ),
            lerpShowcase,
            sectionHeader('08', 'Directional', Icons.swap_horiz, roseMid),
            directionalShowcase,
            sectionHeader('09', 'Operators', Icons.calculate, coralMid),
            operatorShowcase,
            sectionHeader(
              '10',
              'Where BorderRadius shows up',
              Icons.compare,
              peachMid,
            ),
            comparisonShowcase,
            sectionHeader(
              '11',
              'Real-world examples',
              Icons.dashboard,
              roseDeep,
            ),
            realWorldShowcase,
            sectionHeader('12', 'Caveats', Icons.warning_amber, coralDeep),
            caveatsShowcase,
            footer,
          ],
        ),
      ),
    ),
  );
}
