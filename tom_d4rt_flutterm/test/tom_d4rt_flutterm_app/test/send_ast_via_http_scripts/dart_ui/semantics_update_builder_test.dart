// D4rt test script: Deep demo for SemanticsUpdateBuilder from dart:ui
//
// SemanticsUpdateBuilder constructs accessibility trees for screen readers.
// It creates SemanticsUpdate objects that describe the UI structure.
//
// Key concepts:
//   - SemanticsNode: A node in the semantics tree
//   - SemanticsUpdate: Batch of node updates
//   - Labels: Text announced by screen readers
//   - Actions: Interactions available on nodes
//   - Flags: Boolean properties (focusable, button, etc.)
//
// SemanticsAction enum values:
//   - tap, longPress, scrollLeft/Right/Up/Down
//   - increase, decrease, showOnScreen
//   - moveCursorForward/Backward, setSelection
//   - copy, cut, paste, didGainAccessibilityFocus
//   - dismiss, customAction, focus
//
// SemanticsFlag enum values:
//   - hasCheckedState, isChecked, isSelected
//   - isButton, isSlider, isKeyboardKey
//   - isTextField, isFocusable, isFocused
//   - hasEnabledState, isEnabled, isInMutuallyExclusiveGroup
//   - isHeader, isObscured, scopesRoute
//   - namesRoute, isHidden, isImage
//   - isLiveRegion, hasToggledState, isToggled
//   - hasImplicitScrolling, isMultiline, isReadOnly
//   - isLink, isSlider
//
// This demo visually demonstrates semantics concepts.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF6A1B9A), const Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6A1B9A).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.accessibility_new, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFAB47BC).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF6A1B9A), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'Accessibility Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Visual flow
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: const Size(double.infinity, 80),
            painter: _AccessibilityFlowPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SemanticsUpdateBuilder creates updates that tell screen readers '
            'how to navigate and announce UI elements.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

class _AccessibilityFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxes = [
      {'label': 'Widget', 'color': const Color(0xFF6A1B9A)},
      {'label': 'Semantics', 'color': const Color(0xFF8E24AA)},
      {'label': 'Update', 'color': const Color(0xFFAB47BC)},
      {'label': 'Reader', 'color': const Color(0xFFCE93D8)},
    ];

    final boxWidth = (size.width - 30) / 4;
    final boxHeight = 40.0;
    final y = (size.height - boxHeight) / 2;

    for (var i = 0; i < boxes.length; i++) {
      final x = i * (boxWidth + 10);
      final color = boxes[i]['color'] as Color;

      // Box
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectXY(Rect.fromLTWH(x, y, boxWidth, boxHeight), 8, 8),
        paint,
      );

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: boxes[i]['label'] as String,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x + (boxWidth - tp.width) / 2, y + 14));

      // Arrow
      if (i < boxes.length - 1) {
        final arrowPaint = Paint()
          ..color = Colors.grey
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(x + boxWidth + 2, y + boxHeight / 2),
          Offset(x + boxWidth + 8, y + boxHeight / 2),
          arrowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildActionsCard() {
  final actions = [
    {'icon': Icons.touch_app, 'label': 'tap', 'desc': 'Activate element'},
    {'icon': Icons.gesture, 'label': 'longPress', 'desc': 'Alternate action'},
    {'icon': Icons.add, 'label': 'increase', 'desc': 'Increment value'},
    {'icon': Icons.remove, 'label': 'decrease', 'desc': 'Decrement value'},
    {'icon': Icons.arrow_upward, 'label': 'scrollUp', 'desc': 'Scroll content'},
    {'icon': Icons.copy, 'label': 'copy', 'desc': 'Copy text'},
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'SemanticsAction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: actions.map((a) {
            return Container(
              width: 95,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    a['icon'] as IconData,
                    size: 20,
                    color: const Color(0xFF6A1B9A),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    a['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    a['desc'] as String,
                    style: TextStyle(fontSize: 8, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
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

Widget _buildFlagsCard() {
  final flags = [
    {'label': 'isButton', 'active': true},
    {'label': 'isFocusable', 'active': true},
    {'label': 'isFocused', 'active': false},
    {'label': 'isTextField', 'active': false},
    {'label': 'isChecked', 'active': true},
    {'label': 'isEnabled', 'active': true},
    {'label': 'isHeader', 'active': false},
    {'label': 'isImage', 'active': false},
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'SemanticsFlag',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: flags.map((f) {
            final active = f['active'] as bool;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF6A1B9A) : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                f['label'] as String,
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: active ? Colors.white : Colors.grey[600],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Text(
          'Boolean properties that describe UI element characteristics',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildTreeVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'Semantics Tree',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTreeItem('Root (id: 0)', 0, Icons.home),
              _buildTreeItem('AppBar: "My App"', 1, Icons.title),
              _buildTreeItem('Button: "Submit"', 1, Icons.smart_button),
              _buildTreeItem('TextField: "Email"', 1, Icons.text_fields),
              _buildTreeItem('ListView', 1, Icons.list),
              _buildTreeItem('Item: "Apple"', 2, Icons.menu_book),
              _buildTreeItem('Item: "Banana"', 2, Icons.menu_book),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeItem(String label, int indent, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, top: 6, bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6A1B9A)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
      ],
    ),
  );
}

Widget _buildWorkflowCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'Builder Workflow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// Create builder\n'
          'final builder = SemanticsUpdateBuilder();\n'
          '\n'
          '// Add node updates (framework handles this)\n'
          "// builder.updateNode(...)\n"
          '\n'
          '// Build the update\n'
          'final update = builder.build();\n'
          '\n'
          '// Apply to pipeline (window.updateSemantics)\n'
          '// ...\n'
          '\n'
          '// Clean up\n'
          'update.dispose();',
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildWorkflowStep('1', 'Create', Icons.add_circle),
            _buildWorkflowStep('2', 'Update', Icons.edit),
            _buildWorkflowStep('3', 'Build', Icons.build_circle),
            _buildWorkflowStep('4', 'Apply', Icons.send),
            _buildWorkflowStep('5', 'Dispose', Icons.delete),
          ],
        ),
      ],
    ),
  );
}

