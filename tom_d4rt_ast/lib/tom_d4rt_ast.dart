/// The serializable mirror AST, and nothing else.
///
/// This barrel is a pass-through: it re-exports `package:tom_ast_model/ast.dart`
/// and adds no surface of its own. Importing it gives you the `S*` node types —
/// `SAstNode` and its subtypes — with no interpreter attached.
///
/// **For the runtime, import `package:tom_d4rt_ast/d4rt.dart`** (or
/// `runtime.dart`, which it re-exports). That is where the interpreter,
/// `Environment`, the bridge infrastructure and the standard library live, and
/// it is what generated bridge packages and `FlutterD4rt` import.
///
/// Note the asymmetry with the analyzer line, because it is a migration trap:
/// `package:tom_d4rt/tom_d4rt.dart` DOES carry the runtime (it re-exports that
/// package's `d4rt.dart`). Porting a file to the analyzer-free line by
/// swapping only the package name therefore lands you here, on the model
/// alone, and the first symptom is an unresolved interpreter type. Swap the
/// library too: `tom_d4rt/tom_d4rt.dart` -> `tom_d4rt_ast/d4rt.dart`.
///
/// The narrowness is deliberate and load-bearing — do not "fix" a missing
/// identifier here by widening this export. Consumers depend on being able to
/// take the node types alone: `tom_reflector`'s dependency was satisfiable by
/// the model precisely because this barrel does not drag the runtime in, and
/// widening it would pull an interpreter into packages that wanted a data
/// model. An earlier docstring claimed this barrel "adds the D4rt runtime",
/// which sent readers looking for an interpreter that was never exported here.
library;

export 'ast.dart';
