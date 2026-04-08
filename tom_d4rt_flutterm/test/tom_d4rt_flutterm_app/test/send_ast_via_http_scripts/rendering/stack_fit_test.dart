// ignore_for_file: avoid_print
// Deep demo: StackFit
// Demonstrates the StackFit enum that controls how the Stack widget
// sizes its non-positioned children: loose, expand, and passthrough.
import 'package:flutter/material.dart';

// ─── palette: Rose / Pink Cream ───────────────────────────────────
const Color _sfRose = Color(0xFF880E4F);
const Color _sfPink = Color(0xFFFCE4EC);
const Color _sfAccent = Color(0xFFEC407A);
const Color _sfDark = Color(0xFF212121);
const Color _sfGood = Color(0xFF2E7D32);
const Color _sfWarn = Color(0xFFE65100);
const Color _sfBlue = Color(0xFF1565C0);

// ─── text helpers ─────────────────────────────────────────────────
Widget _sfTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _sfRose,
              letterSpacing: 0.3)),
    );

Widget _sfSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _sfAccent)),
    );

Widget _sfBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _sfCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _sfDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFF48FB1),
              height: 1.5)),
    );

Widget _sfNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _sfPink,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _sfRose.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _sfRose),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _sfRose, height: 1.4)),
          ),
        ],
      ),
    );

Widget _sfDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _sfRose.withValues(alpha: 0.12)),
    );

Widget _sfBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _sfAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _sfTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _sfLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _sfRose,
        letterSpacing: 0.2));

Widget _sfSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual building blocks ───────────────────────────────────────

/// A mock stack frame showing children inside.
Widget _sfStackFrame(String title, double width, double height,
    List<Widget> layers) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _sfRose.withValues(alpha: 0.3), width: 1.5),
    ),
    child: Stack(
      children: [
        ...layers,
        Positioned(
          bottom: 2,
          right: 4,
          child: Text(title,
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: _sfRose)),
        ),
      ],
    ),
  );
}

