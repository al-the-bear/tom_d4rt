// D4rt test script: Deep Visual Demo — SliverChildDelegate (The Delegate Foundry)
//
// SliverChildDelegate is the abstract base class used by sliver widgets
// (SliverList, SliverGrid, etc.) to produce their children. Flutter ships
// two concrete subclasses:
//   * SliverChildBuilderDelegate — lazy, builder-callback based, ideal for
//     huge or unbounded lists where only visible items should be materialised.
//   * SliverChildListDelegate — eager, wraps a pre-built List<Widget>, suitable
//     when all children are cheap and known up front.
// You may also subclass SliverChildDelegate directly to implement bespoke
// construction policies (paging, instrumentation, virtualised sources, etc.).
//
// This deep demo builds a single-screen "Delegate Foundry" that compares the
// three flavours side by side, with live build counters that prove whether
// the delegate materialises children lazily or eagerly. The custom
// _LoggingChildDelegate subclass demonstrates the full override surface:
// build, estimatedChildCount, didFinishLayout, shouldRebuild.
//
// Palette: forge orange (#EA580C), iron grey (#3F3F46), cream (#FEF7ED).

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ============================================================================
// PALETTE CONSTANTS
// ============================================================================

const Color _kForgeOrange = Color(0xFFEA580C);
const Color _kForgeOrangeDeep = Color(0xFFC2410C);
const Color _kForgeOrangeLight = Color(0xFFFB923C);
const Color _kIronGrey = Color(0xFF3F3F46);
const Color _kIronGreyDeep = Color(0xFF27272A);
const Color _kIronGreyLight = Color(0xFF71717A);
const Color _kCream = Color(0xFFFEF7ED);
const Color _kCreamDeep = Color(0xFFFDE4CB);
const Color _kMolten = Color(0xFFFFA94D);
const Color _kEmber = Color(0xFFB91C1C);

// ============================================================================
// ENTRYPOINT (d4rt AST harness — no main / no runApp)
// ============================================================================

dynamic build(BuildContext context) {
  debugPrint('SliverChildDelegate — Delegate Foundry deep demo starting');

  // Build counters for the three delegates. These are wrapped in
  // ValueNotifiers so the counter headers rebuild as the scroll view
  // materialises children.
  final ValueNotifier<int> builderBuildCount = ValueNotifier<int>(0);
  final ValueNotifier<int> listBuildCount = ValueNotifier<int>(0);
  final ValueNotifier<int> customBuildCount = ValueNotifier<int>(0);
  final ValueNotifier<String> customLog =
      ValueNotifier<String>('custom delegate — log awaiting first build');

  debugPrint('Counters initialised: builder, list, custom, log sink');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliverChildDelegate — Delegate Foundry',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _kCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kForgeOrange,
        primary: _kForgeOrange,
        secondary: _kIronGrey,
        surface: _kCream,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: _kIronGreyDeep,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          color: _kIronGreyDeep,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: _kIronGreyDeep,
        ),
        bodyMedium: TextStyle(color: _kIronGrey),
        bodySmall: TextStyle(color: _kIronGreyLight),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: _kIronGreyDeep,
        foregroundColor: _kCream,
        elevation: 0,
        title: const Text(
          'SliverChildDelegate — Delegate Foundry',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _kForgeOrange,
                  _kMolten,
                  _kEmber,
                ],
              ),
            ),
          ),
        ),
      ),
      body: _FoundryBody(
        builderBuildCount: builderBuildCount,
        listBuildCount: listBuildCount,
        customBuildCount: customBuildCount,
        customLog: customLog,
      ),
    ),
  );
}

// ============================================================================
// ROOT BODY — stitches every scene together
// ============================================================================

class _FoundryBody extends StatelessWidget {
  const _FoundryBody({
    required this.builderBuildCount,
    required this.listBuildCount,
    required this.customBuildCount,
    required this.customLog,
  });

