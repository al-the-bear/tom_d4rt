// -----------------------------------------------------------------------------
// SlottedContainerRenderObjectMixin<SlotType, ChildType> — a visual study.
//
// This file is file #413 of a 4-file cluster about the slotted render-object
// stack in Flutter:
//
//   * 413 — SlottedContainerRenderObjectMixin       (this file) — RENDER side
//   * 414 — SlottedMultiChildRenderObjectWidgetMixin — WIDGET side (sibling)
//   * 415 — SlottedMultiChildRenderObjectWidget      — concrete widget
//   * 416 — SlottedRenderObjectElement               — element that wires slots
//
// STAY STRICTLY RENDER-OBJECT SIDE: every diagram, every code sample, every
// anatomical label is about what happens inside the RenderBox. The widget
// shell that you see on screen exists only so the demo can reach the render
// object; it is deliberately minimal and is never the subject of the study.
//
// The mixin is the thing that lets a custom RenderBox adopt named slots
// ("header", "body", "trailing") instead of the classical linked-list-of-
// children model that ContainerRenderObjectMixin gives you. A slotted render
// object does NOT pretend to be a list: each slot holds at most one child,
// slots are identified by a caller-defined enum-like key, and the mixin
// handles all the bookkeeping (adopting, dropping, attaching, detaching,
// visiting, describing) so the subclass only needs to implement
// performLayout / paint / hitTest over the `children` iterable.
//
// Theme: "Slot-Based Render Object Anatomy" — blueprint blue + ivory +
// red-pencil, with orthographic projections, dimension arrows, and pencil
// hatching. The intent is that a reader who has never seen this mixin can
// come away with a mental model that survives the next refactor.
//
// d4rt harness contract:
//   * top-level `dynamic build(BuildContext context)` returning a MaterialApp
//   * NO `main()`, NO `runApp()`
//   * private types prefixed `_Scrom` (Slotted Container Render Object Mixin)
//     to avoid collisions with 414/415/416 siblings
//   * no ignore directives, no analysis_options edits
// -----------------------------------------------------------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// =============================================================================
// PALETTE — kept in one place so we can tune the blueprint tone holistically.
// =============================================================================

/// The dominant blueprint blue. Used for frames, axis lines, dimension arrows
/// and body copy that must read as "ink on drafting paper".
const Color _scromBlueprint = Color(0xFF1A3A6E);

/// A softer blueprint for secondary strokes — grid lines, hatching, light
/// callouts. Kept derivable from `_scromBlueprint` rather than sampled by eye.
const Color _scromBlueprintSoft = Color(0xFF3F5E8C);

/// Ivory — the "paper". Background for panels and for the demo canvas.
const Color _scromIvory = Color(0xFFFAF6EA);

/// A slightly deeper ivory for alternating rows and subtle panel separation.
const Color _scromIvoryDeep = Color(0xFFF1EADA);

/// The red pencil: corrections, "wrong" examples, warning callouts. Used
/// sparingly — red on a blueprint is an editorial act.
const Color _scromRedPencil = Color(0xFFD64545);

/// A dimmer red for secondary warning strokes and hatching.
const Color _scromRedPencilSoft = Color(0xFFB03535);

/// Graphite — near-black ink for the heaviest annotations only.
const Color _scromGraphite = Color(0xFF1A1A1A);

// =============================================================================
// SLOT ENUM — three named slots for the concrete render-object demo.
// =============================================================================

/// Named slots for the concrete demo render object `_ScromTriptychRender`.
///
/// These are intentionally mundane — `header`, `body`, `trailing` — because
/// the purpose of the demo is the mixin machinery, not a clever layout.
enum _ScromSlot {
  /// Slot painted at the top. Optional: may be null in any given frame.
  header,

  /// Slot painted in the middle. Treated as the anchor — when present it
  /// defines the intrinsic width of the overall render object.
  body,

  /// Slot painted at the bottom. Optional: a valid triptych can omit it.
  trailing,
}

// =============================================================================
// _ScromTriptychRender — the live render-object subject.
//
// The class the entire file revolves around. Everything else — the hero,
// the panels, the diagrams — exists to explain THIS class.
//
// Responsibilities (imposed by the mixin contract):
//
//   * optionally override `children` for deterministic traversal order;
//   * implement `performLayout` — walk `children`, call `layout` with a
//     reasonable BoxConstraints, place via `parentData` (a `BoxParentData`
//     we install via `setupParentData`), and finally assign `size`;
//   * implement `paint` — iterate via `children` and call `paintChild`;
//   * implement `hitTestChildren` — forward using parent-data offset.
//
// What the mixin does FOR us:
//
//   * private `_setChild(child, slot)` — drops the old child in that slot,
//     adopts the new child, and maintains the private `_slotToChild` map;
//   * `attach` / `detach` / `redepthChildren` / `visitChildren` — by
//     walking the `children` getter;
//   * `debugDescribeChildren` — emits one diagnostic per slot with
//     `debugNameForSlot` providing a human label.
//
// We keep: `performLayout`, `paint`, `hitTestChildren`, `computeDryLayout`.
// =============================================================================

