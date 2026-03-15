// D4rt test script: Tests RestorableCupertinoTabController from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('RestorableCupertinoTabController test executing');

  // ===== 1. Default constructor (initialIndex: 0) =====
  print('--- Default RestorableCupertinoTabController ---');
  final defaultCtrl = RestorableCupertinoTabController();
  print('  created: ${defaultCtrl.runtimeType}');

  // ===== 2. With custom initialIndex =====
  print('--- Custom initialIndex ---');
  final ctrl1 = RestorableCupertinoTabController(initialIndex: 1);
  print('  initialIndex: 1 controller created');

  final ctrl2 = RestorableCupertinoTabController(initialIndex: 2);
  print('  initialIndex: 2 controller created');

  final ctrl3 = RestorableCupertinoTabController(initialIndex: 3);
  print('  initialIndex: 3 controller created');

  // ===== 3. CupertinoTabScaffold with default controller =====
  print('--- CupertinoTabScaffold integration ---');
  final tabItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
  ];
  print('  ${tabItems.length} tab items created');

  // ===== 4. Tab controller with CupertinoTabController =====
  print('--- CupertinoTabController comparison ---');
  final regularCtrl = CupertinoTabController(initialIndex: 0);
  print('  regular controller type: ${regularCtrl.runtimeType}');
  print('  regular controller index: ${regularCtrl.index}');

  final regularCtrl2 = CupertinoTabController(initialIndex: 2);
  print('  regular controller at index 2: ${regularCtrl2.index}');

  // ===== 5. Tab bar items =====
  print('--- CupertinoTabBar ---');
  final tabBar = CupertinoTabBar(
    items: tabItems,
    currentIndex: 0,
  );
  print('  tab bar created with ${tabItems.length} items');

  // ===== 6. Multiple tab configurations =====
  print('--- Multiple tab configurations ---');
  final twoTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc), label: 'Files'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.folder), label: 'Folders'),
  ];
  final fiveTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Account'),
  ];
  print('  2-tab config created');
  print('  5-tab config created');

  // ===== 7. Tab scaffold with explicit controller =====
  print('--- Tab scaffold ---');
  final tabPages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Profile Page')),
  ];

  regularCtrl.dispose();
  regularCtrl2.dispose();

  print('RestorableCupertinoTabController test completed');
  return CupertinoApp(
    home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: tabItems),
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Tab $index'),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tab $index Content', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 8.0),
                  Text('RestorableCupertinoTabController'),
                  Text('Supports state restoration'),
                  SizedBox(height: 16.0),
                  Text('Controllers tested:'),
                  Text('  default (index 0)'),
                  Text('  index 1, 2, 3'),
                  Text('  2-tab, 4-tab, 5-tab configs'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
