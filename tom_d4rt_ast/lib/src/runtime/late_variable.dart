import 'package:tom_d4rt_ast/runtime.dart';

/// Represents a late variable that supports lazy initialization
class LateVariable {
  bool _isInitialized = false;

  /// True while [_initializer] runs: a read in that window is a cycle.
  bool _isInitializing = false;
  Object? _value;
  final Object? Function()? _initializer;
  final String _name;
  final bool _isFinal;

  LateVariable(this._name, this._initializer, {bool isFinal = false})
    : _isFinal = isFinal;

  /// Gets the value of the late variable, initializing it if necessary
  Object? get value {
    if (!_isInitialized) {
      if (_initializer != null) {
        // Lazy initialization. A read while the initializer runs means it
        // depends on itself (`static const a = b; static const b = a;`):
        // report it instead of recursing until the stack overflows. An
        // initializer that throws leaves the variable uninitialized, so the
        // next read runs it again, as in Dart.
        if (_isInitializing) {
          throw LateInitializationError(
            "LateInitializationError: '$_name' is read during its initialization "
            '(its initializer depends on itself).',
          );
        }
        _isInitializing = true;
        try {
          _value = _initializer();
        } finally {
          _isInitializing = false;
        }
        _isInitialized = true;
        Logger.debug(
          "[LateVariable] Lazy initialized '$_name' with value: $_value",
        );
      } else {
        // Late variable without initializer accessed before assignment
        throw LateInitializationError(
          "LateInitializationError: Late variable '$_name' without initializer is accessed before being assigned.",
        );
      }
    }
    return _value;
  }

  /// Assigns a value to the late variable
  void assign(Object? value) {
    if (_isFinal && _isInitialized) {
      throw LateInitializationError(
        "LateInitializationError: Late final variable '$_name' has already been assigned.",
      );
    }
    _value = value;
    _isInitialized = true;
    Logger.debug("[LateVariable] Assigned '$_name' = $value");
  }

  /// Set the value
  set value(Object? newValue) {
    if (_isInitialized && _isFinal) {
      throw LateInitializationError(
        "LateInitializationError: Field '$_name' has already been initialized.",
      );
    }
    _value = newValue;
    _isInitialized = true;
  }

  /// Check if the variable has been initialized
  bool get isInitialized => _isInitialized;

  @override
  String toString() =>
      'LateVariable($_name, initialized: $_isInitialized, value: $_value)';
}

/// Exception thrown when accessing an uninitialized late variable
class LateInitializationError extends RuntimeD4rtException {
  LateInitializationError(super.message);
}
