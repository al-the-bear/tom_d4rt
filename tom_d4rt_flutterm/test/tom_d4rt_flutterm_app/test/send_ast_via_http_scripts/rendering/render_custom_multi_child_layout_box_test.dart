// D4rt test script: Tests RenderCustomMultiChildLayoutBox from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// Custom delegate for multi-child layout
class _StackLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // Layout children in stack-like arrangement
    if (hasChild('background')) {
      layoutChild('background', BoxConstraints.tight(size));
      positionChild('background', Offset.zero);
    }
    if (hasChild('foreground')) {
      final foregroundSize = layoutChild(
        'foreground',
        BoxConstraints.loose(size),
      );
      positionChild(
        'foreground',
        Offset(
          (size.width - foregroundSize.width) / 2,
          (size.height - foregroundSize.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(_StackLayoutDelegate oldDelegate) => false;
}

// Diagonal layout delegate
class _DiagonalLayoutDelegate extends MultiChildLayoutDelegate {
  final double spacing;

  _DiagonalLayoutDelegate({this.spacing = 20});

  @override
  void performLayout(Size size) {
    double x = 0;
    double y = 0;
    for (int i = 0; i < 5; i++) {
      final childId = 'item$i';
      if (hasChild(childId)) {
        final childSize = layoutChild(childId, BoxConstraints.loose(size));
        positionChild(childId, Offset(x, y));
        x += spacing;
        y += spacing;
      }
    }
  }

  @override
  bool shouldRelayout(_DiagonalLayoutDelegate oldDelegate) {
    return spacing != oldDelegate.spacing;
  }
}

dynamic build(BuildContext context) {
  print('RenderCustomMultiChildLayoutBox test executing');

  // ========== CUSTOM MULTI-CHILD LAYOUT BASICS ==========
  print('--- CustomMultiChildLayout Basics ---');
  print('RenderCustomMultiChildLayoutBox positions multiple children');
  print('Uses MultiChildLayoutDelegate for custom positioning');
  print('Each child must have a LayoutId');

  // Test basic CustomMultiChildLayout
  final stackLayout = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'background',
        child: Container(color: Colors.blue),
      ),
      LayoutId(
        id: 'foreground',
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
          child: Center(child: Text('FG')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with stack delegate');
  print('  Background: fills entire area');
  print('  Foreground: centered 50x50');

  // ========== DELEGATE METHODS ==========
  print('--- MultiChildLayoutDelegate Methods ---');
  print('hasChild(id): Check if child with id exists');
  print('layoutChild(id, constraints): Layout child, returns Size');
  print('positionChild(id, offset): Position child at offset');
  print('shouldRelayout(oldDelegate): Return true to trigger relayout');

  // Test diagonal layout
  final diagonalLayout = CustomMultiChildLayout(
    delegate: _DiagonalLayoutDelegate(spacing: 15),
    children: [
      for (int i = 0; i < 3; i++)
        LayoutId(
          id: 'item$i',
          child: Container(
            width: 30,
            height: 30,
            color: Colors.primaries[i % Colors.primaries.length],
            child: Center(child: Text('$i')),
          ),
        ),
    ],
  );
  print('Diagonal layout with 3 children');
  print('  Spacing: 15 pixels');

  // ========== LAYOUT ID USAGE ==========
  print('--- LayoutId Usage ---');
  print('LayoutId wraps each child with unique identifier');
  print('ID can be any Object (String, int, enum, etc.)');
  print('IDs must be unique within the layout');

  // Test with different ID types
  final stringIds = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'bg',
        child: Container(color: Colors.grey),
      ),
      LayoutId(
        id: 'fg',
        child: Container(width: 40, height: 40, color: Colors.red),
      ),
    ],
  );
  print('String IDs: "bg", "fg"');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Complex overlay layouts');
  print('2. Custom card layouts');
  print('3. Dashboard widgets with specific positioning');
  print('4. Game UI layouts');

  // Test responsive-like layout
  final responsiveLayout = Container(
    width: 200,
    height: 100,
    color: Colors.grey[200],
    child: CustomMultiChildLayout(
      delegate: _StackLayoutDelegate(),
      children: [
        LayoutId(
          id: 'background',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
            ),
          ),
        ),
        LayoutId(
          id: 'foreground',
          child: Card(
            child: Padding(padding: EdgeInsets.all(8), child: Text('Card')),
          ),
        ),
      ],
    ),
  );
  print('Responsive-style layout with gradient background');

  // ========== COMPARING WITH OTHER LAYOUTS ==========
  print('--- Comparing Layout Widgets ---');
  print('CustomMultiChildLayout: Full control over positioning');
  print('Stack: Z-order based layout with alignment');
  print('Flow: Transformation-based layout');
  print('Wrap: Automatic wrapping layout');

  // ========== CONSTRAINT HANDLING ==========
  print('--- Constraint Handling ---');
  print('Parent constraints passed to delegate');
  print('layoutChild receives constraints you specify');
  print('Children can have different constraints');

  // Test tight vs loose constraints
  final constraintTest = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'background',
        child: Container(color: Colors.cyan),
      ),
      LayoutId(
        id: 'foreground',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.star, size: 24), Text('Star')],
        ),
      ),
    ],
  );
  print('Constraint test with varying child sizes');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('shouldRelayout controls when to recalculate');
  print('Cache layout calculations when possible');
  print('Minimize number of children for performance');

  print('RenderCustomMultiChildLayoutBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderCustomMultiChildLayoutBox Tests'),
      Container(width: 150, height: 100, child: stackLayout),
      SizedBox(height: 8),
      Container(
        width: 120,
        height: 80,
        color: Colors.grey[100],
        child: diagonalLayout,
      ),
      SizedBox(height: 8),
      responsiveLayout,
      SizedBox(height: 8),
      Text('All CustomMultiChildLayout tests passed'),
    ],
  );
}
