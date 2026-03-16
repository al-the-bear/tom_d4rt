// D4rt test script: Tests Table from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Table test executing');

  // Test basic Table with TableRow children
  final tableBasic = Table(
    children: [
      TableRow(children: [Text('A1'), Text('B1'), Text('C1')]),
      TableRow(children: [Text('A2'), Text('B2'), Text('C2')]),
      TableRow(children: [Text('A3'), Text('B3'), Text('C3')]),
    ],
  );
  print('Basic Table with 3x3 cells created');

  // Test Table with border
  final tableBorder = Table(
    border: TableBorder.all(color: Colors.black, width: 1.0),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Name')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Age')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('City')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Alice')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('30')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('NYC')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Bob')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('25')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('LA')),
        ],
      ),
    ],
  );
  print('Table with border created');

  // Test Table with columnWidths
  final tableColumnWidths = Table(
    border: TableBorder.all(color: Colors.grey, width: 1.0),
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(1.0),
      2: FixedColumnWidth(80.0),
    },
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Wide column')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Normal')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Fixed')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Flex 2.0')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Flex 1.0')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('80px')),
        ],
      ),
    ],
  );
  print('Table with columnWidths created');

  // Test Table with defaultVerticalAlignment
  final tableVerticalAlign = Table(
    border: TableBorder.all(color: Colors.blue, width: 1.0),
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          Container(
            height: 60.0,
            padding: EdgeInsets.all(4.0),
            child: Text('Tall cell'),
          ),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Middle aligned')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Also middle')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(4.0), child: Text('Row 2')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Data')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('More')),
        ],
      ),
    ],
  );
  print('Table with defaultVerticalAlignment=middle created');

  // Test Table with row decorations
  final tableDecorated = Table(
    border: TableBorder.all(color: Colors.black54, width: 1.0),
    children: [
      TableRow(
        decoration: BoxDecoration(color: Colors.blue),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Header 1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Header 2',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      TableRow(
        decoration: BoxDecoration(color: Colors.grey),
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 2')),
        ],
      ),
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 3')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 4')),
        ],
      ),
    ],
  );
  print('Table with row decorations created');

  // Test Table with IntrinsicColumnWidth
  final tableIntrinsic = Table(
    border: TableBorder.all(color: Colors.green, width: 1.0),
    columnWidths: {0: IntrinsicColumnWidth(), 1: FlexColumnWidth(1.0)},
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Short')),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Flexible column fills remaining space'),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Longer label here'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Adapts to content'),
          ),
        ],
      ),
    ],
  );
  print('Table with IntrinsicColumnWidth created');

  // Test Table with symmetric border
  final tableSymmetricBorder = Table(
    border: TableBorder.symmetric(
      inside: BorderSide(color: Colors.grey, width: 1.0),
      outside: BorderSide(color: Colors.black, width: 2.0),
    ),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 2')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 3')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 4')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 5')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 6')),
        ],
      ),
    ],
  );
  print('Table with symmetric border created');

  // Test Table with defaultColumnWidth
  final tableDefaultCol = Table(
    border: TableBorder.all(color: Colors.purple, width: 1.0),
    defaultColumnWidth: FlexColumnWidth(1.0),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Equal')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Width')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cols')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Four')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C2')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C3')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C4')),
        ],
      ),
    ],
  );
  print('Table with defaultColumnWidth created');

  print('All Table tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Table Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic 3x3:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableBasic,
        SizedBox(height: 12.0),
        Text('With border:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableBorder,
        SizedBox(height: 12.0),
        Text(
          'Column widths (Flex/Fixed):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableColumnWidths,
        SizedBox(height: 12.0),
        Text(
          'Vertical alignment (middle):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableVerticalAlign,
        SizedBox(height: 12.0),
        Text('Row decorations:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableDecorated,
        SizedBox(height: 12.0),
        Text(
          'Intrinsic column width:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableIntrinsic,
        SizedBox(height: 12.0),
        Text(
          'Symmetric border:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableSymmetricBorder,
        SizedBox(height: 12.0),
        Text(
          'Default column width:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableDefaultCol,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Table uses TableRow children for rows'),
        Text('• columnWidths map overrides per-column sizing'),
        Text(
          '• FlexColumnWidth, FixedColumnWidth, IntrinsicColumnWidth available',
        ),
        Text('• TableBorder.all, TableBorder.symmetric for borders'),
        Text('• defaultVerticalAlignment controls cell alignment'),
        Text('• TableRow decoration styles individual rows'),
      ],
    ),
  );
}
