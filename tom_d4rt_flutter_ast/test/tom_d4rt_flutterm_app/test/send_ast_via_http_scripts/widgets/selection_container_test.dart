// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionContainer – the widget that groups
// Selectable children and registers them with the enclosing SelectableRegion.
// Also demonstrates SelectionContainer.disabled to prevent selection in
// specific subtrees.
// Deep Demo: Enabled vs disabled containers, nested hierarchies, mixed
// selectable/non-selectable regions, and live toggle interactions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionContainer Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept – What is SelectionContainer?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.view_in_ar,
      'title': 'Grouping Selectables',
      'body': 'SelectionContainer groups one or more Selectable widgets '
          '(Text, RichText, etc.) and registers them with the nearest '
          'SelectionRegistrar ancestor. This is how SelectableRegion '
          'discovers which children participate in selection.',
    },
    {
      'icon': Icons.block,
      'title': 'SelectionContainer.disabled',
      'body': 'The .disabled() constructor creates a container that '
          'prevents all descendants from participating in selection. '
          'Use this to exclude specific parts of a SelectableRegion '
          'subtree – for example, buttons, icons, or decorative elements.',
    },
    {
      'icon': Icons.layers,
      'title': 'Transparent by Default',
      'body': 'SelectionArea automatically wraps its child in a '
          'SelectionContainer. When you use SelectionArea, you get '
          'a container for free. Explicit usage is for advanced cases.',
    },
    {
      'icon': Icons.account_tree,
      'title': 'Registrar Relationship',
      'body': 'SelectionContainer uses SelectionRegistrarScope to find '
          'the nearest SelectionRegistrar (provided by SelectableRegion). '
          'Each container registers/unregisters its delegate when it '
          'mounts/unmounts.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.deepOrange, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
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
  // SECTION 2: Enabled vs Disabled Comparison
  // ============================================================
  print('=== Section 2: Enabled vs Disabled ===');

  final enabledDisabledDemo = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enabled vs Disabled Containers',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Side by side: one with normal selection, one wrapped in '
          'SelectionContainer.disabled that blocks all selection.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
        ),
        const SizedBox(height: 14.0),
        SelectionArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enabled side
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 18.0),
                          const SizedBox(width: 6.0),
                          Text(
                            'SELECTABLE',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.green.shade700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'This text lives inside a normal SelectionContainer. '
                        'You can select it by clicking and dragging. The '
                        'selection highlight appears and you can copy it.',
                        style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              // Disabled side
              Expanded(
                child: SelectionContainer.disabled(
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cancel, color: Colors.red, size: 18.0),
                            const SizedBox(width: 6.0),
                            Text(
                              'NOT SELECTABLE',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.red.shade700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'This text is wrapped in SelectionContainer.disabled(). '
                          'No matter how you try, you cannot select it. The '
                          'selection gesture passes through as if it were a '
                          'non-text widget.',
                          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Mixed Selectability in a Single Region
  // ============================================================
  print('=== Section 3: Mixed Selectability ===');

  final mixedDemo = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Article with Mixed Selectability',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        Text(
          'A realistic use case: article body is selectable, but the header, '
          'metadata badges, and action buttons are not.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
        ),
        const SizedBox(height: 14.0),
        SelectionArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Non-selectable header
                SelectionContainer.disabled(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'TUTORIAL',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'Understanding Flutter Selection',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.person, size: 14.0, color: Colors.grey.shade500),
                          SizedBox(width: 4.0),
                          Text(
                            'By Flutter Team  |  April 2026  |  5 min read',
                            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade200),
                    ],
                  ),
                ),
                // Selectable body paragraphs
                const Text(
                  'The Flutter selection system works by establishing a '
                  'SelectableRegion that manages the overall selection state. '
                  'Within this region, SelectionContainer instances group '
                  'selectable content together.',
                  style: TextStyle(fontSize: 13.0, color: Colors.black87, height: 1.55),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'When you need to prevent selection on certain elements '
                  'like navigation buttons, category tags, or decorative '
                  'images, wrap them in SelectionContainer.disabled(). This '
                  'is much cleaner than trying to intercept gestures.',
                  style: TextStyle(fontSize: 13.0, color: Colors.black87, height: 1.55),
                ),
                const SizedBox(height: 10.0),
                // Non-selectable code block
                SelectionContainer.disabled(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.code, size: 14.0, color: Colors.grey.shade500),
                            SizedBox(width: 4.0),
                            Text(
                              'Non-selectable code block',
                              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          'SelectionContainer.disabled(\n'
                          '  child: Text("Cannot select me"),\n'
                          ')',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Selectable continuation
                const Text(
                  'The disabled container can be placed at any level in the '
                  'widget tree. All descendants are excluded from selection, '
                  'even if they are normally selectable widgets.',
                  style: TextStyle(fontSize: 13.0, color: Colors.black87, height: 1.55),
                ),
                // Non-selectable footer
                SelectionContainer.disabled(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, size: 16.0, color: Colors.grey.shade500),
                        SizedBox(width: 4.0),
                        Text('42 likes', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500)),
                        SizedBox(width: 16.0),
                        Icon(Icons.comment_outlined, size: 16.0, color: Colors.grey.shade500),
                        SizedBox(width: 4.0),
                        Text('7 comments', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500)),
                        Spacer(),
                        Icon(Icons.share, size: 16.0, color: Colors.grey.shade500),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Constructor Reference
  // ============================================================
  print('=== Section 4: Constructors ===');

  final constructors = <Map<String, dynamic>>[
    {
      'name': 'SelectionContainer()',
      'color': Colors.green,
      'params': <Map<String, String>>[
        {
          'param': 'registrar',
          'type': 'SelectionRegistrar?',
          'desc': 'Custom registrar. If null, uses the nearest ancestor registrar.',
        },
        {
          'param': 'delegate',
          'type': 'SelectionContainerDelegate',
          'desc': 'Required. Handles selection events for the grouped children.',
        },
        {
          'param': 'child',
          'type': 'Widget?',
          'desc': 'Child widget tree containing selectable content.',
        },
      ],
    },
    {
      'name': 'SelectionContainer.disabled()',
      'color': Colors.red,
      'params': <Map<String, String>>[
        {
          'param': 'child',
          'type': 'Widget?',
          'desc': 'Child subtree that will be excluded from selection entirely.',
        },
      ],
    },
  ];

  final constructorWidgets = <Widget>[];
  for (final ctor in constructors) {
    final color = ctor['color'] as Color;
    final params = ctor['params'] as List<Map<String, String>>;

    constructorWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(
                ctor['name'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
            ...params.map((p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.0,
                    child: Text(
                      p['param']!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['type']!,
                          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.teal.shade700),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          p['desc']!,
                          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Nested Containers
  // ============================================================
  print('=== Section 5: Nested Containers ===');

  final nestedDemo = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nested Container Hierarchy',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        Text(
          'SelectionContainer.disabled can be nested inside enabled containers. '
          'The disabled flag only affects its subtree – siblings remain selectable.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
        ),
        const SizedBox(height: 14.0),
        SelectionArea(
          child: Column(
            children: [
              // Level 1 – normal (selectable)
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 8.0, height: 8.0, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green)),
                        const SizedBox(width: 6.0),
                        Text('Level 1 – Selectable', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.green.shade700)),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'This paragraph is at the top level and is selectable.',
                      style: TextStyle(fontSize: 12.5, height: 1.4),
                    ),
                    const SizedBox(height: 10.0),
                    // Level 2 – disabled
                    SelectionContainer.disabled(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 8.0, height: 8.0, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
                                const SizedBox(width: 6.0),
                                Text('Level 2 – Disabled', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.red.shade700)),
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            const Text(
                              'This nested paragraph is inside a disabled container. '
                              'You cannot select it even though its parent is selectable.',
                              style: TextStyle(fontSize: 12.5, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    // Back to selectable
                    const Text(
                      'This paragraph is a sibling of the disabled container '
                      'and remains selectable. The disabled flag does not leak.',
                      style: TextStyle(fontSize: 12.5, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // Legend
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The disabled scope only affects its own subtree. '
                  'Sibling and parent containers are unaffected.',
                  style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Live Toggle Demo
  // ============================================================
  print('=== Section 6: Live Toggle ===');

  final toggleDemo = _SelectionToggleDemo();

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Article Layout',
      'icon': Icons.article,
      'color': Colors.blue,
      'selectable': 'Body text, quotes, captions',
      'disabled': 'Header, navigation, metadata, social buttons',
    },
    {
      'title': 'Chat Interface',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.green,
      'selectable': 'Message text content',
      'disabled': 'Avatars, timestamps, reaction buttons, input area',
    },
    {
      'title': 'Data Table',
      'icon': Icons.table_chart,
      'color': Colors.purple,
      'selectable': 'Cell values',
      'disabled': 'Column headers, row indices, sort indicators',
    },
    {
      'title': 'Code Editor',
      'icon': Icons.code,
      'color': Colors.orange,
      'selectable': 'Code content',
      'disabled': 'Line numbers, gutter icons, minimap',
    },
    {
      'title': 'Documentation',
      'icon': Icons.menu_book,
      'color': Colors.teal,
      'selectable': 'Content text, code samples',
      'disabled': 'Navigation sidebar, breadcrumbs, table of contents links',
    },
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCases) {
    final color = uc['color'] as Color;
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(uc['icon'] as IconData, color: color, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  uc['title'] as String,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Selectable: ${uc['selectable']}',
                    style: TextStyle(fontSize: 11.5, color: Colors.green.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Icon(Icons.cancel, color: Colors.red, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Disabled: ${uc['disabled']}',
                    style: TextStyle(fontSize: 11.5, color: Colors.red.shade700),
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
  // SECTION 8: How Registrar Works
  // ============================================================
  print('=== Section 8: Registrar Mechanism ===');

  final registrarSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'SelectableRegion Provides Registrar',
      'desc': 'When SelectableRegion builds, it provides a SelectionRegistrar '
          'via SelectionRegistrarScope. This is the registration endpoint.',
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'Container Finds Registrar',
      'desc': 'SelectionContainer looks up the registrar via '
          'SelectionRegistrarScope.maybeOf(context) during initState/didChangeDependencies.',
      'color': Colors.purple,
    },
    {
      'step': '3',
      'title': 'Delegate Registered',
      'desc': 'The container registers its SelectionContainerDelegate with the registrar. '
          'This lets SelectableRegion discover the container and its children.',
      'color': Colors.teal,
    },
    {
      'step': '4',
      'title': 'Selection Events Flow',
      'desc': 'When the user selects, SelectableRegion dispatches selection events to '
          'all registered delegates. Each delegate determines which of its children '
          'are inside the selection bounds.',
      'color': Colors.orange,
    },
    {
      'step': '5',
      'title': 'Cleanup on Dispose',
      'desc': 'When the container unmounts, it unregisters from the registrar. '
          'This prevents stale references and selection artifacts.',
      'color': Colors.red,
    },
  ];

  final registrarWidgets = <Widget>[];
  for (final rs in registrarSteps) {
    final color = rs['color'] as Color;
    registrarWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                child: Text(
                  rs['step'] as String,
                  style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rs['title'] as String, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  Text(rs['desc'] as String, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600, height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.view_in_ar, 'text': 'Groups Selectable children and registers them with SelectableRegion'},
    {'icon': Icons.block, 'text': '.disabled() excludes a subtree from selection entirely'},
    {'icon': Icons.layers, 'text': 'SelectionArea creates one automatically; explicit usage is for advanced cases'},
    {'icon': Icons.account_tree, 'text': 'Uses SelectionRegistrar for discovery and lifecycle management'},
    {'icon': Icons.article, 'text': 'Key tool for mixed-selectability layouts (articles, chat, tables)'},
    {'icon': Icons.nest_cam_wired_stand, 'text': 'Disabled containers can be nested; the flag does not leak to siblings'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.deepOrange),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD FINAL TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionContainer'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Enabled/Disabled'),
            Tab(text: 'Mixed Layout'),
            Tab(text: 'Constructors'),
            Tab(text: 'Nested'),
            Tab(text: 'Live Toggle'),
            Tab(text: 'Use Cases'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('What is SelectionContainer?',
                    'A widget that groups selectable content and registers it '
                    'with the nearest SelectableRegion. Its .disabled() '
                    'constructor prevents all descendants from being selected.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Enabled/Disabled
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Side-by-Side Comparison',
                    'Try selecting text in each panel to see the difference '
                    'between enabled and disabled containers.'),
                const SizedBox(height: 14.0),
                enabledDisabledDemo,
              ],
            ),
          ),
          // Tab 3: Mixed Layout
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Mixed Selectability',
                    'A realistic article layout where body text is selectable '
                    'but UI chrome (headers, badges, buttons) is not.'),
                const SizedBox(height: 14.0),
                mixedDemo,
              ],
            ),
          ),
          // Tab 4: Constructors
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Constructor Reference',
                    'SelectionContainer has two constructors: the default '
                    'constructor for custom registrar/delegate usage, and '
                    '.disabled() for excluding subtrees.'),
                const SizedBox(height: 14.0),
                ...constructorWidgets,
              ],
            ),
          ),
          // Tab 5: Nested
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Nested Containers',
                    'Disabled containers can be nested inside enabled ones. '
                    'Only the disabled subtree is affected – siblings remain selectable.'),
                const SizedBox(height: 14.0),
                nestedDemo,
              ],
            ),
          ),
          // Tab 6: Live Toggle
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Live Toggle Demo',
                    'Toggle SelectionContainer.disabled on and off to see '
                    'how it affects selectability in real time.'),
                const SizedBox(height: 14.0),
                toggleDemo,
              ],
            ),
          ),
          // Tab 7: Use Cases
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Common Use Cases',
                    'Typical scenarios where mixing selectable and non-selectable '
                    'content improves user experience.'),
                const SizedBox(height: 14.0),
                ...useCaseCards,
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Registrar Mechanism',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10.0),
                      ...registrarWidgets,
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange.withValues(alpha: 0.05),
                        Colors.orange.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
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

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSCBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.deepOrange, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.deepOrange)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Selection Toggle Demo
// ---------------------------------------------------------------------------
class _SelectionToggleDemo extends StatefulWidget {
  @override
  State<_SelectionToggleDemo> createState() => _SelectionToggleDemoState();
}

