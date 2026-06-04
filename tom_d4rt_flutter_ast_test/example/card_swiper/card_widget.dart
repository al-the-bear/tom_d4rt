// Visual representation of a single deck card.
//
// The card is intentionally simple — a rounded coloured rectangle
// with a name on top and a one-liner fact below it. The interesting
// behaviour lives in the parent (`Deck`), which decides whether the
// card is the top one (and therefore gets a `Transform.translate` +
// `Transform.rotate` applied from the live drag offset) or one of
// the underlying stack cards.
//
// Keeping the card stateless lets the deck wrap it in
// `Transform`/`AnimatedPositioned`/`Hero` without it needing to know
// where it is in the stack.
import 'package:flutter/material.dart';

import 'swipe_controller.dart';

class CardWidget extends StatelessWidget {
  final SwipeCard card;

  /// True for the top card on the stack — we render a slightly
  /// stronger shadow so it visually pops above the others.
  final bool isTop;

  /// `LIKE`/`PASS` overlay opacity in `[-1.0, 1.0]`. Positive shows
  /// the green LIKE stamp; negative shows the red PASS stamp.
  final double overlayProgress;

  const CardWidget({
    super.key,
    required this.card,
    this.isTop = false,
    this.overlayProgress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final likeOpacity =
        overlayProgress > 0 ? overlayProgress.clamp(0.0, 1.0) : 0.0;
    final passOpacity =
        overlayProgress < 0 ? (-overlayProgress).clamp(0.0, 1.0) : 0.0;

    return Material(
      elevation: isTop ? 8.0 : 2.0,
      borderRadius: BorderRadius.circular(20.0),
      color: card.color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Body content — name + fact, padded into a Column.
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    card.name,
                    key: Key('card-name-${card.id}'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    card.fact,
                    key: Key('card-fact-${card.id}'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            // LIKE stamp (top-left).
            if (likeOpacity > 0)
              Positioned(
                top: 24.0,
                left: 24.0,
                child: Opacity(
                  opacity: likeOpacity,
                  child: _stamp(text: 'LIKE', color: Colors.greenAccent),
                ),
              ),
            // PASS stamp (top-right).
            if (passOpacity > 0)
              Positioned(
                top: 24.0,
                right: 24.0,
                child: Opacity(
                  opacity: passOpacity,
                  child: _stamp(text: 'PASS', color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _stamp({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
