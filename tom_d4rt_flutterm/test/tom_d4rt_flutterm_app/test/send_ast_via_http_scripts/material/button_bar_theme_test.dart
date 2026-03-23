// ignore_for_file: avoid_print
// D4rt test script: Tests ButtonBarTheme from material
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade800,
      ),
    ),
  );
}

// Helper to build description
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

// Helper to build info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper: theme label badge
Widget buildThemeBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

// Helper: themed ButtonBar card
Widget buildThemedButtonBarCard({
  required String title,
  required String description,
  required ButtonBarThemeData themeData,
  required List<Widget> buttons,
  String? themeBadgeText,
  Color? themeBadgeColor,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
              if (themeBadgeText != null)
                buildThemeBadge(themeBadgeText, themeBadgeColor ?? Colors.indigo),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        Divider(height: 1),
        ButtonBarTheme(
          data: themeData,
          child: ButtonBar(children: buttons),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

// Helper: nested theme comparison card
Widget buildNestedThemeCard({
  required String title,
  required String description,
  required ButtonBarThemeData outerTheme,
  required ButtonBarThemeData innerTheme,
  required List<Widget> outerButtons,
  required List<Widget> innerButtons,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        // Outer theme
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: buildThemeBadge('Outer Theme', Colors.indigo),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ButtonBarTheme(
            data: outerTheme,
            child: ButtonBar(children: outerButtons),
          ),
        ),
        SizedBox(height: 8),
        // Inner theme
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: buildThemeBadge('Inner Theme (overrides)', Colors.orange),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ButtonBarTheme(
            data: outerTheme,
            child: ButtonBarTheme(
              data: innerTheme,
              child: ButtonBar(children: innerButtons),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

// Helper: property comparison row
Widget buildPropertyRow(String prop, String outer, String inner) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(prop, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(outer, style: TextStyle(fontSize: 11, color: Colors.indigo)),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(inner, style: TextStyle(fontSize: 11, color: Colors.orange.shade700)),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== ButtonBarTheme Deep Demo ===');
  debugPrint('Demonstrating ButtonBarTheme inheritance and wrapping');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ButtonBarTheme Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Theme wrapping, inheritance, and override patterns for ButtonBar',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Deprecated - use OverflowBar instead',
                  style: TextStyle(fontSize: 11, color: Colors.brown.shade800),
                ),
              ),
            ],
          ),
        ),

        // Section 1: Basic Theme Wrapping
        buildSectionTitle('1. Basic Theme Wrapping'),
        buildDescription('ButtonBarTheme wrapping ButtonBars with different alignment'),

        buildThemedButtonBarCard(
          title: 'Start-aligned Theme',
          description: 'Buttons pushed to the start with padding',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            buttonPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Share')),
            TextButton(onPressed: () {}, child: Text('Like')),
          ],
          themeBadgeText: 'start',
          themeBadgeColor: Colors.green,
        ),
        buildThemedButtonBarCard(
          title: 'Center-aligned Theme',
          description: 'Buttons centered within the bar',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
            buttonPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          buttons: [
            OutlinedButton(onPressed: () {}, child: Text('Previous')),
            ElevatedButton(onPressed: () {}, child: Text('Next')),
          ],
          themeBadgeText: 'center',
          themeBadgeColor: Colors.blue,
        ),
        buildThemedButtonBarCard(
          title: 'End-aligned Theme (default)',
          description: 'Buttons aligned to end, typical for dialogs',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Cancel')),
            ElevatedButton(onPressed: () {}, child: Text('OK')),
          ],
          themeBadgeText: 'end',
          themeBadgeColor: Colors.red,
        ),

        // Section 2: Nested Theme Inheritance
        buildSectionTitle('2. Nested Theme Inheritance'),
        buildDescription('Inner ButtonBarTheme overrides outer theme properties'),

        buildNestedThemeCard(
          title: 'Alignment Override',
          description: 'Outer uses start, inner overrides to end',
          outerTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            buttonPadding: EdgeInsets.symmetric(horizontal: 6),
          ),
          innerTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.symmetric(horizontal: 6),
          ),
          outerButtons: [
            TextButton(onPressed: () {}, child: Text('A')),
            ElevatedButton(onPressed: () {}, child: Text('B')),
          ],
          innerButtons: [
            TextButton(onPressed: () {}, child: Text('X')),
            ElevatedButton(onPressed: () {}, child: Text('Y')),
          ],
        ),

        // Property comparison table
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Inheritance Table',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: Text('Outer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Inner', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              buildPropertyRow('alignment', 'start', 'end'),
              buildPropertyRow('padding', 'h:6', 'h:6'),
              buildPropertyRow('mainAxisSize', 'max', 'max'),
            ],
          ),
        ),

        buildNestedThemeCard(
          title: 'Sizing Override',
          description: 'Outer uses small buttons, inner uses large',
          outerTheme: ButtonBarThemeData(
            buttonMinWidth: 60,
            buttonHeight: 32,
            alignment: MainAxisAlignment.center,
          ),
          innerTheme: ButtonBarThemeData(
            buttonMinWidth: 120,
            buttonHeight: 48,
            alignment: MainAxisAlignment.center,
          ),
          outerButtons: [
            ElevatedButton(onPressed: () {}, child: Text('Small')),
            ElevatedButton(onPressed: () {}, child: Text('Btns')),
          ],
          innerButtons: [
            ElevatedButton(onPressed: () {}, child: Text('Large')),
            ElevatedButton(onPressed: () {}, child: Text('Btns')),
          ],
        ),

        // Section 3: Full ThemeData Integration
        buildSectionTitle('3. Full ThemeData Integration'),
        buildDescription('Using ThemeData.buttonBarTheme for app-wide configuration'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Theme Widget Integration',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.indigo.shade700),
                      ),
                    ),
                    buildThemeBadge('ThemeData', Colors.purple),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'ButtonBar inherits from ThemeData.buttonBarTheme',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),
              Divider(height: 1),
              Theme(
                data: ThemeData(
                  buttonBarTheme: ButtonBarThemeData(
                    alignment: MainAxisAlignment.center,
                    buttonMinWidth: 100,
                    buttonHeight: 44,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                child: ButtonBar(
                  children: [
                    OutlinedButton(onPressed: () {}, child: Text('Back')),
                    ElevatedButton(onPressed: () {}, child: Text('Continue')),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),

        // Section 4: Different Button Arrangements
        buildSectionTitle('4. Theme with Different Button Sets'),
        buildDescription('Same theme applied to various button configurations'),

        buildThemedButtonBarCard(
          title: 'Form Actions',
          description: 'Theme with centered alignment for form buttons',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 80,
            buttonPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Reset')),
            OutlinedButton(onPressed: () {}, child: Text('Clear')),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
        buildThemedButtonBarCard(
          title: 'Navigation Actions',
          description: 'Theme with spaceBetween for wizard navigation',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
            buttonMinWidth: 100,
            buttonHeight: 42,
          ),
          buttons: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_back, size: 16),
              label: Text('Previous'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward, size: 16),
              label: Text('Next'),
            ),
          ],
        ),
        buildThemedButtonBarCard(
          title: 'Social Actions',
          description: 'Start-aligned theme for card social buttons',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            buttonPadding: EdgeInsets.symmetric(horizontal: 4),
            buttonMinWidth: 40,
          ),
          buttons: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.thumb_up_outlined, size: 16),
              label: Text('Like'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.comment_outlined, size: 16),
              label: Text('Comment'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.share_outlined, size: 16),
              label: Text('Share'),
            ),
          ],
        ),

        // Section 5: Theme Lookup with of()
        buildSectionTitle('5. Theme Lookup Behavior'),
        buildDescription('How ButtonBarTheme.of(context) resolves theme data'),

        buildInfoBox(
          'ButtonBarTheme.of(context) returns the nearest '
          'ButtonBarThemeData in the widget tree, or the one from ThemeData.',
          Colors.indigo,
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Theme Resolution Order',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              _buildResolutionStep('1', 'Local ButtonBarTheme widget', Colors.green),
              _buildResolutionStep('2', 'Parent ButtonBarTheme widget', Colors.blue),
              _buildResolutionStep('3', 'ThemeData.buttonBarTheme', Colors.orange),
              _buildResolutionStep('4', 'Default ButtonBarThemeData', Colors.grey),
              SizedBox(height: 16),
            ],
          ),
        ),

        // Section 6: Dark Theme Integration
        buildSectionTitle('6. Dark Theme Integration'),
        buildDescription('ButtonBarTheme within dark-themed context'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'Dark Theme ButtonBar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'Theme integrated with dark color scheme',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
              ),
              Theme(
                data: ThemeData.dark().copyWith(
                  buttonBarTheme: ButtonBarThemeData(
                    alignment: MainAxisAlignment.end,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                child: ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Dismiss', style: TextStyle(color: Colors.grey.shade400)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent.shade700,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Accept'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),

        // Section 7: Multiple Themes Side by Side
        buildSectionTitle('7. Theme Variety Comparison'),
        buildDescription('Different theme configurations shown side by side'),

        buildThemedButtonBarCard(
          title: 'Compact Theme',
          description: 'Small buttons, minimal padding',
          themeData: ButtonBarThemeData(
            buttonMinWidth: 50,
            buttonHeight: 30,
            buttonPadding: EdgeInsets.symmetric(horizontal: 2),
            alignment: MainAxisAlignment.end,
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('No', style: TextStyle(fontSize: 12))),
            ElevatedButton(onPressed: () {}, child: Text('Yes', style: TextStyle(fontSize: 12))),
          ],
          themeBadgeText: 'compact',
          themeBadgeColor: Colors.green,
        ),
        buildThemedButtonBarCard(
          title: 'Spacious Theme',
          description: 'Large buttons, generous padding',
          themeData: ButtonBarThemeData(
            buttonMinWidth: 140,
            buttonHeight: 52,
            buttonPadding: EdgeInsets.symmetric(horizontal: 16),
            alignment: MainAxisAlignment.center,
          ),
          buttons: [
            OutlinedButton(onPressed: () {}, child: Text('Decline')),
            ElevatedButton(onPressed: () {}, child: Text('Accept')),
          ],
          themeBadgeText: 'spacious',
          themeBadgeColor: Colors.purple,
        ),
        buildThemedButtonBarCard(
          title: 'Spread Theme',
          description: 'Buttons spread across full width',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            buttonMinWidth: 80,
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('A')),
            TextButton(onPressed: () {}, child: Text('B')),
            TextButton(onPressed: () {}, child: Text('C')),
            TextButton(onPressed: () {}, child: Text('D')),
          ],
          themeBadgeText: 'spread',
          themeBadgeColor: Colors.teal,
        ),

        // Summary
        buildSectionTitle('8. Summary'),
        buildInfoBox(
          'ButtonBarTheme is an InheritedWidget that provides ButtonBarThemeData '
          'to ButtonBar descendants in the widget tree.',
          Colors.indigo,
        ),
        buildInfoBox(
          'Inner ButtonBarTheme widgets fully override outer ones because '
          'ButtonBarThemeData does not merge properties from ancestors.',
          Colors.orange,
        ),
        buildInfoBox(
          'You can also set the theme globally via ThemeData.buttonBarTheme '
          'or locally via ButtonBarTheme widget wrapping.',
          Colors.green,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}

// Helper: resolution step
Widget _buildResolutionStep(String number, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(number, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(description, style: TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}
