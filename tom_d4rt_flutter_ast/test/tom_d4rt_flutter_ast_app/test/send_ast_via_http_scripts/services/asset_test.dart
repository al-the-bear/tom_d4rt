// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for AssetBundle, AssetImage,
// RootBundle, NetworkAssetBundle and the AssetManifest family
// ============================================================================
// Theme: 'Atelier Indigo' -- a print-shop palette of indigo dye, oxidised brass,
// linen white, kraft paper tan, and oxblood ink. The script renders an
// instructional, scroll-able catalogue that maps the entire asset-loading
// surface of package:flutter/services.dart: AssetBundle (abstract), the
// concrete RootBundle wired to the running app, NetworkAssetBundle for HTTP
// origins, the deprecated PlatformAssetBundle / CachingAssetBundle pair, and
// the manifest layer (AssetManifest, AssetMetadata). It also covers the
// resolution-variant convention (1x/2x/3x folders), the AssetImage and
// ExactAssetImage providers built on top, AssetBundleImageProvider, and the
// DefaultAssetBundle inherited-widget wrapping recipe.
//
// SECTIONS
//   1.  Title banner with palette swatches
//   2.  AssetBundle taxonomy -- one card per concrete bundle class
//   3.  RootBundle prose card + signature snippets
//   4.  AssetImage / ExactAssetImage construction gallery
//   5.  Resolution-variant diagram -- 1x / 1.5x / 2x / 3x / 4x folder layout
//   6.  AssetManifest mock display -- simulated JSON listing
//   7.  DefaultAssetBundle wrapping recipe -- inherited-widget pattern
//   8.  Comparison matrix -- AssetImage vs NetworkImage vs FileImage
//   9.  AssetBundleImageProvider lineage
//  10.  Pubspec.yaml asset declaration cheatsheet
//  11.  DO / AVOID callouts
//  12.  Glossary -- fourteen terms
//  13.  Recap footer
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// PALETTE -- Atelier Indigo
// ============================================================================
class _Palette {
  static const Color linen      = Color(0xFFF5EFE4);
  static const Color kraft      = Color(0xFFD9C7A3);
  static const Color indigo     = Color(0xFF2D3E6F);
  static const Color indigoDeep = Color(0xFF1A2750);
  static const Color brass      = Color(0xFFB48A3C);
  static const Color brassDeep  = Color(0xFF8A6624);
  static const Color oxblood    = Color(0xFF6D2A2A);
  static const Color ink        = Color(0xFF1B1A17);
  static const Color sage       = Color(0xFF6E8260);
  static const Color sky        = Color(0xFF6F8CB4);
  static const Color paper      = Color(0xFFFBF6EC);
  static const Color rule       = Color(0xFF8C7A55);
  static const Color highlight  = Color(0xFFE9D9A8);
  static const Color shadow     = Color(0xFF5A4B33);
  static const Color hush       = Color(0xFFEFE7D6);
  static const Color stamp      = Color(0xFFC0793A);
}

Color _alpha(Color c, double a) => c.withValues(alpha: a);

// ============================================================================
// SMALL HELPERS
// ============================================================================
TextStyle _h1() => const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      color: _Palette.linen,
      letterSpacing: 0.4,
    );

TextStyle _h2() => const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: _Palette.indigoDeep,
      letterSpacing: 0.3,
    );

TextStyle _h3() => const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: _Palette.ink,
    );

TextStyle _body() => const TextStyle(
      fontSize: 13.5,
      height: 1.45,
      color: _Palette.ink,
    );

TextStyle _mono() => const TextStyle(
      fontFamily: 'monospace',
      fontSize: 12.5,
      height: 1.45,
      color: _Palette.indigoDeep,
    );

TextStyle _monoLight() => const TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
      height: 1.4,
      color: _Palette.linen,
    );

Widget _gap(double h) => SizedBox(height: h);

Widget _hr({Color color = _Palette.rule, double height = 1, double opacity = 0.4}) {
  return Container(
    height: height,
    color: _alpha(color, opacity),
  );
}

Widget _swatch(Color c, String name, String hex) {
  return Container(
    width: 92,
    padding: const EdgeInsets.all(6),
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _alpha(_Palette.rule, 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: _alpha(_Palette.ink, 0.18)),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _Palette.ink)),
        Text(hex, style: const TextStyle(fontSize: 9, color: _Palette.shadow, fontFamily: 'monospace')),
      ],
    ),
  );
}

Widget _chip(String text, {Color bg = _Palette.brass, Color fg = _Palette.linen}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _sectionTitle(String index, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.only(top: 22, bottom: 10),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: _Palette.indigo,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: _alpha(_Palette.ink, 0.18),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _Palette.brass,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: _Palette.indigoDeep,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _h1()),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(fontSize: 12, color: _alpha(_Palette.linen, 0.78))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child, Color? color, EdgeInsets? padding}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: padding ?? const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color ?? _Palette.paper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _alpha(_Palette.rule, 0.45)),
      boxShadow: [
        BoxShadow(
          color: _alpha(_Palette.ink, 0.06),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _codeBlock(String code, {Color bg = _Palette.indigoDeep}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(code, style: _monoLight()),
  );
}

Widget _kv(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(k, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _Palette.brassDeep)),
        ),
        Expanded(child: Text(v, style: _body())),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1 -- TITLE BANNER
