import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TooltipWindowDeepDemo();
}

const Color _kPrimary = Color(0xFF1A237E);
const Color _kAccent = Color(0xFF26A69A);
const Color _kSurface = Color(0xFFE8EAF6);
const Color _kPanel = Colors.white;

class _TooltipWindowDeepDemo extends StatefulWidget {
  const _TooltipWindowDeepDemo();

  @override
  State<_TooltipWindowDeepDemo> createState() => _TooltipWindowDeepDemoState();
}

class _TooltipWindowDeepDemoState extends State<_TooltipWindowDeepDemo>
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
        title: const Text('TooltipWindow Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Architecture'),
            Tab(text: 'Positioning Lab'),
            Tab(text: 'Lifecycle Policies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ArchitectureTab(),
          _PositioningLabTab(),
          _LifecyclePoliciesTab(),
        ],
      ),
    );
  }
}

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'What TooltipWindow Adds',
          body:
              'TooltipWindow models tooltip content in a distinct window layer '
              'instead of in-process overlay only. This is useful when clipping, '
              'z-order, or multi-window constraints need explicit handling.',
        ),
        SizedBox(height: 12),
        _TopicCard(
          title: 'Window Composition',
          points: [
            'Source widget emits hover/focus trigger.',
            'Controller delegates creation and placement.',
            'Window surface hosts tooltip content and transitions.',
            'Dismiss paths include timeout, pointer exit, and explicit hide.',
          ],
          color: Color(0xFF1565C0),
        ),
        _TopicCard(
          title: 'Why not plain overlay?',
          points: [
            'Overlay may be clipped by route or view constraints.',
            'Cross-window affordances can require independent surfaces.',
            'Desktop interactions often need richer z-order behavior.',
            'Tooling can inspect lifecycle events at window granularity.',
          ],
          color: Color(0xFF2E7D32),
        ),
        _TopicCard(
          title: 'Implementation guardrails',
          points: [
            'Treat windowing capability checks as first-class gating logic.',
            'Define predictable fallback when windowing is unavailable.',
            'Ensure accessibility labels remain attached to tooltip content.',
            'Provide deterministic close reasons for diagnostics.',
          ],
          color: Color(0xFF6A1B9A),
        ),
        SizedBox(height: 12),
        _PipelineCard(),
      ],
    );
  }
}

class _PositioningLabTab extends StatefulWidget {
  const _PositioningLabTab();

  @override
  State<_PositioningLabTab> createState() => _PositioningLabTabState();
}

class _PositioningLabTabState extends State<_PositioningLabTab> {
  Offset _anchor = const Offset(220, 150);
  Size _tooltipSize = const Size(190, 64);
  bool _preferBelow = true;
  double _offset = 12;
  bool _pinToViewport = true;

  static const Size _viewport = Size(460, 320);

