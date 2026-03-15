// D4rt test script: Tests MaterialApp widget from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialApp test executing');

  // Test basic MaterialApp
  final basicApp = MaterialApp(
    home: Scaffold(body: Center(child: Text('Basic MaterialApp'))),
  );
  print('Basic MaterialApp with home created');

  // Test MaterialApp with title
  final withTitle = MaterialApp(
    title: 'My App Title',
    home: Scaffold(body: Center(child: Text('With Title'))),
  );
  print('MaterialApp with title created');

  // Test MaterialApp with theme
  final withTheme = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
    home: Scaffold(body: Center(child: Text('With Theme'))),
  );
  print('MaterialApp with light theme created');

  // Test MaterialApp with darkTheme
  final withDarkTheme = MaterialApp(
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
    home: Scaffold(body: Center(child: Text('With Dark Theme'))),
  );
  print('MaterialApp with dark theme created');

  // Test MaterialApp with themeMode
  print('ThemeMode.system - follows system setting');
  print('ThemeMode.light - always light theme');
  print('ThemeMode.dark - always dark theme');

  // Test MaterialApp with routes
  final withRoutes = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Scaffold(body: Center(child: Text('Home'))),
      '/second': (context) => Scaffold(body: Center(child: Text('Second'))),
      '/third': (context) => Scaffold(body: Center(child: Text('Third'))),
    },
  );
  print('MaterialApp with named routes created');

  // Test MaterialApp with onGenerateRoute
  final withGenerateRoute = MaterialApp(
    onGenerateRoute: (settings) {
      print('onGenerateRoute for: ${settings.name}');
      if (settings.name == '/details') {
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text('Details: ${args?["id"]}'))),
        );
      }
      return MaterialPageRoute(
        builder: (context) => Scaffold(body: Center(child: Text('Unknown'))),
      );
    },
    initialRoute: '/',
  );
  print('MaterialApp with onGenerateRoute created');

  // Test MaterialApp with onUnknownRoute
  final withUnknownRoute = MaterialApp(
    onUnknownRoute: (settings) {
      print('Unknown route: ${settings.name}');
      return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('404 - Not Found'))),
      );
    },
    home: Scaffold(body: Center(child: Text('Home'))),
  );
  print('MaterialApp with onUnknownRoute created');

  // Test MaterialApp with navigatorKey
  final navigatorKey = GlobalKey<NavigatorState>();
  final withNavKey = MaterialApp(
    navigatorKey: navigatorKey,
    home: Scaffold(body: Center(child: Text('With Navigator Key'))),
  );
  print('MaterialApp with navigatorKey created');

  // Test MaterialApp with navigatorObservers
  final withObservers = MaterialApp(
    navigatorObservers: [NavigatorObserver()],
    home: Scaffold(body: Center(child: Text('With Observers'))),
  );
  print('MaterialApp with navigatorObservers created');

  // Test MaterialApp with debugShowCheckedModeBanner
  final noBanner = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: Text('No Debug Banner'))),
  );
  print('MaterialApp with debugShowCheckedModeBanner=false created');

  // Test MaterialApp with locale
  final withLocale = MaterialApp(
    locale: Locale('en', 'US'),
    home: Scaffold(body: Center(child: Text('English US'))),
  );
  print('MaterialApp with locale=en_US created');

  // Test MaterialApp with localizationsDelegates
  print('MaterialApp.localizationsDelegates for internationalization');

  // Test MaterialApp with supportedLocales
  final withSupportedLocales = MaterialApp(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('es', 'ES'),
      Locale('de', 'DE'),
    ],
    home: Scaffold(body: Center(child: Text('Multi-locale'))),
  );
  print('MaterialApp with supportedLocales created');

  // Test MaterialApp with builder
  final withBuilder = MaterialApp(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
        child: child!,
      );
    },
    home: Scaffold(body: Center(child: Text('With Builder'))),
  );
  print('MaterialApp with builder created');

  // Test MaterialApp with scrollBehavior
  final withScrollBehavior = MaterialApp(
    scrollBehavior: MaterialScrollBehavior(),
    home: Scaffold(body: Center(child: Text('Custom Scroll'))),
  );
  print('MaterialApp with scrollBehavior created');

  // Test MaterialApp with shortcuts
  print('MaterialApp.shortcuts for keyboard shortcuts');

  // Test MaterialApp with actions
  print('MaterialApp.actions for action intents');

  // Test MaterialApp with restorationScopeId
  final withRestoration = MaterialApp(
    restorationScopeId: 'root',
    home: Scaffold(body: Center(child: Text('With Restoration'))),
  );
  print('MaterialApp with restorationScopeId created');

  // Test MaterialApp.router
  print('MaterialApp.router for Router-based navigation');

  // Test showAboutDialog
  print('showAboutDialog() for about dialog');

  // Test showDatePicker
  print('showDatePicker() for date selection');

  // Test showTimePicker
  print('showTimePicker() for time selection');

  // Test showModalBottomSheet
  print('showModalBottomSheet() for bottom sheets');

  // Test showDialog
  print('showDialog() for dialogs');

  print('MaterialApp test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialApp Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Theme Support:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• theme - light theme'),
        Text('• darkTheme - dark theme'),
        Text('• themeMode - system/light/dark'),
        Text('• highContrastTheme - accessibility'),
        SizedBox(height: 16.0),

        Text('Navigation:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• home - initial widget'),
        Text('• initialRoute - initial route name'),
        Text('• routes - named route map'),
        Text('• onGenerateRoute - dynamic routes'),
        Text('• onUnknownRoute - 404 handler'),
        Text('• navigatorKey - external nav access'),
        Text('• navigatorObservers - route observers'),
        SizedBox(height: 16.0),

        Text('Localization:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• locale - current locale'),
        Text('• localizationsDelegates - l10n delegates'),
        Text('• supportedLocales - available locales'),
        Text('• localeListResolutionCallback'),
        Text('• localeResolutionCallback'),
        SizedBox(height: 16.0),

        Text('Configuration:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• title - app title'),
        Text('• color - app color'),
        Text('• debugShowCheckedModeBanner - debug banner'),
        Text('• showPerformanceOverlay - performance'),
        Text('• showSemanticsDebugger - semantics'),
        Text('• builder - widget wrapper'),
        Text('• scrollBehavior - scroll physics'),
        SizedBox(height: 16.0),

        Text(
          'Embedded App Demo:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: basicApp,
        ),
      ],
    ),
  );
}
