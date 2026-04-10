import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ViewportParentDataDeepDemo();
}

const Color _kObsidian = Color(0xFF1F2937);
const Color _kMist = Color(0xFFF9FAFB);
const Color _kMint = Color(0xFFA7F3D0);

class _ViewportParentDataDeepDemo extends StatefulWidget {
  const _ViewportParentDataDeepDemo();

  @override
  State<_ViewportParentDataDeepDemo> createState() => _ViewportParentDataDeepDemoState();
}

class _ViewportParentDataDeepDemoState extends State<_ViewportParentDataDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kMist,
      appBar: AppBar(
        backgroundColor: _kObsidian,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalViewportParentData Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kMint,
          tabs: const [
            Tab(text: 'Concept Atlas'),
            Tab(text: 'Geometry Lab'),
            Tab(text: 'Visibility & Paint'),
            Tab(text: 'KeepAlive Ledger'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ConceptAtlasPanel(),
          _GeometryLabPanel(),
          _VisibilityPaintPanel(),
          _KeepAliveLedgerPanel(),
        ],
      ),
    );
  }
}

class _ConceptAtlasPanel extends StatelessWidget {
  const _ConceptAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LeadCard(
          title: 'What TwoDimensionalViewportParentData Represents',
          body:
              'TwoDimensionalViewportParentData stores per-child layout and paint '
              'metadata used by RenderTwoDimensionalViewport. It links a child to '
              'its vicinity, offsets, visibility, and keepAlive behavior.',
        ),
        SizedBox(height: 12),
        _InfoCard(
          title: 'Core fields in practice',
          tone: Color(0xFF166534),
          lines: [
            'vicinity: logical coordinate in the 2D content space.',
            'layoutOffset: child origin in viewport coordinate system.',
            'paintExtent visibility metadata used for paint skipping.',
            'keepAlive flag used for off-screen retention decisions.',
          ],
        ),
        _InfoCard(
          title: 'Why parent data matters',
          tone: Color(0xFF1D4ED8),
          lines: [
            'Avoids recomputing child positions during paint passes.',
            'Connects child lifecycle decisions to spatial context.',
            'Enables quick culling when child is outside clip region.',
            'Supports recycling and restore paths across scroll movement.',
          ],
        ),
        _InfoCard(
          title: 'Common failure patterns',
          tone: Color(0xFF9A3412),
          lines: [
            'Stale layoutOffset after viewport scale change.',
            'Wrong vicinity mapping causing row/column drift.',
            'Paint extent not reset after collapse operations.',
            'keepAlive never released, causing large cache growth.',
          ],
        ),
        SizedBox(height: 12),
        _LifecycleTrackCard(),
      ],
    );
  }
}

class _LifecycleTrackCard extends StatelessWidget {
  const _LifecycleTrackCard();

