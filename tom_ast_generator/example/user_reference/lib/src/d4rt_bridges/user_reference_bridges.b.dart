// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-06T18:40:07.911739

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:user_reference_example/src/data_models.dart' as $user_reference_example_1;
import 'package:user_reference_example/src/services.dart' as $user_reference_example_2;

/// Bridge class for all module.
class AllBridge {
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
      'User': 'package:user_reference_example/src/data_models.dart',
      'Product': 'package:user_reference_example/src/data_models.dart',
      'Order': 'package:user_reference_example/src/data_models.dart',
      'UserService': 'package:user_reference_example/src/services.dart',
      'ProductService': 'package:user_reference_example/src/services.dart',
      'EventEmitter': 'package:user_reference_example/src/services.dart',
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:user_reference_example/src/data_models.dart',
      'package:user_reference_example/src/services.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:user_reference_example/user_reference_example.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
  }

}

// =============================================================================
// User Bridge
// =============================================================================

BridgedClass _createUserBridge() {
  return BridgedClass(
    nativeType: $user_reference_example_1.User,
    name: 'User',
    isAssignable: (v) => v is $user_reference_example_1.User,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'User');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'User');
        final email = D4.getOptionalNamedArg<String?>(named, 'email');
        return $user_reference_example_1.User(id: id, name: name, email: email);
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'User');
        if (positional.isEmpty) {
          throw ArgumentError('User: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $user_reference_example_1.User.fromMap(map);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$user_reference_example_1.User>(target, 'User').id,
      'name': (visitor, target) => D4.validateTarget<$user_reference_example_1.User>(target, 'User').name,
      'email': (visitor, target) => D4.validateTarget<$user_reference_example_1.User>(target, 'User').email,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$user_reference_example_1.User>(target, 'User').name = D4.extractBridgedArg<String>(value, 'name'),
      'email': (visitor, target, value) => 
        D4.validateTarget<$user_reference_example_1.User>(target, 'User').email = D4.extractBridgedArgOrNull<String>(value, 'email'),
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_1.User>(target, 'User');
        return t.toMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_1.User>(target, 'User');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'User({required int id, required String name, String? email})',
      'fromMap': 'factory User.fromMap(Map<String, dynamic> map)',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'int get id',
      'name': 'String get name',
      'email': 'String? get email',
    },
    setterSignatures: {
      'name': 'set name(dynamic value)',
      'email': 'set email(dynamic value)',
    },
  );
}

// =============================================================================
// Product Bridge
// =============================================================================

BridgedClass _createProductBridge() {
  return BridgedClass(
    nativeType: $user_reference_example_1.Product,
    name: 'Product',
    isAssignable: (v) => v is $user_reference_example_1.Product,
    constructors: {
      '': (visitor, positional, named) {
        final sku = D4.getRequiredNamedArg<String>(named, 'sku', 'Product');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Product');
        final priceInCents = D4.getNamedArgWithDefault<int>(named, 'priceInCents', 0);
        final quantity = D4.getNamedArgWithDefault<int>(named, 'quantity', 0);
        return $user_reference_example_1.Product(sku: sku, name: name, priceInCents: priceInCents, quantity: quantity);
      },
    },
    getters: {
      'sku': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').sku,
      'name': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').name,
      'priceInCents': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').priceInCents,
      'quantity': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').quantity,
      'formattedPrice': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').formattedPrice,
      'isInStock': (visitor, target) => D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').isInStock,
    },
    setters: {
      'priceInCents': (visitor, target, value) => 
        D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').priceInCents = D4.extractBridgedArg<int>(value, 'priceInCents'),
      'quantity': (visitor, target, value) => 
        D4.validateTarget<$user_reference_example_1.Product>(target, 'Product').quantity = D4.extractBridgedArg<int>(value, 'quantity'),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_1.Product>(target, 'Product');
        return t.toString();
      },
    },
    staticMethods: {
      'placeholder': (visitor, positional, named, typeArgs) {
        return $user_reference_example_1.Product.placeholder();
      },
    },
    constructorSignatures: {
      '': 'Product({required String sku, required String name, int priceInCents = 0, int quantity = 0})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'sku': 'String get sku',
      'name': 'String get name',
      'priceInCents': 'int get priceInCents',
      'quantity': 'int get quantity',
      'formattedPrice': 'String get formattedPrice',
      'isInStock': 'bool get isInStock',
    },
    setterSignatures: {
      'priceInCents': 'set priceInCents(dynamic value)',
      'quantity': 'set quantity(dynamic value)',
    },
    staticMethodSignatures: {
      'placeholder': 'Product placeholder()',
    },
  );
}

// =============================================================================
// Order Bridge
// =============================================================================