Widget _buildWorkflowStep(String num, String label, IconData icon) {
  return Column(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF6A1B9A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Icon(icon, size: 18, color: Colors.white)),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 9)),
    ],
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFFD4D4D4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildScreenReaderDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.record_voice_over, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'Screen Reader Output',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildAnnouncementItem(
          'Button',
          'Submit, button, double tap to activate',
        ),
        _buildAnnouncementItem(
          'TextField',
          'Email, text field, enter your email',
        ),
        _buildAnnouncementItem('Checkbox', 'Remember me, checkbox, checked'),
        _buildAnnouncementItem('Slider', 'Volume, slider, 75%'),
      ],
    ),
  );
}

Widget _buildAnnouncementItem(String type, String announcement) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF6A1B9A),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.volume_up, size: 14, color: Color(0xFF6A1B9A)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '"$announcement"',
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
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

Widget _buildResultsCard(String type1, String type2) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            const Text(
              'Test Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow('SemanticsUpdateBuilder', type1, true),
        _buildResultRow('SemanticsUpdate created', type2, true),
        _buildResultRow('build() returns update', 'Yes', true),
        _buildResultRow('dispose() cleans up', 'Yes', true),
      ],
    ),
  );
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 11))),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesCard() {
  final cases = [
    {
      'icon': Icons.visibility,
      'label': 'TalkBack / VoiceOver',
      'desc': 'Screen readers',
    },
    {
      'icon': Icons.accessibility,
      'label': 'Accessibility testing',
      'desc': 'UI audits',
    },
    {'icon': Icons.search, 'label': 'Widget tests', 'desc': 'Semantic finders'},
    {
      'icon': Icons.developer_mode,
      'label': 'Debug info',
      'desc': 'Semantics debugger',
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.apps, color: const Color(0xFF6A1B9A)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFF6A1B9A),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['label'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        c['desc'] as String,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== SemanticsUpdateBuilder Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SemanticsUpdateBuilder Overview ---');
  print('Constructs accessibility tree updates for screen readers');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CREATE BUILDER
  // ═══════════════════════════════════════════════════════════════════════════

  final builder = ui.SemanticsUpdateBuilder();
  print('Created SemanticsUpdateBuilder: ${builder.runtimeType}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: BUILD UPDATE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building SemanticsUpdate ---');
  final update = builder.build();
  print('SemanticsUpdate type: ${update.runtimeType}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: DISPOSE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Disposing ---');
  update.dispose();
  print('SemanticsUpdate disposed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SECOND BUILDER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Second Builder ---');
  final builder2 = ui.SemanticsUpdateBuilder();
  final update2 = builder2.build();
  print('Second build: ${update2.runtimeType}');
  update2.dispose();
  print('Second update disposed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SEMANTICS ACTION ENUM
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SemanticsAction values ---');
  final actionCount = ui.SemanticsAction.values.length;
  print('Total actions: $actionCount');
  for (final action in ui.SemanticsAction.values.take(5)) {
    print('  ${action.name}');
  }
  print('  ...');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: SEMANTICS FLAG ENUM
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SemanticsFlag values ---');
  final flagCount = ui.SemanticsFlag.values.length;
  print('Total flags: $flagCount');
  for (final flag in ui.SemanticsFlag.values.take(5)) {
    print('  ${flag.name}');
  }
  print('  ...');

  print('\n=== SemanticsUpdateBuilder Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  final builderType = '${builder.runtimeType}';
  final updateType = '${update.runtimeType}';

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'SemanticsUpdateBuilder',
          'Accessibility Tree Construction',
        ),
        const SizedBox(height: 20),

        // Concept
        _buildSectionTitle('Concept', Icons.info),
        _buildConceptCard(),
        const SizedBox(height: 20),

        // Tree
        _buildSectionTitle('Tree Structure', Icons.account_tree),
        _buildTreeVisualization(),
        const SizedBox(height: 20),

        // Actions
        _buildSectionTitle('Actions', Icons.touch_app),
        _buildActionsCard(),
        const SizedBox(height: 20),

        // Flags
        _buildSectionTitle('Flags', Icons.flag),
        _buildFlagsCard(),
        const SizedBox(height: 20),

        // Screen reader
        _buildSectionTitle('Screen Reader', Icons.record_voice_over),
        _buildScreenReaderDemo(),
        const SizedBox(height: 20),

        // Workflow
        _buildSectionTitle('Workflow', Icons.timeline),
        _buildWorkflowCard(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.apps),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(builderType, updateType),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• SemanticsUpdateBuilder creates accessibility updates\n'
                '• SemanticsUpdate describes UI element properties\n'
                '• SemanticsAction defines available interactions\n'
                '• SemanticsFlag marks element characteristics\n'
                '• Screen readers use this to navigate and announce\n'
                '• Always dispose() updates to free resources',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
