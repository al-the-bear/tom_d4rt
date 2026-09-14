// Deep visual demo — SelectionContainerDelegate "Delegate Dissection".
//
// Scene C approach note:
//   SelectionContainerDelegate is abstract and has a large surface
//   (SelectionHandler + SelectionRegistrar: add/remove selectables,
//   pushHandleLayers, dispatchSelectionEvent, getSelectedContent,
//   getSelection, contentLength, value, plus ValueListenable machinery).
//   A full hand-rolled subclass that actually coordinates selectables would
//   be hundreds of lines and easy to desynchronize, so this demo pivots the
//   "custom delegate" scene to composition + a _DelegateSpy that subscribes
//   to SelectionArea.onSelectionChanged and logs every selection-change
//   signal surfaced at the delegate boundary. A pedagogical table explains
//   what a real subclass would have to wire up.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — midnight + cyan + peach.
// ---------------------------------------------------------------------------

const Color _kMidnight = Color(0xFF0B1120);
const Color _kMidnightPanel = Color(0xFF111A2C);
const Color _kMidnightDeep = Color(0xFF060A14);
const Color _kCyan = Color(0xFF22D3EE);
const Color _kCyanSoft = Color(0xFF67E8F9);
const Color _kCyanDeep = Color(0xFF0891B2);
const Color _kPeach = Color(0xFFFED7AA);
const Color _kPeachSoft = Color(0xFFFFEDD5);
const Color _kPeachDeep = Color(0xFFFDBA74);
const Color _kInk = Color(0xFFE2E8F0);
const Color _kInkDim = Color(0xFF94A3B8);
const Color _kGridLine = Color(0xFF1E293B);
const Color _kDanger = Color(0xFFF87171);
const Color _kSuccess = Color(0xFF4ADE80);

// ---------------------------------------------------------------------------
// Shared utility text styles used across scenes.
// ---------------------------------------------------------------------------

const TextStyle _kTitleStyle = TextStyle(
  color: _kCyan,
  fontWeight: FontWeight.w700,
  fontSize: 22,
  letterSpacing: 0.4,
);

const TextStyle _kSectionStyle = TextStyle(
  color: _kCyanSoft,
  fontWeight: FontWeight.w600,
  fontSize: 15,
  letterSpacing: 0.6,
);

const TextStyle _kLabelStyle = TextStyle(
  color: _kPeach,
  fontWeight: FontWeight.w600,
  fontSize: 13,
);

const TextStyle _kBodyStyle = TextStyle(
  color: _kInk,
  fontSize: 13,
  height: 1.42,
);

const TextStyle _kMonoStyle = TextStyle(
  color: _kPeachSoft,
  fontFamily: 'monospace',
  fontSize: 12,
  height: 1.4,
);

const TextStyle _kDimStyle = TextStyle(
  color: _kInkDim,
  fontSize: 11,
  height: 1.4,
);

// ===========================================================================
// ENTRY POINT for d4rt AST harness.
// ===========================================================================

dynamic build(BuildContext context) {
  return const _SelectionDelegateDemoApp();
}

class _SelectionDelegateDemoApp extends StatelessWidget {
  const _SelectionDelegateDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SelectionContainerDelegate — Delegate Dissection',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kMidnight,
        canvasColor: _kMidnight,
        fontFamily: 'Roboto',
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _kCyan,
          selectionColor: Color(0x5522D3EE),
          selectionHandleColor: _kCyan,
        ),
        dividerTheme: const DividerThemeData(
          color: _kGridLine,
          thickness: 1,
        ),
        colorScheme: const ColorScheme.dark(
          surface: _kMidnightPanel,
          primary: _kCyan,
          secondary: _kPeach,
          onPrimary: _kMidnight,
          onSecondary: _kMidnight,
          onSurface: _kInk,
        ),
      ),
      home: const _DelegateDemoHome(),
    );
  }
}

// ===========================================================================
// HOME — wires up the sections, the event log, and manages spy state.
// ===========================================================================

class _DelegateDemoHome extends StatefulWidget {
  const _DelegateDemoHome();

  @override
  State<_DelegateDemoHome> createState() => _DelegateDemoHomeState();
}

class _DelegateDemoHomeState extends State<_DelegateDemoHome> {
  final _DelegateSpy _spy = _DelegateSpy();

  @override
  void initState() {
    super.initState();
    _spy.record(
      _DelegateSpyEventKind.info,
      'boot',
      'Delegate Dissection initialized — listening for selection events.',
    );
    _spy.record(
      _DelegateSpyEventKind.info,
      'boot',
      'Tip: drag across the different scenes to compare outputs.',
    );
  }

  @override
  void dispose() {
    _spy.dispose();
    super.dispose();
  }

  void _emitManualPulse() {
    _spy.record(
      _DelegateSpyEventKind.manual,
      'manual.pulse',
      'Manual pulse emitted at ${DateTime.now().toIso8601String()}',
    );
  }

