import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetsBindingObserverDeepDemo();
}

const Color _kObserverBar = Color(0xFF111827);
const Color _kObserverCanvas = Color(0xFFF8FAFC);

class _WidgetsBindingObserverDeepDemo extends StatefulWidget {
  const _WidgetsBindingObserverDeepDemo();

  @override
  State<_WidgetsBindingObserverDeepDemo> createState() =>
      _WidgetsBindingObserverDeepDemoState();
}

class _WidgetsBindingObserverDeepDemoState
    extends State<_WidgetsBindingObserverDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kObserverCanvas,
      appBar: AppBar(
        backgroundColor: _kObserverBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetsBindingObserver Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Lifecycle Lab'),
            Tab(text: 'System Events'),
            Tab(text: 'Route Callbacks'),
            Tab(text: 'Observer Patterns'),
            Tab(text: 'Event Timeline'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ObserverOverviewPanel(),
          _LifecycleLabPanel(),
          _SystemEventsPanel(),
          _RouteCallbacksPanel(),
          _ObserverPatternsPanel(),
          _EventTimelinePanel(),
        ],
      ),
    );
  }
}

class _ObserverOverviewPanel extends StatelessWidget {
  const _ObserverOverviewPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ObserverInfoCard(
          title: 'Purpose of WidgetsBindingObserver',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetsBindingObserver connects app-level logic to runtime '
              'framework events such as lifecycle transitions, metrics changes, '
              'platform brightness updates, locales, and route handling.',
        ),
        SizedBox(height: 12),
        _ObserverInfoCard(
          title: 'Typical architecture role',
          tone: Color(0xFF047857),
          body:
              'Observers are ideal for orchestrating services that live beyond '
              'single widgets: analytics, persistence, connectivity, media, '
              'notification routing, and recovery under memory pressure.',
        ),
        SizedBox(height: 12),
        _ObserverBulletCard(
          title: 'High-value callbacks',
          tone: Color(0xFF7C3AED),
          bullets: [
            'didChangeAppLifecycleState for pause/resume logic.',
            'didChangeMetrics for orientation and viewport changes.',
            'didChangePlatformBrightness for adaptive themes.',
            'didChangeLocales for localization refresh behavior.',
            'didHaveMemoryPressure for cache reduction strategies.',
          ],
        ),
        SizedBox(height: 12),
        _ObserverBulletCard(
          title: 'Implementation pitfalls',
          tone: Color(0xFFB91C1C),
          bullets: [
            'Forgetting removeObserver in dispose.',
            'Heavy synchronous work inside callbacks.',
            'No debouncing for frequent metrics events.',
            'Coupling UI rendering directly to lifecycle transitions.',
          ],
        ),
      ],
    );
  }
}

class _LifecycleLabPanel extends StatefulWidget {
  const _LifecycleLabPanel();

  @override
  State<_LifecycleLabPanel> createState() => _LifecycleLabPanelState();
}

class _LifecycleLabPanelState extends State<_LifecycleLabPanel> {
  AppLifecycleState _selected = AppLifecycleState.resumed;
  final List<String> _events = <String>['Lifecycle lab started.'];

