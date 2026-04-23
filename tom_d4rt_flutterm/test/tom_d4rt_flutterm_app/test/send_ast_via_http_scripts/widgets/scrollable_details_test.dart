import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Scroll Direction Laboratory — a deep visual demo for ScrollableDetails.
//
// ScrollableDetails is primarily the descriptor used by 2-D scrollables
// (TwoDimensionalScrollable / TwoDimensionalScrollView) to announce which way
// a viewport grows, which physics it wants, which controller drives it and
// how the decoration clips overflow. It bundles:
//
//   * AxisDirection direction        — up / down / left / right
//   * ScrollController? controller   — optional external controller
//   * ScrollPhysics? physics         — optional physics override
//   * Clip decorationClipBehavior    — how decoration clips content
//
// The named constructors .vertical({reverse}) and .horizontal({reverse}) map
// a `reverse` boolean to a concrete AxisDirection:
//
//   vertical:    reverse=false -> down,  reverse=true -> up
//   horizontal:  reverse=false -> right, reverse=true -> left
//
// In this demo we surface that behaviour directly: we author a bunch of
// ScrollableDetails instances and then project their .direction onto a
// regular 1-D CustomScrollView via axisDirectionToAxis(...) plus a small
// reverse helper. That way every pixel on the screen traces back to a real
// ScrollableDetails value.
// -----------------------------------------------------------------------------

const Color _kPrimary = Color(0xFF0E9488);
const Color _kAccent = Color(0xFFE45C58);
const Color _kCream = Color(0xFFFAF4EC);
const Color _kCharcoal = Color(0xFF1F2430);
const Color _kSoftInk = Color(0xFF4C5464);
const Color _kPanelEdge = Color(0xFFDDD1BE);

bool _reverseFromDirection(AxisDirection d) {
  return d == AxisDirection.up || d == AxisDirection.left;
}

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollableDetails Laboratory',
    home: _Laboratory(),
  );
}

class _Laboratory extends StatefulWidget {
  const _Laboratory();

  @override
  State<_Laboratory> createState() => _LaboratoryState();
}

class _LaboratoryState extends State<_Laboratory> {
  AxisDirection _liveDir = AxisDirection.down;
  final ScrollController _liveController = ScrollController();

