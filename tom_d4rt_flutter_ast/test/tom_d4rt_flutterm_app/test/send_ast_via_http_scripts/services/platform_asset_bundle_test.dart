// ignore_for_file: avoid_print
// D4rt deep demo: PlatformAssetBundle — loads assets from the platform's
// native asset bundle using rootBundle, asset manifest, and path resolution.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Amber / Gold palette ───
  const Color amber = Color(0xFFF59E0B);
  const Color gold = Color(0xFFD97706);
  const Color deepAmber = Color(0xFF92400E);
  const Color paleAmber = Color(0xFFFEF3C7);
  const Color honeycomb = Color(0xFFFBBF24);
  const Color bronze = Color(0xFFB45309);
  const Color wheat = Color(0xFFFDE68A);
  const Color caramel = Color(0xFF78350F);
  const Color cream = Color(0xFFFFFBEB);
  const Color tawny = Color(0xFFF97316);

  print('[pa] ===== PLATFORM ASSET BUNDLE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget paBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [caramel, deepAmber],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: caramel.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: amber,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: wheat, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: TextStyle(
                      color: caramel,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget paNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleAmber,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wheat),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: caramel.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget paCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wheat.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: caramel.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: amber.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: caramel)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget paRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? amber.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: wheat.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? caramel : deepAmber)),
          );
        }).toList(),
      ),
    );
  }

  Widget paFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? caramel : deepAmber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: amber),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is PlatformAssetBundle? ━━━━━━
  print('[pa-01] Section 1: What is PlatformAssetBundle?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('01', 'What Is PlatformAssetBundle?'),
      paNote(
        'PlatformAssetBundle is the default implementation of AssetBundle '
        'that loads assets packaged with the Flutter application. It reads '
        'assets declared in pubspec.yaml via rootBundle, handling path '
        'resolution, variant selection, and binary decoding.',
      ),
      paCard(
        'Asset Loading Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paFlow(['pubspec.yaml', 'flutter build', 'AssetManifest',
                'rootBundle.load()', 'ByteData']),
            const SizedBox(height: 10),
            _paRoleBadge('Declares', 'pubspec.yaml flutter:assets section', caramel),
            _paRoleBadge('Bundles', 'Build tool copies to asset dir', deepAmber),
            _paRoleBadge('Manifests', 'AssetManifest.json maps keys', bronze),
            _paRoleBadge('Loads', 'rootBundle fetches bytes', amber),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: rootBundle ━━━━━━
  print('[pa-02] Section 2: rootBundle');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('02', 'rootBundle — The Global Entry Point'),
      paNote(
        'rootBundle is a top-level property in services.dart that gives '
        'access to the main asset bundle. It is a PlatformAssetBundle '
        'by default. Widgets can also use DefaultAssetBundle.of(context) '
        'for testable asset loading.',
      ),
      paCard(
        'rootBundle vs DefaultAssetBundle',
        Column(
          children: [
            paRow(['Approach', 'Source', 'Testable?'], isHeader: true),
            paRow(['rootBundle', 'Global singleton', 'Hard to mock']),
            paRow(['DefaultAssetBundle.of()', 'InheritedWidget', 'Yes — wrap in test']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: AssetBundle API ━━━━━━
  print('[pa-03] Section 3: AssetBundle API');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('03', 'AssetBundle API'),
      paNote(
        'AssetBundle is the abstract class. PlatformAssetBundle is one '
        'implementation. The API provides load() for raw bytes, '
        'loadString() for text, loadStructuredData() for parsed formats '
        'like JSON, and evict() to clear cached assets.',
      ),
      paCard(
        'Core Methods',
        Column(
          children: [
            paRow(['Method', 'Returns', 'Use Case'], isHeader: true),
            paRow(['load(key)', 'Future<ByteData>', 'Binary files']),
            paRow(['loadString(key)', 'Future<String>', 'Text / JSON']),
            paRow(['loadStructuredData()', 'Future<T>', 'Parsed data']),
            paRow(['loadBuffer(key)', 'Future<ImmutableBuffer>', 'Optimized binary']),
            paRow(['evict(key)', 'void', 'Clear from cache']),
            paRow(['clear()', 'void', 'Clear all cached']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Asset manifest ━━━━━━
  print('[pa-04] Section 4: Asset manifest');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('04', 'Asset Manifest'),
      paNote(
        'The build tool creates AssetManifest.json (legacy) and '
        'AssetManifest.smcbin (binary, faster). The manifest maps '
        'logical asset keys to their physical bundle paths, including '
        'resolution variants (2.0x, 3.0x) and flavor variants.',
      ),
      paCard(
        'Manifest Structure',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paCodeLine('AssetManifest.json:', caramel),
              _paCodeLine('{', deepAmber),
              _paCodeLine('  "assets/logo.png": [', bronze),
              _paCodeLine('    "assets/logo.png",', bronze),
              _paCodeLine('    "assets/2.0x/logo.png",', bronze),
              _paCodeLine('    "assets/3.0x/logo.png"', bronze),
              _paCodeLine('  ]', bronze),
              _paCodeLine('}', deepAmber),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Resolution-aware images ━━━━━━
  print('[pa-05] Section 5: Resolution-aware images');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('05', 'Resolution-Aware Image Assets'),
      paNote(
        'Flutter automatically selects the best resolution variant based '
        'on the device pixel ratio. Place variants in 1.5x/, 2.0x/, 3.0x/ '
        'sub-folders. The bundle resolves to the closest match.',
      ),
      paCard(
        'Variant Selection',
        Column(
          children: [
            paRow(['Device DPR', 'Selects', 'Folder'], isHeader: true),
            paRow(['1.0', '1.0x', 'assets/']),
            paRow(['1.5', '1.5x', 'assets/1.5x/']),
            paRow(['2.0', '2.0x', 'assets/2.0x/']),
            paRow(['3.0', '3.0x', 'assets/3.0x/']),
            paRow(['3.5', '3.0x (closest)', 'assets/3.0x/']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Text and JSON loading ━━━━━━
  print('[pa-06] Section 6: Text and JSON loading');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('06', 'Loading Text and JSON'),
      paNote(
        'loadString() reads text assets with UTF-8 decoding and optional '
        'caching. loadStructuredData() parses the result through a '
        'callback — perfect for JSON config files, translations, etc. '
        'The structured data is cached by key.',
      ),
      paCard(
        'Loading Patterns',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paCodeLine('// Text asset', caramel),
              _paCodeLine("final txt = await bundle.loadString('assets/about.txt');", deepAmber),
              const SizedBox(height: 6),
              _paCodeLine('// JSON asset with caching', caramel),
              _paCodeLine("final config = await bundle.loadStructuredData<Map>(", deepAmber),
              _paCodeLine("  'assets/config.json',", deepAmber),
              _paCodeLine("  (str) async => jsonDecode(str) as Map,", deepAmber),
              _paCodeLine(");", deepAmber),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Binary loading ━━━━━━
  print('[pa-07] Section 7: Binary loading');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('07', 'Binary Asset Loading'),
      paNote(
        'load() returns ByteData — suitable for fonts, shaders, protobuf. '
        'loadBuffer() returns ImmutableBuffer which is more efficient for '
        'painting as it avoids an extra copy. Use loadBuffer when feeding '
        'data directly to the engine.',
      ),
      paCard(
        'Binary Methods',
        Column(
          children: [
            paRow(['Method', 'Return', 'Copy?', 'Best For'], isHeader: true),
            paRow(['load()', 'ByteData', '1 copy', 'General binary']),
            paRow(['loadBuffer()', 'ImmutableBuffer', '0 copy', 'Images/shaders']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Caching ━━━━━━
  print('[pa-08] Section 8: Caching');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('08', 'Asset Caching'),
      paNote(
        'PlatformAssetBundle caches loadString and loadStructuredData '
        'results by key. Binary data from load() is NOT cached by default. '
        'Use evict(key) to remove a single entry, or clear() to drop '
        'everything — useful on memory warnings.',
      ),
      paCard(
        'Cache Behavior',
        Column(
          children: [
            paRow(['Operation', 'Cached?', 'Clear With'], isHeader: true),
            paRow(['loadString()', 'Yes', 'evict(key)']),
            paRow(['loadStructuredData()', 'Yes', 'evict(key)']),
            paRow(['load()', 'No', 'n/a']),
            paRow(['loadBuffer()', 'No', 'n/a']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: pubspec.yaml declaration ━━━━━━
  print('[pa-09] Section 9: pubspec.yaml');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('09', 'Declaring Assets in pubspec.yaml'),
      paNote(
        'Assets must be listed under flutter: assets: in pubspec.yaml. '
        'You can list individual files or entire directories (trailing /). '
        'Sub-directories are NOT automatically included; each level must '
        'be declared explicitly.',
      ),
      paCard(
        'Declaration Patterns',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paCodeLine('flutter:', caramel),
              _paCodeLine('  assets:', caramel),
              _paCodeLine('    - assets/logo.png        # single file', deepAmber),
              _paCodeLine('    - assets/images/         # entire folder', deepAmber),
              _paCodeLine('    - assets/images/icons/   # sub-folder too', deepAmber),
              _paCodeLine('    - assets/config.json     # JSON config', deepAmber),
              _paCodeLine('    - packages/pkg/asset.txt # package asset', bronze),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Font assets ━━━━━━
  print('[pa-10] Section 10: Font assets');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('10', 'Font Asset Loading'),
      paNote(
        'Fonts are loaded through the asset bundle with a dedicated '
        'flutter:fonts section in pubspec.yaml. FontLoader can dynamically '
        'load fonts at runtime by reading bytes from the bundle and '
        'registering them with the engine.',
      ),
      paCard(
        'Font Loading',
        Column(
          children: [
            paRow(['Source', 'Method', 'When'], isHeader: true),
            paRow(['pubspec.yaml', 'fonts: section', 'Build time']),
            paRow(['rootBundle.load()', 'FontLoader.addFont', 'Runtime']),
            paRow(['Network fetch', 'FontLoader.addFont', 'Runtime']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Package assets ━━━━━━
  print('[pa-11] Section 11: Package assets');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('11', 'Package Assets'),
      paNote(
        'Assets from Dart packages are accessed with the packages/ prefix: '
        'packages/my_pkg/assets/file.png. The package must list its own '
        'assets in pubspec.yaml. The consuming app does NOT need to '
        're-declare them.',
      ),
      paCard(
        'Package Asset Resolution',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paFlow(['packages/pkg_name/', 'lib/', 'assets/', 'file.png']),
            const SizedBox(height: 10),
            _paKeyValue('Asset key', 'packages/my_pkg/assets/icon.svg', caramel),
            _paKeyValue('Physical path', 'lib/assets/icon.svg in package', deepAmber),
            _paKeyValue('Resolution', 'Same 2.0x/3.0x rules apply', bronze),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Error handling ━━━━━━
  print('[pa-12] Section 12: Error handling');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('12', 'Error Handling'),
      paNote(
        'Asset loading can fail with FlutterError when the key is not '
        'found in the manifest. Common causes: typo in key, missing '
        'pubspec declaration, missing build step. Always handle errors '
        'with try-catch or .catchError.',
      ),
      paCard(
        'Common Errors',
        Column(
          children: [
            paRow(['Error', 'Cause', 'Fix'], isHeader: true),
            paRow(['Unable to load asset', 'Key not in manifest', 'Check pubspec']),
            paRow(['FormatException', 'Binary loaded as string', 'Use load()']),
            paRow(['Asset not found', 'Missing build', 'flutter pub get']),
            paRow(['Wrong variant', 'Folder mismatch', 'Check 2.0x/ path']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: DefaultAssetBundle ━━━━━━
  print('[pa-13] Section 13: DefaultAssetBundle');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('13', 'DefaultAssetBundle for Testing'),
      paNote(
        'DefaultAssetBundle is an InheritedWidget that provides the '
        'asset bundle down the tree. Override it in tests with a custom '
        'bundle to avoid real file I/O. Widgets should prefer '
        'DefaultAssetBundle.of(context) over rootBundle.',
      ),
      paCard(
        'Test Override Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paCodeLine('testWidgets("loads config", (tester) async {', caramel),
              _paCodeLine('  final bundle = TestAssetBundle();', deepAmber),
              _paCodeLine('  await tester.pumpWidget(', deepAmber),
              _paCodeLine('    DefaultAssetBundle(', deepAmber),
              _paCodeLine('      bundle: bundle,', deepAmber),
              _paCodeLine('      child: MyWidget(),', deepAmber),
              _paCodeLine('    ),', deepAmber),
              _paCodeLine('  );', deepAmber),
              _paCodeLine('});', caramel),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Platform differences ━━━━━━
  print('[pa-14] Section 14: Platform differences');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('14', 'Platform-Specific Asset Loading'),
      paNote(
        'Asset storage differs by platform. On Android, assets live in '
        'the APK. On iOS, in the app bundle. On web, assets are served '
        'as network resources. PlatformAssetBundle abstracts this — '
        'the load API is identical across platforms.',
      ),
      paCard(
        'Where Assets Live',
        Column(
          children: [
            paRow(['Platform', 'Storage', 'Delivery'], isHeader: true),
            paRow(['Android', 'APK assets/', 'AssetManager']),
            paRow(['iOS', 'Bundle/flutter_assets', 'NSBundle']),
            paRow(['Web', 'Server root/assets/', 'HTTP fetch']),
            paRow(['macOS', 'App bundle', 'NSBundle']),
            paRow(['Windows', 'data/flutter_assets/', 'File read']),
            paRow(['Linux', 'data/flutter_assets/', 'File read']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Flavor/conditional assets ━━━━━━
  print('[pa-15] Section 15: Conditional assets');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('15', 'Flavor and Conditional Assets'),
      paNote(
        'Flutter 3.24+ supports flavor-conditional assets. Declare assets '
        'with a flavors: filter in pubspec.yaml. Only assets matching '
        'the build flavor are bundled. This reduces app size for '
        'white-label or multi-brand apps.',
      ),
      paCard(
        'Flavor Asset Declaration',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paCodeLine('flutter:', caramel),
              _paCodeLine('  assets:', caramel),
              _paCodeLine('    - path: assets/brand_logo.png', deepAmber),
              _paCodeLine('      flavors:', deepAmber),
              _paCodeLine('        - premium', bronze),
              _paCodeLine('    - path: assets/generic_logo.png', deepAmber),
              _paCodeLine('      flavors:', deepAmber),
              _paCodeLine('        - free', bronze),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[pa-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paBanner('16', 'Summary Dashboard'),
      paCard(
        'PlatformAssetBundle — Complete',
        Column(
          children: [
            paRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            paRow(['What', 'S01', 'Default AssetBundle for Flutter']),
            paRow(['rootBundle', 'S02', 'Global entry point']),
            paRow(['API', 'S03', 'load, loadString, loadBuffer']),
            paRow(['Manifest', 'S04', 'AssetManifest maps keys']),
            paRow(['Resolution', 'S05', '1x/2x/3x auto-select']),
            paRow(['Text/JSON', 'S06', 'loadString + structured']),
            paRow(['Binary', 'S07', 'load vs loadBuffer']),
            paRow(['Caching', 'S08', 'String cached, binary not']),
            paRow(['pubspec', 'S09', 'flutter:assets declaration']),
            paRow(['Fonts', 'S10', 'FontLoader at runtime']),
            paRow(['Packages', 'S11', 'packages/ prefix']),
            paRow(['Errors', 'S12', 'Key not found']),
            paRow(['Testing', 'S13', 'DefaultAssetBundle override']),
            paRow(['Platforms', 'S14', 'APK/NSBundle/HTTP']),
            paRow(['Flavors', 'S15', 'Conditional asset bundling']),
          ],
        ),
      ),
      paCard(
        'Amber / Gold Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _paColorSwatch('Amber', amber),
            _paColorSwatch('Gold', gold),
            _paColorSwatch('Honeycomb', honeycomb),
            _paColorSwatch('Bronze', bronze),
            _paColorSwatch('Caramel', caramel),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [caramel, deepAmber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('PlatformAssetBundle — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From rootBundle through manifests, resolution variants, '
              'caching, package assets, platform differences, and flavor '
              'conditional bundling — the full asset loading story.',
              style: TextStyle(color: wheat, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[pa] palette: $tawny, $gold, $wheat, $cream');
  print('[pa] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PlatformAssetBundle — Asset Loading'),
        backgroundColor: caramel,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFFDF5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _paRoleBadge(String role, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(role,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _paCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _paKeyValue(String key, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(key,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 10, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _paColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
