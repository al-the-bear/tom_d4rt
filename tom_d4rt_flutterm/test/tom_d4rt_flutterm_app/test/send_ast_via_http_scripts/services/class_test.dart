// ignore_for_file: avoid_print
// Deep demo: Class (Type system)
// Demonstrates Dart's runtime Type objects, runtimeType property,
// the is/is! operators, and how class identity works at runtime in
// the context of Flutter services and widget introspection.
import 'package:flutter/material.dart';

// ─── palette: Copper / Cream ──────────────────────────────────────
const Color _clCopper = Color(0xFFBF5B04);
const Color _clCream = Color(0xFFFFF3E0);
const Color _clAccent = Color(0xFFE65100);
const Color _clDark = Color(0xFF1A1A1A);
const Color _clBlue = Color(0xFF1565C0);
const Color _clGreen = Color(0xFF2E7D32);
const Color _clPurple = Color(0xFF6A1B9A);
const Color _clTeal = Color(0xFF00695C);
const Color _clRed = Color(0xFFC62828);

// ─── text helpers ─────────────────────────────────────────────────
Widget _clTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _clCopper,
              letterSpacing: 0.3)),
    );

Widget _clSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _clAccent)),
    );

Widget _clBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _clCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _clDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFFFCC80),
              height: 1.5)),
    );

Widget _clNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _clCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _clCopper.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.class_outlined, size: 16, color: _clCopper),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _clCopper, height: 1.4)),
          ),
        ],
      ),
    );

Widget _clDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _clCopper.withValues(alpha: 0.1)),
    );

Widget _clTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _clLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _clCopper,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _clBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_clCopper, Color(0xFFE65100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.account_tree_outlined, size: 48, color: _clCream),
          const SizedBox(height: 10),
          const Text('Class & Type System',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Runtime class identity and type introspection in Dart',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _clTag('services', _clAccent),
              _clTag('type system', _clBlue),
              _clTag('runtime', _clPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _clWhatIs() => [
      _clTitle('§2  What Is a Class at Runtime?'),
      _clBody(
          'In Dart, every object knows its class at runtime through the '
          'runtimeType property. The Type object returned represents the '
          'runtime class of the instance. This is the foundation of '
          'runtime type checking, reflection, and service registration.'),
      _clCode(
          '// Every Dart object has a runtimeType:\n'
          'final widget = Text(\'Hello\');\n'
          'print(widget.runtimeType); // Text\n'
          '\n'
          '// Type literals are compile-time class references:\n'
          'Type t = String;\n'
          'print(t); // String\n'
          '\n'
          '// The is operator checks class membership:\n'
          'print(widget is Widget);       // true\n'
          'print(widget is StatelessWidget); // true\n'
          'print(widget is StatefulWidget);  // false'),
      _clNote(
          'Dart does not support full reflection by default. The Type object '
          'provides identity only — you cannot inspect fields or methods '
          'without dart:mirrors or code generation.'),
    ];

// ─── §3 runtimeType ──────────────────────────────────────────────
List<Widget> _clRuntimeType() => [
      _clDivider(),
      _clTitle('§3  runtimeType Property'),
      _clBody(
          'The runtimeType getter is defined on Object and returns a Type '
          'that identifies the most specific class of the instance:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _clTypeRow('42', 'int', _clCopper),
            _clTypeRow("'hello'", 'String', _clBlue),
            _clTypeRow('[1, 2, 3]', 'List<int>', _clGreen),
            _clTypeRow('Text("Hi")', 'Text', _clPurple),
            _clTypeRow('Container()', 'Container', _clTeal),
            _clTypeRow('Scaffold()', 'Scaffold', _clRed),
          ],
        ),
      ),
      _clCode(
          '// runtimeType returns the exact class:\n'
          'Widget w = const Text(\'Hello\');\n'
          'print(w.runtimeType); // Text (not Widget)\n'
          '\n'
          '// For generic types, type arguments are preserved:\n'
          'List<int> nums = [1, 2, 3];\n'
          'print(nums.runtimeType); // List<int>'),
      _clSubtitle('Overriding runtimeType'),
      _clBody(
          'Some Flutter classes override runtimeType for diagnostic '
          'purposes. For example, widget classes may add additional '
          'info in debug mode:'),
      _clCode(
          '// Some classes override for better diagnostics:\n'
          '@override\n'
          'Type get runtimeType {\n'
          '  // Custom diagnostic information in debug\n'
          '  return super.runtimeType;\n'
          '}'),
    ];

