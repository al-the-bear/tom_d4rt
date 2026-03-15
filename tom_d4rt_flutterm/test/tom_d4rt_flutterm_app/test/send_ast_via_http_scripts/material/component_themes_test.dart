// D4rt test script: Tests ListTileTheme, ListTileThemeData, CardTheme, ChipTheme, ChipThemeData, TooltipTheme, TooltipThemeData, DividerTheme, DividerThemeData from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Component themes test executing');

  // ========== LIST TILE THEME DATA ==========
  print('--- ListTileThemeData Tests ---');

  final listTileThemeData = ListTileThemeData(
    dense: true,
    tileColor: Colors.white,
    selectedTileColor: Colors.blue.shade50,
    iconColor: Colors.blue.shade700,
    textColor: Colors.black87,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    subtitleTextStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
    leadingAndTrailingTextStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    minLeadingWidth: 40.0,
    minVerticalPadding: 4.0,
    enableFeedback: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    selectedColor: Colors.blue,
    horizontalTitleGap: 16.0,
    visualDensity: VisualDensity.compact,
  );
  print('ListTileThemeData created');
  print('  dense: ${listTileThemeData.dense}');
  print('  tileColor: ${listTileThemeData.tileColor}');
  print('  selectedTileColor: ${listTileThemeData.selectedTileColor}');
  print('  iconColor: ${listTileThemeData.iconColor}');
  print('  contentPadding: ${listTileThemeData.contentPadding}');
  print('  minLeadingWidth: ${listTileThemeData.minLeadingWidth}');
  print('  shape: ${listTileThemeData.shape}');

  // Test copyWith
  final copiedListTileTheme = listTileThemeData.copyWith(
    dense: false,
    tileColor: Colors.grey.shade50,
  );
  print('ListTileThemeData.copyWith created');
  print('  new dense: ${copiedListTileTheme.dense}');
  print('  new tileColor: ${copiedListTileTheme.tileColor}');

  // ========== CARD THEME DATA ==========
  print('--- CardThemeData Tests ---');

  final cardTheme = CardThemeData(
    color: Colors.white,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade50,
    elevation: 2.0,
    margin: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    clipBehavior: Clip.antiAlias,
  );
  print('CardThemeData created');
  print('  color: ${cardTheme.color}');
  print('  shadowColor: ${cardTheme.shadowColor}');
  print('  elevation: ${cardTheme.elevation}');
  print('  margin: ${cardTheme.margin}');
  print('  clipBehavior: ${cardTheme.clipBehavior}');
  print('  shape: ${cardTheme.shape}');

  // Test copyWith
  final copiedCardTheme = cardTheme.copyWith(
    elevation: 4.0,
    color: Colors.grey.shade50,
  );
  print('CardThemeData.copyWith created');
  print('  new elevation: ${copiedCardTheme.elevation}');
  print('  new color: ${copiedCardTheme.color}');

  // ========== CHIP THEME DATA ==========
  print('--- ChipThemeData Tests ---');

  final chipThemeData = ChipThemeData(
    backgroundColor: Colors.grey.shade200,
    selectedColor: Colors.blue.shade100,
    disabledColor: Colors.grey.shade300,
    deleteIconColor: Colors.red,
    secondarySelectedColor: Colors.blue.shade200,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade50,
    selectedShadowColor: Colors.blue.shade300,
    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
    secondaryLabelStyle: TextStyle(fontSize: 14.0, color: Colors.blue),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
    side: BorderSide(color: Colors.grey.shade400, width: 1.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    elevation: 1.0,
    pressElevation: 4.0,
    brightness: Brightness.light,
    showCheckmark: true,
    checkmarkColor: Colors.blue,
    iconTheme: IconThemeData(size: 18.0, color: Colors.grey.shade700),
  );
  print('ChipThemeData created');
  print('  backgroundColor: ${chipThemeData.backgroundColor}');
  print('  selectedColor: ${chipThemeData.selectedColor}');
  print('  labelStyle: ${chipThemeData.labelStyle}');
  print('  elevation: ${chipThemeData.elevation}');
  print('  showCheckmark: ${chipThemeData.showCheckmark}');
  print('  shape: ${chipThemeData.shape}');

  // Test copyWith
  final copiedChipTheme = chipThemeData.copyWith(
    backgroundColor: Colors.blue.shade50,
    elevation: 3.0,
  );
  print('ChipThemeData.copyWith created');
  print('  new backgroundColor: ${copiedChipTheme.backgroundColor}');
  print('  new elevation: ${copiedChipTheme.elevation}');

  // ========== TOOLTIP THEME DATA ==========
  print('--- TooltipThemeData Tests ---');

  final tooltipThemeData = TooltipThemeData(
    height: 32.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    margin: EdgeInsets.all(4.0),
    verticalOffset: 24.0,
    preferBelow: true,
    textStyle: TextStyle(fontSize: 12.0, color: Colors.white),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(4.0),
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
    textAlign: TextAlign.center,
    enableFeedback: true,
  );
  print('TooltipThemeData created');
  print('  height: ${tooltipThemeData.height}');
  print('  padding: ${tooltipThemeData.padding}');
  print('  verticalOffset: ${tooltipThemeData.verticalOffset}');
  print('  preferBelow: ${tooltipThemeData.preferBelow}');
  print('  waitDuration: ${tooltipThemeData.waitDuration}');
  print('  showDuration: ${tooltipThemeData.showDuration}');
  print('  textAlign: ${tooltipThemeData.textAlign}');

  // Test copyWith
  final copiedTooltipTheme = tooltipThemeData.copyWith(
    height: 40.0,
    preferBelow: false,
  );
  print('TooltipThemeData.copyWith created');
  print('  new height: ${copiedTooltipTheme.height}');
  print('  new preferBelow: ${copiedTooltipTheme.preferBelow}');

  // ========== DIVIDER THEME DATA ==========
  print('--- DividerThemeData Tests ---');

  final dividerThemeData = DividerThemeData(
    color: Colors.grey.shade300,
    space: 16.0,
    thickness: 1.0,
    indent: 16.0,
    endIndent: 16.0,
  );
  print('DividerThemeData created');
  print('  color: ${dividerThemeData.color}');
  print('  space: ${dividerThemeData.space}');
  print('  thickness: ${dividerThemeData.thickness}');
  print('  indent: ${dividerThemeData.indent}');
  print('  endIndent: ${dividerThemeData.endIndent}');

  // Test copyWith
  final copiedDividerTheme = dividerThemeData.copyWith(
    color: Colors.blue.shade200,
    thickness: 2.0,
  );
  print('DividerThemeData.copyWith created');
  print('  new color: ${copiedDividerTheme.color}');
  print('  new thickness: ${copiedDividerTheme.thickness}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    listTileTheme: listTileThemeData,
    cardTheme: cardTheme,
    chipTheme: chipThemeData,
    tooltipTheme: tooltipThemeData,
    dividerTheme: dividerThemeData,
  );
  print('ThemeData with component themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print('  listTileTheme.dense: ${resolvedTheme.listTileTheme.dense}');
        print('  cardTheme.elevation: ${resolvedTheme.cardTheme.elevation}');
        print(
          '  chipTheme.backgroundColor: ${resolvedTheme.chipTheme.backgroundColor}',
        );
        print('  tooltipTheme.height: ${resolvedTheme.tooltipTheme.height}');
        print(
          '  dividerTheme.thickness: ${resolvedTheme.dividerTheme.thickness}',
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTileTheme(
              data: listTileThemeData,
              child: ListTile(title: Text('ListTile themed')),
            ),
            ChipTheme(
              data: chipThemeData,
              child: Chip(label: Text('Chip themed')),
            ),
            TooltipTheme(
              data: tooltipThemeData,
              child: Tooltip(message: 'Test', child: Text('Tooltip themed')),
            ),
            DividerTheme(data: dividerThemeData, child: Divider()),
            Card(child: Text('Component themes test passed')),
          ],
        );
      },
    ),
  );
}
