// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDecorationTheme widget integration from material
import 'package:flutter/material.dart';

// Helper to build a section header with gradient background
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

// Helper to build description text
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

// Helper to build an info banner with icon
Widget buildInfoBanner(String text, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper to build a labeled field group inside a card
Widget buildFieldGroup(String label, List<Widget> children) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 10),
        Column(children: children),
      ],
    ),
  );
}

// Helper to build a code snippet display
Widget buildCodeSnippet(String code, Color borderColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor.withAlpha(60)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'monospace',
        color: Color(0xFF37474F),
      ),
    ),
  );
}

// Helper to build a property row
Widget buildPropertyRow(String name, String value, Color dotColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

// Helper: build a themed form card that wraps children in a Theme
Widget buildThemedFormCard(
  String title,
  String subtitle,
  InputDecorationTheme inputTheme,
  Color headerColor,
  List<Widget> fields,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(18),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: headerColor.withAlpha(30),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: headerColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: headerColor.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Theme(
            data: ThemeData(inputDecorationTheme: inputTheme),
            child: Column(children: fields),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a spacer between fields
Widget buildFieldSpacer() {
  return SizedBox(height: 14);
}

dynamic build(BuildContext context) {
  print('=== InputDecorationTheme Widget Integration Demo ===');
  print('Demonstrating Theme wrapping to style groups of input fields');
  print('');

  // Retrieve context theme for debug output
  ThemeData contextTheme = Theme.of(context);
  InputDecorationThemeData currentInputTheme =
      contextTheme.inputDecorationTheme;
  print(
    'Context inputDecorationTheme filled: ' +
        currentInputTheme.filled.toString(),
  );
  print(
    'Context inputDecorationTheme floatingLabelBehavior: ' +
        currentInputTheme.floatingLabelBehavior.toString(),
  );
  print('');

  // Define reusable theme configurations
  InputDecorationTheme loginTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFE8EAF6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF3F51B5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF9FA8DA)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE53935)),
    ),
    labelStyle: TextStyle(color: Color(0xFF3F51B5)),
    hintStyle: TextStyle(color: Color(0xFF9FA8DA)),
    prefixIconColor: Color(0xFF3F51B5),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  InputDecorationTheme registrationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFE0F2F1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF00897B)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF80CBC4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF00897B), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFF00897B)),
    hintStyle: TextStyle(color: Color(0xFF80CBC4)),
    prefixIconColor: Color(0xFF00897B),
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );

  InputDecorationTheme searchTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFF3E0),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFF9800)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFFCC80)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFF9800), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFFE65100)),
    hintStyle: TextStyle(color: Color(0xFFFFCC80)),
    prefixIconColor: Color(0xFFFF9800),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );

  InputDecorationTheme darkModeTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF616161)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF616161)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFEF5350)),
    ),
    labelStyle: TextStyle(color: Color(0xFFBBDEFB)),
    hintStyle: TextStyle(color: Color(0xFF757575)),
    prefixIconColor: Color(0xFF64B5F6),
    suffixIconColor: Color(0xFF90CAF9),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    floatingLabelStyle: TextStyle(color: Color(0xFF90CAF9)),
  );

  InputDecorationTheme material3Theme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFECE6F0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Color(0xFF6750A4), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFF49454F)),
    hintStyle: TextStyle(color: Color(0xFF79747E)),
    prefixIconColor: Color(0xFF49454F),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  );

  InputDecorationTheme minimalTheme = InputDecorationTheme(
    filled: false,
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF424242), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFF757575), fontSize: 13),
    hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 13),
    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    isDense: true,
  );

  print('Defined 6 InputDecorationTheme configurations:');
  print('  1. loginTheme - Indigo, rounded outline');
  print('  2. registrationTheme - Teal, floating labels');
  print('  3. searchTheme - Orange, underline style');
  print('  4. darkModeTheme - Dark background, blue accents');
  print('  5. material3Theme - M3 pill shape, no visible border');
  print('  6. minimalTheme - Minimal underline, dense');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('InputDecorationTheme Integration'),
        backgroundColor: Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Theme.of(context) usage
            buildSectionHeader(
              'Theme.of(context) Usage',
              Icons.palette,
              Color(0xFF1A237E),
            ),
            buildDescription(
              'Access the current InputDecorationTheme from the widget tree context.',
            ),
            buildCodeSnippet(
              'InputDecorationTheme theme =\n'
              '    Theme.of(context).inputDecorationTheme;\n'
              'bool isFilled = theme.filled ?? false;',
              Color(0xFF1A237E),
            ),
            buildInfoBanner(
              'Theme.of(context).inputDecorationTheme provides the inherited theme for all descendant input fields.',
              Color(0xFF1565C0),
              Icons.info_outline,
            ),
            buildFieldGroup('Context Theme Fields', [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Uses context theme',
                  hintText: 'Inherits from nearest Theme ancestor',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
              buildFieldSpacer(),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Another context field',
                  hintText: 'Same inherited styling',
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
            ]),

            // Section 2: Login Form with Indigo theme
            buildSectionHeader(
              'Login Form Theme',
              Icons.login,
              Color(0xFF3F51B5),
            ),
            buildDescription(
              'Wrapping a login form in Theme() with an indigo InputDecorationTheme.',
            ),
            buildCodeSnippet(
              'Theme(\n'
              '  data: ThemeData(\n'
              '    inputDecorationTheme: InputDecorationTheme(\n'
              '      filled: true,\n'
              '      fillColor: Color(0xFFE8EAF6),\n'
              '      border: OutlineInputBorder(...),\n'
              '    ),\n'
              '  ),\n'
              '  child: Column(children: [TextField(...)]),\n'
              ')',
              Color(0xFF3F51B5),
            ),
            buildThemedFormCard(
              'Login',
              'Indigo outlined theme with rounded corners',
              loginTheme,
              Color(0xFF3F51B5),
              [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'user@example.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Two-Factor Code',
                    hintText: '6-digit code',
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
              ],
            ),

            // Section 3: Registration Form with Teal theme
            buildSectionHeader(
              'Registration Form Theme',
              Icons.person_add,
              Color(0xFF00897B),
            ),
            buildDescription(
              'Registration form wrapped in a Teal themed InputDecorationTheme with always-floating labels.',
            ),
            buildThemedFormCard(
              'Registration',
              'Teal theme with floating labels always visible',
              registrationTheme,
              Color(0xFF00897B),
              [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'john@example.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '+1 555 123 4567',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Create Password',
                    hintText: 'At least 8 characters',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ],
            ),

            // Section 4: Search Form with Orange underline theme
            buildSectionHeader(
              'Search Form Theme',
              Icons.search,
              Color(0xFFE65100),
            ),
            buildDescription(
              'Search-style form using underline borders and warm orange styling.',
            ),
            buildThemedFormCard(
              'Search & Filter',
              'Orange underline theme for search interfaces',
              searchTheme,
              Color(0xFFFF9800),
              [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Query',
                    hintText: 'Type to search...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.clear),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Category Filter',
                    hintText: 'All categories',
                    prefixIcon: Icon(Icons.filter_list),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'City or ZIP code',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
              ],
            ),

            // Section 5: Dark Mode Theme
            buildSectionHeader(
              'Dark Mode Input Styling',
              Icons.dark_mode,
              Color(0xFF37474F),
            ),
            buildDescription(
              'Dark-themed inputs with blue accent colors - simulating dark mode styling.',
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF263238),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode Form',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF90CAF9),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Blue accent on dark background',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF78909C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        inputDecorationTheme: darkModeTheme,
                      ),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Color(0xFFE0E0E0)),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter username',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          buildFieldSpacer(),
                          TextField(
                            style: TextStyle(color: Color(0xFFE0E0E0)),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'API Key',
                              hintText: 'Your secret key',
                              prefixIcon: Icon(Icons.vpn_key),
                              suffixIcon: Icon(Icons.copy),
                            ),
                          ),
                          buildFieldSpacer(),
                          TextField(
                            style: TextStyle(color: Color(0xFFE0E0E0)),
                            decoration: InputDecoration(
                              labelText: 'Server URL',
                              hintText: 'https://api.example.com',
                              prefixIcon: Icon(Icons.cloud),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section 6: Material 3 Style
            buildSectionHeader(
              'Material 3 Input Styling',
              Icons.auto_awesome,
              Color(0xFF6750A4),
            ),
            buildDescription(
              'M3-inspired pill-shaped inputs with subtle fill and no visible border until focus.',
            ),
            buildThemedFormCard(
              'Material 3 Inputs',
              'Rounded pill shape with surface tint fill',
              material3Theme,
              Color(0xFF6750A4),
              [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    hintText: 'How others see you',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    hintText: 'Tell us about yourself',
                    prefixIcon: Icon(Icons.edit_note),
                  ),
                ),
                buildFieldSpacer(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Website',
                    hintText: 'https://yoursite.com',
                    prefixIcon: Icon(Icons.language),
                  ),
                ),
              ],
            ),

            // Section 7: Multiple Themed Forms Side-by-Side
            buildSectionHeader(
              'Side-by-Side Themed Forms',
              Icons.compare,
              Color(0xFF4E342E),
            ),
            buildDescription(
              'Comparing different InputDecorationTheme styles in adjacent columns.',
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(inputDecorationTheme: loginTheme),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Outlined Style',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3F51B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(inputDecorationTheme: searchTheme),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Underline Style',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE65100),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(inputDecorationTheme: material3Theme),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'M3 Pill Style',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6750A4),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(inputDecorationTheme: minimalTheme),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Minimal Style',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section 8: Theme affecting different field types
            buildSectionHeader(
              'Theme Across Field Types',
              Icons.widgets,
              Color(0xFF00695C),
            ),
            buildDescription(
              'Same InputDecorationTheme applied to TextField, TextFormField, and DropdownButtonFormField.',
            ),
            buildInfoBanner(
              'InputDecorationTheme affects ALL widgets that use InputDecoration, including TextFormField and DropdownButtonFormField.',
              Color(0xFF00695C),
              Icons.lightbulb_outline,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(18),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Theme(
                data: ThemeData(inputDecorationTheme: registrationTheme),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teal theme on different widget types',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00897B),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'TextField:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'TextField Widget',
                        hintText: 'Standard text input',
                        prefixIcon: Icon(Icons.text_fields),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'TextFormField:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'TextFormField Widget',
                        hintText: 'Form-validated input',
                        prefixIcon: Icon(Icons.check_circle_outline),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'DropdownButtonFormField:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 6),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Select Option',
                        prefixIcon: Icon(Icons.arrow_drop_down_circle),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'opt1',
                          child: Text('Option One'),
                        ),
                        DropdownMenuItem(
                          value: 'opt2',
                          child: Text('Option Two'),
                        ),
                        DropdownMenuItem(
                          value: 'opt3',
                          child: Text('Option Three'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),

            // Section 9: Property Reference
            buildSectionHeader(
              'InputDecorationTheme Properties',
              Icons.list_alt,
              Color(0xFF5D4037),
            ),
            buildDescription(
              'Key properties available on InputDecorationTheme that affect all child inputs.',
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fill & Background',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  buildPropertyRow(
                    'filled',
                    'Whether inputs have a fill color',
                    Color(0xFF8D6E63),
                  ),
                  buildPropertyRow(
                    'fillColor',
                    'Background fill color',
                    Color(0xFF8D6E63),
                  ),
                  buildPropertyRow(
                    'hoverColor',
                    'Fill color on hover',
                    Color(0xFF8D6E63),
                  ),
                  buildPropertyRow(
                    'focusColor',
                    'Fill color when focused',
                    Color(0xFF8D6E63),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Borders',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  buildPropertyRow(
                    'border',
                    'Default border shape',
                    Color(0xFFA1887F),
                  ),
                  buildPropertyRow(
                    'enabledBorder',
                    'Border when enabled',
                    Color(0xFFA1887F),
                  ),
                  buildPropertyRow(
                    'focusedBorder',
                    'Border when focused',
                    Color(0xFFA1887F),
                  ),
                  buildPropertyRow(
                    'errorBorder',
                    'Border when error',
                    Color(0xFFA1887F),
                  ),
                  buildPropertyRow(
                    'focusedErrorBorder',
                    'Border on focused error',
                    Color(0xFFA1887F),
                  ),
                  buildPropertyRow(
                    'disabledBorder',
                    'Border when disabled',
                    Color(0xFFA1887F),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Labels & Text Styles',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  buildPropertyRow(
                    'labelStyle',
                    'Style for label text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'floatingLabelStyle',
                    'Style when label floats',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'hintStyle',
                    'Style for hint text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'helperStyle',
                    'Style for helper text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'errorStyle',
                    'Style for error text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'prefixStyle',
                    'Style for prefix text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'suffixStyle',
                    'Style for suffix text',
                    Color(0xFFBCAAA4),
                  ),
                  buildPropertyRow(
                    'counterStyle',
                    'Style for counter text',
                    Color(0xFFBCAAA4),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Layout & Behavior',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  buildPropertyRow(
                    'contentPadding',
                    'Inner padding of field',
                    Color(0xFFD7CCC8),
                  ),
                  buildPropertyRow(
                    'isDense',
                    'Reduces vertical spacing',
                    Color(0xFFD7CCC8),
                  ),
                  buildPropertyRow(
                    'isCollapsed',
                    'Removes default padding',
                    Color(0xFFD7CCC8),
                  ),
                  buildPropertyRow(
                    'floatingLabelBehavior',
                    'When label floats up',
                    Color(0xFFD7CCC8),
                  ),
                  buildPropertyRow(
                    'floatingLabelAlignment',
                    'Horizontal label alignment',
                    Color(0xFFD7CCC8),
                  ),
                  buildPropertyRow(
                    'alignLabelWithHint',
                    'Align label to hint baseline',
                    Color(0xFFD7CCC8),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Icons',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  buildPropertyRow(
                    'prefixIconColor',
                    'Color of prefix icon',
                    Color(0xFF795548),
                  ),
                  buildPropertyRow(
                    'suffixIconColor',
                    'Color of suffix icon',
                    Color(0xFF795548),
                  ),
                  buildPropertyRow(
                    'iconColor',
                    'Color of leading icon',
                    Color(0xFF795548),
                  ),
                ],
              ),
            ),

            // Section 10: Debug Output Summary
            buildSectionHeader(
              'Debug Output Summary',
              Icons.bug_report,
              Color(0xFF880E4F),
            ),
            buildDescription(
              'Summary of all print() debug output produced during this demo.',
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFF48FB1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.terminal, color: Color(0xFF880E4F), size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Console Output',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF880E4F),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'All print() output is sent during build():\n'
                    '- Theme configuration names\n'
                    '- Context theme filled status\n'
                    '- FloatingLabelBehavior setting\n'
                    '- Theme count and descriptions',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC62828),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),

            // Final info banner
            buildInfoBanner(
              'InputDecorationTheme is the primary mechanism for consistent input styling across an app. '
              'Wrap subtrees in Theme(data: ThemeData(inputDecorationTheme: ...)) to override styling for specific sections.',
              Color(0xFF1A237E),
              Icons.lightbulb_outline,
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
