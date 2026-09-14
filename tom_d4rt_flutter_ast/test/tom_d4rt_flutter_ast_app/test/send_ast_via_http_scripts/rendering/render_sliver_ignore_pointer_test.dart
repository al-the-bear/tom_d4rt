// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverIgnorePointer
//
// RenderSliverIgnorePointer is a sliver render object that prevents its
// child sliver subtree from receiving pointer events (taps, drags, etc.)
// when the `ignoring` property is true. It is the sliver equivalent of
// the box-level IgnorePointer widget.
//
// This demo visualises:
//   1. Overview of RenderSliverIgnorePointer
//   2. The ignoring property: on vs off
//   3. Comparison with IgnorePointer and AbsorbPointer (box)
//   4. Hit test behaviour when ignoring
//   5. SliverIgnorePointer widget API
//   6. ignoringSemantics for screen readers
//   7. Use cases: disabled sections, overlays, loading states
//   8. Visual scroll view demonstrations
//   9. Integration patterns and best practices
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – DeepPurple / Violet
// ---------------------------------------------------------------------------
const Color _siPrimary = Color(0xFF4527A0);
const Color _siPrimaryLight = Color(0xFF5E35B1);
const Color _siAccent = Color(0xFF7C4DFF);
const Color _siAccentLight = Color(0xFFB388FF);
const Color _siSurface = Color(0xFFEDE7F6);
const Color _siSurfaceDark = Color(0xFFD1C4E9);
const Color _siOnPrimary = Color(0xFFFFFFFF);
const Color _siTextDark = Color(0xFF311B92);
const Color _siTextMedium = Color(0xFF512DA8);
const Color _siDivider = Color(0xFFB39DDB);
const Color _siGreen = Color(0xFF2E7D32);
const Color _siRed = Color(0xFFC62828);
const Color _siBlue = Color(0xFF1565C0);
const Color _siOrange = Color(0xFFE65100);
const Color _siTeal = Color(0xFF00695C);
const Color _siGrey = Color(0xFF757575);
const Color _siAmber = Color(0xFFF57F17);
const Color _siPink = Color(0xFFC2185B);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _siSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _siPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _siTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _siDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _siBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _siInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _siPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _siSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _siTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _siTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: code snippet
// ---------------------------------------------------------------------------
Widget _siCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _siSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _siPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _siSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _siSectionTitle('1 · RenderSliverIgnorePointer Overview', Icons.do_not_touch),
      _siInfoCard(
        'What is RenderSliverIgnorePointer?',
        'A sliver render object that conditionally prevents its child sliver '
            'from receiving pointer events. When ignoring is true, the hit test '
            'short-circuits — no events reach the child or its descendants.',
        Icons.block,
      ),
      _siInfoCard(
        'Widget: SliverIgnorePointer',
        'The widget-level API is SliverIgnorePointer. It creates '
            'RenderSliverIgnorePointer under the hood, and takes an ignoring '
            'parameter (bool) plus an optional ignoringSemantics parameter.',
        Icons.widgets,
        accent: _siAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _siBadge('SliverIgnorePointer', _siPrimary, _siOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _siGrey),
                _siBadge('RenderSliverIgnorePointer', _siAccent, _siOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Wraps a single child sliver and controls pointer event delivery',
              style: TextStyle(fontSize: 11, color: _siTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: The ignoring Property
// ---------------------------------------------------------------------------
Widget _siSection2IgnoringProperty() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('2 · The ignoring Property', Icons.toggle_on),
      _siInfoCard(
        'Boolean toggle',
        'ignoring is a simple bool property. When true, hitTestChildren() '
            'returns false immediately — no child is hit tested. When false, '
            'hit testing proceeds normally to the child sliver.',
        Icons.power_settings_new,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _siGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _siGreen.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, size: 28, color: _siGreen),
                    SizedBox(height: 6),
                    Text('ignoring: false', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siGreen)),
                    SizedBox(height: 4),
                    Text(
                      'Events flow to child\nnormally',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: _siTextMedium),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _siRed.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _siRed.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.do_not_touch, size: 28, color: _siRed),
                    SizedBox(height: 6),
                    Text('ignoring: true', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siRed)),
                    SizedBox(height: 4),
                    Text(
                      'Events blocked\nat this render object',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: _siTextMedium),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Comparison with Box-level Ignore/Absorb
