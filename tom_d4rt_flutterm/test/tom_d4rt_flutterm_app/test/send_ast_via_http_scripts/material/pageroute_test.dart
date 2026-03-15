// D4rt test script: Tests MaterialPageRoute, RouteSettings, MaterialPage from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialPageRoute/RouteSettings/MaterialPage test executing');

  // ========== ROUTESETTINGS ==========
  print('--- RouteSettings Tests ---');

  // Variation 1: Basic RouteSettings
  final settings1 = RouteSettings(name: '/home');
  print('RouteSettings(name: /home) created');
  print('  name: ${settings1.name}');

  // Variation 2: RouteSettings with arguments
  final settings2 = RouteSettings(name: '/detail', arguments: 'item-42');
  print('RouteSettings(name: /detail, arguments: item-42) created');
  print('  name: ${settings2.name}, arguments: ${settings2.arguments}');

  // Variation 3: RouteSettings with map arguments
  final settings3 = RouteSettings(
    name: '/user',
    arguments: {'id': 123, 'name': 'Alice'},
  );
  print('RouteSettings(name: /user, arguments: map) created');
  print('  arguments: ${settings3.arguments}');

  // Variation 4: RouteSettings with no name
  final settings4 = RouteSettings();
  print('RouteSettings() created');
  print('  name: ${settings4.name}');

  // ========== MATERIALPAGEROUTE ==========
  print('--- MaterialPageRoute Tests ---');

  // Variation 5: Basic MaterialPageRoute
  final route1 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(title: Text('Route Page')),
        body: Center(child: Text('Hello from route')),
      );
    },
  );
  print('MaterialPageRoute(builder) created');
  print('  runtimeType: ${route1.runtimeType}');

  // Variation 6: MaterialPageRoute with settings
  final route2 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('Test'));
    },
    settings: RouteSettings(name: '/test'),
  );
  print('MaterialPageRoute(settings: /test) created');
  print('  settings.name: ${route2.settings.name}');

  // Variation 7: MaterialPageRoute with maintainState false
  final route3 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('No state'));
    },
    maintainState: false,
  );
  print('MaterialPageRoute(maintainState: false) created');
  print('  maintainState: ${route3.maintainState}');

  // Variation 8: MaterialPageRoute with fullscreenDialog
  final route4 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(title: Text('Dialog Route')),
        body: Center(child: Text('Fullscreen dialog')),
      );
    },
    fullscreenDialog: true,
  );
  print('MaterialPageRoute(fullscreenDialog: true) created');
  print('  fullscreenDialog: ${route4.fullscreenDialog}');

  // Variation 9: MaterialPageRoute with settings and arguments
  final route5 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('Args route'));
    },
    settings: RouteSettings(name: '/args', arguments: [1, 2, 3]),
  );
  print('MaterialPageRoute(settings with arguments) created');
  print('  settings.arguments: ${route5.settings.arguments}');

  // ========== MATERIALPAGE ==========
  print('--- MaterialPage Tests ---');

  // Variation 10: Basic MaterialPage
  final page1 = MaterialPage(
    child: Scaffold(body: Center(child: Text('Material Page'))),
  );
  print('MaterialPage(child: Scaffold) created');
  print('  runtimeType: ${page1.runtimeType}');

  // Variation 11: MaterialPage with key
  final page2 = MaterialPage(
    key: ValueKey('home-page'),
    child: Center(child: Text('Keyed Page')),
  );
  print('MaterialPage(key: home-page) created');
  print('  key: ${page2.key}');

  // Variation 12: MaterialPage with name
  final page3 = MaterialPage(
    name: '/profile',
    child: Center(child: Text('Profile Page')),
  );
  print('MaterialPage(name: /profile) created');
  print('  name: ${page3.name}');

  // Variation 13: MaterialPage with arguments
  final page4 = MaterialPage(
    name: '/item',
    arguments: 'item-99',
    child: Center(child: Text('Item Page')),
  );
  print('MaterialPage(name: /item, arguments: item-99) created');
  print('  arguments: ${page4.arguments}');

  // Variation 14: MaterialPage with maintainState and fullscreenDialog
  final page5 = MaterialPage(
    maintainState: false,
    fullscreenDialog: true,
    child: Scaffold(
      appBar: AppBar(title: Text('FS Dialog Page')),
      body: Center(child: Text('Fullscreen')),
    ),
  );
  print('MaterialPage(maintainState: false, fullscreenDialog: true) created');

  print('MaterialPageRoute/RouteSettings/MaterialPage test completed');
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialPageRoute tests completed',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('RouteSettings: 4 variations tested'),
        Text('MaterialPageRoute: 5 variations tested'),
        Text('MaterialPage: 5 variations tested'),
        SizedBox(height: 16),
        Text(
          'Note: Routes constructed and inspected without navigation.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
