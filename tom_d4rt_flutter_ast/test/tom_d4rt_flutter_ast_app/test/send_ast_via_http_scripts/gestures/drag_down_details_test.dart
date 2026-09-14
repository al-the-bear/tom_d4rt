// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// DragDownDetails — Deep Visual Demo
// -----------------------------------------------------------------------------
// DragDownDetails is the immutable record handed to GestureDragDownCallback,
// i.e. the onPanDown / onVerticalDragDown / onHorizontalDragDown callback of a
// GestureDetector. It is the "finger has just landed and a drag MAY begin"
// snapshot. It carries:
//   * globalPosition : Offset  — where the pointer touched, in screen coords.
//   * localPosition  : Offset  — where the pointer touched, in widget coords
//                                (defaults to globalPosition if omitted).
//
// Unlike its siblings, DragDownDetails does NOT expose a `kind` field — pointer
// kind is reported on DragStartDetails. It does NOT carry velocity (that is
// DragEndDetails) and it does NOT carry delta (that is DragUpdateDetails). It
// is the very first beat of the drag chain:
//   onDown  →  onStart  →  onUpdate*  →  onEnd.
// =============================================================================

// A small const data record for sample finger positions used in the demo grid.
// Declared at file scope so it can be const-instantiated; it has zero behaviour.
class _Sample {
  final String label;
  final String story;
  final Offset global;
  final Offset local;
  final String? kindLabel;
  final Color hue;
  final IconData icon;
  const _Sample({
    required this.label,
    required this.story,
    required this.global,
    required this.local,
    required this.hue,
    required this.icon,
    this.kindLabel,
  });
}

// A const data record for sibling-types comparison.
class _SiblingCard {
  final String type;
  final List<String> fields;
  final String unique;
  final Color tint;
  final IconData icon;
  const _SiblingCard({
    required this.type,
    required this.fields,
    required this.unique,
    required this.tint,
    required this.icon,
  });
}

// A const data record for the gesture-chain flow boxes.
class _ChainBox {
  final String callback;
  final String detailsType;
  final String summary;
  final Color color;
  final bool highlighted;
  const _ChainBox({
    required this.callback,
    required this.detailsType,
    required this.summary,
    required this.color,
    this.highlighted = false,
  });
}