  @override
  Widget build(BuildContext context) {
    final request = _PositionRequest(
      anchor: _anchor,
      tooltipSize: _tooltipSize,
      preferBelow: _preferBelow,
      offset: _offset,
      viewport: _viewport,
      pinToViewport: _pinToViewport,
    );
    final result = _resolvePosition(request);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Positioning Playground',
          body:
              'Drag the anchor and tune constraints to observe how windowed '
              'tooltip placement resolves collisions and preserves visibility.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Controls', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                FilterChip(
                  label: const Text('preferBelow'),
                  selected: _preferBelow,
                  onSelected: (value) => setState(() => _preferBelow = value),
                ),
                const SizedBox(height: 6),
                FilterChip(
                  label: const Text('pinToViewport'),
                  selected: _pinToViewport,
                  onSelected: (value) => setState(() => _pinToViewport = value),
                ),
                const SizedBox(height: 8),
                Text('Offset: ${_offset.toStringAsFixed(0)}'),
                Slider(
                  value: _offset,
                  min: 0,
                  max: 36,
                  onChanged: (value) => setState(() => _offset = value),
                ),
                Text('Tooltip width: ${_tooltipSize.width.toStringAsFixed(0)}'),
                Slider(
                  value: _tooltipSize.width,
                  min: 120,
                  max: 260,
                  onChanged: (value) =>
                      setState(() => _tooltipSize = Size(value, _tooltipSize.height)),
                ),
                Text('Tooltip height: ${_tooltipSize.height.toStringAsFixed(0)}'),
                Slider(
                  value: _tooltipSize.height,
                  min: 44,
                  max: 120,
                  onChanged: (value) =>
                      setState(() => _tooltipSize = Size(_tooltipSize.width, value)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Canvas', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SizedBox(
                  width: _viewport.width,
                  height: _viewport.height,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _anchor = Offset(
                          (_anchor.dx + details.delta.dx).clamp(0, _viewport.width),
                          (_anchor.dy + details.delta.dy).clamp(0, _viewport.height),
                        );
                      });
                    },
                    child: CustomPaint(
                      painter: _TooltipCanvasPainter(
                        request: request,
                        result: result,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Chosen origin: ${result.origin.dx.toStringAsFixed(1)}, ${result.origin.dy.toStringAsFixed(1)}'),
                Text('Placement reason: ${result.reason}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LifecyclePoliciesTab extends StatefulWidget {
  const _LifecyclePoliciesTab();

  @override
  State<_LifecyclePoliciesTab> createState() => _LifecyclePoliciesTabState();
}

class _LifecyclePoliciesTabState extends State<_LifecyclePoliciesTab> {
  bool _windowingEnabled = true;
  bool _pointerInside = false;
  bool _focusActive = true;
  _TooltipPhase _phase = _TooltipPhase.idle;
  int _openCount = 0;
  int _dismissCount = 0;
  final List<String> _log = ['Policy engine initialized'];

  void _append(String line) {
    setState(() {
      _log.add(line);
      if (_log.length > 32) {
        _log.removeAt(0);
      }
    });
  }

  void _triggerShow() {
    if (!_windowingEnabled) {
      setState(() => _phase = _TooltipPhase.blocked);
      _append('show denied: windowing disabled');
      return;
    }
    if (!_focusActive) {
      setState(() => _phase = _TooltipPhase.pending);
      _append('show deferred: focus inactive');
      return;
    }
    setState(() {
      _phase = _TooltipPhase.visible;
      _openCount += 1;
    });
    _append('tooltip window shown');
  }

  void _triggerDismiss() {
    if (_phase == _TooltipPhase.idle) {
      _append('dismiss ignored: already idle');
      return;
    }
    setState(() {
      _phase = _TooltipPhase.idle;
      _dismissCount += 1;
    });
    _append('tooltip dismissed by policy');
  }

  @override
  Widget build(BuildContext context) {
    final descriptor = _phaseMessage(_phase);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Lifecycle Policy Simulator',
          body:
              'This panel demonstrates how TooltipWindow policies react to '
              'capability checks, focus changes, and pointer state.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Inputs', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('windowingEnabled'),
                      selected: _windowingEnabled,
                      onSelected: (value) => setState(() => _windowingEnabled = value),
                    ),
                    FilterChip(
                      label: const Text('focusActive'),
                      selected: _focusActive,
                      onSelected: (value) => setState(() => _focusActive = value),
                    ),
                    FilterChip(
                      label: const Text('pointerInside'),
                      selected: _pointerInside,
                      onSelected: (value) {
                        setState(() => _pointerInside = value);
                        _append(value ? 'pointer entered target' : 'pointer left target');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _triggerShow, child: const Text('Show Window')),
                    OutlinedButton(onPressed: _triggerDismiss, child: const Text('Dismiss Window')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('State Overview', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 180,
                  child: _StateBoard(
                    phase: _phase,
                    openCount: _openCount,
                    dismissCount: _dismissCount,
                    pointerInside: _pointerInside,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Phase: ${descriptor.title}'),
                Text(descriptor.details),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Policy Log', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final line in _log)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $line'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kPanel,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.title,
    required this.points,
    required this.color,
  });

  final String title;
  final List<String> points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: _kPanel,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 8),
              for (final point in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $point'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PipelineCard extends StatelessWidget {
  const _PipelineCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kPanel,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('TooltipWindow Pipeline', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            _FlowRow(step: 'Trigger', detail: 'Pointer/focus event requests tooltip display.'),
            _FlowArrow(),
            _FlowRow(step: 'Resolve', detail: 'Position and policy constraints are evaluated.'),
            _FlowArrow(),
            _FlowRow(step: 'Render', detail: 'Window host displays tooltip surface.'),
            _FlowArrow(),
            _FlowRow(step: 'Dismiss', detail: 'Timeout or explicit hide closes tooltip window.'),
          ],
        ),
      ),
    );
  }
}

class _FlowRow extends StatelessWidget {
  const _FlowRow({required this.step, required this.detail});

  final String step;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFC5CAE9),
          ),
          child: Text(step, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(detail)),
      ],
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Icon(Icons.south, color: Color(0xFF5C6BC0), size: 18),
    );
  }
}

class _PositionRequest {
  const _PositionRequest({
    required this.anchor,
    required this.tooltipSize,
    required this.preferBelow,
    required this.offset,
    required this.viewport,
    required this.pinToViewport,
  });

  final Offset anchor;
  final Size tooltipSize;
  final bool preferBelow;
  final double offset;
  final Size viewport;
  final bool pinToViewport;
}

class _PositionResult {
  const _PositionResult({
    required this.origin,
    required this.reason,
  });

  final Offset origin;
  final String reason;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _PositionResult && other.origin == origin && other.reason == reason;
  }

  @override
  int get hashCode => Object.hash(origin, reason);
}

