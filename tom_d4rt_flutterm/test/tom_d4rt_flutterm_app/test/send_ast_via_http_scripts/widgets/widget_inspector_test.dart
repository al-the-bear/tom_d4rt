import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetInspectorDeepDemo();
}

const Color _kShell = Color(0xFF111827);
const Color _kPage = Color(0xFFF8FAFC);

class _WidgetInspectorDeepDemo extends StatefulWidget {
  const _WidgetInspectorDeepDemo();

  @override
  State<_WidgetInspectorDeepDemo> createState() => _WidgetInspectorDeepDemoState();
}

class _WidgetInspectorDeepDemoState extends State<_WidgetInspectorDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPage,
      appBar: AppBar(
        backgroundColor: _kShell,
        foregroundColor: Colors.white,
        title: const Text('WidgetInspector Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Inspector Primer'),
            Tab(text: 'Hit-Target Lab'),
            Tab(text: 'Overlay Renderer'),
            Tab(text: 'Selection Timeline'),
            Tab(text: 'Practice Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _InspectorPrimerPanel(),
          _HitTargetLabPanel(),
          _OverlayRendererPanel(),
          _SelectionTimelinePanel(),
          _PracticeGuidePanel(),
        ],
      ),
    );
  }
}

class _InspectorPrimerPanel extends StatelessWidget {
  const _InspectorPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LeadPanel(
          title: 'What WidgetInspector is for',
          body:
              'WidgetInspector is the on-device visual bridge between a running '
              'widget tree and inspection tooling. It enables pick mode, widget '
              'boundary overlays, and detailed node discovery during debugging.',
        ),
        SizedBox(height: 10),
        _InfoPanel(
          title: 'Primary responsibilities',
          tint: Color(0xFF1D4ED8),
          lines: [
            'Provide selectable overlay mode for widget picking.',
            'Surface selected node metadata for external tools.',
            'Render visual boundaries and spatial hints.',
            'Coordinate with WidgetInspectorService command channels.',
          ],
        ),
        _InfoPanel(
          title: 'Typical debug flow',
          tint: Color(0xFF166534),
          lines: [
            'Enable selection mode from inspector toggle control.',
            'Tap target widget in rendered scene.',
            'Observe highlight overlays and metadata output.',
            'Navigate parent/child relationships and repeat.',
          ],
        ),
        _InfoPanel(
          title: 'Important boundaries',
          tint: Color(0xFFB91C1C),
          lines: [
            'Designed for debug-oriented inspection sessions.',
            'Should not be treated as a production analytics mechanism.',
            'Selection overlays can affect perceived UI responsiveness.',
            'Use focused toggles and clear exit paths for pick mode.',
          ],
        ),
      ],
    );
  }
}

class _HitTargetLabPanel extends StatefulWidget {
  const _HitTargetLabPanel();

  @override
  State<_HitTargetLabPanel> createState() => _HitTargetLabPanelState();
}

class _HitTargetLabPanelState extends State<_HitTargetLabPanel> {
  bool _pickMode = true;
  final List<_TargetNode> _targets = [
    _TargetNode('HeaderBanner', const Color(0xFFDBEAFE), const Icon(Icons.dashboard)),
    _TargetNode('ActionRail', const Color(0xFFD1FAE5), const Icon(Icons.tune)),
    _TargetNode('StatsPanel', const Color(0xFFEDE9FE), const Icon(Icons.bar_chart)),
    _TargetNode('TaskGrid', const Color(0xFFFEF3C7), const Icon(Icons.grid_view)),
    _TargetNode('FooterStrip', const Color(0xFFFCE7F3), const Icon(Icons.view_day)),
    _TargetNode('QuickPalette', const Color(0xFFE2E8F0), const Icon(Icons.palette)),
  ];
  final List<String> _events = ['Hit-target lab initialized'];

