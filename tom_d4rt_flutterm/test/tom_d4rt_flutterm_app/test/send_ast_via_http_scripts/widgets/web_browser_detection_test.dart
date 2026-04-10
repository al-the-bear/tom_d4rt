import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WebBrowserDetectionDeepDemo();
}

const Color _kHeader = Color(0xFF0F172A);
const Color _kSheet = Color(0xFFF8FAFC);

class _WebBrowserDetectionDeepDemo extends StatefulWidget {
  const _WebBrowserDetectionDeepDemo();

  @override
  State<_WebBrowserDetectionDeepDemo> createState() =>
      _WebBrowserDetectionDeepDemoState();
}

class _WebBrowserDetectionDeepDemoState extends State<_WebBrowserDetectionDeepDemo>
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
      backgroundColor: _kSheet,
      appBar: AppBar(
        backgroundColor: _kHeader,
        foregroundColor: Colors.white,
        title: const Text('WebBrowserDetection Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Detection Primer'),
            Tab(text: 'UA Lab'),
            Tab(text: 'Capability Grid'),
            Tab(text: 'Fallback Studio'),
            Tab(text: 'Integration Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _DetectionPrimerPanel(),
          _UaLabPanel(),
          _CapabilityGridPanel(),
          _FallbackStudioPanel(),
          _IntegrationGuidePanel(),
        ],
      ),
    );
  }
}

class _DetectionPrimerPanel extends StatelessWidget {
  const _DetectionPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _PrimerCard(
          title: 'What WebBrowserDetection solves',
          body:
              'WebBrowserDetection-style logic identifies browser family and version '
              'to support diagnostics, compatibility guidance, and selective behavior '
              'adjustments in Flutter web tooling flows.',
        ),
        SizedBox(height: 10),
        _BulletPanel(
          title: 'Architecture shape',
          tint: Color(0xFF1D4ED8),
          bullets: [
            'Platform-specific implementation for web runtime.',
            'Non-web fallback/stub implementation for safe imports.',
            'Shared API surface consumed by widgets/tooling layers.',
            'Typical core input: user-agent and browser capability probes.',
          ],
        ),
        _BulletPanel(
          title: 'Primary outputs',
          tint: Color(0xFF166534),
          bullets: [
            'Browser family classification (Chrome/Firefox/Safari/Edge/Opera).',
            'Version extraction for targeted workaround scopes.',
            'Flags used by DevTools-like overlays and diagnostics.',
            'Context for issue reports and telemetry dashboards.',
          ],
        ),
        _BulletPanel(
          title: 'Important caveat',
          tint: Color(0xFFB91C1C),
          bullets: [
            'User-agent strings are spoofable; do not use for security boundaries.',
            'Prefer feature detection when deciding hard capability paths.',
            'Browser detection should support UX compatibility, not trust checks.',
            'Always keep unknown-browser safe fallback behavior.',
          ],
        ),
      ],
    );
  }
}

class _UaLabPanel extends StatefulWidget {
  const _UaLabPanel();

  @override
  State<_UaLabPanel> createState() => _UaLabPanelState();
}

class _UaLabPanelState extends State<_UaLabPanel> {
  final TextEditingController _ua = TextEditingController(
    text:
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 '
        '(KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
  );

  final List<String> _history = ['UA lab initialized'];
  _BrowserSnapshot _snapshot = _BrowserSnapshot.unknown();

  @override
  void dispose() {
    _ua.dispose();
    super.dispose();
  }

  void _detect() {
    final ua = _ua.text;
    final snap = _BrowserParser.parse(ua);
    setState(() {
      _snapshot = snap;
      _history.add('Detected ${snap.family} v${snap.version}');
      if (_history.length > 28) {
        _history.removeAt(0);
      }
    });
  }

