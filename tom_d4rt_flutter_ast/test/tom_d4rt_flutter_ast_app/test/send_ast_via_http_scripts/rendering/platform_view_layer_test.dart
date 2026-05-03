// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: PlatformViewLayer deep demo
//
// PlatformViewLayer is the engine layer that allows native platform views
// (AndroidView, UiKitView, AppKitView, HtmlElementView) to be embedded inside
// the Flutter render tree. The engine composes the native view either on top
// of, or beneath, the Flutter surface, depending on the composition mode.
//
// This script renders a static, hand-authored explainer. It does NOT
// instantiate real platform-view widgets — they require platform channels
// that are not reachable from a sandboxed test app, and they cannot render
// on a Linux host. Instead, each section uses defaultTargetPlatform to
// detect availability and renders mock visual previews of what the embed
// would look like in production.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

const Color _androidGreen = Color(0xFF3DDC84);
const Color _androidGreenDark = Color(0xFF1B873F);
const Color _iosBlue = Color(0xFF007AFF);
const Color _iosBlueDark = Color(0xFF0050B3);
const Color _macPurple = Color(0xFF8E44AD);
const Color _macPurpleDark = Color(0xFF5B2C6F);
const Color _webOrange = Color(0xFFE67E22);
const Color _webOrangeDark = Color(0xFFA0521D);
const Color _neutralInk = Color(0xFF1F2933);
const Color _neutralPaper = Color(0xFFF7F9FC);
const Color _neutralBorder = Color(0xFFE4E7EB);
const Color _neutralMuted = Color(0xFF7B8794);

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED LOW-LEVEL HELPERS
// ═══════════════════════════════════════════════════════════════════════════════

BoxDecoration _cardDecoration({
  required List<Color> gradient,
  double radius = 18,
  double borderOpacity = 0.18,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: gradient,
    ),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: Colors.white.withOpacity(borderOpacity),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.18),
        blurRadius: 22,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

BoxDecoration _paperDecoration({double radius = 14}) {
  return BoxDecoration(
    color: _neutralPaper,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: _neutralBorder),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

Widget _sectionDivider(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: _neutralBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              color: _neutralMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1, color: _neutralBorder)),
      ],
    ),
  );
}