dynamic build(BuildContext context) {
  print('================================================================');
  print('=== DragDownDetails: deep visual demo — build() executing      =');
  print('================================================================');

  // -------------------------------------------------------------------------
  // 1. Construct ten+ DragDownDetails instances spanning all flavours.
  // -------------------------------------------------------------------------
  final ddTopLeft = DragDownDetails(
    globalPosition: const Offset(12, 18),
    localPosition: const Offset(4, 6),
  );
  final ddCenter = DragDownDetails(
    globalPosition: const Offset(180, 200),
    localPosition: const Offset(60, 40),
  );
  final ddBottomRight = DragDownDetails(
    globalPosition: const Offset(420, 880),
    localPosition: const Offset(118, 56),
  );
  final ddDefaultLocal = DragDownDetails(
    globalPosition: const Offset(256, 384),
  );
  final ddFarFromOrigin = DragDownDetails(
    globalPosition: const Offset(1024, 768),
    localPosition: const Offset(8, 12),
  );
  final ddMouseLike = DragDownDetails(
    globalPosition: const Offset(330, 220),
    localPosition: const Offset(50, 30),
  );
  final ddStylusLike = DragDownDetails(
    globalPosition: const Offset(212, 145),
    localPosition: const Offset(72, 18),
  );
  final ddTouchLike = DragDownDetails(
    globalPosition: const Offset(96, 412),
    localPosition: const Offset(96, 28),
  );
  final ddOriginLanding = DragDownDetails(
    globalPosition: const Offset(0, 0),
    localPosition: const Offset(0, 0),
  );
  final ddDeepNested = DragDownDetails(
    globalPosition: const Offset(640, 360),
    localPosition: const Offset(120, 60),
  );

  print('=== Section 1: instances built ===');
  print('  ddTopLeft       global=${ddTopLeft.globalPosition} local=${ddTopLeft.localPosition}');
  print('  ddCenter        global=${ddCenter.globalPosition} local=${ddCenter.localPosition}');
  print('  ddBottomRight   global=${ddBottomRight.globalPosition} local=${ddBottomRight.localPosition}');
  print('  ddDefaultLocal  global=${ddDefaultLocal.globalPosition} local=${ddDefaultLocal.localPosition}');
  print('  ddFarFromOrigin delta=${ddFarFromOrigin.globalPosition - ddFarFromOrigin.localPosition}');
  print('  ddMouseLike     global=${ddMouseLike.globalPosition}');
  print('  ddStylusLike    global=${ddStylusLike.globalPosition}');
  print('  ddTouchLike     global=${ddTouchLike.globalPosition}');
  print('  ddOriginLanding global=${ddOriginLanding.globalPosition}');
  print('  ddDeepNested    global=${ddDeepNested.globalPosition}');
  print('  toString(ddCenter) -> ${ddCenter.toString()}');

  // -------------------------------------------------------------------------
  // 2. Assemble the demo tree.
  // -------------------------------------------------------------------------
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------------------------------------------------------
        // SECTION 1 — Hero / title card
        // ---------------------------------------------------------------
        _heroCard(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 2 — Anatomy diagram
        // ---------------------------------------------------------------
        _anatomyDiagram(ddCenter),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 3 — Constructor signatures
        // ---------------------------------------------------------------
        _constructorSignatures(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 4 — Sample instances grid
        // ---------------------------------------------------------------
        _samplesGrid(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 5 — Where it fits in the gesture chain
        // ---------------------------------------------------------------
        _gestureChain(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 6 — Live-looking interactive scaffolds (static previews)
        // ---------------------------------------------------------------
        _livePreviews(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 7 — Sibling Details type comparison
        // ---------------------------------------------------------------
        _siblingComparison(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 8 — Real-world recipes
        // ---------------------------------------------------------------
        _recipes(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 9 — Coordinate translation cheat-sheet
        // ---------------------------------------------------------------
        _coordinateCheatsheet(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 10 — Pitfalls / FAQ
        // ---------------------------------------------------------------
        _pitfallsFaq(),

        const SizedBox(height: 28),

        // ---------------------------------------------------------------
        // SECTION 11 — Footer
        // ---------------------------------------------------------------
        _footer(),

        const SizedBox(height: 40),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero / title card
// =============================================================================
Widget _heroCard() {
  print('=== Section 1: hero card ===');
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 32, 28, 36),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A0B2E),
          Color(0xFF3C1A78),
          Color(0xFF6F1AB6),
          Color(0xFFB13BFF),
        ],
        stops: [0.0, 0.45, 0.8, 1.0],
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66B13BFF),
          blurRadius: 36,
          spreadRadius: 2,
          offset: Offset(0, 18),
        ),
        BoxShadow(
          color: Color(0x331A0B2E),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [Color(0xFFFFE8FF), Color(0x33FFFFFF)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x88FFFFFF),
                    blurRadius: 24,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.touch_app_rounded,
                size: 38,
                color: Color(0xFF3C1A78),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      color: Color(0xCCFFE8FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'DragDownDetails',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0x55FFFFFF), width: 1),
              ),
              child: const Text(
                'IMMUTABLE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'A small immutable record passed to GestureDragDownCallback — the very first '
          'beat of a drag chain. It captures where the finger landed, both in screen '
          'coordinates and inside the receiving widget. Use it to stamp the start of a '
          'drag, hit-test sub-elements, or branch behaviour by pointer kind. Velocity '
          'and deltas live elsewhere — this record is purely about "you are here".',
          style: TextStyle(
            color: Color(0xEEFFFFFF),
            fontSize: 14.5,
            height: 1.55,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _HeroPill(label: 'globalPosition : Offset', tint: Color(0xFFFF6BCB)),
            _HeroPill(label: 'localPosition : Offset', tint: Color(0xFF6BC4FF)),
            _HeroPill(label: 'with Diagnosticable', tint: Color(0xFFFFD56B)),
          ],
        ),
      ],
    ),
  );
}

