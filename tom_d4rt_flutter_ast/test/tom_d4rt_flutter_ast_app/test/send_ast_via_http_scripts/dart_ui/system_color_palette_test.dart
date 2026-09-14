// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - SystemColorPalette from dart:ui
//
// This file demonstrates the live W3C system-color palette as exposed by
// the host platform via dart:ui. The class under test is
// `ui.SystemColorPalette`, accessible through `ui.SystemColor.light` and
// `ui.SystemColor.dark`. Whether values are populated is determined by
// `ui.SystemColor.platformProvidesSystemColors` — true on web (Chrome,
// Safari, Firefox, Edge), false elsewhere. Accessing palette getters on
// platforms that do not provide system colors throws an UnsupportedError.
//
// The build() function below:
//   1. Detects platform / palette availability up-front.
//   2. Renders a live palette grid when present.
//   3. Always renders the static W3C reference grid, the synthesised
//      light/dark cards, the use-case demos, the API anatomy panel,
//      and an explanatory "Why care" panel.
//
// The class is hand-instrumented; nothing is mocked. The fallback
// branch is reached only when the running platform genuinely returns
// `platformProvidesSystemColors == false`.

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CONSTANTS / COLOUR TOKENS
// ─────────────────────────────────────────────────────────────────────────────

const Color _kPageBg = Color(0xFFF4F6FA);
const Color _kInk = Color(0xFF0F1B2D);
const Color _kInkSoft = Color(0xFF52617A);
const Color _kInkFaint = Color(0xFF8090A8);
const Color _kCardBorder = Color(0xFFD8DEE9);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kAccent = Color(0xFF3B6FD0);
const Color _kAccentDeep = Color(0xFF234B96);
const Color _kAccentSoft = Color(0xFFDFE9FB);
const Color _kSuccess = Color(0xFF2E8B57);
const Color _kSuccessSoft = Color(0xFFDFF1E5);
const Color _kWarn = Color(0xFFC97A1D);
const Color _kWarnSoft = Color(0xFFFCE8CD);
const Color _kDanger = Color(0xFFB23A48);
const Color _kDangerSoft = Color(0xFFF8D7DC);
const Color _kPlumDeep = Color(0xFF5B2A7A);
const Color _kPlumSoft = Color(0xFFE7DAF1);
const Color _kTealDeep = Color(0xFF076E73);
const Color _kTealSoft = Color(0xFFCDEBED);
const Color _kSlateDeep = Color(0xFF394452);
const Color _kSlateSoft = Color(0xFFDDE4ED);

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────