Widget _clTypeRow(String expr, String type, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(expr,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: c,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(type,
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
        ],
      ),
    );

// ─── §4 Type checking ────────────────────────────────────────────
List<Widget> _clTypeCheck() => [
      _clDivider(),
      _clTitle('§4  Type Checking Operators'),
      _clBody(
          'Dart provides two operators for runtime type checking:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _clOpCard('is', 'Type Test',
                  'Returns true if the object is an instance of the '
                      'specified type (including supertypes)',
                  _clCopper),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _clOpCard('is!', 'Negated Test',
                  'Returns true if the object is NOT an instance of '
                      'the specified type',
                  _clRed),
            ),
          ],
        ),
      ),
      _clCode(
          '// is operator — checks class hierarchy:\n'
          'final btn = ElevatedButton(\n'
          '    onPressed: () {}, child: Text(\'OK\'));\n'
          'btn is ElevatedButton;  // true — exact match\n'
          'btn is ButtonStyleButton; // true — superclass\n'
          'btn is Widget;           // true — ancestor\n'
          'btn is Object;           // true — always\n'
          'btn is StatefulWidget;   // true\n'
          'btn is StatelessWidget;  // false\n'
          '\n'
          '// is! operator — negation:\n'
          'btn is! Icon;            // true\n'
          'btn is! Widget;          // false'),
      _clSubtitle('Type promotion'),
      _clBody(
          'The is operator also promotes the variable\'s type within '
          'the scope, enabling safe member access:'),
      _clCode(
          'void processWidget(Widget w) {\n'
          '  if (w is Text) {\n'
          '    // w is promoted to Text here\n'
          '    print(w.data); // safe access\n'
          '  }\n'
          '  if (w is Container) {\n'
          '    // w is promoted to Container\n'
          '    print(w.padding); // safe access\n'
          '  }\n'
          '}'),
    ];

Widget _clOpCard(String op, String name, String desc, Color c) =>
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(op,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'monospace')),
            ),
          ),
          const SizedBox(height: 8),
          Text(name,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: c)),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10.5,
                  color: Colors.black54,
                  height: 1.4)),
        ],
      ),
    );

// ─── §5 Generic types ────────────────────────────────────────────
List<Widget> _clGenerics() => [
      _clDivider(),
      _clTitle('§5  Generic Type Identity'),
      _clBody(
          'Dart preserves generic type arguments at runtime, unlike '
          'some other languages (Java\'s type erasure). This means '
          'List<int> and List<String> are different types:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _clLabel('Reified generics in Dart'),
            const SizedBox(height: 10),
            _clGenRow('List<int>', 'List<int>', true, _clCopper),
            _clGenRow('List<int>', 'List<String>', false, _clRed),
            _clGenRow('List<int>', 'List<dynamic>', false, _clRed),
            _clGenRow('Map<String, int>', 'Map<String, int>', true,
                _clGreen),
            _clGenRow('Future<String>', 'Future<String>', true, _clBlue),
            _clGenRow('Future<String>', 'Future<int>', false, _clRed),
          ],
        ),
      ),
      _clCode(
          '// Reified generics — full type info at runtime:\n'
          'final a = <int>[1, 2];\n'
          'final b = <String>[\'x\'];\n'
          'print(a.runtimeType == b.runtimeType); // false\n'
          'print(a is List<int>);    // true\n'
          'print(a is List<String>); // false\n'
          'print(a is List);         // true (raw type)'),
    ];

