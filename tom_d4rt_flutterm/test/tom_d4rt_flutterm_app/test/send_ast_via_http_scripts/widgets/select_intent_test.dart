// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for SelectIntent.
///
/// SelectIntent is an Intent that signals the desire to select the currently
/// focused control. It's handled by SelectAction implementations.
///
/// Key characteristics:
/// - Simple intent with no parameters
/// - const constructor for efficiency
/// - Different from ActivateIntent
/// - Not bound to key by default
class FlutterWidgetPrinter {
  dynamic build(BuildContext context) {
    print('=== SelectIntent Test ===');
    print('');
    
    // Class details
    print('SelectIntent:');
    print('  Extends: Intent');
    print('  Package: flutter/src/widgets/actions.dart');
    print('  Purpose: Signal selection request');
    print('');
    
    // Constructor
    print('Constructor:');
    print('  const SelectIntent()');
    print('');
    
    // Intent usage
    print('Intent Pattern:');
    print('  - Intent: Declares what action to perform');
    print('  - SelectIntent: "Select the focused control"');
    print('  - Action system finds matching Action');
    print('  - Action.invoke() executes the selection');
    print('');
    
    // Selection semantics
    print('Selection Semantics:');
    print('  - Select/toggle state without activating');
    print('  - Example: Select checkbox without toggling');
    print('  - Example: Select item in multi-select list');
    print('  - Example: Mark focus target as selected');
    print('');
    
    // Select vs Activate comparison
    print('SelectIntent vs ActivateIntent:');
    print('  SelectIntent:');
    print('    - Selects/marks the control');
    print('    - May toggle selection state');
    print('    - Not bound to key by default');
    print('  ActivateIntent:');
    print('    - Activates/triggers the control');
    print('    - Like pressing a button');
    print('    - Bound to Enter/Space');
    print('');
    
    // Usage with Actions
    print('Registering SelectAction:');
    print('  Actions(');
    print('    actions: <Type, Action<Intent>>{');
    print('      SelectIntent: MySelectAction(),');
    print('    },');
    print('    child: myWidget,');
    print('  )');
    print('');
    
    // Invoking programmatically
    print('Invoking Programmatically:');
    print('  Actions.invoke<SelectIntent>(');
    print('    context,');
    print('    const SelectIntent(),');
    print('  );');
    print('');
    
    // Checking if enabled
    print('Checking Action Status:');
    print('  final action = Actions.maybeFind<SelectIntent>(context);');
    print('  if (action != null && action.isActionEnabled) {');
    print('    Actions.invoke(context, const SelectIntent());');
    print('  }');
    print('');
    
    // Related intents
    print('Related Intents:');
    print('  - ActivateIntent: Activate control');
    print('  - DismissIntent: Dismiss focused widget');
    print('  - DirectionalFocusIntent: Move focus');
    print('');
    
    print('Test completed.');
    return const SizedBox.shrink();
  }
}
