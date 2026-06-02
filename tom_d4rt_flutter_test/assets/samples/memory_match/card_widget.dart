// One memory-match card.
//
// The card spins around its Y axis to reveal / hide the face,
// driven by a `TweenAnimationBuilder<double>` keyed to the
// `revealed` flag. When `revealed` flips, the tween animates from
// the old value of `targetAngle` to the new one; the host's
// `setState` is what drives the `targetAngle` change.
//
// The transform is the standard "flip-around-Y" matrix with a
// small perspective on `m[3][2]`. At angle 0 we see the back, at
// angle π we see the face. Halfway through the spin (|angle - π/2|
// < ε) the side that's "behind us" should not be drawn, so we
// branch on the current animation value to pick which face to
// paint.
//
// `TweenAnimationBuilder<double>` is the *first* place the
// d4rt-driven sample suite exercises the generic constructor for
// this widget. If type inference can't pick `T = double` from the
// tween argument we must write the type explicitly (GEN-113 rule).
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'game.dart';

class MemoryCardTile extends StatelessWidget {
  /// The model backing this card. Drives `revealed`, `matched`,
  /// and the face emoji lookup.
  final MemoryCard card;

  /// Tap callback — wired to the host's flip-handler.
  final VoidCallback onTap;

  /// Optional ValueKey suffix — used by tests to address a
  /// specific slot regardless of layout.
  final int slot;

  const MemoryCardTile({
    super.key,
    required this.card,
    required this.onTap,
    required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final target = card.revealed ? math.pi : 0.0;
    return GestureDetector(
      key: ValueKey<String>('card-${card.id}'),
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        // begin only matters on the *first* build; subsequent
        // builds animate from the current value to the new `end`.
        tween: Tween<double>(begin: 0.0, end: target),
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          final showFace = value > math.pi / 2;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(value);
          // When the face side faces the viewer we need to flip the
          // child horizontally so the emoji isn't mirrored — the
          // outer rotation already mirrors everything past π/2.
          if (showFace) {
            transform.rotateY(math.pi);
          }
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: showFace
                ? _buildFace(scheme)
                : _buildBack(scheme),
          );
        },
      ),
    );
  }

  Widget _buildBack(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.primaryContainer, width: 2),
      ),
      child: Center(
        child: Text(
          '?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: scheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildFace(ColorScheme scheme) {
    final faceText = kFaceRack[card.faceId % kFaceRack.length];
    final bg = card.matched
        ? scheme.tertiaryContainer
        : scheme.surfaceContainerHighest;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: card.matched ? scheme.tertiary : scheme.outlineVariant,
          width: card.matched ? 2.5 : 1,
        ),
      ),
      child: Center(
        child: Text(
          faceText,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
