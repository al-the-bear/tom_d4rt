// D4rt test script: Tests ObstructingPreferredSizeWidget from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ObstructingPreferredSizeWidget is abstract — tested via CupertinoNavigationBar
// which implements it.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('ObstructingPreferredSizeWidget test executing');

  // ===== 1. CupertinoNavigationBar implements ObstructingPreferredSizeWidget =====
  print('--- CupertinoNavigationBar as ObstructingPreferredSizeWidget ---');
  final navBar = CupertinoNavigationBar(
    middle: Text('Title'),
  );
  print('  navBar type: ${navBar.runtimeType}');
  print('  preferredSize: ${navBar.preferredSize}');
  print('  is ObstructingPreferredSizeWidget: ${navBar is ObstructingPreferredSizeWidget}');

  // ===== 2. shouldFullyObstruct =====
  print('--- shouldFullyObstruct ---');
  final opaqueBar = CupertinoNavigationBar(
    middle: Text('Opaque'),
    backgroundColor: CupertinoColors.white,
  );
  print('  opaque bar preferredSize: ${opaqueBar.preferredSize}');
  print('  opaque bar shouldFullyObstruct: ${opaqueBar.shouldFullyObstruct(context)}');

  final translucentBar = CupertinoNavigationBar(
    middle: Text('Translucent'),
    backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
  );
  print('  translucent bar shouldFullyObstruct: ${translucentBar.shouldFullyObstruct(context)}');

  // ===== 3. preferredSize dimensions =====
  print('--- preferredSize ---');
  final bars = <CupertinoNavigationBar>[
    CupertinoNavigationBar(middle: Text('Default')),
    CupertinoNavigationBar(
      middle: Text('With leading'),
      leading: CupertinoButton(padding: EdgeInsets.zero, child: Text('Back'), onPressed: () {}),
    ),
    CupertinoNavigationBar(
      middle: Text('With trailing'),
      trailing: CupertinoButton(padding: EdgeInsets.zero, child: Icon(CupertinoIcons.add), onPressed: () {}),
    ),
    CupertinoNavigationBar(
      middle: Text('Full'),
      leading: CupertinoButton(padding: EdgeInsets.zero, child: Text('Cancel'), onPressed: () {}),
      trailing: CupertinoButton(padding: EdgeInsets.zero, child: Text('Done'), onPressed: () {}),
    ),
  ];
  for (final bar in bars) {
    print('  ${(bar.middle as Text).data}: preferredSize=${bar.preferredSize}');
  }

  // ===== 4. CupertinoSliverNavigationBar also obstructs =====
  print('--- CupertinoSliverNavigationBar ---');
  final sliverBar = CupertinoSliverNavigationBar(
    largeTitle: Text('Large Title'),
  );
  print('  sliver nav bar created: ${sliverBar.runtimeType}');

  // ===== 5. Navigation bar with different backgrounds =====
  print('--- Background variations ---');
  final backgrounds = <String, Color>{
    'white': CupertinoColors.white,
    'black': CupertinoColors.black,
    'blue': CupertinoColors.activeBlue,
    'transparent': Color(0x00000000),
  };
  for (final entry in backgrounds.entries) {
    final bar = CupertinoNavigationBar(
      middle: Text(entry.key),
      backgroundColor: entry.value,
    );
    print('  ${entry.key}: shouldFullyObstruct=${bar.shouldFullyObstruct(context)}');
  }

  // ===== 6. PreferredSizeWidget comparison =====
  print('--- PreferredSizeWidget check ---');
  final isPreferred = navBar is PreferredSizeWidget;
  final isObstructing = navBar is ObstructingPreferredSizeWidget;
  print('  is PreferredSizeWidget: $isPreferred');
  print('  is ObstructingPreferredSizeWidget: $isObstructing');

  print('ObstructingPreferredSizeWidget test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: opaqueBar,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ObstructingPreferredSizeWidget', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Tested via CupertinoNavigationBar'),
              SizedBox(height: 8.0),
              Text('preferredSize: ${navBar.preferredSize}'),
              Text('shouldFullyObstruct (opaque): ${opaqueBar.shouldFullyObstruct(context)}'),
              Text('shouldFullyObstruct (translucent): ${translucentBar.shouldFullyObstruct(context)}'),
              SizedBox(height: 16.0),
              Text('Background variations:'),
              for (final entry in backgrounds.entries)
                Text('  ${entry.key}: obstruct=${CupertinoNavigationBar(middle: Text(""), backgroundColor: entry.value).shouldFullyObstruct(context)}'),
            ],
          ),
        ),
      ),
    ),
  );
}