String _hex(Color c) {
  final int a = (c.a * 255.0).round() & 0xFF;
  final int r = (c.r * 255.0).round() & 0xFF;
  final int g = (c.g * 255.0).round() & 0xFF;
  final int b = (c.b * 255.0).round() & 0xFF;
  String pad(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
  return '#${pad(a)}${pad(r)}${pad(g)}${pad(b)}';
}

bool _isLight(Color c) {
  final double luma = (c.r * 0.299) + (c.g * 0.587) + (c.b * 0.114);
  return luma > 0.6;
}

Color _readableTextOn(Color bg) =>
    _isLight(bg) ? const Color(0xFF101820) : const Color(0xFFFAFCFF);

class _LivePaletteEntry {
  const _LivePaletteEntry({
    required this.fieldName,
    required this.cssName,
    required this.color,
    required this.supported,
  });

  final String fieldName;
  final String cssName;
  final Color? color;
  final bool supported;
}

class _RefEntry {
  const _RefEntry(this.name, this.lightColor, this.darkColor, this.role);

  final String name;
  final Color lightColor;
  final Color darkColor;
  final String role;
}

class _ApiEntry {
  const _ApiEntry(this.field, this.cssName, this.purpose);

  final String field;
  final String cssName;
  final String purpose;
}

// Probe helper — accessing palette getters throws on non-web platforms,
// but the test environment may be old/new. Using try/catch keeps the
// demo robust without ignoring the genuine error path.
_LivePaletteEntry _probe(
  String field,
  String cssName,
  ui.SystemColor Function() read,
) {
  try {
    final ui.SystemColor sys = read();
    return _LivePaletteEntry(
      fieldName: field,
      cssName: cssName,
      color: sys.value,
      supported: sys.isSupported,
    );
  } catch (_) {
    return _LivePaletteEntry(
      fieldName: field,
      cssName: cssName,
      color: null,
      supported: false,
    );
  }
}

List<_LivePaletteEntry> _readLivePalette(ui.SystemColorPalette p) {
  return <_LivePaletteEntry>[
    _probe('accentColor', 'AccentColor', () => p.accentColor),
    _probe('accentColorText', 'AccentColorText', () => p.accentColorText),
    _probe('activeText', 'ActiveText', () => p.activeText),
    _probe('buttonBorder', 'ButtonBorder', () => p.buttonBorder),
    _probe('buttonFace', 'ButtonFace', () => p.buttonFace),
    _probe('buttonText', 'ButtonText', () => p.buttonText),
    _probe('canvas', 'Canvas', () => p.canvas),
    _probe('canvasText', 'CanvasText', () => p.canvasText),
    _probe('field', 'Field', () => p.field),
    _probe('fieldText', 'FieldText', () => p.fieldText),
    _probe('grayText', 'GrayText', () => p.grayText),
    _probe('highlight', 'Highlight', () => p.highlight),
    _probe('highlightText', 'HighlightText', () => p.highlightText),
    _probe('linkText', 'LinkText', () => p.linkText),
    _probe('mark', 'Mark', () => p.mark),
    _probe('markText', 'MarkText', () => p.markText),
    _probe('selectedItem', 'SelectedItem', () => p.selectedItem),
    _probe('selectedItemText', 'SelectedItemText', () => p.selectedItemText),
    _probe('visitedText', 'VisitedText', () => p.visitedText),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// BUILD ENTRY POINT
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  // ===========================================================================
  // PLATFORM AND PALETTE PROBING
  // ===========================================================================

  final TargetPlatform platform = defaultTargetPlatform;
  final bool runningOnWeb = kIsWeb;
  final bool palettesProvided = ui.SystemColor.platformProvidesSystemColors;
  final ui.SystemColorPalette? livePaletteLight =
      palettesProvided ? ui.SystemColor.light : null;
  final ui.SystemColorPalette? livePaletteDark =
      palettesProvided ? ui.SystemColor.dark : null;

  print(
    '[system_color_palette_test] platform=${platform.name} '
    'kIsWeb=$runningOnWeb palettesProvided=$palettesProvided '
    'light=${_describePalette(livePaletteLight)} '
    'dark=${_describePalette(livePaletteDark)}',
  );

  final List<_LivePaletteEntry> liveLightEntries = livePaletteLight == null
      ? const <_LivePaletteEntry>[]
      : _readLivePalette(livePaletteLight);
  final List<_LivePaletteEntry> liveDarkEntries = livePaletteDark == null
      ? const <_LivePaletteEntry>[]
      : _readLivePalette(livePaletteDark);

  final int liveSupportedCount = liveLightEntries
      .where((_LivePaletteEntry e) => e.supported)
      .length;

  // ===========================================================================
  // STATIC W3C REFERENCE PALETTE
  // ===========================================================================

  final List<_RefEntry> w3cReference = <_RefEntry>[
    _RefEntry(
      'ButtonFace',
      const Color(0xFFE0E0E0),
      const Color(0xFF3A3A3A),
      'Background of push-button controls.',
    ),
    _RefEntry(
      'ButtonText',
      const Color(0xFF101820),
      const Color(0xFFF5F7FA),
      'Foreground text on push-button controls.',
    ),
    _RefEntry(
      'Canvas',
      const Color(0xFFFFFFFF),
      const Color(0xFF1B1F26),
      'Background of an application document or canvas.',
    ),
    _RefEntry(
      'CanvasText',
      const Color(0xFF222222),
      const Color(0xFFE6EAF1),
      'Default foreground text colour against Canvas.',
    ),
    _RefEntry(
      'Field',
      const Color(0xFFFFFFFF),
      const Color(0xFF252A33),
      'Background of editable form-field controls.',
    ),
    _RefEntry(
      'FieldText',
      const Color(0xFF000000),
      const Color(0xFFEDEFF2),
      'Foreground inside editable form-field controls.',
    ),
    _RefEntry(
      'GrayText',
      const Color(0xFFA8A8A8),
      const Color(0xFF6F7682),
      'Foreground used for disabled / inactive UI text.',
    ),
    _RefEntry(
      'Highlight',
      const Color(0xFF3B6FD0),
      const Color(0xFF4F86E5),
      'Background colour used for selected items.',
    ),
    _RefEntry(
      'HighlightText',
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      'Foreground colour for text in selected items.',
    ),
    _RefEntry(
      'LinkText',
      const Color(0xFF1A4FB0),
      const Color(0xFF6BA2FF),
      'Foreground for unvisited hyperlinks.',
    ),
    _RefEntry(
      'Mark',
      const Color(0xFFFFFFAA),
      const Color(0xFF715E1A),
      'Background colour for highlighted (<mark>) text.',
    ),
    _RefEntry(
      'MarkText',
      const Color(0xFF000000),
      const Color(0xFFFFF7CC),
      'Foreground for text inside <mark> highlights.',
    ),
    _RefEntry(
      'VisitedText',
      const Color(0xFF6E1FA8),
      const Color(0xFFC58BF0),
      'Foreground for visited hyperlinks.',
    ),
    _RefEntry(
      'AccentColor',
      const Color(0xFF0067D6),
      const Color(0xFF4F9CFF),
      'OS-level accent / brand colour reflected by Flutter web.',
    ),
    _RefEntry(
      'SelectedItem',
      const Color(0xFFCFE0FA),
      const Color(0xFF274D8A),
      'Background of an item in a focused selection container.',
    ),
    _RefEntry(
      'SelectedItemText',
      const Color(0xFF0E2240),
      const Color(0xFFF3F8FF),
      'Foreground of an item in a focused selection container.',
    ),
  ];

  // ===========================================================================
  // API ANATOMY (ui.SystemColorPalette getters)
  // ===========================================================================

  final List<_ApiEntry> apiAnatomy = <_ApiEntry>[
    _ApiEntry(
      'accentColor',
      'AccentColor',
      'OS accent colour — Windows highlight, macOS system blue, etc.',
    ),
    _ApiEntry(
      'accentColorText',
      'AccentColorText',
      'Foreground intended to sit legibly on top of the accent colour.',
    ),
    _ApiEntry(
      'activeText',
      'ActiveText',
      'Colour for currently activated (mouse-down) hyperlinks.',
    ),
    _ApiEntry(
      'buttonBorder',
      'ButtonBorder',
      'Border colour around push-button controls.',
    ),
    _ApiEntry(
      'buttonFace',
      'ButtonFace',
      'Surface colour of push-button controls in their resting state.',
    ),
    _ApiEntry(
      'buttonText',
      'ButtonText',
      'Foreground of text inside push-button controls.',
    ),
    _ApiEntry(
      'canvas',
      'Canvas',
      'Background colour of the application "document" surface.',
    ),
    _ApiEntry(
      'canvasText',
      'CanvasText',
      'Default foreground text colour drawn over Canvas.',
    ),
    _ApiEntry(
      'field',
      'Field',
      'Background of input fields, text areas, combo-boxes.',
    ),
    _ApiEntry(
      'fieldText',
      'FieldText',
      'Foreground for text typed into Field-style controls.',
    ),
    _ApiEntry(
      'grayText',
      'GrayText',
      'Disabled-state foreground for any control kind.',
    ),
    _ApiEntry(
      'highlight',
      'Highlight',
      'Background colour applied to selected text or list rows.',
    ),
    _ApiEntry(
      'highlightText',
      'HighlightText',
      'Foreground of text inside Highlight selections.',
    ),
    _ApiEntry(
      'linkText',
      'LinkText',
      'Default foreground for unvisited hyperlinks.',
    ),
    _ApiEntry(
      'mark',
      'Mark',
      'Background of <mark>-style highlighted text spans.',
    ),
    _ApiEntry(
      'markText',
      'MarkText',
      'Foreground for text inside <mark> highlight spans.',
    ),
    _ApiEntry(
      'selectedItem',
      'SelectedItem',
      'Background of items in a focused list / selection.',
    ),
    _ApiEntry(
      'selectedItemText',
      'SelectedItemText',
      'Foreground of items in a focused list / selection.',
    ),
    _ApiEntry(
      'visitedText',
      'VisitedText',
      'Default foreground for hyperlinks the user already visited.',
    ),
  ];

  // ===========================================================================
  // ROOT WIDGET TREE
  // ===========================================================================

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      color: _kPageBg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildPageHeader(),
              const SizedBox(height: 22),
              _buildPlatformStatusCard(
                platform: platform,
                runningOnWeb: runningOnWeb,
                palettesProvided: palettesProvided,
                liveSupportedCount: liveSupportedCount,
                totalProbed: liveLightEntries.length,
              ),
              const SizedBox(height: 22),
              if (palettesProvided)
                _buildLivePaletteSection(
                  title: 'Live SystemColorPalette (light)',
                  description:
                      'Resolved from ui.SystemColor.light on this host. '
                      'Each swatch reads the live OS / browser value.',
                  entries: liveLightEntries,
                  accentBg: _kAccentSoft,
                  accentFg: _kAccentDeep,
                )
              else
                _buildLivePaletteUnavailableNotice(platform),
              const SizedBox(height: 22),
              if (palettesProvided)
                _buildLivePaletteSection(
                  title: 'Live SystemColorPalette (dark)',
                  description:
                      'Resolved from ui.SystemColor.dark. Browsers honour '
                      'the user-chosen forced-colors / dark-mode preference.',
                  entries: liveDarkEntries,
                  accentBg: _kSlateSoft,
                  accentFg: _kSlateDeep,
                ),
              if (palettesProvided) const SizedBox(height: 22),
              _buildW3cReferenceSection(w3cReference),
              const SizedBox(height: 22),
              _buildLightVsDarkSection(w3cReference),
              const SizedBox(height: 22),
              _buildUseCaseDemos(w3cReference),
              const SizedBox(height: 22),
              _buildApiAnatomySection(apiAnatomy),
              const SizedBox(height: 22),
              _buildWhyCareSection(),
              const SizedBox(height: 22),
              _buildFooterCard(
                liveSupportedCount: liveSupportedCount,
                palettesProvided: palettesProvided,
                platform: platform,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE HEADER
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildPageHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kAccentDeep, _kAccent, _kPlumDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kAccentDeep.withAlpha(70),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'ui',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ui.SystemColorPalette',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Host-OS / browser system-colour palette',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD9E4FB),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _headerPill('dart:ui'),
            _headerPill('W3C system-color'),
            _headerPill('PlatformDispatcher.platformBrightness'),
            _headerPill('SystemColor.platformProvidesSystemColors'),
          ],
        ),
      ],
    ),
  );
}

