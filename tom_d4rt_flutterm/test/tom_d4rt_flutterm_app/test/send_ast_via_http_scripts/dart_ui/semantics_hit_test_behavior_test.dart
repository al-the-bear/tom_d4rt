// D4rt test script: Deep Demo for SemanticsHitTestBehavior from dart:ui
// SemanticsHitTestBehavior controls how semantics hit testing works
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Global scope for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade700, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.touch_app, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'SemanticsHitTestBehavior',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Semantics Hit Testing Control from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueCard(
  SemanticsHitTestBehavior behavior,
  Color color,
  String description,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    behavior.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    'index: ${behavior.index}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.grey.shade600,
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
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(behavior, color),
      ],
    ),
  );
}

Widget _buildCodeSnippet(SemanticsHitTestBehavior behavior, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      'SemanticsHitTestBehavior.${behavior.name}',
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildVisualDemonstration() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.visibility, color: Colors.indigo.shade700),
            const SizedBox(width: 8),
            const Text(
              'Visual Hit Test Flow',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        // Visual diagram showing hit test flow
        Center(child: Column(children: [_buildHitTestDiagram()])),
      ],
    ),
  );
}

Widget _buildHitTestDiagram() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade400),
            ),
            child: const Text('User Touch\n⬇️', textAlign: TextAlign.center),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Container(width: 2, height: 20, color: Colors.grey),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade400),
        ),
        child: const Text(
          'Hit Test\n(Find Semantic Nodes)',
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 8),
      Container(width: 2, height: 20, color: Colors.grey),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBehaviorBox('opaque', Colors.green),
          _buildBehaviorBox('transparent', Colors.purple),
          _buildBehaviorBox('defer', Colors.grey),
        ],
      ),
    ],
  );
}

Widget _buildBehaviorBox(String label, Color color) {
  return Container(
    width: 90,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.table_chart, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Text(
              'Behavior Comparison',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: const [
                _TableCell('Behavior', isHeader: true),
                _TableCell('Self Hit', isHeader: true),
                _TableCell('Child Hit', isHeader: true),
                _TableCell('Behind Hit', isHeader: true),
              ],
            ),
            const TableRow(
              children: [
                _TableCell('opaque'),
                _TableCell('✅ Yes'),
                _TableCell('✅ Yes'),
                _TableCell('❌ No'),
              ],
            ),
            const TableRow(
              children: [
                _TableCell('transparent'),
                _TableCell('✅ Yes'),
                _TableCell('✅ Yes'),
                _TableCell('✅ Yes'),
              ],
            ),
            const TableRow(
              children: [
                _TableCell('defer'),
                _TableCell('❌ No'),
                _TableCell('✅ Yes'),
                _TableCell('✅ Yes'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _TableCell(this.text, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

Widget _buildUseCases() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildUseCaseItem(
          'opaque',
          Colors.green,
          'Buttons, clickable cards, interactive elements',
          'Standard interactive elements that block behind elements',
        ),
        const SizedBox(height: 12),
        _buildUseCaseItem(
          'transparent',
          Colors.purple,
          'Overlays, tooltips, modal backgrounds',
          'Elements that are hittable but allow hits to pass through',
        ),
        const SizedBox(height: 12),
        _buildUseCaseItem(
          'defer',
          Colors.grey,
          'Layout containers, positioning wrappers',
          'Containers that should not intercept accessibility events',
        ),
      ],
    ),
  );
}

Widget _buildUseCaseItem(
  String behavior,
  Color color,
  String example,
  String desc,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          behavior,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAccessibilityImportance() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            const Text(
              'Accessibility Impact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildAccessibilityPoint(
          Icons.visibility,
          'Screen Reader Navigation',
          'Controls which elements are recognized when a user taps the screen with VoiceOver/TalkBack.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityPoint(
          Icons.layers,
          'Element Stacking',
          'Determines whether overlapping elements are all announced or just the topmost.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityPoint(
          Icons.touch_app,
          'Touch Exploration',
          'Affects how touch exploration navigates through accessible elements.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityPoint(
          Icons.warning,
          'Common Pitfall',
          'Using opaque when transparent is needed can make content behind inaccessible to screen readers.',
        ),
      ],
    ),
  );
}

