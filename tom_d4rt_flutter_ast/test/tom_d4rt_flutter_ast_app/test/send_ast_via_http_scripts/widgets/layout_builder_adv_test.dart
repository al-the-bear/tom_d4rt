// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Advanced Layout Builders Visual Demo
// ---------------------------------------------------------------------------
// This script renders, in a single scrollable page, every major shape of
// constraint-driven layout that Flutter exposes:
//
//   * LayoutBuilder         -> read incoming BoxConstraints and pick a layout
//   * OrientationBuilder    -> branch on portrait/landscape based on aspect
//   * CustomMultiChildLayout + MultiChildLayoutDelegate
//                            -> place arbitrarily many children by id, freely
//                              positioned with custom math (radial clocks,
//                              asymmetric editor shells, dashboards)
//   * CustomSingleChildLayout + SingleChildLayoutDelegate
//                            -> constrain and position a single child by hand
//
// To make the demo *deterministic* every example is wrapped in a SizedBox of a
// known size.  That way the visual output never depends on the host viewport;
// each block always shows what it is supposed to show no matter where it is
// rendered.  The widths picked here -- 320 / 600 / 900 -- correspond to the
// familiar phone / tablet / desktop breakpoints that the LayoutBuilder
// examples respond to.
//
// Note: the entry point is a single `build(BuildContext)` function and all
// supporting code is expressed as top-level helper functions, not as
// StatelessWidget subclasses.  The only top-level classes are the two
// MultiChildLayoutDelegate and SingleChildLayoutDelegate subclasses, which
// are the canonical way to use those APIs.
// ---------------------------------------------------------------------------

// Shared palette so the various sections feel like a single document instead
// of a Christmas tree.
const Color _bgPage = Color(0xFFF5F7FB);
const Color _panel = Color(0xFFFFFFFF);
const Color _panelBorder = Color(0xFFE2E6EE);
const Color _accent = Color(0xFF3155F6);
const Color _accentSoft = Color(0xFFDCE4FF);
const Color _ink = Color(0xFF1B2333);
const Color _muted = Color(0xFF6E7A92);
const Color _good = Color(0xFF1F9D55);
const Color _bad = Color(0xFFD13838);
const Color _warn = Color(0xFFE08A1A);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Advanced layout-builder visual demo starting');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _bgPage,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _ink, fontSize: 13, height: 1.35),
      ),
    ),
    home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection1HeaderAnatomy(),
              _gap(),
              _buildSection2Breakpoints(),
              _gap(),
              _buildSection3Orientation(),
              _gap(),
              _buildSection4AspectAware(),
              _gap(),
              _buildSection5RadialClock(),
              _gap(),
              _buildSection6EditorShell(),
              _gap(),
              _buildSection7SingleChildLayout(),
              _gap(),
              _buildSection8NestedBuilders(),
              _gap(),
              _buildSection9ConstraintInspection(),
              _gap(),
              _buildSection10Pitfalls(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    ),
  );
}

SizedBox _gap() => const SizedBox(height: 28);

// ---------------------------------------------------------------------------
// Generic chrome helpers -- a "panel" is a rounded card with a title row, an
// explanatory blurb, and the actual demo inside.  Using a single helper makes
// every section feel like part of the same document.
// ---------------------------------------------------------------------------

Widget _panelFrame({
  required String number,
  required String title,
  required String description,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _panelBorder),
    ),
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12.5, color: _muted, height: 1.45),
        ),
        const SizedBox(height: 14),
        body,
      ],
    ),
  );
}

Widget _caption(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(
      text,
      style: const TextStyle(fontSize: 11.5, color: _muted, height: 1.4),
    ),
  );
}

Widget _label(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: _accent,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _forcedWidth(double width, Widget child, {String? badge}) {
  // A consistent "this is exactly N pixels wide" frame so the breakpoint
  // demos always show all three sizes side by side without depending on the
  // host viewport.
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: _panelBorder),
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFAFBFE),
    ),
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badge != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _accentSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 11,
                  color: _accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        SizedBox(width: width, child: child),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 -- Header / anatomy of a LayoutBuilder
