import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TooltipWindowControllerDelegateDemo();
}

const Color _kPrimary = Color(0xFF004D40);
const Color _kAccent = Color(0xFFFF7043);
const Color _kSurface = Color(0xFFE0F2F1);
const Color _kCard = Colors.white;

class _TooltipWindowControllerDelegateDemo extends StatefulWidget {
  const _TooltipWindowControllerDelegateDemo();

  @override
  State<_TooltipWindowControllerDelegateDemo> createState() =>
      _TooltipWindowControllerDelegateDemoState();
}

class _TooltipWindowControllerDelegateDemoState
    extends State<_TooltipWindowControllerDelegateDemo>
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
        title: const Text('TooltipWindowControllerDelegate'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Delegate Contract'),
            Tab(text: 'Lifecycle Lab'),
            Tab(text: 'Policy Presets'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ContractTab(),
          _LifecycleLabTab(),
          _PolicyPresetsTab(),
        ],
      ),
    );
  }
}

class _ContractTab extends StatelessWidget {
  const _ContractTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'Delegate Responsibility Scope',
          body:
              'A tooltip window delegate can mediate where tooltip windows open, '
              'how they react to focus changes, and when they are recycled or '
              'dismissed.',
        ),
        SizedBox(height: 12),
        _RoleCard(
          title: 'Creation phase',
          bullets: [
            'Validate windowing capability before launching tooltip window.',
            'Choose initial origin near target with viewport-safe clamping.',
            'Attach metadata for ownership and diagnostics.',
          ],
          color: Color(0xFF00695C),
        ),
        _RoleCard(
          title: 'Active phase',
          bullets: [
            'Reposition tooltip when source window moves or resizes.',
            'Track focus transitions to avoid orphan windows.',
            'Throttle updates to prevent visual stutter.',
          ],
          color: Color(0xFF0277BD),
        ),
        _RoleCard(
          title: 'Shutdown phase',
          bullets: [
            'Dismiss tooltip on source teardown or explicit cancel.',
            'Release any shared channels or callback handles.',
            'Publish close reason for analytics and debugging.',
          ],
          color: Color(0xFFD84315),
        ),
      ],
    );
  }
}

class _LifecycleLabTab extends StatefulWidget {
  const _LifecycleLabTab();

  @override
  State<_LifecycleLabTab> createState() => _LifecycleLabTabState();
}

class _LifecycleLabTabState extends State<_LifecycleLabTab> {
  _WindowState _state = _WindowState.idle;
  bool _windowingEnabled = true;
  bool _sourceFocused = true;
  int _openCount = 0;
  int _repositionCount = 0;
  final List<String> _events = ['Session created'];

