// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  SLATE MARBLE :: LeastSquaresSolver Lectern
// =============================================================================
//
//  THEME
//  -----
//  "Slate Marble" -- a cathedral mathematician's lectern. The page is slate
//  grey, veined with marble whites and pale greys; tables are ivory parchment
//  rolled across the lectern; plot points are ink-blue dots, fitted curves
//  are gold leaf laid down with a careful brush. The mood is the hush of a
//  university chapel just after morning lecture: chalk dust still in the air,
//  a battered hardback of Numerical Recipes open on the desk, and a very
//  patient mathematician explaining, again, what regression actually IS.
//
//  SUBJECT
//  -------
//  package:flutter/gestures.dart
//
//      LeastSquaresSolver(List<double> x, List<double> y, List<double> w)
//          A small polynomial-regression engine. Given parallel vectors of
//          observations (x, y) and per-observation weights (w), it returns
//          the coefficients of the polynomial of requested degree that
//          minimises the weighted sum of squared residuals.
//
//      PolynomialFit? solve(int degree)
//          Returns null for ill-posed problems (zero weights, more degrees
//          than observations, singular normal equations). Otherwise returns
//          a PolynomialFit with two fields:
//              List<double> coefficients   --  c0, c1, c2, ... cn
//              double       confidence      --  1 - SS_res / SS_tot, the
//                                              coefficient of determination
//                                              (R^2) of the fit.
//
//  WHY THIS LIVES IN GESTURES
//  --------------------------
//  Flutter's VelocityTracker keeps a rolling window of (timestamp, position)
//  samples. When the gesture system asks "how fast is the finger moving?",
//  the tracker hands the recent samples to a LeastSquaresSolver and asks for
//  a quadratic fit (degree=2). The first derivative of that quadratic at the
//  most recent timestamp IS the reported velocity; the confidence value
//  becomes the gating signal that decides whether the velocity is trusted
//  enough to drive a fling, or whether the gesture is downgraded to a tap.
//
//  So this tiny solver, tucked away in flutter/gestures, is the actual
//  arithmetic that converts a smear of touch points into the "feel" of a
//  scrollable list. Every flick of every list in every Flutter app passes
//  through it. That is worth a careful look.
//
//  THE LECTURE
//  -----------
//  This script is laid out like a lecture given at the lectern. Twelve
//  numbered sections walk the viewer from "what is regression" through to
//  "here is exactly what the solver did with this dataset, including the
//  ill-conditioned cases where it returned null."
//
//      Section 1  Title plate and palette swatches.
//      Section 2  Mathematical primer -- weighted least squares.
//      Section 3  Algorithm overview -- normal equations, Cholesky, R^2.
//      Section 4  Six worked datasets, each rendered as:
//                     - an ivory parchment table of (i, x, y, w) rows,
//                     - the fits at degree 1, 2, and 3,
//                     - a small ink-and-gold scatter plot.
//      Section 5  Polynomial overlay charts -- one per dataset.
//      Section 6  Velocity-tracker context: how this all becomes px/s.
//      Section 7  Confidence interpretation -- when to trust the answer.
//      Section 8  Edge cases -- degenerate data, all-zero weights, too
//                 few samples, duplicated x.
//      Section 9  DO / AVOID rules of regression for gesture work.
//      Section 10 Glossary of terms.
//      Section 11 Recipe cards -- four canonical patterns.
//      Section 12 Recap footer -- closing motto in gold leaf.
//
//  RULES OF THE ROAD (D4RT CONSTRAINTS)
//  ------------------------------------
//      * build(BuildContext) is invoked exactly ONCE; we return a frozen
//        widget tree.
//      * No StatefulWidget, no setState, no controllers, no timers.
//      * No streams, no futures, no animation tickers.
//      * No `for-in` loops over BridgedInstance values; indexed access only.
//      * No `.value` reads on Tween.animate(...) results.
//      * Use `Color.withValues(alpha: ...)` instead of `withOpacity`.
//      * Real identifiers from package:flutter/gestures.dart only.
//
//  ATTRIBUTION
//  -----------
//  Slate Marble is a fictional design language invented for this teaching
//  artifact. It is the colour of a Cambridge college lecture hall on a
//  rainy October morning, the smell of damp wool coats, and the precise
//  arithmetic of a mathematician who has explained the normal equations
//  three hundred times and would happily explain them again.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// ---------------------------------------------------------------------------
// PALETTE -- "Slate Marble"
// ---------------------------------------------------------------------------

const Color kSlateDeep         = Color(0xFF2A2F36); // deepest slate backdrop
const Color kSlate             = Color(0xFF3A4048); // panel surface
const Color kSlateLight        = Color(0xFF4E545E); // raised slate tile
const Color kMarbleVein        = Color(0xFF8E96A2); // marble vein highlight
const Color kMarblePale        = Color(0xFFC8CDD4); // pale marble facing
const Color kIvoryParchment    = Color(0xFFF3EAD3); // table parchment
const Color kIvorySoft         = Color(0xFFEFE6CC); // soft callout
const Color kInkBlue           = Color(0xFF1F3A6E); // plot points
const Color kInkBlueDeep       = Color(0xFF14264A); // primary text on parchment
const Color kGoldLeaf          = Color(0xFFC9A24A); // fitted curve
const Color kGoldLeafDeep      = Color(0xFF8E6E1E); // gold accent stroke
const Color kChalkWhite        = Color(0xFFE8EAEE); // chalk text on slate
const Color kChalkDim          = Color(0xFFB6BCC6); // dim chalk on slate
const Color kCrimsonSeal       = Color(0xFFA13B2C); // AVOID seal
const Color kBrassRule         = Color(0xFF7A6A3A); // ruled border
const Color kVerdigris         = Color(0xFF4E7A6E); // accent for confidence

// ---------------------------------------------------------------------------
// TYPOGRAPHY HELPERS
// ---------------------------------------------------------------------------

TextStyle _h1() => const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: kChalkWhite,
      letterSpacing: 0.5,
    );

TextStyle _h2() => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: kChalkWhite,
      letterSpacing: 0.3,
    );

TextStyle _h3() => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kChalkWhite,
    );

TextStyle _body() => const TextStyle(
      fontSize: 13,
      height: 1.5,
      color: kChalkDim,
    );

TextStyle _bodyDark() => const TextStyle(
      fontSize: 13,
      height: 1.5,
      color: kInkBlueDeep,
    );

TextStyle _mono() => const TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      color: kChalkWhite,
      height: 1.4,
    );

TextStyle _monoDark() => const TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      color: kInkBlueDeep,
      height: 1.4,
    );

TextStyle _label() => const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.4,
      color: kGoldLeaf,
    );

TextStyle _labelDark() => const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.4,
      color: kGoldLeafDeep,
    );

// ---------------------------------------------------------------------------
// LITTLE BUILDING BLOCKS
// ---------------------------------------------------------------------------

Widget _gapW(double w) => SizedBox(width: w);

Widget _goldRule() => Container(
      height: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kGoldLeafDeep.withValues(alpha: 0.0),
            kGoldLeaf.withValues(alpha: 0.85),
            kGoldLeafDeep.withValues(alpha: 0.0),
          ],
        ),
      ),
    );

