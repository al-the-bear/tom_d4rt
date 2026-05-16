// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Visibility Toggle Gallery
// Theme: "Visibility Toggle Gallery" - a hand-crafted showcase of Visibility,
// SliverVisibility, Offstage, IgnorePointer, AbsorbPointer, ExcludeSemantics,
// and the various maintain* flags. Side-by-side panels render the same content
// in visible vs invisible states using replacement / Offstage / maintain*
// combinations, with palette swatches, recipe cards, comparison grids and
// a closing glossary.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE TOKENS - "Toggle Gallery" — emerald, dusk, citrus, rose
// ============================================================================

const Color _galleryInk = Color(0xFF0B1A22);
const Color _gallerySlate = Color(0xFF1C2E3A);
const Color _galleryMist = Color(0xFFEFF7F4);
const Color _galleryPaper = Color(0xFFFBFEFC);
const Color _galleryLine = Color(0xFFCBDDD5);
const Color _gallerySubtle = Color(0xFF55706A);
const Color _galleryFog = Color(0xFFE3ECE8);

const Color _sec1Primary = Color(0xFF1F8E6E); // Primitives - emerald
const Color _sec1Accent = Color(0xFF8FD8C3);
const Color _sec1Surface = Color(0xFFDFF2EB);

const Color _sec2Primary = Color(0xFF1F6FB5); // Visible vs invisible - ocean
const Color _sec2Accent = Color(0xFF9CC6E8);
const Color _sec2Surface = Color(0xFFE0EDF7);

const Color _sec3Primary = Color(0xFFA84A8C); // maintainState - magenta
const Color _sec3Accent = Color(0xFFE3A7CE);
const Color _sec3Surface = Color(0xFFF7E3EE);

const Color _sec4Primary = Color(0xFFB05A1F); // maintainAnimation - copper
const Color _sec4Accent = Color(0xFFE7B58A);
const Color _sec4Surface = Color(0xFFF9E7D4);

const Color _sec5Primary = Color(0xFF4A6BC5); // maintainSize - cobalt
const Color _sec5Accent = Color(0xFFAEBDE6);
const Color _sec5Surface = Color(0xFFE3E9F7);

const Color _sec6Primary = Color(0xFF246C6A); // maintainSemantics - teal
const Color _sec6Accent = Color(0xFF95C6C4);
const Color _sec6Surface = Color(0xFFDAEBEA);

const Color _sec7Primary = Color(0xFF8B3A62); // maintainInteractivity - berry
const Color _sec7Accent = Color(0xFFD49DB6);
const Color _sec7Surface = Color(0xFFF1DBE5);

const Color _sec8Primary = Color(0xFF5C4AA8); // replacement - indigo
const Color _sec8Accent = Color(0xFFB6ABE3);
const Color _sec8Surface = Color(0xFFE5DFF6);

const Color _sec9Primary = Color(0xFF1F5D7A); // Offstage - deep blue
const Color _sec9Accent = Color(0xFF96BBCC);
const Color _sec9Surface = Color(0xFFDDEAF1);

const Color _sec10Primary = Color(0xFFB04A3A); // IgnorePointer/Absorb - terracotta
const Color _sec10Accent = Color(0xFFE6A89A);
const Color _sec10Surface = Color(0xFFF7DFD7);

const Color _sec11Primary = Color(0xFF3C7A1F); // SliverVisibility - moss
const Color _sec11Accent = Color(0xFFAFD49A);
const Color _sec11Surface = Color(0xFFE2F0D6);

const Color _sec12Primary = Color(0xFF514F4C); // Flag combinations - graphite
const Color _sec12Accent = Color(0xFFB0ADAA);
const Color _sec12Surface = Color(0xFFE7E5E2);

// ============================================================================
// SHARED VISUAL HELPERS
// ============================================================================

Widget _gap(double h) => SizedBox(height: h);
Widget _wgap(double w) => SizedBox(width: w);

Widget _label(
  String text, {
  Color color = _galleryInk,
  double size = 12.0,
  FontWeight weight = FontWeight.w600,
  double letter = 0.4,
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

Widget _heading(
  String text, {
  Color color = _galleryInk,
  double size = 22.0,
}) {
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

Widget _body(
  String text, {
  Color color = _gallerySubtle,
  double size = 13.0,
  double height = 1.45,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget _badge(String text, Color color, {Color fg = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(99.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
    ),
  );
}

Widget _chip(String text, Color tone) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: tone.withOpacity(0.18),
      borderRadius: BorderRadius.circular(99.0),
      border: Border.all(color: tone.withOpacity(0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
        ),
        _wgap(6.0),
        Text(
          text,
          style: TextStyle(
            color: _galleryInk,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _swatch(Color c, String name) {
  return Container(
    margin: const EdgeInsets.only(right: 12.0),
    width: 84.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 44.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _galleryLine, width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: c.withOpacity(0.25),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
        ),
        _gap(6.0),
        _label(
          name,
          size: 10.5,
          weight: FontWeight.w700,
          letter: 0.6,
          color: _gallerySlate,
        ),
      ],
    ),
  );
}

Widget _palette(List<List<dynamic>> entries) {
  final List<Widget> chips = <Widget>[];
  for (final List<dynamic> row in entries) {
    chips.add(_swatch(row[0] as Color, row[1] as String));
  }
  return Row(children: chips);
}

Widget _sectionBanner({
  required int number,
  required String title,
  required String subtitle,
  required Color primary,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 14.0),
    padding: const EdgeInsets.fromLTRB(22.0, 18.0, 22.0, 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[primary, accent],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: primary.withOpacity(0.28),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.45),
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                number.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              Positioned(
                right: 4.0,
                top: 4.0,
                child: Icon(
                  icon,
                  size: 12.0,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
        _wgap(16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              _gap(4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required List<String> bullets,
  required Color accent,
}) {
  final List<Widget> lines = <Widget>[];
  for (final String b in bullets) {
    lines.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6.0, right: 10.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: _body(b, color: _gallerySlate, size: 12.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 14.0),
    decoration: BoxDecoration(
      color: _galleryPaper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.menu_book_rounded,
                size: 16.0,
                color: Colors.white,
              ),
            ),
            _wgap(10.0),
            _heading('Recipe — $title', size: 14.5, color: _galleryInk),
          ],
        ),
        _gap(10.0),
        ...lines,
      ],
    ),
  );
}

Widget _codeQuote(String title, String code, Color accent) {
  return Container(
    margin: const EdgeInsets.only(top: 14.0),
    decoration: BoxDecoration(
      color: _galleryInk,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.85),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.code_rounded, color: Colors.white, size: 16.0),
              _wgap(8.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 16.0),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE3F1EB),
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kvTable(String caption, List<List<String>> rows, Color accent) {
  final List<TableRow> tableRows = <TableRow>[];
  tableRows.add(
    TableRow(
      decoration: BoxDecoration(color: accent.withOpacity(0.18)),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label(
            'Property',
            size: 11.5,
            weight: FontWeight.w800,
            color: _galleryInk,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label(
            'Value',
            size: 11.5,
            weight: FontWeight.w800,
            color: _galleryInk,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label(
            'Effect',
            size: 11.5,
            weight: FontWeight.w800,
            color: _galleryInk,
          ),
        ),
      ],
    ),
  );
  for (int i = 0; i < rows.length; i++) {
    final List<String> r = rows[i];
    tableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: i.isEven ? _galleryPaper : _galleryMist,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.0,
            ),
            child: Text(
              r[0],
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: _galleryInk,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.0,
            ),
            child: Text(
              r[1],
              style: const TextStyle(fontSize: 11.5, color: _gallerySlate),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.0,
            ),
            child: Text(
              r[2],
              style: const TextStyle(
                fontSize: 11.5,
                color: _gallerySubtle,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.only(top: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          color: _gallerySlate,
          child: _label(
            caption,
            color: Colors.white,
            size: 12.0,
            weight: FontWeight.w700,
            letter: 0.6,
          ),
        ),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(1.3),
            2: FlexColumnWidth(2.4),
          },
          children: tableRows,
        ),
      ],
    ),
  );
}

