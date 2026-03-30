import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return const _DefaultAssetBundleDemoApp();
}

class _DefaultAssetBundleDemoApp extends StatelessWidget {
  const _DefaultAssetBundleDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6C87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F7FA),
      ),
      home: const _DefaultAssetBundleDemoPage(),
    );
  }
}

class _DefaultAssetBundleDemoPage extends StatefulWidget {
  const _DefaultAssetBundleDemoPage();

  @override
  State<_DefaultAssetBundleDemoPage> createState() => _DefaultAssetBundleDemoPageState();
}

class _DefaultAssetBundleDemoPageState extends State<_DefaultAssetBundleDemoPage> {
  static const _pixelPngBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAwMBASgmWQ0AAAAASUVORK5CYII=';

  late final _DemoAssetBundle _oceanBundle;
  late final _DemoAssetBundle _coralBundle;
  late final _DemoAssetBundle _forestBundle;

  @override
  void initState() {
    super.initState();

    final tinyPng = base64Decode(_pixelPngBase64);

    _oceanBundle = _DemoAssetBundle(
      label: 'Ocean Bundle',
      latency: const Duration(milliseconds: 260),
      stringAssets: {
        'copy/headline.txt': 'Ocean Control Center',
        'copy/subtitle.txt': 'Real-time tides, routes, and vessel health.',
        'copy/cta.txt': 'View harbor updates',
        'copy/module.txt': 'Shipping Module',
        'copy/highlight.txt': 'Priority: Coastal weather watch',
        'copy/image_caption.txt': 'Icon loaded through Ocean bundle',
      },
      binaryAssets: {
        'data/temperatures.bin': Uint8List.fromList(<int>[17, 18, 20, 22, 23, 21, 19, 18]),
        'data/waves.bin': Uint8List.fromList(<int>[2, 4, 6, 5, 7, 9, 6, 4, 3]),
        'images/logo.png': tinyPng,
      },
    );

    _coralBundle = _DemoAssetBundle(
      label: 'Coral Bundle',
      latency: const Duration(milliseconds: 220),
      stringAssets: {
        'copy/headline.txt': 'Coral Studio Workspace',
        'copy/subtitle.txt': 'Campaigns, content, and approvals in one flow.',
        'copy/cta.txt': 'Open creative board',
        'copy/module.txt': 'Creative Module',
        'copy/highlight.txt': 'Priority: Finalize launch assets',
        'copy/image_caption.txt': 'Icon loaded through Coral bundle',
      },
      binaryAssets: {
        'data/temperatures.bin': Uint8List.fromList(<int>[26, 27, 28, 30, 31, 32, 30, 29]),
        'data/waves.bin': Uint8List.fromList(<int>[6, 5, 4, 7, 8, 7, 6, 5, 4]),
        'images/logo.png': tinyPng,
      },
    );

    _forestBundle = _DemoAssetBundle(
      label: 'Forest Bundle',
      latency: const Duration(milliseconds: 300),
      stringAssets: {
        'copy/headline.txt': 'Forest Analytics Desk',
        'copy/subtitle.txt': 'Carbon forecasts and habitat monitoring.',
        'copy/cta.txt': 'Inspect telemetry',
        'copy/module.txt': 'Sustainability Module',
        'copy/highlight.txt': 'Priority: Validate sensor anomalies',
        'copy/image_caption.txt': 'Icon loaded through Forest bundle',
      },
      binaryAssets: {
        'data/temperatures.bin': Uint8List.fromList(<int>[11, 12, 13, 14, 15, 16, 15, 14]),
        'data/waves.bin': Uint8List.fromList(<int>[1, 2, 1, 3, 2, 4, 3, 2, 1]),
        'images/logo.png': tinyPng,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: _oceanBundle,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A6C87),
          foregroundColor: Colors.white,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DefaultAssetBundle Deep Demo'),
              SizedBox(height: 2),
              Text(
                'Scoped assets, string and binary loading, image integration',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroCard(
                oceanBundle: _oceanBundle,
                coralBundle: _coralBundle,
                forestBundle: _forestBundle,
              ),
              const SizedBox(height: 16),
              const _SceneCard(
                index: 1,
                title: 'DefaultAssetBundle Concept',
                subtitle:
                    'What it is, why it exists, and how widget subtrees resolve assets through BuildContext.',
                accent: Color(0xFF0A6C87),
                child: _ConceptScene(),
              ),
              const SizedBox(height: 14),
              _SceneCard(
                index: 2,
                title: 'Scope Resolution with Nested Bundles',
                subtitle:
                    'Three zones show the same asset keys resolving differently by nearest DefaultAssetBundle ancestor.',
                accent: const Color(0xFFE46D47),
                child: _NestedScopeScene(
                  oceanBundle: _oceanBundle,
                  coralBundle: _coralBundle,
                  forestBundle: _forestBundle,
                ),
              ),
              const SizedBox(height: 14),
              _SceneCard(
                index: 3,
                title: 'loadString Visualized',
                subtitle:
                    'FutureBuilder cards make text loading explicit and demonstrate asynchronous string assets in UI.',
                accent: const Color(0xFF0F8A5F),
                child: _LoadStringScene(
                  oceanBundle: _oceanBundle,
                  coralBundle: _coralBundle,
                  forestBundle: _forestBundle,
                ),
              ),
              const SizedBox(height: 14),
              _SceneCard(
                index: 4,
                title: 'Binary load (ByteData) in UI',
                subtitle:
                    'Raw bytes become tiny charts and diagnostics, showing non-text asset access through the same bundle.',
                accent: const Color(0xFF304B66),
                child: _BinaryScene(
                  oceanBundle: _oceanBundle,
                  coralBundle: _coralBundle,
                  forestBundle: _forestBundle,
                ),
              ),
              const SizedBox(height: 14),
              _SceneCard(
                index: 5,
                title: 'AssetImage + DefaultAssetBundle',
                subtitle:
                    'Image providers also resolve through context, enabling per-feature image packs without changing widget code.',
                accent: const Color(0xFF70509E),
                child: _AssetImageScene(
                  oceanBundle: _oceanBundle,
                  coralBundle: _coralBundle,
                  forestBundle: _forestBundle,
                ),
              ),
              const SizedBox(height: 14),
              _SceneCard(
                index: 6,
                title: 'Practical Architecture Pattern',
                subtitle:
                    'A mini app shell shows feature-level bundle injection and reusable widgets loading assets without hard wiring.',
                accent: const Color(0xFF7C5A36),
                child: _ArchitectureScene(
                  oceanBundle: _oceanBundle,
                  coralBundle: _coralBundle,
                  forestBundle: _forestBundle,
                ),
              ),
              const SizedBox(height: 18),
              const _RecapCard(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoAssetBundle extends CachingAssetBundle {
  _DemoAssetBundle({
    required this.label,
    required Map<String, String> stringAssets,
    required Map<String, Uint8List> binaryAssets,
    this.latency = const Duration(milliseconds: 240),
  })  : _stringAssets = Map.unmodifiable(stringAssets),
        _binaryAssets = Map.unmodifiable(binaryAssets);

  final String label;
  final Duration latency;
  final Map<String, String> _stringAssets;
  final Map<String, Uint8List> _binaryAssets;

  List<String> get keys {
    return <String>[
      ..._stringAssets.keys,
      ..._binaryAssets.keys,
    ]..sort();
  }

  @override
  Future<ByteData> load(String key) async {
    await Future<void>.delayed(latency);

    if (_binaryAssets.containsKey(key)) {
      final bytes = _binaryAssets[key]!;
      return ByteData.sublistView(Uint8List.fromList(bytes));
    }

    if (_stringAssets.containsKey(key)) {
      final bytes = utf8.encode(_stringAssets[key]!);
      return ByteData.sublistView(Uint8List.fromList(bytes));
    }

    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('Asset key "$key" not found in $label.'),
      ErrorDescription('The demo bundle only serves in-memory assets.'),
      ErrorHint('Available keys: ${keys.join(', ')}'),
    ]);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    await Future<void>.delayed(latency);

    if (_stringAssets.containsKey(key)) {
      return _stringAssets[key]!;
    }

    if (_binaryAssets.containsKey(key)) {
      return 'Binary asset "$key" in $label (${_binaryAssets[key]!.length} bytes)';
    }

    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('String asset key "$key" not found in $label.'),
      ErrorHint('Available keys: ${keys.join(', ')}'),
    ]);
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF0A6C87), Color(0xFF3C8DA8), Color(0xFFE5EEF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DefaultAssetBundle',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'An inherited asset source for a subtree. Widgets call DefaultAssetBundle.of(context) '
            'and stay decoupled from concrete file systems, locale packs, test fixtures, or runtime swaps.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFEDF8FF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _BundlePill(bundle: oceanBundle, color: const Color(0xFFD8F0FF)),
              _BundlePill(bundle: coralBundle, color: const Color(0xFFFFE2D9)),
              _BundlePill(bundle: forestBundle, color: const Color(0xFFE2F4E8)),
            ],
          ),
        ],
      ),
    );
  }
}

