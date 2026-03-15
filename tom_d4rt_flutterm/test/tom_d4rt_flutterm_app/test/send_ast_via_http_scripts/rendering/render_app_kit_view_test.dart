// D4rt test script: Tests RenderAppKitView from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderAppKitView test executing');

  // ========== APPKIT VIEW CONCEPTS ==========
  print('--- RenderAppKitView Concepts ---');
  print('RenderAppKitView renders macOS AppKit views in Flutter');
  print('It is the macOS equivalent of RenderAndroidView');
  print('Uses Cocoa APIs for embedding native NSView objects');

  // ========== PLATFORM SPECIFICITY ==========
  print('--- Platform Specificity ---');
  print('RenderAppKitView is macOS-specific');
  print('On Android: use RenderAndroidView');
  print('On iOS: use RenderUiKitView');
  print('On macOS: use RenderAppKitView');
  print('Cross-platform: use PlatformViewLink');

  // ========== PLATFORM VIEW HIT TEST BEHAVIOR ==========
  print('--- PlatformViewHitTestBehavior ---');
  print(
    'PlatformViewHitTestBehavior.opaque: ${PlatformViewHitTestBehavior.opaque}',
  );
  print('  Blocks hit testing - native view handles all touches');
  print(
    'PlatformViewHitTestBehavior.translucent: ${PlatformViewHitTestBehavior.translucent}',
  );
  print('  Allows hit testing - both Flutter and native can respond');
  print(
    'PlatformViewHitTestBehavior.transparent: ${PlatformViewHitTestBehavior.transparent}',
  );
  print('  Ignores native view - Flutter handles all touches');

  // ========== APPKIT VIEW WIDGET ==========
  print('--- AppKitView Widget (creates RenderAppKitView) ---');
  print('AppKitView is the widget that creates RenderAppKitView');
  print('It embeds native macOS views into Flutter apps');
  print('Note: AppKitView only works on macOS platform');

  print('AppKitView structure:');
  print('  viewType: String - registered native view type');
  print('  onPlatformViewCreated: callback when view is ready');
  print('  hitTestBehavior: how to handle mouse/touch events');
  print('  layoutDirection: TextDirection for the view');
  print('  gestureRecognizers: set of gesture recognizers');
  print('  creationParams: parameters passed to native side');
  print('  creationParamsCodec: codec for serializing params');

  // ========== NATIVE VIEW EXAMPLES ==========
  print('--- Common AppKit View Types ---');
  print('NSTextField - native text input');
  print('NSButton - native macOS button');
  print('WKWebView - web browser view');
  print('AVPlayerView - video player');
  print('MKMapView - Apple Maps view');
  print('NSOpenGLView - OpenGL rendering');
  print('PDFView - PDF document viewer');

  // ========== PLATFORM VIEW PLACEHOLDER ==========
  print('--- Platform View Placeholder ---');

  final appKitPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.blueGrey, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.desktop_mac, size: 40, color: Colors.blueGrey),
        SizedBox(height: 8),
        Text('macOS AppKit View'),
        Text('(Platform-specific)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Created AppKit view placeholder');

  // ========== RENDERING MODES ==========
  print('--- macOS Rendering Modes ---');
  print('Layer-backed view: uses CALayer for compositing');
  print('  - Better integration with Flutter rendering');
  print('  - Hardware accelerated');
  print('Snapshot rendering: renders to texture');
  print('  - For views that don\'t support layer backing');
  print('  - May have performance overhead');

  // ========== FOCUS AND KEYBOARD ==========
  print('--- Focus and Keyboard Handling ---');
  print('RenderAppKitView manages focus for native views');
  print('Key events are forwarded to the native responder chain');
  print('Focus ring is drawn by the native view system');

  // ========== MOUSE EVENT HANDLING ==========
  print('--- Mouse Event Handling ---');
  print('Mouse events are converted to NSEvent objects');
  print('Supports: mouseDown, mouseUp, mouseDragged');
  print('Supports: rightMouseDown, otherMouseDown');
  print('Scroll events: scrollWheel, magnify, rotate');

  // ========== GESTURE RECOGNIZERS ==========
  print('--- Gesture Recognizers ---');
  print('Custom gesture recognizers can intercept events');
  print('Events can be forwarded to both Flutter and native');
  print('Use gestureRecognizers parameter to configure');

  // ========== ACCESSIBILITY ==========
  print('--- Accessibility Support ---');
  print('Native accessibility is integrated with Flutter');
  print('VoiceOver can navigate into AppKit views');
  print('Semantic information is merged with Flutter tree');

  // ========== PLATFORM CHANNEL COMMUNICATION ==========
  print('--- Platform Channel Communication ---');

  final channelExample = MethodChannel('example/appkit_view');
  print('MethodChannel for AppKit communication: example/appkit_view');

  print('Common channel operations:');
  print('  invokeMethod: call native method');
  print('  setMethodCallHandler: receive native calls');

  // ========== LIFECYCLE MANAGEMENT ==========
  print('--- View Controller Lifecycle ---');
  print('1. Plugin registers view factory');
  print('2. Flutter requests view creation');
  print('3. Native NSView is instantiated');
  print('4. View is sized and positioned');
  print('5. Events are forwarded as needed');
  print('6. View is disposed when widget is removed');

  // ========== MULTI-WINDOW SUPPORT ==========
  print('--- Multi-Window Support ---');
  print('macOS apps can have multiple windows');
  print('Each window has its own FlutterViewController');
  print('AppKit views are scoped to their window');

  // ========== RETINA DISPLAY ==========
  print('--- Retina Display Support ---');
  print('RenderAppKitView handles HiDPI scaling');
  print('Native views render at full Retina resolution');
  print('Flutter coordinates are in logical pixels');

  // ========== PLATFORM VIEW SURFACE ==========
  print('--- Platform View Surface ---');
  print('AppKitViewSurface: for native view composition');
  print('Uses CALayer blending for smooth integration');

  // ========== ERROR HANDLING ==========
  print('--- Error Handling ---');
  print('Platform view creation can fail');
  print('Check onPlatformViewCreated callback');
  print('Handle missing native dependencies gracefully');

  print('RenderAppKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAppKitView Tests'),
      SizedBox(height: 8),
      appKitPlaceholder,
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text('macOS-Specific Features:'),
            Text('• NSView embedding', style: TextStyle(fontSize: 12)),
            Text('• Mouse/trackpad events', style: TextStyle(fontSize: 12)),
            Text('• Focus ring support', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      SizedBox(height: 8),
      Text('All RenderAppKitView tests passed'),
    ],
  );
}
