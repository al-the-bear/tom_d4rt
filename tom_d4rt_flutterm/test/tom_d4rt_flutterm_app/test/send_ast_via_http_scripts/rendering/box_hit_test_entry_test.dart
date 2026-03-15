// D4rt test script: Tests BoxHitTestEntry from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Simple test RenderBox for hit testing
class TestRenderBox extends RenderBox {
  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (size.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}

dynamic build(BuildContext context) {
  print('BoxHitTestEntry test executing');
  final results = <String>[];

  // ========== Section 1: Create Test RenderBox ==========
  print('--- Section 1: Create Test RenderBox ---');

  final renderBox = TestRenderBox();
  // Simulate layout
  renderBox.layout(BoxConstraints.tight(Size(200, 100)));

  print('Created TestRenderBox with size: ${renderBox.size}');
  results.add('RenderBox size: ${renderBox.size}');

  // ========== Section 2: Create BoxHitTestEntry ==========
  print('--- Section 2: Create BoxHitTestEntry ---');

  final localPosition = Offset(50, 30);
  final entry = BoxHitTestEntry(renderBox, localPosition);

  print('Created BoxHitTestEntry');
  print('Entry target: ${entry.target.runtimeType}');
  print('Entry localPosition: ${entry.localPosition}');
  results.add('Entry localPosition: ${entry.localPosition}');

  // ========== Section 3: Target Properties ==========
  print('--- Section 3: Target Properties ---');

  // Access the target (RenderBox)
  final target = entry.target;
  print('Target type: ${target.runtimeType}');
  print('Target is RenderBox: ${target is RenderBox}');
  results.add('Target is RenderBox: ${target is RenderBox}');

  // ========== Section 4: Local Position ==========
  print('--- Section 4: Local Position ---');

  // Test different local positions
  final positions = [Offset(0, 0), Offset(100, 50), Offset(199, 99)];

  for (final pos in positions) {
    final testEntry = BoxHitTestEntry(renderBox, pos);
    print('Entry at $pos: localPosition=${testEntry.localPosition}');
  }
  results.add('Tested ${positions.length} positions');

  // ========== Section 5: Hit Test Via RenderBox ==========
  print('--- Section 5: Hit Test Via RenderBox ---');

  final hitResult = BoxHitTestResult();
  final hitPosition = Offset(75, 25);

  final wasHit = renderBox.hitTest(hitResult, position: hitPosition);
  print('Hit test at $hitPosition: $wasHit');
  print('Result path length: ${hitResult.path.length}');

  if (hitResult.path.isNotEmpty) {
    final firstEntry = hitResult.path.first;
    print('First entry in path: ${firstEntry.runtimeType}');
    if (firstEntry is BoxHitTestEntry) {
      print('BoxHitTestEntry localPosition: ${firstEntry.localPosition}');
      results.add('Hit test entry position: ${firstEntry.localPosition}');
    }
  }

  // ========== Section 6: Outside Hit Test ==========
  print('--- Section 6: Outside Hit Test ---');

  final outsideResult = BoxHitTestResult();
  final outsidePosition = Offset(300, 200); // Outside the box

  final outsideHit = renderBox.hitTest(
    outsideResult,
    position: outsidePosition,
  );
  print('Hit test outside box at $outsidePosition: $outsideHit');
  print('Outside result path length: ${outsideResult.path.length}');
  results.add('Outside hit test: $outsideHit');

  // ========== Section 7: Entry ToString ==========
  print('--- Section 7: Entry ToString ---');

  final stringEntry = BoxHitTestEntry(renderBox, Offset(10, 20));
  final entryString = stringEntry.toString();
  print('Entry toString: $entryString');
  results.add('Entry has toString: ${entryString.isNotEmpty}');

  // ========== Section 8: Multiple Entries ==========
  print('--- Section 8: Multiple Entries ---');

  final multiResult = BoxHitTestResult();

  // Create multiple boxes
  final box1 = TestRenderBox()..layout(BoxConstraints.tight(Size(100, 100)));
  final box2 = TestRenderBox()..layout(BoxConstraints.tight(Size(100, 100)));

  box1.hitTest(multiResult, position: Offset(50, 50));
  box2.hitTest(multiResult, position: Offset(50, 50));

  print('Multiple hit test path length: ${multiResult.path.length}');
  var boxEntryCount = 0;
  for (final e in multiResult.path) {
    if (e is BoxHitTestEntry) {
      boxEntryCount++;
      print('  BoxHitTestEntry #$boxEntryCount: ${e.localPosition}');
    }
  }
  results.add('Multiple entries: $boxEntryCount BoxHitTestEntries');

  print('BoxHitTestEntry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BoxHitTestEntry Tests',
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
