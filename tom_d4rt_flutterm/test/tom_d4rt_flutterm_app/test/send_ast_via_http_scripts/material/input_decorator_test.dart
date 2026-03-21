// D4rt test script: Tests InputDecorator from material
import 'package:flutter/material.dart';

// Helper: section header with icon and gradient background
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper: info card with label and description
Widget buildInfoCard(String label, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color)),
              SizedBox(height: 2),
              Text(description,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: wrap an InputDecorator with margin and optional background
Widget buildDecoratorCard(Widget decorator, Color bgColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: decorator,
  );
}

// Main entry point
dynamic build(BuildContext context) {
  print('InputDecorator deep demo: starting build');

  // Section 1: Basic InputDecorators with label, hint, and helper
  print('Section 1: Basic label, hint, and helper text');
  final Widget basicSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Basic Labels & Hints', Icons.text_fields, Colors.indigo),
      buildInfoCard(
          'InputDecorator',
          'Wraps any widget and applies InputDecoration styling including labels, hints, and helper text.',
          Colors.indigo),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            helperText: 'First and last name required',
          ),
          child: Text('John Doe',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'user@example.com',
            helperText: 'We will never share your email',
            helperStyle: TextStyle(color: Colors.teal, fontSize: 11),
          ),
          child: Text('alice@example.com',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.indigo.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            hintText: '+1 (555) 000-0000',
            helperText: 'Include country code',
            labelStyle: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.w600),
          ),
          child: Text('+1 (555) 123-4567',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          isEmpty: true,
          decoration: InputDecoration(
            labelText: 'Empty Field',
            hintText: 'This field is empty - notice the label position',
            helperText: 'isEmpty controls label animation',
          ),
          child: Text('',
              style: TextStyle(fontSize: 16)),
        ),
        Colors.grey.shade50,
      ),
    ],
  );

  // Section 2: Prefix and Suffix Icons
  print('Section 2: Prefix and suffix icon configurations');
  final Widget iconSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Prefix & Suffix Icons', Icons.star_border, Colors.orange),
      buildInfoCard('prefixIcon / suffixIcon',
          'Place icons before or after the input area to provide visual context.',
          Colors.orange),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Type to search...',
            prefixIcon: Icon(Icons.search, color: Colors.orange),
          ),
          child: Text('Flutter widgets',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter password',
            prefixIcon: Icon(Icons.lock, color: Colors.orange.shade700),
            suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
          ),
          child: Text('********',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.orange.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Website URL',
            hintText: 'https://example.com',
            prefixIcon: Icon(Icons.language, color: Colors.blue),
            suffixIcon: Icon(Icons.open_in_new, color: Colors.blue.shade300),
          ),
          child: Text('https://flutter.dev',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Amount',
            hintText: '0.00',
            prefixIcon: Icon(Icons.attach_money, color: Colors.green),
            suffixIcon: Icon(Icons.calculate, color: Colors.green.shade300),
            icon: Icon(Icons.account_balance_wallet, color: Colors.grey),
          ),
          child: Text('1,250.00',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.green.shade50,
      ),
    ],
  );

  // Section 3: Outline border vs underline border
  print('Section 3: Outline border vs underline border styles');
  final Widget borderSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Border Styles', Icons.border_all, Colors.teal),
      buildInfoCard('OutlineInputBorder vs UnderlineInputBorder',
          'Two built-in border types: outline draws a rectangle, underline draws only the bottom edge.',
          Colors.teal),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Outline Border',
            hintText: 'Rectangle border around the field',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Outlined content',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Underline Border (default)',
            hintText: 'Bottom edge decoration only',
            border: UnderlineInputBorder(),
          ),
          child: Text('Underlined content',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.teal.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Rounded Outline',
            hintText: 'Large border radius',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.teal, width: 2),
            ),
          ),
          child: Text('Rounded border',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'No Border',
            hintText: 'InputBorder.none removes the border',
            border: InputBorder.none,
          ),
          child: Text('Borderless input',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.grey.shade100,
      ),
    ],
  );

  // Section 4: Error state
  print('Section 4: Error state with errorText and errorStyle');
  final Widget errorSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Error State', Icons.error_outline, Colors.red),
      buildInfoCard('errorText / errorStyle / errorBorder',
          'Display validation errors beneath the field with custom styling and border colors.',
          Colors.red),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: 'Username is already taken',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 2),
            ),
          ),
          child: Text('admin',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: 'Please enter a valid email address',
            errorStyle: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
                fontSize: 12),
            errorMaxLines: 2,
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange, width: 2),
            ),
            prefixIcon: Icon(Icons.email, color: Colors.red.shade300),
          ),
          child: Text('not-an-email',
              style: TextStyle(fontSize: 16, color: Colors.red.shade700)),
        ),
        Colors.red.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: 'Must be at least 8 characters with one uppercase letter and one number',
            errorMaxLines: 3,
            errorStyle: TextStyle(fontSize: 11, color: Colors.red),
            border: UnderlineInputBorder(),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.red.shade200),
            suffixIcon: Icon(Icons.warning_amber, color: Colors.amber),
          ),
          child: Text('abc',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
        ),
        Colors.white,
      ),
    ],
  );

  // Section 5: Focused state styling
  print('Section 5: Focused state styling with focusedBorder');
  final Widget focusedSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Focused State', Icons.center_focus_strong, Colors.blue),
      buildInfoCard('focusedBorder / focusedErrorBorder',
          'Custom borders applied when the field gains focus. These override the default border.',
          Colors.blue),
      buildDecoratorCard(
        InputDecorator(
          isFocused: true,
          decoration: InputDecoration(
            labelText: 'Focused Outline',
            hintText: 'This field appears focused',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Active input here',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.blue.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          isFocused: true,
          decoration: InputDecoration(
            labelText: 'Focused Underline',
            hintText: 'Thick underline when focused',
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 3),
            ),
            floatingLabelStyle: TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          child: Text('Purple focused',
              style: TextStyle(fontSize: 16, color: Colors.purple)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          isFocused: true,
          decoration: InputDecoration(
            labelText: 'Focused with Error',
            errorText: 'This field has an error while focused',
            border: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('Error + focused',
              style: TextStyle(fontSize: 16, color: Colors.deepOrange)),
        ),
        Colors.orange.shade50,
      ),
    ],
  );

  // Section 6: Filled vs unfilled backgrounds
  print('Section 6: Filled vs unfilled backgrounds');
  final Widget filledSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Filled vs Unfilled', Icons.format_color_fill, Colors.purple),
      buildInfoCard('filled / fillColor',
          'Set filled: true to add a background color behind the input area. Combine with fillColor for custom tones.',
          Colors.purple),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Unfilled (default)',
            hintText: 'No background fill',
            filled: false,
            border: OutlineInputBorder(),
          ),
          child: Text('No fill',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Filled Default',
            hintText: 'Uses theme default fill',
            filled: true,
            border: UnderlineInputBorder(),
          ),
          child: Text('Default fill color',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Custom Fill Color',
            hintText: 'Light purple background',
            filled: true,
            fillColor: Colors.purple.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('Purple fill',
              style: TextStyle(fontSize: 16, color: Colors.purple)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Teal Filled',
            hintText: 'Teal background with outline',
            filled: true,
            fillColor: Colors.teal.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.teal),
            ),
            prefixIcon: Icon(Icons.eco, color: Colors.teal),
          ),
          child: Text('Filled with icon',
              style: TextStyle(fontSize: 16, color: Colors.teal.shade700)),
        ),
        Colors.white,
      ),
    ],
  );

  // Section 7: Floating label behavior
  print('Section 7: FloatingLabelBehavior modes');
  final Widget floatingLabelSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Floating Label Behavior', Icons.label, Colors.deepOrange),
      buildInfoCard('FloatingLabelBehavior',
          'Controls when the label floats above the input: always, auto (default), or never.',
          Colors.deepOrange),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Always Floating',
            hintText: 'Label always stays above',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          isEmpty: true,
          child: Text('',
              style: TextStyle(fontSize: 16)),
        ),
        Colors.deepOrange.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Auto Floating (with content)',
            hintText: 'Label floats when content is present',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(),
          ),
          child: Text('Some content here',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          isEmpty: true,
          decoration: InputDecoration(
            labelText: 'Auto Floating (empty)',
            hintText: 'Label centered when empty, floats on focus',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(),
          ),
          child: Text('',
              style: TextStyle(fontSize: 16)),
        ),
        Colors.grey.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Never Floating',
            hintText: 'Label never moves above',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
          ),
          child: Text('Content present',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          isFocused: true,
          decoration: InputDecoration(
            labelText: 'Always + Focused',
            hintText: 'Always float with focused styling',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange, width: 2),
            ),
          ),
          child: Text('Styled floating label',
              style: TextStyle(fontSize: 16, color: Colors.deepOrange)),
        ),
        Colors.deepOrange.shade50,
      ),
    ],
  );

  // Section 8: Prefix/suffix widgets and counter
  print('Section 8: Prefix/suffix widgets and counter text');
  final Widget prefixSuffixSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Prefix/Suffix Widgets & Counter', Icons.widgets, Colors.cyan),
      buildInfoCard('prefix / suffix / counterText',
          'Unlike prefixIcon, prefix and suffix are inline widgets that appear inside the input area. counterText shows character counts.',
          Colors.cyan),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
            prefix: Container(
              padding: EdgeInsets.only(right: 8),
              child: Text('\$',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
            ),
            suffix: Container(
              padding: EdgeInsets.only(left: 8),
              child: Text('USD',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          child: Text('99.99',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Website',
            border: OutlineInputBorder(),
            prefixText: 'https://',
            prefixStyle: TextStyle(color: Colors.cyan.shade700, fontSize: 14),
            suffixText: '.com',
            suffixStyle: TextStyle(color: Colors.cyan.shade600, fontSize: 14),
          ),
          child: Text('mysite',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.cyan.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Bio',
            hintText: 'Tell us about yourself',
            border: OutlineInputBorder(),
            counterText: '42 / 200 characters',
            counterStyle: TextStyle(
                fontSize: 11,
                color: Colors.cyan.shade600),
          ),
          child: Text('I love building Flutter apps and exploring new widgets',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Discount Code',
            border: OutlineInputBorder(),
            prefix: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('CODE',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade800)),
            ),
            suffix: Icon(Icons.check_circle, color: Colors.green, size: 20),
            counterText: 'Valid code applied',
            counterStyle: TextStyle(color: Colors.green, fontSize: 11),
          ),
          child: Text('SAVE20',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        Colors.amber.shade50,
      ),
    ],
  );

  // Section 9: Dense vs normal
  print('Section 9: Dense vs normal InputDecorator');
  final Widget denseSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Dense vs Normal', Icons.compress, Colors.brown),
      buildInfoCard('isDense',
          'When isDense is true, the decorator reduces vertical spacing. Useful in forms with many fields.',
          Colors.brown),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Normal Density',
            hintText: 'Default vertical spacing',
            helperText: 'isDense: false (default)',
            border: OutlineInputBorder(),
            isDense: false,
            prefixIcon: Icon(Icons.person, color: Colors.brown),
          ),
          child: Text('Normal spacing',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Dense',
            hintText: 'Reduced vertical spacing',
            helperText: 'isDense: true',
            border: OutlineInputBorder(),
            isDense: true,
            prefixIcon: Icon(Icons.person, color: Colors.brown),
          ),
          child: Text('Dense spacing',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.brown.shade50,
      ),
      Row(
        children: [
          Expanded(
            child: buildDecoratorCard(
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Normal',
                  border: OutlineInputBorder(),
                  isDense: false,
                ),
                child: Text('A',
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
              ),
              Colors.white,
            ),
          ),
          Expanded(
            child: buildDecoratorCard(
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Dense',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                child: Text('B',
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
              ),
              Colors.brown.shade50,
            ),
          ),
        ],
      ),
    ],
  );

  // Section 10: Content padding customization
  print('Section 10: Content padding customization');
  final Widget paddingSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Content Padding', Icons.padding, Colors.green),
      buildInfoCard('contentPadding',
          'Override the default padding inside the decorator to achieve custom layouts.',
          Colors.green),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Default Padding',
            helperText: 'No contentPadding override',
            border: OutlineInputBorder(),
          ),
          child: Text('Default',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Large Padding',
            helperText: 'contentPadding: EdgeInsets.all(24)',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(24),
          ),
          child: Text('Spacious input area',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.green.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Small Padding',
            helperText: 'contentPadding: EdgeInsets.all(4)',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(4),
          ),
          child: Text('Compact',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Asymmetric Padding',
            helperText: 'contentPadding: EdgeInsets.fromLTRB(32, 16, 8, 16)',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(32, 16, 8, 16),
          ),
          child: Text('Left-heavy padding',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.green.shade50,
      ),
      buildDecoratorCard(
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Vertical Only',
            helperText: 'contentPadding: EdgeInsets.symmetric(vertical: 20)',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          ),
          child: Text('Tall rows',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Colors.white,
      ),
    ],
  );

  // Section 11: Summary
  print('Section 11: Summary of demonstrated properties');
  final Widget summarySection = Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.teal.shade50],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('InputDecorator Properties Demonstrated:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            Chip(label: Text('labelText', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.indigo.shade100),
            Chip(label: Text('hintText', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.indigo.shade50),
            Chip(label: Text('helperText', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.indigo.shade100),
            Chip(label: Text('prefixIcon', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.orange.shade100),
            Chip(label: Text('suffixIcon', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.orange.shade50),
            Chip(label: Text('icon', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.orange.shade100),
            Chip(label: Text('OutlineInputBorder', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.teal.shade100),
            Chip(label: Text('UnderlineInputBorder', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.teal.shade50),
            Chip(label: Text('InputBorder.none', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.teal.shade100),
            Chip(label: Text('errorText', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.red.shade100),
            Chip(label: Text('errorStyle', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.red.shade50),
            Chip(label: Text('errorBorder', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.red.shade100),
            Chip(label: Text('focusedBorder', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.blue.shade100),
            Chip(label: Text('isFocused', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.blue.shade50),
            Chip(label: Text('filled', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.purple.shade100),
            Chip(label: Text('fillColor', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.purple.shade50),
            Chip(label: Text('FloatingLabelBehavior', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.deepOrange.shade100),
            Chip(label: Text('prefix', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.cyan.shade100),
            Chip(label: Text('suffix', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.cyan.shade50),
            Chip(label: Text('counterText', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.cyan.shade100),
            Chip(label: Text('isDense', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.brown.shade100),
            Chip(label: Text('contentPadding', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.green.shade100),
            Chip(label: Text('isEmpty', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.grey.shade200),
            Chip(label: Text('floatingLabelStyle', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.deepOrange.shade50),
          ],
        ),
        SizedBox(height: 8),
        Text('Total sections: 10 demo groups + summary',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        Text('InputDecorator wraps any widget with Material Design input styling.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    ),
  );

  print('InputDecorator deep demo: assembling final layout');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('InputDecorator Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              basicSection,
              iconSection,
              borderSection,
              errorSection,
              focusedSection,
              filledSection,
              floatingLabelSection,
              prefixSuffixSection,
              denseSection,
              paddingSection,
              summarySection,
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
