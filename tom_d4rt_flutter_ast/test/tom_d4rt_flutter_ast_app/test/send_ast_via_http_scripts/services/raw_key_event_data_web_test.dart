// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep visual demo: RawKeyEventDataWeb — Flutter raw keyboard event data on web.
// Subject : RawKeyEventData subclass for browsers (Chrome / Firefox / Safari /
//           Edge), wrapping the W3C UI Events KeyboardEvent: `.code`, `.key`,
//           `.location`, `.metaState` (modifier bitmask) and the legacy
//           `.keyCode` integer.
// Goal    : Render a long, didactic, scrollable canvas explaining each field,
//           the W3C `code` vs `key` distinction, the four `KeyboardEvent.location`
//           regions (standard, left, right, numpad), the modifier bitmask
//           register, browser quirks, the deprecation path toward HardwareKeyboard,
//           sample event cards, a derivation table to LogicalKeyboardKey /
//           PhysicalKeyboardKey and a KeyboardListener recipe.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ───────────────────────────────────────────────────────────────────────────
// U12 — local stand-in for the SDK's `@Deprecated` `RawKeyEventDataWeb`.
//
// The Flutter SDK class `RawKeyEventDataWeb` (`flutter/services.dart`,
// `raw_keyboard_web.dart:32-37`) is annotated `@Deprecated` and is therefore
// filtered out of the d4rt bridge surface (see U12 in
// `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`). The deprecation
// path is `RawKeyboard → HardwareKeyboard / RawKeyEvent → KeyEvent /
// RawKeyEventDataWeb → (folded into KeyEvent.physicalKey/logicalKey)`,
// i.e. there is no typedef-rename — variant B does not apply. We use
// variant A: a private local class with the same constructor shape and
// the small set of accessors this demo actually reads. Code positions
// reference `_RawKeyEventDataWeb`; strings and comments preserve the
// original SDK name so the didactic copy still documents it verbatim.
// ───────────────────────────────────────────────────────────────────────────
class _RawKeyEventDataWeb {
  const _RawKeyEventDataWeb({
    required this.code,
    required this.key,
    required this.location,
    required this.metaState,
    required this.keyCode,
  });

  final String code;
  final String key;
  final int location;
  final int metaState;
  final int keyCode;

  // Modifier bits — match the engine constants documented in the demo.
  bool get isShiftPressed => (metaState & 0x01) != 0;
  bool get isControlPressed => (metaState & 0x02) != 0;
  bool get isAltPressed => (metaState & 0x04) != 0;
  bool get isMetaPressed => (metaState & 0x08) != 0;

  // The demo only prints these — best-effort placeholder strings that
  // preserve the visual shape of the historical output.
  String get physicalKey => 'PhysicalKeyboardKey(code: $code)';
  String get logicalKey => 'LogicalKeyboardKey(key: $key)';
}

// ───────────────────────────────────────────────────────────────────────────
// Color palette — "Web flavor": indigo for chrome, cyan for browser glass,
// amber for the keyboard, magenta accents for modifier bits.
// ───────────────────────────────────────────────────────────────────────────
const Color rweInk = Color(0xFF1A237E);
const Color rweInkSoft = Color(0xFF303F9F);
const Color rweCyan = Color(0xFF006064);
const Color rweCyanSoft = Color(0xFF26C6DA);
const Color rweAmber = Color(0xFFF57F17);
const Color rweAmberSoft = Color(0xFFFFE082);
const Color rweMagenta = Color(0xFFAD1457);
const Color rweMagentaSoft = Color(0xFFF8BBD0);
const Color rweTeal = Color(0xFF00695C);
const Color rweTealSoft = Color(0xFFB2DFDB);
const Color rweMoss = Color(0xFF33691E);
const Color rweMossSoft = Color(0xFFDCEDC8);
const Color rwePaper = Color(0xFFFFFDF7);
const Color rwePaperShade = Color(0xFFF5F2E8);
const Color rweCharcoal = Color(0xFF263238);
const Color rweAsh = Color(0xFF607D8B);
const Color rweMist = Color(0xFFCFD8DC);
const Color rweWhite = Color(0xFFFFFFFF);
const Color rweBoneShadow = Color(0x14000000);

// ───────────────────────────────────────────────────────────────────────────
// Typography helpers
// ───────────────────────────────────────────────────────────────────────────
TextStyle rweTitle({Color color = rweInk, double size = 22}) => TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.4,
    );

TextStyle rweHeading({Color color = rweInk, double size = 16}) => TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    );

TextStyle rweLabel({Color color = rweCharcoal, double size = 12}) => TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
    );

TextStyle rweBody({Color color = rweCharcoal, double size = 12.5}) => TextStyle(
      color: color,
      fontSize: size,
      height: 1.45,
      fontWeight: FontWeight.w400,
    );

TextStyle rweMono({Color color = rweCharcoal, double size = 12}) => TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w500,
    );

TextStyle rweMonoBold({Color color = rweInk, double size = 12.5}) => TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w800,
    );

// ───────────────────────────────────────────────────────────────────────────
// Generic primitives: cards, dividers, chips, info rows, code blocks.
// ───────────────────────────────────────────────────────────────────────────
Widget rweCard(
  String title,
  Widget child, {
  Color accent = rweInk,
  String? subtitle,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: rwePaper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rweMist),
      boxShadow: const [
        BoxShadow(color: rweBoneShadow, blurRadius: 10, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accent,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: rweTitle(color: rweWhite, size: 16)),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(subtitle,
                    style: rweBody(color: rweWhite, size: 11.5)
                        .copyWith(fontStyle: FontStyle.italic)),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: child,
        ),
      ],
    ),
  );
}

Widget rweDivider({double pad = 8, Color color = rweMist}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: pad),
    height: 1,
    color: color,
  );
}

Widget rweChip(String label, Color color, {String? icon}) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.55)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Text(icon, style: TextStyle(fontSize: 12, color: color)),
          const SizedBox(width: 4),
        ],
        Text(label,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

Widget rweKeyVal(String key, String value, {Color color = rweInk}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key, style: rweLabel(color: color)),
        ),
        Expanded(
          child: Text(value, style: rweMono()),
        ),
      ],
    ),
  );
}

Widget rweBullet(String text, {Color color = rweInk}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text, style: rweBody())),
      ],
    ),
  );
}

Widget rweCode(String code, {Color background = rweInk}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: rweCyan.withValues(alpha: 0.3)),
    ),
    child: Text(code,
        style: TextStyle(
            color: rweCyanSoft.withValues(alpha: 0.95),
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45)),
  );
}

Widget rweCallout(String label, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: rweHeading(color: accent, size: 13)
                .copyWith(letterSpacing: 0.6)),
        const SizedBox(height: 4),
        Text(body, style: rweBody()),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 1 — Hero card: a stylized browser window mockup floating above
