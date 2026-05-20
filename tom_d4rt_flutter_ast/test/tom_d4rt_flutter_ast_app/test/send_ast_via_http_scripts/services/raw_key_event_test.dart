// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_field
//
// =====================================================================
//  raw_key_event_test.dart
// =====================================================================
//  D4rt-AST sandbox deep demo for `RawKeyEvent` (and friends:
//  `RawKeyDownEvent`, `RawKeyUpEvent`) from package:flutter/services.dart.
//
//  IMPORTANT: `RawKeyEvent` is the LEGACY / DEPRECATED keyboard-event API
//  in Flutter.  It still ships with the framework (and is what countless
//  older plugins and tutorials reference), but new code should use the
//  modern hierarchy:
//
//      KeyEvent          (abstract base)
//        ├── KeyDownEvent
//        ├── KeyUpEvent
//        └── KeyRepeatEvent
//
//  served by `HardwareKeyboard.instance` and `KeyboardListener`.
//
//  The deprecation rationale (paraphrased from the Flutter team):
//
//    * `RawKeyEvent` exposed an unstructured grab-bag of platform fields
//      via `RawKeyEventData` subclasses (Linux/macOS/Windows/Android/iOS/
//      Web).  Code that walked these fields was inherently
//      non-portable.
//    * Modifier-state was tracked per-event from platform flags, leading
//      to "stuck-modifier" bugs whenever an event was lost.
//    * `RawKeyboard.instance` only synthesized partial state recovery.
//
//  The modern `HardwareKeyboard` + `KeyEvent` API solves these by:
//
//    * Owning canonical modifier state itself (no per-event flag race).
//    * Surfacing only `physicalKey`, `logicalKey`, `character`, and a
//      `timeStamp`, with no platform-specific subclasses leaking into
//      portable code.
//    * Dispatching synthesized events to keep state consistent.
//
//  Despite all of that, `RawKeyEvent` is still constructible and still
//  flows through legacy listeners, so this script demonstrates:
//
//    * How to construct `RawKeyDownEvent` / `RawKeyUpEvent` in a
//      portable, sandbox-safe way (no live keyboard subscription).
//    * How to read modifier state via `isControlPressed`,
//      `isShiftPressed`, `isAltPressed`, `isMetaPressed`,
//      `isModifierPressed(...)`.
//    * The full `RawKeyEventData` subclass family.
//    * A side-by-side migration map from `RawKeyEvent` to `KeyEvent`.
//
//  Visual theme: vintage typewriter / mechanical-keyboard.  The palette
//  is paper-cream, ribbon-red, brass, ink-black, and aged-key-cap gray.
//
//  D4rt-AST sandbox constraints respected:
//    * No setState / StatefulWidget / AnimationController.
//    * No Timer / Future / Stream / live keyboard subscription.
//    * Static snapshot only.  Indexed loops, no for-in over bridged
//      instances.  Single top-level `build()` returning the root.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------
//  U12 — local stand-ins for the @Deprecated RawKeyboard family.
// ---------------------------------------------------------------------
//
// The Flutter SDK classes used by this demo are all annotated
// `@Deprecated` and are therefore filtered out of the d4rt bridge
// surface by design (`ElementModeExtractor.generateDeprecatedElements
// = false`). See U12 in tom_d4rt_flutter_ast/doc/interpreter_unfixable.md.
//
// Deprecated SDK members this script references:
//   * RawKeyEvent          (raw_keyboard.dart:364, abstract base class)
//   * RawKeyDownEvent      (raw_keyboard.dart:674)
//   * RawKeyUpEvent        (raw_keyboard.dart:695)
//   * RawKeyEventDataLinux (raw_keyboard_linux.dart:30)
//   * GLFWKeyHelper        (raw_keyboard_linux.dart:255)
//   * ModifierKey          (raw_keyboard.dart:68 — enum)
//   * KeyboardSide         (raw_keyboard.dart:40 — enum)
//
// Variant B (typedef-rename swap) does not apply: the modernisation
// path is `RawKeyEvent → KeyEvent`, an entirely different API shape
// (no platform-specific RawKeyEventData subclass on KeyEvent — the
// platform layer is folded behind logicalKey/physicalKey). Variant A
// (local stand-in) is the only option. Every code-position reference
// to the deprecated names below is routed through the `_*` stand-ins;
// strings and comments preserve the SDK names verbatim so the
// didactic copy still documents them.
//
// `LogicalKeyboardKey` and `PhysicalKeyboardKey` are *not* deprecated
// and remain fully bridged — the stand-ins return real instances so
// `logicalKey.keyLabel`, `logicalKey.keyId`, `physicalKey.debugName`
// all resolve via the SDK as before.

