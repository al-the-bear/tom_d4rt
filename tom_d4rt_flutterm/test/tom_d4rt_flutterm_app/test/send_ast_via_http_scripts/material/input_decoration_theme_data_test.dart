// D4rt test script: Tests InputDecorationTheme from material
import 'package:flutter/material.dart';

// Helper to build a section header with icon
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 28, bottom: 10, left: 16, right: 16),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withAlpha(40), color.withAlpha(15)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80), width: 1),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a description text
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build an info card with colored border
Widget buildInfoCard(String title, String content, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accentColor.withAlpha(18),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withAlpha(60), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: accentColor, size: 16),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          content,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

// Helper to build a property chip
Widget buildPropertyChip(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
    ),
  );
}

// Helper to wrap a TextField with an InputDecorationTheme inside a Theme
Widget buildThemedTextField({
  required String title,
  required String subtitle,
  required InputDecorationTheme decorTheme,
  String hintText = 'Type something...',
  String labelText = 'Label',
  bool showError = false,
  bool showHelper = false,
  bool showPrefix = false,
  bool showSuffix = false,
}) {
  InputDecoration decoration = InputDecoration(
    hintText: hintText,
    labelText: labelText,
  );
  if (showError) {
    decoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      errorText: 'This field has an error',
    );
  }
  if (showHelper) {
    decoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      helperText: 'Helper text appears here',
    );
  }
  if (showPrefix) {
    decoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: Icon(Icons.search),
    );
  }
  if (showSuffix) {
    decoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      suffixIcon: Icon(Icons.clear),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        SizedBox(height: 10),
        Theme(
          data: ThemeData(
            inputDecorationTheme: decorTheme,
          ),
          child: TextField(
            decoration: decoration,
          ),
        ),
      ],
    ),
  );
}