class _HeroPill extends StatelessWidget {
  final String label;
  final Color tint;
  const _HeroPill({required this.label, required this.tint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withOpacity(0.6), width: 1.4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tint,
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Anatomy diagram
// =============================================================================
Widget _anatomyDiagram(DragDownDetails sample) {
  print('=== Section 2: anatomy diagram ===');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF6FBFF), Color(0xFFE2F1FF)],
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFBFDDFF), width: 1.2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A1F77D2),
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '02',
          title: 'Anatomy',
          subtitle: 'Where globalPosition and localPosition come from',
          accent: const Color(0xFF1F77D2),
        ),
        const SizedBox(height: 20),
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD7E8FA), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x111F77D2),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // The "screen" outer frame.
              Positioned(
                left: 16,
                top: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFAFCFF), Color(0xFFEFF6FF)],
                    ),
                    border: Border.all(
                      color: const Color(0xFF1F77D2),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'SCREEN VIEWPORT  (0, 0)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F77D2),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // The "widget rect" inner frame.
              Positioned(
                left: 110,
                top: 90,
                width: 220,
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFF1F8), Color(0xFFFFE0EF)],
                    ),
                    border: Border.all(
                      color: const Color(0xFFE91E63),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'WIDGET RECT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE91E63),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Dashed line from screen-origin to finger.
              const Positioned(
                left: 16,
                top: 16,
                child: _Dashed(width: 220, height: 2, color: Color(0xFF1F77D2)),
              ),
              const Positioned(
                left: 234,
                top: 16,
                child: _Dashed(width: 2, height: 152, color: Color(0xFF1F77D2)),
              ),
              // Dashed line from widget-origin to finger.
              const Positioned(
                left: 110,
                top: 90,
                child: _Dashed(width: 124, height: 2, color: Color(0xFFE91E63)),
              ),
              const Positioned(
                left: 234,
                top: 90,
                child: _Dashed(width: 2, height: 78, color: Color(0xFFE91E63)),
              ),
              // The "finger" dot.
              Positioned(
                left: 224,
                top: 158,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFFB13BFF)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x88B13BFF),
                        blurRadius: 14,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
              const Positioned(
                left: 250,
                top: 162,
                child: Text(
                  'finger landed here',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6F1AB6),
                  ),
                ),
              ),
              // Labels.
              Positioned(
                left: 30,
                top: 24,
                child: _LabelChip(
                  text: 'globalPosition = ${sample.globalPosition.dx.toStringAsFixed(0)}, ${sample.globalPosition.dy.toStringAsFixed(0)}',
                  color: const Color(0xFF1F77D2),
                ),
              ),
              Positioned(
                left: 124,
                top: 96,
                child: _LabelChip(
                  text: 'localPosition = ${sample.localPosition.dx.toStringAsFixed(0)}, ${sample.localPosition.dy.toStringAsFixed(0)}',
                  color: const Color(0xFFE91E63),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _LegendDot(color: Color(0xFF1F77D2), text: 'screen-relative — globalPosition'),
            _LegendDot(color: Color(0xFFE91E63), text: 'widget-relative — localPosition'),
            _LegendDot(color: Color(0xFFB13BFF), text: 'pointer landing'),
          ],
        ),
      ],
    ),
  );
}

