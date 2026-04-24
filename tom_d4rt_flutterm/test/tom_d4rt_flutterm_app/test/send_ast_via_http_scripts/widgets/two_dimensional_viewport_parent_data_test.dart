// TwoDimensionalViewportParentData — deep visual harness.
//
// This d4rt AST harness script demonstrates the Flutter framework's
// `TwoDimensionalViewportParentData` class, the `ParentData` attached by
// `RenderTwoDimensionalViewport` to each child it lays out. The relevant
// properties of the real class are:
//
//   • `Offset? layoutOffset`  — set during `layoutChildSequence`
//   • `ChildVicinity vicinity` — set by `buildOrObtainChildFor`
//   • `Offset? paintOffset`    — computed after layout to account for
//                                reversed axis directions
//   • `bool get isVisible`     — derived from `_paintExtent`
//
// Because assembling a full `RenderTwoDimensionalViewport` in an AST script
// is unwieldy (it requires a `TwoDimensionalChildDelegate`, a
// `TwoDimensionalChildManager`, and careful `layoutChildSequence` bookkeeping),
// this demo pairs narrative explanation with a faithful *local* analogue: a
// purpose-built `RenderBox` (`_TwoDVpPdRenderGrid`) that:
//
//   • assigns a bespoke `_TwoDVpPdParentData` (mirroring
//     `TwoDimensionalViewportParentData` — `layoutOffset`, `vicinity`,
//     `paintOffset`, `isVisible`) to every child inside `setupParentData`;
//   • writes `layoutOffset` into each child's parent data inside its own
//     `layoutChildSequence()` analogue;
//   • exposes a `parentDataOf(RenderBox)` helper that is the direct echo of
//     `RenderTwoDimensionalViewport.parentDataOf`.
//
// The demo overlays the live `layoutOffset` on every cell, shows an
// inspector for tapped cells, provides a culling switch that flips
// `isVisible` for offscreen children, and renders a vector-field diagram
// of each cell's offset relative to the viewport origin.
//
// Theme: blueprint blue + ivory rules + red annotation ink + brass grid.

import 'package:flutter/material.dart';

// ───────────────────────────────────────────────────────────────────────────
// Shared palette (blueprint blue / ivory / brass / annotation red)
// ───────────────────────────────────────────────────────────────────────────

const Color _twoDVpPdBlueprint = Color(0xFF0E3A62);
const Color _twoDVpPdBlueprintDeep = Color(0xFF0A2946);
const Color _twoDVpPdIvory = Color(0xFFF4ECD8);
const Color _twoDVpPdIvorySoft = Color(0xFFE8DEC1);
const Color _twoDVpPdBrass = Color(0xFFC9A86A);
const Color _twoDVpPdRedInk = Color(0xFFC43B2A);
const Color _twoDVpPdChalk = Color(0xFFB9D8F0);
const Color _twoDVpPdFaded = Color(0xFF4A607A);

// ───────────────────────────────────────────────────────────────────────────
// Shared notifiers — top-level so d4rt sees them without a State object.
// ───────────────────────────────────────────────────────────────────────────

final ValueNotifier<double> _twoDVpPdCellSize = ValueNotifier<double>(76);
final ValueNotifier<int> _twoDVpPdCols = ValueNotifier<int>(6);
final ValueNotifier<int> _twoDVpPdRows = ValueNotifier<int>(5);
final ValueNotifier<bool> _twoDVpPdCullOffscreen = ValueNotifier<bool>(true);
final ValueNotifier<bool> _twoDVpPdShowOffsets = ValueNotifier<bool>(true);
final ValueNotifier<bool> _twoDVpPdShowVectors = ValueNotifier<bool>(true);
final ValueNotifier<_TwoDVpPdVicinity?> _twoDVpPdSelectedCell =
    ValueNotifier<_TwoDVpPdVicinity?>(null);
final ValueNotifier<double> _twoDVpPdHorizontalScroll = ValueNotifier<double>(0);
final ValueNotifier<double> _twoDVpPdVerticalScroll = ValueNotifier<double>(0);
final ValueNotifier<List<String>> _twoDVpPdConsole =
    ValueNotifier<List<String>>(<String>[
  '[boot] _TwoDVpPdRenderGrid attached',
  '[boot] setupParentData called for 30 children',
  '[boot] layoutChildSequence complete — 30 parentData records updated',
]);

// ───────────────────────────────────────────────────────────────────────────
// Support types — vicinity echo + parent-data record.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdVicinity {
  const _TwoDVpPdVicinity({required this.xIndex, required this.yIndex});

  final int xIndex;
  final int yIndex;

  @override
  bool operator ==(Object other) {
    return other is _TwoDVpPdVicinity &&
        other.xIndex == xIndex &&
        other.yIndex == yIndex;
  }

  @override
  int get hashCode => Object.hash(xIndex, yIndex);

  @override
  String toString() => 'ChildVicinity(x:$xIndex, y:$yIndex)';
}

class _TwoDVpPdRecord {
  _TwoDVpPdRecord({
    required this.vicinity,
    required this.layoutOffset,
    required this.paintOffset,
    required this.isVisible,
    required this.keepAlive,
  });

  final _TwoDVpPdVicinity vicinity;
  final Offset layoutOffset;
  final Offset paintOffset;
  final bool isVisible;
  final bool keepAlive;
}

// A simple immutable "viewport spec" used to compute layout offsets for
// every child, mirroring what `layoutChildSequence` does in the real class.
class _TwoDVpPdViewportSpec {
  const _TwoDVpPdViewportSpec({
    required this.cellSize,
    required this.cols,
    required this.rows,
    required this.horizontalOffset,
    required this.verticalOffset,
    required this.visibleWidth,
    required this.visibleHeight,
    required this.cullOffscreen,
  });

  final double cellSize;
  final int cols;
  final int rows;
  final double horizontalOffset;
  final double verticalOffset;
  final double visibleWidth;
  final double visibleHeight;
  final bool cullOffscreen;

  Offset layoutOffsetFor(_TwoDVpPdVicinity vicinity) {
    final double x = vicinity.xIndex * cellSize - horizontalOffset;
    final double y = vicinity.yIndex * cellSize - verticalOffset;
    return Offset(x, y);
  }

  bool isVisibleFor(_TwoDVpPdVicinity vicinity) {
    if (!cullOffscreen) {
      return true;
    }
    final Offset o = layoutOffsetFor(vicinity);
    final bool xOk = o.dx + cellSize > 0 && o.dx < visibleWidth;
    final bool yOk = o.dy + cellSize > 0 && o.dy < visibleHeight;
    return xOk && yOk;
  }
}

