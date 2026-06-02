// A single carousel card.
//
// The card paints a diagonal gradient between the two colours defined
// in `PageInfo`. While the card is the focus page the title sits at
// its visual center; off-axis cards stay legible but slightly inset.
//
// Tapping the card forwards to `onTap` — wired by the `home.dart`
// shell to open the detail view via the `AnimatedSwitcher`.
import 'package:flutter/material.dart';

import 'pages.dart';

class PageCard extends StatelessWidget {
  final PageInfo info;
  final int index;
  final VoidCallback onTap;

  const PageCard({
    super.key,
    required this.info,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('page-card-$index'),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[info.colorA, info.colorB],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                info.title,
                key: Key('page-title-$index'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  info.tagline,
                  key: Key('page-tagline-$index'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
