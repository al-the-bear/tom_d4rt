// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive visual demonstration of SemanticsValidationResult from dart_ui
// This enum describes validation states for semantic nodes, helping assistive technologies
// communicate form validation feedback to users.
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Must be declared before build() for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════════

/// Builds the main header section explaining SemanticsValidationResult
Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade700, Colors.green.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
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
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.verified, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SemanticsValidationResult',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dart:ui enum • 3 values',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Describes the validation state of semantic nodes, typically used with '
            'form inputs to communicate whether user input is valid, invalid, or '
            'not yet validated. Essential for accessible form validation feedback.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

/// Builds a card displaying information about a validation result value
Widget _buildValidationCard(
  SemanticsValidationResult result,
  Color color,
  String description,
  IconData icon,
  String screenReaderBehavior,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
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
        // Header row with icon and name
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SemanticsValidationResult.${result.name}',
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Index: ${result.index}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Description and behavior
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              // Screen reader behavior
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.speaker_notes,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Screen Reader Behavior',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            screenReaderBehavior,
                            style: TextStyle(
                              color: Colors.grey.shade600,
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
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a visual form validation demo
Widget _buildFormValidationDemo() {
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
            Icon(Icons.edit_document, color: Colors.blue.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Form Validation Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Form fields with different validation states
        _buildFormFieldRow(
          'Email',
          'john@example.com',
          SemanticsValidationResult.valid,
          Colors.green,
          Icons.check_circle,
        ),
        const SizedBox(height: 12),
        _buildFormFieldRow(
          'Password',
          '********',
          SemanticsValidationResult.none,
          Colors.grey,
          Icons.help_outline,
        ),
        const SizedBox(height: 12),
        _buildFormFieldRow(
          'Phone',
          'invalid-phone',
          SemanticsValidationResult.invalid,
          Colors.red,
          Icons.error,
        ),
      ],
    ),
  );
}

/// Builds a single form field row
Widget _buildFormFieldRow(
  String label,
  String value,
  SemanticsValidationResult result,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(icon, color: color, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            result.name,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds the validation state flow diagram
Widget _buildValidationStateFlow() {
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
            Icon(Icons.schema, color: Colors.purple.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Validation State Flow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Flow diagram
        Row(
          children: [
            _buildFlowNode('none', Colors.grey, 'Initial'),
            _buildFlowArrow('User\ninput'),
            _buildFlowNode('none', Colors.grey, 'Typing'),
            _buildFlowArrow('Validate'),
            Expanded(
              child: Column(
                children: [
                  _buildFlowNode('valid', Colors.green, 'Valid'),
                  const SizedBox(height: 8),
                  const Text(
                    'or',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  _buildFlowNode('invalid', Colors.red, 'Invalid'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Builds a flow node
Widget _buildFlowNode(String state, Color color, String label) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Text(
          state,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
    ],
  );
}

/// Builds a flow arrow
Widget _buildFlowArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
        Text(
          label,
          style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// Builds accessible form best practices section
Widget _buildAccessibilityBestPractices() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Accessibility Best Practices',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildPracticeItem(
          'Use valid/invalid at the right time',
          'Only set validation result after user has interacted with the field, '
              'not on initial render',
          Icons.timer,
        ),
        const SizedBox(height: 10),
        _buildPracticeItem(
          'Provide error descriptions',
          'When invalid, include descriptive error text in the semantics label '
              'explaining what\'s wrong',
          Icons.description,
        ),
        const SizedBox(height: 10),
        _buildPracticeItem(
          'Announce changes',
          'Use SemanticsSortKey to ensure validation changes are announced '
              'in a logical order',
          Icons.campaign,
        ),
        const SizedBox(height: 10),
        _buildPracticeItem(
          'Clear none state on focus',
          'Consider transitioning from none to valid/invalid when field '
              'loses focus, not while typing',
          Icons.autorenew,
        ),
      ],
    ),
  );
}

/// Builds a practice item row
Widget _buildPracticeItem(String title, String description, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Colors.amber.shade700, size: 18),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
                fontSize: 13,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.amber.shade700,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

/// Builds comparison table
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
            Icon(Icons.table_chart, color: Colors.cyan.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Validation Result Comparison',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.cyan.shade700,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: const Row(
            children: [
              Expanded(flex: 2, child: _HeaderCell('Value')),
              Expanded(flex: 3, child: _HeaderCell('Use Case')),
              Expanded(flex: 2, child: _HeaderCell('Visual')),
            ],
          ),
        ),
        _buildTableRow(
          'none',
          'Initial/typing state',
          'No indicator',
          0,
          Colors.grey,
        ),
        _buildTableRow(
          'valid',
          'Input acceptable',
          'Green check',
          1,
          Colors.green,
        ),
        _buildTableRow('invalid', 'Error present', 'Red error', 2, Colors.red),
      ],
    ),
  );
}

