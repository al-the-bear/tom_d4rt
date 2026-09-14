// WidgetStateBorderSide — deep visual demo (d4rt AST harness).
//
// Theme: Tailor's Workshop. A mood of chalk-blue fabric, ivory muslin,
// charcoal pinstripes, and brass button accents. Borders are bolts of
// fabric whose selvage changes thickness, colour and style depending on
// how the garment is being handled — hovered like a shoulder being
// measured, pressed like a buttonhole being stitched, focused like a
// lapel under the tailor's lens.
//
// Class under study:
//   abstract class WidgetStateBorderSide
//       extends BorderSide
//       implements WidgetStateProperty<BorderSide?>
//
// Factories:
//   WidgetStateBorderSide.resolveWith((Set<WidgetState> states) => ... )
//   WidgetStateBorderSide.fromMap(<WidgetStatesConstraint, BorderSide?>{...})
//
// Primary contract:
//   BorderSide? resolve(Set<WidgetState> states);
//
// This file is a single top-level `build(BuildContext)` entry point for
// d4rt; it must not define `main()` or call `runApp`. Every widget is
// authored by hand with the `_Wsbs` prefix.

import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ═════════════════════════════════════════════════════════════════════════
//  PALETTE — Tailor's Workshop
// ═════════════════════════════════════════════════════════════════════════

const Color _wsbsIvory = Color(0xFFF4EFE6);
const Color _wsbsMuslin = Color(0xFFECE4D2);
const Color _wsbsChalk = Color(0xFFBFD3E0);
const Color _wsbsChalkDeep = Color(0xFF4F6B7F);
const Color _wsbsCharcoal = Color(0xFF2A2E33);
const Color _wsbsPinstripe = Color(0xFF1B1F24);
const Color _wsbsBrass = Color(0xFFB08D57);
const Color _wsbsBrassLight = Color(0xFFD9B382);
const Color _wsbsBrassDark = Color(0xFF8B6B3D);
const Color _wsbsThreadRed = Color(0xFFB23A48);
const Color _wsbsThreadGreen = Color(0xFF3E7D5B);
const Color _wsbsThreadGold = Color(0xFFC8A95A);
const Color _wsbsInk = Color(0xFF141618);
const Color _wsbsParchment = Color(0xFFF8F2E4);
const Color _wsbsShadow = Color(0x332A2E33);

// ═════════════════════════════════════════════════════════════════════════
//  TEXT STYLES
// ═════════════════════════════════════════════════════════════════════════

const TextStyle _wsbsTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: _wsbsIvory,
  letterSpacing: 0.6,
);

const TextStyle _wsbsSubtitleStyle = TextStyle(
  fontSize: 12,
  color: Color(0xDDF4EFE6),
  letterSpacing: 0.3,
);

const TextStyle _wsbsSectionHead = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w800,
  color: _wsbsCharcoal,
  letterSpacing: 0.5,
);

const TextStyle _wsbsBody = TextStyle(
  fontSize: 12,
  color: _wsbsInk,
  height: 1.45,
);

const TextStyle _wsbsMono = TextStyle(
  fontSize: 11,
  color: _wsbsParchment,
  fontFamily: 'monospace',
  height: 1.55,
);

const TextStyle _wsbsLabelSmall = TextStyle(
  fontSize: 10,
  color: _wsbsCharcoal,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.8,
);

const TextStyle _wsbsSwatchName = TextStyle(
  fontSize: 11,
  color: _wsbsInk,
  fontWeight: FontWeight.w700,
);

// ═════════════════════════════════════════════════════════════════════════
//  CUSTOM PAINTER — pinstripe weave background
// ═════════════════════════════════════════════════════════════════════════

class _WsbsPinstripePainter extends CustomPainter {
  const _WsbsPinstripePainter({
    this.stripeColor = _wsbsPinstripe,
    this.background = _wsbsMuslin,
    this.stripeSpacing = 10.0,
    this.stripeWidth = 0.7,
  }) : weave = true;

  final Color stripeColor;
  final Color background;
  final double stripeSpacing;
  final double stripeWidth;
  final bool weave;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = background;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint stripe = Paint()
      ..color = stripeColor.withValues(alpha: 0.35)
      ..strokeWidth = stripeWidth;

    // Diagonal pinstripes left-to-right.
    for (double x = -size.height; x < size.width; x += stripeSpacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        stripe,
      );
    }
    if (weave) {
      final Paint counter = Paint()
        ..color = stripeColor.withValues(alpha: 0.18)
        ..strokeWidth = stripeWidth;
      for (double x = 0; x < size.width + size.height; x += stripeSpacing) {
        canvas.drawLine(
          Offset(x, 0),
          Offset(x - size.height, size.height),
          counter,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WsbsPinstripePainter oldDelegate) {
    return oldDelegate.stripeColor != stripeColor ||
        oldDelegate.background != background ||
        oldDelegate.stripeSpacing != stripeSpacing ||
        oldDelegate.stripeWidth != stripeWidth ||
        oldDelegate.weave != weave;
  }
}

// A secondary painter: tailor's chalk marks (tiny tick pattern).
class _WsbsChalkMarksPainter extends CustomPainter {
  const _WsbsChalkMarksPainter({this.density = 18});

  final int density;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint chalk = Paint()
      ..color = _wsbsChalk.withValues(alpha: 0.55)
      ..strokeWidth = 1.2;
    final math.Random rng = math.Random(7);
    for (int i = 0; i < density; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      final double len = 4 + rng.nextDouble() * 8;
      canvas.drawLine(Offset(x, y), Offset(x + len, y + len * 0.25), chalk);
    }
  }

  @override
  bool shouldRepaint(covariant _WsbsChalkMarksPainter oldDelegate) => false;
}

// ═════════════════════════════════════════════════════════════════════════
//  HELPER — section frame
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsFrame({
  required String title,
  String? subtitle,
  required Widget child,
  Color titleBar = _wsbsCharcoal,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: _wsbsIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wsbsCharcoal.withValues(alpha: 0.25)),
      boxShadow: const [
        BoxShadow(
          color: _wsbsShadow,
          offset: Offset(0, 2),
          blurRadius: 6,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [titleBar, titleBar.withValues(alpha: 0.75)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _wsbsTitleStyle),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle, style: _wsbsSubtitleStyle),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: child,
        ),
      ],
    ),
  );
}

Widget _wsbsBullet(String text, {Color dot = _wsbsBrass}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8),
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              border: Border.all(color: _wsbsBrassDark, width: 0.8),
            ),
          ),
        ),
        Expanded(child: Text(text, style: _wsbsBody)),
      ],
    ),
  );
}

Widget _wsbsCode(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _wsbsInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _wsbsBrassDark.withValues(alpha: 0.6)),
    ),
    child: Text(code, style: _wsbsMono),
  );
}

