import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TooltipPositionContextDemo();
}

const Color _kPrimary = Color(0xFF4A148C);
const Color _kAccent = Color(0xFF26C6DA);
const Color _kSurface = Color(0xFFF3E5F5);
const Color _kCard = Colors.white;

class _TooltipPositionContextDemo extends StatefulWidget {
  const _TooltipPositionContextDemo();

  @override
  State<_TooltipPositionContextDemo> createState() =>
      _TooltipPositionContextDemoState();
}

class _TooltipPositionContextDemoState extends State<_TooltipPositionContextDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: const Text('TooltipPositionContext'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Model'),
            Tab(text: 'Position Studio'),
            Tab(text: 'Edge Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ModelTab(),
          _PositionStudioTab(),
          _EdgeCasesTab(),
        ],
      ),
    );
  }
}

class _ModelTab extends StatelessWidget {
  const _ModelTab();

  @override
  Widget build(BuildContext context) {
    const contextSample = TooltipPositionContext(
      target: Offset(220, 180),
      targetSize: Size(56, 32),
      verticalOffset: 12,
      preferBelow: true,
      tooltipSize: Size(164, 56),
      overlaySize: Size(420, 320),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _Banner(
          title: 'Position Context Anatomy',
          body:
              'TooltipPositionContext packages anchor geometry, tooltip size, '
              'overlay bounds, and direction preference into one immutable '
              'snapshot for delegate-style placement logic.',
        ),
        SizedBox(height: 12),
        _ContextCard(
          title: 'Sample Context Fields',
          contextValue: contextSample,
        ),
        SizedBox(height: 12),
        _Banner(
          title: 'Interpretation Guidelines',
          body:
              'target and targetSize describe anchor geometry; tooltipSize '
              'describes floating content; overlaySize and preferBelow shape '
              'fallback decisions near bounds.',
        ),
        SizedBox(height: 12),
        _ChecklistCard(
          lines: [
            'Keep verticalOffset large enough to avoid pointer occlusion.',
            'Clamp computed tooltip origin to overlay bounds.',
            'Use preferBelow as a preference, not an absolute mandate.',
            'Include targetSize when centering around non-point anchors.',
          ],
        ),
      ],
    );
  }
}

class _PositionStudioTab extends StatefulWidget {
  const _PositionStudioTab();

  @override
  State<_PositionStudioTab> createState() => _PositionStudioTabState();
}

class _PositionStudioTabState extends State<_PositionStudioTab> {
  Offset _target = const Offset(220, 170);
  final Size _targetSize = const Size(56, 32);
  Size _tooltipSize = const Size(164, 56);
  double _verticalOffset = 12;
  bool _preferBelow = true;

  static const Size _overlay = Size(420, 320);

