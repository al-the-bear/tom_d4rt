// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unnecessary_import
// D4rt deep visual demo: TargetPlatform, defaultTargetPlatform, kIsWeb,
// Theme.of(context).platform, and platform-adaptive UI patterns. Three
// detection layers — compile-time (kIsWeb), runtime default
// (defaultTargetPlatform), theme-supplied (Theme.of(context).platform) —
// rendered as a long, image-rich page across 11 sections.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ============================================================
// Color palette (single source of truth so cards stay coherent)
// ============================================================
const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMuted = Color(0xFF64748B);
const Color _kPaper = Color(0xFFF8FAFC);
const Color _kPaperWarm = Color(0xFFFFF8F1);
const Color _kAccent = Color(0xFF6366F1);
const Color _kAccentDeep = Color(0xFF3730A3);
const Color _kSuccess = Color(0xFF16A34A);
const Color _kDanger = Color(0xFFDC2626);
const Color _kWarn = Color(0xFFD97706);

// Platform-specific signature colors (used in the gallery cards).
const Color _kAndroidGreen = Color(0xFF3DDC84);
const Color _kFuchsiaPink = Color(0xFFFF4081);
const Color _kIosBlue = Color(0xFF007AFF);
const Color _kLinuxOrange = Color(0xFFE95420);
const Color _kMacSilver = Color(0xFFB8BFC7);
const Color _kWindowsTeal = Color(0xFF0078D4);

dynamic build(BuildContext context) {
  print('Platform deep-demo executing');
  print('=== Reading platform layer values ===');
  print('kIsWeb: $kIsWeb');
  print('kIsWasm: $kIsWasm');
  print('kDebugMode: $kDebugMode');
  print('kReleaseMode: $kReleaseMode');
  print('kProfileMode: $kProfileMode');

  // Defensive read of defaultTargetPlatform — never throws in practice but
  // we wrap it so the demo keeps rendering if the interpreter shape changes.
  TargetPlatform detectedPlatform = TargetPlatform.android;
  String detectedPlatformLabel = '<unknown>';
  String detectionError = '';
  try {
    detectedPlatform = defaultTargetPlatform;
    detectedPlatformLabel = detectedPlatform.toString();
    print('defaultTargetPlatform: $detectedPlatform');
  } catch (e) {
    detectionError = e.toString();
    print('defaultTargetPlatform error: $e');
  }

  TargetPlatform themePlatform = TargetPlatform.android;
  String themePlatformLabel = '<unknown>';
  try {
    themePlatform = Theme.of(context).platform;
    themePlatformLabel = themePlatform.toString();
    print('Theme.of(context).platform: $themePlatform');
  } catch (e) {
    print('Theme.of(context).platform error: $e');
  }

  // Print the entire enum once, for the trail-file readers.
  for (final TargetPlatform p in TargetPlatform.values) {
    print('TargetPlatform value: $p (index ${p.index})');
  }

  // SingleChildScrollView wrap (entry #20 follow-up): the script's 11
  // sections + intro + footer stack to ~7000+ px of natural height —
  // far exceeding the typical 800-px test viewport. Without scroll
  // wrapping, the Column overflows the bounded viewport by ~7257 px
  // (the U18 IntrinsicHeight fix on _defaultVsThemeCard unmasked this
  // previously-hidden overflow that the original Row(stretch)
  // assertion was firing on first). Adding the SCV gives the Column
  // an unbounded vertical extent and lets the content scroll, which
  // is the expected UX for a long demo page anyway.
  return Container(
    color: _kPaper,
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroIntro(), const SizedBox(height: 28.0),
          _section1Title(), const SizedBox(height: 12.0), _section1Body(),
        const SizedBox(height: 36.0),
        _section2Title(), const SizedBox(height: 12.0), _platformGallery(),
        const SizedBox(height: 36.0),
        _section3Title(), const SizedBox(height: 12.0), _defaultVsThemeCard(),
        const SizedBox(height: 36.0),
        _section4Title(), const SizedBox(height: 12.0),
        _liveDetectionCard(
          detectedPlatform: detectedPlatform,
          detectedLabel: detectedPlatformLabel,
          themePlatform: themePlatform,
          themePlatformLabel: themePlatformLabel,
          detectionError: detectionError),
        const SizedBox(height: 36.0),
        _section5Title(), const SizedBox(height: 12.0), _cupertinoVsMaterialTable(),
        const SizedBox(height: 36.0),
        _section6Title(), const SizedBox(height: 12.0), _codeIdiomCards(),
        const SizedBox(height: 36.0),
        _section7Title(), const SizedBox(height: 12.0), _osChromeShowcase(),
        const SizedBox(height: 36.0),
        _section8Title(), const SizedBox(height: 12.0), _themePlatformOverrides(),
        const SizedBox(height: 36.0),
        _section9Title(), const SizedBox(height: 12.0), _pitfallsList(),
        const SizedBox(height: 36.0),
        _section10Title(), const SizedBox(height: 12.0), _decisionTree(),
        const SizedBox(height: 36.0),
        _section11Title(), const SizedBox(height: 12.0), _cheatSheet(),
        const SizedBox(height: 32.0), _footerTagline(),
        const SizedBox(height: 24.0),
      ],
    ),
    ),
  );
}

