// D4rt test script: Tests MergeableMaterial, MaterialGap, MaterialSlice from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MergeableMaterial/MaterialGap/MaterialSlice test executing');

  // ========== MATERIALSLICE ==========
  print('--- MaterialSlice Tests ---');

  // Variation 1: Basic MergeableMaterial with single MaterialSlice
  final widget1 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('slice1'),
          child: ListTile(
            title: Text('Single Slice'),
            subtitle: Text('Just one MaterialSlice'),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(1 MaterialSlice) created');

  // Variation 2: MergeableMaterial with multiple MaterialSlice
  final widget2 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('top'),
          child: ListTile(
            leading: Icon(Icons.arrow_upward),
            title: Text('Top Slice'),
          ),
        ),
        MaterialSlice(
          key: ValueKey('middle'),
          child: ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Middle Slice'),
          ),
        ),
        MaterialSlice(
          key: ValueKey('bottom'),
          child: ListTile(
            leading: Icon(Icons.arrow_downward),
            title: Text('Bottom Slice'),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(3 MaterialSlice) created');

  // ========== MATERIALGAP ==========
  print('--- MaterialGap Tests ---');

  // Variation 3: MergeableMaterial with MaterialGap between slices
  final widget3 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('above'),
          child: ListTile(
            title: Text('Above Gap'),
            tileColor: Colors.blue.shade50,
          ),
        ),
        MaterialGap(key: ValueKey('gap1')),
        MaterialSlice(
          key: ValueKey('below'),
          child: ListTile(
            title: Text('Below Gap'),
            tileColor: Colors.green.shade50,
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(MaterialGap between 2 slices) created');

  // Variation 4: MergeableMaterial with sized MaterialGap
  final widget4 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('s1'),
          child: ListTile(title: Text('Section 1')),
        ),
        MaterialGap(key: ValueKey('gap-sm'), size: 8.0),
        MaterialSlice(
          key: ValueKey('s2'),
          child: ListTile(title: Text('Section 2')),
        ),
        MaterialGap(key: ValueKey('gap-lg'), size: 24.0),
        MaterialSlice(
          key: ValueKey('s3'),
          child: ListTile(title: Text('Section 3')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(MaterialGap with size 8 and 24) created');

  // Variation 5: MergeableMaterial with multiple gaps and slices
  final widget5 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('header'),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.indigo.shade50,
            child: Text(
              'Header',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        MaterialGap(key: ValueKey('g1')),
        MaterialSlice(
          key: ValueKey('item1'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 1')),
        ),
        MaterialSlice(
          key: ValueKey('item2'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 2')),
        ),
        MaterialSlice(
          key: ValueKey('item3'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 3')),
        ),
        MaterialGap(key: ValueKey('g2')),
        MaterialSlice(
          key: ValueKey('footer'),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Text(
              'Footer',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(header/items/footer with gaps) created');

  // ========== MERGEABLEMATERIAL PROPERTIES ==========
  print('--- MergeableMaterial Properties ---');

  // Variation 6: MergeableMaterial with elevation
  final widget6 = SingleChildScrollView(
    child: MergeableMaterial(
      elevation: 8,
      children: [
        MaterialSlice(
          key: ValueKey('elevated'),
          child: ListTile(title: Text('Elevated MergeableMaterial')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(elevation: 8) created');

  // Variation 7: MergeableMaterial with hasDividers false
  final widget7 = SingleChildScrollView(
    child: MergeableMaterial(
      hasDividers: false,
      children: [
        MaterialSlice(
          key: ValueKey('nd1'),
          child: ListTile(title: Text('No Divider 1')),
        ),
        MaterialSlice(
          key: ValueKey('nd2'),
          child: ListTile(title: Text('No Divider 2')),
        ),
        MaterialSlice(
          key: ValueKey('nd3'),
          child: ListTile(title: Text('No Divider 3')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(hasDividers: false) created');

  // Variation 8: MergeableMaterial with dividerColor
  final widget8 = SingleChildScrollView(
    child: MergeableMaterial(
      dividerColor: Colors.red,
      children: [
        MaterialSlice(
          key: ValueKey('dc1'),
          child: ListTile(title: Text('Red Divider 1')),
        ),
        MaterialSlice(
          key: ValueKey('dc2'),
          child: ListTile(title: Text('Red Divider 2')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(dividerColor: red) created');

  // Variation 9: MergeableMaterial with complex content in slices
  final widget9 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('rich1'),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(child: Text('A')),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alice',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'alice@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        MaterialGap(key: ValueKey('g-rich')),
        MaterialSlice(
          key: ValueKey('rich2'),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(child: Text('B')),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bob',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'bob@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(complex content with Row/Column) created');

  // Variation 10: MaterialSlice with color
  final widget10 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('color1'),
          color: Colors.amber.shade50,
          child: ListTile(title: Text('Colored Slice 1')),
        ),
        MaterialSlice(
          key: ValueKey('color2'),
          color: Colors.lightBlue.shade50,
          child: ListTile(title: Text('Colored Slice 2')),
        ),
      ],
    ),
  );
  print('MaterialSlice(color) created');

  print('MergeableMaterial/MaterialGap/MaterialSlice test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        widget1,
        SizedBox(height: 16),
        widget2,
        SizedBox(height: 16),
        widget3,
        SizedBox(height: 16),
        widget4,
        SizedBox(height: 16),
        widget5,
        SizedBox(height: 16),
        widget6,
        SizedBox(height: 16),
        widget7,
        SizedBox(height: 16),
        widget8,
        SizedBox(height: 16),
        widget9,
        SizedBox(height: 16),
        widget10,
      ],
    ),
  );
}