  void _emitManualClear() {
    _spy.record(
      _DelegateSpyEventKind.manual,
      'manual.clear',
      'Manual clear pulse — simulates ClearSelectionEvent dispatch.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kMidnight,
      appBar: _buildAppBar(),
      body: SelectionArea(
        onSelectionChanged: (content) {
          _spy.record(
            _DelegateSpyEventKind.outerArea,
            'onSelectionChanged',
            content == null
                ? 'selection cleared (null SelectedContent)'
                : 'len=${content.plainText.length} preview="${_spy.preview(content.plainText)}"',
          );
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          children: <Widget>[
            const _DemoIntroCard(),
            const SizedBox(height: 20),
            _DelegateFlowHero(spy: _spy),
            const SizedBox(height: 20),
            _PassThroughScene(spy: _spy),
            const SizedBox(height: 20),
            _AggregatingScene(spy: _spy),
            const SizedBox(height: 20),
            _LoggingDelegateScene(
              spy: _spy,
              onManualPulse: _emitManualPulse,
              onManualClear: _emitManualClear,
            ),
            const SizedBox(height: 20),
            const _OwnershipTable(),
            const SizedBox(height: 20),
            const _WhenToBuildCard(),
            const SizedBox(height: 20),
            const _GotchasCard(),
            const SizedBox(height: 20),
            _EventLogCard(spy: _spy),
            const SizedBox(height: 24),
            const _FooterNote(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _kMidnightDeep,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: _kCyan,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'SelectionContainerDelegate · Delegate Dissection',
            style: TextStyle(
              color: _kCyan,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kMidnightPanel,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kGridLine),
            ),
            child: const Text(
              'flutter 3.41.6',
              style: TextStyle(color: _kPeach, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// INTRO CARD
// ===========================================================================

class _DemoIntroCard extends StatelessWidget {
  const _DemoIntroCard();

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kCyan,
      title: 'About this demo',
      subtitle:
          'SelectionContainerDelegate is the seam where SelectionContainer '
          'collects selectables, geometrizes selection, and dispatches events.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Below you see three instructive use cases plus a pedagogical '
            'flow-chart of the delegate callback surface. Drag across any of '
            'the paragraphs; the event log at the bottom records signals that '
            'bubble up from the delegate boundary.',
            style: _kBodyStyle,
          ),
          SizedBox(height: 12),
          Text(
            'Scenes',
            style: _kSectionStyle,
          ),
          SizedBox(height: 6),
          _BulletRow(
            bullet: 'A',
            text:
                'SelectionContainer.disabled — a pass-through that makes a '
                'subtree opt out of the ambient SelectionArea.',
          ),
          _BulletRow(
            bullet: 'B',
            text:
                'Aggregating — nested SelectionArea aggregates selection '
                'across a multi-column layout into a single geometry.',
          ),
          _BulletRow(
            bullet: 'C',
            text:
                'Logging — a _DelegateSpy decorator that observes every '
                'onSelectionChanged pulse at the SelectionArea boundary.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SCENE 1 — HERO FLOW CHART painted with CustomPaint.
// ===========================================================================

class _DelegateFlowHero extends StatelessWidget {
  const _DelegateFlowHero({required this.spy});

  final _DelegateSpy spy;

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kPeach,
      title: '1 · Delegate callback surface',
      subtitle:
          'The methods a SelectionContainerDelegate exposes to the widget layer.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Arrows show incoming SelectionEvents (left) and outgoing '
            'SelectionGeometry / SelectedContent (right). Dashed lines are '
            'lifecycle registrations from child Selectables.',
            style: _kBodyStyle,
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 1.85,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return CustomPaint(
                  painter: _DelegateFlowPainter(),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text('Callouts', style: _kSectionStyle),
          const SizedBox(height: 8),
          _CalloutGrid(items: _kCallouts),
          const SizedBox(height: 12),
          _InlineHintBar(
            spy: spy,
            text:
                'handleSelectionEvent is the write-path; getSelectionGeometry '
                'is the read-path. value is a ValueListenable<SelectionGeometry>.',
          ),
        ],
      ),
    );
  }
}

// The callouts that annotate the flow-chart.
const List<_CalloutItem> _kCallouts = <_CalloutItem>[
  _CalloutItem(
    label: 'handleSelectionEvent',
    description:
        'Inherited from SelectionHandler. Receives SelectionEvents dispatched '
        'by an ancestor SelectableRegion/SelectionArea and decides how to '
        'propagate them to registered selectables.',
    color: _kCyan,
  ),
  _CalloutItem(
    label: 'getSelectionGeometry',
    description:
        'Returns a SelectionGeometry combining child selectables. This is '
        'what the SelectionContainer exposes via its ValueListenable value.',
    color: _kCyanSoft,
  ),
  _CalloutItem(
    label: 'pushHandleLayers',
    description:
        'Receives LayerLinks for start/end selection handles. The delegate '
        'must forward these to whichever selectable currently owns the edge.',
    color: _kPeach,
  ),
  _CalloutItem(
    label: 'value',
    description:
        'ValueListenable<SelectionGeometry>. Listeners rebuild when the '
        'geometry or status changes. notifyListeners is the write side.',
    color: _kPeachDeep,
  ),
  _CalloutItem(
    label: 'selectables',
    description:
        'Internal list that children register via add()/remove() because '
        'SelectionContainerDelegate implements SelectionRegistrar.',
    color: _kPeachSoft,
  ),
  _CalloutItem(
    label: 'contentLength',
    description:
        'Total length of selectable content in this container — used for '
        'offset math when selection crosses multiple selectables.',
    color: _kSuccess,
  ),
];

class _CalloutItem {
  const _CalloutItem({
    required this.label,
    required this.description,
    required this.color,
  });

  final String label;
  final String description;
  final Color color;
}

class _CalloutGrid extends StatelessWidget {
  const _CalloutGrid({required this.items});

  final List<_CalloutItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth > 760 ? 3 : 2;
        final double width =
            (constraints.maxWidth - (columns - 1) * 10) / columns;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            for (final _CalloutItem item in items)
              SizedBox(
                width: width,
                child: _CalloutCard(item: item),
              ),
          ],
        );
      },
    );
  }
}

class _CalloutCard extends StatelessWidget {
  const _CalloutCard({required this.item});

