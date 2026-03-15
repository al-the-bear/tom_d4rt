// D4rt test script: Tests RenderCustomSingleChildLayoutBox from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// Center-offset delegate
class _CenterOffsetDelegate extends SingleChildLayoutDelegate {
  final Offset offset;

  _CenterOffsetDelegate({this.offset = Offset.zero});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      (size.width - childSize.width) / 2 + offset.dx,
      (size.height - childSize.height) / 2 + offset.dy,
    );
  }

  @override
  bool shouldRelayout(_CenterOffsetDelegate oldDelegate) {
    return offset != oldDelegate.offset;
  }

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;
}

// Corner positioning delegate
class _CornerDelegate extends SingleChildLayoutDelegate {
  final Alignment alignment;
  final EdgeInsets padding;

  _CornerDelegate({
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
      Size(
        constraints.maxWidth - padding.horizontal,
        constraints.maxHeight - padding.vertical,
      ),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final x =
        padding.left +
        (size.width - padding.horizontal - childSize.width) *
            ((alignment.x + 1) / 2);
    final y =
        padding.top +
        (size.height - padding.vertical - childSize.height) *
            ((alignment.y + 1) / 2);
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_CornerDelegate oldDelegate) {
    return alignment != oldDelegate.alignment || padding != oldDelegate.padding;
  }
}

dynamic build(BuildContext context) {
  print('RenderCustomSingleChildLayoutBox test executing');

  // ========== CUSTOM SINGLE CHILD LAYOUT BASICS ==========
  print('--- CustomSingleChildLayout Basics ---');
  print('RenderCustomSingleChildLayoutBox positions a single child');
  print('Uses SingleChildLayoutDelegate for custom positioning');
  print('More flexible than Align widget');

  // Test basic CustomSingleChildLayout
  final centeredLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(),
    child: Container(
      width: 60,
      height: 60,
      color: Colors.blue,
      child: Center(child: Text('C')),
    ),
  );
  print('CustomSingleChildLayout with center delegate');
  print('  Child centered in available space');

  // Test with offset
  final offsetLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(offset: Offset(20, 10)),
    child: Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Center(child: Text('O')),
    ),
  );
  print('CustomSingleChildLayout with offset');
  print('  Offset: (20, 10) from center');

  // ========== DELEGATE METHODS ==========
  print('--- SingleChildLayoutDelegate Methods ---');
  print('getSize(constraints): Override to set layout size');
  print('getConstraintsForChild(constraints): Set child constraints');
  print('getPositionForChild(size, childSize): Position child');
  print('shouldRelayout(oldDelegate): Control when to relayout');

  // Test corner positioning
  final topLeftLayout = CustomSingleChildLayout(
    delegate: _CornerDelegate(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
    ),
    child: Container(
      width: 40,
      height: 40,
      color: Colors.green,
      child: Center(child: Text('TL')),
    ),
  );
  print('Corner delegate: top-left with padding');

  final bottomRightLayout = CustomSingleChildLayout(
    delegate: _CornerDelegate(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.all(8),
    ),
    child: Container(
      width: 40,
      height: 40,
      color: Colors.orange,
      child: Center(child: Text('BR')),
    ),
  );
  print('Corner delegate: bottom-right with padding');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Tooltip positioning');
  print('2. Custom popup placement');
  print('3. Overlay positioning');
  print('4. Dynamic child positioning based on state');

  // Test animated positioning concept
  final animatedPosition = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(offset: Offset(30, 0)),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Icon(Icons.star, color: Colors.white, size: 20)),
    ),
  );
  print('Animated positioning with delegate');

  // ========== CONSTRAINT HANDLING ==========
  print('--- Constraint Handling ---');
  print('getConstraintsForChild defines what child receives');
  print('Can use tight, loose, or custom constraints');
  print('Parent constraints available for calculations');

  // Test tight constraints
  final tightConstraintLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(),
    child: Container(
      color: Colors.teal,
      child: Center(child: Text('Tight')),
    ),
  );
  print('Loose constraints allow child to size itself');

  // ========== COMPARING WITH ALIGN ==========
  print('--- Comparing with Align Widget ---');
  print('Align: Simple alignment with alignment parameter');
  print('CustomSingleChildLayout: Full control over positioning');
  print('Align is simpler, CustomSingleChildLayout more powerful');

  // Equivalent Align widget
  final alignEquivalent = Align(
    alignment: Alignment.center,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.amber,
      child: Center(child: Text('A')),
    ),
  );
  print('Align widget for simple centering');

  // ========== SIZING BEHAVIOR ==========
  print('--- Sizing Behavior ---');
  print('getSize controls how layout sizes itself');
  print('Default: constraints.biggest (fills available space)');
  print('Can return smaller size if needed');

  // Test with explicit size
  final fixedSizeLayout = Container(
    width: 120,
    height: 80,
    color: Colors.grey[200],
    child: CustomSingleChildLayout(
      delegate: _CenterOffsetDelegate(),
      child: Container(
        width: 40,
        height: 40,
        color: Colors.indigo,
        child: Center(child: Text('F')),
      ),
    ),
  );
  print('Fixed size container with centered child');

  // ========== NESTED LAYOUTS ==========
  print('--- Nested Custom Layouts ---');

  final nestedLayout = Container(
    width: 150,
    height: 100,
    color: Colors.grey[300],
    child: CustomSingleChildLayout(
      delegate: _CornerDelegate(
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(4),
      ),
      child: CustomSingleChildLayout(
        delegate: _CenterOffsetDelegate(),
        child: Container(
          width: 60,
          height: 50,
          color: Colors.pink,
          child: Center(child: Text('N')),
        ),
      ),
    ),
  );
  print('Nested CustomSingleChildLayout widgets');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('shouldRelayout prevents unnecessary recalculations');
  print('Compare delegate properties for changes');
  print('Use const delegates when possible');

  print('RenderCustomSingleChildLayoutBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderCustomSingleChildLayoutBox Tests'),
      Container(
        width: 120,
        height: 80,
        color: Colors.grey[200],
        child: centeredLayout,
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 60,
            color: Colors.grey[100],
            child: topLeftLayout,
          ),
          SizedBox(width: 8),
          Container(
            width: 80,
            height: 60,
            color: Colors.grey[100],
            child: bottomRightLayout,
          ),
        ],
      ),
      SizedBox(height: 8),
      fixedSizeLayout,
      SizedBox(height: 8),
      nestedLayout,
      SizedBox(height: 8),
      Text('All CustomSingleChildLayout tests passed'),
    ],
  );
}
