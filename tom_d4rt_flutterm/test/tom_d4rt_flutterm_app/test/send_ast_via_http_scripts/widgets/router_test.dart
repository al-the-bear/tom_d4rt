// D4rt test script: Tests Router concepts — RouterDelegate, RouteInformationParser, RouteInformationProvider from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Router test executing');

  // Router requires RouterDelegate and RouteInformationParser
  // Both are abstract classes and cannot be subclassed in D4rt
  print('RouterDelegate is abstract - cannot subclass in D4rt');
  print('RouteInformationParser is abstract - cannot subclass in D4rt');
  print('RouteInformationProvider is abstract - cannot subclass in D4rt');

  // Router widget is bridged but requires abstract delegate implementations
  print('Router widget requires concrete RouterDelegate implementation');

  // Test RouteInformation
  final routeInfo1 = RouteInformation(uri: Uri.parse('/home'));
  print('RouteInformation(uri: /home) created');
  print('RouteInformation uri: ${routeInfo1.uri}');

  final routeInfo2 = RouteInformation(uri: Uri.parse('/detail/42'));
  print('RouteInformation(uri: /detail/42) created');
  print('RouteInformation uri: ${routeInfo2.uri}');

  final routeInfo3 = RouteInformation(uri: Uri.parse('/settings?theme=dark'));
  print('RouteInformation(uri: /settings?theme=dark) created');
  print('RouteInformation uri: ${routeInfo3.uri}');

  // Test PlatformRouteInformationProvider
  final platformProvider = PlatformRouteInformationProvider(
    initialRouteInformation: RouteInformation(uri: Uri.parse('/initial')),
  );
  print('PlatformRouteInformationProvider created');
  print(
    'PlatformRouteInformationProvider runtimeType: ${platformProvider.runtimeType}',
  );

  // Since we can't create a full Router, demonstrate MaterialApp.router concept
  // MaterialApp.router is the typical way to use Router
  print('MaterialApp.router is the typical usage pattern for Router');
  print('It requires routerDelegate and routeInformationParser');

  // NavigatorObserver can be used with Router
  final observer = NavigatorObserver();
  print('NavigatorObserver created for Router context');
  print('NavigatorObserver runtimeType: ${observer.runtimeType}');

  // BackButtonDispatcher for Router
  final backDispatcher = RootBackButtonDispatcher();
  print('RootBackButtonDispatcher for Router created');

  // Show conceptual info
  final infoWidget = Container(
    padding: EdgeInsets.all(16.0),
    color: Colors.grey,
    width: 300.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Router API (Navigator 2.0):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text('Required components:'),
        Text('  - RouterDelegate (abstract)'),
        Text('  - RouteInformationParser (abstract)'),
        Text('  - RouteInformationProvider'),
        Text('  - BackButtonDispatcher'),
        SizedBox(height: 8.0),
        Text('D4rt limitation:'),
        Text('  Cannot subclass abstract delegates'),
        Text('  Use MaterialApp named routes instead'),
        SizedBox(height: 8.0),
        Text('Bridged types verified:'),
        Text('  RouteInformation: ${routeInfo1.runtimeType}'),
        Text('  RootBackButtonDispatcher: ${backDispatcher.runtimeType}'),
        Text('  NavigatorObserver: ${observer.runtimeType}'),
      ],
    ),
  );

  // Fallback: demonstrate traditional routing as alternative
  final traditionalRouting = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (ctx) => Scaffold(
        appBar: AppBar(title: Text('Router Test - Home')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Traditional routing (alternative to Router API)'),
              SizedBox(height: 8.0),
              ElevatedButton(
                child: Text('Navigate'),
                onPressed: () => print('Would navigate to /detail'),
              ),
            ],
          ),
        ),
      ),
      '/detail': (ctx) => Scaffold(
        appBar: AppBar(title: Text('Detail')),
        body: Center(child: Text('Detail page')),
      ),
    },
    navigatorObservers: [observer],
  );
  print('MaterialApp with traditional routes created as fallback');

  print('Router test completed');
  return traditionalRouting;
}