// a small keyboard. Communicates "Web flavor" of RawKeyEventData at a glance.
// ───────────────────────────────────────────────────────────────────────────
Widget rweBrowserDot(Color color) {
  return Container(
    width: 11,
    height: 11,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget rweBrowserChrome() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Title bar
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: rweInkSoft,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Row(
          children: [
            rweBrowserDot(const Color(0xFFEF5350)),
            rweBrowserDot(const Color(0xFFFFCA28)),
            rweBrowserDot(const Color(0xFF66BB6A)),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: rweWhite.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'https://flutter.dev/web · keydown listener',
                  style: rweMono(color: rweWhite, size: 11),
                ),
              ),
            ),
          ],
        ),
      ),
      // Tab bar
      Container(
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: rweInk,
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: rweCyanSoft.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('events',
                  style: rweMono(color: rweCyanSoft, size: 10)),
            ),
            const SizedBox(width: 6),
            Text('•',
                style: rweMono(
                    color: rweMist.withValues(alpha: 0.6), size: 14)),
            const SizedBox(width: 6),
            Text('keydown / keyup / keypress',
                style: rweMono(
                    color: rweMist.withValues(alpha: 0.85), size: 10)),
          ],
        ),
      ),
      // Body — a staged "console" log with a key event
      Container(
        padding: const EdgeInsets.all(12),
        color: rweCharcoal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('> document.addEventListener("keydown", e => print(e))',
                style: rweMono(color: rweCyanSoft, size: 11)),
            const SizedBox(height: 6),
            Text('< KeyboardEvent {',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('    code: "KeyA",',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('    key:  "a",',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('    location: 0,',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('    keyCode: 65,',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('    shiftKey: false, ctrlKey: false',
                style: rweMono(color: rweAmberSoft, size: 11)),
            Text('  }',
                style: rweMono(color: rweAmberSoft, size: 11)),
          ],
        ),
      ),
    ],
  );
}

Widget rweMiniKey(String label, {double width = 28}) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(horizontal: 1.5),
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: rweAmberSoft,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: rweAmber.withValues(alpha: 0.5)),
    ),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            color: rweCharcoal,
            fontFamily: 'monospace',
            fontSize: 10,
            fontWeight: FontWeight.w700)),
  );
}

Widget rweMiniKeyboard() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: rweAmber.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: rweAmber.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rweMiniKey('Esc'),
            const SizedBox(width: 8),
            rweMiniKey('1'),
            rweMiniKey('2'),
            rweMiniKey('3'),
            rweMiniKey('4'),
            rweMiniKey('5'),
            rweMiniKey('6'),
            rweMiniKey('7'),
            rweMiniKey('8'),
            rweMiniKey('9'),
            rweMiniKey('0'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rweMiniKey('Q'),
            rweMiniKey('W'),
            rweMiniKey('E'),
            rweMiniKey('R'),
            rweMiniKey('T'),
            rweMiniKey('Y'),
            rweMiniKey('U'),
            rweMiniKey('I'),
            rweMiniKey('O'),
            rweMiniKey('P'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rweMiniKey('A', width: 30),
            rweMiniKey('S'),
            rweMiniKey('D'),
            rweMiniKey('F'),
            rweMiniKey('G'),
            rweMiniKey('H'),
            rweMiniKey('J'),
            rweMiniKey('K'),
            rweMiniKey('L'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rweMiniKey('Sft', width: 36),
            rweMiniKey('Z'),
            rweMiniKey('X'),
            rweMiniKey('C'),
            rweMiniKey('V'),
            rweMiniKey('B'),
            rweMiniKey('N'),
            rweMiniKey('M'),
            rweMiniKey('Sft', width: 36),
          ],
        ),
      ],
    ),
  );
}

Widget rweHeroCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [rweInk, rweInkSoft, rweCyan],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(color: rweBoneShadow, blurRadius: 20, offset: Offset(0, 8)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: rweCyanSoft.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('flutter / services',
                  style: rweMono(color: rweCyanSoft, size: 11)),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: rweMagentaSoft.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Web flavor',
                  style: rweMono(color: rweMagentaSoft, size: 11)),
            ),
            const Spacer(),
            Text('@Deprecated · v3.18',
                style:
                    rweMono(color: rweAmberSoft, size: 10.5)),
          ],
        ),
        const SizedBox(height: 14),
        Text('RawKeyEventDataWeb', style: rweTitle(color: rweWhite, size: 26)),
        const SizedBox(height: 6),
        Text(
          'A RawKeyEventData subclass produced by the Flutter web engine when '
          'a DOM KeyboardEvent fires inside a hosted Flutter app. Wraps the '
          'W3C UI Events fields: code, key, location, modifiers, keyCode.',
          style: rweBody(color: rweWhite, size: 13).copyWith(height: 1.5),
        ),
        const SizedBox(height: 14),
        rweBrowserChrome(),
        const SizedBox(height: 14),
        rweMiniKeyboard(),
        const SizedBox(height: 14),
        Wrap(
          children: [
            rweChip('keydown', rweCyanSoft, icon: '⌨'),
            rweChip('keyup', rweMagentaSoft, icon: '↑'),
            rweChip('layout-independent code', rweAmberSoft),
            rweChip('layout-aware key', rweMossSoft),
            rweChip('legacy keyCode', rweMist),
          ],
        ),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 2 — Anatomy: the constructor and its five fields, dissected.
// ───────────────────────────────────────────────────────────────────────────
Widget rweAnatomyRow(
    String name, String type, String example, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: rwePaperShade,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: rweInk, width: 3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name, style: rweMonoBold(size: 13)),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: rweCyan.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(type, style: rweMono(color: rweCyan, size: 11)),
            ),
            const Spacer(),
            Text('e.g. $example',
                style: rweMono(color: rweAmber, size: 11)),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: rweBody()),
      ],
    ),
  );
}

Widget rweAnatomySection() {
  return rweCard(
    '1 · Anatomy of RawKeyEventDataWeb',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCode(
          'const RawKeyEventDataWeb({\n'
          '  required String code,\n'
          '  required String key,\n'
          '  int location = 0,\n'
          '  int metaState = modifierNone,\n'
          '  int keyCode = 0,\n'
          '});',
        ),
        const SizedBox(height: 8),
        rweAnatomyRow('code', 'String', '"KeyA"',
            'KeyboardEvent.code — physical key, layout-independent.'),
        rweAnatomyRow('key', 'String', '"a" / "A"',
            'KeyboardEvent.key — printable value after layout & modifiers.'),
        rweAnatomyRow('location', 'int', '0..3',
            'KeyboardEvent.location — STANDARD/LEFT/RIGHT/NUMPAD region.'),
        rweAnatomyRow('metaState', 'int (bitmask)', '0x01 | 0x04',
            'Bitmask of held modifiers: shift, ctrl, alt, meta, caps, num...'),
        rweAnatomyRow('keyCode', 'int (legacy)', '65',
            'Legacy KeyboardEvent.keyCode integer (deprecated by W3C).'),
        rweDivider(),
        Text(
          'Of the five fields, only `code` and `key` are required; the rest '
          'have defaults that map to "no modifiers, standard location, '
          'unknown legacy keyCode". This keeps test fixtures terse.',
          style: rweBody(),
        ),
      ],
    ),
    accent: rweInk,
    subtitle: 'Five fields lifted directly from the W3C KeyboardEvent.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 3 — code vs key: a 3-column comparison with concrete examples.
