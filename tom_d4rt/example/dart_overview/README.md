# Dart Language Overview

A comprehensive collection of Dart language feature demonstrations, used for testing the `tom_analyzer` code analysis and reflection generation tools.

## Purpose

This package demonstrates all major Dart language features:

1. Variables - declarations, types, null safety, constants
2. Operators - arithmetic, comparison, logical, bitwise
3. Control Flow - conditionals, switch, loops
4. Functions - declarations, parameters, closures, generators
5. Classes - declarations, constructors, inheritance
6. Class Modifiers - abstract, sealed, interface, mixin
7. Generics - generic classes, functions, bounds, variance
8. Collections - lists, sets, maps, iterables
9. Records - anonymous aggregate data structures
10. Patterns - destructuring, matching, switch patterns
11. Enums - simple and enhanced enumerations
12. Mixins - code reuse through mixins
13. Extensions - adding functionality to existing types
14. Async - futures, streams, isolates
15. Error Handling - try/catch, exceptions, stack traces
16. Libraries - imports, exports, visibility
17. Comments - documentation and code comments
18. Typedefs - type aliases for functions and types
19. Annotations - metadata annotations, built-in and custom
20. Globals - top-level variables, functions, getters/setters

## Running

```bash
dart run lib/run_dart_overview.dart
```

## Usage with tom_analyzer

### Analysis
```bash
dart run tom_analyzer analyze --barrel dart_overview/lib/run_dart_overview.dart --format yaml
```

### Reflection Generation
```bash
dart run tom_analyzer reflect --barrel dart_overview/lib/run_dart_overview.dart --output dart_overview.r.dart
```
