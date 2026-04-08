// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverMultiBoxAdaptor
//
// RenderSliverMultiBoxAdaptor is the abstract base class for slivers that
// contain multiple box children which are lazily created, laid out, and
// garbage-collected. SliverList, SliverFixedExtentList, and SliverGrid all
// extend this class.
//
// This demo visualises:
//   1. Overview — what is RenderSliverMultiBoxAdaptor
//   2. Lazy child management — creating children on demand
//   3. KeepAlive mechanism — retaining off-screen children
//   4. Garbage collection — reclaiming off-screen children
//   5. RenderSliverBoxChildManager delegate
//   6. indexOf and child ordering — linked list traversal
//   7. Paint and hit test — rendering visible children
//   8. Visual scroll demonstration
//   9. Practical patterns and best practices
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Olive / Forest
// ---------------------------------------------------------------------------
const Color _baPrimary = Color(0xFF33691E);
const Color _baPrimaryLight = Color(0xFF558B2F);
const Color _baAccent = Color(0xFF76FF03);
const Color _baAccentLight = Color(0xFFCCFF90);
const Color _baSurface = Color(0xFFF1F8E9);
const Color _baSurfaceDark = Color(0xFFDCEDC8);
const Color _baOnPrimary = Color(0xFFFFFFFF);
const Color _baTextDark = Color(0xFF1B5E20);
const Color _baTextMedium = Color(0xFF388E3C);
const Color _baDivider = Color(0xFFA5D6A7);
const Color _baGreen = Color(0xFF2E7D32);
const Color _baBlue = Color(0xFF1565C0);
const Color _baOrange = Color(0xFFE65100);
const Color _baTeal = Color(0xFF00695C);
const Color _baGrey = Color(0xFF757575);
const Color _baAmber = Color(0xFFF57F17);
const Color _baRed = Color(0xFFC62828);
const Color _baIndigo = Color(0xFF283593);
const Color _baPurple = Color(0xFF6A1B9A);
const Color _baPink = Color(0xFFC2185B);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _baSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _baPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _baTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _baDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _baBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _baInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _baPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _baSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _baTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _baTextMedium, height: 1.4)),
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
Widget _baCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _baSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _baPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _baSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _baSectionTitle('1 · RenderSliverMultiBoxAdaptor Overview', Icons.view_list),
      _baInfoCard(
        'What is RenderSliverMultiBoxAdaptor?',
        'An abstract base class for sliver render objects that manage '
            'multiple box children. It handles lazy child creation, '
            'garbage collection of off-screen children, and KeepAlive '
            'management. SliverList and SliverGrid both extend it.',
        Icons.account_tree,
      ),
      _baInfoCard(
        'Key subclasses',
        'RenderSliverList, RenderSliverFixedExtentList, and '
            'RenderSliverGrid all extend this class. They differ in '
            'how they calculate child positions — this base class provides '
            'the child management plumbing.',
        Icons.class_,
        accent: _baAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          children: [
            _baBadge('RenderSliverMultiBoxAdaptor', _baPrimary, _baOnPrimary),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _baGrey),
                    SizedBox(height: 2),
                    _baBadge('SliverList', _baBlue, _baOnPrimary),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _baGrey),
                    SizedBox(height: 2),
                    _baBadge('SliverFixedExtentList', _baTeal, _baOnPrimary),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _baGrey),
                    SizedBox(height: 2),
                    _baBadge('SliverGrid', _baOrange, _baOnPrimary),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'All share the same child management infrastructure',
              style: TextStyle(fontSize: 10, color: _baTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Lazy Child Management
// ---------------------------------------------------------------------------
Widget _baSection2LazyManagement() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('2 · Lazy Child Management', Icons.dynamic_feed),
      _baInfoCard(
        'Children created on demand',
        'Unlike RenderBox which has all children in memory at once, '
            'RenderSliverMultiBoxAdaptor creates children lazily via '
            'its childManager. Only children near the visible area are '
            'materialised. This allows lists of thousands of items without '
            'creating thousands of widgets.',
        Icons.memory,
      ),
      Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Stack(
          children: [
            // Total list indicator
            Positioned(
              left: 10, top: 10, right: 10,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: _baGrey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _baGrey.withValues(alpha: 0.2), style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 4),
                    Text('10,000 items (logical)', style: TextStyle(fontSize: 9, color: _baGrey)),
                  ],
                ),
              ),
            ),
            // Off-screen before (not created)
            Positioned(
              left: 20, top: 25, right: 20,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  color: _baGrey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text('items 0–95  ·  not created', style: TextStyle(fontSize: 9, color: _baGrey)),
              ),
            ),
            // Cached before
            Positioned(
              left: 20, top: 53, right: 20,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: _baAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _baAmber.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('96–99  ·  cached (cacheExtent)', style: TextStyle(fontSize: 9, color: _baAmber)),
              ),
            ),
            // Visible
            Positioned(
              left: 20, top: 76, right: 20,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _baGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _baGreen.withValues(alpha: 0.5)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility, size: 14, color: _baGreen),
                    Text('100–109  ·  visible', style: TextStyle(fontSize: 9, color: _baGreen, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            // Cached after
            Positioned(
              left: 20, top: 119, right: 20,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: _baAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _baAmber.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('110–113  ·  cached (cacheExtent)', style: TextStyle(fontSize: 9, color: _baAmber)),
              ),
            ),
            // Off-screen after
            Positioned(
              left: 20, top: 142, right: 20,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  color: _baGrey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text('114–9999  ·  not created', style: TextStyle(fontSize: 9, color: _baGrey)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: KeepAlive Mechanism
// ---------------------------------------------------------------------------
Widget _baSection3KeepAlive() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('3 · KeepAlive Mechanism', Icons.favorite),
      _baInfoCard(
        'What is KeepAlive?',
        'Some children need to stay alive even when scrolled off-screen '
            '— for example, a text field with user input. The KeepAlive '
            'mechanism marks children via AutomaticKeepAliveClientMixin, '
            'and the adaptor retains them in a separate list rather than '
            'removing them during garbage collection.',
        Icons.bookmark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _baGreen.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _baGreen.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.delete_outline, size: 22, color: _baGreen),
                        SizedBox(height: 4),
                        Text('Normal child', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _baGreen)),
                        SizedBox(height: 4),
                        Text(
                          'Disposed when scrolled out of cache region',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: _baTextMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _baPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _baPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.favorite, size: 22, color: _baPrimary),
                        SizedBox(height: 4),
                        Text('KeepAlive child', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _baPrimary)),
                        SizedBox(height: 4),
                        Text(
                          'Retained in memory, kept alive until wantKeepAlive = false',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: _baTextMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 14, color: _baBlue),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'KeepAlive children are stored with a KeepAliveParentDataMixin '
                    'that flags them during garbage collection.',
                    style: TextStyle(fontSize: 10, color: _baBlue),
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
// Section 4: Garbage Collection
// ---------------------------------------------------------------------------
Widget _baSection4GarbageCollection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('4 · Garbage Collection', Icons.auto_delete),
      _baInfoCard(
        'Reclaiming off-screen children',
        'During layout, the adaptor calls collectGarbage() to remove '
            'children that have scrolled beyond the cache extent. This '
            'destroys the Element and RenderObject for each garbage-collected '
            'child, freeing memory. KeepAlive children are excluded.',
        Icons.cleaning_services,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Garbage collection flow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _baTextDark)),
            SizedBox(height: 8),
            _baGCStep('1. Layout determines visible range', _baPrimary, Icons.straighten),
            _baGCStep('2. Identify children outside visible + cache', _baOrange, Icons.search),
            _baGCStep('3. Check KeepAlive flag on each', _baBlue, Icons.favorite_border),
            _baGCStep('4. Call childManager.removeChild() for non-kept', _baRed, Icons.delete),
            _baGCStep('5. Move kept children to _keepAliveBucket', _baGreen, Icons.bookmark),
            _baGCStep('6. Remaining children form new visible set', _baTeal, Icons.check_circle),
          ],
        ),
      ),
    ],
  );
}

