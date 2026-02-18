import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

void main() {
  test('ElementNotFoundException formats message', () {
    final exception = ElementNotFoundException('Missing element');
    expect(exception.toString(), 'ElementNotFoundException: Missing element');
  });

  test('AmbiguousElementException formats candidates', () {
    final exception = AmbiguousElementException(
      'Ambiguous',
      candidates: ['a.A', 'b.A'],
    );

    expect(exception.toString(), contains('AmbiguousElementException: Ambiguous'));
    expect(exception.toString(), contains('Candidates:'));
    expect(exception.toString(), contains('- a.A'));
    expect(exception.toString(), contains('- b.A'));
  });
}