enum _ModifierKey {
  controlModifier,
  shiftModifier,
  altModifier,
  metaModifier,
  capsLockModifier,
  numLockModifier,
  scrollLockModifier,
  functionModifier,
  symbolModifier,
}

enum _KeyboardSide { any, left, right, all }

class _GLFWKeyHelper {
  const _GLFWKeyHelper();
}

class _RawKeyEventDataLinux {
  const _RawKeyEventDataLinux({
    required this.keyHelper,
    required this.unicodeScalarValues,
    required this.keyCode,
    required this.scanCode,
    required this.modifiers,
    required this.isDown,
  });
  final _GLFWKeyHelper keyHelper;
  final int unicodeScalarValues;
  final int keyCode;
  final int scanCode;
  final int modifiers;
  final bool isDown;

  // GLFW modifier bitmask (mirrors the constants the demo cites):
  //   shift=0x0001, control=0x0002, alt=0x0004, super/meta=0x0008.
  bool isModifierPressed(_ModifierKey key,
      {_KeyboardSide side = _KeyboardSide.any}) {
    switch (key) {
      case _ModifierKey.shiftModifier:
        return (modifiers & 0x0001) != 0;
      case _ModifierKey.controlModifier:
        return (modifiers & 0x0002) != 0;
      case _ModifierKey.altModifier:
        return (modifiers & 0x0004) != 0;
      case _ModifierKey.metaModifier:
        return (modifiers & 0x0008) != 0;
      default:
        return false;
    }
  }
}

abstract class _RawKeyEvent {
  const _RawKeyEvent({required this.data, this.character});
  final _RawKeyEventDataLinux data;
  final String? character;

  // The demo uses unicodeScalarValues as the seed for logical id and
  // scanCode for the physical hid-usage. A non-positive scalar value
  // falls back to a stable placeholder so `keyLabel` / `debugName`
  // remain printable.
  LogicalKeyboardKey get logicalKey =>
      LogicalKeyboardKey(data.unicodeScalarValues == 0
          ? 0x100000000
          : data.unicodeScalarValues);
  PhysicalKeyboardKey get physicalKey =>
      PhysicalKeyboardKey(data.scanCode == 0
          ? 0x00070004
          : 0x00070000 | data.scanCode);

  bool get repeat => false;

  // Event-level modifier getters forward to the platform data — same
  // shape the real RawKeyEvent superclass uses.
  bool get isShiftPressed =>
      data.isModifierPressed(_ModifierKey.shiftModifier);
  bool get isControlPressed =>
      data.isModifierPressed(_ModifierKey.controlModifier);
  bool get isAltPressed => data.isModifierPressed(_ModifierKey.altModifier);
  bool get isMetaPressed =>
      data.isModifierPressed(_ModifierKey.metaModifier);
}

class _RawKeyDownEvent extends _RawKeyEvent {
  const _RawKeyDownEvent({required super.data, super.character});
}

class _RawKeyUpEvent extends _RawKeyEvent {
  const _RawKeyUpEvent({required super.data, super.character});
}

// ---------------------------------------------------------------------
//  Vintage-typewriter palette (≥10 const Colors).
// ---------------------------------------------------------------------

const Color kPaperCream = Color(0xFFF5ECD7);
const Color kPaperTan = Color(0xFFE6D5A8);
const Color kInkBlack = Color(0xFF1B140E);
const Color kInkSoft = Color(0xFF3A2E22);
const Color kRibbonRed = Color(0xFFB1331E);
const Color kRibbonRedDark = Color(0xFF7A1F0F);
const Color kBrass = Color(0xFFB08D3F);
const Color kBrassDark = Color(0xFF7B5F22);
const Color kKeyCapGray = Color(0xFF5C5247);
const Color kKeyCapLight = Color(0xFF8C8275);
const Color kTypebar = Color(0xFF2E2620);
const Color kPlaten = Color(0xFF14100B);
const Color kAged = Color(0xFFC9B486);
const Color kHighlight = Color(0xFFFFE9A3);

// ---------------------------------------------------------------------
//  Tiny print helpers.
// ---------------------------------------------------------------------

void hr(String label) {
  print('');
  print('=== $label ${'=' * (60 - label.length).clamp(0, 60)}');
}

void bullet(String text) {
  print('  • $text');
}

// ---------------------------------------------------------------------
//  Section helpers — visual building blocks for the demo card.
// ---------------------------------------------------------------------