  @override
  Widget build(BuildContext context) {
    final contextValue = TooltipPositionContext(
      target: _target,
      targetSize: _targetSize,
      verticalOffset: _verticalOffset,
      preferBelow: _preferBelow,
      tooltipSize: _tooltipSize,
      overlaySize: _overlay,
    );
    final result = _positionTooltip(contextValue);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _Banner(
          title: 'Interactive Position Studio',
          body:
              'Move the target and adjust dimensions to inspect how candidate '
              'tooltip positions are selected and clamped.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Layout Controls',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text('Vertical offset: ${_verticalOffset.toStringAsFixed(0)}'),
                Slider(
                  value: _verticalOffset,
                  min: 0,
                  max: 32,
                  onChanged: (value) => setState(() => _verticalOffset = value),
                ),
                Text('Tooltip width: ${_tooltipSize.width.toStringAsFixed(0)}'),
                Slider(
                  value: _tooltipSize.width,
                  min: 100,
                  max: 240,
                  onChanged: (value) =>
                      setState(() => _tooltipSize = Size(value, _tooltipSize.height)),
                ),
                Text('Tooltip height: ${_tooltipSize.height.toStringAsFixed(0)}'),
                Slider(
                  value: _tooltipSize.height,
                  min: 36,
                  max: 120,
                  onChanged: (value) =>
                      setState(() => _tooltipSize = Size(_tooltipSize.width, value)),
                ),
                FilterChip(
                  label: const Text('preferBelow'),
                  selected: _preferBelow,
                  onSelected: (value) => setState(() => _preferBelow = value),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overlay Visualization',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: _overlay.width,
                  height: _overlay.height,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _target = Offset(
                          (_target.dx + details.delta.dx).clamp(0, _overlay.width),
                          (_target.dy + details.delta.dy).clamp(0, _overlay.height),
                        );
                      });
                    },
                    child: CustomPaint(
                      painter: _TooltipStudioPainter(
                        target: _target,
                        targetSize: _targetSize,
                        tooltipSize: _tooltipSize,
                        result: result,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Decision: ${result.reason}'),
                Text(
                  'Chosen origin: ${result.origin.dx.toStringAsFixed(1)}, '
                  '${result.origin.dy.toStringAsFixed(1)}',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EdgeCasesTab extends StatelessWidget {
  const _EdgeCasesTab();

  static const List<_CaseDefinition> _cases = [
    _CaseDefinition(
      name: 'Near top edge',
      contextValue: TooltipPositionContext(
        target: Offset(200, 18),
        targetSize: Size(40, 24),
        verticalOffset: 10,
        preferBelow: false,
        tooltipSize: Size(180, 56),
        overlaySize: Size(420, 320),
      ),
    ),
    _CaseDefinition(
      name: 'Near bottom edge',
      contextValue: TooltipPositionContext(
        target: Offset(210, 302),
        targetSize: Size(40, 24),
        verticalOffset: 10,
        preferBelow: true,
        tooltipSize: Size(170, 56),
        overlaySize: Size(420, 320),
      ),
    ),
    _CaseDefinition(
      name: 'Near right edge',
      contextValue: TooltipPositionContext(
        target: Offset(410, 170),
        targetSize: Size(40, 24),
        verticalOffset: 10,
        preferBelow: true,
        tooltipSize: Size(190, 56),
        overlaySize: Size(420, 320),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _Banner(
          title: 'Edge Case Gallery',
          body:
              'Each case feeds a different TooltipPositionContext snapshot into '
              'the same placement function to verify robust fallback behavior.',
        ),
        const SizedBox(height: 12),
        for (final entry in _cases)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _EdgeCaseCard(
              definition: entry,
              result: _positionTooltip(entry.contextValue),
            ),
          ),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _ContextCard extends StatelessWidget {
  const _ContextCard({required this.title, required this.contextValue});

  final String title;
  final TooltipPositionContext contextValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('target: ${contextValue.target}'),
            Text('targetSize: ${contextValue.targetSize}'),
            Text('tooltipSize: ${contextValue.tooltipSize}'),
            Text('verticalOffset: ${contextValue.verticalOffset}'),
            Text('preferBelow: ${contextValue.preferBelow}'),
            Text('overlaySize: ${contextValue.overlaySize}'),
          ],
        ),
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 18, color: Color(0xFF2E7D32)),
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
}

class _TooltipStudioPainter extends CustomPainter {
  const _TooltipStudioPainter({
    required this.target,
    required this.targetSize,
    required this.tooltipSize,
    required this.result,
  });

  final Offset target;
  final Size targetSize;
  final Size tooltipSize;
  final _PlacementResult result;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF8EAFD);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final targetRect = Rect.fromCenter(
      center: target,
      width: targetSize.width,
      height: targetSize.height,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(targetRect, const Radius.circular(8)),
      Paint()..color = const Color(0xFF6A1B9A),
    );

    final tooltipRect = result.origin & tooltipSize;
    canvas.drawRRect(
      RRect.fromRectAndRadius(tooltipRect, const Radius.circular(10)),
      Paint()..color = const Color(0xFF00838F),
    );

    canvas.drawLine(
      target,
      Offset(tooltipRect.center.dx, tooltipRect.center.dy),
      Paint()
        ..color = const Color(0xFF424242)
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _TooltipStudioPainter oldDelegate) {
    return oldDelegate.target != target ||
        oldDelegate.targetSize != targetSize ||
        oldDelegate.tooltipSize != tooltipSize ||
        oldDelegate.result != result;
  }
}

class _EdgeCaseCard extends StatelessWidget {
  const _EdgeCaseCard({required this.definition, required this.result});

  final _CaseDefinition definition;
  final _PlacementResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(definition.name, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('target: ${definition.contextValue.target}'),
            Text('tooltipSize: ${definition.contextValue.tooltipSize}'),
            Text('preferBelow: ${definition.contextValue.preferBelow}'),
            const SizedBox(height: 6),
            Text('result: ${result.origin}'),
            Text('reason: ${result.reason}'),
          ],
        ),
      ),
    );
  }
}

class _CaseDefinition {
  const _CaseDefinition({required this.name, required this.contextValue});

  final String name;
  final TooltipPositionContext contextValue;
}

class _PlacementResult {
  const _PlacementResult({required this.origin, required this.reason});

  final Offset origin;
  final String reason;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _PlacementResult &&
        other.origin == origin &&
        other.reason == reason;
  }

  @override
  int get hashCode => Object.hash(origin, reason);
}

_PlacementResult _positionTooltip(TooltipPositionContext contextValue) {
  final targetCenterX = contextValue.target.dx;
  final halfTooltipWidth = contextValue.tooltipSize.width / 2;

  final above = Offset(
    targetCenterX - halfTooltipWidth,
    contextValue.target.dy - contextValue.verticalOffset - contextValue.tooltipSize.height,
  );
  final below = Offset(
    targetCenterX - halfTooltipWidth,
    contextValue.target.dy + contextValue.targetSize.height + contextValue.verticalOffset,
  );

  final candidate = contextValue.preferBelow ? below : above;
  final fallback = contextValue.preferBelow ? above : below;

  final candidateFits = _fits(candidate, contextValue.tooltipSize, contextValue.overlaySize);
  final raw = candidateFits ? candidate : fallback;
  final reason = candidateFits
      ? (contextValue.preferBelow ? 'preferred below fits' : 'preferred above fits')
      : 'fallback used due to edge collision';

  final clamped = Offset(
    raw.dx.clamp(0.0, math.max(0.0, contextValue.overlaySize.width - contextValue.tooltipSize.width)),
    raw.dy.clamp(0.0, math.max(0.0, contextValue.overlaySize.height - contextValue.tooltipSize.height)),
  );

  return _PlacementResult(origin: clamped, reason: reason);
}

bool _fits(Offset origin, Size tooltip, Size overlay) {
  return origin.dx >= 0 &&
      origin.dy >= 0 &&
      origin.dx + tooltip.width <= overlay.width &&
      origin.dy + tooltip.height <= overlay.height;
}
