// Home / shell page for the card_swiper sample.
//
// Renders:
//   * an AppBar with the liked / passed counters
//   * the `Deck` in the centre (fills most of the body)
//   * Pass / Like FAB-style buttons at the bottom that drive the
//     same fly-away animation as a drag would
//
// The page owns the `SwipeController` and a `GlobalKey<DeckState>`
// so the bottom buttons can call `flyOff(direction)` directly. That
// avoids having to plumb a second AnimationController through the
// controller; keeping the animation owned by the deck is simpler and
// still lets the controller drive the trail / state side.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'deck.dart';
import 'swipe_controller.dart';

class SwiperHome extends StatefulWidget {
  const SwiperHome({super.key});

  @override
  State<SwiperHome> createState() => _SwiperHomeState();
}

class _SwiperHomeState extends State<SwiperHome> {
  late final SwipeController _controller;
  final GlobalKey<DeckState> _deckKey = GlobalKey<DeckState>();

  @override
  void initState() {
    super.initState();
    _controller = SwipeController();
    _controller.addListener(_onChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    _controller.dispose();
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  void _onPass() {
    final dir = _controller.swipeButton(right: false);
    if (dir != 0) {
      _deckKey.currentState?.flyOff(dir);
    }
  }

  void _onLike() {
    final dir = _controller.swipeButton(right: true);
    if (dir != 0) {
      _deckKey.currentState?.flyOff(dir);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('swiper-appbar'),
        title: const Text('Card Swiper'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                'Liked ${_controller.liked} • Passed ${_controller.passed}',
                key: const Key('swiper-counter'),
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Deck(
                key: _deckKey,
                controller: _controller,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  key: const Key('btn-pass'),
                  heroTag: 'pass',
                  backgroundColor: Colors.red.shade400,
                  onPressed: _controller.isEmpty ? null : _onPass,
                  child: const Icon(Icons.close),
                ),
                FloatingActionButton(
                  key: const Key('btn-like'),
                  heroTag: 'like',
                  backgroundColor: Colors.green.shade400,
                  onPressed: _controller.isEmpty ? null : _onLike,
                  child: const Icon(Icons.favorite),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
