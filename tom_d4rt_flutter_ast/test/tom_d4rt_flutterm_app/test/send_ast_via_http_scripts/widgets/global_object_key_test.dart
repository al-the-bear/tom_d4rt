// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — GlobalObjectKey
// Demonstrates GlobalObjectKey — a GlobalKey whose identity is
// based on an object reference. Covers key hierarchy, identity vs
// equality, widget state preservation across trees, and comparison
// with ValueKey, ObjectKey, UniqueKey and plain GlobalKey.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GlobalObjectKey Deep Demo executing');

  // ============================================================
  // SECTION 1: What is GlobalObjectKey?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.vpn_key,
      'title': 'A GlobalKey Tied to an Object',
      'body': 'GlobalObjectKey<T> is a GlobalKey whose identity is '
          'determined by the object you pass to its constructor. '
          'Two GlobalObjectKey instances wrapping the SAME object '
          '(identical) are considered equal. This lets you create '
          'globally unique keys from existing object references.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.fingerprint,
      'title': 'Identity, Not Value',
      'body': 'Unlike ValueKey which uses operator== for comparison, '
          'GlobalObjectKey uses the identity of the wrapped value. '
          'The default behavior relies on the object\'s == operator, '
          'but in practice it\'s typically used with unique object '
          'instances where identity IS equality.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.public,
      'title': 'Global Scope',
      'body': 'As a GlobalKey, it\'s unique across the ENTIRE widget '
          'tree. Only one widget in the whole app can have a given '
          'GlobalObjectKey at any time. This enables state '
          'preservation when widgets move between parents.',
      'accent': Colors.orange[600]!,
    },
    {
      'icon': Icons.data_object,
      'title': 'Data Model Integration',
      'body': 'The primary use case: you have a data model object '
          '(like a User, a TodoItem, or a database record) and want '
          'a global key derived from it. GlobalObjectKey(myUser) '
          'gives you a consistent key that matches whenever the '
          'same object instance is used.',
      'accent': Colors.amber[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Key Hierarchy
  // ============================================================
  print('=== Section 2: Key Hierarchy ===');

  final keyTypes = <Map<String, dynamic>>[
    {
      'name': 'Key (abstract)',
      'icon': Icons.account_tree,
      'color': Colors.grey[600]!,
      'depth': 0,
      'description': 'The root of all key types. Used by the framework '
          'to identify widgets during reconciliation.',
    },
    {
      'name': 'LocalKey',
      'icon': Icons.key,
      'color': Colors.orange[500]!,
      'depth': 1,
      'description': 'Keys that are unique among siblings. ValueKey, '
          'ObjectKey, UniqueKey. Used in lists and collections.',
    },
    {
      'name': 'ValueKey<T>',
      'icon': Icons.tag,
      'color': Colors.orange[400]!,
      'depth': 2,
      'description': 'Compares by value using operator==. '
          'ValueKey("hello") == ValueKey("hello"). Most common local key.',
    },
    {
      'name': 'ObjectKey',
      'icon': Icons.data_object,
      'color': Colors.orange[400]!,
      'depth': 2,
      'description': 'Compares by object identity (identical()). '
          'ObjectKey(objA) == ObjectKey(objA) only if same instance.',
    },
    {
      'name': 'UniqueKey',
      'icon': Icons.ac_unit,
      'color': Colors.orange[400]!,
      'depth': 2,
      'description': 'Always unique — never equals any other key. '
          'Each UniqueKey() creates a distinct identity.',
    },
    {
      'name': 'GlobalKey<T>',
      'icon': Icons.public,
      'color': Colors.amber[700]!,
      'depth': 1,
      'description': 'Unique across the entire widget tree. Provides '
          'access to State and BuildContext of the associated widget. '
          'More expensive than LocalKey.',
    },
    {
      'name': 'GlobalObjectKey<T>',
      'icon': Icons.vpn_key,
      'color': Colors.orange[700]!,
      'depth': 2,
      'description': 'A GlobalKey whose equality is based on a wrapped '
          'object. GlobalObjectKey(obj) where two instances with the '
          'same obj are equal. THIS IS THE DEMO SUBJECT.',
    },
    {
      'name': 'LabeledGlobalKey',
      'icon': Icons.label,
      'color': Colors.amber[600]!,
      'depth': 2,
      'description': 'A GlobalKey with a debug label. Created by '
          'GlobalKey() constructor. The label appears in toString() '
          'for debugging. Always unique (identity-based).',
    },
  ];

  print('  Prepared ${keyTypes.length} key types');

  // ============================================================
  // SECTION 3: Identity vs Equality
  // ============================================================
  print('=== Section 3: Identity vs Equality ===');

  final identityExamples = <Map<String, dynamic>>[
    {
      'scenario': 'Same object instance',
      'code': 'final user = User("Alice");\n'
          'GlobalObjectKey(user) == GlobalObjectKey(user)',
      'result': 'TRUE',
      'resultColor': Colors.green[600]!,
      'icon': Icons.check_circle,
      'explanation': 'Same object reference → same key. The two keys '
          'point to the identical User instance.',
    },
    {
      'scenario': 'Different objects, same data',
      'code': 'final user1 = User("Alice");\n'
          'final user2 = User("Alice");\n'
          'GlobalObjectKey(user1) == GlobalObjectKey(user2)',
      'result': 'DEPENDS',
      'resultColor': Colors.orange[600]!,
      'icon': Icons.help,
      'explanation': 'Depends on User\'s == operator. If User '
          'implements operator== based on name, they\'re equal. '
          'If using default Object identity, they\'re NOT equal.',
    },
    {
      'scenario': 'Primitive values',
      'code': 'GlobalObjectKey(42) == GlobalObjectKey(42)',
      'result': 'TRUE',
      'resultColor': Colors.green[600]!,
      'icon': Icons.check_circle,
      'explanation': 'Dart interns small integers. 42 is 42 — same '
          'object. Strings may also be interned. But this behavior '
          'is unreliable — use ValueKey for primitives instead.',
    },
    {
      'scenario': 'Null values',
      'code': 'GlobalObjectKey(null) == GlobalObjectKey(null)',
      'result': 'TRUE',
      'resultColor': Colors.green[600]!,
      'icon': Icons.check_circle,
      'explanation': 'null is always identical to null. But having '
          'a null-keyed GlobalKey is unusual and suggests a design '
          'issue.',
    },
    {
      'scenario': 'vs ValueKey',
      'code': 'GlobalObjectKey("hello") vs ValueKey("hello")',
      'result': 'NOT EQUAL',
      'resultColor': Colors.red[600]!,
      'icon': Icons.cancel,
      'explanation': 'Different key types are never equal even if '
          'they wrap the same value. Type matters.',
    },
  ];

  print('  Prepared ${identityExamples.length} identity examples');

  // ============================================================
  // SECTION 4: GlobalKey Capabilities
  // ============================================================
  print('=== Section 4: GlobalKey Capabilities ===');

  final capabilities = <Map<String, dynamic>>[
    {
      'name': 'currentState',
      'type': 'T? (State)',
      'icon': Icons.memory,
      'color': Colors.orange[700]!,
      'bgColor': Colors.orange[50]!,
      'description': 'Access the State object of the widget this key '
          'is attached to. Returns null if the widget has no State '
          '(StatelessWidget) or isn\'t mounted. Example: '
          'myKey.currentState?.doSomething().',
    },
    {
      'name': 'currentContext',
      'type': 'BuildContext?',
      'icon': Icons.web,
      'color': Colors.amber[700]!,
      'bgColor': Colors.amber[50]!,
      'description': 'Access the BuildContext of the widget. Useful '
          'for finding the widget\'s position (via RenderBox), '
          'showing overlays, or accessing inherited widgets from '
          'outside the subtree.',
    },
    {
      'name': 'currentWidget',
      'type': 'Widget?',
      'icon': Icons.widgets,
      'color': Colors.orange[600]!,
      'bgColor': Colors.orange[50]!,
      'description': 'Access the Widget instance itself. Rarely '
          'needed — usually you have the widget already. Mainly '
          'useful for debugging or framework-level code.',
    },
    {
      'name': 'Widget Reparenting',
      'type': 'behavior',
      'icon': Icons.swap_horiz,
      'color': Colors.amber[600]!,
      'bgColor': Colors.amber[50]!,
      'description': 'When a widget with a GlobalKey moves from one '
          'parent to another in the same frame, the framework '
          'preserves its Element and State. The widget is "reparented" '
          'rather than destroyed and recreated.',
    },
  ];

  print('  Prepared ${capabilities.length} capabilities');

  // ============================================================
  // SECTION 5: Key Comparison Table
  // ============================================================
  print('=== Section 5: Key Comparison ===');

  final keyComparison = <Map<String, String>>[
    {
      'aspect': 'Scope',
      'valueKey': 'Local (siblings)',
      'objectKey': 'Local (siblings)',
      'globalKey': 'Global (entire tree)',
      'globalObjKey': 'Global (entire tree)',
    },
    {
      'aspect': 'Equality',
      'valueKey': 'Value (operator==)',
      'objectKey': 'Identity (identical)',
      'globalKey': 'Identity (always unique)',
      'globalObjKey': 'Wrapped object\'s ==',
    },
    {
      'aspect': 'State Access',
      'valueKey': 'No',
      'objectKey': 'No',
      'globalKey': 'Yes (.currentState)',
      'globalObjKey': 'Yes (.currentState)',
    },
    {
      'aspect': 'Reparenting',
      'valueKey': 'No',
      'objectKey': 'No',
      'globalKey': 'Yes',
      'globalObjKey': 'Yes',
    },
    {
      'aspect': 'Performance',
      'valueKey': 'Cheapest',
      'objectKey': 'Cheap',
      'globalKey': 'Expensive',
      'globalObjKey': 'Expensive',
    },
    {
      'aspect': 'Best For',
      'valueKey': 'Lists, enums, IDs',
      'objectKey': 'Object instances',
      'globalKey': 'Accessing state remotely',
      'globalObjKey': 'Object-based global keys',
    },
  ];

  print('  Prepared ${keyComparison.length} comparison rows');

  // ============================================================
  // SECTION 6: Usage Patterns
  // ============================================================
  print('=== Section 6: Usage Patterns ===');

  final usagePatterns = <Map<String, dynamic>>[
    {
      'name': 'Accessing Remote State',
      'icon': Icons.memory,
      'color': Colors.orange[700]!,
      'code': 'final key = GlobalObjectKey<FormState>(myFormModel);\n'
          '\n'
          '// In widget tree:\n'
          'Form(key: key, child: ...);\n'
          '\n'
          '// From outside:\n'
          'key.currentState?.validate();\n'
          'key.currentState?.save();',
      'description': 'Derive a GlobalKey from a form model object. '
          'Use it to access FormState from a parent widget or '
          'sibling. The key stays consistent as long as the model '
          'object is the same instance.',
    },
    {
      'name': 'Widget Reparenting',
      'icon': Icons.swap_horiz,
      'color': Colors.amber[700]!,
      'code': 'final itemKey = GlobalObjectKey(item);\n'
          '\n'
          '// Before: in list A\n'
          'ListA(children: [MyWidget(key: itemKey)]);\n'
          '\n'
          '// After: moved to list B (same frame)\n'
          'ListB(children: [MyWidget(key: itemKey)]);',
      'description': 'When a widget with a GlobalObjectKey moves from '
          'one parent to another, the framework reparents it — '
          'the State is preserved, animations continue, text '
          'fields keep their content.',
    },
    {
      'name': 'Data-Driven Keys',
      'icon': Icons.data_object,
      'color': Colors.orange[600]!,
      'code': 'class TodoItem { ... }\n'
          '\n'
          'final todos = [TodoItem(...), TodoItem(...)]; \n'
          '\n'
          'todos.map((todo) => Card(\n'
          '  key: GlobalObjectKey(todo),\n'
          '  child: TodoTile(todo: todo),\n'
          '))',
      'description': 'Each data model object becomes a unique global '
          'key. This preserves widget state when the list is '
          'reordered. Note: only needed if you require GlobalKey '
          'features (state access, reparenting). For simple lists, '
          'prefer ValueKey(todo.id).',
    },
  ];

  print('  Prepared ${usagePatterns.length} usage patterns');

  // ============================================================
  // SECTION 7: Common Mistakes
  // ============================================================
  print('=== Section 7: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Creating New Objects in build()',
      'icon': Icons.error,
      'color': Colors.red[600]!,
      'bad': 'GlobalObjectKey(SomeClass())  // New instance each build!',
      'good': 'GlobalObjectKey(stableReference)  // Same instance',
      'explanation': 'If you create a new object in build(), the key '
          'changes every rebuild. The framework treats this as "old '
          'widget removed, new widget created" — all state is lost.',
    },
    {
      'title': 'Using Primitives Without Thought',
      'icon': Icons.warning,
      'color': Colors.orange[700]!,
      'bad': 'GlobalObjectKey(42)  // Relies on int interning',
      'good': 'ValueKey(42)  // or GlobalKey with a label',
      'explanation': 'Dart\'s small integer interning makes this work '
          'by accident, but it\'s fragile. For primitive values, '
          'use ValueKey instead. GlobalObjectKey is designed for '
          'object references.',
    },
    {
      'title': 'Duplicate Keys in Tree',
      'icon': Icons.copy,
      'color': Colors.red[700]!,
      'bad': 'Two widgets with GlobalObjectKey(sameObj) at once',
      'good': 'One widget per GlobalObjectKey at any time',
      'explanation': 'GlobalKeys must be unique across the tree. Two '
          'widgets with the same GlobalObjectKey triggers a runtime '
          'error: "Multiple widgets used the same GlobalKey".',
    },
    {
      'title': 'Overusing GlobalKey',
      'icon': Icons.warning_amber,
      'color': Colors.orange[600]!,
      'bad': 'GlobalObjectKey on every list item "just in case"',
      'good': 'ValueKey(item.id) for simple list identity',
      'explanation': 'GlobalKeys have overhead — the framework tracks '
          'them globally. Use them only when you need state access '
          'or reparenting. For simple list diffing, LocalKeys '
          'are sufficient and much cheaper.',
    },
  ];

  print('  Prepared ${mistakes.length} common mistakes');

  // ============================================================
  // SECTION 8: When to Use Which Key
  // ============================================================
  print('=== Section 8: Decision Guide ===');

  final decisionGuide = <Map<String, dynamic>>[
    {
      'question': 'Do I need to access State from outside?',
      'answer': 'Yes → GlobalKey or GlobalObjectKey',
      'icon': Icons.memory,
      'color': Colors.orange[700]!,
    },
    {
      'question': 'Do I have a stable object reference to key on?',
      'answer': 'Yes → GlobalObjectKey(myObject)',
      'icon': Icons.data_object,
      'color': Colors.amber[700]!,
    },
    {
      'question': 'Do I just need list item diffing?',
      'answer': 'Yes → ValueKey(item.id) or ObjectKey(item)',
      'icon': Icons.list,
      'color': Colors.orange[600]!,
    },
    {
      'question': 'Do I need the widget to survive reparenting?',
      'answer': 'Yes → GlobalKey (any variant)',
      'icon': Icons.swap_horiz,
      'color': Colors.amber[600]!,
    },
    {
      'question': 'Do I need a unique key for animations?',
      'answer': 'Usually → UniqueKey() or ValueKey',
      'icon': Icons.animation,
      'color': Colors.orange[500]!,
    },
    {
      'question': 'Am I unsure?',
      'answer': 'Start with ValueKey. Upgrade only if needed.',
      'icon': Icons.help,
      'color': Colors.amber[500]!,
    },
  ];

  print('  Prepared ${decisionGuide.length} decision items');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'GlobalKeys Are Expensive',
      'body': 'The framework maintains a global registry of all '
          'GlobalKeys. Every frame, it checks for duplicates and '
          'handles reparenting. Use only when LocalKey is '
          'insufficient.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'GlobalObjectKey Uses ==, Not identical()',
      'body': 'Despite the name "Object Key", GlobalObjectKey uses '
          'the value\'s operator== for comparison, NOT identical(). '
          'If your class overrides ==, two different instances with '
          'the same value will produce equal GlobalObjectKeys.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Store Keys in State, Not build()',
      'body': 'Create GlobalObjectKey instances in initState or as '
          'final fields, not in build(). This ensures the key '
          'reference stays stable across rebuilds. Recreating '
          'in build() defeats the purpose.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Reparenting Happens in Same Frame',
      'body': 'Widget reparenting only works when the old parent '
          'removes and the new parent adds the widget in the SAME '
          'build frame. If there\'s a frame gap, the widget is '
          'disposed and recreated — state is lost.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Type Parameter Matters',
      'body': 'GlobalObjectKey<FormState>(obj) lets you type-safely '
          'access the state: key.currentState returns FormState?. '
          'Without the type parameter, you get State<StatefulWidget>? '
          'which requires casting.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Debug with debugDoingBuild',
      'body': 'If you see "Multiple widgets used the same '
          'GlobalKey" errors, check that your keyed widgets aren\'t '
          'being built in two places simultaneously. The error '
          'message includes the offending widgets.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('GlobalObjectKey'),
      backgroundColor: Colors.orange[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[700]!, Colors.amber[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.vpn_key, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'GlobalObjectKey',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A GlobalKey whose identity is derived from an '
                  'object reference — enables state access and '
                  'widget reparenting keyed to your data models.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _keyHead('1', 'What is GlobalObjectKey?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Key Hierarchy ──
          _keyHead('2', 'Key Type Hierarchy'),
          SizedBox(height: 12),
          ...keyTypes.map((kt) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (kt['depth'] as int) * 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kt['name'] == 'GlobalObjectKey<T>'
                          ? Colors.orange[50]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                            color: kt['color'] as Color, width: 4),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(kt['icon'] as IconData,
                              color: kt['color'] as Color, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(kt['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                    color: kt['color'] as Color)),
                          ),
                          if (kt['name'] == 'GlobalObjectKey<T>')
                            _keyTag('THIS DEMO', Colors.orange[700]!),
                        ]),
                        SizedBox(height: 4),
                        Text(kt['description'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.3)),
                      ],
                    ),
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Identity vs Equality ──
          _keyHead('3', 'Identity vs Equality'),
          SizedBox(height: 12),
          ...identityExamples.map((ex) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ex['icon'] as IconData,
                            color: ex['resultColor'] as Color,
                            size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ex['scenario'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: ex['resultColor'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(ex['result'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(ex['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(ex['explanation'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: GlobalKey Capabilities ──
          _keyHead('4', 'GlobalKey Capabilities'),
          SizedBox(height: 12),
          ...capabilities.map((cap) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cap['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (cap['color'] as Color).withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: cap['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(cap['icon'] as IconData,
                              color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('.${cap['name']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: cap['color'] as Color)),
                              Text(cap['type'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(cap['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Key Comparison Table ──
          _keyHead('5', 'Key Type Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('ValueKey',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('ObjectKey',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('GlobalKey',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('G.ObjKey',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...keyComparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text(row['valueKey']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 2,
                          child: Text(row['objectKey']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 2,
                          child: Text(row['globalKey']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 2,
                          child: Text(row['globalObjKey']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold,
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Usage Patterns ──
          _keyHead('6', 'Usage Patterns'),
          SizedBox(height: 12),
          ...usagePatterns.map((up) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: up['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(up['icon'] as IconData,
                            color: up['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(up['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              (up['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(up['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(up['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Common Mistakes ──
          _keyHead('7', 'Common Mistakes'),
          SizedBox(height: 12),
          ...mistakes.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(children: [
                          Text('BAD: ',
                              style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(m['bad'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: Colors.red[700])),
                          ),
                        ]),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(children: [
                          Text('GOOD: ',
                              style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(m['good'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: Colors.green[700])),
                          ),
                        ]),
                      ),
                      SizedBox(height: 8),
                      Text(m['explanation'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Decision Guide ──
          _keyHead('8', 'When to Use Which Key'),
          SizedBox(height: 12),
          ...decisionGuide.map((dg) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: dg['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(dg['icon'] as IconData,
                          color: dg['color'] as Color, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dg['question'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 2),
                            Text(dg['answer'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: dg['color'] as Color,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _keyHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of GlobalObjectKey Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _keyHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small label tag
// ──────────────────────────────────────────────────────────
Widget _keyTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
