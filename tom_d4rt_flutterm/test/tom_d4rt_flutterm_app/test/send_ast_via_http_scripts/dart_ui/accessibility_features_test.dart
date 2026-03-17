// D4rt test script: Deep Demo for AccessibilityFeatures from dart:ui
// AccessibilityFeatures provides info about platform accessibility settings
// Used to adapt UI for users with accessibility needs
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║            ACCESSIBILITY FEATURES DEEP DEMO                       ║');
  print('║       Platform Accessibility Settings for Adaptive UI             ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ACCESSIBILITY FEATURES FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ACCESSIBILITY FEATURES FUNDAMENTALS                    │');
  print('│ Understanding platform accessibility settings                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('AccessibilityFeatures provides:');
  print('  • Platform accessibility settings');
  print('  • User preference flags');
  print('  • Adaptive UI information');
  print('  • System-level configurations');
  print('');

  print('Accessibility categories:');
  print('  • Visual (contrast, colors)');
  print('  • Motion (animations)');
  print('  • Navigation (screen readers)');
  print('  • Interaction (switches, focus)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PLATFORM DISPATCHER ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: PLATFORM DISPATCHER ACCESS                             │');
  print('│ Getting features via PlatformDispatcher                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final dispatcher = ui.PlatformDispatcher.instance;
  final features = dispatcher.accessibilityFeatures;
  
  print('Access pattern:');
  print('  final dispatcher = PlatformDispatcher.instance;');
  print('  final features = dispatcher.accessibilityFeatures;');
  print('');
  print('Object info:');
  print('  • runtimeType: ${features.runtimeType}');
  print('  • hashCode: ${features.hashCode}');
  print('  • toString: ${features.toString()}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ALL FEATURE FLAGS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: ALL FEATURE FLAGS                                      │');
  print('│ Complete list of accessibility features                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final featureData = <Map<String, dynamic>>[
    {'name': 'accessibleNavigation', 'value': features.accessibleNavigation, 'description': 'Screen reader active'},
    {'name': 'invertColors', 'value': features.invertColors, 'description': 'Color inversion enabled'},
    {'name': 'disableAnimations', 'value': features.disableAnimations, 'description': 'Animations disabled'},
    {'name': 'boldText', 'value': features.boldText, 'description': 'Bold text requested'},
    {'name': 'reduceMotion', 'value': features.reduceMotion, 'description': 'Reduced motion preference'},
    {'name': 'highContrast', 'value': features.highContrast, 'description': 'High contrast mode'},
    {'name': 'onOffSwitchLabels', 'value': features.onOffSwitchLabels, 'description': 'Show on/off labels'},
  ];
  
  print('Feature flags from platform:');
  print('┌─────────────────────────┬─────────┬───────────────────────────────────┐');
  print('│       Feature           │  Value  │   Description                     │');
  print('├─────────────────────────┼─────────┼───────────────────────────────────┤');
  for (final data in featureData) {
    final name = (data['name'] as String).padRight(23);
    final value = (data['value'] as bool ? 'Yes' : 'No').padRight(7);
    final desc = (data['description'] as String).padRight(33);
    print('│ $name │ $value │ $desc │');
  }
  print('└─────────────────────────┴─────────┴───────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: MEDIAQUERY ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: MEDIAQUERY ACCESS                                      │');
  print('│ Accessing features through MediaQuery                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final mq = MediaQuery.of(context);
  
  print('MediaQuery accessibility properties:');
  print('  • accessibleNavigation: ${mq.accessibleNavigation}');
  print('  • boldText: ${mq.boldText}');
  print('  • disableAnimations: ${mq.disableAnimations}');
  print('  • invertColors: ${mq.invertColors}');
  print('  • highContrast: ${mq.highContrast}');
  print('');

  print('Recommended access pattern:');
  print('  // In a widget build method:');
  print('  final mq = MediaQuery.of(context);');
  print('  if (mq.disableAnimations) {');
  print('    // Skip animations');
  print('  }');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VISUAL ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: VISUAL ACCESSIBILITY                                   │');
  print('│ Color and contrast settings                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Visual features:');
  print('');
  print('  invertColors: ${features.invertColors}');
  print('    → Inverts all colors on screen');
  print('    → Use: Adjust images that shouldn\'t be inverted');
  print('');
  print('  highContrast: ${features.highContrast}');
  print('    → High contrast mode enabled');
  print('    → Use: Increase text/background contrast');
  print('');
  print('  boldText: ${features.boldText}');
  print('    → User prefers bold text');
  print('    → Use: Increase font weights');
  print('');

  print('Adaptive example:');
  print('  final fontWeight = features.boldText');
  print('    ? FontWeight.bold');
  print('    : FontWeight.normal;');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: MOTION ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: MOTION ACCESSIBILITY                                   │');
  print('│ Animation and motion preferences                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Motion features:');
  print('');
  print('  disableAnimations: ${features.disableAnimations}');
  print('    → Animations completely disabled');
  print('    → Use: Skip all animations');
  print('');
  print('  reduceMotion: ${features.reduceMotion}');
  print('    → Reduce animation intensity');
  print('    → Use: Simpler/shorter animations');
  print('');

  print('Motion-aware animation:');
  print('  final duration = features.reduceMotion');
  print('    ? Duration.zero');
  print('    : Duration(milliseconds: 300);');
  print('');
  print('  AnimatedContainer(');
  print('    duration: duration,');
  print('    // ...');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: NAVIGATION ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: NAVIGATION ACCESSIBILITY                               │');
  print('│ Screen reader and navigation settings                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Navigation features:');
  print('');
  print('  accessibleNavigation: ${features.accessibleNavigation}');
  print('    → Screen reader is active');
  print('    → VoiceOver (iOS), TalkBack (Android)');
  print('');

  print('Screen reader adaptations:');
  print('  • Add semantic labels');
  print('  • Ensure focus order is logical');
  print('  • Avoid time-limited interactions');
  print('  • Provide text alternatives for images');
  print('');

  print('Example:');
  print('  Semantics(');
  print('    label: "Profile picture of John",');
  print('    child: Image.asset("profile.png"),');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: INTERACTION ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: INTERACTION ACCESSIBILITY                              │');
  print('│ Switch and label preferences                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Interaction features:');
  print('');
  print('  onOffSwitchLabels: ${features.onOffSwitchLabels}');
  print('    → Show text labels on switches');
  print('    → Display "ON"/"OFF" text');
  print('');

  print('Adaptive switch example:');
  print('  if (features.onOffSwitchLabels) {');
  print('    return SwitchListTile(');
  print('      title: Text("Notifications"),');
  print('      subtitle: Text(isOn ? "ON" : "OFF"),');
  print('      value: isOn,');
  print('      onChanged: ...,');
  print('    );');
  print('  }');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: LISTENING FOR CHANGES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: LISTENING FOR CHANGES                                  │');
  print('│ Reacting to accessibility changes                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Platform change listener:');
  print('  PlatformDispatcher.instance.onAccessibilityFeaturesChanged = () {');
  print('    final newFeatures = PlatformDispatcher.instance');
  print('        .accessibilityFeatures;');
  print('    // Rebuild UI with new settings');
  print('  };');
  print('');

  print('In widget tree (recommended):');
  print('  MediaQuery automatically propagates changes');
  print('  Widgets rebuild when settings change');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: PRACTICAL USE CASES                                   │');
  print('│ Implementing accessible UIs                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. Auto-hiding Elements');
  print('   Don\'t auto-hide if accessibleNavigation is true');
  print('');

  print('2. Parallax Effects');
  print('   Disable parallax if reduceMotion is true');
  print('');

  print('3. Animated Backgrounds');
  print('   Static background if disableAnimations is true');
  print('');

  print('4. Color Schemes');
  print('   Higher contrast palette if highContrast is true');
  print('');

  print('5. Text Sizes');
  print('   Larger/bolder text if boldText is true');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║           ACCESSIBILITY FEATURES SUMMARY                          ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('AccessibilityFeatures key features:');
  print('  • 7 boolean feature flags');
  print('  • Platform-provided settings');
  print('  • MediaQuery integration');
  print('  • Change notification support');
  print('');
  print('Best practices:');
  print('  • Use MediaQuery.of(context) in widgets');
  print('  • Respect reduceMotion for animations');
  print('  • Support high contrast when requested');
  print('  • Add semantic labels for screen readers');
  print('');
  print('AccessibilityFeatures Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return MaterialApp(
    debugShowCheckedModeBanner: false,
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
                    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.accessibility_new, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'AccessibilityFeatures',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Platform Accessibility Settings',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Features List
              _buildSectionHeader('FEATURE FLAGS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ...featureData.map((data) => _buildFeatureRow(
                      data['name'] as String,
                      data['value'] as bool,
                      data['description'] as String,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Category Overview
              _buildSectionHeader('FEATURE CATEGORIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(child: _buildCategoryCard('Visual', Icons.visibility, Color(0xFF7C4DFF), 3)),
                    SizedBox(width: 12),
                    Expanded(child: _buildCategoryCard('Motion', Icons.animation, Color(0xFFFF5722), 2)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(child: _buildCategoryCard('Navigation', Icons.navigation, Color(0xFF4CAF50), 1)),
                    SizedBox(width: 12),
                    Expanded(child: _buildCategoryCard('Interaction', Icons.touch_app, Color(0xFF00BCD4), 1)),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Current Settings
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
                      'CURRENT PLATFORM SETTINGS',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: featureData
                          .where((d) => d['value'] as bool)
                          .map((d) => _buildActiveChip(d['name'] as String))
                          .toList(),
                    ),
                    if (featureData.every((d) => !(d['value'] as bool)))
                      Text(
                        'No accessibility features enabled',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
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
                        _buildSummaryStat('Features', '7'),
                        _buildSummaryStat('Active', '${featureData.where((d) => d['value'] as bool).length}'),
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
                    'Deep Demo • AccessibilityFeatures • dart:ui',
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
        color: Color(0xFF1565C0),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildFeatureRow(String name, bool value, String description) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 0.5)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: value ? Color(0xFF4CAF50) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            value ? Icons.check : Icons.close,
            size: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(description, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryCard(String title, IconData icon, Color color, int count) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Text('$count features', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _buildActiveChip(String name) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Color(0xFF4CAF50),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      name,
      style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),
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
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