// ───────────────────────────────────────────────────────────────────────────
Widget rweCodeKeyHeaderCell(String text, {Color color = rweInk}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    color: color,
    alignment: Alignment.centerLeft,
    child: Text(text,
        style: rweMonoBold(color: rweWhite, size: 12)
            .copyWith(letterSpacing: 0.4)),
  );
}

Widget rweCodeKeyCell(String text,
    {Color color = rwePaper, Color textColor = rweCharcoal, bool mono = true}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    color: color,
    alignment: Alignment.centerLeft,
    child: Text(text,
        style: mono
            ? rweMono(color: textColor)
            : rweBody(color: textColor, size: 12)),
  );
}

Widget rweCodeKeySection() {
  final TableRow header = TableRow(children: [
    rweCodeKeyHeaderCell('Scenario', color: rweInk),
    rweCodeKeyHeaderCell('code (physical)', color: rweCyan),
    rweCodeKeyHeaderCell('key (logical)', color: rweMagenta),
  ]);

  final List<List<String>> rows = [
    ['Pressing "A" (no shift, US layout)', '"KeyA"', '"a"'],
    ['Pressing "A" (with Shift, US layout)', '"KeyA"', '"A"'],
    ['Pressing "A" (with Caps Lock)', '"KeyA"', '"A"'],
    ['Pressing "A" (FR AZERTY layout)', '"KeyA"', '"q"'],
    ['Pressing top-row "1"', '"Digit1"', '"1"'],
    ['Pressing top-row "1" with Shift', '"Digit1"', '"!"'],
    ['Pressing Numpad "1"', '"Numpad1"', '"1"'],
    ['Pressing Numpad "1" (NumLock off)', '"Numpad1"', '"End"'],
    ['Pressing Enter (main)', '"Enter"', '"Enter"'],
    ['Pressing Enter (numpad)', '"NumpadEnter"', '"Enter"'],
    ['Pressing Left Shift', '"ShiftLeft"', '"Shift"'],
    ['Pressing Right Shift', '"ShiftRight"', '"Shift"'],
    ['Pressing F5', '"F5"', '"F5"'],
    ['Pressing dead "´" key', '"Backquote"', '"Dead"'],
  ];

  final List<TableRow> dataRows = [];
  for (var i = 0; i < rows.length; i++) {
    final bg = i.isEven ? rwePaper : rwePaperShade;
    dataRows.add(TableRow(children: [
      rweCodeKeyCell(rows[i][0], color: bg, mono: false),
      rweCodeKeyCell(rows[i][1], color: bg, textColor: rweCyan),
      rweCodeKeyCell(rows[i][2], color: bg, textColor: rweMagenta),
    ]));
  }

  return rweCard(
    '2 · code vs key — physical vs logical',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('TL;DR',
            'code = which physical key. key = what character/value the OS '
            'computed after layout, locale, modifiers and dead-key state.',
            rweInk),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: rweMist),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2.4),
              1: FlexColumnWidth(1.4),
              2: FlexColumnWidth(1.4),
            },
            children: [header, ...dataRows],
          ),
        ),
        const SizedBox(height: 10),
        rweBullet(
            'Same physical key may yield very different `key` values depending '
            'on shift state, caps lock or active layout (en-US vs fr-FR).'),
        rweBullet(
            'Numpad-1 and main-row-1 share `"1"` for `key` but disambiguate '
            'cleanly via `code = "Numpad1" | "Digit1"`.'),
        rweBullet(
            'Numpad-Enter and the main Enter return the same `key = "Enter"` '
            'but different `code = "NumpadEnter" | "Enter"`.'),
        rweBullet(
            'Left vs Right Shift share `key = "Shift"`; only `code` and the '
            'KeyboardEvent.location field tell them apart.'),
      ],
    ),
    accent: rweCyan,
    subtitle: 'Two parallel namespaces from the W3C UI Events spec.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 4 — KeyboardEvent.location with a small diagrammed keyboard.
// ───────────────────────────────────────────────────────────────────────────
Widget rweLocationKey(String label, int loc, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        children: [
          Text(label,
              style:
                  rweMonoBold(color: color, size: 12)),
          const SizedBox(height: 2),
          Text('loc=$loc',
              style: TextStyle(
                  color: color, fontSize: 9, fontWeight: FontWeight.w700)),
        ],
      ),
    ),
  );
}

