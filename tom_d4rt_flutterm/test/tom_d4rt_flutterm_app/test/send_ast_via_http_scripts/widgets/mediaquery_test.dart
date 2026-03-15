// D4rt test script: Tests MediaQuery from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MediaQuery test executing');

  // Test MediaQuery.of(context) to get data
  final mediaData = MediaQuery.of(context);
  print('MediaQuery.of(context) size: ${mediaData.size}');
  print(
    'MediaQuery.of(context) devicePixelRatio: ${mediaData.devicePixelRatio}',
  );
  print('MediaQuery.of(context) padding: ${mediaData.padding}');
  print('MediaQuery.of(context) viewInsets: ${mediaData.viewInsets}');
  print('MediaQuery.of(context) textScaleFactor: ${mediaData.textScaleFactor}');
  print(
    'MediaQuery.of(context) platformBrightness: ${mediaData.platformBrightness}',
  );

  // Test MediaQuery.sizeOf shortcut
  final size = MediaQuery.sizeOf(context);
  print('MediaQuery.sizeOf: $size');
  print('Screen width: ${size.width}');
  print('Screen height: ${size.height}');

  // Test MediaQueryData constructor
  final customData = MediaQueryData(
    size: Size(400.0, 800.0),
    devicePixelRatio: 2.0,
    padding: EdgeInsets.only(top: 44.0, bottom: 34.0),
    textScaleFactor: 1.0,
  );
  print('Custom MediaQueryData created: size=${customData.size}');
  print('Custom padding: ${customData.padding}');

  // Test MediaQuery widget wrapping child with custom data
  final mediaQueryWidget = MediaQuery(
    data: customData,
    child: Container(
      color: Colors.blue,
      height: 100.0,
      child: Center(
        child: Text('Custom MediaQuery', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery widget with custom data created');

  // Test removePadding
  final noPaddingWidget = MediaQuery.removePadding(
    context: context,
    removeTop: true,
    removeBottom: true,
    child: Container(
      color: Colors.green,
      height: 100.0,
      child: Center(
        child: Text('No padding', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removePadding created (top and bottom removed)');

  // Test removePadding with only top
  final noTopPadding = MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Container(
      color: Colors.orange,
      height: 100.0,
      child: Center(
        child: Text('No top padding', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removePadding created (top only)');

  // Test removeViewInsets
  final noViewInsets = MediaQuery.removeViewInsets(
    context: context,
    removeBottom: true,
    child: Container(
      color: Colors.purple,
      height: 100.0,
      child: Center(
        child: Text('No view insets', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removeViewInsets created (bottom removed)');

  // Test MediaQueryData.copyWith
  final modifiedData = mediaData.copyWith(textScaleFactor: 2.0);
  print(
    'MediaQueryData.copyWith textScaleFactor=2.0: ${modifiedData.textScaleFactor}',
  );

  final scaledWidget = MediaQuery(
    data: modifiedData,
    child: Container(
      color: Colors.teal,
      height: 100.0,
      child: Center(
        child: Text('Scaled text', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery with modified data created');

  // Display responsive info
  final width = mediaData.size.width;
  final isNarrow = width < 600.0;
  print('Screen width: $width, isNarrow: $isNarrow');

  print('MediaQuery test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'MediaQuery Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Screen: ${mediaData.size}'),
        Text('DPR: ${mediaData.devicePixelRatio}'),
        Text('Padding: ${mediaData.padding}'),
        SizedBox(height: 16.0),
        Text(
          'Custom MediaQuery:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        mediaQueryWidget,
        SizedBox(height: 8.0),
        Text('Remove padding:', style: TextStyle(fontWeight: FontWeight.bold)),
        noPaddingWidget,
        SizedBox(height: 8.0),
        noTopPadding,
        SizedBox(height: 8.0),
        Text(
          'Remove view insets:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        noViewInsets,
        SizedBox(height: 8.0),
        Text('Scaled text:', style: TextStyle(fontWeight: FontWeight.bold)),
        scaledWidget,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• MediaQuery.of(context) gets device info'),
        Text('• MediaQuery.sizeOf(context) for screen size'),
        Text('• removePadding removes safe area padding'),
        Text('• removeViewInsets removes keyboard insets'),
        Text('• copyWith modifies specific properties'),
      ],
    ),
  );
}