// ---------------------------------------------------------------------------
Widget _siSection3Comparison() {
  final items = <Map<String, dynamic>>[
    {'name': 'IgnorePointer', 'scope': 'Box child', 'passes': 'Yes (through)', 'blocks': 'Child only', 'icon': Icons.do_not_touch, 'color': _siBlue},
    {'name': 'AbsorbPointer', 'scope': 'Box child', 'passes': 'No (absorbs)', 'blocks': 'Child + behind', 'icon': Icons.pan_tool, 'color': _siOrange},
    {'name': 'SliverIgnorePointer', 'scope': 'Sliver child', 'passes': 'Yes (through)', 'blocks': 'Child sliver', 'icon': Icons.do_not_touch, 'color': _siPrimary},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('3 · Comparison: Ignore vs Absorb', Icons.compare),
      _siInfoCard(
        'Three related pointer-blocking widgets',
        'IgnorePointer and AbsorbPointer work with box children. '
            'SliverIgnorePointer does the same for sliver children in a '
            'CustomScrollView. The key difference: IgnorePointer lets events '
            'pass through (hit widgets behind), AbsorbPointer stops them.',
        Icons.layers,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Comparison table', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siTextDark)),
            Divider(color: _siDivider, height: 12),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text('Widget', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _siGrey))),
                  Expanded(child: Text('Scope', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _siGrey))),
                  Expanded(child: Text('Pass-through', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _siGrey))),
                  Expanded(child: Text('Blocks', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _siGrey))),
                ],
              ),
            ),
            ...items.map((i) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(i['icon'] as IconData, size: 14, color: i['color'] as Color),
                        SizedBox(width: 4),
                        Expanded(child: Text(i['name'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: i['color'] as Color))),
                      ],
                    ),
                  ),
                  Expanded(child: Text(i['scope'] as String, style: TextStyle(fontSize: 10, color: _siTextMedium))),
                  Expanded(child: Text(i['passes'] as String, style: TextStyle(fontSize: 10, color: _siTextMedium))),
                  Expanded(child: Text(i['blocks'] as String, style: TextStyle(fontSize: 10, color: _siTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Hit Test Behaviour
// ---------------------------------------------------------------------------
Widget _siSection4HitTest() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('4 · Hit Test Behaviour', Icons.touch_app),
      _siInfoCard(
        'Short-circuit hit testing',
        'When ignoring is true, RenderSliverIgnorePointer\'s hitTestChildren() '
            'returns false immediately. The pointer event doesn\'t reach any '
            'descendant render object — it passes through as if the sliver '
            'wasn\'t there for hit testing purposes.',
        Icons.gesture,
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Stack(
          children: [
            // Layer 1: behind (receives taps when ignore is on)
            Positioned(
              left: 20, top: 20, right: 20, bottom: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: _siGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _siGreen),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.layers, size: 20, color: _siGreen),
                    Text('Widget behind (receives tap)', style: TextStyle(fontSize: 10, color: _siGreen, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            // Layer 2: ignored sliver (transparent to taps)
            Positioned(
              left: 50, top: 40, right: 50, bottom: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: _siRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _siRed, style: BorderStyle.solid),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.do_not_touch, size: 20, color: _siRed),
                    Text('SliverIgnorePointer (ignoring: true)', style: TextStyle(fontSize: 10, color: _siRed, fontWeight: FontWeight.w600)),
                    Text('taps pass through', style: TextStyle(fontSize: 9, color: _siRed)),
                  ],
                ),
              ),
            ),
            // Tap arrow
            Positioned(
              right: 20, bottom: 10,
              child: Row(
                children: [
                  Icon(Icons.touch_app, size: 16, color: _siAccent),
                  SizedBox(width: 4),
                  Text('Tap → passes through → hits green', style: TextStyle(fontSize: 9, color: _siAccent, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: SliverIgnorePointer Widget API
// ---------------------------------------------------------------------------
Widget _siSection5API() {
  final params = <Map<String, String>>[
    {'param': 'ignoring', 'type': 'bool', 'desc': 'Whether to ignore pointer events (default: true)'},
    {'param': 'ignoringSemantics', 'type': 'bool?', 'desc': 'Whether to ignore semantics too (null = follow ignoring)'},
    {'param': 'sliver', 'type': 'Widget', 'desc': 'The child sliver whose events are controlled'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('5 · SliverIgnorePointer Widget API', Icons.api),
      _siInfoCard(
        'Widget constructor',
        'SliverIgnorePointer({ignoring: true, ignoringSemantics, sliver}) '
            'creates a sliver that conditionally ignores pointer events for '
            'its child sliver.',
        Icons.code,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constructor parameters', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siTextDark)),
            Divider(color: _siDivider, height: 12),
            ...params.map((p) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: _siCode(p['param']!, color: _siPrimary),
                  ),
                  SizedBox(width: 6),
                  _siBadge(p['type']!, _siAccentLight.withValues(alpha: 0.3), _siPrimary),
                  SizedBox(width: 6),
                  Expanded(child: Text(p['desc']!, style: TextStyle(fontSize: 10, color: _siTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Code-like representation
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _siSurfaceDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _siCode('SliverIgnorePointer('),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _siCode('ignoring: isLoading,'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _siCode('sliver: SliverList(...)'),
            ),
            _siCode(')'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: ignoringSemantics
// ---------------------------------------------------------------------------
Widget _siSection6Semantics() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('6 · ignoringSemantics', Icons.accessibility),
      _siInfoCard(
        'Semantic tree control',
        'ignoringSemantics controls whether the child subtree is excluded '
            'from the semantics tree. When null, it follows the ignoring value. '
            'Set it explicitly when you want different behaviour for screen '
            'readers vs touch events.',
        Icons.hearing,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _siPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _siPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        _siBadge('null (default)', _siPrimary, _siOnPrimary),
                        SizedBox(height: 6),
                        Text('Follows ignoring', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _siTextDark)),
                        Text('Touch blocked → Semantics blocked', style: TextStyle(fontSize: 9, color: _siTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _siTeal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _siTeal.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        _siBadge('false', _siTeal, _siOnPrimary),
                        SizedBox(height: 6),
                        Text('Keep semantics', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _siTextDark)),
                        Text('Touch blocked → Still readable', style: TextStyle(fontSize: 9, color: _siTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _siRed.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _siRed.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        _siBadge('true', _siRed, _siOnPrimary),
                        SizedBox(height: 6),
                        Text('Drop semantics', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _siTextDark)),
                        Text('Completely invisible to SR', style: TextStyle(fontSize: 9, color: _siTextMedium)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Use Cases
// ---------------------------------------------------------------------------
Widget _siSection7UseCases() {
  final useCases = <Map<String, dynamic>>[
    {'title': 'Loading overlay', 'desc': 'Disable sliver interaction while data loads', 'icon': Icons.hourglass_top, 'color': _siPrimary},
    {'title': 'Modal backdrop', 'desc': 'Prevent taps on background slivers behind a dialog', 'icon': Icons.layers, 'color': _siBlue},
    {'title': 'Disabled section', 'desc': 'Grey out and disable a portion of a scroll view', 'icon': Icons.visibility_off, 'color': _siGrey},
    {'title': 'Tutorial walkthrough', 'desc': 'Block interaction except the highlighted target', 'icon': Icons.school, 'color': _siTeal},
    {'title': 'Read-only mode', 'desc': 'Allow scrolling but prevent form input in slivers', 'icon': Icons.lock, 'color': _siOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('7 · Use Cases', Icons.lightbulb),
      _siInfoCard(
        'When to use SliverIgnorePointer',
        'Use SliverIgnorePointer in CustomScrollView when you need to '
            'conditionally disable user interaction with specific slivers '
            'while keeping them visible and maintaining their layout.',
        Icons.info,
      ),
      ...useCases.map((u) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: u['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(u['icon'] as IconData, size: 18, color: u['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siTextDark)),
                  SizedBox(height: 2),
                  Text(u['desc'] as String, style: TextStyle(fontSize: 11, color: _siTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Visual Scroll View Demo
// ---------------------------------------------------------------------------
Widget _siSection8ScrollDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('8 · Visual Scroll View Demo', Icons.view_list),
      _siInfoCard(
        'Live demonstration',
        'Below is a CustomScrollView with three sliver sections. '
            'The middle sliver is wrapped in SliverIgnorePointer, showing '
            'how it visually persists but is non-interactive. Items in the '
            'top and bottom sections remain tappable.',
        Icons.preview,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _siSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CustomScrollView with SliverIgnorePointer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _siTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 200,
              child: CustomScrollView(
                slivers: [
                  // Active header
                  SliverToBoxAdapter(
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _siGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _siGreen.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, size: 14, color: _siGreen),
                          SizedBox(width: 4),
                          Text('Active section — tappable', style: TextStyle(fontSize: 10, color: _siGreen, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  // Ignored section
                  SliverIgnorePointer(
                    ignoring: true,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 80,
                        margin: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: _siRed.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _siRed.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.do_not_touch, size: 18, color: _siRed),
                                SizedBox(width: 4),
                                Text('Ignored section', style: TextStyle(fontSize: 11, color: _siRed, fontWeight: FontWeight.w700)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text('SliverIgnorePointer(ignoring: true)', style: TextStyle(fontSize: 9, color: _siRed)),
                            Text('Visible but non-interactive', style: TextStyle(fontSize: 9, color: _siGrey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Active footer
                  SliverToBoxAdapter(
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _siGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _siGreen.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, size: 14, color: _siGreen),
                          SizedBox(width: 4),
                          Text('Active section — tappable', style: TextStyle(fontSize: 10, color: _siGreen, fontWeight: FontWeight.w600)),
                        ],
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
  );
}

// ---------------------------------------------------------------------------
// Section 9: Integration Patterns
// ---------------------------------------------------------------------------
Widget _siSection9Integration() {
  final patterns = <Map<String, dynamic>>[
    {'title': 'Conditional ignoring', 'desc': 'Bind ignoring to a state variable for dynamic toggle', 'icon': Icons.toggle_on, 'color': _siPrimary},
    {'title': 'Combined with opacity', 'desc': 'Use SliverOpacity + SliverIgnorePointer for greyed-out disabled state', 'icon': Icons.opacity, 'color': _siBlue},
    {'title': 'Nested in SliverMainAxisGroup', 'desc': 'Disable a group of slivers at once', 'icon': Icons.group_work, 'color': _siTeal},
    {'title': 'Loading state pattern', 'desc': 'Toggle ignoring while loading, show progress indicator on top', 'icon': Icons.hourglass_top, 'color': _siAmber},
    {'title': 'Form validation gate', 'desc': 'Block submit section until form is valid', 'icon': Icons.check_circle_outline, 'color': _siGreen},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _siSectionTitle('9 · Integration Patterns', Icons.integration_instructions),
      _siInfoCard(
        'Common patterns',
        'SliverIgnorePointer is most useful when combined with other slivers '
            'and state management. It is a building block for complex scroll '
            'views with conditional interactivity.',
        Icons.architecture,
      ),
      ...patterns.map((p) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: p['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(p['icon'] as IconData, size: 18, color: p['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _siTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _siTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_siPrimary.withValues(alpha: 0.08), _siAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _siPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.do_not_touch, size: 32, color: _siPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverIgnorePointer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _siTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The sliver-level pointer blocker — conditionally preventing '
              'touch events from reaching child slivers while keeping them '
              'visible and maintaining scroll layout.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _siTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_siPrimary, _siPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.do_not_touch, color: _siOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverIgnorePointer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _siOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Sliver-level pointer event blocking for scroll views',
                style: TextStyle(fontSize: 12, color: _siOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _siSection1Overview(),
        _siSection2IgnoringProperty(),
        _siSection3Comparison(),
        _siSection4HitTest(),
        _siSection5API(),
        _siSection6Semantics(),
        _siSection7UseCases(),
        _siSection8ScrollDemo(),
        _siSection9Integration(),

        SizedBox(height: 24),
      ],
    ),
  );
}
