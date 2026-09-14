import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TooltipWindowControllerDemo();
}

const Color _kPrimary = Color(0xFF283593);
const Color _kAccent = Color(0xFF26A69A);
const Color _kSurface = Color(0xFFE8EAF6);
const Color _kCard = Colors.white;

class _TooltipWindowControllerDemo extends StatefulWidget {
  const _TooltipWindowControllerDemo();

  @override
  State<_TooltipWindowControllerDemo> createState() =>
      _TooltipWindowControllerDemoState();
}

class _TooltipWindowControllerDemoState extends State<_TooltipWindowControllerDemo>
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
        title: const Text('TooltipWindowController'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Controller API'),
            Tab(text: 'Orchestration Lab'),
            Tab(text: 'Coordination Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ControllerApiTab(),
          _OrchestrationLabTab(),
          _CoordinationPatternsTab(),
        ],
      ),
    );
  }
}

class _ControllerApiTab extends StatelessWidget {
  const _ControllerApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoCard(
          title: 'Controller Purpose',
          body:
              'TooltipWindowController centralizes show/hide orchestration for '
              'window-based tooltips, keeping trigger logic separate from '
              'rendering details.',
        ),
        SizedBox(height: 12),
        _ActionCard(
          title: 'show(request)',
          bullets: [
            'Opens a tooltip window from a trigger request.',
            'Can replace, queue, or merge with active tooltip.',
            'Stores metadata for diagnostics.',
          ],
          color: Color(0xFF1565C0),
        ),
        _ActionCard(
          title: 'hide(reason)',
          bullets: [
            'Dismisses active tooltip with explicit reason.',
            'Flushes or resumes queued requests based on policy.',
            'Emits state transition event.',
          ],
          color: Color(0xFF00897B),
        ),
        _ActionCard(
          title: 'attach / detach',
          bullets: [
            'Binds controller to host tooltip state lifecycle.',
            'Ensures cleanup when host is disposed.',
            'Prevents dangling external windows.',
          ],
          color: Color(0xFF6A1B9A),
        ),
      ],
    );
  }
}

class _OrchestrationLabTab extends StatefulWidget {
  const _OrchestrationLabTab();

  @override
  State<_OrchestrationLabTab> createState() => _OrchestrationLabTabState();
}

class _OrchestrationLabTabState extends State<_OrchestrationLabTab> {
  final List<_TooltipRequest> _queue = [];
  final List<String> _events = ['Controller initialized'];
  _TooltipRequest? _active;
  _QueuePolicy _policy = _QueuePolicy.replace;
  int _requestCounter = 0;