// ---------------------------------------------------------------------------
// SWATCH WIDGET -- a small ivory parchment chip showing one palette colour.
// ---------------------------------------------------------------------------
Widget _swatch(Color c, String name, String purpose) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.all(8),
    width: 188,
    decoration: BoxDecoration(
      color: kIvoryParchment,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kInkBlueDeep.withValues(alpha: 0.30)),
          ),
        ),
        _gapW(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: kInkBlueDeep)),
              const SizedBox(height: 2),
              Text(purpose,
                  style: const TextStyle(
                      fontSize: 10.5, color: kInkBlueDeep, height: 1.25)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION HEADER -- gold rule, all-caps section number, h2 title.
// ---------------------------------------------------------------------------
Widget _sectionHeader(String number, String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _goldRule(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('SECTION $number', style: _label()),
          _gapW(12),
          Container(
            width: 1,
            height: 14,
            color: kGoldLeaf.withValues(alpha: 0.6),
          ),
          _gapW(12),
          Expanded(child: Text(title, style: _h2())),
        ],
      ),
      const SizedBox(height: 4),
      Text(subtitle, style: _body()),
      const SizedBox(height: 12),
    ],
  );
}

// ---------------------------------------------------------------------------
// PARCHMENT CARD -- ivory background, brass border, padded content.
// ---------------------------------------------------------------------------
Widget _parchment({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: padding ?? const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kIvoryParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.55), width: 1),
      boxShadow: [
        BoxShadow(
          color: kSlateDeep.withValues(alpha: 0.35),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

// ---------------------------------------------------------------------------
// SLATE TILE -- raised slate panel for prose on dark background.
// ---------------------------------------------------------------------------
Widget _slateTile({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: padding ?? const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kSlate,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kMarbleVein.withValues(alpha: 0.35)),
    ),
    child: child,
  );
}

// ---------------------------------------------------------------------------
// MARBLE VEIN STRIPE -- a thin decorative stripe used between sections.
// ---------------------------------------------------------------------------
Widget _marbleStripe() {
  return Container(
    height: 6,
    margin: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      gradient: const LinearGradient(
        colors: [
          kSlateDeep,
          kMarbleVein,
          kMarblePale,
          kMarbleVein,
          kSlateDeep,
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// EQUATION TILE -- centred mathematical expression on parchment.
// ---------------------------------------------------------------------------
Widget _equation(String expr, {String? caption}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    decoration: BoxDecoration(
      color: kIvorySoft,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          expr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.5,
            fontFamily: 'monospace',
            color: kInkBlueDeep,
            height: 1.5,
          ),
        ),
        if (caption != null) ...[
          const SizedBox(height: 6),
          Text(caption,
              style: const TextStyle(
                  fontSize: 11,
                  color: kInkBlueDeep,
                  fontStyle: FontStyle.italic)),
        ]
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// FORMAT HELPERS
// ---------------------------------------------------------------------------
String _fmt(double v, {int frac = 4}) {
  if (v.isNaN) return 'NaN';
  if (v.isInfinite) return v.isNegative ? '-Inf' : '+Inf';
  return v.toStringAsFixed(frac);
}

String _fmtSigned(double v, {int frac = 4}) {
  final String s = _fmt(v.abs(), frac: frac);
  return v < 0 ? '-$s' : '+$s';
}

String _polyExpr(List<double> c) {
  // c0 + c1 x + c2 x^2 + ...
  final StringBuffer sb = StringBuffer();
  for (int i = 0; i < c.length; i++) {
    final double v = c[i];
    if (i == 0) {
      sb.write(_fmt(v, frac: 4));
    } else {
      sb.write(' ');
      sb.write(_fmtSigned(v, frac: 4));
      if (i == 1) {
        sb.write(' x');
      } else {
        sb.write(' x^$i');
      }
    }
  }
  return sb.toString();
}

double _evalPoly(List<double> c, double x) {
  double acc = 0.0;
  double xp = 1.0;
  for (int i = 0; i < c.length; i++) {
    acc = acc + c[i] * xp;
    xp = xp * x;
  }
  return acc;
}

// ---------------------------------------------------------------------------
// DATASET RECORD -- a single labelled dataset with prose and three solves.
// ---------------------------------------------------------------------------
class _Dataset {
  final String code;        // 'D1', 'D2', ...
  final String title;       // 'Linear ascent'
  final String narrative;   // one or two paragraphs of lecture prose
  final List<double> xs;
  final List<double> ys;
  final List<double> ws;
  final PolynomialFit? fit1;
  final PolynomialFit? fit2;
  final PolynomialFit? fit3;
  final Color accent;

  const _Dataset({
    required this.code,
    required this.title,
    required this.narrative,
    required this.xs,
    required this.ys,
    required this.ws,
    required this.fit1,
    required this.fit2,
    required this.fit3,
    required this.accent,
  });
}

// ---------------------------------------------------------------------------
// SOLVE-ALL HELPER -- builds the three fits for a dataset.
// Catches solver returns of null gracefully.
// ---------------------------------------------------------------------------
_Dataset _buildDataset({
  required String code,
  required String title,
  required String narrative,
  required List<double> xs,
  required List<double> ys,
  required List<double> ws,
  required Color accent,
}) {
  final LeastSquaresSolver solver = LeastSquaresSolver(xs, ys, ws);
  PolynomialFit? f1;
  PolynomialFit? f2;
  PolynomialFit? f3;
  try {
    f1 = solver.solve(1);
  } catch (_) {
    f1 = null;
  }
  try {
    f2 = solver.solve(2);
  } catch (_) {
    f2 = null;
  }
  try {
    f3 = solver.solve(3);
  } catch (_) {
    f3 = null;
  }
  return _Dataset(
    code: code,
    title: title,
    narrative: narrative,
    xs: xs,
    ys: ys,
    ws: ws,
    fit1: f1,
    fit2: f2,
    fit3: f3,
    accent: accent,
  );
}

// ---------------------------------------------------------------------------
// SAMPLE TABLE -- ivory parchment, columns: i, x, y, w.
// ---------------------------------------------------------------------------
Widget _sampleTable(_Dataset d) {
  final List<TableRow> rows = <TableRow>[];
  rows.add(TableRow(
    decoration: BoxDecoration(color: kInkBlueDeep.withValues(alpha: 0.10)),
    children: [
      _th('i'),
      _th('x'),
      _th('y'),
      _th('w'),
    ],
  ));
  for (int i = 0; i < d.xs.length; i++) {
    rows.add(TableRow(
      children: [
        _td(i.toString()),
        _td(_fmt(d.xs[i], frac: 3)),
        _td(_fmt(d.ys[i], frac: 3)),
        _td(_fmt(d.ws[i], frac: 3)),
      ],
    ));
  }
  return Table(
    columnWidths: const {
      0: FixedColumnWidth(36),
      1: FlexColumnWidth(1.2),
      2: FlexColumnWidth(1.2),
      3: FlexColumnWidth(1.0),
    },
    border: TableBorder.all(
        color: kBrassRule.withValues(alpha: 0.4), width: 0.6),
    children: rows,
  );
}

Widget _th(String s) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Text(s,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            fontSize: 12,
            color: kInkBlueDeep,
            letterSpacing: 0.5,
          )),
    );

Widget _td(String s) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Text(s,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: kInkBlueDeep,
          )),
    );

