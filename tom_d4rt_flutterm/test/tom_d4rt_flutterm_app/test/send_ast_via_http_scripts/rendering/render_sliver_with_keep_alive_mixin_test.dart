// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverWithKeepAliveMixin
//
// RenderSliverWithKeepAliveMixin is a mixin applied to sliver render objects
// that need to keep child elements alive even when they scroll out of the
// viewport. This is the rendering-layer mechanism behind the
// AutomaticKeepAliveClientMixin at the widget level.
//
// Without keep-alive, sliver children are disposed when they scroll off
// screen. With keep-alive, the render object retains the child's render
// subtree, preserving state such as scroll positions, text input, animation
// progress, and network-loaded content.
//
// This demo visualises:
//   1. Overview — what keep-alive means for slivers
//   2. The keep-alive lifecycle — from alive to disposed
//   3. KeepAliveParentDataMixin — the parent data flag
//   4. How AutomaticKeepAlive requests keep-alive
//   5. Memory and performance trade-offs
//   6. Visual demo — items with keep-alive markers
//   7. When to use keep-alive vs when to avoid it
//   8. Common patterns (tabs, forms, media players)
//   9. Summary and quick reference
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Plum / Mauve
// ---------------------------------------------------------------------------
const Color _kaPrimary = Color(0xFF8E24AA);
const Color _kaPrimaryLight = Color(0xFFAB47BC);
const Color _kaAccent = Color(0xFF6A1B9A);
const Color _kaAccentLight = Color(0xFFE1BEE7);
const Color _kaSurface = Color(0xFFF3E5F5);
const Color _kaSurfaceDark = Color(0xFFE1BEE7);
const Color _kaOnPrimary = Color(0xFFFFFFFF);
const Color _kaTextDark = Color(0xFF4A148C);
const Color _kaTextMedium = Color(0xFF6A1B9A);
const Color _kaDivider = Color(0xFFCE93D8);
const Color _kaGreen = Color(0xFF2E7D32);
const Color _kaBlue = Color(0xFF1565C0);
const Color _kaOrange = Color(0xFFE65100);
const Color _kaTeal = Color(0xFF00695C);
const Color _kaGrey = Color(0xFF757575);
const Color _kaAmber = Color(0xFFF57F17);
const Color _kaRed = Color(0xFFC62828);
const Color _kaIndigo = Color(0xFF283593);
const Color _kaBrown = Color(0xFF4E342E);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _kaSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _kaPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _kaTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _kaDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _kaBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _kaInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _kaPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _kaSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kaTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _kaTextMedium, height: 1.4)),
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
Widget _kaCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _kaSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _kaAccent, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _kaSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _kaSectionTitle('1 · Keep-Alive Overview', Icons.push_pin),
      _kaInfoCard(
        'What does keep-alive mean?',
        'Normally, sliver children are disposed when they scroll off screen. '
            'Keep-alive prevents this — the child\'s render object and element '
            'tree are retained in memory so that state is preserved when the '
            'user scrolls back.',
        Icons.memory,
      ),
      _kaInfoCard(
        'Why a mixin on the render object?',
        'The keep-alive decision happens at the rendering layer. '
            'RenderSliverWithKeepAliveMixin adds the ability to check '
            'each child\'s parent data for a keepAlive flag and skip '
            'disposal for flagged children.',
        Icons.extension,
        accent: _kaAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          children: [
            Text('Without vs With Keep-Alive', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kaTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _kaBadge('Without', _kaRed, _kaOnPrimary),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _kaRed.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _kaRed.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Text('Item scrolls off', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kaRed)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaRed),
                            Text('Disposed', style: TextStyle(fontSize: 10, color: _kaRed)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaRed),
                            Text('State lost', style: TextStyle(fontSize: 10, color: _kaGrey)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaRed),
                            Text('Rebuilt on scroll back', style: TextStyle(fontSize: 10, color: _kaRed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      _kaBadge('With Keep-Alive', _kaGreen, _kaOnPrimary),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _kaGreen.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _kaGreen.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Text('Item scrolls off', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kaGreen)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaGreen),
                            Text('Kept alive (hidden)', style: TextStyle(fontSize: 10, color: _kaGreen)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaGreen),
                            Text('State preserved', style: TextStyle(fontSize: 10, color: _kaGreen)),
                            Icon(Icons.arrow_downward, size: 14, color: _kaGreen),
                            Text('Shown on scroll back', style: TextStyle(fontSize: 10, color: _kaGreen)),
                          ],
                        ),
                      ),
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

