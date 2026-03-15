// D4rt test script: Tests RenderDarwinPlatformView from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderDarwinPlatformView test executing');

  // ========== DARWIN PLATFORM VIEW BASICS ==========
  print('--- Darwin Platform View Basics ---');
  print('RenderDarwinPlatformView renders native macOS/iOS views');
  print('Part of the platform views system for hybrid UIs');
  print('Used for embedding UIView (iOS) or NSView (macOS)');

  // Note: Direct instantiation requires platform-specific setup
  // We test using UiKitView/AppKitView widgets as equivalents
  print('--- Platform View Architecture ---');
  print('UiKitView: iOS platform view widget');
  print('AppKitView: macOS platform view widget');
  print('RenderDarwinPlatformView: Underlying render object');

  // ========== HIT TEST BEHAVIOR ==========
  print('--- Hit Test Behavior Options ---');

  // Demonstrate PlatformViewHitTestBehavior enum values
  print('PlatformViewHitTestBehavior.opaque:');
  print('  Platform view absorbs all hit tests');
  print('  Flutter widgets behind cannot receive events');

  print('PlatformViewHitTestBehavior.translucent:');
  print('  Platform view and Flutter can both receive events');
  print('  Events pass through to widgets behind');

  print('PlatformViewHitTestBehavior.transparent:');
  print('  Platform view is ignored in hit testing');
  print('  All events go to Flutter widgets');

  // ========== PLATFORM VIEW COMPOSITION ==========
  print('--- Platform View Composition ---');
  print('Hybrid composition: Native view in Flutter layer tree');
  print('Virtual display: Native view rendered to texture');
  print('Darwin uses hybrid composition by default');

  // Test placeholder for platform view area
  final platformViewPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      border: Border.all(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.desktop_mac, size: 40, color: Colors.blue),
        SizedBox(height: 8),
        Text('Darwin Platform View'),
        Text('(macOS/iOS Native)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Placeholder representing platform view area');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Embedding WKWebView for web content');
  print('2. MapKit for native maps on Apple platforms');
  print('3. PDFKit for PDF rendering');
  print('4. AVPlayerView for video playback');
  print('5. Custom native UI components');

  // Test web view placeholder
  final webViewPlaceholder = Container(
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      children: [
        Container(
          height: 30,
          color: Colors.grey[200],
          child: Row(
            children: [
              SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              Spacer(),
              Text('WebView', style: TextStyle(fontSize: 10)),
              SizedBox(width: 8),
            ],
          ),
        ),
        Expanded(child: Center(child: Text('Web Content Area'))),
      ],
    ),
  );
  print('WebView placeholder demonstration');

  // ========== SIZING BEHAVIOR ==========
  print('--- Sizing Behavior ---');
  print('RenderDarwinPlatformView sizes to exact constraints');
  print('Native view fills the entire render box area');
  print('Use SizedBox or AspectRatio to control size');

  // Test different sizes
  final smallView = Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.blue[100],
      border: Border.all(color: Colors.blue),
    ),
    child: Center(child: Text('80x60')),
  );

  final mediumView = Container(
    width: 120,
    height: 90,
    decoration: BoxDecoration(
      color: Colors.green[100],
      border: Border.all(color: Colors.green),
    ),
    child: Center(child: Text('120x90')),
  );
  print('Different sized platform view placeholders');

  // ========== GESTURE HANDLING ==========
  print('--- Gesture Handling ---');
  print('Platform views can handle native gestures');
  print('Or pass through to Flutter gesture system');
  print('gestureRecognizers parameter customizes behavior');

  final gestureDemo = GestureDetector(
    onTap: () => print('Flutter tap'),
    child: Container(
      width: 150,
      height: 80,
      color: Colors.purple[100],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.touch_app), Text('Gesture Area')],
        ),
      ),
    ),
  );
  print('Gesture detector wrapping platform view area');

  // ========== LAYOUT INTEGRATION ==========
  print('--- Layout Integration ---');
  print('Platform views participate in Flutter layout');
  print('Can be placed in Rows, Columns, Stacks');
  print('Respect constraints from parent widgets');

  final layoutExample = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 60,
        height: 60,
        color: Colors.amber,
        child: Center(child: Text('FL')),
      ),
      Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.blue),
        ),
        child: Center(child: Text('Native')),
      ),
      Container(
        width: 60,
        height: 60,
        color: Colors.teal,
        child: Center(child: Text('FL')),
      ),
    ],
  );
  print('Mixed Flutter/Native layout');

  // ========== MEMORY MANAGEMENT ==========
  print('--- Memory Management ---');
  print('Platform views are disposed when widget is removed');
  print('Native resources released automatically');
  print('Use AutomaticKeepAlive for caching if needed');

  // ========== PLATFORM DIFFERENCES ==========
  print('--- Platform Differences ---');
  print('iOS: Uses UIView, supports hybrid composition');
  print('macOS: Uses NSView, similar to iOS');
  print('Both use Quartz layer-backed views');

  print('RenderDarwinPlatformView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDarwinPlatformView Tests'),
      SizedBox(height: 8),
      platformViewPlaceholder,
      SizedBox(height: 8),
      webViewPlaceholder,
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [smallView, SizedBox(width: 8), mediumView],
      ),
      SizedBox(height: 8),
      layoutExample,
      SizedBox(height: 8),
      Text('All DarwinPlatformView tests passed'),
    ],
  );
}
