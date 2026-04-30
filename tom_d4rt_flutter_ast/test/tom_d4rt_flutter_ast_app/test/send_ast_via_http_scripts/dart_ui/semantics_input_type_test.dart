// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive visual demonstration of SemanticsInputType from dart_ui
// This enum describes the type of input for semantic text fields, enabling accessibility
// services to provide appropriate keyboard layouts and input suggestions.
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Must be declared before build() for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════════

/// Builds the main header section explaining SemanticsInputType
Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.indigo.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.3),
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
              child: const Icon(Icons.keyboard, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SemanticsInputType',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dart:ui enum',
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
            'Describes the type of input expected in a semantic text field. '
            'This information helps accessibility services provide appropriate '
            'keyboard layouts and input suggestions for different types of content.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

/// Builds a card displaying information about an input type value
Widget _buildInputTypeCard(
  SemanticsInputType type,
  Color color,
  String description,
  IconData icon,
  String keyboardHint,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SemanticsInputType.${type.name}',
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Index: ${type.index}',
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
        // Description
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
              const SizedBox(height: 12),
              // Keyboard hint
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_alt_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      keyboardHint,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
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
  );
}

/// Builds the visual keyboard type selection panel
Widget _buildKeyboardTypesPanel() {
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
            Icon(Icons.keyboard, color: Colors.indigo.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Keyboard Types by Input Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildKeyboardRow(
          'none',
          'Default Keyboard',
          Colors.grey,
          Icons.keyboard_outlined,
        ),
        const SizedBox(height: 8),
        _buildKeyboardRow(
          'text',
          'Text Keyboard',
          Colors.blue,
          Icons.text_fields,
        ),
        const SizedBox(height: 8),
        _buildKeyboardRow(
          'url',
          'URL Keyboard (.com, /)',
          Colors.green,
          Icons.link,
        ),
        const SizedBox(height: 8),
        _buildKeyboardRow(
          'phone',
          'Phone Dial Pad',
          Colors.orange,
          Icons.dialpad,
        ),
        const SizedBox(height: 8),
        _buildKeyboardRow(
          'search',
          'Search Keyboard (Go)',
          Colors.purple,
          Icons.search,
        ),
        const SizedBox(height: 8),
        _buildKeyboardRow(
          'email',
          'Email Keyboard (@)',
          Colors.red,
          Icons.email,
        ),
      ],
    ),
  );
}

/// Builds a single keyboard type row
Widget _buildKeyboardRow(
  String typeName,
  String keyboardName,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            typeName,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Icon(Icons.arrow_forward, color: Colors.grey.shade400, size: 16),
        const SizedBox(width: 8),
        Text(
          keyboardName,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
        ),
      ],
    ),
  );
}

/// Builds the form field examples section
Widget _buildFormFieldExamples() {
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
            Icon(Icons.edit_note, color: Colors.teal.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Form Field Examples',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Form preview
        _buildFormField(
          'Username',
          SemanticsInputType.text,
          Colors.blue,
          Icons.person,
        ),
        const SizedBox(height: 12),
        _buildFormField(
          'Email Address',
          SemanticsInputType.email,
          Colors.red,
          Icons.email,
        ),
        const SizedBox(height: 12),
        _buildFormField(
          'Phone Number',
          SemanticsInputType.phone,
          Colors.orange,
          Icons.phone,
        ),
        const SizedBox(height: 12),
        _buildFormField(
          'Website URL',
          SemanticsInputType.url,
          Colors.green,
          Icons.link,
        ),
        const SizedBox(height: 12),
        _buildFormField(
          'Search Query',
          SemanticsInputType.search,
          Colors.purple,
          Icons.search,
        ),
      ],
    ),
  );
}

/// Builds a styled form field preview
Widget _buildFormField(
  String label,
  SemanticsInputType type,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type.name,
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
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter $label...',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

/// Builds the accessibility benefits section
Widget _buildAccessibilityBenefits() {
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
            Icon(
              Icons.accessibility_new,
              color: Colors.amber.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Accessibility Benefits',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          'Optimized Keyboards',
          'Screen readers can present the most appropriate virtual keyboard for each input type',
          Icons.keyboard_alt,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Input Validation Hints',
          'Assistive technologies can provide format hints (e.g., "expects email format")',
          Icons.check_circle_outline,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Voice Input Adaptation',
          'Voice control systems can adapt recognition for the expected input type',
          Icons.mic,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Auto-Complete Suggestions',
          'Saved data suggestions are filtered by input type (emails, phones, etc.)',
          Icons.auto_awesome,
        ),
      ],
    ),
  );
}

/// Builds a single benefit item row
Widget _buildBenefitItem(String title, String description, IconData icon) {
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

/// Builds the comparison table section
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
            Icon(
              Icons.table_chart,
              color: Colors.deepPurple.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Input Type Characteristics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade700,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: const Row(
            children: [
              Expanded(flex: 2, child: _HeaderCell('Type')),
              Expanded(flex: 3, child: _HeaderCell('Best For')),
              Expanded(flex: 2, child: _HeaderCell('Keyboard')),
            ],
          ),
        ),
        // Table rows
        _buildTableRow('none', 'Non-text fields', 'Default', 0),
        _buildTableRow('text', 'Names, messages', 'Standard', 1),
        _buildTableRow('url', 'Web addresses', '.com / keys', 2),
        _buildTableRow('phone', 'Phone numbers', 'Dial pad', 3),
        _buildTableRow('search', 'Search queries', 'Go button', 4),
        _buildTableRow('email', 'Email addresses', '@ symbol', 5),
      ],
    ),
  );
}