Widget _wsbsChip(String label, {Color color = _wsbsBrass, bool filled = true}) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: filled ? color.withValues(alpha: 0.18) : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color, width: 1.1),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        color: filled ? _wsbsCharcoal : color,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _wsbsDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _wsbsBrass.withValues(alpha: 0.0),
          _wsbsBrass.withValues(alpha: 0.6),
          _wsbsBrass.withValues(alpha: 0.0),
        ],
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 1 — DOSSIER / PREAMBLE
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsDossierCard1() {
  return _wsbsFrame(
    title: 'Dossier 1 · What is WidgetStateBorderSide?',
    subtitle: 'A BorderSide whose appearance depends on widget state.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WidgetStateBorderSide is an abstract subclass of BorderSide that '
          'also implements WidgetStateProperty<BorderSide?>. Where a plain '
          'BorderSide is a static seam, WidgetStateBorderSide is a tailor\'s '
          'measuring tape: a single description whose width, colour and '
          'style reshape themselves to match whichever WidgetState set is '
          'currently active on the widget.',
          style: _wsbsBody,
        ),
        _wsbsDivider(),
        _wsbsBullet('Lives in package:flutter/src/widgets/widget_state.dart'),
        _wsbsBullet('Re-exported through widgets.dart and material.dart'),
        _wsbsBullet('Consumed by ChipThemeData.side, OutlinedButton, '
            'ToggleButtons.borderSide, and any stateful border surface.'),
        _wsbsBullet('Returned values may be null — meaning "fall back to '
            'the widget\'s default border for this state".'),
      ],
    ),
  );
}

Widget _wsbsDossierCard2() {
  return _wsbsFrame(
    title: 'Dossier 2 · The WidgetStateProperty family',
    subtitle: 'Where borders join colours, cursors, and text styles.',
    titleBar: _wsbsChalkDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter ships a family of state-aware property classes. Each one '
          'follows the same pattern: resolve a Set<WidgetState> into a '
          'concrete piece of styling. WidgetStateBorderSide is the border '
          'specialist in that family.',
          style: _wsbsBody,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: [
            _wsbsChip('WidgetStateColor'),
            _wsbsChip('WidgetStateTextStyle'),
            _wsbsChip('WidgetStateMouseCursor'),
            _wsbsChip('WidgetStateOutlinedBorder'),
            _wsbsChip('WidgetStateBorderSide', color: _wsbsThreadRed),
            _wsbsChip('WidgetStatePropertyAll'),
          ],
        ),
        _wsbsDivider(),
        _wsbsBullet('All of them return T or T? from resolve(states).'),
        _wsbsBullet('WidgetStateBorderSide returns BorderSide?.'),
        _wsbsBullet('A null return signals "use the widget default".'),
      ],
    ),
  );
}

Widget _wsbsDossierCard3() {
  return _wsbsFrame(
    title: 'Dossier 3 · The eight WidgetState values',
    subtitle: 'The seams that react to user gestures.',
    titleBar: _wsbsBrassDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A Set<WidgetState> is what the widget feeds to resolve(). These '
          'are the eight values your border can react to. Most real widgets '
          'only raise a subset at any moment.',
          style: _wsbsBody,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: [
            _wsbsChip('hovered', color: _wsbsThreadGreen),
            _wsbsChip('focused', color: _wsbsChalkDeep),
            _wsbsChip('pressed', color: _wsbsThreadRed),
            _wsbsChip('dragged', color: _wsbsBrass),
            _wsbsChip('selected', color: _wsbsThreadGold),
            _wsbsChip('scrolledUnder', color: _wsbsCharcoal),
            _wsbsChip('disabled', color: _wsbsChalkDeep),
            _wsbsChip('error', color: _wsbsThreadRed),
          ],
        ),
      ],
    ),
  );
}

Widget _wsbsDossierCard4() {
  return _wsbsFrame(
    title: 'Dossier 4 · Two factory constructors, one mission',
    subtitle: 'resolveWith for code, fromMap for tables.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You rarely subclass WidgetStateBorderSide yourself. Instead you '
          'call one of its two factories. resolveWith takes an arbitrary '
          'function from Set<WidgetState> to BorderSide?; fromMap takes a '
          'map from WidgetStatesConstraint to BorderSide? and picks the '
          'first matching key.',
          style: _wsbsBody,
        ),
        _wsbsCode('WidgetStateBorderSide.resolveWith(\n'
            '  (Set<WidgetState> states) {\n'
            '    if (states.contains(WidgetState.error)) {\n'
            '      return const BorderSide(color: Colors.red, width: 2);\n'
            '    }\n'
            '    if (states.contains(WidgetState.pressed)) {\n'
            '      return const BorderSide(color: Colors.black, width: 3);\n'
            '    }\n'
            '    return const BorderSide(color: Colors.grey);\n'
            '  },\n'
            ');'),
        _wsbsCode('WidgetStateBorderSide.fromMap(<WidgetStatesConstraint,\n'
            '    BorderSide?>{\n'
            '  WidgetState.error: BorderSide(color: Colors.red, width: 2),\n'
            '  WidgetState.pressed: BorderSide(color: Colors.black, width:3),\n'
            '  WidgetState.any: BorderSide(color: Colors.grey),\n'
            '});'),
      ],
    ),
  );
}

Widget _wsbsDossierCard5() {
  return _wsbsFrame(
    title: 'Dossier 5 · The resolve contract',
    subtitle: 'A single method carries the whole abstraction.',
    titleBar: _wsbsChalkDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Every WidgetStateBorderSide has exactly one operational method. '
          'Widgets call it whenever their state set changes; the returned '
          'BorderSide (or null) is what they paint.',
          style: _wsbsBody,
        ),
        _wsbsCode('BorderSide? resolve(Set<WidgetState> states);'),
        _wsbsBullet('Called on every relevant state transition.'),
        _wsbsBullet('Returning null means: use the widget\'s own fallback.'),
        _wsbsBullet('Implementations must be cheap: no I/O, no allocations '
            'beyond the returned BorderSide.'),
      ],
    ),
  );
}

Widget _wsbsDossierCard6() {
  return _wsbsFrame(
    title: 'Dossier 6 · Where it appears in the Material catalog',
    subtitle: 'Real widgets that will accept a WidgetStateBorderSide.',
    titleBar: _wsbsBrassDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wsbsBullet('ChipThemeData.side — per-state chip outline.'),
        _wsbsBullet('OutlinedButton.styleFrom / ButtonStyle.side — button '
            'borders that react to hover, press, focus, disabled.'),
        _wsbsBullet('ToggleButtons.borderSide (wrapped as state property).'),
        _wsbsBullet('Any custom widget that stores a '
            'WidgetStateProperty<BorderSide?> and calls resolve() itself.'),
        _wsbsDivider(),
        Text(
          'The pattern is always the same: the widget keeps its own '
          'Set<WidgetState>, and during paint or build it asks the '
          'WidgetStateBorderSide "what should I draw right now?".',
          style: _wsbsBody,
        ),
      ],
    ),
  );
}

