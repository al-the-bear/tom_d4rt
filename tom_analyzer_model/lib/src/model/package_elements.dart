part of 'model.dart';

/// Grouped view of elements belonging to a package.
class PackageElements {
  final List<ClassInfo> classes;
  final List<EnumInfo> enums;
  final List<FunctionInfo> functions;
  final List<MixinInfo> mixins;
  final List<ExtensionInfo> extensions;

  PackageElements({
    required this.classes,
    required this.enums,
    required this.functions,
    required this.mixins,
    required this.extensions,
  });

  List<TypeDeclaration> get allTypes => [
        ...classes,
        ...enums,
        ...mixins,
        ...extensions,
      ];

  List<ExecutableElement> get allExecutables => [
        ...functions,
        ...classes.expand((c) => c.methods),
        ...classes.expand((c) => c.getters),
        ...classes.expand((c) => c.setters),
      ];
}