/// Builds a table row
Widget _buildTableRow(String type, String bestFor, String keyboard, int index) {
  final isEven = index % 2 == 0;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: isEven ? Colors.grey.shade50 : Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200),
        left: BorderSide(color: Colors.grey.shade200),
        right: BorderSide(color: Colors.grey.shade200),
      ),
      borderRadius: index == 5
          ? const BorderRadius.vertical(bottom: Radius.circular(8))
          : null,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            bestFor,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            keyboard,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

/// Builds the use cases section
Widget _buildUseCases() {
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
            Icon(Icons.lightbulb, color: Colors.cyan.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildUseCase(
          'Login Forms',
          'Use email type for username/email field, text type for passwords',
          Icons.login,
          Colors.blue,
        ),
        const SizedBox(height: 10),
        _buildUseCase(
          'Registration',
          'Use phone for phone number, email for email, text for name fields',
          Icons.app_registration,
          Colors.green,
        ),
        const SizedBox(height: 10),
        _buildUseCase(
          'Contact Forms',
          'Combine email, phone, and text types for comprehensive contact info',
          Icons.contact_mail,
          Colors.orange,
        ),
        const SizedBox(height: 10),
        _buildUseCase(
          'Search Interfaces',
          'Use search type for query fields, url type for direct address entry',
          Icons.search,
          Colors.purple,
        ),
      ],
    ),
  );
}

/// Builds a single use case card
Widget _buildUseCase(
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
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
        _buildApiRow('Values', 'none, text, url, phone, search, email'),
        _buildApiRow('Properties', '.name, .index'),
        _buildApiRow('Static', 'SemanticsInputType.values (List)'),
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
  print('=== SemanticsInputType Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUMERATE ALL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = SemanticsInputType.values;
  print('Total values: ${values.length}');

  for (final v in values) {
    print('SemanticsInputType.${v.name}: index=${v.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final none = SemanticsInputType.none;
  final text = SemanticsInputType.text;
  final url = SemanticsInputType.url;
  final phone = SemanticsInputType.phone;
  final search = SemanticsInputType.search;
  final email = SemanticsInputType.email;

  print('none: $none, index=${none.index}');
  print('text: $text, index=${text.index}');
  print('url: $url, index=${url.index}');
  print('phone: $phone, index=${phone.index}');
  print('search: $search, index=${search.index}');
  print('email: $email, index=${email.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('text == text: ${text == SemanticsInputType.text}');
  print('text == email: ${text == email}');
  print(
    'text.hashCode == text.hashCode: ${text.hashCode == SemanticsInputType.text.hashCode}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INDEX-BASED ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  for (var i = 0; i < values.length; i++) {
    print('values[$i]: ${values[i].name}');
  }

  print('First: ${values.first}');
  print('Last: ${values.last}');

  print('=== SemanticsInputType Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('SemanticsInputType'),
        backgroundColor: Colors.indigo.shade700,
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
              'Input Type Values',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInputTypeCard(
              none,
              Colors.grey,
              'The default value for non-text fields. Used when no specific input '
                  'type semantics are needed.',
              Icons.block,
              'Default keyboard',
            ),
            _buildInputTypeCard(
              text,
              Colors.blue,
              'Describes a generic text field for entering free-form text content '
                  'such as names, messages, or descriptions.',
              Icons.text_fields,
              'Standard text keyboard',
            ),
            _buildInputTypeCard(
              url,
              Colors.green,
              'Describes a text field for entering web addresses. The keyboard may '
                  'include .com, /, and other URL-related keys.',
              Icons.link,
              'URL keyboard with .com, / keys',
            ),
            _buildInputTypeCard(
              phone,
              Colors.orange,
              'Describes a text field for entering phone numbers. Typically shows '
                  'a numeric dial pad for easier entry.',
              Icons.phone,
              'Numeric dial pad',
            ),
            _buildInputTypeCard(
              search,
              Colors.purple,
              'Describes a search field. The keyboard may include a "Go" or "Search" '
                  'button instead of return.',
              Icons.search,
              'Search keyboard with Go button',
            ),
            _buildInputTypeCard(
              email,
              Colors.red,
              'Describes a text field for entering email addresses. The keyboard '
                  'includes @ symbol and may provide email suggestions.',
              Icons.email,
              'Email keyboard with @ symbol',
            ),
            const SizedBox(height: 20),

            _buildKeyboardTypesPanel(),
            const SizedBox(height: 16),

            _buildFormFieldExamples(),
            const SizedBox(height: 16),

            _buildAccessibilityBenefits(),
            const SizedBox(height: 16),

            _buildComparisonTable(),
            const SizedBox(height: 16),

            _buildUseCases(),
            const SizedBox(height: 16),

            _buildApiSection(),
            const SizedBox(height: 20),

            // Summary footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.indigo.shade700,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SemanticsInputType helps accessibility services provide '
                    'the best user experience for text input by indicating '
                    'what type of content is expected.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo.shade700,
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
