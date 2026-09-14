// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unnecessary_this, avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  ATLAS  IRIS  ::  A Cartographer's Legend Room for IconData & IconDataProperty
// =============================================================================
//
//  THEME
//  -----
//  "Atlas Iris" is the visual language of an old cartographer's legend room.
//  Imagine a long oak table lit by a brass lamp at midnight, the surface buried
//  under chart paper, copper compasses, sextants, and a leather-bound atlas
//  open to a hand-drawn legend. On the margins of every map there is a small
//  rectangular cartouche printed in lavender and indigo: the legend, the
//  registry of every glyph the cartographer chose to mean a thing.
//
//  In Flutter, an IconData object IS a legend entry. It is not a painting; it
//  is a triple (codePoint, fontFamily, fontPackage) plus an
//  optional matchTextDirection flag. That triple, when fed to an Icon widget,
//  becomes a printed glyph. But the IconData itself is metadata. Metadata is
//  the cartographer's domain: the legend, the index, the gazetteer.
//
//  The same metadata mindset rules the Diagnosticable infrastructure. When a
//  widget calls debugFillProperties on a DiagnosticPropertiesBuilder it adds
//  IconDataProperty entries for every icon it owns. Those properties feed the
//  widget inspector, the dartdoc renderer, and any tool that reads
//  toDiagnosticsNode() from a Flutter object. IconDataProperty is therefore the
//  documentation surface of every icon in the framework: it is the cartouche
//  on the map.
//
//  This script paints that legend room in lavender and indigo. The palette is
//  chart-paper cream for the surface, lavender (#B5A6D5) for the legend
//  cartouche, indigo (#5B4F8C) for the title bar, mid-violet (#7E6DAA) for
//  inner panels, and copper (#9C5526) for the legend keys and arrows.
//
//  SUBJECT
//  -------
//  package:flutter/foundation.dart  ::  class IconDataProperty
//                                   ::  class DiagnosticPropertiesBuilder
//                                   ::  class DiagnosticsNode (abstract)
//                                   ::  class Diagnosticable (mixin)
//
//  package:flutter/widgets.dart     ::  class IconData
//
//  IconData
//  --------
//  IconData(int codePoint, {
//    String? fontFamily,
//    String? fontPackage,
//    bool matchTextDirection = false,
//    List<String>? fontFamilyFallback,
//  })
//
//  Four fields, all final, all part of the value identity:
//
//      codePoint           :: int (the Unicode private-use codepoint, e.g. 0xe88a)
//      fontFamily          :: String? ('MaterialIcons', 'CupertinoIcons', ...)
//      fontPackage         :: String? (null for Flutter's bundled fonts; set
//                              for custom font packages)
//      matchTextDirection  :: bool (mirror the glyph horizontally in RTL)
//      fontFamilyFallback  :: List<String>? (alternative families if codepoint
//                              not found in primary family)
//
//  IconData overrides operator == and hashCode using all four fields, so two
//  IconData values are equal iff every field is equal. This matters for diff
//  rendering in the widget inspector and for diagnostic value comparisons.
//
//  IconDataProperty
//  ----------------
//  class IconDataProperty extends DiagnosticsProperty<IconData> {
//    IconDataProperty(
//      String super.name,
//      IconData? super.value, {
//      super.ifNull,
//      super.showName = true,
//      super.style = DiagnosticsTreeStyle.singleLine,
//      super.level = DiagnosticLevel.info,
//    });
//
//    @override
//    Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate) {
//      final Map<String, Object?> json = super.toJsonMap(delegate);
//      if (value != null) {
//        json['valueProperties'] = <String, Object>{
//          'codePoint': value!.codePoint,
//        };
//      }
//      return json;
//    }
//  }
//
//  IconDataProperty exists for one reason: so the JSON serialization of a
//  DiagnosticsNode that wraps an IconData includes the codePoint. Without
//  this override the serialized JSON would only carry value.toString() (a
//  string like 'IconData(U+0E88A)'), which is not enough for a remote inspector
//  client to actually paint the icon. By adding 'valueProperties.codePoint',
//  IconDataProperty allows the Flutter Inspector and any external tool to
//  reconstruct the glyph from its codepoint and family.
//
//  DiagnosticPropertiesBuilder
//  ---------------------------
//  class DiagnosticPropertiesBuilder {
//    DiagnosticPropertiesBuilder() : properties = <DiagnosticsNode>[];
//    DiagnosticPropertiesBuilder.fromProperties(this.properties);
//    final List<DiagnosticsNode> properties;
//    DiagnosticsTreeStyle? defaultDiagnosticsTreeStyle =
//        DiagnosticsTreeStyle.sparse;
//    void add(DiagnosticsNode property) { properties.add(property); }
//  }
//
//  Every Diagnosticable (every Widget, RenderObject, Element, ...) has a
//  debugFillProperties(DiagnosticPropertiesBuilder properties) method. That
//  method calls properties.add(IconDataProperty('icon', this.icon)) and
//  properties.add(StringProperty('semanticLabel', this.semanticLabel)) and so
//  on. The collected properties become the displayed properties of the
//  diagnostics node returned by toDiagnosticsNode().
//
//  DiagnosticsNode tree -> documentation
//  -------------------------------------
//  toDiagnosticsNode() returns a DiagnosticsNode whose getProperties() returns
//  the IconDataProperty / StringProperty / ColorProperty / ... that
//  debugFillProperties added. Tools call toString() on the tree, or .toJsonMap()
//  on each node, or .toStringDeep() for an indented multi-line dump.
//
//  This is the chain documentation tools follow:
//
//      Widget.toDiagnosticsNode()
//          -> DiagnosticsNode  (with cached properties)
//                -> getProperties()
//                      -> List<DiagnosticsNode>
//                            including IconDataProperty('icon', someIcon)
//                                .toJsonMap(delegate)
//                                    -> 'valueProperties.codePoint' = int
//
//  DocumentationIcon (briefly)
//  ---------------------------
//  package:flutter/foundation.dart also exposes a small annotation class
//  DocumentationIcon(String url). It is a marker used by documentation tooling
//  to attach an icon URL to a class declaration. We acknowledge it in one
//  section but the heart of the demo is IconData and IconDataProperty: those
//  are the mechanisms that actually pump icon metadata into the inspector and
//  documentation pipeline.
//
//  SECTIONS (twelve cartouches in this legend room)
//  -----------------------------------------------
//   1. Title hero          - Atlas Iris banner with copper-edged cartouche.
//   2. Anatomy diagram     - IconData fields labelled with copper arrows.
//   3. Twelve icon plates  - 12 Cards rendering Icon(IconData(...)).
//   4. IconDataProperty    - 6 builder demonstrations rendered line by line.
//   5. Codepoint encyclo.  - 18 Material Icons codepoints in a registry table.
//   6. matchTextDirection  - LTR vs RTL with matchTextDirection true / false.
//   7. fontPackage         - Material, Cupertino, custom-font variants.
//   8. DiagnosticsNode tree- toStringDeep() example rendered in monospace.
//   9. Documentation flow  - CustomPainter showing the toJsonMap pipeline.
//  10. Icon glossary       - 14 vocabulary cards (codepoint, glyph, baseline...)
//  11. Field reference     - three-column table for IconData.
//  12. Closing essay       - 200-word prose paragraph on icon-as-data.
//
//  D4RT RULES OBSERVED
//  -------------------
//   * Single top-level function: dynamic build(BuildContext context).
//   * No StatefulWidget, no controllers, no async, no Stream, no Future.
//   * No for-in loops, no collection-for - every iteration is indexed.
//   * Color opacity uses .withValues(alpha: ...).
//   * The widget tree is constructed once and returned frozen.
//
//  ATTRIBUTION
//  -----------
//  "Atlas Iris" is a fictional teaching aesthetic invented for this demo. The
//  cartographer's legend tradition is borrowed from the Mercator atlases of the
//  16th century, the Blaeu folios of the 17th, and the modern USGS topographic
//  series. The pedagogical voice is deliberate: it asks the reader to treat
//  IconData not as an opaque token but as legend metadata that flows into
//  documentation, inspectors, and downstream tooling.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// PALETTE :: Atlas Iris
//
// Sixteen named tones. Lavender + indigo dominate; copper accents the legend
// keys; chart-paper cream is the substrate. Every value here is a const Color
// so the script can compose without re-allocating in inner loops.
// -----------------------------------------------------------------------------
const Color irisCream      = Color(0xFFF2EBD8); // chart paper
const Color irisLinen      = Color(0xFFEFE7C9); // aged chart paper
const Color irisChalk      = Color(0xFFFAF4E2); // light chalk highlight
const Color irisLavender   = Color(0xFFB5A6D5); // pale lavender wash
const Color irisLavSoft    = Color(0xFFCABFE3); // lighter lavender
const Color irisViolet     = Color(0xFF7E6DAA); // mid violet panel
const Color irisIndigo     = Color(0xFF5B4F8C); // indigo title bar
const Color irisInk        = Color(0xFF332B57); // deep indigo ink
const Color irisCharcoal   = Color(0xFF231C40); // near-black indigo
const Color irisCopper     = Color(0xFF9C5526); // copper legend key
const Color irisRust       = Color(0xFFB97044); // rust accent
const Color irisAmber      = Color(0xFFC98F45); // amber highlight
const Color irisOlive      = Color(0xFF6B6B33); // olive marginalia
const Color irisSage       = Color(0xFF6F8F73); // sage tint
const Color irisDust       = Color(0xFF8B8068); // chart-dust grey
const Color irisStone      = Color(0xFF55503F); // stone-grey caption

