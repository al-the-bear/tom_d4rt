// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverSemanticsAnnotations
//
// RenderSliverSemanticsAnnotations is a sliver render object proxy that adds
// semantic annotations to its sliver child. It doesn't change layout or
// painting — it purely annotates the semantics tree for accessibility tools,
// screen readers, and testing frameworks.
//
// This is the sliver equivalent of the Semantics widget for box layout.
// It enables slivers to provide labels, hints, values, and actions to the
// accessibility system, which is essential for inclusive app development.
//
// This demo visualises:
//   1. Overview — what semantics annotations do
//   2. Accessibility tree — how annotations appear
//   3. Common semantic properties
//   4. Sliver vs box semantics
//   5. SemanticsProperties mapping
//   6. Screen reader interaction
//   7. Testing with semantics
//   8. Visual demo — annotated slivers
//   9. Best practices for sliver accessibility
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Violet / Orchid
// ---------------------------------------------------------------------------
const Color _saPrimary = Color(0xFF4A148C);
const Color _saPrimaryLight = Color(0xFF6A1B9A);
const Color _saAccent = Color(0xFF9C27B0);
const Color _saAccentLight = Color(0xFFCE93D8);
const Color _saSurface = Color(0xFFF3E5F5);
const Color _saSurfaceDark = Color(0xFFE1BEE7);
const Color _saOnPrimary = Color(0xFFFFFFFF);
const Color _saTextDark = Color(0xFF311B92);
const Color _saTextMedium = Color(0xFF6A4C93);
const Color _saDivider = Color(0xFFCE93D8);
const Color _saGreen = Color(0xFF2E7D32);
const Color _saBlue = Color(0xFF1565C0);
const Color _saOrange = Color(0xFFE65100);
const Color _saTeal = Color(0xFF00695C);
const Color _saGrey = Color(0xFF757575);
const Color _saAmber = Color(0xFFF57F17);
const Color _saRed = Color(0xFFC62828);
const Color _saIndigo = Color(0xFF283593);
const Color _saCyan = Color(0xFF00838F);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _saSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _saPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _saTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _saDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _saBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _saInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _saPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _saSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _saTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _saTextMedium, height: 1.4)),
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
Widget _saCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _saSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _saPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _saSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionTitle('1 · Semantics Annotations Overview', Icons.accessibility),
      _saInfoCard(
        'What is RenderSliverSemanticsAnnotations?',
        'A sliver render object proxy that adds semantic annotations without '
            'affecting layout or painting. It tells accessibility services (like '
            'screen readers) what a sliver represents, its label, its role, '
            'and what actions it supports.',
        Icons.description,
      ),
      _saInfoCard(
        'Why sliver semantics matter',
        'Without semantics annotations, slivers are invisible to accessibility '
            'tools. Screen readers would skip the content entirely. Providing '
            'proper annotations ensures all users can interact with scroll views.',
        Icons.accessibility_new,
        accent: _saAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          children: [
            Text('Transparency principle', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _saTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.grid_on, size: 24, color: _saGrey),
                      SizedBox(height: 4),
                      Text('Layout', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saGrey)),
                      Text('Unchanged', style: TextStyle(fontSize: 9, color: _saTextMedium)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.brush, size: 24, color: _saGrey),
                      SizedBox(height: 4),
                      Text('Painting', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saGrey)),
                      Text('Unchanged', style: TextStyle(fontSize: 9, color: _saTextMedium)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.accessibility, size: 24, color: _saPrimary),
                      SizedBox(height: 4),
                      Text('Semantics', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saPrimary)),
                      Text('Modified ✓', style: TextStyle(fontSize: 9, color: _saPrimary)),
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
// Section 2: Accessibility Tree
// ---------------------------------------------------------------------------
Widget _saSection2AccessTree() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('2 · The Accessibility Tree', Icons.account_tree),
      _saInfoCard(
        'Semantics tree structure',
        'Flutter builds a parallel tree of SemanticsNode objects alongside '
            'the render tree. Each SemanticsNode carries labels, hints, flags, '
            'and actions. Screen readers traverse this tree to describe the UI.',
        Icons.nature,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tree layers', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _saTextDark)),
            SizedBox(height: 8),
            ...[
              {'layer': 'Widget Tree', 'detail': 'Declarative UI configuration', 'color': _saBlue},
              {'layer': 'Element Tree', 'detail': 'Lifecycle and state management', 'color': _saTeal},
              {'layer': 'Render Tree', 'detail': 'Layout, painting, hit testing', 'color': _saOrange},
              {'layer': 'Semantics Tree', 'detail': 'Accessibility annotations ← Here', 'color': _saPrimary},
            ].map((l) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (l['color'] as Color).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: l['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  _saBadge(l['layer'] as String, l['color'] as Color, _saOnPrimary),
                  SizedBox(width: 8),
                  Expanded(child: Text(l['detail'] as String, style: TextStyle(fontSize: 10, color: _saTextMedium))),
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
// Section 3: Common Semantic Properties
// ---------------------------------------------------------------------------
Widget _saSection3Properties() {
  final props = <Map<String, dynamic>>[
    {'prop': 'label', 'desc': 'Human-readable description of the sliver content', 'example': '"Product list section"', 'color': _saPrimary},
    {'prop': 'value', 'desc': 'Current value for adjustable content', 'example': '"Page 3 of 10"', 'color': _saBlue},
    {'prop': 'hint', 'desc': 'Action hint for screen readers', 'example': '"Double tap to expand"', 'color': _saTeal},
    {'prop': 'isHeader', 'desc': 'Marks the sliver as a heading element', 'example': 'true for section headers', 'color': _saOrange},
    {'prop': 'isHidden', 'desc': 'Hides the node from accessibility tools', 'example': 'true for decorative slivers', 'color': _saGrey},
    {'prop': 'liveRegion', 'desc': 'Announces changes automatically', 'example': 'true for dynamic content areas', 'color': _saAmber},
    {'prop': 'sortKey', 'desc': 'Controls traversal order for screen readers', 'example': 'OrdinalSortKey(1.0)', 'color': _saIndigo},
    {'prop': 'container', 'desc': 'Groups child semantics into one node', 'example': 'true for logical sections', 'color': _saCyan},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('3 · Common Semantic Properties', Icons.list_alt),
      _saInfoCard(
        'What can be annotated?',
        'SemanticsProperties offers dozens of fields. The most common for '
            'slivers are label, hint, value, isHeader, and container. These '
            'tell accessibility tools what the content is and how to interact.',
        Icons.tune,
      ),
      ...props.map((p) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: p['color'] as Color, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _saCode(p['prop'] as String, color: p['color'] as Color),
                SizedBox(width: 8),
                Expanded(child: Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _saTextMedium))),
              ],
            ),
            SizedBox(height: 4),
            Text('Example: ${p['example']}', style: TextStyle(fontSize: 10, color: _saGrey, fontStyle: FontStyle.italic)),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Sliver vs Box Semantics
// ---------------------------------------------------------------------------
Widget _saSection4SliverVsBox() {
  final diffs = <Map<String, String>>[
    {'aspect': 'Widget', 'box': 'Semantics', 'sliver': 'SliverSemanticsAnnotations (or via render object)'},
    {'aspect': 'Render', 'box': 'RenderSemanticsAnnotations', 'sliver': 'RenderSliverSemanticsAnnotations'},
    {'aspect': 'Protocol', 'box': 'Box protocol (BoxConstraints)', 'sliver': 'Sliver protocol (SliverConstraints)'},
    {'aspect': 'Parent', 'box': 'Any RenderBox parent', 'sliver': 'Viewport or sliver parent'},
    {'aspect': 'Effect', 'box': 'Same — adds semantics only', 'sliver': 'Same — adds semantics only'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('4 · Sliver vs Box Semantics', Icons.compare),
      _saInfoCard(
        'Same concept, different protocol',
        'RenderSliverSemanticsAnnotations is the sliver equivalent of '
            'RenderSemanticsAnnotations. Both add semantics without affecting '
            'layout. The only difference is they participate in the sliver vs '
            'box layout protocol respectively.',
        Icons.swap_horiz,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(color: _saSurface, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  SizedBox(width: 60, child: Text('Aspect', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saTextDark))),
                  Expanded(child: Text('Box', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saBlue))),
                  Expanded(child: Text('Sliver', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _saPrimary))),
                ],
              ),
            ),
            ...diffs.map((d) => Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _saDivider.withValues(alpha: 0.3)))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 60, child: Text(d['aspect']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _saTextDark))),
                  Expanded(child: Text(d['box']!, style: TextStyle(fontSize: 10, color: _saBlue))),
                  Expanded(child: Text(d['sliver']!, style: TextStyle(fontSize: 10, color: _saPrimary))),
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
// Section 5: SemanticsProperties Mapping
// ---------------------------------------------------------------------------
Widget _saSection5PropertiesMapping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('5 · SemanticsProperties Mapping', Icons.map),
      _saInfoCard(
        'How properties flow',
        'The render object receives SemanticsProperties and applies them '
            'to the SemanticsNode during describeSemanticsConfiguration(). '
            'The node then becomes part of the semantics tree that the '
            'platform accessibility framework reads.',
        Icons.schema,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data flow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _saTextDark)),
            SizedBox(height: 8),
            ...[
              {'step': '1', 'desc': 'Widget provides SemanticsProperties', 'color': _saPrimary},
              {'step': '2', 'desc': 'RenderSliverSemanticsAnnotations stores them', 'color': _saAccent},
              {'step': '3', 'desc': 'describeSemanticsConfiguration() applies to SemanticsConfiguration', 'color': _saTeal},
              {'step': '4', 'desc': 'SemanticsNode is updated in the semantics tree', 'color': _saBlue},
              {'step': '5', 'desc': 'Platform bridge sends to OS accessibility framework', 'color': _saOrange},
              {'step': '6', 'desc': 'Screen reader announces content to user', 'color': _saGreen},
            ].map((s) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(color: s['color'] as Color, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text(s['step'] as String, style: TextStyle(fontSize: 10, color: _saOnPrimary, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(s['desc'] as String, style: TextStyle(fontSize: 11, color: _saTextMedium))),
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
// Section 6: Screen Reader Interaction
// ---------------------------------------------------------------------------
Widget _saSection6ScreenReader() {
  final platforms = <Map<String, dynamic>>[
    {'platform': 'iOS', 'reader': 'VoiceOver', 'icon': Icons.phone_iphone, 'color': _saGrey},
    {'platform': 'Android', 'reader': 'TalkBack', 'icon': Icons.phone_android, 'color': _saGreen},
    {'platform': 'macOS', 'reader': 'VoiceOver', 'icon': Icons.desktop_mac, 'color': _saBlue},
    {'platform': 'Windows', 'reader': 'Narrator', 'icon': Icons.desktop_windows, 'color': _saIndigo},
    {'platform': 'Web', 'reader': 'ARIA / NVDA / JAWS', 'icon': Icons.web, 'color': _saOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('6 · Screen Reader Interaction', Icons.hearing),
      _saInfoCard(
        'Cross-platform accessibility',
        'Semantics annotations are platform-independent. Flutter translates '
            'them into platform-native accessibility primitives. VoiceOver on '
            'iOS, TalkBack on Android, and ARIA on web all receive the same '
            'semantic information from the same annotation.',
        Icons.language,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Platform screen readers', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _saTextDark)),
            SizedBox(height: 6),
            ...platforms.map((p) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: (p['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(p['icon'] as IconData, size: 16, color: p['color'] as Color),
                  SizedBox(width: 8),
                  SizedBox(width: 60, child: Text(p['platform'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _saTextDark))),
                  Expanded(child: Text(p['reader'] as String, style: TextStyle(fontSize: 11, color: _saTextMedium))),
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
// Section 7: Testing with Semantics
// ---------------------------------------------------------------------------
Widget _saSection7Testing() {
  final methods = <Map<String, dynamic>>[
    {'method': 'find.bySemanticsLabel()', 'desc': 'Find widgets by their semantic label in tests', 'color': _saPrimary},
    {'method': 'SemanticsHandle', 'desc': 'Enable semantics tree in widget tests', 'color': _saAccent},
    {'method': 'tester.getSemantics()', 'desc': 'Get the SemanticsNode for a specific finder', 'color': _saTeal},
    {'method': 'SemanticsFlag checks', 'desc': 'Assert that specific flags are set on nodes', 'color': _saBlue},
    {'method': 'Accessibility audit', 'desc': 'Run full accessibility audits in integration tests', 'color': _saOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('7 · Testing with Semantics', Icons.science),
      _saInfoCard(
        'Verifying accessibility in tests',
        'Flutter\'s test framework provides tools to inspect the semantics '
            'tree. You can find widgets by label, check flags, and verify '
            'that annotations are correctly applied. This is crucial for '
            'regression testing accessibility.',
        Icons.verified,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Test utilities', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _saTextDark)),
            Divider(color: _saDivider, height: 12),
            ...methods.map((m) => Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _saSurface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _saCode(m['method'] as String, color: m['color'] as Color),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(m['desc'] as String, style: TextStyle(fontSize: 10, color: _saTextMedium)),
                  ),
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
// Section 8: Visual Demo
// ---------------------------------------------------------------------------
Widget _saSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('8 · Visual Demo', Icons.preview),
      _saInfoCard(
        'Annotated slivers in a scroll view',
        'Below is a CustomScrollView where each section has Semantics '
            'annotations. While the visual appearance is the same as without '
            'annotations, screen readers can now identify and describe each '
            'section.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _saSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('Semantics-annotated CustomScrollView', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _saTextDark)),
            ),
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    // Header section with semantics
                    SliverToBoxAdapter(
                      child: Semantics(
                        label: 'Accessibility demo header',
                        header: true,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: _saPrimary,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.accessibility, color: _saOnPrimary, size: 28),
                              SizedBox(height: 4),
                              Text('Accessible Scroll View', style: TextStyle(color: _saOnPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                              _saBadge('Semantics: label, header', _saAccent, _saOnPrimary),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Category section with semantics
                    SliverToBoxAdapter(
                      child: Semantics(
                        label: 'Product categories',
                        container: true,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Categories', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _saTextDark)),
                                  Spacer(),
                                  _saBadge('container: true', _saTeal, _saOnPrimary),
                                ],
                              ),
                              SizedBox(height: 4),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: ['Electronics', 'Books', 'Clothing', 'Home'].map((cat) => Semantics(
                                  label: '$cat category',
                                  button: true,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _saAccentLight.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: _saAccent.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(cat, style: TextStyle(fontSize: 11, color: _saPrimary)),
                                  ),
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // List items with semantics
                    SliverList.builder(
                      itemCount: 15,
                      itemBuilder: (ctx, i) => Semantics(
                        label: 'Product item ${i + 1}',
                        hint: 'Double tap to view details',
                        child: Container(
                          height: 48,
                          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: i.isEven
                                ? _saPrimary.withValues(alpha: 0.03)
                                : _saAccent.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: _saDivider.withValues(alpha: 0.2)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.label, size: 14, color: _saAccent),
                              SizedBox(width: 8),
                              Text('Product ${i + 1}', style: TextStyle(fontSize: 12, color: _saTextDark)),
                              Spacer(),
                              if (i < 3) _saBadge('label + hint', _saPrimary.withValues(alpha: 0.15), _saPrimary),
                            ],
                          ),
                        ),
                      ),
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
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _saSection9BestPractices() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Label everything interactive', 'desc': 'Every tappable sliver must have a semantic label for screen readers', 'icon': Icons.touch_app, 'color': _saPrimary},
    {'title': 'Use container for groups', 'desc': 'Set container: true on logical sections so screen readers group child nodes', 'icon': Icons.folder, 'color': _saTeal},
    {'title': 'Mark headers as headers', 'desc': 'Set header: true on section headers for proper document structure', 'icon': Icons.title, 'color': _saBlue},
    {'title': 'Avoid redundant labels', 'desc': 'Don\'t duplicate text already visible — add context instead', 'icon': Icons.content_copy, 'color': _saAmber},
    {'title': 'Test with a screen reader', 'desc': 'Run TalkBack/VoiceOver to verify the experience, not just the tree', 'icon': Icons.hearing, 'color': _saOrange},
    {'title': 'Use excludeSemantics sparingly', 'desc': 'Only exclude decorative elements that add no information', 'icon': Icons.remove_circle, 'color': _saRed},
    {'title': 'Order matters', 'desc': 'Use sortKey when visual order differs from reading order', 'icon': Icons.sort, 'color': _saIndigo},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _saSectionTitle('9 · Best Practices', Icons.star),
      _saInfoCard(
        'Building accessible slivers',
        'Accessibility is not optional — it is a core quality attribute. '
            'RenderSliverSemanticsAnnotations makes it possible to provide '
            'rich accessibility information even in complex sliver layouts.',
        Icons.verified_user,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, size: 18, color: p['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _saTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _saTextMedium)),
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
            colors: [_saPrimary.withValues(alpha: 0.08), _saAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _saPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.accessibility, size: 32, color: _saPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverSemanticsAnnotations',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _saTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The invisible layer that makes slivers accessible — '
              'adding labels, hints, and structure to the semantics tree '
              'without affecting layout or painting.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _saTextMedium, height: 1.4),
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
              colors: [_saPrimary, _saPrimaryLight],
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
                  Icon(Icons.accessibility, color: _saOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverSemanticsAnnotations',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _saOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Adding accessibility annotations to sliver content',
                style: TextStyle(fontSize: 12, color: _saOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _saSection1Overview(),
        _saSection2AccessTree(),
        _saSection3Properties(),
        _saSection4SliverVsBox(),
        _saSection5PropertiesMapping(),
        _saSection6ScreenReader(),
        _saSection7Testing(),
        _saSection8Demo(),
        _saSection9BestPractices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
