// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for SystemColor from dart:ui
//
// SystemColor represents a color defined by the operating system that user
// applications may reference for styling. These colors are defined by W3C CSS
// system color specification and include standard names like AccentColor,
// ButtonText, Canvas, etc.
//
// Key characteristics:
//   - Has a 'name' property for the standard CSS system color name
//   - Has a nullable 'value' property (Color?) - null if unsupported
//   - 'isSupported' getter returns true if value is not null
//   - 'platformProvidesSystemColors' static getter checks platform support
//   - 'light' and 'dark' static getters provide SystemColorPalette instances
//
// This demo visually demonstrates SystemColor usage with fallback patterns
// and simulated system color scenarios.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF1A237E), const Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1A237E).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.color_lens, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF3949AB).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF3949AB), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSystemColorCard(
  String name,
  Color? value,
  String description,
  IconData icon,
) {
  final isSupported = value != null;
  final displayColor = value ?? const Color(0xFFE0E0E0);

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSupported ? displayColor : const Color(0xFFE0E0E0),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Color preview
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: displayColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Icon(icon, color: _getContrastColor(displayColor), size: 32),
          ),
        ),
        // Info section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isSupported
                            ? const Color(0xFF4CAF50).withAlpha(30)
                            : const Color(0xFFFF9800).withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isSupported ? 'Supported' : 'Unsupported',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isSupported
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF9800),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  isSupported
                      ? 'Value: 0x${_colorToHex(displayColor)}'
                      : 'Value: null (fallback shown)',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Color _getContrastColor(Color color) {
  final argb = color.toARGB32();
  final luminance =
      (0.299 * ((argb >> 16) & 0xFF) +
          0.587 * ((argb >> 8) & 0xFF) +
          0.114 * (argb & 0xFF)) /
      255;
  return luminance > 0.5 ? Colors.black : Colors.white;
}

String _colorToHex(Color color) {
  return color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
}

