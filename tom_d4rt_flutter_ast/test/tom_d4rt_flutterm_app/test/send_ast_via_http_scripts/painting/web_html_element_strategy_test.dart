// ignore_for_file: avoid_print
// D4rt deep-demo: WebHtmlElementStrategy — Sand / Dune theme, prefix we
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget weSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFA0845A), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF7A6340),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget weChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget weInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A6340))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E8A68))),
        ),
      ],
    ),
  );
}

Widget weStrategyCard(String name, IconData icon, Color accent,
    String desc, String benefits, String drawbacks) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7A6340))),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(desc,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF9E8A68))),
        SizedBox(height: 6.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.add_circle, color: Color(0xFF7AAF8E), size: 14.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(benefits,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF5A9A6E))),
            ),
          ],
        ),
        SizedBox(height: 3.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.remove_circle, color: Color(0xFFCC7766), size: 14.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(drawbacks,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFFB55A4A))),
            ),
          ],
        ),
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('WebHtmlElementStrategy Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] WebHtmlElementStrategy Overview');
  print('  Enum controlling how images render on Flutter Web');
  print('  3 values: prefer, fallback, never');
  print('  Only affects web platform');

  final weTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFA0845A), Color(0xFF7A6340)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.web, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('WebHtmlElementStrategy',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
            'Controls whether Flutter Web uses native HTML <img> elements '
            'or decodes images in Dart for rendering',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFE0D4C0))),
        SizedBox(height: 6.0),
        Row(
          children: [
            weChip('prefer', Color(0xFFC4A874)),
            weChip('fallback', Color(0xFFB09060)),
            weChip('never', Color(0xFF8A7050)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Three Values ─────────────────────────────────
  print('\n[2] The Three Strategies');
  for (final v in WebHtmlElementStrategy.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final weThreeValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      children: [
        weStrategyCard(
          'prefer',
          Icons.speed,
          Color(0xFFC4A874),
          'Always use HTML <img> element when possible. '
              'The browser handles image decoding natively.',
          'Fast loading, low memory, hardware-accelerated, lazy decode',
          'Cannot access pixel data, no shader effects, no custom painting',
        ),
        weStrategyCard(
          'fallback',
          Icons.sync_alt,
          Color(0xFFB09060),
          'Prefer raw bytes for Dart decoding, but fall back to HTML '
              '<img> element if byte decoding is not supported.',
          'Pixel manipulation possible when bytes work, graceful fallback',
          'Less predictable behavior across image formats',
        ),
        weStrategyCard(
          'never',
          Icons.memory,
          Color(0xFF8A7050),
          'Always decode the image in Dart, never use HTML elements. '
              'Full access to pixel data.',
          'Full pixel access, shader support, custom painting, consistent rendering',
          'Higher memory usage, slower loading, manual decode overhead',
        ),
      ],
    ),
  );

  // ── Section 3: Platform Context ──────────────────────────────
  print('\n[3] Platform Context');
  print('  Web only — ignored on mobile/desktop');
  print('  Flutter Web can use CanvasKit or HTML renderer');
  print('  HTML renderer uses DOM elements for images');

  final wePlatformSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform Applicability',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 8.0),
        _wePlatformRow(Icons.web, 'Flutter Web',
            'Fully applies — controls image rendering strategy',
            Color(0xFFC4A874), true),
        _wePlatformRow(Icons.phone_android, 'Android',
            'Ignored — uses native Skia rendering', Color(0xFF9E8A68), false),
        _wePlatformRow(Icons.phone_iphone, 'iOS',
            'Ignored — uses native Impeller/Skia', Color(0xFF9E8A68), false),
        _wePlatformRow(Icons.desktop_windows, 'Desktop',
            'Ignored — uses native rendering pipeline', Color(0xFF9E8A68), false),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Setting WebHtmlElementStrategy on non-web platforms has no effect. '
            'The property is safe to set unconditionally — it will be silently '
            'ignored on native platforms.',
            style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF9E8A68)),
          ),
        ),
      ],
    ),
  );

  // ── Section 4: NetworkImage Integration ──────────────────────
  print('\n[4] NetworkImage Integration');
  print('  NetworkImage.webHtmlElementStrategy property');
  print('  Controls per-image strategy');

  final weNetworkSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NetworkImage Configuration',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 8.0),
        weInfoRow('Property:', 'webHtmlElementStrategy'),
        weInfoRow('Type:', 'WebHtmlElementStrategy'),
        weInfoRow('Default:', 'WebHtmlElementStrategy.prefer'),
        weInfoRow('Where:', 'NetworkImage constructor'),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5EDE0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Image.network(\n'
            '  "https://example.com/photo.jpg",\n'
            '  // Under the hood, creates NetworkImage\n'
            '  // with webHtmlElementStrategy\n'
            ')\n\n'
            '// Or directly:\n'
            'NetworkImage(\n'
            '  "https://example.com/photo.jpg",\n'
            '  webHtmlElementStrategy:\n'
            '    WebHtmlElementStrategy.never,\n'
            ')',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF7A6340)),
          ),
        ),
      ],
    ),
  );

  // ── Section 5: Performance Tradeoffs ─────────────────────────
  print('\n[5] Performance Tradeoffs');
  print('  prefer: fastest loading, lowest memory');
  print('  fallback: medium, depends on format support');
  print('  never: slowest loading, highest memory, full control');

  final perfData = <Map<String, dynamic>>[
    {
      'mode': 'prefer',
      'speed': 0.95,
      'memory': 0.2,
      'control': 0.15,
      'color': Color(0xFFC4A874),
    },
    {
      'mode': 'fallback',
      'speed': 0.65,
      'memory': 0.5,
      'control': 0.6,
      'color': Color(0xFFB09060),
    },
    {
      'mode': 'never',
      'speed': 0.35,
      'memory': 0.85,
      'control': 0.95,
      'color': Color(0xFF8A7050),
    },
  ];

  final wePerfSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      children: perfData.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              weChip(p['mode'] as String, p['color'] as Color),
              SizedBox(height: 6.0),
              _wePerfBar('Speed', p['speed'] as double, Color(0xFF5A9A6E)),
              _wePerfBar('Memory', p['memory'] as double, Color(0xFFCC7766)),
              _wePerfBar(
                  'Control', p['control'] as double, Color(0xFF6B8FC4)),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 6: Decision Tree ─────────────────────────────────
  print('\n[6] Decision Tree');
  print('  Need pixel access? → never');
  print('  Need fast loading? → prefer');
  print('  Unsure about format? → fallback');

  final weDecisionSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Which Strategy to Choose?',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 10.0),
        _weDecisionNode(
            'Do you need to access image pixels?',
            'Yes → never',
            'No → continue',
            Color(0xFF8A7050)),
        _weDecisionNode(
            'Is loading speed the top priority?',
            'Yes → prefer',
            'No → continue',
            Color(0xFFC4A874)),
        _weDecisionNode(
            'Are you using exotic image formats?',
            'Yes → fallback',
            'No → prefer (default)',
            Color(0xFFB09060)),
      ],
    ),
  );

  // ── Section 7: Feature Comparison ────────────────────────────
  print('\n[7] Feature Comparison Matrix');

  final featureData = <Map<String, String>>[
    {'feature': 'HTML <img>', 'prefer': 'Yes', 'fallback': 'Fallback', 'never': 'No'},
    {'feature': 'Dart decode', 'prefer': 'No', 'fallback': 'Primary', 'never': 'Yes'},
    {'feature': 'Pixel access', 'prefer': 'No', 'fallback': 'Maybe', 'never': 'Yes'},
    {'feature': 'Shaders', 'prefer': 'No', 'fallback': 'Maybe', 'never': 'Yes'},
    {'feature': 'Memory', 'prefer': 'Low', 'fallback': 'Medium', 'never': 'High'},
    {'feature': 'Speed', 'prefer': 'Fast', 'fallback': 'Medium', 'never': 'Slow'},
  ];

  final weFeatureTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 80.0,
                child: Text('Feature',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF7A6340)))),
            Expanded(
                child: Text('prefer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFFC4A874)))),
            Expanded(
                child: Text('fallback',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFFB09060)))),
            Expanded(
                child: Text('never',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF8A7050)))),
          ],
        ),
        Divider(color: Color(0xFFE0D4C0)),
        ...featureData.map((f) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  SizedBox(
                      width: 80.0,
                      child: Text(f['feature']!,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A6340)))),
                  Expanded(
                      child: Text(f['prefer']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF9E8A68)))),
                  Expanded(
                      child: Text(f['fallback']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF9E8A68)))),
                  Expanded(
                      child: Text(f['never']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF9E8A68)))),
                ],
              ),
            )),
      ],
    ),
  );

  // ── Section 8: Use Cases ─────────────────────────────────────
  print('\n[8] Practical Use Cases');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Photo Gallery',
      'icon': Icons.photo_library,
      'mode': 'prefer',
      'color': Color(0xFFC4A874),
      'desc': 'Fast loading, browser-optimized display',
    },
    {
      'title': 'Image Editor',
      'icon': Icons.edit,
      'mode': 'never',
      'color': Color(0xFF8A7050),
      'desc': 'Pixel manipulation for filters and effects',
    },
    {
      'title': 'Avatar Display',
      'icon': Icons.account_circle,
      'mode': 'prefer',
      'color': Color(0xFFC4A874),
      'desc': 'Simple display, no processing needed',
    },
    {
      'title': 'Chart with Image',
      'icon': Icons.show_chart,
      'mode': 'never',
      'color': Color(0xFF8A7050),
      'desc': 'Custom painting over image data',
    },
    {
      'title': 'Mixed Content CMS',
      'icon': Icons.article,
      'mode': 'fallback',
      'color': Color(0xFFB09060),
      'desc': 'Various image formats from user uploads',
    },
    {
      'title': 'Background Image',
      'icon': Icons.wallpaper,
      'mode': 'prefer',
      'color': Color(0xFFC4A874),
      'desc': 'Decorative only, low priority decode',
    },
  ];

  final weUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: useCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Color(0xFFE0D4C0).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData,
                      color: uc['color'] as Color, size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(
                      child: Text(uc['title'] as String,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF7A6340)))),
                ],
              ),
              SizedBox(height: 4.0),
              weChip(uc['mode'] as String, uc['color'] as Color),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF9E8A68))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 9: Switch Pattern ────────────────────────────────
  print('\n[9] Switch Pattern');
  final testStrategy = WebHtmlElementStrategy.prefer;
  switch (testStrategy) {
    case WebHtmlElementStrategy.prefer:
      print('  → Use HTML element');
    case WebHtmlElementStrategy.fallback:
      print('  → Try bytes, fall back to HTML');
    case WebHtmlElementStrategy.never:
      print('  → Always decode in Dart');
  }

  final weSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5EDE0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final rendering = switch (strategy) {\n'
            '  ...prefer  => "HTML element",\n'
            '  ...fallback => "Bytes then HTML",\n'
            '  ...never    => "Dart decode only",\n'
            '};',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF7A6340)),
          ),
        ),
        SizedBox(height: 8.0),
        ...WebHtmlElementStrategy.values.map((v) {
          final desc = switch (v) {
            WebHtmlElementStrategy.prefer => 'Use native HTML <img>',
            WebHtmlElementStrategy.fallback =>
              'Try bytes, fall back to HTML',
            WebHtmlElementStrategy.never => 'Decode in Dart always',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right,
                    color: Color(0xFFA0845A), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFF9E8A68))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 10: Web Renderer Context ─────────────────────────
  print('\n[10] Web Renderer Context');
  print('  Flutter Web has two renderers: HTML and CanvasKit');
  print('  HTML renderer: native DOM elements (img, canvas)');
  print('  CanvasKit: Skia compiled to WASM');
  print('  WebHtmlElementStrategy mainly for HTML renderer');

  final weRendererSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Web Rendering Engines',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 8.0),
        _weRendererCard('HTML Renderer', 'DOM-based',
            'Uses native <img> elements for images. '
            'WebHtmlElementStrategy directly controls behavior.',
            Color(0xFFC4A874)),
        _weRendererCard('CanvasKit', 'Skia-WASM',
            'Renders via Skia on canvas. HTML element strategy '
            'can still apply for image loading optimization.',
            Color(0xFF8A7050)),
        _weRendererCard('Skwasm', 'WASM-based',
            'Newer rendering backend. Similar to CanvasKit '
            'with improved performance characteristics.',
            Color(0xFFB09060)),
      ],
    ),
  );

  // ── Section 11: Equality & Hashing ───────────────────────────
  print('\n[11] Equality & Hashing');
  print('  prefer == prefer: ${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.prefer}');
  print('  prefer == never: ${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.never}');

  final weEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        weInfoRow('prefer == prefer:',
            '${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.prefer}'),
        weInfoRow('prefer == never:',
            '${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.never}'),
        weInfoRow('hashCode prefer:',
            '${WebHtmlElementStrategy.prefer.hashCode}'),
        weInfoRow('hashCode never:',
            '${WebHtmlElementStrategy.never.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFE0D4C0)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: WebHtmlElementStrategy.values
              .toSet()
              .map((v) => weChip(v.name, Color(0xFFA0845A)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 12: Code Patterns ────────────────────────────────
  print('\n[12] Common Code Patterns');

  final wePatterns = <Map<String, String>>[
    {
      'title': 'Fast Photo Display',
      'code': 'Image.network(\n'
          '  url,\n'
          '  // Default: prefer → HTML <img>\n'
          '  // Fastest for pure display\n'
          ')',
    },
    {
      'title': 'Image with Pixel Processing',
      'code': 'Image(\n'
          '  image: NetworkImage(\n'
          '    url,\n'
          '    webHtmlElementStrategy:\n'
          '      WebHtmlElementStrategy.never,\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Safe Fallback for CMS',
      'code': 'NetworkImage(\n'
          '  userUploadedUrl,\n'
          '  webHtmlElementStrategy:\n'
          '    WebHtmlElementStrategy.fallback,\n'
          ')',
    },
  ];

  final wePatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      children: wePatterns.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p['title']!,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA0845A))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5EDE0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF7A6340))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 13: Image Provider Chain ─────────────────────────
  print('\n[13] Image Provider Chain');
  print('  NetworkImage → resolve → load → strategy decides');

  final weChainSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Image Loading Pipeline',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 10.0),
        _weChainStep('1', 'NetworkImage created',
            'webHtmlElementStrategy set', Color(0xFFC4A874)),
        _weChainStep('2', 'resolve() called',
            'Creates ImageStreamCompleter', Color(0xFFB09060)),
        _weChainStep('3', 'loadImage() invoked',
            'Strategy determines loading path', Color(0xFF8A7050)),
        _weChainStep('4a', 'prefer → HTML <img>',
            'Browser decodes natively', Color(0xFFC4A874)),
        _weChainStep('4b', 'never → Dart decode',
            'Bytes fetched and decoded in Dart', Color(0xFF8A7050)),
      ],
    ),
  );

  // ── Section 14: Best Practices ───────────────────────────────
  print('\n[14] Best Practices');
  print('  Default (prefer) is best for most apps');
  print('  Only use "never" when pixel access is required');
  print('  Use "fallback" for mixed-format content');

  final weBestPractices = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF5ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      children: [
        _weTipCard(Icons.check_circle, Color(0xFF5A9A6E),
            'Use prefer (default) for display-only images'),
        _weTipCard(Icons.check_circle, Color(0xFF5A9A6E),
            'Use never only when you need pixel-level access'),
        _weTipCard(Icons.check_circle, Color(0xFF5A9A6E),
            'Use fallback for CMS/user-uploaded content'),
        _weTipCard(Icons.warning, Color(0xFFCC9944),
            'Avoid never for large galleries — memory cost'),
        _weTipCard(Icons.warning, Color(0xFFCC9944),
            'Test with actual web builds — not visible in hot reload'),
        _weTipCard(Icons.info, Color(0xFF6B8FC4),
            'Setting strategy on non-web is safe but has no effect'),
      ],
    ),
  );

  // ── Section 15: Default Behavior ─────────────────────────────
  print('\n[15] Default Behavior');
  print('  Default: WebHtmlElementStrategy.prefer');
  print('  Most performant choice for pure display');

  final weDefaultSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0D4C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        weInfoRow('Default:', 'WebHtmlElementStrategy.prefer'),
        weInfoRow('Reason:', 'Fastest, lowest memory usage'),
        weInfoRow('Override:', 'Per-image via NetworkImage'),
        weInfoRow('Global:', 'No global override — set per image'),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'The default "prefer" strategy leverages the browser\'s native '
            'image decoding which is hardware-accelerated and typically '
            'faster than Dart-side decoding. Only override when you need '
            'specific Dart-side pixel access.',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF9E8A68)),
          ),
        ),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Total values: ${WebHtmlElementStrategy.values.length}');
  print('  Default: prefer');
  print('  Platform: Web only');

  final weSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF7A6340), Color(0xFFA0845A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('WebHtmlElementStrategy Dashboard',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${WebHtmlElementStrategy.values.length}',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE0D4C0))),
                Text('Strategies',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFC4B090))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.speed, color: Color(0xFFE0D4C0), size: 28.0),
                Text('Default: prefer',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFC4B090))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.web, color: Color(0xFFE0D4C0), size: 28.0),
                Text('Web platform',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFFC4B090))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          alignment: WrapAlignment.center,
          children: WebHtmlElementStrategy.values
              .map((v) => weChip(v.name, Color(0xFFC4A874)))
              .toList(),
        ),
      ],
    ),
  );

  print('\nWebHtmlElementStrategy Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        weTitleSection,
        SizedBox(height: 16.0),
        // 2 Three Values
        weSectionHeader('The Three Strategies', Icons.tune),
        weThreeValues,
        // 3 Platform
        weSectionHeader('Platform Context', Icons.devices),
        wePlatformSection,
        // 4 NetworkImage
        weSectionHeader('NetworkImage Integration', Icons.image),
        weNetworkSection,
        // 5 Performance
        weSectionHeader('Performance Tradeoffs', Icons.speed),
        wePerfSection,
        // 6 Decision
        weSectionHeader('Decision Tree', Icons.account_tree),
        weDecisionSection,
        // 7 Features
        weSectionHeader('Feature Comparison', Icons.table_chart),
        weFeatureTable,
        // 8 Use Cases
        weSectionHeader('Practical Use Cases', Icons.auto_awesome),
        weUseCaseSection,
        // 9 Switch
        weSectionHeader('Switch Pattern', Icons.alt_route),
        weSwitchSection,
        // 10 Renderer
        weSectionHeader('Web Renderer Context', Icons.layers),
        weRendererSection,
        // 11 Equality
        weSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        weEqualitySection,
        // 12 Patterns
        weSectionHeader('Common Code Patterns', Icons.code),
        wePatternsSection,
        // 13 Chain
        weSectionHeader('Image Loading Pipeline', Icons.linear_scale),
        weChainSection,
        // 14 Best Practices
        weSectionHeader('Best Practices', Icons.lightbulb_outline),
        weBestPractices,
        // 15 Default
        weSectionHeader('Default Behavior', Icons.settings),
        weDefaultSection,
        // 16 Summary
        SizedBox(height: 8.0),
        weSummarySection,
      ],
    ),
  );
}

