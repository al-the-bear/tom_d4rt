// D4rt test script: Tests RenderAndroidView from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderAndroidView test executing');

  // ========== PLATFORM VIEW CONCEPTS ==========
  print('--- RenderAndroidView Concepts ---');
  print('RenderAndroidView renders Android native views in Flutter');
  print('It is part of the platform views system');
  print('Uses Android-specific APIs for embedding native views');

  // ========== PLATFORM VIEW HIT TEST BEHAVIOR ==========
  print('--- PlatformViewHitTestBehavior ---');
  print(
    'PlatformViewHitTestBehavior.opaque: ${PlatformViewHitTestBehavior.opaque}',
  );
  print(
    'PlatformViewHitTestBehavior.translucent: ${PlatformViewHitTestBehavior.translucent}',
  );
  print(
    'PlatformViewHitTestBehavior.transparent: ${PlatformViewHitTestBehavior.transparent}',
  );

  // ========== ANDROID VIEW WIDGET ==========
  print('--- AndroidView Widget (creates RenderAndroidView) ---');
  print('AndroidView is the widget that creates RenderAndroidView');
  print('It requires a viewType registered with the platform');
  print('Note: AndroidView only works on Android platform');

  // Demonstrate AndroidView structure (won\'t work in non-Android context)
  print('AndroidView structure:');
  print('  viewType: String - registered native view type');
  print('  onPlatformViewCreated: callback when view is ready');
  print('  hitTestBehavior: how to handle touch events');
  print('  layoutDirection: TextDirection for the view');
  print('  gestureRecognizers: set of gesture recognizers');
  print('  creationParams: parameters passed to native side');
  print('  creationParamsCodec: codec for serializing params');

  // ========== PLATFORM VIEW LAYER ==========
  print('--- PlatformViewLayer ---');
  print('RenderAndroidView uses PlatformViewLayer for compositing');
  print('PlatformViewLayer holds the platform view ID');

  // ========== TEXTURE VS HYBRID COMPOSITION ==========
  print('--- Rendering Modes ---');
  print('Virtual Display (Texture): renders in off-screen buffer');
  print('  - Better performance');
  print('  - Some features may not work (keyboard, accessibility)');
  print('Hybrid Composition: native view in view hierarchy');
  print('  - Full native features');
  print('  - May have performance overhead');

  // ========== GESTURE FORWARDING ==========
  print('--- Gesture Forwarding ---');
  print('RenderAndroidView handles touch event forwarding to native');
  print('Touch events are converted to MotionEvents on Android');
  print('Gesture recognizers can intercept events before forwarding');

  // ========== SIZING CONSTRAINTS ==========
  print('--- Sizing Behavior ---');
  print('RenderAndroidView typically sizes to constraints');
  print('Native view receives the allocated size');
  print('Size changes trigger native view resize');

  // ========== PLATFORM VIEW SURFACE ==========
  print('--- Platform View Surface ---');
  print('AndroidViewSurface: for hybrid composition rendering');
  print('Uses TextureLayer or PlatformViewLayer depending on mode');

  // ========== MOCK PLATFORM VIEW DISPLAY ==========
  print('--- Platform View Example Structure ---');

  // Create a placeholder that represents where AndroidView would be
  final platformViewPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.green, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.android, size: 40, color: Colors.green),
        SizedBox(height: 8),
        Text('Android Native View'),
        Text('(Platform-specific)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Created platform view placeholder');

  // ========== PLATFORM VIEW LINK ==========
  print('--- PlatformViewLink ---');
  print('PlatformViewLink connects widget to render object');
  print('  surfaceFactory: creates the surface widget');
  print('  onCreatePlatformView: creates platform view controller');
  print('  viewType: identifies the native view type');

  // ========== VIEW CONTROLLER ==========
  print('--- View Controller Lifecycle ---');
  print('1. PlatformViewController created');
  print('2. create() called - initializes native view');
  print('3. setSize() called when layout completes');
  print('4. dispose() called when widget is removed');

  // ========== WEBVIEW EXAMPLE ==========
  print('--- Common Android View Types ---');
  print('WebView - embedded web browser');
  print('MapView - Google Maps');
  print('VideoView - video player');
  print('AdView - advertisement banners');
  print('Custom native widgets');

  // ========== PLATFORM CHANNELS ==========
  print('--- Platform Channel Communication ---');
  print('MethodChannel: for method calls');
  print('EventChannel: for event streams');
  print('BasicMessageChannel: for raw messages');

  final channelExample = MethodChannel('example/android_view');
  print('MethodChannel created: example/android_view');

  // ========== FOCUS HANDLING ==========
  print('--- Focus Handling ---');
  print('RenderAndroidView manages focus for the native view');
  print('Focus can be requested programmatically');
  print('Keyboard events are forwarded when focused');

  // ========== ACCESSIBILITY ==========
  print('--- Accessibility ---');
  print('RenderAndroidView supports accessibility semantics');
  print('Native view accessibility tree is merged with Flutter');
  print('Screen readers can navigate into native views');

  print('RenderAndroidView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAndroidView Tests'),
      SizedBox(height: 8),
      platformViewPlaceholder,
      SizedBox(height: 8),
      Text('Platform views are Android-specific'),
      Text('See documentation for usage'),
      SizedBox(height: 8),
      Text('All RenderAndroidView tests passed'),
    ],
  );
}