Widget rweLocationDiagram() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: rwePaperShade,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: rweMist),
    ),
    child: Column(
      children: [
        Row(
          children: [
            rweLocationKey('Ctrl L', 1, rweCyan),
            rweLocationKey('Win L', 1, rweCyan),
            rweLocationKey('Alt L', 1, rweCyan),
            Expanded(
              flex: 5,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: rweInk.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: rweInk.withValues(alpha: 0.5)),
                ),
                child: Column(
                  children: [
                    Text('Space',
                        style: rweMonoBold(color: rweInk, size: 12)),
                    const SizedBox(height: 2),
                    Text('loc=0',
                        style: TextStyle(
                            color: rweInk,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            rweLocationKey('Alt R', 2, rweMagenta),
            rweLocationKey('Win R', 2, rweMagenta),
            rweLocationKey('Ctrl R', 2, rweMagenta),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: rweInk.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: rweInk.withValues(alpha: 0.4)),
                ),
                child: Column(
                  children: [
                    Text('Letters / Digits / Enter',
                        style: rweMonoBold(color: rweInk, size: 11)),
                    const SizedBox(height: 2),
                    Text('loc=0 (STANDARD)',
                        style: TextStyle(
                            color: rweInk,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            rweLocationKey('Num7', 3, rweMoss),
            rweLocationKey('Num8', 3, rweMoss),
            rweLocationKey('Num9', 3, rweMoss),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(flex: 6, child: const SizedBox()),
            rweLocationKey('Num4', 3, rweMoss),
            rweLocationKey('Num5', 3, rweMoss),
            rweLocationKey('Num6', 3, rweMoss),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(flex: 6, child: const SizedBox()),
            rweLocationKey('Num1', 3, rweMoss),
            rweLocationKey('Num2', 3, rweMoss),
            rweLocationKey('Num3', 3, rweMoss),
          ],
        ),
      ],
    ),
  );
}

Widget rweLocationSection() {
  return rweCard(
    '3 · KeyboardEvent.location — four regions',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Why location matters',
            'Most keys live in the standard region. Modifier keys (Shift, '
            'Ctrl, Alt, Meta) appear twice (left + right) and the numpad '
            'duplicates digits, Enter, /, *, +, -, .. The location int is '
            'how the W3C disambiguates them when the `key` value is the same.',
            rweCyan),
        const SizedBox(height: 8),
        rweKeyVal('DOM_KEY_LOCATION_STANDARD', '0 — main key area', color: rweInk),
        rweKeyVal('DOM_KEY_LOCATION_LEFT', '1 — left modifier (e.g. ShiftLeft)',
            color: rweCyan),
        rweKeyVal('DOM_KEY_LOCATION_RIGHT',
            '2 — right modifier (e.g. ShiftRight)',
            color: rweMagenta),
        rweKeyVal('DOM_KEY_LOCATION_NUMPAD',
            '3 — numpad key (e.g. Numpad1, NumpadEnter)',
            color: rweMoss),
        rweDivider(),
        rweLocationDiagram(),
        const SizedBox(height: 10),
        rweBullet(
            'For non-modifier, non-numpad keys (letters, digits, Tab, '
            'Backspace, arrows on the cursor pad), location is always 0.'),
        rweBullet(
            'Caps Lock / Num Lock / Scroll Lock are typically reported with '
            'location 0 even though physically they live above the numpad.'),
        rweBullet(
            'Browser engines have settled on these values; legacy browsers '
            'sometimes used location 4 ("mobile") which has been removed.'),
      ],
    ),
    accent: rweMagenta,
    subtitle: 'Standard / Left / Right / Numpad — and how to read them.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 5 — Modifier bitmask register (8-bit diagram).
// ───────────────────────────────────────────────────────────────────────────
Widget rweBitCell(int idx, String name, bool set, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: set ? color : rwePaperShade,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: rweMist),
      ),
      child: Column(
        children: [
          Text(set ? '1' : '0',
              style: TextStyle(
                  color: set ? rweWhite : rweAsh,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 16)),
          const SizedBox(height: 2),
          Text(name,
              style: TextStyle(
                  color: set ? rweWhite : rweCharcoal,
                  fontSize: 9,
                  fontWeight: FontWeight.w700)),
          Text('bit $idx',
              style: TextStyle(
                  color: set
                      ? rweWhite.withValues(alpha: 0.85)
                      : rweAsh,
                  fontSize: 8,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}

Widget rweBitRegister(int value) {
  bool b(int i) => (value & (1 << i)) != 0;
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: rwePaper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: rweMist),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('metaState = 0x${value.toRadixString(16).padLeft(2, '0')}'
                ' (decimal $value)',
                style: rweMonoBold()),
            const Spacer(),
            Text('binary 0b${value.toRadixString(2).padLeft(8, '0')}',
                style: rweMono(color: rweAsh)),
          ],
        ),
        const SizedBox(height: 6),
        Row(children: [
          rweBitCell(7, 'Fn', b(7), rweTeal),
          rweBitCell(6, 'Scrl', b(6), rweTeal),
          rweBitCell(5, 'Num', b(5), rweMoss),
          rweBitCell(4, 'Caps', b(4), rweMoss),
          rweBitCell(3, 'Meta', b(3), rweMagenta),
          rweBitCell(2, 'Alt', b(2), rweMagenta),
          rweBitCell(1, 'Ctrl', b(1), rweCyan),
          rweBitCell(0, 'Shift', b(0), rweCyan),
        ]),
      ],
    ),
  );
}

Widget rweModifierSection() {
  // Concrete metaState samples (these mirror the engine constants in
  // raw_keyboard_web.dart: modifierShift=1, modifierCtrl=2, modifierAlt=4,
  // modifierMeta=8, modifierCapsLock=16, modifierNumLock=32, etc.)
  const int sampleNone = 0;
  const int sampleShift = 1;
  const int sampleCtrlAlt = 2 | 4;
  const int sampleAllMods = 1 | 2 | 4 | 8;
  const int sampleCapsAndShift = 1 | 16;
  const int sampleNumLock = 32;

  return rweCard(
    '4 · metaState — an 8-bit modifier register',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Bitmask layout',
            'metaState is an int whose bits each map to one modifier. '
            'Use bitwise AND with the constants on RawKeyEventDataWeb '
            '(modifierShift = 0x01, modifierCtrl = 0x02, modifierAlt = 0x04, '
            'modifierMeta = 0x08, modifierCapsLock = 0x10, modifierNumLock = '
            '0x20, modifierScrollLock = 0x40 …). bit-or them to combine.',
            rweMagenta),
        const SizedBox(height: 8),
        Text('No modifiers held (idle):', style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleNone),
        const SizedBox(height: 8),
        Text('Just Shift:', style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleShift),
        const SizedBox(height: 8),
        Text('Ctrl + Alt (browser sometimes treats as AltGr):',
            style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleCtrlAlt),
        const SizedBox(height: 8),
        Text('Shift + Ctrl + Alt + Meta (full chord):', style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleAllMods),
        const SizedBox(height: 8),
        Text('Caps Lock latched + Shift held:', style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleCapsAndShift),
        const SizedBox(height: 8),
        Text('Num Lock latched, no other keys:', style: rweLabel()),
        const SizedBox(height: 4),
        rweBitRegister(sampleNumLock),
        const SizedBox(height: 8),
        rweCode(
          '// Reading the bitmask\n'
          'final bool shift = (data.metaState & 0x01) != 0;\n'
          'final bool ctrl  = (data.metaState & 0x02) != 0;\n'
          'final bool alt   = (data.metaState & 0x04) != 0;\n'
          'final bool meta  = (data.metaState & 0x08) != 0;\n'
          '// Or use the high-level inherited helpers:\n'
          'data.isShiftPressed; data.isControlPressed;\n'
          'data.isAltPressed;   data.isMetaPressed;',
        ),
      ],
    ),
    accent: rweMagenta,
    subtitle: 'shift · ctrl · alt · meta · caps · num · scroll · fn',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 6 — Six concrete sample event cards. Each instantiates a real
// RawKeyEventDataWeb and prints it as a JSON-like blob.
// ───────────────────────────────────────────────────────────────────────────
String rweJsonish(_RawKeyEventDataWeb d) {
  return '{\n'
      '  "code"     : "${d.code}",\n'
      '  "key"      : "${d.key}",\n'
      '  "location" : ${d.location},\n'
      '  "metaState": 0x${d.metaState.toRadixString(16).padLeft(2, '0')},\n'
      '  "keyCode"  : ${d.keyCode}\n'
      '}';
}

String rweLocationName(int loc) {
  switch (loc) {
    case 0:
      return 'STANDARD';
    case 1:
      return 'LEFT';
    case 2:
      return 'RIGHT';
    case 3:
      return 'NUMPAD';
    default:
      return 'UNKNOWN($loc)';
  }
}

