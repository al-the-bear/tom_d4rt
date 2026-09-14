// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of DefaultAssetBundle / AssetBundle.
//
// This script is sent via HTTP to a d4rt-driven Flutter test app and rendered
// live. It demonstrates the AssetBundle class hierarchy and DefaultAssetBundle
// inherited widget through static, deterministic visual elements only — no
// actual asset I/O occurs because d4rt cannot reach the platform asset
// channel from interpreted code. Instead, this acts as a "code reference"
// that visually documents the API surface for human readers.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// ---------------------------------------------------------------------------
// Top-level palette and constants. Static so the d4rt interpreter can resolve
// them without analyzer state.
// ---------------------------------------------------------------------------

const Color _kBackground = Color(0xFFF4F6FB);
const Color _kCardSurface = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF1A1F2C);
const Color _kInkSoft = Color(0xFF55607A);
const Color _kAccentBlue = Color(0xFF3D6BFF);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentPurple = Color(0xFF7C3AED);
const Color _kAccentRose = Color(0xFFE11D74);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kCodeBg = Color(0xFF1E1E2F);
const Color _kCodeBgAlt = Color(0xFF252537);
const Color _kCodeText = Color(0xFFE7E9F2);
const Color _kCodeComment = Color(0xFF6A9955);

// ---------------------------------------------------------------------------
// build entrypoint expected by the d4rt-driven Flutter test runner.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'DefaultAssetBundle Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: _kAccentBlue,
      scaffoldBackgroundColor: _kBackground,
    ),
    home: Scaffold(
      backgroundColor: _kBackground,
      appBar: AppBar(
        title: const Text('AssetBundle Reference'),
        backgroundColor: _kAccentBlue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          const SizedBox(height: 18),
          _buildClassHierarchyDiagram(),
          const SizedBox(height: 18),
          _buildDefaultAssetBundleSection(),
          const SizedBox(height: 18),
          _buildAssetBundleApiCard(),
          const SizedBox(height: 18),
          _buildNetworkAssetBundleSection(),
          const SizedBox(height: 18),
          _buildPlatformAssetBundleSection(),
          const SizedBox(height: 18),
          _buildOverridingPatternSection(),
          const SizedBox(height: 18),
          _buildCachingDiagram(),
          const SizedBox(height: 18),
          _buildLiveDefaultAssetBundleSection(),
          const SizedBox(height: 18),
          _buildUsageGuide(),
          const SizedBox(height: 18),
          _buildFooterCard(),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Intro card
// ===========================================================================

Widget _buildIntroCard() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentBlue, _kAccentPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.menu_book,
    headerTitle: 'DefaultAssetBundle & AssetBundle',
    headerSubtitle: 'Interactive code reference for Flutter asset loading',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'AssetBundle is the abstract gateway through which Flutter apps load '
        'binary, string, and structured assets bundled with the app or fetched '
        'over the network. DefaultAssetBundle is an InheritedWidget that '
        'announces which AssetBundle implementation should be used by the '
        'descendants of a subtree. Combined, they let you swap the asset '
        'source for tests, override sections of the widget tree, or layer '
        'caching strategies on top of the platform default.',
      ),
      const SizedBox(height: 12),
      _bulletRow(_kAccentBlue, 'Abstract API contract — extend to plug in custom asset sources.'),
      _bulletRow(_kAccentTeal, 'Inherited widget — change asset bundle scope without rebuilding the world.'),
      _bulletRow(_kAccentPurple, 'rootBundle — the always-available, app-wide default bundle.'),
      _bulletRow(_kAccentAmber, 'CachingAssetBundle — mixin that memoizes loaded assets in-memory.'),
      _bulletRow(_kAccentRose, 'NetworkAssetBundle — HTTP-backed bundle for remote content during dev.'),
      const SizedBox(height: 12),
      _calloutBox(
        icon: Icons.bolt,
        accent: _kAccentAmber,
        title: 'Why a separate widget for asset bundles?',
        body:
            'Asset resolution is a tree-scoped concern: a localization layer '
            'might rebind the bundle for translated assets, a test harness '
            'might inject a mock bundle, and previewers might serve assets '
            'from disk. DefaultAssetBundle gives every descendant a single '
            'lookup point without threading the bundle through constructors.',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 2 — Class hierarchy diagram (Stack with Positioned boxes + lines)
// ===========================================================================

Widget _buildClassHierarchyDiagram() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentTeal, _kAccentBlue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.account_tree,
    headerTitle: 'Class hierarchy',
    headerSubtitle: 'The shape of the AssetBundle family tree',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'The AssetBundle family is rooted at an abstract base. Concrete '
        'platform and network bundles extend it directly, while the caching '
        'behavior is provided through a mixin so it can be composed into '
        'either branch. DefaultAssetBundle sits beside the family as an '
        'inherited widget that exposes whichever AssetBundle instance is '
        'currently in scope.',
      ),
      const SizedBox(height: 16),
      _hierarchyDiagram(),
      const SizedBox(height: 12),
      _paragraph(
        'Each box below represents a Dart type. Solid arrows mean "extends" '
        'and dashed-style thin connectors mean "with mixin". The diagram '
        'shows that PlatformAssetBundle composes both the abstract bundle and '
        'the caching mixin, while NetworkAssetBundle is a plain extension '
        'that does not cache by default.',
      ),
    ],
  );
}

