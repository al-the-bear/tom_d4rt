// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverOffstage
//
// RenderSliverOffstage is a sliver render object that conditionally removes
// its child from layout, painting, and hit testing. It is the sliver
// counterpart of the box-level Offstage widget. When offstage is true, the
// child contributes zero scroll extent and is neither painted nor hit-tested.
//
// This demo visualises:
//   1. Overview of RenderSliverOffstage
//   2. The offstage property: visible vs hidden
//   3. Layout behaviour — scroll extent impact
//   4. Painting behaviour — hidden vs visible
//   5. Hit testing when offstage
//   6. SliverOffstage widget API
//   7. Comparison with SliverVisibility, SliverOpacity, SliverIgnorePointer
//   8. Visual scroll view demonstration
//   9. Use cases and integration patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Steel / Slate
// ---------------------------------------------------------------------------
const Color _soPrimary = Color(0xFF37474F);
const Color _soPrimaryLight = Color(0xFF546E7A);
const Color _soAccent = Color(0xFF78909C);
const Color _soAccentLight = Color(0xFFB0BEC5);
const Color _soSurface = Color(0xFFECEFF1);
const Color _soSurfaceDark = Color(0xFFCFD8DC);
const Color _soOnPrimary = Color(0xFFFFFFFF);
const Color _soTextDark = Color(0xFF263238);
const Color _soTextMedium = Color(0xFF455A64);
const Color _soDivider = Color(0xFF90A4AE);
const Color _soGreen = Color(0xFF2E7D32);
const Color _soRed = Color(0xFFC62828);
const Color _soBlue = Color(0xFF1565C0);
const Color _soOrange = Color(0xFFE65100);
const Color _soTeal = Color(0xFF00695C);
const Color _soGrey = Color(0xFF757575);
const Color _soAmber = Color(0xFFF57F17);
const Color _soPurple = Color(0xFF6A1B9A);
const Color _soPink = Color(0xFFC2185B);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _soSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _soPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _soTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _soDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _soBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _soInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _soPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _soSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _soTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _soTextMedium, height: 1.4)),
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
Widget _soCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _soSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _soPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _soSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _soSectionTitle('1 · RenderSliverOffstage Overview', Icons.visibility_off),
      _soInfoCard(
        'What is RenderSliverOffstage?',
        'A sliver render object that removes its child from layout, '
            'painting, and hit testing when offstage is true. Unlike '
            'SliverOpacity (which keeps layout but hides paint), Offstage '
            'removes the child entirely — it occupies zero space.',
        Icons.hide_source,
      ),
      _soInfoCard(
        'Widget: SliverOffstage',
        'SliverOffstage is the widget API. It takes an offstage bool and '
            'a sliver child. When offstage is true, the child\'s scroll extent '
            'becomes zero and it is invisible and untouchable.',
        Icons.widgets,
        accent: _soAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _soBadge('SliverOffstage', _soPrimary, _soOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _soGrey),
                _soBadge('RenderSliverOffstage', _soAccent, _soOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Removes child from layout + paint + hit test',
              style: TextStyle(fontSize: 11, color: _soTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: offstage Property Toggle
// ---------------------------------------------------------------------------
Widget _soSection2OffstageToggle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('2 · The offstage Property', Icons.toggle_on),
      _soInfoCard(
        'Boolean toggle',
        'offstage is a bool that controls whether the child participates in '
            'the parent\'s layout. When toggled, a relayout is triggered. '
            'The child is still part of the widget tree — it is just hidden.',
        Icons.power_settings_new,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _soGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _soGreen.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility, size: 28, color: _soGreen),
                    SizedBox(height: 6),
                    Text('offstage: false', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _soGreen)),
                    SizedBox(height: 4),
                    Text(
                      'Child is visible\nOccupies scroll space\nReceives events',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: _soTextMedium),
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
                  color: _soRed.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _soRed.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility_off, size: 28, color: _soRed),
                    SizedBox(height: 6),
                    Text('offstage: true', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _soRed)),
                    SizedBox(height: 4),
                    Text(
                      'Child hidden\nZero scroll extent\nNo events, no paint',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: _soTextMedium),
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
// Section 3: Layout Behaviour
// ---------------------------------------------------------------------------
Widget _soSection3Layout() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('3 · Layout Behaviour', Icons.straighten),
      _soInfoCard(
        'Zero geometry when offstage',
        'When offstage is true, performLayout still lays out the child '
            '(so it maintains state), but the reported geometry is '
            'SliverGeometry.zero. The viewport sees the sliver as having '
            'no scroll content at all.',
        Icons.crop_square,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scroll extent comparison', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _soTextDark)),
            SizedBox(height: 8),
            // offstage: false
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _soBadge('offstage: false', _soGreen, _soOnPrimary),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _soGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text('scrollExtent: 300px', style: TextStyle(fontSize: 10, color: _soGreen, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // offstage: true
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  _soBadge('offstage: true', _soRed, _soOnPrimary),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: _soRed.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text('scrollExtent: 0px', style: TextStyle(fontSize: 10, color: _soRed, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      SizedBox(height: 6),
      _soInfoCard(
        'Child still lays out',
        'Even though geometry is zero, the child is still given constraints '
            'and performs layout. This preserves its internal state — text '
            'fields retain their content, animations continue, etc.',
        Icons.memory,
        accent: _soBlue,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Painting Behaviour
// ---------------------------------------------------------------------------
Widget _soSection4Painting() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('4 · Painting Behaviour', Icons.format_paint),
      _soInfoCard(
        'No painting when offstage',
        'paint() is completely skipped when offstage is true. The child '
            'render object exists but produces no visual output. This is '
            'different from opacity 0, where paint still runs but is invisible.',
        Icons.brush,
      ),
      Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Row(
          children: [
            // Visible state
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _soGreen.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _soGreen.withValues(alpha: 0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _soBadge('Visible (onstage)', _soGreen, _soOnPrimary),
                    SizedBox(height: 8),
                    Container(
                      width: 80, height: 40,
                      decoration: BoxDecoration(
                        color: _soBlue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _soBlue),
                      ),
                      alignment: Alignment.center,
                      child: Text('Painted', style: TextStyle(fontSize: 10, color: _soBlue, fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: 4),
                    Text('paint() runs', style: TextStyle(fontSize: 9, color: _soGreen)),
                  ],
                ),
              ),
            ),
            // Hidden state
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _soRed.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _soRed.withValues(alpha: 0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _soBadge('Hidden (offstage)', _soRed, _soOnPrimary),
                    SizedBox(height: 8),
                    Container(
                      width: 80, height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _soGrey.withValues(alpha: 0.3), style: BorderStyle.solid),
                      ),
                      alignment: Alignment.center,
                      child: Text('(nothing)', style: TextStyle(fontSize: 10, color: _soGrey, fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 4),
                    Text('paint() skipped', style: TextStyle(fontSize: 9, color: _soRed)),
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
// Section 5: Hit Testing
// ---------------------------------------------------------------------------
Widget _soSection5HitTest() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('5 · Hit Testing When Offstage', Icons.touch_app),
      _soInfoCard(
        'No hit testing',
        'When offstage is true, hitTestChildren returns false immediately. '
            'Since the child has zero geometry, it has no area to test against. '
            'Events pass through as if the sliver doesn\'t exist.',
        Icons.do_not_touch,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          children: [
            Text('Event flow with offstage sliver', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _soTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.touch_app, size: 20, color: _soPrimary),
                      Icon(Icons.arrow_downward, size: 14, color: _soGrey),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _soGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _soGreen.withValues(alpha: 0.3)),
                        ),
                        child: Text('Sliver A', style: TextStyle(fontSize: 10, color: _soGreen, fontWeight: FontWeight.w600)),
                      ),
                      Icon(Icons.arrow_downward, size: 14, color: _soGrey),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _soRed.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _soRed.withValues(alpha: 0.3), style: BorderStyle.solid),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.visibility_off, size: 10, color: _soRed),
                            SizedBox(width: 3),
                            Text('Offstage', style: TextStyle(fontSize: 10, color: _soRed)),
                          ],
                        ),
                      ),
                      Text('(skipped)', style: TextStyle(fontSize: 8, color: _soRed)),
                      Icon(Icons.arrow_downward, size: 14, color: _soGrey),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _soGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _soGreen.withValues(alpha: 0.3)),
                        ),
                        child: Text('Sliver C', style: TextStyle(fontSize: 10, color: _soGreen, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hit test order:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _soTextDark)),
                      SizedBox(height: 6),
                      _soStepText('1. Sliver A → active', _soGreen),
                      _soStepText('2. Offstage → zero size, skip', _soRed),
                      _soStepText('3. Sliver C → active', _soGreen),
                      SizedBox(height: 6),
                      Text('Offstage sliver occupies\nno space in the scroll view', style: TextStyle(fontSize: 10, color: _soGrey, fontStyle: FontStyle.italic)),
                    ],
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