// ============================================================
// HERO INTRO
// ============================================================
Widget _heroIntro() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF312E81)],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(24.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.white24, Colors.white10],
                begin: Alignment.topCenter, end: Alignment.bottomCenter),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.devices_other, size: 48.0, color: Colors.white),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Platform', style: TextStyle(
                  fontSize: 36.0, fontWeight: FontWeight.bold,
                  color: Colors.white, letterSpacing: 1.4)),
                SizedBox(height: 4.0),
                Text('TargetPlatform • defaultTargetPlatform • kIsWeb',
                  style: TextStyle(
                    fontSize: 13.0, color: Colors.white70, fontFamily: 'monospace')),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.white24),
          ),
          child: const Text(
            'Flutter exposes three layered ways to ask "where am I running?": '
            'compile-time constants (kIsWeb), runtime defaults (defaultTargetPlatform), '
            'and theme-supplied context (Theme.of(context).platform). Each answers a slightly '
            'different question — and mixing them up is one of the most common adaptive-UI bugs.',
            style: TextStyle(color: Colors.white, fontSize: 14.0, height: 1.5),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(children: <Widget>[
          _heroChip('6 platforms', Icons.grid_view),
          const SizedBox(width: 8.0),
          _heroChip('3 layers', Icons.layers),
          const SizedBox(width: 8.0),
          _heroChip('1 enum', Icons.list_alt),
        ]),
      ],
    ),
  );
}

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Colors.white24, Colors.white12],
        begin: Alignment.centerLeft, end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 16.0),
        const SizedBox(width: 6.0),
        Text(label, style: const TextStyle(
          color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

// ============================================================
// Section title helper
// ============================================================
Widget _sectionTitle(String number, String title, String subtitle, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border(left: BorderSide(color: accent, width: 6.0)),
    ),
    child: Row(children: <Widget>[
      Container(
        width: 42.0, height: 42.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12), shape: BoxShape.circle),
        child: Text(number, style: TextStyle(
          color: accent, fontWeight: FontWeight.bold, fontSize: 18.0)),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: _kInk)),
            const SizedBox(height: 2.0),
            Text(subtitle, style: const TextStyle(
              fontSize: 12.0, color: _kInkMuted)),
          ],
        ),
      ),
    ]),
  );
}

Widget _section1Title() => _sectionTitle('1', 'Why platform detection matters', 'Three layers, one enum, plenty of footguns', _kAccent);

Widget _section1Body() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Flutter is a write-once-render-anywhere toolkit, but "anywhere" is pluralistic. '
          'Each target ships with its own input model, gestures, typography, and visual idioms. '
          'A scroll bounce on iOS is an overscroll glow on Android. A page-push on iOS slides '
          'from the right with an interactive back-swipe; on Android it fades up.',
          style: TextStyle(fontSize: 14.0, color: _kInkSoft, height: 1.55),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Most of these distinctions are already baked into Material and Cupertino — you '
          'rarely need to write `if (Platform.isIOS)` yourself. The exceptions: choosing the '
          'app shell, custom title bars on desktop, platform-specific asset paths, and web-only '
          'fallbacks. Those are the cases where the three layers below matter.',
          style: TextStyle(fontSize: 14.0, color: _kInkSoft, height: 1.55),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Expanded(child: _layerCard('Compile-time', 'kIsWeb, kIsWasm, kDebug/Release/Profile',
                'Tree-shaken in release builds. Always cheap.', Icons.code, _kSuccess)),
            const SizedBox(width: 10.0),
            Expanded(child: _layerCard('Runtime default', 'defaultTargetPlatform',
                'Static getter. Overridable in tests.', Icons.memory, _kAccent)),
            const SizedBox(width: 10.0),
            Expanded(child: _layerCard('Theme context', 'Theme.of(context).platform',
                'What Material widgets actually obey.', Icons.color_lens, _kWarn)),
          ],
        ),
      ],
    ),
  );
}

Widget _layerCard(String layer, String api, String note, IconData icon, Color accent) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: accent, size: 22.0),
        const SizedBox(height: 6.0),
        Text(layer,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: accent, letterSpacing: 0.6)),
        const SizedBox(height: 4.0),
        Text(api, style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInk)),
        const SizedBox(height: 6.0),
        Text(note, style: const TextStyle(fontSize: 10.5, color: _kInkSoft, height: 1.35)),
      ],
    ),
  );
}

// ============================================================
// SECTION 2: TargetPlatform enum gallery
// ============================================================
Widget _section2Title() => _sectionTitle('2', 'TargetPlatform enum gallery', 'Six values, each with its native chrome', _kAccentDeep);

Widget _platformGallery() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _platformCard(TargetPlatform.android, 'Android',
              _kAndroidGreen, Icons.android,
              'Material 3 by default', 'Pixel, Samsung, Xiaomi, …')),
            const SizedBox(width: 10.0),
            Expanded(child: _platformCard(TargetPlatform.fuchsia, 'Fuchsia',
              _kFuchsiaPink, Icons.bubble_chart,
              'Google\'s experimental OS', 'Nest Hub gen-2+')),
            const SizedBox(width: 10.0),
            Expanded(child: _platformCard(TargetPlatform.iOS, 'iOS',
              _kIosBlue, Icons.phone_iphone,
              'Cupertino by default', 'iPhone, iPad')),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _platformCard(TargetPlatform.linux, 'Linux',
              _kLinuxOrange, Icons.computer,
              'GTK/Qt host integration', 'Ubuntu, Fedora, Arch')),
            const SizedBox(width: 10.0),
            Expanded(child: _platformCard(TargetPlatform.macOS, 'macOS',
              _kMacSilver, Icons.laptop_mac,
              'AppKit chrome', 'MacBook, iMac, Mac mini')),
            const SizedBox(width: 10.0),
            Expanded(child: _platformCard(TargetPlatform.windows, 'Windows',
              _kWindowsTeal, Icons.window,
              'Fluent design hints', 'Surface, Dell, HP')),
          ],
        ),
        const SizedBox(height: 14.0),
        _galleryFooter(),
      ],
    ),
  );
}

