// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, dead_code
// D4rt test script: KeyboardSide from package:flutter/services.dart
// ---------------------------------------------------------------------------
// Deep Demo: Visual exploration of the `KeyboardSide` enum used by the
// `RawKeyEventData.isModifierPressed(...)` family of APIs to ask whether a
// modifier on the LEFT side of the keyboard, the RIGHT side, EITHER side, or
// BOTH sides simultaneously is being held down. The demo is purely declarative
// — the script returns a `MaterialApp` that paints a multi-section walkthrough
// of every value, the underlying mock keyboard layout, the shortcut tables you
// might wire it into, and the desktop / web pitfalls you should keep in mind
// when porting code that depends on side-aware modifiers.
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ===========================================================================
// SPEC: every KeyboardSide value carries a tightly bundled set of metadata so
// the section builders below can be data-driven instead of hard-coded.
// ===========================================================================
class _SideSpec {
  const _SideSpec({
    required this.side,
    required this.label,
    required this.headline,
    required this.tagline,
    required this.icon,
    required this.glow,
    required this.dim,
    required this.shadow,
    required this.matchesLeft,
    required this.matchesRight,
    required this.matchesBoth,
    required this.usage,
    required this.example,
    required this.gotcha,
  });

  final KeyboardSide side;
  final String label;
  final String headline;
  final String tagline;
  final IconData icon;
  final Color glow;
  final Color dim;
  final Color shadow;
  final bool matchesLeft;
  final bool matchesRight;
  final bool matchesBoth;
  final String usage;
  final String example;
  final String gotcha;
}

// All four enumerated members of `KeyboardSide`. We assert the count so a
// future SDK change immediately surfaces here instead of silently drifting.
const List<_SideSpec> _sideSpecs = <_SideSpec>[
  _SideSpec(
    side: KeyboardSide.any,
    label: 'any',
    headline: 'EITHER SIDE WILL DO',
    tagline: 'Match left, right, or both — the default for most APIs.',
    icon: Icons.swap_horiz,
    glow: Color(0xFF42A5F5),
    dim: Color(0xFFE3F2FD),
    shadow: Color(0xFF1565C0),
    matchesLeft: true,
    matchesRight: true,
    matchesBoth: true,
    usage:
        'Default value for `RawKeyEventData.isModifierPressed`. Use it when you '
        'do not care which physical Shift / Ctrl / Alt / Meta key triggered the '
        'event — only that some Shift was down.',
    example: 'event.isShiftPressed                       // any-Shift',
    gotcha:
        'Because `any` is the default it is the safest choice — but it hides '
        'side information. If a feature is supposed to differ for left vs '
        'right modifiers you must NOT use `any`.',
  ),
  _SideSpec(
    side: KeyboardSide.left,
    label: 'left',
    headline: 'LEFT MODIFIER ONLY',
    tagline: 'Match only the LEFT-hand version of the key.',
    icon: Icons.arrow_back,
    glow: Color(0xFFEC407A),
    dim: Color(0xFFFCE4EC),
    shadow: Color(0xFFAD1457),
    matchesLeft: true,
    matchesRight: false,
    matchesBoth: false,
    usage:
        'Use to wire a chord that *requires* the left Shift / Ctrl / Alt / '
        'Meta. Most often paired with games and accessibility toggles where '
        'the left hand owns the modifier and the right hand drives the action.',
    example:
        'data.isModifierPressed(ModifierKey.shiftModifier, side: KeyboardSide.left)',
    gotcha:
        'Mobile soft-keyboards do not report a side, so a left-only chord is '
        'effectively a desktop / web feature. Always provide a fallback for '
        'platforms that lack side information.',
  ),
  _SideSpec(
    side: KeyboardSide.right,
    label: 'right',
    headline: 'RIGHT MODIFIER ONLY',
    tagline: 'Match only the RIGHT-hand version of the key.',
    icon: Icons.arrow_forward,
    glow: Color(0xFFFFA726),
    dim: Color(0xFFFFF3E0),
    shadow: Color(0xFFE65100),
    matchesLeft: false,
    matchesRight: true,
    matchesBoth: false,
    usage:
        'Mirror of `left`. Useful for split keyboard layouts, or for power '
        'users who want a distinct binding on the right Alt (AltGr on European '
        'layouts) without disturbing the left-Alt menu mnemonics.',
    example:
        'data.isModifierPressed(ModifierKey.altModifier, side: KeyboardSide.right)',
    gotcha:
        'On most keyboards the right Alt is AltGr and is consumed by the OS '
        'before Flutter sees it. Treat `right` as a "best-effort" hint and '
        'never rely on it for primary actions.',
  ),
  _SideSpec(
    side: KeyboardSide.all,
    label: 'all',
    headline: 'BOTH SIDES TOGETHER',
    tagline: 'Match only when LEFT *and* RIGHT are pressed simultaneously.',
    icon: Icons.compare_arrows,
    glow: Color(0xFF66BB6A),
    dim: Color(0xFFE8F5E9),
    shadow: Color(0xFF1B5E20),
    matchesLeft: false,
    matchesRight: false,
    matchesBoth: true,
    usage:
        'A "panic chord" — both Shifts, both Ctrls, both Alts, or both Metas. '
        'Useful for emergency overrides where the user must hold the modifier '
        'with two hands to confirm a destructive action.',
    example:
        'data.isModifierPressed(ModifierKey.controlModifier, side: KeyboardSide.all)',
    gotcha:
        'OS keyboard managers can reject duplicate modifiers (especially on '
        'Linux/X11) so `all` may never fire. Fall back to a confirm dialog '
        'instead of silently no-op-ing.',
  ),
];