// ---------------------------------------------------------------------------

Widget _buildSection1HeaderAnatomy() {
  return _panelFrame(
    number: '1',
    title: 'Anatomy of a constraint-driven build',
    description:
        'A LayoutBuilder is a widget that receives the incoming BoxConstraints '
        'from its parent and rebuilds whenever those constraints change. The '
        'diagram below traces the flow: the parent imposes a constraint, the '
        'builder closure reads it, and the resulting subtree is then sized '
        'against those very same constraints.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('CONSTRAINT FLOW'),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFBFE),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _panelBorder),
          ),
          child: Column(
            children: [
              _anatomyRow('Parent', 'minW=0, maxW=600\nminH=0, maxH=inf',
                  Colors.indigo),
              _anatomyArrow('passes BoxConstraints down'),
              _anatomyRow('LayoutBuilder', 'reads constraints,\nbuilds subtree',
                  _accent),
              _anatomyArrow('builder(context, constraints)'),
              _anatomyRow(
                  'Subtree', 'sized against the\nsame constraints', _good),
            ],
          ),
        ),
        _caption(
            'The builder closure runs during the layout phase, not the build '
            'phase. That is why you cannot call setState inside it without '
            'scheduling a post-frame callback -- you would mutate state in the '
            'middle of laying out the tree.'),
      ],
    ),
  );
}

Widget _anatomyRow(String name, String detail, Color color) {
  return Row(
    children: [
      Container(
        width: 110,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Text(
          detail,
          style: const TextStyle(fontSize: 12, color: _ink, height: 1.3),
        ),
      ),
    ],
  );
}

Widget _anatomyArrow(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 50, top: 6, bottom: 6),
    child: Row(
      children: [
        Container(width: 2, height: 18, color: _muted),
        const SizedBox(width: 10),
        Text(text,
            style: const TextStyle(
                fontSize: 11.5,
                color: _muted,
                fontStyle: FontStyle.italic)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 -- Breakpoint demo (320 / 600 / 900)
// ---------------------------------------------------------------------------

Widget _buildSection2Breakpoints() {
  return _panelFrame(
    number: '2',
    title: 'Breakpoint grid: 1, 2, or 3 columns',
    description:
        'A single LayoutBuilder switches the column count of a card grid '
        'based on the incoming maxWidth. To prove the switch in a fixed-size '
        'preview, we wrap three instances in SizedBox widgets of 320, 600 and '
        '900 logical pixels respectively. The same widget tree reacts to '
        'three different constraint envelopes.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _forcedWidth(320, _breakpointGrid(), badge: '320 px -> 1 column'),
        _forcedWidth(600, _breakpointGrid(), badge: '600 px -> 2 columns'),
        _forcedWidth(900, _breakpointGrid(), badge: '900 px -> 3 columns'),
      ],
    ),
  );
}

Widget _breakpointGrid() {
  return LayoutBuilder(
    builder: (context, constraints) {
      int columns;
      String tier;
      if (constraints.maxWidth < 480) {
        columns = 1;
        tier = 'mobile';
      } else if (constraints.maxWidth < 800) {
        columns = 2;
        tier = 'tablet';
      } else {
        columns = 3;
        tier = 'desktop';
      }

      final items = <Widget>[
        _demoCard('Orders', '128', _accent),
        _demoCard('Revenue', '\$24.1k', _good),
        _demoCard('Open', '7', _warn),
        _demoCard('Returns', '2', _bad),
        _demoCard('NPS', '+62', _accent),
        _demoCard('Avg.', '4.6', _good),
      ];

      final rows = <Widget>[];
      for (int i = 0; i < items.length; i += columns) {
        final rowItems = <Widget>[];
        for (int c = 0; c < columns; c++) {
          if (i + c < items.length) {
            rowItems.add(Expanded(child: items[i + c]));
          } else {
            rowItems.add(const Expanded(child: SizedBox.shrink()));
          }
          if (c < columns - 1) {
            rowItems.add(const SizedBox(width: 8));
          }
        }
        rows.add(Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(children: rowItems),
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'tier=$tier  maxW=${constraints.maxWidth.toStringAsFixed(0)}px  -> $columns col${columns == 1 ? '' : 's'}',
            style: const TextStyle(
                fontSize: 11.5, color: _muted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...rows,
        ],
      );
    },
  );
}

Widget _demoCard(String title, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 11.5, color: color, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: _ink),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 -- OrientationBuilder
// ---------------------------------------------------------------------------

Widget _buildSection3Orientation() {
  return _panelFrame(
    number: '3',
    title: 'OrientationBuilder: portrait vs landscape',
    description:
        'OrientationBuilder picks portrait/landscape based on the aspect ratio '
        'of the constraints it receives (wider-than-tall -> landscape). The '
        'two examples below are forced to specific aspect ratios via SizedBox '
        'wrappers so they reliably exercise both branches regardless of the '
        'host viewport.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('FORCED PORTRAIT  240w x 320h'),
              SizedBox(width: 240, height: 320, child: _orientationBox()),
              _caption(
                  'Aspect <1, so OrientationBuilder returns Orientation.portrait '
                  'and we stack the cards vertically.'),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('FORCED LANDSCAPE  360w x 180h'),
              SizedBox(width: 360, height: 180, child: _orientationBox()),
              _caption(
                  'Aspect >1, so OrientationBuilder returns Orientation.landscape '
                  'and the same content flows horizontally.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _orientationBox() {
  return OrientationBuilder(
    builder: (context, orientation) {
      final cards = <Widget>[
        _orientChip('Photos', Icons.photo_library, _accent),
        _orientChip('Albums', Icons.collections, _good),
        _orientChip('Trash', Icons.delete_outline, _warn),
      ];

      final isLandscape = orientation == Orientation.landscape;
      final orientationLabel = isLandscape ? 'landscape' : 'portrait';

      final children = <Widget>[];
      children.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: _accentSoft,
          child: Text(
            'orientation=$orientationLabel',
            style: const TextStyle(
                color: _accent, fontWeight: FontWeight.w600, fontSize: 11.5),
          ),
        ),
      );

      if (isLandscape) {
        children.add(Expanded(
          child: Row(
            children: [
              for (final c in cards) Expanded(child: c),
            ],
          ),
        ));
      } else {
        children.add(Expanded(
          child: Column(
            children: [
              for (final c in cards) Expanded(child: c),
            ],
          ),
        ));
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: _panelBorder),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFAFBFE),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      );
    },
  );
}

