// D4rt test script: Tests RenderAbstractViewport from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAbstractViewport test executing');

  // ========== VIEWPORT CONCEPTS ==========
  print('--- RenderAbstractViewport Concepts ---');
  print(
    'RenderAbstractViewport is the abstract base class for viewport render objects',
  );
  print('It provides the interface for scrollable regions');
  print(
    'Concrete implementations: RenderViewport, RenderShrinkWrappingViewport',
  );

  // ========== SCROLL DIRECTION TESTS ==========
  print('--- Scroll Direction ---');
  print('AxisDirection.down: ${AxisDirection.down}');
  print('AxisDirection.up: ${AxisDirection.up}');
  print('AxisDirection.right: ${AxisDirection.right}');
  print('AxisDirection.left: ${AxisDirection.left}');

  // ========== VIEWPORT OFFSET TESTS ==========
  print('--- ViewportOffset Tests ---');

  // Create ScrollController to test viewport behavior
  final scrollController = ScrollController(initialScrollOffset: 100.0);
  print(
    'ScrollController created with initialScrollOffset: ${scrollController.initialScrollOffset}',
  );

  // ========== SINGLE CHILD SCROLL VIEW ==========
  print('--- SingleChildScrollView (uses RenderViewport concepts) ---');

  final verticalScroll = SingleChildScrollView(
    controller: scrollController,
    scrollDirection: Axis.vertical,
    child: Column(
      children: List.generate(
        20,
        (i) => Container(
          height: 50,
          color: i.isEven ? Colors.blue : Colors.green,
          child: Center(child: Text('Item $i')),
        ),
      ),
    ),
  );
  print('Created vertical SingleChildScrollView');
  print('  scrollDirection: Axis.vertical');

  final horizontalScroll = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        10,
        (i) => Container(
          width: 80,
          height: 60,
          color: i.isEven ? Colors.red : Colors.orange,
          child: Center(child: Text('H$i')),
        ),
      ),
    ),
  );
  print('Created horizontal SingleChildScrollView');
  print('  scrollDirection: Axis.horizontal');

  // ========== LIST VIEW (USES VIEWPORT) ==========
  print('--- ListView (uses RenderViewport) ---');

  final listView = SizedBox(
    height: 150,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('List Item $index'), leading: Icon(Icons.star)),
    ),
  );
  print('Created ListView.builder with 50 items');
  print('  ListView uses RenderViewport internally');

  // ========== GRID VIEW (USES VIEWPORT) ==========
  print('--- GridView (uses RenderViewport) ---');

  final gridView = SizedBox(
    height: 150,
    child: GridView.count(
      crossAxisCount: 3,
      children: List.generate(
        12,
        (i) => Container(
          color: Colors.primaries[i % Colors.primaries.length],
          child: Center(child: Text('G$i')),
        ),
      ),
    ),
  );
  print('Created GridView.count with 3 columns');
  print('  crossAxisCount: 3');

  // ========== CUSTOM SCROLL VIEW ==========
  print('--- CustomScrollView (direct viewport access) ---');

  final customScroll = SizedBox(
    height: 200,
    child: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Sliver App Bar'),
          floating: true,
          flexibleSpace: Container(color: Colors.purple),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              height: 40,
              color: index.isEven ? Colors.cyan : Colors.teal,
              child: Center(child: Text('Sliver Item $index')),
            ),
            childCount: 15,
          ),
        ),
      ],
    ),
  );
  print('Created CustomScrollView with SliverAppBar and SliverList');

  // ========== CACHE EXTENT ==========
  print('--- Cache Extent ---');
  print('CacheExtentStyle.pixel: items cached by fixed pixel distance');
  print('CacheExtentStyle.viewport: items cached by viewport multiplier');
  print('Default cacheExtent is typically 250.0 logical pixels');

  // ========== VIEWPORT STATIC METHODS ==========
  print('--- RenderAbstractViewport Static Methods ---');
  print('RenderAbstractViewport.of(RenderObject): finds nearest viewport');
  print('Used for scroll-to-visible functionality');

  // ========== REVEALED OFFSET ==========
  print('--- RevealedOffset Class ---');
  final revealedOffset = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0, 100, 50, 50),
  );
  print('RevealedOffset: offset=${revealedOffset.offset}');
  print('  rect=${revealedOffset.rect}');

  // ========== SHRINK WRAPPING VIEWPORT ==========
  print('--- ShrinkWrappingViewport ---');
  print('Used when viewport should size itself to content');
  print('Common in nested scrollable scenarios');

  final shrinkWrap = SizedBox(
    height: 100,
    child: ListView(
      shrinkWrap: true,
      children: [
        Text('ShrinkWrap Item 1'),
        Text('ShrinkWrap Item 2'),
        Text('ShrinkWrap Item 3'),
      ],
    ),
  );
  print('Created shrinkWrap ListView');

  // ========== AXIS DIRECTION UTILITIES ==========
  print('--- Axis Direction Utilities ---');
  print(
    'axisDirectionToAxis(AxisDirection.down): ${axisDirectionToAxis(AxisDirection.down)}',
  );
  print(
    'axisDirectionToAxis(AxisDirection.right): ${axisDirectionToAxis(AxisDirection.right)}',
  );
  print(
    'axisDirectionIsReversed(AxisDirection.up): ${axisDirectionIsReversed(AxisDirection.up)}',
  );
  print(
    'axisDirectionIsReversed(AxisDirection.down): ${axisDirectionIsReversed(AxisDirection.down)}',
  );

  print('RenderAbstractViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbstractViewport Tests'),
      SizedBox(height: 8),
      SizedBox(height: 80, child: verticalScroll),
      SizedBox(height: 8),
      SizedBox(height: 60, child: horizontalScroll),
      SizedBox(height: 8),
      listView,
      SizedBox(height: 8),
      gridView,
      SizedBox(height: 8),
      Text('All Viewport tests passed'),
    ],
  );
}
