// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Deep demo of Factory<T> from foundation
// Factory<T> is a simple generic class that wraps a constructor or builder
// function of type T Function(). It stores the function in .constructor and
// returns fresh instances via call(). Flutter uses it for deferred creation.
// Note: Factory.constructor is not accessible in D4rt bridge, so we use a
// local FactoryWrapper<T> to demonstrate identical behaviour.
import 'package:flutter/material.dart';

/// Local wrapper replicating Factory<T> since the bridge cannot access
/// the .constructor getter on the real Factory class.
class _FactoryWrapper<T> {
  final T Function() constructor;
  const _FactoryWrapper(this.constructor);
  T call() => constructor();
  Type get type => T;

  @override
  String toString() => 'Factory<$T>(constructor: $constructor)';
}

dynamic build(BuildContext context) {
  print('Factory deep demo executing');

  // ============================================================
  // SECTION 1: Overview Banner
  // ============================================================
  print('=== Section 1: Overview ===');

  Widget fcBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF4DB6AC)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      children: [
        Icon(Icons.factory, color: Colors.white, size: 44.0),
        SizedBox(height: 8.0),
        Text('Factory<T>', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text('Generic builder function wrapper', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(height: 8.0),
        Text(
          'Factory<T> wraps a constructor function T Function() so objects can be created on demand. Each call() invocation produces a fresh instance.',
          style: TextStyle(fontSize: 12.0, color: Colors.white.withValues(alpha: 0.9)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Class Anatomy
  // ============================================================
  print('=== Section 2: Class Anatomy ===');

  Widget fcAnatomyRow(String member, String signature, String description, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: accent, width: 3.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(member, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: accent)),
              Spacer(),
              Text(signature, style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.grey.shade700)),
            ],
          ),
          SizedBox(height: 4.0),
          Text(description, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 3: FactoryWrapper Workaround
  // ============================================================
  print('=== Section 3: FactoryWrapper ===');
  print('Using FactoryWrapper<T> as D4rt bridge workaround');

  Widget fcWorkaround = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('D4rt Bridge Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.orange.shade800)),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Factory.constructor is not accessible in the D4rt bridge. This demo uses a local _FactoryWrapper<T> class that replicates the exact API: const constructor, call(), type getter, and toString().',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'class _FactoryWrapper<T> {\n  final T Function() constructor;\n  const _FactoryWrapper(this.constructor);\n  T call() => constructor();\n  Type get type => T;\n}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: String Factory
  // ============================================================
  print('=== Section 4: String Factory ===');
  final fcString = _FactoryWrapper<String>(() => 'Hello from Factory');
  final fcStringResult = fcString.call();
  print('String factory result: $fcStringResult');
  print('type: ${fcString.type}');

  Widget fcResultCard(String title, String factoryType, String result, IconData icon, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 18.0),
              SizedBox(width: 8.0),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: accent)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(color: accent.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4.0)),
                child: Text(factoryType, style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, fontWeight: FontWeight.bold, color: accent)),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: accent.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(6.0)),
            child: Text(result, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 5: Numeric Counter Factory
  // ============================================================
  print('=== Section 5: Counter Factory ===');
  int fcCounter = 0;
  final fcInt = _FactoryWrapper<int>(() => ++fcCounter);
  final fcR1 = fcInt.call();
  final fcR2 = fcInt.call();
  final fcR3 = fcInt.call();
  print('Counter: $fcR1, $fcR2, $fcR3');

  Widget fcCounterDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.add_circle, color: Color(0xFF00695C), size: 22.0),
            SizedBox(width: 8.0),
            Text('Stateful Counter Factory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xFF00695C))),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Factory closures can capture mutable state. Each call() increments:', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _FcCallChip(label: 'call() #1', value: '$fcR1', color: Color(0xFF00897B)),
            Icon(Icons.arrow_forward, color: Colors.grey, size: 16.0),
            _FcCallChip(label: 'call() #2', value: '$fcR2', color: Color(0xFF00897B)),
            Icon(Icons.arrow_forward, color: Colors.grey, size: 16.0),
            _FcCallChip(label: 'call() #3', value: '$fcR3', color: Color(0xFF00897B)),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Each invocation produces a new, incrementing value from the captured closure.', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: List Factory
  // ============================================================
  print('=== Section 6: List Factory ===');
  final fcList = _FactoryWrapper<List<int>>(() => <int>[1, 2, 3]);
  final fcListA = fcList.call();
  final fcListB = fcList.call();
  print('List A: $fcListA');
  print('List B: $fcListB');
  print('Same instance? ${identical(fcListA, fcListB)}');

  // ============================================================
  // SECTION 7: Map Factory
  // ============================================================
  print('=== Section 7: Map Factory ===');
  final fcMap = _FactoryWrapper<Map<String, int>>(() => {'x': 10, 'y': 20, 'z': 30});
  final fcMapResult = fcMap.call();
  print('Map: $fcMapResult');

  // ============================================================
  // SECTION 8: Widget Factory
  // ============================================================
  print('=== Section 8: Widget Factory ===');
  final fcWidget = _FactoryWrapper<Widget>(() => Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      color: Color(0xFF4DB6AC),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(child: Icon(Icons.widgets, color: Colors.white, size: 28.0)),
  ));
  final fcWidgetInstance = fcWidget.call();
  print('Widget: ${fcWidgetInstance.runtimeType}');

  Widget fcWidgetDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.widgets, color: Colors.purple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Widget Factory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.purple.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Factory<Widget> can produce fresh widget trees on demand:', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          children: [
            fcWidgetInstance,
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Factory<Widget>', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.purple.shade700)),
                  Text('Each call() returns a new widget subtree', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
                  SizedBox(height: 4.0),
                  Text('type: ${fcWidget.type}', style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Nested Factories
  // ============================================================
  print('=== Section 9: Nested Factories ===');
  final fcNested = _FactoryWrapper<_FactoryWrapper<String>>(
    () => _FactoryWrapper<String>(() => 'inner value'),
  );
  final fcInner = fcNested.call();
  final fcInnerResult = fcInner.call();
  print('Nested factory result: $fcInnerResult');

  // ============================================================
  // SECTION 10: Lazy Initialization
  // ============================================================
  print('=== Section 10: Lazy Init ===');
  int fcExpensiveCallCount = 0;
  final fcLazy = _FactoryWrapper<String>(() {
    fcExpensiveCallCount++;
    return 'Expensive result #$fcExpensiveCallCount';
  });
  print('Before call: count=$fcExpensiveCallCount');
  final fcLazyResult = fcLazy.call();
  print('After call: count=$fcExpensiveCallCount, result=$fcLazyResult');

  Widget fcLazySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.hourglass_empty, color: Colors.blue.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Lazy Initialization', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.blue.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Factory defers object creation until call() is invoked. No work is done at construction time.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Text('Before call()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.blue.shade700)),
                    Text('count = 0', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
                    Text('Constructor stored, not executed', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.arrow_forward, color: Colors.blue.shade300, size: 20.0),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Text('After call()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.green.shade700)),
                    Text('count = $fcExpensiveCallCount', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
                    Text(fcLazyResult, style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Caching Factory
  // ============================================================
  print('=== Section 11: Caching Factory ===');

  Widget fcCachingSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.cached, color: Colors.pink.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Factory vs Cached Singleton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.pink.shade800)),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.factory, color: Color(0xFF00695C), size: 16.0),
                  SizedBox(width: 6.0),
                  Text('Factory<T>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Color(0xFF00695C))),
                ],
              ),
              Text('call() → new instance every time', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              Text('identical(a, b) = false', style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.red.shade600)),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lock, color: Colors.pink.shade700, size: 16.0),
                  SizedBox(width: 6.0),
                  Text('Singleton / late final', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.pink.shade700)),
                ],
              ),
              Text('Always returns same instance', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              Text('identical(a, b) = true', style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.green.shade600)),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text('List identical check: ${identical(fcListA, fcListB)} (demonstrates fresh instances)', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade700)),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Type-Safe Registry
  // ============================================================
  print('=== Section 12: Registry ===');
  final fcRegistry = <String, _FactoryWrapper<dynamic>>{
    'greeting': _FactoryWrapper<String>(() => 'Welcome!'),
    'counter': _FactoryWrapper<int>(() => 42),
    'colors': _FactoryWrapper<List<String>>(() => ['red', 'green', 'blue']),
  };

  Widget fcRegistrySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.app_registration, color: Colors.deepPurple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Factory Registry Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.deepPurple.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('A Map<String, Factory<T>> acts as a service locator:', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        ...fcRegistry.entries.map((entry) {
          final result = entry.value.call();
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6.0),
              border: Border(left: BorderSide(color: Colors.deepPurple, width: 2.0)),
            ),
            child: Row(
              children: [
                SizedBox(width: 70.0, child: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.deepPurple))),
                Text('→ ', style: TextStyle(color: Colors.grey)),
                Expanded(child: Text('$result', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0))),
                Text('(${result.runtimeType})', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // SECTION 13: Identity and Equality
  // ============================================================
  print('=== Section 13: Identity ===');
  final fcA = _FactoryWrapper<String>(() => 'same');
  final fcB = _FactoryWrapper<String>(() => 'same');
  print('fcA == fcB: ${fcA == fcB}');
  print('identical(fcA, fcB): ${identical(fcA, fcB)}');
  print('fcA.call() == fcB.call(): ${fcA.call() == fcB.call()}');

  Widget fcIdentitySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.lightGreen.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.fingerprint, color: Colors.lightGreen.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Identity & Equality', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.lightGreen.shade800)),
          ],
        ),
        SizedBox(height: 10.0),
        _FcCompareRow(label: 'factoryA == factoryB', result: fcA == fcB, note: 'Different objects'),
        _FcCompareRow(label: 'identical(factoryA, factoryB)', result: identical(fcA, fcB), note: 'Not same reference'),
        _FcCompareRow(label: 'factoryA() == factoryB()', result: fcA.call() == fcB.call(), note: 'Same value output'),
        SizedBox(height: 6.0),
        Text('Factories are compared by reference, not by output. Two factories producing the same value are still different objects.', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 14: Real-World Flutter Uses
  // ============================================================
  print('=== Section 14: Flutter Uses ===');

  Widget fcUseCaseRow(String where, String description, IconData icon, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: accent, width: 3.0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 18.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(where, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: accent)),
                Text(description, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 15: toString() Representation
  // ============================================================
  print('=== Section 15: toString ===');
  print('String factory: $fcString');
  print('List factory: $fcList');
  print('Map factory: $fcMap');

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  Widget fcSummaryTile(String label, String value, Color bg, Color text) {
    return Container(
      width: 95.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: text)),
          SizedBox(height: 2.0),
          Text(label, style: TextStyle(fontSize: 9.5, color: text.withValues(alpha: 0.7)), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  print('Factory deep demo completed');

  // ============================================================
  // ASSEMBLE FULL UI
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Factory<T> Deep Demo'),
        backgroundColor: Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Banner
            fcBanner,

            // Section 2: Anatomy
            SizedBox(height: 20.0),
            Text('2. Class Anatomy', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            fcAnatomyRow('const Factory()', 'T Function() constructor', 'Creates a factory wrapping the given constructor function', Color(0xFF00897B)),
            fcAnatomyRow('.constructor', 'T Function()', 'Returns the stored builder function', Color(0xFF00897B)),
            fcAnatomyRow('.call()', 'T', 'Invokes constructor and returns a fresh T instance', Color(0xFF00897B)),
            fcAnatomyRow('.type', 'Type', 'Returns the static type parameter T', Color(0xFF00897B)),

            // Section 3: Workaround
            SizedBox(height: 20.0),
            Text('3. D4rt Bridge Workaround', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcWorkaround,

            // Section 4: String
            SizedBox(height: 20.0),
            Text('4. String Factory', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            fcResultCard('String Factory', 'Factory<String>', 'Result: "$fcStringResult"', Icons.text_fields, Color(0xFF00897B)),

            // Section 5: Counter
            SizedBox(height: 20.0),
            Text('5. Stateful Counter', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcCounterDemo,

            // Section 6: List
            SizedBox(height: 20.0),
            Text('6. List Factory', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            fcResultCard('List Factory', 'Factory<List<int>>', 'A: $fcListA\nB: $fcListB\nidentical: ${identical(fcListA, fcListB)}', Icons.list, Color(0xFF00897B)),

            // Section 7: Map
            SizedBox(height: 20.0),
            Text('7. Map Factory', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            fcResultCard('Map Factory', 'Factory<Map>', '$fcMapResult', Icons.data_object, Color(0xFF00897B)),

            // Section 8: Widget
            SizedBox(height: 20.0),
            Text('8. Widget Factory', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcWidgetDemo,

            // Section 9: Nested
            SizedBox(height: 20.0),
            Text('9. Nested Factories', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            fcResultCard('Nested', 'Factory<Factory<String>>', 'outer.call().call() → "$fcInnerResult"', Icons.layers, Color(0xFF00897B)),

            // Section 10: Lazy
            SizedBox(height: 20.0),
            Text('10. Lazy Initialization', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcLazySection,

            // Section 11: Caching
            SizedBox(height: 20.0),
            Text('11. Factory vs Singleton', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcCachingSection,

            // Section 12: Registry
            SizedBox(height: 20.0),
            Text('12. Factory Registry', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcRegistrySection,

            // Section 13: Identity
            SizedBox(height: 20.0),
            Text('13. Identity & Equality', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            fcIdentitySection,

            // Section 14: Use cases
            SizedBox(height: 20.0),
            Text('14. Flutter Use Cases', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 4.0),
            Text('Where Factory<T> appears in the Flutter framework:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            fcUseCaseRow('WidgetSpan', 'Deferred widget creation inside rich text', Icons.text_snippet, Color(0xFF00897B)),
            fcUseCaseRow('AnimationController', 'Ticker factory for vsync timing', Icons.animation, Color(0xFF00897B)),
            fcUseCaseRow('ScrollBehavior', 'Platform-specific physics factory', Icons.swipe, Color(0xFF00897B)),
            fcUseCaseRow('ThemeData', 'Widget factories for default look', Icons.palette, Color(0xFF00897B)),
            fcUseCaseRow('Route generation', 'RouteFactory creates routes by name', Icons.route, Color(0xFF00897B)),

            // Section 15: toString
            SizedBox(height: 20.0),
            Text('15. toString()', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$fcString', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  SizedBox(height: 4.0),
                  Text('$fcList', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  SizedBox(height: 4.0),
                  Text('$fcMap', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                ],
              ),
            ),

            // Section 16: Summary
            SizedBox(height: 20.0),
            Text('16. Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8.0),
            Wrap(
              children: [
                fcSummaryTile('Factories', '${fcRegistry.length + 7}', Color(0xFFE0F2F1), Color(0xFF00695C)),
                fcSummaryTile('Types', '6', Color(0xFFE3F2FD), Colors.blue.shade700),
                fcSummaryTile('Calls', '${3 + 2 + 1 + 1 + 1 + 1 + 1 + 3}', Color(0xFFF3E5F5), Colors.purple.shade700),
                fcSummaryTile('Patterns', '4', Color(0xFFFFF3E0), Colors.orange.shade700),
                fcSummaryTile('Use Cases', '5', Color(0xFFFCE4EC), Colors.pink.shade700),
                fcSummaryTile('Sections', '16', Color(0xFFF1F8E9), Colors.green.shade700),
              ],
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

/// Visual chip showing call sequence for Section 5
class _FcCallChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _FcCallChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10.0)),
          child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white)),
        ),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 9.5, color: Colors.grey)),
      ],
    );
  }
}

/// Comparison row for Section 13
class _FcCompareRow extends StatelessWidget {
  final String label;
  final bool result;
  final String note;

  const _FcCompareRow({required this.label, required this.result, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: (result ? Colors.green : Colors.red).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: result ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('$result', style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, fontWeight: FontWeight.bold, color: result ? Colors.green.shade700 : Colors.red.shade700)),
          ),
          SizedBox(width: 6.0),
          Text(note, style: TextStyle(fontSize: 9.5, color: Colors.grey)),
        ],
      ),
    );
  }
}