  void _tapTarget(_TargetNode node) {
    if (!_pickMode) {
      setState(() {
        _events.add('Ignored tap on ${node.name}; pick mode disabled');
        if (_events.length > 28) {
          _events.removeAt(0);
        }
      });
      return;
    }

    setState(() {
      for (final t in _targets) {
        t.selected = identical(t, node);
      }
      node.hitCount += 1;
      _events.add('Selected ${node.name} (hits=${node.hitCount})');
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Text('Pick mode'),
                        const SizedBox(width: 8),
                        Switch(
                          value: _pickMode,
                          onChanged: (v) => setState(() => _pickMode = v),
                        ),
                        const SizedBox(width: 10),
                        Text(_pickMode ? 'active' : 'paused'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  itemCount: _targets.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    final target = _targets[index];
                    return Card(
                      color: target.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: target.selected
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFFCBD5E1),
                          width: target.selected ? 3 : 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _tapTarget(target),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              target.icon,
                              const SizedBox(height: 8),
                              Text(target.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15)),
                              const SizedBox(height: 4),
                              Text('Selected: ${target.selected}'),
                              Text('Hits: ${target.hitCount}'),
                              const Spacer(),
                              const Text('Tap to inspect',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Selection Events',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child:
                        Text('• $event', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OverlayRendererPanel extends StatefulWidget {
  const _OverlayRendererPanel();

  @override
  State<_OverlayRendererPanel> createState() => _OverlayRendererPanelState();
}

class _OverlayRendererPanelState extends State<_OverlayRendererPanel> {
  bool _showBounds = true;
  bool _showSpacing = true;
  bool _showBaseline = false;
  double _opacity = 0.45;
  final List<String> _events = ['Overlay renderer ready'];

  void _record(String label) {
    setState(() {
      _events.add(label);
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Show widget bounds overlay'),
                        value: _showBounds,
                        onChanged: (v) {
                          setState(() => _showBounds = v);
                          _record('Bounds overlay: $v');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Show spacing guides'),
                        value: _showSpacing,
                        onChanged: (v) {
                          setState(() => _showSpacing = v);
                          _record('Spacing guides: $v');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Show baseline hints'),
                        value: _showBaseline,
                        onChanged: (v) {
                          setState(() => _showBaseline = v);
                          _record('Baseline hints: $v');
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Overlay opacity'),
                          Expanded(
                            child: Slider(
                              value: _opacity,
                              min: 0.1,
                              max: 0.9,
                              divisions: 8,
                              onChanged: (value) {
                                setState(() => _opacity = value);
                                _record('Overlay opacity: ${value.toStringAsFixed(2)}');
                              },
                            ),
                          ),
                          Text(_opacity.toStringAsFixed(2)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            color: const Color(0xFFE2E8F0),
                            alignment: Alignment.center,
                            child: const Text('Sample Widget Surface'),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: ColoredBox(color: Color(0xFFDBEAFE)),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: ColoredBox(color: Color(0xFFD1FAE5)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showBounds || _showSpacing || _showBaseline)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _showBounds
                                  ? Colors.red.withValues(alpha: _opacity)
                                  : Colors.transparent,
                              width: _showBounds ? 2 : 0,
                            ),
                          ),
                          child: CustomPaint(
                            painter: _OverlayPainter(
                              showSpacing: _showSpacing,
                              showBaseline: _showBaseline,
                              opacity: _opacity,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Overlay Events',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final item in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $item', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectionTimelinePanel extends StatefulWidget {
  const _SelectionTimelinePanel();

  @override
  State<_SelectionTimelinePanel> createState() => _SelectionTimelinePanelState();
}

class _SelectionTimelinePanelState extends State<_SelectionTimelinePanel> {
  final List<_TimelineStep> _steps = [
    _TimelineStep('Enable select mode'),
    _TimelineStep('Tap target widget'),
    _TimelineStep('Render overlay hints'),
    _TimelineStep('Resolve selected node data'),
    _TimelineStep('Publish selection to service'),
    _TimelineStep('Inspect parent/child path'),
  ];
  int _cursor = 0;

  void _advance() {
    setState(() {
      _steps[_cursor].done = true;
      _cursor += 1;
      if (_cursor >= _steps.length) {
        _cursor = 0;
        for (final step in _steps) {
          step.done = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Selection lifecycle timeline',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17)),
                  ),
                  FilledButton(onPressed: _advance, child: const Text('Advance')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                final step = _steps[index];
                final isActive = index == _cursor;
                return Card(
                  color: step.done
                      ? const Color(0xFFD1FAE5)
                      : isActive
                          ? const Color(0xFFDBEAFE)
                          : Colors.white,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: step.done
                          ? const Color(0xFF166534)
                          : isActive
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFF64748B),
                      child: Text('${index + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(step.label),
                    subtitle: Text(step.done
                        ? 'Completed'
                        : isActive
                            ? 'Current step'
                            : 'Pending'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeGuidePanel extends StatelessWidget {
  const _PracticeGuidePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoPanel(
          title: 'Daily inspector workflow',
          tint: Color(0xFF0F766E),
          lines: [
            'Use select mode only when inspecting active UI state.',
            'Capture selection metadata before triggering expensive rerenders.',
            'Cross-check overlay boundaries with expected layout constraints.',
            'Exit inspect mode to restore normal interaction behavior.',
          ],
        ),
        _InfoPanel(
          title: 'Common pitfalls',
          tint: Color(0xFFB91C1C),
          lines: [
            'Forgetting pick mode is active and misreading normal taps.',
            'Assuming selected node remains valid across rebuild storms.',
            'Interpreting overlay hints as final layout truth without context.',
            'Using inspector flows as production analytics mechanism.',
          ],
        ),
        _InfoPanel(
          title: 'Interpreter test emphasis',
          tint: Color(0xFF7C3AED),
          lines: [
            'Demonstrate interactive selection and overlay behavior visually.',
            'Exercise multiple surfaces and component regions.',
            'Track event timeline and state transitions in the demo UI.',
            'Prioritize human-debuggability over assert-heavy checks.',
          ],
        ),
      ],
    );
  }
}

class _LeadPanel extends StatelessWidget {
  const _LeadPanel({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel(
      {required this.title, required this.tint, required this.lines});

  final String title;
  final Color tint;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: tint,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
              const SizedBox(height: 8),
              for (final line in lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $line'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TargetNode {
  _TargetNode(this.name, this.color, this.icon);

  final String name;
  final Color color;
  final Widget icon;
  bool selected = false;
  int hitCount = 0;
}

class _TimelineStep {
  _TimelineStep(this.label);

  final String label;
  bool done = false;
}

class _OverlayPainter extends CustomPainter {
  _OverlayPainter({
    required this.showSpacing,
    required this.showBaseline,
    required this.opacity,
  });

  final bool showSpacing;
  final bool showBaseline;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (showSpacing) {
      final spacingPaint = Paint()
        ..color = Colors.blue.withValues(alpha: opacity)
        ..strokeWidth = 1;
      for (double x = 16; x < size.width; x += 24) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), spacingPaint);
      }
      for (double y = 16; y < size.height; y += 24) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), spacingPaint);
      }
    }

    if (showBaseline) {
      final baselinePaint = Paint()
        ..color = Colors.orange.withValues(alpha: opacity)
        ..strokeWidth = 2;
      canvas.drawLine(
        Offset(0, size.height * 0.35),
        Offset(size.width, size.height * 0.35),
        baselinePaint,
      );
      canvas.drawLine(
        Offset(0, size.height * 0.65),
        Offset(size.width, size.height * 0.65),
        baselinePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.showSpacing != showSpacing ||
        oldDelegate.showBaseline != showBaseline ||
        oldDelegate.opacity != opacity;
  }
}
