// ignore_for_file: avoid_print
// D4rt test script: Deep demo for WindowPositionerAnchor (internal concept).
import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_AnchorPoint> _anchorPoints = <_AnchorPoint>[
  _AnchorPoint('topLeft', Alignment.topLeft, 'Parent top-left corner.'),
  _AnchorPoint('top', Alignment.topCenter, 'Parent top edge midpoint.'),
  _AnchorPoint('topRight', Alignment.topRight, 'Parent top-right corner.'),
  _AnchorPoint('left', Alignment.centerLeft, 'Parent left edge midpoint.'),
  _AnchorPoint('center', Alignment.center, 'Parent rectangle center point.'),
  _AnchorPoint('right', Alignment.centerRight, 'Parent right edge midpoint.'),
  _AnchorPoint('bottomLeft', Alignment.bottomLeft, 'Parent bottom-left corner.'),
  _AnchorPoint('bottom', Alignment.bottomCenter, 'Parent bottom edge midpoint.'),
  _AnchorPoint(
    'bottomRight',
    Alignment.bottomRight,
    'Parent bottom-right corner.',
  ),
];

const List<_AnchorScenario> _scenarios = <_AnchorScenario>[
  _AnchorScenario(
    title: 'Dropdown below trigger',
    parentAnchorName: 'bottomLeft',
    childAnchorName: 'topLeft',
    offset: Offset(0, 8),
    rationale: 'Keeps left edges aligned while opening downward.',
  ),
  _AnchorScenario(
    title: 'Tooltip above control',
    parentAnchorName: 'topCenter',
    childAnchorName: 'bottomCenter',
    offset: Offset(0, -6),
    rationale: 'Centers tooltip while avoiding overlap with trigger.',
  ),
  _AnchorScenario(
    title: 'Context menu at cursor',
    parentAnchorName: 'center',
    childAnchorName: 'topLeft',
    offset: Offset(10, 10),
    rationale: 'Menu grows down and right from pointer region.',
  ),
  _AnchorScenario(
    title: 'Right-side flyout',
    parentAnchorName: 'centerRight',
    childAnchorName: 'centerLeft',
    offset: Offset(6, 0),
    rationale: 'Useful for nested navigation menus.',
  ),
  _AnchorScenario(
    title: 'Pinned status panel',
    parentAnchorName: 'topRight',
    childAnchorName: 'topRight',
    offset: Offset(-12, 12),
    rationale: 'Keeps compact panel near global action controls.',
  ),
];

