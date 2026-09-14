import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Resize Seismograph — a deep visual demo for
// SizeChangedLayoutNotification. This file is executed by the d4rt AST test
// harness (no main(), no runApp()). The entry point is the top-level
// `build(BuildContext)` function, which returns a MaterialApp with a
// Scaffold that hosts a dense stack of scenes showing how
// SizeChangedLayoutNotifier dispatches SizeChangedLayoutNotification and how
// to listen to it via NotificationListener<SizeChangedLayoutNotification>.
// ---------------------------------------------------------------------------

// === Palette ==============================================================
const Color _charcoal = Color(0xFF0B1120);
const Color _charcoalDeeper = Color(0xFF05080F);
const Color _magenta = Color(0xFFEC4899);
const Color _magentaSoft = Color(0xFFF9A8D4);
const Color _paleSky = Color(0xFFE0F2FE);
const Color _paleSkyDim = Color(0xFFBAE6FD);
const Color _gridLine = Color(0xFF1F2937);
const Color _panelFill = Color(0xFF111827);
const Color _panelEdge = Color(0xFF1E293B);

// === Resize Event Model ===================================================
class _ResizeEvent {
  _ResizeEvent({
    required this.timestamp,
    required this.panelId,
    required this.oldSize,
    required this.newSize,
  });

  final DateTime timestamp;
  final String panelId;
  final Size? oldSize;
  final Size newSize;

  double get magnitude {
    final o = oldSize;
    if (o == null) {
      return newSize.width + newSize.height;
    }
    final dx = (newSize.width - o.width).abs();
    final dy = (newSize.height - o.height).abs();
    return math.sqrt(dx * dx + dy * dy);
  }

  String get timeLabel {
    String two(int n) => n.toString().padLeft(2, '0');
    String three(int n) => n.toString().padLeft(3, '0');
    return '${two(timestamp.hour)}:${two(timestamp.minute)}:${two(timestamp.second)}.${three(timestamp.millisecond)}';
  }

  String get fromLabel {
    final o = oldSize;
    if (o == null) return '—';
    return '${o.width.toStringAsFixed(1)} × ${o.height.toStringAsFixed(1)}';
  }

  String get toLabel {
    return '${newSize.width.toStringAsFixed(1)} × ${newSize.height.toStringAsFixed(1)}';
  }
}

// === Top-level build (entry point for d4rt AST harness) ==================
dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Resize Seismograph',
    home: _ResizeSeismographHome(),
  );
}

class _ResizeSeismographHome extends StatefulWidget {
  const _ResizeSeismographHome();

  @override
  State<_ResizeSeismographHome> createState() => _ResizeSeismographHomeState();
}

class _ResizeSeismographHomeState extends State<_ResizeSeismographHome> {
  // Shared seismograph trace of all magnitudes, most recent last.
  final List<double> _trace = <double>[];
  // Shared notification log.
  final List<_ResizeEvent> _log = <_ResizeEvent>[];
  int _totalNotifications = 0;

  void _record(_ResizeEvent event) {
    setState(() {
      _totalNotifications += 1;
      _trace.add(event.magnitude);
      if (_trace.length > 120) {
        _trace.removeRange(0, _trace.length - 120);
      }
      _log.insert(0, event);
      if (_log.length > 40) {
        _log.removeRange(40, _log.length);
      }
    });
    debugPrint(
      'SizeChangedLayoutNotification · ${event.panelId} · '
      '${event.fromLabel} → ${event.toLabel}',
    );
  }