/// A child widget inside a mock stack.
Widget _sfChild(String label, Color c, double w, double h,
    {double? left, double? top}) {
  return Positioned(
    left: left ?? 4,
    top: top ?? 4,
    child: Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c, width: 1),
      ),
      child: Center(
        child: Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
    ),
  );
}

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _sfBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_sfRose, Color(0xFFAD1457)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.layers_outlined, size: 48, color: _sfPink),
          const SizedBox(height: 10),
          const Text('StackFit',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Controls how Stack sizes non-positioned children',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _sfTag('rendering', _sfAccent),
              _sfTag('enum', _sfBlue),
              _sfTag('layout', _sfGood),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is StackFit? ────────────────────────────────────────
List<Widget> _sfWhatIs() => [
      _sfTitle('§2  What Is StackFit?'),
      _sfBody(
          'StackFit is an enum that determines the BoxConstraints given to '
          'non-positioned children of a Stack. It controls whether children '
          'are free to choose their size, forced to expand, or given the '
          'exact constraints from the parent.'),
      _sfCode(
          'enum StackFit {\n'
          '  loose,       // min=0, max=stack size\n'
          '  expand,      // min=max=stack size (tight)\n'
          '  passthrough, // forward parent constraints unchanged\n'
          '}'),
      _sfBody(
          'The Stack sizes itself based on its non-positioned children '
          '(or fills the parent if alignment is used). Then it applies '
          'the StackFit to determine how to constrain those same '
          'non-positioned children.'),
      _sfNote(
          'Positioned children are NOT affected by StackFit. They get '
          'constraints derived from their positional properties.'),
    ];

// ─── §3 The three enum values ────────────────────────────────────
List<Widget> _sfEnumValues() => [
      _sfDivider(),
      _sfTitle('§3  The Three Enum Values'),
      _sfSubtitle('loose (default)'),
      _sfBody(
          'The non-positioned children are given loose constraints: '
          'minWidth=0, minHeight=0, maxWidth=stackWidth, '
          'maxHeight=stackHeight. Children can be any size from 0 '
          'to the stack size.'),
      _sfBullet('Behavior', 'Children choose their own size'),
      _sfBullet('Common use', 'Default — children have intrinsic sizes'),
      _sfSubtitle('expand'),
      _sfBody(
          'The non-positioned children are given tight constraints: '
          'minWidth=maxWidth=stackWidth, minHeight=maxHeight=stackHeight. '
          'Children MUST be exactly the stack size.'),
      _sfBullet('Behavior', 'Children forced to fill the stack'),
      _sfBullet('Common use', 'Background layers, overlay panels'),
      _sfSubtitle('passthrough'),
      _sfBody(
          'The constraints from the parent are passed to non-positioned '
          'children unchanged. This is useful when you want children to '
          'receive the original constraints instead of the stack-derived ones.'),
      _sfBullet('Behavior', 'Parent constraints forwarded as-is'),
      _sfBullet('Common use', 'Nested stacks, constraint-sensitive children'),
    ];

// ─── §4 Visual: loose ────────────────────────────────────────────
List<Widget> _sfLooseVisual() => [
      _sfDivider(),
      _sfTitle('§4  Visual: StackFit.loose'),
      _sfBody(
          'With loose fit, each non-positioned child chooses its own size. '
          'Small children stay small; large children can grow up to the '
          'stack size.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _sfLabel('Stack (200 x 150) with StackFit.loose'),
            const SizedBox(height: 10),
            Center(
              child: _sfStackFrame('loose', 200, 150, [
                _sfChild('Child A\n60x40', _sfRose, 60, 40),
                _sfChild('Child B\n120x80', _sfAccent, 120, 80,
                    left: 30, top: 30),
                _sfChild('Child C\n40x30', _sfBlue, 40, 30,
                    left: 10, top: 100),
              ]),
            ),
            const SizedBox(height: 8),
            _sfSmall(
                'Each child sizes itself freely (min=0, max=stack size)'),
          ],
        ),
      ),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.loose,  // default\n'
          '  children: [\n'
          '    Container(width: 60, height: 40, color: red),\n'
          '    Container(width: 120, height: 80, color: pink),\n'
          '    Container(width: 40, height: 30, color: blue),\n'
          '  ],\n'
          ')'),
      _sfBody(
          'The constraints given to each child: '
          'BoxConstraints(0<=w<=200, 0<=h<=150). The child picks its '
          'preferred size within those bounds.'),
    ];

// ─── §5 Visual: expand ───────────────────────────────────────────
List<Widget> _sfExpandVisual() => [
      _sfDivider(),
      _sfTitle('§5  Visual: StackFit.expand'),
      _sfBody(
          'With expand fit, every non-positioned child is forced to be '
          'exactly the stack size. All children fill the stack completely.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _sfLabel('Stack (200 x 150) with StackFit.expand'),
            const SizedBox(height: 10),
            Center(
              child: _sfStackFrame('expand', 200, 150, [
                _sfChild('Child A\n(fills stack)', _sfRose.withValues(alpha: 0.4),
                    192, 138),
                _sfChild('Child B\n(fills stack)', _sfAccent.withValues(alpha: 0.5),
                    192, 138),
                _sfChild('Child C\n(on top, fills stack)', _sfBlue, 192, 138),
              ]),
            ),
            const SizedBox(height: 8),
            _sfSmall(
                'All children are the same size: exactly 200x150'),
          ],
        ),
      ),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.expand,\n'
          '  children: [\n'
          '    Container(color: red),    // forced to 200x150\n'
          '    Container(color: pink),   // forced to 200x150\n'
          '    Container(color: blue),   // forced to 200x150\n'
          '  ],\n'
          ')'),
      _sfBody(
          'The constraints given to each child: '
          'BoxConstraints(w=200, h=150). Tight constraints — children '
          'must be exactly this size regardless of their preferred size.'),
    ];