Widget _headerPill(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFFFFFFF),
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// PLATFORM STATUS
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildPlatformStatusCard({
  required TargetPlatform platform,
  required bool runningOnWeb,
  required bool palettesProvided,
  required int liveSupportedCount,
  required int totalProbed,
}) {
  final Color statusBg = palettesProvided ? _kSuccessSoft : _kWarnSoft;
  final Color statusFg = palettesProvided ? _kSuccess : _kWarn;
  final String statusLabel = palettesProvided
      ? 'PALETTE LIVE'
      : 'PALETTE UNAVAILABLE';

  return _sectionCard(
    accentBg: _kAccentSoft,
    accentFg: _kAccentDeep,
    icon: 'i',
    title: '1 — Platform status',
    subtitle: 'Runtime probe of the current host environment.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _statusRow('defaultTargetPlatform', platform.name, _kInk),
        const SizedBox(height: 8),
        _statusRow('kIsWeb', runningOnWeb ? 'true' : 'false', _kInk),
        const SizedBox(height: 8),
        _statusRow(
          'SystemColor.platformProvidesSystemColors',
          palettesProvided ? 'true' : 'false',
          _kInk,
        ),
        const SizedBox(height: 8),
        _statusRow(
          'live palette getters returning a value',
          palettesProvided ? '$liveSupportedCount / $totalProbed' : '0 / 19',
          _kInk,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: statusFg.withAlpha(120)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusFg,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusLabel,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: statusFg,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _statusRow(String key, String value, Color valueColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 5,
        child: Text(
          key,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: _kInkSoft,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        flex: 4,
        child: Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// LIVE PALETTE SECTIONS
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildLivePaletteSection({
  required String title,
  required String description,
  required List<_LivePaletteEntry> entries,
  required Color accentBg,
  required Color accentFg,
}) {
  return _sectionCard(
    accentBg: accentBg,
    accentFg: accentFg,
    icon: '*',
    title: '2 — $title',
    subtitle: description,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _LivePaletteEntry e in entries)
              SizedBox(
                width: 220,
                child: _liveSwatchCell(e),
              ),
          ],
        ),
        const SizedBox(height: 14),
        _legendNote(
          'Cells with a striped background indicate the platform did not '
          'expose that particular system colour, even though the palette '
          'itself is provided.',
          accentFg,
        ),
      ],
    ),
  );
}