Widget _buildAccessibilityPoint(IconData icon, String title, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.blue.shade700),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildEnumDetails() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.blueGrey.shade700),
            const SizedBox(width: 8),
            const Text(
              'API Reference',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildApiItem('Type', 'enum SemanticsHitTestBehavior'),
        const SizedBox(height: 8),
        _buildApiItem('Library', 'dart:ui'),
        const SizedBox(height: 8),
        _buildApiItem('Values', 'defer, opaque, transparent'),
        const SizedBox(height: 8),
        _buildApiItem('properties', '.name, .index'),
        const SizedBox(height: 8),
        _buildApiItem('Static', 'SemanticsHitTestBehavior.values'),
      ],
    ),
  );
}

Widget _buildApiItem(String name, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ],
  );
}

Widget _buildInteractiveDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.mouse, color: Colors.pink.shade700),
            const SizedBox(width: 8),
            const Text(
              'Interactive Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Center(
          child: SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Bottom layer - grey
                Positioned(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Behind',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // Middle layer - transparent (allows pass-through)
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        'transparent\n(pass-through)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Top layer - opaque
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'opaque\n(blocks)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'With opaque: Only top element is hit-tested\n'
            'With transparent: Events pass through to elements behind\n'
            'With defer: Platform decides optimal behavior',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== SemanticsHitTestBehavior Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = SemanticsHitTestBehavior.values;
  print('SemanticsHitTestBehavior values: $values');
  print('Count: ${values.length}');

  for (final v in values) {
    print('SemanticsHitTestBehavior.${v.name}: index=${v.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final opaque = SemanticsHitTestBehavior.opaque;
  final transparent = SemanticsHitTestBehavior.transparent;
  final defer = SemanticsHitTestBehavior.defer;

  print('opaque: $opaque, index=${opaque.index}');
  print('transparent: $transparent, index=${transparent.index}');
  print('defer: $defer, index=${defer.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('opaque == opaque: ${opaque == SemanticsHitTestBehavior.opaque}');
  print('opaque == transparent: ${opaque == transparent}');
  print(
    'opaque.hashCode == opaque.hashCode: ${opaque.hashCode == SemanticsHitTestBehavior.opaque.hashCode}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INDEX-BASED ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  for (var i = 0; i < values.length; i++) {
    print('values[$i]: ${values[i].name}');
  }

  print('First: ${values.first}');
  print('Last: ${values.last}');

  print('=== SemanticsHitTestBehavior Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('SemanticsHitTestBehavior'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            // Value cards
            const Text(
              'Enum Values',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildValueCard(
              opaque,
              Colors.green,
              'The semantics node is hit-testable, and it blocks hit testing of nodes behind it. '
              'This is the default behavior for most interactive elements.',
              Icons.stop_circle,
            ),
            const SizedBox(height: 12),
            _buildValueCard(
              transparent,
              Colors.purple,
              'The semantics node is transparent to hit testing. Events pass through to elements behind it. '
              'Used for decorations that should not intercept touch events.',
              Icons.blur_on,
            ),
            const SizedBox(height: 12),
            _buildValueCard(
              defer,
              Colors.grey,
              'Defers hit test behavior to the platform. The platform infers appropriate behavior '
              'based on semantic node properties. This is the default value.',
              Icons.auto_mode,
            ),
            const SizedBox(height: 24),

            _buildVisualDemonstration(),
            const SizedBox(height: 20),

            _buildComparisonTable(),
            const SizedBox(height: 20),

            _buildInteractiveDemo(),
            const SizedBox(height: 20),

            _buildUseCases(),
            const SizedBox(height: 20),

            _buildAccessibilityImportance(),
            const SizedBox(height: 20),

            _buildEnumDetails(),
            const SizedBox(height: 32),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.teal.shade700),
                  const SizedBox(width: 8),
                  const Text(
                    'SemanticsHitTestBehavior Demo Complete',
                    style: TextStyle(fontWeight: FontWeight.w500),
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
