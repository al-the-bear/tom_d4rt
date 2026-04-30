// D4rt test script: Deep Demo - TwoDimensionalChildManager
// Framed as a "Warehouse Rack Manager" running a SKU grid.
//
// TwoDimensionalChildManager is the abstract interface implemented by the
// Element of a TwoDimensionalViewport. It owns the lifecycle of child
// elements in a 2D lazy-scrolling viewport:
//
//   - _startLayout / _endLayout bracket a layout pass
//   - _buildChild(vicinity)  : build a brand-new element for a vicinity
//   - _reuseChild(vicinity)  : move an already-live element into the new
//                              pass' keep list
//
// Subclasses of RenderTwoDimensionalViewport call buildOrObtainChildFor
// during layoutChildSequence, and the manager (the element) decides whether
// that collapses into a _buildChild or a _reuseChild call. Children that
// are *not* reused during the pass are unmounted at _endLayout - that's
// the "remove" side of the ledger.
//
// Because the abstract members of TwoDimensionalChildManager are private,
// subclasses can only live inside the widgets library. So this demo works
// at the layer exposed to users: a concrete RenderTwoDimensionalViewport
// + TwoDimensionalChildBuilderDelegate, instrumented so we can observe
// the build / reuse / remove signals the manager sees.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// Theme tokens - warehouse red, gunmetal, steel, caution yellow.
// ---------------------------------------------------------------------------

const Color _twoDMgrBg = Color(0xFF171A1F);
const Color _twoDMgrPanel = Color(0xFF1F242B);
const Color _twoDMgrPanelDeep = Color(0xFF12151A);
const Color _twoDMgrSteel = Color(0xFF3D4753);
const Color _twoDMgrSteelLight = Color(0xFF6A7684);
const Color _twoDMgrInk = Color(0xFFE6EAF0);
const Color _twoDMgrInkMuted = Color(0xFFA4ADB8);
const Color _twoDMgrWarehouseRed = Color(0xFFB8342B);
const Color _twoDMgrWarehouseRedDeep = Color(0xFF7A1F19);
const Color _twoDMgrCaution = Color(0xFFF3C948);
const Color _twoDMgrCautionDeep = Color(0xFFB08A1D);
const Color _twoDMgrGridLine = Color(0xFF2C333C);
const Color _twoDMgrOkGreen = Color(0xFF49B37A);
const Color _twoDMgrReuseBlue = Color(0xFF4A8FB5);
const Color _twoDMgrRemoveGrey = Color(0xFF8893A0);

const TextStyle _twoDMgrMono = TextStyle(
  fontFamily: 'monospace',
  fontFamilyFallback: <String>['Courier', 'RobotoMono'],
  color: _twoDMgrInk,
  fontSize: 12,
  height: 1.2,
);

const TextStyle _twoDMgrMonoSmall = TextStyle(
  fontFamily: 'monospace',
  fontFamilyFallback: <String>['Courier', 'RobotoMono'],
  color: _twoDMgrInkMuted,
  fontSize: 10,
  height: 1.15,
);

const TextStyle _twoDMgrTitle = TextStyle(
  color: _twoDMgrCaution,
  fontSize: 18,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.4,
);

const TextStyle _twoDMgrSubtitle = TextStyle(
  color: _twoDMgrInk,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.2,
);

const TextStyle _twoDMgrBody = TextStyle(
  color: _twoDMgrInk,
  fontSize: 12.5,
  height: 1.4,
);

const TextStyle _twoDMgrBodyMuted = TextStyle(
  color: _twoDMgrInkMuted,
  fontSize: 12,
  height: 1.4,
);

// ---------------------------------------------------------------------------
// Telemetry model.
// ---------------------------------------------------------------------------

class _TwoDMgrTelemetry extends ChangeNotifier {
  int builds = 0;
  int reuses = 0;
  int removes = 0;
  int layoutPasses = 0;

  // Per-vicinity counters for the interior of the rack viewport.
  final Map<String, int> perCellBuilds = <String, int>{};
  final Map<String, int> perCellReuses = <String, int>{};

  // Timeline of (build, reuse, remove) samples for the scroll trace.
  final List<_TwoDMgrSample> samples = <_TwoDMgrSample>[];

  // Set of vicinities currently "alive" in the viewport's element map.
  final Set<String> liveVicinities = <String>{};

  // Used to distinguish the two demo instances.
  final String tag;

  _TwoDMgrTelemetry(this.tag);

  void noteBuild(int x, int y) {
    builds++;
    final String k = '$x:$y';
    perCellBuilds[k] = (perCellBuilds[k] ?? 0) + 1;
    liveVicinities.add(k);
    notifyListeners();
  }

  void noteReuse(int x, int y) {
    reuses++;
    final String k = '$x:$y';
    perCellReuses[k] = (perCellReuses[k] ?? 0) + 1;
    notifyListeners();
  }

  void noteRemove(int x, int y) {
    removes++;
    final String k = '$x:$y';
    liveVicinities.remove(k);
    notifyListeners();
  }

  void sample() {
    layoutPasses++;
    samples.add(_TwoDMgrSample(
      pass: layoutPasses,
      builds: builds,
      reuses: reuses,
      removes: removes,
      alive: liveVicinities.length,
    ));
    if (samples.length > 240) {
      samples.removeAt(0);
    }
    notifyListeners();
  }

  void reset() {
    builds = 0;
    reuses = 0;
    removes = 0;
    layoutPasses = 0;
    perCellBuilds.clear();
    perCellReuses.clear();
    samples.clear();
    liveVicinities.clear();
    notifyListeners();
  }
}

class _TwoDMgrSample {
  final int pass;
  final int builds;
  final int reuses;
  final int removes;
  final int alive;
  const _TwoDMgrSample({
    required this.pass,
    required this.builds,
    required this.reuses,
    required this.removes,
    required this.alive,
  });
}

// ---------------------------------------------------------------------------
// SKU generator - deterministic per vicinity.
// ---------------------------------------------------------------------------

String _twoDMgrSkuFor(int x, int y) {
  // Three-letter aisle prefix from x, zero-padded slot from y.
  const List<String> aisles = <String>[
    'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AJ', 'AK',
    'BA', 'BB', 'BC', 'BD', 'BE', 'BF', 'BG', 'BH', 'BJ', 'BK',
    'CA', 'CB', 'CC', 'CD', 'CE', 'CF', 'CG', 'CH', 'CJ', 'CK',
    'DA', 'DB', 'DC', 'DD', 'DE', 'DF', 'DG', 'DH', 'DJ', 'DK',
  ];
  final String aisle = aisles[x % aisles.length];
  final String slot = y.toString().padLeft(4, '0');
  return '$aisle-$slot';
}

