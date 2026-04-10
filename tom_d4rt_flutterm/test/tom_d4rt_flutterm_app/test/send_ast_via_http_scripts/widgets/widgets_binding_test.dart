import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetsBindingDeepDemo();
}

const Color _kBindingBar = Color(0xFF0F172A);
const Color _kBindingCanvas = Color(0xFFF8FAFC);

class _WidgetsBindingDeepDemo extends StatefulWidget {
  const _WidgetsBindingDeepDemo();

  @override
  State<_WidgetsBindingDeepDemo> createState() => _WidgetsBindingDeepDemoState();
}

class _WidgetsBindingDeepDemoState extends State<_WidgetsBindingDeepDemo>
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
      backgroundColor: _kBindingCanvas,
      appBar: AppBar(
        backgroundColor: _kBindingBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetsBinding Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Binding Snapshot'),
            Tab(text: 'Frame Lab'),
            Tab(text: 'Focus and Lifecycle'),
            Tab(text: 'Platform Signals'),
            Tab(text: 'Trace Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BindingOverviewPanel(),
          _BindingSnapshotPanel(),
          _FrameLabPanel(),
          _FocusLifecyclePanel(),
          _PlatformSignalsPanel(),
          _BindingTracePanel(),
        ],
      ),
    );
  }
}

class _BindingOverviewPanel extends StatelessWidget {
  const _BindingOverviewPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BindingCard(
          title: 'What WidgetsBinding coordinates',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetsBinding connects the widget layer to scheduler, gesture '
              'system, rendering, semantics, and platform channels. It is the '
              'central operational bridge behind frame-driven UI.',
        ),
        SizedBox(height: 12),
        _BindingCard(
          title: 'Why this matters in deep demos',
          tone: Color(0xFF047857),
          body:
              'Interpreter execution should preserve binding-driven behavior '
              'for post-frame callbacks, lifecycle handling, focus updates, '
              'and platform dispatcher information.',
        ),
        SizedBox(height: 12),
        _BindingBulletCard(
          title: 'Critical surfaces',
          tone: Color(0xFF7C3AED),
          bullets: [
            'WidgetsBinding.instance singleton access.',
            'frame scheduling APIs and callback timing.',
            'focusManager and lifecycleState snapshots.',
            'platformDispatcher locale and brightness signals.',
            'observer registration and callback forwarding.',
          ],
        ),
        SizedBox(height: 12),
        _BindingBulletCard(
          title: 'Operational guardrails',
          tone: Color(0xFFB91C1C),
          bullets: [
            'Avoid expensive work inside frame callbacks.',
            'Use ensureInitialized before early binding access in main.',
            'Keep callback telemetry available during diagnostics.',
            'Do not rely on platform signals without fallback values.',
          ],
        ),
      ],
    );
  }
}

class _BindingSnapshotPanel extends StatelessWidget {
  const _BindingSnapshotPanel();

