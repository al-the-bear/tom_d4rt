// ignore_for_file: avoid_print
// D4rt test script: Tests DecoratedSliver from widgets/decorated_sliver.dart
// Deep Demo: Visual exploration of DecoratedSliver — the sliver version of
// DecoratedBox that paints decorations behind or in front of sliver children.
//
// DecoratedSliver is designed for use inside CustomScrollView and other sliver
// contexts. Unlike DecoratedBox (which wraps RenderBox widgets), DecoratedSliver
// expects a sliver child and properly handles scroll geometry, cache extent,
// and painting within the sliver protocol.
//
// Key properties:
// - decoration: A Decoration (typically BoxDecoration) to paint
// - position: DecorationPosition.background or .foreground
// - sliver: The sliver child to decorate
//
// Scene 1 — DecoratedSliver vs DecoratedBox: conceptual comparison
// Scene 2 — Basic Decorations: solid colors, borders, border-radius
// Scene 3 — Gradient Decorations: linear and radial gradients on slivers
// Scene 4 — DecorationPosition: background vs foreground painting
// Scene 5 — Multiple Decorated Slivers: composing rich scroll views
// Scene 6 — Practical Patterns: headers, sections, visual dividers
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecoratedSliver Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — ocean/sand/coral coastal theme
  // ──────────────────────────────────────────────────────────
  const cOcean = Color(0xFF006994);        // deep ocean blue - primary
  const cSand = Color(0xFFF5E6D3);         // warm sand - surface
  const cCoral = Color(0xFFFF6F61);        // coral pink - accent
  const cSeafoam = Color(0xFF88D8B0);      // seafoam green - success
  const cNavy = Color(0xFF1A237E);         // deep navy - secondary
  const cSunset = Color(0xFFFF9E80);       // sunset orange - warm
  const cDeepTeal = Color(0xFF00695C);     // deep teal - info
  const cSlate = Color(0xFF37474F);        // slate - text
  const cPearl = Color(0xFFFAF9F6);        // pearl white - light surface
  const cLagoon = Color(0xFF4DD0E1);       // lagoon cyan - highlight

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 34.0, bottom: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: cSlate.withValues(alpha: 0.85),
          height: 1.5,
        ),
      ),
    );
  }

  Widget codeSnippet(String code, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cSlate.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: borderColor.withValues(alpha: 0.15)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          color: cSlate.withValues(alpha: 0.8),
          height: 1.4,
        ),
      ),
    );
  }

  Widget tagLabel(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget demoCard({
    required String title,
    required String description,
    required Widget child,
    required Color accent,
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? 320.0,
      height: height,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cSlate.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a simple sliver list item for demos.
  Widget sliverItem(String text, Color color, {double height = 50.0}) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: cPearl,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 12.0, color: cSlate),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SCENE 1 — DecoratedSliver vs DecoratedBox
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 1: DecoratedSliver vs DecoratedBox ---');
  print('Understanding when to use each');

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — DecoratedSliver vs DecoratedBox',
        'Two decoration widgets for different contexts',
        Icons.compare_arrows,
        cOcean,
      ),
      infoBox(
        'Flutter has two decoration widgets: DecoratedBox for regular box widgets, '
        'and DecoratedSliver for sliver widgets used in scroll views. They have '
        'similar APIs but work with different layout protocols. DecoratedSliver '
        'properly handles scroll extent, paint offset, and cache regions.',
        cOcean,
      ),

      // Comparison table
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cSand,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cOcean.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'Feature Comparison',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cOcean),
            ),
            const SizedBox(height: 16.0),
            // Header row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Feature', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate)),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: cOcean.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'DecoratedBox',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cOcean),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: cCoral.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'DecoratedSliver',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cCoral),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Data rows
            for (final row in [
              {'feature': 'Child type', 'box': 'RenderBox widget', 'sliver': 'Sliver widget'},
              {'feature': 'Used in', 'box': 'Row, Column, Stack...', 'sliver': 'CustomScrollView'},
              {'feature': 'Layout protocol', 'box': 'Box constraints', 'sliver': 'Sliver geometry'},
              {'feature': 'Scroll-aware', 'box': 'No', 'sliver': 'Yes (extent, cache)'},
              {'feature': 'Decoration', 'box': 'BoxDecoration etc', 'sliver': 'BoxDecoration etc'},
              {'feature': 'Position property', 'box': '✓', 'sliver': '✓'},
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        row['feature']!,
                        style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.7)),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          row['box']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          row['sliver']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      // Visual comparison
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DecoratedBox example
          demoCard(
            title: 'DecoratedBox',
            description: 'For box widgets (Row, Column, etc)',
            accent: cOcean,
            width: 220.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: cOcean.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cOcean.withValues(alpha: 0.4)),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.crop_square, color: cOcean, size: 32.0),
                    const SizedBox(height: 8.0),
                    Text(
                      'I am a box widget\nwith a decoration',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0, color: cOcean),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // DecoratedSliver context
          demoCard(
            title: 'DecoratedSliver',
            description: 'For slivers in scroll views',
            accent: cCoral,
            width: 220.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cCoral.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cCoral.withValues(alpha: 0.4)),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.view_day, color: cCoral, size: 32.0),
                            const SizedBox(height: 8.0),
                            Text(
                              'I am a sliver widget\nwith a decoration',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10.0, color: cCoral),
                            ),
                          ],
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

      codeSnippet(
        '// DecoratedSliver in a CustomScrollView\n'
        'CustomScrollView(\n'
        '  slivers: [\n'
        '    DecoratedSliver(\n'
        '      decoration: BoxDecoration(\n'
        '        color: Colors.blue.withOpacity(0.1),\n'
        '        borderRadius: BorderRadius.circular(8.0),\n'
        '      ),\n'
        '      sliver: SliverList(...),\n'
        '    ),\n'
        '  ],\n'
        ')',
        cOcean,
      ),
    ],
  );

  print('Scene 1 built: comparison table + visual examples');

  // ════════════════════════════════════════════════════════════
  // SCENE 2 — Basic Decorations
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 2: Basic Decorations ---');
  print('Solid colors, borders, and border-radius on slivers');

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Basic Decorations',
        'Solid colors, borders, and rounded corners on sliver content',
        Icons.format_color_fill,
        cSeafoam,
      ),
      infoBox(
        'DecoratedSliver accepts any Decoration, but BoxDecoration is most common. '
        'You can apply solid fills, borders, border-radius, and more. The decoration '
        'paints at the sliver\'s position and covers its scroll extent.',
        cSeafoam,
      ),

      // Basic decoration gallery
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Solid color
          demoCard(
            title: 'Solid Color Fill',
            description: 'Simple background color',
            accent: cOcean,
            width: 195.0,
            height: 180.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cOcean.withValues(alpha: 0.15),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < 2; i++)
                              Container(
                                height: 30.0,
                                margin: const EdgeInsets.symmetric(vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text('Item ${i + 1}', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Border
          demoCard(
            title: 'Border Only',
            description: 'Border without fill',
            accent: cCoral,
            width: 195.0,
            height: 180.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      border: Border.all(color: cCoral, width: 2.0),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < 2; i++)
                              Container(
                                height: 30.0,
                                margin: const EdgeInsets.symmetric(vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: cPearl,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text('Item ${i + 1}', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ),
                              ),
                          ],
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

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rounded corners
          demoCard(
            title: 'Rounded Corners',
            description: 'BorderRadius with fill',
            accent: cDeepTeal,
            width: 195.0,
            height: 180.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cDeepTeal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < 2; i++)
                              Container(
                                height: 30.0,
                                margin: const EdgeInsets.symmetric(vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text('Item ${i + 1}', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Combined
          demoCard(
            title: 'Combined',
            description: 'Fill + border + radius',
            accent: cSunset,
            width: 195.0,
            height: 180.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cSunset.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: cSunset.withValues(alpha: 0.4), width: 1.5),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < 2; i++)
                              Container(
                                height: 30.0,
                                margin: const EdgeInsets.symmetric(vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text('Item ${i + 1}', style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ),
                              ),
                          ],
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

      codeSnippet(
        'DecoratedSliver(\n'
        '  decoration: BoxDecoration(\n'
        '    color: Colors.teal.withOpacity(0.1),\n'
        '    borderRadius: BorderRadius.circular(12.0),\n'
        '    border: Border.all(color: Colors.teal),\n'
        '  ),\n'
        '  sliver: SliverList.builder(\n'
        '    itemCount: 5,\n'
        '    itemBuilder: (ctx, i) => ListTile(title: Text(\'Item \$i\')),\n'
        '  ),\n'
        ')',
        cSeafoam,
      ),
    ],
  );

  print('Scene 2 built: 4 basic decoration styles');

  // ════════════════════════════════════════════════════════════
  // SCENE 3 — Gradient Decorations
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 3: Gradient Decorations ---');
  print('Linear and radial gradients on sliver content');

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — Gradient Decorations',
        'Linear and radial gradients behind sliver content',
        Icons.gradient,
        cNavy,
      ),
      infoBox(
        'BoxDecoration supports gradients: LinearGradient, RadialGradient, and '
        'SweepGradient. When applied to DecoratedSliver, the gradient paints '
        'across the sliver\'s scroll extent, creating beautiful background effects.',
        cNavy,
      ),

      // Gradient gallery
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linear gradient vertical
          demoCard(
            title: 'Linear Gradient (Vertical)',
            description: 'Top-to-bottom color transition',
            accent: cOcean,
            width: 200.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          cOcean.withValues(alpha: 0.3),
                          cLagoon.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => sliverItem('Item ${index + 1}', cOcean, height: 40.0),
                        childCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Linear gradient diagonal
          demoCard(
            title: 'Linear Gradient (Diagonal)',
            description: 'Corner-to-corner transition',
            accent: cCoral,
            width: 200.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cCoral.withValues(alpha: 0.25),
                          cSunset.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => sliverItem('Item ${index + 1}', cCoral, height: 40.0),
                        childCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Radial gradient
          demoCard(
            title: 'Radial Gradient',
            description: 'Center-outward glow effect',
            accent: cDeepTeal,
            width: 200.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          cSeafoam.withValues(alpha: 0.4),
                          cDeepTeal.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => sliverItem('Item ${index + 1}', cDeepTeal, height: 40.0),
                        childCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Multi-stop gradient
          demoCard(
            title: 'Multi-Stop Gradient',
            description: 'Multiple color stops',
            accent: cNavy,
            width: 200.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          cNavy.withValues(alpha: 0.2),
                          cOcean.withValues(alpha: 0.15),
                          cLagoon.withValues(alpha: 0.1),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => sliverItem('Item ${index + 1}', cNavy, height: 40.0),
                        childCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      codeSnippet(
        'DecoratedSliver(\n'
        '  decoration: BoxDecoration(\n'
        '    gradient: LinearGradient(\n'
        '      begin: Alignment.topCenter,\n'
        '      end: Alignment.bottomCenter,\n'
        '      colors: [Colors.blue.shade100, Colors.blue.shade50],\n'
        '    ),\n'
        '  ),\n'
        '  sliver: SliverList(...),\n'
        ')',
        cNavy,
      ),
    ],
  );

  print('Scene 3 built: 4 gradient styles');

  // ════════════════════════════════════════════════════════════
  // SCENE 4 — DecorationPosition
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 4: DecorationPosition ---');
  print('Background vs foreground painting');

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — DecorationPosition',
        'Background (default) vs Foreground painting',
        Icons.layers,
        cCoral,
      ),
      infoBox(
        'The position property controls whether the decoration paints BEHIND '
        '(background) or IN FRONT OF (foreground) the sliver child. Foreground '
        'decorations can create overlay effects, vignettes, or disabled states.',
        cCoral,
      ),

      // Position comparison
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Background position
          demoCard(
            title: 'DecorationPosition.background',
            description: 'Decoration paints BEHIND content (default)',
            accent: cOcean,
            width: 210.0,
            height: 220.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cOcean.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    position: DecorationPosition.background,
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.visibility, color: cOcean, size: 20.0),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      'Content is fully visible',
                                      style: TextStyle(fontSize: 11.0, color: cSlate),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Decoration is behind',
                              style: TextStyle(fontSize: 10.0, color: cOcean),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Foreground position
          demoCard(
            title: 'DecorationPosition.foreground',
            description: 'Decoration paints IN FRONT of content',
            accent: cCoral,
            width: 210.0,
            height: 220.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(
                      color: cCoral.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    position: DecorationPosition.foreground,
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.visibility_off, color: cCoral, size: 20.0),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      'Content is overlaid',
                                      style: TextStyle(fontSize: 11.0, color: cSlate),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Decoration is in front',
                              style: TextStyle(fontSize: 10.0, color: cCoral),
                            ),
                          ],
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

      // Practical foreground uses
      demoCard(
        title: 'Foreground Use Cases',
        description: 'Practical applications of foreground decorations',
        accent: cDeepTeal,
        width: 440.0,
        child: Row(
          children: [
            // Disabled overlay
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Disabled Overlay',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cDeepTeal),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          DecoratedSliver(
                            decoration: BoxDecoration(
                              color: cSlate.withValues(alpha: 0.4),
                            ),
                            position: DecorationPosition.foreground,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.block, color: Colors.white, size: 16.0),
                                    const SizedBox(width: 6.0),
                                    Text('Disabled', style: TextStyle(fontSize: 10.0, color: Colors.white)),
                                  ],
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
            const SizedBox(width: 12.0),
            // Vignette effect
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Vignette Effect',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cDeepTeal),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          DecoratedSliver(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Colors.transparent,
                                  cNavy.withValues(alpha: 0.3),
                                ],
                                radius: 0.8,
                              ),
                            ),
                            position: DecorationPosition.foreground,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                color: cSand,
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Content', style: TextStyle(fontSize: 10.0, color: cSlate)),
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
            const SizedBox(width: 12.0),
            // Loading overlay
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Loading State',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cDeepTeal),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: cSlate.withValues(alpha: 0.2)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          DecoratedSliver(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                            position: DecorationPosition.foreground,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                color: cOcean.withValues(alpha: 0.1),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: cOcean,
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
          ],
        ),
      ),

      codeSnippet(
        '// Foreground decoration for overlay effect\n'
        'DecoratedSliver(\n'
        '  decoration: BoxDecoration(\n'
        '    color: Colors.black.withOpacity(0.5),\n'
        '  ),\n'
        '  position: DecorationPosition.foreground,\n'
        '  sliver: SliverList(...),\n'
        ')',
        cCoral,
      ),
    ],
  );

  print('Scene 4 built: position comparison + use cases');

  // ════════════════════════════════════════════════════════════
  // SCENE 5 — Multiple Decorated Slivers
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 5: Multiple Decorated Slivers ---');
  print('Composing rich scroll views with decorated sections');

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Multiple Decorated Slivers',
        'Composing visually distinct sections in one scroll view',
        Icons.view_agenda,
        cSeafoam,
      ),
      infoBox(
        'A CustomScrollView can contain multiple DecoratedSliver widgets, each '
        'with different decorations. This creates visually segmented scroll content '
        'with distinct backgrounds for each section.',
        cSeafoam,
      ),

      // Multi-section scroll view
      demoCard(
        title: 'Multi-Section Scroll View',
        description: 'Different decorations per section',
        accent: cSeafoam,
        width: 440.0,
        height: 350.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CustomScrollView(
            slivers: [
              // Section 1: Ocean header
              DecoratedSliver(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [cOcean, cOcean.withValues(alpha: 0.7)],
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.waves, color: Colors.white, size: 28.0),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ocean Section',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Deep blue gradient header',
                              style: TextStyle(fontSize: 11.0, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section 2: Sand content
              DecoratedSliver(
                decoration: BoxDecoration(
                  color: cSand,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      height: 44.0,
                      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: cSlate.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: cSunset.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cSunset),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            'Sand section item ${index + 1}',
                            style: TextStyle(fontSize: 12.0, color: cSlate),
                          ),
                        ],
                      ),
                    ),
                    childCount: 3,
                  ),
                ),
              ),

              // Section 3: Coral accent
              DecoratedSliver(
                decoration: BoxDecoration(
                  color: cCoral.withValues(alpha: 0.1),
                  border: Border(
                    top: BorderSide(color: cCoral.withValues(alpha: 0.3), width: 2.0),
                    bottom: BorderSide(color: cCoral.withValues(alpha: 0.3), width: 2.0),
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department, color: cCoral, size: 24.0),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coral Highlight Section',
                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cCoral),
                              ),
                              Text(
                                'Bordered accent section',
                                style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section 4: Seafoam footer
              DecoratedSliver(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [cSeafoam.withValues(alpha: 0.15), cSeafoam.withValues(alpha: 0.3)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: cSeafoam, size: 20.0),
                          const SizedBox(width: 8.0),
                          Text(
                            'End of list',
                            style: TextStyle(fontSize: 12.0, color: cDeepTeal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      codeSnippet(
        'CustomScrollView(\n'
        '  slivers: [\n'
        '    DecoratedSliver(decoration: headerDecoration, sliver: header),\n'
        '    DecoratedSliver(decoration: contentDecoration, sliver: list),\n'
        '    DecoratedSliver(decoration: accentDecoration, sliver: highlight),\n'
        '    DecoratedSliver(decoration: footerDecoration, sliver: footer),\n'
        '  ],\n'
        ')',
        cSeafoam,
      ),
    ],
  );

  print('Scene 5 built: 4-section scroll view');

  // ════════════════════════════════════════════════════════════
  // SCENE 6 — Practical Patterns
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 6: Practical Patterns ---');
  print('Real-world DecoratedSliver usage patterns');

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Practical Patterns',
        'Real-world DecoratedSliver applications',
        Icons.build_circle,
        cDeepTeal,
      ),
      infoBox(
        'DecoratedSliver shines in apps with complex scroll views: settings pages, '
        'feeds, dashboards. Here are common patterns for productionuse.',
        cDeepTeal,
      ),

      // Pattern 1: Card-like sections
      demoCard(
        title: 'Pattern: Card-Like Sections',
        description: 'Rounded shadow sections in a list',
        accent: cOcean,
        width: 440.0,
        height: 200.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: cSand.withValues(alpha: 0.3),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: DecoratedSliver(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: cSlate.withValues(alpha: 0.1),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_circle, color: cOcean, size: 24.0),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Account Settings',
                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cSlate),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            for (final setting in ['Profile', 'Security', 'Notifications'])
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6.0,
                                      height: 6.0,
                                      decoration: BoxDecoration(
                                        color: cOcean,
                                        borderRadius: BorderRadius.circular(3.0),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(setting, style: TextStyle(fontSize: 12.0, color: cSlate.withValues(alpha: 0.7))),
                                  ],
                                ),
                              ),
                          ],
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

      // Pattern 2: Sticky header with decoration
      demoCard(
        title: 'Pattern: Decorated Sticky Header',
        description: 'Pinned header with background decoration',
        accent: cNavy,
        width: 440.0,
        height: 200.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CustomScrollView(
            slivers: [
              // Decorated persistent header
              SliverPersistentHeader(
                pinned: true,
                delegate: _ColoredHeaderDelegate(
                  minHeight: 50.0,
                  maxHeight: 80.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [cNavy, cOcean],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.inbox, color: Colors.white, size: 24.0),
                          const SizedBox(width: 12.0),
                          Text(
                            'Inbox',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              '5 new',
                              style: TextStyle(fontSize: 10.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Content below
              DecoratedSliver(
                decoration: BoxDecoration(color: cPearl),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      height: 50.0,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                              color: [cOcean, cCoral, cSeafoam][index % 3].withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Icon(
                              [Icons.mail, Icons.star, Icons.attach_file][index % 3],
                              color: [cOcean, cCoral, cSeafoam][index % 3],
                              size: 16.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              'Message ${index + 1}',
                              style: TextStyle(fontSize: 12.0, color: cSlate),
                            ),
                          ),
                        ],
                      ),
                    ),
                    childCount: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Pattern 3: Section dividers
      demoCard(
        title: 'Pattern: Visual Section Dividers',
        description: 'Using decoration to separate content groups',
        accent: cCoral,
        width: 440.0,
        height: 200.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              // Section A
              DecoratedSliver(
                decoration: const BoxDecoration(color: Colors.white),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        tagLabel('Section A', cOcean),
                        const SizedBox(width: 12.0),
                        Text('First group content', style: TextStyle(fontSize: 11.0, color: cSlate)),
                      ],
                    ),
                  ),
                ),
              ),
              // Divider sliver
              DecoratedSliver(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cSlate.withValues(alpha: 0.05),
                      cSlate.withValues(alpha: 0.1),
                      cSlate.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 20.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Container(
                        height: 1.0,
                        color: cSlate.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                ),
              ),
              // Section B
              DecoratedSliver(
                decoration: const BoxDecoration(color: Colors.white),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        tagLabel('Section B', cCoral),
                        const SizedBox(width: 12.0),
                        Text('Second group content', style: TextStyle(fontSize: 11.0, color: cSlate)),
                      ],
                    ),
                  ),
                ),
              ),
              // Divider sliver
              DecoratedSliver(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cSlate.withValues(alpha: 0.05),
                      cSlate.withValues(alpha: 0.1),
                      cSlate.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 20.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Container(
                        height: 1.0,
                        color: cSlate.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                ),
              ),
              // Section C
              DecoratedSliver(
                decoration: const BoxDecoration(color: Colors.white),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        tagLabel('Section C', cSeafoam),
                        const SizedBox(width: 12.0),
                        Text('Third group content', style: TextStyle(fontSize: 11.0, color: cSlate)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 10.0),

      // Closing summary
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cOcean.withValues(alpha: 0.08), cCoral.withValues(alpha: 0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cOcean.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: cOcean, size: 18.0),
                const SizedBox(width: 8.0),
                Text(
                  'When to use DecoratedSliver',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: cOcean,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              '• Adding background colors or gradients to sliver sections\n'
              '• Creating card-like sections with rounded corners and shadows\n'
              '• Building visually segmented scroll views (settings, feeds)\n'
              '• Adding borders to separate content groups\n'
              '• Creating overlay effects with foreground position\n'
              '• Implementing disabled or loading states over sliver content\n\n'
              'For non-sliver content (Row, Column, Stack), use DecoratedBox instead. '
              'DecoratedSliver is specifically designed for the sliver protocol.',
              style: TextStyle(
                fontSize: 11.0,
                color: cSlate.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 6 built: 3 practical patterns + summary');

  // ════════════════════════════════════════════════════════════
  // TITLE BANNER
  // ════════════════════════════════════════════════════════════
  final titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cOcean.withValues(alpha: 0.12), cCoral.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cOcean.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.view_day, color: cOcean, size: 28.0),
            const SizedBox(width: 10.0),
            Text(
              'DecoratedSliver',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: cOcean,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Decoration for Sliver Widgets in Scroll Views',
          style: TextStyle(
            fontSize: 13.0,
            color: cSlate.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          alignment: WrapAlignment.center,
          children: [
            tagLabel('BoxDecoration', cOcean),
            tagLabel('Gradients', cNavy),
            tagLabel('BorderRadius', cDeepTeal),
            tagLabel('DecorationPosition', cCoral),
            tagLabel('CustomScrollView', cSeafoam),
            tagLabel('SliverList', cSunset),
          ],
        ),
      ],
    ),
  );

  // ════════════════════════════════════════════════════════════
  // ASSEMBLE APP
  // ════════════════════════════════════════════════════════════
  print('\n=== Assembling final layout ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: cSand,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBanner,
            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}

/// A simple persistent header delegate for the sticky header demo.
class _ColoredHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ColoredHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_ColoredHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