Widget _orientChip(String label, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.35)),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 -- Aspect-ratio-aware layout via constraints.biggest
// ---------------------------------------------------------------------------

Widget _buildSection4AspectAware() {
  return _panelFrame(
    number: '4',
    title: 'Aspect-aware layout from constraints.biggest',
    description:
        'Instead of switching on width alone, this LayoutBuilder reads '
        'constraints.biggest and computes biggest.width / biggest.height. '
        'That single value distinguishes tall (gallery rail), square '
        '(quadrant grid) and wide (banner) shapes -- without depending on '
        'MediaQuery.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('TALL  ratio<0.8'),
              SizedBox(width: 160, height: 260, child: _aspectAware()),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SQUARE  0.8..1.5'),
              SizedBox(width: 220, height: 220, child: _aspectAware()),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('WIDE  ratio>1.5'),
              SizedBox(width: 320, height: 140, child: _aspectAware()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _aspectAware() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final s = constraints.biggest;
      final ratio = s.width / s.height;
      String mode;
      Widget body;
      if (ratio < 0.8) {
        mode = 'tall';
        body = Column(
          children: [
            for (int i = 0; i < 4; i++)
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(3),
                color: _accent.withOpacity(0.1 + (i * 0.18)),
                alignment: Alignment.center,
                child: Text('#$i',
                    style: const TextStyle(
                        color: _accent, fontWeight: FontWeight.w700)),
              )),
          ],
        );
      } else if (ratio < 1.5) {
        mode = 'square';
        body = Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _good.withOpacity(0.18))),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _accent.withOpacity(0.18))),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _warn.withOpacity(0.20))),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _bad.withOpacity(0.18))),
                ],
              ),
            ),
          ],
        );
      } else {
        mode = 'wide';
        body = Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(3),
                color: _accent.withOpacity(0.15),
                alignment: Alignment.center,
                child: const Text('banner',
                    style: TextStyle(
                        color: _accent, fontWeight: FontWeight.w700)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _good.withOpacity(0.2))),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(3),
                          color: _warn.withOpacity(0.2))),
                ],
              ),
            ),
          ],
        );
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: _panelBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: _accentSoft,
              width: double.infinity,
              child: Text(
                'mode=$mode  ratio=${ratio.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 11, color: _accent, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      );
    },
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 -- CustomMultiChildLayout radial clock
// ---------------------------------------------------------------------------

