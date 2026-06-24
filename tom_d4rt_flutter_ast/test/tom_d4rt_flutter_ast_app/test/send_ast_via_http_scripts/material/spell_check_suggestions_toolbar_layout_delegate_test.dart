import 'dart:math' as math;

import 'package:flutter/material.dart';

class _AnchorPreset {
  const _AnchorPreset({
    required this.title,
    required this.subtitle,
    required this.anchor,
    required this.viewport,
    required this.accent,
    required this.note,
    required this.keyboardInset,
  });

  final String title;
  final String subtitle;
  final Offset anchor;
  final Size viewport;
  final Color accent;
  final String note;
  final double keyboardInset;
}

class _LabGuide {
  const _LabGuide({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
}

class _LabMetric {
  const _LabMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _LabTimeline {
  const _LabTimeline({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _LabMatrixRow {
  const _LabMatrixRow({
    required this.topic,
    required this.delegateBehavior,
    required this.recommendation,
  });

  final String topic;
  final String delegateBehavior;
  final String recommendation;
}

class _AnchorSnapshot {
  const _AnchorSnapshot({
    required this.id,
    required this.anchor,
    required this.viewport,
    required this.note,
    required this.color,
  });

  final int id;
  final Offset anchor;
  final Size viewport;
  final String note;
  final Color color;
}

class _OverlayPlacementPainter extends CustomPainter {
  _OverlayPlacementPainter({
    required this.anchor,
    required this.viewport,
    required this.accent,
    required this.showGrid,
    required this.showSafeArea,
    required this.keyboardInset,
  });

  final Offset anchor;
  final Size viewport;
  final Color accent;
  final bool showGrid;
  final bool showSafeArea;
  final double keyboardInset;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(14)),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFF8FBFF), Color(0xFFE8F0FF)],
        ).createShader(area),
    );

    final Rect viewportRect = Rect.fromLTWH(16, 16, size.width - 32, size.height - 32);
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewportRect, const Radius.circular(12)),
      Paint()..color = Colors.white.withValues(alpha: 0.78),
    );

    if (showSafeArea) {
      final Rect safeRect = Rect.fromLTWH(
        viewportRect.left + 16,
        viewportRect.top + 12,
        viewportRect.width - 32,
        viewportRect.height - 24,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(safeRect, const Radius.circular(8)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..color = const Color(0xFF90A4C7),
      );
    }

    if (showGrid) {
      const int columns = 8;
      const int rows = 6;
      for (int i = 1; i < columns; i++) {
        final double x = viewportRect.left + viewportRect.width * (i / columns);
        canvas.drawLine(
          Offset(x, viewportRect.top),
          Offset(x, viewportRect.bottom),
          Paint()
            ..color = const Color(0xFFCDD8EA)
            ..strokeWidth = 1,
        );
      }
      for (int i = 1; i < rows; i++) {
        final double y = viewportRect.top + viewportRect.height * (i / rows);
        canvas.drawLine(
          Offset(viewportRect.left, y),
          Offset(viewportRect.right, y),
          Paint()
            ..color = const Color(0xFFCDD8EA)
            ..strokeWidth = 1,
        );
      }
    }

    final double x = viewportRect.left + (anchor.dx / math.max(1, viewport.width)) * viewportRect.width;
    final double y = viewportRect.top + (anchor.dy / math.max(1, viewport.height)) * viewportRect.height;

    if (keyboardInset > 0) {
      final double h = viewportRect.height * (keyboardInset / math.max(1, viewport.height));
      final Rect keyboardRect = Rect.fromLTWH(
        viewportRect.left,
        viewportRect.bottom - h,
        viewportRect.width,
        h,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(keyboardRect, const Radius.circular(8)),
        Paint()..color = const Color(0xFF37474F).withValues(alpha: 0.22),
      );
    }

    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()..color = accent,
    );
    canvas.drawCircle(
      Offset(x, y),
      15,
      Paint()..color = accent.withValues(alpha: 0.18),
    );
    canvas.drawLine(
      Offset(x - 14, y),
      Offset(x + 14, y),
      Paint()
        ..color = accent.withValues(alpha: 0.95)
        ..strokeWidth = 1.3,
    );
    canvas.drawLine(
      Offset(x, y - 14),
      Offset(x, y + 14),
      Paint()
        ..color = accent.withValues(alpha: 0.95)
        ..strokeWidth = 1.3,
    );

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'Anchor (${anchor.dx.toStringAsFixed(1)}, ${anchor.dy.toStringAsFixed(1)})',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF183153),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: viewportRect.width - 8);
    tp.paint(canvas, Offset(viewportRect.left + 4, viewportRect.top + 4));
  }

  @override
  bool shouldRepaint(covariant _OverlayPlacementPainter oldDelegate) {
    return oldDelegate.anchor != anchor ||
        oldDelegate.viewport != viewport ||
        oldDelegate.accent != accent ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showSafeArea != showSafeArea ||
        oldDelegate.keyboardInset != keyboardInset;
  }
}

