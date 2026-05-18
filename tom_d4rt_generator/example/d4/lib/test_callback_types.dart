/// Test file for GEN-061: Generic method callback return type bug.
///
/// History:
///   - Original bug: generator emitted `FutureOr<dynamic>` for an unbounded
///     `<T>` callback, which is not assignable to `FutureOr<T>`.
///   - 2026-05-03 fix (commit `114f11f5`, C11): generator now erases an
///     unbounded `<T>` callback return type to nullable `FutureOr<Object?>`
///     instead of `FutureOr<dynamic>`. This is the contract bridges must
///     produce so that nullable-returning callbacks (common in the Flutter
///     bridge corpus) round-trip correctly.
///   - 2026-05-18: source declarations updated to use `FutureOr<T?>` for
///     unbounded generic overloads so the generator's nullable erasure
///     unifies cleanly with the call-site signature (no backward-compat
///     concern in the example/d4 corpus).
library;

import 'dart:async';

/// Class with generic method that has a callback parameter.
///
/// The real-world case is MySQLConnectionPool.withConnection<T>:
/// ```dart
/// FutureOr<T?> withConnection<T>(FutureOr<T?> Function(MySQLConnection conn) callback)
/// ```
///
/// The generator erases unbounded `<T>` to `Object?` in the callback cast:
/// ```dart
/// ... as FutureOr<Object?> Function(dynamic)
/// ```
///
/// Declaring the source as `FutureOr<T?>` lets `T` infer to `Object` (or
/// `Object?`) at the bridge call site: either way, `T?` resolves to
/// `Object?` and the cast types match. The bounded variant below
/// (`withBoundedType<T extends Object>`) keeps non-nullable `FutureOr<T>`
/// because its bound prevents nullable inference.
class GenericCallbackService {
  /// Generic method with FutureOr<T?> callback — nullable to align with the
  /// generator's `FutureOr<Object?>` erasure for unbounded `<T>`.
  FutureOr<T?> withConnection<T>(
    FutureOr<T?> Function(dynamic connection) callback,
  ) async {
    final result = await callback('mock_connection');
    return result;
  }

  /// Another generic method variant.
  Future<T?> transactional<T>(
    FutureOr<T?> Function(String input) callback,
  ) async {
    final result = await callback('test_input');
    return result;
  }

  /// Generic method with bounded type parameter. Non-nullable because the
  /// `T extends Object` bound prevents `T` from inferring to a nullable
  /// type; the generator emits non-nullable `FutureOr<Object>` here.
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
  /// This tests non-generic callback handling — generator preserves the
  /// non-nullable `Object` because there is no `<T>` to erase.
  Future<String> withConnection(
    FutureOr<Object> Function(dynamic connection) callback,
  ) async {
    final result = await callback('mock_connection');
    return result.toString();
  }
}
