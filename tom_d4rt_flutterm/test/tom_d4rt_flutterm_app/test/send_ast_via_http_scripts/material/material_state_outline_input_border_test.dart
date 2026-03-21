// WidgetStateOutlineInputBorder Deep Demo Test
// Tests state-responsive outline input borders for TextField widgets
// Demonstrates focus, error, disabled, hovered states affecting border appearance

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('WidgetStateOutlineInputBorder Demo'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic WidgetStateOutlineInputBorder'),
            _buildInfoCard(
              'WidgetStateOutlineInputBorder resolves to different borders based on widget state. '
              'It implements WidgetStateProperty<InputBorder> interface.',
              Colors.indigo.shade50,
            ),
            _buildBasicStateResolvingDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('2. TextField with State-Responsive Border'),
            _buildInfoCard(
              'TextField changes border color and style when focused vs unfocused. '
              'The border adapts dynamically to user interaction.',
              Colors.blue.shade50,
            ),
            _buildFocusStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('3. Error State Border Styling'),
            _buildInfoCard(
              'When field has validation error, border switches to error styling. '
              'WidgetState.error triggers the error appearance.',
              Colors.red.shade50,
            ),
            _buildErrorStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('4. Disabled State Border Appearance'),
            _buildInfoCard(
              'Disabled fields show muted, faded borders. '
              'WidgetState.disabled triggers greyed-out appearance.',
              Colors.grey.shade200,
            ),
            _buildDisabledStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('5. Multiple Configurations'),
            _buildInfoCard(
              'Different TextFields can have entirely different WidgetStateProperty configurations, '
              'creating varied visual behaviors.',
              Colors.purple.shade50,
            ),
            _buildMultipleConfigurationsDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('6. BorderSide Width Changes Per State'),
            _buildInfoCard(
              'Border width can increase when focused or on error, '
              'making the state change more prominent.',
              Colors.orange.shade50,
            ),
            _buildBorderWidthDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('7. BorderRadius Variations Per State'),
            _buildInfoCard(
              'Border radius can change between states - rounder when focused, '
              'sharper when in error state.',
              Colors.teal.shade50,
            ),
            _buildBorderRadiusDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('8. Regular vs WidgetState Border Comparison'),
            _buildInfoCard(
              'Comparing static OutlineInputBorder with dynamic WidgetStateOutlineInputBorder '
              'shows the flexibility advantage.',
              Colors.cyan.shade50,
            ),
            _buildComparisonDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('9. Form with Multiple Decorated Fields'),
            _buildInfoCard(
              'A complete form using state-responsive borders on all fields, '
              'demonstrating cohesive form styling.',
              Colors.green.shade50,
            ),
            _buildFormDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('10. State Summary Grid'),
            _buildInfoCard(
              'Visual grid showing all widget states and their corresponding '
              'border appearances for reference.',
              Colors.amber.shade50,
            ),
            _buildStateSummaryGrid(),
            SizedBox(height: 32),

            _buildSectionHeader('11. Advanced: Combined State Handling'),
            _buildInfoCard(
              'Handling multiple simultaneous states like focused+error, '
              'or hovered+disabled combinations.',
              Colors.deepPurple.shade50,
            ),
            _buildCombinedStatesDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('12. Interactive State Showcase'),
            _buildInfoCard(
              'Live interactive fields demonstrating real-time state changes '
              'as user interacts with them.',
              Colors.lime.shade50,
            ),
            _buildInteractiveShowcase(),
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
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.indigo.shade500],
      ),
      borderRadius: BorderRadius.circular(8),
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
        Icon(Icons.info_outline, color: Colors.grey.shade700, size: 20),
        SizedBox(width: 8),
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

Widget _buildColorBox(Color color, String label) {
  return Column(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400),
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10)),
    ],
  );
}