class _ConstraintHeatmapPainter extends CustomPainter {
  _ConstraintHeatmapPainter({
    required this.anchor,
    required this.viewport,
    required this.accent,
    required this.showSafeArea,
  });

  final Offset anchor;
  final Size viewport;
  final Color accent;
  final bool showSafeArea;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FAFE),
    );

    final Rect chart = Rect.fromLTWH(16, 18, size.width - 32, size.height - 36);

    for (int y = 0; y < 24; y++) {
      for (int x = 0; x < 24; x++) {
        final double dx = x / 23;
        final double dy = y / 23;
        final double ax = anchor.dx / math.max(1, viewport.width);
        final double ay = anchor.dy / math.max(1, viewport.height);
        final double dist = math.sqrt(math.pow(dx - ax, 2) + math.pow(dy - ay, 2));
        final double influence = (1 - dist * 1.7).clamp(0, 1);
        final Rect cell = Rect.fromLTWH(
          chart.left + chart.width * (x / 24),
          chart.top + chart.height * (y / 24),
          chart.width / 24,
          chart.height / 24,
        );
        canvas.drawRect(
          cell,
          Paint()..color = accent.withValues(alpha: 0.07 + influence * 0.56),
        );
      }
    }

    if (showSafeArea) {
      final Rect safe = Rect.fromLTWH(
        chart.left + 12,
        chart.top + 12,
        chart.width - 24,
        chart.height - 24,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(safe, const Radius.circular(8)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = const Color(0xFF7890B1),
      );
    }

    final Offset marker = Offset(
      chart.left + (anchor.dx / math.max(1, viewport.width)) * chart.width,
      chart.top + (anchor.dy / math.max(1, viewport.height)) * chart.height,
    );

    canvas.drawCircle(marker, 7, Paint()..color = const Color(0xFF102A43));
    canvas.drawCircle(
      marker,
      12,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF102A43).withValues(alpha: 0.5),
    );

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'Anchor Influence Heatmap',
        style: TextStyle(
          color: Color(0xFF1C3557),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    title.paint(canvas, const Offset(16, 4));
  }

  @override
  bool shouldRepaint(covariant _ConstraintHeatmapPainter oldDelegate) {
    return oldDelegate.anchor != anchor ||
        oldDelegate.viewport != viewport ||
        oldDelegate.accent != accent ||
        oldDelegate.showSafeArea != showSafeArea;
  }
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();

  final List<_AnchorPreset> presets = <_AnchorPreset>[
    const _AnchorPreset(
      title: 'Middle Paragraph',
      subtitle: 'Typical in-body misspelling inside long editor text.',
      anchor: Offset(180, 260),
      viewport: Size(360, 620),
      accent: Color(0xFF1E88E5),
      note:
          'Balanced case: delegate typically places toolbar above anchor when there is vertical room.',
      keyboardInset: 0,
    ),
    const _AnchorPreset(
      title: 'Top Edge Candidate',
      subtitle: 'Misspelling near app bar and safe area.',
      anchor: Offset(220, 42),
      viewport: Size(390, 700),
      accent: Color(0xFF6A1B9A),
      note:
          'Top edge pushes placement downward because room above anchor is constrained.',
      keyboardInset: 0,
    ),
    const _AnchorPreset(
      title: 'Bottom + Keyboard',
      subtitle: 'Word near footer while software keyboard is visible.',
      anchor: Offset(156, 565),
      viewport: Size(360, 650),
      accent: Color(0xFFE65100),
      note:
          'Keyboard inset reduces effective height, forcing delegate to seek stable visible placement.',
      keyboardInset: 210,
    ),
    const _AnchorPreset(
      title: 'Narrow Pane',
      subtitle: 'Split-view editor with constrained width.',
      anchor: Offset(108, 210),
      viewport: Size(220, 600),
      accent: Color(0xFF2E7D32),
      note:
          'Horizontal clamping becomes visible when toolbar width approaches pane width.',
      keyboardInset: 0,
    ),
    const _AnchorPreset(
      title: 'RTL Review Mode',
      subtitle: 'Right-aligned reading flow with trailing-side anchors.',
      anchor: Offset(310, 280),
      viewport: Size(400, 700),
      accent: Color(0xFF455A64),
      note:
          'Directionality influences contextual expectations while delegate still obeys constraints.',
      keyboardInset: 0,
    ),
  ];

  final List<_LabGuide> guides = <_LabGuide>[
    const _LabGuide(
      title: 'What This Delegate Does',
      body:
          'SpellCheckSuggestionsToolbarLayoutDelegate computes where the spell-check suggestions toolbar should appear relative to an anchor.',
      icon: Icons.settings_overscan,
      color: Color(0xFF1E88E5),
    ),
    const _LabGuide(
      title: 'Primary Input',
      body:
          'Its key input is the anchor coordinate where misspelled text was detected. Constraints and viewport bounds determine final position.',
      icon: Icons.gps_fixed,
      color: Color(0xFF00838F),
    ),
    const _LabGuide(
      title: 'Why It Matters',
      body:
          'Good placement keeps suggestions visible and contextually attached to the selected text across many device sizes.',
      icon: Icons.visibility,
      color: Color(0xFF6A1B9A),
    ),
    const _LabGuide(
      title: 'Interpreter Focus',
      body:
          'This test validates dynamic interaction and visual behavior when interpreted, not Flutter framework correctness itself.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
    const _LabGuide(
      title: 'Production Tip',
      body:
          'Pair delegate behavior with keyboard insets and safe area handling in your overlay pipeline for resilient UX.',
      icon: Icons.lightbulb,
      color: Color(0xFFE65100),
    ),
    const _LabGuide(
      title: 'Debugging Strategy',
      body:
          'Track anchor snapshots and timeline logs while varying viewport sizes to catch edge-overflow issues quickly.',
      icon: Icons.bug_report,
      color: Color(0xFF2E7D32),
    ),
  ];

  final List<_LabMatrixRow> matrixRows = <_LabMatrixRow>[
    const _LabMatrixRow(
      topic: 'Top boundary',
      delegateBehavior: 'Prefers visible placement and avoids clipping past top edge.',
      recommendation: 'Include safe-area padding in overlays for status bar stability.',
    ),
    const _LabMatrixRow(
      topic: 'Bottom boundary',
      delegateBehavior: 'May reposition above anchor to avoid keyboard/edge obstruction.',
      recommendation: 'Inject keyboard insets into scene model before layout.',
    ),
    const _LabMatrixRow(
      topic: 'Narrow width',
      delegateBehavior: 'Horizontal clamping keeps toolbar inside viewport.',
      recommendation: 'Constrain suggestion item widths for compact panes.',
    ),
    const _LabMatrixRow(
      topic: 'Large toolbars',
      delegateBehavior: 'Additional width increases clamping frequency.',
      recommendation: 'Use wrapping/scrolling suggestions in tight spaces.',
    ),
    const _LabMatrixRow(
      topic: 'Anchor jitter',
      delegateBehavior: 'Small anchor changes can shift final position near edges.',
      recommendation: 'Debounce update streams when dragging selections.',
    ),
    const _LabMatrixRow(
      topic: 'Reading direction',
      delegateBehavior: 'Constraint logic remains robust regardless of text direction.',
      recommendation: 'Validate in both LTR and RTL with realistic content.',
    ),
  ];

  Size viewport = const Size(360, 620);
  Offset anchor = const Offset(180, 260);
  Color accent = const Color(0xFF1E88E5);
  double keyboardInset = 0;
  bool showGrid = true;
  bool showSafeArea = true;
  bool showKeyboard = false;
  bool rtl = false;
  bool showHeatmap = true;
  bool showThirdScene = true;
  bool toolbarEnabled = true;
  bool denseToolbar = false;
  int toolbarActions = 3;
  int loads = 0;
  int drags = 0;
  int taps = 0;
  int delegateRebuilds = 0;
  int snapshotId = 0;

  final List<String> console = <String>[];
  final List<_LabTimeline> timeline = <_LabTimeline>[];
  final List<_AnchorSnapshot> snapshots = <_AnchorSnapshot>[];

  void addLog(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    console.insert(0, '[$stamp] $message');
    if (console.length > 180) {
      console.removeLast();
    }
  }

  void addTimeline(String title, String detail, Color color) {
    timeline.insert(0, _LabTimeline(title: title, detail: detail, color: color));
    if (timeline.length > 36) {
      timeline.removeLast();
    }
  }

  Offset clampAnchor(Offset value) {
    final double dx = value.dx.clamp(0, viewport.width);
    final double dy = value.dy.clamp(0, viewport.height - (showKeyboard ? keyboardInset : 0));
    return Offset(dx, dy);
  }

  void captureSnapshot(String note) {
    snapshotId += 1;
    snapshots.insert(
      0,
      _AnchorSnapshot(
        id: snapshotId,
        anchor: anchor,
        viewport: viewport,
        note: note,
        color: accent,
      ),
    );
    if (snapshots.length > 24) {
      snapshots.removeLast();
    }
  }

  String formatDouble(double value) {
    if ((value - value.roundToDouble()).abs() < 0.001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  List<_LabMetric> buildMetrics() {
    final double nx = (anchor.dx / math.max(1, viewport.width)).clamp(0, 1);
    final double ny = (anchor.dy / math.max(1, viewport.height)).clamp(0, 1);
    final double distanceFromCenter = math.sqrt(
      math.pow(nx - 0.5, 2) + math.pow(ny - 0.5, 2),
    );

    return <_LabMetric>[
      _LabMetric(label: 'Anchor X', value: formatDouble(anchor.dx), color: accent),
      _LabMetric(label: 'Anchor Y', value: formatDouble(anchor.dy), color: const Color(0xFF6A1B9A)),
      _LabMetric(label: 'Viewport W', value: formatDouble(viewport.width), color: const Color(0xFF2E7D32)),
      _LabMetric(label: 'Viewport H', value: formatDouble(viewport.height), color: const Color(0xFF00838F)),
      _LabMetric(label: 'Norm X', value: formatDouble(nx), color: const Color(0xFFE65100)),
      _LabMetric(label: 'Norm Y', value: formatDouble(ny), color: const Color(0xFF455A64)),
      _LabMetric(
        label: 'Center Dist',
        value: formatDouble(distanceFromCenter),
        color: const Color(0xFF283593),
      ),
      _LabMetric(label: 'Toolbar actions', value: '$toolbarActions', color: const Color(0xFFAD1457)),
      _LabMetric(label: 'Rebuilds', value: '$delegateRebuilds', color: const Color(0xFF37474F)),
      _LabMetric(label: 'Loads', value: '$loads', color: const Color(0xFF5D4037)),
      _LabMetric(label: 'Drags', value: '$drags', color: const Color(0xFF1565C0)),
      _LabMetric(label: 'Taps', value: '$taps', color: const Color(0xFF827717)),
    ];
  }

  Widget badge(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        border: Border.all(color: const Color(0xFFC9D8ED)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF1C3557),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget sectionTitle(String title, String subtitle, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: accent, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget metricGrid(List<_LabMetric> metrics) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: metrics.map((metric) {
        return Container(
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: metric.color.withValues(alpha: 0.08),
            border: Border.all(color: metric.color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                metric.label,
                style: TextStyle(
                  color: metric.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                metric.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget sliderControl({
    required String label,
    required double min,
    required double max,
    required int divisions,
    required double value,
    required String valueLabel,
    required ValueChanged<double>? onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        border: Border.all(color: color.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                valueLabel,
                style: TextStyle(color: color, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.14),
              inactiveTrackColor: color.withValues(alpha: 0.3),
            ),
            child: Slider(
              min: min,
              max: max,
              divisions: divisions,
              value: value.clamp(min, max),
              label: valueLabel,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget toolbarChip(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(denseToolbar ? 6 : 10),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: denseToolbar ? 11 : 12,
        ),
      ),
    );
  }

  Widget suggestionToolbar(Color color) {
    final List<String> labels = <String>[
      'accept',
      'ignore',
      'learn',
      'replace',
      'next',
      'dictionary',
      'copy',
      'search',
    ];

    final List<Widget> items = <Widget>[];
    for (int i = 0; i < toolbarActions.clamp(1, labels.length); i++) {
      items.add(toolbarChip(labels[i], color));
    }

    return Container(
      constraints: BoxConstraints(maxWidth: denseToolbar ? 240 : 320),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: items),
    );
  }

  Widget scenePanel({
    required String title,
    required String subtitle,
    required Size panelViewport,
    required Offset panelAnchor,
    required Color panelAccent,
    required bool enabled,
    required void Function(void Function()) setState,
  }) {
    final double keyboard = showKeyboard ? keyboardInset : 0;
    final double availableHeight = math.max(120, panelViewport.height - keyboard);
    final Offset resolvedAnchor = Offset(
      panelAnchor.dx.clamp(0, panelViewport.width),
      panelAnchor.dy.clamp(0, availableHeight),
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            panelAccent.withValues(alpha: 0.08),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: panelAccent.withValues(alpha: 0.36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: panelAccent,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(color: Colors.blueGrey.shade700),
          ),
          const SizedBox(height: 10),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD5E1F1)),
            ),
            child: Directionality(
              textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final Size overlaySize = Size(constraints.maxWidth, constraints.maxHeight);
                  final Offset mappedAnchor = Offset(
                    (resolvedAnchor.dx / math.max(1, panelViewport.width)) * overlaySize.width,
                    (resolvedAnchor.dy / math.max(1, panelViewport.height)) * overlaySize.height,
                  );

                  return GestureDetector(
                    onPanUpdate: enabled
                        ? (DragUpdateDetails details) {
                            final RenderBox box = context.findRenderObject()! as RenderBox;
                            final Offset local = box.globalToLocal(details.globalPosition);
                            final Offset mapped = Offset(
                              (local.dx / math.max(1, box.size.width)) * panelViewport.width,
                              (local.dy / math.max(1, box.size.height)) * panelViewport.height,
                            );
                            setState(() {
                              anchor = clampAnchor(mapped);
                              drags += 1;
                              delegateRebuilds += 1;
                            });
                          }
                        : null,
                    onTapDown: enabled
                        ? (TapDownDetails details) {
                            final RenderBox box = context.findRenderObject()! as RenderBox;
                            final Offset local = box.globalToLocal(details.globalPosition);
                            final Offset mapped = Offset(
                              (local.dx / math.max(1, box.size.width)) * panelViewport.width,
                              (local.dy / math.max(1, box.size.height)) * panelViewport.height,
                            );
                            setState(() {
                              anchor = clampAnchor(mapped);
                              taps += 1;
                              delegateRebuilds += 1;
                            });
                            addLog('Tapped $title at (${formatDouble(anchor.dx)}, ${formatDouble(anchor.dy)}).');
                          }
                        : null,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _OverlayPlacementPainter(
                              anchor: resolvedAnchor,
                              viewport: panelViewport,
                              accent: panelAccent,
                              showGrid: showGrid,
                              showSafeArea: showSafeArea,
                              keyboardInset: keyboard,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          right: 12,
                          top: 12,
                          bottom: 12,
                          child: CustomSingleChildLayout(
                            delegate: SpellCheckSuggestionsToolbarLayoutDelegate(
                              anchor: mappedAnchor,
                            ),
                            child: toolbarEnabled
                                ? suggestionToolbar(panelAccent)
                                : const SizedBox.shrink(),
                          ),
                        ),
                        Positioned(
                          left: mappedAnchor.dx - 7,
                          top: mappedAnchor.dy - 7,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: panelAccent,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap or drag inside panel to move anchor. Delegate repositions suggestions toolbar around the highlighted misspelling point.',
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget presetCard(_AnchorPreset preset, void Function(void Function()) setState) {
    return Container(
      width: 318,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[preset.accent.withValues(alpha: 0.1), Colors.white],
        ),
        border: Border.all(color: preset.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            preset.title,
            style: TextStyle(
              color: preset.accent,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            preset.subtitle,
            style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3),
          ),
          const SizedBox(height: 10),
          Text(
            preset.note,
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.34),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              badge('Anchor', '${formatDouble(preset.anchor.dx)}, ${formatDouble(preset.anchor.dy)}'),
              badge('Viewport', '${formatDouble(preset.viewport.width)}x${formatDouble(preset.viewport.height)}'),
              badge('Keyboard', formatDouble(preset.keyboardInset)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  anchor = preset.anchor;
                  viewport = preset.viewport;
                  accent = preset.accent;
                  keyboardInset = preset.keyboardInset;
                  showKeyboard = preset.keyboardInset > 0;
                  loads += 1;
                  delegateRebuilds += 1;
                });
                addLog('Loaded preset: ${preset.title}.');
                addTimeline(
                  'Preset loaded',
                  '${preset.title} | anchor ${formatDouble(anchor.dx)}, ${formatDouble(anchor.dy)}',
                  preset.accent,
                );
                captureSnapshot('Loaded ${preset.title}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Scenario'),
            ),
          ),
        ],
      ),
    );
  }

  Widget matrixTable() {
    Widget cell(String text, {bool header = false, Color? tint}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDCE6F5)),
          color: tint,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: header ? FontWeight.w800 : FontWeight.w500,
            fontSize: header ? 13 : 12,
          ),
        ),
      );
    }

    final List<Widget> rows = <Widget>[
      Row(
        children: <Widget>[
          Expanded(flex: 2, child: cell('Topic', header: true, tint: const Color(0xFFF0F6FF))),
          Expanded(
            flex: 3,
            child: cell('Delegate Behavior', header: true, tint: const Color(0xFFF0F6FF)),
          ),
          Expanded(
            flex: 3,
            child: cell('Recommendation', header: true, tint: const Color(0xFFF0F6FF)),
          ),
        ],
      ),
    ];

    for (final _LabMatrixRow row in matrixRows) {
      rows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.topic, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(flex: 3, child: cell(row.delegateBehavior)),
            Expanded(flex: 3, child: cell(row.recommendation)),
          ],
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: rows));
  }

  Widget timelinePanel() {
    if (timeline.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF5F8FC),
          border: Border.all(color: const Color(0xFFD8E5F4)),
        ),
        child: Text(
          'Timeline empty. Load a scenario or move anchor to capture delegate placement events.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
      children: timeline.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: item.color.withValues(alpha: 0.08),
            border: Border.all(color: item.color.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(color: item.color, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(item.detail, style: TextStyle(color: Colors.blueGrey.shade800, height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ));
  }

  Widget snapshotPanel() {
    if (snapshots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF7FAFD),
          border: Border.all(color: const Color(0xFFDDE8F5)),
        ),
        child: Text(
          'No anchor snapshots yet. Capture snapshots to compare placement behavior across viewport changes.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
      children: snapshots.map((snapshot) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: snapshot.color.withValues(alpha: 0.08),
            border: Border.all(color: snapshot.color.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Snapshot #${snapshot.id} | anchor ${formatDouble(snapshot.anchor.dx)}, ${formatDouble(snapshot.anchor.dy)}',
                style: TextStyle(color: snapshot.color, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                'viewport ${formatDouble(snapshot.viewport.width)}x${formatDouble(snapshot.viewport.height)}',
                style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                snapshot.note,
                style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    ));
  }

  Widget consolePanel() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF0D1321),
      ),
      child: console.isEmpty
          ? const Center(
              child: Text(
                'No logs yet. Interact with anchor and scenario controls to populate diagnostics.',
                style: TextStyle(color: Color(0xFFB7C9EA), fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              itemCount: console.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    console[index],
                    style: const TextStyle(
                      color: Color(0xFFD4E5FF),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final List<_LabMetric> metrics = buildMetrics();
      final Offset constrainedAnchor = clampAnchor(anchor);

      return Container(
        color: const Color(0xFFF3F7FE),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 26),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                ),
                border: Border.all(color: const Color(0xFFC6D8F5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.spellcheck, color: accent),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'SpellCheckSuggestionsToolbarLayoutDelegate Deep Demo',
                              style: TextStyle(
                                color: Color(0xFF102A43),
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Visual placement lab for spell-check suggestion overlays: inspect how anchor, constraints, keyboard insets, and pane geometry influence toolbar positioning.',
                              style: TextStyle(color: Colors.blueGrey.shade700, height: 1.34),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      badge('Anchor', '${formatDouble(constrainedAnchor.dx)}, ${formatDouble(constrainedAnchor.dy)}'),
                      badge('Viewport', '${formatDouble(viewport.width)}x${formatDouble(viewport.height)}'),
                      badge('Keyboard', showKeyboard ? formatDouble(keyboardInset) : 'off'),
                      badge('RTL', rtl ? 'on' : 'off'),
                      badge('Grid', showGrid ? 'on' : 'off'),
                      badge('Safe area', showSafeArea ? 'on' : 'off'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Scenario Presets',
              'Use curated contexts to observe delegate behavior around edges, narrow panes, and keyboard overlays.',
              Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((preset) => presetCard(preset, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              'Layout Controls',
              'Tune viewport, anchor, toolbar density, and interaction modes to stress the delegate in real-world conditions.',
              Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD6E3F4)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: sliderControl(
                          label: 'Viewport width',
                          min: 160,
                          max: 540,
                          divisions: 190,
                          value: viewport.width,
                          valueLabel: formatDouble(viewport.width),
                          onChanged: (double value) {
                            setState(() {
                              viewport = Size(value, viewport.height);
                              anchor = clampAnchor(anchor);
                              delegateRebuilds += 1;
                            });
                            addLog('Viewport width set to ${formatDouble(viewport.width)}.');
                          },
                          color: accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Viewport height',
                          min: 220,
                          max: 940,
                          divisions: 180,
                          value: viewport.height,
                          valueLabel: formatDouble(viewport.height),
                          onChanged: (double value) {
                            setState(() {
                              viewport = Size(viewport.width, value);
                              anchor = clampAnchor(anchor);
                              delegateRebuilds += 1;
                            });
                            addLog('Viewport height set to ${formatDouble(viewport.height)}.');
                          },
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: sliderControl(
                          label: 'Anchor X',
                          min: 0,
                          max: viewport.width,
                          divisions: 220,
                          value: constrainedAnchor.dx,
                          valueLabel: formatDouble(constrainedAnchor.dx),
                          onChanged: (double value) {
                            setState(() {
                              anchor = clampAnchor(Offset(value, anchor.dy));
                              delegateRebuilds += 1;
                            });
                            addLog('Anchor X changed to ${formatDouble(anchor.dx)}.');
                          },
                          color: const Color(0xFF6A1B9A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Anchor Y',
                          min: 0,
                          max: math.max(80, viewport.height - (showKeyboard ? keyboardInset : 0)),
                          divisions: 220,
                          value: constrainedAnchor.dy,
                          valueLabel: formatDouble(constrainedAnchor.dy),
                          onChanged: (double value) {
                            setState(() {
                              anchor = clampAnchor(Offset(anchor.dx, value));
                              delegateRebuilds += 1;
                            });
                            addLog('Anchor Y changed to ${formatDouble(anchor.dy)}.');
                          },
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: sliderControl(
                          label: 'Keyboard inset',
                          min: 0,
                          max: 360,
                          divisions: 180,
                          value: keyboardInset,
                          valueLabel: formatDouble(keyboardInset),
                          onChanged: (double value) {
                            setState(() {
                              keyboardInset = value;
                              anchor = clampAnchor(anchor);
                              delegateRebuilds += 1;
                            });
                            addLog('Keyboard inset changed to ${formatDouble(keyboardInset)}.');
                          },
                          color: const Color(0xFF455A64),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Toolbar actions',
                          min: 1,
                          max: 8,
                          divisions: 7,
                          value: toolbarActions.toDouble(),
                          valueLabel: '$toolbarActions',
                          onChanged: (double value) {
                            setState(() {
                              toolbarActions = value.round();
                              delegateRebuilds += 1;
                            });
                            addLog('Toolbar actions set to $toolbarActions.');
                          },
                          color: const Color(0xFF00838F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: toolbarEnabled,
                          title: const Text('Toolbar enabled'),
                          subtitle: const Text('Toggle suggestions visibility.'),
                          onChanged: (bool value) {
                            setState(() {
                              toolbarEnabled = value;
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'Toolbar enabled.' : 'Toolbar disabled.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: denseToolbar,
                          title: const Text('Dense toolbar'),
                          subtitle: const Text('Compact action chips.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseToolbar = value;
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'Dense toolbar enabled.' : 'Dense toolbar disabled.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showGrid,
                          title: const Text('Grid overlay'),
                          subtitle: const Text('Visualize layout lattice.'),
                          onChanged: (bool value) {
                            setState(() {
                              showGrid = value;
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'Grid overlay enabled.' : 'Grid overlay disabled.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showSafeArea,
                          title: const Text('Safe-area guide'),
                          subtitle: const Text('Show constrained frame.'),
                          onChanged: (bool value) {
                            setState(() {
                              showSafeArea = value;
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'Safe-area guide enabled.' : 'Safe-area guide disabled.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showKeyboard,
                          title: const Text('Keyboard inset active'),
                          subtitle: const Text('Reserve lower screen area.'),
                          onChanged: (bool value) {
                            setState(() {
                              showKeyboard = value;
                              anchor = clampAnchor(anchor);
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'Keyboard inset activated.' : 'Keyboard inset deactivated.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: rtl,
                          title: const Text('RTL scene direction'),
                          subtitle: const Text('Preview right-to-left contexts.'),
                          onChanged: (bool value) {
                            setState(() {
                              rtl = value;
                              delegateRebuilds += 1;
                            });
                            addLog(value ? 'RTL mode enabled.' : 'RTL mode disabled.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showHeatmap,
                          title: const Text('Heatmap panel'),
                          subtitle: const Text('Show anchor influence map.'),
                          onChanged: (bool value) {
                            setState(() {
                              showHeatmap = value;
                            });
                            addLog(value ? 'Heatmap panel shown.' : 'Heatmap panel hidden.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showThirdScene,
                          title: const Text('Third scene'),
                          subtitle: const Text('Enable compact pane comparison.'),
                          onChanged: (bool value) {
                            setState(() {
                              showThirdScene = value;
                            });
                            addLog(value ? 'Third scene enabled.' : 'Third scene hidden.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  anchor = clampAnchor(Offset(viewport.width / 2, viewport.height / 2));
                                  delegateRebuilds += 1;
                                });
                                addLog('Centered anchor in viewport.');
                                addTimeline(
                                  'Anchor centered',
                                  '${formatDouble(anchor.dx)}, ${formatDouble(anchor.dy)}',
                                  accent,
                                );
                              },
                              child: const Text('Center Anchor'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  anchor = clampAnchor(const Offset(0, 0));
                                  delegateRebuilds += 1;
                                });
                                addLog('Moved anchor to top-left corner.');
                                addTimeline('Top-left probe', 'Anchor moved to corner for edge test', accent);
                              },
                              child: const Text('Top-Left Probe'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  anchor = clampAnchor(Offset(viewport.width, viewport.height));
                                  delegateRebuilds += 1;
                                });
                                addLog('Moved anchor to bottom-right corner.');
                                addTimeline('Bottom-right probe', 'Anchor moved to lower edge', accent);
                              },
                              child: const Text('Bottom-Right Probe'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                captureSnapshot('Manual capture');
                                addLog('Captured anchor snapshot.');
                              },
                              child: const Text('Capture Snapshot'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Delegate Scene Gallery',
              'Three synchronized overlays show how SpellCheckSuggestionsToolbarLayoutDelegate responds to placement constraints.',
              Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            scenePanel(
              title: 'Primary Editor Viewport',
              subtitle: 'Main document area with configurable anchor and toolbar actions.',
              panelViewport: viewport,
              panelAnchor: constrainedAnchor,
              panelAccent: accent,
              enabled: true,
              setState: setState,
            ),
            const SizedBox(height: 12),
            scenePanel(
              title: 'Narrow Review Pane',
              subtitle: 'Constrained width scene emphasizes horizontal clamping behavior.',
              panelViewport: Size(math.max(170, viewport.width * 0.62), viewport.height),
              panelAnchor: constrainedAnchor,
              panelAccent: const Color(0xFF2E7D32),
              enabled: true,
              setState: setState,
            ),
            if (showThirdScene) ...<Widget>[
              const SizedBox(height: 12),
              scenePanel(
                title: 'Bottom-Edge + Keyboard Scene',
                subtitle: 'Focuses on toolbar repositioning with reduced vertical availability.',
                panelViewport: Size(viewport.width, math.max(280, viewport.height * 0.8)),
                panelAnchor: Offset(constrainedAnchor.dx, math.max(0, constrainedAnchor.dy + 60)),
                panelAccent: const Color(0xFFE65100),
                enabled: true,
                setState: setState,
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              'Placement Inspector',
              'Metrics and code-oriented snapshot for how to wire this delegate with CustomSingleChildLayout.',
              Icons.analytics,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD7E3F4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  metricGrid(metrics),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF26476E)),
                      color: const Color(0xFF0D1321),
                    ),
                    child: Text(
                      'CustomSingleChildLayout(\n'
                      '  delegate: SpellCheckSuggestionsToolbarLayoutDelegate(\n'
                      '    anchor: Offset(${formatDouble(anchor.dx)}, ${formatDouble(anchor.dy)}),\n'
                      '  ),\n'
                      '  child: SuggestionsToolbar(actions: $toolbarActions),\n'
                      ')\n\n'
                      'viewport: ${formatDouble(viewport.width)} x ${formatDouble(viewport.height)}\n'
                      'keyboardInset: ${formatDouble(keyboardInset)}\n'
                      'rtl: ${rtl ? 'true' : 'false'}\n'
                      'showSafeArea: ${showSafeArea ? 'true' : 'false'}\n'
                      'delegateRebuilds: $delegateRebuilds',
                      style: const TextStyle(
                        color: Color(0xFFD5E7FF),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.34,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (showHeatmap) ...<Widget>[
              const SizedBox(height: 18),
              sectionTitle(
                'Constraint Heatmap',
                'Visual map of anchor influence against viewport constraints for debugging placement edge cases.',
                Icons.blur_on,
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD4E0F2)),
                ),
                child: CustomPaint(
                  painter: _ConstraintHeatmapPainter(
                    anchor: constrainedAnchor,
                    viewport: viewport,
                    accent: accent,
                    showSafeArea: showSafeArea,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              'Guidance Cards',
              'Practical usage notes to apply SpellCheckSuggestionsToolbarLayoutDelegate in production overlays.',
              Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guides.map((guide) {
                return Container(
                  width: 305,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: guide.color.withValues(alpha: 0.28)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(guide.icon, color: guide.color, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              guide.title,
                              style: TextStyle(color: guide.color, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        guide.body,
                        style: TextStyle(color: Colors.blueGrey.shade800, height: 1.32, fontSize: 13),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Behavior Matrix',
              'Cross-check delegate behavior categories and associated implementation guidance.',
              Icons.table_view,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD7E3F4)),
              ),
              child: matrixTable(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Anchor Snapshots',
              'Record anchor/viewport states to compare delegate output under different scenarios.',
              Icons.camera,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Timeline',
              'Event stream for preset loads, probes, and anchor adjustments during interpreter execution.',
              Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Diagnostics Console',
              'Text telemetry to trace runtime decisions and interactions in interpreted mode.',
              Icons.terminal,
            ),
            const SizedBox(height: 10),
            consolePanel(),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFE8F5E9), Color(0xFFE3F2FD)],
                ),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Text(
                'Summary: SpellCheckSuggestionsToolbarLayoutDelegate is the layout decision engine that places spell-check suggestion '
                'toolbars relative to a misspelled-text anchor while respecting viewport constraints. This deep demo shows multiple '
                'visual overlays, edge probes, keyboard inset simulation, narrow-pane behavior, metric instrumentation, and guidance '
                'cards so developers can confidently integrate resilient suggestion-toolbar placement in interpreted Flutter apps.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Session started at '
              '${sessionStart.hour.toString().padLeft(2, '0')}:'
              '${sessionStart.minute.toString().padLeft(2, '0')}:'
              '${sessionStart.second.toString().padLeft(2, '0')}.',
              style: TextStyle(color: Colors.blueGrey.shade600, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    },
  );
}
