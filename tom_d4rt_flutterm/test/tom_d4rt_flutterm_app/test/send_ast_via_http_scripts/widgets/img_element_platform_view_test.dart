// Deep visual demo: ImgElementPlatformView — a Flutter-for-Web widget that
// embeds a browser-native HTML `<img>` element directly into the widget tree
// as a platform view. This demo is intentionally an architectural /
// educational *simulation* because the real widget:
//
//   * throws on non-web targets (no <img> element, no DOM),
//   * is implemented with `ui_web.platformViewRegistry.registerViewFactory`
//     which is unavailable under the tom_d4rt_flutterm harness,
//   * depends on `package:web/web.dart` bindings that only resolve when
//     the engine is compiled for a browser.
//
// We therefore visualise the concept with pure Flutter widgets: mock
// "image frames", explanatory diagrams, architecture CustomPainters, and
// attribute chips that mirror real HTML `<img>` features (loading, srcset,
// sizes, decoding, referrerpolicy, crossorigin, …).
//
// The demo is deliberately stateless. All interactive surfaces are driven
// by top-level ValueNotifiers + ValueListenableBuilder so the top-level
// widget tree can remain a StatelessWidget.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers. The demo is stateless, so any interactive
// surfaces reach their state through these shared notifiers plus
// ValueListenableBuilder widgets.
// ---------------------------------------------------------------------------

/// Drives the CSS filter preview selector (section 5).
/// Stored as the enum index to keep the notifier type public.
final ValueNotifier<int> kFilterChoice = ValueNotifier<int>(0);

/// Drives the srcset DPR selector (section 3).
final ValueNotifier<int> kSrcsetDpr = ValueNotifier<int>(2);

/// Drives the responsive grid viewport selector (section 8).
/// Stored as the enum index to keep the notifier type public.
final ValueNotifier<int> kViewport = ValueNotifier<int>(2);

/// Drives the architecture diagram focus ring (section 2).
final ValueNotifier<int> kArchFocus = ValueNotifier<int>(-1);

/// Drives the pipeline comparison highlight (section 6).
/// Stored as the enum index to keep the notifier type public.
final ValueNotifier<int> kPipeline = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Shared constants and data.
// ---------------------------------------------------------------------------

const Color _seedColor = Color(0xFF4C6EF5);

const double _sectionSpacing = 32.0;

const List<_HtmlFeature> _htmlFeatures = <_HtmlFeature>[
  _HtmlFeature(
    label: 'loading="lazy"',
    icon: Icons.hourglass_bottom,
    hue: Color(0xFF1565C0),
    summary: 'Defers fetch until the image approaches the viewport.',
    attrKey: 'loading',
    attrValue: 'lazy',
    bulletPoints: <String>[
      'Native browser scheduler — no JS observer needed.',
      'Great for long-form pages and product grids.',
      'Falls back to eager when unsupported.',
    ],
  ),
  _HtmlFeature(
    label: 'srcset="1x 2x 3x"',
    icon: Icons.high_quality,
    hue: Color(0xFF2E7D32),
    summary: 'Browser picks the best candidate for the current DPR.',
    attrKey: 'srcset',
    attrValue: 'hero.png 1x, hero@2x.png 2x, hero@3x.png 3x',
    bulletPoints: <String>[
      'Automatic on Retina / HiDPI screens.',
      'Pairs with the `sizes` attribute for width hints.',
      'Avoids shipping 4x assets to 1x devices.',
    ],
  ),
  _HtmlFeature(
    label: 'sizes="(max-w…) …"',
    icon: Icons.straighten,
    hue: Color(0xFFEF6C00),
    summary: 'Declares rendered width so the UA can pre-pick a candidate.',
    attrKey: 'sizes',
    attrValue: '(max-width: 600px) 100vw, 50vw',
    bulletPoints: <String>[
      'Used before layout completes — hint, not measurement.',
      'Works alongside `srcset` width descriptors.',
      'Critical for LCP on responsive layouts.',
    ],
  ),
  _HtmlFeature(
    label: 'referrerpolicy',
    icon: Icons.privacy_tip,
    hue: Color(0xFF6A1B9A),
    summary: 'Controls the Referer header sent with the image request.',
    attrKey: 'referrerpolicy',
    attrValue: 'no-referrer-when-downgrade',
    bulletPoints: <String>[
      'Defends against leaking private URLs to CDNs.',
      'Common values: no-referrer, origin, same-origin.',
      'Enforced by the browser — not by Flutter.',
    ],
  ),
  _HtmlFeature(
    label: 'crossorigin',
    icon: Icons.swap_horiz,
    hue: Color(0xFFC62828),
    summary: 'Opts the fetch into CORS so canvas reads / WebGL are legal.',
    attrKey: 'crossorigin',
    attrValue: 'anonymous',
    bulletPoints: <String>[
      'Required to read pixels back via toDataURL().',
      'Requires the server to return Access-Control-Allow-Origin.',
      'Without it, canvases become "tainted".',
    ],
  ),
  _HtmlFeature(
    label: 'decoding="async"',
    icon: Icons.bolt,
    hue: Color(0xFF00838F),
    summary: 'Lets the browser decode off the main thread when possible.',
    attrKey: 'decoding',
    attrValue: 'async',
    bulletPoints: <String>[
      'Reduces jank on hero banners.',
      'Pairs well with `loading="lazy"`.',
      'Values: sync, async, auto.',
    ],
  ),
];

const List<_Benefit> _benefits = <_Benefit>[
  _Benefit(
    icon: Icons.search,
    label: 'SEO',
    description:
        'Crawlers index a real <img> with src/alt attributes, which is not '
        'possible for images rendered to a CanvasKit <canvas>.',
    wins: <String>[
      'Alt text becomes part of the DOM.',
      'Image search can preview the asset.',
      'Structured data (OpenGraph) works naturally.',
    ],
  ),
  _Benefit(
    icon: Icons.accessibility_new,
    label: 'Accessibility',
    description:
        'Screen readers hit the exact same element you would get in any '
        'plain HTML page — roles, landmarks and focus all work.',
    wins: <String>[
      'NVDA / VoiceOver read alt text verbatim.',
      'Context menu still exposes "Open image in new tab".',
      'High-contrast forced colors mode applies.',
    ],
  ),
  _Benefit(
    icon: Icons.download,
    label: 'User control',
    description:
        'Right-click, long-press and "Save image" all keep working — users '
        'interact with a real image node instead of a canvas blob.',
    wins: <String>[
      'Preserves drag-and-drop to Finder / Explorer.',
      'Keeps keyboard shortcuts for image copy.',
      'Translation tools can overlay captions.',
    ],
  ),
  _Benefit(
    icon: Icons.image,
    label: 'Decoding',
    description:
        'The browser uses its battle-hardened native decoder, which is '
        'faster and better supported than any userland decoder.',
    wins: <String>[
      'Hardware-accelerated JPEG / WebP / AVIF.',
      'Benefits from browser-level caching policies.',
      'Respects Content-DPR / DPR client hints.',
    ],
  ),
  _Benefit(
    icon: Icons.shield_moon,
    label: 'Security',
    description:
        'CSP rules for img-src still apply, and the Referrer-Policy flows '
        'naturally through the element.',
    wins: <String>[
      'No blob: URL leak from re-hosting.',
      'Mixed-content blocking works untouched.',
      'CORS governs canvas tainting, not Flutter.',
    ],
  ),
  _Benefit(
    icon: Icons.auto_awesome,
    label: 'Browser perks',
    description:
        'Every browser-native feature — lazy loading, content-visibility, '
        'priority hints — is available without a plugin.',
    wins: <String>[
      'fetchpriority="high" works out of the box.',
      'Paint-holding / fade-in may apply.',
      'Media-queries on srcset scale automatically.',
    ],
  ),
];