class _BundlePill extends StatelessWidget {
  const _BundlePill({required this.bundle, required this.color});

  final _DemoAssetBundle bundle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Text(
        '${bundle.label} (${bundle.keys.length} keys)',
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: accent,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: accent.withValues(alpha: 0.78),
                height: 1.42,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
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
        const _InfoText(
          'DefaultAssetBundle is an InheritedWidget wrapper. It injects an AssetBundle into a subtree. '
          'Widgets can request assets through context, so tests and runtime modules can swap bundles '
          'without changing the widgets that consume those assets.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: const [
            _ConceptTile(
              title: 'Inherited scope',
              body: 'Nearest ancestor DefaultAssetBundle wins for resolution.',
              icon: Icons.account_tree_rounded,
              color: Color(0xFF0A6C87),
            ),
            _ConceptTile(
              title: 'Source abstraction',
              body: 'UI does not know if assets come from files, memory, or network cache.',
              icon: Icons.layers_rounded,
              color: Color(0xFF3F7A5A),
            ),
            _ConceptTile(
              title: 'Testing friendly',
              body: 'Inject deterministic in-memory bundles for demos and tests.',
              icon: Icons.science_rounded,
              color: Color(0xFF855A3B),
            ),
            _ConceptTile(
              title: 'Runtime variation',
              body: 'Swap locale/theme/module assets per route or feature subtree.',
              icon: Icons.swap_horiz_rounded,
              color: Color(0xFF6A5397),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F7FC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFB5D0E4)),
          ),
          child: const SelectableText(
            'CustomScrollView or MaterialApp subtree\n'
            '  -> DefaultAssetBundle(bundle: localizedBundle)\n'
            '      -> Feature widgets\n'
            '          -> DefaultAssetBundle.of(context).loadString("copy/headline.txt")\n'
            '          -> Image(image: AssetImage("images/logo.png"))',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.35),
          ),
        ),
      ],
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(fontSize: 11.5, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NestedScopeScene extends StatelessWidget {
  const _NestedScopeScene({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'All three cards below request identical keys: copy/headline.txt and copy/subtitle.txt. '
          'Only the nearest DefaultAssetBundle changes, proving scope-driven resolution.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultAssetBundle(
              bundle: oceanBundle,
              child: const _ScopePanel(
                title: 'Outer scope: Ocean',
                accent: Color(0xFF0A6C87),
                icon: Icons.water,
              ),
            ),
            DefaultAssetBundle(
              bundle: coralBundle,
              child: const _ScopePanel(
                title: 'Middle scope: Coral',
                accent: Color(0xFFE46D47),
                icon: Icons.palette_rounded,
              ),
            ),
            DefaultAssetBundle(
              bundle: forestBundle,
              child: const _ScopePanel(
                title: 'Inner scope: Forest',
                accent: Color(0xFF3F7A5A),
                icon: Icons.park_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const _InfoText(
          'This pattern is useful for route-localized copy, white-label branding, feature flags, '
          'or experiments where asset lookups should be redirected per subtree.',
        ),
      ],
    );
  }
}

class _ScopePanel extends StatelessWidget {
  const _ScopePanel({
    required this.title,
    required this.accent,
    required this.icon,
  });

  final String title;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: accent, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _ResolvedStringTile(assetKey: 'copy/headline.txt', color: accent),
            const SizedBox(height: 6),
            _ResolvedStringTile(assetKey: 'copy/subtitle.txt', color: accent),
          ],
        ),
      ),
    );
  }
}