Widget _hierarchyDiagram() {
  return Container(
    height: 360,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFF8FAFF), Color(0xFFEEF2FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFD8DEF0)),
    ),
    child: Stack(
      children: <Widget>[
        // Root: AssetBundle (abstract)
        Positioned(
          left: 0,
          right: 0,
          top: 14,
          child: Center(child: _diagramBox('AssetBundle', 'abstract', _kAccentBlue, 200)),
        ),
        // Vertical line down from root
        Positioned(
          left: 0,
          right: 0,
          top: 70,
          child: Center(
            child: Container(width: 2, height: 30, color: _kAccentBlue),
          ),
        ),
        // Horizontal trunk
        Positioned(
          left: 60,
          right: 60,
          top: 100,
          child: Container(height: 2, color: _kAccentBlue),
        ),
        // Vertical drop to NetworkAssetBundle (left)
        Positioned(
          left: 90,
          top: 100,
          child: Container(width: 2, height: 26, color: _kAccentBlue),
        ),
        // Vertical drop to PlatformAssetBundle (center)
        Positioned(
          left: 0,
          right: 0,
          top: 100,
          child: Center(
            child: Container(width: 2, height: 26, color: _kAccentBlue),
          ),
        ),
        // Vertical drop to CachingAssetBundle (right)
        Positioned(
          right: 90,
          top: 100,
          child: Container(width: 2, height: 26, color: _kAccentTeal),
        ),
        // NetworkAssetBundle box
        Positioned(
          left: 16,
          top: 130,
          child: _diagramBox('NetworkAssetBundle', 'class', _kAccentRose, 150),
        ),
        // PlatformAssetBundle box (center)
        Positioned(
          left: 0,
          right: 0,
          top: 130,
          child: Center(
            child: _diagramBox('PlatformAssetBundle', 'class', _kAccentPurple, 170),
          ),
        ),
        // CachingAssetBundle box (right)
        Positioned(
          right: 16,
          top: 130,
          child: _diagramBox('CachingAssetBundle', 'mixin', _kAccentTeal, 160),
        ),
        // Mixin connector — small dashed-feel by stacking two short bars
        Positioned(
          right: 96,
          top: 168,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(width: 16, height: 2, color: _kAccentTeal),
              const SizedBox(width: 4),
              Container(width: 16, height: 2, color: _kAccentTeal),
              const SizedBox(width: 4),
              Container(width: 16, height: 2, color: _kAccentTeal),
            ],
          ),
        ),
        // DefaultAssetBundle widget (separate cluster, lower-left)
        Positioned(
          left: 16,
          top: 230,
          child: _diagramBox('DefaultAssetBundle', 'InheritedWidget', _kAccentAmber, 200),
        ),
        // rootBundle global (lower-right)
        Positioned(
          right: 16,
          top: 230,
          child: _diagramBox('rootBundle', 'top-level final', _kAccentGreen, 180),
        ),
        // Caption row at bottom
        Positioned(
          left: 16,
          right: 16,
          bottom: 14,
          child: Row(
            children: <Widget>[
              _legendChip('extends', _kAccentBlue),
              const SizedBox(width: 10),
              _legendChip('with mixin', _kAccentTeal),
              const SizedBox(width: 10),
              _legendChip('exposes', _kAccentAmber),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _diagramBox(String title, String label, Color accent, double width) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 2),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x1F000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: _kInkSoft, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget _legendChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 11)),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 — DefaultAssetBundle widget reference
