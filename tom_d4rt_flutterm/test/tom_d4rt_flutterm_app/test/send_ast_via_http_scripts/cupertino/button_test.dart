// D4rt test script: Tests CupertinoButton from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoButton test executing');

  // ========== CUPERTINOBUTTON ==========
  print('--- CupertinoButton Tests ---');

  // Test basic CupertinoButton
  final basicButton = CupertinoButton(
    child: Text('Basic Button'),
    onPressed: () {
      print('Button pressed');
    },
  );
  print('Basic CupertinoButton created');

  // Test CupertinoButton with color
  final coloredButton = CupertinoButton(
    color: CupertinoColors.systemBlue,
    child: Text('Blue Button'),
    onPressed: () {},
  );
  print('CupertinoButton with color created');

  // Test CupertinoButton disabled
  final disabledButton = CupertinoButton(
    child: Text('Disabled Button'),
    onPressed: null,
  );
  print('CupertinoButton disabled created');

  // Test CupertinoButton with disabledColor
  final disabledColorButton = CupertinoButton(
    disabledColor: CupertinoColors.systemGrey3,
    child: Text('Custom Disabled'),
    onPressed: null,
  );
  print('CupertinoButton with disabledColor created');

  // Test CupertinoButton with padding
  final paddedButton = CupertinoButton(
    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    child: Text('Padded Button'),
    onPressed: () {},
  );
  print('CupertinoButton with padding created');

  // Test CupertinoButton with minSize
  final minSizeButton = CupertinoButton(
    minSize: 60.0,
    child: Text('Min Size'),
    onPressed: () {},
  );
  print('CupertinoButton with minSize created');

  // Test CupertinoButton with pressedOpacity
  final opacityButton = CupertinoButton(
    pressedOpacity: 0.3,
    child: Text('Custom Opacity'),
    onPressed: () {},
  );
  print('CupertinoButton with pressedOpacity created');

  // Test CupertinoButton with borderRadius
  final roundedButton = CupertinoButton(
    borderRadius: BorderRadius.circular(20.0),
    color: CupertinoColors.systemPurple,
    child: Text('Rounded'),
    onPressed: () {},
  );
  print('CupertinoButton with borderRadius created');

  // Test CupertinoButton with alignment
  final alignedButton = CupertinoButton(
    alignment: Alignment.centerLeft,
    child: Text('Left Aligned'),
    onPressed: () {},
  );
  print('CupertinoButton with alignment created');

  // Test CupertinoButton with Icon
  final iconButton = CupertinoButton(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(CupertinoIcons.add), SizedBox(width: 8.0), Text('Add')],
    ),
    onPressed: () {},
  );
  print('CupertinoButton with Icon created');

  // Test CupertinoButton.filled
  final filledButton = CupertinoButton.filled(
    child: Text('Filled Button'),
    onPressed: () {},
  );
  print('CupertinoButton.filled created');

  // Test CupertinoButton.filled with custom padding
  final filledPaddedButton = CupertinoButton.filled(
    padding: EdgeInsets.all(16.0),
    child: Text('Filled Padded'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with padding created');

  // Test CupertinoButton.filled disabled
  final filledDisabledButton = CupertinoButton.filled(
    child: Text('Filled Disabled'),
    onPressed: null,
  );
  print('CupertinoButton.filled disabled created');

  // Test CupertinoButton.filled with disabledColor
  final filledDisabledColorButton = CupertinoButton.filled(
    disabledColor: CupertinoColors.systemGrey,
    child: Text('Custom Disabled'),
    onPressed: null,
  );
  print('CupertinoButton.filled with disabledColor created');

  // Test CupertinoButton.filled with minSize
  final filledMinSizeButton = CupertinoButton.filled(
    minSize: 50.0,
    child: Text('Small'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with minSize created');

  // Test CupertinoButton.filled with pressedOpacity
  final filledOpacityButton = CupertinoButton.filled(
    pressedOpacity: 0.5,
    child: Text('Half Opacity'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with pressedOpacity created');

  // Test CupertinoButton.filled with borderRadius
  final filledRoundedButton = CupertinoButton.filled(
    borderRadius: BorderRadius.circular(25.0),
    child: Text('Very Rounded'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with borderRadius created');

  // Test CupertinoButton.filled with alignment
  final filledAlignedButton = CupertinoButton.filled(
    alignment: Alignment.center,
    child: Text('Centered'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with alignment created');

  // Test different colored filled buttons
  final redFilledButton = CupertinoButton.filled(
    child: Text('Red Filled'),
    onPressed: () {},
  );
  print('Various colored CupertinoButton.filled created');

  print('CupertinoButton test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoButton Test'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Basic Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              basicButton,
              SizedBox(height: 8.0),
              coloredButton,
              SizedBox(height: 8.0),
              disabledButton,

              SizedBox(height: 24.0),
              Text(
                'Styled Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              paddedButton,
              SizedBox(height: 8.0),
              roundedButton,
              SizedBox(height: 8.0),
              iconButton,

              SizedBox(height: 24.0),
              Text(
                'Filled Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              filledButton,
              SizedBox(height: 8.0),
              filledPaddedButton,
              SizedBox(height: 8.0),
              filledDisabledButton,
              SizedBox(height: 8.0),
              filledRoundedButton,

              SizedBox(height: 24.0),
              Text(
                'Button Grid:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  CupertinoButton(
                    color: CupertinoColors.systemRed,
                    child: Text('Red'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemOrange,
                    child: Text('Orange'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemGreen,
                    child: Text('Green'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemTeal,
                    child: Text('Teal'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemIndigo,
                    child: Text('Indigo'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