// ---------------------------------------------------------------------------
// Section 2: Keep-Alive Lifecycle
// ---------------------------------------------------------------------------
Widget _kaSection2Lifecycle() {
  final phases = <Map<String, dynamic>>[
    {'phase': 'Created', 'desc': 'Child element and render object are created when scrolling into view', 'color': _kaBlue, 'icon': Icons.add_circle},
    {'phase': 'Visible', 'desc': 'Child is laid out and painted within the viewport', 'color': _kaGreen, 'icon': Icons.visibility},
    {'phase': 'Off-screen (no keep-alive)', 'desc': 'Child is garbage collected — state is lost', 'color': _kaRed, 'icon': Icons.delete},
    {'phase': 'Off-screen (keep-alive)', 'desc': 'Child is retained but not painted, preserving state', 'color': _kaPrimary, 'icon': Icons.push_pin},
    {'phase': 'Back on-screen', 'desc': 'Child is painted again with preserved state', 'color': _kaTeal, 'icon': Icons.replay},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('2 · Keep-Alive Lifecycle', Icons.autorenew),
      _kaInfoCard(
        'Full lifecycle of a kept-alive child',
        'Understanding when children are created, retained, and potentially '
            'disposed is key to using keep-alive effectively.',
        Icons.timeline,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          children: phases.asMap().entries.map((entry) {
            final i = entry.key;
            final p = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: (p['color'] as Color).withValues(alpha: 0.06),
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
                        Text(p['phase'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: p['color'] as Color)),
                        Text(p['desc'] as String, style: TextStyle(fontSize: 10, color: _kaTextMedium)),
                      ],
                    ),
                  ),
                  if (i < phases.length - 1) Icon(Icons.arrow_downward, size: 12, color: _kaGrey),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: KeepAliveParentDataMixin
// ---------------------------------------------------------------------------
Widget _kaSection3ParentData() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('3 · KeepAliveParentDataMixin', Icons.data_object),
      _kaInfoCard(
        'The keepAlive flag on parent data',
        'Each child in a sliver has SliverMultiBoxAdaptorParentData which '
            'includes KeepAliveParentDataMixin. The mixin adds a bool '
            'keepAlive property. When true, the sliver retains the child.',
        Icons.flag,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parent data structure', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kaTextDark)),
            SizedBox(height: 8),
            _kaCode('class SliverMultiBoxAdaptorParentData'),
            _kaCode('    extends SliverLogicalParentData'),
            _kaCode('    with KeepAliveParentDataMixin {'),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kaCode('// From KeepAliveParentDataMixin'),
                  _kaCode('bool keepAlive = false;'),
                  SizedBox(height: 4),
                  _kaCode('// From SliverLogicalParentData'),
                  _kaCode('double layoutOffset = 0.0;'),
                  SizedBox(height: 4),
                  _kaCode('// Item index in the child list'),
                  _kaCode('int? index;'),
                ],
              ),
            ),
            _kaCode('}'),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kaAmber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _kaAmber, width: 3)),
              ),
              child: Text(
                'When the mixin\'s keepAlive is true, the sliver moves the '
                    'child to a "kept alive" bucket instead of destroying it during '
                    'garbage collection.',
                style: TextStyle(fontSize: 10, color: _kaTextMedium),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: AutomaticKeepAlive
// ---------------------------------------------------------------------------
Widget _kaSection4AutomaticKeepAlive() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('4 · AutomaticKeepAlive & the Widget Layer', Icons.smart_toy),
      _kaInfoCard(
        'How widgets request keep-alive',
        'At the widget layer, AutomaticKeepAliveClientMixin is mixed into '
            'a State class. It sends a KeepAliveNotification up the tree. '
            'The AutomaticKeepAlive widget (inserted by SliverList) catches '
            'it and sets keepAlive = true on the parent data.',
        Icons.notifications,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Keep-alive request flow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kaTextDark)),
            SizedBox(height: 8),
            ...[
              {'step': 'State mixes in AutomaticKeepAliveClientMixin', 'icon': Icons.extension, 'color': _kaPrimary},
              {'step': 'wantKeepAlive getter returns true', 'icon': Icons.check, 'color': _kaGreen},
              {'step': 'updateKeepAlive() sends KeepAliveNotification', 'icon': Icons.notifications_active, 'color': _kaBlue},
              {'step': 'AutomaticKeepAlive widget catches notification', 'icon': Icons.catching_pokemon, 'color': _kaOrange},
              {'step': 'Sets parentData.keepAlive = true', 'icon': Icons.flag, 'color': _kaTeal},
              {'step': 'Sliver retains child when off-screen', 'icon': Icons.push_pin, 'color': _kaAccent},
            ].map((s) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  Icon(s['icon'] as IconData, size: 14, color: s['color'] as Color),
                  SizedBox(width: 8),
                  Expanded(child: Text(s['step'] as String, style: TextStyle(fontSize: 11, color: _kaTextMedium))),
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
// Section 5: Memory Trade-offs
// ---------------------------------------------------------------------------
Widget _kaSection5Memory() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('5 · Memory & Performance Trade-offs', Icons.memory),
      _kaInfoCard(
        'Keep-alive increases memory usage',
        'Every kept-alive child remains in the render tree. For a list with '
            '1000 items where 50 are kept alive, those 50 children consume memory '
            'even when not visible. Use judiciously.',
        Icons.warning,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              color: _kaSurface,
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('Aspect', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kaTextDark))),
                  Expanded(child: Text('No Keep-Alive', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kaRed))),
                  Expanded(child: Text('With Keep-Alive', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kaGreen))),
                ],
              ),
            ),
            ...[
              {'aspect': 'Memory', 'without': 'Low (visible only)', 'with': 'Higher (retained)'},
              {'aspect': 'State', 'without': 'Lost on scroll', 'with': 'Preserved'},
              {'aspect': 'Rebuild cost', 'without': 'Full rebuild', 'with': 'Zero (reuse)'},
              {'aspect': 'Network', 'without': 'Re-fetch data', 'with': 'Data cached'},
              {'aspect': 'Animations', 'without': 'Reset', 'with': 'Continue'},
              {'aspect': 'Text input', 'without': 'Cleared', 'with': 'Preserved'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _kaDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text(r['aspect']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kaTextDark))),
                  Expanded(child: Text(r['without']!, style: TextStyle(fontSize: 10, color: _kaRed))),
                  Expanded(child: Text(r['with']!, style: TextStyle(fontSize: 10, color: _kaGreen))),
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
// Section 6: Visual Demo
// ---------------------------------------------------------------------------
Widget _kaSection6Demo() {
  // Simulate items where some are "kept alive"
  final items = List.generate(15, (i) {
    final keepAlive = i % 3 == 0; // every 3rd item
    return {
      'index': i,
      'keepAlive': keepAlive,
      'label': keepAlive ? 'Keep-Alive Item $i' : 'Regular Item $i',
    };
  });

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('6 · Visual Demo', Icons.preview),
      _kaInfoCard(
        'Items with keep-alive markers',
        'In this demo, every 3rd item simulates having keep-alive enabled. '
            'Keep-alive items are pinned (shown with a pin icon) — they would '
            'preserve state when scrolled off-screen.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _kaSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Row(
                children: [
                  Text('SliverList with keep-alive markers', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kaTextDark)),
                  SizedBox(width: 6),
                  _kaBadge('pin = keep-alive', _kaPrimary, _kaOnPrimary),
                ],
              ),
            ),
            SizedBox(
              height: 340,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, i) {
                        final item = items[i];
                        final alive = item['keepAlive'] as bool;
                        return Container(
                          height: 52,
                          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: alive ? _kaPrimary.withValues(alpha: 0.08) : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: alive ? _kaPrimary.withValues(alpha: 0.4) : _kaDivider.withValues(alpha: 0.3),
                              width: alive ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                alignment: Alignment.center,
                                child: alive
                                    ? Icon(Icons.push_pin, size: 18, color: _kaPrimary)
                                    : Text('${item['index']}', style: TextStyle(fontSize: 11, color: _kaGrey)),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['label'] as String,
                                      style: TextStyle(
                                        fontWeight: alive ? FontWeight.w700 : FontWeight.w500,
                                        fontSize: 12,
                                        color: alive ? _kaPrimary : _kaTextDark,
                                      ),
                                    ),
                                    Text(
                                      alive ? 'State preserved when off-screen' : 'State lost when off-screen',
                                      style: TextStyle(fontSize: 9, color: alive ? _kaAccent : _kaGrey),
                                    ),
                                  ],
                                ),
                              ),
                              if (alive) Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: _kaBadge('ALIVE', _kaPrimary, _kaOnPrimary),
                              ),
                            ],
                          ),
                        );
                      },
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
// Section 7: When to Use
// ---------------------------------------------------------------------------
Widget _kaSection7WhenToUse() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('7 · When to Use vs Avoid', Icons.rule),
      _kaInfoCard(
        'Choosing wisely',
        'Keep-alive is powerful but not free. Use it when state preservation '
            'matters more than memory usage. Avoid it for simple display-only items.',
        Icons.balance,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _kaBadge('Use Keep-Alive', _kaGreen, _kaOnPrimary),
                  SizedBox(height: 8),
                  ...[
                    'Form fields with user input',
                    'Video players mid-playback',
                    'Nested scroll views',
                    'Items with expensive init',
                    'Tab views in lists',
                  ].map((t) => Container(
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kaGreen.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, size: 12, color: _kaGreen),
                        SizedBox(width: 4),
                        Expanded(child: Text(t, style: TextStyle(fontSize: 10, color: _kaTextMedium))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  _kaBadge('Avoid Keep-Alive', _kaRed, _kaOnPrimary),
                  SizedBox(height: 8),
                  ...[
                    'Simple text display items',
                    'Items in very long lists',
                    'Stateless information cards',
                    'Items with minimal init',
                    'Memory-critical apps',
                  ].map((t) => Container(
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kaRed.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.cancel, size: 12, color: _kaRed),
                        SizedBox(width: 4),
                        Expanded(child: Text(t, style: TextStyle(fontSize: 10, color: _kaTextMedium))),
                      ],
                    ),
                  )),
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
// Section 8: Common Patterns
// ---------------------------------------------------------------------------
Widget _kaSection8Patterns() {
  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Tab views in a list',
      'desc': 'Each list item contains a TabBarView. Keep-alive preserves '
          'the selected tab and nested scroll position.',
      'icon': Icons.tab,
      'color': _kaPrimary,
    },
    {
      'title': 'Forms in expandable tiles',
      'desc': 'ExpansionTile items contain form fields. Without keep-alive, '
          'user input is lost when the tile scrolls off screen.',
      'icon': Icons.edit_note,
      'color': _kaBlue,
    },
    {
      'title': 'Media players',
      'desc': 'Audio/video players in a feed should preserve playback position '
          'and buffered data when scrolled off screen.',
      'icon': Icons.play_circle,
      'color': _kaOrange,
    },
    {
      'title': 'Chat messages with controllers',
      'desc': 'Chat bubbles with animation controllers or text editing '
          'controllers benefit from state preservation.',
      'icon': Icons.chat,
      'color': _kaTeal,
    },
    {
      'title': 'Data-heavy dashboard cards',
      'desc': 'Cards that load charts or compute summaries. Re-computing '
          'on every scroll-back is expensive.',
      'icon': Icons.dashboard,
      'color': _kaAmber,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('8 · Common Patterns', Icons.pattern),
      _kaInfoCard(
        'Real-world keep-alive scenarios',
        'These patterns show where keep-alive makes a tangible difference '
            'in user experience by preserving meaningful state.',
        Icons.cases,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, size: 18, color: p['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _kaTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _kaTextMedium)),
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
// Section 9: Summary
// ---------------------------------------------------------------------------
Widget _kaSection9Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _kaSectionTitle('9 · Quick Reference', Icons.menu_book),
      _kaInfoCard(
        'Key facts about keep-alive',
        'The mixin works at the rendering layer, driven by widget-level '
            'notifications. Keep it targeted — only flag children whose state '
            'is valuable enough to justify the memory cost.',
        Icons.lightbulb,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaDivider),
        ),
        child: Column(
          children: [
            ...<Map<String, String>>[
              {'label': 'Mixin', 'value': 'RenderSliverWithKeepAliveMixin'},
              {'label': 'Parent data', 'value': 'KeepAliveParentDataMixin'},
              {'label': 'Widget API', 'value': 'AutomaticKeepAliveClientMixin'},
              {'label': 'Notification', 'value': 'KeepAliveNotification'},
              {'label': 'Flag', 'value': 'parentData.keepAlive'},
              {'label': 'Effect', 'value': 'Child retained when off-screen'},
              {'label': 'Cost', 'value': 'Memory (render tree not released)'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _kaDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(r['label']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kaTextDark)),
                  ),
                  Expanded(child: Text(r['value']!, style: TextStyle(fontSize: 11, color: _kaPrimary, fontWeight: FontWeight.w600))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_kaPrimary.withValues(alpha: 0.08), _kaAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kaPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.push_pin, size: 32, color: _kaPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverWithKeepAliveMixin',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _kaTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Pin sliver children in memory — preserving state across scrolling '
              'at the cost of increased memory usage.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _kaTextMedium, height: 1.4),
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
              colors: [_kaPrimary, _kaAccent],
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
                  Icon(Icons.push_pin, color: _kaOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverWithKeepAliveMixin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _kaOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Keeping sliver children alive when they scroll off-screen',
                style: TextStyle(fontSize: 12, color: _kaOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _kaSection1Overview(),
        _kaSection2Lifecycle(),
        _kaSection3ParentData(),
        _kaSection4AutomaticKeepAlive(),
        _kaSection5Memory(),
        _kaSection6Demo(),
        _kaSection7WhenToUse(),
        _kaSection8Patterns(),
        _kaSection9Summary(),

        SizedBox(height: 24),
      ],
    ),
  );
}