  final ValueNotifier<int> builderBuildCount;
  final ValueNotifier<int> listBuildCount;
  final ValueNotifier<int> customBuildCount;
  final ValueNotifier<String> customLog;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      children: <Widget>[
        const _FoundryHero(),
        const SizedBox(height: 24),
        _SectionHeader(
          index: 1,
          title: 'Builder delegate — lazy molten pour',
          subtitle:
              'SliverChildBuilderDelegate builds children on demand as the '
              'viewport scrolls over them. childCount is a hint, not a '
              'commitment.',
        ),
        const SizedBox(height: 12),
        _BuilderDelegateScene(counter: builderBuildCount),
        const SizedBox(height: 28),
        _SectionHeader(
          index: 2,
          title: 'List delegate — eager ingot stack',
          subtitle:
              'SliverChildListDelegate wraps a pre-built List<Widget>. Every '
              'child is constructed before the first frame of the sliver.',
        ),
        const SizedBox(height: 12),
        _ListDelegateScene(counter: listBuildCount),
        const SizedBox(height: 28),
        _SectionHeader(
          index: 3,
          title: 'Custom delegate — hand-forged subclass',
          subtitle:
              'A direct subclass of SliverChildDelegate that logs every '
              'build, reports estimatedChildCount, and hooks didFinishLayout.',
        ),
        const SizedBox(height: 12),
        _CustomDelegateScene(
          counter: customBuildCount,
          log: customLog,
        ),
        const SizedBox(height: 28),
        _SectionHeader(
          index: 4,
          title: 'Decision table — which delegate, when?',
          subtitle:
              'Choose between builder / list / custom based on child count, '
              'stability, and instrumentation needs.',
        ),
        const SizedBox(height: 12),
        const _DecisionTable(),
        const SizedBox(height: 28),
        _SectionHeader(
          index: 5,
          title: 'Field reference — the full override surface',
          subtitle:
              'Every member you can override when subclassing '
              'SliverChildDelegate directly.',
        ),
        const SizedBox(height: 12),
        const _FieldReferenceTable(),
        const SizedBox(height: 28),
        _SectionHeader(
          index: 6,
          title: 'Instructional panels — wrapping policies',
          subtitle:
              'How the concrete delegates wrap children in AutomaticKeepAlive, '
              'RepaintBoundary, and IndexedSemantics.',
        ),
        const SizedBox(height: 12),
        const _WrappingPolicyPanels(),
        const SizedBox(height: 28),
        const _Footer(),
      ],
    );
  }
}

// ============================================================================
// HERO — CustomPainter foundry diagram
// ============================================================================

