// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for SelectionDetails.
///
/// SelectionDetails is an abstract final class that provides selection
/// information including the range and status of a selection.
///
/// Key properties:
/// - range: The SelectedContentRange of the selection (nullable)
/// - status: The SelectionStatus indicating selection state
///
/// Accessed via SelectionListenerNotifier.selection
dynamic build(BuildContext context) {
  print('=== SelectionDetails Test ===');
  print('');
  
  // Class details
  print('SelectionDetails:');
  print('  Type: abstract final class');
  print('  Package: flutter/src/widgets/selectable_region.dart');
  print('  Purpose: Selection range and status info');
  print('');
  
  // Abstract final class
  print('Abstract Final Class:');
  print('  - Cannot be extended');
  print('  - Cannot be implemented directly');
  print('  - Used as interface via private implementations');
  print('  - Dart 3.0 sealed class feature');
  print('');
  
  // Range property
  print('range Property (SelectedContentRange?):');
  print('  - Returns null if nothing selected');
  print('  - Contains start/end offsets local to SelectionListener');
  print('  - Describes selected text range');
  print('');
  
  // Status property
  print('status Property (SelectionStatus):');
  print('  - SelectionStatus.none: No selection');
  print('  - SelectionStatus.collapsed: Caret only');
  print('  - SelectionStatus.uncollapsed: Range selected');
  print('');
  
  // Accessing SelectionDetails
  print('Accessing SelectionDetails:');
  print('  1. Create SelectionListenerNotifier');
  print('  2. Pass to SelectionListener');
  print('  3. Access via notifier.selection');
  print('');
  
  // Usage example
  print('Usage Example:');
  print('  final notifier = SelectionListenerNotifier();');
  print('  ');
  print('  SelectionListener(');
  print('    notifier: notifier,');
  print('    child: SelectionArea(child: text),');
  print('  );');
  print('  ');
  print('  // Later...');
  print('  if (notifier.registered) {');
  print('    final details = notifier.selection;');
  print('    final status = details.status;');
  print('    final range = details.range;');
  print('  }');
  print('');
  
  // SelectionListenerNotifier
  print('SelectionListenerNotifier:');
  print('  - registered: Whether connected to SelectionListener');
  print('  - selection: Get SelectionDetails');
  print('  - addListener/removeListener: Track changes');
  print('');
  
  // Related classes
  print('Related Classes:');
  print('  - SelectionListener: Widget providing details');
  print('  - SelectionListenerNotifier: Notifies of changes');
  print('  - SelectedContentRange: Start/end offsets');
  print('  - SelectionStatus: Selection state enum');
  print('');
  
  print('Test completed.');
  return const SizedBox.shrink();
}
