// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for MediaQuery, MediaQueryData
// and the TextScaler / DisplayFeature family
//
// This script is intentionally long, opinionated and self-explanatory. It is a
// reference page for the entire MediaQuery surface area: every field of
// MediaQueryData, every static accessor on MediaQuery, the override family
// (MediaQuery.removePadding / removeViewInsets / removeViewPadding), the
// TextScaler API (linear vs noScaling), and the dart:ui DisplayFeature value
// type. Sections are independent visual cards stacked in a final ListView.
//
// Renderer notes:
//   * No StatefulWidget, Ticker, Future, Stream or async usage anywhere.
//   * Nested MediaQuery scopes are demonstrated via MediaQuery(data:..., child:..)
//     rather than mutating ambient state.
//   * CustomPaint is used for the inset diagrams; no animation controllers.
//   * Loops over indexed integers — no for-in over bridged Flutter collections.
//   * Tween usage uses .transform(t) — not .animate(Animation).value.

import 'dart:ui' show DisplayFeature, DisplayFeatureType, DisplayFeatureState;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------

const Color _kBgCard = Color(0xFFFAFAFA);
const Color _kBgPage = Color(0xFFEFEFEF);
const Color _kBorder = Color(0xFFCFCFCF);
const Color _kBorderStrong = Color(0xFF8E8E8E);
const Color _kAccent = Color(0xFF1565C0);
const Color _kAccentSoft = Color(0xFFBBDEFB);
const Color _kWarn = Color(0xFFE65100);
const Color _kWarnSoft = Color(0xFFFFCC80);
const Color _kOk = Color(0xFF2E7D32);
const Color _kOkSoft = Color(0xFFC8E6C9);
const Color _kInk = Color(0xFF212121);
const Color _kInkSoft = Color(0xFF616161);
const Color _kPaper = Color(0xFFFFFFFF);
const Color _kPadColor = Color(0xFFF06292);
const Color _kViewInsetColor = Color(0xFF9575CD);
const Color _kViewPaddingColor = Color(0xFF4DB6AC);
const Color _kGestureColor = Color(0xFFFFB74D);

const TextStyle _kH1 = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: _kInk,
);

const TextStyle _kH2 = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: _kInk,
);

const TextStyle _kH3 = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
  color: _kInk,
);

const TextStyle _kBody = TextStyle(fontSize: 13.0, color: _kInk);

const TextStyle _kMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.0,
  color: _kInk,
);

const TextStyle _kMonoSmall = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.0,
  color: _kInkSoft,
);

const TextStyle _kCaption = TextStyle(fontSize: 11.0, color: _kInkSoft);

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _chip(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: fg.withOpacity(0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11.0, color: fg, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _kv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170.0,
          child: Text(key, style: _kMonoSmall),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: valueColor ?? _kInk,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionCard({
  required String title,
  required String subtitle,
  required Widget child,
  Color accent = _kAccent,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: _kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            border: Border(
              left: BorderSide(color: accent, width: 4.0),
              bottom: BorderSide(color: _kBorder),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _kH2),
              const SizedBox(height: 4.0),
              Text(subtitle, style: _kCaption),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: child,
        ),
      ],
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.only(right: 12.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: color.withOpacity(0.7)),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(label, style: _kCaption),
      ],
    ),
  );
}

