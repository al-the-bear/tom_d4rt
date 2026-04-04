// Generated print-only test for RenderAbstractLayoutBuilderMixin
// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/widgets.dart';

/// Print-only test for RenderAbstractLayoutBuilderMixin
/// This test prints class structure and API information.
dynamic build(BuildContext context) {
print('=' * 50);
print('RenderAbstractLayoutBuilderMixin PRINT-ONLY TEST');
print('=' * 50);

// Mixin definition
print('\n--- RenderAbstractLayoutBuilderMixin ---');
print('mixin RenderAbstractLayoutBuilderMixin<LayoutInfoType, ChildType>');
print('  on RenderObjectWithChildMixin<ChildType>,');
print('     RenderObjectWithLayoutCallbackMixin');
print('Purpose: Base for layout builders with callbacks');

// Type parameters
print('\n--- Type parameters ---');
print('LayoutInfoType: info passed to builder callback');
print('ChildType: type of child RenderObject');
print('Default LayoutInfoType is Constraints');

// Callback mechanism
print('\n--- Callback mechanism ---');
print('_callback: LayoutCallback<Constraints>?');
print('_updateCallback(): sets and schedules callback');
print('scheduleLayoutCallback(): marks needs layout');

// layoutCallback method
print('\n--- layoutCallback() ---');
print('@visibleForOverriding');
print('@override');
print('void layoutCallback() => _callback!(constraints)');
print('Called during performLayout');
print('Invokes builder with current constraints');

// layoutInfo property
print('\n--- layoutInfo property ---');
print('@protected');
print('LayoutInfoType get layoutInfo => constraints');
print('Override in subclasses for custom info');
print('Default returns incoming constraints');

// Usage pattern
print('\n--- Usage pattern ---');
print('1. Call layoutCallback() in performLayout');
print('2. Builder receives layoutInfo');
print('3. Builder rebuilds widget tree');
print('4. Continue with layout');

// LayoutBuilder usage
print('\n--- LayoutBuilder example ---');
print('LayoutBuilder(');
print('  builder: (context, constraints) {');
print('    // constraints come from layoutInfo');
print('    return SizedBox(...);');
print('  },');
print(')');

// Replacement note
print('\n--- RenderConstrainedLayoutBuilder ---');
print('typedef RenderConstrainedLayoutBuilder = ');
print('  RenderAbstractLayoutBuilderMixin');
print('Old name, use new mixin name');


// Custom layoutInfo
print('\n--- Custom layoutInfo override ---');
print('@override');
print('MyLayoutInfo get layoutInfo => MyLayoutInfo(');
print('  constraints: constraints,');
print('  extraData: computeExtra(),');
print(')');

print('\n' + '=' * 50);
print('END RenderAbstractLayoutBuilderMixin PRINT-ONLY TEST');
print('=' * 50);
return const SizedBox.shrink();
}