Widget _baGCStep(String text, Color color, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: _baTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Child Manager Delegate
// ---------------------------------------------------------------------------
Widget _baSection5ChildManager() {
  final methods = <Map<String, String>>[
    {'method': 'createChild', 'desc': 'Creates a new child widget at given index'},
    {'method': 'removeChild', 'desc': 'Removes a child that is no longer needed'},
    {'method': 'estimateMaxScrollOffset', 'desc': 'Estimates total scroll extent from item count'},
    {'method': 'childCount', 'desc': 'Returns total number of children (if known)'},
    {'method': 'didAdoptChild', 'desc': 'Called when a child is adopted into the child list'},
    {'method': 'setDidUnderflow', 'desc': 'Notifies delegate that layout ran out of children'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('5 · Child Manager Delegate', Icons.manage_accounts),
      _baInfoCard(
        'RenderSliverBoxChildManager',
        'The adaptor delegates actual child creation and removal to a '
            'childManager (RenderSliverBoxChildManager). In practice, this '
            'is implemented by SliverMultiBoxAdaptorElement, which calls '
            'the SliverChildDelegate (e.g., SliverChildBuilderDelegate).',
        Icons.settings,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Child manager methods', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _baTextDark)),
            Divider(color: _baDivider, height: 12),
            ...methods.map((m) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: _baCode(m['method']!),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(m['desc']!, style: TextStyle(fontSize: 10, color: _baTextMedium))),
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
          color: _baSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Row(
          children: [
            _baBadge('Widget layer', _baBlue, _baOnPrimary),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 12, color: _baGrey),
            SizedBox(width: 6),
            _baBadge('Element layer', _baTeal, _baOnPrimary),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 12, color: _baGrey),
            SizedBox(width: 6),
            _baBadge('RenderObject', _baPrimary, _baOnPrimary),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: indexOf and Child Ordering
// ---------------------------------------------------------------------------
Widget _baSection6IndexOf() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('6 · indexOf & Child Ordering', Icons.format_list_numbered),
      _baInfoCard(
        'Linked list of children',
        'Children are stored in a doubly-linked list via ContainerParentDataMixin. '
            'indexOf(child) returns the index of a child in the logical list. '
            'Children are ordered by index — firstChild has the lowest visible '
            'index, lastChild the highest.',
        Icons.link,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Child linked list (visible range)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _baTextDark)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _baChildNode('idx 5', _baPrimary, true),
                _baArrow(),
                _baChildNode('idx 6', _baBlue, false),
                _baArrow(),
                _baChildNode('idx 7', _baTeal, false),
                _baArrow(),
                _baChildNode('idx 8', _baOrange, false),
                _baArrow(),
                _baChildNode('idx 9', _baIndigo, true),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.first_page, size: 14, color: _baPrimary),
                    Text(' firstChild', style: TextStyle(fontSize: 10, color: _baPrimary, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text('lastChild ', style: TextStyle(fontSize: 10, color: _baIndigo, fontWeight: FontWeight.w600)),
                    Icon(Icons.last_page, size: 14, color: _baIndigo),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _baInfoCard(
        'SliverMultiBoxAdaptorParentData',
        'Each child\'s parentData stores its index (an int) and '
            'layoutOffset (double). The index is used for ordering and '
            'for talking back to the child manager when removing children.',
        Icons.data_object,
        accent: _baBlue,
      ),
    ],
  );
}

Widget _baChildNode(String label, Color color, bool isEdge) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color, width: isEdge ? 2 : 1),
    ),
    child: Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w700)),
  );
}