  @override
  Widget build(BuildContext context) {
    final binding = WidgetsBinding.instance;
    final locale = binding.platformDispatcher.locale;
    final lifecycle = binding.lifecycleState;
    final framesEnabled = binding.framesEnabled;
    final focusManager = binding.focusManager;
    final primaryFocus = focusManager.primaryFocus;

    final rows = <({String label, String value, Color tone})>[
      (
        label: 'runtimeType',
        value: binding.runtimeType.toString(),
        tone: const Color(0xFF1D4ED8),
      ),
      (
        label: 'lifecycleState',
        value: '$lifecycle',
        tone: const Color(0xFF7C3AED),
      ),
      (
        label: 'framesEnabled',
        value: '$framesEnabled',
        tone: const Color(0xFF16A34A),
      ),
      (
        label: 'locale',
        value: '${locale.languageCode}_${locale.countryCode ?? 'none'}',
        tone: const Color(0xFF0EA5E9),
      ),
      (
        label: 'primaryFocus',
        value: '$primaryFocus',
        tone: const Color(0xFFCA8A04),
      ),
      (
        label: 'platformBrightness',
        value: '${binding.platformDispatcher.platformBrightness}',
        tone: const Color(0xFFB91C1C),
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.28,
      children: [
        for (final row in rows)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [row.tone.withValues(alpha: 0.8), row.tone],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  row.value,
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _FrameLabPanel extends StatefulWidget {
  const _FrameLabPanel();

  @override
  State<_FrameLabPanel> createState() => _FrameLabPanelState();
}

class _FrameLabPanelState extends State<_FrameLabPanel> {
  int _scheduled = 0;
  int _postFrame = 0;
  int _manualMarks = 0;
  final List<String> _events = <String>['Frame lab ready.'];

  void _scheduleFrame() {
    WidgetsBinding.instance.scheduleFrame();
    setState(() {
      _scheduled += 1;
      _events.add('${DateTime.now().toIso8601String()} -> scheduleFrame()');
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  void _queuePostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _postFrame += 1;
        _events.add(
          '${DateTime.now().toIso8601String()} -> postFrame callback at ${duration.inMicroseconds}us',
        );
        if (_events.length > 24) {
          _events.removeAt(0);
        }
      });
    });
    setState(() {
      _events.add('${DateTime.now().toIso8601String()} -> addPostFrameCallback()');
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  void _manualMark() {
    setState(() {
      _manualMarks += 1;
      _events.add('${DateTime.now().toIso8601String()} -> manual frame marker');
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
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: _scheduleFrame,
                        child: const Text('scheduleFrame'),
                      ),
                      ElevatedButton(
                        onPressed: _queuePostFrame,
                        child: const Text('addPostFrameCallback'),
                      ),
                      OutlinedButton(
                        onPressed: _manualMark,
                        child: const Text('Manual marker'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StatTile(label: 'scheduleFrame', value: '$_scheduled'),
                      _StatTile(label: 'postFrame callbacks', value: '$_postFrame'),
                      _StatTile(label: 'manual marks', value: '$_manualMarks'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Frame scheduling APIs are central to rendering cadence. '
                  'This lab demonstrates how callback registration and frame '
                  'requests can be observed and traced.',
                  style: TextStyle(color: Colors.white, height: 1.3),
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

class _FocusLifecyclePanel extends StatelessWidget {
  const _FocusLifecyclePanel();

  @override
  Widget build(BuildContext context) {
    final binding = WidgetsBinding.instance;
    final lifecycle = binding.lifecycleState;
    final primaryFocus = binding.focusManager.primaryFocus;
    final views = binding.platformDispatcher.views;

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        _BindingCard(
          title: 'Lifecycle and focus snapshot',
          tone: const Color(0xFF1E40AF),
          body:
              'Current lifecycle state is $lifecycle and primary focus node is '
              '$primaryFocus. Observers and binding consumers can react to '
              'changes here to control app behavior.',
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('View count: ${views.length}'),
                const SizedBox(height: 8),
                for (final view in views)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'View ${view.viewId} size: ${view.physicalSize} DPR: ${view.devicePixelRatio}',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlatformSignalsPanel extends StatelessWidget {
  const _PlatformSignalsPanel();

  @override
  Widget build(BuildContext context) {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    final locale = dispatcher.locale;
    final locales = dispatcher.locales;
    final brightness = dispatcher.platformBrightness;
    final textScale = MediaQuery.textScalerOf(context);

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        _BindingCard(
          title: 'Platform dispatcher insights',
          tone: const Color(0xFF047857),
          body:
              'Locale ${locale.languageCode}_${locale.countryCode ?? 'none'}, '
              'brightness $brightness. Binding exposes these for responsive '
              'internationalization and theme behavior.',
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Primary locale: $locale'),
                Text('Locales list length: ${locales.length}'),
                Text('Brightness: $brightness'),
                Text('Text scaler estimate: $textScale'),
                const SizedBox(height: 10),
                const Text(
                  'Use observer callbacks with these values to trigger '
                  'translation reloads, theme updates, and density-aware layouts.',
                  style: TextStyle(height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BindingTracePanel extends StatefulWidget {
  const _BindingTracePanel();

  @override
  State<_BindingTracePanel> createState() => _BindingTracePanelState();
}

class _BindingTracePanelState extends State<_BindingTracePanel> {
  final List<String> _trace = <String>['Binding trace console ready.'];

  void _record(String event) {
    setState(() {
      _trace.add('${DateTime.now().toIso8601String()} -> $event');
      if (_trace.length > 24) {
        _trace.removeAt(0);
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
              onPressed: () => _record('scheduleFrame() requested'),
              child: const Text('Trace frame request'),
            ),
            ElevatedButton(
              onPressed: () => _record('addPostFrameCallback registered'),
              child: const Text('Trace post-frame'),
            ),
            ElevatedButton(
              onPressed: () => _record('focusManager.primaryFocus checked'),
              child: const Text('Trace focus snapshot'),
            ),
            ElevatedButton(
              onPressed: () => _record('platformDispatcher locale inspected'),
              child: const Text('Trace locale snapshot'),
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
              itemCount: _trace.length,
              itemBuilder: (context, index) {
                final line = _trace[_trace.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFF93C5FD),
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

class _BindingCard extends StatelessWidget {
  const _BindingCard({
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

class _BindingBulletCard extends StatelessWidget {
  const _BindingBulletCard({
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

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
