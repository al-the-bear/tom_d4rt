// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-12T17:06:47.669606

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:d4_example/src/user_reference/data_models.dart' as $d4_example_1;

/// Bridge class for user_reference module.
class UserReferenceBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createUserBridge(),
      _createProductBridge(),
      _createOrderBridge(),
      _createUserServiceBridge(),
      _createProductServiceBridge(),
      _createEventEmitterBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'User': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\data_models.dart',
      'Product': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\data_models.dart',
      'Order': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\data_models.dart',
      'UserService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\services.dart',
      'ProductService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\services.dart',
      'EventEmitter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\user_reference\services.dart',
    };
  }

    isAssignable: (v) => v is Order,
    constructors: {
      '': (visitor, positional, named) {
        final orderId = D4.getRequiredNamedArg<String>(named, 'orderId', 'Order');
        final customer = D4.getRequiredNamedArg<$d4_example_1.User>(named, 'customer', 'Order');
        final items = D4.coerceListOrNull<$d4_example_1.Product>(named['items'], 'items');
        final createdAt = D4.getOptionalNamedArg<DateTime?>(named, 'createdAt');
        return Order(orderId: orderId, customer: customer, items: items, createdAt: createdAt);
      },
    },
    getters: {
      'orderId': (visitor, target) => D4.validateTarget<Order>(target, 'Order').orderId,
      'customer': (visitor, target) => D4.validateTarget<Order>(target, 'Order').customer,
      'items': (visitor, target) => D4.validateTarget<Order>(target, 'Order').items,
      'createdAt': (visitor, target) => D4.validateTarget<Order>(target, 'Order').createdAt,
      'itemCount': (visitor, target) => D4.validateTarget<Order>(target, 'Order').itemCount,
      'totalPriceInCents': (visitor, target) => D4.validateTarget<Order>(target, 'Order').totalPriceInCents,
      'formattedTotal': (visitor, target) => D4.validateTarget<Order>(target, 'Order').formattedTotal,
    },
    methods: {
      'addItem': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Order>(target, 'Order');
        D4.requireMinArgs(positional, 1, 'addItem');
        final product = D4.getRequiredArg<$d4_example_1.Product>(positional, 0, 'product', 'addItem');
        t.addItem(product);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Order>(target, 'Order');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Order({required String orderId, required User customer, List<Product>? items, DateTime? createdAt})',
    },
    methodSignatures: {
      'addItem': 'void addItem(Product product)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'orderId': 'String get orderId',
      'customer': 'User get customer',
      'items': 'List<Product> get items',
      'createdAt': 'DateTime get createdAt',
      'itemCount': 'int get itemCount',
      'totalPriceInCents': 'int get totalPriceInCents',
      'formattedTotal': 'String get formattedTotal',
    },
  );
}

// =============================================================================
// UserService Bridge
// =============================================================================

BridgedClass _createUserServiceBridge() {
  return BridgedClass(
    nativeType: UserService,
    name: 'UserService',
    isAssignable: (v) => v is ProductService,
    constructors: {
      '': (visitor, positional, named) {
        return ProductService();
      },
    },
    getters: {
      'products': (visitor, target) => D4.validateTarget<ProductService>(target, 'ProductService').products,
    },
    methods: {
      'setProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'setProduct');
        final product = D4.getRequiredArg<$d4_example_1.Product>(positional, 0, 'product', 'setProduct');
        t.setProduct(product);
        return null;
      },
      'getProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'getProduct');
        final sku = D4.getRequiredArg<String>(positional, 0, 'sku', 'getProduct');
        return t.getProduct(sku);
      },
      'removeProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'removeProduct');
        final sku = D4.getRequiredArg<String>(positional, 0, 'sku', 'removeProduct');
        return t.removeProduct(sku);
      },
      'getInStockProducts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProductService>(target, 'ProductService');
        return t.getInStockProducts();
      },
      'calculateInventoryValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProductService>(target, 'ProductService');
        return t.calculateInventoryValue();
      },
    },
    constructorSignatures: {
      '': 'ProductService()',
    },
    methodSignatures: {
      'setProduct': 'void setProduct(Product product)',
      'getProduct': 'Product? getProduct(String sku)',
      'removeProduct': 'bool removeProduct(String sku)',
      'getInStockProducts': 'List<Product> getInStockProducts()',
      'calculateInventoryValue': 'int calculateInventoryValue()',
    },
    getterSignatures: {
      'products': 'List<Product> get products',
    },
  );
}

// =============================================================================
// EventEmitter Bridge
// =============================================================================

BridgedClass _createEventEmitterBridge() {
  return BridgedClass(
    nativeType: EventEmitter,
    name: 'EventEmitter',
    isAssignable: (v) => v is EventEmitter,
    constructors: {
      '': (visitor, positional, named) {
        return EventEmitter();
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((dynamic p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((dynamic p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<dynamic>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        t.clearListeners();
        return null;
      },
    },
    constructorSignatures: {
      '': 'EventEmitter()',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function(T) listener)',
      'removeListener': 'void removeListener(void Function(T) listener)',
      'emit': 'void emit(T event)',
      'clearListeners': 'void clearListeners()',
    },
  );
}

