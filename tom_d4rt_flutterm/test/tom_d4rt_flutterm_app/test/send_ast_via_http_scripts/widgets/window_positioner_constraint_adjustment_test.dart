// ignore_for_file: avoid_print
// D4rt test script: Deep demo for WindowPositionerConstraintAdjustment concepts.
import 'dart:math' as math;

import 'package:flutter/material.dart';

const int _none = 0;
const int _slideX = 1 << 0;
const int _slideY = 1 << 1;
const int _flipX = 1 << 2;
const int _flipY = 1 << 3;
const int _resizeX = 1 << 4;
const int _resizeY = 1 << 5;

const int _slide = _slideX | _slideY;
const int _flip = _flipX | _flipY;
const int _resize = _resizeX | _resizeY;
const int _all = _slide | _flip | _resize;

const List<_AdjustmentFlagInfo> _flagInfos = <_AdjustmentFlagInfo>[
  _AdjustmentFlagInfo(
    flag: _slideX,
    title: 'slideX',
    behavior: 'Slide horizontally to keep window inside viewport.',
    color: Color(0xFF146074),
  ),
  _AdjustmentFlagInfo(
    flag: _slideY,
    title: 'slideY',
    behavior: 'Slide vertically to keep window inside viewport.',
    color: Color(0xFF146074),
  ),
  _AdjustmentFlagInfo(
    flag: _flipX,
    title: 'flipX',
    behavior: 'Mirror anchor horizontally to opposite side.',
    color: Color(0xFF865A12),
  ),
  _AdjustmentFlagInfo(
    flag: _flipY,
    title: 'flipY',
    behavior: 'Mirror anchor vertically to opposite side.',
    color: Color(0xFF865A12),
  ),
  _AdjustmentFlagInfo(
    flag: _resizeX,
    title: 'resizeX',
    behavior: 'Reduce width to satisfy horizontal constraints.',
    color: Color(0xFF7A2453),
  ),
  _AdjustmentFlagInfo(
    flag: _resizeY,
    title: 'resizeY',
    behavior: 'Reduce height to satisfy vertical constraints.',
    color: Color(0xFF7A2453),
  ),
];

const List<_AdjustmentPreset> _presets = <_AdjustmentPreset>[
  _AdjustmentPreset(
    name: 'Tooltip default',
    mask: _flipY | _slideX,
    explanation: 'Flip vertically first, then slide horizontally if needed.',
  ),
  _AdjustmentPreset(
    name: 'Context menu resilient',
    mask: _flip | _slide,
    explanation: 'Allow full axis flips and slides, keep size stable.',
  ),
  _AdjustmentPreset(
    name: 'Dropdown strict width',
    mask: _flipY | _slideX | _resizeY,
    explanation: 'Prefer side-safe placement while preserving width.',
  ),
  _AdjustmentPreset(
    name: 'Max survival',
    mask: _all,
    explanation: 'Enable all strategies to avoid clipping in constrained views.',
  ),
];

dynamic build(BuildContext context) {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  final ValueNotifier<int> selectedMask = ValueNotifier<int>(_flipY | _slideX);
  final ValueNotifier<int> selectedPreset = ValueNotifier<int>(0);
  final ValueNotifier<double> popupX = ValueNotifier<double>(260);
  final ValueNotifier<double> popupY = ValueNotifier<double>(168);
  final ValueNotifier<double> popupWidth = ValueNotifier<double>(210);
  final ValueNotifier<double> popupHeight = ValueNotifier<double>(132);
  final ValueNotifier<bool> showSimulationGrid = ValueNotifier<bool>(true);

  print('WindowPositionerConstraintAdjustment deep demo executing');
  print('Binding runtimeType: ${binding.runtimeType}');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A5667)),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFEDF9FA), Color(0xFFFFF3EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 16),
          _buildFlagLegend(),
          const SizedBox(height: 16),
          _buildBitmaskComposer(
            selectedMask: selectedMask,
            selectedPreset: selectedPreset,
          ),
          const SizedBox(height: 16),
          _buildSimulationControls(
            popupX: popupX,
            popupY: popupY,
            popupWidth: popupWidth,
            popupHeight: popupHeight,
            showSimulationGrid: showSimulationGrid,
          ),
          const SizedBox(height: 16),
          _buildSimulationCanvas(
            selectedMask: selectedMask,
            popupX: popupX,
            popupY: popupY,
            popupWidth: popupWidth,
            popupHeight: popupHeight,
            showSimulationGrid: showSimulationGrid,
          ),
          const SizedBox(height: 16),
          _buildPriorityNarrative(),
          const SizedBox(height: 16),
          _buildIntegrationNotes(),
          const SizedBox(height: 16),
          _buildChecklist(),
        ],
      ),
    ),
  );
}

