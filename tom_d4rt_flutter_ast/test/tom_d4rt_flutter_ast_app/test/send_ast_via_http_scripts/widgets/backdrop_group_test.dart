// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// =============================================================================
//                       BackdropGroup Deep Demo
// =============================================================================
//
// BackdropGroup is the Flutter mechanism for sharing a single backdrop sample
// across multiple BackdropFilter widgets. Without grouping, every
// BackdropFilter creates its own offscreen sample of the parent, which is
// expensive (each one triggers a saveLayer round-trip on the GPU). With a
// BackdropGroup wrapping multiple BackdropFilter.grouped widgets, the engine
// can sample the parent once and reuse it for every grouped filter inside the
// group.
//
// Visual behavior is largely identical (each filter still applies its own
// ImageFilter); the win is performance. This demo walks through:
//
//   1.  Intro and ASCII diagram of the optimization
//   2.  Glassmorphism gallery: 6-card grouped wall over a colorful gradient
//   3.  Live BackdropGroup wrapping multiple BackdropFilter.grouped filters
//   4.  Animated blur intensity (sigma driven by AnimationController)
//   5.  Layered blur stack (3 filters with different sigmas composing)
//   6.  Comparison: grouped vs ungrouped (visually similar, perf differs)
//   7.  iOS-style notification banner (frosted glass over gradient)
//   8.  Floating action sheet with frosted-glass over chart-like background
//   9.  Row of 3 filters with different ImageFilter types: blur, dilate, erode
//   10. Pitfalls (5 cards)
//   11. Recipe gallery (4 cards: modal sheet, navbar, search overlay, alert)
//   12. Reference table (BackdropFilter, BackdropGroup, ImageFilter.*, etc.)
//
// All sections are real widgets you can inspect via the snapshot harness.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== BackdropGroup Deep Demo (Harness-Safe) ===');
  print('Renders ~12 sections demonstrating grouped vs ungrouped backdrop'
      ' filters, glassmorphism, animated blur, and recipe galleries.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BackdropGroup Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('BackdropGroup Deep Demo'),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionHeader(
                index: 1,
                title: 'Why BackdropGroup Exists',
                subtitle:
                    'Each BackdropFilter samples the parent independently;'
                    ' BackdropGroup lets siblings share a single sample.',
              ),
              const _IntroExplanation(),
              const SizedBox(height: 8),
              const _IntroDiagram(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 2,
                title: 'Visual Gallery: 6-Card Glassmorphism Wall',
                subtitle:
                    '6 frosted cards floating over a colorful gradient,'
                    ' grouped via BackdropGroup so all filters share one sample.',
              ),
              const _GlassmorphismWall(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 3,
                title: 'Live BackdropGroup Wrapping Multiple Filters',
                subtitle:
                    'Three BackdropFilter.grouped widgets inside a single'
                    ' BackdropGroup. They share the backdrop sample.',
              ),
              const _LiveBackdropGroup(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 4,
                title: 'Animated Blur Intensity',
                subtitle:
                    'AnimationController drives ImageFilter.blur sigma on'
                    ' multiple grouped filters simultaneously.',
              ),
              const _AnimatedBlurSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 5,
                title: 'Layered Blur Stack',
                subtitle:
                    '3 stacked BackdropFilter.grouped layers with different'
                    ' sigmas — observe how composition works.',
              ),
              const _LayeredBlurStack(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 6,
                title: 'Comparison: Grouped vs Ungrouped',
                subtitle:
                    'Side-by-side panels — visually similar, perf differs.'
                    ' Grouped shares one sample; ungrouped allocates N.',
              ),
              const _GroupedVsUngrouped(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 7,
                title: 'iOS-Style Notification Banner',
                subtitle:
                    'Real-world recipe: a notification card with frosted'
                    ' glass over a wallpaper-like gradient.',
              ),
              const _IosNotificationBanner(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 8,
                title: 'Floating Action Sheet',
                subtitle:
                    'Bottom action sheet with frosted-glass blur over a'
                    ' colorful chart-like background.',
              ),
              const _FloatingActionSheet(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 9,
                title: 'Row of Filters: Blur, Dilate, Erode',
                subtitle:
                    'Three BackdropFilter.grouped widgets with different'
                    ' ImageFilter types side-by-side.',
              ),
              const _FilterTypeRow(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 10,
                title: 'Pitfalls',
                subtitle:
                    'Common mistakes when using BackdropFilter and how'
                    ' BackdropGroup helps mitigate them.',
              ),
              const _PitfallsSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 11,
                title: 'Recipe Gallery',
                subtitle:
                    'Four working recipes: modal sheet, navbar, search'
                    ' overlay, alert dialog.',
              ),
              const _RecipeGallery(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 12,
                title: 'Reference Table',
                subtitle: 'API summary for backdrop / image filter widgets.',
              ),
              const _ReferenceTable(),
              const SizedBox(height: 32),
              const _FooterNote(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section header — used to label each demo section consistently.
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
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

// =============================================================================
// Section 1: Intro explanation + ASCII diagram.
// =============================================================================

class _IntroExplanation extends StatelessWidget {
  const _IntroExplanation();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'BackdropFilter is one of the more expensive Flutter widgets:'
              ' to apply an image filter (e.g. blur) to the content behind'
              ' the widget, the engine performs a saveLayer / restore around'
              ' a snapshot of the parent. Each BackdropFilter does this'
              ' independently — even if 10 sibling filters all want the same'
              ' input, the engine samples the parent 10 times.',
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
            SizedBox(height: 10),
            Text(
              'BackdropGroup fixes this. Wrap a subtree in a BackdropGroup'
              ' and use BackdropFilter.grouped (instead of the regular'
              ' BackdropFilter constructor). Every grouped filter inside'
              ' the group looks up the same BackdropKey and shares the'
              ' single shared sample.',
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
            SizedBox(height: 10),
            Text(
              'Visually the result is essentially identical — each grouped'
              ' filter still applies its own ImageFilter to the shared'
              ' input. The performance difference matters when you have'
              ' many filters (a glassmorphism wall, an animated blur grid,'
              ' a frosted nav bar, etc).',
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroDiagram extends StatelessWidget {
  const _IntroDiagram();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Without grouping (each filter samples independently):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: const Text(
                '  Parent paint  -> [sample 1] -> filter A\n'
                '                -> [sample 2] -> filter B\n'
                '                -> [sample 3] -> filter C\n'
                '                -> [sample 4] -> filter D\n'
                '   N filters    => N samples (expensive saveLayers)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'With BackdropGroup (single shared sample):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: const Text(
                '  Parent paint  -> [shared sample] +-> filter A\n'
                '                                   +-> filter B\n'
                '                                   +-> filter C\n'
                '                                   +-> filter D\n'
                '   N filters    => 1 sample (one saveLayer reused)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Section 2: Glassmorphism wall — 6 frosted cards over a colorful gradient.
// =============================================================================

class _GlassmorphismWall extends StatelessWidget {
  const _GlassmorphismWall();

  @override
  Widget build(BuildContext context) {
    final cards = <_GlassCardData>[
      const _GlassCardData('Aurora', 'Northern lights gradient', Icons.auto_awesome),
      const _GlassCardData('Crimson', 'Sunset over the desert', Icons.wb_twilight),
      const _GlassCardData('Lagoon', 'Tropical waters', Icons.water),
      const _GlassCardData('Nebula', 'Cosmic dust clouds', Icons.public),
      const _GlassCardData('Forest', 'Mossy underbrush', Icons.park),
      const _GlassCardData('Aether', 'Pale violet wash', Icons.cloud),
    ];

    return SizedBox(
      height: 360,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Colorful gradient background.
            const _ColorfulGradient(seed: 17),
            // Decorative blobs that benefit from being blurred.
            const Positioned(
              top: 30,
              left: 20,
              child: _Blob(color: Colors.pinkAccent, size: 90),
            ),
            const Positioned(
              top: 80,
              right: 30,
              child: _Blob(color: Colors.lightBlueAccent, size: 110),
            ),
            const Positioned(
              bottom: 20,
              left: 60,
              child: _Blob(color: Colors.amberAccent, size: 80),
            ),
            const Positioned(
              bottom: 60,
              right: 80,
              child: _Blob(color: Colors.purpleAccent, size: 100),
            ),
            // The grouped glass cards.
            BackdropGroup(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    for (final c in cards) _GlassCard(data: c),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassCardData {
  const _GlassCardData(this.title, this.subtitle, this.icon);
  final String title;
  final String subtitle;
  final IconData icon;
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.data});

  final _GlassCardData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Icon(data.icon, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorfulGradient extends StatelessWidget {
  const _ColorfulGradient({this.seed = 0});

  final int seed;

  @override
  Widget build(BuildContext context) {
    // Vary the gradient angle slightly using the seed so different sections
    // do not look identical.
    final angle = (seed * 13) % 90;
    final begin = Alignment(-1 + (angle / 90) * 2, -1);
    const end = Alignment(1, 1);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: <Color>[
            Colors.deepPurple.shade400,
            Colors.indigo.shade500,
            Colors.cyan.shade400,
            Colors.amber.shade400,
            Colors.pink.shade400,
          ],
          stops: const <double>[0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            color.withOpacity(0.85),
            color.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Section 3: Live BackdropGroup wrapping three BackdropFilter.grouped widgets.
// =============================================================================

class _LiveBackdropGroup extends StatelessWidget {
  const _LiveBackdropGroup();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const _ColorfulGradient(seed: 5),
            // A "background text" layer behind the filters so the blur is
            // visually obvious.
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (var i = 0; i < 28; i++)
                      Text(
                        ['Flutter', 'Backdrop', 'Group', 'Shared', 'Sample'][
                            i % 5],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            BackdropGroup(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 16,
                    top: 16,
                    width: 130,
                    height: 80,
                    child: _GroupedFilterTile(
                      label: 'Filter A\n(σ=10)',
                      sigma: 10,
                    ),
                  ),
                  Positioned(
                    left: 160,
                    top: 50,
                    width: 130,
                    height: 80,
                    child: _GroupedFilterTile(
                      label: 'Filter B\n(σ=18)',
                      sigma: 18,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    width: 150,
                    height: 90,
                    child: _GroupedFilterTile(
                      label: 'Filter C\n(σ=24)',
                      sigma: 24,
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

class _GroupedFilterTile extends StatelessWidget {
  const _GroupedFilterTile({required this.label, required this.sigma});

  final String label;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.22),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.45)),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 4: Animated blur intensity — AnimationController drives sigma.
// =============================================================================

class _AnimatedBlurSection extends StatefulWidget {
  const _AnimatedBlurSection();

  @override
  State<_AnimatedBlurSection> createState() => _AnimatedBlurSectionState();
}

class _AnimatedBlurSectionState extends State<_AnimatedBlurSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<double> _sigma = Tween<double>(begin: 2, end: 22)
      .chain(CurveTween(curve: Curves.easeInOutCubic))
      .animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sigma,
      builder: (context, _) {
        final s = _sigma.value;
        return SizedBox(
          height: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                const _ColorfulGradient(seed: 33),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'σ = ${s.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                BackdropGroup(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 12,
                        top: 12,
                        width: 110,
                        height: 70,
                        child: _AnimatedBlurTile(sigma: s, label: 'Tile A'),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        width: 110,
                        height: 70,
                        child: _AnimatedBlurTile(sigma: s, label: 'Tile B'),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        width: 110,
                        height: 70,
                        child: _AnimatedBlurTile(sigma: s, label: 'Tile C'),
                      ),
                      Positioned(
                        right: 12,
                        bottom: 12,
                        width: 110,
                        height: 70,
                        child: _AnimatedBlurTile(sigma: s, label: 'Tile D'),
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

class _AnimatedBlurTile extends StatelessWidget {
  const _AnimatedBlurTile({required this.sigma, required this.label});

  final double sigma;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 5: Layered blur stack — 3 stacked BackdropFilter.grouped layers.
// =============================================================================

class _LayeredBlurStack extends StatelessWidget {
  const _LayeredBlurStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const _ColorfulGradient(seed: 11),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 6,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    for (var i = 0; i < 24; i++)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.primaries[i % Colors.primaries.length]
                              .withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            BackdropGroup(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _StackedLayer(size: 200, sigma: 4, opacity: 0.10),
                    _StackedLayer(size: 150, sigma: 10, opacity: 0.16),
                    _StackedLayer(size: 100, sigma: 22, opacity: 0.24),
                    const Text(
                      '3 layers',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StackedLayer extends StatelessWidget {
  const _StackedLayer({
    required this.size,
    required this.sigma,
    required this.opacity,
  });

  final double size;
  final double sigma;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.35)),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 6: Comparison — grouped vs ungrouped (visually similar; perf differs).
// =============================================================================

class _GroupedVsUngrouped extends StatelessWidget {
  const _GroupedVsUngrouped();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _ComparisonCard(
            title: 'Grouped',
            caption: 'BackdropGroup wraps 4 filters → 1 sample reused.',
            child: const _ComparisonGroupedPanel(),
            color: Colors.green.shade50,
            border: Colors.green.shade300,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ComparisonCard(
            title: 'Ungrouped',
            caption: 'Plain BackdropFilters → 4 independent samples (4×).',
            child: const _ComparisonUngroupedPanel(),
            color: Colors.red.shade50,
            border: Colors.red.shade300,
          ),
        ),
      ],
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.title,
    required this.caption,
    required this.child,
    required this.color,
    required this.border,
  });

  final String title;
  final String caption;
  final Widget child;
  final Color color;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(caption, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          SizedBox(height: 180, child: child),
        ],
      ),
    );
  }
}

class _ComparisonGroupedPanel extends StatelessWidget {
  const _ComparisonGroupedPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _ColorfulGradient(seed: 7),
          BackdropGroup(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  _SmallGroupedTile(sigma: 14),
                  _SmallGroupedTile(sigma: 14),
                  _SmallGroupedTile(sigma: 14),
                  _SmallGroupedTile(sigma: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonUngroupedPanel extends StatelessWidget {
  const _ComparisonUngroupedPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _ColorfulGradient(seed: 7),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                _SmallPlainTile(sigma: 14),
                _SmallPlainTile(sigma: 14),
                _SmallPlainTile(sigma: 14),
                _SmallPlainTile(sigma: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallGroupedTile extends StatelessWidget {
  const _SmallGroupedTile({required this.sigma});

  final double sigma;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class _SmallPlainTile extends StatelessWidget {
  const _SmallPlainTile({required this.sigma});

  final double sigma;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.warning_amber, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 7: iOS-style notification banner.
// =============================================================================

class _IosNotificationBanner extends StatelessWidget {
  const _IosNotificationBanner();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Wallpaper-like gradient with a fake mountain silhouette.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.indigo.shade900,
                    Colors.deepPurple.shade700,
                    Colors.pink.shade400,
                    Colors.orange.shade300,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: CustomPaint(painter: _MountainPainter()),
            ),
            Positioned(
              top: 18,
              right: 24,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber.shade100.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // The frosted notification banner stack.
            BackdropGroup(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    _FrostedNotification(
                      app: 'Messages',
                      title: 'Mom',
                      body: 'Don\'t forget dinner at 7. Bring wine.',
                      icon: Icons.message_rounded,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    _FrostedNotification(
                      app: 'Calendar',
                      title: 'Standup',
                      body: 'Daily standup in 10 minutes (room: Echo).',
                      icon: Icons.calendar_today,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 8),
                    _FrostedNotification(
                      app: 'Mail',
                      title: 'Inbox: 3 new',
                      body: 'Review PR #482, sprint planning notes…',
                      icon: Icons.mail_outline,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.45);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.55)
      ..lineTo(size.width * 0.20, size.height * 0.10)
      ..lineTo(size.width * 0.42, size.height * 0.55)
      ..lineTo(size.width * 0.55, size.height * 0.30)
      ..lineTo(size.width * 0.82, size.height * 0.55)
      ..lineTo(size.width, size.height * 0.40)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MountainPainter oldDelegate) => false;
}

class _FrostedNotification extends StatelessWidget {
  const _FrostedNotification({
    required this.app,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String app;
  final String title;
  final String body;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          app,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'now',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 8: Floating action sheet over a chart-like background.
// =============================================================================

class _FloatingActionSheet extends StatelessWidget {
  const _FloatingActionSheet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Chart-ish bar background.
            Container(color: const Color(0xFF101522)),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    for (var i = 0; i < 18; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                          child: Container(
                            height: 30.0 +
                                (i * 11) % 180,
                            decoration: BoxDecoration(
                              color: Colors
                                  .primaries[i % Colors.primaries.length]
                                  .withOpacity(0.85),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // The action sheet at the bottom.
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: BackdropGroup(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter.grouped(
                    filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.4)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              _SheetAction(icon: Icons.share, label: 'Share'),
                              _SheetAction(icon: Icons.edit, label: 'Edit'),
                              _SheetAction(icon: Icons.copy, label: 'Copy'),
                              _SheetAction(
                                  icon: Icons.delete, label: 'Delete'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter.grouped(
                              filter: ui.ImageFilter.blur(
                                  sigmaX: 6, sigmaY: 6),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Nested grouped filter — same sample,'
                                  ' lighter blur for the inline note.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _SheetAction extends StatelessWidget {
  const _SheetAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 9: Row of 3 grouped filters with different ImageFilter types.
// =============================================================================

class _FilterTypeRow extends StatelessWidget {
  const _FilterTypeRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // A high-frequency pattern background helps make dilate/erode
            // visible (they affect bright pixel neighborhoods).
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.cyan.shade300,
                    Colors.purple.shade400,
                    Colors.amber.shade300,
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: <Widget>[
                    for (var i = 0; i < 26; i++)
                      Container(
                        width: 28,
                        height: 28,
                        color: Colors.primaries[i % Colors.primaries.length],
                      ),
                  ],
                ),
              ),
            ),
            BackdropGroup(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _FilterTypeTile(
                        label: 'blur (σ=14)',
                        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FilterTypeTile(
                        label: 'dilate (3,3)',
                        filter: ui.ImageFilter.dilate(
                            radiusX: 3, radiusY: 3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FilterTypeTile(
                        label: 'erode (3,3)',
                        filter:
                            ui.ImageFilter.erode(radiusX: 3, radiusY: 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTypeTile extends StatelessWidget {
  const _FilterTypeTile({required this.label, required this.filter});

  final String label;
  final ui.ImageFilter filter;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter.grouped(
        filter: filter,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 6),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 10: Pitfalls — 5 cards.
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    final items = <_PitfallData>[
      const _PitfallData(
        icon: Icons.bolt,
        color: Colors.orange,
        title: 'BackdropFilter is expensive — group when possible.',
        body: 'Each non-grouped BackdropFilter triggers a saveLayer +'
            ' offscreen sample. Wrap siblings in BackdropGroup and use'
            ' BackdropFilter.grouped to share one sample.',
      ),
      const _PitfallData(
        icon: Icons.timeline,
        color: Colors.red,
        title: 'ImageFilter.blur radius affects performance.',
        body: 'Larger sigma → larger kernel → slower convolution. Prefer'
            ' modest sigmas (~10-20) and rely on color tints for the'
            ' "frosted" look.',
      ),
      const _PitfallData(
        icon: Icons.format_paint,
        color: Colors.blueGrey,
        title: 'Don\'t blur over solid colors.',
        body: 'A blurred sample of a solid color is still a solid color.'
            ' If the input is uniform, skip the BackdropFilter entirely'
            ' and just paint a translucent color.',
      ),
      const _PitfallData(
        icon: Icons.layers,
        color: Colors.deepPurple,
        title: 'BackdropFilter requires saveLayer.',
        body: 'saveLayer round-trips through the GPU. Heavy on mobile'
            ' impellers, especially when the layer covers a large area.',
      ),
      const _PitfallData(
        icon: Icons.add_chart,
        color: Colors.teal,
        title: 'Stacking many BackdropFilters multiplies cost — group!',
        body: 'A wall of 12 ungrouped filters means 12 saveLayers. The same'
            ' wall under one BackdropGroup samples once and the engine'
            ' applies each filter to the shared input.',
      ),
    ];
    return Column(
      children: <Widget>[
        for (final p in items) _PitfallCard(data: p),
      ],
    );
  }
}

class _PitfallData {
  const _PitfallData({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.data});

  final _PitfallData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(data.icon, color: data.color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.body,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      height: 1.4,
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

// =============================================================================
// Section 11: Recipe gallery — 4 cards each with a working effect.
// =============================================================================

class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _RecipeModalSheet(),
        SizedBox(height: 12),
        _RecipeNavbar(),
        SizedBox(height: 12),
        _RecipeSearchOverlay(),
        SizedBox(height: 12),
        _RecipeAlertDialog(),
      ],
    );
  }
}

class _RecipeModalSheet extends StatelessWidget {
  const _RecipeModalSheet();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe: modal sheet glass',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const _ColorfulGradient(seed: 41),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BackdropGroup(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: BackdropFilter.grouped(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 18, sigmaY: 18),
                            child: Container(
                              height: 110,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.20),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Modal Sheet',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Slides up from the bottom over the page.'
                                    ' Frosted glass keeps context visible.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: <Widget>[
                                      _GlassPill(label: 'Cancel'),
                                      const SizedBox(width: 6),
                                      _GlassPill(label: 'Confirm'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeNavbar extends StatelessWidget {
  const _RecipeNavbar();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe: navbar with content scrolling under',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(color: const Color(0xFFEFF1F8)),
                    ListView(
                      padding: const EdgeInsets.fromLTRB(12, 60, 12, 12),
                      children: <Widget>[
                        for (var i = 0; i < 8; i++)
                          Container(
                            margin:
                                const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.primaries[
                                  i % Colors.primaries.length]
                                  .withOpacity(0.85),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Row $i — content scrolls under the navbar',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: BackdropGroup(
                        child: ClipRRect(
                          child: BackdropFilter.grouped(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 14, sigmaY: 14),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.55),
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Colors.white.withOpacity(0.6))),
                              ),
                              child: Row(
                                children: const <Widget>[
                                  Icon(Icons.menu, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Frosted Navbar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeSearchOverlay extends StatelessWidget {
  const _RecipeSearchOverlay();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe: search overlay',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const _ColorfulGradient(seed: 67),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          for (var i = 0; i < 12; i++)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$i',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    BackdropGroup(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter.grouped(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 22, sigmaY: 22),
                            child: Container(
                              width: 240,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                              child: Row(
                                children: const <Widget>[
                                  Icon(Icons.search, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Search…',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeAlertDialog extends StatelessWidget {
  const _RecipeAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe: alert dialog over busy background',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Busy background.
                    Container(color: Colors.black),
                    Positioned.fill(
                      child: Wrap(
                        children: <Widget>[
                          for (var i = 0; i < 80; i++)
                            Container(
                              width: 36,
                              height: 28,
                              color: Colors.primaries[
                                  i % Colors.primaries.length],
                            ),
                        ],
                      ),
                    ),
                    BackdropGroup(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter.grouped(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 18, sigmaY: 18),
                            child: Container(
                              width: 260,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Confirm action?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'This cannot be undone.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _GlassPill(label: 'Cancel'),
                                      _GlassPill(label: 'OK'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  const _GlassPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 12: Reference table.
// =============================================================================

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    final rows = <_RefRow>[
      const _RefRow(
        api: 'BackdropFilter',
        purpose:
            'Apply an ImageFilter to the painted content behind the widget.'
            ' Each instance triggers an independent saveLayer/sample.',
      ),
      const _RefRow(
        api: 'BackdropFilter.grouped',
        purpose:
            'A BackdropFilter that participates in the nearest BackdropGroup'
            ' (sharing one sample with its group siblings).',
      ),
      const _RefRow(
        api: 'BackdropGroup',
        purpose:
            'InheritedWidget that exposes a shared BackdropKey. All grouped'
            ' filters in the subtree share one sample of the parent.',
      ),
      const _RefRow(
        api: 'ImageFilter.blur',
        purpose:
            'Gaussian blur with sigmaX / sigmaY. The most common backdrop'
            ' filter. Larger sigma → more expensive convolution.',
      ),
      const _RefRow(
        api: 'ImageFilter.compose',
        purpose:
            'Compose two image filters (outer applied to result of inner).'
            ' Lets you chain blur → matrix, etc.',
      ),
      const _RefRow(
        api: 'ColorFilter',
        purpose:
            'Color-only filtering (matrix, mode). Cheaper than ImageFilter;'
            ' use ColorFiltered for color-only effects, not BackdropFilter.',
      ),
      const _RefRow(
        api: 'ImageFiltered',
        purpose:
            'Apply an ImageFilter to the child only (not the backdrop).'
            ' Use when you want to filter a widget itself instead of what'
            ' is behind it.',
      ),
      const _RefRow(
        api: 'ImageFilter.dilate / .erode',
        purpose:
            'Morphological filters useful for stylized effects. Less'
            ' commonly used as backdrop filters but legal.',
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade300),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: Colors.indigo.shade50),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'API',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Purpose',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            for (final r in rows)
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      r.api,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(r.purpose, style: const TextStyle(height: 1.4)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _RefRow {
  const _RefRow({required this.api, required this.purpose});
  final String api;
  final String purpose;
}

// =============================================================================
// Footer.
// =============================================================================

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: Colors.indigo.shade600),
              const SizedBox(width: 8),
              const Text(
                'About this demo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'BackdropGroup and BackdropFilter.grouped are exposed by the'
            ' Flutter SDK in use; this demo uses them live. The visual'
            ' result is essentially identical to using plain BackdropFilter,'
            ' but the engine performs only one offscreen sample per group'
            ' instead of one per filter.',
            style: TextStyle(height: 1.4),
          ),
          const SizedBox(height: 10),
          const Text(
            'Patterns demonstrated:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            '• Glassmorphism wall (grouped 6-up grid)\n'
            '• Animated blur (sigma driven by AnimationController)\n'
            '• Layered blur stack (3 grouped circles)\n'
            '• Grouped vs ungrouped side-by-side\n'
            '• iOS-style notification banner\n'
            '• Floating action sheet over a chart background\n'
            '• Row of grouped filters: blur, dilate, erode\n'
            '• Recipe gallery: modal sheet, navbar, search overlay, alert',
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}