  final _CalloutItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kMidnightDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: item.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(item.description, style: _kBodyStyle),
        ],
      ),
    );
  }
}

class _DelegateFlowPainter extends CustomPainter {
  _DelegateFlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kMidnightDeep;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14)),
      bg,
    );

    // Grid dots.
    final Paint gridPaint = Paint()
      ..color = _kGridLine.withValues(alpha: 0.55);
    const double step = 28;
    for (double x = step; x < size.width; x += step) {
      for (double y = step; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.0, gridPaint);
      }
    }

    final Rect core = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.34,
      height: size.height * 0.42,
    );
    final RRect coreRR =
        RRect.fromRectAndRadius(core, const Radius.circular(14));
    canvas.drawRRect(
      coreRR,
      Paint()..color = _kCyan.withValues(alpha: 0.10),
    );
    canvas.drawRRect(
      coreRR,
      Paint()
        ..color = _kCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    _drawCenteredText(
      canvas,
      'SelectionContainerDelegate',
      core.center.translate(0, -14),
      const TextStyle(
        color: _kCyan,
        fontWeight: FontWeight.w800,
        fontSize: 14,
        fontFamily: 'monospace',
      ),
      core.width - 20,
    );
    _drawCenteredText(
      canvas,
      'selectables • contentLength • value',
      core.center.translate(0, 10),
      const TextStyle(
        color: _kPeach,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
      core.width - 20,
    );

    final List<_FlowNode> inNodes = <_FlowNode>[
      _FlowNode(
        title: 'SelectionArea',
        subtitle: 'dispatches events',
        rect: Rect.fromLTWH(16, 26, size.width * 0.24, 52),
        color: _kPeach,
      ),
      _FlowNode(
        title: 'Selectable child',
        subtitle: 'registers itself',
        rect: Rect.fromLTWH(16, size.height / 2 - 26, size.width * 0.24, 52),
        color: _kPeachSoft,
      ),
      _FlowNode(
        title: 'Handle gesture',
        subtitle: 'pushHandleLayers',
        rect: Rect.fromLTWH(16, size.height - 78, size.width * 0.24, 52),
        color: _kPeachDeep,
      ),
    ];

    final List<_FlowNode> outNodes = <_FlowNode>[
      _FlowNode(
        title: 'SelectionGeometry',
        subtitle: 'value / getter',
        rect: Rect.fromLTWH(
          size.width - 16 - size.width * 0.24,
          26,
          size.width * 0.24,
          52,
        ),
        color: _kCyan,
      ),
      _FlowNode(
        title: 'SelectedContent',
        subtitle: 'getSelectedContent',
        rect: Rect.fromLTWH(
          size.width - 16 - size.width * 0.24,
          size.height / 2 - 26,
          size.width * 0.24,
          52,
        ),
        color: _kCyanSoft,
      ),
      _FlowNode(
        title: 'Listeners',
        subtitle: 'notifyListeners',
        rect: Rect.fromLTWH(
          size.width - 16 - size.width * 0.24,
          size.height - 78,
          size.width * 0.24,
          52,
        ),
        color: _kCyanDeep,
      ),
    ];

    for (final _FlowNode node in inNodes) {
      _drawNode(canvas, node);
      _drawArrow(
        canvas,
        from: node.rect.centerRight,
        to: _nearestEdge(coreRR.outerRect, node.rect.centerRight),
        color: node.color,
      );
    }
    for (final _FlowNode node in outNodes) {
      _drawNode(canvas, node);
      _drawArrow(
        canvas,
        from: _nearestEdge(coreRR.outerRect, node.rect.centerLeft),
        to: node.rect.centerLeft,
        color: node.color,
      );
    }

    // Top label.
    _drawCenteredText(
      canvas,
      'Delegate callback surface',
      Offset(size.width / 2, 14),
      const TextStyle(
        color: _kInkDim,
        fontSize: 10,
        letterSpacing: 1.2,
        fontFamily: 'monospace',
      ),
      size.width,
    );
  }

  Offset _nearestEdge(Rect core, Offset external) {
    final double x = external.dx.clamp(core.left, core.right);
    final double y = external.dy.clamp(core.top, core.bottom);
    return Offset(x, y);
  }

  void _drawNode(Canvas canvas, _FlowNode node) {
    final RRect rr =
        RRect.fromRectAndRadius(node.rect, const Radius.circular(10));
    canvas.drawRRect(
      rr,
      Paint()..color = node.color.withValues(alpha: 0.12),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = node.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
    _drawCenteredText(
      canvas,
      node.title,
      node.rect.center.translate(0, -8),
      TextStyle(
        color: node.color,
        fontWeight: FontWeight.w700,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
      node.rect.width - 12,
    );
    _drawCenteredText(
      canvas,
      node.subtitle,
      node.rect.center.translate(0, 10),
      const TextStyle(
        color: _kInk,
        fontSize: 10,
      ),
      node.rect.width - 12,
    );
  }

  void _drawArrow(
    Canvas canvas, {
    required Offset from,
    required Offset to,
    required Color color,
  }) {
    final Paint stroke = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final double midX = (from.dx + to.dx) / 2;
    final Path path = Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(midX, from.dy, midX, to.dy, to.dx, to.dy);
    canvas.drawPath(path, stroke);

    // Arrow head.
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const double arrowSize = 7;
    final Offset tip = to;
    final Offset p1 = Offset(
      tip.dx - arrowSize * math.cos(angle - math.pi / 7),
      tip.dy - arrowSize * math.sin(angle - math.pi / 7),
    );
    final Offset p2 = Offset(
      tip.dx - arrowSize * math.cos(angle + math.pi / 7),
      tip.dy - arrowSize * math.sin(angle + math.pi / 7),
    );
    final Path head = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(head, Paint()..color = color);
  }

  void _drawCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    TextStyle style,
    double maxWidth,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: maxWidth);
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _DelegateFlowPainter oldDelegate) => false;
}