Widget rweEventCard(String title, _RawKeyEventDataWeb data, String narrative,
    Color accent) {
  final List<String> mods = [];
  if ((data.metaState & 0x01) != 0) mods.add('Shift');
  if ((data.metaState & 0x02) != 0) mods.add('Ctrl');
  if ((data.metaState & 0x04) != 0) mods.add('Alt');
  if ((data.metaState & 0x08) != 0) mods.add('Meta');
  if ((data.metaState & 0x10) != 0) mods.add('CapsLock');
  if ((data.metaState & 0x20) != 0) mods.add('NumLock');
  final String chord = mods.isEmpty ? '∅ (no modifiers)' : mods.join(' + ');
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: rwePaperShade,
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: rweHeading(color: accent)),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(rweLocationName(data.location),
                  style: rweMono(color: accent, size: 10)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(narrative, style: rweBody()),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: rweCharcoal,
            borderRadius: BorderRadius.circular(6),
          ),
          width: double.infinity,
          child: Text(rweJsonish(data),
              style: rweMono(color: rweCyanSoft, size: 11.5)),
        ),
        const SizedBox(height: 6),
        rweKeyVal('held modifiers', chord, color: accent),
        rweKeyVal('runtimeType', '${data.runtimeType}', color: accent),
      ],
    ),
  );
}

Widget rweSampleEventsSection() {
  // Construct six real RawKeyEventDataWeb instances. These exercise all
  // four location regions, the modifier bitmask and both `code` ≠ `key`
  // and `code` == `key` shapes.
  final _RawKeyEventDataWeb evKeyA = _RawKeyEventDataWeb(
    code: 'KeyA',
    key: 'a',
    location: 0,
    metaState: 0,
    keyCode: 65,
  );
  final _RawKeyEventDataWeb evNumpad1 = _RawKeyEventDataWeb(
    code: 'Numpad1',
    key: '1',
    location: 3,
    metaState: 32, // NumLock latched
    keyCode: 97,
  );
  final _RawKeyEventDataWeb evArrowUp = _RawKeyEventDataWeb(
    code: 'ArrowUp',
    key: 'ArrowUp',
    location: 0,
    metaState: 0,
    keyCode: 38,
  );
  final _RawKeyEventDataWeb evMetaLeft = _RawKeyEventDataWeb(
    code: 'MetaLeft',
    key: 'Meta',
    location: 1,
    metaState: 8,
    keyCode: 91,
  );
  final _RawKeyEventDataWeb evMetaRight = _RawKeyEventDataWeb(
    code: 'MetaRight',
    key: 'Meta',
    location: 2,
    metaState: 8,
    keyCode: 93,
  );
  final _RawKeyEventDataWeb evShiftA = _RawKeyEventDataWeb(
    code: 'KeyA',
    key: 'A',
    location: 0,
    metaState: 1, // Shift down
    keyCode: 65,
  );

  return rweCard(
    '5 · Six sample RawKeyEventDataWeb instances',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweEventCard(
            'evKeyA — pressing A on a US layout',
            evKeyA,
            'Plain "a" on the home row. code is the W3C-stable "KeyA"; key '
            'reflects the lowercase glyph; location stays 0 (STANDARD).',
            rweInk),
        rweEventCard(
            'evNumpad1 — pressing 1 on the numpad',
            evNumpad1,
            'Same printable "1" as the main row, but discriminated by '
            'code = "Numpad1" and location = 3 (NUMPAD). NumLock is latched, '
            'metaState bit 5 is set.',
            rweMoss),
        rweEventCard(
            'evArrowUp — pressing the up arrow',
            evArrowUp,
            'Non-printable navigation key. Notably, code == key == "ArrowUp" '
            'because there is no glyph; location is STANDARD.',
            rweCyan),
        rweEventCard(
            'evMetaLeft — pressing the left ⌘ / Win / Super',
            evMetaLeft,
            'Modifier on the left of the spacebar. location = 1 (LEFT). '
            'metaState bit 3 is set because Meta is held while it fires.',
            rweMagenta),
        rweEventCard(
            'evMetaRight — pressing the right ⌘ / Win / Super',
            evMetaRight,
            'Same key value as evMetaLeft ("Meta") but location = 2 (RIGHT) '
            'and code = "MetaRight". The pair is how chord engines tell '
            'sides apart.',
            rweMagenta),
        rweEventCard(
            'evShiftA — pressing Shift+A',
            evShiftA,
            'Same physical key as evKeyA, but the OS lifted it through the '
            'shift map: key = "A" while code stays "KeyA". metaState bit 0 '
            '(Shift) is set.',
            rweAmber),
      ],
    ),
    accent: rweAmber,
    subtitle: '4 location regions × 2 modifier shapes × 2 namespaces.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 7 — Browser quirks, especially legacy keyCode disagreement.
// ───────────────────────────────────────────────────────────────────────────
Widget rweQuirkRow(String scenario, String chrome, String firefox, String safari,
    String edge) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: rwePaperShade,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(scenario, style: rweLabel()),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            rweChip('Chrome: $chrome', rweInk),
            rweChip('Firefox: $firefox', rweAmber),
            rweChip('Safari: $safari', rweCyan),
            rweChip('Edge: $edge', rweMagenta),
          ],
        ),
      ],
    ),
  );
}

Widget rweQuirkSection() {
  return rweCard(
    '6 · Browser quirks — the legacy keyCode minefield',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Spec status',
            'KeyboardEvent.keyCode is normative-but-deprecated: the W3C '
            'requires browsers to keep returning *something* for legacy '
            'apps, but the values are no longer specified. Engines diverge.',
            rweAmber),
        const SizedBox(height: 8),
        rweQuirkRow('Pressing ";" (US layout)', '186', '59', '186', '186'),
        rweQuirkRow('Pressing "=" (US layout)', '187', '61', '187', '187'),
        rweQuirkRow('Pressing "-" (US layout)', '189', '173', '189', '189'),
        rweQuirkRow('Pressing dead "´" (DE layout)', '221', '221', '221', '221'),
        rweQuirkRow('AltGr (German layout)',
            'Ctrl+Alt synth', 'AltGraph', 'AltGraph', 'Ctrl+Alt synth'),
        rweQuirkRow('Pressing F12', '123', '123', 'sometimes blocked',
            '123 / blocked'),
        rweDivider(),
        rweBullet(
            'Firefox historically returned different keyCodes for "punctuation '
            'with shifted variants" than Chromium-based browsers; this is '
            'the single biggest cross-browser source of bugs in legacy '
            'JavaScript shortcuts.'),
        rweBullet(
            'Safari treats AltGraph as a real, observable modifier; Chromium '
            'on Windows synthesizes AltGr as the simultaneous Ctrl+Alt chord, '
            'so metaState bits 1 and 2 are *both* set on a single character.'),
        rweBullet(
            'Mobile Chrome on Android sends keydown events with code = "" '
            'and keyCode = 229 ("composing") for IME-buffered characters. '
            'Treat that as "ignore until composition end".'),
        rweBullet(
            'F-keys, F11, F12 and Esc may be eaten by the browser shell '
            'before they reach the document — your KeyboardListener will '
            'simply never see them.'),
      ],
    ),
    accent: rweAmber,
    subtitle: 'Chrome / Firefox / Safari / Edge — and where they disagree.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 8 — Deprecation note: RawKeyboard → HardwareKeyboard / KeyEvent.
