// D4rt test script: Tests RenderTreeRootElement concepts and related root widget behavior
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RenderTreeRootElement is the base for root elements that own the render tree
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderTreeRootElement test executing');

  // RenderTreeRootElement is a mixin used by root elements (View, etc.)
  // We test its behavior through widgets that use root element concepts

  // Test 1: Root element detection
  print('--- Root Element Detection ---');
  Widget buildRootDetector() {
    return Builder(
      builder: (context) {
        final element = context as Element;

        // Walk up to find root-like elements
        var depth = 0;
        Element? rootCandidate;
        element.visitAncestorElements((ancestor) {
          depth++;
          rootCandidate = ancestor;
          print('Depth $depth: ${ancestor.widget.runtimeType}');
          return true; // continue visiting
        });

        print('Total tree depth from this point: $depth');
        if (rootCandidate != null) {
          print('Top ancestor widget: ${rootCandidate!.widget.runtimeType}');
        }

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Root Detection',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Tree depth: $depth'),
              if (rootCandidate != null)
                Text('Top: ${rootCandidate!.widget.runtimeType}'),
            ],
          ),
        );
      },
    );
  }

  // Test 2: Render tree owner access
  print('--- Render Tree Owner ---');
  Widget buildOwnerDemo() {
    return Builder(
      builder: (context) {
        final element = context as Element;
        final owner = element.owner;

        print('BuildOwner: ${owner?.runtimeType}');
        if (owner != null) {
          print('BuildOwner debugBuilding: ${owner.debugBuilding}');
        }

        // Access pipeline owner through render object
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            final pipelineOwner = renderObject.owner;
            print('PipelineOwner: ${pipelineOwner?.runtimeType}');
            if (pipelineOwner != null) {
              print(
                'Semantics enabled: ${pipelineOwner.semanticsOwner != null}',
              );
            }
          }
        });

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tree Owner', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('BuildOwner: ${owner?.runtimeType}'),
              Text('Has owner: ${owner != null}'),
            ],
          ),
        );
      },
    );
  }

  // Test 3: View widget (root widget concept)
  print('--- View Widget Tests ---');
  Widget buildViewDemo() {
    return Builder(
      builder: (context) {
        final view = View.maybeOf(context);
        print('View.maybeOf result: ${view != null}');

        if (view != null) {
          print('FlutterView devicePixelRatio: ${view.devicePixelRatio}');
          print('FlutterView physicalSize: ${view.physicalSize}');
        }

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Access',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Has View: ${view != null}'),
              if (view != null) ...[
                Text('DPR: ${view.devicePixelRatio.toStringAsFixed(2)}'),
                Text('Size: ${view.physicalSize}'),
              ],
            ],
          ),
        );
      },
    );
  }

  // Test 4: WidgetsBinding and root interaction
  print('--- WidgetsBinding Root ---');
  Widget buildBindingDemo() {
    final binding = WidgetsBinding.instance;
    print('WidgetsBinding: ${binding.runtimeType}');
    print('BuildOwner: ${binding.buildOwner?.runtimeType}');
    print('PipelineOwner: ${binding.rootPipelineOwner.runtimeType}');

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('WidgetsBinding', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Type: ${binding.runtimeType}'),
          Text('BuildOwner: ${binding.buildOwner?.runtimeType}'),
          Text('RootPipeline: ${binding.rootPipelineOwner.runtimeType}'),
        ],
      ),
    );
  }

  // Test 5: Root render object properties
  print('--- Root RenderObject ---');
  Widget buildRenderRootDemo() {
    return Builder(
      builder: (context) {
        // Schedule post-frame to access render tree
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            // Traverse up to find root
            RenderObject? current = renderObject;
            var levels = 0;
            while (current?.parent != null) {
              current = current!.parent;
              levels++;
            }
            print('Levels to root RenderObject: $levels');
            print('Root RenderObject type: ${current?.runtimeType}');

            if (current is RenderBox) {
              print(
                'Root is RenderBox with size: ${current.hasSize ? current.size : "no size"}',
              );
            }
          }
        });

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Render Root',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Check console for render tree info'),
            ],
          ),
        );
      },
    );
  }

  // Test 6: Root element rebuild behavior
  print('--- Root Rebuild ---');
  Widget buildRebuildDemo() {
    return StatefulBuilder(
      builder: (context, setState) {
        final element = context as Element;

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rebuild Demo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Element: ${element.runtimeType}'),
              Text('Depth: ${element.depth}'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  print('Triggering setState rebuild...');
                  setState(() {});
                  print('Rebuild scheduled');
                },
                child: Text('Trigger Rebuild'),
              ),
            ],
          ),
        );
      },
    );
  }

  print('RenderTreeRootElement test completed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('RenderTreeRootElement')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Root Element Concepts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            buildRootDetector(),
            SizedBox(height: 12),
            buildOwnerDemo(),
            SizedBox(height: 12),
            buildViewDemo(),
            SizedBox(height: 12),
            buildBindingDemo(),
            SizedBox(height: 12),
            buildRenderRootDemo(),
            SizedBox(height: 12),
            buildRebuildDemo(),
          ],
        ),
      ),
    ),
  );
}