Widget _buildBasicStateResolvingDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('State Resolution Examples:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Default State',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Normal',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildLabeledField(
                'Focused State Color',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Focus me',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
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
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'WidgetStateOutlineInputBorder.resolveWith((states) => ...) allows dynamic border resolution.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFocusStateDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Focus State Transitions:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Click to see focus border change',
            hintText: 'Border becomes blue and thicker on focus',
            prefixIcon: Icon(Icons.edit),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Alternative focus style',
            hintText: 'Green focus with rounded corners',
            prefixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildColorBox(Colors.grey.shade300, 'Unfocused'),
            SizedBox(width: 16),
            Icon(Icons.arrow_forward, color: Colors.grey),
            SizedBox(width: 16),
            _buildColorBox(Colors.blue, 'Focused'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildErrorStateDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Error State Styling:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Required Field',
            errorText: 'This field is required',
            prefixIcon: Icon(Icons.warning_amber),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Field',
            errorText: 'Invalid email format',
            prefixIcon: Icon(Icons.email),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900, width: 2.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text('Error states have distinct, attention-grabbing borders'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDisabledStateDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Disabled State Appearance:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Enabled Field',
                TextField(
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'Active',
                    hintText: 'Can be edited',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildLabeledField(
                'Disabled Field',
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Disabled',
                    hintText: 'Cannot edit',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          enabled: false,
          controller: TextEditingController(text: 'Pre-filled disabled value'),
          decoration: InputDecoration(
            labelText: 'Read-only with value',
            prefixIcon: Icon(Icons.lock, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade50,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMultipleConfigurationsDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Various Configuration Styles:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _buildLabeledField(
          'Indigo Theme',
          TextField(
            decoration: InputDecoration(
              labelText: 'Indigo borders',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Teal Theme',
          TextField(
            decoration: InputDecoration(
              labelText: 'Teal borders',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Orange Theme',
          TextField(
            decoration: InputDecoration(
              labelText: 'Orange borders',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Pink Theme with rounded corners',
          TextField(
            decoration: InputDecoration(
              labelText: 'Pink borders',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade200, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBorderWidthDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Border Width Variations:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Thin to Thick (1px to 3px)',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Focus to see thick border',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildLabeledField(
                'Very Thick Focus (4px)',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Extra thick focus',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Error gets thickest border (5px)',
          TextField(
            decoration: InputDecoration(
              labelText: 'Error Field',
              errorText: 'Extra prominent error border',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade900, width: 5),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.orange.shade50,
          child: Row(
            children: [
              Container(width: 30, height: 4, color: Colors.grey),
              SizedBox(width: 8),
              Text('Normal: 1px'),
              SizedBox(width: 16),
              Container(width: 30, height: 8, color: Colors.blue),
              SizedBox(width: 8),
              Text('Focused: 2-4px'),
              SizedBox(width: 16),
              Container(width: 30, height: 10, color: Colors.red),
              SizedBox(width: 8),
              Text('Error: 3-5px'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBorderRadiusDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Border Radius Changes Per State:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _buildLabeledField(
          'Sharp corners, rounded on focus',
          TextField(
            decoration: InputDecoration(
              labelText: 'Focus to round corners',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Rounded normal, sharp on error',
          TextField(
            decoration: InputDecoration(
              labelText: 'Error field',
              errorText: 'Square corners on error',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade800, width: 2),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Fully rounded pill shape',
          TextField(
            decoration: InputDecoration(
              labelText: 'Pill-shaped field',
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Static vs Dynamic Border Comparison:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Static OutlineInputBorder', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                    SizedBox(height: 4),
                    Text('Same border always', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Static border',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.cyan.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WidgetState Border', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan.shade700)),
                    SizedBox(height: 4),
                    Text('Changes with state', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Dynamic border',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.cyan.shade50,
          child: Text(
            'WidgetStateOutlineInputBorder resolves borders dynamically based on current widget states, '
            'enabling rich, interactive form experiences.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Complete Form Example:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _buildFormField('Full Name', Icons.person, null),
        SizedBox(height: 12),
        _buildFormField('Email Address', Icons.email, 'Please enter a valid email'),
        SizedBox(height: 12),
        _buildFormField('Phone Number', Icons.phone, null),
        SizedBox(height: 12),
        _buildFormField('Password', Icons.lock, null, isPassword: true),
        SizedBox(height: 12),
        _buildFormField('Confirm Password', Icons.lock_outline, 'Passwords do not match', isPassword: true),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text('Submit Form', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormField(String label, IconData icon, String? errorText, {bool isPassword = false}) {
  return TextField(
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      errorText: errorText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade700, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget _buildStateSummaryGrid() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Widget States Reference:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _buildStateRow('Normal / Enabled', Colors.grey.shade400, 1.0, 'Default idle state'),
        _buildStateRow('Focused', Colors.blue, 2.0, 'Active input focus'),
        _buildStateRow('Hovered', Colors.blue.shade300, 1.5, 'Mouse hover (desktop)'),
        _buildStateRow('Error', Colors.red, 2.0, 'Validation failed'),
        _buildStateRow('Focused + Error', Colors.red.shade800, 2.5, 'Error with focus'),
        _buildStateRow('Disabled', Colors.grey.shade300, 1.0, 'Non-interactive'),
        _buildStateRow('Pressed', Colors.indigo, 2.5, 'Being pressed'),
        _buildStateRow('Selected', Colors.green, 2.0, 'Item selected'),
      ],
    ),
  );
}

Widget _buildStateRow(String stateName, Color borderColor, double width, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: width),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stateName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCombinedStatesDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Combined State Handling:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text(
          'States can combine: a field can be both focused AND in error state. '
          'Border resolution should prioritize appropriately.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Error Only',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Error state',
                    errorText: 'Validation error',
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade300, width: 2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildLabeledField(
                'Focused + Error',
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Focus me (error)',
                    errorText: 'Error persists on focus',
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade300, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade700, width: 3),
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
              Text('State Priority Order:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 6),
              Text('1. Disabled (highest)', style: TextStyle(fontSize: 12)),
              Text('2. Error + Focused', style: TextStyle(fontSize: 12)),
              Text('3. Error', style: TextStyle(fontSize: 12)),
              Text('4. Focused', style: TextStyle(fontSize: 12)),
              Text('5. Hovered', style: TextStyle(fontSize: 12)),
              Text('6. Enabled (default)', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInteractiveShowcase() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Try These Interactive Fields:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _buildLabeledField(
          'Type something here',
          TextField(
            decoration: InputDecoration(
              hintText: 'Watch the border change as you interact',
              prefixIcon: Icon(Icons.keyboard),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lime.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lime.shade700, width: 2.5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Search Field',
          TextField(
            decoration: InputDecoration(
              hintText: 'Pill-shaped search input',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.clear),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Multi-line Text Area',
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Write multiple lines here...',
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade600, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lime.shade100, Colors.amber.shade100],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: Colors.grey.shade700),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Click or tap the fields above to see real-time border transitions!',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
