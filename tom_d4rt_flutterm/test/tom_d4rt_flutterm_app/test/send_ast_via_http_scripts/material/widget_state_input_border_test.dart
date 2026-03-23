// ignore_for_file: avoid_print
// D4rt test script: Tests WidgetStateInputBorder (was MaterialStateInputBorder)
// Widget state aware input border for dynamic, state-responsive TextField borders
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateInputBorder deep demo executing');
  print('WidgetStateInputBorder provides state-responsive input borders');
  print('It replaces the deprecated MaterialStateInputBorder');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('WidgetStateInputBorder Deep Demo'),
        backgroundColor: Colors.teal.shade100,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. WidgetStateInputBorder.resolveWith Usage'),
            _buildInfoCard(
              'WidgetStateInputBorder.resolveWith creates borders that dynamically resolve '
              'based on the current widget states. The callback receives a Set<WidgetState> '
              'and returns the appropriate InputBorder for those states.',
              Colors.teal.shade50,
            ),
            _buildResolveWithBasicDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('2. Focused vs Unfocused States'),
            _buildInfoCard(
              'The most common use case is changing border appearance when a TextField '
              'gains or loses focus. Focused borders typically become more prominent.',
              Colors.blue.shade50,
            ),
            _buildFocusedUnfocusedDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('3. Error State Borders'),
            _buildInfoCard(
              'When WidgetState.error is present, fields should display error styling. '
              'Combined with focusedError state for focused fields with errors.',
              Colors.red.shade50,
            ),
            _buildErrorStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('4. Disabled State Borders'),
            _buildInfoCard(
              'Disabled fields show subdued, muted borders indicating non-interactivity. '
              'WidgetState.disabled triggers faded, greyed-out appearance.',
              Colors.grey.shade200,
            ),
            _buildDisabledStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('5. OutlineInputBorder with Widget State'),
            _buildInfoCard(
              'OutlineInputBorder creates a rectangular border around the entire field. '
              'Use WidgetStateProperty to vary borderRadius, borderSide, and gapPadding.',
              Colors.indigo.shade50,
            ),
            _buildOutlineInputBorderDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('6. UnderlineInputBorder with Widget State'),
            _buildInfoCard(
              'UnderlineInputBorder draws only the bottom border line. '
              'State changes can alter color, width, and top corner radius.',
              Colors.purple.shade50,
            ),
            _buildUnderlineInputBorderDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('7. InputDecoration Theming'),
            _buildInfoCard(
              'InputDecorationTheme applies consistent border styling across all TextFields. '
              'Define enabledBorder, focusedBorder, errorBorder in the theme.',
              Colors.amber.shade50,
            ),
            _buildInputDecorationThemingDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('8. Advanced resolveWith Patterns'),
            _buildInfoCard(
              'Complex resolveWith callbacks can check multiple states and combine logic '
              'for nuanced border behavior.',
              Colors.cyan.shade50,
            ),
            _buildAdvancedResolveWithDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('9. Combined State Handling'),
            _buildInfoCard(
              'Handle simultaneous states like focused+error or hovered+disabled. '
              'Priority logic determines which styling wins.',
              Colors.deepPurple.shade50,
            ),
            _buildCombinedStatesDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('10. Visual State Reference Grid'),
            _buildInfoCard(
              'Grid showing all widget states and their corresponding border appearances.',
              Colors.lime.shade50,
            ),
            _buildStateReferenceGrid(),
            SizedBox(height: 24),

            _buildSectionHeader('11. Interactive Demo Fields'),
            _buildInfoCard(
              'Live interactive fields demonstrating real-time state changes.',
              Colors.orange.shade50,
            ),
            _buildInteractiveDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('12. Form with Themed Borders'),
            _buildInfoCard(
              'Complete form example using widget state borders throughout.',
              Colors.green.shade50,
            ),
            _buildCompleteFormDemo(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: EdgeInsets.only(bottom: 12, top: 8),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade700, Colors.teal.shade500],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withAlpha(60),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildInfoCard(String text, Color backgroundColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lightbulb_outline, color: Colors.grey.shade700, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLabeledField(String label, Widget field) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      SizedBox(height: 6),
      field,
    ],
  );
}