// ============================================================================
Widget _buildTitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_Palette.indigoDeep, _Palette.indigo, _Palette.oxblood],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _Palette.brass,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _Palette.linen, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                'A',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: _Palette.indigoDeep,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AssetBundle Atlas', style: _h1()),
                  const SizedBox(height: 2),
                  Text(
                    'A deep visual tour of the asset-loading surface',
                    style: TextStyle(fontSize: 13, color: _alpha(_Palette.linen, 0.78)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _hr(color: _Palette.linen, opacity: 0.3),
        const SizedBox(height: 12),
        Text(
          'package:flutter/services.dart  --  rootBundle, NetworkAssetBundle, AssetManifest, DefaultAssetBundle',
          style: _monoLight(),
        ),
        const SizedBox(height: 16),
        Wrap(
          children: [
            _swatch(_Palette.linen,     'linen',     '#F5EFE4'),
            _swatch(_Palette.kraft,     'kraft',     '#D9C7A3'),
            _swatch(_Palette.indigo,    'indigo',    '#2D3E6F'),
            _swatch(_Palette.indigoDeep,'indigoDeep','#1A2750'),
            _swatch(_Palette.brass,     'brass',     '#B48A3C'),
            _swatch(_Palette.brassDeep, 'brassDeep', '#8A6624'),
            _swatch(_Palette.oxblood,   'oxblood',   '#6D2A2A'),
            _swatch(_Palette.sage,      'sage',      '#6E8260'),
            _swatch(_Palette.sky,       'sky',       '#6F8CB4'),
            _swatch(_Palette.stamp,     'stamp',     '#C0793A'),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 -- AssetBundle taxonomy
// ============================================================================
class _BundleDescriptor {
  final String name;
  final String role;
  final String storage;
  final String returns;
  final Color accent;
  const _BundleDescriptor({
    required this.name,
    required this.role,
    required this.storage,
    required this.returns,
    required this.accent,
  });
}

List<_BundleDescriptor> _bundleDescriptors() {
  return const <_BundleDescriptor>[
    _BundleDescriptor(
      name: 'AssetBundle (abstract)',
      role: 'Base class -- defines load, loadString, loadStructuredData',
      storage: 'no inherent storage -- concrete subclasses choose',
      returns: 'ByteData, String, T (decoded)',
      accent: _Palette.indigo,
    ),
    _BundleDescriptor(
      name: 'CachingAssetBundle',
      role: 'Mixes in an in-memory LRU cache of decoded results',
      storage: 'Map<String, Object?> in process memory',
      returns: 'cached String / structured data',
      accent: _Palette.brass,
    ),
    _BundleDescriptor(
      name: 'PlatformAssetBundle',
      role: 'Concrete bundle that hits the engine asset table',
      storage: 'compiled-in app bundle (apk / ipa / web)',
      returns: 'ByteData via PlatformChannels',
      accent: _Palette.sage,
    ),
    _BundleDescriptor(
      name: 'NetworkAssetBundle',
      role: 'Concrete bundle backed by HTTP GET to a base Uri',
      storage: 'remote HTTP origin (CDN, tenant server)',
      returns: 'ByteData of response body',
      accent: _Palette.sky,
    ),
    _BundleDescriptor(
      name: 'RootBundle (singleton)',
      role: 'Global default -- top-level rootBundle reference',
      storage: 'PlatformAssetBundle under the hood',
      returns: 'matches PlatformAssetBundle',
      accent: _Palette.oxblood,
    ),
    _BundleDescriptor(
      name: 'DefaultAssetBundle',
      role: 'InheritedWidget that scopes a bundle to a subtree',
      storage: 'whatever bundle is supplied to .bundle',
      returns: 'looked up via DefaultAssetBundle.of(context)',
      accent: _Palette.stamp,
    ),
  ];
}

Widget _buildBundleTaxonomy() {
  final descriptors = _bundleDescriptors();
  final cards = <Widget>[];
  for (int i = 0; i < descriptors.length; i++) {
    final d = descriptors[i];
    cards.add(_card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: d.accent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: _Palette.linen,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(d.name, style: _h2())),
              _chip('class', bg: _alpha(d.accent, 0.85)),
            ],
          ),
          const SizedBox(height: 8),
          _hr(),
          const SizedBox(height: 6),
          _kv('role', d.role),
          _kv('storage', d.storage),
          _kv('returns', d.returns),
        ],
      ),
    ));
  }
  return Column(children: cards);
}