Widget _buildSection5RadialClock() {
  return _panelFrame(
    number: '5',
    title: 'CustomMultiChildLayout: radial clock face',
    description:
        'CustomMultiChildLayout asks a MultiChildLayoutDelegate to size and '
        'position each child by id. Here we lay twelve numbered bubbles in a '
        'circle around a central hub, computing each angle as i * (2pi / 12). '
        'This is the canonical use case for MultiChildLayoutDelegate: '
        'positions that do not fit any built-in widget.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          height: 280,
          child: CustomMultiChildLayout(
            delegate: _RadialClockDelegate(),
            children: [
              LayoutId(id: 'hub', child: _clockHub()),
              for (int i = 1; i <= 12; i++)
                LayoutId(id: 'h$i', child: _clockBubble('$i')),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('HOW THE DELEGATE WORKS'),
              _codeBlock(const [
                'class _RadialClockDelegate extends MultiChildLayoutDelegate {',
                '  void performLayout(Size size) {',
                '    final r = min(size.width, size.height) / 2 - 24;',
                '    final c = size.center(Offset.zero);',
                '    layoutChild("hub", BoxConstraints.tightFor(...));',
                '    positionChild("hub", c - half(hubSize));',
                '    for (i in 1..12) {',
                '      final theta = -pi/2 + i * 2pi/12;',
                '      final pos = c + Offset(cos*r, sin*r) - half(size);',
                '      layoutChild("h\$i", tightFor);',
                '      positionChild("h\$i", pos);',
                '    }',
                '  }',
                '}',
              ]),
              _caption(
                  'layoutChild() returns the size after sizing; positionChild() '
                  'sets the top-left corner.  Both must be called exactly once '
                  'per id.'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RadialClockDelegate extends MultiChildLayoutDelegate {
  _RadialClockDelegate();

  @override
  void performLayout(Size size) {
    final double radius = math.min(size.width, size.height) / 2 - 22;
    final Offset center = Offset(size.width / 2, size.height / 2);

    if (hasChild('hub')) {
      final Size hubSize = layoutChild(
        'hub',
        const BoxConstraints.tightFor(width: 70, height: 70),
      );
      positionChild(
          'hub', center - Offset(hubSize.width / 2, hubSize.height / 2));
    }

    for (int i = 1; i <= 12; i++) {
      final String id = 'h$i';
      if (!hasChild(id)) continue;
      final double theta = -math.pi / 2 + (i * 2 * math.pi / 12);
      final Size bubble = layoutChild(
        id,
        const BoxConstraints.tightFor(width: 36, height: 36),
      );
      final Offset target = center +
          Offset(math.cos(theta) * radius, math.sin(theta) * radius) -
          Offset(bubble.width / 2, bubble.height / 2);
      positionChild(id, target);
    }
  }

  @override
  bool shouldRelayout(_RadialClockDelegate oldDelegate) => false;
}

Widget _clockHub() {
  return Container(
    decoration: BoxDecoration(
      color: _accent,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
            color: _accent.withOpacity(0.35), blurRadius: 14, spreadRadius: 1)
      ],
    ),
    alignment: Alignment.center,
    child: const Text(
      '12h',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
    ),
  );
}

Widget _clockBubble(String label) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(color: _accent, width: 1.4),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
          color: _accent, fontWeight: FontWeight.w700, fontSize: 12),
    ),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1B2333),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final l in lines)
          Text(
            l,
            style: const TextStyle(
              color: Color(0xFFD7DEEA),
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 -- Asymmetric editor shell via CustomMultiChildLayout
// ---------------------------------------------------------------------------

Widget _buildSection6EditorShell() {
  return _panelFrame(
    number: '6',
    title: 'CustomMultiChildLayout: asymmetric editor shell',
    description:
        'An editor "shell" with a top bar, a left sidebar, a primary editor '
        'area, a right inspector and a bottom status strip. Each region is '
        'positioned and sized by an _EditorShellDelegate. The sidebar and '
        'inspector widths are computed from the container width so the layout '
        'is responsive without nesting Rows/Columns.',
    body: SizedBox(
      width: double.infinity,
      height: 280,
      child: CustomMultiChildLayout(
        delegate: _EditorShellDelegate(
          headerHeight: 32,
          footerHeight: 22,
          sidebarFraction: 0.20,
          inspectorFraction: 0.24,
        ),
        children: [
          LayoutId(id: 'header', child: _shellRegion('header', _accent)),
          LayoutId(id: 'sidebar', child: _shellRegion('sidebar', _good)),
          LayoutId(id: 'editor', child: _shellRegion('editor', _muted)),
          LayoutId(id: 'inspector', child: _shellRegion('inspector', _warn)),
          LayoutId(id: 'footer', child: _shellRegion('footer', _bad)),
        ],
      ),
    ),
  );
}

class _EditorShellDelegate extends MultiChildLayoutDelegate {
  final double headerHeight;
  final double footerHeight;
  final double sidebarFraction;
  final double inspectorFraction;

  _EditorShellDelegate({
    required this.headerHeight,
    required this.footerHeight,
    required this.sidebarFraction,
    required this.inspectorFraction,
  });

  @override
  void performLayout(Size size) {
    final double sidebarWidth = size.width * sidebarFraction;
    final double inspectorWidth = size.width * inspectorFraction;
    final double middleHeight = size.height - headerHeight - footerHeight;
    final double editorWidth = size.width - sidebarWidth - inspectorWidth;

    if (hasChild('header')) {
      layoutChild(
          'header',
          BoxConstraints.tightFor(
              width: size.width, height: headerHeight));
      positionChild('header', Offset.zero);
    }
    if (hasChild('sidebar')) {
      layoutChild('sidebar',
          BoxConstraints.tightFor(width: sidebarWidth, height: middleHeight));
      positionChild('sidebar', Offset(0, headerHeight));
    }
    if (hasChild('editor')) {
      layoutChild('editor',
          BoxConstraints.tightFor(width: editorWidth, height: middleHeight));
      positionChild('editor', Offset(sidebarWidth, headerHeight));
    }
    if (hasChild('inspector')) {
      layoutChild(
          'inspector',
          BoxConstraints.tightFor(
              width: inspectorWidth, height: middleHeight));
      positionChild(
          'inspector', Offset(sidebarWidth + editorWidth, headerHeight));
    }
    if (hasChild('footer')) {
      layoutChild('footer',
          BoxConstraints.tightFor(width: size.width, height: footerHeight));
      positionChild('footer', Offset(0, size.height - footerHeight));
    }
  }

  @override
  bool shouldRelayout(_EditorShellDelegate old) =>
      old.headerHeight != headerHeight ||
      old.footerHeight != footerHeight ||
      old.sidebarFraction != sidebarFraction ||
      old.inspectorFraction != inspectorFraction;
}

Widget _shellRegion(String label, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color.withOpacity(0.13),
      border: Border.all(color: color.withOpacity(0.6)),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
          color: color, fontWeight: FontWeight.w700, fontSize: 12.5),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 -- CustomSingleChildLayout with custom offset
// ---------------------------------------------------------------------------

Widget _buildSection7SingleChildLayout() {
  return _panelFrame(
    number: '7',
    title: 'CustomSingleChildLayout: hand-placed single child',
    description:
        'CustomSingleChildLayout takes a SingleChildLayoutDelegate that '
        'controls (a) the constraints applied to the child, (b) the size of '
        'the parent given the child size, and (c) the position of the child '
        'inside that parent. Below, three identical children are placed at '
        '"top-left", "centered", and "bottom-right" by three different '
        'delegates.',
    body: Row(
      children: [
        Expanded(
            child: _singleChildExample(
                _SingleChildAnchor.topLeft, 'top-left + 12px inset')),
        const SizedBox(width: 14),
        Expanded(
            child: _singleChildExample(
                _SingleChildAnchor.center, 'centered exactly')),
        const SizedBox(width: 14),
        Expanded(
            child: _singleChildExample(
                _SingleChildAnchor.bottomRight, 'bottom-right + 12px')),
      ],
    ),
  );
}

Widget _singleChildExample(_SingleChildAnchor anchor, String caption) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(anchor.name.toUpperCase()),
      Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(color: _panelBorder),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFAFBFE),
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomSingleChildLayout(
          delegate: _AnchorDelegate(anchor),
          child: Container(
            width: 70,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'tile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      _caption(caption),
    ],
  );
}

