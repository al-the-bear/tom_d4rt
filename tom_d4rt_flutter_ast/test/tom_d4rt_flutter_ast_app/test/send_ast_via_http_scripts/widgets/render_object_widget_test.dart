// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

/// Deep visual demo — RenderObjectWidget
///
/// RenderObjectWidget is the abstract base class for widgets that create and
/// manage RenderObject instances. Every visual element on screen ultimately
/// passes through a RenderObjectWidget. This demo explores all three
/// concrete subclasses — Leaf, SingleChild, MultiChild — with live
/// interactive examples that show the create/update/unmount lifecycle.
///
/// Sections
/// ─────────
/// 1. What is RenderObjectWidget?
/// 2. The three subclass categories
/// 3. Lifecycle: createRenderObject / updateRenderObject / didUnmountRenderObject
/// 4. Live: custom LeafRenderObjectWidget (color swatch with adjustable hue)
/// 5. Live: custom SingleChildRenderObjectWidget (rounded inset wrapper)
/// 6. Live: custom MultiChildRenderObjectWidget (radial fan layout)
/// 7. RenderObjectElement pairing
/// 8. Debug diagnostics protocol

// ─── palette ───────────────────────────────────────────────
const _kTeal       = Color(0xFF009688);
const _kTealLight  = Color(0xFFB2DFDB);
const _kTealDark   = Color(0xFF004D40);
const _kAmber      = Color(0xFFFFC107);
const _kAmberLight = Color(0xFFFFF8E1);
const _kAmberDark  = Color(0xFFFF6F00);
const _kSurface    = Color(0xFFFAFAFA);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── 1. What is RenderObjectWidget ─────────────────────────
const _kWhatIs = 'RenderObjectWidget is an abstract Widget subclass. Unlike '
    'StatelessWidget or StatefulWidget — which compose other widgets — a '
    'RenderObjectWidget creates a RenderObject: the actual low-level node '
    'in the render tree that performs layout, painting, and hit testing. '
    'Every Container, Text, Image, and custom drawing ultimately delegates '
    'its visual work to a RenderObject created through a RenderObjectWidget.';

// ─── 2. Subclass categories ────────────────────────────────
class _Subclass {
  const _Subclass(this.name, this.description, this.examples, this.icon);
  final String name;
  final String description;
  final List<String> examples;
  final IconData icon;
}

const _kSubclasses = <_Subclass>[
  _Subclass(
    'LeafRenderObjectWidget',
    'Has zero children. Used for terminal visual nodes that paint something '
    'but do not contain other widgets. The simplest to implement.',
    ['RichText', 'RawImage', 'Texture', 'ErrorWidget', 'SizedBox (when empty)'],
    Icons.spa_outlined,
  ),
  _Subclass(
    'SingleChildRenderObjectWidget',
    'Has exactly one child widget. Used for wrappers that transform, clip, '
    'pad, or decorate a single child. The child field is managed automatically.',
    ['Padding', 'Align', 'ClipRect', 'Opacity', 'DecoratedBox', 'SizedBox (with child)'],
    Icons.filter_1_outlined,
  ),
  _Subclass(
    'MultiChildRenderObjectWidget',
    'Has a List<Widget> of children. Used for layout containers that arrange '
    'multiple children according to a layout protocol. Uses ContainerRenderObjectMixin.',
    ['Flex (Row/Column)', 'Stack', 'Wrap', 'Flow', 'RichText (with InlineSpans)'],
    Icons.grid_view_outlined,
  ),
];

// ─── 3. Lifecycle ──────────────────────────────────────────
class _LifecycleStep {
  const _LifecycleStep(this.method, this.when, this.what);
  final String method;
  final String when;
  final String what;
}

const _kLifecycleSteps = <_LifecycleStep>[
  _LifecycleStep(
    'createElement()',
    'Widget first inflated into the element tree',
    'Returns a RenderObjectElement (Leaf, SingleChild, or MultiChild variant). '
    'The framework calls this automatically — you override it by choosing the '
    'right subclass.',
  ),
  _LifecycleStep(
    'createRenderObject(context)',
    'Element mounted into the tree',
    'Creates and returns a new RenderObject, configured from the widget\'s fields. '
    'Called once per Element lifecycle. Should NOT configure children.',
  ),
  _LifecycleStep(
    'updateRenderObject(context, renderObject)',
    'Widget rebuilt with new configuration',
    'Copies changed properties from the widget to the existing RenderObject. '
    'Called on every rebuild where the widget changed. Must be idempotent.',
  ),
  _LifecycleStep(
    'didUnmountRenderObject(renderObject)',
    'Element removed from the tree permanently',
    'Cleanup callback. Releases resources (listeners, controllers, etc.) that '
    'the RenderObject holds. Not called on temporary deactivation — only on '
    'final unmount.',
  ),
];