/// A RenderBox with three named slots, implemented via
/// [SlottedContainerRenderObjectMixin].
///
/// The layout algorithm is deliberately simple and readable: children are
/// stacked vertically, each given the full incoming max-width, and the box
/// sizes itself to the tight width and the sum of child heights. Missing
/// slots are skipped — they contribute neither height nor paint work.
class _ScromTriptychRender extends RenderBox
    with SlottedContainerRenderObjectMixin<_ScromSlot, RenderBox> {
  _ScromTriptychRender({double gap = 12}) : _gap = gap;

  double _gap;
  double get gap => _gap;
  set gap(double value) {
    if (value == _gap) return;
    _gap = value;
    markNeedsLayout();
  }

  /// Convenience getters onto the three logical slots. Each returns `null`
  /// when the slot is empty — the mixin's `childForSlot` returns `null`
  /// cleanly for absent slots.
  RenderBox? get headerChild => childForSlot(_ScromSlot.header);
  RenderBox? get bodyChild => childForSlot(_ScromSlot.body);
  RenderBox? get trailingChild => childForSlot(_ScromSlot.trailing);

  /// Override `children` to guarantee paint order: header -> body -> trailing.
  /// The base mixin returns `_slotToChild.values`, which is insertion-order
  /// and therefore dependent on widget construction order; we normalize.
  @override
  Iterable<RenderBox> get children sync* {
    final RenderBox? h = headerChild;
    if (h != null) yield h;
    final RenderBox? b = bodyChild;
    if (b != null) yield b;
    final RenderBox? t = trailingChild;
    if (t != null) yield t;
  }

  @override
  String debugNameForSlot(_ScromSlot slot) {
    switch (slot) {
      case _ScromSlot.header:
        return 'header';
      case _ScromSlot.body:
        return 'body';
      case _ScromSlot.trailing:
        return 'trailing';
    }
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints incoming = constraints;
    double y = 0;
    double usedWidth = 0;
    bool anyPainted = false;

    for (final RenderBox child in children) {
      final BoxConstraints childConstraints = BoxConstraints(
        maxWidth: incoming.maxWidth.isFinite ? incoming.maxWidth : 320,
      );
      child.layout(childConstraints, parentUsesSize: true);
      final BoxParentData pd = child.parentData! as BoxParentData;
      if (anyPainted) {
        y += _gap;
      }
      pd.offset = Offset(0, y);
      y += child.size.height;
      usedWidth = math.max(usedWidth, child.size.width);
      anyPainted = true;
    }

    size = incoming.constrain(Size(usedWidth, y));
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double total = 0;
    double width = 0;
    bool any = false;
    for (final RenderBox child in children) {
      final Size s = child.getDryLayout(BoxConstraints(
        maxWidth: constraints.maxWidth.isFinite ? constraints.maxWidth : 320,
      ));
      if (any) total += _gap;
      total += s.height;
      width = math.max(width, s.width);
      any = true;
    }
    return constraints.constrain(Size(width, total));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    for (final RenderBox child in children) {
      final BoxParentData pd = child.parentData! as BoxParentData;
      context.paintChild(child, pd.offset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData pd = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: pd.offset,
        position: position,
        hitTest: (BoxHitTestResult r, Offset p) {
          return child.hitTest(r, position: p);
        },
      );
      if (isHit) return true;
    }
    return false;
  }
}

// =============================================================================
// Widget shell — the MINIMUM bridge into the widget world. Uses
// SlottedMultiChildRenderObjectWidget so we don't reimplement 414/415/416.
// =============================================================================

/// A SlottedMultiChildRenderObjectWidget that forwards three optional
/// children to the three named slots of `_ScromTriptychRender`.
class _ScromTriptych extends SlottedMultiChildRenderObjectWidget<_ScromSlot, RenderBox> {
  const _ScromTriptych({
    this.header,
    this.body,
    this.trailing,
    this.gap = 12,
  });

  final Widget? header;
  final Widget? body;
  final Widget? trailing;
  final double gap;

  @override
  Iterable<_ScromSlot> get slots => const <_ScromSlot>[
        _ScromSlot.header,
        _ScromSlot.body,
        _ScromSlot.trailing,
      ];

  @override
  Widget? childForSlot(_ScromSlot slot) {
    switch (slot) {
      case _ScromSlot.header:
        return header;
      case _ScromSlot.body:
        return body;
      case _ScromSlot.trailing:
        return trailing;
    }
  }

  @override
  _ScromTriptychRender createRenderObject(BuildContext context) {
    return _ScromTriptychRender(gap: gap);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _ScromTriptychRender renderObject,
  ) {
    renderObject.gap = gap;
  }
}


// =============================================================================
// d4rt ENTRY POINT — top-level `build(BuildContext context)` returning a
// MaterialApp. No main(), no runApp(). This is the function the harness
// mounts as the widget tree.
// =============================================================================

/// The AST harness calls this and expects a widget back. We wrap the whole
/// study in a single MaterialApp with a custom Scaffold so we can theme the
/// AppBar consistently with the blueprint aesthetic.
dynamic build(BuildContext context) {
  debugPrint('[scrom] build() called — mounting SlottedContainerRenderObjectMixin study');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SlottedContainerRenderObjectMixin — blueprint anatomy',
    home: _ScromHomePage(),
  );
}

// =============================================================================
// HOME PAGE — a stateful widget that owns the scroll position and the ticker
// for the compass animation in the hero header.
// =============================================================================

class _ScromHomePage extends StatefulWidget {
  const _ScromHomePage();

  @override
  State<_ScromHomePage> createState() => _ScromHomePageState();
}