// ===========================================================================

Widget _buildDefaultAssetBundleSection() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentAmber, _kAccentRose],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.layers,
    headerTitle: 'DefaultAssetBundle',
    headerSubtitle: 'InheritedWidget(bundle, child)',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'DefaultAssetBundle is the canonical way to swap the AssetBundle for '
        'a subtree without forcing widgets to receive a bundle parameter. It '
        'is an InheritedWidget, so descendants subscribe with '
        'DefaultAssetBundle.of(context). When a subtree is wrapped in a '
        'DefaultAssetBundle with a custom bundle, calls like '
        'DefaultAssetBundle.of(context).loadString(...) resolve through that '
        'override instead of rootBundle.',
      ),
      const SizedBox(height: 12),
      _signatureRow('class', 'DefaultAssetBundle', 'extends InheritedWidget', _kAccentBlue),
      _signatureRow('field', 'bundle', 'final AssetBundle', _kAccentTeal),
      _signatureRow('field', 'child', 'final Widget', _kAccentTeal),
      _signatureRow('static', 'of(BuildContext context)', '→ AssetBundle', _kAccentAmber),
      _signatureRow('override', 'updateShouldNotify', '→ bool', _kAccentRose),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'default_asset_bundle.dart',
        lines: const <String>[
          '// Wrap a subtree to override the asset bundle for descendants.',
          'class DefaultAssetBundle extends InheritedWidget {',
          '  const DefaultAssetBundle({',
          '    super.key,',
          '    required this.bundle,',
          '    required super.child,',
          '  });',
          '',
          '  final AssetBundle bundle;',
          '',
          '  static AssetBundle of(BuildContext context) {',
          '    final result = context.dependOnInheritedWidgetOfExactType<DefaultAssetBundle>();',
          '    return result?.bundle ?? rootBundle;',
          '  }',
          '',
          '  @override',
          '  bool updateShouldNotify(DefaultAssetBundle old) => bundle != old.bundle;',
          '}',
        ],
      ),
      const SizedBox(height: 12),
      _calloutBox(
        icon: Icons.lightbulb,
        accent: _kAccentAmber,
        title: 'Fallback to rootBundle',
        body:
            'When no DefaultAssetBundle ancestor is found, "of(context)" '
            'falls back to the top-level rootBundle. That means consumers can '
            'always count on getting some AssetBundle without null checks.',
      ),
    ],
  );
}

