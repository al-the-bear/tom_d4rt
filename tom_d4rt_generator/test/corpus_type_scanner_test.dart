/// Tests for the corpus type-combination scanner.
///
/// The scanner ([CorpusTypeScanner]) statically walks D4rt test scripts and
/// collects the bare names of every type that appears as a type argument in a
/// generic instantiation — at any nesting depth — so the reduced relaxer/RC-2
/// generation can enumerate only the type-args the corpus actually
/// exercises. Parsing runs in recovery mode (`throwIfDiagnostics: false`), so
/// scripts that don't type-check in isolation still yield their type-args.
///
/// These tests pin: flat generic args, nested generic args (every depth),
/// collection-literal type args, generic-method invocation type args,
/// `extractBridgedArg<Base<Arg>>`-style nested forms, de-duplication with
/// counts, the `dynamic`/`void`/`Never` exclusion, and the YAML/text emitters.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('CorpusTypeScanner.scanSource', () {
    const scanner = CorpusTypeScanner();

    test('G-CTS-1: flat generic instantiation collects each type-arg', () {
      final counts = scanner.scanSource('''
        void main() {
          final t = Tween<double>(begin: 0, end: 1);
          final n = ValueNotifier<int>(0);
        }
      ''');
      expect(counts.keys, containsAll(<String>['double', 'int']));
      expect(counts['double'], 1);
      expect(counts['int'], 1);
    });

    test('G-CTS-2: nested generic args captured at every depth', () {
      final counts = scanner.scanSource('''
        void main() {
          final m = <String, List<Color>>{};
        }
      ''');
      // Outer list yields String + List; inner list yields Color.
      expect(counts.keys, containsAll(<String>['String', 'List', 'Color']));
      expect(counts['String'], 1);
      expect(counts['List'], 1);
      expect(counts['Color'], 1);
    });

    test('G-CTS-3: generic-method invocation type-args collected', () {
      final counts = scanner.scanSource('''
        void main() {
          final v = context.read<MyModel>();
          final xs = items.cast<Widget>();
        }
      ''');
      expect(counts.keys, containsAll(<String>['MyModel', 'Widget']));
    });

    test('G-CTS-4: extractBridgedArg<Base<Arg>> nested form collected', () {
      final counts = scanner.scanSource('''
        Object? f() {
          return extractBridgedArg<Tween<Offset>>(arg);
        }
      ''');
      // Outer arg list yields Tween; inner yields Offset.
      expect(counts.keys, containsAll(<String>['Tween', 'Offset']));
    });

    test('G-CTS-5: de-duplicates with occurrence counts', () {
      final counts = scanner.scanSource('''
        void main() {
          final a = ValueNotifier<int>(0);
          final b = ValueNotifier<int>(1);
          final c = Tween<int>();
        }
      ''');
      expect(counts['int'], 3);
      expect(counts['ValueNotifier'], isNull,
          reason: 'constructor names are not type-args');
    });

    test('G-CTS-6: dynamic / void / Never are excluded', () {
      final counts = scanner.scanSource('''
        void main() {
          final a = <dynamic>[];
          final b = Future<void>.value();
          final c = <Never>[];
          final d = <int>[];
        }
      ''');
      expect(counts.containsKey('dynamic'), isFalse);
      expect(counts.containsKey('void'), isFalse);
      expect(counts.containsKey('Never'), isFalse);
      expect(counts['int'], 1);
    });

    test('G-CTS-7: malformed source still yields parseable type-args', () {
      // Missing closing brace — recovery mode must not throw.
      final counts = scanner.scanSource('''
        void main() {
          final t = Tween<double>(begin: 0
      ''');
      expect(counts['double'], 1);
    });

    test('G-CTS-8: source with no generics yields empty map', () {
      final counts = scanner.scanSource('''
        void main() {
          final x = 1 + 2;
          print(x);
        }
      ''');
      expect(counts, isEmpty);
    });
  });

  group('CorpusTypeScanner emitters', () {
    const scanner = CorpusTypeScanner();

    CorpusTypeScanResult resultOf(Map<String, int> counts) =>
        CorpusTypeScanResult(typeArgumentCounts: counts, filesScanned: 1);

    test('G-CTS-9: sortedTypeArguments is ascending and de-duplicated', () {
      final r = resultOf({'Color': 2, 'Apple': 1, 'double': 5});
      expect(r.sortedTypeArguments, ['Apple', 'Color', 'double']);
      expect(r.distinctCount, 3);
    });

    test('G-CTS-10: toYamlAllowlist emits sorted additionalRelaxerTypes block',
        () {
      final yaml = scanner.toYamlAllowlist(resultOf({'Color': 1, 'Apple': 1}));
      expect(yaml, contains('additionalRelaxerTypes:'));
      // Apple before Color (sorted), each as a list item.
      final appleIdx = yaml.indexOf('  - Apple');
      final colorIdx = yaml.indexOf('  - Color');
      expect(appleIdx, greaterThanOrEqualTo(0));
      expect(colorIdx, greaterThan(appleIdx));
    });

    test('G-CTS-11: toYamlAllowlist prefixes header as comment lines', () {
      final yaml = scanner.toYamlAllowlist(
        resultOf({'Color': 1}),
        header: 'line one\nline two',
      );
      expect(yaml, contains('# line one'));
      expect(yaml, contains('# line two'));
    });

    test('G-CTS-12: toTextAllowlist is newline-joined sorted names', () {
      final text = scanner.toTextAllowlist(resultOf({'Color': 1, 'Apple': 1}));
      expect(text, 'Apple\nColor\n');
    });
  });
}