Widget _wsbsDossierCard7() {
  return _wsbsFrame(
    title: 'Dossier 7 · When *not* to reach for it',
    subtitle: 'Sometimes a plain BorderSide is the right tool.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'If your border never changes across states, use a plain '
          'BorderSide. WidgetStateBorderSide adds a resolver indirection '
          'that is only worth it when the seam actually behaves '
          'differently for different interactions.',
          style: _wsbsBody,
        ),
        _wsbsBullet('Static card outline → plain BorderSide.'),
        _wsbsBullet('Button that changes on press/hover → WidgetState.'),
        _wsbsBullet('Chip that also toggles selected/disabled → WidgetState.'),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 2 — ANATOMY CARD
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsAnatomyCard() {
  return _wsbsFrame(
    title: 'Anatomy · class hierarchy at a glance',
    subtitle: 'Two factories, one resolver, one extend-hook.',
    titleBar: _wsbsCharcoal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The class itself is only a few lines long in the Flutter source. '
          'Its whole job is to fuse the BorderSide API with the '
          'WidgetStateProperty API so Material widgets can accept either '
          'and treat them uniformly.',
          style: _wsbsBody,
        ),
        _wsbsCode('abstract class WidgetStateBorderSide\n'
            '    extends BorderSide\n'
            '    implements WidgetStateProperty<BorderSide?> {\n'
            '  const WidgetStateBorderSide();\n'
            '\n'
            '  factory WidgetStateBorderSide.fromMap(\n'
            '    WidgetStateMap<BorderSide?> map,\n'
            '  ) = _WidgetStateBorderSideMapper;\n'
            '\n'
            '  factory WidgetStateBorderSide.resolveWith(\n'
            '    WidgetPropertyResolver<BorderSide?> callback,\n'
            '  ) = _WidgetStateBorderSide;\n'
            '\n'
            '  @override\n'
            '  BorderSide? resolve(Set<WidgetState> states);\n'
            '}'),
        _wsbsDivider(),
        Text(
          'A few points worth internalising:',
          style: _wsbsBody.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        _wsbsBullet('It *is* a BorderSide, so you can assign one into any '
            'API that expects BorderSide (thanks to the extends).'),
        _wsbsBullet('It *is also* a WidgetStateProperty<BorderSide?>, so '
            'any API that expects WidgetStateProperty<BorderSide?> also '
            'accepts one.'),
        _wsbsBullet('The two private factories (_WidgetStateBorderSide and '
            '_WidgetStateBorderSideMapper) keep the class unsealed-looking '
            'while still blocking arbitrary subclassing in practice.'),
        _wsbsBullet('resolve() can (and often should) return null — null '
            'is interpreted by consumers as "no opinion for this state".'),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 3 — LIVE PLAYGROUND
// ═════════════════════════════════════════════════════════════════════════
//
// Interactive row of swatch cards. Each card is wrapped in InkWell +
// MouseRegion + Focus + a StatefulBuilder so we can observe the
// currently-active WidgetState set without running a full widget tree
// with ButtonStyle plumbing (d4rt lifecycle limitations).

Widget _wsbsStateTag(String name, bool active, {Color color = _wsbsBrass}) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: active ? color : color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 9.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: active ? _wsbsIvory : color,
      ),
    ),
  );
}

Widget _wsbsStateRow(Set<WidgetState> states) {
  return Wrap(
    children: [
      _wsbsStateTag('HOVERED', states.contains(WidgetState.hovered),
          color: _wsbsThreadGreen),
      _wsbsStateTag('FOCUSED', states.contains(WidgetState.focused),
          color: _wsbsChalkDeep),
      _wsbsStateTag('PRESSED', states.contains(WidgetState.pressed),
          color: _wsbsThreadRed),
      _wsbsStateTag('SELECTED', states.contains(WidgetState.selected),
          color: _wsbsThreadGold),
      _wsbsStateTag('DISABLED', states.contains(WidgetState.disabled),
          color: _wsbsChalkDeep),
      _wsbsStateTag('ERROR', states.contains(WidgetState.error),
          color: _wsbsThreadRed),
    ],
  );
}

