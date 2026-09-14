// D4rt test script: Tests InteractiveViewer from widgets
// Deep Demo: The Pan-and-Zoom Workshop
//
// InteractiveViewer wraps a child in a viewport that supports pan/scale gestures
// by maintaining a Matrix4 transformation. It is used by maps, image viewers,
// diagram canvases, and any scenario where the user needs to navigate content
// larger than the viewport. This demo walks through every major knob:
//   * minScale / maxScale / scaleFactor
//   * panEnabled / scaleEnabled
//   * boundaryMargin
//   * constrained
//   * alignment, clipBehavior
//   * TransformationController (a ValueNotifier<Matrix4>)
//   * onInteractionStart / Update / End
//   * interactionEndFrictionCoefficient
//   * InteractiveViewer.builder for very large content
//
// The visual theme is "the pan-and-zoom workshop": a vintage drafting room
// where every tool is laid out on a workbench so the reader can see what each
// parameter does in isolation.
import 'package:flutter/material.dart';

// Note: this script intentionally avoids `package:vector_math/vector_math_64.dart`
// because `Quad` and `Vector3` are not re-exported by `package:flutter/material.dart`
// (Flutter only re-exports `Matrix4`). The `InteractiveViewer.builder` constructor —
// which would require `Quad` in its callback signature — is therefore demonstrated
// via the standard `InteractiveViewer` with `constrained: false` instead. See
// interpreter_unfixable.md for the underlying root cause.

// ---------------------------------------------------------------------------
// Shared visual helpers
// ---------------------------------------------------------------------------

const Color _workshopInk = Color(0xFF1F2933);
const Color _workshopPaper = Color(0xFFF8F4EA);
const Color _workshopAccent = Color(0xFF8C5A2B);
const Color _workshopRule = Color(0xFFB89773);

Widget _sectionHeader(String number, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFF7E8), Color(0xFFF1E4C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _workshopRule, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _workshopInk.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _workshopAccent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: _workshopPaper,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: _workshopInk,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13.0,
                  height: 1.35,
                  color: _workshopInk,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _narrativeCard(String body) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _workshopPaper,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _workshopRule.withValues(alpha: 0.6)),
    ),
    child: Text(
      body,
      style: const TextStyle(
        fontSize: 13.0,
        height: 1.4,
        color: _workshopInk,
      ),
    ),
  );
}