class _Dashed extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const _Dashed({required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    final isHorizontal = width > height;
    final segments = isHorizontal ? (width ~/ 6) : (height ~/ 6);
    return SizedBox(
      width: width,
      height: height,
      child: Flex(
        direction: isHorizontal ? Axis.horizontal : Axis.vertical,
        children: List<Widget>.generate(segments, (i) {
          return Container(
            width: isHorizontal ? 4 : width,
            height: isHorizontal ? height : 4,
            margin: EdgeInsets.only(
              right: isHorizontal ? 2 : 0,
              bottom: isHorizontal ? 0 : 2,
            ),
            color: i.isEven ? color : Colors.transparent,
          );
        }),
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  final String text;
  final Color color;
  const _LabelChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendDot({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 3 — Constructor signatures
// =============================================================================
Widget _constructorSignatures() {
  print('=== Section 3: constructor signatures ===');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF062B36), Color(0xFF0E4A5E)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x440E4A5E),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '03',
          title: 'Constructor',
          subtitle: 'Two ways to summon a DragDownDetails',
          accent: const Color(0xFF14B8A6),
          onDarkBackground: true,
        ),
        const SizedBox(height: 18),
        const _CodeBlock(
          title: 'Default localPosition',
          code: 'DragDownDetails(\n'
              '  globalPosition: Offset(180, 200),\n'
              ')\n'
              '// localPosition defaults to globalPosition',
          accent: Color(0xFF14B8A6),
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          title: 'Explicit localPosition',
          code: 'DragDownDetails(\n'
              '  globalPosition: Offset(420, 880),\n'
              '  localPosition: Offset(118, 56),\n'
              ')',
          accent: Color(0xFF22D3EE),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x110AFFFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0x4414B8A6), width: 1),
          ),
          child: const Text(
            'Notes:\n'
            '  • Both fields are stored as final.\n'
            '  • localPosition ?? globalPosition  — when omitted, you observe the same '
            'Offset twice. That is correct only when there is no transform between the '
            'screen and the receiving widget.\n'
            '  • Unlike DragStartDetails, DragDownDetails does NOT expose a kind field. '
            'If you need the pointer kind, read it from the subsequent DragStartDetails '
            'inside onStart.',
            style: TextStyle(
              color: Color(0xFFCFFFF7),
              fontSize: 12,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CodeBlock extends StatelessWidget {
  final String title;
  final String code;
  final Color accent;
  const _CodeBlock({required this.title, required this.code, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF02141A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFFE0F7F4),
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Sample instances grid
// =============================================================================
Widget _samplesGrid() {
  print('=== Section 4: samples grid ===');
  const samples = <_Sample>[
    _Sample(
      label: 'finger top-left',
      story: 'Pointer landed near the widget origin — local ≈ (4,6)',
      global: Offset(12, 18),
      local: Offset(4, 6),
      hue: Color(0xFFFF7043),
      icon: Icons.north_west_rounded,
    ),
    _Sample(
      label: 'finger near centre',
      story: 'Comfortable middle-of-widget tap — local ≈ (60,40)',
      global: Offset(180, 200),
      local: Offset(60, 40),
      hue: Color(0xFFAB47BC),
      icon: Icons.center_focus_strong_rounded,
    ),
    _Sample(
      label: 'finger bottom-right',
      story: 'Tap near the widget far corner — local ≈ (118,56)',
      global: Offset(420, 880),
      local: Offset(118, 56),
      hue: Color(0xFF26A69A),
      icon: Icons.south_east_rounded,
    ),
    _Sample(
      label: 'far from origin',
      story: 'Widget shifted on screen → big delta between globals/locals',
      global: Offset(1024, 768),
      local: Offset(8, 12),
      hue: Color(0xFFEF5350),
      icon: Icons.zoom_out_map_rounded,
    ),
    _Sample(
      label: 'mouse-like landing',
      story: 'No kind on DragDownDetails — read it from the next DragStartDetails',
      global: Offset(330, 220),
      local: Offset(50, 30),
      hue: Color(0xFF42A5F5),
      icon: Icons.mouse_rounded,
      kindLabel: 'see onStart',
    ),
    _Sample(
      label: 'stylus-like landing',
      story: 'Same Offset story; kind information lives on DragStartDetails',
      global: Offset(212, 145),
      local: Offset(72, 18),
      hue: Color(0xFF7E57C2),
      icon: Icons.edit_rounded,
      kindLabel: 'see onStart',
    ),
    _Sample(
      label: 'origin landing',
      story: 'Touch landed exactly at (0,0) — both Offsets are zero',
      global: Offset(0, 0),
      local: Offset(0, 0),
      hue: Color(0xFF66BB6A),
      icon: Icons.fingerprint_rounded,
    ),
    _Sample(
      label: 'deep-nested widget',
      story: 'Widget far inside layout → big delta between global and local',
      global: Offset(640, 360),
      local: Offset(120, 60),
      hue: Color(0xFF8D6E63),
      icon: Icons.layers_rounded,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF8F2), Color(0xFFFFEFE0)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFFFD3A8), width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22FF7043),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '04',
          title: 'Sample instances',
          subtitle: 'Eight different DragDownDetails values seen in the wild',
          accent: const Color(0xFFFF7043),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [for (final s in samples) _SampleCard(sample: s)],
        ),
      ],
    ),
  );
}

class _SampleCard extends StatelessWidget {
  final _Sample sample;
  const _SampleCard({required this.sample});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: sample.hue.withOpacity(0.35), width: 1),
        boxShadow: [
          BoxShadow(
            color: sample.hue.withOpacity(0.20),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      sample.hue.withOpacity(0.85),
                      sample.hue.withOpacity(0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(sample.icon, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  sample.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: sample.hue.withAlpha(0xEE),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Mini diagram.
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 6,
                  top: 6,
                  right: 6,
                  bottom: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: sample.hue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Positioned(
                  left: (sample.local.dx.clamp(0.0, 200.0) / 200.0) * 200 + 4,
                  top: (sample.local.dy.clamp(0.0, 60.0) / 60.0) * 70 + 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: sample.hue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: sample.hue.withOpacity(0.55),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'global = (${sample.global.dx.toStringAsFixed(0)}, ${sample.global.dy.toStringAsFixed(0)})',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
          Text(
            'local  = (${sample.local.dx.toStringAsFixed(0)}, ${sample.local.dy.toStringAsFixed(0)})',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
          if (sample.kindLabel != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'kind   = ${sample.kindLabel}',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: sample.hue,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            sample.story,
            style: const TextStyle(
              fontSize: 11,
              height: 1.4,
              color: Color(0xFF616161),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — Gesture chain flow diagram
// =============================================================================
Widget _gestureChain() {
  print('=== Section 5: gesture chain ===');
  const chain = <_ChainBox>[
    _ChainBox(
      callback: 'onDown',
      detailsType: 'DragDownDetails',
      summary: 'Pointer landed; possible drag begin. global+local only.',
      color: Color(0xFFE91E63),
      highlighted: true,
    ),
    _ChainBox(
      callback: 'onStart',
      detailsType: 'DragStartDetails',
      summary: 'Drag confirmed. + sourceTimeStamp + kind.',
      color: Color(0xFFFFA000),
    ),
    _ChainBox(
      callback: 'onUpdate',
      detailsType: 'DragUpdateDetails',
      summary: 'Pointer moved. + delta + primaryDelta.',
      color: Color(0xFF00ACC1),
    ),
    _ChainBox(
      callback: 'onEnd',
      detailsType: 'DragEndDetails',
      summary: 'Pointer released. velocity + primaryVelocity.',
      color: Color(0xFF8E24AA),
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFCFCFC), Color(0xFFEFEFF5)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22555555),
          blurRadius: 22,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '05',
          title: 'In the gesture chain',
          subtitle: 'onDown is where DragDownDetails arrives',
          accent: const Color(0xFFE91E63),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < chain.length; i++) ...[
                _ChainBoxWidget(box: chain[i]),
                if (i != chain.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 50),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(0xFF9E9E9E),
                      size: 28,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

class _ChainBoxWidget extends StatelessWidget {
  final _ChainBox box;
  const _ChainBoxWidget({required this.box});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            box.color.withOpacity(box.highlighted ? 0.95 : 0.85),
            box.color.withOpacity(box.highlighted ? 0.7 : 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: box.highlighted ? Colors.white : box.color.withOpacity(0.5),
          width: box.highlighted ? 3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: box.color.withOpacity(box.highlighted ? 0.6 : 0.25),
            blurRadius: box.highlighted ? 24 : 10,
            offset: const Offset(0, 6),
            spreadRadius: box.highlighted ? 1 : 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            box.callback,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              box.detailsType,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            box.summary,
            style: const TextStyle(
              color: Color(0xEEFFFFFF),
              fontSize: 11.5,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Live-looking interactive scaffolds (static previews)
// =============================================================================
Widget _livePreviews() {
  print('=== Section 6: live previews ===');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE0FFF4), Color(0xFFB6F6E0)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFF80CBC4)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x2200897B),
          blurRadius: 22,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '06',
          title: 'Static preview of onPanDown',
          subtitle: 'Imagine the user tapping these spots — see the DragDownDetails',
          accent: const Color(0xFF00897B),
        ),
        const SizedBox(height: 18),
        const _PreviewBoard(
          tapGlobal: Offset(152, 88),
          tapLocal: Offset(40, 12),
          tint: Color(0xFF00897B),
          caption: 'Top edge of widget — likely a header drag.',
        ),
        const SizedBox(height: 14),
        const _PreviewBoard(
          tapGlobal: Offset(220, 168),
          tapLocal: Offset(108, 92),
          tint: Color(0xFF7CB342),
          caption: 'Centre tap — neutral drag start, no special handle.',
        ),
        const SizedBox(height: 14),
        const _PreviewBoard(
          tapGlobal: Offset(360, 240),
          tapLocal: Offset(248, 164),
          tint: Color(0xFFEC407A),
          caption: 'Bottom-right corner — could be a resize affordance.',
        ),
      ],
    ),
  );
}

class _PreviewBoard extends StatelessWidget {
  final Offset tapGlobal;
  final Offset tapLocal;
  final Color tint;
  final String caption;
  const _PreviewBoard({
    required this.tapGlobal,
    required this.tapLocal,
    required this.tint,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tint.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: tint.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 280,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [tint.withOpacity(0.15), tint.withOpacity(0.04)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: tint, width: 1.4),
            ),
            child: Stack(
              children: [
                const Positioned(
                  left: 8,
                  top: 6,
                  child: Text(
                    'GestureDetector(onPanDown: …)',
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF455A64),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Positioned(
                  left: tapLocal.dx.clamp(0.0, 250.0),
                  top: tapLocal.dy.clamp(0.0, 150.0),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.white, tint],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: tint.withOpacity(0.7),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                Positioned(
                  left: tapLocal.dx.clamp(0.0, 250.0) + 30,
                  top: tapLocal.dy.clamp(0.0, 150.0) + 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: tint),
                    ),
                    child: Text(
                      'tap!',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: tint,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'If user tapped here:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: tint.withOpacity(0.85),
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 6),
                _kv('globalPosition', '(${tapGlobal.dx.toInt()}, ${tapGlobal.dy.toInt()})'),
                _kv('localPosition', '(${tapLocal.dx.toInt()}, ${tapLocal.dy.toInt()})'),
                _kv('Δ', '(${(tapGlobal.dx - tapLocal.dx).toInt()}, ${(tapGlobal.dy - tapLocal.dy).toInt()})'),
                const SizedBox(height: 8),
                Text(
                  caption,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF37474F),
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

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$k: ',
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: Color(0xFF607D8B),
              ),
            ),
            TextSpan(
              text: v,
              style: const TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — Sibling Details type comparison
// =============================================================================
Widget _siblingComparison() {
  print('=== Section 7: sibling comparison ===');
  const cards = <_SiblingCard>[
    _SiblingCard(
      type: 'DragDownDetails',
      fields: ['globalPosition', 'localPosition'],
      unique: '↪ first beat — pointer just landed (no kind!)',
      tint: Color(0xFFE91E63),
      icon: Icons.pan_tool_alt_rounded,
    ),
    _SiblingCard(
      type: 'DragStartDetails',
      fields: ['globalPosition', 'localPosition', 'kind', 'sourceTimeStamp'],
      unique: '↪ + sourceTimeStamp (Duration)',
      tint: Color(0xFFFFA000),
      icon: Icons.play_arrow_rounded,
    ),
    _SiblingCard(
      type: 'DragUpdateDetails',
      fields: ['globalPosition', 'localPosition', 'sourceTimeStamp', 'delta', 'primaryDelta'],
      unique: '↪ + delta + primaryDelta',
      tint: Color(0xFF00ACC1),
      icon: Icons.trending_up_rounded,
    ),
    _SiblingCard(
      type: 'DragEndDetails',
      fields: ['velocity', 'primaryVelocity', 'globalPosition', 'localPosition'],
      unique: '↪ velocity + primaryVelocity',
      tint: Color(0xFF8E24AA),
      icon: Icons.flag_rounded,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1B1F3A), Color(0xFF2C3358)],
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: const [
        BoxShadow(
          color: Color(0x441B1F3A),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '07',
          title: 'Sibling Details types',
          subtitle: 'What is unique to each step in the chain',
          accent: const Color(0xFFFFC107),
          onDarkBackground: true,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [for (final c in cards) _SiblingCardWidget(card: c)],
        ),
      ],
    ),
  );
}

class _SiblingCardWidget extends StatelessWidget {
  final _SiblingCard card;
  const _SiblingCardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [card.tint.withOpacity(0.95), card.tint.withOpacity(0.65)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: card.tint.withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(card.icon, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  card.type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final f in card.fields)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                '• $f',
                style: const TextStyle(
                  color: Color(0xEEFFFFFF),
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x44000000),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              card.unique,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Real-world recipes
// =============================================================================
Widget _recipes() {
  print('=== Section 8: recipes ===');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFF5F8), Color(0xFFFFE2EC)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFFFB6C9)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33FF6F91),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(
          number: '08',
          title: 'Real-world recipes',
          subtitle: 'How DragDownDetails shows up in actual UIs',
          accent: const Color(0xFFC2185B),
        ),
        const SizedBox(height: 20),
        const _RecipeCardGrabHandle(),
        const SizedBox(height: 14),
        const _RecipeMapPan(),
        const SizedBox(height: 14),
        const _RecipeSliderThumb(),
      ],
    ),
  );
}

class _RecipeCardGrabHandle extends StatelessWidget {
  const _RecipeCardGrabHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFC1D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22FF6F91),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // The "card with a grab handle".
          Container(
            width: 200,
            height: 110,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFC1D6), Color(0xFFFFE2EC)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF6F91)),
            ),
            child: Stack(
              children: [
                // The grab handle stripes.
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    width: 50,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F91),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Center(
                        child: Text(
                          '▤▤▤',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 12,
                  top: 38,
                  child: Text(
                    'Card title',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF880E4F),
                    ),
                  ),
                ),
                const Positioned(
                  left: 12,
                  top: 60,
                  right: 12,
                  child: Text(
                    'Drag the handle to reorder',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFAD1457),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // Marker for the finger.
                Positioned(
                  left: 28,
                  top: 12,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC2185B),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x88C2185B),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card grab handle',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'onPanDown stamps DragDownDetails when the finger lands on the '
                  'handle. localPosition tells you whether the touch fell on the '
                  'handle (small y, small x) or somewhere else on the card.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.5,
                    color: Color(0xFF880E4F),
                    fontWeight: FontWeight.w400,
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

