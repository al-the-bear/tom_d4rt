// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for SystemColorPalette from dart:ui
//
// SystemColorPalette provides W3C CSS system colors from the OS.
// These colors adapt to light/dark mode automatically.
//
// Access patterns:
//   - SystemColor.light: Light mode palette
//   - SystemColor.dark: Dark mode palette
//   - SystemColor.platformProvidesSystemColors: True if OS provides colors
//
// W3C CSS System Colors (available on palette):
//   - canvas/canvasText: Background and foreground
//   - buttonFace/buttonText: Button colors
//   - field/fieldText: Input field colors
//   - highlight/highlightText: Selection colors
//   - linkText/visitedText: Link colors
//   - accentColor/accentColorText: Accent colors
//   - mark/markText: Highlight marker colors
//   - grayText: Disabled text color
//
// SystemColorPalette is a read-only snapshot of system colors
// at the time Flutter initializes or when the system changes.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// Convert ui.SystemColor to Color (using .value which is Color?)
Color _sysColor(ui.SystemColor c) => c.value ?? Colors.transparent;

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF37474F), const Color(0xFF78909C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF37474F).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.palette, size: 48, color: Colors.white),
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
            color: const Color(0xFF78909C).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF37474F), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformStatusCard(bool provides) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: provides ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: provides ? const Color(0xFF4CAF50) : const Color(0xFFFFB74D),
        width: 2,
      ),
    ),
    child: Row(
      children: [
        Icon(
          provides ? Icons.check_circle : Icons.info,
          color: provides ? const Color(0xFF4CAF50) : const Color(0xFFE65100),
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provides
                    ? 'Platform provides system colors'
                    : 'Using fallback colors',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provides
                    ? 'Colors from operating system'
                    : 'Default palette is being used',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPalettePreview(ui.SystemColorPalette palette, String mode) {
  final isLight = mode == 'Light';

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isLight ? Colors.white : const Color(0xFF1E1E1E),
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
            Icon(
              isLight ? Icons.light_mode : Icons.dark_mode,
              color: isLight ? Colors.orange : Colors.indigo,
            ),
            const SizedBox(width: 8),
            Text(
              '$mode Palette',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isLight ? const Color(0xFF37474F) : Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Canvas pair
        _buildColorPair(
          'canvas',
          _sysColor(palette.canvas),
          'canvasText',
          _sysColor(palette.canvasText),
        ),
        const SizedBox(height: 8),
        // Button pair
        _buildColorPair(
          'buttonFace',
          _sysColor(palette.buttonFace),
          'buttonText',
          _sysColor(palette.buttonText),
        ),
        const SizedBox(height: 8),
        // Field pair
        _buildColorPair(
          'field',
          _sysColor(palette.field),
          'fieldText',
          _sysColor(palette.fieldText),
        ),
        const SizedBox(height: 8),
        // Highlight pair
        _buildColorPair(
          'highlight',
          _sysColor(palette.highlight),
          'highlightText',
          _sysColor(palette.highlightText),
        ),
        const SizedBox(height: 8),
        // Accent pair
        _buildColorPair(
          'accentColor',
          _sysColor(palette.accentColor),
          'accentText',
          _sysColor(palette.accentColorText),
        ),
      ],
    ),
  );
}

Widget _buildColorPair(String bgName, Color bg, String fgName, Color fg) {
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bgName,
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: fg,
                ),
              ),
              Text(
                'Sample Text',
                style: TextStyle(
                  fontSize: 12,
                  color: fg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 6),
      Column(
        children: [
          _buildColorChip(bg),
          const SizedBox(height: 2),
          _buildColorChip(fg),
        ],
      ),
    ],
  );
}

Widget _buildColorChip(Color color) {
  return Container(
    width: 24,
    height: 14,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: Colors.grey.withAlpha(100)),
    ),
  );
}

