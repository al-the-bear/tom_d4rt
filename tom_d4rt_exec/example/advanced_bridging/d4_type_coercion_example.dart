/// D4 Type Coercion Example
///
/// Demonstrates the D4 class helper methods for type coercion.
/// These methods solve a common problem: D4rt creates `List<Object?>` and
/// `Map<Object?, Object?>` at runtime even when all elements are of the
/// same type.
///
/// Run with: dart run example/advanced_bridging/d4_type_coercion_example.dart
library;

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

// =============================================================================
// Example Classes for Bridging
// =============================================================================

/// A simple item class for demonstrating list coercion.
class Item {
  final String name;
  final int quantity;

  Item(this.name, this.quantity);

  @override
  String toString() => 'Item($name, qty: $quantity)';
}

/// Inventory service that works with typed lists.
class InventoryService {
  final List<Item> _items = [];

  /// Add multiple items at once.
  /// The bridge must coerce List<Object?> to List<Item>.
  void addItems(List<Item> items) {
    _items.addAll(items);
  }

  /// Get all items.
  List<Item> get items => List.unmodifiable(_items);

  /// Add items from a configuration map.
  /// The bridge must coerce Map<Object?, Object?> to Map<String, int>.
  void addFromConfig(Map<String, int> config) {
    for (final entry in config.entries) {
      _items.add(Item(entry.key, entry.value));
    }
  }

  /// Get inventory summary as a map.
  Map<String, int> getSummary() {
    return {for (final item in _items) item.name: item.quantity};
  }
}

// =============================================================================
// Bridge Implementation Using D4 Helpers
// =============================================================================

BridgedClass createItemBridge() {
  return BridgedClass(
    nativeType: Item,
    name: 'Item',
    constructors: {
      '': (visitor, positional, named) {
        // D4.getRequiredArg validates presence and type
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Item');
        final quantity =
            D4.getRequiredArg<int>(positional, 1, 'quantity', 'Item');
        return Item(name, quantity);
      },
    },
    getters: {
      'name': (visitor, target) =>
          D4.validateTarget<Item>(target, 'Item').name,
      'quantity': (visitor, target) =>
          D4.validateTarget<Item>(target, 'Item').quantity,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Item>(target, 'Item').toString();
      },
    },
  );
}

BridgedClass createInventoryServiceBridge() {
  return BridgedClass(
    nativeType: InventoryService,
    name: 'InventoryService',
    constructors: {
      '': (visitor, positional, named) => InventoryService(),
    },
    getters: {
      'items': (visitor, target) =>
          D4.validateTarget<InventoryService>(target, 'InventoryService').items,
    },
    methods: {
      // Example 1: Using D4.coerceList to handle List<Object?> → List<Item>
      'addItems': (visitor, target, positional, named, typeArgs) {
        final service =
            D4.validateTarget<InventoryService>(target, 'InventoryService');

        // D4rt passes a List<Object?> even if all elements are Items
        // Use D4.coerceList to safely convert to List<Item>
        final items = D4.coerceList<Item>(positional[0], 'items');

        service.addItems(items);
        return null;
      },

      // Example 2: Using D4.coerceMap to handle Map<Object?, Object?>
      'addFromConfig': (visitor, target, positional, named, typeArgs) {
        final service =
            D4.validateTarget<InventoryService>(target, 'InventoryService');

        // D4rt passes Map<Object?, Object?> for map literals
        // Use D4.coerceMap to convert to Map<String, int>
        final config = D4.coerceMap<String, int>(positional[0], 'config');

        service.addFromConfig(config);
        return null;
      },

      'getSummary': (visitor, target, positional, named, typeArgs) {
        return D4
            .validateTarget<InventoryService>(target, 'InventoryService')
            .getSummary();
      },
    },
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('D4 Type Coercion Example');
  print('=' * 60);

  // Create interpreter and register bridges
  final d4rt = D4rt();
  d4rt.registerBridgedClass(createItemBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(
      createInventoryServiceBridge(), 'package:example/example.dart');

  // Execute script that creates typed collections
  final script = '''
import 'package:example/example.dart';

void main() {
  final inventory = InventoryService();
  
  // Create items - D4rt creates List<Object?> internally
  final items = [
    Item('Apple', 10),
    Item('Banana', 20),
    Item('Orange', 15),
  ];
  
  // addItems uses D4.coerceList to convert to List<Item>
  inventory.addItems(items);
  
  print('After addItems:');
  for (final item in inventory.items) {
    print('  - \$item');
  }
  
  // Create a map config - D4rt creates Map<Object?, Object?> internally
  final config = {
    'Grapes': 30,
    'Mango': 25,
  };
  
  // addFromConfig uses D4.coerceMap to convert to Map<String, int>
  inventory.addFromConfig(config);
  
  print('\\nAfter addFromConfig:');
  for (final item in inventory.items) {
    print('  - \$item');
  }
  
  print('\\nInventory Summary:');
  final summary = inventory.getSummary();
  for (final entry in summary.entries) {
    print('  \${entry.key}: \${entry.value}');
  }
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  print('\n' + '=' * 60);
  print('Example completed successfully!');
}
