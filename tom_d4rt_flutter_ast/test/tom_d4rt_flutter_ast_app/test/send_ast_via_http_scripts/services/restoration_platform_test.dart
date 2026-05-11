// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
// =====================================================================
// Deep visual demo: platform-side restoration API
// ---------------------------------------------------------------------
// Topic   : RestorationManager, RestorationBucket, RestorationBucketStorage
// Channel : flutter/restoration
// Codec   : StandardMessageCodec-compatible primitives
// Purpose : Visualise the cold-start round-trip pipeline of restoration
//           data between framework state, the platform channel, and the
//           operating system's persistence layer.
// =====================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// Palette constants
// =====================================================================

const Color _kBgDeep = Color(0xFF0B1020);
const Color _kBgMid = Color(0xFF131A33);
const Color _kBgSoft = Color(0xFF1B2348);
const Color _kInk = Color(0xFFE7ECFF);
const Color _kInkSoft = Color(0xFFB4BEDC);
const Color _kInkMute = Color(0xFF7C88B2);
const Color _kAccentA = Color(0xFF6EA8FE);
const Color _kAccentB = Color(0xFF8E7BFF);
const Color _kAccentC = Color(0xFF4DD0E1);
const Color _kAccentD = Color(0xFFFFB86B);
const Color _kAccentE = Color(0xFFFF6B9D);
const Color _kAccentF = Color(0xFF7DE2A8);
const Color _kAccentG = Color(0xFFFFD166);
const Color _kAccentH = Color(0xFFC084FC);
const Color _kCardEdge = Color(0xFF2A3360);
const Color _kCardEdgeBright = Color(0xFF45528A);
const Color _kCodeBg = Color(0xFF080B18);
const Color _kCodeEdge = Color(0xFF1F2A55);
const Color _kOk = Color(0xFF66DDAA);
const Color _kBad = Color(0xFFFF8088);
const Color _kWarn = Color(0xFFFFCB6B);

// =====================================================================
// Gradients
// =====================================================================

const LinearGradient _gradHero = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF1A2452),
    Color(0xFF2C2160),
    Color(0xFF45236E),
  ],
);

const LinearGradient _gradManager = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF15244C),
    Color(0xFF1E2D5E),
    Color(0xFF253874),
  ],
);

const LinearGradient _gradBucket = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF142D40),
    Color(0xFF19405A),
    Color(0xFF1F5774),
  ],
);

const LinearGradient _gradPayload = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF2A1A47),
    Color(0xFF3A205C),
    Color(0xFF4B2E76),
  ],
);

const LinearGradient _gradPipeline = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color(0xFF0E1A38),
    Color(0xFF18234E),
    Color(0xFF0E1A38),
  ],
);

const LinearGradient _gradDecision = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF15323A),
    Color(0xFF1D4750),
    Color(0xFF235668),
  ],
);

const LinearGradient _gradCallback = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF301E12),
    Color(0xFF44291A),
    Color(0xFF583622),
  ],
);

const LinearGradient _gradReference = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF1A1A35),
    Color(0xFF221E45),
    Color(0xFF2A2255),
  ],
);

const LinearGradient _gradChannel = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF12233F),
    Color(0xFF1A3050),
    Color(0xFF223D63),
  ],
);

const LinearGradient _gradPalette = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF192040),
    Color(0xFF222C55),
    Color(0xFF2D3A6F),
  ],
);

// =====================================================================
// Shadow helpers
// =====================================================================

List<BoxShadow> _heroShadows() => const <BoxShadow>[
      BoxShadow(
        color: Color(0x6608112F),
        blurRadius: 28.0,
        offset: Offset(0.0, 18.0),
      ),
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 6.0,
        offset: Offset(0.0, 2.0),
      ),
      BoxShadow(
        color: Color(0x2A6EA8FE),
        blurRadius: 60.0,
        offset: Offset(0.0, 0.0),
        spreadRadius: 1.0,
      ),
    ];

List<BoxShadow> _cardShadows() => const <BoxShadow>[
      BoxShadow(
        color: Color(0x55050817),
        blurRadius: 18.0,
        offset: Offset(0.0, 10.0),
      ),
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ];

List<BoxShadow> _glowShadows(Color tint) => <BoxShadow>[
      BoxShadow(
        color: tint.withValues(alpha: 0.35),
        blurRadius: 38.0,
        offset: const Offset(0.0, 0.0),
        spreadRadius: 0.0,
      ),
      const BoxShadow(
        color: Color(0x66000814),
        blurRadius: 14.0,
        offset: Offset(0.0, 8.0),
      ),
    ];

List<BoxShadow> _chipShadows() => const <BoxShadow>[
      BoxShadow(
        color: Color(0x55000814),
        blurRadius: 10.0,
        offset: Offset(0.0, 4.0),
      ),
      BoxShadow(
        color: Color(0x222C61C0),
        blurRadius: 18.0,
        offset: Offset(0.0, 0.0),
      ),
    ];

