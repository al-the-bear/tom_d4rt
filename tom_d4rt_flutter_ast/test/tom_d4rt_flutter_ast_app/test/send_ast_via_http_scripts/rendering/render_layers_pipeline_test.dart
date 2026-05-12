// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Flutter's rendering layer tree and
// rendering pipeline.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that walks through the
// rendering pipeline and the layer tree from the framework's perspective.
// Nine thematic sections cover:
//
//   1. Hero intro - what the layer tree is, how it sits below the render
//      tree, and how `dart:ui` consumes it.
//   2. Layer class hierarchy CustomPainter - inheritance diagram for the
//      Layer family (Layer -> ContainerLayer -> OffsetLayer ->
//      TransformLayer, ClipRectLayer, ClipRRectLayer, ClipPathLayer,
//      OpacityLayer, ColorFilterLayer, ImageFilterLayer,
//      BackdropFilterLayer, ShaderMaskLayer, FollowerLayer, LeaderLayer,
//      AnnotatedRegionLayer<T>) plus the leaf layers (PictureLayer,
//      TextureLayer, PlatformViewLayer, PerformanceOverlayLayer).
//   3. Pipeline stages timeline CustomPainter - the four big stages
//      (build, layout, paint, composite) with the WidgetsBinding/render
//      objects responsible for each.
//   4. Dirty-bit propagation CustomPainter - markNeedsLayout,
//      markNeedsPaint, markNeedsCompositingBitsUpdate, walking up the
//      render tree to the nearest relayout boundary or repaint boundary.
//   5. RepaintBoundary effect side-by-side - two miniature trees showing
//      the same widget content, one without and one with a RepaintBoundary
//      between the heavy painter and the rest of the tree.
//   6. ContainerLayer composition example - a node-graph drawing of a
//      ContainerLayer holding an OffsetLayer, a ClipRRectLayer, and an
//      OpacityLayer wrapping a PictureLayer, with a side legend listing
//      the corresponding render objects.
//   7. Layer surface area table - the fields each Layer subclass exposes
//      to the SceneBuilder, grouped by role (clip/effect/leaf).
//   8. Code recipes - six idiomatic snippets you reach for again and
//      again when working with the rendering pipeline (RepaintBoundary,
//      OffsetLayer.toImage, RenderAnnotatedRegion, markNeedsPaint, etc.).
//   9. Pitfalls panel - six callouts (forgetting markNeedsPaint after
//      mutating render-object state, repaint boundary thrashing, opacity
//      vs ColorFilter cost, BackdropFilter as a compositing boundary,
//      LeaderLayer/FollowerLayer lifecycle, PlatformViewLayer ordering).
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, no async, no Tween.animate(...).value reads, no
// `for (final x in someBridgedInstance)` over a Flutter API instance.
// We construct no live PipelineOwner because there is no second build pass
// and we cannot safely drive markNeedsLayout/markNeedsPaint at runtime in
// the sandbox.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The palette borrows from a "violet-on-porcelain" mood since the layer tree
// sits between the framework (cool blue) and the engine (warm violet).
const Color _kCanvas = Color(0xFFF5F4FA);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFFAF9FE);
const Color _kCardDark = Color(0xFF1B1A2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1A25);
const Color _kInkSecondary = Color(0xFF45455A);
const Color _kInkTertiary = Color(0xFF8A8AA0);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A5BA);
const Color _kAccent = Color(0xFF7C3AED); // violet
const Color _kAccentSoft = Color(0xFFF1ECFE);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentIndigo = Color(0xFF4F46E5);
const Color _kAccentPink = Color(0xFFEC4899);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
// Helpers are top-level private functions returning Widgets so the file
// reads top-to-bottom: helpers, then sections, then build().

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (int i = 0; i < items.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 6.0, right: 10.0),
                child: SizedBox(
                  width: 6.0,
                  height: 6.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _kAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Expanded(child: Text(items[i], style: _kBodyStyle)),
            ],
          ),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E1B4B), Color(0xFF6D28D9), Color(0xFFDB2777)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331E1B4B),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/rendering.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'layer.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Layer Tree & Pipeline',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'The bridge between Flutter\'s render objects and dart:ui Scene. '
          'Layers, RepaintBoundary, dirty bits, PipelineOwner - all in one '
          'static gallery.',
          style: TextStyle(
            color: Color(0xFFE0E1F4),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _pill('Layer', colour: const Color(0xFFFDE68A)),
            const SizedBox(width: 8.0),
            _pill('ContainerLayer', colour: const Color(0xFF93C5FD)),
            const SizedBox(width: 8.0),
            _pill('RepaintBoundary', colour: const Color(0xFFA7F3D0)),
            const SizedBox(width: 8.0),
            _pill('PipelineOwner', colour: const Color(0xFFFBCFE8)),
          ],
        ),
      ],
    ),
  );
}

