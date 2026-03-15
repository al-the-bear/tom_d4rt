// D4rt test script: Tests DiagnosticsDebugCreator from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsDebugCreator test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // DiagnosticsDebugCreator wraps an Element for debug information
  // We'll use context which is an Element (BuildContext is implemented by Element)
  final element = context as Element;

  final debugCreator = DiagnosticsDebugCreator(element);
  print('Created DiagnosticsDebugCreator');
  print('Value type: ${debugCreator.value.runtimeType}');
  results.add('Created with element type: ${element.runtimeType}');

  // ========== Section 2: Value Property ==========
  print('--- Section 2: Value Property ---');

  final value = debugCreator.value;
  print('Value: $value');
  print('Value is Element: ${value is Element}');
  results.add('Value is Element: ${value is Element}');

  // ========== Section 3: DiagnosticsProperty Base ==========
  print('--- Section 3: DiagnosticsProperty Base ---');

  // DiagnosticsDebugCreator extends DiagnosticsProperty<Element>
  print('Is DiagnosticsProperty: ${debugCreator is DiagnosticsProperty}');
  print('Name: ${debugCreator.name}');
  print('Level: ${debugCreator.level}');
  results.add('Name: ${debugCreator.name}, Level: ${debugCreator.level}');

  // ========== Section 4: ToString Methods ==========
  print('--- Section 4: ToString Methods ---');

  final str = debugCreator.toString();
  print('toString: $str');

  final jsonStr = debugCreator.toJsonMap(DiagnosticsSerializationDelegate());
  print('toJsonMap keys: ${jsonStr.keys.join(", ")}');
  results.add('Has toString: ${str.isNotEmpty}');

  // ========== Section 5: Description ==========
  print('--- Section 5: Description ---');

  final description = debugCreator.toDescription();
  print('Description: $description');
  results.add('Description available: ${description.isNotEmpty}');

  // ========== Section 6: With Different Elements ==========
  print('--- Section 6: With Different Elements ---');

  // Get widget from context
  final widget = context.widget;
  print('Widget type: ${widget.runtimeType}');
  print('Element widget: ${element.widget.runtimeType}');
  results.add('Widget type: ${widget.runtimeType}');

  // ========== Section 7: Property Features ==========
  print('--- Section 7: Property Features ---');

  // Check diagnostic property features
  print('isFiltered: ${debugCreator.isFiltered(DiagnosticLevel.info)}');
  print('allowWrap: ${debugCreator.allowWrap}');
  print('allowNameWrap: ${debugCreator.allowNameWrap}');
  results.add('allowWrap: ${debugCreator.allowWrap}');

  // ========== Section 8: Expandable Children ==========
  print('--- Section 8: Expandable Children ---');

  final children = debugCreator.getChildren();
  print('Children count: ${children.length}');
  for (var child in children.take(3)) {
    print('  Child: ${child.name}');
  }
  results.add('Children count: ${children.length}');

  // ========== Section 9: Properties ==========
  print('--- Section 9: Properties ---');

  final properties = debugCreator.getProperties();
  print('Properties count: ${properties.length}');
  for (var prop in properties.take(3)) {
    print('  Property: ${prop.name}');
  }
  results.add('Properties count: ${properties.length}');

  // ========== Section 10: Style ==========
  print('--- Section 10: Style ---');

  print('Style: ${debugCreator.style}');
  print('ShowName: ${debugCreator.showName}');
  print('ShowSeparator: ${debugCreator.showSeparator}');
  results.add('Style: ${debugCreator.style}');

  print('DiagnosticsDebugCreator test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DiagnosticsDebugCreator Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