// ─── §6 Visual: passthrough ──────────────────────────────────────
List<Widget> _sfPassthroughVisual() => [
      _sfDivider(),
      _sfTitle('§6  Visual: StackFit.passthrough'),
      _sfBody(
          'With passthrough, the parent constraints are forwarded '
          'unchanged. If the parent says "width: 100-300, height: 50-200", '
          'the children receive exactly those constraints.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _sfLabel('Parent gives: 100<=w<=300, 50<=h<=200'),
            const SizedBox(height: 10),
            Center(
              child: _sfStackFrame('passthrough', 200, 150, [
                _sfChild('Child A\nuses 100x50', _sfRose, 100, 50),
                _sfChild('Child B\nuses 200x150', _sfAccent, 192, 138,
                    left: 4, top: 4),
                _sfChild('Child C\nuses 150x100', _sfBlue, 150, 100,
                    left: 20, top: 30),
              ]),
            ),
            const SizedBox(height: 8),
            _sfSmall(
                'Children get parent constraints: not stack-derived'),
          ],
        ),
      ),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.passthrough,\n'
          '  children: [\n'
          '    // Gets parent constraints directly:\n'
          '    // BoxConstraints(100<=w<=300, 50<=h<=200)\n'
          '    Container(width: 100, height: 50, color: red),\n'
          '    Container(width: 200, height: 150, color: pink),\n'
          '    Container(width: 150, height: 100, color: blue),\n'
          '  ],\n'
          ')'),
      _sfNote(
          'passthrough is rarely used. It is useful when a Stack is nested '
          'inside another layout widget and you want children to respect '
          'the outer constraints, not the stack size.'),
    ];

// ─── §7 How Stack applies fit during layout ──────────────────────
List<Widget> _sfLayoutFlow() => [
      _sfDivider(),
      _sfTitle('§7  How Stack Applies Fit During Layout'),
      _sfBody(
          'During performLayout, the RenderStack computes the constraints '
          'for non-positioned children based on the StackFit:'),
      _sfCode(
          '@override\n'
          'void performLayout() {\n'
          '  // 1. Determine the stack size from incoming constraints\n'
          '  //    and the largest non-positioned child\n'
          '\n'
          '  // 2. For each non-positioned child:\n'
          '  BoxConstraints childConstraints;\n'
          '  switch (fit) {\n'
          '    case StackFit.loose:\n'
          '      childConstraints = BoxConstraints.loose(size);\n'
          '    case StackFit.expand:\n'
          '      childConstraints = BoxConstraints.tight(size);\n'
          '    case StackFit.passthrough:\n'
          '      childConstraints = constraints; // from parent\n'
          '  }\n'
          '  child.layout(childConstraints, parentUsesSize: true);\n'
          '\n'
          '  // 3. Position each child based on alignment\n'
          '}'),
      _sfSubtitle('Constraint transformation'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sfConstraintRow('StackFit', 'min', 'max', isHeader: true),
            _sfConstraintRow('loose', '0', 'stack size'),
            _sfConstraintRow('expand', 'stack size', 'stack size'),
            _sfConstraintRow('passthrough', 'parent min', 'parent max'),
          ],
        ),
      ),
      _sfBody(
          'The key insight: loose and expand derive constraints from the '
          'stack size (which is already determined). Passthrough ignores '
          'the stack size and uses the raw parent constraints.'),
    ];

Widget _sfConstraintRow(String fit, String min, String max,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 12,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _sfRose : Colors.black87,
    fontFamily: isHeader ? null : 'monospace',
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 100, child: Text(fit, style: style)),
        Expanded(child: Text(min, style: style.copyWith(fontFamily: null))),
        Expanded(child: Text(max, style: style.copyWith(fontFamily: null))),
      ],
    ),
  );
}