const List<_PipelineRow> _pipelineRows = <_PipelineRow>[
  _PipelineRow(
    topic: 'Decoder',
    html: 'Browser-native (libjpeg-turbo, libwebp, libavif…).',
    canvasKit: 'Skia-bundled decoders inside the WASM bundle.',
  ),
  _PipelineRow(
    topic: 'Threading',
    html: 'Main thread + browser helper threads.',
    canvasKit: 'Dart isolate + WebGL worker pipeline.',
  ),
  _PipelineRow(
    topic: 'Cache',
    html: 'Browser HTTP cache + disk cache reused across tabs.',
    canvasKit: 'Per-app ImageCache driven by ImageProvider keys.',
  ),
  _PipelineRow(
    topic: 'Memory',
    html: 'Lives in native GPU memory via the compositor.',
    canvasKit: 'Uploaded as GPU textures by Skia from WASM heap.',
  ),
  _PipelineRow(
    topic: 'A11y tree',
    html: 'Part of the document — screen readers see it.',
    canvasKit: 'Exposed through synthetic SemanticsNodes only.',
  ),
  _PipelineRow(
    topic: 'Animation',
    html: 'CSS transitions / filters free.',
    canvasKit: 'Flutter animations with Skia paint.',
  ),
];

const List<_Pitfall> _pitfalls = <_Pitfall>[
  _Pitfall(
    icon: Icons.public_off,
    title: 'Web only',
    body:
        'On mobile, desktop or tests the widget throws. Any shared codebase '
        'must guard with `kIsWeb` before constructing it.',
  ),
  _Pitfall(
    icon: Icons.gesture,
    title: 'Pointer routing',
    body:
        'Pointer events flow through the DOM first. Flutter gesture '
        'recognizers only see gestures that bubble past the <img>.',
  ),
  _Pitfall(
    icon: Icons.touch_app,
    title: 'Touch quirks',
    body:
        'iOS long-press can trigger "Add to Photos" unless the element '
        'disables the callout via -webkit-touch-callout: none.',
  ),
];

const List<_CheatRow> _cheatRows = <_CheatRow>[
  _CheatRow(
    name: 'ImgElementPlatformView',
    kind: 'Widget (web-only)',
    notes: 'Thin wrapper that creates a HtmlElementView bound to a factory.',
  ),
  _CheatRow(
    name: 'HtmlElementView',
    kind: 'Widget',
    notes: 'Public API for embedding any HTMLElement as a platform view.',
  ),
  _CheatRow(
    name: 'ui_web.platformViewRegistry',
    kind: 'Static registry',
    notes: 'registerViewFactory(viewType, factory) — factory returns Element.',
  ),
  _CheatRow(
    name: 'package:web <img>',
    kind: 'HTMLImageElement',
    notes: 'Has .src, .alt, .srcset, .sizes, .loading, .decoding, ….',
  ),
  _CheatRow(
    name: 'kIsWeb',
    kind: 'foundation.dart',
    notes: 'Compile-time constant; always guard ImgElementPlatformView use.',
  ),
  _CheatRow(
    name: 'DefaultAssetBundle',
    kind: 'Widget',
    notes: 'Not used — <img> fetches directly from the network.',
  ),
  _CheatRow(
    name: 'Image.network',
    kind: 'Alternative',
    notes: 'CanvasKit path — decodes in Skia instead of the browser.',
  ),
  _CheatRow(
    name: 'Image.asset',
    kind: 'Alternative',
    notes: 'Reads from flutter_assets — needs extra work on web.',
  ),
];

const List<_CssFilterSpec> _cssFilters = <_CssFilterSpec>[
  _CssFilterSpec(_CssFilter.none, 'none', 'No CSS filter applied'),
  _CssFilterSpec(_CssFilter.blur, 'blur(4px)', 'Gaussian blur ~4 pixels'),
  _CssFilterSpec(_CssFilter.sepia, 'sepia(0.8)', 'Warm sepia-tone treatment'),
  _CssFilterSpec(_CssFilter.grayscale, 'grayscale(1)', 'Full desaturation'),
  _CssFilterSpec(_CssFilter.invert, 'invert(1)', 'Color inversion'),
  _CssFilterSpec(_CssFilter.brightness, 'brightness(1.3)', 'Boosts luminance'),
];

const List<_ResponsiveSample> _responsiveSamples = <_ResponsiveSample>[
  _ResponsiveSample('orchard.jpg', Color(0xFF8D6E63), Icons.eco),
  _ResponsiveSample('ocean.jpg', Color(0xFF0277BD), Icons.waves),
  _ResponsiveSample('ridgeline.jpg', Color(0xFF2E7D32), Icons.terrain),
  _ResponsiveSample('dunes.jpg', Color(0xFFF9A825), Icons.filter_hdr),
  _ResponsiveSample('lantern.jpg', Color(0xFFC62828), Icons.lightbulb),
  _ResponsiveSample('lagoon.jpg', Color(0xFF00838F), Icons.pool),
  _ResponsiveSample('glade.jpg', Color(0xFF558B2F), Icons.park),
  _ResponsiveSample('observatory.jpg', Color(0xFF4527A0), Icons.stars),
  _ResponsiveSample('harbour.jpg', Color(0xFF3E2723), Icons.directions_boat),
];

const List<_ViewportSpec> _viewportSpecs = <_ViewportSpec>[
  _ViewportSpec(_ViewportPreset.phone, 'Phone', 360.0, 1, '100vw'),
  _ViewportSpec(_ViewportPreset.tablet, 'Tablet', 720.0, 2, '50vw'),
  _ViewportSpec(_ViewportPreset.desktop, 'Desktop', 1280.0, 3, '33vw'),
  _ViewportSpec(_ViewportPreset.cinema, '4K', 2560.0, 4, '25vw'),
];

// ---------------------------------------------------------------------------
// Enums used by shared notifiers.
// ---------------------------------------------------------------------------

enum _CssFilter { none, blur, sepia, grayscale, invert, brightness }

enum _ViewportPreset { phone, tablet, desktop, cinema }

enum _Pipeline { htmlRenderer, canvasKit }

// ---------------------------------------------------------------------------
// Data classes (plain, const constructible).
// ---------------------------------------------------------------------------

class _HtmlFeature {
  final String label;
  final IconData icon;
  final Color hue;
  final String summary;
  final String attrKey;
  final String attrValue;
  final List<String> bulletPoints;
  const _HtmlFeature({
    required this.label,
    required this.icon,
    required this.hue,
    required this.summary,
    required this.attrKey,
    required this.attrValue,
    required this.bulletPoints,
  });
}

class _Benefit {
  final IconData icon;
  final String label;
  final String description;
  final List<String> wins;
  const _Benefit({
    required this.icon,
    required this.label,
    required this.description,
    required this.wins,
  });
}

class _PipelineRow {
  final String topic;
  final String html;
  final String canvasKit;
  const _PipelineRow({
    required this.topic,
    required this.html,
    required this.canvasKit,
  });
}

