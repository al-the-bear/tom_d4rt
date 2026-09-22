/// SCD95 — a REPORT-ONLY static pass that finds names a program reads and
/// nothing defines.
///
/// **It reports; it never throws, and nothing in `execute()` calls it.** That
/// is the whole risk-management strategy of the todo that produced it, and it
/// is deliberate rather than unfinished. Real Dart rejects an undefined name at
/// compile time, so the program never runs at all; d4rt runs everything up to
/// the bad line first, and a script that writes a file on line 3 and mistypes a
/// name on line 9 has already written the file. Closing that gap means adding a
/// pass that can REFUSE to run a program — and a resolver that is wrong in the
/// aggressive direction rejects working scripts, which is far worse than the
/// bug it fixes. So the pass is built report-only, swept over corpora of
/// programs known to work, and only allowed to fail anything once that sweep is
/// clean. See `scd95_static_name_report_test.dart` for the measurement.
///
/// WHAT IT CANNOT SEE, and therefore never reports
///
/// The resolver is syntactic. It is handed the names the host registered
/// ([knownGlobals]) because bridged classes, enums, globals and typedefs are
/// known only at execute time, not at parse time. Everything else it cannot
/// prove it treats as defined:
///
///   - **Anything after a `.`** — a property, a method name with a target, the
///     right half of a prefixed identifier. Resolving those needs the
///     receiver's type, which an unresolved AST does not carry, and a `dynamic`
///     receiver makes the name legitimately unknowable until runtime.
///   - **Any name inside a class whose supertype chain leaves the unit** — a
///     class extending a bridged type inherits members this pass cannot
///     enumerate, so implicit-`this` reads inside it are all waved through.
///     [openClasses] records which classes were skipped for this reason.
///   - **Extension members**, which are discovered by applicability at the call
///     site rather than by scope. A class some extension in the unit targets is
///     therefore open too, and an extension on `Object` or `dynamic` opens
///     every class.
///   - **Imported names**, whose module graph `ModuleLoader` resolves lazily.
///     The CALLER decides which imports it has names for and passes
///     [hasUnresolvedImports] for a unit importing anything else, which
///     suppresses that unit entirely rather than producing a page of false
///     hits. Suppressing on the mere PRESENCE of an import would be worse than
///     useless: it reports nothing, looks clean, and has checked nothing.
///   - **Type positions.** A `NamedType` resolves through a different path
///     (bridge registry, then environment), and a type that fails to resolve is
///     already diagnosed at its use site.
///
/// Every one of those is a deliberate FALSE NEGATIVE. The pass exists to be
/// trusted when it does speak, which means it must stay silent whenever it
/// might be wrong — the SCC31 runtime guard remains the backstop for everything
/// listed above, and would remain so even after this pass starts enforcing.
library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// One name the program reads that this pass could not find a definition for.
class UnresolvedName {
  UnresolvedName(this.name, this.offset, {required this.enclosing});

  /// The identifier as written.
  final String name;

  /// Character offset of the use in the compilation unit.
  final int offset;

  /// The declaration the use sits in, for a legible report.
  final String enclosing;

  @override
  String toString() => '$name (at $offset, in $enclosing)';
}

/// The result of one sweep.
class NameReport {
  NameReport(this.unresolved, this.openClasses, {required this.suppressed});

  final List<UnresolvedName> unresolved;

  /// Classes whose supertype chain left the unit, so implicit-`this` reads
  /// inside them were not checked. Counted so a sweep that reports nothing
  /// because it checked nothing is distinguishable from a clean one.
  final Set<String> openClasses;

  /// True when the whole unit was waved through — an import the caller did not
  /// account for. A suppressed report is not a clean one.
  final bool suppressed;

  bool get isClean => unresolved.isEmpty;
}

/// Report the names [unit] reads that neither the unit nor [knownGlobals]
/// defines.
///
/// [knownGlobals] is the host's registration set plus whatever `dart:core`
/// supplies — the caller owns assembling it, because only the caller knows
/// which bridges were registered before `execute()`.
NameReport reportUnresolvedNames(
  CompilationUnit unit,
  Set<String> knownGlobals, {
  bool hasUnresolvedImports = false,
}) {
  if (hasUnresolvedImports) {
    return NameReport(const [], const {}, suppressed: true);
  }
  final visitor = _NameReportVisitor(knownGlobals);
  visitor.collectTopLevel(unit);
  // An `import ... as p` puts `p` in scope as a name in its own right.
  for (final directive in unit.directives.whereType<ImportDirective>()) {
    final prefix = directive.prefix?.name;
    if (prefix != null) visitor.declareTopLevel(prefix);
  }
  unit.visitChildren(visitor);
  return NameReport(visitor.unresolved, visitor.openClasses, suppressed: false);
}