// =====================================================================
// Painter: round-trip restoration pipeline
// =====================================================================

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter({required this.highlight});

  final int highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFF0B1126), Color(0xFF111A38)],
      ).createShader(Offset.zero & size);
    final RRect bgRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(18.0),
    );
    canvas.drawRRect(bgRect, bg);

    final List<_Node> nodes = <_Node>[
      _Node('Framework\nState', _kAccentA, const Offset(0.10, 0.20)),
      _Node('Restoration\nBucket', _kAccentB, const Offset(0.42, 0.20)),
      _Node('Restoration\nManager', _kAccentC, const Offset(0.74, 0.20)),
      _Node('Platform\nChannel', _kAccentD, const Offset(0.90, 0.55)),
      _Node('OS\nStorage', _kAccentE, const Offset(0.74, 0.85)),
      _Node('Cold Start\nPayload', _kAccentF, const Offset(0.42, 0.85)),
      _Node('Restored\nState', _kAccentG, const Offset(0.10, 0.85)),
    ];

    for (int i = 0; i < nodes.length - 1; i++) {
      _drawArrow(
        canvas,
        size,
        nodes[i].rel,
        nodes[i + 1].rel,
        active: i == highlight,
        tint: nodes[i].tint,
      );
    }
    // Closing loop arrow from final to first.
    _drawArrow(
      canvas,
      size,
      nodes.last.rel,
      nodes.first.rel,
      active: highlight == nodes.length - 1,
      tint: nodes.last.tint,
      curveUp: true,
    );

    for (int i = 0; i < nodes.length; i++) {
      _drawNode(canvas, size, nodes[i], active: i == highlight);
    }
  }

  void _drawNode(Canvas canvas, Size size, _Node node, {required bool active}) {
    final Offset center = Offset(node.rel.dx * size.width, node.rel.dy * size.height);
    final double radius = active ? 38.0 : 32.0;
    final Rect box = Rect.fromCenter(
      center: center,
      width: radius * 3.6,
      height: radius * 1.9,
    );
    final RRect r = RRect.fromRectAndRadius(box, const Radius.circular(12.0));

    final Paint glow = Paint()
      ..color = node.tint.withValues(alpha: active ? 0.55 : 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14.0);
    canvas.drawRRect(r.inflate(4.0), glow);

    final Paint fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          node.tint.withValues(alpha: 0.85),
          node.tint.withValues(alpha: 0.55),
        ],
      ).createShader(box);
    canvas.drawRRect(r, fill);

    final Paint edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = active ? 2.2 : 1.4
      ..color = Colors.white.withValues(alpha: active ? 0.85 : 0.45);
    canvas.drawRRect(r, edge);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: node.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: box.width - 8.0);
    tp.paint(
      canvas,
      box.center - Offset(tp.width / 2, tp.height / 2),
    );
  }

  void _drawArrow(
    Canvas canvas,
    Size size,
    Offset a,
    Offset b, {
    required bool active,
    required Color tint,
    bool curveUp = false,
  }) {
    final Offset p0 = Offset(a.dx * size.width, a.dy * size.height);
    final Offset p1 = Offset(b.dx * size.width, b.dy * size.height);
    final Path path = Path()..moveTo(p0.dx, p0.dy);
    final Offset mid = (p0 + p1) / 2;
    final Offset control = curveUp
        ? mid + Offset(0.0, -size.height * 0.25)
        : mid + Offset(0.0, ((b.dy - a.dy).abs() < 0.05) ? -16.0 : 0.0);
    path.quadraticBezierTo(control.dx, control.dy, p1.dx, p1.dy);

    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = active ? 3.2 : 1.6
      ..color = tint.withValues(alpha: active ? 0.95 : 0.55);
    canvas.drawPath(path, stroke);

    // Arrowhead
    final double angle = (p1 - control).direction;
    const double headLen = 10.0;
    final Offset tip = p1;
    final Offset left = tip - Offset.fromDirection(angle - 0.35, headLen);
    final Offset right = tip - Offset.fromDirection(angle + 0.35, headLen);
    final Path head = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final Paint headPaint = Paint()..color = tint;
    canvas.drawPath(head, headPaint);
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter old) => old.highlight != highlight;
}

class _Node {
  const _Node(this.label, this.tint, this.rel);
  final String label;
  final Color tint;
  final Offset rel;
}

// =====================================================================
// Painter: bucket tree diagram
// =====================================================================

class _BucketTreePainter extends CustomPainter {
  const _BucketTreePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0E1730);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14.0)),
      bg,
    );

    final List<_BucketNode> tree = <_BucketNode>[
      _BucketNode('root', _kAccentA, const Offset(0.5, 0.10), 110.0, 26.0),
      _BucketNode('app.nav', _kAccentB, const Offset(0.22, 0.40), 92.0, 24.0),
      _BucketNode('app.theme', _kAccentC, const Offset(0.50, 0.40), 92.0, 24.0),
      _BucketNode('app.user', _kAccentD, const Offset(0.78, 0.40), 92.0, 24.0),
      _BucketNode('nav.tab=2', _kAccentE, const Offset(0.10, 0.72), 80.0, 22.0),
      _BucketNode('nav.scroll=140', _kAccentE, const Offset(0.32, 0.72), 100.0, 22.0),
      _BucketNode('theme.dark=1', _kAccentF, const Offset(0.50, 0.72), 96.0, 22.0),
      _BucketNode('user.id=42', _kAccentG, const Offset(0.70, 0.72), 88.0, 22.0),
      _BucketNode('user.cart=[]', _kAccentH, const Offset(0.88, 0.72), 88.0, 22.0),
    ];

    final List<List<int>> edges = <List<int>>[
      <int>[0, 1],
      <int>[0, 2],
      <int>[0, 3],
      <int>[1, 4],
      <int>[1, 5],
      <int>[2, 6],
      <int>[3, 7],
      <int>[3, 8],
    ];

    final Paint edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.white.withValues(alpha: 0.35);

    for (final List<int> e in edges) {
      final Offset a = Offset(
        tree[e[0]].rel.dx * size.width,
        tree[e[0]].rel.dy * size.height,
      );
      final Offset b = Offset(
        tree[e[1]].rel.dx * size.width,
        tree[e[1]].rel.dy * size.height,
      );
      final Path p = Path()
        ..moveTo(a.dx, a.dy + 14.0)
        ..cubicTo(a.dx, (a.dy + b.dy) / 2, b.dx, (a.dy + b.dy) / 2, b.dx, b.dy - 14.0);
      canvas.drawPath(p, edgePaint);
    }

    for (final _BucketNode n in tree) {
      final Offset center = Offset(n.rel.dx * size.width, n.rel.dy * size.height);
      final Rect r = Rect.fromCenter(center: center, width: n.w, height: n.h);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      final Paint fill = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            n.tint.withValues(alpha: 0.85),
            n.tint.withValues(alpha: 0.50),
          ],
        ).createShader(r);
      canvas.drawRRect(rr, fill);
      final Paint edge = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = Colors.white.withValues(alpha: 0.55);
      canvas.drawRRect(rr, edge);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 8.0);
      tp.paint(canvas, r.center - Offset(tp.width / 2, tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _BucketTreePainter old) => false;
}

