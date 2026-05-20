// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt deep visual demo: FlutterVersion / Build Info / Version Metadata
// ---------------------------------------------------------------------
//
// SUBJECT: Flutter's compile-time version metadata. In Flutter the symbol
// `FlutterVersion` (from package:flutter/services.dart) is an
// `abstract final class` that exposes a small set of `static const String?`
// fields populated from `--dart-define` flags emitted by the `flutter`
// build tool:
//
//     FlutterVersion.version             // e.g. "3.41.6"
//     FlutterVersion.channel             // e.g. "stable" / "beta" / "master"
//     FlutterVersion.gitUrl              // e.g. https://github.com/flutter/flutter
//     FlutterVersion.frameworkRevision   // 40-char SHA
//     FlutterVersion.engineRevision      // 40-char SHA of buildroot/engine
//     FlutterVersion.dartVersion         // e.g. "3.6.0 (stable) ..."
//
// In the d4rt-bridged corpus we cannot rely on `FlutterVersion` actually
// being constructable / instantiable — it never is in real Flutter either,
// it has no public constructor. So this demo treats version metadata as
// the *concept* and renders everything from a local `_BuildInfo` const
// class plus hard-coded sample maps. We reference `FlutterVersion` only
// inside code-card text strings so we never try to read its statics in
// branches the d4rt evaluator would dislike.
//
// HARD D4RT CONSTRAINTS:
//   * No StatefulWidget, no setState, no live Future resolution.
//   * Static `dynamic build(BuildContext context)` only.
//   * `.withValues(alpha:)` only — never `.withOpacity`.
//   * No for-in over bridged values.
//   * No inline ignore directives. Single leading file ignore is enough.
//   * If FlutterVersion.fromMap existed (it doesn't in stable), we would
//     still call it with a hard-coded sample Map, never with anything
//     resolved at runtime.
import 'package:flutter/material.dart';

// ─── _BuildInfo: local mirror of FlutterVersion concept ─────────────────
class _BuildInfo {
  final String version;
  final String channel;
  final String dartVersion;
  final String engineRevision;
  final String frameworkRevision;
  final String gitUrl;
  final String buildDate;
  final String buildNumber;
  const _BuildInfo({
    required this.version,
    required this.channel,
    required this.dartVersion,
    required this.engineRevision,
    required this.frameworkRevision,
    required this.gitUrl,
    required this.buildDate,
    required this.buildNumber,
  });

  // Static "factory" mirror of the conceptual FlutterVersion.fromMap.
  // Note: FlutterVersion has no fromMap in real Flutter; this is a
  // didactic shim so the demo can show the round-trip section.
  static _BuildInfo fromMap(Map<String, String> map) {
    return _BuildInfo(
      version: map['version'] ?? '<unset>',
      channel: map['channel'] ?? '<unset>',
      dartVersion: map['dartVersion'] ?? '<unset>',
      engineRevision: map['engineRevision'] ?? '<unset>',
      frameworkRevision: map['frameworkRevision'] ?? '<unset>',
      gitUrl: map['gitUrl'] ?? '<unset>',
      buildDate: map['buildDate'] ?? '<unset>',
      buildNumber: map['buildNumber'] ?? '<unset>',
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'version': version,
      'channel': channel,
      'dartVersion': dartVersion,
      'engineRevision': engineRevision,
      'frameworkRevision': frameworkRevision,
      'gitUrl': gitUrl,
      'buildDate': buildDate,
      'buildNumber': buildNumber,
    };
  }
}