Widget _signatureRow(String tag, String name, String signature, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color),
          ),
          child: Text(
            tag,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: name,
                  style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 13),
                ),
                const TextSpan(text: '  '),
                TextSpan(
                  text: signature,
                  style: const TextStyle(color: _kInkSoft, fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — AssetBundle API surface
// ===========================================================================

Widget _buildAssetBundleApiCard() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentPurple, _kAccentBlue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.api,
    headerTitle: 'AssetBundle API',
    headerSubtitle: 'The abstract contract every bundle implements',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'The AssetBundle abstract class defines five core operations: load '
        'raw bytes, load a string, load and parse structured text, load and '
        'parse structured binary, and evict cached entries. Concrete '
        'implementations decide where the bytes come from — disk, the '
        'platform asset channel, or the network — but they all expose this '
        'same surface so calling code stays portable.',
      ),
      const SizedBox(height: 14),
      _apiMethodTile(
        icon: Icons.text_snippet,
        accent: _kAccentBlue,
        signature: 'Future<String> loadString(String key, {bool cache = true})',
        description:
            'Load an asset as a UTF-8 string. The "cache" flag decides whether '
            'the implementation may keep the result in memory.',
      ),
      _apiMethodTile(
        icon: Icons.memory,
        accent: _kAccentPurple,
        signature: 'Future<ByteData> load(String key)',
        description:
            'Load an asset as raw bytes. This is the lowest-level entry and '
            'underpins all other loaders.',
      ),
      _apiMethodTile(
        icon: Icons.data_object,
        accent: _kAccentTeal,
        signature: 'Future<T> loadStructuredData<T>(String key, Future<T> Function(String) parser)',
        description:
            'Load a string asset and run a parser. The parsed value is then '
            'cached, not the raw string — saves repeat parsing.',
      ),
      _apiMethodTile(
        icon: Icons.bar_chart,
        accent: _kAccentRose,
        signature: 'Future<T> loadStructuredBinaryData<T>(String key, FutureOr<T> Function(ByteData) parser)',
        description:
            'Binary equivalent of loadStructuredData. Useful for protobuf or '
            'custom binary asset formats.',
      ),
      _apiMethodTile(
        icon: Icons.delete_sweep,
        accent: _kAccentAmber,
        signature: 'void evict(String key)',
        description:
            'Remove an entry from any cache the implementation maintains. '
            'Subsequent loads will re-fetch from the source.',
      ),
      _apiMethodTile(
        icon: Icons.cleaning_services,
        accent: _kAccentGreen,
        signature: 'void clear()',
        description:
            'Drop every cached entry. Often used in hot-restart or test '
            'teardown to ensure a clean slate.',
      ),
      const SizedBox(height: 14),
      _codeEditorPanel(
        title: 'asset_bundle.dart',
        lines: const <String>[
          '// Abstract contract.',
          'abstract class AssetBundle {',
          '  Future<ByteData> load(String key);',
          '  Future<String> loadString(String key, {bool cache = true});',
          '  Future<T> loadStructuredData<T>(',
          '    String key,',
          '    Future<T> Function(String value) parser,',
          '  );',
          '  Future<T> loadStructuredBinaryData<T>(',
          '    String key,',
          '    FutureOr<T> Function(ByteData data) parser,',
          '  );',
          '  void evict(String key) {}',
          '  void clear() {}',
          '}',
        ],
      ),
    ],
  );
}

Widget _apiMethodTile({
  required IconData icon,
  required Color accent,
  required String signature,
  required String description,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                signature,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — NetworkAssetBundle
// ===========================================================================

Widget _buildNetworkAssetBundleSection() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentRose, _kAccentPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.cloud_download,
    headerTitle: 'NetworkAssetBundle',
    headerSubtitle: 'Fetches assets relative to a base URL',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'NetworkAssetBundle is a concrete AssetBundle that resolves keys as '
        'paths relative to a base URI and downloads them via HTTP. It is '
        'useful in development for serving live assets from a local web '
        'server, or in tests where you want assets to come from a deterministic '
        'origin. It does not cache responses — wrap or extend with '
        'CachingAssetBundle if memoization is required.',
      ),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'network_asset_bundle_usage.dart',
        lines: const <String>[
          '// Construct with a base URL — keys are resolved against it.',
          'final remote = NetworkAssetBundle(',
          '  Uri.parse("https://assets.example.com/v1/"),',
          ');',
          '',
          '// loadString resolves to "https://assets.example.com/v1/copy/intro.txt"',
          'final intro = await remote.loadString("copy/intro.txt");',
          '',
          '// load returns ByteData for binary payloads',
          'final ByteData logo = await remote.load("img/logo.png");',
          '',
          '// You can wrap it in DefaultAssetBundle to scope it to a subtree.',
          'DefaultAssetBundle(',
          '  bundle: remote,',
          '  child: const ProductCatalog(),',
          ');',
        ],
      ),
      const SizedBox(height: 12),
      _calloutBox(
        icon: Icons.warning_amber,
        accent: _kAccentRose,
        title: 'Production caveat',
        body:
            'NetworkAssetBundle is intended primarily for development and '
            'testing. Production apps should ship critical assets in the bundle '
            'or use a more robust caching/resilience layer.',
      ),
      const SizedBox(height: 12),
      _twoColumnInfo(
        leftTitle: 'Pros',
        leftItems: const <String>[
          'No app rebuild needed to change assets',
          'Trivial setup with a base URI',
          'Perfect for design previews',
          'Plays nicely with DefaultAssetBundle',
        ],
        rightTitle: 'Cons',
        rightItems: const <String>[
          'No built-in cache',
          'Network latency on every call',
          'Hard to test offline',
          'No retry / backoff strategy',
        ],
      ),
    ],
  );
}

// ===========================================================================
// SECTION 6 — PlatformAssetBundle
// ===========================================================================

