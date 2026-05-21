// Animated progress bar for the form_wizard sample (example #15).
//
// Driven by an `AnimationController` so that hopping from one step
// to the next eases the bar fill rather than snapping. The progress
// value is owned by the wizard controller — this widget only sees
// the latest goal value via its constructor and animates from the
// previous goal to the new one.
//
// The animation is wired through `didUpdateWidget`: when the parent
// rebuilds with a new `progress`, we replace the underlying Tween
// and run the controller forward from 0 to 1. The `AnimatedBuilder`
// then samples the tween every tick.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class WizardProgressBar extends StatefulWidget {
  /// Current goal progress, in [0.0, 1.0]. The widget animates
  /// from whatever it was previously rendering toward this value.
  final double progress;

  final Duration animationDuration;

  const WizardProgressBar({
    super.key,
    required this.progress,
    this.animationDuration = const Duration(milliseconds: 240),
  });

  @override
  State<WizardProgressBar> createState() => _WizardProgressBarState();
}

class _WizardProgressBarState extends State<WizardProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tween;
  late double _from;

  @override
  void initState() {
    super.initState();
    _from = widget.progress;
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: 1.0,
    );
    _tween = AlwaysStoppedAnimation<double>(widget.progress);
  }

  @override
  void didUpdateWidget(WizardProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      // Lock in the previous goal as our new tween start so the
      // bar fills/recedes smoothly. Without capturing this we'd
      // snap straight to the new value the first frame.
      _from = oldWidget.progress;
      _tween = Tween<double>(begin: _from, end: widget.progress)
          .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
      _controller
        ..reset()
        ..forward();
      print('progress.animate from=$_from to=${widget.progress}');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tween,
      builder: (BuildContext ctx, Widget? _) {
        return LinearProgressIndicator(
          key: const Key('progress-bar'),
          value: _tween.value.clamp(0.0, 1.0),
          minHeight: 6.0,
        );
      },
    );
  }
}
