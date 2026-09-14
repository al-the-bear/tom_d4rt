// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: const in Flutter Rendering
//
// The `const` keyword is foundational to Flutter's rendering efficiency.
// Compile-time constants enable identity-based equality checks, allowing
// the framework to skip expensive rebuild, layout, and paint operations
// when a widget subtree is known to be identical.
//
// This demo visualises:
//   1. What const means in Dart and why it matters for rendering
//   2. Const constructors for key rendering/layout types
//   3. Const vs non-const widget identity
//   4. Const propagation through widget trees
//   5. Performance benefits: rebuild skipping
//   6. Common const values in the rendering library
//   7. Const in decoration and painting primitives
//   8. When const cannot be used
//   9. Best practices and patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Cyan / DarkCyan
// ---------------------------------------------------------------------------
const Color _ctPrimary = Color(0xFF006064);
const Color _ctPrimaryLight = Color(0xFF00838F);
const Color _ctAccent = Color(0xFF00BCD4);
const Color _ctAccentLight = Color(0xFF4DD0E1);
const Color _ctSurface = Color(0xFFE0F7FA);
const Color _ctSurfaceDark = Color(0xFFB2EBF2);
const Color _ctOnPrimary = Color(0xFFFFFFFF);
const Color _ctTextDark = Color(0xFF004D40);
const Color _ctTextMedium = Color(0xFF00695C);
const Color _ctDivider = Color(0xFF80DEEA);
const Color _ctGreen = Color(0xFF2E7D32);
const Color _ctRed = Color(0xFFC62828);
const Color _ctOrange = Color(0xFFE65100);
const Color _ctPurple = Color(0xFF6A1B9A);
const Color _ctBlue = Color(0xFF1565C0);
const Color _ctGrey = Color(0xFF757575);
const Color _ctAmber = Color(0xFFF57F17);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _ctSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _ctPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _ctTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _ctDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _ctBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _ctInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _ctPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _ctSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _ctTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _ctTextMedium, height: 1.4)),
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
Widget _ctCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _ctSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _ctPrimary, fontWeight: FontWeight.w600),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: comparison row
// ---------------------------------------------------------------------------
Widget _ctCompareRow(String constSide, String nonConstSide, {String? note}) {
  return Container(
    margin: EdgeInsets.only(bottom: 6),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _ctDivider),
    ),
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.check_circle, size: 14, color: _ctGreen),
              SizedBox(width: 4),
              Expanded(child: _ctCode(constSide, color: _ctGreen)),
            ],
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Icon(Icons.warning_amber, size: 14, color: _ctOrange),
              SizedBox(width: 4),
              Expanded(child: _ctCode(nonConstSide, color: _ctOrange)),
            ],
          ),
        ),
        if (note != null) ...[
          SizedBox(width: 8),
          Expanded(
            child: Text(note, style: TextStyle(fontSize: 10, color: _ctGrey, fontStyle: FontStyle.italic)),
          ),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: What const Means
// ---------------------------------------------------------------------------
Widget _ctSection1WhatConst() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ctSectionTitle('1 · What const Means in Flutter', Icons.star),
      _ctInfoCard(
        'Compile-time constants',
        'The const keyword marks a value as a compile-time constant. '
            'The Dart compiler evaluates it at build time and creates a single '
            'canonical instance. Any subsequent reference to the same const '
            'expression returns the identical object — not a copy.',
        Icons.memory,
      ),
      _ctInfoCard(
        'Why const matters for rendering',
        'Flutter rebuilds widget trees frequently. When a subtree is const, '
            'the framework can detect via identical() that nothing has changed, '
            'skipping Element.updateChild entirely. This avoids layout, paint, '
            'and compositing for unchanged portions of the tree.',
        Icons.speed,
        accent: _ctAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ctBadge('const Widget', _ctGreen, _ctOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _ctGrey),
                _ctBadge('identical()', _ctPrimary, _ctOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _ctGrey),
                _ctBadge('skip rebuild', _ctAccent, _ctOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Const widgets are canonicalised → identical check succeeds → no rebuild needed',
              style: TextStyle(fontSize: 11, color: _ctTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Const Constructors for Rendering Types
// ---------------------------------------------------------------------------
Widget _ctSection2Constructors() {
  final types = <Map<String, String>>[
    {'type': 'EdgeInsets', 'example': 'EdgeInsets.all(8.0)', 'desc': 'Padding/margin offsets'},
    {'type': 'Alignment', 'example': 'Alignment.center', 'desc': 'Fractional positioning'},
    {'type': 'BoxConstraints', 'example': 'BoxConstraints.tightFor(w: 100)', 'desc': 'Size constraints'},
    {'type': 'Offset', 'example': 'Offset(0.0, 0.0)', 'desc': '2D displacement vector'},
    {'type': 'Size', 'example': 'Size(200.0, 100.0)', 'desc': 'Width × height pair'},
    {'type': 'Rect', 'example': 'Rect.fromLTWH(0, 0, 100, 50)', 'desc': 'Axis-aligned rectangle'},
    {'type': 'Color', 'example': 'Color(0xFF00BCD4)', 'desc': 'ARGB colour value'},
    {'type': 'TextStyle', 'example': 'TextStyle(fontSize: 14)', 'desc': 'Text rendering parameters'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('2 · Const Constructors for Rendering Types', Icons.construction),
      _ctInfoCard(
        'Const-constructable types',
        'Many core rendering types have const constructors, meaning instances '
            'can be compile-time constants. This is by design — Flutter\'s layout '
            'and painting primitives are intentionally immutable and const-friendly.',
        Icons.architecture,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key const-constructable rendering types', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            Divider(color: _ctDivider, height: 12),
            ...types.map((t) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: _ctCode(t['type']!),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(t['desc']!, style: TextStyle(fontSize: 11, color: _ctTextMedium)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Visual: show actual const instances being created
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _ctSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Live const instances', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 8),
            // Demonstrate actual const EdgeInsets
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _ctAccentLight.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'This container uses const EdgeInsets.all(12)',
                style: TextStyle(fontSize: 11, color: _ctTextDark),
              ),
            ),
            SizedBox(height: 6),
            // Demonstrate const Alignment
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: _ctAccentLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _ctAccent.withValues(alpha: 0.3)),
              ),
              alignment: const Alignment(0.0, 0.0),
              child: Text(
                'Aligned with const Alignment(0.0, 0.0)',
                style: TextStyle(fontSize: 11, color: _ctTextDark),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Const vs Non-const Widget Identity
// ---------------------------------------------------------------------------
Widget _ctSection3Identity() {
  // Create two const widgets and two non-const widgets to demonstrate identity
  const Widget constWidgetA = SizedBox(width: 50, height: 50);
  const Widget constWidgetB = SizedBox(width: 50, height: 50);
  final Widget nonConstWidgetA = SizedBox(width: 50, height: 50);
  final Widget nonConstWidgetB = SizedBox(width: 50, height: 50);

  final bool constIdentical = identical(constWidgetA, constWidgetB);
  final bool nonConstIdentical = identical(nonConstWidgetA, nonConstWidgetB);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('3 · Const vs Non-const Identity', Icons.compare_arrows),
      _ctInfoCard(
        'The identical() test',
        'Two const expressions with the same arguments resolve to the exact '
            'same object in memory. The identical() function returns true. '
            'For non-const, even with the same arguments, two separate objects '
            'are created — identical() returns false.',
        Icons.fingerprint,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _ctGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _ctGreen.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _ctCode('const SizedBox(50×50)'),
                        SizedBox(height: 4),
                        _ctCode('const SizedBox(50×50)'),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, size: 16, color: _ctGreen),
                            SizedBox(width: 4),
                            Text(
                              'identical: $constIdentical',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _ctGreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _ctRed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _ctRed.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _ctCode('new SizedBox(50×50)'),
                        SizedBox(height: 4),
                        _ctCode('new SizedBox(50×50)'),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel, size: 16, color: _ctRed),
                            SizedBox(width: 4),
                            Text(
                              'identical: $nonConstIdentical',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _ctRed),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Same arguments, same type — but only const produces identical objects',
              style: TextStyle(fontSize: 11, color: _ctTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Visual side-by-side of the actual widgets
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _ctGreen.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _ctGreen.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text('const', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ctGreen)),
                  SizedBox(height: 4),
                  constWidgetA,
                  SizedBox(height: 2),
                  Text('One canonical instance', style: TextStyle(fontSize: 9, color: _ctGrey)),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _ctOrange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _ctOrange.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text('non-const', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ctOrange)),
                  SizedBox(height: 4),
                  nonConstWidgetA,
                  SizedBox(height: 2),
                  Text('Separate heap objects', style: TextStyle(fontSize: 9, color: _ctGrey)),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Const Propagation in Widget Trees
// ---------------------------------------------------------------------------
Widget _ctSection4Propagation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('4 · Const Propagation in Widget Trees', Icons.account_tree),
      _ctInfoCard(
        'Subtree is frozen',
        'When a widget is marked const, its entire constructor argument tree '
            'must also be const. This means children, padding, decoration — '
            'everything is compile-time constant. The entire subtree becomes '
            'a single immutable object graph.',
        Icons.lock,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Const subtree visualisation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 10),
            // Level 0: outer container
            _ctTreeLevel(0, 'const Padding', _ctGreen, true),
            _ctTreeLevel(1, 'const EdgeInsets.all(8)', _ctGreen, true),
            _ctTreeLevel(1, 'const Center', _ctGreen, true),
            _ctTreeLevel(2, 'const Text("Hello")', _ctGreen, true),
            SizedBox(height: 12),
            // Non-const tree for comparison
            Text('Non-const subtree (breaks propagation)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: _ctOrange)),
            SizedBox(height: 6),
            _ctTreeLevel(0, 'Padding', _ctOrange, false),
            _ctTreeLevel(1, 'EdgeInsets.all(value)', _ctRed, false),
            _ctTreeLevel(1, 'Center', _ctOrange, false),
            _ctTreeLevel(2, 'Text(dynamicString)', _ctRed, false),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Actual const subtree as a live widget
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _ctGreen.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctGreen.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _ctGreen),
                SizedBox(width: 4),
                Text('Live const subtree', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _ctGreen)),
              ],
            ),
            SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'This entire subtree is a single const object',
                  style: TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _ctTreeLevel(int depth, String label, Color color, bool isConst) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 2, bottom: 2),
    child: Row(
      children: [
        Container(width: 2, height: 18, color: color.withValues(alpha: 0.4)),
        SizedBox(width: 6),
        Icon(
          isConst ? Icons.lock_outline : Icons.lock_open,
          size: 12,
          color: color,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label, style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: color, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Performance Benefits
// ---------------------------------------------------------------------------
Widget _ctSection5Performance() {
  final benefits = <Map<String, dynamic>>[
    {'label': 'Rebuild skip', 'desc': 'identical() on widget → skip updateChild()', 'saving': 'High', 'icon': Icons.replay, 'color': _ctGreen},
    {'label': 'No GC pressure', 'desc': 'Single canonical instance, no allocation on rebuild', 'saving': 'Medium', 'icon': Icons.delete_sweep, 'color': _ctBlue},
    {'label': 'Faster comparison', 'desc': 'identical() is O(1) pointer comparison', 'saving': 'High', 'icon': Icons.bolt, 'color': _ctAmber},
    {'label': 'Tree pruning', 'desc': 'Entire const subtrees are pruned from rebuild', 'saving': 'High', 'icon': Icons.content_cut, 'color': _ctPurple},
    {'label': 'Compile-time eval', 'desc': 'No runtime constructor call needed', 'saving': 'Low', 'icon': Icons.build, 'color': _ctOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('5 · Performance Benefits', Icons.speed),
      _ctInfoCard(
        'Why const matters for 60fps',
        'Flutter targets 60fps (16ms per frame). Every widget rebuild, layout '
            'pass, and paint call takes time. Const widgets eliminate unnecessary '
            'work by letting the framework detect unchanged subtrees via pointer '
            'equality — no deep comparison needed.',
        Icons.timer,
      ),
      ...benefits.map((b) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: b['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(b['icon'] as IconData, size: 18, color: b['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(b['label'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
                      SizedBox(width: 8),
                      _ctBadge('Saving: ${b['saving']}', (b['color'] as Color).withValues(alpha: 0.15), b['color'] as Color),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(b['desc'] as String, style: TextStyle(fontSize: 11, color: _ctTextMedium)),
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
// Section 6: Common Const Values
// ---------------------------------------------------------------------------
Widget _ctSection6CommonValues() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('6 · Common Const Values in Rendering', Icons.inventory_2),
      _ctInfoCard(
        'Pre-defined constants',
        'Flutter defines many frequently-used values as static const fields. '
            'Using these avoids creating duplicate instances and communicates '
            'intent clearly. Examples: EdgeInsets.zero, Alignment.center, '
            'BoxConstraints(), Offset.zero, Size.zero.',
        Icons.bookmark,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('EdgeInsets constants', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 6),
            _ctConstValueRow('EdgeInsets.zero', 'All sides 0.0', _ctPrimary),
            _ctConstValueRow('EdgeInsets.all(8.0)', 'Uniform 8px padding', _ctAccent),
            _ctConstValueRow('EdgeInsets.symmetric(h: 16)', 'Horizontal only', _ctBlue),
            SizedBox(height: 12),
            Text('Alignment constants', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 6),
            _ctConstValueRow('Alignment.topLeft', '(-1.0, -1.0)', _ctPrimary),
            _ctConstValueRow('Alignment.center', '(0.0, 0.0)', _ctAccent),
            _ctConstValueRow('Alignment.bottomRight', '(1.0, 1.0)', _ctBlue),
            SizedBox(height: 12),
            Text('Geometry constants', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 6),
            _ctConstValueRow('Offset.zero', '(0.0, 0.0)', _ctPrimary),
            _ctConstValueRow('Size.zero', '(0.0, 0.0)', _ctAccent),
            _ctConstValueRow('Rect.zero', '(0, 0, 0, 0)', _ctBlue),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Visual demonstrations of const alignment
      Container(
        height: 100,
        decoration: BoxDecoration(
          color: _ctSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: _ctBadge('topLeft', _ctPrimary, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _ctBadge('topCenter', _ctAccent, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.topRight,
              child: _ctBadge('topRight', _ctBlue, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: _ctBadge('centerLeft', _ctPurple, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.center,
              child: _ctBadge('center', _ctPrimaryLight, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _ctBadge('centerRight', _ctOrange, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: _ctBadge('bottomLeft', _ctAmber, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _ctBadge('bottomCenter', _ctGrey, _ctOnPrimary),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _ctBadge('bottomRight', _ctRed, _ctOnPrimary),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _ctConstValueRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(width: 4, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 8),
        SizedBox(width: 180, child: _ctCode(name, color: color)),
        SizedBox(width: 8),
        Expanded(child: Text(desc, style: TextStyle(fontSize: 10, color: _ctTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Const in Decoration & Painting
// ---------------------------------------------------------------------------
Widget _ctSection7Decoration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('7 · Const in Decoration & Painting', Icons.palette),
      _ctInfoCard(
        'BoxDecoration and const',
        'BoxDecoration has a const constructor, so borders, colours, and '
            'border radii can all be compile-time constants. When decorations '
            'are const, the rendering layer can skip repaint comparison entirely.',
        Icons.brush,
      ),
      // Visual gallery of const decorations
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Const decoration gallery', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF006064),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    child: Text('const color + radius', style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Color(0xFF00BCD4), width: 2)),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    alignment: Alignment.center,
                    child: Text('const border', style: TextStyle(fontSize: 10, color: _ctPrimary)),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0F7FA),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('circle', style: TextStyle(fontSize: 10, color: _ctPrimary)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_ctPrimary, _ctAccent],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text('gradient (non-const)', style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: _ctSurfaceDark,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: _ctPrimary.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text('shadow', style: TextStyle(fontSize: 10, color: _ctPrimary)),
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
// Section 8: When Const Cannot Be Used
// ---------------------------------------------------------------------------
Widget _ctSection8Limitations() {
  final limitations = <Map<String, dynamic>>[
    {'title': 'Runtime values', 'desc': 'Variables, function results, or state that changes at runtime', 'icon': Icons.play_arrow, 'color': _ctRed},
    {'title': 'Theme references', 'desc': 'Theme.of(context) returns runtime data, cannot be const', 'icon': Icons.color_lens, 'color': _ctOrange},
    {'title': 'MediaQuery', 'desc': 'Screen dimensions and orientation are runtime-only', 'icon': Icons.phone_android, 'color': _ctAmber},
    {'title': 'Callbacks', 'desc': 'Functions/closures are not compile-time constants', 'icon': Icons.touch_app, 'color': _ctPurple},
    {'title': 'DateTime.now()', 'desc': 'Time-dependent values cannot be determined at compile time', 'icon': Icons.access_time, 'color': _ctBlue},
    {'title': 'Collections with spreads', 'desc': 'Spread operators (...) break const in collections', 'icon': Icons.list, 'color': _ctGrey},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('8 · When const Cannot Be Used', Icons.block),
      _ctInfoCard(
        'Runtime data breaks const',
        'Any value that depends on runtime state — user input, screen size, '
            'theme, locale, or time — cannot be const. The compiler must be '
            'able to fully evaluate the expression at build time.',
        Icons.warning_amber,
        accent: _ctOrange,
      ),
      ...limitations.map((l) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: l['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(l['icon'] as IconData, size: 18, color: l['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
                  SizedBox(height: 2),
                  Text(l['desc'] as String, style: TextStyle(fontSize: 11, color: _ctTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
      SizedBox(height: 8),
      // Visual: const vs non-const comparison
      _ctCompareRow('const Text("Hello")', 'Text(variable)', note: 'String literal vs variable'),
      _ctCompareRow('const EdgeInsets.all(8)', 'EdgeInsets.all(val)', note: 'Literal vs param'),
      _ctCompareRow('const Color(0xFF006064)', 'Theme.of(ctx).primary', note: 'Literal vs theme'),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _ctSection9BestPractices() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Mark static subtrees const', 'desc': 'Any widget subtree that doesn\'t depend on state should be const', 'icon': Icons.check_circle, 'color': _ctGreen},
    {'title': 'Use const constructors', 'desc': 'Add const constructors to your custom widget classes when possible', 'icon': Icons.construction, 'color': _ctPrimary},
    {'title': 'Pre-defined constants', 'desc': 'Prefer EdgeInsets.zero over EdgeInsets.all(0.0)', 'icon': Icons.bookmark, 'color': _ctBlue},
    {'title': 'Extract const widgets', 'desc': 'Move const subtrees into named const variables for reuse', 'icon': Icons.move_up, 'color': _ctPurple},
    {'title': 'Lint rules', 'desc': 'Enable prefer_const_constructors and prefer_const_literals_to_create_immutables', 'icon': Icons.rule, 'color': _ctOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ctSectionTitle('9 · Best Practices', Icons.star_outline),
      _ctInfoCard(
        'Maximise const usage',
        'The more of your widget tree that is const, the less work Flutter '
            'does on each frame. This is especially important for leaf widgets '
            'like Text, Icon, and SizedBox which appear many times.',
        Icons.lightbulb,
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
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ctTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _ctTextMedium)),
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
            colors: [_ctPrimary.withValues(alpha: 0.08), _ctAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ctPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.star, size: 32, color: _ctPrimary),
            SizedBox(height: 8),
            Text(
              'const in Flutter Rendering',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _ctTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Compile-time constants are the foundation of Flutter\'s rendering '
              'efficiency — enabling identity-based rebuild skipping, reducing GC '
              'pressure, and making 60fps achievable for complex widget trees.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _ctTextMedium, height: 1.4),
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
              colors: [_ctPrimary, _ctPrimaryLight],
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
                  Icon(Icons.lock_outline, color: _ctOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'const in Flutter Rendering',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _ctOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Compile-time constants — the key to efficient widget rebuilds',
                style: TextStyle(fontSize: 12, color: _ctOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _ctSection1WhatConst(),
        _ctSection2Constructors(),
        _ctSection3Identity(),
        _ctSection4Propagation(),
        _ctSection5Performance(),
        _ctSection6CommonValues(),
        _ctSection7Decoration(),
        _ctSection8Limitations(),
        _ctSection9BestPractices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