Widget _section({
  required int number,
  required String title,
  required String subtitle,
  required Color primary,
  required Color accent,
  required Color surface,
  required IconData icon,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 22.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionBanner(
          number: number,
          title: title,
          subtitle: subtitle,
          primary: primary,
          accent: accent,
          icon: icon,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _galleryLine, width: 1.0),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _captionedCard({
  required String title,
  required String caption,
  required Color tone,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 14.0),
    decoration: BoxDecoration(
      color: _galleryPaper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _galleryLine, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withOpacity(0.10),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
          decoration: BoxDecoration(
            color: tone.withOpacity(0.12),
            border: Border(
              bottom: BorderSide(color: tone.withOpacity(0.4), width: 1.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: tone,
                  shape: BoxShape.circle,
                ),
              ),
              _wgap(10.0),
              Expanded(
                child: _label(
                  title,
                  size: 12.5,
                  weight: FontWeight.w800,
                  color: _galleryInk,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 12.0),
          child: body,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 12.0),
          child: _body(caption, size: 11.5, height: 1.5),
        ),
      ],
    ),
  );
}

// A boxed demo subject used for visible/invisible side-by-side comparisons.
Widget _subjectBox(String label, Color tone, {double height = 60.0}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[tone, tone.withOpacity(0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withOpacity(0.3),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 13.0,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// A dotted/hatched border container to indicate "collapsed space" placeholder.
Widget _placeholderSlot(String tag, {double height = 60.0}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: _galleryFog,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: _gallerySubtle.withOpacity(0.5),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      tag,
      style: const TextStyle(
        color: _gallerySubtle,
        fontWeight: FontWeight.w700,
        fontSize: 11.0,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _sideBySide({
  required String leftLabel,
  required Widget left,
  required String rightLabel,
  required Widget right,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _label(
              leftLabel,
              size: 10.5,
              weight: FontWeight.w800,
              color: _gallerySlate,
              letter: 0.6,
            ),
            _gap(6.0),
            left,
          ],
        ),
      ),
      _wgap(12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _label(
              rightLabel,
              size: 10.5,
              weight: FontWeight.w800,
              color: _gallerySlate,
              letter: 0.6,
            ),
            _gap(6.0),
            right,
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================

Widget _hero() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 32.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_galleryInk, _gallerySlate, _sec1Primary],
        stops: <double>[0.0, 0.55, 1.0],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46.0,
              height: 46.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.visibility_rounded,
                size: 22.0,
                color: Colors.white,
              ),
            ),
            _wgap(14.0),
            const Text(
              'VISIBILITY — TOGGLE GALLERY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                letterSpacing: 2.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        _gap(18.0),
        const Text(
          'Show, Hide, Preserve',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.2,
            height: 1.1,
          ),
        ),
        _gap(10.0),
        Text(
          'A hand-curated walkthrough of Visibility, SliverVisibility, Offstage, '
          'IgnorePointer, AbsorbPointer, ExcludeSemantics and the maintain* flag '
          'family. Each section pairs a real side-by-side demo, palette swatches, '
          'a recipe and a property table.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.86),
            fontSize: 14.0,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        _gap(22.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _heroTag('Visibility', _sec1Accent),
            _heroTag('SliverVisibility', _sec11Accent),
            _heroTag('Offstage', _sec9Accent),
            _heroTag('IgnorePointer', _sec10Accent),
            _heroTag('AbsorbPointer', _sec10Accent),
            _heroTag('ExcludeSemantics', _sec6Accent),
            _heroTag('maintainState', _sec3Accent),
            _heroTag('maintainAnimation', _sec4Accent),
            _heroTag('maintainSize', _sec5Accent),
            _heroTag('maintainSemantics', _sec6Accent),
            _heroTag('maintainInteractivity', _sec7Accent),
            _heroTag('replacement', _sec8Accent),
          ],
        ),
      ],
    ),
  );
}

