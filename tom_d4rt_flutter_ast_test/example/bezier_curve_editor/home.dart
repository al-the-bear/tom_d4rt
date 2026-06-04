// Main editor page for the bezier_curve_editor sample.
//
// Lays out a `Stack`:
//   * A `CustomPaint(painter: BezierPainter)` fills the editor
//     area and draws the curve, construction polygon, control
//     markers, and preview dot.
//   * On top of the painter, four `Positioned` `GestureDetector`s
//     — one per control point — sit at the point's pixel
//     location. Each owns its own `onPanUpdate` so the per-point
//     drag spec in the example plan is honoured exactly (a single
//     parent gesture detector with hit-test math would conflate
//     the four targets).
//
// The page also wires an `AnimationController` to drive the
// preview dot along the curve using `Curves.elasticOut`. Tapping
// "Play" starts the animation; "Pause" stops it; "Reset" jumps
// the controller back to `0` so the dot returns to `p0`.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'bezier_model.dart';
import 'bezier_painter.dart';
import 'controls.dart';

class BezierHome extends StatefulWidget {
  const BezierHome({super.key});

  @override
  State<BezierHome> createState() => _BezierHomeState();
}

class _BezierHomeState extends State<BezierHome>
    with SingleTickerProviderStateMixin {
  late final BezierModel _model;
  late final AnimationController _animController;
  late final Animation<double> _animValue;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _model = BezierModel();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animValue = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _animValue.addListener(_onAnimTick);
    _animController.addStatusListener(_onAnimStatus);
  }

  @override
  void dispose() {
    _animValue.removeListener(_onAnimTick);
    _animController.removeStatusListener(_onAnimStatus);
    _animController.dispose();
    _model.dispose();
    super.dispose();
  }

  void _onAnimTick() {
    _model.setPreviewT(_animValue.value);
  }

  void _onAnimStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
      print('bezier.play complete');
    }
  }

  void _play() {
    print('bezier.play start');
    setState(() {
      _isPlaying = true;
    });
    _animController.forward(from: 0.0);
  }

  void _pause() {
    print('bezier.play pause');
    setState(() {
      _isPlaying = false;
    });
    _animController.stop();
  }

  void _reset() {
    print('bezier.play reset');
    _animController.reset();
    _model.setPreviewT(0.0);
  }

  /// Convert a local pixel position inside the editor area into
  /// normalised `[0, 1] × [0, 1]` coords. Inverts the mapping in
  /// `BezierPainter._toPx`.
  Offset _toNormalised(Offset px, Size size) {
    final double w = size.width - 2.0 * kBezierInset;
    final double h = size.height - 2.0 * kBezierInset;
    if (w <= 0.0 || h <= 0.0) return const Offset(0.5, 0.5);
    return Offset((px.dx - kBezierInset) / w, (px.dy - kBezierInset) / h);
  }

  /// Convert a normalised offset back to a pixel position inside
  /// the editor. Used to place each handle's `Positioned`.
  Offset _toPx(Offset n, Size size) {
    final double w = size.width - 2.0 * kBezierInset;
    final double h = size.height - 2.0 * kBezierInset;
    return Offset(kBezierInset + n.dx * w, kBezierInset + n.dy * h);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('bezier-appbar'),
        title: const Text('Bezier curve editor'),
      ),
      body: AnimatedBuilder(
        animation: _model,
        builder: (BuildContext ctx, Widget? _) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext lc, BoxConstraints constraints) {
                      final Size size = Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      );
                      return Stack(
                        key: const Key('bezier-stack'),
                        children: <Widget>[
                          Positioned.fill(
                            child: CustomPaint(
                              key: const Key('bezier-paint'),
                              painter: BezierPainter(_model),
                            ),
                          ),
                          _buildHandle(0, size),
                          _buildHandle(1, size),
                          _buildHandle(2, size),
                          _buildHandle(3, size),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Controls(
                model: _model,
                isPlaying: _isPlaying,
                onPlay: _play,
                onPause: _pause,
                onReset: _reset,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHandle(int index, Size size) {
    const double radius = 18.0;
    final Offset px = _toPx(_model.points[index], size);
    return Positioned(
      left: px.dx - radius,
      top: px.dy - radius,
      width: radius * 2.0,
      height: radius * 2.0,
      child: GestureDetector(
        key: Key('bezier-handle-$index'),
        behavior: HitTestBehavior.opaque,
        onPanStart: (DragStartDetails _) {
          print('bezier.drag.start i=$index');
        },
        onPanUpdate: (DragUpdateDetails details) {
          // Convert the *current* handle position into pixel
          // space, add the delta, then convert back to normalised
          // coords. Using `delta` from onPanUpdate avoids needing
          // a separate startOffset member.
          final Offset currentPx = _toPx(_model.points[index], size);
          final Offset newPx = currentPx + details.delta;
          final Offset newN = _toNormalised(newPx, size);
          _model.setPoint(index, newN);
        },
        onPanEnd: (DragEndDetails _) {
          print('bezier.drag.end i=$index');
        },
        child: Container(
          // Transparent hit area; the visual circle lives inside
          // the painter so we don't need to render anything here.
          color: const Color(0x00000000),
        ),
      ),
    );
  }
}