Widget _bullet(String text, {IconData icon = Icons.check_circle, Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color ?? _neutralMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _neutralInk,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            key,
            style: const TextStyle(
              color: _neutralMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _neutralInk,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String text, {required Color color}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 1. HERO HEADER
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFF1A237E),
        Color(0xFF311B92),
        Color(0xFF6A1B9A),
      ],
      radius: 24,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.layers, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'PlatformViewLayer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'rendering library — engine-composited native view embed',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'A PlatformViewLayer represents the slot in the Flutter render tree '
          'where the engine composites a native UI view managed by the host '
          'platform (Android, iOS, macOS, Web). The Flutter framework does '
          'not paint into this region directly — instead, the embedder hands '
          'the rectangle off to the native view system, which paints it with '
          'platform-native primitives, then the engine recombines the result '
          'with the rest of the Flutter scene.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chip('hybrid composition', color: Colors.white),
            _chip('texture layer', color: Colors.white),
            _chip('virtual display', color: Colors.white),
            _chip('engine layer', color: Colors.white),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 2. PLATFORM DETECTION PANEL
// ═══════════════════════════════════════════════════════════════════════════════

String _platformLabel(TargetPlatform p) {
  switch (p) {
    case TargetPlatform.android:
      return 'Android';
    case TargetPlatform.iOS:
      return 'iOS';
    case TargetPlatform.macOS:
      return 'macOS';
    case TargetPlatform.linux:
      return 'Linux';
    case TargetPlatform.windows:
      return 'Windows';
    case TargetPlatform.fuchsia:
      return 'Fuchsia';
  }
}

IconData _platformIcon(TargetPlatform p) {
  switch (p) {
    case TargetPlatform.android:
      return Icons.android;
    case TargetPlatform.iOS:
      return Icons.phone_iphone;
    case TargetPlatform.macOS:
      return Icons.desktop_mac;
    case TargetPlatform.linux:
      return Icons.computer;
    case TargetPlatform.windows:
      return Icons.window;
    case TargetPlatform.fuchsia:
      return Icons.bubble_chart;
  }
}

Widget _buildPlatformDetection(TargetPlatform platform) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFF263238),
        Color(0xFF37474F),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.device_hub, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            const Text(
              'Platform detection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_platformIcon(platform),
                      color: Colors.white, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    _platformLabel(platform),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'defaultTargetPlatform from package:flutter/foundation.dart returns '
          'the runtime target. The PlatformView APIs each have a distinct '
          'home OS — only one of them is renderable at any given time. '
          'kIsWeb is a separate compile-time const that gates HtmlElementView.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _platformRow('Android', Icons.android, _androidGreen,
                  'AndroidView', platform == TargetPlatform.android),
              _platformRow('iOS', Icons.phone_iphone, _iosBlue, 'UiKitView',
                  platform == TargetPlatform.iOS),
              _platformRow('macOS', Icons.desktop_mac, _macPurple,
                  'AppKitView', platform == TargetPlatform.macOS),
              _platformRow('Web (kIsWeb)', Icons.public, _webOrange,
                  'HtmlElementView', kIsWeb),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'kIsWeb = $kIsWeb',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _platformRow(
    String name, IconData icon, Color color, String widget, bool active) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Icon(
          active ? Icons.check_circle : Icons.cancel,
          color: active ? _androidGreen : Colors.white24,
          size: 16,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 3. ANDROID — AndroidView panel
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildAndroidPanel(TargetPlatform platform) {
  final available = platform == TargetPlatform.android;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFE8F5E9),
        Color(0xFFC8E6C9),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_androidGreen, _androidGreenDark],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _androidGreen.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.android, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AndroidView',
                    style: TextStyle(
                      color: _androidGreenDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'package:flutter/widgets.dart → AndroidView',
                    style: TextStyle(
                      color: _neutralMuted,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (available)
          _availabilityNotice(
            available: true,
            text: 'You are on Android — a real AndroidView could be embedded '
                'into the live tree right here. The mock below shows what a '
                'Google Map AndroidView would look like in your render tree.',
            color: _androidGreenDark,
          )
        else
          _availabilityNotice(
            available: false,
            text: 'AndroidView only renders on Android — your platform is '
                '${_platformLabel(platform)}. The embed slot would be empty '
                'or fall back to the placeholderBuilder. The mock below '
                'visualizes what would appear on a real device.',
            color: _androidGreenDark,
          ),
        const SizedBox(height: 14),
        const Text(
          'Mock preview: a Google Maps AndroidView embedded in a Flutter '
          'Column. The native view paints its own pixels; Flutter widgets '
          'around it composite normally.',
          style: TextStyle(color: _neutralInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _mockGoogleMap(),
        const SizedBox(height: 14),
        const Text('Constructor sketch',
            style: TextStyle(
              color: _androidGreenDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 6),
        _codeBlock(
          'AndroidView(\n'
          '  viewType: \'plugins.flutter.io/google_maps\',\n'
          '  creationParams: <String, dynamic>{\n'
          '    \'initialCameraPosition\': cameraPosition,\n'
          '  },\n'
          '  creationParamsCodec: const StandardMessageCodec(),\n'
          '  onPlatformViewCreated: (int id) => _bind(id),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _bullet('Backed by hybrid composition since Flutter 1.22.',
            icon: Icons.bolt, color: _androidGreenDark),
        _bullet('Falls back to virtual display on older Android.',
            icon: Icons.history, color: _androidGreenDark),
        _bullet('Touch events flow through Flutter\'s gesture arena.',
            icon: Icons.touch_app, color: _androidGreenDark),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 4. iOS — UiKitView panel
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildIosPanel(TargetPlatform platform) {
  final available = platform == TargetPlatform.iOS;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFE3F2FD),
        Color(0xFFBBDEFB),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_iosBlue, _iosBlueDark],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _iosBlue.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child:
                  const Icon(Icons.phone_iphone, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UiKitView',
                    style: TextStyle(
                      color: _iosBlueDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'package:flutter/widgets.dart → UiKitView',
                    style: TextStyle(
                      color: _neutralMuted,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (available)
          _availabilityNotice(
            available: true,
            text: 'You are on iOS — a real UiKitView could be embedded into '
                'the tree. The mock below shows what an AVPlayer UIView '
                'embed might look like.',
            color: _iosBlueDark,
          )
        else
          _availabilityNotice(
            available: false,
            text: 'UiKitView only renders on iOS — your platform is '
                '${_platformLabel(platform)}. The embed slot would be a no-op '
                'or replaced with a placeholder. The mock below visualizes '
                'what would appear on a real iPhone.',
            color: _iosBlueDark,
          ),
        const SizedBox(height: 14),
        const Text(
          'Mock preview: a UIView-backed video player frame embedded in a '
          'Flutter Column. The native AVPlayerLayer paints into its own '
          'CALayer surface, then the engine composes it with the Flutter '
          'scene.',
          style: TextStyle(color: _neutralInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _mockVideoPlayer(),
        const SizedBox(height: 14),
        const Text('Constructor sketch',
            style: TextStyle(
              color: _iosBlueDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 6),
        _codeBlock(
          'UiKitView(\n'
          '  viewType: \'plugins.flutter.io/avplayer\',\n'
          '  creationParams: <String, dynamic>{\n'
          '    \'url\': videoUrl,\n'
          '  },\n'
          '  creationParamsCodec: const StandardMessageCodec(),\n'
          '  onPlatformViewCreated: (int id) => _bind(id),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _bullet('Always uses hybrid composition on iOS.',
            icon: Icons.bolt, color: _iosBlueDark),
        _bullet('Backed by FlutterPlatformViewsController in the embedder.',
            icon: Icons.architecture, color: _iosBlueDark),
        _bullet('Threading: must be created on the platform thread.',
            icon: Icons.warning_amber, color: _iosBlueDark),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 5. macOS — AppKitView panel
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMacOsPanel(TargetPlatform platform) {
  final available = platform == TargetPlatform.macOS;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFF3E5F5),
        Color(0xFFE1BEE7),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_macPurple, _macPurpleDark],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _macPurple.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child:
                  const Icon(Icons.desktop_mac, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AppKitView',
                    style: TextStyle(
                      color: _macPurpleDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'package:flutter/widgets.dart → AppKitView (newest)',
                    style: TextStyle(
                      color: _neutralMuted,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _macPurple.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _macPurple.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.new_releases, color: _macPurpleDark, size: 14),
              SizedBox(width: 6),
              Text(
                'Newest platform-view variant',
                style: TextStyle(
                  color: _macPurpleDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (available)
          _availabilityNotice(
            available: true,
            text: 'You are on macOS — a real AppKitView could be embedded. '
                'The mock below shows a native NSButton + NSTextField group '
                'as an AppKitView embed.',
            color: _macPurpleDark,
          )
        else
          _availabilityNotice(
            available: false,
            text: 'AppKitView only renders on macOS — your platform is '
                '${_platformLabel(platform)}. The mock below visualizes what '
                'would appear in a real macOS Flutter app.',
            color: _macPurpleDark,
          ),
        const SizedBox(height: 14),
        const Text(
          'AppKitView is the macOS-desktop-native counterpart to UiKitView, '
          'introduced after Flutter 3.x stabilized desktop. It hosts NSView '
          'subclasses inside the Flutter scene using the same hybrid '
          'composition pattern.',
          style: TextStyle(color: _neutralInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _mockNativeButton(),
        const SizedBox(height: 14),
        const Text('Constructor sketch',
            style: TextStyle(
              color: _macPurpleDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 6),
        _codeBlock(
          'AppKitView(\n'
          '  viewType: \'com.example/native_form\',\n'
          '  creationParams: <String, dynamic>{\n'
          '    \'placeholder\': \'Enter your name\',\n'
          '  },\n'
          '  creationParamsCodec: const StandardMessageCodec(),\n'
          '  onPlatformViewCreated: (int id) => _bind(id),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _bullet('NSView-based instead of UIView.',
            icon: Icons.layers, color: _macPurpleDark),
        _bullet('Inherits from DarwinPlatformView base.',
            icon: Icons.account_tree, color: _macPurpleDark),
        _bullet('Use cases: native menus, NSTextView, NSStackView, WKWebView.',
            icon: Icons.menu_book, color: _macPurpleDark),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 6. WEB — HtmlElementView panel
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildWebPanel(TargetPlatform platform) {
  final available = kIsWeb;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFFFF3E0),
        Color(0xFFFFE0B2),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_webOrange, _webOrangeDark],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _webOrange.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.public, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HtmlElementView',
                    style: TextStyle(
                      color: _webOrangeDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'package:flutter/widgets.dart → HtmlElementView',
                    style: TextStyle(
                      color: _neutralMuted,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (available)
          _availabilityNotice(
            available: true,
            text: 'kIsWeb is true — a real HtmlElementView could embed an '
                'arbitrary HTMLElement (registered via platformViewRegistry) '
                'in the DOM beneath the Flutter canvas.',
            color: _webOrangeDark,
          )
        else
          _availabilityNotice(
            available: false,
            text: 'HtmlElementView only renders when kIsWeb is true — you '
                'are running on ${_platformLabel(platform)}. The mock below '
                'visualizes a faux <iframe> embed.',
            color: _webOrangeDark,
          ),
        const SizedBox(height: 14),
        const Text(
          'On the web, platform views are HTML elements registered by '
          'viewType. The Flutter web engine inserts them into the DOM tree '
          'and overlays the canvas via the HTML/CanvasKit renderer.',
          style: TextStyle(color: _neutralInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _mockIframe(),
        const SizedBox(height: 14),
        const Text('Constructor sketch',
            style: TextStyle(
              color: _webOrangeDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 6),
        _codeBlock(
          '// Register first:\n'
          'ui.platformViewRegistry.registerViewFactory(\n'
          '  \'iframe-element\',\n'
          '  (int viewId) => IFrameElement()..src = \'https://flutter.dev\',\n'
          ');\n\n'
          'HtmlElementView(\n'
          '  viewType: \'iframe-element\',\n'
          '  onPlatformViewCreated: (int id) => _bind(id),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _bullet('Use kIsWeb to compile-time-gate web-only code.',
            icon: Icons.code, color: _webOrangeDark),
        _bullet('No StandardMessageCodec — JS interop instead.',
            icon: Icons.swap_horiz, color: _webOrangeDark),
        _bullet('Element receives DOM events directly; gestures may bypass.',
            icon: Icons.warning_amber, color: _webOrangeDark),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 7. COMPOSITION-MODE COMPARISON TABLE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCompositionModeTable() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFECEFF1),
        Color(0xFFCFD8DC),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.compare_arrows, color: _neutralInk, size: 22),
            SizedBox(width: 10),
            Text(
              'Composition modes',
              style: TextStyle(
                color: _neutralInk,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'How the engine merges native pixels with the Flutter scene.',
          style: TextStyle(color: _neutralMuted, fontSize: 12),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: _paperDecoration(),
          child: Column(
            children: [
              _modeHeader(),
              _modeRow(
                  Icons.merge_type,
                  Colors.indigo,
                  'Hybrid composition',
                  'Native view rendered into a separate CALayer/SurfaceView '
                      'that the engine composites with the Flutter scene.',
                  'Default on iOS/macOS, default on Android since 1.22.',
                  'Slightly slower frame budget; correct ordering.'),
              _modeRow(
                  Icons.developer_board,
                  Colors.deepOrange,
                  'Virtual display',
                  'Android draws the View into an off-screen Surface; '
                      'Flutter samples it as a texture each frame.',
                  'Legacy Android fallback (pre-hybrid composition).',
                  'Cheap GPU-side; loses some accessibility & input events.'),
              _modeRow(
                  Icons.texture,
                  Colors.teal,
                  'Texture layer',
                  'Native producer pushes frames into an OS texture; the '
                      'Flutter Texture widget samples it.',
                  'Used for video, camera, GL — no widget tree intrusion.',
                  'Best perf for video; not appropriate for interactive UI.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _modeHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
    ),
    child: Row(
      children: const [
        SizedBox(width: 28),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text('Mode',
              style: TextStyle(
                  color: _neutralInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6)),
        ),
        Expanded(
          flex: 4,
          child: Text('What it does',
              style: TextStyle(
                  color: _neutralInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6)),
        ),
        Expanded(
          flex: 3,
          child: Text('Where it\'s used',
              style: TextStyle(
                  color: _neutralInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6)),
        ),
        Expanded(
          flex: 3,
          child: Text('Trade-offs',
              style: TextStyle(
                  color: _neutralInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6)),
        ),
      ],
    ),
  );
}

Widget _modeRow(IconData icon, Color color, String name, String what,
    String where, String tradeoffs) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: _neutralBorder)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(name,
              style: TextStyle(
                  color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        Expanded(
          flex: 4,
          child: Text(what,
              style: const TextStyle(
                  color: _neutralInk, fontSize: 12, height: 1.45)),
        ),
        Expanded(
          flex: 3,
          child: Text(where,
              style: const TextStyle(
                  color: _neutralInk, fontSize: 12, height: 1.45)),
        ),
        Expanded(
          flex: 3,
          child: Text(tradeoffs,
              style: const TextStyle(
                  color: _neutralMuted, fontSize: 12, height: 1.45)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 8. API REFERENCE CARD MATRIX
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildApiReferenceMatrix() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(Icons.menu_book, color: _neutralInk, size: 22),
            SizedBox(width: 10),
            Text(
              'API reference',
              style: TextStyle(
                color: _neutralInk,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      const Text(
        'Each platform-view widget shares the same API surface. Below is a '
        'card matrix of the six primary parameters, with prose for each.',
        style: TextStyle(color: _neutralMuted, fontSize: 13),
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          _apiCard(
            'viewType',
            Icons.label,
            const Color(0xFF1976D2),
            'String',
            'A unique key identifying which native view factory to '
                'instantiate. Must match a registration on the host side '
                '(registerViewFactory on Web, FlutterPlatformViewFactory on '
                'iOS/macOS, PlatformViewFactory on Android).',
          ),
          _apiCard(
            'creationParams',
            Icons.send,
            const Color(0xFF8E24AA),
            'dynamic',
            'Initial configuration data passed to the native factory at '
                'creation time. Keep this small — it is encoded once and is '
                'not a stream. For ongoing communication use a MethodChannel '
                'keyed by the platform-view id.',
          ),
          _apiCard(
            'creationParamsCodec',
            Icons.transform,
            const Color(0xFFD81B60),
            'MessageCodec<dynamic>',
            'Codec used to serialize creationParams. Required when '
                'creationParams is not null. The standard choice is '
                'StandardMessageCodec; for binary blobs use BinaryCodec.',
          ),
          _apiCard(
            'gestureRecognizers',
            Icons.touch_app,
            const Color(0xFFEF6C00),
            'Set<Factory<OneSequenceGestureRecognizer>>',
            'Eagerly-claimed gesture recognizers that compete with the '
                'native view in the gesture arena. Without this, the native '
                'view receives all touches inside its rectangle; with it, '
                'Flutter can intercept (e.g.) horizontal drags for a parent.',
          ),
          _apiCard(
            'onPlatformViewCreated',
            Icons.bolt,
            const Color(0xFF00897B),
            'PlatformViewCreatedCallback',
            'Fires once after the native view\'s widget is mounted and the '
                'engine has assigned a platform-view id. Use it to wire a '
                'MethodChannel keyed by that id for subsequent calls.',
          ),
          _apiCard(
            'hitTestBehavior',
            Icons.crop_free,
            const Color(0xFF6D4C41),
            'PlatformViewHitTestBehavior',
            'opaque (default), translucent, or transparent — controls how '
                'the platform-view rectangle participates in Flutter\'s hit '
                'test. transparent lets pointer events pass through to '
                'widgets behind the embed.',
          ),
        ],
      ),
    ],
  );
}

Widget _apiCard(String name, IconData icon, Color color, String type,
    String description) {
  return SizedBox(
    width: 360,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _neutralBorder),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _neutralPaper,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _neutralBorder),
            ),
            child: Text(
              type,
              style: const TextStyle(
                color: _neutralInk,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _neutralInk,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 9. COMMON PITFALLS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPitfalls() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFFFEBEE),
        Color(0xFFFFCDD2),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.warning_amber, color: Color(0xFFB71C1C), size: 22),
            SizedBox(width: 10),
            Text(
              'Common pitfalls',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _pitfallItem(
          Icons.touch_app,
          'Gesture-arena interaction',
          'The default behavior is that the native view consumes every '
              'pointer event inside its rectangle. If you need a parent '
              'Flutter widget to intercept (e.g. a PageView swiping over a '
              'map), pass a non-empty gestureRecognizers Set.',
        ),
        _pitfallItem(
          Icons.transform,
          'Transformation and rotation cost',
          'Rotating, scaling, or applying a 3D Matrix4 to a region '
              'containing a PlatformView forces the engine into the slow '
              'compositor path. Profile carefully — animated transforms on '
              'native embeds are typically unaffordable.',
        ),
        _pitfallItem(
          Icons.accessibility_new,
          'Accessibility forwarding',
          'Native views must explicitly publish their accessibility tree '
              'so it can merge with Flutter\'s SemanticsTree. On Android '
              'this requires SemanticsBinding hooks; on iOS, the platform '
              'view must enable accessibility traits.',
        ),
        _pitfallItem(
          Icons.layers,
          'Z-ordering with Flutter widgets',
          'You can paint Flutter widgets *over* a PlatformView using Stack, '
              'but the engine has to pre-allocate an extra overlay. Many '
              'overlapping platform views can blow the overlay budget.',
        ),
        _pitfallItem(
          Icons.memory,
          'Memory & lifecycle',
          'Each platform view holds native resources (textures, surfaces, '
              'GL contexts). Make sure the Dart-side widget is removed when '
              'no longer needed; the engine calls dispose on the native '
              'side, but only on widget disposal.',
        ),
        _pitfallItem(
          Icons.speed,
          'Frame-rate sensitivity',
          'A single misbehaving PlatformView can stall the whole frame. '
              'When debugging jank, use Flutter DevTools timeline and look '
              'for "Embed View" events spanning multiple frames.',
        ),
      ],
    ),
  );
}

Widget _pitfallItem(IconData icon, String title, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFB71C1C).withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFB71C1C), size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFB71C1C),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(
                  color: _neutralInk,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// 10. SEE-ALSO + FINAL MANTRA
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSeeAlso() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFFE0F2F1),
        Color(0xFFB2DFDB),
      ],
      borderOpacity: 0.4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.menu_book_outlined, color: Color(0xFF00695C), size: 22),
            SizedBox(width: 10),
            Text(
              'See also',
              style: TextStyle(
                color: Color(0xFF00695C),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _seeAlsoEntry(
          Icons.video_library,
          'Texture',
          'Lightweight platform-pushed pixel buffer — no widget tree '
              'intrusion. Ideal for video / camera preview.',
        ),
        _seeAlsoEntry(
          Icons.blur_on,
          'BackdropFilter',
          'Pure-Flutter alternative for blur/blend effects — does not '
              'require platform views and stays fast.',
        ),
        _seeAlsoEntry(
          Icons.swap_calls,
          'MethodChannel',
          'Bidirectional Dart-to-platform calls keyed by a channel name; '
              'pair with onPlatformViewCreated for per-instance binding.',
        ),
        _seeAlsoEntry(
          Icons.compare,
          'BasicMessageChannel',
          'Codec-based channel for arbitrary message payloads, often used '
              'as the back-end for creationParams and event streams.',
        ),
        _seeAlsoEntry(
          Icons.event_note,
          'EventChannel',
          'Subscription-based channel where the platform pushes a stream '
              'to Dart — useful for sensor or location updates.',
        ),
        _seeAlsoEntry(
          Icons.account_tree,
          'PlatformViewLink + UiKitView.controller pattern',
          'Lower-level integration that gives you control over the '
              'PlatformViewSurface widget and the AndroidViewController.',
        ),
      ],
    ),
  );
}

Widget _seeAlsoEntry(IconData icon, String title, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF00695C), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF00695C),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(
                  color: _neutralInk,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMantra() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: _cardDecoration(
      gradient: const [
        Color(0xFF263238),
        Color(0xFF000000),
      ],
      radius: 22,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.format_quote, color: Colors.white24, size: 36),
        const SizedBox(height: 8),
        const Text(
          'Platform views are powerful but expensive — use Flutter widgets '
          'when you can.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
          ),
          child: const Text(
            'PlatformViewLayer  •  rendering library  •  Flutter',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOCK PREVIEW WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _availabilityNotice({
  required bool available,
  required String text,
  required Color color,
}) {
  final bgColor = available
      ? color.withOpacity(0.12)
      : const Color(0xFFB71C1C).withOpacity(0.08);
  final borderColor = available
      ? color.withOpacity(0.4)
      : const Color(0xFFB71C1C).withOpacity(0.3);
  final iconColor = available ? color : const Color(0xFFB71C1C);
  final icon = available ? Icons.check_circle : Icons.info_outline;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: borderColor),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: iconColor,
              fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFD4D4D4),
        fontSize: 11,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

// Mock Google Maps preview ─────────────────────────────────────────
Widget _mockGoogleMap() {
  return Container(
    height: 220,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Base map background.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8EAED), Color(0xFFD0D5D9)],
              ),
            ),
          ),
          // Faux road grid.
          Positioned.fill(child: _mapGrid()),
          // A diagonal road.
          Positioned(
            left: -30,
            top: 80,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 380,
                height: 14,
                color: Colors.white,
              ),
            ),
          ),
          // Vertical road.
          Positioned(
            left: 110,
            top: 0,
            bottom: 0,
            child: Container(width: 12, color: Colors.white),
          ),
          // A small park.
          Positioned(
            right: 24,
            bottom: 24,
            child: Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Pin marker.
          const Positioned(
            left: 160,
            top: 70,
            child: Icon(Icons.location_pin,
                color: Color(0xFFD32F2F), size: 36),
          ),
          // Top-right Google watermark mock.
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Text(
                'Map preview (mock)',
                style: TextStyle(
                  color: _neutralInk,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Bottom badge.
          Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'AndroidView • viewType: google_maps',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _mapGrid() {
  return Column(
    children: List<Widget>.generate(6, (rowIdx) {
      return Expanded(
        child: Row(
          children: List<Widget>.generate(8, (colIdx) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.all(0.5),
                color: ((rowIdx + colIdx).isEven)
                    ? const Color(0xFFE8EAED)
                    : const Color(0xFFDDE0E3),
              ),
            );
          }),
        ),
      );
    }),
  );
}

// Mock video player preview ─────────────────────────────────────────
Widget _mockVideoPlayer() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.9,
                colors: [Color(0xFF2C3E50), Color(0xFF000000)],
              ),
            ),
          ),
          // Faux moving subject (silhouette).
          Center(
            child: Icon(
              Icons.directions_run,
              color: Colors.white.withOpacity(0.5),
              size: 80,
            ),
          ),
          // Top bar.
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fiber_manual_record,
                      color: Colors.white, size: 10),
                  SizedBox(width: 4),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom controls.
          Positioned(
            left: 8,
            right: 8,
            bottom: 10,
            child: Row(
              children: [
                const Icon(Icons.play_arrow, color: Colors.white, size: 22),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  '01:23 / 04:56',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'monospace'),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.fullscreen, color: Colors.white, size: 18),
              ],
            ),
          ),
          // Bottom watermark.
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'UiKitView • avplayer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontFamily: 'monospace'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Mock native button group preview ─────────────────────────────────
Widget _mockNativeButton() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFAFAFA), Color(0xFFE0E0E0)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFB0B0B0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Native macOS form (mock)',
          style: TextStyle(
            color: _neutralInk,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFB0B0B0)),
          ),
          child: const Text(
            'NSTextField — placeholder text',
            style: TextStyle(color: _neutralMuted, fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6FB1FC), Color(0xFF4364F7)],
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFB0B0B0)),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: _neutralInk,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.help_outline,
                color: _neutralMuted, size: 16),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'AppKitView • native_form',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// Mock iframe preview ─────────────────────────────────────────────