// ============================================================================
// SECTION 3 -- RootBundle prose card
// ============================================================================
Widget _buildRootBundleProse() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _Palette.oxblood,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('rB',
                      style: TextStyle(
                          color: _Palette.linen,
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('rootBundle -- the global default', style: _h2()),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _hr(),
            const SizedBox(height: 8),
            Text(
              'rootBundle is a top-level final variable exported from '
              'package:flutter/services.dart. It is initialised by the engine '
              'binding at startup to point at a PlatformAssetBundle whose '
              'underlying transport is a platform channel. Asking rootBundle '
              'for an asset asks the engine, which then asks the host platform '
              'asset loader, which finally consults the app bundle that was '
              'shipped alongside your binary.',
              style: _body(),
            ),
            const SizedBox(height: 8),
            Text(
              'Practical guidance: avoid reaching for rootBundle inside a '
              'widget. Reach for DefaultAssetBundle.of(context) instead so '
              'tests can inject a different bundle. rootBundle is best used '
              'in app-startup glue, build-system tools, and standalone '
              'isolates that have no widget tree.',
              style: _body(),
            ),
          ],
        ),
      ),
      _card(
        color: _Palette.indigoDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Signature snippets', style: TextStyle(
                color: _Palette.linen,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.4)),
            const SizedBox(height: 6),
            _codeBlock(
              '// In services.dart\n'
              'final AssetBundle rootBundle = _initRootBundle();\n'
              '\n'
              '// AssetBundle abstract surface\n'
              'abstract class AssetBundle {\n'
              '  Future<ByteData> load(String key);\n'
              '  Future<String>   loadString(String key, {bool cache = true});\n'
              '  Future<T>        loadStructuredData<T>(String key,\n'
              '      Future<T> Function(String value) parser);\n'
              '  void evict(String key);\n'
              '  void clear();\n'
              '}',
              bg: const Color(0xFF111A30),
            ),
            const SizedBox(height: 4),
            Text(
              'Note: the asset_test demo never calls .load -- that would '
              'return a Future. We only describe the API and instantiate '
              'providers synchronously.',
              style: TextStyle(color: _alpha(_Palette.linen, 0.7), fontSize: 11.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 4 -- AssetImage / ExactAssetImage construction gallery
// ============================================================================
class _ProviderSample {
  final String label;
  final ImageProvider provider;
  final String code;
  final String detail;
  const _ProviderSample(this.label, this.provider, this.code, this.detail);
}

List<_ProviderSample> _providerSamples() {
  // We construct these for inspection -- never resolve them.
  final samples = <_ProviderSample>[];

  final a1 = AssetImage('assets/dummy.png');
  samples.add(_ProviderSample(
    'AssetImage -- bare',
    a1,
    "AssetImage('assets/dummy.png')",
    'Looks up the closest scale variant via the manifest.',
  ));

  final a2 = AssetImage('assets/icons/star.png', package: 'demo_pkg');
  samples.add(_ProviderSample(
    'AssetImage -- package',
    a2,
    "AssetImage('assets/icons/star.png', package: 'demo_pkg')",
    "Prefixes the key with 'packages/demo_pkg/'.",
  ));

  final a3 = ExactAssetImage('assets/icons/star@2x.png', scale: 2.0);
  samples.add(_ProviderSample(
    'ExactAssetImage -- 2x',
    a3,
    "ExactAssetImage('assets/icons/star@2x.png', scale: 2.0)",
    'Skips manifest resolution -- you commit to a single file.',
  ));

  final a4 = ExactAssetImage('assets/icons/star@3x.png',
      scale: 3.0, package: 'demo_pkg');
  samples.add(_ProviderSample(
    'ExactAssetImage -- 3x + package',
    a4,
    "ExactAssetImage('...@3x.png', scale: 3.0, package: 'demo_pkg')",
    'Useful for fonts/icons in shared library packages.',
  ));

  final a5 = AssetImage('assets/brand/logo.png');
  samples.add(_ProviderSample(
    'AssetImage -- brand logo',
    a5,
    "AssetImage('assets/brand/logo.png')",
    'Typical white-label brand asset -- one logical name.',
  ));

  final a6 = ExactAssetImage('assets/maps/tile_512.webp', scale: 1.0);
  samples.add(_ProviderSample(
    'ExactAssetImage -- map tile',
    a6,
    "ExactAssetImage('assets/maps/tile_512.webp', scale: 1.0)",
    'WebP tile served at a known DPR -- no variant search.',
  ));

  return samples;
}

Widget _buildProviderGallery() {
  final samples = _providerSamples();
  final cards = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final s = samples[i];
    cards.add(_card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visual stand-in for the image we never resolve.
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _Palette.kraft,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _alpha(_Palette.rule, 0.5)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _Palette.brassDeep,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.label, style: _h3()),
                    const SizedBox(height: 4),
                    Text(
                      'runtimeType = ${s.provider.runtimeType}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _Palette.brassDeep,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(s.detail, style: _body()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _codeBlock(s.code),
        ],
      ),
    ));
  }
  return Column(children: cards);
}

