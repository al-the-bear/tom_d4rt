import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ToolbarPreset {
  const _ToolbarPreset({
    required this.title,
    required this.subtitle,
    required this.anchor,
    required this.viewport,
    required this.accent,
    required this.keyboardInset,
    required this.actionCount,
    required this.rtl,
    required this.note,
  });

  final String title;
  final String subtitle;
  final Offset anchor;
  final Size viewport;
  final Color accent;
  final double keyboardInset;
  final int actionCount;
  final bool rtl;
  final String note;
}

class _ToolbarGuide {
  const _ToolbarGuide({
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

class _ToolbarMetric {
  const _ToolbarMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _ToolbarEvent {
  const _ToolbarEvent({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _ToolbarMatrixRow {
  const _ToolbarMatrixRow({
    required this.topic,
    required this.behavior,
    required this.recommendation,
  });

  final String topic;
  final String behavior;
  final String recommendation;
}

class _ToolbarSnapshot {
  const _ToolbarSnapshot({
    required this.id,
    required this.anchor,
    required this.viewport,
    required this.actionCount,
    required this.note,
    required this.color,
  });

  final int id;
  final Offset anchor;
  final Size viewport;
  final int actionCount;
  final String note;
  final Color color;
}

class _ToolbarPlacementPainter extends CustomPainter {
  _ToolbarPlacementPainter({
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

    final Rect viewportRect = Rect.fromLTWH(14, 14, size.width - 28, size.height - 28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewportRect, const Radius.circular(12)),
      Paint()..color = Colors.white.withValues(alpha: 0.82),
    );

    if (showGrid) {
      const int cols = 10;
      const int rows = 8;
      for (int i = 1; i < cols; i++) {
        final double x = viewportRect.left + viewportRect.width * (i / cols);
        canvas.drawLine(
          Offset(x, viewportRect.top),
          Offset(x, viewportRect.bottom),
          Paint()
            ..color = const Color(0xFFD2DEEE)
            ..strokeWidth = 1,
        );
      }
      for (int i = 1; i < rows; i++) {
        final double y = viewportRect.top + viewportRect.height * (i / rows);
        canvas.drawLine(
          Offset(viewportRect.left, y),
          Offset(viewportRect.right, y),
          Paint()
            ..color = const Color(0xFFD2DEEE)
            ..strokeWidth = 1,
        );
      }
    }

    if (showSafeArea) {
      final Rect safeRect = Rect.fromLTWH(
        viewportRect.left + 14,
        viewportRect.top + 10,
        viewportRect.width - 28,
        viewportRect.height - 20,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(safeRect, const Radius.circular(8)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = const Color(0xFF8EA2BE),
      );
    }

    if (keyboardInset > 0) {
      final double height = viewportRect.height * (keyboardInset / math.max(1, viewport.height));
      final Rect keyboardRect = Rect.fromLTWH(
        viewportRect.left,
        viewportRect.bottom - height,
        viewportRect.width,
        height,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(keyboardRect, const Radius.circular(8)),
        Paint()..color = const Color(0xFF37474F).withValues(alpha: 0.23),
      );
    }

    final double x = viewportRect.left + (anchor.dx / math.max(1, viewport.width)) * viewportRect.width;
    final double y = viewportRect.top + (anchor.dy / math.max(1, viewport.height)) * viewportRect.height;

    canvas.drawCircle(Offset(x, y), 8, Paint()..color = accent);
    canvas.drawCircle(Offset(x, y), 15, Paint()..color = accent.withValues(alpha: 0.18));
    canvas.drawLine(
      Offset(x - 15, y),
      Offset(x + 15, y),
      Paint()
        ..color = accent
        ..strokeWidth = 1.4,
    );
    canvas.drawLine(
      Offset(x, y - 15),
      Offset(x, y + 15),
      Paint()
        ..color = accent
        ..strokeWidth = 1.4,
    );

    final TextPainter label = TextPainter(
      text: TextSpan(
        text: 'Anchor ${anchor.dx.toStringAsFixed(1)}, ${anchor.dy.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF1A3558),
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: viewportRect.width - 8);
    label.paint(canvas, Offset(viewportRect.left + 4, viewportRect.top + 4));
  }

  @override
  bool shouldRepaint(covariant _ToolbarPlacementPainter oldDelegate) {
    return oldDelegate.anchor != anchor ||
        oldDelegate.viewport != viewport ||
        oldDelegate.accent != accent ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showSafeArea != showSafeArea ||
        oldDelegate.keyboardInset != keyboardInset;
  }
}

class _ActionHeatmapPainter extends CustomPainter {
  _ActionHeatmapPainter({
    required this.anchor,
    required this.viewport,
    required this.accent,
    required this.actionCount,
  });

  final Offset anchor;
  final Size viewport;
  final Color accent;
  final int actionCount;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FAFE),
    );

    final Rect chart = Rect.fromLTWH(14, 16, size.width - 28, size.height - 30);
    final double ax = anchor.dx / math.max(1, viewport.width);
    final double ay = anchor.dy / math.max(1, viewport.height);
    final double spread = (actionCount / 8).clamp(0.2, 1.0);

    for (int y = 0; y < 28; y++) {
      for (int x = 0; x < 28; x++) {
        final double dx = x / 27;
        final double dy = y / 27;
        final double dist = math.sqrt(math.pow(dx - ax, 2) + math.pow(dy - ay, 2));
        final double influence = (1 - dist * (2.1 - spread)).clamp(0, 1);
        final Rect cell = Rect.fromLTWH(
          chart.left + chart.width * (x / 28),
          chart.top + chart.height * (y / 28),
          chart.width / 28,
          chart.height / 28,
        );
        canvas.drawRect(
          cell,
          Paint()..color = accent.withValues(alpha: 0.06 + influence * 0.58),
        );
      }
    }

    final Offset marker = Offset(
      chart.left + ax * chart.width,
      chart.top + ay * chart.height,
    );
    canvas.drawCircle(marker, 7, Paint()..color = const Color(0xFF0F2946));
    canvas.drawCircle(
      marker,
      12,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF0F2946).withValues(alpha: 0.45),
    );

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'Action Density Heatmap',
        style: TextStyle(
          color: Color(0xFF1A3458),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: chart.width);
    title.paint(canvas, const Offset(14, 3));
  }

  @override
  bool shouldRepaint(covariant _ActionHeatmapPainter oldDelegate) {
    return oldDelegate.anchor != anchor ||
        oldDelegate.viewport != viewport ||
        oldDelegate.accent != accent ||
        oldDelegate.actionCount != actionCount;
  }
}

dynamic build(BuildContext context) {
  final DateTime startedAt = DateTime.now();

  final List<_ToolbarPreset> presets = <_ToolbarPreset>[
    const _ToolbarPreset(
      title: 'Editor Midline',
      subtitle: 'Balanced suggestions over paragraph center.',
      anchor: Offset(180, 260),
      viewport: Size(360, 640),
      accent: Color(0xFF1565C0),
      keyboardInset: 0,
      actionCount: 4,
      rtl: false,
      note: 'Default case for in-flow typo correction in long text.',
    ),
    const _ToolbarPreset(
      title: 'Top Margin Word',
      subtitle: 'Anchor near top edge under app bar.',
      anchor: Offset(220, 44),
      viewport: Size(390, 700),
      accent: Color(0xFF6A1B9A),
      keyboardInset: 0,
      actionCount: 3,
      rtl: false,
      note: 'Ensures toolbar is placed visibly when vertical space above anchor is limited.',
    ),
    const _ToolbarPreset(
      title: 'Bottom + Keyboard',
      subtitle: 'Anchor near keyboard-obstructed lower area.',
      anchor: Offset(150, 560),
      viewport: Size(360, 660),
      accent: Color(0xFFE65100),
      keyboardInset: 210,
      actionCount: 5,
      rtl: false,
      note: 'Tests readable placement when keyboard consumes lower viewport.',
    ),
    const _ToolbarPreset(
      title: 'Narrow Split Pane',
      subtitle: 'Compact pane where toolbar width pressure is high.',
      anchor: Offset(94, 220),
      viewport: Size(220, 620),
      accent: Color(0xFF2E7D32),
      keyboardInset: 0,
      actionCount: 6,
      rtl: false,
      note: 'Useful for desktop split editors and constrained side-by-side views.',
    ),
    const _ToolbarPreset(
      title: 'RTL Review',
      subtitle: 'Right-to-left reading context validation.',
      anchor: Offset(308, 286),
      viewport: Size(400, 720),
      accent: Color(0xFF455A64),
      keyboardInset: 0,
      actionCount: 4,
      rtl: true,
      note: 'Confirms toolbar remains understandable and anchored in RTL workflows.',
    ),
  ];

  final List<_ToolbarGuide> guides = <_ToolbarGuide>[
    const _ToolbarGuide(
      title: 'Purpose',
      body:
          'SpellCheckSuggestionsToolbar is a Material widget that presents correction actions near a misspelled text anchor.',
      icon: Icons.spellcheck,
      color: Color(0xFF1565C0),
    ),
    const _ToolbarGuide(
      title: 'Direct Constructor',
      body:
          'Use SpellCheckSuggestionsToolbar(anchor: ..., buttonItems: ...) when you control the suggestion overlay pipeline.',
      icon: Icons.construction,
      color: Color(0xFF6A1B9A),
    ),
    const _ToolbarGuide(
      title: 'EditableText Integration',
      body:
          'SpellCheckSuggestionsToolbar.editableText(...) supports integration with EditableText state and native suggestion flow.',
      icon: Icons.text_fields,
      color: Color(0xFF2E7D32),
    ),
    const _ToolbarGuide(
      title: 'Layout Behavior',
      body:
          'Toolbar placement follows anchor and viewport constraints; use diagnostics to catch clipping near edges and keyboard insets.',
      icon: Icons.open_with,
      color: Color(0xFFE65100),
    ),
    const _ToolbarGuide(
      title: 'Action Design',
      body:
          'Keep suggestions concise and task-oriented: accept, replace, ignore, or dictionary actions.',
      icon: Icons.checklist,
      color: Color(0xFF00838F),
    ),
    const _ToolbarGuide(
      title: 'Interpreter Validation Goal',
      body:
          'This demo verifies runtime interaction patterns in interpreted execution rather than asserting Flutter internals.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
  ];

  final List<_ToolbarMatrixRow> matrixRows = <_ToolbarMatrixRow>[
    const _ToolbarMatrixRow(
      topic: 'Anchor near top',
      behavior: 'Toolbar seeks visible placement without clipping status/toolbar regions.',
      recommendation: 'Reserve top safe area and avoid long button labels.',
    ),
    const _ToolbarMatrixRow(
      topic: 'Anchor near bottom',
      behavior: 'Toolbar repositions around keyboard and lower bounds.',
      recommendation: 'Track keyboard inset and update overlay frame before building toolbar.',
    ),
    const _ToolbarMatrixRow(
      topic: 'High action count',
      behavior: 'Toolbar width grows and clamping pressure increases.',
      recommendation: 'Limit action count or use compact labels in constrained layouts.',
    ),
    const _ToolbarMatrixRow(
      topic: 'Split-pane editor',
      behavior: 'Narrow viewport makes horizontal overflow more likely.',
      recommendation: 'Prefer dense action chips and fewer optional actions.',
    ),
    const _ToolbarMatrixRow(
      topic: 'RTL content',
      behavior: 'Directionality changes perception while placement remains anchor-driven.',
      recommendation: 'Validate action ordering for locale-specific UX expectations.',
    ),
    const _ToolbarMatrixRow(
      topic: 'Live selection movement',
      behavior: 'Frequent anchor updates trigger rapid toolbar repositioning.',
      recommendation: 'Debounce updates if selection drags emit excessive events.',
    ),
  ];

  Size viewport = const Size(360, 640);
  Offset anchor = const Offset(180, 260);
  Color accent = const Color(0xFF1565C0);
  double keyboardInset = 0;
  bool showKeyboard = false;
  bool showGrid = true;
  bool showSafeArea = true;
  bool rtl = false;
  bool showHeatmap = true;
  bool showThirdScene = true;
  bool toolbarVisible = true;
  bool denseToolbar = false;
  bool includeUtilityActions = true;
  bool includeSeverityTag = true;
  int actionCount = 4;
  int presetLoads = 0;
  int anchorTaps = 0;
  int anchorDrags = 0;
  int toolbarBuilds = 0;
  int actionPresses = 0;
  int snapshotId = 0;

  final List<String> console = <String>[];
  final List<_ToolbarEvent> timeline = <_ToolbarEvent>[];
  final List<_ToolbarSnapshot> snapshots = <_ToolbarSnapshot>[];

  void addLog(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    console.insert(0, '[$stamp] $message');
    if (console.length > 180) {
      console.removeLast();
    }
  }

  void addEvent(String title, String detail, Color color) {
    timeline.insert(0, _ToolbarEvent(title: title, detail: detail, color: color));
    if (timeline.length > 40) {
      timeline.removeLast();
    }
  }

  Offset clampAnchor(Offset input) {
    final double maxY = math.max(1, viewport.height - (showKeyboard ? keyboardInset : 0));
    return Offset(input.dx.clamp(0, viewport.width), input.dy.clamp(0, maxY));
  }

  String fmt(double value) {
    if ((value - value.roundToDouble()).abs() < 0.0001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  void captureSnapshot(String note) {
    snapshotId += 1;
    snapshots.insert(
      0,
      _ToolbarSnapshot(
        id: snapshotId,
        anchor: anchor,
        viewport: viewport,
        actionCount: actionCount,
        note: note,
        color: accent,
      ),
    );
    if (snapshots.length > 24) {
      snapshots.removeLast();
    }
  }

  Widget chip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFC9D8ED)),
        color: Colors.white.withValues(alpha: 0.82),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF1D3557),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget sectionTitle({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
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

  List<ContextMenuButtonItem> buildToolbarItems(void Function(void Function()) setState, Color color) {
    final List<_ActionSpec> specs = <_ActionSpec>[
      _ActionSpec(
        label: 'Replace',
        type: ContextMenuButtonType.custom,
        event: 'Replace suggestion chosen',
      ),
      _ActionSpec(
        label: 'Ignore',
        type: ContextMenuButtonType.custom,
        event: 'Ignore selected',
      ),
      _ActionSpec(
        label: 'Add Dict',
        type: ContextMenuButtonType.custom,
        event: 'Added to dictionary',
      ),
      _ActionSpec(
        label: 'Next',
        type: ContextMenuButtonType.custom,
        event: 'Navigate to next issue',
      ),
      _ActionSpec(
        label: 'Prev',
        type: ContextMenuButtonType.custom,
        event: 'Navigate to previous issue',
      ),
      _ActionSpec(
        label: 'Explain',
        type: ContextMenuButtonType.custom,
        event: 'Open explanation tooltip',
      ),
      _ActionSpec(
        label: 'Search',
        type: ContextMenuButtonType.custom,
        event: 'Search replacement options',
      ),
      _ActionSpec(
        label: 'Dismiss',
        type: ContextMenuButtonType.custom,
        event: 'Dismiss toolbar',
      ),
    ];

    final int count = actionCount.clamp(1, specs.length);
    final List<ContextMenuButtonItem> items = <ContextMenuButtonItem>[];

    for (int i = 0; i < count; i++) {
      final _ActionSpec spec = specs[i];
      items.add(
        ContextMenuButtonItem(
          label: spec.label,
          type: spec.type,
          onPressed: () {
            setState(() {
              actionPresses += 1;
            });
            addLog('Action pressed: ${spec.label}.');
            addEvent('Toolbar action', spec.event, color);
          },
        ),
      );
    }

    if (includeUtilityActions && count < specs.length) {
      items.add(
        ContextMenuButtonItem(
          label: 'Utility',
          type: ContextMenuButtonType.custom,
          onPressed: () {
            setState(() {
              actionPresses += 1;
            });
            addLog('Utility action pressed.');
            addEvent('Toolbar action', 'Utility command selected', color);
          },
        ),
      );
    }

    return items;
  }

  Widget metricGrid(List<_ToolbarMetric> metrics) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: metrics.map((metric) {
        return Container(
          width: 132,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: metric.color.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: metric.color.withValues(alpha: 0.3)),
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
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget sliderBox({
    required String label,
    required String valueLabel,
    required double min,
    required double max,
    required int divisions,
    required double value,
    required ValueChanged<double>? onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
              ),
              Text(valueLabel, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: color.withValues(alpha: 0.3),
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.15),
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

  Widget presetCard(_ToolbarPreset preset, void Function(void Function()) setState) {
    return Container(
      width: 318,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[preset.accent.withValues(alpha: 0.11), Colors.white],
        ),
        border: Border.all(color: preset.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            preset.title,
            style: TextStyle(color: preset.accent, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(
            preset.subtitle,
            style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3),
          ),
          const SizedBox(height: 8),
          Text(
            preset.note,
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.34),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              chip('Anchor', '${fmt(preset.anchor.dx)}, ${fmt(preset.anchor.dy)}'),
              chip('Viewport', '${fmt(preset.viewport.width)}x${fmt(preset.viewport.height)}'),
              chip('Actions', '${preset.actionCount}'),
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
                  actionCount = preset.actionCount;
                  rtl = preset.rtl;
                  presetLoads += 1;
                  toolbarBuilds += 1;
                });
                addLog('Loaded preset ${preset.title}.');
                addEvent(
                  'Preset loaded',
                  '${preset.title}: anchor ${fmt(anchor.dx)}, ${fmt(anchor.dy)}',
                  preset.accent,
                );
                captureSnapshot('Loaded ${preset.title}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Preset'),
            ),
          ),
        ],
      ),
    );
  }

  Widget editorBackdrop({required Color accent}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD0DEEF)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFAFCFF), Color(0xFFF1F7FF)],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.description, color: accent, size: 16),
              const SizedBox(width: 6),
              Text(
                'Simulated Text Surface',
                style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const Spacer(),
              if (includeSeverityTag)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFFFCC80)),
                  ),
                  child: const Text(
                    'medium typo risk',
                    style: TextStyle(
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'A production editor typically forwards misspelled-word coordinates into '
            'SpellCheckSuggestionsToolbar so correction commands appear adjacent to text.',
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget scenePanel({
    required String title,
    required String subtitle,
    required Size panelViewport,
    required Offset panelAnchor,
    required Color panelAccent,
    required bool allowInteract,
    required void Function(void Function()) setState,
  }) {
    final double keyboard = showKeyboard ? keyboardInset : 0;
    final double safeHeight = math.max(100, panelViewport.height - keyboard);
    final Offset normalizedAnchor = Offset(
      panelAnchor.dx.clamp(0, panelViewport.width),
      panelAnchor.dy.clamp(0, safeHeight),
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[panelAccent.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: panelAccent.withValues(alpha: 0.38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: panelAccent, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.blueGrey.shade700)),
          const SizedBox(height: 10),
          Container(
            height: 270,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD6E2F2)),
            ),
            child: Directionality(
              textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final Size sceneSize = Size(constraints.maxWidth, constraints.maxHeight);
                  final Offset sceneAnchor = Offset(
                    (normalizedAnchor.dx / math.max(1, panelViewport.width)) * sceneSize.width,
                    (normalizedAnchor.dy / math.max(1, panelViewport.height)) * sceneSize.height,
                  );

                  return GestureDetector(
                    onTapDown: allowInteract
                        ? (TapDownDetails details) {
                            final RenderBox box = context.findRenderObject()! as RenderBox;
                            final Offset local = box.globalToLocal(details.globalPosition);
                            final Offset mapped = Offset(
                              (local.dx / math.max(1, box.size.width)) * panelViewport.width,
                              (local.dy / math.max(1, box.size.height)) * panelViewport.height,
                            );
                            setState(() {
                              anchor = clampAnchor(mapped);
                              anchorTaps += 1;
                              toolbarBuilds += 1;
                            });
                            addLog('Tapped $title at ${fmt(anchor.dx)}, ${fmt(anchor.dy)}.');
                            addEvent('Anchor tap', '$title updated anchor', panelAccent);
                          }
                        : null,
                    onPanUpdate: allowInteract
                        ? (DragUpdateDetails details) {
                            final RenderBox box = context.findRenderObject()! as RenderBox;
                            final Offset local = box.globalToLocal(details.globalPosition);
                            final Offset mapped = Offset(
                              (local.dx / math.max(1, box.size.width)) * panelViewport.width,
                              (local.dy / math.max(1, box.size.height)) * panelViewport.height,
                            );
                            setState(() {
                              anchor = clampAnchor(mapped);
                              anchorDrags += 1;
                              toolbarBuilds += 1;
                            });
                          }
                        : null,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _ToolbarPlacementPainter(
                              anchor: normalizedAnchor,
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
                          child: editorBackdrop(accent: panelAccent),
                        ),
                        Positioned(
                          left: sceneAnchor.dx - 7,
                          top: sceneAnchor.dy - 7,
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
                        if (toolbarVisible)
                          Positioned(
                            left: 12,
                            right: 12,
                            top: 12,
                            bottom: 12,
                            child: CustomSingleChildLayout(
                              delegate: SpellCheckSuggestionsToolbarLayoutDelegate(
                                anchor: sceneAnchor,
                              ),
                              child: SpellCheckSuggestionsToolbar(
                                anchor: sceneAnchor,
                                buttonItems: buildToolbarItems(setState, panelAccent),
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
            'This panel renders SpellCheckSuggestionsToolbar directly with contextual button items. '
            'Move the anchor to validate placement and action behavior.',
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.3),
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
          border: Border.all(color: const Color(0xFFDCE7F5)),
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
            child: cell('Observed Behavior', header: true, tint: const Color(0xFFF0F6FF)),
          ),
          Expanded(
            flex: 3,
            child: cell('Recommendation', header: true, tint: const Color(0xFFF0F6FF)),
          ),
        ],
      ),
    ];

    for (final _ToolbarMatrixRow row in matrixRows) {
      rows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.topic, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(flex: 3, child: cell(row.behavior)),
            Expanded(flex: 3, child: cell(row.recommendation)),
          ],
        ),
      );
    }

    return Column(children: rows);
  }

  Widget timelinePanel() {
    if (timeline.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD9E5F4)),
        ),
        child: Text(
          'Timeline is empty. Load presets, move anchors, and press toolbar actions to capture runtime events.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return Column(
      children: timeline.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: entry.color.withValues(alpha: 0.08),
            border: Border.all(color: entry.color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: entry.color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.title,
                      style: TextStyle(color: entry.color, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(entry.detail, style: TextStyle(color: Colors.blueGrey.shade800, height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget snapshotPanel() {
    if (snapshots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDDE8F5)),
        ),
        child: Text(
          'No snapshots captured yet. Use "Capture Snapshot" to save toolbar placement states.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return Column(
      children: snapshots.map((snapshot) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: snapshot.color.withValues(alpha: 0.08),
            border: Border.all(color: snapshot.color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Snapshot #${snapshot.id} | anchor ${fmt(snapshot.anchor.dx)}, ${fmt(snapshot.anchor.dy)}',
                style: TextStyle(color: snapshot.color, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 3),
              Text(
                'viewport ${fmt(snapshot.viewport.width)}x${fmt(snapshot.viewport.height)} | actions ${snapshot.actionCount}',
                style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(snapshot.note, style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget consolePanel() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1321),
        borderRadius: BorderRadius.circular(12),
      ),
      child: console.isEmpty
          ? const Center(
              child: Text(
                'No logs yet. Interact with toolbar actions and anchor controls.',
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
      final Offset clamped = clampAnchor(anchor);
      final double normalizedX = (clamped.dx / math.max(1, viewport.width)).clamp(0, 1);
      final double normalizedY = (clamped.dy / math.max(1, viewport.height)).clamp(0, 1);

      final List<_ToolbarMetric> metrics = <_ToolbarMetric>[
        _ToolbarMetric(label: 'Anchor X', value: fmt(clamped.dx), color: accent),
        _ToolbarMetric(label: 'Anchor Y', value: fmt(clamped.dy), color: const Color(0xFF6A1B9A)),
        _ToolbarMetric(label: 'Viewport W', value: fmt(viewport.width), color: const Color(0xFF2E7D32)),
        _ToolbarMetric(label: 'Viewport H', value: fmt(viewport.height), color: const Color(0xFF00838F)),
        _ToolbarMetric(label: 'Norm X', value: fmt(normalizedX), color: const Color(0xFFE65100)),
        _ToolbarMetric(label: 'Norm Y', value: fmt(normalizedY), color: const Color(0xFF455A64)),
        _ToolbarMetric(label: 'Action count', value: '$actionCount', color: const Color(0xFF283593)),
        _ToolbarMetric(label: 'Toolbar builds', value: '$toolbarBuilds', color: const Color(0xFF37474F)),
        _ToolbarMetric(label: 'Action presses', value: '$actionPresses', color: const Color(0xFFAD1457)),
        _ToolbarMetric(label: 'Preset loads', value: '$presetLoads', color: const Color(0xFF5D4037)),
        _ToolbarMetric(label: 'Anchor taps', value: '$anchorTaps', color: const Color(0xFF1565C0)),
        _ToolbarMetric(label: 'Anchor drags', value: '$anchorDrags', color: const Color(0xFF827717)),
      ];

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
                  colors: <Color>[Color(0xFFE6F0FF), Color(0xFFF2E8FF)],
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
                              'SpellCheckSuggestionsToolbar Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Interactive command center demonstrating how SpellCheckSuggestionsToolbar behaves across anchors, viewports, keyboard insets, and action densities.',
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
                      chip('Anchor', '${fmt(clamped.dx)}, ${fmt(clamped.dy)}'),
                      chip('Viewport', '${fmt(viewport.width)}x${fmt(viewport.height)}'),
                      chip('Actions', '$actionCount'),
                      chip('RTL', rtl ? 'on' : 'off'),
                      chip('Keyboard', showKeyboard ? fmt(keyboardInset) : 'off'),
                      chip('Safe area', showSafeArea ? 'on' : 'off'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Presets',
              subtitle: 'Load practical spell-check contexts to inspect toolbar placement and interaction.',
              icon: Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((p) => presetCard(p, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Toolbar Controls',
              subtitle: 'Tune viewport, anchor, actions, and mode switches for placement stress testing.',
              icon: Icons.tune,
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
                        child: sliderBox(
                          label: 'Viewport width',
                          valueLabel: fmt(viewport.width),
                          min: 160,
                          max: 560,
                          divisions: 200,
                          value: viewport.width,
                          onChanged: (double value) {
                            setState(() {
                              viewport = Size(value, viewport.height);
                              anchor = clampAnchor(anchor);
                              toolbarBuilds += 1;
                            });
                            addLog('Viewport width updated to ${fmt(viewport.width)}.');
                          },
                          color: accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderBox(
                          label: 'Viewport height',
                          valueLabel: fmt(viewport.height),
                          min: 220,
                          max: 980,
                          divisions: 190,
                          value: viewport.height,
                          onChanged: (double value) {
                            setState(() {
                              viewport = Size(viewport.width, value);
                              anchor = clampAnchor(anchor);
                              toolbarBuilds += 1;
                            });
                            addLog('Viewport height updated to ${fmt(viewport.height)}.');
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
                        child: sliderBox(
                          label: 'Anchor X',
                          valueLabel: fmt(clamped.dx),
                          min: 0,
                          max: viewport.width,
                          divisions: 200,
                          value: clamped.dx,
                          onChanged: (double value) {
                            setState(() {
                              anchor = clampAnchor(Offset(value, anchor.dy));
                              toolbarBuilds += 1;
                            });
                            addLog('Anchor X changed to ${fmt(anchor.dx)}.');
                          },
                          color: const Color(0xFF6A1B9A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderBox(
                          label: 'Anchor Y',
                          valueLabel: fmt(clamped.dy),
                          min: 0,
                          max: math.max(100, viewport.height - (showKeyboard ? keyboardInset : 0)),
                          divisions: 200,
                          value: clamped.dy,
                          onChanged: (double value) {
                            setState(() {
                              anchor = clampAnchor(Offset(anchor.dx, value));
                              toolbarBuilds += 1;
                            });
                            addLog('Anchor Y changed to ${fmt(anchor.dy)}.');
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
                        child: sliderBox(
                          label: 'Keyboard inset',
                          valueLabel: fmt(keyboardInset),
                          min: 0,
                          max: 380,
                          divisions: 190,
                          value: keyboardInset,
                          onChanged: (double value) {
                            setState(() {
                              keyboardInset = value;
                              anchor = clampAnchor(anchor);
                              toolbarBuilds += 1;
                            });
                            addLog('Keyboard inset set to ${fmt(keyboardInset)}.');
                          },
                          color: const Color(0xFF455A64),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderBox(
                          label: 'Action count',
                          valueLabel: '$actionCount',
                          min: 1,
                          max: 8,
                          divisions: 7,
                          value: actionCount.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              actionCount = value.round();
                              toolbarBuilds += 1;
                            });
                            addLog('Action count set to $actionCount.');
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
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: toolbarVisible,
                          title: const Text('Toolbar visible'),
                          subtitle: const Text('Toggle SpellCheckSuggestionsToolbar rendering.'),
                          onChanged: (bool value) {
                            setState(() {
                              toolbarVisible = value;
                              toolbarBuilds += 1;
                            });
                            addLog(value ? 'Toolbar shown.' : 'Toolbar hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: denseToolbar,
                          title: const Text('Dense toolbar mode'),
                          subtitle: const Text('Compact presentation emphasis.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseToolbar = value;
                              if (denseToolbar && actionCount > 5) {
                                actionCount = 5;
                              }
                              toolbarBuilds += 1;
                            });
                            addLog(value ? 'Dense toolbar enabled.' : 'Dense toolbar disabled.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: includeUtilityActions,
                          title: const Text('Include utility action'),
                          subtitle: const Text('Adds fallback command button.'),
                          onChanged: (bool value) {
                            setState(() {
                              includeUtilityActions = value;
                              toolbarBuilds += 1;
                            });
                            addLog(value ? 'Utility action enabled.' : 'Utility action disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: includeSeverityTag,
                          title: const Text('Severity tag overlay'),
                          subtitle: const Text('Show issue severity chip in editor backdrop.'),
                          onChanged: (bool value) {
                            setState(() {
                              includeSeverityTag = value;
                            });
                            addLog(value ? 'Severity tag shown.' : 'Severity tag hidden.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showGrid,
                          title: const Text('Grid overlay'),
                          subtitle: const Text('Draw scene lattice for spatial debugging.'),
                          onChanged: (bool value) {
                            setState(() {
                              showGrid = value;
                            });
                            addLog(value ? 'Grid overlay enabled.' : 'Grid overlay disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showSafeArea,
                          title: const Text('Safe area guide'),
                          subtitle: const Text('Show usable region boundary.'),
                          onChanged: (bool value) {
                            setState(() {
                              showSafeArea = value;
                            });
                            addLog(value ? 'Safe area guide enabled.' : 'Safe area guide disabled.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showKeyboard,
                          title: const Text('Keyboard inset active'),
                          subtitle: const Text('Reserve lower viewport area.'),
                          onChanged: (bool value) {
                            setState(() {
                              showKeyboard = value;
                              anchor = clampAnchor(anchor);
                              toolbarBuilds += 1;
                            });
                            addLog(value ? 'Keyboard inset activated.' : 'Keyboard inset deactivated.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: rtl,
                          title: const Text('RTL mode'),
                          subtitle: const Text('Switch scene directionality.'),
                          onChanged: (bool value) {
                            setState(() {
                              rtl = value;
                              toolbarBuilds += 1;
                            });
                            addLog(value ? 'RTL mode enabled.' : 'RTL mode disabled.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showHeatmap,
                          title: const Text('Show heatmap panel'),
                          subtitle: const Text('Visualize action density pressure.'),
                          onChanged: (bool value) {
                            setState(() {
                              showHeatmap = value;
                            });
                            addLog(value ? 'Heatmap panel shown.' : 'Heatmap panel hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showThirdScene,
                          title: const Text('Show third scene'),
                          subtitle: const Text('Enable compact comparison scene.'),
                          onChanged: (bool value) {
                            setState(() {
                              showThirdScene = value;
                            });
                            addLog(value ? 'Third scene shown.' : 'Third scene hidden.');
                          },
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
                                  toolbarBuilds += 1;
                                });
                                addLog('Anchor centered.');
                                addEvent('Probe', 'Centered anchor probe', accent);
                              },
                              child: const Text('Center Anchor'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  anchor = clampAnchor(const Offset(0, 0));
                                  toolbarBuilds += 1;
                                });
                                addLog('Top-left probe executed.');
                                addEvent('Probe', 'Top-left edge test', accent);
                              },
                              child: const Text('Top-Left Probe'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  anchor = clampAnchor(Offset(viewport.width, viewport.height));
                                  toolbarBuilds += 1;
                                });
                                addLog('Bottom-right probe executed.');
                                addEvent('Probe', 'Bottom-right edge test', accent);
                              },
                              child: const Text('Bottom-Right Probe'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                captureSnapshot('Manual capture');
                                addLog('Snapshot captured.');
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
              title: 'Toolbar Scene Gallery',
              subtitle: 'Multiple visual scenes showing direct SpellCheckSuggestionsToolbar usage in overlay-style layouts.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            scenePanel(
              title: 'Primary Editor Scene',
              subtitle: 'General-purpose editing surface with interactive toolbar anchoring.',
              panelViewport: viewport,
              panelAnchor: clamped,
              panelAccent: accent,
              allowInteract: true,
              setState: setState,
            ),
            const SizedBox(height: 12),
            scenePanel(
              title: 'Narrow Pane Scene',
              subtitle: 'Constrained width emphasizes toolbar action density and clamping.',
              panelViewport: Size(math.max(180, viewport.width * 0.62), viewport.height),
              panelAnchor: clamped,
              panelAccent: const Color(0xFF2E7D32),
              allowInteract: true,
              setState: setState,
            ),
            if (showThirdScene) ...<Widget>[
              const SizedBox(height: 12),
              scenePanel(
                title: 'Keyboard-Constrained Scene',
                subtitle: 'Reduced vertical room highlights lower-bound placement handling.',
                panelViewport: Size(viewport.width, math.max(280, viewport.height * 0.82)),
                panelAnchor: Offset(clamped.dx, clamped.dy + 40),
                panelAccent: const Color(0xFFE65100),
                allowInteract: true,
                setState: setState,
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Toolbar Inspector',
              subtitle: 'Metrics and implementation sketch for direct toolbar integration in custom overlays.',
              icon: Icons.analytics,
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
                      color: const Color(0xFF0D1321),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF26476E)),
                    ),
                    child: Text(
                      'SpellCheckSuggestionsToolbar(\n'
                      '  anchor: Offset(${fmt(clamped.dx)}, ${fmt(clamped.dy)}),\n'
                      '  buttonItems: <ContextMenuButtonItem>[...],\n'
                      ')\n\n'
                      'CustomSingleChildLayout(\n'
                      '  delegate: SpellCheckSuggestionsToolbarLayoutDelegate(anchor: ...),\n'
                      '  child: toolbar,\n'
                      ')\n\n'
                      'viewport: ${fmt(viewport.width)} x ${fmt(viewport.height)}\n'
                      'keyboardInset: ${fmt(keyboardInset)}\n'
                      'rtl: ${rtl ? 'true' : 'false'}\n'
                      'toolbarBuilds: $toolbarBuilds\n'
                      'actionPresses: $actionPresses',
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
                title: 'Action Density Heatmap',
                subtitle: 'Visual cue for how action count and anchor location can pressure placement in constrained scenes.',
                icon: Icons.blur_on,
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
                  painter: _ActionHeatmapPainter(
                    anchor: clamped,
                    viewport: viewport,
                    accent: accent,
                    actionCount: actionCount,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Guidance Cards',
              subtitle: 'Practical implementation advice for spell-check suggestion toolbars.',
              icon: Icons.menu_book,
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
              title: 'Behavior Matrix',
              subtitle: 'Reference table for toolbar behavior under edge and density constraints.',
              icon: Icons.table_chart,
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
              title: 'Snapshots',
              subtitle: 'Stored toolbar states for comparing anchor and viewport-dependent behavior.',
              icon: Icons.camera,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline',
              subtitle: 'Event stream of preset loads, probes, and toolbar action presses.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle: 'Low-level interaction trace for interpreter-side verification.',
              icon: Icons.terminal,
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
                'Summary: SpellCheckSuggestionsToolbar is the action surface for typo correction around a text anchor. '
                'This deep demo shows direct constructor usage with ContextMenuButtonItem sets, multi-viewport scene behavior, '
                'keyboard-bound constraints, RTL mode checks, and action telemetry. It provides a practical blueprint for integrating '
                'spell-check suggestion overlays in interpreter-driven Flutter applications.',
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
              '${startedAt.hour.toString().padLeft(2, '0')}:'
              '${startedAt.minute.toString().padLeft(2, '0')}:'
              '${startedAt.second.toString().padLeft(2, '0')}.',
              style: TextStyle(color: Colors.blueGrey.shade600, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    },
  );
}

class _ActionSpec {
  const _ActionSpec({
    required this.label,
    required this.type,
    required this.event,
  });

  final String label;
  final ContextMenuButtonType type;
  final String event;
}
