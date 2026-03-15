// D4rt test script: Tests material FAB location, ScaffoldMessenger,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SnackBarBehavior, FloatingActionButtonLocation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FAB location and scaffold messenger test executing');

  // ========== FloatingActionButtonLocation ==========
  print('--- FloatingActionButtonLocation Tests ---');

  print('FABLocation.endFloat: ${FloatingActionButtonLocation.endFloat}');
  print('FABLocation.centerFloat: ${FloatingActionButtonLocation.centerFloat}');
  print('FABLocation.endDocked: ${FloatingActionButtonLocation.endDocked}');
  print(
    'FABLocation.centerDocked: ${FloatingActionButtonLocation.centerDocked}',
  );
  print('FABLocation.endTop: ${FloatingActionButtonLocation.endTop}');
  print('FABLocation.startTop: ${FloatingActionButtonLocation.startTop}');
  print(
    'FABLocation.endContained: ${FloatingActionButtonLocation.endContained}',
  );
  print(
    'FABLocation.miniStartTop: ${FloatingActionButtonLocation.miniStartTop}',
  );
  print('FABLocation.miniEndTop: ${FloatingActionButtonLocation.miniEndTop}');
  print(
    'FABLocation.miniCenterTop: ${FloatingActionButtonLocation.miniCenterTop}',
  );
  print(
    'FABLocation.miniStartFloat: ${FloatingActionButtonLocation.miniStartFloat}',
  );
  print(
    'FABLocation.miniEndFloat: ${FloatingActionButtonLocation.miniEndFloat}',
  );
  print(
    'FABLocation.miniCenterFloat: ${FloatingActionButtonLocation.miniCenterFloat}',
  );
  print(
    'FABLocation.miniStartDocked: ${FloatingActionButtonLocation.miniStartDocked}',
  );
  print(
    'FABLocation.miniEndDocked: ${FloatingActionButtonLocation.miniEndDocked}',
  );
  print(
    'FABLocation.miniCenterDocked: ${FloatingActionButtonLocation.miniCenterDocked}',
  );

  // ========== SnackBarBehavior ==========
  print('--- SnackBarBehavior Tests ---');

  print('SnackBarBehavior.fixed: ${SnackBarBehavior.fixed}');
  print('SnackBarBehavior.floating: ${SnackBarBehavior.floating}');

  // ========== SnackBarClosedReason ==========
  print('--- SnackBarClosedReason Tests ---');

  print('SnackBarClosedReason.action: ${SnackBarClosedReason.action}');
  print('SnackBarClosedReason.dismiss: ${SnackBarClosedReason.dismiss}');
  print('SnackBarClosedReason.swipe: ${SnackBarClosedReason.swipe}');
  print('SnackBarClosedReason.hide: ${SnackBarClosedReason.hide}');
  print('SnackBarClosedReason.remove: ${SnackBarClosedReason.remove}');
  print('SnackBarClosedReason.timeout: ${SnackBarClosedReason.timeout}');
  print('SnackBarClosedReason.values: ${SnackBarClosedReason.values}');

  // ========== MaterialBanner/SnackBar actions ==========
  print('--- SnackBarAction Tests ---');

  final snackAction = SnackBarAction(
    label: 'UNDO',
    onPressed: () => print('Undo pressed'),
    textColor: Colors.yellow,
  );
  print('SnackBarAction label: ${snackAction.label}');

  // ========== MaterialBannerClosedReason ==========
  print('--- MaterialBannerClosedReason Tests ---');

  print(
    'MaterialBannerClosedReason.dismiss: ${MaterialBannerClosedReason.dismiss}',
  );
  print(
    'MaterialBannerClosedReason.swipe: ${MaterialBannerClosedReason.swipe}',
  );
  print('MaterialBannerClosedReason.hide: ${MaterialBannerClosedReason.hide}');
  print(
    'MaterialBannerClosedReason.remove: ${MaterialBannerClosedReason.remove}',
  );

  // ========== TabBarIndicatorSize ==========
  print('--- TabBarIndicatorSize Tests ---');

  print('TabBarIndicatorSize.tab: ${TabBarIndicatorSize.tab}');
  print('TabBarIndicatorSize.label: ${TabBarIndicatorSize.label}');

  print('All FAB location and scaffold messenger tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('FAB Location Test')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FAB Location Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text('SnackBarBehavior: floating'),
            Text('FAB location: endFloat'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FAB pressed'),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ],
        ),
      ),
    ),
  );
}
