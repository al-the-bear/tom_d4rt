// D4rt test script: Tests AssetImage, NetworkImage, ExactAssetImage from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Asset services test executing');

  // ========== ASSETIMAGE ==========
  print('--- AssetImage Tests ---');

  final assetImage = AssetImage('icon.png');
  print('AssetImage: ${assetImage.runtimeType}');
  print('AssetImage keyName: ${assetImage.keyName}');
  print('AssetImage assetName: ${assetImage.assetName}');

  // AssetImage with package
  final packageAsset = AssetImage('images/logo.png', package: 'my_package');
  print('Package AssetImage: ${packageAsset.runtimeType}');
  print('Package AssetImage keyName: ${packageAsset.keyName}');
  print('Package AssetImage package: ${packageAsset.package}');

  // ExactAssetImage with scale
  final exactAsset = ExactAssetImage('icon@2x.png', scale: 2.0);
  print('ExactAssetImage: ${exactAsset.runtimeType}');
  print('ExactAssetImage keyName: ${exactAsset.keyName}');
  print('ExactAssetImage scale: ${exactAsset.scale}');

  // ========== NETWORKIMAGE ==========
  print('--- NetworkImage Tests ---');

  final networkImage = NetworkImage(
    'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
    scale: 1.0,
  );
  print('NetworkImage: ${networkImage.runtimeType}');
  print('NetworkImage url: ${networkImage.url}');
  print('NetworkImage scale: ${networkImage.scale}');

  // NetworkImage with scale
  final scaledNetworkImage = NetworkImage(
    'https://flutter.dev/favicon.ico',
    scale: 2.0,
  );
  print('Scaled NetworkImage url: ${scaledNetworkImage.url}');
  print('Scaled NetworkImage scale: ${scaledNetworkImage.scale}');

  // ========== MEMORYIMAGE ==========
  print('--- MemoryImage Tests ---');

  // Create a minimal 1x1 transparent PNG as bytes
  // (just test constructor, not actual rendering)
  // We can't easily create real image bytes in a D4rt script,
  // but we can verify the class exists and its type

  // ========== FILEIMAGEPROVIDER PROPERTIES ==========
  print('--- Image Provider Properties ---');

  // Test equality
  final asset1 = AssetImage('test.png');
  final asset2 = AssetImage('test.png');
  print('AssetImage equality: ${asset1 == asset2}');
  print('AssetImage hashCode match: ${asset1.hashCode == asset2.hashCode}');

  final net1 = NetworkImage('https://example.com/a.png', scale: 1.0);
  final net2 = NetworkImage('https://example.com/a.png', scale: 1.0);
  print('NetworkImage equality: ${net1 == net2}');
  print('NetworkImage hashCode match: ${net1.hashCode == net2.hashCode}');

  final net3 = NetworkImage('https://example.com/b.png', scale: 1.0);
  print('Different NetworkImage equality: ${net1 == net3}');

  // ========== DECORATIONIMAGE ==========
  print('--- DecorationImage Tests ---');

  final decoImage = DecorationImage(
    image: NetworkImage('https://example.com/bg.png', scale: 1.0),
    fit: BoxFit.cover,
    alignment: Alignment.center,
    repeat: ImageRepeat.noRepeat,
  );
  print('DecorationImage: ${decoImage.runtimeType}');
  print('DecorationImage fit: ${decoImage.fit}');
  print('DecorationImage alignment: ${decoImage.alignment}');
  print('DecorationImage repeat: ${decoImage.repeat}');

  // DecorationImage with more options
  final decoImage2 = DecorationImage(
    image: AssetImage('background.png'),
    fit: BoxFit.contain,
    alignment: Alignment.topCenter,
    repeat: ImageRepeat.repeatX,
    opacity: 0.8,
    filterQuality: FilterQuality.high,
  );
  print('DecorationImage2 fit: ${decoImage2.fit}');
  print('DecorationImage2 opacity: ${decoImage2.opacity}');
  print('DecorationImage2 filterQuality: ${decoImage2.filterQuality}');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Asset services test'),
        SizedBox(height: 8.0),
        Text('AssetImage keyName: ${assetImage.keyName}'),
        Text('NetworkImage url: ${networkImage.url}'),
        SizedBox(height: 8.0),
        Text('ExactAssetImage keyName: ${exactAsset.keyName}'),
        Text('ExactAssetImage scale: ${exactAsset.scale}'),
        SizedBox(height: 8.0),
        Text('Package asset keyName: ${packageAsset.keyName}'),
        SizedBox(height: 8.0),
        // Display a network image widget (may or may not load)
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Image(
            image: networkImage,
            errorBuilder: (ctx, error, stack) {
              print('Image load error: $error');
              return Center(child: Icon(Icons.broken_image, size: 40.0));
            },
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text('Asset services test rendered'),
      ],
    ),
  );
}