/// Builds a table row
Widget _buildTableRow(
  String value,
  String useCase,
  String visual,
  int index,
  Color color,
) {
  final isLast = index == 2;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: index % 2 == 0 ? Colors.grey.shade50 : Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200),
        left: BorderSide(color: Colors.grey.shade200),
        right: BorderSide(color: Colors.grey.shade200),
      ),
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(8))
          : null,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            useCase,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            visual,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

/// Builds real-world usage examples
Widget _buildUsageExamples() {
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
            Icon(Icons.code, color: Colors.blueGrey.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildUseCaseCard(
          'Text Fields',
          'Email validation, password strength, phone format',
          Icons.text_fields,
          Colors.blue,
        ),
        const SizedBox(height: 10),
        _buildUseCaseCard(
          'Checkboxes & Toggles',
          'Required agreement checkboxes, terms acceptance',
          Icons.check_box,
          Colors.green,
        ),
        const SizedBox(height: 10),
        _buildUseCaseCard(
          'Dropdowns',
          'Required selection fields, date pickers',
          Icons.arrow_drop_down_circle,
          Colors.orange,
        ),
        const SizedBox(height: 10),
        _buildUseCaseCard(
          'Radio Buttons',
          'Required option selection with validation',
          Icons.radio_button_checked,
          Colors.purple,
        ),
      ],
    ),
  );
}

/// Builds a use case card
Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds API documentation section
Widget _buildApiSection() {
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
            Icon(Icons.code, color: Colors.blueGrey.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildApiRow('Library', 'dart:ui'),
        _buildApiRow('Type', 'enum'),
        _buildApiRow('Values', 'none, valid, invalid'),
        _buildApiRow('Properties', '.name, .index'),
        _buildApiRow('Static', 'SemanticsValidationResult.values (List)'),
      ],
    ),
  );
}

/// Builds an API documentation row
Widget _buildApiRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blueGrey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Table header cell widget
class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== SemanticsValidationResult Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUMERATE ALL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = SemanticsValidationResult.values;
  print('Total values: ${values.length}');

  for (final v in values) {
    print('SemanticsValidationResult.${v.name}: index=${v.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final none = SemanticsValidationResult.none;
  final valid = SemanticsValidationResult.valid;
  final invalid = SemanticsValidationResult.invalid;

  print('none: $none, index=${none.index}');
  print('valid: $valid, index=${valid.index}');
  print('invalid: $invalid, index=${invalid.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('valid == valid: ${valid == SemanticsValidationResult.valid}');
  print('valid == invalid: ${valid == invalid}');
  print(
    'valid.hashCode == valid.hashCode: ${valid.hashCode == SemanticsValidationResult.valid.hashCode}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INDEX-BASED ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  for (var i = 0; i < values.length; i++) {
    print('values[$i]: ${values[i].name}');
  }

  print('First: ${values.first}');
  print('Last: ${values.last}');

  print('=== SemanticsValidationResult Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('SemanticsValidationResult'),
        backgroundColor: Colors.green.shade700,
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
              'Validation States',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildValidationCard(
              none,
              Colors.grey,
              'No validation information is attached to this node. This is the default '
                  'state for most semantic nodes. Typically used before validation has occurred '
                  'or for non-input elements.',
              Icons.help_outline,
              'No specific validation feedback is communicated.',
            ),
            _buildValidationCard(
              valid,
              Colors.green,
              'The entered value has been validated and is acceptable. No error message '
                  'should be displayed. Screen readers may announce this as "valid" or with '
                  'a positive tone.',
              Icons.check_circle,
              'Screen reader announces "valid" or "input accepted".',
            ),
            _buildValidationCard(
              invalid,
              Colors.red,
              'The entered value has failed validation. An error message should be '
                  'communicated to the user. This state triggers screen readers to announce '
                  'the error with urgency.',
              Icons.error,
              'Screen reader announces "invalid" with error description.',
            ),
            const SizedBox(height: 16),

            _buildFormValidationDemo(),
            const SizedBox(height: 16),

            _buildValidationStateFlow(),
            const SizedBox(height: 16),

            _buildComparisonTable(),
            const SizedBox(height: 16),

            _buildUsageExamples(),
            const SizedBox(height: 16),

            _buildAccessibilityBestPractices(),
            const SizedBox(height: 16),

            _buildApiSection(),
            const SizedBox(height: 20),

            // Summary footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Icon(Icons.verified, color: Colors.green.shade700, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    'SemanticsValidationResult enables accessible form validation '
                    'by communicating input states (none, valid, invalid) to '
                    'assistive technologies for better user feedback.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14,
                      height: 1.4,
                    ),
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
