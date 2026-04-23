/// Phase 4 / summary-refactoring-plan: shared type-rendering helpers for
/// element-mode consumers.
///
/// Both [ElementModeExtractor] (bridge generation) and
/// `proxy_generator.dart` need to render a `DartType` as Dart source text
/// while preserving *function-typedef* aliases (e.g. `VoidCallback`,
/// `ValueChanged<T>`). The plain `type.getDisplayString()` loses those
/// aliases for function types, which causes downstream bridge and proxy
/// code to emit expanded function signatures that can drift from what the
/// analyzer legitimately resolves through the typedef.
///
/// Phase 1 / W6 introduced `_renderDartType` inside `ElementModeExtractor`.
/// Phase 4 extracts it into a shared helper so `ProxyGenerator` uses the
/// exact same rendering rules, guaranteeing proxy field/parameter/return
/// types match the bridge-side rendering and removing one more source of
/// drift between the two pipelines.
///
/// Rendering rules:
///   - `FunctionType` with a typedef alias → `AliasName<arg1, arg2>?`
///     (alias preserved, type arguments recursively rendered).
///   - `FunctionType` with no alias → `Return Function(params)?`.
///   - `InterfaceType` → `BaseName<arg1, arg2>?` (class-rename typedef
///     aliases are intentionally dropped — see §1.4 of the plan — so the
///     emitter resolves them via the concrete class's library URI).
///   - Anything else → `type.getDisplayString()`.
library;

import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Renders [type] to Dart source-like text with function-typedef aliases
/// preserved. See the library doc comment for the full set of rules.
String renderDartType(DartType type) {
  if (type is InterfaceType) {
    final baseName = type.element.name;
    if (baseName == null) return type.getDisplayString();
    final args = type.typeArguments;
    final argsText =
        args.isEmpty ? '' : '<${args.map(renderDartType).join(', ')}>';
    final nullable =
        type.nullabilitySuffix == NullabilitySuffix.question ? '?' : '';
    return '$baseName$argsText$nullable';
  }
  if (type is FunctionType) {
    final alias = type.alias;
    if (alias != null) {
      final aliasName = alias.element.name;
      if (aliasName != null) {
        final args = alias.typeArguments;
        final argsText =
            args.isEmpty ? '' : '<${args.map(renderDartType).join(', ')}>';
        final nullable =
            type.nullabilitySuffix == NullabilitySuffix.question ? '?' : '';
        return '$aliasName$argsText$nullable';
      }
    }
    final returnType = renderDartType(type.returnType);
    final positional = <String>[];
    final optional = <String>[];
    final named = <String>[];
    for (final p in type.formalParameters) {
      final pt = renderDartType(p.type);
      final pn = p.name ?? '';
      final label = pn.isNotEmpty ? '$pt $pn' : pt;
      if (p.isRequiredPositional) {
        positional.add(label);
      } else if (p.isOptionalPositional) {
        optional.add(label);
      } else if (p.isRequiredNamed) {
        named.add('required $label');
      } else {
        named.add(label);
      }
    }
    final parts = [...positional];
    if (optional.isNotEmpty) parts.add('[${optional.join(', ')}]');
    if (named.isNotEmpty) parts.add('{${named.join(', ')}}');
    // `?` on a function type binds to the whole function type; no outer
    // parens are needed and adding them would make `(X)?` parse as a
    // single-positional record in named-parameter positions in Dart 3.
    final nullable =
        type.nullabilitySuffix == NullabilitySuffix.question ? '?' : '';
    return '$returnType Function(${parts.join(', ')})$nullable';
  }
  return type.getDisplayString();
}
