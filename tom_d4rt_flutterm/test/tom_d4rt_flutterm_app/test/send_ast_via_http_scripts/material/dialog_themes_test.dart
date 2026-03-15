// D4rt test script: Tests DialogTheme, BottomSheetTheme, BottomSheetThemeData, SnackBarTheme, SnackBarThemeData from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog themes test executing');

  // ========== DIALOG THEME DATA ==========
  print('--- DialogThemeData Tests ---');

  final dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    alignment: Alignment.center,
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    contentTextStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
    actionsPadding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
    iconColor: Colors.blue,
  );
  print('DialogThemeData created');
  print('  backgroundColor: ${dialogTheme.backgroundColor}');
  print('  elevation: ${dialogTheme.elevation}');
  print('  shadowColor: ${dialogTheme.shadowColor}');
  print('  surfaceTintColor: ${dialogTheme.surfaceTintColor}');
  print('  shape: ${dialogTheme.shape}');
  print('  alignment: ${dialogTheme.alignment}');
  print('  iconColor: ${dialogTheme.iconColor}');
  print('  actionsPadding: ${dialogTheme.actionsPadding}');

  // Test copyWith
  final copiedDialogTheme = dialogTheme.copyWith(
    backgroundColor: Colors.grey.shade50,
    elevation: 16.0,
  );
  print('DialogThemeData.copyWith created');
  print('  new backgroundColor: ${copiedDialogTheme.backgroundColor}');
  print('  new elevation: ${copiedDialogTheme.elevation}');
  print('  shape preserved: ${copiedDialogTheme.shape}');

  // ========== BOTTOM SHEET THEME DATA ==========
  print('--- BottomSheetThemeData Tests ---');

  final bottomSheetThemeData = BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black38,
    surfaceTintColor: Colors.grey.shade50,
    modalBackgroundColor: Colors.white,
    modalElevation: 16.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
    ),
    showDragHandle: true,
    dragHandleColor: Colors.grey.shade400,
    dragHandleSize: Size(32.0, 4.0),
    constraints: BoxConstraints(maxWidth: 640.0),
  );
  print('BottomSheetThemeData created');
  print('  backgroundColor: ${bottomSheetThemeData.backgroundColor}');
  print('  elevation: ${bottomSheetThemeData.elevation}');
  print('  modalBackgroundColor: ${bottomSheetThemeData.modalBackgroundColor}');
  print('  modalElevation: ${bottomSheetThemeData.modalElevation}');
  print('  showDragHandle: ${bottomSheetThemeData.showDragHandle}');
  print('  dragHandleColor: ${bottomSheetThemeData.dragHandleColor}');
  print('  dragHandleSize: ${bottomSheetThemeData.dragHandleSize}');
  print('  shape: ${bottomSheetThemeData.shape}');

  // Test copyWith
  final copiedBottomSheetTheme = bottomSheetThemeData.copyWith(
    backgroundColor: Colors.blue.shade50,
    showDragHandle: false,
  );
  print('BottomSheetThemeData.copyWith created');
  print('  new backgroundColor: ${copiedBottomSheetTheme.backgroundColor}');
  print('  new showDragHandle: ${copiedBottomSheetTheme.showDragHandle}');
  print('  elevation preserved: ${copiedBottomSheetTheme.elevation}');

  // ========== SNACK BAR THEME DATA ==========
  print('--- SnackBarThemeData Tests ---');

  final snackBarThemeData = SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    actionTextColor: Colors.blue.shade200,
    disabledActionTextColor: Colors.grey,
    contentTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
    elevation: 6.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    behavior: SnackBarBehavior.floating,
    width: 400.0,
    insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    showCloseIcon: true,
    closeIconColor: Colors.white70,
    actionOverflowThreshold: 0.25,
    dismissDirection: DismissDirection.horizontal,
  );
  print('SnackBarThemeData created');
  print('  backgroundColor: ${snackBarThemeData.backgroundColor}');
  print('  actionTextColor: ${snackBarThemeData.actionTextColor}');
  print('  elevation: ${snackBarThemeData.elevation}');
  print('  behavior: ${snackBarThemeData.behavior}');
  print('  width: ${snackBarThemeData.width}');
  print('  showCloseIcon: ${snackBarThemeData.showCloseIcon}');
  print('  closeIconColor: ${snackBarThemeData.closeIconColor}');
  print('  dismissDirection: ${snackBarThemeData.dismissDirection}');
  print('  shape: ${snackBarThemeData.shape}');

  // Test copyWith (keep behavior floating since original has width=400)
  final copiedSnackBarTheme = snackBarThemeData.copyWith(
    backgroundColor: Colors.black87,
    elevation: 8.0,
  );
  print('SnackBarThemeData.copyWith created');
  print('  new backgroundColor: ${copiedSnackBarTheme.backgroundColor}');
  print('  new elevation: ${copiedSnackBarTheme.elevation}');
  print('  behavior preserved: ${copiedSnackBarTheme.behavior}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    dialogTheme: dialogTheme,
    bottomSheetTheme: bottomSheetThemeData,
    snackBarTheme: snackBarThemeData,
  );
  print('ThemeData with dialog themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  dialogTheme.elevation: ${resolvedTheme.dialogTheme.elevation}',
        );
        print(
          '  bottomSheetTheme.elevation: ${resolvedTheme.bottomSheetTheme.elevation}',
        );
        print(
          '  snackBarTheme.behavior: ${resolvedTheme.snackBarTheme.behavior}',
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Dialog: elevation=${dialogTheme.elevation}'),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'BottomSheet: showDragHandle=${bottomSheetThemeData.showDragHandle}',
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('SnackBar: behavior=${snackBarThemeData.behavior}'),
              ),
            ),
            Text('Dialog themes test passed'),
          ],
        );
      },
    ),
  );
}