// ============================================================================
// SECTION 5 -- Resolution variant diagram
// ============================================================================
class _VariantRow {
  final String folder;
  final String filename;
  final double scale;
  final int pxSquare;
  final Color tint;
  const _VariantRow(this.folder, this.filename, this.scale, this.pxSquare, this.tint);
}

List<_VariantRow> _variantRows() {
  return const <_VariantRow>[
    _VariantRow('assets/',       'star.png',    1.0,  48, _Palette.linen),
    _VariantRow('assets/1.5x/',  'star.png',    1.5,  72, _Palette.hush),
    _VariantRow('assets/2.0x/',  'star.png',    2.0,  96, _Palette.kraft),
    _VariantRow('assets/3.0x/',  'star.png',    3.0, 144, _Palette.highlight),
    _VariantRow('assets/4.0x/',  'star.png',    4.0, 192, _Palette.brass),
  ];
}

Widget _buildVariantDiagram() {
  final rows = _variantRows();
  final rowWidgets = <Widget>[];

  // Header strip
  rowWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _Palette.indigoDeep,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(width: 70,  child: Text('scale',     style: _monoLight())),
          SizedBox(width: 130, child: Text('folder',    style: _monoLight())),
          SizedBox(width: 100, child: Text('filename',  style: _monoLight())),
          SizedBox(width: 70,  child: Text('px (sq)',   style: _monoLight())),
          Expanded(            child: Text('preview',   style: _monoLight())),
        ],
      ),
    ),
  );

  for (int i = 0; i < rows.length; i++) {
    final r = rows[i];
    final previewSize = 18.0 + (r.scale * 6.0);
    rowWidgets.add(
      Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: r.tint,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _alpha(_Palette.rule, 0.45)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Text('${r.scale.toStringAsFixed(1)}x',
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      color: _Palette.indigoDeep)),
            ),
            SizedBox(
              width: 130,
              child: Text(r.folder, style: _mono()),
            ),
            SizedBox(
              width: 100,
              child: Text(r.filename, style: _mono()),
            ),
            SizedBox(
              width: 70,
              child: Text('${r.pxSquare}',
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _Palette.brassDeep,
                      fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: previewSize,
                  height: previewSize,
                  decoration: BoxDecoration(
                    color: _Palette.oxblood,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: _alpha(_Palette.ink, 0.3)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resolution variant folder layout', style: _h2()),
        const SizedBox(height: 6),
        Text(
          'Flutter resolves an AssetImage by scanning sibling folders named '
          '"<scale>x" beside the declared asset. The manifest lists every '
          'variant; the framework picks the one whose scale most closely '
          'matches MediaQuery.devicePixelRatio.',
          style: _body(),
        ),
        const SizedBox(height: 10),
        ...rowWidgets,
        const SizedBox(height: 10),
        _codeBlock(
          '// pubspec.yaml declares only the *logical* name.\n'
          '# pubspec.yaml\n'
          'flutter:\n'
          '  assets:\n'
          '    - assets/star.png\n'
          '\n'
          '# Variants are picked up automatically when present:\n'
          '#   assets/1.5x/star.png\n'
          '#   assets/2.0x/star.png\n'
          '#   assets/3.0x/star.png',
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 -- AssetManifest mock display
// ============================================================================
class _ManifestEntry {
  final String key;
  final List<_ManifestVariant> variants;
  const _ManifestEntry(this.key, this.variants);
}

class _ManifestVariant {
  final String asset;
  final double scale;
  const _ManifestVariant(this.asset, this.scale);
}

List<_ManifestEntry> _manifestEntries() {
  return const <_ManifestEntry>[
    _ManifestEntry('assets/star.png', [
      _ManifestVariant('assets/star.png',       1.0),
      _ManifestVariant('assets/1.5x/star.png',  1.5),
      _ManifestVariant('assets/2.0x/star.png',  2.0),
      _ManifestVariant('assets/3.0x/star.png',  3.0),
    ]),
    _ManifestEntry('assets/brand/logo.png', [
      _ManifestVariant('assets/brand/logo.png',      1.0),
      _ManifestVariant('assets/brand/2.0x/logo.png', 2.0),
    ]),
    _ManifestEntry('assets/i18n/en.json', [
      _ManifestVariant('assets/i18n/en.json', 1.0),
    ]),
    _ManifestEntry('packages/demo_pkg/assets/icons/heart.png', [
      _ManifestVariant('packages/demo_pkg/assets/icons/heart.png',      1.0),
      _ManifestVariant('packages/demo_pkg/assets/2.0x/icons/heart.png', 2.0),
      _ManifestVariant('packages/demo_pkg/assets/3.0x/icons/heart.png', 3.0),
    ]),
    _ManifestEntry('assets/maps/tile_512.webp', [
      _ManifestVariant('assets/maps/tile_512.webp', 1.0),
    ]),
  ];
}

Widget _buildManifestDisplay() {
  final entries = _manifestEntries();
  final rows = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final e = entries[i];
    final variantRows = <Widget>[];
    for (int v = 0; v < e.variants.length; v++) {
      final vv = e.variants[v];
      variantRows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: Row(
            children: [
              Container(
                width: 38,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: _Palette.brass,
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${vv.scale.toStringAsFixed(1)}x',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: _Palette.indigoDeep,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(vv.asset, style: _mono())),
            ],
          ),
        ),
      );
    }
    rows.add(_card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _Palette.sky,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('${i + 1}',
                    style: const TextStyle(
                        color: _Palette.linen,
                        fontWeight: FontWeight.w900,
                        fontSize: 11)),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(e.key, style: _h3())),
              _chip('${e.variants.length} variants', bg: _Palette.sage),
            ],
          ),
          const SizedBox(height: 8),
          _hr(),
          const SizedBox(height: 4),
          ...variantRows,
        ],
      ),
    ));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AssetManifest -- what it actually is', style: _h2()),
            const SizedBox(height: 6),
            Text(
              'AssetManifest is a structured listing of every asset the app '
              'has access to, including each scale variant. It is built at '
              "build time by the flutter tool, shipped as a binary blob "
              'inside the bundle, and exposed through AssetManifest.loadFromAssetBundle.',
              style: _body(),
            ),
            const SizedBox(height: 6),
            _codeBlock(
              '// API shape -- conceptual\n'
              'abstract class AssetManifest {\n'
              '  static Future<AssetManifest> loadFromAssetBundle(AssetBundle bundle);\n'
              '  List<String> listAssets();\n'
              '  List<AssetMetadata> getAssetVariants(String key);\n'
              '}\n'
              '\n'
              'class AssetMetadata {\n'
              '  final String key;\n'
              '  final double? targetDevicePixelRatio;\n'
              '  final bool main;\n'
              '}',
            ),
          ],
        ),
      ),
      ...rows,
    ],
  );
}

