// One numbered tile on the board.
//
// `AnimatedPositioned` interpolates between cell positions: when the
// board hands the same tile (keyed by its value) a different `cell`
// in the next build, the framework slides it instead of cutting.
import 'package:flutter/material.dart';

const double kTileSize = 72.0;
const double kTilePadding = 4.0;

class PuzzleTile extends StatelessWidget {
  final int value;
  final int cell;
  final VoidCallback onTap;

  const PuzzleTile({
    super.key,
    required this.value,
    required this.cell,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final int row = cell ~/ 4;
    final int col = cell % 4;
    final double left = col * (kTileSize + kTilePadding);
    final double top = row * (kTileSize + kTilePadding);
    return AnimatedPositioned(
      key: Key('tile-pos-$value'),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      left: left,
      top: top,
      width: kTileSize,
      height: kTileSize,
      child: GestureDetector(
        key: Key('tile-$value'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _tileColor(value),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Hue shifts gently across the 15 tiles so the user can read the
  // gradient — bottom-right is "warmest", top-left "coolest".
  Color _tileColor(int v) {
    final double t = (v - 1) / 14.0;
    final int r = (40 + 180 * t).round();
    final int g = (90 + 60 * (1.0 - t)).round();
    final int b = (200 - 120 * t).round();
    return Color.fromARGB(255, r, g, b);
  }
}
