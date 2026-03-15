// D4rt test script: Tests Navigator widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigator test executing');

  // Test Navigator.of to check context access
  try {
    final navigator = Navigator.of(context);
    print('Navigator.of(context) accessed successfully');
    print('Navigator canPop: ${navigator.canPop()}');
  } catch (e) {
    print('Navigator.of(context) - expected in test: $e');
  }

  // Test Navigator with routes using Builder for context
  final navigatorTest = MaterialApp(
    home: Builder(
      builder: (innerContext) {
        return Scaffold(
          appBar: AppBar(title: Text('Navigator Test')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Push Named Route'),
                  onPressed: () {
                    print('Would push named route /second');
                    // Navigator.pushNamed(innerContext, '/second');
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Push MaterialPageRoute'),
                  onPressed: () {
                    print('Would push MaterialPageRoute');
                    // Navigator.push(innerContext, MaterialPageRoute(
                    //   builder: (_) => SecondPage(),
                    // ));
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Push Replacement'),
                  onPressed: () {
                    print('Would pushReplacement');
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Pop'),
                  onPressed: () {
                    print('Would pop');
                    // Navigator.pop(innerContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
    routes: {
      '/second': (context) => Scaffold(
        appBar: AppBar(title: Text('Second Page')),
        body: Center(child: Text('Second Page Content')),
      ),
      '/third': (context) => Scaffold(
        appBar: AppBar(title: Text('Third Page')),
        body: Center(child: Text('Third Page Content')),
      ),
    },
  );
  print('Navigator with named routes created');

  // Test creating route settings
  final routeSettings = RouteSettings(
    name: '/test-route',
    arguments: {'id': 123, 'name': 'Test'},
  );
  print(
    'RouteSettings created: name=${routeSettings.name}, arguments=${routeSettings.arguments}',
  );

  // Test MaterialPageRoute
  final materialRoute = MaterialPageRoute(
    builder: (context) => Scaffold(body: Center(child: Text('Route Content'))),
    settings: RouteSettings(name: '/material-route'),
    maintainState: true,
    fullscreenDialog: false,
  );
  print('MaterialPageRoute created with settings=/material-route');

  // Test MaterialPageRoute as fullscreen dialog
  final dialogRoute = MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: Text('Dialog Route')),
      body: Center(child: Text('Fullscreen Dialog')),
    ),
    fullscreenDialog: true,
  );
  print('MaterialPageRoute with fullscreenDialog=true created');

  // Test PageRouteBuilder
  final customRoute = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(body: Center(child: Text('Custom Route')));
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 200),
    settings: RouteSettings(name: '/custom'),
  );
  print('PageRouteBuilder with FadeTransition created');

  // Test NavigatorObserver
  final observer = NavigatorObserver();
  print('NavigatorObserver created');

  // Test Navigator widget with onGenerateRoute
  final generatedRoutes = Navigator(
    pages: const <Page<dynamic>>[],
    transitionDelegate: DefaultTransitionDelegate<dynamic>(),
    routeTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    routeDirectionalTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    onGenerateRoute: (settings) {
      print('onGenerateRoute called for: ${settings.name}');
      if (settings.name == '/') {
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Home'))),
        );
      }
      if (settings.name == '/details') {
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Details: ${args?['id']}'))),
        );
      }
      return null;
    },
    onUnknownRoute: (settings) {
      print('onUnknownRoute called for: ${settings.name}');
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text('404'))),
      );
    },
    initialRoute: '/',
  );
  print('Navigator with onGenerateRoute and onUnknownRoute created');

  // Test Navigator with observers
  final withObservers = Navigator(
    pages: const <Page<dynamic>>[],
    transitionDelegate: DefaultTransitionDelegate<dynamic>(),
    routeTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    routeDirectionalTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    observers: [NavigatorObserver()],
    onGenerateRoute: (settings) =>
        MaterialPageRoute(builder: (_) => Center(child: Text('Observed'))),
    initialRoute: '/',
  );
  print('Navigator with observers list created');

  // Test popUntil predicate concept
  bool popUntilPredicate(Route route) {
    return route.settings.name == '/home';
  }

  print('PopUntil predicate function created');

  // Test canPop concept
  print('Navigator.canPop checks if there is more than one route');

  // Test maybePop concept
  print('Navigator.maybePop pops if possible, returns true if popped');

  // Test pushAndRemoveUntil concept
  print(
    'Navigator.pushAndRemoveUntil pushes and removes routes until predicate',
  );

  // Test popAndPushNamed concept
  print('Navigator.popAndPushNamed pops current and pushes named route');

  // Test restorableState methods
  print('Navigator.restorablePush for state restoration');
  print('Navigator.restorablePushNamed for restorable named routes');

  print('Navigator test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navigator Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'Navigator API Tests:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text('• Navigator.of(context) - access navigator'),
          Text('• Navigator.push - push route'),
          Text('• Navigator.pushNamed - push named route'),
          Text('• Navigator.pop - pop route'),
          Text('• Navigator.pushReplacement - replace current'),
          Text('• Navigator.pushAndRemoveUntil - push and clear stack'),
          Text('• Navigator.popUntil - pop until predicate'),
          Text('• Navigator.canPop - check if can pop'),
          Text('• Navigator.maybePop - pop if possible'),
          SizedBox(height: 16.0),
          Text(
            'Route Types:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text('• MaterialPageRoute - standard page route'),
          Text('• PageRouteBuilder - custom transitions'),
          Text('• RouteSettings - route configuration'),
          SizedBox(height: 16.0),
          Container(height: 400.0, child: navigatorTest),
        ],
      ),
    ),
  );
}