// ============================================================================
// SECTION 7 -- DefaultAssetBundle wrapping recipe
// ============================================================================
Widget _buildDefaultBundleRecipe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DefaultAssetBundle -- the inherited-widget wrapper',
                style: _h2()),
            const SizedBox(height: 6),
            Text(
              'DefaultAssetBundle is an InheritedWidget that propagates an '
              'AssetBundle reference down a subtree. Widgets call '
              'DefaultAssetBundle.of(context) to get a bundle without hard-'
              'coding rootBundle, which makes them test-friendly: a test can '
              'wrap them in a DefaultAssetBundle whose .bundle is an in-'
              'memory fake.',
              style: _body(),
            ),
            const SizedBox(height: 8),
            _codeBlock(
              '// Production -- rely on the implicit rootBundle.\n'
              'DefaultAssetBundle.of(context).loadString("assets/i18n/en.json");\n'
              '\n'
              '// Test -- inject a fake bundle.\n'
              'await tester.pumpWidget(\n'
              '  DefaultAssetBundle(\n'
              '    bundle: FakeBundle({\n'
              '      "assets/i18n/en.json": "{\\\"hello\\\":\\\"hi\\\"}",\n'
              '    }),\n'
              '    child: MyApp(),\n'
              '  ),\n'
              ');',
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inheritance diagram', style: _h3()),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _diagramNode('MaterialApp', _Palette.indigo, _Palette.linen),
                _diagramArrow(),
                _diagramNode('DefaultAssetBundle', _Palette.brass, _Palette.indigoDeep),
                _diagramArrow(),
                _diagramNode('subtree', _Palette.sage, _Palette.linen),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'MaterialApp implicitly inserts a DefaultAssetBundle that '
              'points at rootBundle, so .of(context) almost always finds '
              "something usable. Override it deliberately when you need to.",
              style: _body(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _diagramNode(String label, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 12),
    ),
  );
}

Widget _diagramArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: Icon(Icons.arrow_forward, color: _Palette.brassDeep, size: 18),
  );
}

// ============================================================================
// SECTION 8 -- Provider comparison matrix
// ============================================================================
class _ProviderCompare {
  final String name;
  final String source;
  final String cacheKey;
  final String mostUsefulFor;
  final Color accent;
  const _ProviderCompare(this.name, this.source, this.cacheKey,
      this.mostUsefulFor, this.accent);
}

List<_ProviderCompare> _providerCompares() {
  return const <_ProviderCompare>[
    _ProviderCompare(
      'AssetImage',
      'AssetBundle (default rootBundle)',
      '(assetName, bundle, package)',
      'Bundled UI imagery, glyphs, brand marks',
      _Palette.indigo,
    ),
    _ProviderCompare(
      'ExactAssetImage',
      'AssetBundle (no manifest lookup)',
      '(assetName, scale, bundle, package)',
      'Pinning a specific scale variant',
      _Palette.brass,
    ),
    _ProviderCompare(
      'NetworkImage',
      'HTTP fetch by Uri',
      '(url, scale, headers)',
      'User-supplied remote URLs',
      _Palette.sky,
    ),
    _ProviderCompare(
      'FileImage',
      'dart:io File on disk',
      '(file, scale)',
      'Local cache, downloads, picker results',
      _Palette.sage,
    ),
    _ProviderCompare(
      'MemoryImage',
      'Uint8List already in RAM',
      '(bytes, scale)',
      'Decoded payloads, generated thumbnails',
      _Palette.oxblood,
    ),
  ];
}

