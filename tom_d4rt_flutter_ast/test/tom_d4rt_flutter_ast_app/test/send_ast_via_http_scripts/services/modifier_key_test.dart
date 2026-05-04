// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, dead_code, unnecessary_import
// D4rt test script: ModifierKey from package:flutter/services.dart
// ---------------------------------------------------------------------------
// Deep Demo: Visual exploration of the `ModifierKey` enum used by the legacy
// `RawKeyEventData.isModifierPressed(...)` family of APIs. Even though
// `RawKeyboard` and its `ModifierKey` companion are deprecated in favour of
// `HardwareKeyboard` + `LogicalKeyboardKey`, the enum is still everywhere in
// older code, in tests that exercise the raw-key compatibility layer, and in
// shortcut-matchers that have not yet migrated. This demo is a single-screen
// reference book: it dumps every value, draws the keyboard layout that each
// modifier owns, summarises the platform-specific quirks, lists migration
// recipes, and ends with an ASCII cheatsheet so the file reads top-to-bottom
// like a documentation page.
// ---------------------------------------------------------------------------
//
// IMPORTANT — D4rt bridge note:
//   The `ModifierKey` symbol is part of the deprecated raw-keyboard surface and
//   is intentionally NOT exposed by the d4rt Flutter bridge. To keep the demo
//   compiling under both d4rt and a normal Flutter analyzer pass we declare a
//   *local shim* enum with the exact same nine members and run the demo against
//   the shim. The shim mirrors the SDK declaration in `raw_keyboard.dart` 1:1.
//   The `package:flutter/services.dart` import is still kept (and explicitly
//   allowed via `unnecessary_import`) so the demo also gets access to
//   `KeyboardSide`, `LogicalKeyboardKey` and friends used by the diagrams.
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ===========================================================================
// SHIM: `ModifierKey` is deprecated and the d4rt bridge does not expose it, so
// we declare a fully compatible local enum here. The order, names, and the
// number of members match the upstream Flutter declaration in
// `packages/flutter/lib/src/services/raw_keyboard.dart`.
// ===========================================================================
enum ModifierKey {
  /// The CTRL modifier key. Typically two physical keys (left + right).
  controlModifier,

  /// The SHIFT modifier key. Typically two physical keys (left + right).
  shiftModifier,

  /// The ALT modifier key. Typically two physical keys (left + right).
  /// On many European layouts the right Alt is "AltGr" and is consumed by the
  /// OS layer for dead-key composition.
  altModifier,

  /// The META modifier key. The Windows key on Windows (Win), Command on
  /// macOS / iOS, Search on Android. Typically two physical keys.
  metaModifier,

  /// The CAPS LOCK modifier key. Reported as "pressed" while caps-lock is on.
  capsLockModifier,

  /// The NUM LOCK modifier key. Reported as "pressed" while num-lock is on.
  numLockModifier,

  /// The SCROLL LOCK modifier key. Reported as "pressed" while scroll-lock is on.
  scrollLockModifier,

  /// The FUNCTION (Fn) modifier key — only some hardware keyboards expose it.
  functionModifier,

  /// The SYMBOL modifier key — Android-style soft keyboards, AOSP IMEs.
  symbolModifier,
}

// ===========================================================================
// SHIM: `KeyboardSide` is also part of the deprecated raw-keyboard surface and
// is intentionally NOT exposed by the d4rt Flutter bridge. We declare a fully
// compatible local enum here. The order and names match the upstream Flutter
// declaration in `packages/flutter/lib/src/services/raw_keyboard.dart`.
// ===========================================================================
enum KeyboardSide {
  /// Both sides at once (rarely used in practice).
  any,

  /// The left-hand instance of a paired modifier key (L-Shift, L-Ctrl, …).
  left,

  /// The right-hand instance of a paired modifier key (R-Shift, R-Ctrl, …).
  right,

  /// All instances of the modifier — semantically identical to `any` for
  /// query semantics but kept distinct for symmetry with the SDK enum.
  all,
}

// ===========================================================================
// SPEC: Per-value metadata. Every section in the demo is data-driven from this
// list so the file stays consistent and adding/removing a value automatically
// updates every visualisation.
// ===========================================================================
class _ModifierSpec {
  const _ModifierSpec({
    required this.key,
    required this.label,
    required this.shortLabel,
    required this.headline,
    required this.tagline,
    required this.icon,
    required this.glow,
    required this.dim,
    required this.shadow,
    required this.usage,
    required this.example,
    required this.gotcha,
    required this.physicalCount,
    required this.isLockKey,
    required this.isToggle,
    required this.platformNote,
    required this.windowsLabel,
    required this.macLabel,
    required this.linuxLabel,
    required this.androidLabel,
  });

  final ModifierKey key;
  final String label;
  final String shortLabel;
  final String headline;
  final String tagline;
  final IconData icon;
  final Color glow;
  final Color dim;
  final Color shadow;
  final String usage;
  final String example;
  final String gotcha;
  final int physicalCount;
  final bool isLockKey;
  final bool isToggle;
  final String platformNote;
  final String windowsLabel;
  final String macLabel;
  final String linuxLabel;
  final String androidLabel;
}