Widget _liveSwatchCell(_LivePaletteEntry e) {
  final Color swatch = e.color ?? const Color(0xFFEDEFF3);
  final bool unsupported = !e.supported || e.color == null;
  final Color textOn = _readableTextOn(swatch);
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCardBorder),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: swatch,
            border: unsupported
                ? const Border(
                    bottom: BorderSide(color: Color(0xFFB23A48), width: 2),
                  )
                : null,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            unsupported ? 'unsupported' : _hex(swatch),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: unsupported ? const Color(0xFFB23A48) : textOn,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                e.fieldName,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'CSS: ${e.cssName}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kInkFaint,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLivePaletteUnavailableNotice(TargetPlatform platform) {
  return _sectionCard(
    accentBg: _kWarnSoft,
    accentFg: _kWarn,
    icon: '!',
    title: '2 — Live palette unavailable',
    subtitle:
        'On ${platform.name} the system color palette is null; this is '
        'expected. The web build (Chrome / Safari / Firefox / Edge) returns '
        'a non-null palette via ui.SystemColor.light / ui.SystemColor.dark.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8EC),
            border: Border.all(color: _kWarn.withAlpha(120)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Probe results',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: _kInk,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• ui.SystemColor.platformProvidesSystemColors  →  false\n'
                '• Reading any palette getter would throw '
                'UnsupportedError.\n'
                '• Below sections still illustrate the concept using '
                'curated approximations.',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.55,
                  color: _kInkSoft,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// W3C STATIC REFERENCE
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildW3cReferenceSection(List<_RefEntry> reference) {
  return _sectionCard(
    accentBg: _kPlumSoft,
    accentFg: _kPlumDeep,
    icon: 'W3',
    title: '3 — W3C system-colour reference grid',
    subtitle:
        'Approximations of the W3C-defined system-colour names. On the web '
        'the browser substitutes the real OS values; the hex values shown '
        'here are illustrative only.',
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        for (final _RefEntry e in reference)
          SizedBox(
            width: 230,
            child: _refSwatchCell(e),
          ),
      ],
    ),
  );
}