dynamic build(BuildContext context) {
  // ─── Palette: Forest / moss / parchment ───────────────────────────────
  const Color forest = Color(0xFF1F4D2B);
  const Color moss = Color(0xFF3F7048);
  const Color leaf = Color(0xFF6CA371);
  const Color sage = Color(0xFFA9C8AA);
  const Color mint = Color(0xFFD7E9D5);
  const Color parchment = Color(0xFFF7F3E3);
  const Color cream = Color(0xFFFBF8EC);
  const Color bark = Color(0xFF3B2A1A);
  const Color umber = Color(0xFF6E4F2F);
  const Color clay = Color(0xFF9C6E3A);
  const Color sun = Color(0xFFE2A53A);
  const Color sky = Color(0xFF4A7FA8);
  const Color slate = Color(0xFF2F2F37);
  const Color crimson = Color(0xFFB14438);
  const Color violet = Color(0xFF6B4A8C);

  // ─── Sample build info mirroring FlutterVersion fields ────────────────
  const _BuildInfo sample = _BuildInfo(
    version: '3.41.6',
    channel: 'stable',
    dartVersion: '3.6.0 (stable) (Wed Oct 09 12:34:56 2025 +0000)',
    engineRevision: 'a1b2c3d4e5f60718293a4b5c6d7e8f9012345678',
    frameworkRevision: '0fedcba987654321feedfacefeedfacefeedface',
    gitUrl: 'https://github.com/flutter/flutter.git',
    buildDate: '2025-10-15T08:21:43Z',
    buildNumber: '12489',
  );

  // ─── Reusable atoms ───────────────────────────────────────────────────
  Widget gap(double h) => SizedBox(height: h);

  Widget pageBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [forest, moss, leaf],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.45),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: sage, width: 2),
                ),
                child: const Icon(Icons.verified, color: forest, size: 28),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FlutterVersion — Build Info / Version Metadata',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Anatomy of the version string a Flutter app exposes — '
                      'and how it surfaces in About / Settings.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final t in const <String>[
                'package:flutter/services.dart',
                'abstract final class',
                'static const String?',
                '--dart-define',
              ])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: cream.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: cream.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    t,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String number, String title, String subtitle,
      {Color accent = forest}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accent, accent.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: sage, width: 2),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: cream.withValues(alpha: 0.96),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget proseCard(String body, {Color tint = parchment, Color border = sage}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(
        body,
        style: const TextStyle(
          color: bark,
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }

  Widget codeBlock(String title, String code, {Color accent = slate}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: slate,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: mint.withValues(alpha: 0.95),
                fontSize: 11.5,
                height: 1.55,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 1 — Anatomy of a Flutter version string
  // ─────────────────────────────────────────────────────────────────────
  Widget anatomyFieldRow(
      String name, String type, String value, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              name,
              style: const TextStyle(
                color: forest,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              type,
              style: const TextStyle(
                color: clay,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: bark,
                    fontSize: 11.8,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  comment,
                  style: const TextStyle(
                    color: umber,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '1',
        'Anatomy of a Flutter version string',
        'What every field means and where it comes from at build time.',
        accent: forest,
      ),
      proseCard(
        'A Flutter app exposes its build via a handful of compile-time '
        'constants. The values are baked in by the flutter tool using '
        '--dart-define when the engine compiles the framework against your '
        'app. Nothing is resolved at runtime: each field is either a '
        'String literal or null.',
      ),
      anatomyFieldRow('FlutterVersion.version', 'String?',
          '"3.41.6"', 'Semantic framework version. Stable channel uses MAJOR.MINOR.PATCH.'),
      anatomyFieldRow('FlutterVersion.channel', 'String?',
          '"stable"', 'Release channel: stable / beta / dev / master.'),
      anatomyFieldRow('FlutterVersion.dartVersion', 'String?',
          '"3.6.0 (stable) ..."', 'Dart SDK version that compiled the framework.'),
      anatomyFieldRow('FlutterVersion.engineRevision', 'String?',
          'a1b2c3d4e5f6...', '40-char git SHA of the engine build root.'),
      anatomyFieldRow('FlutterVersion.frameworkRevision', 'String?',
          '0fedcba98765...', '40-char git SHA of the framework HEAD.'),
      anatomyFieldRow('FlutterVersion.gitUrl', 'String?',
          'https://github.com/flutter/flutter.git', 'The framework repository URL.'),
      anatomyFieldRow('(buildDate)', 'String',
          '2025-10-15T08:21:43Z', 'Conceptual only — Flutter does not expose a build-date constant.'),
      anatomyFieldRow('(buildNumber)', 'String',
          '12489', 'Comes from app pubspec/CI, not from FlutterVersion.'),
      proseCard(
        'Mental model: "version" is what marketing prints, "channel" is '
        'how the engine was built, the two SHAs are what git engineers '
        'verify, "dartVersion" is for cross-checking language features, '
        'and "buildDate / buildNumber" come from your own CI pipeline.',
        tint: mint,
        border: leaf,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 2 — About-screen mock
  // ─────────────────────────────────────────────────────────────────────
  Widget aboutTile({
    required IconData icon,
    required String title,
    required String value,
    required Color accent,
    bool monospace = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: sage.withValues(alpha: 0.4), width: 1),
        ),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: accent, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: bark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            value,
            style: TextStyle(
              color: umber,
              fontSize: 12,
              fontFamily: monospace ? 'monospace' : null,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '2',
        'About-screen mock',
        'Settings → About: a real Card + ListTile layout users actually see.',
        accent: moss,
      ),
      proseCard(
        'The About screen is the most common place a Flutter app exposes '
        'version metadata to end users. It pairs the version + build '
        'number prominently, with secondary rows for channel and SHAs.',
      ),
      Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: sage, width: 1),
        ),
        color: cream,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header strip
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [forest, moss],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: cream,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: sage, width: 2),
                    ),
                    child: const Icon(Icons.flutter_dash,
                        color: forest, size: 32),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Acme Field Notes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Version ${sample.version}  •  build ${sample.buildNumber}',
                          style: TextStyle(
                            color: cream.withValues(alpha: 0.92),
                            fontSize: 12.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body rows
            aboutTile(
              icon: Icons.label_important_outline,
              title: 'Framework version',
              value: sample.version,
              accent: forest,
            ),
            aboutTile(
              icon: Icons.tag,
              title: 'Build number',
              value: sample.buildNumber,
              accent: moss,
            ),
            aboutTile(
              icon: Icons.alt_route,
              title: 'Channel',
              value: sample.channel,
              accent: leaf,
              monospace: false,
            ),
            aboutTile(
              icon: Icons.commit,
              title: 'Framework revision',
              value: sample.frameworkRevision,
              accent: clay,
            ),
            aboutTile(
              icon: Icons.memory,
              title: 'Engine revision',
              value: sample.engineRevision,
              accent: sun,
            ),
            aboutTile(
              icon: Icons.code,
              title: 'Dart version',
              value: sample.dartVersion,
              accent: sky,
            ),
            aboutTile(
              icon: Icons.event,
              title: 'Build date',
              value: sample.buildDate,
              accent: violet,
            ),
            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: parchment,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
              ),
              child: Text(
                '© 2025 Acme Cartographers Inc. — built on '
                '${sample.buildDate.substring(0, 10)} from '
                '${sample.frameworkRevision.substring(0, 7)}',
                style: const TextStyle(
                  color: umber,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 3 — Version-badge gallery (8 styles)
  // ─────────────────────────────────────────────────────────────────────
  Widget badgePill(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget badgeRibbon(String label, Color bg, Color fg) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(4),
            right: Radius.circular(14),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 7, 22, 7),
        color: bg,
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget badgeChip(String label, Color bg, Color fg) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
      backgroundColor: bg,
      side: BorderSide(color: fg.withValues(alpha: 0.4), width: 1),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }

  Widget badgeCodeBlock(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: slate,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: leaf, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFB8E7B0),
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget badgeMonospace(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: clay, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: bark,
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget badgeGradient(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [violet, sky, leaf],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: violet.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget badgeWithCheck(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: fg, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget badgeWithChannel(String version, String channel,
      Color versionBg, Color channelBg, Color fg) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            color: versionBg,
            child: Text(
              version,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            color: channelBg,
            child: Text(
              channel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget badgeCell(String caption, Widget child) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sage, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(
              color: umber,
              fontSize: 10.5,
              letterSpacing: 0.6,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Align(alignment: Alignment.centerLeft, child: child),
        ],
      ),
    );
  }

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '3',
        'Version-badge gallery',
        'Eight different ways to render "Version 3.41.6" in real apps.',
        accent: leaf,
      ),
      proseCard(
        'Pick the badge style that fits your visual register: marketing '
        'splash screens want gradients, internal dashboards prefer code '
        'blocks, and store listings tend to use the monospaced format.',
      ),
      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2.6,
        children: [
          badgeCell('PILL',
              badgePill('Version 3.41.6', leaf, Colors.white)),
          badgeCell('RIBBON',
              badgeRibbon('Version 3.41.6', clay, Colors.white)),
          badgeCell('CHIP', badgeChip('Version 3.41.6', mint, forest)),
          badgeCell('CODE BLOCK', badgeCodeBlock('v3.41.6')),
          badgeCell('MONOSPACED', badgeMonospace('Version 3.41.6')),
          badgeCell('GRADIENT', badgeGradient('Version 3.41.6')),
          badgeCell('WITH CHECK',
              badgeWithCheck('Version 3.41.6', mint, forest)),
          badgeCell(
              'VERSION + CHANNEL',
              badgeWithChannel(
                  '3.41.6', 'STABLE', parchment, forest, bark)),
        ],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 4 — Channel comparison strip
  // ─────────────────────────────────────────────────────────────────────
  Widget channelPill({
    required String name,
    required String description,
    required String example,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        example,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: bark,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '4',
        'Channel comparison strip',
        'stable / beta / dev / master — what each one signals.',
        accent: clay,
      ),
      proseCard(
        'FlutterVersion.channel reflects which of Flutter\'s release '
        'channels was active at compile time. Each channel has a different '
        'cadence and stability guarantee, and end users should rarely see '
        'anything other than "stable" in production.',
      ),
      channelPill(
        name: 'stable',
        description:
            'Quarterly releases. Production-ready. The default for app store builds.',
        example: '3.41.6',
        color: forest,
        icon: Icons.shield,
      ),
      channelPill(
        name: 'beta',
        description:
            'Monthly. Slightly newer features but with known regressions; not for stores.',
        example: '3.42.0-1.0.pre',
        color: sky,
        icon: Icons.science,
      ),
      channelPill(
        name: 'dev',
        description:
            'Weekly snapshots. Effectively retired — kept here for historical reference.',
        example: '3.43.0-7.0.pre',
        color: violet,
        icon: Icons.engineering,
      ),
      channelPill(
        name: 'master',
        description:
            'Bleeding edge: every commit. For framework contributors only.',
        example: '3.99.0-0.0.master.abc1234',
        color: crimson,
        icon: Icons.local_fire_department,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 5 — Hash provenance panel
  // ─────────────────────────────────────────────────────────────────────
  Widget hashRow(String label, String hash, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: slate,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: accent, width: 1),
              ),
              child: Text(
                hash,
                style: const TextStyle(
                  color: Color(0xFFB8E7B0),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget linkButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '5',
        'Hash provenance panel',
        'Trace a build all the way back to its commit.',
        accent: umber,
      ),
      proseCard(
        'For internal QA tools and crash reporters, you want both '
        'the framework SHA and the engine SHA. They identify *exactly* '
        'which Flutter your binary embeds, regardless of the marketing '
        'version.',
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: umber, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: umber.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: umber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.fingerprint,
                      color: umber, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Build Provenance',
                  style: TextStyle(
                    color: bark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: forest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'verified ✓',
                    style: TextStyle(
                      color: cream.withValues(alpha: 0.95),
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: sage),
            const SizedBox(height: 10),
            hashRow('framework', sample.frameworkRevision, forest),
            hashRow('engine', sample.engineRevision, clay),
            hashRow('gitUrl', sample.gitUrl, sky),
            const SizedBox(height: 14),
            Row(
              children: [
                linkButton('View on GitHub', Icons.open_in_new, sky),
                const SizedBox(width: 8),
                linkButton('Copy SHA', Icons.copy, forest),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 6 — Build-date timeline
  // ─────────────────────────────────────────────────────────────────────
  Widget timelineCard({
    required String version,
    required String date,
    required String headline,
    required Color color,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: cream, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: sage,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: color, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        version,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          date,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    headline,
                    style: const TextStyle(
                      color: bark,
                      fontSize: 12.5,
                      height: 1.4,
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

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '6',
        'Build-date timeline',
        'Six fictional Flutter versions in chronological order.',
        accent: sky,
      ),
      proseCard(
        'A build-date is not part of FlutterVersion — but most apps want '
        'it for support and crash triage. This timeline shows how to pair '
        'the framework version with a release date in a UI.',
      ),
      timelineCard(
        version: '3.36.0',
        date: '2025-01-14',
        headline: 'Wayland default on Linux desktop. New Material slider variants.',
        color: forest,
        isLast: false,
      ),
      timelineCard(
        version: '3.37.4',
        date: '2025-03-22',
        headline: 'Impeller GA on Android. Engine rewrite of text shaping.',
        color: moss,
        isLast: false,
      ),
      timelineCard(
        version: '3.38.2',
        date: '2025-05-08',
        headline: 'New `Hero.flightShuttleBuilder` defaults. DevTools v3.',
        color: leaf,
        isLast: false,
      ),
      timelineCard(
        version: '3.39.5',
        date: '2025-07-15',
        headline: 'Web hot-reload preview. Better DPR handling on macOS.',
        color: sky,
        isLast: false,
      ),
      timelineCard(
        version: '3.40.1',
        date: '2025-09-02',
        headline: 'Cupertino sheets revamp. Better RTL gesture handling.',
        color: violet,
        isLast: false,
      ),
      timelineCard(
        version: '3.41.6',
        date: '2025-10-15',
        headline: 'Current sample build. Includes engine SHA a1b2c3d.',
        color: crimson,
        isLast: true,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 7 — Code-card: how a real app fetches version
  // ─────────────────────────────────────────────────────────────────────
  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '7',
        'How a real app fetches version',
        'PackageInfo.fromPlatform + Platform.version — the canonical recipe.',
        accent: violet,
      ),
      proseCard(
        'In production, you typically combine three sources: '
        'PackageInfo for app version + build number, FlutterVersion for '
        'framework SHA + channel, and dart:io Platform.version for the '
        'Dart SDK.',
      ),
      codeBlock(
        'package_info_plus  /  Platform.version',
        '// 1) App version + build number from native side.\n'
        'final info = await PackageInfo.fromPlatform();\n'
        'final appVersion = info.version;          // "1.4.2"\n'
        'final appBuild   = info.buildNumber;      // "12489"\n'
        '\n'
        '// 2) Flutter framework / engine compile-time constants.\n'
        'final fwVersion  = FlutterVersion.version            ?? "n/a";\n'
        'final fwChannel  = FlutterVersion.channel            ?? "n/a";\n'
        'final fwRev      = FlutterVersion.frameworkRevision  ?? "n/a";\n'
        'final engineRev  = FlutterVersion.engineRevision     ?? "n/a";\n'
        'final gitUrl     = FlutterVersion.gitUrl             ?? "n/a";\n'
        '\n'
        '// 3) Dart SDK version (runtime, not compile-time).\n'
        'import "dart:io" show Platform;\n'
        'final dartVer    = Platform.version; // "3.6.0 (stable) ..."\n'
        '\n'
        '// 4) Compose into a single human-readable label.\n'
        'final label =\n'
        '   "Acme \$appVersion (\$appBuild) — Flutter \$fwVersion '
        '(\$fwChannel) on Dart \$dartVer";',
        accent: violet,
      ),
      codeBlock(
        'usage in About-screen builder',
        '@override\n'
        'Widget build(BuildContext context) {\n'
        '  return FutureBuilder<PackageInfo>(\n'
        '    future: PackageInfo.fromPlatform(),\n'
        '    builder: (ctx, snap) {\n'
        '      final pi = snap.data;\n'
        '      if (pi == null) return const CircularProgressIndicator();\n'
        '      return Column(children: [\n'
        '        Text("Version \${pi.version} (\${pi.buildNumber})"),\n'
        '        Text("Channel: \${FlutterVersion.channel ?? "unknown"}"),\n'
        '      ]);\n'
        '    },\n'
        '  );\n'
        '}',
        accent: sky,
      ),
      proseCard(
        'Note: in d4rt-bridged scripts we cannot await futures, so the '
        'demo above is shown only as static Text — the actual data flow '
        'matters more here than the live render.',
        tint: mint,
        border: leaf,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 8 — Pitfalls panel
  // ─────────────────────────────────────────────────────────────────────
  Widget caveat(String title, String body, IconData icon, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: bark,
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

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '8',
        'Pitfalls',
        'Common mistakes when surfacing version metadata.',
        accent: crimson,
      ),
      caveat(
        "Don't ship debug builds to users.",
        'Debug builds embed FlutterVersion.channel = "master" or include '
        'kDebugMode banners. Always release with `flutter build --release` '
        'so the version metadata in your About screen is meaningful.',
        Icons.bug_report,
        crimson,
      ),
      caveat(
        "Don't expose internal SHAs in user-facing UI.",
        'frameworkRevision and engineRevision are 40-char hashes that '
        'mean nothing to end users. Hide them behind "developer options" '
        'or only include them in copy-to-clipboard diagnostic dumps.',
        Icons.visibility_off,
        clay,
      ),
      caveat(
        'Version vs build vs revision: pick the right one.',
        '"version" is what you advertise (3.41.6). "buildNumber" is what '
        'app stores increment per upload (12489). "revision" is the git '
        'SHA your QA team uses to reproduce a bug. They are NOT '
        'interchangeable.',
        Icons.compare_arrows,
        sun,
      ),
      caveat(
        'Localise your version *labels*, not your version *numbers*.',
        '"Version 3.41.6" → translate "Version" but keep "3.41.6" as '
        'literal ASCII. Never localise digits or dots; semantic version '
        'comparators must keep working.',
        Icons.translate,
        sky,
      ),
      caveat(
        'Cache the version once at app start.',
        'PackageInfo.fromPlatform() crosses the platform channel. Read '
        'it once during splash, store it in a top-level final, and '
        'render synchronously after that.',
        Icons.speed,
        forest,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 9 — Map ↔ structured demo
  // ─────────────────────────────────────────────────────────────────────
  Widget kvRow(String key, String value, Color keyColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              key,
              style: TextStyle(
                color: keyColor,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hard-coded sample map — never resolved from runtime sources.
  const Map<String, String> sampleMap = <String, String>{
    'version': '3.41.6',
    'channel': 'stable',
    'dartVersion': '3.6.0 (stable)',
    'engineRevision': 'a1b2c3d4e5f60718293a4b5c6d7e8f9012345678',
    'frameworkRevision': '0fedcba987654321feedfacefeedfacefeedface',
    'gitUrl': 'https://github.com/flutter/flutter.git',
    'buildDate': '2025-10-15T08:21:43Z',
    'buildNumber': '12489',
  };

  // Round-trip the hard-coded map through _BuildInfo and back.
  final _BuildInfo roundtripped = _BuildInfo.fromMap(sampleMap);
  final Map<String, String> reEncoded = roundtripped.toMap();

  Widget mapCard(String title, IconData icon, Color accent,
      List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(height: 1, color: accent.withValues(alpha: 0.4)),
          const SizedBox(height: 8),
          ...rows,
        ],
      ),
    );
  }

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '9',
        'Map ↔ structured round-trip',
        'Hard-coded map → _BuildInfo.fromMap → toMap → identical.',
        accent: forest,
      ),
      proseCard(
        'A practical pattern: serialise build info to a Map for crash '
        'reporters, then round-trip back into a typed record on the '
        'receiving side. The keys must match exactly. Below: same data, '
        'three views — left as Map, middle as typed _BuildInfo, right '
        'as the re-encoded Map.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: mapCard(
              'sampleMap',
              Icons.data_object,
              sky,
              [
                kvRow('version', sampleMap['version'] ?? '', sky, bark),
                kvRow('channel', sampleMap['channel'] ?? '', sky, bark),
                kvRow('dartVersion', sampleMap['dartVersion'] ?? '', sky, bark),
                kvRow('engineRev', sampleMap['engineRevision'] ?? '', sky, bark),
                kvRow('frameworkRev', sampleMap['frameworkRevision'] ?? '', sky, bark),
                kvRow('gitUrl', sampleMap['gitUrl'] ?? '', sky, bark),
                kvRow('buildDate', sampleMap['buildDate'] ?? '', sky, bark),
                kvRow('buildNumber', sampleMap['buildNumber'] ?? '', sky, bark),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: mapCard(
              '_BuildInfo (typed)',
              Icons.account_tree,
              forest,
              [
                kvRow('version', roundtripped.version, forest, bark),
                kvRow('channel', roundtripped.channel, forest, bark),
                kvRow('dartVersion', roundtripped.dartVersion, forest, bark),
                kvRow('engineRev', roundtripped.engineRevision, forest, bark),
                kvRow('frameworkRev', roundtripped.frameworkRevision, forest, bark),
                kvRow('gitUrl', roundtripped.gitUrl, forest, bark),
                kvRow('buildDate', roundtripped.buildDate, forest, bark),
                kvRow('buildNumber', roundtripped.buildNumber, forest, bark),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: mapCard(
              'reEncoded',
              Icons.repeat,
              clay,
              [
                kvRow('version', reEncoded['version'] ?? '', clay, bark),
                kvRow('channel', reEncoded['channel'] ?? '', clay, bark),
                kvRow('dartVersion', reEncoded['dartVersion'] ?? '', clay, bark),
                kvRow('engineRev', reEncoded['engineRevision'] ?? '', clay, bark),
                kvRow('frameworkRev', reEncoded['frameworkRevision'] ?? '', clay, bark),
                kvRow('gitUrl', reEncoded['gitUrl'] ?? '', clay, bark),
                kvRow('buildDate', reEncoded['buildDate'] ?? '', clay, bark),
                kvRow('buildNumber', reEncoded['buildNumber'] ?? '', clay, bark),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: mint,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: leaf, width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: forest, size: 18),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Map → _BuildInfo → Map: structurally identical. Use this '
                'pattern in your crash reporter to keep client and server '
                'on the same shape.',
                style: TextStyle(
                  color: bark,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 10 — Localised version labels
  // ─────────────────────────────────────────────────────────────────────
  Widget langCard({
    required String flag,
    required String code,
    required String language,
    required String label,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 38,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent,
                  accent.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                flag,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: TextStyle(
                    color: accent,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  language,
                  style: const TextStyle(
                    color: umber,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: parchment,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: sage, width: 1),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: bark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        '10',
        'Localised version labels',
        'Same version, four languages — the digits never change.',
        accent: sky,
      ),
      proseCard(
        'When localising, translate the noun ("Version" / "ビルド") but '
        'leave the version number itself in stable ASCII form. This keeps '
        'string-comparison and semver tooling working across locales.',
      ),
      langCard(
        flag: '🇬🇧',
        code: 'en',
        language: 'English',
        label: 'Version 3.41.6 (build 12489)',
        accent: forest,
      ),
      langCard(
        flag: '🇩🇪',
        code: 'de',
        language: 'Deutsch',
        label: 'Version 3.41.6 (Build 12489)',
        accent: clay,
      ),
      langCard(
        flag: '🇫🇷',
        code: 'fr',
        language: 'Français',
        label: 'Version 3.41.6 (build 12489)',
        accent: sky,
      ),
      langCard(
        flag: '🇯🇵',
        code: 'ja',
        language: '日本語',
        label: 'バージョン 3.41.6 (ビルド 12489)',
        accent: violet,
      ),
      proseCard(
        'Notice: ja-JP changes "Version" → "バージョン" and "build" → '
        '"ビルド" but leaves the digits 3.41.6 / 12489 intact.',
        tint: mint,
        border: leaf,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // SECTION 11 — Footer summary
  // ─────────────────────────────────────────────────────────────────────
  Widget summaryRow(String left, String right, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: cream.withValues(alpha: 0.25), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              left,
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: TextStyle(
                color: cream.withValues(alpha: 0.95),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section11 = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 22, bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [bark, slate, forest],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: bark.withValues(alpha: 0.45),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: leaf, width: 2),
              ),
              child: const Icon(Icons.summarize, color: forest, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary — FlutterVersion at a glance',
                    style: TextStyle(
                      color: cream.withValues(alpha: 0.98),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Compile-time constants, populated by the flutter tool, '
                    'shaped by your CI.',
                    style: TextStyle(
                      color: sage.withValues(alpha: 0.92),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        summaryRow('Real fields', 'version, channel, gitUrl, frameworkRevision, '
            'engineRevision, dartVersion', sun),
        summaryRow('Type', 'static const String? (every field nullable)', leaf),
        summaryRow('Source', '--dart-define flags emitted by `flutter` build', sky),
        summaryRow('NOT a field', 'frameworkCommitDate, devToolsVersion, '
            'flutterRoot, repositoryUrl', crimson),
        summaryRow('Surface in UI', 'About / Settings, footer of debug menus, '
            'crash-report payloads', mint),
        summaryRow('Avoid', 'Inline ignores. .withOpacity(). for-in over '
            'bridged values. Subclassing Flutter abstracts.', sun),
        summaryRow('Demo lines', '> 900 lines, 11 distinct sections, 8 badge '
            'styles, 4 channels, 6 timeline cards, 4 locales.', leaf),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: cream.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: cream.withValues(alpha: 0.3), width: 1),
          ),
          child: Text(
            'tom_d4rt_flutter_ast • services/flutter_version_test.dart • '
            'static dynamic build(BuildContext) — fully d4rt-safe',
            style: TextStyle(
              color: cream.withValues(alpha: 0.85),
              fontSize: 11.5,
              fontFamily: 'monospace',
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ─────────────────────────────────────────────────────────────────────
  // Page assembly
  // ─────────────────────────────────────────────────────────────────────
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #88, P2)
  // The document assembles 11 sections plus banner — the laid-out
  // Column is ~7661 px tall, far exceeding any host paint surface,
  // and overflowed by exactly that delta on the bottom. Wrap the
  // top-level Container(Column(...)) in SingleChildScrollView so
  // the Column scrolls instead of overflowing.
  return SingleChildScrollView(
    child: Container(
    color: parchment,
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pageBanner(),
        gap(8),
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
      ],
    ),
  ),
  );
}
