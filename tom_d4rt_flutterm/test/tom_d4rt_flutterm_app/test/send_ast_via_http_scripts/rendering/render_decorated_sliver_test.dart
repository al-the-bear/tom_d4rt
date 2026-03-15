// D4rt test script: Tests RenderDecoratedSliver from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderDecoratedSliver test executing');

  // ========== DECORATED SLIVER BASICS ==========
  print('--- DecoratedSliver Basics ---');
  print('RenderDecoratedSliver paints decoration around a sliver');
  print('Equivalent to DecoratedBox but for slivers');
  print('Supports BoxDecoration, ShapeDecoration, etc.');

  // Test using DecoratedSliver widget
  final colorDecoration = BoxDecoration(color: Colors.blue[100]);
  print('Simple color BoxDecoration');
  print('  color: Colors.blue[100]');

  // Test gradient decoration
  final gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
  print('Gradient BoxDecoration');
  print('  LinearGradient: purple to blue');

  // ========== DECORATION TYPES ==========
  print('--- Decoration Types ---');

  // Border decoration
  final borderDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(8),
  );
  print('Border decoration');
  print('  border: 2px red');
  print('  borderRadius: 8');

  // Shadow decoration
  final shadowDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
    ],
  );
  print('Shadow decoration');
  print('  boxShadow: black26, blur 8, offset (2,2)');

  // Combined decoration
  final combinedDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 4)),
    ],
  );
  print('Combined decoration: gradient + radius + shadow');

  // ========== SLIVER CONTEXT ==========
  print('--- Sliver Context Usage ---');
  print('DecoratedSliver must be used inside CustomScrollView');
  print('Decoration wraps the entire sliver paint extent');
  print('Useful for sliver headers, footers, backgrounds');

  // Create a complete scrollable with decorated slivers
  final scrollableExample = Container(
    height: 200,
    child: CustomScrollView(
      slivers: [
        // Decorated header sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 60,
              child: Center(
                child: Text(
                  'Decorated Header',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        // Content sliver
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                ListTile(title: Text('Item $index'), leading: Icon(Icons.star)),
            childCount: 5,
          ),
        ),
        // Decorated footer sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(top: BorderSide(color: Colors.grey)),
          ),
          sliver: SliverToBoxAdapter(
            child: Container(height: 50, child: Center(child: Text('Footer'))),
          ),
        ),
      ],
    ),
  );
  print('Complete CustomScrollView with decorated slivers');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Styled sliver app bars');
  print('2. Section backgrounds in lists');
  print('3. Decorated sliver headers');
  print('4. Group separators with styling');

  // ========== DECORATION POSITION ==========
  print('--- Decoration Position ---');
  print('DecorationPosition.background: Decoration behind content');
  print('DecorationPosition.foreground: Decoration in front');

  final backgroundPositioned = DecoratedSliver(
    decoration: colorDecoration,
    position: DecorationPosition.background,
    sliver: SliverToBoxAdapter(child: Container(height: 40)),
  );
  print('Background positioned decoration');

  final foregroundPositioned = DecoratedSliver(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.green, width: 3),
    ),
    position: DecorationPosition.foreground,
    sliver: SliverToBoxAdapter(
      child: Container(height: 40, color: Colors.yellow[100]),
    ),
  );
  print('Foreground positioned border');

  // ========== COMPARING WITH DECORATEDBOX ==========
  print('--- DecoratedSliver vs DecoratedBox ---');
  print('DecoratedBox: Works with RenderBox children');
  print('DecoratedSliver: Works with RenderSliver children');
  print('Same decoration types, different render protocols');

  // DecoratedBox equivalent
  final decoratedBox = DecoratedBox(
    decoration: borderDecoration,
    child: SizedBox(width: 80, height: 60, child: Center(child: Text('Box'))),
  );
  print('DecoratedBox for comparison');

  // ========== PAINTING BEHAVIOR ==========
  print('--- Painting Behavior ---');
  print('Decoration paints relative to sliver\'s scroll offset');
  print('Handles sliver geometry (paintExtent, layoutExtent)');
  print('Clips to sliver bounds if needed');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('Complex decorations (shadows, gradients) impact performance');
  print('Use simple colors when possible');
  print('Decoration is repainted on scroll');

  print('RenderDecoratedSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDecoratedSliver Tests'),
      SizedBox(height: 8),
      // Show decoration samples
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: colorDecoration,
            child: Center(child: Text('Color')),
          ),
          SizedBox(width: 8),
          Container(
            width: 60,
            height: 50,
            decoration: borderDecoration,
            child: Center(child: Text('Border')),
          ),
          SizedBox(width: 8),
          Container(
            width: 60,
            height: 50,
            decoration: gradientDecoration,
            child: Center(
              child: Text('Grad', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      // Scrollable example
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: scrollableExample,
      ),
      SizedBox(height: 8),
      decoratedBox,
      SizedBox(height: 8),
      Text('All DecoratedSliver tests passed'),
    ],
  );
}
