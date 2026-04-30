// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverAnimatedOpacity
// Demonstrates SliverAnimatedOpacity — a sliver that animates its child
// sliver's opacity over a given duration. Useful for fading sliver content
// in and out within a CustomScrollView.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedOpacity Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.opacity,
      'title': 'What Is SliverAnimatedOpacity?',
      'body': 'SliverAnimatedOpacity is the sliver version of '
          'AnimatedOpacity. It wraps a child sliver and automatically '
          'animates transitions between opacity values. When you change '
          'the opacity property, it smoothly interpolates over the '
          'given duration.',
    },
    {
      'icon': Icons.layers,
      'title': 'Sliver Context',
      'body': 'Unlike AnimatedOpacity (a box widget), SliverAnimatedOpacity '
          'works inside CustomScrollView alongside other slivers. It takes '
          'a sliver child — typically SliverList, SliverGrid, etc. — and '
          'fades the entire sliver section.',
    },
    {
      'icon': Icons.animation,
      'title': 'Implicit Animation',
      'body': 'Like other "Animated" widgets, SliverAnimatedOpacity is an '
          'implicit animation: you declaratively set the target opacity and '
          'duration, and the framework handles the interpolation. No '
          'AnimationController needed.',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'alwaysIncludeSemantics',
      'body': 'When opacity is 0, the child is still part of the widget tree '
          'but invisible. Set alwaysIncludeSemantics to true if screen readers '
          'should still announce the hidden content (accessibility).',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final item = conceptItems[i];
    print('Concept ${i + 1}: ${item['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.deepOrange.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.deepOrange,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    item['body'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[700],
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

  final conceptTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepOrange.withValues(alpha: 0.08),
                Colors.deepOrange.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              const Icon(Icons.opacity, size: 48.0, color: Colors.deepOrange),
              const SizedBox(height: 8.0),
              const Text(
                'SliverAnimatedOpacity',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A sliver that implicitly animates its child sliver\'s '
                'opacity smoothly over a configured duration.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...conceptCards,

        const SizedBox(height: 12.0),
        // Widget family tree
        buildSAOSectionHeader('Widget Family', Icons.account_tree),
        const SizedBox(height: 8.0),
        _buildSAOFamilyTree(),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final params = <Map<String, String>>[
    {
      'name': 'opacity',
      'type': 'double',
      'required': 'Yes',
      'desc': 'The target opacity (0.0 = invisible, 1.0 = fully visible). '
          'When this value changes, the widget animates to the new value.',
    },
    {
      'name': 'duration',
      'type': 'Duration',
      'required': 'Yes',
      'desc': 'How long the opacity transition takes. Typical values '
          'range from 200ms to 500ms.',
    },
    {
      'name': 'curve',
      'type': 'Curve',
      'required': 'No',
      'desc': 'The easing curve for the animation. Defaults to '
          'Curves.linear. Use Curves.easeInOut for a softer feel.',
    },
    {
      'name': 'onEnd',
      'type': 'VoidCallback?',
      'required': 'No',
      'desc': 'Called when the animation completes. Useful for chaining '
          'actions or cleanup after the fade finishes.',
    },
    {
      'name': 'alwaysIncludeSemantics',
      'type': 'bool',
      'required': 'No',
      'desc': 'When true, the child\'s semantics are included even when '
          'opacity is 0. Default is false.',
    },
    {
      'name': 'sliver',
      'type': 'Widget',
      'required': 'Yes',
      'desc': 'The child sliver to fade. Must be a sliver widget '
          '(SliverList, SliverGrid, SliverToBoxAdapter, etc.).',
    },
  ];

  final paramWidgets = <Widget>[];
  for (final p in params) {
    print('  Param: ${p['name']}');
    paramWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(11.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.deepOrange.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    p['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                      color: Colors.deepOrange,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  p['type']!,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey[500],
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                if (p['required'] == 'Yes')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      'REQUIRED',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              p['desc']!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[700],
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final constructorTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAOSectionHeader('Constructor Parameters', Icons.code),
        const SizedBox(height: 12.0),
        ...paramWidgets,
        const SizedBox(height: 14.0),
        buildSAOSectionHeader('Basic Usage', Icons.text_snippet),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'bool _visible = true;\n\n'
            'CustomScrollView(\n'
            '  slivers: [\n'
            '    SliverAnimatedOpacity(\n'
            '      opacity: _visible ? 1.0 : 0.0,\n'
            '      duration: Duration(milliseconds: 400),\n'
            '      curve: Curves.easeInOut,\n'
            '      sliver: SliverList(\n'
            '        delegate: SliverChildBuilderDelegate(\n'
            '          (ctx, i) => ListTile(\n'
            '            title: Text("Item \$i"),\n'
            '          ),\n'
            '          childCount: 10,\n'
            '        ),\n'
            '      ),\n'
            '    ),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Opacity Levels
  // ============================================================
  print('=== Section 3: Opacity Levels ===');

  final opacityLevels = <double>[0.0, 0.15, 0.3, 0.5, 0.7, 0.85, 1.0];

  final opacityCards = <Widget>[];
  for (final opacity in opacityLevels) {
    print('  Opacity level: $opacity');
    opacityCards.add(
      Column(
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.deepOrange.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: Colors.deepOrange.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.star,
                size: 22.0,
                color: Colors.white.withValues(alpha: opacity),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            opacity.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey[600],
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  final opacityTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAOSectionHeader('Opacity Spectrum', Icons.gradient),
        const SizedBox(height: 8.0),
        Text(
          'Visual reference for different opacity values. The animation '
          'smoothly interpolates between any two of these states.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepOrange.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: opacityCards,
          ),
        ),
        const SizedBox(height: 20.0),

        // Opacity + semantics explanation
        buildSAOSectionHeader('Opacity & Visibility', Icons.visibility),
        const SizedBox(height: 8.0),
        _buildSAOInfoRow(
          'opacity: 0.0',
          'Invisible. Child is still in the tree (takes space, '
          'receives events unless wrapped in IgnorePointer).',
          Colors.red,
          Icons.visibility_off,
        ),
        _buildSAOInfoRow(
          'opacity: 0.5',
          'Semi-transparent. Child is drawn at 50% alpha. Useful for '
          'disabled or loading states.',
          Colors.orange,
          Icons.tonality,
        ),
        _buildSAOInfoRow(
          'opacity: 1.0',
          'Fully visible. No visual difference from a non-wrapped child. '
          'No compositing layer is added when opacity is exactly 1.0.',
          Colors.green,
          Icons.visibility,
        ),

        const SizedBox(height: 20.0),
        buildSAOSectionHeader('Transition Diagram', Icons.timeline),
        const SizedBox(height: 8.0),
        _buildSAOTransitionDiagram(),

        const SizedBox(height: 20.0),
        // Performance note
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.tips_and_updates, color: Colors.amber, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Performance Tip',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Opacity creates a compositing layer when the value '
                      'is not 0.0 or 1.0. For elements that toggle between '
                      'fully visible and invisible, consider using '
                      'SliverVisibility or removing the sliver entirely — '
                      'it avoids the compositing overhead.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Curves
  // ============================================================
  print('=== Section 4: Curves ===');

  final curveEntries = <Map<String, dynamic>>[
    {
      'name': 'linear',
      'desc': 'Constant rate',
      'color': Colors.blue,
      'points': [0.0, 0.25, 0.5, 0.75, 1.0],
    },
    {
      'name': 'easeIn',
      'desc': 'Slow start, fast end',
      'color': Colors.green,
      'points': [0.0, 0.06, 0.25, 0.56, 1.0],
    },
    {
      'name': 'easeOut',
      'desc': 'Fast start, slow end',
      'color': Colors.orange,
      'points': [0.0, 0.44, 0.75, 0.94, 1.0],
    },
    {
      'name': 'easeInOut',
      'desc': 'Smooth start & end',
      'color': Colors.purple,
      'points': [0.0, 0.12, 0.5, 0.88, 1.0],
    },
    {
      'name': 'bounceOut',
      'desc': 'Bounce at the end',
      'color': Colors.red,
      'points': [0.0, 0.77, 1.0, 0.93, 1.0],
    },
    {
      'name': 'elasticOut',
      'desc': 'Elastic spring finish',
      'color': Colors.teal,
      'points': [0.0, 0.5, 1.1, 0.97, 1.0],
    },
  ];

  final curveCards = <Widget>[];
  for (final curve in curveEntries) {
    print('  Curve: ${curve['name']}');
    final points = curve['points'] as List<double>;
    final color = curve['color'] as Color;
    curveCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            // Curve name and description
            SizedBox(
              width: 85.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curve['name'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                  Text(
                    curve['desc'] as String,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            // Visual curve representation — opacity boxes
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(points.length, (i) {
                  final v = points[i].clamp(0.0, 1.0);
                  return Container(
                    width: 32.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: v),
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${(v * 100).toInt()}',
                        style: TextStyle(
                          fontSize: 8.0,
                          fontWeight: FontWeight.w600,
                          color: v > 0.5 ? Colors.white : color,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final curvesTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAOSectionHeader('Animation Curves', Icons.show_chart),
        const SizedBox(height: 8.0),
        Text(
          'The curve parameter controls the rate of opacity change '
          'over time. Different curves create different visual effects.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        // Column header
        Row(
          children: [
            const SizedBox(width: 85.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (i) {
                  final pct = i * 25;
                  return SizedBox(
                    width: 32.0,
                    child: Text(
                      't=$pct%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        ...curveCards,

        const SizedBox(height: 16.0),
        // Code example
        buildSAOSectionHeader('Using Curves in Code', Icons.code),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'SliverAnimatedOpacity(\n'
            '  opacity: _isVisible ? 1.0 : 0.0,\n'
            '  duration: Duration(milliseconds: 400),\n'
            '  curve: Curves.easeInOut,  // ← Try different curves\n'
            '  onEnd: () {\n'
            '    print("Fade complete!");\n'
            '  },\n'
            '  sliver: SliverToBoxAdapter(\n'
            '    child: Card(child: Text("Hello")),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveTab = _SAOLiveDemo();

  // ============================================================
  // SECTION 6: vs Alternatives
  // ============================================================
  print('=== Section 6: vs Alternatives ===');

  final alternatives = <Map<String, dynamic>>[
    {
      'name': 'AnimatedOpacity',
      'type': 'Box widget',
      'when': 'Fading a single box widget outside CustomScrollView.',
      'color': Colors.blue,
      'icon': Icons.crop_square,
    },
    {
      'name': 'SliverAnimatedOpacity',
      'type': 'Sliver wrapper',
      'when': 'Fading a sliver inside CustomScrollView with implicit anim.',
      'color': Colors.deepOrange,
      'icon': Icons.opacity,
    },
    {
      'name': 'SliverFadeTransition',
      'type': 'Sliver wrapper',
      'when': 'Fading a sliver with explicit AnimationController (more control).',
      'color': Colors.purple,
      'icon': Icons.animation,
    },
    {
      'name': 'SliverVisibility',
      'type': 'Sliver wrapper',
      'when': 'Toggling visibility on/off without animation. Removes from layout.',
      'color': Colors.green,
      'icon': Icons.visibility,
    },
    {
      'name': 'Opacity + SliverToBoxAdapter',
      'type': 'Box workaround',
      'when': 'Fading a single non-sliver widget as sliver content.',
      'color': Colors.grey,
      'icon': Icons.wrap_text,
    },
  ];

  final altCards = <Widget>[];
  for (final alt in alternatives) {
    print('  Alternative: ${alt['name']}');
    final color = alt['color'] as Color;
    altCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(11.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(alt['icon'] as IconData, size: 20.0, color: color),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        alt['name'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 1.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          alt['type'] as String,
                          style: TextStyle(
                            fontSize: 9.0,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    alt['when'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                      height: 1.3,
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

  final vsTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAOSectionHeader('Comparison: Opacity Widgets', Icons.compare),
        const SizedBox(height: 8.0),
        Text(
          'Flutter has several ways to control opacity. Choose the right '
          'one based on your context (box vs sliver) and animation needs '
          '(implicit vs explicit).',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...altCards,

        const SizedBox(height: 16.0),
        // Decision tree
        buildSAOSectionHeader('Decision Tree', Icons.fork_right),
        const SizedBox(height: 8.0),
        _buildSAODecisionTree(),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Progressive Disclosure',
      'desc': 'Fade in additional sliver content as the user progresses '
          'through a workflow. Step 1 content fades out, step 2 fades in.',
      'icon': Icons.expand,
      'color': Colors.blue,
      'visual': _SAOProgressiveDisclosureVisual(),
    },
    {
      'title': 'Loading Skeleton',
      'desc': 'Show a skeleton sliver at full opacity, then cross-fade '
          'to the real data sliver once loaded.',
      'icon': Icons.hourglass_empty,
      'color': Colors.orange,
      'visual': _SAOLoadingSkeletonVisual(),
    },
    {
      'title': 'Search Results Filter',
      'desc': 'Fade entire result sections in/out as filters are applied. '
          'E.g., a "Recent" sliver fades out when search is active.',
      'icon': Icons.search,
      'color': Colors.green,
      'visual': _SAOSearchFilterVisual(),
    },
    {
      'title': 'Multi-Section Reveal',
      'desc': 'Animate multiple sliver sections one by one with staggered '
          'delays for a cascading fade-in effect on page load.',
      'icon': Icons.view_agenda,
      'color': Colors.purple,
      'visual': _SAOStaggeredRevealVisual(),
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    print('  Use case: ${uc['title']}');
    final color = uc['color'] as Color;
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(uc['icon'] as IconData, size: 20.0, color: color),
                  const SizedBox(width: 8.0),
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                uc['desc'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
              ),
              child: uc['visual'] as Widget,
            ),
          ],
        ),
      ),
    );
  }

  final useCasesTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAOSectionHeader('Real-World Use Cases', Icons.lightbulb),
        const SizedBox(height: 14.0),
        ...useCaseWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.opacity,
      'text': 'SliverAnimatedOpacity wraps a child sliver and smoothly '
          'animates its opacity when the value changes.',
    },
    {
      'icon': Icons.animation,
      'text': 'It is an implicit animation — set the target opacity and '
          'duration, no AnimationController needed.',
    },
    {
      'icon': Icons.show_chart,
      'text': 'Use the curve parameter to control the easing. '
          'easeInOut provides a natural feel for most transitions.',
    },
    {
      'icon': Icons.layers,
      'text': 'The child must be a sliver widget. Wrap non-sliver content '
          'in SliverToBoxAdapter if needed.',
    },
    {
      'icon': Icons.speed,
      'text': 'At opacity 0 or 1, no compositing layer is created. '
          'Intermediate values create a layer — avoid animating too '
          'many slivers simultaneously.',
    },
    {
      'icon': Icons.compare,
      'text': 'Use SliverFadeTransition instead when you need explicit '
          'animation control (reverse, repeat, custom triggers).',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (final item in summaryPoints) {
    summaryWidgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 18.0,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                item['text'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey[800],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final summaryTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepOrange.withValues(alpha: 0.1),
                Colors.deepOrange.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Column(
            children: [
              Icon(Icons.summarize, size: 40.0, color: Colors.deepOrange),
              SizedBox(height: 8.0),
              Text(
                'SliverAnimatedOpacity — Key Takeaways',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...summaryWidgets,
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE TABS
  // ============================================================
  print('Assembling SliverAnimatedOpacity deep demo tabs');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.grey[50],
    ),
    home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SliverAnimatedOpacity Deep Demo'),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 2.0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
              Tab(icon: Icon(Icons.code), text: 'Constructor'),
              Tab(icon: Icon(Icons.gradient), text: 'Opacity'),
              Tab(icon: Icon(Icons.show_chart), text: 'Curves'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Live Demo'),
              Tab(icon: Icon(Icons.compare), text: 'vs Alternatives'),
              Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
              Tab(icon: Icon(Icons.summarize), text: 'Summary'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            conceptTab,
            constructorTab,
            opacityTab,
            curvesTab,
            liveTab,
            vsTab,
            useCasesTab,
            summaryTab,
          ],
        ),
      ),
    ),
  );
}

// ==================================================================
// Top-level helper functions
// ==================================================================

Widget buildSAOSectionHeader(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 20.0, color: Colors.deepOrange),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.deepOrange,
          ),
        ),
      ),
    ],
  );
}

Widget buildSAOBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          width: 6.0,
          height: 6.0,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSAOInfoRow(String title, String desc, Color color, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: color),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSAOFamilyTree() {
  final nodes = <Map<String, dynamic>>[
    {'label': 'ImplicitlyAnimatedWidget', 'indent': 0, 'color': Colors.grey},
    {'label': '├─ AnimatedOpacity (box)', 'indent': 1, 'color': Colors.blue},
    {'label': '├─ AnimatedContainer', 'indent': 1, 'color': Colors.grey},
    {'label': '└─ SliverAnimatedOpacity ★', 'indent': 1, 'color': Colors.deepOrange},
    {'label': '', 'indent': 0, 'color': Colors.grey},
    {'label': 'Related explicit versions:', 'indent': 0, 'color': Colors.grey},
    {'label': '├─ FadeTransition (box)', 'indent': 1, 'color': Colors.purple},
    {'label': '└─ SliverFadeTransition', 'indent': 1, 'color': Colors.purple},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nodes.map((n) {
        if ((n['label'] as String).isEmpty) {
          return const SizedBox(height: 8.0);
        }
        return Padding(
          padding: EdgeInsets.only(
            left: (n['indent'] as int) * 10.0,
            bottom: 3.0,
          ),
          child: Text(
            n['label'] as String,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: (n['label'] as String).contains('★')
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: n['color'] as Color,
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget _buildSAOTransitionDiagram() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.15)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSAOPhaseBlock('opacity: 1.0', Colors.deepOrange, 1.0),
            const Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey),
            _buildSAOPhaseBlock('Animating...', Colors.orange, 0.5),
            const Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey),
            _buildSAOPhaseBlock('opacity: 0.0', Colors.grey, 0.15),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, size: 14.0, color: Colors.grey[500]),
            const SizedBox(width: 4.0),
            Text(
              'Duration: 400ms  •  Curve: easeInOut',
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSAOPhaseBlock(String label, Color color, double alpha) {
  return Container(
    width: 82.0,
    height: 50.0,
    decoration: BoxDecoration(
      color: color.withValues(alpha: alpha * 0.3),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ),
  );
}

Widget _buildSAODecisionTree() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSAODecisionNode(
          'Inside CustomScrollView?',
          Colors.grey,
          isQuestion: true,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YES branch
            Expanded(
              child: Column(
                children: [
                  Text(
                    'YES',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.green[700],
                    ),
                  ),
                  _buildSAODecisionNode(
                    'Need explicit control?',
                    Colors.grey,
                    isQuestion: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('NO',
                                style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.w700)),
                            _buildSAODecisionNode(
                              'SliverAnimated\nOpacity',
                              Colors.deepOrange,
                              isQuestion: false,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('YES',
                                style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.orange[600],
                                    fontWeight: FontWeight.w700)),
                            _buildSAODecisionNode(
                              'SliverFade\nTransition',
                              Colors.purple,
                              isQuestion: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // NO branch
            Expanded(
              child: Column(
                children: [
                  Text(
                    'NO',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.red[700],
                    ),
                  ),
                  _buildSAODecisionNode(
                    'AnimatedOpacity\n(box widget)',
                    Colors.blue,
                    isQuestion: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSAODecisionNode(String label, Color color,
    {required bool isQuestion}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: isQuestion ? 0.06 : 0.12),
      borderRadius: BorderRadius.circular(isQuestion ? 6.0 : 4.0),
      border: Border.all(
        color: color.withValues(alpha: 0.3),
        width: isQuestion ? 1.0 : 1.5,
      ),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isQuestion ? 10.0 : 9.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ==================================================================
// Use-Case Visual Widgets
// ==================================================================

class _SAOProgressiveDisclosureVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSAOUseCaseState('Step 1 visible', [1.0, 0.0, 0.0]),
        const Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
        _buildSAOUseCaseState('Step 2 fading in', [0.3, 0.7, 0.0]),
        const Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
        _buildSAOUseCaseState('Step 2 visible', [0.0, 1.0, 0.0]),
      ],
    );
  }
}

class _SAOLoadingSkeletonVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSAODualState('Skeleton', 1.0, 'Data', 0.0, Colors.grey),
        const Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
        _buildSAODualState('Skeleton', 0.5, 'Data', 0.5, Colors.orange),
        const Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
        _buildSAODualState('Skeleton', 0.0, 'Data', 1.0, Colors.green),
      ],
    );
  }
}

class _SAOSearchFilterVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSAOFilterBox('Recent', 1.0, Colors.green),
            _buildSAOFilterBox('Popular', 1.0, Colors.blue),
            _buildSAOFilterBox('Nearby', 1.0, Colors.orange),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          'All visible → search active → Recent fades out',
          style: TextStyle(fontSize: 9.0, color: Colors.grey[500]),
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSAOFilterBox('Recent', 0.15, Colors.green),
            _buildSAOFilterBox('Popular', 1.0, Colors.blue),
            _buildSAOFilterBox('Nearby', 0.15, Colors.orange),
          ],
        ),
      ],
    );
  }
}

class _SAOStaggeredRevealVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (i) {
        final opacity = (i < 3) ? 1.0 : (i == 3 ? 0.5 : 0.1);
        return Column(
          children: [
            Text(
              'Section ${i + 1}',
              style: TextStyle(fontSize: 8.0, color: Colors.grey[500]),
            ),
            const SizedBox(height: 2.0),
            Container(
              width: 45.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: opacity * 0.3),
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(
                  color: Colors.purple.withValues(alpha: opacity * 0.5),
                ),
              ),
              child: Center(
                child: Text(
                  'α=${opacity.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 7.0,
                    color: Colors.purple.withValues(alpha: opacity),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _buildSAOUseCaseState(String label, List<double> opacities) {
  return Column(
    children: [
      ...opacities.asMap().entries.map((e) {
        return Container(
          width: 50.0,
          height: 14.0,
          margin: const EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: e.value * 0.4),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Center(
            child: Text(
              'S${e.key + 1}',
              style: TextStyle(
                fontSize: 7.0,
                color: Colors.blue.withValues(alpha: e.value),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
      const SizedBox(height: 2.0),
      Text(
        label,
        style: TextStyle(fontSize: 7.0, color: Colors.grey[500]),
      ),
    ],
  );
}

Widget _buildSAODualState(
  String topLabel,
  double topOpacity,
  String bottomLabel,
  double bottomOpacity,
  Color color,
) {
  return Column(
    children: [
      Container(
        width: 55.0,
        height: 18.0,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: topOpacity * 0.3),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Center(
          child: Text(
            topLabel,
            style: TextStyle(
              fontSize: 7.0,
              color: Colors.grey.withValues(alpha: topOpacity),
            ),
          ),
        ),
      ),
      const SizedBox(height: 2.0),
      Container(
        width: 55.0,
        height: 18.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: bottomOpacity * 0.3),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Center(
          child: Text(
            bottomLabel,
            style: TextStyle(
              fontSize: 7.0,
              color: color.withValues(alpha: bottomOpacity),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSAOFilterBox(String label, double opacity, Color color) {
  return Container(
    width: 65.0,
    height: 24.0,
    decoration: BoxDecoration(
      color: color.withValues(alpha: opacity * 0.2),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: opacity * 0.4)),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.0,
          fontWeight: FontWeight.w600,
          color: color.withValues(alpha: opacity),
        ),
      ),
    ),
  );
}

// ==================================================================
// Live Demo — Interactive SliverAnimatedOpacity
// ==================================================================
class _SAOLiveDemo extends StatefulWidget {
  @override
  State<_SAOLiveDemo> createState() => _SAOLiveDemoState();
}

class _SAOLiveDemoState extends State<_SAOLiveDemo> {
  double _opacity = 1.0;
  int _durationMs = 400;
  String _selectedCurve = 'easeInOut';
  bool _alwaysSemantics = false;
  String _statusText = 'Fully visible';

  final _curveMap = <String, Curve>{
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounceOut': Curves.bounceOut,
  };

  void _updateOpacity(double value) {
    setState(() {
      _opacity = value;
      if (_opacity == 0.0) {
        _statusText = 'Invisible (opacity = 0)';
      } else if (_opacity == 1.0) {
        _statusText = 'Fully visible (opacity = 1)';
      } else {
        _statusText = 'Animating to ${_opacity.toStringAsFixed(2)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls panel
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withValues(alpha: 0.04),
            border: Border(
              bottom: BorderSide(
                color: Colors.deepOrange.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Opacity slider
              Row(
                children: [
                  Text(
                    'Opacity:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _opacity,
                      min: 0.0,
                      max: 1.0,
                      divisions: 20,
                      activeColor: Colors.deepOrange,
                      onChanged: _updateOpacity,
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                    child: Text(
                      _opacity.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
              // Quick toggles
              Row(
                children: [
                  _buildSAOQuickBtn('0%', 0.0),
                  const SizedBox(width: 4.0),
                  _buildSAOQuickBtn('25%', 0.25),
                  const SizedBox(width: 4.0),
                  _buildSAOQuickBtn('50%', 0.5),
                  const SizedBox(width: 4.0),
                  _buildSAOQuickBtn('75%', 0.75),
                  const SizedBox(width: 4.0),
                  _buildSAOQuickBtn('100%', 1.0),
                ],
              ),
              const SizedBox(height: 8.0),
              // Duration
              Row(
                children: [
                  Text(
                    'Duration:',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ...[200, 400, 800, 1500].map((ms) {
                    final isSelected = ms == _durationMs;
                    return GestureDetector(
                      onTap: () => setState(() => _durationMs = ms),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.deepOrange
                              : Colors.deepOrange.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '${ms}ms',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected ? Colors.white : Colors.deepOrange,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 6.0),
              // Curve
              Row(
                children: [
                  Text(
                    'Curve:',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ..._curveMap.keys.map((name) {
                    final isSelected = name == _selectedCurve;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCurve = name),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.deepOrange
                              : Colors.deepOrange.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected ? Colors.white : Colors.deepOrange,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 6.0),
              // Semantics toggle
              Row(
                children: [
                  Text(
                    'alwaysIncludeSemantics:',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _alwaysSemantics = !_alwaysSemantics),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: _alwaysSemantics
                            ? Colors.green
                            : Colors.grey.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        _alwaysSemantics ? 'true' : 'false',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                          color: _alwaysSemantics
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _statusText,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // The actual demo scroll view
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Header sliver
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  color: Colors.deepOrange.withValues(alpha: 0.06),
                  child: const Text(
                    'This section is always visible (SliverToBoxAdapter)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),

              // Animated opacity section
              SliverAnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: _durationMs),
                curve: _curveMap[_selectedCurve] ?? Curves.easeInOut,
                alwaysIncludeSemantics: _alwaysSemantics,
                onEnd: () {
                  setState(() {
                    if (_opacity == 0.0) {
                      _statusText = 'Fade-out complete';
                    } else if (_opacity == 1.0) {
                      _statusText = 'Fade-in complete';
                    } else {
                      _statusText = 'Settled at ${_opacity.toStringAsFixed(2)}';
                    }
                  });
                },
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final colors = [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                        Colors.teal,
                      ];
                      final color = colors[index % colors.length];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 3.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: color.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.opacity, size: 18.0, color: color),
                            const SizedBox(width: 10.0),
                            Text(
                              'Animated Item ${index + 1}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 6,
                  ),
                ),
              ),

              // Footer sliver
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  color: Colors.indigo.withValues(alpha: 0.06),
                  child: const Text(
                    'This section is also always visible (below animated list)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSAOQuickBtn(String label, double value) {
    final isActive = (_opacity - value).abs() < 0.01;
    return Expanded(
      child: GestureDetector(
        onTap: () => _updateOpacity(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.deepOrange
                : Colors.deepOrange.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.deepOrange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