class _NameReportVisitor extends GeneralizingAstVisitor<void> {
  _NameReportVisitor(this._knownGlobals);

  final Set<String> _knownGlobals;
  final List<Set<String>> _scopes = [];

  /// Types some extension in this unit adds members to. A class in this set is
  /// OPEN: an implicit-`this` read inside it can resolve to an extension member
  /// that no class body declares.
  final _extendedTypes = <String>{};

  /// True when an extension targets `Object`, `dynamic` or a type parameter,
  /// which reaches every class — so every class body is open.
  bool _extensionOnEverything = false;
  final unresolved = <UnresolvedName>[];
  final openClasses = <String>{};

  /// Nesting depth of class bodies whose members this pass cannot enumerate.
  /// Every read inside one is waved through.
  int _openClassDepth = 0;

  String _enclosing = '<unit>';

  void collectTopLevel(CompilationUnit unit) {
    final top = <String>{};
    for (final d in unit.declarations) {
      switch (d) {
        case NamedCompilationUnitMember():
          top.add(d.name.lexeme);
        case TopLevelVariableDeclaration():
          for (final v in d.variables.variables) {
            top.add(v.name.lexeme);
          }
        default:
          break;
      }
    }
    _scopes.add(top);

    // An extension can add members to a class the unit also declares, and
    // applicability is decided at the CALL SITE rather than by scope. So a
    // class an extension targets has to be treated as open, exactly like one
    // whose supertype leaves the unit — `extension BoxX on Box { int get
    // tripled => v * 3; }` makes the bare `tripled` inside `Box` resolvable
    // by a route no class body mentions.
    for (final d in unit.declarations.whereType<ExtensionDeclaration>()) {
      final onType = d.onClause?.extendedType;
      final name = onType is NamedType ? onType.name.lexeme : null;
      if (name == null || name == 'Object' || name == 'dynamic') {
        _extensionOnEverything = true;
      } else {
        _extendedTypes.add(name);
      }
    }
  }

  /// Add [name] to the unit-level scope. Used for import prefixes, which are
  /// names the program can read but no declaration in the unit introduces.
  void declareTopLevel(String name) => _scopes.first.add(name);

  void _push([Iterable<String> names = const []]) => _scopes.add({...names});

  void _pop() => _scopes.removeLast();

  bool _isKnown(String name) {
    if (_knownGlobals.contains(name)) return true;
    for (final scope in _scopes) {
      if (scope.contains(name)) return true;
    }
    return false;
  }

  void _declare(String name) {
    if (_scopes.isEmpty) return;
    _scopes.last.add(name);
  }

  Iterable<String> _paramNames(FormalParameterList? params) sync* {
    if (params == null) return;
    for (final p in params.parameters) {
      final name = p.name?.lexeme;
      if (name != null) yield name;
    }
  }

  Iterable<String> _typeParamNames(TypeParameterList? tps) sync* {
    if (tps == null) return;
    for (final tp in tps.typeParameters) {
      yield tp.name.lexeme;
    }
  }