// A reusable interactive swatch wired to a resolveWith-based border.
Widget _wsbsInteractiveSwatch({
  required String name,
  required WidgetStateBorderSide side,
  required bool selected,
  required bool disabled,
  required bool error,
  required ValueChanged<bool> onToggleSelected,
}) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      bool hovered = false;
      bool pressed = false;
      bool focused = false;

      Set<WidgetState> statesOf() {
        final Set<WidgetState> out = <WidgetState>{};
        if (hovered) out.add(WidgetState.hovered);
        if (pressed) out.add(WidgetState.pressed);
        if (focused) out.add(WidgetState.focused);
        if (selected) out.add(WidgetState.selected);
        if (disabled) out.add(WidgetState.disabled);
        if (error) out.add(WidgetState.error);
        return out;
      }

      return StatefulBuilder(
        builder: (BuildContext innerCtx, StateSetter innerSet) {
          final Set<WidgetState> currentStates = statesOf();
          final BorderSide? resolved = side.resolve(currentStates);
          return MouseRegion(
            onEnter: (PointerEnterEvent evt) {
              innerSet(() {
                hovered = true;
              });
            },
            onExit: (PointerExitEvent evt) {
              innerSet(() {
                hovered = false;
                pressed = false;
              });
            },
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                innerSet(() {
                  pressed = true;
                });
              },
              onTapUp: (TapUpDetails details) {
                innerSet(() {
                  pressed = false;
                  focused = !focused;
                });
                onToggleSelected(!selected);
              },
              onTapCancel: () {
                innerSet(() {
                  pressed = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 210,
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: disabled
                      ? _wsbsMuslin.withValues(alpha: 0.55)
                      : _wsbsParchment,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.fromBorderSide(
                    resolved ??
                        const BorderSide(color: _wsbsCharcoal, width: 1),
                  ),
                  boxShadow: pressed
                      ? const []
                      : const [
                          BoxShadow(
                            color: _wsbsShadow,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: _wsbsSwatchName),
                    const SizedBox(height: 6),
                    _wsbsStateRow(currentStates),
                    const SizedBox(height: 6),
                    Text(
                      resolved == null
                          ? 'resolve → null (fallback)'
                          : 'width: ${resolved.width.toStringAsFixed(1)}  '
                              'style: ${resolved.style.name}',
                      style: _wsbsLabelSmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// The outer playground owns the "persistent" selected/disabled/error flags
// so they can be toggled independently from pointer-driven states.
Widget _wsbsPlayground() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      final List<bool> selected = <bool>[false, false, false];
      bool disabled = false;
      bool error = false;

      final WidgetStateBorderSide tailorSide =
          WidgetStateBorderSide.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: _wsbsChalkDeep.withValues(alpha: 0.35),
              width: 1,
              style: BorderStyle.solid,
            );
          }
          if (states.contains(WidgetState.error)) {
            return const BorderSide(color: _wsbsThreadRed, width: 2.6);
          }
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(color: _wsbsInk, width: 3);
          }
          if (states.contains(WidgetState.focused)) {
            return const BorderSide(color: _wsbsChalkDeep, width: 2.4);
          }
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: _wsbsBrass, width: 2);
          }
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(color: _wsbsThreadGold, width: 2.2);
          }
          return const BorderSide(color: _wsbsCharcoal, width: 1);
        },
      );

      return _wsbsFrame(
        title: 'Playground · live resolveWith',
        subtitle:
            'Hover, tap or toggle. Watch the border react to each state.',
        titleBar: _wsbsChalkDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('disabled', style: _wsbsBody),
                    value: disabled,
                    onChanged: (bool v) {
                      setState(() {
                        disabled = v;
                      });
                    },
                    activeThumbColor: _wsbsBrass,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('error', style: _wsbsBody),
                    value: error,
                    onChanged: (bool v) {
                      setState(() {
                        error = v;
                      });
                    },
                    activeThumbColor: _wsbsThreadRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              children: <Widget>[
                _wsbsInteractiveSwatch(
                  name: 'Chalk-blue Worsted',
                  side: tailorSide,
                  selected: selected[0],
                  disabled: disabled,
                  error: error,
                  onToggleSelected: (bool v) {
                    setState(() {
                      selected[0] = v;
                    });
                  },
                ),
                _wsbsInteractiveSwatch(
                  name: 'Ivory Linen',
                  side: tailorSide,
                  selected: selected[1],
                  disabled: disabled,
                  error: error,
                  onToggleSelected: (bool v) {
                    setState(() {
                      selected[1] = v;
                    });
                  },
                ),
                _wsbsInteractiveSwatch(
                  name: 'Charcoal Flannel',
                  side: tailorSide,
                  selected: selected[2],
                  disabled: disabled,
                  error: error,
                  onToggleSelected: (bool v) {
                    setState(() {
                      selected[2] = v;
                    });
                  },
                ),
              ],
            ),
            _wsbsDivider(),
            Text(
              'Notice how the same WidgetStateBorderSide instance is shared '
              'across all three swatches. The resolver is pure — it reacts '
              'to whatever Set<WidgetState> each swatch passes in, which is '
              'why these cards can share one definition but render '
              'independently.',
              style: _wsbsBody,
            ),
          ],
        ),
      );
    },
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 4 — fromMap vs resolveWith COMPARISON
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsComparePanel({
  required String title,
  required String subtitle,
  required String codeBlob,
  required WidgetStateBorderSide side,
  required Color accent,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _wsbsParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: _wsbsSectionHead.copyWith(color: accent)),
                const SizedBox(height: 2),
                Text(subtitle, style: _wsbsLabelSmall),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _wsbsCode(codeBlob),
                const SizedBox(height: 6),
                _wsbsInteractiveSwatch(
                  name: 'Demo swatch',
                  side: side,
                  selected: false,
                  disabled: false,
                  error: false,
                  onToggleSelected: (bool v) {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _wsbsComparison() {
  // fromMap: declarative, evaluated in declaration order; first match wins.
  final WidgetStateBorderSide mapSide =
      WidgetStateBorderSide.fromMap(<WidgetStatesConstraint, BorderSide?>{
    WidgetState.error: const BorderSide(color: _wsbsThreadRed, width: 2.4),
    WidgetState.disabled: BorderSide(
      color: _wsbsChalkDeep.withValues(alpha: 0.35),
      width: 1,
    ),
    WidgetState.pressed: const BorderSide(color: _wsbsInk, width: 3),
    WidgetState.focused: const BorderSide(color: _wsbsChalkDeep, width: 2.2),
    WidgetState.hovered: const BorderSide(color: _wsbsBrass, width: 2),
    WidgetState.selected: const BorderSide(color: _wsbsThreadGold, width: 2),
    WidgetState.any: const BorderSide(color: _wsbsCharcoal, width: 1),
  });

  // resolveWith: arbitrary function, can be non-linear / composite.
  final WidgetStateBorderSide codeSide = WidgetStateBorderSide.resolveWith(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.error)) {
        return const BorderSide(color: _wsbsThreadRed, width: 2.4);
      }
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(
          color: _wsbsChalkDeep.withValues(alpha: 0.35),
          width: 1,
        );
      }
      // Composite: pressed + selected yields a thicker brass-gold band.
      if (states.contains(WidgetState.pressed) &&
          states.contains(WidgetState.selected)) {
        return const BorderSide(color: _wsbsBrassDark, width: 3.4);
      }
      if (states.contains(WidgetState.pressed)) {
        return const BorderSide(color: _wsbsInk, width: 3);
      }
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: _wsbsChalkDeep, width: 2.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return const BorderSide(color: _wsbsBrass, width: 2);
      }
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: _wsbsThreadGold, width: 2);
      }
      return const BorderSide(color: _wsbsCharcoal, width: 1);
    },
  );

  return _wsbsFrame(
    title: 'Comparison · fromMap  vs  resolveWith',
    subtitle:
        'Two factories, same visual result — choose by your ergonomics.',
    titleBar: _wsbsBrassDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Both factories produce a WidgetStateBorderSide. fromMap reads '
          'like a style-sheet — ideal for flat, mutually-exclusive rules. '
          'resolveWith gives you the full power of Dart — ideal when you '
          'need composite reactions (e.g. pressed+selected producing a '
          'different seam than either alone).',
          style: _wsbsBody,
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wsbsComparePanel(
              title: 'fromMap',
              subtitle: 'First matching constraint wins, top-down.',
              codeBlob: 'WidgetStateBorderSide.fromMap({\n'
                  '  WidgetState.error:   BorderSide(red,   w:2.4),\n'
                  '  WidgetState.disabled:BorderSide(chalk, w:1.0),\n'
                  '  WidgetState.pressed: BorderSide(ink,   w:3.0),\n'
                  '  WidgetState.focused: BorderSide(chalk, w:2.2),\n'
                  '  WidgetState.hovered: BorderSide(brass, w:2.0),\n'
                  '  WidgetState.selected:BorderSide(gold,  w:2.0),\n'
                  '  WidgetState.any:     BorderSide(coal,  w:1.0),\n'
                  '});',
              side: mapSide,
              accent: _wsbsChalkDeep,
            ),
            _wsbsComparePanel(
              title: 'resolveWith',
              subtitle: 'Arbitrary logic — composites and computed widths.',
              codeBlob: 'WidgetStateBorderSide.resolveWith((states) {\n'
                  '  if (states.contains(error)) return red;\n'
                  '  if (states.contains(disabled)) return faint;\n'
                  '  if (pressed && selected) return brassDark;\n'
                  '  if (pressed)  return ink;\n'
                  '  if (focused)  return chalk;\n'
                  '  if (hovered)  return brass;\n'
                  '  if (selected) return gold;\n'
                  '  return coal;\n'
                  '});',
              side: codeSide,
              accent: _wsbsBrassDark,
            ),
          ],
        ),
        _wsbsDivider(),
        _wsbsBullet('fromMap is easier to audit visually; reviewers can scan '
            'the table of constraints.'),
        _wsbsBullet('resolveWith handles *interactions* between states (e.g. '
            'pressed AND selected) far more naturally.'),
        _wsbsBullet('Pick fromMap when rules are mutually exclusive; pick '
            'resolveWith when rules compose or depend on computed values.'),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 5 — SWATCH BOOK
// ═════════════════════════════════════════════════════════════════════════

class _WsbsSwatchSpec {
  const _WsbsSwatchSpec({
    required this.label,
    required this.subtitle,
    required this.states,
    required this.backdrop,
  });
  final String label;
  final String subtitle;
  final Set<WidgetState> states;
  final Color backdrop;
}

