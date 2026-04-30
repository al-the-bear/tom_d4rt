// ignore_for_file: avoid_print
// Deep demo: CachingAssetBundle
// Demonstrates CachingAssetBundle — an AssetBundle implementation
// that caches previously loaded assets in memory so subsequent
// lookups return immediately without re-reading from disk or network.
import 'package:flutter/material.dart';

// ─── palette: Forest / Sage ───────────────────────────────────────
const Color _cbForest = Color(0xFF1B5E20);
const Color _cbSage = Color(0xFFE8F5E9);
const Color _cbAccent = Color(0xFF388E3C);
const Color _cbDark = Color(0xFF1A1A1A);
const Color _cbBlue = Color(0xFF1565C0);
const Color _cbOrange = Color(0xFFEF6C00);
const Color _cbPurple = Color(0xFF6A1B9A);
const Color _cbTeal = Color(0xFF00695C);
const Color _cbRed = Color(0xFFC62828);

// ─── text helpers ─────────────────────────────────────────────────
Widget _cbTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _cbForest,
              letterSpacing: 0.3)),
    );

Widget _cbSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _cbAccent)),
    );

Widget _cbBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _cbCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cbDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFA5D6A7),
              height: 1.5)),
    );

Widget _cbNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cbSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _cbForest.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.cached, size: 16, color: _cbForest),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _cbForest, height: 1.4)),
          ),
        ],
      ),
    );

Widget _cbDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _cbForest.withValues(alpha: 0.1)),
    );

Widget _cbBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
                color: _cbAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _cbTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _cbLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _cbForest,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _cbBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_cbForest, Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.storage_outlined, size: 48, color: _cbSage),
          const SizedBox(height: 10),
          const Text('CachingAssetBundle',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('In-memory caching layer for asset loading',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _cbTag('services', _cbAccent),
              _cbTag('assets', _cbBlue),
              _cbTag('caching', _cbPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _cbWhatIs() => [
      _cbTitle('§2  What Is CachingAssetBundle?'),
      _cbBody(
          'CachingAssetBundle is an abstract AssetBundle subclass that '
          'wraps asset loading with in-memory caching. Once an asset '
          'has been loaded by key, subsequent calls with the same key '
          'return the cached ByteData or String immediately, avoiding '
          'repeated file I/O or network roundtrips.'),
      _cbCode(
          'abstract class CachingAssetBundle extends AssetBundle {\n'
          '  // String cache: key -> structured data\n'
          '  final Map<String, Future<String>> _stringCache =\n'
          '      <String, Future<String>>{};\n'
          '\n'
          '  // Structured data cache: key -> decoded result\n'
          '  final Map<String, Future<dynamic>> _structuredDataCache =\n'
          '      <String, Future<dynamic>>{};\n'
          '}'),
      _cbNote(
          'CachingAssetBundle itself is abstract. The default '
          'rootBundle and DefaultAssetBundle.of(context) both return '
          'a PlatformAssetBundle, which extends CachingAssetBundle.'),
    ];

// ─── §3 Inheritance hierarchy ────────────────────────────────────
List<Widget> _cbHierarchy() => [
      _cbDivider(),
      _cbTitle('§3  Inheritance Hierarchy'),
      _cbBody(
          'CachingAssetBundle sits between the abstract AssetBundle '
          'and the concrete platform implementation:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cbHierNode(0, 'AssetBundle', 'Abstract base',
                _cbForest),
            _cbHierNode(1, 'CachingAssetBundle',
                'Adds in-memory caching', _cbAccent),
            _cbHierNode(2, 'PlatformAssetBundle',
                'Production implementation', _cbBlue),
            _cbHierNode(2, 'NetworkAssetBundle',
                'HTTP-based loading (also extends AssetBundle)',
                _cbOrange),
          ],
        ),
      ),
      _cbBullet('AssetBundle',
          'Defines load(), loadString(), loadStructuredData()'),
      _cbBullet('CachingAssetBundle',
          'Overrides loadString/loadStructuredData with cache'),
      _cbBullet('PlatformAssetBundle',
          'Loads from the app bundle via platform channels'),
    ];