String _twoDMgrCategoryFor(int x, int y) {
  const List<String> cats = <String>[
    'BOLT', 'NUT ', 'WASH', 'GASK', 'HOSE', 'VALV', 'CAP ', 'FILT',
    'BELT', 'BRNG', 'SEAL', 'CLMP', 'LUBE', 'COIL', 'FUSE', 'WIRE',
  ];
  return cats[(x * 7 + y * 3) % cats.length];
}

int _twoDMgrStockFor(int x, int y) {
  final int h = (x * 131 + y * 977 + 13) & 0x7FFFFFFF;
  return 1 + (h % 480);
}

// ---------------------------------------------------------------------------
// Counting builder delegate.
//
// TwoDimensionalChildBuilderDelegate.builder is invoked exactly when the
// manager's _buildChild branch fires - i.e. when the render object asked
// for a vicinity and there was no live element to reuse. So counting the
// calls to this builder is equivalent to counting _buildChild on the
// manager.
//
// _reuseChild and remove are inferred from the render-object-side
// bookkeeping below (see _TwoDMgrRenderWarehouseViewport).
// ---------------------------------------------------------------------------

class _TwoDMgrCountingDelegate extends TwoDimensionalChildBuilderDelegate {
  _TwoDMgrCountingDelegate({
    required this.telemetry,
    required int maxX,
    required int maxY,
    required bool keepAlives,
    required bool repaintBoundaries,
  }) : super(
          maxXIndex: maxX,
          maxYIndex: maxY,
          addAutomaticKeepAlives: keepAlives,
          addRepaintBoundaries: repaintBoundaries,
          builder: (BuildContext ctx, ChildVicinity v) {
            // Intentionally simple - the real widget is built below via
            // the instance builder; we have to pass a top-level closure
            // here so we override build() to route through our logger.
            return const SizedBox.shrink();
          },
        );

  final _TwoDMgrTelemetry telemetry;

  @override
  Widget? build(BuildContext context, ChildVicinity vicinity) {
    if (vicinity.xIndex < 0 ||
        vicinity.yIndex < 0 ||
        (maxXIndex != null && vicinity.xIndex > maxXIndex!) ||
        (maxYIndex != null && vicinity.yIndex > maxYIndex!)) {
      return null;
    }
    telemetry.noteBuild(vicinity.xIndex, vicinity.yIndex);
    Widget child = _TwoDMgrRackCell(
      vicinity: vicinity,
      telemetry: telemetry,
    );
    if (addRepaintBoundaries) {
      child = RepaintBoundary(child: child);
    }
    if (addAutomaticKeepAlives) {
      child = KeyedSubtree(
        key: ValueKey<ChildVicinity>(vicinity),
        child: child,
      );
    } else {
      child = KeyedSubtree(
        key: ValueKey<ChildVicinity>(vicinity),
        child: child,
      );
    }
    return child;
  }
}

// ---------------------------------------------------------------------------
// Rack cell widget.
// ---------------------------------------------------------------------------

class _TwoDMgrRackCell extends StatelessWidget {
  const _TwoDMgrRackCell({
    required this.vicinity,
    required this.telemetry,
  });

  final ChildVicinity vicinity;
  final _TwoDMgrTelemetry telemetry;

  @override
  Widget build(BuildContext context) {
    final int x = vicinity.xIndex;
    final int y = vicinity.yIndex;
    final String sku = _twoDMgrSkuFor(x, y);
    final String cat = _twoDMgrCategoryFor(x, y);
    final int stock = _twoDMgrStockFor(x, y);
    final bool isAisleHeader = y == 0;
    final bool isOddAisle = x.isOdd;

    final Color bg = isAisleHeader
        ? _twoDMgrWarehouseRedDeep
        : (isOddAisle ? _twoDMgrPanel : _twoDMgrPanelDeep);
    final Color accent = isAisleHeader
        ? _twoDMgrCaution
        : (stock < 30 ? _twoDMgrCaution : _twoDMgrOkGreen);

    final int builds = telemetry.perCellBuilds['$x:$y'] ?? 0;
    final int reuses = telemetry.perCellReuses['$x:$y'] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: _twoDMgrGridLine, width: 1),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(sku, style: _twoDMgrMono),
            ],
          ),
          const SizedBox(height: 4),
          Text(cat, style: _twoDMgrMonoSmall),
          const Spacer(),
          Row(
            children: <Widget>[
              Text('qty ', style: _twoDMgrMonoSmall),
              Text('$stock'.padLeft(3, '0'),
                  style: _twoDMgrMono.copyWith(color: accent)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: <Widget>[
              _TwoDMgrCounterChip(label: 'b', value: builds, color: _twoDMgrCaution),
              const SizedBox(width: 4),
              _TwoDMgrCounterChip(label: 'r', value: reuses, color: _twoDMgrReuseBlue),
            ],
          ),
        ],
      ),
    );
  }
}