Widget _wsbsSwatchCard(
  _WsbsSwatchSpec spec,
  WidgetStateBorderSide side,
) {
  final BorderSide? resolved = side.resolve(spec.states);
  final BorderSide effective =
      resolved ?? const BorderSide(color: _wsbsCharcoal, width: 1);
  return Container(
    width: 170,
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: spec.backdrop,
      borderRadius: BorderRadius.circular(8),
      border: Border.fromBorderSide(effective),
      boxShadow: const [
        BoxShadow(
          color: _wsbsShadow,
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(spec.label,
              style: _wsbsSwatchName.copyWith(color: _wsbsInk)),
          const SizedBox(height: 2),
          Text(spec.subtitle, style: _wsbsLabelSmall),
          const SizedBox(height: 8),
          _wsbsStateRow(spec.states),
          const SizedBox(height: 6),
          Text(
            'w:${effective.width.toStringAsFixed(1)}  '
            'style:${effective.style.name}',
            style: _wsbsLabelSmall.copyWith(
                color: _wsbsCharcoal, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

Widget _wsbsSwatchBook() {
  // A single resolveWith shared by the entire swatch book.
  final WidgetStateBorderSide book = WidgetStateBorderSide.resolveWith(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.error)) {
        return const BorderSide(color: _wsbsThreadRed, width: 2.6);
      }
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(
            color: _wsbsChalkDeep.withValues(alpha: 0.35), width: 1);
      }
      if (states.contains(WidgetState.pressed) &&
          states.contains(WidgetState.focused)) {
        return const BorderSide(color: _wsbsInk, width: 3.5);
      }
      if (states.contains(WidgetState.pressed)) {
        return const BorderSide(color: _wsbsInk, width: 3);
      }
      if (states.contains(WidgetState.hovered) &&
          states.contains(WidgetState.selected)) {
        return const BorderSide(color: _wsbsBrassDark, width: 2.8);
      }
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: _wsbsThreadGold, width: 2.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return const BorderSide(color: _wsbsBrass, width: 2);
      }
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: _wsbsChalkDeep, width: 2.4);
      }
      if (states.contains(WidgetState.dragged)) {
        return const BorderSide(color: _wsbsThreadGreen, width: 2.0);
      }
      if (states.contains(WidgetState.scrolledUnder)) {
        return BorderSide(
            color: _wsbsCharcoal.withValues(alpha: 0.6), width: 1.4);
      }
      return const BorderSide(color: _wsbsCharcoal, width: 1);
    },
  );

  final List<_WsbsSwatchSpec> specs = <_WsbsSwatchSpec>[
    const _WsbsSwatchSpec(
      label: 'Idle',
      subtitle: 'No states set.',
      states: <WidgetState>{},
      backdrop: _wsbsParchment,
    ),
    const _WsbsSwatchSpec(
      label: 'Hovered',
      subtitle: 'Cursor is over the surface.',
      states: <WidgetState>{WidgetState.hovered},
      backdrop: _wsbsParchment,
    ),
    const _WsbsSwatchSpec(
      label: 'Focused',
      subtitle: 'Keyboard focus on the widget.',
      states: <WidgetState>{WidgetState.focused},
      backdrop: _wsbsParchment,
    ),
    const _WsbsSwatchSpec(
      label: 'Pressed',
      subtitle: 'User is actively tapping.',
      states: <WidgetState>{WidgetState.pressed},
      backdrop: _wsbsParchment,
    ),
    const _WsbsSwatchSpec(
      label: 'Selected',
      subtitle: 'Chip or button is toggled on.',
      states: <WidgetState>{WidgetState.selected},
      backdrop: _wsbsIvory,
    ),
    const _WsbsSwatchSpec(
      label: 'Hovered + Selected',
      subtitle: 'Composite state, thicker selvage.',
      states: <WidgetState>{WidgetState.hovered, WidgetState.selected},
      backdrop: _wsbsIvory,
    ),
    const _WsbsSwatchSpec(
      label: 'Pressed + Focused',
      subtitle: 'Keyboard-driven activation.',
      states: <WidgetState>{WidgetState.pressed, WidgetState.focused},
      backdrop: _wsbsIvory,
    ),
    const _WsbsSwatchSpec(
      label: 'Dragged',
      subtitle: 'Being moved; seams loosen.',
      states: <WidgetState>{WidgetState.dragged},
      backdrop: _wsbsMuslin,
    ),
    const _WsbsSwatchSpec(
      label: 'Scrolled under',
      subtitle: 'Surface hidden by app bar etc.',
      states: <WidgetState>{WidgetState.scrolledUnder},
      backdrop: _wsbsMuslin,
    ),
    const _WsbsSwatchSpec(
      label: 'Disabled',
      subtitle: 'Widget cannot be interacted with.',
      states: <WidgetState>{WidgetState.disabled},
      backdrop: _wsbsMuslin,
    ),
    const _WsbsSwatchSpec(
      label: 'Error',
      subtitle: 'Form validation failed.',
      states: <WidgetState>{WidgetState.error},
      backdrop: _wsbsParchment,
    ),
    const _WsbsSwatchSpec(
      label: 'Error + Disabled',
      subtitle: 'Disabled short-circuits error in this resolver.',
      states: <WidgetState>{WidgetState.error, WidgetState.disabled},
      backdrop: _wsbsMuslin,
    ),
  ];

  return _wsbsFrame(
    title: 'Swatch book · state ↦ border mapping',
    subtitle: 'Twelve annotated swatches from the same resolver.',
    titleBar: _wsbsBrassDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Each swatch feeds a specific Set<WidgetState> into the shared '
          'resolveWith callback above. No pointer events are involved — '
          'this is the pure, inspectable mapping from state to seam.',
          style: _wsbsBody,
        ),
        const SizedBox(height: 8),
        Wrap(
          children:
              specs.map((_WsbsSwatchSpec s) => _wsbsSwatchCard(s, book))
                  .toList(),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 6 — CHIP THEME SHOWCASE
// ═════════════════════════════════════════════════════════════════════════

class _WsbsChipSpec {
  const _WsbsChipSpec(this.label, this.icon);
  final String label;
  final IconData icon;
}

Widget _wsbsChipTheme() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      final List<_WsbsChipSpec> specs = <_WsbsChipSpec>[
        const _WsbsChipSpec('Wool', Icons.grass),
        const _WsbsChipSpec('Linen', Icons.waves),
        const _WsbsChipSpec('Silk', Icons.auto_awesome),
        const _WsbsChipSpec('Tweed', Icons.texture),
        const _WsbsChipSpec('Velvet', Icons.cloud),
        const _WsbsChipSpec('Denim', Icons.layers),
      ];
      final List<bool> picked = <bool>[false, true, false, true, false, false];
      bool disabled = false;

      final WidgetStateBorderSide chipSide =
          WidgetStateBorderSide.fromMap(<WidgetStatesConstraint, BorderSide?>{
        WidgetState.disabled: BorderSide(
            color: _wsbsChalkDeep.withValues(alpha: 0.3), width: 1),
        WidgetState.selected & WidgetState.hovered:
            const BorderSide(color: _wsbsBrassDark, width: 2.6),
        WidgetState.selected:
            const BorderSide(color: _wsbsThreadGold, width: 2),
        WidgetState.hovered:
            const BorderSide(color: _wsbsBrass, width: 1.8),
        WidgetState.focused:
            const BorderSide(color: _wsbsChalkDeep, width: 2),
        WidgetState.any:
            const BorderSide(color: _wsbsCharcoal, width: 1),
      });

      final ChipThemeData chipTheme = ChipThemeData(
        side: chipSide,
        showCheckmark: true,
        checkmarkColor: _wsbsBrassDark,
        selectedColor: _wsbsBrass.withValues(alpha: 0.25),
        backgroundColor: _wsbsParchment,
        disabledColor: _wsbsMuslin,
        labelStyle: const TextStyle(
          color: _wsbsInk,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );

      return _wsbsFrame(
        title: 'Chip theme · ChipThemeData(side: WidgetStateBorderSide)',
        subtitle:
            'A single theme controls outlines for a whole row of chips.',
        titleBar: _wsbsChalkDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The chips below all inherit the same ChipThemeData. The side '
              'field carries a WidgetStateBorderSide.fromMap, so each chip '
              'picks the right border for its own current states.',
              style: _wsbsBody,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: const Text('Disable all chips', style: _wsbsBody),
              value: disabled,
              onChanged: (bool v) {
                setState(() {
                  disabled = v;
                });
              },
              activeThumbColor: _wsbsBrass,
            ),
            const SizedBox(height: 8),
            Theme(
              data: Theme.of(context).copyWith(chipTheme: chipTheme),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List<Widget>.generate(specs.length,
                    (int idx) {
                  final _WsbsChipSpec spec = specs[idx];
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(spec.icon, size: 14, color: _wsbsCharcoal),
                        const SizedBox(width: 4),
                        Text(spec.label),
                      ],
                    ),
                    selected: picked[idx],
                    onSelected: disabled
                        ? null
                        : (bool v) {
                            setState(() {
                              picked[idx] = v;
                            });
                          },
                  );
                }),
              ),
            ),
            _wsbsDivider(),
            Text(
              'Selected chips use a brass-gold seam; hovering a selected '
              'chip thickens it further thanks to the combined constraint '
              'WidgetState.selected & WidgetState.hovered.',
              style: _wsbsBody,
            ),
            const SizedBox(height: 6),
            Wrap(children: <Widget>[
              for (int i = 0; i < specs.length; i++)
                _wsbsChip(
                  '${specs[i].label}: ${picked[i] ? "picked" : "plain"}',
                  color: picked[i] ? _wsbsBrassDark : _wsbsCharcoal,
                  filled: picked[i],
                ),
            ]),
          ],
        ),
      );
    },
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 7 — WIDTH-AND-STYLE ANIMATION (TweenAnimationBuilder)
// ═════════════════════════════════════════════════════════════════════════
//
// We avoid AnimationController + late init (d4rt lifecycle limitation)
// and use TweenAnimationBuilder to drive a synthetic "level" value from
// 0 to 1. That level is translated into a Set<WidgetState> with
// progressively stronger members, fed into a WidgetStateBorderSide, and
// the resolved BorderSide is drawn in a boxed panel.

