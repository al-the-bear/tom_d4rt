// D4rt test script: Tests CheckedState from dart_ui
// CheckedState defines states for checkbox-like accessibility semantics
// Part of the accessibility/semantics system
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CheckedState Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All CheckedState Values
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CheckedState values by index
  // ═══════════════════════════════════════════════════════════════════════════
  // Access CheckedState values dynamically by index

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CheckedState usage
  // ═══════════════════════════════════════════════════════════════════════════
  // Use the enum values in comparisons

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Using CheckedState values
  // ═══════════════════════════════════════════════════════════════════════════
  // The mixed state is already defined above

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Tristate Checkbox Widget
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Semantics Integration
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Accessibility Best Practices
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Custom Checkbox Implementation
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Platform-Specific Behavior
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: CheckedState vs SemanticsFlag
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Testing Checkbox Semantics
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: State Transitions
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Related Enums
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // Return visual UI demonstrating all states
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green.shade50, Colors.teal.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.check_box, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CheckedState',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Tri-State Checkbox Semantics',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // States display
        Text(
          'All CheckedState Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: ui.CheckedState.values.map((state) {
            // Use index-based lookup for icons and colors
            final iconList = [
              Icons.check_box_outline_blank, // index 0
              Icons.check_box, // index 1
              Icons.indeterminate_check_box, // index 2
            ];
            final colorList = [
              Colors.grey, // index 0
              Colors.green, // index 1
              Colors.orange, // index 2
            ];
            final icon = state.index < iconList.length
                ? iconList[state.index]
                : Icons.help;
            final color = state.index < colorList.length
                ? colorList[state.index]
                : Colors.grey;
            final isLast = state.index == ui.CheckedState.values.length - 1;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isLast ? 0 : 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.shade400, width: 2),
                ),
                child: Column(
                  children: [
                    Icon(icon, size: 48, color: color.shade700),
                    SizedBox(height: 8),
                    Text(
                      state.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color.shade700,
                      ),
                    ),
                    Text(
                      'index: ${state.index}',
                      style: TextStyle(fontSize: 11, color: color.shade500),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Mapping table
        Text(
          'Widget Value Mapping',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              _MappingRow(
                widgetValue: 'true',
                state: 'checked',
                color: Colors.green,
              ),
              Divider(height: 1),
              _MappingRow(
                widgetValue: 'false',
                state: 'unchecked',
                color: Colors.grey,
              ),
              Divider(height: 1),
              _MappingRow(
                widgetValue: 'null',
                state: 'mixed',
                color: Colors.orange,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Info cards
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.accessibility,
                title: 'Purpose',
                content: 'Screen reader\naccessibility',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.check_box,
                title: 'Widget',
                content: 'Checkbox\ntristate mode',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.hub,
                title: 'Semantics',
                content: 'SemanticsNode',
                color: Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.CheckedState.values.length} states • Part of accessibility system • Used by Checkbox and Semantics widgets',
                  style: TextStyle(fontSize: 12, color: Colors.teal.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for mapping rows
class _MappingRow extends StatelessWidget {
  final String widgetValue;
  final String state;
  final MaterialColor color;

  const _MappingRow({
    required this.widgetValue,
    required this.state,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Checkbox(value: $widgetValue)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
          Expanded(
            child: Text(
              'CheckedState.$state',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for info cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final MaterialColor color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 9, color: color.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