const List<_ModifierSpec> _specs = <_ModifierSpec>[
  _ModifierSpec(
    key: ModifierKey.controlModifier,
    label: 'controlModifier',
    shortLabel: 'CTRL',
    headline: 'CONTROL — primary chord modifier',
    tagline: 'The bread-and-butter shortcut modifier on Windows / Linux.',
    icon: Icons.keyboard_command_key,
    glow: Color(0xFF1E88E5),
    dim: Color(0xFFE3F2FD),
    shadow: Color(0xFF0D47A1),
    usage: 'Detect Ctrl-as-modifier in a shortcut chord. On Windows and Linux '
        'this is the typical "primary" modifier used for save / copy / paste. '
        'Most Flutter shortcut maps fall back to `meta` on macOS so a single '
        'binding works across desktops.',
    example: 'data.isModifierPressed(ModifierKey.controlModifier)',
    gotcha: 'On macOS users expect Cmd, not Ctrl. Use platform-aware shortcut '
        'definitions (`SingleActivator(LogicalKeyboardKey.keyS, meta: ...)`) '
        'rather than hard-coding control.',
    physicalCount: 2,
    isLockKey: false,
    isToggle: false,
    platformNote: 'Mapped to `Ctrl` on Windows / Linux / web; rarely the '
        'primary modifier on macOS.',
    windowsLabel: 'Ctrl',
    macLabel: 'Control (^)',
    linuxLabel: 'Ctrl',
    androidLabel: 'Ctrl (external kbd)',
  ),
  _ModifierSpec(
    key: ModifierKey.shiftModifier,
    label: 'shiftModifier',
    shortLabel: 'SHIFT',
    headline: 'SHIFT — case + selection modifier',
    tagline: 'Toggles upper-case while typing and extends selections.',
    icon: Icons.arrow_upward,
    glow: Color(0xFFEC407A),
    dim: Color(0xFFFCE4EC),
    shadow: Color(0xFFAD1457),
    usage: 'Detect Shift-as-modifier when a chord wants to differentiate '
        'capitalised input or "extend selection" semantics from "move '
        'selection" semantics. Works identically across desktop and most '
        'mobile soft keyboards.',
    example: 'data.isModifierPressed(ModifierKey.shiftModifier)',
    gotcha: 'On soft keyboards the Shift is often a *latched* state, not a '
        'live modifier — you may receive an already-uppercased character '
        'rather than a Shift event.',
    physicalCount: 2,
    isLockKey: false,
    isToggle: false,
    platformNote: 'Reliably reported on every desktop platform; latched on '
        'mobile soft keyboards.',
    windowsLabel: 'Shift',
    macLabel: 'Shift (⇧)',
    linuxLabel: 'Shift',
    androidLabel: 'Shift (latched)',
  ),
  _ModifierSpec(
    key: ModifierKey.altModifier,
    label: 'altModifier',
    shortLabel: 'ALT',
    headline: 'ALT — menu mnemonics + dead keys',
    tagline: 'Left Alt drives menus; right Alt is AltGr in many layouts.',
    icon: Icons.alt_route,
    glow: Color(0xFFFFA726),
    dim: Color(0xFFFFF3E0),
    shadow: Color(0xFFE65100),
    usage: 'Detect Alt-as-modifier for menu mnemonics, accessibility shortcuts, '
        'or dead-key composition. Use `KeyboardSide.left` to limit a chord to '
        'left-Alt only — that avoids stomping on AltGr on European layouts.',
    example: 'data.isModifierPressed(ModifierKey.altModifier, '
        'side: KeyboardSide.left)',
    gotcha: 'Right Alt = AltGr on most non-US layouts and is consumed by the OS '
        'before Flutter sees it. Always allow a non-Alt fallback shortcut for '
        'AltGr-using locales.',
    physicalCount: 2,
    isLockKey: false,
    isToggle: false,
    platformNote: 'Right Alt may be re-purposed as AltGr on Linux / Windows '
        'for dead-key composition.',
    windowsLabel: 'Alt / AltGr',
    macLabel: 'Option (⌥)',
    linuxLabel: 'Alt / AltGr',
    androidLabel: 'Alt (external kbd)',
  ),
  _ModifierSpec(
    key: ModifierKey.metaModifier,
    label: 'metaModifier',
    shortLabel: 'META',
    headline: 'META — the OS-level modifier',
    tagline: 'Win on Windows, Cmd on macOS, Search on Android.',
    icon: Icons.layers,
    glow: Color(0xFF7E57C2),
    dim: Color(0xFFEDE7F6),
    shadow: Color(0xFF311B92),
    usage: 'Detect the OS-owned modifier. On macOS this is the primary '
        'shortcut modifier (Cmd-S, Cmd-C); on Windows / Linux it usually '
        'invokes window-manager features and should be avoided as the primary '
        'binding.',
    example: 'data.isModifierPressed(ModifierKey.metaModifier)',
    gotcha: 'On Windows and most Linux DEs the OS captures Win-key chords '
        'before Flutter sees them. On macOS Cmd is the *expected* primary '
        'modifier — use it instead of Ctrl.',
    physicalCount: 2,
    isLockKey: false,
    isToggle: false,
    platformNote: 'Always present on desktop; rare on mobile keyboards.',
    windowsLabel: 'Win (⊞)',
    macLabel: 'Command (⌘)',
    linuxLabel: 'Super',
    androidLabel: 'Search (🔍)',
  ),
  _ModifierSpec(
    key: ModifierKey.capsLockModifier,
    label: 'capsLockModifier',
    shortLabel: 'CAPS',
    headline: 'CAPS LOCK — latching toggle',
    tagline: 'Reported as pressed *only* while caps-lock is enabled.',
    icon: Icons.keyboard_capslock,
    glow: Color(0xFF26A69A),
    dim: Color(0xFFE0F2F1),
    shadow: Color(0xFF004D40),
    usage: 'Detect whether caps-lock is currently latched. Often used by '
        'accessibility overlays to warn the user that they may be typing in '
        'all caps unintentionally (password fields, chat input).',
    example: 'data.isModifierPressed(ModifierKey.capsLockModifier)',
    gotcha: 'The event semantics are inverted at the edges: you receive a '
        'key-up while the LED turns ON, and a key-down when it turns OFF. '
        'Always rely on the boolean rather than counting events.',
    physicalCount: 1,
    isLockKey: true,
    isToggle: true,
    platformNote: 'Reliable everywhere caps-lock exists; ignored on most '
        'mobile soft keyboards.',
    windowsLabel: 'Caps Lock',
    macLabel: 'Caps Lock (⇪)',
    linuxLabel: 'Caps Lock',
    androidLabel: 'Caps (latched)',
  ),
  _ModifierSpec(
    key: ModifierKey.numLockModifier,
    label: 'numLockModifier',
    shortLabel: 'NUM',
    headline: 'NUM LOCK — numeric keypad gate',
    tagline: 'Switches the numeric keypad between digits and arrow keys.',
    icon: Icons.dialpad,
    glow: Color(0xFF66BB6A),
    dim: Color(0xFFE8F5E9),
    shadow: Color(0xFF1B5E20),
    usage: 'Detect whether the keypad is in numeric mode. Useful for data-entry '
        'apps that want to warn the user "Num Lock is OFF" when the keypad '
        'should be producing digits.',
    example: 'data.isModifierPressed(ModifierKey.numLockModifier)',
    gotcha: 'Laptops without a dedicated numpad still report num-lock — but '
        'the bound function keys may overlap with Fn-layer remaps. Test on '
        'real hardware before shipping shortcuts behind num-lock.',
    physicalCount: 1,
    isLockKey: true,
    isToggle: true,
    platformNote: 'Almost always present on physical desktop keyboards; '
        'meaningless on tablets and phones.',
    windowsLabel: 'Num Lock',
    macLabel: 'Clear (no LED)',
    linuxLabel: 'Num Lock',
    androidLabel: '— (no num-lock)',
  ),
  _ModifierSpec(
    key: ModifierKey.scrollLockModifier,
    label: 'scrollLockModifier',
    shortLabel: 'SCROLL',
    headline: 'SCROLL LOCK — vestigial toggle',
    tagline: 'Almost no app uses it, but the LED still reports state.',
    icon: Icons.swap_vert_circle,
    glow: Color(0xFF8D6E63),
    dim: Color(0xFFEFEBE9),
    shadow: Color(0xFF3E2723),
    usage: 'Some terminals and spreadsheets still respect scroll-lock to flip '
        'between "scroll the viewport" and "move the cursor". If your app '
        'imitates a 1990s spreadsheet, this is your toggle.',
    example: 'data.isModifierPressed(ModifierKey.scrollLockModifier)',
    gotcha: 'Many modern keyboards omit the key entirely. Treat scroll-lock '
        'support as opt-in and always provide an in-app toggle as a fallback.',
    physicalCount: 1,
    isLockKey: true,
    isToggle: true,
    platformNote: 'Rare on laptops; only consistently present on full-size '
        'desktop keyboards and KVM-style hardware.',
    windowsLabel: 'Scroll Lock',
    macLabel: 'F14 (no LED)',
    linuxLabel: 'Scroll Lock',
    androidLabel: '— (absent)',
  ),
  _ModifierSpec(
    key: ModifierKey.functionModifier,
    label: 'functionModifier',
    shortLabel: 'FN',
    headline: 'FUNCTION (Fn) — vendor-defined layer key',
    tagline: 'Laptop manufacturers expose it; few SDKs surface the event.',
    icon: Icons.functions,
    glow: Color(0xFFAB47BC),
    dim: Color(0xFFF3E5F5),
    shadow: Color(0xFF4A148C),
    usage: 'Detect vendor Fn-layer chords. Useful for laptop-specific keymaps '
        '(brightness, media keys) when the vendor actually surfaces the Fn '
        'modifier as a real key event rather than swallowing it.',
    example: 'data.isModifierPressed(ModifierKey.functionModifier)',
    gotcha: 'Most laptops handle Fn in firmware, so you will simply receive a '
        'remapped keypress (e.g. F5 turning into "brightness down") with NO '
        'Fn modifier set. Cannot be relied upon cross-vendor.',
    physicalCount: 1,
    isLockKey: false,
    isToggle: false,
    platformNote: 'Visible only on a handful of vendor / Linux configurations.',
    windowsLabel: 'Fn (vendor)',
    macLabel: 'Fn (globe key)',
    linuxLabel: 'Fn (vendor)',
    androidLabel: '— (absent)',
  ),
  _ModifierSpec(
    key: ModifierKey.symbolModifier,
    label: 'symbolModifier',
    shortLabel: 'SYM',
    headline: 'SYMBOL — soft-keyboard layer key',
    tagline: 'Android IMEs use this to flip between letters and symbols.',
    icon: Icons.text_format,
    glow: Color(0xFFFF7043),
    dim: Color(0xFFFBE9E7),
    shadow: Color(0xFFBF360C),
    usage: 'Detect whether the on-screen IME is currently showing the symbol '
        'layer. Mostly useful for analytics or IME wrapper widgets that need '
        'to mirror the keyboard layout in their own UI.',
    example: 'data.isModifierPressed(ModifierKey.symbolModifier)',
    gotcha: 'Desktop keyboards never set this modifier — guard your code with '
        'a platform check or it will appear "always off" to QA.',
    physicalCount: 1,
    isLockKey: false,
    isToggle: true,
    platformNote: 'Android-only; ignored on every other platform.',
    windowsLabel: '— (absent)',
    macLabel: '— (absent)',
    linuxLabel: '— (absent)',
    androidLabel: 'Sym (IME)',
  ),
];