  // --- declarations that open a scope -------------------------------------

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // A class whose supertype chain leaves this unit inherits members this
    // pass cannot enumerate. Rather than guess, every read inside it is waved
    // through — and the class is recorded so a sweep that reports nothing
    // because it checked nothing is not mistaken for a clean one.
    final leavesUnit =
        node.extendsClause != null ||
        node.withClause != null ||
        node.implementsClause != null ||
        _extensionOnEverything ||
        _extendedTypes.contains(node.name.lexeme);
    if (leavesUnit) openClasses.add(node.name.lexeme);
    final members = <String>{
      ..._typeParamNames(node.typeParameters),
      for (final m in node.members)
        ...switch (m) {
          MethodDeclaration() => [m.name.lexeme],
          FieldDeclaration() => [
            for (final v in m.fields.variables) v.name.lexeme,
          ],
          ConstructorDeclaration() => [if (m.name != null) m.name!.lexeme],
          _ => const <String>[],
        },
      'this',
      'super',
    };
    final savedEnclosing = _enclosing;
    _enclosing = node.name.lexeme;
    if (leavesUnit) _openClassDepth++;
    _push(members);
    node.visitChildren(this);
    _pop();
    if (leavesUnit) _openClassDepth--;
    _enclosing = savedEnclosing;
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    // A mixin is applied to a class this pass cannot see, so `this` inside it
    // can reach anything. Always open.
    openClasses.add(node.name.lexeme);
    _openClassDepth++;
    _push({..._typeParamNames(node.typeParameters), 'this', 'super'});
    node.visitChildren(this);
    _pop();
    _openClassDepth--;
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    // Extension members resolve by applicability at the call site, not by
    // scope. Out of this pass's reach by construction.
    openClasses.add(node.name?.lexeme ?? '<unnamed extension>');
    _openClassDepth++;
    _push({'this'});
    node.visitChildren(this);
    _pop();
    _openClassDepth--;
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    // SCE128. An extension type declares its REPRESENTATION as a name its
    // members read bare — `int get doubled => value * 2` — and nothing here
    // recorded it, so every such read was reported. It also `implements`
    // types that can leave the unit, which is the same openness a class has.
    openClasses.add(node.name.lexeme);
    _openClassDepth++;
    _push({
      ..._typeParamNames(node.typeParameters),
      node.representation.fieldName.lexeme,
      for (final m in node.members)
        if (m is MethodDeclaration) m.name.lexeme,
      'this',
    });
    node.visitChildren(this);
    _pop();
    _openClassDepth--;
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    openClasses.add(node.name.lexeme);
    _openClassDepth++;
    _push({
      ..._typeParamNames(node.typeParameters),
      for (final c in node.constants) c.name.lexeme,
      for (final m in node.members)
        if (m is MethodDeclaration) m.name.lexeme,
      'this',
      'values',
      'index',
    });
    node.visitChildren(this);
    _pop();
    _openClassDepth--;
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final saved = _enclosing;
    _enclosing = node.name.lexeme;
    _push({
      ..._typeParamNames(node.functionExpression.typeParameters),
      ..._paramNames(node.functionExpression.parameters),
    });
    node.visitChildren(this);
    _pop();
    _enclosing = saved;
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final saved = _enclosing;
    _enclosing = '$_enclosing.${node.name.lexeme}';
    _push({
      ..._typeParamNames(node.typeParameters),
      ..._paramNames(node.parameters),
    });
    node.visitChildren(this);
    _pop();
    _enclosing = saved;
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _push(_paramNames(node.parameters));
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    // Reached for closures; a FunctionDeclaration's own expression already
    // pushed its scope above, and a second push is harmless.
    _push({
      ..._typeParamNames(node.typeParameters),
      ..._paramNames(node.parameters),
    });
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitBlock(Block node) {
    // Dart forbids reading a local before its declaration in the same block,
    // so collecting the whole block up front is conservative in the safe
    // direction: it can only ever suppress a report, never invent one.
    _push(_localsOf(node));
    node.visitChildren(this);
    _pop();
  }

  Iterable<String> _localsOf(Block block) sync* {
    for (final s in block.statements) {
      if (s is VariableDeclarationStatement) {
        for (final v in s.variables.variables) {
          yield v.name.lexeme;
        }
      } else if (s is FunctionDeclarationStatement) {
        yield s.functionDeclaration.name.lexeme;
      } else if (s is PatternVariableDeclarationStatement) {
        yield* _patternNames(s.declaration.pattern);
      }
    }
  }

  Iterable<String> _patternNames(DartPattern pattern) sync* {
    if (pattern is DeclaredVariablePattern) {
      yield pattern.name.lexeme;
    }
    for (final child in pattern.childEntities) {
      if (child is DartPattern) yield* _patternNames(child);
      if (child is AstNode) {
        for (final c in child.childEntities) {
          if (c is DartPattern) yield* _patternNames(c);
        }
      }
    }
  }