// ─── 7. Element pairing ────────────────────────────────────
const _kElementPairs = <String, String>{
  'LeafRenderObjectWidget': 'LeafRenderObjectElement',
  'SingleChildRenderObjectWidget': 'SingleChildRenderObjectElement',
  'MultiChildRenderObjectWidget': 'MultiChildRenderObjectElement',
};

// ─── 8. Debug protocol ─────────────────────────────────────
const _kDebugSteps = <String, String>{
  'debugFillProperties':
    'Override on your RenderObject to describe configuration in DevTools. '
    'add(StringProperty("color", ...)), add(DoubleProperty("radius", ...)).',
  'debugDescribeChildren':
    'Override to describe child structure. The default is fine for single/multi '
    'child; custom layouts may want labeled children.',
  'toStringShort / toStringDeep':
    'Produce human-readable dump of the render tree. Used in error messages.',
  'debugPaintSizeEnabled':
    'Set globally to paint blue outlines around every RenderBox. Helps see '
    'layout boundaries during development.',
};

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kTealDark, _kAmberDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kTeal, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════
// CUSTOM RENDER OBJECTS
// ════════════════════════════════════════════════════════════

// ── 4. LeafRenderObjectWidget: Color swatch ────────────────
class _DemoColorSwatch extends LeafRenderObjectWidget {
  const _DemoColorSwatch({required this.hue, required this.radius});
  final double hue;
  final double radius;

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('[LeafROW] createRenderObject: hue=${hue.toStringAsFixed(0)}, radius=${radius.toStringAsFixed(0)}');
    return _RenderColorSwatch(hue: hue, radius: radius);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderColorSwatch renderObject) {
    print('[LeafROW] updateRenderObject: hue=${hue.toStringAsFixed(0)}, radius=${radius.toStringAsFixed(0)}');
    renderObject
      ..hue = hue
      ..radius = radius;
  }

  @override
  void didUnmountRenderObject(covariant _RenderColorSwatch renderObject) {
    print('[LeafROW] didUnmountRenderObject');
  }
}

class _RenderColorSwatch extends RenderBox {
  _RenderColorSwatch({required double hue, required double radius})
      : _hue = hue,
        _radius = radius;

  double _hue;
  set hue(double value) {
    if (_hue == value) return;
    _hue = value;
    markNeedsPaint();
  }

  double _radius;
  set radius(double value) {
    if (_radius == value) return;
    _radius = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final side = _radius * 2;
    size = constraints.constrain(Size(side, side));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final center = offset + Offset(size.width / 2, size.height / 2);
    final r = math.min(size.width, size.height) / 2;

    // Outer ring — 12 hue segments
    for (int i = 0; i < 12; i++) {
      final segHue = (i * 30.0 + _hue) % 360;
      final paint = Paint()..color = HSVColor.fromAHSV(1, segHue, 0.7, 0.9).toColor();
      final startAngle = i * math.pi / 6 - math.pi / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        startAngle, math.pi / 6, true, paint,
      );
    }

    // Inner circle — current hue, full saturation
    final innerPaint = Paint()..color = HSVColor.fromAHSV(1, _hue, 1, 1).toColor();
    canvas.drawCircle(center, r * 0.45, innerPaint);

    // Label
    final tp = TextPainter(
      text: TextSpan(
        text: '${_hue.toInt()}°',
        style: TextStyle(color: Colors.white, fontSize: r * 0.28, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }
}

// ── 5. SingleChildRenderObjectWidget: Rounded inset ────────
class _DemoRoundedInset extends SingleChildRenderObjectWidget {
  const _DemoRoundedInset({required this.inset, required this.borderColor, required Widget child})
      : super(child: child);
  final double inset;
  final Color borderColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('[SingleChildROW] createRenderObject: inset=${inset.toStringAsFixed(0)}');
    return _RenderRoundedInset(inset: inset, borderColor: borderColor);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderRoundedInset renderObject) {
    print('[SingleChildROW] updateRenderObject: inset=${inset.toStringAsFixed(0)}');
    renderObject
      ..inset = inset
      ..borderColor = borderColor;
  }
}

class _RenderRoundedInset extends RenderShiftedBox {
  _RenderRoundedInset({required double inset, required Color borderColor, RenderBox? child})
      : _inset = inset,
        _borderColor = borderColor,
        super(child);