Widget _buildHeader() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF0A5667),
                child: Icon(Icons.fit_screen, color: Colors.white),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'WindowPositionerConstraintAdjustment Deep Demo',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Constraint adjustment is an internal flag-driven strategy for keeping '
            'positioned windows visible. This demo models bitwise composition and '
            'simulates how flips, slides, and resizes resolve overflow.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildFlagLegend() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Flag Legend',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _flagInfos
                .map(
                  (_AdjustmentFlagInfo info) => SizedBox(
                    width: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: info.color.withValues(alpha: 0.5)),
                        color: info.color.withValues(alpha: 0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${info.title} (0x${info.flag.toRadixString(16)})',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(info.behavior),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          const Text(
            'Composite flags: slide = slideX | slideY, flip = flipX | flipY, '
            'resize = resizeX | resizeY, all = slide | flip | resize.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildBitmaskComposer({
  required ValueNotifier<int> selectedMask,
  required ValueNotifier<int> selectedPreset,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder2<int, int>(
        first: selectedMask,
        second: selectedPreset,
        builder: (BuildContext context, int mask, int presetIndex) {
          final _AdjustmentPreset preset = _presets[presetIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Bitmask Composer',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _presets.length; i++)
                    ChoiceChip(
                      selected: i == presetIndex,
                      label: Text(_presets[i].name),
                      onSelected: (_) {
                        selectedPreset.value = i;
                        selectedMask.value = _presets[i].mask;
                      },
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Preset explanation: ${preset.explanation}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _flagInfos
                    .map(
                      (_AdjustmentFlagInfo info) => FilterChip(
                        selected: _hasFlag(mask, info.flag),
                        label: Text(info.title),
                        onSelected: (_) =>
                            selectedMask.value = _toggleFlag(mask, info.flag),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD5E1E6)),
                  color: const Color(0xFFF8FBFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Current mask: 0x${mask.toRadixString(16).padLeft(2, '0')} (${mask.toRadixString(2).padLeft(6, '0')})',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('Decoded: ${_maskDescription(mask)}'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

bool _hasFlag(int mask, int flag) => (mask & flag) != _none;

int _toggleFlag(int mask, int flag) {
  if (_hasFlag(mask, flag)) {
    return mask & ~flag;
  }
  return mask | flag;
}

String _maskDescription(int mask) {
  final List<String> parts = <String>[];
  for (final _AdjustmentFlagInfo info in _flagInfos) {
    if (_hasFlag(mask, info.flag)) {
      parts.add(info.title);
    }
  }
  if (parts.isEmpty) {
    return 'none';
  }
  return parts.join(' | ');
}

Widget _buildSimulationControls({
  required ValueNotifier<double> popupX,
  required ValueNotifier<double> popupY,
  required ValueNotifier<double> popupWidth,
  required ValueNotifier<double> popupHeight,
  required ValueNotifier<bool> showSimulationGrid,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder5<double, double, double, double, bool>(
        first: popupX,
        second: popupY,
        third: popupWidth,
        fourth: popupHeight,
        fifth: showSimulationGrid,
        builder: (BuildContext context, double x, double y, double width,
            double height, bool grid) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Simulation Controls',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Show viewport grid'),
                value: grid,
                onChanged: (bool next) => showSimulationGrid.value = next,
              ),
              const SizedBox(height: 6),
              Text('Popup X: ${x.toStringAsFixed(0)}'),
              Slider(
                min: 0,
                max: 340,
                value: x,
                onChanged: (double v) => popupX.value = v,
              ),
              Text('Popup Y: ${y.toStringAsFixed(0)}'),
              Slider(
                min: 0,
                max: 240,
                value: y,
                onChanged: (double v) => popupY.value = v,
              ),
              Text('Popup Width: ${width.toStringAsFixed(0)}'),
              Slider(
                min: 80,
                max: 280,
                value: width,
                onChanged: (double v) => popupWidth.value = v,
              ),
              Text('Popup Height: ${height.toStringAsFixed(0)}'),
              Slider(
                min: 60,
                max: 190,
                value: height,
                onChanged: (double v) => popupHeight.value = v,
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildSimulationCanvas({
  required ValueNotifier<int> selectedMask,
  required ValueNotifier<double> popupX,
  required ValueNotifier<double> popupY,
  required ValueNotifier<double> popupWidth,
  required ValueNotifier<double> popupHeight,
  required ValueNotifier<bool> showSimulationGrid,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder6<int, double, double, double, double, bool>(
        first: selectedMask,
        second: popupX,
        third: popupY,
        fourth: popupWidth,
        fifth: popupHeight,
        sixth: showSimulationGrid,
        builder: (BuildContext context, int mask, double x, double y,
            double width, double height, bool grid) {
          const Rect viewport = Rect.fromLTWH(0, 0, 360, 260);
          final Rect original = Rect.fromLTWH(x, y, width, height);
          final _AdjustmentResult result =
              _simulateAdjustment(viewport: viewport, popup: original, mask: mask);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Adjustment Simulation Canvas',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 360 / 260,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFD0DFE5)),
                  ),
                  child: CustomPaint(
                    painter: _AdjustmentPainter(
                      viewport: viewport,
                      original: original,
                      adjusted: result.adjusted,
                      showGrid: grid,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Resolution pipeline: ${result.steps.join(' -> ')}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('Final rect: ${_rectString(result.adjusted)}'),
              Text('Overflow after adjustment: ${_overflowScore(viewport, result.adjusted).toStringAsFixed(1)}px'),
            ],
          );
        },
      ),
    ),
  );
}

String _rectString(Rect rect) {
  return '[x=${rect.left.toStringAsFixed(1)}, y=${rect.top.toStringAsFixed(1)}, '
      'w=${rect.width.toStringAsFixed(1)}, h=${rect.height.toStringAsFixed(1)}]';
}

double _overflowScore(Rect viewport, Rect rect) {
  double score = 0;
  if (rect.left < viewport.left) {
    score += viewport.left - rect.left;
  }
  if (rect.top < viewport.top) {
    score += viewport.top - rect.top;
  }
  if (rect.right > viewport.right) {
    score += rect.right - viewport.right;
  }
  if (rect.bottom > viewport.bottom) {
    score += rect.bottom - viewport.bottom;
  }
  return score;
}

_AdjustmentResult _simulateAdjustment({
  required Rect viewport,
  required Rect popup,
  required int mask,
}) {
  Rect current = popup;
  final List<String> steps = <String>['start'];

  if (_overflowScore(viewport, current) == 0) {
    steps.add('fits');
    return _AdjustmentResult(adjusted: current, steps: steps);
  }

  if (_hasFlag(mask, _flipY) && current.bottom > viewport.bottom) {
    current = current.shift(Offset(0, -current.height - 14));
    steps.add('flipY');
  }
  if (_hasFlag(mask, _flipX) && current.right > viewport.right) {
    current = current.shift(Offset(-current.width - 14, 0));
    steps.add('flipX');
  }

  if (_hasFlag(mask, _slideX)) {
    final double dx = _clampDelta(
      current.left,
      current.right,
      viewport.left,
      viewport.right,
    );
    current = current.shift(Offset(dx, 0));
    steps.add('slideX');
  }
  if (_hasFlag(mask, _slideY)) {
    final double dy = _clampDelta(
      current.top,
      current.bottom,
      viewport.top,
      viewport.bottom,
    );
    current = current.shift(Offset(0, dy));
    steps.add('slideY');
  }

  if (_hasFlag(mask, _resizeX) && current.width > viewport.width) {
    current = Rect.fromLTWH(
      current.left,
      current.top,
      viewport.width,
      current.height,
    );
    steps.add('resizeX');
  }
  if (_hasFlag(mask, _resizeY) && current.height > viewport.height) {
    current = Rect.fromLTWH(
      current.left,
      current.top,
      current.width,
      viewport.height,
    );
    steps.add('resizeY');
  }

  // Final hard clamp to model safe fallback.
  current = Rect.fromLTWH(
    current.left.clamp(viewport.left, viewport.right - current.width),
    current.top.clamp(viewport.top, viewport.bottom - current.height),
    current.width,
    current.height,
  );
  steps.add('finalClamp');

  return _AdjustmentResult(adjusted: current, steps: steps);
}

double _clampDelta(
  double min,
  double max,
  double boundMin,
  double boundMax,
) {
  if (min < boundMin) {
    return boundMin - min;
  }
  if (max > boundMax) {
    return boundMax - max;
  }
  return 0;
}

Widget _buildPriorityNarrative() {
  const List<_PriorityStep> order = <_PriorityStep>[
    _PriorityStep(
      title: 'Flip first',
      detail: 'Try opposite side placement to preserve target dimensions.',
      icon: Icons.flip,
    ),
    _PriorityStep(
      title: 'Slide second',
      detail: 'Translate popup within viewport bounds without changing size.',
      icon: Icons.open_with,
    ),
    _PriorityStep(
      title: 'Resize last',
      detail: 'Shrink as final fallback when geometry still overflows.',
      icon: Icons.fit_screen,
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Priority Narrative',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < order.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xFF0A5667),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFD0DFE6)),
                        color: const Color(0xFFF8FBFD),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(order[i].icon, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    order[i].title,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(order[i].detail),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildIntegrationNotes() {
  const List<_SnippetNote> snippets = <_SnippetNote>[
    _SnippetNote(
      title: 'Bitmask declaration',
      code:
          'const int behavior = flipY | slideX;\nif ((behavior & flipY) != 0) {\n  // try vertical mirror\n}',
      note: 'Canonical bitwise composition and checks.',
    ),
    _SnippetNote(
      title: 'Desktop shell bridge',
      code:
          'waylandPositioner\n  ..set_constraint_adjustment(flags)\n  ..set_anchor(anchor)',
      note: 'Window managers often expose similar constraints API.',
    ),
    _SnippetNote(
      title: 'Fallback guard',
      code:
          'if (overflow > threshold && (mask & resizeY) != 0) {\n  height = min(height, viewportHeight);\n}',
      note: 'Resize fallback prevents inaccessible menu tails.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Integration Notes',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _SnippetNote snippet in snippets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD5E1E6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snippet.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF13262C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snippet.code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD6F3FF),
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(snippet.note),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildChecklist() {
  const List<String> checklist = <String>[
    'Flags are represented as explicit bitmask constants and composites.',
    'Composer enables interactive OR toggling and preset loading.',
    'Canvas simulates adjustment sequence for overflowing popup rects.',
    'Resolution steps and final overflow score are surfaced clearly.',
    'Integration notes map conceptual flags to platform-facing workflows.',
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Demo Validation Checklist',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          for (final String line in checklist)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(line)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class _AdjustmentPainter extends CustomPainter {
  const _AdjustmentPainter({
    required this.viewport,
    required this.original,
    required this.adjusted,
    required this.showGrid,
  });

  final Rect viewport;
  final Rect original;
  final Rect adjusted;
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final double sx = size.width / viewport.width;
    final double sy = size.height / viewport.height;

    Rect map(Rect r) => Rect.fromLTWH(
          r.left * sx,
          r.top * sy,
          r.width * sx,
          r.height * sy,
        );

    if (showGrid) {
      final Paint grid = Paint()
        ..color = const Color(0xFFE3ECEF)
        ..strokeWidth = 1;
      for (double x = 0; x <= size.width; x += size.width / 12) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += size.height / 10) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Paint viewportPaint = Paint()
      ..color = const Color(0xFFB9DCE5).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, viewportPaint);

    final Rect o = map(original);
    final Rect a = map(adjusted);

    final Paint originalFill = Paint()
      ..color = const Color(0xFFC65B50).withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    final Paint originalBorder = Paint()
      ..color = const Color(0xFFC65B50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(o, const Radius.circular(8)),
      originalFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(o, const Radius.circular(8)),
      originalBorder,
    );

    final Paint adjustedFill = Paint()
      ..color = const Color(0xFF15806D).withValues(alpha: 0.26)
      ..style = PaintingStyle.fill;
    final Paint adjustedBorder = Paint()
      ..color = const Color(0xFF15806D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(a, const Radius.circular(8)),
      adjustedFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(a, const Radius.circular(8)),
      adjustedBorder,
    );

    final Paint arrow = Paint()
      ..color = const Color(0xFF5A5A5A)
      ..strokeWidth = 2;
    final Offset from = o.center;
    final Offset to = a.center;
    canvas.drawLine(from, to, arrow);
    _drawArrowHead(canvas, from, to, arrow.color);
  }

  void _drawArrowHead(Canvas canvas, Offset from, Offset to, Color color) {
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const double size = 8;
    final Offset p1 = Offset(
      to.dx - size * math.cos(angle - math.pi / 6),
      to.dy - size * math.sin(angle - math.pi / 6),
    );
    final Offset p2 = Offset(
      to.dx - size * math.cos(angle + math.pi / 6),
      to.dy - size * math.sin(angle + math.pi / 6),
    );
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final Path path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AdjustmentPainter oldDelegate) {
    return oldDelegate.original != original ||
        oldDelegate.adjusted != adjusted ||
        oldDelegate.showGrid != showGrid;
  }
}

class _AdjustmentFlagInfo {
  const _AdjustmentFlagInfo({
    required this.flag,
    required this.title,
    required this.behavior,
    required this.color,
  });

  final int flag;
  final String title;
  final String behavior;
  final Color color;
}

class _AdjustmentPreset {
  const _AdjustmentPreset({
    required this.name,
    required this.mask,
    required this.explanation,
  });

  final String name;
  final int mask;
  final String explanation;
}

class _AdjustmentResult {
  const _AdjustmentResult({required this.adjusted, required this.steps});

  final Rect adjusted;
  final List<String> steps;
}

class _PriorityStep {
  const _PriorityStep({
    required this.title,
    required this.detail,
    required this.icon,
  });

  final String title;
  final String detail;
  final IconData icon;
}

class _SnippetNote {
  const _SnippetNote({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final Widget Function(BuildContext context, A a, B b) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nestedChild) {
            return builder(context, a, b);
          },
        );
      },
    );
  }
}

class ValueListenableBuilder5<A, B, C, D, E> extends StatelessWidget {
  const ValueListenableBuilder5({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nestedChild) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leafChild) {
                return ValueListenableBuilder<D>(
                  valueListenable: fourth,
                  builder: (BuildContext context, D d, Widget? finalChild) {
                    return ValueListenableBuilder<E>(
                      valueListenable: fifth,
                      builder: (BuildContext context, E e, Widget? terminalChild) {
                        return builder(context, a, b, c, d, e);
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class ValueListenableBuilder6<A, B, C, D, E, F> extends StatelessWidget {
  const ValueListenableBuilder6({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final ValueNotifier<F> sixth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e, F f)
      builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nestedChild) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leafChild) {
                return ValueListenableBuilder<D>(
                  valueListenable: fourth,
                  builder: (BuildContext context, D d, Widget? finalChild) {
                    return ValueListenableBuilder<E>(
                      valueListenable: fifth,
                      builder: (BuildContext context, E e, Widget? terminalChild) {
                        return ValueListenableBuilder<F>(
                          valueListenable: sixth,
                          builder: (BuildContext context, F f, Widget? lastChild) {
                            return builder(context, a, b, c, d, e, f);
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
