// D4rt test script: Deep Demo for DartPluginRegistrant from dart:ui
// DartPluginRegistrant provides plugin registration hooks for Dart-only environments
// It ensures dartPluginRegistrantImplementation is available
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DartPluginRegistrant Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TYPE REFERENCE
  // ═══════════════════════════════════════════════════════════════════════════
  // DartPluginRegistrant is a utility class for registering plugins in Dart-only
  // environments where `dart:io` or `dart:html` are unavailable.

  print('DartPluginRegistrant type: ${ui.DartPluginRegistrant}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ensureInitialized
  // ═══════════════════════════════════════════════════════════════════════════
  // The main static method ensures the default plugin registration is done
  ui.DartPluginRegistrant.ensureInitialized();
  print('DartPluginRegistrant.ensureInitialized() called successfully');

  // Multiple calls are safe (idempotent)
  ui.DartPluginRegistrant.ensureInitialized();
  ui.DartPluginRegistrant.ensureInitialized();
  print('Multiple ensureInitialized() calls are safe (idempotent)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: PLUGIN ARCHITECTURE CONTEXT
  // ═══════════════════════════════════════════════════════════════════════════
  // In Flutter, plugins register themselves via generated code.
  // DartPluginRegistrant provides the hook for this in Dart-only contexts.

  print('Plugin registration architecture:');
  print('  1. Build tool generates registration code');
  print('  2. Registration code calls platform-specific setup');
  print('  3. DartPluginRegistrant bridges the gap for Dart environments');
  print('  4. ensureInitialized() triggers the registration');

  print('DartPluginRegistrant demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A148C), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 12, offset: Offset(0, 6)),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.extension, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text('DartPluginRegistrant',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    SizedBox(height: 6),
                    Text('Plugin registration for Dart-only environments',
                      style: TextStyle(fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85))),
                  ],
                ),
              ),

              // ── Section 1: Overview ──
              _sectionTitle('1. CLASS OVERVIEW'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _overviewChip('Package', 'dart:ui', Color(0xFF4A148C)),
                    SizedBox(height: 8),
                    _overviewChip('Type', 'Utility class (abstract)', Color(0xFF1565C0)),
                    SizedBox(height: 8),
                    _overviewChip('Constructor', 'None (static only)', Color(0xFFC62828)),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'DartPluginRegistrant is a utility class with only static '
                        'members. It manages plugin initialization for Dart-only '
                        'contexts where the platform channel mechanism is unavailable.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF4A148C)),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Static API ──
              _sectionTitle('2. STATIC API'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiMethodCard(
                      'ensureInitialized()',
                      'static void',
                      'Triggers plugin registration. Safe to call multiple times.',
                      Icons.play_arrow,
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Idempotent: calling multiple times has no side effects',
                              style: TextStyle(fontSize: 12, color: Color(0xFF1B5E20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 3: Registration Pipeline ──
              _sectionTitle('3. REGISTRATION PIPELINE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipelineStep(1, 'Build Tool',
                      'Scans pubspec for plugin dependencies',
                      Icons.build, Color(0xFF4A148C)),
                    _arrow(),
                    _pipelineStep(2, 'Code Generation',
                      'Generates dart_plugin_registrant.dart',
                      Icons.code, Color(0xFF1565C0)),
                    _arrow(),
                    _pipelineStep(3, 'Registration Function',
                      'Defines registerPlugins() with all plugins',
                      Icons.extension, Color(0xFF00695C)),
                    _arrow(),
                    _pipelineStep(4, 'ensureInitialized()',
                      'Calls registerPlugins() exactly once',
                      Icons.play_arrow, Color(0xFF2E7D32)),
                    _arrow(),
                    _pipelineStep(5, 'Plugins Active',
                      'All Dart-side plugins registered and ready',
                      Icons.check_circle, Color(0xFFE65100)),
                  ],
                ),
              ),

              // ── Section 4: Dart vs Flutter Registration ──
              _sectionTitle('4. DART vs FLUTTER REGISTRATION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _comparisonRow('Flutter App',
                      'Plugins auto-registered via GeneratedPluginRegistrant',
                      Icons.phone_android, Color(0xFF1565C0)),
                    Divider(height: 20),
                    _comparisonRow('Dart-only',
                      'Uses DartPluginRegistrant.ensureInitialized()',
                      Icons.terminal, Color(0xFF4A148C)),
                    Divider(height: 20),
                    _comparisonRow('Tests',
                      'May need explicit registration depending on env',
                      Icons.science, Color(0xFF00695C)),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF6A1B9A), size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Both paths converge: plugins end up registered '
                              'on their respective method channels.',
                              style: TextStyle(fontSize: 11, color: Color(0xFF6A1B9A)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Common Plugins ──
              _sectionTitle('5. COMMON PLUGINS REGISTERED'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pluginRow('url_launcher', 'Platform URL handling', Icons.link, Color(0xFF1565C0)),
                    _pluginRow('path_provider', 'File system paths', Icons.folder, Color(0xFF2E7D32)),
                    _pluginRow('shared_preferences', 'Key-value storage', Icons.storage, Color(0xFFE65100)),
                    _pluginRow('camera', 'Camera access', Icons.camera_alt, Color(0xFF6A1B9A)),
                    _pluginRow('connectivity', 'Network status', Icons.wifi, Color(0xFF00695C)),
                    _pluginRow('firebase_core', 'Firebase initialization', Icons.whatshot, Color(0xFFC62828)),
                  ],
                ),
              ),

              // ── Section 6: Lifecycle ──
              _sectionTitle('6. INITIALIZATION LIFECYCLE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 18, top: 0, bottom: 0,
                      child: Container(width: 2, color: Color(0xFFE0E0E0))),
                    Column(
                      children: [
                        _lifecycleEvent('App starts', 'main() begins execution',
                          Color(0xFF6A1B9A), true),
                        SizedBox(height: 16),
                        _lifecycleEvent('Binding init', 'WidgetsFlutterBinding.ensureInitialized()',
                          Color(0xFF1565C0), false),
                        SizedBox(height: 16),
                        _lifecycleEvent('Plugin reg', 'DartPluginRegistrant.ensureInitialized()',
                          Color(0xFF2E7D32), false),
                        SizedBox(height: 16),
                        _lifecycleEvent('App ready', 'runApp(MyApp()) executes',
                          Color(0xFFE65100), false),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 7: Key Properties ──
              _sectionTitle('7. KEY PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propertyBullet('Static-only', 'No instance can be created'),
                    _propertyBullet('Idempotent', 'Safe to call ensureInitialized() multiple times'),
                    _propertyBullet('Build-tool generated', 'Registration code is generated automatically'),
                    _propertyBullet('Dart-only focus', 'For contexts without platform channels'),
                    _propertyBullet('Transparent', 'User typically does not interact directly'),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(title, style: TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700,
      color: Color(0xFF455A64), letterSpacing: 1.0,
    )),
  );
}

Widget _overviewChip(String label, String value, Color color) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: TextStyle(fontSize: 11,
          fontWeight: FontWeight.bold, color: color)),
      ),
      SizedBox(width: 10),
      Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    ],
  );
}

Widget _apiMethodCard(String method, String returnType, String desc,
    IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(method, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13,
                fontFamily: 'monospace')),
              Text(returnType, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              SizedBox(height: 2),
              Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineStep(int step, String label, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 30, height: 30,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text('$step', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
      Icon(icon, color: color, size: 20),
    ],
  );
}

Widget _arrow() {
  return Padding(
    padding: EdgeInsets.only(left: 12),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 16),
  );
}

Widget _comparisonRow(String title, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _pluginRow(String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,
                fontFamily: 'monospace')),
              Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleEvent(String title, String desc, Color color, bool first) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 38,
        alignment: Alignment.center,
        child: Container(
          width: 12, height: 12,
          decoration: BoxDecoration(
            color: color, shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4)],
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _propertyBullet(String title, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          width: 6, height: 6,
          decoration: BoxDecoration(color: Color(0xFF6A1B9A), shape: BoxShape.circle),
        ),
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$title: ', style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
                TextSpan(text: desc, style: TextStyle(
                  fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