Set<WidgetState> _wsbsLevelToStates(double level) {
  final Set<WidgetState> out = <WidgetState>{};
  if (level > 0.15) out.add(WidgetState.hovered);
  if (level > 0.40) out.add(WidgetState.focused);
  if (level > 0.65) out.add(WidgetState.selected);
  if (level > 0.88) out.add(WidgetState.pressed);
  return out;
}

Widget _wsbsAnimatedSweep() {
  final WidgetStateBorderSide sweepSide =
      WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
    double width = 1;
    Color color = _wsbsCharcoal;
    BorderStyle style = BorderStyle.solid;
    if (states.contains(WidgetState.hovered)) {
      width = 1.6;
      color = _wsbsBrass;
    }
    if (states.contains(WidgetState.focused)) {
      width = 2.2;
      color = _wsbsChalkDeep;
    }
    if (states.contains(WidgetState.selected)) {
      width = 2.8;
      color = _wsbsThreadGold;
    }
    if (states.contains(WidgetState.pressed)) {
      width = 3.6;
      color = _wsbsInk;
      style = BorderStyle.solid;
    }
    return BorderSide(color: color, width: width, style: style);
  });

  return _wsbsFrame(
    title: 'Animation · width sweep via TweenAnimationBuilder',
    subtitle:
        'Synthesises a "level" state driving hover → focus → select → press.',
    titleBar: _wsbsCharcoal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenAnimationBuilder drives a value from 0.0 to 1.0 and back. '
          'We quantise that value into a Set<WidgetState>, then feed it '
          'through a WidgetStateBorderSide.resolveWith. The resolver is '
          'agnostic — it only sees a state set, not an animation.',
          style: _wsbsBody,
        ),
        const SizedBox(height: 10),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 4),
          curve: Curves.easeInOut,
          builder: (BuildContext context, double value, Widget? child) {
            // bounce: 0→1→0
            final double level = value < 0.5 ? value * 2 : (1 - value) * 2;
            final Set<WidgetState> states = _wsbsLevelToStates(level);
            final BorderSide? resolved = sweepSide.resolve(states);
            final BorderSide effective =
                resolved ?? const BorderSide(color: _wsbsCharcoal);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _wsbsParchment,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.fromBorderSide(effective),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'level = ${level.toStringAsFixed(2)}   '
                    'width = ${effective.width.toStringAsFixed(2)}',
                    style: _wsbsBody.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 8),
                _wsbsStateRow(states),
                const SizedBox(height: 8),
                _wsbsProgressBar(level),
              ],
            );
          },
        ),
        _wsbsDivider(),
        _wsbsBullet('Real apps would hand a real Set<WidgetState> to '
            'resolve — this demo just fabricates one from a tween to make '
            'the border\'s reaction visible without user interaction.'),
        _wsbsBullet('Notice how width, colour and (optionally) style all '
            'change as the state set grows.'),
      ],
    ),
  );
}

Widget _wsbsProgressBar(double level) {
  return Container(
    height: 10,
    decoration: BoxDecoration(
      color: _wsbsMuslin,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: _wsbsCharcoal.withValues(alpha: 0.3)),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: level.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_wsbsBrass, _wsbsBrassDark],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 8 — RECIPE CARDS
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsRecipeCard({
  required String title,
  required String pitch,
  required String code,
  required BorderSide sample,
  required Color accent,
}) {
  return Container(
    width: 340,
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _wsbsParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                border: Border.all(color: _wsbsInk, width: 0.8),
                boxShadow: const [
                  BoxShadow(
                    color: _wsbsShadow,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: _wsbsSectionHead.copyWith(color: accent)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(pitch, style: _wsbsBody),
        const SizedBox(height: 8),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: _wsbsIvory,
            borderRadius: BorderRadius.circular(6),
            border: Border.fromBorderSide(sample),
          ),
          alignment: Alignment.center,
          child: Text(
            'w:${sample.width.toStringAsFixed(1)} · '
            '${sample.color.toString().split('(').last.replaceAll(')', '')}',
            style: _wsbsLabelSmall,
          ),
        ),
        _wsbsCode(code),
      ],
    ),
  );
}