// ─── §8 Interaction with Positioned ──────────────────────────────
List<Widget> _sfPositioned() => [
      _sfDivider(),
      _sfTitle('§8  Interaction With Positioned Children'),
      _sfBody(
          'StackFit ONLY affects non-positioned children. Positioned children '
          'get their constraints from the positional properties (left, right, '
          'top, bottom, width, height):'),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.expand,\n'
          '  children: [\n'
          '    // Non-positioned: FORCED to stack size\n'
          '    Container(color: Colors.red),\n'
          '\n'
          '    // Positioned: constraints from position props\n'
          '    Positioned(\n'
          '      left: 10, top: 10, width: 100, height: 50,\n'
          '      child: Container(color: Colors.blue),\n'
          '    ),\n'
          '  ],\n'
          ')'),
      _sfSubtitle('Visual: expand with positioned child'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: _sfStackFrame('expand + Positioned', 200, 130, [
            // Non-positioned: fills everything
            _sfChild('Background\n(expand = fills)', _sfRose.withValues(alpha: 0.3),
                192, 118),
            // Positioned: respects its props
            _sfChild('Positioned\n100x50', _sfBlue, 100, 50,
                left: 10, top: 10),
          ]),
        ),
      ),
      _sfSmall(
          'Red background fills stack (StackFit.expand); blue uses Positioned constraints'),
      _sfNote(
          'The Stack first lays out non-positioned children to determine '
          'its own size, then lays out positioned children using their '
          'positional properties.'),
    ];

// ─── §9 Side-by-side comparison ──────────────────────────────────
List<Widget> _sfComparison() => [
      _sfDivider(),
      _sfTitle('§9  Side-by-Side Comparison'),
      _sfBody(
          'All three StackFit values with the same Stack and children:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _sfLabel('loose'),
                      const SizedBox(height: 4),
                      _sfStackFrame('', 100, 80, [
                        _sfChild('A\n40x30', _sfRose, 40, 30),
                        _sfChild('B\n60x50', _sfBlue, 60, 50,
                            left: 20, top: 20),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    children: [
                      _sfLabel('expand'),
                      const SizedBox(height: 4),
                      _sfStackFrame('', 100, 80, [
                        _sfChild('A\nfills', _sfRose, 92, 68),
                        _sfChild('B\nfills', _sfBlue, 92, 68),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    children: [
                      _sfLabel('passthrough'),
                      const SizedBox(height: 4),
                      _sfStackFrame('', 100, 80, [
                        _sfChild('A\nparent\nconstrs', _sfRose, 55, 50),
                        _sfChild('B\nparent\nconstrs', _sfBlue, 70, 60,
                            left: 15, top: 10),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _sfSmall('Same children, different constraint behavior'),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sfCmpRow('Property', 'loose', 'expand', 'passthrough',
                isHeader: true),
            _sfCmpRow('Default?', 'Yes', 'No', 'No'),
            _sfCmpRow('Constraints', 'Loose', 'Tight', 'Parent'),
            _sfCmpRow('Child size', 'Intrinsic', 'Stack size', 'Varies'),
            _sfCmpRow('Overflow', 'No', 'No', 'Possible'),
            _sfCmpRow('Use case', 'General', 'Backgrounds', 'Nested'),
          ],
        ),
      ),
    ];

Widget _sfCmpRow(String prop, String v1, String v2, String v3,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _sfRose : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 72, child: Text(prop, style: style)),
        Expanded(child: Text(v1, style: style)),
        Expanded(child: Text(v2, style: style)),
        Expanded(child: Text(v3, style: style)),
      ],
    ),
  );
}

// ─── §10 Common use patterns ─────────────────────────────────────
List<Widget> _sfPatterns() => [
      _sfDivider(),
      _sfTitle('§10  Common Use Patterns'),
      _sfSubtitle('Pattern 1: Background + foreground'),
      _sfBody(
          'Use expand to make a background image fill the stack, then '
          'overlay content on top:'),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.expand,\n'
          '  children: [\n'
          '    Image.network(url, fit: BoxFit.cover),  // fills\n'
          '    Container(\n'
          '      color: Colors.black54,  // overlay\n'
          '    ),\n'
          '    Center(child: Text("Hello")),  // centered text\n'
          '  ],\n'
          ')'),
      _sfSubtitle('Pattern 2: Overlapping cards'),
      _sfBody(
          'Use loose to let cards size themselves naturally:'),
      _sfCode(
          'Stack(\n'
          '  fit: StackFit.loose,  // default\n'
          '  alignment: Alignment.center,\n'
          '  children: [\n'
          '    Card(child: Padding(padding: p16, child: bigContent)),\n'
          '    Card(child: Padding(padding: p8, child: badge)),\n'
          '  ],\n'
          ')'),
      _sfSubtitle('Pattern 3: Nested constraint forwarding'),
      _sfBody(
          'Use passthrough when wrapping a Stack in a LayoutBuilder:'),
      _sfCode(
          'LayoutBuilder(\n'
          '  builder: (context, constraints) {\n'
          '    return Stack(\n'
          '      fit: StackFit.passthrough,\n'
          '      children: [\n'
          '        // Children receive LayoutBuilder constraints\n'
          '        MyWidget(), // sees original parent constraints\n'
          '      ],\n'
          '    );\n'
          '  },\n'
          ')'),
    ];

// ─── §11 Gotchas and edge cases ──────────────────────────────────
List<Widget> _sfGotchas() => [
      _sfDivider(),
      _sfTitle('§11  Gotchas and Edge Cases'),
      _sfSubtitle('1. UnconstrainedBox inside an expand stack'),
      _sfBody(
          'If a child is wrapped in UnconstrainedBox inside a StackFit.expand '
          'stack, the UnconstrainedBox will remove the tight constraints, '
          'and the child can be any size. This may cause overflow.'),
      _sfSubtitle('2. passthrough with unbounded constraints'),
      _sfBody(
          'If the parent gives unbounded constraints (e.g., inside a '
          'ListView), passthrough forwards those. Children that expect '
          'bounded constraints will fail with an assertion.'),
      _sfSubtitle('3. expand when Stack has no non-positioned children'),
      _sfBody(
          'If all children are Positioned, the stack size is determined by '
          'the parent constraints, not children. The fit value is irrelevant '
          'because there are no non-positioned children to constrain.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _sfPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sfLabel('Gotcha summary'),
            const SizedBox(height: 8),
            _sfGotchaRow(Icons.warning_amber, 'expand + UnconstrainedBox',
                'Constraint override — may overflow', _sfWarn),
            _sfGotchaRow(Icons.warning_amber, 'passthrough + unbounded',
                'Assertion failure if child expects bounds', _sfWarn),
            _sfGotchaRow(Icons.check_circle_outline, 'expand + all Positioned',
                'fit is ignored — no non-positioned children', _sfGood),
          ],
        ),
      ),
      _sfNote(
          'When in doubt, use StackFit.loose (the default). It is the '
          'safest option and works well for most layouts.'),
    ];

