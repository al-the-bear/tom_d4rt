// D4rt test script: Tests CupertinoTextFormFieldRow, CupertinoListTileChevron,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoScrollbar, CupertinoPopupSurface, CupertinoContextMenuAction
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino form/scroll test executing');

  // ========== CupertinoTextFormFieldRow ==========
  print('--- CupertinoTextFormFieldRow Tests ---');
  final textRow = CupertinoTextFormFieldRow(
    prefix: Text('Name'),
    placeholder: 'Enter your name',
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    autocorrect: false,
    maxLines: 1,
  );
  print('CupertinoTextFormFieldRow created');

  // ========== CupertinoListTile ==========
  print('--- CupertinoListTile Tests ---');
  final listTile = CupertinoListTile(
    title: Text('List Item'),
    subtitle: Text('With chevron'),
    leading: Icon(CupertinoIcons.person),
    trailing: CupertinoListTileChevron(),
    onTap: () => print('Tile tapped'),
  );
  print('CupertinoListTile with chevron created');

  // ========== CupertinoListTileChevron ==========
  print('--- CupertinoListTileChevron Tests ---');
  final chevron = CupertinoListTileChevron();
  print('CupertinoListTileChevron created');

  // ========== CupertinoScrollbar ==========
  print('--- CupertinoScrollbar Tests ---');
  final scrollCtrl = ScrollController();
  final cupertinoScrollbar = CupertinoScrollbar(
    controller: scrollCtrl,
    thumbVisibility: true,
    thickness: 6.0,
    thicknessWhileDragging: 10.0,
    radius: Radius.circular(3.0),
    radiusWhileDragging: Radius.circular(5.0),
    child: ListView.builder(
      controller: scrollCtrl,
      itemCount: 30,
      itemBuilder: (ctx, i) => CupertinoListTile(title: Text('Item $i')),
    ),
  );
  print('CupertinoScrollbar created');
  print('  thickness: 6.0');
  print('  thicknessWhileDragging: 10.0');

  // ========== CupertinoPopupSurface ==========
  print('--- CupertinoPopupSurface Tests ---');
  final popupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Popup Surface Content'),
    ),
  );
  print('CupertinoPopupSurface created');

  // ========== CupertinoContextMenuAction ==========
  print('--- CupertinoContextMenuAction Tests ---');
  final ctxAction = CupertinoContextMenuAction(
    child: Text('Copy'),
    trailingIcon: CupertinoIcons.doc_on_clipboard,
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('Context action pressed'),
  );
  print('CupertinoContextMenuAction created');
  print('  isDefaultAction: true');
  print('  isDestructiveAction: false');

  final destructiveAction = CupertinoContextMenuAction(
    child: Text('Delete'),
    trailingIcon: CupertinoIcons.delete,
    isDestructiveAction: true,
    onPressed: () {},
  );
  print('Destructive CupertinoContextMenuAction created');

  print('All cupertino form/scroll tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Form/Scroll Test')),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          header: Text('Form Fields'),
          children: [
            textRow,
            listTile,
            CupertinoListTile(
              title: Text('Settings'),
              trailing: CupertinoListTileChevron(),
            ),
          ],
        ),
      ),
    ),
  );
}
