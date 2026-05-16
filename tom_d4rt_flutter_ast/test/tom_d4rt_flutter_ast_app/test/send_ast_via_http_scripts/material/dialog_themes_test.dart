// ignore_for_file: avoid_print, unused_local_variable
// D4rt visual deep-demo: DialogTheme atelier.
//
// This file is a hand-written demonstration showcasing every facet of the
// Flutter DialogTheme family — colours, shapes, elevation, alignment, content
// padding, text styles, action layouts. Dialogs are rendered inline (no
// showDialog, no async, no Timer) by composing the dialog tree under a faux
// scrim. There is no main(); the script entry point is the top-level
// `build(BuildContext)` function which returns the entire visual document.

import 'package:flutter/material.dart';

// ============================================================================
// PALETTE TOKENS (slate / parchment / copper)
// ============================================================================

const Color _ink = Color(0xFF1B1A2E);
const Color _slate = Color(0xFF2B2A48);
const Color _mist = Color(0xFFEFEDF5);
const Color _paper = Color(0xFFFBF9F1);
const Color _line = Color(0xFFD7D2BF);
const Color _subtle = Color(0xFF5F5A6E);
const Color _scrim = Color(0x88151538);

const Color _copper = Color(0xFFB7541C);
const Color _copperSoft = Color(0xFFE9B68B);
const Color _copperWash = Color(0xFFFBE8D5);

const Color _moss = Color(0xFF2F6A4E);
const Color _mossSoft = Color(0xFFA8CDB7);
const Color _mossWash = Color(0xFFDFEFE4);

const Color _plum = Color(0xFF6B2E63);
const Color _plumSoft = Color(0xFFC9A4C2);
const Color _plumWash = Color(0xFFEEDEEB);

const Color _navy = Color(0xFF1F3A6B);
const Color _navySoft = Color(0xFF9DB1D6);
const Color _navyWash = Color(0xFFDDE5F1);

const Color _danger = Color(0xFFB23B3B);
const Color _dangerSoft = Color(0xFFE9AEAE);
const Color _dangerWash = Color(0xFFFBDDDD);

const Color _amber = Color(0xFFC78A1A);
const Color _amberSoft = Color(0xFFEFD49C);
const Color _amberWash = Color(0xFFFAEED4);

// ============================================================================
// MICRO HELPERS
// ============================================================================

Widget _gap(double h) => SizedBox(height: h);
Widget _wgap(double w) => SizedBox(width: w);

Widget _label(
  String text, {
  Color color = _ink,
  double size = 12.0,
  FontWeight weight = FontWeight.w600,
  double letter = 0.6,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letter,
    ),
  );
}

Widget _caption(String text, {Color color = _subtle, double size = 12.5}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      height: 1.5,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _heading(String text, {Color color = _ink, double size = 22.0}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    ),
  );
}

Widget _kicker(String text, {Color color = _copper}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    ),
  );
}

Widget _bullet(String text, {Color color = _ink}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7, right: 10),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _divider({Color color = _line, double thickness = 1.0}) {
  return Container(height: thickness, color: color);
}

Widget _sectionFrame({
  required String index,
  required String title,
  required String tagline,
  required Color primary,
  required Color soft,
  required Color wash,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    decoration: BoxDecoration(
      color: _paper,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _line, width: 1),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.06),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(28, 26, 28, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: wash,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: soft, width: 1.4),
              ),
              child: Text(
                index,
                style: TextStyle(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            _wgap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kicker(tagline, color: primary),
                  _gap(8),
                  _heading(title),
                ],
              ),
            ),
          ],
        ),
        _gap(20),
        _divider(),
        _gap(22),
        body,
      ],
    ),
  );
}

Widget _scrimStage({required Widget child, Color tint = _scrim}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [tint, tint.withValues(alpha: 0.55)],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    alignment: Alignment.center,
    child: child,
  );
}