class _FlowNode {
  _FlowNode({
    required this.title,
    required this.subtitle,
    required this.rect,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Rect rect;
  final Color color;
}

// ===========================================================================
// SCENE 2 — SelectionContainer.disabled pass-through.
// ===========================================================================

class _PassThroughScene extends StatefulWidget {
  const _PassThroughScene({required this.spy});

  final _DelegateSpy spy;

  @override
  State<_PassThroughScene> createState() => _PassThroughSceneState();
}

class _PassThroughSceneState extends State<_PassThroughScene> {
  bool _showDisabled = true;

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kCyan,
      title: '2 · Scene A — SelectionContainer.disabled (pass-through)',
      subtitle:
          'SelectionContainer.disabled injects a null delegate that blocks '
          'registration of descendant Selectables.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Switch(
                value: _showDisabled,
                activeThumbColor: _kCyan,
                activeTrackColor: _kCyan.withValues(alpha: 0.35),
                onChanged: (bool v) {
                  setState(() => _showDisabled = v);
                  widget.spy.record(
                    _DelegateSpyEventKind.info,
                    'sceneA.toggle',
                    'right column disabled=$_showDisabled',
                  );
                },
              ),
              const SizedBox(width: 8),
              Text(
                'Right column disabled: $_showDisabled',
                style: _kLabelStyle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SelectionArea(
            onSelectionChanged: (content) {
              widget.spy.record(
                _DelegateSpyEventKind.sceneA,
                'sceneA.onSelectionChanged',
                content == null
                    ? 'cleared'
                    : '${content.plainText.length} chars — "${widget.spy.preview(content.plainText)}"',
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kMidnightDeep,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGridLine),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _PassThroughParagraph(
                      tint: _kCyan,
                      title: 'Enabled (default)',
                      body: _kEnabledParagraph,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _showDisabled
                        ? const SelectionContainer.disabled(
                            child: _PassThroughParagraph(
                              tint: _kDanger,
                              title: 'Disabled (opt-out)',
                              body: _kDisabledParagraph,
                              disabled: true,
                            ),
                          )
                        : const _PassThroughParagraph(
                            tint: _kCyanSoft,
                            title: 'Disabled OFF → now selectable',
                            body: _kDisabledParagraph,
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoTile(
            icon: Icons.info_outline,
            color: _kPeach,
            text:
                'Try dragging across both columns. With disabled=true, the '
                'right column never participates in the selection — the drag '
                'starts/ends at the disabled boundary.',
          ),
        ],
      ),
    );
  }
}

class _PassThroughParagraph extends StatelessWidget {
  const _PassThroughParagraph({
    required this.tint,
    required this.title,
    required this.body,
    this.disabled = false,
  });

  final Color tint;
  final String title;
  final String body;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: disabled
            ? _kDanger.withValues(alpha: 0.06)
            : _kCyan.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: tint.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                disabled ? Icons.block : Icons.check_circle_outline,
                color: tint,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: _kBodyStyle),
        ],
      ),
    );
  }
}

const String _kEnabledParagraph =
    'This paragraph lives inside the ambient SelectionArea, so its Text '
    'widget registers its internal Selectable with the nearest '
    'SelectionRegistrar — the SelectionArea delegate — and drags flow '
    'through here as expected. Geometry updates dispatch upward.';

const String _kDisabledParagraph =
    'This paragraph is wrapped in SelectionContainer.disabled, which '
    'installs a no-op SelectionRegistrarScope. Descendant Selectables see '
    'a null registrar and skip registration, so selection cannot start or '
    'end here.';

