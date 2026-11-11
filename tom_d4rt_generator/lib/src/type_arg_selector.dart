/// The name a name-keyed generic dispatch matches a script's type argument by.
///
/// The interpreter reports a type argument's name with its `?` and its own
/// type arguments (`int?`, `List<int>`, `List<int>?`). The generated dispatch
/// switches - RC-2 generic constructors, generic constructor and interceptor
/// templates - list plain class names, so they match the name with the type
/// arguments taken off and the `?` kept (ghissues42).
library;

/// The Dart expression that takes the type arguments off the name held by
/// [variable]: `List<int>` becomes `List`, `List<int>?` becomes `List?`.
String typeArgNameWithoutTypeArgs(String variable) =>
    "$variable.replaceFirst(RegExp(r'<.*>'), '')";

/// Emits `final typeName = ...;`, the name the dispatch switch matches.
///
/// A type argument's name keeps its `?` and its own type arguments (`int?`,
/// `List<int>`). A configured variant matches its name verbatim; any other
/// name loses its type arguments (`PopupMenuButtonState<String>` dispatches as
/// `PopupMenuButtonState`) and keeps its `?` (ghissues42).
void writeTypeArgNameSelector(StringBuffer b, List<String> variants) {
  b.writeln(
    '    final rawTypeName = (typeArgs != null && typeArgs.isNotEmpty)',
  );
  b.writeln('        ? typeArgs[0].name');
  b.writeln('        : null;');
  final nested = [
    for (final v in variants)
      if (v.contains('<')) "'$v'",
  ];
  final strip = typeArgNameWithoutTypeArgs('rawTypeName?');
  if (nested.isEmpty) {
    b.writeln('    final typeName = $strip;');
  } else {
    b.writeln(
      '    final typeName = const {${nested.join(', ')}}.contains(rawTypeName)',
    );
    b.writeln('        ? rawTypeName');
    b.writeln('        : $strip;');
  }
}