Widget _soStepText(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 10, color: _soTextMedium)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: SliverOffstage Widget API
// ---------------------------------------------------------------------------
Widget _soSection6API() {
  final params = <Map<String, String>>[
    {'param': 'offstage', 'type': 'bool', 'desc': 'Whether the child is hidden (default: true)'},
    {'param': 'sliver', 'type': 'Widget', 'desc': 'The child sliver to show or hide'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('6 · SliverOffstage Widget API', Icons.api),
      _soInfoCard(
        'Simple two-parameter API',
        'SliverOffstage has just two parameters: offstage (bool) and '
            'sliver (Widget). The default is offstage: true, meaning the '
            'sliver is hidden by default.',
        Icons.code,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constructor parameters', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _soTextDark)),
            Divider(color: _soDivider, height: 12),
            ...params.map((p) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(width: 90, child: _soCode(p['param']!)),
                  SizedBox(width: 6),
                  _soBadge(p['type']!, _soAccentLight.withValues(alpha: 0.5), _soPrimary),
                  SizedBox(width: 6),
                  Expanded(child: Text(p['desc']!, style: TextStyle(fontSize: 10, color: _soTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _soSurfaceDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _soCode('SliverOffstage('),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _soCode('offstage: _isHidden,'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _soCode('sliver: SliverList(...)'),
            ),
            _soCode(')'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Comparison with Related Slivers
// ---------------------------------------------------------------------------
Widget _soSection7Comparison() {
  final items = <Map<String, dynamic>>[
    {'name': 'SliverOffstage', 'layout': 'Zero extent', 'paint': 'Skipped', 'hit': 'Skipped', 'state': 'Preserved', 'icon': Icons.visibility_off, 'color': _soPrimary},
    {'name': 'SliverOpacity(0.0)', 'layout': 'Normal', 'paint': 'Transparent', 'hit': 'Active', 'state': 'Preserved', 'icon': Icons.opacity, 'color': _soBlue},
    {'name': 'SliverIgnorePointer', 'layout': 'Normal', 'paint': 'Normal', 'hit': 'Skipped', 'state': 'Preserved', 'icon': Icons.do_not_touch, 'color': _soOrange},
    {'name': 'Remove from tree', 'layout': 'Gone', 'paint': 'Gone', 'hit': 'Gone', 'state': 'Lost', 'icon': Icons.delete, 'color': _soRed},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('7 · Comparison with Related Slivers', Icons.compare),
      _soInfoCard(
        'Four ways to hide a sliver',
        'Each approach has different trade-offs for layout, painting, '
            'hit testing, and state preservation. Offstage is unique in '
            'removing from layout while keeping state.',
        Icons.layers,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text('Widget', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _soGrey))),
                  Expanded(child: Text('Layout', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _soGrey))),
                  Expanded(child: Text('Paint', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _soGrey))),
                  Expanded(child: Text('Hit', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _soGrey))),
                  Expanded(child: Text('State', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _soGrey))),
                ],
              ),
            ),
            Divider(color: _soDivider, height: 6),
            ...items.map((i) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(i['icon'] as IconData, size: 12, color: i['color'] as Color),
                        SizedBox(width: 3),
                        Expanded(child: Text(i['name'] as String, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: i['color'] as Color))),
                      ],
                    ),
                  ),
                  Expanded(child: Text(i['layout'] as String, style: TextStyle(fontSize: 9, color: _soTextMedium))),
                  Expanded(child: Text(i['paint'] as String, style: TextStyle(fontSize: 9, color: _soTextMedium))),
                  Expanded(child: Text(i['hit'] as String, style: TextStyle(fontSize: 9, color: _soTextMedium))),
                  Expanded(child: Text(i['state'] as String, style: TextStyle(fontSize: 9, color: _soTextMedium))),
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
// Section 8: Visual Scroll Demo
// ---------------------------------------------------------------------------
Widget _soSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('8 · Visual Scroll View Demo', Icons.preview),
      _soInfoCard(
        'Live demonstration',
        'Below is a CustomScrollView with three sliver sections. '
            'The middle section is wrapped in SliverOffstage(offstage: true), '
            'removing it entirely from the scroll layout. Notice how the '
            'first and third sections appear adjacent with no gap.',
        Icons.view_list,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _soSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CustomScrollView with SliverOffstage', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _soTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 220,
              child: CustomScrollView(
                slivers: [
                  // Section 1 — visible
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _soGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _soGreen.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility, size: 14, color: _soGreen),
                          SizedBox(width: 4),
                          Text('Section 1 — Visible', style: TextStyle(fontSize: 11, color: _soGreen, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  // Section 2 — offstage (hidden)
                  SliverOffstage(
                    offstage: true,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 80,
                        margin: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: _soRed.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _soRed),
                        ),
                        alignment: Alignment.center,
                        child: Text('Section 2 — OFFSTAGE (you should not see this)', style: TextStyle(fontSize: 11, color: _soRed)),
                      ),
                    ),
                  ),
                  // Section 3 — visible
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _soGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _soGreen.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility, size: 14, color: _soGreen),
                          SizedBox(width: 4),
                          Text('Section 3 — Visible (directly after 1)', style: TextStyle(fontSize: 11, color: _soGreen, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  // Explanation
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _soPrimary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _soPrimary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 14, color: _soPrimary),
                          SizedBox(width: 6),
                          Expanded(child: Text(
                            'Section 2 exists in the widget tree but is offstage. '
                            'Sections 1 and 3 are adjacent — no gap where 2 would be.',
                            style: TextStyle(fontSize: 10, color: _soTextMedium),
                          )),
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
// Section 9: Use Cases and Patterns
// ---------------------------------------------------------------------------
Widget _soSection9UseCases() {
  final useCases = <Map<String, dynamic>>[
    {'title': 'Conditional sections', 'desc': 'Show/hide sliver sections based on user preferences or feature flags', 'icon': Icons.toggle_on, 'color': _soPrimary},
    {'title': 'Lazy feature gating', 'desc': 'Keep premium content built but offstage until purchase', 'icon': Icons.lock_open, 'color': _soBlue},
    {'title': 'A/B testing', 'desc': 'Show different sliver layouts to different user segments', 'icon': Icons.science, 'color': _soTeal},
    {'title': 'Progressive disclosure', 'desc': 'Reveal sliver sections as user progresses through a flow', 'icon': Icons.unfold_more, 'color': _soOrange},
    {'title': 'Debug overlays', 'desc': 'Add debug slivers that are offstage in production', 'icon': Icons.bug_report, 'color': _soPurple},
    {'title': 'Preloading content', 'desc': 'Build expensive slivers offstage before revealing them instantly', 'icon': Icons.speed, 'color': _soAmber},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _soSectionTitle('9 · Use Cases & Patterns', Icons.lightbulb),
      _soInfoCard(
        'When to use SliverOffstage',
        'Use SliverOffstage when you need to completely remove a sliver from '
            'layout (no gap) while preserving its internal state. If you just '
            'want to hide visually but keep layout space, use SliverOpacity instead.',
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
                  Text(u['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _soTextDark)),
                  SizedBox(height: 2),
                  Text(u['desc'] as String, style: TextStyle(fontSize: 11, color: _soTextMedium)),
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
            colors: [_soPrimary.withValues(alpha: 0.08), _soAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _soPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.visibility_off, size: 32, color: _soPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverOffstage',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _soTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Total sliver removal from layout while preserving state — '
              'the sliver disappears from scroll extent, painting, and '
              'hit testing as if it never existed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _soTextMedium, height: 1.4),
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
              colors: [_soPrimary, _soPrimaryLight],
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
                  Icon(Icons.visibility_off, color: _soOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverOffstage',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _soOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Conditionally removing a sliver from layout, paint, and hit test',
                style: TextStyle(fontSize: 12, color: _soOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _soSection1Overview(),
        _soSection2OffstageToggle(),
        _soSection3Layout(),
        _soSection4Painting(),
        _soSection5HitTest(),
        _soSection6API(),
        _soSection7Comparison(),
        _soSection8Demo(),
        _soSection9UseCases(),

        SizedBox(height: 24),
      ],
    ),
  );
}
