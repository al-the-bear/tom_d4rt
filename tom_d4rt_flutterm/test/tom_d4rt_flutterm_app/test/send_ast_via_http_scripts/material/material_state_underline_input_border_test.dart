// ignore_for_file: avoid_print
// WidgetStateUnderlineInputBorder Deep Demo Test
// Tests state-responsive underline input borders for TextField widgets
// Demonstrates focus, error, disabled, hovered states affecting underline appearance

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('WidgetStateUnderlineInputBorder Demo'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              '1. Basic WidgetStateUnderlineInputBorder State Resolution',
            ),
            _buildInfoCard(
              'WidgetStateUnderlineInputBorder resolves to different underline borders based on widget state. '
              'It implements WidgetStateProperty<InputBorder> interface for dynamic border styling.',
              Colors.teal.shade50,
            ),
            _buildBasicStateResolvingDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('2. TextField with State-Responsive Underline'),
            _buildInfoCard(
              'TextField changes underline color and thickness when focused vs unfocused. '
              'The underline adapts dynamically to user interaction.',
              Colors.blue.shade50,
            ),
            _buildFocusStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('3. Error State Underline Styling'),
            _buildInfoCard(
              'When field has validation error, underline switches to error styling with red color and increased thickness. '
              'WidgetState.error triggers the error appearance.',
              Colors.red.shade50,
            ),
            _buildErrorStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('4. Disabled State Underline Appearance'),
            _buildInfoCard(
              'Disabled fields show muted, thin grey underlines. '
              'WidgetState.disabled triggers greyed-out appearance.',
              Colors.grey.shade200,
            ),
            _buildDisabledStateDemo(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '5. Multiple TextFields with Different Underline Configurations',
            ),
            _buildInfoCard(
              'Different TextFields can have entirely different underline configurations, '
              'creating varied visual behaviors within the same form.',
              Colors.purple.shade50,
            ),
            _buildMultipleConfigurationsDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('6. BorderSide Color/Width Per State'),
            _buildInfoCard(
              'Underline width and color can change dramatically between states, '
              'making state transitions more prominent and accessible.',
              Colors.orange.shade50,
            ),
            _buildBorderSideDemo(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '7. Regular UnderlineInputBorder vs WidgetStateUnderlineInputBorder',
            ),
            _buildInfoCard(
              'Comparing static UnderlineInputBorder with dynamic WidgetStateUnderlineInputBorder '
              'shows the flexibility advantage of state-responsive borders.',
              Colors.cyan.shade50,
            ),
            _buildComparisonDemo(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '8. Form with Multiple Underline-Decorated Fields',
            ),
            _buildInfoCard(
              'A complete form using state-responsive underlines on all fields, '
              'demonstrating cohesive form styling with consistent behavior.',
              Colors.green.shade50,
            ),
            _buildFormDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('9. State Variations Grid'),
            _buildInfoCard(
              'Visual grid showing all widget states and their corresponding '
              'underline appearances for reference.',
              Colors.amber.shade50,
            ),
            _buildStateVariationsGrid(),
            SizedBox(height: 24),

            _buildSectionHeader('10. Interactive TextField Showcase'),
            _buildInfoCard(
              'Live interactive fields demonstrating real-time underline state changes '
              'as user interacts with them. Focus, hover, and type to see changes.',
              Colors.lime.shade50,
            ),
            _buildInteractiveShowcase(),
            SizedBox(height: 24),

            _buildSectionHeader('11. Underline with Custom Gap Padding'),
            _buildInfoCard(
              'UnderlineInputBorder supports gap padding for floating labels. '
              'Different padding values affect underline appearance.',
              Colors.indigo.shade50,
            ),
            _buildGapPaddingDemo(),
            SizedBox(height: 24),

            _buildSectionHeader('12. Themed Underline Borders'),
            _buildInfoCard(
              'Using InputDecorationTheme to apply consistent underline styling '
              'across multiple fields without repeating configuration.',
              Colors.deepOrange.shade50,
            ),
            _buildThemedUnderlineDemo(),
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
        colors: [Colors.teal.shade700, Colors.teal.shade500],
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

