// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for CupertinoBasedMaterialThemeData from material
// CupertinoBasedMaterialThemeData is a MaterialBasedCupertinoThemeData wrapper
// It allows using Material theming conventions with Cupertino widgets
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║      CUPERTINO BASED MATERIAL THEME DATA DEEP DEMO                ║',
  );
  print(
    '║    Bridge Material Themes to Cupertino Widget Styling             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: THEME BRIDGING FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: THEME BRIDGING FUNDAMENTALS                            │',
  );
  print(
    '│ Understanding Material to Cupertino theme mapping                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Theme bridging concept:');
  print('  • Material apps using Cupertino widgets');
  print('  • Automatic color mapping');
  print('  • Typography conversion');
  print('  • Consistent look across platforms');
  print('');

  print('Theme inheritance flow:');
  print('  MaterialApp');
  print('      │');
  print('      ▼');
  print('  ThemeData (Material)');
  print('      │');
  print('      ▼');
  print('  MaterialBasedCupertinoThemeData');
  print('      │');
  print('      ▼');
  print('  Cupertino Widgets (use Material colors)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: MATERIAL THEME DATA
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: MATERIAL THEME DATA                                    │',
  );
  print(
    '│ Base Material theme configuration                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final materialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  print('ThemeData properties:');
  print(
    '┌────────────────────────────┬─────────────────────────────────────────┐',
  );
  print(
    '│       Property             │   Value                                 │',
  );
  print(
    '├────────────────────────────┼─────────────────────────────────────────┤',
  );
  print(
    '│ primaryColor               │ ${materialTheme.primaryColor}           │',
  );
  print(
    '│ brightness                 │ ${materialTheme.brightness}             │',
  );
  print(
    '│ colorScheme.primary        │ ${materialTheme.colorScheme.primary}    │',
  );
  print(
    '│ colorScheme.secondary      │ ${materialTheme.colorScheme.secondary}  │',
  );
  print(
    '│ useMaterial3               │ ${materialTheme.useMaterial3}           │',
  );
  print(
    '└────────────────────────────┴─────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CUPERTINO THEME FROM MATERIAL
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: CUPERTINO THEME FROM MATERIAL                          │',
  );
  print(
    '│ Deriving CupertinoThemeData from Material                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final cupertinoTheme = MaterialBasedCupertinoThemeData(
    materialTheme: materialTheme,
  );

  print('MaterialBasedCupertinoThemeData:');
  print('  • runtimeType: ${cupertinoTheme.runtimeType}');
  print('  • primaryColor: ${cupertinoTheme.primaryColor}');
  print(
    '  • primaryContrastingColor: ${cupertinoTheme.primaryContrastingColor}',
  );
  print('  • brightness: ${cupertinoTheme.brightness}');
  print(
    '  • scaffoldBackgroundColor: ${cupertinoTheme.scaffoldBackgroundColor}',
  );
  print('  • barBackgroundColor: ${cupertinoTheme.barBackgroundColor}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COLOR MAPPING
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: COLOR MAPPING                                          │',
  );
  print(
    '│ How Material colors map to Cupertino                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Color mapping table:');
  print(
    '┌─────────────────────────────┬───────────────────────────────────────┐',
  );
  print(
    '│     Material Property       │     Cupertino Property                │',
  );
  print(
    '├─────────────────────────────┼───────────────────────────────────────┤',
  );
  print(
    '│ colorScheme.primary         │ primaryColor                          │',
  );
  print(
    '│ colorScheme.onPrimary       │ primaryContrastingColor               │',
  );
  print(
    '│ colorScheme.surface         │ scaffoldBackgroundColor               │',
  );
  print(
    '│ colorScheme.surfaceVariant  │ barBackgroundColor                    │',
  );
  print(
    '│ brightness                  │ brightness (direct)                   │',
  );
  print(
    '│ textTheme                   │ textTheme (converted)                 │',
  );
  print(
    '└─────────────────────────────┴───────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: DARK THEME MAPPING
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: DARK THEME MAPPING                                     │',
  );
  print(
    '│ Material dark theme to Cupertino conversion                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final darkMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  final darkCupertinoTheme = MaterialBasedCupertinoThemeData(
    materialTheme: darkMaterialTheme,
  );

  print('Dark theme conversion:');
  print('  Material dark theme:');
  print('    • brightness: ${darkMaterialTheme.brightness}');
  print(
    '    • scaffoldBackgroundColor: ${darkMaterialTheme.scaffoldBackgroundColor}',
  );
  print('');
  print('  Resulting Cupertino theme:');
  print('    • brightness: ${darkCupertinoTheme.brightness}');
  print(
    '    • scaffoldBackgroundColor: ${darkCupertinoTheme.scaffoldBackgroundColor}',
  );
  print('    • barBackgroundColor: ${darkCupertinoTheme.barBackgroundColor}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: TYPOGRAPHY MAPPING
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: TYPOGRAPHY MAPPING                                     │',
  );
  print(
    '│ Text styles from Material to Cupertino                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Text style mapping:');
  print(
    '┌─────────────────────────────┬───────────────────────────────────────┐',
  );
  print(
    '│     Material TextStyle      │     Cupertino TextStyle               │',
  );
  print(
    '├─────────────────────────────┼───────────────────────────────────────┤',
  );
  print(
    '│ headlineLarge               │ navLargeTitleTextStyle                │',
  );
  print(
    '│ titleLarge                  │ navTitleTextStyle                     │',
  );
  print(
    '│ bodyLarge                   │ textStyle                             │',
  );
  print(
    '│ bodyMedium                  │ actionTextStyle                       │',
  );
  print(
    '│ labelLarge                  │ tabLabelTextStyle                     │',
  );
  print(
    '└─────────────────────────────┴───────────────────────────────────────┘',
  );
  print('');

  final textTheme = cupertinoTheme.textTheme;
  print('CupertinoTextThemeData:');
  print('  • textStyle: ${textTheme.textStyle.fontSize}pt');
  print('  • actionTextStyle: ${textTheme.actionTextStyle.fontSize}pt');
  print('  • navTitleTextStyle: ${textTheme.navTitleTextStyle.fontSize}pt');
  print(
    '  • navLargeTitleTextStyle: ${textTheme.navLargeTitleTextStyle.fontSize}pt',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: USING IN MATERIAL APP
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: USING IN MATERIAL APP                                  │',
  );
  print(
    '│ Integrating Cupertino widgets in Material apps                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Integration pattern:');
  print('  MaterialApp(');
  print('    theme: ThemeData(...),');
  print('    home: Builder(');
  print('      builder: (context) {');
  print('        // Cupertino widgets automatically');
  print('        // inherit Material theme colors');
  print('        return CupertinoButton(');
  print('          child: Text("iOS Button"),');
  print('          onPressed: () {},');
  print('        );');
  print('      },');
  print('    ),');
  print('  )');
  print('');

  print('Benefits of theme bridging:');
  print('  • Consistent color palette');
  print('  • No manual color re-definition');
  print('  • Automatic dark mode support');
  print('  • Platform-appropriate styling');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: CUSTOM OVERRIDES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: CUSTOM OVERRIDES                                       │',
  );
  print(
    '│ Customizing the bridged theme                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Override specific Cupertino properties:');
  print('  CupertinoTheme(');
  print('    data: MaterialBasedCupertinoThemeData(');
  print('      materialTheme: Theme.of(context),');
  print('    ).copyWith(');
  print('      primaryColor: Colors.orange,');
  print('      barBackgroundColor: Colors.white,');
  print('    ),');
  print('    child: ...,');
  print('  )');
  print('');

  print('Common overrides:');
  print('  • primaryColor: Custom accent color');
  print('  • scaffoldBackgroundColor: Page background');
  print('  • barBackgroundColor: Nav bar tint');
  print('  • textTheme: Typography adjustments');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: COMPARISON                                             │',
  );
  print(
    '│ MaterialBasedCupertinoThemeData vs CupertinoThemeData             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Feature comparison:');
  print(
    '┌────────────────────────┬──────────────────────┬──────────────────────┐',
  );
  print(
    '│       Feature          │  CupertinoThemeData  │  MaterialBased...    │',
  );
  print(
    '├────────────────────────┼──────────────────────┼──────────────────────┤',
  );
  print(
    '│ Source                 │ Explicit definition  │ Derived from Material│',
  );
  print(
    '│ Color sync             │ Manual               │ Automatic            │',
  );
  print(
    '│ Dark mode              │ Separate themes      │ Inherits brightness  │',
  );
  print(
    '│ Typography             │ iOS defaults         │ Material to iOS map  │',
  );
  print(
    '│ Use case               │ Cupertino-only apps  │ Mixed Material+iOS   │',
  );
  print(
    '└────────────────────────┴──────────────────────┴──────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL USE CASES                                   │',
  );
  print(
    '│ When to use MaterialBasedCupertinoThemeData                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Cross-Platform Apps');
  print('   Material app with iOS-native pickers/alerts');
  print('');

  print('2. Platform Adaptive UI');
  print('   Single codebase, platform-specific widgets');
  print('');

  print('3. Gradual Migration');
  print('   Transitioning from Material to Cupertino');
  print('');

  print('4. Design System Consistency');
  print('   Brand colors across all platforms');
  print('');

  print('5. Dark Mode Support');
  print('   Automatic theme propagation');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║      CUPERTINO BASED MATERIAL THEME DATA SUMMARY                  ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('MaterialBasedCupertinoThemeData key features:');
  print('  • Bridges Material to Cupertino styling');
  print('  • Automatic color mapping');
  print('  • Typography conversion');
  print('  • Brightness inheritance');
  print('');
  print('Best practices:');
  print('  • Use in MaterialApp with Cupertino widgets');
  print('  • Override specific properties as needed');
  print('  • Let brightness flow through automatically');
  print('');
  print('MaterialBasedCupertinoThemeData Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: materialTheme,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF673AB7), Color(0xFF9575CD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'MaterialBasedCupertinoThemeData',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Theme Bridge: Material → Cupertino',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Theme Flow Diagram
              _buildSectionHeader('THEME INHERITANCE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildThemeFlowItem(
                      'ThemeData',
                      'Material Design',
                      Colors.blue,
                    ),
                    Icon(Icons.arrow_downward, color: Colors.grey),
                    _buildThemeFlowItem(
                      'MaterialBasedCupertinoThemeData',
                      'Bridge',
                      Colors.purple,
                    ),
                    Icon(Icons.arrow_downward, color: Colors.grey),
                    _buildThemeFlowItem(
                      'CupertinoThemeData',
                      'iOS Style',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Color Mapping Demo
              _buildSectionHeader('COLOR MAPPING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Material',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildColorChip(
                            'Primary',
                            materialTheme.colorScheme.primary,
                          ),
                          _buildColorChip(
                            'Secondary',
                            materialTheme.colorScheme.secondary,
                          ),
                          _buildColorChip(
                            'Surface',
                            materialTheme.colorScheme.surface,
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 100, color: Colors.grey[300]),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Cupertino',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildColorChip(
                            'Primary',
                            cupertinoTheme.primaryColor,
                          ),
                          _buildColorChip(
                            'Contrasting',
                            cupertinoTheme.primaryContrastingColor,
                          ),
                          _buildColorChip(
                            'Scaffold',
                            cupertinoTheme.scaffoldBackgroundColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Live Demo with Cupertino Widget
              _buildSectionHeader('LIVE DEMO: CUPERTINO IN MATERIAL'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: CupertinoTheme(
                  data: cupertinoTheme,
                  child: Column(
                    children: [
                      Text(
                        'Cupertino widgets using Material colors:',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 12),
                      CupertinoButton.filled(
                        child: Text('CupertinoButton.filled'),
                        onPressed: () {},
                      ),
                      SizedBox(height: 12),
                      CupertinoButton(
                        child: Text('CupertinoButton'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Brightness comparison
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'BRIGHTNESS INHERITANCE',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBrightnessBox('Light', Brightness.light),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildBrightnessBox('Dark', Brightness.dark),
                        ),
                      ],
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
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryStat('Mapping', 'Auto'),
                        _buildSummaryStat('Dark Mode', '✓'),
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
                    'Deep Demo • MaterialBasedCupertinoThemeData • Flutter',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        color: Color(0xFF673AB7),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildThemeFlowItem(String title, String subtitle, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _buildColorChip(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[300]!),
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    ),
  );
}

Widget _buildBrightnessBox(String label, Brightness brightness) {
  final isLight = brightness == Brightness.light;
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isLight ? Colors.white : Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isLight ? Colors.black : Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          isLight ? 'White BG' : 'Dark BG',
          style: TextStyle(
            fontSize: 10,
            color: isLight ? Colors.grey[600] : Colors.grey[400],
          ),
        ),
      ],
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
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
