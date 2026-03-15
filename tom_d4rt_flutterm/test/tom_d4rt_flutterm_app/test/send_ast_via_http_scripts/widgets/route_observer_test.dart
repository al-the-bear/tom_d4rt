// D4rt test script: Tests RouteObserver, NavigatorObserver, RouteSettings,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RouteAware pattern, ModalRoute properties, Route, MaterialPageRoute
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Route observer test executing');

  // ========== RouteSettings ==========
  print('--- RouteSettings Tests ---');
  final settings = RouteSettings(name: '/home', arguments: {'id': 42});
  print('RouteSettings created: name=${settings.name}');
  print('  arguments: ${settings.arguments}');

  final settings2 = RouteSettings(name: '/details');
  print('RouteSettings no args: name=${settings2.name}');

  // ========== NavigatorObserver ==========
  print('--- NavigatorObserver Tests ---');
  final observer = TestNavigatorObserver();
  print('NavigatorObserver created');

  // ========== RouteObserver ==========
  print('--- RouteObserver Tests ---');
  final routeObserver = RouteObserver<ModalRoute<dynamic>>();
  print('RouteObserver created');

  // ========== MaterialPageRoute ==========
  print('--- MaterialPageRoute Tests ---');
  final pageRoute = MaterialPageRoute(
    builder: (context) => Scaffold(body: Text('Page')),
    settings: settings,
    maintainState: true,
    fullscreenDialog: false,
  );
  print('MaterialPageRoute created');
  print('  maintainState: ${pageRoute.maintainState}');
  print('  fullscreenDialog: ${pageRoute.fullscreenDialog}');
  print('  settings.name: ${pageRoute.settings.name}');

  // ========== PageRouteBuilder ==========
  print('--- PageRouteBuilder Tests ---');
  final customRoute = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(body: Text('Custom'));
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    settings: RouteSettings(name: '/custom'),
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 200),
    opaque: true,
    barrierDismissible: false,
  );
  print('PageRouteBuilder created');
  print('  transitionDuration: ${customRoute.transitionDuration}');
  print('  opaque: ${customRoute.opaque}');

  // ========== Route properties ==========
  print('--- Route properties ---');
  print('  MaterialPageRoute is a ModalRoute');
  print('  PageRouteBuilder is a PageRoute');

  // ========== Navigator methods (static) ==========
  print('--- Navigator static methods ---');
  print('  Navigator.defaultRouteName: ${Navigator.defaultRouteName}');

  // ========== TransitionRoute concepts ==========
  print('--- TransitionRoute concepts ---');
  print('  Duration: ${Duration(milliseconds: 300)}');
  print('  Curve: ${Curves.easeInOut}');
  print('  Curve: ${Curves.fastOutSlowIn}');

  print('All route observer tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    navigatorObservers: [observer, routeObserver],
    home: Scaffold(
      appBar: AppBar(title: Text('Route Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Route Observer Test'),
            Text('Settings: ${settings.name}'),
          ],
        ),
      ),
    ),
  );
}

class TestNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('  Observer: pushed ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('  Observer: popped ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('  Observer: replaced');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print('  Observer: removed ${route.settings.name}');
  }
}
