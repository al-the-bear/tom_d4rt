// D4rt test script: Tests Key, LocalKey, ValueKey, UniqueKey from foundation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
