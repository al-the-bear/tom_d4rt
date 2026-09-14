// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Deep demo for: ApplicationSwitcherDescription
//   from: package:flutter/services.dart
//
// ApplicationSwitcherDescription is a small immutable value object that wraps
// the two pieces of metadata Android shows in the recents / app-switcher view:
//
//   - label:        Optional String shown under the app's thumbnail in the
//                   recents view. When null, the Android-supplied launcher
//                   label is used.
//   - primaryColor: Optional ARGB int (0xAARRGGBB) used to tint the small
//                   header bar above the thumbnail. When null Android falls
//                   back to its default tint.
//
// It is consumed by:
//
//   SystemChrome.setApplicationSwitcherDescription(
//     ApplicationSwitcherDescription(
//       label: 'My App',
//       primaryColor: 0xFF1565C0,
//     ),
//   );
//
// Behaviour by platform:
//
//   Android : Honoured. Calls ActivityManager.TaskDescription under the hood.
//   iOS     : No-op. iOS does not expose recents-card tinting via Flutter.
//   Web     : No-op.
//   Desktop : No-op (Windows / macOS / Linux).
//
// Typical call sites:
//
//   - At app start, right after the first frame settles.
//   - On theme / brightness changes (so the recents tint follows your theme).
//   - When the user changes locale, so the label is localized.
//
// This file is intentionally fully static: no Stateful, no Timer, no Future,
// no AnimationController, no setState. It paints a richly-decorated catalog
// page that explains the API and visualises a mock Android recents card with
// several label / colour combinations.
// ---------------------------------------------------------------------------

const Color _kBg = Color(0xFF0E141B);
const Color _kSurface = Color(0xFF18222D);
const Color _kSurfaceAlt = Color(0xFF223040);
const Color _kAccent = Color(0xFF4FC3F7);
const Color _kAccent2 = Color(0xFF7E57C2);
const Color _kAccent3 = Color(0xFFFFB74D);
const Color _kAccent4 = Color(0xFF81C784);
const Color _kAccent5 = Color(0xFFE57373);
const Color _kText = Color(0xFFE6EDF3);
const Color _kTextDim = Color(0xFF8B98A5);
const Color _kBorder = Color(0xFF2C3A4A);

// ---------------------------------------------------------------------------
// Top-level entry expected by the d4rt visual harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ApplicationSwitcherDescription Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBg,
      primaryColor: _kAccent,
      colorScheme: ColorScheme.dark(
        primary: _kAccent,
        secondary: _kAccent2,
        surface: _kSurface,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kText, fontSize: 14, height: 1.45),
        bodySmall: TextStyle(color: _kTextDim, fontSize: 12, height: 1.4),
        titleLarge: TextStyle(
          color: _kText,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: _kText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _HeroBannerSection(),
            SizedBox(height: 28),
            const _ClassAnatomySection(),
            SizedBox(height: 28),
            const _RecentsCardMockSection(),
            SizedBox(height: 28),
            const _PlatformSupportSection(),
            SizedBox(height: 28),
            const _CodeSnippetsSection(),
            SizedBox(height: 28),
            const _PrimaryColorEncodingSection(),
            SizedBox(height: 28),
            const _PitfallsSection(),
            SizedBox(height: 28),
            const _RelatedApisSection(),
            SizedBox(height: 28),
            const _BestPracticesSection(),
            SizedBox(height: 28),
            const _FooterReferencesSection(),
            SizedBox(height: 60),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// 1. Hero banner section
// ===========================================================================
class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A237E),
            const Color(0xFF283593).withValues(alpha: 0.85),
            const Color(0xFF512DA8).withValues(alpha: 0.75),
            const Color(0xFF311B92),
          ],
          stops: const <double>[0.0, 0.45, 0.75, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _kAccent.withValues(alpha: 0.35),
          width: 1.1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kAccent,
                  _kAccent2,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kAccent.withValues(alpha: 0.45),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.dashboard_customize_outlined,
                color: Colors.white,
                size: 44,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ApplicationSwitcherDescription',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'package:flutter/services.dart',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Metadata describing how your Flutter app should appear in '
                  'the Android recents / app-switcher overview. Two fields: '
                  'a label and an ARGB primaryColor. Applied through '
                  'SystemChrome.setApplicationSwitcherDescription.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const <Widget>[
                    _HeroChip(label: 'Android-only'),
                    _HeroChip(label: 'Immutable'),
                    _HeroChip(label: 'No-op on iOS / Web / Desktop'),
                    _HeroChip(label: 'ARGB int'),
                    _HeroChip(label: 'Affects recents card'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  const _HeroChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.28),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ===========================================================================
// 2. Class anatomy section (constructor + fields table)
// ===========================================================================
class _ClassAnatomySection extends StatelessWidget {
  const _ClassAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Class anatomy',
      subtitle: 'Constructor signature and the two fields you can set',
      iconData: Icons.account_tree_outlined,
      accent: _kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF0F1B26),
                  const Color(0xFF132233).withValues(alpha: 0.95),
                  const Color(0xFF0B141C),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder, width: 1),
            ),
            child: const _CodeBlock(
              lines: <_CodeLine>[
                _CodeLine(text: '// ARGB int format: 0xAARRGGBB'),
                _CodeLine(text: '@immutable'),
                _CodeLine(text: 'class ApplicationSwitcherDescription {'),
                _CodeLine(text: '  const ApplicationSwitcherDescription({'),
                _CodeLine(text: '    this.label,'),
                _CodeLine(text: '    this.primaryColor,'),
                _CodeLine(text: '  });'),
                _CodeLine(text: ''),
                _CodeLine(text: '  /// Shown under the thumbnail.'),
                _CodeLine(text: '  final String? label;'),
                _CodeLine(text: ''),
                _CodeLine(text: '  /// ARGB int; tints the recents header.'),
                _CodeLine(text: '  final int? primaryColor;'),
                _CodeLine(text: '}'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _AnatomyTable(),
        ],
      ),
    );
  }
}

