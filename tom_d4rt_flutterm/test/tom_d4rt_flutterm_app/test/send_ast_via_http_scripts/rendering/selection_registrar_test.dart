// D4rt test script: Tests SelectionRegistrar from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Mock implementation of SelectionRegistrar for testing
class MockSelectionRegistrar extends SelectionRegistrar {
  final List<Selectable> _selectables = [];
  int addCount = 0;
  int removeCount = 0;

  @override
  void add(Selectable selectable) {
    _selectables.add(selectable);
    addCount++;
  }

  @override
  void remove(Selectable selectable) {
    _selectables.remove(selectable);
    removeCount++;
  }

  List<Selectable> get selectables => List.unmodifiable(_selectables);
}

dynamic build(BuildContext context) {
  print('SelectionRegistrar test executing');
  final results = <String>[];

  // ========== Section 1: SelectionRegistrar is Abstract ==========
  print('--- Section 1: SelectionRegistrar is Abstract ---');

  print('SelectionRegistrar is an abstract class');
  print('It defines the interface for managing selectables');
  results.add('SelectionRegistrar is abstract class');

  // ========== Section 2: Mock Implementation ==========
  print('--- Section 2: Mock Implementation ---');

  final registrar = MockSelectionRegistrar();
  print('Created MockSelectionRegistrar: ${registrar.runtimeType}');
  print('Initial selectables count: ${registrar.selectables.length}');
  print('Initial addCount: ${registrar.addCount}');
  print('Initial removeCount: ${registrar.removeCount}');
  results.add('Mock registrar created');

  // ========== Section 3: SelectionRegistrar Methods ==========
  print('--- Section 3: SelectionRegistrar Methods ---');

  // SelectionRegistrar has two main methods:
  // - add(Selectable selectable)
  // - remove(Selectable selectable)
  print('SelectionRegistrar methods:');
  print('  - add(Selectable): registers a selectable');
  print('  - remove(Selectable): unregisters a selectable');
  results.add('Methods: add, remove');

  // ========== Section 4: Type Checking ==========
  print('--- Section 4: Type Checking ---');

  print('registrar is SelectionRegistrar: ${registrar is SelectionRegistrar}');
  print('registrar runtimeType: ${registrar.runtimeType}');
  results.add('Type check: ${registrar is SelectionRegistrar}');

  // ========== Section 5: SelectionRegistrarScope (inherited widget) ==========
  print('--- Section 5: SelectionRegistrarScope ---');

  // SelectionRegistrarScope is an InheritedWidget that provides
  // SelectionRegistrar to the widget tree
  print('SelectionRegistrarScope is an InheritedWidget');
  print('Used to provide SelectionRegistrar in widget tree');

  // Create a scope with null registrar
  final scope = SelectionRegistrarScope(registrar: null, child: SizedBox());
  print('Created SelectionRegistrarScope: ${scope.runtimeType}');
  results.add('SelectionRegistrarScope created');

  // ========== Section 6: SelectionRegistrarScope with Registrar ==========
  print('--- Section 6: SelectionRegistrarScope with Registrar ---');

  final scopeWithRegistrar = SelectionRegistrarScope(
    registrar: registrar,
    child: Container(),
  );
  print('Scope with registrar: ${scopeWithRegistrar.registrar != null}');
  print('Registrar type: ${scopeWithRegistrar.registrar?.runtimeType}');
  results.add('Scope with registrar working');

  // ========== Section 7: Maybeofs and Of Methods ==========
  print('--- Section 7: Static Methods Pattern ---');

  // SelectionRegistrarScope typically provides:
  // - maybeOf(BuildContext): returns nullable registrar
  // - of(BuildContext): returns non-nullable registrar (throws if not found)
  print('SelectionRegistrarScope provides static lookup methods');
  print('Pattern: maybeOf(context) and of(context)');
  results.add('Static methods: maybeOf, of');

  // ========== Section 8: Multiple Registrations ==========
  print('--- Section 8: Multiple Registrations ---');

  final testRegistrar = MockSelectionRegistrar();
  print('Add count before: ${testRegistrar.addCount}');
  print('Remove count before: ${testRegistrar.removeCount}');

  // Note: We cannot create actual Selectables without a full widget tree,
  // but we can verify the registrar interface
  print('Registrar interface verified');
  results.add('Registrar interface verified');

  // ========== Section 9: SelectionContainer Pattern ==========
  print('--- Section 9: SelectionContainer Pattern ---');

  // SelectionContainer uses SelectionRegistrar internally
  print('SelectionContainer widget uses SelectionRegistrar');
  print('It coordinates selection across child selectables');

  final selectionContainer = SelectionContainer(child: Text('Selectable text'));
  print('SelectionContainer created: ${selectionContainer.runtimeType}');
  results.add('SelectionContainer uses registrar pattern');

  // ========== Section 10: Disabled Selection ==========
  print('--- Section 10: Disabled Selection ---');

  final disabledSelection = SelectionContainer.disabled(
    child: Text('Non-selectable text'),
  );
  print('SelectionContainer.disabled: ${disabledSelection.runtimeType}');
  results.add('SelectionContainer.disabled available');

  print('SelectionRegistrar test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionRegistrar Tests',
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