Widget _platformCard(TargetPlatform platform, String name, Color color, IconData icon,
    String tagline, String devices) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color, _shade(color, 0.85)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          ),
          child: Row(children: <Widget>[
            Icon(icon, color: Colors.white, size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(child: Text(name, style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0))),
            _mockChromeDots(platform),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('TargetPlatform.${_enumTail(platform.toString())}',
                  style: TextStyle(
                    fontSize: 10.5, fontFamily: 'monospace',
                    color: _shade(color, 0.6), fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8.0),
              Text(tagline, style: const TextStyle(
                fontSize: 12.0, color: _kInk, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4.0),
              Text(devices, style: const TextStyle(fontSize: 11.0, color: _kInkMuted)),
              const SizedBox(height: 8.0),
              Row(children: <Widget>[
                _swatch(color), const SizedBox(width: 4.0),
                _swatch(_shade(color, 0.7)), const SizedBox(width: 4.0),
                _swatch(_shade(color, 0.45)), const SizedBox(width: 4.0),
                _swatch(_shade(color, 1.25)),
              ]),
              const SizedBox(height: 6.0),
              Text('index: ${platform.index}', style: const TextStyle(
                fontSize: 10.0, color: _kInkMuted, fontFamily: 'monospace')),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mockChromeDots(TargetPlatform platform) {
  // Each platform's window-controls hint:
  // macOS = red/yellow/green dots, Windows = three small squares, mobile/linux = blank.
  if (platform == TargetPlatform.macOS) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        _ChromeDot(color: Color(0xFFFF5F57)),
        SizedBox(width: 4.0),
        _ChromeDot(color: Color(0xFFFEBC2E)),
        SizedBox(width: 4.0),
        _ChromeDot(color: Color(0xFF28C840)),
      ],
    );
  }
  if (platform == TargetPlatform.windows) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(Icons.minimize, color: Colors.white, size: 12.0),
        SizedBox(width: 4.0),
        Icon(Icons.crop_square, color: Colors.white, size: 12.0),
        SizedBox(width: 4.0),
        Icon(Icons.close, color: Colors.white, size: 12.0),
      ],
    );
  }
  if (platform == TargetPlatform.linux) {
    return const Icon(Icons.menu, color: Colors.white, size: 14.0);
  }
  // iOS / android / fuchsia: mobile, no chrome buttons.
  return const SizedBox(width: 18.0, height: 14.0);
}

class _ChromeDot extends StatelessWidget {
  final Color color;
  const _ChromeDot({required this.color});
  @override
  Widget build(BuildContext context) => Container(
    width: 8.0, height: 8.0,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

Widget _swatch(Color c) {
  return Container(
    width: 14.0, height: 14.0,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(3.0),
      border: Border.all(color: Colors.black.withValues(alpha: 0.08))),
  );
}

Color _shade(Color base, double factor) {
  // factor < 1 darkens, > 1 lightens (clamped to byte range).
  final int r = (base.r * 255.0).round();
  final int g = (base.g * 255.0).round();
  final int b = (base.b * 255.0).round();
  int adjust(int v) {
    if (factor <= 1.0) {
      return (v * factor).round().clamp(0, 255).toInt();
    }
    final double t = (factor - 1.0).clamp(0.0, 2.0);
    return (v + (255 - v) * t).round().clamp(0, 255).toInt();
  }
  return Color.fromARGB(255, adjust(r), adjust(g), adjust(b));
}

String _enumTail(String s) {
  final int idx = s.indexOf('.');
  if (idx < 0) {
    return s;
  }
  return s.substring(idx + 1);
}

Widget _galleryFooter() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kWarn.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.info_outline, color: _kWarn, size: 18.0),
        const SizedBox(width: 8.0),
        const Expanded(
          child: Text(
            'There is no TargetPlatform.web — the web is a build dimension, '
            'not a TargetPlatform. Use kIsWeb to detect the web and then '
            'defaultTargetPlatform to detect the host OS the browser runs on.',
            style: TextStyle(fontSize: 12.0, color: _kInkSoft, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// SECTION 3: defaultTargetPlatform vs Theme.of(context).platform
// ============================================================
Widget _section3Title() => _sectionTitle('3', 'defaultTargetPlatform vs Theme.of(context).platform', 'Same enum, different question', _kSuccess);

Widget _defaultVsThemeCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    // IntrinsicHeight wrap (entry #20): a Row(crossAxisAlignment.stretch)
    // inside a Container that sits in the outer Column receives
    // `maxHeight: infinity` from the surrounding scroll view and
    // propagates it via the cross-axis stretch into a synthetic
    // RenderConstrainedBox inside each Expanded(_twinCard), surfacing
    // as `BoxConstraints forces an infinite height`. IntrinsicHeight
    // resolves the Row's height to the intrinsic min height of the
    // taller twinCard so the stretch has a finite cross-axis to work
    // with. Same family as entry #19's animation/cubic_test fix and
    // entry #10's rendering/render_exclude_semantics_test fix.
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: _twinCard(
            title: 'defaultTargetPlatform',
            subtitle: 'package:flutter/foundation.dart',
            question: '"What host OS am I running on?"',
            color: _kAccent, icon: Icons.memory,
            bullets: const <String>[
              'Static, top-level getter.',
              'Returns one of the six TargetPlatform values.',
              'Best for: choosing your widget tree shape (e.g. wrap in '
                'CupertinoApp vs MaterialApp) before a context exists.',
              'Overridable in tests with debugDefaultTargetPlatformOverride.',
              'Never returns "web" — pair with kIsWeb if you need to '
                'distinguish browsers from native.',
            ],
          )),
          const SizedBox(width: 14.0),
          Expanded(child: _twinCard(
            title: 'Theme.of(context).platform',
            subtitle: 'package:flutter/material.dart',
            question: '"What does the theme want me to look like?"',
            color: _kWarn, icon: Icons.color_lens,
            bullets: const <String>[
              'Read off the ThemeData supplied by the nearest Theme.',
              'What MaterialApp and its widgets actually obey.',
              'Best for: adaptive widgets inside Material — '
                'PageTransitionsTheme, ScrollPhysics, selection handles.',
              'Falls back to defaultTargetPlatform unless overridden via '
                'ThemeData(platform: ...).',
              'Override it to test iOS-flavoured Material on a Linux dev '
                'machine without restarting.',
            ],
          )),
        ],
      ),
    ),
  );
}