Widget _wsbsRecipes() {
  return _wsbsFrame(
    title: 'Recipes · five classic WidgetStateBorderSide patterns',
    subtitle: 'Copy-paste-adapt for your own tailoring.',
    titleBar: _wsbsBrassDark,
    child: Wrap(
      children: <Widget>[
        _wsbsRecipeCard(
          title: '1 · Outlined button default',
          pitch:
              'A thin charcoal seam that thickens on hover and darkens on '
              'press — the classic OutlinedButton feel, but explicit.',
          sample: const BorderSide(color: _wsbsCharcoal, width: 1),
          code: 'WidgetStateBorderSide.resolveWith((s) {\n'
              '  if (s.contains(WidgetState.pressed)) {\n'
              '    return const BorderSide(color: Colors.black, width:2);\n'
              '  }\n'
              '  if (s.contains(WidgetState.hovered)) {\n'
              '    return const BorderSide(color: Colors.black, width:1.6);\n'
              '  }\n'
              '  return const BorderSide(color: Colors.black54, width:1);\n'
              '});',
          accent: _wsbsCharcoal,
        ),
        _wsbsRecipeCard(
          title: '2 · Error-state red seam',
          pitch:
              'Used on form fields — whenever WidgetState.error is present, '
              'clamp to a loud red border regardless of other states.',
          sample: const BorderSide(color: _wsbsThreadRed, width: 2.2),
          code: 'WidgetStateBorderSide.fromMap({\n'
              '  WidgetState.error:\n'
              '    BorderSide(color: Colors.red.shade700, width: 2),\n'
              '  WidgetState.focused:\n'
              '    BorderSide(color: Colors.blue, width: 2),\n'
              '  WidgetState.any:\n'
              '    BorderSide(color: Colors.grey),\n'
              '});',
          accent: _wsbsThreadRed,
        ),
        _wsbsRecipeCard(
          title: '3 · Selected-chip bold stroke',
          pitch:
              'Chips that are picked get a brass-gold seam. When both '
              'selected AND hovered, thicken further to signal "about to '
              'act".',
          sample: const BorderSide(color: _wsbsThreadGold, width: 2.4),
          code: 'WidgetStateBorderSide.fromMap({\n'
              '  WidgetState.selected & WidgetState.hovered:\n'
              '    BorderSide(color: Colors.amber.shade800, width: 2.8),\n'
              '  WidgetState.selected:\n'
              '    BorderSide(color: Colors.amber, width: 2),\n'
              '  WidgetState.any:\n'
              '    BorderSide(color: Colors.black54),\n'
              '});',
          accent: _wsbsThreadGold,
        ),
        _wsbsRecipeCard(
          title: '4 · Focus-ring treatment',
          pitch:
              'A broad chalk-blue ring appears only on keyboard focus, '
              'satisfying accessibility without cluttering hover visuals.',
          sample: const BorderSide(color: _wsbsChalkDeep, width: 2.6),
          code: 'WidgetStateBorderSide.resolveWith((s) =>\n'
              '  s.contains(WidgetState.focused)\n'
              '    ? const BorderSide(color: Colors.blue, width: 3)\n'
              '    : const BorderSide(color: Colors.grey, width: 1),\n'
              ');',
          accent: _wsbsChalkDeep,
        ),
        _wsbsRecipeCard(
          title: '5 · Dashed-look for dragged',
          pitch:
              'Flutter\'s BorderSide has no dashed style, but we can fake '
              'one by picking a distinct colour-on-press. (For true dashed '
              'strokes use a CustomPainter.)',
          sample: const BorderSide(color: _wsbsThreadGreen, width: 2),
          code: 'WidgetStateBorderSide.resolveWith((s) {\n'
              '  if (s.contains(WidgetState.dragged)) {\n'
              '    return const BorderSide(color: Colors.green, width: 2);\n'
              '  }\n'
              '  return const BorderSide(color: Colors.grey, width: 1);\n'
              '});',
          accent: _wsbsThreadGreen,
        ),
        _wsbsRecipeCard(
          title: '6 · Disabled never wins',
          pitch:
              'Even when other states would demand a loud seam, disabled '
              'always wins — always check it first in your resolver.',
          sample: BorderSide(
              color: _wsbsChalkDeep.withValues(alpha: 0.35), width: 1),
          code: 'WidgetStateBorderSide.resolveWith((s) {\n'
              '  if (s.contains(WidgetState.disabled)) {\n'
              '    return const BorderSide(color: Colors.black26);\n'
              '  }\n'
              '  // ... real rules below ...\n'
              '});',
          accent: _wsbsChalkDeep,
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 9 — COMPARISON TABLE
// ═════════════════════════════════════════════════════════════════════════

class _WsbsTableRow {
  const _WsbsTableRow(this.aspect, this.plain, this.wsbs, this.material);
  final String aspect;
  final String plain;
  final String wsbs;
  final String material;
}

Widget _wsbsCompareCell(String value, {bool strong = false, Color? bg}) {
  return Container(
    constraints: const BoxConstraints(minHeight: 40),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: bg ?? Colors.transparent,
      border: Border.all(color: _wsbsCharcoal.withValues(alpha: 0.15)),
    ),
    child: Text(
      value,
      style: _wsbsBody.copyWith(
        fontSize: 11,
        fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
      ),
    ),
  );
}

Widget _wsbsCompareHeader(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: _wsbsCharcoal,
      border: Border.all(color: _wsbsPinstripe),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: _wsbsIvory,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.7,
      ),
    ),
  );
}

Widget _wsbsComparisonTable() {
  final List<_WsbsTableRow> rows = <_WsbsTableRow>[
    const _WsbsTableRow(
      'Reactivity',
      'Static — single colour/width/style.',
      'Per-state — different seam for each WidgetState set.',
      'Per-state (deprecated alias of WidgetStateBorderSide).',
    ),
    const _WsbsTableRow(
      'Parent class',
      'Object.',
      'BorderSide.',
      'BorderSide (via typedef redirect).',
    ),
    const _WsbsTableRow(
      'Implements',
      '—',
      'WidgetStateProperty<BorderSide?>',
      'MaterialStateProperty<BorderSide?>',
    ),
    const _WsbsTableRow(
      'Primary API',
      'const BorderSide(color:, width:, style:)',
      '.resolveWith / .fromMap → resolve(states)',
      '.resolveWith / .fromMap → resolve(states) (deprecated)',
    ),
    const _WsbsTableRow(
      'Null allowed?',
      'No — a BorderSide is always a concrete seam.',
      'Yes — resolve() may return null.',
      'Yes — same semantics.',
    ),
    const _WsbsTableRow(
      'Typical use',
      'Fixed outlines (cards, static borders).',
      'Buttons, chips, inputs that react to interaction.',
      'Legacy code; prefer WidgetStateBorderSide in new code.',
    ),
    const _WsbsTableRow(
      'Flutter status',
      'Stable, primary primitive.',
      'Stable, recommended.',
      'Deprecated; retained for backwards compatibility.',
    ),
    const _WsbsTableRow(
      'Ergonomics',
      'Trivial.',
      'Moderate — one resolver function or a small map.',
      'Same as WidgetStateBorderSide, but with old names.',
    ),
  ];

  return _wsbsFrame(
    title: 'Comparison · BorderSide vs WidgetStateBorderSide vs Material…',
    subtitle:
        'When each is the right tool, and why MaterialStateBorderSide is out.',
    titleBar: _wsbsChalkDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialStateBorderSide was renamed to WidgetStateBorderSide in '
          '2024; the old name still exists but is deprecated. Prefer the '
          'widget-state-prefixed names everywhere new.',
          style: _wsbsBody,
        ),
        const SizedBox(height: 10),
        Row(children: <Widget>[
          Expanded(child: _wsbsCompareHeader('Aspect')),
          Expanded(child: _wsbsCompareHeader('BorderSide')),
          Expanded(child: _wsbsCompareHeader('WidgetStateBorderSide')),
          Expanded(child: _wsbsCompareHeader('MaterialStateBorderSide')),
        ]),
        for (final _WsbsTableRow row in rows)
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _wsbsCompareCell(row.aspect,
                    strong: true, bg: _wsbsMuslin),
              ),
              Expanded(child: _wsbsCompareCell(row.plain)),
              Expanded(
                child: _wsbsCompareCell(row.wsbs,
                    bg: _wsbsBrass.withValues(alpha: 0.12)),
              ),
              Expanded(child: _wsbsCompareCell(row.material)),
            ],
          ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  SECTION 10 — GLOSSARY / EPILOGUE
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsGlossaryEntry(String term, String def) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(term,
              style: _wsbsBody.copyWith(
                  fontWeight: FontWeight.w800, color: _wsbsBrassDark)),
        ),
        Expanded(child: Text(def, style: _wsbsBody)),
      ],
    ),
  );
}