// ---------------------------------------------------------------------------
// FIT BLOCK -- formats a single PolynomialFit into a parchment block.
// ---------------------------------------------------------------------------
Widget _fitBlock(int degree, PolynomialFit? fit) {
  if (fit == null) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: kCrimsonSeal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kCrimsonSeal.withValues(alpha: 0.55)),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kCrimsonSeal,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text('$degree',
                style: const TextStyle(
                    color: kIvoryParchment,
                    fontWeight: FontWeight.w800,
                    fontSize: 12)),
          ),
          _gapW(8),
          Expanded(
            child: Text(
                'solve($degree) returned null -- problem ill-posed for this degree',
                style: const TextStyle(
                    fontSize: 12,
                    color: kInkBlueDeep,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
  final List<double> coeffs = <double>[];
  for (int i = 0; i < fit.coefficients.length; i++) {
    coeffs.add(fit.coefficients[i]);
  }
  final double conf = fit.confidence;
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: kIvorySoft,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGoldLeaf,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text('$degree',
                  style: const TextStyle(
                      color: kInkBlueDeep,
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ),
            _gapW(8),
            Text('degree-$degree fit',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: kInkBlueDeep)),
            const Spacer(),
            _confidenceChip(conf),
          ],
        ),
        const SizedBox(height: 6),
        Text('y(x) = ${_polyExpr(coeffs)}', style: _monoDark()),
        const SizedBox(height: 4),
        _coefficientList(coeffs),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// COEFFICIENT LIST -- one labelled chip per coefficient.
// ---------------------------------------------------------------------------
Widget _coefficientList(List<double> coeffs) {
  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < coeffs.length; i++) {
    chips.add(Container(
      margin: const EdgeInsets.only(right: 6, top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kInkBlueDeep.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: kInkBlueDeep.withValues(alpha: 0.20)),
      ),
      child: Text('c$i = ${_fmt(coeffs[i], frac: 5)}',
          style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: kInkBlueDeep)),
    ));
  }
  return Wrap(children: chips);
}

// ---------------------------------------------------------------------------
// CONFIDENCE CHIP -- coloured by quality.
// ---------------------------------------------------------------------------
Widget _confidenceChip(double conf) {
  Color bg;
  String label;
  if (conf >= 0.95) {
    bg = kVerdigris;
    label = 'EXCELLENT';
  } else if (conf >= 0.80) {
    bg = kGoldLeaf;
    label = 'GOOD';
  } else if (conf >= 0.50) {
    bg = kBrassRule;
    label = 'FAIR';
  } else {
    bg = kCrimsonSeal;
    label = 'POOR';
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      'R^2 ${_fmt(conf, frac: 4)} $label',
      style: const TextStyle(
        color: kIvoryParchment,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.7,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SCATTER+FIT PLOT -- a Stack of Containers acting as a chart.
// Ink-blue dots = samples; gold-leaf sprite chain = fitted polynomial.
// No CustomPainter is required to satisfy the demo: the entire chart is
// composed from bare positioned Containers laid into a fixed bounding box.
// ---------------------------------------------------------------------------
Widget _scatterPlot({
  required List<double> xs,
  required List<double> ys,
  required PolynomialFit? fit,
  required Color accent,
  double height = 180,
  double width = 360,
}) {
  // Compute bounds.
  double minX = xs[0];
  double maxX = xs[0];
  double minY = ys[0];
  double maxY = ys[0];
  for (int i = 1; i < xs.length; i++) {
    if (xs[i] < minX) minX = xs[i];
    if (xs[i] > maxX) maxX = xs[i];
    if (ys[i] < minY) minY = ys[i];
    if (ys[i] > maxY) maxY = ys[i];
  }
  // Include polynomial extreme values in y bounds.
  if (fit != null) {
    final List<double> coeffs = <double>[];
    for (int i = 0; i < fit.coefficients.length; i++) {
      coeffs.add(fit.coefficients[i]);
    }
    for (int s = 0; s <= 24; s++) {
      final double t = s / 24.0;
      final double x = minX + (maxX - minX) * t;
      final double y = _evalPoly(coeffs, x);
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
    }
  }
  final double spanX = (maxX - minX).abs() < 1e-9 ? 1.0 : (maxX - minX);
  final double spanY = (maxY - minY).abs() < 1e-9 ? 1.0 : (maxY - minY);
  final double pad = 14.0;
  final double plotW = width - pad * 2;
  final double plotH = height - pad * 2;

  double xToPx(double x) => pad + (x - minX) / spanX * plotW;
  double yToPx(double y) => pad + (1 - (y - minY) / spanY) * plotH;

  final List<Widget> children = <Widget>[];

  // Backdrop.
  children.add(Positioned.fill(
    child: Container(
      decoration: BoxDecoration(
        color: kIvoryParchment,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kBrassRule.withValues(alpha: 0.5)),
      ),
    ),
  ));

  // Gridlines (5 horizontal, 5 vertical) -- thin marble grey.
  for (int g = 0; g <= 5; g++) {
    final double yy = pad + plotH * g / 5.0;
    children.add(Positioned(
      left: pad,
      top: yy,
      child: Container(
        width: plotW,
        height: 0.5,
        color: kMarbleVein.withValues(alpha: 0.35),
      ),
    ));
    final double xx = pad + plotW * g / 5.0;
    children.add(Positioned(
      left: xx,
      top: pad,
      child: Container(
        width: 0.5,
        height: plotH,
        color: kMarbleVein.withValues(alpha: 0.35),
      ),
    ));
  }

  // Polynomial curve as a chain of small gold-leaf squares.
  if (fit != null) {
    final List<double> coeffs = <double>[];
    for (int i = 0; i < fit.coefficients.length; i++) {
      coeffs.add(fit.coefficients[i]);
    }
    const int steps = 80;
    for (int s = 0; s < steps; s++) {
      final double t = s / (steps - 1);
      final double x = minX + (maxX - minX) * t;
      final double y = _evalPoly(coeffs, x);
      final double px = xToPx(x);
      final double py = yToPx(y);
      children.add(Positioned(
        left: px - 1.5,
        top: py - 1.5,
        child: Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: kGoldLeaf,
            shape: BoxShape.circle,
          ),
        ),
      ));
    }
  }

  // Scatter dots in ink-blue with a tiny accent ring.
  for (int i = 0; i < xs.length; i++) {
    final double px = xToPx(xs[i]);
    final double py = yToPx(ys[i]);
    children.add(Positioned(
      left: px - 5,
      top: py - 5,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: kInkBlue,
          shape: BoxShape.circle,
          border: Border.all(color: accent, width: 1.2),
        ),
      ),
    ));
  }

  // Axis labels (corners only).
  children.add(Positioned(
    left: 4,
    top: 2,
    child: Text('y', style: _labelDark()),
  ));
  children.add(Positioned(
    right: 4,
    bottom: 2,
    child: Text('x', style: _labelDark()),
  ));
  children.add(Positioned(
    left: 4,
    bottom: 2,
    child: Text('(${_fmt(minX, frac: 1)}, ${_fmt(minY, frac: 1)})',
        style: const TextStyle(
            fontSize: 9.5,
            color: kInkBlueDeep,
            fontFamily: 'monospace')),
  ));
  children.add(Positioned(
    right: 4,
    top: 2,
    child: Text('(${_fmt(maxX, frac: 1)}, ${_fmt(maxY, frac: 1)})',
        style: const TextStyle(
            fontSize: 9.5,
            color: kInkBlueDeep,
            fontFamily: 'monospace')),
  ));

  return SizedBox(
    width: width,
    height: height,
    child: Stack(children: children),
  );
}