Widget _buildW3CSystemColorsCard(ui.SystemColorPalette palette) {
  final colors = [
    {
      'name': 'canvas',
      'color': _sysColor(palette.canvas),
      'desc': 'App background',
    },
    {
      'name': 'canvasText',
      'color': _sysColor(palette.canvasText),
      'desc': 'Default text',
    },
    {
      'name': 'buttonFace',
      'color': _sysColor(palette.buttonFace),
      'desc': 'Button background',
    },
    {
      'name': 'buttonText',
      'color': _sysColor(palette.buttonText),
      'desc': 'Button text',
    },
    {
      'name': 'field',
      'color': _sysColor(palette.field),
      'desc': 'Input background',
    },
    {
      'name': 'fieldText',
      'color': _sysColor(palette.fieldText),
      'desc': 'Input text',
    },
    {
      'name': 'highlight',
      'color': _sysColor(palette.highlight),
      'desc': 'Selection bg',
    },
    {
      'name': 'highlightText',
      'color': _sysColor(palette.highlightText),
      'desc': 'Selection text',
    },
    {
      'name': 'linkText',
      'color': _sysColor(palette.linkText),
      'desc': 'Link text',
    },
    {
      'name': 'visitedText',
      'color': _sysColor(palette.visitedText),
      'desc': 'Visited link',
    },
    {
      'name': 'grayText',
      'color': _sysColor(palette.grayText),
      'desc': 'Disabled text',
    },
    {
      'name': 'accentColor',
      'color': _sysColor(palette.accentColor),
      'desc': 'Accent color',
    },
    {
      'name': 'accentColorText',
      'color': _sysColor(palette.accentColorText),
      'desc': 'Accent text',
    },
    {
      'name': 'mark',
      'color': _sysColor(palette.mark),
      'desc': 'Highlight mark',
    },
    {
      'name': 'markText',
      'color': _sysColor(palette.markText),
      'desc': 'Mark text',
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
            Icon(Icons.format_color_fill, color: const Color(0xFF37474F)),
            const SizedBox(width: 8),
            const Text(
              'W3C System Colors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: colors.map((c) {
            final color = c['color'] as Color;
            final name = c['name'] as String;
            return Tooltip(
              message: name,
              child: Container(
                width: 65,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.withAlpha(80)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      name.length > 10 ? '${name.substring(0, 8)}...' : name,
                      style: const TextStyle(
                        fontSize: 7,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard(
  ui.SystemColorPalette light,
  ui.SystemColorPalette dark,
) {
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
            Icon(Icons.compare, color: const Color(0xFF37474F)),
            const SizedBox(width: 8),
            const Text(
              'Light vs Dark',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildComparisonRow(
          'canvas',
          _sysColor(light.canvas),
          _sysColor(dark.canvas),
        ),
        _buildComparisonRow(
          'canvasText',
          _sysColor(light.canvasText),
          _sysColor(dark.canvasText),
        ),
        _buildComparisonRow(
          'buttonFace',
          _sysColor(light.buttonFace),
          _sysColor(dark.buttonFace),
        ),
        _buildComparisonRow(
          'highlight',
          _sysColor(light.highlight),
          _sysColor(dark.highlight),
        ),
        _buildComparisonRow(
          'accentColor',
          _sysColor(light.accentColor),
          _sysColor(dark.accentColor),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(String name, Color light, Color dark) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
          ),
        ),
        Container(
          width: 40,
          height: 22,
          decoration: BoxDecoration(
            color: light,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(color: Colors.grey.withAlpha(80)),
          ),
          child: const Center(
            child: Icon(Icons.light_mode, size: 12, color: Colors.grey),
          ),
        ),
        Container(
          width: 40,
          height: 22,
          decoration: BoxDecoration(
            color: dark,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            border: Border.all(color: Colors.grey.withAlpha(80)),
          ),
          child: const Center(
            child: Icon(Icons.dark_mode, size: 12, color: Colors.grey),
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}

Widget _buildIntegrationCard() {
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
            Icon(Icons.code, color: const Color(0xFF37474F)),
            const SizedBox(width: 8),
            const Text(
              'Usage Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// Check if platform provides colors\n'
          'if (ui.SystemColor.platformProvidesSystemColors) {\n'
          '  // Use system palette\n'
          '  final palette = ui.SystemColor.light;\n'
          '  final bg = palette.canvas;\n'
          '  final text = palette.canvasText;\n'
          '  final accent = palette.accentColor;\n'
          '}\n'
          '\n'
          '// For dark mode\n'
          'final darkPalette = ui.SystemColor.dark;\n'
          'final darkBg = darkPalette.canvas;',
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFFD4D4D4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildUseCasesCard() {
  final cases = [
    {'icon': Icons.apps, 'label': 'Adaptive UI', 'desc': 'Match OS theme'},
    {
      'icon': Icons.accessibility,
      'label': 'Accessibility',
      'desc': 'High contrast colors',
    },
    {
      'icon': Icons.settings,
      'label': 'User Preferences',
      'desc': 'Respect system settings',
    },
    {
      'icon': Icons.desktop_windows,
      'label': 'Native Feel',
      'desc': 'Platform integration',
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
            Icon(Icons.lightbulb, color: const Color(0xFF37474F)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEFF1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFF37474F),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['label'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        c['desc'] as String,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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

Widget _buildResultsCard(
  ui.SystemColorPalette light,
  ui.SystemColorPalette dark,
  bool provides,
) {
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
            Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            const Text(
              'Test Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow('platformProvidesSystemColors', '$provides', true),
        _buildResultRow('Light palette type', '${light.runtimeType}', true),
        _buildResultRow('Dark palette type', '${dark.runtimeType}', true),
        _buildResultRow(
          'light.canvasText',
          _sysColorToHex(light.canvasText),
          true,
        ),
        _buildResultRow(
          'dark.canvasText',
          _sysColorToHex(dark.canvasText),
          true,
        ),
        _buildResultRow(
          'light.accentColor',
          _sysColorToHex(light.accentColor),
          true,
        ),
      ],
    ),
  );
}

String _sysColorToHex(ui.SystemColor c) {
  if (c.value == null) return 'N/A';
  return '#${c.value!.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 11))),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== SystemColorPalette Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SystemColorPalette Overview ---');
  print('W3C CSS system colors from the operating system');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PLATFORM STATUS
  // ═══════════════════════════════════════════════════════════════════════════

  final provides = ui.SystemColor.platformProvidesSystemColors;
  print('platformProvidesSystemColors: $provides');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LIGHT PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Light Palette ---');
  final light = ui.SystemColor.light;
  print('Light palette: ${light.runtimeType}');
  print('canvas: ${light.canvas}');
  print('canvasText: ${light.canvasText}');
  print('buttonFace: ${light.buttonFace}');
  print('buttonText: ${light.buttonText}');
  print('highlight: ${light.highlight}');
  print('accentColor: ${light.accentColor}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: DARK PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Dark Palette ---');
  final dark = ui.SystemColor.dark;
  print('Dark palette: ${dark.runtimeType}');
  print('canvas: ${dark.canvas}');
  print('canvasText: ${dark.canvasText}');
  print('buttonFace: ${dark.buttonFace}');
  print('buttonText: ${dark.buttonText}');
  print('highlight: ${dark.highlight}');
  print('accentColor: ${dark.accentColor}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ALL COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- All Light Palette Colors ---');
  print('field: ${light.field}');
  print('fieldText: ${light.fieldText}');
  print('highlightText: ${light.highlightText}');
  print('linkText: ${light.linkText}');
  print('visitedText: ${light.visitedText}');
  print('grayText: ${light.grayText}');
  print('accentColorText: ${light.accentColorText}');
  print('mark: ${light.mark}');
  print('markText: ${light.markText}');

  print('\n=== SystemColorPalette Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('SystemColorPalette', 'W3C CSS System Colors'),
        const SizedBox(height: 20),

        // Platform status
        _buildSectionTitle('Platform Status', Icons.info),
        _buildPlatformStatusCard(provides),
        const SizedBox(height: 20),

        // Light palette
        _buildSectionTitle('Light Mode', Icons.light_mode),
        _buildPalettePreview(light, 'Light'),
        const SizedBox(height: 20),

        // Dark palette
        _buildSectionTitle('Dark Mode', Icons.dark_mode),
        _buildPalettePreview(dark, 'Dark'),
        const SizedBox(height: 20),

        // All W3C colors
        _buildSectionTitle('All Colors', Icons.format_color_fill),
        _buildW3CSystemColorsCard(light),
        const SizedBox(height: 20),

        // Comparison
        _buildSectionTitle('Comparison', Icons.compare),
        _buildComparisonCard(light, dark),
        const SizedBox(height: 20),

        // Integration
        _buildSectionTitle('Code Example', Icons.code),
        _buildIntegrationCard(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.lightbulb),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(light, dark, provides),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• SystemColorPalette provides OS system colors\n'
                '• SystemColor.light and .dark access palettes\n'
                '• W3C CSS color names (canvas, buttonFace, etc.)\n'
                '• Adapts to light/dark mode automatically\n'
                '• Check platformProvidesSystemColors first\n'
                '• Use for native look and accessibility',
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