Widget _buildPlatformAssetBundleSection() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentGreen, _kAccentTeal],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.smartphone,
    headerTitle: 'PlatformAssetBundle',
    headerSubtitle: 'The default app-bundled asset source',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'PlatformAssetBundle is the default asset bundle Flutter uses when '
        'an app starts. It loads assets through the platform asset channel, '
        'which on each operating system maps to the bundled resources of the '
        'installed app. It composes the CachingAssetBundle mixin so that '
        'parsed structured data and string assets are remembered between '
        'requests for performance.',
      ),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'platform_asset_bundle.dart',
        lines: const <String>[
          '// rootBundle is itself a PlatformAssetBundle instance.',
          'final PlatformAssetBundle bundle = rootBundle as PlatformAssetBundle;',
          '',
          '// Load a config that ships in pubspec.yaml > assets.',
          'final String yaml = await bundle.loadString("config/app.yaml");',
          '',
          '// Or parse JSON via loadStructuredData (parsed value is cached).',
          'final Map<String, dynamic> data = await bundle.loadStructuredData(',
          '  "data/menu.json",',
          '  (raw) async => json.decode(raw) as Map<String, dynamic>,',
          ');',
        ],
      ),
      const SizedBox(height: 12),
      _featureGrid(<List<dynamic>>[
        <dynamic>[Icons.bolt, _kAccentBlue, 'Channel-backed', 'Talks to the embedder over a binary message channel.'],
        <dynamic>[Icons.cached, _kAccentTeal, 'In-memory cache', 'CachingAssetBundle mixin keeps parsed values alive.'],
        <dynamic>[Icons.lock, _kAccentPurple, 'Read-only', 'Cannot mutate the bundled assets at runtime.'],
        <dynamic>[Icons.public, _kAccentAmber, 'Cross-platform', 'Single API across iOS, Android, web, desktop.'],
      ]),
    ],
  );
}

// ===========================================================================
// SECTION 7 — Overriding pattern
// ===========================================================================

Widget _buildOverridingPatternSection() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentBlue, _kAccentTeal],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.swap_horiz,
    headerTitle: 'Overriding pattern',
    headerSubtitle: 'Swapping the bundle for a subtree',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'A common pattern is to install a custom AssetBundle near the root '
        'of a feature, then have descendants resolve assets via '
        'DefaultAssetBundle.of(context). This makes the feature trivially '
        'pluggable — tests inject a mock bundle, previewers inject a network '
        'bundle, and production keeps the platform default. Because the '
        'override is an InheritedWidget, descendants automatically rebuild if '
        'the bundle reference changes.',
      ),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'override_pattern.dart',
        lines: const <String>[
          '// Production: implicit rootBundle (PlatformAssetBundle).',
          'class App extends StatelessWidget {',
          '  @override',
          '  Widget build(BuildContext context) {',
          '    return const MaterialApp(home: HomePage());',
          '  }',
          '}',
          '',
          '// Tests: override with a deterministic bundle.',
          'class TestApp extends StatelessWidget {',
          '  const TestApp({required this.bundle, super.key});',
          '  final AssetBundle bundle;',
          '',
          '  @override',
          '  Widget build(BuildContext context) {',
          '    return DefaultAssetBundle(',
          '      bundle: bundle,',
          '      child: const MaterialApp(home: HomePage()),',
          '    );',
          '  }',
          '}',
        ],
      ),
      const SizedBox(height: 12),
      _flowDiagram(),
      const SizedBox(height: 12),
      _paragraph(
        'The flow above shows how a call site reaches the bundle. Widgets '
        'never depend on a concrete implementation directly; instead they '
        'ask the InheritedWidget for whatever AssetBundle is currently in '
        'scope. The override pattern is what makes Flutter testing of '
        'asset-driven UI possible without running the platform asset channel.',
      ),
    ],
  );
}

Widget _flowDiagram() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5FF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCFD8F0)),
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _flowNode('Widget', _kAccentPurple, Icons.widgets),
            _flowArrow(),
            _flowNode('of(context)', _kAccentBlue, Icons.search),
            _flowArrow(),
            _flowNode('AssetBundle', _kAccentTeal, Icons.inventory_2),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Widget asks for the bundle, which the InheritedWidget resolves to '
          'either the override or rootBundle.',
          textAlign: TextAlign.center,
          style: TextStyle(color: _kInkSoft, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _flowNode(String label, Color color, IconData icon) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ],
      ),
    ),
  );
}