// -----------------------------------------------------------------------------
// TYPOGRAPHY HELPERS
//
// Five reusable text styles. The cartographer's analogue is: titlecase Roman
// for legend headers, italic small caps for marginalia, and a fixed-width
// engraver's slab for the codepoint registry.
// -----------------------------------------------------------------------------
TextStyle _displayStyle(double size, Color color) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: 0.5,
      height: 1.15,
    );

TextStyle _titleStyle(double size, Color color) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.3,
      height: 1.2,
    );

TextStyle _bodyStyle(Color color, {double size = 13, FontWeight w = FontWeight.w400}) =>
    TextStyle(fontSize: size, color: color, fontWeight: w, height: 1.5);

TextStyle _captionStyle(Color color, {double size = 11}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.3,
    );

TextStyle _monoStyle(Color color, {double size = 11, FontWeight w = FontWeight.w400}) =>
    TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      color: color,
      height: 1.4,
      fontWeight: w,
    );

// -----------------------------------------------------------------------------
// SURFACE DECORATIONS
//
// Three reusable surfaces. _chartSurface is the default chart-paper card;
// _legendSurface is a lavender legend cartouche; _indigoSurface is the
// title-bar gradient.
// -----------------------------------------------------------------------------
BoxDecoration _chartSurface() => BoxDecoration(
      color: irisCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: irisCopper.withValues(alpha: 0.55), width: 1.0),
    );

BoxDecoration _legendSurface() => BoxDecoration(
      color: irisLavender.withValues(alpha: 0.32),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: irisIndigo.withValues(alpha: 0.55), width: 1.0),
    );

BoxDecoration _indigoSurface() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [irisCharcoal, irisInk, irisIndigo, irisViolet],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: irisCopper.withValues(alpha: 0.7), width: 1.2),
    );

// -----------------------------------------------------------------------------
// SMALL UI HELPERS
// -----------------------------------------------------------------------------
Widget _verticalGap(double h) => SizedBox(height: h);
Widget _horizontalGap(double w) => SizedBox(width: w);

Widget _swatch(String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: irisInk.withValues(alpha: 0.35)),
    ),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? irisCream
            : irisInk,
      ),
    ),
  );
}