Widget _buildColorCategoryCard(
  String category,
  List<Map<String, dynamic>> colors,
  IconData categoryIcon,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(categoryIcon, color: const Color(0xFF3949AB)),
            const SizedBox(width: 8),
            Text(
              category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map((c) {
            final color = c['color'] as Color;
            final name = c['name'] as String;
            return Tooltip(
              message: name,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.withAlpha(80),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(60),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    name.substring(0, 2).toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getContrastColor(color),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildPlatformSupportCard(bool platformSupports) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: platformSupports
            ? [const Color(0xFF4CAF50), const Color(0xFF81C784)]
            : [const Color(0xFFFF9800), const Color(0xFFFFB74D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(
          platformSupports ? Icons.check_circle : Icons.info,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Support',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                platformSupports
                    ? 'System colors are available on this platform'
                    : 'System colors are not supported (web only currently)',
                style: TextStyle(
                  color: Colors.white.withAlpha(220),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFallbackPatternDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: const Color(0xFFFFA000)),
            const SizedBox(width: 8),
            const Text(
              'Fallback Pattern',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFF57C00),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '// Using SystemColor with fallback\n'
            'final sysColor = SystemColor(\n'
            '  name: "AccentColor",\n'
            '  value: obtainedValue, // null if unsupported\n'
            ');\n\n'
            '// Safe usage pattern\n'
            'final color = sysColor.isSupported\n'
            '    ? sysColor.value!\n'
            '    : Theme.of(context).colorScheme.primary;',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildW3CColorsVisual() {
  // W3C CSS System Colors (standard names)
  final w3cColors = <Map<String, dynamic>>[
    {
      'name': 'Canvas',
      'color': const Color(0xFFFFFFFF),
      'desc': 'Application background',
    },
    {
      'name': 'CanvasText',
      'color': const Color(0xFF000000),
      'desc': 'Text on canvas',
    },
    {
      'name': 'LinkText',
      'color': const Color(0xFF0000EE),
      'desc': 'Hyperlinks',
    },
    {
      'name': 'VisitedText',
      'color': const Color(0xFF551A8B),
      'desc': 'Visited links',
    },
    {
      'name': 'ActiveText',
      'color': const Color(0xFFFF0000),
      'desc': 'Active links',
    },
    {
      'name': 'ButtonFace',
      'color': const Color(0xFFE0E0E0),
      'desc': 'Button background',
    },
    {
      'name': 'ButtonText',
      'color': const Color(0xFF000000),
      'desc': 'Button text',
    },
    {
      'name': 'ButtonBorder',
      'color': const Color(0xFF767676),
      'desc': 'Button border',
    },
    {
      'name': 'Field',
      'color': const Color(0xFFFFFFFF),
      'desc': 'Input field bg',
    },
    {
      'name': 'FieldText',
      'color': const Color(0xFF000000),
      'desc': 'Input field text',
    },
    {
      'name': 'Highlight',
      'color': const Color(0xFF3390FF),
      'desc': 'Selection bg',
    },
    {
      'name': 'HighlightText',
      'color': const Color(0xFFFFFFFF),
      'desc': 'Selection text',
    },
    {
      'name': 'GrayText',
      'color': const Color(0xFF808080),
      'desc': 'Disabled text',
    },
    {
      'name': 'AccentColor',
      'color': const Color(0xFF0078D4),
      'desc': 'Accent/theme color',
    },
    {
      'name': 'AccentColorText',
      'color': const Color(0xFFFFFFFF),
      'desc': 'Accent text',
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: const Color(0xFF3949AB)),
            const SizedBox(width: 8),
            const Text(
              'W3C CSS System Colors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Standard color names as defined by CSS specification',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        ...w3cColors.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: c['color'] as Color,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.withAlpha(80)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        c['desc'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildThemeIntegrationDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: const Color(0xFF3949AB)),
            const SizedBox(width: 8),
            const Text(
              'Theme Integration Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Light theme button simulation
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // ButtonFace light
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF767676)), // ButtonBorder
          ),
          child: const Text(
            'Light Theme Button',
            style: TextStyle(
              color: Color(0xFF000000), // ButtonText
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Dark theme button simulation
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF404040), // ButtonFace dark
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF666666)), // ButtonBorder
          ),
          child: const Text(
            'Dark Theme Button',
            style: TextStyle(
              color: Color(0xFFFFFFFF), // ButtonText
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Input field simulation
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF), // Field
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF767676)),
          ),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14),
                    children: [
                      const TextSpan(
                        text: 'Click ',
                        style: TextStyle(color: Color(0xFF000000)), // FieldText
                      ),
                      const TextSpan(
                        text: 'this link',
                        style: TextStyle(
                          color: Color(0xFF0000EE), // LinkText
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' for info',
                        style: TextStyle(color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Selection highlight
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withAlpha(80)),
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 14, color: Color(0xFF000000)),
              children: [
                TextSpan(text: 'Some '),
                TextSpan(
                  text: 'highlighted',
                  style: TextStyle(
                    backgroundColor: Color(0xFF3390FF), // Highlight
                    color: Color(0xFFFFFFFF), // HighlightText
                  ),
                ),
                TextSpan(text: ' text'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyTable() {
  final properties = [
    {'name': 'name', 'type': 'String', 'desc': 'W3C CSS system color name'},
    {
      'name': 'value',
      'type': 'Color?',
      'desc': 'Color value if supported, null otherwise',
    },
    {
      'name': 'isSupported',
      'type': 'bool',
      'desc': 'Returns true if value is not null',
    },
    {
      'name': 'platformProvidesSystemColors',
      'type': 'static bool',
      'desc': 'Platform support check',
    },
    {
      'name': 'light',
      'type': 'static SystemColorPalette',
      'desc': 'Light mode palette',
    },
    {
      'name': 'dark',
      'type': 'static SystemColorPalette',
      'desc': 'Dark mode palette',
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: const Color(0xFF3949AB)),
            const SizedBox(width: 8),
            const Text(
              'SystemColor Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...properties.map((p) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    p['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    p['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    p['desc']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== SystemColor Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SystemColor Overview ---');
  print('SystemColor: Represents OS-defined system colors');
  print('Defined by W3C CSS system color specification');
  print('Currently supported on web platform only');

  // Check platform support
  final platformSupports = ui.SystemColor.platformProvidesSystemColors;
  print('\nplatformProvidesSystemColors: $platformSupports');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CREATING SYSTEM COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating SystemColor Instances ---');

  // Create with supported value
  final accentColor = ui.SystemColor(
    name: 'AccentColor',
    value: const Color(0xFF0078D4),
  );
  print('Created AccentColor:');
  print('  name: ${accentColor.name}');
  print('  value: ${accentColor.value}');
  print('  isSupported: ${accentColor.isSupported}');

  // Create with null value (unsupported)
  final unsupportedColor = ui.SystemColor(name: 'CustomColor', value: null);
  print('\nCreated unsupported color:');
  print('  name: ${unsupportedColor.name}');
  print('  value: ${unsupportedColor.value}');
  print('  isSupported: ${unsupportedColor.isSupported}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: STANDARD W3C SYSTEM COLOR NAMES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- W3C CSS System Color Names ---');
  final w3cNames = [
    'Canvas',
    'CanvasText',
    'LinkText',
    'VisitedText',
    'ActiveText',
    'ButtonFace',
    'ButtonText',
    'ButtonBorder',
    'Field',
    'FieldText',
    'Highlight',
    'HighlightText',
    'SelectedItem',
    'SelectedItemText',
    'Mark',
    'MarkText',
    'GrayText',
    'AccentColor',
    'AccentColorText',
  ];

  for (final name in w3cNames) {
    print('  $name');
  }
  print('Total W3C names: ${w3cNames.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: LIGHT AND DARK PALETTES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SystemColor Palettes ---');
  print('SystemColor.light: Light mode palette');
  print('SystemColor.dark: Dark mode palette');
  print('Note: These throw UnsupportedError on non-web platforms');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PRACTICAL USAGE PATTERNS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Usage Patterns ---');

  // Pattern 1: Safe usage with isSupported
  final buttonFace = ui.SystemColor(
    name: 'ButtonFace',
    value: platformSupports ? const Color(0xFFE0E0E0) : null,
  );
  final effectiveButtonFace = buttonFace.isSupported
      ? buttonFace.value!
      : const Color(0xFFE0E0E0);
  print('ButtonFace (safe): $effectiveButtonFace');

  // Pattern 2: Multiple system colors for a component
  final buttonColors = <String, ui.SystemColor>{
    'face': ui.SystemColor(name: 'ButtonFace', value: const Color(0xFFE0E0E0)),
    'text': ui.SystemColor(name: 'ButtonText', value: const Color(0xFF000000)),
    'border': ui.SystemColor(
      name: 'ButtonBorder',
      value: const Color(0xFF767676),
    ),
  };
  print('\nButton color set:');
  for (final entry in buttonColors.entries) {
    print('  ${entry.key}: ${entry.value.value}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SIMULATED SYSTEM COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Simulated System Color Values ---');

  final simulatedColors = <ui.SystemColor>[
    ui.SystemColor(name: 'Canvas', value: const Color(0xFFFFFFFF)),
    ui.SystemColor(name: 'CanvasText', value: const Color(0xFF000000)),
    ui.SystemColor(name: 'LinkText', value: const Color(0xFF0000EE)),
    ui.SystemColor(name: 'Highlight', value: const Color(0xFF3390FF)),
    ui.SystemColor(name: 'HighlightText', value: const Color(0xFFFFFFFF)),
    ui.SystemColor(name: 'AccentColor', value: const Color(0xFF0078D4)),
    ui.SystemColor(name: 'GrayText', value: const Color(0xFF808080)),
  ];

  for (final sc in simulatedColors) {
    print('${sc.name}: ${sc.value} (isSupported: ${sc.isSupported})');
  }

  print('\n=== SystemColor Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('SystemColor', 'Platform-defined OS System Colors'),
        const SizedBox(height: 20),

        // Platform support status
        _buildPlatformSupportCard(platformSupports),
        const SizedBox(height: 20),

        // Properties table
        _buildSectionTitle('Class Properties', Icons.code),
        _buildPropertyTable(),
        const SizedBox(height: 20),

        // Example system colors
        _buildSectionTitle('System Color Examples', Icons.palette),

        _buildSystemColorCard(
          'AccentColor',
          const Color(0xFF0078D4),
          'Primary accent/theme color from OS',
          Icons.brush,
        ),
        _buildSystemColorCard(
          'ButtonFace',
          const Color(0xFFE0E0E0),
          'Default button background color',
          Icons.smart_button,
        ),
        _buildSystemColorCard(
          'Highlight',
          const Color(0xFF3390FF),
          'Selection/highlight background',
          Icons.highlight,
        ),
        _buildSystemColorCard(
          'GrayText',
          const Color(0xFF808080),
          'Disabled/inactive text color',
          Icons.text_fields,
        ),
        _buildSystemColorCard(
          'UnsupportedColor',
          null,
          'Example of an unsupported system color',
          Icons.block,
        ),

        const SizedBox(height: 20),

        // W3C Colors
        _buildSectionTitle('W3C Standard Colors', Icons.public),
        _buildW3CColorsVisual(),
        const SizedBox(height: 20),

        // Theme integration
        _buildSectionTitle('Theme Integration', Icons.style),
        _buildThemeIntegrationDemo(),
        const SizedBox(height: 20),

        // Color categories
        _buildColorCategoryCard('UI Element Colors', [
          {'name': 'Canvas', 'color': const Color(0xFFFFFFFF)},
          {'name': 'CanvasText', 'color': const Color(0xFF000000)},
          {'name': 'ButtonFace', 'color': const Color(0xFFE0E0E0)},
          {'name': 'ButtonText', 'color': const Color(0xFF1A1A1A)},
          {'name': 'Field', 'color': const Color(0xFFFAFAFA)},
          {'name': 'FieldText', 'color': const Color(0xFF212121)},
        ], Icons.widgets),

        _buildColorCategoryCard('Interactive Colors', [
          {'name': 'LinkText', 'color': const Color(0xFF0000EE)},
          {'name': 'VisitedText', 'color': const Color(0xFF551A8B)},
          {'name': 'ActiveText', 'color': const Color(0xFFFF0000)},
          {'name': 'Highlight', 'color': const Color(0xFF3390FF)},
          {'name': 'AccentColor', 'color': const Color(0xFF0078D4)},
        ], Icons.touch_app),

        const SizedBox(height: 20),

        // Fallback pattern
        _buildSectionTitle('Usage Patterns', Icons.lightbulb),
        _buildFallbackPatternDemo(),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• SystemColor provides platform OS colors\n'
                '• Uses W3C CSS system color names\n'
                '• isSupported indicates availability\n'
                '• value is null when unsupported\n'
                '• Currently web-only support\n'
                '• Use fallback patterns for cross-platform',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