class _TwoDMgrCounterChip extends StatelessWidget {
  const _TwoDMgrCounterChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 0.8),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        '$label${value.toString().padLeft(2, '0')}',
        style: TextStyle(
          fontFamily: 'monospace',
          fontFamilyFallback: const <String>['Courier'],
          color: color,
          fontSize: 9,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom RenderTwoDimensionalViewport.
//
// This is where the render object talks to the TwoDimensionalChildManager.
// Between startLayout() and endLayout(), we call buildOrObtainChildFor(v)
// for every visible vicinity. The manager maps that to either _buildChild
// (fresh element) or _reuseChild (relocate a still-live element into the
// new keep list). Whatever the manager doesn't relocate gets unmounted at
// endLayout - we treat those as removes.
// ---------------------------------------------------------------------------

class _TwoDMgrRenderWarehouseViewport extends RenderTwoDimensionalViewport {
  _TwoDMgrRenderWarehouseViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required _TwoDMgrCountingDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    required this.cellWidth,
    required this.cellHeight,
    required this.telemetry,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  final double cellWidth;
  final double cellHeight;
  final _TwoDMgrTelemetry telemetry;

  // Vicinities that were live at the start of the current layout pass.
  // We subtract the ones we touch this pass; what's left is the "removed"
  // set.
  final Set<ChildVicinity> _prevVicinities = <ChildVicinity>{};

  @override
  void layoutChildSequence() {
    final double hPix = horizontalOffset.pixels;
    final double vPix = verticalOffset.pixels;
    final double viewW = viewportDimension.width;
    final double viewH = viewportDimension.height;

    // Snapshot the live set from last pass so we can compute removes.
    final Set<ChildVicinity> previous = Set<ChildVicinity>.from(_prevVicinities);
    _prevVicinities.clear();

    final _TwoDMgrCountingDelegate d = delegate as _TwoDMgrCountingDelegate;
    final int maxX = d.maxXIndex ?? 0;
    final int maxY = d.maxYIndex ?? 0;

    final int leadCol = math.max((hPix / cellWidth).floor(), 0);
    final int leadRow = math.max((vPix / cellHeight).floor(), 0);
    final int trailCol =
        math.min(((hPix + viewW) / cellWidth).ceil(), maxX);
    final int trailRow =
        math.min(((vPix + viewH) / cellHeight).ceil(), maxY);

    double xOff = (leadCol * cellWidth) - hPix;
    for (int col = leadCol; col <= trailCol; col++) {
      double yOff = (leadRow * cellHeight) - vPix;
      for (int row = leadRow; row <= trailRow; row++) {
        final ChildVicinity v = ChildVicinity(xIndex: col, yIndex: row);
        _prevVicinities.add(v);
        final bool wasLive = previous.remove(v);
        final RenderBox? child = buildOrObtainChildFor(v);
        if (child != null) {
          // If the manager says the element was already live going into
          // this pass, the real code path was _reuseChild; otherwise it
          // was _buildChild and the builder fired (telemetry already
          // recorded it).
          if (wasLive) {
            telemetry.noteReuse(col, row);
          }
          child.layout(constraints.tighten(
            width: cellWidth,
            height: cellHeight,
          ));
          parentDataOf(child).layoutOffset = Offset(xOff, yOff);
        }
        yOff += cellHeight;
      }
      xOff += cellWidth;
    }

    // Anything still in 'previous' was live last pass but not touched
    // this pass. That set is unmounted by the manager at _endLayout.
    for (final ChildVicinity gone in previous) {
      telemetry.noteRemove(gone.xIndex, gone.yIndex);
    }

    final double totalW = cellWidth * (maxX + 1);
    final double totalH = cellHeight * (maxY + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      math.max(totalW - viewW, 0.0),
    );
    verticalOffset.applyContentDimensions(
      0.0,
      math.max(totalH - viewH, 0.0),
    );

    // Schedule a sample after the layout commits, so the graph shows
    // activity.
    _TwoDMgrSchedulerCompat.scheduleTelemetrySample(telemetry);
  }
}

// Tiny helper so we don't import scheduler directly - just a
// post-frame microtask.
class _TwoDMgrSchedulerCompat {
  static void scheduleTelemetrySample(_TwoDMgrTelemetry t) {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      t.sample();
    });
  }
}

// ---------------------------------------------------------------------------
// Viewport widget.
// ---------------------------------------------------------------------------

class _TwoDMgrWarehouseViewport extends TwoDimensionalViewport {
  const _TwoDMgrWarehouseViewport({
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required _TwoDMgrCountingDelegate delegate,
    required super.mainAxis,
    required this.cellWidth,
    required this.cellHeight,
    required this.telemetry,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  final double cellWidth;
  final double cellHeight;
  final _TwoDMgrTelemetry telemetry;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return _TwoDMgrRenderWarehouseViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as _TwoDMgrCountingDelegate,
      childManager: context as TwoDimensionalChildManager,
      cellWidth: cellWidth,
      cellHeight: cellHeight,
      telemetry: telemetry,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _TwoDMgrRenderWarehouseViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cacheExtent = cacheExtent
      ..cacheExtentStyle = cacheExtentStyle
      ..clipBehavior = clipBehavior;
  }
}

// ---------------------------------------------------------------------------
// Scroll view.
// ---------------------------------------------------------------------------

class _TwoDMgrWarehouseScrollView extends TwoDimensionalScrollView {
  const _TwoDMgrWarehouseScrollView({
    required _TwoDMgrCountingDelegate delegate,
    required this.cellWidth,
    required this.cellHeight,
    required this.telemetry,
    super.verticalDetails = const ScrollableDetails.vertical(),
    super.horizontalDetails = const ScrollableDetails.horizontal(),
    super.diagonalDragBehavior = DiagonalDragBehavior.free,
  }) : super(delegate: delegate);

  final double cellWidth;
  final double cellHeight;
  final _TwoDMgrTelemetry telemetry;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return _TwoDMgrWarehouseViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as _TwoDMgrCountingDelegate,
      cellWidth: cellWidth,
      cellHeight: cellHeight,
      telemetry: telemetry,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
    );
  }
}

// ---------------------------------------------------------------------------
// Telemetry dashboard - three counters + live alive-set count.
// ---------------------------------------------------------------------------

class _TwoDMgrDashboard extends StatelessWidget {
  const _TwoDMgrDashboard({required this.telemetry, required this.title});

  final _TwoDMgrTelemetry telemetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: telemetry,
      builder: (BuildContext context, Widget? _) {
        final int builds = telemetry.builds;
        final int reuses = telemetry.reuses;
        final int removes = telemetry.removes;
        final int alive = telemetry.liveVicinities.length;
        final int total = builds + reuses;
        final double reuseRatio =
            total == 0 ? 0.0 : reuses / total;
        return Container(
          decoration: BoxDecoration(
            color: _twoDMgrPanel,
            border: Border.all(color: _twoDMgrSteel, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _twoDMgrWarehouseRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(title, style: _twoDMgrSubtitle),
                  const Spacer(),
                  Text('pass ${telemetry.layoutPasses.toString().padLeft(4, '0')}',
                      style: _twoDMgrMonoSmall),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  _TwoDMgrBigCounter(
                    label: 'buildChild',
                    value: builds,
                    color: _twoDMgrCaution,
                    sub: '_buildChild(vicinity)',
                  ),
                  const SizedBox(width: 8),
                  _TwoDMgrBigCounter(
                    label: 'reuseChild',
                    value: reuses,
                    color: _twoDMgrReuseBlue,
                    sub: '_reuseChild(vicinity)',
                  ),
                  const SizedBox(width: 8),
                  _TwoDMgrBigCounter(
                    label: 'removeChild',
                    value: removes,
                    color: _twoDMgrRemoveGrey,
                    sub: 'unmount @ _endLayout',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _TwoDMgrReuseBar(ratio: reuseRatio, alive: alive),
            ],
          ),
        );
      },
    );
  }
}