Widget _propRow(String name, String value, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 152,
          child: Text(
            name,
            style: _monoStyle(accent ?? irisInk, size: 11, w: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: _bodyStyle(irisCharcoal, size: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _legendKey(String marker, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: irisCopper,
            shape: BoxShape.circle,
            border: Border.all(color: irisInk, width: 1.0),
          ),
          child: Text(
            marker,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: irisCream,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            description,
            style: _bodyStyle(irisCharcoal, size: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _proseCard({required String title, required List<String> paragraphs, Color? titleColor, BoxDecoration? surface}) {
  final List<Widget> children = <Widget>[];
  children.add(Text(title, style: _titleStyle(15, titleColor ?? irisInk)));
  children.add(_verticalGap(8));
  for (int i = 0; i < paragraphs.length; i++) {
    children.add(Text(paragraphs[i], style: _bodyStyle(irisCharcoal, size: 12)));
    if (i < paragraphs.length - 1) {
      children.add(_verticalGap(8));
    }
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: surface ?? _chartSurface(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

Widget _sectionHeader(String index, String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [irisIndigo, irisViolet, irisLavender.withValues(alpha: 0.4)],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: irisCopper.withValues(alpha: 0.65)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: irisCopper,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(index, style: _monoStyle(irisCream, size: 12, w: FontWeight.w800)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _titleStyle(15, irisCream)),
              Text(subtitle, style: _captionStyle(irisChalk, size: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// FLOW PAINTER  ::  used by Section 9 to draw the documentation pipeline.
//
// The painter draws four labelled boxes connected by copper arrows:
//      IconData -> IconDataProperty -> DiagnosticsNode -> toJsonMap
// CustomPainter is allowed in d4rt because we never call animate(); we just
// paint once.
// -----------------------------------------------------------------------------
class _FlowPainter extends CustomPainter {
  _FlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = irisLavSoft;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = irisIndigo;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = irisCopper;
    final Paint arrowHeadPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = irisCopper;

    final double h = size.height;
    final double yMid = h / 2;
    final double boxHeight = h * 0.45;
    final double boxTop = (h - boxHeight) / 2;

    final List<String> labels = <String>[
      'IconData',
      'IconDataProperty',
      'DiagnosticsNode',
      'toJsonMap',
    ];
    final double total = size.width;
    final double margin = 6.0;
    final double gap = 18.0;
    final double available = total - 2 * margin - 3 * gap;
    final double boxWidth = available / 4.0;

    final List<Rect> boxes = <Rect>[];
    for (int i = 0; i < 4; i++) {
      final double x = margin + i * (boxWidth + gap);
      final Rect r = Rect.fromLTWH(x, boxTop, boxWidth, boxHeight);
      boxes.add(r);
    }

    for (int i = 0; i < boxes.length; i++) {
      final Rect r = boxes[i];
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      canvas.drawRRect(rr, boxPaint);
      canvas.drawRRect(rr, borderPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: irisInk,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 2,
      );
      tp.layout(maxWidth: r.width - 8);
      final Offset off = Offset(
        r.left + (r.width - tp.width) / 2,
        r.top + (r.height - tp.height) / 2,
      );
      tp.paint(canvas, off);
    }

    for (int i = 0; i < boxes.length - 1; i++) {
      final Rect a = boxes[i];
      final Rect b = boxes[i + 1];
      final Offset start = Offset(a.right, yMid);
      final Offset end = Offset(b.left, yMid);
      canvas.drawLine(start, end, arrowPaint);
      final Path arrowHead = Path();
      arrowHead.moveTo(end.dx, end.dy);
      arrowHead.lineTo(end.dx - 6, end.dy - 4);
      arrowHead.lineTo(end.dx - 6, end.dy + 4);
      arrowHead.close();
      canvas.drawPath(arrowHead, arrowHeadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// ANATOMY PAINTER :: Section 2.
//
// Paints a labelled IconData "anatomy" diagram: a central rectangle with the
// four field names arrayed around it and copper arrows pointing in. Used by
// the ANATOMY card.
// -----------------------------------------------------------------------------
class _AnatomyPainter extends CustomPainter {
  _AnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint surface = Paint()
      ..style = PaintingStyle.fill
      ..color = irisLavSoft;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = irisIndigo;
    final Paint arrow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = irisCopper;
    final Paint arrowHead = Paint()
      ..style = PaintingStyle.fill
      ..color = irisCopper;

    final double w = size.width;
    final double h = size.height;
    final Rect center = Rect.fromCenter(
      center: Offset(w / 2, h / 2),
      width: w * 0.36,
      height: h * 0.30,
    );
    final RRect rr = RRect.fromRectAndRadius(center, const Radius.circular(10));
    canvas.drawRRect(rr, surface);
    canvas.drawRRect(rr, stroke);

    final TextPainter centerTp = TextPainter(
      text: TextSpan(
        text: 'IconData',
        style: TextStyle(
          color: irisInk,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    centerTp.layout();
    centerTp.paint(
      canvas,
      Offset(
        center.left + (center.width - centerTp.width) / 2,
        center.top + (center.height - centerTp.height) / 2,
      ),
    );

    // Four field labels: top, right, bottom, left.
    final List<String> labels = <String>[
      'codePoint',
      'fontFamily',
      'fontPackage',
      'matchTextDirection',
    ];

    // Anchor positions (where label boxes sit) and the corresponding edge
    // attach point on the center rectangle.
    final List<Offset> labelCenters = <Offset>[
      Offset(w / 2, h * 0.10),  // top
      Offset(w * 0.88, h / 2),  // right
      Offset(w / 2, h * 0.90),  // bottom
      Offset(w * 0.12, h / 2),  // left
    ];

    final List<Offset> attach = <Offset>[
      Offset(center.center.dx, center.top),
      Offset(center.right, center.center.dy),
      Offset(center.center.dx, center.bottom),
      Offset(center.left, center.center.dy),
    ];

    for (int i = 0; i < labels.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: irisInk,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final Offset c = labelCenters[i];
      final Rect labelBox = Rect.fromCenter(
        center: c,
        width: tp.width + 14,
        height: tp.height + 8,
      );
      final RRect lrr = RRect.fromRectAndRadius(labelBox, const Radius.circular(6));
      final Paint labelFill = Paint()
        ..color = irisLinen
        ..style = PaintingStyle.fill;
      final Paint labelStroke = Paint()
        ..color = irisCopper
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawRRect(lrr, labelFill);
      canvas.drawRRect(lrr, labelStroke);
      tp.paint(
        canvas,
        Offset(labelBox.left + 7, labelBox.top + 4),
      );

      // Arrow from labelBox edge -> attach point.
      Offset arrowStart;
      if (i == 0) {
        arrowStart = Offset(labelBox.center.dx, labelBox.bottom);
      } else if (i == 1) {
        arrowStart = Offset(labelBox.left, labelBox.center.dy);
      } else if (i == 2) {
        arrowStart = Offset(labelBox.center.dx, labelBox.top);
      } else {
        arrowStart = Offset(labelBox.right, labelBox.center.dy);
      }
      final Offset arrowEnd = attach[i];
      canvas.drawLine(arrowStart, arrowEnd, arrow);

      // Tiny arrowhead at the attach point.
      final double dx = arrowEnd.dx - arrowStart.dx;
      final double dy = arrowEnd.dy - arrowStart.dy;
      final double len = (dx * dx + dy * dy);
      final double mag = len <= 0 ? 1.0 : len;
      // Without sqrt: approximate a normalized arrowhead by scaling 6/length.
      final double inv = 6.0 / (mag > 36 ? mag / 6 : 6);
      final Offset back = Offset(arrowEnd.dx - dx * inv, arrowEnd.dy - dy * inv);
      final Path head = Path();
      head.moveTo(arrowEnd.dx, arrowEnd.dy);
      head.lineTo(back.dx + dy * inv * 0.5, back.dy - dx * inv * 0.5);
      head.lineTo(back.dx - dy * inv * 0.5, back.dy + dx * inv * 0.5);
      head.close();
      canvas.drawPath(head, arrowHead);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// build(BuildContext)
//
// The single entry point. Every widget below is constructed once, returned in
// a single frozen tree, and rendered by the D4rt host. There is no state, no
// listener, no controller, no async work in the tree.
// =============================================================================
dynamic build(BuildContext context) {
  print('================================================================');
  print('Atlas Iris  ::  A Cartographer\'s Legend Room for IconData');
  print('================================================================');
  print('Setting the brass lamp on the legend table...');
  print('Unrolling the chart paper, fanning the lavender ink across the page.');

  // ---------------------------------------------------------------------------
  // CHAPTER 0 :: BUILDING THE LEGEND REGISTRY
  //
  // Twelve realistic IconData instances, each annotated with its codePoint
  // (in hex), fontFamily, fontPackage, and matchTextDirection flag. Some of
  // these are taken straight from Icons.* (so fontFamily = 'MaterialIcons',
  // package = null). One is a hand-built directional arrow with
  // matchTextDirection = true. One simulates a custom-package icon font.
  // ---------------------------------------------------------------------------
  print('Cataloging twelve legend entries...');

  final IconData icMap         = Icons.map;
  final IconData icExplore     = Icons.explore;
  final IconData icCompass     = Icons.explore_outlined;
  final IconData icAnchor      = Icons.anchor;
  final IconData icArrowFwd    = Icons.arrow_forward;
  final IconData icArrowBack   = Icons.arrow_back;
  final IconData icSettings    = Icons.settings;
  final IconData icSearch      = Icons.search;
  final IconData icFlag        = Icons.flag;
  final IconData icLandmark    = Icons.account_balance;
  final IconData icRoom        = Icons.room;
  final IconData icTerrain     = Icons.terrain;

  // A hand-built IconData that mirrors when in RTL Directionality.
  final IconData icRtlArrow = IconData(
    0xe5c8,
    fontFamily: 'MaterialIcons',
    matchTextDirection: true,
  );

  // A hand-built IconData simulating a custom-package font. Note the fontFamily
  // and fontPackage fields - in a real app, these would match a font asset
  // declared in pubspec.yaml under flutter -> fonts.
  final IconData icCustomFont = IconData(
    0xe000,
    fontFamily: 'AtlasIris',
    fontPackage: 'atlas_iris_icons',
  );

  // The twelve plates arranged in a fixed order. This list and the parallel
  // lists below are accessed only via indexed for-loops (no for-in).
  final List<IconData> plates = <IconData>[
    icMap, icExplore, icCompass, icAnchor,
    icArrowFwd, icArrowBack, icSettings, icSearch,
    icFlag, icLandmark, icRoom, icTerrain,
  ];

  final List<String> plateNames = <String>[
    'Icons.map', 'Icons.explore', 'Icons.explore_outlined', 'Icons.anchor',
    'Icons.arrow_forward', 'Icons.arrow_back', 'Icons.settings', 'Icons.search',
    'Icons.flag', 'Icons.account_balance', 'Icons.room', 'Icons.terrain',
  ];

  final List<String> plateMeanings = <String>[
    'general map / atlas concept',
    'compass-rose used for exploration',
    'outlined compass variant',
    'anchor / fixed-point marker',
    'forward / next navigation',
    'back / previous navigation',
    'configuration / preferences',
    'search / lookup',
    'flag / waypoint marker',
    'landmark / civic building',
    'room / location pin',
    'terrain / topographic relief',
  ];

  print('Plates assembled: ${plates.length} legend entries.');
  print('First plate:  ${plateNames[0]}  -> codePoint = 0x'
      '${plates[0].codePoint.toRadixString(16)}');
  print('Last plate:   ${plateNames[plates.length - 1]}  -> codePoint = 0x'
      '${plates[plates.length - 1].codePoint.toRadixString(16)}');

  // ===========================================================================
  // SECTION 1 :: TITLE HERO
  //
  // The opening cartouche. Indigo-violet gradient ground; copper border;
  // lavender swatches ranged along the bottom. The title is set in the
  // display style. A small subtitle reminds the reader that the subject is
  // foundation-level: IconData and IconDataProperty.
  // ===========================================================================
  print('Section 1 :: gilding the title cartouche.');

  final Widget section1 = Container(
    padding: const EdgeInsets.all(22),
    decoration: _indigoSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.map, color: irisCopper, size: 40),
            _horizontalGap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ATLAS  IRIS', style: _displayStyle(26, irisCream)),
                  _verticalGap(4),
                  Text(
                    'A cartographer\'s legend room for IconData & IconDataProperty',
                    style: _bodyStyle(irisLavSoft, size: 14, w: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Icon(Icons.explore, color: irisCopper, size: 40),
          ],
        ),
        _verticalGap(14),
        Text(
          'package:flutter/foundation.dart  ::  IconDataProperty',
          style: _monoStyle(irisLavSoft, size: 12),
        ),
        _verticalGap(2),
        Text(
          'package:flutter/widgets.dart     ::  IconData',
          style: _monoStyle(irisLavSoft.withValues(alpha: 0.85), size: 11),
        ),
        _verticalGap(2),
        Text(
          'Diagnosticable -> debugFillProperties -> DiagnosticPropertiesBuilder',
          style: _monoStyle(irisLavSoft.withValues(alpha: 0.7), size: 11),
        ),
        _verticalGap(14),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _swatch('cream', irisCream),
            _swatch('linen', irisLinen),
            _swatch('chalk', irisChalk),
            _swatch('lavender', irisLavender),
            _swatch('lavSoft', irisLavSoft),
            _swatch('violet', irisViolet),
            _swatch('indigo', irisIndigo),
            _swatch('ink', irisInk),
            _swatch('charcoal', irisCharcoal),
            _swatch('copper', irisCopper),
            _swatch('rust', irisRust),
            _swatch('amber', irisAmber),
            _swatch('olive', irisOlive),
            _swatch('sage', irisSage),
            _swatch('dust', irisDust),
            _swatch('stone', irisStone),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 :: ANATOMY OF AN ICONDATA
  //
  // Prose paragraphs, then the anatomy diagram (CustomPainter), then a
  // property table mapping each IconData field to a one-sentence definition.
  // ===========================================================================
  print('Section 2 :: writing the anatomy of an IconData.');

  final Widget section2Header = _sectionHeader(
    '02',
    'Anatomy of an IconData',
    'codePoint, fontFamily, fontPackage, matchTextDirection',
  );

  final Widget section2Prose = _proseCard(
    title: 'Anatomy :: an IconData is a legend entry, not a painting',
    paragraphs: const [
      'Every glyph in an icon font lives at a precise codepoint - a small '
          'integer in the Unicode Private Use Area (U+E000 through U+F8FF, '
          'with extensions into Plane 15 for newer fonts). Material Icons '
          'places the home glyph at U+E88A, the search glyph at U+E8B6, and '
          'the settings glyph at U+E57F. These are not arbitrary - they are '
          'an encoding contract between the font file and the IconData lookup.',
      'IconData is the value class that records this contract. Its four '
          'fields - codePoint, fontFamily, fontPackage, matchTextDirection - '
          'plus an optional fontFamilyFallback, are the entire legend entry. '
          'IconData has no visual presence on its own; it is metadata.',
      'When you write Icons.home you are reading a static const IconData '
          'declared in the Icons class: IconData(0xe88a, fontFamily: '
          '\'MaterialIcons\'). That const expression is reused everywhere the '
          'symbol Icons.home appears, so all those references compare equal '
          'under operator == and have the same hashCode.',
      'The matchTextDirection flag is the cartographer\'s mirror. When the '
          'IconData carries matchTextDirection = true and the surrounding '
          'Directionality is TextDirection.rtl, the Icon widget paints the '
          'glyph mirrored. This is how arrow_back becomes arrow_forward in '
          'Arabic and Hebrew layouts without the application code having to '
          'swap which constant to draw.',
    ],
  );

  final Widget section2Diagram = Container(
    padding: const EdgeInsets.all(14),
    decoration: _legendSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Diagram :: fields of IconData', style: _titleStyle(15, irisInk)),
        _verticalGap(6),
        Text(
          'The four field labels are connected to the central IconData node by copper arrows. ',
          style: _bodyStyle(irisStone, size: 11),
        ),
        _verticalGap(10),
        SizedBox(
          height: 220,
          child: CustomPaint(
            painter: _AnatomyPainter(),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    ),
  );

  final Widget section2Table = Container(
    padding: const EdgeInsets.all(14),
    decoration: _chartSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property dictionary :: IconData', style: _titleStyle(15, irisInk)),
        _verticalGap(6),
        Text(
          'Each row maps one IconData constructor argument to its purpose.',
          style: _bodyStyle(irisStone, size: 11),
        ),
        _verticalGap(10),
        _propRow('codePoint', 'int (required) - the Unicode codepoint of the glyph in the icon font.'),
        _propRow('fontFamily', 'String? - the font family name; null falls back to the inherited family.'),
        _propRow('fontPackage', 'String? - the package name when the font lives in a Dart package.'),
        _propRow('matchTextDirection', 'bool - mirror the glyph horizontally in RTL Directionality.'),
        _propRow('fontFamilyFallback', 'List<String>? - additional family names tried if codepoint is absent.'),
        _verticalGap(8),
        Text('Equality semantics', style: _titleStyle(13, irisIndigo)),
        _verticalGap(4),
        Text(
          'IconData overrides operator == and hashCode using all four fields plus the fallback list. Two IconData instances are equal iff every field is equal.',
          style: _bodyStyle(irisCharcoal, size: 12),
        ),
      ],
    ),
  );

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section2Header,
      _verticalGap(10),
      section2Prose,
      _verticalGap(10),
      section2Diagram,
      _verticalGap(10),
      section2Table,
    ],
  );

  // ===========================================================================
  // SECTION 3 :: TWELVE ICON PLATES
  //
  // Twelve Cards, each rendering an Icon plus printed metadata: codePoint
  // (hex), fontFamily, fontPackage, matchTextDirection. The plates are the
  // canonical "legend entries" the rest of the demo references.
  // ===========================================================================
  print('Section 3 :: laying out the twelve illuminated plates.');

  final List<Widget> plateWidgets = <Widget>[];
  for (int i = 0; i < plates.length; i++) {
    final IconData d = plates[i];
    final String name = plateNames[i];
    final String meaning = plateMeanings[i];
    // Cycle accent colors across the plates so the page feels varied.
    Color accent;
    if (i % 4 == 0) {
      accent = irisIndigo;
    } else if (i % 4 == 1) {
      accent = irisViolet;
    } else if (i % 4 == 2) {
      accent = irisCopper;
    } else {
      accent = irisRust;
    }
    final String hex = '0x${d.codePoint.toRadixString(16)}';
    final String fontFamily = d.fontFamily ?? '<none>';
    final String fontPackage = d.fontPackage ?? '<none>';
    final String matchTd = d.matchTextDirection.toString();

    final Widget plate = Container(
      width: 168,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: irisCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Icon(d, size: 38, color: accent)),
          _verticalGap(6),
          Text(name, style: _captionStyle(irisInk, size: 11)),
          Text(meaning, style: _bodyStyle(irisStone, size: 10)),
          _verticalGap(4),
          Text('codePoint  $hex', style: _monoStyle(irisCopper, size: 10)),
          Text('fontFamily $fontFamily', style: _monoStyle(irisIndigo, size: 10)),
          Text('package    $fontPackage', style: _monoStyle(irisIndigo, size: 10)),
          Text('matchTD    $matchTd', style: _monoStyle(irisIndigo, size: 10)),
        ],
      ),
    );
    plateWidgets.add(plate);
  }

  final Widget section3Header = _sectionHeader(
    '03',
    'Twelve Icon Plates',
    'rendered glyphs paired with their legend metadata',
  );

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section3Header,
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: _chartSurface(),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: plateWidgets,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 4 :: ICONDATAPROPERTY IN ACTION
  //
  // For six selected icons we build a DiagnosticPropertiesBuilder, add an
  // IconDataProperty plus a few sibling DiagnosticsNode children
  // (StringProperty, DoubleProperty, FlagProperty, ColorProperty), and render
  // the resulting properties list line by line in a card.
  //
  // Note: We must call .toString() on each DiagnosticsNode (not the builder
  // itself - that has no toString hook). The cards reproduce what the widget
  // inspector would show in its property panel.
  // ===========================================================================
  print('Section 4 :: building IconDataProperty demonstrations.');

  final List<IconData> demoIcons = <IconData>[
    icMap, icExplore, icArrowFwd, icSettings, icSearch, icCustomFont,
  ];
  final List<String> demoNames = <String>[
    'icMap', 'icExplore', 'icArrowFwd', 'icSettings', 'icSearch', 'icCustomFont',
  ];
  final List<String> demoSemantic = <String>[
    'world map', 'compass rose', 'forward navigation',
    'preferences', 'search lookup', 'atlas iris brand mark',
  ];
  final List<double> demoSizes = <double>[24.0, 32.0, 28.0, 24.0, 24.0, 36.0];
  final List<Color> demoColors = <Color>[
    irisIndigo, irisViolet, irisCopper, irisInk, irisRust, irisCharcoal,
  ];
  final List<bool> demoIncluded = <bool>[true, true, true, false, true, true];

  final List<Widget> demoCards = <Widget>[];
  for (int i = 0; i < demoIcons.length; i++) {
    final IconData d = demoIcons[i];
    final String n = demoNames[i];
    final String semantic = demoSemantic[i];
    final double sz = demoSizes[i];
    final Color col = demoColors[i];
    final bool included = demoIncluded[i];

    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    builder.add(IconDataProperty('icon', d));
    builder.add(StringProperty('semanticLabel', semantic, quoted: true));
    builder.add(DoubleProperty('size', sz, defaultValue: 24.0));
    builder.add(ColorProperty('color', col, defaultValue: null));
    builder.add(FlagProperty('included',
        value: included, ifTrue: 'visible', ifFalse: 'hidden'));
    builder.add(StringProperty('runtimeType', d.runtimeType.toString(), quoted: false));

    final List<DiagnosticsNode> props = builder.properties;
    final List<Widget> propLines = <Widget>[];
    for (int j = 0; j < props.length; j++) {
      final DiagnosticsNode node = props[j];
      final String rendered = node.toString();
      propLines.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                '${j + 1}.',
                style: _monoStyle(irisCopper, size: 11, w: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Text(rendered, style: _monoStyle(irisInk, size: 11)),
            ),
          ],
        ),
      ));
    }

    final Widget card = Container(
      padding: const EdgeInsets.all(12),
      decoration: _legendSurface(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(d, size: 26, color: col),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('demo[$i] $n', style: _titleStyle(13, irisInk)),
                    Text('codePoint 0x${d.codePoint.toRadixString(16)}',
                        style: _monoStyle(irisCopper, size: 10)),
                  ],
                ),
              ),
            ],
          ),
          _verticalGap(8),
          Text('builder.properties:', style: _captionStyle(irisIndigo, size: 11)),
          _verticalGap(4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: irisChalk,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: irisCopper.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: propLines,
            ),
          ),
        ],
      ),
    );
    demoCards.add(card);
  }

  final Widget section4Header = _sectionHeader(
    '04',
    'IconDataProperty in action',
    'six DiagnosticPropertiesBuilder demonstrations',
  );

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section4Header,
      _verticalGap(10),
      _proseCard(
        title: 'Reading the cards',
        paragraphs: const [
          'Every Diagnosticable in Flutter has a debugFillProperties hook. '
              'That hook receives a DiagnosticPropertiesBuilder and adds '
              'DiagnosticsNode subclasses for every property the object owns. '
              'For an Icon widget, the hook adds an IconDataProperty for the '
              'icon, a StringProperty for the semanticLabel, a DoubleProperty '
              'for size, and a ColorProperty for color.',
          'Each card below builds such a builder by hand for a chosen icon '
              'and renders the resulting properties list. The IconDataProperty '
              'is always entry #1 and shows the icon\'s name plus the rendered '
              'string \'IconData(U+0E88A)\' or similar.',
        ],
      ),
      _verticalGap(10),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: demoCards,
      ),
    ],
  );

  // ===========================================================================
  // SECTION 5 :: CODEPOINT ENCYCLOPEDIA
  //
  // Eighteen well-known Material Icons codepoints in a registry table:
  // codepoint hex, decimal, glyph rendering (via IconData), and fontFamily.
  // The table is built as a Column of Rows; the rows are colored alternately.
  // ===========================================================================
  print('Section 5 :: cataloging the codepoint encyclopedia.');

  final List<IconData> registryIcons = <IconData>[
    Icons.home, Icons.search, Icons.settings, Icons.menu, Icons.close,
    Icons.add, Icons.remove, Icons.check, Icons.star, Icons.favorite,
    Icons.map, Icons.explore, Icons.flag, Icons.anchor, Icons.terrain,
    Icons.account_balance, Icons.room, Icons.compare_arrows,
  ];
  final List<String> registryNames = <String>[
    'Icons.home', 'Icons.search', 'Icons.settings', 'Icons.menu', 'Icons.close',
    'Icons.add', 'Icons.remove', 'Icons.check', 'Icons.star', 'Icons.favorite',
    'Icons.map', 'Icons.explore', 'Icons.flag', 'Icons.anchor', 'Icons.terrain',
    'Icons.account_balance', 'Icons.room', 'Icons.compare_arrows',
  ];

  final List<Widget> registryRows = <Widget>[];
  // Header row.
  registryRows.add(Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: irisIndigo,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(width: 38, child: Text('glyph', style: _captionStyle(irisCream, size: 11))),
        SizedBox(width: 158, child: Text('name', style: _captionStyle(irisCream, size: 11))),
        SizedBox(width: 86, child: Text('hex', style: _captionStyle(irisCream, size: 11))),
        SizedBox(width: 76, child: Text('decimal', style: _captionStyle(irisCream, size: 11))),
        Expanded(child: Text('fontFamily', style: _captionStyle(irisCream, size: 11))),
      ],
    ),
  ));
  for (int i = 0; i < registryIcons.length; i++) {
    final IconData d = registryIcons[i];
    final String n = registryNames[i];
    final String hex = '0x${d.codePoint.toRadixString(16)}';
    final String dec = d.codePoint.toString();
    final String family = d.fontFamily ?? '<inherited>';
    final Color rowBg = i % 2 == 0 ? irisCream : irisLinen;
    registryRows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: rowBg,
        border: Border(
          bottom: BorderSide(color: irisCopper.withValues(alpha: 0.25), width: 0.6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 38, child: Icon(d, size: 22, color: irisIndigo)),
          SizedBox(
            width: 158,
            child: Text(n, style: _monoStyle(irisInk, size: 11, w: FontWeight.w600)),
          ),
          SizedBox(
            width: 86,
            child: Text(hex, style: _monoStyle(irisCopper, size: 11)),
          ),
          SizedBox(
            width: 76,
            child: Text(dec, style: _monoStyle(irisStone, size: 11)),
          ),
          Expanded(
            child: Text(family, style: _monoStyle(irisIndigo, size: 11)),
          ),
        ],
      ),
    ));
  }

  final Widget section5Header = _sectionHeader(
    '05',
    'Codepoint Encyclopedia',
    'eighteen Material Icons codepoints in a registry table',
  );

  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section5Header,
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: _chartSurface(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: registryRows,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 6 :: matchTextDirection
  //
  // Same icon (the directional arrow) rendered four ways:
  //   * matchTextDirection = false, Directionality LTR
  //   * matchTextDirection = false, Directionality RTL
  //   * matchTextDirection = true,  Directionality LTR
  //   * matchTextDirection = true,  Directionality RTL  <- mirrored!
  //
  // Only the fourth cell visibly flips the glyph, demonstrating the contract.
  // ===========================================================================
  print('Section 6 :: building the matchTextDirection demo.');

  final IconData mtdFalse = IconData(0xe5c8, fontFamily: 'MaterialIcons', matchTextDirection: false);
  final IconData mtdTrue  = IconData(0xe5c8, fontFamily: 'MaterialIcons', matchTextDirection: true);

  final List<List<dynamic>> mtdCells = <List<dynamic>>[
    <dynamic>[mtdFalse, TextDirection.ltr, 'matchTextDirection: false', 'Directionality: LTR', 'glyph drawn as designed'],
    <dynamic>[mtdFalse, TextDirection.rtl, 'matchTextDirection: false', 'Directionality: RTL', 'glyph not mirrored (flag is false)'],
    <dynamic>[mtdTrue,  TextDirection.ltr, 'matchTextDirection: true',  'Directionality: LTR', 'glyph drawn as designed (LTR is default)'],
    <dynamic>[mtdTrue,  TextDirection.rtl, 'matchTextDirection: true',  'Directionality: RTL', 'glyph mirrored horizontally (the contract!)'],
  ];

  final List<Widget> mtdCards = <Widget>[];
  for (int i = 0; i < mtdCells.length; i++) {
    final List<dynamic> row = mtdCells[i];
    final IconData d = row[0] as IconData;
    final TextDirection td = row[1] as TextDirection;
    final String f1 = row[2] as String;
    final String f2 = row[3] as String;
    final String desc = row[4] as String;

    final Color border = i == 3 ? irisCopper : irisIndigo.withValues(alpha: 0.5);

    final Widget card = Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: irisChalk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border, width: i == 3 ? 1.6 : 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('case ${i + 1}', style: _captionStyle(irisCopper, size: 11)),
          _verticalGap(6),
          Center(
            child: Directionality(
              textDirection: td,
              child: Icon(d, size: 56, color: irisIndigo),
            ),
          ),
          _verticalGap(8),
          Text(f1, style: _monoStyle(irisInk, size: 11, w: FontWeight.w700)),
          Text(f2, style: _monoStyle(irisInk, size: 11, w: FontWeight.w700)),
          _verticalGap(4),
          Text(desc, style: _bodyStyle(irisStone, size: 11)),
        ],
      ),
    );
    mtdCards.add(card);
  }

  final Widget section6Header = _sectionHeader(
    '06',
    'matchTextDirection',
    'arrow_back drawn LTR vs RTL with mtd false vs true',
  );

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section6Header,
      _verticalGap(10),
      _proseCard(
        title: 'The cartographer\'s mirror',
        paragraphs: const [
          'When matchTextDirection is true and the surrounding Directionality '
              'is RTL, Icon paints the glyph mirrored horizontally. This is '
              'the framework\'s built-in mechanism for making directional '
              'arrows obey reading order without the application code having '
              'to swap which constant to draw.',
          'The four cards below reproduce the full truth table. Only case 4 '
              '(true + RTL) actually flips the glyph; the other three are '
              'reference rows.',
        ],
      ),
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _chartSurface(),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: mtdCards,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 7 :: fontPackage demonstration
  //
  // Three Card variants show how IconData.fontPackage participates in the
  // font lookup. The first uses a Material Icons glyph (no package). The
  // second uses a Cupertino Icons glyph (ships in cupertino_icons package).
  // The third uses a hand-built custom-font IconData with fontFamily
  // 'AtlasIris' and fontPackage 'atlas_iris_icons'.
  // ===========================================================================
  print('Section 7 :: assembling the fontPackage demonstration.');

  final IconData fpMaterial = IconData(0xe57f, fontFamily: 'MaterialIcons');
  final IconData fpCupertino = IconData(
    0xf3d8,
    fontFamily: 'CupertinoIcons',
    fontPackage: 'cupertino_icons',
  );
  final IconData fpCustom = IconData(
    0xe000,
    fontFamily: 'AtlasIris',
    fontPackage: 'atlas_iris_icons',
  );

  final List<IconData> fpEntries = <IconData>[fpMaterial, fpCupertino, fpCustom];
  final List<String> fpHeaders = <String>[
    'Material Icons (built-in)',
    'Cupertino Icons (package)',
    'Custom font (your package)',
  ];
  final List<String> fpDescriptions = <String>[
    'Flutter ships the MaterialIcons font as part of the framework. fontPackage is null because no package wraps the font; the font name resolves directly against the engine\'s loaded fonts.',
    'Cupertino Icons ships in the cupertino_icons pub package. Both fontFamily and fontPackage must be set so the engine can find the font asset declared in cupertino_icons/pubspec.yaml.',
    'When you ship your own icon font you declare it in your package\'s pubspec.yaml under flutter -> fonts. Setting fontPackage tells the engine to look in that package for the asset, even if the font name itself is unique.',
  ];

  final List<Widget> fpCards = <Widget>[];
  for (int i = 0; i < fpEntries.length; i++) {
    final IconData d = fpEntries[i];
    final String header = fpHeaders[i];
    final String desc = fpDescriptions[i];

    final Widget card = Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: _legendSurface(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: _titleStyle(13, irisInk)),
          _verticalGap(6),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: irisChalk,
                shape: BoxShape.circle,
                border: Border.all(color: irisCopper.withValues(alpha: 0.45)),
              ),
              // Note: a custom font that is not actually loaded will render
              // as the Unicode replacement glyph; the demo is illustrative.
              child: Icon(d, size: 36, color: irisIndigo),
            ),
          ),
          _verticalGap(8),
          Text(
            'codePoint 0x${d.codePoint.toRadixString(16)}',
            style: _monoStyle(irisCopper, size: 11),
          ),
          Text(
            'fontFamily ${d.fontFamily ?? "<none>"}',
            style: _monoStyle(irisIndigo, size: 11),
          ),
          Text(
            'fontPackage ${d.fontPackage ?? "<none>"}',
            style: _monoStyle(irisIndigo, size: 11),
          ),
          _verticalGap(8),
          Text(desc, style: _bodyStyle(irisStone, size: 11)),
        ],
      ),
    );
    fpCards.add(card);
  }

  final Widget section7Header = _sectionHeader(
    '07',
    'fontPackage demonstration',
    'Material vs Cupertino vs custom-package fonts',
  );

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section7Header,
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _chartSurface(),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: fpCards,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 8 :: DIAGNOSTICSNODE TREE  (toStringDeep)
  //
  // We render a hand-built example of what a Container(child: Icon(...))
  // toStringDeep() output looks like, in monospace, with indentation. This
  // is the textual form documentation tools and `dart devtools --inspector`
  // present to a developer who calls obj.toStringDeep().
  // ===========================================================================
  print('Section 8 :: rendering the toStringDeep example.');

  final List<String> deepLines = <String>[
    'Container',
    ' \u2502 padding: EdgeInsets(8.0, 8.0, 8.0, 8.0)',
    ' \u2502 alignment: center',
    ' \u2502 decoration: BoxDecoration:',
    ' \u2502   color: Color(0xFFB5A6D5)',
    ' \u2502   borderRadius: BorderRadius.circular(8.0)',
    ' \u2502 child: Icon',
    ' \u2502   icon: IconData(U+0E88A)',
    ' \u2502   size: 32.0',
    ' \u2502   color: Color(0xFF5B4F8C)',
    ' \u2502   semanticLabel: "home"',
    ' \u2502   matchTextDirection: false',
    ' \u2514\u2500',
  ];

  final Widget section8Header = _sectionHeader(
    '08',
    'DiagnosticsNode tree',
    'toStringDeep() rendered for Container( child: Icon(Icons.home))',
  );

  final List<Widget> deepLineWidgets = <Widget>[];
  for (int i = 0; i < deepLines.length; i++) {
    deepLineWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(deepLines[i], style: _monoStyle(irisInk, size: 11)),
    ));
  }

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section8Header,
      _verticalGap(10),
      _proseCard(
        title: 'How toStringDeep is built',
        paragraphs: const [
          'Every Diagnosticable returns a DiagnosticsNode from toDiagnosticsNode(). Calling toStringDeep on that node walks the children, collects each child\'s own getProperties() and getChildren(), and indents the output by tree depth.',
          'For an Icon embedded in a Container, the tree includes one IconDataProperty entry that renders as \'icon: IconData(U+0E88A)\'. That string is exactly what a developer pastes into a bug report; the inspector\'s remote pane reads the JSON form (toJsonMap) instead.',
        ],
      ),
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: irisCharcoal,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: irisCopper.withValues(alpha: 0.7), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('toStringDeep()  (paste-ready)',
                style: _monoStyle(irisAmber, size: 11, w: FontWeight.w700)),
            _verticalGap(6),
            DefaultTextStyle(
              style: _monoStyle(irisCream, size: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: deepLineWidgets,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 9 :: DOCUMENTATION FLOW DIAGRAM
  //
  // CustomPainter draws four labelled boxes connected by copper arrows showing
  // the data flow:  IconData -> IconDataProperty -> DiagnosticsNode -> toJsonMap.
  // Below the diagram, a short caption explains each transition.
  // ===========================================================================
  print('Section 9 :: drawing the documentation flow diagram.');

  final Widget section9Header = _sectionHeader(
    '09',
    'Documentation pipeline',
    'IconData -> IconDataProperty -> DiagnosticsNode -> toJsonMap',
  );

  final Widget section9Diagram = Container(
    padding: const EdgeInsets.all(14),
    decoration: _legendSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pipeline diagram', style: _titleStyle(15, irisInk)),
        _verticalGap(8),
        SizedBox(
          height: 110,
          child: CustomPaint(
            painter: _FlowPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        _verticalGap(10),
        Text(
          'The four boxes represent the four stages every IconData traverses '
          'before it is consumed by an external tool such as the widget '
          'inspector, devtools, or dartdoc.',
          style: _bodyStyle(irisCharcoal, size: 12),
        ),
      ],
    ),
  );

  final Widget section9Steps = Container(
    padding: const EdgeInsets.all(14),
    decoration: _chartSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stage explanations', style: _titleStyle(15, irisInk)),
        _verticalGap(8),
        _legendKey('1', 'IconData.  An immutable value (codePoint, fontFamily, fontPackage, matchTextDirection). The legend entry.'),
        _legendKey('2', 'IconDataProperty.  Wraps the IconData in a DiagnosticsProperty so it can join a property list.'),
        _legendKey('3', 'DiagnosticsNode.  The wrapped value joins a tree of nodes returned by toDiagnosticsNode().'),
        _legendKey('4', 'toJsonMap.  The node serializes to JSON; valueProperties.codePoint preserves the numeric codepoint.'),
      ],
    ),
  );

  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section9Header,
      _verticalGap(10),
      section9Diagram,
      _verticalGap(10),
      section9Steps,
    ],
  );

  // ===========================================================================
  // SECTION 10 :: ICON GLOSSARY
  //
  // Fourteen vocabulary entries arranged as small cards. The vocabulary
  // intentionally bridges typography (glyph, baseline, ascender) and Flutter
  // diagnostics (DiagnosticsNode, IconDataProperty, valueProperties), so the
  // reader sees the icon-as-data idea in both worlds.
  // ===========================================================================
  print('Section 10 :: writing the icon glossary.');

  final List<List<String>> glossary = <List<String>>[
    <String>['codePoint', 'A Unicode integer identifying a glyph in a font; for icon fonts usually in the U+E000-U+F8FF private-use range.'],
    <String>['fontFamily', 'The name of the font that contains the glyph. Material Icons, CupertinoIcons, FontAwesome, etc.'],
    <String>['fontPackage', 'The Dart package the font lives in. null for the framework-bundled MaterialIcons font.'],
    <String>['glyph', 'A specific shape drawn for a codepoint by a font. The same codepoint can have different glyphs in different fonts.'],
    <String>['baseline', 'The horizontal line that letters and glyphs sit on. Icons in a font are drawn relative to the baseline.'],
    <String>['ascender', 'The portion of a glyph that rises above the x-height (or for icons, above the visual centerline).'],
    <String>['descender', 'The portion of a glyph that drops below the baseline.'],
    <String>['ligature', 'A composite glyph formed when a font replaces a specific letter sequence (e.g. \'home\') with a single icon glyph.'],
    <String>['matchTextDirection', 'Boolean flag on IconData; mirrors the glyph horizontally inside an RTL Directionality.'],
    <String>['IconData', 'The value class that records (codePoint, fontFamily, fontPackage, matchTextDirection); pure metadata.'],
    <String>['IconDataProperty', 'DiagnosticsProperty<IconData> that adds valueProperties.codePoint when serialized to JSON.'],
    <String>['DiagnosticsNode', 'Abstract base for a node in a diagnostics tree; carries a name, a value, and a list of children.'],
    <String>['DiagnosticPropertiesBuilder', 'Mutable builder used by debugFillProperties to accumulate DiagnosticsNode entries.'],
    <String>['valueProperties', 'A reserved JSON key in the toJsonMap output that records value-specific data; for IconData it carries codePoint.'],
  ];

  final List<Widget> glossaryCards = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    final String term = glossary[i][0];
    final String defn = glossary[i][1];
    glossaryCards.add(Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: i % 2 == 0 ? irisCream : irisLinen,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: irisCopper.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(term, style: _titleStyle(12, irisIndigo)),
          _verticalGap(4),
          Text(defn, style: _bodyStyle(irisCharcoal, size: 11)),
        ],
      ),
    ));
  }

  final Widget section10Header = _sectionHeader(
    '10',
    'Icon glossary',
    'fourteen vocabulary entries spanning typography and diagnostics',
  );

  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section10Header,
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _chartSurface(),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: glossaryCards,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 11 :: FIELD REFERENCE TABLE
  //
  // Three-column table for IconData. Field, type, description.
  // ===========================================================================
  print('Section 11 :: laying out the field reference table.');

  final List<List<String>> fields = <List<String>>[
    <String>['codePoint', 'int', 'The Unicode codepoint of the glyph in the icon font. Required.'],
    <String>['fontFamily', 'String?', 'The name of the icon font containing the glyph; null falls back to the inherited family from IconTheme.'],
    <String>['fontPackage', 'String?', 'The package that ships the font asset; null for the framework-bundled MaterialIcons font.'],
    <String>['matchTextDirection', 'bool', 'When true, the Icon widget mirrors the glyph horizontally inside RTL Directionality. Default: false.'],
    <String>['fontFamilyFallback', 'List<String>?', 'Additional font family names tried in order if the primary family does not contain the codepoint.'],
  ];

  final List<Widget> fieldRows = <Widget>[];
  fieldRows.add(Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: irisIndigo,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(width: 160, child: Text('field', style: _captionStyle(irisCream, size: 11))),
        SizedBox(width: 110, child: Text('type', style: _captionStyle(irisCream, size: 11))),
        Expanded(child: Text('description', style: _captionStyle(irisCream, size: 11))),
      ],
    ),
  ));
  for (int i = 0; i < fields.length; i++) {
    final List<String> row = fields[i];
    final String field = row[0];
    final String type = row[1];
    final String desc = row[2];
    fieldRows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: i % 2 == 0 ? irisCream : irisLinen,
        border: Border(
          bottom: BorderSide(color: irisCopper.withValues(alpha: 0.25), width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 160, child: Text(field, style: _monoStyle(irisInk, size: 11, w: FontWeight.w700))),
          SizedBox(width: 110, child: Text(type, style: _monoStyle(irisCopper, size: 11))),
          Expanded(child: Text(desc, style: _bodyStyle(irisCharcoal, size: 11))),
        ],
      ),
    ));
  }

  final Widget section11Header = _sectionHeader(
    '11',
    'Field reference :: IconData',
    'field, type, description',
  );

  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section11Header,
      _verticalGap(10),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: _chartSurface(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fieldRows,
        ),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 12 :: CLOSING ESSAY
  //
  // A 200-word prose paragraph on icon-as-data and the cartographer's legend
  // tradition. Written in a single panel, with a small column of marginalia
  // (DocumentationIcon brief reference).
  // ===========================================================================
  print('Section 12 :: writing the closing essay.');

  final Widget section12Header = _sectionHeader(
    '12',
    'Closing essay',
    'icon-as-data and the cartographer\'s legend tradition',
  );

  final Widget section12Essay = Container(
    padding: const EdgeInsets.all(16),
    decoration: _chartSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('On the icon-as-data', style: _titleStyle(16, irisIndigo)),
        _verticalGap(8),
        Text(
          'A cartographer\'s legend, drawn in the margin of a folio map, is not '
          'the territory and is not the painting. It is metadata: an indexed '
          'agreement that the wavy line means river, the small castle means '
          'fortified town, the tiny cross means church. The reader who knows '
          'the legend can read the map. The reader who does not is looking at '
          'pretty marks. IconData stands in this same relation to the '
          'rendered Icon. It is a four-field tuple - codePoint, fontFamily, '
          'fontPackage, matchTextDirection - that names a glyph in a font but '
          'is not the glyph itself. The Icon widget paints; the IconData '
          'specifies. When debugFillProperties wraps an IconData in an '
          'IconDataProperty and adds it to a DiagnosticPropertiesBuilder, '
          'that legend entry begins its second life: it flows into the '
          'DiagnosticsNode tree, into toJsonMap, into the inspector, and '
          'eventually into the widget panels and tooltips that documentation '
          'tools build for the developer reading the API. The icon as data '
          'survives in the legend long after the painting fades from the wall.',
          style: _bodyStyle(irisCharcoal, size: 13),
        ),
        _verticalGap(12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: _legendSurface(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Marginalia :: DocumentationIcon', style: _titleStyle(13, irisIndigo)),
              _verticalGap(4),
              Text(
                'package:flutter/foundation.dart also exposes a small '
                'annotation, DocumentationIcon(String url), used by '
                'documentation tooling to attach an icon URL to a class '
                'declaration. It is metadata of a different kind - external '
                'icon, not in-font codepoint - but it shares the spirit of '
                'this essay: marks that say "this lives here" without doing '
                'the painting themselves.',
                style: _bodyStyle(irisCharcoal, size: 11),
              ),
              _verticalGap(6),
              Text('  const di = DocumentationIcon(\'https://flutter.dev/icon.png\');',
                  style: _monoStyle(irisCopper, size: 10)),
              Text('  print(di.url);  // -> https://flutter.dev/icon.png',
                  style: _monoStyle(irisCopper, size: 10)),
            ],
          ),
        ),
      ],
    ),
  );

  // Demonstrate DocumentationIcon construction (acknowledges the original
  // stub's subject) so the print-trail proves the symbol resolves under
  // d4rt.  We construct one and print its url.  The widget tree references
  // the marginalia card above; this code runs purely for the trail.
  final DocumentationIcon docIconRef = DocumentationIcon(
    'https://flutter.dev/icons/documentation_icon.png',
  );
  print('DocumentationIcon constructed:');
  print('  url:         ${docIconRef.url}');
  print('  runtimeType: ${docIconRef.runtimeType}');

  // ===========================================================================
  // PRINT-TRAIL :: a final block of print() calls that summarises the demo for
  // the d4rt host's stdout. None of this affects the widget tree; it is purely
  // narrative debugging output.
  // ===========================================================================
  print('----------------------------------------------------------------');
  print('Atlas Iris  ::  summary of legend entries');
  print('----------------------------------------------------------------');
  for (int i = 0; i < plates.length; i++) {
    final IconData d = plates[i];
    final String name = plateNames[i];
    print('plate ${(i + 1).toString().padLeft(2, " ")}.  '
        '$name  =>  codePoint = 0x'
        '${d.codePoint.toRadixString(16)}, '
        'fontFamily = ${d.fontFamily ?? "<inherited>"}, '
        'fontPackage = ${d.fontPackage ?? "<none>"}, '
        'matchTextDirection = ${d.matchTextDirection}');
  }
  print('----------------------------------------------------------------');
  print('IconDataProperty demonstrations:');
  for (int i = 0; i < demoIcons.length; i++) {
    final IconData d = demoIcons[i];
    final String n = demoNames[i];
    final DiagnosticPropertiesBuilder b = DiagnosticPropertiesBuilder();
    b.add(IconDataProperty('icon', d));
    print('  demo[$i] $n -> ${b.properties[0].toString()}');
  }
  print('----------------------------------------------------------------');
  print('Atlas Iris demo finished assembling its widget tree.');
  print('Returning the frozen Column to the d4rt host renderer.');
  print('================================================================');

  // ===========================================================================
  // FINAL TREE
  //
  // We return one SingleChildScrollView wrapping a Padding wrapping a Column
  // of all twelve sections. Section dividers are simple SizedBox gaps with a
  // thin copper-tinted line.
  // ===========================================================================
  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                irisCopper.withValues(alpha: 0.0),
                irisCopper.withValues(alpha: 0.6),
                irisCopper.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      );

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(color: irisLinen),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          section1,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section2,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section3,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section4,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section5,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section6,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section7,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section8,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section9,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section10,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section11,
          _verticalGap(16),
          _divider(),
          _verticalGap(8),
          section12Header,
          _verticalGap(10),
          section12Essay,
          _verticalGap(20),
          // Closing colophon: a small lavender ribbon centered.
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: irisLavender.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: irisCopper.withValues(alpha: 0.55)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map, size: 18, color: irisIndigo),
                  const SizedBox(width: 8),
                  Text(
                    'Atlas Iris  ::  end of legend room',
                    style: _captionStyle(irisIndigo, size: 12),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.explore, size: 18, color: irisIndigo),
                ],
              ),
            ),
          ),
          _verticalGap(20),
        ],
      ),
    ),
  );
}