class _FoundryHero extends StatelessWidget {
  const _FoundryHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _kIronGreyDeep,
            _kIronGrey,
            _kForgeOrangeDeep,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kForgeOrange.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: _FoundryPainter(),
              ),
            ),
            const Positioned(
              left: 20,
              top: 18,
              right: 20,
              child: Text(
                'THE DELEGATE FOUNDRY',
                style: TextStyle(
                  color: _kCream,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 3,
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 40,
              right: 20,
              child: Text(
                'SliverChildDelegate',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 18,
              right: 20,
              child: Text(
                'molten widgets → funnel → SliverList render tree',
                style: TextStyle(
                  color: _kCream.withValues(alpha: 0.85),
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoundryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Background furnace glow (radial pool behind the crucible).
    final Paint glow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _kMolten.withValues(alpha: 0.55),
          _kForgeOrangeDeep.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(w * 0.28, h * 0.55),
        radius: w * 0.35,
      ));
    canvas.drawCircle(Offset(w * 0.28, h * 0.55), w * 0.35, glow);

    // Crucible on the left — pouring molten widgets.
    final Paint ironStroke = Paint()
      ..color = _kIronGreyDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Path crucible = Path();
    crucible.moveTo(w * 0.10, h * 0.35);
    crucible.lineTo(w * 0.30, h * 0.35);
    crucible.lineTo(w * 0.28, h * 0.70);
    crucible.lineTo(w * 0.12, h * 0.70);
    crucible.close();
    final Paint crucibleFill = Paint()..color = _kIronGrey;
    canvas.drawPath(crucible, crucibleFill);
    canvas.drawPath(crucible, ironStroke);

    // Molten surface.
    final Paint molten = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kForgeOrangeLight, _kEmber],
      ).createShader(Rect.fromLTWH(w * 0.12, h * 0.33, w * 0.18, 10));
    canvas.drawOval(
      Rect.fromLTWH(w * 0.12, h * 0.33, w * 0.18, 10),
      molten,
    );

    // Pouring stream.
    final Path stream = Path();
    stream.moveTo(w * 0.30, h * 0.55);
    stream.quadraticBezierTo(w * 0.38, h * 0.62, w * 0.45, h * 0.72);
    stream.lineTo(w * 0.50, h * 0.78);
    stream.lineTo(w * 0.48, h * 0.80);
    stream.lineTo(w * 0.43, h * 0.74);
    stream.quadraticBezierTo(w * 0.36, h * 0.64, w * 0.28, h * 0.57);
    stream.close();
    final Paint streamPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kMolten, _kForgeOrangeDeep],
      ).createShader(Rect.fromLTWH(w * 0.28, h * 0.55, w * 0.22, h * 0.25));
    canvas.drawPath(stream, streamPaint);

    // Funnel (SliverList) receiving the pour.
    final Path funnel = Path();
    funnel.moveTo(w * 0.46, h * 0.75);
    funnel.lineTo(w * 0.74, h * 0.75);
    funnel.lineTo(w * 0.64, h * 0.90);
    funnel.lineTo(w * 0.56, h * 0.90);
    funnel.close();
    final Paint funnelFill = Paint()..color = _kIronGreyLight;
    canvas.drawPath(funnel, funnelFill);
    canvas.drawPath(funnel, ironStroke);

    // Nodes representing widget children that fell through the funnel.
    for (int i = 0; i < 5; i++) {
      final double x = w * 0.80 + (i % 3) * 18;
      final double y = h * 0.35 + (i ~/ 3) * 40 + i * 14;
      final Paint nodeFill = Paint()
        ..color = i.isEven ? _kForgeOrange : _kCreamDeep;
      final Paint nodeStroke = Paint()
        ..color = _kIronGreyDeep
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      final RRect node = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, 40, 24),
        const Radius.circular(4),
      );
      canvas.drawRRect(node, nodeFill);
      canvas.drawRRect(node, nodeStroke);
    }

    // Label: BUILDER
    _paintLabel(
      canvas,
      'BUILDER',
      Offset(w * 0.20, h * 0.26),
      _kCream,
      fontWeight: FontWeight.w800,
    );

    // Label: LIST
    _paintLabel(
      canvas,
      'LIST',
      Offset(w * 0.60, h * 0.72),
      _kCream,
      fontWeight: FontWeight.w800,
    );

    // Label: CUSTOM
    _paintLabel(
      canvas,
      'CUSTOM',
      Offset(w * 0.86, h * 0.28),
      _kCream,
      fontWeight: FontWeight.w800,
    );

    // Horizontal arrow connecting crucible to funnel.
    final Paint arrow = Paint()
      ..color = _kCream.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(w * 0.33, h * 0.48),
      Offset(w * 0.46, h * 0.78),
      arrow,
    );
  }

  void _paintLabel(
    Canvas canvas,
    String text,
    Offset pos,
    Color color, {
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SHARED SECTION HEADER
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_kForgeOrange, _kForgeOrangeDeep],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kForgeOrange.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
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
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: _kIronGreyDeep,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: _kIronGreyLight,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// BUILDER-DELEGATE DEMO — SliverChildBuilderDelegate (lazy, childCount=10000)
// ============================================================================

class _BuilderDelegateScene extends StatelessWidget {
  const _BuilderDelegateScene({required this.counter});

  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kForgeOrange.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIronGreyDeep.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _CounterHeader(
            title: 'SliverChildBuilderDelegate',
            description: 'childCount: 10 000 — only visible items materialise',
            counter: counter,
            accent: _kForgeOrange,
          ),
          SizedBox(
            height: 260,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        counter.value += 1;
                        return _BuilderDelegateCard(index: index);
                      },
                      childCount: 10000,
                      addAutomaticKeepAlives: true,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const _LazyBanner(),
        ],
      ),
    );
  }
}