Widget _chip(String label, String value, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11.0,
            color: _workshopInk,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter: grid background used inside the viewers
// ---------------------------------------------------------------------------

class _GridPainter extends CustomPainter {
  const _GridPainter({
    required this.spacing,
    required this.lineColor,
    required this.majorEvery,
  });

  final double spacing;
  final Color lineColor;
  final int majorEvery;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint minor = Paint()
      ..color = lineColor.withValues(alpha: 0.35)
      ..strokeWidth = 0.7;
    final Paint major = Paint()
      ..color = lineColor.withValues(alpha: 0.85)
      ..strokeWidth = 1.4;
    int i = 0;
    for (double x = 0; x <= size.width; x += spacing) {
      final Paint p = i % majorEvery == 0 ? major : minor;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
      i++;
    }
    i = 0;
    for (double y = 0; y <= size.height; y += spacing) {
      final Paint p = i % majorEvery == 0 ? major : minor;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) =>
      old.spacing != spacing ||
      old.lineColor != lineColor ||
      old.majorEvery != majorEvery;
}

Widget _gridSurface({
  required double width,
  required double height,
  required List<Color> gradient,
  required String label,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: CustomPaint(
      painter: const _GridPainter(
        spacing: 30.0,
        lineColor: Colors.white,
        majorEvery: 4,
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: _workshopInk.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: _workshopPaper,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3: Default behavior — live scale readout
// ---------------------------------------------------------------------------

class _DefaultViewer extends StatefulWidget {
  const _DefaultViewer();

  @override
  State<_DefaultViewer> createState() => _DefaultViewerState();
}

class _DefaultViewerState extends State<_DefaultViewer> {
  final TransformationController _controller = TransformationController();
  double _scale = 1.0;
  double _tx = 0.0;
  double _ty = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onMatrix);
  }

  void _onMatrix() {
    final Matrix4 m = _controller.value;
    setState(() {
      _scale = m.getMaxScaleOnAxis();
      // Read translation directly from the column-major storage instead of
      // m.getTranslation().x/.y — Vector3 is not bridged in this interpreter.
      _tx = m[12];
      _ty = m[13];
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onMatrix);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 280.0,
          height: 280.0,
          decoration: BoxDecoration(
            border: Border.all(color: _workshopInk, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: InteractiveViewer(
              transformationController: _controller,
              minScale: 0.5,
              maxScale: 4.0,
              child: _gridSurface(
                width: 600.0,
                height: 600.0,
                gradient: const <Color>[
                  Color(0xFF4FC3F7),
                  Color(0xFF1976D2),
                ],
                label: '600x600 canvas',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: <Widget>[
            _chip('scale', _scale.toStringAsFixed(2), Colors.indigo),
            _chip('tx', _tx.toStringAsFixed(1), Colors.teal),
            _chip('ty', _ty.toStringAsFixed(1), Colors.teal),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4: min/max scale stepladder
// ---------------------------------------------------------------------------

class _ScaleRangeViewer extends StatefulWidget {
  const _ScaleRangeViewer({
    required this.minScale,
    required this.maxScale,
    required this.tint,
    required this.title,
  });

  final double minScale;
  final double maxScale;
  final Color tint;
  final String title;

  @override
  State<_ScaleRangeViewer> createState() => _ScaleRangeViewerState();
}

class _ScaleRangeViewerState extends State<_ScaleRangeViewer> {
  final TransformationController _controller = TransformationController();
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value.getMaxScaleOnAxis();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _workshopPaper,
        border: Border.all(color: widget.tint, width: 1.6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: widget.tint,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'range: ${widget.minScale} - ${widget.maxScale}',
            style: const TextStyle(fontSize: 11.0, color: _workshopInk),
          ),
          const SizedBox(height: 8.0),
          ClipRect(
            child: SizedBox(
              width: 180.0,
              height: 180.0,
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: widget.minScale,
                maxScale: widget.maxScale,
                child: _gridSurface(
                  width: 360.0,
                  height: 360.0,
                  gradient: <Color>[
                    widget.tint.withValues(alpha: 0.4),
                    widget.tint,
                  ],
                  label: widget.title,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          _chip('scale', _scale.toStringAsFixed(2), widget.tint),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5: pan / scale toggles
// ---------------------------------------------------------------------------

Widget _toggleViewer({
  required bool panEnabled,
  required bool scaleEnabled,
  required Color tint,
  required String title,
  required String note,
}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _workshopPaper,
      border: Border.all(color: tint, width: 1.6),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: tint,
          ),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: <Widget>[
            Icon(
              panEnabled ? Icons.check_circle : Icons.cancel,
              size: 14.0,
              color: panEnabled ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 4.0),
            const Text('pan', style: TextStyle(fontSize: 11.0)),
            const SizedBox(width: 10.0),
            Icon(
              scaleEnabled ? Icons.check_circle : Icons.cancel,
              size: 14.0,
              color: scaleEnabled ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 4.0),
            const Text('scale', style: TextStyle(fontSize: 11.0)),
          ],
        ),
        const SizedBox(height: 8.0),
        ClipRect(
          child: SizedBox(
            width: 180.0,
            height: 140.0,
            child: InteractiveViewer(
              panEnabled: panEnabled,
              scaleEnabled: scaleEnabled,
              minScale: 0.5,
              maxScale: 4.0,
              child: _gridSurface(
                width: 280.0,
                height: 220.0,
                gradient: <Color>[
                  tint.withValues(alpha: 0.5),
                  tint,
                ],
                label: title,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          width: 180.0,
          child: Text(
            note,
            style: const TextStyle(fontSize: 11.0, color: _workshopInk),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6: boundaryMargin demonstrator
// ---------------------------------------------------------------------------

Widget _boundaryViewer({
  required EdgeInsets margin,
  required String label,
  required String description,
  required Color tint,
}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _workshopPaper,
      border: Border.all(color: tint, width: 1.6),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: tint,
          ),
        ),
        const SizedBox(height: 6.0),
        ClipRect(
          child: SizedBox(
            width: 180.0,
            height: 140.0,
            child: InteractiveViewer(
              boundaryMargin: margin,
              minScale: 0.4,
              maxScale: 4.0,
              child: _gridSurface(
                width: 260.0,
                height: 200.0,
                gradient: <Color>[
                  tint.withValues(alpha: 0.45),
                  tint,
                ],
                label: label,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          width: 180.0,
          child: Text(
            description,
            style: const TextStyle(fontSize: 11.0, color: _workshopInk),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7: constrained: false with large intrinsic content
// ---------------------------------------------------------------------------

Widget _unconstrainedViewer() {
  return Container(
    height: 360.0,
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      border: Border.all(color: _workshopInk, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(80.0),
        minScale: 0.2,
        maxScale: 3.0,
        child: _gridSurface(
          width: 1200.0,
          height: 800.0,
          gradient: const <Color>[
            Color(0xFFFFB74D),
            Color(0xFFE65100),
          ],
          label: 'constrained: false (1200x800 intrinsic)',
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: TransformationController-driven (reset / center / zoom)
// ---------------------------------------------------------------------------

class _ControlledViewer extends StatefulWidget {
  const _ControlledViewer();

  @override
  State<_ControlledViewer> createState() => _ControlledViewerState();
}

class _ControlledViewerState extends State<_ControlledViewer>
    with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );
  Animation<Matrix4>? _tween;

  void _animateTo(Matrix4 target) {
    _tween = Matrix4Tween(begin: _controller.value, end: target)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));
    _tween!.addListener(_apply);
    _anim
      ..reset()
      ..forward();
  }

  void _apply() {
    if (_tween != null) {
      _controller.value = _tween!.value;
    }
  }

  void _reset() {
    _animateTo(Matrix4.identity());
  }

  void _zoomIn() {
    final Matrix4 next = _controller.value.clone()..scaleByDouble(1.6, 1.6, 1.0, 1.0);
    _animateTo(next);
  }

  void _zoomOut() {
    final double inv = 1.0 / 1.6;
    final Matrix4 next = _controller.value.clone()..scaleByDouble(inv, inv, 1.0, 1.0);
    _animateTo(next);
  }

  void _center() {
    final Matrix4 next = Matrix4.identity()..translateByDouble(-150.0, -100.0, 0.0, 1.0);
    _animateTo(next);
  }

  @override
  void dispose() {
    _tween?.removeListener(_apply);
    _anim.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        final Matrix4 m = _controller.value;
        final double scale = m.getMaxScaleOnAxis();
        // Read translation directly from the column-major storage instead of
        // m.getTranslation().x/.y — Vector3 is not bridged in this interpreter.
        final double tx = m[12];
        final double ty = m[13];
        return Column(
          children: <Widget>[
            Container(
              height: 280.0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: _workshopInk, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: InteractiveViewer(
                  transformationController: _controller,
                  minScale: 0.3,
                  maxScale: 6.0,
                  boundaryMargin: const EdgeInsets.all(120.0),
                  child: _gridSurface(
                    width: 720.0,
                    height: 480.0,
                    gradient: const <Color>[
                      Color(0xFF7E57C2),
                      Color(0xFF311B92),
                    ],
                    label: 'controlled canvas',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                _controlButton('reset', Icons.refresh, _reset),
                _controlButton('center', Icons.center_focus_strong, _center),
                _controlButton('zoom in', Icons.zoom_in, _zoomIn),
                _controlButton('zoom out', Icons.zoom_out, _zoomOut),
              ],
            ),
            const SizedBox(height: 8.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                _chip('scale', scale.toStringAsFixed(2), Colors.deepPurple),
                _chip('tx', tx.toStringAsFixed(1), Colors.deepPurple),
                _chip('ty', ty.toStringAsFixed(1), Colors.deepPurple),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _controlButton(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16.0),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9: InteractiveViewer with a large pre-built tiled canvas
// ---------------------------------------------------------------------------
//
// The `.builder` constructor would let us build tiles lazily based on the
// visible viewport `Quad`, but `Quad` lives in `package:vector_math/vector_math_64.dart`
// which is not re-exported by `package:flutter/material.dart`. We use the
// standard constructor with `constrained: false` and pre-build a moderate
// tile grid instead — the demo still covers the "large content" use case.

class _LargeTiledViewer extends StatefulWidget {
  const _LargeTiledViewer();

  @override
  State<_LargeTiledViewer> createState() => _LargeTiledViewerState();
}

class _LargeTiledViewerState extends State<_LargeTiledViewer> {
  final TransformationController _controller = TransformationController();
  static const double _tileSize = 80.0;
  static const int _gridCols = 12;
  static const int _gridRows = 12;
  static const double _canvasWidth = _tileSize * _gridCols;
  static const double _canvasHeight = _tileSize * _gridRows;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _tileAt(int col, int row) {
    final int sum = col + row;
    final Color base = sum.isEven
        ? const Color(0xFFE3F2FD)
        : const Color(0xFFBBDEFB);
    return Container(
      width: _tileSize,
      height: _tileSize,
      decoration: BoxDecoration(
        color: base,
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$col,$row',
        style: const TextStyle(
          fontSize: 9.0,
          color: Color(0xFF0D47A1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int row = 0; row < _gridRows; row++) {
      for (int col = 0; col < _gridCols; col++) {
        tiles.add(
          Positioned(
            left: col * _tileSize,
            top: row * _tileSize,
            child: _tileAt(col, row),
          ),
        );
      }
    }
    return Container(
      height: 340.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: _workshopInk, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InteractiveViewer(
          transformationController: _controller,
          constrained: false,
          minScale: 0.1,
          maxScale: 4.0,
          boundaryMargin: const EdgeInsets.all(200.0),
          child: SizedBox(
            width: _canvasWidth,
            height: _canvasHeight,
            child: Stack(children: tiles),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10: Faux map view with markers
// ---------------------------------------------------------------------------

class _MapCity {
  const _MapCity(this.name, this.dx, this.dy, this.color);
  final String name;
  final double dx;
  final double dy;
  final Color color;
}

class _FauxMapView extends StatefulWidget {
  const _FauxMapView();

  @override
  State<_FauxMapView> createState() => _FauxMapViewState();
}

class _FauxMapViewState extends State<_FauxMapView> {
  final TransformationController _controller = TransformationController();
  static const List<_MapCity> _cities = <_MapCity>[
    _MapCity('Anchorage', 120.0, 90.0, Colors.indigo),
    _MapCity('Reykjavik', 380.0, 110.0, Colors.teal),
    _MapCity('Lisbon', 520.0, 240.0, Colors.deepOrange),
    _MapCity('Cairo', 660.0, 260.0, Colors.amber),
    _MapCity('Bangkok', 880.0, 310.0, Colors.green),
    _MapCity('Buenos Aires', 410.0, 510.0, Colors.purple),
    _MapCity('Cape Town', 640.0, 520.0, Colors.brown),
    _MapCity('Sydney', 980.0, 540.0, Colors.red),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetHome() {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 340.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: _workshopInk, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: InteractiveViewer(
              transformationController: _controller,
              minScale: 0.5,
              maxScale: 6.0,
              boundaryMargin: const EdgeInsets.all(60.0),
              child: SizedBox(
                width: 1100.0,
                height: 620.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 1100.0,
                      height: 620.0,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFB3E5FC),
                            Color(0xFF4FC3F7),
                            Color(0xFF0288D1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: CustomPaint(
                        painter: const _GridPainter(
                          spacing: 50.0,
                          lineColor: Colors.white,
                          majorEvery: 4,
                        ),
                      ),
                    ),
                    for (final _MapCity c in _cities)
                      Positioned(
                        left: c.dx,
                        top: c.dy,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              size: 28.0,
                              color: c.color,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 2.0,
                              ),
                              decoration: BoxDecoration(
                                color: _workshopPaper.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                c.name,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: _workshopInk,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton.icon(
          onPressed: _resetHome,
          icon: const Icon(Icons.home),
          label: const Text('reset to home view'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0288D1),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 11: Interaction event log
// ---------------------------------------------------------------------------

class _InteractionLogViewer extends StatefulWidget {
  const _InteractionLogViewer();

  @override
  State<_InteractionLogViewer> createState() => _InteractionLogViewerState();
}

class _InteractionLogViewerState extends State<_InteractionLogViewer> {
  final TransformationController _controller = TransformationController();
  final List<String> _events = <String>[];

  void _push(String entry) {
    setState(() {
      _events.insert(0, entry);
      if (_events.length > 5) {
        _events.removeRange(5, _events.length);
      }
    });
    debugPrint('interaction event: $entry');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 240.0,
            height: 240.0,
            decoration: BoxDecoration(
              border: Border.all(color: _workshopInk, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: 0.5,
                maxScale: 5.0,
                interactionEndFrictionCoefficient: 0.0000135,
                onInteractionStart: (ScaleStartDetails d) {
                  _push(
                    'start  pointers=${d.pointerCount} '
                    'focal=(${d.focalPoint.dx.toStringAsFixed(0)},'
                    '${d.focalPoint.dy.toStringAsFixed(0)})',
                  );
                },
                onInteractionUpdate: (ScaleUpdateDetails d) {
                  _push(
                    'update scale=${d.scale.toStringAsFixed(2)} '
                    'rot=${d.rotation.toStringAsFixed(2)}',
                  );
                },
                onInteractionEnd: (ScaleEndDetails d) {
                  _push(
                    'end    vel=${d.velocity.pixelsPerSecond.distance
                        .toStringAsFixed(1)}',
                  );
                },
                child: _gridSurface(
                  width: 480.0,
                  height: 480.0,
                  gradient: const <Color>[
                    Color(0xFFA1887F),
                    Color(0xFF4E342E),
                  ],
                  label: 'log target',
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Container(
              height: 240.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _workshopInk,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'event log (most recent first)',
                    style: TextStyle(
                      color: _workshopPaper,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (_events.isEmpty)
                    const Text(
                      '(pan or pinch the canvas to populate)',
                      style: TextStyle(
                        color: _workshopPaper,
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  for (final String e in _events)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: _workshopPaper,
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2: anatomy of the transform diagram
// ---------------------------------------------------------------------------

Widget _transformAnatomy() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _workshopPaper,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _workshopRule, width: 1.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Matrix4 — 4x4 transformation encoded by the viewer',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: _workshopInk,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _workshopInk,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _MatrixRow(<String>['sx', '0', '0', 'tx']),
              _MatrixRow(<String>['0', 'sy', '0', 'ty']),
              _MatrixRow(<String>['0', '0', '1', '0']),
              _MatrixRow(<String>['0', '0', '0', '1']),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Wrap(
          children: <Widget>[
            _LegendEntry('sx, sy', 'horizontal/vertical scale'),
            _LegendEntry('tx, ty', 'pan translation in pixels'),
            _LegendEntry('row 3', 'reserved for Z (rarely used here)'),
            _LegendEntry('row 4', 'projective homogenous component'),
          ],
        ),
      ],
    ),
  );
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow(this.values);
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          for (final String v in values)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _workshopPaper.withValues(alpha: 0.12),
                  border: Border.all(
                    color: _workshopPaper.withValues(alpha: 0.4),
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  v,
                  style: const TextStyle(
                    color: _workshopPaper,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LegendEntry extends StatelessWidget {
  const _LegendEntry(this.symbol, this.text);
  final String symbol;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _workshopAccent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: _workshopAccent.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            symbol,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: _workshopAccent,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            text,
            style: const TextStyle(fontSize: 12.0, color: _workshopInk),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 12: best practices
// ---------------------------------------------------------------------------

Widget _bestPracticesCard() {
  const List<List<String>> items = <List<String>>[
    <String>[
      'Always dispose TransformationController',
      'It is a ValueNotifier; leaks add listeners over time.',
    ],
    <String>[
      'Pick sensible scale bounds',
      'min ~0.5 - 1.0, max ~2.0 - 6.0 for most apps.',
    ],
    <String>[
      'Prefer builder for huge content',
      'Only the visible viewport is built; saves memory.',
    ],
    <String>[
      'Use boundaryMargin: infinite for free roam',
      'Constraints feel claustrophobic for maps and large canvases.',
    ],
    <String>[
      'Reset via controller, not setState',
      'Assigning Matrix4.identity() is the canonical reset.',
    ],
    <String>[
      'Accessibility',
      'Provide buttons (reset/zoom) for users who cannot pinch.',
    ],
  ];
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade700, width: 1.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.verified, color: Colors.green.shade800),
            const SizedBox(width: 6.0),
            Text(
              'best practices',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        for (final List<String> entry in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  size: 16.0,
                  color: Colors.green.shade700,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        entry[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _workshopInk,
                          fontSize: 13.0,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        entry[1],
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: _workshopInk,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero header
// ---------------------------------------------------------------------------

Widget _heroHeader() {
  return Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1F2933),
          Color(0xFF3E4C59),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _workshopInk.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 84.0,
          height: 84.0,
          decoration: BoxDecoration(
            color: _workshopAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(
            Icons.pan_tool,
            color: _workshopPaper,
            size: 44.0,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'InteractiveViewer',
                style: TextStyle(
                  color: _workshopPaper,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'The pan-and-zoom workshop',
                style: TextStyle(
                  color: _workshopPaper.withValues(alpha: 0.85),
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Wraps a child in a Matrix4 transform driven by pan and pinch. '
                'Used for maps, image viewers, schematic diagrams and any '
                'canvas larger than the visible viewport.',
                style: TextStyle(
                  color: _workshopPaper.withValues(alpha: 0.85),
                  fontSize: 12.5,
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

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('InteractiveViewer Deep Demo executing');

  // SECTION 1: hero header
  final Widget hero = _heroHeader();

  // SECTION 2: anatomy of the transform
  final Widget anatomy = _transformAnatomy();

  // SECTION 3: default behavior
  const Widget defaultViewer = _DefaultViewer();

  // SECTION 4: min/max scale stepladder
  final Widget scaleStepladder = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      children: const <Widget>[
        _ScaleRangeViewer(
          minScale: 0.5,
          maxScale: 2.0,
          tint: Color(0xFF1E88E5),
          title: 'gentle',
        ),
        _ScaleRangeViewer(
          minScale: 1.0,
          maxScale: 4.0,
          tint: Color(0xFF43A047),
          title: 'standard',
        ),
        _ScaleRangeViewer(
          minScale: 0.1,
          maxScale: 10.0,
          tint: Color(0xFFE53935),
          title: 'wide',
        ),
      ],
    ),
  );

  // SECTION 5: panEnabled / scaleEnabled
  final Widget toggleGrid = Wrap(
    alignment: WrapAlignment.center,
    children: <Widget>[
      _toggleViewer(
        panEnabled: true,
        scaleEnabled: true,
        tint: const Color(0xFF1E88E5),
        title: 'both on',
        note: 'Default. User can pan and pinch freely.',
      ),
      _toggleViewer(
        panEnabled: true,
        scaleEnabled: false,
        tint: const Color(0xFF8E24AA),
        title: 'pan only',
        note: 'Useful when you handle zoom yourself.',
      ),
      _toggleViewer(
        panEnabled: false,
        scaleEnabled: true,
        tint: const Color(0xFFFB8C00),
        title: 'scale only',
        note: 'Locks position, allows zoom — good for fixed inspections.',
      ),
      _toggleViewer(
        panEnabled: false,
        scaleEnabled: false,
        tint: const Color(0xFF6D4C41),
        title: 'both off',
        note: 'Effectively static. Use only if you drive the matrix manually.',
      ),
    ],
  );

  // SECTION 6: boundaryMargin
  final Widget boundaryRow = Wrap(
    alignment: WrapAlignment.center,
    children: <Widget>[
      _boundaryViewer(
        margin: EdgeInsets.zero,
        label: 'tight',
        description: 'EdgeInsets.zero — child cannot pan past its bounds.',
        tint: const Color(0xFFD81B60),
      ),
      _boundaryViewer(
        margin: const EdgeInsets.all(60.0),
        label: 'breathing room',
        description: 'EdgeInsets.all(60) — child can overshoot a little.',
        tint: const Color(0xFF00897B),
      ),
      _boundaryViewer(
        margin: const EdgeInsets.all(double.infinity),
        label: 'infinite',
        description: 'EdgeInsets.all(infinity) — unconstrained roam.',
        tint: const Color(0xFF5E35B1),
      ),
    ],
  );

  // SECTION 7: constrained: false
  final Widget unconstrained = _unconstrainedViewer();

  // SECTION 8: controller-driven
  const Widget controlled = _ControlledViewer();

  // SECTION 9: large pre-built tiled content
  const Widget huge = _LargeTiledViewer();

  // SECTION 10: faux map
  const Widget mapView = _FauxMapView();

  // SECTION 11: interaction log
  const Widget log = _InteractionLogViewer();

  // SECTION 12: best practices
  final Widget best = _bestPracticesCard();

  return Scaffold(
    backgroundColor: const Color(0xFFFAF6EA),
    appBar: AppBar(
      backgroundColor: _workshopInk,
      foregroundColor: _workshopPaper,
      title: const Text('InteractiveViewer — pan-and-zoom workshop'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // SECTION 1: Hero header
          hero,

          // SECTION 2: Matrix anatomy
          _sectionHeader(
            '2',
            'Anatomy of the transform',
            'Every gesture mutates a single Matrix4. Translation is pan, '
                'diagonal is scale, the rest is rarely touched.',
          ),
          _narrativeCard(
            'InteractiveViewer keeps a Matrix4 inside a TransformationController '
            '(a ValueNotifier<Matrix4>). Pan and pinch translate and scale this '
            'matrix; everything you observe on screen is this matrix applied to '
            'the child via a Transform widget.',
          ),
          anatomy,

          // SECTION 3: Default behavior
          _sectionHeader(
            '3',
            'Default behavior',
            '600x600 gradient grid inside a 280x280 viewport — pan to explore.',
          ),
          _narrativeCard(
            'With no configuration the viewer accepts pan and pinch, clamps '
            'scale between 0.8 and 2.5, and keeps the child inside its bounds. '
            'Watch the chips below — the matrix decomposes into scale and '
            'translation in real time.',
          ),
          const Center(child: defaultViewer),

          // SECTION 4: scale stepladder
          _sectionHeader(
            '4',
            'min / max scale stepladder',
            'Three viewers, three scale ranges. Live scale is shown below each.',
          ),
          _narrativeCard(
            'minScale and maxScale define the range. The "gentle" range is '
            'great for portraits, "standard" matches most photo galleries, and '
            '"wide" suits diagram inspection where you need to read fine print.',
          ),
          scaleStepladder,

          // SECTION 5: pan / scale toggles
          _sectionHeader(
            '5',
            'panEnabled / scaleEnabled toggles',
            'Independently disable pan or scale to fit your UX.',
          ),
          _narrativeCard(
            'panEnabled and scaleEnabled both default to true. Disabling them '
            'is rarely needed but handy if you handle zoom via buttons or want '
            'a fixed inspection target.',
          ),
          toggleGrid,

          // SECTION 6: boundaryMargin
          _sectionHeader(
            '6',
            'boundaryMargin — how far past the child the user may pan',
            'Zero clamps tightly. Infinity unlocks free roam.',
          ),
          _narrativeCard(
            'boundaryMargin defines virtual padding around the child. Pan and '
            'scale are constrained so the child cannot move outside (child '
            'bounds + boundaryMargin). Use infinity for maps; use zero to keep '
            'the user focused on a single asset.',
          ),
          boundaryRow,

          // SECTION 7: constrained: false
          _sectionHeader(
            '7',
            'constrained: false — let the child be its intrinsic size',
            'For very large content (1200x800 here) you must opt out of '
                'constraint propagation.',
          ),
          _narrativeCard(
            'By default the child receives the viewer\'s constraints. Set '
            'constrained: false to give it unbounded constraints so the child '
            'can take its intrinsic size — required for huge canvases.',
          ),
          unconstrained,

          // SECTION 8: TransformationController-driven
          _sectionHeader(
            '8',
            'TransformationController-driven viewer',
            'Reset, center, zoom in, zoom out — animated via Matrix4Tween.',
          ),
          _narrativeCard(
            'Drive the viewer programmatically by assigning a new Matrix4 to '
            'the controller. Wrap that assignment in an AnimationController + '
            'Matrix4Tween for smooth transitions. Below the canvas the matrix '
            'is decomposed into scale and translation chips.',
          ),
          controlled,

          // SECTION 9: large pre-built tiled content
          _sectionHeader(
            '9',
            'Large tiled content with constrained: false',
            '12x12 tile grid at 80px each — pan and zoom around the canvas.',
          ),
          _narrativeCard(
            'For large content, set constrained: false and feed the viewer a '
            'child sized to the full canvas. (The InteractiveViewer.builder '
            'constructor offers lazy per-viewport tile construction but its '
            'callback receives a Quad from package:vector_math/vector_math_64.dart '
            'which is not re-exported by package:flutter/material.dart, so this '
            'demo uses the pre-built form instead.)',
          ),
          huge,

          // SECTION 10: faux map
          _sectionHeader(
            '10',
            'Faux map view with markers',
            'A "world map" gradient with city markers — reset to home view '
                'button restores Matrix4.identity().',
          ),
          _narrativeCard(
            'This pattern shows up everywhere: a static background with '
            'positioned overlays, all inside an InteractiveViewer. Markers '
            'scale with the canvas because they share the same Transform.',
          ),
          mapView,

          // SECTION 11: interaction event log
          _sectionHeader(
            '11',
            'onInteractionStart / Update / End',
            'Capture the last 5 events from each callback into a console panel.',
          ),
          _narrativeCard(
            'These callbacks fire on every gesture phase. interactionEnd also '
            'carries velocity — useful for friction-aware UX. '
            'interactionEndFrictionCoefficient (set to a small value here) '
            'controls how quickly the inertial fling decays after release.',
          ),
          log,

          // SECTION 12: best practices
          _sectionHeader(
            '12',
            'Best practices',
            'A short checklist before shipping a viewer to production.',
          ),
          best,

          const SizedBox(height: 28.0),
        ],
      ),
    ),
  );
}
