/// Bounded string-selector dispatch for generated relaxer and constructor
/// factories.
///
/// A relaxer factory or an RC-2 generic constructor factory dispatches on a
/// type name: one `switch` arm per bridged type, about 3 200 arms each for the
/// full Flutter bridge set. A release AOT build compiles each such function as
/// a unit, and a hundred of them made the full set impractical to compile (the
/// frontend did not finish in 600 s, GitHub al-the-bear/tom_d4rt#11). Past
/// [maxSelectorsPerDispatchLeaf] selectors, [writeBoundedSelectorDispatch]
/// therefore splits the switch into leaf functions of at most that many
/// selectors, reached through a binary search on the selector.
///
/// The design follows the repair proposed in #11: deduplicate the selectors
/// first, keeping the first arm's expression; keep the arguments the arms read
/// typed; and keep the fallback for a selector no arm names.
library;

/// The most selectors one generated `switch` may dispatch on (#11).
const int maxSelectorsPerDispatchLeaf = 64;

/// One arm of a selector dispatch: the string [selectors] it matches and the
/// [expression] it yields.
class DispatchArm {
  const DispatchArm(this.selectors, this.expression);

  /// Matched values, written as single-quoted string literals.
  final List<String> selectors;

  /// The arm's result, written verbatim after `=>`.
  final String expression;
}

/// A value the arms read from the enclosing function, passed to each leaf as a
/// parameter of [type] under the same [name], so the arms compile unchanged.
typedef DispatchParameter = ({String type, String name});

/// The statements that dispatch on [selector], and the leaf functions they
/// call (empty when the dispatch fits one switch).
typedef BoundedDispatch = ({String statements, String leafFunctions});

/// Writes `return switch (selector) { arms, _ => fallback };`, indented by
/// [indent], when the arms name at most [maxSelectors] distinct selectors.
/// That form is unchanged from the unbounded generator, so a small dispatch is
/// written exactly as before.
///
/// Past the bound the statements route [selector] through a binary search on
/// sorted selector ranges to leaf functions named `<leafPrefix>$leaf<n>`, each a
/// `switch` over at most [maxSelectors] selectors ending in the same fallback.
/// A leaf takes the selector and [parameters], and returns [returnType]. A
/// selector named by more than one arm goes to the first; a selector no arm
/// names reaches a leaf whose switch falls back.
BoundedDispatch writeBoundedSelectorDispatch({
  required String selector,
  required List<DispatchArm> arms,
  required String fallback,
  required String returnType,
  required String leafPrefix,
  List<DispatchParameter> parameters = const [],
  String indent = '  ',
  int maxSelectors = maxSelectorsPerDispatchLeaf,
}) {
  if (maxSelectors < 1) {
    throw ArgumentError.value(maxSelectors, 'maxSelectors', 'must be >= 1');
  }

  // First arm wins, as in the switch it replaces.
  final armOf = <String, int>{};
  for (var i = 0; i < arms.length; i++) {
    for (final s in arms[i].selectors) {
      armOf.putIfAbsent(s, () => i);
    }
  }

  if (armOf.length <= maxSelectors) {
    final b = StringBuffer();
    _writeSwitch(b, indent, selector, arms, fallback);
    return (statements: b.toString(), leafFunctions: '');
  }

  final sorted = armOf.keys.toList()..sort();
  final leaves = <List<String>>[
    for (var i = 0; i < sorted.length; i += maxSelectors)
      sorted.sublist(
        i,
        i + maxSelectors < sorted.length ? i + maxSelectors : sorted.length,
      ),
  ];

  final callArgs = [selector, for (final p in parameters) p.name].join(', ');
  final statements = StringBuffer();
  _writeRoute(
    statements,
    indent,
    selector,
    leaves,
    0,
    leaves.length - 1,
    (i) => '${_leafName(leafPrefix, i)}($callArgs)',
  );

  final leafParams = [
    'String $selector',
    for (final p in parameters) '${p.type} ${p.name}',
  ].join(', ');
  final functions = StringBuffer();
  for (var i = 0; i < leaves.length; i++) {
    final leafArms = <DispatchArm>[];
    final byArm = <int, List<String>>{};
    for (final s in leaves[i]) {
      byArm.putIfAbsent(armOf[s]!, () => []).add(s);
    }
    final order = byArm.keys.toList()..sort();
    for (final a in order) {
      leafArms.add(DispatchArm(byArm[a]!, arms[a].expression));
    }
    functions.writeln(
      "/// Selectors '${leaves[i].first}' to '${leaves[i].last}' of "
      '`$leafPrefix` (bounded dispatch, al-the-bear/tom_d4rt#11).',
    );
    functions.writeln('$returnType ${_leafName(leafPrefix, i)}($leafParams) {');
    _writeSwitch(functions, '  ', selector, leafArms, fallback);
    functions.writeln('}');
    functions.writeln();
  }

  return (
    statements: statements.toString(),
    leafFunctions: functions.toString(),
  );
}

String _leafName(String prefix, int index) => '$prefix\$leaf$index';

void _writeSwitch(
  StringBuffer b,
  String indent,
  String selector,
  List<DispatchArm> arms,
  String fallback,
) {
  b.writeln('${indent}return switch ($selector) {');
  for (final arm in arms) {
    final pattern = arm.selectors.map((s) => "'$s'").join(' || ');
    b.writeln('$indent  $pattern => ${arm.expression},');
  }
  b.writeln('$indent  _ => $fallback,');
  b.writeln('$indent};');
}

/// Routes to leaves [lo]..[hi] by comparing the selector with the first
/// selector of the middle leaf.
void _writeRoute(
  StringBuffer b,
  String indent,
  String selector,
  List<List<String>> leaves,
  int lo,
  int hi,
  String Function(int) call,
) {
  if (lo == hi) {
    b.writeln('${indent}return ${call(lo)};');
    return;
  }
  final mid = (lo + hi + 1) ~/ 2;
  b.writeln("${indent}if ($selector.compareTo('${leaves[mid].first}') < 0) {");
  _writeRoute(b, '$indent  ', selector, leaves, lo, mid - 1, call);
  b.writeln('$indent}');
  _writeRoute(b, indent, selector, leaves, mid, hi, call);
}
