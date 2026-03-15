// D4rt test script: Tests Tooltip and Badge widgets from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tooltip and Badge widgets test executing');

  // ========== TOOLTIP ==========
  print('--- Tooltip Tests ---');

  // Test basic Tooltip
  final basicTooltip = Tooltip(
    message: 'This is a tooltip',
    child: Icon(Icons.info),
  );
  print('Basic Tooltip created');

  // Test Tooltip with richMessage
  final richTooltip = Tooltip(
    richMessage: TextSpan(
      children: [
        TextSpan(
          text: 'Bold ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: 'and '),
        TextSpan(
          text: 'italic',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
    child: Icon(Icons.text_fields),
  );
  print('Tooltip with richMessage created');

  // Test Tooltip with height
  final tallTooltip = Tooltip(
    message: 'Tall tooltip',
    height: 60.0,
    child: Icon(Icons.height),
  );
  print('Tooltip with height created');

  // Test Tooltip with padding
  final paddedTooltip = Tooltip(
    message: 'Padded tooltip',
    padding: EdgeInsets.all(16.0),
    child: Icon(Icons.padding),
  );
  print('Tooltip with padding created');

  // Test Tooltip with margin
  final marginTooltip = Tooltip(
    message: 'Margin tooltip',
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Icon(Icons.margin),
  );
  print('Tooltip with margin created');

  // Test Tooltip with verticalOffset
  final offsetTooltip = Tooltip(
    message: 'Offset tooltip',
    verticalOffset: 40.0,
    child: Icon(Icons.vertical_align_bottom),
  );
  print('Tooltip with verticalOffset created');

  // Test Tooltip with preferBelow
  final aboveTooltip = Tooltip(
    message: 'Shows above',
    preferBelow: false,
    child: Icon(Icons.arrow_upward),
  );
  print('Tooltip with preferBelow=false created');

  // Test Tooltip with excludeFromSemantics
  final semanticsTooltip = Tooltip(
    message: 'Excluded from semantics',
    excludeFromSemantics: true,
    child: Icon(Icons.accessibility),
  );
  print('Tooltip with excludeFromSemantics created');

  // Test Tooltip with decoration
  final decoratedTooltip = Tooltip(
    message: 'Decorated tooltip',
    decoration: BoxDecoration(
      color: Colors.purple,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Icon(Icons.brush),
  );
  print('Tooltip with decoration created');

  // Test Tooltip with textStyle
  final styledTooltip = Tooltip(
    message: 'Styled text',
    textStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    child: Icon(Icons.text_format),
  );
  print('Tooltip with textStyle created');

  // Test Tooltip with textAlign
  final alignedTooltip = Tooltip(
    message: 'Center aligned text in this tooltip',
    textAlign: TextAlign.center,
    child: Icon(Icons.format_align_center),
  );
  print('Tooltip with textAlign created');

  // Test Tooltip with waitDuration
  final waitTooltip = Tooltip(
    message: 'Wait 1 second to show',
    waitDuration: Duration(seconds: 1),
    child: Icon(Icons.timer),
  );
  print('Tooltip with waitDuration created');

  // Test Tooltip with showDuration
  final showTooltip = Tooltip(
    message: 'Shows for 5 seconds',
    showDuration: Duration(seconds: 5),
    child: Icon(Icons.visibility),
  );
  print('Tooltip with showDuration created');

  // Test Tooltip with exitDuration
  final exitTooltip = Tooltip(
    message: 'Slow exit',
    exitDuration: Duration(milliseconds: 500),
    child: Icon(Icons.exit_to_app),
  );
  print('Tooltip with exitDuration created');

  // Test Tooltip with triggerMode
  final tapTooltip = Tooltip(
    message: 'Tap to show',
    triggerMode: TooltipTriggerMode.tap,
    child: Icon(Icons.touch_app),
  );
  print('Tooltip with triggerMode.tap created');

  // Test Tooltip with enableFeedback
  final feedbackTooltip = Tooltip(
    message: 'With Feedback',
    enableFeedback: true,
    child: Icon(Icons.vibration),
  );
  print('Tooltip with enableFeedback created');

  // Test Tooltip with onTriggered
  final triggeredTooltip = Tooltip(
    message: 'Triggered callback',
    onTriggered: () {
      print('Tooltip triggered!');
    },
    child: Icon(Icons.notifications_active),
  );
  print('Tooltip with onTriggered created');

  // ========== BADGE ==========
  print('--- Badge Tests ---');

  // Test basic Badge
  final basicBadge = Badge(child: Icon(Icons.mail));
  print('Basic Badge (dot) created');

  // Test Badge with label
  final labelBadge = Badge(label: Text('5'), child: Icon(Icons.notifications));
  print('Badge with label created');

  // Test Badge with large count
  final countBadge = Badge(
    label: Text('99+'),
    child: Icon(Icons.shopping_cart),
  );
  print('Badge with large count created');

  // Test Badge with isLabelVisible
  final hiddenBadge = Badge(
    label: Text('3'),
    isLabelVisible: false,
    child: Icon(Icons.inbox),
  );
  print('Badge with isLabelVisible=false created');

  // Test Badge with backgroundColor
  final coloredBadge = Badge(
    label: Text('New'),
    backgroundColor: Colors.green,
    child: Icon(Icons.star),
  );
  print('Badge with backgroundColor created');

  // Test Badge with textColor
  final textColorBadge = Badge(
    label: Text('!'),
    textColor: Colors.yellow,
    backgroundColor: Colors.black,
    child: Icon(Icons.warning),
  );
  print('Badge with textColor created');

  // Test Badge with textStyle
  final styledBadge = Badge(
    label: Text('VIP'),
    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    child: Icon(Icons.person),
  );
  print('Badge with textStyle created');

  // Test Badge with padding
  final paddedBadge = Badge(
    label: Text('100'),
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Icon(Icons.message),
  );
  print('Badge with padding created');

  // Test Badge with largeSize
  final largeBadge = Badge(
    label: Text('Big'),
    largeSize: 28.0,
    child: Icon(Icons.circle),
  );
  print('Badge with largeSize created');

  // Test Badge with smallSize
  final smallBadge = Badge(
    smallSize: 8.0,
    child: Icon(Icons.fiber_manual_record),
  );
  print('Badge with smallSize created');

  // Test Badge with alignment
  final alignedBadge = Badge(
    label: Text('1'),
    alignment: Alignment.bottomRight,
    child: Icon(Icons.folder),
  );
  print('Badge with alignment created');

  // Test Badge with offset
  final offsetBadge = Badge(
    label: Text('2'),
    offset: Offset(4, -4),
    child: Icon(Icons.attach_file),
  );
  print('Badge with offset created');

  // Test Badge.count
  final countFactoryBadge = Badge.count(
    count: 42,
    child: Icon(Icons.notifications),
  );
  print('Badge.count created');

  // Test Badge.count with zero
  final zeroBadge = Badge.count(count: 0, child: Icon(Icons.email));
  print('Badge.count with zero created');

  // Test Badge on IconButton
  final iconButtonBadge = Badge(
    label: Text('3'),
    child: IconButton(
      icon: Icon(Icons.chat),
      onPressed: () {
        print('Chat button pressed');
      },
    ),
  );
  print('Badge on IconButton created');

  // Test Badge on NavigationDestination
  // Note: Typically used within NavigationBar
  final navDestinationBadge = Badge(
    label: Text('99+'),
    child: Icon(Icons.home),
  );
  print('Badge for navigation destination created');

  print('Tooltip and Badge widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tooltip & Badge Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Tooltip Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Hover or long-press to see tooltips)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),

        Wrap(
          spacing: 24.0,
          runSpacing: 16.0,
          children: [
            Column(
              children: [
                basicTooltip,
                Text('Basic', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                richTooltip,
                Text('Rich', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                decoratedTooltip,
                Text('Decorated', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                styledTooltip,
                Text('Styled', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                aboveTooltip,
                Text('Above', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                tapTooltip,
                Text('Tap', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                waitTooltip,
                Text('Wait 1s', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                offsetTooltip,
                Text('Offset', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),

        SizedBox(height: 32.0),
        Text('Badge Examples:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),

        Wrap(
          spacing: 24.0,
          runSpacing: 16.0,
          children: [
            Column(
              children: [
                basicBadge,
                Text('Dot', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                labelBadge,
                Text('Count 5', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                countBadge,
                Text('99+', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                coloredBadge,
                Text('Green', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                textColorBadge,
                Text('Custom', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                styledBadge,
                Text('Styled', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                paddedBadge,
                Text('Padded', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                alignedBadge,
                Text('Bottom', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text('Badge.count:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),

        Row(
          children: [
            Badge.count(count: 0, child: Icon(Icons.email, size: 32)),
            SizedBox(width: 16),
            Badge.count(count: 5, child: Icon(Icons.chat, size: 32)),
            SizedBox(width: 16),
            Badge.count(count: 42, child: Icon(Icons.notifications, size: 32)),
            SizedBox(width: 16),
            Badge.count(count: 999, child: Icon(Icons.shopping_cart, size: 32)),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Badge on IconButton:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        Row(
          children: [
            iconButtonBadge,
            SizedBox(width: 16),
            Badge(
              label: Text('10'),
              child: IconButton(icon: Icon(Icons.mail), onPressed: () {}),
            ),
            SizedBox(width: 16),
            Badge(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Badge visibility:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        Row(
          children: [
            Column(
              children: [
                Badge(
                  label: Text('1'),
                  isLabelVisible: true,
                  child: Icon(Icons.folder, size: 32),
                ),
                Text('Visible', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 32),
            Column(
              children: [
                Badge(
                  label: Text('1'),
                  isLabelVisible: false,
                  child: Icon(Icons.folder, size: 32),
                ),
                Text('Hidden', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