// ===========================================================================
// SCENE 3 — Aggregating selection across multiple columns.
// ===========================================================================

class _AggregatingScene extends StatefulWidget {
  const _AggregatingScene({required this.spy});

  final _DelegateSpy spy;

  @override
  State<_AggregatingScene> createState() => _AggregatingSceneState();
}

class _AggregatingSceneState extends State<_AggregatingScene> {
  int _events = 0;
  String _lastText = '';

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kPeach,
      title: '2 · Scene B — aggregating delegate (nested SelectionArea)',
      subtitle:
          'A nested SelectionArea installs its own delegate which aggregates '
          'geometry from all columns into a single SelectedContent.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectionArea(
            onSelectionChanged: (content) {
              setState(() {
                _events++;
                _lastText = content?.plainText ?? '';
              });
              widget.spy.record(
                _DelegateSpyEventKind.sceneB,
                'sceneB.onSelectionChanged',
                content == null
                    ? 'cleared'
                    : 'aggregated len=${content.plainText.length} '
                          'preview="${widget.spy.preview(content.plainText)}"',
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kMidnightDeep,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGridLine),
              ),
              child: const _ThreeColumnArticle(),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _InspectorCard(
                  eventCount: _events,
                  lastText: _lastText,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: _InfoTile(
                  icon: Icons.merge,
                  color: _kPeach,
                  text:
                      'Flutter\'s built-in MultiSelectableSelectionContainerDelegate '
                      '(used by SelectionArea internally) tracks per-selectable '
                      'offsets and assembles a contentLength that sums all of them. '
                      'Aggregated selection rectangles get clipped to the container\'s '
                      'coordinate space via getTransformFrom.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThreeColumnArticle extends StatelessWidget {
  const _ThreeColumnArticle();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool tight = constraints.maxWidth < 540;
        final int columns = tight ? 1 : 3;
        final double gap = 12;
        final double width =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (int i = 0; i < _kColumns.length; i++)
              SizedBox(
                width: columns == 1 ? constraints.maxWidth : width,
                child: _ColumnTile(
                  index: i,
                  heading: _kColumns[i].$1,
                  body: _kColumns[i].$2,
                ),
              ),
          ],
        );
      },
    );
  }
}

const List<(String, String)> _kColumns = <(String, String)>[
  (
    'Registration',
    'Each Selectable registers itself with the nearest SelectionRegistrar '
        'during mount. The aggregating delegate stores it in an internal list '
        'and must unregister on dispose to avoid stale references.'
  ),
  (
    'Dispatch',
    'When a drag crosses a selectable boundary, the aggregating delegate '
        'splits the event into per-selectable events. Its return value is the '
        'combined SelectionResult — previous, next, end, or none.'
  ),
  (
    'Geometry',
    'For rendering, the delegate merges per-selectable geometries: it picks '
        'the true startSelectionPoint and endSelectionPoint, and concatenates '
        'all selectionRects after applying getTransformFrom.'
  ),
];

class _ColumnTile extends StatelessWidget {
  const _ColumnTile({
    required this.index,
    required this.heading,
    required this.body,
  });

  final int index;
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    final List<Color> tints = <Color>[_kCyan, _kPeach, _kCyanSoft];
    final Color tint = tints[index % tints.length];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            body,
            style: _kBodyStyle,
            cursorColor: _kCyan,
          ),
        ],
      ),
    );
  }
}

class _InspectorCard extends StatelessWidget {
  const _InspectorCard({
    required this.eventCount,
    required this.lastText,
  });

  final int eventCount;
  final String lastText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kMidnightDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPeach.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Inspector', style: _kSectionStyle),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              const Text('events:', style: _kLabelStyle),
              const SizedBox(width: 6),
              Text('$eventCount', style: _kMonoStyle),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('len:', style: _kLabelStyle),
              const SizedBox(width: 6),
              Text('${lastText.length}', style: _kMonoStyle),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            lastText.isEmpty
                ? '(no selection yet — drag across the columns)'
                : '"${_truncate(lastText, 180)}"',
            style: _kMonoStyle,
          ),
        ],
      ),
    );
  }

  String _truncate(String text, int max) {
    if (text.length <= max) {
      return text;
    }
    return '${text.substring(0, max)}…';
  }
}

// ===========================================================================
// SCENE 4 — _DelegateSpy logging scene.
// ===========================================================================

class _LoggingDelegateScene extends StatefulWidget {
  const _LoggingDelegateScene({
    required this.spy,
    required this.onManualPulse,
    required this.onManualClear,
  });

  final _DelegateSpy spy;
  final VoidCallback onManualPulse;
  final VoidCallback onManualClear;

  @override
  State<_LoggingDelegateScene> createState() => _LoggingDelegateSceneState();
}

