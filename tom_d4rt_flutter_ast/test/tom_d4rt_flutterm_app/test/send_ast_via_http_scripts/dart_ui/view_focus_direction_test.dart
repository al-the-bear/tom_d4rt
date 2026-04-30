// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ViewFocusDirection from dart:ui
// ViewFocusDirection indicates the direction of focus traversal
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// GLOBAL HELPER FUNCTIONS (declared before build)
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.purple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const Icon(Icons.swap_horiz, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'ViewFocusDirection',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Focus Traversal Direction from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Forward and backward focus navigation',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverviewCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.deepPurple, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ViewFocusDirection Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Specifies focus traversal direction'),
              _buildBulletPoint('Used with ViewFocusEvent for focus changes'),
              _buildBulletPoint('Simple binary enum: forward or backward'),
              _buildBulletPoint('Maps to Tab/Shift+Tab navigation'),
              _buildBulletPoint('Critical for accessibility'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionCard(
  ViewFocusDirection direction,
  IconData icon,
  Color color,
  String description,
  List<String> traits,
  String keyboardShortcut,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ViewFocusDirection.${direction.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Index: ${direction.index}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            keyboardShortcut,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Characteristics',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...traits.map(
                      (t) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: color, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
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
      ],
    ),
  );
}

Widget _buildQuickRefGrid() {
  final items = [
    (
      ViewFocusDirection.forward,
      Icons.arrow_forward,
      Colors.blue,
      'Forward',
      'Tab',
    ),
    (
      ViewFocusDirection.backward,
      Icons.arrow_back,
      Colors.orange,
      'Backward',
      'Shift+Tab',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Reference',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${ViewFocusDirection.values.length} focus direction values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Row(
          children: items
              .map(
                (item) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item.$3.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: item.$3.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(item.$2, color: item.$3, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          item.$4,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: item.$3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: item.$3.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.$5,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildFocusTraversalVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Focus Traversal Flow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How focus moves through focusable elements',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 24),
        // Forward flow
        _buildFlowRow(
          'Forward (Tab)',
          ['Button 1', 'Input 1', 'Button 2', 'Input 2'],
          Colors.blue,
          true,
        ),
        const SizedBox(height: 20),
        // Backward flow
        _buildFlowRow(
          'Backward (Shift+Tab)',
          ['Input 2', 'Button 2', 'Input 1', 'Button 1'],
          Colors.orange,
          false,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Tab navigation follows widget order in the focus tree. '
            'Use FocusTraversalGroup to customize the order.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowRow(
  String label,
  List<String> items,
  Color color,
  bool isForward,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            isForward ? Icons.arrow_forward : Icons.arrow_back,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.asMap().entries.map((entry) {
            final isLast = entry.key == items.length - 1;
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: entry.key == 0
                        ? Border.all(color: color, width: 2)
                        : null,
                  ),
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: entry.key == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      isForward ? Icons.arrow_forward : Icons.arrow_back,
                      color: Colors.grey.shade600,
                      size: 14,
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget _buildPlatformMapping() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Key Mappings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlatformRow(
          Icons.computer,
          'Windows/Linux',
          'Tab',
          'Shift + Tab',
        ),
        const Divider(),
        _buildPlatformRow(Icons.laptop_mac, 'macOS', 'Tab', 'Shift + Tab'),
        const Divider(),
        _buildPlatformRow(Icons.web, 'Web', 'Tab', 'Shift + Tab'),
        const Divider(),
        _buildPlatformRow(
          Icons.phone_android,
          'Android',
          'Tab (keyboard)',
          'Shift + Tab',
        ),
        const Divider(),
        _buildPlatformRow(
          Icons.phone_iphone,
          'iOS',
          'Tab (keyboard)',
          'Shift + Tab',
        ),
      ],
    ),
  );
}

Widget _buildPlatformRow(
  IconData icon,
  String platform,
  String forward,
  String backward,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey.shade700),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            platform,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              forward,
              style: const TextStyle(fontSize: 10, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              backward,
              style: const TextStyle(fontSize: 10, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeExamples() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Code Examples',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Handle ViewFocusEvent',
          '''void handleViewFocusEvent(ViewFocusEvent event) {
  switch (event.direction) {
    case ViewFocusDirection.forward:
      moveFocusToNext();
      break;
    case ViewFocusDirection.backward:
      moveFocusToPrevious();
      break;
  }
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Custom focus navigation',
          '''void navigateFocus(ViewFocusDirection direction) {
  if (direction == ViewFocusDirection.forward) {
    FocusScope.of(context).nextFocus();
  } else {
    FocusScope.of(context).previousFocus();
  }
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Respond to focus direction',
          '''Widget build(BuildContext context) {
  return Focus(
    onKeyEvent: (node, event) {
      if (event.logicalKey == LogicalKeyboardKey.tab) {
        final direction = HardwareKeyboard.instance
            .isShiftPressed
            ? ViewFocusDirection.backward
            : ViewFocusDirection.forward;
        handleFocus(direction);
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
    child: YourWidget(),
  );
}''',
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
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    ],
  );
}

Widget _buildAccessibilitySection() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade700, Colors.green.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'Accessibility Importance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildAccessibilityPoint('Enables keyboard-only navigation'),
        _buildAccessibilityPoint('Critical for screen reader users'),
        _buildAccessibilityPoint('Required for WCAG compliance'),
        _buildAccessibilityPoint('Supports motor accessibility'),
        _buildAccessibilityPoint('Works with switch devices'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Always ensure your app has a logical focus order that makes '
            'sense for users who navigate exclusively with Tab.',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAccessibilityPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    ),
  );
}

Widget _buildRelatedTypes() {
  final types = [
    ('ViewFocusEvent', 'Focus change event', Colors.blue),
    ('ViewFocusState', 'Current focus state', Colors.orange),
    ('FocusNode', 'Focus tree node', Colors.green),
    ('FocusScope', 'Focus scope widget', Colors.purple),
    ('FocusTraversalGroup', 'Custom traversal', Colors.teal),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types
              .map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: t.$3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: t.$3.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.$1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: t.$3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.$2,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStats() {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade400, Colors.purple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total', '${ViewFocusDirection.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Forward', '→'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Backward', '←'),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.white.withValues(alpha: 0.8),
        ),
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'ViewFocusDirection Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${ViewFocusDirection.values.length} focus direction values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== ViewFocusDirection Deep Demo ===');

  // Log all values
  print('ViewFocusDirection indicates focus traversal direction');
  print('All values: ${ViewFocusDirection.values}');
  print('Count: ${ViewFocusDirection.values.length}');

  for (final d in ViewFocusDirection.values) {
    print('${d.name}: index=${d.index}');
  }

  print('\n--- Direction Details ---');
  print('forward: Tab key - moves to next focusable');
  print('backward: Shift+Tab - moves to previous focusable');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Overview
              _buildOverviewCard(),
              const SizedBox(height: 16),

              // Quick reference
              _buildSectionHeader('QUICK REFERENCE'),
              _buildQuickRefGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // Direction cards
              _buildSectionHeader('DIRECTION DETAILS'),

              _buildDirectionCard(
                ViewFocusDirection.forward,
                Icons.arrow_forward,
                Colors.blue,
                'Indicates focus should move to the next focusable element in the focus traversal order. This is the default direction when the user presses Tab.',
                [
                  'Triggered by Tab key press',
                  'Moves focus to next widget',
                  'Follows focus traversal order',
                  'Default direction for navigation',
                  'Cycles to first element at end',
                ],
                'Tab',
              ),

              _buildDirectionCard(
                ViewFocusDirection.backward,
                Icons.arrow_back,
                Colors.orange,
                'Indicates focus should move to the previous focusable element in the focus traversal order. This occurs when the user presses Shift+Tab.',
                [
                  'Triggered by Shift+Tab',
                  'Moves focus to previous widget',
                  'Reverse of forward traversal',
                  'Essential for bidirectional navigation',
                  'Cycles to last element at start',
                ],
                'Shift+Tab',
              ),

              const SizedBox(height: 16),

              // Focus traversal visualization
              _buildSectionHeader('FOCUS TRAVERSAL'),
              _buildFocusTraversalVisualization(),
              const SizedBox(height: 16),

              // Platform mapping
              _buildSectionHeader('PLATFORM KEYS'),
              _buildPlatformMapping(),
              const SizedBox(height: 16),

              // Accessibility
              _buildSectionHeader('ACCESSIBILITY'),
              _buildAccessibilitySection(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExamples(),
              const SizedBox(height: 16),

              // Related types
              _buildSectionHeader('RELATED TYPES'),
              _buildRelatedTypes(),
              const SizedBox(height: 16),

              // Footer
              _buildFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