// ───────────────────────────────────────────────────────────────────────────
// build(context) — the d4rt contract.
// ───────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TwoDimensionalViewportParentData Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _twoDVpPdBlueprint,
      colorScheme: const ColorScheme.dark(
        primary: _twoDVpPdBrass,
        onPrimary: _twoDVpPdBlueprintDeep,
        secondary: _twoDVpPdRedInk,
        onSecondary: _twoDVpPdIvory,
        surface: _twoDVpPdBlueprintDeep,
        onSurface: _twoDVpPdIvory,
      ),
      fontFamily: 'monospace',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _twoDVpPdIvory),
        bodySmall: TextStyle(color: _twoDVpPdIvorySoft),
      ),
    ),
    home: const _TwoDVpPdShell(),
  );
}

// ───────────────────────────────────────────────────────────────────────────
// Top-level shell — blueprint background, scroll view of scenario cards.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdShell extends StatelessWidget {
  const _TwoDVpPdShell();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _twoDVpPdBlueprint,
      appBar: AppBar(
        backgroundColor: _twoDVpPdBlueprintDeep,
        foregroundColor: _twoDVpPdIvory,
        elevation: 0,
        title: const _TwoDVpPdTitleBar(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(height: 2, color: _twoDVpPdBrass),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _TwoDVpPdBlueprintBackground()),
          ListView(
            padding: const EdgeInsets.all(18),
            children: const <Widget>[
              _TwoDVpPdPreambleCard(),
              SizedBox(height: 20),
              _TwoDVpPdAnatomyCard(),
              SizedBox(height: 20),
              _TwoDVpPdControlsCard(),
              SizedBox(height: 20),
              _TwoDVpPdLiveGridCard(),
              SizedBox(height: 20),
              _TwoDVpPdInspectorCard(),
              SizedBox(height: 20),
              _TwoDVpPdCullDemoCard(),
              SizedBox(height: 20),
              _TwoDVpPdVectorFieldCard(),
              SizedBox(height: 20),
              _TwoDVpPdLifecycleCard(),
              SizedBox(height: 20),
              _TwoDVpPdConsoleCard(),
              SizedBox(height: 20),
              _TwoDVpPdFooterRibbon(),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}

class _TwoDVpPdTitleBar extends StatelessWidget {
  const _TwoDVpPdTitleBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.grid_on, color: _twoDVpPdBrass, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'TwoDimensionalViewportParentData',
                style: TextStyle(
                  color: _twoDVpPdIvory,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                'anatomy • layoutOffset • isVisible • parentDataOf',
                style: TextStyle(
                  color: _twoDVpPdBrass,
                  fontSize: 11,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: _twoDVpPdBrass, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            'BLUEPRINT · R4',
            style: TextStyle(
              color: _twoDVpPdBrass,
              fontSize: 10,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Blueprint background — custom painter with brass grid lines.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdBlueprintBackground extends StatelessWidget {
  const _TwoDVpPdBlueprintBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _TwoDVpPdBlueprintBackgroundPainter());
  }
}

class _TwoDVpPdBlueprintBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _twoDVpPdBlueprint;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint majorLine = Paint()
      ..color = _twoDVpPdBrass.withValues(alpha: 0.12)
      ..strokeWidth = 0.8;
    final Paint minorLine = Paint()
      ..color = _twoDVpPdBrass.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;

    const double major = 80;
    const double minor = 20;

    for (double x = 0; x < size.width; x += minor) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        x % major == 0 ? majorLine : minorLine,
      );
    }
    for (double y = 0; y < size.height; y += minor) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        y % major == 0 ? majorLine : minorLine,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TwoDVpPdBlueprintBackgroundPainter oldDelegate) =>
      false;
}

// ───────────────────────────────────────────────────────────────────────────
// Card shell — ivory-ruled blueprint card with brass corners.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdCard extends StatelessWidget {
  const _TwoDVpPdCard({
    required this.title,
    required this.subtitle,
    required this.body,
    this.stamp,
  });

  final String title;
  final String subtitle;
  final Widget body;
  final String? stamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDVpPdBlueprintDeep,
        border: Border.all(color: _twoDVpPdBrass, width: 1.2),
        borderRadius: BorderRadius.circular(6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _TwoDVpPdCardHeader(
            title: title,
            subtitle: subtitle,
            stamp: stamp,
          ),
          Container(height: 1, color: _twoDVpPdBrass.withValues(alpha: 0.45)),
          Padding(padding: const EdgeInsets.all(16), child: body),
        ],
      ),
    );
  }
}

class _TwoDVpPdCardHeader extends StatelessWidget {
  const _TwoDVpPdCardHeader({
    required this.title,
    required this.subtitle,
    required this.stamp,
  });

  final String title;
  final String subtitle;
  final String? stamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: <Widget>[
          Container(width: 4, height: 28, color: _twoDVpPdBrass),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _twoDVpPdIvory,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _twoDVpPdChalk,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          if (stamp != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: _twoDVpPdRedInk, width: 1),
                color: _twoDVpPdRedInk.withValues(alpha: 0.08),
              ),
              child: Text(
                stamp!,
                style: const TextStyle(
                  color: _twoDVpPdRedInk,
                  fontSize: 10,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Preamble card — what is a ParentData, conceptually.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdPreambleCard extends StatelessWidget {
  const _TwoDVpPdPreambleCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'PREAMBLE · what is a ParentData?',
      subtitle: 'Per-child state that only the parent render object cares about',
      stamp: 'PLATE 01',
      body: _TwoDVpPdPreambleBody(),
    );
  }
}

class _TwoDVpPdPreambleBody extends StatelessWidget {
  const _TwoDVpPdPreambleBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _TwoDVpPdProse(
          'In Flutter, every RenderObject can attach a ParentData payload to '
          'its children. The payload is opaque to the child — only the '
          'parent inspects or mutates it during layout and paint. Stack uses '
          'StackParentData to remember top/left/right/bottom; Flex uses '
          'FlexParentData to remember flex/fit; and a 2D viewport uses '
          'TwoDimensionalViewportParentData to remember where in the grid a '
          'child lives and whether any of its box is visible.',
        ),
        SizedBox(height: 10),
        _TwoDVpPdProse(
          'Two things matter: (1) the parent must call setupParentData on '
          'every child to install the right payload instance, and (2) the '
          'parent must keep that payload consistent during layout. If the '
          'parent ever reads a stale offset, the children drift.',
        ),
        SizedBox(height: 12),
        _TwoDVpPdBullet('Installed by setupParentData(child).'),
        _TwoDVpPdBullet('Accessed by parentDataOf(child).'),
        _TwoDVpPdBullet('Written during layoutChildSequence().'),
        _TwoDVpPdBullet('Read again during paint() to position the child.'),
      ],
    );
  }
}

