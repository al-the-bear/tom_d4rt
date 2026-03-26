// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

/// CollapseMode Deep Demo
/// =====================
///
/// This demo comprehensively explores Flutter's CollapseMode enum,
/// which controls how the background of a FlexibleSpaceBar behaves
/// during scroll interactions within a SliverAppBar.
///
/// The three modes are:
/// - CollapseMode.parallax: Background scrolls slower than foreground (parallax effect)
/// - CollapseMode.pin: Background stays fixed in place
/// - CollapseMode.none: Background scrolls at the same speed as content

dynamic build(BuildContext context) {
  print('╔══════════════════════════════════════════════════════════════╗');
  print('║           CollapseMode Deep Demonstration                    ║');
  print('║  Exploring FlexibleSpaceBar Background Scroll Behaviors      ║');
  print('╚══════════════════════════════════════════════════════════════╝');

  // Define the three collapse modes for iteration
  final List<CollapseMode> allModes = [
    CollapseMode.parallax,
    CollapseMode.pin,
    CollapseMode.none,
  ];

  print('\n📋 Available CollapseMode values:');
  for (final mode in allModes) {
    print('   • ${mode.toString()}');
  }

  // Color schemes for each mode demonstration
  final Map<CollapseMode, List<Color>> modeGradients = {
    CollapseMode.parallax: [
      const Color(0xFF6366F1),
      const Color(0xFF8B5CF6),
      const Color(0xFFA855F7),
    ],
    CollapseMode.pin: [
      const Color(0xFF059669),
      const Color(0xFF10B981),
      const Color(0xFF34D399),
    ],
    CollapseMode.none: [
      const Color(0xFFDC2626),
      const Color(0xFFEF4444),
      const Color(0xFFF87171),
    ],
  };

  // Icons for each mode
  final Map<CollapseMode, IconData> modeIcons = {
    CollapseMode.parallax: Icons.layers,
    CollapseMode.pin: Icons.push_pin,
    CollapseMode.none: Icons.swap_vert,
  };

  // Detailed descriptions for each mode
  final Map<CollapseMode, String> modeDescriptions = {
    CollapseMode.parallax:
        'The background scrolls at a slower rate than the foreground content, '
        'creating a depth perception effect. This is the most commonly used mode '
        'for hero images and app bars with visual backgrounds.',
    CollapseMode.pin:
        'The background remains completely fixed in its position while '
        'the foreground content scrolls over it. Useful for backgrounds that '
        'should always remain fully visible until collapsed.',
    CollapseMode.none:
        'The background scrolls at exactly the same rate as the content, '
        'with no special effects. The background moves in lockstep with '
        'the scroll position, appearing attached to the content.',
  };

  // Use case examples for each mode
  final Map<CollapseMode, List<String>> modeUseCases = {
    CollapseMode.parallax: [
      'Photo gallery app headers',
      'Profile pages with cover images',
      'Product detail pages',
      'News article hero images',
      'Travel app destination headers',
    ],
    CollapseMode.pin: [
      'Maps with overlay content',
      'Video player backgrounds',
      'Dashboard headers with charts',
      'Settings pages with branding',
      'Fixed promotional banners',
    ],
    CollapseMode.none: [
      'Simple list headers',
      'Form section headers',
      'Minimal design apps',
      'Technical documentation',
      'Data-heavy interfaces',
    ],
  };

  print('\n🎨 Building visual demonstration widgets...');

  // Build mode explanation card widget
  Widget buildModeExplanationCard(CollapseMode mode) {
    final colors = modeGradients[mode]!;
    final icon = modeIcons[mode]!;
    final description = modeDescriptions[mode]!;
    final useCases = modeUseCases[mode]!;

    print('   Creating explanation card for: ${mode.name}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors[0].withOpacity(0.15), colors[2].withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors[1].withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: colors,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CollapseMode.${mode.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getModeTagline(mode),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Description section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: colors[1], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'How It Works',
                      style: TextStyle(
                        color: colors[0],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: colors[1], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Best Use Cases',
                      style: TextStyle(
                        color: colors[0],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...useCases.map(
                  (useCase) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: colors[1],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            useCase,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
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
    );
  }

  // Build visual scroll simulation widget
  Widget buildScrollSimulationWidget(CollapseMode mode) {
    final colors = modeGradients[mode]!;

    print('   Creating scroll simulation for: ${mode.name}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        children: [
          // Title bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors[0],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.phone_android,
                  color: Colors.white.withOpacity(0.9),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Scroll Behavior Preview: ${mode.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Simulation area
          Expanded(
            child: Stack(
              children: [
                // Background layer representation
                Positioned(
                  top: _getBackgroundPosition(mode, 0.3),
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colors[0].withOpacity(0.4),
                          colors[2].withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colors[1].withOpacity(0.5),
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: colors[1], size: 28),
                          const SizedBox(height: 4),
                          Text(
                            'BACKGROUND',
                            style: TextStyle(
                              color: colors[0],
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Foreground content representation
                Positioned(
                  top: 80,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.article,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Content Area',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMockTextLine(0.9, Colors.grey[300]!),
                                const SizedBox(height: 6),
                                _buildMockTextLine(0.7, Colors.grey[200]!),
                                const SizedBox(height: 6),
                                _buildMockTextLine(0.8, Colors.grey[200]!),
                                const SizedBox(height: 6),
                                _buildMockTextLine(0.5, Colors.grey[200]!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Scroll indicator arrow
                Positioned(
                  right: 10,
                  top: 60,
                  child: Column(
                    children: [
                      Icon(Icons.keyboard_arrow_up, color: colors[1], size: 24),
                      Container(
                        width: 3,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [colors[1], colors[2]],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colors[2],
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Behavior description
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors[0].withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.speed, color: colors[1], size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _getScrollBehaviorDescription(mode),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
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

  // Build code example widget
  Widget buildCodeExampleWidget(CollapseMode mode) {
    final colors = modeGradients[mode]!;
    final codeExample = _getCodeExample(mode);

    print('   Creating code example for: ${mode.name}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Code header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors[0].withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${mode.name}_example.dart',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Icon(Icons.code, color: colors[1], size: 18),
              ],
            ),
          ),
          // Code content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              codeExample,
              style: const TextStyle(
                color: Color(0xFFD4D4D4),
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build comparison matrix widget
  Widget buildComparisonMatrix() {
    print('   Creating comparison matrix widget...');

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF374151), Color(0xFF4B5563)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.compare_arrows, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Mode Comparison Matrix',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Property',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                ...allModes.map(
                  (mode) => Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        mode.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: modeGradients[mode]![0],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Comparison rows
          _buildComparisonRow('Scroll Speed', ['0.5x', '0x (fixed)', '1x']),
          _buildComparisonRow('Visual Depth', ['High', 'Medium', 'Low']),
          _buildComparisonRow('Performance', [
            'Optimized',
            'Optimized',
            'Optimized',
          ]),
          _buildComparisonRow('Common Use', ['Images', 'Maps/Video', 'Simple']),
          _buildComparisonRow('Complexity', ['Low', 'Low', 'Lowest']),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Build technical details section
  Widget buildTechnicalDetails() {
    print('   Creating technical details section...');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[50]!, Colors.purple[50]!],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[100]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.engineering,
                  color: Colors.blue[700],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Technical Implementation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A5F),
                      ),
                    ),
                    Text(
                      'How CollapseMode works under the hood',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTechnicalPoint(
            'Widget Tree Integration',
            'CollapseMode is a property of FlexibleSpaceBar, which is typically '
                'used as the flexibleSpace of a SliverAppBar widget. The mode '
                'affects how the background widget is positioned during scroll.',
            Icons.account_tree,
          ),
          const SizedBox(height: 16),
          _buildTechnicalPoint(
            'Scroll Controller Interaction',
            'The FlexibleSpaceBar listens to the scroll offset via the '
                'FlexibleSpaceBarSettings inherited widget. Based on the '
                'CollapseMode, it applies different transform calculations.',
            Icons.sync_alt,
          ),
          const SizedBox(height: 16),
          _buildTechnicalPoint(
            'Transform Calculations',
            'For parallax mode, the background offset is multiplied by a factor '
                '(typically 0.5). For pin mode, no transform is applied. For none '
                'mode, the full scroll offset is applied.',
            Icons.calculate,
          ),
          const SizedBox(height: 16),
          _buildTechnicalPoint(
            'Performance Considerations',
            'All three modes are highly optimized by Flutter. The transforms '
                'use hardware-accelerated layers when possible, ensuring smooth '
                '60fps scrolling on most devices.',
            Icons.speed,
          ),
        ],
      ),
    );
  }

  // Build interactive tips section
  Widget buildInteractiveTips() {
    print('   Creating interactive tips section...');

    final tips = [
      {
        'icon': Icons.lightbulb,
        'title': 'Choosing the Right Mode',
        'content':
            'Consider the content behind your FlexibleSpaceBar. Images benefit '
            'from parallax, maps from pin, and simple colors from none.',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.palette,
        'title': 'Design Consistency',
        'content':
            'Match your CollapseMode choice with your app\'s overall design '
            'language. Parallax suggests a modern, dynamic feel while none '
            'conveys simplicity.',
        'color': const Color(0xFFEC4899),
      },
      {
        'icon': Icons.memory,
        'title': 'Memory Usage',
        'content':
            'Large images in FlexibleSpaceBar backgrounds should be properly '
            'sized. Consider using ResizeImage or cacheWidth/cacheHeight to '
            'optimize memory.',
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.accessibility,
        'title': 'Accessibility',
        'content':
            'Ensure sufficient contrast between your FlexibleSpaceBar content '
            'and foreground UI elements. Test with various accessibility settings.',
        'color': const Color(0xFF6366F1),
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: tips.map((tip) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (tip['color'] as Color).withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: (tip['color'] as Color).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (tip['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    tip['icon'] as IconData,
                    color: tip['color'] as Color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip['title'] as String,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        tip['content'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Build summary footer
  Widget buildSummaryFooter() {
    print('   Creating summary footer...');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F2937), Color(0xFF374151)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF34D399), size: 48),
          const SizedBox(height: 16),
          const Text(
            'CollapseMode Demo Complete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'You\'ve explored all three collapse modes available in Flutter\'s '
            'FlexibleSpaceBar widget. Each mode offers unique visual behavior '
            'suited for different design requirements.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: allModes.map((mode) {
              final colors = modeGradients[mode]!;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [colors[0], colors[2]]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(modeIcons[mode], color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      mode.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Main widget tree assembly
  print('\n🔧 Assembling main widget tree...');

  final Widget mainContent = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'DEEP DEMO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'CollapseMode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Master the FlexibleSpaceBar background scroll behavior',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildHeaderStat('3', 'Modes'),
                    const SizedBox(width: 24),
                    _buildHeaderStat('∞', 'Possibilities'),
                    const SizedBox(width: 24),
                    _buildHeaderStat('0ms', 'Lag'),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Introduction section
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Understanding CollapseMode',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'CollapseMode is an enum in Flutter that determines how the '
                'background of a FlexibleSpaceBar behaves when the SliverAppBar '
                'collapses during scrolling. This is crucial for creating '
                'visually appealing app bar animations.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),

        // Mode explanation cards
        ...allModes.map((mode) => buildModeExplanationCard(mode)),

        // Section divider
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 24),
                  color: Colors.grey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'VISUAL SIMULATIONS',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(right: 24),
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),

        // Scroll simulations
        ...allModes.map((mode) => buildScrollSimulationWidget(mode)),

        // Section divider
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 24),
                  color: Colors.grey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'COMPARISON',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(right: 24),
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),

        // Comparison matrix
        buildComparisonMatrix(),

        // Section divider
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 24),
                  color: Colors.grey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'CODE EXAMPLES',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(right: 24),
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),

        // Code examples
        ...allModes.map((mode) => buildCodeExampleWidget(mode)),

        // Technical details
        buildTechnicalDetails(),

        // Tips section
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Pro Tips & Best Practices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),

        buildInteractiveTips(),

        // Summary footer
        buildSummaryFooter(),

        const SizedBox(height: 32),
      ],
    ),
  );

  print('\n✅ Widget tree assembly complete!');
  print('📊 Total sections: 7');
  print('🎯 Modes demonstrated: ${allModes.length}');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, fontFamily: 'SF Pro Display'),
    home: Scaffold(backgroundColor: const Color(0xFFF5F5F7), body: mainContent),
  );
}

// Helper function to get mode tagline
String _getModeTagline(CollapseMode mode) {
  switch (mode) {
    case CollapseMode.parallax:
      return 'Create depth with differential scrolling';
    case CollapseMode.pin:
      return 'Keep backgrounds stationary and visible';
    case CollapseMode.none:
      return 'Simple, synchronized scrolling behavior';
  }
}

// Helper function to calculate background position for simulation
double _getBackgroundPosition(CollapseMode mode, double scrollProgress) {
  switch (mode) {
    case CollapseMode.parallax:
      return 20 + (scrollProgress * 30); // Slower movement
    case CollapseMode.pin:
      return 20; // Fixed position
    case CollapseMode.none:
      return 20 + (scrollProgress * 60); // Full movement
  }
}

// Helper function to get scroll behavior description
String _getScrollBehaviorDescription(CollapseMode mode) {
  switch (mode) {
    case CollapseMode.parallax:
      return 'Background moves at ~50% of scroll speed, creating depth perception';
    case CollapseMode.pin:
      return 'Background remains fixed while content scrolls over it';
    case CollapseMode.none:
      return 'Background and content scroll together at the same speed';
  }
}

// Helper function to get code example
String _getCodeExample(CollapseMode mode) {
  switch (mode) {
    case CollapseMode.parallax:
      return '''SliverAppBar(
  expandedHeight: 200.0,
  floating: false,
  pinned: true,
  flexibleSpace: FlexibleSpaceBar(
    title: Text('Parallax Effect'),
    collapseMode: CollapseMode.parallax,
    background: Image.network(
      'https://example.com/hero.jpg',
      fit: BoxFit.cover,
    ),
  ),
)''';
    case CollapseMode.pin:
      return '''SliverAppBar(
  expandedHeight: 200.0,
  floating: false,
  pinned: true,
  flexibleSpace: FlexibleSpaceBar(
    title: Text('Pinned Background'),
    collapseMode: CollapseMode.pin,
    background: GoogleMap(
      initialCameraPosition: _position,
      // Map stays visible while content scrolls
    ),
  ),
)''';
    case CollapseMode.none:
      return '''SliverAppBar(
  expandedHeight: 200.0,
  floating: false,
  pinned: true,
  flexibleSpace: FlexibleSpaceBar(
    title: Text('Simple Header'),
    collapseMode: CollapseMode.none,
    background: Container(
      color: Colors.blue,
      // Scrolls at same speed as content
    ),
  ),
)''';
  }
}

// Helper function to build mock text line
Widget _buildMockTextLine(double widthFactor, Color color) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
    child: Container(
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}

// Helper function to build comparison row
Widget _buildComparisonRow(String property, List<String> values) {
  final colors = [
    const Color(0xFF6366F1),
    const Color(0xFF059669),
    const Color(0xFFDC2626),
  ];

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            property,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
        ),
        ...List.generate(values.length, (index) {
          return Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  values[index],
                  style: TextStyle(
                    color: colors[index],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    ),
  );
}

// Helper function to build technical point
Widget _buildTechnicalPoint(String title, String description, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue[600], size: 18),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E3A5F),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Helper function to build header stat
Widget _buildHeaderStat(String value, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
      ),
    ],
  );
}