// ===========================================================================
// MOCK KEYBOARD: a tiny ASCII-flavoured layout used by the side-highlight
// section. The keys are organised in three rows; modifier keys are tagged so
// the section painter can highlight them per side.
// ===========================================================================
class _Key {
  const _Key(this.label, {this.side, this.isModifier = false, this.flex = 1});
  final String label;
  final KeyboardSide? side;
  final bool isModifier;
  final int flex;
}

const List<List<_Key>> _mockKeyboard = <List<_Key>>[
  <_Key>[
    _Key('Esc'),
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
    _Key('L-Shift',
        side: KeyboardSide.left, isModifier: true, flex: 2),
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
        side: KeyboardSide.right, isModifier: true, flex: 2),
  ],
  <_Key>[
    _Key('L-Ctrl',
        side: KeyboardSide.left, isModifier: true, flex: 2),
    _Key('L-Meta',
        side: KeyboardSide.left, isModifier: true, flex: 2),
    _Key('L-Alt',
        side: KeyboardSide.left, isModifier: true, flex: 2),
    _Key('Space', flex: 6),
    _Key('R-Alt',
        side: KeyboardSide.right, isModifier: true, flex: 2),
    _Key('R-Meta',
        side: KeyboardSide.right, isModifier: true, flex: 2),
    _Key('R-Ctrl',
        side: KeyboardSide.right, isModifier: true, flex: 2),
  ],
];

// Returns true when the given key should glow for the currently rendered
// keyboard side. The rules mirror the SDK semantics:
//   any   -> light up *all* modifier keys on both sides.
//   left  -> only the left-hand modifiers.
//   right -> only the right-hand modifiers.
//   all   -> light up both sides simultaneously (drawn with a pulse outline).
bool _isHighlighted(_Key key, KeyboardSide side) {
  if (!key.isModifier) {
    return false;
  }
  switch (side) {
    case KeyboardSide.any:
      return true;
    case KeyboardSide.left:
      return key.side == KeyboardSide.left;
    case KeyboardSide.right:
      return key.side == KeyboardSide.right;
    case KeyboardSide.all:
      return true;
  }
}

