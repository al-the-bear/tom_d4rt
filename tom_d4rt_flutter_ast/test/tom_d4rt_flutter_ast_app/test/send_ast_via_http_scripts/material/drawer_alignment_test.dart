// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// **DrawerAlignment Deep Demo**
///
/// This demonstration explores the DrawerAlignment enum, which controls
/// whether a drawer slides in from the start or end of the screen.
/// Understanding alignment is crucial for proper app architecture,
/// especially when supporting both LTR and RTL languages.
///
/// **Key Concept:**
/// - DrawerAlignment.start → Left side in LTR, Right side in RTL
/// - DrawerAlignment.end → Right side in LTR, Left side in RTL
///
/// The alignment follows the logical reading direction, not absolute
/// screen positions. This ensures consistent UX across all locales.

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'DrawerAlignment Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1565C0),
        brightness: Brightness.light,
      ),
    ),
    home: const DrawerAlignmentShowcase(),
  );
}

/// Main showcase widget demonstrating all aspects of DrawerAlignment
class DrawerAlignmentShowcase extends StatelessWidget {
  const DrawerAlignmentShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFF90CAF9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildConceptOverview(),
                const SizedBox(height: 32),
                _buildAlignmentEnumSection(),
                const SizedBox(height: 32),
                _buildLtrLayoutDiagram(),
                const SizedBox(height: 32),
                _buildRtlLayoutDiagram(),
                const SizedBox(height: 32),
                _buildScaffoldMockupSection(),
                const SizedBox(height: 32),
                _buildUseCasesSection(),
                const SizedBox(height: 32),
                _buildAccessibilitySection(),
                const SizedBox(height: 32),
                _buildCodeExamplesSection(),
                const SizedBox(height: 32),
                _buildBestPracticesSection(),
                const SizedBox(height: 40),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header with title and introduction
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_open,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DrawerAlignment',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Flutter Material Library',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'DrawerAlignment determines which side of the Scaffold a drawer '
              'appears on. It uses logical positioning (start/end) rather than '
              'absolute positioning (left/right) to properly support RTL layouts.',
              style: TextStyle(fontSize: 15, color: Colors.white, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  /// Overview of the concept
  Widget _buildConceptOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Understanding Logical Positioning',
            Icons.lightbulb_outline,
          ),
          const SizedBox(height: 16),
          const Text(
            'In Flutter, "start" and "end" are logical directions that adapt to '
            'the current text direction (TextDirection). This is fundamental for '
            'building apps that work correctly in both LTR (English, French, German) '
            'and RTL (Arabic, Hebrew, Persian) locales.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildDirectionCard(
                  'LTR',
                  'Start = Left\nEnd = Right',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDirectionCard(
                  'RTL',
                  'Start = Right\nEnd = Left',
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFB74D)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFFE65100)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Always use logical positioning (start/end) instead of '
                    'absolute positioning (left/right) for RTL compatibility.',
                    style: TextStyle(fontSize: 14, color: Color(0xFFE65100)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionCard(
    String direction,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            direction,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: color.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Section showing the enum values
  Widget _buildAlignmentEnumSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('DrawerAlignment Enum Values', Icons.code),
          const SizedBox(height: 16),
          _buildEnumValueCard(
            'DrawerAlignment.start',
            'The drawer slides in from the start edge of the screen. '
                'This is the default alignment for the main navigation drawer.',
            Icons.arrow_back,
            const Color(0xFF2E7D32),
          ),
          const SizedBox(height: 12),
          _buildEnumValueCard(
            'DrawerAlignment.end',
            'The drawer slides in from the end edge of the screen. '
                'Typically used for secondary drawers like settings or filters.',
            Icons.arrow_forward,
            const Color(0xFF7B1FA2),
          ),
        ],
      ),
    );
  }

  Widget _buildEnumValueCard(
    String name,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF616161),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Visual diagram for LTR layout
  Widget _buildLtrLayoutDiagram() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'LTR Layout (Left-to-Right)',
            Icons.format_textdirection_l_to_r,
          ),
          const SizedBox(height: 8),
          const Text(
            'In LTR languages like English, reading flows from left to right.',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 20),
          _buildLayoutDiagram(
            isRtl: false,
            startLabel: 'START\n(Left)',
            endLabel: 'END\n(Right)',
            startColor: const Color(0xFF2E7D32),
            endColor: const Color(0xFF7B1FA2),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildLegendItem(
                'DrawerAlignment.start',
                const Color(0xFF2E7D32),
              ),
              const SizedBox(width: 24),
              _buildLegendItem('DrawerAlignment.end', const Color(0xFF7B1FA2)),
            ],
          ),
        ],
      ),
    );
  }

  /// Visual diagram for RTL layout
  Widget _buildRtlLayoutDiagram() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'RTL Layout (Right-to-Left)',
            Icons.format_textdirection_r_to_l,
          ),
          const SizedBox(height: 8),
          const Text(
            'In RTL languages like Arabic and Hebrew, reading flows from right to left.',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 20),
          _buildLayoutDiagram(
            isRtl: true,
            startLabel: 'START\n(Right)',
            endLabel: 'END\n(Left)',
            startColor: const Color(0xFF2E7D32),
            endColor: const Color(0xFF7B1FA2),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF81C784)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF2E7D32),
                  size: 22,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Notice how the same DrawerAlignment values produce different '
                    'physical positions based on text direction!',
                    style: TextStyle(fontSize: 13, color: Color(0xFF2E7D32)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutDiagram({
    required bool isRtl,
    required String startLabel,
    required String endLabel,
    required Color startColor,
    required Color endColor,
  }) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          // Left drawer area
          Container(
            width: 80,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (isRtl ? endColor : startColor).withOpacity(0.3),
                  (isRtl ? endColor : startColor).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isRtl ? endColor : startColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.vertical_split,
                    color: isRtl ? endColor : startColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isRtl ? endLabel : startLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isRtl ? endColor : startColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content area
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFBDBDBD)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'MAIN CONTENT',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isRtl ? Icons.arrow_back : Icons.arrow_forward,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isRtl
                            ? 'RTL Reading Direction'
                            : 'LTR Reading Direction',
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Right drawer area
          Container(
            width: 80,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (isRtl ? startColor : endColor).withOpacity(0.1),
                  (isRtl ? startColor : endColor).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isRtl ? startColor : endColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.vertical_split,
                    color: isRtl ? startColor : endColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isRtl ? startLabel : endLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isRtl ? startColor : endColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Scaffold mockups showing drawer positions
  Widget _buildScaffoldMockupSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Scaffold with Drawer & EndDrawer',
            Icons.dashboard,
          ),
          const SizedBox(height: 8),
          const Text(
            'A Scaffold can have both a drawer (start) and an endDrawer simultaneously.',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 20),
          _buildScaffoldMockup(),
          const SizedBox(height: 20),
          _buildPropertyTable(),
        ],
      ),
    );
  }

  Widget _buildScaffoldMockup() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF37474F).withOpacity(0.05),
            const Color(0xFF37474F).withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF37474F).withOpacity(0.2)),
      ),
      child: Stack(
        children: [
          // Main scaffold
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // App bar
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1565C0),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'App Title',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  // Body
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.swipe, size: 40, color: Colors.grey[300]),
                          const SizedBox(height: 8),
                          Text(
                            'Swipe from edges to open drawers',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Start drawer indicator
          Positioned(
            left: 0,
            top: 40,
            bottom: 40,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2E7D32).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
            ),
          ),
          // Start drawer label
          Positioned(
            left: 16,
            top: 80,
            child: _buildDrawerLabel(
              'drawer\n(start)',
              const Color(0xFF2E7D32),
            ),
          ),
          // End drawer indicator
          Positioned(
            right: 0,
            top: 40,
            bottom: 40,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF7B1FA2),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7B1FA2).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(-2, 0),
                  ),
                ],
              ),
            ),
          ),
          // End drawer label
          Positioned(
            right: 16,
            top: 80,
            child: _buildDrawerLabel(
              'endDrawer\n(end)',
              const Color(0xFF7B1FA2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildPropertyTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Scaffold Property',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Alignment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Position (LTR)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          _buildTableRow('drawer', 'start', 'Left edge', false),
          _buildTableRow('endDrawer', 'end', 'Right edge', true),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    String property,
    String alignment,
    String position,
    bool isLast,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              property,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF1565C0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(alignment, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              position,
              style: const TextStyle(fontSize: 13, color: Color(0xFF616161)),
            ),
          ),
        ],
      ),
    );
  }

  /// Use cases section
  Widget _buildUseCasesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Common Use Cases', Icons.cases_outlined),
          const SizedBox(height: 16),
          _buildUseCaseCard(
            icon: Icons.menu,
            title: 'Navigation Drawer (Start)',
            description:
                'Primary app navigation with menu items, user profile, '
                'and section links. Opened via hamburger menu icon.',
            alignment: 'DrawerAlignment.start',
            color: const Color(0xFF2E7D32),
            examples: ['Main menu', 'Section navigation', 'User account'],
          ),
          const SizedBox(height: 16),
          _buildUseCaseCard(
            icon: Icons.tune,
            title: 'Settings/Filter Drawer (End)',
            description:
                'Secondary actions like filters, settings, or additional '
                'options. Provides contextual controls without leaving current view.',
            alignment: 'DrawerAlignment.end',
            color: const Color(0xFF7B1FA2),
            examples: ['Filters panel', 'Settings', 'Shopping cart'],
          ),
          const SizedBox(height: 16),
          _buildUseCaseCard(
            icon: Icons.dashboard_customize,
            title: 'Dual Drawer Layout',
            description:
                'Combine both drawers for complex apps: main navigation '
                'on start, contextual options on end. Common in productivity apps.',
            alignment: 'Both alignments',
            color: const Color(0xFFE65100),
            examples: ['Email clients', 'IDEs', 'File managers'],
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseCard({
    required IconData icon,
    required String title,
    required String description,
    required String alignment,
    required Color color,
    required List<String> examples,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        alignment,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF616161),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: examples.map((example) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  example,
                  style: TextStyle(fontSize: 12, color: color),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Accessibility section
  Widget _buildAccessibilitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF00897B).withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00897B).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Accessibility & UX Considerations',
            Icons.accessibility_new,
          ),
          const SizedBox(height: 16),
          _buildAccessibilityItem(
            Icons.touch_app,
            'Gesture Support',
            'Both drawers support edge-swipe gestures for opening. Ensure '
                'sufficient edge width for comfortable interaction.',
          ),
          const SizedBox(height: 12),
          _buildAccessibilityItem(
            Icons.language,
            'RTL Automatic Handling',
            'Flutter automatically mirrors drawer positions in RTL locales. '
                'No extra code needed when using logical alignment.',
          ),
          const SizedBox(height: 12),
          _buildAccessibilityItem(
            Icons.record_voice_over,
            'Screen Reader Support',
            'Drawers are announced properly by screen readers. Use semantic '
                'labels for drawer items to improve navigation.',
          ),
          const SizedBox(height: 12),
          _buildAccessibilityItem(
            Icons.keyboard,
            'Keyboard Navigation',
            'Drawers can be opened/closed with keyboard shortcuts and '
                'support tab navigation through items.',
          ),
          const SizedBox(height: 12),
          _buildAccessibilityItem(
            Icons.smartphone,
            'One-Handed Use',
            'Consider which hand most users operate their device with. '
                'Start drawer is easier to reach with left thumb.',
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilityItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF00897B).withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF00897B), size: 20),
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
                  color: Color(0xFF00695C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Code examples section
  Widget _buildCodeExamplesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Implementation Examples', Icons.code),
          const SizedBox(height: 16),
          _buildCodeBlock('Basic Scaffold with Both Drawers', '''Scaffold(
  appBar: AppBar(title: Text('My App')),
  drawer: Drawer(
    // DrawerAlignment.start (default)
    child: ListView(
      children: [
        DrawerHeader(...),
        ListTile(title: Text('Home')),
        ListTile(title: Text('Profile')),
      ],
    ),
  ),
  endDrawer: Drawer(
    // DrawerAlignment.end
    child: ListView(
      children: [
        ListTile(title: Text('Settings')),
        ListTile(title: Text('Help')),
      ],
    ),
  ),
  body: Center(child: Text('Content')),
)'''),
          const SizedBox(height: 20),
          _buildCodeBlock(
            'Programmatically Opening Drawers',
            '''// Open start drawer
Scaffold.of(context).openDrawer();

// Open end drawer  
Scaffold.of(context).openEndDrawer();

// Check if drawer is open
final isDrawerOpen = 
  Scaffold.of(context).isDrawerOpen;

// Close any open drawer
Navigator.of(context).pop();''',
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFB2EBF2),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Best practices section
  Widget _buildBestPracticesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Best Practices', Icons.star_outline),
          const SizedBox(height: 16),
          _buildBestPracticeItem(
            '✓',
            'Use start drawer for primary navigation',
            'Users expect main navigation on the start edge.',
            Colors.green,
          ),
          _buildBestPracticeItem(
            '✓',
            'Use end drawer for contextual options',
            'Settings, filters, and secondary actions fit well here.',
            Colors.green,
          ),
          _buildBestPracticeItem(
            '✓',
            'Test with RTL locales',
            'Verify your layout works correctly in both directions.',
            Colors.green,
          ),
          _buildBestPracticeItem(
            '✓',
            'Provide visual affordance',
            'Use hamburger menu icons to indicate drawer presence.',
            Colors.green,
          ),
          _buildBestPracticeItem(
            '✗',
            'Don\'t use both drawers for navigation',
            'Having two navigation drawers confuses users.',
            Colors.red,
          ),
          _buildBestPracticeItem(
            '✗',
            'Don\'t skip the hamburger icon',
            'Users may not discover swipe gestures without visual hints.',
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildBestPracticeItem(
    String symbol,
    String title,
    String description,
    Color symbolColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: symbolColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                symbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: symbolColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1565C0), size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF37474F).withOpacity(0.1),
            const Color(0xFF37474F).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF37474F).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_open, color: Color(0xFF546E7A), size: 28),
              SizedBox(width: 12),
              Text(
                'DrawerAlignment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Part of Flutter Material Library',
            style: TextStyle(fontSize: 14, color: Color(0xFF78909C)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterChip('Enum'),
              const SizedBox(width: 8),
              _buildFooterChip('Material'),
              const SizedBox(width: 8),
              _buildFooterChip('Navigation'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: Color(0xFF90A4AE), size: 18),
                SizedBox(width: 8),
                Text(
                  'See also: Drawer, Scaffold, NavigationDrawer',
                  style: TextStyle(fontSize: 13, color: Color(0xFF78909C)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF546E7A).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF546E7A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
