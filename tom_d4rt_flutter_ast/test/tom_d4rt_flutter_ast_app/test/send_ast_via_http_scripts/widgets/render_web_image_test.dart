import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// RenderWebImage — Deep Visual Demo
// Web-only; educational simulation for non-web sandboxes.
// Entry point: build(BuildContext context)
// ---------------------------------------------------------------------------

// ── Top-level notifiers ─────────────────────────────────────────────────────

final ValueNotifier<int> _activeSrcsetIndex = ValueNotifier<int>(1);
final ValueNotifier<String> _activeFilter = ValueNotifier<String>('none');
final ValueNotifier<bool> _lazyVisible = ValueNotifier<bool>(false);
final ValueNotifier<String> _activeAlt = ValueNotifier<String>('A mountain lake at sunset');
final ValueNotifier<bool> _corsError = ValueNotifier<bool>(false);

// ── Entry point ─────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
    ),
    home: const _RenderWebImageDemo(),
  );
}

// ── Root scaffold ────────────────────────────────────────────────────────────

class _RenderWebImageDemo extends StatelessWidget {
  const _RenderWebImageDemo();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RenderWebImage — Deep Visual Demo'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.onPrimary,
            unselectedLabelColor:
                Theme.of(context).colorScheme.onPrimary.withAlpha(178),
            indicatorColor: Theme.of(context).colorScheme.onPrimary,
            tabs: const [
              Tab(text: '① Intro'),
              Tab(text: '② Architecture'),
              Tab(text: '③ HTML Attributes'),
              Tab(text: '④ CanvasKit vs HTML'),
              Tab(text: '⑤ CSS Filters'),
              Tab(text: '⑥ srcset / DPR'),
              Tab(text: '⑦ Accessibility'),
              Tab(text: '⑧ Lazy Loading'),
              Tab(text: '⑨ Pitfalls & API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _Tab1HeroBanner(),
            _Tab2Architecture(),
            _Tab3HtmlAttributes(),
            _Tab4CanvasKitVsHtml(),
            _Tab5CssFilters(),
            _Tab6SrcsetDpr(),
            _Tab7Accessibility(),
            _Tab8LazyLoading(),
            _Tab9PitfallsAndApi(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Hero Banner
// ═══════════════════════════════════════════════════════════════════════════

class _Tab1HeroBanner extends StatelessWidget {
  const _Tab1HeroBanner();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Hero card
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.web, size: 56, color: cs.onPrimary),
              const SizedBox(height: 12),
              Text(
                'RenderWebImage',
                style: tt.headlineLarge?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Web-only render object — HTML <img> inside Flutter',
                style: tt.titleMedium?.copyWith(color: cs.onPrimary.withAlpha(220)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Web-only badge
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                border: Border.all(color: Colors.orange.shade400),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 18, color: Colors.orange.shade800),
                  const SizedBox(width: 6),
                  Text(
                    'Web-only  •  Not available on native platforms',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        _SectionHeader('What is RenderWebImage?'),
        const SizedBox(height: 10),
        _InfoCard(
          child: Text(
            'RenderWebImage is the Flutter Web render object that backs the WebImage '
            'widget. Instead of decoding pixels through the Dart image pipeline and '
            'painting them onto the CanvasKit surface, it creates a native HTML '
            '<img> element and embeds it into the Flutter widget tree via a '
            'platform view slot. The browser compositor handles image decoding, '
            'caching, and painting — Flutter only positions and sizes the slot.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        const SizedBox(height: 20),

        _SectionHeader('HTML <img> vs CanvasKit-decoded image'),
        const SizedBox(height: 10),
        _CompactCompareRow(
          left: _CompactCompareCard(
            label: 'CanvasKit Pipeline',
            icon: Icons.developer_board,
            color: Colors.purple.shade100,
            points: [
              'Dart fetches bytes via HTTP',
              'Skia decodes pixels in WASM',
              'Rasterised onto <canvas>',
              'Pixel-perfect & filterable',
              'Higher CPU/GPU usage',
            ],
          ),
          right: _CompactCompareCard(
            label: 'RenderWebImage / <img>',
            icon: Icons.language,
            color: Colors.blue.shade100,
            points: [
              'Browser fetches via <img src>',
              'Native codec decodes pixels',
              'Browser compositor paints',
              'SEO & a11y friendly',
              'Lower memory footprint',
            ],
          ),
        ),

        const SizedBox(height: 20),

        _SectionHeader('When should you use WebImage?'),
        const SizedBox(height: 10),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletRow(icon: Icons.check_circle, color: Colors.green,
                  text: 'User-generated content (avatars, thumbnails) where SEO matters'),
              const SizedBox(height: 6),
              _BulletRow(icon: Icons.check_circle, color: Colors.green,
                  text: 'Responsive images with srcset and sizes attributes'),
              const SizedBox(height: 6),
              _BulletRow(icon: Icons.check_circle, color: Colors.green,
                  text: 'Accessibility: alt text is read by screen readers natively'),
              const SizedBox(height: 6),
              _BulletRow(icon: Icons.check_circle, color: Colors.green,
                  text: 'Lazy loading large images below the fold'),
              const SizedBox(height: 6),
              _BulletRow(icon: Icons.cancel, color: Colors.red,
                  text: 'Avoid when pixel-perfect shader effects are required'),
              const SizedBox(height: 6),
              _BulletRow(icon: Icons.cancel, color: Colors.red,
                  text: 'Avoid on native iOS/Android — WebImage throws an assertion'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        _SectionHeader('Simulation note'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Because this demo runs in a non-web sandbox, all HTML <img> elements '
            'and platform-view slots are simulated using Flutter widgets. Coloured '
            'rectangles, CustomPainter diagrams, and ColorFiltered containers stand '
            'in for actual browser-rendered images. Every section is labelled '
            '"[SIMULATED]" where real browser behaviour would differ.',
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Architecture Diagram
// ═══════════════════════════════════════════════════════════════════════════

class _Tab2Architecture extends StatelessWidget {
  const _Tab2Architecture();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Widget-to-Browser Rendering Pipeline'),
        const SizedBox(height: 6),
        Text(
          'How a WebImage widget becomes a native <img> element in the browser DOM.',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 420,
          child: CustomPaint(
            painter: _ArchitecturePainter(cs: cs),
          ),
        ),

        const SizedBox(height: 20),

        _SectionHeader('Layer Breakdown'),
        const SizedBox(height: 10),

        _ArchLayerCard(
          number: '1',
          title: 'WebImage Widget',
          description:
              'A StatelessWidget (LeafRenderObjectWidget) that accepts src, alt, '
              'fit, alignment, and web-specific attributes. It creates a '
              'RenderWebImage render object.',
          color: Colors.blue.shade50,
          border: Colors.blue,
        ),
        const SizedBox(height: 8),
        _ArchLayerCard(
          number: '2',
          title: 'RenderWebImage (RenderBox)',
          description:
              'The render object. Overrides createRenderObject / updateRenderObject. '
              'During paint() it requests a platform-view slot from the embedding and '
              'passes the HTMLImageElement\'s view ID.',
          color: Colors.purple.shade50,
          border: Colors.purple,
        ),
        const SizedBox(height: 8),
        _ArchLayerCard(
          number: '3',
          title: 'Platform View Slot',
          description:
              'Flutter Web\'s PlatformViewController injects the HTML node into the '
              'shadow DOM at the correct z-index. The Flutter scene is cut out '
              'around the slot to avoid overdraw.',
          color: Colors.teal.shade50,
          border: Colors.teal,
        ),
        const SizedBox(height: 8),
        _ArchLayerCard(
          number: '4',
          title: 'HTMLImageElement',
          description:
              'A native <img> element whose src, alt, srcset, sizes, loading, '
              'fetchpriority, decoding, and referrerpolicy attributes are set by '
              'RenderWebImage. The browser\'s network stack fetches the image.',
          color: Colors.orange.shade50,
          border: Colors.orange,
        ),
        const SizedBox(height: 8),
        _ArchLayerCard(
          number: '5',
          title: 'Browser Compositor',
          description:
              'The browser decodes the image using its native codec (JPEG, WebP, '
              'AVIF…), GPU-accelerates the composite, handles retina scaling via '
              'devicePixelRatio, and applies CSS filters if set.',
          color: Colors.green.shade50,
          border: Colors.green,
        ),

        const SizedBox(height: 20),

        _SectionHeader('Key Interfaces'),
        const SizedBox(height: 10),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _CodeLine('class WebImage extends LeafRenderObjectWidget'),
              _CodeLine('class RenderWebImage extends RenderBox'),
              _CodeLine('  implements PlatformViewRenderBox'),
              _CodeLine('void paint(PaintingContext context, Offset offset)'),
              _CodeLine('  → context.addLayer(PlatformViewLayer(...))'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  final ColorScheme cs;
  const _ArchitecturePainter({required this.cs});

  @override
  void paint(Canvas canvas, Size size) {
    final boxW = size.width * 0.72;
    final boxH = 52.0;
    final gapY = 16.0;
    final startX = (size.width - boxW) / 2;

    final colors = [
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.teal.shade300,
      Colors.orange.shade300,
      Colors.green.shade300,
    ];

    final labels = [
      'WebImage Widget',
      'RenderWebImage (RenderBox)',
      'Platform View Slot (shadow DOM)',
      'HTMLImageElement (<img>)',
      'Browser Compositor',
    ];

    final subtitles = [
      'createRenderObject()',
      'paint() → PlatformViewLayer',
      'z-index slot injection',
      'src / alt / srcset / loading',
      'decode → GPU composite',
    ];

    final totalH = colors.length * (boxH + gapY) - gapY;
    final startY = (size.height - totalH) / 2;

    final paint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final arrowPaint = Paint()
      ..color = cs.onSurfaceVariant.withAlpha(180)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < colors.length; i++) {
      final y = startY + i * (boxH + gapY);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(startX, y, boxW, boxH),
        const Radius.circular(10),
      );

      paint.color = colors[i].withAlpha(200);
      canvas.drawRRect(rect, paint);

      borderPaint.color = colors[i];
      canvas.drawRRect(rect, borderPaint);

      // Number circle
      paint.color = colors[i];
      canvas.drawCircle(
          Offset(startX + 22, y + boxH / 2), 14, paint);

      final numPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      numPainter.paint(
          canvas,
          Offset(startX + 22 - numPainter.width / 2,
              y + boxH / 2 - numPainter.height / 2));

      // Label
      final labelPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: boxW - 80);
      labelPainter.paint(canvas, Offset(startX + 44, y + 8));

      // Subtitle
      final subPainter = TextPainter(
        text: TextSpan(
          text: subtitles[i],
          style: TextStyle(
            color: cs.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: boxW - 80);
      subPainter.paint(canvas, Offset(startX + 44, y + 28));

      // Arrow down
      if (i < colors.length - 1) {
        final arrowX = startX + boxW / 2;
        final arrowTop = y + boxH;
        final arrowBot = arrowTop + gapY;
        canvas.drawLine(
            Offset(arrowX, arrowTop), Offset(arrowX, arrowBot - 6), arrowPaint);
        final path = Path()
          ..moveTo(arrowX - 6, arrowBot - 8)
          ..lineTo(arrowX, arrowBot)
          ..lineTo(arrowX + 6, arrowBot - 8);
        canvas.drawPath(path, arrowPaint..style = PaintingStyle.stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ArchitecturePainter old) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — HTML img Feature Cards
// ═══════════════════════════════════════════════════════════════════════════

class _Tab3HtmlAttributes extends StatelessWidget {
  const _Tab3HtmlAttributes();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    const attrs = [
      _AttrInfo(
        name: 'src',
        value: 'https://example.com/photo.webp',
        icon: Icons.link,
        color: Color(0xFF1565C0),
        description:
            'The primary URL of the image. RenderWebImage sets this on the '
            'HTMLImageElement immediately. The browser starts a resource fetch '
            'using its network stack, respecting HTTP cache headers.',
        dartProp: 'WebImage(src: "https://example.com/photo.webp")',
      ),
      _AttrInfo(
        name: 'alt',
        value: 'A mountain lake at sunset',
        icon: Icons.accessibility_new,
        color: Color(0xFF6A1B9A),
        description:
            'Descriptive text for the image. Screen readers announce this. '
            'Search engines index it. If the image fails to load, browsers '
            'display the alt text inline. Never use an empty string unless '
            'the image is purely decorative.',
        dartProp: 'WebImage(alt: "A mountain lake at sunset")',
      ),
      _AttrInfo(
        name: 'srcset',
        value: 'img-1x.jpg 1x, img-2x.jpg 2x, img-3x.jpg 3x',
        icon: Icons.photo_size_select_actual,
        color: Color(0xFF00695C),
        description:
            'A comma-separated list of image candidates with descriptors. '
            'The browser picks the most appropriate candidate based on the '
            'device pixel ratio (1x/2x/3x) or viewport width (via sizes). '
            'Retina displays automatically receive higher-resolution sources.',
        dartProp: 'WebImage(srcset: "img-1x.jpg 1x, img-2x.jpg 2x")',
      ),
      _AttrInfo(
        name: 'sizes',
        value: '(max-width: 600px) 100vw, 50vw',
        icon: Icons.devices,
        color: Color(0xFFE65100),
        description:
            'Works alongside srcset. Tells the browser how wide the image '
            'will be rendered at different breakpoints so it can pick the '
            'smallest adequate source before layout is complete.',
        dartProp: 'WebImage(sizes: "(max-width: 600px) 100vw, 50vw")',
      ),
      _AttrInfo(
        name: 'loading',
        value: 'lazy',
        icon: Icons.hourglass_bottom,
        color: Color(0xFF558B2F),
        description:
            'loading="lazy" defers fetching until the image is near the '
            'viewport. loading="eager" fetches immediately. Lazy loading '
            'reduces initial page bandwidth and is especially valuable for '
            'long lists of images.',
        dartProp: 'WebImage(loading: WebImageLoadingMode.lazy)',
      ),
      _AttrInfo(
        name: 'fetchpriority',
        value: 'high',
        icon: Icons.priority_high,
        color: Color(0xFFC62828),
        description:
            'Hints to the browser\'s resource prioritisation engine. "high" '
            'fetches the image before lower-priority resources (useful for '
            'LCP hero images). "low" deprioritises decorative images. "auto" '
            'lets the browser decide.',
        dartProp: 'WebImage(fetchPriority: WebImageFetchPriority.high)',
      ),
      _AttrInfo(
        name: 'referrerpolicy',
        value: 'no-referrer-when-downgrade',
        icon: Icons.policy,
        color: Color(0xFF37474F),
        description:
            'Controls what Referer header is sent when the browser fetches '
            'the image URL. Useful for privacy compliance or to pass '
            'authentication tokens expected by CDN providers.',
        dartProp: 'WebImage(referrerPolicy: "no-referrer-when-downgrade")',
      ),
      _AttrInfo(
        name: 'decoding',
        value: 'async',
        icon: Icons.sync_alt,
        color: Color(0xFF00838F),
        description:
            'decoding="async" allows the browser to decode the image off the '
            'main thread, preventing frame jank. decoding="sync" blocks until '
            'decoding is complete — useful when the image must be visible '
            'immediately after insertion (e.g., above-the-fold hero).',
        dartProp: 'WebImage(decoding: WebImageDecoding.async)',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('HTML <img> Attribute Simulation'),
        const SizedBox(height: 6),
        Text(
          '8 key attributes that RenderWebImage forwards to the underlying '
          'HTMLImageElement. [SIMULATED]',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        ...attrs.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _AttributeCard(info: a),
            )),
      ],
    );
  }
}

class _AttrInfo {
  final String name;
  final String value;
  final IconData icon;
  final Color color;
  final String description;
  final String dartProp;
  const _AttrInfo({
    required this.name,
    required this.value,
    required this.icon,
    required this.color,
    required this.description,
    required this.dartProp,
  });
}

class _AttributeCard extends StatelessWidget {
  final _AttrInfo info;
  const _AttributeCard({required this.info});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: info.color.withAlpha(120)),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: info.color.withAlpha(30),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: info.color.withAlpha(24),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Icon(info.icon, color: info.color, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.name,
                        style: tt.titleSmall?.copyWith(
                          color: info.color,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        info.value,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontFamily: 'monospace',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.description, style: tt.bodySmall),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    info.dartProp,
                    style: tt.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: info.color,
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
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 4 — CanvasKit vs HTML Renderer
// ═══════════════════════════════════════════════════════════════════════════

class _Tab4CanvasKitVsHtml extends StatelessWidget {
  const _Tab4CanvasKitVsHtml();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('CanvasKit vs HTML Renderer [SIMULATED]'),
        const SizedBox(height: 6),
        Text(
          'Side-by-side simulated images and a comparison table.',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        // Side-by-side simulated images
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SimulatedImagePanel(
                label: 'CanvasKit',
                subtitle: 'Decoded by Skia/WASM\npainted on <canvas>',
                color: Colors.purple.shade200,
                icon: Icons.developer_board,
                badge: 'WASM',
                badgeColor: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SimulatedImagePanel(
                label: 'HTML Renderer',
                subtitle: 'Native <img> element\npainted by browser',
                color: Colors.blue.shade200,
                icon: Icons.language,
                badge: 'HTML',
                badgeColor: Colors.blue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        _SectionHeader('Comparison Table'),
        const SizedBox(height: 10),

        _ComparisonTable(
          rows: const [
            _TableRow(
              aspect: 'Decoding',
              canvasKit: 'Skia/WASM (Dart)',
              html: 'Native browser codec',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'CPU/GPU usage',
              canvasKit: 'Higher — WASM decode',
              html: 'Lower — GPU composited',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'Pixel-perfect',
              canvasKit: 'Yes — Skia antialiasing',
              html: 'Browser-dependent',
              winner: 'canvaskit',
            ),
            _TableRow(
              aspect: 'Memory',
              canvasKit: 'Dart heap + GPU texture',
              html: 'Browser managed',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'SEO',
              canvasKit: 'No — inside <canvas>',
              html: 'Yes — real <img> in DOM',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'Accessibility',
              canvasKit: 'Manual (Semantics API)',
              html: 'Native alt / ARIA',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'CSS filters',
              canvasKit: 'Via Dart ColorFilter',
              html: 'Native CSS filter: blur()',
              winner: 'html',
            ),
            _TableRow(
              aspect: 'Shader effects',
              canvasKit: 'Full Skia shaders',
              html: 'Limited to CSS filters',
              winner: 'canvaskit',
            ),
            _TableRow(
              aspect: 'CORS restrictions',
              canvasKit: 'Yes (fetch cross-origin)',
              html: 'Yes (crossorigin attr)',
              winner: 'tie',
            ),
            _TableRow(
              aspect: 'Initial load cost',
              canvasKit: 'Large WASM download',
              html: 'No extra download',
              winner: 'html',
            ),
          ],
        ),
      ],
    );
  }
}

class _SimulatedImagePanel extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String badge;
  final Color badgeColor;

  const _SimulatedImagePanel({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.badge,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(icon, size: 52, color: Colors.white.withAlpha(200)),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: Colors.black38,
                  child: Text(
                    '[SIMULATED]',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(subtitle,
            style: tt.bodySmall, textAlign: TextAlign.center),
      ],
    );
  }
}

class _TableRow {
  final String aspect;
  final String canvasKit;
  final String html;
  final String winner; // 'canvaskit' | 'html' | 'tie'
  const _TableRow({
    required this.aspect,
    required this.canvasKit,
    required this.html,
    required this.winner,
  });
}

class _ComparisonTable extends StatelessWidget {
  final List<_TableRow> rows;
  const _ComparisonTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Aspect',
                        style: tt.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 4,
                    child: Text('CanvasKit',
                        style: tt.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple))),
                Expanded(
                    flex: 4,
                    child: Text('HTML / WebImage',
                        style: tt.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700))),
              ],
            ),
          ),
          ...rows.asMap().entries.map((e) {
            final i = e.key;
            final row = e.value;
            final bg = i.isOdd ? cs.surface : cs.surfaceContainerLowest;
            Color ckColor = cs.onSurface;
            Color htmlColor = cs.onSurface;
            if (row.winner == 'canvaskit') ckColor = Colors.green.shade700;
            if (row.winner == 'html') htmlColor = Colors.green.shade700;

            return Container(
              color: bg,
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(row.aspect,
                          style: tt.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600))),
                  Expanded(
                      flex: 4,
                      child: Text(row.canvasKit,
                          style: tt.bodySmall?.copyWith(color: ckColor))),
                  Expanded(
                      flex: 4,
                      child: Text(row.html,
                          style: tt.bodySmall?.copyWith(color: htmlColor))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 5 — CSS Filter Simulation
// ═══════════════════════════════════════════════════════════════════════════

class _Tab5CssFilters extends StatelessWidget {
  const _Tab5CssFilters();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('CSS Filter Simulation [SIMULATED]'),
        const SizedBox(height: 6),
        Text(
          'Real CSS applies filter: on the <img> element. Here we simulate '
          'equivalent effects using Flutter\'s ColorFiltered and ImageFiltered. '
          'Select a filter to see the simulated result.',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        // Filter picker
        ValueListenableBuilder<String>(
          valueListenable: _activeFilter,
          builder: (context, active, _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'none',
                'blur',
                'sepia',
                'grayscale',
                'invert',
                'brightness',
              ].map((f) {
                return FilterChip(
                  label: Text(f),
                  selected: active == f,
                  onSelected: (_) => _activeFilter.value = f,
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 20),

        // Simulated image with filter
        ValueListenableBuilder<String>(
          valueListenable: _activeFilter,
          builder: (context, active, _) {
            return _FilteredImageCard(filter: active);
          },
        ),

        const SizedBox(height: 20),

        _SectionHeader('CSS Filter Reference'),
        const SizedBox(height: 10),

        _FilterReferenceTable(
          rows: const [
            _FilterRow(
              css: 'filter: blur(4px)',
              flutter: 'ImageFiltered(imageFilter: ImageFilter.blur(...))',
              notes: 'Gaussian blur. Real CSS blurs the <img> via GPU. '
                  'Flutter\'s ImageFiltered wraps any widget subtree.',
            ),
            _FilterRow(
              css: 'filter: sepia(1)',
              flutter: 'ColorFiltered(colorFilter: ColorFilter.matrix([...]))',
              notes: 'Warm brownish tone. Requires a 4×5 sepia color matrix '
                  'in Flutter.',
            ),
            _FilterRow(
              css: 'filter: grayscale(1)',
              flutter: 'ColorFiltered(colorFilter: ColorFilter.matrix([...]))',
              notes: 'Removes colour saturation. CSS shorthand; Flutter needs '
                  'a luminance-preserving matrix.',
            ),
            _FilterRow(
              css: 'filter: invert(1)',
              flutter: 'ColorFiltered(colorFilter: ColorFilter.matrix([...]))',
              notes: 'Inverts each RGB channel. Full invert = complementary '
                  'colours.',
            ),
            _FilterRow(
              css: 'filter: brightness(1.5)',
              flutter: 'ColorFiltered(colorFilter: ColorFilter.matrix([...]))',
              notes: 'Scales RGB values. Values >1 brighten; <1 darken; 0 = '
                  'black.',
            ),
          ],
        ),

        const SizedBox(height: 16),

        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('⚠️ CSS filters on <img> vs Flutter ColorFiltered',
                  style: tt.titleSmall),
              const SizedBox(height: 6),
              Text(
                'When you set filter: on an HTMLImageElement in CSS, the browser '
                'applies it during compositing — zero Dart cost. Flutter\'s '
                'ColorFiltered runs a paint-phase shader on the engine side. '
                'For WebImage on Flutter Web, prefer CSS properties if you need '
                'filters; don\'t apply Flutter ColorFiltered on top of a WebImage '
                'as it may not interact correctly with the platform-view slot.',
                style: tt.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilteredImageCard extends StatelessWidget {
  final String filter;
  const _FilteredImageCard({required this.filter});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    // Base "image" widget — a coloured gradient card
    Widget image = Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF00695C), Color(0xFFE65100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.landscape, size: 60, color: Colors.white),
            const SizedBox(height: 6),
            Text('Mountain Lake [SIMULATED]',
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );

    // Apply simulated filter
    switch (filter) {
      case 'blur':
        image = ImageFiltered(
          imageFilter: _blurFilter(),
          child: image,
        );
      case 'grayscale':
        image = ColorFiltered(
          colorFilter: const ColorFilter.matrix(_grayscaleMatrix),
          child: image,
        );
      case 'sepia':
        image = ColorFiltered(
          colorFilter: const ColorFilter.matrix(_sepiaMatrix),
          child: image,
        );
      case 'invert':
        image = ColorFiltered(
          colorFilter: const ColorFilter.matrix(_invertMatrix),
          child: image,
        );
      case 'brightness':
        image = ColorFiltered(
          colorFilter: const ColorFilter.matrix(_brightnessMatrix),
          child: image,
        );
    }

    final cssLabel = switch (filter) {
      'blur' => 'filter: blur(6px)',
      'grayscale' => 'filter: grayscale(1)',
      'sepia' => 'filter: sepia(1)',
      'invert' => 'filter: invert(1)',
      'brightness' => 'filter: brightness(1.6)',
      _ => 'filter: none',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image,
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'CSS equivalent: $cssLabel',
            style: tt.bodySmall?.copyWith(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}

// Color matrices
const List<double> _grayscaleMatrix = [
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
];

const List<double> _sepiaMatrix = [
  0.393, 0.769, 0.189, 0, 0,
  0.349, 0.686, 0.168, 0, 0,
  0.272, 0.534, 0.131, 0, 0,
  0,     0,     0,     1, 0,
];

const List<double> _invertMatrix = [
  -1, 0,  0,  0, 255,
   0, -1, 0,  0, 255,
   0,  0, -1, 0, 255,
   0,  0,  0, 1, 0,
];

const List<double> _brightnessMatrix = [
  1.6, 0,   0,   0, 0,
  0,   1.6, 0,   0, 0,
  0,   0,   1.6, 0, 0,
  0,   0,   0,   1, 0,
];

ui.ImageFilter _blurFilter() {
  return ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6);
}

class _FilterRow {
  final String css;
  final String flutter;
  final String notes;
  const _FilterRow(
      {required this.css, required this.flutter, required this.notes});
}

class _FilterReferenceTable extends StatelessWidget {
  final List<_FilterRow> rows;
  const _FilterReferenceTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: rows.asMap().entries.map((e) {
        final i = e.key;
        final r = e.value;
        final bg = i.isOdd ? cs.surface : cs.surfaceContainerLowest;
        return Container(
          color: bg,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r.css,
                  style: tt.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(r.flutter,
                  style: tt.bodySmall?.copyWith(
                      fontFamily: 'monospace', color: Colors.purple)),
              const SizedBox(height: 4),
              Text(r.notes, style: tt.bodySmall),
              const Divider(),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 6 — Responsive Images / srcset / DPR
// ═══════════════════════════════════════════════════════════════════════════

class _Tab6SrcsetDpr extends StatelessWidget {
  const _Tab6SrcsetDpr();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final dpr = MediaQuery.of(context).devicePixelRatio;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Responsive Images with srcset [SIMULATED]'),
        const SizedBox(height: 6),
        Text(
          'The browser selects a source from srcset based on devicePixelRatio '
          'and the sizes attribute. Current device DPR: ${dpr.toStringAsFixed(1)}',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        // DPR selector
        _SectionHeader('Simulate different DPRs'),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: _activeSrcsetIndex,
          builder: (context, active, _) {
            return Row(
              children: [1, 2, 3].map((dprVal) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            active == dprVal ? cs.primaryContainer : null,
                      ),
                      onPressed: () => _activeSrcsetIndex.value = dprVal,
                      child: Text('${dprVal}x DPR'),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 16),

        // Visual DPR diagram
        ValueListenableBuilder<int>(
          valueListenable: _activeSrcsetIndex,
          builder: (context, active, _) {
            return _SrcsetDiagram(selectedDpr: active);
          },
        ),

        const SizedBox(height: 20),

        _SectionHeader('srcset Anatomy'),
        const SizedBox(height: 10),

        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CodeLine('<img'),
              const _CodeLine('  src="photo-1x.jpg"'),
              const _CodeLine('  srcset="photo-1x.jpg 1x,'),
              const _CodeLine('          photo-2x.jpg 2x,'),
              const _CodeLine('          photo-3x.jpg 3x"'),
              const _CodeLine('  sizes="(max-width:600px) 100vw, 50vw"'),
              const _CodeLine('  alt="Mountain lake"'),
              const _CodeLine('  loading="lazy"'),
              const _CodeLine('/>'),
              const SizedBox(height: 10),
              Text(
                'The browser parses srcset, evaluates the device DPR (and '
                'optional viewport conditions from sizes), then picks the best '
                'candidate before making a network request. On a 2x retina '
                'display it will fetch photo-2x.jpg — twice the physical pixels '
                'for crisp rendering.',
                style: tt.bodySmall,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        _SectionHeader('Width descriptor (w) vs pixel density (x)'),
        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pixel density (x)',
                        style: tt.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const _CodeLine('srcset="img.jpg 1x,'),
                    const _CodeLine('        img@2x.jpg 2x"'),
                    const SizedBox(height: 6),
                    Text(
                      'Simple. Browser picks based on DPR only. Does not '
                      'consider layout width.',
                      style: tt.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Width descriptor (w)',
                        style: tt.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const _CodeLine('srcset="img-400.jpg 400w,'),
                    const _CodeLine('        img-800.jpg 800w"'),
                    const SizedBox(height: 6),
                    Text(
                      'Advanced. Combined with sizes, browser calculates the '
                      'best source for any DPR × layout width combination.',
                      style: tt.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SrcsetDiagram extends StatelessWidget {
  final int selectedDpr;
  const _SrcsetDiagram({required this.selectedDpr});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final candidates = [
      _SrcsetCandidate(
          dpr: 1,
          src: 'photo-1x.jpg',
          size: '400×300',
          bytes: '42 KB',
          color: Colors.blue.shade100),
      _SrcsetCandidate(
          dpr: 2,
          src: 'photo-2x.jpg',
          size: '800×600',
          bytes: '130 KB',
          color: Colors.blue.shade200),
      _SrcsetCandidate(
          dpr: 3,
          src: 'photo-3x.jpg',
          size: '1200×900',
          bytes: '280 KB',
          color: Colors.blue.shade300),
    ];

    return Column(
      children: [
        // srcset candidates
        Row(
          children: candidates.map((c) {
            final isSelected = c.dpr == selectedDpr;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? cs.primaryContainer : c.color,
                    border: Border.all(
                      color: isSelected ? cs.primary : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text('${c.dpr}x',
                          style: tt.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? cs.primary : cs.onSurface)),
                      const SizedBox(height: 4),
                      Text(c.src,
                          style: tt.labelSmall?.copyWith(
                              fontFamily: 'monospace'),
                          textAlign: TextAlign.center),
                      Text(c.size,
                          style: tt.bodySmall, textAlign: TextAlign.center),
                      Text(c.bytes,
                          style: tt.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant),
                          textAlign: TextAlign.center),
                      if (isSelected) ...[
                        const SizedBox(height: 4),
                        Icon(Icons.check_circle,
                            color: cs.primary, size: 18),
                        Text('Selected',
                            style: tt.labelSmall
                                ?.copyWith(color: cs.primary)),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'At ${selectedDpr}x DPR → browser fetches: '
            '${candidates.firstWhere((c) => c.dpr == selectedDpr).src}',
            style: tt.bodySmall?.copyWith(
                fontFamily: 'monospace', fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _SrcsetCandidate {
  final int dpr;
  final String src;
  final String size;
  final String bytes;
  final Color color;
  const _SrcsetCandidate({
    required this.dpr,
    required this.src,
    required this.size,
    required this.bytes,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 7 — Accessibility
// ═══════════════════════════════════════════════════════════════════════════

class _Tab7Accessibility extends StatelessWidget {
  const _Tab7Accessibility();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final altExamples = [
      'A mountain lake at sunset',
      'Company logo — Acme Corp',
      'Bar chart showing Q1 revenue by region',
      '', // decorative
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Accessibility with RenderWebImage'),
        const SizedBox(height: 6),
        Text(
          'Because WebImage uses a real <img> element, screen readers and '
          'search engines see the image natively — no Semantics API needed.',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        // Alt text demo
        _SectionHeader('Alt Text Examples'),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: _activeAlt,
          builder: (context, alt, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: altExamples.map((a) {
                    return ChoiceChip(
                      label: Text(a.isEmpty ? '[empty — decorative]' : a,
                          style: const TextStyle(fontSize: 11)),
                      selected: _activeAlt.value == a,
                      onSelected: (_) => _activeAlt.value = a,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                _AltTextCard(alt: alt),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        _SectionHeader('ARIA Attributes on <img>'),
        const SizedBox(height: 10),

        _AriaAttributeList(
          items: const [
            _AriaItem(
              attr: 'alt="..."',
              role: 'Primary text alternative',
              notes:
                  'Read by screen readers as the image description. Required '
                  'for informative images. Empty string marks image as decorative.',
            ),
            _AriaItem(
              attr: 'role="img"',
              role: 'Explicit landmark',
              notes:
                  'Redundant on <img> but needed on <div> or <span> used as '
                  'images. WebImage always uses <img> so role is implicit.',
            ),
            _AriaItem(
              attr: 'aria-label="..."',
              role: 'Override label',
              notes:
                  'Overrides alt text for AT. Use when alt must be brief but '
                  'AT needs verbose description.',
            ),
            _AriaItem(
              attr: 'aria-describedby="id"',
              role: 'Link to description',
              notes:
                  'Points to a separate paragraph that gives extended context '
                  'for the image. Useful for complex charts or diagrams.',
            ),
            _AriaItem(
              attr: 'aria-hidden="true"',
              role: 'Hide from AT',
              notes:
                  'Equivalent to alt="". Hides the element from the '
                  'accessibility tree entirely. Use for purely decorative images.',
            ),
          ],
        ),

        const SizedBox(height: 20),

        _SectionHeader('A11y Checklist'),
        const SizedBox(height: 10),
        _InfoCard(
          child: Column(
            children: [
              _CheckRow(
                  label: 'Informative images have descriptive alt text'),
              _CheckRow(
                  label: 'Decorative images use alt="" or aria-hidden'),
              _CheckRow(label: 'Complex images have aria-describedby'),
              _CheckRow(
                  label:
                      'Color is not the only means of conveying information'),
              _CheckRow(
                  label:
                      'Image links: alt text describes the link destination'),
              _CheckRow(
                  label:
                      'srcset doesn\'t affect alt text — use same description'),
            ],
          ),
        ),
      ],
    );
  }
}

class _AltTextCard extends StatelessWidget {
  final String alt;
  const _AltTextCard({required this.alt});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDecorative = alt.isEmpty;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isDecorative ? Colors.orange : cs.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simulated image area
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
              child: Icon(Icons.landscape, size: 48, color: cs.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                        isDecorative
                            ? Icons.visibility_off
                            : Icons.record_voice_over,
                        size: 18,
                        color: isDecorative ? Colors.orange : cs.primary),
                    const SizedBox(width: 6),
                    Text(
                      isDecorative
                          ? 'Decorative — hidden from screen readers'
                          : 'Screen reader announces:',
                      style: tt.labelSmall?.copyWith(
                          color:
                              isDecorative ? Colors.orange : cs.primary),
                    ),
                  ],
                ),
                if (!isDecorative) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: cs.surfaceContainerHighest,
                    child: Text('"$alt"',
                        style: tt.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic)),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  isDecorative
                      ? 'HTML: <img src="..." alt="" />'
                      : 'HTML: <img src="..." alt="$alt" />',
                  style: tt.bodySmall?.copyWith(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AriaItem {
  final String attr;
  final String role;
  final String notes;
  const _AriaItem(
      {required this.attr, required this.role, required this.notes});
}

class _AriaAttributeList extends StatelessWidget {
  final List<_AriaItem> items;
  const _AriaAttributeList({required this.items});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(item.attr,
                        style: tt.labelSmall?.copyWith(
                            fontFamily: 'monospace',
                            color: cs.primary,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),
                  Text(item.role,
                      style: tt.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              Text(item.notes, style: tt.bodySmall),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CheckRow extends StatelessWidget {
  final String label;
  const _CheckRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_box, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(label,
                  style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 8 — Lazy Loading
// ═══════════════════════════════════════════════════════════════════════════

class _Tab8LazyLoading extends StatelessWidget {
  const _Tab8LazyLoading();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Lazy Loading — loading="lazy" [SIMULATED]'),
        const SizedBox(height: 6),
        Text(
          'The browser defers network requests for off-screen images until '
          'they approach the viewport. Tap the button to simulate scroll.',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),

        // Timeline diagram
        _SectionHeader('Loading timeline'),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _LazyLoadTimelinePainter(cs: cs),
            size: Size.infinite,
          ),
        ),

        const SizedBox(height: 20),

        // Lazy simulation toggle
        ValueListenableBuilder<bool>(
          valueListenable: _lazyVisible,
          builder: (context, visible, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader('Viewport simulation'),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Image entered viewport'),
                  subtitle: Text(visible
                      ? 'Browser fetches image now'
                      : 'Browser waits — image outside viewport'),
                  value: visible,
                  onChanged: (v) => _lazyVisible.value = v,
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: visible
                      ? _LazyImageLoaded(key: const ValueKey('loaded'))
                      : _LazyImagePending(key: const ValueKey('pending')),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 24),

        _SectionHeader('loading attribute values'),
        const SizedBox(height: 10),

        _InfoCard(
          child: Column(
            children: [
              _LoadingModeRow(
                mode: 'eager',
                description:
                    'Default. Browser fetches the image immediately regardless '
                    'of scroll position. Use for above-the-fold content.',
                icon: Icons.bolt,
                color: Colors.orange,
              ),
              const Divider(),
              _LoadingModeRow(
                mode: 'lazy',
                description:
                    'Browser defers fetch until image is within its '
                    '"lazy-load distance" (typically 1200–2500 px depending on '
                    'connection speed). Reduces initial page data.',
                icon: Icons.hourglass_bottom,
                color: Colors.green,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _SectionHeader('Impact on Core Web Vitals'),
        const SizedBox(height: 10),

        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletRow(
                  icon: Icons.trending_up,
                  color: Colors.green,
                  text:
                      'LCP (Largest Contentful Paint): Use loading="eager" for '
                      'hero images to avoid delaying the LCP element.'),
              const SizedBox(height: 6),
              _BulletRow(
                  icon: Icons.speed,
                  color: Colors.blue,
                  text:
                      'FID / INP: Lazy loading reduces JS parse time for image '
                      'decoders, improving responsiveness.'),
              const SizedBox(height: 6),
              _BulletRow(
                  icon: Icons.memory,
                  color: Colors.purple,
                  text:
                      'TBT (Total Blocking Time): Deferred images reduce main '
                      'thread decode work during initial load.'),
              const SizedBox(height: 6),
              _BulletRow(
                  icon: Icons.warning_amber,
                  color: Colors.orange,
                  text:
                      'CLS (Cumulative Layout Shift): Always specify width/height '
                      'on <img> — even lazy images shift layout if dimensions '
                      'are unknown.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _LazyLoadTimelinePainter extends CustomPainter {
  final ColorScheme cs;
  const _LazyLoadTimelinePainter({required this.cs});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final textStyle = TextStyle(color: cs.onSurface, fontSize: 11);

    // Timeline axis
    final axisPaint = Paint()
      ..color = cs.outlineVariant
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisY = size.height - 30;
    canvas.drawLine(
        Offset(20, axisY), Offset(size.width - 20, axisY), axisPaint);

    // Events
    final events = [
      _TimelineEvent(
          x: 0.05, label: 'Page load', color: Colors.blue, y: axisY - 80),
      _TimelineEvent(
          x: 0.2, label: 'eager img\nfetched', color: Colors.orange, y: axisY - 60),
      _TimelineEvent(
          x: 0.45, label: 'User\nscrolls', color: Colors.grey, y: axisY - 50),
      _TimelineEvent(
          x: 0.65, label: 'lazy img\nenters viewport', color: Colors.green, y: axisY - 70),
      _TimelineEvent(
          x: 0.8, label: 'lazy img\nfetched', color: Colors.teal, y: axisY - 50),
    ];

    for (final e in events) {
      final x = 20 + (size.width - 40) * e.x;

      // Dot on axis
      paint.color = e.color;
      canvas.drawCircle(Offset(x, axisY), 7, paint);

      // Vertical line
      canvas.drawLine(
        Offset(x, axisY - 6),
        Offset(x, e.y + 22),
        Paint()
          ..color = e.color.withAlpha(160)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );

      // Label
      final tp = TextPainter(
        text: TextSpan(
            text: e.label,
            style: textStyle.copyWith(color: e.color)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 90);
      tp.paint(
          canvas, Offset(x - tp.width / 2, e.y));
    }

    // "Time" label
    final timePainter = TextPainter(
      text: TextSpan(text: 'Time →', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    timePainter.paint(
        canvas, Offset(size.width - timePainter.width - 4, axisY + 8));
  }

  @override
  bool shouldRepaint(covariant _LazyLoadTimelinePainter old) => false;
}

class _TimelineEvent {
  final double x;
  final String label;
  final Color color;
  final double y;
  const _TimelineEvent(
      {required this.x,
      required this.label,
      required this.color,
      required this.y});
}

class _LazyImageLoaded extends StatelessWidget {
  const _LazyImageLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image, size: 40, color: Colors.green.shade700),
            const SizedBox(height: 6),
            Text('Image loaded [SIMULATED]',
                style: TextStyle(color: Colors.green.shade700)),
            Text('loading="lazy" — fetch triggered by viewport entry',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _LazyImagePending extends StatelessWidget {
  const _LazyImagePending({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty, size: 40, color: cs.onSurfaceVariant),
            const SizedBox(height: 6),
            Text('Waiting for viewport [SIMULATED]',
                style: TextStyle(color: cs.onSurfaceVariant)),
            Text('loading="lazy" — network request deferred',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _LoadingModeRow extends StatelessWidget {
  final String mode;
  final String description;
  final IconData icon;
  final Color color;
  const _LoadingModeRow({
    required this.mode,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('loading="$mode"',
                    style: tt.titleSmall?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: color)),
                const SizedBox(height: 4),
                Text(description, style: tt.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 9 — Pitfalls & API Cheat Sheet
// ═══════════════════════════════════════════════════════════════════════════

class _Tab9PitfallsAndApi extends StatelessWidget {
  const _Tab9PitfallsAndApi();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Common Pitfalls'),
        const SizedBox(height: 12),

        // Pitfall 1: non-web assertion
        _PitfallCard(
          number: '1',
          title: 'Web-only assertion on native platforms',
          icon: Icons.phone_iphone,
          color: Colors.red,
          problem:
              'WebImage throws an AssertionError on iOS, Android, macOS, Windows, '
              'and Linux. The assertion fires inside the widget constructor '
              'before any rendering occurs.',
          solution:
              'Wrap usage in a kIsWeb guard:\n'
              'if (kIsWeb) WebImage(src: url)\n'
              'else Image.network(url)',
          codeSnippet:
              "import 'package:flutter/foundation.dart' show kIsWeb;\n"
              'Widget imageFor(String url) =>\n'
              '    kIsWeb ? WebImage(src: url) : Image.network(url);',
        ),
        const SizedBox(height: 12),

        // Pitfall 2: gesture routing
        _PitfallCard(
          number: '2',
          title: 'Gesture routing through native <img>',
          icon: Icons.touch_app,
          color: Colors.orange,
          problem:
              'Platform views sit in a separate DOM layer. Flutter\'s gesture arena '
              'does not receive pointer events that land on the <img> element '
              'directly. GestureDetector wrapping WebImage may silently drop taps.',
          solution:
              'Use PlatformViewSurface\'s gestureRecognizers parameter or handle '
              'events via JS interop on the HTMLImageElement. Alternatively, '
              'overlay a transparent Flutter widget on top.',
          codeSnippet:
              '// Workaround: transparent overlay\n'
              'Stack(\n'
              '  children: [\n'
              '    WebImage(src: url),\n'
              '    Positioned.fill(\n'
              '      child: GestureDetector(onTap: onTap),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        const SizedBox(height: 12),

        // Pitfall 3: CORS
        _PitfallCard(
          number: '3',
          title: 'CORS restrictions',
          icon: Icons.security,
          color: Colors.purple,
          problem:
              'If the image server does not include CORS headers '
              '(Access-Control-Allow-Origin), and you set crossorigin="anonymous" '
              'on the <img>, the browser blocks the load. Without crossorigin, '
              'the image loads but cannot be drawn to a <canvas> later.',
          solution:
              'Ensure the image CDN sends:\n'
              'Access-Control-Allow-Origin: *\n'
              'Or proxy images through your own server. Do not add crossorigin '
              'unless you specifically need canvas access.',
          codeSnippet:
              '// WebImage CORS attribute (when needed)\n'
              'WebImage(\n'
              '  src: url,\n'
              '  // crossOrigin: "anonymous",  // enable only if needed\n'
              ');',
        ),
        const SizedBox(height: 12),

        // Pitfall 4: CSP
        _PitfallCard(
          number: '4',
          title: 'Content Security Policy (CSP)',
          icon: Icons.policy,
          color: Colors.teal,
          problem:
              'A strict Content-Security-Policy may block cross-origin image '
              'sources. This manifests as a blank image without any Dart '
              'exception — the browser silently drops the request.',
          solution:
              'Add the image domain to the img-src directive in your CSP header:\n'
              'Content-Security-Policy: img-src \'self\' https://cdn.example.com;',
          codeSnippet:
              '<!-- index.html -->\n'
              '<meta http-equiv="Content-Security-Policy"\n'
              '  content="img-src \'self\' https://cdn.example.com">\n',
        ),

        const SizedBox(height: 24),

        _SectionHeader('CORS Simulation'),
        const SizedBox(height: 10),
        ValueListenableBuilder<bool>(
          valueListenable: _corsError,
          builder: (context, hasError, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: const Text('Simulate CORS error'),
                  subtitle: const Text('Toggle missing Access-Control-Allow-Origin header'),
                  value: hasError,
                  onChanged: (v) => _corsError.value = v,
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: hasError
                      ? _CorsErrorWidget(key: const ValueKey('err'))
                      : _CorsOkWidget(key: const ValueKey('ok')),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 24),

        _SectionHeader('WebImage API Cheat Sheet'),
        const SizedBox(height: 10),

        _ApiCheatSheet(
          rows: const [
            _ApiRow(
                prop: 'src',
                type: 'String',
                notes: 'Required. The image URL.'),
            _ApiRow(
                prop: 'alt',
                type: 'String',
                notes:
                    'Alt text for accessibility. Empty string for decorative.'),
            _ApiRow(
                prop: 'width',
                type: 'double?',
                notes: 'Intrinsic width hint.'),
            _ApiRow(
                prop: 'height',
                type: 'double?',
                notes: 'Intrinsic height hint. Set both to prevent CLS.'),
            _ApiRow(
                prop: 'fit',
                type: 'BoxFit?',
                notes:
                    'Mapped to CSS object-fit on the <img> element.'),
            _ApiRow(
                prop: 'alignment',
                type: 'Alignment',
                notes: 'Mapped to CSS object-position.'),
            _ApiRow(
                prop: 'srcset',
                type: 'String?',
                notes: 'Responsive image sources, e.g. "img-2x.jpg 2x".'),
            _ApiRow(
                prop: 'sizes',
                type: 'String?',
                notes:
                    'Media conditions for srcset width selection.'),
            _ApiRow(
                prop: 'loading',
                type: 'WebImageLoadingMode',
                notes: 'eager (default) or lazy.'),
            _ApiRow(
                prop: 'decoding',
                type: 'WebImageDecoding',
                notes: 'sync, async, or auto.'),
            _ApiRow(
                prop: 'fetchPriority',
                type: 'WebImageFetchPriority',
                notes: 'high, low, or auto.'),
            _ApiRow(
                prop: 'referrerPolicy',
                type: 'String?',
                notes: 'Referrer header policy string.'),
          ],
        ),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;
  final Color color;
  final String problem;
  final String solution;
  final String codeSnippet;

  const _PitfallCard({
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
    required this.problem,
    required this.solution,
    required this.codeSnippet,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(100)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  radius: 14,
                  child: Text(number,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: tt.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Problem',
                    style: tt.labelSmall?.copyWith(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(problem, style: tt.bodySmall),
                const SizedBox(height: 10),
                Text('Solution',
                    style: tt.labelSmall?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(solution, style: tt.bodySmall),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(codeSnippet,
                      style: tt.bodySmall
                          ?.copyWith(fontFamily: 'monospace')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CorsErrorWidget extends StatelessWidget {
  const _CorsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image, color: Colors.red, size: 30),
            const SizedBox(height: 4),
            Text('[SIMULATED] CORS error — image blocked',
                style: TextStyle(color: Colors.red.shade700, fontSize: 12)),
            Text(
                'Missing Access-Control-Allow-Origin header',
                style: TextStyle(color: Colors.red.shade400, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _CorsOkWidget extends StatelessWidget {
  const _CorsOkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image, color: Colors.green, size: 30),
            const SizedBox(height: 4),
            Text('[SIMULATED] Image loaded successfully',
                style: TextStyle(color: Colors.green.shade700, fontSize: 12)),
            Text('CORS headers present — browser allowed load',
                style: TextStyle(color: Colors.green.shade400, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _ApiRow {
  final String prop;
  final String type;
  final String notes;
  const _ApiRow(
      {required this.prop, required this.type, required this.notes});
}

class _ApiCheatSheet extends StatelessWidget {
  final List<_ApiRow> rows;
  const _ApiCheatSheet({required this.rows});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Property',
                        style: tt.labelSmall
                            ?.copyWith(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Type',
                        style: tt.labelSmall
                            ?.copyWith(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 5,
                    child: Text('Notes',
                        style: tt.labelSmall
                            ?.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ...rows.asMap().entries.map((e) {
            final i = e.key;
            final row = e.value;
            final bg = i.isOdd ? cs.surface : cs.surfaceContainerLowest;
            return Container(
              color: bg,
              padding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(row.prop,
                          style: tt.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: cs.primary,
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 3,
                      child: Text(row.type,
                          style: tt.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: Colors.purple))),
                  Expanded(
                      flex: 5,
                      child: Text(row.notes, style: tt.bodySmall)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared helper widgets
// ═══════════════════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;
  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _CompactCompareRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  const _CompactCompareRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }
}

class _CompactCompareCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final List<String> points;

  const _CompactCompareCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 6),
          Text(label, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...points.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 11)),
                    Expanded(child: Text(p, style: tt.bodySmall)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _BulletRow(
      {required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
            child:
                Text(text, style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;
  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _ArchLayerCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final Color color;
  final Color border;

  const _ArchLayerCard({
    required this.number,
    required this.title,
    required this.description,
    required this.color,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: border.withAlpha(80)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: border,
            radius: 13,
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: tt.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description, style: tt.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