class _AnatomyTable extends StatelessWidget {
  const _AnatomyTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: const <Widget>[
          _TableRow(
            cells: <String>['Field', 'Type', 'Nullable', 'Effect on Android'],
            isHeader: true,
          ),
          _TableRow(
            cells: <String>[
              'label',
              'String?',
              'yes',
              'Caption under the recents thumbnail. If null, falls back to '
                  'the launcher activity label.',
            ],
          ),
          _TableRow(
            cells: <String>[
              'primaryColor',
              'int?',
              'yes',
              'ARGB int used to tint the small header bar above the '
                  'recents thumbnail. Alpha is usually ignored on Android.',
            ],
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final List<String> cells;
  final bool isHeader;
  const _TableRow({required this.cells, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFF1B2A38)
            : const Color(0x00000000),
        border: Border(
          bottom: BorderSide(color: _kBorder, width: 0.6),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              cells[0],
              style: TextStyle(
                color: isHeader ? _kAccent : _kText,
                fontFamily: 'monospace',
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cells[1],
              style: TextStyle(
                color: isHeader ? _kAccent : _kAccent3,
                fontFamily: 'monospace',
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              cells[2],
              style: TextStyle(
                color: isHeader ? _kAccent : _kTextDim,
                fontFamily: 'monospace',
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              cells[3],
              style: TextStyle(
                color: isHeader ? _kAccent : _kText,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 3. Recents card mock section
// ===========================================================================
class _RecentsCardMockSection extends StatelessWidget {
  const _RecentsCardMockSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Android recents card mock',
      subtitle:
          'Static reproduction of how Android composes the recents thumbnail '
          'using the label and primaryColor you provide.',
      iconData: Icons.view_carousel_outlined,
      accent: _kAccent2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF101820),
                  const Color(0xFF18222D),
                  const Color(0xFF0C141B),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.start,
              children: const <Widget>[
                _RecentsCardMock(
                  label: 'Tom Forge',
                  primaryColorArgb: 0xFF1565C0,
                  appIcon: Icons.architecture,
                  bodyAccent: Color(0xFF1565C0),
                  bodySubtitle: 'Flow editor • Project Acorn',
                ),
                _RecentsCardMock(
                  label: 'Tom Assistant',
                  primaryColorArgb: 0xFF6A1B9A,
                  appIcon: Icons.smart_toy_outlined,
                  bodyAccent: Color(0xFF6A1B9A),
                  bodySubtitle: 'Active conversation',
                ),
                _RecentsCardMock(
                  label: 'Work Tracker',
                  primaryColorArgb: 0xFFEF6C00,
                  appIcon: Icons.checklist_rtl,
                  bodyAccent: Color(0xFFEF6C00),
                  bodySubtitle: '3 todos open',
                ),
                _RecentsCardMock(
                  label: null,
                  primaryColorArgb: 0xFF2E7D32,
                  appIcon: Icons.bug_report_outlined,
                  bodyAccent: Color(0xFF2E7D32),
                  bodySubtitle: 'Label is null → launcher label is shown',
                ),
                _RecentsCardMock(
                  label: 'Atelier',
                  primaryColorArgb: null,
                  appIcon: Icons.palette_outlined,
                  bodyAccent: Color(0xFF455A64),
                  bodySubtitle: 'primaryColor null → system default',
                ),
                _RecentsCardMock(
                  label: 'Tom Forge — Beta',
                  primaryColorArgb: 0xFFAD1457,
                  appIcon: Icons.science_outlined,
                  bodyAccent: Color(0xFFAD1457),
                  bodySubtitle: 'Long label gets ellipsised',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _kAccent2.withValues(alpha: 0.18),
                  _kAccent2.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _kAccent2.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: _kAccent2,
                  size: 22,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'These are static renderings — Flutter does not draw the '
                    'recents card itself. The values you pass to '
                    'ApplicationSwitcherDescription are forwarded to '
                    'ActivityManager.TaskDescription on Android, and the '
                    'system shell does the actual rendering.',
                    style: TextStyle(
                      color: _kText,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentsCardMock extends StatelessWidget {
  final String? label;
  final int? primaryColorArgb;
  final IconData appIcon;
  final Color bodyAccent;
  final String bodySubtitle;

  const _RecentsCardMock({
    required this.label,
    required this.primaryColorArgb,
    required this.appIcon,
    required this.bodyAccent,
    required this.bodySubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedHeader = primaryColorArgb == null
        ? const Color(0xFF455A64)
        : Color(primaryColorArgb!);
    final String resolvedLabel = label ?? '(launcher label)';
    final bool labelIsFallback = label == null;
    final bool colorIsFallback = primaryColorArgb == null;

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.7),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header bar (tinted by primaryColor)
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: resolvedHeader,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    appIcon,
                    size: 14,
                    color: resolvedHeader,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    resolvedLabel,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                      fontStyle: labelIsFallback
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                  ),
                ),
                Icon(Icons.close, size: 14, color: Colors.white),
              ],
            ),
          ),
          // Thumbnail body
          Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  bodyAccent.withValues(alpha: 0.35),
                  bodyAccent.withValues(alpha: 0.08),
                  const Color(0xFF101010),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 8,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          // Footer description (this is *not* part of Android — it's the
          // explanation we attach to the demo).
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bodySubtitle,
                  style: TextStyle(
                    color: _kText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'label: ${labelIsFallback ? "null" : '"$label"'}',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'primaryColor: ${colorIsFallback ? "null" : "0x${primaryColorArgb!.toRadixString(16).toUpperCase().padLeft(8, "0")}"}',
                  style: TextStyle(
                    color: _kAccent3,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 4. Platform support section
// ===========================================================================
class _PlatformSupportSection extends StatelessWidget {
  const _PlatformSupportSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Platform support matrix',
      subtitle:
          'ApplicationSwitcherDescription is only consumed by the Android '
          'embedder. Everywhere else, calling '
          'SystemChrome.setApplicationSwitcherDescription is a silent no-op.',
      iconData: Icons.devices_other_outlined,
      accent: _kAccent3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              children: const <Widget>[
                _PlatformRow(
                  platform: 'Android',
                  icon: Icons.android,
                  iconColor: Color(0xFF8BC34A),
                  status: _PlatformStatus.full,
                  notes:
                      'Both label and primaryColor are forwarded to '
                      'ActivityManager.TaskDescription. Effect is visible on '
                      'every modern Android version (API 21+).',
                ),
                _PlatformRow(
                  platform: 'iOS',
                  icon: Icons.phone_iphone,
                  iconColor: Color(0xFFB0BEC5),
                  status: _PlatformStatus.noop,
                  notes:
                      'iOS does not expose recents-card tint metadata to '
                      'apps. The call is silently ignored.',
                ),
                _PlatformRow(
                  platform: 'Web',
                  icon: Icons.public,
                  iconColor: Color(0xFF4FC3F7),
                  status: _PlatformStatus.noop,
                  notes:
                      'No platform channel implementation. Browser tab title '
                      'is unaffected — use document.title or MaterialApp.title '
                      'for that.',
                ),
                _PlatformRow(
                  platform: 'macOS',
                  icon: Icons.laptop_mac,
                  iconColor: Color(0xFFB0BEC5),
                  status: _PlatformStatus.noop,
                  notes:
                      'macOS uses NSWindow titles; this API does nothing on '
                      'desktop.',
                ),
                _PlatformRow(
                  platform: 'Windows',
                  icon: Icons.laptop_windows,
                  iconColor: Color(0xFF42A5F5),
                  status: _PlatformStatus.noop,
                  notes: 'No-op. Use the native window title APIs.',
                ),
                _PlatformRow(
                  platform: 'Linux',
                  icon: Icons.laptop_chromebook,
                  iconColor: Color(0xFFFFB74D),
                  status: _PlatformStatus.noop,
                  notes: 'No-op. Window-manager-specific APIs apply.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _LegendDot(
                color: const Color(0xFF66BB6A),
                label: 'full support',
              ),
              const SizedBox(width: 16),
              _LegendDot(
                color: const Color(0xFFFFB74D),
                label: 'partial',
              ),
              const SizedBox(width: 16),
              _LegendDot(
                color: const Color(0xFFE57373),
                label: 'no-op',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _PlatformStatus { full, partial, noop }

class _PlatformRow extends StatelessWidget {
  final String platform;
  final IconData icon;
  final Color iconColor;
  final _PlatformStatus status;
  final String notes;

  const _PlatformRow({
    required this.platform,
    required this.icon,
    required this.iconColor,
    required this.status,
    required this.notes,
  });

  Color get _statusColor {
    switch (status) {
      case _PlatformStatus.full:
        return const Color(0xFF66BB6A);
      case _PlatformStatus.partial:
        return const Color(0xFFFFB74D);
      case _PlatformStatus.noop:
        return const Color(0xFFE57373);
    }
  }

  String get _statusLabel {
    switch (status) {
      case _PlatformStatus.full:
        return 'FULL';
      case _PlatformStatus.partial:
        return 'PARTIAL';
      case _PlatformStatus.noop:
        return 'NO-OP';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _kBorder, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: iconColor.withValues(alpha: 0.4),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  platform,
                  style: const TextStyle(
                    color: _kText,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _statusColor.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(
                      color: _statusColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              notes,
              style: const TextStyle(
                color: _kText,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.45),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _kTextDim,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// 5. Code snippets section
// ===========================================================================
class _CodeSnippetsSection extends StatelessWidget {
  const _CodeSnippetsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Practical code snippets',
      subtitle:
          'Three canonical patterns: set on startup, react to brightness '
          'changes, and localise the label.',
      iconData: Icons.code_outlined,
      accent: _kAccent4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _CodeSnippet(
            title: 'Set on app start',
            description:
                'Call once after WidgetsFlutterBinding.ensureInitialized, '
                'before runApp, to set the recents card the moment your app '
                'becomes visible.',
            tagColor: _kAccent4,
            lines: <_CodeLine>[
              _CodeLine(text: "import 'package:flutter/services.dart';"),
              _CodeLine(text: "import 'package:flutter/widgets.dart';"),
              _CodeLine(text: ''),
              _CodeLine(text: 'void main() {'),
              _CodeLine(
                  text: '  WidgetsFlutterBinding.ensureInitialized();'),
              _CodeLine(
                  text: '  SystemChrome.setApplicationSwitcherDescription('),
              _CodeLine(text: '    const ApplicationSwitcherDescription('),
              _CodeLine(text: "      label: 'Tom Forge',"),
              _CodeLine(text: '      primaryColor: 0xFF1565C0,'),
              _CodeLine(text: '    ),'),
              _CodeLine(text: '  );'),
              _CodeLine(text: '  runApp(const MyApp());'),
              _CodeLine(text: '}'),
            ],
          ),
          SizedBox(height: 18),
          _CodeSnippet(
            title: 'Update on theme / brightness change',
            description:
                'If you have a dark mode toggle, call again so the recents '
                'header tint follows your active theme.',
            tagColor: _kAccent2,
            lines: <_CodeLine>[
              _CodeLine(text: 'void applyRecentsForBrightness(Brightness b) {'),
              _CodeLine(text: '  final int argb = b == Brightness.dark'),
              _CodeLine(text: '      ? 0xFF0D1117'),
              _CodeLine(text: '      : 0xFFFFFFFF;'),
              _CodeLine(text: '  SystemChrome.setApplicationSwitcherDescription('),
              _CodeLine(text: '    ApplicationSwitcherDescription('),
              _CodeLine(text: "      label: 'Tom Forge',"),
              _CodeLine(text: '      primaryColor: argb,'),
              _CodeLine(text: '    ),'),
              _CodeLine(text: '  );'),
              _CodeLine(text: '}'),
            ],
          ),
          SizedBox(height: 18),
          _CodeSnippet(
            title: 'Localise the label',
            description:
                'In a LocalizationsDelegate or LocaleListener, push a fresh '
                'description so the recents caption matches the user locale.',
            tagColor: _kAccent3,
            lines: <_CodeLine>[
              _CodeLine(text: 'void applyRecentsForLocale(Locale locale) {'),
              _CodeLine(text: '  final String localized = switch (locale.languageCode) {'),
              _CodeLine(text: "    'de' => 'Tom Schmiede',"),
              _CodeLine(text: "    'fr' => 'Tom Forge',"),
              _CodeLine(text: "    'ja' => 'トム鍛冶'  ,"),
              _CodeLine(text: "    _ => 'Tom Forge',"),
              _CodeLine(text: '  };'),
              _CodeLine(text: '  SystemChrome.setApplicationSwitcherDescription('),
              _CodeLine(text: '    ApplicationSwitcherDescription('),
              _CodeLine(text: '      label: localized,'),
              _CodeLine(text: '      primaryColor: 0xFF1565C0,'),
              _CodeLine(text: '    ),'),
              _CodeLine(text: '  );'),
              _CodeLine(text: '}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  final String title;
  final String description;
  final List<_CodeLine> lines;
  final Color tagColor;

  const _CodeSnippet({
    required this.title,
    required this.description,
    required this.lines,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF0D1A23),
            const Color(0xFF101E29).withValues(alpha: 0.95),
            const Color(0xFF0A141B),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: tagColor.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: tagColor.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              border: Border(
                bottom: BorderSide(
                  color: tagColor.withValues(alpha: 0.35),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: tagColor.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    'snippet',
                    style: TextStyle(
                      color: tagColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: _kText,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          color: _kTextDim,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // code body
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
            child: _CodeBlock(lines: lines),
          ),
        ],
      ),
    );
  }
}

class _CodeLine {
  final String text;
  const _CodeLine({required this.text});
}

class _CodeBlock extends StatelessWidget {
  final List<_CodeLine> lines;
  const _CodeBlock({required this.lines});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < lines.length; i++) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 30,
                child: Text(
                  (i + 1).toString().padLeft(2, ' '),
                  style: const TextStyle(
                    color: Color(0xFF4A5A6A),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: _SyntaxText(text: lines[i].text),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class _SyntaxText extends StatelessWidget {
  final String text;
  const _SyntaxText({required this.text});

  Color _colorize(String word) {
    const Set<String> keywords = <String>{
      'import',
      'class',
      'const',
      'final',
      'void',
      'return',
      'if',
      'else',
      'switch',
      'case',
      'true',
      'false',
      'null',
      'new',
      'this',
      'super',
      'extends',
      'with',
      'static',
    };
    if (keywords.contains(word)) return const Color(0xFFCE93D8);
    if (word.startsWith('0x')) return const Color(0xFFFFB74D);
    if (word.startsWith('//')) return const Color(0xFF607D8B);
    if (word.startsWith("'") || word.startsWith('"')) {
      return const Color(0xFF80CBC4);
    }
    return _kText;
  }

  @override
  Widget build(BuildContext context) {
    if (text.trim().startsWith('//')) {
      return Text(
        text,
        style: const TextStyle(
          color: Color(0xFF607D8B),
          fontFamily: 'monospace',
          fontSize: 12.5,
          fontStyle: FontStyle.italic,
          height: 1.55,
        ),
      );
    }
    final List<String> tokens = text.split(' ');
    final List<InlineSpan> spans = <InlineSpan>[];
    for (int i = 0; i < tokens.length; i++) {
      final String t = tokens[i];
      spans.add(
        TextSpan(
          text: t + (i == tokens.length - 1 ? '' : ' '),
          style: TextStyle(
            color: _colorize(t),
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
      );
    }
    return RichText(text: TextSpan(children: spans));
  }
}

// ===========================================================================
// 6. primaryColor encoding section (ARGB bit layout)
// ===========================================================================
class _PrimaryColorEncodingSection extends StatelessWidget {
  const _PrimaryColorEncodingSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'primaryColor encoding',
      subtitle:
          'The int value is a packed 32-bit ARGB number: 0xAARRGGBB. Each '
          'byte controls one channel.',
      iconData: Icons.format_color_fill_outlined,
      accent: _kAccent5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF1B2330),
                  const Color(0xFF111923),
                  const Color(0xFF0A1018),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              children: const <Widget>[
                _BitLayoutDiagram(),
                SizedBox(height: 20),
                _BitLayoutLegend(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _ArgbExamplesGrid(),
        ],
      ),
    );
  }
}

class _BitLayoutDiagram extends StatelessWidget {
  const _BitLayoutDiagram();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          child: _BitByteBox(
            label: 'A',
            hex: 'FF',
            description: 'alpha\nignored on most\nAndroid versions',
            color: Color(0xFFB0BEC5),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _BitByteBox(
            label: 'R',
            hex: '15',
            description: 'red\n0–255',
            color: Color(0xFFEF5350),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _BitByteBox(
            label: 'G',
            hex: '65',
            description: 'green\n0–255',
            color: Color(0xFF66BB6A),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _BitByteBox(
            label: 'B',
            hex: 'C0',
            description: 'blue\n0–255',
            color: Color(0xFF42A5F5),
          ),
        ),
      ],
    );
  }
}

class _BitByteBox extends StatelessWidget {
  final String label;
  final String hex;
  final String description;
  final Color color;

  const _BitByteBox({
    required this.label,
    required this.hex,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            color.withValues(alpha: 0.32),
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.55),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 28,
              letterSpacing: 1,
            ),
          ),
          Text(
            '0x$hex',
            style: const TextStyle(
              color: _kText,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kTextDim,
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _BitLayoutLegend extends StatelessWidget {
  const _BitLayoutLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _LegendBullet(
            label: 'Reading bits',
            description:
                'bits 31-24 = A, bits 23-16 = R, bits 15-8 = G, bits 7-0 = B',
          ),
          SizedBox(height: 6),
          _LegendBullet(
            label: 'Constructing',
            description:
                'final int argb = (a << 24) | (r << 16) | (g << 8) | b;',
          ),
          SizedBox(height: 6),
          _LegendBullet(
            label: 'From Flutter Color',
            description:
                'color.value returns the packed int directly. You can pass it '
                'straight into primaryColor.',
          ),
          SizedBox(height: 6),
          _LegendBullet(
            label: 'Alpha caveat',
            description:
                'Android typically treats the recents header as fully opaque, '
                'so the alpha byte is effectively ignored.',
          ),
        ],
      ),
    );
  }
}

class _LegendBullet extends StatelessWidget {
  final String label;
  final String description;
  const _LegendBullet({required this.label, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _kAccent5,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: '$label — ',
                  style: const TextStyle(
                    color: _kText,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
                TextSpan(
                  text: description,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ArgbExamplesGrid extends StatelessWidget {
  const _ArgbExamplesGrid();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'A few prepared ARGB examples',
            style: TextStyle(
              color: _kText,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _ArgbExample(name: 'Indigo 700', hex: 0xFF303F9F),
              _ArgbExample(name: 'Blue 800', hex: 0xFF1565C0),
              _ArgbExample(name: 'Teal 600', hex: 0xFF00897B),
              _ArgbExample(name: 'Amber 800', hex: 0xFFFF8F00),
              _ArgbExample(name: 'Pink 700', hex: 0xFFC2185B),
              _ArgbExample(name: 'Deep Purple', hex: 0xFF512DA8),
              _ArgbExample(name: 'Green 700', hex: 0xFF388E3C),
              _ArgbExample(name: 'Brown 600', hex: 0xFF6D4C41),
              _ArgbExample(name: 'BlueGrey', hex: 0xFF455A64),
              _ArgbExample(name: 'Black87', hex: 0xDD000000),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArgbExample extends StatelessWidget {
  final String name;
  final int hex;
  const _ArgbExample({required this.name, required this.hex});

  @override
  Widget build(BuildContext context) {
    final Color c = Color(hex);
    return Container(
      width: 168,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF101A24),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '0x${hex.toRadixString(16).toUpperCase().padLeft(8, "0")}',
            style: const TextStyle(
              color: _kAccent3,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 7. Pitfalls section
// ===========================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pitfalls',
      subtitle:
          'Subtle behaviours that surprise people the first time they touch '
          'this API.',
      iconData: Icons.warning_amber_outlined,
      accent: _kAccent3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _Pitfall(
            title: 'Calling before binding initialization',
            severity: _Severity.high,
            description:
                'SystemChrome.setApplicationSwitcherDescription calls a '
                'platform channel. If you call it before '
                'WidgetsFlutterBinding.ensureInitialized() (or '
                'ServicesBinding) you will get a "ServicesBinding.instance '
                'has not been initialized" assertion at runtime.',
            fix:
                'Always call WidgetsFlutterBinding.ensureInitialized() in '
                'main() before any platform-channel calls.',
          ),
          _Pitfall(
            title: 'Null label clears the override',
            severity: _Severity.medium,
            description:
                'Passing ApplicationSwitcherDescription(label: null) does '
                'not preserve the previous label — it removes it. Android '
                'then re-renders the recents card with the launcher label.',
            fix:
                'If you only want to update the colour, supply the current '
                'label again as well.',
          ),
          _Pitfall(
            title: 'primaryColor alpha is usually ignored',
            severity: _Severity.low,
            description:
                'Android applies the colour to an opaque header view. '
                'Setting an alpha of 0x80 will not make the header '
                'translucent on top of wallpaper.',
            fix:
                'Treat the alpha byte as a constant 0xFF unless you have a '
                'specific reason to vary it.',
          ),
          _Pitfall(
            title: 'No effect on iOS / desktop / web',
            severity: _Severity.medium,
            description:
                'The call succeeds silently on non-Android platforms. Do not '
                'rely on it for cross-platform window-title or theming '
                'behaviour.',
            fix:
                'For cross-platform window titles use MaterialApp.title and '
                'the OS-specific window APIs.',
          ),
          _Pitfall(
            title: 'Stale colour after theme change',
            severity: _Severity.medium,
            description:
                'If you only set the description once at startup, the '
                'recents header colour will not follow user-driven theme '
                'switches inside the app.',
            fix:
                'Re-call SystemChrome.setApplicationSwitcherDescription on '
                'every theme change.',
          ),
          _Pitfall(
            title: 'Frequent updates can flicker',
            severity: _Severity.low,
            description:
                'Calling this API every frame (e.g. in build) sends a '
                'platform message every time. It is cheap, but pointless and '
                'can show up in performance traces.',
            fix:
                'Guard the call so it only fires when label or primaryColor '
                'actually change.',
          ),
        ],
      ),
    );
  }
}

enum _Severity { low, medium, high }

class _Pitfall extends StatelessWidget {
  final String title;
  final _Severity severity;
  final String description;
  final String fix;

  const _Pitfall({
    required this.title,
    required this.severity,
    required this.description,
    required this.fix,
  });

  Color get _color {
    switch (severity) {
      case _Severity.low:
        return const Color(0xFF66BB6A);
      case _Severity.medium:
        return const Color(0xFFFFB74D);
      case _Severity.high:
        return const Color(0xFFE57373);
    }
  }

  String get _label {
    switch (severity) {
      case _Severity.low:
        return 'low';
      case _Severity.medium:
        return 'medium';
      case _Severity.high:
        return 'high';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _color.withValues(alpha: 0.12),
            _color.withValues(alpha: 0.03),
            _kSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _color.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _color.withValues(alpha: 0.6),
                  ),
                ),
                child: Text(
                  _label.toUpperCase(),
                  style: TextStyle(
                    color: _color,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _kText,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kBg.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _color.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: _color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fix,
                    style: const TextStyle(
                      color: _kText,
                      fontSize: 12,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 8. Related APIs section
// ===========================================================================
class _RelatedApisSection extends StatelessWidget {
  const _RelatedApisSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Related APIs',
      subtitle:
          'Cousins of ApplicationSwitcherDescription that you usually wire up '
          'in the same place.',
      iconData: Icons.hub_outlined,
      accent: _kAccent2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _RelatedApiCard(
            symbol: 'SystemChrome.setSystemUIOverlayStyle',
            kind: 'static method',
            summary:
                'Controls status-bar and navigation-bar contents (icon '
                'brightness, background colour, divider).',
            relation:
                'Often called next to setApplicationSwitcherDescription so '
                'the in-app system bars match the recents-card tint.',
          ),
          _RelatedApiCard(
            symbol: 'SystemUiOverlayStyle',
            kind: 'class',
            summary:
                'Immutable description of the system overlays — status-bar '
                'background colour, icon brightness, etc.',
            relation:
                'Companion value class. Pair it with '
                'ApplicationSwitcherDescription for full visual coherence.',
          ),
          _RelatedApiCard(
            symbol: 'SystemChrome.setPreferredOrientations',
            kind: 'static method',
            summary:
                'Locks the app to a subset of device orientations.',
            relation:
                'Often configured at the same startup point. Has nothing to '
                'do with recents tinting but lives in the same family.',
          ),
          _RelatedApiCard(
            symbol: 'MaterialApp.title',
            kind: 'field',
            summary:
                'Title used by some platforms for window decoration and the '
                'task switcher when no other override is present.',
            relation:
                'On Android, ApplicationSwitcherDescription.label takes '
                'precedence over MaterialApp.title for the recents card.',
          ),
          _RelatedApiCard(
            symbol: 'WidgetsBindingObserver',
            kind: 'mixin',
            summary:
                'Notifies on app lifecycle transitions, brightness, locale, '
                'and metrics changes.',
            relation:
                'Listen for brightness/locale changes to know when to '
                're-push an updated ApplicationSwitcherDescription.',
          ),
          _RelatedApiCard(
            symbol: 'ActivityManager.TaskDescription',
            kind: 'Android API',
            summary:
                'Native Android class that ApplicationSwitcherDescription '
                'maps onto under the hood.',
            relation:
                'Knowing this exists helps when reading the Flutter engine '
                'source or filing platform bugs.',
          ),
        ],
      ),
    );
  }
}

class _RelatedApiCard extends StatelessWidget {
  final String symbol;
  final String kind;
  final String summary;
  final String relation;

  const _RelatedApiCard({
    required this.symbol,
    required this.kind,
    required this.summary,
    required this.relation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  symbol,
                  style: const TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _kAccent2.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _kAccent2.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  kind,
                  style: TextStyle(
                    color: _kAccent2,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(
              color: _kText,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kBg.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.link,
                  color: _kAccent,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    relation,
                    style: const TextStyle(
                      color: _kTextDim,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 9. Best practices section
// ===========================================================================
class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Best practices',
      subtitle:
          'Recommendations distilled from real Tom Forge / Tom Assistant '
          'usage of this API.',
      iconData: Icons.verified_outlined,
      accent: _kAccent4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _BestPractice(
            number: 1,
            title: 'Match recents tint to your top app-bar',
            body:
                'Pick the same colour you use for AppBar.backgroundColor so '
                'the recents card visually flows into the running app.',
          ),
          _BestPractice(
            number: 2,
            title: 'Keep the label short and brand-aligned',
            body:
                'Android truncates long labels. 12–18 characters is a safe '
                'visual budget on most devices.',
          ),
          _BestPractice(
            number: 3,
            title: 'Re-apply after every meaningful theme change',
            body:
                'Hook into WidgetsBindingObserver or your own theme '
                'controller to call setApplicationSwitcherDescription again.',
          ),
          _BestPractice(
            number: 4,
            title: 'Localise the label, not the colour',
            body:
                'The label is user-visible text and should be translated. The '
                'primaryColor is brand metadata and should generally not '
                'depend on locale.',
          ),
          _BestPractice(
            number: 5,
            title: 'Guard against redundant calls',
            body:
                'Cache the last applied description; only push a new one when '
                'a field actually changed.',
          ),
          _BestPractice(
            number: 6,
            title: 'Document non-Android no-op',
            body:
                'Leave a short comment near the call site noting that other '
                'platforms ignore it, so future readers do not chase '
                'cross-platform bugs.',
          ),
          _BestPractice(
            number: 7,
            title: 'Avoid alpha tricks',
            body:
                'Treat primaryColor as 0xFFRRGGBB. Do not try to use alpha '
                'for "ghost" effects — Android composites it as opaque.',
          ),
          _BestPractice(
            number: 8,
            title: 'Pair with a clean MaterialApp.title',
            body:
                'On platforms that ignore this API, MaterialApp.title is the '
                'next-best label. Keep both in sync.',
          ),
        ],
      ),
    );
  }
}

class _BestPractice extends StatelessWidget {
  final int number;
  final String title;
  final String body;
  const _BestPractice({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kAccent4.withValues(alpha: 0.9),
                  _kAccent.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kAccent4.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 12.5,
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
}

// ===========================================================================
// 10. Footer references section
// ===========================================================================
class _FooterReferencesSection extends StatelessWidget {
  const _FooterReferencesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A237E).withValues(alpha: 0.55),
            const Color(0xFF311B92).withValues(alpha: 0.45),
            const Color(0xFF0E141B),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _kAccent.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.menu_book_outlined,
                color: _kAccent,
                size: 24,
              ),
              const SizedBox(width: 10),
              const Text(
                'References',
                style: TextStyle(
                  color: _kText,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kSurface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _RefLink(
                  label: 'Flutter API: ApplicationSwitcherDescription',
                  url:
                      'https://api.flutter.dev/flutter/services/ApplicationSwitcherDescription-class.html',
                ),
                _RefLink(
                  label: 'Flutter API: SystemChrome.setApplicationSwitcherDescription',
                  url:
                      'https://api.flutter.dev/flutter/services/SystemChrome/setApplicationSwitcherDescription.html',
                ),
                _RefLink(
                  label: 'Android: ActivityManager.TaskDescription',
                  url:
                      'https://developer.android.com/reference/android/app/ActivityManager.TaskDescription',
                ),
                _RefLink(
                  label: 'Flutter source: lib/src/services/system_chrome.dart',
                  url:
                      'https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/services/system_chrome.dart',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'This file is a static visual specification used by the d4rt '
            'Flutter AST visual harness. It paints — but never schedules or '
            'mutates — the page that documents how '
            'ApplicationSwitcherDescription behaves end-to-end.',
            style: TextStyle(
              color: _kText.withValues(alpha: 0.85),
              fontSize: 12.5,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const Icon(
                Icons.copyright_outlined,
                color: _kTextDim,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'Tom AI — d4rt visual catalog. All values are illustrative.',
                style: TextStyle(
                  color: _kTextDim,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RefLink extends StatelessWidget {
  final String label;
  final String url;
  const _RefLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.link_outlined,
            size: 14,
            color: _kAccent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: _kText,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  url,
                  style: const TextStyle(
                    color: _kAccent,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section shell (shared chrome around every _*Section widget)
// ===========================================================================
class _SectionShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color accent;
  final Widget child;

  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accent.withValues(alpha: 0.25),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      accent.withValues(alpha: 0.9),
                      accent.withValues(alpha: 0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: accent.withValues(alpha: 0.45),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(iconData, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kTextDim,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.0),
                  accent.withValues(alpha: 0.5),
                  accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// End of static deep demo for ApplicationSwitcherDescription.
//
// Section inventory (unique private _*Section widgets):
//   1.  _HeroBannerSection
//   2.  _ClassAnatomySection
//   3.  _RecentsCardMockSection
//   4.  _PlatformSupportSection
//   5.  _CodeSnippetsSection
//   6.  _PrimaryColorEncodingSection
//   7.  _PitfallsSection
//   8.  _RelatedApisSection
//   9.  _BestPracticesSection
//   10. _FooterReferencesSection
//
// Gradient inventory (BoxDecoration LinearGradients, at minimum):
//   - Hero banner background gradient
//   - Hero banner inner icon tile gradient
//   - Class anatomy code-block surface gradient
//   - Recents card mock outer surface gradient
//   - Recents card mock body fill gradient (per card variant)
//   - Code snippet surface gradient
//   - primaryColor encoding section surface gradient
//   - Bit-byte boxes vertical gradients (A / R / G / B)
//   - Pitfalls cards diagonal gradients
//   - Best-practice number badge gradients
//   - Section shell icon-tile gradient
//   - Section shell divider gradient line
//   - Footer references background gradient
//
// All structural patterns are static; no scheduling APIs are used.
// ---------------------------------------------------------------------------
