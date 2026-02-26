/// Callback and async examples for bridge generation testing.
/// 
/// This file demonstrates callback and async bridging capabilities:
/// - Methods accepting function callbacks
/// - Async methods (Future return types)
/// - Stream methods
/// - Callbacks with various signatures
library;

/// A result wrapper for callbacks.
class Result<T> {
  final T? value;
  final String? error;

  Result.success(this.value) : error = null;
  Result.failure(this.error) : value = null;

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  @override
  String toString() => isSuccess ? 'Success($value)' : 'Failure($error)';
}

/// A task scheduler demonstrating callbacks.
class TaskScheduler {
  final List<void Function()> _tasks = [];

  /// Default constructor.
  TaskScheduler();

  /// Add a simple callback task.
  void addTask(void Function() task) => _tasks.add(task);

  /// Run all tasks.
  void runAll() {
    for (final task in _tasks) {
      task();
    }
  }

  /// Run task with result handler.
  void runWithHandler<T>(
    T Function() task,
    void Function(T) onSuccess,
    void Function(Object) onError,
  ) {
    try {
      final result = task();
      onSuccess(result);
    } catch (e) {
      onError(e);
    }
  }

  /// Transform values with mapper callback.
  List<R> mapValues<T, R>(List<T> values, R Function(T) mapper) {
    return values.map(mapper).toList();
  }

  /// Filter values with predicate callback.
  List<T> filterValues<T>(List<T> values, bool Function(T) predicate) {
    return values.where(predicate).toList();
  }

  /// Reduce values with accumulator callback.
  T reduceValues<T>(List<T> values, T Function(T, T) combiner) {
    return values.reduce(combiner);
  }

  /// Static method with callback.
  static List<T> generate<T>(int count, T Function(int) generator) {
    return List.generate(count, generator);
  }
}

/// A class demonstrating async operations.
class AsyncService {
  final String name;
  final int _delayMs;

  AsyncService(this.name, [this._delayMs = 10]);

  /// Simple async method.
  Future<String> fetchData() async {
    await Future.delayed(Duration(milliseconds: _delayMs));
    return 'Data from $name';
  }

  /// Async method with parameter.
  Future<String> fetchById(String id) async {
    await Future.delayed(Duration(milliseconds: _delayMs));
    return 'Item $id from $name';
  }

  /// Async method with callback for progress.
  Future<String> fetchWithProgress(
    void Function(int) onProgress,
  ) async {
    for (var i = 0; i <= 100; i += 25) {
      await Future.delayed(Duration(milliseconds: _delayMs ~/ 5));
      onProgress(i);
    }
    return 'Complete from $name';
  }

  /// Async method returning generic Result.
  Future<Result<String>> tryFetch(String id) async {
    await Future.delayed(Duration(milliseconds: _delayMs));
    if (id.isEmpty) {
      return Result.failure('ID cannot be empty');
    }
    return Result.success('Fetched $id from $name');
  }

  /// Static async factory.
  static Future<AsyncService> create(String name) async {
    await Future.delayed(const Duration(milliseconds: 5));
    return AsyncService(name);
  }
}

/// Event listener callback types.
typedef EventCallback = void Function(String event);
typedef DataCallback<T> = void Function(T data);

/// An event emitter demonstrating callback registration.
class EventEmitter {
  final Map<String, List<EventCallback>> _listeners = {};

  /// Default constructor.
  EventEmitter();

  /// Register a listener for an event.
  void on(String event, EventCallback callback) {
    _listeners.putIfAbsent(event, () => []).add(callback);
  }

  /// Emit an event to all listeners.
  void emit(String event) {
    final listeners = _listeners[event];
    if (listeners != null) {
      // Create a copy to avoid concurrent modification when listeners remove themselves
      for (final listener in List.of(listeners)) {
        listener(event);
      }
    }
  }

  /// Remove a listener.
  void off(String event, EventCallback callback) {
    _listeners[event]?.remove(callback);
  }

  /// Register a one-time listener.
  void once(String event, EventCallback callback) {
    late EventCallback wrapper;
    wrapper = (e) {
      callback(e);
      off(event, wrapper);
    };
    on(event, wrapper);
  }

  /// Get listener count for an event.
  int listenerCount(String event) => _listeners[event]?.length ?? 0;
}