Widget _fakeDialog({
  required Widget child,
  double width = 320,
  double elevation = 6,
  Color shadow = const Color(0x55000000),
  BorderRadius? radius,
  Color color = Colors.white,
  Border? border,
}) {
  return Center(
    child: SizedBox(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: radius ?? BorderRadius.circular(16),
            border: border,
            boxShadow: [
              BoxShadow(
                color: shadow,
                blurRadius: 6 + elevation * 2,
                spreadRadius: elevation * 0.2,
                offset: Offset(0, elevation),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius ?? BorderRadius.circular(16),
            child: child,
          ),
        ),
      ),
    ),
  );
}

Widget _codeQuote(String text, {Color tint = _slate}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _ink,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withValues(alpha: 0.55)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFEFE7D9),
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.5,
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — HERO HEADER
// ============================================================================

Widget _heroHeader() {
  return Container(
    margin: const EdgeInsets.fromLTRB(24, 28, 24, 12),
    padding: const EdgeInsets.fromLTRB(32, 30, 32, 32),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_ink, _slate, _plum],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: _ink.withValues(alpha: 0.25),
          blurRadius: 32,
          offset: const Offset(0, 16),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _kicker('DEEP DEMO • DIALOGS', color: _copperSoft),
            _wgap(10),
            _kicker('MATERIAL 3', color: _mossSoft),
          ],
        ),
        _gap(20),
        const Text(
          'DialogTheme Atelier',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        _gap(10),
        const Text(
          'A hand-crafted gallery of AlertDialog, SimpleDialog, and Dialog '
          'compositions — every theme knob, alignment slot, and elevation '
          'tier rendered inline as a static visual document.',
          style: TextStyle(
            color: Color(0xFFE6DEF5),
            fontSize: 15,
            height: 1.55,
            fontWeight: FontWeight.w500,
          ),
        ),
        _gap(24),
        Row(
          children: [
            _heroChip('14 sections', _copperSoft),
            _wgap(10),
            _heroChip('Inline rendering', _mossSoft),
            _wgap(10),
            _heroChip('Analyzer-clean', _navySoft),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(40),
      border: Border.all(color: color.withValues(alpha: 0.65)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
      ),
    ),
  );
}

// ============================================================================
// SECTION 2 — CONCEPT BULLETS
// ============================================================================

