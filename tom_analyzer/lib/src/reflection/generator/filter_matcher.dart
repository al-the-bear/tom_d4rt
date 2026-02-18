/// Filter matching utilities for reflection configuration.
///
/// Provides glob-pattern matching for packages, paths, types, and elements
/// used by [ReflectionFilter] and [ReflectionDefaults].
library;

// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';

import 'reflection_config.dart';

/// Matches elements against filter patterns.
///
/// This class evaluates [ReflectionFilter] instances against Dart elements
/// from the analyzer.
class FilterMatcher {
  /// The filter to match against.
  final ReflectionFilter filter;

  /// Compiled package matchers.
  late final List<GlobMatcher> _packageMatchers;

  /// Compiled path matchers.
  late final List<GlobMatcher> _pathMatchers;

  /// Compiled type matchers.
  late final List<GlobMatcher> _typeMatchers;

  /// Annotation patterns (stored as-is for qualified matching).
  late final List<AnnotationPattern> _annotationPatterns;

  /// Element identifiers (stored as-is for exact matching).
  late final Set<String> _elementIds;

  FilterMatcher(this.filter) {
    _packageMatchers =
        filter.packages.map((p) => GlobMatcher(p)).toList(growable: false);
    _pathMatchers =
        filter.paths.map((p) => GlobMatcher(p)).toList(growable: false);
    _typeMatchers =
        filter.types.map((t) => GlobMatcher(t)).toList(growable: false);
    _annotationPatterns = filter.annotations
        .map((a) => AnnotationPattern.parse(a))
        .toList(growable: false);
    _elementIds = filter.elements.toSet();
  }

  /// Check if the filter matches by package name.
  bool matchesPackage(String packageName) {
    if (_packageMatchers.isEmpty) return false;
    return _packageMatchers.any((m) => m.matches(packageName));
  }

  /// Check if the filter matches by file path.
  bool matchesPath(String filePath) {
    if (_pathMatchers.isEmpty) return false;
    return _pathMatchers.any((m) => m.matches(filePath));
  }

  /// Check if the filter matches by type name.
  bool matchesTypeName(String typeName) {
    if (_typeMatchers.isEmpty) return false;
    return _typeMatchers.any((m) => m.matches(typeName));
  }

  /// Check if the filter matches by annotation.
  bool matchesAnnotation(List<ElementAnnotation> annotations) {
    if (_annotationPatterns.isEmpty) return false;
    return _annotationPatterns.any((pattern) {
      return annotations.any((ann) => pattern.matches(ann));
    });
  }

  /// Check if the filter matches by element identifier.
  bool matchesElement(String elementId) {
    if (_elementIds.isEmpty) return false;
    return _elementIds.contains(elementId);
  }

  /// Check if this filter has any selectors.
  bool get hasSelectors => filter.hasSelectors;

  /// Check if this is an include filter.
  bool get isInclude => filter.isInclude;

  /// Evaluate the filter against an element.
  ///
  /// Returns `true` if the element matches this filter.
  bool matches(Element element) {
    // If no selectors, doesn't match anything specific
    if (!hasSelectors) return false;

    // Check element ID first (most specific)
    final elementId = _getElementId(element);
    if (matchesElement(elementId)) return true;

    // Check package
    final packageName = _getPackageName(element);
    if (packageName != null && matchesPackage(packageName)) return true;

    // Check file path
    final filePath = _getFilePath(element);
    if (filePath != null && matchesPath(filePath)) return true;

    // Check type name (for type elements)
    if (element is InterfaceElement || element is TypeAliasElement) {
      if (matchesTypeName(element.name ?? '')) return true;
    }

    // Check annotations
    if (matchesAnnotation(element.metadata.annotations)) return true;

    return false;
  }

  String _getElementId(Element element) {
    final libraryUri = element.library?.firstFragment.source.uri.toString() ?? '';
    return '$libraryUri#${element.name}';
  }

  String? _getPackageName(Element element) {
    final uri = element.library?.firstFragment.source.uri;
    if (uri == null) return null;
    if (uri.scheme == 'package') {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }
    if (uri.scheme == 'dart') {
      return 'dart:${uri.path}';
    }
    return null;
  }