class _RecipeMapPan extends StatelessWidget {
  const _RecipeMapPan();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFC1D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22FF6F91),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            height: 130,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFC8E6C9), Color(0xFFE8F5E9), Color(0xFFB3E5FC)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF66BB6A)),
            ),
            child: Stack(
              children: [
                // Faint grid lines.
                for (int i = 1; i < 5; i++)
                  Positioned(
                    left: i * 40.0,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 1, color: const Color(0x33335E20)),
                  ),
                for (int j = 1; j < 4; j++)
                  Positioned(
                    top: j * 32.0,
                    left: 0,
                    right: 0,
                    child: Container(height: 1, color: const Color(0x33335E20)),
                  ),
                // Pretend marker.
                const Positioned(
                  left: 64,
                  top: 50,
                  child: Icon(Icons.location_on_rounded, color: Color(0xFFD32F2F), size: 22),
                ),
                // Finger position.
                Positioned(
                  left: 130,
                  top: 80,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B5E20),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x991B5E20),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Map pan start',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'onHorizontalDragDown gives you the local coordinate inside the '
                  'map widget. Use it for hit-testing markers before deciding '
                  'whether to start a pan or instead grab a marker.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.5,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w400,
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

class _RecipeSliderThumb extends StatelessWidget {
  const _RecipeSliderThumb();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFC1D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22FF6F91),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 220,
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF8F00)),
            ),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // Track.
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB74D),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  // Thumb.
                  Positioned(
                    left: 110,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [Color(0xFFFFFFFF), Color(0xFFFF8F00)],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x88FF8F00),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Pointer.
                  Positioned(
                    left: 116,
                    top: -16,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE65100),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Slider-thumb capture',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'A custom Slider uses details.localPosition.dx to decide if the '
                  'finger landed on the thumb or merely on the track. If the touch '
                  'is within ±half-thumb-width of the thumb, capture it.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.5,
                    color: Color(0xFF6D4C41),
                    fontWeight: FontWeight.w400,
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

