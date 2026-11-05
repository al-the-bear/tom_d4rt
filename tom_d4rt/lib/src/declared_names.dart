/// The name a top-level declaration introduces.
library;

import 'package:analyzer/dart/ast/ast.dart';

/// The name [d] introduces, for every kind analyzer 10 grouped as
/// `NamedCompilationUnitMember` (a class, enum, extension type, mixin,
/// function or type alias); null for any other declaration.
String? namedMemberName(CompilationUnitMember d) => switch (d) {
  ClassDeclaration(:final namePart) => namePart.typeName.lexeme,
  EnumDeclaration(:final namePart) => namePart.typeName.lexeme,
  ExtensionTypeDeclaration(:final namePart) => namePart.typeName.lexeme,
  MixinDeclaration(:final name) => name.lexeme,
  FunctionDeclaration(:final name) => name.lexeme,
  TypeAlias(:final name) => name.lexeme,
  _ => null,
};
