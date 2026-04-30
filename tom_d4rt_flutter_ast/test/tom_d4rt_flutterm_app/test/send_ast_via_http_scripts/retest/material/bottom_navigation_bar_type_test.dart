// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

/// Deep demonstration of BottomNavigationBarType enum and its visual/behavioral differences.
///
/// BottomNavigationBarType controls how navigation items display and animate:
/// - **fixed**: All items displayed with equal width, labels always visible
/// - **shifting**: Selected item expands, unselected items shrink with hidden labels
///
/// This demo provides comprehensive visual comparison and use-case guidance.

dynamic build(BuildContext context) {
  return _BottomNavigationBarTypeDemo();
}

class _BottomNavigationBarTypeDemo extends StatefulWidget {
  @override
  State<_BottomNavigationBarTypeDemo> createState() =>
      _BottomNavigationBarTypeDemoState();
}

class _BottomNavigationBarTypeDemoState
    extends State<_BottomNavigationBarTypeDemo> {
  int _fixedSelectedIndex = 0;
  int _shiftingSelectedIndex = 0;
  int _scenario1Index = 0;
  int _scenario2Index = 0;
  int _scenario3Index = 0;
  int _interactiveFixedIndex = 0;
  int _interactiveShiftingIndex = 0;
  int _accessibilityIndex = 0;

  // Color schemes for different demonstrations
  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _deepPurple = Color(0xFF7B1FA2);
  static const Color _teal = Color(0xFF00796B);
  static const Color _orange = Color(0xFFE65100);
  static const Color _indigo = Color(0xFF303F9F);
  static const Color _pink = Color(0xFFC2185B);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF5F7FA), Color(0xFFE8EDF5), Color(0xFFDCE4F2)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildSection1Overview(),
                  const SizedBox(height: 32),
                  _buildSection2SideBySideComparison(),
                  const SizedBox(height: 32),
                  _buildSection3InteractiveDemo(),
                  const SizedBox(height: 32),
                  _buildSection4UseCaseScenarios(),
                  const SizedBox(height: 32),
                  _buildSection5BestPractices(),
                  const SizedBox(height: 32),
                  _buildSection6AccessibilityConsiderations(),
                  const SizedBox(height: 40),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Main header with title and introduction
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primaryBlue, Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.navigation_rounded, size: 56, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'BottomNavigationBarType',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Deep Dive into Fixed vs Shifting Navigation Styles',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Flutter Material Design Component',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 1: Overview cards explaining both types
  Widget _buildSection1Overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('1. Understanding the Types', Icons.info_outline),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildTypeOverviewCard(
                title: 'FIXED',
                icon: Icons.view_column,
                color: _teal,
                description:
                    'All navigation items maintain equal width regardless of selection state. Labels remain visible for all items at all times.',
                characteristics: [
                  'Equal width distribution',
                  'Labels always visible',
                  'Consistent visual layout',
                  'No expansion animation',
                  'Best for 3-4 items',
                ],
                codeSnippet: 'type: BottomNavigationBarType.fixed',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOverviewCard(
                title: 'SHIFTING',
                icon: Icons.auto_awesome,
                color: _deepPurple,
                description:
                    'Selected item expands to show its label while unselected items shrink and hide their labels. Creates dynamic, attention-grabbing UI.',
                characteristics: [
                  'Selected item expands',
                  'Unselected labels hidden',
                  'Smooth transition animation',
                  'Color-based item backgrounds',
                  'Best for 4-5 items',
                ],
                codeSnippet: 'type: BottomNavigationBarType.shifting',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildInfoBanner(
          icon: Icons.lightbulb_outline,
          color: _orange,
          title: 'Key Insight',
          message:
              'The type property affects both visual presentation and animation behavior. '
              'Fixed type provides stability and clarity, while shifting type creates '
              'visual hierarchy and engagement through animation.',
        ),
      ],
    );
  }

  Widget _buildTypeOverviewCard({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required List<String> characteristics,
    required String codeSnippet,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Characteristics:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...characteristics.map(
            (char) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: color, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      char,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              codeSnippet,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 2: Side-by-side visual comparison with actual widgets
  Widget _buildSection2SideBySideComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('2. Visual Comparison', Icons.compare),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Tap the items below to see how each type behaves differently',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildComparisonPanel(
                      title: 'BottomNavigationBarType.fixed',
                      color: _teal,
                      child: _buildFixedNavigationBar(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildComparisonPanel(
                      title: 'BottomNavigationBarType.shifting',
                      color: _deepPurple,
                      child: _buildShiftingNavigationBar(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildComparisonNotes(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonPanel({
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: child,
          ),
        ),
      ],
    );
  }

  Widget _buildFixedNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _fixedSelectedIndex,
      onTap: (index) => setState(() => _fixedSelectedIndex = index),
      backgroundColor: Colors.white,
      selectedItemColor: _teal,
      unselectedItemColor: Colors.grey[500],
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildShiftingNavigationBar() {
    final colors = [_deepPurple, _pink, _orange, _indigo];
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _shiftingSelectedIndex,
      onTap: (index) => setState(() => _shiftingSelectedIndex = index),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: colors[0],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search),
          label: 'Search',
          backgroundColor: colors[1],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          activeIcon: const Icon(Icons.favorite),
          label: 'Favorites',
          backgroundColor: colors[2],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: 'Profile',
          backgroundColor: colors[3],
        ),
      ],
    );
  }

  Widget _buildComparisonNotes() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.visibility, color: Colors.grey[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Visual Differences to Observe:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildObservationItem(
            '1',
            'Label visibility: Fixed shows all labels, Shifting hides unselected',
          ),
          _buildObservationItem(
            '2',
            'Width distribution: Fixed uses equal widths, Shifting expands selected',
          ),
          _buildObservationItem(
            '3',
            'Background color: Shifting uses item backgroundColor property',
          ),
          _buildObservationItem(
            '4',
            'Animation: Shifting has more pronounced transition effects',
          ),
        ],
      ),
    );
  }

  Widget _buildObservationItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _primaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 3: Interactive demonstration with multiple items
  Widget _buildSection3InteractiveDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('3. Interactive Demonstrations', Icons.touch_app),
        const SizedBox(height: 20),
        _buildInteractiveCard(
          title: 'Three Items - Fixed Type',
          subtitle: 'Optimal for apps with few primary destinations',
          color: _teal,
          child: _buildThreeItemFixed(),
          selectedIndex: _interactiveFixedIndex,
        ),
        const SizedBox(height: 20),
        _buildInteractiveCard(
          title: 'Five Items - Shifting Type',
          subtitle: 'Shifting excels with more items to manage visual space',
          color: _deepPurple,
          child: _buildFiveItemShifting(),
          selectedIndex: _interactiveShiftingIndex,
        ),
        const SizedBox(height: 20),
        _buildColorSchemeDemo(),
      ],
    );
  }

  Widget _buildInteractiveCard({
    required String title,
    required String subtitle,
    required Color color,
    required Widget child,
    required int selectedIndex,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.navigation, color: color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Index: $selectedIndex',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildThreeItemFixed() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _interactiveFixedIndex,
      onTap: (index) => setState(() => _interactiveFixedIndex = index),
      backgroundColor: _teal,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      selectedFontSize: 13,
      unselectedFontSize: 12,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget _buildFiveItemShifting() {
    final itemColors = [
      const Color(0xFF6200EA),
      const Color(0xFF0097A7),
      const Color(0xFFF57C00),
      const Color(0xFFC51162),
      const Color(0xFF00897B),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _interactiveShiftingIndex,
      onTap: (index) => setState(() => _interactiveShiftingIndex = index),
      selectedFontSize: 13,
      unselectedFontSize: 12,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.inbox_outlined),
          activeIcon: const Icon(Icons.inbox),
          label: 'Inbox',
          backgroundColor: itemColors[0],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.send_outlined),
          activeIcon: const Icon(Icons.send),
          label: 'Sent',
          backgroundColor: itemColors[1],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.drafts_outlined),
          activeIcon: const Icon(Icons.drafts),
          label: 'Drafts',
          backgroundColor: itemColors[2],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.archive_outlined),
          activeIcon: const Icon(Icons.archive),
          label: 'Archive',
          backgroundColor: itemColors[3],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.delete_outline),
          activeIcon: const Icon(Icons.delete),
          label: 'Trash',
          backgroundColor: itemColors[4],
        ),
      ],
    );
  }

  Widget _buildColorSchemeDemo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[100]!, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: Colors.grey[700], size: 22),
              const SizedBox(width: 10),
              Text(
                'Color Behavior Differences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildColorBehaviorRow(
            'Fixed Type',
            'Uses backgroundColor of BottomNavigationBar for entire bar',
            _teal,
          ),
          const SizedBox(height: 12),
          _buildColorBehaviorRow(
            'Shifting Type',
            'Uses backgroundColor from each BottomNavigationBarItem',
            _deepPurple,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.tips_and_updates,
                  color: Colors.amber[700],
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'For shifting type, define a distinct backgroundColor on each '
                    'BottomNavigationBarItem to get smooth color transitions when '
                    'switching tabs.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.amber[900],
                      height: 1.4,
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

  Widget _buildColorBehaviorRow(String type, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Section 4: Use case scenarios
  Widget _buildSection4UseCaseScenarios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('4. Use Case Scenarios', Icons.cases_outlined),
        const SizedBox(height: 20),
        _buildScenarioCard(
          title: 'E-Commerce App',
          recommendation: 'FIXED',
          reason:
              'Users need quick access to all sections. Visible labels reduce cognitive load during shopping.',
          color: _teal,
          icon: Icons.shopping_bag_outlined,
          navBar: _buildEcommerceNavBar(),
          selectedIndex: _scenario1Index,
          onIndexChanged: (i) => setState(() => _scenario1Index = i),
        ),
        const SizedBox(height: 20),
        _buildScenarioCard(
          title: 'Social Media App',
          recommendation: 'SHIFTING',
          reason:
              'Dynamic content benefits from engaging animations. Color transitions add brand personality.',
          color: _deepPurple,
          icon: Icons.people_outline,
          navBar: _buildSocialMediaNavBar(),
          selectedIndex: _scenario2Index,
          onIndexChanged: (i) => setState(() => _scenario2Index = i),
        ),
        const SizedBox(height: 20),
        _buildScenarioCard(
          title: 'Productivity App',
          recommendation: 'FIXED',
          reason:
              'Professional context requires clarity. Users focus on tasks, not navigation animations.',
          color: _indigo,
          icon: Icons.work_outline,
          navBar: _buildProductivityNavBar(),
          selectedIndex: _scenario3Index,
          onIndexChanged: (i) => setState(() => _scenario3Index = i),
        ),
        const SizedBox(height: 24),
        _buildDecisionFlowchart(),
      ],
    );
  }

  Widget _buildScenarioCard({
    required String title,
    required String recommendation,
    required String reason,
    required Color color,
    required IconData icon,
    required Widget navBar,
    required int selectedIndex,
    required ValueChanged<int> onIndexChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              recommendation,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        reason,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: navBar,
          ),
        ],
      ),
    );
  }

  Widget _buildEcommerceNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _scenario1Index,
      onTap: (index) => setState(() => _scenario1Index = index),
      backgroundColor: Colors.white,
      selectedItemColor: _teal,
      unselectedItemColor: Colors.grey[400],
      selectedFontSize: 11,
      unselectedFontSize: 11,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront_outlined),
          activeIcon: Icon(Icons.storefront),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }

  Widget _buildSocialMediaNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _scenario2Index,
      onTap: (index) => setState(() => _scenario2Index = index),
      selectedFontSize: 11,
      unselectedFontSize: 11,
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: 'Feed',
          backgroundColor: const Color(0xFF6200EA),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.explore_outlined),
          activeIcon: const Icon(Icons.explore),
          label: 'Explore',
          backgroundColor: const Color(0xFFD81B60),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_box_outlined),
          activeIcon: const Icon(Icons.add_box),
          label: 'Create',
          backgroundColor: const Color(0xFFFF6D00),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.notifications_outlined),
          activeIcon: const Icon(Icons.notifications),
          label: 'Alerts',
          backgroundColor: const Color(0xFF00BFA5),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: 'Profile',
          backgroundColor: const Color(0xFF304FFE),
        ),
      ],
    );
  }

  Widget _buildProductivityNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _scenario3Index,
      onTap: (index) => setState(() => _scenario3Index = index),
      backgroundColor: _indigo,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      selectedFontSize: 11,
      unselectedFontSize: 11,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.today_outlined),
          activeIcon: Icon(Icons.today),
          label: 'Today',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_outlined),
          activeIcon: Icon(Icons.task),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          activeIcon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }

  Widget _buildDecisionFlowchart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.purple[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: _primaryBlue, size: 24),
              const SizedBox(width: 10),
              const Text(
                'Decision Guide: Fixed vs Shifting',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDecisionRow(
            'Number of items',
            '3-4',
            'Fixed',
            '4-5',
            'Shifting',
          ),
          _buildDecisionRow(
            'Label importance',
            'High',
            'Fixed',
            'Low',
            'Shifting',
          ),
          _buildDecisionRow(
            'Brand personality',
            'Professional',
            'Fixed',
            'Playful',
            'Shifting',
          ),
          _buildDecisionRow(
            'User focus',
            'Task-oriented',
            'Fixed',
            'Exploratory',
            'Shifting',
          ),
          _buildDecisionRow(
            'Animation preference',
            'Minimal',
            'Fixed',
            'Dynamic',
            'Shifting',
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionRow(
    String criterion,
    String leftVal,
    String leftType,
    String rightVal,
    String rightType,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              criterion,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _teal.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$leftVal → $leftType',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: _teal,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _deepPurple.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$rightVal → $rightType',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: _deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 5: Best practices
  Widget _buildSection5BestPractices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('5. Best Practices', Icons.verified_outlined),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBestPracticeCard(
                title: 'Do\'s',
                color: Colors.green[600]!,
                icon: Icons.check_circle,
                items: [
                  'Use fixed for 3-4 items with equal importance',
                  'Use shifting for 4-5 items with visual hierarchy',
                  'Match type choice to app\'s brand personality',
                  'Consider user familiarity with navigation patterns',
                  'Test both types with real users before deciding',
                  'Use activeIcon for clear selected state',
                  'Maintain consistent icon sizes across items',
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildBestPracticeCard(
                title: 'Don\'ts',
                color: Colors.red[600]!,
                icon: Icons.cancel,
                items: [
                  'Don\'t use shifting with only 2-3 items',
                  'Don\'t mix icon styles within the same bar',
                  'Don\'t use shifting in text-heavy interfaces',
                  'Don\'t ignore accessibility requirements',
                  'Don\'t change type based on screen size',
                  'Don\'t use overly long labels (max 1-2 words)',
                  'Don\'t forget to handle edge cases like RTL',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildCodeExamplesPanel(),
      ],
    );
  }

  Widget _buildBestPracticeCard({
    required String title,
    required Color color,
    required IconData icon,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    title == 'Do\'s' ? Icons.add : Icons.remove,
                    color: color,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
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

  Widget _buildCodeExamplesPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code, color: Colors.white70, size: 20),
              const SizedBox(width: 10),
              const Text(
                'Code Examples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Dart',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCodeSnippet('Fixed Type Setup', '''BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  items: [...],
)'''),
          const SizedBox(height: 16),
          _buildCodeSnippet('Shifting Type Setup', '''BottomNavigationBar(
  type: BottomNavigationBarType.shifting,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.purple, // Per-item color
    ),
    // More items...
  ],
)'''),
        ],
      ),
    );
  }

  Widget _buildCodeSnippet(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// $title',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green[400],
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Section 6: Accessibility considerations
  Widget _buildSection6AccessibilityConsiderations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('6. Accessibility', Icons.accessibility_new),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAccessibilityPoint(
                icon: Icons.visibility,
                title: 'Label Visibility',
                fixedBehavior:
                    'Labels always visible, better for users who rely on text',
                shiftingBehavior:
                    'Unselected labels hidden, may reduce scannability',
                recommendation: 'Fixed preferred for accessibility',
              ),
              const Divider(height: 32),
              _buildAccessibilityPoint(
                icon: Icons.touch_app,
                title: 'Touch Targets',
                fixedBehavior: 'Equal-sized targets, predictable hit areas',
                shiftingBehavior: 'Variable target sizes during animation',
                recommendation: 'Both acceptable with proper sizing',
              ),
              const Divider(height: 32),
              _buildAccessibilityPoint(
                icon: Icons.hearing,
                title: 'Screen Readers',
                fixedBehavior: 'Consistent navigation announcements',
                shiftingBehavior: 'Same semantic information available',
                recommendation: 'Both work well with proper semantics',
              ),
              const Divider(height: 32),
              _buildAccessibilityPoint(
                icon: Icons.animation,
                title: 'Reduce Motion',
                fixedBehavior: 'Minimal animation, respects preferences',
                shiftingBehavior:
                    'Significant animation, check reduceAnimations',
                recommendation: 'Fixed safer for motion sensitivity',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildAccessibilityDemo(),
      ],
    );
  }

  Widget _buildAccessibilityPoint({
    required IconData icon,
    required String title,
    required String fixedBehavior,
    required String shiftingBehavior,
    required String recommendation,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _primaryBlue, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildAccessibilityBadge('Fixed', fixedBehavior, _teal),
                  const SizedBox(width: 10),
                  _buildAccessibilityBadge(
                    'Shifting',
                    shiftingBehavior,
                    _deepPurple,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '💡 $recommendation',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccessibilityBadge(String type, String text, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityDemo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.accessibility,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Accessible Fixed Navigation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Demonstrates proper semantics with Semantics labels',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _accessibilityIndex,
              onTap: (index) => setState(() => _accessibilityIndex = index),
              backgroundColor: Colors.green[700],
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              selectedFontSize: 13,
              unselectedFontSize: 12,
              showUnselectedLabels: true,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  tooltip: 'Go to home screen',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Alerts',
                  tooltip: 'View notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  tooltip: 'Open settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Footer section
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[100]!, Colors.grey[200]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.summarize, color: Colors.grey[600], size: 32),
          const SizedBox(height: 16),
          Text(
            'Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'BottomNavigationBarType provides two distinct navigation experiences. '
            'Fixed offers consistency and clarity with always-visible labels and equal widths. '
            'Shifting provides dynamic, engaging navigation with expanding selected items and '
            'per-item color theming. Choose based on your app\'s personality, item count, '
            'and user needs.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSummaryChip('Fixed', _teal, Icons.view_column),
              const SizedBox(width: 16),
              _buildSummaryChip('Shifting', _deepPurple, Icons.auto_awesome),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Flutter Material Design • BottomNavigationBarType Demo',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryChip(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Section title widget
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _primaryBlue, size: 22),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  /// Helper: Info banner widget
  Widget _buildInfoBanner({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.5,
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