// ---------------------------------------------------------------------------
// Helper: text style shortcuts kept in one place so every section ends up
// with the same typographic rhythm.
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
// Helper: shared "section title" pill placed above each major block. The
// number argument keeps the order visible to a reader scrolling top-to-bottom.
// ---------------------------------------------------------------------------
Widget _sectionTitle(int index, String title, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.fromLTRB(4.0, 32.0, 4.0, 12.0),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[color.withValues(alpha: 0.18), color.withValues(alpha: 0.02)],
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
// Helper: a small "chip" that we reuse heavily — one rounded rectangle with
// an icon, a short label, and a colour tint pulled from the spec.
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
// Helper: a code-style block used in the recipe section. The progress driver
// uses an `AlwaysStoppedAnimation<double>` to satisfy the "no motion" rule
// while still demonstrating that the demo could plug into a real animation.
// ---------------------------------------------------------------------------
Widget _codeBlock(String code, Color accent) {
  // We construct a frozen animation to satisfy demos that compose with
  // `Animation<double>` without ever ticking. `Duration.zero` is reused below
  // wherever a "configurable" duration is required by the API surface.
  final Animation<double> frozen = const AlwaysStoppedAnimation<double>(1.0);
  // The frozen animation feeds an Opacity that always stays at full strength.
  return Opacity(
    opacity: frozen.value,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[const Color(0xFF1B1F23), const Color(0xFF24292E)],
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

// ===========================================================================
// MAIN: build a full page that walks through KeyboardSide.
// ===========================================================================
dynamic build(BuildContext context) {
  print('KeyboardSide deep demo executing');

  // -------------------------------------------------------------------------
  // Sanity log: enumerate every value on stdout so the test runner shows the
  // expected ordering. The count is asserted at runtime — if a Flutter SDK
  // upgrade ever changes the enum cardinality the demo will surface here.
  // -------------------------------------------------------------------------
  for (final KeyboardSide value in KeyboardSide.values) {
    print('  KeyboardSide.${value.name} (index ${value.index})');
  }
  print('Total values: ${KeyboardSide.values.length}');
  // The SDK currently exposes 4 values: any, left, right, all.
  assert(KeyboardSide.values.length == 4,
      'KeyboardSide is expected to expose 4 values.');

  // Frozen "progress" used by every progress-bar in the demo so we satisfy
  // the no-motion requirement while still composing through Animation<T>.
  final Animation<double> staticProgress =
      const AlwaysStoppedAnimation<double>(1.0);
  // Reused everywhere a Duration is required (e.g. AnimatedContainer style
  // recipes). We keep it at zero so nothing animates.
  const Duration motion = Duration.zero;

  // =========================================================================
  // SECTION 1 — Hero header. Sets the scene, names the enum, and previews the
  // four members as colour-coded pills.
  // =========================================================================
  final Widget hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1A237E), Color(0xFF4527A0), Color(0xFF311B92)],
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
                  colors: <Color>[Color(0xFF7E57C2), Color(0xFFB39DDB)],
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFFB39DDB).withValues(alpha: 0.4),
                    blurRadius: 14.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(Icons.keyboard, size: 36.0, color: Colors.white),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('package:flutter/services.dart',
                      style: _hMono(11.0, Colors.white70)),
                  const SizedBox(height: 4.0),
                  Text('KeyboardSide',
                      style: _hSans(30.0, Colors.white,
                          weight: FontWeight.w900)),
                  const SizedBox(height: 2.0),
                  Text(
                    'Side-aware modifier matching for shortcut and intent APIs',
                    style: _hSans(13.0, Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final _SideSpec spec in _sideSpecs)
              _miniChip(
                'KeyboardSide.${spec.label}',
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
            'KeyboardSide is the parameter that the legacy `RawKeyEventData` '
            'API uses to disambiguate left from right modifier keys. Even '
            'though `RawKeyboard` is being phased out in favour of '
            '`HardwareKeyboard`, side-aware checks still appear in shortcut '
            'matchers, intent maps, accessibility toggles, and game inputs.',
            style: _hSans(12.0, Colors.white.withValues(alpha: 0.92)),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 — Anatomy / enum signature. Shows the source you would see if
  // you opened raw_keyboard.dart, with each value annotated.
  // =========================================================================
  final Widget anatomy = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF8E24AA), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF8E24AA).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Source signature', style: _hSans(14.0, const Color(0xFF4A148C),
            weight: FontWeight.w800)),
        const SizedBox(height: 10.0),
        _codeBlock(
          'enum KeyboardSide {\n'
          '  // Match if either left, right, or both are pressed.\n'
          '  any,\n'
          '\n'
          '  // Match the left version of the key.\n'
          '  left,\n'
          '\n'
          '  // Match the right version of the key.\n'
          '  right,\n'
          '\n'
          '  // Match left and right pressed simultaneously.\n'
          '  all,\n'
          '}\n'
          '\n'
          '// Used by:\n'
          '//   RawKeyEventData.isModifierPressed(\n'
          '//     ModifierKey key, {KeyboardSide side = KeyboardSide.any});\n'
          '//   RawKeyEventData.getModifierSide(ModifierKey key);',
          const Color(0xFFF8BBD0),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final KeyboardSide v in KeyboardSide.values)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFCE93D8)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFFCE93D8).withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Text(
                  'index ${v.index} • ${v.name}',
                  style: _hMono(11.0, const Color(0xFF4A148C)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'Reading the signature top-to-bottom doubles as the operator-precedence '
          'guide: `any` is the most permissive, `all` the most restrictive, and '
          '`left`/`right` are the exact-match middle ground.',
          style: _hSans(12.0, const Color(0xFF4A148C)),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 — Per-value cards (one card per KeyboardSide member).
  // =========================================================================
  final List<Widget> valueCards = <Widget>[];
  for (final _SideSpec spec in _sideSpecs) {
    valueCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              spec.dim,
              Colors.white,
              spec.dim.withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: spec.glow.withValues(alpha: 0.55), width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: spec.shadow.withValues(alpha: 0.22),
              blurRadius: 16.0,
              offset: const Offset(0.0, 8.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header — name, index, headline.
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        spec.glow,
                        spec.shadow.withValues(alpha: 0.85),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: spec.glow.withValues(alpha: 0.4),
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(spec.icon, size: 30.0, color: Colors.white),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('KeyboardSide.${spec.label}',
                          style: _hMono(15.0, spec.shadow,
                              weight: FontWeight.w900)),
                      const SizedBox(height: 2.0),
                      Text(spec.headline,
                          style: _hSans(11.0, spec.shadow,
                              weight: FontWeight.w700)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: spec.shadow.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                  child: Text('idx ${spec.side.index}',
                      style: _hMono(11.0, spec.shadow)),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(spec.tagline, style: _hSans(13.0, Colors.black87)),
            const SizedBox(height: 14.0),

            // Match matrix: shows whether this value matches a left-only
            // press, a right-only press, or a simultaneous left+right press.
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: spec.glow.withValues(alpha: 0.35)),
              ),
              child: Column(
                children: <Widget>[
                  Text('Matches when…',
                      style: _hSans(11.0, spec.shadow,
                          weight: FontWeight.w700)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _matchCell('Left only', spec.matchesLeft, spec.glow),
                      _matchCell('Right only', spec.matchesRight, spec.glow),
                      _matchCell('Both', spec.matchesBoth, spec.glow),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),

            // Usage prose.
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    spec.glow.withValues(alpha: 0.06),
                    spec.glow.withValues(alpha: 0.16),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('When to use',
                      style: _hSans(11.0, spec.shadow,
                          weight: FontWeight.w800)),
                  const SizedBox(height: 4.0),
                  Text(spec.usage, style: _hSans(12.0, Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // Code example.
            _codeBlock(spec.example, spec.glow),
            const SizedBox(height: 10.0),

            // Gotcha.
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDE7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xFFFBC02D)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.warning_amber_rounded,
                      size: 18.0, color: Color(0xFFF57F17)),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(spec.gotcha,
                        style: _hSans(11.5, const Color(0xFF6D4C41))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // A frozen progress bar that visualises how restrictive each
            // value is on a 0..1 scale (any=1.0 down to all=0.25).
            _restrictivenessBar(spec, staticProgress),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // SECTION 4 — Mock keyboard with side-highlighted modifier keys. The same
  // keyboard is rendered four times, once per KeyboardSide value, so the
  // reader can compare the highlighting at a glance.
  // =========================================================================
  final List<Widget> keyboards = <Widget>[];
  for (final _SideSpec spec in _sideSpecs) {
    keyboards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFFFAFAFA),
              spec.dim.withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: spec.glow.withValues(alpha: 0.5), width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: spec.shadow.withValues(alpha: 0.18),
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
                Icon(spec.icon, size: 18.0, color: spec.shadow),
                const SizedBox(width: 8.0),
                Text('KeyboardSide.${spec.label}',
                    style: _hMono(13.0, spec.shadow, weight: FontWeight.w800)),
                const Spacer(),
                _miniChip(spec.label.toUpperCase(), spec.icon, spec.glow),
              ],
            ),
            const SizedBox(height: 10.0),
            for (final List<_Key> row in _mockKeyboard)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: <Widget>[
                    for (final _Key k in row)
                      Expanded(
                        flex: k.flex,
                        child: _keyCap(k, spec, _isHighlighted(k, spec.side)),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 10.0),
            Text(
              _keyboardLegend(spec.side),
              style: _hMono(10.0, spec.shadow.withValues(alpha: 0.85)),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // SECTION 5 — Shortcut comparison table. Three sample shortcuts are scored
  // against each KeyboardSide value to show which ones light up.
  // =========================================================================
  final List<_ShortcutCase> shortcuts = <_ShortcutCase>[
    _ShortcutCase('Shift only (left)', leftPressed: true, rightPressed: false),
    _ShortcutCase('Shift only (right)', leftPressed: false, rightPressed: true),
    _ShortcutCase('Both Shifts pressed', leftPressed: true, rightPressed: true),
    _ShortcutCase('No Shift pressed', leftPressed: false, rightPressed: false),
  ];

  Widget shortcutTable() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFE3F2FD), Color(0xFFE8EAF6)],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFF1565C0), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1565C0).withValues(alpha: 0.18),
            blurRadius: 14.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 170.0),
              for (final _SideSpec spec in _sideSpecs)
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      color: spec.glow.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(spec.label,
                          style: _hMono(11.0, spec.shadow,
                              weight: FontWeight.w800)),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6.0),
          for (final _ShortcutCase sc in shortcuts)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3.0),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFFB0BEC5)),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 170.0,
                    child: Text(sc.label,
                        style: _hSans(12.0, const Color(0xFF263238),
                            weight: FontWeight.w700)),
                  ),
                  for (final _SideSpec spec in _sideSpecs)
                    Expanded(
                      child: Center(
                        child: _booleanGlyph(
                          sc.matches(spec.side),
                          spec.glow,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8.0),
          Text(
            'Reads top-to-bottom: each row is a hypothetical event, each '
            'column is a side-aware predicate. A green check means the '
            'event satisfies that predicate.',
            style: _hSans(11.0, const Color(0xFF263238)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // SECTION 6 — ModifierKey × KeyboardSide interaction diagram. We render a
  // matrix where each cell carries a tiny chord glyph (e.g. "L-Ctrl + R-Alt"
  // for ModifierKey.controlModifier × KeyboardSide.all is left+right Ctrl).
  // =========================================================================
  const List<ModifierKey> modifierKeys = <ModifierKey>[
    ModifierKey.shiftModifier,
    ModifierKey.controlModifier,
    ModifierKey.altModifier,
    ModifierKey.metaModifier,
  ];

  String modifierGlyph(ModifierKey key) {
    switch (key) {
      case ModifierKey.shiftModifier:
        return '⇧';
      case ModifierKey.controlModifier:
        return '⌃';
      case ModifierKey.altModifier:
        return '⌥';
      case ModifierKey.metaModifier:
        return '⌘';
      case ModifierKey.capsLockModifier:
        return '⇪';
      case ModifierKey.numLockModifier:
        return '#';
      case ModifierKey.scrollLockModifier:
        return '↧';
      case ModifierKey.functionModifier:
        return 'fn';
      case ModifierKey.symbolModifier:
        return 'sy';
    }
  }

  String chord(ModifierKey key, KeyboardSide side) {
    final String g = modifierGlyph(key);
    switch (side) {
      case KeyboardSide.any:
        return g;
      case KeyboardSide.left:
        return 'L-$g';
      case KeyboardSide.right:
        return 'R-$g';
      case KeyboardSide.all:
        return 'L-$g + R-$g';
    }
  }

  final Widget interactionDiagram = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFB8C00), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFFB8C00).withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 110.0),
            for (final KeyboardSide side in KeyboardSide.values)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB8C00).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(side.name,
                        style: _hMono(11.0, const Color(0xFF6D4C41),
                            weight: FontWeight.w800)),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (final ModifierKey key in modifierKeys)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFFFCC80)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  child: Text(
                    key.name.replaceAll('Modifier', ''),
                    style: _hSans(12.0, const Color(0xFF6D4C41),
                        weight: FontWeight.w700),
                  ),
                ),
                for (final KeyboardSide side in KeyboardSide.values)
                  Expanded(
                    child: Center(
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFE082),
                              Color(0xFFFFD54F),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: const Color(0xFFF9A825)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0xFFF9A825)
                                  .withValues(alpha: 0.4),
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Text(
                          chord(key, side),
                          style: _hMono(10.0, const Color(0xFF5D4037),
                              weight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 8.0),
        Text(
          'Each cell is the literal chord `getModifierSide` would have to '
          'observe in order for `isModifierPressed(key, side: side)` to '
          'evaluate to true.',
          style: _hSans(11.0, const Color(0xFF6D4C41)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 — Recipes. Three real-world snippets the reader can copy: a
  // SingleActivator bound to either Shift, a side-aware accessibility
  // toggle, and a "panic chord" backed by ModifierKey + KeyboardSide.all.
  // =========================================================================
  final List<Widget> recipes = <Widget>[
    _recipeCard(
      title: 'Recipe 1 — Side-agnostic SingleActivator',
      subtitle: 'The default. Match either Shift.',
      gradient: const <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
      accent: const Color(0xFF00838F),
      code:
          '// Bind <Shift+S> regardless of which Shift is held.\n'
          'SingleActivator(\n'
          '  LogicalKeyboardKey.keyS,\n'
          '  shift: true, // any Shift\n'
          ');\n'
          '\n'
          '// Internally, RawKeyEventData.isModifierPressed defaults to\n'
          '// `KeyboardSide.any`, so this works on every platform.',
    ),
    _recipeCard(
      title: 'Recipe 2 — Left-only accessibility toggle',
      subtitle: 'Only the left Alt enables high-contrast mode.',
      gradient: const <Color>[Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
      accent: const Color(0xFFAD1457),
      code:
          'final RawKeyEventData data = event.data;\n'
          'final bool isLeftAltOnly = data.isModifierPressed(\n'
          '  ModifierKey.altModifier,\n'
          '  side: KeyboardSide.left,\n'
          ');\n'
          'if (isLeftAltOnly && event.logicalKey == LogicalKeyboardKey.keyA) {\n'
          '  toggleHighContrast();\n'
          '}',
    ),
    _recipeCard(
      title: 'Recipe 3 — Two-handed panic chord',
      subtitle: 'Both Ctrls + Esc — emergency stop.',
      gradient: const <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
      accent: const Color(0xFF1B5E20),
      code:
          'final bool bothCtrl = data.isModifierPressed(\n'
          '  ModifierKey.controlModifier,\n'
          '  side: KeyboardSide.all,\n'
          ');\n'
          'if (bothCtrl && event.logicalKey == LogicalKeyboardKey.escape) {\n'
          '  emergencyStop();\n'
          '}',
    ),
    _recipeCard(
      title: 'Recipe 4 — Inspect getModifierSide for telemetry',
      subtitle: 'Log which physical key fired the chord.',
      gradient: const <Color>[Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
      accent: const Color(0xFF4527A0),
      code:
          'final KeyboardSide? side =\n'
          '    data.getModifierSide(ModifierKey.shiftModifier);\n'
          'switch (side) {\n'
          '  case KeyboardSide.left:  log(\'Left-Shift\');\n'
          '  case KeyboardSide.right: log(\'Right-Shift\');\n'
          '  case KeyboardSide.all:   log(\'Both Shifts\');\n'
          '  case KeyboardSide.any:   log(\'Either Shift\');\n'
          '  case null:               log(\'Side unknown (mobile)\');\n'
          '}',
    ),
  ];

  // =========================================================================
  // SECTION 8 — Pitfalls. Plain prose with red/yellow framing.
  // =========================================================================
  final Widget pitfalls = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFC62828), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFC62828).withValues(alpha: 0.22),
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
            const Icon(Icons.report_problem,
                color: Color(0xFFB71C1C), size: 24.0),
            const SizedBox(width: 8.0),
            Text('Pitfalls & platform quirks',
                style: _hSans(15.0, const Color(0xFFB71C1C),
                    weight: FontWeight.w900)),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          'Mobile / soft keyboards do not report a side',
          'On Android and iOS, `RawKeyEventData.getModifierSide` returns null '
              'for most synthetic key events. Treat side-aware checks as a '
              'desktop / web upgrade, not a hard requirement.',
        ),
        _pitfall(
          'Web normalises some right modifiers',
          'Browser key events sometimes synthesise the right modifier as the '
              'left one, especially for Meta. Test on every browser you '
              'support before assuming `KeyboardSide.right` is reliable.',
        ),
        _pitfall(
          '`KeyboardSide.all` is rare in the wild',
          'A simultaneous left+right press is hard to coordinate; window '
              'managers may consume one of the events. If your UX hinges on '
              '`all`, surface a fallback (a confirm dialog, a long-press, etc.).',
        ),
        _pitfall(
          '`RawKeyboard` is deprecated',
          'New code should use `HardwareKeyboard` and `KeyEvent`, which lean '
              'on `LogicalKeyboardKey` distinctions (e.g. `shiftLeft` vs '
              '`shiftRight`) instead of a separate `KeyboardSide` enum. '
              'KeyboardSide is still relevant for legacy maintenance.',
        ),
        _pitfall(
          'Default `KeyboardSide.any` in `isModifierPressed`',
          'It is easy to write `data.isModifierPressed(...)` and forget that '
              'the side defaults to `any`. If you mean "left only" you must '
              'pass it explicitly.',
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 — ASCII footer. A frozen progress bar caps the page so the
  // demo "ends" with a visible terminator.
  // =========================================================================
  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 32.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF263238), Color(0xFF37474F)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '+--------------------------------------------------------+\n'
          '|              KeyboardSide deep-demo                    |\n'
          '|                                                        |\n'
          '|  any   :: matches L | matches R | matches L+R          |\n'
          '|  left  :: matches L                                    |\n'
          '|  right ::             matches R                        |\n'
          '|  all   ::                          matches L+R         |\n'
          '|                                                        |\n'
          '|  -- emitted ${KeyboardSide.values.length} values, '
          '${_sideSpecs.length} cards, '
          '${_mockKeyboard.length} keyboard rows --      |\n'
          '+--------------------------------------------------------+',
          style: _hMono(11.0, const Color(0xFF80CBC4)),
        ),
        const SizedBox(height: 12.0),
        // Frozen progress bar (always 100%) backed by the always-stopped
        // animation we created at the top of build().
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: SizedBox(
            height: 8.0,
            child: LinearProgressIndicator(
              value: staticProgress.value,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF80CBC4)),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Static progress = ${staticProgress.value.toStringAsFixed(2)} • '
          'tween duration = ${motion.inMilliseconds}ms • no motion by design.',
          style: _hMono(10.0, Colors.white.withValues(alpha: 0.7)),
        ),
      ],
    ),
  );

  print('KeyboardSide deep demo built — assembling tree');

  // =========================================================================
  // Final tree: SingleChildScrollView wrapping a Column of all sections.
  // =========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KeyboardSide Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              _sectionTitle(
                  2, 'Anatomy & enum signature', Icons.menu_book,
                  const Color(0xFF8E24AA)),
              anatomy,
              _sectionTitle(
                  3, 'Per-value cards (any / left / right / all)',
                  Icons.style, const Color(0xFF1565C0)),
              ...valueCards,
              _sectionTitle(
                  4, 'Mock keyboard with side-highlighted modifiers',
                  Icons.keyboard, const Color(0xFF6A1B9A)),
              ...keyboards,
              _sectionTitle(
                  5, 'Shortcut comparison table', Icons.table_chart,
                  const Color(0xFF1565C0)),
              shortcutTable(),
              _sectionTitle(
                  6, 'ModifierKey × KeyboardSide interaction',
                  Icons.account_tree, const Color(0xFFEF6C00)),
              interactionDiagram,
              _sectionTitle(
                  7, 'Recipes', Icons.restaurant_menu,
                  const Color(0xFF2E7D32)),
              ...recipes,
              _sectionTitle(
                  8, 'Pitfalls & platform quirks',
                  Icons.report_problem, const Color(0xFFC62828)),
              pitfalls,
              _sectionTitle(
                  9, 'Footer', Icons.flag, const Color(0xFF455A64)),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: a single match cell used inside the per-value cards. A green check
