// D4rt test script: Tests ConstrainedBox, FittedBox, AspectRatio, IntrinsicWidth, IntrinsicHeight from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    'ConstrainedBox/FittedBox/AspectRatio/IntrinsicWidth/IntrinsicHeight test executing',
  );

  // ========== CONSTRAINEDBOX ==========
  print('--- ConstrainedBox Tests ---');

  // Test ConstrainedBox with minWidth and minHeight
  final constrainedMin = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 100.0, minHeight: 50.0),
    child: Container(
      color: Colors.blue,
      child: Text('Min 100x50', style: TextStyle(color: Colors.white)),
    ),
  );
  print('ConstrainedBox with minWidth=100, minHeight=50 created');

  // Test ConstrainedBox with maxWidth and maxHeight
  final constrainedMax = ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 200.0, maxHeight: 80.0),
    child: Container(
      color: Colors.green,
      width: 300.0,
      height: 120.0,
      child: Text('Max 200x80', style: TextStyle(color: Colors.white)),
    ),
  );
  print('ConstrainedBox with maxWidth=200, maxHeight=80 created');

  // Test ConstrainedBox with tight constraints
  final constrainedTight = ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 150.0, height: 60.0),
    child: Container(
      color: Colors.orange,
      child: Center(
        child: Text('Tight 150x60', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ConstrainedBox with tight constraints created');

  // Test ConstrainedBox with loose constraints
  final constrainedLoose = ConstrainedBox(
    constraints: BoxConstraints.loose(Size(180.0, 70.0)),
    child: Container(
      color: Colors.purple,
      child: Text('Loose 180x70', style: TextStyle(color: Colors.white)),
    ),
  );
  print('ConstrainedBox with loose constraints created');

  // Test ConstrainedBox with expand
  final constrainedExpand = ConstrainedBox(
    constraints: BoxConstraints.expand(height: 40.0),
    child: Container(
      color: Colors.teal,
      child: Center(
        child: Text('Expand height=40', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ConstrainedBox with expand created');

  // ========== FITTEDBOX ==========
  print('--- FittedBox Tests ---');

  // Test FittedBox with default fit (contain)
  final fittedContain = FittedBox(
    child: Text('Fitted Contain', style: TextStyle(fontSize: 50.0)),
  );
  print('FittedBox with default fit (contain) created');

  // Test FittedBox with BoxFit.fill
  final fittedFill = SizedBox(
    width: 200.0,
    height: 50.0,
    child: FittedBox(
      fit: BoxFit.fill,
      child: Text('Fill', style: TextStyle(fontSize: 30.0)),
    ),
  );
  print('FittedBox with BoxFit.fill created');

  // Test FittedBox with BoxFit.cover
  final fittedCover = SizedBox(
    width: 150.0,
    height: 40.0,
    child: FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: Text('Cover Text', style: TextStyle(fontSize: 30.0)),
    ),
  );
  print('FittedBox with BoxFit.cover and clipBehavior created');

  // Test FittedBox with BoxFit.scaleDown
  final fittedScaleDown = SizedBox(
    width: 200.0,
    height: 50.0,
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text('ScaleDown', style: TextStyle(fontSize: 12.0)),
    ),
  );
  print('FittedBox with BoxFit.scaleDown created');

  // Test FittedBox with alignment
  final fittedAligned = SizedBox(
    width: 200.0,
    height: 60.0,
    child: FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.centerLeft,
      child: Text('Left', style: TextStyle(fontSize: 20.0)),
    ),
  );
  print('FittedBox with alignment=centerLeft created');

  // ========== ASPECTRATIO ==========
  print('--- AspectRatio Tests ---');

  // Test AspectRatio 16:9
  final aspect16x9 = AspectRatio(
    aspectRatio: 16.0 / 9.0,
    child: Container(
      color: Colors.indigo,
      child: Center(
        child: Text('16:9', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AspectRatio 16:9 created');

  // Test AspectRatio 1:1 (square)
  final aspectSquare = AspectRatio(
    aspectRatio: 1.0,
    child: Container(
      color: Colors.red,
      child: Center(
        child: Text('1:1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AspectRatio 1:1 (square) created');

  // Test AspectRatio 4:3
  final aspect4x3 = AspectRatio(
    aspectRatio: 4.0 / 3.0,
    child: Container(
      color: Colors.brown,
      child: Center(
        child: Text('4:3', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AspectRatio 4:3 created');

  // ========== INTRINSICWIDTH ==========
  print('--- IntrinsicWidth Tests ---');

  // Test IntrinsicWidth basic
  final intrinsicWidthBasic = IntrinsicWidth(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(color: Colors.blue, height: 30.0, child: Text('Short')),
        Container(
          color: Colors.green,
          height: 30.0,
          child: Text('A longer text here'),
        ),
        Container(color: Colors.red, height: 30.0, child: Text('Med')),
      ],
    ),
  );
  print('IntrinsicWidth basic created');

  // Test IntrinsicWidth with stepWidth
  final intrinsicWidthStep = IntrinsicWidth(
    stepWidth: 100.0,
    child: Container(
      color: Colors.amber,
      height: 40.0,
      child: Center(child: Text('Step 100')),
    ),
  );
  print('IntrinsicWidth with stepWidth=100 created');

  // ========== INTRINSICHEIGHT ==========
  print('--- IntrinsicHeight Tests ---');

  // Test IntrinsicHeight basic
  final intrinsicHeightBasic = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(color: Colors.blue, width: 60.0, child: Text('A')),
        Container(
          color: Colors.green,
          width: 60.0,
          child: Column(
            children: [Text('Line 1'), Text('Line 2'), Text('Line 3')],
          ),
        ),
        Container(color: Colors.red, width: 60.0, child: Text('C')),
      ],
    ),
  );
  print('IntrinsicHeight basic created');

  print(
    'All ConstrainedBox/FittedBox/AspectRatio/IntrinsicWidth/IntrinsicHeight tests completed',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== ConstrainedBox Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Min constraints:', style: TextStyle(fontWeight: FontWeight.bold)),
        constrainedMin,
        SizedBox(height: 8.0),
        Text('Max constraints:', style: TextStyle(fontWeight: FontWeight.bold)),
        constrainedMax,
        SizedBox(height: 8.0),
        Text(
          'Tight constraints:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constrainedTight,
        SizedBox(height: 8.0),
        Text(
          'Loose constraints:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constrainedLoose,
        SizedBox(height: 8.0),
        Text('Expand:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 40.0, child: constrainedExpand),
        SizedBox(height: 16.0),
        Text(
          '=== FittedBox Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Contain:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, height: 40.0, child: fittedContain),
        SizedBox(height: 8.0),
        Text('Fill:', style: TextStyle(fontWeight: FontWeight.bold)),
        fittedFill,
        SizedBox(height: 8.0),
        Text('Cover:', style: TextStyle(fontWeight: FontWeight.bold)),
        fittedCover,
        SizedBox(height: 8.0),
        Text('ScaleDown:', style: TextStyle(fontWeight: FontWeight.bold)),
        fittedScaleDown,
        SizedBox(height: 8.0),
        Text('Aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        fittedAligned,
        SizedBox(height: 16.0),
        Text(
          '=== AspectRatio Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('16:9:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, child: aspect16x9),
        SizedBox(height: 8.0),
        Text('1:1 Square:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 100.0, child: aspectSquare),
        SizedBox(height: 8.0),
        Text('4:3:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, child: aspect4x3),
        SizedBox(height: 16.0),
        Text(
          '=== IntrinsicWidth Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        intrinsicWidthBasic,
        SizedBox(height: 8.0),
        Text('Step width:', style: TextStyle(fontWeight: FontWeight.bold)),
        intrinsicWidthStep,
        SizedBox(height: 16.0),
        Text(
          '=== IntrinsicHeight Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        intrinsicHeightBasic,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ConstrainedBox adds min/max size constraints'),
        Text('• FittedBox scales child to fit with various BoxFit modes'),
        Text('• AspectRatio enforces width/height ratio'),
        Text('• IntrinsicWidth sizes to widest child intrinsic width'),
        Text('• IntrinsicHeight sizes to tallest child intrinsic height'),
      ],
    ),
  );
}