Widget _wsbsGlossary() {
  return _wsbsFrame(
    title: 'Glossary · terms you\'ll meet along the way',
    subtitle: 'Short, opinionated definitions.',
    titleBar: _wsbsCharcoal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wsbsGlossaryEntry('BorderSide',
            'A description of one edge of a border: colour, width, style, '
                'stroke-align. The atomic unit.'),
        _wsbsGlossaryEntry('WidgetState',
            'An enum of interaction states (hovered, focused, pressed, '
                'dragged, selected, scrolledUnder, disabled, error).'),
        _wsbsGlossaryEntry('Set<WidgetState>',
            'The set of states that are currently active on a widget. '
                'Many can coexist (hovered + focused + selected, etc.).'),
        _wsbsGlossaryEntry('WidgetStatesConstraint',
            'A matcher over state sets. Each WidgetState is itself a '
                'constraint; combine with & | ~ for composite rules.'),
        _wsbsGlossaryEntry('WidgetStateMap<T>',
            'A map from WidgetStatesConstraint to T. Scanned top-down; '
                'first matching constraint wins.'),
        _wsbsGlossaryEntry('WidgetStateProperty<T>',
            'Anything that can resolve a Set<WidgetState> to a T.'),
        _wsbsGlossaryEntry('WidgetStateBorderSide',
            'A WidgetStateProperty<BorderSide?> that also IS a BorderSide '
                '— the subject of this demo.'),
        _wsbsGlossaryEntry('WidgetPropertyResolver<T>',
            'typedef for T Function(Set<WidgetState>). The callback shape '
                'consumed by resolveWith.'),
        _wsbsGlossaryEntry('resolve(states)',
            'The single contract method. Called by widgets to obtain the '
                'BorderSide appropriate for the current state set.'),
        _wsbsDivider(),
        Text(
          'Epilogue. The tailor\'s workshop metaphor is deliberate: a '
          'BorderSide is a finished seam; a WidgetStateBorderSide is the '
          'tailor\'s sensibility — the rules that decide which seam to '
          'use given the garment\'s current treatment. Write resolvers '
          'that check disabled first, error next, then composite states, '
          'then single states, and finally fall through to a sensible '
          'default. Your code will read like a pattern book.',
          style: _wsbsBody,
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════
//  MASTHEAD, FOOTER, HOME
// ═════════════════════════════════════════════════════════════════════════

Widget _wsbsMasthead() {
  return Container(
    margin: const EdgeInsets.fromLTRB(14, 14, 14, 6),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _wsbsInk, width: 1.2),
      boxShadow: const [
        BoxShadow(
          color: _wsbsShadow,
          offset: Offset(0, 3),
          blurRadius: 10,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _WsbsPinstripePainter(
                stripeColor: _wsbsPinstripe,
                background: _wsbsMuslin,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _WsbsChalkMarksPainter(density: 40),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _wsbsCharcoal.withValues(alpha: 0.85),
                    _wsbsCharcoal.withValues(alpha: 0.55),
                    _wsbsBrassDark.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _wsbsBrass,
                        shape: BoxShape.circle,
                        border: Border.all(color: _wsbsBrassDark, width: 1.4),
                        boxShadow: const [
                          BoxShadow(
                            color: _wsbsShadow,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.content_cut,
                          color: _wsbsInk, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'WidgetStateBorderSide',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: _wsbsIvory,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Tailor\'s Workshop · deep visual demo',
                            style: TextStyle(
                              fontSize: 12,
                              color: _wsbsBrassLight,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'A stateful seam — borders that learn to react to hover, '
                  'focus, press, selection, disablement and error.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xEEF4EFE6),
                    height: 1.4,
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

Widget _wsbsFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(14, 6, 14, 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _wsbsInk,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wsbsBrassDark.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: _wsbsBrass,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'End of demo · return to the pattern book',
              style: TextStyle(
                color: _wsbsBrassLight,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Every widget on this page was hand-authored with the _Wsbs '
          'prefix, no code generation, no ignore_for_file directives. The '
          'resolver pattern shown here scales from a single button to a '
          'full form library — the tailor\'s workshop goes with you.',
          style: const TextStyle(
            color: Color(0xEEECE4D2),
            fontSize: 11,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

class _WsbsHome extends StatelessWidget {
  const _WsbsHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wsbsMuslin,
      appBar: AppBar(
        title: const Text(
          'WidgetStateBorderSide · deep demo',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: _wsbsCharcoal,
        foregroundColor: _wsbsIvory,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _WsbsPinstripePainter(
                stripeColor: _wsbsPinstripe,
                background: _wsbsMuslin,
                stripeSpacing: 14,
                stripeWidth: 0.5,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              _wsbsMasthead(),
              _wsbsDossierCard1(),
              _wsbsDossierCard2(),
              _wsbsDossierCard3(),
              _wsbsDossierCard4(),
              _wsbsDossierCard5(),
              _wsbsDossierCard6(),
              _wsbsDossierCard7(),
              _wsbsAnatomyCard(),
              _wsbsPlayground(),
              _wsbsComparison(),
              _wsbsSwatchBook(),
              _wsbsChipTheme(),
              _wsbsAnimatedSweep(),
              _wsbsRecipes(),
              _wsbsComparisonTable(),
              _wsbsGlossary(),
              _wsbsFooter(),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════
//  d4rt entry
// ═════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  debugPrint('[WidgetStateBorderSide demo] build() invoked.');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WidgetStateBorderSide — Tailor\'s Workshop',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _wsbsMuslin,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _wsbsBrass,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _wsbsCharcoal,
        foregroundColor: _wsbsIvory,
      ),
    ),
    home: const _WsbsHome(),
  );
}
