// D4rt test script: Tests PipelineManifold from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Test implementation of PipelineManifold
class TestPipelineManifold extends PipelineManifold {
  final Set<Listenable> _semanticsListeners = {};

  @override
  void requestVisualUpdate() {
    print('  requestVisualUpdate called');
  }

  @override
  void addSemanticsListener(Listenable listener) {
    _semanticsListeners.add(listener);
    print(
      '  addSemanticsListener: total listeners = ${_semanticsListeners.length}',
    );
  }

  @override
  void removeSemanticsListener(Listenable listener) {
    _semanticsListeners.remove(listener);
    print(
      '  removeSemanticsListener: total listeners = ${_semanticsListeners.length}',
    );
  }

  int get listenerCount => _semanticsListeners.length;
}

/// A simple test Listenable for testing semantics listeners
class TestListenable extends ChangeNotifier {
  final String name;
  TestListenable(this.name);
}

dynamic build(BuildContext context) {
  print('PipelineManifold test executing');

  // ========== Basic PipelineManifold ==========
  print('--- Basic PipelineManifold ---');
  final manifold = TestPipelineManifold();
  print('  created: ${manifold.runtimeType}');
  print('  is PipelineManifold: ${manifold is PipelineManifold}');

  // ========== requestVisualUpdate method ==========
  print('--- requestVisualUpdate method ---');
  manifold.requestVisualUpdate();
  manifold.requestVisualUpdate();
  manifold.requestVisualUpdate();
  print('  requestVisualUpdate called 3 times');

  // ========== addSemanticsListener method ==========
  print('--- addSemanticsListener method ---');
  final listener1 = TestListenable('listener1');
  manifold.addSemanticsListener(listener1);

  final listener2 = TestListenable('listener2');
  manifold.addSemanticsListener(listener2);

  final listener3 = TestListenable('listener3');
  manifold.addSemanticsListener(listener3);

  print('  listener count after adding 3: ${manifold.listenerCount}');

  // ========== removeSemanticsListener method ==========
  print('--- removeSemanticsListener method ---');
  manifold.removeSemanticsListener(listener2);
  print('  listener count after removing 1: ${manifold.listenerCount}');

  manifold.removeSemanticsListener(listener1);
  print('  listener count after removing 2: ${manifold.listenerCount}');

  // ========== Multiple manifolds ==========
  print('--- Multiple manifolds ---');
  final manifold2 = TestPipelineManifold();
  final manifold3 = TestPipelineManifold();
  print('  manifold2: ${manifold2.runtimeType}');
  print('  manifold3: ${manifold3.runtimeType}');

  // Add listeners to multiple manifolds
  final sharedListener = TestListenable('shared');
  manifold2.addSemanticsListener(sharedListener);
  manifold3.addSemanticsListener(sharedListener);
  print('  shared listener added to manifold2 and manifold3');
  print('  manifold2 listener count: ${manifold2.listenerCount}');
  print('  manifold3 listener count: ${manifold3.listenerCount}');

  // ========== Adding same listener multiple times ==========
  print('--- Adding same listener multiple times ---');
  final newManifold = TestPipelineManifold();
  final sameListener = TestListenable('same');
  newManifold.addSemanticsListener(sameListener);
  newManifold.addSemanticsListener(sameListener); // Add again
  print(
    '  added same listener twice, count: ${newManifold.listenerCount}',
  ); // Set prevents duplicates

  // ========== Request visual update multiple times ==========
  print('--- Multiple visual update requests ---');
  final updateManifold = TestPipelineManifold();
  for (int i = 0; i < 5; i++) {
    updateManifold.requestVisualUpdate();
  }
  print('  requested visual update 5 times');

  // ========== Many listeners ==========
  print('--- Many listeners ---');
  final manyListenersManifold = TestPipelineManifold();
  final listeners = List.generate(10, (i) => TestListenable('listener_$i'));
  for (final l in listeners) {
    manyListenersManifold.addSemanticsListener(l);
  }
  print('  added 10 listeners, count: ${manyListenersManifold.listenerCount}');

  // Remove half
  for (int i = 0; i < 5; i++) {
    manyListenersManifold.removeSemanticsListener(listeners[i]);
  }
  print('  removed 5 listeners, count: ${manyListenersManifold.listenerCount}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  manifold.runtimeType: ${manifold.runtimeType}');
  print('  manifold2.runtimeType: ${manifold2.runtimeType}');
  print('  listener1.runtimeType: ${listener1.runtimeType}');

  print('PipelineManifold test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PipelineManifold Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${manifold.runtimeType}'),
          Text('Interface: PipelineManifold'),
          SizedBox(height: 8.0),
          Text('Methods:'),
          Text('  - requestVisualUpdate()'),
          Text('  - addSemanticsListener(Listenable)'),
          Text('  - removeSemanticsListener(Listenable)'),
          SizedBox(height: 8.0),
          Text('Test results:'),
          Text('  manifold listener count: ${manifold.listenerCount}'),
          Text('  manifold2 listener count: ${manifold2.listenerCount}'),
          Text('  manifold3 listener count: ${manifold3.listenerCount}'),
          Text('  manyListeners count: ${manyListenersManifold.listenerCount}'),
          SizedBox(height: 8.0),
          Text('Purpose: Manages rendering pipeline'),
          Text('Used for semantics and visual updates'),
        ],
      ),
    ),
  );
}