class _BucketNode {
  const _BucketNode(this.label, this.tint, this.rel, this.w, this.h);
  final String label;
  final Color tint;
  final Offset rel;
  final double w;
  final double h;
}

// =====================================================================
// Section helpers
// =====================================================================

Widget _sectionShell({
  required String tag,
  required String title,
  required String subtitle,
  required Gradient gradient,
  required Widget body,
  Color glow = _kAccentA,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 22.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _kCardEdge, width: 1.1),
      boxShadow: _glowShadows(glow),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: glow.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: glow.withValues(alpha: 0.55)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: glow,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          subtitle,
          style: const TextStyle(
            color: _kInkMute,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),
        body,
      ],
    ),
  );
}

Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 13.0,
        height: 1.55,
      ),
    ),
  );
}

Widget _kvRow(String k, String v, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150.0,
          child: Text(
            k,
            style: TextStyle(
              color: accent ?? _kAccentA,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color tint) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: tint.withValues(alpha: 0.55)),
      boxShadow: _chipShadows(),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _codeCard(String title, String code, Color accent) {
  return Container(
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kCodeEdge),
      boxShadow: _cardShadows(),
    ),
    padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: accent.withValues(alpha: 0.6),
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          code,
          style: const TextStyle(
            color: _kInk,
            fontSize: 12.0,
            height: 1.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _calloutBox(String title, String body, Color tint, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tint.withValues(alpha: 0.55)),
      boxShadow: _cardShadows(),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: tint, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 1 — Hero
// =====================================================================

Widget _heroSection() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
    padding: const EdgeInsets.fromLTRB(22.0, 26.0, 22.0, 28.0),
    decoration: BoxDecoration(
      gradient: _gradHero,
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: _kCardEdgeBright, width: 1.4),
      boxShadow: _heroShadows(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kAccentB.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: _kAccentB.withValues(alpha: 0.65)),
              ),
              child: const Text(
                'flutter/services',
                style: TextStyle(
                  color: _kAccentB,
                  fontWeight: FontWeight.w800,
                  fontSize: 10.5,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kAccentC.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: _kAccentC.withValues(alpha: 0.65)),
              ),
              child: const Text(
                'flutter/restoration',
                style: TextStyle(
                  color: _kAccentC,
                  fontWeight: FontWeight.w800,
                  fontSize: 10.5,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Platform-side Restoration',
          style: TextStyle(
            color: _kInk,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'RestorationManager · RestorationBucket · RestorationBucketStorage',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'This page documents how Flutter persists small fragments of UI state across cold '
          'starts by handing them to the host operating system through a single dedicated '
          'platform channel. The framework never writes to disk on its own — it serialises '
          'a tree of buckets into a StandardMessageCodec payload and asks the embedder to '
          'remember it. On the next launch the embedder replays the payload back, the '
          'manager rebuilds the tree, and individual RestorationMixin participants pull '
          'their values from named slots before the first frame renders.',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _heroPill('cold-start safe', _kAccentA),
            _heroPill('async I/O', _kAccentC),
            _heroPill('opt-in per widget', _kAccentD),
            _heroPill('platform-bounded', _kAccentE),
          ],
        ),
      ],
    ),
  );
}

Widget _heroPill(String label, Color tint) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: tint.withValues(alpha: 0.55)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontWeight: FontWeight.w700,
        fontSize: 11.0,
      ),
    ),
  );
}

// =====================================================================
// Section 2 — RestorationManager anatomy
// =====================================================================