// =============================================================================
// SECTION 9 — Coordinate translation cheat-sheet
// =============================================================================
Widget _coordinateCheatsheet() {
  print('=== Section 9: coordinate cheat-sheet ===');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFFDE7), Color(0xFFFFF59D)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFFBC02D)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33F9A825),
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '09',
          title: 'globalPosition vs localPosition',
          subtitle: 'How the Offset gets translated under the hood',
          accent: const Color(0xFFF57F17),
        ),
        const SizedBox(height: 18),
        _cheatPara(
          'globalPosition is the screen-relative Offset of the pointer at the moment '
          'the gesture system declared "this is a possible drag". It comes from the '
          'PointerDownEvent.position field bubbling up.',
        ),
        const SizedBox(height: 10),
        _cheatPara(
          'localPosition is the same Offset, but expressed inside the receiving '
          'render box. The framework computes it via RenderBox.globalToLocal so that '
          'a tap at screen (300, 200) lands at widget-local (40, 12) when the widget '
          "itself sits at screen (260, 188).",
        ),
        const SizedBox(height: 10),
        _cheatPara(
          'When you construct a DragDownDetails by hand without a localPosition, the '
          'constructor transparently uses globalPosition. That simplifies tests but '
          'is rarely what real production code observes.',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x55263238),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            '// What the engine effectively does:\n'
            'final box = context.findRenderObject() as RenderBox;\n'
            'final local = box.globalToLocal(event.position);\n'
            'final details = DragDownDetails(\n'
            '  globalPosition: event.position,\n'
            '  localPosition: local,\n'
            '  kind: event.kind,\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFAED581),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _cheatPara(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xCCFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFFBC02D)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        height: 1.6,
        color: Color(0xFF424242),
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