Widget _twinCard({
  required String title,
  required String subtitle,
  required String question,
  required Color color,
  required IconData icon,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.0)),
            child: Icon(icon, color: color, size: 20.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(
                  fontSize: 14.0, fontWeight: FontWeight.bold,
                  fontFamily: 'monospace', color: _kInk)),
                Text(subtitle, style: const TextStyle(
                  fontSize: 10.5, color: _kInkMuted, fontFamily: 'monospace')),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8.0)),
          child: Text(question, style: TextStyle(
            fontSize: 13.0, color: _shade(color, 0.55),
            fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 12.0),
        for (final String bullet in bullets) _twinBullet(bullet, color),
      ],
    ),
  );
}

Widget _twinBullet(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          width: 6.0, height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8.0),
        Expanded(child: Text(text, style: const TextStyle(
          fontSize: 12.0, color: _kInkSoft, height: 1.4))),
      ],
    ),
  );
}

// ============================================================
// SECTION 4: Live detection
// ============================================================
Widget _section4Title() => _sectionTitle('4', 'Live detection at build time', 'What this very render sees right now', _kDanger);

Widget _liveDetectionCard({
  required TargetPlatform detectedPlatform,
  required String detectedLabel,
  required TargetPlatform themePlatform,
  required String themePlatformLabel,
  required String detectionError,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFFBEB), Color(0xFFFFF1F2)],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kDanger.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Detection snapshot', style: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: _kInk)),
        const SizedBox(height: 4.0),
        const Text(
          'These badges are computed in this build(BuildContext) call. They '
          'reflect what the running host (and the supplied Theme) report at '
          'the moment of rendering.',
          style: TextStyle(fontSize: 12.0, color: _kInkSoft, height: 1.45),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0, runSpacing: 10.0,
          children: <Widget>[
            _detectionBadge(label: 'kIsWeb', value: kIsWeb ? 'true' : 'false',
              accent: kIsWeb ? _kSuccess : _kInkMuted, icon: Icons.public),
            _detectionBadge(label: 'kIsWasm', value: kIsWasm ? 'true' : 'false',
              accent: kIsWasm ? _kSuccess : _kInkMuted, icon: Icons.bolt),
            _detectionBadge(label: 'kDebugMode', value: kDebugMode ? 'true' : 'false',
              accent: kDebugMode ? _kWarn : _kInkMuted, icon: Icons.bug_report),
            _detectionBadge(label: 'kReleaseMode', value: kReleaseMode ? 'true' : 'false',
              accent: kReleaseMode ? _kSuccess : _kInkMuted, icon: Icons.rocket_launch),
            _detectionBadge(label: 'kProfileMode', value: kProfileMode ? 'true' : 'false',
              accent: kProfileMode ? _kAccent : _kInkMuted, icon: Icons.speed),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kInkMuted.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _liveRow(label: 'defaultTargetPlatform', value: detectedLabel,
                accent: _platformAccent(detectedPlatform),
                icon: _platformIcon(detectedPlatform)),
              const Divider(height: 18.0),
              _liveRow(label: 'Theme.of(context).platform', value: themePlatformLabel,
                accent: _platformAccent(themePlatform),
                icon: _platformIcon(themePlatform)),
              if (detectionError.isNotEmpty) ...<Widget>[
                const Divider(height: 18.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.error_outline, color: _kDanger, size: 16.0),
                    const SizedBox(width: 6.0),
                    Expanded(child: Text('detection error: $detectionError',
                      style: const TextStyle(
                        fontSize: 11.0, color: _kDanger, fontFamily: 'monospace'))),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _detectionBadge({
  required String label,
  required String value,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      border: Border.all(color: accent.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: accent, size: 14.0),
        const SizedBox(width: 6.0),
        Text(label, style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInk)),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(value,
              style: TextStyle(
                  fontSize: 11.0, fontWeight: FontWeight.bold, color: accent, fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

Widget _liveRow({
  required String label,
  required String value,
  required Color accent,
  required IconData icon,
}) {
  return Row(
    children: <Widget>[
      Container(
        width: 36.0, height: 36.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12), shape: BoxShape.circle),
        child: Icon(icon, color: accent, size: 18.0),
      ),
      const SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: const TextStyle(
              fontSize: 11.0, fontFamily: 'monospace', color: _kInkMuted)),
            Text(value, style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w600,
              color: _kInk, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

Color _platformAccent(TargetPlatform p) {
  if (p == TargetPlatform.android) return _kAndroidGreen;
  if (p == TargetPlatform.fuchsia) return _kFuchsiaPink;
  if (p == TargetPlatform.iOS) return _kIosBlue;
  if (p == TargetPlatform.linux) return _kLinuxOrange;
  if (p == TargetPlatform.macOS) return _kMacSilver;
  return _kWindowsTeal;
}

IconData _platformIcon(TargetPlatform p) {
  if (p == TargetPlatform.android) return Icons.android;
  if (p == TargetPlatform.fuchsia) return Icons.bubble_chart;
  if (p == TargetPlatform.iOS) return Icons.phone_iphone;
  if (p == TargetPlatform.linux) return Icons.computer;
  if (p == TargetPlatform.macOS) return Icons.laptop_mac;
  return Icons.window;
}

// ============================================================
// SECTION 5: Cupertino vs Material comparison table
// ============================================================
Widget _section5Title() => _sectionTitle('5', 'Cupertino vs Material adaptation', 'How platform-aware widgets choose their behaviour', _kIosBlue);

Widget _cupertinoVsMaterialTable() {
  const List<List<String>> rows = <List<String>>[
    <String>['Page push transition', 'MaterialPageRoute (fade-up)',
        'CupertinoPageRoute (slide-from-right)'],
    <String>['Back gesture', 'AppBar back button only', 'Interactive edge swipe'],
    <String>['Scroll physics', 'ClampingScrollPhysics', 'BouncingScrollPhysics'],
    <String>['Selection handles', 'Material drop handles', 'Cupertino pin handles'],
    <String>['Dialog widget', 'AlertDialog', 'CupertinoAlertDialog'],
    <String>['Switch widget', 'Switch (Material 3)', 'CupertinoSwitch'],
    <String>['Activity indicator', 'CircularProgressIndicator', 'CupertinoActivityIndicator'],
    <String>['Text selection toolbar', 'Material context menu', 'Cupertino magnifier menu'],
    <String>['Date picker', 'showDatePicker (calendar)', 'CupertinoDatePicker (wheel)'],
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[Color(0xFFEFF6FF), Color(0xFFFCE7F3)]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          ),
          child: Row(children: const <Widget>[
            Expanded(flex: 3, child: Text('Concern', style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold,
              color: _kInkSoft, letterSpacing: 0.5))),
            Expanded(flex: 4, child: Text('Material (Android)', style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold,
              color: _kAndroidGreen, letterSpacing: 0.5))),
            Expanded(flex: 4, child: Text('Cupertino (iOS)', style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold,
              color: _kIosBlue, letterSpacing: 0.5))),
          ]),
        ),
        for (int i = 0; i < rows.length; i++) _tableRow(rows[i], i.isEven),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, bool zebra) {
  const TextStyle ts = TextStyle(fontSize: 11.5, color: _kInkSoft, fontFamily: 'monospace', height: 1.4);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: zebra ? Colors.white : const Color(0xFFFAFAFA),
      border: const Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(cells[0],
              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _kInk)),
        ),
        Expanded(flex: 4, child: Text(cells[1], style: ts)),
        Expanded(flex: 4, child: Text(cells[2], style: ts)),
      ],
    ),
  );
}

