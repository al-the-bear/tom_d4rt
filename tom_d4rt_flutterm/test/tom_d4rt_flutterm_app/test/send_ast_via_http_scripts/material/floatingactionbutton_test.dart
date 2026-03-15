// D4rt test script: Tests FloatingActionButton widget from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingActionButton test executing');

  // Test basic FAB
  final basicFab = FloatingActionButton(
    onPressed: () {
      print('FAB pressed');
    },
    child: Icon(Icons.add),
  );
  print('Basic FloatingActionButton created');

  // Test FAB with tooltip
  final tooltipFab = FloatingActionButton(
    onPressed: () {},
    tooltip: 'Add Item',
    child: Icon(Icons.add),
  );
  print('FAB with tooltip created');

  // Test FAB.small
  final smallFab = FloatingActionButton.small(
    onPressed: () {},
    child: Icon(Icons.add),
  );
  print('FloatingActionButton.small created');

  // Test FAB.large
  final largeFab = FloatingActionButton.large(
    onPressed: () {},
    child: Icon(Icons.add),
  );
  print('FloatingActionButton.large created');

  // Test FAB.extended
  final extendedFab = FloatingActionButton.extended(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add Item'),
  );
  print('FloatingActionButton.extended created');

  // Test FAB with custom colors
  final coloredFab = FloatingActionButton(
    onPressed: () {},
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    child: Icon(Icons.favorite),
  );
  print('FAB with custom colors created');

  // Test FAB with elevation
  final elevatedFab = FloatingActionButton(
    onPressed: () {},
    elevation: 12.0,
    highlightElevation: 16.0,
    child: Icon(Icons.star),
  );
  print('FAB with elevation=12 created');

  // Test FAB with focusElevation and hoverElevation
  final hoverFab = FloatingActionButton(
    onPressed: () {},
    focusElevation: 8.0,
    hoverElevation: 10.0,
    child: Icon(Icons.edit),
  );
  print('FAB with focus/hover elevation created');

  // Test FAB with shape
  final shapedFab = FloatingActionButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: Icon(Icons.settings),
  );
  print('FAB with RoundedRectangleBorder created');

  // Test FAB with mini
  final miniFab = FloatingActionButton(
    onPressed: () {},
    mini: true,
    child: Icon(Icons.navigation),
  );
  print('FAB with mini=true created');

  // Test FAB with isExtended
  print('FAB isExtended property for extended FAB');

  // Test FAB with clipBehavior
  final clippedFab = FloatingActionButton(
    onPressed: () {},
    clipBehavior: Clip.antiAlias,
    child: Icon(Icons.crop),
  );
  print('FAB with clipBehavior=antiAlias created');

  // Test FAB with focusNode
  final focusNode = FocusNode();
  final focusFab = FloatingActionButton(
    onPressed: () {},
    focusNode: focusNode,
    child: Icon(Icons.keyboard),
  );
  print('FAB with focusNode created');

  // Test FAB with autofocus
  final autofocusFab = FloatingActionButton(
    onPressed: () {},
    autofocus: true,
    child: Icon(Icons.auto_fix_high),
  );
  print('FAB with autofocus=true created');

  // Test FAB with materialTapTargetSize
  final padddedFab = FloatingActionButton(
    onPressed: () {},
    materialTapTargetSize: MaterialTapTargetSize.padded,
    child: Icon(Icons.touch_app),
  );
  print('FAB with materialTapTargetSize=padded created');

  // Test FAB with enableFeedback
  final feedbackFab = FloatingActionButton(
    onPressed: () {},
    enableFeedback: true,
    child: Icon(Icons.vibration),
  );
  print('FAB with enableFeedback=true created');

  // Test FAB with splashColor
  final splashFab = FloatingActionButton(
    onPressed: () {},
    splashColor: Colors.red.withOpacity(0.5),
    child: Icon(Icons.water_drop),
  );
  print('FAB with custom splashColor created');

  // Test disabled FAB
  final disabledFab = FloatingActionButton(
    onPressed: null,
    child: Icon(Icons.block),
  );
  print('Disabled FAB (onPressed=null) created');

  // Test FAB with heroTag
  final heroFab = FloatingActionButton(
    onPressed: () {},
    heroTag: 'unique-fab-tag',
    child: Icon(Icons.flight),
  );
  print('FAB with heroTag created');

  // Test multiple FABs need different heroTags
  print('Note: Multiple FABs on same route need different heroTags');

  print('FloatingActionButton test completed');

  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FloatingActionButton Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('FAB Variants:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                children: [
                  basicFab,
                  SizedBox(height: 4.0),
                  Text('Regular', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  smallFab,
                  SizedBox(height: 4.0),
                  Text('Small', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  largeFab,
                  SizedBox(height: 4.0),
                  Text('Large', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  miniFab,
                  SizedBox(height: 4.0),
                  Text('Mini', style: TextStyle(fontSize: 10.0)),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.0),

          Text('Extended FAB:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          extendedFab,
          SizedBox(height: 24.0),

          Text('Styled FABs:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [coloredFab, elevatedFab, shapedFab, disabledFab],
          ),
          SizedBox(height: 24.0),

          Text(
            'Key Properties:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• onPressed - tap callback'),
          Text('• child - icon or widget'),
          Text('• tooltip - accessibility text'),
          Text('• backgroundColor - background'),
          Text('• foregroundColor - icon/text color'),
          Text('• elevation - shadow depth'),
          Text('• shape - button shape'),
          Text('• mini - smaller size'),
          Text('• heroTag - animation tag'),
        ],
      ),
    ),
    floatingActionButton: basicFab,
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}
