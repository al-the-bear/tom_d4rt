// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of AccessibilityFocusBlockType
// from `package:flutter/semantics.dart`.
//
// AccessibilityFocusBlockType is a three-valued enum that controls how a
// SemanticsConfiguration suppresses accessibility focus on a node and/or its
// descendants. The enum values are:
//   - none          : a11y focus is not blocked
//   - blockSubtree  : blocks a11y focus on this node and the entire subtree
//   - blockNode     : blocks a11y focus on the current node only; descendants
//                     remain focusable
//
// This script exercises the enum surface (values, names, indices, iteration)
// and pairs it with a hand-authored visual catalogue that makes the behavior
// concrete: anatomy diagrams, per-value cards, accessibility recipes, common
// pitfalls, a comparison table against related public APIs (ExcludeSemantics,
// BlockSemantics, MergeSemantics, IgnorePointer), a quick-reference cheatsheet
// and an ASCII footer. The script is fully static — there is no main(), no
// test()/expect()/group(), no live animation: motion is conveyed through
// AlwaysStoppedAnimation<double>(value) and Duration.zero.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Shared static "animations" — frozen at fixed values to avoid
  // any actual ticking. These are used to seed progress bars,
  // intensity meters and other quantitative visuals.
  // ============================================================
  final AlwaysStoppedAnimation<double> intensityNone =
      AlwaysStoppedAnimation<double>(0.0);
  final AlwaysStoppedAnimation<double> intensityNode =
      AlwaysStoppedAnimation<double>(0.55);
  final AlwaysStoppedAnimation<double> intensitySubtree =
      AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> midIntensity =
      AlwaysStoppedAnimation<double>(0.5);
  final Duration frozen = Duration.zero;

  // ============================================================
  // SECTION 0: Hero header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.deepPurple.shade500,
          Colors.purple.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 28.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.30),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.accessibility_new,
                size: 48.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AccessibilityFocusBlockType',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/semantics.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Three discrete blocking modes that govern how accessibility '
          'focus traverses a SemanticsNode and its descendants.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroBadge('enum', Icons.code, Colors.amber),
            _heroBadge('a11y', Icons.hearing, Colors.tealAccent),
            _heroBadge('semantics', Icons.layers, Colors.pinkAccent),
            _heroBadge(
              '${AccessibilityFocusBlockType.values.length} values',
              Icons.format_list_numbered,
              Colors.lightGreenAccent,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 1: Anatomy of accessibility-focus blocking
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade50,
          Colors.blueGrey.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.blueGrey.shade800),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of Accessibility Focus Blocking',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A SemanticsConfiguration carries one AccessibilityFocusBlockType '
          'value. When the framework rasterizes the semantics tree, this '
          'enum decides whether the owner node, its descendants, both, or '
          'neither are reachable through assistive technology focus '
          'traversal.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.blueGrey.shade900,
            height: 1.45,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _anatomyTree('none', Colors.green)),
            SizedBox(width: 12.0),
            Expanded(child: _anatomyTree('blockNode', Colors.orange)),
            SizedBox(width: 12.0),
            Expanded(child: _anatomyTree('blockSubtree', Colors.red)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Per-value cards (one per enum value)
  // ============================================================
  final List<Map<String, Object>> valueData = [
    {
      'value': AccessibilityFocusBlockType.none,
      'icon': Icons.visibility,
      'color': Colors.green,
      'tagline': 'Default — focus passes freely',
      'description':
          'Accessibility focus traversal is not blocked. The node and all '
          'descendants are reachable by screen readers and switch control.',
      'whenToUse':
          'Use for ordinary content nodes that should participate normally '
          'in the a11y traversal order. This is the implicit default.',
      'intensity': intensityNone,
      'asciiTree': 'A\n |- B\n |- C\n     |- D',
    },
    {
      'value': AccessibilityFocusBlockType.blockNode,
      'icon': Icons.block,
      'color': Colors.orange,
      'tagline': 'Hide this node — keep children reachable',
      'description':
          'Blocks a11y focus on the owning node only. Descendants remain '
          'focusable. The node itself is removed from the a11y traversal '
          'order, but the subtree below continues to participate.',
      'whenToUse':
          'Use for purely structural containers that wrap meaningful '
          'children — you want the children read out, but not the wrapper '
          'as a separate stop.',
      'intensity': intensityNode,
      'asciiTree': '[A]   <-- skipped\n |- B\n |- C\n     |- D',
    },
    {
      'value': AccessibilityFocusBlockType.blockSubtree,
      'icon': Icons.layers_clear,
      'color': Colors.red,
      'tagline': 'Hide this node and everything below',
      'description':
          'Blocks accessibility focus for the entire subtree rooted at the '
          'owning node. Neither the node nor any descendant is reachable '
          'via a11y focus traversal.',
      'whenToUse':
          'Use for offscreen content, decorative regions, or modal scrims '
          'that should be entirely ignored by assistive tech while present.',
      'intensity': intensitySubtree,
      'asciiTree': '[A]   <-- skipped\n [B]  <-- skipped\n [C]  <-- skipped\n     [D]  <-- skipped',
    },
  ];

  final List<Widget> valueCards = <Widget>[];
  for (final Map<String, Object> data in valueData) {
    final AccessibilityFocusBlockType value =
        data['value'] as AccessibilityFocusBlockType;
    final Color color = data['color'] as Color;
    final IconData icon = data['icon'] as IconData;
    final String tagline = data['tagline'] as String;
    final String description = data['description'] as String;
    final String whenToUse = data['whenToUse'] as String;
    final AlwaysStoppedAnimation<double> intensity =
        data['intensity'] as AlwaysStoppedAnimation<double>;
    final String asciiTree = data['asciiTree'] as String;

    valueCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.06),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.withValues(alpha: 0.65), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 12.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 32.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AccessibilityFocusBlockType.${value.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: color.withValues(alpha: 0.95),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        tagline,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 4.0,
                        children: [
                          _miniChip('index ${value.index}', color),
                          _miniChip('intensity ${(intensity.value * 100).toStringAsFixed(0)}%', color),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.30),
                  width: 1.0,
                ),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.18),
                    color.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline, color: color, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      whenToUse,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            // Intensity meter
            Row(
              children: [
                Text(
                  'Block strength',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 2.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: intensity.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.5),
                              color,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${(intensity.value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // ASCII subtree visualization
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_tree_outlined,
                      color: Colors.greenAccent.shade100, size: 16.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      asciiTree,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: Colors.greenAccent.shade100,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Enumeration sweep
  // ============================================================
  final List<Widget> enumeratedRows = <Widget>[];
  for (int i = 0; i < AccessibilityFocusBlockType.values.length; i++) {
    final AccessibilityFocusBlockType v = AccessibilityFocusBlockType.values[i];
    final Color rowColor = i == 0
        ? Colors.green
        : i == 1
            ? Colors.orange
            : Colors.red;
    enumeratedRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rowColor.withValues(alpha: 0.05),
              rowColor.withValues(alpha: 0.16),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: rowColor.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rowColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: rowColor.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                '${v.index}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                v.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: rowColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: rowColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'AccessibilityFocusBlockType.${v.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: rowColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget enumerationSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: Colors.indigo.shade700),
            SizedBox(width: 8.0),
            Text(
              'AccessibilityFocusBlockType.values',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade700,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '${AccessibilityFocusBlockType.values.length} entries',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...enumeratedRows,
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.first_page, color: Colors.indigo, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'first: ${AccessibilityFocusBlockType.values.first.name}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
              ),
              SizedBox(width: 16.0),
              Icon(Icons.last_page, color: Colors.indigo, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'last: ${AccessibilityFocusBlockType.values.last.name}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Accessibility recipes (idiomatic patterns)
  // ============================================================
  final List<Map<String, Object>> recipeData = [
    {
      'title': 'Hide a decorative wrapper',
      'icon': Icons.crop_din,
      'color': Colors.teal,
      'value': AccessibilityFocusBlockType.blockNode,
      'snippet': '''SemanticsConfiguration()
  ..accessibilityFocusBlockType =
      AccessibilityFocusBlockType.blockNode;
// Children remain focusable; wrapper itself is skipped.''',
      'note':
          'Pattern for purely structural padding/Container nodes that '
          'shouldn\'t become a separate a11y stop.',
    },
    {
      'title': 'Suppress an offscreen drawer',
      'icon': Icons.menu_open,
      'color': Colors.deepOrange,
      'value': AccessibilityFocusBlockType.blockSubtree,
      'snippet': '''SemanticsConfiguration()
  ..accessibilityFocusBlockType =
      AccessibilityFocusBlockType.blockSubtree;
// Whole drawer subtree is invisible to assistive tech.''',
      'note':
          'Use when content is technically present in the tree but visually '
          'or contextually unavailable (offscreen, inert).',
    },
    {
      'title': 'Restore default behavior',
      'icon': Icons.restart_alt,
      'color': Colors.green,
      'value': AccessibilityFocusBlockType.none,
      'snippet': '''SemanticsConfiguration()
  ..accessibilityFocusBlockType =
      AccessibilityFocusBlockType.none;
// Equivalent to never setting the field.''',
      'note':
          'Explicitly clearing an inherited block; identical to leaving '
          'the field at its default value.',
    },
    {
      'title': 'Branching by enum',
      'icon': Icons.alt_route,
      'color': Colors.purple,
      'value': AccessibilityFocusBlockType.blockNode,
      'snippet': '''switch (cfg.accessibilityFocusBlockType) {
  case AccessibilityFocusBlockType.none:
    // pass through
  case AccessibilityFocusBlockType.blockNode:
    // skip current node
  case AccessibilityFocusBlockType.blockSubtree:
    // prune entire subtree
}''',
      'note':
          'Exhaustive switch over the three values — guarantees compile-time '
          'safety if Flutter ever extends the enum.',
    },
  ];

  final List<Widget> recipeCards = <Widget>[];
  for (final Map<String, Object> r in recipeData) {
    final Color c = r['color'] as Color;
    final AccessibilityFocusBlockType bt =
        r['value'] as AccessibilityFocusBlockType;
    recipeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              c.withValues(alpha: 0.05),
              c.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: c.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(r['icon'] as IconData, color: c),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    r['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: c.withValues(alpha: 0.95),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    bt.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: c,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                r['snippet'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.greenAccent.shade100,
                  height: 1.45,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: c, size: 14.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    r['note'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Pitfalls
  // ============================================================
  final List<Map<String, Object>> pitfallData = [
    {
      'icon': Icons.warning,
      'color': Colors.red,
      'title': 'blockSubtree hides interactive children',
      'detail':
          'Setting blockSubtree on a panel will also hide buttons, links '
          'and form fields beneath it from assistive tech, even if they '
          'still respond to taps. Make sure that\'s intentional.',
    },
    {
      'icon': Icons.report_problem,
      'color': Colors.deepOrange,
      'title': 'blockNode does NOT remove pointer events',
      'detail':
          'A blocked node is still hit-testable. To stop pointer events, '
          'pair it with IgnorePointer or AbsorbPointer.',
    },
    {
      'icon': Icons.bug_report,
      'color': Colors.amber,
      'title': 'Confusing with ExcludeSemantics',
      'detail':
          'ExcludeSemantics drops the subtree from the semantics tree '
          'entirely. blockSubtree keeps the nodes for layout/labeling but '
          'makes them unfocusable.',
    },
    {
      'icon': Icons.error_outline,
      'color': Colors.purple,
      'title': 'Merge semantics flattens block flags',
      'detail':
          'When two configurations merge, blockSubtree wins, then '
          'blockNode, then none — never assume the inner node\'s value '
          'survives unchanged.',
    },
    {
      'icon': Icons.rule,
      'color': Colors.blueGrey,
      'title': 'Default is implicit',
      'detail':
          'A SemanticsConfiguration that never touches the field is '
          'identical to one explicitly set to none. Don\'t rely on writes '
          'to detect "user opted in".',
    },
  ];

  final List<Widget> pitfallCards = <Widget>[];
  for (final Map<String, Object> p in pitfallData) {
    final Color c = p['color'] as Color;
    pitfallCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              c.withValues(alpha: 0.12),
              c.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #81, P5(a)):
          // Original combined `borderRadius: 12` with a non-uniform `Border`
          // (left: c/4.0 vs top/right/bottom: c@0.3/1.0). Flutter asserts
          // uniform-colors-or-no-radius. The pitfallCards loop builds 5 cards
          // → 5 errors. Drop borderRadius; the heavy-left accent bar (the
          // visual hallmark of the pitfall card) is carried by the wider,
          // saturated left BorderSide alone.
          border: Border(
            left: BorderSide(color: c, width: 4.0),
            top: BorderSide(color: c.withValues(alpha: 0.3), width: 1.0),
            right: BorderSide(color: c.withValues(alpha: 0.3), width: 1.0),
            bottom: BorderSide(color: c.withValues(alpha: 0.3), width: 1.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(p['icon'] as IconData, color: c, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    p['detail'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Comparison table (vs related public APIs)
  // ============================================================
  final List<List<String>> comparisonRows = [
    [
      'AccessibilityFocusBlockType.none',
      'no',
      'no',
      'no',
      'default',
    ],
    [
      'AccessibilityFocusBlockType.blockNode',
      'this node',
      'no',
      'no',
      'wrappers',
    ],
    [
      'AccessibilityFocusBlockType.blockSubtree',
      'this node',
      'descendants',
      'no',
      'inert regions',
    ],
    [
      'ExcludeSemantics',
      'whole subtree',
      'whole subtree',
      'no',
      'remove from a11y',
    ],
    [
      'BlockSemantics',
      'siblings',
      'siblings',
      'no',
      'modal scrims',
    ],
    [
      'IgnorePointer',
      'no',
      'no',
      'whole subtree',
      'pointer-only',
    ],
    [
      'MergeSemantics',
      'merges',
      'merges',
      'no',
      'flattens reads',
    ],
  ];

  final Widget comparisonTable = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.orange.shade800),
            SizedBox(width: 8.0),
            Text(
              'Comparison with related a11y APIs',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade300,
                Colors.amber.shade300,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _tableHeader('API', flex: 4),
              _tableHeader('Block node', flex: 2),
              _tableHeader('Block subtree', flex: 2),
              _tableHeader('Block pointer', flex: 2),
              _tableHeader('Typical use', flex: 3),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < comparisonRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.amber.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: [
                _tableCell(comparisonRows[i][0], flex: 4, mono: true),
                _tableCell(comparisonRows[i][1], flex: 2),
                _tableCell(comparisonRows[i][2], flex: 2),
                _tableCell(comparisonRows[i][3], flex: 2),
                _tableCell(comparisonRows[i][4], flex: 3),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Quick reference cheatsheet
  // ============================================================
  final Widget cheatsheet = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.cyan.shade100,
          Colors.lightBlue.shade100,
          Colors.indigo.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flash_on, color: Colors.indigo.shade700),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _cheatLine(
          Icons.check_circle,
          Colors.green,
          'none',
          'Default — accessibility focus passes through normally.',
        ),
        _cheatLine(
          Icons.remove_circle,
          Colors.orange,
          'blockNode',
          'Skip this node only — descendants stay focusable.',
        ),
        _cheatLine(
          Icons.cancel,
          Colors.red,
          'blockSubtree',
          'Skip this node and the whole subtree below it.',
        ),
        Divider(color: Colors.indigo.shade200),
        _cheatLine(
          Icons.merge_type,
          Colors.purple,
          'merge order',
          'blockSubtree > blockNode > none.',
        ),
        _cheatLine(
          Icons.touch_app,
          Colors.brown,
          'pointer events',
          'Not affected — combine with IgnorePointer if needed.',
        ),
        _cheatLine(
          Icons.visibility_off,
          Colors.blueGrey,
          'vs ExcludeSemantics',
          'ExcludeSemantics removes nodes; block keeps them, only blocks focus.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Visual focus simulator
  // ============================================================
  // Non-interactive simulator: shows three identical UI fragments side by
  // side, each rendered as if the wrapping SemanticsConfiguration were
  // configured with a different AccessibilityFocusBlockType. We use
  // opacity + overlay glyphs to convey "reachable" vs "blocked" without
  // relying on actual focus state.
  Widget simulatorPanel(
    AccessibilityFocusBlockType mode,
    Color color,
    String label,
  ) {
    final bool nodeBlocked = mode != AccessibilityFocusBlockType.none;
    final bool subtreeBlocked =
        mode == AccessibilityFocusBlockType.blockSubtree;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8.0),
            // wrapper "node"
            Stack(
              children: [
                Opacity(
                  opacity: nodeBlocked ? 0.45 : 1.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: nodeBlocked
                            ? Colors.grey
                            : Colors.green.shade400,
                        width: 1.5,
                        style: nodeBlocked
                            ? BorderStyle.solid
                            : BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.layers,
                              size: 16.0,
                              color: nodeBlocked
                                  ? Colors.grey
                                  : Colors.green.shade700,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              'wrapper',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: nodeBlocked
                                    ? Colors.grey
                                    : Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        // Children
                        Opacity(
                          opacity: subtreeBlocked ? 0.40 : 1.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _simChild('Heading',
                                  blocked: subtreeBlocked, color: color),
                              _simChild('Body text',
                                  blocked: subtreeBlocked, color: color),
                              _simChild('Action button',
                                  blocked: subtreeBlocked, color: color),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (nodeBlocked)
                  Positioned(
                    top: 2.0,
                    right: 2.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        nodeBlocked && !subtreeBlocked
                            ? 'node hidden'
                            : 'subtree hidden',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget simulator = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.preview, color: Colors.grey.shade700),
            SizedBox(width: 8.0),
            Text(
              'Focus reachability simulator',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            simulatorPanel(
              AccessibilityFocusBlockType.none,
              Colors.green.shade700,
              'none',
            ),
            simulatorPanel(
              AccessibilityFocusBlockType.blockNode,
              Colors.orange.shade700,
              'blockNode',
            ),
            simulatorPanel(
              AccessibilityFocusBlockType.blockSubtree,
              Colors.red.shade700,
              'blockSubtree',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  const String asciiArt = r'''
    +----------------------------------------------------+
    |   AccessibilityFocusBlockType  -  Focus Gatekeeper |
    +----------------------------------------------------+
    |  none          ->  o---o---o   (all reachable)     |
    |  blockNode     ->  X---o---o   (root skipped)      |
    |  blockSubtree  ->  X---X---X   (all skipped)       |
    +----------------------------------------------------+
''';

  final Widget footer = Container(
    margin: EdgeInsets.only(top: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent.shade100),
            SizedBox(width: 8.0),
            Text(
              'a11y_focus_block.txt',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.greenAccent.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.greenAccent.shade100,
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose the final layout
  // ============================================================
  final Widget body = SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 24.0),
        _sectionTitle(
            '1. Anatomy', Icons.account_tree, Colors.blueGrey.shade800),
        anatomy,
        SizedBox(height: 20.0),
        _sectionTitle('2. Per-value cards',
            Icons.dashboard_customize, Colors.deepPurple),
        ...valueCards,
        SizedBox(height: 20.0),
        _sectionTitle(
            '3. Enumeration sweep', Icons.list_alt, Colors.indigo),
        enumerationSection,
        SizedBox(height: 20.0),
        _sectionTitle(
            '4. Accessibility recipes', Icons.menu_book, Colors.teal),
        ...recipeCards,
        SizedBox(height: 20.0),
        _sectionTitle(
            '5. Pitfalls', Icons.warning_amber, Colors.red.shade700),
        ...pitfallCards,
        SizedBox(height: 20.0),
        _sectionTitle('6. Comparison vs related APIs',
            Icons.compare_arrows, Colors.orange.shade800),
        comparisonTable,
        SizedBox(height: 20.0),
        _sectionTitle('7. Quick reference', Icons.flash_on, Colors.cyan.shade800),
        cheatsheet,
        SizedBox(height: 20.0),
        _sectionTitle(
            '8. Focus reachability simulator',
            Icons.preview,
            Colors.grey.shade800),
        simulator,
        SizedBox(height: 20.0),
        _sectionTitle('9. ASCII footer', Icons.terminal, Colors.green.shade800),
        footer,
      ],
    ),
  );

  return MaterialApp(home: Scaffold(body: body));
}

// ============================================================
// Helpers
// ============================================================

Widget _heroBadge(String text, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.30),
          color.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String label, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #81, P5(a)):
      // Original combined `borderRadius: 8` with `Border(left: color/4.0)` —
      // top/right/bottom default to BorderSide.none → non-uniform. Flutter
      // asserts uniform-colors-or-no-radius. `_sectionTitle` is invoked
      // throughout the script; Flutter's per-frame throttling absorbs the
      // repeats into the same 5-error count as the pitfallCards site. Drop
      // borderRadius; the heavy-left accent bar look is preserved by the
      // wider colored left BorderSide alone.
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _miniChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _anatomyTree(String mode, Color color) {
  final bool isNone = mode == 'none';
  final bool isBlockNode = mode == 'blockNode';
  final bool isBlockSubtree = mode == 'blockSubtree';
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.20),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          mode,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 10.0),
        _treeNode('A', blocked: isBlockNode || isBlockSubtree, color: color),
        Container(
          width: 2.0,
          height: 16.0,
          color: color.withValues(alpha: 0.5),
        ),
        _treeNode('B', blocked: isBlockSubtree, color: color),
        Container(
          width: 2.0,
          height: 16.0,
          color: color.withValues(alpha: 0.5),
        ),
        _treeNode('C', blocked: isBlockSubtree, color: color),
      ],
    ),
  );
}

Widget _treeNode(String label, {required bool blocked, required Color color}) {
  return Container(
    width: 36.0,
    height: 36.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: blocked
          ? Colors.grey.shade400
          : color.withValues(alpha: 0.85),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: blocked
              ? Colors.grey.withValues(alpha: 0.3)
              : color.withValues(alpha: 0.4),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
        decoration: blocked ? TextDecoration.lineThrough : null,
      ),
    ),
  );
}

Widget _tableHeader(String label, {required int flex}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
          color: Colors.brown.shade900,
        ),
      ),
    ),
  );
}

Widget _tableCell(String text, {required int flex, bool mono = false}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: mono ? 'monospace' : null,
          fontSize: mono ? 10.0 : 11.0,
          color: Colors.black87,
        ),
      ),
    ),
  );
}

Widget _cheatLine(IconData icon, Color color, String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _simChild(String label, {required bool blocked, required Color color}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: blocked ? Colors.grey : color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: blocked ? Colors.grey : Colors.black87,
              decoration: blocked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    ),
  );
}
