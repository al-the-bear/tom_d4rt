// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NetworkAssetBundle and the AssetBundle hierarchy
// from package:flutter/services.dart.
// Deep Demo: A 19th-century postal sorting depot — every asset is a parcel,
// every base URI a dispatch route, every cache entry a pigeonhole.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('=== The Bureau of Asset Dispatch ===');
  print('Welcome to the sorting depot. Mind the parcels.');

  // ============================================================
  // Construct a few NetworkAssetBundle instances. NEVER call .load().
  // ============================================================
  final cdnUri = Uri.parse('https://cdn.example.com/assets/');
  final localUri = Uri.parse('http://localhost:8080/assets/');
  final versionedUri = Uri.parse('https://cdn.example.com/assets/v2/');
  final regionalUri = Uri.parse('https://eu.cdn.example.com/parcels/');

  final cdnBundle = NetworkAssetBundle(cdnUri);
  final localBundle = NetworkAssetBundle(localUri);
  final versionedBundle = NetworkAssetBundle(versionedUri);
  final regionalBundle = NetworkAssetBundle(regionalUri);

  print('Constructed bundles:');
  print('  cdnBundle      runtimeType=${cdnBundle.runtimeType}');
  print('  localBundle    runtimeType=${localBundle.runtimeType}');
  print('  versionedBundle runtimeType=${versionedBundle.runtimeType}');
  print('  regionalBundle runtimeType=${regionalBundle.runtimeType}');

  // ============================================================
  // SECTION 1: Header — Bureau of Asset Dispatch
  // ============================================================
  print('=== Section 1: Bureau Header ===');

  final header = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4E342E), Color(0xFF8D6E63), Color(0xFFD7CCC8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3E2723).withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Color(0xFF6D4C41).withValues(alpha: 0.3),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.local_post_office, size: 64.0, color: Color(0xFFFFE0B2)),
        SizedBox(height: 8.0),
        Text(
          'THE BUREAU OF ASSET DISPATCH',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Color(0xFFFFF8E1),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'NetworkAssetBundle  &  the  AssetBundle  Hierarchy',
          style: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFFFFE0B2),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF3E2723).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFFE082), width: 1.0),
          ),
          child: Text(
            'Est. 1879  —  Sorting Depot No. 4',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFF8E1),
            ),
          ),
        ),
      ],
    ),
  );
  print('Bureau header constructed.');

  // ============================================================
  // SECTION 2: The AssetBundle class hierarchy (anatomy diagram)
  // ============================================================
  print('=== Section 2: AssetBundle Hierarchy ===');

  final hierarchyNodes = <Map<String, dynamic>>[
    {
      'name': 'AssetBundle',
      'role': 'abstract',
      'desc': 'The general post: defines load/loadString/evict/clear',
      'color': Color(0xFF5D4037),
      'icon': Icons.inventory_2_outlined,
    },
    {
      'name': 'CachingAssetBundle',
      'role': 'abstract',
      'desc': 'The pigeonhole wall: caches ByteData and Strings',
      'color': Color(0xFF6D4C41),
      'icon': Icons.grid_view,
    },
    {
      'name': 'NetworkAssetBundle',
      'role': 'concrete',
      'desc': 'The express courier: HTTP/HTTPS dispatch via base Uri',
      'color': Color(0xFF1565C0),
      'icon': Icons.cloud_download,
    },
    {
      'name': 'PlatformAssetBundle',
      'role': 'concrete',
      'desc': 'The in-house clerk: native platform asset channel',
      'color': Color(0xFF2E7D32),
      'icon': Icons.archive,
    },
  ];

  final hierarchyChildren = <Widget>[];
  for (var i = 0; i < hierarchyNodes.length; i++) {
    final n = hierarchyNodes[i];
    final color = n['color'] as Color;
    final isAbstract = n['role'] == 'abstract';
    hierarchyChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.25),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          children: [
            // Indentation rail showing tree depth.
            Container(
              width: 24.0 + (i * 12.0),
              alignment: Alignment.centerRight,
              child: Text(
                i == 0 ? '' : (i == 1 ? '\u2514\u2500' : '   \u2514\u2500'),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(n['icon'] as IconData, color: color, size: 28.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        n['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: isAbstract
                              ? Color(0xFFEF6C00)
                              : Color(0xFF388E3C),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          (n['role'] as String).toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    n['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF4E342E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final hierarchyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF8D6E63), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF8D6E63).withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF5D4037), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'AssetBundle Class Hierarchy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...hierarchyChildren,
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF3E2723).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF8D6E63), width: 1.0),
          ),
          child: Text(
            'Note: rootBundle is a top-level singleton (a PlatformAssetBundle in '
            'practice) maintained by Flutter. DefaultAssetBundle.of(context) '
            'returns whichever bundle the surrounding widget tree provides — '
            'often rootBundle, sometimes a NetworkAssetBundle injected by tests.',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF3E2723),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Hierarchy diagram built with ${hierarchyChildren.length} nodes.');

  // ============================================================
  // SECTION 3: Base-URI patterns
  // ============================================================
  print('=== Section 3: Base-URI Patterns ===');

  final uriPatterns = <Map<String, dynamic>>[
    {
      'label': 'Public CDN (HTTPS)',
      'uri': cdnUri,
      'bundle': cdnBundle,
      'note':
          'Production parcels arrive over rail; sealed envelopes (TLS) only.',
      'icon': Icons.public,
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Local Dev Server (HTTP)',
      'uri': localUri,
      'bundle': localBundle,
      'note':
          'The mailroom across the corridor. Plain post; no escort needed.',
      'icon': Icons.computer,
      'color': Color(0xFF6A1B9A),
    },
    {
      'label': 'Versioned Manifest',
      'uri': versionedUri,
      'bundle': versionedBundle,
      'note': 'A new despatch register every quarter. Old keys still work.',
      'icon': Icons.history_edu,
      'color': Color(0xFFEF6C00),
    },
    {
      'label': 'Regional Sub-Depot',
      'uri': regionalUri,
      'bundle': regionalBundle,
      'note': 'European branch line — closer to its readers.',
      'icon': Icons.flag,
      'color': Color(0xFF2E7D32),
    },
  ];

  final uriCards = <Widget>[];
  for (var i = 0; i < uriPatterns.length; i++) {
    final p = uriPatterns[i];
    final color = p['color'] as Color;
    final uri = p['uri'] as Uri;
    final bundle = p['bundle'] as NetworkAssetBundle;
    print(
      '  pattern #$i: ${p['label']} -> $uri (runtimeType=${bundle.runtimeType})',
    );

    uriCards.add(
      Container(
        width: 260.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: Color(0xFF3E2723).withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(p['icon'] as IconData, color: color, size: 28.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    p['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Color(0xFF3E2723),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                uri.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Color(0xFFFFE082),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                _kv('scheme', uri.scheme, color),
                SizedBox(width: 8.0),
                _kv('host', uri.host.isEmpty ? '(none)' : uri.host, color),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                _kv('port', uri.hasPort ? uri.port.toString() : '-', color),
                SizedBox(width: 8.0),
                _kv('path', uri.path.isEmpty ? '/' : uri.path, color),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Text(
                p['note'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF4E342E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${uriCards.length} base-URI cards.');

  // ============================================================
  // SECTION 4: URI resolution pipeline (anatomy)
  // ============================================================
  print('=== Section 4: URI Resolution Pipeline ===');

  final exampleKey = 'images/seals/wax_seal_07.png';
  final resolvedExample = cdnUri.resolve(exampleKey);
  print('  base = $cdnUri');
  print('  key  = $exampleKey');
  print('  resolved = $resolvedExample');

  final pipelineStages = <Map<String, dynamic>>[
    {
      'title': 'BASE',
      'value': cdnUri.toString(),
      'caption': 'NetworkAssetBundle.baseUrl',
      'color': Color(0xFF5D4037),
      'icon': Icons.home_work,
    },
    {
      'title': 'KEY',
      'value': exampleKey,
      'caption': 'argument to load(key)',
      'color': Color(0xFFEF6C00),
      'icon': Icons.label,
    },
    {
      'title': 'RESOLVE',
      'value': 'baseUrl.resolve(key)',
      'caption': 'Uri resolution per RFC 3986',
      'color': Color(0xFF6A1B9A),
      'icon': Icons.merge_type,
    },
    {
      'title': 'FETCH',
      'value': resolvedExample.toString(),
      'caption': 'HTTP GET dispatched',
      'color': Color(0xFF1565C0),
      'icon': Icons.send,
    },
    {
      'title': 'CACHE',
      'value': 'stored under key="$exampleKey"',
      'caption': 'CachingAssetBundle pigeonhole',
      'color': Color(0xFF2E7D32),
      'icon': Icons.archive,
    },
  ];

  final pipelineRows = <Widget>[];
  for (var i = 0; i < pipelineStages.length; i++) {
    final s = pipelineStages[i];
    final color = s['color'] as Color;
    pipelineRows.add(
      Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Text(
              '${i + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Icon(s['icon'] as IconData, color: color, size: 22.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.10),
                    color.withValues(alpha: 0.20),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: color, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        s['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          letterSpacing: 1.5,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        s['caption'] as String,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    s['value'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (i != pipelineStages.length - 1) {
      pipelineRows.add(
        Padding(
          padding: EdgeInsets.only(left: 18.0, top: 4.0, bottom: 4.0),
          child: Icon(
            Icons.arrow_downward,
            color: Color(0xFF8D6E63),
            size: 18.0,
          ),
        ),
      );
    }
  }

  final pipelineDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFFDE7), Color(0xFFFFE0B2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF8D6E63), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6D4C41).withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: Color(0xFF5D4037), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'URI Resolution Pipeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...pipelineRows,
      ],
    ),
  );
  print('Pipeline diagram built (${pipelineStages.length} stages).');

  // ============================================================
  // SECTION 5: Method catalogue
  // ============================================================
  print('=== Section 5: Method Catalogue ===');

  final methods = <Map<String, dynamic>>[
    {
      'sig': 'Future<ByteData> load(String key)',
      'role': 'Fetch raw parcel as ByteData. Caches on success.',
      'icon': Icons.download_rounded,
      'color': Color(0xFF1565C0),
    },
    {
      'sig': 'Future<String> loadString(String key, {bool cache = true})',
      'role': 'Decode UTF-8 text. Disable cache for one-off bulky letters.',
      'icon': Icons.text_snippet,
      'color': Color(0xFF2E7D32),
    },
    {
      'sig': 'Future<T> loadStructuredData<T>(String key, parser)',
      'role': 'Run parser on cached String — JSON, YAML, manifests.',
      'icon': Icons.account_tree_outlined,
      'color': Color(0xFF6A1B9A),
    },
    {
      'sig': 'Future<ByteData> loadBuffer(String key)',
      'role': 'Same as load(); returns immutable buffer (newer API).',
      'icon': Icons.memory,
      'color': Color(0xFF0277BD),
    },
    {
      'sig': 'bool evict(String key)',
      'role': 'Empty one pigeonhole. Returns true if a parcel was there.',
      'icon': Icons.delete_outline,
      'color': Color(0xFFEF6C00),
    },
    {
      'sig': 'void clear()',
      'role': 'Empty the entire pigeonhole wall. Use sparingly.',
      'icon': Icons.cleaning_services,
      'color': Color(0xFFC62828),
    },
  ];

  final methodCards = <Widget>[];
  for (var i = 0; i < methods.length; i++) {
    final m = methods[i];
    final color = m['color'] as Color;
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.20),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.20),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              child: Icon(m['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m['sig'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    m['role'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${methodCards.length} method cards.');

  // ============================================================
  // SECTION 6: Cache key namespace (the pigeonhole wall)
  // ============================================================
  print('=== Section 6: Cache Key Namespace ===');

  final cacheKeys = <Map<String, dynamic>>[
    {
      'key': 'images/seals/wax_seal_07.png',
      'kind': 'image',
      'icon': Icons.image,
      'color': Color(0xFF1565C0),
    },
    {
      'key': 'config/depot_routes.json',
      'kind': 'json',
      'icon': Icons.data_object,
      'color': Color(0xFF6A1B9A),
    },
    {
      'key': 'fonts/Copperplate-Regular.ttf',
      'kind': 'font',
      'icon': Icons.font_download,
      'color': Color(0xFFEF6C00),
    },
    {
      'key': 'manifest/parcel_manifest.yaml',
      'kind': 'yaml',
      'icon': Icons.list_alt,
      'color': Color(0xFF2E7D32),
    },
    {
      'key': 'audio/whistle_long.wav',
      'kind': 'audio',
      'icon': Icons.audiotrack,
      'color': Color(0xFFC62828),
    },
    {
      'key': 'docs/preamble.txt',
      'kind': 'text',
      'icon': Icons.notes,
      'color': Color(0xFF455A64),
    },
  ];

  final pigeonholeCells = <Widget>[];
  for (var i = 0; i < cacheKeys.length; i++) {
    final c = cacheKeys[i];
    final color = c['color'] as Color;
    final key = c['key'] as String;
    final keyParts = key.split('/');
    pigeonholeCells.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8E1), color.withValues(alpha: 0.18)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6D4C41).withValues(alpha: 0.20),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(c['icon'] as IconData, color: color, size: 20.0),
                SizedBox(width: 6.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    (c['kind'] as String).toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  '#${(i + 1).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              key,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Color(0xFF3E2723),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                for (var p = 0; p < keyParts.length; p++)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 1.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      keyParts[p],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9.0,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${pigeonholeCells.length} pigeonhole cells.');

  // ============================================================
  // SECTION 7: load/evict/clear lifecycle (anatomy)
  // ============================================================
  print('=== Section 7: Lifecycle Diagram ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'verb': 'load(key)',
      'state': 'MISS',
      'desc': 'No parcel for that key. Dispatch HTTP GET to baseUrl.resolve.',
      'color': Color(0xFFEF6C00),
      'icon': Icons.search_off,
    },
    {
      'verb': 'fetch',
      'state': 'NETWORK',
      'desc': 'Courier returns; ByteData received and decoded if needed.',
      'color': Color(0xFF1565C0),
      'icon': Icons.cloud_download,
    },
    {
      'verb': 'cache.put',
      'state': 'STORED',
      'desc': 'Pigeonhole keyed on the original key; subsequent loads HIT.',
      'color': Color(0xFF2E7D32),
      'icon': Icons.archive,
    },
    {
      'verb': 'load(key)',
      'state': 'HIT',
      'desc': 'Return cached parcel without touching the network.',
      'color': Color(0xFF388E3C),
      'icon': Icons.flash_on,
    },
    {
      'verb': 'evict(key)',
      'state': 'INVALIDATED',
      'desc': 'Single pigeonhole emptied. Next load(key) re-fetches.',
      'color': Color(0xFFC62828),
      'icon': Icons.delete_outline,
    },
    {
      'verb': 'clear()',
      'state': 'WIPED',
      'desc': 'All pigeonholes emptied. Use on logout/version-bump.',
      'color': Color(0xFF6D4C41),
      'icon': Icons.cleaning_services,
    },
  ];

  final lifecycleChildren = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final s = lifecycleSteps[i];
    final color = s['color'] as Color;
    lifecycleChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: color, width: 4.0)),
        ),
        child: Row(
          children: [
            Icon(s['icon'] as IconData, color: color, size: 22.0),
            SizedBox(width: 10.0),
            Container(
              width: 90.0,
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                s['state'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['verb'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    s['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: When-to-use comparison panel
  // ============================================================
  print('=== Section 8: When-to-use comparison ===');

  final useCases = <Map<String, dynamic>>[
    {
      'name': 'rootBundle',
      'tagline': 'The in-house archive',
      'use':
          'Use for assets shipped IN your app — declared in pubspec.yaml. '
          'Always available, zero network. Static content.',
      'avoid':
          'Avoid for content that changes after release; you cannot update it '
          'without shipping a new build.',
      'color': Color(0xFF2E7D32),
      'icon': Icons.inventory,
    },
    {
      'name': 'DefaultAssetBundle.of(context)',
      'tagline': 'The clerk on duty',
      'use':
          'Use inside widgets to obtain whatever bundle the surrounding tree '
          'provides. Tests can substitute a fake bundle this way.',
      'avoid':
          'Avoid in non-widget code. There is no context — fall back to '
          'rootBundle directly.',
      'color': Color(0xFF6A1B9A),
      'icon': Icons.support_agent,
    },
    {
      'name': 'NetworkAssetBundle',
      'tagline': 'The express courier',
      'use':
          'Use for assets that live on a server, dynamic content, '
          'localised packs, or testing scenarios where a fake server stands in.',
      'avoid':
          'Avoid for tight render loops — every miss pays HTTP latency. '
          'Pre-warm critical keys during startup.',
      'color': Color(0xFF1565C0),
      'icon': Icons.local_shipping,
    },
  ];

  final useCaseCards = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final u = useCases[i];
    final color = u['color'] as Color;
    useCaseCards.add(
      Container(
        width: 290.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: Color(0xFF3E2723).withValues(alpha: 0.10),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(u['icon'] as IconData, color: color, size: 30.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        u['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        u['tagline'] as String,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4E342E),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(6.0),
                border: Border(
                  left: BorderSide(color: Color(0xFF388E3C), width: 3.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF388E3C),
                    size: 16.0,
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      u['use'] as String,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(6.0),
                border: Border(
                  left: BorderSide(color: Color(0xFFC62828), width: 3.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.cancel, color: Color(0xFFC62828), size: 16.0),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      u['avoid'] as String,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFFB71C1C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${useCaseCards.length} use-case cards.');

  // ============================================================
  // SECTION 9: Configuration recipes
  // ============================================================
  print('=== Section 9: Configuration Recipes ===');

  final recipes = <Map<String, dynamic>>[
    {
      'title': 'Single-region CDN',
      'code':
          'final bundle = NetworkAssetBundle(\n'
          '  Uri.parse(\'https://cdn.example.com/assets/\'),\n'
          ');\n'
          'final mfst = await bundle.loadString(\'manifest.json\');',
      'note':
          'Most apps need only this. The bundle caches strings in memory '
          'after the first hit.',
    },
    {
      'title': 'Versioned manifest with cache busting',
      'code':
          'final version = \'v3\';\n'
          'final bundle = NetworkAssetBundle(\n'
          '  Uri.parse(\'https://cdn.example.com/assets/\$version/\'),\n'
          ');\n'
          '// On version bump:\n'
          'oldBundle.clear();',
      'note':
          'Embed the version in the base URI; flip the variable on release '
          'and clear the previous bundle.',
    },
    {
      'title': 'Local dev proxy',
      'code':
          'final dev = NetworkAssetBundle(\n'
          '  Uri.parse(\'http://localhost:8080/assets/\'),\n'
          ');\n'
          '// In tests:\n'
          'await runApp(\n'
          '  DefaultAssetBundle(bundle: dev, child: MyApp()),\n'
          ');',
      'note':
          'Wrap your widget tree in DefaultAssetBundle to inject a network '
          'bundle for tests or a hot-reloadable asset server.',
    },
    {
      'title': 'Selective invalidation',
      'code':
          'final removed = bundle.evict(\'config/depot_routes.json\');\n'
          'if (removed) {\n'
          '  final fresh = await bundle\n'
          '    .loadString(\'config/depot_routes.json\');\n'
          '}',
      'note':
          'evict returns whether something was actually cached. Use it for '
          'fine-grained invalidation without nuking unrelated parcels.',
    },
    {
      'title': 'Structured manifest parsing',
      'code':
          'Future<Map<String, dynamic>> parse(String s) async {\n'
          '  return jsonDecode(s) as Map<String, dynamic>;\n'
          '}\n'
          'final cfg = await bundle.loadStructuredData(\n'
          '  \'config/depot_routes.json\', parse);',
      'note':
          'loadStructuredData caches the parsed value, not just the bytes — '
          'parsers run only on the first call.',
    },
  ];

  final recipeCards = <Widget>[];
  for (var i = 0; i < recipes.length; i++) {
    final r = recipes[i];
    recipeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Color(0xFF8D6E63), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6D4C41).withValues(alpha: 0.20),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFF5D4037),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22.0,
                    height: 22.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE082),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    r['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Color(0xFFFFF8E1),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF263238),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      r['code'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Color(0xFF80DEEA),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFFEF6C00),
                        size: 16.0,
                      ),
                      SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          r['note'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${recipeCards.length} recipe cards.');

  // ============================================================
  // SECTION 10: Despatch ledger — runtime introspection of bundles
  // ============================================================
  print('=== Section 10: Despatch Ledger ===');

  final ledgerEntries = <Widget>[];
  final allBundles = [cdnBundle, localBundle, versionedBundle, regionalBundle];
  final allUris = [cdnUri, localUri, versionedUri, regionalUri];
  final ledgerLabels = [
    'Public CDN',
    'Local Dev',
    'Versioned',
    'Regional EU',
  ];
  for (var i = 0; i < allBundles.length; i++) {
    final bundle = allBundles[i];
    final uri = allUris[i];
    final isHttps = uri.scheme == 'https';
    ledgerEntries.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i.isEven
              ? Color(0xFFFFF8E1)
              : Color(0xFFFFE0B2).withValues(alpha: 0.6),
          border: Border(
            bottom: BorderSide(color: Color(0xFF8D6E63), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                ledgerLabels[i],
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: isHttps ? Color(0xFF2E7D32) : Color(0xFFEF6C00),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  uri.scheme.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                uri.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Color(0xFF3E2723),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              bundle.runtimeType.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.5,
                color: Color(0xFF6D4C41),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final ledger = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF5D4037), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3E2723).withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF5D4037),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.menu_book, color: Color(0xFFFFE082), size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Despatch Ledger  —  Active Bundles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Color(0xFFFFF8E1),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          color: Color(0xFFD7CCC8),
          child: Row(
            children: [
              SizedBox(
                width: 28.0,
                child: Text(
                  '#',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(
                  'Label',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
              SizedBox(
                width: 70.0,
                child: Text(
                  'Scheme',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Base URI',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
              Text(
                'Type',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),
            ],
          ),
        ),
        ...ledgerEntries,
      ],
    ),
  );
  print('Built ledger with ${ledgerEntries.length} rows.');

  // ============================================================
  // SECTION 11: Code excerpts in dark scriptorium
  // ============================================================
  print('=== Section 11: Code Excerpts ===');

  final codeBlock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF000000).withValues(alpha: 0.40),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF80DEEA), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'From the chief clerk\'s notebook',
              style: TextStyle(
                color: Color(0xFF80DEEA),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _code(
          '// 1. Construct a NetworkAssetBundle.\n'
          'final bundle = NetworkAssetBundle(\n'
          '  Uri.parse(\'https://cdn.example.com/assets/\'),\n'
          ');',
          Color(0xFF90CAF9),
        ),
        SizedBox(height: 8.0),
        _code(
          '// 2. Read structured data once; cached afterwards.\n'
          'final cfg = await bundle.loadStructuredData(\n'
          '  \'config/depot_routes.json\',\n'
          '  (s) async => jsonDecode(s) as Map<String, dynamic>,\n'
          ');',
          Color(0xFFA5D6A7),
        ),
        SizedBox(height: 8.0),
        _code(
          '// 3. Invalidate one entry, or sweep the whole pigeonhole wall.\n'
          'bundle.evict(\'config/depot_routes.json\');\n'
          'bundle.clear();',
          Color(0xFFFFAB91),
        ),
        SizedBox(height: 8.0),
        _code(
          '// 4. Inject for tests via DefaultAssetBundle.\n'
          'DefaultAssetBundle(\n'
          '  bundle: NetworkAssetBundle(\n'
          '    Uri.parse(\'http://localhost:8080/assets/\'),\n'
          '  ),\n'
          '  child: MyApp(),\n'
          ');',
          Color(0xFFCE93D8),
        ),
      ],
    ),
  );
  print('Code excerpts ready.');

  // ============================================================
  // SECTION 12: Postscript — narrative paragraphs
  // ============================================================
  print('=== Section 12: Postscript ===');

  final postscript = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEFEBE9), Color(0xFFD7CCC8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF8D6E63), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6D4C41).withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history_edu, color: Color(0xFF5D4037), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'The Postmaster\'s Notes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _para(
          'NetworkAssetBundle exists for one purpose: to let an AssetBundle '
          'speak HTTP. Construct it with a base URI ending in a trailing slash '
          '(this matters — Uri.resolve treats trailing slashes as the boundary '
          'between directory and file). Every key passed to load is then '
          'resolved against that base, an HTTP GET issued, and the result '
          'cached in the parent CachingAssetBundle.',
        ),
        SizedBox(height: 8.0),
        _para(
          'rootBundle is a top-level field (not a method, not a constant). On '
          'all known platforms it is a PlatformAssetBundle that talks to the '
          'platform asset channel for parcels declared in pubspec.yaml. It '
          'cannot be replaced — but every widget can override what '
          'DefaultAssetBundle.of(context) returns by wrapping its subtree in a '
          'DefaultAssetBundle widget. That is the seam most tests use to '
          'inject a NetworkAssetBundle pointing at a fake server.',
        ),
        SizedBox(height: 8.0),
        _para(
          'evict(key) returns true if the key was found and removed. clear() '
          'returns nothing. Both operate on the in-memory cache only — they '
          'do not flush HTTP-layer caches kept by the underlying client. If '
          'you need a hard reload across a version bump, change the base URI '
          'instead of relying on cache invalidation.',
        ),
      ],
    ),
  );

  print('=== All sections assembled. Closing the depot ledger. ===');

  // ============================================================
  // Compose the final scrolling page.
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        SizedBox(height: 24.0),

        _sectionTitle('1.  AssetBundle Class Hierarchy'),
        hierarchyDiagram,
        SizedBox(height: 24.0),

        _sectionTitle('2.  Base-URI Patterns'),
        Wrap(alignment: WrapAlignment.center, children: uriCards),
        SizedBox(height: 24.0),

        _sectionTitle('3.  URI Resolution Pipeline'),
        pipelineDiagram,
        SizedBox(height: 24.0),

        _sectionTitle('4.  Method Catalogue'),
        ...methodCards,
        SizedBox(height: 24.0),

        _sectionTitle('5.  Cache Key Namespace  —  the Pigeonhole Wall'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF8D6E63), width: 1.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: pigeonholeCells,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('6.  Lifecycle  —  Load / Evict / Clear'),
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF8D6E63), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: lifecycleChildren,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('7.  When to Use Which Bundle'),
        Wrap(alignment: WrapAlignment.center, children: useCaseCards),
        SizedBox(height: 24.0),

        _sectionTitle('8.  Configuration Recipes'),
        ...recipeCards,
        SizedBox(height: 24.0),

        _sectionTitle('9.  Despatch Ledger'),
        ledger,
        SizedBox(height: 24.0),

        _sectionTitle('10. Code Excerpts'),
        codeBlock,
        SizedBox(height: 24.0),

        _sectionTitle('11. Postmaster\'s Notes'),
        postscript,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 28.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5D4037), Color(0xFFEF6C00)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String k, String v, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: color.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            k,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            v,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF3E2723),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

Widget _code(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
      ),
    ),
  );
}

Widget _para(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 12.0,
      height: 1.5,
      color: Color(0xFF3E2723),
    ),
  );
}
