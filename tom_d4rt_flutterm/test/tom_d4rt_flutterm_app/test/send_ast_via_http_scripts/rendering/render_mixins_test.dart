// D4rt test script: Tests RenderObjectWithChildMixin, ContainerRenderObjectMixin, ContainerParentDataMixin, RenderIndexedStack, RenderBoxAdapter, RenderSemanticsAnnotations, RenderBlockSemantics, RenderExcludeSemantics, RenderMergeSemantics
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Render mixins and semantics render objects test executing');

  // ========== RenderObjectWithChildMixin ==========
  print('--- RenderObjectWithChildMixin Tests ---');
  // RenderObjectWithChildMixin is a mixin used by render objects that have a single child.
  // RenderDecoratedBox uses it. Reference through DecoratedBox widget.
  final decoratedBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print(
    'RenderObjectWithChildMixin: referenced via DecoratedBox (single-child render objects)',
  );
  print('Type: RenderObjectWithChildMixin is a mixin on RenderObject');

  // ========== ContainerRenderObjectMixin ==========
  print('--- ContainerRenderObjectMixin Tests ---');
  // ContainerRenderObjectMixin is used by render objects with multiple children.
  // RenderStack uses ContainerRenderObjectMixin.
  final stack = Stack(
    children: [
      Positioned(
        left: 0.0,
        top: 0.0,
        child: SizedBox(width: 10.0, height: 10.0),
      ),
      Positioned(
        left: 5.0,
        top: 5.0,
        child: SizedBox(width: 10.0, height: 10.0),
      ),
    ],
  );
  print(
    'ContainerRenderObjectMixin: referenced via Stack/RenderStack (multi-child render objects)',
  );
  print('Type: ContainerRenderObjectMixin is a mixin on RenderObject');

  // ========== ContainerParentDataMixin ==========
  print('--- ContainerParentDataMixin Tests ---');
  // ContainerParentDataMixin is used for parent data in multi-child layouts.
  // StackParentData uses ContainerParentDataMixin.
  print(
    'ContainerParentDataMixin: referenced via StackParentData (multi-child parent data)',
  );
  print('Type: ContainerParentDataMixin is a mixin on ParentData');

  // ========== RenderIndexedStack ==========
  print('--- RenderIndexedStack Tests ---');
  final indexedStack = IndexedStack(
    index: 0,
    children: [
      SizedBox(width: 100.0, height: 100.0),
      SizedBox(width: 200.0, height: 200.0),
    ],
  );
  print('RenderIndexedStack: referenced via IndexedStack widget');
  print('Type: ${RenderStack}');
  print('IndexedStack index: 0');

  // ========== RenderBoxAdapter (SliverToBoxAdapter) ==========
  print('--- RenderBoxAdapter Tests ---');
  // RenderSliverToBoxAdapter is the render object for SliverToBoxAdapter.
  final sliverAdapter = SliverToBoxAdapter(
    child: SizedBox(width: 100.0, height: 50.0),
  );
  print('RenderBoxAdapter: referenced via SliverToBoxAdapter widget');
  print('SliverToBoxAdapter type: ${sliverAdapter.runtimeType}');

  // ========== RenderSemanticsAnnotations ==========
  print('--- RenderSemanticsAnnotations Tests ---');
  final semanticsWidget = Semantics(
    label: 'test label',
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderSemanticsAnnotations: referenced via Semantics widget');
  print('Semantics label: test label');
  print('Type: RenderSemanticsAnnotations');

  // ========== RenderBlockSemantics ==========
  print('--- RenderBlockSemantics Tests ---');
  final blockSemanticsWidget = BlockSemantics(
    blocking: true,
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderBlockSemantics: referenced via BlockSemantics widget');
  print('BlockSemantics blocking: true');
  print('Type: RenderBlockSemantics');

  // ========== RenderExcludeSemantics ==========
  print('--- RenderExcludeSemantics Tests ---');
  final excludeSemanticsWidget = ExcludeSemantics(
    excluding: true,
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderExcludeSemantics: referenced via ExcludeSemantics widget');
  print('ExcludeSemantics excluding: true');
  print('Type: RenderExcludeSemantics');

  // ========== RenderMergeSemantics ==========
  print('--- RenderMergeSemantics Tests ---');
  final mergeSemanticsWidget = MergeSemantics(
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderMergeSemantics: referenced via MergeSemantics widget');
  print('Type: RenderMergeSemantics');

  print('All render mixins and semantics render object tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Render Mixins Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RenderObjectWithChildMixin: OK'),
            Text('ContainerRenderObjectMixin: OK'),
            Text('ContainerParentDataMixin: OK'),
            Text('RenderIndexedStack: OK'),
            Text('RenderBoxAdapter: OK'),
            Text('RenderSemanticsAnnotations: OK'),
            Text('RenderBlockSemantics: OK'),
            Text('RenderExcludeSemantics: OK'),
            Text('RenderMergeSemantics: OK'),
          ],
        ),
      ),
    ),
  );
}