Widget _clGenRow(
    String typeA, String typeB, bool match, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _clCopper.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(typeA,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: _clCopper,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(match ? '==' : '!=',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: c)),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(typeB,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: c,
                    fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          Icon(match ? Icons.check : Icons.close,
              size: 14, color: c),
        ],
      ),
    );

// ─── §6 Class hierarchy ──────────────────────────────────────────
List<Widget> _clClassHier() => [
      _clDivider(),
      _clTitle('§6  Class Hierarchy Walk'),
      _clBody(
          'Every Dart object sits in a class hierarchy rooted at '
          'Object. The is operator traverses this entire chain:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _clHierNode(0, 'Object', 'Root of all Dart classes', _clCopper),
            _clHierNode(1, 'DiagnosticableTree', 'Debug printing',
                _clBlue),
            _clHierNode(2, 'Widget', 'Immutable UI description',
                _clGreen),
            _clHierNode(3, 'StatelessWidget', 'No mutable state',
                _clPurple),
            _clHierNode(4, 'Text', 'Displays a string', _clTeal),
          ],
        ),
      ),
      _clCode(
          '// A Text widget is all of these:\n'
          'final t = Text(\'Hello\');\n'
          't is Text;               // true\n'
          't is StatelessWidget;    // true\n'
          't is Widget;             // true\n'
          't is DiagnosticableTree; // true\n'
          't is Object;             // true\n'
          '\n'
          '// But runtimeType returns the most specific:\n'
          't.runtimeType;           // Text'),
    ];

Widget _clHierNode(int depth, String name, String desc, Color c) =>
    Padding(
      padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §7 Type as service key ──────────────────────────────────────
List<Widget> _clServiceKey() => [
      _clDivider(),
      _clTitle('§7  Type as Service Key'),
      _clBody(
          'A common pattern in Flutter services is using Type objects '
          'as keys in registries. Service locators, InheritedWidget '
          'lookup, and provider patterns all use class identity:'),
      _clCode(
          '// InheritedWidget uses Type for lookup:\n'
          '// Theme.of(context) is equivalent to:\n'
          '//   context.dependOnInheritedWidgetOfExactType<Theme>()\n'
          '\n'
          '// Service locator pattern:\n'
          'class ServiceRegistry {\n'
          '  final _services = <Type, Object>{};\n'
          '\n'
          '  void register<T extends Object>(T service) {\n'
          '    _services[T] = service;\n'
          '  }\n'
          '\n'
          '  T locate<T extends Object>() {\n'
          '    return _services[T]! as T;\n'
          '  }\n'
          '}'),
      _clSubtitle('Flutter framework usage'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _clUsageRow('Theme.of(context)', 'Type lookup on ThemeData',
                _clCopper),
            _clUsageRow('MediaQuery.of(context)',
                'Type lookup on MediaQueryData', _clBlue),
            _clUsageRow('Provider.of<T>(context)',
                'Generic type as registry key', _clGreen),
            _clUsageRow('GetIt.I.get<T>()',
                'Service locator using Type', _clPurple),
          ],
        ),
      ),
    ];

Widget _clUsageRow(String api, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 28,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(api,
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: c,
                        fontFamily: 'monospace')),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §8 Mixins and interfaces ────────────────────────────────────
