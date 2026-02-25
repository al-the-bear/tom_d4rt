// D4rt test: GNRC06 - Generic collection classes (GEN-042 implicit ctors)
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Stack (GEN-042 - implicit default constructor)
  try {
    var stack = Stack();
    stack.push(1);
    stack.push(2);
    stack.push(3);

    if (stack.length != 3) {
      errors.add('Stack.length after 3 pushes expected 3, got ${stack.length}');
    }

    var popped = stack.pop();
    if (popped != 3) {
      errors.add('Stack.pop() expected 3, got $popped');
    }

    var peeked = stack.peek();
    if (peeked != 2) {
      errors.add('Stack.peek() expected 2, got $peeked');
    }

    if (stack.length != 2) {
      errors.add('Stack.length after pop expected 2, got ${stack.length}');
    }
  } catch (e) {
    errors.add('Stack() threw: $e');
  }

  // Test Queue (GEN-042 - implicit default constructor)
  try {
    var queue = Queue();
    queue.enqueue('first');
    queue.enqueue('second');
    queue.enqueue('third');

    if (queue.length != 3) {
      errors.add('Queue.length after 3 enqueues expected 3, got ${queue.length}');
    }

    var dequeued = queue.dequeue();
    if (dequeued != 'first') {
      errors.add('Queue.dequeue() expected "first", got "$dequeued"');
    }

    var front = queue.front;
    if (front != 'second') {
      errors.add('Queue.front expected "second", got "$front"');
    }

    if (queue.length != 2) {
      errors.add('Queue.length after dequeue expected 2, got ${queue.length}');
    }
  } catch (e) {
    errors.add('Queue() threw: $e');
  }

  if (errors.isEmpty) {
    print('GNRC06_PASSED');
  } else {
    print('GNRC06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
