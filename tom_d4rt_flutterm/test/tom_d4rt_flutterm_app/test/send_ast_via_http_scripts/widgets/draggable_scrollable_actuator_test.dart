import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DraggableScrollableActuatorDeepDemoApp();
}

class _DraggableScrollableActuatorDeepDemoApp extends StatelessWidget {
  const _DraggableScrollableActuatorDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E4E75)),
        useMaterial3: true,
      ),
      home: const _ActuatorDemoPage(),
    );
  }
}

class _ActuatorDemoPage extends StatefulWidget {
  const _ActuatorDemoPage();

  @override
  State<_ActuatorDemoPage> createState() => _ActuatorDemoPageState();
}

class _ActuatorDemoPageState extends State<_ActuatorDemoPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGuides = true;
  bool _snap = true;

  double _initialSize = 0.28;
  double _minSize = 0.14;
  double _maxSize = 0.92;

  @override
  Widget build(BuildContext context) {
    const cNavy = Color(0xFF1E4E75);
    const cAmber = Color(0xFFC57B35);
    const cTeal = Color(0xFF277E71);
    const cRose = Color(0xFF92466A);
    const cIndigo = Color(0xFF5653A0);
    const cOlive = Color(0xFF6B682D);

    final minSize = _minSize.clamp(0.05, 0.8);
    final maxSize = _maxSize.clamp(minSize + 0.1, 1.0);
    final initial = _initialSize.clamp(minSize + 0.01, maxSize - 0.01);

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 76,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DraggableScrollableActuator Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl
                    ? 'Ambient Direction: RTL'
                    : 'Ambient Direction: LTR',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroControlDeck(
                rtl: _rtl,
                compact: _compact,
                showGuides: _showGuides,
                snap: _snap,
                initialSize: initial,
                minSize: minSize,
                maxSize: maxSize,
                onRtlChanged: (v) => setState(() => _rtl = v),
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGuidesChanged: (v) => setState(() => _showGuides = v),
                onSnapChanged: (v) => setState(() => _snap = v),
                onInitialChanged: (v) => setState(() => _initialSize = v),
                onMinChanged: (v) => setState(() => _minSize = v),
                onMaxChanged: (v) => setState(() => _maxSize = v),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: cNavy,
                title: 'Actuator Semantics and API',
                subtitle:
                    'DraggableScrollableActuator provides context-based reset signals for descendant DraggableScrollableSheet instances that listen for reset notifications.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: cAmber,
                title: 'Single Actuator Command Scene',
                subtitle:
                    'One actuator wrapping one sheet. Trigger reset from context and inspect return values and extent telemetry.',
                child: _SingleActuatorScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  minSize: minSize,
                  maxSize: maxSize,
                  initialSize: initial,
                  snap: _snap,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: cTeal,
                title: 'Controller vs Actuator Controls',
                subtitle:
                    'Compare direct controller operations with actuator reset to understand overlap and usage trade-offs.',
                child: _ControllerVsActuatorScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  minSize: minSize,
                  maxSize: maxSize,
                  initialSize: initial,
                  snap: _snap,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: cRose,
                title: 'Reset Return Value Probes',
                subtitle:
                    'Demonstrates true/false outcomes by issuing reset in contexts with listening sheets, without listeners, and outside any actuator scope.',
                child: _ReturnValueScene(
                  compact: _compact,
                  minSize: minSize,
                  maxSize: maxSize,
                  initialSize: initial,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: cIndigo,
                title: 'Scoped Actuator Hierarchy',
                subtitle:
                    'Nested and sibling actuator scopes show local reset isolation and broader outer-scope resets.',
                child: _ScopedActuatorScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  minSize: minSize,
                  maxSize: maxSize,
                  initialSize: initial,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: cOlive,
                title: 'Practical Pattern: Command Center',
                subtitle:
                    'An app-like panel demonstrates actuator reset for accessibility-friendly “return to baseline sheet extent” behavior.',
                child: _PracticalPatternScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  minSize: minSize,
                  maxSize: maxSize,
                  initialSize: initial,
                  snap: _snap,
                ),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroControlDeck extends StatelessWidget {
  const _HeroControlDeck({
    required this.rtl,
    required this.compact,
    required this.showGuides,
    required this.snap,
    required this.initialSize,
    required this.minSize,
    required this.maxSize,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGuidesChanged,
    required this.onSnapChanged,
    required this.onInitialChanged,
    required this.onMinChanged,
    required this.onMaxChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGuides;
  final bool snap;
  final double initialSize;
  final double minSize;
  final double maxSize;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGuidesChanged;
  final ValueChanged<bool> onSnapChanged;
  final ValueChanged<double> onInitialChanged;
  final ValueChanged<double> onMinChanged;
  final ValueChanged<double> onMaxChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E4E75), Color(0xFF426888), Color(0xFF734A66)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actuator Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune sheet extents and interaction style globally, then use scene controls to trigger context-based resets and compare outcomes.',
            style: TextStyle(color: Color(0xFFF3F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGuides,
                  onChanged: onShowGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guides', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: snap,
                  onChanged: onSnapChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sheet snap', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Initial size: ${initialSize.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: initialSize,
            min: 0.1,
            max: 0.95,
            divisions: 17,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.28),
            onChanged: onInitialChanged,
          ),
          Text(
            'Min size: ${minSize.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: minSize,
            min: 0.05,
            max: 0.7,
            divisions: 13,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.28),
            onChanged: onMinChanged,
          ),
          Text(
            'Max size: ${maxSize.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: maxSize,
            min: 0.3,
            max: 1.0,
            divisions: 14,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.28),
            onChanged: onMaxChanged,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroTag(label: rtl ? 'Direction: RTL' : 'Direction: LTR'),
              const _HeroTag(label: 'DraggableScrollableActuator.reset(context)'),
              const _HeroTag(label: 'Returns true when listeners exist'),
              const _HeroTag(label: 'Controller reset comparison'),
              const _HeroTag(label: 'Scoped reset behavior'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.84)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DraggableScrollableActuator is primarily a context-scoped reset signal. It is useful when code cannot directly hold or pass sheet controllers.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ConceptCard(
              title: 'When to use actuator',
              accent: Color(0xFF1E4E75),
              line1: 'Library or parent code cannot access controller.',
              line2: 'Need context-scoped “return to initial size” command.',
              line3: 'Scaffold uses similar pattern for persistent sheets.',
            ),
            _ConceptCard(
              title: 'Return value',
              accent: Color(0xFF1E4E75),
              line1: 'true: actuator found and some sheet listeners exist.',
              line2: 'false: no actuator in scope or no listeners attached.',
              line3: 'Useful for telemetry and fallback action logic.',
            ),
            _ConceptCard(
              title: 'Relation to controller',
              accent: Color(0xFF1E4E75),
              line1: 'Controller gives direct imperative operations.',
              line2: 'Actuator reset is context-based and decoupled.',
              line3: 'Use controller when available; actuator for indirection.',
            ),
            _ConceptCard(
              title: 'Scope model',
              accent: Color(0xFF1E4E75),
              line1: 'Reset reaches descendant listening sheets only.',
              line2: 'Nested actuator scopes can isolate or aggregate resets.',
              line3: 'Placement in tree defines effective blast radius.',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD7E1)),
          ),
          child: const SelectableText(
            'DraggableScrollableActuator(\n'
            '  child: Builder(\n'
            '    builder: (context) => FilledButton(\n'
            '      onPressed: () {\n'
            '        final bool didReset = DraggableScrollableActuator.reset(context);\n'
            '      },\n'
            '      child: Text(\'Reset Descendant Sheets\'),\n'
            '    ),\n'
            '  ),\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.1, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({
    required this.title,
    required this.accent,
    required this.line1,
    required this.line2,
    required this.line3,
  });

  final String title;
  final Color accent;
  final String line1;
  final String line2;
  final String line3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.2)),
            const SizedBox(height: 6),
            Text(line1, style: const TextStyle(fontSize: 11.2, height: 1.35)),
            const SizedBox(height: 3),
            Text(line2, style: const TextStyle(fontSize: 11.2, height: 1.35)),
            const SizedBox(height: 3),
            Text(line3, style: const TextStyle(fontSize: 11.2, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _SingleActuatorScene extends StatefulWidget {
  const _SingleActuatorScene({
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
    required this.snap,
  });

  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;
  final bool snap;

  @override
  State<_SingleActuatorScene> createState() => _SingleActuatorSceneState();
}

class _SingleActuatorSceneState extends State<_SingleActuatorScene> {
  double _extent = 0;
  bool? _lastResetResult;
  final List<String> _events = <String>[];

  void _pushEvent(String text) {
    final t = TimeOfDay.now();
    final stamp = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, '$stamp $text');
      if (_events.length > 8) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFC57B35);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Use the Reset button to dispatch actuator reset from a context inside the actuator scope. Drag sheet and observe extent returning to initial size.',
        ),
        const SizedBox(height: 10),
        DraggableScrollableActuator(
          child: Builder(
            builder: (actuatorContext) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilledButton.tonal(
                        onPressed: () {
                          final didReset = DraggableScrollableActuator.reset(actuatorContext);
                          setState(() => _lastResetResult = didReset);
                          _pushEvent('Actuator reset triggered -> $didReset');
                        },
                        child: const Text('Actuator Reset'),
                      ),
                      _TelemetryPill(label: 'Current extent', value: _extent.toStringAsFixed(3), accent: accent),
                      _TelemetryPill(
                        label: 'Last reset result',
                        value: _lastResetResult == null ? '-' : (_lastResetResult! ? 'true' : 'false'),
                        accent: accent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: widget.compact ? 260 : 320,
                    child: NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        setState(() {
                          _extent = notification.extent;
                        });
                        return false;
                      },
                      child: _SheetSandbox(
                        accent: accent,
                        compact: widget.compact,
                        showGuides: widget.showGuides,
                        minSize: widget.minSize,
                        maxSize: widget.maxSize,
                        initialSize: widget.initialSize,
                        snap: widget.snap,
                        label: 'Single-scope sheet',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _EventList(events: _events),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ControllerVsActuatorScene extends StatefulWidget {
  const _ControllerVsActuatorScene({
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
    required this.snap,
  });

  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;
  final bool snap;

  @override
  State<_ControllerVsActuatorScene> createState() => _ControllerVsActuatorSceneState();
}

class _ControllerVsActuatorSceneState extends State<_ControllerVsActuatorScene> {
  final DraggableScrollableController _controller = DraggableScrollableController();
  final List<String> _events = <String>[];
  double _extent = 0;
  bool? _lastActuatorResult;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _log(String text) {
    final t = TimeOfDay.now();
    final stamp = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, '$stamp $text');
      if (_events.length > 10) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF277E71);

    return DraggableScrollableActuator(
      child: Builder(
        builder: (actuatorContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'Actuator reset is context-scoped and decoupled; controller methods are direct. Use whichever ownership model fits your architecture.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      final didReset = DraggableScrollableActuator.reset(actuatorContext);
                      setState(() => _lastActuatorResult = didReset);
                      _log('Actuator reset -> $didReset');
                    },
                    child: const Text('Actuator reset'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      if (_controller.isAttached) {
                        _controller.reset();
                        _log('Controller.reset()');
                      } else {
                        _log('Controller not attached');
                      }
                    },
                    child: const Text('Controller reset'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      if (_controller.isAttached) {
                        _controller.animateTo(
                          widget.maxSize,
                          duration: const Duration(milliseconds: 420),
                          curve: Curves.easeOutCubic,
                        );
                        _log('Controller.animateTo(max)');
                      } else {
                        _log('Controller not attached');
                      }
                    },
                    child: const Text('Animate max'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      if (_controller.isAttached) {
                        final target = (widget.minSize + widget.maxSize) / 2;
                        _controller.jumpTo(target);
                        _log('Controller.jumpTo(mid)');
                      } else {
                        _log('Controller not attached');
                      }
                    },
                    child: const Text('Jump mid'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _TelemetryPill(label: 'Extent', value: _extent.toStringAsFixed(3), accent: accent),
                  _TelemetryPill(
                    label: 'Actuator reset result',
                    value: _lastActuatorResult == null ? '-' : (_lastActuatorResult! ? 'true' : 'false'),
                    accent: accent,
                  ),
                  _TelemetryPill(
                    label: 'Controller attached',
                    value: _controller.isAttached ? 'yes' : 'no',
                    accent: accent,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: widget.compact ? 260 : 320,
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    setState(() {
                      _extent = notification.extent;
                    });
                    return false;
                  },
                  child: _SheetSandbox(
                    accent: accent,
                    compact: widget.compact,
                    showGuides: widget.showGuides,
                    minSize: widget.minSize,
                    maxSize: widget.maxSize,
                    initialSize: widget.initialSize,
                    snap: widget.snap,
                    label: 'Controller-enabled sheet',
                    controller: _controller,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _EventList(events: _events),
            ],
          );
        },
      ),
    );
  }
}

class _ReturnValueScene extends StatefulWidget {
  const _ReturnValueScene({
    required this.compact,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
  });

  final bool compact;
  final double minSize;
  final double maxSize;
  final double initialSize;

  @override
  State<_ReturnValueScene> createState() => _ReturnValueSceneState();
}

class _ReturnValueSceneState extends State<_ReturnValueScene> {
  bool? _insideWithListener;
  bool? _insideNoListener;
  bool? _outsideAnyActuator;

  final List<String> _events = <String>[];

  void _add(String text) {
    final t = TimeOfDay.now();
    final s = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, '$s $text');
      if (_events.length > 8) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF92466A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Use these probes to verify reset return values. This helps detect when command context is incorrectly scoped.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _TelemetryPill(
              label: 'Inside actuator with listener',
              value: _insideWithListener == null ? '-' : (_insideWithListener! ? 'true' : 'false'),
              accent: accent,
            ),
            _TelemetryPill(
              label: 'Inside actuator without listener',
              value: _insideNoListener == null ? '-' : (_insideNoListener! ? 'true' : 'false'),
              accent: accent,
            ),
            _TelemetryPill(
              label: 'Outside any actuator',
              value: _outsideAnyActuator == null ? '-' : (_outsideAnyActuator! ? 'true' : 'false'),
              accent: accent,
            ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton.tonal(
          onPressed: () {
            final didReset = DraggableScrollableActuator.reset(context);
            setState(() => _outsideAnyActuator = didReset);
            _add('Outside actuator reset -> $didReset');
          },
          child: const Text('Reset from outside any actuator scope'),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DraggableScrollableActuator(
                child: Builder(
                  builder: (actuatorContext) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accent.withValues(alpha: 0.24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Scope with listening sheet', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          FilledButton.tonal(
                            onPressed: () {
                              final didReset = DraggableScrollableActuator.reset(actuatorContext);
                              setState(() => _insideWithListener = didReset);
                              _add('Inside with listener reset -> $didReset');
                            },
                            child: const Text('Reset in this scope'),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: widget.compact ? 180 : 220,
                            child: _SheetSandbox(
                              accent: accent,
                              compact: widget.compact,
                              showGuides: false,
                              minSize: widget.minSize,
                              maxSize: widget.maxSize,
                              initialSize: widget.initialSize,
                              snap: false,
                              label: 'Listener present',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DraggableScrollableActuator(
                child: Builder(
                  builder: (actuatorContext) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accent.withValues(alpha: 0.24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Scope without listening sheet', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          FilledButton.tonal(
                            onPressed: () {
                              final didReset = DraggableScrollableActuator.reset(actuatorContext);
                              setState(() => _insideNoListener = didReset);
                              _add('Inside without listener reset -> $didReset');
                            },
                            child: const Text('Reset in this scope'),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: widget.compact ? 180 : 220,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: accent.withValues(alpha: 0.2)),
                            ),
                            child: const Text(
                              'No DraggableScrollableSheet here',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _EventList(events: _events),
      ],
    );
  }
}

class _ScopedActuatorScene extends StatefulWidget {
  const _ScopedActuatorScene({
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
  });

  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;

  @override
  State<_ScopedActuatorScene> createState() => _ScopedActuatorSceneState();
}

class _ScopedActuatorSceneState extends State<_ScopedActuatorScene> {
  final List<String> _events = <String>[];
  bool? _outerResult;
  bool? _leftResult;
  bool? _rightResult;

  void _log(String message) {
    final t = TimeOfDay.now();
    final s = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, '$s $message');
      if (_events.length > 10) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF5653A0);

    return DraggableScrollableActuator(
      child: Builder(
        builder: (outerContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'Outer reset should reach all descendant listeners. Inner reset buttons target their local subtree scope only.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      final result = DraggableScrollableActuator.reset(outerContext);
                      setState(() => _outerResult = result);
                      _log('Outer scope reset -> $result');
                    },
                    child: const Text('Outer scope reset'),
                  ),
                  _TelemetryPill(label: 'Outer result', value: _fmtBool(_outerResult), accent: accent),
                  _TelemetryPill(label: 'Left result', value: _fmtBool(_leftResult), accent: accent),
                  _TelemetryPill(label: 'Right result', value: _fmtBool(_rightResult), accent: accent),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ScopedPane(
                      title: 'Left inner actuator',
                      accent: accent,
                      compact: widget.compact,
                      showGuides: widget.showGuides,
                      minSize: widget.minSize,
                      maxSize: widget.maxSize,
                      initialSize: widget.initialSize,
                      onResetResult: (result) {
                        setState(() => _leftResult = result);
                        _log('Left scope reset -> $result');
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ScopedPane(
                      title: 'Right inner actuator',
                      accent: accent,
                      compact: widget.compact,
                      showGuides: widget.showGuides,
                      minSize: widget.minSize,
                      maxSize: widget.maxSize,
                      initialSize: widget.initialSize,
                      onResetResult: (result) {
                        setState(() => _rightResult = result);
                        _log('Right scope reset -> $result');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _EventList(events: _events),
            ],
          );
        },
      ),
    );
  }

  static String _fmtBool(bool? b) {
    if (b == null) {
      return '-';
    }
    return b ? 'true' : 'false';
  }
}

class _ScopedPane extends StatelessWidget {
  const _ScopedPane({
    required this.title,
    required this.accent,
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
    required this.onResetResult,
  });

  final String title;
  final Color accent;
  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;
  final ValueChanged<bool> onResetResult;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: Builder(
        builder: (innerContext) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent.withValues(alpha: 0.24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                FilledButton.tonal(
                  onPressed: () {
                    onResetResult(DraggableScrollableActuator.reset(innerContext));
                  },
                  child: const Text('Inner scope reset'),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: compact ? 200 : 240,
                  child: _SheetSandbox(
                    accent: accent,
                    compact: compact,
                    showGuides: showGuides,
                    minSize: minSize,
                    maxSize: maxSize,
                    initialSize: initialSize,
                    snap: false,
                    label: title,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PracticalPatternScene extends StatefulWidget {
  const _PracticalPatternScene({
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
    required this.snap,
  });

  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;
  final bool snap;

  @override
  State<_PracticalPatternScene> createState() => _PracticalPatternSceneState();
}

class _PracticalPatternSceneState extends State<_PracticalPatternScene> {
  final List<String> _events = <String>[];
  int _selectedAction = 0;
  bool? _lastResult;

  void _log(String message) {
    final t = TimeOfDay.now();
    final s = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, '$s $message');
      if (_events.length > 8) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF6B682D);

    return DraggableScrollableActuator(
      child: Builder(
        builder: (actuatorContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'This scene models a command center where a global action can return the sheet to baseline for clarity and accessibility.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      final didReset = DraggableScrollableActuator.reset(actuatorContext);
                      setState(() => _lastResult = didReset);
                      _log('Command center reset -> $didReset');
                    },
                    child: const Text('Return Sheet To Baseline'),
                  ),
                  _TelemetryPill(
                    label: 'Last result',
                    value: _lastResult == null ? '-' : (_lastResult! ? 'true' : 'false'),
                    accent: accent,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accent.withValues(alpha: 0.24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Action presets', style: TextStyle(fontWeight: FontWeight.w800, color: accent)),
                          const SizedBox(height: 8),
                          _ActionToggle(
                            label: 'Review queue',
                            selected: _selectedAction == 0,
                            onTap: () => setState(() => _selectedAction = 0),
                          ),
                          const SizedBox(height: 6),
                          _ActionToggle(
                            label: 'Resolve incidents',
                            selected: _selectedAction == 1,
                            onTap: () => setState(() => _selectedAction = 1),
                          ),
                          const SizedBox(height: 6),
                          _ActionToggle(
                            label: 'Publish summary',
                            selected: _selectedAction == 2,
                            onTap: () => setState(() => _selectedAction = 2),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tip: actuator reset is great for keyboard shortcuts or assistive controls when direct drag gestures are cumbersome.',
                            style: TextStyle(fontSize: 11.2, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: widget.compact ? 280 : 340,
                      child: _SheetSandbox(
                        accent: accent,
                        compact: widget.compact,
                        showGuides: widget.showGuides,
                        minSize: widget.minSize,
                        maxSize: widget.maxSize,
                        initialSize: widget.initialSize,
                        snap: widget.snap,
                        label: _selectedAction == 0
                            ? 'Review queue panel'
                            : _selectedAction == 1
                                ? 'Incident panel'
                                : 'Publish panel',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _EventList(events: _events),
            ],
          );
        },
      ),
    );
  }
}

class _ActionToggle extends StatelessWidget {
  const _ActionToggle({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF6B682D);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.22)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : accent,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SheetSandbox extends StatelessWidget {
  const _SheetSandbox({
    required this.accent,
    required this.compact,
    required this.showGuides,
    required this.minSize,
    required this.maxSize,
    required this.initialSize,
    required this.snap,
    required this.label,
    this.controller,
  });

  final Color accent;
  final bool compact;
  final bool showGuides;
  final double minSize;
  final double maxSize;
  final double initialSize;
  final bool snap;
  final String label;
  final DraggableScrollableController? controller;

  @override
  Widget build(BuildContext context) {
    final laneHeight = compact ? 26.0 : 34.0;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEAF0F7), Color(0xFFF7EEE8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          if (showGuides)
            Positioned.fill(
              child: CustomPaint(painter: _GuideGridPainter(color: accent.withValues(alpha: 0.12))),
            ),
          PositionedDirectional(
            start: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(label, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 11)),
            ),
          ),
          DraggableScrollableSheet(
            controller: controller,
            minChildSize: minSize,
            maxChildSize: maxSize,
            initialChildSize: initialSize,
            snap: snap,
            snapSizes: snap ? <double>[minSize, (minSize + maxSize) / 2, maxSize] : null,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  border: Border.all(color: accent.withValues(alpha: 0.24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  children: [
                    Center(
                      child: Container(
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Drag handle area',
                      style: TextStyle(fontWeight: FontWeight.w800, color: accent),
                    ),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Extent-aware analytics row', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Activity stream row', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Command row', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Incident row', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Summary row', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row A', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row B', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row C', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row D', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row E', height: laneHeight),
                    const SizedBox(height: 6),
                    _LaneCard(color: accent, text: 'Long content row F', height: laneHeight),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LaneCard extends StatelessWidget {
  const _LaneCard({
    required this.color,
    required this.text,
    required this.height,
  });

  final Color color;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11.3)),
        ),
      ),
    );
  }
}

class _GuideGridPainter extends CustomPainter {
  _GuideGridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;

    const step = 30.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GuideGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _TelemetryPill extends StatelessWidget {
  const _TelemetryPill({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 11.2),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD3DAE2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scene event log', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF3B4F62))),
          const SizedBox(height: 6),
          if (events.isEmpty) const Text('No events yet.'),
          for (final line in events)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 10.4)),
            ),
        ],
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFEAF0F6), Color(0xFFF7ECE4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFC1CCD8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF31495B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DraggableScrollableActuator.reset(context) sends reset signals to listening descendant sheets.\n'
            '2) It returns true only when actuator scope is found and listeners are present.\n'
            '3) Controller methods and actuator reset can coexist; actuator is useful when direct controller access is unavailable.\n'
            '4) Scope placement controls which sheets are affected by reset.\n'
            '5) Nested actuator patterns enable local and global reset strategies.\n'
            '6) This pattern supports accessibility and command-driven UX where drag gestures are not the only interaction path.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.4, height: 1.45));
  }
}
