// D4rt test script: Tests Chip, InputChip, FilterChip, ChoiceChip, ActionChip from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Chip widgets test executing');

  // ========== CHIP ==========
  print('--- Chip Tests ---');

  // Test basic Chip
  final basicChip = Chip(label: Text('Basic Chip'));
  print('Basic Chip created');

  // Test Chip with avatar
  final avatarChip = Chip(
    avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
    label: Text('Avatar Chip'),
  );
  print('Chip with avatar created');

  // Test Chip with deleteIcon
  final deleteChip = Chip(
    label: Text('Deletable'),
    deleteIcon: Icon(Icons.cancel),
    onDeleted: () {
      print('Chip deleted');
    },
  );
  print('Chip with deleteIcon created');

  // Test Chip with deleteIconColor
  final deleteColorChip = Chip(
    label: Text('Delete Color'),
    deleteIconColor: Colors.red,
    onDeleted: () {},
  );
  print('Chip with deleteIconColor created');

  // Test Chip with backgroundColor
  final bgColorChip = Chip(
    label: Text('Colored'),
    backgroundColor: Colors.purple.shade100,
  );
  print('Chip with backgroundColor created');

  // Test Chip with labelStyle
  final styleChip = Chip(
    label: Text('Styled'),
    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    backgroundColor: Colors.teal,
  );
  print('Chip with labelStyle created');

  // Test Chip with padding
  final paddedChip = Chip(
    label: Text('Padded'),
    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(8.0),
  );
  print('Chip with padding created');

  // Test Chip with shape
  final shapedChip = Chip(
    label: Text('Shaped'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side: BorderSide(color: Colors.blue),
    ),
  );
  print('Chip with shape created');

  // Test Chip with elevation
  final elevatedChip = Chip(
    label: Text('Elevated'),
    elevation: 8.0,
    shadowColor: Colors.black,
  );
  print('Chip with elevation created');

  // Test Chip with side
  final sideChip = Chip(
    label: Text('Bordered'),
    side: BorderSide(color: Colors.orange, width: 2.0),
  );
  print('Chip with side created');

  // ========== INPUTCHIP ==========
  print('--- InputChip Tests ---');

  // Test basic InputChip
  final basicInputChip = InputChip(
    label: Text('Input Chip'),
    onPressed: () {
      print('InputChip pressed');
    },
  );
  print('Basic InputChip created');

  // Test InputChip with avatar
  final avatarInputChip = InputChip(
    avatar: Icon(Icons.person, size: 18),
    label: Text('John'),
    onPressed: () {},
  );
  print('InputChip with avatar created');

  // Test InputChip with selected
  final selectedInputChip = InputChip(
    label: Text('Selected'),
    selected: true,
    onPressed: () {},
  );
  print('InputChip selected created');

  // Test InputChip with onSelected
  final selectableInputChip = InputChip(
    label: Text('Selectable'),
    onSelected: (bool selected) {
      print('InputChip selected: $selected');
    },
  );
  print('InputChip with onSelected created');

  // Test InputChip with onDeleted
  final deletableInputChip = InputChip(
    label: Text('Remove'),
    onDeleted: () {
      print('InputChip deleted');
    },
  );
  print('InputChip with onDeleted created');

  // Test InputChip disabled
  final disabledInputChip = InputChip(
    label: Text('Disabled'),
    isEnabled: false,
  );
  print('Disabled InputChip created');

  // Test InputChip with selectedColor
  final coloredInputChip = InputChip(
    label: Text('Color Selected'),
    selected: true,
    selectedColor: Colors.green.shade100,
    onPressed: () {},
  );
  print('InputChip with selectedColor created');

  // Test InputChip with checkmarkColor
  final checkmarkInputChip = InputChip(
    label: Text('Checkmark'),
    selected: true,
    showCheckmark: true,
    checkmarkColor: Colors.purple,
    onPressed: () {},
  );
  print('InputChip with checkmarkColor created');

  // ========== FILTERCHIP ==========
  print('--- FilterChip Tests ---');

  // Test basic FilterChip
  final basicFilterChip = FilterChip(
    label: Text('Filter'),
    selected: false,
    onSelected: (bool selected) {
      print('FilterChip selected: $selected');
    },
  );
  print('Basic FilterChip created');

  // Test FilterChip selected
  final selectedFilterChip = FilterChip(
    label: Text('Active'),
    selected: true,
    onSelected: (selected) {},
  );
  print('FilterChip selected created');

  // Test FilterChip with avatar
  final avatarFilterChip = FilterChip(
    avatar: Icon(Icons.label, size: 18),
    label: Text('Tag'),
    selected: false,
    onSelected: (selected) {},
  );
  print('FilterChip with avatar created');

  // Test FilterChip with selectedColor
  final coloredFilterChip = FilterChip(
    label: Text('Yellow Selected'),
    selected: true,
    selectedColor: Colors.yellow.shade200,
    onSelected: (selected) {},
  );
  print('FilterChip with selectedColor created');

  // Test FilterChip with backgroundColor
  final bgFilterChip = FilterChip(
    label: Text('Background'),
    selected: false,
    backgroundColor: Colors.grey.shade200,
    onSelected: (selected) {},
  );
  print('FilterChip with backgroundColor created');

  // Test FilterChip with showCheckmark
  final noCheckFilterChip = FilterChip(
    label: Text('No Check'),
    selected: true,
    showCheckmark: false,
    onSelected: (selected) {},
  );
  print('FilterChip showCheckmark=false created');

  // Test FilterChip with checkmarkColor
  final checkFilterChip = FilterChip(
    label: Text('Red Check'),
    selected: true,
    checkmarkColor: Colors.red,
    onSelected: (selected) {},
  );
  print('FilterChip with checkmarkColor created');

  // Test FilterChip disabled
  final disabledFilterChip = FilterChip(
    label: Text('Disabled'),
    selected: false,
    onSelected: null,
  );
  print('Disabled FilterChip created');

  // Test FilterChip with elevation
  final elevatedFilterChip = FilterChip(
    label: Text('Elevated'),
    selected: false,
    elevation: 4.0,
    onSelected: (selected) {},
  );
  print('FilterChip with elevation created');

  // Test FilterChip with pressElevation
  final pressFilterChip = FilterChip(
    label: Text('Press Elevation'),
    selected: false,
    pressElevation: 8.0,
    onSelected: (selected) {},
  );
  print('FilterChip with pressElevation created');

  // ========== CHOICECHIP ==========
  print('--- ChoiceChip Tests ---');

  // Test basic ChoiceChip
  final basicChoiceChip = ChoiceChip(
    label: Text('Choice'),
    selected: false,
    onSelected: (bool selected) {
      print('ChoiceChip selected: $selected');
    },
  );
  print('Basic ChoiceChip created');

  // Test ChoiceChip selected
  final selectedChoiceChip = ChoiceChip(
    label: Text('Selected Choice'),
    selected: true,
    onSelected: (selected) {},
  );
  print('ChoiceChip selected created');

  // Test ChoiceChip with avatar
  final avatarChoiceChip = ChoiceChip(
    avatar: CircleAvatar(child: Text('S')),
    label: Text('Small'),
    selected: true,
    onSelected: (selected) {},
  );
  print('ChoiceChip with avatar created');

  // Test ChoiceChip with selectedColor
  final coloredChoiceChip = ChoiceChip(
    label: Text('Blue Selected'),
    selected: true,
    selectedColor: Colors.blue.shade200,
    onSelected: (selected) {},
  );
  print('ChoiceChip with selectedColor created');

  // Test ChoiceChip with disabledColor
  final disabledColorChoiceChip = ChoiceChip(
    label: Text('Grey Disabled'),
    selected: false,
    disabledColor: Colors.grey.shade300,
    onSelected: null,
  );
  print('ChoiceChip with disabledColor created');

  // Test ChoiceChip with labelStyle
  final styleChoiceChip = ChoiceChip(
    label: Text('Styled'),
    selected: true,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    onSelected: (selected) {},
  );
  print('ChoiceChip with labelStyle created');

  // Test ChoiceChip with elevation
  final elevatedChoiceChip = ChoiceChip(
    label: Text('Elevated'),
    selected: false,
    elevation: 4.0,
    onSelected: (selected) {},
  );
  print('ChoiceChip with elevation created');

  // Test ChoiceChip with shape
  final shapedChoiceChip = ChoiceChip(
    label: Text('Shaped'),
    selected: true,
    shape: StadiumBorder(side: BorderSide(color: Colors.purple)),
    onSelected: (selected) {},
  );
  print('ChoiceChip with shape created');

  // ========== ACTIONCHIP ==========
  print('--- ActionChip Tests ---');

  // Test basic ActionChip
  final basicActionChip = ActionChip(
    label: Text('Action'),
    onPressed: () {
      print('ActionChip pressed');
    },
  );
  print('Basic ActionChip created');

  // Test ActionChip with avatar
  final avatarActionChip = ActionChip(
    avatar: Icon(Icons.add, size: 18),
    label: Text('Add'),
    onPressed: () {},
  );
  print('ActionChip with avatar created');

  // Test ActionChip with tooltip
  final tooltipActionChip = ActionChip(
    label: Text('Tooltip'),
    tooltip: 'This is a tooltip',
    onPressed: () {},
  );
  print('ActionChip with tooltip created');

  // Test ActionChip with backgroundColor
  final coloredActionChip = ActionChip(
    label: Text('Colored'),
    backgroundColor: Colors.orange.shade100,
    onPressed: () {},
  );
  print('ActionChip with backgroundColor created');

  // Test ActionChip with labelStyle
  final styleActionChip = ActionChip(
    label: Text('Styled Action'),
    labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    onPressed: () {},
  );
  print('ActionChip with labelStyle created');

  // Test ActionChip disabled
  final disabledActionChip = ActionChip(
    label: Text('Disabled'),
    onPressed: null,
  );
  print('Disabled ActionChip created');

  // Test ActionChip with elevation
  final elevatedActionChip = ActionChip(
    label: Text('Elevated'),
    elevation: 4.0,
    onPressed: () {},
  );
  print('ActionChip with elevation created');

  // Test ActionChip with pressElevation
  final pressActionChip = ActionChip(
    label: Text('Press'),
    pressElevation: 8.0,
    onPressed: () {},
  );
  print('ActionChip with pressElevation created');

  // Test ActionChip with side
  final sideActionChip = ActionChip(
    label: Text('Bordered'),
    side: BorderSide(color: Colors.green, width: 2.0),
    onPressed: () {},
  );
  print('ActionChip with side created');

  // Test ActionChip.elevated
  final elevatedActionVariant = ActionChip.elevated(
    label: Text('Elevated Variant'),
    onPressed: () {},
  );
  print('ActionChip.elevated created');

  print('Chip widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chip Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Chip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicChip,
            avatarChip,
            deleteChip,
            bgColorChip,
            styleChip,
            shapedChip,
            elevatedChip,
            sideChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('InputChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicInputChip,
            avatarInputChip,
            selectedInputChip,
            deletableInputChip,
            disabledInputChip,
            coloredInputChip,
            checkmarkInputChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('FilterChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicFilterChip,
            selectedFilterChip,
            avatarFilterChip,
            coloredFilterChip,
            noCheckFilterChip,
            checkFilterChip,
            disabledFilterChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('ChoiceChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicChoiceChip,
            selectedChoiceChip,
            avatarChoiceChip,
            coloredChoiceChip,
            disabledColorChoiceChip,
            shapedChoiceChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('ActionChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicActionChip,
            avatarActionChip,
            tooltipActionChip,
            coloredActionChip,
            disabledActionChip,
            sideActionChip,
            elevatedActionVariant,
          ],
        ),
      ],
    ),
  );
}