class _TwoDMgrBigCounter extends StatelessWidget {
  const _TwoDMgrBigCounter({
    required this.label,
    required this.value,
    required this.color,
    required this.sub,
  });

  final String label;
  final int value;
  final Color color;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _twoDMgrPanelDeep,
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
          borderRadius: BorderRadius.circular(3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                )),
            const SizedBox(height: 4),
            Text(
              value.toString().padLeft(5, '0'),
              style: TextStyle(
                fontFamily: 'monospace',
                fontFamilyFallback: const <String>['Courier'],
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(sub, style: _twoDMgrMonoSmall),
          ],
        ),
      ),
    );
  }
}

class _TwoDMgrReuseBar extends StatelessWidget {
  const _TwoDMgrReuseBar({required this.ratio, required this.alive});

  final double ratio;
  final int alive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('reuse ratio', style: _twoDMgrMonoSmall),
            const Spacer(),
            Text(
              '${(ratio * 100).toStringAsFixed(1)}% ',
              style: _twoDMgrMono.copyWith(color: _twoDMgrReuseBlue),
            ),
            Text('alive=${alive.toString().padLeft(3, '0')}',
                style: _twoDMgrMonoSmall),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            height: 6,
            color: _twoDMgrSteel,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: ratio.clamp(0.0, 1.0),
                child: Container(color: _twoDMgrReuseBlue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scroll trace graph.
// ---------------------------------------------------------------------------

class _TwoDMgrTraceGraph extends StatelessWidget {
  const _TwoDMgrTraceGraph({required this.telemetry});

  final _TwoDMgrTelemetry telemetry;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: telemetry,
      builder: (BuildContext context, Widget? _) {
        return Container(
          height: 160,
          decoration: BoxDecoration(
            color: _twoDMgrPanelDeep,
            border: Border.all(color: _twoDMgrSteel, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('scroll trace',
                      style: _twoDMgrSubtitle.copyWith(color: _twoDMgrCaution)),
                  const SizedBox(width: 12),
                  _TwoDMgrLegendDot(color: _twoDMgrCaution, text: 'build'),
                  const SizedBox(width: 10),
                  _TwoDMgrLegendDot(color: _twoDMgrReuseBlue, text: 'reuse'),
                  const SizedBox(width: 10),
                  _TwoDMgrLegendDot(color: _twoDMgrRemoveGrey, text: 'remove'),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _TwoDMgrTracePainter(samples: telemetry.samples),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TwoDMgrLegendDot extends StatelessWidget {
  const _TwoDMgrLegendDot({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(text, style: _twoDMgrMonoSmall),
      ],
    );
  }
}

class _TwoDMgrTracePainter extends CustomPainter {
  _TwoDMgrTracePainter({required this.samples});

  final List<_TwoDMgrSample> samples;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = _twoDMgrGridLine
      ..strokeWidth = 1;
    // Horizontal grid lines.
    for (int i = 0; i <= 4; i++) {
      final double y = size.height * (i / 4);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
    // Vertical grid lines.
    for (int i = 0; i <= 6; i++) {
      final double x = size.width * (i / 6);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    if (samples.isEmpty) {
      final TextPainter tp = TextPainter(
        text: const TextSpan(
          text: '(no samples yet - scroll the rack)',
          style: _twoDMgrMonoSmall,
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.width);
      tp.paint(
        canvas,
        Offset(
          (size.width - tp.width) / 2,
          (size.height - tp.height) / 2,
        ),
      );
      return;
    }

    // Rolling window: last N samples.
    final List<_TwoDMgrSample> s = samples;
    final int n = s.length;

    // Compute per-pass deltas.
    final List<int> dBuild = <int>[];
    final List<int> dReuse = <int>[];
    final List<int> dRemove = <int>[];
    for (int i = 0; i < n; i++) {
      if (i == 0) {
        dBuild.add(s[i].builds);
        dReuse.add(s[i].reuses);
        dRemove.add(s[i].removes);
      } else {
        dBuild.add(s[i].builds - s[i - 1].builds);
        dReuse.add(s[i].reuses - s[i - 1].reuses);
        dRemove.add(s[i].removes - s[i - 1].removes);
      }
    }

    int maxDelta = 1;
    for (int i = 0; i < n; i++) {
      if (dBuild[i] > maxDelta) maxDelta = dBuild[i];
      if (dReuse[i] > maxDelta) maxDelta = dReuse[i];
      if (dRemove[i] > maxDelta) maxDelta = dRemove[i];
    }

    Path buildPath(List<int> deltas, double verticalBias) {
      final Path p = Path();
      for (int i = 0; i < n; i++) {
        final double x = n <= 1 ? 0.0 : size.width * (i / (n - 1));
        final double norm = deltas[i] / maxDelta;
        final double y = size.height - norm * size.height * 0.92 - 4 + verticalBias;
        if (i == 0) {
          p.moveTo(x, y);
        } else {
          p.lineTo(x, y);
        }
      }
      return p;
    }

    final Paint bp = Paint()
      ..color = _twoDMgrCaution
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint rp = Paint()
      ..color = _twoDMgrReuseBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint rmp = Paint()
      ..color = _twoDMgrRemoveGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    canvas.drawPath(buildPath(dBuild, 0), bp);
    canvas.drawPath(buildPath(dReuse, 0), rp);
    canvas.drawPath(buildPath(dRemove, 0), rmp);

    // Axis label - maxDelta scale.
    final TextPainter scaleTp = TextPainter(
      text: TextSpan(
        text: 'max ${maxDelta.toString().padLeft(3, '0')}/pass',
        style: _twoDMgrMonoSmall,
      ),
      textDirection: TextDirection.ltr,
    );
    scaleTp.layout();
    scaleTp.paint(canvas, const Offset(4, 2));
  }

  @override
  bool shouldRepaint(covariant _TwoDMgrTracePainter oldDelegate) {
    return oldDelegate.samples != samples ||
        oldDelegate.samples.length != samples.length;
  }
}

// ---------------------------------------------------------------------------
// Preamble card.
// ---------------------------------------------------------------------------

class _TwoDMgrPreambleCard extends StatelessWidget {
  const _TwoDMgrPreambleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanel,
        border: Border.all(color: _twoDMgrSteel, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 22,
                color: _twoDMgrWarehouseRed,
              ),
              const SizedBox(width: 10),
              const Text('TwoDimensionalChildManager', style: _twoDMgrTitle),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _twoDMgrCaution.withValues(alpha: 0.15),
                  border: Border.all(
                    color: _twoDMgrCaution.withValues(alpha: 0.6),
                    width: 0.8,
                  ),
                ),
                child: const Text(
                  'abstract interface / library-private',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _twoDMgrCaution,
                    fontSize: 10,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'A TwoDimensionalViewport lazily reifies only the children that are '
            'actually visible (plus a cacheExtent). The manager - implemented '
            'by the viewport\'s Element - owns the element-level lifecycle of '
            'those children.',
            style: _twoDMgrBody,
          ),
          const SizedBox(height: 8),
          const Text(
            'During every layout pass, the render object calls '
            'buildOrObtainChildFor(vicinity) for each cell it needs. That call '
            'routes through the manager, which either (a) rebuilds a new '
            'Element via _buildChild, or (b) relocates an already-live Element '
            'via _reuseChild. At the end of the pass, any Element that the '
            'subclass did not ask for is unmounted - that is the manager\'s '
            'remove branch.',
            style: _twoDMgrBody,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: _twoDMgrPanelDeep,
              border: Border.all(color: _twoDMgrGridLine),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('manager contract (simplified)', style: _twoDMgrSubtitle),
                SizedBox(height: 6),
                Text(
                  'void _startLayout();\n'
                  'void _buildChild(ChildVicinity v);\n'
                  'void _reuseChild(ChildVicinity v);\n'
                  'void _endLayout();',
                  style: _twoDMgrMono,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: _TwoDMgrFactBox(
                  heading: 'where it lives',
                  body:
                      'The only concrete implementation in the framework is '
                      '_TwoDimensionalViewportElement. Because the abstract '
                      'members are library-private, outside code uses the '
                      'manager transitively - by plugging into '
                      'TwoDimensionalChildDelegate and RenderTwoDimensionalViewport.',
                  accent: _twoDMgrReuseBlue,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _TwoDMgrFactBox(
                  heading: 'why this split',
                  body:
                      'Flutter separates Widgets, Elements, and RenderObjects. '
                      'A 2D viewport needs tight coordination between layout '
                      '(render) and keep/drop decisions (element). The manager '
                      'is the interface that lets the render object ask the '
                      'element "materialise this vicinity" on demand.',
                  accent: _twoDMgrCaution,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TwoDMgrFactBox extends StatelessWidget {
  const _TwoDMgrFactBox({
    required this.heading,
    required this.body,
    required this.accent,
  });

  final String heading;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanelDeep,
        border: Border.all(color: accent.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(heading,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              )),
          const SizedBox(height: 6),
          Text(body, style: _twoDMgrBody),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy card - method table.
// ---------------------------------------------------------------------------

class _TwoDMgrAnatomyCard extends StatelessWidget {
  const _TwoDMgrAnatomyCard();

  @override
  Widget build(BuildContext context) {
    final List<_TwoDMgrAnatomyRow> rows = <_TwoDMgrAnatomyRow>[
      const _TwoDMgrAnatomyRow(
        method: '_startLayout()',
        fires: 'at the top of RenderTwoDimensionalViewport.performLayout',
        body:
            'The manager prepares new-pass bookkeeping maps (vicinity->element, key->element).',
        color: _twoDMgrCaution,
      ),
      const _TwoDMgrAnatomyRow(
        method: '_buildChild(vicinity)',
        fires: 'from buildOrObtainChildFor, when no live element is at that vicinity',
        body:
            'Runs owner.buildScope, asks delegate.build(context, vicinity), inflates the widget, '
            'and stores the new Element under vicinity and (optionally) key.',
        color: _twoDMgrCaution,
      ),
      const _TwoDMgrAnatomyRow(
        method: '_reuseChild(vicinity)',
        fires: 'from buildOrObtainChildFor, when an element already exists at that vicinity or key',
        body:
            'Pops the existing Element out of the previous-pass map and inserts it into the new-pass map. '
            'No widget rebuild, no new RenderObject attach - cheap.',
        color: _twoDMgrReuseBlue,
      ),
      const _TwoDMgrAnatomyRow(
        method: '_endLayout()',
        fires: 'after layoutChildSequence returns',
        body:
            'Any element still sitting in the previous-pass maps (nobody reused it) is unmounted via '
            'updateChild(old, null, null). This is the "remove" step.',
        color: _twoDMgrRemoveGrey,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanel,
        border: Border.all(color: _twoDMgrSteel, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text('anatomy of a layout pass', style: _twoDMgrTitle),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'The render object drives. The manager reacts. Here is the call sequence, '
            'and what flips on the telemetry dashboard.',
            style: _twoDMgrBodyMuted,
          ),
          const SizedBox(height: 12),
          for (final _TwoDMgrAnatomyRow r in rows) ...<Widget>[
            _TwoDMgrAnatomyTile(row: r),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: _twoDMgrPanelDeep,
              border: Border.all(color: _twoDMgrGridLine),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('driver side (your subclass)', style: _twoDMgrSubtitle),
                SizedBox(height: 6),
                Text(
                  'class _MyRenderViewport extends RenderTwoDimensionalViewport {\n'
                  '  @override\n'
                  '  void layoutChildSequence() {\n'
                  '    for each vicinity in visible window:\n'
                  '      final child = buildOrObtainChildFor(vicinity);\n'
                  '      child?.layout(constraints.tighten(...));\n'
                  '      parentDataOf(child).layoutOffset = Offset(...);\n'
                  '    applyContentDimensions(minScrollExtent, maxScrollExtent);\n'
                  '  }\n'
                  '}',
                  style: _twoDMgrMono,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDMgrAnatomyRow {
  final String method;
  final String fires;
  final String body;
  final Color color;
  const _TwoDMgrAnatomyRow({
    required this.method,
    required this.fires,
    required this.body,
    required this.color,
  });
}

class _TwoDMgrAnatomyTile extends StatelessWidget {
  const _TwoDMgrAnatomyTile({required this.row});

  final _TwoDMgrAnatomyRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanelDeep,
        border: Border(
          left: BorderSide(color: row.color, width: 3),
          top: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
          right: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
          bottom: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                row.method,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: row.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(row.fires,
                    style: _twoDMgrMonoSmall, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(row.body, style: _twoDMgrBody),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Control bar with slider + toggles + reset.
// ---------------------------------------------------------------------------

class _TwoDMgrControlBar extends StatelessWidget {
  const _TwoDMgrControlBar({
    required this.scrollSpeed,
    required this.keepAlives,
    required this.repaintBoundaries,
    required this.onSpeed,
    required this.onKeepAlives,
    required this.onRepaint,
    required this.onScrollSimulated,
    required this.onReset,
    required this.onRecenter,
  });

  final double scrollSpeed;
  final bool keepAlives;
  final bool repaintBoundaries;
  final ValueChanged<double> onSpeed;
  final ValueChanged<bool> onKeepAlives;
  final ValueChanged<bool> onRepaint;
  final VoidCallback onScrollSimulated;
  final VoidCallback onReset;
  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanel,
        border: Border.all(color: _twoDMgrSteel, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Text('scroll speed', style: _twoDMgrMonoSmall),
          const SizedBox(width: 8),
          SizedBox(
            width: 160,
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: _twoDMgrCaution,
                inactiveTrackColor: _twoDMgrSteel,
                thumbColor: _twoDMgrCaution,
                overlayColor: _twoDMgrCaution.withValues(alpha: 0.2),
                trackHeight: 3,
              ),
              child: Slider(
                value: scrollSpeed,
                min: 0.2,
                max: 4.0,
                onChanged: onSpeed,
              ),
            ),
          ),
          Container(
            width: 44,
            alignment: Alignment.centerRight,
            child: Text('${scrollSpeed.toStringAsFixed(1)}x',
                style: _twoDMgrMono.copyWith(color: _twoDMgrCaution)),
          ),
          const SizedBox(width: 16),
          _TwoDMgrToggle(
            label: 'keepAlives',
            value: keepAlives,
            onChanged: onKeepAlives,
          ),
          const SizedBox(width: 12),
          _TwoDMgrToggle(
            label: 'repaintBoundaries',
            value: repaintBoundaries,
            onChanged: onRepaint,
          ),
          const Spacer(),
          _TwoDMgrPillButton(
            text: 'simulate scroll',
            onPressed: onScrollSimulated,
            color: _twoDMgrReuseBlue,
          ),
          const SizedBox(width: 8),
          _TwoDMgrPillButton(
            text: 'recenter',
            onPressed: onRecenter,
            color: _twoDMgrCaution,
          ),
          const SizedBox(width: 8),
          _TwoDMgrPillButton(
            text: 'reset counters',
            onPressed: onReset,
            color: _twoDMgrWarehouseRed,
          ),
        ],
      ),
    );
  }
}

class _TwoDMgrToggle extends StatelessWidget {
  const _TwoDMgrToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _twoDMgrCaution,
            activeTrackColor: _twoDMgrCautionDeep,
            inactiveThumbColor: _twoDMgrSteelLight,
            inactiveTrackColor: _twoDMgrSteel,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: _twoDMgrMonoSmall),
      ],
    );
  }
}

class _TwoDMgrPillButton extends StatelessWidget {
  const _TwoDMgrPillButton({
    required this.text,
    required this.onPressed,
    required this.color,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.55), width: 0.8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        minimumSize: const Size(0, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      child: Text(text),
    );
  }
}

// ---------------------------------------------------------------------------
// Interactive rack demo - holds scroll controllers, simulates scroll,
// drives counter reset and toggle flow.
// ---------------------------------------------------------------------------

class _TwoDMgrRackLab extends StatefulWidget {
  const _TwoDMgrRackLab({
    required this.telemetry,
    required this.title,
    required this.subtitle,
    required this.defaultKeepAlives,
    required this.defaultRepaintBoundaries,
    required this.maxX,
    required this.maxY,
    required this.cellWidth,
    required this.cellHeight,
    required this.viewportHeight,
  });

  final _TwoDMgrTelemetry telemetry;
  final String title;
  final String subtitle;
  final bool defaultKeepAlives;
  final bool defaultRepaintBoundaries;
  final int maxX;
  final int maxY;
  final double cellWidth;
  final double cellHeight;
  final double viewportHeight;

  @override
  State<_TwoDMgrRackLab> createState() => _TwoDMgrRackLabState();
}

class _TwoDMgrRackLabState extends State<_TwoDMgrRackLab>
    with SingleTickerProviderStateMixin {
  late ScrollController _vCtrl;
  late ScrollController _hCtrl;
  late AnimationController _sim;
  double _speed = 1.0;
  late bool _keepAlives;
  late bool _repaintBoundaries;

  late _TwoDMgrCountingDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _vCtrl = ScrollController();
    _hCtrl = ScrollController();
    _keepAlives = widget.defaultKeepAlives;
    _repaintBoundaries = widget.defaultRepaintBoundaries;
    _sim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..addListener(_tickSim);
    _rebuildDelegate();
  }

  void _rebuildDelegate() {
    _delegate = _TwoDMgrCountingDelegate(
      telemetry: widget.telemetry,
      maxX: widget.maxX,
      maxY: widget.maxY,
      keepAlives: _keepAlives,
      repaintBoundaries: _repaintBoundaries,
    );
  }

  void _tickSim() {
    if (!_vCtrl.hasClients || !_hCtrl.hasClients) return;
    final double t = _sim.value;
    final double vMax = _vCtrl.position.maxScrollExtent;
    final double hMax = _hCtrl.position.maxScrollExtent;
    // Lissajous-ish path so both axes churn.
    final double vTarget =
        vMax * (0.5 - 0.5 * math.cos(t * math.pi * 2 * _speed));
    final double hTarget =
        hMax * (0.5 - 0.5 * math.sin(t * math.pi * 2 * _speed * 0.7));
    _vCtrl.jumpTo(vTarget.clamp(0.0, vMax));
    _hCtrl.jumpTo(hTarget.clamp(0.0, hMax));
  }

  void _startSimulate() {
    _sim
      ..stop()
      ..reset()
      ..forward();
  }

  void _recenter() {
    if (_vCtrl.hasClients) _vCtrl.jumpTo(0);
    if (_hCtrl.hasClients) _hCtrl.jumpTo(0);
  }

  void _reset() {
    widget.telemetry.reset();
  }

  @override
  void dispose() {
    _sim.dispose();
    _vCtrl.dispose();
    _hCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanel,
        border: Border.all(color: _twoDMgrSteel, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 4, height: 20, color: _twoDMgrCaution),
              const SizedBox(width: 10),
              Text(widget.title, style: _twoDMgrSubtitle),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.subtitle,
                  style: _twoDMgrMonoSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _TwoDMgrControlBar(
            scrollSpeed: _speed,
            keepAlives: _keepAlives,
            repaintBoundaries: _repaintBoundaries,
            onSpeed: (double v) => setState(() => _speed = v),
            onKeepAlives: (bool v) {
              setState(() {
                _keepAlives = v;
                _rebuildDelegate();
              });
            },
            onRepaint: (bool v) {
              setState(() {
                _repaintBoundaries = v;
                _rebuildDelegate();
              });
            },
            onScrollSimulated: _startSimulate,
            onReset: _reset,
            onRecenter: _recenter,
          ),
          const SizedBox(height: 12),
          Container(
            height: widget.viewportHeight,
            decoration: BoxDecoration(
              color: _twoDMgrPanelDeep,
              border: Border.all(color: _twoDMgrSteel, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: _TwoDMgrWarehouseScrollView(
                delegate: _delegate,
                cellWidth: widget.cellWidth,
                cellHeight: widget.cellHeight,
                telemetry: widget.telemetry,
                verticalDetails: ScrollableDetails.vertical(
                  controller: _vCtrl,
                ),
                horizontalDetails: ScrollableDetails.horizontal(
                  controller: _hCtrl,
                ),
                diagonalDragBehavior: DiagonalDragBehavior.free,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _TwoDMgrDashboard(
            telemetry: widget.telemetry,
            title: '${widget.title} - telemetry',
          ),
          const SizedBox(height: 12),
          _TwoDMgrTraceGraph(telemetry: widget.telemetry),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Comparison strip - two labs side by side.
// ---------------------------------------------------------------------------

class _TwoDMgrComparisonCard extends StatelessWidget {
  const _TwoDMgrComparisonCard({
    required this.recyclingTelemetry,
    required this.noRecyclingTelemetry,
  });

  final _TwoDMgrTelemetry recyclingTelemetry;
  final _TwoDMgrTelemetry noRecyclingTelemetry;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        recyclingTelemetry,
        noRecyclingTelemetry,
      ]),
      builder: (BuildContext context, Widget? _) {
        return Container(
          decoration: BoxDecoration(
            color: _twoDMgrPanel,
            border: Border.all(color: _twoDMgrSteel, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('comparison: recycling vs no recycling',
                  style: _twoDMgrTitle),
              const SizedBox(height: 4),
              const Text(
                'Both racks receive the same scroll simulation; only the '
                'delegate wrapping differs. Watch the build column - '
                'keep-alives dramatically reduce _buildChild traffic, at '
                'the cost of keeping more Elements resident.',
                style: _twoDMgrBodyMuted,
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _TwoDMgrComparisonCol(
                      label: 'recycling ON',
                      color: _twoDMgrReuseBlue,
                      telemetry: recyclingTelemetry,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TwoDMgrComparisonCol(
                      label: 'recycling OFF',
                      color: _twoDMgrWarehouseRed,
                      telemetry: noRecyclingTelemetry,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TwoDMgrComparisonCol extends StatelessWidget {
  const _TwoDMgrComparisonCol({
    required this.label,
    required this.color,
    required this.telemetry,
  });

  final String label;
  final Color color;
  final _TwoDMgrTelemetry telemetry;

  @override
  Widget build(BuildContext context) {
    final int b = telemetry.builds;
    final int r = telemetry.reuses;
    final int rm = telemetry.removes;
    final int total = b + r;
    final double reuseRatio = total == 0 ? 0.0 : r / total;
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanelDeep,
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _TwoDMgrKvRow(k: 'builds', v: b.toString(), color: _twoDMgrCaution),
          _TwoDMgrKvRow(k: 'reuses', v: r.toString(), color: _twoDMgrReuseBlue),
          _TwoDMgrKvRow(k: 'removes', v: rm.toString(), color: _twoDMgrRemoveGrey),
          _TwoDMgrKvRow(
            k: 'reuse%',
            v: '${(reuseRatio * 100).toStringAsFixed(1)}%',
            color: _twoDMgrOkGreen,
          ),
        ],
      ),
    );
  }
}

class _TwoDMgrKvRow extends StatelessWidget {
  const _TwoDMgrKvRow({
    required this.k,
    required this.v,
    required this.color,
  });

  final String k;
  final String v;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Text(k, style: _twoDMgrMonoSmall),
          ),
          Expanded(
            child: Text(
              v,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'monospace',
                fontFamilyFallback: const <String>['Courier'],
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Epilogue card.
// ---------------------------------------------------------------------------

class _TwoDMgrEpilogueCard extends StatelessWidget {
  const _TwoDMgrEpilogueCard();

  @override
  Widget build(BuildContext context) {
    final List<_TwoDMgrTip> tips = <_TwoDMgrTip>[
      const _TwoDMgrTip(
        title: 'extend, do not reimplement',
        body:
            'Do not write a brand-new TwoDimensionalChildManager outside the '
            'framework - its abstract members are library-private and the only '
            'implementation is glued into the Element machinery. Instead, '
            'subclass RenderTwoDimensionalViewport and let the framework-provided '
            'element manager do its job.',
        color: _twoDMgrCaution,
      ),
      const _TwoDMgrTip(
        title: 'keep layoutChildSequence tight',
        body:
            'layoutChildSequence is called on every scroll. Compute your '
            'visible window (leadCol/trailCol/leadRow/trailRow), call '
            'buildOrObtainChildFor only for cells you actually need, and '
            'always call applyContentDimensions on both offsets.',
        color: _twoDMgrReuseBlue,
      ),
      const _TwoDMgrTip(
        title: 'use ChildVicinity as your key',
        body:
            'The manager dedupes children by ChildVicinity. If you wrap your '
            'child in a KeyedSubtree keyed by vicinity, you get predictable '
            'reuse when the same vicinity reappears after a scroll-back.',
        color: _twoDMgrOkGreen,
      ),
      const _TwoDMgrTip(
        title: 'repaint boundaries are a win here',
        body:
            'addRepaintBoundaries on the delegate wraps every cell in a '
            'RepaintBoundary. In a scrollable grid, cells re-layout more '
            'often than they re-paint, so boundaries keep cost local.',
        color: _twoDMgrCaution,
      ),
      const _TwoDMgrTip(
        title: 'keep-alives are not free',
        body:
            'addAutomaticKeepAlives lets cells opt in via '
            'AutomaticKeepAliveClientMixin. It prevents removes, so the '
            'reuseChild rate climbs - but resident element count climbs too. '
            'Only enable for cells that are expensive to build.',
        color: _twoDMgrWarehouseRed,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanel,
        border: Border.all(color: _twoDMgrSteel, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('epilogue - when to reach for the manager',
              style: _twoDMgrTitle),
          const SizedBox(height: 10),
          for (final _TwoDMgrTip t in tips) ...<Widget>[
            _TwoDMgrTipTile(tip: t),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _TwoDMgrTip {
  final String title;
  final String body;
  final Color color;
  const _TwoDMgrTip({
    required this.title,
    required this.body,
    required this.color,
  });
}

class _TwoDMgrTipTile extends StatelessWidget {
  const _TwoDMgrTipTile({required this.tip});

  final _TwoDMgrTip tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDMgrPanelDeep,
        border: Border(
          left: BorderSide(color: tip.color, width: 3),
          top: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
          right: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
          bottom: const BorderSide(color: _twoDMgrGridLine, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tip.title,
            style: TextStyle(
              fontFamily: 'monospace',
              color: tip.color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(tip.body, style: _twoDMgrBody),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section header.
// ---------------------------------------------------------------------------

class _TwoDMgrSectionHeader extends StatelessWidget {
  const _TwoDMgrSectionHeader({required this.index, required this.title});

  final String index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 6),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _twoDMgrWarehouseRedDeep,
              border: Border.all(color: _twoDMgrCaution, width: 0.8),
            ),
            child: Text(
              index,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _twoDMgrCaution,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(title, style: _twoDMgrTitle),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _twoDMgrCaution,
                    Color(0x00F3C948),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Root demo widget.
// ---------------------------------------------------------------------------

class _TwoDMgrRoot extends StatefulWidget {
  const _TwoDMgrRoot();

  @override
  State<_TwoDMgrRoot> createState() => _TwoDMgrRootState();
}

class _TwoDMgrRootState extends State<_TwoDMgrRoot> {
  final _TwoDMgrTelemetry _primary = _TwoDMgrTelemetry('primary');
  final _TwoDMgrTelemetry _recycling = _TwoDMgrTelemetry('recycling-on');
  final _TwoDMgrTelemetry _noRecycling = _TwoDMgrTelemetry('recycling-off');

  @override
  void dispose() {
    _primary.dispose();
    _recycling.dispose();
    _noRecycling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('TwoDimensionalChildManager deep demo: building root');
    return Scaffold(
      backgroundColor: _twoDMgrBg,
      appBar: AppBar(
        backgroundColor: _twoDMgrPanelDeep,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Container(width: 10, height: 10, color: _twoDMgrWarehouseRed),
            const SizedBox(width: 8),
            const Text(
              'TwoDimensionalChildManager / warehouse rack',
              style: TextStyle(
                color: _twoDMgrInk,
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _TwoDMgrSectionHeader(
                index: '01',
                title: 'preamble',
              ),
              const _TwoDMgrPreambleCard(),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '02',
                title: 'anatomy of a layout pass',
              ),
              const _TwoDMgrAnatomyCard(),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '03',
                title: 'rack viewport - live telemetry',
              ),
              _TwoDMgrRackLab(
                telemetry: _primary,
                title: 'primary rack',
                subtitle:
                    'custom RenderTwoDimensionalViewport over a counting TwoDimensionalChildBuilderDelegate',
                defaultKeepAlives: true,
                defaultRepaintBoundaries: true,
                maxX: 39,
                maxY: 79,
                cellWidth: 140,
                cellHeight: 110,
                viewportHeight: 360,
              ),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '04',
                title: 'recycling ON - keep-alives enabled',
              ),
              _TwoDMgrRackLab(
                telemetry: _recycling,
                title: 'recycling rack (keepAlives=true)',
                subtitle:
                    'addAutomaticKeepAlives=true, addRepaintBoundaries=true - expect high reuse ratio',
                defaultKeepAlives: true,
                defaultRepaintBoundaries: true,
                maxX: 29,
                maxY: 59,
                cellWidth: 130,
                cellHeight: 100,
                viewportHeight: 300,
              ),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '05',
                title: 'recycling OFF - aggressive rebuilds',
              ),
              _TwoDMgrRackLab(
                telemetry: _noRecycling,
                title: 'no-recycling rack (keepAlives=false)',
                subtitle:
                    'addAutomaticKeepAlives=false, addRepaintBoundaries=false - watch builds surge',
                defaultKeepAlives: false,
                defaultRepaintBoundaries: false,
                maxX: 29,
                maxY: 59,
                cellWidth: 130,
                cellHeight: 100,
                viewportHeight: 300,
              ),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '06',
                title: 'side-by-side comparison',
              ),
              _TwoDMgrComparisonCard(
                recyclingTelemetry: _recycling,
                noRecyclingTelemetry: _noRecycling,
              ),
              const SizedBox(height: 18),
              const _TwoDMgrSectionHeader(
                index: '07',
                title: 'epilogue',
              ),
              const _TwoDMgrEpilogueCard(),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _twoDMgrPanelDeep,
                  border: Border.all(color: _twoDMgrSteel),
                ),
                child: const Text(
                  'end of TwoDimensionalChildManager deep demo. scroll any rack '
                  'with a trackpad or drag gesture; each layout pass samples '
                  'build/reuse/remove counts and feeds the graph.',
                  style: _twoDMgrMonoSmall,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top-level build() for the d4rt harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('TwoDimensionalChildManager deep demo executing');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TwoDimensionalChildManager - warehouse rack manager',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _twoDMgrBg,
      canvasColor: _twoDMgrBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _twoDMgrWarehouseRed,
        brightness: Brightness.dark,
      ).copyWith(
        surface: _twoDMgrPanel,
        primary: _twoDMgrCaution,
        secondary: _twoDMgrReuseBlue,
      ),
      textTheme: const TextTheme(
        bodyMedium: _twoDMgrBody,
        bodySmall: _twoDMgrBodyMuted,
      ),
    ),
    home: const _TwoDMgrRoot(),
  );
}