Widget _cbHierNode(int depth, String name, String desc, Color c) =>
    Padding(
      padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §4 How caching works ────────────────────────────────────────
List<Widget> _cbCacheMechanism() => [
      _cbDivider(),
      _cbTitle('§4  How Caching Works'),
      _cbBody(
          'CachingAssetBundle maintains two separate caches — one for '
          'raw strings and one for structured data (decoded JSON, YAML, '
          'etc.). The caching strategy is straightforward:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _cbFlowStep(1, 'loadString(key) called',
                'Check _stringCache[key]', _cbForest, Icons.search),
            _cbFlowStep(2, 'Cache miss',
                'Call super.load(key) for ByteData', _cbBlue,
                Icons.download),
            _cbFlowStep(3, 'Decode bytes',
                'UTF-8 decode ByteData to String', _cbAccent,
                Icons.text_snippet),
            _cbFlowStep(4, 'Store in cache',
                '_stringCache[key] = Future.value(string)', _cbOrange,
                Icons.save),
            _cbFlowStep(5, 'Return',
                'Return cached Future<String>', _cbPurple,
                Icons.check_circle_outline),
          ],
        ),
      ),
      _cbSubtitle('String cache flow'),
      _cbCode(
          '@override\n'
          'Future<String> loadString(String key,\n'
          '    {bool cache = true}) {\n'
          '  if (cache) {\n'
          '    return _stringCache.putIfAbsent(\n'
          '      key,\n'
          '      () => _fetchString(key),\n'
          '    );\n'
          '  }\n'
          '  return _fetchString(key); // bypass cache\n'
          '}'),
      _cbSubtitle('Structured data cache flow'),
      _cbCode(
          '@override\n'
          'Future<T> loadStructuredData<T>(\n'
          '  String key,\n'
          '  Future<T> Function(String value) parser,\n'
          ') {\n'
          '  return _structuredDataCache.putIfAbsent(\n'
          '    key,\n'
          '    () => loadString(key)\n'
          '        .then<T>(parser),\n'
          '  ) as Future<T>;\n'
          '}'),
    ];

Widget _cbFlowStep(
    int step, String name, String desc, Color c, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text('$step',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18, color: c),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10.5, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §5 Cache lifetime ───────────────────────────────────────────
List<Widget> _cbLifetime() => [
      _cbDivider(),
      _cbTitle('§5  Cache Lifetime'),
      _cbBody(
          'The caches live for the duration of the AssetBundle. '
          'In a typical Flutter app, this means the cache persists '
          'for the lifetime of the application:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cbLabel('Cache events timeline'),
            const SizedBox(height: 10),
            _cbTimeEvent('App start', 'Bundle created, caches empty',
                _cbForest),
            _cbTimeEvent('First load', 'Asset fetched from disk, cached',
                _cbBlue),
            _cbTimeEvent('Second load', 'Returned from cache (no I/O)',
                _cbAccent),
            _cbTimeEvent('evict(key)', 'Single entry removed from cache',
                _cbOrange),
            _cbTimeEvent('clear()', 'Both caches fully emptied',
                _cbRed),
            _cbTimeEvent('Hot reload',
                'Framework calls evict() for changed assets', _cbPurple),
          ],
        ),
      ),
      _cbCode(
          '// Force an asset to be re-loaded from disk:\n'
          'rootBundle.evict(\'assets/data/config.json\');\n'
          '\n'
          '// Clear everything (rarely needed):\n'
          '// The clear() method removes all cached entries.\n'
          '// During hot reload, the framework automatically\n'
          '// evicts changed assets.'),
      _cbNote(
          'During hot reload, the Flutter framework calls evict() '
          'for any assets that changed on disk, ensuring that '
          'loadString() and loadStructuredData() see fresh data.'),
    ];

Widget _cbTimeEvent(String event, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$event — ',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: c)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 11.5, color: Colors.black54)),
              ]),
            ),
          ),
        ],
      ),
    );

// ─── §6 Method reference ─────────────────────────────────────────
List<Widget> _cbMethods() => [
      _cbDivider(),
      _cbTitle('§6  Method Reference'),
      _cbBody(
          'Key methods provided or overridden by CachingAssetBundle:'),
      _cbMethodCard('loadString(key, {cache})', 'Future<String>',
          'Load asset as UTF-8 string with optional caching',
          _cbForest),
      _cbMethodCard('loadStructuredData<T>(key, parser)',
          'Future<T>',
          'Load, parse, and cache structured data',
          _cbBlue),
      _cbMethodCard('evict(key)', 'void',
          'Remove a specific key from both caches',
          _cbOrange),
      _cbMethodCard('clear()', 'void',
          'Remove all entries from both caches',
          _cbRed),
      _cbMethodCard('load(key)', 'Future<ByteData>',
          'Raw byte loading (inherited, not cached at this level)',
          _cbPurple),
      _cbMethodCard('loadBuffer(key)', 'Future<ImmutableBuffer>',
          'Load raw bytes as immutable buffer (inherited)',
          _cbTeal),
    ];

Widget _cbMethodCard(String name, String ret, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: c.withValues(alpha: 0.15)),
      boxShadow: [
        BoxShadow(
            color: c.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2)),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: c,
                            fontFamily: 'monospace')),
                  ),
                  Text(ret,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §7 Common asset types ───────────────────────────────────────
List<Widget> _cbAssetTypes() => [
      _cbDivider(),
      _cbTitle('§7  Common Asset Types'),
      _cbBody(
          'CachingAssetBundle is used for various asset types in '
          'a Flutter application:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _cbAssetRow(Icons.description, 'JSON',
                'Configuration, translations, API schemas', _cbForest),
            _cbAssetRow(Icons.image, 'Images',
                'Via load() for raw bytes — not string-cached', _cbBlue),
            _cbAssetRow(Icons.font_download, 'Fonts',
                'Font files loaded via loadBuffer()', _cbAccent),
            _cbAssetRow(Icons.code, 'YAML / TOML',
                'Structured config via loadStructuredData()', _cbOrange),
            _cbAssetRow(Icons.text_snippet, 'Text / Markdown',
                'Help text, licenses, documentation', _cbPurple),
            _cbAssetRow(Icons.auto_graph, 'Shader programs',
                'FragmentProgram loads via loadBuffer()', _cbTeal),
          ],
        ),
      ),
      _cbNote(
          'Only loadString() and loadStructuredData() go through '
          'the CachingAssetBundle cache. Raw byte loading (load, '
          'loadBuffer) bypasses the string/structured caches.'),
    ];