Widget _conceptSection() {
  return _sectionFrame(
    index: '01',
    title: 'What DialogTheme controls',
    tagline: 'CONCEPT',
    primary: _copper,
    soft: _copperSoft,
    wash: _copperWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DialogTheme (and DialogThemeData in Material 3) lives inside '
          'ThemeData and provides defaults for every Material dialog widget. '
          'Below are the properties that flow through the theme into '
          'AlertDialog, SimpleDialog, and Dialog.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('SURFACE'),
                  _gap(8),
                  _bullet('backgroundColor — fill of the dialog surface.'),
                  _bullet('surfaceTintColor — M3 elevation tint overlay.'),
                  _bullet('shadowColor — colour of the cast shadow.'),
                  _bullet('elevation — z-depth, drives shadow intensity.'),
                  _bullet('shape — ShapeBorder for the perimeter.'),
                ],
              ),
            ),
            _wgap(28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('TEXT & ICON'),
                  _gap(8),
                  _bullet('titleTextStyle — heading text style.'),
                  _bullet('contentTextStyle — body text style.'),
                  _bullet('iconColor — colour of the leading icon slot.'),
                ],
              ),
            ),
            _wgap(28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('LAYOUT'),
                  _gap(8),
                  _bullet('alignment — where the dialog sits on screen.'),
                  _bullet('insetPadding — outer margin around the dialog.'),
                  _bullet('actionsPadding — pad around the action row.'),
                  _bullet('barrierColor — scrim behind the dialog.'),
                  _bullet('clipBehavior — clipping on the surface.'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — ANATOMY DIAGRAM
// ============================================================================

Widget _anatomySection() {
  return _sectionFrame(
    index: '02',
    title: 'Anatomy of an AlertDialog',
    tagline: 'ANATOMY',
    primary: _moss,
    soft: _mossSoft,
    wash: _mossWash,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _anatomyStage(),
        ),
        _wgap(28),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _anatomyRow('A', 'Icon slot', 'Optional leading icon, M3 only.'),
              _anatomyRow('B', 'Title', 'Heading line, titleTextStyle.'),
              _anatomyRow('C', 'Content', 'Body region, contentTextStyle.'),
              _anatomyRow('D', 'Actions', 'Buttons row, actionsAlignment.'),
              _anatomyRow('E', 'Scrim', 'Modal background, barrierColor.'),
              _anatomyRow('F', 'Inset padding', 'Margin to screen edges.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyStage() {
  return _scrimStage(
    tint: _mossWash,
    child: _fakeDialog(
      width: 340,
      elevation: 12,
      color: Colors.white,
      radius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _anatomyTag('A', _moss),
            _gap(6),
            const Icon(Icons.info_outline, color: _moss, size: 28),
            _gap(12),
            _anatomyTag('B', _moss),
            _gap(4),
            const Text(
              'Confirm publication',
              style: TextStyle(
                color: _ink,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            _gap(12),
            _anatomyTag('C', _moss),
            _gap(4),
            const Text(
              'The article will be visible to all readers. You can edit or '
              'unpublish it at any time from the dashboard.',
              style: TextStyle(
                color: _subtle,
                fontSize: 13.5,
                height: 1.45,
              ),
            ),
            _gap(16),
            _anatomyTag('D', _moss),
            _gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Cancel')),
                _wgap(4),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Publish'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _anatomyTag(String letter, Color color) {
  return Container(
    width: 22,
    height: 22,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      letter,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _anatomyRow(String tag, String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _anatomyTag(tag, _moss),
        _wgap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _gap(2),
              Text(
                desc,
                style: const TextStyle(
                  color: _subtle,
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

// ============================================================================
// SECTION 4 — DEFAULT vs THEMED SIDE-BY-SIDE
// ============================================================================

Widget _defaultVsThemedSection() {
  return _sectionFrame(
    index: '03',
    title: 'Default vs themed',
    tagline: 'BEFORE / AFTER',
    primary: _plum,
    soft: _plumSoft,
    wash: _plumWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'On the left, an AlertDialog with Material defaults. On the right, '
          'the same dialog rendered with a custom DialogTheme applied to the '
          'surrounding ThemeData.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('DEFAULT'),
                  _gap(8),
                  _scrimStage(
                    tint: _mist,
                    child: _fakeDialog(
                      child: const AlertDialog(
                        title: Text('Default title'),
                        content: Text(
                          'Plain AlertDialog, no DialogTheme override. '
                          'Inherits the ambient ThemeData defaults.',
                        ),
                        actions: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _wgap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('THEMED'),
                  _gap(8),
                  _scrimStage(
                    tint: _plumWash,
                    child: _fakeDialog(
                      color: _paper,
                      radius: BorderRadius.circular(22),
                      elevation: 10,
                      shadow: _plum.withValues(alpha: 0.30),
                      border: Border.all(color: _plumSoft, width: 1.2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 14),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              color: _plum,
                              size: 26,
                            ),
                            _gap(10),
                            const Text(
                              'Themed title',
                              style: TextStyle(
                                color: _plum,
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                            _gap(10),
                            const Text(
                              'Custom DialogTheme with plum palette, larger '
                              'radius, tinted shadow, and bespoke title style.',
                              style: TextStyle(
                                color: _slate,
                                fontSize: 13.5,
                                height: 1.45,
                              ),
                            ),
                            _gap(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: _plum),
                                  ),
                                ),
                                _wgap(4),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: _plum,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Continue'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — SHAPE VARIANTS
// ============================================================================

Widget _shapeSection() {
  return _sectionFrame(
    index: '04',
    title: 'Shape variants',
    tagline: 'SHAPE',
    primary: _navy,
    soft: _navySoft,
    wash: _navyWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DialogTheme.shape accepts any ShapeBorder. Square, gently rounded, '
          'stadium, and cut-corner perimeters all yield distinct silhouettes.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _shapeCard(
                label: 'SQUARE',
                radius: BorderRadius.zero,
                tint: _navy,
              ),
            ),
            _wgap(14),
            Expanded(
              child: _shapeCard(
                label: 'ROUNDED 16',
                radius: BorderRadius.circular(16),
                tint: _navy,
              ),
            ),
            _wgap(14),
            Expanded(
              child: _shapeCard(
                label: 'STADIUM 40',
                radius: BorderRadius.circular(40),
                tint: _navy,
              ),
            ),
            _wgap(14),
            Expanded(
              child: _shapeCard(
                label: 'CUT CORNERS',
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                tint: _navy,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _shapeCard({
  required String label,
  required BorderRadius radius,
  required Color tint,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(label, color: tint),
      _gap(8),
      _scrimStage(
        tint: _navyWash,
        child: _fakeDialog(
          width: 220,
          radius: radius,
          color: Colors.white,
          border: Border.all(color: _navySoft, width: 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.crop_square, color: tint, size: 22),
                _gap(8),
                Text(
                  'Shape sample',
                  style: TextStyle(
                    color: tint,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _gap(6),
                const Text(
                  'Same content, different perimeter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _subtle,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 6 — COLOUR PALETTE DIALOGS
// ============================================================================

Widget _palettesSection() {
  final List<_PaletteSpec> specs = [
    _PaletteSpec('Mint', const Color(0xFFE8F5EE), const Color(0xFF1E6F4D)),
    _PaletteSpec('Rose', const Color(0xFFFCE6EA), const Color(0xFFB23A5A)),
    _PaletteSpec('Sand', const Color(0xFFFAEFD8), const Color(0xFFB07418)),
    _PaletteSpec('Lilac', const Color(0xFFEEE2F6), const Color(0xFF6F3F8E)),
    _PaletteSpec('Steel', const Color(0xFFE2E7EE), const Color(0xFF334B6F)),
    _PaletteSpec('Coral', const Color(0xFFFAE0DB), const Color(0xFFB44D32)),
  ];
  return _sectionFrame(
    index: '05',
    title: 'Colour palette dialogs',
    tagline: 'PALETTE',
    primary: _copper,
    soft: _copperSoft,
    wash: _copperWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'Six AlertDialogs, each painted with a different DialogTheme '
          '.backgroundColor and a matching titleTextStyle colour.',
        ),
        _gap(18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.05,
          children: [for (final s in specs) _paletteCard(s)],
        ),
      ],
    ),
  );
}

class _PaletteSpec {
  final String name;
  final Color bg;
  final Color fg;
  const _PaletteSpec(this.name, this.bg, this.fg);
}

Widget _paletteCard(_PaletteSpec spec) {
  return _scrimStage(
    tint: spec.bg,
    child: _fakeDialog(
      width: 220,
      color: spec.bg,
      radius: BorderRadius.circular(18),
      border: Border.all(color: spec.fg.withValues(alpha: 0.35), width: 1.2),
      shadow: spec.fg.withValues(alpha: 0.25),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: spec.fg.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                spec.name.toUpperCase(),
                style: TextStyle(
                  color: spec.fg,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            _gap(10),
            Text(
              '${spec.name} dialog',
              style: TextStyle(
                color: spec.fg,
                fontSize: 15.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            _gap(8),
            const Text(
              'Painted via DialogTheme.backgroundColor and a colour-matched '
              'titleTextStyle.',
              style: TextStyle(
                color: _slate,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
            _gap(12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: spec.fg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 7 — ELEVATION STUDIES
// ============================================================================

Widget _elevationSection() {
  return _sectionFrame(
    index: '06',
    title: 'Elevation studies',
    tagline: 'ELEVATION',
    primary: _amber,
    soft: _amberSoft,
    wash: _amberWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DialogTheme.elevation governs the strength of the cast shadow. '
          'Here three identical dialogs sit at elevation 0, 4, and 12.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _elevationCard('FLAT', 0, _amber)),
            _wgap(14),
            Expanded(child: _elevationCard('LIFTED', 4, _amber)),
            _wgap(14),
            Expanded(child: _elevationCard('FLOATING', 12, _amber)),
          ],
        ),
      ],
    ),
  );
}

Widget _elevationCard(String label, double elevation, Color tint) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          _label(label, color: tint),
          _wgap(8),
          _kicker('e=$elevation', color: tint),
        ],
      ),
      _gap(8),
      _scrimStage(
        tint: _amberWash,
        child: _fakeDialog(
          width: 240,
          elevation: elevation,
          color: Colors.white,
          radius: BorderRadius.circular(16),
          shadow: tint.withValues(alpha: 0.35),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.layers_outlined, color: tint, size: 24),
                _gap(10),
                const Text(
                  'Elevation matters',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _gap(6),
                const Text(
                  'Shadow softness scales with z-depth.',
                  style: TextStyle(color: _subtle, fontSize: 12, height: 1.35),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 8 — ALIGNMENT MATRIX
// ============================================================================

Widget _alignmentSection() {
  const List<Alignment> rowOrder = [
    Alignment.topLeft, Alignment.topCenter, Alignment.topRight,
    Alignment.centerLeft, Alignment.center, Alignment.centerRight,
    Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight,
  ];
  const List<String> rowLabels = [
    'topLeft', 'topCenter', 'topRight',
    'centerLeft', 'center', 'centerRight',
    'bottomLeft', 'bottomCenter', 'bottomRight',
  ];
  return _sectionFrame(
    index: '07',
    title: 'Alignment matrix',
    tagline: 'ALIGNMENT',
    primary: _moss,
    soft: _mossSoft,
    wash: _mossWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DialogTheme.alignment positions the dialog inside the route. '
          'Here are all nine canonical Alignment.* values.',
        ),
        _gap(18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.25,
          children: [
            for (int i = 0; i < rowOrder.length; i++)
              _alignmentCell(rowLabels[i], rowOrder[i]),
          ],
        ),
      ],
    ),
  );
}

Widget _alignmentCell(String label, Alignment alignment) {
  return Container(
    decoration: BoxDecoration(
      color: _mossWash,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _mossSoft),
    ),
    padding: const EdgeInsets.all(10),
    child: Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: alignment,
            child: Container(
              width: 70,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: _moss, width: 1.2),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.chat_bubble_outline,
                color: _moss,
                size: 16,
              ),
            ),
          ),
        ),
        Positioned(
          left: 4,
          top: 4,
          child: Text(
            label,
            style: const TextStyle(
              color: _moss,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — SIMPLEDIALOG vs ALERTDIALOG vs DIALOG
// ============================================================================

Widget _flavoursSection() {
  return _sectionFrame(
    index: '08',
    title: 'SimpleDialog vs AlertDialog vs Dialog',
    tagline: 'FLAVOURS',
    primary: _navy,
    soft: _navySoft,
    wash: _navyWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'Three sibling widgets share DialogTheme but solve different '
          'problems. AlertDialog for decisions, SimpleDialog for choice '
          'menus, raw Dialog for fully custom surfaces.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _alertFlavour()),
            _wgap(16),
            Expanded(child: _simpleFlavour()),
            _wgap(16),
            Expanded(child: _customFlavour()),
          ],
        ),
      ],
    ),
  );
}

Widget _alertFlavour() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('AlertDialog', color: _navy),
      _gap(8),
      _scrimStage(
        tint: _navyWash,
        child: _fakeDialog(
          width: 240,
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 14),
            child: AlertDialog(
              title: Text('Discard draft?'),
              content: Text('Unsaved edits will be lost forever.'),
              actions: [],
            ),
          ),
        ),
      ),
      _gap(8),
      _caption('Title + content + actions row. Default Material spacing.'),
    ],
  );
}

Widget _simpleFlavour() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('SimpleDialog', color: _navy),
      _gap(8),
      _scrimStage(
        tint: _navyWash,
        child: _fakeDialog(
          width: 240,
          color: Colors.white,
          child: SimpleDialog(
            title: const Text('Pick a profile'),
            children: [
              _simpleDialogOption('Alex Porter', Icons.person_outline),
              _simpleDialogOption('Maya Costa', Icons.person_outline),
              _simpleDialogOption('Add account', Icons.add_circle_outline),
            ],
          ),
        ),
      ),
      _gap(8),
      _caption('Stack of SimpleDialogOption rows. Great for short menus.'),
    ],
  );
}

Widget _simpleDialogOption(String label, IconData icon) {
  return SimpleDialogOption(
    onPressed: () {},
    child: Row(
      children: [
        Icon(icon, color: _navy, size: 18),
        _wgap(10),
        Text(label),
      ],
    ),
  );
}

Widget _customFlavour() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('Dialog (raw)', color: _navy),
      _gap(8),
      _scrimStage(
        tint: _navyWash,
        child: _fakeDialog(
          width: 240,
          color: _navy,
          radius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.bolt, color: _navySoft, size: 26),
                _gap(10),
                const Text(
                  'Pro tip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                _gap(6),
                const Text(
                  'Build any surface you like — Dialog is just a Material '
                  'shell.',
                  style: TextStyle(
                    color: _navyWash,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                _gap(12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Got it',
                      style: TextStyle(color: _navyWash),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      _gap(8),
      _caption('Total freedom — no enforced anatomy.'),
    ],
  );
}

// ============================================================================
// SECTION 10 — ACTION STYLE VARIANTS
// ============================================================================

Widget _actionStyleSection() {
  return _sectionFrame(
    index: '09',
    title: 'Action button variants',
    tagline: 'ACTIONS',
    primary: _plum,
    soft: _plumSoft,
    wash: _plumWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'AlertDialog.actions accepts any widget. Pair a quiet TextButton '
          'with an OutlinedButton, FilledButton, or ElevatedButton to signal '
          'the primary action with progressively more weight.',
        ),
        _gap(18),
        _actionRow(
          'TEXT + TEXT',
          [
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            TextButton(onPressed: () {}, child: const Text('OK')),
          ],
        ),
        _actionRow(
          'TEXT + OUTLINED',
          [
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            OutlinedButton(onPressed: () {}, child: const Text('Continue')),
          ],
        ),
        _actionRow(
          'TEXT + FILLED',
          [
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            FilledButton(onPressed: () {}, child: const Text('Save')),
          ],
        ),
        _actionRow(
          'TEXT + ELEVATED',
          [
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            ElevatedButton(onPressed: () {}, child: const Text('Publish')),
          ],
        ),
        _actionRow(
          'DESTRUCTIVE',
          [
            TextButton(onPressed: () {}, child: const Text('Keep')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: _danger),
              onPressed: () {},
              child: const Text('Delete'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _actionRow(String label, List<Widget> actions) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: _plumWash,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _plumSoft),
    ),
    child: Row(
      children: [
        SizedBox(width: 140, child: _label(label, color: _plum)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int i = 0; i < actions.length; i++) ...[
                if (i > 0) _wgap(8),
                actions[i],
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — THEMEDATA CODE QUOTE
// ============================================================================

Widget _codeQuoteSection() {
  return _sectionFrame(
    index: '10',
    title: 'ThemeData.copyWith recipe',
    tagline: 'CODE QUOTE',
    primary: _ink,
    soft: _slate,
    wash: _mist,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'A typical DialogTheme override applied at the ThemeData level. '
          'Every dialog in the subtree inherits these defaults.',
        ),
        _gap(16),
        _codeQuote(
          'ThemeData(\n'
          '  dialogTheme: DialogTheme(\n'
          '    backgroundColor: Color(0xFFFBF9F1),\n'
          '    surfaceTintColor: Color(0xFFB7541C),\n'
          '    shadowColor: Color(0xFF1B1A2E),\n'
          '    elevation: 10,\n'
          '    alignment: Alignment.center,\n'
          '    shape: RoundedRectangleBorder(\n'
          '      borderRadius: BorderRadius.circular(20),\n'
          '    ),\n'
          '    titleTextStyle: TextStyle(\n'
          '      color: Color(0xFF1B1A2E),\n'
          '      fontSize: 20,\n'
          '      fontWeight: FontWeight.w800,\n'
          '    ),\n'
          '    contentTextStyle: TextStyle(\n'
          '      color: Color(0xFF5F5A6E),\n'
          '      fontSize: 14,\n'
          '      height: 1.5,\n'
          '    ),\n'
          '    iconColor: Color(0xFFB7541C),\n'
          '    actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),\n'
          '  ),\n'
          ');',
        ),
        _gap(14),
        _caption(
          'Tip: in Material 3, use DialogThemeData and ThemeData(useMaterial3: '
          'true) to opt into the modern token system.',
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 — GLOSSARY
// ============================================================================

Widget _glossarySection() {
  final List<List<String>> rows = [
    [
      'backgroundColor',
      'Fill colour of the dialog surface.',
    ],
    [
      'surfaceTintColor',
      'Material 3 elevation tint overlay, blended over background.',
    ],
    [
      'shadowColor',
      'Colour of the shadow drop beneath the surface.',
    ],
    [
      'elevation',
      'Z-depth — drives shadow size and surfaceTint strength.',
    ],
    [
      'shape',
      'ShapeBorder applied to the perimeter (rounded, stadium, cut).',
    ],
    [
      'alignment',
      'Where the dialog sits inside the modal route.',
    ],
    [
      'titleTextStyle',
      'Default TextStyle for AlertDialog.title.',
    ],
    [
      'contentTextStyle',
      'Default TextStyle for AlertDialog.content.',
    ],
    [
      'iconColor',
      'Tint for the optional leading icon slot (M3).',
    ],
    [
      'actionsPadding',
      'EdgeInsets around the actions row.',
    ],
    [
      'insetPadding',
      'Outer margin between dialog and screen edges.',
    ],
    [
      'barrierColor',
      'Scrim colour rendered behind the dialog.',
    ],
  ];
  return _sectionFrame(
    index: '11',
    title: 'Glossary',
    tagline: 'GLOSSARY',
    primary: _moss,
    soft: _mossSoft,
    wash: _mossWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'A quick lookup of every DialogTheme property covered in this '
          'demo. Each row is a property name on the left and its plain-'
          'English purpose on the right.',
        ),
        _gap(16),
        for (final r in rows) _glossaryRow(r[0], r[1]),
      ],
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: _mossWash,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _mossSoft),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            term,
            style: const TextStyle(
              color: _moss,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            def,
            style: const TextStyle(
              color: _ink,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 — REAL-WORLD RECIPES
// ============================================================================

Widget _recipesSection() {
  return _sectionFrame(
    index: '12',
    title: 'Real-world recipes',
    tagline: 'RECIPES',
    primary: _danger,
    soft: _dangerSoft,
    wash: _dangerWash,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'Three composed examples a Material app might ship — a friendly '
          'info dialog, a confirmation dialog, and a high-stakes destructive '
          'dialog. All hand-rendered, no async APIs involved.',
        ),
        _gap(18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _infoRecipe()),
            _wgap(16),
            Expanded(child: _confirmRecipe()),
            _wgap(16),
            Expanded(child: _destructiveRecipe()),
          ],
        ),
      ],
    ),
  );
}

Widget _infoRecipe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('INFO', color: _navy),
      _gap(8),
      _scrimStage(
        tint: _navyWash,
        child: _fakeDialog(
          width: 250,
          color: Colors.white,
          radius: BorderRadius.circular(18),
          shadow: _navy.withValues(alpha: 0.30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _navyWash,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.info_outline, color: _navy),
                ),
                _gap(14),
                const Text(
                  'New feature available',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                _gap(8),
                const Text(
                  'You can now drag widgets directly onto the canvas. '
                  'Try it from the toolbox panel.',
                  style: TextStyle(
                    color: _subtle,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                _gap(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: _navy),
                    onPressed: () {},
                    child: const Text('Got it'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _confirmRecipe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('CONFIRM', color: _moss),
      _gap(8),
      _scrimStage(
        tint: _mossWash,
        child: _fakeDialog(
          width: 250,
          color: Colors.white,
          radius: BorderRadius.circular(18),
          shadow: _moss.withValues(alpha: 0.30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.cloud_upload_outlined,
                    color: _moss, size: 28),
                _gap(12),
                const Text(
                  'Publish article?',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                _gap(8),
                const Text(
                  'This will make the draft visible to all readers. You '
                  'can unpublish later from the dashboard.',
                  style: TextStyle(
                    color: _subtle,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                _gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: _subtle),
                      ),
                    ),
                    _wgap(4),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: _moss),
                      onPressed: () {},
                      child: const Text('Publish'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _destructiveRecipe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('DESTRUCTIVE', color: _danger),
      _gap(8),
      _scrimStage(
        tint: _dangerWash,
        child: _fakeDialog(
          width: 250,
          color: Colors.white,
          radius: BorderRadius.circular(18),
          shadow: _danger.withValues(alpha: 0.35),
          border: Border.all(color: _dangerSoft, width: 1.2),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _dangerWash,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: _danger,
                  ),
                ),
                _gap(14),
                const Text(
                  'Delete workspace?',
                  style: TextStyle(
                    color: _danger,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                _gap(8),
                const Text(
                  'This cannot be undone. All boards, drafts, and assets '
                  'will be permanently removed.',
                  style: TextStyle(
                    color: _subtle,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                _gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Keep',
                        style: TextStyle(color: _subtle),
                      ),
                    ),
                    _wgap(4),
                    FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(
                        backgroundColor: _danger,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      onPressed: () {},
                      label: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 14 — EPILOGUE
// ============================================================================

Widget _epilogueSection() {
  return Container(
    margin: const EdgeInsets.fromLTRB(24, 12, 24, 36),
    padding: const EdgeInsets.fromLTRB(32, 30, 32, 32),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_slate, _ink],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('EPILOGUE', color: _copperSoft),
        _gap(14),
        const Text(
          'Takeaways',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        _gap(14),
        _epilogueLine(
          'DialogTheme centralises every dialog default — set it once at '
          'ThemeData level and every AlertDialog/SimpleDialog inherits.',
        ),
        _epilogueLine(
          'Use shape and elevation to tune the silhouette and the visual '
          'weight of your modal stack.',
        ),
        _epilogueLine(
          'Pair a quiet TextButton with one stronger FilledButton to '
          'communicate the primary action without shouting.',
        ),
        _epilogueLine(
          'Reach for SimpleDialog when offering a list of choices, '
          'AlertDialog for decisions, raw Dialog for fully bespoke shells.',
        ),
        _epilogueLine(
          'Treat destructive actions with extra care: warm red palette, '
          'icon cue, irreversible copy, FilledButton primary.',
        ),
      ],
    ),
  );
}

Widget _epilogueLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, right: 12),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _copperSoft,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFE6DEF5),
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _mist,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _copper,
        primary: _copper,
        surface: _paper,
      ),
    ),
    home: Scaffold(
      backgroundColor: _mist,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroHeader(),
            _conceptSection(),
            _anatomySection(),
            _defaultVsThemedSection(),
            _shapeSection(),
            _palettesSection(),
            _elevationSection(),
            _alignmentSection(),
            _flavoursSection(),
            _actionStyleSection(),
            _codeQuoteSection(),
            _glossarySection(),
            _recipesSection(),
            _epilogueSection(),
          ],
        ),
      ),
    ),
  );
}