Widget _sfGotchaRow(IconData icon, String title, String desc, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: c),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                Text(desc,
                    style: TextStyle(fontSize: 10.5, color: c)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §12 Summary ─────────────────────────────────────────────────
List<Widget> _sfSummary() => [
      _sfDivider(),
      _sfTitle('§12  Summary'),
      _sfBody(
          'StackFit gives you control over how the Stack constrains its '
          'non-positioned children. The three values cover the full range: '
          'from flexible (loose) to rigid (expand) to transparent '
          '(passthrough).'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _sfRose.withValues(alpha: 0.08),
              _sfPink,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _sfRose.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _sfRose)),
            const SizedBox(height: 10),
            _sfSummPt('loose',
                'Default — children size freely, 0 to stack size'),
            _sfSummPt('expand',
                'Children forced to match stack size (tight constraints)'),
            _sfSummPt('passthrough',
                'Parent constraints forwarded unchanged'),
            _sfSummPt('Positioned',
                'Not affected by StackFit — always uses position props'),
            _sfSummPt('Layout order',
                'Non-positioned laid out first to determine stack size'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _sfRose,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of StackFit Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _sfSummPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _sfGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _sfRose)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sfBanner(),
        const SizedBox(height: 20),
        ..._sfWhatIs(),
        ..._sfEnumValues(),
        ..._sfLooseVisual(),
        ..._sfExpandVisual(),
        ..._sfPassthroughVisual(),
        ..._sfLayoutFlow(),
        ..._sfPositioned(),
        ..._sfComparison(),
        ..._sfPatterns(),
        ..._sfGotchas(),
        ..._sfSummary(),
      ],
    ),
  );
}