class _Pitfall {
  final IconData icon;
  final String title;
  final String body;
  const _Pitfall({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class _CheatRow {
  final String name;
  final String kind;
  final String notes;
  const _CheatRow({
    required this.name,
    required this.kind,
    required this.notes,
  });
}

class _CssFilterSpec {
  final _CssFilter filter;
  final String css;
  final String description;
  const _CssFilterSpec(this.filter, this.css, this.description);
}

class _ResponsiveSample {
  final String filename;
  final Color color;
  final IconData icon;
  const _ResponsiveSample(this.filename, this.color, this.icon);
}

class _ViewportSpec {
  final _ViewportPreset preset;
  final String label;
  final double width;
  final int dpr;
  final String sizesHint;
  const _ViewportSpec(
    this.preset,
    this.label,
    this.width,
    this.dpr,
    this.sizesHint,
  );
}

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ImgElementPlatformView — Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    ),
    home: const _DemoHome(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with 9 tabs.
// ---------------------------------------------------------------------------

class _DemoHome extends StatelessWidget {
  const _DemoHome();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ImgElementPlatformView'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(text: '1. Hero'),
              Tab(text: '2. Architecture'),
              Tab(text: '3. HTML features'),
              Tab(text: '4. SEO & a11y'),
              Tab(text: '5. CSS filters'),
              Tab(text: '6. HTML vs CanvasKit'),
              Tab(text: '7. Factory snippet'),
              Tab(text: '8. Responsive grid'),
              Tab(text: '9. Pitfalls & API'),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: <Widget>[
              _HeroTab(),
              _ArchitectureTab(),
              _FeaturesTab(),
              _SeoA11yTab(),
              _CssFiltersTab(),
              _PipelineTab(),
              _FactoryTab(),
              _ResponsiveTab(),
              _PitfallsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — hero banner.
// ---------------------------------------------------------------------------

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _HeroBanner(scheme: scheme),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'What is ImgElementPlatformView?',
            subtitle: 'A Flutter-for-Web only widget.',
            icon: Icons.image_outlined,
          ),
          const SizedBox(height: 16),
          const _ConceptParagraphs(),
          const SizedBox(height: _sectionSpacing),
          _HeroCalloutRow(scheme: scheme),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Why embed a native <img> element?',
            subtitle:
                'Some browser features are simply not reachable through '
                'the Dart UI stack.',
            icon: Icons.integration_instructions,
          ),
          const SizedBox(height: 16),
          const _WhyEmbedTiles(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Simulation disclaimer',
            subtitle:
                'The harness cannot run real platform views — everything '
                'below is an educational re-creation.',
            icon: Icons.science,
          ),
          const SizedBox(height: 16),
          _SimulationDisclaimer(scheme: scheme),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final ColorScheme scheme;
  const _HeroBanner({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 20, color: Colors.black26, offset: Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.language, color: Colors.white, size: 42),
                const SizedBox(width: 12),
                Text(
                  'Flutter Web — Platform View',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                        letterSpacing: 1.6,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'ImgElementPlatformView',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Embed a browser-native <img> element into the Flutter widget '
              'tree for SEO, accessibility, lazy loading, responsive srcset '
              'and CSS filters — without giving up the rest of Flutter.',
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const <Widget>[
                _HeroChip(icon: Icons.web, label: 'Web only'),
                _HeroChip(icon: Icons.accessibility, label: 'Accessible'),
                _HeroChip(icon: Icons.bolt, label: 'Native decoding'),
                _HeroChip(icon: Icons.photo_size_select_large, label: 'srcset'),
                _HeroChip(icon: Icons.hourglass_bottom, label: 'lazy loading'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConceptParagraphs extends StatelessWidget {
  const _ConceptParagraphs();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Platform views on Flutter Web let you punch a hole through '
              'the Flutter canvas and show a real HTML element instead. '
              'This is the mechanism behind HtmlElementView, and '
              'ImgElementPlatformView is a thin wrapper that registers an '
              'HTMLImageElement factory and returns a HtmlElementView for '
              'it.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              'Unlike Image.network — which hands the bytes to CanvasKit / '
              'Skia and paints into the canvas — this widget asks the '
              'browser itself to fetch, decode, and composite the bitmap. '
              'Everything the browser normally does for <img> (lazy '
              'loading, responsive srcset, SEO indexing, assistive '
              'technology) continues to work.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              'The tradeoff: it only exists on the web. On mobile or '
              'desktop there is no DOM, so constructing it throws. Any '
              'real app must branch on kIsWeb before reaching for it.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCalloutRow extends StatelessWidget {
  final ColorScheme scheme;
  const _HeroCalloutRow({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth > 720;
        final List<Widget> cells = <Widget>[
          _HeroCalloutCard(
            icon: Icons.layers,
            title: 'Platform view',
            body:
                'A trap-door in the Flutter canvas that hosts a native DOM '
                'element (or an iframe, canvas, video, …).',
            color: scheme.primaryContainer,
            textColor: scheme.onPrimaryContainer,
          ),
          _HeroCalloutCard(
            icon: Icons.image,
            title: '<img> element',
            body:
                'The browser-native image tag. Understands src, srcset, '
                'sizes, loading, decoding, referrerpolicy, crossorigin.',
            color: scheme.secondaryContainer,
            textColor: scheme.onSecondaryContainer,
          ),
          _HeroCalloutCard(
            icon: Icons.extension,
            title: 'HtmlElementView',
            body:
                'The public Flutter-for-Web bridge that turns a registered '
                'factory ID into a placed Widget.',
            color: scheme.tertiaryContainer,
            textColor: scheme.onTertiaryContainer,
          ),
        ];
        if (wide) {
          // IntrinsicHeight bounds the Row's vertical extent so that
          // CrossAxisAlignment.stretch does not propagate the unbounded
          // height inherited from the SingleChildScrollView ancestor.
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: cells[0]),
                const SizedBox(width: 12),
                Expanded(child: cells[1]),
                const SizedBox(width: 12),
                Expanded(child: cells[2]),
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            cells[0],
            const SizedBox(height: 12),
            cells[1],
            const SizedBox(height: 12),
            cells[2],
          ],
        );
      },
    );
  }
}

class _HeroCalloutCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final Color textColor;
  const _HeroCalloutCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: textColor, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: TextStyle(color: textColor, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhyEmbedTiles extends StatelessWidget {
  const _WhyEmbedTiles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _WhyEmbedTile(
          icon: Icons.language,
          title: 'Native browser features',
          body:
              'Lazy loading, content-visibility, responsive srcset, fetch '
              'priority hints — all come for free with a real <img>.',
        ),
        SizedBox(height: 10),
        _WhyEmbedTile(
          icon: Icons.visibility,
          title: 'Discoverability',
          body:
              'Search crawlers and image indexers prefer real elements. '
              'They can read alt text, captions, and schema.org metadata.',
        ),
        SizedBox(height: 10),
        _WhyEmbedTile(
          icon: Icons.accessibility_new,
          title: 'Assistive technology',
          body:
              'Screen readers expose <img> with its alt attribute. '
              'Canvas-rendered images must emulate this via Semantics.',
        ),
        SizedBox(height: 10),
        _WhyEmbedTile(
          icon: Icons.mouse,
          title: 'User affordances',
          body:
              'Right-click, drag-and-drop, and "Copy image" remain usable — '
              'they are implemented by the browser, not by the framework.',
        ),
      ],
    );
  }
}

class _WhyEmbedTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _WhyEmbedTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimulationDisclaimer extends StatelessWidget {
  final ColorScheme scheme;
  const _SimulationDisclaimer({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.info_outline, color: scheme.primary),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'ImgElementPlatformView needs a browser DOM. This demo runs '
                'under the tom_d4rt_flutterm harness, which has no DOM, so '
                'every <img> shown below is simulated with Flutter-only '
                'widgets (Container, CustomPaint, ColorFiltered). The '
                'attribute chips, factory snippet, and architecture diagram '
                'show the real shape of the API.',
                style: TextStyle(height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — architecture diagram.
// ---------------------------------------------------------------------------

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'Rendering pipeline',
            subtitle:
                'How a call to ImgElementPlatformView(src: "...") becomes '
                'pixels on screen.',
            icon: Icons.architecture,
          ),
          const SizedBox(height: 16),
          const _ArchitectureDiagram(),
          const SizedBox(height: 20),
          const _ArchitectureLegend(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Request → decode → composite',
            subtitle:
                'Each hop is the browser’s responsibility — Flutter just '
                'declares what element should exist and where.',
            icon: Icons.route,
          ),
          const SizedBox(height: 16),
          const _PipelineSteps(),
        ],
      ),
    );
  }
}