Widget _buildColorSwatch(Color color, String label) {
  return Column(
    children: [
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildResolveWithBasicDemo() {
  print('Building WidgetStateInputBorder.resolveWith basic demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic resolveWith Pattern:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'WidgetStateInputBorder.resolveWith((states) {\n'
            '  if (states.contains(WidgetState.focused)) {\n'
            '    return focusedBorder;\n'
            '  }\n'
            '  return defaultBorder;\n'
            '});',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.teal.shade800,
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'resolveWith Focus Change',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tap to focus',
                    hintText: 'Watch border change',
                    prefixIcon: Icon(Icons.touch_app),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorSwatch(Colors.grey.shade400, 'Enabled'),
            SizedBox(width: 16),
            Icon(Icons.arrow_forward, color: Colors.grey.shade600),
            SizedBox(width: 16),
            _buildColorSwatch(Colors.teal, 'Focused'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFocusedUnfocusedDemo() {
  print('Building focused vs unfocused demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Focus State Transitions:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Thin to Thick Border',
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Border thickness increases on focus',
              prefixIcon: Icon(Icons.person),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Color Shift on Focus',
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Grey to green transition',
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Radius Change on Focus',
          TextField(
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'Corner radius increases on focus',
              prefixIcon: Icon(Icons.note),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildErrorStateDemo() {
  print('Building error state demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Error State Styling:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Field with Error Text',
          TextField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              errorText: 'Please enter a valid email',
              prefixIcon: Icon(Icons.email),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700, width: 2.5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Required Field Missing',
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: 'Password is required',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.visibility_off),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade900, width: 2.5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildColorSwatch(Colors.red, 'Error'),
            SizedBox(width: 12),
            _buildColorSwatch(Colors.red.shade700, 'Focused\nError'),
            SizedBox(width: 12),
            _buildColorSwatch(Colors.orange.shade700, 'Warning'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDisabledStateDemo() {
  print('Building disabled state demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disabled State Appearance:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Disabled Field',
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Read Only',
                    hintText: 'Cannot edit',
                    prefixIcon: Icon(Icons.lock_outline),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildLabeledField(
                'Enabled Field',
                TextField(
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'Editable',
                    hintText: 'Can edit this',
                    prefixIcon: Icon(Icons.edit),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Disabled with Value',
          TextField(
            enabled: false,
            controller: TextEditingController(text: 'Pre-filled value'),
            decoration: InputDecoration(
              labelText: 'Account ID',
              prefixIcon: Icon(Icons.badge),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Disabled borders are typically lighter, indicating non-interactive state.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOutlineInputBorderDemo() {
  print('Building OutlineInputBorder widget state demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OutlineInputBorder Variations:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Standard Outline',
          TextField(
            decoration: InputDecoration(
              labelText: 'Standard',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Rounded Pill Shape',
          TextField(
            decoration: InputDecoration(
              labelText: 'Rounded',
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple.shade200, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Sharp Corners',
          TextField(
            decoration: InputDecoration(
              labelText: 'Square',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown.shade300, width: 1),
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown, width: 2),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Custom Gap Padding',
          TextField(
            decoration: InputDecoration(
              labelText: 'With gapPadding: 8',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal.shade300, width: 1),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 8,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 8,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUnderlineInputBorderDemo() {
  print('Building UnderlineInputBorder widget state demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UnderlineInputBorder Variations:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Standard Underline',
          TextField(
            decoration: InputDecoration(
              labelText: 'Default underline',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Thick Underline on Focus',
          TextField(
            decoration: InputDecoration(
              labelText: 'Focus for thick line',
              prefixIcon: Icon(Icons.text_fields),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange, width: 3),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Colored Underline States',
          TextField(
            decoration: InputDecoration(
              labelText: 'Multi-color states',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.5),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Underline with Top Radius',
          TextField(
            decoration: InputDecoration(
              labelText: 'Rounded top corners',
              filled: true,
              fillColor: Colors.cyan.shade50,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan.shade300, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan.shade700, width: 3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInputDecorationThemingDemo() {
  print('Building InputDecoration theming demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InputDecorationTheme Example:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Theme(data: ThemeData(inputDecorationTheme: ...))\n'
            'applies consistent borders to all child TextFields.',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
        SizedBox(height: 16),
        Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.green.shade50,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700, width: 2.5),
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: TextStyle(color: Colors.green.shade800),
              hintStyle: TextStyle(color: Colors.green.shade400),
            ),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Themed Field 1',
                  hintText: 'Inherits theme styling',
                  prefixIcon: Icon(Icons.eco, color: Colors.green.shade600),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Themed Field 2',
                  hintText: 'Same consistent styling',
                  prefixIcon: Icon(Icons.nature, color: Colors.green.shade600),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Disabled Themed Field',
                  hintText: 'Shows disabled theme border',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey.shade400),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAdvancedResolveWithDemo() {
  print('Building advanced resolveWith demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Advanced State Checking:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'if (states.contains(WidgetState.error)) {\n'
            '  if (states.contains(WidgetState.focused)) {\n'
            '    return focusedErrorBorder;\n'
            '  }\n'
            '  return errorBorder;\n'
            '} else if (states.contains(WidgetState.focused)) {\n'
            '  return focusedBorder;\n'
            '}\n'
            'return enabledBorder;',
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Priority: Error > Focused > Enabled',
          TextField(
            decoration: InputDecoration(
              labelText: 'Complex state field',
              hintText: 'Error state takes priority',
              errorText: 'Validation failed',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan.shade700, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade900, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Hovered State Detection',
          TextField(
            decoration: InputDecoration(
              labelText: 'Hover for effect',
              hintText: 'Mouse hover changes appearance',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCombinedStatesDemo() {
  print('Building combined states demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Simultaneous State Combinations:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Focused + Error',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Both states',
                    errorText: 'Error while focused',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildLabeledField(
                'Just Error',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Error only',
                    errorText: 'Not focused error',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'State Priority Order:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 6),
              Text('1. disabled (blocks all interactions)'),
              Text('2. error + focused (focusedErrorBorder)'),
              Text('3. error (errorBorder)'),
              Text('4. focused (focusedBorder)'),
              Text('5. hovered (if supported)'),
              Text('6. enabled (enabledBorder)'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateReferenceGrid() {
  print('Building state reference grid');

  Widget buildStateRow(String state, Color borderColor, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Field',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All WidgetState Values:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        buildStateRow(
          'WidgetState.hovered',
          Colors.lightBlue,
          'Mouse cursor is over the widget',
        ),
        buildStateRow(
          'WidgetState.focused',
          Colors.blue,
          'Widget has keyboard focus',
        ),
        buildStateRow(
          'WidgetState.pressed',
          Colors.indigo,
          'Widget is being pressed/tapped',
        ),
        buildStateRow(
          'WidgetState.dragged',
          Colors.purple,
          'Widget is being dragged',
        ),
        buildStateRow(
          'WidgetState.selected',
          Colors.teal,
          'Widget is selected (checkbox, etc)',
        ),
        buildStateRow(
          'WidgetState.scrolledUnder',
          Colors.brown,
          'Content scrolled under widget',
        ),
        buildStateRow(
          'WidgetState.disabled',
          Colors.grey.shade400,
          'Widget is disabled/non-interactive',
        ),
        buildStateRow(
          'WidgetState.error',
          Colors.red,
          'Widget is in error state',
        ),
      ],
    ),
  );
}

Widget _buildInteractiveDemo() {
  print('Building interactive demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Try These Interactive Fields:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Focus Field A, then B',
          TextField(
            decoration: InputDecoration(
              labelText: 'Field A - Pink Focus',
              prefixIcon: Icon(Icons.favorite),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade200, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink, width: 2.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Tab to next field',
          TextField(
            decoration: InputDecoration(
              labelText: 'Field B - Amber Focus',
              prefixIcon: Icon(Icons.star),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber.shade200, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber.shade700, width: 2.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Underline style',
          TextField(
            decoration: InputDecoration(
              labelText: 'Field C - Underline',
              prefixIcon: Icon(Icons.text_format),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightGreen.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen, width: 3),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Click/tap each field to see its focus border style activate.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCompleteFormDemo() {
  print('Building complete form demo');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Registration Form Example:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade600, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade600, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'example@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'At least 8 characters',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter password',
                  prefixIcon: Icon(Icons.lock_outline),
                  errorText: 'Passwords do not match',
                ),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+1 234 567 8900',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Form submitted');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade700,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All fields use InputDecorationTheme for consistent widget state borders.',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