Widget _managerSection() {
  return _sectionShell(
    tag: 'MANAGER',
    title: 'RestorationManager — the single owner',
    subtitle:
        'Owns the root bucket, talks to the embedder, and broadcasts change notifications.',
    gradient: _gradManager,
    glow: _kAccentA,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'A single RestorationManager instance is reachable from any element in the '
          'tree via ServicesBinding.instance.restorationManager. It is the only object '
          'that knows how to communicate with the platform — every other restoration '
          'class hangs off it. The manager keeps a reference to the root RestorationBucket '
          '(once one has been provisioned by the platform) and exposes it lazily through '
          'the rootBucket Future. Until that Future completes the framework cannot read '
          'or write restoration data, which is why restoration is opt-in: a widget that '
          'wants to participate must wait for its slot to become available.',
        ),
        const SizedBox(height: 10.0),
        _kvRow('rootBucket', 'Future<RestorationBucket?> — completes after the platform answers'),
        _kvRow('isReplacing', 'bool — true while a new platform payload is being merged'),
        _kvRow('flushData()', 'void — schedules a serialised payload write through the channel'),
        _kvRow('handleRestorationUpdateFromEngine',
            'protocol entry-point invoked by the engine when fresh data arrives'),
        _kvRow('scheduleSerializationFor',
            'void — marks a bucket dirty so its bytes are re-sent on the next flush'),
        _kvRow('notifyListeners', 'ChangeNotifier — broadcasts when the tree mutates'),
        _calloutBox(
          'Lifecycle',
          'Construction is automatic. The framework instantiates the manager when the '
          'service binding initialises, immediately requests an initial payload from the '
          'platform, and then keeps the tree synchronised as the user moves through the app.',
          _kAccentA,
          Icons.timeline_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 3 — Bucket tree
// =====================================================================

Widget _bucketSection() {
  return _sectionShell(
    tag: 'BUCKET',
    title: 'RestorationBucket — the hierarchical container',
    subtitle:
        'A small key/value store that nests other buckets, used to back property scopes.',
    gradient: _gradBucket,
    glow: _kAccentC,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'Each RestorationBucket is essentially a Map of restoration IDs to two kinds '
          'of children: leaf values (primitives the codec can serialise) and child '
          'buckets (other RestorationBuckets owned by deeper widgets). Buckets form a '
          'tree mirroring the participating subtree of the UI: a ChildBackButtonDispatcher '
          'might own one child bucket per route, and inside each route a list widget '
          'might own another bucket per visible cell. When a value changes, the bucket '
          'marks itself dirty and asks the manager to flush.',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: const _BucketTreePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            _chip('read<T>(id)', _kAccentA),
            _chip('write(id, value)', _kAccentB),
            _chip('claimChild(id, debugOwner)', _kAccentC),
            _chip('adoptChild(bucket)', _kAccentD),
            _chip('remove(id)', _kAccentE),
            _chip('rename(newId)', _kAccentF),
            _chip('finalize()', _kAccentG),
            _chip('addListener', _kAccentH),
          ],
        ),
        _calloutBox(
          'Ownership',
          'Two participants can claim the same restoration ID — the manager treats one as '
          'the active owner and keeps the other warm. When the owner releases its claim the '
          'warm participant immediately adopts the bucket and hydrates from its existing '
          'values, which is how navigation animations preserve state across page swaps.',
          _kAccentC,
          Icons.account_tree_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 4 — Pipeline diagram
// =====================================================================

Widget _pipelineSection(int highlight, void Function(int) onStep) {
  return _sectionShell(
    tag: 'PIPELINE',
    title: 'Round-trip across the channel',
    subtitle:
        'Framework state → bucket → platform channel → OS storage → cold start → bucket → state.',
    gradient: _gradPipeline,
    glow: _kAccentB,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'The seven-step round trip below is the entire mental model of restoration. '
          'Every restoration scenario in the framework — keeping a TextField cursor at '
          'the same offset after a tab swap, restoring scroll position on Android task '
          'kill, replaying the focused page index of a PageView — collapses to this same '
          'choreography. The arrows are bidirectional in intent but in practice each call '
          'only writes a forward delta or schedules a future read.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 280.0,
          child: CustomPaint(
            painter: _PipelinePainter(highlight: highlight),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (int i = 0; i < 7; i++)
              GestureDetector(
                onTap: () => onStep(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: (i == highlight ? _kAccentB : _kBgSoft)
                        .withValues(alpha: i == highlight ? 0.35 : 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: i == highlight ? _kAccentB : _kCardEdge,
                      width: i == highlight ? 1.4 : 1.0,
                    ),
                  ),
                  child: Text(
                    'Step ${i + 1}',
                    style: TextStyle(
                      color: i == highlight ? _kAccentB : _kInkSoft,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12.0),
        _kvRow('1. State', 'A widget mutates a RestorableProperty; the property writes to its bucket.',
            accent: _kAccentA),
        _kvRow('2. Bucket', 'The bucket marks itself dirty and notifies the manager via finalize().',
            accent: _kAccentB),
        _kvRow('3. Manager', 'The manager batches dirty buckets and serialises the payload.',
            accent: _kAccentC),
        _kvRow('4. Channel', 'It writes through MethodChannel("flutter/restoration").put.',
            accent: _kAccentD),
        _kvRow('5. OS', 'The embedder persists the bytes — SharedPreferences on Android, NSUserDefaults on iOS.',
            accent: _kAccentE),
        _kvRow('6. Cold Start', 'On relaunch the embedder reads the bytes and pushes them via .get.',
            accent: _kAccentF),
        _kvRow('7. Restored', 'Buckets rehydrate, properties call initWithValue, state is back.',
            accent: _kAccentG),
      ],
    ),
  );
}

// =====================================================================
// Section 5 — Payload mockup
// =====================================================================

Widget _payloadSection() {
  const String payload = '''{
  "v": 1,
  "c": {
    "app.nav": {
      "v": 0,
      "c": {
        "tab":    { "v": 2 },
        "scroll": { "v": 140.0 },
        "search": { "v": "flu" }
      }
    },
    "app.theme": {
      "v": 0,
      "c": {
        "dark": { "v": true }
      }
    },
    "app.user": {
      "v": 0,
      "c": {
        "id":   { "v": 42 },
        "cart": { "v": [101, 102, 103] }
      }
    }
  }
}''';
  const String wireFormat = '''// On the wire (pseudo):
StandardMessageCodec.encode(<String, Object?>{
  'enabled': true,
  'data': <int>[ /* 8-bit bytes of nested map */ ],
});

// Channel:
const MethodChannel('flutter/restoration')
  ..invokeMethod<dynamic>('put', payloadBytes)
  ..setMethodCallHandler(_engineUpdates);''';

  return _sectionShell(
    tag: 'PAYLOAD',
    title: 'Serialized bucket — the wire shape',
    subtitle:
        'A nested map of restoration IDs to {value, children} pairs, codec-encoded.',
    gradient: _gradPayload,
    glow: _kAccentB,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'The actual payload Flutter sends is not JSON — it is a Map<String, dynamic> '
          'encoded with StandardMessageCodec. The mock below uses JSON-style braces only '
          'because they read cleanly: keys "v" and "c" stand for "values" and "children" '
          'and you can see how a bucket nests other buckets inside the c map. The whole '
          'thing is bounded in size and intent: restoration is for tiny UI hints, not for '
          'application data. Treat it like a few kilobytes of breadcrumbs.',
        ),
        const SizedBox(height: 12.0),
        _codeCard('mock bucket tree', payload, _kAccentB),
        const SizedBox(height: 12.0),
        _codeCard('channel call', wireFormat, _kAccentD),
        _calloutBox(
          'Size budget',
          'Embedders typically silently drop or truncate payloads larger than a few hundred '
          'kilobytes. Anything you would not want to fit inside a single platform message '
          'almost certainly belongs in a database, not in a restoration bucket.',
          _kWarn,
          Icons.scale_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 6 — Decision matrix
// =====================================================================

Widget _decisionSection() {
  return _sectionShell(
    tag: 'DECISION',
    title: 'Restoration-friendly value types',
    subtitle:
        'What the StandardMessageCodec accepts vs what you must transform first.',
    gradient: _gradDecision,
    glow: _kAccentC,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'Restoration values bottom out at the same primitives the platform channel '
          'codec understands. The cheat sheet below shows which Dart types can be written '
          'into a bucket directly, which need a deterministic conversion, and which are '
          'flat-out unsupported. If you ever feel the urge to put a closure, a Future, or '
          'a live Flutter object into a bucket, stop — convert the underlying intent into '
          'a small primitive instead and rebuild the live object on the way back in.',
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: _kBgDeep,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kCardEdge),
            boxShadow: _cardShadows(),
          ),
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            headingRowHeight: 36.0,
            dataRowMinHeight: 32.0,
            dataRowMaxHeight: 44.0,
            columnSpacing: 22.0,
            headingTextStyle: const TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
            dataTextStyle: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.0,
            ),
            columns: const <DataColumn>[
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Supported')),
              DataColumn(label: Text('Notes')),
            ],
            rows: <DataRow>[
              _decisionRow('int', _kOk, 'Native; round-trips as 32/64-bit integer.'),
              _decisionRow('double', _kOk, 'Native; NaN/±Infinity are preserved on most embedders.'),
              _decisionRow('bool', _kOk, 'Native; encoded as a 1-byte primitive.'),
              _decisionRow('String', _kOk, 'Native UTF-8; size-bound by the platform.'),
              _decisionRow('Uint8List', _kOk, 'Bytes pass through unmodified — useful for blobs.'),
              _decisionRow('List<dynamic>', _kOk,
                  'Allowed if every element is itself restoration-friendly.'),
              _decisionRow('Map<String,dynamic>', _kOk,
                  'Keys must be Strings; values must be restoration-friendly.'),
              _decisionRow('DateTime', _kWarn,
                  'Convert to ISO-8601 String or millisecondsSinceEpoch int.'),
              _decisionRow('Enum', _kWarn,
                  'Store .index as int; rebuild on read with Enum.values[i].'),
              _decisionRow('Offset / Size / Rect', _kWarn,
                  'Decompose into List<double> manually or via a RestorableValue.'),
              _decisionRow('Color', _kWarn,
                  'Store .value (int) and re-construct on read.'),
              _decisionRow('Function / Closure', _kBad,
                  'Not codec-friendly. Store an identifier and look the function up.'),
              _decisionRow('Future / Stream', _kBad,
                  'Live objects cannot be serialised. Persist their result instead.'),
              _decisionRow('Widget / Element', _kBad,
                  'Never. Rebuild the widget from primitive inputs.'),
              _decisionRow('Image / ui.Image', _kBad,
                  'Far too large; persist a URL or asset key.'),
            ],
          ),
        ),
        _calloutBox(
          'Rule of thumb',
          'If you can describe the value in a sentence to another human without using '
          'Dart-specific vocabulary, it is probably restoration-friendly. If you reach '
          'for words like "live", "running", or "stream", it is not.',
          _kAccentC,
          Icons.rule_rounded,
        ),
      ],
    ),
  );
}

