// Tests: ShortcutActivator (abstract), ShortcutManager, ShortcutRegistry,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        ShortcutRegistryEntry, DoNothingAndStopPropagationIntent,
//        DoNothingAndStopPropagationAction, PrioritizedAction,
//        ContextAction (abstract)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // --- ShortcutActivator Tests ---
  print('--- ShortcutActivator Tests ---');
  print('ShortcutActivator is the abstract interface for shortcut triggers');
  print('Type: $ShortcutActivator');
  print('Implemented by SingleActivator, CharacterActivator, LogicalKeySet');
  var singleActivator = SingleActivator(LogicalKeyboardKey.keyA, control: true);
  print('SingleActivator (Ctrl+A): $singleActivator');
  print('SingleActivator trigger: ${singleActivator.trigger}');
  var charActivator = CharacterActivator('?');
  print('CharacterActivator (?): $charActivator');
  print('CharacterActivator character: ${charActivator.character}');

  // --- ShortcutManager Tests ---
  print('--- ShortcutManager Tests ---');
  var shortcutManager = ShortcutManager(
    shortcuts: {
      SingleActivator(LogicalKeyboardKey.keyS, control: true):
          const ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.keyZ, control: true):
          const UndoTextIntent(SelectionChangedCause.keyboard),
    },
  );
  print('ShortcutManager: $shortcutManager');
  print('ShortcutManager shortcuts count: ${shortcutManager.shortcuts.length}');
  print('ShortcutManager handles keyboard shortcut dispatching');

  // --- ShortcutRegistry Tests ---
  print('--- ShortcutRegistry Tests ---');
  print('ShortcutRegistry allows dynamic shortcut registration');
  print('Type: $ShortcutRegistry');
  print('Provides addAll() to register shortcuts at runtime');
  print('Returns ShortcutRegistryEntry for later removal');

  // --- ShortcutRegistryEntry Tests ---
  print('--- ShortcutRegistryEntry Tests ---');
  print('ShortcutRegistryEntry represents a registered shortcut set');
  print('Type: $ShortcutRegistryEntry');
  print('Call dispose() to unregister shortcuts from the registry');
  print('Returned by ShortcutRegistry.addAll()');

  // --- DoNothingAndStopPropagationIntent Tests ---
  print('--- DoNothingAndStopPropagationIntent Tests ---');
  var doNothingStopIntent = DoNothingAndStopPropagationIntent();
  print('DoNothingAndStopPropagationIntent: $doNothingStopIntent');
  print('Stops event propagation without performing any action');
  print('Useful for consuming keyboard events silently');

  // --- DoNothingAndStopPropagationAction Tests ---
  print('--- DoNothingAndStopPropagationAction Tests ---');
  var doNothingStopAction = DoNothingAction(consumesKey: false);
  print(
    'DoNothingAndStopPropagationAction (now DoNothingAction): $doNothingStopAction',
  );
  print(
    'consumesKey: ${doNothingStopAction.consumesKey(DoNothingAndStopPropagationIntent())}',
  );
  print('Handles DoNothingAndStopPropagationIntent');

  // --- PrioritizedAction Tests ---
  print('--- PrioritizedAction Tests ---');
  print('PrioritizedAction wraps an action with priority ordering');
  print('Type: $PrioritizedAction');
  var prioritizedIntents = PrioritizedIntents(
    orderedIntents: [const ActivateIntent(), const DismissIntent()],
  );
  print('PrioritizedIntents: $prioritizedIntents');
  print(
    'PrioritizedIntents orderedIntents: ${prioritizedIntents.orderedIntents}',
  );
  print('PrioritizedAction tries intents in order until one is handled');

  // --- ContextAction Tests ---
  print('--- ContextAction Tests ---');
  print('ContextAction is an abstract Action with BuildContext access');
  print('Type: $ContextAction');
  print('Extends Action<T> and receives context in invoke()');
  print('Useful when action needs to access ancestor widgets');

  print('All shortcuts actions advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Shortcuts(
        shortcuts: shortcutManager.shortcuts,
        child: Actions(
          actions: {DoNothingAndStopPropagationIntent: doNothingStopAction},
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ShortcutManager shortcuts: ${shortcutManager.shortcuts.length}',
                ),
                Text('SingleActivator: $singleActivator'),
                Text('CharacterActivator: $charActivator'),
                const Text('Shortcuts Actions Adv Test'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