// ============================================================
// SECTION 6: Code idiom cards
// ============================================================
Widget _section6Title() => _sectionTitle('6', 'Six idioms you will actually type', 'Copy-paste-ready snippets for platform branching', _kAccent);

Widget _codeIdiomCards() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: <Widget>[
        _codeCard(
          number: '01',
          title: 'switch on defaultTargetPlatform',
          purpose: 'Pick a top-level app shell before any context exists.',
          code: '''Widget rootApp() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return const CupertinoApp(home: HomeScreen());
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return const MaterialApp(home: HomeScreen());
  }
}''',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          number: '02',
          title: 'Theme.of(context).platform inside a widget',
          purpose: 'Adapt an inner widget — respects platform overrides.',
          code: '''Widget build(BuildContext context) {
  final TargetPlatform p = Theme.of(context).platform;
  final bool isApple =
      p == TargetPlatform.iOS || p == TargetPlatform.macOS;
  return isApple
      ? const CupertinoButton(onPressed: null, child: Text('Save'))
      : ElevatedButton(onPressed: () {}, child: const Text('Save'));
}''',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          number: '03',
          title: 'kIsWeb guard for web-only branches',
          purpose: 'Tree-shaken; safe to combine with dart:io imports.',
          code: '''if (kIsWeb) {
  // No dart:io here — file access via dart:html / package:web.
  print('Running in a browser');
} else {
  // Native: dart:io is available below this branch.
  print('Running natively');
}''',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          number: '04',
          title: 'dart:io Platform.is* (native only)',
          purpose:
              'Lowest-level OS detection. NEVER import dart:io on web — '
              'use conditional imports if you must.',
          code: '''// import 'dart:io' show Platform;  // native targets only
//
// if (Platform.isMacOS) {
//   menuBarHeight = 24.0;
// } else if (Platform.isWindows) {
//   menuBarHeight = 32.0;
// }
//
// Best practice: use conditional imports so this whole branch
// is compiled away on web:
//
// import 'platform_io.dart'
//     if (dart.library.html) 'platform_web.dart';''',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          number: '05',
          title: 'Responsive layout factor by platform',
          purpose: 'Mix MediaQuery sizing with platform-derived defaults.',
          code: '''double cardWidth(BuildContext ctx) {
  final double w = MediaQuery.sizeOf(ctx).width;
  switch (Theme.of(ctx).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      return w;                 // phone: full bleed
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return math.min(w, 720);  // desktop: capped column
  }
}''',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          number: '06',
          title: 'Combine web + platform for asset paths',
          purpose: 'Web uses URL-flavoured paths; native uses asset bundles.',
          code: '''String iconPath(String name) {
  if (kIsWeb) {
    return '/assets/icons/web/\$name.svg';
  }
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return 'assets/icons/apple/\$name.png';
    default:
      return 'assets/icons/material/\$name.png';
  }
}''',
        ),
      ],
    ),
  );
}

Widget _codeCard({
  required String number,
  required String title,
  required String purpose,
  required String code,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF0B1021),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: const BoxDecoration(
            color: Color(0xFF111827),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
          ),
          child: Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0)),
              child: Text(number, style: const TextStyle(
                color: Color(0xFFC7D2FE), fontFamily: 'monospace',
                fontSize: 11.0, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(title, style: const TextStyle(
              color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600))),
            const Icon(Icons.copy, color: Colors.white24, size: 14.0),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(purpose, style: const TextStyle(
            fontSize: 11.5, color: Color(0xFF93C5FD), fontStyle: FontStyle.italic)),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: Color(0xFF050816),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.0), bottomRight: Radius.circular(14.0)),
          ),
          child: Text(code, style: const TextStyle(
            color: Color(0xFFE5E7EB), fontFamily: 'monospace',
            fontSize: 11.5, height: 1.5)),
        ),
      ],
    ),
  );
}

// ============================================================
// SECTION 7: Static OS chrome showcase
// ============================================================
Widget _section7Title() => _sectionTitle('7', 'OS chrome showcases', 'Hand-drawn approximations of native top bars', _kMacSilver);

