// D4rt test script: Deep Demo for CupertinoTextField from cupertino
// CupertinoTextField is an iOS-style text input widget
// Provides text entry with iOS styling and behavior
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║               CUPERTINO TEXT FIELD DEEP DEMO                      ║');
  print('║       iOS-Style Text Input with Cupertino Design                  ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CUPERTINO TEXT FIELD FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: CUPERTINO TEXT FIELD FUNDAMENTALS                      │');
  print('│ Understanding iOS-style text input                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('CupertinoTextField provides:');
  print('  • iOS-native styling');
  print('  • Rounded rectangle border');
  print('  • Clear button support');
  print('  • Prefix/suffix widgets');
  print('  • Placeholder text');
  print('  • TextEditingController integration');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: DEFAULT TEXT FIELD
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: DEFAULT TEXT FIELD                                     │');
  print('│ Basic configuration and properties                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final defaultField = CupertinoTextField(
    placeholder: 'Enter text',
    padding: EdgeInsets.all(12.0),
  );
  
  print('Default CupertinoTextField properties:');
  print('┌──────────────────────────┬──────────────────────────────────────────┐');
  print('│      Property            │   Value                                  │');
  print('├──────────────────────────┼──────────────────────────────────────────┤');
  print('│ runtimeType              │ ${defaultField.runtimeType.toString().padRight(40)} │');
  print('│ placeholder              │ ${defaultField.placeholder.toString().padRight(40)} │');
  print('│ padding                  │ ${defaultField.padding.toString().padRight(40)} │');
  print('│ obscureText              │ ${defaultField.obscureText.toString().padRight(40)} │');
  print('│ autocorrect              │ ${defaultField.autocorrect.toString().padRight(40)} │');
  print('│ maxLines                 │ ${defaultField.maxLines.toString().padRight(40)} │');
  print('│ enabled                  │ ${defaultField.enabled.toString().padRight(40)} │');
  print('│ readOnly                 │ ${defaultField.readOnly.toString().padRight(40)} │');
  print('│ textAlign                │ ${defaultField.textAlign.toString().padRight(40)} │');
  print('└──────────────────────────┴──────────────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SHOW SECURE ENTRY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: SECURE TEXT ENTRY                                      │');
  print('│ Password and secure input configuration                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final passwordField = CupertinoTextField(
    placeholder: 'Password',
    obscureText: true,
    maxLines: 1,
    keyboardType: TextInputType.visiblePassword,
    autocorrect: false,
    prefix: Padding(
      padding: EdgeInsets.only(left: 8),
      child: Icon(CupertinoIcons.lock, size: 18, color: CupertinoColors.systemGrey),
    ),
    suffix: Padding(
      padding: EdgeInsets.only(right: 8),
      child: Icon(CupertinoIcons.eye, size: 18, color: CupertinoColors.systemGrey),
    ),
    clearButtonMode: OverlayVisibilityMode.editing,
  );
  
  print('Password field configuration:');
  print('  • obscureText: ${passwordField.obscureText}');
  print('  • autocorrect: ${passwordField.autocorrect}');
  print('  • maxLines: ${passwordField.maxLines}');
  print('  • keyboardType: visiblePassword');
  print('  • prefix: Lock icon');
  print('  • suffix: Eye icon');
  print('  • clearButtonMode: ${passwordField.clearButtonMode}');
  print('');

  print('Visual representation:');
  print('  ┌───┬─────────────────────────────┬───┐');
  print('  │ 🔒│ ••••••••                    │ 👁│');
  print('  └───┴─────────────────────────────┴───┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BORDERLESS VARIANT
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: BORDERLESS VARIANT                                     │');
  print('│ Inline text field without border                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final borderlessField = CupertinoTextField.borderless(
    placeholder: 'Borderless text entry',
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  );
  
  print('CupertinoTextField.borderless properties:');
  print('  • runtimeType: ${borderlessField.runtimeType}');
  print('  • placeholder: ${borderlessField.placeholder}');
  print('  • padding: ${borderlessField.padding}');
  print('  • decoration: No visible border');
  print('');

  print('Use cases for borderless:');
  print('  • Inline editing');
  print('  • Chat message input');
  print('  • Search within headers');
  print('  • Form fields in cards');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: TEXT EDITING CONTROLLER
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: TEXT EDITING CONTROLLER                                │');
  print('│ Programmatic text control                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final controller1 = TextEditingController(text: 'Initial value');
  final controlledField = CupertinoTextField(controller: controller1);
  
  print('TextEditingController usage:');
  print('  • Initial text: "${controller1.text}"');
  print('  • Get text: controller.text');
  print('  • Set text: controller.text = "new value"');
  print('  • Clear: controller.clear()');
  print('  • Selection: controller.selection');
  print('');

  print('Controller methods:');
  print('┌────────────────────────┬────────────────────────────────────────────┐');
  print('│      Method            │   Description                              │');
  print('├────────────────────────┼────────────────────────────────────────────┤');
  print('│ text                   │ Get/set current text                       │');
  print('│ selection              │ Get/set text selection                     │');
  print('│ clear()                │ Clear all text                             │');
  print('│ dispose()              │ Clean up resources                         │');
  print('│ addListener()          │ Listen for changes                         │');
  print('└────────────────────────┴────────────────────────────────────────────┘');
  print('');
  controller1.dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: PREFIX AND SUFFIX
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: PREFIX AND SUFFIX                                      │');
  print('│ Adding icons and widgets to text field                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Prefix/suffix widgets:');
  print('');
  print('  Search field:');
  print('  ┌───┬─────────────────────────────┬───┐');
  print('  │ 🔍│ Search...                   │ ⊗ │');
  print('  └───┴─────────────────────────────┴───┘');
  print('         prefix                      clear button');
  print('');
  print('  Email field:');
  print('  ┌───┬─────────────────────────────────┐');
  print('  │ @ │ user@example.com                │');
  print('  └───┴─────────────────────────────────┘');
  print('    prefix (always visible)');
  print('');
  print('  Currency field:');
  print('  ┌─────────────────────────────────┬───┐');
  print('  │ 123.45                          │ $ │');
  print('  └─────────────────────────────────┴───┘');
  print('                                   suffix');
  print('');

  print('Visibility modes for prefix/suffix:');
  print('  • never: Always hidden');
  print('  • editing: Show when focused');
  print('  • notEditing: Show when not focused');
  print('  • always: Always visible');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: KEYBOARD TYPES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: KEYBOARD TYPES                                         │');
  print('│ Input type and keyboard configuration                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('TextInputType options:');
  print('┌────────────────────────┬────────────────────────────────────────────┐');
  print('│      Type              │   Keyboard shown                           │');
  print('├────────────────────────┼────────────────────────────────────────────┤');
  print('│ text                   │ Default alphabetic keyboard                │');
  print('│ number                 │ Numeric keypad                             │');
  print('│ phone                  │ Phone dial pad                             │');
  print('│ emailAddress           │ Email with @ and .com                      │');
  print('│ url                    │ URL with / and .com                        │');
  print('│ visiblePassword        │ Text without autocorrect                   │');
  print('│ datetime               │ Date/time input                            │');
  print('│ multiline              │ Return key allows new lines                │');
  print('└────────────────────────┴────────────────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: STYLING OPTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: STYLING OPTIONS                                        │');
  print('│ Customizing appearance                                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Decoration options:');
  print('  • decoration: BoxDecoration for styling');
  print('  • cursorColor: Cursor/caret color');
  print('  • style: TextStyle for input text');
  print('  • placeholderStyle: TextStyle for placeholder');
  print('');

  print('Example customization:');
  print('  CupertinoTextField(');
  print('    decoration: BoxDecoration(');
  print('      color: CupertinoColors.systemGrey6,');
  print('      borderRadius: BorderRadius.circular(8),');
  print('      border: Border.all(color: Colors.blue),');
  print('    ),');
  print('    style: TextStyle(fontSize: 16),');
  print('    cursorColor: Colors.blue,');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CALLBACKS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: CALLBACKS                                              │');
  print('│ Event handling and state changes                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Available callbacks:');
  print('┌─────────────────────────┬───────────────────────────────────────────┐');
  print('│      Callback           │   When triggered                          │');
  print('├─────────────────────────┼───────────────────────────────────────────┤');
  print('│ onChanged               │ Text content changes                      │');
  print('│ onSubmitted             │ Submit/return pressed                     │');
  print('│ onEditingComplete       │ Input complete (keyboard done)            │');
  print('│ onTap                   │ Field tapped                              │');
  print('│ onTapOutside            │ Tap outside field area                    │');
  print('└─────────────────────────┴───────────────────────────────────────────┘');
  print('');

  print('Example usage:');
  print('  CupertinoTextField(');
  print('    onChanged: (value) => print("Changed: \$value"),');
  print('    onSubmitted: (value) => performSearch(value),');
  print('    onEditingComplete: () => FocusScope.of(context).nextFocus(),');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: PRACTICAL USE CASES                                   │');
  print('│ Real-world implementations                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. Search Field');
  print('   CupertinoTextField(');
  print('     placeholder: "Search",');
  print('     prefix: Icon(CupertinoIcons.search),');
  print('     clearButtonMode: OverlayVisibilityMode.editing,');
  print('   )');
  print('');

  print('2. Login Form');
  print('   CupertinoTextField(');
  print('     placeholder: "Email",');
  print('     keyboardType: TextInputType.emailAddress,');
  print('     autocorrect: false,');
  print('   )');
  print('');

  print('3. Comment Input');
  print('   CupertinoTextField(');
  print('     placeholder: "Write a comment...",');
  print('     maxLines: null,');
  print('     minLines: 3,');
  print('   )');
  print('');

  print('4. Phone Number');
  print('   CupertinoTextField(');
  print('     placeholder: "(555) 123-4567",');
  print('     keyboardType: TextInputType.phone,');
  print('     prefix: Text("+1"),');
  print('   )');
  print('');

  print('5. Disabled Field');
  print('   CupertinoTextField(');
  print('     enabled: false,');
  print('     controller: TextEditingController(text: "Fixed value"),');
  print('   )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║           CUPERTINO TEXT FIELD SUMMARY                            ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('CupertinoTextField key features:');
  print('  • iOS-native text input styling');
  print('  • Rounded rectangle border default');
  print('  • Support for prefix/suffix');
  print('  • Multiple keyboard types');
  print('  • Password obscuring');
  print('  • Borderless variant available');
  print('');
  print('Best practices:');
  print('  • Use controller for programmatic access');
  print('  • Set autocorrect: false for passwords');
  print('  • Use appropriate keyboardType');
  print('  • Add clear button for search fields');
  print('');
  print('CupertinoTextField Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'CupertinoTextField',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'iOS-Style Text Input Widget',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Section: Default Text Field
            _buildSectionHeader('DEFAULT TEXT FIELD'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic text entry', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  CupertinoTextField(
                    placeholder: 'Enter text here...',
                    padding: EdgeInsets.all(12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Section: Password Field
            _buildSectionHeader('SECURE TEXT ENTRY'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password with prefix/suffix', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  CupertinoTextField(
                    placeholder: 'Password',
                    obscureText: true,
                    padding: EdgeInsets.all(12),
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(CupertinoIcons.lock, size: 18, color: CupertinoColors.systemGrey),
                    ),
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(CupertinoIcons.eye, size: 18, color: CupertinoColors.systemGrey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Section: Search Field
            _buildSectionHeader('SEARCH FIELD'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('With search icon and clear button', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  CupertinoTextField(
                    placeholder: 'Search',
                    padding: EdgeInsets.all(12),
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(CupertinoIcons.search, size: 18, color: CupertinoColors.systemGrey),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Section: Borderless
            _buildSectionHeader('BORDERLESS VARIANT'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CupertinoTextField.borderless', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  Container(
                    color: Color(0xFFF5F5F5),
                    padding: EdgeInsets.all(8),
                    child: CupertinoTextField.borderless(
                      placeholder: 'Type here (no border)...',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Section: Email Field
            _buildSectionHeader('EMAIL INPUT'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email keyboard type', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  CupertinoTextField(
                    placeholder: 'email@example.com',
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    padding: EdgeInsets.all(12),
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text('@', style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 16)),
                    ),
                    prefixMode: OverlayVisibilityMode.always,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Section: Multiline
            _buildSectionHeader('MULTILINE INPUT'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Multi-line text area', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 8),
                  CupertinoTextField(
                    placeholder: 'Enter description...',
                    maxLines: null,
                    minLines: 3,
                    padding: EdgeInsets.all(12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Summary
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'SUMMARY',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Widget', 'Text'),
                      _buildSummaryStat('Variants', '2'),
                      _buildSummaryStat('Sections', '10'),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Deep Demo • CupertinoTextField • Flutter Cupertino',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.systemGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2196F3),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
