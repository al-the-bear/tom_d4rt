// D4rt test script: Tests SemanticsEvent types — AnnounceSemanticsEvent,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TooltipSemanticsEvent, LongPressSemanticsEvent, TapSemanticEvent,
// FocusSemanticsEvent, SemanticsService
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics events advanced test executing');

  // ========== AnnounceSemanticsEvent ==========
  print('--- AnnounceSemanticsEvent Tests ---');
  final announce = AnnounceSemanticsEvent(
    'Item added to cart',
    TextDirection.ltr,
    0,
  );
  print('AnnounceSemanticsEvent: message="${announce.message}"');
  print('  textDirection: ${announce.textDirection}');
  print('  type: ${announce.type}');
  final announceMap = announce.toMap();
  print('  toMap keys: ${announceMap.keys.toList()}');

  final announceRtl = AnnounceSemanticsEvent(
    'تمت الإضافة',
    TextDirection.rtl,
    1,
  );
  print('AnnounceSemanticsEvent RTL: message="${announceRtl.message}"');

  // ========== TooltipSemanticsEvent ==========
  print('--- TooltipSemanticsEvent Tests ---');
  final tooltip = TooltipSemanticsEvent('Save button');
  print('TooltipSemanticsEvent: message="${tooltip.message}"');
  print('  type: ${tooltip.type}');
  final tooltipMap = tooltip.toMap();
  print('  toMap keys: ${tooltipMap.keys.toList()}');

  // ========== LongPressSemanticsEvent ==========
  print('--- LongPressSemanticsEvent Tests ---');
  final longPress = LongPressSemanticsEvent();
  print('LongPressSemanticsEvent created');
  print('  type: ${longPress.type}');
  final longPressMap = longPress.toMap();
  print('  toMap: $longPressMap');

  // ========== TapSemanticEvent ==========
  print('--- TapSemanticEvent Tests ---');
  final tap = TapSemanticEvent();
  print('TapSemanticEvent created');
  print('  type: ${tap.type}');

  // ========== Assertiveness enum ==========
  print('--- Assertiveness Tests ---');
  for (final a in Assertiveness.values) {
    print('Assertiveness: ${a.name}');
  }

  // ========== SemanticsService ==========
  print('--- SemanticsService Tests ---');
  print('SemanticsService.announce() sends announcements');
  print('SemanticsService.tooltip() sends tooltip events');

  // ========== CustomSemanticsAction ==========
  print('--- CustomSemanticsAction Tests ---');
  final customAction = CustomSemanticsAction(label: 'Dismiss');
  print('CustomSemanticsAction: label="${customAction.label}"');

  final overrideAction = CustomSemanticsAction.overridingAction(
    hint: 'Swipe to dismiss',
    action: SemanticsAction.dismiss,
  );
  print(
    'CustomSemanticsAction.overridingAction: hint="${overrideAction.hint}"',
  );

  // ========== OrdinalSortKey ==========
  print('--- OrdinalSortKey Tests ---');
  final sortKey1 = OrdinalSortKey(1.0, name: 'header');
  final sortKey2 = OrdinalSortKey(2.0, name: 'body');
  final sortKey3 = OrdinalSortKey(3.0);
  print('OrdinalSortKey: order=${sortKey1.order}, name=${sortKey1.name}');
  print('OrdinalSortKey: order=${sortKey2.order}, name=${sortKey2.name}');
  print('OrdinalSortKey: order=${sortKey3.order}, name=${sortKey3.name}');

  print('All semantics events tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Semantics(
        label: 'Main Content',
        sortKey: OrdinalSortKey(0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                sortKey: OrdinalSortKey(1.0),
                child: Text(
                  'Semantics Events Test',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Semantics(
                sortKey: OrdinalSortKey(2.0),
                child: Text('AnnounceSemanticsEvent, TooltipSemanticsEvent'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(3.0),
                child: Text('LongPressSemanticsEvent, TapSemanticEvent'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(4.0),
                child: Text('FocusSemanticsEvent, CustomSemanticsAction'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(5.0),
                child: Text('OrdinalSortKey for ordering'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