Widget vintageHeader(String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kInkBlack, kTypebar, kKeyCapGray],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x99000000),
          offset: Offset(0, 4),
          blurRadius: 10,
        ),
        BoxShadow(
          color: Color(0x33B08D3F),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kPaperCream,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: kAged,
            fontSize: 13,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

Widget paperPanel({
  required String heading,
  required Widget child,
  Color stripColor = kRibbonRed,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kPaperCream, kPaperTan],
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
      border: Border.all(color: kBrassDark, width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: stripColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Text(
            heading,
            style: const TextStyle(
              color: kPaperCream,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: child,
        ),
      ],
    ),
  );
}

Widget keyCap(String label, {double width = 44, double height = 44}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        center: Alignment(-0.3, -0.4),
        radius: 1.2,
        colors: [kKeyCapLight, kKeyCapGray, kInkSoft],
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0xAA000000),
          offset: Offset(0, 3),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Color(0x44FFFFFF),
          offset: Offset(0, -1),
          blurRadius: 0,
        ),
      ],
      border: Border.all(color: kInkBlack, width: 1),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: kPaperCream,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget labelValue(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(
              color: kInkSoft,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kInkBlack,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget tableRow(List<String> cells, {bool header = false}) {
  return Container(
    decoration: BoxDecoration(
      color: header ? kKeyCapGray : Colors.transparent,
      border: const Border(
        bottom: BorderSide(color: kBrassDark, width: 0.5),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    child: Row(
      children: [
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Text(
              cells[i],
              style: TextStyle(
                color: header ? kPaperCream : kInkBlack,
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
                fontFamily: header ? null : 'monospace',
              ),
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
//  Migration "side-by-side" comparison row.
// ---------------------------------------------------------------------

Widget migrationRow(String legacy, String modern, String note) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kPaperCream, kHighlight],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: kBrass, width: 0.8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            legacy,
            style: const TextStyle(
              color: kRibbonRedDark,
              decoration: TextDecoration.lineThrough,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 14, color: kBrassDark),
        ),
        Expanded(
          flex: 4,
          child: Text(
            modern,
            style: const TextStyle(
              color: kInkBlack,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            note,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
//  build()
// =====================================================================

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------
  //  SECTION 0 — Anchor RawKeyDownEvent instance (Linux platform data).
  // -------------------------------------------------------------------
  hr('SECTION 0 — Anchor RawKeyDownEvent (Linux data)');
  print('Constructing a RawKeyDownEvent backed by RawKeyEventDataLinux.');
  print('Linux platform data is the most portable to fabricate manually.');
  print('We pick keyHelper="glfw" because GLFW codes are documented.');
  print('character: "a", keyCode mirrors XK_a (0x61).');

  // GLFW key helper for GLFW-style event codes (used by Linux desktop).
  // Note: GLFWKeyHelper has no const constructor, so RawKeyEventDataLinux
  // instances built with it cannot themselves be const.
  final _RawKeyEventDataLinux linuxData = _RawKeyEventDataLinux(
    keyHelper: _GLFWKeyHelper(),
    unicodeScalarValues: 0x61, // 'a'
    keyCode: 0x61,
    scanCode: 38, // X11 scancode for 'a' on a typical PC keyboard.
    modifiers: 0, // no modifiers held
    isDown: true,
  );

  final _RawKeyDownEvent anchorDown = _RawKeyDownEvent(
    data: linuxData,
    character: 'a',
  );

  bullet('runtimeType        = ${anchorDown.runtimeType}');
  bullet('character          = ${anchorDown.character}');
  bullet('logicalKey         = ${anchorDown.logicalKey.keyLabel}');
  bullet('logicalKey.id      = ${anchorDown.logicalKey.keyId}');
  bullet('physicalKey        = ${anchorDown.physicalKey.debugName}');
  bullet('data.runtimeType   = ${anchorDown.data.runtimeType}');
  bullet('isControlPressed   = ${anchorDown.isControlPressed}');
  bullet('isShiftPressed     = ${anchorDown.isShiftPressed}');
  bullet('isAltPressed       = ${anchorDown.isAltPressed}');
  bullet('isMetaPressed      = ${anchorDown.isMetaPressed}');
  bullet('repeat             = ${anchorDown.repeat}');

  // A matching key-up event lets us discuss the press lifecycle.
  final _RawKeyEventDataLinux linuxDataUp = _RawKeyEventDataLinux(
    keyHelper: _GLFWKeyHelper(),
    unicodeScalarValues: 0x61,
    keyCode: 0x61,
    scanCode: 38,
    modifiers: 0,
    isDown: false,
  );
  final _RawKeyUpEvent anchorUp = _RawKeyUpEvent(
    data: linuxDataUp,
    character: null,
  );
  bullet('paired KeyUp.runtimeType = ${anchorUp.runtimeType}');
  bullet('paired KeyUp.character   = ${anchorUp.character}');

  // -------------------------------------------------------------------
  //  SECTION 1 — Title banner data.
  // -------------------------------------------------------------------
  hr('SECTION 1 — Title banner');
  print('Vintage typewriter banner introduces the demo theme.');
  print('Theme: paper-cream + ribbon-red + brass + ink-black.');
  print('Banner uses LinearGradient #1 (ink to typebar).');
  print('Banner uses BoxShadow #1 (deep paper drop) and #2 (brass rim).');

  // -------------------------------------------------------------------
  //  SECTION 2 — Anatomy of a RawKeyEvent.
  // -------------------------------------------------------------------
  hr('SECTION 2 — RawKeyEvent anatomy');
  print('A RawKeyEvent has these conceptual fields:');
  bullet('character        — the printable text the keystroke produced');
  bullet('logicalKey       — what the user *meant* (e.g. LogicalKeyboardKey.keyA)');
  bullet('physicalKey      — which button on the keyboard chassis');
  bullet('data             — platform-specific RawKeyEventData subclass');
  bullet('repeat           — was this a key-repeat event?');
  bullet('data.isModifierPressed — query helper for any ModifierKey + side');
  bullet('runtimeType      — RawKeyDownEvent | RawKeyUpEvent');

  // Build a small "diagram" of the anchor event for the UI.
  final List<List<String>> anatomyRows = <List<String>>[
    <String>['character', '${anchorDown.character}'],
    <String>['logicalKey', anchorDown.logicalKey.keyLabel],
    <String>['logicalKey.id', '0x${anchorDown.logicalKey.keyId.toRadixString(16)}'],
    <String>['physicalKey', anchorDown.physicalKey.debugName ?? '<unknown>'],
    <String>['data', anchorDown.data.runtimeType.toString()],
    <String>['repeat', '${anchorDown.repeat}'],
    <String>['isControl', '${anchorDown.isControlPressed}'],
    <String>['isShift', '${anchorDown.isShiftPressed}'],
    <String>['isAlt', '${anchorDown.isAltPressed}'],
    <String>['isMeta', '${anchorDown.isMetaPressed}'],
  ];
  print('Anatomy rows assembled: ${anatomyRows.length}');

  // -------------------------------------------------------------------
  //  SECTION 3 — Gallery of six events.
  // -------------------------------------------------------------------
  hr('SECTION 3 — Gallery of six events');
  print('Six hand-built events covering letters, digits, modifier combos.');

  // 3.1  Plain 'b' down.
  final _RawKeyDownEvent ev1 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0x62,
      keyCode: 0x62,
      scanCode: 56,
      modifiers: 0,
      isDown: true,
    ),
    character: 'b',
  );

  // 3.2  Shift+C  (modifiers bit for shift in GLFW = 0x0001).
  final _RawKeyDownEvent ev2 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0x43,
      keyCode: 0x43,
      scanCode: 54,
      modifiers: 0x0001,
      isDown: true,
    ),
    character: 'C',
  );

  // 3.3  Digit '1'
  final _RawKeyDownEvent ev3 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0x31,
      keyCode: 0x31,
      scanCode: 10,
      modifiers: 0,
      isDown: true,
    ),
    character: '1',
  );

  // 3.4  Ctrl+S (control bit in GLFW = 0x0002).
  final _RawKeyDownEvent ev4 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0x73,
      keyCode: 0x73,
      scanCode: 39,
      modifiers: 0x0002,
      isDown: true,
    ),
    character: 's',
  );

  // 3.5  Alt+Tab (alt bit = 0x0004).
  final _RawKeyDownEvent ev5 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0,
      keyCode: 0xff09,
      scanCode: 23,
      modifiers: 0x0004,
      isDown: true,
    ),
    character: null,
  );

  // 3.6  Meta+Q (super/meta bit = 0x0008).
  final _RawKeyDownEvent ev6 = _RawKeyDownEvent(
    data: _RawKeyEventDataLinux(
      keyHelper: _GLFWKeyHelper(),
      unicodeScalarValues: 0x71,
      keyCode: 0x71,
      scanCode: 24,
      modifiers: 0x0008,
      isDown: true,
    ),
    character: 'q',
  );

  bullet('ev1 plain "b"     -> ${ev1.logicalKey.keyLabel} char=${ev1.character}');
  bullet('ev2 Shift+C       -> shift=${ev2.isShiftPressed} char=${ev2.character}');
  bullet('ev3 digit "1"     -> ${ev3.logicalKey.keyLabel} char=${ev3.character}');
  bullet('ev4 Ctrl+S        -> ctrl=${ev4.isControlPressed} char=${ev4.character}');
  bullet('ev5 Alt+Tab       -> alt=${ev5.isAltPressed} char=${ev5.character}');
  bullet('ev6 Meta+Q        -> meta=${ev6.isMetaPressed} char=${ev6.character}');

  final List<_RawKeyDownEvent> gallery = <_RawKeyDownEvent>[
    ev1, ev2, ev3, ev4, ev5, ev6,
  ];
  final List<String> galleryLabels = <String>[
    'B',
    '⇧C',
    '1',
    '⌃S',
    '⌥⇥',
    '⌘Q',
  ];

  print('Gallery size: ${gallery.length}');

  // -------------------------------------------------------------------
  //  SECTION 4 — Deprecation / migration card.
  // -------------------------------------------------------------------
  hr('SECTION 4 — Deprecation & migration');
  print('RawKeyEvent is deprecated.  The replacement is KeyEvent.');
  print('Side-by-side mapping shows field-for-field correspondence.');
  print('Listener replacement: RawKeyboardListener -> KeyboardListener.');
  print('Hub replacement:      RawKeyboard         -> HardwareKeyboard.');

  // Build a parallel KeyDownEvent so the comparison is concrete.
  const KeyDownEvent modernDown = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 100),
    character: 'a',
  );
  bullet('modern KeyDownEvent.physicalKey = ${modernDown.physicalKey.debugName}');
  bullet('modern KeyDownEvent.logicalKey  = ${modernDown.logicalKey.keyLabel}');
  bullet('modern KeyDownEvent.character   = ${modernDown.character}');
  bullet('modern KeyDownEvent.timeStamp   = ${modernDown.timeStamp}');

  // -------------------------------------------------------------------
  //  SECTION 5 — RawKeyEventData subclasses.
  // -------------------------------------------------------------------
  hr('SECTION 5 — RawKeyEventData subclasses');
  print('Each platform contributes its own RawKeyEventData subclass:');
  bullet('RawKeyEventDataAndroid  — keyCode/scanCode/metaState/flags');
  bullet('RawKeyEventDataIos      — characters/charactersIgnoringModifiers/modifiers');
  bullet('RawKeyEventDataLinux    — keyHelper (GTK or GLFW), keyCode, scanCode');
  bullet('RawKeyEventDataMacOs    — characters/charactersIgnoringModifiers/keyCode');
  bullet('RawKeyEventDataWeb      — code, key, location, metaState');
  bullet('RawKeyEventDataWindows  — keyCode, scanCode, characterCodePoint, modifiers');

  final List<List<String>> platformRows = <List<String>>[
    <String>['Platform', 'Subclass', 'Key fields'],
    <String>['Android', 'DataAndroid', 'keyCode, scanCode, metaState, flags'],
    <String>['iOS', 'DataIos', 'characters, charactersIgnoringMods, modifiers'],
    <String>['Linux', 'DataLinux', 'keyHelper, keyCode, scanCode, modifiers'],
    <String>['macOS', 'DataMacOs', 'characters, charactersIgnoringMods, keyCode'],
    <String>['Web', 'DataWeb', 'code, key, location, metaState'],
    <String>['Windows', 'DataWindows', 'keyCode, scanCode, characterCodePoint'],
    <String>['Fuchsia', 'DataFuchsia', 'hidUsage, codePoint, modifiers'],
  ];
  print('Platform table has ${platformRows.length} rows.');

  // -------------------------------------------------------------------
  //  SECTION 6 — Modifier handling.
  // -------------------------------------------------------------------
  hr('SECTION 6 — Modifier handling');
  print('RawKeyEvent inherits a getter family for portable modifier state:');
  bullet('isControlPressed');
  bullet('isShiftPressed');
  bullet('isAltPressed');
  bullet('isMetaPressed');
  bullet('data.isModifierPressed(ModifierKey, {KeyboardSide side = any})');
  bullet('Underlying flags live on data.modifiers (int bitmask).');

  // Demonstrate the parameterized API by querying ev2 (Shift+C).
  // isModifierPressed lives on RawKeyEventData (event.data), not on the
  // event itself.  The event-level getters (isShiftPressed, etc.) forward
  // to event.data.isModifierPressed under the hood.
  final bool ev2ShiftAny = ev2.data.isModifierPressed(
    _ModifierKey.shiftModifier,
    side: _KeyboardSide.any,
  );
  final bool ev4ControlAny = ev4.data.isModifierPressed(
    _ModifierKey.controlModifier,
    side: _KeyboardSide.any,
  );
  final bool ev5AltAny = ev5.data.isModifierPressed(
    _ModifierKey.altModifier,
    side: _KeyboardSide.any,
  );
  final bool ev6MetaAny = ev6.data.isModifierPressed(
    _ModifierKey.metaModifier,
    side: _KeyboardSide.any,
  );
  bullet('ev2 isModifierPressed(shift,   any) = $ev2ShiftAny');
  bullet('ev4 isModifierPressed(control, any) = $ev4ControlAny');
  bullet('ev5 isModifierPressed(alt,     any) = $ev5AltAny');
  bullet('ev6 isModifierPressed(meta,    any) = $ev6MetaAny');

  // -------------------------------------------------------------------
  //  SECTION 7 — keyDown vs keyUp lifecycle.
  // -------------------------------------------------------------------
  hr('SECTION 7 — keyDown / keyUp lifecycle');
  print('A user pressing and releasing "a" generates two RawKeyEvents:');
  bullet('1. RawKeyDownEvent  (data.isDown = true)');
  bullet('2. RawKeyUpEvent    (data.isDown = false)');
  bullet('repeat=true is set on intervening down events while held.');
  bullet('Listeners that count presses must NOT count repeats as new presses.');
  bullet('Modern KeyEvent splits this into KeyDownEvent + KeyRepeatEvent + KeyUpEvent.');

  // -------------------------------------------------------------------
  //  SECTION 8 — Where you still meet RawKeyEvent in the wild.
  // -------------------------------------------------------------------
  hr('SECTION 8 — Where RawKeyEvent still appears');
  print('Reasons you might still encounter RawKeyEvent today:');
  bullet('Older plugins that subclass RawKeyboardListener.');
  bullet('Tutorials and StackOverflow answers from pre-3.x Flutter.');
  bullet('Code paths that read RawKeyboard.instance.keysPressed.');
  bullet('Embedders that have not yet wired KeyData.');
  bullet('Tests that assert on legacy RawKeyEvent shapes.');

  // -------------------------------------------------------------------
  //  SECTION 9 — Cheat-sheet of migration steps.
  // -------------------------------------------------------------------
  hr('SECTION 9 — Migration cheat-sheet');
  print('A practical six-step migration plan:');
  bullet('1. Replace RawKeyboardListener with KeyboardListener.');
  bullet('2. Replace onKey: (RawKeyEvent e) -> onKeyEvent: (KeyEvent e).');
  bullet('3. Switch is RawKeyDownEvent -> is KeyDownEvent.');
  bullet('4. Replace RawKeyboard.instance.keysPressed -> '
      'HardwareKeyboard.instance.logicalKeysPressed.');
  bullet('5. Replace addListener -> HardwareKeyboard.instance.addHandler.');
  bullet('6. Drop platform-specific reads of event.data; use logicalKey instead.');

  // -------------------------------------------------------------------
  //  Final summary line.
  // -------------------------------------------------------------------
  print('');
  print('RawKeyEvent deep-demo build() complete.');
  print('Total gallery events: ${gallery.length}');
  print('Total platform subclasses listed: ${platformRows.length - 1}');

  // ===================================================================
  //  UI — single root widget.
  // ===================================================================

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #97, P2)
  // The page-root Column packs the SECTION 0–9 cards top-to-bottom and
  // exceeds the available viewport height by ~2378 px, producing
  // "A RenderFlex overflowed by 2378 pixels on the bottom". Wrapping
  // the Column in a SingleChildScrollView absorbs the overflow without
  // changing the visual composition — the page becomes scrollable.
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kPlaten, kInkBlack, kTypebar],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------------------------------
        //  SECTION 1 — Title banner.
        // -----------------------------------------------------------
        vintageHeader(
          'RawKeyEvent — Deep Demo',
          'Legacy keyboard API · vintage-typewriter theme',
        ),
        const SizedBox(height: 12),

        // -----------------------------------------------------------
        //  SECTION 0 — Anchor event card.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 0  ·  Anchor RawKeyDownEvent (Linux)',
          stripColor: kRibbonRedDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  keyCap('a', width: 56, height: 56),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelValue('runtimeType',
                            anchorDown.runtimeType.toString()),
                        labelValue('character', '${anchorDown.character}'),
                        labelValue('logicalKey',
                            anchorDown.logicalKey.keyLabel),
                        labelValue('physicalKey',
                            anchorDown.physicalKey.debugName ?? '?'),
                        labelValue('data',
                            anchorDown.data.runtimeType.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kInkBlack,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  'character="${anchorDown.character}"  '
                  'logical=0x${anchorDown.logicalKey.keyId.toRadixString(16)}  '
                  'shift=${anchorDown.isShiftPressed}  '
                  'ctrl=${anchorDown.isControlPressed}  '
                  'alt=${anchorDown.isAltPressed}  '
                  'meta=${anchorDown.isMetaPressed}',
                  style: const TextStyle(
                    color: kHighlight,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 2 — Anatomy diagram.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 2  ·  Anatomy of a RawKeyEvent',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < anatomyRows.length; i++)
                labelValue(anatomyRows[i][0], anatomyRows[i][1]),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [kAged, kPaperTan, kPaperCream],
                        center: Alignment.center,
                        radius: 0.9,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kBrassDark),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    top: 10,
                    child: Text(
                      'character',
                      style: TextStyle(
                        color: kRibbonRedDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    top: 10,
                    child: Text(
                      'logicalKey',
                      style: TextStyle(
                        color: kInkBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      'physicalKey',
                      style: TextStyle(
                        color: kBrassDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    bottom: 10,
                    child: Text(
                      'modifiers',
                      style: TextStyle(
                        color: kKeyCapGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 70,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kInkBlack, kKeyCapGray],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Text(
                            'RawKey',
                            style: TextStyle(
                              color: kHighlight,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 3 — Gallery of six events.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 3  ·  Gallery (6 events)',
          stripColor: kBrassDark,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < gallery.length; i++)
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [kPaperCream, kPaperTan],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x44000000),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                        border: Border.all(color: kBrassDark, width: 0.7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              keyCap(
                                galleryLabels[i],
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  gallery[i].logicalKey.keyLabel,
                                  style: const TextStyle(
                                    color: kInkBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'char=${gallery[i].character ?? '∅'}',
                            style: const TextStyle(
                              color: kInkSoft,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'shift=${gallery[i].isShiftPressed}',
                            style: const TextStyle(
                              color: kInkSoft,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'ctrl=${gallery[i].isControlPressed}',
                            style: const TextStyle(
                              color: kInkSoft,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'alt=${gallery[i].isAltPressed}',
                            style: const TextStyle(
                              color: kInkSoft,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'meta=${gallery[i].isMetaPressed}',
                            style: const TextStyle(
                              color: kInkSoft,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 4 — Deprecation / migration card.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 4  ·  DEPRECATED — migrate to KeyEvent',
          stripColor: kRibbonRed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kRibbonRedDark, kRibbonRed],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber, color: kHighlight, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'RawKeyEvent is deprecated. Use KeyEvent / '
                        'HardwareKeyboard / KeyboardListener instead.',
                        style: TextStyle(
                          color: kPaperCream,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              migrationRow(
                'RawKeyEvent',
                'KeyEvent',
                'abstract base class',
              ),
              migrationRow(
                'RawKeyDownEvent',
                'KeyDownEvent',
                'press lifecycle start',
              ),
              migrationRow(
                'RawKeyUpEvent',
                'KeyUpEvent',
                'press lifecycle end',
              ),
              migrationRow(
                'event.repeat',
                'KeyRepeatEvent',
                'repeats are now their own type',
              ),
              migrationRow(
                'RawKeyboard.instance',
                'HardwareKeyboard.instance',
                'authoritative state hub',
              ),
              migrationRow(
                'RawKeyboardListener',
                'KeyboardListener',
                'widget for global key handling',
              ),
              migrationRow(
                'event.data.modifiers',
                'event.logicalKey + state',
                'avoid platform-specific bitmasks',
              ),
              migrationRow(
                'isControlPressed',
                'HardwareKeyboard.isControlPressed',
                'query the global state',
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 5 — RawKeyEventData subclasses overview.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 5  ·  RawKeyEventData subclass family',
          stripColor: kKeyCapGray,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < platformRows.length; i++)
                      tableRow(platformRows[i], header: i == 0),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Note: portable code should not switch on these subclasses. '
                'Read logicalKey / physicalKey instead.',
                style: TextStyle(
                  color: kInkSoft,
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 6 — Modifier key handling.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 6  ·  Modifier-key handling',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Convenience getters on RawKeyEvent:',
                style: TextStyle(
                  color: kInkBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  keyCap('Shift', width: 70, height: 36),
                  keyCap('Ctrl', width: 60, height: 36),
                  keyCap('Alt', width: 56, height: 36),
                  keyCap('Meta', width: 64, height: 36),
                  keyCap('Fn', width: 50, height: 36),
                  keyCap('CapsLk', width: 76, height: 36),
                ],
              ),
              const SizedBox(height: 10),
              labelValue('ev2 Shift+C',
                  'isShiftPressed=${ev2.isShiftPressed}  any=$ev2ShiftAny'),
              labelValue('ev4 Ctrl+S',
                  'isControlPressed=${ev4.isControlPressed}  any=$ev4ControlAny'),
              labelValue('ev5 Alt+Tab',
                  'isAltPressed=${ev5.isAltPressed}  any=$ev5AltAny'),
              labelValue('ev6 Meta+Q',
                  'isMetaPressed=${ev6.isMetaPressed}  any=$ev6MetaAny'),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kPaperTan, kAged],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'event.data.isModifierPressed(ModifierKey.shiftModifier, '
                  'side: KeyboardSide.left) — query exact side.',
                  style: TextStyle(
                    color: kInkBlack,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 7 — keyDown / keyUp lifecycle.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 7  ·  keyDown vs keyUp',
          stripColor: kBrass,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kPaperCream, kHighlight],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kBrassDark),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RawKeyDownEvent',
                        style: TextStyle(
                          color: kRibbonRedDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'data.isDown = true\n'
                        'character may be present\n'
                        'repeat=${anchorDown.repeat}',
                        style: const TextStyle(
                          color: kInkBlack,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kPaperCream, kAged],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kBrassDark),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RawKeyUpEvent',
                        style: TextStyle(
                          color: kInkBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'data.isDown = false\n'
                        'character usually null\n'
                        'pair: ${anchorUp.runtimeType}',
                        style: const TextStyle(
                          color: kInkBlack,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 8 — Where you still see RawKeyEvent.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 8  ·  Where RawKeyEvent still appears',
          stripColor: kKeyCapGray,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '• Old plugins subclassing RawKeyboardListener.',
                style: TextStyle(color: kInkBlack, fontSize: 11),
              ),
              SizedBox(height: 2),
              Text(
                '• Tutorials and SO answers from pre-Flutter-3.x.',
                style: TextStyle(color: kInkBlack, fontSize: 11),
              ),
              SizedBox(height: 2),
              Text(
                '• Code reading RawKeyboard.instance.keysPressed.',
                style: TextStyle(color: kInkBlack, fontSize: 11),
              ),
              SizedBox(height: 2),
              Text(
                '• Embedders that have not wired KeyData yet.',
                style: TextStyle(color: kInkBlack, fontSize: 11),
              ),
              SizedBox(height: 2),
              Text(
                '• Tests asserting on legacy RawKeyEvent shapes.',
                style: TextStyle(color: kInkBlack, fontSize: 11),
              ),
            ],
          ),
        ),

        // -----------------------------------------------------------
        //  SECTION 9 — Migration cheat-sheet.
        // -----------------------------------------------------------
        paperPanel(
          heading: 'SECTION 9  ·  Migration cheat-sheet',
          stripColor: kRibbonRedDark,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 6; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kPaperCream, kPaperTan],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kBrassDark, width: 0.7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [kBrass, kBrassDark],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x55000000),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: kPaperCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          <String>[
                            'Replace RawKeyboardListener with KeyboardListener.',
                            'Switch onKey: (RawKeyEvent) to onKeyEvent: (KeyEvent).',
                            'Pattern-match KeyDownEvent / KeyUpEvent / KeyRepeatEvent.',
                            'Read HardwareKeyboard.instance.logicalKeysPressed.',
                            'Use HardwareKeyboard.instance.addHandler for global hooks.',
                            'Drop platform reads of event.data; use logicalKey.',
                          ][i],
                          style: const TextStyle(
                            color: kInkBlack,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kInkBlack,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Text(
                  '// Modern equivalent\n'
                  'KeyboardListener(\n'
                  '  focusNode: FocusNode(),\n'
                  '  onKeyEvent: (KeyEvent e) {\n'
                  '    if (e is KeyDownEvent) print(e.logicalKey);\n'
                  '  },\n'
                  '  child: child,\n'
                  ');',
                  style: TextStyle(
                    color: kHighlight,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kBrassDark, kBrass, kBrassDark],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x88000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: const Text(
            'End of RawKeyEvent deep demo · '
            'remember: prefer KeyEvent for new code.',
            style: TextStyle(
              color: kInkBlack,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    ),
  );
}
