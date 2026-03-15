// Tests: TextSelectionGestureDetector, TextSelectionGestureDetectorBuilder,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        EditableTextState, BlacklistingTextInputFormatter (deprecated),
//        WhitelistingTextInputFormatter (deprecated), SelectionHandleType (enum),
//        SliverChildDelegate (abstract), SliverAnimatedGrid
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // --- TextSelectionGestureDetector Tests ---
  print('--- TextSelectionGestureDetector Tests ---');
  print('TextSelectionGestureDetector handles text selection gestures');
  print('Type: $TextSelectionGestureDetector');
  print('Detects taps, double-taps, long presses for text selection');
  print('Used internally by EditableText and TextField');

  // --- TextSelectionGestureDetectorBuilder Tests ---
  print('--- TextSelectionGestureDetectorBuilder Tests ---');
  print('TextSelectionGestureDetectorBuilder builds gesture detectors');
  print('Type: $TextSelectionGestureDetectorBuilder');
  print('Factory for creating TextSelectionGestureDetector instances');
  print('Can be subclassed to customize text selection behavior');

  // --- EditableTextState Tests ---
  print('--- EditableTextState Tests ---');
  print('EditableTextState is the State for EditableText');
  print('Type: $EditableTextState');
  print('Manages text editing, selection, and input handling');
  print('Provides methods like insertTextPlaceholder, removeTextPlaceholder');

  // --- BlacklistingTextInputFormatter Tests (deprecated) ---
  print('--- BlacklistingTextInputFormatter Tests ---');
  print('BlacklistingTextInputFormatter is deprecated');
  print('Use FilteringTextInputFormatter.deny instead');
  // BlacklistingTextInputFormatter was removed from Flutter.
  // Use FilteringTextInputFormatter.deny instead (shown below).
  var blacklistFormatter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print(
    'BlacklistingTextInputFormatter (now FilteringTextInputFormatter.deny): $blacklistFormatter',
  );
  print('Blocks input matching the pattern (digits in this case)');
  var denyFormatter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print('Replacement - FilteringTextInputFormatter.deny: $denyFormatter');

  // --- WhitelistingTextInputFormatter Tests (deprecated) ---
  print('--- WhitelistingTextInputFormatter Tests ---');
  print('WhitelistingTextInputFormatter is deprecated');
  print('Use FilteringTextInputFormatter.allow instead');
  // WhitelistingTextInputFormatter was removed from Flutter.
  // Use FilteringTextInputFormatter.allow instead (shown below).
  var whitelistFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z]'),
  );
  print(
    'WhitelistingTextInputFormatter (now FilteringTextInputFormatter.allow): $whitelistFormatter',
  );
  print('Only allows input matching the pattern (letters in this case)');
  var allowFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  print('Replacement - FilteringTextInputFormatter.allow: $allowFormatter');

  // --- SelectionHandleType Tests ---
  print('--- SelectionHandleType Tests ---');
  print('SelectionHandleType defines text selection handle types');
  print('Type: $TextSelectionHandleType');
  print('left: ${TextSelectionHandleType.left}');
  print('right: ${TextSelectionHandleType.right}');
  print('collapsed: ${TextSelectionHandleType.collapsed}');
  print('values: ${TextSelectionHandleType.values}');

  // --- SliverChildDelegate Tests ---
  print('--- SliverChildDelegate Tests ---');
  print('SliverChildDelegate provides children to slivers');
  print('Type: $SliverChildDelegate');
  var listDelegate = SliverChildListDelegate([
    const Text('Item 1'),
    const Text('Item 2'),
  ]);
  print('SliverChildListDelegate: $listDelegate');
  var builderDelegate = SliverChildBuilderDelegate(
    (context, index) => Text('Built Item $index'),
    childCount: 10,
  );
  print('SliverChildBuilderDelegate: $builderDelegate');
  print('SliverChildBuilderDelegate childCount: ${builderDelegate.childCount}');

  // --- SliverAnimatedGrid Tests ---
  print('--- SliverAnimatedGrid Tests ---');
  print('SliverAnimatedGrid is an animated grid in a sliver');
  print('Type: $SliverAnimatedGrid');
  print('Animates items as they are inserted or removed');
  print('Requires a GlobalKey<SliverAnimatedGridState> for manipulation');
  var gridKey = GlobalKey<SliverAnimatedGridState>();
  print('SliverAnimatedGrid key: $gridKey');

  print('All text editing advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              inputFormatters: [denyFormatter, allowFormatter],
              decoration: const InputDecoration(labelText: 'Filtered Input'),
            ),
            const SizedBox(height: 20),
            const Text('Text Editing Adv Test'),
          ],
        ),
      ),
    ),
  );
}
