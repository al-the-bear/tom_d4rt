// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoThemeData, CupertinoColors, CupertinoTextThemeData, CupertinoDynamicColor, CupertinoIcons from cupertino
// Deep Demo: Visual demonstration of Cupertino theme construction, colour palettes, and text themes
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CupertinoThemes Batch 1 Deep Demo executing');

  // ============================================================
  // SECTION 1: CupertinoTheme Concept Overview
  // ============================================================
  print('=== Section 1: CupertinoTheme Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is CupertinoThemeData
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.palette, size: 44.0, color: Colors.blue.shade700),
          SizedBox(height: 12.0),
          Text(
            'CupertinoThemeData',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Holds iOS-style theme values:\nprimary colour, brightness,\ntext theme, backgrounds.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.blue.shade800),
          ),
        ],
      ),
    ),
  );

  // Concept 2: CupertinoTheme widget cascading
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.account_tree, size: 44.0, color: Colors.teal.shade700),
          SizedBox(height: 12.0),
          Text(
            'CupertinoTheme (widget)',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Inherited widget — descendants\nresolve theme via\nCupertinoTheme.of(context).',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade800),
          ),
        ],
      ),
    ),
  );

  // Concept 3: CupertinoColors palette
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.deepOrange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.color_lens, size: 44.0, color: Colors.orange.shade700),
          SizedBox(height: 12.0),
          Text(
            'CupertinoColors',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Static palette of Apple-spec\nsystem colours: systemBlue,\nsystemRed, labels, fills, …',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.orange.shade800),
          ),
        ],
      ),
    ),
  );

  // Concept 4: CupertinoDynamicColor
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.brightness_6, size: 44.0, color: Colors.purple.shade700),
          SizedBox(height: 12.0),
          Text(
            'CupertinoDynamicColor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Resolves to different values\nbased on brightness,\nelevation and contrast.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.purple.shade800),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: CupertinoColors System Palette Gallery
  // ============================================================
  print('=== Section 2: CupertinoColors System Palette ===');

  final paletteEntries = <Map<String, dynamic>>[
    {
      'name': 'systemBlue',
      'color': CupertinoColors.systemBlue,
      'hex': '#007AFF',
    },
    {
      'name': 'systemGreen',
      'color': CupertinoColors.systemGreen,
      'hex': '#34C759',
    },
    {
      'name': 'systemIndigo',
      'color': CupertinoColors.systemIndigo,
      'hex': '#5856D6',
    },
    {
      'name': 'systemOrange',
      'color': CupertinoColors.systemOrange,
      'hex': '#FF9500',
    },
    {
      'name': 'systemPink',
      'color': CupertinoColors.systemPink,
      'hex': '#FF2D55',
    },
    {
      'name': 'systemPurple',
      'color': CupertinoColors.systemPurple,
      'hex': '#AF52DE',
    },
    {
      'name': 'systemRed',
      'color': CupertinoColors.systemRed,
      'hex': '#FF3B30',
    },
    {
      'name': 'systemTeal',
      'color': CupertinoColors.systemTeal,
      'hex': '#5AC8FA',
    },
    {
      'name': 'systemYellow',
      'color': CupertinoColors.systemYellow,
      'hex': '#FFCC00',
    },
    {
      'name': 'systemGrey',
      'color': CupertinoColors.systemGrey,
      'hex': '#8E8E93',
    },
    {
      'name': 'systemGrey2',
      'color': CupertinoColors.systemGrey2,
      'hex': '#AEAEB2',
    },
    {
      'name': 'systemGrey3',
      'color': CupertinoColors.systemGrey3,
      'hex': '#C7C7CC',
    },
    {
      'name': 'systemGrey4',
      'color': CupertinoColors.systemGrey4,
      'hex': '#D1D1D6',
    },
    {
      'name': 'systemGrey5',
      'color': CupertinoColors.systemGrey5,
      'hex': '#E5E5EA',
    },
    {
      'name': 'activeBlue',
      'color': CupertinoColors.activeBlue,
      'hex': '#007AFF',
    },
    {
      'name': 'activeGreen',
      'color': CupertinoColors.activeGreen,
      'hex': '#4CD964',
    },
    {
      'name': 'activeOrange',
      'color': CupertinoColors.activeOrange,
      'hex': '#FF9500',
    },
    {
      'name': 'destructiveRed',
      'color': CupertinoColors.destructiveRed,
      'hex': '#FF3B30',
    },
  ];

  for (final entry in paletteEntries) {
    print('  ${entry['name']}: ${entry['hex']}');
  }

  final paletteCards = <Widget>[];
  for (final entry in paletteEntries) {
    final c = entry['color'] as Color;
    paletteCards.add(
      Container(
        width: 140.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colour swatch
            Container(
              height: 70.0,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(6.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  entry['hex'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Label
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                entry['name'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${paletteCards.length} palette swatch cards');

  // ============================================================
  // SECTION 3: Label Hierarchy & Fill Colours
  // ============================================================
  print('=== Section 3: Label Hierarchy & Fill Colours ===');

  final labelEntries = <Map<String, dynamic>>[
    {
      'name': 'label',
      'color': CupertinoColors.label,
      'desc': 'Primary label colour',
    },
    {
      'name': 'secondaryLabel',
      'color': CupertinoColors.secondaryLabel,
      'desc': 'Secondary label colour',
    },
    {
      'name': 'tertiaryLabel',
      'color': CupertinoColors.tertiaryLabel,
      'desc': 'Tertiary label colour',
    },
    {
      'name': 'quaternaryLabel',
      'color': CupertinoColors.quaternaryLabel,
      'desc': 'Quaternary label colour',
    },
    {
      'name': 'placeholderText',
      'color': CupertinoColors.placeholderText,
      'desc': 'Placeholder text input',
    },
    {
      'name': 'separator',
      'color': CupertinoColors.separator,
      'desc': 'Separator between cells',
    },
    {
      'name': 'opaqueSeparator',
      'color': CupertinoColors.opaqueSeparator,
      'desc': 'Opaque separator variant',
    },
    {
      'name': 'link',
      'color': CupertinoColors.link,
      'desc': 'Link / interactive text',
    },
  ];

  final labelWidgets = <Widget>[];
  for (final entry in labelEntries) {
    final c = entry['color'] as Color;
    labelWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade400, width: 0.5),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CupertinoColors.${entry['name']}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    entry['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${labelWidgets.length} label colour rows');

  // System fills
  final fillEntries = <Map<String, dynamic>>[
    {'name': 'systemFill', 'color': CupertinoColors.systemFill},
    {'name': 'secondarySystemFill', 'color': CupertinoColors.secondarySystemFill},
    {'name': 'tertiarySystemFill', 'color': CupertinoColors.tertiarySystemFill},
    {
      'name': 'quaternarySystemFill',
      'color': CupertinoColors.quaternarySystemFill,
    },
    {
      'name': 'systemBackground',
      'color': CupertinoColors.systemBackground,
    },
    {
      'name': 'secondarySystemBackground',
      'color': CupertinoColors.secondarySystemBackground,
    },
    {
      'name': 'tertiarySystemBackground',
      'color': CupertinoColors.tertiarySystemBackground,
    },
    {
      'name': 'systemGroupedBackground',
      'color': CupertinoColors.systemGroupedBackground,
    },
  ];

  final fillCards = <Widget>[];
  for (final entry in fillEntries) {
    final c = entry['color'] as Color;
    fillCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42.0,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade400, width: 0.5),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              entry['name'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${fillCards.length} fill swatches');

  // ============================================================
  // SECTION 4: CupertinoDynamicColor Light/Dark Pairs
  // ============================================================
  print('=== Section 4: CupertinoDynamicColor Light/Dark Pairs ===');

  final dynamicColorSamples = <Map<String, dynamic>>[
    {
      'name': 'separator',
      'light': Color(0x4D3C3C43),
      'dark': Color(0x995C5C5C),
    },
    {
      'name': 'label',
      'light': Color(0xFF000000),
      'dark': Color(0xFFFFFFFF),
    },
    {
      'name': 'secondaryLabel',
      'light': Color(0x993C3C43),
      'dark': Color(0x99EBEBF5),
    },
    {
      'name': 'systemBackground',
      'light': Color(0xFFFFFFFF),
      'dark': Color(0xFF000000),
    },
    {
      'name': 'secondarySystemBackground',
      'light': Color(0xFFF2F2F7),
      'dark': Color(0xFF1C1C1E),
    },
    {
      'name': 'systemFill',
      'light': Color(0x33787880),
      'dark': Color(0x5C787880),
    },
  ];

  final dynamicColorRows = <Widget>[];
  for (final s in dynamicColorSamples) {
    final light = s['light'] as Color;
    final dark = s['dark'] as Color;
    dynamicColorRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.brightness_6,
                    color: Colors.purple.shade700,
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'CupertinoDynamicColor.${s['name']}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Light mode side
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              size: 16.0,
                              color: Colors.amber.shade700,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              'Light',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: light,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0x${light.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(width: 1.0, height: 100.0, color: Colors.grey.shade300),
                // Dark mode side
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    color: Colors.grey.shade900,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              size: 16.0,
                              color: Colors.indigo.shade200,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              'Dark',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: dark,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.grey.shade600,
                              width: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0x${dark.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${dynamicColorRows.length} dynamic-color rows');

  // ============================================================
  // SECTION 5: CupertinoTextThemeData Font Sample Gallery
  // ============================================================
  print('=== Section 5: CupertinoTextThemeData Font Samples ===');

  final cupertinoTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(
      fontSize: 17.0,
      color: CupertinoColors.label,
      fontFamily: '.SF Pro Text',
    ),
    actionTextStyle: TextStyle(
      fontSize: 17.0,
      color: CupertinoColors.activeBlue,
      fontFamily: '.SF Pro Text',
    ),
    tabLabelTextStyle: TextStyle(
      fontSize: 10.0,
      color: CupertinoColors.inactiveGray,
      fontFamily: '.SF Pro Text',
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: CupertinoColors.label,
      fontFamily: '.SF Pro Display',
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.label,
      fontFamily: '.SF Pro Display',
    ),
    navActionTextStyle: TextStyle(
      fontSize: 17.0,
      color: CupertinoColors.activeBlue,
      fontFamily: '.SF Pro Text',
    ),
    pickerTextStyle: TextStyle(
      fontSize: 22.0,
      color: CupertinoColors.label,
      fontFamily: '.SF Pro Text',
    ),
    dateTimePickerTextStyle: TextStyle(
      fontSize: 20.0,
      color: CupertinoColors.label,
      fontFamily: '.SF Pro Text',
    ),
  );
  print('Constructed CupertinoTextThemeData with 8 explicit text styles');

  final textSamples = <Map<String, dynamic>>[
    {
      'label': 'navLargeTitleTextStyle',
      'sample': 'Large Title',
      'style': cupertinoTextTheme.navLargeTitleTextStyle,
      'note': '34pt bold — large iOS nav titles',
    },
    {
      'label': 'navTitleTextStyle',
      'sample': 'Nav Title',
      'style': cupertinoTextTheme.navTitleTextStyle,
      'note': '17pt semibold — standard nav bar',
    },
    {
      'label': 'textStyle',
      'sample': 'Body text in Cupertino apps.',
      'style': cupertinoTextTheme.textStyle,
      'note': '17pt regular — default body',
    },
    {
      'label': 'actionTextStyle',
      'sample': 'Tappable Action',
      'style': cupertinoTextTheme.actionTextStyle,
      'note': '17pt blue — interactive labels',
    },
    {
      'label': 'navActionTextStyle',
      'sample': 'Done',
      'style': cupertinoTextTheme.navActionTextStyle,
      'note': '17pt blue — nav bar actions',
    },
    {
      'label': 'tabLabelTextStyle',
      'sample': 'TAB LABEL',
      'style': cupertinoTextTheme.tabLabelTextStyle,
      'note': '10pt grey — tab bar labels',
    },
    {
      'label': 'pickerTextStyle',
      'sample': 'Pick a value',
      'style': cupertinoTextTheme.pickerTextStyle,
      'note': '22pt — wheel picker rows',
    },
    {
      'label': 'dateTimePickerTextStyle',
      'sample': '14:30',
      'style': cupertinoTextTheme.dateTimePickerTextStyle,
      'note': '20pt — date/time picker rows',
    },
  ];

  final textSampleCards = <Widget>[];
  for (final s in textSamples) {
    final ts = s['style'] as TextStyle;
    textSampleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    s['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    s['note'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.centerLeft,
              child: Text(s['sample'] as String, style: ts),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${textSampleCards.length} text sample cards');

  // ============================================================
  // SECTION 6: Building & Cascading a Custom CupertinoThemeData
  // ============================================================
  print('=== Section 6: Custom CupertinoThemeData with copyWith ===');

  final baseTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.systemGroupedBackground,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    textTheme: cupertinoTextTheme,
  );
  print('Base theme primaryColor: ${baseTheme.primaryColor}');

  final redVariant = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  final greenVariant = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemGreen,
  );
  final purpleVariant = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemPurple,
  );
  final orangeVariant = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemOrange,
  );
  print('Created 4 .copyWith variants (red/green/purple/orange)');

  // Build mini-UI fragments wrapped in CupertinoTheme widgets so the
  // descendants visibly pick up the theme's primaryColor.
  Widget buildMiniCupertinoFragment(
    CupertinoThemeData theme,
    String label,
    IconData icon,
  ) {
    return CupertinoTheme(
      data: theme,
      child: Builder(
        builder: (BuildContext inner) {
          final resolved = CupertinoTheme.of(inner);
          final pc = resolved.primaryColor;
          return Container(
            width: 260.0,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey.shade300, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mock NavBar
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: resolved.barBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Back',
                        style: (resolved.textTheme.navActionTextStyle).copyWith(
                          color: pc,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        label,
                        style: (resolved.textTheme.navTitleTextStyle).copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        'Done',
                        style: (resolved.textTheme.navActionTextStyle).copyWith(
                          color: pc,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Body
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: resolved.scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: pc.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: pc, size: 28.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'primaryColor cascade',
                        style: resolved.textTheme.textStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Mock CupertinoButton (Material-rendered for portability)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: pc,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Primary Action',
                          style: TextStyle(
                            color: resolved.primaryContrastingColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        '0x${pc.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final cascadeFragments = <Widget>[
    buildMiniCupertinoFragment(baseTheme, 'Default Blue', Icons.bookmark),
    buildMiniCupertinoFragment(redVariant, 'Red Variant', Icons.favorite),
    buildMiniCupertinoFragment(greenVariant, 'Green Variant', Icons.check_circle),
    buildMiniCupertinoFragment(purpleVariant, 'Purple Variant', Icons.star),
    buildMiniCupertinoFragment(orangeVariant, 'Orange Variant', Icons.flag),
  ];
  print('Built ${cascadeFragments.length} cascade fragments');

  // ============================================================
  // SECTION 7: CupertinoIcons Gallery
  // ============================================================
  print('=== Section 7: CupertinoIcons Gallery ===');

  final cupertinoIcons = <Map<String, dynamic>>[
    {'name': 'home', 'icon': CupertinoIcons.home},
    {'name': 'gear', 'icon': CupertinoIcons.gear},
    {'name': 'person_fill', 'icon': CupertinoIcons.person_fill},
    {'name': 'bell_fill', 'icon': CupertinoIcons.bell_fill},
    {'name': 'star_fill', 'icon': CupertinoIcons.star_fill},
    {'name': 'heart_fill', 'icon': CupertinoIcons.heart_fill},
    {'name': 'search', 'icon': CupertinoIcons.search},
    {'name': 'camera_fill', 'icon': CupertinoIcons.camera_fill},
    {'name': 'cloud_fill', 'icon': CupertinoIcons.cloud_fill},
    {'name': 'envelope_fill', 'icon': CupertinoIcons.envelope_fill},
    {'name': 'phone_fill', 'icon': CupertinoIcons.phone_fill},
    {'name': 'location_fill', 'icon': CupertinoIcons.location_fill},
  ];

  final iconColors = <Color>[
    CupertinoColors.systemBlue,
    CupertinoColors.systemRed,
    CupertinoColors.systemGreen,
    CupertinoColors.systemOrange,
    CupertinoColors.systemPurple,
    CupertinoColors.systemTeal,
    CupertinoColors.systemPink,
    CupertinoColors.systemIndigo,
    CupertinoColors.systemYellow,
    CupertinoColors.activeBlue,
    CupertinoColors.activeGreen,
    CupertinoColors.activeOrange,
  ];

  final iconCards = <Widget>[];
  for (int i = 0; i < cupertinoIcons.length; i++) {
    final entry = cupertinoIcons[i];
    final c = iconColors[i % iconColors.length];
    iconCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: c.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.12),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(entry['icon'] as IconData, color: c, size: 28.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'CupertinoIcons',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              '.${entry['name']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${iconCards.length} Cupertino icon cards');

  // ============================================================
  // SECTION 8: Code Example Panels
  // ============================================================
  print('=== Section 8: Code Example Panels ===');

  final codePanels = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Cupertino Theme Patterns',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Panel 1: Constructing a CupertinoThemeData
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// 1. Construct a CupertinoThemeData',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'final theme = CupertinoThemeData(\n'
                '  brightness: Brightness.light,\n'
                '  primaryColor: CupertinoColors.systemBlue,\n'
                '  primaryContrastingColor: CupertinoColors.white,\n'
                '  barBackgroundColor:\n'
                '      CupertinoColors.systemGroupedBackground,\n'
                '  scaffoldBackgroundColor:\n'
                '      CupertinoColors.systemBackground,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.green.shade300,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Panel 2: copyWith cascading
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// 2. Cascade via .copyWith and CupertinoTheme()',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'CupertinoTheme(\n'
                '  data: theme.copyWith(\n'
                '    primaryColor: CupertinoColors.systemRed,\n'
                '  ),\n'
                '  child: CupertinoButton.filled(\n'
                '    child: Text("Red Themed"),\n'
                '    onPressed: () {},\n'
                '  ),\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.cyan.shade200,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Panel 3: Resolving theme inside descendants
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// 3. Resolve the theme inside descendants',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Builder(\n'
                '  builder: (BuildContext ctx) {\n'
                '    final t = CupertinoTheme.of(ctx);\n'
                '    return Text(\n'
                '      "Primary: \${t.primaryColor}",\n'
                '      style: t.textTheme.textStyle,\n'
                '    );\n'
                '  },\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.purple.shade200,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Panel 4: CupertinoTextThemeData
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// 4. CupertinoTextThemeData slots',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'CupertinoTextThemeData(\n'
                '  textStyle:           ... ,\n'
                '  actionTextStyle:     ... ,\n'
                '  tabLabelTextStyle:   ... ,\n'
                '  navTitleTextStyle:   ... ,\n'
                '  navLargeTitleTextStyle: ... ,\n'
                '  navActionTextStyle:  ... ,\n'
                '  pickerTextStyle:     ... ,\n'
                '  dateTimePickerTextStyle: ... ,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.orange.shade200,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created code panel widget');

  // ============================================================
  // SECTION 9: Summary Panel
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Cupertino Theming — Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.palette,
          'CupertinoThemeData',
          'Holds brightness, primary/contrasting colours, bar & scaffold backgrounds, and a CupertinoTextThemeData.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.account_tree,
          'CupertinoTheme widget cascades',
          'Wrap a subtree in CupertinoTheme(data: ...) so descendants resolve via CupertinoTheme.of(context).',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.color_lens,
          'CupertinoColors palette',
          'system* and active* constants give Apple-spec colours; grey ramp and label hierarchy match HIG.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brightness_6,
          'CupertinoDynamicColor',
          'Same semantic colour resolves to different RGBA in light vs. dark — drives adaptive UI automatically.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.text_fields,
          'CupertinoTextThemeData',
          'Slots cover nav titles, body text, actions, tab labels, picker text — override per-slot to tune typography.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.content_copy,
          '.copyWith composition',
          'baseTheme.copyWith(primaryColor: ...) yields scoped variants without rebuilding the full data object.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.star,
          'CupertinoIcons',
          'SF-style icon set; pair with system colours for native-feeling iOS surfaces.',
          Colors.pink,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('CupertinoThemes Batch 1 Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.25),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.palette, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'CupertinoThemes — Batch 1',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Theme construction · colour palettes · text themes',
                style: TextStyle(fontSize: 13.5, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. CupertinoTheme Concepts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. CupertinoColors System Palette',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: paletteCards),
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. Label Hierarchy & System Fills',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: labelWidgets),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: fillCards),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. CupertinoDynamicColor — Light vs Dark',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: dynamicColorRows),
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. CupertinoTextThemeData Samples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: textSampleCards),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Custom CupertinoThemeData & .copyWith Cascade',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: cascadeFragments),
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. CupertinoIcons Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: iconCards),
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codePanels,
        SizedBox(height: 32.0),

        // Section 9
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
        SizedBox(height: 16.0),
      ],
    ),
  );
}

// Helper: build a summary line item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