class _BuilderDelegateCard extends StatelessWidget {
  const _BuilderDelegateCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    // Index-based color — hue rotates through orange/iron/cream families.
    final double hue = (index * 17) % 360;
    final HSLColor hsl = HSLColor.fromAHSL(1.0, hue, 0.45, 0.62);
    final Color tint = hsl.toColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: tint.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lazy child $index',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kIronGreyDeep,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'built on demand via SliverChildBuilderDelegate',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kIronGreyLight.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.flash_on,
            color: tint,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _LazyBanner extends StatelessWidget {
  const _LazyBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kForgeOrange.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(color: _kForgeOrange.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.lightbulb, color: _kForgeOrange, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Even though childCount reports 10 000, only visible indices '
              'invoke the builder — scroll to watch the counter climb.',
              style: TextStyle(
                fontSize: 11.5,
                color: _kIronGrey.withValues(alpha: 0.9),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// LIST-DELEGATE DEMO — SliverChildListDelegate (eager, 50 cards)
// ============================================================================

class _ListDelegateScene extends StatelessWidget {
  const _ListDelegateScene({required this.counter});

  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    // Eagerly construct all 50 cards and increment the counter during
    // construction. This proves the list delegate materialises everything
    // before the sliver ever paints.
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < 50; i++) {
      counter.value += 1;
      children.add(_ListDelegateCard(index: i));
    }
    debugPrint(
      'SliverChildListDelegate — constructed ${children.length} widgets eagerly',
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kIronGrey.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIronGreyDeep.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _CounterHeader(
            title: 'SliverChildListDelegate',
            description: '50 pre-built cards — all constructed eagerly',
            counter: counter,
            accent: _kIronGrey,
          ),
          SizedBox(
            height: 260,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      children,
                      addAutomaticKeepAlives: true,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const _EagerBanner(),
        ],
      ),
    );
  }
}

class _ListDelegateCard extends StatelessWidget {
  const _ListDelegateCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final double t = index / 50.0;
    final Color tint = Color.lerp(_kIronGreyLight, _kIronGreyDeep, t)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: tint.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Eager child $index',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kIronGreyDeep,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'constructed up front by SliverChildListDelegate',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kIronGreyLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.anchor,
            color: _kIronGrey,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _EagerBanner extends StatelessWidget {
  const _EagerBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kIronGrey.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(color: _kIronGrey.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Icon(Icons.warning_amber, color: _kIronGrey, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'The counter already reads 50 on the first frame — every card '
              'was materialised before the viewport laid out a single pixel.',
              style: TextStyle(
                fontSize: 11.5,
                color: _kIronGrey,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CUSTOM DELEGATE — hand-rolled SliverChildDelegate subclass
// ============================================================================

class _CustomDelegateScene extends StatelessWidget {
  const _CustomDelegateScene({
    required this.counter,
    required this.log,
  });

  final ValueNotifier<int> counter;
  final ValueNotifier<String> log;

  @override
  Widget build(BuildContext context) {
    final _LoggingChildDelegate delegate = _LoggingChildDelegate(
      childCount: 20,
      onBuild: (int index) {
        counter.value += 1;
        log.value = 'build(index=$index) → build count ${counter.value}';
      },
      onFinishLayout: (int first, int last) {
        log.value = 'didFinishLayout(firstIndex=$first, lastIndex=$last)';
      },
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kEmber.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIronGreyDeep.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _CounterHeader(
            title: '_LoggingChildDelegate extends SliverChildDelegate',
            description:
                'Implements build, estimatedChildCount, didFinishLayout, '
                'shouldRebuild',
            counter: counter,
            accent: _kEmber,
          ),
          SizedBox(
            height: 240,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(delegate: delegate),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<String>(
            valueListenable: log,
            builder: (BuildContext context, String value, Widget? _) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: _kIronGreyDeep,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.terminal,
                      color: _kForgeOrangeLight,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _kCream,
                          fontFamily: 'monospace',
                          height: 1.35,
                        ),
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
}

class _CustomDelegateCard extends StatelessWidget {
  const _CustomDelegateCard({required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    // Computed colour: rotate through a triangular wave so adjacent cards
    // differ visibly but the palette stays forge-flavoured.
    final double phase = (index / math.max(1, total)) * math.pi * 2;
    final double red = 0.5 + 0.5 * math.sin(phase);
    final double blue = 0.5 + 0.5 * math.cos(phase * 0.5);
    final Color tint = Color.fromRGBO(
      (234 * red).clamp(0, 255).round() + 10,
      (88 + 40 * (1 - red)).clamp(0, 255).round(),
      (12 + 40 * blue).clamp(0, 255).round(),
      1.0,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            tint.withValues(alpha: 0.18),
            tint.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: tint.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Custom child $index of $total',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kIronGreyDeep,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'produced by _LoggingChildDelegate.build(context, index)',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kIronGreyLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.construction,
            color: _kEmber,
            size: 18,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _LoggingChildDelegate — a direct SliverChildDelegate subclass.
// Implements the full override surface recommended by the Flutter docs:
//   * build(BuildContext, int)                (required abstract)
//   * shouldRebuild(SliverChildDelegate)      (required abstract)
//   * estimatedChildCount                     (optional, defaults to null)
//   * didFinishLayout(int, int)               (optional, defaults to no-op)
// ---------------------------------------------------------------------------

class _LoggingChildDelegate extends SliverChildDelegate {
  _LoggingChildDelegate({
    required this.childCount,
    required this.onBuild,
    required this.onFinishLayout,
  });

  final int childCount;
  final void Function(int index) onBuild;
  final void Function(int first, int last) onFinishLayout;

  @override
  Widget? build(BuildContext context, int index) {
    if (index < 0 || index >= childCount) {
      return null;
    }
    onBuild(index);
    debugPrint('_LoggingChildDelegate.build(index=$index)');
    // Hand-wire the conveniences that the concrete delegates offer by default.
    // A real custom delegate would usually conditionally wrap based on flags.
    return RepaintBoundary(
      child: IndexedSemantics(
        index: index,
        child: _CustomDelegateCard(index: index, total: childCount),
      ),
    );
  }

  @override
  int get estimatedChildCount => childCount;

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    onFinishLayout(firstIndex, lastIndex);
    debugPrint(
      '_LoggingChildDelegate.didFinishLayout(first=$firstIndex, last=$lastIndex)',
    );
  }

  @override
  bool shouldRebuild(covariant _LoggingChildDelegate oldDelegate) {
    // Rebuild if the reported child count changes.
    return oldDelegate.childCount != childCount;
  }

  @override
  double? estimateMaxScrollOffset(
    int firstIndex,
    int lastIndex,
    double leadingScrollOffset,
    double trailingScrollOffset,
  ) {
    // Let the framework extrapolate — our children are uniform height but
    // we don't short-circuit the default, to show how an override would hook in.
    return null;
  }

  @override
  int? findIndexByKey(Key key) {
    // No key-based lookup supported — return null to fall back on positional
    // matching. Override this in reorderable data sources.
    return null;
  }
}

// ============================================================================
// COUNTER HEADER — shared widget for each scene
// ============================================================================

class _CounterHeader extends StatelessWidget {
  const _CounterHeader({
    required this.title,
    required this.description,
    required this.counter,
    required this.accent,
  });

  final String title;
  final String description;
  final ValueNotifier<int> counter;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(color: accent.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: accent == _kIronGrey ? _kIronGreyDeep : accent,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: _kIronGrey.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<int>(
            valueListenable: counter,
            builder: (BuildContext context, int value, Widget? _) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'builds: $value',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// DECISION TABLE — scenario / recommended / reason / gotcha
// ============================================================================

class _DecisionTable extends StatelessWidget {
  const _DecisionTable();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> rows = <Map<String, String>>[
      <String, String>{
        'scenario': 'Unbounded feed, millions of rows',
        'recommended': 'SliverChildBuilderDelegate',
        'reason': 'Lazy builder only materialises visible indices.',
        'gotcha':
            'childCount can be null for truly infinite lists — builder must '
            'return null past the end.',
      },
      <String, String>{
        'scenario': 'Large but bounded list (10k items)',
        'recommended': 'SliverChildBuilderDelegate',
        'reason': 'Provide childCount so scroll metrics are exact.',
        'gotcha':
            'Reading async data inside the builder forces a rebuild on every '
            'recycle — prefer pre-computed state.',
      },
      <String, String>{
        'scenario': 'Short static list (< 50 items)',
        'recommended': 'SliverChildListDelegate',
        'reason':
            'Eager construction cost is negligible, no builder indirection.',
        'gotcha':
            'Still eager — if any single child is expensive, switch back to '
            'the builder delegate.',
      },
      <String, String>{
        'scenario': 'Heterogeneous sections w/ headers',
        'recommended': 'SliverChildBuilderDelegate with switch',
        'reason':
            'Single delegate can branch on index into header/item/footer.',
        'gotcha':
            'Semantic indexing may need a semanticIndexCallback to skip '
            'decorative rows.',
      },
      <String, String>{
        'scenario': 'Instrumented telemetry, paging, tracing',
        'recommended': 'Custom SliverChildDelegate subclass',
        'reason':
            'didFinishLayout + build give hooks the concrete delegates lack.',
        'gotcha':
            'You must reimplement AutomaticKeepAlive / RepaintBoundary / '
            'IndexedSemantics wrapping yourself.',
      },
      <String, String>{
        'scenario': 'Reorderable content with stable keys',
        'recommended': 'SliverChildBuilderDelegate',
        'reason':
            'findChildIndexCallback preserves element identity across moves.',
        'gotcha':
            'Children must carry keys that survive reorder — ValueKey on a '
            'domain id, not on the index.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kIronGrey.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: _kIronGreyDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 3,
                  child: _HeaderCell(text: 'Scenario'),
                ),
                Expanded(
                  flex: 2,
                  child: _HeaderCell(text: 'Recommended'),
                ),
                Expanded(
                  flex: 3,
                  child: _HeaderCell(text: 'Reason'),
                ),
                Expanded(
                  flex: 3,
                  child: _HeaderCell(text: 'Gotcha'),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven
                    ? _kCream.withValues(alpha: 0.5)
                    : Colors.white,
                border: Border(
                  bottom: i == rows.length - 1
                      ? BorderSide.none
                      : BorderSide(
                          color: _kIronGrey.withValues(alpha: 0.08),
                        ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: _BodyCell(
                      text: rows[i]['scenario']!,
                      weight: FontWeight.w700,
                      color: _kIronGreyDeep,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _BodyCell(
                      text: rows[i]['recommended']!,
                      color: _kForgeOrangeDeep,
                      weight: FontWeight.w700,
                      monospace: true,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _BodyCell(
                      text: rows[i]['reason']!,
                      color: _kIronGrey,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _BodyCell(
                      text: rows[i]['gotcha']!,
                      color: _kEmber,
                      italic: true,
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

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: _kCream,
          fontWeight: FontWeight.w800,
          fontSize: 12,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell({
    required this.text,
    this.color = _kIronGrey,
    this.weight = FontWeight.w500,
    this.italic = false,
    this.monospace = false,
  });

  final String text;
  final Color color;
  final FontWeight weight;
  final bool italic;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: weight,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontFamily: monospace ? 'monospace' : null,
          fontSize: 12,
          height: 1.35,
        ),
      ),
    );
  }
}

// ============================================================================
// FIELD REFERENCE TABLE — every override on SliverChildDelegate
// ============================================================================

class _FieldReferenceTable extends StatelessWidget {
  const _FieldReferenceTable();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> fields = <Map<String, String>>[
      <String, String>{
        'name': 'build(BuildContext, int)',
        'kind': 'abstract',
        'returns': 'Widget?',
        'purpose':
            'Return the child for the given index, or null past the end.',
      },
      <String, String>{
        'name': 'shouldRebuild(SliverChildDelegate)',
        'kind': 'abstract',
        'returns': 'bool',
        'purpose':
            'True when a new delegate represents different information than '
            'the previous one.',
      },
      <String, String>{
        'name': 'estimatedChildCount',
        'kind': 'getter',
        'returns': 'int?',
        'purpose':
            'Upper-bound count. May be null for truly unbounded streams. '
            'Must be exact once build returns null.',
      },
      <String, String>{
        'name': 'estimateMaxScrollOffset(...)',
        'kind': 'method',
        'returns': 'double?',
        'purpose':
            'Custom max scroll extent hint — default null lets the framework '
            'extrapolate.',
      },
      <String, String>{
        'name': 'didFinishLayout(first, last)',
        'kind': 'method',
        'returns': 'void',
        'purpose':
            'Hook invoked at layout end with the visible index range. Useful '
            'for analytics and viewport tracking.',
      },
      <String, String>{
        'name': 'findIndexByKey(Key)',
        'kind': 'method',
        'returns': 'int?',
        'purpose':
            'Locate a child by key so the element tree survives reorders '
            'without state loss.',
      },
      <String, String>{
        'name': 'debugFillDescription(...)',
        'kind': 'method',
        'returns': 'void',
        'purpose':
            'Override to add extra fields to the default toString()/inspector '
            'description.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kIronGrey.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: _kForgeOrangeDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(flex: 4, child: _HeaderCell(text: 'Member')),
                Expanded(flex: 2, child: _HeaderCell(text: 'Kind')),
                Expanded(flex: 2, child: _HeaderCell(text: 'Returns')),
                Expanded(flex: 5, child: _HeaderCell(text: 'Purpose')),
              ],
            ),
          ),
          for (int i = 0; i < fields.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven
                    ? _kCream.withValues(alpha: 0.4)
                    : Colors.white,
                border: Border(
                  bottom: i == fields.length - 1
                      ? BorderSide.none
                      : BorderSide(
                          color: _kIronGrey.withValues(alpha: 0.08),
                        ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: _BodyCell(
                      text: fields[i]['name']!,
                      monospace: true,
                      color: _kIronGreyDeep,
                      weight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _KindBadge(kind: fields[i]['kind']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: _BodyCell(
                      text: fields[i]['returns']!,
                      monospace: true,
                      color: _kForgeOrangeDeep,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: _BodyCell(
                      text: fields[i]['purpose']!,
                      color: _kIronGrey,
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

class _KindBadge extends StatelessWidget {
  const _KindBadge({required this.kind});

  final String kind;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (kind) {
      case 'abstract':
        bg = _kEmber.withValues(alpha: 0.15);
        fg = _kEmber;
        break;
      case 'getter':
        bg = _kForgeOrange.withValues(alpha: 0.15);
        fg = _kForgeOrangeDeep;
        break;
      default:
        bg = _kIronGrey.withValues(alpha: 0.12);
        fg = _kIronGreyDeep;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            kind,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
              letterSpacing: 1.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// INSTRUCTIONAL PANELS — wrapping flags on the concrete delegates
// ============================================================================

class _WrappingPolicyPanels extends StatelessWidget {
  const _WrappingPolicyPanels();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _PolicyPanel(
          icon: Icons.memory,
          title: 'addAutomaticKeepAlives',
          body:
              'When true (the default), children are wrapped in an '
              'AutomaticKeepAlive so they can call KeepAliveNotification and '
              'remain cached across scroll-off. Disable if your children are '
              'cheap to rebuild — you save a wrapper element per child.',
          bullets: <String>[
            'Default: true on SliverChildBuilderDelegate and SliverChildListDelegate',
            'Honours KeepAliveNotification bubbling from descendants',
            'Custom delegates must wrap manually — it is NOT automatic',
          ],
        ),
        SizedBox(height: 10),
        _PolicyPanel(
          icon: Icons.brush,
          title: 'addRepaintBoundaries',
          body:
              'Wraps each child in a RepaintBoundary so a child that animates '
              'or redraws does not invalidate neighbours. Disable only if '
              'the children are always static or already cheap to paint.',
          bullets: <String>[
            'Default: true — usually a pure win for scroll performance',
            'Inserts a separate layer per child → higher GPU memory cost',
            'Skip for ultra-light rows (icons, single-line text)',
          ],
        ),
        SizedBox(height: 10),
        _PolicyPanel(
          icon: Icons.accessibility,
          title: 'addSemanticIndexes',
          body:
              'Wraps each child in IndexedSemantics so accessibility trees see '
              'a stable ordering. Combine with semanticIndexCallback when the '
              'list mixes content and decorations (separators, headers).',
          bullets: <String>[
            'Default: true — required for correct VoiceOver / TalkBack order',
            'semanticIndexOffset lets multiple delegates share a scroll view',
            'Custom delegates must add IndexedSemantics themselves',
          ],
        ),
      ],
    );
  }
}

class _PolicyPanel extends StatelessWidget {
  const _PolicyPanel({
    required this.icon,
    required this.title,
    required this.body,
    required this.bullets,
  });

  final IconData icon;
  final String title;
  final String body;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kForgeOrange.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIronGreyDeep.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kForgeOrange.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _kForgeOrangeDeep, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: _kIronGreyDeep,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kIronGrey,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                for (final String bullet in bullets)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 4, right: 6),
                          child: Icon(
                            Icons.fiber_manual_record,
                            size: 7,
                            color: _kForgeOrange,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            bullet,
                            style: const TextStyle(
                              fontSize: 12,
                              color: _kIronGreyDeep,
                              height: 1.35,
                            ),
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
}

// ============================================================================
// FOOTER
// ============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kIronGreyDeep, _kIronGrey],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _kForgeOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.verified,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Delegate Foundry — demo complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'You have seen lazy (builder), eager (list), and hand-forged '
                  '(custom) delegates compared in a single CustomScrollView per '
                  'scene. Pick the strategy that matches your data shape.',
                  style: TextStyle(
                    color: _kCream,
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
