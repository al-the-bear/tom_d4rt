/// Test file for GEN-061: Generic method callback return type bug
/// 
/// When a method has a type parameter T and a callback with return type FutureOr<T>,
/// the generator incorrectly generates code that casts to FutureOr<dynamic>.
/// This is NOT assignable back to FutureOr<T>.
library;

import 'dart:async';

/// Class with generic method that has a callback parameter.
/// 
/// The real-world case is MySQLConnectionPool.withConnection<T>:
/// ```dart
/// FutureOr<T> withConnection<T>(FutureOr<T> Function(MySQLConnection conn) callback)
/// ```
/// 
/// When T is unresolved, the generator outputs:
/// ```dart
/// D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<dynamic>
/// ```
/// 
/// But `FutureOr<dynamic>` is NOT assignable to `FutureOr<T>` because generic T
/// could be any type, and `dynamic` is not a subtype of bounded T.
class GenericCallbackService {
  /// Generic method with FutureOr<T> callback - THIS IS THE BUG!
  /// 
  /// The generator must preserve the type parameter T in the cast,
  /// not substitute dynamic.
  FutureOr<T> withConnection<T>(
    FutureOr<T> Function(dynamic connection) callback,
  ) async {
    final result = await callback('mock_connection');
    return result;
  }
  
  /// Another generic method variant.
  Future<T> transactional<T>(
    FutureOr<T> Function(String input) callback,
  ) async {
    final result = await callback('test_input');
    return result;
  }
  
  /// Generic method with bounded type parameter.
  FutureOr<T> withBoundedType<T extends Object>(
    FutureOr<T> Function(dynamic conn) callback,
  ) async {
    final result = await callback('bounded');
    return result;
  }
}

/// Non-generic version for comparison - this should work correctly.
class CallbackTypeService {
  /// Method with FutureOr<Object> return type callback.
  /// This tests non-generic callback handling.
  Future<String> withConnection(
    FutureOr<Object> Function(dynamic connection) callback,
  ) async {
    final result = await callback('mock_connection');
    return result.toString();
  }
}
