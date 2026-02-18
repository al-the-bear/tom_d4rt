// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor2.dart';

/// Collects analyzer elements during traversal.
class ElementVisitorResult {
  final classes = <ClassElement>[];
  final enums = <EnumElement>[];
  final mixins = <MixinElement>[];
  final extensions = <ExtensionElement>[];
  final extensionTypes = <ExtensionTypeElement>[];
  final typeAliases = <TypeAliasElement>[];
  final functions = <TopLevelFunctionElement>[];
  final topLevelVariables = <TopLevelVariableElement>[];
  final accessors = <PropertyAccessorElement>[];
  final constructors = <ConstructorElement>[];
}

/// Basic analyzer visitor that gathers key element types.
class TomElementVisitor extends GeneralizingElementVisitor2<void> {
  final ElementVisitorResult result;

  TomElementVisitor(this.result);

  @override
  void visitClassElement(ClassElement element) {
    result.classes.add(element);
    super.visitClassElement(element);
  }

  @override
  void visitEnumElement(EnumElement element) {
    result.enums.add(element);
    super.visitEnumElement(element);
  }

  @override
  void visitMixinElement(MixinElement element) {
    result.mixins.add(element);
    super.visitMixinElement(element);
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    result.extensions.add(element);
    super.visitExtensionElement(element);
  }

  @override
  void visitExtensionTypeElement(ExtensionTypeElement element) {
    result.extensionTypes.add(element);
    super.visitExtensionTypeElement(element);
  }

  @override
  void visitTypeAliasElement(TypeAliasElement element) {
    result.typeAliases.add(element);
    super.visitTypeAliasElement(element);
  }

  @override
  void visitTopLevelFunctionElement(TopLevelFunctionElement element) {
    result.functions.add(element);
    super.visitTopLevelFunctionElement(element);
  }

  @override
  void visitTopLevelVariableElement(TopLevelVariableElement element) {
    result.topLevelVariables.add(element);
    super.visitTopLevelVariableElement(element);
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    result.accessors.add(element);
    super.visitPropertyAccessorElement(element);
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    result.constructors.add(element);
    super.visitConstructorElement(element);
  }
}