List<Widget> _clMixins() => [
      _clDivider(),
      _clTitle('§8  Mixins & Interfaces'),
      _clBody(
          'Dart classes can implement multiple interfaces and apply '
          'multiple mixins. The is operator checks all of them:'),
      _clCode(
          'mixin Printable {\n'
          '  String toPrintString();\n'
          '}\n'
          '\n'
          'abstract class Describable {\n'
          '  String describe();\n'
          '}\n'
          '\n'
          'class MyWidget extends StatelessWidget\n'
          '    with Printable\n'
          '    implements Describable {\n'
          '  @override\n'
          '  Widget build(BuildContext c) => Text(\'hi\');\n'
          '  @override\n'
          '  String toPrintString() => \'MyWidget\';\n'
          '  @override\n'
          '  String describe() => \'A custom widget\';\n'
          '}\n'
          '\n'
          '// All of these are true:\n'
          'final w = MyWidget();\n'
          'w is MyWidget;        // true\n'
          'w is StatelessWidget; // true\n'
          'w is Printable;       // true\n'
          'w is Describable;     // true'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _clLabel('Type relationships'),
            const SizedBox(height: 8),
            _clRelRow('extends', 'Single inheritance',
                'Only one superclass', _clCopper),
            _clRelRow('implements', 'Interface',
                'Multiple allowed, must override all', _clBlue),
            _clRelRow('with', 'Mixin',
                'Multiple allowed, provides implementations', _clGreen),
            _clRelRow('on', 'Mixin constraint',
                'Restricts which classes can apply mixin', _clPurple),
          ],
        ),
      ),
    ];

Widget _clRelRow(String keyword, String kind, String desc, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 70,
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(keyword,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'monospace')),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kind,
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §9 toString and diagnostics ─────────────────────────────────
List<Widget> _clDiagnostics() => [
      _clDivider(),
      _clTitle('§9  toString & Diagnostics'),
      _clBody(
          'Type.toString() returns the class name as a string. Flutter '
          'uses this extensively in error messages and diagnostics:'),
      _clCode(
          '// Type.toString() gives the class name:\n'
          'print(String);       // "String"\n'
          'print(List<int>);    // "List<int>"\n'
          'print(Text);         // "Text"\n'
          '\n'
          '// Flutter uses it in errors:\n'
          '// "A RenderFlex overflowed by 42 pixels"\n'
          '//  ^^^^^^^^^^^^ from runtimeType.toString()'),
      _clSubtitle('Diagnostics tree'),
      _clBody(
          'Flutter widgets extend DiagnosticableTree, which uses '
          'runtimeType for debug output:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _clCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _clLabel('Widget debug output'),
            const SizedBox(height: 8),
            const Text(
              'Text("Hello")\n'
              '  data: "Hello"\n'
              '  textAlign: null\n'
              '  maxLines: null\n'
              'Container\n'
              '  padding: EdgeInsets.all(8.0)\n'
              '  child: Text("World")',
              style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: Colors.black54,
                  height: 1.5),
            ),
          ],
        ),
      ),
    ];

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _clSummary() => [
      _clDivider(),
      _clTitle('§10  Summary'),
      _clBody(
          'Dart\'s runtime type system provides class identity, '
          'type checking, and generic type preservation — all crucial '
          'for Flutter\'s service layer and widget framework.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_clCopper.withValues(alpha: 0.07), _clCream],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _clCopper.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _clCopper)),
            const SizedBox(height: 10),
            _clSumPt('runtimeType',
                'Returns the most specific class of an instance'),
            _clSumPt('is / is!',
                'Check class membership across the hierarchy'),
            _clSumPt('Reified generics',
                'List<int> and List<String> are distinct types'),
            _clSumPt('Type promotion',
                'is operator narrows the type for safe access'),
            _clSumPt('Service keys',
                'Type objects serve as keys in registries'),
            _clSumPt('Diagnostics',
                'runtimeType powers Flutter error messages'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _clCopper,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of Class & Type System Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _clSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _clAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _clCopper)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _clBanner(),
        const SizedBox(height: 20),
        ..._clWhatIs(),
        ..._clRuntimeType(),
        ..._clTypeCheck(),
        ..._clGenerics(),
        ..._clClassHier(),
        ..._clServiceKey(),
        ..._clMixins(),
        ..._clDiagnostics(),
        ..._clSummary(),
      ],
    ),
  );
}