enum _SingleChildAnchor { topLeft, center, bottomRight }

class _AnchorDelegate extends SingleChildLayoutDelegate {
  final _SingleChildAnchor anchor;
  const _AnchorDelegate(this.anchor);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // We let the child be loose -- the child itself sets its own width/height.
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    const double pad = 12;
    switch (anchor) {
      case _SingleChildAnchor.topLeft:
        return const Offset(pad, pad);
      case _SingleChildAnchor.center:
        return Offset(
          (size.width - childSize.width) / 2,
          (size.height - childSize.height) / 2,
        );
      case _SingleChildAnchor.bottomRight:
        return Offset(
          size.width - childSize.width - pad,
          size.height - childSize.height - pad,
        );
    }
  }

  @override
  bool shouldRelayout(_AnchorDelegate old) => old.anchor != anchor;
}

// ---------------------------------------------------------------------------
// SECTION 8 -- Nested LayoutBuilders
// ---------------------------------------------------------------------------

Widget _buildSection8NestedBuilders() {
  return _panelFrame(
    number: '8',
    title: 'Nested LayoutBuilders: wide vs narrow, then small vs medium',
    description:
        'You can nest LayoutBuilders. The outer one picks a top-level "wide" '
        'or "narrow" shape; on the "wide" branch the inner LayoutBuilder '
        'further subdivides into "small" vs "medium" inner cards. Both '
        'decisions read the current constraint envelope -- they do not need '
        'MediaQuery, so the widget keeps working inside arbitrary parent '
        'sizes.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _forcedWidth(300, _nestedBuilder(), badge: 'narrow outer'),
        _forcedWidth(520, _nestedBuilder(), badge: 'wide -> small inner'),
        _forcedWidth(820, _nestedBuilder(), badge: 'wide -> medium inner'),
      ],
    ),
  );
}