  void _loadSample(String sample) {
    setState(() {
      _ua.text = sample;
    });
    _detect();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('User-Agent Input', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _ua,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'navigator.userAgent sample',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton(onPressed: _detect, child: const Text('Detect Browser')),
                          OutlinedButton(
                            onPressed: () => _loadSample(
                              'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:124.0) '
                              'Gecko/20100101 Firefox/124.0',
                            ),
                            child: const Text('Load Firefox Sample'),
                          ),
                          OutlinedButton(
                            onPressed: () => _loadSample(
                              'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) '
                              'AppleWebKit/605.1.15 (KHTML, like Gecko) '
                              'Version/17.0 Safari/605.1.15',
                            ),
                            child: const Text('Load Safari Sample'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: const Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Detection Result', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Family: ${_snapshot.family}'),
                      Text('Version: ${_snapshot.version}'),
                      Text('Engine: ${_snapshot.engine}'),
                      Text('Confidence: ${_snapshot.confidence}%'),
                    ],
                  ),
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
                const Text('Detection History', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final item in _history.reversed)
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

class _CapabilityGridPanel extends StatefulWidget {
  const _CapabilityGridPanel();

  @override
  State<_CapabilityGridPanel> createState() => _CapabilityGridPanelState();
}

class _CapabilityGridPanelState extends State<_CapabilityGridPanel> {
  _BrowserSnapshot _browser = const _BrowserSnapshot(
    family: 'Chrome',
    version: '122',
    engine: 'Blink',
    confidence: 90,
  );

  @override
  Widget build(BuildContext context) {
    final capabilities = _CapabilityMatrix.forBrowser(_browser.family);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final family in _CapabilityMatrix.families)
                    ChoiceChip(
                      label: Text(family),
                      selected: _browser.family == family,
                      onSelected: (_) => setState(() {
                        _browser = _browser.copyWith(family: family);
                      }),
                    ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            itemCount: capabilities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (context, index) {
              final cap = capabilities[index];
              return Card(
                color: cap.enabled ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cap.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text(cap.enabled ? 'Supported' : 'Limited/unsupported'),
                      const SizedBox(height: 6),
                      Text(cap.note, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FallbackStudioPanel extends StatefulWidget {
  const _FallbackStudioPanel();

  @override
  State<_FallbackStudioPanel> createState() => _FallbackStudioPanelState();
}

class _FallbackStudioPanelState extends State<_FallbackStudioPanel> {
  bool _pretendWeb = true;
  bool _unknownBrowser = false;
  final List<String> _events = ['Fallback studio initialized'];

  String get _resolvedMode {
    if (!_pretendWeb) {
      return 'non-web stub mode';
    }
    if (_unknownBrowser) {
      return 'web unknown-browser safe mode';
    }
    return 'web detected-browser mode';
  }

  void _simulateProbe() {
    setState(() {
      _events.add('Probe result -> $_resolvedMode');
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
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Runtime simulation toggles', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        title: const Text('Pretend running on web platform'),
                        value: _pretendWeb,
                        onChanged: (v) => setState(() => _pretendWeb = v),
                      ),
                      SwitchListTile(
                        title: const Text('Pretend browser is unknown'),
                        value: _unknownBrowser,
                        onChanged: (v) => setState(() => _unknownBrowser = v),
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _simulateProbe,
                        child: const Text('Simulate Detection Probe'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: const Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Current mode: $_resolvedMode'),
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
                const Text('Fallback Events', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $line', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntegrationGuidePanel extends StatelessWidget {
  const _IntegrationGuidePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BulletPanel(
          title: 'Integration pattern',
          tint: Color(0xFF0F766E),
          bullets: [
            'Collect detection snapshot once during startup.',
            'Publish browser context via inherited/service container.',
            'Gate only targeted compatibility workarounds with snapshot flags.',
            'Retain unknown-browser safe defaults.',
          ],
        ),
        _BulletPanel(
          title: 'Telemetry best practices',
          tint: Color(0xFF1D4ED8),
          bullets: [
            'Record browser family/version for issue triage context.',
            'Track workaround activations by browser cohort.',
            'Avoid collecting sensitive identifier fragments from UA.',
            'Use aggregate dashboards for compatibility trends.',
          ],
        ),
        _BulletPanel(
          title: 'Anti-patterns to avoid',
          tint: Color(0xFFB91C1C),
          bullets: [
            'Branching entire app flows on weak UA heuristics alone.',
            'Treating detected browser as trust/security factor.',
            'Hard-failing unknown browsers instead of graceful degradation.',
            'Scattershot detection calls from many widgets.',
          ],
        ),
      ],
    );
  }
}

class _PrimerCard extends StatelessWidget {
  const _PrimerCard({required this.title, required this.body});

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
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _BulletPanel extends StatelessWidget {
  const _BulletPanel({required this.title, required this.tint, required this.bullets});

  final String title;
  final Color tint;
  final List<String> bullets;

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
              Text(title, style: TextStyle(color: tint, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              for (final b in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $b'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrowserSnapshot {
  const _BrowserSnapshot({
    required this.family,
    required this.version,
    required this.engine,
    required this.confidence,
  });

  final String family;
  final String version;
  final String engine;
  final int confidence;

  factory _BrowserSnapshot.unknown() {
    return const _BrowserSnapshot(
      family: 'Unknown',
      version: '-',
      engine: 'Unknown',
      confidence: 0,
    );
  }

  _BrowserSnapshot copyWith({
    String? family,
    String? version,
    String? engine,
    int? confidence,
  }) {
    return _BrowserSnapshot(
      family: family ?? this.family,
      version: version ?? this.version,
      engine: engine ?? this.engine,
      confidence: confidence ?? this.confidence,
    );
  }
}

class _BrowserParser {
  static _BrowserSnapshot parse(String ua) {
    final lower = ua.toLowerCase();

    if (lower.contains('edg/')) {
      return _BrowserSnapshot(
        family: 'Edge',
        version: _extractVersion(ua, 'Edg/'),
        engine: 'Blink',
        confidence: 88,
      );
    }
    if (lower.contains('opr/') || lower.contains('opera')) {
      return _BrowserSnapshot(
        family: 'Opera',
        version: _extractVersion(ua, 'OPR/'),
        engine: 'Blink',
        confidence: 86,
      );
    }
    if (lower.contains('firefox/')) {
      return _BrowserSnapshot(
        family: 'Firefox',
        version: _extractVersion(ua, 'Firefox/'),
        engine: 'Gecko',
        confidence: 92,
      );
    }
    if (lower.contains('chrome/') && !lower.contains('chromium')) {
      return _BrowserSnapshot(
        family: 'Chrome',
        version: _extractVersion(ua, 'Chrome/'),
        engine: 'Blink',
        confidence: 90,
      );
    }
    if (lower.contains('safari/') && lower.contains('version/')) {
      return _BrowserSnapshot(
        family: 'Safari',
        version: _extractVersion(ua, 'Version/'),
        engine: 'WebKit',
        confidence: 84,
      );
    }

    return _BrowserSnapshot.unknown();
  }

  static String _extractVersion(String ua, String marker) {
    final index = ua.indexOf(marker);
    if (index < 0) {
      return '-';
    }
    final start = index + marker.length;
    if (start >= ua.length) {
      return '-';
    }
    final rest = ua.substring(start);
    final token = rest.split(' ').first;
    return token.isEmpty ? '-' : token;
  }
}

class _Capability {
  const _Capability({required this.name, required this.enabled, required this.note});

  final String name;
  final bool enabled;
  final String note;
}

class _CapabilityMatrix {
  static const List<String> families = [
    'Chrome',
    'Firefox',
    'Safari',
    'Edge',
    'Opera',
    'Unknown',
  ];

  static List<_Capability> forBrowser(String family) {
    switch (family) {
      case 'Chrome':
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: true, note: 'Strong support in Chromium stack.'),
          _Capability(name: 'Pointer events fidelity', enabled: true, note: 'Consistent behavior for web gestures.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: false, note: 'Modern baseline usually sufficient.'),
          _Capability(name: 'Canvas perf heuristics', enabled: true, note: 'Generally favorable for complex scenes.'),
        ];
      case 'Firefox':
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: false, note: 'Different tooling protocol stack.'),
          _Capability(name: 'Pointer events fidelity', enabled: true, note: 'Good support; edge cases still possible.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: true, note: 'Some compatibility shims may apply.'),
          _Capability(name: 'Canvas perf heuristics', enabled: true, note: 'Good, but tune heavy repaint paths.'),
        ];
      case 'Safari':
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: false, note: 'WebKit-specific tooling behavior.'),
          _Capability(name: 'Pointer events fidelity', enabled: false, note: 'Gesture differences can surface.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: true, note: 'Compatibility styles often needed.'),
          _Capability(name: 'Canvas perf heuristics', enabled: false, note: 'Conservative rendering strategy recommended.'),
        ];
      case 'Edge':
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: true, note: 'Chromium-aligned support.'),
          _Capability(name: 'Pointer events fidelity', enabled: true, note: 'Strong default behavior.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: false, note: 'Usually unnecessary on modern Edge.'),
          _Capability(name: 'Canvas perf heuristics', enabled: true, note: 'Comparable to Chrome in most cases.'),
        ];
      case 'Opera':
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: true, note: 'Chromium-derived tooling paths.'),
          _Capability(name: 'Pointer events fidelity', enabled: true, note: 'Mostly aligned with Blink behavior.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: false, note: 'Modern baseline generally valid.'),
          _Capability(name: 'Canvas perf heuristics', enabled: true, note: 'Typically favorable performance profile.'),
        ];
      default:
        return const [
          _Capability(name: 'DevTools protocol hooks', enabled: false, note: 'Unknown platform; disable specialized paths.'),
          _Capability(name: 'Pointer events fidelity', enabled: false, note: 'Assume conservative behavior.'),
          _Capability(name: 'Legacy CSS fallback needed', enabled: true, note: 'Prefer broad compatibility defaults.'),
          _Capability(name: 'Canvas perf heuristics', enabled: false, note: 'Use low-risk rendering settings.'),
        ];
    }
  }
}
