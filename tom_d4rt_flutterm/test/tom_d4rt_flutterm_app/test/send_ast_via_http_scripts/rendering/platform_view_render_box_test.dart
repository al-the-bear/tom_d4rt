// D4rt test script: Tests PlatformViewRenderBox from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('PlatformViewRenderBox test executing');

  // ========== PlatformViewRenderBox via AndroidView ==========
  print('--- PlatformViewRenderBox via AndroidView ---');
  // PlatformViewRenderBox is abstract, test via concrete implementations
  // On Android this would be RenderAndroidView, on iOS RenderUiKitView
  print('  PlatformViewRenderBox is an abstract base class');
  print('  Concrete implementations: RenderAndroidView, RenderUiKitView');

  // ========== Test AndroidView widget (creates PlatformViewRenderBox) ==========
  print('--- AndroidView widget properties ---');
  final androidView = AndroidView(
    viewType: 'test-view-type',
    layoutDirection: TextDirection.ltr,
    creationParams: {'key': 'value'},
    creationParamsCodec: StandardMessageCodec(),
    onPlatformViewCreated: (int id) {
      print('  Platform view created with id: $id');
    },
    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
  );
  print('  AndroidView created');
  print('  viewType: test-view-type');
  print('  layoutDirection: ${TextDirection.ltr}');
  print('  hitTestBehavior: ${PlatformViewHitTestBehavior.opaque}');

  // ========== Test UiKitView widget ==========
  print('--- UiKitView widget properties ---');
  final uiKitView = UiKitView(
    viewType: 'ios-view-type',
    layoutDirection: TextDirection.rtl,
    creationParams: {'iosKey': 'iosValue'},
    creationParamsCodec: StandardMessageCodec(),
    onPlatformViewCreated: (int id) {
      print('  iOS platform view created with id: $id');
    },
    hitTestBehavior: PlatformViewHitTestBehavior.translucent,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
  );
  print('  UiKitView created');
  print('  viewType: ios-view-type');
  print('  layoutDirection: ${TextDirection.rtl}');
  print('  hitTestBehavior: ${PlatformViewHitTestBehavior.translucent}');

  // ========== PlatformViewHitTestBehavior values ==========
  print('--- PlatformViewHitTestBehavior ---');
  for (final behavior in PlatformViewHitTestBehavior.values) {
    print('  ${behavior.name}: ${behavior.index}');
  }
  print('  Total behaviors: ${PlatformViewHitTestBehavior.values.length}');

  // ========== Different hit test behaviors ==========
  print('--- Hit test behavior comparison ---');
  print('  opaque: blocks all hit tests below');
  print('  translucent: allows hit tests to pass through');
  print('  transparent: ignores hit tests');
  final opaque = PlatformViewHitTestBehavior.opaque;
  final translucent = PlatformViewHitTestBehavior.translucent;
  final transparent = PlatformViewHitTestBehavior.transparent;
  print('  opaque.index: ${opaque.index}');
  print('  translucent.index: ${translucent.index}');
  print('  transparent.index: ${transparent.index}');

  // ========== Gesture recognizer factories ==========
  print('--- Gesture recognizer factories ---');
  final tapFactory = Factory<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
  );
  final longPressFactory = Factory<LongPressGestureRecognizer>(
    () => LongPressGestureRecognizer(),
  );
  final panFactory = Factory<PanGestureRecognizer>(
    () => PanGestureRecognizer(),
  );
  print('  Created TapGestureRecognizer factory');
  print('  Created LongPressGestureRecognizer factory');
  print('  Created PanGestureRecognizer factory');

  // ========== AndroidView with gesture recognizers ==========
  print('--- AndroidView with gestures ---');
  final androidViewWithGestures = AndroidView(
    viewType: 'gesture-view',
    layoutDirection: TextDirection.ltr,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
      Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
      Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()),
    },
  );
  print('  Created AndroidView with tap and long press recognizers');

  // ========== Platform view parameters testing ==========
  print('--- Creation params codec types ---');
  final standardCodec = StandardMessageCodec();
  final jsonCodec = JSONMessageCodec();
  print('  StandardMessageCodec available');
  print('  JSONMessageCodec available');

  // ========== Layout direction options ==========
  print('--- Layout directions ---');
  print('  TextDirection.ltr: ${TextDirection.ltr}');
  print('  TextDirection.rtl: ${TextDirection.rtl}');
  print('  LTR index: ${TextDirection.ltr.index}');
  print('  RTL index: ${TextDirection.rtl.index}');

  print('PlatformViewRenderBox test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PlatformViewRenderBox Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('AndroidView widget created'),
          Text('UiKitView widget created'),
          Text(
            'Hit test behaviors: ${PlatformViewHitTestBehavior.values.length}',
          ),
          Text('Opaque: blocks hit tests'),
          Text('Translucent: passes hit tests'),
          Text('Transparent: ignores hit tests'),
          Text('Gesture recognizers: tap, longPress, pan'),
          Text('Layout directions: LTR, RTL'),
        ],
      ),
    ),
  );
}