class _LoggingDelegateSceneState extends State<_LoggingDelegateScene> {
  bool _spyEnabled = true;

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kCyanSoft,
      title: '2 · Scene C — _DelegateSpy logging decorator',
      subtitle:
          'Instead of subclassing SelectionContainerDelegate directly, '
          'compose a spy around SelectionArea that records every onSelectionChanged.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kMidnightDeep,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kInkDim.withValues(alpha: 0.4)),
            ),
            child: const Text(
              'Pedagogical note: SelectionContainerDelegate is abstract and '
              'its full surface (add, remove, dispatchSelectionEvent, '
              'pushHandleLayers, value, getSelectedContent, getSelection, '
              'contentLength, listeners …) is non-trivial to reproduce '
              'correctly. The built-in MultiSelectableSelectionContainerDelegate '
              'Flutter uses internally is private. To observe its behavior '
              'safely, _DelegateSpy subscribes to SelectionArea.onSelectionChanged, '
              'logs every pulse, and lets you compare behavior across scenes.',
              style: _kDimStyle,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Switch(
                value: _spyEnabled,
                activeThumbColor: _kCyan,
                activeTrackColor: _kCyan.withValues(alpha: 0.35),
                onChanged: (bool v) {
                  setState(() => _spyEnabled = v);
                  widget.spy.record(
                    _DelegateSpyEventKind.info,
                    'sceneC.toggle',
                    'spy enabled=$_spyEnabled',
                  );
                },
              ),
              const SizedBox(width: 6),
              Text(
                'Spy enabled: $_spyEnabled',
                style: _kLabelStyle,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: widget.onManualPulse,
                style: FilledButton.styleFrom(
                  backgroundColor: _kCyan,
                  foregroundColor: _kMidnight,
                ),
                icon: const Icon(Icons.bolt, size: 16),
                label: const Text('Manual pulse'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: widget.onManualClear,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kPeach,
                  side: const BorderSide(color: _kPeach),
                ),
                icon: const Icon(Icons.clear_all, size: 16),
                label: const Text('Manual clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectionArea(
            onSelectionChanged: (content) {
              if (!_spyEnabled) {
                return;
              }
              widget.spy.record(
                _DelegateSpyEventKind.sceneC,
                'sceneC.onSelectionChanged',
                content == null
                    ? 'cleared'
                    : 'len=${content.plainText.length} — "${widget.spy.preview(content.plainText)}"',
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kMidnightDeep,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _kCyanSoft.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Two SelectableText children — the delegate can enumerate '
                    'at least these two selectables:',
                    style: _kDimStyle,
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    'The quick cyan fox dispatches a drag across the peach brook. '
                    'handleSelectionEvent receives a SelectionEdgeUpdateEvent; the '
                    'delegate routes it to the right child selectable.',
                    style: _kBodyStyle.copyWith(
                      color: _kCyanSoft,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    'Meanwhile, the peach moon rises above the midnight grid. '
                    'getSelectionGeometry returns a geometry merged from both '
                    'selectables, and pushHandleLayers forwards LayerLinks.',
                    style: _kBodyStyle.copyWith(
                      color: _kPeachSoft,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _InfoTile(
            icon: Icons.visibility_outlined,
            color: _kCyan,
            text:
                'Every drag triggers an entry in the event log at the bottom, '
                'tagged with sceneC. Manual pulses demonstrate how a real '
                'delegate-side notifyListeners flows through the SelectionHandler '
                'boundary.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// OWNERSHIP TABLE — delegate vs registrar vs fragment.
// ===========================================================================

class _OwnershipTable extends StatelessWidget {
  const _OwnershipTable();

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kPeach,
      title: '3 · Who owns what',
      subtitle:
          'The selection pipeline has three roles; keeping them straight '
          'clarifies where to customize behavior.',
      child: Container(
        decoration: BoxDecoration(
          color: _kMidnightDeep,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kGridLine),
        ),
        child: Column(
          children: const <Widget>[
            _TableRow(
              role: 'Role',
              description: 'Responsibility',
              notableMembers: 'Key members',
              isHeader: true,
            ),
            Divider(height: 1, color: _kGridLine),
            _TableRow(
              role: 'SelectionContainerDelegate',
              description:
                  'Decides how selection is aggregated, dispatched, and geometrized '
                  'inside a SelectionContainer.',
              notableMembers:
                  'handleSelectionEvent · value · getSelectionGeometry · '
                  'pushHandleLayers · getSelectedContent · contentLength',
              accent: _kCyan,
            ),
            Divider(height: 1, color: _kGridLine),
            _TableRow(
              role: 'SelectionRegistrar',
              description:
                  'Registry where Selectables subscribe. Delegates implement '
                  'this interface; SelectionContainer.maybeOf returns the ambient one.',
              notableMembers: 'add(Selectable) · remove(Selectable)',
              accent: _kPeach,
            ),
            Divider(height: 1, color: _kGridLine),
            _TableRow(
              role: 'Selectable / SelectableFragment',
              description:
                  'Leaf Selectable mixin; fragments represent sub-pieces of a '
                  'RenderParagraph for cross-paragraph selection.',
              notableMembers:
                  'dispatchSelectionEvent · value · boundingBoxes · '
                  'pushHandleLayers',
              accent: _kCyanSoft,
            ),
            Divider(height: 1, color: _kGridLine),
            _TableRow(
              role: 'SelectionArea / SelectableRegion',
              description:
                  'Top-level widgets that install a default aggregating delegate '
                  'and wire it to gesture recognizers + toolbars.',
              notableMembers:
                  'onSelectionChanged · selectionControls · contextMenuBuilder',
              accent: _kPeachSoft,
            ),
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.role,
    required this.description,
    required this.notableMembers,
    this.isHeader = false,
    this.accent,
  });

  final String role;
  final String description;
  final String notableMembers;
  final bool isHeader;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = TextStyle(
      color: accent ?? _kCyan,
      fontWeight: FontWeight.w700,
      fontSize: isHeader ? 12 : 13,
      letterSpacing: isHeader ? 1.2 : 0.2,
      fontFamily: isHeader ? 'monospace' : null,
    );
    final TextStyle bodyStyle = isHeader ? _kLabelStyle : _kBodyStyle;
    final TextStyle monoStyle = isHeader ? _kLabelStyle : _kMonoStyle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(role, style: headerStyle),
          ),
          Expanded(
            flex: 5,
            child: Text(description, style: bodyStyle),
          ),
          Expanded(
            flex: 4,
            child: Text(notableMembers, style: monoStyle),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// WHEN TO BUILD A CUSTOM DELEGATE.
// ===========================================================================

class _WhenToBuildCard extends StatelessWidget {
  const _WhenToBuildCard();

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kCyan,
      title: '4 · When to build a custom delegate',
      subtitle: 'Concrete signals that the default aggregator is not enough.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SignalRow(
            ok: true,
            label: 'Non-linear content order',
            text:
                'You want selection to traverse children in a custom order — '
                'e.g. a grid that should select row-major instead of z-order.',
          ),
          _SignalRow(
            ok: true,
            label: 'Synthetic selectables',
            text:
                'You have custom RenderObjects that are not Text but should '
                'participate in copy/selection (e.g. a chart, timeline, chip row).',
          ),
          _SignalRow(
            ok: true,
            label: 'Filtered dispatch',
            text:
                'You want to veto specific SelectionEvent subclasses — e.g. '
                'block SelectAllSelectionEvent in a sensitive panel.',
          ),
          _SignalRow(
            ok: false,
            label: 'You just want different highlight colors',
            text:
                'Use TextSelectionThemeData.selectionColor or a SelectionArea '
                'theme override — do NOT subclass the delegate for this.',
          ),
          _SignalRow(
            ok: false,
            label: 'You need to opt a subtree out',
            text:
                'Use SelectionContainer.disabled (see Scene A) — cheaper and '
                'analyzer-safe.',
          ),
        ],
      ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  const _SignalRow({
    required this.ok,
    required this.label,
    required this.text,
  });

  final bool ok;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color tint = ok ? _kSuccess : _kDanger;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            ok ? Icons.check_circle_outline : Icons.do_not_disturb_on_outlined,
            color: tint,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(text, style: _kBodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// GOTCHAS.
// ===========================================================================

class _GotchasCard extends StatelessWidget {
  const _GotchasCard();

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kPeachDeep,
      title: '5 · Gotchas',
      subtitle:
          'Delegate implementations that seem to work locally but break in '
          'the field.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _GotchaRow(
            number: 1,
            title: 'Register / unregister symmetry',
            text:
                'If a Selectable is removed from the tree but you forget to '
                'call remove(), you will leak it; if you call remove during '
                'dispatch, concurrent modification bugs surface randomly.',
          ),
          _GotchaRow(
            number: 2,
            title: 'Geometry must be consistent',
            text:
                'getSelectionGeometry should always reflect the latest '
                'dispatched event before notifyListeners fires. Otherwise '
                'handle layers end up pointing at stale positions.',
          ),
          _GotchaRow(
            number: 3,
            title: 'Transform-space mistakes',
            text:
                'Selectables report geometry in their own coords. The '
                'delegate MUST apply getTransformFrom(child) before merging — '
                'otherwise rects drift when any ancestor scales/rotates.',
          ),
          _GotchaRow(
            number: 4,
            title: 'contentLength must sum child lengths',
            text:
                'Several editing gestures rely on offsets into contentLength. '
                'If children are added/removed, recompute on each change.',
          ),
          _GotchaRow(
            number: 5,
            title: 'Do not forget ClearSelectionEvent',
            text:
                'When the selection is dismissed, dispatch ClearSelectionEvent '
                'to every child and reset internal edges to null.',
          ),
          _GotchaRow(
            number: 6,
            title: 'pushHandleLayers is fan-out',
            text:
                'Start and end handles often live in different child '
                'selectables. The delegate must forward each LayerLink to the '
                'correct child based on current edges.',
          ),
        ],
      ),
    );
  }
}

class _GotchaRow extends StatelessWidget {
  const _GotchaRow({
    required this.number,
    required this.title,
    required this.text,
  });

  final int number;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kPeachDeep.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kPeachDeep.withValues(alpha: 0.6)),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: _kPeachDeep,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kPeachDeep,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(text, style: _kBodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// EVENT LOG CARD.
// ===========================================================================

class _EventLogCard extends StatelessWidget {
  const _EventLogCard({required this.spy});

  final _DelegateSpy spy;

  @override
  Widget build(BuildContext context) {
    return _PanelCard(
      accent: _kCyan,
      title: '6 · Event log — _DelegateSpy output',
      subtitle:
          'Every onSelectionChanged pulse and every manual delegate-style '
          'event lands here, newest first.',
      child: ListenableBuilder(
        listenable: spy,
        builder: (BuildContext context, Widget? _) {
          final List<_DelegateSpyEvent> events = spy.events;
          return Container(
            height: 260,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kMidnightDeep,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kGridLine),
            ),
            child: events.isEmpty
                ? Center(
                    child: Text(
                      '(no events yet — drag across any scene)',
                      style: _kDimStyle,
                    ),
                  )
                : ListView.separated(
                    reverse: false,
                    itemCount: events.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (BuildContext context, int index) {
                      final _DelegateSpyEvent e = events[index];
                      return _EventLogRow(event: e);
                    },
                  ),
          );
        },
      ),
    );
  }
}

class _EventLogRow extends StatelessWidget {
  const _EventLogRow({required this.event});

  final _DelegateSpyEvent event;

  @override
  Widget build(BuildContext context) {
    final Color kindColor = _colorFor(event.kind);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kindColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kindColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Text(
              event.stamp,
              style: TextStyle(
                color: kindColor,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              event.kind.name,
              style: TextStyle(
                color: kindColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              event.tag,
              style: const TextStyle(
                color: _kPeach,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              event.payload,
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _colorFor(_DelegateSpyEventKind kind) {
    switch (kind) {
      case _DelegateSpyEventKind.info:
        return _kInkDim;
      case _DelegateSpyEventKind.outerArea:
        return _kCyanSoft;
      case _DelegateSpyEventKind.sceneA:
        return _kCyan;
      case _DelegateSpyEventKind.sceneB:
        return _kPeach;
      case _DelegateSpyEventKind.sceneC:
        return _kCyan;
      case _DelegateSpyEventKind.manual:
        return _kPeachDeep;
    }
  }
}

// ===========================================================================
// _DelegateSpy — the logging core.
// ===========================================================================

enum _DelegateSpyEventKind {
  info,
  outerArea,
  sceneA,
  sceneB,
  sceneC,
  manual,
}

class _DelegateSpyEvent {
  _DelegateSpyEvent({
    required this.kind,
    required this.tag,
    required this.payload,
    required this.stamp,
  });

  final _DelegateSpyEventKind kind;
  final String tag;
  final String payload;
  final String stamp;
}

class _DelegateSpy extends ChangeNotifier {
  final List<_DelegateSpyEvent> _events = <_DelegateSpyEvent>[];
  static const int _maxEvents = 60;

  List<_DelegateSpyEvent> get events => List<_DelegateSpyEvent>.unmodifiable(
    _events.reversed,
  );

  void record(_DelegateSpyEventKind kind, String tag, String payload) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${_two(now.hour)}:${_two(now.minute)}:${_two(now.second)}';
    _events.add(
      _DelegateSpyEvent(
        kind: kind,
        tag: tag,
        payload: payload,
        stamp: stamp,
      ),
    );
    if (_events.length > _maxEvents) {
      _events.removeRange(0, _events.length - _maxEvents);
    }
    debugPrint('[_DelegateSpy] $stamp ${kind.name} $tag · $payload');
    notifyListeners();
  }

  String preview(String raw) {
    final String flat = raw.replaceAll('\n', '\u21B5');
    if (flat.length <= 48) {
      return flat;
    }
    return '${flat.substring(0, 48)}…';
  }

  static String _two(int value) {
    return value.toString().padLeft(2, '0');
  }
}

// ===========================================================================
// SMALL SHARED COMPONENTS.
// ===========================================================================

class _PanelCard extends StatelessWidget {
  const _PanelCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kMidnightPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 22,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 6,
                height: 22,
                margin: const EdgeInsets.only(top: 4, right: 12),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: _kTitleStyle.copyWith(color: accent)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: _kDimStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.bullet, required this.text});

  final String bullet;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kCyan.withValues(alpha: 0.5)),
            ),
            child: Text(
              bullet,
              style: const TextStyle(
                color: _kCyan,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: _kBodyStyle)),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: _kBodyStyle)),
        ],
      ),
    );
  }
}

class _InlineHintBar extends StatelessWidget {
  const _InlineHintBar({required this.spy, required this.text});

  final _DelegateSpy spy;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kPeach.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPeach.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.lightbulb_outline, color: _kPeach, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: _kBodyStyle),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              spy.record(
                _DelegateSpyEventKind.info,
                'hint.dismiss',
                'User acknowledged hint',
              );
            },
            style: TextButton.styleFrom(foregroundColor: _kPeach),
            child: const Text('got it'),
          ),
        ],
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 1,
            width: 120,
            color: _kGridLine,
          ),
          const SizedBox(height: 8),
          Text(
            'SelectionContainerDelegate — Delegate Dissection',
            style: _kDimStyle,
          ),
          const SizedBox(height: 3),
          Text(
            'Palette: midnight #0B1120 · cyan #22D3EE · peach #FED7AA',
            style: _kDimStyle,
          ),
        ],
      ),
    );
  }
}