// ---------------------------------------------------------------------------
// OVERLAY CHART -- three fits (deg 1, 2, 3) on the same plot, distinguished
// by accent colour. Helps the viewer SEE how more degrees curl the curve.
// ---------------------------------------------------------------------------
Widget _overlayPlot(_Dataset d, {double height = 220, double width = 380}) {
  // Bounds from data.
  double minX = d.xs[0];
  double maxX = d.xs[0];
  double minY = d.ys[0];
  double maxY = d.ys[0];
  for (int i = 1; i < d.xs.length; i++) {
    if (d.xs[i] < minX) minX = d.xs[i];
    if (d.xs[i] > maxX) maxX = d.xs[i];
    if (d.ys[i] < minY) minY = d.ys[i];
    if (d.ys[i] > maxY) maxY = d.ys[i];
  }
  // Expand bounds with each fit's curve samples.
  final List<PolynomialFit?> fits = <PolynomialFit?>[d.fit1, d.fit2, d.fit3];
  for (int f = 0; f < fits.length; f++) {
    final PolynomialFit? cur = fits[f];
    if (cur == null) continue;
    final List<double> coeffs = <double>[];
    for (int i = 0; i < cur.coefficients.length; i++) {
      coeffs.add(cur.coefficients[i]);
    }
    for (int s = 0; s <= 24; s++) {
      final double t = s / 24.0;
      final double x = minX + (maxX - minX) * t;
      final double y = _evalPoly(coeffs, x);
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
    }
  }
  final double spanX = (maxX - minX).abs() < 1e-9 ? 1.0 : (maxX - minX);
  final double spanY = (maxY - minY).abs() < 1e-9 ? 1.0 : (maxY - minY);
  final double pad = 18.0;
  final double plotW = width - pad * 2;
  final double plotH = height - pad * 2;

  double xToPx(double x) => pad + (x - minX) / spanX * plotW;
  double yToPx(double y) => pad + (1 - (y - minY) / spanY) * plotH;

  final List<Widget> children = <Widget>[];
  children.add(Positioned.fill(
    child: Container(
      decoration: BoxDecoration(
        color: kSlateLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kMarbleVein.withValues(alpha: 0.35)),
      ),
    ),
  ));

  // Gridlines.
  for (int g = 0; g <= 6; g++) {
    final double yy = pad + plotH * g / 6.0;
    children.add(Positioned(
      left: pad,
      top: yy,
      child: Container(
        width: plotW,
        height: 0.5,
        color: kMarblePale.withValues(alpha: 0.20),
      ),
    ));
    final double xx = pad + plotW * g / 6.0;
    children.add(Positioned(
      left: xx,
      top: pad,
      child: Container(
        width: 0.5,
        height: plotH,
        color: kMarblePale.withValues(alpha: 0.20),
      ),
    ));
  }

  // Curve colours per degree.
  final List<Color> degreeColors = <Color>[
    kVerdigris,    // deg 1 -- straight line, calm green
    kGoldLeaf,     // deg 2 -- the gestures-default
    kCrimsonSeal,  // deg 3 -- often overfit
  ];

  for (int f = 0; f < fits.length; f++) {
    final PolynomialFit? cur = fits[f];
    if (cur == null) continue;
    final List<double> coeffs = <double>[];
    for (int i = 0; i < cur.coefficients.length; i++) {
      coeffs.add(cur.coefficients[i]);
    }
    const int steps = 90;
    for (int s = 0; s < steps; s++) {
      final double t = s / (steps - 1);
      final double x = minX + (maxX - minX) * t;
      final double y = _evalPoly(coeffs, x);
      final double px = xToPx(x);
      final double py = yToPx(y);
      children.add(Positioned(
        left: px - 1.25,
        top: py - 1.25,
        child: Container(
          width: 2.5,
          height: 2.5,
          decoration: BoxDecoration(
            color: degreeColors[f],
            shape: BoxShape.circle,
          ),
        ),
      ));
    }
  }

  // Scatter dots.
  for (int i = 0; i < d.xs.length; i++) {
    final double px = xToPx(d.xs[i]);
    final double py = yToPx(d.ys[i]);
    children.add(Positioned(
      left: px - 4.5,
      top: py - 4.5,
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: kChalkWhite,
          shape: BoxShape.circle,
          border: Border.all(color: kInkBlueDeep, width: 1.4),
        ),
      ),
    ));
  }

  // Legend.
  children.add(Positioned(
    right: 6,
    top: 6,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: kSlateDeep.withValues(alpha: 0.70),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _legendDot('deg 1', degreeColors[0]),
          _legendDot('deg 2', degreeColors[1]),
          _legendDot('deg 3', degreeColors[2]),
        ],
      ),
    ),
  ));

  return SizedBox(
    width: width,
    height: height,
    child: Stack(children: children),
  );
}

Widget _legendDot(String label, Color c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: kChalkWhite,
                fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// DATASET CARD -- the full per-dataset composition: title, narrative,
// table, three fits, scatter plot.
// ---------------------------------------------------------------------------
Widget _datasetCard(_Dataset d) {
  return _parchment(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: d.accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(d.code,
                  style: const TextStyle(
                      color: kIvoryParchment,
                      fontWeight: FontWeight.w800,
                      fontSize: 11)),
            ),
            _gapW(10),
            Expanded(
              child: Text(d.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kInkBlueDeep,
                    letterSpacing: 0.3,
                  )),
            ),
            Text('n = ${d.xs.length}', style: _labelDark()),
          ],
        ),
        const SizedBox(height: 8),
        Text(d.narrative, style: _bodyDark()),
        const SizedBox(height: 10),
        Container(height: 1, color: kBrassRule.withValues(alpha: 0.4)),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: sample table
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SAMPLES', style: _labelDark()),
                  const SizedBox(height: 6),
                  _sampleTable(d),
                ],
              ),
            ),
            _gapW(14),
            // RIGHT: scatter plot of degree-2 fit (the gestures default)
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SCATTER + DEG-2 FIT', style: _labelDark()),
                  const SizedBox(height: 6),
                  _scatterPlot(
                    xs: d.xs,
                    ys: d.ys,
                    fit: d.fit2,
                    accent: d.accent,
                    height: 200,
                    width: 320,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: kBrassRule.withValues(alpha: 0.4)),
        const SizedBox(height: 8),
        Text('FITS', style: _labelDark()),
        const SizedBox(height: 6),
        _fitBlock(1, d.fit1),
        _fitBlock(2, d.fit2),
        _fitBlock(3, d.fit3),
        const SizedBox(height: 4),
        _residualsBlock(d),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// RESIDUALS BLOCK -- per-sample residuals from the degree-2 fit shown as
// horizontal bars proportional to |y - y_hat|.
// ---------------------------------------------------------------------------
Widget _residualsBlock(_Dataset d) {
  if (d.fit2 == null) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kCrimsonSeal.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'Residuals unavailable -- the degree-2 fit was not computable.',
        style: TextStyle(
            fontSize: 11.5,
            color: kInkBlueDeep,
            fontStyle: FontStyle.italic),
      ),
    );
  }
  final List<double> coeffs = <double>[];
  for (int i = 0; i < d.fit2!.coefficients.length; i++) {
    coeffs.add(d.fit2!.coefficients[i]);
  }
  // Compute residuals.
  final List<double> resids = <double>[];
  double maxAbs = 1e-9;
  for (int i = 0; i < d.xs.length; i++) {
    final double yh = _evalPoly(coeffs, d.xs[i]);
    final double r = d.ys[i] - yh;
    resids.add(r);
    if (r.abs() > maxAbs) maxAbs = r.abs();
  }
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < d.xs.length; i++) {
    final double r = resids[i];
    final double frac = (r.abs() / maxAbs).clamp(0.0, 1.0);
    final Color barColor =
        r >= 0 ? kVerdigris : kCrimsonSeal.withValues(alpha: 0.85);
    rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text('i$i',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: kInkBlueDeep)),
          ),
          SizedBox(
            width: 64,
            child: Text(_fmtSigned(r, frac: 4),
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: kInkBlueDeep)),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: kInkBlueDeep.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: frac,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kIvorySoft,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RESIDUALS (degree 2: y - y_hat)', style: _labelDark()),
        const SizedBox(height: 6),
        ...rows,
        const SizedBox(height: 4),
        Text(
          'Max |residual| = ${_fmt(maxAbs, frac: 4)}.  Green bars are positive '
          '(measurement above fit); red bars are negative (below fit).',
          style: const TextStyle(
              fontSize: 10.5,
              color: kInkBlueDeep,
              fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CALL-OUT -- a single titled paragraph in slate or parchment.
// ---------------------------------------------------------------------------
Widget _calloutSlate(String label, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSlateLight,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kMarbleVein.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _label()),
        const SizedBox(height: 4),
        Text(body, style: _body()),
      ],
    ),
  );
}

