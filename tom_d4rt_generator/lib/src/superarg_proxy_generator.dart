/// D4rt super-constructor-argument capture emitter (`superArgDefaults`).
///
/// Some bridged base classes have **required** super-constructor parameters
/// (`BoxScrollView.scrollDirection`, `TwoDimensionalViewport.delegate`,
/// `RenderTwoDimensionalViewport.childManager`, …). The bridge generator
/// strips the abstract constructor, so when a script declares
/// `class _MyScroll extends BoxScrollView { _MyScroll() : super(...); }` the
/// `super(...)` call has nowhere to land natively. The fix is a native proxy
/// whose static `create(visitor, instance)` factory re-reads each captured
/// `super(...)` named arg off the [InterpretedInstance]
/// (`_readSuperArg<T>(instance, 'name', visitor)`) and forwards it to the real
/// native super-constructor, falling back to a sane default for any required
/// formal the script omitted.
///
/// These `create()` factories were previously hand-written near-verbatim — one
/// `_readSuperArg<T>(...) ?? default` line per super-formal — in each twin's
/// `d4rt_runtime_registrations.dart` (`_InterpretedBoxScrollView`,
/// `_InterpretedTwoDimensionalScrollView`, `_InterpretedTwoDimensionalViewport`,
/// `_InterpretedRenderTwoDimensionalViewport`). This emitter replaces that
/// boilerplate: the per-proxy pieces are just the analyzer-derived super-formal
/// list (name + type + required-ness) and the human-supplied
/// [ProxyClassConfig.superArgDefaults] for the required formals.
///
/// The emitter produces a **canonical** form (the golden pins that contract;
/// the regen-time base-test gate validates behavioural equivalence with the
/// hand code, whose only differences are cosmetic dartfmt wrap drift and a
/// per-proxy `StateError` message). What it does **not** emit is the bespoke
/// override-hook body each proxy forwards back into the interpreter
/// (`buildViewport` / `buildChildLayout` / `createRenderObject` /
/// `layoutChildSequence`) — those are not derivable from the annotation and
/// stay hand-written for now.
library;

/// One super-constructor formal a capture-factory forwards.
///
/// In the real generator pipeline [name], [type] and [isRequired] are read off
/// the bridged super-class's constructor via the analyzer; [defaultExpr] is
/// supplied by [ProxyClassConfig.superArgDefaults] (or the param's own default
/// where present). The `key` formal is special-cased by the emitter — it always
/// falls back to `_readKey(instance, visitor)` rather than a config default.
class SuperArgFormal {
  /// The super-formal's name (e.g. `scrollDirection`).
  final String name;

  /// The super-formal's native type (e.g. `Axis`). Used as the `_readSuperArg`
  /// type argument and, for required formals, the local variable's inferred
  /// type.
  final String type;

  /// Whether the native super-constructor *requires* this formal. Required
  /// formals without a [defaultExpr] are read into a local and null-checked in
  /// a preamble that throws a `StateError` naming the missing args.
  final bool isRequired;

  /// The fallback expression appended as `?? defaultExpr` when the script did
  /// not pass this arg to `super(...)`. `null` means no fallback (the captured
  /// value, possibly null, is forwarded as-is — valid for optional formals).
  final String? defaultExpr;

  const SuperArgFormal({
    required this.name,
    required this.type,
    this.isRequired = false,
    this.defaultExpr,
  });

  /// A required formal that has no usable default — it is read into a local and
  /// participates in the null-check preamble.
  bool get needsValidation => isRequired && defaultExpr == null && name != 'key';

  SuperArgFormal copyWith({String? defaultExpr}) => SuperArgFormal(
        name: name,
        type: type,
        isRequired: isRequired,
        defaultExpr: defaultExpr ?? this.defaultExpr,
      );
}

/// Fill each formal's [SuperArgFormal.defaultExpr] from [superArgDefaults]
/// (keyed by formal name) where the formal does not already carry one.
///
/// This is how [ProxyClassConfig.superArgDefaults] (the only human input) is
/// merged onto the analyzer-derived formal list before emission. A formal that
/// already has a default (e.g. from the param's own default value) keeps it.
List<SuperArgFormal> applySuperArgDefaults(
  List<SuperArgFormal> formals,
  Map<String, String> superArgDefaults,
) {
  return [
    for (final f in formals)
      if (f.defaultExpr == null && superArgDefaults.containsKey(f.name))
        f.copyWith(defaultExpr: superArgDefaults[f.name])
      else
        f,
  ];
}

