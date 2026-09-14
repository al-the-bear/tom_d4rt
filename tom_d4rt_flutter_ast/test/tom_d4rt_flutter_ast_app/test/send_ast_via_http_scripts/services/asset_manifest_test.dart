// ignore_for_file: avoid_print
// D4rt deep demo: AssetManifest & Asset Loading Pipeline
// Demonstrates how Flutter discovers, resolves, and loads bundled assets —
// manifest parsing, variant resolution, device-pixel-ratio selection, and caching.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Indigo / Navy palette ───
  const Color indigo = Color(0xFF3F51B5);
  const Color navy = Color(0xFF1A237E);
  const Color darkIndigo = Color(0xFF283593);
  const Color lightIndigo = Color(0xFF7986CB);
  const Color lavender = Color(0xFFE8EAF6);
  const Color midBlue = Color(0xFF5C6BC0);
  const Color periwinkle = Color(0xFF9FA8DA);
  const Color paleSlate = Color(0xFFF5F7FF);
  const Color deepNavy = Color(0xFF0D1147);
  const Color softBlue = Color(0xFFC5CAE9);

  print('[am] ===== ASSET MANIFEST DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget amBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [navy, indigo],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.35),
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
              color: deepNavy,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: periwinkle, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
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

  Widget amNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSlate,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: softBlue.withValues(alpha: 0.6)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkIndigo.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget amCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: lavender.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: indigo, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: navy,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: darkIndigo)),
          ),
        ],
      ),
    );
  }

  Widget amCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: softBlue.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.06),
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
              color: indigo.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: navy)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget amRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? indigo.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: softBlue.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? navy : darkIndigo)),
          );
        }).toList(),
      ),
    );
  }

  Widget amFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? navy : indigo,
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
          child: Icon(Icons.east, size: 12, color: midBlue),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget amLayerBox(String label, Color color, double height) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color.computeLuminance() > 0.5
                    ? darkIndigo
                    : Colors.white)),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is AssetManifest? ━━━━━━
  print('[am-01] Section 1: What is AssetManifest?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('01', 'What Is AssetManifest?'),
      amNote(
        'AssetManifest is Flutter\'s internal registry of all bundled assets. '
        'When you list assets in pubspec.yaml, the build system generates a '
        'manifest file (AssetManifest.json or AssetManifest.bin) that maps each '
        'asset key to its variants (resolution-specific alternatives). At runtime, '
        'Flutter uses this manifest to locate and load the correct asset.',
      ),
      amCard(
        'Asset System Overview',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amFlow([
              'pubspec.yaml',
              'Flutter build',
              'AssetManifest',
              'Runtime lookup',
              'Asset loaded',
            ]),
            const SizedBox(height: 12),
            amLayerBox('pubspec.yaml — asset declarations', indigo.withValues(alpha: 0.12), 38),
            amLayerBox('AssetManifest.bin — binary manifest', midBlue.withValues(alpha: 0.2), 38),
            amLayerBox('AssetBundle — runtime accessor', darkIndigo.withValues(alpha: 0.1), 38),
            amLayerBox('Image / File — loaded content', navy.withValues(alpha: 0.08), 38),
          ],
        ),
      ),
      amCard(
        'Manifest Formats',
        Column(
          children: [
            amRow(['Format', 'File', 'Used Since'], isHeader: true),
            amRow(['JSON', 'AssetManifest.json', 'Early Flutter']),
            amRow(['Binary', 'AssetManifest.bin', 'Flutter 3.7+']),
            amRow(['SMCBIN', 'AssetManifest.smcbin', 'Flutter 3.13+']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Pubspec asset declarations ━━━━━━
  print('[am-02] Section 2: Pubspec declarations');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('02', 'Pubspec Asset Declarations'),
      amNote(
        'Assets are declared in pubspec.yaml under the flutter: section. '
        'You can list individual files or entire directories (with trailing /). '
        'The build tool scans all listed paths and generates the manifest.',
      ),
      amCard(
        'Declaration Patterns',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lavender.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'flutter:\n'
                '  assets:\n'
                '    - assets/images/logo.png      # Single file\n'
                '    - assets/images/               # Entire directory\n'
                '    - assets/data/config.json      # Data file\n'
                '    - packages/pkg/assets/icon.svg  # Package asset',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: darkIndigo,
                    height: 1.5),
              ),
            ),
            const SizedBox(height: 10),
            amRow(['Pattern', 'Scope', 'Example'], isHeader: true),
            amRow(['Single file', 'One asset', 'assets/logo.png']),
            amRow(['Directory', 'All files', 'assets/images/']),
            amRow(['Package', 'Dependency', 'packages/pkg/icon.svg']),
            amRow(['Nested', 'Recursive', 'assets/data/']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Manifest generation ━━━━━━
  print('[am-03] Section 3: Manifest generation');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('03', 'Manifest Generation Pipeline'),
      amNote(
        'During the build, Flutter\'s asset compiler walks the declared asset '
        'paths, discovers all files and their variants, and writes the manifest. '
        'The binary format (AssetManifest.bin) is more compact and faster to '
        'parse than the legacy JSON format.',
      ),
      amCard(
        'Build Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _amBuildStep('1', 'Parse pubspec.yaml', 'Read asset declarations',
                navy),
            _amBuildStep('2', 'Walk directories', 'Find all matching files',
                darkIndigo),
            _amBuildStep('3', 'Discover variants', 'Match 2.0x/, 3.0x/ folders',
                indigo),
            _amBuildStep('4', 'Build variant map', 'Key → [base, 2x, 3x]',
                midBlue),
            _amBuildStep('5', 'Serialize manifest', 'Write .bin or .json',
                lightIndigo),
            _amBuildStep('6', 'Bundle into APK/IPA', 'Included in final app',
                periwinkle),
          ],
        ),
      ),
      amCard(
        'Manifest Entry Structure',
        Column(
          children: [
            amCode('key', '"assets/images/logo.png"'),
            amCode('variants', '["assets/images/2.0x/logo.png", ...]'),
            amCode('dpr', 'Each variant\'s device-pixel-ratio'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Resolution-aware assets ━━━━━━
  print('[am-04] Section 4: Resolution-aware assets');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('04', 'Resolution-Aware Asset Loading'),
      amNote(
        'Flutter automatically selects the highest-resolution asset variant that '
        'doesn\'t exceed the device\'s pixel ratio. Place variants in numbered '
        'subdirectories (2.0x/, 3.0x/) alongside the base asset.',
      ),
      amCard(
        'Directory Layout',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lavender.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _amDirEntry(0, '📁 assets/images/', navy),
              _amDirEntry(1, '📄 logo.png (1.0x base)', darkIndigo),
              _amDirEntry(1, '📁 2.0x/', indigo),
              _amDirEntry(2, '📄 logo.png (@2x)', midBlue),
              _amDirEntry(1, '📁 3.0x/', indigo),
              _amDirEntry(2, '📄 logo.png (@3x)', midBlue),
              _amDirEntry(1, '📁 4.0x/', indigo),
              _amDirEntry(2, '📄 logo.png (@4x)', midBlue),
            ],
          ),
        ),
      ),
      amCard(
        'DPR Selection Logic',
        Column(
          children: [
            amRow(['Device DPR', 'Available', 'Selected'], isHeader: true),
            amRow(['1.0', '1.0, 2.0, 3.0', '1.0x variant']),
            amRow(['1.5', '1.0, 2.0, 3.0', '2.0x variant']),
            amRow(['2.0', '1.0, 2.0, 3.0', '2.0x variant']),
            amRow(['2.75', '1.0, 2.0, 3.0', '3.0x variant']),
            amRow(['3.0', '1.0, 2.0, 3.0', '3.0x variant']),
            amRow(['3.5', '1.0, 2.0, 3.0', '3.0x variant (best fit)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: AssetBundle API ━━━━━━
  print('[am-05] Section 5: AssetBundle API');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('05', 'AssetBundle — Runtime Access'),
      amNote(
        'AssetBundle is the runtime interface for loading assets. The default '
        'implementation (rootBundle) reads from the app bundle. '
        'DefaultAssetBundle.of(context) provides the contextual bundle, which '
        'can be overridden for testing.',
      ),
      amCard(
        'AssetBundle API Surface',
        Column(
          children: [
            amRow(['Method', 'Returns', 'Use Case'], isHeader: true),
            amRow(['load(key)', 'ByteData', 'Raw binary data']),
            amRow(['loadString(key)', 'String', 'Text/JSON/YAML files']),
            amRow(['loadBuffer(key)', 'ImmutableBuffer', 'Zero-copy loading']),
            amRow(['loadStructuredData()', 'T', 'Parsed + cached data']),
            amRow(['evict(key)', 'void', 'Clear cached entry']),
          ],
        ),
      ),
      amCard(
        'Access Patterns',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: navy.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.public, color: navy, size: 24),
                        const SizedBox(height: 4),
                        Text('rootBundle',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: navy)),
                        Text('Global singleton',
                            style: TextStyle(fontSize: 9, color: darkIndigo)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: indigo.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.account_tree, color: indigo, size: 24),
                        const SizedBox(height: 4),
                        Text('DefaultAssetBundle',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: indigo)),
                        Text('Context-aware',
                            style: TextStyle(fontSize: 9, color: darkIndigo)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: AssetManifest class ━━━━━━
  print('[am-06] Section 6: AssetManifest class');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('06', 'AssetManifest Class'),
      amNote(
        'The AssetManifest class provides a typed interface for querying the '
        'manifest. It lists all asset keys and their variants, enabling runtime '
        'discovery of available assets without hardcoding paths.',
      ),
      amCard(
        'AssetManifest API',
        Column(
          children: [
            amCode('listAssets()', 'Returns List<String> of all asset keys'),
            amCode('getAssetVariants(key)', 'Returns List<AssetMetadata> with DPR info'),
          ],
        ),
      ),
      amCard(
        'AssetMetadata Properties',
        Column(
          children: [
            amRow(['Property', 'Type', 'Description'], isHeader: true),
            amRow(['key', 'String', 'Full path to asset variant']),
            amRow(['targetDevicePixelRatio', 'double?', 'DPR for this variant']),
            amRow(['main', 'bool', 'Whether this is the base variant']),
          ],
        ),
      ),
      amCard(
        'Static Factory',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amFlow([
              'AssetManifest.loadFromAssetBundle()',
              'Parse manifest',
              'AssetManifest instance',
            ]),
            const SizedBox(height: 8),
            amNote('This async factory reads and parses the binary manifest '
                'from the bundle, returning a ready-to-query instance.'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Image asset loading ━━━━━━
  print('[am-07] Section 7: Image asset loading');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('07', 'Image Asset Loading Pipeline'),
      amNote(
        'When you use Image.asset(), Flutter goes through several steps: '
        'resolve the asset key, look up the manifest for the best variant, '
        'load the bytes, decode the image, and cache it for reuse.',
      ),
      amCard(
        'Image Loading Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _amImageStep('1', 'Image.asset("logo.png")', 'Widget constructor', navy),
            _amImageStep('2', 'AssetImage.resolve()', 'Key → variant lookup', darkIndigo),
            _amImageStep('3', 'Manifest variant query', 'Best DPR match', indigo),
            _amImageStep('4', 'AssetBundle.load()', 'Read bytes from bundle', midBlue),
            _amImageStep('5', 'instantiateImageCodec()', 'Decode image bytes', lightIndigo),
            _amImageStep('6', 'ImageCache stores', 'Avoid re-decoding', periwinkle),
          ],
        ),
      ),
      amCard(
        'Image Cache Mechanics',
        Column(
          children: [
            amRow(['Property', 'Default', 'Purpose'], isHeader: true),
            amRow(['maximumSize', '1000', 'Max cached images']),
            amRow(['maximumSizeBytes', '100 MB', 'Byte limit']),
            amRow(['currentSize', 'varies', 'Current entry count']),
            amRow(['evict(key)', 'n/a', 'Manual eviction']),
            amRow(['clear()', 'n/a', 'Clear entire cache']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Asset types ━━━━━━
  print('[am-08] Section 8: Supported asset types');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('08', 'Supported Asset Types'),
      amNote(
        'Flutter can bundle any file type. The manifest doesn\'t care about '
        'the format — it\'s just a key-to-path mapping. How you load and '
        'use the asset depends on the file type.',
      ),
      amCard(
        'Common Asset Categories',
        Column(
          children: [
            _amAssetType(Icons.image, 'Images', 'PNG, JPEG, WebP, GIF, BMP, WBMP', navy),
            _amAssetType(Icons.text_fields, 'Text', 'JSON, YAML, CSV, TXT, XML', darkIndigo),
            _amAssetType(Icons.font_download, 'Fonts', 'TTF, OTF (declared separately)', indigo),
            _amAssetType(Icons.audiotrack, 'Audio', 'MP3, WAV, OGG (via plugins)', midBlue),
            _amAssetType(Icons.videocam, 'Video', 'MP4, WebM (via plugins)', lightIndigo),
            _amAssetType(Icons.draw, 'Vector', 'SVG (via flutter_svg package)', periwinkle),
            _amAssetType(Icons.code, 'Data', 'Protobuf, SQLite, binary', navy),
            _amAssetType(Icons.animation, 'Animation', 'Lottie, Rive (via plugins)', darkIndigo),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Package assets ━━━━━━
  print('[am-09] Section 9: Package assets');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('09', 'Package Assets'),
      amNote(
        'Packages can bundle their own assets. These are accessed with a '
        'packages/ prefix: "packages/my_package/assets/icon.png". The app\'s '
        'pubspec must declare package assets to include them in the manifest.',
      ),
      amCard(
        'Package Asset Resolution',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: navy.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Package pubspec',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: navy)),
                        const SizedBox(height: 4),
                        Text('flutter:\n  assets:\n    - assets/icon.png',
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: darkIndigo)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: midBlue, size: 20),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: indigo.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Manifest key',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: indigo)),
                        const SizedBox(height: 4),
                        Text('packages/my_pkg/\n  assets/icon.png',
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: darkIndigo)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            amRow(['Loading Pattern', 'API'], isHeader: true),
            amRow(['Image widget', 'Image.asset("pkg/icon.png", package: "my_pkg")']),
            amRow(['Direct load', 'rootBundle.load("packages/my_pkg/icon.png")']),
            amRow(['AssetImage', 'AssetImage("icon.png", package: "my_pkg")']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Binary manifest format ━━━━━━
  print('[am-10] Section 10: Binary manifest format');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('10', 'Binary Manifest Format (AssetManifest.bin)'),
      amNote(
        'Flutter 3.7+ uses a binary manifest format for faster parsing. '
        'Instead of parsing JSON text, the runtime reads a pre-serialized '
        'structure using StandardMessageCodec. This reduces app startup time, '
        'especially for apps with hundreds of assets.',
      ),
      amCard(
        'Format Comparison',
        Column(
          children: [
            amRow(['Aspect', 'JSON (.json)', 'Binary (.bin)'], isHeader: true),
            amRow(['Parse speed', 'Slower (text parse)', 'Faster (pre-serialized)']),
            amRow(['File size', 'Larger (text)', 'Smaller (binary)']),
            amRow(['Human readable', 'Yes', 'No']),
            amRow(['Codec', 'json.decode()', 'StandardMessageCodec']),
            amRow(['Available since', 'Always', 'Flutter 3.7+']),
          ],
        ),
      ),
      amCard(
        'Binary Structure',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amLayerBox('Header: magic bytes + version', navy.withValues(alpha: 0.15), 32),
            amLayerBox('Asset count: uint32', darkIndigo.withValues(alpha: 0.12), 28),
            amLayerBox('For each asset: key (String)', indigo.withValues(alpha: 0.1), 32),
            amLayerBox('Variant count + variant entries', midBlue.withValues(alpha: 0.1), 32),
            amLayerBox('Each variant: path + dpr (double)', lightIndigo.withValues(alpha: 0.1), 28),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Asset transformation ━━━━━━
  print('[am-11] Section 11: Asset transformation');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('11', 'Asset Transformations'),
      amNote(
        'Flutter 3.16+ supports asset transformations — custom build steps '
        'that process assets during compilation. For example, optimizing SVGs, '
        'compressing images, or converting fonts. Transformers are declared in '
        'pubspec.yaml alongside asset entries.',
      ),
      amCard(
        'Transformation Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amFlow([
              'Original asset',
              'Transformer',
              'Processed asset',
              'Bundle',
            ]),
            const SizedBox(height: 12),
            amRow(['Feature', 'Description'], isHeader: true),
            amRow(['Declarative', 'Configured in pubspec.yaml']),
            amRow(['Chainable', 'Multiple transformers per asset']),
            amRow(['Type-aware', 'Run on specific file types']),
            amRow(['Build-integrated', 'Runs during flutter build']),
          ],
        ),
      ),
      amCard(
        'Example Declaration',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lavender.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'flutter:\n'
            '  assets:\n'
            '    - path: assets/icon.svg\n'
            '      transformers:\n'
            '        - package: vector_graphics_compiler',
            style: TextStyle(
                fontSize: 11, fontFamily: 'monospace', color: darkIndigo, height: 1.4),
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Deferred assets ━━━━━━
  print('[am-12] Section 12: Deferred assets');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('12', 'Deferred Asset Loading'),
      amNote(
        'Deferred components allow downloading assets on demand rather than '
        'bundling everything upfront. This is especially useful for large apps '
        'with many assets. Android uses Play Feature Delivery; iOS uses '
        'On Demand Resources.',
      ),
      amCard(
        'Deferred Loading Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amFlow([
              'App installed (base)',
              'Feature requested',
              'Download deferred',
              'Assets available',
            ]),
            const SizedBox(height: 10),
            amRow(['Platform', 'Mechanism', 'Limit'], isHeader: true),
            amRow(['Android', 'Play Feature Delivery', '150 MB per module']),
            amRow(['iOS', 'On Demand Resources', '20 MB initial, 512 MB total']),
            amRow(['Web', 'Deferred libraries', 'JS splitting']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Testing with assets ━━━━━━
  print('[am-13] Section 13: Testing with assets');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('13', 'Testing With Assets'),
      amNote(
        'In widget tests, the real asset bundle isn\'t available. Use '
        'DefaultAssetBundle to wrap widgets with a mock bundle. For image '
        'tests, provide a transparent PNG via an in-memory bundle.',
      ),
      amCard(
        'Test Strategies',
        Column(
          children: [
            _amTestStrategy(
              'Mock AssetBundle',
              'Override loadString/load to return test data',
              Icons.developer_mode,
              navy,
            ),
            const SizedBox(height: 8),
            _amTestStrategy(
              'DefaultAssetBundle wrapper',
              'Wrap tree with test bundle via InheritedWidget',
              Icons.account_tree,
              indigo,
            ),
            const SizedBox(height: 8),
            _amTestStrategy(
              'Golden tests',
              'Compare rendered images pixel-by-pixel',
              Icons.compare,
              midBlue,
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Asset caching ━━━━━━
  print('[am-14] Section 14: Asset caching');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('14', 'Asset Caching Architecture'),
      amNote(
        'Flutter caches assets at multiple levels: the AssetBundle caches '
        'parsed data via loadStructuredData, the ImageCache caches decoded '
        'images, and the engine caches GPU textures. Understanding caching '
        'helps manage memory and avoid redundant work.',
      ),
      amCard(
        'Cache Layers',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            amLayerBox('L1: AssetBundle.loadStructuredData()', navy.withValues(alpha: 0.2), 38),
            amLayerBox('L2: ImageCache (decoded images)', indigo.withValues(alpha: 0.15), 38),
            amLayerBox('L3: Engine GPU texture cache', midBlue.withValues(alpha: 0.1), 38),
            const SizedBox(height: 8),
            amRow(['Cache', 'What', 'Eviction'], isHeader: true),
            amRow(['AssetBundle', 'Parsed data (JSON → Map)', 'evict(key)']),
            amRow(['ImageCache', 'Decoded image frames', 'LRU, size limit']),
            amRow(['GPU textures', 'Rendered textures', 'Engine-managed']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Troubleshooting ━━━━━━
  print('[am-15] Section 15: Troubleshooting');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('15', 'Common Troubleshooting'),
      amNote(
        'Asset loading failures are among the most common Flutter errors for '
        'beginners. Most issues stem from incorrect paths, missing pubspec '
        'declarations, or stale builds.',
      ),
      amCard(
        'Common Issues & Fixes',
        Column(
          children: [
            _amTroubleshoot('Asset not found', 'FlutterError',
                'Verify path matches pubspec exactly; run flutter clean'),
            _amTroubleshoot('Wrong resolution loaded', 'Visual',
                'Check folder naming: 2.0x/, 3.0x/ (not @2x)'),
            _amTroubleshoot('Package asset missing', 'FlutterError',
                'Add package: parameter to Image.asset()'),
            _amTroubleshoot('Stale manifest', 'Various',
                'flutter clean && flutter pub get && rebuild'),
            _amTroubleshoot('Large bundle size', 'Performance',
                'Use deferred loading; compress images; tree-shake'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[am-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      amBanner('16', 'Summary Dashboard'),
      amCard(
        'Asset Manifest System — Complete',
        Column(
          children: [
            amRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            amRow(['Concept', 'S01', 'Manifest maps keys to variants']),
            amRow(['Pubspec', 'S02', 'Declare files or directories']),
            amRow(['Generation', 'S03', 'Build pipeline creates .bin']),
            amRow(['Resolution', 'S04', 'DPR-based variant selection']),
            amRow(['AssetBundle', 'S05', 'Runtime load/loadString API']),
            amRow(['AssetManifest class', 'S06', 'listAssets / getVariants']),
            amRow(['Image loading', 'S07', 'Resolve → load → decode → cache']),
            amRow(['Types', 'S08', 'Images, text, fonts, audio, video']),
            amRow(['Packages', 'S09', 'packages/ prefix resolution']),
            amRow(['Binary format', 'S10', 'Faster than JSON']),
            amRow(['Transforms', 'S11', 'Build-time processing']),
            amRow(['Deferred', 'S12', 'On-demand downloading']),
            amRow(['Testing', 'S13', 'Mock bundles for widget tests']),
            amRow(['Caching', 'S14', 'Multi-layer cache architecture']),
            amRow(['Troubleshooting', 'S15', 'Path, resolution, stale build']),
          ],
        ),
      ),
      amCard(
        'Indigo / Navy Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _amColorSwatch('Indigo', indigo),
            _amColorSwatch('Navy', navy),
            _amColorSwatch('Dark', darkIndigo),
            _amColorSwatch('Mid', midBlue),
            _amColorSwatch('Light', lightIndigo),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [navy, indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AssetManifest — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From pubspec declarations through manifest generation, '
              'resolution-aware loading, caching, and deferred delivery — '
              'the full Flutter asset pipeline.',
              style: TextStyle(color: lavender, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[am] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AssetManifest & Asset Loading'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0F2FA),
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

Widget _amBuildStep(String num, String phase, String desc, Color accent) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phase,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accent)),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF283593))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _amDirEntry(int depth, String label, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, bottom: 3),
    child: Text(label,
        style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: color)),
  );
}

Widget _amImageStep(String num, String code, String desc, Color accent) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code,
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      color: accent)),
              Text(desc,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF283593))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _amAssetType(IconData icon, String name, String formats, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(formats,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF283593))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _amTestStrategy(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF283593))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _amTroubleshoot(String issue, String type, String fix) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber, size: 16, color: const Color(0xFF1A237E)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(issue,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text('Type: $type',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: const Color(0xFF3F51B5))),
              Text('Fix: $fix',
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF283593))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _amColorSwatch(String name, Color color) {
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