  void _push(String message) {
    setState(() {
      _events.add(message);
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  void _requestOpen() {
    if (!_windowingEnabled) {
      _push('Open blocked: windowing disabled');
      setState(() => _state = _WindowState.blocked);
      return;
    }
    if (!_sourceFocused) {
      _push('Open deferred: source not focused');
      setState(() => _state = _WindowState.deferred);
      return;
    }
    setState(() {
      _state = _WindowState.visible;
      _openCount += 1;
    });
    _push('Tooltip window opened');
  }

  void _reposition() {
    if (_state != _WindowState.visible) {
      _push('Reposition ignored: tooltip not visible');
      return;
    }
    setState(() => _repositionCount += 1);
    _push('Tooltip window repositioned');
  }

  void _dismiss() {
    setState(() => _state = _WindowState.dismissed);
    _push('Tooltip dismissed by delegate');
  }

  @override
  Widget build(BuildContext context) {
    final descriptor = _describe(_state);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Lifecycle Simulation',
          body:
              'Use the controls below to trigger delegate decisions across '
              'window creation, updates, and dismissal scenarios.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Runtime flags',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('windowingEnabled'),
                      selected: _windowingEnabled,
                      onSelected: (v) => setState(() => _windowingEnabled = v),
                    ),
                    FilterChip(
                      label: const Text('sourceFocused'),
                      selected: _sourceFocused,
                      onSelected: (v) => setState(() => _sourceFocused = v),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(
                      onPressed: _requestOpen,
                      child: const Text('Request Open'),
                    ),
                    OutlinedButton(
                      onPressed: _reposition,
                      child: const Text('Reposition'),
                    ),
                    OutlinedButton(
                      onPressed: _dismiss,
                      child: const Text('Dismiss'),
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
                const Text('Visual Window Map', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 220,
                  child: _WindowMap(
                    state: _state,
                    sourceFocused: _sourceFocused,
                    openCount: _openCount,
                    repositionCount: _repositionCount,
                  ),
                ),
                const SizedBox(height: 8),
                Text('State: ${descriptor.title}'),
                Text(descriptor.message),
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
                const Text('Delegate Event Log', style: TextStyle(fontWeight: FontWeight.w700)),
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

class _PolicyPresetsTab extends StatelessWidget {
  const _PolicyPresetsTab();

  static const List<_PolicyPreset> _presets = [
    _PolicyPreset(
      name: 'Conservative desktop',
      bullets: [
        'Open only when source window is active.',
        'Dismiss immediately on focus loss.',
        'Throttle reposition to reduce CPU spikes.',
      ],
      color: Color(0xFF1B5E20),
    ),
    _PolicyPreset(
      name: 'Floating assistant',
      bullets: [
        'Allow short-lived visibility after focus changes.',
        'Pin tooltip to pointer-adjacent region.',
        'Use fade transitions for context continuity.',
      ],
      color: Color(0xFF1565C0),
    ),
    _PolicyPreset(
      name: 'Accessibility priority',
      bullets: [
        'Increase tooltip dwell time for readability.',
        'Avoid overlap with screen-reader focus rings.',
        'Prefer stable anchors to prevent tracking fatigue.',
      ],
      color: Color(0xFF6A1B9A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Policy Profiles',
          body:
              'A delegate should expose clear policy presets so application '
              'teams can choose behavior intentionally by product context.',
        ),
        const SizedBox(height: 12),
        for (final preset in _presets)
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
                      preset.name,
                      style: TextStyle(fontWeight: FontWeight.w700, color: preset.color),
                    ),
                    const SizedBox(height: 8),
                    for (final line in preset.bullets)
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

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.body});

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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
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

class _WindowMap extends StatelessWidget {
  const _WindowMap({
    required this.state,
    required this.sourceFocused,
    required this.openCount,
    required this.repositionCount,
  });

  final _WindowState state;
  final bool sourceFocused;
  final int openCount;
  final int repositionCount;

  @override
  Widget build(BuildContext context) {
    final tooltipVisible = state == _WindowState.visible;
    return Stack(
      children: [
        Positioned(
          left: 16,
          top: 24,
          child: _WindowCard(
            title: 'Source window',
            focused: sourceFocused,
            width: 220,
            height: 140,
            color: const Color(0xFF00796B),
            subtitle: 'hover zone active',
          ),
        ),
        Positioned(
          left: 210,
          top: 60,
          child: _WindowCard(
            title: 'Tooltip window',
            focused: tooltipVisible,
            width: 170,
            height: 96,
            color: tooltipVisible ? const Color(0xFFEF6C00) : const Color(0xFFB0BEC5),
            subtitle: tooltipVisible ? 'visible' : 'hidden',
          ),
        ),
        Positioned(
          left: 16,
          bottom: 10,
          child: Text('opens=$openCount | repositions=$repositionCount'),
        ),
      ],
    );
  }
}

class _WindowCard extends StatelessWidget {
  const _WindowCard({
    required this.title,
    required this.focused,
    required this.width,
    required this.height,
    required this.color,
    required this.subtitle,
  });

  final String title;
  final bool focused;
  final double width;
  final double height;
  final Color color;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withValues(alpha: focused ? 0.95 : 0.45),
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
          ),
          const Spacer(),
          Text(
            focused ? 'focused' : 'inactive',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
          ),
        ],
      ),
    );
  }
}

class _PolicyPreset {
  const _PolicyPreset({required this.name, required this.bullets, required this.color});

  final String name;
  final List<String> bullets;
  final Color color;
}

enum _WindowState {
  idle,
  visible,
  deferred,
  blocked,
  dismissed,
}

class _StateDescription {
  const _StateDescription({required this.title, required this.message});

  final String title;
  final String message;
}

_StateDescription _describe(_WindowState state) {
  switch (state) {
    case _WindowState.idle:
      return const _StateDescription(
        title: 'Idle',
        message: 'No tooltip window is currently requested.',
      );
    case _WindowState.visible:
      return const _StateDescription(
        title: 'Visible',
        message: 'Tooltip window is open and eligible for reposition updates.',
      );
    case _WindowState.deferred:
      return const _StateDescription(
        title: 'Deferred',
        message: 'Delegate postponed opening because focus preconditions failed.',
      );
    case _WindowState.blocked:
      return const _StateDescription(
        title: 'Blocked',
        message: 'Delegate blocked opening because windowing is disabled.',
      );
    case _WindowState.dismissed:
      return const _StateDescription(
        title: 'Dismissed',
        message: 'Tooltip window has been explicitly closed.',
      );
  }
}