  double _inset;
  set inset(double value) {
    if (_inset == value) return;
    _inset = value;
    markNeedsLayout();
  }

  Color _borderColor;
  set borderColor(Color value) {
    if (_borderColor == value) return;
    _borderColor = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final innerConstraints = constraints.deflate(EdgeInsets.all(_inset));
    child?.layout(innerConstraints, parentUsesSize: true);
    final childSize = child?.size ?? Size.zero;
    size = constraints.constrain(Size(
      childSize.width + _inset * 2,
      childSize.height + _inset * 2,
    ));
    final childParentData = child?.parentData as BoxParentData?;
    childParentData?.offset = Offset(_inset, _inset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final rrect = RRect.fromRectAndRadius(
      offset & size,
      Radius.circular(_inset * 0.6),
    );
    // Border
    context.canvas.drawRRect(rrect, Paint()
      ..color = _borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5);
    // Child
    if (child != null) {
      final childParentData = child!.parentData as BoxParentData;
      context.paintChild(child!, childParentData.offset + offset);
    }
  }
}

// ── 6. MultiChildRenderObjectWidget: Radial fan ────────────
class _DemoRadialFanParentData extends ContainerBoxParentData<RenderBox> {
  double angle = 0;
}

class _DemoRadialFan extends MultiChildRenderObjectWidget {
  const _DemoRadialFan({required this.spread, required this.fanRadius, required super.children});
  final double spread;
  final double fanRadius;

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('[MultiChildROW] createRenderObject: spread=${spread.toStringAsFixed(1)}, radius=${fanRadius.toStringAsFixed(0)}');
    return _RenderRadialFan(spread: spread, fanRadius: fanRadius);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderRadialFan renderObject) {
    print('[MultiChildROW] updateRenderObject: spread=${spread.toStringAsFixed(1)}');
    renderObject
      ..spread = spread
      ..fanRadius = fanRadius;
  }
}

class _RenderRadialFan extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _DemoRadialFanParentData>,
         RenderBoxContainerDefaultsMixin<RenderBox, _DemoRadialFanParentData> {
  _RenderRadialFan({required double spread, required double fanRadius})
      : _spread = spread,
        _fanRadius = fanRadius;

  double _spread;
  set spread(double value) {
    if (_spread == value) return;
    _spread = value;
    markNeedsLayout();
  }

  double _fanRadius;
  set fanRadius(double value) {
    if (_fanRadius == value) return;
    _fanRadius = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _DemoRadialFanParentData) {
      child.parentData = _DemoRadialFanParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.constrain(Size(_fanRadius * 2 + 60, _fanRadius * 2 + 60));
    final center = Offset(size.width / 2, size.height / 2);
    var child = firstChild;
    int index = 0;
    final count = childCount;
    while (child != null) {
      child.layout(BoxConstraints.loose(Size(40, 40)), parentUsesSize: true);
      final pd = child.parentData as _DemoRadialFanParentData;
      final fraction = count > 1 ? index / (count - 1) : 0.5;
      final angle = -_spread / 2 + fraction * _spread;
      pd.angle = angle;
      pd.offset = Offset(
        center.dx + _fanRadius * math.sin(angle) - child.size.width / 2,
        center.dy - _fanRadius * math.cos(angle) - child.size.height / 2,
      );
      child = pd.nextSibling;
      index++;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final center = offset + Offset(size.width / 2, size.height / 2);
    // Draw radial guidelines
    var child = firstChild;
    while (child != null) {
      final pd = child.parentData as _DemoRadialFanParentData;
      final childCenter = pd.offset + offset + Offset(child.size.width / 2, child.size.height / 2);
      context.canvas.drawLine(center, childCenter, Paint()
        ..color = _kTealLight
        ..strokeWidth = 1.5);
      child = pd.nextSibling;
    }
    // Paint children on top of lines
    defaultPaint(context, offset);
    // Center dot
    context.canvas.drawCircle(center, 5, Paint()..color = _kAmberDark);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _FanChild extends StatelessWidget {
  const _FanChild({required this.index, required this.color});
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 4, offset: Offset(0, 2))],
      ),
      alignment: Alignment.center,
      child: Text('${index + 1}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
    );
  }
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('RenderObjectWidget deep visual demo');
  print('─' * 48);
  print('Sections: what is it, subclasses, lifecycle, Leaf, SingleChild,');
  print('MultiChild, element pairing, debug protocol.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kTeal, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RenderObjectWidget'),
        backgroundColor: _kTealDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _Body(),
    ),
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  // Leaf demo state
  double _hue = 180;
  double _swatchRadius = 60;

  // SingleChild demo state
  double _inset = 16;

  // MultiChild demo state
  double _fanSpread = 2.0;
  double _fanRadius = 80;
  int _fanChildCount = 7;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1: What is it ──
        _sectionHeader('1 · What Is RenderObjectWidget?', Icons.widgets_outlined),
        SizedBox(height: 8),
        _card(child: Text(_kWhatIs,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('THE WIDGET→ELEMENT→RENDEROBJECT CHAIN'),
              SizedBox(height: 8),
              _mono('Widget (immutable description)'),
              _mono('  └─ createElement() → Element (mutable host)'),
              _mono('       └─ createRenderObject() → RenderObject (visual)'),
              SizedBox(height: 8),
              _bullet('Widget: declares what to render (configuration).'),
              _bullet('Element: manages the widget in the tree (lifecycle).'),
              _bullet('RenderObject: performs layout, paint, hit testing.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2: Subclasses ──
        _sectionHeader('2 · Three Subclass Categories', Icons.account_tree_outlined),
        SizedBox(height: 8),
        ..._kSubclasses.map((s) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(s.icon, color: _kTealDark, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(s.name,
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                            fontSize: 13, color: _kTealDark)),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(s.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              SizedBox(height: 8),
              _label('FRAMEWORK EXAMPLES'),
              SizedBox(height: 4),
              Wrap(
                spacing: 6, runSpacing: 4,
                children: s.examples.map((e) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _kAmberLight,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _kAmber.withOpacity(0.4)),
                  ),
                  child: Text(e,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: _kAmberDark)),
                )).toList(),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3: Lifecycle ──
        _sectionHeader('3 · Lifecycle Methods', Icons.loop),
        SizedBox(height: 8),
        ..._kLifecycleSteps.map((s) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kTealLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(s.method,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kTealDark)),
              ),
              SizedBox(height: 6),
              _label(s.when.toUpperCase()),
              SizedBox(height: 4),
              Text(s.what,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('LIFECYCLE SEQUENCE DIAGRAM'),
              SizedBox(height: 8),
              _mono('Widget first inserted:'),
              _mono('  framework → createElement() → mount()'),
              _mono('  mount() → createRenderObject(context)'),
              _mono(''),
              _mono('Widget rebuilt (same type, same key):'),
              _mono('  framework → element.update(newWidget)'),
              _mono('  update → updateRenderObject(context, renderObject)'),
              _mono(''),
              _mono('Widget removed permanently:'),
              _mono('  framework → element.unmount()'),
              _mono('  unmount → didUnmountRenderObject(renderObject)'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4: Live Leaf demo ──
        _sectionHeader('4 · Live: LeafRenderObjectWidget', Icons.spa_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This custom _DemoColorSwatch is a LeafRenderObjectWidget. It creates '
                'a _RenderColorSwatch that draws a color wheel with the selected hue '
                'highlighted in the center. Dragging the sliders calls setState(), which '
                'triggers updateRenderObject() — the RenderObject mutates in place.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              Center(
                child: _DemoColorSwatch(hue: _hue, radius: _swatchRadius),
              ),
              SizedBox(height: 12),
              _label('HUE'),
              Slider(
                value: _hue, min: 0, max: 360,
                activeColor: _kTealDark,
                onChanged: (v) => setState(() => _hue = v),
              ),
              _label('RADIUS'),
              Slider(
                value: _swatchRadius, min: 30, max: 100,
                activeColor: _kAmberDark,
                onChanged: (v) => setState(() => _swatchRadius = v),
              ),
              _mono('hue: ${_hue.toInt()}°  radius: ${_swatchRadius.toInt()}px', color: _kTextMuted),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 5: Live SingleChild demo ──
        _sectionHeader('5 · Live: SingleChildRenderObjectWidget', Icons.filter_1_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This custom _DemoRoundedInset wraps its single child with a configurable '
                'inset and draws a rounded border. Like Padding, it overrides '
                'performLayout to deflate constraints and positions the child with an '
                'offset. The border color shifts based on inset value.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              Center(
                child: _DemoRoundedInset(
                  inset: _inset,
                  borderColor: Color.lerp(_kTeal, _kAmberDark, (_inset / 40).clamp(0, 1))!,
                  child: Container(
                    width: 120, height: 80,
                    decoration: BoxDecoration(
                      color: _kTealLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text('Child',
                        style: TextStyle(fontWeight: FontWeight.w700, color: _kTealDark)),
                  ),
                ),
              ),
              SizedBox(height: 12),
              _label('INSET'),
              Slider(
                value: _inset, min: 0, max: 40,
                activeColor: _kTealDark,
                onChanged: (v) => setState(() => _inset = v),
              ),
              _mono('inset: ${_inset.toInt()}px', color: _kTextMuted),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 6: Live MultiChild demo ──
        _sectionHeader('6 · Live: MultiChildRenderObjectWidget', Icons.grid_view_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This custom _DemoRadialFan arranges children in a radial arc around a center '
                'point. Each child receives _DemoRadialFanParentData with an angle offset. '
                'The radial lines from center to each child show the layout geometry. '
                'Adjust spread, radius, and child count to see updateRenderObject in action.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              Center(
                child: _DemoRadialFan(
                  spread: _fanSpread,
                  fanRadius: _fanRadius,
                  children: List.generate(_fanChildCount, (i) => _FanChild(
                    index: i,
                    color: HSVColor.fromAHSV(
                      1, (i * 360 / _fanChildCount) % 360, 0.75, 0.85,
                    ).toColor(),
                  )),
                ),
              ),
              SizedBox(height: 12),
              _label('SPREAD (RADIANS)'),
              Slider(
                value: _fanSpread, min: 0.5, max: 5.5,
                activeColor: _kTealDark,
                onChanged: (v) => setState(() => _fanSpread = v),
              ),
              _label('FAN RADIUS'),
              Slider(
                value: _fanRadius, min: 40, max: 120,
                activeColor: _kAmberDark,
                onChanged: (v) => setState(() => _fanRadius = v),
              ),
              _label('CHILD COUNT'),
              Slider(
                value: _fanChildCount.toDouble(), min: 3, max: 12,
                divisions: 9,
                activeColor: _kTeal,
                onChanged: (v) => setState(() => _fanChildCount = v.toInt()),
              ),
              _mono('spread: ${_fanSpread.toStringAsFixed(1)} rad  '
                  'radius: ${_fanRadius.toInt()}px  '
                  'children: $_fanChildCount', color: _kTextMuted),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 7: Element pairing ──
        _sectionHeader('7 · RenderObjectElement Pairing', Icons.link),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Each RenderObjectWidget subclass is paired with a corresponding Element '
                'type. The Element manages the widget-tree position, creates/updates the '
                'RenderObject, and manages child widgets.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              ..._kElementPairs.entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _kTealLight, borderRadius: BorderRadius.circular(6)),
                        child: Text(e.key,
                            style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                                color: _kTealDark, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, size: 16, color: _kAmberDark),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _kAmberLight, borderRadius: BorderRadius.circular(6)),
                        child: Text(e.value,
                            style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                                color: _kAmberDark, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('ELEMENT RESPONSIBILITIES'),
              SizedBox(height: 8),
              _bullet('Calls createRenderObject() during mount.'),
              _bullet('Calls updateRenderObject() when widget config changes.'),
              _bullet('Manages child elements (insert, move, remove, update).'),
              _bullet('Attaches/detaches render objects to/from the render tree.'),
              _bullet('Calls didUnmountRenderObject() on permanent removal.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8: Debug ──
        _sectionHeader('8 · Debug & Diagnostics Protocol', Icons.bug_report_outlined),
        SizedBox(height: 8),
        ..._kDebugSteps.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.key,
                  style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                      fontSize: 13, color: _kAmberDark)),
              SizedBox(height: 4),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY TAKEAWAY'),
              SizedBox(height: 6),
              Text(
                'RenderObjectWidget is the workhorse of Flutter\'s rendering pipeline. '
                'Every pixel on screen is ultimately painted by a RenderObject that was '
                'created through one of the three subclass patterns. Understanding this '
                'trifecta — Leaf, SingleChild, MultiChild — and the create/update/unmount '
                'lifecycle is essential for building custom low-level widgets that go '
                'beyond the compositions offered by StatelessWidget and StatefulWidget.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