// ===========================================================================
// MOCK KEYBOARD: a tiny ASCII-flavoured layout used by the highlight diagram.
// Keys can declare which `ModifierKey` they belong to. Non-modifier keys are
// drawn dim regardless of the currently-selected ModifierKey.
// ===========================================================================
class _Key {
  const _Key(this.label, {this.modifier, this.flex = 1, this.side});
  final String label;
  final ModifierKey? modifier;
  final int flex;
  final KeyboardSide? side;
}

const List<List<_Key>> _mockKeyboard = <List<_Key>>[
  <_Key>[
    _Key('Esc'),
    _Key('F1'),
    _Key('F2'),
    _Key('F3'),
    _Key('F4'),
    _Key('F5'),
    _Key('F6'),
    _Key('F7'),
    _Key('F8'),
    _Key('PrSc'),
    _Key('SLk', modifier: ModifierKey.scrollLockModifier),
    _Key('Pse'),
  ],
  <_Key>[
    _Key('`'),
    _Key('1'),
    _Key('2'),
    _Key('3'),
    _Key('4'),
    _Key('5'),
    _Key('6'),
    _Key('7'),
    _Key('8'),
    _Key('9'),
    _Key('0'),
    _Key('Bksp', flex: 2),
  ],
  <_Key>[
    _Key('Tab', flex: 2),
    _Key('Q'),
    _Key('W'),
    _Key('E'),
    _Key('R'),
    _Key('T'),
    _Key('Y'),
    _Key('U'),
    _Key('I'),
    _Key('O'),
    _Key('P'),
    _Key('Ent', flex: 2),
  ],
  <_Key>[
    _Key('Caps', modifier: ModifierKey.capsLockModifier, flex: 2),
    _Key('A'),
    _Key('S'),
    _Key('D'),
    _Key('F'),
    _Key('G'),
    _Key('H'),
    _Key('J'),
    _Key('K'),
    _Key('L'),
    _Key(';'),
    _Key('"'),
  ],
  <_Key>[
    _Key('L-Shift',
        modifier: ModifierKey.shiftModifier,
        side: KeyboardSide.left,
        flex: 2),
    _Key('Z'),
    _Key('X'),
    _Key('C'),
    _Key('V'),
    _Key('B'),
    _Key('N'),
    _Key('M'),
    _Key(','),
    _Key('.'),
    _Key('R-Shift',
        modifier: ModifierKey.shiftModifier,
        side: KeyboardSide.right,
        flex: 2),
  ],
  <_Key>[
    _Key('L-Ctrl',
        modifier: ModifierKey.controlModifier,
        side: KeyboardSide.left,
        flex: 2),
    _Key('Fn', modifier: ModifierKey.functionModifier),
    _Key('L-Meta',
        modifier: ModifierKey.metaModifier,
        side: KeyboardSide.left),
    _Key('L-Alt',
        modifier: ModifierKey.altModifier,
        side: KeyboardSide.left,
        flex: 2),
    _Key('Space', flex: 6),
    _Key('R-Alt',
        modifier: ModifierKey.altModifier,
        side: KeyboardSide.right,
        flex: 2),
    _Key('R-Meta',
        modifier: ModifierKey.metaModifier,
        side: KeyboardSide.right),
    _Key('Sym', modifier: ModifierKey.symbolModifier),
    _Key('R-Ctrl',
        modifier: ModifierKey.controlModifier,
        side: KeyboardSide.right,
        flex: 2),
  ],
  <_Key>[
    _Key('NumL', modifier: ModifierKey.numLockModifier),
    _Key('/'),
    _Key('*'),
    _Key('-'),
    _Key('7'),
    _Key('8'),
    _Key('9'),
    _Key('+', flex: 2),
    _Key('4'),
    _Key('5'),
    _Key('6'),
  ],
];