Widget _buildProviderCompare() {
  final rows = _providerCompares();
  final widgets = <Widget>[];
  // Header
  widgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _Palette.indigoDeep,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text('provider',   style: _monoLight())),
          SizedBox(width: 180, child: Text('source',     style: _monoLight())),
          SizedBox(width: 180, child: Text('cache key',  style: _monoLight())),
          Expanded(            child: Text('most useful for', style: _monoLight())),
        ],
      ),
    ),
  );
  for (int i = 0; i < rows.length; i++) {
    final r = rows[i];
    widgets.add(
      Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _alpha(r.accent, 0.12),
          border: Border(left: BorderSide(color: r.accent, width: 4)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(r.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _Palette.indigoDeep,
                      fontSize: 12.5)),
            ),
            SizedBox(width: 180, child: Text(r.source, style: _body())),
            SizedBox(width: 180, child: Text(r.cacheKey, style: _mono())),
            Expanded(child: Text(r.mostUsefulFor, style: _body())),
          ],
        ),
      ),
    );
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ImageProvider comparison matrix', style: _h2()),
        const SizedBox(height: 8),
        ...widgets,
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 -- AssetBundleImageProvider lineage
// ============================================================================
Widget _buildProviderLineage() {
  final levels = <Widget>[];

  Widget node(String label, String comment, Color bg, {Color fg = _Palette.linen}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 36,
            color: _alpha(_Palette.linen, 0.6),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: fg,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(comment,
                    style: TextStyle(
                        color: _alpha(fg, 0.85),
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  levels.add(node('ImageProvider<T>',
      'Generic base. Defines obtainKey + loadImage(key, decoder).',
      _Palette.indigoDeep));
  levels.add(node('AssetBundleImageProvider',
      'Mixes in resolving keys through an AssetBundle. Calls bundle.load(key).',
      _Palette.indigo));
  levels.add(node('AssetImage',
      'Adds manifest-based scale variant resolution -- picks the right Nx.',
      _Palette.brass, fg: _Palette.indigoDeep));
  levels.add(node('ExactAssetImage',
      'Skips manifest lookup -- you tell it the scale and asset name.',
      _Palette.brassDeep));
  levels.add(node('NetworkAssetBundle (parallel)',
      'Not an ImageProvider; an AssetBundle subclass that fetches via HTTP.',
      _Palette.sky, fg: _Palette.indigoDeep));

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AssetBundleImageProvider lineage', style: _h2()),
        const SizedBox(height: 6),
        Text(
          'AssetImage and ExactAssetImage share a common ancestor that knows '
          'how to translate a logical key into bundle bytes. The manifest is '
          'only consulted by AssetImage; ExactAssetImage shortcuts straight '
          'to bundle.load(key).',
          style: _body(),
        ),
        ...levels,
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 -- pubspec.yaml cheatsheet
// ============================================================================
Widget _buildPubspecCheatsheet() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('pubspec.yaml -- asset declaration cheatsheet', style: _h2()),
        const SizedBox(height: 6),
        Text(
          'The flutter tool turns the pubspec asset list into a manifest and '
          'embeds it in the compiled bundle. There are four declaration '
          'styles you will encounter in practice.',
          style: _body(),
        ),
        _codeBlock(
          '# 1. Single asset by full path -- the simplest form.\n'
          'flutter:\n'
          '  assets:\n'
          '    - assets/icons/star.png\n'
          '\n'
          '# 2. Folder shorthand -- ends with "/" -- picks up everything\n'
          '#    directly inside that folder, plus its Nx siblings.\n'
          'flutter:\n'
          '  assets:\n'
          '    - assets/icons/\n'
          '\n'
          '# 3. Package asset -- pulled in from a dep -- prefix at use-site.\n'
          'flutter:\n'
          '  assets:\n'
          '    - packages/demo_pkg/assets/icons/heart.png\n'
          '\n'
          '# 4. Asset variants -- declare logical name once -- variants are\n'
          '#    discovered automatically when in <scale>x/ siblings.\n'
          'flutter:\n'
          '  assets:\n'
          '    - assets/brand/logo.png',
        ),
        const SizedBox(height: 4),
        Text(
          'Gotchas: folder shorthand is non-recursive. To include nested '
          'folders, list each folder explicitly, or upgrade to a list of '
          'folder entries. Package assets must be declared in the consuming '
          "app's pubspec only if you want to override -- otherwise the "
          "package's own pubspec is enough.",
          style: _body(),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 -- DO / AVOID callouts
// ============================================================================
class _Callout {
  final bool isDo;
  final String title;
  final String body;
  const _Callout(this.isDo, this.title, this.body);
}

List<_Callout> _callouts() {
  return const <_Callout>[
    _Callout(true,
        'DO use DefaultAssetBundle.of(context)',
        'Lets tests and themed subtrees swap in a different bundle.'),
    _Callout(false,
        'AVOID hard-coding rootBundle inside widgets',
        'It works in production but defeats injection-based widget tests.'),
    _Callout(true,
        'DO let AssetImage pick the scale',
        'Declare one logical name in pubspec and ship Nx siblings.'),
    _Callout(false,
        'AVOID branching on devicePixelRatio yourself',
        'AssetImage already does this through the manifest.'),
    _Callout(true,
        'DO use ExactAssetImage for pre-rendered tile sets',
        "When you ship a 512x512 webp tile you don't want Flutter to scale-pick.'"),
    _Callout(false,
        'AVOID NetworkAssetBundle for high-frequency requests',
        'It re-fetches per key. Use a real cache (CachingAssetBundle subclass).'),
    _Callout(true,
        'DO precache critical AssetImages at startup',
        'precacheImage(AssetImage(...), context) avoids first-frame jank.'),
    _Callout(false,
        "AVOID calling .load on rootBundle in synchronous code",
        'It always returns a Future -- await it on a non-render-blocking path.'),
  ];
}

Widget _buildCallouts() {
  final items = _callouts();
  final widgets = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    final c = items[i];
    final bg = c.isDo ? _alpha(_Palette.sage, 0.18) : _alpha(_Palette.oxblood, 0.13);
    final accent = c.isDo ? _Palette.sage : _Palette.oxblood;
    widgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: accent, width: 4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                c.isDo ? 'DO' : 'NO',
                style: const TextStyle(
                  color: _Palette.linen,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.title, style: _h3()),
                  const SizedBox(height: 2),
                  Text(c.body, style: _body()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DO / AVOID -- field notes', style: _h2()),
        const SizedBox(height: 8),
        ...widgets,
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 -- Glossary
// ============================================================================
class _GlossaryTerm {
  final String term;
  final String def;
  const _GlossaryTerm(this.term, this.def);
}

List<_GlossaryTerm> _glossary() {
  return const <_GlossaryTerm>[
    _GlossaryTerm('AssetBundle',
        'Abstract handle for a collection of named assets. Concrete subclasses are PlatformAssetBundle and NetworkAssetBundle.'),
    _GlossaryTerm('rootBundle',
        'Top-level singleton AssetBundle wired to the engine asset table.'),
    _GlossaryTerm('PlatformAssetBundle',
        'Concrete bundle that loads via platform channels from the compiled app bundle.'),
    _GlossaryTerm('NetworkAssetBundle',
        'Concrete bundle that loads via HTTP GET against a base URI.'),
    _GlossaryTerm('CachingAssetBundle',
        'Mixin that keeps loadString / loadStructuredData results in memory.'),
    _GlossaryTerm('DefaultAssetBundle',
        'InheritedWidget that supplies a bundle to a subtree.'),
    _GlossaryTerm('AssetManifest',
        'Build-time JSON-ish index of every asset and its scale variants.'),
    _GlossaryTerm('AssetMetadata',
        'Per-variant record: key, targetDevicePixelRatio, main-or-variant flag.'),
    _GlossaryTerm('AssetImage',
        'ImageProvider that resolves a logical asset name through the manifest.'),
    _GlossaryTerm('ExactAssetImage',
        'ImageProvider that bypasses the manifest -- you pass scale yourself.'),
    _GlossaryTerm('AssetBundleImageProvider',
        'Internal base shared by AssetImage and ExactAssetImage.'),
    _GlossaryTerm('keyName',
        'Final resolved bundle key -- includes package prefix and scale folder.'),
    _GlossaryTerm('packages/<name>/...',
        'Magic prefix that maps to a dependency package\'s assets folder.'),
    _GlossaryTerm('precacheImage',
        'Top-level helper that warms an ImageProvider so the first frame is cheap.'),
  ];
}

Widget _buildGlossary() {
  final terms = _glossary();
  final tiles = <Widget>[];
  for (int i = 0; i < terms.length; i++) {
    final t = terms[i];
    tiles.add(_card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _Palette.brass,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text('${i + 1}',
                    style: const TextStyle(
                        color: _Palette.indigoDeep,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(t.term, style: _h3())),
            ],
          ),
          const SizedBox(height: 4),
          Text(t.def, style: _body()),
        ],
      ),
    ));
  }
  return Column(children: tiles);
}

// ============================================================================
// SECTION 13 -- Recap footer
// ============================================================================
Widget _buildRecap() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_Palette.indigo, _Palette.indigoDeep],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recap', style: _h1()),
        const SizedBox(height: 8),
        _hr(color: _Palette.linen, opacity: 0.35),
        const SizedBox(height: 10),
        Text(
          'The asset pipeline is layered. At the bottom sits AssetBundle, a '
          'tiny abstract class with three load shapes. rootBundle is a '
          'process-wide PlatformAssetBundle. DefaultAssetBundle scopes a '
          'bundle to a subtree so widgets stay testable. The manifest is the '
          'build-time index that lets AssetImage discover scale variants '
          'declared in pubspec.yaml. ExactAssetImage is the escape hatch '
          'when you need to pin a single file. NetworkAssetBundle is for '
          'remote origins; CachingAssetBundle is the in-memory cache. '
          'ImageProvider lineage flows ImageProvider -> '
          'AssetBundleImageProvider -> {AssetImage, ExactAssetImage}.',
          style: TextStyle(
            color: _alpha(_Palette.linen, 0.92),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        _hr(color: _Palette.linen, opacity: 0.35),
        const SizedBox(height: 8),
        Row(
          children: [
            _chip('AssetBundle',         bg: _Palette.brass, fg: _Palette.indigoDeep),
            const SizedBox(width: 6),
            _chip('rootBundle',          bg: _Palette.oxblood),
            const SizedBox(width: 6),
            _chip('AssetManifest',       bg: _Palette.sky, fg: _Palette.indigoDeep),
            const SizedBox(width: 6),
            _chip('DefaultAssetBundle',  bg: _Palette.sage),
            const SizedBox(width: 6),
            _chip('AssetImage',          bg: _Palette.stamp),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD ENTRY
// ============================================================================
dynamic build(BuildContext context) {
  print('asset_test build() starting');
  print('section 1 -- title banner');
  final titleBanner = _buildTitleBanner();

  print('section 2 -- AssetBundle taxonomy');
  final taxonomy = _buildBundleTaxonomy();

  print('section 3 -- rootBundle prose');
  final rootBundleProse = _buildRootBundleProse();

  print('section 4 -- AssetImage / ExactAssetImage gallery');
  // Touch a couple of providers so their runtimeTypes get reported.
  final demoAsset = AssetImage('assets/dummy.png');
  print('demoAsset.runtimeType = ${demoAsset.runtimeType}');
  final demoExact = ExactAssetImage('assets/dummy@2x.png', scale: 2.0);
  print('demoExact.runtimeType = ${demoExact.runtimeType}');
  final demoPkg = AssetImage('assets/heart.png', package: 'demo_pkg');
  print('demoPkg.keyName = ${demoPkg.keyName}');
  // Reference rootBundle from package:flutter/services.dart so the import
  // is genuinely necessary. We never call .load -- that would return a Future.
  final AssetBundle rb = rootBundle;
  print('rootBundle.runtimeType = ${rb.runtimeType}');
  final gallery = _buildProviderGallery();

  print('section 5 -- resolution variant diagram');
  final variants = _buildVariantDiagram();

  print('section 6 -- AssetManifest mock display');
  final manifest = _buildManifestDisplay();

  print('section 7 -- DefaultAssetBundle recipe');
  final defaultBundle = _buildDefaultBundleRecipe();

  print('section 8 -- provider comparison matrix');
  final compare = _buildProviderCompare();

  print('section 9 -- AssetBundleImageProvider lineage');
  final lineage = _buildProviderLineage();

  print('section 10 -- pubspec.yaml cheatsheet');
  final pubspec = _buildPubspecCheatsheet();

  print('section 11 -- DO / AVOID callouts');
  final callouts = _buildCallouts();

  print('section 12 -- glossary');
  final glossary = _buildGlossary();

  print('section 13 -- recap');
  final recap = _buildRecap();

  print('assembling Scaffold');

  return Scaffold(
    backgroundColor: _Palette.linen,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          titleBanner,
          _sectionTitle('2', 'AssetBundle taxonomy',
              'one card per concrete or abstract bundle class'),
          taxonomy,
          _sectionTitle('3', 'rootBundle',
              'the global PlatformAssetBundle singleton'),
          rootBundleProse,
          _sectionTitle('4', 'AssetImage gallery',
              'AssetImage, ExactAssetImage, package: variants'),
          gallery,
          _sectionTitle('5', 'Resolution variants',
              '1x / 1.5x / 2x / 3x / 4x folder layout'),
          variants,
          _sectionTitle('6', 'AssetManifest',
              'build-time index of every asset + scale variant'),
          manifest,
          _sectionTitle('7', 'DefaultAssetBundle',
              'inherited-widget wrapper for test injection'),
          defaultBundle,
          _sectionTitle('8', 'Provider comparison',
              'AssetImage vs NetworkImage vs FileImage vs MemoryImage'),
          compare,
          _sectionTitle('9', 'Provider lineage',
              'AssetBundleImageProvider hierarchy'),
          lineage,
          _sectionTitle('10', 'pubspec.yaml',
              'declaring assets and discovering variants'),
          pubspec,
          _sectionTitle('11', 'DO / AVOID',
              'practical field notes'),
          callouts,
          _sectionTitle('12', 'Glossary',
              'fourteen recurring terms in the asset surface'),
          glossary,
          _gap(18),
          recap,
          _gap(20),
        ],
      ),
    ),
  );
}
