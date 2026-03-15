// D4rt test script: Tests CircularProgressIndicator, LinearProgressIndicator, RefreshIndicator from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Progress Indicator widgets test executing');

  // ========== CIRCULARPROGRESSINDICATOR ==========
  print('--- CircularProgressIndicator Tests ---');

  // Test basic indeterminate CircularProgressIndicator
  final basicCircular = CircularProgressIndicator();
  print('Basic CircularProgressIndicator (indeterminate) created');

  // Test CircularProgressIndicator with value
  final valueCircular = CircularProgressIndicator(value: 0.6);
  print('CircularProgressIndicator with value=0.6 created');

  // Test CircularProgressIndicator with value 0
  final zeroCircular = CircularProgressIndicator(value: 0.0);
  print('CircularProgressIndicator with value=0 created');

  // Test CircularProgressIndicator with value 1
  final fullCircular = CircularProgressIndicator(value: 1.0);
  print('CircularProgressIndicator with value=1 created');

  // Test CircularProgressIndicator with color
  final coloredCircular = CircularProgressIndicator(color: Colors.purple);
  print('CircularProgressIndicator with color created');

  // Test CircularProgressIndicator with backgroundColor
  final bgCircular = CircularProgressIndicator(
    value: 0.5,
    backgroundColor: Colors.grey.shade300,
  );
  print('CircularProgressIndicator with backgroundColor created');

  // Test CircularProgressIndicator with strokeWidth
  final thickCircular = CircularProgressIndicator(strokeWidth: 8.0);
  print('CircularProgressIndicator with strokeWidth=8 created');

  // Test thin CircularProgressIndicator
  final thinCircular = CircularProgressIndicator(strokeWidth: 2.0);
  print('CircularProgressIndicator with strokeWidth=2 created');

  // Test CircularProgressIndicator with valueColor
  final animatedColorCircular = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
  );
  print('CircularProgressIndicator with valueColor created');

  // Test CircularProgressIndicator with strokeCap
  final roundedCircular = CircularProgressIndicator(
    value: 0.7,
    strokeCap: StrokeCap.round,
    strokeWidth: 8.0,
  );
  print('CircularProgressIndicator with strokeCap=round created');

  // Test CircularProgressIndicator with semanticsLabel
  final labeledCircular = CircularProgressIndicator(
    value: 0.4,
    semanticsLabel: '40% complete',
    semanticsValue: '40%',
  );
  print('CircularProgressIndicator with semanticsLabel created');

  // Test CircularProgressIndicator.adaptive
  final adaptiveCircular = CircularProgressIndicator.adaptive();
  print('CircularProgressIndicator.adaptive created');

  // ========== LINEARPROGRESSINDICATOR ==========
  print('--- LinearProgressIndicator Tests ---');

  // Test basic indeterminate LinearProgressIndicator
  final basicLinear = LinearProgressIndicator();
  print('Basic LinearProgressIndicator (indeterminate) created');

  // Test LinearProgressIndicator with value
  final valueLinear = LinearProgressIndicator(value: 0.5);
  print('LinearProgressIndicator with value=0.5 created');

  // Test LinearProgressIndicator with value 0
  final zeroLinear = LinearProgressIndicator(value: 0.0);
  print('LinearProgressIndicator with value=0 created');

  // Test LinearProgressIndicator with value 1
  final fullLinear = LinearProgressIndicator(value: 1.0);
  print('LinearProgressIndicator with value=1 created');

  // Test LinearProgressIndicator with color
  final coloredLinear = LinearProgressIndicator(color: Colors.green);
  print('LinearProgressIndicator with color created');

  // Test LinearProgressIndicator with backgroundColor
  final bgLinear = LinearProgressIndicator(
    value: 0.7,
    backgroundColor: Colors.grey.shade200,
  );
  print('LinearProgressIndicator with backgroundColor created');

  // Test LinearProgressIndicator with valueColor
  final animatedColorLinear = LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
  );
  print('LinearProgressIndicator with valueColor created');

  // Test LinearProgressIndicator with minHeight
  final tallLinear = LinearProgressIndicator(minHeight: 10.0, value: 0.6);
  print('LinearProgressIndicator with minHeight=10 created');

  // Test thin LinearProgressIndicator
  final thinLinear = LinearProgressIndicator(minHeight: 2.0, value: 0.8);
  print('LinearProgressIndicator with minHeight=2 created');

  // Test LinearProgressIndicator with borderRadius
  final roundedLinear = LinearProgressIndicator(
    value: 0.5,
    minHeight: 8.0,
    borderRadius: BorderRadius.circular(4.0),
  );
  print('LinearProgressIndicator with borderRadius created');

  // Test LinearProgressIndicator with semanticsLabel
  final labeledLinear = LinearProgressIndicator(
    value: 0.3,
    semanticsLabel: '30% complete',
    semanticsValue: '30%',
  );
  print('LinearProgressIndicator with semanticsLabel created');

  // ========== REFRESHINDICATOR ==========
  print('--- RefreshIndicator Tests ---');

  // Test basic RefreshIndicator
  final basicRefresh = RefreshIndicator(
    onRefresh: () async {
      print('Refreshing...');
      await Future.delayed(Duration(seconds: 1));
      print('Refresh complete');
    },
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    ),
  );
  print('Basic RefreshIndicator created');

  // Test RefreshIndicator with color
  final coloredRefresh = RefreshIndicator(
    color: Colors.purple,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh')),
        ListTile(title: Text('Colored indicator')),
      ],
    ),
  );
  print('RefreshIndicator with color created');

  // Test RefreshIndicator with backgroundColor
  final bgRefresh = RefreshIndicator(
    backgroundColor: Colors.blue.shade100,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh')),
        ListTile(title: Text('Background colored')),
      ],
    ),
  );
  print('RefreshIndicator with backgroundColor created');

  // Test RefreshIndicator with displacement
  final displacedRefresh = RefreshIndicator(
    displacement: 60.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Large displacement'))]),
  );
  print('RefreshIndicator with displacement created');

  // Test RefreshIndicator with edgeOffset
  final offsetRefresh = RefreshIndicator(
    edgeOffset: 100.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Edge offset'))]),
  );
  print('RefreshIndicator with edgeOffset created');

  // Test RefreshIndicator with strokeWidth
  final strokeRefresh = RefreshIndicator(
    strokeWidth: 4.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Thick stroke'))]),
  );
  print('RefreshIndicator with strokeWidth created');

  // Test RefreshIndicator with triggerMode
  final triggerRefresh = RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Trigger anywhere'))]),
  );
  print('RefreshIndicator with triggerMode created');

  // Test RefreshIndicator.adaptive
  final adaptiveRefresh = RefreshIndicator.adaptive(
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Adaptive indicator'))]),
  );
  print('RefreshIndicator.adaptive created');

  print('Progress Indicator widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Indicators Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'CircularProgressIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: basicCircular),
                SizedBox(height: 4),
                Text('Indeterminate', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: valueCircular),
                SizedBox(height: 4),
                Text('60%', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: coloredCircular),
                SizedBox(height: 4),
                Text('Colored', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: thickCircular),
                SizedBox(height: 4),
                Text('Thick', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: roundedCircular),
                SizedBox(height: 4),
                Text('Rounded Cap', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: bgCircular),
                SizedBox(height: 4),
                Text('With BG', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: adaptiveCircular),
                SizedBox(height: 4),
                Text('Adaptive', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'LinearProgressIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        Text('Indeterminate:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        basicLinear,
        SizedBox(height: 12.0),

        Text('50% complete:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        valueLinear,
        SizedBox(height: 12.0),

        Text('Colored (green):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        coloredLinear,
        SizedBox(height: 12.0),

        Text('With background:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        bgLinear,
        SizedBox(height: 12.0),

        Text('Tall (10px):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        tallLinear,
        SizedBox(height: 12.0),

        Text('Thin (2px):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        thinLinear,
        SizedBox(height: 12.0),

        Text('Rounded corners:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        roundedLinear,

        SizedBox(height: 24.0),
        Text(
          'RefreshIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Pull down to refresh in actual app)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: basicRefresh,
        ),
      ],
    ),
  );
}
