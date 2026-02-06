/// Demonstrates Dart generic classes
///
/// Features covered:
/// - Generic class declaration
/// - Type parameters
/// - Multiple type parameters
/// - Generic methods in classes
/// - Type inference

void main() {
  print('=== Generic Classes ===');
  print('');

  // Simple generic class
  print('--- Simple Generic Class ---');
  var intBox = Box<int>(42);
  var stringBox = Box<String>('Hello');
  var listBox = Box<List<int>>([1, 2, 3]);

  print('intBox.value: ${intBox.value}');
  print('stringBox.value: ${stringBox.value}');
  print('listBox.value: ${listBox.value}');

  // Type inference
  print('');
  print('--- Type Inference ---');
  var inferredBox = Box(3.14); // Inferred as Box<double>
  print('inferredBox.value: ${inferredBox.value}');
  print('Type: ${inferredBox.value.runtimeType}');

  // Generic with methods
  print('');
  print('--- Generic with Methods ---');
  var wrapper = Wrapper<String>('Hello');
  print('Original: ${wrapper.value}');
  wrapper.value = 'World';
  print('Changed: ${wrapper.value}');

  var doubled = wrapper.transform((s) => '$s $s');
  print('Doubled type: ${doubled.runtimeType}');
  print('Doubled value: ${doubled.value}');

  // Multiple type parameters
  print('');
  print('--- Multiple Type Parameters ---');
  var pair = Pair<String, int>('Age', 25);
  print('Pair: (${pair.first}, ${pair.second})');
  print('Swapped: ${pair.swap()}');

  var entry = Pair<int, String>(1, 'One');
  print('Entry: (${entry.first}, ${entry.second})');

  // Stack implementation
  print('');
  print('--- Generic Stack ---');
  var stack = Stack<int>();
  stack.push(1);
  stack.push(2);
  stack.push(3);

  print('Stack: $stack');
  print('Pop: ${stack.pop()}');
  print('Peek: ${stack.peek()}');
  print('After pop: $stack');

  // Queue implementation
  print('');
  print('--- Generic Queue ---');
  var queue = Queue<String>();
  queue.enqueue('First');
  queue.enqueue('Second');
  queue.enqueue('Third');

  print('Queue: $queue');
  print('Dequeue: ${queue.dequeue()}');
  print('Front: ${queue.front}');
  print('After dequeue: $queue');

  // Optional/Maybe type
  print('');
  print('--- Optional/Maybe Type ---');
  var someValue = Maybe<int>.some(42);
  var noValue = Maybe<int>.none();

  print('someValue.hasValue: ${someValue.hasValue}');
  print('someValue.value: ${someValue.value}');
  print('noValue.hasValue: ${noValue.hasValue}');
  print('noValue.getOrElse(0): ${noValue.getOrElse(0)}');

  // Result type
  print('');
  print('--- Result Type ---');
  var success = Result<int, String>.success(42);
  var failure = Result<int, String>.failure('Something went wrong');

  print('success: ${success.fold((v) => 'Value: $v', (e) => 'Error: $e')}');
  print('failure: ${failure.fold((v) => 'Value: $v', (e) => 'Error: $e')}');

  print('');
  print('=== End of Generic Classes Demo ===');
}

// Simple generic class
class Box<T> {
  final T value;
  Box(this.value);
}

// Generic with mutable value and transform
class Wrapper<T> {
  T value;
  Wrapper(this.value);

  Wrapper<R> transform<R>(R Function(T) f) {
    return Wrapper<R>(f(value));
  }
}

// Multiple type parameters
class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);

  Pair<S, F> swap() => Pair(second, first);

  @override
  String toString() => 'Pair($first, $second)';
}

// Generic Stack
class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.removeLast();
  }

  T peek() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Stack($_items)';
}

// Generic Queue
class Queue<T> {
  final List<T> _items = [];

  void enqueue(T item) => _items.add(item);

  T dequeue() {
    if (_items.isEmpty) throw StateError('Queue is empty');
    return _items.removeAt(0);
  }

  T get front {
    if (_items.isEmpty) throw StateError('Queue is empty');
    return _items.first;
  }

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Queue($_items)';
}

// Optional/Maybe type
class Maybe<T> {
  final T? _value;
  final bool hasValue;

  Maybe.some(T value)
      : _value = value,
        hasValue = true;

  Maybe.none()
      : _value = null,
        hasValue = false;

  T get value {
    if (!hasValue) throw StateError('No value present');
    return _value as T;
  }

  T getOrElse(T defaultValue) => hasValue ? _value as T : defaultValue;

  Maybe<R> map<R>(R Function(T) f) {
    if (hasValue) {
      return Maybe.some(f(_value as T));
    }
    return Maybe.none();
  }
}

// Result type (Either)
class Result<T, E> {
  final T? _value;
  final E? _error;
  final bool isSuccess;

  Result.success(T value)
      : _value = value,
        _error = null,
        isSuccess = true;

  Result.failure(E error)
      : _value = null,
        _error = error,
        isSuccess = false;

  R fold<R>(R Function(T) onSuccess, R Function(E) onFailure) {
    if (isSuccess) {
      return onSuccess(_value as T);
    }
    return onFailure(_error as E);
  }
}
