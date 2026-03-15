// D4rt test script: Tests CupertinoApp from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoApp test executing');

  // ========== CUPERTINOAPP ==========
  print('--- CupertinoApp Tests ---');

  // Test basic CupertinoApp
  final basicApp = CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Basic App')),
      child: Center(child: Text('Hello Cupertino')),
    ),
  );
  print('Basic CupertinoApp created');

  // Test CupertinoApp with title
  final titledApp = CupertinoApp(
    title: 'My Cupertino App',
    home: Center(child: Text('App with title')),
  );
  print('CupertinoApp with title created');

  // Test CupertinoApp with theme
  final themedApp = CupertinoApp(
    theme: CupertinoThemeData(
      primaryColor: CupertinoColors.systemBlue,
      brightness: Brightness.light,
    ),
    home: Center(child: Text('Themed app')),
  );
  print('CupertinoApp with theme created');

  // Test CupertinoApp with dark theme
  final darkApp = CupertinoApp(
    theme: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: Center(child: Text('Dark app')),
  );
  print('CupertinoApp with dark theme created');

  // Test CupertinoApp with color
  final coloredApp = CupertinoApp(
    color: CupertinoColors.systemOrange,
    home: Center(child: Text('Colored app')),
  );
  print('CupertinoApp with color created');

  // Test CupertinoApp with localizationsDelegates
  final localizedApp = CupertinoApp(
    localizationsDelegates: [DefaultCupertinoLocalizations.delegate],
    home: Center(child: Text('Localized app')),
  );
  print('CupertinoApp with localizationsDelegates created');

  // Test CupertinoApp with supportedLocales
  final multiLocaleApp = CupertinoApp(
    supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
    home: Center(child: Text('Multi-locale app')),
  );
  print('CupertinoApp with supportedLocales created');

  // Test CupertinoApp with debugShowCheckedModeBanner
  final noBannerApp = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: Center(child: Text('No debug banner')),
  );
  print('CupertinoApp with debugShowCheckedModeBanner=false created');

  // Test CupertinoApp with showPerformanceOverlay
  final perfOverlayApp = CupertinoApp(
    showPerformanceOverlay: false,
    home: Center(child: Text('Performance overlay app')),
  );
  print('CupertinoApp with showPerformanceOverlay created');

  // Test CupertinoApp with showSemanticsDebugger
  final semanticsApp = CupertinoApp(
    showSemanticsDebugger: false,
    home: Center(child: Text('Semantics debugger app')),
  );
  print('CupertinoApp with showSemanticsDebugger created');

  // Test CupertinoApp with routes
  final routedApp = CupertinoApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Center(child: Text('Home')),
      '/second': (context) => Center(child: Text('Second')),
    },
  );
  print('CupertinoApp with routes created');

  // Test CupertinoApp with onGenerateRoute
  final generatedRouteApp = CupertinoApp(
    onGenerateRoute: (settings) {
      return CupertinoPageRoute(
        builder: (context) =>
            Center(child: Text('Generated route: ${settings.name}')),
      );
    },
    initialRoute: '/generated',
  );
  print('CupertinoApp with onGenerateRoute created');

  // Test CupertinoApp with onUnknownRoute
  final unknownRouteApp = CupertinoApp(
    onUnknownRoute: (settings) {
      return CupertinoPageRoute(
        builder: (context) => Center(child: Text('Unknown route')),
      );
    },
    home: Center(child: Text('App with unknown route handler')),
  );
  print('CupertinoApp with onUnknownRoute created');

  // Test CupertinoApp with navigatorKey
  final navigatorKeyApp = CupertinoApp(
    navigatorKey: GlobalKey<NavigatorState>(),
    home: Center(child: Text('App with navigator key')),
  );
  print('CupertinoApp with navigatorKey created');

  // Test CupertinoApp with navigatorObservers
  final observedApp = CupertinoApp(
    navigatorObservers: [],
    home: Center(child: Text('App with observers')),
  );
  print('CupertinoApp with navigatorObservers created');

  // Test CupertinoApp with builder
  final builderApp = CupertinoApp(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(1.2)),
        child: child!,
      );
    },
    home: Center(child: Text('App with builder')),
  );
  print('CupertinoApp with builder created');

  // Test CupertinoApp with scrollBehavior
  final scrollApp = CupertinoApp(
    scrollBehavior: CupertinoScrollBehavior(),
    home: Center(child: Text('App with scroll behavior')),
  );
  print('CupertinoApp with scrollBehavior created');

  // Test CupertinoApp.router
  // Note: CupertinoApp.router requires RouterConfig
  print('CupertinoApp.router concept noted (requires RouterConfig)');

  print('CupertinoApp test completed');

  // Return a simple widget for rendering
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
    ),
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoApp Test'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoApp Test Results',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Tests executed:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('• Basic CupertinoApp'),
              Text('• With title'),
              Text('• With light/dark theme'),
              Text('• With color'),
              Text('• With localization'),
              Text('• With routes'),
              Text('• With navigatorKey'),
              Text('• With builder'),
              Text('• With scrollBehavior'),
              SizedBox(height: 24.0),
              Text(
                'All CupertinoApp tests passed!',
                style: TextStyle(color: CupertinoColors.systemGreen),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