Widget _osChromeShowcase() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: <Widget>[
        _chromeFrame(
          accent: _kIosBlue, radius: 16.0, header: _iosNavBar(),
          body: Row(children: <Widget>[
            _iosCell('Account', Icons.person_outline),
            const SizedBox(width: 8.0),
            _iosCell('Settings', Icons.settings_outlined),
            const SizedBox(width: 8.0),
            _iosCell('About', Icons.info_outline),
          ]),
        ),
        const SizedBox(height: 14.0),
        _chromeFrame(
          accent: _kAndroidGreen, radius: 16.0, header: _androidTopBar(),
          body: Row(children: <Widget>[
            Container(
              width: 44.0, height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kAndroidGreen,
                borderRadius: BorderRadius.circular(14.0)),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(28.0)),
                child: const Text('Floating action + chip rail',
                  style: TextStyle(fontSize: 12.0, color: _kInkSoft)),
              ),
            ),
          ]),
          footer: Row(children: <Widget>[
            _navItem(Icons.home, 'Home', selected: true),
            _navItem(Icons.search, 'Search'),
            _navItem(Icons.notifications_none, 'Alerts'),
            _navItem(Icons.person_outline, 'Me'),
          ]),
        ),
        const SizedBox(height: 14.0),
        _chromeFrame(
          accent: _kWindowsTeal, radius: 10.0, header: _windowsTitleBar(),
          body: Row(children: <Widget>[
            _winButton('Primary', _kWindowsTeal, true),
            const SizedBox(width: 8.0),
            _winButton('Secondary', _kWindowsTeal, false),
            const Spacer(),
            const Icon(Icons.info_outline, size: 16.0, color: _kInkMuted),
          ]),
        ),
        const SizedBox(height: 14.0),
        _chromeFrame(
          accent: _kMacSilver, radius: 10.0, header: _macTitleBar(),
          body: Row(children: <Widget>[
            const Icon(Icons.folder, color: Color(0xFF60A5FA), size: 28.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('Projects', style: TextStyle(
                    fontSize: 13.0, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.0),
                  Text('12 items', style: TextStyle(
                    fontSize: 11.0, color: _kInkMuted)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _kInkMuted),
          ]),
        ),
      ],
    ),
  );
}

Widget _chromeFrame({
  required Color accent,
  required double radius,
  required Widget header,
  required Widget body,
  Widget? footer,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(radius)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        header,
        Padding(padding: const EdgeInsets.all(14.0), child: body),
        if (footer != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius))),
            child: footer,
          ),
      ],
    ),
  );
}

Widget _iosNavBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF9FAFB),
      border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.08))),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
    child: Row(children: const <Widget>[
      Icon(Icons.arrow_back_ios, color: _kIosBlue, size: 18.0),
      Text(' Back', style: TextStyle(color: _kIosBlue, fontSize: 14.0)),
      Spacer(),
      Text('iOS Chrome', style: TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w600, color: _kInk)),
      Spacer(),
      Icon(Icons.ios_share, color: _kIosBlue, size: 20.0),
    ]),
  );
}

Widget _iosCell(String label, IconData icon) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: _kIosBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: <Widget>[
        Icon(icon, color: _kIosBlue, size: 22.0),
        const SizedBox(height: 4.0),
        Text(label, style: const TextStyle(
          fontSize: 11.0, color: _kInk, fontWeight: FontWeight.w600)),
      ]),
    ),
  );
}

Widget _androidTopBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
    decoration: const BoxDecoration(
      color: Color(0xFFE7F8EE),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
    child: Row(children: const <Widget>[
      Icon(Icons.menu, color: _kInk, size: 22.0),
      SizedBox(width: 12.0),
      Expanded(child: Text('Android Chrome', style: TextStyle(
        fontSize: 17.0, fontWeight: FontWeight.w600, color: _kInk))),
      Icon(Icons.search, color: _kInk, size: 22.0),
      SizedBox(width: 12.0),
      Icon(Icons.more_vert, color: _kInk, size: 22.0),
    ]),
  );
}

Widget _navItem(IconData icon, String label, {bool selected = false}) {
  return Expanded(
    child: Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: selected ? _kAndroidGreen.withValues(alpha: 0.22) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(icon, size: 18.0,
          color: selected ? _shade(_kAndroidGreen, 0.4) : _kInkSoft),
      ),
      const SizedBox(height: 2.0),
      Text(label, style: TextStyle(
        fontSize: 10.0, color: selected ? _kInk : _kInkMuted,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
    ]),
  );
}

Widget _windowsTitleBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: const BoxDecoration(
      color: Color(0xFFF3F4F6),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
    child: Row(children: const <Widget>[
      Icon(Icons.window, color: _kWindowsTeal, size: 14.0),
      SizedBox(width: 8.0),
      Text('Windows Chrome — mock title bar',
        style: TextStyle(fontSize: 11.5, color: _kInk)),
      Spacer(),
      Icon(Icons.minimize, size: 12.0, color: Color(0xFF6B7280)),
      SizedBox(width: 8.0),
      Icon(Icons.crop_square, size: 12.0, color: Color(0xFF6B7280)),
      SizedBox(width: 8.0),
      Icon(Icons.close, size: 12.0, color: Color(0xFFEF4444)),
    ]),
  );
}

Widget _winButton(String label, Color color, bool primary) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: primary ? color : Colors.white,
      border: primary ? null : Border.all(color: const Color(0xFFCBD5E1)),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Text(label, style: TextStyle(
      color: primary ? Colors.white : _kInk, fontSize: 11.5,
      fontWeight: primary ? FontWeight.w600 : FontWeight.normal)),
  );
}

Widget _macTitleBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFECECEC), Color(0xFFDADADA)],
        begin: Alignment.topCenter, end: Alignment.bottomCenter),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
    child: Row(children: const <Widget>[
      _ChromeDot(color: Color(0xFFFF5F57)), SizedBox(width: 8.0),
      _ChromeDot(color: Color(0xFFFEBC2E)), SizedBox(width: 8.0),
      _ChromeDot(color: Color(0xFF28C840)),
      Spacer(),
      Text('macOS Chrome', style: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: _kInk)),
      Spacer(),
      SizedBox(width: 60.0),
    ]),
  );
}