Widget _nestedBuilder() {
  return LayoutBuilder(
    builder: (context, outer) {
      if (outer.maxWidth < 480) {
        return _innerCard('narrow outer\nstack-only',
            color: _warn, height: 160);
      }
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, inner) {
                if (inner.maxWidth < 320) {
                  return _innerCard('inner=small\nsingle col',
                      color: _accent, height: 160);
                }
                return Row(
                  children: [
                    Expanded(
                        child: _innerCard('inner=medium\nA',
                            color: _accent, height: 160)),
                    const SizedBox(width: 6),
                    Expanded(
                        child: _innerCard('inner=medium\nB',
                            color: _good, height: 160)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              flex: 1,
              child: _innerCard('outer\nsidebar', color: _muted, height: 160)),
        ],
      );
    },
  );
}

Widget _innerCard(String text,
    {required Color color, required double height}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.45)),
    ),
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color, fontSize: 12, fontWeight: FontWeight.w700, height: 1.3),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 -- Min/max constraint inspection
// ---------------------------------------------------------------------------

Widget _buildSection9ConstraintInspection() {
  return _panelFrame(
    number: '9',
    title: 'Min/max constraint inspection card',
    description:
        'A read-only LayoutBuilder that simply renders the BoxConstraints it '
        'received. Wrapping the same widget at three forced widths reveals '
        'exactly which minWidth/maxWidth values your subtree must respect at '
        'each breakpoint.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _forcedWidth(320, _constraintInspector(), badge: 'phone width'),
        _forcedWidth(600, _constraintInspector(), badge: 'tablet width'),
        _forcedWidth(900, _constraintInspector(), badge: 'desktop width'),
      ],
    ),
  );
}

