import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:test/test.dart';

void main() {
  test('creates analyzer instance', () {
    final analyzer = TomAnalyzer();
    expect(analyzer, isA<TomAnalyzer>());
  });
}