class _TwoDVpPdProse extends StatelessWidget {
  const _TwoDVpPdProse(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _twoDVpPdIvorySoft,
        fontSize: 12.5,
        height: 1.45,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _TwoDVpPdBullet extends StatelessWidget {
  const _TwoDVpPdBullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 8),
            child: Icon(Icons.circle, size: 5, color: _twoDVpPdBrass),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _twoDVpPdIvory,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Anatomy card — the fields on TwoDimensionalViewportParentData.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdAnatomyCard extends StatelessWidget {
  const _TwoDVpPdAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'ANATOMY · class TwoDimensionalViewportParentData',
      subtitle: 'from package:flutter/widgets/two_dimensional_viewport.dart',
      stamp: 'PLATE 02',
      body: _TwoDVpPdAnatomyBody(),
    );
  }
}

class _TwoDVpPdAnatomyBody extends StatelessWidget {
  const _TwoDVpPdAnatomyBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _TwoDVpPdField(
          name: 'layoutOffset',
          type: 'Offset?',
          role: 'must be set during layoutChildSequence()',
          text:
              "Top-left corner of the child in the viewport's coordinate "
              "space. Null before layout. The framework asserts this is "
              "non-null after layout finishes for every attached child.",
        ),
        _TwoDVpPdField(
          name: 'vicinity',
          type: 'ChildVicinity',
          role: 'set by buildOrObtainChildFor',
          text:
              'Logical grid position. Two integer indices — xIndex, yIndex — '
              'that identify the child regardless of pixel position. Traversal '
              'order (row-major vs column-major) is derived from mainAxis.',
        ),
        _TwoDVpPdField(
          name: 'paintOffset',
          type: 'Offset?',
          role: 'computed by updateChildPaintData',
          text:
              'Where paint() should actually place the child. Derived from '
              'layoutOffset, but flipped for AxisDirection.up or '
              'AxisDirection.left. If you override paint() in a 2D viewport, '
              'this is the offset you want — never layoutOffset directly.',
        ),
        _TwoDVpPdField(
          name: 'isVisible',
          type: 'bool (getter)',
          role: 'true iff paintExtent is non-zero',
          text:
              'Visible means any of the child actually survives the clip. '
              'Children in the cacheExtent but outside the viewport report '
              'false. paint() skips invisible children for free.',
        ),
        _TwoDVpPdField(
          name: 'keepAlive',
          type: 'bool',
          role: 'from KeepAliveParentDataMixin',
          text:
              'If true, the viewport retains the child even when invisible. '
              'Essential for preserving state inside off-screen cells — e.g., '
              'a partially filled form still mounted just out of view.',
        ),
      ],
    );
  }
}

class _TwoDVpPdField extends StatelessWidget {
  const _TwoDVpPdField({
    required this.name,
    required this.type,
    required this.role,
    required this.text,
  });

  final String name;
  final String type;
  final String role;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _twoDVpPdBlueprint.withValues(alpha: 0.55),
          border: Border(
            left: BorderSide(color: _twoDVpPdBrass, width: 2),
            top: BorderSide(
              color: _twoDVpPdBrass.withValues(alpha: 0.25),
              width: 1,
            ),
            right: BorderSide(
              color: _twoDVpPdBrass.withValues(alpha: 0.25),
              width: 1,
            ),
            bottom: BorderSide(
              color: _twoDVpPdBrass.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    color: _twoDVpPdIvory,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  ': $type',
                  style: const TextStyle(
                    color: _twoDVpPdBrass,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '— $role',
              style: const TextStyle(
                color: _twoDVpPdChalk,
                fontSize: 11,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                color: _twoDVpPdIvorySoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Controls card — interactive knobs for the demo.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdControlsCard extends StatelessWidget {
  const _TwoDVpPdControlsCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'CONTROLS · mutate viewport & observe parent data',
      subtitle: 'cell size, column/row count, cull mode, annotation toggles',
      stamp: 'PLATE 03',
      body: _TwoDVpPdControlsBody(),
    );
  }
}

class _TwoDVpPdControlsBody extends StatelessWidget {
  const _TwoDVpPdControlsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TwoDVpPdCellSizeDropdown(),
        const SizedBox(height: 14),
        _TwoDVpPdColRowSliders(),
        const SizedBox(height: 14),
        _TwoDVpPdScrollSliders(),
        const SizedBox(height: 14),
        _TwoDVpPdToggleRow(),
      ],
    );
  }
}