  String? _getFilePath(Element element) {
    final uri = element.library?.firstFragment.source.uri;
    if (uri == null) return null;
    return uri.toString();
  }
}

/// Matches default settings against elements.
class DefaultsMatcher {
  /// The defaults to match against.
  final ReflectionDefaults defaults;

  /// Compiled exclude package matchers.
  late final List<GlobMatcher> _excludePackageMatchers;

  /// Compiled include package matchers.
  late final List<GlobMatcher> _includePackageMatchers;

  /// Annotation patterns for include.
  late final List<AnnotationPattern> _includeAnnotationPatterns;

  DefaultsMatcher(this.defaults) {
    _excludePackageMatchers =
        defaults.excludePackages.map((p) => GlobMatcher(p)).toList();
    _includePackageMatchers =
        defaults.includePackages.map((p) => GlobMatcher(p)).toList();
    _includeAnnotationPatterns = defaults.includeAnnotations
        .map((a) => AnnotationPattern.parse(a))
        .toList();
  }

  /// Check if a package should be excluded by default.
  bool isPackageExcluded(String packageName) {
    return _excludePackageMatchers.any((m) => m.matches(packageName));
  }

  /// Check if a package should be included by default.
  bool isPackageIncluded(String packageName) {
    return _includePackageMatchers.any((m) => m.matches(packageName));
  }

  /// Check if annotations trigger inclusion.
  bool hasIncludeAnnotation(List<ElementAnnotation> annotations) {
    if (_includeAnnotationPatterns.isEmpty) return false;
    return _includeAnnotationPatterns.any((pattern) {
      return annotations.any((ann) => pattern.matches(ann));
    });
  }
}

/// Simple glob pattern matcher.
///
/// Supports:
/// - `*` matches any characters except `/`
/// - `**` matches any characters including `/`
/// - `?` matches a single character
class GlobMatcher {
  final String pattern;
  late final RegExp _regex;

  GlobMatcher(this.pattern) {
    _regex = _compileGlob(pattern);
  }

  /// Check if the pattern matches the input.
  bool matches(String input) {
    return _regex.hasMatch(input);
  }

  static RegExp _compileGlob(String pattern) {
    final buffer = StringBuffer('^');
    var i = 0;
    while (i < pattern.length) {
      final c = pattern[i];
      if (c == '*') {
        if (i + 1 < pattern.length && pattern[i + 1] == '*') {
          // ** matches anything including /
          buffer.write('.*');
          i += 2;
        } else {
          // * matches anything except /
          buffer.write('[^/]*');
          i++;
        }
      } else if (c == '?') {
        buffer.write('.');
        i++;
      } else if (_isRegexSpecial(c)) {
        buffer.write('\\$c');
        i++;
      } else {
        buffer.write(c);
        i++;
      }
    }
    buffer.write(r'$');
    return RegExp(buffer.toString());
  }

  static bool _isRegexSpecial(String c) {
    return r'\.+[]{}()^$|'.contains(c);
  }
}

/// Parsed annotation pattern.
///
/// Supports:
/// - Short name: `Entity`
/// - Qualified name: `package:my_app/annotations.dart#Entity`
/// - With field matching: `Entity(tableName: *)`
class AnnotationPattern {
  /// The annotation name (short or qualified).
  final String name;

  /// Whether this is a qualified name (contains `#` or `package:`).
  final bool isQualified;

  /// Field matchers for annotation arguments.
  final Map<String, GlobMatcher>? fieldMatchers;

  AnnotationPattern({
    required this.name,
    required this.isQualified,
    this.fieldMatchers,
  });

  /// Parse an annotation pattern string.
  static AnnotationPattern parse(String pattern) {
    // Check for field matchers: Entity(tableName: *)
    final parenIndex = pattern.indexOf('(');
    if (parenIndex != -1 && pattern.endsWith(')')) {
      final name = pattern.substring(0, parenIndex);
      final fieldsStr = pattern.substring(parenIndex + 1, pattern.length - 1);
      final fieldMatchers = _parseFieldMatchers(fieldsStr);
      return AnnotationPattern(
        name: name,
        isQualified: name.contains('#') || name.startsWith('package:'),
        fieldMatchers: fieldMatchers,
      );
    }

    return AnnotationPattern(
      name: pattern,
      isQualified: pattern.contains('#') || pattern.startsWith('package:'),
    );
  }