  void _append(String event) {
    setState(() {
      _events.add(event);
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
  }

  void _show(String source, Color color) {
    final request = _TooltipRequest(
      id: ++_requestCounter,
      source: source,
      color: color,
      time: TimeOfDay.now().format(context),
    );

    switch (_policy) {
      case _QueuePolicy.replace:
        setState(() {
          _active = request;
          _queue.clear();
        });
        _append('show($source): replaced active tooltip');
      case _QueuePolicy.queue:
        if (_active == null) {
          setState(() => _active = request);
          _append('show($source): became active');
        } else {
          setState(() => _queue.add(request));
          _append('show($source): queued behind active');
        }
      case _QueuePolicy.merge:
        if (_active == null) {
          setState(() => _active = request);
          _append('show($source): became active');
        } else {
          final merged = _TooltipRequest(
            id: _active!.id,
            source: '${_active!.source} + $source',
            color: _active!.color,
            time: request.time,
          );
          setState(() => _active = merged);
          _append('show($source): merged into active tooltip');
        }
    }
  }

  void _hide() {
    if (_active == null) {
      _append('hide(): ignored, no active tooltip');
      return;
    }
    final hiddenSource = _active!.source;
    setState(() {
      _active = null;
      if (_queue.isNotEmpty) {
        _active = _queue.removeAt(0);
      }
    });
    _append('hide(): closed [$hiddenSource]');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Controller Orchestration Lab',
          body:
              'Trigger competing tooltip requests and inspect how queue policy '
              'changes active-window behavior.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Queue policy', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SegmentedButton<_QueuePolicy>(
                  segments: _QueuePolicy.values
                      .map((p) => ButtonSegment<_QueuePolicy>(value: p, label: Text(p.label)))
                      .toList(),
                  selected: {_policy},
                  onSelectionChanged: (selection) {
                    setState(() => _policy = selection.first);
                    _append('policy switched to ${selection.first.label}');
                  },
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(
                      onPressed: () => _show('hover hint', const Color(0xFF1565C0)),
                      child: const Text('Show Hover Hint'),
                    ),
                    FilledButton.tonal(
                      onPressed: () => _show('keyboard shortcut', const Color(0xFF2E7D32)),
                      child: const Text('Show Shortcut Tip'),
                    ),
                    FilledButton.tonal(
                      onPressed: () => _show('validation message', const Color(0xFFD84315)),
                      child: const Text('Show Validation Tip'),
                    ),
                    OutlinedButton(
                      onPressed: _hide,
                      child: const Text('Hide Active'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Window State Dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 220,
                  child: _ControllerDashboard(
                    active: _active,
                    queue: _queue,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Active: ${_active?.source ?? 'none'}'),
                Text('Queued: ${_queue.length}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Controller Event Stream', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final event in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CoordinationPatternsTab extends StatelessWidget {
  const _CoordinationPatternsTab();

  static const List<_Pattern> _patterns = [
    _Pattern(
      name: 'Single-source strict',
      bullets: [
        'One tooltip source at a time.',
        'Replace policy keeps UI minimal.',
        'Ideal for dense editors with frequent hover events.',
      ],
      color: Color(0xFF1A237E),
    ),
    _Pattern(
      name: 'Assistive queue',
      bullets: [
        'Queue policy preserves sequencing of help prompts.',
        'Useful in tutorial and onboarding experiences.',
        'Requires clear timeout and cancellation strategy.',
      ],
      color: Color(0xFF00695C),
    ),
    _Pattern(
      name: 'Signal merge',
      bullets: [
        'Merge policy avoids tooltip spam under rapid triggers.',
        'Combines related hints into one consolidated surface.',
        'Effective for validation + shortcut collisions.',
      ],
      color: Color(0xFFB71C1C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Coordination Patterns',
          body:
              'Choosing the right controller policy depends on product intent, '
              'user cognitive load, and trigger frequency.',
        ),
        const SizedBox(height: 12),
        for (final pattern in _patterns)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: _kCard,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pattern.name,
                      style: TextStyle(fontWeight: FontWeight.w700, color: pattern.color),
                    ),
                    const SizedBox(height: 8),
                    for (final line in pattern.bullets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $line'),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

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

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.bullets,
    required this.color,
  });

  final String title;
  final List<String> bullets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: _kCard,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 8),
              for (final line in bullets)
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

class _ControllerDashboard extends StatelessWidget {
  const _ControllerDashboard({required this.active, required this.queue});

  final _TooltipRequest? active;
  final List<_TooltipRequest> queue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 12,
          top: 16,
          child: _WindowTile(
            label: 'Active window',
            request: active,
            fallback: 'none',
            width: 220,
          ),
        ),
        Positioned(
          right: 12,
          top: 16,
          child: _QueueTile(queue: queue),
        ),
      ],
    );
  }
}

class _WindowTile extends StatelessWidget {
  const _WindowTile({
    required this.label,
    required this.request,
    required this.fallback,
    required this.width,
  });

  final String label;
  final _TooltipRequest? request;
  final String fallback;
  final double width;

  @override
  Widget build(BuildContext context) {
    final color = request?.color ?? const Color(0xFFB0BEC5);
    return Container(
      width: width,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withValues(alpha: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            request?.source ?? fallback,
            style: const TextStyle(color: Colors.white),
          ),
          const Spacer(),
          Text(
            request == null ? 'idle' : 'id=${request!.id} at ${request!.time}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _QueueTile extends StatelessWidget {
  const _QueueTile({required this.queue});

  final List<_TooltipRequest> queue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFCFD8DC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Queue', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (queue.isEmpty)
            const Text('empty')
          else
            for (final request in queue)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('#${request.id} ${request.source}'),
              ),
        ],
      ),
    );
  }
}

class _TooltipRequest {
  const _TooltipRequest({
    required this.id,
    required this.source,
    required this.color,
    required this.time,
  });

  final int id;
  final String source;
  final Color color;
  final String time;
}

class _Pattern {
  const _Pattern({required this.name, required this.bullets, required this.color});

  final String name;
  final List<String> bullets;
  final Color color;
}

enum _QueuePolicy {
  replace('Replace'),
  queue('Queue'),
  merge('Merge');

  const _QueuePolicy(this.label);
  final String label;
}