Widget _cbAssetRow(IconData icon, String type, String desc, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: c),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §8 DefaultAssetBundle ───────────────────────────────────────
List<Widget> _cbDefaultBundle() => [
      _cbDivider(),
      _cbTitle('§8  DefaultAssetBundle'),
      _cbBody(
          'In practice, widgets access the CachingAssetBundle via '
          'DefaultAssetBundle.of(context), which provides the asset '
          'bundle for the current subtree:'),
      _cbCode(
          '// How widgets typically load assets:\n'
          'final bundle = DefaultAssetBundle.of(context);\n'
          'final json = await bundle.loadString(\n'
          '    \'assets/data/items.json\');\n'
          '\n'
          '// Or structured data with parsing:\n'
          'final items = await bundle.loadStructuredData<List>(\n'
          '  \'assets/data/items.json\',\n'
          '  (String value) async => jsonDecode(value) as List,\n'
          ');\n'
          '\n'
          '// For testing, wrap with a custom bundle:\n'
          'DefaultAssetBundle(\n'
          '  bundle: TestAssetBundle(),\n'
          '  child: MyWidget(),\n'
          ')'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _cbBundleCard('rootBundle',
                  'Global singleton, always available',
                  'Top-level asset loading',
                  _cbForest),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _cbBundleCard('DefaultAssetBundle.of()',
                  'Inherited widget lookup',
                  'Context-aware, mockable for tests',
                  _cbBlue),
            ),
          ],
        ),
      ),
    ];

Widget _cbBundleCard(
    String name, String desc, String detail, Color c) =>
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: c,
                  fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(
                  fontSize: 10.5, color: Colors.black54)),
          const SizedBox(height: 2),
          Text(detail,
              style: TextStyle(
                  fontSize: 10, color: c.withValues(alpha: 0.8))),
        ],
      ),
    );

// ─── §9 Comparison ───────────────────────────────────────────────
List<Widget> _cbComparison() => [
      _cbDivider(),
      _cbTitle('§9  AssetBundle Implementations Compared'),
      _cbBody(
          'Flutter provides several AssetBundle implementations for '
          'different scenarios:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _cbSage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _cbCompEntry('CachingAssetBundle',
                'Abstract; adds string and structured data caching',
                _cbForest),
            _cbCompEntry('PlatformAssetBundle',
                'Default production bundle; extends CachingAssetBundle',
                _cbBlue),
            _cbCompEntry('NetworkAssetBundle',
                'Loads from URLs via HTTP; no caching',
                _cbOrange),
            _cbCompEntry('TestAssetBundle',
                'Returns predefined data; for widget tests',
                _cbPurple),
          ],
        ),
      ),
      _cbBullet('Caching', 'Only CachingAssetBundle (and subclasses) cache'),
      _cbBullet('Network', 'NetworkAssetBundle hits HTTP each time'),
      _cbBullet('Testing',
          'DefaultAssetBundle widget allows bundle injection'),
    ];

Widget _cbCompEntry(String name, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 32,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c,
                        fontFamily: 'monospace')),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _cbSummary() => [
      _cbDivider(),
      _cbTitle('§10  Summary'),
      _cbBody(
          'CachingAssetBundle is the caching backbone of Flutter\'s '
          'asset system, ensuring that repeated asset loads do not '
          'incur repeated I/O.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_cbForest.withValues(alpha: 0.07), _cbSage],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _cbForest.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _cbForest)),
            const SizedBox(height: 10),
            _cbSumPt('Two caches',
                'Separate string and structured-data caches'),
            _cbSumPt('putIfAbsent',
                'Cache-miss triggers load, cache-hit returns Future'),
            _cbSumPt('evict / clear',
                'Manual cache invalidation when assets change'),
            _cbSumPt('Hot reload aware',
                'Framework auto-evicts changed resources'),
            _cbSumPt('Abstract class',
                'PlatformAssetBundle is the concrete implementation'),
            _cbSumPt('DefaultAssetBundle',
                'Preferred way to access the bundle from widgets'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _cbForest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of CachingAssetBundle Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _cbSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _cbAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _cbForest)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cbBanner(),
        const SizedBox(height: 20),
        ..._cbWhatIs(),
        ..._cbHierarchy(),
        ..._cbCacheMechanism(),
        ..._cbLifetime(),
        ..._cbMethods(),
        ..._cbAssetTypes(),
        ..._cbDefaultBundle(),
        ..._cbComparison(),
        ..._cbSummary(),
      ],
    ),
  );
}
