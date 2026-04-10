import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  final ValueNotifier<int> parentAnchorIndex = ValueNotifier<int>(7);
  final ValueNotifier<int> childAnchorIndex = ValueNotifier<int>(1);
  final ValueNotifier<double> offsetX = ValueNotifier<double>(0);
  final ValueNotifier<double> offsetY = ValueNotifier<double>(8);
  final ValueNotifier<int> selectedScenario = ValueNotifier<int>(0);
  final ValueNotifier<bool> allowFlip = ValueNotifier<bool>(true);
  final ValueNotifier<bool> allowSlide = ValueNotifier<bool>(true);
  final ValueNotifier<bool> allowResize = ValueNotifier<bool>(false);
  final ValueNotifier<double> childWidth = ValueNotifier<double>(170);
  final ValueNotifier<double> childHeight = ValueNotifier<double>(110);

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6179)),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFEAF8FB), Color(0xFFFFF6EE)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          const _WindowPositionerHero(),
          const SizedBox(height: 16),
          _ScenarioStrip(
            selectedScenario: selectedScenario,
            parentAnchorIndex: parentAnchorIndex,
            childAnchorIndex: childAnchorIndex,
            offsetX: offsetX,
            offsetY: offsetY,
          ),
          const SizedBox(height: 16),
          _ControlLab(
            parentAnchorIndex: parentAnchorIndex,
            childAnchorIndex: childAnchorIndex,
            offsetX: offsetX,
            offsetY: offsetY,
            allowFlip: allowFlip,
            allowSlide: allowSlide,
            allowResize: allowResize,
            childWidth: childWidth,
            childHeight: childHeight,
          ),
          const SizedBox(height: 16),
          _ViewportSimulation(
            parentAnchorIndex: parentAnchorIndex,
            childAnchorIndex: childAnchorIndex,
            offsetX: offsetX,
            offsetY: offsetY,
            allowFlip: allowFlip,
            allowSlide: allowSlide,
            allowResize: allowResize,
            childWidth: childWidth,
            childHeight: childHeight,
          ),
          const SizedBox(height: 16),
          _UsagePatterns(
            allowFlip: allowFlip,
            allowSlide: allowSlide,
            allowResize: allowResize,
          ),
          const SizedBox(height: 16),
          const _AlgorithmWalkthrough(),
          const SizedBox(height: 16),
          const _ValidationChecklist(),
        ],
      ),
    ),
  );
}

const List<_AnchorSpec> _anchors = <_AnchorSpec>[
  _AnchorSpec('topLeft', Alignment.topLeft, 'Corner for menus and badges.'),
  _AnchorSpec('topCenter', Alignment.topCenter, 'Top midpoint for tooltips.'),
  _AnchorSpec('topRight', Alignment.topRight, 'Top-right aligned overlays.'),
  _AnchorSpec('centerLeft', Alignment.centerLeft, 'Side-linked nested flyouts.'),
  _AnchorSpec('center', Alignment.center, 'Centered dialogs and callouts.'),
  _AnchorSpec('centerRight', Alignment.centerRight, 'Right edge sidecars.'),
  _AnchorSpec('bottomLeft', Alignment.bottomLeft, 'Dropdown default origin.'),
  _AnchorSpec('bottomCenter', Alignment.bottomCenter, 'Bottom-centered sheets.'),
  _AnchorSpec('bottomRight', Alignment.bottomRight, 'Right aligned context panes.'),
];

const List<_ScenarioPreset> _presets = <_ScenarioPreset>[
  _ScenarioPreset(
    title: 'Dropdown',
    parentAnchor: 6,
    childAnchor: 0,
    offset: Offset(0, 8),
    note: 'Anchor below trigger and keep left edges aligned.',
  ),
  _ScenarioPreset(
    title: 'Tooltip Above',
    parentAnchor: 1,
    childAnchor: 7,
    offset: Offset(0, -10),
    note: 'Center tooltip while offsetting upward.',
  ),
  _ScenarioPreset(
    title: 'Context Menu',
    parentAnchor: 4,
    childAnchor: 0,
    offset: Offset(12, 12),
    note: 'Open from pointer center to top-left popup corner.',
  ),
  _ScenarioPreset(
    title: 'Right Flyout',
    parentAnchor: 5,
    childAnchor: 3,
    offset: Offset(6, 0),
    note: 'Attach nested panel to the right edge.',
  ),
];