Widget _heroTag(String text, Color tone) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(99.0),
      border: Border.all(color: tone, width: 1.2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
        ),
        _wgap(8.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================

Widget _overview() {
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0.0),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 18.0),
    decoration: BoxDecoration(
      color: _galleryPaper,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _galleryLine, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _sec1Primary.withOpacity(0.06),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: _sec1Surface,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec1Accent, width: 1.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.lightbulb_rounded,
                color: _sec1Primary,
                size: 18.0,
              ),
            ),
            _wgap(12.0),
            _heading('Why a toggle gallery?', size: 16.0),
          ],
        ),
        _gap(10.0),
        _body(
          'Hiding a widget is never a single decision. Should it collapse to zero '
          'space, or hold its slot? Should its State live on, or be discarded? '
          'Should screen readers still announce it? Should it still receive taps? '
          'This gallery answers each question with a paired visible/invisible demo '
          'so the trade-offs are obvious at a glance.',
          size: 13.0,
        ),
        _gap(14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _chip('layout', _sec5Primary),
            _chip('state', _sec3Primary),
            _chip('animation', _sec4Primary),
            _chip('semantics', _sec6Primary),
            _chip('hit-test', _sec7Primary),
            _chip('replacement', _sec8Primary),
            _chip('slivers', _sec11Primary),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: VISIBILITY PRIMITIVES
// ============================================================================

Widget _section1(BuildContext context) {
  return _section(
    number: 1,
    title: 'Visibility Primitives',
    subtitle: 'The toolbox: Visibility, Offstage, IgnorePointer, AbsorbPointer.',
    primary: _sec1Primary,
    accent: _sec1Accent,
    surface: _sec1Surface,
    icon: Icons.toggle_on_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Four primitives, four jobs', size: 16.0, color: _sec1Primary),
        _gap(6.0),
        _body(
          'Each widget answers one question. Visibility decides if the child is '
          'in the layout at all. Offstage paints nothing but can hold a slot. '
          'IgnorePointer and AbsorbPointer change hit-test behaviour without '
          'touching paint.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec1Primary, 'emerald'],
          <dynamic>[_sec1Accent, 'mint'],
          <dynamic>[_sec1Surface, 'froth'],
          <dynamic>[_galleryFog, 'fog'],
          <dynamic>[_galleryInk, 'ink'],
        ]),
        _captionedCard(
          title: 'Visibility — the workhorse',
          caption:
              'Visibility wraps a child and decides whether to insert it into '
              'the tree. With flags, it can keep state, animation, layout slot, '
              'semantics, or interactivity.',
          tone: _sec1Primary,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _sideBySide(
                leftLabel: 'visible: true',
                left: Visibility(
                  visible: true,
                  child: _subjectBox('Visible child', _sec1Primary),
                ),
                rightLabel: 'visible: false (collapses)',
                right: Container(
                  decoration: BoxDecoration(
                    color: _galleryFog,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: _gallerySubtle.withOpacity(0.4),
                    ),
                  ),
                  height: 60.0,
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: false,
                    child: _subjectBox('Hidden', _sec1Primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'Offstage — paints nothing, can still be measured',
          caption:
              'Offstage removes the child from painting and hit testing but '
              'keeps it laid out off-screen when measured. Useful for pre-warming '
              'expensive widgets.',
          tone: _sec9Primary,
          body: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _label(
                      'offstage: false',
                      size: 10.5,
                      weight: FontWeight.w800,
                      color: _gallerySlate,
                    ),
                    _gap(6.0),
                    Offstage(
                      offstage: false,
                      child: _subjectBox('On stage', _sec9Primary),
                    ),
                  ],
                ),
              ),
              _wgap(12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _label(
                      'offstage: true',
                      size: 10.5,
                      weight: FontWeight.w800,
                      color: _gallerySlate,
                    ),
                    _gap(6.0),
                    Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: _galleryFog,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: _sec9Primary.withOpacity(0.4),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Offstage(
                        offstage: true,
                        child: _subjectBox('Hidden offstage', _sec9Primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'IgnorePointer vs AbsorbPointer',
          caption:
              'IgnorePointer makes the subtree invisible to hit tests; events '
              'pass through. AbsorbPointer also blocks events but consumes them, '
              'so widgets behind do NOT receive them.',
          tone: _sec10Primary,
          body: Column(
            children: <Widget>[
              _sideBySide(
                leftLabel: 'IgnorePointer(ignoring: true)',
                left: IgnorePointer(
                  ignoring: true,
                  child: _subjectBox('Taps pass through', _sec10Primary),
                ),
                rightLabel: 'AbsorbPointer(absorbing: true)',
                right: AbsorbPointer(
                  absorbing: true,
                  child: _subjectBox('Taps absorbed', _sec10Primary),
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'ExcludeSemantics — accessibility opt-out',
          caption:
              'ExcludeSemantics drops the subtree from the semantics tree '
              'without changing pixels or hit-testing. Pair it with decorative '
              'graphics or duplicate icons.',
          tone: _sec6Primary,
          body: ExcludeSemantics(
            excluding: true,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _subjectBox('Decorative — not announced', _sec6Primary),
                ),
              ],
            ),
          ),
        ),
        _recipeCard(
          title: 'Choosing a primitive',
          bullets: <String>[
            'Want to control layout slot AND paint? — Visibility.',
            'Want to keep measurement but skip paint? — Offstage.',
            'Want to block taps without changing pixels? — IgnorePointer or AbsorbPointer.',
            'Want to hide from screen readers only? — ExcludeSemantics.',
          ],
          accent: _sec1Accent,
        ),
        _kvTable(
          'Primitive cheat sheet',
          <List<String>>[
            <String>[
              'Visibility',
              'visible / maintain*',
              'Single widget gates layout, paint, state, hit-test.',
            ],
            <String>[
              'Offstage',
              'offstage',
              'Skips paint and hit-test; layout still measured.',
            ],
            <String>[
              'IgnorePointer',
              'ignoring',
              'Skips hit-test for subtree; events pass to lower widgets.',
            ],
            <String>[
              'AbsorbPointer',
              'absorbing',
              'Blocks events at this subtree; lower widgets do not see them.',
            ],
            <String>[
              'ExcludeSemantics',
              'excluding',
              'Hides subtree from a11y tree without touching paint/layout.',
            ],
            <String>[
              'SliverVisibility',
              'visible / maintain*',
              'Same idea as Visibility, but for sliver children.',
            ],
          ],
          _sec1Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2: VISIBLE VS INVISIBLE STATES
// ============================================================================

Widget _section2(BuildContext context) {
  return _section(
    number: 2,
    title: 'Visible vs Invisible States',
    subtitle: 'Default behaviour — collapsing space when visible is false.',
    primary: _sec2Primary,
    accent: _sec2Accent,
    surface: _sec2Surface,
    icon: Icons.compare_arrows_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('What "invisible" really means', size: 16.0, color: _sec2Primary),
        _gap(6.0),
        _body(
          'By default Visibility(visible: false) is equivalent to inserting a '
          'zero-size SizedBox.shrink in place of the child. The widget is rebuilt '
          'each frame but its child is not laid out, painted, or hit tested.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec2Primary, 'ocean'],
          <dynamic>[_sec2Accent, 'sky'],
          <dynamic>[_sec2Surface, 'cloud'],
          <dynamic>[_galleryInk, 'ink'],
        ]),
        _captionedCard(
          title: 'A: visible=true vs visible=false (default)',
          caption:
              'When visible flips to false, the slot collapses. Surrounding '
              'widgets reflow to fill the vacated space.',
          tone: _sec2Primary,
          body: _sideBySide(
            leftLabel: 'visible: true',
            left: Visibility(
              visible: true,
              child: _subjectBox('Filled slot', _sec2Primary),
            ),
            rightLabel: 'visible: false (collapsed)',
            right: Container(
              decoration: BoxDecoration(
                color: _galleryFog,
                border: Border.all(color: _gallerySubtle.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 60.0,
              alignment: Alignment.center,
              child: Visibility(
                visible: false,
                child: _subjectBox('Hidden', _sec2Primary),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: reflow demo — three siblings, one toggled',
          caption:
              'The middle slot disappears; the right slot slides to fill its '
              'place. This is the most common bug when "the layout jumps".',
          tone: _sec2Accent,
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _subjectBox('A', _sec2Primary)),
                  _wgap(8.0),
                  Expanded(
                    child: Visibility(
                      visible: true,
                      child: _subjectBox('B (visible)', _sec2Accent),
                    ),
                  ),
                  _wgap(8.0),
                  Expanded(child: _subjectBox('C', _sec2Primary)),
                ],
              ),
              _gap(10.0),
              Row(
                children: <Widget>[
                  Expanded(child: _subjectBox('A', _sec2Primary)),
                  _wgap(8.0),
                  Visibility(
                    visible: false,
                    child: Expanded(
                      child: _subjectBox('B (hidden)', _sec2Accent),
                    ),
                  ),
                  _wgap(8.0),
                  Expanded(child: _subjectBox('C', _sec2Primary)),
                ],
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: invisible boundary',
          caption:
              'Wrap the invisible Visibility in a sized Container to make the '
              'collapsed slot visible at design time — useful for debugging.',
          tone: _sec2Primary,
          body: Container(
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _sec2Primary.withOpacity(0.4),
                width: 1.4,
              ),
              color: _galleryFog,
            ),
            alignment: Alignment.center,
            child: Visibility(
              visible: false,
              child: _subjectBox('Inside', _sec2Primary),
            ),
          ),
        ),
        _recipeCard(
          title: 'Default behaviour rules',
          bullets: <String>[
            'visible=false collapses the layout slot.',
            'No paint, no layout, no hit-test, no semantics, no state.',
            'The Visibility widget itself rebuilds — only its child is skipped.',
            'Pair maintain* flags when any of those should be preserved.',
          ],
          accent: _sec2Accent,
        ),
        _codeQuote(
          'Visibility — minimal',
          'Visibility(\n'
              '  visible: showHero,\n'
              '  child: HeroPanel(),\n'
              ');',
          _sec2Primary,
        ),
        _kvTable(
          'visible flag effects (default flags)',
          <List<String>>[
            <String>['visible', 'true', 'Renders child normally.'],
            <String>[
              'visible',
              'false',
              'Removes child entirely; slot collapses.',
            ],
            <String>[
              'reflow',
              'implicit',
              'Siblings move to fill freed space.',
            ],
            <String>[
              'rebuild cost',
              'O(1)',
              'Only Visibility itself rebuilds; child subtree skipped.',
            ],
          ],
          _sec2Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3: maintainState FLAG
// ============================================================================

Widget _section3(BuildContext context) {
  return _section(
    number: 3,
    title: 'maintainState Flag',
    subtitle: 'Keep StatefulWidget state alive across visibility toggles.',
    primary: _sec3Primary,
    accent: _sec3Accent,
    surface: _sec3Surface,
    icon: Icons.memory_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Why maintainState matters', size: 16.0, color: _sec3Primary),
        _gap(6.0),
        _body(
          'When visible flips back to true, the child is rebuilt from scratch '
          'by default. That means a TextField loses its text, a Scrollable '
          'jumps to offset 0, and a video player tears down its controller. '
          'maintainState keeps the Element subtree alive so State objects '
          'survive the hidden interval.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec3Primary, 'magenta'],
          <dynamic>[_sec3Accent, 'rose'],
          <dynamic>[_sec3Surface, 'blush'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: state lost (maintainState: false)',
          caption:
              'When invisible, the child is unmounted. A TextField inside would '
              'lose its text once shown again. The slot also collapses.',
          tone: _sec3Primary,
          body: _sideBySide(
            leftLabel: 'visible: true',
            left: _subjectBox('TextField{value=hello}', _sec3Primary),
            rightLabel: 'visible: false, maintainState: false',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _gallerySubtle.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'STATE UNMOUNTED',
                style: TextStyle(
                  color: _gallerySubtle,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  fontSize: 11.0,
                ),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: state preserved (maintainState: true)',
          caption:
              'The child remains mounted, just skipped during paint and layout. '
              'When visible flips back, the TextField still has its text.',
          tone: _sec3Accent,
          body: _sideBySide(
            leftLabel: 'visible: true',
            left: _subjectBox('TextField{value=hello}', _sec3Primary),
            rightLabel: 'visible: false, maintainState: true',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec3Primary.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: Visibility(
                visible: false,
                maintainState: true,
                child: _subjectBox('alive but unpainted', _sec3Primary),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'C: scroll position preserved',
          caption:
              'A ListView inside a hidden Visibility forgets its scroll offset '
              'unless maintainState is true. Toggling tabs is a classic case.',
          tone: _sec3Primary,
          body: Container(
            decoration: BoxDecoration(
              color: _galleryPaper,
              border: Border.all(color: _sec3Accent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _label('Pseudo-scroll', size: 11.0, color: _gallerySlate),
                _gap(6.0),
                Row(
                  children: <Widget>[
                    _badge('offset 0', _sec3Primary),
                    _wgap(6.0),
                    _badge('offset 142', _sec3Accent, fg: _galleryInk),
                    _wgap(6.0),
                    _badge('offset 318', _sec3Primary),
                  ],
                ),
                _gap(6.0),
                _body(
                  'maintainState lets the Scrollable retain offset 318 even '
                  'while hidden.',
                  size: 11.5,
                ),
              ],
            ),
          ),
        ),
        _recipeCard(
          title: 'When to set maintainState: true',
          bullets: <String>[
            'TextEditingController and FormField values you do not want to lose.',
            'ScrollControllers — preserves scroll offset across hides.',
            'Heavy widget that you do not want to rebuild on every toggle.',
            'Animations: combine with maintainAnimation to keep them running.',
          ],
          accent: _sec3Accent,
        ),
        _codeQuote(
          'maintainState — example',
          'Visibility(\n'
              '  visible: showForm,\n'
              '  maintainState: true,\n'
              '  child: MyEditableForm(),\n'
              ');',
          _sec3Primary,
        ),
        _kvTable(
          'maintainState — effects',
          <List<String>>[
            <String>[
              'State alive',
              'true',
              'Element + State retained while invisible.',
            ],
            <String>[
              'Layout',
              'skipped',
              'Layout/paint/hit-test still skipped — slot still collapses.',
            ],
            <String>[
              'Memory',
              'preserved',
              'Subtree memory not freed; budget accordingly.',
            ],
            <String>[
              'Rebuild',
              'avoided',
              'No mount/unmount thrash when toggling.',
            ],
          ],
          _sec3Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: maintainAnimation FLAG
// ============================================================================

Widget _section4(BuildContext context) {
  return _section(
    number: 4,
    title: 'maintainAnimation Flag',
    subtitle: 'Keep AnimationControllers ticking while invisible.',
    primary: _sec4Primary,
    accent: _sec4Accent,
    surface: _sec4Surface,
    icon: Icons.animation_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Animations and visibility', size: 16.0, color: _sec4Primary),
        _gap(6.0),
        _body(
          'maintainAnimation keeps the subtree ticking — AnimationControllers '
          'continue advancing, even though the result is not painted. It '
          'requires maintainState to be true. Without it, controllers freeze '
          'or are torn down when invisible.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec4Primary, 'copper'],
          <dynamic>[_sec4Accent, 'amber'],
          <dynamic>[_sec4Surface, 'cream'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: animation frozen (default)',
          caption:
              'Without the flag, an animation that was at t=0.6 will stop '
              'advancing and resume jumpily when re-shown.',
          tone: _sec4Primary,
          body: _sideBySide(
            leftLabel: 'visible: true (running)',
            left: FadeTransition(
              opacity: const AlwaysStoppedAnimation<double>(0.6),
              child: _subjectBox('opacity 0.60', _sec4Primary),
            ),
            rightLabel: 'visible: false (frozen)',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _gallerySubtle.withOpacity(0.5)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'CTRL PAUSED',
                style: TextStyle(
                  color: _gallerySubtle,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: animation alive (maintainAnimation: true)',
          caption:
              'With maintainAnimation + maintainState, the controller keeps '
              'advancing. When re-shown, the animation continues from t=0.83 '
              'as if it never disappeared.',
          tone: _sec4Accent,
          body: _sideBySide(
            leftLabel: 'visible: true',
            left: FadeTransition(
              opacity: const AlwaysStoppedAnimation<double>(0.83),
              child: _subjectBox('opacity 0.83', _sec4Primary),
            ),
            rightLabel: 'visible: false, maintainAnimation: true',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec4Primary.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                child: FadeTransition(
                  opacity: const AlwaysStoppedAnimation<double>(0.83),
                  child: _subjectBox('still ticking', _sec4Primary),
                ),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'C: rotation snapshot',
          caption:
              'A RotationTransition reaches a particular angle. The maintainAnimation '
              'flag means re-showing does not snap back to 0.',
          tone: _sec4Primary,
          body: Row(
            children: <Widget>[
              Expanded(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation<double>(0.08),
                  child: _subjectBox('rot 0.08', _sec4Accent),
                ),
              ),
              _wgap(8.0),
              Expanded(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation<double>(0.16),
                  child: _subjectBox('rot 0.16', _sec4Accent),
                ),
              ),
              _wgap(8.0),
              Expanded(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation<double>(0.24),
                  child: _subjectBox('rot 0.24', _sec4Accent),
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Pairing rules',
          bullets: <String>[
            'maintainAnimation requires maintainState: true.',
            'Useful for spinners and loading indicators inside collapsed panels.',
            'Animations still cost CPU — consider pausing the controller manually if not needed.',
            'Combine with maintainSize for placeholder shimmer that "kept rolling".',
          ],
          accent: _sec4Accent,
        ),
        _codeQuote(
          'maintainAnimation — example',
          'Visibility(\n'
              '  visible: showSpinner,\n'
              '  maintainState: true,\n'
              '  maintainAnimation: true,\n'
              '  child: CircularProgressIndicator(),\n'
              ');',
          _sec4Primary,
        ),
        _kvTable(
          'maintainAnimation — effects',
          <List<String>>[
            <String>[
              'Requires',
              'maintainState: true',
              'Animations need their State to live.',
            ],
            <String>[
              'Ticker',
              'still running',
              'AnimationControllers keep advancing.',
            ],
            <String>[
              'Paint',
              'skipped',
              'Visual updates suppressed while invisible.',
            ],
            <String>[
              'CPU',
              'still spent',
              'Animation logic still executes — be deliberate.',
            ],
          ],
          _sec4Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5: maintainSize FLAG
// ============================================================================

Widget _section5(BuildContext context) {
  return _section(
    number: 5,
    title: 'maintainSize Flag',
    subtitle: 'Hold the slot — preserve layout while hiding paint.',
    primary: _sec5Primary,
    accent: _sec5Accent,
    surface: _sec5Surface,
    icon: Icons.straighten_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Stop the layout from jumping', size: 16.0, color: _sec5Primary),
        _gap(6.0),
        _body(
          'maintainSize keeps the original layout slot. The child still occupies '
          'its measured area, but is not painted or hit-tested. This is the most '
          'expensive flag — Flutter requires maintainAnimation + maintainState '
          'to be true as well, because painting depends on them.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec5Primary, 'cobalt'],
          <dynamic>[_sec5Accent, 'periwinkle'],
          <dynamic>[_sec5Surface, 'sky'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: layout collapses (default)',
          caption:
              'A visible vs invisible pair shows obvious reflow — the second '
              'row pushes upwards because the slot collapsed to zero.',
          tone: _sec5Primary,
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _subjectBox('row A', _sec5Primary)),
                  _wgap(8.0),
                  Expanded(
                    child: Visibility(
                      visible: true,
                      child: _subjectBox('hero', _sec5Accent),
                    ),
                  ),
                  _wgap(8.0),
                  Expanded(child: _subjectBox('row B', _sec5Primary)),
                ],
              ),
              _gap(8.0),
              Row(
                children: <Widget>[
                  Expanded(child: _subjectBox('row A', _sec5Primary)),
                  _wgap(8.0),
                  Visibility(
                    visible: false,
                    child: Expanded(child: _subjectBox('hero', _sec5Accent)),
                  ),
                  _wgap(8.0),
                  Expanded(child: _subjectBox('row B', _sec5Primary)),
                ],
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'B: slot held (maintainSize: true)',
          caption:
              'With maintainSize, the middle slot is preserved. Surrounding '
              'widgets stay still — only the hero pixel content disappears.',
          tone: _sec5Accent,
          body: Row(
            children: <Widget>[
              Expanded(child: _subjectBox('row A', _sec5Primary)),
              _wgap(8.0),
              Expanded(
                child: Visibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: _subjectBox('hero (held)', _sec5Accent),
                ),
              ),
              _wgap(8.0),
              Expanded(child: _subjectBox('row B', _sec5Primary)),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: skeleton placeholder pattern',
          caption:
              'A common technique: stack a skeleton beneath a maintainSize '
              'Visibility. When the content hides, the skeleton becomes visible '
              'and the layout never shifts.',
          tone: _sec5Primary,
          body: Stack(
            children: <Widget>[
              _placeholderSlot('SKELETON', height: 60.0),
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: _subjectBox('content (hidden)', _sec5Primary),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Stability rules',
          bullets: <String>[
            'maintainSize requires maintainAnimation + maintainState.',
            'Slot preserved — siblings do not reflow.',
            'Paint suppressed, hit-test suppressed (unless maintainInteractivity).',
            'Useful for skeletons, async placeholders and "hidden in tab" content.',
          ],
          accent: _sec5Accent,
        ),
        _codeQuote(
          'maintainSize — example',
          'Visibility(\n'
              '  visible: ready,\n'
              '  maintainState: true,\n'
              '  maintainAnimation: true,\n'
              '  maintainSize: true,\n'
              '  child: ChartCard(),\n'
              ');',
          _sec5Primary,
        ),
        _kvTable(
          'maintainSize — effects',
          <List<String>>[
            <String>[
              'Requires',
              'state + animation',
              'Flag cascade — both must be true.',
            ],
            <String>[
              'Layout',
              'preserved',
              'Slot occupies the same area as if visible.',
            ],
            <String>['Paint', 'skipped', 'Child not drawn.'],
            <String>[
              'Hit-test',
              'skipped',
              'Unless maintainInteractivity is true.',
            ],
          ],
          _sec5Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6: maintainSemantics FLAG
// ============================================================================

Widget _section6(BuildContext context) {
  return _section(
    number: 6,
    title: 'maintainSemantics Flag',
    subtitle: 'Keep accessibility data alive for screen readers.',
    primary: _sec6Primary,
    accent: _sec6Accent,
    surface: _sec6Surface,
    icon: Icons.accessibility_new_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Visible to screen readers, invisible to the eye', size: 16.0, color: _sec6Primary),
        _gap(6.0),
        _body(
          'maintainSemantics decouples accessibility from paint. The child is '
          'not drawn, but its semantics nodes remain in the tree. Screen readers '
          'can still announce labels, hints and actions — useful for live '
          'regions and screen-reader-only metadata.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec6Primary, 'teal'],
          <dynamic>[_sec6Accent, 'mint'],
          <dynamic>[_sec6Surface, 'wash'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: default — semantics gone with paint',
          caption:
              'When visible flips to false, the subtree disappears from the '
              'a11y tree as well. TalkBack and VoiceOver cannot announce it.',
          tone: _sec6Primary,
          body: _sideBySide(
            leftLabel: 'visible: true',
            left: Semantics(
              label: 'Live region: 3 unread messages',
              child: _subjectBox('Live region', _sec6Primary),
            ),
            rightLabel: 'visible: false',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _gallerySubtle.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'NO SEMANTICS',
                style: TextStyle(
                  color: _gallerySubtle,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: semantics retained',
          caption:
              'maintainSemantics preserves the node tree. Screen readers can '
              'still discover and announce the content even if pixels are '
              'absent. Great for off-screen status text.',
          tone: _sec6Accent,
          body: Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: _galleryFog,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _sec6Primary.withOpacity(0.4)),
            ),
            alignment: Alignment.center,
            child: Visibility(
              visible: false,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              maintainSemantics: true,
              child: Semantics(
                label: 'Live region: 3 unread messages',
                child: _subjectBox('announced', _sec6Primary),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'C: ExcludeSemantics — the inverse',
          caption:
              'ExcludeSemantics does the opposite: keep paint, drop semantics. '
              'Use for decorative icons that duplicate adjacent labels.',
          tone: _sec6Primary,
          body: Row(
            children: <Widget>[
              Expanded(
                child: Semantics(
                  label: 'Status — 3 unread',
                  child: _subjectBox('with semantics', _sec6Primary),
                ),
              ),
              _wgap(8.0),
              Expanded(
                child: ExcludeSemantics(
                  excluding: true,
                  child: _subjectBox('excluded', _sec6Accent),
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'When to use maintainSemantics',
          bullets: <String>[
            'Live regions whose status must always be announced.',
            'Hidden form fields that participate in screen reader flow.',
            'Tutorial overlays that hide visually but stay narratable.',
            'Pair with maintainSize to keep focus order stable.',
          ],
          accent: _sec6Accent,
        ),
        _codeQuote(
          'maintainSemantics — example',
          'Visibility(\n'
              '  visible: false,\n'
              '  maintainState: true,\n'
              '  maintainAnimation: true,\n'
              '  maintainSize: true,\n'
              '  maintainSemantics: true,\n'
              '  child: Semantics(label: "3 unread", child: SizedBox()),\n'
              ');',
          _sec6Primary,
        ),
        _kvTable(
          'maintainSemantics — effects',
          <List<String>>[
            <String>[
              'Requires',
              'state + anim + size',
              'Flag cascade for semantics-without-paint.',
            ],
            <String>[
              'A11y tree',
              'preserved',
              'Screen readers still announce.',
            ],
            <String>['Paint', 'skipped', 'Pixels invisible.'],
            <String>[
              'Focus',
              'maintained',
              'Reader focus order remains predictable.',
            ],
          ],
          _sec6Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: maintainInteractivity FLAG
// ============================================================================

Widget _section7(BuildContext context) {
  return _section(
    number: 7,
    title: 'maintainInteractivity Flag',
    subtitle: 'Invisible — but still tappable.',
    primary: _sec7Primary,
    accent: _sec7Accent,
    surface: _sec7Surface,
    icon: Icons.touch_app_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Hit-test through invisible widgets', size: 16.0, color: _sec7Primary),
        _gap(6.0),
        _body(
          'maintainInteractivity lets the invisible child still respond to '
          'pointer events. Combined with maintainSize, it is the only way to '
          'have an invisible-but-tappable region. Rarely needed — but useful '
          'for cheat overlays, A/B test gates, and "ghost" buttons.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec7Primary, 'berry'],
          <dynamic>[_sec7Accent, 'rose'],
          <dynamic>[_sec7Surface, 'wash'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: default — invisible widget cannot be tapped',
          caption:
              'Even with maintainSize, the hidden child does not receive '
              'pointer events. Taps fall through to whatever is behind.',
          tone: _sec7Primary,
          body: Stack(
            children: <Widget>[
              _subjectBox('Background button', _sec7Primary, height: 60.0),
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: _subjectBox('Overlay (hidden)', _sec7Accent, height: 60.0),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'B: still tappable (maintainInteractivity: true)',
          caption:
              'With maintainInteractivity, the invisible overlay continues to '
              'absorb taps even though the background button is what the user '
              'sees.',
          tone: _sec7Accent,
          body: Stack(
            children: <Widget>[
              _subjectBox('Background button', _sec7Primary, height: 60.0),
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                maintainInteractivity: true,
                child: _subjectBox('Overlay (tappable)', _sec7Accent, height: 60.0),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: A/B gate pattern',
          caption:
              'A maintainInteractivity layer can intercept taps for analytics '
              'or gating without changing pixels. Disable to fall through.',
          tone: _sec7Primary,
          body: Row(
            children: <Widget>[
              Expanded(
                child: _subjectBox('Control variant', _sec7Primary),
              ),
              _wgap(8.0),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _subjectBox('Treatment variant', _sec7Accent),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainInteractivity: true,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Hit-test rules',
          bullets: <String>[
            'maintainInteractivity requires maintainSize: true.',
            'Slot must exist for hit-testing to find the area.',
            'Useful for invisible gating layers — rarely for UI controls.',
            'Prefer IgnorePointer/AbsorbPointer for explicit hit-test control.',
          ],
          accent: _sec7Accent,
        ),
        _codeQuote(
          'maintainInteractivity — example',
          'Visibility(\n'
              '  visible: false,\n'
              '  maintainState: true,\n'
              '  maintainAnimation: true,\n'
              '  maintainSize: true,\n'
              '  maintainInteractivity: true,\n'
              '  child: GestureDetector(onTap: gateTap, child: SizedBox.expand()),\n'
              ');',
          _sec7Primary,
        ),
        _kvTable(
          'maintainInteractivity — effects',
          <List<String>>[
            <String>[
              'Requires',
              'maintainSize: true',
              'Layout slot needed for hit testing.',
            ],
            <String>[
              'Hit-test',
              'enabled',
              'Pointer events reach the (invisible) child.',
            ],
            <String>['Paint', 'skipped', 'No pixels rendered.'],
            <String>[
              'Risk',
              'invisible affordance',
              'Users cannot see the tap target — be careful.',
            ],
          ],
          _sec7Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8: replacement WIDGET SHOWCASE
// ============================================================================

Widget _section8(BuildContext context) {
  return _section(
    number: 8,
    title: 'replacement Widget Showcase',
    subtitle: 'Swap content cleanly without conditional trees.',
    primary: _sec8Primary,
    accent: _sec8Accent,
    surface: _sec8Surface,
    icon: Icons.swap_horiz_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('A clean swap pattern', size: 16.0, color: _sec8Primary),
        _gap(6.0),
        _body(
          'Visibility.replacement defaults to SizedBox.shrink(), but accepts '
          'any widget. When visible: false, the replacement is shown instead. '
          'This is the cleanest alternative to a ternary in a Column — and it '
          'keeps the surrounding Element identity stable.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec8Primary, 'indigo'],
          <dynamic>[_sec8Accent, 'lilac'],
          <dynamic>[_sec8Surface, 'haze'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: ready vs loading',
          caption:
              'Show real content when ready, a skeleton placeholder otherwise.',
          tone: _sec8Primary,
          body: _sideBySide(
            leftLabel: 'visible: true (ready)',
            left: Visibility(
              visible: true,
              replacement: _placeholderSlot('LOADING…'),
              child: _subjectBox('Chart content', _sec8Primary),
            ),
            rightLabel: 'visible: false (loading)',
            right: Visibility(
              visible: false,
              replacement: _placeholderSlot('LOADING…'),
              child: _subjectBox('Chart content', _sec8Primary),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: empty state replacement',
          caption:
              'When the list is empty, swap the list for a centred empty-state '
              'illustration. Surrounding layout stays untouched.',
          tone: _sec8Accent,
          body: Visibility(
            visible: false,
            replacement: Container(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              decoration: BoxDecoration(
                color: _galleryPaper,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: _sec8Primary.withOpacity(0.4),
                  width: 1.0,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Icon(Icons.inbox_rounded, color: _sec8Primary, size: 28.0),
                  _gap(6.0),
                  _label(
                    'No items yet',
                    size: 12.5,
                    weight: FontWeight.w800,
                    color: _galleryInk,
                  ),
                  _gap(4.0),
                  _body(
                    'When stock arrives, the list will appear here.',
                    size: 11.5,
                  ),
                ],
              ),
            ),
            child: _subjectBox('List content', _sec8Primary, height: 96.0),
          ),
        ),
        _captionedCard(
          title: 'C: badge swap',
          caption:
              'Replace a small badge with a different style based on visibility.',
          tone: _sec8Primary,
          body: Row(
            children: <Widget>[
              Visibility(
                visible: false,
                replacement: _badge('LIVE', _sec8Primary),
                child: _badge('DRAFT', _sec8Accent, fg: _galleryInk),
              ),
              _wgap(8.0),
              Visibility(
                visible: true,
                replacement: _badge('LIVE', _sec8Primary),
                child: _badge('DRAFT', _sec8Accent, fg: _galleryInk),
              ),
              _wgap(8.0),
              _body(
                ' ← invisible swap, visible original',
                size: 11.0,
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Replacement guidelines',
          bullets: <String>[
            'Use for ready / loading / empty / error swaps in the same slot.',
            'Replacement does not get maintain* — it is a brand new subtree.',
            'Keeps Element identity for the surrounding Column / Row constant.',
            'Reduces conditional ternaries in build methods.',
          ],
          accent: _sec8Accent,
        ),
        _codeQuote(
          'replacement — example',
          'Visibility(\n'
              '  visible: data != null,\n'
              '  replacement: SkeletonCard(),\n'
              '  child: DataCard(data!),\n'
              ');',
          _sec8Primary,
        ),
        _kvTable(
          'replacement — effects',
          <List<String>>[
            <String>[
              'Default',
              'SizedBox.shrink()',
              'Effectively collapses if you do not set it.',
            ],
            <String>[
              'Custom',
              'any Widget',
              'Replaces child when visible is false.',
            ],
            <String>[
              'maintain*',
              'ignored',
              'Flags apply to the child only — replacement is a new tree.',
            ],
            <String>[
              'Use case',
              'state swaps',
              'Ready, loading, empty, error variants.',
            ],
          ],
          _sec8Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9: OFFSTAGE PATTERNS
// ============================================================================

Widget _section9(BuildContext context) {
  return _section(
    number: 9,
    title: 'Offstage Patterns',
    subtitle: 'Lay out, but do not paint or hit-test.',
    primary: _sec9Primary,
    accent: _sec9Accent,
    surface: _sec9Surface,
    icon: Icons.layers_clear_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Offstage — the hidden rehearsal', size: 16.0, color: _sec9Primary),
        _gap(6.0),
        _body(
          'Offstage paints nothing and absorbs no input, but measures its child '
          'as if it were on screen. Useful for pre-warming heavy widgets, '
          'measuring intrinsic sizes, or running animation controllers in the '
          'background.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec9Primary, 'deep'],
          <dynamic>[_sec9Accent, 'sky'],
          <dynamic>[_sec9Surface, 'haze'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: on stage vs off stage',
          caption:
              'Offstage(offstage: true) does not paint. The slot is still '
              'measured, but it never reaches the screen.',
          tone: _sec9Primary,
          body: _sideBySide(
            leftLabel: 'offstage: false',
            left: Offstage(
              offstage: false,
              child: _subjectBox('on stage', _sec9Primary),
            ),
            rightLabel: 'offstage: true',
            right: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _galleryFog,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec9Primary.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: Offstage(
                offstage: true,
                child: _subjectBox('off stage', _sec9Primary),
              ),
            ),
          ),
        ),
        _captionedCard(
          title: 'B: pre-warm heavy widget',
          caption:
              'Place an expensive widget Offstage while loading other content, '
              'then flip offstage to false when ready. Build cost is paid in '
              'advance.',
          tone: _sec9Accent,
          body: Column(
            children: <Widget>[
              Offstage(
                offstage: true,
                child: _subjectBox(
                  'Heavy chart (pre-warmed offstage)',
                  _sec9Primary,
                ),
              ),
              _gap(8.0),
              _subjectBox('Other on-screen content', _sec9Accent),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: intrinsic measurement',
          caption:
              'Offstage participates in intrinsic measurement. Use to ask "how '
              'wide will this be?" without committing to paint.',
          tone: _sec9Primary,
          body: Row(
            children: <Widget>[
              Offstage(
                offstage: true,
                child: SizedBox(
                  width: 200.0,
                  child: _subjectBox('ghost', _sec9Primary),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Offstage child contributes to parent measurement when '
                    'parent asks for intrinsic sizes — not for typical layout '
                    'though.',
                    style: TextStyle(
                      color: _gallerySubtle,
                      fontSize: 12.0,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Offstage vs Visibility',
          bullets: <String>[
            'Visibility(visible: false) — child not laid out, paint, or hit-tested.',
            'Offstage(offstage: true) — laid out, not painted, not hit-tested.',
            'Offstage is cheaper than maintain* flag combos when you only need pre-warming.',
            'Visibility is cleaner when you want a single switch with multiple behaviours.',
          ],
          accent: _sec9Accent,
        ),
        _codeQuote(
          'Offstage — example',
          'Offstage(\n'
              '  offstage: !preload,\n'
              '  child: ExpensiveSubtree(),\n'
              ');',
          _sec9Primary,
        ),
        _kvTable(
          'Offstage — effects',
          <List<String>>[
            <String>['offstage', 'true', 'No paint, no hit-test.'],
            <String>['layout', 'still done', 'Child measured normally.'],
            <String>[
              'animations',
              'tick by default',
              'No need for maintain* flags.',
            ],
            <String>[
              'intrinsic size',
              'contributes',
              'Useful for parent measurement.',
            ],
          ],
          _sec9Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10: IGNORE / ABSORB POINTER
// ============================================================================

Widget _section10(BuildContext context) {
  return _section(
    number: 10,
    title: 'IgnorePointer / AbsorbPointer',
    subtitle: 'Pointer-level visibility — paint but skip taps.',
    primary: _sec10Primary,
    accent: _sec10Accent,
    surface: _sec10Surface,
    icon: Icons.do_not_touch_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Two flavours of "no taps"', size: 16.0, color: _sec10Primary),
        _gap(6.0),
        _body(
          'IgnorePointer and AbsorbPointer both disable pointer input, but '
          'differ on whether events pass to widgets behind. Choose the right '
          'one based on stacking behaviour you want.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec10Primary, 'terracotta'],
          <dynamic>[_sec10Accent, 'peach'],
          <dynamic>[_sec10Surface, 'sand'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: IgnorePointer — events pass through',
          caption:
              'Useful for decorative overlays. A confetti animation, for '
              'instance, should never block the button beneath it.',
          tone: _sec10Primary,
          body: Stack(
            children: <Widget>[
              _subjectBox('Button below', _sec10Primary, height: 60.0),
              IgnorePointer(
                ignoring: true,
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: _sec10Accent.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Decorative overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'B: AbsorbPointer — events stop here',
          caption:
              'Useful when you want to disable a region without changing its '
              'colours. The button beneath is unreachable.',
          tone: _sec10Accent,
          body: Stack(
            children: <Widget>[
              _subjectBox('Button below (BLOCKED)', _sec10Primary, height: 60.0),
              AbsorbPointer(
                absorbing: true,
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: _sec10Accent.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Gate',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: disabling a form',
          caption:
              'Wrap a Form in IgnorePointer to make it visually present but '
              'unsubmittable while a request is pending. Pair with a translucent '
              'overlay for clarity.',
          tone: _sec10Primary,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _subjectBox('Field A', _sec10Primary),
                  _gap(8.0),
                  _subjectBox('Field B', _sec10Primary),
                ],
              ),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'SUBMITTING…',
                      style: TextStyle(
                        color: _sec10Primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          title: 'Pick the right pointer widget',
          bullets: <String>[
            'Decorative overlay? — IgnorePointer.',
            'Disabling gate? — AbsorbPointer (keeps lower widgets quiet).',
            'Combined with semantics? — pair with ExcludeSemantics for read-only.',
            'Performance: both are cheap; just one extra render object.',
          ],
          accent: _sec10Accent,
        ),
        _codeQuote(
          'IgnorePointer / AbsorbPointer',
          'IgnorePointer(\n'
              '  ignoring: !active,\n'
              '  child: DecorativeOverlay(),\n'
              ');\n\n'
              'AbsorbPointer(\n'
              '  absorbing: submitting,\n'
              '  child: MyForm(),\n'
              ');',
          _sec10Primary,
        ),
        _kvTable(
          'IgnorePointer vs AbsorbPointer',
          <List<String>>[
            <String>[
              'IgnorePointer',
              'pass-through',
              'Events pass to widgets below in the Stack.',
            ],
            <String>[
              'AbsorbPointer',
              'consume',
              'Events stop here; lower widgets see nothing.',
            ],
            <String>[
              'Paint',
              'identical',
              'Neither one changes pixel output.',
            ],
            <String>[
              'Semantics',
              'unchanged',
              'Use ExcludeSemantics if you also want to hide a11y.',
            ],
          ],
          _sec10Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11: SLIVERVISIBILITY
// ============================================================================

Widget _section11(BuildContext context) {
  return _section(
    number: 11,
    title: 'SliverVisibility',
    subtitle: 'The Visibility analogue inside a CustomScrollView.',
    primary: _sec11Primary,
    accent: _sec11Accent,
    surface: _sec11Surface,
    icon: Icons.view_list_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('Visibility for slivers', size: 16.0, color: _sec11Primary),
        _gap(6.0),
        _body(
          'SliverVisibility wraps a sliver child instead of a box child. All '
          'the same flags apply: maintainState, maintainAnimation, maintainSize, '
          'maintainSemantics, maintainInteractivity. It also accepts a '
          'replacementSliver instead of a regular widget.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec11Primary, 'moss'],
          <dynamic>[_sec11Accent, 'fern'],
          <dynamic>[_sec11Surface, 'meadow'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: simulated sliver list — visible vs hidden header',
          caption:
              'The left tower shows a header + items. The right tower removes '
              'the header via SliverVisibility — items shift upward.',
          tone: _sec11Primary,
          body: SizedBox(
            height: 200.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: _subjectBox('HEADER', _sec11Primary),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: _subjectBox('item 1', _sec11Accent),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _subjectBox('item 2', _sec11Accent),
                      ),
                    ],
                  ),
                ),
                _wgap(12.0),
                Expanded(
                  child: CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverVisibility(
                        visible: false,
                        sliver: SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: _subjectBox('HEADER', _sec11Primary),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: _subjectBox('item 1', _sec11Accent),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _subjectBox('item 2', _sec11Accent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _captionedCard(
          title: 'B: maintainSize sliver',
          caption:
              'Keep the header slot via maintainSize, so list items do not '
              'shift while waiting for the header to populate.',
          tone: _sec11Accent,
          body: SizedBox(
            height: 200.0,
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverVisibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: _subjectBox('HEADER (held)', _sec11Primary),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: _subjectBox('item 1', _sec11Accent),
                  ),
                ),
                SliverToBoxAdapter(child: _subjectBox('item 2', _sec11Accent)),
              ],
            ),
          ),
        ),
        _captionedCard(
          title: 'C: replacementSliver',
          caption:
              'Provide a different sliver when invisible — e.g. an empty-state '
              'sliver instead of the data sliver.',
          tone: _sec11Primary,
          body: SizedBox(
            height: 200.0,
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverVisibility(
                  visible: false,
                  replacementSliver: SliverToBoxAdapter(
                    child: _placeholderSlot('EMPTY STATE SLIVER', height: 80.0),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _subjectBox('row 1', _sec11Primary),
                        _gap(6.0),
                        _subjectBox('row 2', _sec11Primary),
                        _gap(6.0),
                        _subjectBox('row 3', _sec11Primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _recipeCard(
          title: 'SliverVisibility rules',
          bullets: <String>[
            'Use it instead of Visibility inside CustomScrollView.',
            'sliver: argument required — box children will not work.',
            'replacementSliver: defaults to SliverToBoxAdapter(SizedBox.shrink()).',
            'All maintain* flags apply identically.',
          ],
          accent: _sec11Accent,
        ),
        _codeQuote(
          'SliverVisibility — example',
          'CustomScrollView(\n'
              '  slivers: [\n'
              '    SliverVisibility(\n'
              '      visible: hasData,\n'
              '      replacementSliver: SliverEmptyState(),\n'
              '      sliver: SliverList(delegate: …),\n'
              '    ),\n'
              '  ],\n'
              ');',
          _sec11Primary,
        ),
        _kvTable(
          'SliverVisibility — properties',
          <List<String>>[
            <String>[
              'sliver',
              'required',
              'The sliver shown when visible is true.',
            ],
            <String>[
              'replacementSliver',
              'optional',
              'Sliver shown when visible is false (defaults to empty).',
            ],
            <String>[
              'maintain* flags',
              'identical',
              'Same semantics as Visibility.',
            ],
            <String>[
              'context',
              'CustomScrollView',
              'Must live inside a sliver host.',
            ],
          ],
          _sec11Accent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12: FLAG COMBINATIONS
// ============================================================================

Widget _section12(BuildContext context) {
  return _section(
    number: 12,
    title: 'Flag Combinations',
    subtitle: 'Reading a Visibility config at a glance.',
    primary: _sec12Primary,
    accent: _sec12Accent,
    surface: _sec12Surface,
    icon: Icons.grid_view_rounded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _heading('The five-flag truth table', size: 16.0, color: _sec12Primary),
        _gap(6.0),
        _body(
          'maintainState, maintainAnimation, maintainSize, maintainSemantics '
          'and maintainInteractivity cascade — each requires the previous one '
          'in the chain. Pick the lowest level that satisfies your use case '
          'to keep memory and CPU costs low.',
        ),
        _gap(12.0),
        _palette(<List<dynamic>>[
          <dynamic>[_sec12Primary, 'graphite'],
          <dynamic>[_sec12Accent, 'ash'],
          <dynamic>[_sec12Surface, 'cloud'],
          <dynamic>[_galleryFog, 'fog'],
        ]),
        _captionedCard(
          title: 'A: combo grid',
          caption:
              'Four invisible Visibility widgets, identical child, different '
              'flag combos. Borders show which flags are active.',
          tone: _sec12Primary,
          body: Column(
            children: <Widget>[
              _comboRow(
                'state only',
                _sec3Primary,
                Visibility(
                  visible: false,
                  maintainState: true,
                  child: _subjectBox('state', _sec12Primary),
                ),
              ),
              _gap(8.0),
              _comboRow(
                'state + anim',
                _sec4Primary,
                Visibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  child: _subjectBox('state+anim', _sec12Primary),
                ),
              ),
              _gap(8.0),
              _comboRow(
                'state + anim + size',
                _sec5Primary,
                Visibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: _subjectBox('s+a+sz', _sec12Primary),
                ),
              ),
              _gap(8.0),
              _comboRow(
                'all five',
                _sec7Primary,
                Visibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainSemantics: true,
                  maintainInteractivity: true,
                  child: _subjectBox('all', _sec12Primary),
                ),
              ),
            ],
          ),
        ),
        _captionedCard(
          title: 'B: the four most common configs',
          caption:
              'In practice almost every Visibility you write falls into one of '
              'these four buckets. Pick deliberately.',
          tone: _sec12Accent,
          body: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _badge('default (collapse)', _sec12Primary),
              _badge('replacement', _sec8Primary),
              _badge('maintainState', _sec3Primary),
              _badge('full maintain', _sec7Primary),
            ],
          ),
        ),
        _captionedCard(
          title: 'C: cost ladder',
          caption:
              'Each extra maintain* flag costs slightly more. The ladder grows '
              'from cheap collapse all the way to fully-alive invisible widget.',
          tone: _sec12Primary,
          body: Column(
            children: <Widget>[
              _costRow('cheapest', 'visible: false (collapse)', _sec1Primary),
              _gap(6.0),
              _costRow('cheap', 'maintainState', _sec3Primary),
              _gap(6.0),
              _costRow('medium', '+ maintainAnimation', _sec4Primary),
              _gap(6.0),
              _costRow('medium-heavy', '+ maintainSize', _sec5Primary),
              _gap(6.0),
              _costRow('heavy', '+ maintainSemantics', _sec6Primary),
              _gap(6.0),
              _costRow('heaviest', '+ maintainInteractivity', _sec7Primary),
            ],
          ),
        ),
        _recipeCard(
          title: 'How to pick',
          bullets: <String>[
            'Start with default — let the slot collapse.',
            'Add maintainState only if you need state preserved.',
            'Layer flags up the chain — each requires the previous.',
            'maintainSize is the most common upgrade — stable layouts.',
          ],
          accent: _sec12Accent,
        ),
        _codeQuote(
          'Combinations — example',
          'Visibility(\n'
              '  visible: false,\n'
              '  maintainState: true,\n'
              '  maintainAnimation: true,\n'
              '  maintainSize: true,\n'
              '  child: HeroPanel(),\n'
              ');',
          _sec12Primary,
        ),
        _kvTable(
          'Flag dependency rules',
          <List<String>>[
            <String>[
              'maintainState',
              'standalone',
              'Lowest of the chain — keeps state alive.',
            ],
            <String>[
              'maintainAnimation',
              'needs state',
              'Tickers cannot live without their State.',
            ],
            <String>[
              'maintainSize',
              'needs state + anim',
              'Layout needs paintable subtree.',
            ],
            <String>[
              'maintainSemantics',
              'needs s+a+sz',
              'Semantics rely on a placed render object.',
            ],
            <String>[
              'maintainInteractivity',
              'needs size',
              'Hit-testing requires a measured slot.',
            ],
          ],
          _sec12Accent,
        ),
      ],
    ),
  );
}

Widget _comboRow(String label, Color tone, Widget hiddenChild) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 150.0,
        child: _chip(label, tone),
      ),
      _wgap(10.0),
      Expanded(
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: _galleryFog,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: tone.withOpacity(0.4), width: 1.0),
          ),
          alignment: Alignment.center,
          child: hiddenChild,
        ),
      ),
    ],
  );
}

Widget _costRow(String tier, String label, Color tone) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 110.0,
        child: _label(
          tier,
          size: 11.0,
          weight: FontWeight.w800,
          color: tone,
          letter: 0.6,
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: tone.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: tone.withOpacity(0.4)),
          ),
          child: _label(
            label,
            size: 12.0,
            weight: FontWeight.w700,
            color: _galleryInk,
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// COMPARISON TABLE: Visibility vs Offstage vs IgnorePointer vs replacement
// ============================================================================

Widget _comparison() {
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 32.0, 22.0, 0.0),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
    decoration: BoxDecoration(
      color: _galleryPaper,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: _sec8Surface,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec8Accent),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.compare_rounded,
                color: _sec8Primary,
                size: 18.0,
              ),
            ),
            _wgap(12.0),
            _heading('Comparison Grid', size: 18.0),
          ],
        ),
        _gap(8.0),
        _body(
          'A side-by-side feature matrix of the four most common visibility '
          'controls. Use this as your decision card.',
          size: 12.5,
        ),
        _gap(14.0),
        _comparisonTable(),
      ],
    ),
  );
}

Widget _comparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['Widget', 'Layout', 'Paint', 'Hit-test', 'Semantics', 'State'],
    <String>['Visibility (default)', 'collapse', 'no', 'no', 'no', 'lost'],
    <String>['Visibility + maintainSize', 'kept', 'no', 'no', 'no', 'kept'],
    <String>['Visibility + maintainSemantics', 'kept', 'no', 'no', 'yes', 'kept'],
    <String>['Visibility + maintainInteractivity', 'kept', 'no', 'yes', 'no', 'kept'],
    <String>['Visibility.replacement', 'replacement', 'replacement', 'replacement', 'replacement', 'lost'],
    <String>['Offstage', 'measured', 'no', 'no', 'no', 'kept'],
    <String>['IgnorePointer', 'kept', 'yes', 'pass-through', 'yes', 'kept'],
    <String>['AbsorbPointer', 'kept', 'yes', 'consume', 'yes', 'kept'],
    <String>['ExcludeSemantics', 'kept', 'yes', 'yes', 'no', 'kept'],
  ];
  final List<TableRow> tableRows = <TableRow>[];
  for (int i = 0; i < rows.length; i++) {
    final List<String> r = rows[i];
    final bool isHeader = i == 0;
    tableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: isHeader
              ? _sec8Primary.withOpacity(0.18)
              : (i.isOdd ? _galleryPaper : _galleryMist),
        ),
        children: <Widget>[
          for (final String cell in r)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Text(
                cell,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
                  color: isHeader ? _galleryInk : _gallerySlate,
                ),
              ),
            ),
        ],
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2.4),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1.0),
        3: FlexColumnWidth(1.4),
        4: FlexColumnWidth(1.2),
        5: FlexColumnWidth(1.0),
      },
      children: tableRows,
    ),
  );
}

// ============================================================================
// GLOSSARY
// ============================================================================

Widget _glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>['Visibility', 'Single widget that gates a child by layout, paint, state, semantics, hit-test.'],
    <String>['SliverVisibility', 'Sliver-aware analogue for use inside CustomScrollView.'],
    <String>['Offstage', 'Lays out a child but skips paint and hit-test; cheap pre-warming.'],
    <String>['IgnorePointer', 'Disables hit-testing for the subtree; events pass through.'],
    <String>['AbsorbPointer', 'Disables hit-testing for the subtree; events are absorbed.'],
    <String>['ExcludeSemantics', 'Drops the subtree from the semantics tree without affecting paint.'],
    <String>['maintainState', 'Keeps the Element/State of the child alive while invisible.'],
    <String>['maintainAnimation', 'Allows AnimationControllers to keep ticking while invisible.'],
    <String>['maintainSize', 'Preserves the layout slot — siblings do not reflow.'],
    <String>['maintainSemantics', 'Keeps the a11y nodes alive while paint is suppressed.'],
    <String>['maintainInteractivity', 'Allows the invisible child to keep receiving pointer events.'],
    <String>['replacement', 'Widget shown instead of the child when visible is false.'],
    <String>['replacementSliver', 'SliverVisibility version of the replacement parameter.'],
    <String>['AlwaysStoppedAnimation', 'A frozen Animation snapshot used to render transition states statically.'],
  ];
  final List<Widget> rows = <Widget>[];
  for (final List<String> e in entries) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: _label(
                e[0],
                size: 12.0,
                color: _galleryInk,
                weight: FontWeight.w800,
              ),
            ),
            Expanded(child: _body(e[1], size: 12.0)),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 32.0, 22.0, 0.0),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
    decoration: BoxDecoration(
      color: _galleryPaper,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _galleryLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: _sec1Surface,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _sec1Accent),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.bookmark_rounded,
                color: _sec1Primary,
                size: 18.0,
              ),
            ),
            _wgap(12.0),
            _heading('Glossary', size: 18.0),
          ],
        ),
        _gap(6.0),
        _body(
          'Quick reference for the visibility toggle family used across the gallery.',
          size: 12.5,
        ),
        _gap(10.0),
        ...rows,
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================

Widget _epilogue() {
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 28.0, 22.0, 32.0),
    padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_gallerySlate, _galleryInk],
      ),
      borderRadius: BorderRadius.circular(22.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            _wgap(12.0),
            const Text(
              'GALLERY COMPLETE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.4,
              ),
            ),
          ],
        ),
        _gap(14.0),
        const Text(
          'Twelve sections, five flags, one decision card.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        _gap(8.0),
        Text(
          'Every "hide this widget" decision in Flutter is a layered choice: do '
          'you want to free the slot, free the state, free the animation, free '
          'the a11y data, or free the hit-target? Visibility, Offstage, '
          'IgnorePointer, AbsorbPointer, ExcludeSemantics and SliverVisibility '
          'cover the whole matrix — pick the smallest tool that does the job.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 13.0,
            height: 1.55,
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
    title: 'Visibility — Toggle Gallery',
    theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: _sec1Primary,
        secondary: _sec3Primary,
        surface: _galleryPaper,
      ),
      scaffoldBackgroundColor: _galleryMist,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _galleryMist,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _hero(),
            _overview(),
            _section1(context),
            _section2(context),
            _section3(context),
            _section4(context),
            _section5(context),
            _section6(context),
            _section7(context),
            _section8(context),
            _section9(context),
            _section10(context),
            _section11(context),
            _section12(context),
            _comparison(),
            _glossary(),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}
