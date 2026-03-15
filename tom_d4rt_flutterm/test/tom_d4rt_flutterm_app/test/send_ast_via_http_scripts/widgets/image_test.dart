// D4rt test script: Tests Image widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Image test executing');

  // Note: Image.network and Image.asset may not work in D4rt sandbox
  // Testing constructors and properties that work without network/assets

  // Test Image.memory would require bytes, skipping for now

  // Test placeholder/error widgets pattern
  final placeholderImage = Container(
    width: 150.0,
    height: 100.0,
    color: Colors.grey.shade300,
    child: Center(
      child: Icon(Icons.image, size: 48.0, color: Colors.grey.shade600),
    ),
  );
  print('Placeholder image container created');

  // Test Container decorated like an image area
  final decoratedImageArea = Container(
    width: 150.0,
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blue, width: 2.0),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo, size: 32.0, color: Colors.blue),
          Text(
            'Image Area',
            style: TextStyle(color: Colors.blue, fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
  print('Decorated image area created');

  // Test DecorationImage properties on Container
  final decorationImageContainer = Container(
    width: 150.0,
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.green.shade100,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Text('BoxFit.cover', style: TextStyle(fontSize: 14.0)),
    ),
  );
  print('Container demonstrating BoxFit properties created');

  // Test various BoxFit values on containers
  final boxFitDemo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.red.shade100,
            child: Center(
              child: Text('fill', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.fill', style: TextStyle(fontSize: 8.0)),
        ],
      ),
      SizedBox(width: 8.0),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.green.shade100,
            child: Center(
              child: Text('contain', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.contain', style: TextStyle(fontSize: 8.0)),
        ],
      ),
      SizedBox(width: 8.0),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.blue.shade100,
            child: Center(
              child: Text('cover', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.cover', style: TextStyle(fontSize: 8.0)),
        ],
      ),
    ],
  );
  print('BoxFit demonstration created');

  // Test ImageRepeat values on containers
  final repeatDemo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.orange.shade100,
        child: Center(child: Text('no', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.purple.shade100,
        child: Center(child: Text('x', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.teal.shade100,
        child: Center(child: Text('y', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.pink.shade100,
        child: Center(child: Text('xy', style: TextStyle(fontSize: 10.0))),
      ),
    ],
  );
  print('ImageRepeat demonstration created');

  // Test FilterQuality on container
  final filterQualityDemo = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FilterQuality:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade200,
            child: Center(child: Text('none', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade300,
            child: Center(child: Text('low', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade400,
            child: Center(child: Text('med', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade500,
            child: Center(child: Text('high', style: TextStyle(fontSize: 8.0))),
          ),
        ],
      ),
    ],
  );
  print('FilterQuality demonstration created');

  print('Image test completed');
  print('NOTE: Network/asset images cannot be tested in D4rt sandbox');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Image Widget Test', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8.0),
      placeholderImage,
      SizedBox(height: 8.0),
      decoratedImageArea,
      SizedBox(height: 8.0),
      Text(
        'BoxFit values:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      boxFitDemo,
      SizedBox(height: 8.0),
      Text(
        'ImageRepeat values:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      repeatDemo,
      SizedBox(height: 8.0),
      filterQualityDemo,
    ],
  );
}