// ───────────────────────────────────────────────────────────────────────────
Widget rweDeprecationStage(
    String title, String notation, String description, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: rweHeading(color: color, size: 13)),
          const SizedBox(height: 4),
          Text(notation, style: rweMono(color: color)),
          const SizedBox(height: 6),
          Text(description, style: rweBody(size: 11.5)),
        ],
      ),
    ),
  );
}

Widget rweDeprecationSection() {
  return rweCard(
    '7 · Deprecation — the migration to HardwareKeyboard',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Why deprecated?',
            'RawKeyEventData and its platform subclasses leak engine details '
            'and force apps to fork by platform. The replacement KeyEvent '
            'system is platform-agnostic, layered (HardwareKeyboard → '
            'FocusManager → KeyboardListener) and uses LogicalKeyboardKey / '
            'PhysicalKeyboardKey directly. Marked deprecated after Flutter '
            'v3.18.0-2.0.pre.',
            rweTeal),
        const SizedBox(height: 8),
        Row(
          children: [
            rweDeprecationStage(
              'Old (deprecated)',
              'RawKeyboard\nRawKeyEvent\nRawKeyEventDataWeb',
              'Per-platform subclasses, exposes raw browser fields. Still '
              'present, still works, but flagged.',
              rweAmber,
            ),
            rweDeprecationStage(
              'Transitional',
              'KeyEventManager\n.handleRawKeyMessage',
              'The shim that now feeds RawKey events from the new KeyEvent '
              'pipeline so legacy code keeps running.',
              rweMagenta,
            ),
            rweDeprecationStage(
              'New (preferred)',
              'HardwareKeyboard\nKeyEvent\nKeyboardListener',
              'Platform-agnostic, uses LogicalKeyboardKey + '
              'PhysicalKeyboardKey, plays nicely with web, mobile and desktop.',
              rweTeal,
            ),
          ],
        ),
        const SizedBox(height: 10),
        rweCode(
          '// OLD (deprecated)\n'
          'RawKeyboard.instance.addListener((RawKeyEvent ev) {\n'
          '  if (ev.data is RawKeyEventDataWeb) {\n'
          '    final web = ev.data as RawKeyEventDataWeb;\n'
          '    if (web.code == "KeyA") doSomething();\n'
          '  }\n'
          '});\n'
          '\n'
          '// NEW (preferred)\n'
          'HardwareKeyboard.instance.addHandler((KeyEvent ev) {\n'
          '  if (ev is KeyDownEvent &&\n'
          '      ev.physicalKey == PhysicalKeyboardKey.keyA) {\n'
          '    doSomething();\n'
          '  }\n'
          '  return false;\n'
          '});',
        ),
      ],
    ),
    accent: rweTeal,
    subtitle: 'RawKeyEventDataWeb is alive but has a successor.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 9 — logicalKey / physicalKey derivation table.
// ───────────────────────────────────────────────────────────────────────────
Widget rweDeriveCell(String text,
    {Color color = rwePaper, Color textColor = rweCharcoal, bool mono = true}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    color: color,
    alignment: Alignment.centerLeft,
    child: Text(text,
        style: mono
            ? rweMono(color: textColor)
            : rweBody(color: textColor, size: 12)),
  );
}

Widget rweDerivationSection() {
  final TableRow header = TableRow(children: [
    rweCodeKeyHeaderCell('Web event', color: rweInk),
    rweCodeKeyHeaderCell('PhysicalKeyboardKey', color: rweCyan),
    rweCodeKeyHeaderCell('LogicalKeyboardKey', color: rweMagenta),
  ]);
  final List<List<String>> rows = [
    ['code:KeyA, key:"a"', 'PhysicalKeyboardKey.keyA',
      'LogicalKeyboardKey.keyA'],
    ['code:KeyA, key:"A" (Shift)', 'PhysicalKeyboardKey.keyA',
      'LogicalKeyboardKey.keyA'],
    ['code:Digit1, key:"1"', 'PhysicalKeyboardKey.digit1',
      'LogicalKeyboardKey.digit1'],
    ['code:Numpad1, key:"1"', 'PhysicalKeyboardKey.numpad1',
      'LogicalKeyboardKey.numpad1'],
    ['code:Numpad1, key:"End"', 'PhysicalKeyboardKey.numpad1',
      'LogicalKeyboardKey.end'],
    ['code:Enter, key:"Enter"', 'PhysicalKeyboardKey.enter',
      'LogicalKeyboardKey.enter'],
    ['code:NumpadEnter, key:"Enter"', 'PhysicalKeyboardKey.numpadEnter',
      'LogicalKeyboardKey.enter'],
    ['code:ShiftLeft, key:"Shift"', 'PhysicalKeyboardKey.shiftLeft',
      'LogicalKeyboardKey.shiftLeft'],
    ['code:ShiftRight, key:"Shift"', 'PhysicalKeyboardKey.shiftRight',
      'LogicalKeyboardKey.shiftRight'],
    ['code:MetaLeft, key:"Meta"', 'PhysicalKeyboardKey.metaLeft',
      'LogicalKeyboardKey.metaLeft'],
    ['code:ArrowUp, key:"ArrowUp"', 'PhysicalKeyboardKey.arrowUp',
      'LogicalKeyboardKey.arrowUp'],
    ['code:F5, key:"F5"', 'PhysicalKeyboardKey.f5', 'LogicalKeyboardKey.f5'],
    ['code:Backquote, key:"Dead"', 'PhysicalKeyboardKey.backquote',
      'LogicalKeyboardKey.dead'],
  ];
  final List<TableRow> dataRows = [];
  for (var i = 0; i < rows.length; i++) {
    final bg = i.isEven ? rwePaper : rwePaperShade;
    dataRows.add(TableRow(children: [
      rweDeriveCell(rows[i][0], color: bg, mono: true),
      rweDeriveCell(rows[i][1], color: bg, textColor: rweCyan),
      rweDeriveCell(rows[i][2], color: bg, textColor: rweMagenta),
    ]));
  }
  return rweCard(
    '8 · Derivation to PhysicalKeyboardKey & LogicalKeyboardKey',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Two parallel functions',
            'physicalKey is derived purely from `code` (and is therefore '
            'layout-stable). logicalKey looks at `key` first; if `key` is a '
            'special token like "Dead" or "Unidentified" it falls back to '
            'a `code`-based mapping.',
            rweInk),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: rweMist),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.7),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
            },
            children: [header, ...dataRows],
          ),
        ),
        const SizedBox(height: 10),
        rweBullet(
            'PhysicalKeyboardKey is keyed by the W3C `code` string and is '
            'identical across all platforms — Mac, Linux, Windows, Web, '
            'Android, iOS — for the same physical key.'),
        rweBullet(
            'LogicalKeyboardKey is identity-aware: numpad-1 with NumLock '
            'off becomes End, not "1", because the OS published "End" as '
            'the `key` value.'),
        rweBullet(
            'When `key` is "Unidentified" or "Process" (IME), the engine '
            'falls back to the `code` mapping or assigns LogicalKeyboardKey '
            '.unidentified.'),
      ],
    ),
    accent: rweInk,
    subtitle: 'How code & key turn into Flutter\'s key abstractions.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 10 — Recipe code listing for KeyboardListener handling these events.