Widget _flowArrow() {
  return const SizedBox(
    width: 28,
    child: Icon(Icons.arrow_forward, color: _kInkSoft, size: 20),
  );
}

// ===========================================================================
// SECTION 8 — Caching diagram
// ===========================================================================

Widget _buildCachingDiagram() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentTeal, _kAccentGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.cached,
    headerTitle: 'CachingAssetBundle',
    headerSubtitle: 'Mixin that memoizes loadString and loadStructuredData',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'CachingAssetBundle is a mixin that adds a per-instance, in-memory '
        'cache of strings and parsed structured data. It is the reason '
        'PlatformAssetBundle is fast on repeat reads — once a key is loaded, '
        'subsequent calls are served from a Map. The cache is invalidated '
        'manually via evict(key) or wholesale via clear().',
      ),
      const SizedBox(height: 12),
      _cacheVisualization(),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'caching_asset_bundle_lookup.dart',
        lines: const <String>[
          '// First call — cold cache, hits the source.',
          'final t0 = await rootBundle.loadString("copy/intro.txt"); // SLOW',
          '',
          '// Second call — warm cache, served from memory.',
          'final t1 = await rootBundle.loadString("copy/intro.txt"); // FAST',
          '',
          '// Force a refresh.',
          'rootBundle.evict("copy/intro.txt");',
          'final t2 = await rootBundle.loadString("copy/intro.txt"); // SLOW again',
          '',
          '// Drop everything (e.g. on locale change).',
          'rootBundle.clear();',
        ],
      ),
      const SizedBox(height: 12),
      _calloutBox(
        icon: Icons.tips_and_updates,
        accent: _kAccentTeal,
        title: 'Cache key sanity',
        body:
            'Cache keys are exact strings — "img/logo.png" and "/img/logo.png" '
            'are different cache entries. Normalize keys at the call site to '
            'avoid duplicated cache slots for the same logical asset.',
      ),
    ],
  );
}