_PositionResult _resolvePosition(_PositionRequest request) {
  final below = Offset(
    request.anchor.dx - request.tooltipSize.width / 2,
    request.anchor.dy + request.offset,
  );
  final above = Offset(
    request.anchor.dx - request.tooltipSize.width / 2,
    request.anchor.dy - request.offset - request.tooltipSize.height,
  );

  final preferred = request.preferBelow ? below : above;
  final fallback = request.preferBelow ? above : below;

  final preferredFits = _fitsRect(preferred, request.tooltipSize, request.viewport);
  final raw = preferredFits ? preferred : fallback;

  final Offset resolved;
  final String reason;
  if (request.pinToViewport) {
    resolved = Offset(
      raw.dx.clamp(0.0, request.viewport.width - request.tooltipSize.width),
      raw.dy.clamp(0.0, request.viewport.height - request.tooltipSize.height),
    );
    reason = preferredFits
        ? (request.preferBelow ? 'preferred below fits' : 'preferred above fits')
        : 'fallback then clamped to viewport';
  } else {
    resolved = raw;
    reason = preferredFits
        ? (request.preferBelow ? 'preferred below accepted' : 'preferred above accepted')
        : 'fallback chosen without clamping';
  }
  return _PositionResult(origin: resolved, reason: reason);
}

bool _fitsRect(Offset origin, Size size, Size viewport) {
  return origin.dx >= 0 &&
      origin.dy >= 0 &&
      origin.dx + size.width <= viewport.width &&
      origin.dy + size.height <= viewport.height;
}

class _TooltipCanvasPainter extends CustomPainter {
  const _TooltipCanvasPainter({required this.request, required this.result});

  final _PositionRequest request;
  final _PositionResult result;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFF3F5FE));

    final anchorRect = Rect.fromCenter(center: request.anchor, width: 20, height: 20);
    canvas.drawOval(anchorRect, Paint()..color = const Color(0xFF3949AB));

    final tooltipRect = result.origin & request.tooltipSize;
    canvas.drawRRect(
      RRect.fromRectAndRadius(tooltipRect, const Radius.circular(10)),
      Paint()..color = const Color(0xFF00897B),
    );

    final preferredPoint = request.preferBelow
        ? Offset(request.anchor.dx, request.anchor.dy + request.offset)
        : Offset(request.anchor.dx, request.anchor.dy - request.offset);
    canvas.drawLine(
      request.anchor,
      preferredPoint,
      Paint()
        ..color = const Color(0xFF616161)
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _TooltipCanvasPainter oldDelegate) {
    return oldDelegate.request != request || oldDelegate.result != result;
  }
}

enum _TooltipPhase {
  idle,
  pending,
  visible,
  blocked,
}

class _PhaseDescriptor {
  const _PhaseDescriptor({required this.title, required this.details});

  final String title;
  final String details;
}

_PhaseDescriptor _phaseMessage(_TooltipPhase phase) {
  switch (phase) {
    case _TooltipPhase.idle:
      return const _PhaseDescriptor(
        title: 'Idle',
        details: 'No tooltip window is active.',
      );
    case _TooltipPhase.pending:
      return const _PhaseDescriptor(
        title: 'Pending',
        details: 'Tooltip open request is waiting for valid focus preconditions.',
      );
    case _TooltipPhase.visible:
      return const _PhaseDescriptor(
        title: 'Visible',
        details: 'Tooltip window is shown and can receive reposition updates.',
      );
    case _TooltipPhase.blocked:
      return const _PhaseDescriptor(
        title: 'Blocked',
        details: 'Tooltip window could not open because capability gate failed.',
      );
  }
}

class _StateBoard extends StatelessWidget {
  const _StateBoard({
    required this.phase,
    required this.openCount,
    required this.dismissCount,
    required this.pointerInside,
  });

  final _TooltipPhase phase;
  final int openCount;
  final int dismissCount;
  final bool pointerInside;

  @override
  Widget build(BuildContext context) {
    final phaseColor = switch (phase) {
      _TooltipPhase.idle => const Color(0xFF90A4AE),
      _TooltipPhase.pending => const Color(0xFFFFA000),
      _TooltipPhase.visible => const Color(0xFF2E7D32),
      _TooltipPhase.blocked => const Color(0xFFC62828),
    };

    return Stack(
      children: [
        Positioned(
          left: 12,
          top: 16,
          child: Container(
            width: 180,
            height: 120,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF5C6BC0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Source\nhover=${pointerInside ? 'inside' : 'outside'}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 30,
          child: Container(
            width: 160,
            height: 96,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: phaseColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Tooltip\nphase=$phase',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          left: 12,
          bottom: 6,
          child: Text('opens=$openCount | dismiss=$dismissCount'),
        ),
      ],
    );
  }
}