Widget _buildColorIndicator(Color color, String label) {
  return Column(
    children: [
      Container(
        width: 50,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade700)),
    ],
  );
}

String _colorToHex(Color color) {
  int argb =
      ((color.a * 255).round() << 24) |
      ((color.r * 255).round() << 16) |
      ((color.g * 255).round() << 8) |
      (color.b * 255).round();
  return '#${argb.toRadixString(16).toUpperCase().padLeft(8, '0')}';
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
        Text(
          'State Resolution Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLabeledField(
                'Default Unfocused',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Normal',
                    hintText: 'Grey underline',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildLabeledField(
                'Focused State',
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Focus me',
                    hintText: 'Teal underline on focus',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
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
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'WidgetStateUnderlineInputBorder.resolveWith((states) => ...) allows dynamic underline resolution.',
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
        Text(
          'Focus State Transitions:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Click to see underline change',
            hintText: 'Underline becomes blue and thicker on focus',
            prefixIcon: Icon(Icons.edit),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 3),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Alternative focus style',
            hintText: 'Green thick underline on focus',
            prefixIcon: Icon(Icons.search),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade600, width: 3),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Purple accent underline',
            hintText: 'Purple gradient effect simulated',
            prefixIcon: Icon(Icons.palette),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple.shade200, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple.shade700, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorIndicator(Colors.grey.shade300, 'Unfocused'),
            SizedBox(width: 20),
            Icon(Icons.arrow_forward, color: Colors.grey),
            SizedBox(width: 20),
            _buildColorIndicator(Colors.blue, 'Focused'),
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
        Text(
          'Error State Underline Styling:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Required Field',
            errorText: 'This field is required',
            prefixIcon: Icon(Icons.warning_amber),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.5),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 3),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Field',
            errorText: 'Invalid email format',
            prefixIcon: Icon(Icons.email),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password Field',
            errorText: 'Password must be at least 8 characters',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.visibility_off),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade600, width: 2.5),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade800, width: 3),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Error underlines are thicker and use red/orange colors for visibility',
                  style: TextStyle(fontSize: 12, color: Colors.red.shade700),
                ),
              ),
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
        Text(
          'Disabled State Underlines:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Disabled Field',
            hintText: 'Cannot interact',
            prefixIcon: Icon(Icons.block),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          enabled: false,
          controller: TextEditingController(text: 'Pre-filled disabled value'),
          decoration: InputDecoration(
            labelText: 'Disabled with Value',
            prefixIcon: Icon(Icons.person),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          enabled: false,
          controller: TextEditingController(text: 'john.doe@example.com'),
          decoration: InputDecoration(
            labelText: 'Disabled Email',
            prefixIcon: Icon(Icons.email_outlined),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorIndicator(Colors.grey.shade300, 'Thin'),
            SizedBox(width: 8),
            Text('Disabled = ', style: TextStyle(fontSize: 12)),
            SizedBox(width: 8),
            _buildColorIndicator(Colors.grey.shade400, 'Muted'),
          ],
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
        Text(
          'Various Underline Configurations:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Blue Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Green Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Orange Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Purple Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pink Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Teal Theme',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal.shade700,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBorderSideDemo() {
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
        Text(
          'BorderSide Width Variations:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildLabeledField(
          'Width: 1px (thin)',
          TextField(
            decoration: InputDecoration(
              hintText: 'Thin underline',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700, width: 1),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Width: 2px (medium)',
          TextField(
            decoration: InputDecoration(
              hintText: 'Medium underline',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade400, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Width: 3px (thick)',
          TextField(
            decoration: InputDecoration(
              hintText: 'Thick underline',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade400, width: 3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700, width: 3),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'Width: 4px (extra thick)',
          TextField(
            decoration: InputDecoration(
              hintText: 'Extra thick underline',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade400, width: 4),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700, width: 4),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Different widths can indicate importance or state prominence',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
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
        Text('Comparison Demo:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Regular UnderlineInputBorder',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Static border',
                  hintText: 'Same appearance regardless of state',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WidgetStateUnderlineInputBorder',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Dynamic border',
                  hintText: 'Changes based on state',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Icon(Icons.remove, color: Colors.grey),
                    Text('Static', style: TextStyle(fontSize: 12)),
                    Text(
                      'No state changes',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.teal),
                    Text('Dynamic', style: TextStyle(fontSize: 12)),
                    Text(
                      'State-responsive',
                      style: TextStyle(fontSize: 10, color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        Row(
          children: [
            Icon(Icons.assignment, color: Colors.green.shade700),
            SizedBox(width: 8),
            Text(
              'Registration Form',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person_outline),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            prefixIcon: Icon(Icons.email_outlined),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2),
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility_off),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility_off),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text('Register', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateVariationsGrid() {
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
        Text(
          'State Reference Grid:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.amber.shade100),
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'State',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Underline Color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Width',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _buildStateTableRow('Enabled', Colors.grey.shade400, '1px'),
            _buildStateTableRow('Focused', Colors.teal, '2px'),
            _buildStateTableRow('Hovered', Colors.teal.shade300, '1.5px'),
            _buildStateTableRow('Error', Colors.red, '2px'),
            _buildStateTableRow('Focused+Error', Colors.red.shade700, '2.5px'),
            _buildStateTableRow('Disabled', Colors.grey.shade300, '0.5px'),
          ],
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStateChip('Enabled', Colors.grey),
            _buildStateChip('Focused', Colors.teal),
            _buildStateChip('Hovered', Colors.blue),
            _buildStateChip('Error', Colors.red),
            _buildStateChip('Disabled', Colors.grey.shade400),
          ],
        ),
      ],
    ),
  );
}

TableRow _buildStateTableRow(String state, Color color, String width) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(state, style: TextStyle(fontSize: 13)),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text(
              _colorToHex(color),
              style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(width, style: TextStyle(fontSize: 13)),
      ),
    ],
  );
}

Widget _buildStateChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
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
        Text(
          'Interactive Fields:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Click, hover, and type in these fields to see underline changes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: Icon(Icons.account_circle),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lime.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lime.shade700, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Search Query',
            hintText: 'What are you looking for?',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo.shade200, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo.shade600, width: 2.5),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Comment',
            hintText: 'Add a comment...',
            prefixIcon: Icon(Icons.chat_bubble_outline),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber.shade700, width: 2.5),
            ),
          ),
          maxLines: 2,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Amount',
            hintText: '0.00',
            prefixIcon: Icon(Icons.attach_money),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade300, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 2.5),
            ),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.lime.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: Colors.lime.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Focus any field to see the underline respond dynamically',
                  style: TextStyle(fontSize: 12, color: Colors.lime.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildGapPaddingDemo() {
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
        Text(
          'UnderlineInputBorder Gap Padding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildLabeledField(
          'borderGap: 4.0 (default)',
          TextField(
            decoration: InputDecoration(
              labelText: 'Default Gap',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildLabeledField(
          'With Dense Padding',
          TextField(
            decoration: InputDecoration(
              labelText: 'Dense Field',
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildLabeledField(
          'With Content Padding',
          TextField(
            decoration: InputDecoration(
              labelText: 'Padded Field',
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildLabeledField(
          'Floating Label Behavior: Always',
          TextField(
            decoration: InputDecoration(
              labelText: 'Always Floating',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade400, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildThemedUnderlineDemo() {
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
        Text(
          'Themed Input Fields:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Using InputDecorationTheme for consistent styling',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange.shade700,
                  width: 2.5,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade600, width: 2),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade800, width: 2.5),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
              labelStyle: TextStyle(color: Colors.deepOrange.shade700),
              floatingLabelStyle: TextStyle(color: Colors.deepOrange.shade700),
            ),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Themed Field 1',
                  hintText: 'First themed input',
                  prefixIcon: Icon(Icons.star),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Themed Field 2',
                  hintText: 'Second themed input',
                  prefixIcon: Icon(Icons.favorite),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Themed Field 3',
                  hintText: 'Third themed input',
                  prefixIcon: Icon(Icons.bookmark),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Themed Disabled',
                  hintText: 'Disabled themed input',
                  prefixIcon: Icon(Icons.block),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.palette, color: Colors.deepOrange.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All fields inherit underline styling from InputDecorationTheme',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.deepOrange.shade800,
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