class _ScromHomePageState extends State<_ScromHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _compass;

  @override
  void initState() {
    super.initState();
    _compass = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
    debugPrint('[scrom] compass ticker started (14s period)');
  }

  @override
  void dispose() {
    _compass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scromIvory,
      appBar: AppBar(
        backgroundColor: _scromBlueprint,
        foregroundColor: _scromIvory,
        elevation: 0,
        title: const Text(
          'SlottedContainerRenderObjectMixin',
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: _scromRedPencil.withValues(alpha: 0.85),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: <Widget>[
          _ScromHero(compass: _compass),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '01',
            title: 'Anatomy at a glance',
            lead:
                'A slotted render object is a RenderBox that chooses correspondence over '
                'sequence. Each slot is a named socket; the mixin maintains the map from '
                'slot to child and adopts / drops children as the element reconciles.',
          ),
          const SizedBox(height: 14),
          const _ScromAnatomyPanel(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '02',
            title: 'Live triptych — three configurations',
            lead:
                'The same RenderBox subclass handles all three configurations below. '
                'The mixin tolerates absent slots: the `children` iterable simply omits '
                'them, and performLayout / paint / hitTest inherit that omission for free.',
          ),
          const SizedBox(height: 14),
          const _ScromLiveTriptychRow(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '03',
            title: 'Slot manifest — the quoted mixin surface',
            lead:
                'These are the four methods the mixin exposes to subclasses. Everything '
                'else (attach, detach, redepthChildren, visitChildren, debugDescribeChildren) '
                'is provided by the mixin in terms of these.',
          ),
          const SizedBox(height: 14),
          const _ScromSlotManifestPanel(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '04',
            title: 'Layout algorithm — orthographic trace',
            lead:
                'A pencil-drafted trace of performLayout walking the three slots, writing '
                'the BoxParentData.offset for each and accumulating the vertical extent.',
          ),
          const SizedBox(height: 14),
          const _ScromLayoutDiagram(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '05',
            title: 'Incorrect vs correct — list vs slot semantics',
            lead:
                'A common mistake: reaching for ContainerRenderObjectMixin and then trying '
                'to encode slot meaning into list position. The slot mixin exists so you '
                'do not have to pay that tax.',
          ),
          const SizedBox(height: 14),
          const _ScromComparePanel(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '06',
            title: 'Cross-reference — three related mixins',
            lead:
                'A quick differentiator card so future-you does not reach for the wrong '
                'tool. Stay in 413 territory: this is the render-object side.',
          ),
          const SizedBox(height: 14),
          const _ScromCrossRefPanel(),
          const SizedBox(height: 28),
          const _ScromSectionTitle(
            ordinal: '07',
            title: 'Pitfall — the mixin manages children, not layout',
            lead:
                'The mixin gives you child bookkeeping. You still owe the subclass '
                'contract: measure, position, paint, hit-test. Do not assume otherwise.',
          ),
          const SizedBox(height: 14),
          const _ScromPitfallCard(),
          const SizedBox(height: 40),
          const _ScromColophon(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// =============================================================================
// HERO — headline + compass CustomPainter.
//
// Blueprint page with a title on the left and an animated draftsman's
// compass on the right. The compass is drawn with primitive strokes (arcs,
// ticks, radial callouts) so it reads as "ink", not "widget".
// =============================================================================

class _ScromHero extends StatelessWidget {
  const _ScromHero({required this.compass});

  final AnimationController compass;

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _scromRedPencil,
                          border: Border.all(
                            color: _scromBlueprint,
                            width: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'FILE 413 / RENDER-OBJECT TIER',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.8,
                          color: _scromBlueprint.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Slot-Based\nRender Object\nAnatomy',
                    style: TextStyle(
                      fontSize: 38,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      color: _scromBlueprint,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 120,
                    height: 2,
                    color: _scromRedPencil,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'A working study of SlottedContainerRenderObjectMixin — the '
                    'mixin that lets a RenderBox hold children by name instead of '
                    'by list position. No widget-tier sleight of hand; the subject '
                    'is the render object.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: _scromGraphite.withValues(alpha: 0.82),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: const <Widget>[
                      _ScromTag(label: 'RenderBox'),
                      _ScromTag(label: 'SlotType'),
                      _ScromTag(label: 'ChildType'),
                      _ScromTag(label: 'performLayout'),
                      _ScromTag(label: 'paint'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: AnimatedBuilder(
                  animation: compass,
                  builder: (BuildContext context, Widget? _) {
                    return CustomPaint(
                      painter: _ScromCompassPainter(turn: compass.value),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Compass painter — slow rotating draftsman's compass with slot dots for
// header/body/trailing at the three cardinal positions (N, mid, S).
// -----------------------------------------------------------------------------

class _ScromCompassPainter extends CustomPainter {
  _ScromCompassPainter({required this.turn});

  /// Normalized [0..1) rotation phase.
  final double turn;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = math.min(size.width, size.height) / 2 - 10;

    // Paper background.
    final Paint bg = Paint()..color = _scromIvoryDeep;
    canvas.drawRect(Offset.zero & size, bg);

    // Outer frame.
    final Paint frame = Paint()
      ..color = _scromBlueprint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      frame,
    );

    // Grid.
    final Paint grid = Paint()
      ..color = _scromBlueprintSoft.withValues(alpha: 0.18)
      ..strokeWidth = 0.5;
    const double step = 14;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Concentric compass rings.
    final Paint ring = Paint()
      ..color = _scromBlueprint.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, r, ring);
    canvas.drawCircle(center, r * 0.72, ring);
    canvas.drawCircle(center, r * 0.42, ring);

    // Rotating tick marks (24).
    final double angle = turn * 2 * math.pi;
    for (int i = 0; i < 24; i++) {
      final double a = angle + (i / 24) * 2 * math.pi;
      final bool heavy = i % 6 == 0;
      final double inner = r * (heavy ? 0.78 : 0.88);
      final double outer = r * 0.98;
      final Paint tick = Paint()
        ..color = heavy
            ? _scromBlueprint
            : _scromBlueprint.withValues(alpha: 0.45)
        ..strokeWidth = heavy ? 1.6 : 0.8;
      canvas.drawLine(
        center + Offset(math.cos(a) * inner, math.sin(a) * inner),
        center + Offset(math.cos(a) * outer, math.sin(a) * outer),
        tick,
      );
    }

    // Slot markers: three dots at 270deg (N), 30deg, 150deg relative to
    // unrotated frame, but rotated with the compass so they feel attached.
    final List<(String label, double deg)> slots = <(String, double)>[
      ('header', -math.pi / 2),
      ('body', math.pi / 6),
      ('trailing', 5 * math.pi / 6),
    ];
    for (final (String label, double a0) in slots) {
      final double a = a0 + angle * 0.25;
      final Offset pos = center + Offset(math.cos(a) * r * 0.58, math.sin(a) * r * 0.58);
      final Paint dot = Paint()..color = _scromRedPencil;
      canvas.drawCircle(pos, 5, dot);
      canvas.drawCircle(
        pos,
        5,
        Paint()
          ..color = _scromBlueprint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: _scromBlueprint.withValues(alpha: 0.88),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos + Offset(8, -4));
    }

    // Central hub — the "render object" symbol.
    final Paint hubFill = Paint()..color = _scromIvory;
    canvas.drawCircle(center, 14, hubFill);
    canvas.drawCircle(
      center,
      14,
      Paint()
        ..color = _scromBlueprint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
    final TextPainter hub = TextPainter(
      text: const TextSpan(
        text: 'RO',
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w800,
          color: _scromBlueprint,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    hub.paint(canvas, center - Offset(hub.width / 2, hub.height / 2));

    // Bottom caption.
    final TextPainter caption = TextPainter(
      text: TextSpan(
        text: 'SLOT COMPASS — ${(turn * 360).toStringAsFixed(0)}°',
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: _scromBlueprint.withValues(alpha: 0.7),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    caption.paint(canvas, Offset(8, size.height - caption.height - 6));
  }

  @override
  bool shouldRepaint(covariant _ScromCompassPainter old) => old.turn != turn;
}

// =============================================================================
// _ScromPaper — the shared "drafting paper" panel wrapper: ivory field,
// blueprint border, 1px red-pencil top stripe.
// =============================================================================

class _ScromPaper extends StatelessWidget {
  const _ScromPaper({required this.child, this.deep = false});

  final Widget child;
  final bool deep;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: deep ? _scromIvoryDeep : _scromIvory,
        border: Border.all(color: _scromBlueprint, width: 1.3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _scromBlueprint.withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(height: 3, color: _scromRedPencil.withValues(alpha: 0.85)),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// _ScromTag — small pill-shaped label used in the hero.
// =============================================================================

class _ScromTag extends StatelessWidget {
  const _ScromTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _scromBlueprint.withValues(alpha: 0.08),
        border: Border.all(
          color: _scromBlueprint.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          color: _scromBlueprint.withValues(alpha: 0.92),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// =============================================================================
// _ScromSectionTitle — ordinal + title + lead paragraph.
// =============================================================================

class _ScromSectionTitle extends StatelessWidget {
  const _ScromSectionTitle({
    required this.ordinal,
    required this.title,
    required this.lead,
  });

  final String ordinal;
  final String title;
  final String lead;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 56,
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ordinal,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  height: 0.9,
                  color: _scromRedPencil.withValues(alpha: 0.88),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 36,
                height: 2,
                color: _scromBlueprint,
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _scromBlueprint,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                lead,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: _scromGraphite.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// _ScromAnatomyPanel — dense overview: a labeled schematic of the render
// object and a table of the five methods the mixin provides.
// =============================================================================

class _ScromAnatomyPanel extends StatelessWidget {
  const _ScromAnatomyPanel();

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 320,
                child: CustomPaint(
                  painter: _ScromAnatomyPainter(),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  _ScromAnatomyRow(
                    left: 'attach(owner)',
                    right:
                        'iterates `children`, calls `child.attach(owner)` so '
                        'each slot is hooked to the pipeline.',
                  ),
                  _ScromAnatomyRow(
                    left: 'detach()',
                    right:
                        'mirror of attach — each child is disconnected from '
                        'the pipeline in iteration order.',
                  ),
                  _ScromAnatomyRow(
                    left: 'redepthChildren()',
                    right:
                        'calls `redepthChild` for each entry; keeps depth '
                        'invariants intact after reparenting.',
                  ),
                  _ScromAnatomyRow(
                    left: 'visitChildren(v)',
                    right:
                        'forwards to each child in `children` order. The '
                        'inspector and semantics walk both ride on this.',
                  ),
                  _ScromAnatomyRow(
                    left: 'debugDescribeChildren()',
                    right:
                        'emits one DiagnosticsNode per slot, labeled with '
                        '`debugNameForSlot(slot)`.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScromAnatomyRow extends StatelessWidget {
  const _ScromAnatomyRow({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              left,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: _scromBlueprint,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              right,
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                color: _scromGraphite.withValues(alpha: 0.82),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScromAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paper.
    canvas.drawRect(Offset.zero & size, Paint()..color = _scromIvoryDeep);

    // Outer frame — the render object body.
    final Rect body = Rect.fromLTWH(30, 30, size.width - 60, size.height - 60);
    final Paint stroke = Paint()
      ..color = _scromBlueprint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(body, stroke);

    // Three slot sockets, stacked vertically inside the body.
    final double slotH = (body.height - 30) / 3;
    final List<String> names = <String>['header', 'body', 'trailing'];
    for (int i = 0; i < 3; i++) {
      final Rect slot = Rect.fromLTWH(
        body.left + 14,
        body.top + 10 + i * (slotH + 5),
        body.width - 90,
        slotH - 5,
      );
      // Hatching.
      final Paint hatch = Paint()
        ..color = _scromBlueprintSoft.withValues(alpha: 0.18)
        ..strokeWidth = 0.6;
      for (double x = slot.left; x < slot.right + slot.height; x += 6) {
        canvas.drawLine(
          Offset(x, slot.top),
          Offset(x - slot.height, slot.bottom),
          hatch,
        );
      }
      // Border.
      final Paint slotStroke = Paint()
        ..color = _scromBlueprint.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawRect(slot, slotStroke);
      // Name.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'SLOT :: ${names[i].toUpperCase()}',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: _scromBlueprint,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(slot.left + 8, slot.top + 6));
      // Callout from slot to right side of the paper.
      final Offset from = Offset(slot.right, slot.center.dy);
      final Offset to = Offset(body.right - 8, slot.center.dy);
      final Paint callout = Paint()
        ..color = _scromRedPencil
        ..strokeWidth = 1.2;
      canvas.drawLine(from, to, callout);
      // Arrow head.
      canvas.drawLine(to, to + const Offset(-6, -4), callout);
      canvas.drawLine(to, to + const Offset(-6, 4), callout);
      // Right margin label.
      final TextPainter label = TextPainter(
        text: TextSpan(
          text: 'childForSlot(${names[i]})',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: _scromRedPencilSoft,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, Offset(body.right + 4, slot.center.dy - label.height / 2));
    }

    // Top banner label.
    final TextPainter title = TextPainter(
      text: TextSpan(
        text: 'RenderBox with SlottedContainerRenderObjectMixin<_ScromSlot, RenderBox>',
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          color: _scromBlueprint,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    title.paint(canvas, Offset(body.left, body.top - 18));

    // Dimension arrows beneath the body.
    final double dy = size.height - 18;
    final Paint dim = Paint()
      ..color = _scromBlueprint
      ..strokeWidth = 1;
    canvas.drawLine(Offset(body.left, dy), Offset(body.right, dy), dim);
    canvas.drawLine(Offset(body.left, dy - 4), Offset(body.left, dy + 4), dim);
    canvas.drawLine(Offset(body.right, dy - 4), Offset(body.right, dy + 4), dim);
    final TextPainter dimLabel = TextPainter(
      text: TextSpan(
        text: 'size.width = incoming.constrain(maxChildWidth)',
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'monospace',
          color: _scromBlueprint.withValues(alpha: 0.78),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    dimLabel.paint(
      canvas,
      Offset(body.center.dx - dimLabel.width / 2, dy + 4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// _ScromLiveTriptychRow — three live _ScromTriptych widgets side by side:
// (A) header + body, (B) body only, (C) header + body + trailing.
// Each is framed in an ivory paper card with its configuration label.
// =============================================================================

class _ScromLiveTriptychRow extends StatelessWidget {
  const _ScromLiveTriptychRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _ScromTriptychCase(
            label: 'A · header + body',
            note: 'trailing slot is null; `children` yields 2 items.',
            child: _ScromTriptych(
              header: _ScromSlotBlock(
                title: 'HEADER',
                subtitle: 'top slot',
                color: _scromBlueprint,
              ),
              body: _ScromSlotBlock(
                title: 'BODY',
                subtitle: 'anchor slot',
                color: _scromBlueprintSoft,
                tall: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _ScromTriptychCase(
            label: 'B · body only',
            note: 'both optional slots null; `children` yields 1 item.',
            child: _ScromTriptych(
              gap: 10,
              body: _ScromSlotBlock(
                title: 'BODY',
                subtitle: 'standalone',
                color: _scromBlueprintSoft,
                tall: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _ScromTriptychCase(
            label: 'C · all three',
            note: 'every slot occupied; `children` yields 3 items.',
            child: _ScromTriptych(
              header: _ScromSlotBlock(
                title: 'HEADER',
                subtitle: 'top slot',
                color: _scromBlueprint,
              ),
              body: _ScromSlotBlock(
                title: 'BODY',
                subtitle: 'anchor slot',
                color: _scromBlueprintSoft,
              ),
              trailing: _ScromSlotBlock(
                title: 'TRAILING',
                subtitle: 'bottom slot',
                color: _scromRedPencilSoft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScromTriptychCase extends StatelessWidget {
  const _ScromTriptychCase({
    required this.label,
    required this.note,
    required this.child,
  });

  final String label;
  final String note;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      deep: true,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: _scromBlueprint,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              note,
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: _scromGraphite.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _scromIvory,
                border: Border.all(
                  color: _scromBlueprint.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScromSlotBlock extends StatelessWidget {
  const _ScromSlotBlock({
    required this.title,
    required this.subtitle,
    required this.color,
    this.tall = false,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool tall;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: tall ? 20 : 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: _scromGraphite.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// _ScromSlotManifestPanel — quoted code of the core mixin API with pencil
// annotations to the right of each line block.
// =============================================================================

class _ScromSlotManifestPanel extends StatelessWidget {
  const _ScromSlotManifestPanel();

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _ScromManifestEntry(
              signature: '@protected\nChildType? childForSlot(SlotType slot);',
              annotation:
                  'Primary getter. Returns the current child in `slot`, or null. '
                  'Subclasses use this to expose named accessors like '
                  '`headerChild => childForSlot(_ScromSlot.header)`.',
              tint: _scromBlueprint,
            ),
            SizedBox(height: 10),
            _ScromManifestEntry(
              signature: '@protected\nIterable<ChildType> get children;',
              annotation:
                  'The traversal order. The default is `_slotToChild.values` — '
                  'insertion order. Override it when paint / hit-test order must '
                  'be deterministic (header, body, trailing in our case).',
              tint: _scromBlueprintSoft,
            ),
            SizedBox(height: 10),
            _ScromManifestEntry(
              signature: '@protected\nString debugNameForSlot(SlotType slot);',
              annotation:
                  'Humanizes diagnostic output. Default falls back to '
                  '`Enum.name` or `toString()`. Override for custom SlotType '
                  'objects or to alias cryptic enum names.',
              tint: _scromRedPencilSoft,
            ),
            SizedBox(height: 10),
            _ScromManifestEntry(
              signature:
                  '// private, driven by the element\nvoid _setChild(ChildType? child, SlotType slot);',
              annotation:
                  'Internal — the element calls this via the widget mixin when it '
                  'inserts / removes / moves a child in a slot. It drops the '
                  'old child, then adopts the new one. You do NOT call it '
                  'directly.',
              tint: _scromRedPencil,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScromManifestEntry extends StatelessWidget {
  const _ScromManifestEntry({
    required this.signature,
    required this.annotation,
    required this.tint,
  });

  final String signature;
  final String annotation;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _scromIvoryDeep,
        border: Border(
          left: BorderSide(color: tint, width: 4),
          top: BorderSide(color: _scromBlueprint.withValues(alpha: 0.25)),
          right: BorderSide(color: _scromBlueprint.withValues(alpha: 0.25)),
          bottom: BorderSide(color: _scromBlueprint.withValues(alpha: 0.25)),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: SelectableText(
              signature,
              style: TextStyle(
                fontSize: 12.5,
                fontFamily: 'monospace',
                height: 1.45,
                color: _scromBlueprint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 6,
            child: Text(
              annotation,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: _scromGraphite.withValues(alpha: 0.84),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// _ScromLayoutDiagram — orthographic trace of performLayout.
//
// A drafting view of the render object from the side: incoming constraints
// on the left, the body of the box in the middle, the three slot frames
// stacked with dimension arrows, and annotations on the right explaining
// what performLayout does at each step.
// =============================================================================

class _ScromLayoutDiagram extends StatelessWidget {
  const _ScromLayoutDiagram();

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: 420,
          child: CustomPaint(
            painter: _ScromLayoutPainter(),
          ),
        ),
      ),
    );
  }
}

class _ScromLayoutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paper grid.
    final Paint grid = Paint()
      ..color = _scromBlueprintSoft.withValues(alpha: 0.12)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Box frame.
    final Rect box = Rect.fromLTWH(140, 40, 260, size.height - 90);
    final Paint boxStroke = Paint()
      ..color = _scromBlueprint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(box, boxStroke);

    // Three slot rectangles inside.
    final List<({String name, double fraction})> slots = <({String name, double fraction})>[
      (name: 'header', fraction: 0.18),
      (name: 'body', fraction: 0.52),
      (name: 'trailing', fraction: 0.25),
    ];

    const double pad = 10;
    final double usable = box.height - pad * 2 - 2 * 8;
    double y = box.top + pad;

    for (int i = 0; i < slots.length; i++) {
      final double h = usable * slots[i].fraction;
      final Rect slot = Rect.fromLTWH(
        box.left + 14,
        y,
        box.width - 28,
        h,
      );
      // Fill with pencil hatching.
      final Paint hatch = Paint()
        ..color = _scromBlueprintSoft.withValues(alpha: 0.14)
        ..strokeWidth = 0.6;
      for (double hx = slot.left; hx < slot.right + slot.height; hx += 7) {
        canvas.drawLine(
          Offset(hx, slot.top),
          Offset(hx - slot.height, slot.bottom),
          hatch,
        );
      }
      canvas.drawRect(
        slot,
        Paint()
          ..color = _scromBlueprint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1,
      );

      // Slot label inside.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: slots[i].name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: _scromBlueprint,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(slot.left + 8, slot.top + 6));

      // parentData.offset callout from upper-left corner.
      final Paint ink = Paint()
        ..color = _scromRedPencil
        ..strokeWidth = 1.2;
      final Offset from = slot.topLeft;
      final Offset to = Offset(box.right + 24, slot.top + 8);
      canvas.drawLine(from, Offset(from.dx - 20, from.dy), ink);
      canvas.drawLine(
        Offset(from.dx - 20, from.dy),
        Offset(from.dx - 20, to.dy),
        ink,
      );
      canvas.drawLine(
        Offset(from.dx - 20, to.dy),
        to,
        ink,
      );
      canvas.drawLine(to, to + const Offset(-6, -4), ink);
      canvas.drawLine(to, to + const Offset(-6, 4), ink);

      final TextPainter anno = TextPainter(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: 'parentData.offset = Offset(0, ',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _scromBlueprint.withValues(alpha: 0.85),
              ),
            ),
            TextSpan(
              text: (slot.top - box.top - pad).toStringAsFixed(0),
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: _scromRedPencilSoft,
              ),
            ),
            TextSpan(
              text: ')',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _scromBlueprint.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      anno.paint(canvas, to + const Offset(6, -6));

      // Vertical dimension arrow on the left side of the slot.
      final Paint dim = Paint()
        ..color = _scromBlueprint.withValues(alpha: 0.75)
        ..strokeWidth = 0.9;
      final double dx = box.left - 18;
      canvas.drawLine(Offset(dx, slot.top), Offset(dx, slot.bottom), dim);
      canvas.drawLine(Offset(dx - 3, slot.top), Offset(dx + 3, slot.top), dim);
      canvas.drawLine(
        Offset(dx - 3, slot.bottom),
        Offset(dx + 3, slot.bottom),
        dim,
      );
      final TextPainter dimTp = TextPainter(
        text: TextSpan(
          text: '${h.toStringAsFixed(0)}px',
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'monospace',
            color: _scromBlueprint.withValues(alpha: 0.8),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      canvas.save();
      canvas.translate(dx - 6, slot.center.dy + dimTp.width / 2);
      canvas.rotate(-math.pi / 2);
      dimTp.paint(canvas, Offset.zero);
      canvas.restore();

      y = slot.bottom + 8;
    }

    // Incoming constraints label at the top-left.
    final TextPainter cons = TextPainter(
      text: TextSpan(
        text: 'constraints.maxWidth',
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          color: _scromBlueprint,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    cons.paint(canvas, Offset(box.left, box.top - 22));
    final Paint consArrow = Paint()
      ..color = _scromBlueprint
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(box.left, box.top - 6),
      Offset(box.right, box.top - 6),
      consArrow,
    );
    canvas.drawLine(
      Offset(box.right, box.top - 6),
      Offset(box.right - 6, box.top - 10),
      consArrow,
    );
    canvas.drawLine(
      Offset(box.right, box.top - 6),
      Offset(box.right - 6, box.top - 2),
      consArrow,
    );

    // Bottom legend.
    final TextPainter legend = TextPainter(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'performLayout() ',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              color: _scromBlueprint,
            ),
          ),
          TextSpan(
            text:
                '— iterate `children`, layout(child, childConstraints, parentUsesSize: true), write parentData.offset, accumulate size.',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: _scromBlueprint.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 20);
    legend.paint(canvas, Offset(10, size.height - legend.height - 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// _ScromComparePanel — side-by-side "incorrect vs correct" example.
//
// Left: a pretend ContainerRenderObjectMixin usage where the implementer has
// tried to encode slot semantics by list position ("index 0 is header, index
// 1 is body"). Right: the same thing done with the slot mixin. The red
// pencil annotations call out why the left approach is fragile.
// =============================================================================

class _ScromComparePanel extends StatelessWidget {
  const _ScromComparePanel();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Expanded(
          child: _ScromCompareCard(
            tone: _ScromCompareTone.wrong,
            title: 'DON\'T · list semantics pretending to be slot semantics',
            code: 'class BadTriptych extends RenderBox\n'
                '    with ContainerRenderObjectMixin<RenderBox, _Pd>,\n'
                '         RenderBoxContainerDefaultsMixin<RenderBox, _Pd> {\n'
                '  // Implementer convention: firstChild = header,\n'
                '  //                         firstChild.next = body,\n'
                '  //                         firstChild.next.next = trailing.\n'
                '\n'
                '  @override\n'
                '  void performLayout() {\n'
                '    final RenderBox? header = firstChild;\n'
                '    final RenderBox? body = header?.nextSibling;\n'
                '    final RenderBox? trailing = body?.nextSibling;\n'
                '    // ... breaks if a slot is absent or reordered.\n'
                '  }\n'
                '}',
            notes: <String>[
              'Absent slot? The list shifts. `body` silently becomes your header.',
              'Reordered by the parent widget? Your `firstChild.next` points at the wrong thing.',
              'Diagnostics label the children "[0], [1], [2]" with no semantic meaning.',
              'You invent an ad-hoc convention the element layer has no contract with.',
            ],
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: _ScromCompareCard(
            tone: _ScromCompareTone.right,
            title: 'DO · name the slots; let the mixin own the map',
            code: 'class GoodTriptych extends RenderBox\n'
                '    with SlottedContainerRenderObjectMixin<_ScromSlot, RenderBox> {\n'
                '  RenderBox? get headerChild   => childForSlot(_ScromSlot.header);\n'
                '  RenderBox? get bodyChild     => childForSlot(_ScromSlot.body);\n'
                '  RenderBox? get trailingChild => childForSlot(_ScromSlot.trailing);\n'
                '\n'
                '  @override\n'
                '  Iterable<RenderBox> get children sync* {\n'
                '    final h = headerChild;   if (h != null) yield h;\n'
                '    final b = bodyChild;     if (b != null) yield b;\n'
                '    final t = trailingChild; if (t != null) yield t;\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  void performLayout() {\n'
                '    for (final child in children) {\n'
                '      child.layout(childConstraints, parentUsesSize: true);\n'
                '      (child.parentData as BoxParentData).offset = ...;\n'
                '    }\n'
                '  }\n'
                '}',
            notes: <String>[
              'Absent slot? `children` just omits it; nothing to rewrite.',
              'Widget reordering is irrelevant — slot identity is an enum, not a position.',
              'Diagnostics read "header", "body", "trailing" via debugNameForSlot.',
              'The element layer has a typed slot contract to coordinate with.',
            ],
          ),
        ),
      ],
    );
  }
}

enum _ScromCompareTone { wrong, right }

class _ScromCompareCard extends StatelessWidget {
  const _ScromCompareCard({
    required this.tone,
    required this.title,
    required this.code,
    required this.notes,
  });

  final _ScromCompareTone tone;
  final String title;
  final String code;
  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    final Color accent =
        tone == _ScromCompareTone.wrong ? _scromRedPencil : _scromBlueprint;
    final String bang =
        tone == _ScromCompareTone.wrong ? '×' : '✓';
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    bang,
                    style: const TextStyle(
                      color: _scromIvory,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: accent,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _scromIvoryDeep,
                border: Border.all(
                  color: accent.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
              child: SelectableText(
                code,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  height: 1.4,
                  color: _scromBlueprint,
                ),
              ),
            ),
            const SizedBox(height: 12),
            for (final String n in notes)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      width: 6,
                      height: 6,
                      color: accent,
                    ),
                    Expanded(
                      child: Text(
                        n,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.45,
                          color: _scromGraphite.withValues(alpha: 0.82),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// _ScromCrossRefPanel — three-card reference to the siblings: Container*,
// MultiChild* and the present mixin.
// =============================================================================

class _ScromCrossRefPanel extends StatelessWidget {
  const _ScromCrossRefPanel();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Expanded(
          child: _ScromRefCard(
            name: 'ContainerRenderObjectMixin',
            tag: 'LIST',
            summary:
                'A doubly-linked list of children with ContainerParentDataMixin-typed '
                'parentData. First/last pointers, next/prev siblings. Great for Row, '
                'Column, Flow, Wrap — anywhere children are homogeneous and sequential.',
            when: 'Use when children are interchangeable and indexed by position.',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ScromRefCard(
            name: 'SlottedContainerRenderObjectMixin',
            tag: 'SLOT · this file',
            summary:
                'A typed map from SlotType to ChildType. Each slot holds at most one '
                'child. Slot identity is preserved across rebuilds. Provides attach, '
                'detach, visit, diagnostics — subclass implements layout / paint / hitTest.',
            when: 'Use when children play different roles: header, body, trailing, etc.',
            accent: true,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ScromRefCard(
            name: 'RenderObjectWithChildMixin',
            tag: 'SINGLE',
            summary:
                'Single-child adapter. Exposes `child` getter/setter, adopts and drops '
                'automatically. RenderBoxContainerDefaultsMixin is unnecessary here — '
                'hit-test, paint and layout are typically trivial.',
            when: 'Use when the render object has exactly one child.',
          ),
        ),
      ],
    );
  }
}

class _ScromRefCard extends StatelessWidget {
  const _ScromRefCard({
    required this.name,
    required this.tag,
    required this.summary,
    required this.when,
    this.accent = false,
  });

  final String name;
  final String tag;
  final String summary;
  final String when;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final Color border =
        accent ? _scromRedPencil : _scromBlueprint.withValues(alpha: 0.7);
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: border.withValues(alpha: 0.12),
                border: Border.all(color: border, width: 1),
              ),
              child: Text(
                tag,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: border,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: _scromBlueprint,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              summary,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: _scromGraphite.withValues(alpha: 0.82),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              color: _scromIvoryDeep,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'WHEN · ',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: _scromRedPencilSoft,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      when,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.45,
                        color: _scromBlueprint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// _ScromPitfallCard — single red-bordered card. The mixin does child
// bookkeeping only; you still implement the whole measure/paint/hitTest
// contract.
// =============================================================================

class _ScromPitfallCard extends StatelessWidget {
  const _ScromPitfallCard();

  @override
  Widget build(BuildContext context) {
    return _ScromPaper(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _scromRedPencil,
                border: Border.all(color: _scromBlueprint, width: 1.5),
              ),
              child: const Text(
                '!',
                style: TextStyle(
                  color: _scromIvory,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'The mixin manages children. It does not manage LAYOUT.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _scromRedPencil,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'SlottedContainerRenderObjectMixin adopts, drops, attaches, detaches, '
                    'visits and describes children. That is the entire surface. You are '
                    'still responsible for:',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: _scromGraphite.withValues(alpha: 0.88),
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final String b in const <String>[
                    'setupParentData(child) — install the BoxParentData your layout writes to.',
                    'performLayout() — call layout() on every child and assign size.',
                    'computeDryLayout(constraints) — mirror of performLayout without mutation.',
                    'paint(context, offset) — iterate and forward to paintChild.',
                    'hitTestChildren(result, position) — forward via parent-data offset.',
                    'intrinsic metrics (computeMinIntrinsicWidth etc.) when the tree asks.',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 7, right: 10),
                            width: 6,
                            height: 6,
                            color: _scromRedPencil,
                          ),
                          Expanded(
                            child: Text(
                              b,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.5,
                                fontFamily: 'monospace',
                                color: _scromBlueprint,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    'Forgetting any of these gives you a render object that "works" until '
                    'the first time something asks it a question it has no answer to — '
                    'then you get a silent no-op or an assertion deep in the framework.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.55,
                      color: _scromGraphite.withValues(alpha: 0.78),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// _ScromColophon — closing stamp.
// =============================================================================

class _ScromColophon extends StatelessWidget {
  const _ScromColophon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _scromBlueprint,
        border: Border.all(color: _scromBlueprint, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            color: _scromRedPencil,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'FILE 413 · SlottedContainerRenderObjectMixin — render-object tier only. '
              'For the widget, element and concrete widget counterparts see files 414, '
              '415 and 416 respectively. Theme: blueprint blue / ivory / red-pencil.',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _scromIvory.withValues(alpha: 0.92),
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '— drafted by hand',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: _scromIvory.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// End of file 413.
// -----------------------------------------------------------------------------
