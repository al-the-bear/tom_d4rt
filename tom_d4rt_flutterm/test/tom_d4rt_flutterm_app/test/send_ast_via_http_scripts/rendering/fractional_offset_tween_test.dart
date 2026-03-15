// D4rt test script: Tests FractionalOffsetTween from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

dynamic build(BuildContext context) {
  print('FractionalOffsetTween test executing');

  // ========== Basic FractionalOffsetTween creation ==========
  print('--- Basic FractionalOffsetTween ---');
  final tween1 = FractionalOffsetTween(
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
  );
  print('  created: ${tween1.runtimeType}');
  print('  begin: ${tween1.begin}');
  print('  end: ${tween1.end}');

  // ========== Lerp at different values ==========
  print('--- Lerp at different t values ---');
  print('  lerp(0.0): ${tween1.lerp(0.0)}');
  print('  lerp(0.25): ${tween1.lerp(0.25)}');
  print('  lerp(0.5): ${tween1.lerp(0.5)}');
  print('  lerp(0.75): ${tween1.lerp(0.75)}');
  print('  lerp(1.0): ${tween1.lerp(1.0)}');

  // ========== Transform method ==========
  print('--- Transform method ---');
  print('  transform(0.0): ${tween1.transform(0.0)}');
  print('  transform(0.5): ${tween1.transform(0.5)}');
  print('  transform(1.0): ${tween1.transform(1.0)}');

  // ========== Different FractionalOffset values ==========
  print('--- Different FractionalOffset values ---');
  final tween2 = FractionalOffsetTween(
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 1.0),
  );
  print('  tween2 begin: ${tween2.begin}');
  print('  tween2 end: ${tween2.end}');
  print('  tween2.lerp(0.5): ${tween2.lerp(0.5)}');

  final tween3 = FractionalOffsetTween(
    begin: FractionalOffset(-0.5, -0.5),
    end: FractionalOffset(1.5, 1.5),
  );
  print('  tween3 begin: ${tween3.begin}');
  print('  tween3 end: ${tween3.end}');
  print('  tween3.lerp(0.5): ${tween3.lerp(0.5)}');

  // ========== Named FractionalOffset constants ==========
  print('--- Named FractionalOffset constants ---');
  final tweenCenter = FractionalOffsetTween(
    begin: FractionalOffset.center,
    end: FractionalOffset.bottomCenter,
  );
  print('  center to bottomCenter');
  print('  begin: ${tweenCenter.begin}');
  print('  end: ${tweenCenter.end}');
  print('  lerp(0.5): ${tweenCenter.lerp(0.5)}');

  final tweenCorners = FractionalOffsetTween(
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft,
  );
  print('  topRight to bottomLeft');
  print('  lerp(0.5): ${tweenCorners.lerp(0.5)}');

  // ========== Chain method ==========
  print('--- Chain method ---');
  final chainedTween = tween1.chain(CurveTween(curve: Curves.easeInOut));
  print('  chained tween created: ${chainedTween.runtimeType}');

  // ========== Null begin/end handling ==========
  print('--- Null handling ---');
  final tweenNullBegin = FractionalOffsetTween(
    begin: null,
    end: FractionalOffset.center,
  );
  print('  null begin tween.end: ${tweenNullBegin.end}');

  final tweenNullEnd = FractionalOffsetTween(
    begin: FractionalOffset.center,
    end: null,
  );
  print('  null end tween.begin: ${tweenNullEnd.begin}');

  print('FractionalOffsetTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FractionalOffsetTween Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic tween: ${tween1.runtimeType}'),
          Text('Begin: ${tween1.begin}'),
          Text('End: ${tween1.end}'),
          Text('Lerp(0.0): ${tween1.lerp(0.0)}'),
          Text('Lerp(0.5): ${tween1.lerp(0.5)}'),
          Text('Lerp(1.0): ${tween1.lerp(1.0)}'),
          Text('Center to bottom: ${tweenCenter.lerp(0.5)}'),
        ],
      ),
    ),
  );
}