class _ArchitectureDiagram extends StatelessWidget {
  const _ArchitectureDiagram();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kArchFocus,
      builder: (BuildContext context, int focus, Widget? _) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomPaint(
                painter: _ArchDiagramPainter(
                  focus: focus,
                  primary: Theme.of(context).colorScheme.primary,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ArchDiagramPainter extends CustomPainter {
  final int focus;
  final Color primary;
  final Color onSurface;
  _ArchDiagramPainter({
    required this.focus,
    required this.primary,
    required this.onSurface,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double nodeW = size.width / 6.0;
    final double nodeH = size.height * 0.22;
    final double cy = size.height / 2.0;
    final List<String> labels = <String>[
      'Flutter tree',
      'ImgElement\nPlatformView',
      'HtmlElement\nView',
      'HTMLDivElement\n(host)',
      'HTMLImageElement',
      'Browser renderer',
    ];
    final List<Rect> boxes = <Rect>[];
    for (int i = 0; i < labels.length; i++) {
      final double cx = nodeW / 2 + i * (nodeW + 6);
      boxes.add(Rect.fromCenter(
        center: Offset(cx, cy),
        width: nodeW,
        height: nodeH,
      ));
    }
    // Arrows behind boxes.
    final Paint arrow = Paint()
      ..color = onSurface.withValues(alpha: 0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < boxes.length - 1; i++) {
      final Offset a = boxes[i].centerRight;
      final Offset b = boxes[i + 1].centerLeft;
      canvas.drawLine(a, b, arrow);
      final Path head = Path()
        ..moveTo(b.dx, b.dy)
        ..lineTo(b.dx - 8, b.dy - 5)
        ..lineTo(b.dx - 8, b.dy + 5)
        ..close();
      canvas.drawPath(head, Paint()..color = onSurface.withValues(alpha: 0.6));
    }
    // Boxes.
    for (int i = 0; i < boxes.length; i++) {
      final bool isFocused = i == focus;
      final Paint fill = Paint()
        ..color =
            isFocused ? primary.withValues(alpha: 0.18) : Colors.transparent;
      final Paint stroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isFocused ? 2.4 : 1.3
        ..color = isFocused ? primary : onSurface.withValues(alpha: 0.7);
      final RRect r = RRect.fromRectAndRadius(boxes[i], const Radius.circular(8));
      canvas.drawRRect(r, fill);
      canvas.drawRRect(r, stroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: onSurface,
            fontSize: 11.0,
            height: 1.25,
            fontWeight: isFocused ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 3,
      )..layout(maxWidth: nodeW - 8);
      tp.paint(
        canvas,
        Offset(
          boxes[i].center.dx - tp.width / 2,
          boxes[i].center.dy - tp.height / 2,
        ),
      );
    }
    // Top / bottom captions.
    _drawCaption(canvas, 'Dart side', Offset(size.width * 0.18, 16), primary);
    _drawCaption(
      canvas,
      'Browser side',
      Offset(size.width * 0.72, 16),
      primary,
    );
    _drawCaption(
      canvas,
      'Flutter declares the element; the browser owns fetching, decoding '
      'and compositing.',
      Offset(size.width / 2 - 180, size.height - 18),
      onSurface.withValues(alpha: 0.6),
    );
  }

  void _drawCaption(Canvas canvas, String text, Offset at, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 360);
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _ArchDiagramPainter oldDelegate) {
    return oldDelegate.focus != focus ||
        oldDelegate.primary != primary ||
        oldDelegate.onSurface != onSurface;
  }
}

class _ArchitectureLegend extends StatelessWidget {
  const _ArchitectureLegend();

  @override
  Widget build(BuildContext context) {
    const List<String> legend = <String>[
      'Flutter tree — the ordinary Widget graph in your app.',
      'ImgElementPlatformView — Flutter wrapper, only exists for web.',
      'HtmlElementView — public API that places a platform view.',
      'HTMLDivElement — wrapper div the factory hands back.',
      'HTMLImageElement — the real <img> the browser renders.',
      'Browser renderer — compositor & GPU drawing the page.',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (int i = 0; i < legend.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () {
              kArchFocus.value = kArchFocus.value == i ? -1 : i;
            },
            child: ValueListenableBuilder<int>(
              valueListenable: kArchFocus,
              builder: (BuildContext context, int f, Widget? _) {
                final bool sel = f == i;
                final ColorScheme scheme = Theme.of(context).colorScheme;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: sel ? scheme.primaryContainer : scheme.surface,
                    border: Border.all(
                      color: sel ? scheme.primary : scheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: sel
                            ? scheme.primary
                            : scheme.surfaceContainerHighest,
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: sel ? scheme.onPrimary : scheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 260,
                        child: Text(
                          legend[i],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _PipelineSteps extends StatelessWidget {
  const _PipelineSteps();

  @override
  Widget build(BuildContext context) {
    const List<_PipelineStep> steps = <_PipelineStep>[
      _PipelineStep(
        stage: 'Build',
        side: 'Dart',
        body: 'ImgElementPlatformView creates a HtmlElementView('
            'viewType: "img-" + src).',
      ),
      _PipelineStep(
        stage: 'Register',
        side: 'Dart',
        body:
            'On first use, a factory is registered that returns a fresh '
            'HTMLImageElement wrapped in a host div.',
      ),
      _PipelineStep(
        stage: 'Insert',
        side: 'Bridge',
        body:
            'Flutter’s compositor reserves a rectangle in the layer tree and '
            'the host div is parented under the Flutter canvas.',
      ),
      _PipelineStep(
        stage: 'Fetch',
        side: 'Browser',
        body:
            'The browser issues an HTTP GET for src, honouring cache '
            'headers, referrerpolicy, and CORS.',
      ),
      _PipelineStep(
        stage: 'Decode',
        side: 'Browser',
        body:
            'Pixels are decoded natively — usually off the main thread when '
            'decoding="async" is set.',
      ),
      _PipelineStep(
        stage: 'Composite',
        side: 'Browser',
        body:
            'The compositor uploads the decoded bitmap to the GPU and blends '
            'it with the Flutter surface.',
      ),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _PipelineStepRow(step: steps[i], index: i + 1),
          ),
      ],
    );
  }
}

class _PipelineStep {
  final String stage;
  final String side;
  final String body;
  const _PipelineStep({
    required this.stage,
    required this.side,
    required this.body,
  });
}

class _PipelineStepRow extends StatelessWidget {
  final _PipelineStep step;
  final int index;
  const _PipelineStepRow({required this.step, required this.index});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    Color sideColor;
    switch (step.side) {
      case 'Dart':
        sideColor = scheme.primary;
        break;
      case 'Bridge':
        sideColor = scheme.tertiary;
        break;
      default:
        sideColor = scheme.secondary;
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: sideColor,
              foregroundColor: Colors.white,
              child: Text('$index'),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        step.stage,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: sideColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          step.side,
                          style: TextStyle(
                            fontSize: 11,
                            color: sideColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(step.body, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — HTML <img> features gallery.
// ---------------------------------------------------------------------------

class _FeaturesTab extends StatelessWidget {
  const _FeaturesTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'HTML <img> feature gallery',
            subtitle:
                'Six features the browser gives you for free once the '
                'element is real.',
            icon: Icons.grid_view,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int cols = constraints.maxWidth > 960
                  ? 3
                  : constraints.maxWidth > 640
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _htmlFeatures.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _FeatureCard(feature: _htmlFeatures[index]);
                },
              );
            },
          ),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Device-pixel-ratio srcset resolver',
            subtitle:
                'Pick a DPR and see which candidate the browser would fetch.',
            icon: Icons.tune,
          ),
          const SizedBox(height: 16),
          const _SrcsetResolver(),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final _HtmlFeature feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SyntheticImageFrame(color: feature.hue, icon: feature.icon),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(feature.icon, color: feature.hue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature.label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              feature.summary,
              style: const TextStyle(fontSize: 12.5, height: 1.35),
            ),
            const SizedBox(height: 10),
            _AttributeChip(
              attrKey: feature.attrKey,
              attrValue: feature.attrValue,
              color: feature.hue,
            ),
            const SizedBox(height: 10),
            for (final String bullet in feature.bulletPoints)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('• '),
                    Expanded(
                      child: Text(
                        bullet,
                        style: const TextStyle(fontSize: 12),
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
}

class _SyntheticImageFrame extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _SyntheticImageFrame({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              color.withValues(alpha: 0.92),
              color.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(painter: _ImageGlyphPainter(icon: icon)),
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '<img>',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageGlyphPainter extends CustomPainter {
  final IconData icon;
  _ImageGlyphPainter({required this.icon});

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: size.shortestSide * 0.5,
          color: Colors.white.withValues(alpha: 0.75),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) / 2,
        (size.height - tp.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _ImageGlyphPainter oldDelegate) {
    return oldDelegate.icon != icon;
  }
}

class _AttributeChip extends StatelessWidget {
  final String attrKey;
  final String attrValue;
  final Color color;
  const _AttributeChip({
    required this.attrKey,
    required this.attrValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            attrKey,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const Text(
            '=',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          Flexible(
            child: Text(
              '"$attrValue"',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SrcsetResolver extends StatelessWidget {
  const _SrcsetResolver();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'srcset="hero.png 1x, hero@2x.png 2x, hero@3x.png 3x"',
              style: TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder<int>(
              valueListenable: kSrcsetDpr,
              builder: (BuildContext context, int dpr, Widget? _) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Device pixel ratio'),
                        Text(
                          '${dpr}x',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: dpr.toDouble(),
                      min: 1,
                      max: 4,
                      divisions: 3,
                      label: '${dpr}x',
                      onChanged: (double v) {
                        kSrcsetDpr.value = v.round();
                      },
                    ),
                    _CandidateRow(dpr: dpr),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CandidateRow extends StatelessWidget {
  final int dpr;
  const _CandidateRow({required this.dpr});

  @override
  Widget build(BuildContext context) {
    const List<String> candidates = <String>[
      'hero.png (1x)',
      'hero@2x.png (2x)',
      'hero@3x.png (3x)',
      'hero@3x.png (3x, clamped)',
    ];
    final int chosen = dpr.clamp(1, 4) - 1;
    return Column(
      children: <Widget>[
        for (int i = 0; i < candidates.length; i++)
          Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: i == chosen
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: i == chosen
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 1.2,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  i == chosen ? Icons.check_circle : Icons.circle_outlined,
                  size: 16,
                  color: i == chosen
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 8),
                Text(
                  candidates[i],
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — SEO + a11y benefits.
// ---------------------------------------------------------------------------

class _SeoA11yTab extends StatelessWidget {
  const _SeoA11yTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'SEO & accessibility benefits',
            subtitle:
                'What ImgElementPlatformView unlocks that CanvasKit Image '
                'cannot match.',
            icon: Icons.emoji_objects,
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < _benefits.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _BenefitTile(benefit: _benefits[i]),
            ),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Comparison with Image.network',
            subtitle:
                'Side-by-side of the same scene expressed two different ways.',
            icon: Icons.compare_arrows,
          ),
          const SizedBox(height: 16),
          const _SeoComparison(),
        ],
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  final _Benefit benefit;
  const _BenefitTile({required this.benefit});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: scheme.primaryContainer,
              foregroundColor: scheme.onPrimaryContainer,
              child: Icon(benefit.icon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    benefit.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(benefit.description, style: const TextStyle(height: 1.4)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      for (final String win in benefit.wins)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            win,
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSecondaryContainer,
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
}

class _SeoComparison extends StatelessWidget {
  const _SeoComparison();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth > 780;
        final List<Widget> sides = <Widget>[
          const _SeoComparisonCard(
            title: 'ImgElementPlatformView',
            subtitle: 'HTML renderer',
            positives: <String>[
              'alt="Mountain dawn" is indexable.',
              'Crawler can follow src directly.',
              'Screen readers read alt verbatim.',
              'Right-click → Save image works.',
              'Works with open-graph meta.',
            ],
            negatives: <String>[
              'Web only — will throw elsewhere.',
              'Pointer events are routed through DOM.',
            ],
            tint: Color(0xFFE8F5E9),
          ),
          const _SeoComparisonCard(
            title: 'Image.network',
            subtitle: 'CanvasKit (or HTML) renderer',
            positives: <String>[
              'Works on every platform.',
              'Unified API across targets.',
              'Shader masks / blend modes easy.',
            ],
            negatives: <String>[
              'Bitmap lives inside <canvas>.',
              'Alt text must be synthesised.',
              'No native lazy-load.',
              'Copy / save does not work for users.',
            ],
            tint: Color(0xFFFFF3E0),
          ),
        ];
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: sides[0]),
              const SizedBox(width: 12),
              Expanded(child: sides[1]),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            sides[0],
            const SizedBox(height: 12),
            sides[1],
          ],
        );
      },
    );
  }
}

class _SeoComparisonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> positives;
  final List<String> negatives;
  final Color tint;
  const _SeoComparisonCard({
    required this.title,
    required this.subtitle,
    required this.positives,
    required this.negatives,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tint,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            const Text(
              'Pros',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            for (final String line in positives)
              _ProConLine(icon: Icons.check, color: Colors.green, text: line),
            const SizedBox(height: 8),
            const Text(
              'Watch-outs',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.deepOrange,
              ),
            ),
            for (final String line in negatives)
              _ProConLine(
                icon: Icons.warning_amber,
                color: Colors.deepOrange,
                text: line,
              ),
          ],
        ),
      ),
    );
  }
}

class _ProConLine extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _ProConLine({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — CSS filter simulation.
// ---------------------------------------------------------------------------

class _CssFiltersTab extends StatelessWidget {
  const _CssFiltersTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'CSS filter simulation',
            subtitle:
                'In the real browser, CSS filter chains apply to <img> for '
                'free. Here we fake them with Flutter-only primitives.',
            icon: Icons.filter,
          ),
          const SizedBox(height: 16),
          const _FilterSelector(),
          const SizedBox(height: 20),
          const _FilterPreview(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Filter catalogue',
            subtitle:
                'Each CSS filter primitive, alongside the Flutter widget '
                'you would use to approximate it inside a canvas image.',
            icon: Icons.menu_book,
          ),
          const SizedBox(height: 16),
          const _FilterCatalogue(),
        ],
      ),
    );
  }
}

class _FilterSelector extends StatelessWidget {
  const _FilterSelector();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kFilterChoice,
      builder: (BuildContext context, int currentIndex, Widget? _) {
        final _CssFilter current = _CssFilter.values[currentIndex];
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (int i = 0; i < _cssFilters.length; i++)
              ChoiceChip(
                label: Text(_cssFilters[i].css),
                selected: _cssFilters[i].filter == current,
                onSelected: (bool _) {
                  kFilterChoice.value = _cssFilters[i].filter.index;
                },
              ),
          ],
        );
      },
    );
  }
}

class _FilterPreview extends StatelessWidget {
  const _FilterPreview();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kFilterChoice,
      builder: (BuildContext context, int currentIndex, Widget? _) {
        final _CssFilter current = _CssFilter.values[currentIndex];
        final _CssFilterSpec spec = _cssFilters.firstWhere(
          (_CssFilterSpec s) => s.filter == current,
        );
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _FilterAttributeBar(spec: spec),
                const SizedBox(height: 14),
                Center(child: _FilteredFrame(current: current)),
                const SizedBox(height: 14),
                Text(
                  spec.description,
                  style: const TextStyle(height: 1.4),
                ),
                const SizedBox(height: 8),
                const Text(
                  'In a real <img>, applying CSS filter is as simple as '
                  'setting style="filter: ...". Flutter has no filter '
                  'attribute on <img>, so we approximate the effect with '
                  'ColorFiltered / ImageFiltered wrappers.',
                  style: TextStyle(
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterAttributeBar extends StatelessWidget {
  final _CssFilterSpec spec;
  const _FilterAttributeBar({required this.spec});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.filter_b_and_w, color: scheme.primary),
          const SizedBox(width: 8),
          const Text(
            'style="filter: ',
            style: TextStyle(fontFamily: 'monospace'),
          ),
          Flexible(
            child: Text(
              spec.css,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ),
          const Text('"', style: TextStyle(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _FilteredFrame extends StatelessWidget {
  final _CssFilter current;
  const _FilteredFrame({required this.current});

  @override
  Widget build(BuildContext context) {
    Widget frame = const _SyntheticImageFrame(
      color: Color(0xFF455A64),
      icon: Icons.photo_camera_back,
    );
    switch (current) {
      case _CssFilter.none:
        break;
      case _CssFilter.blur:
        frame = ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: frame,
        );
        break;
      case _CssFilter.sepia:
        frame = ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.393, 0.769, 0.189, 0, 0,
            0.349, 0.686, 0.168, 0, 0,
            0.272, 0.534, 0.131, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: frame,
        );
        break;
      case _CssFilter.grayscale:
        frame = ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: frame,
        );
        break;
      case _CssFilter.invert:
        frame = ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            -1, 0, 0, 0, 255,
            0, -1, 0, 0, 255,
            0, 0, -1, 0, 255,
            0, 0, 0, 1, 0,
          ]),
          child: frame,
        );
        break;
      case _CssFilter.brightness:
        frame = ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            1.3, 0, 0, 0, 0,
            0, 1.3, 0, 0, 0,
            0, 0, 1.3, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: frame,
        );
        break;
    }
    return SizedBox(width: 320, child: frame);
  }
}

class _FilterCatalogue extends StatelessWidget {
  const _FilterCatalogue();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['blur(px)', 'ImageFiltered + ImageFilter.blur'],
      <String>['sepia(amount)', 'ColorFiltered + ColorFilter.matrix'],
      <String>['grayscale(amount)', 'ColorFiltered + luminance matrix'],
      <String>['invert(amount)', 'ColorFiltered + negate matrix'],
      <String>['brightness(n)', 'ColorFiltered + scale matrix'],
      <String>['contrast(n)', 'ColorFiltered + translate matrix'],
      <String>['hue-rotate(deg)', 'ColorFiltered + rotation matrix'],
      <String>['drop-shadow(...)', 'DecoratedBox + BoxShadow'],
    ];
    return Card(
      child: Column(
        children: <Widget>[
          const _CatalogueHeader(),
          for (int i = 0; i < rows.length; i++)
            _CatalogueRow(
              css: rows[i][0],
              flutter: rows[i][1],
              alternate: i.isOdd,
            ),
        ],
      ),
    );
  }
}

class _CatalogueHeader extends StatelessWidget {
  const _CatalogueHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            child: Text(
              'CSS filter',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              'Flutter equivalent',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogueRow extends StatelessWidget {
  final String css;
  final String flutter;
  final bool alternate;
  const _CatalogueRow({
    required this.css,
    required this.flutter,
    required this.alternate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: alternate
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              css,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          Expanded(
            child: Text(
              flutter,
              style: const TextStyle(height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — pipeline vs CanvasKit.
// ---------------------------------------------------------------------------

class _PipelineTab extends StatelessWidget {
  const _PipelineTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'HTML renderer vs CanvasKit',
            subtitle:
                'Flutter Web has two backends; ImgElementPlatformView is '
                'meaningful in both but behaves differently.',
            icon: Icons.view_in_ar,
          ),
          const SizedBox(height: 16),
          const _PipelineSwitcher(),
          const SizedBox(height: 16),
          const _PipelineDiagram(),
          const SizedBox(height: 20),
          const _PipelineTable(),
        ],
      ),
    );
  }
}

class _PipelineSwitcher extends StatelessWidget {
  const _PipelineSwitcher();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kPipeline,
      builder: (BuildContext context, int idx, Widget? _) {
        final _Pipeline current = _Pipeline.values[idx];
        return SegmentedButton<_Pipeline>(
          segments: const <ButtonSegment<_Pipeline>>[
            ButtonSegment<_Pipeline>(
              value: _Pipeline.htmlRenderer,
              label: Text('HTML renderer'),
              icon: Icon(Icons.html),
            ),
            ButtonSegment<_Pipeline>(
              value: _Pipeline.canvasKit,
              label: Text('CanvasKit'),
              icon: Icon(Icons.widgets),
            ),
          ],
          selected: <_Pipeline>{current},
          onSelectionChanged: (Set<_Pipeline> s) {
            kPipeline.value = s.first.index;
          },
        );
      },
    );
  }
}

class _PipelineDiagram extends StatelessWidget {
  const _PipelineDiagram();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kPipeline,
      builder: (BuildContext context, int idx, Widget? _) {
        final _Pipeline pipeline = _Pipeline.values[idx];
        return AspectRatio(
          aspectRatio: 16 / 7,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomPaint(
                painter: _PipelinePainter(
                  pipeline: pipeline,
                  primary: Theme.of(context).colorScheme.primary,
                  secondary: Theme.of(context).colorScheme.secondary,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PipelinePainter extends CustomPainter {
  final _Pipeline pipeline;
  final Color primary;
  final Color secondary;
  final Color onSurface;
  _PipelinePainter({
    required this.pipeline,
    required this.primary,
    required this.secondary,
    required this.onSurface,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<String> stages = pipeline == _Pipeline.htmlRenderer
        ? <String>[
            'HTTP fetch',
            'Browser decode',
            'Compositor upload',
            'GPU draw',
          ]
        : <String>[
            'HTTP fetch',
            'Skia decode',
            'Dart texture upload',
            'WebGL draw',
          ];
    final Color fill =
        (pipeline == _Pipeline.htmlRenderer ? primary : secondary);
    final double nodeH = size.height * 0.3;
    final double nodeW = (size.width - 20 * (stages.length - 1)) / stages.length;
    final double y = size.height / 2 - nodeH / 2;
    final List<Rect> rects = <Rect>[];
    for (int i = 0; i < stages.length; i++) {
      final double x = i * (nodeW + 20);
      rects.add(Rect.fromLTWH(x, y, nodeW, nodeH));
    }
    // Arrows.
    final Paint arrow = Paint()
      ..color = onSurface.withValues(alpha: 0.5)
      ..strokeWidth = 2;
    for (int i = 0; i < rects.length - 1; i++) {
      final Offset a = rects[i].centerRight;
      final Offset b = rects[i + 1].centerLeft;
      canvas.drawLine(a, b, arrow);
      final Path head = Path()
        ..moveTo(b.dx, b.dy)
        ..lineTo(b.dx - 8, b.dy - 5)
        ..lineTo(b.dx - 8, b.dy + 5)
        ..close();
      canvas.drawPath(
        head,
        Paint()..color = onSurface.withValues(alpha: 0.5),
      );
    }
    for (int i = 0; i < rects.length; i++) {
      final RRect rr =
          RRect.fromRectAndRadius(rects[i], const Radius.circular(10));
      canvas.drawRRect(
        rr,
        Paint()..color = fill.withValues(alpha: 0.22),
      );
      canvas.drawRRect(
        rr,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..color = fill,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: stages[i],
          style: TextStyle(
            fontSize: 12,
            color: onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
      )..layout(maxWidth: nodeW - 8);
      tp.paint(
        canvas,
        Offset(
          rects[i].center.dx - tp.width / 2,
          rects[i].center.dy - tp.height / 2,
        ),
      );
    }
    // Title.
    final TextPainter title = TextPainter(
      text: TextSpan(
        text: pipeline == _Pipeline.htmlRenderer
            ? 'Browser <img> pipeline'
            : 'CanvasKit pipeline',
        style: TextStyle(
          color: fill,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    title.paint(canvas, const Offset(4, 4));
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) {
    return oldDelegate.pipeline != pipeline ||
        oldDelegate.primary != primary ||
        oldDelegate.secondary != secondary ||
        oldDelegate.onSurface != onSurface;
  }
}

class _PipelineTable extends StatelessWidget {
  const _PipelineTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 120,
                  child: Text(
                    'Topic',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    'HTML renderer',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    'CanvasKit',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < _pipelineRows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: i.isOdd
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Text(
                      _pipelineRows[i].topic,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _pipelineRows[i].html,
                      style: const TextStyle(height: 1.35),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _pipelineRows[i].canvasKit,
                      style: const TextStyle(height: 1.35),
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

// ---------------------------------------------------------------------------
// Section 7 — factory registration snippet.
// ---------------------------------------------------------------------------

class _FactoryTab extends StatelessWidget {
  const _FactoryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'Factory registration',
            subtitle:
                'How the widget wires up an HTMLImageElement behind the '
                'scenes. Code is stylised monospace, not executed here.',
            icon: Icons.code,
          ),
          const SizedBox(height: 16),
          const _CodeBlock(
            title: 'web side — register the factory',
            language: 'dart',
            lines: <String>[
              "import 'dart:ui_web' as ui_web;",
              "import 'package:web/web.dart' as web;",
              '',
              'void registerImgFactory(String viewType, String src) {',
              '  ui_web.platformViewRegistry.registerViewFactory(',
              '    viewType,',
              '    (int id) {',
              '      final web.HTMLImageElement img =',
              "          web.HTMLImageElement()",
              "            ..src = src",
              "            ..alt = 'Web-decoded image'",
              "            ..loading = 'lazy'",
              "            ..decoding = 'async'",
              "            ..srcset = '\$src 1x, \${src}@2x 2x, \${src}@3x 3x'",
              "            ..sizes = '(max-width: 600px) 100vw, 50vw'",
              "            ..crossOrigin = 'anonymous'",
              "            ..referrerPolicy = 'no-referrer-when-downgrade'",
              "            ..style.width = '100%'",
              "            ..style.height = '100%'",
              "            ..style.display = 'block';",
              '      return img;',
              '    },',
              '  );',
              '}',
            ],
          ),
          const SizedBox(height: 20),
          const _CodeBlock(
            title: 'Dart side — construct the widget',
            language: 'dart',
            lines: <String>[
              'class ImgElementPlatformView extends StatelessWidget {',
              '  final String src;',
              '  const ImgElementPlatformView({super.key, required this.src});',
              '',
              '  @override',
              '  Widget build(BuildContext context) {',
              "    final String viewType = 'img-\$src';",
              '    registerImgFactory(viewType, src);',
              '    return HtmlElementView(viewType: viewType);',
              '  }',
              '}',
            ],
          ),
          const SizedBox(height: 20),
          const _CodeBlock(
            title: 'call-site — guard with kIsWeb',
            language: 'dart',
            lines: <String>[
              "import 'package:flutter/foundation.dart';",
              '',
              'Widget productHero(String src) {',
              '  if (kIsWeb) {',
              '    return ImgElementPlatformView(src: src);',
              '  }',
              '  return Image.network(src);',
              '}',
            ],
          ),
          const SizedBox(height: 20),
          const _CodeBlock(
            title: 'tip — deduplicating view types',
            language: 'dart',
            lines: <String>[
              'final Set<String> _registered = <String>{};',
              '',
              'void registerImgFactoryOnce(String viewType, String src) {',
              '  if (_registered.add(viewType)) {',
              '    registerImgFactory(viewType, src);',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String title;
  final String language;
  final List<String> lines;
  const _CodeBlock({
    required this.title,
    required this.language,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code, color: scheme.onSecondaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    language,
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onTertiaryContainer,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: scheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < lines.length; i++)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${i + 1}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: scheme.outline,
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          lines[i].isEmpty ? ' ' : lines[i],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.5,
                            height: 1.45,
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
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — responsive image grid.
// ---------------------------------------------------------------------------

class _ResponsiveTab extends StatelessWidget {
  const _ResponsiveTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'Responsive srcset / sizes',
            subtitle:
                'Flip between viewport presets to see how the browser would '
                'pick the srcset candidate and size the container.',
            icon: Icons.devices,
          ),
          const SizedBox(height: 16),
          const _ViewportSelector(),
          const SizedBox(height: 16),
          const _ViewportSummary(),
          const SizedBox(height: 20),
          const _ResponsiveGallery(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Media-query reference',
            subtitle: 'Common sizes hints you will see in the wild.',
            icon: Icons.bookmark_added,
          ),
          const SizedBox(height: 16),
          const _SizesReferenceTable(),
        ],
      ),
    );
  }
}

class _ViewportSelector extends StatelessWidget {
  const _ViewportSelector();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kViewport,
      builder: (BuildContext context, int idx, Widget? _) {
        final _ViewportPreset current = _ViewportPreset.values[idx];
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final _ViewportSpec spec in _viewportSpecs)
              ChoiceChip(
                label: Text('${spec.label} (${spec.width.toInt()}px)'),
                selected: spec.preset == current,
                onSelected: (bool _) {
                  kViewport.value = spec.preset.index;
                },
              ),
          ],
        );
      },
    );
  }
}

class _ViewportSummary extends StatelessWidget {
  const _ViewportSummary();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kViewport,
      builder: (BuildContext context, int idx, Widget? _) {
        final _ViewportPreset current = _ViewportPreset.values[idx];
        final _ViewportSpec spec =
            _viewportSpecs.firstWhere((_ViewportSpec s) => s.preset == current);
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.devices_other,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Viewport: ${spec.label} — ${spec.width.toInt()}px',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Selected DPR: ${spec.dpr}x   /   '
                        'sizes="${spec.sizesHint}"',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ResponsiveGallery extends StatelessWidget {
  const _ResponsiveGallery();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kViewport,
      builder: (BuildContext context, int idx, Widget? _) {
        final _ViewportPreset current = _ViewportPreset.values[idx];
        final _ViewportSpec spec =
            _viewportSpecs.firstWhere((_ViewportSpec s) => s.preset == current);
        int cols;
        switch (spec.preset) {
          case _ViewportPreset.phone:
            cols = 1;
            break;
          case _ViewportPreset.tablet:
            cols = 2;
            break;
          case _ViewportPreset.desktop:
            cols = 3;
            break;
          case _ViewportPreset.cinema:
            cols = 4;
            break;
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _responsiveSamples.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _ResponsiveCard(
              sample: _responsiveSamples[index],
              dpr: spec.dpr,
            );
          },
        );
      },
    );
  }
}

class _ResponsiveCard extends StatelessWidget {
  final _ResponsiveSample sample;
  final int dpr;
  const _ResponsiveCard({required this.sample, required this.dpr});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _SyntheticImageFrame(
                color: sample.color,
                icon: sample.icon,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sample.filename,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'requested @ ${dpr}x',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizesReferenceTable extends StatelessWidget {
  const _SizesReferenceTable();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['100vw', 'Full-bleed hero banner on every device.'],
      <String>['50vw', 'Two-column layout above the tablet breakpoint.'],
      <String>[
        '(max-width: 600px) 100vw, 50vw',
        'Stacks to full width on phones, halves on tablet+.'
      ],
      <String>[
        '(max-width: 600px) 100vw, (max-width: 1200px) 50vw, 33vw',
        'Phone, tablet, desktop three-step ramp.'
      ],
      <String>[
        '(min-resolution: 2dppx) 75vw, 50vw',
        'High-DPI devices get a bigger candidate.'
      ],
      <String>[
        '25vw',
        'Dense 4-column thumbnail grid on desktop.'
      ],
    ];
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 260,
                  child: Text(
                    'sizes=',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Typical use case',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: i.isOdd
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 260,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(height: 1.4),
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

// ---------------------------------------------------------------------------
// Section 9 — pitfalls + API cheat sheet.
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'Pitfalls',
            subtitle: 'Three big gotchas to keep on your radar.',
            icon: Icons.warning_amber_outlined,
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < _pitfalls.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PitfallTile(pitfall: _pitfalls[i]),
            ),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'API cheat sheet',
            subtitle:
                'Quick lookup of the moving parts involved when using '
                'ImgElementPlatformView.',
            icon: Icons.receipt_long,
          ),
          const SizedBox(height: 16),
          const _CheatSheet(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Behaviour notes',
            subtitle: 'Edge cases and subtleties worth memorising.',
            icon: Icons.notes,
          ),
          const SizedBox(height: 16),
          const _BehaviourNotes(),
          const SizedBox(height: _sectionSpacing),
          _SectionHeader(
            title: 'Further reading',
            subtitle: 'Relevant specs and docs.',
            icon: Icons.menu_book,
          ),
          const SizedBox(height: 16),
          const _FurtherReading(),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  final _Pitfall pitfall;
  const _PitfallTile({required this.pitfall});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: scheme.errorContainer,
              foregroundColor: scheme.onErrorContainer,
              child: Icon(pitfall.icon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pitfall.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(pitfall.body, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheatSheet extends StatelessWidget {
  const _CheatSheet();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 220,
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    'Kind',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Notes',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < _cheatRows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: i.isOdd
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 220,
                    child: Text(
                      _cheatRows[i].name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                      _cheatRows[i].kind,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _cheatRows[i].notes,
                      style: const TextStyle(height: 1.4),
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

class _BehaviourNotes extends StatelessWidget {
  const _BehaviourNotes();

  @override
  Widget build(BuildContext context) {
    const List<String> notes = <String>[
      'The widget does not repaint Flutter content over the <img>; the img '
          'itself is the pixel source for the rectangle it occupies.',
      'Semantics must be merged manually via Semantics(label: alt) when '
          'other widgets overlay the image.',
      'Do not reuse the same viewType for distinct images — cache by src.',
      'Hot reload reuses the registered factory; setting .src at runtime is '
          'cheap.',
      'If src is a blob URL, revoke it when the widget disposes to avoid '
          'leaks.',
      'The element participates in the browser HTTP cache — no extra work '
          'needed for repeat visits.',
      'onError in DOM corresponds to an ImageChunkEvent equivalent — you '
          'must subscribe manually if needed.',
      'CSS filters applied to the element persist across Flutter repaints.',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final String note in notes)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        note,
                        style: const TextStyle(height: 1.45),
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
}

class _FurtherReading extends StatelessWidget {
  const _FurtherReading();

  @override
  Widget build(BuildContext context) {
    const List<_Reading> items = <_Reading>[
      _Reading(
        title: 'HTML Living Standard — <img>',
        body:
            'Defines srcset, sizes, loading, decoding, referrerpolicy and '
            'crossorigin semantics.',
      ),
      _Reading(
        title: 'Flutter Web — HtmlElementView',
        body:
            'Official API for embedding HTML elements in the widget tree. '
            'ImgElementPlatformView is a thin wrapper on top.',
      ),
      _Reading(
        title: 'dart:ui_web platformViewRegistry',
        body:
            'Runtime registry that maps a viewType string to a factory '
            'returning an Element.',
      ),
      _Reading(
        title: 'Responsive Images Community Group',
        body: 'Picture element, srcset, art direction — historical context.',
      ),
      _Reading(
        title: 'W3C WAI alt text guidance',
        body: 'Canonical rules for writing alt text for non-decorative images.',
      ),
      _Reading(
        title: 'web.dev — Fast load times',
        body:
            'Benchmarks for native decoding vs userland decoders, plus tips '
            'on fetchpriority.',
      ),
    ];
    return Column(
      children: <Widget>[
        for (final _Reading item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.menu_book_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(item.body, style: const TextStyle(height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Reading {
  final String title;
  final String body;
  const _Reading({required this.title, required this.body});
}

// ---------------------------------------------------------------------------
// Shared section header widget.
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          radius: 22,
          child: Icon(icon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