// =============================================================================
// SECTION 10 — Pitfalls / FAQ
// =============================================================================
Widget _pitfallsFaq() {
  print('=== Section 10: pitfalls ===');
  const items = <({String title, String body, IconData icon, Color tint})>[
    (
      title: 'Using globalPosition for hit-testing inside a transformed widget',
      body: 'Always prefer localPosition. globalPosition ignores any Transform, '
          'rotation, scale, or scroll offset that wraps your widget.',
      icon: Icons.warning_amber_rounded,
      tint: Color(0xFFE53935),
    ),
    (
      title: 'Assuming localPosition is always (0, 0)',
      body: 'It is not. localPosition is the same Offset as globalPosition only '
          'when the widget sits flush at screen origin or you constructed the '
          'details manually without a localPosition argument.',
      icon: Icons.bug_report_rounded,
      tint: Color(0xFFFFA000),
    ),
    (
      title: 'Reaching for `kind` on DragDownDetails',
      body: 'It is not there. DragDownDetails only carries globalPosition and '
          'localPosition. Pointer kind is reported on DragStartDetails, so '
          'inspect kind inside onStart, not onDown.',
      icon: Icons.tune_rounded,
      tint: Color(0xFF1E88E5),
    ),
    (
      title: 'Expecting velocity from DragDownDetails',
      body: 'Wrong type. Velocity is reported by DragEndDetails when the finger '
          'lifts. DragDownDetails is the LANDING — there is no movement yet, so '
          'no velocity is meaningful.',
      icon: Icons.flash_off_rounded,
      tint: Color(0xFF6A1B9A),
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFEBEE), Color(0xFFFCE4EC)],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFEF9A9A)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22D32F2F),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '10',
          title: 'Pitfalls & FAQ',
          subtitle: 'Four mistakes that bite people who skim the docs',
          accent: const Color(0xFFD32F2F),
        ),
        const SizedBox(height: 20),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PitfallCard(
              title: item.title,
              body: item.body,
              icon: item.icon,
              tint: item.tint,
            ),
          ),
      ],
    ),
  );
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color tint;
  const _PitfallCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: tint.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tint, tint.withOpacity(0.55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: tint.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: tint,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF424242),
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

