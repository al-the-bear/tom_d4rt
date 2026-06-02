// Visual deck for the card_swiper sample.
//
// `Deck` listens to the `SwipeController` and renders up to three
// cards at a time:
//   * The next-next card (smallest, furthest behind)
//   * The next card (medium, slightly behind the top)
//   * The top card (full size, accepts pan gestures)
//
// `AnimatedPositioned` on the two underlying cards gives the deck
// its "card animates up" feel when the top card flies away.
//
// Fly-away is driven by a local `AnimationController` + a
// `Tween<Offset>` that drags the card off-screen in the direction
// dictated by `SwipeController.startFly`. When the animation
// completes, the deck calls `controller.finishFly(direction)` which
// removes the card and resets the drag.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'card_widget.dart';
import 'swipe_controller.dart';

class Deck extends StatefulWidget {
  final SwipeController controller;

  const Deck({super.key, required this.controller});

  @override
  State<Deck> createState() => DeckState();
}

class DeckState extends State<Deck> with SingleTickerProviderStateMixin {
  late final AnimationController _flyController;
  Animation<Offset>? _flyAnimation;
  int _flyDirection = 0;

  @override
  void initState() {
    super.initState();
    _flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _flyController.addStatusListener(_onStatus);
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    _flyController.removeStatusListener(_onStatus);
    _flyController.dispose();
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (mounted) setState(() {});
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      final dir = _flyDirection;
      _flyDirection = 0;
      _flyAnimation = null;
      widget.controller.finishFly(dir);
      _flyController.reset();
    }
  }

  /// Programmatic fly invoked from `Home` after a button press. The
  /// caller supplies the direction; the deck synthesises a target
  /// offset based on the screen size.
  void flyOff(int direction) {
    if (_flyController.isAnimating) return;
    if (widget.controller.isEmpty) return;
    final size = MediaQuery.of(context).size;
    final startOffset = widget.controller.dragOffset;
    final endOffset = Offset(
      direction * (size.width + 200.0),
      startOffset.dy - 80.0,
    );
    _flyDirection = direction;
    _flyAnimation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(
      CurvedAnimation(parent: _flyController, curve: Curves.easeOut),
    );
    widget.controller.startFly(direction);
    _flyController.forward(from: 0.0);
  }

  void _onPanStart(DragStartDetails _) {
    if (_flyController.isAnimating) return;
    // No-op — the controller resets the drag offset between cards.
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_flyController.isAnimating) return;
    widget.controller.updateDrag(details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_flyController.isAnimating) return;
    final dir = widget.controller.endDrag();
    if (dir != 0) {
      flyOff(dir);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    if (c.isEmpty) {
      return Center(
        key: const Key('deck-empty'),
        child: Text(
          'No more cards.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        // Three card positions: top (no inset), 2nd (slightly smaller
        // and offset down), 3rd (smaller still). When the top flies
        // away, AnimatedPositioned slides the 2nd into the top slot.
        final positions = <_Slot>[
          _Slot(left: 0.0, top: 0.0, scale: 1.0),
          _Slot(left: 0.0, top: 12.0, scale: 0.96),
          _Slot(left: 0.0, top: 24.0, scale: 0.92),
        ];

        final children = <Widget>[];
        for (var depth = positions.length - 1; depth >= 0; depth--) {
          final idx = c.currentIndex + depth;
          if (idx >= c.cards.length) continue;
          children.add(_buildSlot(c, idx, depth, positions[depth], w, h));
        }

        return Stack(
          key: const Key('deck-stack'),
          fit: StackFit.expand,
          children: children,
        );
      },
    );
  }

  Widget _buildSlot(
    SwipeController c,
    int cardIndex,
    int depth,
    _Slot slot,
    double w,
    double h,
  ) {
    final card = c.cards[cardIndex];
    final isTop = depth == 0;

    // The card box itself is a fixed size — let it occupy most of
    // the deck area, with a small horizontal inset so the deck looks
    // padded in the parent.
    Widget child = SizedBox(
      width: w * 0.85,
      height: h * 0.85,
      child: CardWidget(
        card: card,
        isTop: isTop,
        overlayProgress: isTop ? c.dragProgress : 0.0,
      ),
    );

    if (isTop) {
      // Combine drag offset (live) + fly offset (animated).
      Offset offset = c.dragOffset;
      double rotation = (c.dragOffset.dx / 200.0) * kMaxCardRotation;
      if (_flyAnimation != null) {
        offset = _flyAnimation!.value;
        rotation = (offset.dx / 200.0) * kMaxCardRotation;
      }
      child = Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: rotation,
          child: child,
        ),
      );
      child = GestureDetector(
        key: Key('deck-top-${card.id}'),
        behavior: HitTestBehavior.opaque,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: child,
      );
    }

    // Center the (scaled) card inside the stack slot.
    final positioned = AnimatedPositioned(
      key: ValueKey<int>(card.id),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      left: (w - w * 0.85 * slot.scale) / 2,
      right: (w - w * 0.85 * slot.scale) / 2,
      top: slot.top + (h - h * 0.85 * slot.scale) / 2,
      bottom: -slot.top + (h - h * 0.85 * slot.scale) / 2,
      child: Transform.scale(scale: slot.scale, child: child),
    );

    return AnimatedBuilder(
      animation: _flyController,
      builder: (BuildContext context, Widget? _) => positioned,
    );
  }
}

class _Slot {
  final double left;
  final double top;
  final double scale;
  const _Slot({required this.left, required this.top, required this.scale});
}
