// ghissues80's test program (GitHub #24): a type argument compared with a
// type literal that has type arguments, `T == List<String>`.
//
// Valid Dart: the tests import it to get native Dart's answers, and run its
// text through the interpreter (tom_d4rt: test/ghissues80_applied_type_equality_test.dart;
// tom_d4rt_ast: bundles of the same file, parse-only and resolved,
// fixtures/ghissues80_parse_only.bundle.json and ghissues80_resolved.bundle.json,
// written by tom_ast_generator/tool/write_ghissues80_fixtures.dart).
// tom_d4rt_ast keeps a copy (test/runtime/fixtures/ghissues80_program.dart);
// the two must stay identical.

/// The issue's code: a type passed as a type argument or as a value.
class Protocol {
  Object compare<T>([Type? type]) {
    type ??= T;
    return [type == List<String>, T == List<String>];
  }
}

/// The issue's call: `[true, true]`.
Object issue() => Protocol().compare<List<String>>();

/// A script class with a type parameter.
class Box<T> {
  Box(this.value);
  Box.named(this.value);
  final T value;
}

bool _sameHash(Type a, Type b) => a.hashCode == b.hashCode;

Type _nullableOf<T>() => _Ty<T?>().t;

Type _typeOf<T>() => T;

class _Ty<T> {
  Type get t => T;
}

/// The unequal controls: other arguments, nullable, nested, another class.
List<Object> controls() => [
  Protocol().compare<List<int>>(),
  Protocol().compare<List<String>?>(),
  Protocol().compare<List<List<String>>>(),
  Protocol().compare<Map<String, int>>(),
  Protocol().compare<Set<String>>(),
  Protocol().compare<List<String>>(List<int>),
  List<String> == List<int>,
  _nullableOf<List<String>>() == List<String>,
  Box<int> == Box<String>,
  _typeOf<Box<int>>() == Box<String>,
  Box<int> == List<int>,
];

/// The equal cases: as values, as map keys, nested, a script class.
List<Object> equalities() => [
  Protocol().compare<List<String>>(List<String>),
  List<String> == List<String>,
  _sameHash(List<String>, List<String>),
  {List<String>: 1}[List<String>] ?? 'missing',
  _typeOf<List<List<String>>>() == List<List<String>>,
  _typeOf<Map<String, int>>() == Map<String, int>,
  _typeOf<Box<int>>() == Box<int>,
  Box<int> == Box<int>,
  _sameHash(_typeOf<Box<int>>(), Box<int>),
  '${List<String>}',
  '${Map<String, List<int>>}',
  '${Box<int>}',
];

/// Constructor tear-offs of an applied class still construct (ghissues79).
List<Object> tearOffs() {
  final make = Box<int>.new;
  final named = Box<int>.named;
  return [make(1).value, named(2).value];
}
