// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverConstrainedCrossAxis
// Demonstrates SliverConstrainedCrossAxis — a sliver that constrains
// the cross-axis extent of its child sliver to a maximum value.
// Useful for limiting content width inside CustomScrollView for
// readability, responsive design, and centered narrow layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverConstrainedCrossAxis Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.width_normal,
      'title': 'What Is SliverConstrainedCrossAxis?',
      'body': 'SliverConstrainedCrossAxis is a sliver that applies a '
          'maximum cross-axis extent to its child sliver. In a vertical '
          'CustomScrollView, this means limiting how wide the child '
          'content can be. The child sliver is centered within the '
          'remaining space.',
    },
    {
      'icon': Icons.straighten,
      'title': 'maxExtent Parameter',
      'body': 'The single key parameter is maxExtent — the maximum '
          'cross-axis size (in logical pixels) allowed for the child '
          'sliver. If the viewport is wider, the child is constrained '
          'and centered. If the viewport is narrower, the child uses '
          'the full available width.',
    },
    {
      'icon': Icons.center_focus_strong,
      'title': 'Centering Behavior',
      'body': 'When maxExtent constrains the child to be narrower than '
          'the viewport, the child is positioned at the center of the '
          'cross axis. This provides a natural centered-content layout '
          'without requiring explicit alignment wrappers.',
    },
    {
      'icon': Icons.devices,
      'title': 'Responsive Design',
      'body': 'SliverConstrainedCrossAxis is essential for responsive '
          'scrollable layouts. On wide screens (tablets, desktops), it '
          'prevents content from stretching uncomfortably wide. On '
          'narrow screens (phones), it has no effect — content uses '
          'the full width naturally.',
    },
    {
      'icon': Icons.text_format,
      'title': 'Readability',
      'body': 'Typography best practices recommend 45-75 characters per '
          'line for readability. SliverConstrainedCrossAxis lets you '
          'enforce a maximum content width to maintain comfortable '
          'reading line lengths without hardcoding layout sizes.',
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
          color: Colors.brown.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.brown.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.brown.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.brown,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade700,
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

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  Widget buildSCCAParam(
    String name,
    String type,
    String description,
    bool isRequired,
    Color accentColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accentColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: isRequired
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              isRequired ? 'REQUIRED' : 'OPTIONAL',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: isRequired ? Colors.red : Colors.green.shade700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: accentColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade700,
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

  final constructorParams = [
    buildSCCAParam(
      'maxExtent',
      'double',
      'The maximum cross-axis extent (e.g., maximum width in a '
          'vertical scroll). The child sliver will never be wider than '
          'this value.  Must be non-negative.',
      true,
      Colors.brown,
    ),
    buildSCCAParam(
      'sliver',
      'Widget',
      'The child sliver to constrain. Typically a SliverList, '
          'SliverGrid, SliverToBoxAdapter, or any other sliver widget.',
      true,
      Colors.brown,
    ),
    buildSCCAParam(
      'key',
      'Key?',
      'An optional key to identify this widget in the element tree.',
      false,
      Colors.brown,
    ),
  ];

  // Constructor code sample
  final constructorCode = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// Basic usage:',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.green,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverConstrainedCrossAxis(\n'
          '      maxExtent: 600.0,\n'
          '      sliver: SliverList(\n'
          '        delegate: SliverChildListDelegate([\n'
          '          // ... children\n'
          '        ]),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.white70,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Width Limiting
  // ============================================================
  print('=== Section 3: Width Limiting ===');

  // Build side-by-side comparison: unconstrained vs constrained
  Widget buildSCCAWidthDemo(
    String label,
    double? maxExtent,
    Color childColor,
  ) {
    final sliverContent = SliverToBoxAdapter(
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: childColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: childColor.withValues(alpha: 0.4)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.view_column, color: childColor, size: 24.0),
              const SizedBox(height: 4.0),
              Text(
                maxExtent == null
                    ? 'Full width (unconstrained)'
                    : 'maxExtent: ${maxExtent.toInt()}px',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: childColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final sliver = maxExtent != null
        ? SliverConstrainedCrossAxis(
            maxExtent: maxExtent,
            sliver: sliverContent,
          )
        : sliverContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: childColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: childColor,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          height: 90.0,
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [sliver],
          ),
        ),
      ],
    );
  }

  final widthDemos = [
    buildSCCAWidthDemo(
      'A) No Constraint — Full Width',
      null,
      Colors.blue,
    ),
    const SizedBox(height: 14.0),
    buildSCCAWidthDemo(
      'B) maxExtent: 300px — Narrow Column',
      300.0,
      Colors.green,
    ),
    const SizedBox(height: 14.0),
    buildSCCAWidthDemo(
      'C) maxExtent: 200px — Very Narrow',
      200.0,
      Colors.orange,
    ),
    const SizedBox(height: 14.0),
    buildSCCAWidthDemo(
      'D) maxExtent: 150px — Minimal',
      150.0,
      Colors.purple,
    ),
  ];

  print('Width limiting demos built (4 variations)');

  // ============================================================
  // SECTION 4: Responsive Layouts
  // ============================================================
  print('=== Section 4: Responsive Layouts ===');

  // Simulate different viewport widths with different maxExtent values
  final responsiveScenarios = <Map<String, dynamic>>[
    {
      'device': 'Phone (360px)',
      'viewport': 360,
      'maxExtent': 600,
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'note': 'maxExtent 600 > viewport 360 → no effect, full width used',
    },
    {
      'device': 'Tablet (768px)',
      'viewport': 768,
      'maxExtent': 600,
      'icon': Icons.tablet_android,
      'color': Colors.teal,
      'note': 'maxExtent 600 < viewport 768 → content constrained to 600px',
    },
    {
      'device': 'Desktop (1200px)',
      'viewport': 1200,
      'maxExtent': 600,
      'icon': Icons.desktop_windows,
      'color': Colors.indigo,
      'note': 'maxExtent 600 << viewport 1200 → content centered in 600px column',
    },
    {
      'device': 'Widescreen (1920px)',
      'viewport': 1920,
      'maxExtent': 600,
      'icon': Icons.tv,
      'color': Colors.deepPurple,
      'note': 'maxExtent 600 <<< viewport 1920 → narrow centered column',
    },
  ];

  final responsiveCards = <Widget>[];
  for (var i = 0; i < responsiveScenarios.length; i++) {
    final scenario = responsiveScenarios[i];
    final viewport = scenario['viewport'] as int;
    final maxExtent = scenario['maxExtent'] as int;
    final effectiveWidth = viewport < maxExtent ? viewport : maxExtent;
    final ratio = effectiveWidth / viewport;

    print('Responsive ${i + 1}: ${scenario['device']}');

    responsiveCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (scenario['color'] as Color).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (scenario['color'] as Color).withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  scenario['icon'] as IconData,
                  color: scenario['color'] as Color,
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    scenario['device'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: scenario['color'] as Color,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: (scenario['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '${(ratio * 100).toInt()}% used',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: scenario['color'] as Color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Visual viewport representation
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Stack(
                children: [
                  // Viewport label
                  Positioned(
                    right: 4.0,
                    top: 2.0,
                    child: Text(
                      '${viewport}px',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  // Content area
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: ratio,
                      child: Container(
                        decoration: BoxDecoration(
                          color: (scenario['color'] as Color)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: (scenario['color'] as Color)
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${effectiveWidth}px',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: scenario['color'] as Color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              scenario['note'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  // Interactive demo with different maxExtent values and sliver children

  final liveDemoWidget = _SCCALiveDemo();

  // ============================================================
  // SECTION 6: Nesting
  // ============================================================
  print('=== Section 6: Nesting ===');

  // Show how SliverConstrainedCrossAxis can be used alongside
  // unconstrained slivers in the same CustomScrollView

  final nestingDemo = Container(
    height: 400.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.brown.withValues(alpha: 0.2)),
    ),
    clipBehavior: Clip.antiAlias,
    child: CustomScrollView(
      slivers: [
        // Full-width header
        SliverToBoxAdapter(
          child: Container(
            height: 60.0,
            color: Colors.brown.withValues(alpha: 0.15),
            child: const Center(
              child: Text(
                'FULL-WIDTH HEADER — No Constraint',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
        ),

        // Constrained content section
        SliverConstrainedCrossAxis(
          maxExtent: 280.0,
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.article, color: Colors.blue, size: 28.0),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Constrained Content (280px)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'This section is wrapped in SliverConstrainedCrossAxis '
                      'with maxExtent: 280. It will be centered and never '
                      'wider than 280 logical pixels.',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: 0.15),
                  ),
                ),
                child: Text(
                  'Another constrained item in the same sliver list. '
                  'All items share the same 280px width.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8.0),
            ]),
          ),
        ),

        // Full-width divider
        SliverToBoxAdapter(
          child: Container(
            height: 40.0,
            color: Colors.grey.withValues(alpha: 0.08),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.0,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'FULL-WIDTH DIVIDER',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade500,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 40.0,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Different constrained width
        SliverConstrainedCrossAxis(
          maxExtent: 200.0,
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(14.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.view_compact,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    '200px Constrained',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Even narrower constraint',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Full-width footer
        SliverToBoxAdapter(
          child: Container(
            height: 50.0,
            color: Colors.brown.withValues(alpha: 0.1),
            child: const Center(
              child: Text(
                'FULL-WIDTH FOOTER — No Constraint',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Build nesting annotations
  final nestingAnnotations = <Map<String, dynamic>>[
    {
      'label': 'Header',
      'desc': 'SliverToBoxAdapter — no constraint, full viewport width',
      'color': Colors.brown,
    },
    {
      'label': 'Content',
      'desc': 'SliverConstrainedCrossAxis(maxExtent: 280) → SliverList with 2 items',
      'color': Colors.blue,
    },
    {
      'label': 'Divider',
      'desc': 'SliverToBoxAdapter — full width again',
      'color': Colors.grey,
    },
    {
      'label': 'Compact',
      'desc': 'SliverConstrainedCrossAxis(maxExtent: 200) → SliverToBoxAdapter',
      'color': Colors.green,
    },
    {
      'label': 'Footer',
      'desc': 'SliverToBoxAdapter — full width, closing section',
      'color': Colors.brown,
    },
  ];

  final nestingLegend = <Widget>[];
  for (final ann in nestingAnnotations) {
    nestingLegend.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: (ann['color'] as Color).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(
                  color: (ann['color'] as Color).withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${ann['label']}: ',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: ann['color'] as Color,
              ),
            ),
            Expanded(
              child: Text(
                ann['desc'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Nesting demo built');

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'icon': Icons.article_outlined,
      'title': 'Content Readability',
      'body': 'Blog posts, articles, documentation — limit the line length '
          'to 600-800px for comfortable reading on wide screens while '
          'allowing full width on phones.',
      'codeHint': 'SliverConstrainedCrossAxis(maxExtent: 700, sliver: articles)',
      'color': Colors.blue,
    },
    {
      'icon': Icons.assignment,
      'title': 'Form Layouts',
      'body': 'Forms feel awkward when stretched across a full desktop '
          'viewport. Constrain form slivers to 500-600px for a natural, '
          'focused input experience.',
      'codeHint': 'SliverConstrainedCrossAxis(maxExtent: 500, sliver: formSliver)',
      'color': Colors.green,
    },
    {
      'icon': Icons.dashboard,
      'title': 'Dashboard Cards',
      'body': 'In a scrollable dashboard, some card sections should be '
          'narrow while others span the full viewport. Mix constrained '
          'and unconstrained slivers freely.',
      'codeHint': 'SliverConstrainedCrossAxis(maxExtent: 400, sliver: cardGrid)',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.chat_bubble_outline,
      'title': 'Chat Messages',
      'body': 'On a tablet, chat messages look odd spanning the full width. '
          'Constrain the message list to a phone-like width while keeping '
          'the top bar and input full-width.',
      'codeHint': 'SliverConstrainedCrossAxis(maxExtent: 420, sliver: messages)',
      'color': Colors.purple,
    },
    {
      'icon': Icons.settings,
      'title': 'Settings Pages',
      'body': 'Settings lists with switches and toggles are cleaner when '
          'constrained. The user does not need to scan across a wide '
          'screen to read labels and tap controls.',
      'codeHint': 'SliverConstrainedCrossAxis(maxExtent: 550, sliver: settings)',
      'color': Colors.teal,
    },
  ];

  final useCaseCards = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    print('Use case ${i + 1}: ${uc['title']}');
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (uc['color'] as Color).withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: (uc['color'] as Color).withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9.0),
                  topRight: Radius.circular(9.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    uc['icon'] as IconData,
                    color: uc['color'] as Color,
                    size: 22.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      uc['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: uc['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['body'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      uc['codeHint'] as String,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.white70,
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

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  Widget buildSCCABullet(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final summaryBullets = [
    buildSCCABullet(
      Icons.check_circle_outline,
      'SliverConstrainedCrossAxis limits the cross-axis extent of '
          'its child sliver to a maximum value.',
      Colors.green,
    ),
    buildSCCABullet(
      Icons.check_circle_outline,
      'The child is centered when constrained to a width narrower '
          'than the viewport.',
      Colors.green,
    ),
    buildSCCABullet(
      Icons.check_circle_outline,
      'Has no effect when the viewport is already narrower than '
          'maxExtent — the child uses full viewport width naturally.',
      Colors.green,
    ),
    buildSCCABullet(
      Icons.check_circle_outline,
      'Mix constrained and unconstrained slivers in the same '
          'CustomScrollView for flexible responsive layouts.',
      Colors.green,
    ),
    buildSCCABullet(
      Icons.check_circle_outline,
      'Ideal for readability (limiting line length), forms, '
          'settings pages, and any content that looks best in a '
          'narrow centered column.',
      Colors.green,
    ),
    buildSCCABullet(
      Icons.warning_amber,
      'Only constrains the cross axis — has no effect on the main '
          'axis (scroll direction). For main axis limiting, use '
          'SliverToBoxAdapter with SizedBox.',
      Colors.orange,
    ),
    buildSCCABullet(
      Icons.warning_amber,
      'Works only with sliver children. To constrain a box widget, '
          'wrap it in SliverToBoxAdapter first, then constrain.',
      Colors.orange,
    ),
    buildSCCABullet(
      Icons.info_outline,
      'Combine with LayoutBuilder or MediaQuery for truly adaptive '
          'maxExtent values that change at breakpoints.',
      Colors.blue,
    ),
  ];

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverConstrainedCrossAxis Deep Demo'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Width Limiting'),
            Tab(text: 'Responsive'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Nesting'),
            Tab(text: 'Use Cases'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // ===== TAB 1: Concept =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.brown.withValues(alpha: 0.12),
                        Colors.brown.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.brown.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.width_normal,
                          color: Colors.brown,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'SliverConstrainedCrossAxis',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Limit the cross-axis extent of sliver content '
                        'for readable, responsive scrollable layouts.',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptCards,
                // Quick visual: constrained vs unconstrained
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Visual: Constrained vs Unconstrained',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // Unconstrained bar
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Unconstrained — uses full viewport width',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Constrained bar
                      Center(
                        child: Container(
                          width: 220.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.green.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Constrained — centered at maxExtent',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 2: Constructor =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.build_circle,
                        color: Colors.brown,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Constructor Parameters',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'SliverConstrainedCrossAxis has a minimal API — '
                        'just the maximum cross-axis extent.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...constructorParams,
                constructorCode,
                const SizedBox(height: 16.0),
                // Signature box
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Class Hierarchy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ..._buildHierarchyItems([
                        'Widget',
                        '  └─ RenderObjectWidget',
                        '      └─ SingleChildRenderObjectWidget',
                        '          └─ SliverConstrainedCrossAxis',
                      ]),
                      const SizedBox(height: 10.0),
                      Text(
                        'Like other layout slivers, SliverConstrainedCrossAxis '
                        'is a single-child render object widget that delegates '
                        'to a custom RenderObject (RenderSliverConstrainedCrossAxis) '
                        'to enforce the cross-axis constraint.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 3: Width Limiting =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.straighten,
                        color: Colors.brown,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Width Limiting in Action',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'See how different maxExtent values constrain '
                        'a sliver to progressively narrower widths.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...widthDemos,
                const SizedBox(height: 16.0),
                // Explanation card
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.lightbulb_outline,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'How It Works',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '1. SliverConstrainedCrossAxis receives the viewport '
                        'constraints from its parent.\n'
                        '2. It modifies the cross-axis extent of those constraints:\n'
                        '   crossAxisExtent = min(maxExtent, parent.crossAxisExtent)\n'
                        '3. The modified constraints are passed to the child sliver.\n'
                        '4. The child lays out within the narrower constraints.\n'
                        '5. The RenderObject centers the child in the remaining space.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 4: Responsive ======
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.devices,
                        color: Colors.brown,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Responsive Behavior',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'How maxExtent: 600 behaves across different '
                        'viewport widths — from phone to widescreen.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...responsiveCards,
                const SizedBox(height: 12.0),
                // Adaptive maxExtent pattern
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.indigo.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.indigo,
                            size: 20.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Adaptive maxExtent Pattern',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'You can combine SliverConstrainedCrossAxis '
                        'with MediaQuery or LayoutBuilder to use different '
                        'maxExtent values at different breakpoints:',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          'final width = MediaQuery.of(context).size.width;\n'
                          'final maxExtent = width > 1200 ? 800.0\n'
                          '    : width > 768 ? 600.0\n'
                          '    : double.infinity;\n\n'
                          'SliverConstrainedCrossAxis(\n'
                          '  maxExtent: maxExtent,\n'
                          '  sliver: contentSliver,\n'
                          ')',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontFamily: 'monospace',
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'This creates a truly adaptive layout that constrains '
                        'content only when there is enough viewport space.',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Breakpoint table
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Common Breakpoints & Recommended maxExtent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // Table header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        color: Colors.brown.withValues(alpha: 0.08),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 80.0,
                              child: Text(
                                'Device',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70.0,
                              child: Text(
                                'Width',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Recommended maxExtent',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ..._buildBreakpointRows(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 5: Live Demo =====
          liveDemoWidget,

          // ===== TAB 6: Nesting =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.layers,
                        color: Colors.brown,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Nesting: Mixed-Width Slivers',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Constrained and unconstrained slivers in the '
                        'same CustomScrollView create flexible layouts.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                nestingDemo,
                const SizedBox(height: 16.0),
                const Text(
                  'Sliver Structure:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 8.0),
                ...nestingLegend,
                const SizedBox(height: 16.0),
                // Tree visualization
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Widget Tree:',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'CustomScrollView\n'
                        '├── SliverToBoxAdapter (header)\n'
                        '│   └── Container [full width]\n'
                        '├── SliverConstrainedCrossAxis(280)\n'
                        '│   └── SliverList\n'
                        '│       ├── Container [280px max]\n'
                        '│       └── Container [280px max]\n'
                        '├── SliverToBoxAdapter (divider)\n'
                        '│   └── Container [full width]\n'
                        '├── SliverConstrainedCrossAxis(200)\n'
                        '│   └── SliverToBoxAdapter\n'
                        '│       └── Container [200px max]\n'
                        '└── SliverToBoxAdapter (footer)\n'
                        '    └── Container [full width]',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Tips for nesting
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.teal.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.tips_and_updates,
                            color: Colors.teal,
                            size: 20.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Nesting Patterns',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      _buildNestingTip(
                        'Full-width headers + constrained content',
                        'The most common pattern. Headers, navigation bars, '
                            'and banners span the full viewport while the main '
                            'content column is constrained.',
                        Colors.teal,
                      ),
                      _buildNestingTip(
                        'Multiple constraint widths',
                        'Different sections can have different maxExtent '
                            'values. A form section might be 500px while a '
                            'content section is 700px.',
                        Colors.teal,
                      ),
                      _buildNestingTip(
                        'Nesting constrained slivers',
                        'SliverConstrainedCrossAxis can wrap other '
                            'constraint slivers. The tightest constraint wins.',
                        Colors.teal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 7: Use Cases =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: Colors.brown,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Practical Use Cases',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Real-world scenarios where SliverConstrainedCrossAxis '
                        'improves layout quality and user experience.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...useCaseCards,
                const SizedBox(height: 12.0),
                // When NOT to use
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.do_not_disturb, color: Colors.red, size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'When NOT to Use',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      _buildDontUseItem(
                        'Non-sliver contexts',
                        'For regular box widgets, use ConstrainedBox or '
                            'Container with constraints instead.',
                      ),
                      _buildDontUseItem(
                        'Main-axis limiting',
                        'This widget only constrains the cross axis. For '
                            'main-axis (scroll direction) limiting, use '
                            'SizedBox in SliverToBoxAdapter.',
                      ),
                      _buildDontUseItem(
                        'When you need padding, not constraining',
                        'If you want margins around slivers, use '
                            'SliverPadding instead.',
                      ),
                      _buildDontUseItem(
                        'Fixed layouts',
                        'If the layout is never wider than maxExtent, '
                            'the constraint does nothing. Only useful when '
                            'the viewport can exceed the limit.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Alternatives comparison table
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alternatives Comparison',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildComparisonRow(
                        'SliverConstrainedCrossAxis',
                        'Sliver',
                        'Cross-axis max',
                        'Centers child',
                        true,
                      ),
                      _buildComparisonRow(
                        'SliverPadding',
                        'Sliver',
                        'Insets only',
                        'Adds space',
                        false,
                      ),
                      _buildComparisonRow(
                        'ConstrainedBox',
                        'Box',
                        'Min/max w/h',
                        'Not sliver-aware',
                        false,
                      ),
                      _buildComparisonRow(
                        'Container',
                        'Box',
                        'Width/height',
                        'Wrap in adapter',
                        false,
                      ),
                      _buildComparisonRow(
                        'SliverCrossAxisGroup',
                        'Sliver',
                        'Multiple slivers',
                        'Side by side',
                        false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 8: Summary =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.brown.withValues(alpha: 0.12),
                        Colors.brown.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.brown,
                        size: 32.0,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Key takeaways for SliverConstrainedCrossAxis',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryBullets,
                const SizedBox(height: 16.0),
                // Quick reference card
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.brown.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Reference',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildRefRow('Type', 'SingleChildRenderObjectWidget (sliver)'),
                      _buildRefRow('Key param', 'maxExtent (required, double)'),
                      _buildRefRow('Child', 'A sliver widget'),
                      _buildRefRow('Centering', 'Automatic when constrained'),
                      _buildRefRow('Main axis', 'Unaffected'),
                      _buildRefRow('Render object', 'RenderSliverConstrainedCrossAxis'),
                      _buildRefRow('Common use', 'Readable content columns'),
                      _buildRefRow('Since', 'Flutter 3.7'),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Decision tree
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.teal.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.fork_right, color: Colors.teal, size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Decision Flow',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      _buildDecisionStep(
                        1,
                        'Need to limit width in a scrollable?',
                        'Yes → Continue',
                        Colors.teal,
                      ),
                      _buildDecisionStep(
                        2,
                        'Using CustomScrollView with slivers?',
                        'Yes → Use SliverConstrainedCrossAxis',
                        Colors.teal,
                      ),
                      _buildDecisionStep(
                        3,
                        'Using ListView or other non-sliver scrollable?',
                        'Wrap content in ConstrainedBox or Container',
                        Colors.blue,
                      ),
                      _buildDecisionStep(
                        4,
                        'Need padding instead of constraining?',
                        'Use SliverPadding instead',
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // Final note
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'SliverConstrainedCrossAxis — '
                      'Simple, essential, responsive.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                        fontStyle: FontStyle.italic,
                      ),
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

// ================================================================
// LIVE DEMO (Interactive Stateful Widget)
// ================================================================

class _SCCALiveDemo extends StatefulWidget {
  @override
  State<_SCCALiveDemo> createState() => _SCCALiveDemoState();
}

class _SCCALiveDemoState extends State<_SCCALiveDemo> {
  double _maxExtent = 300.0;
  int _itemCount = 6;
  bool _useGrid = false;
  bool _showBorder = true;

  @override
  Widget build(BuildContext context) {
    print('Live demo build: maxExtent=$_maxExtent, items=$_itemCount, '
        'grid=$_useGrid, border=$_showBorder');

    // Build the child sliver based on mode
    Widget childSliver;
    if (_useGrid) {
      childSliver = SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final hue = (index * 37.0) % 360.0;
            final itemColor = HSVColor.fromAHSV(1.0, hue, 0.4, 0.9).toColor();
            return Container(
              decoration: BoxDecoration(
                color: itemColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: itemColor.withValues(alpha: 0.5),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.grid_view,
                      color: itemColor,
                      size: 18.0,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Grid ${index + 1}',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: itemColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: _itemCount,
        ),
      );
    } else {
      childSliver = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final hue = (index * 43.0) % 360.0;
            final itemColor = HSVColor.fromAHSV(1.0, hue, 0.35, 0.85).toColor();
            return Container(
              margin: const EdgeInsets.only(bottom: 6.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: itemColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: itemColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: itemColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: itemColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'List item ${index + 1} — constrained to '
                      '${_maxExtent.toInt()}px max',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: itemColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: _itemCount,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Controls
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.brown.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.brown.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Controls',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 12.0),
                // maxExtent slider
                Row(
                  children: [
                    SizedBox(
                      width: 90.0,
                      child: Text(
                        'maxExtent:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _maxExtent,
                        min: 100.0,
                        max: 500.0,
                        divisions: 16,
                        activeColor: Colors.brown,
                        label: '${_maxExtent.toInt()}px',
                        onChanged: (v) => setState(() => _maxExtent = v),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${_maxExtent.toInt()}px',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Item count
                Row(
                  children: [
                    SizedBox(
                      width: 90.0,
                      child: Text(
                        'Items:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _itemCount.toDouble(),
                        min: 1.0,
                        max: 15.0,
                        divisions: 14,
                        activeColor: Colors.brown,
                        label: '$_itemCount',
                        onChanged: (v) =>
                            setState(() => _itemCount = v.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '$_itemCount',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Toggle row
                Row(
                  children: [
                    // Grid vs List toggle
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _useGrid = !_useGrid),
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: (_useGrid
                                    ? Colors.teal
                                    : Colors.grey)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: (_useGrid
                                      ? Colors.teal
                                      : Colors.grey)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _useGrid
                                    ? Icons.grid_view
                                    : Icons.list,
                                size: 16.0,
                                color: _useGrid
                                    ? Colors.teal
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                _useGrid ? 'Grid Mode' : 'List Mode',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: _useGrid
                                      ? Colors.teal
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    // Show border toggle
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            setState(() => _showBorder = !_showBorder),
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: (_showBorder
                                    ? Colors.indigo
                                    : Colors.grey)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: (_showBorder
                                      ? Colors.indigo
                                      : Colors.grey)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _showBorder
                                    ? Icons.border_outer
                                    : Icons.border_clear,
                                size: 16.0,
                                color: _showBorder
                                    ? Colors.indigo
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                _showBorder
                                    ? 'Border On'
                                    : 'Border Off',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: _showBorder
                                      ? Colors.indigo
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Scrollable area with the constrained sliver
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: _showBorder
                    ? Border.all(
                        color: Colors.brown.withValues(alpha: 0.2),
                      )
                    : null,
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: [
                  // Header showing full width
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.grey.withValues(alpha: 0.06),
                      child: Center(
                        child: Text(
                          'Full Viewport Width',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Constrained content
                  SliverConstrainedCrossAxis(
                    maxExtent: _maxExtent,
                    sliver: childSliver,
                  ),
                  // Footer showing full width again
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.grey.withValues(alpha: 0.06),
                      child: Center(
                        child: Text(
                          'Full Viewport Width Again',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          // Info footer
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.amber.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: Colors.amber,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Drag the maxExtent slider to see how the constrained '
                    'area changes. Switch between list and grid mode. The '
                    'content is always centered within the viewport.',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
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

// ================================================================
// HELPER FUNCTIONS
// ================================================================

List<Widget> _buildHierarchyItems(List<String> items) {
  return items.map((item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        item,
        style: TextStyle(
          fontSize: 11.5,
          fontFamily: 'monospace',
          color: item.contains('SliverConstrainedCrossAxis')
              ? Colors.brown
              : Colors.grey.shade700,
          fontWeight: item.contains('SliverConstrainedCrossAxis')
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }).toList();
}

List<Widget> _buildBreakpointRows() {
  final rows = <Map<String, String>>[
    {'device': 'Phone', 'width': '<600px', 'max': 'Not needed'},
    {'device': 'Small tab', 'width': '600-900px', 'max': '500-600px'},
    {'device': 'Large tab', 'width': '900-1200px', 'max': '600-800px'},
    {'device': 'Desktop', 'width': '1200-1600px', 'max': '700-900px'},
    {'device': 'Wide', 'width': '>1600px', 'max': '800-1000px'},
  ];

  return rows
      .asMap()
      .entries
      .map((entry) {
        final row = entry.value;
        final isEven = entry.key % 2 == 0;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          color: isEven
              ? Colors.brown.withValues(alpha: 0.02)
              : Colors.transparent,
          child: Row(
            children: [
              SizedBox(
                width: 80.0,
                child: Text(
                  row['device']!,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                width: 70.0,
                child: Text(
                  row['width']!,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  row['max']!,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade600,
                  ),
                ),
              ),
            ],
          ),
        );
      })
      .toList();
}

Widget _buildNestingTip(String title, String body, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.arrow_right, size: 18.0, color: color),
        const SizedBox(width: 4.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
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

Widget _buildDontUseItem(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.close, size: 16.0, color: Colors.red),
        const SizedBox(width: 6.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
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

Widget _buildComparisonRow(
  String widget,
  String type,
  String constraint,
  String behavior,
  bool isHighlighted,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    margin: const EdgeInsets.only(bottom: 2.0),
    decoration: BoxDecoration(
      color: isHighlighted
          ? Colors.brown.withValues(alpha: 0.06)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            widget,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight:
                  isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted ? Colors.brown : Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            constraint,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            behavior,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecisionStep(
  int step,
  String question,
  String answer,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                '→ $answer',
                style: TextStyle(
                  fontSize: 11.0,
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