Widget _calloutDoSlate(String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kVerdigris.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: kVerdigris.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          margin: const EdgeInsets.only(right: 8, top: 1),
          decoration: BoxDecoration(
            color: kVerdigris,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text('DO',
              style: TextStyle(
                  color: kIvoryParchment,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0)),
        ),
        Expanded(child: Text(body, style: _body())),
      ],
    ),
  );
}

Widget _calloutAvoidSlate(String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kCrimsonSeal.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: kCrimsonSeal.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          margin: const EdgeInsets.only(right: 8, top: 1),
          decoration: BoxDecoration(
            color: kCrimsonSeal,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text('AVOID',
              style: TextStyle(
                  color: kIvoryParchment,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0)),
        ),
        Expanded(child: Text(body, style: _body())),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// GLOSSARY ENTRY -- term + definition on parchment.
// ---------------------------------------------------------------------------
Widget _glossaryEntry(String term, String def) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kIvoryParchment,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: kBrassRule.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(term,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kInkBlueDeep)),
        const SizedBox(height: 3),
        Text(def, style: _bodyDark()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// RECIPE CARD -- a small code-pattern card.
// ---------------------------------------------------------------------------
Widget _recipeCard(String title, String code, String comment) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kSlateLight,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kGoldLeaf.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _h3()),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kSlateDeep,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(code, style: _mono()),
        ),
        const SizedBox(height: 6),
        Text(comment, style: _body()),
      ],
    ),
  );
}

