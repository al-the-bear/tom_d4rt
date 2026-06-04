// Toolbar — colour swatches, brush-size slider, undo / redo / clear.
//
// The toolbar is a pure `StatelessWidget` driven by typed
// callbacks. All state lives in the host's
// `State<DrawingPadHome>`; the toolbar just renders the
// already-resolved selected colour / brush size / button-enabled
// flags and forwards user input back via the callbacks.
//
// `List.generate` is used to build the swatch row so each swatch
// closure captures its own `i` — the d4rt classic-for-loop
// closure-capture issue (loop variable shared across iterations)
// does not apply here.
import 'package:flutter/material.dart';

class DrawingToolBar extends StatelessWidget {
  /// Palette colours in display order. Tapping a swatch invokes
  /// [onColorSelected] with the matching `Color`.
  final List<Color> palette;

  /// Currently selected colour — drives swatch highlight ring.
  final Color selectedColor;

  final void Function(Color color) onColorSelected;

  /// Current brush width, between [minBrush] and [maxBrush].
  final double brushSize;
  final double minBrush;
  final double maxBrush;

  final void Function(double size) onBrushSizeChanged;

  /// Whether the Undo button can run right now.
  final bool canUndo;

  /// Whether the Redo button can run right now.
  final bool canRedo;

  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onClear;

  const DrawingToolBar({
    super.key,
    required this.palette,
    required this.selectedColor,
    required this.onColorSelected,
    required this.brushSize,
    required this.minBrush,
    required this.maxBrush,
    required this.onBrushSizeChanged,
    required this.canUndo,
    required this.canRedo,
    required this.onUndo,
    required this.onRedo,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      key: const ValueKey<String>('tool-bar'),
      color: scheme.surfaceContainer,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SwatchRow(
              palette: palette,
              selectedColor: selectedColor,
              onColorSelected: onColorSelected,
              scheme: scheme,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.brush_outlined,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Slider(
                    key: const ValueKey<String>('brush-slider'),
                    value: brushSize,
                    min: minBrush,
                    max: maxBrush,
                    onChanged: onBrushSizeChanged,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  key: const ValueKey<String>('btn-undo'),
                  tooltip: 'Undo',
                  onPressed: canUndo ? onUndo : null,
                  icon: const Icon(Icons.undo),
                ),
                IconButton(
                  key: const ValueKey<String>('btn-redo'),
                  tooltip: 'Redo',
                  onPressed: canRedo ? onRedo : null,
                  icon: const Icon(Icons.redo),
                ),
                IconButton(
                  key: const ValueKey<String>('btn-clear'),
                  tooltip: 'Clear',
                  onPressed: (canUndo || canRedo) ? onClear : null,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SwatchRow extends StatelessWidget {
  final List<Color> palette;
  final Color selectedColor;
  final void Function(Color color) onColorSelected;
  final ColorScheme scheme;

  const _SwatchRow({
    required this.palette,
    required this.selectedColor,
    required this.onColorSelected,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(palette.length, (i) {
        final color = palette[i];
        final selected = color == selectedColor;
        return _Swatch(
          index: i,
          color: color,
          selected: selected,
          scheme: scheme,
          onTap: () => onColorSelected(color),
        );
      }),
    );
  }
}

class _Swatch extends StatelessWidget {
  final int index;
  final Color color;
  final bool selected;
  final ColorScheme scheme;
  final VoidCallback onTap;

  const _Swatch({
    required this.index,
    required this.color,
    required this.selected,
    required this.scheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = selected
        ? Border.all(width: 3, color: scheme.primary)
        : Border.all(width: 1, color: scheme.outlineVariant);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        key: ValueKey<String>('swatch-$index'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border,
          ),
        ),
      ),
    );
  }
}
