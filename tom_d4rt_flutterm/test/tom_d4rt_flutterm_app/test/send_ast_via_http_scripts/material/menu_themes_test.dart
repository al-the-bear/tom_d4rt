// D4rt test script: Tests MenuTheme, MenuThemeData, MenuBarTheme, MenuBarThemeData, DropdownMenuTheme, DropdownMenuThemeData, SearchBarTheme, SearchBarThemeData, SearchViewTheme, SearchViewThemeData from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Menu themes test executing');

  // ========== MENU THEME DATA ==========
  print('--- MenuThemeData Tests ---');

  final menuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(8.0),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.grey.shade50),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 8.0)),
    alignment: Alignment.topLeft,
    side: WidgetStateProperty.all(BorderSide.none),
    minimumSize: WidgetStateProperty.all(Size(112.0, 48.0)),
    maximumSize: WidgetStateProperty.all(Size(280.0, 600.0)),
  );
  final menuThemeData = MenuThemeData(style: menuStyle);
  print('MenuThemeData created');
  print('  style: ${menuThemeData.style}');

  // ========== MENU BAR THEME DATA ==========
  print('--- MenuBarThemeData Tests ---');

  final menuBarStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(3.0),
    shadowColor: WidgetStateProperty.all(Colors.black12),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 4.0)),
  );
  final menuBarThemeData = MenuBarThemeData(style: menuBarStyle);
  print('MenuBarThemeData created');
  print('  style: ${menuBarThemeData.style}');

  // ========== DROPDOWN MENU THEME DATA ==========
  print('--- DropdownMenuThemeData Tests ---');

  final dropdownMenuThemeData = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),
    textStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(4.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
  print('DropdownMenuThemeData created');
  print(
    '  inputDecorationTheme: ${dropdownMenuThemeData.inputDecorationTheme}',
  );
  print('  textStyle: ${dropdownMenuThemeData.textStyle}');
  print('  menuStyle: ${dropdownMenuThemeData.menuStyle}');

  // Test copyWith
  final copiedDropdownMenuTheme = dropdownMenuThemeData.copyWith(
    textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
  );
  print('DropdownMenuThemeData.copyWith created');
  print('  new textStyle: ${copiedDropdownMenuTheme.textStyle}');

  // ========== SEARCH BAR THEME DATA ==========
  print('--- SearchBarThemeData Tests ---');

  final searchBarThemeData = SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
    elevation: WidgetStateProperty.all(2.0),
    shadowColor: WidgetStateProperty.all(Colors.black12),
    surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.grey.withValues(alpha: 0.1)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.0)),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16.0, color: Colors.black87),
    ),
    hintStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16.0, color: Colors.grey),
    ),
    constraints: BoxConstraints(minHeight: 56.0, maxWidth: 720.0),
    side: WidgetStateProperty.all(BorderSide.none),
    textCapitalization: TextCapitalization.none,
  );
  print('SearchBarThemeData created');
  print('  constraints: ${searchBarThemeData.constraints}');
  print('  textCapitalization: ${searchBarThemeData.textCapitalization}');

  // Test copyWith
  final copiedSearchBarTheme = searchBarThemeData.copyWith(
    constraints: BoxConstraints(minHeight: 48.0, maxWidth: 600.0),
  );
  print('SearchBarThemeData.copyWith created');
  print('  new constraints: ${copiedSearchBarTheme.constraints}');

  // ========== SEARCH VIEW THEME DATA ==========
  print('--- SearchViewThemeData Tests ---');

  final searchViewThemeData = SearchViewThemeData(
    backgroundColor: Colors.white,
    elevation: 6.0,
    surfaceTintColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    headerTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
    headerHintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
    dividerColor: Colors.grey.shade300,
    constraints: BoxConstraints(minHeight: 240.0, maxWidth: 720.0),
    side: BorderSide.none,
  );
  print('SearchViewThemeData created');
  print('  backgroundColor: ${searchViewThemeData.backgroundColor}');
  print('  elevation: ${searchViewThemeData.elevation}');
  print('  dividerColor: ${searchViewThemeData.dividerColor}');
  print('  constraints: ${searchViewThemeData.constraints}');
  print('  shape: ${searchViewThemeData.shape}');

  // Test copyWith
  final copiedSearchViewTheme = searchViewThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    elevation: 8.0,
  );
  print('SearchViewThemeData.copyWith created');
  print('  new backgroundColor: ${copiedSearchViewTheme.backgroundColor}');
  print('  new elevation: ${copiedSearchViewTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    menuTheme: menuThemeData,
    menuBarTheme: menuBarThemeData,
    dropdownMenuTheme: dropdownMenuThemeData,
    searchBarTheme: searchBarThemeData,
    searchViewTheme: searchViewThemeData,
  );
  print('ThemeData with menu themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print('  menuTheme.style: ${resolvedTheme.menuTheme.style}');
        print('  menuBarTheme.style: ${resolvedTheme.menuBarTheme.style}');
        print(
          '  dropdownMenuTheme.textStyle: ${resolvedTheme.dropdownMenuTheme.textStyle}',
        );
        print(
          '  searchBarTheme.constraints: ${resolvedTheme.searchBarTheme.constraints}',
        );
        print(
          '  searchViewTheme.elevation: ${resolvedTheme.searchViewTheme.elevation}',
        );

        return MenuTheme(
          data: menuThemeData,
          child: MenuBarTheme(
            data: menuBarThemeData,
            child: DropdownMenuTheme(
              data: dropdownMenuThemeData,
              child: SearchBarTheme(
                data: searchBarThemeData,
                child: SearchViewTheme(
                  data: searchViewThemeData,
                  child: Card(child: Text('Menu themes test passed')),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
