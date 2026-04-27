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
    // Elide `<dynamic, dynamic, ...>` tails — Dart's inferred-all-dynamic
    // type arguments are semantically equivalent to the bare generic and
    // preserving the `<dynamic>` suffix breaks downstream contains-checks
    // in the bridge generator (e.g. type-erasure bound for
    // `K extends Comparable` must render as `Comparable`, not
    // `Comparable<dynamic>`; see G-TE-13).
    //
    // The analyzer element API resolves type-parameter bounds via
    // `instantiateToBounds`, which produces the all-dynamic form even when
    // the source-level type had no explicit type arguments. AST-walker
    // mode rendered the source-level form; element mode inherits the
    // analyzer form. This guard restores source-form parity without
    // reaching back into the AST.
    final renderedArgs = args.map(renderDartType).toList();
    final allDynamic = renderedArgs.isNotEmpty &&
        renderedArgs.every((a) => a == 'dynamic');
    final argsText = (renderedArgs.isEmpty || allDynamic)
        ? ''
        : '<${renderedArgs.join(', ')}>';
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

/// Renders [type] like [renderDartType] but **always expands function-typedef
/// aliases** to their underlying `Return Function(args)` form.
///
/// C17: the proxy generator must use this rendering when emitting the type
/// argument to `D4.extractBridgedArg<T>` for a getter / method whose return
/// type is a function-typed typedef alias (e.g. `SemanticsBuilderCallback?`,
/// `ValueChanged<T>?`). The runtime extractor decides whether to wrap an
/// `InterpretedFunction` based on `T.toString().contains('Function')` —
/// alias-preserved typedef names like `SemanticsBuilderCallback` don't match
/// that heuristic, and the proxy-side `_parseFunctionType` also returns
/// `null` for them. The expanded form `List<CustomPainterSemantics> Function(Size)?`
/// triggers both code paths correctly.
///
/// Class-rename / interface typedefs are unaffected: only `FunctionType`
/// aliases are expanded; type arguments inside other types are still
/// recursively expanded too (so `Map<String, ValueChanged<int>?>` becomes
/// `Map<String, void Function(int)?>`).
String renderDartTypeExpanded(DartType type) {
  if (type is InterfaceType) {
    final baseName = type.element.name;
    if (baseName == null) return type.getDisplayString();
    final args = type.typeArguments;
    final renderedArgs = args.map(renderDartTypeExpanded).toList();
    final allDynamic = renderedArgs.isNotEmpty &&
        renderedArgs.every((a) => a == 'dynamic');
    final argsText = (renderedArgs.isEmpty || allDynamic)
        ? ''
        : '<${renderedArgs.join(', ')}>';
    final nullable =
        type.nullabilitySuffix == NullabilitySuffix.question ? '?' : '';
    return '$baseName$argsText$nullable';
  }
  if (type is FunctionType) {
    // C17: bypass alias preservation — emit the expanded function form.
    final returnType = renderDartTypeExpanded(type.returnType);
    final positional = <String>[];
    final optional = <String>[];
    final named = <String>[];
    for (final p in type.formalParameters) {
      final pt = renderDartTypeExpanded(p.type);
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
    final nullable =
        type.nullabilitySuffix == NullabilitySuffix.question ? '?' : '';
    return '$returnType Function(${parts.join(', ')})$nullable';
  }
  return type.getDisplayString();
}
