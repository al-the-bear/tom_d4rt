// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for Brightness from dart:ui
// Brightness enum defines light/dark schemes — fundamental to theming
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Brightness Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Brightness Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('Brightness defines whether surfaces are light or dark');
  print('Values: ${ui.Brightness.values}');
  print('Count: ${ui.Brightness.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  final light = ui.Brightness.light;
  final dark = ui.Brightness.dark;
  print('light: name=${light.name}, index=${light.index}');
  print('dark: name=${dark.name}, index=${dark.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Brightness.light
  // ═══════════════════════════════════════════════════════════════════════════

  print('\nBrightness.light:');
  print('  Background: white or light colors');
  print('  Foreground: dark text for readability');
  print('  Status bar: dark icons on light background');
  print('  Default for most apps');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Brightness.dark
  // ═══════════════════════════════════════════════════════════════════════════

  print('\nBrightness.dark:');
  print('  Background: dark gray or black');
  print('  Foreground: light text for readability');
  print('  Status bar: light icons on dark background');
  print('  Reduces eye strain in low light, saves OLED battery');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: ThemeData usage
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- ThemeData usage ---');
  print('ThemeData(brightness: Brightness.light)');
  print('ThemeData(brightness: Brightness.dark)');
  print('ThemeData.light() / ThemeData.dark() factory constructors');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ColorScheme
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- ColorScheme ---');
  print('ColorScheme.light() → brightness: Brightness.light');
  print('ColorScheme.dark() → brightness: Brightness.dark');
  print('ColorScheme.fromSeed(brightness: ...)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Detection
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Platform brightness ---');
  print('MediaQuery.of(context).platformBrightness');
  print('WidgetsBinding.instance.platformDispatcher.platformBrightness');
  print('Reflects OS-level light/dark mode setting');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Equality
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Equality ---');
  print('light == light: ${light == ui.Brightness.light}');
  print('dark == dark: ${dark == ui.Brightness.dark}');
  print('light == dark: ${light == dark}');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget brightnessPanel(ui.Brightness brightness) {
    final isDark = brightness == ui.Brightness.dark;
    final bg = isDark ? Color(0xFF1E1E1E) : Colors.white;
    final fg = isDark ? Colors.white : Color(0xFF1E1E1E);
    final secondary = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    final accent = isDark ? Colors.blue[300]! : Colors.blue;
    final surface = isDark ? Color(0xFF2D2D2D) : Colors.grey[50]!;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mode icon + label
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: isDark ? Colors.amber : Colors.orange,
                size: 28,
              ),
              SizedBox(width: 8),
              Text(
                brightness.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: fg,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'index: ${brightness.index}',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: secondary,
            ),
          ),
          SizedBox(height: 10),
          // Simulated app bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(Icons.menu, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'App Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Content
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Primary text', style: TextStyle(color: fg, fontSize: 11)),
                Text(
                  'Secondary text',
                  style: TextStyle(color: secondary, fontSize: 10),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          // Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Action',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget themeProperty(String prop, String lightVal, String darkVal) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              prop,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(lightVal, style: TextStyle(fontSize: 9)),
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(darkVal, style: TextStyle(fontSize: 9)),
            ),
          ),
        ],
      ),
    );
  }

  Widget usageTile(IconData icon, String title, String code, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            code,
            style: TextStyle(
              fontSize: 8,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[800]!, Colors.amber[600]!],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.light_mode, color: Colors.amber[200], size: 28),
                  SizedBox(width: 12),
                  Icon(Icons.dark_mode, color: Colors.grey[300], size: 28),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Brightness Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Light and Dark color scheme foundation',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Side-by-side panels
        Text(
          '1. Light vs Dark Mode',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: brightnessPanel(light)),
            SizedBox(width: 12),
            Expanded(child: brightnessPanel(dark)),
          ],
        ),
        SizedBox(height: 16),

        // Theme properties comparison
        Text(
          '2. Theme Property Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 100),
                    Expanded(
                      child: Text(
                        'Light',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[700],
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Dark',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 8),
                themeProperty(
                  'Background',
                  'White (#FFFFFF)',
                  'Dark gray (#1E1E1E)',
                ),
                themeProperty('Foreground', 'Black text', 'White text'),
                themeProperty('Primary', 'Saturated blue', 'Lighter blue'),
                themeProperty('Surface', 'Light gray', 'Dark gray'),
                themeProperty('Status bar', 'Dark icons', 'Light icons'),
                themeProperty('Shadow', 'Visible', 'Subtle/none'),
                themeProperty('Elevation', 'Shadow-based', 'Overlay-based'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Usage
        Text(
          '3. Common Usage Patterns',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: usageTile(
                Icons.palette,
                'ThemeData',
                'brightness:\nBrightness.light',
                Colors.purple,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: usageTile(
                Icons.color_lens,
                'ColorScheme',
                'ColorScheme\n.light() / .dark()',
                Colors.orange,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: usageTile(
                Icons.phone_android,
                'Platform',
                'platformBrightness\n(OS setting)',
                Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Dark mode best practices
        Text(
          '4. Dark Mode Best Practices',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final tip in [
                MapEntry(
                  Icons.opacity,
                  'Use dark gray (#121212) not pure black',
                ),
                MapEntry(
                  Icons.text_fields,
                  'Reduce text opacity for hierarchy',
                ),
                MapEntry(Icons.contrast, 'Maintain 4.5:1 contrast ratio'),
                MapEntry(
                  Icons.layers,
                  'Express elevation via surface overlays',
                ),
                MapEntry(Icons.color_lens, 'Desaturate primary colors'),
              ])
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(tip.key, color: Colors.amber[300], size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip.value,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Equality
        Text(
          '5. Equality',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                for (final pair in [
                  MapEntry('light == light', '${light == ui.Brightness.light}'),
                  MapEntry('dark == dark', '${dark == ui.Brightness.dark}'),
                  MapEntry('light == dark', '${light == dark}'),
                ])
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(pair.key, style: TextStyle(fontSize: 11)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: pair.value == 'true'
                                ? Colors.green.withValues(alpha: 0.15)
                                : Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            pair.value,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: pair.value == 'true'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.Brightness.values.length} values: light, dark • Core theme property • Drives Material, Cupertino, and custom theming',
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