// ============================================================
// SECTION 8: Theme.platform overrides
// ============================================================
Widget _section8Title() => _sectionTitle('8', 'Theme.platform override examples', 'Force a different platform feel inside MaterialApp', _kFuchsiaPink);

Widget _themePlatformOverrides() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: <Widget>[
        _overrideCard(
          title: 'Material app, forced to look iOS-flavoured',
          code: '''MaterialApp(
  theme: ThemeData(
    platform: TargetPlatform.iOS,   // <-- override
    useMaterial3: true,
  ),
  home: const HomeScreen(),
);''',
          explanation: 'Page routes become Cupertino-style slides, scroll physics '
            'become bouncing, and selection handles become iOS pins. '
            'Useful for cross-platform screenshots.',
          color: _kIosBlue,
        ),
        const SizedBox(height: 12.0),
        _overrideCard(
          title: 'CupertinoApp wrapping Material widgets',
          code: '''CupertinoApp(
  home: Material(
    type: MaterialType.transparency,
    child: HomeScreen(),
  ),
);''',
          explanation: 'Inverse trick: an iOS-by-default app shell with Material '
            'widgets nested inside (e.g. for a richer text input or navigation rail).',
          color: _kFuchsiaPink,
        ),
        const SizedBox(height: 12.0),
        _overrideCard(
          title: 'Per-test override (for golden tests)',
          code: '''testWidgets('renders the same on every host', (tester) async {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  await tester.pumpWidget(const MyApp());
  // ... expect calls ...
  debugDefaultTargetPlatformOverride = null;  // reset!
});''',
          explanation: 'Always reset the override in tearDown — leaving it set '
            'pollutes the next test. Pair with addTearDown(...) for safety.',
          color: _kWarn,
        ),
      ],
    ),
  );
}

Widget _overrideCard({
  required String title,
  required String code,
  required String explanation,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(width: 4.0, height: 18.0, decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(2.0))),
          const SizedBox(width: 8.0),
          Expanded(child: Text(title, style: const TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: _kInk))),
        ]),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1021),
            borderRadius: BorderRadius.circular(8.0)),
          child: Text(code, style: const TextStyle(
            color: Color(0xFFE5E7EB), fontFamily: 'monospace',
            fontSize: 11.5, height: 1.5)),
        ),
        const SizedBox(height: 8.0),
        Text(explanation, style: const TextStyle(
          fontSize: 12.0, color: _kInkSoft, height: 1.45)),
      ],
    ),
  );
}

// ============================================================
// SECTION 9: Pitfalls
// ============================================================
Widget _section9Title() => _sectionTitle('9', 'Pitfalls and footguns', 'Mistakes the rest of us already made', _kDanger);

Widget _pitfallsList() {
  const List<List<String>> items = <List<String>>[
    <String>['Importing dart:io on web',
      'A bare `import \'dart:io\';` will crash dart2js/dart2wasm at compile '
      'time. Use conditional imports or guard with kIsWeb and route '
      'native code through a separate file.'],
    <String>['defaultTargetPlatform in tests differs from production',
      'Widget tests default to TargetPlatform.android regardless of the '
      'host. Set `debugDefaultTargetPlatformOverride` (and reset it in '
      'tearDown) to test platform-adaptive paths explicitly.'],
    <String>['Platform-keyed asset paths without web fallback',
      'Switching on defaultTargetPlatform alone returns one of six values — '
      'but you may be running on web. Check kIsWeb first, then branch on '
      'the host platform inside.'],
    <String>['Layering Cupertino on top of Material on top of Cupertino',
      'Nesting CupertinoApp inside MaterialApp inside CupertinoApp leads to '
      'duplicate Directionality, double scaffolds, and confused selection '
      'controls. Pick one shell at the root and nest individual widgets.'],
    <String>['BuildContext-vs-static confusion',
      'defaultTargetPlatform is global; Theme.of(context).platform is local. '
      'Adapting a deeply nested widget? Use Theme.of so theme overrides '
      'are respected.'],
    <String>['Stale TargetPlatform after orientation/Theme change',
      'If you read defaultTargetPlatform once at app startup into a static '
      'variable, hot-reload that toggles the override will not update '
      'your cached copy. Read it lazily in build(), or via Theme.of.'],
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: <Widget>[
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _pitfallTile('${i + 1}', items[i][0], items[i][1]),
          ),
      ],
    ),
  );
}

Widget _pitfallTile(String number, String title, String body) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(left: BorderSide(color: _kDanger, width: 4.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30.0, height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kDanger.withValues(alpha: 0.15), shape: BoxShape.circle),
          child: Text(number, style: const TextStyle(
            color: _kDanger, fontWeight: FontWeight.bold, fontSize: 14.0)),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(
                fontSize: 13.5, fontWeight: FontWeight.bold, color: _kInk)),
              const SizedBox(height: 4.0),
              Text(body, style: const TextStyle(
                fontSize: 12.0, color: _kInkSoft, height: 1.45)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// SECTION 10: Decision tree
// ============================================================
Widget _section10Title() => _sectionTitle('10', 'Decision tree', 'When to use which detector', _kAccentDeep);

Widget _decisionTree() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360.0,
          child: CustomPaint(
            painter: _DecisionTreePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _legendChip('kIsWeb', _kSuccess),
            _legendChip('defaultTargetPlatform', _kAccent),
            _legendChip('Theme.of(context).platform', _kWarn),
            _legendChip('Platform.is* (dart:io)', _kDanger),
          ],
        ),
      ],
    ),
  );
}

Widget _legendChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.35)),
    ),
    child: Text(text, style: TextStyle(
      fontSize: 10.5, color: color,
      fontWeight: FontWeight.w600, fontFamily: 'monospace')),
  );
}