dynamic build(BuildContext context) {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  final ValueNotifier<int> selectedParentAnchor = ValueNotifier<int>(7);
  final ValueNotifier<int> selectedChildAnchor = ValueNotifier<int>(1);
  final ValueNotifier<double> offsetX = ValueNotifier<double>(0);
  final ValueNotifier<double> offsetY = ValueNotifier<double>(8);
  final ValueNotifier<int> selectedScenario = ValueNotifier<int>(0);
  final ValueNotifier<bool> snapOffset = ValueNotifier<bool>(true);

  print('WindowPositionerAnchor deep demo executing');
  print('Binding runtimeType: ${binding.runtimeType}');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00536A)),
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
          colors: <Color>[Color(0xFFE9F5FA), Color(0xFFFFF6EE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 16),
          _buildAnchorReferenceGrid(),
          const SizedBox(height: 16),
          _buildScenarioSelector(
            selectedScenario: selectedScenario,
            selectedParentAnchor: selectedParentAnchor,
            selectedChildAnchor: selectedChildAnchor,
            offsetX: offsetX,
            offsetY: offsetY,
          ),
          const SizedBox(height: 16),
          _buildAnchorControlPanel(
            selectedParentAnchor: selectedParentAnchor,
            selectedChildAnchor: selectedChildAnchor,
            offsetX: offsetX,
            offsetY: offsetY,
            snapOffset: snapOffset,
          ),
          const SizedBox(height: 16),
          _buildGeometryCanvas(
            selectedParentAnchor: selectedParentAnchor,
            selectedChildAnchor: selectedChildAnchor,
            offsetX: offsetX,
            offsetY: offsetY,
          ),
          const SizedBox(height: 16),
          _buildPracticalCases(),
          const SizedBox(height: 16),
          _buildEdgeHandlingNotes(),
          const SizedBox(height: 16),
          _buildValidationChecklist(),
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
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF00536A),
                child: Icon(Icons.control_camera, color: Colors.white),
              ),
              Text(
                'WindowPositionerAnchor Deep Demo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'WindowPositionerAnchor is an internal anchor model used by window '
            'positioning logic. This demo visualizes parent/child anchor matching '
            'and offset behavior for popup-like surfaces.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildAnchorReferenceGrid() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Anchor Reference Matrix',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _anchorPoints.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              final _AnchorPoint anchor = _anchorPoints[index];
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD3E0E8)),
                  color: const Color(0xFFF9FCFE),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        anchor.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        anchor.description,
                        style: const TextStyle(fontSize: 12),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildScenarioSelector({
  required ValueNotifier<int> selectedScenario,
  required ValueNotifier<int> selectedParentAnchor,
  required ValueNotifier<int> selectedChildAnchor,
  required ValueNotifier<double> offsetX,
  required ValueNotifier<double> offsetY,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedScenario,
        builder: (BuildContext context, int scenarioIndex, Widget? child) {
          final _AnchorScenario scenario = _scenarios[scenarioIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Scenario Presets',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _scenarios.length; i++)
                    FilterChip(
                      selected: i == scenarioIndex,
                      label: Text(_scenarios[i].title),
                      onSelected: (_) {
                        selectedScenario.value = i;
                        _applyScenario(
                          _scenarios[i],
                          selectedParentAnchor,
                          selectedChildAnchor,
                          offsetX,
                          offsetY,
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD0DFE8)),
                  color: const Color(0xFFF7FBFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        scenario.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text('Parent anchor: ${scenario.parentAnchorName}'),
                      Text('Child anchor: ${scenario.childAnchorName}'),
                      Text(
                        'Offset: (${scenario.offset.dx.toStringAsFixed(1)}, ${scenario.offset.dy.toStringAsFixed(1)})',
                      ),
                      const SizedBox(height: 4),
                      Text(scenario.rationale),
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

void _applyScenario(
  _AnchorScenario scenario,
  ValueNotifier<int> selectedParentAnchor,
  ValueNotifier<int> selectedChildAnchor,
  ValueNotifier<double> offsetX,
  ValueNotifier<double> offsetY,
) {
  selectedParentAnchor.value = _resolveAnchorIndex(scenario.parentAnchorName);
  selectedChildAnchor.value = _resolveAnchorIndex(scenario.childAnchorName);
  offsetX.value = scenario.offset.dx;
  offsetY.value = scenario.offset.dy;
}

Widget _buildAnchorControlPanel({
  required ValueNotifier<int> selectedParentAnchor,
  required ValueNotifier<int> selectedChildAnchor,
  required ValueNotifier<double> offsetX,
  required ValueNotifier<double> offsetY,
  required ValueNotifier<bool> snapOffset,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder5<int, int, double, double, bool>(
        first: selectedParentAnchor,
        second: selectedChildAnchor,
        third: offsetX,
        fourth: offsetY,
        fifth: snapOffset,
        builder: (BuildContext context, int parent, int child, double dx,
            double dy, bool snap) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Anchor Controls',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              _AnchorDropdown(
                title: 'Parent anchor',
                value: parent,
                onChanged: (int value) => selectedParentAnchor.value = value,
              ),
              const SizedBox(height: 8),
              _AnchorDropdown(
                title: 'Child anchor',
                value: child,
                onChanged: (int value) => selectedChildAnchor.value = value,
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Snap offsets to 2px increments'),
                value: snap,
                onChanged: (bool next) => snapOffset.value = next,
              ),
              const SizedBox(height: 6),
              Text('Offset X: ${dx.toStringAsFixed(1)}'),
              Slider(
                min: -40,
                max: 40,
                value: dx,
                divisions: 80,
                onChanged: (double v) {
                  offsetX.value = snap ? _snap(v, 2) : v;
                },
              ),
              Text('Offset Y: ${dy.toStringAsFixed(1)}'),
              Slider(
                min: -40,
                max: 40,
                value: dy,
                divisions: 80,
                onChanged: (double v) {
                  offsetY.value = snap ? _snap(v, 2) : v;
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}

double _snap(double value, int step) {
  final double s = step.toDouble();
  return (value / s).round() * s;
}

Widget _buildGeometryCanvas({
  required ValueNotifier<int> selectedParentAnchor,
  required ValueNotifier<int> selectedChildAnchor,
  required ValueNotifier<double> offsetX,
  required ValueNotifier<double> offsetY,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder4<int, int, double, double>(
        first: selectedParentAnchor,
        second: selectedChildAnchor,
        third: offsetX,
        fourth: offsetY,
        builder: (BuildContext context, int parent, int child, double dx,
            double dy) {
          final _AnchorPoint parentAnchor = _anchorPoints[parent];
          final _AnchorPoint childAnchor = _anchorPoints[child];
          final String summary = _buildSummary(parentAnchor, childAnchor, dx, dy);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Geometry Canvas',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 1.7,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFD1DEE5)),
                    color: const Color(0xFFF9FCFE),
                  ),
                  child: CustomPaint(
                    painter: _AnchorGeometryPainter(
                      parentAlignment: parentAnchor.alignment,
                      childAlignment: childAnchor.alignment,
                      offset: Offset(dx, dy),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(summary),
            ],
          );
        },
      ),
    ),
  );
}

String _buildSummary(
  _AnchorPoint parent,
  _AnchorPoint child,
  double dx,
  double dy,
) {
  final String horizontal = dx == 0
      ? 'no horizontal translation'
      : dx > 0
          ? 'shift right by ${dx.toStringAsFixed(1)}px'
          : 'shift left by ${dx.abs().toStringAsFixed(1)}px';
  final String vertical = dy == 0
      ? 'no vertical translation'
      : dy > 0
          ? 'shift down by ${dy.toStringAsFixed(1)}px'
          : 'shift up by ${dy.abs().toStringAsFixed(1)}px';
  return 'Attach child ${child.name} to parent ${parent.name}, then apply '
      '$horizontal and $vertical.';
}

Widget _buildPracticalCases() {
  const List<_CaseNote> cases = <_CaseNote>[
    _CaseNote(
      title: 'Desktop context menus',
      detail: 'Anchor to pointer hotspot and use topLeft child anchor to grow down.',
      warning: 'Apply constraint adjustment when near screen bounds.',
    ),
    _CaseNote(
      title: 'Hover tooltips',
      detail: 'Anchor tooltip bottomCenter to control topCenter for balanced display.',
      warning: 'Flip vertically when there is no room above.',
    ),
    _CaseNote(
      title: 'Multi-level menus',
      detail: 'Anchor child centerLeft to parent centerRight for seamless flyouts.',
      warning: 'Track viewport edges to avoid clipping deep chains.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Practical Cases',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _CaseNote c in cases)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD3E0E8)),
                  color: const Color(0xFFF8FBFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        c.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(c.detail),
                      const SizedBox(height: 4),
                      Text(
                        'Caution: ${c.warning}',
                        style: const TextStyle(
                          color: Color(0xFF5A4545),
                          fontWeight: FontWeight.w600,
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

Widget _buildEdgeHandlingNotes() {
  const List<_SnippetItem> snippets = <_SnippetItem>[
    _SnippetItem(
      title: 'Anchor equation sketch',
      code:
          'final anchorPoint = parentRect.alignedPoint(parentAnchor);\nfinal childPoint = childRect.alignedPoint(childAnchor);\nfinal positionedChild = anchorPoint - childPoint + offset;',
      note: 'Core equation for translating child based on anchor match.',
    ),
    _SnippetItem(
      title: 'Viewport clamp pass',
      code:
          'if (positionedChild.right > viewport.right) {\n  positionedChild = positionedChild.shift(Offset(viewport.right - positionedChild.right, 0));\n}',
      note: 'Slide strategy keeps panel visible without resizing.',
    ),
    _SnippetItem(
      title: 'Mirror fallback',
      code:
          'if (!fitsBelow) {\n  parentAnchor = topCenter;\n  childAnchor = bottomCenter;\n}',
      note: 'Flip strategy preserves relationship while changing side.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Constraint and Edge Notes',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _SnippetItem snippet in snippets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD6E1E8)),
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
                          color: const Color(0xFF12272E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snippet.code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD5F3FF),
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

Widget _buildValidationChecklist() {
  const List<String> items = <String>[
    'All nine conceptual anchor points are documented and visible in matrix.',
    'Scenario presets automatically reconfigure parent/child and offset values.',
    'Control panel allows fine tuning with optional offset snapping.',
    'Canvas visualizes anchor attachment and translated child rectangle.',
    'Practical notes map anchor concepts to common popup use cases.',
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
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

int _resolveAnchorIndex(String name) {
  for (int i = 0; i < _anchorPoints.length; i++) {
    if (_anchorPoints[i].name == name) {
      return i;
    }
  }

  switch (name) {
    case 'topCenter':
      return 1;
    case 'centerLeft':
      return 3;
    case 'centerRight':
      return 5;
    case 'bottomCenter':
      return 7;
    default:
      return 4;
  }
}

class _AnchorDropdown extends StatelessWidget {
  const _AnchorDropdown({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 116, child: Text(title)),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: value,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
            items: <DropdownMenuItem<int>>[
              for (int i = 0; i < _anchorPoints.length; i++)
                DropdownMenuItem<int>(
                  value: i,
                  child: Text(_anchorPoints[i].name),
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

class _AnchorGeometryPainter extends CustomPainter {
  const _AnchorGeometryPainter({
    required this.parentAlignment,
    required this.childAlignment,
    required this.offset,
  });

  final Alignment parentAlignment;
  final Alignment childAlignment;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect parentRect = Rect.fromLTWH(
      size.width * 0.14,
      size.height * 0.2,
      size.width * 0.38,
      size.height * 0.5,
    );
    final Size childSize = Size(size.width * 0.26, size.height * 0.26);

    final Offset parentAnchorPoint = _alignmentToPoint(parentRect, parentAlignment);
    final Rect provisionalChildRect = Rect.fromCenter(
      center: parentAnchorPoint,
      width: childSize.width,
      height: childSize.height,
    );
    final Offset childAnchorPoint =
        _alignmentToPoint(provisionalChildRect, childAlignment);
    final Offset translation = parentAnchorPoint - childAnchorPoint + offset;
    final Rect childRect = provisionalChildRect.shift(translation);

    final Paint parentPaint = Paint()
      ..color = const Color(0xFF2E86A8).withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final Paint parentBorder = Paint()
      ..color = const Color(0xFF2E86A8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint childPaint = Paint()
      ..color = const Color(0xFFC66A25).withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final Paint childBorder = Paint()
      ..color = const Color(0xFFC66A25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(parentRect, const Radius.circular(12)),
      parentPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(parentRect, const Radius.circular(12)),
      parentBorder,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(childRect, const Radius.circular(10)),
      childPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(childRect, const Radius.circular(10)),
      childBorder,
    );

    final Offset resolvedChildAnchor = _alignmentToPoint(childRect, childAlignment);

    final Paint guidePaint = Paint()
      ..color = const Color(0xFF6C7F8A)
      ..strokeWidth = 1.4;
    canvas.drawLine(parentAnchorPoint, resolvedChildAnchor, guidePaint);

    _drawPoint(canvas, parentAnchorPoint, const Color(0xFF1D6D8B));
    _drawPoint(canvas, resolvedChildAnchor, const Color(0xFFAA4E0A));

    final Paint arrowPaint = Paint()
      ..color = const Color(0xFF7C6B00)
      ..strokeWidth = 2.2;
    final Offset arrowStart = resolvedChildAnchor;
    final Offset arrowEnd = resolvedChildAnchor + offset;
    canvas.drawLine(arrowStart, arrowEnd, arrowPaint);
    _drawArrowHead(canvas, arrowStart, arrowEnd, arrowPaint.color);

    final TextPainter parentLabel = TextPainter(
      text: const TextSpan(
        text: 'P',
        style: TextStyle(
          color: Color(0xFF1D6D8B),
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    parentLabel.paint(canvas, parentAnchorPoint + const Offset(6, -18));

    final TextPainter childLabel = TextPainter(
      text: const TextSpan(
        text: 'C',
        style: TextStyle(
          color: Color(0xFFAA4E0A),
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    childLabel.paint(canvas, resolvedChildAnchor + const Offset(6, -18));
  }

  Offset _alignmentToPoint(Rect rect, Alignment alignment) {
    return Offset(
      rect.left + (alignment.x + 1) / 2 * rect.width,
      rect.top + (alignment.y + 1) / 2 * rect.height,
    );
  }

  void _drawPoint(Canvas canvas, Offset point, Color color) {
    final Paint p = Paint()..color = color;
    canvas.drawCircle(point, 4.4, p);
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
  bool shouldRepaint(covariant _AnchorGeometryPainter oldDelegate) {
    return oldDelegate.parentAlignment != parentAlignment ||
        oldDelegate.childAlignment != childAlignment ||
        oldDelegate.offset != offset;
  }
}

class _AnchorPoint {
  const _AnchorPoint(this.name, this.alignment, this.description);

  final String name;
  final Alignment alignment;
  final String description;
}

class _AnchorScenario {
  const _AnchorScenario({
    required this.title,
    required this.parentAnchorName,
    required this.childAnchorName,
    required this.offset,
    required this.rationale,
  });

  final String title;
  final String parentAnchorName;
  final String childAnchorName;
  final Offset offset;
  final String rationale;
}

class _CaseNote {
  const _CaseNote({
    required this.title,
    required this.detail,
    required this.warning,
  });

  final String title;
  final String detail;
  final String warning;
}

class _SnippetItem {
  const _SnippetItem({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class ValueListenableBuilder4<A, B, C, D> extends StatelessWidget {
  const ValueListenableBuilder4({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final Widget Function(BuildContext context, A a, B b, C c, D d) builder;

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
                    return builder(context, a, b, c, d);
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