// or a red bar tells the reader whether the current KeyboardSide matches the
// scenario (left only, right only, or both at once).
// ---------------------------------------------------------------------------
Widget _matchCell(String label, bool matches, Color glow) {
  return Container(
    width: 90.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: matches
          ? glow.withValues(alpha: 0.16)
          : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: matches ? glow : Colors.grey.shade400,
      ),
    ),
    child: Column(
      children: <Widget>[
        Icon(
          matches ? Icons.check_circle : Icons.remove_circle_outline,
          size: 22.0,
          color: matches ? glow : Colors.grey.shade500,
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: _hSans(10.0,
              matches ? glow : Colors.grey.shade600,
              weight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: a small "key cap" for the mock keyboard. A modifier key is drawn
// with a coloured glow when it matches the requested side, and dim grey
// otherwise.
// ---------------------------------------------------------------------------
Widget _keyCap(_Key k, _SideSpec spec, bool highlighted) {
  final Color baseColor =
      highlighted ? spec.glow : const Color(0xFFECEFF1);
  final Color borderColor =
      highlighted ? spec.shadow : const Color(0xFFB0BEC5);
  final Color textColor =
      highlighted ? Colors.white : const Color(0xFF455A64);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    height: 32.0,
    decoration: BoxDecoration(
      gradient: highlighted
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                spec.glow,
                spec.shadow.withValues(alpha: 0.85),
              ],
            )
          : null,
      color: highlighted ? null : baseColor,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: borderColor),
      boxShadow: highlighted
          ? <BoxShadow>[
              BoxShadow(
                color: spec.glow.withValues(alpha: 0.45),
                blurRadius: 8.0,
                offset: const Offset(0.0, 2.0),
              ),
            ]
          : null,
    ),
    alignment: Alignment.center,
    child: Text(
      k.label,
      style: _hMono(
        k.label.length > 5 ? 9.0 : 11.0,
        textColor,
        weight: highlighted ? FontWeight.w800 : FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    ),
  );
}

// Returns a short legend describing what is currently lit up.
String _keyboardLegend(KeyboardSide side) {
  switch (side) {
    case KeyboardSide.any:
      return '// any → every modifier glows; the predicate fires on either side.';
    case KeyboardSide.left:
      return '// left → only the four left-hand modifiers glow.';
    case KeyboardSide.right:
      return '// right → only the four right-hand modifiers glow.';
    case KeyboardSide.all:
      return '// all → every modifier glows, but the chord requires both at once.';
  }
}

// ---------------------------------------------------------------------------
// Helper: a "restrictiveness" bar. The width is proportional to how many of
// the three scenarios (left, right, both) the current side accepts, so the
// reader can spot at a glance that `any` is the loosest and `all` the tightest.
// ---------------------------------------------------------------------------
Widget _restrictivenessBar(_SideSpec spec, Animation<double> driver) {
  final int matches = (spec.matchesLeft ? 1 : 0) +
      (spec.matchesRight ? 1 : 0) +
      (spec.matchesBoth ? 1 : 0);
  // 3 scenarios → fraction = matches/3. Multiplied by the static driver so the
  // value is technically derived from an Animation<double>.
  final double fraction = (matches / 3.0) * driver.value;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text('Permissiveness',
              style: _hSans(11.0, spec.shadow, weight: FontWeight.w700)),
          const Spacer(),
          Text('${(fraction * 100).toStringAsFixed(0)}%',
              style: _hMono(11.0, spec.shadow, weight: FontWeight.w800)),
        ],
      ),
      const SizedBox(height: 6.0),
      ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: SizedBox(
          height: 10.0,
          child: Stack(
            children: <Widget>[
              Container(
                  color: spec.glow.withValues(alpha: 0.15)),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        spec.glow,
                        spec.shadow,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Helper: a single recipe card. The code lives in a dark code-block, the
// title and subtitle on a soft gradient.
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
// Helper: a single pitfall row. Bold title on top, prose underneath.
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
// Helper: a green check / red dash glyph used in the shortcut comparison
// table. The colour is parameterised so each column matches its KeyboardSide.
// ---------------------------------------------------------------------------
Widget _booleanGlyph(bool ok, Color color) {
  return Container(
    width: 28.0,
    height: 28.0,
    decoration: BoxDecoration(
      color: ok ? color.withValues(alpha: 0.18) : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: ok ? color : Colors.grey.shade400,
      ),
    ),
    alignment: Alignment.center,
    child: Icon(
      ok ? Icons.check : Icons.remove,
      size: 16.0,
      color: ok ? color : Colors.grey.shade500,
    ),
  );
}

// ---------------------------------------------------------------------------
// Spec for a "shortcut case" — represents a hypothetical event used by the
// shortcut comparison table.
// ---------------------------------------------------------------------------
class _ShortcutCase {
  const _ShortcutCase(
    this.label, {
    required this.leftPressed,
    required this.rightPressed,
  });

  final String label;
  final bool leftPressed;
  final bool rightPressed;

  // Returns true when this event would be matched by `isModifierPressed` with
  // the given KeyboardSide. Mirrors the SDK's documented semantics.
  bool matches(KeyboardSide side) {
    switch (side) {
      case KeyboardSide.any:
        return leftPressed || rightPressed;
      case KeyboardSide.left:
        return leftPressed && !rightPressed;
      case KeyboardSide.right:
        return rightPressed && !leftPressed;
      case KeyboardSide.all:
        return leftPressed && rightPressed;
    }
  }
}