  @override
  void dispose() {
    _liveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ------------------------------------------------------------------
    // Shared palette used by the numbered tile grids further down. Pulled
    // out only because the same 20-colour list is reused four times across
    // the axis cards; the rest of the tree is authored in-line.
    // ------------------------------------------------------------------
    final List<Color> tileColors = <Color>[
      const Color(0xFF0E9488),
      const Color(0xFF14B8A6),
      const Color(0xFF2DD4BF),
      const Color(0xFF5EEAD4),
      const Color(0xFF99F6E4),
      const Color(0xFFE45C58),
      const Color(0xFFF87171),
      const Color(0xFFFB923C),
      const Color(0xFFFBBF24),
      const Color(0xFF84CC16),
      const Color(0xFF22C55E),
      const Color(0xFF10B981),
      const Color(0xFF06B6D4),
      const Color(0xFF0EA5E9),
      const Color(0xFF3B82F6),
      const Color(0xFF6366F1),
      const Color(0xFF8B5CF6),
      const Color(0xFFA855F7),
      const Color(0xFFD946EF),
      const Color(0xFFEC4899),
    ];

    return Scaffold(
      backgroundColor: _kCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // =========================================================
              // 1. HERO HEADER
              // =========================================================
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF0E9488),
                      Color(0xFF14B8A6),
                      Color(0xFFE45C58),
                    ],
                    stops: <double>[0.0, 0.55, 1.0],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              'widget laboratory · section 01',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'ScrollableDetails Laboratory',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'axis · reverse · physics · controller · clip',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Axis-cross icon: four arrows pointing out from centre.
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 2. FOUR AXIS-DIRECTION CARDS  (2 x 2 Wrap)
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '02 · Four axis directions',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  'Each card builds a ScrollableDetails with a different '
                  'AxisDirection and projects .direction onto a CustomScrollView.',
                  style: TextStyle(color: _kSoftInk, fontSize: 13),
                ),
              ),

              LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
                  final double cardWidth =
                      (constraints.maxWidth - 16) / 2;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: <Widget>[
                      // -------- DOWN --------
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: _kPrimary,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'AxisDirection.down',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails(
                                      direction: AxisDirection.down,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Content flows top-to-bottom. Tile 0 is at '
                                  'the top of the viewport.',
                                  style: TextStyle(
                                    color: _kSoftInk,
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // -------- UP --------
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: _kAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'AxisDirection.up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails(
                                      direction: AxisDirection.up,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Reversed vertical axis. Tile 0 sits at the '
                                  'bottom; scrolling up reveals larger indices.',
                                  style: TextStyle(
                                    color: _kSoftInk,
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // -------- RIGHT --------
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'AxisDirection.right',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails(
                                      direction: AxisDirection.right,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Horizontal growth. Tile 0 is on the left; '
                                  'swipe/drag left to reveal later tiles.',
                                  style: TextStyle(
                                    color: _kSoftInk,
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // -------- LEFT --------
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF8B5CF6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'AxisDirection.left',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails(
                                      direction: AxisDirection.left,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Reversed horizontal axis. Tile 0 is on the '
                                  'right; reading order mirrors RTL locales.',
                                  style: TextStyle(
                                    color: _kSoftInk,
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 3. VERTICAL / HORIZONTAL NAMED CONSTRUCTORS
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '03 · Named constructors',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  '.vertical(reverse: true) derives AxisDirection.up, '
                  '.horizontal(reverse: true) derives AxisDirection.left.',
                  style: TextStyle(color: _kSoftInk, fontSize: 13),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
                  final double cardWidth =
                      (constraints.maxWidth - 16) / 2;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: <Widget>[
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: _kPrimary.withValues(alpha: 0.9),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  '.vertical(reverse: true)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails.vertical(
                                      reverse: true,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _kCream,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: _kPanelEdge),
                                  ),
                                  child: const Text(
                                    'ScrollableDetails.vertical(reverse: true)\n'
                                    '   → direction: AxisDirection.up',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      height: 1.4,
                                      color: _kCharcoal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _kPanelEdge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: _kAccent.withValues(alpha: 0.9),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  '.horizontal(reverse: true)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: Builder(
                                  builder: (BuildContext c) {
                                    const ScrollableDetails details =
                                        ScrollableDetails.horizontal(
                                      reverse: true,
                                    );
                                    return _buildNumberedScrollable(
                                      details,
                                      tileColors,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _kCream,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: _kPanelEdge),
                                  ),
                                  child: const Text(
                                    'ScrollableDetails.horizontal(reverse: true)\n'
                                    '   → direction: AxisDirection.left',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      height: 1.4,
                                      color: _kCharcoal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 4. LIVE AXIS SWITCHER
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '04 · Live axis switcher',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  'Pick an AxisDirection; the viewport rebuilds with a '
                  'fresh ScrollableDetails and prints its diagnostics.',
                  style: TextStyle(color: _kSoftInk, fontSize: 13),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _kPanelEdge),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // --- Segmented selector ---
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SegmentedButton<AxisDirection>(
                        segments: const <ButtonSegment<AxisDirection>>[
                          ButtonSegment<AxisDirection>(
                            value: AxisDirection.down,
                            label: Text('down'),
                            icon: Icon(Icons.arrow_downward),
                          ),
                          ButtonSegment<AxisDirection>(
                            value: AxisDirection.up,
                            label: Text('up'),
                            icon: Icon(Icons.arrow_upward),
                          ),
                          ButtonSegment<AxisDirection>(
                            value: AxisDirection.right,
                            label: Text('right'),
                            icon: Icon(Icons.arrow_forward),
                          ),
                          ButtonSegment<AxisDirection>(
                            value: AxisDirection.left,
                            label: Text('left'),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ],
                        selected: <AxisDirection>{_liveDir},
                        onSelectionChanged: (Set<AxisDirection> s) {
                          setState(() {
                            _liveDir = s.first;
                            debugPrint(
                              'Live axis switched -> ${_liveDir.name}',
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    // --- Live viewport + diagnostics side by side ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: _kCream,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _kPanelEdge),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Builder(
                                builder: (BuildContext c) {
                                  final ScrollableDetails details =
                                      ScrollableDetails(
                                    direction: _liveDir,
                                    controller: _liveController,
                                    physics:
                                        const BouncingScrollPhysics(),
                                    decorationClipBehavior: Clip.hardEdge,
                                  );
                                  return _buildNumberedScrollable(
                                    details,
                                    tileColors,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _kCharcoal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                height: 1.5,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'ScrollableDetails',
                                    style: TextStyle(
                                      color: Color(0xFF5EEAD4),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('direction: ${_liveDir.name}'),
                                  Text(
                                    'reverse:   '
                                    '${_reverseFromDirection(_liveDir)}',
                                  ),
                                  const Text(
                                    'clip:      Clip.hardEdge',
                                  ),
                                  const Text(
                                    'physics:   BouncingScrollPhysics',
                                  ),
                                  Text(
                                    'ctrl.hash: '
                                    '${_liveController.hashCode.toRadixString(16)}',
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 1,
                                    color: Colors.white
                                        .withValues(alpha: 0.15),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'axisDirectionToAxis(...)\n'
                                    '  = ${axisDirectionToAxis(_liveDir).name}',
                                    style: const TextStyle(
                                      color: Color(0xFFFBBF24),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 5. CLIP BEHAVIOUR DEMO  (Clip.none / hardEdge / antiAlias)
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '05 · decorationClipBehavior',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  'Three scrollables whose content overflows their decoration; '
                  'the three Clip values shape how that overflow is painted.',
                  style: TextStyle(color: _kSoftInk, fontSize: 13),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Clip.none
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF87171),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Clip.none',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 140,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.right,
                                  decorationClipBehavior: Clip.none,
                                );
                                return _buildOversizedScrollable(details);
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'No clipping — painted content can bleed.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Clip.hardEdge
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF14B8A6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Clip.hardEdge',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 140,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.right,
                                  decorationClipBehavior: Clip.hardEdge,
                                );
                                return _buildOversizedScrollable(details);
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Rectangular pixel clip — cheap and crisp.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Clip.antiAlias
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF8B5CF6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Clip.antiAlias',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 140,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.right,
                                  decorationClipBehavior: Clip.antiAlias,
                                );
                                return _buildOversizedScrollable(details);
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Smoothed edges — more costly, prettier corners.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 6. PHYSICS VARIATIONS
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '06 · physics',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  'Same list three times; the ScrollableDetails.physics slot '
                  'swaps the overscroll behaviour.',
                  style: TextStyle(color: _kSoftInk, fontSize: 13),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // NeverScrollable
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF6366F1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'NeverScrollableScrollPhysics',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.down,
                                  physics:
                                      NeverScrollableScrollPhysics(),
                                );
                                return _buildNumberedScrollable(
                                  details,
                                  tileColors,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Scroll rejected — viewport locked.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bouncing
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE45C58),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'BouncingScrollPhysics',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.down,
                                  physics: BouncingScrollPhysics(),
                                );
                                return _buildNumberedScrollable(
                                  details,
                                  tileColors,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'iOS-style spring overscroll.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Clamping
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0E9488),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'ClampingScrollPhysics',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: Builder(
                              builder: (BuildContext c) {
                                const ScrollableDetails details =
                                    ScrollableDetails(
                                  direction: AxisDirection.down,
                                  physics: ClampingScrollPhysics(),
                                );
                                return _buildNumberedScrollable(
                                  details,
                                  tileColors,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Android-style glow clamp.',
                              style: TextStyle(
                                color: _kSoftInk,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 7. TEACHING PANEL
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '07 · When · Why · Gotchas',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.schedule,
                                color: _kPrimary,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'When',
                                style: TextStyle(
                                  color: _kCharcoal,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Reach for ScrollableDetails when authoring a '
                            'TwoDimensionalScrollable/View or when a widget '
                            'API explicitly asks for one per axis.',
                            style: TextStyle(
                              color: _kSoftInk,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.lightbulb_outline,
                                color: _kAccent,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Why',
                                style: TextStyle(
                                  color: _kCharcoal,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'It groups everything a viewport needs to know '
                            'about one axis into one value: direction, '
                            'physics, controller, decoration clip.',
                            style: TextStyle(
                              color: _kSoftInk,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kPanelEdge),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.warning_amber,
                                color: Color(0xFFFBBF24),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Gotchas',
                                style: TextStyle(
                                  color: _kCharcoal,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'The named constructors only set direction+reverse '
                            'derivation — they still accept physics/controller '
                            'if you pass them explicitly.',
                            style: TextStyle(
                              color: _kSoftInk,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kCharcoal,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.55,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '// canonical construction',
                        style: TextStyle(color: Color(0xFF94A3B8)),
                      ),
                      Text('ScrollableDetails('),
                      Text('  direction: AxisDirection.right,'),
                      Text('  reverse: false,'),
                      Text('  controller: _controller,'),
                      Text('  physics: const BouncingScrollPhysics(),'),
                      Text('  decorationClipBehavior: Clip.hardEdge,'),
                      Text(')'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 8. CONSTRUCTOR REFERENCE TABLE
              // =========================================================
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  '08 · Field reference',
                  style: TextStyle(
                    color: _kCharcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kPanelEdge),
                ),
                child: Column(
                  children: <Widget>[
                    // Header row
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              'field',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'type',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'default',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'description',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _fieldRow(
                      'direction',
                      'AxisDirection',
                      'required',
                      'Primary growth direction of the viewport.',
                      even: true,
                    ),
                    _fieldRow(
                      'reverse',
                      'bool (derived)',
                      'false',
                      'Named constructors derive this from the axis direction.',
                    ),
                    _fieldRow(
                      'controller',
                      'ScrollController?',
                      'null',
                      'Optional external controller for offset inspection.',
                      even: true,
                    ),
                    _fieldRow(
                      'physics',
                      'ScrollPhysics?',
                      'null',
                      'Overrides the ambient platform physics.',
                    ),
                    _fieldRow(
                      'decorationClipBehavior',
                      'Clip',
                      'Clip.hardEdge',
                      'How viewport decoration clips overflowing children.',
                      even: true,
                      last: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // 9. FOOTER SUMMARY
              // =========================================================
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFF0E9488),
                      Color(0xFF14B8A6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Laboratory complete',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Eight sections: hero header, four AxisDirection '
                            'cards, named-constructor demos, live switcher, '
                            'clip behaviour, physics variations, teaching '
                            'panel, field reference.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'tom_d4rt_flutterm · ScrollableDetails · visual demo',
                  style: TextStyle(
                    color: _kSoftInk,
                    fontSize: 11,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Helpers — tiny by design. The per-section widget trees live inline above.
// -----------------------------------------------------------------------------

Widget _buildNumberedScrollable(
  ScrollableDetails details,
  List<Color> palette,
) {
  final Axis axis = axisDirectionToAxis(details.direction);
  final bool reverse = _reverseFromDirection(details.direction);
  return CustomScrollView(
    scrollDirection: axis,
    reverse: reverse,
    controller: details.controller,
    physics: details.physics,
    clipBehavior: details.decorationClipBehavior ?? Clip.hardEdge,
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext c, int i) {
              final Color color = palette[i % palette.length];
              if (axis == Axis.horizontal) {
                return Container(
                  width: 52,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$i',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }
              return Container(
                height: 36,
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'tile $i',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            childCount: 18,
          ),
        ),
      ),
    ],
  );
}

Widget _buildOversizedScrollable(ScrollableDetails details) {
  final Axis axis = axisDirectionToAxis(details.direction);
  final bool reverse = _reverseFromDirection(details.direction);
  return CustomScrollView(
    scrollDirection: axis,
    reverse: reverse,
    controller: details.controller,
    physics: details.physics,
    clipBehavior: details.decorationClipBehavior ?? Clip.hardEdge,
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: SizedBox(
          width: 900,
          height: 200,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFFFBBF24),
                        Color(0xFFE45C58),
                        Color(0xFF8B5CF6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 40,
                child: Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'overflow A',
                    style: TextStyle(
                      color: _kCharcoal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 420,
                top: 80,
                child: Container(
                  width: 140,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'overflow B',
                    style: TextStyle(
                      color: _kCharcoal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 720,
                top: 30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(70),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'overflow C',
                    style: TextStyle(
                      color: _kCharcoal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _fieldRow(
  String field,
  String type,
  String def,
  String description, {
  bool even = false,
  bool last = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: even ? _kCream : Colors.white,
      borderRadius: last
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            )
          : null,
      border: Border(
        bottom: BorderSide(
          color: last ? Colors.transparent : _kPanelEdge,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            field,
            style: const TextStyle(
              color: _kCharcoal,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: const TextStyle(
              color: _kPrimary,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            def,
            style: const TextStyle(
              color: _kAccent,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            description,
            style: const TextStyle(
              color: _kSoftInk,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
