// D4rt test script: Tests SelectionHandler from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('SelectionHandler test executing');

  // ========== SelectionHandler is a mixin - test via SelectableRegion ==========
  print('--- SelectionHandler overview ---');
  print('  SelectionHandler is a mixin for handling selection');
  print('  Applied to classes that participate in text selection');
  print('  Key methods: pushHandleLayers, dispatchSelectionEvent');

  // ========== SelectableRegion widget (uses SelectionHandler) ==========
  print('--- SelectableRegion widget ---');
  final focusNode = FocusNode();
  final selectionRegistrar = SelectionContainer.maybeOf(context);
  print('  FocusNode created: ${focusNode.runtimeType}');
  print('  SelectionRegistrar from context: $selectionRegistrar');

  // ========== SelectionRegistrar and SelectionRegistrant ==========
  print('--- Selection registration system ---');
  print('  SelectionRegistrar: manages selection registrants');
  print('  SelectionRegistrant: participates in selection');
  print('  SelectionHandler: handles selection events');

  // ========== Key selection-related types ==========
  print('--- Key selection types ---');
  print('  SelectionResult enum values:');
  for (final result in SelectionResult.values) {
    print('    ${result.name}: ${result.index}');
  }
  print('  Total result values: ${SelectionResult.values.length}');

  // ========== SelectionEvent types that handlers process ==========
  print('--- SelectionEvent types processed by handlers ---');
  final events = <SelectionEvent>[
    SelectAllSelectionEvent(),
    ClearSelectionEvent(),
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(10.0, 10.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(100.0, 100.0)),
    SelectWordSelectionEvent(globalPosition: Offset(50.0, 50.0)),
  ];
  print('  Event types:');
  for (final event in events) {
    print('    ${event.runtimeType}: type=${event.type}');
  }

  // ========== SelectionGeometry for handler state ==========
  print('--- SelectionGeometry states ---');
  final geometries = [
    (SelectionStatus.none, false, 'No selection'),
    (SelectionStatus.collapsed, false, 'Cursor only'),
    (SelectionStatus.uncollapsed, true, 'Has selection'),
  ];
  for (final (status, hasContent, desc) in geometries) {
    final geo = SelectionGeometry(status: status, hasContent: hasContent);
    print('    $desc: status=${geo.status}, hasContent=${geo.hasContent}');
  }

  // ========== LayerLink for selection handles ==========
  print('--- LayerLink for handles ---');
  final startHandleLink = LayerLink();
  final endHandleLink = LayerLink();
  print('  startHandleLink created: ${startHandleLink.runtimeType}');
  print('  endHandleLink created: ${endHandleLink.runtimeType}');
  print('  Links are used for positioning selection handles');

  // ========== Selection points ==========
  print('--- SelectionPoint for handle positions ---');
  final startPoint = SelectionPoint(
    localPosition: Offset(0.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  final endPoint = SelectionPoint(
    localPosition: Offset(100.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  final collapsedPoint = SelectionPoint(
    localPosition: Offset(50.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print(
    '  Start point: ${startPoint.localPosition}, handle: ${startPoint.handleType}',
  );
  print(
    '  End point: ${endPoint.localPosition}, handle: ${endPoint.handleType}',
  );
  print(
    '  Collapsed point: ${collapsedPoint.localPosition}, handle: ${collapsedPoint.handleType}',
  );

  // ========== TextSelectionHandleType ==========
  print('--- TextSelectionHandleType values ---');
  for (final handleType in TextSelectionHandleType.values) {
    print('    ${handleType.name}: ${handleType.index}');
  }

  // ========== SelectedContent from handlers ==========
  print('--- SelectedContent from handlers ---');
  final content = SelectedContent(plainText: 'Selected text from handler');
  print('  plainText: ${content.plainText}');
  print('  length: ${content.plainText.length}');

  // ========== Selection area and container ==========
  print('--- SelectionContainer overview ---');
  print('  SelectionContainer provides SelectionRegistrar');
  print('  Child widgets register to participate in selection');
  print('  SelectionHandler coordinates selection state');

  // ========== FocusNode for selection ==========
  print('--- FocusNode management ---');
  print('  focusNode.hasFocus: ${focusNode.hasFocus}');
  print('  focusNode.hasPrimaryFocus: ${focusNode.hasPrimaryFocus}');
  print('  focusNode.canRequestFocus: ${focusNode.canRequestFocus}');

  // ========== Cleanup ==========
  focusNode.dispose();
  print('  FocusNode disposed');

  print('SelectionHandler test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionHandler Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('SelectionHandler is a mixin'),
          Text('SelectionResult values: ${SelectionResult.values.length}'),
          Text('Event types tested: ${events.length}'),
          Text('Handle types: ${TextSelectionHandleType.values.length}'),
          Text('Start point handle: ${startPoint.handleType}'),
          Text('End point handle: ${endPoint.handleType}'),
          Text('Collapsed handle: ${collapsedPoint.handleType}'),
          Text('SelectedContent: ${content.plainText}'),
        ],
      ),
    ),
  );
}
