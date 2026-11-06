/// The name a top-level declaration introduces.
library;

import 'package:tom_d4rt_ast/ast.dart';

/// The name [d] introduces, for every kind analyzer 10 grouped as
/// `NamedCompilationUnitMember` (a class, enum, extension type, mixin,
/// function or type alias); null for any other declaration.
String? namedMemberName(SCompilationUnitMember d) => switch (d) {
  SClassDeclaration(:final namePart) => namePart.typeName.name,
  SEnumDeclaration(:final namePart) => namePart.typeName.name,
  SExtensionTypeDeclaration(:final namePart) => namePart.typeName.name,
  SMixinDeclaration(:final name) => name?.name,
  SFunctionDeclaration(:final name) => name?.name,
  STypedefDeclaration(:final name) => name?.name,
  _ => null,
};