Widget _mockIframe() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFB0B0B0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          // Browser chrome.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFFECEFF1),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFB0B0B0)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock, size: 10, color: _neutralMuted),
                        SizedBox(width: 4),
                        Text(
                          'https://flutter.dev',
                          style: TextStyle(
                            color: _neutralInk,
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content placeholder.
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFFFFF), Color(0xFFFFE0B2)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _webOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.flutter_dash,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Text('flutter.dev',
                          style: TextStyle(
                              color: _neutralInk,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 8,
                    width: 200,
                    decoration: BoxDecoration(
                      color: _neutralBorder,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 8,
                    width: 160,
                    decoration: BoxDecoration(
                      color: _neutralBorder,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 8,
                    width: 220,
                    decoration: BoxDecoration(
                      color: _neutralBorder,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'HtmlElementView • iframe-element',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  final platform = defaultTargetPlatform;
  return Scaffold(
    backgroundColor: const Color(0xFFF0F2F5),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHero(),
          _sectionDivider('PLATFORM SCAN'),
          _buildPlatformDetection(platform),
          _sectionDivider('PER-PLATFORM EMBEDS'),
          _buildAndroidPanel(platform),
          const SizedBox(height: 14),
          _buildIosPanel(platform),
          const SizedBox(height: 14),
          _buildMacOsPanel(platform),
          const SizedBox(height: 14),
          _buildWebPanel(platform),
          _sectionDivider('COMPOSITION INTERNALS'),
          _buildCompositionModeTable(),
          _sectionDivider('API SURFACE'),
          _buildApiReferenceMatrix(),
          _sectionDivider('PRACTICAL CONCERNS'),
          _buildPitfalls(),
          _sectionDivider('REFERENCES'),
          _buildSeeAlso(),
          const SizedBox(height: 18),
          _buildMantra(),
          const SizedBox(height: 18),
          // Appendix at-a-glance kv table (uses _kvRow primitive).
          ..._appendixSink,
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// EXTRA: a key-value row helper (kept as a public primitive for further
// expansion of the demo). It is exercised here to keep analyzer happy.
// ═══════════════════════════════════════════════════════════════════════════════

Widget _appendixKvDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: _paperDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appendix: PlatformViewLayer at-a-glance',
          style: TextStyle(
            color: _neutralInk,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        _kvRow('Library', 'rendering / widgets'),
        _kvRow('Layer kind', 'engine compositor layer'),
        _kvRow('Android', 'AndroidView'),
        _kvRow('iOS', 'UiKitView'),
        _kvRow('macOS', 'AppKitView'),
        _kvRow('Web', 'HtmlElementView'),
        _kvRow('Modes', 'hybrid | virtual-display | texture'),
        _kvRow('Hit-test', 'opaque | translucent | transparent'),
      ],
    ),
  );
}

// (The appendix is referenced in `_appendixSink` to satisfy analyzer
// unused-element warnings without altering the visible UI surface.)
final List<Widget> _appendixSink = <Widget>[_appendixKvDemo()];
