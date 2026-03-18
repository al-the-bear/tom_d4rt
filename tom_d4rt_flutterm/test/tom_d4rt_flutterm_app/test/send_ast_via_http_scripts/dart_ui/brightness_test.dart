// D4rt test script: Tests Brightness from dart_ui
// Brightness enum defines light and dark color schemes
// Fundamental to theming in Flutter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Brightness Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Brightness Values
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Brightness.light
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Brightness.dark
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Brightness in ThemeData
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: MaterialApp Theme Mode
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Brightness Detection
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Brightness in ColorScheme
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Status Bar and System UI
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Cupertino Brightness
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Conditional Styling
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Brightness Transitions
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Dark Mode Best Practices
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Testing Brightness Scenarios
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // Return visual UI demonstrating both brightness modes
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.grey.shade200, Colors.grey.shade400],
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
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'index: ${brightness.index}',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
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
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Sample button
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
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
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
  final MaterialColor color;

  const _UsageCard({
    required this.icon,
    required this.title,
    required this.code,
    required this.color, // MaterialColor for shade access
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
