// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for advanced dart:ui APIs
// Covers: AccessibilityFeatures, ChannelBuffers, PlatformConfiguration
// These are lower-level dart:ui classes used by the Flutter framework internals
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== dart:ui Advanced APIs Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: AccessibilityFeatures
  // ═══════════════════════════════════════════════════════════════════════════

  // AccessibilityFeatures comes from the platform
  final binding = WidgetsFlutterBinding.ensureInitialized();
  final view = binding.platformDispatcher.views.first;
  print('View: $view');
  // Use PlatformDispatcher to get features
  final features = binding.platformDispatcher.accessibilityFeatures;
  print('AccessibilityFeatures: $features');
  print('  accessibleNavigation: ${features.accessibleNavigation}');
  print('  boldText: ${features.boldText}');
  print('  disableAnimations: ${features.disableAnimations}');
  print('  highContrast: ${features.highContrast}');
  print('  invertColors: ${features.invertColors}');
  print('  onOffSwitchLabels: ${features.onOffSwitchLabels}');
  print('  reduceMotion: ${features.reduceMotion}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ChannelBuffers
  // ═══════════════════════════════════════════════════════════════════════════

  final channelBuffers = ui.channelBuffers;
  print('ChannelBuffers: ${channelBuffers.runtimeType}');
  // ChannelBuffers manages message buffering for platform channels
  // It's a singleton accessed via ui.channelBuffers

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: PlatformDispatcher
  // ═══════════════════════════════════════════════════════════════════════════

  final dispatcher = ui.PlatformDispatcher.instance;
  print('PlatformDispatcher: ${dispatcher.runtimeType}');
  print('  locale: ${dispatcher.locale}');
  print('  locales count: ${dispatcher.locales.length}');
  print('  textScaleFactor: ${dispatcher.textScaleFactor}');
  print('  semanticsEnabled: ${dispatcher.semanticsEnabled}');
  print('  defaultRouteName: ${dispatcher.defaultRouteName}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CALLBACK SETTERS
  // ═══════════════════════════════════════════════════════════════════════════

  // These are setter-only — used by framework, not typical app code
  print('Callback registration points:');
  print('  onMetricsChanged, onLocaleChanged');
  print('  onTextScaleFactorChanged, onPlatformBrightnessChanged');
  print('  onBeginFrame, onDrawFrame');
  print('  onPointerDataPacket, onSemanticsEnabledChanged');
  print('  onSemanticsActionEvent, onFrameDataChanged');

  print('dart:ui Advanced Demo complete');

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
                    colors: [Color(0xFF263238), Color(0xFF546E7A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.settings_applications,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'dart:ui Advanced APIs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'AccessibilityFeatures, ChannelBuffers, PlatformDispatcher',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: AccessibilityFeatures ──
              _sectionTitle('1. ACCESSIBILITY FEATURES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _featureRow(
                      'accessibleNavigation',
                      features.accessibleNavigation,
                      'Navigation aids enabled',
                      Icons.navigation,
                    ),
                    _featureRow(
                      'boldText',
                      features.boldText,
                      'System bold text preference',
                      Icons.format_bold,
                    ),
                    _featureRow(
                      'disableAnimations',
                      features.disableAnimations,
                      'Animations should be minimized',
                      Icons.animation,
                    ),
                    _featureRow(
                      'highContrast',
                      features.highContrast,
                      'High contrast mode active',
                      Icons.contrast,
                    ),
                    _featureRow(
                      'invertColors',
                      features.invertColors,
                      'Color inversion enabled',
                      Icons.invert_colors,
                    ),
                    _featureRow(
                      'onOffSwitchLabels',
                      features.onOffSwitchLabels,
                      'Switch labels should show ON/OFF',
                      Icons.toggle_on,
                    ),
                    _featureRow(
                      'reduceMotion',
                      features.reduceMotion,
                      'Reduce motion preference',
                      Icons.slow_motion_video,
                    ),
                  ],
                ),
              ),

              // ── Section 2: ChannelBuffers ──
              _sectionTitle('2. CHANNEL BUFFERS'),
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
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF1565C0).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.message,
                            color: Color(0xFF1565C0),
                            size: 22,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ChannelBuffers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Singleton via ui.channelBuffers',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _infoBox(
                      'Buffers platform channel messages until a listener registers. '
                      'Critical for plugin initialization ordering.',
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 12),
                    _apiRow('push(name, data, callback)', 'Queue a message'),
                    _apiRow(
                      'setListener(name, handler)',
                      'Register channel listener',
                    ),
                    _apiRow('clearListener(name)', 'Remove channel listener'),
                    _apiRow(
                      'drain(name, callback)',
                      'Process buffered messages',
                    ),
                  ],
                ),
              ),

              // ── Section 3: PlatformDispatcher ──
              _sectionTitle('3. PLATFORM DISPATCHER'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _dispatcherProp(
                      'locale',
                      '${dispatcher.locale}',
                      Icons.language,
                      Color(0xFF6A1B9A),
                    ),
                    _dispatcherProp(
                      'locales',
                      '${dispatcher.locales.length} locales',
                      Icons.translate,
                      Color(0xFF1565C0),
                    ),
                    _dispatcherProp(
                      'textScaleFactor',
                      '${dispatcher.textScaleFactor}',
                      Icons.format_size,
                      Color(0xFF2E7D32),
                    ),
                    _dispatcherProp(
                      'semanticsEnabled',
                      '${dispatcher.semanticsEnabled}',
                      Icons.accessibility,
                      Color(0xFFE65100),
                    ),
                    _dispatcherProp(
                      'defaultRouteName',
                      dispatcher.defaultRouteName,
                      Icons.route,
                      Color(0xFFC62828),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Callback Registration ──
              _sectionTitle('4. FRAMEWORK CALLBACKS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _callbackGroup('Frame Lifecycle', [
                      'onBeginFrame → Start of frame',
                      'onDrawFrame → Drawing phase',
                      'onFrameDataChanged → Frame metadata',
                    ], Color(0xFF1565C0)),
                    SizedBox(height: 12),
                    _callbackGroup('Configuration', [
                      'onMetricsChanged → Window size/DPR',
                      'onLocaleChanged → Locale switch',
                      'onTextScaleFactorChanged → Text scale',
                      'onPlatformBrightnessChanged → Light/dark',
                    ], Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    _callbackGroup('Input & Semantics', [
                      'onPointerDataPacket → Touch/mouse events',
                      'onSemanticsEnabledChanged → A11y toggle',
                      'onSemanticsActionEvent → A11y actions',
                    ], Color(0xFF6A1B9A)),
                  ],
                ),
              ),

              // ── Section 5: Architecture ──
              _sectionTitle('5. ARCHITECTURE LAYER'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _layerBox('Your App Code', Color(0xFF2E7D32), false),
                    _layerArrow(),
                    _layerBox(
                      'Flutter Framework (Widgets, Rendering)',
                      Color(0xFF1565C0),
                      false,
                    ),
                    _layerArrow(),
                    _layerBox(
                      'dart:ui (PlatformDispatcher, etc.)',
                      Color(0xFF6A1B9A),
                      true,
                    ),
                    _layerArrow(),
                    _layerBox(
                      'Engine (C++/Skia/Impeller)',
                      Color(0xFFC62828),
                      false,
                    ),
                    _layerArrow(),
                    _layerBox('OS Platform', Color(0xFF263238), false),
                  ],
                ),
              ),

              // ── Section 6: Views ──
              _sectionTitle('6. VIEWS & DISPLAYS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _dispatcherProp(
                      'views count',
                      '${dispatcher.views.length}',
                      Icons.window,
                      Color(0xFF1565C0),
                    ),
                    if (dispatcher.views.isNotEmpty) ...[
                      SizedBox(height: 8),
                      ...dispatcher.views.take(3).map((v) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monitor,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'View ${v.viewId}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${v.physicalSize.width.toInt()}×${v.physicalSize.height.toInt()} '
                                        'px, DPR: ${v.devicePixelRatio.toStringAsFixed(1)}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
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
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _featureRow(String name, bool value, String desc, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (value ? Color(0xFF2E7D32) : Color(0xFFBDBDBD)).withValues(
              alpha: 0.1,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: value ? Color(0xFF2E7D32) : Color(0xFFBDBDBD),
            size: 16,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: value ? Color(0xFFE8F5E9) : Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value ? 'ON' : 'OFF',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: value ? Color(0xFF2E7D32) : Color(0xFF757575),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _infoBox(String text, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Text(text, style: TextStyle(fontSize: 11, color: color)),
  );
}

Widget _apiRow(String method, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Color(0xFF1565C0),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: method,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: ' — $desc',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _dispatcherProp(String label, String value, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _callbackGroup(String title, List<String> callbacks, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        ...callbacks.map(
          (cb) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '  $cb',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _layerBox(String label, Color color, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      color: active
          ? color.withValues(alpha: 0.15)
          : color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: active ? 2 : 1),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: active ? FontWeight.bold : FontWeight.w500,
          fontSize: 12,
          color: color,
        ),
      ),
    ),
  );
}

Widget _layerArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400], size: 18),
  );
}
