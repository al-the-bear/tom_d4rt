// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-12T17:06:50.447734

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4_example/src/userbridge_override/my_list.dart' as $d4_example_1;

/// Bridge class for userbridge_override module.
class UserbridgeOverrideBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createMyListBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'MyList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\userbridge_override\my_list.dart',
    };
  }

    isAssignable: (v) => v is $d4_example_1.MyList,
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_1.MyList();
      },
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$d4_example_1.MyList>(target, 'MyList').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$d4_example_1.MyList>(target, 'MyList').isEmpty,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        t.clear();
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticMethods: {
      'empty': (visitor, positional, named, typeArgs) {
        return $d4_example_1.MyList.empty();
      },
      'from': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'from');
        if (positional.isEmpty) {
          throw ArgumentError('from: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<dynamic>(positional[0], 'items');
        return $d4_example_1.MyList.from(items);
      },
    },
    constructorSignatures: {
      '': 'MyList()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'remove': 'bool remove(T item)',
      'clear': 'void clear()',
    },
    getterSignatures: {
      'length': 'int get length',
      'isEmpty': 'bool get isEmpty',
    },
    staticMethodSignatures: {
      'empty': 'MyList<T> empty()',
      'from': 'MyList<T> from(List<T> items)',
    },
  );
}

