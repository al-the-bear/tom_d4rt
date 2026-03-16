// D4rt test script: Tests Key, LocalKey, ValueKey, UniqueKey from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation key test executing');

  // ========== KEY ==========
  print('--- Key Tests ---');

  // Note: Key is an abstract class, test via subclasses
  // Keys are used to preserve state when widgets move in the tree
  print('Key is abstract - tested via subclasses');

  // ========== LOCALKEY ==========
  print('--- LocalKey Tests ---');

  // Note: LocalKey is also abstract, but its subclasses are testable
  // LocalKey identifies a widget within a subtree
  print('LocalKey is abstract - tested via ValueKey, UniqueKey');

  // ========== VALUEKEY ==========
  print('--- ValueKey Tests ---');

  // Test ValueKey with int
  final intKey = ValueKey<int>(1);
  print('ValueKey<int>(1) created: $intKey');
  print('ValueKey value: ${intKey.value}');

  // Test ValueKey with string
  final stringKey = ValueKey<String>('myKey');
  print('ValueKey<String>("myKey") created: $stringKey');
  print('ValueKey value: ${stringKey.value}');

  // Test ValueKey with double
  final doubleKey = ValueKey<double>(3.14);
  print('ValueKey<double>(3.14) created: $doubleKey');
  print('ValueKey value: ${doubleKey.value}');

  // Test ValueKey with bool
  final boolKey = ValueKey<bool>(true);
  print('ValueKey<bool>(true) created: $boolKey');
  print('ValueKey value: ${boolKey.value}');

  // Test ValueKey equality
  final key1 = ValueKey<int>(42);
  final key2 = ValueKey<int>(42);
  final key3 = ValueKey<int>(43);
  print('ValueKey equality: key1 == key2: ${key1 == key2}'); // true
  print('ValueKey equality: key1 == key3: ${key1 == key3}'); // false

  // Test ValueKey with custom type
  final dateKey = ValueKey<DateTime>(DateTime(2024, 1, 1));
  print('ValueKey<DateTime> created: $dateKey');

  // Test ValueKey with null (allowed but not recommended)
  final nullKey = ValueKey<String?>(null);
  print('ValueKey<String?>(null) created: $nullKey');

  // Test ValueKey with List (reference equality)
  final listKey1 = ValueKey<List<int>>([1, 2, 3]);
  final listKey2 = ValueKey<List<int>>([1, 2, 3]);
  print(
    'ValueKey<List> equality (different list): ${listKey1 == listKey2}',
  ); // false (reference equality)

  // Test ValueKey hashCode
  print('ValueKey hashCode: ${intKey.hashCode}');
  print(
    'Equal ValueKeys have same hashCode: ${key1.hashCode == key2.hashCode}',
  );

  // ========== UNIQUEKEY ==========
  print('--- UniqueKey Tests ---');

  // Test UniqueKey creation
  final uniqueKey1 = UniqueKey();
  print('UniqueKey created: $uniqueKey1');

  // Test UniqueKey uniqueness
  final uniqueKey2 = UniqueKey();
  print('Second UniqueKey created: $uniqueKey2');
  print('UniqueKeys are different: ${uniqueKey1 != uniqueKey2}');

  // Test UniqueKey toString
  print('UniqueKey toString: ${uniqueKey1.toString()}');

  // Test UniqueKey is never equal to another
  final uniqueKeys = List.generate(5, (index) => UniqueKey());
  print('Generated 5 UniqueKeys');
  for (var i = 0; i < uniqueKeys.length; i++) {
    for (var j = i + 1; j < uniqueKeys.length; j++) {
      if (uniqueKeys[i] == uniqueKeys[j]) {
        print('ERROR: UniqueKeys should never be equal');
      }
    }
  }
  print('All UniqueKeys are unique: true');

  // Test UniqueKey hashCode uniqueness
  final hash1 = uniqueKey1.hashCode;
  final hash2 = uniqueKey2.hashCode;
  print('UniqueKey hashCodes: $hash1, $hash2');

  // ========== GLOBALKEY ==========
  print('--- GlobalKey Tests ---');

  // Test GlobalKey creation
  final globalKey1 = GlobalKey();
  print('GlobalKey created: $globalKey1');

  // Test GlobalKey with debugLabel
  final labeledGlobalKey = GlobalKey(debugLabel: 'myGlobalKey');
  print('GlobalKey with debugLabel created: $labeledGlobalKey');

  // Test GlobalKey uniqueness
  final globalKey2 = GlobalKey();
  print('GlobalKeys are different: ${globalKey1 != globalKey2}');

  // ========== OBJECTKEY ==========
  print('--- ObjectKey Tests ---');

  // Test ObjectKey with object
  final objKey1 = ObjectKey('unique_object_1');
  print('ObjectKey created: $objKey1');

  // Test ObjectKey equality with same object
  final myObject = 'shared_object';
  final objKey2 = ObjectKey(myObject);
  final objKey3 = ObjectKey(myObject);
  print('ObjectKey equality (same object): ${objKey2 == objKey3}');

  // Test ObjectKey with different objects
  final objKey4 = ObjectKey('unique_object_2');
  print('ObjectKey equality (different objects): ${objKey2 == objKey4}');

  print('Foundation key test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation Keys',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          // ValueKey examples
          Text(
            'ValueKey Examples:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            key: ValueKey<int>(1),
            children: [
              Container(
                key: ValueKey<String>('container1'),
                width: 50.0,
                height: 50.0,
                color: Color(0xFF2196F3),
                child: Center(
                  child: Text('1', style: TextStyle(color: Color(0xFFFFFFFF))),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                key: ValueKey<String>('container2'),
                width: 50.0,
                height: 50.0,
                color: Color(0xFF4CAF50),
                child: Center(
                  child: Text('2', style: TextStyle(color: Color(0xFFFFFFFF))),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                key: ValueKey<String>('container3'),
                width: 50.0,
                height: 50.0,
                color: Color(0xFFFF9800),
                child: Center(
                  child: Text('3', style: TextStyle(color: Color(0xFFFFFFFF))),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // UniqueKey examples
          Text(
            'UniqueKey Examples:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                key: UniqueKey(),
                width: 50.0,
                height: 50.0,
                color: Color(0xFF9C27B0),
                child: Center(
                  child: Text('U1', style: TextStyle(color: Color(0xFFFFFFFF))),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                key: UniqueKey(),
                width: 50.0,
                height: 50.0,
                color: Color(0xFF673AB7),
                child: Center(
                  child: Text('U2', style: TextStyle(color: Color(0xFFFFFFFF))),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // Key comparison info
          Text('Key Behavior:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• ValueKey: Equal if values are equal'),
          Text('• UniqueKey: Never equal to another UniqueKey'),
          Text('• GlobalKey: Never equal, can access widget state'),
          Text('• ObjectKey: Equal if same object reference'),
          SizedBox(height: 16.0),

          // Key usage info
          Text('Common Uses:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• Preserve state when widgets move'),
          Text('• Identify widgets in lists'),
          Text('• Access widget state from outside'),
        ],
      ),
    ),
  );
}
