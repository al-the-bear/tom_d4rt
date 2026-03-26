// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RadioListTile from material
// Deep Demo: Visual demonstration of RadioListTile — the Material widget
// that combines a Radio button with a ListTile for convenient grouped selection.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Helper: Section header with gradient banner
// ---------------------------------------------------------------------------
Widget buildSectionHeader(String title, {String? subtitle, IconData? icon}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
    margin: EdgeInsets.only(bottom: 10.0, top: 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.purple.shade600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white, size: 26.0),
          SizedBox(width: 12.0),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: Explanation card with colored accent
// ---------------------------------------------------------------------------
Widget buildExplanationCard(
  String text, {
  Color accentColor = Colors.blueGrey,
  IconData icon = Icons.info_outline,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accentColor.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: accentColor, width: 4.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accentColor, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: Demo card wrapper
// ---------------------------------------------------------------------------
Widget buildDemoCard({
  required String label,
  required Widget child,
  Color borderColor = Colors.grey,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: borderColor.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: borderColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: borderColor.withValues(alpha: 0.9),
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Main build function — entry point for the d4rt script
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('RadioListTile Deep Demo executing');
  print('RadioListTile = Radio + ListTile in one convenient widget');

  // Track the selected value for each demo group
  // In this static demo, we set specific values to show different states.
  final int selectedTheme = 1;
  final String selectedLanguage = 'dart';
  final int selectedQuality = 2;

  // ====================================================================
  // SECTION 1: Overview — What is RadioListTile?
  // ====================================================================
  print('=== Section 1: Overview ===');

  final overviewWidgets = <Widget>[];

  // Title card
  overviewWidgets.add(
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade600, Colors.indigo.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.4),
            blurRadius: 12.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.radio_button_checked, size: 56.0, color: Colors.white),
          SizedBox(height: 12.0),
          Text(
            'RadioListTile<T>',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'A ListTile with a Radio button.\nPerfect for single-selection lists.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  // Component anatomy card — showing what RadioListTile is composed of
  overviewWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.amber.shade300, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.architecture, color: Colors.amber.shade800, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Component Anatomy',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          // Visual anatomy diagram
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                // Radio portion
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.radio_button_checked, color: Colors.blue, size: 28.0),
                      SizedBox(height: 4.0),
                      Text(
                        'Radio<T>',
                        style: TextStyle(fontSize: 10.0, color: Colors.blue.shade700),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Text('+', style: TextStyle(fontSize: 24.0, color: Colors.grey)),
                SizedBox(width: 8.0),
                // ListTile portion
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ListTile',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Container(
                          height: 10.0,
                          width: 120.0,
                          color: Colors.green.shade200,
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          height: 8.0,
                          width: 80.0,
                          color: Colors.green.shade100,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text('=', style: TextStyle(fontSize: 24.0, color: Colors.grey)),
                SizedBox(width: 8.0),
                // Combined
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.playlist_add_check, color: Colors.deepPurple, size: 20.0),
                      Text(
                        'RadioListTile',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'RadioListTile merges Radio and ListTile into one widget. '
            'It handles the selection state, tap behavior, and accessibility '
            'semantics automatically, making it the preferred choice for '
            'single-selection lists in Material Design.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
          ),
        ],
      ),
    ),
  );

  print('Created overview section with ${overviewWidgets.length} widgets');

  // ====================================================================
  // SECTION 2: Basic RadioListTile Group
  // ====================================================================
  print('=== Section 2: Basic Radio Group ===');

  // Demonstrate a simple theme-selection radio group
  final basicGroupWidgets = <Widget>[];

  basicGroupWidgets.add(
    buildExplanationCard(
      'A radio group is formed by giving multiple RadioListTile widgets '
      'the same groupValue. The selected tile shows a filled radio button, '
      'while others show an empty ring. Only one item in a group can be '
      'selected at a time.',
      accentColor: Colors.teal,
      icon: Icons.touch_app,
    ),
  );

  // Theme selection group
  basicGroupWidgets.add(
    buildDemoCard(
      label: 'Theme Selection (groupValue = $selectedTheme)',
      borderColor: Colors.teal,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Light Theme'),
            subtitle: Text('Clean and bright appearance'),
            value: 0,
            groupValue: selectedTheme,
            onChanged: (val) {
              print('Selected Light Theme: $val');
            },
            secondary: Icon(Icons.light_mode, color: Colors.amber.shade600),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Dark Theme'),
            subtitle: Text('Easy on the eyes, saves battery'),
            value: 1,
            groupValue: selectedTheme,
            onChanged: (val) {
              print('Selected Dark Theme: $val');
            },
            secondary: Icon(Icons.dark_mode, color: Colors.blueGrey.shade700),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('System Default'),
            subtitle: Text('Follows the device theme setting'),
            value: 2,
            groupValue: selectedTheme,
            onChanged: (val) {
              print('Selected System Default: $val');
            },
            secondary: Icon(Icons.settings_brightness, color: Colors.indigo),
          ),
        ],
      ),
    ),
  );

  // String-typed group
  basicGroupWidgets.add(
    buildDemoCard(
      label: 'Language Selection (groupValue = "$selectedLanguage")',
      borderColor: Colors.blue,
      child: Column(
        children: [
          RadioListTile<String>(
            title: Text('Dart'),
            subtitle: Text('Client-optimized language for fast apps'),
            value: 'dart',
            groupValue: selectedLanguage,
            onChanged: (val) {
              print('Selected: $val');
            },
          ),
          Divider(height: 1.0),
          RadioListTile<String>(
            title: Text('Kotlin'),
            subtitle: Text('Modern, expressive JVM language'),
            value: 'kotlin',
            groupValue: selectedLanguage,
            onChanged: (val) {
              print('Selected: $val');
            },
          ),
          Divider(height: 1.0),
          RadioListTile<String>(
            title: Text('Swift'),
            subtitle: Text('Powerful language for Apple platforms'),
            value: 'swift',
            groupValue: selectedLanguage,
            onChanged: (val) {
              print('Selected: $val');
            },
          ),
          Divider(height: 1.0),
          RadioListTile<String>(
            title: Text('TypeScript'),
            subtitle: Text('Typed superset of JavaScript'),
            value: 'typescript',
            groupValue: selectedLanguage,
            onChanged: (val) {
              print('Selected: $val');
            },
          ),
        ],
      ),
    ),
  );

  print('Created basic group section with ${basicGroupWidgets.length} widgets');

  // ====================================================================
  // SECTION 3: Control Affinity — Where the Radio Sits
  // ====================================================================
  print('=== Section 3: Control Affinity ===');

  final affinityWidgets = <Widget>[];

  affinityWidgets.add(
    buildExplanationCard(
      'controlAffinity determines where the radio button is placed:\n'
      '• ListTileControlAffinity.leading — radio on the left\n'
      '• ListTileControlAffinity.trailing — radio on the right (default)\n'
      '• ListTileControlAffinity.platform — uses platform convention',
      accentColor: Colors.orange,
      icon: Icons.swap_horiz,
    ),
  );

  // Leading affinity
  affinityWidgets.add(
    buildDemoCard(
      label: 'controlAffinity: leading (radio on left side)',
      borderColor: Colors.orange,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Option Alpha'),
            subtitle: Text('Radio button appears on the leading edge'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Option Beta'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    ),
  );

  // Trailing affinity
  affinityWidgets.add(
    buildDemoCard(
      label: 'controlAffinity: trailing (radio on right side)',
      borderColor: Colors.deepOrange,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Option Alpha'),
            subtitle: Text('Radio button appears on the trailing edge'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Option Beta'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ],
      ),
    ),
  );

  // Platform affinity
  affinityWidgets.add(
    buildDemoCard(
      label: 'controlAffinity: platform (OS default)',
      borderColor: Colors.brown,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Option Alpha'),
            subtitle: Text('Follows the platform convention'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.platform,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Option Beta'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            controlAffinity: ListTileControlAffinity.platform,
          ),
        ],
      ),
    ),
  );

  print('Created affinity section with ${affinityWidgets.length} widgets');

  // ====================================================================
  // SECTION 4: Content Variations
  // ====================================================================
  print('=== Section 4: Content Variations ===');

  final contentWidgets = <Widget>[];

  contentWidgets.add(
    buildExplanationCard(
      'RadioListTile supports all the content slots of ListTile:\n'
      '• title — primary text content (required)\n'
      '• subtitle — secondary descriptive text\n'
      '• secondary — a widget opposite to the radio (icon, image, etc.)\n'
      '• isThreeLine — forces three-line height for longer subtitles\n'
      '• dense — reduces vertical padding for compact lists',
      accentColor: Colors.deepPurple,
      icon: Icons.view_list,
    ),
  );

  // Title-only (minimal)
  contentWidgets.add(
    buildDemoCard(
      label: 'Title Only (minimal RadioListTile)',
      borderColor: Colors.purple,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Simple title, no subtitle'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Another simple option'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
          ),
        ],
      ),
    ),
  );

  // Title + Subtitle
  contentWidgets.add(
    buildDemoCard(
      label: 'Title + Subtitle (two-line)',
      borderColor: Colors.indigo,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Wi-Fi'),
            subtitle: Text('Connect to wireless networks'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Bluetooth'),
            subtitle: Text('Pair with nearby devices'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Mobile Data'),
            subtitle: Text('Use cellular network for internet'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
          ),
        ],
      ),
    ),
  );

  // Title + Subtitle + Secondary widget
  contentWidgets.add(
    buildDemoCard(
      label: 'With Secondary Widget (icon on opposite side)',
      borderColor: Colors.cyan,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Standard Quality'),
            subtitle: Text('480p — Uses less data'),
            value: 0,
            groupValue: selectedQuality,
            onChanged: (val) {
              print('Quality: $val');
            },
            secondary: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'SD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('High Quality'),
            subtitle: Text('720p — Good balance'),
            value: 1,
            groupValue: selectedQuality,
            onChanged: (val) {
              print('Quality: $val');
            },
            secondary: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'HD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Ultra Quality'),
            subtitle: Text('1080p — Best visual experience'),
            value: 2,
            groupValue: selectedQuality,
            onChanged: (val) {
              print('Quality: $val');
            },
            secondary: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'UHD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Three-line mode
  contentWidgets.add(
    buildDemoCard(
      label: 'isThreeLine: true (extra tall for long subtitles)',
      borderColor: Colors.teal,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Detailed Option A'),
            subtitle: Text(
              'This option has a very detailed description that spans '
              'multiple lines, explaining all the nuances of this choice.',
            ),
            isThreeLine: true,
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Detailed Option B'),
            subtitle: Text(
              'Another comprehensive explanation that requires additional '
              'vertical space to display all the relevant information.',
            ),
            isThreeLine: true,
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
          ),
        ],
      ),
    ),
  );

  // Dense mode
  contentWidgets.add(
    buildDemoCard(
      label: 'dense: true (compact vertical padding)',
      borderColor: Colors.green,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Compact Item 1'),
            subtitle: Text('Less vertical space'),
            dense: true,
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          RadioListTile<int>(
            title: Text('Compact Item 2'),
            subtitle: Text('Less vertical space'),
            dense: true,
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
          ),
          RadioListTile<int>(
            title: Text('Compact Item 3'),
            subtitle: Text('Less vertical space'),
            dense: true,
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
          ),
          RadioListTile<int>(
            title: Text('Compact Item 4'),
            subtitle: Text('Less vertical space'),
            dense: true,
            value: 3,
            groupValue: 0,
            onChanged: (val) {},
          ),
        ],
      ),
    ),
  );

  print('Created content section with ${contentWidgets.length} widgets');

  // ====================================================================
  // SECTION 5: Visual Theming & Colors
  // ====================================================================
  print('=== Section 5: Visual Theming ===');

  final themingWidgets = <Widget>[];

  themingWidgets.add(
    buildExplanationCard(
      'RadioListTile offers several color customization options:\n'
      '• activeColor — color of the filled radio when selected\n'
      '• tileColor — background color of the tile\n'
      '• selectedTileColor — background when the tile is selected\n'
      '• selected — highlights the text and icon content\n'
      '• fillColor — MaterialStateProperty for radio fill color\n'
      '• hoverColor, splashRadius — pointer interaction effects',
      accentColor: Colors.pink,
      icon: Icons.palette,
    ),
  );

  // Custom active colors
  themingWidgets.add(
    buildDemoCard(
      label: 'Custom activeColor per tile',
      borderColor: Colors.pink,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Red Active'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            activeColor: Colors.red,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Green Active'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            activeColor: Colors.green,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Purple Active'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            activeColor: Colors.purple,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Orange Active (not selected)'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            activeColor: Colors.orange,
          ),
        ],
      ),
    ),
  );

  // Tile background colors
  themingWidgets.add(
    buildDemoCard(
      label: 'tileColor — Custom tile backgrounds',
      borderColor: Colors.amber,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Warm Tile'),
            subtitle: Text('tileColor: amber.shade50'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            tileColor: Colors.amber.shade50,
          ),
          RadioListTile<int>(
            title: Text('Cool Tile'),
            subtitle: Text('tileColor: blue.shade50'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            tileColor: Colors.blue.shade50,
          ),
          RadioListTile<int>(
            title: Text('Fresh Tile'),
            subtitle: Text('tileColor: green.shade50'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            tileColor: Colors.green.shade50,
          ),
        ],
      ),
    ),
  );

  // Selected tile color + selected flag
  themingWidgets.add(
    buildDemoCard(
      label: 'selected + selectedTileColor — Highlight active tile',
      borderColor: Colors.deepPurple,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Selected tile with highlight'),
            subtitle: Text('selected: true, selectedTileColor used'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            selected: true,
            selectedTileColor: Colors.deepPurple.shade50,
            activeColor: Colors.deepPurple,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Unselected tile'),
            subtitle: Text('selected: false, normal appearance'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            selected: false,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Another unselected tile'),
            subtitle: Text('No highlight applied'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            selected: false,
          ),
        ],
      ),
    ),
  );

  // Shape customization
  themingWidgets.add(
    buildDemoCard(
      label: 'shape — Custom tile shapes',
      borderColor: Colors.indigo,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Rounded Rectangle Shape'),
            subtitle: Text('radius: 16'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            tileColor: Colors.indigo.shade50,
            activeColor: Colors.indigo,
          ),
          SizedBox(height: 4.0),
          RadioListTile<int>(
            title: Text('Stadium Border Shape'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            shape: StadiumBorder(),
            tileColor: Colors.pink.shade50,
          ),
          SizedBox(height: 4.0),
          RadioListTile<int>(
            title: Text('Beveled Rectangle'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            tileColor: Colors.teal.shade50,
          ),
        ],
      ),
    ),
  );

  print('Created theming section with ${themingWidgets.length} widgets');

  // ====================================================================
  // SECTION 6: Disabled & Toggleable States
  // ====================================================================
  print('=== Section 6: Disabled & Toggleable ===');

  final stateWidgets = <Widget>[];

  stateWidgets.add(
    buildExplanationCard(
      'RadioListTile supports two important behavioral properties:\n'
      '• onChanged: null — disables the tile (greyed out, not tappable)\n'
      '• toggleable: true — allows deselecting by tapping the selected tile\n\n'
      'By default, once a radio is selected, tapping it again does nothing. '
      'With toggleable: true, tapping the selected radio sets the value to null.',
      accentColor: Colors.red,
      icon: Icons.toggle_on,
    ),
  );

  // Disabled tiles
  stateWidgets.add(
    buildDemoCard(
      label: 'Disabled RadioListTiles (onChanged: null)',
      borderColor: Colors.grey,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Disabled — Selected'),
            subtitle: Text('Cannot interact, but shows selected state'),
            value: 0,
            groupValue: 0,
            onChanged: null,
            secondary: Icon(Icons.lock, color: Colors.grey),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Disabled — Unselected'),
            subtitle: Text('Cannot interact, radio ring is greyed out'),
            value: 1,
            groupValue: 0,
            onChanged: null,
            secondary: Icon(Icons.lock, color: Colors.grey),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Enabled — For comparison'),
            subtitle: Text('This tile IS tappable'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {
              print('Tapped enabled tile: $val');
            },
            secondary: Icon(Icons.lock_open, color: Colors.green),
          ),
        ],
      ),
    ),
  );

  // Toggleable mode
  stateWidgets.add(
    buildDemoCard(
      label: 'toggleable: true (tap selected to deselect)',
      borderColor: Colors.amber,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Toggleable Option A (selected)'),
            subtitle: Text('Tap again to deselect — value becomes null'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {
              print('Toggled: $val');
            },
            toggleable: true,
            activeColor: Colors.amber.shade700,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Toggleable Option B'),
            subtitle: Text('Select this, then tap again to deselect'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {
              print('Toggled: $val');
            },
            toggleable: true,
            activeColor: Colors.amber.shade700,
          ),
        ],
      ),
    ),
  );

  print('Created state section with ${stateWidgets.length} widgets');

  // ====================================================================
  // SECTION 7: Real-World Settings Screen
  // ====================================================================
  print('=== Section 7: Settings Screen Simulation ===');

  final settingsWidgets = <Widget>[];

  settingsWidgets.add(
    buildExplanationCard(
      'RadioListTile is commonly used in settings screens. Here we simulate '
      'a real app settings page with multiple independent radio groups, '
      'each controlling a different preference.',
      accentColor: Colors.blueGrey,
      icon: Icons.settings,
    ),
  );

  // Simulated settings screen
  settingsWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Settings header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.white, size: 24.0),
                SizedBox(width: 12.0),
                Text(
                  'App Settings',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Group 1: Notification Sound
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0),
            child: Text(
              'NOTIFICATION SOUND',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text('Default'),
                  value: 'default',
                  groupValue: 'chime',
                  onChanged: (val) {},
                  dense: true,
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Chime'),
                  value: 'chime',
                  groupValue: 'chime',
                  onChanged: (val) {},
                  dense: true,
                  activeColor: Colors.blueGrey,
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Bell'),
                  value: 'bell',
                  groupValue: 'chime',
                  onChanged: (val) {},
                  dense: true,
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Silent'),
                  value: 'silent',
                  groupValue: 'chime',
                  onChanged: (val) {},
                  dense: true,
                ),
              ],
            ),
          ),

          SizedBox(height: 12.0),

          // Group 2: Font Size
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 4.0),
            child: Text(
              'FONT SIZE',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text('Small', style: TextStyle(fontSize: 13.0)),
                  value: 'small',
                  groupValue: 'medium',
                  onChanged: (val) {},
                  dense: true,
                  secondary: Text('Aa', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Medium', style: TextStyle(fontSize: 15.0)),
                  value: 'medium',
                  groupValue: 'medium',
                  onChanged: (val) {},
                  dense: true,
                  activeColor: Colors.blueGrey,
                  secondary: Text('Aa', style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Large', style: TextStyle(fontSize: 17.0)),
                  value: 'large',
                  groupValue: 'medium',
                  onChanged: (val) {},
                  dense: true,
                  secondary: Text('Aa', style: TextStyle(fontSize: 17.0, color: Colors.grey)),
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Extra Large', style: TextStyle(fontSize: 19.0)),
                  value: 'xlarge',
                  groupValue: 'medium',
                  onChanged: (val) {},
                  dense: true,
                  secondary: Text('Aa', style: TextStyle(fontSize: 19.0, color: Colors.grey)),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.0),

          // Group 3: Data Usage
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 4.0),
            child: Text(
              'DATA USAGE',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text('Wi-Fi Only'),
                  subtitle: Text('Download content only on Wi-Fi'),
                  value: 'wifi',
                  groupValue: 'wifi',
                  onChanged: (val) {},
                  activeColor: Colors.blueGrey,
                  secondary: Icon(Icons.wifi, color: Colors.green),
                ),
                Divider(height: 1.0, indent: 16.0),
                RadioListTile<String>(
                  title: Text('Wi-Fi + Mobile Data'),
                  subtitle: Text('Download on any connection'),
                  value: 'all',
                  groupValue: 'wifi',
                  onChanged: (val) {},
                  secondary: Icon(Icons.signal_cellular_alt, color: Colors.orange),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    ),
  );

  print('Created settings section with ${settingsWidgets.length} widgets');

  // ====================================================================
  // SECTION 8: Side-by-Side Comparison
  // ====================================================================
  print('=== Section 8: Comparison Gallery ===');

  final comparisonWidgets = <Widget>[];

  comparisonWidgets.add(
    buildExplanationCard(
      'RadioListTile vs manually combining Radio + ListTile:\n'
      '• RadioListTile handles tap regions, semantics, and layout automatically\n'
      '• Manual composition requires more code and careful state management\n'
      '• RadioListTile ensures consistent Material Design behavior',
      accentColor: Colors.green,
      icon: Icons.compare,
    ),
  );

  // Comparison: RadioListTile (convenient)
  comparisonWidgets.add(
    buildDemoCard(
      label: 'Using RadioListTile (recommended)',
      borderColor: Colors.green,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Automatic layout'),
            subtitle: Text('One widget does everything'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            secondary: Icon(Icons.check_circle, color: Colors.green),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Automatic semantics'),
            subtitle: Text('Accessibility built in'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            secondary: Icon(Icons.accessibility, color: Colors.green),
          ),
        ],
      ),
    ),
  );

  // Comparison: Manual Radio + ListTile
  comparisonWidgets.add(
    buildDemoCard(
      label: 'Manual Radio + ListTile (more effort)',
      borderColor: Colors.orange,
      child: Column(
        children: [
          ListTile(
            leading: Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (val) {},
            ),
            title: Text('Manual layout'),
            subtitle: Text('Must wire radio + tile yourself'),
            trailing: Icon(Icons.warning, color: Colors.orange),
          ),
          Divider(height: 1.0),
          ListTile(
            leading: Radio<int>(
              value: 1,
              groupValue: 0,
              onChanged: (val) {},
            ),
            title: Text('Manual state'),
            subtitle: Text('More boilerplate code'),
            trailing: Icon(Icons.code, color: Colors.orange),
          ),
        ],
      ),
    ),
  );

  print('Created comparison section with ${comparisonWidgets.length} widgets');

  // ====================================================================
  // SECTION 9: Edge Cases & Advanced Usage
  // ====================================================================
  print('=== Section 9: Edge Cases ===');

  final edgeCaseWidgets = <Widget>[];

  edgeCaseWidgets.add(
    buildExplanationCard(
      'Edge cases and advanced patterns:\n'
      '• Very long text that wraps to multiple lines\n'
      '• Rich secondary widgets (images, badges, progress indicators)\n'
      '• Mixed enabled/disabled tiles in the same group\n'
      '• Visual density adjustment for different screen types',
      accentColor: Colors.brown,
      icon: Icons.explore,
    ),
  );

  // Long text wrapping
  edgeCaseWidgets.add(
    buildDemoCard(
      label: 'Long Text Wrapping',
      borderColor: Colors.brown,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text(
              'This is a RadioListTile with an intentionally very long title '
              'that demonstrates how the text wraps elegantly to multiple lines',
            ),
            subtitle: Text(
              'The subtitle is equally verbose to show how both title and '
              'subtitle handle overflow by wrapping within the available space.',
            ),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            isThreeLine: true,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Short alternative'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
          ),
        ],
      ),
    ),
  );

  // Rich secondary widgets
  edgeCaseWidgets.add(
    buildDemoCard(
      label: 'Rich Secondary Widgets',
      borderColor: Colors.deepOrange,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Premium Plan'),
            subtitle: Text('\$9.99/month'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            activeColor: Colors.amber.shade700,
            secondary: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.star, color: Colors.white, size: 28.0),
            ),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Basic Plan'),
            subtitle: Text('Free'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            secondary: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.person, color: Colors.grey, size: 28.0),
            ),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Enterprise'),
            subtitle: Text('Contact sales'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            secondary: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.business, color: Colors.white, size: 28.0),
            ),
          ),
        ],
      ),
    ),
  );

  // Mixed enabled/disabled in same group
  edgeCaseWidgets.add(
    buildDemoCard(
      label: 'Mixed Enabled/Disabled in One Group',
      borderColor: Colors.red,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Free Tier'),
            subtitle: Text('Available to all users'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Pro Tier (Locked)'),
            subtitle: Text('Upgrade required — not available'),
            value: 1,
            groupValue: 0,
            onChanged: null,
            secondary: Icon(Icons.lock, color: Colors.red.shade300),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Team Tier (Locked)'),
            subtitle: Text('Organization plan — contact admin'),
            value: 2,
            groupValue: 0,
            onChanged: null,
            secondary: Icon(Icons.lock, color: Colors.red.shade300),
          ),
        ],
      ),
    ),
  );

  // Visual density
  edgeCaseWidgets.add(
    buildDemoCard(
      label: 'visualDensity — Adjusting tile compactness',
      borderColor: Colors.teal,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Comfortable (default)'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            visualDensity: VisualDensity.comfortable,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Standard'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            visualDensity: VisualDensity.standard,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Compact'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    ),
  );

  print('Created edge case section with ${edgeCaseWidgets.length} widgets');

  // ====================================================================
  // SECTION 10: Content Padding & Semantic Properties
  // ====================================================================
  print('=== Section 10: Content Padding & Semantics ===');

  final paddingWidgets = <Widget>[];

  paddingWidgets.add(
    buildExplanationCard(
      'Additional customization:\n'
      '• contentPadding — control the internal padding of the tile\n'
      '• enableFeedback — enable/disable ink splash and vibration\n'
      '• materialTapTargetSize — size of the radio tap target area\n'
      'These fine-grained controls help adapt the tile to different contexts.',
      accentColor: Colors.lime.shade800,
      icon: Icons.tune,
    ),
  );

  // Custom content padding
  paddingWidgets.add(
    buildDemoCard(
      label: 'Custom contentPadding',
      borderColor: Colors.lime.shade700,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('Default Padding'),
            subtitle: Text('Uses default EdgeInsets'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Extra Left Padding'),
            subtitle: Text('contentPadding left: 32'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            contentPadding: EdgeInsets.only(left: 32.0, right: 16.0),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Generous Padding'),
            subtitle: Text('contentPadding: all 24'),
            value: 2,
            groupValue: 0,
            onChanged: (val) {},
            contentPadding: EdgeInsets.all(24.0),
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('Minimal Padding'),
            subtitle: Text('contentPadding: all 4'),
            value: 3,
            groupValue: 0,
            onChanged: (val) {},
            contentPadding: EdgeInsets.all(4.0),
          ),
        ],
      ),
    ),
  );

  // Tap target sizes (Material 3)
  paddingWidgets.add(
    buildDemoCard(
      label: 'materialTapTargetSize — Radio hit area',
      borderColor: Colors.cyan,
      child: Column(
        children: [
          RadioListTile<int>(
            title: Text('padded (default)'),
            subtitle: Text('Larger tap target for touch screens'),
            value: 0,
            groupValue: 0,
            onChanged: (val) {},
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          Divider(height: 1.0),
          RadioListTile<int>(
            title: Text('shrinkWrap'),
            subtitle: Text('Tighter tap target, useful in dense UIs'),
            value: 1,
            groupValue: 0,
            onChanged: (val) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    ),
  );

  print('Created padding section with ${paddingWidgets.length} widgets');

  // ====================================================================
  // SECTION 11: Multiple Themed Groups Side by Side
  // ====================================================================
  print('=== Section 11: Themed Groups Gallery ===');

  final galleryWidgets = <Widget>[];

  galleryWidgets.add(
    buildExplanationCard(
      'A collection of independently themed radio groups, each using a '
      'different color scheme and configuration. This demonstrates how '
      'RadioListTile adapts to various visual contexts in a single app.',
      accentColor: Colors.teal,
      icon: Icons.grid_view,
    ),
  );

  // Blue-themed group: sort order
  galleryWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.sort, color: Colors.blue.shade700, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Sort Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile<String>(
            title: Text('Name (A → Z)'),
            value: 'name_asc',
            groupValue: 'date_desc',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            title: Text('Name (Z → A)'),
            value: 'name_desc',
            groupValue: 'date_desc',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            title: Text('Date (Newest first)'),
            value: 'date_desc',
            groupValue: 'date_desc',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            title: Text('Date (Oldest first)'),
            value: 'date_asc',
            groupValue: 'date_desc',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            title: Text('Size (Largest first)'),
            value: 'size_desc',
            groupValue: 'date_desc',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
          ),
        ],
      ),
    ),
  );

  // Green-themed group: frequency
  galleryWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: Colors.green.shade700, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Sync Frequency',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile<int>(
            title: Text('Every 15 minutes'),
            value: 15,
            groupValue: 60,
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.green,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          RadioListTile<int>(
            title: Text('Every 30 minutes'),
            value: 30,
            groupValue: 60,
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.green,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          RadioListTile<int>(
            title: Text('Every hour'),
            value: 60,
            groupValue: 60,
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.green,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          RadioListTile<int>(
            title: Text('Manual only'),
            value: 0,
            groupValue: 60,
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.green,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    ),
  );

  // Red-themed group: priority
  galleryWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.flag, color: Colors.red.shade700, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Priority Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile<String>(
            title: Text('Critical'),
            value: 'critical',
            groupValue: 'normal',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.red.shade700,
            secondary: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                shape: BoxShape.circle,
              ),
            ),
          ),
          RadioListTile<String>(
            title: Text('High'),
            value: 'high',
            groupValue: 'normal',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.orange,
            secondary: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          RadioListTile<String>(
            title: Text('Normal'),
            value: 'normal',
            groupValue: 'normal',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.blue,
            secondary: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          RadioListTile<String>(
            title: Text('Low'),
            value: 'low',
            groupValue: 'normal',
            onChanged: (val) {},
            dense: true,
            activeColor: Colors.grey,
            secondary: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created gallery section with ${galleryWidgets.length} widgets');

  // ====================================================================
  // FINAL ASSEMBLY
  // ====================================================================
  print('Assembling final layout...');

  final allSections = <Widget>[
    // Section 1: Overview
    buildSectionHeader(
      'Section 1: What is RadioListTile?',
      subtitle: 'Anatomy, purpose, and when to use it',
      icon: Icons.info,
    ),
    ...overviewWidgets,

    // Section 2: Basic Group
    buildSectionHeader(
      'Section 2: Basic Radio Groups',
      subtitle: 'Simple single-selection with groupValue binding',
      icon: Icons.radio_button_checked,
    ),
    ...basicGroupWidgets,

    // Section 3: Control Affinity
    buildSectionHeader(
      'Section 3: Control Affinity',
      subtitle: 'Positioning the radio button within the tile',
      icon: Icons.swap_horiz,
    ),
    ...affinityWidgets,

    // Section 4: Content Variations
    buildSectionHeader(
      'Section 4: Content Variations',
      subtitle: 'title, subtitle, secondary, dense, isThreeLine',
      icon: Icons.view_list,
    ),
    ...contentWidgets,

    // Section 5: Theming
    buildSectionHeader(
      'Section 5: Visual Theming & Colors',
      subtitle: 'activeColor, tileColor, selectedTileColor, shape',
      icon: Icons.palette,
    ),
    ...themingWidgets,

    // Section 6: States
    buildSectionHeader(
      'Section 6: Disabled & Toggleable States',
      subtitle: 'onChanged null, toggleable behavior',
      icon: Icons.toggle_on,
    ),
    ...stateWidgets,

    // Section 7: Settings
    buildSectionHeader(
      'Section 7: Real-World Settings Screen',
      subtitle: 'Simulated app preferences with multiple groups',
      icon: Icons.settings,
    ),
    ...settingsWidgets,

    // Section 8: Comparison
    buildSectionHeader(
      'Section 8: Comparison — RadioListTile vs Manual',
      subtitle: 'Why RadioListTile is the recommended approach',
      icon: Icons.compare,
    ),
    ...comparisonWidgets,

    // Section 9: Edge Cases
    buildSectionHeader(
      'Section 9: Edge Cases & Advanced Usage',
      subtitle: 'Long text, rich widgets, mixed states, visual density',
      icon: Icons.explore,
    ),
    ...edgeCaseWidgets,

    // Section 10: Padding & Semantics
    buildSectionHeader(
      'Section 10: Content Padding & Semantics',
      subtitle: 'Fine-grained padding and tap target controls',
      icon: Icons.tune,
    ),
    ...paddingWidgets,

    // Section 11: Gallery
    buildSectionHeader(
      'Section 11: Themed Groups Gallery',
      subtitle: 'Multiple independent radio groups with different themes',
      icon: Icons.grid_view,
    ),
    ...galleryWidgets,

    // Footer
    SizedBox(height: 30.0),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 36.0),
          SizedBox(height: 8.0),
          Text(
            'RadioListTile Deep Demo Complete',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Covered: basics, control affinity, content slots, theming, '
            'states, real-world settings, comparison, edge cases, padding, '
            'and themed group gallery.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
    SizedBox(height: 20.0),
  ];

  print('Total sections assembled: 11');
  print('RadioListTile Deep Demo complete');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RadioListTile Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: allSections,
        ),
      ),
    ),
  );
}