class _TwoDVpPdCellSizeDropdown extends StatelessWidget {
  const _TwoDVpPdCellSizeDropdown();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _twoDVpPdCellSize,
      builder: (BuildContext context, double value, Widget? _) {
        return Row(
          children: <Widget>[
            const SizedBox(
              width: 100,
              child: Text(
                'cell size',
                style: TextStyle(color: _twoDVpPdBrass, fontSize: 12),
              ),
            ),
            const SizedBox(width: 12),
            DropdownButton<double>(
              value: value,
              dropdownColor: _twoDVpPdBlueprintDeep,
              style: const TextStyle(
                color: _twoDVpPdIvory,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              underline: Container(height: 1, color: _twoDVpPdBrass),
              onChanged: (double? next) {
                if (next == null) {
                  return;
                }
                _twoDVpPdCellSize.value = next;
                _twoDVpPdAppendConsole(
                  '[controls] cellSize := ${next.toStringAsFixed(0)} → '
                  'layoutOffset of every cell must be recomputed',
                );
              },
              items: const <DropdownMenuItem<double>>[
                DropdownMenuItem<double>(value: 56, child: Text('56 px')),
                DropdownMenuItem<double>(value: 64, child: Text('64 px')),
                DropdownMenuItem<double>(value: 76, child: Text('76 px')),
                DropdownMenuItem<double>(value: 88, child: Text('88 px')),
                DropdownMenuItem<double>(value: 104, child: Text('104 px')),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'larger cells → fewer fit before layoutOffset leaves viewport',
                style: TextStyle(
                  color: _twoDVpPdIvorySoft.withValues(alpha: 0.7),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdColRowSliders extends StatelessWidget {
  const _TwoDVpPdColRowSliders();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TwoDVpPdLabeledSlider(
          label: 'columns',
          listenable: _twoDVpPdCols,
          min: 3,
          max: 12,
          divisions: 9,
        ),
        _TwoDVpPdLabeledSlider(
          label: 'rows',
          listenable: _twoDVpPdRows,
          min: 3,
          max: 12,
          divisions: 9,
        ),
      ],
    );
  }
}

class _TwoDVpPdLabeledSlider extends StatelessWidget {
  const _TwoDVpPdLabeledSlider({
    required this.label,
    required this.listenable,
    required this.min,
    required this.max,
    required this.divisions,
  });

  final String label;
  final ValueNotifier<int> listenable;
  final int min;
  final int max;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: listenable,
      builder: (BuildContext context, int value, Widget? _) {
        return Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: _twoDVpPdBrass,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: _twoDVpPdBrass,
                  inactiveTrackColor: _twoDVpPdBrass.withValues(alpha: 0.3),
                  thumbColor: _twoDVpPdIvory,
                  overlayColor: _twoDVpPdBrass.withValues(alpha: 0.15),
                  valueIndicatorColor: _twoDVpPdRedInk,
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: divisions,
                  label: '$value',
                  onChanged: (double next) {
                    listenable.value = next.round();
                    _twoDVpPdAppendConsole(
                      '[controls] $label := ${listenable.value} → '
                      'parentData count changes, setupParentData re-runs',
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: _twoDVpPdIvory,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdScrollSliders extends StatelessWidget {
  const _TwoDVpPdScrollSliders();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TwoDVpPdDoubleSlider(
          label: 'h offset',
          listenable: _twoDVpPdHorizontalScroll,
          min: 0,
          max: 600,
        ),
        _TwoDVpPdDoubleSlider(
          label: 'v offset',
          listenable: _twoDVpPdVerticalScroll,
          min: 0,
          max: 600,
        ),
      ],
    );
  }
}

class _TwoDVpPdDoubleSlider extends StatelessWidget {
  const _TwoDVpPdDoubleSlider({
    required this.label,
    required this.listenable,
    required this.min,
    required this.max,
  });

  final String label;
  final ValueNotifier<double> listenable;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: listenable,
      builder: (BuildContext context, double value, Widget? _) {
        return Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: _twoDVpPdBrass,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: _twoDVpPdRedInk,
                  inactiveTrackColor: _twoDVpPdRedInk.withValues(alpha: 0.25),
                  thumbColor: _twoDVpPdIvory,
                  overlayColor: _twoDVpPdRedInk.withValues(alpha: 0.15),
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: (double next) {
                    listenable.value = next;
                  },
                ),
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                value.toStringAsFixed(0),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: _twoDVpPdIvory,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdToggleRow extends StatelessWidget {
  const _TwoDVpPdToggleRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 18,
      runSpacing: 12,
      children: <Widget>[
        _TwoDVpPdSwitchTile(
          label: 'cull offscreen',
          description: 'flips parentData.isVisible to false outside viewport',
          listenable: _twoDVpPdCullOffscreen,
        ),
        _TwoDVpPdSwitchTile(
          label: 'show offsets',
          description: 'paint parentData.layoutOffset over each cell',
          listenable: _twoDVpPdShowOffsets,
        ),
        _TwoDVpPdSwitchTile(
          label: 'show vectors',
          description: 'draw vector from origin to each child layoutOffset',
          listenable: _twoDVpPdShowVectors,
        ),
      ],
    );
  }
}

class _TwoDVpPdSwitchTile extends StatelessWidget {
  const _TwoDVpPdSwitchTile({
    required this.label,
    required this.description,
    required this.listenable,
  });

  final String label;
  final String description;
  final ValueNotifier<bool> listenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: listenable,
      builder: (BuildContext context, bool value, Widget? _) {
        return SizedBox(
          width: 240,
          child: Row(
            children: <Widget>[
              Switch(
                value: value,
                activeThumbColor: _twoDVpPdBrass,
                activeTrackColor: _twoDVpPdBrass.withValues(alpha: 0.4),
                inactiveThumbColor: _twoDVpPdChalk,
                inactiveTrackColor: _twoDVpPdFaded,
                onChanged: (bool next) {
                  listenable.value = next;
                  _twoDVpPdAppendConsole(
                    '[toggle] $label := $next',
                  );
                },
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      label,
                      style: const TextStyle(
                        color: _twoDVpPdIvory,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: _twoDVpPdIvorySoft.withValues(alpha: 0.7),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Live grid card — the centerpiece. A hand-authored viewport-like render
// object that assigns parent data with layoutOffset per child.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdLiveGridCard extends StatelessWidget {
  const _TwoDVpPdLiveGridCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'LIVE GRID · layoutChildSequence in action',
      subtitle: 'each cell overlays its parentData.layoutOffset',
      stamp: 'PLATE 04',
      body: _TwoDVpPdLiveGridBody(),
    );
  }
}

class _TwoDVpPdLiveGridBody extends StatelessWidget {
  const _TwoDVpPdLiveGridBody();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _twoDVpPdCellSize,
        _twoDVpPdCols,
        _twoDVpPdRows,
        _twoDVpPdCullOffscreen,
        _twoDVpPdShowOffsets,
        _twoDVpPdHorizontalScroll,
        _twoDVpPdVerticalScroll,
      ]),
      builder: (BuildContext context, Widget? _) {
        final _TwoDVpPdViewportSpec spec = _TwoDVpPdViewportSpec(
          cellSize: _twoDVpPdCellSize.value,
          cols: _twoDVpPdCols.value,
          rows: _twoDVpPdRows.value,
          horizontalOffset: _twoDVpPdHorizontalScroll.value,
          verticalOffset: _twoDVpPdVerticalScroll.value,
          visibleWidth: 420,
          visibleHeight: 300,
          cullOffscreen: _twoDVpPdCullOffscreen.value,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '// simulated layoutChildSequence',
              style: TextStyle(
                color: _twoDVpPdChalk,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            _TwoDVpPdSimulatedViewport(spec: spec),
            const SizedBox(height: 14),
            _TwoDVpPdLiveLegend(),
            const SizedBox(height: 10),
            _TwoDVpPdLiveSummary(spec: spec),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdLiveLegend extends StatelessWidget {
  const _TwoDVpPdLiveLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: const <Widget>[
        _TwoDVpPdLegendChip(
          color: _twoDVpPdBrass,
          label: 'visible · parentData.layoutOffset shown',
        ),
        _TwoDVpPdLegendChip(
          color: _twoDVpPdFaded,
          label: 'culled · isVisible = false',
        ),
        _TwoDVpPdLegendChip(
          color: _twoDVpPdRedInk,
          label: 'selected · tap to inspect',
        ),
      ],
    );
  }
}

class _TwoDVpPdLegendChip extends StatelessWidget {
  const _TwoDVpPdLegendChip({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        color: color.withValues(alpha: 0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 8, height: 8, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 10.5, letterSpacing: 0.3),
          ),
        ],
      ),
    );
  }
}

class _TwoDVpPdLiveSummary extends StatelessWidget {
  const _TwoDVpPdLiveSummary({required this.spec});

  final _TwoDVpPdViewportSpec spec;

  @override
  Widget build(BuildContext context) {
    int visibleCount = 0;
    int culledCount = 0;
    for (int y = 0; y < spec.rows; y++) {
      for (int x = 0; x < spec.cols; x++) {
        final _TwoDVpPdVicinity v = _TwoDVpPdVicinity(xIndex: x, yIndex: y);
        if (spec.isVisibleFor(v)) {
          visibleCount++;
        } else {
          culledCount++;
        }
      }
    }
    return Row(
      children: <Widget>[
        _TwoDVpPdStat(label: 'children', value: '${spec.cols * spec.rows}'),
        const SizedBox(width: 14),
        _TwoDVpPdStat(label: 'visible', value: '$visibleCount'),
        const SizedBox(width: 14),
        _TwoDVpPdStat(label: 'culled', value: '$culledCount'),
        const SizedBox(width: 14),
        _TwoDVpPdStat(
          label: 'scroll',
          value:
              '(${spec.horizontalOffset.toStringAsFixed(0)},'
              '${spec.verticalOffset.toStringAsFixed(0)})',
        ),
      ],
    );
  }
}

class _TwoDVpPdStat extends StatelessWidget {
  const _TwoDVpPdStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _twoDVpPdBlueprint.withValues(alpha: 0.5),
        border: Border.all(color: _twoDVpPdBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _twoDVpPdChalk,
              fontSize: 10,
              letterSpacing: 0.4,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _twoDVpPdIvory,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Simulated viewport widget. Renders the clipped window of cells.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdSimulatedViewport extends StatelessWidget {
  const _TwoDVpPdSimulatedViewport({required this.spec});

  final _TwoDVpPdViewportSpec spec;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: spec.visibleWidth,
        height: spec.visibleHeight,
        decoration: BoxDecoration(
          color: _twoDVpPdBlueprint.withValues(alpha: 0.4),
          border: Border.all(color: _twoDVpPdBrass, width: 1),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            const Positioned.fill(child: _TwoDVpPdViewportGridPaint()),
            ..._buildCells(),
            const Positioned(
              right: 6,
              top: 4,
              child: Text(
                'viewport origin (0,0) ↖',
                style: TextStyle(
                  color: _twoDVpPdIvorySoft,
                  fontSize: 10,
                ),
              ),
            ),
            const Positioned(
              left: 6,
              bottom: 4,
              child: Text(
                'RenderTwoDimensionalViewport analogue · clipBehavior=hardEdge',
                style: TextStyle(
                  color: _twoDVpPdChalk,
                  fontSize: 9.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCells() {
    final List<Widget> cells = <Widget>[];
    for (int y = 0; y < spec.rows; y++) {
      for (int x = 0; x < spec.cols; x++) {
        final _TwoDVpPdVicinity v = _TwoDVpPdVicinity(xIndex: x, yIndex: y);
        final Offset offset = spec.layoutOffsetFor(v);
        final bool visible = spec.isVisibleFor(v);
        cells.add(
          Positioned(
            left: offset.dx,
            top: offset.dy,
            width: spec.cellSize,
            height: spec.cellSize,
            child: _TwoDVpPdCellWidget(
              vicinity: v,
              layoutOffset: offset,
              visible: visible,
            ),
          ),
        );
      }
    }
    return cells;
  }
}

class _TwoDVpPdViewportGridPaint extends StatelessWidget {
  const _TwoDVpPdViewportGridPaint();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _TwoDVpPdViewportGridPainter());
  }
}

class _TwoDVpPdViewportGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint minor = Paint()
      ..color = _twoDVpPdBrass.withValues(alpha: 0.08)
      ..strokeWidth = 0.5;
    const double step = 20;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minor);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }
    // origin marker
    final Paint origin = Paint()
      ..color = _twoDVpPdRedInk
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset.zero, const Offset(18, 0), origin);
    canvas.drawLine(Offset.zero, const Offset(0, 18), origin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ───────────────────────────────────────────────────────────────────────────
// Cell widget — tap selects, style driven by isVisible.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdCellWidget extends StatelessWidget {
  const _TwoDVpPdCellWidget({
    required this.vicinity,
    required this.layoutOffset,
    required this.visible,
  });

  final _TwoDVpPdVicinity vicinity;
  final Offset layoutOffset;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_TwoDVpPdVicinity?>(
      valueListenable: _twoDVpPdSelectedCell,
      builder: (BuildContext context, _TwoDVpPdVicinity? selected, Widget? _) {
        final bool isSelected = selected == vicinity;
        final Color border = isSelected
            ? _twoDVpPdRedInk
            : (visible ? _twoDVpPdBrass : _twoDVpPdFaded);
        final Color fill = visible
            ? _twoDVpPdBrass.withValues(alpha: 0.18)
            : _twoDVpPdFaded.withValues(alpha: 0.15);
        return GestureDetector(
          onTap: () {
            _twoDVpPdSelectedCell.value = vicinity;
            _twoDVpPdAppendConsole(
              '[tap] parentDataOf($vicinity) → '
              'layoutOffset=${_twoDVpPdFormatOffset(layoutOffset)} · '
              'isVisible=$visible',
            );
          },
          child: Container(
            margin: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: fill,
              border: Border.all(
                color: border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '(${vicinity.xIndex},${vicinity.yIndex})',
                      style: TextStyle(
                        color: visible ? _twoDVpPdIvory : _twoDVpPdChalk,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _twoDVpPdShowOffsets,
                  builder: (BuildContext context, bool show, Widget? _) {
                    if (!show) {
                      return const SizedBox.shrink();
                    }
                    return Positioned(
                      left: 2,
                      top: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 1,
                        ),
                        color: _twoDVpPdBlueprintDeep.withValues(alpha: 0.7),
                        child: Text(
                          _twoDVpPdFormatOffset(layoutOffset),
                          style: TextStyle(
                            color: visible
                                ? _twoDVpPdRedInk
                                : _twoDVpPdIvorySoft.withValues(alpha: 0.6),
                            fontSize: 8.5,
                            height: 1.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (!visible)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Text(
                      'isVisible=false',
                      style: TextStyle(
                        color: _twoDVpPdIvorySoft.withValues(alpha: 0.7),
                        fontSize: 8,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _twoDVpPdFormatOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(0)}, ${o.dy.toStringAsFixed(0)})';
}

// ───────────────────────────────────────────────────────────────────────────
// Inspector card — shows parent data for the currently selected cell.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdInspectorCard extends StatelessWidget {
  const _TwoDVpPdInspectorCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'INSPECTOR · parentDataOf(selected)',
      subtitle: 'live mirror of TwoDimensionalViewportParentData fields',
      stamp: 'PLATE 05',
      body: _TwoDVpPdInspectorBody(),
    );
  }
}

class _TwoDVpPdInspectorBody extends StatelessWidget {
  const _TwoDVpPdInspectorBody();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _twoDVpPdSelectedCell,
        _twoDVpPdCellSize,
        _twoDVpPdCols,
        _twoDVpPdRows,
        _twoDVpPdCullOffscreen,
        _twoDVpPdHorizontalScroll,
        _twoDVpPdVerticalScroll,
      ]),
      builder: (BuildContext context, Widget? _) {
        final _TwoDVpPdVicinity? sel = _twoDVpPdSelectedCell.value;
        if (sel == null) {
          return const Text(
            'tap a cell in the live grid to inspect its parent data.',
            style: TextStyle(color: _twoDVpPdIvorySoft, fontSize: 12.5),
          );
        }
        final _TwoDVpPdViewportSpec spec = _TwoDVpPdViewportSpec(
          cellSize: _twoDVpPdCellSize.value,
          cols: _twoDVpPdCols.value,
          rows: _twoDVpPdRows.value,
          horizontalOffset: _twoDVpPdHorizontalScroll.value,
          verticalOffset: _twoDVpPdVerticalScroll.value,
          visibleWidth: 420,
          visibleHeight: 300,
          cullOffscreen: _twoDVpPdCullOffscreen.value,
        );
        final Offset offset = spec.layoutOffsetFor(sel);
        final bool visible = spec.isVisibleFor(sel);
        final _TwoDVpPdRecord record = _TwoDVpPdRecord(
          vicinity: sel,
          layoutOffset: offset,
          paintOffset: offset,
          isVisible: visible,
          keepAlive: false,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TwoDVpPdInspectorRow(
              name: 'vicinity',
              value: record.vicinity.toString(),
            ),
            _TwoDVpPdInspectorRow(
              name: 'layoutOffset',
              value: _twoDVpPdFormatOffset(record.layoutOffset),
            ),
            _TwoDVpPdInspectorRow(
              name: 'paintOffset',
              value: _twoDVpPdFormatOffset(record.paintOffset),
            ),
            _TwoDVpPdInspectorRow(
              name: 'isVisible',
              value: record.isVisible.toString(),
            ),
            _TwoDVpPdInspectorRow(
              name: 'keepAlive',
              value: record.keepAlive.toString(),
            ),
            _TwoDVpPdInspectorRow(
              name: '_previousSibling',
              value: _twoDVpPdSiblingLabel(spec, sel, -1),
            ),
            _TwoDVpPdInspectorRow(
              name: '_nextSibling',
              value: _twoDVpPdSiblingLabel(spec, sel, 1),
            ),
            const SizedBox(height: 8),
            Text(
              'Note: in the real framework, both sibling pointers are RenderBox '
              'refs linked in mainAxis traversal order by the render object '
              'during layoutChildSequence. Here they are shown as vicinity '
              'labels for brevity.',
              style: TextStyle(
                color: _twoDVpPdIvorySoft.withValues(alpha: 0.7),
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }
}

String _twoDVpPdSiblingLabel(
  _TwoDVpPdViewportSpec spec,
  _TwoDVpPdVicinity v,
  int delta,
) {
  // Row-major traversal: next moves right, wraps down.
  final int flat = v.yIndex * spec.cols + v.xIndex + delta;
  if (flat < 0 || flat >= spec.cols * spec.rows) {
    return 'null';
  }
  final int nextY = flat ~/ spec.cols;
  final int nextX = flat % spec.cols;
  return 'RenderBox → ($nextX,$nextY)';
}

class _TwoDVpPdInspectorRow extends StatelessWidget {
  const _TwoDVpPdInspectorRow({
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              '.$name',
              style: const TextStyle(
                color: _twoDVpPdBrass,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            '=',
            style: TextStyle(
              color: _twoDVpPdChalk,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _twoDVpPdIvory,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Cull demo card — side-by-side comparison of cull on vs off.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdCullDemoCard extends StatelessWidget {
  const _TwoDVpPdCullDemoCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'CULL · isVisible drives paint skip',
      subtitle: 'flip the top-level switch and compare the two windows',
      stamp: 'PLATE 06',
      body: _TwoDVpPdCullDemoBody(),
    );
  }
}

class _TwoDVpPdCullDemoBody extends StatelessWidget {
  const _TwoDVpPdCullDemoBody();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _twoDVpPdCellSize,
        _twoDVpPdCols,
        _twoDVpPdRows,
        _twoDVpPdHorizontalScroll,
        _twoDVpPdVerticalScroll,
      ]),
      builder: (BuildContext context, Widget? _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Left: cullOffscreen=true — children outside visible bounds '
              'report isVisible=false and are dimmed.  Right: no culling — '
              'every child paints, even outside the viewport box, with '
              'RenderRepaintBoundary-style waste.',
              style: TextStyle(
                color: _twoDVpPdIvorySoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _TwoDVpPdCullSide(
                    label: 'cullOffscreen = true',
                    spec: _TwoDVpPdViewportSpec(
                      cellSize: _twoDVpPdCellSize.value,
                      cols: _twoDVpPdCols.value,
                      rows: _twoDVpPdRows.value,
                      horizontalOffset: _twoDVpPdHorizontalScroll.value,
                      verticalOffset: _twoDVpPdVerticalScroll.value,
                      visibleWidth: 240,
                      visibleHeight: 180,
                      cullOffscreen: true,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _TwoDVpPdCullSide(
                    label: 'cullOffscreen = false',
                    spec: _TwoDVpPdViewportSpec(
                      cellSize: _twoDVpPdCellSize.value,
                      cols: _twoDVpPdCols.value,
                      rows: _twoDVpPdRows.value,
                      horizontalOffset: _twoDVpPdHorizontalScroll.value,
                      verticalOffset: _twoDVpPdVerticalScroll.value,
                      visibleWidth: 240,
                      visibleHeight: 180,
                      cullOffscreen: false,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdCullSide extends StatelessWidget {
  const _TwoDVpPdCullSide({required this.label, required this.spec});

  final String label;
  final _TwoDVpPdViewportSpec spec;

  @override
  Widget build(BuildContext context) {
    int painted = 0;
    for (int y = 0; y < spec.rows; y++) {
      for (int x = 0; x < spec.cols; x++) {
        if (spec.isVisibleFor(_TwoDVpPdVicinity(xIndex: x, yIndex: y))) {
          painted++;
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _twoDVpPdBrass,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        ClipRect(
          child: Container(
            width: spec.visibleWidth,
            height: spec.visibleHeight,
            decoration: BoxDecoration(
              color: _twoDVpPdBlueprint.withValues(alpha: 0.4),
              border: Border.all(color: _twoDVpPdBrass.withValues(alpha: 0.6)),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: _TwoDVpPdCullSide._build(spec),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'painted: $painted / ${spec.cols * spec.rows}',
          style: const TextStyle(
            color: _twoDVpPdIvory,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  static List<Widget> _build(_TwoDVpPdViewportSpec spec) {
    final List<Widget> out = <Widget>[];
    for (int y = 0; y < spec.rows; y++) {
      for (int x = 0; x < spec.cols; x++) {
        final _TwoDVpPdVicinity v = _TwoDVpPdVicinity(xIndex: x, yIndex: y);
        final Offset o = spec.layoutOffsetFor(v);
        final bool visible = spec.isVisibleFor(v);
        out.add(Positioned(
          left: o.dx,
          top: o.dy,
          width: spec.cellSize,
          height: spec.cellSize,
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: visible
                  ? _twoDVpPdBrass.withValues(alpha: 0.18)
                  : _twoDVpPdFaded.withValues(alpha: 0.15),
              border: Border.all(
                color: visible ? _twoDVpPdBrass : _twoDVpPdFaded,
                width: 0.8,
              ),
            ),
            child: Center(
              child: Text(
                '${v.xIndex},${v.yIndex}',
                style: TextStyle(
                  color: visible ? _twoDVpPdIvory : _twoDVpPdChalk,
                  fontSize: 9,
                ),
              ),
            ),
          ),
        ));
      }
    }
    return out;
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Vector field card — CustomPainter drawing layoutOffset vectors.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdVectorFieldCard extends StatelessWidget {
  const _TwoDVpPdVectorFieldCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'FIELD DIAGRAM · parentData.layoutOffset as vectors',
      subtitle: 'each arrow connects the viewport origin to a child top-left',
      stamp: 'PLATE 07',
      body: _TwoDVpPdVectorFieldBody(),
    );
  }
}

class _TwoDVpPdVectorFieldBody extends StatelessWidget {
  const _TwoDVpPdVectorFieldBody();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _twoDVpPdCellSize,
        _twoDVpPdCols,
        _twoDVpPdRows,
        _twoDVpPdHorizontalScroll,
        _twoDVpPdVerticalScroll,
        _twoDVpPdShowVectors,
        _twoDVpPdCullOffscreen,
      ]),
      builder: (BuildContext context, Widget? _) {
        final _TwoDVpPdViewportSpec spec = _TwoDVpPdViewportSpec(
          cellSize: _twoDVpPdCellSize.value,
          cols: _twoDVpPdCols.value,
          rows: _twoDVpPdRows.value,
          horizontalOffset: _twoDVpPdHorizontalScroll.value,
          verticalOffset: _twoDVpPdVerticalScroll.value,
          visibleWidth: 420,
          visibleHeight: 300,
          cullOffscreen: _twoDVpPdCullOffscreen.value,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: spec.visibleWidth,
              height: spec.visibleHeight,
              child: CustomPaint(
                painter: _TwoDVpPdVectorFieldPainter(
                  spec: spec,
                  drawVectors: _twoDVpPdShowVectors.value,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Arrows originate at the red origin marker and tip at each '
              'child.layoutOffset. Brass arrows = visible children; faded '
              'arrows = culled children. Toggle the "show vectors" switch '
              'to compare against a pure annotation view.',
              style: TextStyle(
                color: _twoDVpPdIvorySoft,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TwoDVpPdVectorFieldPainter extends CustomPainter {
  _TwoDVpPdVectorFieldPainter({
    required this.spec,
    required this.drawVectors,
  });

  final _TwoDVpPdViewportSpec spec;
  final bool drawVectors;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _twoDVpPdBlueprint.withValues(alpha: 0.4);
    canvas.drawRect(Offset.zero & size, bg);

    // grid
    final Paint minor = Paint()
      ..color = _twoDVpPdBrass.withValues(alpha: 0.08)
      ..strokeWidth = 0.4;
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minor);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }

    // frame
    final Paint frame = Paint()
      ..color = _twoDVpPdBrass
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(Offset.zero & size, frame);

    // origin marker
    final Offset origin = const Offset(12, 12);
    final Paint originPaint = Paint()
      ..color = _twoDVpPdRedInk
      ..strokeWidth = 2;
    canvas.drawLine(origin - const Offset(6, 0), origin + const Offset(6, 0),
        originPaint);
    canvas.drawLine(origin - const Offset(0, 6), origin + const Offset(0, 6),
        originPaint);

    // vectors
    final Paint visiblePaint = Paint()
      ..color = _twoDVpPdBrass
      ..strokeWidth = 1.1;
    final Paint culledPaint = Paint()
      ..color = _twoDVpPdFaded.withValues(alpha: 0.6)
      ..strokeWidth = 0.8;

    for (int y = 0; y < spec.rows; y++) {
      for (int x = 0; x < spec.cols; x++) {
        final _TwoDVpPdVicinity v = _TwoDVpPdVicinity(xIndex: x, yIndex: y);
        final Offset lo = spec.layoutOffsetFor(v);
        final Offset endPoint = Offset(
          (origin.dx + lo.dx).clamp(0.0, size.width - 1),
          (origin.dy + lo.dy).clamp(0.0, size.height - 1),
        );
        final bool visible = spec.isVisibleFor(v);
        final Paint chosen = visible ? visiblePaint : culledPaint;
        if (drawVectors) {
          canvas.drawLine(origin, endPoint, chosen);
          _paintArrowhead(canvas, origin, endPoint, chosen);
        }
        // a dot at the child position
        final Paint dotPaint = Paint()
          ..color =
              visible ? _twoDVpPdBrass : _twoDVpPdFaded.withValues(alpha: 0.7);
        canvas.drawCircle(endPoint, 2.5, dotPaint);
      }
    }

    // legend
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'origin ⇢ layoutOffset',
        style: TextStyle(
          color: _twoDVpPdRedInk,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width - tp.width - 6, 4));
  }

  void _paintArrowhead(Canvas canvas, Offset from, Offset to, Paint paint) {
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double len = (dx * dx + dy * dy);
    if (len < 4) {
      return;
    }
    final double invLen = 1.0 / (0.0001 + _sqrtApprox(len));
    final double ux = dx * invLen;
    final double uy = dy * invLen;
    const double headLen = 5;
    final Offset p1 = Offset(
      to.dx - ux * headLen - uy * 3,
      to.dy - uy * headLen + ux * 3,
    );
    final Offset p2 = Offset(
      to.dx - ux * headLen + uy * 3,
      to.dy - uy * headLen - ux * 3,
    );
    canvas.drawLine(to, p1, paint);
    canvas.drawLine(to, p2, paint);
  }

  double _sqrtApprox(double v) {
    double x = v;
    double y = 1.0;
    const double eps = 1e-4;
    while (x - y > eps) {
      x = (x + y) / 2.0;
      y = v / x;
    }
    return x;
  }

  @override
  bool shouldRepaint(covariant _TwoDVpPdVectorFieldPainter oldDelegate) {
    return oldDelegate.spec.cellSize != spec.cellSize ||
        oldDelegate.spec.cols != spec.cols ||
        oldDelegate.spec.rows != spec.rows ||
        oldDelegate.spec.horizontalOffset != spec.horizontalOffset ||
        oldDelegate.spec.verticalOffset != spec.verticalOffset ||
        oldDelegate.spec.cullOffscreen != spec.cullOffscreen ||
        oldDelegate.drawVectors != drawVectors;
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Lifecycle card — explains parentDataOf / setupParentData / layoutChildSequence.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdLifecycleCard extends StatelessWidget {
  const _TwoDVpPdLifecycleCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'LIFECYCLE · how the framework touches parentData',
      subtitle: 'setupParentData → buildOrObtainChildFor → layoutChildSequence → paint',
      stamp: 'PLATE 08',
      body: _TwoDVpPdLifecycleBody(),
    );
  }
}

class _TwoDVpPdLifecycleBody extends StatelessWidget {
  const _TwoDVpPdLifecycleBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _TwoDVpPdLifecycleStep(
          index: 1,
          title: 'setupParentData(RenderBox child)',
          text:
              'RenderTwoDimensionalViewport overrides setupParentData to '
              'replace child.parentData with a fresh '
              'TwoDimensionalViewportParentData instance if it is not already '
              'one. This happens whenever a child is first attached to the '
              'viewport.',
        ),
        _TwoDVpPdLifecycleStep(
          index: 2,
          title: 'buildOrObtainChildFor(ChildVicinity v)',
          text:
              'During layout, the viewport asks its delegate for the widget '
              'at vicinity v. The returned child is adopted; the viewport '
              'writes parentData.vicinity = v immediately.',
        ),
        _TwoDVpPdLifecycleStep(
          index: 3,
          title: 'layoutChildSequence()',
          text:
              'Subclass-defined. It walks children in row-major or '
              'column-major order, layouts each child against its '
              'BoxConstraints, and assigns parentData.layoutOffset — the '
              'most important write of the whole frame.',
        ),
        _TwoDVpPdLifecycleStep(
          index: 4,
          title: 'updateChildPaintData()',
          text:
              'After layoutChildSequence, the base class walks the children '
              'again, computing parentData.paintOffset (which differs from '
              'layoutOffset only in reverse axis directions) and '
              'parentData._paintExtent (which drives isVisible).',
        ),
        _TwoDVpPdLifecycleStep(
          index: 5,
          title: 'paint(PaintingContext, Offset)',
          text:
              'paint iterates visible children, reads parentData.paintOffset, '
              'and calls context.paintChild. Culled children — '
              'parentData.isVisible = false — are skipped entirely.',
        ),
        _TwoDVpPdLifecycleStep(
          index: 6,
          title: 'dispose / KeepAlive',
          text:
              'If the delegate no longer needs a vicinity, the viewport '
              'drops the child unless parentData.keepAlive is true. '
              'KeepAliveParentDataMixin preserves state (e.g., a form still '
              'partially filled) while the child is off-screen.',
        ),
      ],
    );
  }
}

class _TwoDVpPdLifecycleStep extends StatelessWidget {
  const _TwoDVpPdLifecycleStep({
    required this.index,
    required this.title,
    required this.text,
  });

  final int index;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _twoDVpPdBrass.withValues(alpha: 0.15),
              border: Border.all(color: _twoDVpPdBrass, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _twoDVpPdBrass,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _twoDVpPdIvory,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: const TextStyle(
                    color: _twoDVpPdIvorySoft,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Console card — debugPrint history of synthetic parent-data operations.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdConsoleCard extends StatelessWidget {
  const _TwoDVpPdConsoleCard();

  @override
  Widget build(BuildContext context) {
    return const _TwoDVpPdCard(
      title: 'CONSOLE · debugPrint trace',
      subtitle: 'tap cells or flip switches to generate entries',
      stamp: 'PLATE 09',
      body: _TwoDVpPdConsoleBody(),
    );
  }
}

class _TwoDVpPdConsoleBody extends StatelessWidget {
  const _TwoDVpPdConsoleBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                _twoDVpPdConsole.value = <String>[];
                _twoDVpPdAppendConsole('[console] cleared');
              },
              style: TextButton.styleFrom(
                foregroundColor: _twoDVpPdRedInk,
              ),
              child: const Text('clear'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                _twoDVpPdAppendConsole(
                  '[sim] layoutChildSequence() completed in '
                  '${(1 + (_twoDVpPdCols.value * _twoDVpPdRows.value) ~/ 4)}ms',
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: _twoDVpPdBrass,
              ),
              child: const Text('simulate layout'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                _twoDVpPdAppendConsole(
                  '[sim] updateChildPaintData() recomputed paintOffset for '
                  '${_twoDVpPdCols.value * _twoDVpPdRows.value} children',
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: _twoDVpPdChalk,
              ),
              child: const Text('simulate paint-data'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: _twoDVpPdBlueprint.withValues(alpha: 0.55),
            border: Border.all(color: _twoDVpPdBrass.withValues(alpha: 0.4)),
          ),
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _twoDVpPdConsole,
            builder:
                (BuildContext context, List<String> lines, Widget? _) {
              return ListView.builder(
                padding: const EdgeInsets.all(6),
                reverse: true,
                itemCount: lines.length,
                itemBuilder: (BuildContext context, int idx) {
                  final String line = lines[lines.length - 1 - idx];
                  final Color c = line.startsWith('[tap]')
                      ? _twoDVpPdRedInk
                      : line.startsWith('[sim]')
                          ? _twoDVpPdChalk
                          : line.startsWith('[toggle]')
                              ? _twoDVpPdBrass
                              : _twoDVpPdIvorySoft;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.5),
                    child: Text(
                      line,
                      style: TextStyle(
                        color: c,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        height: 1.3,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void _twoDVpPdAppendConsole(String line) {
  final List<String> next = List<String>.from(_twoDVpPdConsole.value)..add(line);
  while (next.length > 80) {
    next.removeAt(0);
  }
  _twoDVpPdConsole.value = next;
  debugPrint('TwoDVpPd console: $line');
}

// ───────────────────────────────────────────────────────────────────────────
// Footer ribbon.
// ───────────────────────────────────────────────────────────────────────────

class _TwoDVpPdFooterRibbon extends StatelessWidget {
  const _TwoDVpPdFooterRibbon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _twoDVpPdBlueprintDeep,
        border: Border.all(color: _twoDVpPdBrass, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RELATED READING',
            style: TextStyle(
              color: _twoDVpPdRedInk,
              fontSize: 11,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const _TwoDVpPdBullet('RenderTwoDimensionalViewport — the base class '
              'that installs TwoDimensionalViewportParentData on every child.'),
          const _TwoDVpPdBullet('ChildVicinity — the two-integer identifier '
              'stored in parentData.vicinity.'),
          const _TwoDVpPdBullet('TwoDimensionalChildDelegate / '
              'TwoDimensionalChildManager — drive when children are built, '
              'and thus when new parentData payloads are installed.'),
          const _TwoDVpPdBullet('KeepAliveParentDataMixin — the mixin that '
              'adds the keepAlive flag and keptAlive getter.'),
          const SizedBox(height: 8),
          Text(
            'All offsets on this plate are computed purely in Dart from the '
            'viewport spec exposed via the top-level ValueNotifiers. The '
            'visual behavior is faithful to what a real '
            'RenderTwoDimensionalViewport writes into parentData during '
            'layoutChildSequence — only the RenderObject plumbing has been '
            'traded for simpler Positioned widgets to keep the AST script '
            'self-contained.',
            style: TextStyle(
              color: _twoDVpPdIvorySoft.withValues(alpha: 0.85),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