// ── Top-level helpers ───────────────────────────────────────────
Widget _wePlatformRow(
    IconData icon, String platform, String note, Color color, bool applies) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 80.0,
          child: Text(platform,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7A6340))),
        ),
        Expanded(
          child: Text(note,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF9E8A68))),
        ),
        Icon(
          applies ? Icons.check_circle : Icons.cancel,
          color: applies ? Color(0xFF5A9A6E) : Color(0xFFCC7766),
          size: 16.0,
        ),
      ],
    ),
  );
}

Widget _wePerfBar(String label, double pct, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 50.0,
          child: Text(label,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF7A6340))),
        ),
        Expanded(
          child: SizedBox(
            height: 12.0,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: pct,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4.0),
        Text('${(pct * 100).toInt()}%',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF9E8A68))),
      ],
    ),
  );
}

Widget _weDecisionNode(
    String question, String yes, String no, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question,
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A6340))),
        SizedBox(height: 4.0),
        Row(
          children: [
            Icon(Icons.check, color: Color(0xFF5A9A6E), size: 14.0),
            Text(' $yes',
                style: TextStyle(
                    fontSize: 10.0, color: Color(0xFF5A9A6E))),
            SizedBox(width: 12.0),
            Icon(Icons.close, color: Color(0xFFCC7766), size: 14.0),
            Expanded(
              child: Text(' $no',
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFFCC7766))),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _weRendererCard(
    String name, String tag, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7A6340))),
            SizedBox(width: 6.0),
            weChip(tag, accent),
          ],
        ),
        SizedBox(height: 4.0),
        Text(desc,
            style: TextStyle(
                fontSize: 10.0, color: Color(0xFF9E8A68))),
      ],
    ),
  );
}

Widget _weChainStep(
    String step, String title, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
          child: Text(step,
              style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7A6340))),
              Text(desc,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF9E8A68))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _weTipCard(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 11.0, color: Color(0xFF9E8A68))),
        ),
      ],
    ),
  );
}
