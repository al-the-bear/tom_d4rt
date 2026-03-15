// D4rt test script: Tests AppBarTheme, BottomAppBarTheme from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppBar themes test executing');

  // ========== APPBAR THEME ==========
  print('--- AppBarTheme Tests ---');

  final appBarTheme = AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 4.0,
    scrolledUnderElevation: 3.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.indigo.shade100,
    centerTitle: true,
    titleSpacing: 16.0,
    toolbarHeight: 56.0,
    toolbarTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white70, size: 22.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
    ),
  );
  print('AppBarTheme created');
  print('  backgroundColor: ${appBarTheme.backgroundColor}');
  print('  foregroundColor: ${appBarTheme.foregroundColor}');
  print('  elevation: ${appBarTheme.elevation}');
  print('  scrolledUnderElevation: ${appBarTheme.scrolledUnderElevation}');
  print('  centerTitle: ${appBarTheme.centerTitle}');
  print('  toolbarHeight: ${appBarTheme.toolbarHeight}');
  print('  titleSpacing: ${appBarTheme.titleSpacing}');
  print('  shadowColor: ${appBarTheme.shadowColor}');
  print('  surfaceTintColor: ${appBarTheme.surfaceTintColor}');
  print('  shape: ${appBarTheme.shape}');

  // Test AppBarTheme copyWith
  final copiedAppBarTheme = appBarTheme.copyWith(
    backgroundColor: Colors.deepPurple,
    elevation: 8.0,
    centerTitle: false,
  );
  print('AppBarTheme.copyWith created');
  print('  new backgroundColor: ${copiedAppBarTheme.backgroundColor}');
  print('  new elevation: ${copiedAppBarTheme.elevation}');
  print('  new centerTitle: ${copiedAppBarTheme.centerTitle}');
  print('  foregroundColor preserved: ${copiedAppBarTheme.foregroundColor}');

  // ========== BOTTOM APP BAR THEME DATA ==========
  print('--- BottomAppBarThemeData Tests ---');

  final bottomAppBarTheme = BottomAppBarThemeData(
    color: Colors.blue.shade50,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade100,
    height: 80.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    shape: CircularNotchedRectangle(),
  );
  print('BottomAppBarThemeData created');
  print('  color: ${bottomAppBarTheme.color}');
  print('  elevation: ${bottomAppBarTheme.elevation}');
  print('  shadowColor: ${bottomAppBarTheme.shadowColor}');
  print('  surfaceTintColor: ${bottomAppBarTheme.surfaceTintColor}');
  print('  height: ${bottomAppBarTheme.height}');
  print('  shape: ${bottomAppBarTheme.shape}');

  // Test BottomAppBarThemeData copyWith
  final copiedBottomAppBarTheme = bottomAppBarTheme.copyWith(
    color: Colors.grey.shade100,
    elevation: 4.0,
  );
  print('BottomAppBarThemeData.copyWith created');
  print('  new color: ${copiedBottomAppBarTheme.color}');
  print('  new elevation: ${copiedBottomAppBarTheme.elevation}');
  print('  height preserved: ${copiedBottomAppBarTheme.height}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    appBarTheme: appBarTheme,
    bottomAppBarTheme: bottomAppBarTheme,
  );
  print('ThemeData with AppBar themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  appBarTheme.backgroundColor: ${resolvedTheme.appBarTheme.backgroundColor}',
        );
        print(
          '  appBarTheme.elevation: ${resolvedTheme.appBarTheme.elevation}',
        );
        print(
          '  bottomAppBarTheme.color: ${resolvedTheme.bottomAppBarTheme.color}',
        );
        print(
          '  bottomAppBarTheme.elevation: ${resolvedTheme.bottomAppBarTheme.elevation}',
        );

        return Scaffold(
          appBar: AppBar(title: Text('AppBar Theme Test')),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.home), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
            ),
          ),
          body: Center(child: Text('AppBar themes test passed')),
        );
      },
    ),
  );
}