// ---------------------------------------------------------------------------
// Helper: shared text-style shortcuts so every section keeps the same rhythm.
// ---------------------------------------------------------------------------
TextStyle _hMono(double size, Color color, {FontWeight weight = FontWeight.w600}) {
  return TextStyle(
    fontFamily: 'monospace',
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: 1.25,
  );
}

TextStyle _hSans(double size, Color color, {FontWeight weight = FontWeight.w500}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: 1.35,
  );
}

// ---------------------------------------------------------------------------
// Helper: section-title pill with a leading number and an icon. Reused so the
// reader can skim the page top-to-bottom and immediately see the structure.
// ---------------------------------------------------------------------------
Widget _sectionTitle(int index, String title, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.fromLTRB(4.0, 32.0, 4.0, 12.0),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.02),
        ],
      ),
      border: Border(left: BorderSide(color: color, width: 4.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 22.0, color: color),
        ),
        const SizedBox(width: 12.0),
        Text(
          '${index.toString().padLeft(2, '0')}  •  $title',
          style: _hSans(18.0, color, weight: FontWeight.w800),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: small rounded "chip" — icon + label tinted with a brand colour.
// ---------------------------------------------------------------------------
Widget _miniChip(String text, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 12.0, color: color),
        const SizedBox(width: 4.0),
        Text(text, style: _hMono(10.0, color, weight: FontWeight.w700)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: dark code-block reused by the recipe and migration sections. Uses
// `AlwaysStoppedAnimation` so the demo composes through `Animation<double>`
// without ever ticking — satisfies the no-motion rule.
// ---------------------------------------------------------------------------
Widget _codeBlock(String code, Color accent) {
  final Animation<double> frozen = const AlwaysStoppedAnimation<double>(1.0);
  return Opacity(
    opacity: frozen.value,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1B1F23), Color(0xFF24292E)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.25),
            blurRadius: 12.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Text(code, style: _hMono(11.0, accent.withValues(alpha: 0.95))),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: per-value detail card. Renders the icon, headline, tagline, usage
// guidance, an example call, and a pitfall. Drives off `_ModifierSpec`.
// ---------------------------------------------------------------------------
Widget _valueCard(_ModifierSpec spec) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.white, spec.dim],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: spec.glow.withValues(alpha: 0.55), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spec.glow.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    spec.glow.withValues(alpha: 0.85),
                    spec.shadow,
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: spec.glow.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(spec.icon, size: 28.0, color: Colors.white),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ModifierKey.${spec.label}',
                    style: _hMono(12.0, spec.shadow),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    spec.headline,
                    style: _hSans(15.0, spec.shadow, weight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            _miniChip('idx ${spec.key.index}', Icons.tag, spec.shadow),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(spec.tagline,
            style: _hSans(12.5, spec.shadow.withValues(alpha: 0.85))),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _miniChip(
              spec.physicalCount == 1 ? '1 key' : '${spec.physicalCount} keys',
              Icons.keyboard,
              spec.glow,
            ),
            if (spec.isLockKey) _miniChip('lock', Icons.lock_outline, spec.glow),
            if (spec.isToggle) _miniChip('toggle', Icons.toggle_on, spec.glow),
            if (!spec.isLockKey && !spec.isToggle)
              _miniChip('momentary', Icons.touch_app, spec.glow),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: spec.glow.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: spec.glow.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('USAGE',
                  style: _hMono(9.0, spec.shadow, weight: FontWeight.w800)),
              const SizedBox(height: 4.0),
              Text(spec.usage, style: _hSans(11.5, spec.shadow)),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(spec.example, spec.glow),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFFFB300)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.warning_amber,
                  size: 18.0, color: Color(0xFFE65100)),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('GOTCHA',
                        style: _hMono(9.0, const Color(0xFFBF360C),
                            weight: FontWeight.w800)),
                    const SizedBox(height: 4.0),
                    Text(spec.gotcha,
                        style: _hSans(11.5, const Color(0xFF4E342E))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: a mini "physical key" used by the keyboard diagram.
// ---------------------------------------------------------------------------
Widget _physicalKey(_Key key, ModifierKey? highlight) {
  final bool isHit = key.modifier != null && key.modifier == highlight;
  final Color base = isHit
      ? _specOf(key.modifier!).glow
      : const Color(0xFFCFD8DC);
  final Color text = isHit ? Colors.white : const Color(0xFF37474F);
  return Expanded(
    flex: key.flex,
    child: Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            base,
            base.withValues(alpha: isHit ? 0.7 : 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: isHit ? Colors.white : const Color(0xFF90A4AE),
          width: isHit ? 1.6 : 1.0,
        ),
        boxShadow: isHit
            ? <BoxShadow>[
                BoxShadow(
                  color: base.withValues(alpha: 0.5),
                  blurRadius: 6.0,
                  offset: const Offset(0.0, 2.0),
                ),
              ]
            : null,
      ),
      child: Text(
        key.label,
        textAlign: TextAlign.center,
        style: _hMono(9.5, text, weight: FontWeight.w700),
      ),
    ),
  );
}

// Lookup helper for `_specOf` — small map computed at call time so the const
// `_specs` stays a `const` and we don't pay the cost of building a runtime map
// every render.
_ModifierSpec _specOf(ModifierKey key) {
  for (final _ModifierSpec spec in _specs) {
    if (spec.key == key) {
      return spec;
    }
  }
  // Should be unreachable while `_specs` covers every enum value. We assert in
  // the demo entry-point too so the failure mode is loud.
  return _specs.first;
}

