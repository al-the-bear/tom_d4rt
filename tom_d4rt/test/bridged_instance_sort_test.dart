/// Test for INTER-005: BridgedInstance unwrapping for native calls (sort)
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A sortable item that implements Comparable
class SortableItem implements Comparable<SortableItem> {
  final int value;
  final String name;

  SortableItem(this.value, [this.name = '']);

  @override
  int compareTo(SortableItem other) => value.compareTo(other.value);

  @override
  String toString() => 'SortableItem($value, $name)';
}

void main() {
  group('INTER-005: BridgedInstance sort', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();

      // Register the SortableItem bridged class
      final sortableItemBridge = BridgedClass(
        nativeType: SortableItem,
        name: 'SortableItem',
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final value = positionalArgs[0] as int;
            final name = positionalArgs.length > 1
                ? positionalArgs[1] as String
                : '';
            return SortableItem(value, name);
          },
        },
        getters: {
          'value': (visitor, instance) => (instance as SortableItem).value,
          'name': (visitor, instance) => (instance as SortableItem).name,
        },
        methods: {
          'compareTo': (visitor, instance, positionalArgs, namedArgs, _) {
            final target = instance as SortableItem;
            final other = positionalArgs[0];
            final otherItem =
                other is BridgedInstance ? other.nativeObject : other;
            return target.compareTo(otherItem as SortableItem);
          },
          'toString': (visitor, instance, positionalArgs, namedArgs, _) {
            return (instance as SortableItem).toString();
          },
        },
      );

      interpreter.registerBridgedClass(
          sortableItemBridge, 'package:test/sortable.dart');
    });

    test('sorting a list of BridgedInstance Comparable elements [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        import 'package:test/sortable.dart';

        List<int> main() {
          var items = [
            SortableItem(3, 'third'),
            SortableItem(1, 'first'),
            SortableItem(2, 'second'),
          ];
          items.sort();
          return [items[0].value, items[1].value, items[2].value];
        }
      ''');

      expect(result, equals([1, 2, 3]));
    });

    test('sorting preserves wrapper after sort [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        import 'package:test/sortable.dart';

        String main() {
          var items = [
            SortableItem(3, 'third'),
            SortableItem(1, 'first'),
          ];
          items.sort();
          // Access the name property to verify wrapper is preserved
          return items[0].name;
        }
      ''');

      expect(result, equals('first'));
    });

    test('sorting with custom comparator still works [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        import 'package:test/sortable.dart';

        List<int> main() {
          var items = [
            SortableItem(3, 'third'),
            SortableItem(1, 'first'),
            SortableItem(2, 'second'),
          ];
          // Reverse sort using custom comparator
          items.sort((a, b) => b.value.compareTo(a.value));
          return [items[0].value, items[1].value, items[2].value];
        }
      ''');

      expect(result, equals([3, 2, 1]));
    });

    test('sorting empty list does not throw [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        import 'package:test/sortable.dart';

        int main() {
          var items = <SortableItem>[];
          items.sort();
          return items.length;
        }
      ''');

      expect(result, equals(0));
    });

    test('sorting single element list works [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        import 'package:test/sortable.dart';

        int main() {
          var items = [SortableItem(42)];
          items.sort();
          return items[0].value;
        }
      ''');

      expect(result, equals(42));
    });

    test('sorting mixed list with integers still works [2026-02-10 06:37]', () async {
      // Test that native int sorting still works
      final result = await interpreter.execute(source: '''
        List<int> main() {
          var items = [3, 1, 2];
          items.sort();
          return items;
        }
      ''');

      expect(result, equals([1, 2, 3]));
    });

    test('sorting with strings still works [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        List<String> main() {
          var items = ['banana', 'apple', 'cherry'];
          items.sort();
          return items;
        }
      ''');

      expect(result, equals(['apple', 'banana', 'cherry']));
    });
  });
}