class _ResolvedStringTile extends StatelessWidget {
  const _ResolvedStringTile({required this.assetKey, required this.color});

  final String assetKey;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(assetKey),
      builder: (context, snapshot) {
        final Widget content;
        if (snapshot.connectionState != ConnectionState.done) {
          content = Row(
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              ),
              const SizedBox(width: 8),
              const Expanded(child: Text('Loading...')),
            ],
          );
        } else if (snapshot.hasError) {
          content = Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(fontSize: 11, color: Colors.red),
          );
        } else {
          content = Text(
            snapshot.data ?? 'No data',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          );
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                assetKey,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.82),
                ),
              ),
              const SizedBox(height: 4),
              content,
            ],
          ),
        );
      },
    );
  }
}

class _LoadStringScene extends StatefulWidget {
  const _LoadStringScene({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  State<_LoadStringScene> createState() => _LoadStringSceneState();
}

class _LoadStringSceneState extends State<_LoadStringScene> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final bundles = <_DemoAssetBundle>[
      widget.oceanBundle,
      widget.coralBundle,
      widget.forestBundle,
    ];

    final selectedBundle = bundles[selected];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'The same UI widgets can read entirely different text based on which bundle is active. '
          'Use this for A/B tests, branding, or localized content packs.',
        ),
        const SizedBox(height: 10),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Ocean')),
            ButtonSegment(value: 1, label: Text('Coral')),
            ButtonSegment(value: 2, label: Text('Forest')),
          ],
          selected: {selected},
          onSelectionChanged: (next) {
            setState(() => selected = next.first);
          },
        ),
        const SizedBox(height: 10),
        DefaultAssetBundle(
          bundle: selectedBundle,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _AsyncStringCard(
                title: 'Headline',
                keyPath: 'copy/headline.txt',
                color: Color(0xFF0A6C87),
              ),
              _AsyncStringCard(
                title: 'Subtitle',
                keyPath: 'copy/subtitle.txt',
                color: Color(0xFF3F7A5A),
              ),
              _AsyncStringCard(
                title: 'Call to Action',
                keyPath: 'copy/cta.txt',
                color: Color(0xFF855A3B),
              ),
              _AsyncStringCard(
                title: 'Priority Banner',
                keyPath: 'copy/highlight.txt',
                color: Color(0xFF6A5397),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AsyncStringCard extends StatelessWidget {
  const _AsyncStringCard({
    required this.title,
    required this.keyPath,
    required this.color,
  });

  final String title;
  final String keyPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              keyPath,
              style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: color.withValues(alpha: 0.8)),
            ),
            const SizedBox(height: 7),
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString(keyPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: color),
                      ),
                      const SizedBox(width: 8),
                      const Text('Fetching content...', style: TextStyle(fontSize: 11)),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 11, color: Colors.red),
                  );
                }

                return Text(
                  snapshot.data ?? '',
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BinaryScene extends StatelessWidget {
  const _BinaryScene({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'DefaultAssetBundle is not only for text. The same bundle can serve binary payloads. '
          'In many production systems, this can be telemetry snapshots, compact lookup tables, '
          'or precomputed render hints.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultAssetBundle(
              bundle: oceanBundle,
              child: const _BinaryPanel(
                title: 'Ocean bytes',
                accent: Color(0xFF0A6C87),
              ),
            ),
            DefaultAssetBundle(
              bundle: coralBundle,
              child: const _BinaryPanel(
                title: 'Coral bytes',
                accent: Color(0xFFE46D47),
              ),
            ),
            DefaultAssetBundle(
              bundle: forestBundle,
              child: const _BinaryPanel(
                title: 'Forest bytes',
                accent: Color(0xFF3F7A5A),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BinaryPanel extends StatelessWidget {
  const _BinaryPanel({
    required this.title,
    required this.accent,
  });

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: accent),
            ),
            const SizedBox(height: 6),
            _AsyncBinaryChart(
              keyPath: 'data/temperatures.bin',
              color: accent,
              metric: 'Temperature profile',
            ),
            const SizedBox(height: 8),
            _AsyncBinaryChart(
              keyPath: 'data/waves.bin',
              color: accent,
              metric: 'Wave profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _AsyncBinaryChart extends StatelessWidget {
  const _AsyncBinaryChart({
    required this.keyPath,
    required this.color,
    required this.metric,
  });

  final String keyPath;
  final Color color;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ByteData>(
      future: DefaultAssetBundle.of(context).load(keyPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Row(
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              ),
              const SizedBox(width: 8),
              Text('Loading $metric bytes...', style: const TextStyle(fontSize: 11)),
            ],
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.red, fontSize: 11),
          );
        }

        final bytes = snapshot.data!.buffer.asUint8List();
        final max = bytes.fold<int>(0, (prev, value) => value > prev ? value : prev);
        final average = bytes.isEmpty
            ? 0.0
            : bytes.fold<int>(0, (prev, value) => prev + value) / bytes.length;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(metric, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 11.5)),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final value in bytes)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          height: max == 0 ? 1 : 54 * (value / max),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.25 + (0.55 * (value / (max == 0 ? 1 : max)))),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '$keyPath | bytes=${bytes.length} | max=$max | avg=${average.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 10,
                  color: color.withValues(alpha: 0.85),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AssetImageScene extends StatelessWidget {
  const _AssetImageScene({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'AssetImage resolves asset bytes through the DefaultAssetBundle in context. '
          'This means image sources can be swapped by scope while widget code stays unchanged.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultAssetBundle(
              bundle: oceanBundle,
              child: const _AssetImagePanel(
                title: 'Ocean image scope',
                accent: Color(0xFF0A6C87),
              ),
            ),
            DefaultAssetBundle(
              bundle: coralBundle,
              child: const _AssetImagePanel(
                title: 'Coral image scope',
                accent: Color(0xFFE46D47),
              ),
            ),
            DefaultAssetBundle(
              bundle: forestBundle,
              child: const _AssetImagePanel(
                title: 'Forest image scope',
                accent: Color(0xFF3F7A5A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const _InfoText(
          'Even if this demo uses tiny in-memory image bytes, the pattern is identical for real bundles. '
          'Feature modules can carry separate icon packs and provide them with local DefaultAssetBundle wrappers.',
        ),
      ],
    );
  }
}

class _AssetImagePanel extends StatelessWidget {
  const _AssetImagePanel({
    required this.title,
    required this.accent,
  });

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: accent, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: accent.withValues(alpha: 0.25)),
                  ),
                  alignment: Alignment.center,
                  child: Image(
                    image: const AssetImage('images/logo.png'),
                    width: 30,
                    height: 30,
                    errorBuilder: (context, error, stack) {
                      return Icon(Icons.broken_image_outlined, color: accent);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context).loadString('copy/image_caption.txt'),
                    builder: (context, snapshot) {
                      final text = snapshot.connectionState == ConnectionState.done
                          ? (snapshot.data ?? 'No caption')
                          : 'Loading caption...';
                      return Text(
                        text,
                        style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.2)),
              ),
              child: Text(
                'Widget code: Image(image: AssetImage("images/logo.png"))',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: accent.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArchitectureScene extends StatelessWidget {
  const _ArchitectureScene({
    required this.oceanBundle,
    required this.coralBundle,
    required this.forestBundle,
  });

  final _DemoAssetBundle oceanBundle;
  final _DemoAssetBundle coralBundle;
  final _DemoAssetBundle forestBundle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'This architecture pattern keeps reusable widgets simple. A feature route injects its own '
          'DefaultAssetBundle and shared widgets just read keys. They become naturally multi-tenant.',
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F0E8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD8C4AE)),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.apartment_rounded, color: Color(0xFF7C5A36)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Mini Product Shell: same module card, different bundle scopes',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF7C5A36)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  DefaultAssetBundle(
                    bundle: oceanBundle,
                    child: const _FeatureModuleCard(accent: Color(0xFF0A6C87)),
                  ),
                  DefaultAssetBundle(
                    bundle: coralBundle,
                    child: const _FeatureModuleCard(accent: Color(0xFFE46D47)),
                  ),
                  DefaultAssetBundle(
                    bundle: forestBundle,
                    child: const _FeatureModuleCard(accent: Color(0xFF3F7A5A)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureModuleCard extends StatelessWidget {
  const _FeatureModuleCard({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
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
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString('copy/module.txt'),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? 'Loading module...',
                  style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 14),
                );
              },
            ),
            const SizedBox(height: 4),
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString('copy/headline.txt'),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? 'Loading headline...',
                  style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.w600),
                );
              },
            ),
            const SizedBox(height: 5),
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString('copy/subtitle.txt'),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? 'Loading subtitle...',
                  style: TextStyle(fontSize: 11.4, color: Colors.black.withValues(alpha: 0.68), height: 1.3),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context).loadString('copy/cta.txt'),
                    builder: (context, snapshot) {
                      return FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: accent),
                        onPressed: () {},
                        child: Text(
                          snapshot.connectionState == ConnectionState.done
                              ? (snapshot.data ?? 'Action')
                              : 'Loading...',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FutureBuilder<ByteData>(
              future: DefaultAssetBundle.of(context).load('data/waves.bin'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading diagnostics...', style: TextStyle(fontSize: 10.5));
                }
                final bytes = snapshot.data!.buffer.asUint8List();
                final checksum = bytes.fold<int>(0, (prev, value) => prev + value);
                return Text(
                  'data/waves.bin checksum: $checksum (${bytes.length} bytes)',
                  style: TextStyle(
                    fontSize: 10.2,
                    fontFamily: 'monospace',
                    color: accent.withValues(alpha: 0.84),
                  ),
                );
              },
            ),
          ],
        ),
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
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F2F9), Color(0xFFF7ECE5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB8CBD9)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF304B66)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DefaultAssetBundle injects an AssetBundle through context.\n'
            '2) Nearest scope controls key resolution.\n'
            '3) loadString and load work for text and binary assets.\n'
            '4) Image providers can resolve via the same scoped bundle.\n'
            '5) Feature-level bundle injection enables modular, testable UI architecture.',
            style: TextStyle(fontSize: 12.3, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12.6, height: 1.45),
    );
  }
}
