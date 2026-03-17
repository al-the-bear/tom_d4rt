// D4rt test script: Tests Brightness from dart_ui
// Brightness enum defines light and dark color schemes
// Fundamental to theming in Flutter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                    Brightness - Deep Demo                          ║');
  print('║          Light and Dark Theme Brightness Specification             ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Brightness Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: Brightness Fundamentals                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Brightness is a fundamental enum that describes whether a color');
  print('scheme or theme is light or dark.');
  print('');
  print('Key characteristics:');
  print('  - Simple binary choice: light or dark');
  print('  - Used throughout Flutter theming system');
  print('  - Affects text colors, background colors, widget styling');
  print('  - Defined in dart:ui but heavily used in material/cupertino');
  print('');
  print('Package: dart:ui');
  print('Also exported from: package:flutter/material.dart');
  print('                    package:flutter/widgets.dart');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Brightness Values
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: All Brightness Values                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Brightness enum values:');
  for (final brightness in ui.Brightness.values) {
    print('  [${brightness.index}] ${brightness.name}: $brightness');
  }
  print('');
  print('Total values: ${ui.Brightness.values.length}');
  print('');
  final first = ui.Brightness.values.first;
  final last = ui.Brightness.values.last;
  print('First value: $first (index: ${first.index})');
  print('Last value: $last (index: ${last.index})');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Brightness.light
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: Brightness.light                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const light = ui.Brightness.light;
  print('Brightness.light:');
  print('  - Name: ${light.name}');
  print('  - Index: ${light.index}');
  print('');
  print('Characteristics:');
  print('  - Light background colors (white, beige, light grey)');
  print('  - Dark text and icons');
  print('  - Suitable for well-lit environments');
  print('  - Standard/default mode');
  print('');
  print('Typical light theme:');
  print('  - Background: white (#FFFFFF)');
  print('  - Text: black or dark grey (#000000, #212121)');
  print('  - Primary: Vibrant colors');
  print('  - Status bar icons: Dark');
  print('');
  print('User expectations:');
  print('  - Day mode');
  print('  - High contrast for readability');
  print('  - Traditional UI appearance');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Brightness.dark
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: Brightness.dark                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const dark = ui.Brightness.dark;
  print('Brightness.dark:');
  print('  - Name: ${dark.name}');
  print('  - Index: ${dark.index}');
  print('');
  print('Characteristics:');
  print('  - Dark background colors (black, dark grey)');
  print('  - Light text and icons');
  print('  - Reduces eye strain in low-light');
  print('  - Battery saving on OLED screens');
  print('');
  print('Typical dark theme:');
  print('  - Background: dark grey (#121212) or black (#000000)');
  print('  - Text: white or light grey (#FFFFFF, #E0E0E0)');
  print('  - Primary: Slightly desaturated colors');
  print('  - Status bar icons: Light');
  print('');
  print('User expectations:');
  print('  - Night mode');
  print('  - Reduced blue light');
  print('  - Modern appearance');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Brightness in ThemeData
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Brightness in ThemeData                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using Brightness with MaterialApp and ThemeData:');
  print('');
  print('Option 1: Direct brightness setting');
  print('  ThemeData(');
  print('    brightness: Brightness.dark,');
  print('  )');
  print('');
  print('Option 2: Using factory constructors');
  print('  ThemeData.light()  // Brightness.light by default');
  print('  ThemeData.dark()   // Brightness.dark by default');
  print('');
  print('Option 3: ColorScheme-based');
  print('  ThemeData(');
  print('    colorScheme: ColorScheme.dark(');
  print('      primary: Colors.blue,');
  print('    ),');
  print('  )');
  print('');
  print('Option 4: From seed color');
  print('  ThemeData(');
  print('    colorScheme: ColorScheme.fromSeed(');
  print('      seedColor: Colors.blue,');
  print('      brightness: Brightness.dark,');
  print('    ),');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: MaterialApp Theme Mode
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: MaterialApp Theme Mode                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('MaterialApp supports theme switching:');
  print('');
  print('Example:');
  print('  MaterialApp(');
  print('    theme: ThemeData.light(),        // Light theme');
  print('    darkTheme: ThemeData.dark(),     // Dark theme');
  print('    themeMode: ThemeMode.system,     // Follow system');
  print('  )');
  print('');
  print('ThemeMode options:');
  print('  - ThemeMode.system: Follow platform preference');
  print('  - ThemeMode.light: Always use light theme');
  print('  - ThemeMode.dark: Always use dark theme');
  print('');
  print('Accessing current brightness in widget:');
  print('  final brightness = Theme.of(context).brightness;');
  print('  final isDark = brightness == Brightness.dark;');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Brightness Detection
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Platform Brightness Detection                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Detecting platform/system brightness:');
  print('');
  print('Option 1: MediaQuery');
  print('  final brightness = MediaQuery.platformBrightnessOf(context);');
  print('  final isSystemDark = brightness == Brightness.dark;');
  print('');
  print('Option 2: PlatformDispatcher');
  print('  final brightness = PlatformDispatcher.instance.platformBrightness;');
  print('');
  print('Option 3: WidgetsBinding');
  print('  final brightness = WidgetsBinding.instance.window.platformBrightness;');
  print('');
  print('Platform-specific behavior:');
  print('  iOS: Settings → Display & Brightness');
  print('  Android: Settings → Display → Dark theme');
  print('  Windows: Settings → Personalization → Colors');
  print('  macOS: System Preferences → Appearance');
  print('  Web: prefers-color-scheme CSS media query');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Brightness in ColorScheme
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Brightness in ColorScheme                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ColorScheme includes brightness property:');
  print('');
  print('Creating color schemes:');
  print('  ColorScheme.light(');
  print('    primary: Colors.blue,');
  print('    secondary: Colors.teal,');
  print('  )  // brightness = Brightness.light');
  print('');
  print('  ColorScheme.dark(');
  print('    primary: Colors.lightBlue,');
  print('    secondary: Colors.tealAccent,');
  print('  )  // brightness = Brightness.dark');
  print('');
  print('Accessing brightness:');
  print('  final scheme = Theme.of(context).colorScheme;');
  print('  final isDark = scheme.brightness == Brightness.dark;');
  print('');
  print('Color adjustments for brightness:');
  print('  Light mode: Use standard colors');
  print('  Dark mode: Use lighter/desaturated variants');
  print('           (e.g., Colors.blue → Colors.lightBlue)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Status Bar and System UI
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Status Bar and System UI                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('System UI brightness affects status bar icons:');
  print('');
  print('Using SystemChrome:');
  print('  SystemChrome.setSystemUIOverlayStyle(');
  print('    SystemUiOverlayStyle(');
  print('      statusBarBrightness: Brightness.light,  // iOS');
  print('      statusBarIconBrightness: Brightness.dark,  // Android');
  print('    ),');
  print('  );');
  print('');
  print('Important notes:');
  print('  - iOS: statusBarBrightness');
  print('    - Brightness.light → dark icons (for light backgrounds)');
  print('    - Brightness.dark → light icons (for dark backgrounds)');
  print('');
  print('  - Android: statusBarIconBrightness');
  print('    - Brightness.light → light icons');
  print('    - Brightness.dark → dark icons');
  print('');
  print('Using AnnotatedRegion:');
  print('  AnnotatedRegion<SystemUiOverlayStyle>(');
  print('    value: SystemUiOverlayStyle.light,  // Light status bar');
  print('    child: Scaffold(...),');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Cupertino Brightness
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Cupertino Brightness                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Cupertino theming also uses Brightness:');
  print('');
  print('CupertinoThemeData:');
  print('  CupertinoThemeData(');
  print('    brightness: Brightness.dark,');
  print('    primaryColor: CupertinoColors.activeBlue,');
  print('  )');
  print('');
  print('CupertinoApp:');
  print('  CupertinoApp(');
  print('    theme: CupertinoThemeData(');
  print('      brightness: Brightness.light,');
  print('    ),');
  print('  )');
  print('');
  print('CupertinoDynamicColor:');
  print('  CupertinoDynamicColor.withBrightness(');
  print('    color: CupertinoColors.white,           // Light mode');
  print('    darkColor: CupertinoColors.black,       // Dark mode');
  print('  )');
  print('');
  print('Resolving dynamic colors:');
  print('  final color = CupertinoDynamicColor.resolve(');
  print('    CupertinoColors.systemBackground,');
  print('    context,');
  print('  );');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Conditional Styling
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Conditional Styling                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Common patterns for brightness-aware styling:');
  print('');
  print('Pattern 1: Simple conditional');
  print('  final isDark = Theme.of(context).brightness == Brightness.dark;');
  print('  return Container(');
  print('    color: isDark ? Colors.grey[900] : Colors.white,');
  print('    child: Text(');
  print('      "Hello",');
  print('      style: TextStyle(');
  print('        color: isDark ? Colors.white : Colors.black,');
  print('      ),');
  print('    ),');
  print('  );');
  print('');
  print('Pattern 2: Extension method');
  print('  extension BrightnessExtension on Brightness {');
  print('    Color get backgroundColor =>');
  print('      this == Brightness.dark ? Colors.grey[900]! : Colors.white;');
  print('    Color get textColor =>');
  print('      this == Brightness.dark ? Colors.white : Colors.black;');
  print('  }');
  print('');
  print('Pattern 3: Theme extensions');
  print('  ThemeData(');
  print('    extensions: [');
  print('      MyColors(');
  print('        cardBackground: brightness == Brightness.dark');
  print('          ? Colors.grey[850]!');
  print('          : Colors.white,');
  print('      ),');
  print('    ],');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Brightness Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Brightness Transitions                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Smooth transitions between light/dark modes:');
  print('');
  print('Default MaterialApp behavior:');
  print('  - AnimatedTheme is used internally');
  print('  - Provides smooth color transitions');
  print('  - Duration controlled by MaterialApp');
  print('');
  print('Custom transition:');
  print('  AnimatedTheme(');
  print('    data: isDark ? darkTheme : lightTheme,');
  print('    duration: Duration(milliseconds: 300),');
  print('    curve: Curves.easeInOut,');
  print('    child: child,');
  print('  )');
  print('');
  print('For individual widgets:');
  print('  AnimatedContainer(');
  print('    duration: Duration(milliseconds: 200),');
  print('    color: isDark ? Colors.grey[900] : Colors.white,');
  print('    child: content,');
  print('  )');
  print('');
  print('TweenAnimationBuilder for fine control:');
  print('  TweenAnimationBuilder<Color?>(');
  print('    tween: ColorTween(');
  print('      begin: Colors.white,');
  print('      end: isDark ? Colors.black : Colors.white,');
  print('    ),');
  print('    duration: Duration(milliseconds: 300),');
  print('    builder: (context, color, child) { ... },');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Dark Mode Best Practices
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Dark Mode Best Practices                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Design guidelines for dark mode:');
  print('');
  print('1. Avoid pure black (#000000):');
  print('   - Use dark grey (#121212) for backgrounds');
  print('   - Reduces contrast harshness');
  print('   - Exception: OLED optimization when specifically needed');
  print('');
  print('2. Desaturate colors:');
  print('   - Primary colors should be slightly lighter');
  print('   - Avoid neon/bright colors that strain eyes');
  print('   - Test: Colors should look comfortable at night');
  print('');
  print('3. Elevation with overlays:');
  print('   - Higher elevation = slightly lighter surface');
  print('   - Material 3: tonal elevation');
  print('   - Creates visual hierarchy without shadows');
  print('');
  print('4. Test images and icons:');
  print('   - Some images may need dark mode variants');
  print('   - Icons should maintain visibility');
  print('   - Consider alpha/transparency on dark backgrounds');
  print('');
  print('5. Accessibility:');
  print('   - Maintain WCAG contrast ratios');
  print('   - Test with screen readers');
  print('   - Don\'t rely solely on color for information');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Testing Brightness Scenarios
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Testing Brightness Scenarios                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Testing widgets with different brightness:');
  print('');
  print('Widget test with specific brightness:');
  print('  testWidgets("renders correctly in dark mode", (tester) async {');
  print('    await tester.pumpWidget(');
  print('      MaterialApp(');
  print('        theme: ThemeData.dark(),');
  print('        home: MyWidget(),');
  print('      ),');
  print('    );');
  print('    expect(find.byType(MyWidget), findsOneWidget);');
  print('  });');
  print('');
  print('Testing platform brightness:');
  print('  testWidgets("responds to system brightness", (tester) async {');
  print('    tester.binding.window.platformBrightnessTestValue = Brightness.dark;');
  print('    await tester.pumpWidget(MyApp());');
  print('    // Verify dark mode applied');
  print('    tester.binding.window.clearPlatformBrightnessTestValue();');
  print('  });');
  print('');
  print('Golden tests for both modes:');
  print('  for (final brightness in Brightness.values) {');
  print('    testGoldens("myWidget-\${brightness.name}", (tester) async {');
  print('      // Set up and verify golden');
  print('    });');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Brightness summary:');
  print('');
  print('┌───────────────────┬─────────────────────────────────────────────────┐');
  print('│ Value             │ Description                                     │');
  print('├───────────────────┼─────────────────────────────────────────────────┤');
  print('│ Brightness.light  │ Light backgrounds, dark text (day mode)         │');
  print('│ Brightness.dark   │ Dark backgrounds, light text (night mode)       │');
  print('└───────────────────┴─────────────────────────────────────────────────┘');
  print('');
  print('Key integration points:');
  print('  1. ThemeData.brightness - Set overall theme brightness');
  print('  2. ColorScheme.brightness - Color scheme brightness');
  print('  3. MediaQuery.platformBrightnessOf - Get system preference');
  print('  4. SystemUiOverlayStyle - Status bar icon color');
  print('  5. CupertinoThemeData.brightness - iOS-style theming');
  print('');
  print('Best practices:');
  print('  1. Support both light and dark modes');
  print('  2. Respect system preference (ThemeMode.system)');
  print('  3. Allow manual override');
  print('  4. Test thoroughly in both modes');
  print('  5. Follow platform design guidelines');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('Brightness deep demo completed');

  // Return visual UI demonstrating both brightness modes
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey.shade200,
          Colors.grey.shade400,
        ],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: ui.Brightness.values.map((brightness) {
            final isDark = brightness == ui.Brightness.dark;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isDark ? 0 : 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      size: 48,
                      color: isDark ? Colors.amber : Colors.orange,
                    ),
                    SizedBox(height: 12),
                    Text(
                      brightness.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      'Brightness.${brightness.name}',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'index: ${brightness.index}',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Theme comparison
        Text(
          'Theme Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: ui.Brightness.values.map((brightness) {
            final isDark = brightness == ui.Brightness.dark;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isDark ? 0 : 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sample app bar
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.blue.shade700 : Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.menu, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'App Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Sample content
                    Text(
                      'Sample content',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey.shade800,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Secondary text',
                      style: TextStyle(
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Sample button
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.blue.shade400 : Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Button',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Usage examples
        Text(
          'Common Usage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _UsageCard(
                icon: Icons.palette,
                title: 'ThemeData',
                code: 'brightness:',
                color: Colors.purple,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _UsageCard(
                icon: Icons.color_lens,
                title: 'ColorScheme',
                code: '.light() / .dark()',
                color: Colors.orange,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _UsageCard(
                icon: Icons.phone_android,
                title: 'System',
                code: 'platformBrightness',
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.Brightness.values.length} values • Core theme property • Used by Material, Cupertino, and custom themes',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
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

// Helper widget for usage cards
class _UsageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String code;
  final Color color;

  const _UsageCard({
    required this.icon,
    required this.title,
    required this.code,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            code,
            style: TextStyle(
              fontSize: 9,
              fontFamily: 'monospace',
              color: color.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