Widget _baArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: Icon(Icons.arrow_forward, size: 10, color: _baGrey),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Paint and Hit Test
// ---------------------------------------------------------------------------
Widget _baSection7PaintHitTest() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('7 · Paint & Hit Test', Icons.brush),
      _baInfoCard(
        'Painting visible children',
        'Only children within the paintExtent are painted. The adaptor '
            'iterates the child linked list and paints each child at its '
            'layoutOffset. Children outside the visible bounds are skipped.',
        Icons.palette,
      ),
      _baInfoCard(
        'Hit testing children',
        'hitTestChildren iterates from lastChild to firstChild (reverse '
            'paint order). The first child whose area contains the hit '
            'position wins. KeepAlive children (off-screen) are not hit tested.',
        Icons.touch_app,
        accent: _baBlue,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paint vs hit test order', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _baTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _baPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _baPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.brush, size: 18, color: _baPrimary),
                        SizedBox(height: 4),
                        Text('Paint', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _baPrimary)),
                        SizedBox(height: 4),
                        Text('first → last\n(low index → high)', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: _baTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _baBlue.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _baBlue.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.touch_app, size: 18, color: _baBlue),
                        SizedBox(height: 4),
                        Text('Hit test', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _baBlue)),
                        SizedBox(height: 4),
                        Text('last → first\n(high index → low)', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: _baTextMedium)),
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
// Section 8: Visual Scroll Demo
// ---------------------------------------------------------------------------
Widget _baSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('8 · Visual Scroll Demonstration', Icons.preview),
      _baInfoCard(
        'SliverList backed by RenderSliverMultiBoxAdaptor',
        'Below is a SliverList with 50 items. Internally, Flutter creates '
            'a RenderSliverList (extends RenderSliverMultiBoxAdaptor) that '
            'lazily builds only the visible items plus cache. Scroll to '
            'see items being created and disposed.',
        Icons.format_list_bulleted,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _baSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SliverList — 50 items, lazily managed', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _baTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 240,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _baPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text('Header — above the lazy list', style: TextStyle(color: _baOnPrimary, fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 50,
                    itemBuilder: (ctx, i) {
                      final colors = [_baPrimary, _baBlue, _baTeal, _baOrange, _baIndigo, _baPurple, _baPink, _baAmber];
                      final c = colors[i % colors.length];
                      return Container(
                        height: 44,
                        margin: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          color: c.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: c.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36, height: 44,
                              decoration: BoxDecoration(
                                color: c.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text('${i}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: c)),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('List item ${i}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _baTextDark)),
                                  Text('Created lazily by RenderSliverMultiBoxAdaptor', style: TextStyle(fontSize: 9, color: _baGrey)),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, size: 16, color: _baGrey),
                          ],
                        ),
                      );
                    },
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
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _baSection9BestPractices() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Use builder constructors', 'desc': 'SliverList.builder / SliverGrid.builder for lazy creation', 'icon': Icons.build, 'color': _baPrimary},
    {'title': 'Avoid addAutomaticKeepAlives unless needed', 'desc': 'KeepAlive increases memory — only use for stateful items', 'icon': Icons.memory, 'color': _baRed},
    {'title': 'Set appropriate cacheExtent', 'desc': 'Balance between smooth scrolling and memory usage', 'icon': Icons.cached, 'color': _baBlue},
    {'title': 'Use itemExtent or prototypeItem', 'desc': 'Fixed-extent lists skip child intrinsic size calculation', 'icon': Icons.straighten, 'color': _baOrange},
    {'title': 'Profile long lists', 'desc': 'Use DevTools timeline to verify lazy creation is working', 'icon': Icons.analytics, 'color': _baTeal},
    {'title': 'Keys for stateful children', 'desc': 'Use ValueKey or ObjectKey when children are reordered', 'icon': Icons.vpn_key, 'color': _baIndigo},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _baSectionTitle('9 · Best Practices', Icons.star),
      _baInfoCard(
        'Getting the most from lazy slivers',
        'RenderSliverMultiBoxAdaptor powers the most common scrollable '
            'patterns in Flutter. Understanding its internals helps you '
            'build performant, memory-efficient scroll views.',
        Icons.tips_and_updates,
      ),
      ...practices.map((p) => Container(
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
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _baTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _baTextMedium)),
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
            colors: [_baPrimary.withValues(alpha: 0.08), _baPrimaryLight.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _baPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.view_list, size: 32, color: _baPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverMultiBoxAdaptor',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _baTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The foundation of Flutter\'s lazy scroll views — '
              'efficient child creation, garbage collection, and '
              'KeepAlive management for thousands of items.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _baTextMedium, height: 1.4),
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
              colors: [_baPrimary, _baPrimaryLight],
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
                  Icon(Icons.view_list, color: _baOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverMultiBoxAdaptor',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _baOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Lazy child management for slivers with multiple box children',
                style: TextStyle(fontSize: 12, color: _baOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _baSection1Overview(),
        _baSection2LazyManagement(),
        _baSection3KeepAlive(),
        _baSection4GarbageCollection(),
        _baSection5ChildManager(),
        _baSection6IndexOf(),
        _baSection7PaintHitTest(),
        _baSection8Demo(),
        _baSection9BestPractices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
