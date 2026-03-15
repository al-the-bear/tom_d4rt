// D4rt test script: Tests NavigationBarTheme, NavigationBarThemeData, NavigationRailTheme, NavigationRailThemeData, DrawerTheme, DrawerThemeData from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigation themes test executing');

  // ========== NAVIGATION BAR THEME DATA ==========
  print('--- NavigationBarThemeData Tests ---');

  final navBarThemeData = NavigationBarThemeData(
    backgroundColor: Colors.blue.shade50,
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade100,
    height: 80.0,
    indicatorColor: Colors.blue.shade200,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 12.0, color: Colors.blue.shade800),
    ),
    iconTheme: WidgetStateProperty.all(
      IconThemeData(size: 24.0, color: Colors.blue.shade700),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  );
  print('NavigationBarThemeData created');
  print('  backgroundColor: ${navBarThemeData.backgroundColor}');
  print('  elevation: ${navBarThemeData.elevation}');
  print('  height: ${navBarThemeData.height}');
  print('  indicatorColor: ${navBarThemeData.indicatorColor}');
  print('  labelBehavior: ${navBarThemeData.labelBehavior}');

  // Test copyWith
  final copiedNavBarTheme = navBarThemeData.copyWith(
    backgroundColor: Colors.green.shade50,
    elevation: 6.0,
  );
  print('NavigationBarThemeData.copyWith created');
  print('  new backgroundColor: ${copiedNavBarTheme.backgroundColor}');
  print('  new elevation: ${copiedNavBarTheme.elevation}');
  print('  height preserved: ${copiedNavBarTheme.height}');

  // ========== NAVIGATION RAIL THEME DATA ==========
  print('--- NavigationRailThemeData Tests ---');

  final navRailThemeData = NavigationRailThemeData(
    backgroundColor: Colors.grey.shade100,
    elevation: 2.0,
    indicatorColor: Colors.purple.shade200,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    unselectedLabelTextStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
    selectedLabelTextStyle: TextStyle(
      fontSize: 12.0,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    ),
    unselectedIconTheme: IconThemeData(size: 22.0, color: Colors.grey),
    selectedIconTheme: IconThemeData(size: 24.0, color: Colors.purple),
    groupAlignment: -1.0,
    labelType: NavigationRailLabelType.all,
    useIndicator: true,
    minWidth: 72.0,
    minExtendedWidth: 256.0,
  );
  print('NavigationRailThemeData created');
  print('  backgroundColor: ${navRailThemeData.backgroundColor}');
  print('  elevation: ${navRailThemeData.elevation}');
  print('  indicatorColor: ${navRailThemeData.indicatorColor}');
  print('  labelType: ${navRailThemeData.labelType}');
  print('  useIndicator: ${navRailThemeData.useIndicator}');
  print('  minWidth: ${navRailThemeData.minWidth}');
  print('  minExtendedWidth: ${navRailThemeData.minExtendedWidth}');
  print('  groupAlignment: ${navRailThemeData.groupAlignment}');

  // Test copyWith
  final copiedNavRailTheme = navRailThemeData.copyWith(
    backgroundColor: Colors.white,
    labelType: NavigationRailLabelType.selected,
  );
  print('NavigationRailThemeData.copyWith created');
  print('  new backgroundColor: ${copiedNavRailTheme.backgroundColor}');
  print('  new labelType: ${copiedNavRailTheme.labelType}');

  // ========== DRAWER THEME DATA ==========
  print('--- DrawerThemeData Tests ---');

  final drawerThemeData = DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 16.0,
    shadowColor: Colors.black38,
    surfaceTintColor: Colors.grey.shade50,
    width: 304.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16.0)),
    ),
  );
  print('DrawerThemeData created');
  print('  backgroundColor: ${drawerThemeData.backgroundColor}');
  print('  elevation: ${drawerThemeData.elevation}');
  print('  shadowColor: ${drawerThemeData.shadowColor}');
  print('  width: ${drawerThemeData.width}');
  print('  shape: ${drawerThemeData.shape}');

  // Test copyWith
  final copiedDrawerTheme = drawerThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    width: 320.0,
  );
  print('DrawerThemeData.copyWith created');
  print('  new backgroundColor: ${copiedDrawerTheme.backgroundColor}');
  print('  new width: ${copiedDrawerTheme.width}');
  print('  elevation preserved: ${copiedDrawerTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    navigationBarTheme: navBarThemeData,
    navigationRailTheme: navRailThemeData,
    drawerTheme: drawerThemeData,
  );
  print('ThemeData with navigation themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  navigationBarTheme.height: ${resolvedTheme.navigationBarTheme.height}',
        );
        print(
          '  navigationRailTheme.labelType: ${resolvedTheme.navigationRailTheme.labelType}',
        );
        print('  drawerTheme.width: ${resolvedTheme.drawerTheme.width}');

        return NavigationBarTheme(
          data: navBarThemeData,
          child: NavigationRailTheme(
            data: navRailThemeData,
            child: DrawerTheme(
              data: drawerThemeData,
              child: Card(child: Text('Navigation themes test passed')),
            ),
          ),
        );
      },
    ),
  );
}