// ───────────────────────────────────────────────────────────────────────────
Widget rweRecipeSection() {
  return rweCard(
    '9 · Recipe — handling web key events with KeyboardListener',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Modern path',
            'Even though RawKeyEventDataWeb still works, every new widget '
            'should use KeyboardListener (or Focus + onKeyEvent) and the '
            'KeyEvent class. The recipe below is what you would actually '
            'ship today.',
            rweMoss),
        const SizedBox(height: 8),
        rweCode(
          'class WebShortcutSink extends StatefulWidget {\n'
          '  const WebShortcutSink({super.key, required this.child});\n'
          '  final Widget child;\n'
          '  @override\n'
          '  State<WebShortcutSink> createState() => _WebShortcutSinkState();\n'
          '}\n'
          '\n'
          'class _WebShortcutSinkState extends State<WebShortcutSink> {\n'
          '  final FocusNode _node = FocusNode();\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    WidgetsBinding.instance.addPostFrameCallback((_) {\n'
          '      _node.requestFocus();\n'
          '    });\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return KeyboardListener(\n'
          '      focusNode: _node,\n'
          '      autofocus: true,\n'
          '      onKeyEvent: _handle,\n'
          '      child: widget.child,\n'
          '    );\n'
          '  }\n'
          '\n'
          '  void _handle(KeyEvent ev) {\n'
          '    // ── Use physicalKey for layout-independent shortcuts ──\n'
          '    if (ev is KeyDownEvent &&\n'
          '        ev.physicalKey == PhysicalKeyboardKey.keyS &&\n'
          '        HardwareKeyboard.instance.isControlPressed) {\n'
          '      _save();\n'
          '      return;\n'
          '    }\n'
          '    // ── Use logicalKey when you actually want the glyph ──\n'
          '    if (ev is KeyDownEvent &&\n'
          '        ev.character == "?" ) {\n'
          '      _showHelp();\n'
          '      return;\n'
          '    }\n'
          '    // ── Distinguish numpad Enter from main Enter ──\n'
          '    if (ev is KeyDownEvent &&\n'
          '        ev.physicalKey == PhysicalKeyboardKey.numpadEnter) {\n'
          '      _onNumpadEnter();\n'
          '      return;\n'
          '    }\n'
          '  }\n'
          '\n'
          '  void _save() {/* … */}\n'
          '  void _showHelp() {/* … */}\n'
          '  void _onNumpadEnter() {/* … */}\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _node.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 8),
        rweBullet(
            'Reach for HardwareKeyboard.instance.isControlPressed (et al.) '
            'rather than reading metaState bits manually.'),
        rweBullet(
            'KeyEvent.character is the W3C `key` value when it is a printable '
            'glyph and null otherwise — handy for "type a `?` to open help".'),
        rweBullet(
            'For text fields, prefer Shortcuts + Actions (Intent dispatch) '
            'over a global KeyboardListener so focus traversal still works.'),
      ],
    ),
    accent: rweMoss,
    subtitle: 'Focus + KeyboardListener + KeyEvent — the modern shape.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Section 11 — Pitfalls & anti-patterns.
// ───────────────────────────────────────────────────────────────────────────
Widget rwePitfallSection() {
  return rweCard(
    '10 · Pitfalls — keyCode is legacy, key changes by layout',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rweCallout('Rule of thumb',
            'For *what physical button* the user pressed, use `code` (and '
            'PhysicalKeyboardKey). For *what character* they intend to type, '
            'use `key` (and KeyEvent.character). Never key shortcuts off '
            '`keyCode`.',
            rweMagenta),
        const SizedBox(height: 8),
        rweBullet(
            'Pitfall #1 — keying shortcuts off keyCode. Firefox returns 173 '
            'for "-" while Chromium returns 189. Your shortcut breaks for '
            'half your users.', color: rweMagenta),
        rweBullet(
            'Pitfall #2 — keying shortcuts off `key`. A French AZERTY user '
            'pressing the same physical key as US "A" gets `key = "q"`. '
            'Your "Ctrl+S = Save" becomes "Ctrl+Q = Save" on their machine.',
            color: rweMagenta),
        rweBullet(
            'Pitfall #3 — confusing main Enter and Numpad Enter. They share '
            '`key = "Enter"` but their `code` differs. If you treat them '
            'the same in a "submit form" handler, numpad-Enter users get '
            'a surprise behaviour.', color: rweMagenta),
        rweBullet(
            'Pitfall #4 — assuming Caps Lock fires keydown only. Browsers '
            'are inconsistent: some only fire on the toggle event, some '
            'fire continuously while held. Read the metaState bit instead '
            'of counting keydown events.', color: rweMagenta),
        rweBullet(
            'Pitfall #5 — IME composition. While the user is composing CJK '
            'text, code can be empty and keyCode = 229. Do not feed those '
            'into shortcut detection.', color: rweMagenta),
        rweBullet(
            'Pitfall #6 — relying on RawKeyEventDataWeb forever. The class '
            'is deprecated; new Flutter versions may at any point stop '
            'producing it. Migrate to KeyEvent on your next refactor.',
            color: rweMagenta),
        rweBullet(
            'Pitfall #7 — assuming AltGr is a single bit. It is composed '
            'differently by browser; rely on PhysicalKeyboardKey.altRight '
            'plus character semantics, not on a "ctrl+alt" probe.',
            color: rweMagenta),
        rweBullet(
            'Pitfall #8 — caching keyCode tables. The legacy mapping is '
            'underspecified; use the published Flutter LogicalKeyboardKey '
            'and PhysicalKeyboardKey constants instead.',
            color: rweMagenta),
      ],
    ),
    accent: rweMagenta,
    subtitle: 'Eight ways to corrupt a perfectly good keyboard handler.',
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Footer
// ───────────────────────────────────────────────────────────────────────────
Widget rweFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 28),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: rweInk,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RawKeyEventDataWeb · deep demo',
            style: rweTitle(color: rweWhite, size: 16)),
        const SizedBox(height: 4),
        Text(
          'Subject from package:flutter/services.dart. Five fields. Four '
          'KeyboardEvent.location regions. Eight modifier bits. Six sample '
          'instances. One deprecation arc and one modern recipe.',
          style: rweBody(color: rweMist, size: 12.5),
        ),
        const SizedBox(height: 8),
        Wrap(
          children: [
            rweChip('flutter/services', rweCyanSoft),
            rweChip('@Deprecated v3.18', rweAmberSoft),
            rweChip('W3C UI Events', rweMagentaSoft),
            rweChip('Hardware­Keyboard ahead', rweMossSoft),
          ],
        ),
        const SizedBox(height: 8),
        Text('— end of report —',
            style: rweMono(color: rweCyanSoft, size: 11)),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Console reporter — prints to stdout while building, mirroring the visual