class _SelectionToggleDemoState extends State<_SelectionToggleDemo> {
  bool _section1Disabled = false;
  bool _section2Disabled = true;
  bool _section3Disabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toggle Selection Per Section',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Use the switches to enable/disable selection for each section. '
            'Then try selecting text to see the effect.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          // Control panel
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                _toggleRow('Section 1: Introduction', _section1Disabled, (v) => setState(() => _section1Disabled = v)),
                _toggleRow('Section 2: Details', _section2Disabled, (v) => setState(() => _section2Disabled = v)),
                _toggleRow('Section 3: Conclusion', _section3Disabled, (v) => setState(() => _section3Disabled = v)),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          // Content
          SelectionArea(
            child: Column(
              children: [
                _toggleableSection(
                  'Section 1: Introduction',
                  'SelectionContainer is one of the building blocks of the '
                  'Flutter selection system. It bridges the gap between '
                  'SelectableRegion and individual Selectable widgets.',
                  _section1Disabled,
                  Colors.blue,
                ),
                const SizedBox(height: 8.0),
                _toggleableSection(
                  'Section 2: Details',
                  'The disabled constructor creates a special container that '
                  'intercepts the SelectionRegistrar lookup. Instead of '
                  'forwarding the registrar to children, it provides null, '
                  'effectively hiding all descendants from the selection system.',
                  _section2Disabled,
                  Colors.purple,
                ),
                const SizedBox(height: 8.0),
                _toggleableSection(
                  'Section 3: Conclusion',
                  'By combining enabled and disabled containers, you can '
                  'create sophisticated selection experiences that only '
                  'allow users to select meaningful content.',
                  _section3Disabled,
                  Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleRow(String label, bool disabled, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: disabled ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                color: disabled ? Colors.red.shade700 : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            disabled ? 'DISABLED' : 'ENABLED',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              color: disabled ? Colors.red : Colors.green,
            ),
          ),
          Switch(
            value: disabled,
            onChanged: onChanged,
            activeColor: Colors.red,
            inactiveThumbColor: Colors.green,
            inactiveTrackColor: Colors.green.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _toggleableSection(String title, String body, bool disabled, Color color) {
    Widget content = Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: disabled
            ? Colors.grey.withValues(alpha: 0.05)
            : color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: disabled ? Colors.grey.shade300 : color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                disabled ? Icons.lock : Icons.lock_open,
                size: 16.0,
                color: disabled ? Colors.grey : color,
              ),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: disabled ? Colors.grey : color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: TextStyle(
              fontSize: 12.5,
              color: disabled ? Colors.grey.shade500 : Colors.grey.shade800,
              height: 1.45,
            ),
          ),
        ],
      ),
    );

    if (disabled) {
      return SelectionContainer.disabled(child: content);
    }
    return content;
  }
}