Widget _heroIntroCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'What is the layer tree?',
          subtitle:
              'A parallel tree to the render tree. Every render object that '
              'is a repaint boundary owns one or more layers; the rest paint '
              'into the closest ancestor layer. dart:ui consumes the layer '
              'tree to build a Scene.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Three trees, four stages. The widget tree is configuration, '
            'the element tree is identity, and the render tree is geometry '
            '+ paint. Below the render tree sits the layer tree, which is '
            'what the engine actually rasterises into the GPU\'s back '
            'buffer.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _bulletList(const <String>[
              'Layer is a Listenable with a parent pointer.',
              'ContainerLayer can hold a doubly-linked list of children.',
              'OffsetLayer is the only layer that exposes toImage.',
              'PictureLayer holds a recorded ui.Picture leaf.',
            ])),
            const SizedBox(width: 12.0),
            Expanded(child: _bulletList(const <String>[
              'PipelineOwner drives flushLayout/Paint/Composite.',
              'WidgetsBinding.drawFrame stitches the stages together.',
              'RepaintBoundary forces an OffsetLayer carve-out.',
              'AnnotatedRegionLayer<T> attaches hit-test annotations.',
            ])),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - LAYER CLASS HIERARCHY CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _LayerHierarchyPainter extends CustomPainter {
  const _LayerHierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);
    final Paint accent = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _kAccent;
    final Paint dashed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFF94A3B8);

    final List<_LayerBox> boxes = const <_LayerBox>[
      _LayerBox('Layer (abstract)', Rect.fromLTWH(20, 12, 200, 36),
          Color(0xFFE0E7FF)),
      _LayerBox('ContainerLayer', Rect.fromLTWH(20, 78, 200, 36),
          Color(0xFFC7D2FE)),
      _LayerBox('OffsetLayer', Rect.fromLTWH(20, 144, 200, 36),
          Color(0xFFBFDBFE)),
      // Composition-effect layers (children of OffsetLayer/ContainerLayer)
      _LayerBox('TransformLayer', Rect.fromLTWH(260, 60, 180, 32),
          Color(0xFFFDE68A)),
      _LayerBox('ClipRectLayer', Rect.fromLTWH(260, 100, 180, 32),
          Color(0xFFFDE68A)),
      _LayerBox('ClipRRectLayer', Rect.fromLTWH(260, 140, 180, 32),
          Color(0xFFFDE68A)),
      _LayerBox('ClipPathLayer', Rect.fromLTWH(260, 180, 180, 32),
          Color(0xFFFDE68A)),
      _LayerBox('OpacityLayer', Rect.fromLTWH(460, 60, 180, 32),
          Color(0xFFFCA5A5)),
      _LayerBox('ColorFilterLayer', Rect.fromLTWH(460, 100, 180, 32),
          Color(0xFFFCA5A5)),
      _LayerBox('ImageFilterLayer', Rect.fromLTWH(460, 140, 180, 32),
          Color(0xFFFCA5A5)),
      _LayerBox('BackdropFilterLayer', Rect.fromLTWH(460, 180, 180, 32),
          Color(0xFFFCA5A5)),
      _LayerBox('ShaderMaskLayer', Rect.fromLTWH(460, 220, 180, 32),
          Color(0xFFFCA5A5)),
      // Leader/Follower for CompositedTransformFollower.
      _LayerBox('LeaderLayer', Rect.fromLTWH(260, 220, 180, 32),
          Color(0xFFA7F3D0)),
      _LayerBox('FollowerLayer', Rect.fromLTWH(260, 260, 180, 32),
          Color(0xFFA7F3D0)),
      // Annotation layer (hit-test only).
      _LayerBox('AnnotatedRegionLayer<T>',
          Rect.fromLTWH(460, 260, 200, 32), Color(0xFFE9D5FF)),
      // Leaf layers - do NOT extend ContainerLayer.
      _LayerBox('PictureLayer', Rect.fromLTWH(20, 240, 200, 36),
          Color(0xFFFBCFE8)),
      _LayerBox('TextureLayer', Rect.fromLTWH(20, 290, 200, 36),
          Color(0xFFFBCFE8)),
      _LayerBox('PlatformViewLayer', Rect.fromLTWH(20, 340, 200, 36),
          Color(0xFFFBCFE8)),
      _LayerBox('PerformanceOverlayLayer',
          Rect.fromLTWH(20, 390, 220, 36), Color(0xFFFBCFE8)),
    ];

    for (int i = 0; i < boxes.length; i++) {
      final _LayerBox b = boxes[i];
      final RRect rrect = RRect.fromRectAndRadius(
        b.rect,
        const Radius.circular(8.0),
      );
      canvas.drawRRect(rrect, Paint()..color = b.fill);
      canvas.drawRRect(rrect, borderPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 8.0);
      tp.paint(
        canvas,
        Offset(
          b.rect.left + (b.rect.width - tp.width) / 2,
          b.rect.top + (b.rect.height - tp.height) / 2,
        ),
      );
    }

    // arrow helper
    void arrow(Offset a, Offset b, {Paint? paint}) {
      final Paint p = paint ?? accent;
      canvas.drawLine(a, b, p);
      final double angle = math.atan2(b.dy - a.dy, b.dx - a.dx);
      const double tipLen = 7.0;
      final Path path = Path()
        ..moveTo(b.dx, b.dy)
        ..lineTo(b.dx - tipLen * math.cos(angle - math.pi / 7),
            b.dy - tipLen * math.sin(angle - math.pi / 7))
        ..lineTo(b.dx - tipLen * math.cos(angle + math.pi / 7),
            b.dy - tipLen * math.sin(angle + math.pi / 7))
        ..close();
      canvas.drawPath(path, Paint()..color = p.color);
    }

    // Inheritance arrows along left spine.
    arrow(const Offset(120, 48), const Offset(120, 78));
    arrow(const Offset(120, 114), const Offset(120, 144));
    // Leaves directly under Layer.
    arrow(const Offset(120, 180), const Offset(120, 240), paint: dashed);
    arrow(const Offset(120, 276), const Offset(120, 290), paint: dashed);
    arrow(const Offset(120, 326), const Offset(120, 340), paint: dashed);
    arrow(const Offset(120, 376), const Offset(120, 390), paint: dashed);
    // From ContainerLayer to effect layers.
    arrow(const Offset(220, 96), const Offset(260, 76));
    arrow(const Offset(220, 110), const Offset(260, 116));
    arrow(const Offset(220, 110), const Offset(260, 156));
    arrow(const Offset(220, 110), const Offset(260, 196));
    arrow(const Offset(220, 110), const Offset(260, 236));
    arrow(const Offset(220, 110), const Offset(260, 276));
    // From OffsetLayer to filter-style layers (descend further).
    arrow(const Offset(220, 162), const Offset(460, 76));
    arrow(const Offset(220, 162), const Offset(460, 116));
    arrow(const Offset(220, 162), const Offset(460, 156));
    arrow(const Offset(220, 162), const Offset(460, 196));
    arrow(const Offset(220, 162), const Offset(460, 236));
    arrow(const Offset(220, 162), const Offset(460, 276));

    final TextPainter legend = TextPainter(
      text: const TextSpan(
        text:
            'Solid = direct inheritance        Dashed = leaf layers (no children)',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legend.paint(canvas, const Offset(20, 440));
  }

  @override
  bool shouldRepaint(_LayerHierarchyPainter oldDelegate) => false;
}