Widget _cacheVisualization() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFE8F8F4), Color(0xFFEAF1FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFC7E5DC)),
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _cacheBox('loadString("a")', 'MISS', _kAccentRose),
            const SizedBox(width: 8),
            _cacheBox('loadString("a")', 'HIT', _kAccentGreen),
            const SizedBox(width: 8),
            _cacheBox('evict("a")', '—', _kAccentAmber),
            const SizedBox(width: 8),
            _cacheBox('loadString("a")', 'MISS', _kAccentRose),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccentTeal),
          ),
          child: const Row(
            children: <Widget>[
              Icon(Icons.storage, color: _kAccentTeal),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'In-memory map<String, Future<String>>  +  map<String, Future<Object>>',
                  style: TextStyle(
                    color: _kInk,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _cacheBox(String label, String state, Color accent) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kInk,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              state,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 9 — "Live" DefaultAssetBundle widget
// ===========================================================================

Widget _buildLiveDefaultAssetBundleSection() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentPurple, _kAccentRose],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.preview,
    headerTitle: 'Live DefaultAssetBundle',
    headerSubtitle: 'A real instance wrapping a passive child',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'The card below contains a real DefaultAssetBundle widget wrapping a '
        'small passive child. The child reads '
        'DefaultAssetBundle.of(context).runtimeType and renders it inside its '
        'card so you can confirm that the override actually reaches '
        'descendants. No assets are loaded — this is purely a runtime '
        'identity check.',
      ),
      const SizedBox(height: 14),
      DefaultAssetBundle(
        bundle: rootBundle,
        child: Builder(
          builder: (BuildContext innerContext) {
            final AssetBundle resolved = DefaultAssetBundle.of(innerContext);
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFFFF7F5), Color(0xFFF5F0FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kAccentPurple.withOpacity(0.4)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _kAccentPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.fingerprint, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Resolved bundle runtimeType',
                        style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _kCodeBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'DefaultAssetBundle.of(context).runtimeType\n  → ${resolved.runtimeType}',
                      style: const TextStyle(
                        color: _kCodeText,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This child was resolved through a DefaultAssetBundle wrapping rootBundle.',
                    style: TextStyle(color: _kInkSoft, fontSize: 11.5),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 12),
      _calloutBox(
        icon: Icons.verified,
        accent: _kAccentGreen,
        title: 'No I/O performed',
        body:
            'This widget intentionally does not call load*, loadString, or '
            'loadStructuredData. Doing so under d4rt would attempt real asset '
            'I/O which is not supported in interpreted execution.',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 10 — Usage guide
// ===========================================================================

Widget _buildUsageGuide() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kAccentAmber, _kAccentGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.school,
    headerTitle: 'Usage guide',
    headerSubtitle: 'Picking the right bundle for the job',
    children: <Widget>[
      const SizedBox(height: 12),
      _paragraph(
        'Most apps never need to think about AssetBundle directly — '
        'AssetImage, FontLoader, and other Flutter widgets pull from '
        'DefaultAssetBundle.of(context) under the hood. You will only reach '
        'for it explicitly when reading raw text or binary data, when writing '
        'tests that need deterministic asset resolution, or when wiring up '
        'localized or remote asset sources.',
      ),
      const SizedBox(height: 12),
      _decisionTable(),
      const SizedBox(height: 12),
      _codeEditorPanel(
        title: 'composing_a_caching_network_bundle.dart',
        lines: const <String>[
          '// Compose CachingAssetBundle on top of a network source.',
          'class CachingNetworkAssetBundle extends NetworkAssetBundle',
          '    with CachingAssetBundle {',
          '  CachingNetworkAssetBundle(super.baseUrl);',
          '}',
          '',
          '// Now loadString memoizes results, just like rootBundle.',
          'final cached = CachingNetworkAssetBundle(Uri.parse("https://cdn.example.com/"));',
          'final intro1 = await cached.loadString("intro.md"); // miss',
          'final intro2 = await cached.loadString("intro.md"); // hit',
        ],
      ),
      const SizedBox(height: 12),
      _paragraph(
        'Composing CachingAssetBundle on top of NetworkAssetBundle is one of '
        'the most useful real-world tricks. It gives you a network-backed '
        'bundle without paying for repeat downloads, and because it still '
        'extends AssetBundle it can be installed as the override in any '
        'DefaultAssetBundle higher up the tree.',
      ),
    ],
  );
}

Widget _decisionTable() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E4F0)),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      children: <Widget>[
        _decisionHeader(),
        _decisionRow('You ship the asset in pubspec.yaml', 'rootBundle (PlatformAssetBundle)', _kAccentGreen),
        _decisionRow('You serve assets from a dev server', 'NetworkAssetBundle', _kAccentRose),
        _decisionRow('You want repeat-load caching on a network bundle', 'NetworkAssetBundle + CachingAssetBundle mixin', _kAccentTeal),
        _decisionRow('You write a widget test with mock assets', 'TestAssetBundle (custom subclass)', _kAccentPurple),
        _decisionRow('You scope a bundle to one feature subtree', 'DefaultAssetBundle wrap', _kAccentAmber),
        _decisionRow('You parse JSON / YAML once and reuse', 'loadStructuredData', _kAccentBlue),
      ],
    ),
  );
}