  @override
  Widget build(BuildContext context) {
    const steps = [
      'Child requested for a ChildVicinity in viewport range.',
      'Parent data is attached and vicinity is assigned.',
      'Layout computes and writes layoutOffset and paint metadata.',
      'Paint phase reads metadata and culls or draws child.',
      'On scroll-out, keepAlive decides cache vs disposal path.',
    ];

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lifecycle Track', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (var i = 0; i < steps.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0EA5E9)),
                      alignment: Alignment.center,
                      child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(steps[i])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GeometryLabPanel extends StatefulWidget {
  const _GeometryLabPanel();

  @override
  State<_GeometryLabPanel> createState() => _GeometryLabPanelState();
}

class _GeometryLabPanelState extends State<_GeometryLabPanel> {
  int _columns = 6;
  int _rows = 5;
  double _cellWidth = 76;
  double _cellHeight = 54;
  double _offsetX = 10;
  double _offsetY = 8;
  int _focusX = 1;
  int _focusY = 1;
  final List<String> _events = ['Geometry lab initialized'];

  _ParentDataRecord _recordFor(int x, int y) {
    final offset = Offset(
      _offsetX + x * (_cellWidth + 6),
      _offsetY + y * (_cellHeight + 6),
    );
    final vicinity = ChildVicinity(xIndex: x, yIndex: y);
    final focused = x == _focusX && y == _focusY;
    return _ParentDataRecord(
      vicinity: vicinity,
      layoutOffset: offset,
      paintExtent: Size(_cellWidth, _cellHeight),
      keepAlive: focused,
      isVisible: true,
    );
  }

  void _probeFocus() {
    final record = _recordFor(_focusX, _focusY);
    setState(() {
      _events.add(
        'probe vicinity(${record.vicinity.xIndex},${record.vicinity.yIndex}) '
        'offset(${record.layoutOffset.dx.toStringAsFixed(1)},'
        '${record.layoutOffset.dy.toStringAsFixed(1)}) keepAlive=${record.keepAlive}',
      );
      if (_events.length > 22) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gridRows = <Widget>[];
    for (var y = 0; y < _rows; y++) {
      final row = <Widget>[];
      for (var x = 0; x < _columns; x++) {
        final record = _recordFor(x, y);
        final focused = x == _focusX && y == _focusY;
        row.add(
          Container(
            width: _cellWidth,
            height: _cellHeight,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: focused ? const Color(0xFF99F6E4) : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: focused ? const Color(0xFF0F766E) : const Color(0xFF64748B),
                width: focused ? 2 : 1,
              ),
            ),
            child: Center(
              child: Text(
                'x$x y$y\n${record.layoutOffset.dx.toInt()},${record.layoutOffset.dy.toInt()}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      }
      gridRows.add(Row(mainAxisSize: MainAxisSize.min, children: row));
    }

    final focusRecord = _recordFor(_focusX, _focusY);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Geometry Lab',
          body:
              'Simulate parent-data layout offsets across a 2D matrix and inspect '
              'how vicinity and geometry pair for each child node.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ValueSlider(
                  label: 'Columns',
                  value: _columns.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  onChanged: (v) => setState(() => _columns = v.round()),
                ),
                _ValueSlider(
                  label: 'Rows',
                  value: _rows.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  onChanged: (v) => setState(() => _rows = v.round()),
                ),
                _ValueSlider(
                  label: 'Cell width',
                  value: _cellWidth,
                  min: 52,
                  max: 120,
                  divisions: 34,
                  onChanged: (v) => setState(() => _cellWidth = v),
                ),
                _ValueSlider(
                  label: 'Cell height',
                  value: _cellHeight,
                  min: 42,
                  max: 96,
                  divisions: 27,
                  onChanged: (v) => setState(() => _cellHeight = v),
                ),
                _ValueSlider(
                  label: 'Base offset X',
                  value: _offsetX,
                  min: 0,
                  max: 60,
                  divisions: 30,
                  onChanged: (v) => setState(() => _offsetX = v),
                ),
                _ValueSlider(
                  label: 'Base offset Y',
                  value: _offsetY,
                  min: 0,
                  max: 60,
                  divisions: 30,
                  onChanged: (v) => setState(() => _offsetY = v),
                ),
                _ValueSlider(
                  label: 'Focused vicinity X',
                  value: _focusX.toDouble(),
                  min: 0,
                  max: (_columns - 1).toDouble(),
                  divisions: _columns - 1,
                  onChanged: (v) => setState(() => _focusX = v.round()),
                ),
                _ValueSlider(
                  label: 'Focused vicinity Y',
                  value: _focusY.toDouble(),
                  min: 0,
                  max: (_rows - 1).toDouble(),
                  divisions: _rows - 1,
                  onChanged: (v) => setState(() => _focusY = v.round()),
                ),
                const SizedBox(height: 8),
                FilledButton(onPressed: _probeFocus, child: const Text('Probe Focus Record')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFE0F2FE),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('LayoutOffset Overlay', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  ...gridRows,
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Focused Record Snapshot', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('vicinity: (${focusRecord.vicinity.xIndex}, ${focusRecord.vicinity.yIndex})'),
                Text('layoutOffset: ${focusRecord.layoutOffset.dx.toStringAsFixed(2)}, ${focusRecord.layoutOffset.dy.toStringAsFixed(2)}'),
                Text('paintExtent: ${focusRecord.paintExtent.width.toStringAsFixed(2)} x ${focusRecord.paintExtent.height.toStringAsFixed(2)}'),
                Text('keepAlive: ${focusRecord.keepAlive}'),
                Text('isVisible: ${focusRecord.isVisible}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Probe Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VisibilityPaintPanel extends StatefulWidget {
  const _VisibilityPaintPanel();

  @override
  State<_VisibilityPaintPanel> createState() => _VisibilityPaintPanelState();
}

class _VisibilityPaintPanelState extends State<_VisibilityPaintPanel> {
  double _clipLeft = 40;
  double _clipTop = 30;
  double _clipWidth = 260;
  double _clipHeight = 170;
  double _childX = 120;
  double _childY = 80;
  double _childW = 120;
  double _childH = 90;

  Rect get _clip => Rect.fromLTWH(_clipLeft, _clipTop, _clipWidth, _clipHeight);
  Rect get _child => Rect.fromLTWH(_childX, _childY, _childW, _childH);

  @override
  Widget build(BuildContext context) {
    final intersection = _clip.intersect(_child);
    final visible = intersection.width > 0 && intersection.height > 0;
    final fraction = visible ? (intersection.width * intersection.height) / (_child.width * _child.height) : 0.0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Visibility and Paint Extent',
          body:
              'Parent data is often read by paint traversal to skip fully clipped '
              'children and to estimate how much of a child contributes to rendering.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ValueSlider(label: 'Clip left', value: _clipLeft, min: 0, max: 280, divisions: 56, onChanged: (v) => setState(() => _clipLeft = v)),
                _ValueSlider(label: 'Clip top', value: _clipTop, min: 0, max: 220, divisions: 44, onChanged: (v) => setState(() => _clipTop = v)),
                _ValueSlider(label: 'Clip width', value: _clipWidth, min: 100, max: 320, divisions: 44, onChanged: (v) => setState(() => _clipWidth = v)),
                _ValueSlider(label: 'Clip height', value: _clipHeight, min: 80, max: 240, divisions: 32, onChanged: (v) => setState(() => _clipHeight = v)),
                _ValueSlider(label: 'Child x', value: _childX, min: 0, max: 320, divisions: 64, onChanged: (v) => setState(() => _childX = v)),
                _ValueSlider(label: 'Child y', value: _childY, min: 0, max: 240, divisions: 48, onChanged: (v) => setState(() => _childY = v)),
                _ValueSlider(label: 'Child width', value: _childW, min: 60, max: 180, divisions: 24, onChanged: (v) => setState(() => _childW = v)),
                _ValueSlider(label: 'Child height', value: _childH, min: 50, max: 150, divisions: 20, onChanged: (v) => setState(() => _childH = v)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFECFEFF),
          child: SizedBox(
            height: 320,
            child: CustomPaint(
              painter: _VisibilityPainter(clipRect: _clip, childRect: _child),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: visible ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('isVisible: $visible', style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text('paintExtent area: ${intersection.width.toStringAsFixed(1)} x ${intersection.height.toStringAsFixed(1)}'),
                Text('visible area fraction: ${(fraction * 100).toStringAsFixed(1)}%'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _KeepAliveLedgerPanel extends StatefulWidget {
  const _KeepAliveLedgerPanel();

  @override
  State<_KeepAliveLedgerPanel> createState() => _KeepAliveLedgerPanelState();
}

class _KeepAliveLedgerPanelState extends State<_KeepAliveLedgerPanel> {
  late List<_ParentDataRecord> _records;

  @override
  void initState() {
    super.initState();
    _records = [
      for (var y = 0; y < 4; y++)
        for (var x = 0; x < 5; x++)
          _ParentDataRecord(
            vicinity: ChildVicinity(xIndex: x, yIndex: y),
            layoutOffset: Offset(20 + x * 70, 18 + y * 60),
            paintExtent: const Size(64, 48),
            keepAlive: (x + y) % 3 == 0,
            isVisible: y < 3,
          ),
    ];
  }

  void _toggleKeepAlive(int index) {
    setState(() {
      final r = _records[index];
      _records[index] = r.copyWith(keepAlive: !r.keepAlive);
    });
  }

  @override
  Widget build(BuildContext context) {
    var visible = 0;
    var keepAlive = 0;
    var cached = 0;
    for (final r in _records) {
      if (r.isVisible) {
        visible++;
      }
      if (r.keepAlive) {
        keepAlive++;
      }
      if (!r.isVisible && r.keepAlive) {
        cached++;
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'KeepAlive Ledger',
          body:
              'This ledger tracks parent-data keepAlive decisions for visible and '
              'off-screen children, mirroring viewport cache policy behavior.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: Text('total records: ${_records.length}')),
                Expanded(child: Text('visible: $visible')),
                Expanded(child: Text('keepAlive: $keepAlive')),
                Expanded(child: Text('cached off-screen: $cached')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (var i = 0; i < _records.length; i++)
                  _LedgerRow(
                    index: i,
                    record: _records[i],
                    onToggle: () => _toggleKeepAlive(i),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LeadCard extends StatelessWidget {
  const _LeadCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.tone, required this.lines});

  final String title;
  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tone)),
              const SizedBox(height: 6),
              for (final line in lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $line'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ValueSlider extends StatelessWidget {
  const _ValueSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(1)}'),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
      ],
    );
  }
}

class _ParentDataRecord {
  const _ParentDataRecord({
    required this.vicinity,
    required this.layoutOffset,
    required this.paintExtent,
    required this.keepAlive,
    required this.isVisible,
  });

  final ChildVicinity vicinity;
  final Offset layoutOffset;
  final Size paintExtent;
  final bool keepAlive;
  final bool isVisible;

  _ParentDataRecord copyWith({bool? keepAlive}) {
    return _ParentDataRecord(
      vicinity: vicinity,
      layoutOffset: layoutOffset,
      paintExtent: paintExtent,
      keepAlive: keepAlive ?? this.keepAlive,
      isVisible: isVisible,
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.index, required this.record, required this.onToggle});

  final int index;
  final _ParentDataRecord record;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final statusColor = record.isVisible
        ? const Color(0xFFDCFCE7)
        : (record.keepAlive ? const Color(0xFFE0E7FF) : const Color(0xFFFEE2E2));
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF64748B), width: 0.6),
      ),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text('$index')),
          Expanded(child: Text('vicinity (${record.vicinity.xIndex}, ${record.vicinity.yIndex})')),
          Expanded(child: Text('visible ${record.isVisible}')),
          Expanded(child: Text('keepAlive ${record.keepAlive}')),
          TextButton(onPressed: onToggle, child: const Text('toggle')),
        ],
      ),
    );
  }
}

class _VisibilityPainter extends CustomPainter {
  const _VisibilityPainter({required this.clipRect, required this.childRect});

  final Rect clipRect;
  final Rect childRect;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF8FAFC);
    canvas.drawRect(Offset.zero & size, bg);

    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final clipPaint = Paint()
      ..color = const Color(0x220EA5E9)
      ..style = PaintingStyle.fill;
    canvas.drawRect(clipRect, clipPaint);

    final clipBorder = Paint()
      ..color = const Color(0xFF0EA5E9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(clipRect, clipBorder);

    final childPaint = Paint()
      ..color = const Color(0x22F97316)
      ..style = PaintingStyle.fill;
    canvas.drawRect(childRect, childPaint);

    final childBorder = Paint()
      ..color = const Color(0xFFEA580C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(childRect, childBorder);

    final intersection = clipRect.intersect(childRect);
    if (intersection.width > 0 && intersection.height > 0) {
      final visPaint = Paint()
        ..color = const Color(0x55A3E635)
        ..style = PaintingStyle.fill;
      canvas.drawRect(intersection, visPaint);
      final visBorder = Paint()
        ..color = const Color(0xFF4D7C0F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;
      canvas.drawRect(intersection, visBorder);
    }
  }

  @override
  bool shouldRepaint(covariant _VisibilityPainter oldDelegate) {
    return oldDelegate.clipRect != clipRect || oldDelegate.childRect != childRect;
  }
}