// canvas. Sibling fixtures lean heavily on print() side-effects.
// ───────────────────────────────────────────────────────────────────────────
void rwePrintConsoleReport() {
  print('═══════════════════════════════════════════════════════════════');
  print('  RawKeyEventDataWeb · Deep Demo');
  print('  package:flutter/services.dart  (deprecated after v3.18.0-2.0.pre)');
  print('═══════════════════════════════════════════════════════════════');
  print('');
  print('Five fields:');
  print('  • code      String   "KeyboardEvent.code"      physical, layout-stable');
  print('  • key       String   "KeyboardEvent.key"       logical, layout-aware');
  print('  • location  int      0..3                      STANDARD/LEFT/RIGHT/NUMPAD');
  print('  • metaState int      bitmask                   shift/ctrl/alt/meta/...');
  print('  • keyCode   int      legacy                    deprecated by W3C');
  print('');
  print('Sample instances:');
  final _RawKeyEventDataWeb evKeyA = _RawKeyEventDataWeb(
    code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
  );
  final _RawKeyEventDataWeb evShiftA = _RawKeyEventDataWeb(
    code: 'KeyA', key: 'A', location: 0, metaState: 1, keyCode: 65,
  );
  final _RawKeyEventDataWeb evNumpad1 = _RawKeyEventDataWeb(
    code: 'Numpad1', key: '1', location: 3, metaState: 32, keyCode: 97,
  );
  final _RawKeyEventDataWeb evMetaLeft = _RawKeyEventDataWeb(
    code: 'MetaLeft', key: 'Meta', location: 1, metaState: 8, keyCode: 91,
  );
  final _RawKeyEventDataWeb evMetaRight = _RawKeyEventDataWeb(
    code: 'MetaRight', key: 'Meta', location: 2, metaState: 8, keyCode: 93,
  );
  final _RawKeyEventDataWeb evArrowUp = _RawKeyEventDataWeb(
    code: 'ArrowUp', key: 'ArrowUp', location: 0, metaState: 0, keyCode: 38,
  );
  for (final _RawKeyEventDataWeb ev in [
    evKeyA,
    evShiftA,
    evNumpad1,
    evMetaLeft,
    evMetaRight,
    evArrowUp,
  ]) {
    print('  ${ev.runtimeType}('
        'code: "${ev.code}", '
        'key: "${ev.key}", '
        'location: ${ev.location}, '
        'metaState: 0x${ev.metaState.toRadixString(16).padLeft(2, '0')}, '
        'keyCode: ${ev.keyCode})');
    print('     → physicalKey = ${ev.physicalKey}');
    print('     → logicalKey  = ${ev.logicalKey}');
    print('     → isShiftPressed = ${ev.isShiftPressed}, '
        'isControlPressed = ${ev.isControlPressed}, '
        'isAltPressed = ${ev.isAltPressed}, '
        'isMetaPressed = ${ev.isMetaPressed}');
  }
  print('');
  print('KeyboardEvent.location:');
  print('  0 → STANDARD (main key area)');
  print('  1 → LEFT     (left modifier — ShiftLeft, ControlLeft, AltLeft, MetaLeft)');
  print('  2 → RIGHT    (right modifier — ShiftRight, ControlRight, AltRight, MetaRight)');
  print('  3 → NUMPAD   (Numpad0..9, NumpadEnter, NumpadAdd, NumpadDecimal, …)');
  print('');
  print('metaState bit layout (engine constants):');
  print('  bit 0  modifierShift      0x01');
  print('  bit 1  modifierCtrl       0x02');
  print('  bit 2  modifierAlt        0x04');
  print('  bit 3  modifierMeta       0x08');
  print('  bit 4  modifierCapsLock   0x10');
  print('  bit 5  modifierNumLock    0x20');
  print('  bit 6  modifierScrollLock 0x40');
  print('  bit 7  reserved           0x80');
  print('');
  print('Browser quirks:');
  print('  • Firefox keyCode for ";"  = 59,  Chrome = 186');
  print('  • Firefox keyCode for "="  = 61,  Chrome = 187');
  print('  • Firefox keyCode for "-"  = 173, Chrome = 189');
  print('  • Mobile Chrome on Android: keyCode=229 + code="" while composing');
  print('  • Safari treats AltGraph as a real, observable modifier');
  print('');
  print('Deprecation path:');
  print('  RawKeyboard           → HardwareKeyboard');
  print('  RawKeyEvent           → KeyEvent');
  print('  RawKeyEventDataWeb    → (folded into KeyEvent.physicalKey/logicalKey)');
  print('');
  print('Pitfalls:');
  print('  1) Don\'t key shortcuts off keyCode — browsers disagree.');
  print('  2) Don\'t key shortcuts off `key` — layouts disagree.');
  print('  3) Distinguish numpad Enter (NumpadEnter) from main Enter.');
  print('  4) Read Caps Lock from metaState bits, not from keydown counts.');
  print('  5) Skip events while keyCode == 229 (IME composition).');
  print('═══════════════════════════════════════════════════════════════');
  print('  RawKeyEventDataWeb test executing — visual canvas follows.');
  print('═══════════════════════════════════════════════════════════════');
}

// ───────────────────────────────────────────────────────────────────────────
// Entry point
// ───────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  rwePrintConsoleReport();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyEventDataWeb · deep demo',
    theme: ThemeData(
      scaffoldBackgroundColor: rwePaper,
      primaryColor: rweInk,
      fontFamily: 'sans-serif',
    ),
    home: Scaffold(
      backgroundColor: rwePaper,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            rweHeroCard(),
            rweAnatomySection(),
            rweCodeKeySection(),
            rweLocationSection(),
            rweModifierSection(),
            rweSampleEventsSection(),
            rweQuirkSection(),
            rweDeprecationSection(),
            rweDerivationSection(),
            rweRecipeSection(),
            rwePitfallSection(),
            rweFooter(),
          ],
        ),
      ),
    ),
  );
}