// =============================================================================
// SECTION 11 — Footer
// =============================================================================
Widget _footer() {
  print('=== Section 11: footer ===');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF101828), Color(0xFF1F2937)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55101828),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'In summary',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'DragDownDetails is the smallest, gentlest member of the drag-details '
          'family — three fields, one immutable record, zero behaviour. It tells '
          'you where a finger has just landed, in screen and widget space, and '
          'what kind of pointer it is. Use it to bookmark the start of a possible '
          'drag and to hit-test sub-elements before any motion happens.',
          style: TextStyle(
            color: Color(0xFFE5E7EB),
            fontSize: 13,
            height: 1.55,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1220),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF374151)),
          ),
          child: const Text(
            '+--------------------------------------------------+\n'
            '|  source: package:flutter/src/gestures/monodrag.dart  |\n'
            '|  re-exports via: package:flutter/material.dart       |\n'
            '|  family: DragDownDetails | DragStartDetails |        |\n'
            '|          DragUpdateDetails | DragEndDetails          |\n'
            '+--------------------------------------------------+',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Color(0xFF9CA3AF),
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '— end of demo —',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 10,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Shared helpers
// =============================================================================
Widget _sectionHeader({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  bool onDarkBackground = false,
}) {
  final titleColor = onDarkBackground ? Colors.white : const Color(0xFF1A1A1A);
  final subColor = onDarkBackground ? const Color(0xCCEFEFEF) : const Color(0xFF6B6B6B);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent, accent.withOpacity(0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.45),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: subColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
