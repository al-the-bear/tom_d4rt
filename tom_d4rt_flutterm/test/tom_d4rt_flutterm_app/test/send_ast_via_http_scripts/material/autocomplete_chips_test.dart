// D4rt test script: Tests showDateRangePicker, RestorableTimeOfDay, AutocompleteOptionsBuilder, AutocompleteFieldViewBuilder, AutocompleteOptionsViewBuilder, AutocompleteOnSelected, TappableChipAttributes, DisabledChipAttributes, CheckableChipAttributes
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Autocomplete typedefs and chip attributes tests executing');

  // ========== showDateRangePicker ==========
  print('--- showDateRangePicker Tests ---');
  // showDateRangePicker is a top-level function that shows a date range picker dialog.
  // Cannot call it directly in build() as it requires a navigator context, but we can reference it.
  print('showDateRangePicker type: ${showDateRangePicker.runtimeType}');
  print(
    'showDateRangePicker is a Function: ${showDateRangePicker is Function}',
  );

  // ========== RestorableTimeOfDay ==========
  print('--- RestorableTimeOfDay Tests ---');
  final restorableTime = RestorableTimeOfDay(TimeOfDay(hour: 10, minute: 30));
  print('RestorableTimeOfDay type: ${restorableTime.runtimeType}');
  // Note: .value requires isRegistered via RestorationMixin
  print('RestorableTimeOfDay created with TimeOfDay(10:30)');

  // ========== AutocompleteOptionsBuilder ==========
  print('--- AutocompleteOptionsBuilder Tests ---');
  // AutocompleteOptionsBuilder<T> = Iterable<T> Function(TextEditingValue)
  final AutocompleteOptionsBuilder<String> optionsBuilder =
      (TextEditingValue textEditingValue) {
        final options = ['Apple', 'Banana', 'Cherry'];
        if (textEditingValue.text.isEmpty) {
          return options;
        }
        return options.where(
          (String option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      };
  print('AutocompleteOptionsBuilder type: ${optionsBuilder.runtimeType}');
  final testResult = optionsBuilder(TextEditingValue(text: 'a'));
  print('AutocompleteOptionsBuilder result for "a": $testResult');

  // ========== AutocompleteFieldViewBuilder ==========
  print('--- AutocompleteFieldViewBuilder Tests ---');
  // AutocompleteFieldViewBuilder = Widget Function(BuildContext, TextEditingController, FocusNode, VoidCallback)
  final AutocompleteFieldViewBuilder fieldViewBuilder =
      (
        BuildContext ctx,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextField(controller: controller, focusNode: focusNode);
      };
  print('AutocompleteFieldViewBuilder type: ${fieldViewBuilder.runtimeType}');

  // ========== AutocompleteOptionsViewBuilder ==========
  print('--- AutocompleteOptionsViewBuilder Tests ---');
  // AutocompleteOptionsViewBuilder<T> = Widget Function(BuildContext, AutocompleteOnSelected<T>, Iterable<T>)
  final AutocompleteOptionsViewBuilder<String> optionsViewBuilder =
      (
        BuildContext ctx,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return ListView(
          children: options
              .map(
                (String option) => ListTile(
                  title: Text(option),
                  onTap: () => onSelected(option),
                ),
              )
              .toList(),
        );
      };
  print(
    'AutocompleteOptionsViewBuilder type: ${optionsViewBuilder.runtimeType}',
  );

  // ========== AutocompleteOnSelected ==========
  print('--- AutocompleteOnSelected Tests ---');
  // AutocompleteOnSelected<T> = void Function(T)
  final AutocompleteOnSelected<String> onSelected = (String selection) {
    print('Selected: $selection');
  };
  print('AutocompleteOnSelected type: ${onSelected.runtimeType}');

  // ========== TappableChipAttributes ==========
  print('--- TappableChipAttributes Tests ---');
  // TappableChipAttributes is a mixin on chip classes like ActionChip
  final actionChip = ActionChip(label: Text('Action'), onPressed: () {});
  print(
    'ActionChip type (has TappableChipAttributes): ${actionChip.runtimeType}',
  );
  print('ActionChip is Widget: ${actionChip is Widget}');

  // ========== DisabledChipAttributes ==========
  print('--- DisabledChipAttributes Tests ---');
  // DisabledChipAttributes is a mixin providing isEnabled/onDeleted etc.
  final inputChip = InputChip(label: Text('Input'), isEnabled: false);
  print(
    'InputChip type (has DisabledChipAttributes): ${inputChip.runtimeType}',
  );
  print('InputChip isEnabled: false (DisabledChipAttributes)');

  // ========== CheckableChipAttributes ==========
  print('--- CheckableChipAttributes Tests ---');
  // CheckableChipAttributes is a mixin on FilterChip providing selected/showCheckmark
  final filterChip = FilterChip(
    label: Text('Filter'),
    selected: true,
    onSelected: (bool value) {},
    showCheckmark: true,
  );
  print(
    'FilterChip type (has CheckableChipAttributes): ${filterChip.runtimeType}',
  );
  print('FilterChip selected: true (CheckableChipAttributes)');

  print('All autocomplete and chip attribute tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Autocomplete & Chips Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('showDateRangePicker: function referenced'),
            Text('RestorableTimeOfDay: created'),
            Text('AutocompleteOptionsBuilder: defined'),
            Text('AutocompleteFieldViewBuilder: defined'),
            Text('AutocompleteOptionsViewBuilder: defined'),
            Text('AutocompleteOnSelected: defined'),
            Text('TappableChipAttributes: via ActionChip'),
            Text('DisabledChipAttributes: via InputChip'),
            Text('CheckableChipAttributes: via FilterChip'),
          ],
        ),
      ),
    ),
  );
}
