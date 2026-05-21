// Detail view shown when the user taps a carousel card.
//
// The body grows in via a `TweenAnimationBuilder<double>` that runs
// 0 → 1 on first build. The same gradient + title used in the
// carousel is reused so the transition reads as the card "expanding"
// into the page.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'pages.dart';

class DetailPage extends StatelessWidget {
  final PageInfo info;
  final int index;
  final VoidCallback onClose;

  const DetailPage({
    super.key,
    required this.info,
    required this.index,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('detail-scaffold-$index'),
      appBar: AppBar(
        key: Key('detail-appbar-$index'),
        title: Text(info.title, key: Key('detail-title-$index')),
        leading: IconButton(
          key: const Key('detail-back'),
          icon: const Icon(Icons.close),
          onPressed: () {
            print('detail.close index=$index');
            onClose();
          },
        ),
      ),
      body: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        builder: (BuildContext _, double t, Widget? child) {
          return Padding(
            padding: EdgeInsets.all(16.0 + 24.0 * (1.0 - t)),
            child: Opacity(
              opacity: t,
              child: Container(
                key: Key('detail-card-$index'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[info.colorA, info.colorB],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      info.tagline,
                      key: Key('detail-tagline-$index'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