  void _clearLog() {
    setState(() {
      _log.clear();
      _trace.clear();
      _totalNotifications = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _charcoal,
      appBar: AppBar(
        backgroundColor: _charcoalDeeper,
        foregroundColor: _paleSky,
        elevation: 0,
        title: const Text('SizeChangedLayoutNotification · Resize Seismograph'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'total · $_totalNotifications',
                style: const TextStyle(color: _magentaSoft, fontSize: 13),
              ),
            ),
          ),
          IconButton(
            onPressed: _clearLog,
            icon: const Icon(Icons.clear_all),
            color: _paleSky,
            tooltip: 'Clear log',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _SeismographHero(trace: _trace, total: _totalNotifications),
          const SizedBox(height: 20),
          _ResizerPanel(onEvent: _record),
          const SizedBox(height: 20),
          _CellGrid(onEvent: _record),
          const SizedBox(height: 20),
          const _ResizeVsLayoutCompare(),
          const SizedBox(height: 20),
          _NotificationLog(events: _log),
          const SizedBox(height: 20),
          const _InfoTrio(),
          const SizedBox(height: 20),
          const _FieldReferenceTable(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// === Scene 1 · Hero seismograph ==========================================
class _SeismographHero extends StatelessWidget {
  const _SeismographHero({required this.trace, required this.total});

  final List<double> trace;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_charcoalDeeper, _panelFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _panelEdge),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _magenta.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _magenta,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Seismograph Trace',
                style: TextStyle(
                  color: _paleSky,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Text(
                'samples · ${trace.length}',
                style: const TextStyle(color: _paleSkyDim, fontSize: 12),
              ),
              const SizedBox(width: 16),
              Text(
                'events · $total',
                style: const TextStyle(color: _magentaSoft, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Each magenta spike is a SizeChangedLayoutNotification. '
            'Height is the magnitude of the size delta.',
            style: TextStyle(color: _paleSkyDim, fontSize: 12),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _SeismographPainter(trace: trace),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              _LegendDot(color: _magenta, label: 'resize spike'),
              SizedBox(width: 16),
              _LegendDot(color: _paleSkyDim, label: 'baseline'),
              SizedBox(width: 16),
              _LegendDot(color: _gridLine, label: 'grid'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

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
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: _paleSkyDim, fontSize: 11),
        ),
      ],
    );
  }
}

class _SeismographPainter extends CustomPainter {
  _SeismographPainter({required this.trace});

  final List<double> trace;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = _charcoalDeeper;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    // grid
    final gridPaint = Paint()
      ..color = _gridLine
      ..strokeWidth = 1;
    const cols = 12;
    const rows = 4;
    for (int i = 1; i < cols; i++) {
      final x = size.width * i / cols;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (int j = 1; j < rows; j++) {
      final y = size.height * j / rows;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // baseline
    final baseY = size.height * 0.82;
    final baselinePaint = Paint()
      ..color = _paleSkyDim.withValues(alpha: 0.4)
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(0, baseY), Offset(size.width, baseY), baselinePaint);

    if (trace.isEmpty) {
      final hint = TextPainter(
        text: const TextSpan(
          text: 'awaiting resize · drag sliders, press shake',
          style: TextStyle(color: _paleSkyDim, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      hint.paint(
        canvas,
        Offset(
          (size.width - hint.width) / 2,
          (size.height - hint.height) / 2,
        ),
      );
      return;
    }

    // normalize
    double maxMag = 1;
    for (final m in trace) {
      if (m > maxMag) maxMag = m;
    }
    final count = trace.length;
    final stepW = size.width / math.max(count, 1);
    final spikePaint = Paint()
      ..color = _magenta
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    final glowPaint = Paint()
      ..color = _magenta.withValues(alpha: 0.3)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // link path
    final linkPath = Path();
    for (int i = 0; i < count; i++) {
      final x = stepW * i + stepW / 2;
      final mag = trace[i];
      final y = baseY - (mag / maxMag) * (size.height * 0.72);
      if (i == 0) {
        linkPath.moveTo(x, baseY);
        linkPath.lineTo(x, y);
      } else {
        linkPath.lineTo(x, baseY);
        linkPath.lineTo(x, y);
      }
    }
    final linkPaint = Paint()
      ..color = _paleSkyDim.withValues(alpha: 0.25)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawPath(linkPath, linkPaint);

    for (int i = 0; i < count; i++) {
      final x = stepW * i + stepW / 2;
      final mag = trace[i];
      final y = baseY - (mag / maxMag) * (size.height * 0.72);
      canvas.drawLine(Offset(x, baseY), Offset(x, y), glowPaint);
      canvas.drawLine(Offset(x, baseY), Offset(x, y), spikePaint);
      canvas.drawCircle(Offset(x, y), 2.6, Paint()..color = _magentaSoft);
    }

    // axis labels
    final labelStyle = TextStyle(
      color: _paleSkyDim.withValues(alpha: 0.55),
      fontSize: 9,
    );
    final maxPainter = TextPainter(
      text: TextSpan(text: 'max ${maxMag.toStringAsFixed(1)}', style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    maxPainter.paint(canvas, const Offset(6, 4));
    final basePainter = TextPainter(
      text: TextSpan(text: 'baseline', style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    basePainter.paint(canvas, Offset(6, baseY + 3));
  }

  @override
  bool shouldRepaint(covariant _SeismographPainter oldDelegate) {
    return oldDelegate.trace != trace || oldDelegate.trace.length != trace.length;
  }
}

// === Scene 2 · Interactive resizer ======================================
class _ResizerPanel extends StatefulWidget {
  const _ResizerPanel({required this.onEvent});

  final void Function(_ResizeEvent event) onEvent;

  @override
  State<_ResizerPanel> createState() => _ResizerPanelState();
}

class _ResizerPanelState extends State<_ResizerPanel> {
  double _width = 220;
  double _height = 160;
  Size? _lastSize;
  int _localCount = 0;

  bool _handleNotification(SizeChangedLayoutNotification notification) {
    final renderObject = context.findRenderObject();
    Size current = Size(_width, _height);
    if (renderObject is RenderBox && renderObject.hasSize) {
      // Use the slider-driven size as the observed size; this is the
      // dimension we are explicitly changing.
      current = Size(_width, _height);
    }
    final event = _ResizeEvent(
      timestamp: DateTime.now(),
      panelId: 'resizer',
      oldSize: _lastSize,
      newSize: current,
    );
    _lastSize = current;
    _localCount += 1;
    widget.onEvent(event);
    // Returning true stops the notification from bubbling further.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _PanelFrame(
      title: 'Interactive Resizer',
      subtitle:
          'Drag sliders to change the child size. SizeChangedLayoutNotifier '
          'dispatches a notification whenever the rendered size differs from '
          'the previously observed size.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final wMax = constraints.maxWidth.clamp(160.0, 520.0);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NotificationListener<SizeChangedLayoutNotification>(
                onNotification: _handleNotification,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          _magenta.withValues(alpha: 0.9),
                          _magenta.withValues(alpha: 0.55),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _paleSky, width: 2),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _magenta.withValues(alpha: 0.35),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const SizeChangedLayoutNotifier(
                      child: Center(
                        child: _ResizerChildContent(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SliderRow(
                label: 'width',
                value: _width,
                min: 120,
                max: wMax,
                onChanged: (v) => setState(() => _width = v),
              ),
              _SliderRow(
                label: 'height',
                value: _height,
                min: 80,
                max: 260,
                onChanged: (v) => setState(() => _height = v),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  _MiniBadge(
                    icon: Icons.notifications_active,
                    label: 'listener fired',
                    value: '$_localCount',
                    color: _magenta,
                  ),
                  const SizedBox(width: 10),
                  _MiniBadge(
                    icon: Icons.aspect_ratio,
                    label: 'size',
                    value:
                        '${_width.toStringAsFixed(0)} × ${_height.toStringAsFixed(0)}',
                    color: _paleSky,
                  ),
                  const SizedBox(width: 10),
                  _MiniBadge(
                    icon: Icons.straighten,
                    label: 'last Δ',
                    value: _lastSize == null
                        ? '—'
                        : '${(_width - _lastSize!.width).toStringAsFixed(1)}, '
                            '${(_height - _lastSize!.height).toStringAsFixed(1)}',
                    color: _magentaSoft,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const _NoteBlock(
                text:
                    'Key detail: SizeChangedLayoutNotifier dispatches only '
                    'when the size actually changes. Layout passes that '
                    'result in the same size do not fire a notification.',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ResizerChildContent extends StatelessWidget {
  const _ResizerChildContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.open_in_full, color: _paleSky, size: 26),
        SizedBox(height: 4),
        Text(
          'SizeChangedLayoutNotifier',
          style: TextStyle(
            color: _paleSky,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Text(
          'child',
          style: TextStyle(color: _paleSkyDim, fontSize: 11),
        ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 56,
            child: Text(
              label,
              style: const TextStyle(
                color: _paleSkyDim,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _magenta,
                inactiveTrackColor: _gridLine,
                thumbColor: _paleSky,
                overlayColor: _magenta.withValues(alpha: 0.25),
                trackHeight: 3,
              ),
              child: Slider(
                value: value.clamp(min, max),
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              value.toStringAsFixed(0),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: _paleSky,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _charcoalDeeper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: _paleSkyDim, fontSize: 11),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteBlock extends StatelessWidget {
  const _NoteBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _charcoalDeeper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _magenta.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.info_outline, color: _magentaSoft, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _paleSkyDim, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// === Scene 3 · Cell grid 3x3 ============================================
class _CellGrid extends StatefulWidget {
  const _CellGrid({required this.onEvent});

  final void Function(_ResizeEvent event) onEvent;

  @override
  State<_CellGrid> createState() => _CellGridState();
}

class _CellGridState extends State<_CellGrid>
    with SingleTickerProviderStateMixin {
  static const int _cells = 9;
  late final AnimationController _controller;
  late final List<double> _seeds;
  final List<int> _counts = List<int>.filled(_cells, 0);
  final List<Size?> _lastSizes = List<Size?>.filled(_cells, null);
  final List<double> _widths = List<double>.filled(_cells, 80);
  final List<double> _heights = List<double>.filled(_cells, 80);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(_tick);
    final rng = math.Random(1312);
    _seeds = List<double>.generate(_cells, (_) => rng.nextDouble() * 6.28);
    // initialize with baseline sizes
    for (int i = 0; i < _cells; i++) {
      _widths[i] = 78 + (i % 3) * 2.0;
      _heights[i] = 68 + (i ~/ 3) * 2.0;
    }
  }

  void _tick() {
    final t = _controller.value;
    setState(() {
      for (int i = 0; i < _cells; i++) {
        final seed = _seeds[i];
        final dx = 30 * math.sin(seed + t * 6.28);
        final dy = 25 * math.cos(seed * 1.3 + t * 6.28);
        _widths[i] = 78 + dx;
        _heights[i] = 68 + dy;
      }
    });
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_tick)
      ..dispose();
    super.dispose();
  }

  void _shake() {
    _controller.forward(from: 0);
  }

  bool _onCell(int index, SizeChangedLayoutNotification notification) {
    final size = Size(_widths[index], _heights[index]);
    final event = _ResizeEvent(
      timestamp: DateTime.now(),
      panelId: 'cell#$index',
      oldSize: _lastSizes[index],
      newSize: size,
    );
    _lastSizes[index] = size;
    _counts[index] += 1;
    widget.onEvent(event);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _PanelFrame(
      title: '3 × 3 Cell Grid',
      subtitle:
          'Each cell has its own SizeChangedLayoutNotifier and local counter. '
          'Press Shake to drive all cells with an AnimationController.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _shake,
                icon: const Icon(Icons.vibration, size: 16),
                label: const Text('Shake'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _magenta,
                  foregroundColor: _paleSky,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'total events across grid · '
                '${_counts.fold<int>(0, (a, b) => a + b)}',
                style: const TextStyle(color: _paleSkyDim, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
              final side = (constraints.maxWidth - 16) / 3;
              return Column(
                children: <Widget>[
                  for (int row = 0; row < 3; row++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: <Widget>[
                          for (int col = 0; col < 3; col++) ...<Widget>[
                            SizedBox(
                              width: side,
                              height: side,
                              child: _buildCell(row * 3 + col),
                            ),
                            if (col < 2) const SizedBox(width: 8),
                          ],
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCell(int index) {
    final w = _widths[index];
    final h = _heights[index];
    return Container(
      decoration: BoxDecoration(
        color: _charcoalDeeper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _panelEdge),
      ),
      alignment: Alignment.center,
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (n) => _onCell(index, n),
        child: SizeChangedLayoutNotifier(
          child: SizedBox(
            width: w,
            height: h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _magenta.withValues(alpha: 0.85),
                    _magenta.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _paleSky.withValues(alpha: 0.5)),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 4,
                    left: 6,
                    child: Text(
                      '#$index',
                      style: const TextStyle(
                        color: _paleSky,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 6,
                    child: Text(
                      '${_counts[index]}',
                      style: const TextStyle(
                        color: _paleSky,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${w.toStringAsFixed(0)}×${h.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: _paleSky,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// === Scene 4 · LayoutBuilder vs SizeChangedLayoutNotification ==========
class _ResizeVsLayoutCompare extends StatefulWidget {
  const _ResizeVsLayoutCompare();

  @override
  State<_ResizeVsLayoutCompare> createState() => _ResizeVsLayoutCompareState();
}

class _ResizeVsLayoutCompareState extends State<_ResizeVsLayoutCompare> {
  double _width = 220;
  int _layoutBuilderFires = 0;
  int _sizeChangedFires = 0;
  int _rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    _rebuilds += 1;
    return _PanelFrame(
      title: 'LayoutBuilder vs SizeChangedLayoutNotification',
      subtitle:
          'LayoutBuilder rebuilds on every layout pass even if the size is '
          'unchanged. SizeChangedLayoutNotification only fires when the '
          'rendered size actually changes.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _magenta,
              inactiveTrackColor: _gridLine,
              thumbColor: _paleSky,
            ),
            child: Slider(
              value: _width.clamp(120.0, 320.0),
              min: 120,
              max: 320,
              onChanged: (v) => setState(() => _width = v),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _CompareCard(
                  title: 'LayoutBuilder',
                  color: _paleSky,
                  metricLabel: 'builder calls',
                  metricValue: '$_layoutBuilderFires',
                  child: SizedBox(
                    width: _width,
                    height: 90,
                    child: LayoutBuilder(
                      builder: (ctx, cs) {
                        _layoutBuilderFires += 1;
                        return Container(
                          decoration: BoxDecoration(
                            color: _paleSky.withValues(alpha: 0.25),
                            border: Border.all(color: _paleSky),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'cs: ${cs.maxWidth.toStringAsFixed(0)}×'
                            '${cs.maxHeight.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: _paleSky,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CompareCard(
                  title: 'SizeChangedLayoutNotification',
                  color: _magenta,
                  metricLabel: 'notifications',
                  metricValue: '$_sizeChangedFires',
                  child: NotificationListener<SizeChangedLayoutNotification>(
                    onNotification: (n) {
                      // NOTE: build() can not setState() synchronously, so
                      // defer.
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        setState(() => _sizeChangedFires += 1);
                      });
                      return true;
                    },
                    child: SizedBox(
                      width: _width,
                      height: 90,
                      child: const SizeChangedLayoutNotifier(
                        child: _CompareSubject(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'parent rebuilds · $_rebuilds',
            style: const TextStyle(color: _paleSkyDim, fontSize: 11),
          ),
          const SizedBox(height: 8),
          const _NoteBlock(
            text:
                'Prefer SizeChangedLayoutNotifier when you only care about '
                'actual size transitions (ink sparkle replays, scroll views '
                'resetting after a child grows, overlays recomputing). '
                'Prefer LayoutBuilder when rendering depends on incoming '
                'constraints regardless of whether they changed.',
          ),
        ],
      ),
    );
  }
}

class _CompareSubject extends StatelessWidget {
  const _CompareSubject();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _magenta.withValues(alpha: 0.25),
        border: Border.all(color: _magenta),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: const Text(
        'notify on size change',
        style: TextStyle(
          color: _magentaSoft,
          fontSize: 12,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.color,
    required this.metricLabel,
    required this.metricValue,
    required this.child,
  });

  final String title;
  final Color color;
  final String metricLabel;
  final String metricValue;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _charcoalDeeper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(alignment: Alignment.centerLeft, child: child),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                metricLabel,
                style: const TextStyle(color: _paleSkyDim, fontSize: 11),
              ),
              const SizedBox(width: 6),
              Text(
                metricValue,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// === Scene 5 · Notification log =========================================
class _NotificationLog extends StatelessWidget {
  const _NotificationLog({required this.events});

  final List<_ResizeEvent> events;

  @override
  Widget build(BuildContext context) {
    return _PanelFrame(
      title: 'Notification Log',
      subtitle:
          'Most recent first · timestamp · panel id · old size · new size · '
          'Δ magnitude',
      child: events.isEmpty
          ? const _NoteBlock(
              text:
                  'No SizeChangedLayoutNotification seen yet. Drag a slider '
                  'or press Shake to observe events appearing here.',
            )
          : Column(
              children: <Widget>[
                const _LogHeader(),
                const Divider(color: _gridLine, height: 12),
                for (final ev in events.take(14)) _LogRow(event: ev),
                if (events.length > 14)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '… ${events.length - 14} older event(s) not shown',
                      style: const TextStyle(color: _paleSkyDim, fontSize: 11),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _LogHeader extends StatelessWidget {
  const _LogHeader();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: _paleSkyDim,
      fontSize: 11,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w600,
    );
    return Row(
      children: const <Widget>[
        SizedBox(width: 120, child: Text('time', style: style)),
        SizedBox(width: 80, child: Text('panel', style: style)),
        SizedBox(width: 110, child: Text('old', style: style)),
        SizedBox(width: 110, child: Text('new', style: style)),
        Expanded(child: Text('Δ', style: style)),
      ],
    );
  }
}

class _LogRow extends StatelessWidget {
  const _LogRow({required this.event});

  final _ResizeEvent event;

  @override
  Widget build(BuildContext context) {
    const mono = TextStyle(
      color: _paleSky,
      fontSize: 11,
      fontFamily: 'monospace',
    );
    final magnitudeColor = event.magnitude > 40
        ? _magenta
        : event.magnitude > 10
            ? _magentaSoft
            : _paleSkyDim;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          SizedBox(width: 120, child: Text(event.timeLabel, style: mono)),
          SizedBox(
            width: 80,
            child: Text(
              event.panelId,
              style: const TextStyle(
                color: _magentaSoft,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 110, child: Text(event.fromLabel, style: mono)),
          SizedBox(width: 110, child: Text(event.toLabel, style: mono)),
          Expanded(
            child: Text(
              event.magnitude.toStringAsFixed(2),
              style: TextStyle(
                color: magnitudeColor,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// === Scene 6 · Instructional trio =======================================
class _InfoTrio extends StatelessWidget {
  const _InfoTrio();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        final isWide = constraints.maxWidth > 720;
        final cards = const <_InfoCardData>[
          _InfoCardData(
            icon: Icons.bolt,
            color: _magenta,
            title: 'What triggers it',
            body:
                'SizeChangedLayoutNotifier wraps a RenderSizeChangedWithCallback. '
                'It compares the post-layout size with the previously observed '
                'size and, if they differ, dispatches a '
                'SizeChangedLayoutNotification up the tree during the layout '
                'phase.',
          ),
          _InfoCardData(
            icon: Icons.alt_route,
            color: _paleSky,
            title: 'Bubble semantics',
            body:
                'SizeChangedLayoutNotification extends LayoutChangedNotification '
                'and bubbles up through the widget tree. Place a '
                'NotificationListener<SizeChangedLayoutNotification> anywhere '
                'above the notifier. Return true to stop propagation, false to '
                'let ancestors also observe the event.',
          ),
          _InfoCardData(
            icon: Icons.compare_arrows,
            color: _magentaSoft,
            title: 'When to prefer it',
            body:
                'Pick SizeChangedLayoutNotifier when you only need to react to '
                'actual size transitions (resetting InkSparkle, rebuilding an '
                'overlay, scheduling a paint animation). Pick LayoutBuilder '
                'when rendering must follow incoming constraints even when '
                'they are unchanged.',
          ),
        ];
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < cards.length; i++) ...<Widget>[
                Expanded(child: _InfoCard(data: cards[i])),
                if (i < cards.length - 1) const SizedBox(width: 12),
              ],
            ],
          );
        }
        return Column(
          children: <Widget>[
            for (final c in cards)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _InfoCard(data: c),
              ),
          ],
        );
      },
    );
  }
}

class _InfoCardData {
  const _InfoCardData({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.data});

  final _InfoCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _panelFill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: data.color.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: data.color.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(data.icon, color: data.color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.title,
                  style: TextStyle(
                    color: data.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.body,
            style: const TextStyle(
              color: _paleSkyDim,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// === Scene 7 · Field reference mini-table ==============================
class _FieldReferenceTable extends StatelessWidget {
  const _FieldReferenceTable();

  @override
  Widget build(BuildContext context) {
    const rows = <_RefRow>[
      _RefRow(
        symbol: 'SizeChangedLayoutNotification',
        kind: 'class',
        detail:
            'LayoutChangedNotification fired from a SizeChangedLayoutNotifier '
            'after layout detects a different size.',
      ),
      _RefRow(
        symbol: 'SizeChangedLayoutNotifier',
        kind: 'widget',
        detail:
            'SingleChildRenderObjectWidget that dispatches '
            'SizeChangedLayoutNotification when its rendered size changes.',
      ),
      _RefRow(
        symbol: 'NotificationListener<T>',
        kind: 'widget',
        detail:
            'Catches bubbling Notification objects of type T. Return true to '
            'stop further bubbling.',
      ),
      _RefRow(
        symbol: 'LayoutChangedNotification',
        kind: 'class',
        detail:
            'Supertype for layout-change notifications; '
            'SizeChangedLayoutNotification is currently its only concrete '
            'variant shipped with Flutter.',
      ),
      _RefRow(
        symbol: 'RenderSizeChangedWithCallback',
        kind: 'render',
        detail:
            'Underlying render object that compares old and new sizes and '
            'calls its onLayoutChangedCallback.',
      ),
      _RefRow(
        symbol: 'onNotification',
        kind: 'callback',
        detail:
            'bool Function(T notification) · returning true swallows the '
            'notification so ancestor listeners do not see it.',
      ),
      _RefRow(
        symbol: 'typical use',
        kind: 'pattern',
        detail:
            'Wrap a child whose size depends on dynamic content and observe '
            'size-change events to refresh overlays, ink effects, or cached '
            'measurements.',
      ),
    ];

    return _PanelFrame(
      title: 'Field Reference',
      subtitle: 'Quick lookup of related symbols in the Flutter widgets layer.',
      child: Column(
        children: <Widget>[
          const _RefHeader(),
          const Divider(color: _gridLine, height: 14),
          for (final r in rows) _RefRowTile(row: r),
        ],
      ),
    );
  }
}

class _RefRow {
  const _RefRow({
    required this.symbol,
    required this.kind,
    required this.detail,
  });

  final String symbol;
  final String kind;
  final String detail;
}

class _RefHeader extends StatelessWidget {
  const _RefHeader();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: _paleSkyDim,
      fontSize: 11,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w700,
    );
    return Row(
      children: const <Widget>[
        SizedBox(width: 220, child: Text('symbol', style: style)),
        SizedBox(width: 80, child: Text('kind', style: style)),
        Expanded(child: Text('detail', style: style)),
      ],
    );
  }
}

class _RefRowTile extends StatelessWidget {
  const _RefRowTile({required this.row});

  final _RefRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              row.symbol,
              style: const TextStyle(
                color: _paleSky,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: _magenta.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _magenta.withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                row.kind,
                style: const TextStyle(
                  color: _magentaSoft,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.detail,
              style: const TextStyle(
                color: _paleSkyDim,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// === Shared panel frame =================================================
class _PanelFrame extends StatelessWidget {
  const _PanelFrame({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _panelFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _panelEdge),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _charcoalDeeper.withValues(alpha: 0.6),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: _magenta,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _paleSky,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: _paleSkyDim,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Extended walk-through annotations — kept at the bottom of the file as a
// long-form reference for readers inspecting the test. They describe each
// scene, the Flutter widgets used, and the behavioural guarantees of
// SizeChangedLayoutNotification in exhausting detail.
// ---------------------------------------------------------------------------
//
// Scene 1 · Hero seismograph
// --------------------------
// The hero visualization is a CustomPainter that treats every
// SizeChangedLayoutNotification as a sample on a horizontal time axis. Each
// sample is drawn as a magenta spike whose height encodes the magnitude of
// the size delta. The baseline near the bottom represents zero-magnitude;
// a spike touching the top of the plot is the largest magnitude recorded
// within the most recent 120 samples. Grid lines are drawn in charcoal to
// keep the composition visually calm while still emphasising the magenta
// spikes. A text overlay shows the current maximum magnitude and the
// baseline label so the chart remains self-describing even when the data
// is empty.
//
// Scene 2 · Interactive resizer
// -----------------------------
// A single child wrapped in `SizeChangedLayoutNotifier` is driven by two
// sliders. The sliders update the width and height stored in state, which
// are applied to an AnimatedContainer. Every time the container settles on
// a new size, the notifier dispatches a SizeChangedLayoutNotification that
// bubbles up to a NotificationListener. The listener captures the old size
// (from a cached value), emits a `_ResizeEvent`, and returns `true` so the
// notification does not bubble further. A set of `_MiniBadge` widgets
// displays the current count, the current size, and the last delta vector.
//
// Scene 3 · 3 × 3 cell grid
// -------------------------
// Nine independently-resizable cells each host their own
// SizeChangedLayoutNotifier and per-cell counter. An AnimationController
// drives a sine/cosine oscillation per cell using random phase seeds. The
// result is a grid that pulses in various rhythms, producing a blizzard of
// notifications. Each listener appends to the shared log on the parent via
// a callback. The Shake button forwards the controller from zero to one
// over two seconds, but can be retriggered at any time.
//
// Scene 4 · LayoutBuilder vs SizeChangedLayoutNotification
// ---------------------------------------------------------
// Two cards sit side-by-side: the left card contains a LayoutBuilder whose
// builder callback increments a counter every time it runs; the right
// card contains a SizeChangedLayoutNotifier whose notifications are
// forwarded to a counter. In steady state, the LayoutBuilder counter grows
// on each parent rebuild even when the size did not change, while the
// SizeChangedLayoutNotification counter only grows when the width slider
// actually changes the size. A note block contrasts the two choices in
// practical terms: prefer the notifier for transition-triggered work and
// the builder for constraint-dependent rendering.
//
// Scene 5 · Notification log
// --------------------------
// A scrollable log records the most recent 40 events in reverse
// chronological order (newest at the top). Each row shows the precise
// timestamp, the panel identifier, the old size, the new size, and the
// computed magnitude. Magnitudes above 40 are drawn in magenta, those
// between 10 and 40 in soft magenta, and small deltas in pale sky to
// visually distinguish noisy micro-resizes from significant transitions.
//
// Scene 6 · Instructional trio
// ----------------------------
// Three stacked or side-by-side cards (depending on width) summarise the
// conceptual model: what triggers SizeChangedLayoutNotification, whether
// it bubbles up the tree, and when to prefer it over LayoutBuilder. Each
// card is colour-coded: magenta for "trigger", pale sky for "bubble",
// soft magenta for "preference".
//
// Scene 7 · Field reference
// -------------------------
// A dense reference table lists the related symbols — the notification
// itself, its notifier widget, the NotificationListener generic, the
// LayoutChangedNotification supertype, the underlying render object, the
// onNotification callback signature, and a canonical usage pattern. Each
// row includes a kind badge (class, widget, render, callback, pattern)
// to help readers quickly scan for the right abstraction level.
//
// Behavioural invariants of SizeChangedLayoutNotification
// -------------------------------------------------------
// 1. Fires only after the first layout. The initial size assignment does
//    not dispatch; the notifier first learns the baseline size, then
//    dispatches when subsequent layout produces a different size.
// 2. Fires exactly once per layout pass that changes the size. Consecutive
//    layouts with identical sizes do not fire additional notifications.
// 3. Bubbles up the widget tree as a standard Notification. A
//    NotificationListener<SizeChangedLayoutNotification> placed anywhere
//    above the notifier observes it. Returning true from the listener
//    stops further propagation.
// 4. Extends LayoutChangedNotification. The supertype is reserved for
//    future layout-change notifications; currently, the size-changed
//    variant is the only concrete implementation.
// 5. Uses the RenderSizeChangedWithCallback render object under the hood,
//    which stores the last observed size and invokes its callback when the
//    current size differs.
//
// Why this pattern matters
// ------------------------
// Layout-reactive visuals — ink sparkle, overlay anchors, scroll view
// offset corrections, custom scroll physics that depend on child extent —
// often need to perform imperative work when their child's size changes.
// Polling size in a LayoutBuilder produces unnecessary rebuilds and can
// miss the exact frame of the change. Subscribing to
// SizeChangedLayoutNotification delivers an event at precisely the right
// moment with a clean listener-based API that composes with the rest of
// the Flutter notification system.
//
// Closing remarks
// ---------------
// This file is an intentional end-to-end showcase rather than a minimal
// repro. It exercises the full surface of the notification: dispatching
// from a notifier, observing via a listener, counting events, logging
// payloads, comparing with LayoutBuilder, and discussing the semantic
// contract. It is designed to render within the d4rt AST harness which
// only requires a `dynamic build(BuildContext)` entry point.
//
// Extended walkthrough · frame-by-frame semantics
// -----------------------------------------------
// Reading the life-cycle of a single SizeChangedLayoutNotification event
// frame by frame helps clarify why the API is shaped the way it is.
//
//   Frame N       : Parent rebuilds. The widget tree below the
//                   `SizeChangedLayoutNotifier` is reconstructed, which may
//                   or may not change the incoming constraints.
//   Frame N.1     : The layout phase visits the notifier's render object
//                   (`RenderSizeChangedWithCallback`). It runs the child
//                   layout and compares the child's post-layout size with
//                   the previously stored size.
//   Frame N.2     : If the sizes differ, the stored size is updated and
//                   the render object schedules its onLayoutChangedCallback
//                   to run. This callback, supplied by the
//                   `SizeChangedLayoutNotifier` element, dispatches a fresh
//                   `SizeChangedLayoutNotification`.
//   Frame N.3     : The notification bubbles up through the element tree.
//                   Each `NotificationListener<SizeChangedLayoutNotification>`
//                   along the ancestor chain observes the event. Returning
//                   true halts propagation; returning false lets parent
//                   listeners also observe.
//   Frame N.4     : Paint runs. Any state mutated synchronously inside an
//                   `onNotification` callback is reflected on the same
//                   frame only if the mutation does not itself trigger a
//                   rebuild (e.g. by mutating a ValueNotifier). If the
//                   listener calls `setState`, the result is reflected one
//                   frame later.
//   Frame N+1     : If the state mutation triggered a rebuild, the updated
//                   tree is painted. This is why the comparison card uses
//                   `addPostFrameCallback` before calling `setState` — it
//                   keeps the build phase free of re-entrancy.
//
// The net effect is that SizeChangedLayoutNotification is a *layout-phase*
// event delivered at the exact frame where the size changed, rather than
// a deferred signal processed asynchronously after the frame completed.
// This tight coupling is what makes it so useful for ink effects and
// overlay anchoring: the consumer can recompute geometry and schedule a
// paint-phase update before the frame is committed to the screen.
//
// Anti-patterns to avoid
// ----------------------
// * Avoid calling `setState` synchronously inside an onNotification
//   callback that runs during the build phase. Dispatching a new build
//   while the tree is already building raises assertion failures. Defer
//   with `WidgetsBinding.instance.addPostFrameCallback`.
// * Avoid using SizeChangedLayoutNotification as a substitute for
//   LayoutBuilder when rendering depends on the *current* constraints
//   regardless of whether they changed. The notifier simply will not fire
//   on passes where the size is identical, so your builder will not re-run.
// * Avoid wrapping an enormous subtree in a SizeChangedLayoutNotifier
//   when you only need to observe a small inner widget. The notifier
//   only observes its immediate child, so wrap precisely the widget whose
//   geometry matters.
// * Avoid swallowing the notification unnecessarily. Return true from a
//   listener only when you are certain no ancestor should react to the
//   same event.
//
// Integration checklist
// ---------------------
// When integrating SizeChangedLayoutNotification into a real widget:
//   [1] Identify the exact child whose size is observed.
//   [2] Wrap that child in `SizeChangedLayoutNotifier`.
//   [3] Place a `NotificationListener<SizeChangedLayoutNotification>`
//       above the notifier at the level where the reaction should occur.
//   [4] In onNotification, perform your side effect (cache a measurement,
//       animate an overlay, update a controller). Keep the callback fast.
//   [5] Decide whether to return true (event is fully handled) or false
//       (allow ancestors to also react).
//   [6] Handle lifecycle: if your side effect uses controllers or
//       subscriptions, dispose of them appropriately.
//   [7] Test the integration with a widget test that drives resizes via
//       setState or AnimationController and asserts on the notification
//       count or the resulting side effect.
//
// End of file · Resize Seismograph demo.
// ----------------------------------------