  Color _colorFor(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return const Color(0xFF16A34A);
      case AppLifecycleState.inactive:
        return const Color(0xFFCA8A04);
      case AppLifecycleState.paused:
        return const Color(0xFF7C3AED);
      case AppLifecycleState.detached:
        return const Color(0xFFB91C1C);
      case AppLifecycleState.hidden:
        return const Color(0xFF0EA5E9);
    }
  }

  String _actionFor(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return 'Reconnect realtime channels and resume animation loops.';
      case AppLifecycleState.inactive:
        return 'Throttle interactions and preserve short-lived UI context.';
      case AppLifecycleState.paused:
        return 'Persist volatile state and suspend periodic background tasks.';
      case AppLifecycleState.detached:
        return 'Finalize resources and stop observers gracefully.';
      case AppLifecycleState.hidden:
        return 'Lower frame activity for off-screen application state.';
    }
  }

  void _select(AppLifecycleState state) {
    setState(() {
      _selected = state;
      _events.add(
        '${DateTime.now().toIso8601String()} -> didChangeAppLifecycleState(${state.name})',
      );
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tone = _colorFor(_selected);

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Simulate lifecycle transition',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final state in AppLifecycleState.values)
                            ChoiceChip(
                              label: Text(state.name),
                              selected: _selected == state,
                              onSelected: (_) => _select(state),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current simulated state: ${_selected.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _actionFor(_selected),
                      style: const TextStyle(color: Colors.white, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final line = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFF86EFAC),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SystemEventsPanel extends StatefulWidget {
  const _SystemEventsPanel();

  @override
  State<_SystemEventsPanel> createState() => _SystemEventsPanelState();
}

class _SystemEventsPanelState extends State<_SystemEventsPanel> {
  bool _darkMode = false;
  bool _largeText = false;
  bool _memoryPressure = false;
  bool _metricsChanged = false;
  bool _localesChanged = false;
  final List<String> _events = <String>['System events panel initialized.'];

  void _log(String event) {
    setState(() {
      _events.add('${DateTime.now().toIso8601String()} -> $event');
      if (_events.length > 22) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = _darkMode ? const Color(0xFF0B1020) : Colors.white;
    final fg = _darkMode ? const Color(0xFFE2E8F0) : const Color(0xFF0F172A);
    final scale = _largeText ? 1.2 : 1.0;

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Platform brightness changed'),
                        subtitle: const Text('Simulates didChangePlatformBrightness.'),
                        value: _darkMode,
                        onChanged: (v) {
                          setState(() => _darkMode = v);
                          _log('didChangePlatformBrightness -> ${v ? 'dark' : 'light'}');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Text scale factor changed'),
                        subtitle: const Text('Simulates didChangeTextScaleFactor.'),
                        value: _largeText,
                        onChanged: (v) {
                          setState(() => _largeText = v);
                          _log('didChangeTextScaleFactor -> ${v ? '1.2' : '1.0'}');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Metrics changed'),
                        subtitle: const Text('Simulates didChangeMetrics.'),
                        value: _metricsChanged,
                        onChanged: (v) {
                          setState(() => _metricsChanged = v);
                          _log('didChangeMetrics -> orientation/layout recalculation');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Locales changed'),
                        subtitle: const Text('Simulates didChangeLocales.'),
                        value: _localesChanged,
                        onChanged: (v) {
                          setState(() => _localesChanged = v);
                          _log('didChangeLocales -> localization refresh');
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Memory pressure signal'),
                        subtitle: const Text('Simulates didHaveMemoryPressure.'),
                        value: _memoryPressure,
                        onChanged: (v) {
                          setState(() => _memoryPressure = v);
                          _log('didHaveMemoryPressure -> cache eviction path');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text(
                  'Observer-driven system event preview. Text scale, theme, '
                  'metrics, locale, and memory-pressure simulation can be '
                  'combined to validate response strategy.',
                  style: TextStyle(color: fg, fontSize: 16 * scale, height: 1.35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final line = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFFFDE68A),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _RouteCallbacksPanel extends StatefulWidget {
  const _RouteCallbacksPanel();

  @override
  State<_RouteCallbacksPanel> createState() => _RouteCallbacksPanelState();
}

class _RouteCallbacksPanelState extends State<_RouteCallbacksPanel> {
  final List<String> _routes = <String>['/', '/dashboard', '/settings', '/logs'];
  final List<String> _events = <String>['Route callback panel ready.'];
  String _current = '/';

  void _push(String route) {
    setState(() {
      _current = route;
      _events.add('${DateTime.now().toIso8601String()} -> didPushRoute($route)');
      if (_events.length > 20) {
        _events.removeAt(0);
      }
    });
  }

  void _pop() {
    setState(() {
      _events.add('${DateTime.now().toIso8601String()} -> didPopRoute() from $_current');
      _current = '/';
      if (_events.length > 20) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final route in _routes)
              ElevatedButton(
                onPressed: () => _push(route),
                child: Text('Push $route'),
              ),
            OutlinedButton(
              onPressed: _pop,
              child: const Text('Pop route'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4ED8),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current route simulation',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _current,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Observer route callbacks can coordinate navigation-driven '
                        'service reactions, analytics, and permission checks.',
                        style: TextStyle(color: Colors.white, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final line = _events[_events.length - 1 - index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          line,
                          style: const TextStyle(
                            color: Color(0xFF93C5FD),
                            fontFamily: 'monospace',
                            fontSize: 11,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ObserverPatternsPanel extends StatelessWidget {
  const _ObserverPatternsPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _ObserverInfoCard(
          title: 'Pattern 1: Stateful owner observer',
          tone: Color(0xFF1E40AF),
          body:
              'Register observer in initState and remove in dispose. Keep callback '
              'handlers light and forward heavy work to async services or queues.',
        ),
        SizedBox(height: 10),
        _ObserverInfoCard(
          title: 'Pattern 2: Service orchestrator',
          tone: Color(0xFF047857),
          body:
              'Observer callbacks can publish normalized events to app services. '
              'UI widgets then subscribe to structured state instead of raw '
              'binding callbacks.',
        ),
        SizedBox(height: 10),
        _ObserverInfoCard(
          title: 'Pattern 3: Guarded route handling',
          tone: Color(0xFF7C3AED),
          body:
              'Use didPushRoute and didPopRoute for global navigation hooks '
              'only when necessary. Keep route parsing deterministic and test '
              'unknown path fallbacks.',
        ),
        SizedBox(height: 10),
        _ObserverBulletCard(
          title: 'Production checklist',
          tone: Color(0xFFB45309),
          bullets: [
            'Ensure removeObserver always executes.',
            'Throttle expensive callbacks like metrics changes.',
            'Log lifecycle transitions with timestamp and context.',
            'Provide memory-pressure cleanup strategy and tests.',
          ],
        ),
      ],
    );
  }
}

class _EventTimelinePanel extends StatefulWidget {
  const _EventTimelinePanel();

  @override
  State<_EventTimelinePanel> createState() => _EventTimelinePanelState();
}

class _EventTimelinePanelState extends State<_EventTimelinePanel> {
  final List<String> _timeline = <String>['Observer timeline ready.'];

  void _add(String event) {
    setState(() {
      _timeline.add('${DateTime.now().toIso8601String()} -> $event');
      if (_timeline.length > 24) {
        _timeline.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _add('didChangeAppLifecycleState(resumed)'),
              child: const Text('Lifecycle resumed'),
            ),
            ElevatedButton(
              onPressed: () => _add('didChangeMetrics()'),
              child: const Text('Metrics changed'),
            ),
            ElevatedButton(
              onPressed: () => _add('didChangeLocales([en_US, de_DE])'),
              child: const Text('Locales changed'),
            ),
            ElevatedButton(
              onPressed: () => _add('didChangePlatformBrightness(dark)'),
              child: const Text('Brightness dark'),
            ),
            ElevatedButton(
              onPressed: () => _add('didHaveMemoryPressure()'),
              child: const Text('Memory pressure'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: _timeline.length,
              itemBuilder: (context, index) {
                final line = _timeline[_timeline.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFF86EFAC),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ObserverInfoCard extends StatelessWidget {
  const _ObserverInfoCard({
    required this.title,
    required this.tone,
    required this.body,
  });

  final String title;
  final Color tone;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: tone, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _ObserverBulletCard extends StatelessWidget {
  const _ObserverBulletCard({
    required this.title,
    required this.tone,
    required this.bullets,
  });

  final String title;
  final Color tone;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: tone, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            for (final bullet in bullets)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- ', style: TextStyle(color: tone)),
                    Expanded(child: Text(bullet)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