DataRow _decisionRow(String type, Color status, String note) {
  return DataRow(
    cells: <DataCell>[
      DataCell(
        Text(
          type,
          style: const TextStyle(
            color: _kInk,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: status.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(color: status.withValues(alpha: 0.6)),
          ),
          child: Text(
            status == _kOk
                ? 'yes'
                : status == _kWarn
                    ? 'convert'
                    : 'no',
            style: TextStyle(
              color: status,
              fontWeight: FontWeight.w800,
              fontSize: 11.0,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      DataCell(
        SizedBox(
          width: 280.0,
          child: Text(
            note,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ),
    ],
  );
}

// =====================================================================
// Section 7 — Channel + storage palette
// =====================================================================

Widget _channelSection() {
  return _sectionShell(
    tag: 'CHANNEL',
    title: 'flutter/restoration — the platform contract',
    subtitle:
        'A single MethodChannel with two methods: put (framework → engine) and get (engine → framework).',
    gradient: _gradChannel,
    glow: _kAccentD,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'Every flutter app already has the flutter/restoration channel wired up — '
          'the engine sets it up at startup. The framework calls put with a fresh '
          'payload whenever the manager decides to flush, and the engine answers get '
          'with the most recent payload when the framework asks for it. The channel '
          'uses StandardMethodCodec, so arguments and return values are limited to '
          'codec-friendly types only.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _chip('flutter/restoration', _kAccentA),
            _chip('put', _kAccentB),
            _chip('get', _kAccentC),
            _chip('StandardMethodCodec', _kAccentD),
            _chip('binaryMessenger', _kAccentE),
            _chip('SharedPreferences', _kAccentF),
            _chip('NSUserDefaults', _kAccentG),
            _chip('FlutterEngine.restoreData', _kAccentH),
            _chip('isolate cold-start', _kAccentA),
            _chip('payload <= 0.5 MB', _kWarn),
            _chip('async', _kAccentC),
            _chip('idempotent puts', _kAccentB),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kBgDeep,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kCardEdge),
            boxShadow: _cardShadows(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Storage backends per platform',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Android   →  Bundle from onSaveInstanceState, mirrored to SharedPreferences\n'
                'iOS       →  UIStateRestoration API + NSCoder archives\n'
                'macOS     →  NSUserDefaults under the app domain\n'
                'Windows   →  win32 registry / userdata json (embedder defined)\n'
                'Linux     →  ~/.config/<app>/restoration.bin\n'
                'Web       →  history.state JSON serialisation (browser sandbox)',
                style: TextStyle(
                  color: _kInkSoft,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        _calloutBox(
          'Encryption is not built in',
          'Restoration data is stored in plain text in the embedder\'s native preferences. '
          'Treat it as recoverable hints, never as secrets. If a value would embarrass the '
          'user if leaked, encrypt it yourself before writing, or store only a reference.',
          _kBad,
          Icons.lock_open_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 8 — Callbacks and typedefs
// =====================================================================

Widget _callbackSection(bool needsRestore, void Function() onToggle) {
  return _sectionShell(
    tag: 'CALLBACK',
    title: 'RestorationCallback — bridging widget and bucket',
    subtitle: 'void Function(bool needsRestore) — invoked on attach and on platform replay.',
    gradient: _gradCallback,
    glow: _kAccentD,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'RestorationMixin participants receive a single signal that drives all their '
          'restoration work: the boolean parameter needsRestore. When false, the widget '
          'is being attached fresh — no prior state exists in the bucket and the widget '
          'should write its initial values. When true, the bucket already contains a '
          'payload from a previous run, and the widget should read those values, '
          'reconstruct its state, and avoid clobbering them with defaults.',
        ),
        const SizedBox(height: 12.0),
        _codeCard(
          'typedef',
          'typedef RestorationCallback = void Function(bool needsRestore);\n\n'
          'void onRestore(bool needsRestore) {\n'
          '  if (needsRestore) {\n'
          '    final int tab = bucket!.read<int>("tab") ?? 0;\n'
          '    setState(() => _index = tab);\n'
          '  } else {\n'
          '    bucket!.write<int>("tab", _index);\n'
          '  }\n'
          '}',
          _kAccentD,
        ),
        const SizedBox(height: 12.0),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter scopedSet) {
            return Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: _kBgDeep,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _kCardEdge),
                boxShadow: _cardShadows(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Interactive callback simulation',
                    style: TextStyle(
                      color: _kInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: needsRestore
                              ? _kAccentF.withValues(alpha: 0.18)
                              : _kAccentE.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999.0),
                          border: Border.all(
                            color: needsRestore ? _kAccentF : _kAccentE,
                          ),
                        ),
                        child: Text(
                          needsRestore
                              ? 'needsRestore = true  →  hydrate'
                              : 'needsRestore = false  →  initialise',
                          style: TextStyle(
                            color: needsRestore ? _kAccentF : _kAccentE,
                            fontWeight: FontWeight.w800,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () {
                          onToggle();
                          scopedSet(() {});
                        },
                        icon: const Icon(Icons.swap_horiz_rounded, size: 16.0),
                        label: const Text('toggle'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _kAccentD,
                          side: const BorderSide(color: _kAccentD),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    needsRestore
                        ? '→ widget reads "tab" from bucket and applies via setState.'
                        : '→ widget writes its current "tab" value into the bucket.',
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 12.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 9 — Reference card (API table)
// =====================================================================

Widget _referenceSection() {
  return _sectionShell(
    tag: 'REFERENCE',
    title: 'RestorationManager API surface',
    subtitle: 'Quick reference to the public methods, properties, and signals.',
    gradient: _gradReference,
    glow: _kAccentH,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _kBgDeep,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kCardEdge),
            boxShadow: _cardShadows(),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(180.0),
              1: FlexColumnWidth(),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(color: _kCardEdge.withValues(alpha: 0.6)),
            ),
            children: <TableRow>[
              _refRow('member', 'description', header: true),
              _refRow('rootBucket', 'Future for the root bucket; nullable when the platform opts out.'),
              _refRow('isReplacing', 'Whether the manager is in the middle of swapping payloads.'),
              _refRow('flushData()', 'Asks the manager to immediately serialise dirty buckets.'),
              _refRow('scheduleSerializationFor()', 'Marks a bucket dirty.'),
              _refRow('unscheduleSerializationFor()', 'Cancels a pending serialisation for a bucket.'),
              _refRow('handleRestorationUpdateFromEngine()',
                  'Engine-only entry point; called when the platform pushes fresh data.'),
              _refRow('addListener(VoidCallback)', 'Inherited from ChangeNotifier.'),
              _refRow('removeListener(VoidCallback)', 'Inherited from ChangeNotifier.'),
              _refRow('notifyListeners()', 'Inherited from ChangeNotifier; protected.'),
              _refRow('debugRootBucketAccessed', 'Test hook indicating whether the root was touched.'),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _prose(
          'The surface is intentionally small. Most apps will never call any of these '
          'methods directly — they will either use the RestorationMixin in their stateful '
          'widgets or one of the prebuilt restorable properties (RestorableInt, '
          'RestorableTextEditingController, RestorableEnum, etc.). The mixin handles '
          'claim, release, and the needsRestore plumbing on the widget\'s behalf.',
        ),
        _calloutBox(
          'Debug tip',
          'Set debugRootBucketAccessed to inspect whether your test environment is '
          'actually reaching for the root bucket. Tests that rebuild widgets with new '
          'restoration scopes occasionally race the rootBucket Future, and this flag is '
          'the easiest way to detect that.',
          _kAccentH,
          Icons.bug_report_rounded,
        ),
      ],
    ),
  );
}

TableRow _refRow(String a, String b, {bool header = false}) {
  return TableRow(
    decoration: BoxDecoration(
      color: header ? _kBgMid : null,
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Text(
          a,
          style: TextStyle(
            color: header ? _kAccentH : _kInk,
            fontFamily: 'monospace',
            fontWeight: header ? FontWeight.w800 : FontWeight.w700,
            fontSize: header ? 11.0 : 12.0,
            letterSpacing: header ? 0.8 : 0.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Text(
          b,
          style: TextStyle(
            color: header ? _kAccentH : _kInkSoft,
            fontWeight: header ? FontWeight.w800 : FontWeight.w500,
            fontSize: header ? 11.0 : 12.0,
            height: 1.4,
            letterSpacing: header ? 0.8 : 0.0,
          ),
        ),
      ),
    ],
  );
}

// =====================================================================
// Section 10 — Palette of related concepts
// =====================================================================

Widget _paletteSection() {
  return _sectionShell(
    tag: 'CONCEPTS',
    title: 'Method-channel & restoration concept palette',
    subtitle: 'Adjacent ideas worth keeping in your head while reading this page.',
    gradient: _gradPalette,
    glow: _kAccentE,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'Restoration sits in a neighbourhood of patterns that all share the same '
          'plumbing — a platform channel, a codec, and an embedder-managed store. '
          'Recognising the neighbours helps you tell whether a problem belongs in '
          'restoration or one of its cousins.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _chip('MethodChannel', _kAccentA),
            _chip('BasicMessageChannel', _kAccentB),
            _chip('EventChannel', _kAccentC),
            _chip('StandardMessageCodec', _kAccentD),
            _chip('JSONMessageCodec', _kAccentE),
            _chip('StringCodec', _kAccentF),
            _chip('BinaryMessenger', _kAccentG),
            _chip('PlatformDispatcher', _kAccentH),
            _chip('ServicesBinding', _kAccentA),
            _chip('RestorationMixin', _kAccentB),
            _chip('RestorableProperty', _kAccentC),
            _chip('RestorableInt', _kAccentD),
            _chip('RestorableDouble', _kAccentE),
            _chip('RestorableBool', _kAccentF),
            _chip('RestorableString', _kAccentG),
            _chip('RestorableEnum', _kAccentH),
            _chip('RestorableDateTime', _kAccentA),
            _chip('RestorableTextEditingController', _kAccentB),
            _chip('RestorableRouteFuture', _kAccentC),
            _chip('RootRestorationScope', _kAccentD),
            _chip('UnmanagedRestorationScope', _kAccentE),
            _chip('PrimitiveRestorableProperty', _kAccentF),
            _chip('finalize()', _kAccentG),
            _chip('claimChild()', _kAccentH),
            _chip('adoptChild()', _kAccentA),
            _chip('rename()', _kAccentB),
            _chip('debugRootBucketAccessed', _kAccentC),
            _chip('rootBucket', _kAccentD),
            _chip('flushData', _kAccentE),
            _chip('binaryMessenger', _kAccentF),
          ],
        ),
        _calloutBox(
          'Not the same as state management',
          'Riverpod, Provider, Redux, Bloc — none of these are alternatives to restoration. '
          'They live one layer above and decide where state lives. Restoration is the '
          'cold-start crash protection underneath, and it is happy to coexist with any of '
          'them as long as you teach them how to read and write a bucket.',
          _kAccentE,
          Icons.info_outline_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 11 — Sanity checks (formerly the stub's print statements)
// =====================================================================

Widget _checksSection() {
  return _sectionShell(
    tag: 'CHECKS',
    title: 'Static sanity calls',
    subtitle: 'A few cheap reads that exercise the classes named in the test target.',
    gradient: _gradManager,
    glow: _kAccentF,
    body: Builder(
      builder: (BuildContext context) {
        // Touch the symbols at build time so the test corpus exercises them.
        void restorationCallback(bool needsRestore) {
          print('RestorationCallback invoked with needsRestore: $needsRestore');
        }

        restorationCallback(true);
        restorationCallback(false);

        final PlatformMenu platformMenu = PlatformMenu(
          label: 'File',
          menus: <PlatformMenuItem>[
            PlatformMenuItem(
              label: 'New',
              onSelected: () {
                print('New selected');
              },
            ),
            PlatformMenuItem(
              label: 'Open',
              onSelected: () {
                print('Open selected');
              },
            ),
          ],
        );

        final PlatformMenuItemGroup menuGroup = PlatformMenuItemGroup(
          members: <PlatformMenuItem>[
            PlatformMenuItem(
              label: 'Cut',
              onSelected: () {
                print('Cut selected');
              },
            ),
            PlatformMenuItem(
              label: 'Copy',
              onSelected: () {
                print('Copy selected');
              },
            ),
            PlatformMenuItem(
              label: 'Paste',
              onSelected: () {
                print('Paste selected');
              },
            ),
          ],
        );

        final PlatformProvidedMenuItem aboutItem = PlatformProvidedMenuItem(
          type: PlatformProvidedMenuItemType.about,
        );
        final PlatformProvidedMenuItem quitItem = PlatformProvidedMenuItem(
          type: PlatformProvidedMenuItemType.quit,
        );

        print('PlatformMenu label: ${platformMenu.label}');
        print('PlatformMenu menus count: ${platformMenu.menus.length}');
        print('PlatformMenuItemGroup members: ${menuGroup.members.length}');
        print('PlatformProvidedMenuItem about: ${aboutItem.type}');
        print('PlatformProvidedMenuItem quit: ${quitItem.type}');

        // Foundation usage so the import is meaningful.
        if (kDebugMode) {
          print('Debug mode active during restoration demo build.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _prose(
              'These touches keep the test corpus exercising the public symbols the '
              'AST scanner expects — PlatformMenu, PlatformMenuItemGroup, '
              'PlatformProvidedMenuItem — while the rest of this file focuses on the '
              'restoration story. Each call below prints a tiny breadcrumb so the test '
              'output stays self-describing.',
            ),
            const SizedBox(height: 10.0),
            _kvRow('PlatformMenu', '${platformMenu.label} · ${platformMenu.menus.length} items',
                accent: _kAccentA),
            _kvRow('PlatformMenuItemGroup', '${menuGroup.members.length} members',
                accent: _kAccentB),
            _kvRow('PlatformProvidedMenuItem.about', '${aboutItem.type}', accent: _kAccentC),
            _kvRow('PlatformProvidedMenuItem.quit', '${quitItem.type}', accent: _kAccentD),
            _kvRow('RestorationCallback typedef', 'void Function(bool)', accent: _kAccentE),
            _kvRow('Manager symbol', 'ServicesBinding.instance.restorationManager',
                accent: _kAccentF),
          ],
        );
      },
    ),
  );
}

// =====================================================================
// Section 12 — Closing summary
// =====================================================================

Widget _closingSection() {
  return _sectionShell(
    tag: 'SUMMARY',
    title: 'When in doubt, prefer simpler primitives',
    subtitle: 'A short summary of the trade-offs you implicitly accept by opting into restoration.',
    gradient: _gradHero,
    glow: _kAccentG,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _prose(
          'Restoration is a cooperative, opt-in, asynchronous, platform-mediated, '
          'codec-bound, size-limited persistence layer. Each adjective matters. '
          'Cooperative because every participant must voluntarily claim a bucket. '
          'Opt-in because Flutter does not enable restoration unless your top-level '
          'MaterialApp gives it a restorationScopeId. Asynchronous because rootBucket '
          'is a Future. Platform-mediated because the OS, not the framework, decides '
          'when to call you. Codec-bound because only StandardMessageCodec primitives '
          'make it through. Size-limited because the embedder will silently truncate '
          'or drop oversize payloads. If your feature can live with all six, restoration '
          'is the right tool. Otherwise you want a database, a network round-trip, or '
          'a state-management library.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _chip('cooperative', _kAccentA),
            _chip('opt-in', _kAccentB),
            _chip('asynchronous', _kAccentC),
            _chip('platform-mediated', _kAccentD),
            _chip('codec-bound', _kAccentE),
            _chip('size-limited', _kAccentF),
          ],
        ),
        _calloutBox(
          'Pair with tests',
          'TestRestorationManager from package:flutter/widgets.dart is the friend you '
          'want — it lets you simulate a cold-start cycle in a single test, which is '
          'usually faster than reasoning about whether your widget is correctly hooked '
          'into the framework\'s mixin.',
          _kAccentG,
          Icons.check_circle_outline_rounded,
        ),
      ],
    ),
  );
}

// =====================================================================
// Build entrypoint
// =====================================================================

dynamic build(BuildContext context) {
  print('restoration_platform_test deep demo build()');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Restoration · Platform Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBgDeep,
      colorScheme: const ColorScheme.dark(
        primary: _kAccentA,
        secondary: _kAccentB,
        surface: _kBgMid,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: StatefulBuilder(
            builder: (BuildContext ctx, StateSetter setLocal) {
              int highlight = 0;
              bool needsRestore = false;
              return StatefulBuilder(
                builder: (BuildContext ctx2, StateSetter setInner) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _heroSection(),
                      _managerSection(),
                      _bucketSection(),
                      _pipelineSection(
                        highlight,
                        (int i) {
                          setInner(() {
                            highlight = i;
                          });
                        },
                      ),
                      _payloadSection(),
                      _decisionSection(),
                      _channelSection(),
                      _callbackSection(
                        needsRestore,
                        () {
                          setInner(() {
                            needsRestore = !needsRestore;
                          });
                        },
                      ),
                      _referenceSection(),
                      _paletteSection(),
                      _checksSection(),
                      _closingSection(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    ),
  );
}