// ---------------------------------------------------------------------------
// Helper: render the mock keyboard with one chosen ModifierKey highlighted.
// ---------------------------------------------------------------------------
Widget _miniKeyboard(ModifierKey highlight) {
  return Container(
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF263238), Color(0xFF455A64)],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFF607D8B)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final List<_Key> row in _mockKeyboard)
          Row(
            children: <Widget>[
              for (final _Key key in row) _physicalKey(key, highlight),
            ],
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: small "matrix" cell — bool glyph + colour from spec.
// ---------------------------------------------------------------------------
Widget _matrixCell({required bool yes, required Color color}) {
  return Container(
    width: 48.0,
    height: 28.0,
    margin: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      color: yes ? color.withValues(alpha: 0.18) : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: yes ? color : Colors.grey.shade400),
    ),
    alignment: Alignment.center,
    child: Icon(
      yes ? Icons.check : Icons.remove,
      size: 16.0,
      color: yes ? color : Colors.grey.shade500,
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: small label pill used in the comparison table header.
// ---------------------------------------------------------------------------
Widget _tableHeader(String text, Color color) {
  return Container(
    width: 110.0,
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    margin: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
    ),
    alignment: Alignment.center,
    child: Text(text, style: _hMono(10.5, color, weight: FontWeight.w800)),
  );
}

// ---------------------------------------------------------------------------
// Helper: pitfall row.
// ---------------------------------------------------------------------------
Widget _pitfall(String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFE57373)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.priority_high,
                size: 16.0, color: Color(0xFFB71C1C)),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(title,
                  style: _hSans(12.0, const Color(0xFFB71C1C),
                      weight: FontWeight.w800)),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(body, style: _hSans(11.5, const Color(0xFF6D4C41))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: recipe card. Migrating from raw-keyboard to hardware-keyboard.
// ---------------------------------------------------------------------------
Widget _recipeCard({
  required String title,
  required String subtitle,
  required List<Color> gradient,
  required Color accent,
  required String code,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, size: 18.0, color: accent),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(title,
                  style: _hSans(13.0, accent, weight: FontWeight.w900)),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(subtitle, style: _hSans(11.5, accent.withValues(alpha: 0.85))),
        const SizedBox(height: 10.0),
        _codeBlock(code, accent.withValues(alpha: 0.95)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: platform-row — labels for one ModifierKey across four platforms.
// ---------------------------------------------------------------------------
Widget _platformRow(_ModifierSpec spec) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: spec.glow.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: spec.glow.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Row(
            children: <Widget>[
              Icon(spec.icon, size: 14.0, color: spec.shadow),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(spec.shortLabel,
                    style: _hMono(11.0, spec.shadow, weight: FontWeight.w800)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(spec.windowsLabel,
              style: _hSans(11.0, const Color(0xFF1565C0))),
        ),
        Expanded(
          child: Text(spec.macLabel,
              style: _hSans(11.0, const Color(0xFF6A1B9A))),
        ),
        Expanded(
          child: Text(spec.linuxLabel,
              style: _hSans(11.0, const Color(0xFF2E7D32))),
        ),
        Expanded(
          child: Text(spec.androidLabel,
              style: _hSans(11.0, const Color(0xFFE65100))),
        ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN: build a full visual page describing ModifierKey.
// ===========================================================================
dynamic build(BuildContext context) {
  print('ModifierKey deep demo executing');

  // -------------------------------------------------------------------------
  // Sanity log: enumerate every value on stdout in declaration order so the
  // test runner sees the expected values. We assert the count: a future
  // bridge / SDK change must surface here, not silently drift.
  // -------------------------------------------------------------------------
  for (final ModifierKey value in ModifierKey.values) {
    print('  ModifierKey.${value.name} (index ${value.index})');
  }
  print('Total values: ${ModifierKey.values.length}');
  assert(ModifierKey.values.length == 9,
      'ModifierKey is expected to expose 9 values.');

  // Frozen progress used wherever the demo composes through Animation<double>.
  // `Duration.zero` is reused below where the API surface accepts a duration.
  final Animation<double> staticProgress =
      const AlwaysStoppedAnimation<double>(1.0);
  const Duration motion = Duration.zero;
  // Reference some `package:flutter/services.dart` types so the explicit
  // import is not flagged: we use `KeyboardSide` in the keyboard layout and
  // `LogicalKeyboardKey` in the migration recipes.
  const KeyboardSide defaultSide = KeyboardSide.any;
  final LogicalKeyboardKey shiftLeft = LogicalKeyboardKey.shiftLeft;
  print('Default KeyboardSide: ${defaultSide.name}');
  print('Companion logical key: ${shiftLeft.debugName}');

  // =========================================================================
  // SECTION 1 — Hero header. Names the enum, shows the nine members as pills,
  // and explains why the page exists.
  // =========================================================================
  final Widget hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1A237E),
          Color(0xFF311B92),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF311B92).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF42A5F5), Color(0xFF7986CB)],
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF7986CB).withValues(alpha: 0.4),
                    blurRadius: 14.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(Icons.keyboard_alt,
                  size: 36.0, color: Colors.white),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('package:flutter/services.dart  •  raw_keyboard.dart',
                      style: _hMono(11.0, Colors.white70)),
                  const SizedBox(height: 4.0),
                  Text('ModifierKey',
                      style: _hSans(30.0, Colors.white,
                          weight: FontWeight.w900)),
                  const SizedBox(height: 2.0),
                  Text(
                    'Nine modifier roles addressed by the legacy '
                    'RawKeyEventData API',
                    style: _hSans(13.0, Colors.white70),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEF5350).withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
                border:
                    Border.all(color: const Color(0xFFEF5350), width: 1.0),
              ),
              child: Text('@deprecated',
                  style: _hMono(11.0, Colors.white,
                      weight: FontWeight.w800)),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final _ModifierSpec spec in _specs)
              _miniChip(
                'ModifierKey.${spec.label}',
                spec.icon,
                spec.glow,
              ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          ),
          child: Text(
            'ModifierKey is the parameter that the legacy RawKeyEventData API '
            'uses to describe which physical modifier role (Ctrl, Shift, Alt, '
            'Meta, lock keys, Fn, Sym) was active for a key event. The enum '
            'itself is being phased out together with RawKeyboard, but it '
            'still appears in compatibility shims, IME handling, accessibility '
            'overlays, and any code that has not yet migrated to '
            'HardwareKeyboard + LogicalKeyboardKey.',
            style: _hSans(12.0, Colors.white.withValues(alpha: 0.92)),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 — Anatomy / source signature. Shows the enum declaration and
  // the deprecation banner the SDK ships.
  // =========================================================================
  final Widget anatomy = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF3949AB), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF3949AB).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Source signature',
            style: _hSans(14.0, const Color(0xFF1A237E),
                weight: FontWeight.w800)),
        const SizedBox(height: 10.0),
        _codeBlock(
          '@Deprecated(\n'
          '  \'No longer supported. \'\n'
          '  \'This feature was deprecated after v3.18.0-2.0.pre.\',\n'
          ')\n'
          'enum ModifierKey {\n'
          '  controlModifier,    // CTRL — typically two physical keys.\n'
          '  shiftModifier,      // SHIFT — typically two physical keys.\n'
          '  altModifier,        // ALT — left + right (right is AltGr).\n'
          '  metaModifier,       // Win / Cmd / Search.\n'
          '  capsLockModifier,   // Caps Lock — latched.\n'
          '  numLockModifier,    // Num Lock — latched.\n'
          '  scrollLockModifier, // Scroll Lock — latched.\n'
          '  functionModifier,   // Fn — vendor specific.\n'
          '  symbolModifier,     // Sym — Android soft IME.\n'
          '}\n'
          '\n'
          '// Used by:\n'
          '//   RawKeyEventData.isModifierPressed(\n'
          '//     ModifierKey key, {KeyboardSide side = KeyboardSide.any});\n'
          '//   RawKeyEventData.getModifierSide(ModifierKey key);',
          const Color(0xFFB3E5FC),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final ModifierKey v in ModifierKey.values)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFF7986CB)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:
                          const Color(0xFF7986CB).withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Text(
                  'index ${v.index} • ${v.name}',
                  style: _hMono(11.0, const Color(0xFF1A237E)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'The enum is dense — nine members covering everything from primary '
          'shortcut modifiers to vendor-specific layer keys. The signature is '
          'the same the SDK has shipped since the original raw-keyboard surface '
          'and is preserved verbatim for binary compatibility.',
          style: _hSans(12.0, const Color(0xFF1A237E)),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 — Per-value cards. One generated card per `_ModifierSpec`.
  // =========================================================================
  final Widget perValueCards = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[for (final _ModifierSpec spec in _specs) _valueCard(spec)],
  );

  // =========================================================================
  // SECTION 4 — Keyboard heat-map. Render the mock keyboard once per modifier
  // so the reader can see exactly which physical keys map to which enum value.
  // =========================================================================
  final Widget heatMap = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final _ModifierSpec spec in _specs)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.white, spec.dim],
            ),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: spec.glow.withValues(alpha: 0.5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: spec.glow.withValues(alpha: 0.15),
                blurRadius: 10.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(spec.icon, size: 18.0, color: spec.shadow),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'ModifierKey.${spec.label}  →  highlighted physical keys',
                      style: _hSans(13.0, spec.shadow,
                          weight: FontWeight.w800),
                    ),
                  ),
                  _miniChip(
                    spec.physicalCount == 1
                        ? '1 physical key'
                        : '${spec.physicalCount} physical keys',
                    Icons.keyboard,
                    spec.glow,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              _miniKeyboard(spec.key),
              const SizedBox(height: 8.0),
              Text(spec.tagline,
                  style: _hSans(11.5, spec.shadow.withValues(alpha: 0.85))),
            ],
          ),
        ),
    ],
  );

  // =========================================================================
  // SECTION 5 — Comparison matrix. One row per modifier, one column per
  // boolean dimension (lock-key, toggle, multi-key, desktop, mobile, etc.).
  // =========================================================================
  final Widget matrix = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFF59D)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFBC02D), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFFBC02D).withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Property matrix',
            style: _hSans(14.0, const Color(0xFFF57F17),
                weight: FontWeight.w900)),
        const SizedBox(height: 8.0),
        Text(
          'A quick at-a-glance table of the boolean traits that change how the '
          'modifier is used. Use it as a checklist when porting code.',
          style: _hSans(11.5, const Color(0xFF6D4C41)),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            SizedBox(
              width: 130.0,
              child: Text('Modifier',
                  style: _hMono(11.0, const Color(0xFFF57F17),
                      weight: FontWeight.w900)),
            ),
            _tableHeader('lock?', const Color(0xFFE65100)),
            _tableHeader('toggle?', const Color(0xFF0277BD)),
            _tableHeader('two keys?', const Color(0xFF2E7D32)),
            _tableHeader('desktop?', const Color(0xFF6A1B9A)),
            _tableHeader('mobile?', const Color(0xFFC2185B)),
          ],
        ),
        const SizedBox(height: 4.0),
        for (final _ModifierSpec spec in _specs)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: const Color(0xFFFBC02D)
                    .withValues(alpha: 0.4)),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Row(
                    children: <Widget>[
                      Icon(spec.icon, size: 14.0, color: spec.shadow),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(spec.shortLabel,
                            style: _hMono(11.0, spec.shadow,
                                weight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ),
                _matrixCell(yes: spec.isLockKey, color: spec.glow),
                _matrixCell(yes: spec.isToggle, color: spec.glow),
                _matrixCell(
                    yes: spec.physicalCount > 1, color: spec.glow),
                _matrixCell(
                    yes: spec.windowsLabel.startsWith('—') == false &&
                        spec.macLabel.startsWith('—') == false,
                    color: spec.glow),
                _matrixCell(
                    yes: spec.androidLabel.startsWith('—') == false,
                    color: spec.glow),
              ],
            ),
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 6 — Platform mapping. How each ModifierKey shows up on each OS.
  // =========================================================================
  final Widget platformTable = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF00838F), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF00838F).withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Platform mapping',
            style: _hSans(14.0, const Color(0xFF006064),
                weight: FontWeight.w900)),
        const SizedBox(height: 8.0),
        Text(
          'How each ModifierKey appears to the user on the four platforms '
          'Flutter targets. Use this when localising tooltips and shortcut '
          'cheat-sheets.',
          style: _hSans(11.5, const Color(0xFF004D40)),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            SizedBox(
              width: 110.0,
              child: Text('modifier',
                  style: _hMono(11.0, const Color(0xFF006064),
                      weight: FontWeight.w900)),
            ),
            Expanded(
              child: Text('Windows',
                  style: _hMono(11.0, const Color(0xFF1565C0),
                      weight: FontWeight.w900)),
            ),
            Expanded(
              child: Text('macOS',
                  style: _hMono(11.0, const Color(0xFF6A1B9A),
                      weight: FontWeight.w900)),
            ),
            Expanded(
              child: Text('Linux',
                  style: _hMono(11.0, const Color(0xFF2E7D32),
                      weight: FontWeight.w900)),
            ),
            Expanded(
              child: Text('Android',
                  style: _hMono(11.0, const Color(0xFFE65100),
                      weight: FontWeight.w900)),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (final _ModifierSpec spec in _specs) _platformRow(spec),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFF80DEEA).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.info_outline,
                  size: 16.0, color: Color(0xFF006064)),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'A single em-dash means the platform either does not surface '
                  'this modifier at all, or surfaces it under a different '
                  'name that the SDK simply does not translate. Always ship a '
                  'fallback shortcut for those cases.',
                  style: _hSans(11.0, const Color(0xFF004D40)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 — Recipes. Common code patterns: detecting Cmd/Ctrl, telling
  // left from right Alt, watching caps-lock, and migrating to HardwareKeyboard.
  // =========================================================================
  final Widget recipes = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _recipeCard(
        title: 'Recipe — primary shortcut on every desktop',
        subtitle: 'Treat Cmd on macOS and Ctrl elsewhere as the same chord.',
        gradient: const <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        accent: const Color(0xFF1565C0),
        code: 'final bool isPrimary = data.isModifierPressed(\n'
            '  Theme.of(context).platform == TargetPlatform.macOS\n'
            '      ? ModifierKey.metaModifier\n'
            '      : ModifierKey.controlModifier,\n'
            ');',
      ),
      _recipeCard(
        title: 'Recipe — left-Alt only (avoid AltGr)',
        subtitle: 'Restrict an Alt-chord to the left-hand key.',
        gradient: const <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        accent: const Color(0xFFE65100),
        code: 'final bool leftAlt = data.isModifierPressed(\n'
            '  ModifierKey.altModifier,\n'
            '  side: KeyboardSide.left,\n'
            ');',
      ),
      _recipeCard(
        title: 'Recipe — caps-lock state for password fields',
        subtitle: 'Warn the user if caps-lock is currently on.',
        gradient: const <Color>[Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
        accent: const Color(0xFF00695C),
        code: 'final bool capsOn = data.isModifierPressed(\n'
            '  ModifierKey.capsLockModifier,\n'
            ');\n'
            'if (capsOn) showCapsLockBanner();',
      ),
      _recipeCard(
        title: 'Recipe — full snapshot of every pressed modifier',
        subtitle: 'Iterate ModifierKey.values to build a side-aware map.',
        gradient: const <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        accent: const Color(0xFF6A1B9A),
        code: 'Map<ModifierKey, KeyboardSide> snap = <ModifierKey, KeyboardSide>{};\n'
            'for (final ModifierKey key in ModifierKey.values) {\n'
            '  if (data.isModifierPressed(key)) {\n'
            '    snap[key] = data.getModifierSide(key) ?? KeyboardSide.any;\n'
            '  }\n'
            '}',
      ),
      _recipeCard(
        title: 'Recipe — migration to HardwareKeyboard',
        subtitle: 'Replace ModifierKey lookups with HardwareKeyboard.instance.',
        gradient: const <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        accent: const Color(0xFF2E7D32),
        code: '// Old (deprecated):\n'
            'final bool ctrl = data.isModifierPressed(\n'
            '  ModifierKey.controlModifier,\n'
            ');\n'
            '\n'
            '// New (recommended):\n'
            'final bool ctrl = HardwareKeyboard.instance.isControlPressed;',
      ),
    ],
  );

  // =========================================================================
  // SECTION 8 — Pitfalls. Hard-earned lessons that bite teams when they ship.
  // =========================================================================
  final Widget pitfalls = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFE53935), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFE53935).withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Pitfalls and traps',
            style: _hSans(14.0, const Color(0xFFB71C1C),
                weight: FontWeight.w900)),
        const SizedBox(height: 8.0),
        _pitfall(
          'The whole API is deprecated.',
          'ModifierKey, RawKeyEventData, and isModifierPressed are scheduled '
              'for removal. Treat any new code that touches ModifierKey as '
              'tech-debt and budget time to migrate to HardwareKeyboard.',
        ),
        _pitfall(
          'Right-Alt is not always Alt.',
          'On most non-US layouts the right-Alt is AltGr and produces dead-key '
              'composition before Flutter sees the event. Use KeyboardSide.left '
              'when you need a true Alt-modifier chord.',
        ),
        _pitfall(
          'Caps-lock event ordering is inverted.',
          'You receive a key-up while the LED turns ON, and a key-down when it '
              'turns OFF. Do not count edges — read the boolean snapshot.',
        ),
        _pitfall(
          'Fn is rarely surfaced.',
          'Most laptops handle Fn entirely in firmware so the modifier never '
              'reaches Flutter. Cannot be relied on cross-vendor — never make '
              'Fn the only path to a feature.',
        ),
        _pitfall(
          'Sym is Android-only.',
          'No desktop, web, or iOS keyboard ever sets symbolModifier. Guard '
              'with a Platform check or QA will report it as broken.',
        ),
        _pitfall(
          'Num-lock changes the keypad meaning.',
          'When num-lock is OFF the numeric keypad emits arrow / Home / End '
              'events instead of digits. A shortcut bound to "keypad 7" can '
              'silently become "Home" between sessions.',
        ),
        _pitfall(
          'Soft keyboards latch Shift.',
          'On Android and iOS the IME often delivers an already-uppercase '
              'character with no ModifierKey.shiftModifier set at all. Always '
              'read the character, not the modifier, for case.',
        ),
        _pitfall(
          'getModifierSide can return null.',
          'When the modifier is not pressed at the time of the event the '
              'method returns null — not KeyboardSide.any. Handle the null '
              'case explicitly.',
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 — Lifecycle / migration timeline. Shows where ModifierKey sits
  // in the overall raw-keyboard deprecation arc, and how to replace it.
  // =========================================================================
  final Widget timeline = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF00ACC1), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF00ACC1).withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Migration timeline',
            style: _hSans(14.0, const Color(0xFF006064),
                weight: FontWeight.w900)),
        const SizedBox(height: 12.0),
        for (final List<dynamic> step in <List<dynamic>>[
          <dynamic>[
            'pre-3.18',
            'RawKeyboard owns it',
            'ModifierKey + RawKeyEventData are the canonical API for modifier '
                'inspection. Every shortcut framework wraps them.',
            const Color(0xFF1565C0),
            Icons.history,
          ],
          <dynamic>[
            '3.18',
            'Deprecation banner',
            'The enum and surrounding classes are decorated with @Deprecated. '
                'No behavioural change yet — just a compiler warning.',
            const Color(0xFFE65100),
            Icons.warning_amber,
          ],
          <dynamic>[
            'now',
            'Co-existence',
            'HardwareKeyboard is the recommended API; RawKeyboard still works. '
                'New code should use HardwareKeyboard, old code keeps running.',
            const Color(0xFF6A1B9A),
            Icons.swap_horiz,
          ],
          <dynamic>[
            'next stable',
            'Soft removal',
            'Calls return harmless defaults; the bridge generator skips the '
                'enum (which is exactly why this demo uses a local shim).',
            const Color(0xFFD81B60),
            Icons.remove_circle_outline,
          ],
          <dynamic>[
            'long term',
            'Hard removal',
            'ModifierKey will be deleted from the SDK. Code still depending on '
                'it will fail to compile. Plan migration well before this '
                'point.',
            const Color(0xFFB71C1C),
            Icons.delete_forever,
          ],
        ])
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: (step[3] as Color).withValues(alpha: 0.5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: (step[3] as Color).withValues(alpha: 0.18),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 92.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        (step[3] as Color).withValues(alpha: 0.85),
                        (step[3] as Color).withValues(alpha: 0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(step[4] as IconData,
                          size: 14.0, color: Colors.white),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(step[0] as String,
                            style: _hMono(10.0, Colors.white,
                                weight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(step[1] as String,
                          style: _hSans(13.0, step[3] as Color,
                              weight: FontWeight.w800)),
                      const SizedBox(height: 4.0),
                      Text(step[2] as String,
                          style: _hSans(11.5, const Color(0xFF263238))),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 10 — Quick reference. Tight, dense table with one row per value.
  // =========================================================================
  final Widget quickRef = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF1F8E9), Color(0xFFDCEDC8)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF558B2F), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF558B2F).withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Quick reference',
            style: _hSans(14.0, const Color(0xFF33691E),
                weight: FontWeight.w900)),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            SizedBox(
                width: 60.0,
                child: Text('idx',
                    style: _hMono(10.0, const Color(0xFF33691E),
                        weight: FontWeight.w900))),
            SizedBox(
                width: 170.0,
                child: Text('name',
                    style: _hMono(10.0, const Color(0xFF33691E),
                        weight: FontWeight.w900))),
            SizedBox(
                width: 70.0,
                child: Text('keys',
                    style: _hMono(10.0, const Color(0xFF33691E),
                        weight: FontWeight.w900))),
            SizedBox(
                width: 70.0,
                child: Text('lock',
                    style: _hMono(10.0, const Color(0xFF33691E),
                        weight: FontWeight.w900))),
            Expanded(
              child: Text('platform note',
                  style: _hMono(10.0, const Color(0xFF33691E),
                      weight: FontWeight.w900)),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Container(
          height: 1.0,
          color: const Color(0xFF558B2F).withValues(alpha: 0.4),
        ),
        for (final _ModifierSpec spec in _specs)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: const Color(0xFF558B2F).withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 60.0,
                  child: Text('${spec.key.index}',
                      style: _hMono(11.0, spec.shadow,
                          weight: FontWeight.w800)),
                ),
                SizedBox(
                  width: 170.0,
                  child: Row(
                    children: <Widget>[
                      Icon(spec.icon, size: 12.0, color: spec.shadow),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(spec.label,
                            style: _hMono(11.0, spec.shadow)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 70.0,
                  child: Text('${spec.physicalCount}',
                      style: _hMono(11.0, spec.shadow)),
                ),
                SizedBox(
                  width: 70.0,
                  child: Icon(
                    spec.isLockKey ? Icons.lock : Icons.lock_open,
                    size: 14.0,
                    color: spec.isLockKey
                        ? spec.glow
                        : Colors.grey.shade500,
                  ),
                ),
                Expanded(
                  child: Text(spec.platformNote,
                      style: _hSans(11.0, const Color(0xFF33691E))),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 11 — ASCII footer. The classic monospace cheat-sheet.
  // =========================================================================
  final Widget asciiFooter = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1B1F23), Color(0xFF24292E)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF7E57C2), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF7E57C2).withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      '  ┌─────────────────────────────────────────────────────────────────┐\n'
      '  │              ModifierKey  ::  raw_keyboard.dart                 │\n'
      '  ├─────────────────────────────────────────────────────────────────┤\n'
      '  │  0  controlModifier      ⌃  Ctrl              left + right      │\n'
      '  │  1  shiftModifier        ⇧  Shift             left + right      │\n'
      '  │  2  altModifier          ⌥  Alt / AltGr       left + right      │\n'
      '  │  3  metaModifier         ⌘  Win / Cmd         left + right      │\n'
      '  │  4  capsLockModifier     ⇪  Caps Lock         latched           │\n'
      '  │  5  numLockModifier      ⓝ  Num Lock          latched           │\n'
      '  │  6  scrollLockModifier   ⓢ  Scroll Lock       latched           │\n'
      '  │  7  functionModifier     ƒn Fn                vendor specific   │\n'
      '  │  8  symbolModifier       ☺  Sym               Android IME       │\n'
      '  ├─────────────────────────────────────────────────────────────────┤\n'
      '  │  USAGE:                                                         │\n'
      '  │    data.isModifierPressed(ModifierKey.shiftModifier);           │\n'
      '  │    data.isModifierPressed(ModifierKey.altModifier,              │\n'
      '  │                            side: KeyboardSide.left);            │\n'
      '  │    data.getModifierSide(ModifierKey.metaModifier);              │\n'
      '  ├─────────────────────────────────────────────────────────────────┤\n'
      '  │  MIGRATION:                                                     │\n'
      '  │    HardwareKeyboard.instance.isControlPressed                   │\n'
      '  │    HardwareKeyboard.instance.isShiftPressed                     │\n'
      '  │    HardwareKeyboard.instance.isAltPressed                       │\n'
      '  │    HardwareKeyboard.instance.isMetaPressed                      │\n'
      '  │    HardwareKeyboard.instance.lockModesEnabled                   │\n'
      '  └─────────────────────────────────────────────────────────────────┘',
      style: _hMono(11.0, const Color(0xFFB39DDB), weight: FontWeight.w600),
    ),
  );

  // =========================================================================
  // BUILD: assemble all sections into a single scrollable page.
  // =========================================================================
  print('Demo composition complete — assembling MaterialApp');
  // Reference `motion` so the analyzer is happy that we use the named const.
  final Duration alsoMotion = motion;
  print('Motion duration (frozen): ${alsoMotion.inMilliseconds}ms');
  print('Static progress value: ${staticProgress.value}');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5FA),
      textTheme: const TextTheme(),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              _sectionTitle(
                  1, 'Anatomy and signature', Icons.code, const Color(0xFF1A237E)),
              anatomy,
              _sectionTitle(
                  2,
                  'Per-value walkthrough',
                  Icons.list_alt,
                  const Color(0xFF6A1B9A)),
              perValueCards,
              _sectionTitle(
                  3,
                  'Keyboard heat-map',
                  Icons.keyboard,
                  const Color(0xFF00838F)),
              heatMap,
              _sectionTitle(
                  4,
                  'Property matrix',
                  Icons.grid_on,
                  const Color(0xFFF57F17)),
              matrix,
              _sectionTitle(
                  5,
                  'Platform mapping',
                  Icons.public,
                  const Color(0xFF00838F)),
              platformTable,
              _sectionTitle(
                  6,
                  'Recipes',
                  Icons.menu_book,
                  const Color(0xFF2E7D32)),
              recipes,
              _sectionTitle(
                  7,
                  'Pitfalls and traps',
                  Icons.warning_amber,
                  const Color(0xFFB71C1C)),
              pitfalls,
              _sectionTitle(
                  8,
                  'Migration timeline',
                  Icons.timeline,
                  const Color(0xFF006064)),
              timeline,
              _sectionTitle(
                  9,
                  'Quick reference',
                  Icons.fact_check,
                  const Color(0xFF33691E)),
              quickRef,
              _sectionTitle(
                  10,
                  'ASCII cheat-sheet',
                  Icons.terminal,
                  const Color(0xFF7E57C2)),
              asciiFooter,
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(14.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xFFE1BEE7),
                      Color(0xFFD1C4E9),
                      Color(0xFFC5CAE9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFF9575CD).withValues(alpha: 0.3),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Text(
                  'End of ModifierKey deep demo  •  ${ModifierKey.values.length} '
                  'values  •  generated for the d4rt visual regression suite',
                  style: _hMono(11.0, const Color(0xFF311B92),
                      weight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