Widget _decisionHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kAccentBlue, _kAccentPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    child: const Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            'Scenario',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Recommended bundle',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _decisionRow(String scenario, String recommendation, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFE6EAF5))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            scenario,
            style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.4),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: accent),
            ),
            child: Text(
              recommendation,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — Footer card
// ===========================================================================

Widget _buildFooterCard() {
  return _shellCard(
    headerGradient: const LinearGradient(
      colors: <Color>[_kInk, _kAccentBlue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    headerIcon: Icons.bookmark,
    headerTitle: 'Reference summary',
    headerSubtitle: 'Snapshot of every type covered above',
    children: <Widget>[
      const SizedBox(height: 12),
      _summaryRow('AssetBundle', 'abstract base', 'load / loadString / loadStructuredData / load­StructuredBinaryData / evict / clear', _kAccentBlue),
      _summaryRow('PlatformAssetBundle', 'concrete', 'Default — loads via platform asset channel; mixes in CachingAssetBundle', _kAccentPurple),
      _summaryRow('NetworkAssetBundle', 'concrete', 'Loads via HTTP relative to a base URI; no caching by default', _kAccentRose),
      _summaryRow('CachingAssetBundle', 'mixin', 'Adds in-memory cache for strings and parsed data', _kAccentTeal),
      _summaryRow('DefaultAssetBundle', 'InheritedWidget', 'Wraps a subtree to override the bundle for descendants', _kAccentAmber),
      _summaryRow('rootBundle', 'top-level final', 'Default global PlatformAssetBundle instance', _kAccentGreen),
      const SizedBox(height: 12),
      _paragraph(
        'Together these types let you ship a single asset-loading API across '
        'platforms, override it surgically per subtree, swap it wholesale for '
        'tests, and decorate it with caching when remote sources are involved. '
        'Reach for DefaultAssetBundle whenever a feature needs its own slice '
        'of the asset world.',
      ),
    ],
  );
}

Widget _summaryRow(String name, String kind, String description, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(top: 2, right: 10),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      kind,
                      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(color: _kInk, fontSize: 12, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Shared building blocks
// ===========================================================================

Widget _shellCard({
  required Gradient headerGradient,
  required IconData headerIcon,
  required String headerTitle,
  required String headerSubtitle,
  required List<Widget> children,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kCardSurface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x1F000000), blurRadius: 14, offset: Offset(0, 4)),
        BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: headerGradient,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Icon(headerIcon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      headerTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      headerSubtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.86),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    ),
  );
}

Widget _paragraph(String text) {
  return Text(
    text,
    style: const TextStyle(color: _kInk, fontSize: 13.5, height: 1.5),
  );
}

Widget _bulletRow(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6, right: 10),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kInk, fontSize: 13, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _calloutBox({
  required IconData icon,
  required Color accent,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: accent, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _codeEditorPanel({
  required String title,
  required List<String> lines,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: _kCodeBgAlt,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              _trafficDot(const Color(0xFFFF5F56)),
              const SizedBox(width: 6),
              _trafficDot(const Color(0xFFFFBD2E)),
              const SizedBox(width: 6),
              _trafficDot(const Color(0xFF27C93F)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFB6B9D0),
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.code, color: Color(0xFFB6B9D0), size: 14),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _renderCodeLines(lines),
          ),
        ),
      ],
    ),
  );
}

Widget _trafficDot(Color color) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

List<Widget> _renderCodeLines(List<String> lines) {
  final List<Widget> rendered = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    rendered.add(_codeLine(i + 1, lines[i]));
  }
  return rendered;
}

Widget _codeLine(int number, String content) {
  final Color textColor = content.trimLeft().startsWith('//') ? _kCodeComment : _kCodeText;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 28,
          child: Text(
            number.toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF6E7191),
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            content.isEmpty ? ' ' : content,
            style: TextStyle(
              color: textColor,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _twoColumnInfo({
  required String leftTitle,
  required List<String> leftItems,
  required String rightTitle,
  required List<String> rightItems,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _infoColumn(leftTitle, leftItems, _kAccentGreen, Icons.thumb_up)),
      const SizedBox(width: 10),
      Expanded(child: _infoColumn(rightTitle, rightItems, _kAccentRose, Icons.warning_amber)),
    ],
  );
}

Widget _infoColumn(String title, List<String> items, Color accent, IconData icon) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check_circle, color: accent, size: 14),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                items[i],
                style: const TextStyle(color: _kInk, fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 16),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 12.5),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
      ],
    ),
  );
}

Widget _featureGrid(List<List<dynamic>> entries) {
  // Each entry: [IconData, Color, String title, String subtitle]
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < entries.length; i += 2) {
    final List<dynamic> first = entries[i];
    final bool hasSecond = i + 1 < entries.length;
    final List<dynamic> second = hasSecond ? entries[i + 1] : <dynamic>[];
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _featureTile(
                first[0] as IconData,
                first[1] as Color,
                first[2] as String,
                first[3] as String,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: hasSecond
                  ? _featureTile(
                      second[0] as IconData,
                      second[1] as Color,
                      second[2] as String,
                      second[3] as String,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
  return Column(children: rows);
}

Widget _featureTile(IconData icon, Color accent, String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[accent.withOpacity(0.10), accent.withOpacity(0.02)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.4)),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: _kInk, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );
}