BridgedClass _createOrderBridge() {
  return BridgedClass(
    nativeType: $user_reference_example_1.Order,
    name: 'Order',
    isAssignable: (v) => v is $user_reference_example_1.Order,
    constructors: {
      '': (visitor, positional, named) {
        final orderId = D4.getRequiredNamedArg<String>(named, 'orderId', 'Order');
        final customer = D4.getRequiredNamedArg<$user_reference_example_1.User>(named, 'customer', 'Order');
        final items = D4.coerceListOrNull<$user_reference_example_1.Product>(named['items'], 'items');
        final createdAt = D4.getOptionalNamedArg<DateTime?>(named, 'createdAt');
        return $user_reference_example_1.Order(orderId: orderId, customer: customer, items: items, createdAt: createdAt);
      },
    },
    getters: {
      'orderId': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').orderId,
      'customer': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').customer,
      'items': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').items,
      'createdAt': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').createdAt,
      'itemCount': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').itemCount,
      'totalPriceInCents': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').totalPriceInCents,
      'formattedTotal': (visitor, target) => D4.validateTarget<$user_reference_example_1.Order>(target, 'Order').formattedTotal,
    },
    methods: {
      'addItem': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_1.Order>(target, 'Order');
        D4.requireMinArgs(positional, 1, 'addItem');
        final product = D4.getRequiredArg<$user_reference_example_1.Product>(positional, 0, 'product', 'addItem');
        t.addItem(product);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_1.Order>(target, 'Order');
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
    nativeType: $user_reference_example_2.UserService,
    name: 'UserService',
    isAssignable: (v) => v is $user_reference_example_2.UserService,
    constructors: {
      '': (visitor, positional, named) {
        return $user_reference_example_2.UserService();
      },
    },
    getters: {
      'users': (visitor, target) => D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService').users,
    },
    methods: {
      'getUserById': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService');
        D4.requireMinArgs(positional, 1, 'getUserById');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'getUserById');
        return t.getUserById(id);
      },
      'addUser': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService');
        D4.requireMinArgs(positional, 1, 'addUser');
        final user = D4.getRequiredArg<$user_reference_example_1.User>(positional, 0, 'user', 'addUser');
        t.addUser(user);
        return null;
      },
      'removeUser': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService');
        D4.requireMinArgs(positional, 1, 'removeUser');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'removeUser');
        return t.removeUser(id);
      },
      'findUsers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService');
        D4.requireMinArgs(positional, 1, 'findUsers');
        if (positional.isEmpty) {
          throw ArgumentError('findUsers: Missing required argument "predicate" at position 0');
        }
        final predicateRaw = positional[0];
        return t.findUsers(($user_reference_example_1.User p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; });
      },
      'fetchUser': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.UserService>(target, 'UserService');
        D4.requireMinArgs(positional, 1, 'fetchUser');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'fetchUser');
        return t.fetchUser(id);
      },
    },
    constructorSignatures: {
      '': 'UserService()',
    },
    methodSignatures: {
      'getUserById': 'User? getUserById(int id)',
      'addUser': 'void addUser(User user)',
      'removeUser': 'bool removeUser(int id)',
      'findUsers': 'List<User> findUsers(bool Function(User) predicate)',
      'fetchUser': 'Future<User?> fetchUser(int id)',
    },
    getterSignatures: {
      'users': 'List<User> get users',
    },
  );
}

// =============================================================================
// ProductService Bridge
// =============================================================================

BridgedClass _createProductServiceBridge() {
  return BridgedClass(
    nativeType: $user_reference_example_2.ProductService,
    name: 'ProductService',
    isAssignable: (v) => v is $user_reference_example_2.ProductService,
    constructors: {
      '': (visitor, positional, named) {
        return $user_reference_example_2.ProductService();
      },
    },
    getters: {
      'products': (visitor, target) => D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService').products,
    },
    methods: {
      'setProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'setProduct');
        final product = D4.getRequiredArg<$user_reference_example_1.Product>(positional, 0, 'product', 'setProduct');
        t.setProduct(product);
        return null;
      },
      'getProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'getProduct');
        final sku = D4.getRequiredArg<String>(positional, 0, 'sku', 'getProduct');
        return t.getProduct(sku);
      },
      'removeProduct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService');
        D4.requireMinArgs(positional, 1, 'removeProduct');
        final sku = D4.getRequiredArg<String>(positional, 0, 'sku', 'removeProduct');
        return t.removeProduct(sku);
      },
      'getInStockProducts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService');
        return t.getInStockProducts();
      },
      'calculateInventoryValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.ProductService>(target, 'ProductService');
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
    nativeType: $user_reference_example_2.EventEmitter,
    name: 'EventEmitter',
    isAssignable: (v) => v is $user_reference_example_2.EventEmitter,
    constructors: {
      '': (visitor, positional, named) {
        return $user_reference_example_2.EventEmitter();
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((dynamic p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((dynamic p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<dynamic>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_reference_example_2.EventEmitter>(target, 'EventEmitter');
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

