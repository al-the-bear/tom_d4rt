import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

void main() {
  group('INTER-003: Sync* generator support', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt()..setDebug(false);
    });

    test('I-GEN-1: Basic sync* generator yields values via toList. [2026-02-10] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            Iterable<int> countTo(int n) sync* {
              for (var i = 1; i <= n; i++) {
                yield i;
              }
            }
            
            main() {
              // Use toList() directly to avoid iterator scoping issues
              return countTo(5).toList();
            }
          '''
        },
      );
      expect(result, [1, 2, 3, 4, 5]);
    });

    test('I-GEN-2: Sync* generator with .toList() call. [2026-02-10] (FAIL)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            Iterable<int> countTo(int n) sync* {
              for (var i = 1; i <= n; i++) {
                yield i;
              }
            }
            
            main() {
              var list = countTo(5).toList();
              return list;
            }
          '''
        },
      );
      expect(result, [1, 2, 3, 4, 5]);
    });

    test('I-GEN-3: Sync* generator with .take().toList() chain. [2026-02-10] (FAIL)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            Iterable<int> naturalNumbers() sync* {
              var n = 1;
              while (true) {
                yield n++;
              }
            }
            
            main() {
              var list = naturalNumbers().take(5).toList();
              return list;
            }
          '''
        },
      );
      expect(result, [1, 2, 3, 4, 5]);
    });

    test('I-GEN-4: Sync* generator with .map() and .toList(). [2026-02-10] (FAIL)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            Iterable<int> countTo(int n) sync* {
              for (var i = 1; i <= n; i++) {
                yield i;
              }
            }
            
            main() {
              var list = countTo(3).map((x) => x * 2).toList();
              return list;
            }
          '''
        },
      );
      expect(result, [2, 4, 6]);
    });

    test('I-GEN-5: Sync* generator with yield* via toList. [2026-02-10] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            Iterable<int> oneToThree() sync* {
              yield 1;
              yield 2;
              yield 3;
            }
            
            Iterable<int> oneToSix() sync* {
              yield* oneToThree();
              yield 4;
              yield 5;
              yield 6;
            }
            
            main() {
              // Use toList() directly to avoid for-in scoping issues
              return oneToSix().toList();
            }
          '''
        },
      );
      expect(result, [1, 2, 3, 4, 5, 6]);
    });
  });
}