// =============================================================================
// build() -- the single static entry point. D4rt invokes this exactly once.
// =============================================================================
dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // CONSTRUCT THE SIX TEACHING DATASETS UP FRONT.
  // Each dataset is a hand-curated story: a clean linear ramp, a curving
  // quadratic, a wiggling cubic, a noisy linear ramp, a velocity-tracker
  // style window of touch samples, and a degenerate near-singular case.
  // -------------------------------------------------------------------------

  final _Dataset d1 = _buildDataset(
    code: 'D1',
    title: 'Linear ascent  --  perfectly clean line',
    narrative:
        'Five samples lie exactly on the line y = 1 + 2 x. All weights '
        'are unity. We expect the degree-1 fit to be perfect (R^2 = 1.0). '
        'The degree-2 and degree-3 fits should also be effectively '
        'perfect; the higher-order coefficients should hover near zero, '
        'showing the solver does NOT spuriously bend a straight line.',
    xs: const <double>[0.0, 1.0, 2.0, 3.0, 4.0],
    ys: const <double>[1.0, 3.0, 5.0, 7.0, 9.0],
    ws: const <double>[1.0, 1.0, 1.0, 1.0, 1.0],
    accent: kVerdigris,
  );

  final _Dataset d2 = _buildDataset(
    code: 'D2',
    title: 'Quadratic curve  --  acceleration profile',
    narrative:
        'Six samples on the parabola y = 0.5 + 1.0 x + 0.5 x^2 with unit '
        'weights. This is the canonical "constant acceleration" curve: '
        'position vs. time for a finger that is speeding up smoothly. '
        'The degree-2 fit should reproduce the parabola exactly; degree 1 '
        'will under-fit, degree 3 will over-fit but still be accurate.',
    xs: const <double>[0.0, 1.0, 2.0, 3.0, 4.0, 5.0],
    ys: const <double>[0.5, 2.0, 4.5, 8.0, 12.5, 18.0],
    ws: const <double>[1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
    accent: kGoldLeaf,
  );

  final _Dataset d3 = _buildDataset(
    code: 'D3',
    title: 'Cubic wiggle  --  jerky finger motion',
    narrative:
        'Eight samples drawn from y = 0.2 + 0.4 x - 0.6 x^2 + 0.2 x^3. '
        'This is the kind of wiggle you see when a finger pauses, '
        'reverses slightly, and then continues. Degree 1 is hopeless, '
        'degree 2 captures the broad trend, and degree 3 nails it.',
    xs: const <double>[0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5],
    ys: const <double>[
      0.20,
      0.275,
      0.20,
      0.05,
      0.00,
      0.175,
      0.65,
      1.575,
    ],
    ws: const <double>[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
    accent: kCrimsonSeal,
  );

  final _Dataset d4 = _buildDataset(
    code: 'D4',
    title: 'Noisy linear  --  a real-looking touch trace',
    narrative:
        'Ten samples from a noisy version of y = 5 + 1.5 x with small '
        'jitter. Weights decay linearly across the window, mimicking the '
        'gestures-default "trust newer samples more" weighting. The '
        'degree-1 fit will recover the true slope to within the noise; '
        'higher degrees will chase the jitter slightly.',
    xs: const <double>[
      0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0,
    ],
    ys: const <double>[
      5.10, 6.40, 8.05, 9.55, 11.00, 12.30, 14.10, 15.55, 16.95, 18.55,
    ],
    ws: const <double>[
      0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00,
    ],
    accent: kInkBlue,
  );

  final _Dataset d5 = _buildDataset(
    code: 'D5',
    title: 'Velocity-tracker window  --  touch flick',
    narrative:
        'Twelve (t_ms, x_px) samples taken from a real-feeling rightward '
        'flick: the finger accelerates for the first 100 ms, holds a '
        'roughly constant velocity for 200 ms, then decelerates as it '
        'lifts. Weights are uniform here -- this is what VelocityTracker '
        'actually feeds the solver under the default kind = touch.',
    xs: const <double>[
      0.0, 16.0, 32.0, 48.0, 64.0, 80.0,
      96.0, 112.0, 128.0, 144.0, 160.0, 176.0,
    ],
    ys: const <double>[
      0.0, 4.0, 12.0, 24.0, 40.0, 60.0,
      82.0, 104.0, 124.0, 142.0, 156.0, 166.0,
    ],
    ws: const <double>[
      1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
      1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
    ],
    accent: kGoldLeafDeep,
  );

  final _Dataset d6 = _buildDataset(
    code: 'D6',
    title: 'Degenerate cluster  --  duplicated x',
    narrative:
        'Five samples whose x coordinates are nearly identical. A linear '
        'fit will return something but with negligible confidence; the '
        'degree-2 and degree-3 fits become numerically ill-posed. This '
        'is exactly the regime where VelocityTracker downgrades a flick '
        'to a tap because the finger barely moved within the window.',
    xs: const <double>[0.500, 0.501, 0.499, 0.500, 0.502],
    ys: const <double>[12.00, 12.10, 11.90, 12.05, 12.15],
    ws: const <double>[1.0, 1.0, 1.0, 1.0, 1.0],
    accent: kBrassRule,
  );

  final List<_Dataset> datasets = <_Dataset>[d1, d2, d3, d4, d5, d6];

  // -------------------------------------------------------------------------
  // EDGE CASE PROBES -- constructed once, displayed in section 8.
  // -------------------------------------------------------------------------

  // Probe A -- all weights zero. The solver should hand back a nonsense
  // confidence (or null), and we render that result honestly.
  PolynomialFit? probeAllZeroW;
  try {
    probeAllZeroW = LeastSquaresSolver(
      const <double>[0.0, 1.0, 2.0, 3.0],
      const <double>[1.0, 2.0, 3.0, 4.0],
      const <double>[0.0, 0.0, 0.0, 0.0],
    ).solve(1);
  } catch (_) {
    probeAllZeroW = null;
  }

  // Probe B -- too few samples for the requested degree.
  PolynomialFit? probeTooFew;
  try {
    probeTooFew = LeastSquaresSolver(
      const <double>[0.0, 1.0],
      const <double>[1.0, 3.0],
      const <double>[1.0, 1.0],
    ).solve(3);
  } catch (_) {
    probeTooFew = null;
  }

  // Probe C -- duplicated x values, requested high degree.
  PolynomialFit? probeDup;
  try {
    probeDup = LeastSquaresSolver(
      const <double>[1.0, 1.0, 1.0, 1.0],
      const <double>[2.0, 2.1, 1.9, 2.05],
      const <double>[1.0, 1.0, 1.0, 1.0],
    ).solve(2);
  } catch (_) {
    probeDup = null;
  }

  // Probe D -- a single sample. Degree 0 is asking for a constant.
  PolynomialFit? probeSingle;
  try {
    probeSingle = LeastSquaresSolver(
      const <double>[5.0],
      const <double>[42.0],
      const <double>[1.0],
    ).solve(0);
  } catch (_) {
    probeSingle = null;
  }

  // -------------------------------------------------------------------------
  // BODY -- assembled section by section.
  // -------------------------------------------------------------------------
  final List<Widget> body = <Widget>[];

  // ===========================================================================
  // SECTION 1 -- TITLE PLATE
  // ===========================================================================
  body.add(Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSlateDeep, kSlate, kSlateLight],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kGoldLeaf.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SLATE MARBLE LECTERN', style: _label()),
        const SizedBox(height: 4),
        Text('LeastSquaresSolver', style: _h1()),
        const SizedBox(height: 6),
        Text(
          'Polynomial regression for velocity tracking, narrated as a '
          'morning lecture in a chapel-cold mathematics hall. Six datasets, '
          'three fits each, residual bars, overlay charts, and a careful '
          'tour of the confidence statistic.',
          style: _body(),
        ),
        const SizedBox(height: 10),
        _goldRule(),
        Text('PALETTE', style: _label()),
        const SizedBox(height: 6),
        Wrap(
          children: <Widget>[
            _swatch(kSlateDeep, 'kSlateDeep', 'Deepest slate backdrop'),
            _swatch(kSlate, 'kSlate', 'Panel surface'),
            _swatch(kSlateLight, 'kSlateLight', 'Raised slate tile'),
            _swatch(kMarbleVein, 'kMarbleVein', 'Marble vein highlight'),
            _swatch(kMarblePale, 'kMarblePale', 'Pale marble facing'),
            _swatch(kIvoryParchment, 'kIvoryParchment', 'Table parchment'),
            _swatch(kIvorySoft, 'kIvorySoft', 'Soft callout'),
            _swatch(kInkBlue, 'kInkBlue', 'Plot points'),
            _swatch(kInkBlueDeep, 'kInkBlueDeep', 'Primary text'),
            _swatch(kGoldLeaf, 'kGoldLeaf', 'Fitted curve'),
            _swatch(kGoldLeafDeep, 'kGoldLeafDeep', 'Gold accent stroke'),
            _swatch(kChalkWhite, 'kChalkWhite', 'Chalk text on slate'),
            _swatch(kChalkDim, 'kChalkDim', 'Dim chalk on slate'),
            _swatch(kCrimsonSeal, 'kCrimsonSeal', 'AVOID seal'),
            _swatch(kBrassRule, 'kBrassRule', 'Ruled border'),
            _swatch(kVerdigris, 'kVerdigris', 'Confidence accent'),
          ],
        ),
      ],
    ),
  ));
  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 2 -- WEIGHTED LEAST SQUARES PRIMER
  // ===========================================================================
  body.add(_sectionHeader(
    '02',
    'A primer on weighted least squares',
    'Where the arithmetic comes from, in three short paragraphs.',
  ));
  body.add(_slateTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suppose we have n observations of an underlying smooth function. '
          'For each observation i we know an x value, a y value, and a '
          'non-negative weight w_i that captures how much we trust this '
          'particular sample (newer is usually more trusted than older). '
          'We want to find a polynomial p of degree d such that p(x_i) is '
          'close to y_i for every i, where "close" is measured in a '
          'weighted-square sense.',
          style: _body(),
        ),
        const SizedBox(height: 8),
        Text(
          'Concretely, the polynomial is parameterised by its coefficient '
          'vector c = (c_0, c_1, ..., c_d) and the model is',
          style: _body(),
        ),
        _equation(
          'p(x) = c_0 + c_1 x + c_2 x^2 + ... + c_d x^d',
          caption: 'one polynomial of degree d, with d + 1 coefficients',
        ),
        Text(
          'The objective is to find the c that minimises the weighted '
          'sum-of-squares of residuals:',
          style: _body(),
        ),
        _equation(
          'J(c) = SUM_i  w_i  (y_i - p(x_i))^2',
          caption:
              'each residual is squared, then scaled by the weight w_i, '
              'then summed over all observations',
        ),
        const SizedBox(height: 6),
        Text(
          'Two facts make this tractable. First: the model is LINEAR in c '
          '(even though it is quadratic in x). Second: J is a smooth '
          'convex function of c with a unique minimum given by the '
          'gradient-zero condition. That gradient-zero condition is the '
          'famous "normal equations".',
          style: _body(),
        ),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 3 -- ALGORITHM OVERVIEW
  // ===========================================================================
  body.add(_sectionHeader(
    '03',
    'How the solver actually solves it',
    'Normal equations, Cholesky factoring, the R^2 statistic.',
  ));
  body.add(_slateTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Build the design matrix A whose i-th row is the d+1-vector '
          '(1, x_i, x_i^2, ..., x_i^d). Build the diagonal weight matrix '
          'W with W_ii = w_i. Stack the y values into a column vector Y. '
          'Then the weighted normal equations are simply',
          style: _body(),
        ),
        _equation(
          '(A^T W A) c = A^T W Y',
          caption: 'a (d+1) x (d+1) symmetric positive-definite linear system',
        ),
        Text(
          'Flutter\'s LeastSquaresSolver builds A^T W A directly, then '
          'solves the system using a Cholesky-style factorisation. The '
          'factorisation is robust for the small (typically 3 x 3) systems '
          'that fall out of a degree-2 fit on a 12-sample window, which '
          'is the gestures-default. When the matrix is too close to '
          'singular -- say all the x values agree -- the factorisation '
          'detects the failure and the solver returns null.',
          style: _body(),
        ),
        const SizedBox(height: 8),
        Text(
          'Once c is known, the fitted values are y_hat_i = p(x_i). The '
          'confidence statistic is',
          style: _body(),
        ),
        _equation(
          'R^2 = 1 -  ( SUM_i w_i (y_i - y_hat_i)^2 )  /  ( SUM_i w_i (y_i - y_bar)^2 )',
          caption: 'where y_bar is the weighted mean of y_i',
        ),
        Text(
          'R^2 = 1.0 means the polynomial passes exactly through all the '
          'samples (up to floating-point). R^2 = 0.0 means the polynomial '
          'is no better than predicting the weighted mean. Negative R^2 '
          'is possible in pathological weight regimes but is treated as '
          '"poor" by the gestures pipeline.',
          style: _body(),
        ),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 4 -- SIX DATASETS, EACH AS A FULL CARD
  // ===========================================================================
  body.add(_sectionHeader(
    '04',
    'Six worked datasets',
    'Each dataset shows samples, three fits, and residuals. Every number '
    'on this page came out of an actual LeastSquaresSolver.solve(...) '
    'call performed inside this build().',
  ));
  for (int i = 0; i < datasets.length; i++) {
    body.add(_datasetCard(datasets[i]));
  }

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 5 -- OVERLAY CHARTS
  // ===========================================================================
  body.add(_sectionHeader(
    '05',
    'Polynomial overlay charts',
    'For each dataset, the same scatter cloud with all three fits drawn on '
    'top -- so the eye can see when degree 1 underfits, when degree 2 '
    'is just right, and when degree 3 starts chasing noise.',
  ));
  for (int i = 0; i < datasets.length; i++) {
    final _Dataset d = datasets[i];
    body.add(Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSlate,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kMarbleVein.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: d.accent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(d.code,
                    style: const TextStyle(
                        color: kIvoryParchment,
                        fontWeight: FontWeight.w800,
                        fontSize: 10)),
              ),
              _gapW(8),
              Expanded(
                child: Text(d.title,
                    style: const TextStyle(
                        color: kChalkWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _overlayPlot(d, height: 220, width: 380),
          const SizedBox(height: 8),
          Text(
            _overlayCaption(d),
            style: _body(),
          ),
        ],
      ),
    ));
  }

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 6 -- HOW VELOCITYTRACKER USES THIS
  // ===========================================================================
  body.add(_sectionHeader(
    '06',
    'From polynomial fit to pixels-per-second',
    'The bridge between regression and the feel of a flick.',
  ));
  body.add(_slateTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VelocityTracker keeps a circular buffer of the last 20 '
          '(timestamp, position) pairs. When the gesture system asks '
          'getVelocity(), the tracker does roughly the following:',
          style: _body(),
        ),
        const SizedBox(height: 8),
        _equation(
          '1. collect (t_i, x_i) and (t_i, y_i) within the most recent 100 ms\n'
          '2. assign weights w_i that decay smoothly with sample age\n'
          '3. solver_x = LeastSquaresSolver(t, x, w)\n'
          '4. solver_y = LeastSquaresSolver(t, y, w)\n'
          '5. fit_x = solver_x.solve(2)   --  quadratic in time\n'
          '6. fit_y = solver_y.solve(2)\n'
          '7. velocity_x_pixels_per_ms = fit_x.coefficients[1]\n'
          '8. velocity_y_pixels_per_ms = fit_y.coefficients[1]\n'
          '9. multiply by 1000 to convert to pixels per second',
          caption:
              'note that c_1 IS the slope at t = 0 of the quadratic, '
              'i.e. the instantaneous velocity at the most recent sample',
        ),
        const SizedBox(height: 6),
        Text(
          'The choice of degree 2 (quadratic) is a trade-off. Degree 1 '
          'gives a very robust answer but smears any acceleration into a '
          'single average; degree 3 captures jerk but is much more '
          'sensitive to the last sample. Degree 2 is the sweet spot for '
          'human-finger touch input across every device the team has '
          'tested, which is why the gesture recognizers hard-code it.',
          style: _body(),
        ),
        const SizedBox(height: 8),
        _calloutSlate(
          'WHY WEIGHTS DECAY',
          'A finger that has just lifted should not be influenced too '
          'heavily by where it was 100 ms ago -- that information is '
          'stale. By decaying weights with sample age, the solver pays '
          'closer attention to the moment of release, which is exactly '
          'when the gesture system needs the most accurate velocity '
          'estimate to decide between flick and tap.',
        ),
        _calloutSlate(
          'WHY THE TIME ORIGIN MOVES',
          'In the actual pipeline, the most recent timestamp is shifted '
          'to t = 0 before fitting, so c_1 directly gives the velocity '
          'at the most recent sample without needing to evaluate a '
          'derivative. This also keeps the design matrix well-conditioned '
          'numerically -- t values stay close to zero rather than '
          'growing into large floats.',
        ),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 7 -- INTERPRETING THE CONFIDENCE STATISTIC
  // ===========================================================================
  body.add(_sectionHeader(
    '07',
    'Interpreting confidence (R^2)',
    'When to trust the solver, and when to treat its answer as noise.',
  ));
  body.add(_slateTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _confidenceTier('R^2 >= 0.95',
            'EXCELLENT -- the polynomial passes through (or essentially '
            'through) every sample. Trust the velocity. The gesture is '
            'almost certainly a flick if the magnitude exceeds the '
            'kMinFlingVelocity threshold.'),
        _confidenceTier('0.80 <= R^2 < 0.95',
            'GOOD -- there is some noise around the curve but the '
            'polynomial captures the trend. The gesture system uses this '
            'tier as the default acceptance threshold.'),
        _confidenceTier('0.50 <= R^2 < 0.80',
            'FAIR -- the polynomial only weakly explains the data. '
            'Velocity-based decisions become marginal here; many '
            'recognizers will halve the reported velocity to play it '
            'safe.'),
        _confidenceTier('R^2 < 0.50',
            'POOR -- the data are nearly orthogonal to the model. The '
            'gesture is most likely a tap, jitter, or palm contact. '
            'Reported velocity should NOT be used to drive a fling.'),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 8 -- EDGE CASES
  // ===========================================================================
  body.add(_sectionHeader(
    '08',
    'Edge cases  --  when the solver returns null',
    'Four hand-built probes, each one engineered to break the solver.',
  ));
  body.add(_parchment(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PROBE A  --  ALL WEIGHTS ZERO', style: _labelDark()),
        const SizedBox(height: 4),
        Text(
          'If every w_i is zero, the weighted normal equations have a '
          'zero matrix on the left and a zero vector on the right. The '
          'system is satisfied by every c, which is to say no useful c. '
          'The solver detects this and returns null:',
          style: _bodyDark(),
        ),
        _fitBlock(1, probeAllZeroW),
        const SizedBox(height: 8),
        Text('PROBE B  --  TOO FEW SAMPLES FOR THE DEGREE', style: _labelDark()),
        const SizedBox(height: 4),
        Text(
          'A polynomial of degree 3 has 4 coefficients. With only 2 '
          'samples the design matrix has rank at most 2, so the normal '
          'equations are rank-deficient. The solver returns null:',
          style: _bodyDark(),
        ),
        _fitBlock(3, probeTooFew),
        const SizedBox(height: 8),
        Text('PROBE C  --  DUPLICATED X VALUES', style: _labelDark()),
        const SizedBox(height: 4),
        Text(
          'When all x values agree, the design matrix has identical rows '
          'and is therefore rank 1. Any degree above 0 is unsolvable. '
          'The result here is null for the requested degree-2 fit:',
          style: _bodyDark(),
        ),
        _fitBlock(2, probeDup),
        const SizedBox(height: 8),
        Text('PROBE D  --  A SINGLE SAMPLE, DEGREE 0', style: _labelDark()),
        const SizedBox(height: 4),
        Text(
          'Degree 0 (a constant fit) on one sample is just "predict the '
          'sample\'s y for any input". This is well-posed and the '
          'solver returns it without complaint. R^2 is undefined when '
          'there is no variance in y, but the coefficient is solid.',
          style: _bodyDark(),
        ),
        _fitBlock(0, probeSingle),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 9 -- DO / AVOID RULES
  // ===========================================================================
  body.add(_sectionHeader(
    '09',
    'DO and AVOID  --  rules of thumb for gesture work',
    'Six pragmatic guidelines distilled from years of touch tuning.',
  ));
  body.add(_slateTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _calloutDoSlate(
          'Pick degree 2 for velocity tracking. Degree 1 misses '
          'acceleration; degree 3 chases noise. Degree 2 is the '
          'gestures default for a reason.',
        ),
        _calloutDoSlate(
          'Decay weights with sample age. Newer samples are closer to '
          'the moment of release and deserve more influence on the '
          'reported velocity.',
        ),
        _calloutDoSlate(
          'Shift the time origin so t = 0 lies at the most recent '
          'sample. This makes c_1 the reported velocity directly and '
          'keeps the matrix well-conditioned.',
        ),
        _calloutAvoidSlate(
          'Do not pass raw timestamps from epoch to the solver. The '
          'numbers are too large and the design matrix becomes wildly '
          'ill-conditioned. Subtract the most recent timestamp first.',
        ),
        _calloutAvoidSlate(
          'Do not blindly use the solver\'s velocity if R^2 < 0.5. '
          'The fit is too poor to trust; halve the reported velocity '
          'or downgrade the gesture entirely.',
        ),
        _calloutAvoidSlate(
          'Do not solve degree d with fewer than d + 1 samples. The '
          'solver will return null and your callback will see Velocity.zero, '
          'which produces a "stuck" feel on the resulting fling.',
        ),
      ],
    ),
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 10 -- GLOSSARY
  // ===========================================================================
  body.add(_sectionHeader(
    '10',
    'Glossary',
    'Twelve terms a touring mathematician might use today.',
  ));
  body.add(Wrap(
    spacing: 8,
    runSpacing: 0,
    children: <Widget>[
      SizedBox(
        width: 300,
        child: _glossaryEntry('Design matrix A',
            'The n x (d+1) matrix whose i-th row is (1, x_i, x_i^2, ..., '
            'x_i^d). Encodes the polynomial model in matrix form.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Weight matrix W',
            'A diagonal n x n matrix with W_ii = w_i. In gestures these '
            'weights typically decay with sample age.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Normal equations',
            'The square (d+1) x (d+1) system (A^T W A) c = A^T W Y whose '
            'solution is the weighted least-squares c.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Cholesky factorisation',
            'A numerical method for solving symmetric positive-definite '
            'linear systems by writing the matrix as L L^T.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Residual r_i',
            'The difference y_i - p(x_i) between the observed value and '
            'the fitted value at x_i.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('SS_res',
            'The weighted sum of squared residuals. The solver minimises '
            'this quantity over all c.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('SS_tot',
            'The weighted total sum of squares: how much y varies '
            'around its weighted mean. The denominator of R^2.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('R^2 (confidence)',
            '1 - SS_res / SS_tot. Closer to 1.0 means the polynomial '
            'explains more of the variation in y.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Underfitting',
            'Asking for too LOW a degree. The polynomial cannot bend '
            'enough to follow the data; residuals systematically alternate '
            'sign across x.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Overfitting',
            'Asking for too HIGH a degree. The polynomial chases noise; '
            'small changes in input data cause wild swings in coefficients.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Conditioning',
            'How sensitive the solution is to perturbations in the '
            'inputs. A poorly-conditioned matrix amplifies noise.'),
      ),
      SizedBox(
        width: 300,
        child: _glossaryEntry('Singular system',
            'A linear system with no unique solution. Can happen when '
            'rows are linearly dependent (duplicated x values).'),
      ),
    ],
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 11 -- RECIPE CARDS
  // ===========================================================================
  body.add(_sectionHeader(
    '11',
    'Four canonical recipes',
    'Patterns you can lift directly into your own gesture code.',
  ));
  body.add(_recipeCard(
    'Recipe A  --  basic velocity from samples',
    'final solver = LeastSquaresSolver(t, x, w);\n'
        'final fit = solver.solve(2);\n'
        'if (fit != null && fit.confidence >= 0.5) {\n'
        '  final pxPerMs = fit.coefficients[1];\n'
        '  final velocity = pxPerMs * 1000.0;  // px/s\n'
        '}',
    'Build the solver, request degree 2, gate on confidence, multiply '
        'the linear coefficient by 1000 to get pixels per second.',
  ));
  body.add(_recipeCard(
    'Recipe B  --  decay-weighted gesture window',
    'final w = <double>[];\n'
        'for (int i = 0; i < n; i++) {\n'
        '  final ageMs = (tNow - tSample[i]).abs();\n'
        '  w.add(1.0 / (1.0 + ageMs * 0.01));\n'
        '}\n'
        'final solver = LeastSquaresSolver(tSample, xSample, w);',
    'Older samples count for less. The 1 / (1 + age * 0.01) curve gives '
        'roughly half-weight at 100 ms, matching the gestures default.',
  ));
  body.add(_recipeCard(
    'Recipe C  --  degree-aware fallback',
    'PolynomialFit? fit;\n'
        'for (int d = 2; d >= 0; d = d - 1) {\n'
        '  fit = solver.solve(d);\n'
        '  if (fit != null) break;\n'
        '}',
    'If the requested degree is unsolvable (too few samples, ill-posed), '
        'fall back to a lower degree before giving up.',
  ));
  body.add(_recipeCard(
    'Recipe D  --  evaluate the fit at a new point',
    'double evaluate(PolynomialFit fit, double x) {\n'
        '  double acc = 0.0;\n'
        '  double xp = 1.0;\n'
        '  for (int i = 0; i < fit.coefficients.length; i++) {\n'
        '    acc = acc + fit.coefficients[i] * xp;\n'
        '    xp = xp * x;\n'
        '  }\n'
        '  return acc;\n'
        '}',
    'Horner-ish polynomial evaluation. Used to predict y at any x, e.g. '
        'to extrapolate the position of the finger one frame into the '
        'future for predictive scrolling.',
  ));

  body.add(_marbleStripe());

  // ===========================================================================
  // SECTION 12 -- RECAP / FOOTER
  // ===========================================================================
  body.add(_sectionHeader(
    '12',
    'Recap  --  the lectern in one paragraph',
    'Closing motto in gold leaf.',
  ));
  body.add(Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSlateDeep, kSlate],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kGoldLeaf.withValues(alpha: 0.55), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SLATE MARBLE :: CLOSING NOTE', style: _label()),
        const SizedBox(height: 6),
        Text(
          'LeastSquaresSolver is a small piece of arithmetic with a very '
          'large reach: every flick of every list in every Flutter app '
          'flows through it. Six datasets, three solves each, a residual '
          'plot per dataset, and a tour of confidence and edge cases is '
          'enough to give the touch-tuner a real intuition for what the '
          'solver is good at, and where it quietly returns null.',
          style: _body(),
        ),
        const SizedBox(height: 10),
        _goldRule(),
        Text(
          'The mathematician closes the leather-bound book and turns off '
          'the brass desk-lamp. Outside the chapel, the rain has stopped. '
          'A single golden leaf settles on the slate floor.',
          style: const TextStyle(
            fontSize: 12,
            color: kChalkDim,
            fontStyle: FontStyle.italic,
            height: 1.45,
          ),
        ),
      ],
    ),
  ));

  // -------------------------------------------------------------------------
  // RETURN THE TREE.
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: kSlateDeep,
    appBar: AppBar(
      backgroundColor: kSlateDeep,
      foregroundColor: kChalkWhite,
      title: const Text('LeastSquaresSolver  --  Slate Marble Lectern'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// CONFIDENCE TIER ROW -- a coloured chip plus prose, used in section 7.
// ---------------------------------------------------------------------------
Widget _confidenceTier(String range, String prose) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSlateLight,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kMarbleVein.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(range,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: kGoldLeaf,
              )),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(prose, style: _body())),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// OVERLAY CAPTION -- short prose summarising the three fits in one chart.
// ---------------------------------------------------------------------------
String _overlayCaption(_Dataset d) {
  final StringBuffer sb = StringBuffer();
  if (d.fit1 != null) {
    sb.write('Degree-1 R^2 = ${_fmt(d.fit1!.confidence, frac: 3)}. ');
  } else {
    sb.write('Degree-1 unsolvable. ');
  }
  if (d.fit2 != null) {
    sb.write('Degree-2 R^2 = ${_fmt(d.fit2!.confidence, frac: 3)}. ');
  } else {
    sb.write('Degree-2 unsolvable. ');
  }
  if (d.fit3 != null) {
    sb.write('Degree-3 R^2 = ${_fmt(d.fit3!.confidence, frac: 3)}. ');
  } else {
    sb.write('Degree-3 unsolvable. ');
  }
  sb.write('White-cored dots are the original samples; coloured trails are '
      'the fitted polynomials. The closer the trail hugs the dots, the '
      'higher the corresponding R^2.');
  return sb.toString();
}