  static Map<String, GlobMatcher>? _parseFieldMatchers(String fieldsStr) {
    if (fieldsStr.isEmpty) return null;
    final matchers = <String, GlobMatcher>{};
    // Simple parsing: "key: value, key2: value2"
    final parts = fieldsStr.split(',');
    for (final part in parts) {
      final colonIndex = part.indexOf(':');
      if (colonIndex != -1) {
        final key = part.substring(0, colonIndex).trim();
        final value = part.substring(colonIndex + 1).trim();
        matchers[key] = GlobMatcher(value);
      }
    }
    return matchers.isEmpty ? null : matchers;
  }

  /// Check if this pattern matches an annotation.
  bool matches(ElementAnnotation annotation) {
    // Use deprecated element API (element2 types not fully available yet)
    final element = annotation.element;
    if (element == null) return false;

    // Get the annotation type name
    String? annotationName;
    String? qualifiedName;

    if (element is ConstructorElement) {
      // For constructor annotations, get the enclosing class name
      // Use enclosingElement which is the current API in analyzer 8.x
      final enclosing = element.enclosingElement;
      annotationName = enclosing.name;
      final libraryUri = element.library.firstFragment.source.uri.toString();
      qualifiedName = '$libraryUri#$annotationName';
    } else if (element is PropertyAccessorElement) {
      annotationName = element.name;
      final libraryUri = element.library.firstFragment.source.uri.toString();
      qualifiedName = '$libraryUri#$annotationName';
    } else {
      annotationName = element.name;
      qualifiedName = element.name;
    }

    // Match the name
    if (isQualified) {
      if (qualifiedName != name) return false;
    } else {
      if (annotationName != name) return false;
    }

    // Match fields if specified
    if (fieldMatchers != null) {
      // Field matching requires evaluating the annotation's constant value
      // This is complex and would require computing the constant value.
      // For now, we skip field matching if we can't evaluate it.
      final computed = annotation.computeConstantValue();
      if (computed == null) return false;

      for (final entry in fieldMatchers!.entries) {
        final fieldValue = computed.getField(entry.key);
        if (fieldValue == null) return false;
        final stringValue = fieldValue.toStringValue() ??
            fieldValue.toIntValue()?.toString() ??
            fieldValue.toBoolValue()?.toString() ??
            '';
        if (!entry.value.matches(stringValue)) return false;
      }
    }

    return true;
  }
}

/// Combines defaults and filters to determine element inclusion.
class InclusionResolver {
  final DefaultsMatcher defaults;
  final List<FilterMatcher> filters;

  InclusionResolver({
    required ReflectionDefaults defaultsConfig,
    required List<ReflectionFilter> filterConfigs,
  })  : defaults = DefaultsMatcher(defaultsConfig),
        filters = filterConfigs.map((f) => FilterMatcher(f)).toList();

  /// Determine if an element should be included in reflection.
  ///
  /// Returns `true` if included, `false` if excluded, `null` if neither
  /// (should use default reachability behavior).
  bool? shouldInclude(Element element) {
    // Check default exclusions first
    final packageName = _getPackageName(element);
    if (packageName != null && defaults.isPackageExcluded(packageName)) {
      return false;
    }

    // Check default inclusions
    if (packageName != null && defaults.isPackageIncluded(packageName)) {
      return true;
    }
    if (defaults.hasIncludeAnnotation(element.metadata.annotations)) {
      return true;
    }

    // Apply filters in order
    for (final filter in filters) {
      if (filter.matches(element)) {
        return filter.isInclude;
      }
    }

    // No filter matched - use default reachability
    return null;
  }

  String? _getPackageName(Element element) {
    final uri = element.library?.firstFragment.source.uri;
    if (uri == null) return null;
    if (uri.scheme == 'package') {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }
    if (uri.scheme == 'dart') {
      return 'dart:${uri.path}';
    }
    return null;
  }
}
