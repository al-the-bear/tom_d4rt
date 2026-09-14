// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionRegistrarScope – an InheritedWidget that
// provides a SelectionRegistrar to its subtree, enabling Selectable widgets
// to register for selection events. Deep Demo: Concept, InheritedWidget
// pattern, registrar interface, tree propagation, live demo, disabled
// selection, code patterns, summary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionRegistrarScope Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'InheritedWidget for Selection',
      'body': 'SelectionRegistrarScope is an InheritedWidget that hosts a '
          'SelectionRegistrar. It propagates the registrar down the widget '
          'tree so Selectable descendants can find and register with it.',
    },
    {
      'icon': Icons.app_registration,
      'title': 'Registration Gateway',
      'body': 'Selectable widgets (like Text inside a SelectionArea) use '
          'the registrar from the nearest SelectionRegistrarScope to '
          'register themselves. The registrar then dispatches selection '
          'events to all registered selectables.',
    },
    {
      'icon': Icons.layers,
      'title': 'Created by SelectionContainer',
      'body': 'You rarely create SelectionRegistrarScope directly. '
          'SelectionContainer creates one internally, wrapping its child '
          'subtree with a registrar backed by its delegate.',
    },
    {
      'icon': Icons.block,
      'title': 'Disabling Selection',
      'body': 'SelectionContainer.disabled() creates a scope with a null '
          'registrar, preventing descendant widgets from registering '
          'for selection – effectively making content non-selectable.',
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
          color: Colors.deepPurple.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.deepPurple.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple.shade700,
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
  // SECTION 2: InheritedWidget Pattern
  // ============================================================
  print('=== Section 2: InheritedWidget ===');

  final inheritedSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Scope Provides Registrar',
      'color': Colors.blue,
      'code': 'SelectionRegistrarScope(\n'
          '  registrar: myRegistrar,\n'
          '  child: subtree,\n'
          ')',
      'desc': 'An ancestor places a registrar into the tree via the scope.',
    },
    {
      'step': '2',
      'title': 'Descendants Look Up Scope',
      'color': Colors.green,
      'code': 'final registrar =\n'
          '  SelectionContainer.maybeOf(context);',
      'desc': 'Any descendant can find the nearest registrar using context.',
    },
    {
      'step': '3',
      'title': 'Selectables Register',
      'color': Colors.purple,
      'code': 'registrar?.add(this);\n'
          '// ...\n'
          'registrar?.remove(this);',
      'desc': 'Selectable render objects call add() on mount and remove() on unmount.',
    },
    {
      'step': '4',
      'title': 'Events Dispatched',
      'color': Colors.orange,
      'code': '// SelectionArea dispatches:\n'
          'registrar.dispatchSelectionEvent(\n'
          '  SelectWordSelectionEvent(...),\n'
          ');',
      'desc': 'Selection events flow through the registrar to all registered selectables.',
    },
  ];

  final inheritedWidgets = <Widget>[];
  for (final is_ in inheritedSteps) {
    final color = is_['color'] as Color;
    inheritedWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    child: Center(
                      child: Text(
                        is_['step'] as String,
                        style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    is_['title'] as String,
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey.shade50,
              child: Text(
                is_['code'] as String,
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade800),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                is_['desc'] as String,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: SelectionRegistrar Interface
  // ============================================================
  print('=== Section 3: Registrar Interface ===');

  final registrarMethods = <Map<String, dynamic>>[
    {
      'method': 'add(Selectable selectable)',
      'color': Colors.green,
      'icon': Icons.add_circle_outline,
      'desc': 'Registers a Selectable with the registrar. Called by '
          'SelectionRegistrant mixin during attach(). The registrar '
          'starts tracking this selectable for selection events.',
    },
    {
      'method': 'remove(Selectable selectable)',
      'color': Colors.red,
      'icon': Icons.remove_circle_outline,
      'desc': 'Unregisters a Selectable from the registrar. Called '
          'during detach() or when the registrar changes. The selectable '
          'will no longer receive selection events.',
    },
  ];

  final registrarCards = <Widget>[];
  for (final rm in registrarMethods) {
    final color = rm['color'] as Color;
    registrarCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
              ),
              child: Icon(rm['icon'] as IconData, color: color, size: 22.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rm['method'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    rm['desc'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
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
  // SECTION 4: Tree Propagation
  // ============================================================
  print('=== Section 4: Tree Propagation ===');

  final treeNodes = <Map<String, dynamic>>[
    {
      'indent': 0,
      'widget': 'SelectionArea',
      'role': 'Creates root SelectionRegistrar',
      'color': Colors.blue,
    },
    {
      'indent': 1,
      'widget': 'SelectionRegistrarScope',
      'role': 'Hosts the root registrar (auto-created)',
      'color': Colors.deepPurple,
    },
    {
      'indent': 2,
      'widget': 'SelectionContainer',
      'role': 'Creates nested scope with its delegate',
      'color': Colors.teal,
    },
    {
      'indent': 3,
      'widget': 'SelectionRegistrarScope',
      'role': 'Hosts delegate as registrar (auto-created)',
      'color': Colors.deepPurple,
    },
    {
      'indent': 4,
      'widget': 'Text / SelectableText',
      'role': 'Selectable — registers via nearest scope',
      'color': Colors.green,
    },
    {
      'indent': 2,
      'widget': 'SelectionContainer.disabled()',
      'role': 'Creates scope with null registrar',
      'color': Colors.red,
    },
    {
      'indent': 3,
      'widget': 'SelectionRegistrarScope (null)',
      'role': 'Null registrar blocks selection',
      'color': Colors.grey,
    },
    {
      'indent': 4,
      'widget': 'Text (non-selectable)',
      'role': 'Cannot register: registrar is null',
      'color': Colors.grey,
    },
  ];

  final treeWidgets = <Widget>[];
  for (final tn in treeNodes) {
    final indent = tn['indent'] as int;
    final color = tn['color'] as Color;
    treeWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: indent * 20.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              if (indent > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Icon(Icons.subdirectory_arrow_right, size: 12.0, color: Colors.grey.shade400),
                ),
              Icon(Icons.circle, size: 6.0, color: color),
              const SizedBox(width: 6.0),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      tn['widget'] as String,
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                          fontWeight: FontWeight.w700, color: color),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        tn['role'] as String,
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SRSLiveDemo();

  // ============================================================
  // SECTION 6: Disabled Selection
  // ============================================================
  print('=== Section 6: Disabled Selection ===');

  final disabledDemo = _SRSDisabledDemo();

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'SelectionContainer.disabled()',
      'color': Colors.red,
      'desc': 'The most common use of the scope is through '
          'SelectionContainer.disabled() which creates a scope with '
          'a null registrar, preventing selection in a subtree.',
      'code': 'SelectionArea(\n'
          '  child: Column(\n'
          '    children: [\n'
          '      Text("Selectable text"),\n'
          '      SelectionContainer.disabled(\n'
          '        child: Text("Not selectable"),\n'
          '      ),\n'
          '      Text("Selectable again"),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Nested Selection Containers',
      'color': Colors.blue,
      'desc': 'Each SelectionContainer creates its own scope. Nested '
          'containers create a hierarchy of registrars, allowing '
          'different sections to have independent selection behavior.',
      'code': 'SelectionArea(\n'
          '  child: Column(\n'
          '    children: [\n'
          '      SelectionContainer(\n'
          '        delegate: sectionADelegate,\n'
          '        child: sectionAContent,\n'
          '      ),\n'
          '      SelectionContainer(\n'
          '        delegate: sectionBDelegate,\n'
          '        child: sectionBContent,\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Looking Up the Registrar',
      'color': Colors.green,
      'desc': 'Use SelectionContainer.maybeOf() to find the nearest '
          'registrar. Returns null if selection is disabled or no '
          'SelectionRegistrarScope is in the tree.',
      'code': '// In a RenderObject or widget:\n'
          'final registrar =\n'
          '  SelectionContainer.maybeOf(context);\n'
          '\n'
          'if (registrar != null) {\n'
          '  registrar.add(mySelectable);\n'
          '} else {\n'
          '  // Selection is disabled\n'
          '}',
    },
    {
      'title': 'updateShouldNotify',
      'color': Colors.purple,
      'desc': 'The scope notifies descendants when the registrar changes. '
          'This triggers re-registration: selectables remove from old '
          'registrar and add to the new one.',
      'code': '// Internal to SelectionRegistrarScope:\n'
          '@override\n'
          'bool updateShouldNotify(\n'
          '  SelectionRegistrarScope old,\n'
          ') {\n'
          '  return old.registrar != registrar;\n'
          '}',
    },
  ];

  final patternCards = <Widget>[];
  for (final p in patterns) {
    final color = p['color'] as Color;
    patternCards.add(
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
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(
                p['title'] as String,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                p['desc'] as String,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                p['code'] as String,
                style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.account_tree, 'text': 'SelectionRegistrarScope is an InheritedWidget hosting a SelectionRegistrar'},
    {'icon': Icons.app_registration, 'text': 'Selectable render objects register/unregister through it'},
    {'icon': Icons.layers, 'text': 'Created automatically by SelectionContainer and SelectionArea'},
    {'icon': Icons.block, 'text': 'SelectionContainer.disabled() creates scope with null registrar'},
    {'icon': Icons.sync, 'text': 'updateShouldNotify triggers re-registration when registrar changes'},
    {'icon': Icons.search, 'text': 'Look up via SelectionContainer.maybeOf(context)'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.deepPurple.shade700),
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
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionRegistrarScope'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'InheritedWidget'),
            Tab(text: 'Registrar'),
            Tab(text: 'Tree'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Disabled'),
            Tab(text: 'Patterns'),
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
                _buildSRSBullet('What is SelectionRegistrarScope?',
                    'An InheritedWidget that provides a SelectionRegistrar '
                    'to descendant widgets, enabling them to participate '
                    'in text selection.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: InheritedWidget Pattern
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('InheritedWidget Pattern',
                    'How the scope propagates the registrar down the tree.'),
                const SizedBox(height: 14.0),
                ...inheritedWidgets,
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
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
                          'The SelectionRegistrant mixin on RenderObjects '
                          'automates the register/unregister lifecycle. It '
                          'listens for scope changes and re-registers with '
                          'the new registrar automatically.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Registrar Interface
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('SelectionRegistrar Interface',
                    'The abstract interface that the scope hosts. Only two '
                    'methods: add() and remove().'),
                const SizedBox(height: 14.0),
                ...registrarCards,
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selectable Interface',
                          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                              color: Colors.deepPurple.shade700)),
                      const SizedBox(height: 8.0),
                      Text(
                        'The Selectable objects that register must implement '
                        'dispatchSelectionEvent(), getSelectionGeometry(), '
                        'and other methods. This is handled by the framework '
                        'for built-in widgets like Text paragraphs.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          'abstract class SelectionRegistrar {\n'
                          '  void add(Selectable selectable);\n'
                          '  void remove(Selectable selectable);\n'
                          '}',
                          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: Tree
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('Widget Tree Propagation',
                    'How SelectionRegistrarScope scopes flow through '
                    'the widget tree.'),
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: treeWidgets,
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scope Nesting',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                              color: Colors.deepPurple.shade700)),
                      const SizedBox(height: 6.0),
                      Text(
                        'Each SelectionContainer creates a new scope that '
                        'shadows the parent scope. Selectables always register '
                        'with the nearest (innermost) scope. This creates a '
                        'hierarchy where selection can be managed per-section.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('Live Selection Demo',
                    'Text inside a SelectionArea can be selected. '
                    'The registrar scope makes this possible.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Disabled
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('Disabling Selection',
                    'SelectionContainer.disabled() creates a scope with '
                    'null registrar, blocking selection in a subtree.'),
                const SizedBox(height: 14.0),
                disabledDemo,
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('Code Patterns',
                    'Common usage patterns for SelectionRegistrarScope.'),
                const SizedBox(height: 14.0),
                ...patternCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withValues(alpha: 0.05),
                        Colors.purple.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
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
Widget _buildSRSBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.deepPurple.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.deepPurple.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Demo
// ---------------------------------------------------------------------------
class _SRSLiveDemo extends StatefulWidget {
  @override
  State<_SRSLiveDemo> createState() => _SRSLiveDemoState();
}

class _SRSLiveDemoState extends State<_SRSLiveDemo> {
  bool _hasRegistrar = false;

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
            'SelectionArea provides the registrar scope',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'All text below is inside a SelectionArea. Try selecting '
            'across multiple paragraphs.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 14.0),
          SelectionArea(
            child: Builder(
              builder: (innerContext) {
                // Check if registrar exists
                final registrar = SelectionContainer.maybeOf(innerContext);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _hasRegistrar = registrar != null;
                    });
                  }
                });
                return Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: _hasRegistrar
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _hasRegistrar ? Icons.check_circle : Icons.cancel,
                              size: 14.0,
                              color: _hasRegistrar ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Registrar: ${_hasRegistrar ? "Available" : "None"}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                                color: _hasRegistrar ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'This text is inside a SelectionArea which provides '
                        'a SelectionRegistrarScope. The scope hosts a '
                        'registrar that Text paragraphs automatically '
                        'register with.',
                        style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'When you drag to select text, the registrar '
                        'dispatches selection events to all registered '
                        'selectables. Each Text widget responds by updating '
                        'its selection highlight.',
                        style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'You can select across these paragraphs because they '
                        'all share the same registrar from the enclosing '
                        'SelectionRegistrarScope.',
                        style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How it works:',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                        color: Colors.deepPurple.shade700)),
                const SizedBox(height: 6.0),
                _stepItem('1', 'SelectionArea creates a registrar'),
                _stepItem('2', 'SelectionRegistrarScope hosts the registrar'),
                _stepItem('3', 'Text paragraphs register via maybeOf(context)'),
                _stepItem('4', 'User drag dispatches events through registrar'),
                _stepItem('5', 'Each Text updates its selection highlight'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple.withValues(alpha: 0.15),
            ),
            child: Center(
              child: Text(num,
                  style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700,
                      color: Colors.deepPurple.shade700)),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Disabled Selection Demo
// ---------------------------------------------------------------------------
class _SRSDisabledDemo extends StatelessWidget {
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
            'Selectable vs Non-Selectable Sections',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'SelectionContainer.disabled() creates a scope with null '
            'registrar, blocking selection for that subtree.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 14.0),
          SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selectable section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 14.0, color: Colors.green),
                          const SizedBox(width: 6.0),
                          Text('Selectable (registrar available)',
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'This text is selectable because it has access to '
                        'the SelectionRegistrarScope from the parent '
                        'SelectionArea. Try selecting it.',
                        style: TextStyle(fontSize: 13.0, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                // Disabled section
                SelectionContainer.disabled(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cancel, size: 14.0, color: Colors.red),
                            const SizedBox(width: 6.0),
                            Text('Non-Selectable (registrar is null)',
                                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                                    color: Colors.red.shade700)),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'This text is NOT selectable. SelectionContainer.disabled() '
                          'creates a scope with null registrar, so Text paragraphs '
                          'here cannot register for selection.',
                          style: TextStyle(fontSize: 13.0, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Another selectable section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 14.0, color: Colors.green),
                          const SizedBox(width: 6.0),
                          Text('Selectable again (parent scope restored)',
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'This text is selectable again because it is outside '
                        'the disabled container and can see the parent scope. '
                        'The disabled scope only affects its own subtree.',
                        style: TextStyle(fontSize: 13.0, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'SelectionArea\n'
              '  +-- Text (selectable)\n'
              '  +-- SelectionContainer.disabled()\n'
              '  |     +-- Text (NOT selectable)\n'
              '  +-- Text (selectable)',
              style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
