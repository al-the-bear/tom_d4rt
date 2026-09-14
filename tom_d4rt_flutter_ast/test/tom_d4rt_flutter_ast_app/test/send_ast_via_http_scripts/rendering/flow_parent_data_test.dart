// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// =====================================================================
// FlowParentData — deep visual demo
// ---------------------------------------------------------------------
// FlowParentData is a ParentDataWidget data class that lives on every
// child of a `Flow` widget. The Flow's RenderObject (RenderFlow) attaches
// FlowParentData to each child so the FlowDelegate can mutate the per-
// child transform via `context.paintChild(i, transform: matrix)`.
// =====================================================================

dynamic build(BuildContext context) {
  // Palette — cool deep blues with citrus accents.
  const Color cBg = Color(0xFF0E1726);
  const Color cPanel = Color(0xFF18253C);
  const Color cPanelAlt = Color(0xFF21314C);
  const Color cBorder = Color(0xFF2E4368);
  const Color cAccentA = Color(0xFFFFC857);
  const Color cAccentB = Color(0xFF7DD3FC);
  const Color cAccentC = Color(0xFFF472B6);
  const Color cAccentD = Color(0xFF86EFAC);
  const Color cText = Color(0xFFE6EDF7);
  const Color cTextDim = Color(0xFF9AA8C0);

  // ---- Try/catch zone: probe FlowParentData fields safely ----------
  String parentDataReport = '';
  String offsetText = '?';
  String runtimeTypeText = '?';
  bool isContainerBox = false;
  try {
    final FlowParentData pd = FlowParentData();
    runtimeTypeText = pd.runtimeType.toString();
    offsetText = pd.offset.toString();
    final Object dyn = pd;
    isContainerBox = dyn is ContainerBoxParentData<RenderBox>;
    parentDataReport =
        'OK runtimeType=$runtimeTypeText offset=$offsetText container=$isContainerBox';
  } catch (e) {
    parentDataReport = 'probe failed: $e';
  }
  print('[FlowParentData probe] $parentDataReport');

  // ---- Reusable building blocks ------------------------------------
  Widget chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget sectionTitle(String index, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cAccentA.withValues(alpha: 0.18),
              border: Border.all(color: cAccentA, width: 1.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(index,
                style: const TextStyle(
                    color: cAccentA,
                    fontWeight: FontWeight.w800,
                    fontSize: 13)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: cText,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                        const TextStyle(color: cTextDim, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget panel(Widget child,
      {EdgeInsets padding = const EdgeInsets.all(16),
      Color bg = cPanel,
      Color border = cBorder}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 1),
      ),
      child: child,
    );
  }

  Widget kv(String k, String v, {Color? accent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(k,
                style: TextStyle(
                    color: accent ?? cTextDim,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(v,
                style: const TextStyle(
                    color: cText, fontSize: 12, height: 1.35)),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String code, {Color edge = cAccentB}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1220),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: edge, width: 3)),
      ),
      child: Text(code,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
              color: cText.withValues(alpha: 0.92))),
    );
  }

  // ---- Section 1: Hero ---------------------------------------------
  Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cAccentB.withValues(alpha: 0.18),
          cAccentC.withValues(alpha: 0.18),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cBorder, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: cAccentB.withValues(alpha: 0.2),
            border: Border.all(color: cAccentB, width: 1.4),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: const Text('FP',
              style: TextStyle(
                  color: cAccentB,
                  fontWeight: FontWeight.w900,
                  fontSize: 20)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FlowParentData',
                  style: TextStyle(
                      color: cText,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4)),
              const SizedBox(height: 4),
              const Text(
                'Per-child transform carrier for Flow widget paint phase',
                style: TextStyle(color: cTextDim, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  chip('extends ContainerBoxParentData<RenderBox>', cAccentB),
                  chip('paint-only transform', cAccentA),
                  chip('does not affect layout', cAccentC),
                  chip('mutated by FlowDelegate', cAccentD),
                ],
              ),
              const SizedBox(height: 10),
              Text(parentDataReport,
                  style: const TextStyle(
                      color: cTextDim,
                      fontSize: 11,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
      ],
    ),
  );

  // ---- Section 2: triangle schematic --------------------------------
  Widget node(String label, Color color, double w) {
    return Container(
      width: w,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color, width: 1.2),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w800)),
    );
  }

  Widget arrow(String label, double width, {Color color = cTextDim}) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Container(
          width: width,
          height: 2,
          color: color.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget triangle = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Architectural triangle',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            node('FlowParentData\n(per-child slot)', cAccentB, 150),
            arrow('attached to', 60),
            node('RenderBox child', cAccentA, 130),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            arrow('mutated by', 80, color: cAccentC),
          ],
        ),
        const SizedBox(height: 8),
        Center(child: node('FlowDelegate.paintChildren()', cAccentC, 240)),
        const SizedBox(height: 14),
        const Text(
          'The delegate calls context.paintChild(i, transform: m). '
          'Internally that writes m onto FlowParentData._transform of '
          'child i and triggers a paint pass. Layout is untouched.',
          style: TextStyle(color: cTextDim, fontSize: 12, height: 1.45),
        ),
      ],
    ),
  );

  // ---- Section 3: anatomy of a Matrix4 -----------------------------
  Widget matrixCell(String label, Color color, {bool dim = false}) {
    return Container(
      width: 56,
      height: 38,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: dim
            ? color.withValues(alpha: 0.08)
            : color.withValues(alpha: 0.28),
        border: Border.all(
            color: color.withValues(alpha: dim ? 0.3 : 0.9), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(
              color: dim ? cTextDim : color,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700)),
    );
  }

  Widget matrixRow(List<Widget> cells) {
    return Row(mainAxisSize: MainAxisSize.min, children: cells);
  }

  Widget matrixGrid = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Anatomy of the per-child Matrix4',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 4),
        const Text(
          'Each FlowParentData carries a 4x4 matrix that the delegate '
          'sets at paint time. Components encode TRS+skew+perspective.',
          style: TextStyle(color: cTextDim, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                matrixRow([
                  matrixCell('sx', cAccentA),
                  matrixCell('r01', cAccentC),
                  matrixCell('r02', cAccentC),
                  matrixCell('tx', cAccentB),
                ]),
                matrixRow([
                  matrixCell('r10', cAccentC),
                  matrixCell('sy', cAccentA),
                  matrixCell('r12', cAccentC),
                  matrixCell('ty', cAccentB),
                ]),
                matrixRow([
                  matrixCell('r20', cAccentC, dim: true),
                  matrixCell('r21', cAccentC, dim: true),
                  matrixCell('sz', cAccentA, dim: true),
                  matrixCell('tz', cAccentB, dim: true),
                ]),
                matrixRow([
                  matrixCell('p0', cAccentD, dim: true),
                  matrixCell('p1', cAccentD, dim: true),
                  matrixCell('p2', cAccentD, dim: true),
                  matrixCell('1', cAccentD),
                ]),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    chip('scale', cAccentA),
                    const SizedBox(width: 6),
                    chip('rotation/skew', cAccentC),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: [
                    chip('translation', cAccentB),
                    const SizedBox(width: 6),
                    chip('perspective', cAccentD),
                  ]),
                  const SizedBox(height: 12),
                  const Text(
                    'For Flow children we typically only set tx, ty, '
                    'sx, sy, and a single rotation around Z. The other '
                    'cells stay at the identity defaults.',
                    style: TextStyle(
                        color: cTextDim, fontSize: 11.5, height: 1.45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ---- Section 4: mock flows (Stack-based) -------------------------
  // We do NOT subclass FlowDelegate. Instead we render exactly the
  // visuals a delegate would produce, using Stack + Transform.

  Widget orb(int i, double size, Color color) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        shape: BoxShape.circle,
        border: Border.all(color: cText.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.45),
              blurRadius: 10,
              spreadRadius: 1),
        ],
      ),
      child: Text('$i',
          style: const TextStyle(
              color: Color(0xFF0E1726),
              fontWeight: FontWeight.w900,
              fontSize: 13)),
    );
  }

  // Fan layout
  List<Widget> fanChildren = <Widget>[];
  const int fanCount = 7;
  for (int i = 0; i < fanCount; i++) {
    final double t = i / (fanCount - 1);
    final double angle = (t - 0.5) * (math.pi * 0.9);
    fanChildren.add(Positioned(
      left: 130,
      top: 150,
      child: Transform.rotate(
        angle: angle,
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(0, -60),
          child: orb(i, 36,
              Color.lerp(cAccentA, cAccentC, t) ?? cAccentA),
        ),
      ),
    ));
  }
  Widget fanFlow = SizedBox(
    height: 200,
    child: Stack(children: fanChildren),
  );

  // Orbital layout
  List<Widget> orbitChildren = <Widget>[];
  const int orbitCount = 10;
  const double orbitRadius = 70;
  for (int i = 0; i < orbitCount; i++) {
    final double a = (i / orbitCount) * math.pi * 2;
    final double dx = math.cos(a) * orbitRadius;
    final double dy = math.sin(a) * orbitRadius;
    orbitChildren.add(Positioned(
      left: 130 + dx - 16,
      top: 90 + dy - 16,
      child: orb(
          i, 32, Color.lerp(cAccentB, cAccentD, i / orbitCount) ?? cAccentB),
    ));
  }
  orbitChildren.add(Positioned(
    left: 130 - 6,
    top: 90 - 6,
    child: Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: cAccentA,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: cAccentA.withValues(alpha: 0.6), blurRadius: 8),
        ],
      ),
    ),
  ));
  Widget orbitFlow = SizedBox(
    height: 200,
    child: Stack(children: orbitChildren),
  );

  // Parallax stack
  List<Widget> parallaxChildren = <Widget>[];
  const int parallaxCount = 6;
  for (int i = 0; i < parallaxCount; i++) {
    final double t = i / (parallaxCount - 1);
    final double scale = 0.55 + t * 0.55;
    final double dx = (t - 0.5) * 90;
    final double dy = (1 - t) * 80;
    parallaxChildren.add(Positioned(
      left: 100 + dx,
      top: 30 + dy,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: Color.lerp(cAccentC, cAccentB, t)!.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cText.withValues(alpha: 0.5)),
          ),
          alignment: Alignment.center,
          child: Text('L${i + 1}',
              style: const TextStyle(
                  color: Color(0xFF0E1726),
                  fontWeight: FontWeight.w900,
                  fontSize: 12)),
        ),
      ),
    ));
  }
  Widget parallaxFlow = SizedBox(
    height: 200,
    child: Stack(children: parallaxChildren),
  );

  // Wave deformation
  List<Widget> waveChildren = <Widget>[];
  const int waveCount = 14;
  for (int i = 0; i < waveCount; i++) {
    final double t = i / (waveCount - 1);
    final double dx = t * 250 + 10;
    final double dy = 90 + math.sin(t * math.pi * 2) * 50;
    final double rot = math.sin(t * math.pi * 2) * 0.5;
    waveChildren.add(Positioned(
      left: dx,
      top: dy,
      child: Transform.rotate(
        angle: rot,
        child: Container(
          width: 18,
          height: 32,
          decoration: BoxDecoration(
            color: Color.lerp(cAccentD, cAccentA, t)!.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ));
  }
  Widget waveFlow = SizedBox(
    height: 200,
    child: Stack(children: waveChildren),
  );

  Widget mockTitle(String name, String subtitle, Color tint) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      color: tint.withValues(alpha: 0.18),
      child: Row(
        children: [
          Container(width: 8, height: 8, color: tint),
          const SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                  color: tint,
                  fontSize: 12,
                  fontWeight: FontWeight.w800)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(subtitle,
                  style: const TextStyle(
                      color: cTextDim,
                      fontSize: 11,
                      fontStyle: FontStyle.italic))),
        ],
      ),
    );
  }

  Widget mockBox(String name, String subtitle, Widget child, Color tint) {
    return Container(
      decoration: BoxDecoration(
        color: cPanelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cBorder),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mockTitle(name, subtitle, tint),
          child,
        ],
      ),
    );
  }

  Widget mockGrid = GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.35,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    children: [
      mockBox('Fan layout', 'rotation around bottom-center', fanFlow,
          cAccentA),
      mockBox('Orbit', 'translation around a center', orbitFlow, cAccentB),
      mockBox('Parallax stack', 'scale + translation per layer',
          parallaxFlow, cAccentC),
      mockBox('Wave', 'sin(x) translation + rotate', waveFlow, cAccentD),
    ],
  );

  // ---- Section 5: code card ----------------------------------------
  const String delegateSnippet = '''
// Hypothetical delegate (not subclassed in this demo)
class FanDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      final double t = i / (context.childCount - 1);
      final double angle = (t - 0.5) * 0.9 * math.pi;
      // This call mutates FlowParentData._transform of child i.
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(120.0, 120.0)
          ..rotateZ(angle)
          ..translate(0.0, -60.0),
      );
    }
  }
  @override
  bool shouldRepaint(FlowDelegate old) => true;
}''';

  Widget codeCard = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How a delegate writes into FlowParentData',
          style: TextStyle(
              color: cText, fontWeight: FontWeight.w800, fontSize: 14),
        ),
        const SizedBox(height: 6),
        const Text(
          'context.paintChild(i, transform: m) is the only public way '
          'to set FlowParentData._transform. After the call, the child '
          'is rendered through that 4x4 transform.',
          style: TextStyle(color: cTextDim, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 10),
        codeBlock(delegateSnippet),
      ],
    ),
  );

  // ---- Section 6: comparison table ---------------------------------
  Widget tableHeader(List<String> labels) {
    final List<Widget> cells = <Widget>[];
    for (int i = 0; i < labels.length; i++) {
      cells.add(Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: cAccentA.withValues(alpha: 0.18),
          child: Text(labels[i],
              style: const TextStyle(
                  color: cAccentA,
                  fontSize: 12,
                  fontWeight: FontWeight.w800)),
        ),
      ));
    }
    return Row(children: cells);
  }

  Widget tableRow(List<String> cells, {bool alt = false}) {
    final List<Widget> ws = <Widget>[];
    for (int i = 0; i < cells.length; i++) {
      ws.add(Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: alt
              ? cPanel.withValues(alpha: 0.6)
              : cPanelAlt.withValues(alpha: 0.6),
          child: Text(cells[i],
              style: const TextStyle(
                  color: cText, fontSize: 11.5, height: 1.35)),
        ),
      ));
    }
    return Row(children: ws);
  }

  Widget compareTable = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FlowParentData vs siblings',
            style: TextStyle(
                color: cText, fontSize: 14, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              tableHeader(const ['field', 'FlowParentData',
                'StackParentData', 'ContainerBoxParentData']),
              tableRow(const ['offset', 'inherited (origin)',
                'computed by Stack', 'inherited']),
              tableRow(const [
                'transform',
                'private 4x4, set via paintChild',
                'n/a',
                'n/a',
              ], alt: true),
              tableRow(const [
                'left/right/top/bottom',
                'n/a',
                'optional positioning',
                'n/a',
              ]),
              tableRow(const [
                'width/height',
                'n/a',
                'optional override',
                'n/a',
              ], alt: true),
              tableRow(const [
                'affects layout?',
                'no — paint only',
                'yes',
                'no by itself',
              ]),
              tableRow(const [
                'mutated by',
                'FlowDelegate.paintChildren',
                'RenderStack layout',
                'subclasses',
              ], alt: true),
              tableRow(const [
                'extends',
                'ContainerBoxParentData<RenderBox>',
                'ContainerBoxParentData<RenderBox>',
                'BoxParentData',
              ]),
            ],
          ),
        ),
      ],
    ),
  );

  // ---- Section 7: parent-data widgets reference card ----------------
  Widget refRow(String widget, String parentDataType, String purpose,
      {bool alt = false}) {
    return Container(
      color: alt ? cPanel.withValues(alpha: 0.4) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 110,
              child: Text(widget,
                  style: const TextStyle(
                      color: cAccentB,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800))),
          SizedBox(
              width: 170,
              child: Text(parentDataType,
                  style: const TextStyle(
                      color: cAccentD,
                      fontSize: 11,
                      fontFamily: 'monospace'))),
          Expanded(
              child: Text(purpose,
                  style:
                      const TextStyle(color: cText, fontSize: 11.5))),
        ],
      ),
    );
  }

  Widget refCard = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Parent-data widgets in Flutter (reference)',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 8),
        refRow('Flow', 'FlowParentData',
            'paint-only Matrix4 per child, set by FlowDelegate'),
        refRow('Positioned', 'StackParentData',
            'absolute positioning in a Stack', alt: true),
        refRow('Flexible', 'FlexParentData',
            'flex factor + fit inside Row/Column/Flex'),
        refRow('Expanded', 'FlexParentData',
            'shorthand for Flexible(fit: tight)', alt: true),
        refRow('LayoutId', 'MultiChildLayoutParentData',
            'tag for CustomMultiChildLayout delegate'),
        refRow('TableCell', 'TableCellParentData',
            'vertical alignment inside Table row', alt: true),
        refRow('SliverGridTile', 'SliverGridParentData',
            'grid cell info per sliver child'),
        refRow('KeepAlive', 'KeepAliveParentDataMixin',
            'prevent disposal in lazy lists', alt: true),
        refRow('ListBody', 'BoxParentData',
            'simple sequential layout, no extras'),
      ],
    ),
  );

  // ---- Section 8: edge cases ----------------------------------------
  Widget edgeMini(String title, Widget visual, String desc, Color tint) {
    return Container(
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: cBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, color: tint),
              const SizedBox(width: 6),
              Text(title,
                  style: TextStyle(
                      color: tint,
                      fontSize: 12,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(height: 110, child: visual),
          const SizedBox(height: 6),
          Text(desc,
              style: const TextStyle(
                  color: cTextDim, fontSize: 11, height: 1.35)),
        ],
      ),
    );
  }

  // identity case: all 4 children stack at top-left (the natural
  // appearance when the delegate doesn't call paintChild with any
  // transform — they all draw at the origin).
  List<Widget> identityChildren = <Widget>[];
  for (int i = 0; i < 4; i++) {
    identityChildren.add(Positioned(
      left: 10,
      top: 10,
      child: Opacity(
        opacity: 0.55,
        child: orb(i, 28,
            Color.lerp(cAccentA, cAccentB, i / 3) ?? cAccentA),
      ),
    ));
  }
  Widget identityVis = Stack(children: identityChildren);

  // translation only
  List<Widget> translationChildren = <Widget>[];
  for (int i = 0; i < 5; i++) {
    translationChildren.add(Positioned(
      left: 6 + i * 36,
      top: 30,
      child: orb(i, 30,
          Color.lerp(cAccentC, cAccentB, i / 4) ?? cAccentC),
    ));
  }
  Widget translationVis = Stack(children: translationChildren);

  // rotation + scale
  List<Widget> rotScaleChildren = <Widget>[];
  for (int i = 0; i < 5; i++) {
    final double t = i / 4;
    rotScaleChildren.add(Positioned(
      left: 6 + i * 36,
      top: 25,
      child: Transform.rotate(
        angle: (t - 0.5) * 1.2,
        child: Transform.scale(
          scale: 0.7 + t * 0.7,
          child: orb(i, 28,
              Color.lerp(cAccentD, cAccentA, t) ?? cAccentD),
        ),
      ),
    ));
  }
  Widget rotScaleVis = Stack(children: rotScaleChildren);

  Widget edgeCases = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Edge cases of the per-child transform',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: edgeMini(
                  'identity',
                  identityVis,
                  'No paintChild call, or transform = Matrix4.identity(): '
                  'every child is drawn at the origin and they overlap.',
                  cAccentA),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: edgeMini(
                  'translate-only',
                  translationVis,
                  'transform = Matrix4.translationValues(tx,ty,0): '
                  'common case, places children in a row.',
                  cAccentB),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: edgeMini(
                  'rotate + scale',
                  rotScaleVis,
                  'Composed Matrix4 with rotateZ and scale: produces '
                  'fan-like sweeping content.',
                  cAccentC),
            ),
          ],
        ),
      ],
    ),
  );

  // ---- Section 9: lifecycle timeline --------------------------------
  Widget step(int i, String title, String desc, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text('$i',
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w800))),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        color: cText, fontSize: 11.5, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget lifecycle = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Frame lifecycle around FlowParentData',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 10),
        step(1, 'mount',
            'Flow widget creates RenderFlow; each child gets a fresh '
            'FlowParentData on attach.',
            cAccentA),
        step(2, 'layout',
            'RenderFlow lays out children at constraints; the '
            'FlowParentData.offset stays at (0,0) — layout is intentionally '
            'flat.',
            cAccentB),
        step(3, 'paint',
            'RenderFlow asks the FlowDelegate to paint. The delegate '
            'iterates childCount and calls paintChild(i, transform: m).',
            cAccentC),
        step(4, 'transform write',
            'paintChild writes m onto FlowParentData._transform of child i, '
            'then composes a transform layer for that child.',
            cAccentD),
        step(5, 'repaint',
            'shouldRepaint(oldDelegate) decides whether the next frame '
            'needs to call paintChildren again — animations live here.',
            cAccentA),
      ],
    ),
  );

  // ---- Section 10: quick facts grid --------------------------------
  Widget factCard(String title, String body, Color tint) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        border: Border.all(color: tint.withValues(alpha: 0.6), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: tint, fontSize: 12, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(body,
              style:
                  const TextStyle(color: cText, fontSize: 11.5, height: 1.4)),
        ],
      ),
    );
  }

  Widget factsGrid = GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 2.4,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: [
      factCard('paint, not layout',
          'FlowParentData affects only the paint pass. Children are '
          'always laid out at the origin.',
          cAccentA),
      factCard('private transform',
          '_transform is private; FlowPaintingContext.paintChild is the '
          'only sanctioned way to set it.',
          cAccentB),
      factCard('hit testing',
          'RenderFlow inverts the transform during hit-test, so the '
          'visual position is also the interactive position.',
          cAccentC),
      factCard('repaint boundary friendly',
          'Each painted child is wrapped in its own transform layer, so '
          'unchanged children can be cached.',
          cAccentD),
    ],
  );

  // ---- Section 11: observed values -----------------------------
  Widget observed = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Observed live values',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 6),
        kv('runtimeType', runtimeTypeText, accent: cAccentB),
        kv('offset (default)', offsetText, accent: cAccentC),
        kv('is ContainerBoxParentData<RenderBox>', '$isContainerBox',
            accent: cAccentA),
        kv('probe report', parentDataReport, accent: cAccentD),
        const SizedBox(height: 6),
        const Text(
          'The default offset is Offset.zero because Flow lays out all '
          'children at the origin and lets the delegate take over at paint.',
          style: TextStyle(color: cTextDim, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );

  // ---- Section 12: animation snapshots ------------------------------
  // Demonstrate, frame by frame, how a delegate would use a tween-like
  // value to drive Matrix4 transforms. We do NOT animate; we snapshot.
  Widget animSnapshot(double t, Color tint) {
    final List<Widget> children = <Widget>[];
    const int n = 8;
    for (int i = 0; i < n; i++) {
      final double phase = (i / n) * math.pi * 2 + t * math.pi * 2;
      final double dx = math.cos(phase) * 50;
      final double dy = math.sin(phase) * 30;
      final double scale = 0.6 + 0.4 * (math.sin(phase + t) + 1) / 2;
      children.add(Positioned(
        left: 80 + dx - 10,
        top: 50 + dy - 10,
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border:
                  Border.all(color: cText.withValues(alpha: 0.4), width: 1),
            ),
          ),
        ),
      ));
    }
    return Container(
      width: 160,
      height: 110,
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: cBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(children: children),
    );
  }

  Widget snapshotFrame(double t, Color tint) {
    return Column(
      children: [
        animSnapshot(t, tint),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('t = ${t.toStringAsFixed(2)}',
              style: TextStyle(
                  color: tint,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  // Construct snapshot strip via index-based loop
  final List<Widget> snapshotStrip = <Widget>[];
  const int snapCount = 5;
  for (int i = 0; i < snapCount; i++) {
    final double t = i / (snapCount - 1);
    final Color tint =
        Color.lerp(cAccentB, cAccentC, t) ?? cAccentB;
    if (i > 0) {
      snapshotStrip.add(const SizedBox(width: 10));
    }
    snapshotStrip.add(snapshotFrame(t, tint));
  }

  Widget animSnapshots = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Animation snapshots (AlwaysStoppedAnimation)',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 4),
        const Text(
          'Each frame represents a different value of t fed into the '
          'delegate. The FlowParentData transforms get re-written every '
          'frame; nothing else does.',
          style: TextStyle(color: cTextDim, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: snapshotStrip),
        ),
        const SizedBox(height: 10),
        codeBlock(
          'final Animation<double> a = AlwaysStoppedAnimation<double>(0.5);\n'
          '// In a real app:\n'
          'Flow(\n'
          '  delegate: MyDelegate(progress: a),\n'
          '  children: tiles,\n'
          ');\n'
          '// Inside paintChildren the delegate reads a.value and feeds it\n'
          '// into Matrix4 construction, then context.paintChild(i, transform: m).',
          edge: cAccentC,
        ),
      ],
    ),
  );

  // ---- Section 13: gotchas card ------------------------------------
  Widget gotcha(String label, String detail, Color tint) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: tint, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text('!',
                style: TextStyle(
                    color: Color(0xFF0E1726),
                    fontWeight: FontWeight.w900,
                    fontSize: 11)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: tint,
                        fontSize: 12,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(detail,
                    style: const TextStyle(
                        color: cText, fontSize: 11.5, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gotchaCard = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Common gotchas',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 10),
        gotcha('No layout effect',
            'Setting a transform via paintChild does NOT change child size '
            'or its layout offset. Children always claim the full Flow size.',
            cAccentA),
        gotcha('Children skipped if not painted',
            'A child that is never targeted by paintChild simply does not '
            'paint, but it still exists for layout and hit-testing purposes.',
            cAccentB),
        gotcha('Hit-testing follows transform',
            'Flow inverts each childs transform during hit-testing, so '
            'pointer events land on the visually displayed position.',
            cAccentC),
        gotcha('Repaint frequency',
            'shouldRepaint must return true when delegate inputs change, '
            'otherwise transforms stick to the last frame.',
            cAccentD),
        gotcha('Order matters',
            'Children are painted in the order paintChild is called. Skip '
            'a child to mask it; reorder to layer it.',
            cAccentA),
      ],
    ),
  );

  // ---- Section 14: legend ------------------------------------------
  Widget legendItem(Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                  color: color.withValues(alpha: 0.6), width: 1),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 110,
              child: Text(label,
                  style: const TextStyle(
                      color: cText,
                      fontSize: 12,
                      fontWeight: FontWeight.w700))),
          Expanded(
            child: Text(value,
                style:
                    const TextStyle(color: cTextDim, fontSize: 11.5)),
          ),
        ],
      ),
    );
  }

  Widget legend = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color legend',
            style: TextStyle(
                color: cText, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 8),
        legendItem(cAccentA, 'amber', 'scale axes (sx, sy, sz)'),
        legendItem(cAccentB, 'sky', 'translation (tx, ty, tz)'),
        legendItem(cAccentC, 'pink', 'rotation / skew components'),
        legendItem(cAccentD, 'mint', 'perspective row'),
      ],
    ),
  );

  // ---- Section 15: signature card ----------------------------------
  Widget signatureCard = panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Class signature',
            style: TextStyle(
                color: cText, fontSize: 14, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        codeBlock(
          'class FlowParentData extends ContainerBoxParentData<RenderBox> {\n'
          '  // Field is private:\n'
          '  // Matrix4? _transform;\n'
          '  //\n'
          '  // No public setter. The only way to set _transform is:\n'
          '  // FlowPaintingContext.paintChild(int i, { Matrix4 transform })\n'
          '  // which forwards to RenderFlow which writes child[i].parentData._transform.\n'
          '}',
          edge: cAccentB,
        ),
        const SizedBox(height: 10),
        const Text(
          'Note that FlowParentData has no public constructor parameters '
          'and no public mutator. It is intentionally opaque — clients '
          'are meant to interact with it solely through FlowDelegate.',
          style: TextStyle(color: cTextDim, fontSize: 12, height: 1.45),
        ),
      ],
    ),
  );

  // ---- Section 12: footer summary ----------------------------------
  Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Summary',
            style: TextStyle(
                color: cAccentA,
                fontWeight: FontWeight.w800,
                fontSize: 14)),
        const SizedBox(height: 6),
        const Text(
          'FlowParentData is the per-child slot that lets a Flow widget '
          'apply an arbitrary 4x4 transform at paint time without '
          'disturbing layout. The transform is private and is set '
          'exclusively through FlowPaintingContext.paintChild from a '
          'FlowDelegate. Use Flow when you want efficient per-child '
          'transformations driven by an animation, with caching of the '
          'children that have not changed since the last frame.',
          style: TextStyle(color: cText, fontSize: 12.5, height: 1.5),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            chip('Flow widget', cAccentB),
            chip('FlowDelegate', cAccentC),
            chip('Matrix4', cAccentA),
            chip('paint-only', cAccentD),
            chip('ContainerBoxParentData<RenderBox>', cAccentB),
          ],
        ),
      ],
    ),
  );

  // ---- Compose the page --------------------------------------------
  Widget body = SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hero,
        const SizedBox(height: 18),
        sectionTitle('01', 'Architecture',
            'Where FlowParentData sits between the widget tree and paint.'),
        triangle,
        const SizedBox(height: 18),
        sectionTitle('02', 'Matrix anatomy',
            'What lives inside the per-child Matrix4 carried by FlowParentData.'),
        matrixGrid,
        const SizedBox(height: 18),
        sectionTitle('03', 'Sample flows (mocked)',
            'Visual mock-ups of typical FlowDelegate outputs, drawn with Stack.'),
        mockGrid,
        const SizedBox(height: 18),
        sectionTitle('04', 'Delegate code',
            'How a delegate would call paintChild to write into the parent data.'),
        codeCard,
        const SizedBox(height: 18),
        sectionTitle('05', 'Comparison',
            'FlowParentData against StackParentData and ContainerBoxParentData.'),
        compareTable,
        const SizedBox(height: 18),
        sectionTitle('06', 'Edge cases',
            'How specific Matrix4 inputs map to visible results.'),
        edgeCases,
        const SizedBox(height: 18),
        sectionTitle('07', 'Lifecycle',
            'Per-frame sequence from mount to repaint.'),
        lifecycle,
        const SizedBox(height: 18),
        sectionTitle('08', 'Quick facts',
            'Bite-size pointers to remember when using Flow.'),
        factsGrid,
        const SizedBox(height: 18),
        sectionTitle('09', 'Live probe',
            'Values observed from a real FlowParentData() instance at runtime.'),
        observed,
        const SizedBox(height: 18),
        sectionTitle('10', 'Reference card',
            'Other common parent-data widgets and what they configure.'),
        refCard,
        const SizedBox(height: 18),
        sectionTitle('11', 'Animation snapshots',
            'Frozen progress samples illustrating how transforms evolve.'),
        animSnapshots,
        const SizedBox(height: 18),
        sectionTitle('12', 'Gotchas',
            'Things that bite you when shipping a Flow-based widget.'),
        gotchaCard,
        const SizedBox(height: 18),
        sectionTitle('13', 'Class signature',
            'The minimal public surface of FlowParentData itself.'),
        signatureCard,
        const SizedBox(height: 18),
        sectionTitle('14', 'Legend',
            'Color decoding for the matrix anatomy section.'),
        legend,
        const SizedBox(height: 18),
        footer,
        const SizedBox(height: 24),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: cBg,
    body: body,
  );
}