Widget _refSwatchCell(_RefEntry e) {
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCardBorder),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 64,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: e.lightColor,
                  alignment: Alignment.center,
                  child: Text(
                    'L',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _readableTextOn(e.lightColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: e.darkColor,
                  alignment: Alignment.center,
                  child: Text(
                    'D',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _readableTextOn(e.darkColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                e.name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                e.role,
                style: const TextStyle(
                  fontSize: 11,
                  color: _kInkSoft,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _hex(e.lightColor),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _kInkFaint,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _hex(e.darkColor),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _kInkFaint,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// LIGHT VS DARK SYNTHESISED CARDS
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildLightVsDarkSection(List<_RefEntry> ref) {
  Color pick(String name, bool dark) {
    final _RefEntry e = ref.firstWhere(
      (_RefEntry r) => r.name == name,
      orElse: () => _RefEntry(name, _kCardBg, _kInk, ''),
    );
    return dark ? e.darkColor : e.lightColor;
  }

  Widget themeCard({
    required String label,
    required bool dark,
    required Color cardBg,
    required Color cardBorder,
  }) {
    final Color canvas = pick('Canvas', dark);
    final Color canvasText = pick('CanvasText', dark);
    final Color field = pick('Field', dark);
    final Color fieldText = pick('FieldText', dark);
    final Color highlight = pick('Highlight', dark);
    final Color highlightText = pick('HighlightText', dark);
    final Color buttonFace = pick('ButtonFace', dark);
    final Color buttonText = pick('ButtonText', dark);
    final Color linkText = pick('LinkText', dark);
    final Color visitedText = pick('VisitedText', dark);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: cardBorder,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: dark ? const Color(0xFFFFFFFF) : _kInk,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            color: canvas,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'CanvasText on Canvas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: canvasText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: field,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: cardBorder),
                  ),
                  child: Text(
                    'Field input — FieldText',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: fieldText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: highlight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Highlighted row — HighlightText',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: highlightText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: buttonFace,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '[ Button ] ButtonText',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: buttonText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Text(
                      'LinkText',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: linkText,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'VisitedText',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: visitedText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _sectionCard(
    accentBg: _kTealSoft,
    accentFg: _kTealDeep,
    icon: 'L/D',
    title: '4 — Light vs dark synthesised palettes',
    subtitle:
        'Side-by-side rendering using the curated W3C approximations. In a '
        'real app, MediaQuery.platformBrightnessOf(context) typically picks '
        'which palette to read.',
    body: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: themeCard(
            label: 'Light theme — ui.SystemColor.light',
            dark: false,
            cardBg: const Color(0xFFFAFCFF),
            cardBorder: const Color(0xFFC8D4E5),
          ),
        ),
        SizedBox(
          width: 320,
          child: themeCard(
            label: 'Dark theme — ui.SystemColor.dark',
            dark: true,
            cardBg: const Color(0xFF1B1F26),
            cardBorder: const Color(0xFF394452),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// USE-CASE DEMOS
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildUseCaseDemos(List<_RefEntry> ref) {
  Color pick(String name) {
    return ref
        .firstWhere(
          (_RefEntry r) => r.name == name,
          orElse: () => _RefEntry(name, _kCardBg, _kInk, ''),
        )
        .lightColor;
  }

  final Color canvas = pick('Canvas');
  final Color canvasText = pick('CanvasText');
  final Color buttonFace = pick('ButtonFace');
  final Color buttonText = pick('ButtonText');
  final Color highlight = pick('Highlight');
  final Color highlightText = pick('HighlightText');
  final Color selectedItem = pick('SelectedItem');
  final Color selectedItemText = pick('SelectedItemText');
  final Color linkText = pick('LinkText');
  final Color visitedText = pick('VisitedText');
  final Color accent = pick('AccentColor');
  final Color grayText = pick('GrayText');

  return _sectionCard(
    accentBg: _kSuccessSoft,
    accentFg: _kSuccess,
    icon: 'UI',
    title: '5 — Use-case mini demos',
    subtitle:
        'Three real widget compositions wired up with the system-colour '
        'roles to show how the palette maps onto everyday UI.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // ---- Demo A: navigation bar -----------------------------------------
        _demoCaption('A — Navigation bar (Canvas + CanvasText + AccentColor)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: canvas,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD8DEE9)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'T',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _readableTextOn(accent),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tom Workspace',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: canvasText,
                ),
              ),
              const Spacer(),
              for (final String label in const <String>[
                'Files',
                'Search',
                'Profile',
              ])
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: canvasText,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _readableTextOn(accent),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // ---- Demo B: list with selected row ---------------------------------
        _demoCaption(
          'B — List view (SelectedItem / SelectedItemText / Highlight)',
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: canvas,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD8DEE9)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                _listRow(
                  label:
                      'tom_d4rt_flutter_ast_app/test/case_${i.toString().padLeft(2, '0')}.dart',
                  selected: i == 2,
                  isFirstFocus: i == 2,
                  canvas: canvas,
                  canvasText: canvasText,
                  selectedBg: selectedItem,
                  selectedFg: selectedItemText,
                  focusBg: highlight,
                  focusFg: highlightText,
                  meta: i == 2 ? 'OPEN' : 'idle',
                  metaColor: i == 2 ? selectedItemText : grayText,
                ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // ---- Demo C: hyperlink cluster --------------------------------------
        _demoCaption('C — Link cluster (LinkText vs VisitedText)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: canvas,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD8DEE9)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Documentation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: canvasText,
                ),
              ),
              const SizedBox(height: 8),
              for (final _LinkSpec spec in <_LinkSpec>[
                const _LinkSpec(
                  href: 'https://api.flutter.dev/flutter/dart-ui/SystemColor-class.html',
                  visited: false,
                  blurb: 'API reference for ui.SystemColor',
                ),
                const _LinkSpec(
                  href: 'https://api.flutter.dev/flutter/dart-ui/SystemColorPalette-class.html',
                  visited: true,
                  blurb: 'API reference for ui.SystemColorPalette (already read)',
                ),
                const _LinkSpec(
                  href: 'https://drafts.csswg.org/css-color/#css-system-colors',
                  visited: false,
                  blurb: 'W3C CSS Color spec — system-color names',
                ),
                const _LinkSpec(
                  href: 'https://developer.mozilla.org/en-US/docs/Web/CSS/system-color',
                  visited: true,
                  blurb: 'MDN reference for the CSS system-color value (visited)',
                ),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 13,
                        color: _kInk,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: spec.href,
                          style: TextStyle(
                            color: spec.visited ? visitedText : linkText,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '   ${spec.blurb}',
                          style: TextStyle(color: canvasText),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: buttonFace,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFB8C2D2)),
                ),
                child: Text(
                  '[ Open all in new tab ]',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: buttonText,
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

class _LinkSpec {
  const _LinkSpec({
    required this.href,
    required this.visited,
    required this.blurb,
  });

  final String href;
  final bool visited;
  final String blurb;
}

Widget _listRow({
  required String label,
  required bool selected,
  required bool isFirstFocus,
  required Color canvas,
  required Color canvasText,
  required Color selectedBg,
  required Color selectedFg,
  required Color focusBg,
  required Color focusFg,
  required String meta,
  required Color metaColor,
}) {
  final Color bg = selected ? selectedBg : canvas;
  final Color fg = selected ? selectedFg : canvasText;
  return Container(
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    child: Row(
      children: <Widget>[
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: isFirstFocus ? focusBg : const Color(0x00000000),
            border: Border.all(
              color: isFirstFocus ? focusBg : const Color(0xFFAAB4C2),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.center,
          child: isFirstFocus
              ? Text(
                  'x',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: focusFg,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: fg,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          meta,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: metaColor,
          ),
        ),
      ],
    ),
  );
}

Widget _demoCaption(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: _kInkSoft,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// API ANATOMY
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildApiAnatomySection(List<_ApiEntry> entries) {
  return _sectionCard(
    accentBg: _kSlateSoft,
    accentFg: _kSlateDeep,
    icon: 'API',
    title: '6 — ui.SystemColorPalette anatomy',
    subtitle:
        'Every getter exposed by the live class, with a one-line explanation '
        'of when the OS uses it. The palette is read-only — Flutter snapshots '
        'OS-supplied colours.',
    body: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: _kSlateSoft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: const Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    'SystemColorPalette getter',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _kSlateDeep,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'CSS name',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _kSlateDeep,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Purpose',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _kSlateDeep,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < entries.length; i++)
            Container(
              color: i.isEven ? const Color(0xFFFFFFFF) : const Color(0xFFF6F8FB),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      entries[i].field,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      entries[i].cssName,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: _kInkSoft,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      entries[i].purpose,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _kInkSoft,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// WHY CARE
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildWhyCareSection() {
  return _sectionCard(
    accentBg: _kDangerSoft,
    accentFg: _kDanger,
    icon: '?',
    title: '7 — Why care about the system palette',
    subtitle:
        'OS-faithful rendering, accessibility (forced-colors mode), and '
        'cross-platform consistency are the three big wins.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _whyParagraph(
          headline: 'OS-faithful rendering',
          body:
              'On Windows, ui.SystemColor.light.accentColor maps to the '
              'user\'s personalised accent (Settings → Personalisation → '
              'Colors). On macOS Safari it tracks the system blue / '
              'graphite preference. Reading the palette lets a Flutter web '
              'app match the host chrome exactly, instead of hard-coding '
              'a Material blue and looking out-of-place.',
        ),
        const SizedBox(height: 12),
        _whyParagraph(
          headline: 'Accessibility — forced-colors mode',
          body:
              'When users enable Windows High Contrast or any forced-colors '
              'media query, browsers swap their entire palette to the OS '
              'accessibility theme. Apps that read SystemColorPalette '
              'automatically adopt that theme; apps that hard-code colours '
              'become unreadable.',
        ),
        const SizedBox(height: 12),
        _whyParagraph(
          headline: 'Brightness routing',
          body:
              'Flutter routes the OS-reported brightness through '
              'PlatformDispatcher.platformBrightness and exposes it via '
              'MediaQuery.platformBrightnessOf(context). A typical theme '
              'reads ui.SystemColor.light when brightness is light and '
              'ui.SystemColor.dark when dark. Both palettes stay valid '
              'simultaneously — the choice is yours.',
        ),
        const SizedBox(height: 12),
        _whyParagraph(
          headline: 'Why not on mobile / desktop today',
          body:
              'ui.SystemColor.platformProvidesSystemColors is currently '
              'only true on web. Native iOS / Android / macOS / Windows / '
              'Linux Flutter still relies on Cupertino / Material design '
              'tokens for system-faithful colours. The palette API is '
              'the forward-compatible hook should those platforms expose '
              'it natively in the future.',
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kCardBorder),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Suggested usage pattern',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '  if (ui.SystemColor.platformProvidesSystemColors) {\n'
                '    final ui.SystemColorPalette p =\n'
                '        MediaQuery.platformBrightnessOf(ctx) == Brightness.dark\n'
                '            ? ui.SystemColor.dark\n'
                '            : ui.SystemColor.light;\n'
                '    return p.accentColor.value ?? appTheme.brandColor;\n'
                '  } else {\n'
                '    return appTheme.brandColor;\n'
                '  }',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.45,
                  color: _kInkSoft,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _whyParagraph({required String headline, required String body}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7F8),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDanger.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          headline,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: _kDanger,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: const TextStyle(
            fontSize: 13,
            height: 1.5,
            color: _kInk,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildFooterCard({
  required int liveSupportedCount,
  required bool palettesProvided,
  required TargetPlatform platform,
}) {
  final String footerLine = palettesProvided
      ? 'Palette live — $liveSupportedCount supported entries on ${platform.name}.'
      : 'Palette inert on ${platform.name}; switch to a web build to '
          'observe live OS values.';

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'ui.SystemColorPalette — end of demo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          footerLine,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFB8C5DA),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sections: 1 status / 2 live / 3 W3C ref / 4 light vs dark / '
          '5 use-cases / 6 API anatomy / 7 why care.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF8094B5),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED CARD CHROME
// ─────────────────────────────────────────────────────────────────────────────

Widget _sectionCard({
  required Color accentBg,
  required Color accentFg,
  required String icon,
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kCardBorder),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0F1B2D).withAlpha(14),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
          decoration: BoxDecoration(
            color: accentBg,
            border: Border(
              bottom: BorderSide(color: accentFg.withAlpha(80)),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accentFg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  icon,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: accentFg,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: accentFg.withAlpha(220),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: body,
        ),
      ],
    ),
  );
}

Widget _legendNote(String text, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: accent.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withAlpha(80)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: accent,
        height: 1.45,
      ),
    ),
  );
}

// Describe a palette for debug logging — invoked from build() so it is
// always evaluated and there is no dead code in the file.
String _describePalette(ui.SystemColorPalette? p) {
  if (p == null) return 'null (palette unavailable on this platform)';
  return 'SystemColorPalette(brightness: ${p.brightness.name})';
}