Widget _noteBox(String text, {Color color = _kAccent}) {
  return Container(
    margin: const EdgeInsets.only(top: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      border: Border.all(color: color.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 16.0, color: color),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter — viewport / padding / viewInsets / viewPadding diagram
// ---------------------------------------------------------------------------

class _InsetDiagramPainter extends CustomPainter {
  _InsetDiagramPainter({
    required this.size,
    required this.padding,
    required this.viewInsets,
    required this.viewPadding,
    required this.systemGestureInsets,
  });

  final Size size;
  final EdgeInsets padding;
  final EdgeInsets viewInsets;
  final EdgeInsets viewPadding;
  final EdgeInsets systemGestureInsets;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // Scale logical size into available canvas while preserving aspect.
    final double sw = size.width <= 0.0 ? 1.0 : size.width;
    final double sh = size.height <= 0.0 ? 1.0 : size.height;
    final double scale = (canvasSize.width / sw < canvasSize.height / sh)
        ? canvasSize.width / sw
        : canvasSize.height / sh;
    final double drawW = sw * scale;
    final double drawH = sh * scale;
    final double dx = (canvasSize.width - drawW) / 2.0;
    final double dy = (canvasSize.height - drawH) / 2.0;
    final Rect viewport = Rect.fromLTWH(dx, dy, drawW, drawH);

    // Background paper
    final paper = Paint()..color = _kPaper;
    canvas.drawRect(viewport, paper);

    // viewPadding (drawn as a translucent ring around the inner area)
    final vp = Paint()..color = _kViewPaddingColor.withOpacity(0.25);
    _drawInsetRing(canvas, viewport, viewPadding, scale, vp);

    // padding (slightly thicker, drawn over viewPadding)
    final pad = Paint()..color = _kPadColor.withOpacity(0.35);
    _drawInsetRing(canvas, viewport, padding, scale, pad);

    // viewInsets (e.g. keyboard) — usually only one side
    final vi = Paint()..color = _kViewInsetColor.withOpacity(0.55);
    _drawInsetRing(canvas, viewport, viewInsets, scale, vi);

    // systemGestureInsets — drawn as outlined regions only (no fill) to avoid
    // obscuring the other layers.
    final gestPaint = Paint()
      ..color = _kGestureColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    _drawInsetRing(canvas, viewport, systemGestureInsets, scale, gestPaint,
        strokeOnly: true);

    // Viewport border on top
    final border = Paint()
      ..color = _kBorderStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(viewport, border);

    // Center label
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${sw.toStringAsFixed(0)} x ${sh.toStringAsFixed(0)}',
        style: const TextStyle(
          fontSize: 12.0,
          color: _kInk,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        viewport.center.dx - textPainter.width / 2.0,
        viewport.center.dy - textPainter.height / 2.0,
      ),
    );
  }

  void _drawInsetRing(
    Canvas canvas,
    Rect viewport,
    EdgeInsets insets,
    double scale,
    Paint paint, {
    bool strokeOnly = false,
  }) {
    final double l = insets.left * scale;
    final double t = insets.top * scale;
    final double r = insets.right * scale;
    final double b = insets.bottom * scale;
    if (l > 0.0) {
      final rect = Rect.fromLTWH(viewport.left, viewport.top, l, viewport.height);
      canvas.drawRect(rect, paint);
    }
    if (t > 0.0) {
      final rect = Rect.fromLTWH(viewport.left, viewport.top, viewport.width, t);
      canvas.drawRect(rect, paint);
    }
    if (r > 0.0) {
      final rect = Rect.fromLTWH(
        viewport.right - r,
        viewport.top,
        r,
        viewport.height,
      );
      canvas.drawRect(rect, paint);
    }
    if (b > 0.0) {
      final rect = Rect.fromLTWH(
        viewport.left,
        viewport.bottom - b,
        viewport.width,
        b,
      );
      canvas.drawRect(rect, paint);
    }
    if (strokeOnly) {
      // Already drawn as filled rectangles using stroke paint; nothing more.
    }
  }

  @override
  bool shouldRepaint(covariant _InsetDiagramPainter old) {
    return old.size != size ||
        old.padding != padding ||
        old.viewInsets != viewInsets ||
        old.viewPadding != viewPadding ||
        old.systemGestureInsets != systemGestureInsets;
  }
}

// ---------------------------------------------------------------------------
// CustomPainter — display feature visualization
// ---------------------------------------------------------------------------

class _DisplayFeaturePainter extends CustomPainter {
  _DisplayFeaturePainter({
    required this.size,
    required this.features,
  });

  final Size size;
  final List<DisplayFeature> features;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final double sw = size.width <= 0.0 ? 1.0 : size.width;
    final double sh = size.height <= 0.0 ? 1.0 : size.height;
    final double scale = (canvasSize.width / sw < canvasSize.height / sh)
        ? canvasSize.width / sw
        : canvasSize.height / sh;
    final double drawW = sw * scale;
    final double drawH = sh * scale;
    final double dx = (canvasSize.width - drawW) / 2.0;
    final double dy = (canvasSize.height - drawH) / 2.0;
    final Rect viewport = Rect.fromLTWH(dx, dy, drawW, drawH);

    canvas.drawRect(viewport, Paint()..color = _kPaper);

    final foldPaint = Paint()..color = _kAccent.withOpacity(0.65);
    final hingePaint = Paint()..color = _kWarn.withOpacity(0.65);
    final cutoutPaint = Paint()..color = _kInk.withOpacity(0.75);

    for (int i = 0; i < features.length; i++) {
      final f = features[i];
      final Rect r = Rect.fromLTRB(
        viewport.left + f.bounds.left * scale,
        viewport.top + f.bounds.top * scale,
        viewport.left + f.bounds.right * scale,
        viewport.top + f.bounds.bottom * scale,
      );
      Paint p;
      if (f.type == DisplayFeatureType.fold) {
        p = foldPaint;
      } else if (f.type == DisplayFeatureType.hinge) {
        p = hingePaint;
      } else {
        p = cutoutPaint;
      }
      canvas.drawRect(r, p);

      final label = TextPainter(
        text: TextSpan(
          text: _featureLabel(f),
          style: const TextStyle(
            fontSize: 10.0,
            color: _kPaper,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      label.layout(maxWidth: r.width + 80.0);
      final Offset labelOffset = Offset(
        r.center.dx - label.width / 2.0,
        r.center.dy - label.height / 2.0,
      );
      label.paint(canvas, labelOffset);
    }

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _kBorderStrong;
    canvas.drawRect(viewport, border);
  }

  String _featureLabel(DisplayFeature f) {
    String t;
    if (f.type == DisplayFeatureType.fold) {
      t = 'FOLD';
    } else if (f.type == DisplayFeatureType.hinge) {
      t = 'HINGE';
    } else {
      t = 'CUTOUT';
    }
    String s;
    if (f.state == DisplayFeatureState.postureFlat) {
      s = 'flat';
    } else if (f.state == DisplayFeatureState.postureHalfOpened) {
      s = 'half';
    } else {
      s = 'n/a';
    }
    return '$t/$s';
  }

  @override
  bool shouldRepaint(covariant _DisplayFeaturePainter old) {
    return old.size != size || old.features.length != features.length;
  }
}

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== MediaQuery deep demo — begin ===');

  // -------------------------------------------------------------------------
  // Live ambient MediaQueryData. We snapshot it once at build() so all
  // sub-sections reference a consistent view.
  // -------------------------------------------------------------------------
  final MediaQueryData live = MediaQuery.of(context);
  final MediaQueryData? maybeLive = MediaQuery.maybeOf(context);
  final Size liveSize = MediaQuery.sizeOf(context);

  print('live.size                : ${live.size}');
  print('live.devicePixelRatio    : ${live.devicePixelRatio}');
  print('live.textScaler          : ${live.textScaler}');
  print('live.padding             : ${live.padding}');
  print('live.viewInsets          : ${live.viewInsets}');
  print('live.viewPadding         : ${live.viewPadding}');
  print('live.systemGestureInsets : ${live.systemGestureInsets}');
  print('live.platformBrightness  : ${live.platformBrightness}');
  print('live.accessibleNavigation: ${live.accessibleNavigation}');
  print('live.invertColors        : ${live.invertColors}');
  print('live.highContrast        : ${live.highContrast}');
  print('live.disableAnimations   : ${live.disableAnimations}');
  print('live.boldText            : ${live.boldText}');
  print('live.navigationMode      : ${live.navigationMode}');
  print('live.gestureSettings     : ${live.gestureSettings}');
  print('live.displayFeatures n=  : ${live.displayFeatures.length}');
  print('maybeOf == null ?        : ${maybeLive == null}');
  print('sizeOf == live.size ?    : ${liveSize == live.size}');

  // =========================================================================
  // SECTION 1 — Live ambient dump card
  // =========================================================================

  print('-- section 1: live ambient dump');

  final Widget liveDumpCard = _sectionCard(
    title: '1. Live ambient MediaQueryData',
    subtitle:
        'A direct dump of the values returned by MediaQuery.of(context) at '
        'the moment this script ran. Refresh the host to re-evaluate.',
    accent: _kAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kv('size', '${live.size}'),
        _kv('size.width', live.size.width.toStringAsFixed(2)),
        _kv('size.height', live.size.height.toStringAsFixed(2)),
        _kv('size.aspectRatio',
            (live.size.width / (live.size.height == 0.0 ? 1.0 : live.size.height))
                .toStringAsFixed(3)),
        _kv('devicePixelRatio', live.devicePixelRatio.toStringAsFixed(3)),
        _kv('textScaler', '${live.textScaler}'),
        _kv('platformBrightness', live.platformBrightness.toString()),
        _kv('padding', live.padding.toString()),
        _kv('viewInsets', live.viewInsets.toString()),
        _kv('viewPadding', live.viewPadding.toString()),
        _kv('systemGestureInsets', live.systemGestureInsets.toString()),
        _kv('accessibleNavigation',
            live.accessibleNavigation ? 'true' : 'false',
            valueColor: live.accessibleNavigation ? _kWarn : _kOk),
        _kv('invertColors', live.invertColors ? 'true' : 'false',
            valueColor: live.invertColors ? _kWarn : _kOk),
        _kv('highContrast', live.highContrast ? 'true' : 'false',
            valueColor: live.highContrast ? _kWarn : _kOk),
        _kv('disableAnimations',
            live.disableAnimations ? 'true' : 'false',
            valueColor: live.disableAnimations ? _kWarn : _kOk),
        _kv('boldText', live.boldText ? 'true' : 'false',
            valueColor: live.boldText ? _kWarn : _kOk),
        _kv('navigationMode', live.navigationMode.toString()),
        _kv('gestureSettings.touchSlop',
            (live.gestureSettings.touchSlop ?? 0.0).toStringAsFixed(2)),
        _kv('displayFeatures.length', '${live.displayFeatures.length}'),
        _noteBox(
          'MediaQuery.of(context) subscribes the caller to ALL field changes. '
          'When you only need one aspect, prefer MediaQuery.sizeOf, '
          'MediaQuery.paddingOf, MediaQuery.platformBrightnessOf, etc. — '
          'they rebuild only when that aspect changes.',
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 — Granular accessors gallery
  // =========================================================================

  print('-- section 2: granular accessor gallery');

  final List<Map<String, dynamic>> accessorRows = <Map<String, dynamic>>[
    {
      'name': 'MediaQuery.sizeOf',
      'value': '${MediaQuery.sizeOf(context)}',
      'note': 'Subscribes only to size changes.',
    },
    {
      'name': 'MediaQuery.maybeSizeOf',
      'value': '${MediaQuery.maybeSizeOf(context)}',
      'note': 'Same as sizeOf but returns null if no ancestor.',
    },
    {
      'name': 'MediaQuery.devicePixelRatioOf',
      'value': MediaQuery.devicePixelRatioOf(context).toStringAsFixed(3),
      'note': 'For asset / image resolution selection.',
    },
    {
      'name': 'MediaQuery.textScalerOf',
      'value': '${MediaQuery.textScalerOf(context)}',
      'note': 'Modern non-linear text scaler (replaces textScaleFactorOf).',
    },
    {
      'name': 'MediaQuery.platformBrightnessOf',
      'value': '${MediaQuery.platformBrightnessOf(context)}',
      'note': 'Light or dark — controls ThemeMode.system resolution.',
    },
    {
      'name': 'MediaQuery.paddingOf',
      'value': '${MediaQuery.paddingOf(context)}',
      'note': 'Notch / status bar / home indicator persistent insets.',
    },
    {
      'name': 'MediaQuery.viewInsetsOf',
      'value': '${MediaQuery.viewInsetsOf(context)}',
      'note': 'Transient insets (soft keyboard).',
    },
    {
      'name': 'MediaQuery.viewPaddingOf',
      'value': '${MediaQuery.viewPaddingOf(context)}',
      'note': 'OS overlay padding ignoring transient insets.',
    },
    {
      'name': 'MediaQuery.systemGestureInsetsOf',
      'value': '${MediaQuery.systemGestureInsetsOf(context)}',
      'note': 'Where the OS may steal gestures (back swipe, etc.).',
    },
    {
      'name': 'MediaQuery.accessibleNavigationOf',
      'value': MediaQuery.accessibleNavigationOf(context).toString(),
      'note': 'True when a screen reader / a11y tool is active.',
    },
    {
      'name': 'MediaQuery.invertColorsOf',
      'value': MediaQuery.invertColorsOf(context).toString(),
      'note': 'OS-level color inversion flag.',
    },
    {
      'name': 'MediaQuery.highContrastOf',
      'value': MediaQuery.highContrastOf(context).toString(),
      'note': 'OS preference for high-contrast UI.',
    },
    {
      'name': 'MediaQuery.disableAnimationsOf',
      'value': MediaQuery.disableAnimationsOf(context).toString(),
      'note': 'Reduce motion accessibility preference.',
    },
    {
      'name': 'MediaQuery.boldTextOf',
      'value': MediaQuery.boldTextOf(context).toString(),
      'note': 'User wants stronger weight for legibility.',
    },
    {
      'name': 'MediaQuery.navigationModeOf',
      'value': MediaQuery.navigationModeOf(context).toString(),
      'note': 'Pointer vs directional (TV/remote) navigation.',
    },
  ];

  final List<Widget> accessorTiles = <Widget>[];
  for (int i = 0; i < accessorRows.length; i++) {
    final row = accessorRows[i];
    accessorTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kPaper,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: _kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    row['name'] as String,
                    style: _kMono.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _kAccent,
                    ),
                  ),
                ),
                _chip('#$i', _kAccentSoft, _kAccent),
              ],
            ),
            const SizedBox(height: 4.0),
            Text('-> ${row['value']}', style: _kMono),
            const SizedBox(height: 4.0),
            Text(row['note'] as String, style: _kCaption),
          ],
        ),
      ),
    );
  }

  final Widget accessorCard = _sectionCard(
    title: '2. Granular MediaQuery accessors',
    subtitle:
        'Each .xxxOf(context) static reads exactly one field. Prefer these '
        'over MediaQuery.of(context) inside leaf widgets to limit rebuilds.',
    accent: _kOk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: accessorTiles,
    ),
  );

  // =========================================================================
  // SECTION 3 — Padding / viewInsets / viewPadding diagram
  // =========================================================================

  print('-- section 3: inset diagram');

  // We deliberately fabricate a richer MediaQueryData here so the diagram is
  // visually interesting even on hosts that report zero insets. The override
  // is applied via MediaQuery(data: ..., child: ...) below, not by mutating
  // ambient state.
  final MediaQueryData syntheticForDiagram = live.copyWith(
    size: const Size(390.0, 844.0),
    padding: const EdgeInsets.fromLTRB(0.0, 47.0, 0.0, 34.0),
    viewPadding: const EdgeInsets.fromLTRB(0.0, 47.0, 0.0, 34.0),
    viewInsets: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 291.0), // keyboard
    systemGestureInsets: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    devicePixelRatio: 3.0,
  );

  final Widget insetDiagram = SizedBox(
    height: 320.0,
    child: CustomPaint(
      painter: _InsetDiagramPainter(
        size: syntheticForDiagram.size,
        padding: syntheticForDiagram.padding,
        viewInsets: syntheticForDiagram.viewInsets,
        viewPadding: syntheticForDiagram.viewPadding,
        systemGestureInsets: syntheticForDiagram.systemGestureInsets,
      ),
      child: Container(),
    ),
  );

  final Widget insetCard = _sectionCard(
    title: '3. padding / viewInsets / viewPadding diagram',
    subtitle:
        'Filled bands represent the three EdgeInsets layers. The orange outline '
        'shows where the system may consume gestures.',
    accent: _kWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          children: [
            _legendDot(_kPadColor, 'padding (notch / home bar)'),
            _legendDot(_kViewInsetColor, 'viewInsets (keyboard)'),
            _legendDot(_kViewPaddingColor, 'viewPadding (overlay)'),
            _legendDot(_kGestureColor, 'systemGestureInsets'),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kBorder),
            color: _kBgPage,
          ),
          child: insetDiagram,
        ),
        const SizedBox(height: 8.0),
        _kv('size', '${syntheticForDiagram.size}'),
        _kv('padding', '${syntheticForDiagram.padding}'),
        _kv('viewInsets', '${syntheticForDiagram.viewInsets}'),
        _kv('viewPadding', '${syntheticForDiagram.viewPadding}'),
        _kv('systemGestureInsets', '${syntheticForDiagram.systemGestureInsets}'),
        _noteBox(
          'When the soft keyboard opens, viewInsets grows on the bottom while '
          'padding stays the same. viewPadding is the union of both: physical '
          'OS padding regardless of transient intrusions.',
          color: _kWarn,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 4 — MediaQuery override scopes via MediaQuery(data: ..., child: ...)
  // =========================================================================

  print('-- section 4: override scope demonstrations');

  // Helper widget rendered inside each override scope, which reads its own
  // ambient MediaQuery and reports it. We use a Builder so the closure sees
  // the new context.
  Widget overrideProbe(String label, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.10),
        border: Border.all(color: accent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Builder(
        builder: (BuildContext scoped) {
          final MediaQueryData inner = MediaQuery.of(scoped);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: _kH3.copyWith(color: accent, fontSize: 13.0)),
              const SizedBox(height: 4.0),
              Text('padding     -> ${inner.padding}', style: _kMonoSmall),
              Text('viewInsets  -> ${inner.viewInsets}', style: _kMonoSmall),
              Text('viewPadding -> ${inner.viewPadding}', style: _kMonoSmall),
              Text('textScaler  -> ${inner.textScaler}', style: _kMonoSmall),
              Text('boldText    -> ${inner.boldText}', style: _kMonoSmall),
            ],
          );
        },
      ),
    );
  }

  // Build the override stack as a single nested MediaQuery widget. The probes
  // sit at the same level so each can demonstrate one variant.
  final Widget overrideStack = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Baseline — no override
      overrideProbe('Baseline (ambient)', _kAccent),

      // Custom MediaQueryData
      MediaQuery(
        data: live.copyWith(
          padding: const EdgeInsets.all(24.0),
          viewInsets: const EdgeInsets.only(bottom: 200.0),
          viewPadding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
          boldText: true,
        ),
        child: overrideProbe(
          'MediaQuery(data: copyWith(...))',
          _kWarn,
        ),
      ),

      // removePadding (top + bottom)
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: overrideProbe(
          'MediaQuery.removePadding(removeTop, removeBottom)',
          _kOk,
        ),
      ),

      // removeViewInsets (bottom)
      MediaQuery.removeViewInsets(
        context: context,
        removeBottom: true,
        child: overrideProbe(
          'MediaQuery.removeViewInsets(removeBottom: true)',
          _kAccent,
        ),
      ),

      // removeViewPadding (all sides)
      MediaQuery.removeViewPadding(
        context: context,
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        child: overrideProbe(
          'MediaQuery.removeViewPadding(all)',
          _kWarn,
        ),
      ),
    ],
  );

  final Widget overrideCard = _sectionCard(
    title: '4. MediaQuery override scopes',
    subtitle:
        'Each box is a Builder under a different MediaQuery scope. Read its '
        'reported insets to see how the override mutates the inherited data '
        'for descendants only.',
    accent: _kAccent,
    child: overrideStack,
  );

  // =========================================================================
  // SECTION 5 — TextScaler comparison gallery (linear vs noScaling)
  // =========================================================================

  print('-- section 5: textScaler gallery');

  final List<double> scalerFactors = <double>[0.85, 1.00, 1.15, 1.30, 1.60, 2.00];
  final List<Widget> scalerTiles = <Widget>[];

  // noScaling reference tile
  scalerTiles.add(
    MediaQuery(
      data: live.copyWith(textScaler: TextScaler.noScaling),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kPaper,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: _kBorderStrong, width: 1.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _chip('TextScaler.noScaling', _kInk, _kPaper),
                const SizedBox(width: 8.0),
                Text('reference — ignores user setting',
                    style: _kCaption),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text('The quick brown fox jumps over the lazy dog.',
                style: TextStyle(fontSize: 14.0, color: _kInk)),
          ],
        ),
      ),
    ),
  );

  // Linear scaler tiles
  for (int i = 0; i < scalerFactors.length; i++) {
    final double f = scalerFactors[i];
    final TextScaler scaler = TextScaler.linear(f);
    final String scaledExample = scaler.scale(14.0).toStringAsFixed(2);
    scalerTiles.add(
      MediaQuery(
        data: live.copyWith(textScaler: scaler),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _chip(
                    'TextScaler.linear(${f.toStringAsFixed(2)})',
                    _kAccentSoft,
                    _kAccent,
                  ),
                  const SizedBox(width: 8.0),
                  Text('14pt -> $scaledExample logical px',
                      style: _kCaption),
                ],
              ),
              const SizedBox(height: 6.0),
              const Text(
                'The quick brown fox jumps over the lazy dog.',
                style: TextStyle(fontSize: 14.0, color: _kInk),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget scalerCard = _sectionCard(
    title: '5. TextScaler gallery — linear vs noScaling',
    subtitle:
        'Each tile wraps a Text in MediaQuery with a different TextScaler. '
        'noScaling is the identity; linear(f) multiplies font size by f.',
    accent: _kOk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: scalerTiles,
    ),
  );

  // =========================================================================
  // SECTION 6 — Accessibility flag reference matrix
  // =========================================================================

  print('-- section 6: a11y flag matrix');

  final List<Map<String, dynamic>> a11yRows = <Map<String, dynamic>>[
    {
      'flag': 'accessibleNavigation',
      'value': live.accessibleNavigation,
      'meaning':
          'A screen reader or similar accessibility service is active. Use '
          'it to enable semantic labels and avoid hover-only affordances.',
    },
    {
      'flag': 'invertColors',
      'value': live.invertColors,
      'meaning':
          'OS inversion is enabled. Provide images that survive inversion or '
          'render solid backgrounds for photos.',
    },
    {
      'flag': 'highContrast',
      'value': live.highContrast,
      'meaning':
          'Prefer higher contrast palettes. Bump foreground / background '
          'distance and remove translucency.',
    },
    {
      'flag': 'disableAnimations',
      'value': live.disableAnimations,
      'meaning':
          'Reduce motion. Replace large transitions with cross-fades or '
          'instant cuts.',
    },
    {
      'flag': 'boldText',
      'value': live.boldText,
      'meaning':
          'User wants stronger font weights for legibility. Mirror by raising '
          'the default FontWeight everywhere.',
    },
  ];

  final List<Widget> a11yTiles = <Widget>[];
  for (int i = 0; i < a11yRows.length; i++) {
    final r = a11yRows[i];
    final bool v = r['value'] as bool;
    a11yTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: v ? _kWarnSoft.withOpacity(0.4) : _kOkSoft.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: v ? _kWarn : _kOk),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    r['flag'] as String,
                    style: _kMono.copyWith(
                      fontWeight: FontWeight.w700,
                      color: v ? _kWarn : _kOk,
                    ),
                  ),
                ),
                _chip(v ? 'ACTIVE' : 'off',
                    v ? _kWarn : _kOk, _kPaper),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(r['meaning'] as String, style: _kBody),
          ],
        ),
      ),
    );
  }

  final Widget a11yCard = _sectionCard(
    title: '6. Accessibility flag matrix',
    subtitle:
        'Five bool fields on MediaQueryData reflect OS-level a11y preferences. '
        'A green tile means OFF, an orange tile means ACTIVE — adapt accordingly.',
    accent: _kWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: a11yTiles,
    ),
  );

  // =========================================================================
  // SECTION 7 — platformBrightness + DisplayFeature visualization
  // =========================================================================

  print('-- section 7: platformBrightness + displayFeatures');

  // Synthesize two display features so the painter has something to draw on
  // hosts without folds/cutouts.
  final List<DisplayFeature> syntheticFeatures = <DisplayFeature>[
    const DisplayFeature(
      bounds: Rect.fromLTRB(170.0, 0.0, 220.0, 30.0),
      type: DisplayFeatureType.cutout,
      state: DisplayFeatureState.unknown,
    ),
    const DisplayFeature(
      bounds: Rect.fromLTRB(0.0, 410.0, 390.0, 434.0),
      type: DisplayFeatureType.fold,
      state: DisplayFeatureState.postureFlat,
    ),
  ];

  final Widget featurePaint = SizedBox(
    height: 280.0,
    child: CustomPaint(
      painter: _DisplayFeaturePainter(
        size: const Size(390.0, 844.0),
        features: syntheticFeatures,
      ),
      child: Container(),
    ),
  );

  // Two side-by-side brightness swatches showing how a light-mode and a
  // dark-mode descendant should look. We use Theme.of(context) defensively
  // even though we render bare swatches.
  Widget brightnessSwatch(Brightness b) {
    final bool isDark = b == Brightness.dark;
    final Color bg = isDark ? const Color(0xFF121212) : _kPaper;
    final Color fg = isDark ? _kPaper : _kInk;
    return Expanded(
      child: MediaQuery(
        data: live.copyWith(platformBrightness: b),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kBorderStrong),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDark ? 'Brightness.dark' : 'Brightness.light',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fg,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Headline preview',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Body text resolved against the override scope. Real apps '
                'usually flow this through ThemeData rather than reading '
                'platformBrightness directly.',
                style: TextStyle(fontSize: 12.0, color: fg, height: 1.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget brightnessRow = Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      brightnessSwatch(Brightness.light),
      brightnessSwatch(Brightness.dark),
    ],
  );

  final List<Widget> featureLegendChildren = <Widget>[];
  for (int i = 0; i < syntheticFeatures.length; i++) {
    final DisplayFeature f = syntheticFeatures[i];
    String t;
    if (f.type == DisplayFeatureType.fold) {
      t = 'fold';
    } else if (f.type == DisplayFeatureType.hinge) {
      t = 'hinge';
    } else {
      t = 'cutout';
    }
    String s;
    if (f.state == DisplayFeatureState.postureFlat) {
      s = 'postureFlat';
    } else if (f.state == DisplayFeatureState.postureHalfOpened) {
      s = 'postureHalfOpened';
    } else {
      s = 'unknown';
    }
    featureLegendChildren.add(
      Text(
        '#$i  type=$t  state=$s  bounds=${f.bounds}',
        style: _kMonoSmall,
      ),
    );
  }

  final Widget brightnessCard = _sectionCard(
    title: '7. platformBrightness + DisplayFeature',
    subtitle:
        'Light/dark swatches via MediaQuery override, plus a synthetic '
        'DisplayFeature layout for a foldable.',
    accent: _kAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        brightnessRow,
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            _legendDot(_kAccent, 'DisplayFeatureType.fold'),
            _legendDot(_kWarn, 'DisplayFeatureType.hinge'),
            _legendDot(_kInk, 'DisplayFeatureType.cutout'),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kBorder),
            color: _kBgPage,
          ),
          child: featurePaint,
        ),
        const SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: featureLegendChildren,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 8 — copyWith and Tween-based interpolation reference
  // =========================================================================

  print('-- section 8: copyWith + tween demo');

  // Demonstrate a Tween used the d4rt-friendly way: .transform(t) rather than
  // animate(...).value. We sample five stops and render a row of cards whose
  // padding interpolates between two MediaQueryData values.
  final EdgeInsetsTween paddingTween = EdgeInsetsTween(
    begin: const EdgeInsets.all(8.0),
    end: const EdgeInsets.all(40.0),
  );

  final List<double> tweenStops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Widget> tweenChildren = <Widget>[];

  for (int i = 0; i < tweenStops.length; i++) {
    final double t = tweenStops[i];
    final EdgeInsets interpolated = paddingTween.transform(t);
    final MediaQueryData stepData = live.copyWith(
      padding: interpolated,
      viewPadding: interpolated,
    );
    tweenChildren.add(
      Expanded(
        child: MediaQuery(
          data: stepData,
          child: Builder(
            builder: (BuildContext scoped) {
              final EdgeInsets readBack = MediaQuery.paddingOf(scoped);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration: BoxDecoration(
                  color: _kPaper,
                  border: Border.all(color: _kBorder),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: const BoxDecoration(
                        color: _kAccentSoft,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                      ),
                      child: Text(
                        't=${t.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: _kMono,
                      ),
                    ),
                    Padding(
                      padding: readBack,
                      child: Container(
                        height: 30.0,
                        color: _kAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        readBack.toString(),
                        style: _kMonoSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final Widget tweenCard = _sectionCard(
    title: '8. copyWith + Tween.transform(t)',
    subtitle:
        'EdgeInsetsTween.transform samples five stops between begin and end. '
        'Each tile uses MediaQuery(data: copyWith(padding: ...)) so the inner '
        'Builder reads the freshly interpolated value.',
    accent: _kOk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: tweenChildren,
        ),
        _noteBox(
          'Inside d4rt prefer Tween(...).transform(t) over '
          'Tween(...).animate(controller).value — the latter needs an '
          'AnimationController which is not allowed in this corpus.',
          color: _kOk,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 — MediaQuery.removePadding / removeViewInsets / removeViewPadding
  //              recipe playbook
  // =========================================================================

  print('-- section 9: remove* recipe playbook');

  final List<Map<String, String>> recipes = <Map<String, String>>[
    {
      'title': 'Nested ListView inside SafeArea',
      'code':
          'SafeArea(\n  child: MediaQuery.removePadding(\n    context: context,\n    removeTop: true,\n    child: ListView(...)\n  ),\n)',
      'why':
          'SafeArea already consumed the top padding. Without removePadding '
          'the ListView would add it again at the top of its content.',
    },
    {
      'title': 'Bottom sheet over a keyboard',
      'code':
          'MediaQuery.removeViewInsets(\n  context: context,\n  removeBottom: true,\n  child: bottomSheetBody,\n)',
      'why':
          'The bottom sheet host already shifts to dodge the keyboard. The '
          'body inside should not also offset by viewInsets.bottom.',
    },
    {
      'title': 'Dialog inside a Drawer-like surface',
      'code':
          'MediaQuery.removeViewPadding(\n  context: context,\n  removeLeft: true,\n  removeRight: true,\n  child: dialogContent,\n)',
      'why':
          'When a surface paints its own background to the screen edges, '
          'descendants should not double-count viewPadding on those sides.',
    },
    {
      'title': 'Hosting a SliverAppBar twice in a CustomScrollView',
      'code':
          'CustomScrollView(\n  slivers: [\n    SliverAppBar(...),\n    SliverToBoxAdapter(\n      child: MediaQuery.removePadding(\n        context: context,\n        removeTop: true,\n        child: inner,\n      ),\n    ),\n  ],\n)',
      'why':
          'The SliverAppBar already consumed top padding. Removing it from '
          'the inner subtree prevents extra inset stacking.',
    },
  ];

  final List<Widget> recipeTiles = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final r = recipes[i];
    recipeTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kPaper,
          border: Border.all(color: _kBorder),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _chip('recipe #$i', _kAccentSoft, _kAccent),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(r['title']!, style: _kH3),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _kBgPage,
                border: Border.all(color: _kBorder),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(r['code']!, style: _kMonoSmall),
            ),
            const SizedBox(height: 6.0),
            Text(r['why']!, style: _kBody),
          ],
        ),
      ),
    );
  }

  final Widget recipeCard = _sectionCard(
    title: '9. remove* recipe playbook',
    subtitle:
        'Four cookbook entries for the three MediaQuery override constructors. '
        'Each shows source, when it applies, and why it matters.',
    accent: _kAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: recipeTiles,
    ),
  );

  // =========================================================================
  // SECTION 10 — Quick-reference cheat sheet
  // =========================================================================

  print('-- section 10: cheat sheet');

  final List<Map<String, String>> cheats = <Map<String, String>>[
    {
      'q': 'How do I read screen size without rebuilding on every other change?',
      'a': 'final size = MediaQuery.sizeOf(context);',
    },
    {
      'q': 'How do I detect whether a screen reader is on?',
      'a': 'MediaQuery.accessibleNavigationOf(context) -> bool',
    },
    {
      'q': 'How do I scale font size by the user preference?',
      'a': 'final scaler = MediaQuery.textScalerOf(context); '
          'final px = scaler.scale(14.0);',
    },
    {
      'q': 'How do I temporarily ignore the keyboard inset for a subtree?',
      'a': 'MediaQuery.removeViewInsets(context: context, removeBottom: true, child: ...)',
    },
    {
      'q': 'How do I avoid double-counting safe area padding?',
      'a': 'MediaQuery.removePadding(context: context, removeTop: true, child: ...)',
    },
    {
      'q': 'How do I check whether to reduce motion?',
      'a': 'MediaQuery.disableAnimationsOf(context) -> bool',
    },
    {
      'q': 'How do I query foldable display features?',
      'a': 'MediaQuery.of(context).displayFeatures returns List<DisplayFeature>',
    },
    {
      'q': 'What replaces the deprecated textScaleFactor field?',
      'a': 'textScaler — a TextScaler value (TextScaler.linear(f) or noScaling).',
    },
    {
      'q': 'How do I read MediaQuery without throwing when no ancestor exists?',
      'a': 'MediaQuery.maybeOf(context) — returns MediaQueryData?',
    },
    {
      'q': 'How do I override one field for a subtree only?',
      'a': 'MediaQuery(data: MediaQuery.of(context).copyWith(boldText: true), child: ...)',
    },
  ];

  final List<Widget> cheatTiles = <Widget>[];
  for (int i = 0; i < cheats.length; i++) {
    final c = cheats[i];
    cheatTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kPaper,
          border: Border.all(color: _kBorder),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _chip('Q${i + 1}', _kWarnSoft, _kWarn),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(c['q']!, style: _kH3),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _kBgPage,
                border: Border.all(color: _kBorder),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(c['a']!, style: _kMonoSmall),
            ),
          ],
        ),
      ),
    );
  }

  final Widget cheatCard = _sectionCard(
    title: '10. Cheat sheet',
    subtitle:
        'Quick-reference Q&A for the most common MediaQuery patterns. Pair '
        'this section with the live ambient dump above.',
    accent: _kWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cheatTiles,
    ),
  );

  // =========================================================================
  // SECTION 11 — Footer summary
  // =========================================================================

  print('-- section 11: footer summary');

  final Widget footerCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MediaQuery deep visual demo — summary',
          style: TextStyle(
            color: _kPaper,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Eleven sections rendered. The script reads ${live.size}, has '
          '${live.displayFeatures.length} display features and a '
          'platformBrightness of ${live.platformBrightness}.',
          style: const TextStyle(color: _kPaper, fontSize: 12.0, height: 1.4),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'No StatefulWidget, no async, no AnimationController — pure '
          'declarative MediaQuery & MediaQueryData usage.',
          style: TextStyle(color: _kAccentSoft, fontSize: 11.0),
        ),
      ],
    ),
  );

  print('=== MediaQuery deep demo — assembling page ===');

  // -------------------------------------------------------------------------
  // Assemble the full page. We wrap everything in a Scaffold so the demo can
  // be hosted standalone, but the topmost child is the ListView so the page
  // is scrollable on small viewports.
  // -------------------------------------------------------------------------

  final Widget page = Scaffold(
    backgroundColor: _kBgPage,
    appBar: AppBar(
      backgroundColor: _kAccent,
      foregroundColor: _kPaper,
      title: const Text('MediaQuery deep demo'),
      elevation: 2.0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(14.0),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('MediaQuery & MediaQueryData', style: _kH1),
              const SizedBox(height: 4.0),
              Text(
                'A hand-authored corpus entry exercising every field of '
                'MediaQueryData, all granular .xxxOf(context) accessors, the '
                'three remove* override constructors, TextScaler, and the '
                'DisplayFeature value type.',
                style: _kBody,
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  _chip('11 sections', _kAccentSoft, _kAccent),
                  _chip('every MQ field', _kOkSoft, _kOk),
                  _chip('linear + noScaling', _kWarnSoft, _kWarn),
                  _chip('CustomPaint diagrams', _kAccentSoft, _kAccent),
                ],
              ),
            ],
          ),
        ),
        liveDumpCard,
        accessorCard,
        insetCard,
        overrideCard,
        scalerCard,
        a11yCard,
        brightnessCard,
        tweenCard,
        recipeCard,
        cheatCard,
        footerCard,
      ],
    ),
  );

  print('=== MediaQuery deep demo — end ===');
  return page;
}