  @override
  void visitForStatement(ForStatement node) {
    _push(_forLoopNames(node.forLoopParts));
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitForElement(ForElement node) {
    _push(_forLoopNames(node.forLoopParts));
    node.visitChildren(this);
    _pop();
  }

  Iterable<String> _forLoopNames(ForLoopParts parts) sync* {
    switch (parts) {
      case ForPartsWithDeclarations():
        for (final v in parts.variables.variables) {
          yield v.name.lexeme;
        }
      case ForEachPartsWithDeclaration():
        yield parts.loopVariable.name.lexeme;
      case ForEachPartsWithPattern():
        yield* _patternNames(parts.pattern);
      case ForPartsWithPattern():
        yield* _patternNames(parts.variables.pattern);
      default:
        break;
    }
  }

  @override
  void visitCatchClause(CatchClause node) {
    _push([
      if (node.exceptionParameter != null) node.exceptionParameter!.name.lexeme,
      if (node.stackTraceParameter != null)
        node.stackTraceParameter!.name.lexeme,
    ]);
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitSwitchPatternCase(SwitchPatternCase node) {
    _push(_patternNames(node.guardedPattern.pattern));
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitSwitchExpressionCase(SwitchExpressionCase node) {
    // The expression form of a switch binds pattern variables exactly as the
    // statement form does. Handling only `SwitchPatternCase` made every
    // `switch (s) { Circle(:var radius) => radius * radius }` report its own
    // bound names as undefined.
    _push(_patternNames(node.guardedPattern.pattern));
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitIfStatement(IfStatement node) {
    final pattern = node.caseClause?.guardedPattern.pattern;
    _push(pattern == null ? const <String>[] : _patternNames(pattern));
    node.visitChildren(this);
    _pop();
  }

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    for (final v in node.variables.variables) {
      _declare(v.name.lexeme);
    }
    node.visitChildren(this);
  }

  // --- the check ----------------------------------------------------------

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (_openClassDepth > 0) return;
    if (!_isReadPosition(node)) return;
    final name = node.name;
    if (name.isEmpty || name == '_') return;
    if (_isKnown(name)) return;
    unresolved.add(UnresolvedName(name, node.offset, enclosing: _enclosing));
  }

  /// Whether [node] is a bare name the program READS — as opposed to a name it
  /// declares, a label, a named-argument tag, or anything that hangs off a `.`
  /// and therefore resolves against a receiver this pass cannot type.
  bool _isReadPosition(SimpleIdentifier node) {
    if (node.inDeclarationContext()) return false;
    final parent = node.parent;
    switch (parent) {
      // Anything to the right of a `.`.
      case PropertyAccess(:final propertyName)
          when identical(propertyName, node):
        return false;
      case PrefixedIdentifier(:final identifier)
          when identical(identifier, node):
        return false;
      // A method name is a read only when it is a bare call. `x.f()` has a
      // target; `x..f()` has none in the AST but is a CASCADE section, whose
      // receiver is the cascade's own target — reading `isCascaded` is the
      // only way to tell the two apart, and missing it made `..moveTo(0, 0)`
      // report `moveTo` as undefined across the corpus.
      case MethodInvocation(:final methodName)
          when identical(methodName, node) &&
              (parent.target != null || parent.isCascaded):
        return false;
      case PropertyAccess() when parent.isCascaded:
        return false;
      // Names that are tags rather than reads.
      //
      // SCE128 added the first two. A label DECLARATION is a `Label` node and
      // was already excluded; a label REFERENCE — the `outer` in
      // `break outer;` — is a bare `SimpleIdentifier` whose parent is the
      // break or continue, so it read as an undefined name. It was the single
      // most frequent false positive when the pass was first enforced.
      case BreakStatement():
      case ContinueStatement():
      case Label():
      case ConstructorName():
      case ConstructorDeclaration():
      case ConstructorFieldInitializer():
      case ShowCombinator():
      case HideCombinator():
      case ImportDirective():
      case ExportDirective():
      case PartDirective():
      case LibraryIdentifier():
      case EnumConstantDeclaration():
      case DeclaredIdentifier():
      case NamedType():
      case TypeParameter():
      case Annotation():
      case FieldFormalParameter():
      case SuperFormalParameter():
      case PatternField():
      case PatternFieldName():
      case RepresentationDeclaration():
        return false;
      // `super.x` and `this.x` targets are handled by the class scope.
      case PropertyAccess(:final target) when identical(target, node):
        return true;
      default:
        return true;
    }
  }
}
