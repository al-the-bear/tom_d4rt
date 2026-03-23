// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for AccessibilityFeatures from dart:ui
// AccessibilityFeatures provides info about platform accessibility settings
// Used to adapt UI for users with accessibility needs
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ACCESSIBILITY FEATURES FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════



  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PLATFORM DISPATCHER ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  final dispatcher = ui.PlatformDispatcher.instance;
  final features = dispatcher.accessibilityFeatures;


  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ALL FEATURE FLAGS
  // ═══════════════════════════════════════════════════════════════════════════

  final featureData = <Map<String, dynamic>>[
    {
      'name': 'accessibleNavigation',
      'value': features.accessibleNavigation,
      'description': 'Screen reader active',
    },
    {
      'name': 'invertColors',
      'value': features.invertColors,
      'description': 'Color inversion enabled',
    },
    {
      'name': 'disableAnimations',
      'value': features.disableAnimations,
      'description': 'Animations disabled',
    },
    {
      'name': 'boldText',
      'value': features.boldText,
      'description': 'Bold text requested',
    },
    {
      'name': 'reduceMotion',
      'value': features.reduceMotion,
      'description': 'Reduced motion preference',
    },
    {
      'name': 'highContrast',
      'value': features.highContrast,
      'description': 'High contrast mode',
    },
    {
      'name': 'onOffSwitchLabels',
      'value': features.onOffSwitchLabels,
      'description': 'Show on/off labels',
    },
  ];


  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: NAVIGATION ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════




  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: INTERACTION ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════



  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: LISTENING FOR CHANGES
  // ═══════════════════════════════════════════════════════════════════════════



  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════






  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════

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
                    Icon(
                      Icons.accessibility_new,
                      size: 48,
                      color: Colors.white,
                    ),
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
                        color: Colors.white.withValues(alpha: 0.8),
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
                    ...featureData.map(
                      (data) => _buildFeatureRow(
                        data['name'] as String,
                        data['value'] as bool,
                        data['description'] as String,
                      ),
                    ),
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
                    Expanded(
                      child: _buildCategoryCard(
                        'Visual',
                        Icons.visibility,
                        Color(0xFF7C4DFF),
                        3,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildCategoryCard(
                        'Motion',
                        Icons.animation,
                        Color(0xFFFF5722),
                        2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                        'Navigation',
                        Icons.navigation,
                        Color(0xFF4CAF50),
                        1,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildCategoryCard(
                        'Interaction',
                        Icons.touch_app,
                        Color(0xFF00BCD4),
                        1,
                      ),
                    ),
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
                        _buildSummaryStat(
                          'Active',
                          '${featureData.where((d) => d['value'] as bool).length}',
                        ),
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
              Text(
                name,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
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
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Text(
          '$count features',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
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
      style: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
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