class _WindowPositionerHero extends StatelessWidget {
  const _WindowPositionerHero();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF0A6179),
                  child: Icon(Icons.ads_click, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'WindowPositioner Deep Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WindowPositioner is an internal geometry primitive used by Flutter '
              'windowing code to attach popup surfaces to a parent anchor with '
              'optional offset and overflow correction. This demo visualizes the '
              'placement algorithm with interactive controls and simulation output.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ScenarioStrip extends StatelessWidget {
  const _ScenarioStrip({
    required this.selectedScenario,
    required this.parentAnchorIndex,
    required this.childAnchorIndex,
    required this.offsetX,
    required this.offsetY,
  });

  final ValueNotifier<int> selectedScenario;
  final ValueNotifier<int> parentAnchorIndex;
  final ValueNotifier<int> childAnchorIndex;
  final ValueNotifier<double> offsetX;
  final ValueNotifier<double> offsetY;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedScenario,
          builder: (BuildContext context, int selected, Widget? child) {
            final _ScenarioPreset preset = _presets[selected];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Scenario Presets',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (int i = 0; i < _presets.length; i++)
                      ChoiceChip(
                        selected: i == selected,
                        label: Text(_presets[i].title),
                        onSelected: (_) {
                          selectedScenario.value = i;
                          parentAnchorIndex.value = _presets[i].parentAnchor;
                          childAnchorIndex.value = _presets[i].childAnchor;
                          offsetX.value = _presets[i].offset.dx;
                          offsetY.value = _presets[i].offset.dy;
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F9FB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD1E4EA)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(preset.note),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ControlLab extends StatelessWidget {
  const _ControlLab({
    required this.parentAnchorIndex,
    required this.childAnchorIndex,
    required this.offsetX,
    required this.offsetY,
    required this.allowFlip,
    required this.allowSlide,
    required this.allowResize,
    required this.childWidth,
    required this.childHeight,
  });

  final ValueNotifier<int> parentAnchorIndex;
  final ValueNotifier<int> childAnchorIndex;
  final ValueNotifier<double> offsetX;
  final ValueNotifier<double> offsetY;
  final ValueNotifier<bool> allowFlip;
  final ValueNotifier<bool> allowSlide;
  final ValueNotifier<bool> allowResize;
  final ValueNotifier<double> childWidth;
  final ValueNotifier<double> childHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder8<int, int, double, double, bool, bool,
            bool, double>(
          first: parentAnchorIndex,
          second: childAnchorIndex,
          third: offsetX,
          fourth: offsetY,
          fifth: allowFlip,
          sixth: allowSlide,
          seventh: allowResize,
          eighth: childWidth,
          builder: (BuildContext context, int parent, int child, double dx,
              double dy, bool flip, bool slide, bool resize, double width) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Position Controls',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                _AnchorDropdown(
                  label: 'Parent anchor',
                  value: parent,
                  onChanged: (int v) => parentAnchorIndex.value = v,
                ),
                const SizedBox(height: 8),
                _AnchorDropdown(
                  label: 'Child anchor',
                  value: child,
                  onChanged: (int v) => childAnchorIndex.value = v,
                ),
                const SizedBox(height: 10),
                Text('Offset X: ${dx.toStringAsFixed(1)}'),
                Slider(
                  min: -60,
                  max: 60,
                  divisions: 120,
                  value: dx,
                  onChanged: (double v) => offsetX.value = v,
                ),
                Text('Offset Y: ${dy.toStringAsFixed(1)}'),
                Slider(
                  min: -60,
                  max: 60,
                  divisions: 120,
                  value: dy,
                  onChanged: (double v) => offsetY.value = v,
                ),
                Text('Popup width: ${width.toStringAsFixed(0)}'),
                Slider(
                  min: 110,
                  max: 260,
                  divisions: 150,
                  value: width,
                  onChanged: (double v) => childWidth.value = v,
                ),
                ValueListenableBuilder<double>(
                  valueListenable: childHeight,
                  builder: (BuildContext context, double height, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Popup height: ${height.toStringAsFixed(0)}'),
                        Slider(
                          min: 80,
                          max: 220,
                          divisions: 140,
                          value: height,
                          onChanged: (double v) => childHeight.value = v,
                        ),
                      ],
                    );
                  },
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow flip adjustment'),
                  value: flip,
                  onChanged: (bool v) => allowFlip.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow slide adjustment'),
                  value: slide,
                  onChanged: (bool v) => allowSlide.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow resize adjustment'),
                  value: resize,
                  onChanged: (bool v) => allowResize.value = v,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AnchorDropdown extends StatelessWidget {
  const _AnchorDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 120, child: Text(label)),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: value,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
            items: <DropdownMenuItem<int>>[
              for (int i = 0; i < _anchors.length; i++)
                DropdownMenuItem<int>(
                  value: i,
                  child: Text(_anchors[i].name),
                ),
            ],
            onChanged: (int? next) {
              if (next != null) {
                onChanged(next);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ViewportSimulation extends StatelessWidget {
  const _ViewportSimulation({
    required this.parentAnchorIndex,
    required this.childAnchorIndex,
    required this.offsetX,
    required this.offsetY,
    required this.allowFlip,
    required this.allowSlide,
    required this.allowResize,
    required this.childWidth,
    required this.childHeight,
  });

  final ValueNotifier<int> parentAnchorIndex;
  final ValueNotifier<int> childAnchorIndex;
  final ValueNotifier<double> offsetX;
  final ValueNotifier<double> offsetY;
  final ValueNotifier<bool> allowFlip;
  final ValueNotifier<bool> allowSlide;
  final ValueNotifier<bool> allowResize;
  final ValueNotifier<double> childWidth;
  final ValueNotifier<double> childHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder9<int, int, double, double, bool, bool,
            bool, double, double>(
          first: parentAnchorIndex,
          second: childAnchorIndex,
          third: offsetX,
          fourth: offsetY,
          fifth: allowFlip,
          sixth: allowSlide,
          seventh: allowResize,
          eighth: childWidth,
          ninth: childHeight,
          builder: (BuildContext context, int parent, int child, double dx,
              double dy, bool flip, bool slide, bool resize, double width,
              double height) {
            const Rect viewport = Rect.fromLTWH(0, 0, 360, 260);
            const Rect parentRect = Rect.fromLTWH(118, 90, 120, 54);
            final Size childSize = Size(width, height);
            final _Placement placement = _placePopup(
              viewport: viewport,
              parentRect: parentRect,
              childSize: childSize,
              parentAnchor: _anchors[parent].alignment,
              childAnchor: _anchors[child].alignment,
              offset: Offset(dx, dy),
              allowFlip: flip,
              allowSlide: slide,
              allowResize: resize,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Viewport Simulation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                AspectRatio(
                  aspectRatio: 360 / 260,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFD2E0E8)),
                      color: const Color(0xFFFAFCFE),
                    ),
                    child: CustomPaint(
                      painter: _WindowPositionPainter(
                        viewport: viewport,
                        parentRect: parentRect,
                        rawRect: placement.rawRect,
                        adjustedRect: placement.adjustedRect,
                        parentAnchor: _anchors[parent].alignment,
                        childAnchor: _anchors[child].alignment,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Placement steps: ${placement.steps.join(' -> ')}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Overflow score: ${placement.overflow.toStringAsFixed(1)} px | '
                  'final rect: ${_rectLabel(placement.adjustedRect)}',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UsagePatterns extends StatelessWidget {
  const _UsagePatterns({
    required this.allowFlip,
    required this.allowSlide,
    required this.allowResize,
  });

  final ValueNotifier<bool> allowFlip;
  final ValueNotifier<bool> allowSlide;
  final ValueNotifier<bool> allowResize;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder3<bool, bool, bool>(
          first: allowFlip,
          second: allowSlide,
          third: allowResize,
          builder: (BuildContext context, bool flip, bool slide, bool resize) {
            final List<_PatternItem> patterns = <_PatternItem>[
              const _PatternItem(
                title: 'showMenu-style context panels',
                code:
                    'parentAnchor: bottomLeft\nchildAnchor: topLeft\noffset: Offset(0, 6)',
                note: 'Great for row actions where horizontal alignment matters.',
              ),
              const _PatternItem(
                title: 'Tooltip balancing',
                code:
                    'parentAnchor: topCenter\nchildAnchor: bottomCenter\noffset: Offset(0, -8)',
                note: 'Keeps descriptive overlays centered over trigger controls.',
              ),
              const _PatternItem(
                title: 'Submenu cascades',
                code:
                    'parentAnchor: centerRight\nchildAnchor: centerLeft\noffset: Offset(4, 0)',
                note: 'Useful for desktop navigation where stacked menus expand.',
              ),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Practical Usage Deck',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: patterns
                      .map(
                        (_PatternItem item) => SizedBox(
                          width: 300,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFD5E2E8)),
                              color: const Color(0xFFF8FBFD),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFF10242A),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      item.code,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        color: Color(0xFFD2F5FF),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(item.note),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                Text(
                  'Current strategy mask: ${flip ? 'flip ' : ''}${slide ? 'slide ' : ''}${resize ? 'resize' : ''}',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AlgorithmWalkthrough extends StatelessWidget {
  const _AlgorithmWalkthrough();

  @override
  Widget build(BuildContext context) {
    const List<_StepInfo> steps = <_StepInfo>[
      _StepInfo(
        title: '1. Resolve parent anchor point',
        detail:
            'The parent rectangle and parent anchor (for example bottomLeft) '
            'produce an absolute point in viewport coordinates.',
        icon: Icons.adjust,
      ),
      _StepInfo(
        title: '2. Resolve child anchor in popup space',
        detail:
            'The popup size and child anchor identify what point of the popup '
            'must attach to the parent point.',
        icon: Icons.crop_free,
      ),
      _StepInfo(
        title: '3. Translate using offset',
        detail:
            'The user-provided offset is applied after anchor matching to create '
            'visual breathing room or directional bias.',
        icon: Icons.open_with,
      ),
      _StepInfo(
        title: '4. Apply constraint adjustments',
        detail:
            'Flip, slide, and resize policies attempt to keep the popup visible '
            'without losing relationship to the parent.',
        icon: Icons.fit_screen,
      ),
      _StepInfo(
        title: '5. Commit positioned rect',
        detail:
            'The final rectangle becomes the popup destination used by overlay '
            'or windowing infrastructure.',
        icon: Icons.check_circle,
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Algorithm Walkthrough',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 10),
            for (final _StepInfo step in steps)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD4E2E8)),
                    color: const Color(0xFFF8FBFD),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(step.icon, color: const Color(0xFF0A6179)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                step.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(step.detail),
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
    );
  }
}

class _ValidationChecklist extends StatelessWidget {
  const _ValidationChecklist();

  @override
  Widget build(BuildContext context) {
    const List<String> checks = <String>[
      'Interactive anchor pairing demonstrates parent/child attachment semantics.',
      'Scenario presets show distinct popup patterns (dropdown, tooltip, menu, flyout).',
      'Custom viewport painter visualizes raw versus adjusted rectangles.',
      'Flip/slide/resize toggles demonstrate overflow strategy impacts.',
      'Usage and algorithm panels provide instructive integration guidance.',
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
            for (final String c in checks)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.check_circle, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(c)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

_Placement _placePopup({
  required Rect viewport,
  required Rect parentRect,
  required Size childSize,
  required Alignment parentAnchor,
  required Alignment childAnchor,
  required Offset offset,
  required bool allowFlip,
  required bool allowSlide,
  required bool allowResize,
}) {
  final Offset parentPoint = _anchorPoint(parentRect, parentAnchor);
  final Rect provisional = Rect.fromLTWH(0, 0, childSize.width, childSize.height);
  final Offset childPoint = _anchorPoint(provisional, childAnchor);
  final Rect raw = provisional.shift(parentPoint - childPoint + offset);

  Rect adjusted = raw;
  final List<String> steps = <String>['anchor'];

  if (allowFlip && adjusted.bottom > viewport.bottom) {
    adjusted = adjusted.shift(Offset(0, -adjusted.height - 12));
    steps.add('flipY');
  }
  if (allowFlip && adjusted.right > viewport.right) {
    adjusted = adjusted.shift(Offset(-adjusted.width - 12, 0));
    steps.add('flipX');
  }

  if (allowSlide) {
    final double dx = _clampShift(
      min: adjusted.left,
      max: adjusted.right,
      boundMin: viewport.left,
      boundMax: viewport.right,
    );
    final double dy = _clampShift(
      min: adjusted.top,
      max: adjusted.bottom,
      boundMin: viewport.top,
      boundMax: viewport.bottom,
    );
    adjusted = adjusted.shift(Offset(dx, dy));
    steps.add('slide');
  }

  if (allowResize && adjusted.width > viewport.width) {
    adjusted = Rect.fromLTWH(
      adjusted.left,
      adjusted.top,
      viewport.width,
      adjusted.height,
    );
    steps.add('resizeX');
  }
  if (allowResize && adjusted.height > viewport.height) {
    adjusted = Rect.fromLTWH(
      adjusted.left,
      adjusted.top,
      adjusted.width,
      viewport.height,
    );
    steps.add('resizeY');
  }

  adjusted = Rect.fromLTWH(
    adjusted.left.clamp(viewport.left, viewport.right - adjusted.width),
    adjusted.top.clamp(viewport.top, viewport.bottom - adjusted.height),
    adjusted.width,
    adjusted.height,
  );
  steps.add('clamp');

  return _Placement(
    rawRect: raw,
    adjustedRect: adjusted,
    steps: steps,
    overflow: _overflow(viewport, adjusted),
  );
}

Offset _anchorPoint(Rect rect, Alignment alignment) {
  return Offset(
    rect.left + (alignment.x + 1) * rect.width / 2,
    rect.top + (alignment.y + 1) * rect.height / 2,
  );
}

double _overflow(Rect viewport, Rect rect) {
  double out = 0;
  if (rect.left < viewport.left) {
    out += viewport.left - rect.left;
  }
  if (rect.top < viewport.top) {
    out += viewport.top - rect.top;
  }
  if (rect.right > viewport.right) {
    out += rect.right - viewport.right;
  }
  if (rect.bottom > viewport.bottom) {
    out += rect.bottom - viewport.bottom;
  }
  return out;
}

double _clampShift({
  required double min,
  required double max,
  required double boundMin,
  required double boundMax,
}) {
  if (min < boundMin) {
    return boundMin - min;
  }
  if (max > boundMax) {
    return boundMax - max;
  }
  return 0;
}

String _rectLabel(Rect rect) {
  return '[x=${rect.left.toStringAsFixed(1)}, y=${rect.top.toStringAsFixed(1)}, '
      'w=${rect.width.toStringAsFixed(1)}, h=${rect.height.toStringAsFixed(1)}]';
}

class _WindowPositionPainter extends CustomPainter {
  const _WindowPositionPainter({
    required this.viewport,
    required this.parentRect,
    required this.rawRect,
    required this.adjustedRect,
    required this.parentAnchor,
    required this.childAnchor,
  });

  final Rect viewport;
  final Rect parentRect;
  final Rect rawRect;
  final Rect adjustedRect;
  final Alignment parentAnchor;
  final Alignment childAnchor;

  @override
  void paint(Canvas canvas, Size size) {
    final double sx = size.width / viewport.width;
    final double sy = size.height / viewport.height;

    Rect mapRect(Rect r) => Rect.fromLTWH(
          r.left * sx,
          r.top * sy,
          r.width * sx,
          r.height * sy,
        );

    Offset mapOffset(Offset o) => Offset(o.dx * sx, o.dy * sy);

    final Paint grid = Paint()
      ..color = const Color(0xFFE6EEF2)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += size.width / 12) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += size.height / 10) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Rect p = mapRect(parentRect);
    final Rect raw = mapRect(rawRect);
    final Rect adjusted = mapRect(adjustedRect);

    final Paint parentFill = Paint()
      ..color = const Color(0xFF2C82A0).withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    final Paint parentBorder = Paint()
      ..color = const Color(0xFF2C82A0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(RRect.fromRectAndRadius(p, const Radius.circular(10)), parentFill);
    canvas.drawRRect(RRect.fromRectAndRadius(p, const Radius.circular(10)), parentBorder);

    final Paint rawFill = Paint()
      ..color = const Color(0xFFC96B4E).withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    final Paint rawBorder = Paint()
      ..color = const Color(0xFFC96B4E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(raw, const Radius.circular(10)),
      rawFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(raw, const Radius.circular(10)),
      rawBorder,
    );

    final Paint adjustedFill = Paint()
      ..color = const Color(0xFF1E8B6D).withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    final Paint adjustedBorder = Paint()
      ..color = const Color(0xFF1E8B6D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(adjusted, const Radius.circular(10)),
      adjustedFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(adjusted, const Radius.circular(10)),
      adjustedBorder,
    );

    final Offset parentAnchorPoint = mapOffset(_anchorPoint(parentRect, parentAnchor));
    final Offset childAnchorPoint = mapOffset(_anchorPoint(adjustedRect, childAnchor));

    final Paint linkPaint = Paint()
      ..color = const Color(0xFF5D707A)
      ..strokeWidth = 1.5;
    canvas.drawLine(parentAnchorPoint, childAnchorPoint, linkPaint);

    _drawPoint(canvas, parentAnchorPoint, const Color(0xFF155D75));
    _drawPoint(canvas, childAnchorPoint, const Color(0xFF0F6A53));
    _drawArrow(canvas, raw.center, adjusted.center);
  }

  void _drawPoint(Canvas canvas, Offset point, Color color) {
    canvas.drawCircle(point, 4.3, Paint()..color = color);
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to) {
    final Paint paint = Paint()
      ..color = const Color(0xFF645E48)
      ..strokeWidth = 2;
    canvas.drawLine(from, to, paint);

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
    final Path path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF645E48));
  }

  @override
  bool shouldRepaint(covariant _WindowPositionPainter oldDelegate) {
    return oldDelegate.rawRect != rawRect ||
        oldDelegate.adjustedRect != adjustedRect ||
        oldDelegate.parentAnchor != parentAnchor ||
        oldDelegate.childAnchor != childAnchor;
  }
}

class _AnchorSpec {
  const _AnchorSpec(this.name, this.alignment, this.description);

  final String name;
  final Alignment alignment;
  final String description;
}

class _ScenarioPreset {
  const _ScenarioPreset({
    required this.title,
    required this.parentAnchor,
    required this.childAnchor,
    required this.offset,
    required this.note,
  });

  final String title;
  final int parentAnchor;
  final int childAnchor;
  final Offset offset;
  final String note;
}

class _PatternItem {
  const _PatternItem({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class _StepInfo {
  const _StepInfo({
    required this.title,
    required this.detail,
    required this.icon,
  });

  final String title;
  final String detail;
  final IconData icon;
}

class _Placement {
  const _Placement({
    required this.rawRect,
    required this.adjustedRect,
    required this.steps,
    required this.overflow,
  });

  final Rect rawRect;
  final Rect adjustedRect;
  final List<String> steps;
  final double overflow;
}

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final Widget Function(BuildContext context, A a, B b, C c) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nested) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leaf) {
                return builder(context, a, b, c);
              },
            );
          },
        );
      },
    );
  }
}

class ValueListenableBuilder8<A, B, C, D, E, F, G, H> extends StatelessWidget {
  const ValueListenableBuilder8({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.eighth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final ValueNotifier<F> sixth;
  final ValueNotifier<G> seventh;
  final ValueNotifier<H> eighth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e, F f,
      G g, H h) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nested) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leaf) {
                return ValueListenableBuilder<D>(
                  valueListenable: fourth,
                  builder: (BuildContext context, D d, Widget? deep) {
                    return ValueListenableBuilder<E>(
                      valueListenable: fifth,
                      builder: (BuildContext context, E e, Widget? deeper) {
                        return ValueListenableBuilder<F>(
                          valueListenable: sixth,
                          builder: (BuildContext context, F f, Widget? l1) {
                            return ValueListenableBuilder<G>(
                              valueListenable: seventh,
                              builder: (BuildContext context, G g, Widget? l2) {
                                return ValueListenableBuilder<H>(
                                  valueListenable: eighth,
                                  builder:
                                      (BuildContext context, H h, Widget? l3) {
                                    return builder(
                                      context,
                                      a,
                                      b,
                                      c,
                                      d,
                                      e,
                                      f,
                                      g,
                                      h,
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
              },
            );
          },
        );
      },
    );
  }
}

class ValueListenableBuilder9<A, B, C, D, E, F, G, H, I>
    extends StatelessWidget {
  const ValueListenableBuilder9({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.eighth,
    required this.ninth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final ValueNotifier<F> sixth;
  final ValueNotifier<G> seventh;
  final ValueNotifier<H> eighth;
  final ValueNotifier<I> ninth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e, F f,
      G g, H h, I i) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nested) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leaf) {
                return ValueListenableBuilder<D>(
                  valueListenable: fourth,
                  builder: (BuildContext context, D d, Widget? deep) {
                    return ValueListenableBuilder<E>(
                      valueListenable: fifth,
                      builder: (BuildContext context, E e, Widget? deeper) {
                        return ValueListenableBuilder<F>(
                          valueListenable: sixth,
                          builder: (BuildContext context, F f, Widget? l1) {
                            return ValueListenableBuilder<G>(
                              valueListenable: seventh,
                              builder: (BuildContext context, G g, Widget? l2) {
                                return ValueListenableBuilder<H>(
                                  valueListenable: eighth,
                                  builder:
                                      (BuildContext context, H h, Widget? l3) {
                                    return ValueListenableBuilder<I>(
                                      valueListenable: ninth,
                                      builder: (BuildContext context, I i,
                                          Widget? l4) {
                                        return builder(
                                          context,
                                          a,
                                          b,
                                          c,
                                          d,
                                          e,
                                          f,
                                          g,
                                          h,
                                          i,
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
