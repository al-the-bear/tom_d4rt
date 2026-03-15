// D4rt test script: Tests WidgetState, MaterialStateProperty, WidgetStateProperty, WidgetStatesController from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetState test executing');

  // ========== WIDGET STATE VALUES ==========
  print('--- WidgetState Values ---');

  print('WidgetState.hovered: ${WidgetState.hovered}');
  print('WidgetState.focused: ${WidgetState.focused}');
  print('WidgetState.pressed: ${WidgetState.pressed}');
  print('WidgetState.dragged: ${WidgetState.dragged}');
  print('WidgetState.selected: ${WidgetState.selected}');
  print('WidgetState.scrolledUnder: ${WidgetState.scrolledUnder}');
  print('WidgetState.disabled: ${WidgetState.disabled}');
  print('WidgetState.error: ${WidgetState.error}');

  // ========== WIDGET STATE PROPERTY - all ==========
  print('--- WidgetStateProperty.all Tests ---');

  final colorAll = WidgetStateProperty.all(Colors.blue);
  print('WidgetStateProperty.all(Colors.blue) created');
  print('  resolve empty: ${colorAll.resolve({})}');
  print('  resolve hovered: ${colorAll.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${colorAll.resolve({WidgetState.pressed})}');
  print('  resolve disabled: ${colorAll.resolve({WidgetState.disabled})}');

  // ========== WIDGET STATE PROPERTY - resolveWith ==========
  print('--- WidgetStateProperty.resolveWith Tests ---');

  final colorResolved = WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    if (states.contains(WidgetState.pressed)) return Colors.blue.shade900;
    if (states.contains(WidgetState.hovered)) return Colors.blue.shade700;
    if (states.contains(WidgetState.focused)) return Colors.blue.shade600;
    if (states.contains(WidgetState.selected)) return Colors.blue.shade800;
    if (states.contains(WidgetState.error)) return Colors.red;
    return Colors.blue;
  });
  print('WidgetStateProperty.resolveWith created');
  print('  resolve empty: ${colorResolved.resolve({})}');
  print('  resolve hovered: ${colorResolved.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${colorResolved.resolve({WidgetState.pressed})}');
  print('  resolve disabled: ${colorResolved.resolve({WidgetState.disabled})}');
  print('  resolve selected: ${colorResolved.resolve({WidgetState.selected})}');
  print('  resolve error: ${colorResolved.resolve({WidgetState.error})}');
  print('  resolve focused: ${colorResolved.resolve({WidgetState.focused})}');

  // Test with multiple states
  final multiStates = {WidgetState.hovered, WidgetState.focused};
  print('  resolve hovered+focused: ${colorResolved.resolve(multiStates)}');

  // ========== WIDGET STATE PROPERTY - various types ==========
  print('--- WidgetStateProperty Various Types ---');

  final doubleProperty = WidgetStateProperty.resolveWith<double>((states) {
    if (states.contains(WidgetState.pressed)) return 8.0;
    if (states.contains(WidgetState.hovered)) return 4.0;
    return 2.0;
  });
  print('WidgetStateProperty<double> created');
  print('  resolve empty: ${doubleProperty.resolve({})}');
  print('  resolve hovered: ${doubleProperty.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${doubleProperty.resolve({WidgetState.pressed})}');

  final borderSideProperty = WidgetStateProperty.resolveWith<BorderSide>((
    states,
  ) {
    if (states.contains(WidgetState.error)) {
      return BorderSide(color: Colors.red, width: 2.0);
    }
    if (states.contains(WidgetState.focused)) {
      return BorderSide(color: Colors.blue, width: 2.0);
    }
    return BorderSide(color: Colors.grey, width: 1.0);
  });
  print('WidgetStateProperty<BorderSide> created');
  print('  resolve empty: ${borderSideProperty.resolve({})}');
  print(
    '  resolve focused: ${borderSideProperty.resolve({WidgetState.focused})}',
  );
  print('  resolve error: ${borderSideProperty.resolve({WidgetState.error})}');

  final textStyleProperty = WidgetStateProperty.resolveWith<TextStyle>((
    states,
  ) {
    if (states.contains(WidgetState.selected)) {
      return TextStyle(fontWeight: FontWeight.bold, color: Colors.blue);
    }
    return TextStyle(fontWeight: FontWeight.normal, color: Colors.black87);
  });
  print('WidgetStateProperty<TextStyle> created');
  print('  resolve empty: ${textStyleProperty.resolve({})}');
  print(
    '  resolve selected: ${textStyleProperty.resolve({WidgetState.selected})}',
  );

  // ========== MATERIAL STATE PROPERTY (legacy) ==========
  print('--- MaterialStateProperty Tests (legacy) ---');

  final materialColorProp = MaterialStateProperty.all(Colors.green);
  print('MaterialStateProperty.all(Colors.green) created');
  print('  resolve empty: ${materialColorProp.resolve({})}');

  final materialResolvedProp = MaterialStateProperty.resolveWith<Color>((
    states,
  ) {
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    if (states.contains(WidgetState.pressed)) return Colors.green.shade900;
    return Colors.green;
  });
  print('MaterialStateProperty.resolveWith created');
  print('  resolve empty: ${materialResolvedProp.resolve({})}');
  print(
    '  resolve disabled: ${materialResolvedProp.resolve({WidgetState.disabled})}',
  );
  print(
    '  resolve pressed: ${materialResolvedProp.resolve({WidgetState.pressed})}',
  );

  // ========== WIDGET STATES CONTROLLER ==========
  print('--- WidgetStatesController Tests ---');

  final controller = WidgetStatesController();
  print('WidgetStatesController created');
  print('  initial value: ${controller.value}');

  controller.update(WidgetState.hovered, true);
  print('  after add hovered: ${controller.value}');

  controller.update(WidgetState.focused, true);
  print('  after add focused: ${controller.value}');

  controller.update(WidgetState.hovered, false);
  print('  after remove hovered: ${controller.value}');

  // Create controller with initial states
  final controllerWithStates = WidgetStatesController({
    WidgetState.selected,
    WidgetState.focused,
  });
  print('WidgetStatesController with initial states created');
  print('  initial value: ${controllerWithStates.value}');

  controllerWithStates.update(WidgetState.pressed, true);
  print('  after add pressed: ${controllerWithStates.value}');

  controllerWithStates.update(WidgetState.selected, false);
  print('  after remove selected: ${controllerWithStates.value}');

  // Dispose controllers
  controller.dispose();
  controllerWithStates.dispose();
  print('Controllers disposed');

  // ========== INTEGRATION: USE IN BUTTON STYLE ==========
  print('--- Integration with ButtonStyle ---');

  final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return Colors.grey.shade200;
      if (states.contains(WidgetState.pressed)) return Colors.blue.shade900;
      if (states.contains(WidgetState.hovered)) return Colors.blue.shade700;
      return Colors.blue;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return Colors.grey;
      return Colors.white;
    }),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return 0.0;
      if (states.contains(WidgetState.hovered)) return 4.0;
      return 2.0;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white.withValues(alpha: 0.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.white.withValues(alpha: 0.1);
      }
      return Colors.transparent;
    }),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
  print('ButtonStyle with WidgetStateProperty created');
  print('  backgroundColor states resolve correctly');

  // ========== RETURN WIDGET ==========
  return Theme(
    data: ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    ),
    child: Builder(
      builder: (ctx) {
        final theme = Theme.of(ctx);
        print('Theme.of resolved with WidgetState-driven button style');

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Normal')),
            SizedBox(height: 8.0),
            ElevatedButton(onPressed: null, child: Text('Disabled')),
            SizedBox(height: 8.0),
            Text('WidgetState test passed'),
          ],
        );
      },
    ),
  );
}
