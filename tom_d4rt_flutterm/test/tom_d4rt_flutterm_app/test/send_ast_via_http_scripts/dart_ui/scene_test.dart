import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class _ScenePreset {
  const _ScenePreset({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.offsetX,
    required this.offsetY,
    required this.opacity,
    required this.rotation,
    required this.scale,
    required this.useClipRect,
    required this.useClipRRect,
    required this.useClipPath,
    required this.showBackdrop,
    required this.showOrbitLayer,
    required this.showGrid,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final double offsetX;
  final double offsetY;
  final double opacity;
  final double rotation;
  final double scale;
  final bool useClipRect;
  final bool useClipRRect;
  final bool useClipPath;
  final bool showBackdrop;
  final bool showOrbitLayer;
  final bool showGrid;
}

class _OperationEntry {
  const _OperationEntry({
    required this.label,
    required this.detail,
    required this.color,
  });

  final String label;
  final String detail;
  final Color color;
}

class _SceneBuildResult {
  const _SceneBuildResult({
    required this.scene,
    required this.operations,
  });

  final ui.Scene scene;
  final List<_OperationEntry> operations;
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();
  final List<String> logs = <String>[];
  final List<_OperationEntry> timeline = <_OperationEntry>[];

  ui.Image? renderedImage;
  int captureCount = 0;
  String captureStatus = 'No scene image captured yet.';

  double offsetX = 0;
  double offsetY = 0;
  double scale = 1.0;
  double rotation = 0.0;
  double opacity = 1.0;
  double stripeDensity = 7;
  double orbitRadius = 64;
  double starSize = 10;

  bool showBackdrop = true;
  bool showOrbitLayer = true;
  bool showGrid = true;
  bool useClipRect = false;
  bool useClipRRect = false;
  bool useClipPath = false;

  final List<_ScenePreset> presets = <_ScenePreset>[
    const _ScenePreset(
      title: 'Transform Playground',
      description:
          'Combines offset + rotation + scale. Good baseline for checking transform stack behavior.',
      color: Color(0xFF1565C0),
      icon: Icons.transform,
      offsetX: 36,
      offsetY: 14,
      opacity: 0.95,
      rotation: 0.30,
      scale: 1.15,
      useClipRect: false,
      useClipRRect: false,
      useClipPath: false,
      showBackdrop: true,
      showOrbitLayer: true,
      showGrid: true,
    ),
    const _ScenePreset(
      title: 'Clipped Card Stage',
      description:
          'Uses clip-rect and clip-rrect to demonstrate content containment and rounded clipping.',
      color: Color(0xFF2E7D32),
      icon: Icons.crop,
      offsetX: -28,
      offsetY: 20,
      opacity: 0.86,
      rotation: -0.15,
      scale: 1.0,
      useClipRect: true,
      useClipRRect: true,
      useClipPath: false,
      showBackdrop: true,
      showOrbitLayer: false,
      showGrid: true,
    ),
    const _ScenePreset(
      title: 'Path Window Showcase',
      description:
          'Adds a path clip mask and high orbit radius to verify non-rectangular layer clipping.',
      color: Color(0xFF6A1B9A),
      icon: Icons.change_history,
      offsetX: 12,
      offsetY: -24,
      opacity: 0.92,
      rotation: 0.48,
      scale: 0.94,
      useClipRect: false,
      useClipRRect: false,
      useClipPath: true,
      showBackdrop: true,
      showOrbitLayer: true,
      showGrid: false,
    ),
    const _ScenePreset(
      title: 'Minimal Lightweight Scene',
      description:
          'Near-zero effects for quick composition checks where scene complexity should stay low.',
      color: Color(0xFF00838F),
      icon: Icons.speed,
      offsetX: 0,
      offsetY: 0,
      opacity: 1,
      rotation: 0,
      scale: 1,
      useClipRect: false,
      useClipRRect: false,
      useClipPath: false,
      showBackdrop: false,
      showOrbitLayer: false,
      showGrid: false,
    ),
  ];

  void addLog(String message) {
    final Duration elapsed = DateTime.now().difference(sessionStart);
    final String row =
        '[${elapsed.inSeconds.toString().padLeft(2, '0')}s] $message';
    logs.insert(0, row);
    if (logs.length > 24) {
      logs.removeLast();
    }
  }

  ui.Picture buildBackdropPicture(Size size, Color color) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint fill = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        <Color>[color.withValues(alpha: 0.14), const Color(0xFF001D3D)],
      );
    canvas.drawRect(Offset.zero & size, fill);

    final Paint stripes = Paint()
      ..color = color.withValues(alpha: 0.26)
      ..strokeWidth = 2;
    final double spacing = math.max(8, 80 - stripeDensity * 6);
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), stripes);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = const Color(0x33FFFFFF)
        ..strokeWidth = 1;
      for (double x = 0; x <= size.width; x += 32) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += 32) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    return recorder.endRecording();
  }

  ui.Picture buildPrimaryPicture(Size size, Color color) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Rect mainRect = Rect.fromLTWH(26, 24, size.width - 52, size.height - 48);
    final Paint panel = Paint()
      ..shader = ui.Gradient.radial(
        mainRect.center,
        mainRect.shortestSide,
        <Color>[color.withValues(alpha: 0.98), color.withValues(alpha: 0.24)],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(mainRect, const Radius.circular(20)),
      panel,
    );

    final Paint border = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(mainRect, const Radius.circular(20)),
      border,
    );

    final Paint centerDot = Paint()..color = const Color(0xFFFFE082);
    canvas.drawCircle(mainRect.center, 8 + (starSize * 0.3), centerDot);

    for (int i = 0; i < 5; i++) {
      final double angle = (math.pi * 2 / 5) * i + rotation;
      final Offset p = mainRect.center + Offset(math.cos(angle), math.sin(angle)) * orbitRadius;
      final Paint marker = Paint()
        ..color = HSLColor.fromAHSL(1, (i * 55 + 30).toDouble(), 0.72, 0.62).toColor();
      canvas.drawCircle(p, starSize, marker);
      canvas.drawLine(mainRect.center, p, Paint()..color = marker.color.withValues(alpha: 0.55)..strokeWidth = 2);
    }

    final Paint labelPaint = Paint()..color = Colors.white.withValues(alpha: 0.14);
    final Rect labelRect = Rect.fromLTWH(mainRect.left + 14, mainRect.bottom - 56, mainRect.width - 28, 40);
    canvas.drawRRect(RRect.fromRectAndRadius(labelRect, const Radius.circular(12)), labelPaint);

    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(fontSize: 14, maxLines: 2, ellipsis: '...'),
    )
      ..pushStyle(ui.TextStyle(color: const Color(0xFFE3F2FD), fontWeight: ui.FontWeight.w600))
      ..addText('Scene Layer Card • rotation ${rotation.toStringAsFixed(2)} • scale ${scale.toStringAsFixed(2)}');
    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: labelRect.width - 14));
    canvas.drawParagraph(paragraph, Offset(labelRect.left + 8, labelRect.top + 10));

    return recorder.endRecording();
  }

  ui.Picture buildOrbitPicture(Size size, Color color) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = color.withValues(alpha: 0.60);

    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, 32 + i * 24, ring);
    }

    final Paint needle = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFFFF59D);
    final Offset tip = center + Offset(math.cos(rotation + 1.3), math.sin(rotation + 1.3)) * (orbitRadius + 16);
    canvas.drawLine(center, tip, needle);
    canvas.drawCircle(tip, 6, Paint()..color = const Color(0xFFFFF59D));
    return recorder.endRecording();
  }

  _SceneBuildResult buildScene(Size size, Color color) {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final List<_OperationEntry> operations = <_OperationEntry>[];

    if (showBackdrop) {
      final ui.Picture backdrop = buildBackdropPicture(size, color);
      builder.addPicture(Offset.zero, backdrop);
      operations.add(
        const _OperationEntry(
          label: 'addPicture(backdrop)',
          detail: 'Added a gradient/stripe background picture at root level.',
          color: Color(0xFF1565C0),
        ),
      );
    }

    if (useClipRect) {
      builder.pushClipRect(Rect.fromLTWH(18, 18, size.width - 36, size.height - 36));
      operations.add(
        const _OperationEntry(
          label: 'pushClipRect',
          detail: 'Clipping rectangular viewport around scene center region.',
          color: Color(0xFF2E7D32),
        ),
      );
    }

    if (useClipRRect) {
      builder.pushClipRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(26, 24, size.width - 52, size.height - 48),
          const Radius.circular(28),
        ),
      );
      operations.add(
        const _OperationEntry(
          label: 'pushClipRRect',
          detail: 'Rounded clipping path to create a card-like stage shape.',
          color: Color(0xFF00897B),
        ),
      );
    }

    if (useClipPath) {
      final Path starClip = Path();
      final Offset center = Offset(size.width / 2, size.height / 2);
      final double outer = math.min(size.width, size.height) * 0.45;
      final double inner = outer * 0.58;
      for (int i = 0; i < 10; i++) {
        final double angle = (math.pi / 5) * i - math.pi / 2;
        final double radius = i.isEven ? outer : inner;
        final Offset point = center + Offset(math.cos(angle), math.sin(angle)) * radius;
        if (i == 0) {
          starClip.moveTo(point.dx, point.dy);
        } else {
          starClip.lineTo(point.dx, point.dy);
        }
      }
      starClip.close();
      builder.pushClipPath(starClip);
      operations.add(
        const _OperationEntry(
          label: 'pushClipPath(star)',
          detail: 'Custom star-shaped clip to demonstrate arbitrary clip paths.',
          color: Color(0xFF6A1B9A),
        ),
      );
    }

    final Float64List matrix = Float64List.fromList(<double>[
      scale * math.cos(rotation),
      scale * math.sin(rotation),
      0,
      0,
      -scale * math.sin(rotation),
      scale * math.cos(rotation),
      0,
      0,
      0,
      0,
      1,
      0,
      offsetX,
      offsetY,
      0,
      1,
    ]);
    builder.pushTransform(matrix);
    operations.add(
      _OperationEntry(
        label: 'pushTransform',
        detail:
            'Applied scale ${scale.toStringAsFixed(2)}, rotation ${rotation.toStringAsFixed(2)}, offset (${offsetX.toStringAsFixed(1)}, ${offsetY.toStringAsFixed(1)}).',
        color: const Color(0xFFEF6C00),
      ),
    );

    builder.pushOpacity((opacity * 255).round().clamp(0, 255));
    operations.add(
      _OperationEntry(
        label: 'pushOpacity',
        detail: 'Layer opacity set to ${(opacity * 100).round()}%.',
        color: const Color(0xFFAD1457),
      ),
    );

    final ui.Picture primary = buildPrimaryPicture(size, color);
    builder.addPicture(Offset.zero, primary);
    operations.add(
      const _OperationEntry(
        label: 'addPicture(primary)',
        detail: 'Primary content card with orbit nodes and scene label.',
        color: Color(0xFF283593),
      ),
    );

    if (showOrbitLayer) {
      final ui.Picture orbit = buildOrbitPicture(size, color);
      builder.addPicture(Offset.zero, orbit);
      operations.add(
        const _OperationEntry(
          label: 'addPicture(orbit)',
          detail: 'Overlay orbit rings and directional needle overlay.',
          color: Color(0xFF00838F),
        ),
      );
    }

    builder.pop(); // opacity
    operations.add(
      const _OperationEntry(
        label: 'pop(opacity)',
        detail: 'Closed opacity layer scope.',
        color: Color(0xFF5D4037),
      ),
    );

    builder.pop(); // transform
    operations.add(
      const _OperationEntry(
        label: 'pop(transform)',
        detail: 'Closed transform layer scope.',
        color: Color(0xFF5D4037),
      ),
    );

    if (useClipPath) {
      builder.pop();
      operations.add(
        const _OperationEntry(
          label: 'pop(clipPath)',
          detail: 'Closed clip-path scope.',
          color: Color(0xFF5D4037),
        ),
      );
    }

    if (useClipRRect) {
      builder.pop();
      operations.add(
        const _OperationEntry(
          label: 'pop(clipRRect)',
          detail: 'Closed rounded-rect clipping scope.',
          color: Color(0xFF5D4037),
        ),
      );
    }

    if (useClipRect) {
      builder.pop();
      operations.add(
        const _OperationEntry(
          label: 'pop(clipRect)',
          detail: 'Closed rect clipping scope.',
          color: Color(0xFF5D4037),
        ),
      );
    }

    final ui.Scene scene = builder.build();
    operations.add(
      const _OperationEntry(
        label: 'build() -> Scene',
        detail: 'Finalized Scene for rasterization with toImage/toImageSync.',
        color: Color(0xFF0D47A1),
      ),
    );

    return _SceneBuildResult(scene: scene, operations: operations);
  }

  Future<void> captureAsync(void Function(void Function()) setState) async {
    const Size surface = Size(340, 260);
    final Color baseColor = HSLColor.fromAHSL(1, stripeDensity * 18, 0.78, 0.52).toColor();
    final _SceneBuildResult result = buildScene(surface, baseColor);
    addLog('Async capture started with ${result.operations.length} operations.');
    try {
      final ui.Image image = await result.scene.toImage(surface.width.toInt(), surface.height.toInt());
      result.scene.dispose();
      setState(() {
        renderedImage = image;
        captureCount++;
        captureStatus =
            'Async Scene capture #$captureCount • ${surface.width.toInt()}x${surface.height.toInt()} • operations ${result.operations.length}';
        timeline
          ..clear()
          ..addAll(result.operations);
      });
      addLog('Async capture succeeded.');
    } catch (error, stack) {
      result.scene.dispose();
      setState(() {
        captureStatus = 'Async capture failed: $error';
      });
      addLog('Async capture failed: $error');
      addLog('Stack: $stack');
    }
  }

  void captureSync(void Function(void Function()) setState) {
    const Size surface = Size(340, 260);
    final Color baseColor = HSLColor.fromAHSL(1, stripeDensity * 18, 0.78, 0.52).toColor();
    final _SceneBuildResult result = buildScene(surface, baseColor);
    addLog('Sync capture started with ${result.operations.length} operations.');
    try {
      final ui.Image image = result.scene.toImageSync(surface.width.toInt(), surface.height.toInt());
      result.scene.dispose();
      setState(() {
        renderedImage = image;
        captureCount++;
        captureStatus =
            'Sync Scene capture #$captureCount • ${surface.width.toInt()}x${surface.height.toInt()} • operations ${result.operations.length}';
        timeline
          ..clear()
          ..addAll(result.operations);
      });
      addLog('Sync capture succeeded.');
    } catch (error, stack) {
      result.scene.dispose();
      setState(() {
        captureStatus = 'Sync capture failed: $error';
      });
      addLog('Sync capture failed: $error');
      addLog('Stack: $stack');
    }
  }

  Widget sectionTitle({required String title, required String subtitle, required IconData icon}) {
    return Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Text(subtitle,
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget metricCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color.withValues(alpha: 0.88),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final Color accent = HSLColor.fromAHSL(1, stripeDensity * 18, 0.78, 0.52).toColor();
      final int activeOps =
          (showBackdrop ? 1 : 0) + (showOrbitLayer ? 1 : 0) + (useClipRect ? 1 : 0) + (useClipRRect ? 1 : 0) + (useClipPath ? 1 : 0) + 4;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF001D3D), Color(0xFF003566)],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Scene Composition Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scene is the final composited layer tree generated by SceneBuilder. '
                    'This deep demo shows how layer operations (clip, transform, opacity, pictures) are assembled '
                    'and then rasterized via toImage/toImageSync for interpreter-driven Flutter scripts.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        side: BorderSide.none,
                        avatar: const Icon(Icons.layers, color: Colors.white),
                        label: Text('Active ops: $activeOps', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        side: BorderSide.none,
                        avatar: const Icon(Icons.photo, color: Colors.white),
                        label: Text('Captures: $captureCount', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        side: BorderSide.none,
                        avatar: const Icon(Icons.speed, color: Colors.white),
                        label: Text('Opacity ${(opacity * 100).round()}%', style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Layer Control Board',
              subtitle: 'Tune SceneBuilder inputs and capture resulting Scene images.',
              icon: Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: <Widget>[
                      SizedBox(
                        width: 220,
                        child: metricCard('Offset', '${offsetX.toStringAsFixed(1)}, ${offsetY.toStringAsFixed(1)}', accent),
                      ),
                      SizedBox(
                        width: 220,
                        child: metricCard('Scale / Rotation', '${scale.toStringAsFixed(2)} / ${rotation.toStringAsFixed(2)}', accent),
                      ),
                      SizedBox(
                        width: 220,
                        child: metricCard('Opacity', '${(opacity * 100).round()}%', accent),
                      ),
                      SizedBox(
                        width: 220,
                        child: metricCard('Orbit / Star', '${orbitRadius.toStringAsFixed(1)} / ${starSize.toStringAsFixed(1)}', accent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Transform Sliders', style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w700)),
                  Slider(
                    value: offsetX,
                    min: -120,
                    max: 120,
                    label: 'offsetX ${offsetX.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => offsetX = value),
                  ),
                  Slider(
                    value: offsetY,
                    min: -120,
                    max: 120,
                    label: 'offsetY ${offsetY.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => offsetY = value),
                  ),
                  Slider(
                    value: scale,
                    min: 0.4,
                    max: 1.8,
                    label: 'scale ${scale.toStringAsFixed(2)}',
                    onChanged: (double value) => setState(() => scale = value),
                  ),
                  Slider(
                    value: rotation,
                    min: -math.pi,
                    max: math.pi,
                    label: 'rotation ${rotation.toStringAsFixed(2)}',
                    onChanged: (double value) => setState(() => rotation = value),
                  ),
                  Slider(
                    value: opacity,
                    min: 0.15,
                    max: 1,
                    label: 'opacity ${(opacity * 100).round()}%',
                    onChanged: (double value) => setState(() => opacity = value),
                  ),
                  const SizedBox(height: 8),
                  Text('Style Sliders', style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w700)),
                  Slider(
                    value: stripeDensity,
                    min: 2,
                    max: 12,
                    divisions: 10,
                    label: 'stripeDensity ${stripeDensity.toStringAsFixed(0)}',
                    onChanged: (double value) => setState(() => stripeDensity = value),
                  ),
                  Slider(
                    value: orbitRadius,
                    min: 22,
                    max: 120,
                    label: 'orbitRadius ${orbitRadius.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => orbitRadius = value),
                  ),
                  Slider(
                    value: starSize,
                    min: 4,
                    max: 24,
                    label: 'starSize ${starSize.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => starSize = value),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: <Widget>[
                      FilterChip(
                        label: const Text('Backdrop'),
                        selected: showBackdrop,
                        onSelected: (bool v) => setState(() => showBackdrop = v),
                      ),
                      FilterChip(
                        label: const Text('Orbit Layer'),
                        selected: showOrbitLayer,
                        onSelected: (bool v) => setState(() => showOrbitLayer = v),
                      ),
                      FilterChip(
                        label: const Text('Grid'),
                        selected: showGrid,
                        onSelected: (bool v) => setState(() => showGrid = v),
                      ),
                      FilterChip(
                        label: const Text('ClipRect'),
                        selected: useClipRect,
                        onSelected: (bool v) => setState(() => useClipRect = v),
                      ),
                      FilterChip(
                        label: const Text('ClipRRect'),
                        selected: useClipRRect,
                        onSelected: (bool v) => setState(() => useClipRRect = v),
                      ),
                      FilterChip(
                        label: const Text('ClipPath'),
                        selected: useClipPath,
                        onSelected: (bool v) => setState(() => useClipPath = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () async {
                          await captureAsync(setState);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Capture Async (toImage)'),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          captureSync(setState);
                        },
                        icon: const Icon(Icons.flash_on),
                        label: const Text('Capture Sync (toImageSync)'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            renderedImage = null;
                            captureStatus = 'Rendered image cleared.';
                          });
                          addLog('Cleared rendered image panel.');
                        },
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Clear Rendered Image'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Visual Comparison',
              subtitle: 'Left: conceptual preview painter. Right: actual Scene rasterization output.',
              icon: Icons.compare,
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool stacked = constraints.maxWidth < 900;
                final Widget previewCard = Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.blueGrey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Conceptual Preview', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 260,
                        child: CustomPaint(
                          painter: _ScenePreviewPainter(
                            color: accent,
                            offsetX: offsetX,
                            offsetY: offsetY,
                            rotation: rotation,
                            scale: scale,
                            showBackdrop: showBackdrop,
                            showOrbitLayer: showOrbitLayer,
                            showGrid: showGrid,
                            useClipRect: useClipRect,
                            useClipRRect: useClipRRect,
                            useClipPath: useClipPath,
                            orbitRadius: orbitRadius,
                            starSize: starSize,
                            opacity: opacity,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                final Widget renderCard = Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.blueGrey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Rendered Scene Image', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B132B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: renderedImage == null
                            ? const Center(
                                child: Text(
                                  'Capture a Scene to show rasterized output.',
                                  style: TextStyle(color: Color(0xFFD0D9FF), fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : RawImage(image: renderedImage, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                );

                if (stacked) {
                  return Column(
                    children: <Widget>[
                      previewCard,
                      const SizedBox(height: 10),
                      renderCard,
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    Expanded(child: previewCard),
                    const SizedBox(width: 10),
                    Expanded(child: renderCard),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accent.withValues(alpha: 0.28)),
              ),
              child: Text(
                captureStatus,
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Preset Scenarios',
              subtitle: 'Load curated Scene compositions that emphasize different operations.',
              icon: Icons.auto_awesome,
            ),
            const SizedBox(height: 10),
            Column(
              children: presets.map((_ScenePreset preset) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: preset.color.withValues(alpha: 0.08),
                    border: Border.all(color: preset.color.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: preset.color.withValues(alpha: 0.24),
                        ),
                        child: Icon(preset.icon, color: preset.color, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              preset.title,
                              style: TextStyle(fontWeight: FontWeight.w700, color: preset.color),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              preset.description,
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'offset(${preset.offsetX.toStringAsFixed(0)}, ${preset.offsetY.toStringAsFixed(0)}) '
                              'scale ${preset.scale.toStringAsFixed(2)} rotation ${preset.rotation.toStringAsFixed(2)} '
                              'opacity ${(preset.opacity * 100).round()}%',
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            offsetX = preset.offsetX;
                            offsetY = preset.offsetY;
                            opacity = preset.opacity;
                            rotation = preset.rotation;
                            scale = preset.scale;
                            useClipRect = preset.useClipRect;
                            useClipRRect = preset.useClipRRect;
                            useClipPath = preset.useClipPath;
                            showBackdrop = preset.showBackdrop;
                            showOrbitLayer = preset.showOrbitLayer;
                            showGrid = preset.showGrid;
                          });
                          addLog('Preset loaded: ${preset.title}');
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Load'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Operation Timeline',
              subtitle: 'Latest SceneBuilder stack used for the most recent capture.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No operations captured yet. Use Async or Sync capture to inspect the stack.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _OperationEntry> entry) {
                        final int index = entry.key;
                        final _OperationEntry operation = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: operation.color.withValues(alpha: 0.09),
                            border: Border.all(color: operation.color.withValues(alpha: 0.28)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '#${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.w800, color: operation.color),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(operation.label, style: const TextStyle(fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 3),
                                    Text(
                                      operation.detail,
                                      style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scene Feature Guide',
              subtitle: 'How Scene-level APIs are used in practical rendering pipelines.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: const Column(
                children: <Widget>[
                  _SceneGuideRow(
                    feature: 'SceneBuilder.addPicture',
                    usage:
                        'Attach pre-recorded ui.Picture layers into the scene tree. This demo uses backdrop, primary, and orbit pictures.',
                  ),
                  _SceneGuideRow(
                    feature: 'pushTransform + pop',
                    usage:
                        'Scope translation/scale/rotation to a subtree. Great for camera-like movement of grouped layers.',
                  ),
                  _SceneGuideRow(
                    feature: 'pushOpacity + pop',
                    usage:
                        'Apply subtree alpha quickly without redrawing every primitive with modified paint alpha.',
                  ),
                  _SceneGuideRow(
                    feature: 'pushClipRect / pushClipRRect / pushClipPath',
                    usage:
                        'Bound painting to geometric masks and verify clipping behavior for overlays, cards, and custom windows.',
                  ),
                  _SceneGuideRow(
                    feature: 'Scene.toImage / Scene.toImageSync',
                    usage:
                        'Rasterize the composed scene for snapshots, previews, exports, or further texture workflows.',
                  ),
                  _SceneGuideRow(
                    feature: 'Scene.dispose',
                    usage:
                        'Release scene resources after capture to avoid unnecessary memory pressure in repeated tooling loops.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostic Console',
              subtitle: 'Execution logs emitted during capture and preset actions.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
              ),
              child: logs.isEmpty
                  ? const Center(
                      child: Text(
                        'No logs yet. Capture a scene or load a preset.',
                        style: TextStyle(color: Color(0xFF9FB3D6), fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            logs[index],
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              color: Color(0xFFC8D9FF),
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Reference Snippet',
              subtitle: 'Equivalent code shape for composing and capturing a Scene.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B132B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'final ui.SceneBuilder builder = ui.SceneBuilder();\n'
                '${useClipRect ? 'builder.pushClipRect(...);\\n' : ''}'
                '${useClipRRect ? 'builder.pushClipRRect(...);\\n' : ''}'
                '${useClipPath ? 'builder.pushClipPath(...);\\n' : ''}'
                'builder.pushTransform(matrix4x4);\n'
                'builder.pushOpacity(${(opacity * 255).round()});\n'
                'builder.addPicture(Offset.zero, backdrop);\n'
                'builder.addPicture(Offset.zero, primary);\n'
                '${showOrbitLayer ? 'builder.addPicture(Offset.zero, orbit);\\n' : ''}'
                'builder.pop(); // opacity\n'
                'builder.pop(); // transform\n'
                '${useClipPath ? 'builder.pop(); // clipPath\\n' : ''}'
                '${useClipRRect ? 'builder.pop(); // clipRRect\\n' : ''}'
                '${useClipRect ? 'builder.pop(); // clipRect\\n' : ''}'
                'final ui.Scene scene = builder.build();\n'
                'final ui.Image image = await scene.toImage(340, 260);\n'
                'scene.dispose();',
                style: const TextStyle(
                  color: Color(0xFFCEE8FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
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
                'Summary: This deep demo focuses on Scene as the terminal composition object. '
                'You can experiment with the layer stack, clip scopes, transform/opacity, and picture composition, '
                'then validate results by capturing real raster output through toImage/toImageSync. '
                'Together, the panels show how Scene is used for visual debugging, preview generation, and runtime rendering verification.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _SceneGuideRow extends StatelessWidget {
  const _SceneGuideRow({
    required this.feature,
    required this.usage,
  });

  final String feature;
  final String usage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey.shade50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            feature,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            usage,
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScenePreviewPainter extends CustomPainter {
  _ScenePreviewPainter({
    required this.color,
    required this.offsetX,
    required this.offsetY,
    required this.rotation,
    required this.scale,
    required this.showBackdrop,
    required this.showOrbitLayer,
    required this.showGrid,
    required this.useClipRect,
    required this.useClipRRect,
    required this.useClipPath,
    required this.orbitRadius,
    required this.starSize,
    required this.opacity,
  });

  final Color color;
  final double offsetX;
  final double offsetY;
  final double rotation;
  final double scale;
  final bool showBackdrop;
  final bool showOrbitLayer;
  final bool showGrid;
  final bool useClipRect;
  final bool useClipRRect;
  final bool useClipPath;
  final double orbitRadius;
  final double starSize;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..color = const Color(0xFF101820)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      base,
    );

    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)));

    if (showBackdrop) {
      final Paint backdrop = Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(size.width, size.height),
          <Color>[color.withValues(alpha: 0.20), const Color(0xFF0B132B)],
        );
      canvas.drawRect(Offset.zero & size, backdrop);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = const Color(0x30FFFFFF)
        ..strokeWidth = 1;
      for (double x = 0; x <= size.width; x += 28) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += 28) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    Rect clipRect = Offset.zero & size;
    if (useClipRect) {
      clipRect = Rect.fromLTWH(20, 18, size.width - 40, size.height - 36);
      canvas.save();
      canvas.clipRect(clipRect);
    }
    if (useClipRRect) {
      final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(30, 24, size.width - 60, size.height - 48),
        const Radius.circular(24),
      );
      canvas.save();
      canvas.clipRRect(rrect);
    }
    if (useClipPath) {
      final Path clip = Path();
      final Offset center = Offset(size.width / 2, size.height / 2);
      final double outer = math.min(size.width, size.height) * 0.43;
      final double inner = outer * 0.58;
      for (int i = 0; i < 10; i++) {
        final double angle = (math.pi / 5) * i - math.pi / 2;
        final double radius = i.isEven ? outer : inner;
        final Offset p = center + Offset(math.cos(angle), math.sin(angle)) * radius;
        if (i == 0) {
          clip.moveTo(p.dx, p.dy);
        } else {
          clip.lineTo(p.dx, p.dy);
        }
      }
      clip.close();
      canvas.save();
      canvas.clipPath(clip);
    }

    canvas.save();
    canvas.translate(size.width / 2 + offsetX, size.height / 2 + offsetY);
    canvas.rotate(rotation);
    canvas.scale(scale, scale);

    final Rect card = Rect.fromCenter(center: Offset.zero, width: size.width * 0.64, height: size.height * 0.56);
    final Paint cardPaint = Paint()..color = color.withValues(alpha: opacity.clamp(0.1, 1));
    canvas.drawRRect(RRect.fromRectAndRadius(card, const Radius.circular(18)), cardPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(card, const Radius.circular(18)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white.withValues(alpha: 0.42),
    );

    final Paint center = Paint()..color = const Color(0xFFFFE082);
    canvas.drawCircle(Offset.zero, 7 + starSize * 0.22, center);

    for (int i = 0; i < 5; i++) {
      final double angle = (math.pi * 2 / 5) * i;
      final Offset p = Offset(math.cos(angle), math.sin(angle)) * orbitRadius;
      final Paint marker = Paint()
        ..color = HSLColor.fromAHSL(1, (i * 55 + 30).toDouble(), 0.76, 0.64).toColor();
      canvas.drawCircle(p, starSize, marker);
      canvas.drawLine(Offset.zero, p, Paint()..color = marker.color.withValues(alpha: 0.55)..strokeWidth = 2);
    }

    if (showOrbitLayer) {
      final Paint orbit = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF80DEEA);
      canvas.drawCircle(Offset.zero, orbitRadius + 16, orbit);
      canvas.drawCircle(Offset.zero, orbitRadius + 34, orbit);
    }

    canvas.restore();

    if (useClipPath) {
      canvas.restore();
    }
    if (useClipRRect) {
      canvas.restore();
    }
    if (useClipRect) {
      canvas.restore();
    }

    final TextPainter legend = TextPainter(
      text: TextSpan(
        text: 'offset(${offsetX.toStringAsFixed(0)}, ${offsetY.toStringAsFixed(0)}) '
            'scale ${scale.toStringAsFixed(2)} rot ${rotation.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Color(0xFFE3F2FD),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 14);
    legend.paint(canvas, const Offset(8, 8));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ScenePreviewPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offsetX != offsetX ||
        oldDelegate.offsetY != offsetY ||
        oldDelegate.rotation != rotation ||
        oldDelegate.scale != scale ||
        oldDelegate.showBackdrop != showBackdrop ||
        oldDelegate.showOrbitLayer != showOrbitLayer ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.useClipRect != useClipRect ||
        oldDelegate.useClipRRect != useClipRRect ||
        oldDelegate.useClipPath != useClipPath ||
        oldDelegate.orbitRadius != orbitRadius ||
        oldDelegate.starSize != starSize ||
        oldDelegate.opacity != opacity;
  }
}
