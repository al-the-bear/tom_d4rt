// ignore_for_file: avoid_print
// Deep demo: RenderEditablePainter / Editable text painting concepts
// Demonstrates text field cursor styles, selection colors, handles,
// TextSelectionThemeData, InputDecoration borders, text styles,
// validation states, multi-line fields, and readonly/disabled states.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4000695C),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  print('Building info card: $label');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFF80CBC4), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 16, color: Color(0xFF00897B)),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF004D40),
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF00695C)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFieldCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00897B),
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// Section 1: Cursor styles
Widget _buildCursorStylesSection() {
  print('Building cursor styles section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.edit, 'Cursor Styles'),
      _buildInfoCard(
        'RenderEditablePainter',
        'Paints cursor decoration on editable text. Cursor color, width, and radius are configurable.',
      ),
      _buildFieldCard(
        'Red cursor, width 3.0',
        TextField(
          cursorColor: Colors.red,
          cursorWidth: 3.0,
          decoration: InputDecoration(
            hintText: 'Type here - red thick cursor',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      _buildFieldCard(
        'Blue cursor, width 1.0, rounded',
        TextField(
          cursorColor: Colors.blue,
          cursorWidth: 1.0,
          cursorRadius: Radius.circular(4),
          decoration: InputDecoration(
            hintText: 'Type here - blue thin rounded cursor',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      _buildFieldCard(
        'Purple cursor, width 4.0',
        TextField(
          cursorColor: Color(0xFF7B1FA2),
          cursorWidth: 4.0,
          cursorRadius: Radius.circular(2),
          decoration: InputDecoration(
            hintText: 'Type here - wide purple cursor',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      _buildFieldCard(
        'Orange cursor, default width',
        TextField(
          cursorColor: Color(0xFFE65100),
          decoration: InputDecoration(
            hintText: 'Type here - orange default cursor',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ],
  );
}

// Section 2: Selection colors and handles
Widget _buildSelectionColorsSection() {
  print('Building selection colors section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.select_all, 'Selection Colors & Handles'),
      _buildInfoCard(
        'TextSelectionThemeData',
        'Controls selection highlight color and handle color. RenderEditable uses the painter to draw these overlays.',
      ),
      _buildFieldCard(
        'Green selection highlight',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Color(0x6600C853),
              cursorColor: Color(0xFF00C853),
              selectionHandleColor: Color(0xFF00C853),
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: 'Select this green text'),
            decoration: InputDecoration(
              hintText: 'Green selection',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'Pink selection highlight',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Color(0x66F50057),
              cursorColor: Color(0xFFF50057),
              selectionHandleColor: Color(0xFFF50057),
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: 'Select this pink text'),
            decoration: InputDecoration(
              hintText: 'Pink selection',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'Deep purple selection with amber handles',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Color(0x66651FFF),
              cursorColor: Color(0xFF651FFF),
              selectionHandleColor: Color(0xFFFFAB00),
            ),
          ),
          child: TextField(
            controller: TextEditingController(
              text: 'Purple highlight, amber handles',
            ),
            decoration: InputDecoration(
              hintText: 'Purple/amber combo',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 3: InputDecoration border styles
Widget _buildBorderStylesSection() {
  print('Building border styles section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.border_style, 'InputDecoration Border Styles'),
      _buildInfoCard(
        'Underline vs Outline',
        'InputDecoration supports UnderlineInputBorder and OutlineInputBorder with custom colors and radius.',
      ),
      _buildFieldCard(
        'UnderlineInputBorder (default)',
        TextField(
          decoration: InputDecoration(
            labelText: 'Underline border',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00897B), width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00695C), width: 3),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'OutlineInputBorder rounded',
        TextField(
          decoration: InputDecoration(
            labelText: 'Outline rounded',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFF1565C0), width: 3),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'OutlineInputBorder with error',
        TextField(
          decoration: InputDecoration(
            labelText: 'Error-styled border',
            errorText: 'This field has an error',
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFD32F2F), width: 3),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'OutlineInputBorder square corners',
        TextField(
          decoration: InputDecoration(
            labelText: 'Square outline',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xFF6D4C41), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xFF3E2723), width: 3),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 4: Text styling over colored backgrounds
Widget _buildTextStylesSection() {
  print('Building text styles section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.text_fields, 'Text Styles Over Backgrounds'),
      _buildInfoCard(
        'Editable text styling',
        'TextField text style, together with cursor painting, creates the visual editing experience.',
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFF263238),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: Color(0xFF00E676),
          decoration: InputDecoration(
            labelText: 'Light on dark',
            labelStyle: TextStyle(color: Color(0xAAFFFFFF)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4DB6AC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00E676), width: 2),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          style: TextStyle(
            color: Color(0xFF4E342E),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: Color(0xFF4E342E),
          decoration: InputDecoration(
            labelText: 'Bold on warm gradient',
            labelStyle: TextStyle(color: Color(0xFF6D4C41)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8D6E63)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFE8EAF6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          cursorColor: Color(0xFF3F51B5),
          decoration: InputDecoration(
            labelText: 'Italic indigo on lavender',
            labelStyle: TextStyle(color: Color(0xFF5C6BC0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xFF7986CB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 5: TextFormField validation visual states
Widget _buildValidationSection() {
  print('Building validation visual states section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        Icons.verified_user,
        'TextFormField Validation States',
      ),
      _buildInfoCard(
        'Validation visuals',
        'Error text, error border, and helper text provide visual feedback during editing.',
      ),
      _buildFieldCard(
        'Required field with error',
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email address',
            hintText: 'user@example.com',
            errorText: 'Please enter a valid email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'Valid field with helper',
        TextFormField(
          controller: TextEditingController(text: 'john@example.com'),
          decoration: InputDecoration(
            labelText: 'Email address',
            helperText: 'Looks good!',
            helperStyle: TextStyle(color: Color(0xFF2E7D32)),
            prefixIcon: Icon(Icons.email, color: Color(0xFF2E7D32)),
            suffixIcon: Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'Password field with counter',
        TextFormField(
          obscureText: true,
          maxLength: 20,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: 'Min 8 characters',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.visibility_off),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'Warning state (custom)',
        TextFormField(
          controller: TextEditingController(text: 'short'),
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: 'Username is too short (min 6 chars)',
            errorStyle: TextStyle(color: Color(0xFFFF6F00)),
            prefixIcon: Icon(Icons.person, color: Color(0xFFFF6F00)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFFFF6F00), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFFE65100), width: 2),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 6: Multi-line fields
Widget _buildMultiLineSection() {
  print('Building multi-line fields section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.notes, 'Multi-Line Text Fields'),
      _buildInfoCard(
        'maxLines, minLines, expands',
        'Controls how editable text area grows and scrolls. RenderEditable manages layout of multiple lines.',
      ),
      _buildFieldCard(
        'maxLines: 3',
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Limited to 3 lines',
            hintText: 'Type multiple lines here...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'minLines: 2, maxLines: 5',
        TextField(
          minLines: 2,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Grows from 2 to 5 lines',
            hintText: 'Expandable text area...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'maxLines: null (unlimited)',
        TextField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Unlimited lines',
            hintText: 'Grows indefinitely...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'expands: true in SizedBox',
        SizedBox(
          height: 100,
          child: TextField(
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              labelText: 'Fills available height',
              hintText: 'Expands to 100 logical pixels...',
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 7: Readonly vs Enabled vs Disabled
Widget _buildReadonlyDisabledSection() {
  print('Building readonly/enabled/disabled section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.lock_outline, 'Readonly / Enabled / Disabled'),
      _buildInfoCard(
        'Interactive states',
        'Editing states control whether cursor and selection painting occur. RenderEditable tracks editable state.',
      ),
      _buildFieldCard(
        'Normal (editable)',
        TextField(
          controller: TextEditingController(text: 'Editable text'),
          decoration: InputDecoration(
            labelText: 'Normal field',
            suffixIcon: Icon(Icons.edit, color: Color(0xFF00897B)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'readOnly: true',
        TextField(
          controller: TextEditingController(text: 'Read-only content'),
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Read-only field',
            suffixIcon: Icon(Icons.visibility, color: Color(0xFF757575)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'enabled: false',
        TextField(
          controller: TextEditingController(text: 'Disabled content'),
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Disabled field',
            suffixIcon: Icon(Icons.block, color: Color(0xFFBDBDBD)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFFBDBDBD)),
            ),
          ),
        ),
      ),
      _buildFieldCard(
        'readOnly with showCursor',
        TextField(
          controller: TextEditingController(text: 'Read-only but shows cursor'),
          readOnly: true,
          showCursor: true,
          cursorColor: Color(0xFF00897B),
          decoration: InputDecoration(
            labelText: 'Cursor visible, not editable',
            suffixIcon: Icon(Icons.text_format, color: Color(0xFF00897B)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    ],
  );
}

// Section 8: Handle customization via theme
Widget _buildHandleCustomizationSection() {
  print('Building handle customization section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.touch_app, 'Selection Handle Customization'),
      _buildInfoCard(
        'Handle colors via theme',
        'TextSelectionThemeData.selectionHandleColor customizes drag handle appearance on RenderEditable.',
      ),
      _buildFieldCard(
        'Teal handles',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Color(0xFF00897B),
              selectionColor: Color(0x4400897B),
              cursorColor: Color(0xFF00897B),
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: 'Teal selection handles'),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
      _buildFieldCard(
        'Red handles with blue cursor',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Colors.red,
              selectionColor: Color(0x44FF0000),
              cursorColor: Colors.blue,
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: 'Red handles, blue cursor'),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
      _buildFieldCard(
        'Amber handles with deep orange cursor',
        Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Color(0xFFFFC107),
              selectionColor: Color(0x44FFC107),
              cursorColor: Color(0xFFE64A19),
            ),
          ),
          child: TextField(
            controller: TextEditingController(
              text: 'Amber handles, deep orange cursor',
            ),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
    ],
  );
}

// Section 9: Miscellaneous editable features
Widget _buildMiscEditableSection() {
  print('Building miscellaneous editable features section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(Icons.settings, 'Miscellaneous Editable Features'),
      _buildInfoCard(
        'Additional editable text options',
        'maxLength, obscureText, textAlign, keyboardType affect how text is painted and interacted with.',
      ),
      _buildFieldCard(
        'Max length with counter',
        TextField(
          maxLength: 50,
          decoration: InputDecoration(
            labelText: 'Max 50 characters',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'Center-aligned text',
        TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, letterSpacing: 2),
          decoration: InputDecoration(
            hintText: 'Center aligned',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'Right-aligned text',
        TextField(
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Right aligned',
            suffixText: 'USD',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      _buildFieldCard(
        'Dense input with prefix and suffix',
        TextField(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            prefixText: 'https://',
            prefixStyle: TextStyle(color: Color(0xFF757575)),
            suffixText: '.com',
            suffixStyle: TextStyle(color: Color(0xFF757575)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      _buildFieldCard(
        'Filled decoration style',
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF5F5F5),
            labelText: 'Filled text field',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF00897B), width: 2),
            ),
          ),
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  print('RenderEditablePainter deep demo - building');
  print('Demonstrates text editing visual concepts');
  print('Cursor styles, selection, borders, validation, multi-line, readonly');
  print(
    'RenderEditablePainter is the interface for painting decorations on editable text',
  );
  print(
    'RenderEditable delegates visual painting to RenderEditablePainter instances',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          'RenderEditablePainter',
          'Text editing cursor, selection, handles, borders, and visual states',
        ),
        _buildCursorStylesSection(),
        _buildSelectionColorsSection(),
        _buildBorderStylesSection(),
        _buildTextStylesSection(),
        _buildValidationSection(),
        _buildMultiLineSection(),
        _buildReadonlyDisabledSection(),
        _buildHandleCustomizationSection(),
        _buildMiscEditableSection(),
        SizedBox(height: 32),
        Center(
          child: Text(
            'RenderEditablePainter Demo Complete',
            style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
