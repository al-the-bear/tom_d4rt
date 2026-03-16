// D4rt test script: Tests InkWell widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InkWell test executing');

  // Test basic InkWell with child
  final basicInkWell = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Basic InkWell'),
    ),
    onTap: () {
      print('Basic InkWell tapped');
    },
  );
  print('Basic InkWell with onTap created');

  // Test InkWell with onTap, onDoubleTap, onLongPress
  final multipleCallbacks = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue.shade100,
      child: Text('Multiple Callbacks'),
    ),
    onTap: () => print('onTap'),
    onDoubleTap: () => print('onDoubleTap'),
    onLongPress: () => print('onLongPress'),
  );
  print('InkWell with multiple callbacks created');

  // Test InkWell with custom splash and highlight colors
  final customColors = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Custom Colors'),
    ),
    splashColor: Colors.red.withOpacity(0.5),
    highlightColor: Colors.orange.withOpacity(0.3),
    onTap: () {},
  );
  print('InkWell with custom splashColor and highlightColor created');

  // Test InkWell with focusColor and hoverColor
  final focusHover = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Focus/Hover Colors'),
    ),
    focusColor: Colors.green.withOpacity(0.3),
    hoverColor: Colors.purple.withOpacity(0.2),
    onTap: () {},
  );
  print('InkWell with focusColor and hoverColor created');

  // Test InkWell with borderRadius
  final withBorderRadius = InkWell(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text('Rounded InkWell'),
    ),
    onTap: () {},
  );
  print('InkWell with borderRadius=20.0 created');

  // Test InkWell with customBorder
  final withCustomBorder = InkWell(
    customBorder: StadiumBorder(),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: ShapeDecoration(
        color: Colors.teal.shade100,
        shape: StadiumBorder(),
      ),
      child: Text('Stadium Border'),
    ),
    onTap: () {},
  );
  print('InkWell with StadiumBorder created');

  // Test InkWell with splashFactory
  final noSplash = InkWell(
    splashFactory: NoSplash.splashFactory,
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.amber.shade100,
      child: Text('No Splash'),
    ),
    onTap: () {},
  );
  print('InkWell with NoSplash.splashFactory created');

  // Test InkWell with enabled/disabled
  final enabledWell = InkWell(
    child: Container(padding: EdgeInsets.all(16.0), child: Text('Enabled')),
    onTap: () => print('Enabled tapped'),
  );
  print('InkWell enabled (onTap provided) created');

  final disabledWell = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Disabled (no onTap)'),
    ),
    // no onTap = disabled
  );
  print('InkWell disabled (no onTap) created');

  // Test InkWell with onTapDown and onTapUp
  final tapDownUp = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('TapDown/TapUp'),
    ),
    onTapDown: (details) => print('TapDown at ${details.localPosition}'),
    onTapUp: (details) => print('TapUp at ${details.localPosition}'),
    onTap: () => print('Tap complete'),
  );
  print('InkWell with onTapDown and onTapUp created');

  // Test InkWell with onTapCancel
  final tapCancel = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('With TapCancel'),
    ),
    onTap: () {},
    onTapCancel: () => print('Tap cancelled'),
  );
  print('InkWell with onTapCancel created');

  // Test InkWell with canRequestFocus
  final withFocus = InkWell(
    canRequestFocus: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Can Request Focus'),
    ),
    onTap: () {},
  );
  print('InkWell with canRequestFocus=true created');

  // Test InkWell with autofocus
  final autoFocus = InkWell(
    autofocus: true,
    child: Container(padding: EdgeInsets.all(16.0), child: Text('Autofocus')),
    onTap: () {},
  );
  print('InkWell with autofocus=true created');

  // Test InkWell with excludeFromSemantics
  final excludeSemantics = InkWell(
    excludeFromSemantics: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Excluded from Semantics'),
    ),
    onTap: () {},
  );
  print('InkWell with excludeFromSemantics=true created');

  print('InkWell test completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        basicInkWell,
        SizedBox(height: 8.0),
        multipleCallbacks,
        SizedBox(height: 8.0),
        customColors,
        SizedBox(height: 8.0),
        focusHover,
        SizedBox(height: 8.0),
        withBorderRadius,
        SizedBox(height: 8.0),
        withCustomBorder,
        SizedBox(height: 8.0),
        noSplash,
        SizedBox(height: 8.0),
        enabledWell,
        SizedBox(height: 8.0),
        disabledWell,
        SizedBox(height: 8.0),
        tapDownUp,
        SizedBox(height: 8.0),
        tapCancel,
        SizedBox(height: 8.0),
        withFocus,
        SizedBox(height: 8.0),
        autoFocus,
        SizedBox(height: 8.0),
        excludeSemantics,
      ],
    ),
  );
}