// Helper to build a comparison row of two themed text fields
Widget buildComparisonRow({
  required String leftTitle,
  required InputDecorationTheme leftTheme,
  required String rightTitle,
  required InputDecorationTheme rightTheme,
  String label = 'Field',
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 6),
              Theme(
                data: ThemeData(inputDecorationTheme: leftTheme),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: label,
                    hintText: 'Hint...',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rightTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 6),
              Theme(
                data: ThemeData(inputDecorationTheme: rightTheme),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: label,
                    hintText: 'Hint...',
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

// Helper to build a nested theme demo
Widget buildNestedThemeDemo({
  required String title,
  required String description,
  required InputDecorationTheme outerTheme,
  required InputDecorationTheme innerTheme,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 2),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Outer Theme',
            style: TextStyle(fontSize: 11, color: Colors.deepPurple),
          ),
        ),
        SizedBox(height: 6),
        Theme(
          data: ThemeData(inputDecorationTheme: outerTheme),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Outer field',
              hintText: 'Styled by outer theme...',
            ),
          ),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Inner Theme (overrides outer)',
            style: TextStyle(fontSize: 11, color: Colors.orange.shade700),
          ),
        ),
        SizedBox(height: 6),
        Theme(
          data: ThemeData(inputDecorationTheme: innerTheme),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Inner field',
              hintText: 'Styled by inner theme...',
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a property reference row
Widget buildPropertyRow(String property, String description, String defaultVal) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            property,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
              Text(
                'Default: ' + defaultVal,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== InputDecorationTheme Deep Demo ===');
  print('Testing InputDecorationTheme properties and visual output');

  // Print property inventory
  print('');
  print('--- Property Inventory ---');
  print('labelStyle: TextStyle for label text');
  print('hintStyle: TextStyle for hint text');
  print('errorStyle: TextStyle for error text');
  print('helperStyle: TextStyle for helper text');
  print('contentPadding: EdgeInsetsGeometry for inner padding');
  print('filled: bool, whether to fill the decoration');
  print('fillColor: Color used when filled is true');
  print('border: InputBorder for all states');
  print('focusedBorder: InputBorder when focused');
  print('enabledBorder: InputBorder when enabled');
  print('errorBorder: InputBorder when error');
  print('focusedErrorBorder: InputBorder when focused + error');
  print('disabledBorder: InputBorder when disabled');
  print('floatingLabelBehavior: FloatingLabelBehavior enum');
  print('floatingLabelAlignment: FloatingLabelAlignment');
  print('isDense: bool, reduces padding');
  print('isCollapsed: bool, removes most decoration');
  print('prefixStyle: TextStyle for prefix text');
  print('suffixStyle: TextStyle for suffix text');
  print('counterStyle: TextStyle for counter text');
  print('floatingLabelStyle: TextStyle for floating label');
  print('iconColor: Color for the icon');
  print('prefixIconColor: Color for prefix icon');
  print('suffixIconColor: Color for suffix icon');
  print('');

  // Theme definitions for demonstrations
  print('--- Creating theme variations ---');

  // 1. Default theme (no customization)
  InputDecorationTheme defaultTheme = InputDecorationTheme();
  print('Created: defaultTheme');

  // 2. Filled theme
  InputDecorationTheme filledTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.blue.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    labelStyle: TextStyle(color: Colors.blue.shade700),
    hintStyle: TextStyle(color: Colors.blue.shade300),
  );
  print('Created: filledTheme (filled=true, fillColor=blue.shade50)');

  // 3. Outline border theme
  InputDecorationTheme outlineTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.teal, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.teal.shade700, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.teal.shade300, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
    ),
    labelStyle: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w500),
    hintStyle: TextStyle(color: Colors.teal.shade200),
  );
  print('Created: outlineTheme (rounded outline borders)');

  // 4. Underline border theme
  InputDecorationTheme underlineTheme = InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.purple, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.purple.shade700, width: 3),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.purple.shade200, width: 1),
    ),
    labelStyle: TextStyle(color: Colors.purple.shade600),
    hintStyle: TextStyle(color: Colors.purple.shade200),
  );
  print('Created: underlineTheme (underline borders)');

  // 5. Custom text styles theme
  InputDecorationTheme styledTextTheme = InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange.shade700,
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      fontStyle: FontStyle.italic,
      color: Colors.orange.shade300,
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.red.shade700,
    ),
    helperStyle: TextStyle(
      fontSize: 11,
      color: Colors.green.shade600,
    ),
    floatingLabelStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.deepOrange,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  print('Created: styledTextTheme (custom label/hint/error styles)');

  // 6. Dense padding theme
  InputDecorationTheme densePaddingTheme = InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade700),
    hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
    filled: true,
    fillColor: Colors.grey.shade50,
  );
  print('Created: densePaddingTheme (isDense=true, small padding)');

  // 7. Spacious padding theme
  InputDecorationTheme spaciousPaddingTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.green.shade300, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.green.shade700, width: 3),
    ),
    labelStyle: TextStyle(fontSize: 16, color: Colors.green.shade700),
    hintStyle: TextStyle(fontSize: 14, color: Colors.green.shade300),
    filled: true,
    fillColor: Colors.green.shade50,
  );
  print('Created: spaciousPaddingTheme (large padding)');

  // 8. Floating label auto theme
  InputDecorationTheme floatAutoTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: Colors.cyan.shade700),
    floatingLabelStyle: TextStyle(color: Colors.cyan.shade900, fontWeight: FontWeight.bold),
    filled: true,
    fillColor: Colors.cyan.shade50,
  );
  print('Created: floatAutoTheme (FloatingLabelBehavior.auto)');

  // 9. Floating label always theme
  InputDecorationTheme floatAlwaysTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: Colors.amber.shade800),
    floatingLabelStyle: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
    filled: true,
    fillColor: Colors.amber.shade50,
  );
  print('Created: floatAlwaysTheme (FloatingLabelBehavior.always)');

  // 10. Floating label never theme
  InputDecorationTheme floatNeverTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: Colors.pink.shade700),
    filled: true,
    fillColor: Colors.pink.shade50,
  );
  print('Created: floatNeverTheme (FloatingLabelBehavior.never)');

  // 11. Heavy border radius theme
  InputDecorationTheme pillTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.indigo.shade300, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.indigo, width: 3),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.indigo.shade200, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    filled: true,
    fillColor: Colors.indigo.shade50,
    labelStyle: TextStyle(color: Colors.indigo.shade700),
    hintStyle: TextStyle(color: Colors.indigo.shade300),
    prefixIconColor: Colors.indigo,
    suffixIconColor: Colors.indigo.shade300,
  );
  print('Created: pillTheme (borderRadius=30, pill shape)');

  // 12. Square border theme
  InputDecorationTheme squareTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.brown.shade400, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.brown.shade800, width: 3),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.brown.shade300, width: 2),
    ),
    filled: true,
    fillColor: Colors.brown.shade50,
    labelStyle: TextStyle(color: Colors.brown.shade700),
    hintStyle: TextStyle(color: Colors.brown.shade300),
  );
  print('Created: squareTheme (borderRadius=zero, sharp corners)');

  // 13. Outer theme for nesting demo
  InputDecorationTheme outerNestTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.blue.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue.shade700, width: 3),
    ),
    labelStyle: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
  );
  print('Created: outerNestTheme (for nesting demo)');

  // 14. Inner theme for nesting demo
  InputDecorationTheme innerNestTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.red.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.red.shade700, width: 3),
    ),
    labelStyle: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
  );
  print('Created: innerNestTheme (for nesting demo)');

  // 15. Icon color theme
  InputDecorationTheme iconColorTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.lime.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.lime.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.lime.shade700, width: 2),
    ),
    prefixIconColor: Colors.green.shade700,
    suffixIconColor: Colors.red.shade400,
    iconColor: Colors.lime.shade800,
    labelStyle: TextStyle(color: Colors.lime.shade800),
    hintStyle: TextStyle(color: Colors.lime.shade400),
  );
  print('Created: iconColorTheme (prefix/suffix/icon colors)');

  print('');
  print('--- Building UI sections ---');

  // Build all UI sections
  List<Widget> sections = [];

  // Title section
  sections.add(
    Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade700, Colors.indigo.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.indigo.withAlpha(60), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.text_fields, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'InputDecorationTheme',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Configures the default appearance of InputDecoration for TextField and TextFormField widgets across the widget tree.',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text(
            'Package: flutter/material.dart',
            style: TextStyle(fontSize: 11, color: Colors.white54),
          ),
        ],
      ),
    ),
  );

  // --- Section 1: Default TextField ---
  print('Building: Section 1 - Default TextField');
  sections.add(
    buildSectionHeader('1. Default TextField', Icons.text_snippet, Colors.grey.shade700),
  );
  sections.add(
    buildDescription('A TextField with no InputDecorationTheme applied, showing Flutter defaults.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Default (No Theme)',
      subtitle: 'Uses Flutter built-in underline decoration defaults',
      decorTheme: defaultTheme,
      labelText: 'Default Label',
      hintText: 'Default hint text...',
    ),
  );
  sections.add(
    buildInfoCard(
      'Default behavior',
      'Without InputDecorationTheme, TextField uses an underline border with default system colors for labels, hints, and errors.',
      Colors.grey,
    ),
  );

  // --- Section 2: Filled Style ---
  print('Building: Section 2 - Filled Style');
  sections.add(
    buildSectionHeader('2. Filled Style Theme', Icons.format_color_fill, Colors.blue),
  );
  sections.add(
    buildDescription('Setting filled: true and fillColor creates solid-background fields with no visible underline.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Filled TextField',
      subtitle: 'filled=true, fillColor=blue.shade50, borderSide=none',
      decorTheme: filledTheme,
      labelText: 'Filled Field',
      hintText: 'Enter your data...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Filled with Error',
      subtitle: 'Same filled theme but showing error state',
      decorTheme: filledTheme,
      labelText: 'Email Address',
      hintText: 'user@example.com',
      showError: true,
    ),
  );
  sections.add(
    buildInfoCard(
      'Filled style notes',
      'When filled is true, the fillColor is drawn behind the input text. Set borderSide to none (via OutlineInputBorder) to remove visible borders and rely on the fill color for visual boundary.',
      Colors.blue,
    ),
  );

  // --- Section 3: Outline Border Style ---
  print('Building: Section 3 - Outline Border Style');
  sections.add(
    buildSectionHeader('3. Outline Border Style', Icons.crop_square, Colors.teal),
  );
  sections.add(
    buildDescription('OutlineInputBorder draws a rounded rectangle around the field with configurable radius.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Outlined TextField',
      subtitle: 'OutlineInputBorder with borderRadius=12, teal color scheme',
      decorTheme: outlineTheme,
      labelText: 'Username',
      hintText: 'Enter username...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Outlined with Helper',
      subtitle: 'Same outline theme with helperText displayed',
      decorTheme: outlineTheme,
      labelText: 'Password',
      hintText: 'At least 8 characters',
      showHelper: true,
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Outlined with Error',
      subtitle: 'Shows the errorBorder styling',
      decorTheme: outlineTheme,
      labelText: 'Confirm',
      hintText: 'Re-enter password',
      showError: true,
    ),
  );

  // --- Section 4: Underline Border Style ---
  print('Building: Section 4 - Underline Border Style');
  sections.add(
    buildSectionHeader('4. Underline Border Style', Icons.horizontal_rule, Colors.purple),
  );
  sections.add(
    buildDescription('UnderlineInputBorder shows only a bottom line. Good for minimal, Material Design 2 style inputs.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Underline TextField',
      subtitle: 'UnderlineInputBorder with purple color scheme',
      decorTheme: underlineTheme,
      labelText: 'Full Name',
      hintText: 'John Doe',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Underline with Prefix Icon',
      subtitle: 'Adds a search icon before the field',
      decorTheme: underlineTheme,
      labelText: 'Search',
      hintText: 'Search something...',
      showPrefix: true,
    ),
  );

  // --- Section 5: Custom Label/Hint/Error Styles ---
  print('Building: Section 5 - Custom Text Styles');
  sections.add(
    buildSectionHeader('5. Custom Text Styles', Icons.text_format, Colors.deepOrange),
  );
  sections.add(
    buildDescription('Customize labelStyle, hintStyle, errorStyle, helperStyle, and floatingLabelStyle.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Bold Label, Italic Hint',
      subtitle: 'labelStyle=bold/deepOrange, hintStyle=italic/orange.shade300',
      decorTheme: styledTextTheme,
      labelText: 'Styled Label',
      hintText: 'Italic hint text here...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Custom Error Style',
      subtitle: 'errorStyle=bold/red.shade700 for prominent errors',
      decorTheme: styledTextTheme,
      labelText: 'Critical Field',
      hintText: 'Must not be empty',
      showError: true,
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Custom Helper Style',
      subtitle: 'helperStyle=green.shade600 for guidance text',
      decorTheme: styledTextTheme,
      labelText: 'Optional Notes',
      hintText: 'Add any extra info...',
      showHelper: true,
    ),
  );

  // --- Section 6: Content Padding Variations ---
  print('Building: Section 6 - Content Padding');
  sections.add(
    buildSectionHeader('6. Content Padding Variations', Icons.padding, Colors.green),
  );
  sections.add(
    buildDescription('contentPadding and isDense control the inner spacing of the field.'),
  );
  sections.add(
    buildComparisonRow(
      leftTitle: 'Dense (isDense=true)',
      leftTheme: densePaddingTheme,
      rightTitle: 'Spacious (large padding)',
      rightTheme: spaciousPaddingTheme,
      label: 'Compare',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Dense Compact Field',
      subtitle: 'isDense=true, contentPadding=8h/4v, small text',
      decorTheme: densePaddingTheme,
      labelText: 'Compact',
      hintText: 'Tight...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Spacious Roomy Field',
      subtitle: 'contentPadding=24h/20v, larger text, rounded corners',
      decorTheme: spaciousPaddingTheme,
      labelText: 'Spacious',
      hintText: 'Lots of room...',
    ),
  );
  sections.add(
    buildInfoCard(
      'Padding tips',
      'isDense reduces both horizontal and vertical padding. Combine with small fontSize for compact form layouts. Use larger contentPadding for prominent search bars or hero inputs.',
      Colors.green,
    ),
  );

  // --- Section 7: Floating Label Behavior ---
  print('Building: Section 7 - Floating Label Behavior');
  sections.add(
    buildSectionHeader('7. Floating Label Behavior', Icons.label, Colors.cyan),
  );
  sections.add(
    buildDescription('FloatingLabelBehavior controls when the label floats above the field.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'FloatingLabelBehavior.auto',
      subtitle: 'Label floats when focused or when field has content (default)',
      decorTheme: floatAutoTheme,
      labelText: 'Auto Float',
      hintText: 'Focus to see label float...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'FloatingLabelBehavior.always',
      subtitle: 'Label is always in the floating position above the field',
      decorTheme: floatAlwaysTheme,
      labelText: 'Always Float',
      hintText: 'Label stays above...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'FloatingLabelBehavior.never',
      subtitle: 'Label never floats - acts like placeholder text instead',
      decorTheme: floatNeverTheme,
      labelText: 'Never Float',
      hintText: 'Label disappears on focus...',
    ),
  );
  sections.add(
    buildInfoCard(
      'FloatingLabelBehavior',
      'auto: floats on focus/content. always: always floating above. never: label disappears when focused and replaced by hint. Use always for forms where context is critical.',
      Colors.cyan,
    ),
  );

  // --- Section 8: Side-by-Side Comparison ---
  print('Building: Section 8 - Side-by-Side Comparison');
  sections.add(
    buildSectionHeader('8. Style Comparisons', Icons.compare, Colors.deepPurple),
  );
  sections.add(
    buildDescription('Comparing different InputDecorationTheme configurations side by side.'),
  );
  sections.add(
    buildComparisonRow(
      leftTitle: 'Filled',
      leftTheme: filledTheme,
      rightTitle: 'Outlined',
      rightTheme: outlineTheme,
      label: 'Name',
    ),
  );
  sections.add(
    buildComparisonRow(
      leftTitle: 'Underline',
      leftTheme: underlineTheme,
      rightTitle: 'Pill Shape',
      rightTheme: pillTheme,
      label: 'Email',
    ),
  );
  sections.add(
    buildComparisonRow(
      leftTitle: 'Dense',
      leftTheme: densePaddingTheme,
      rightTitle: 'Square',
      rightTheme: squareTheme,
      label: 'Code',
    ),
  );

  // --- Section 9: Border Radius and Decorations ---
  print('Building: Section 9 - Border Radius and Decorations');
  sections.add(
    buildSectionHeader('9. Border Radius Variations', Icons.rounded_corner, Colors.indigo),
  );
  sections.add(
    buildDescription('Different borderRadius values dramatically change the field appearance.'),
  );
  sections.add(
    buildThemedTextField(
      title: 'Pill Shape (radius=30)',
      subtitle: 'Large borderRadius creates search-bar-like appearance',
      decorTheme: pillTheme,
      labelText: 'Search',
      hintText: 'Search anything...',
      showPrefix: true,
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Pill with Suffix',
      subtitle: 'Pill shape with a clear icon on the right',
      decorTheme: pillTheme,
      labelText: 'Filter',
      hintText: 'Filter results...',
      showSuffix: true,
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Square Corners (radius=0)',
      subtitle: 'Zero borderRadius for a strictly rectangular look',
      decorTheme: squareTheme,
      labelText: 'Terminal Input',
      hintText: '$ command...',
    ),
  );
  sections.add(
    buildThemedTextField(
      title: 'Icon Colors Theme',
      subtitle: 'prefixIconColor=green, suffixIconColor=red, iconColor=lime',
      decorTheme: iconColorTheme,
      labelText: 'Status',
      hintText: 'Check status...',
      showPrefix: true,
    ),
  );
  sections.add(
    buildInfoCard(
      'Border radius guide',
      'borderRadius=0 for sharp rectangular fields. 8-12 for subtle rounding. 20-30 for pill/search bar shapes. Match border radius with the overall app design language.',
      Colors.indigo,
    ),
  );

  // --- Section 10: Nested Themes ---
  print('Building: Section 10 - Nested Themes');
  sections.add(
    buildSectionHeader('10. Nested Theme Overrides', Icons.layers, Colors.deepPurple),
  );
  sections.add(
    buildDescription('Inner Theme overrides properties from the outer Theme for its subtree.'),
  );
  sections.add(
    buildNestedThemeDemo(
      title: 'Blue Outer vs Red Inner',
      description: 'Outer: blue fill, rounded. Inner: red fill, sharp corners.',
      outerTheme: outerNestTheme,
      innerTheme: innerNestTheme,
    ),
  );
  sections.add(
    buildNestedThemeDemo(
      title: 'Pill Outer vs Dense Inner',
      description: 'Outer: pill shape, indigo. Inner: dense compact, grey.',
      outerTheme: pillTheme,
      innerTheme: densePaddingTheme,
    ),
  );
  sections.add(
    buildInfoCard(
      'Nested theme behavior',
      'When a child widget is inside multiple Theme widgets, the closest ancestor Theme wins. This allows section-specific styling without affecting the rest of the app.',
      Colors.deepPurple,
    ),
  );

  // --- Section 11: Property Reference ---
  print('Building: Section 11 - Property Reference');
  sections.add(
    buildSectionHeader('11. Property Reference', Icons.menu_book, Colors.blueGrey),
  );
  sections.add(
    buildDescription('Quick reference of all InputDecorationTheme properties with defaults.'),
  );
  sections.add(SizedBox(height: 4));
  sections.add(
    buildPropertyRow('labelStyle', 'TextStyle for the input label text', 'null (theme default)'),
  );
  sections.add(
    buildPropertyRow('floatingLabelStyle', 'TextStyle when the label is floating', 'null (falls back to labelStyle)'),
  );
  sections.add(
    buildPropertyRow('hintStyle', 'TextStyle for hint text shown when empty', 'null (theme default)'),
  );
  sections.add(
    buildPropertyRow('errorStyle', 'TextStyle for error message below field', 'null (theme default)'),
  );
  sections.add(
    buildPropertyRow('helperStyle', 'TextStyle for helper text below field', 'null (theme default)'),
  );
  sections.add(
    buildPropertyRow('helperMaxLines', 'Max lines for helper text', 'null (unlimited)'),
  );
  sections.add(
    buildPropertyRow('errorMaxLines', 'Max lines for error text', 'null (unlimited)'),
  );
  sections.add(
    buildPropertyRow('contentPadding', 'Inner padding of the input area', 'varies by border type'),
  );
  sections.add(
    buildPropertyRow('isDense', 'Reduces the height and padding', 'false'),
  );
  sections.add(
    buildPropertyRow('isCollapsed', 'Removes extra space for label/error', 'false'),
  );
  sections.add(
    buildPropertyRow('filled', 'Whether to fill background with fillColor', 'false'),
  );
  sections.add(
    buildPropertyRow('fillColor', 'Background color when filled is true', 'null (theme default)'),
  );
  sections.add(
    buildPropertyRow('focusColor', 'Fill color override when focused', 'null'),
  );
  sections.add(
    buildPropertyRow('hoverColor', 'Fill color override when hovered', 'null'),
  );
  sections.add(
    buildPropertyRow('border', 'InputBorder for all states (base)', 'UnderlineInputBorder'),
  );
  sections.add(
    buildPropertyRow('focusedBorder', 'InputBorder when the field is focused', 'null (uses border)'),
  );
  sections.add(
    buildPropertyRow('enabledBorder', 'InputBorder when enabled but not focused', 'null (uses border)'),
  );
  sections.add(
    buildPropertyRow('errorBorder', 'InputBorder when error is present', 'null (uses border)'),
  );
  sections.add(
    buildPropertyRow('focusedErrorBorder', 'InputBorder when focused + error', 'null (uses border)'),
  );
  sections.add(
    buildPropertyRow('disabledBorder', 'InputBorder when the field is disabled', 'null (uses border)'),
  );
  sections.add(
    buildPropertyRow('floatingLabelBehavior', 'auto, always, or never', 'FloatingLabelBehavior.auto'),
  );
  sections.add(
    buildPropertyRow('floatingLabelAlignment', 'Horizontal alignment of float label', 'FloatingLabelAlignment.start'),
  );
  sections.add(
    buildPropertyRow('iconColor', 'Color for the leading icon', 'null'),
  );
  sections.add(
    buildPropertyRow('prefixIconColor', 'Color for the prefix icon', 'null'),
  );
  sections.add(
    buildPropertyRow('suffixIconColor', 'Color for the suffix icon', 'null'),
  );
  sections.add(
    buildPropertyRow('prefixStyle', 'TextStyle for prefix text', 'null'),
  );
  sections.add(
    buildPropertyRow('suffixStyle', 'TextStyle for suffix text', 'null'),
  );
  sections.add(
    buildPropertyRow('counterStyle', 'TextStyle for counter text', 'null'),
  );
  sections.add(
    buildPropertyRow('alignLabelWithHint', 'Aligns label with hint text position', 'null'),
  );
  sections.add(
    buildPropertyRow('constraints', 'BoxConstraints for the input field', 'null'),
  );

  // --- Section 12: Property chips overview ---
  print('Building: Section 12 - Property Chips');
  sections.add(
    buildSectionHeader('12. Property Categories', Icons.category, Colors.teal),
  );
  sections.add(
    buildDescription('Visual grouping of InputDecorationTheme property categories.'),
  );
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Styles',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
          ),
          SizedBox(height: 6),
          Wrap(
            children: [
              buildPropertyChip('labelStyle', Colors.blue),
              buildPropertyChip('floatingLabelStyle', Colors.blue),
              buildPropertyChip('hintStyle', Colors.blue),
              buildPropertyChip('errorStyle', Colors.blue),
              buildPropertyChip('helperStyle', Colors.blue),
              buildPropertyChip('prefixStyle', Colors.blue),
              buildPropertyChip('suffixStyle', Colors.blue),
              buildPropertyChip('counterStyle', Colors.blue),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Borders',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.teal.shade700),
          ),
          SizedBox(height: 6),
          Wrap(
            children: [
              buildPropertyChip('border', Colors.teal),
              buildPropertyChip('focusedBorder', Colors.teal),
              buildPropertyChip('enabledBorder', Colors.teal),
              buildPropertyChip('errorBorder', Colors.teal),
              buildPropertyChip('focusedErrorBorder', Colors.teal),
              buildPropertyChip('disabledBorder', Colors.teal),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Fill and Color',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.orange.shade700),
          ),
          SizedBox(height: 6),
          Wrap(
            children: [
              buildPropertyChip('filled', Colors.orange),
              buildPropertyChip('fillColor', Colors.orange),
              buildPropertyChip('focusColor', Colors.orange),
              buildPropertyChip('hoverColor', Colors.orange),
              buildPropertyChip('iconColor', Colors.orange),
              buildPropertyChip('prefixIconColor', Colors.orange),
              buildPropertyChip('suffixIconColor', Colors.orange),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Layout',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.purple.shade700),
          ),
          SizedBox(height: 6),
          Wrap(
            children: [
              buildPropertyChip('contentPadding', Colors.purple),
              buildPropertyChip('isDense', Colors.purple),
              buildPropertyChip('isCollapsed', Colors.purple),
              buildPropertyChip('constraints', Colors.purple),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Floating Label',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green.shade700),
          ),
          SizedBox(height: 6),
          Wrap(
            children: [
              buildPropertyChip('floatingLabelBehavior', Colors.green),
              buildPropertyChip('floatingLabelAlignment', Colors.green),
              buildPropertyChip('alignLabelWithHint', Colors.green),
            ],
          ),
        ],
      ),
    ),
  );

  // --- Debug Print Summary ---
  print('');
  print('--- Theme Summary ---');
  print('Total themes created: 15');
  print('Themes: default, filled, outline, underline, styledText, dense, spacious');
  print('Themes: floatAuto, floatAlways, floatNever, pill, square');
  print('Themes: outerNest, innerNest, iconColor');
  print('');
  print('--- Visual Sections ---');
  print('1. Default TextField (no theme)');
  print('2. Filled Style (filled=true, fillColor)');
  print('3. Outline Border Style (OutlineInputBorder)');
  print('4. Underline Border Style (UnderlineInputBorder)');
  print('5. Custom Text Styles (label, hint, error, helper, floating)');
  print('6. Content Padding (isDense, contentPadding)');
  print('7. Floating Label Behavior (auto, always, never)');
  print('8. Side-by-Side Comparisons');
  print('9. Border Radius Variations (pill, square, icon colors)');
  print('10. Nested Theme Overrides');
  print('11. Property Reference Table');
  print('12. Property Categories (chips)');
  print('');
  print('=== InputDecorationTheme demo build complete ===');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    ),
  );
}