class _DecisionTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _kInkMuted.withValues(alpha: 0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final Paint fillRoot = Paint()..color = _kAccentDeep;
    final Paint fillWeb = Paint()..color = _kSuccess;
    final Paint fillDtp = Paint()..color = _kAccent;
    final Paint fillTheme = Paint()..color = _kWarn;
    final Paint fillIo = Paint()..color = _kDanger;
    final double cx = size.width / 2.0;

    void node(Offset c, double r, Paint p, String label, String subtitle) {
      canvas.drawCircle(c, r, p);
      final TextPainter tp = TextPainter(
        text: TextSpan(children: <InlineSpan>[
          TextSpan(text: label, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0)),
          const TextSpan(text: '\n'),
          TextSpan(text: subtitle, style: const TextStyle(
            color: Colors.white70, fontSize: 9.0)),
        ]),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout(maxWidth: r * 2.0);
      tp.paint(canvas, Offset(c.dx - tp.width / 2.0, c.dy - tp.height / 2.0));
    }

    final Offset root = Offset(cx, 30.0);
    final Offset webYes = Offset(cx - 130.0, 130.0);
    final Offset webNo = Offset(cx + 130.0, 130.0);
    final Offset themeLeaf = Offset(cx + 50.0, 250.0);
    final Offset dtpLeaf = Offset(cx + 200.0, 250.0);
    final Offset ioLeaf = Offset(cx + 125.0, 330.0);
    final Offset webOnly = Offset(cx - 130.0, 250.0);

    canvas.drawLine(root, webYes, line);
    canvas.drawLine(root, webNo, line);
    canvas.drawLine(webYes, webOnly, line);
    canvas.drawLine(webNo, themeLeaf, line);
    canvas.drawLine(webNo, dtpLeaf, line);
    canvas.drawLine(dtpLeaf, ioLeaf, line);

    void edgeLabel(Offset a, Offset b, String text, Color color) {
      final Offset m = Offset((a.dx + b.dx) / 2.0, (a.dy + b.dy) / 2.0);
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text, style: TextStyle(
          color: color, fontSize: 10.0,
          fontWeight: FontWeight.bold, backgroundColor: Colors.white)),
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(m.dx - tp.width / 2.0, m.dy - tp.height / 2.0));
    }

    node(root, 36.0, fillRoot, 'where?', 'start');
    node(webYes, 32.0, fillWeb, 'kIsWeb', 'true');
    node(webNo, 32.0, fillWeb, 'kIsWeb', 'false');
    node(webOnly, 30.0, fillWeb, 'web', 'fallback');
    node(themeLeaf, 30.0, fillTheme, 'Theme', 'in build');
    node(dtpLeaf, 30.0, fillDtp, 'default', 'TP');
    node(ioLeaf, 28.0, fillIo, 'dart:io', 'native');
    edgeLabel(root, webYes, 'yes', _kSuccess);
    edgeLabel(root, webNo, 'no', _kInkSoft);
    edgeLabel(webNo, themeLeaf, 'inside widget', _kWarn);
    edgeLabel(webNo, dtpLeaf, 'top level', _kAccent);
    edgeLabel(dtpLeaf, ioLeaf, 'fine-grained?', _kDanger);
  }

  @override
  bool shouldRepaint(_DecisionTreePainter oldDelegate) => false;
}

// ============================================================
// SECTION 11: Cheat sheet footer
// ============================================================
Widget _section11Title() => _sectionTitle('11', 'Cheat sheet', 'The whole platform API surface in one card', _kInk);

Widget _cheatSheet() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF1F2937)],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Platform API at a glance', style: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold,
          color: Colors.white, letterSpacing: 0.5)),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0, runSpacing: 8.0,
          children: <Widget>[
            _cheatChip('TargetPlatform', 'enum (6)', const Color(0xFF60A5FA)),
            _cheatChip('.android', 'index 0', _kAndroidGreen),
            _cheatChip('.fuchsia', 'index 1', _kFuchsiaPink),
            _cheatChip('.iOS', 'index 2', _kIosBlue),
            _cheatChip('.linux', 'index 3', _kLinuxOrange),
            _cheatChip('.macOS', 'index 4', _kMacSilver),
            _cheatChip('.windows', 'index 5', _kWindowsTeal),
            _cheatChip('defaultTargetPlatform', 'top-level getter', const Color(0xFFA78BFA)),
            _cheatChip('kIsWeb', 'compile-time const', _kSuccess),
            _cheatChip('kIsWasm', 'wasm only', _kSuccess),
            _cheatChip('Theme.of(ctx).platform', 'context-aware', _kWarn),
            _cheatChip('debugDefaultTargetPlatformOverride', 'test hook', _kDanger),
            _cheatChip('Platform.operatingSystem', 'dart:io (native)', const Color(0xFFFB923C)),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white12),
          ),
          child: const Text(
            'Rules of thumb:\n'
            '  • kIsWeb first, always.\n'
            '  • defaultTargetPlatform for app-shell decisions before context.\n'
            '  • Theme.of(context).platform for everything inside MaterialApp.\n'
            '  • dart:io Platform.* only after a kIsWeb guard (or a conditional import).\n'
            '  • Reset debugDefaultTargetPlatformOverride in test tearDowns.',
            style: TextStyle(
              color: Colors.white, fontSize: 12.0,
              fontFamily: 'monospace', height: 1.6),
          ),
        ),
      ],
    ),
  );
}

Widget _cheatChip(String label, String tag, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 11.0, fontFamily: 'monospace',
          color: color, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(tag, style: const TextStyle(fontSize: 9.5, color: Colors.white70)),
        ),
      ],
    ),
  );
}

Widget _footerTagline() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kInkMuted.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.menu_book, color: _kAccent, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'D4rt deep visual demo • TargetPlatform • '
            'rendered ${DateTime.fromMillisecondsSinceEpoch(0).year} → today • '
            '${TargetPlatform.values.length} enum values × 3 detection layers',
            style: const TextStyle(
              fontSize: 11.5, color: _kInkSoft, fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text('pi=${math.pi.toStringAsFixed(3)}', style: const TextStyle(
            fontSize: 10.5, color: _kAccentDeep,
            fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