Widget _constraintInspector() {
  return LayoutBuilder(
    builder: (context, c) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFBFE),
          border: Border.all(color: _panelBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kv('minWidth', c.minWidth.toStringAsFixed(1)),
            _kv('maxWidth', c.maxWidth.toStringAsFixed(1)),
            _kv('minHeight', c.minHeight.toStringAsFixed(1)),
            _kv(
                'maxHeight',
                c.maxHeight.isFinite
                    ? c.maxHeight.toStringAsFixed(1)
                    : 'inf'),
            const Divider(height: 18),
            _kv('hasBoundedWidth', '${c.hasBoundedWidth}'),
            _kv('hasBoundedHeight', '${c.hasBoundedHeight}'),
            _kv('isTight', '${c.isTight}'),
            _kv(
                'biggest',
                '${c.biggest.width.toStringAsFixed(0)} x ${c.biggest.height.isFinite ? c.biggest.height.toStringAsFixed(0) : 'inf'}'),
          ],
        ),
      );
    },
  );
}

Widget _kv(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            k,
            style: const TextStyle(
                fontSize: 11,
                color: _muted,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
                fontSize: 11.5,
                color: _ink,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 -- Pitfalls / do-and-don't panel
// ---------------------------------------------------------------------------

Widget _buildSection10Pitfalls() {
  return _panelFrame(
    number: '10',
    title: 'Pitfalls: when LayoutBuilder is the wrong tool',
    description:
        'LayoutBuilder forces a *layout-phase* rebuild whenever the incoming '
        'constraints change. That is great when your tree genuinely depends '
        'on the constraints, but expensive and noisy when it does not. Use '
        'it only when the layout would actually differ; otherwise prefer '
        'MediaQuery (for the outermost screen size) or static widgets.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _doPanel()),
        const SizedBox(width: 14),
        Expanded(child: _dontPanel()),
      ],
    ),
  );
}

Widget _doPanel() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _good.withOpacity(0.08),
      border: Border.all(color: _good.withOpacity(0.6)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _badgeRow('DO', _good, Icons.check),
        const SizedBox(height: 8),
        _bulletText(
            'Use LayoutBuilder when the *shape* of the subtree depends on the parent\'s constraints (1- vs 2- vs 3-column grid, rail vs drawer).'),
        _bulletText(
            'Use OrientationBuilder when the same data should be laid out differently based on aspect ratio.'),
        _bulletText(
            'Use CustomMultiChildLayout when you need free-form 2D positioning that no built-in widget can express (radial menus, asymmetric shells).'),
        _bulletText(
            'Use CustomSingleChildLayout when you need to control the constraints AND position of exactly one child.'),
      ],
    ),
  );
}

Widget _dontPanel() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bad.withOpacity(0.06),
      border: Border.all(color: _bad.withOpacity(0.6)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _badgeRow('DON\'T', _bad, Icons.block),
        const SizedBox(height: 8),
        _bulletText(
            'Don\'t wrap a widget in LayoutBuilder if its content does not actually read `constraints` -- you just paid for a relayout-time rebuild for nothing.'),
        _bulletText(
            'Don\'t call setState inside the builder closure synchronously; the framework is already laying out and will throw.'),
        _bulletText(
            'Don\'t use LayoutBuilder for top-level screen-size decisions when the answer is the same for the entire screen -- MediaQuery.of(context) is cheaper.'),
        _bulletText(
            'Don\'t forget to call layoutChild/positionChild exactly once per id inside a MultiChildLayoutDelegate.'),
      ],
    ),
  );
}

Widget _badgeRow(String label, Color color, IconData icon) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _bulletText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, right: 8),
          child: Icon(Icons.circle, size: 6, color: _ink),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: _ink, height: 1.4),
          ),
        ),
      ],
    ),
  );
}
