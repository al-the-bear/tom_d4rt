// D4rt test script: Tests ChildLayoutHelper from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Helper RenderBox for testing layout
class LayoutTestBox extends RenderBox {
  Size? _requestedSize;

  LayoutTestBox({Size? requestedSize}) : _requestedSize = requestedSize;

  @override
  void performLayout() {
    size = _requestedSize ?? constraints.biggest;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _requestedSize ?? constraints.biggest;
  }

  @override
  double computeMinIntrinsicWidth(double height) => _requestedSize?.width ?? 0;

  @override
  double computeMaxIntrinsicWidth(double height) =>
      _requestedSize?.width ?? double.infinity;

  @override
  double computeMinIntrinsicHeight(double width) => _requestedSize?.height ?? 0;

  @override
  double computeMaxIntrinsicHeight(double width) =>
      _requestedSize?.height ?? double.infinity;
}

dynamic build(BuildContext context) {
  print('ChildLayoutHelper test executing');
  final results = <String>[];

  // ========== Section 1: DryLayoutChild ==========
  print('--- Section 1: DryLayoutChild ---');

  final child1 = LayoutTestBox(requestedSize: Size(100, 50));
  final constraints1 = BoxConstraints(maxWidth: 200, maxHeight: 100);

  final drySize = ChildLayoutHelper.dryLayoutChild(child1, constraints1);
  print('Dry layout size: $drySize');
  results.add('Dry layout: $drySize');

  // ========== Section 2: LayoutChild ==========
  print('--- Section 2: LayoutChild ---');

  final child2 = LayoutTestBox(requestedSize: Size(80, 60));
  final constraints2 = BoxConstraints.tight(Size(150, 100));

  final layoutSize = ChildLayoutHelper.layoutChild(child2, constraints2);
  print('Layout child size: $layoutSize');
  print('Child hasSize: ${child2.hasSize}');
  results.add('Layout child: $layoutSize');

  // ========== Section 3: Constrained Layout ==========
  print('--- Section 3: Constrained Layout ---');

  // Test with tight constraints
  final tightChild = LayoutTestBox(requestedSize: Size(200, 200));
  final tightConstraints = BoxConstraints.tight(Size(50, 50));

  final tightSize = ChildLayoutHelper.layoutChild(tightChild, tightConstraints);
  print('Tight constrained size: $tightSize');
  results.add('Tight constraints: $tightSize');

  // ========== Section 4: Loose Constraints ==========
  print('--- Section 4: Loose Constraints ---');

  final looseChild = LayoutTestBox(requestedSize: Size(75, 75));
  final looseConstraints = BoxConstraints.loose(Size(200, 200));

  final looseSize = ChildLayoutHelper.layoutChild(looseChild, looseConstraints);
  print('Loose constrained size: $looseSize');
  results.add('Loose constraints: $looseSize');

  // ========== Section 5: Expanding Constraints ==========
  print('--- Section 5: Expanding Constraints ---');

  final expandChild = LayoutTestBox(); // Will take biggest
  final expandConstraints = BoxConstraints.expand(width: 300, height: 200);

  final expandSize = ChildLayoutHelper.layoutChild(
    expandChild,
    expandConstraints,
  );
  print('Expand constrained size: $expandSize');
  results.add('Expand constraints: $expandSize');

  // ========== Section 6: Min/Max Constraints ==========
  print('--- Section 6: Min/Max Constraints ---');

  final minMaxChild = LayoutTestBox(requestedSize: Size(100, 100));
  final minMaxConstraints = BoxConstraints(
    minWidth: 50,
    maxWidth: 150,
    minHeight: 40,
    maxHeight: 120,
  );

  final minMaxSize = ChildLayoutHelper.layoutChild(
    minMaxChild,
    minMaxConstraints,
  );
  print('Min/Max constrained size: $minMaxSize');
  results.add('Min/Max: $minMaxSize');

  // ========== Section 7: Dry Layout Comparison ==========
  print('--- Section 7: Dry Layout Comparison ---');

  final compChild = LayoutTestBox(requestedSize: Size(80, 60));
  final compConstraints = BoxConstraints(maxWidth: 100, maxHeight: 80);

  final dryResult = ChildLayoutHelper.dryLayoutChild(
    compChild,
    compConstraints,
  );
  final layoutResult = ChildLayoutHelper.layoutChild(
    compChild,
    compConstraints,
  );

  print('Dry result: $dryResult');
  print('Layout result: $layoutResult');
  print('Results match: ${dryResult == layoutResult}');
  results.add('Dry vs Layout match: ${dryResult == layoutResult}');

  // ========== Section 8: Zero Constraints ==========
  print('--- Section 8: Zero Constraints ---');

  final zeroChild = LayoutTestBox(requestedSize: Size(0, 0));
  final zeroConstraints = BoxConstraints.tight(Size.zero);

  final zeroSize = ChildLayoutHelper.layoutChild(zeroChild, zeroConstraints);
  print('Zero constrained size: $zeroSize');
  results.add('Zero constraints: $zeroSize');

  // ========== Section 9: Multiple Children ==========
  print('--- Section 9: Multiple Children ---');

  final children = [
    LayoutTestBox(requestedSize: Size(50, 30)),
    LayoutTestBox(requestedSize: Size(60, 40)),
    LayoutTestBox(requestedSize: Size(70, 50)),
  ];

  final childConstraints = BoxConstraints.loose(Size(100, 100));
  var totalHeight = 0.0;

  for (var i = 0; i < children.length; i++) {
    final childSize = ChildLayoutHelper.layoutChild(
      children[i],
      childConstraints,
    );
    print('Child $i size: $childSize');
    totalHeight += childSize.height;
  }

  results.add('Total height of ${children.length} children: $totalHeight');

  print('ChildLayoutHelper test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ChildLayoutHelper Tests',
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