/// Emits the shared `_readSuperArg<T>` helper every capture-factory calls.
///
/// Reads a captured `super(...)` named arg off the [InterpretedInstance] and
/// unwraps it to a native `T`; returns `null` when the script did not pass the
/// arg (so the caller's `?? default` applies) or when the captured value cannot
/// be coerced — which is why script-supplied args always win over defaults.
String generateReadSuperArgHelper() {
  final b = StringBuffer();
  b.writeln('/// Read a captured `super(...)` named arg and unwrap it to a native [T].');
  b.writeln('///');
  b.writeln('/// Returns `null` when the script did not pass `name` to `super(...)` (so the');
  b.writeln('/// caller can fall back to a default) or when the captured value cannot be');
  b.writeln("/// coerced to [T]. Script-supplied args therefore always win over the proxy's");
  b.writeln('/// defaults. Generated by the d4rtgen proxy generator (superArgDefaults).');
  b.writeln('T? _readSuperArg<T>(');
  b.writeln('  InterpretedInstance instance,');
  b.writeln('  String name, [');
  b.writeln('  InterpreterVisitor? visitor,');
  b.writeln(']) {');
  b.writeln('  final raw = instance.superCallNamedArgs?[name];');
  b.writeln('  if (raw == null) return null;');
  b.writeln('  try {');
  b.writeln('    return D4.extractBridgedArgOrNull<T>(raw, name, visitor);');
  b.writeln('  } catch (_) {');
  b.writeln('    return null;');
  b.writeln('  }');
  b.writeln('}');
  return b.toString();
}

/// Emits one named-arg entry for the proxy constructor call.
///
/// - The `key` formal is special-cased: `?? _readKey(instance, visitor)`.
/// - A [SuperArgFormal.needsValidation] formal forwards its preamble local
///   (`name: name`) — see [generateSuperArgCaptureFactory].
/// - Otherwise: `name: _readSuperArg<Type>(instance, 'name', visitor)` with a
///   trailing `?? defaultExpr` when a default is present.
String generateSuperArgEntry(SuperArgFormal formal) {
  final n = formal.name;
  if (n == 'key') {
    return "key: _readSuperArg<Key>(instance, 'key', visitor) ?? "
        '_readKey(instance, visitor),';
  }
  if (formal.needsValidation) {
    return '$n: $n,';
  }
  final read = "_readSuperArg<${formal.type}>(instance, '$n', visitor)";
  if (formal.defaultExpr != null) {
    return '$n: $read ?? ${formal.defaultExpr},';
  }
  return '$n: $read,';
}

/// Emits the static `create(visitor, instance)` super-arg-capture factory for a
/// proxy backing interpreted subclasses of [baseClassName].
///
/// The proxy class name is `_Interpreted$baseClassName` (matching the existing
/// hand-written proxies). Required formals without a default are read into
/// locals first and null-checked in a `StateError` preamble; every other formal
/// is forwarded inline. The factory ends with the canonical
/// `instance.nativeProxy ??= proxy; return proxy;` tail.
String generateSuperArgCaptureFactory({
  required String baseClassName,
  required List<SuperArgFormal> formals,
}) {
  final proxyName = '_Interpreted$baseClassName';
  final validated = formals.where((f) => f.needsValidation).toList();
  final b = StringBuffer();
  b.writeln('  static $proxyName create(');
  b.writeln('    InterpreterVisitor visitor,');
  b.writeln('    InterpretedInstance instance,');
  b.writeln('  ) {');
  for (final f in validated) {
    b.writeln(
        "    final ${f.name} = _readSuperArg<${f.type}>(instance, '${f.name}', visitor);");
  }
  if (validated.isNotEmpty) {
    final nullChecks = validated.map((f) => '${f.name} == null').join(' || ');
    final names = validated.map((f) => f.name).join(', ');
    b.writeln('    if ($nullChecks) {');
    b.writeln('      throw StateError(');
    b.writeln("        'Interpreted \${instance.klass.name} ($baseClassName subclass) '");
    b.writeln("        'did not pass all required super-args ($names).',");
    b.writeln('      );');
    b.writeln('    }');
  }
  b.writeln('    final proxy = $proxyName._(');
  b.writeln('      visitor,');
  b.writeln('      instance,');
  for (final f in formals) {
    b.writeln('      ${generateSuperArgEntry(f)}');
  }
  b.writeln('    );');
  b.writeln('    instance.nativeProxy ??= proxy;');
  b.writeln('    return proxy;');
  b.writeln('  }');
  return b.toString();
}