class _LayerBox {
  const _LayerBox(this.label, this.rect, this.fill);
  final String label;
  final Rect rect;
  final Color fill;
}

Widget _layerHierarchySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Layer class hierarchy',
          subtitle:
              'All composition effects are sub-classes of ContainerLayer; '
              'PictureLayer, TextureLayer, PlatformViewLayer and '
              'PerformanceOverlayLayer are leaf Layers that hold raster '
              'content.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 470.0,
          child: CustomPaint(
            painter: const _LayerHierarchyPainter(),
            size: const Size(double.infinity, 470.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('OffsetLayer.toImage', colour: _kAccentBlue),
            _pill('AnnotatedRegionLayer<T>', colour: _kAccentTeal),
            _pill('LeaderLayer/FollowerLayer', colour: _kAccentGreen),
            _pill('PictureLayer (leaf)', colour: _kAccentPink),
            _pill('PlatformViewLayer (leaf)', colour: _kAccentAmber),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - PIPELINE STAGES TIMELINE CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _PipelineStagesPainter extends CustomPainter {
  const _PipelineStagesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);

    final List<_PipelineStage> stages = const <_PipelineStage>[
      _PipelineStage(
        title: 'BUILD',
        owner: 'BuildOwner',
        api: 'buildScope / Element.rebuild',
        produces: 'Element & RenderObject tree',
        fill: Color(0xFFFDE68A),
        ring: Color(0xFFF59E0B),
      ),
      _PipelineStage(
        title: 'LAYOUT',
        owner: 'PipelineOwner.flushLayout',
        api: 'RenderObject.layout / performLayout',
        produces: 'sizes & positions (relayout boundaries)',
        fill: Color(0xFFBFDBFE),
        ring: Color(0xFF2563EB),
      ),
      _PipelineStage(
        title: 'PAINT',
        owner: 'PipelineOwner.flushPaint',
        api: 'RenderObject.paint / PaintingContext',
        produces: 'PictureLayers & composition layers',
        fill: Color(0xFFA7F3D0),
        ring: Color(0xFF14B8A6),
      ),
      _PipelineStage(
        title: 'COMPOSITE',
        owner: 'RenderView.compositeFrame',
        api: 'Layer.buildScene / SceneBuilder',
        produces: 'ui.Scene -> window.render(scene)',
        fill: Color(0xFFFBCFE8),
        ring: Color(0xFFEC4899),
      ),
    ];

    const double rowH = 96.0;
    const double pad = 14.0;
    const double startY = 16.0;
    final double cardW = size.width - 40.0;

    for (int i = 0; i < stages.length; i++) {
      final _PipelineStage s = stages[i];
      final Rect r = Rect.fromLTWH(20, startY + i * rowH, cardW, rowH - 14);
      final RRect rrect =
          RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(rrect, Paint()..color = s.fill.withOpacity(0.35));
      canvas.drawRRect(rrect, border);

      // Big numeric badge on the left.
      final Rect badge =
          Rect.fromLTWH(r.left + pad, r.top + pad, 44, r.height - pad * 2);
      canvas.drawRRect(
        RRect.fromRectAndRadius(badge, const Radius.circular(8.0)),
        Paint()..color = s.ring,
      );
      final TextPainter num = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      num.paint(
        canvas,
        Offset(badge.left + (badge.width - num.width) / 2,
            badge.top + (badge.height - num.height) / 2),
      );

      // Title.
      final TextPainter title = TextPainter(
        text: TextSpan(
          text: s.title,
          style: const TextStyle(
            color: _kInk,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      title.paint(canvas, Offset(badge.right + 14, r.top + pad - 2));

      // Owner + api lines.
      final TextPainter owner = TextPainter(
        text: TextSpan(
          text: 'owner:  ${s.owner}',
          style: const TextStyle(
            color: _kInkSecondary,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      owner.paint(canvas, Offset(badge.right + 14, r.top + pad + 22));

      final TextPainter api = TextPainter(
        text: TextSpan(
          text: 'api:    ${s.api}',
          style: const TextStyle(
            color: _kInkSecondary,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      api.paint(canvas, Offset(badge.right + 14, r.top + pad + 40));

      final TextPainter prod = TextPainter(
        text: TextSpan(
          text: 'output: ${s.produces}',
          style: const TextStyle(
            color: _kInk,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      prod.paint(canvas, Offset(badge.right + 14, r.top + pad + 58));

      // Arrow down to next stage.
      if (i < stages.length - 1) {
        final Paint arrowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..color = s.ring;
        canvas.drawLine(
          Offset(r.left + 42, r.bottom),
          Offset(r.left + 42, r.bottom + 12),
          arrowPaint,
        );
        final Path tip = Path()
          ..moveTo(r.left + 42, r.bottom + 14)
          ..lineTo(r.left + 36, r.bottom + 6)
          ..lineTo(r.left + 48, r.bottom + 6)
          ..close();
        canvas.drawPath(tip, Paint()..color = s.ring);
      }
    }
  }

  @override
  bool shouldRepaint(_PipelineStagesPainter oldDelegate) => false;
}

class _PipelineStage {
  const _PipelineStage({
    required this.title,
    required this.owner,
    required this.api,
    required this.produces,
    required this.fill,
    required this.ring,
  });
  final String title;
  final String owner;
  final String api;
  final String produces;
  final Color fill;
  final Color ring;
}

Widget _pipelineStagesSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'The four pipeline stages',
          subtitle:
              'WidgetsBinding.drawFrame walks BUILD -> LAYOUT -> PAINT -> '
              'COMPOSITE. Each stage has an owner and a well-defined output.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 400.0,
          child: CustomPaint(
            painter: const _PipelineStagesPainter(),
            size: const Size(double.infinity, 400.0),
          ),
        ),
        const SizedBox(height: 6.0),
        _bulletList(const <String>[
          'BUILD is driven by BuildOwner.buildScope and only touches dirty Elements.',
          'LAYOUT is bounded by relayout boundaries (parentUsesSize == false).',
          'PAINT is bounded by repaint boundaries (isRepaintBoundary == true).',
          'COMPOSITE walks the layer tree once and asks dart:ui to build a Scene.',
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - DIRTY-BIT PROPAGATION CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _DirtyBitsPainter extends CustomPainter {
  const _DirtyBitsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);

    // Render-tree spine.
    final List<_TreeNode> nodes = const <_TreeNode>[
      _TreeNode('RenderView', Rect.fromLTWH(40, 12, 170, 34),
          Color(0xFFE0E7FF), false),
      _TreeNode('RenderRepaintBoundary', Rect.fromLTWH(40, 70, 230, 34),
          Color(0xFFA7F3D0), true),
      _TreeNode('RenderPositionedBox', Rect.fromLTWH(40, 128, 200, 34),
          Color(0xFFFEF3C7), false),
      _TreeNode('RenderConstrainedBox', Rect.fromLTWH(40, 186, 210, 34),
          Color(0xFFFEF3C7), false),
      _TreeNode('RenderFlex (Column)', Rect.fromLTWH(40, 244, 200, 34),
          Color(0xFFFEF3C7), false),
      _TreeNode('RenderParagraph  <- markNeedsLayout',
          Rect.fromLTWH(40, 302, 320, 34), Color(0xFFFCA5A5), false),
    ];

    for (int i = 0; i < nodes.length; i++) {
      final _TreeNode n = nodes[i];
      final RRect rrect =
          RRect.fromRectAndRadius(n.rect, const Radius.circular(8.0));
      canvas.drawRRect(rrect, Paint()..color = n.fill);
      canvas.drawRRect(rrect, border);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: n.rect.width - 10.0);
      tp.paint(
          canvas,
          Offset(n.rect.left + 8,
              n.rect.top + (n.rect.height - tp.height) / 2));
      if (n.isBoundary) {
        final TextPainter badge = TextPainter(
          text: const TextSpan(
            text: 'RB',
            style: TextStyle(
              color: Color(0xFF065F46),
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(n.rect.right - 28, n.rect.top + 6, 22, 18),
            const Radius.circular(4.0),
          ),
          Paint()..color = const Color(0xFFA7F3D0),
        );
        badge.paint(canvas, Offset(n.rect.right - 25, n.rect.top + 8));
      }
    }

    // Upward arrow chain (propagation).
    final Paint up = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = _kAccentRose;
    void upArrow(double y) {
      canvas.drawLine(Offset(380, y), Offset(380, y - 30), up);
      final Path tip = Path()
        ..moveTo(380, y - 34)
        ..lineTo(374, y - 26)
        ..lineTo(386, y - 26)
        ..close();
      canvas.drawPath(tip, Paint()..color = _kAccentRose);
    }

    upArrow(330);
    upArrow(272);
    upArrow(214);
    upArrow(156);
    upArrow(98);

    final TextPainter chainLabel = TextPainter(
      text: const TextSpan(
        text:
            'markNeedsLayout() walks parent->parent until parentUsesSize=false\n'
            'or until the boundary is reached -> sloppy layout schedule.',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 12.0,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 260);
    chainLabel.paint(canvas, const Offset(420, 220));

    final TextPainter pillLabel = TextPainter(
      text: const TextSpan(
        text:
            'markNeedsPaint() walks parent->parent until isRepaintBoundary\n'
            'and only that ancestor is added to nodesNeedingPaint.',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 12.0,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 260);
    pillLabel.paint(canvas, const Offset(420, 110));

    final TextPainter cbLabel = TextPainter(
      text: const TextSpan(
        text:
            'markNeedsCompositingBitsUpdate() bubbles needsCompositing flag\n'
            'until the next compositing boundary; only then can a child\n'
            'layer be added without affecting the rest of the tree.',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 12.0,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 260);
    cbLabel.paint(canvas, const Offset(420, 24));
  }

  @override
  bool shouldRepaint(_DirtyBitsPainter oldDelegate) => false;
}

class _TreeNode {
  const _TreeNode(this.label, this.rect, this.fill, this.isBoundary);
  final String label;
  final Rect rect;
  final Color fill;
  final bool isBoundary;
}

Widget _dirtyBitsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Dirty bit propagation',
          subtitle:
              'Three independent dirty bits ride up the render tree until '
              'they hit the relevant boundary. The PipelineOwner only knows '
              'about the nodes that are listed as dirty at their boundary.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 360.0,
          child: CustomPaint(
            painter: const _DirtyBitsPainter(),
            size: const Size(double.infinity, 360.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('markNeedsLayout', colour: _kAccentBlue),
            _pill('markNeedsPaint', colour: _kAccentRose),
            _pill('markNeedsCompositingBitsUpdate', colour: _kAccentIndigo),
            _pill('markNeedsSemanticsUpdate', colour: _kAccentTeal),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - REPAINTBOUNDARY SIDE-BY-SIDE
// ---------------------------------------------------------------------------
class _RepaintBoundaryEffectPainter extends CustomPainter {
  const _RepaintBoundaryEffectPainter({required this.withBoundary});

  final bool withBoundary;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);

    // Render side (top).
    final List<_TreeNode> renderSide = <_TreeNode>[
      const _TreeNode('RenderView', Rect.fromLTWH(20, 10, 140, 26),
          Color(0xFFE0E7FF), false),
      const _TreeNode('RenderPositionedBox', Rect.fromLTWH(20, 46, 180, 26),
          Color(0xFFFEF3C7), false),
      const _TreeNode('RenderFlex (Column)', Rect.fromLTWH(20, 82, 180, 26),
          Color(0xFFFEF3C7), false),
      _TreeNode(
        withBoundary ? 'RenderRepaintBoundary' : 'RenderConstrainedBox',
        const Rect.fromLTWH(20, 118, 200, 26),
        withBoundary ? const Color(0xFFA7F3D0) : const Color(0xFFFEF3C7),
        withBoundary,
      ),
      const _TreeNode('CustomPainter (heavy)', Rect.fromLTWH(20, 154, 200, 26),
          Color(0xFFFCA5A5), false),
    ];
    for (int i = 0; i < renderSide.length; i++) {
      final _TreeNode n = renderSide[i];
      final RRect rrect =
          RRect.fromRectAndRadius(n.rect, const Radius.circular(6.0));
      canvas.drawRRect(rrect, Paint()..color = n.fill);
      canvas.drawRRect(rrect, border);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: n.rect.width - 8.0);
      tp.paint(
          canvas,
          Offset(n.rect.left + 6,
              n.rect.top + (n.rect.height - tp.height) / 2));
    }

    // Layer side (bottom).
    final List<_LayerBox> layerSide = withBoundary
        ? const <_LayerBox>[
            _LayerBox('TransformLayer (root)',
                Rect.fromLTWH(20, 220, 200, 26), Color(0xFFBFDBFE)),
            _LayerBox('OffsetLayer (RB)', Rect.fromLTWH(20, 256, 200, 26),
                Color(0xFFA7F3D0)),
            _LayerBox('PictureLayer (heavy)',
                Rect.fromLTWH(20, 292, 200, 26), Color(0xFFFBCFE8)),
            _LayerBox('PictureLayer (everything else)',
                Rect.fromLTWH(20, 328, 240, 26), Color(0xFFFBCFE8)),
          ]
        : const <_LayerBox>[
            _LayerBox('TransformLayer (root)',
                Rect.fromLTWH(20, 220, 200, 26), Color(0xFFBFDBFE)),
            _LayerBox('PictureLayer (single, the whole tree)',
                Rect.fromLTWH(20, 256, 280, 26), Color(0xFFFCA5A5)),
          ];
    for (int i = 0; i < layerSide.length; i++) {
      final _LayerBox b = layerSide[i];
      final RRect rrect =
          RRect.fromRectAndRadius(b.rect, const Radius.circular(6.0));
      canvas.drawRRect(rrect, Paint()..color = b.fill);
      canvas.drawRRect(rrect, border);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 8.0);
      tp.paint(
          canvas,
          Offset(b.rect.left + 6,
              b.rect.top + (b.rect.height - tp.height) / 2));
    }

    // Section labels.
    final TextPainter rt = TextPainter(
      text: const TextSpan(
        text: 'render tree',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rt.paint(canvas, const Offset(20, 0));

    final TextPainter lt = TextPainter(
      text: const TextSpan(
        text: 'layer tree',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    lt.paint(canvas, const Offset(20, 200));

    // Verdict.
    final String verdict = withBoundary
        ? 'Heavy paint isolated in its own OffsetLayer\n'
            '-> repaint cost = heavy painter only.'
        : 'Heavy paint sits in the same PictureLayer\n'
            'as the entire tree -> any sibling repaint cost.';
    final TextPainter v = TextPainter(
      text: TextSpan(
        text: verdict,
        style: TextStyle(
          color: withBoundary ? _kAccentGreen : _kAccentRose,
          fontSize: 11.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 280);
    v.paint(canvas, Offset(20, withBoundary ? 365 : 295));
  }

  @override
  bool shouldRepaint(_RepaintBoundaryEffectPainter oldDelegate) =>
      oldDelegate.withBoundary != withBoundary;
}

Widget _repaintBoundarySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'RepaintBoundary effect',
          subtitle:
              'Same render tree, two layer trees. The left half has no '
              'RepaintBoundary, the right half adds one above the heavy '
              'painter.',
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('without RepaintBoundary', colour: _kAccentRose),
                  const SizedBox(height: 6.0),
                  SizedBox(
                    height: 410.0,
                    child: CustomPaint(
                      painter: const _RepaintBoundaryEffectPainter(
                          withBoundary: false),
                      size: const Size(double.infinity, 410.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('with RepaintBoundary', colour: _kAccentGreen),
                  const SizedBox(height: 6.0),
                  SizedBox(
                    height: 410.0,
                    child: CustomPaint(
                      painter: const _RepaintBoundaryEffectPainter(
                          withBoundary: true),
                      size: const Size(double.infinity, 410.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bulletList(const <String>[
          'A RepaintBoundary inserts a RenderRepaintBoundary into the render tree.',
          'Its layer is an OffsetLayer, which short-circuits the repaint walk.',
          'OffsetLayer is the only Layer whose toImage() captures the subtree.',
          'Use sparingly: each boundary doubles the number of leaf PictureLayers.',
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - CONTAINERLAYER COMPOSITION EXAMPLE
// ---------------------------------------------------------------------------
class _CompositionGraphPainter extends CustomPainter {
  const _CompositionGraphPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);
    final Paint accent = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _kAccent;

    final List<_LayerBox> nodes = const <_LayerBox>[
      _LayerBox('TransformLayer (RenderView)',
          Rect.fromLTWH(160, 12, 260, 34), Color(0xFFE0E7FF)),
      _LayerBox('OffsetLayer (RB)', Rect.fromLTWH(180, 70, 220, 32),
          Color(0xFFA7F3D0)),
      _LayerBox('ClipRRectLayer', Rect.fromLTWH(40, 130, 160, 32),
          Color(0xFFFDE68A)),
      _LayerBox('OpacityLayer (alpha=200)',
          Rect.fromLTWH(220, 130, 200, 32), Color(0xFFFCA5A5)),
      _LayerBox('TransformLayer (scale)',
          Rect.fromLTWH(440, 130, 180, 32), Color(0xFFFDE68A)),
      _LayerBox('PictureLayer (rounded image)',
          Rect.fromLTWH(20, 190, 200, 32), Color(0xFFFBCFE8)),
      _LayerBox('PictureLayer (badge text)',
          Rect.fromLTWH(240, 190, 200, 32), Color(0xFFFBCFE8)),
      _LayerBox('PictureLayer (sparkle)',
          Rect.fromLTWH(460, 190, 180, 32), Color(0xFFFBCFE8)),
    ];

    for (int i = 0; i < nodes.length; i++) {
      final _LayerBox b = nodes[i];
      final RRect rrect =
          RRect.fromRectAndRadius(b.rect, const Radius.circular(8.0));
      canvas.drawRRect(rrect, Paint()..color = b.fill);
      canvas.drawRRect(rrect, border);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 8.0);
      tp.paint(
        canvas,
        Offset(
          b.rect.left + (b.rect.width - tp.width) / 2,
          b.rect.top + (b.rect.height - tp.height) / 2,
        ),
      );
    }

    void edge(Offset a, Offset b) {
      canvas.drawLine(a, b, accent);
    }

    edge(const Offset(290, 46), const Offset(290, 70));
    edge(const Offset(290, 102), const Offset(120, 130));
    edge(const Offset(290, 102), const Offset(320, 130));
    edge(const Offset(290, 102), const Offset(530, 130));
    edge(const Offset(120, 162), const Offset(120, 190));
    edge(const Offset(320, 162), const Offset(340, 190));
    edge(const Offset(530, 162), const Offset(550, 190));

    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text:
            'edges = parent-child links in the layer tree\n'
            '(SceneBuilder pushes one transform/clip/opacity per ContainerLayer)',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 11.0,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    caption.paint(canvas, const Offset(20, 240));
  }

  @override
  bool shouldRepaint(_CompositionGraphPainter oldDelegate) => false;
}

Widget _compositionGraphSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ContainerLayer composition',
          subtitle:
              'A typical "rounded avatar with badge" subtree: clip rect, '
              'opacity, transform, and three picture leaves under one '
              'RepaintBoundary.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 290.0,
          child: CustomPaint(
            painter: const _CompositionGraphPainter(),
            size: const Size(double.infinity, 290.0),
          ),
        ),
        const SizedBox(height: 6.0),
        _kvRow('OffsetLayer.offset', 'parent-relative origin (used by RB)'),
        _kvRow('ClipRRectLayer.clipRRect', 'scene-space rounded rectangle'),
        _kvRow('OpacityLayer.alpha', '0..255 - implemented via SaveLayer'),
        _kvRow('TransformLayer.transform',
            '4x4 Matrix4 multiplied into the scene'),
        _kvRow('PictureLayer.picture',
            'ui.Picture recorded by PaintingContext.canvas'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - LAYER PROPERTY TABLE
// ---------------------------------------------------------------------------
Widget _layerFieldRow(
  String name,
  String extendsClass,
  String keyField,
  String role,
  Color tint,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint.withOpacity(0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Text(name, style: _kMonoInlineStyle),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            extendsClass,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            keyField,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            role,
            style: const TextStyle(
              fontSize: 12.0,
              color: _kInk,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _layerTableSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Layer surface area',
          subtitle:
              'The fields the SceneBuilder actually reads when it walks a '
              'ContainerLayer. Anything else is bookkeeping.',
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            SizedBox(
              width: 180.0,
              child: Text(
                'class',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 150.0,
              child: Text(
                'extends',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 220.0,
              child: Text(
                'key field',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'role',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        _layerFieldRow('ContainerLayer', 'Layer', 'firstChild / lastChild',
            'Owns a doubly-linked list of child layers and dispatches addToScene.',
            _kAccentBlue),
        _layerFieldRow('OffsetLayer', 'ContainerLayer', 'Offset offset',
            'Adds a translation; only layer that exposes toImage().',
            _kAccentBlue),
        _layerFieldRow('TransformLayer', 'OffsetLayer', 'Matrix4 transform',
            'Multiplies a 4x4 transform into the scene before drawing.',
            _kAccentAmber),
        _layerFieldRow('ClipRectLayer', 'ContainerLayer', 'Rect clipRect',
            'Hard/anti-aliased clip; sceneBuilder.pushClipRect.', _kAccentAmber),
        _layerFieldRow('ClipRRectLayer', 'ContainerLayer', 'RRect clipRRect',
            'Rounded-rectangle clip via sceneBuilder.pushClipRRect.',
            _kAccentAmber),
        _layerFieldRow('ClipPathLayer', 'ContainerLayer', 'Path clipPath',
            'Arbitrary path clip; the most expensive of the three.',
            _kAccentAmber),
        _layerFieldRow('OpacityLayer', 'ContainerLayer', 'int alpha (0..255)',
            'Performs an offscreen saveLayer; expensive for large subtrees.',
            _kAccentRose),
        _layerFieldRow('ColorFilterLayer', 'ContainerLayer',
            'ColorFilter colorFilter',
            'Single-pixel filter applied as a saveLayer.', _kAccentRose),
        _layerFieldRow('ImageFilterLayer', 'ContainerLayer',
            'ImageFilter imageFilter',
            'Convolution/blur applied to the child output.', _kAccentRose),
        _layerFieldRow('BackdropFilterLayer', 'ContainerLayer',
            'ImageFilter filter',
            'Reads BEHIND the layer first; forces a compositing boundary.',
            _kAccentRose),
        _layerFieldRow('ShaderMaskLayer', 'ContainerLayer', 'Shader shader',
            'Multiplies child output by a shader (used for gradient masks).',
            _kAccentRose),
        _layerFieldRow('LeaderLayer', 'ContainerLayer', 'LayerLink link',
            'Publishes scene-space transform so FollowerLayer can read it.',
            _kAccentGreen),
        _layerFieldRow('FollowerLayer', 'ContainerLayer', 'LayerLink link',
            'Re-applies leader transform; basis for CompositedTransformFollower.',
            _kAccentGreen),
        _layerFieldRow('AnnotatedRegionLayer<T>', 'ContainerLayer',
            'T value, Size? size',
            'Adds a hit-test annotation; powers SystemUiOverlayStyle, etc.',
            _kAccentTeal),
        _layerFieldRow('PictureLayer', 'Layer', 'ui.Picture picture',
            'Leaf layer holding the bytecode of canvas calls.', _kAccentPink),
        _layerFieldRow('TextureLayer', 'Layer', 'int textureId',
            'Leaf layer that displays an engine-owned texture.', _kAccentPink),
        _layerFieldRow('PlatformViewLayer', 'Layer', 'int viewId',
            'Embeds a native UIView/View into the scene.', _kAccentPink),
        _layerFieldRow('PerformanceOverlayLayer', 'Layer', 'int optionsMask',
            'Renders the engine\'s performance overlay HUD.', _kAccentPink),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - CODE RECIPES
// ---------------------------------------------------------------------------
Widget _codeRecipesSection() {
  return Column(
    children: <Widget>[
      _codeBlock(
        '// 1. RepaintBoundary around a custom painter that animates.\n'
        'RepaintBoundary(\n'
        '  child: CustomPaint(\n'
        '    painter: const _SparklePainter(),\n'
        '    size: const Size(200, 200),\n'
        '  ),\n'
        ')',
        title: 'recipe_repaint_boundary.dart',
      ),
      _codeBlock(
        '// 2. Capturing a subtree as an image via OffsetLayer.toImage.\n'
        'final RenderRepaintBoundary boundary = key.currentContext!\n'
        '    .findRenderObject()! as RenderRepaintBoundary;\n'
        'final ui.Image image = await boundary.toImage(pixelRatio: 2.0);\n'
        '// boundary.layer is an OffsetLayer; its toImage drives this call.',
        title: 'recipe_screenshot.dart',
      ),
      _codeBlock(
        '// 3. RenderAnnotatedRegion: attach data to a subtree for hit tests.\n'
        'AnnotatedRegion<SystemUiOverlayStyle>(\n'
        '  value: SystemUiOverlayStyle.dark,\n'
        '  child: SafeArea(child: child),\n'
        ')\n'
        '// Under the hood: AnnotatedRegionLayer<SystemUiOverlayStyle>.',
        title: 'recipe_annotated_region.dart',
      ),
      _codeBlock(
        '// 4. Custom RenderBox that triggers paint without re-laying out.\n'
        'class _BlinkRenderBox extends RenderBox {\n'
        '  void setEnabled(bool value) {\n'
        '    if (_enabled == value) return;\n'
        '    _enabled = value;\n'
        '    markNeedsPaint(); // not markNeedsLayout: size is unchanged.\n'
        '  }\n'
        '  bool _enabled = false;\n'
        '}',
        title: 'recipe_mark_needs_paint.dart',
      ),
      _codeBlock(
        '// 5. Driving the pipeline manually for tests.\n'
        'final PipelineOwner owner = PipelineOwner();\n'
        'owner.rootNode = renderView;\n'
        'renderView.scheduleInitialLayout();\n'
        'owner.flushLayout();\n'
        'owner.flushCompositingBits();\n'
        'owner.flushPaint();\n'
        '// then renderView.compositeFrame() to push the Scene.',
        title: 'recipe_pipeline_owner.dart',
      ),
      _codeBlock(
        '// 6. Adding a compositing bit when introducing a new layer type.\n'
        '@override\n'
        'bool get alwaysNeedsCompositing => true; // forces own layer\n'
        '\n'
        '@override\n'
        'void paint(PaintingContext context, Offset offset) {\n'
        '  context.pushLayer(_GlowLayer(strength: _strength), super.paint, offset);\n'
        '}',
        title: 'recipe_custom_layer.dart',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - PITFALLS PANEL
// ---------------------------------------------------------------------------
Widget _pitfall(String tag, String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(body, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls and gotchas',
          subtitle:
              'Six rendering-pipeline traps that bite teams shipping their '
              'first non-trivial CustomPainter or RenderObject.',
        ),
        const SizedBox(height: 6.0),
        _pitfall(
            'P1',
            'Forgetting markNeedsPaint after mutating render-object state.',
            'A new field on a RenderBox that affects paint() but not '
                'layout() still requires markNeedsPaint - otherwise the '
                'PipelineOwner reuses the cached PictureLayer.',
            _kAccentRose),
        _pitfall(
            'P2',
            'Putting too many RepaintBoundaries on hot subtrees.',
            'Each boundary materialises an OffsetLayer + at least one '
                'PictureLayer, doubling the per-frame leaf count. Reach for '
                'debugRepaintRainbowEnabled to spot churn.',
            _kAccentAmber),
        _pitfall(
            'P3',
            'Treating Opacity as a free wrapper.',
            'OpacityLayer triggers a saveLayer in the engine. For static '
                'tints prefer ColorFiltered or withOpacity on a Paint.',
            _kAccentBlue),
        _pitfall(
            'P4',
            'BackdropFilter without a compositing boundary above it.',
            'BackdropFilterLayer needs to read the back buffer; the engine '
                'will introduce an implicit boundary, which can sneak in '
                'unexpected raster cost.',
            _kAccentIndigo),
        _pitfall(
            'P5',
            'LeaderLayer / FollowerLayer lifecycle mismatch.',
            'A LayerLink that is detached during paint silently drops '
                'updates. Always rebuild the link in didUpdateWidget and '
                'mark the follower dirty when the link changes.',
            _kAccentTeal),
        _pitfall(
            'P6',
            'PlatformViewLayer ordering.',
            'On iOS, hybrid composition places native views above Flutter '
                'layers. Putting a Flutter ColorFilterLayer above will not '
                'tint the platform view - that has to happen on the native '
                'side.',
            _kAccentPink),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _chipGroup(String title, List<String> chips, Color colour) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: colour,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (int i = 0; i < chips.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: colour.withOpacity(0.35)),
                ),
                child: Text(
                  chips[i],
                  style: TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: colour,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Cheat-sheet',
            subtitle: 'A compact map of the rendering subsystem.'),
        const SizedBox(height: 10.0),
        _chipGroup('container layers', const <String>[
          'ContainerLayer',
          'OffsetLayer',
          'TransformLayer',
          'ClipRectLayer',
          'ClipRRectLayer',
          'ClipPathLayer',
          'OpacityLayer',
          'ColorFilterLayer',
          'ImageFilterLayer',
          'BackdropFilterLayer',
          'ShaderMaskLayer',
          'LeaderLayer',
          'FollowerLayer',
          'AnnotatedRegionLayer<T>',
        ], _kAccentBlue),
        _chipGroup('leaf layers', const <String>[
          'PictureLayer',
          'TextureLayer',
          'PlatformViewLayer',
          'PerformanceOverlayLayer',
        ], _kAccentPink),
        _chipGroup('pipeline owners', const <String>[
          'BuildOwner',
          'PipelineOwner',
          'WidgetsBinding.drawFrame',
          'RenderView.compositeFrame',
          'SchedulerBinding.scheduleFrame',
        ], _kAccentAmber),
        _chipGroup('dirty bits', const <String>[
          'markNeedsBuild',
          'markNeedsLayout',
          'markNeedsPaint',
          'markNeedsCompositingBitsUpdate',
          'markNeedsSemanticsUpdate',
        ], _kAccentRose),
        _chipGroup('boundaries', const <String>[
          'RepaintBoundary',
          'RelayoutBoundary (implicit)',
          'isRepaintBoundary',
          'alwaysNeedsCompositing',
        ], _kAccentGreen),
        _chipGroup('rendering APIs', const <String>[
          'PaintingContext.canvas',
          'PaintingContext.pushLayer',
          'PaintingContext.pushClipRect',
          'PaintingContext.pushOpacity',
          'OffsetLayer.toImage',
          'SceneBuilder',
          'ui.Scene',
        ], _kAccentTeal),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. We never construct a
// live PipelineOwner or schedule frames - the demo is a static gallery.
// ===========================================================================
dynamic build(BuildContext context) {
  print('RenderLayers pipeline deep visual demo: building widget tree');
  // Inspect an inert ContainerLayer for diagnostic purposes only. We do not
  // attach it to a PipelineOwner; it remains a detached, empty root.
  final ContainerLayer demoLayer = ContainerLayer();
  print('demoLayer.attached=${demoLayer.attached}');
  print('demoLayer.runtimeType=${demoLayer.runtimeType}');
  print('demoLayer.parent=${demoLayer.parent}');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(1, 'Why the layer tree exists',
              'A parallel tree that maps render objects to dart:ui Scene.'),
          _heroIntroCard(),
          _sectionDivider(),
          _sectionHeader(2, 'Layer class hierarchy',
              'From Layer to PictureLayer, with every effect in between.'),
          _layerHierarchySection(),
          _sectionDivider(),
          _sectionHeader(3, 'Pipeline stages',
              'BUILD -> LAYOUT -> PAINT -> COMPOSITE, four owners.'),
          _pipelineStagesSection(),
          _sectionDivider(),
          _sectionHeader(4, 'Dirty-bit propagation',
              'markNeedsLayout / markNeedsPaint / markNeedsCompositingBitsUpdate.'),
          _dirtyBitsSection(),
          _sectionDivider(),
          _sectionHeader(5, 'RepaintBoundary effect',
              'Same render tree, two layer trees - measured by leaf count.'),
          _repaintBoundarySection(),
          _sectionDivider(),
          _sectionHeader(6, 'ContainerLayer composition',
              'A rounded-avatar subtree drawn as a layer graph.'),
          _compositionGraphSection(),
          _sectionDivider(),
          _sectionHeader(7, 'Layer surface area',
              'The fields the SceneBuilder actually reads.'),
          _layerTableSection(),
          _sectionDivider(),
          _sectionHeader(8, 'Code recipes',
              'Six idiomatic snippets you will reach for again and again.'),
          _codeRecipesSection(),
          _sectionDivider(),
          _sectionHeader(9, 'Pitfalls',
              'Six callouts that bite Flutter rendering work.'),
          _pitfallsSection(),
          _sectionDivider(),
          _sectionHeader(10, 'Cheat-sheet',
              'A compact map of the rendering pipeline.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
