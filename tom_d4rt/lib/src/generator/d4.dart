/// D4 Bridge Helpers
///
/// Static helper methods for D4rt-generated bridge code.
///
/// NOTE: This is work in progress - API may change.
library;

import 'dart:typed_data';

import '../bridge/bridged_types.dart';
import '../bridge/bridged_enum.dart';
import '../bridge/registration.dart'
    show BridgedMethodAdapter, BridgedStaticMethodAdapter;
import '../callable.dart';
import '../exceptions.dart';
import '../interpreter_visitor.dart';
import '../runtime_interfaces.dart';
import '../runtime_types.dart';

/// GEN-079: Factory callback for creating typed wrappers.
///
/// Takes the raw unwrapped value and the inner type argument string
/// (e.g., 'Color?' for `WidgetStateProperty<Color?>`).
/// Returns a properly typed wrapper, or null if the type arg is not supported.
typedef GenericTypeWrapperFactory = Object? Function(
    Object value, String innerTypeArg);

/// RC-1: Factory for creating native proxy objects that delegate method calls
/// back to an [InterpretedInstance].
///
/// When a D4rt script class implements or extends a bridged abstract class
/// or interface (e.g., `class MyClipper extends CustomClipper<Path>`),
/// the resulting [InterpretedInstance] cannot be used directly as the native
/// type. An interface proxy wraps it in a native object that delegates
/// method calls back to the interpreter.
///
/// The [visitor] is the current interpreter for dispatching callbacks.
/// The [instance] is the D4rt interpreted instance that provides the implementation.
typedef InterfaceProxyFactory = Object? Function(
    InterpreterVisitor visitor, InterpretedInstance instance);

/// RC-3: Factory for converting one type to another when they represent
/// the same concept but live in different packages.
///
/// Example: `painting.TextStyle` → `dart:ui.TextStyle` via `getTextStyle()`.
typedef TypeCoercionFactory = Object? Function(Object value);

/// RC-2: Factory for constructing generic bridged classes with type arguments.
///
/// When a D4rt script calls `GlobalKey<NavigatorState>()`, the type argument
/// is evaluated at runtime but Dart requires compile-time generic types.
/// This factory receives the evaluated [RuntimeType] list and dispatches to
/// the correct statically-typed constructor.
///
/// The [visitor] is the current interpreter context.
/// [positionalArgs] and [namedArgs] are the converted arguments.
/// [typeArguments] are the evaluated type arguments from the script,
/// or null when called without type arguments (constructor override).
typedef GenericConstructorFactory = Object? Function(
    InterpreterVisitor visitor,
    List<Object?> positionalArgs,
    Map<String, Object?> namedArgs,
    List<RuntimeType>? typeArguments);

/// D4 - Static helper class for D4rt bridge code generation.
///
/// All generated bridge code uses these static methods for:
/// - Type coercion (List/Map from D4rt runtime)
/// - Argument extraction (positional and named)
/// - Target validation (instance methods)
/// - Argument count validation
///
/// Example usage in generated bridge code:
/// ```dart
/// // Validate target for instance method
/// final t = D4.validateTarget<MyClass>(target, 'MyClass');
///
/// // Extract required positional argument
/// final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MyClass');
///
/// // Coerce D4rt list to typed list
/// final items = D4.coerceList<Item>(positional[0], 'items');
/// ```
class D4 {
  // Private constructor - all methods are static
  D4._();

  // ==========================================================================
  // Active Visitor (for interface proxy creation in bridge constructor helpers)
  // ==========================================================================

  /// The currently active [InterpreterVisitor] during bridge constructor/method
  /// execution. Set via [withActiveVisitor] before calling bridge adapters.
  ///
  /// This allows [extractBridgedArg] to access the visitor for interface proxy
  /// creation even when called indirectly via helper methods (getRequiredNamedArg
  /// etc.) that don't pass the visitor parameter.
  static InterpreterVisitor? _activeVisitor;

  /// Exposes the currently-active visitor to embedders that need to finish
  /// unwrapping an InterpretedInstance after `executeBundle` has returned
  /// (e.g. `FlutterD4rt._unwrap<Widget>` turning a script-returned StatelessWidget
  /// InterpretedInstance into a native proxy via the registered interface
  /// factories).
  static InterpreterVisitor? get activeVisitor => _activeVisitor;

  /// Execute [fn] with the given [visitor] as the active visitor.
  /// Restores the previous visitor when done (supports nesting).
  static T withActiveVisitor<T>(InterpreterVisitor visitor, T Function() fn) {
    final previous = _activeVisitor;
    _activeVisitor = visitor;
    try {
      return fn();
    } finally {
      _activeVisitor = previous;
    }
  }

  // ==========================================================================
  // GEN-079: Generic Type Wrapper Registration
  // ==========================================================================

  /// Registered wrapper factory lists keyed by base type name.
  ///
  /// Each base type name maps to a list of factories registered additively
  /// across modules. Factories are checked in registration order — the first
  /// factory that returns non-null wins.
  ///
  /// Example: 'ValueNotifier' → [foundationFactory, widgetsFactory, userFactory]
  static final Map<String, List<GenericTypeWrapperFactory>>
      _genericTypeWrappers = {};

  // ==========================================================================
  // 1401-TODO #7 (F9) — Native ↔ Interpreted reverse map
  // ==========================================================================

  /// Maps a native bridged-super object back to the [InterpretedInstance]
  /// that owns it. Populated by [extractBridgedArg] when an
  /// `InterpretedInstance.bridgedSuperObject` is returned to native code
  /// (e.g. `_invokeInterpretedAs<RenderObject>` returns the bridged super
  /// of a script's `_RenderMeasureBox` to the Flutter framework). The
  /// interpreter consults this map at property-assignment sites when the
  /// bridge has no matching setter, so script-defined fields on a concrete
  /// subclass (`_RenderMeasureBox.onLayout`) can still be reached after the
  /// framework has handed the native side back to script code.
  ///
  /// [Expando] is used so the map entries do not pin the native object
  /// against garbage collection. Each native object can have at most one
  /// associated InterpretedInstance (the last extracted one wins —
  /// extractBridgedArg is idempotent within one interpreter session, so
  /// re-extractions of the same arg overwrite with the same value).
  ///
  /// Non-`final` so [resetNativeAccumulators] can swap in a fresh [Expando]:
  /// although individual entries are weak, the framework (Flutter Elements /
  /// RenderObjects / animations) keeps the *native keys* alive across `/build`
  /// cycles, so the entries pinned by them survive too. That is the genuine
  /// cross-build accumulator identified in OPEN B.12 / §U28.
  static Expando<Object> _nativeToInterpreted =
      Expando<Object>('d4rt:nativeToInterpreted');

  /// Cumulative count of [registerInterpretedForNative] calls since the last
  /// [resetNativeAccumulators]. The [Expando] itself exposes no length, so
  /// this counter is the observable proxy for "how much native→interpreted
  /// state has built up" — it lets embedders and tests detect accumulation
  /// across `/build` cycles and verify a reset returns it to baseline.
  static int _nativeRegistrationCount = 0;

  /// Number of native→interpreted registrations recorded since the last
  /// [resetNativeAccumulators] (OPEN B.12 / §U28 instrumentation).
  static int get nativeRegistrationCount => _nativeRegistrationCount;

  /// Records that [nativeObject] is the bridged-super of [interpretedInstance].
  /// No-op for non-Object keys (Expandos require Object keys).
  static void registerInterpretedForNative(
    Object nativeObject,
    Object interpretedInstance,
  ) {
    _nativeToInterpreted[nativeObject] = interpretedInstance;
    _nativeRegistrationCount++;
  }

  /// Returns the [InterpretedInstance] previously registered for
  /// [nativeObject], or `null` if none. The return type is `Object?` to
  /// avoid a cross-module import of `InterpretedInstance` here; callers in
  /// the interpreter cast to `InterpretedInstance`.
  static Object? interpretedForNative(Object? nativeObject) {
    if (nativeObject == null) return null;
    return _nativeToInterpreted[nativeObject];
  }

  /// Clears the cross-build native-side accumulator (OPEN B.12 / §U28).
  ///
  /// Replaces the [_nativeToInterpreted] [Expando] with a fresh instance —
  /// the only way to bulk-drop its entries, since [Expando] exposes neither a
  /// `clear()` nor an iterator — and zeroes [nativeRegistrationCount]. Any
  /// native object previously mapped reads back as `null` afterwards.
  ///
  /// Wired into the runtime reset API (`D4rt.resetScriptDeclarations` here /
  /// `D4rtRunner.resetScriptDeclarations` on the AST twin) so an embedder's
  /// `/clear` actually frees the native→interpreted entries pinned by the
  /// previous build's framework objects, instead of leaking them until
  /// process recycle.
  ///
  /// NOTE: this state is **process-global** (static on [D4]), shared by every
  /// live interpreter. It does not touch the registration caches
  /// ([_interfaceProxies], [_genericConstructors], [_typeCoercions], …) — those
  /// are populated once at bridge finalization and must persist across builds.
  static void resetNativeAccumulators() {
    _nativeToInterpreted = Expando<Object>('d4rt:nativeToInterpreted');
    _nativeRegistrationCount = 0;
  }

  // ==========================================================================
  // RC-1: Interface Proxy Registration
  // ==========================================================================

  /// Registered interface proxy factories keyed by bridged class name.
  ///
  /// When [extractBridgedArg] encounters an [InterpretedInstance] whose class
  /// hierarchy includes a bridged interface/superclass, it looks up a proxy
  /// factory here to create a native object that delegates back to the interpreter.
  static final Map<String, InterfaceProxyFactory> _interfaceProxies = {};

  /// Register a proxy factory for a bridged interface or abstract class.
  ///
  /// The [bridgedTypeName] is the name of the bridged class/interface.
  /// The [factory] creates a native proxy that delegates to the InterpreterVisitor.
  ///
  /// **Idempotent:** Repeated calls with the same [bridgedTypeName] simply
  /// overwrite the previously registered factory — calling this twice (e.g.
  /// from a generated `registerProxyFactories()` that fires on every
  /// `FlutterD4rt` instance) is safe and well-defined.
  static void registerInterfaceProxy(
    String bridgedTypeName,
    InterfaceProxyFactory factory,
  ) {
    _interfaceProxies[bridgedTypeName] = factory;
  }

  /// Returns true when an interface-proxy factory has been registered for the
  /// bridged type [bridgedTypeName] (via [registerInterfaceProxy]).
  ///
  /// Used by the interpreter (`super(...)` resolution in callable.dart) to
  /// skip the missing-bridge-constructor error for abstract widget bases
  /// like `SingleChildRenderObjectWidget` / `LeafRenderObjectWidget`. See
  /// the matching tom_d4rt_ast helper for the full rationale.
  static bool hasInterfaceProxy(String bridgedTypeName) =>
      _interfaceProxies.containsKey(bridgedTypeName);

  /// Bridged-class names whose proxy `create()` reads the script's
  /// `super(...)` argument list off [InterpretedInstance.superCallNamedArgs]
  /// / [InterpretedInstance.superCallPositionalArgs]. See the matching
  /// tom_d4rt_ast helper for the full rationale.
  static final Set<String> _superArgCapturingProxies = <String>{};

  /// Mark [bridgedTypeName] as a proxy that needs `super(...)` args
  /// captured onto the [InterpretedInstance]. See [_superArgCapturingProxies].
  static void markProxyCapturesSuperArgs(String bridgedTypeName) {
    _superArgCapturingProxies.add(bridgedTypeName);
  }

  /// Returns true when the proxy registered for [bridgedTypeName] needs the
  /// script's `super(...)` argument list captured. See
  /// [_superArgCapturingProxies].
  static bool proxyCapturesSuperArgs(String bridgedTypeName) =>
      _superArgCapturingProxies.contains(bridgedTypeName);

  // ==========================================================================
  // RC-3: Type Coercion Registration
  // ==========================================================================

  /// Registered type coercion factories keyed by "SourceType->TargetType".
  ///
  /// When [extractBridgedArg<T>] receives a value that isn't T but has a
  /// registered coercion from its runtime type to T, it applies the coercion.
  static final Map<String, TypeCoercionFactory> _typeCoercions = {};

  /// Register a type coercion from one type to another.
  ///
  /// [sourceTypeName] is the runtime type name of the source (e.g., 'TextStyle').
  /// [targetTypeName] is the expected type name (e.g., 'TextStyle') — but in a
  /// different package. The key used is "sourceType->targetType" but since both
  /// may have the same name, we use the native [Type] objects.
  /// [sourceType] and [targetType] are the actual Dart [Type] objects.
  /// The [factory] converts the source to the target type.
  ///
  /// **Idempotent:** Repeated calls with the same `(sourceType, targetType)`
  /// pair overwrite the previously registered factory in both
  /// [_typeCoercions] and [_typeCoercionsByType] — safe to invoke twice
  /// when a process re-runs the generator's `registerRelaxers()` block.
  static void registerTypeCoercion({
    required Type sourceType,
    required Type targetType,
    required TypeCoercionFactory factory,
  }) {
    final key = '${sourceType.hashCode}->${targetType.hashCode}';
    _typeCoercions[key] = factory;
    // Also store by type objects for lookup
    _typeCoercionsByType[_TypePair(sourceType, targetType)] = factory;
  }

  static final Map<_TypePair, TypeCoercionFactory> _typeCoercionsByType = {};

  /// Per-base-type identity tracking for [registerGenericTypeWrapper] —
  /// keyed by the same [baseTypeName] used by [_genericTypeWrappers].
  /// Lets the registration call dedupe by factory identity so a second
  /// `registerRelaxers()` does not re-append the same factory.
  static final Map<String, Set<GenericTypeWrapperFactory>>
      _genericTypeWrapperIdentities = {};

  /// Register a wrapper factory for a generic base type (additive).
  ///
  /// Multiple factories can be registered for the same base type — each module
  /// contributes factory cases for its own types. Factories are checked in
  /// registration order during [extractBridgedArg] resolution; the first to
  /// return non-null wins.
  ///
  /// The [baseTypeName] is the unparameterized type name (e.g., 'WidgetStateProperty').
  /// The [factory] receives the raw value and the desired inner type argument string.
  ///
  /// **Idempotent:** If the same [factory] (compared by identity) has
  /// already been registered for [baseTypeName], the call is a no-op.
  /// Distinct factories for the same base type are still appended in
  /// registration order. This lets `registerRelaxers()` and similar
  /// generator-emitted blocks fire multiple times (e.g. on a second
  /// `FlutterD4rt` instance) without growing the per-key list.
  static void registerGenericTypeWrapper(
    String baseTypeName,
    GenericTypeWrapperFactory factory,
  ) {
    final identities =
        _genericTypeWrapperIdentities.putIfAbsent(baseTypeName, () => {});
    if (!identities.add(factory)) return;
    (_genericTypeWrappers[baseTypeName] ??= []).add(factory);
  }

  // ==========================================================================
  // RC-2: Generic Constructor Registration
  // ==========================================================================

  /// Registered generic constructor factories keyed by "ClassName.ctorName".
  ///
  /// When a bridged class constructor is called with type arguments
  /// (e.g., `GlobalKey<NavigatorState>()`), the interpreter checks this map
  /// first. If found, the factory handles the construction with proper
  /// generic type arguments. Otherwise, the regular constructor adapter runs.
  static final Map<String, GenericConstructorFactory> _genericConstructors = {};

  /// Per-key identity tracking for [registerGenericConstructor]. The
  /// chained-factory closure captures and grows on every call, which is
  /// the right behaviour for *distinct* factories layering on top of each
  /// other but the wrong behaviour for the *same* factory firing twice
  /// (e.g. when `registerRelaxers()` is invoked on every `FlutterD4rt`
  /// instance after the `_relaxersRegistered` guard is removed).
  /// We dedupe by factory identity, keyed by `'$className.$constructorName'`.
  static final Map<String, Set<GenericConstructorFactory>>
      _genericConstructorIdentities = {};

  /// Register a generic constructor factory for a bridged class.
  ///
  /// [className] - The bridged class name (e.g., 'GlobalKey').
  /// [constructorName] - The constructor name ('' for default, 'named' for named).
  /// [factory] - Creates the native object using the provided type arguments.
  ///
  /// **Chaining:** If a factory is already registered for the same key, the
  /// new factory runs first. If it returns `null` (unhandled type), the
  /// previously-registered factory runs as fallback. This enables downstream
  /// packages to extend type dispatches without knowledge of upstream types.
  ///
  /// **Idempotent:** If the same [factory] (by identity) is already
  /// registered for `$className.$constructorName`, the call is a no-op —
  /// no extra chaining, no duplicate dispatch. Distinct factories for the
  /// same key still chain as documented above.
  static void registerGenericConstructor(
    String className,
    String constructorName,
    GenericConstructorFactory factory,
  ) {
    final key = '$className.$constructorName';
    final identities =
        _genericConstructorIdentities.putIfAbsent(key, () => {});
    if (!identities.add(factory)) return;
    final existing = _genericConstructors[key];
    if (existing != null) {
      // Chain: try new factory first, fall back to existing
      _genericConstructors[key] =
          (visitor, positionalArgs, namedArgs, typeArgs) {
        final result = factory(visitor, positionalArgs, namedArgs, typeArgs);
        if (result != null) return result;
        return existing(visitor, positionalArgs, namedArgs, typeArgs);
      };
    } else {
      _genericConstructors[key] = factory;
    }
  }

  /// Look up a registered generic constructor factory.
  ///
  /// Returns null if no generic constructor is registered for this class/ctor.
  static GenericConstructorFactory? findGenericConstructor(
    String className,
    String constructorName,
  ) {
    return _genericConstructors['$className.$constructorName'];
  }

  // ==========================================================================
  // Usage logging + miss-tracking (P&R#1 / request h)
  // ==========================================================================

  /// Opt-in instrumentation toggle. When `true`, [extractBridgedArg] and the
  /// interpreter's generic-constructor path record each relaxer /
  /// interface-proxy / type-coercion / generic-constructor *hit* and each
  /// unresolved *miss*, keyed by category + base type + type-argument. The
  /// accumulated data drives the mass-generation reduction work (P&R steps
  /// 4–5): it reveals which generated cases real scripts actually exercise.
  ///
  /// Defaults to `false`. Every instrumentation call site guards on this flag
  /// *before* composing any log key, so the log is completely silent and
  /// zero-overhead when disabled.
  ///
  /// Web note: this flag is purely programmatic here (no `dart:io`). The VM
  /// `D4rt` facade additionally defaults it from the `D4RT_LOG_RELAXER_USAGE`
  /// environment variable; the web-capable `tom_d4rt_ast` twin cannot read
  /// environment variables, so callers enable it directly. This is the only
  /// deliberate twin divergence for this feature.
  static bool usageLogEnabled = false;

  static final Map<String, int> _usageHits = <String, int>{};
  static final Map<String, int> _usageMisses = <String, int>{};

  static String _usageKey(String category, String base, String typeArg) =>
      '$category|$base|$typeArg';

  /// Parse the base type name from a type string, e.g. `List<int>?` → `List`,
  /// `Color` → `Color`. Used to key usage records by base type.
  static String _baseTypeName(String typeStr) {
    var s = typeStr;
    while (s.endsWith('?')) {
      s = s.substring(0, s.length - 1);
    }
    final lt = s.indexOf('<');
    return lt < 0 ? s : s.substring(0, lt);
  }

  /// Parse the inner type-argument from a generic type string, e.g.
  /// `List<int>` → `int`; returns `` (empty) for a non-generic type.
  static String _innerTypeArg(String typeStr) {
    var s = typeStr;
    while (s.endsWith('?')) {
      s = s.substring(0, s.length - 1);
    }
    final lt = s.indexOf('<');
    final gt = s.lastIndexOf('>');
    return (lt < 0 || gt < 0 || gt <= lt) ? '' : s.substring(lt + 1, gt);
  }

  /// Record a successful resolution of [category] (`relaxer`, `proxy`,
  /// `coercion`, or `ctor`) for [base] with [typeArg]. No-op unless
  /// [usageLogEnabled]; call sites still guard the flag to avoid key allocation
  /// when logging is off.
  static void recordUsageHit(String category, String base, String typeArg) {
    if (!usageLogEnabled) return;
    final key = _usageKey(category, base, typeArg);
    _usageHits[key] = (_usageHits[key] ?? 0) + 1;
  }

  /// Record an unresolved [extractBridgedArg] miss for [base]/[typeArg].
  static void recordUsageMiss(String base, String typeArg) {
    if (!usageLogEnabled) return;
    final key = _usageKey('miss', base, typeArg);
    _usageMisses[key] = (_usageMisses[key] ?? 0) + 1;
  }

  /// Hits accumulated so far, keyed `category|base|typeArg`. Read-only copy.
  static Map<String, int> get usageHits =>
      Map<String, int>.unmodifiable(_usageHits);

  /// Misses accumulated so far, keyed `miss|base|typeArg`. Read-only copy.
  static Map<String, int> get usageMisses =>
      Map<String, int>.unmodifiable(_usageMisses);

  /// Total hit events recorded across all categories.
  static int get usageHitCount => _usageHits.values.fold(0, (a, b) => a + b);

  /// Total miss events recorded.
  static int get usageMissCount => _usageMisses.values.fold(0, (a, b) => a + b);

  /// Clear all accumulated usage data so the next run starts fresh.
  static void resetUsageLog() {
    _usageHits.clear();
    _usageMisses.clear();
  }

  /// A human-readable end-of-run summary of recorded hits and misses, grouped
  /// into Hits/Misses and sorted by descending count. Embedders print this at
  /// run end (the VM CLI does so automatically when the env var is set).
  /// Returns a short "(no … recorded)" line when nothing was captured.
  static String usageLogSummary() {
    final buffer = StringBuffer();
    buffer.writeln('=== D4 relaxer/proxy/ctor usage log ===');
    if (_usageHits.isEmpty && _usageMisses.isEmpty) {
      buffer.writeln('(no relaxer/proxy/ctor lookups recorded)');
      return buffer.toString();
    }
    _writeUsageSection(buffer, 'Hits', _usageHits);
    _writeUsageSection(buffer, 'Misses', _usageMisses);
    return buffer.toString();
  }

  static void _writeUsageSection(
    StringBuffer buffer,
    String title,
    Map<String, int> data,
  ) {
    final total = data.values.fold(0, (a, b) => a + b);
    buffer.writeln('$title: $total event(s), ${data.length} distinct');
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    for (final e in entries) {
      buffer.writeln('  ${e.value}× ${e.key}');
    }
  }

  /// Build an enriched diagnostic message for an unresolved
  /// [extractBridgedArg] resolution (P&R#2 / request g).
  ///
  /// Beyond the bare "expected/got" line, it reports:
  /// - the **base type** (`expectedType` stripped of nullability + type args),
  /// - the **unmatched type-argument** (if `expectedType` is generic),
  /// - the **registration state** — whether a relaxer (generic-type wrapper),
  ///   interface-proxy, or generic-constructor factory is registered for the
  ///   *base* type even though none matched *this* argument, and
  /// - the concrete **remedy** (add the inner type to `additionalRelaxerTypes:`
  ///   in the bridge config, or register a factory programmatically).
  ///
  /// The first line preserves the historical
  /// `Invalid parameter "<name>": expected <T>, got <actual>` prefix so callers
  /// that match on it keep working; the diagnostics follow on indented lines.
  static String _missingBridgeResolutionMessage(
    String paramName,
    String expectedType,
    Object? actualType,
  ) {
    final base = _baseTypeName(expectedType);
    final typeArg = _innerTypeArg(expectedType);
    final hasRelaxer = _genericTypeWrappers.containsKey(base);
    final hasProxy = _interfaceProxies.containsKey(base);
    final hasCtor = _genericConstructors.keys.any((k) => k.startsWith('$base.'));

    final buffer = StringBuffer()
      ..write('Invalid parameter "$paramName": expected $expectedType, '
          'got $actualType')
      ..write('\n  base type: $base');
    if (typeArg.isNotEmpty) {
      buffer.write('\n  unmatched type-argument: $typeArg');
    }

    final registered = <String>[
      if (hasRelaxer) 'relaxer',
      if (hasProxy) 'interface-proxy',
      if (hasCtor) 'generic-constructor factory',
    ];
    if (registered.isEmpty) {
      buffer
        ..write('\n  registration: no relaxer / interface-proxy / '
            'generic-constructor factory is registered for "$base".')
        ..write('\n  remedy: add "$base" to `additionalRelaxerTypes:` in the '
            'bridge config and regenerate, or register one at runtime via '
            'D4.registerGenericTypeWrapper("$base", ...) / '
            'D4.registerInterfaceProxy("$base", ...).');
    } else {
      final verb = registered.length == 1 ? 'is' : 'are';
      final argDesc =
          typeArg.isEmpty ? 'this argument' : 'type-argument "$typeArg"';
      buffer
        ..write('\n  registration: a ${registered.join(' / ')} $verb '
            'registered for "$base", but $argDesc did not match.')
        ..write('\n  remedy: extend the registered factory to cover '
            '${typeArg.isEmpty ? 'this argument' : '"$base<$typeArg>"'} — add '
            '"$typeArg" to `additionalRelaxerTypes:` for "$base" and '
            'regenerate, or register an additional factory via '
            'D4.registerGenericTypeWrapper("$base", ...).');
    }
    return buffer.toString();
  }

  // ==========================================================================
  // RC-5: Supplementary Method Adapters
  // ==========================================================================

  /// Supplementary method adapters for bridged classes.
  ///
  /// These fill gaps where the bridge generator skips methods (e.g. @protected
  /// methods like ChangeNotifier.notifyListeners). Checked as a fallback
  /// after the main bridge method lookup in InterpretedInstance.get().
  static final Map<String, Map<String, BridgedMethodAdapter>>
      _supplementaryMethods = {};

  /// Register a supplementary method adapter for a bridged class.
  ///
  /// [bridgedClassName] - The name of the bridged class.
  /// [methodName] - The method name to add.
  /// [adapter] - The method adapter (same signature as generated adapters).
  ///
  /// **Idempotent:** Repeated calls with the same `(bridgedClassName,
  /// methodName)` overwrite the previously registered adapter — safe to
  /// call twice when generator-emitted blocks fire multiple times.
  static void registerSupplementaryMethod(
    String bridgedClassName,
    String methodName,
    BridgedMethodAdapter adapter,
  ) {
    _supplementaryMethods.putIfAbsent(bridgedClassName, () => {})[methodName] =
        adapter;
  }

  /// Look up a supplementary method adapter.
  static BridgedMethodAdapter? findSupplementaryMethod(
    String bridgedClassName,
    String methodName,
  ) {
    return _supplementaryMethods[bridgedClassName]?[methodName];
  }

  // ==========================================================================
  // Plan E: Bridged Method Interceptors
  // ==========================================================================

  /// Bridged method interceptors keyed by class name then method name.
  ///
  /// Generated bridge adapters for selected methods (currently
  /// `Element.dependOnInheritedWidgetOfExactType`,
  /// `Element.getInheritedWidgetOfExactType`,
  /// `Element.getElementForInheritedWidgetOfExactType`) emit a hook check at
  /// the top of their adapter body. If an interceptor is registered for the
  /// owning class + method name, it runs in place of the native call,
  /// receiving the full `(visitor, target, positional, named, typeArgs)`
  /// tuple — including any script-supplied generic type arguments which the
  /// native bridge call would otherwise drop.
  ///
  /// Used by `tom_d4rt_flutterm` to resolve interpreted `InheritedWidget`
  /// subclasses by walking the element tree and matching
  /// `_InterpretedInheritedWidget._instance.klass` against `typeArgs[0]`,
  /// since interpreted subclasses share the same native runtimeType and
  /// Flutter's `_inheritedElements[T]` lookup is type-erased.
  static final Map<String, Map<String, BridgedMethodAdapter>>
      _methodInterceptors = {};

  /// Register an interceptor for a bridged method. Replaces any previously
  /// registered interceptor for the same `(className, methodName)` pair.
  ///
  /// The [className] is the conceptual owner of the method (e.g. `'Element'`)
  /// — bridge adapters generated on subclasses look up the same key.
  static void registerBridgedMethodInterceptor(
    String className,
    String methodName,
    BridgedMethodAdapter interceptor,
  ) {
    _methodInterceptors.putIfAbsent(className, () => {})[methodName] =
        interceptor;
  }

  /// Look up a bridged method interceptor for `(className, methodName)`.
  /// Returns `null` when no interceptor has been registered.
  static BridgedMethodAdapter? findBridgedMethodInterceptor(
    String className,
    String methodName,
  ) {
    return _methodInterceptors[className]?[methodName];
  }

  // ==========================================================================
  // Plan E: Bridged Static Method Interceptors
  // ==========================================================================
  //
  // Same idea as [_methodInterceptors] but for static methods (e.g.
  // `InheritedModel.inheritFrom<T>`). Keyed by `(className, methodName)`.
  // The interceptor receives `(visitor, positional, named, typeArgs)` —
  // matching [BridgedStaticMethodAdapter].
  static final Map<String, Map<String, BridgedStaticMethodAdapter>>
      _staticMethodInterceptors = {};

  /// Register an interceptor for a bridged static method. Replaces any
  /// previously registered interceptor for the same `(className, methodName)`
  /// pair.
  static void registerBridgedStaticMethodInterceptor(
    String className,
    String methodName,
    BridgedStaticMethodAdapter interceptor,
  ) {
    _staticMethodInterceptors.putIfAbsent(className, () => {})[methodName] =
        interceptor;
  }

  /// Look up a bridged static method interceptor for `(className, methodName)`.
  /// Returns `null` when no interceptor has been registered.
  static BridgedStaticMethodAdapter? findBridgedStaticMethodInterceptor(
    String className,
    String methodName,
  ) {
    return _staticMethodInterceptors[className]?[methodName];
  }

  // ==========================================================================
  // RC-8: Enum Static Getter Registry
  // ==========================================================================

  /// Static getter adapters for bridged enums, keyed by enum name then getter
  /// name. These allow injecting non-constant static members (e.g.
  /// `WidgetState.any`) at runtime without modifying generated bridge files.
  static final Map<String, Map<String, Object? Function()>>
      _enumStaticGetters = {};

  /// Register a static getter on a bridged enum type.
  ///
  /// Used for enum static members that are not enum constants (e.g.
  /// `WidgetState.any` which returns a `WidgetStatesConstraint`).
  static void registerEnumStaticGetter(
    String enumName,
    String getterName,
    Object? Function() getter,
  ) {
    _enumStaticGetters.putIfAbsent(enumName, () => {})[getterName] = getter;
  }

  /// Look up a runtime-registered static getter for a bridged enum.
  static Object? Function()? findEnumStaticGetter(
    String enumName,
    String getterName,
  ) {
    return _enumStaticGetters[enumName]?[getterName];
  }

  // ==========================================================================
  // List Coercion
  // ==========================================================================

  /// Coerce a List from D4rt to a typed List.
  ///
  /// D4rt creates `List<Object?>` when evaluating list literals, even if all
  /// elements are of the same type. This function coerces the list to the
  /// expected type by casting each element.
  static List<T> coerceList<T>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<$T>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    if (value is! List) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<$T>, got ${value.runtimeType}',
      );
    }

    // If already the correct type, return as-is
    if (value is List<T>) {
      return value;
    }

    // GEN-080: when T is non-nullable, drop null elements before coercion.
    // This matches Dart's collection-if semantics (`if (false) widget` adds
    // nothing to the resulting list) and prevents the interpreter — which
    // is more lenient than the analyzer about null leaking into typed
    // lists — from blowing up with `type 'Null' is not a subtype of type X`
    // on bridge constructors that take `List<T>` for non-nullable T.
    final iterable = (null is T) ? value : value.where((e) => e != null);

    // Coerce each element to the expected type
    try {
      return iterable.map<T>((e) {
        if (e is BridgedInstance) {
          final native = e.nativeObject;
          if (native is T) return native as T;
          // GEN-079: Try wrapper resolution before failing the cast.
          // e.g., TweenSequenceItem<dynamic> → $RelaxedTweenSequenceItem<double>
          final wrapped = _tryGenericWrapperResolution<T>(native);
          if (wrapped != null) return wrapped;
          return native as T;
        }
        if (e is BridgedEnumValue) {
          return e.nativeValue as T;
        }
        // RC-1: InterpretedInstance element unwrapping.
        // When a D4rt list contains interpreted widgets/objects that extend
        // a bridged type, unwrap via bridgedSuperObject.
        if (e is InterpretedInstance) {
          if (e.bridgedSuperObject is T) {
            return e.bridgedSuperObject as T;
          }
          // RC-1: Try interface proxy for elements that implement a bridged interface
          final effectiveVisitor = _activeVisitor;
          if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
            final proxy =
                tryCreateInterfaceProxyWithVisitor<T>(e, effectiveVisitor);
            if (proxy != null) return proxy;
          }
        }
        // INTER-003c: int→double element promotion in lists
        if (_isDoubleType<T>() && e is int) {
          return e.toDouble() as T;
        }
        // GEN-079: Generic wrapper resolution for list elements.
        // When T is a parameterized generic (e.g., TweenSequenceItem<double>)
        // and the element has the right base type but wrong type args
        // (e.g., TweenSequenceItem<dynamic>), use registered wrapper factories.
        final unwrappedElem = e is BridgedInstance ? e.nativeObject : e;
        final wrapped = _tryGenericWrapperResolution<T>(unwrappedElem);
        if (wrapped != null) return wrapped;
        return e as T;
      }).toList();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert List to List<$T> - $e',
      );
    }
  }

  /// Check if T is double or double? (nullable double)
  static bool _isDoubleType<T>() {
    // Check non-nullable double
    if (T == double) return true;
    // Check nullable double by examining type string
    final typeName = T.toString();
    return typeName == 'double?' || typeName == 'double?';
  }

  /// Check if T is num or num? (nullable num)
  static bool _isNumType<T>() {
    if (T == num) return true;
    final typeName = T.toString();
    return typeName == 'num?' || typeName == 'num?';
  }

  /// GEN-075: Unwrap a single element from BridgedInstance/BridgedEnumValue.
  static Object? _unwrapElement(Object? e) {
    if (e is BridgedInstance) return e.nativeObject;
    if (e is BridgedEnumValue) return e.nativeValue;
    return e;
  }

  /// MAP-COERCE: split a generic argument list `K, V` at the top-level comma.
  ///
  /// Respects nested angle brackets so `Map<K, V>` arguments containing other
  /// generics (e.g. `Map<String, List<int>>`) are split correctly. Returns
  /// the index of the top-level comma, or -1 if no top-level comma is found.
  static int _splitTopLevelComma(String s) {
    var depth = 0;
    for (var i = 0; i < s.length; i++) {
      final c = s.codeUnitAt(i);
      if (c == 0x3C /* '<' */ || c == 0x28 /* '(' */) {
        depth++;
      } else if (c == 0x3E /* '>' */ || c == 0x29 /* ')' */) {
        depth--;
      } else if (c == 0x2C /* ',' */ && depth == 0) {
        return i;
      }
    }
    return -1;
  }

  /// MAP-COERCE: rebuild [source] as a `Map<K, V>` for common primitive
  /// combinations, dispatching on the parsed type-string pair.
  ///
  /// `extractBridgedArg<Map<K, V>>` cannot use compile-time type parameters,
  /// so a typed cast of `Map<Object?, Object?>` to the requested
  /// `Map<String, String>` (etc.) fails on reified generics. This helper
  /// rebuilds the map with concrete element types for the cases that show
  /// up in real bridges — covering the dcli `withEnvironmentAsync` case
  /// (`Map<String, String>`) plus the other primitive shapes that appear
  /// in stdlib and Flutter bridges. Returns null if the K|V combination
  /// is not handled, in which case the caller falls back to the existing
  /// unwrapped/rewrapped map paths.
  static Map<dynamic, dynamic>? _buildTypedMap(
    Map<Object?, Object?> source,
    String keyType,
    String valueType,
  ) {
    final key = '$keyType|$valueType';
    switch (key) {
      case 'String|String':
        return <String, String>{
          for (final e in source.entries) e.key as String: e.value as String,
        };
      case 'String|int':
        return <String, int>{
          for (final e in source.entries) e.key as String: e.value as int,
        };
      case 'String|double':
        return <String, double>{
          for (final e in source.entries)
            e.key as String:
                e.value is int ? (e.value as int).toDouble() : e.value as double,
        };
      case 'String|num':
        return <String, num>{
          for (final e in source.entries) e.key as String: e.value as num,
        };
      case 'String|bool':
        return <String, bool>{
          for (final e in source.entries) e.key as String: e.value as bool,
        };
      case 'String|Object':
      case 'String|Object?':
      case 'String|dynamic':
        return <String, Object?>{
          for (final e in source.entries) e.key as String: e.value,
        };
      case 'int|String':
        return <int, String>{
          for (final e in source.entries) e.key as int: e.value as String,
        };
      case 'int|int':
        return <int, int>{
          for (final e in source.entries) e.key as int: e.value as int,
        };
      case 'int|Object':
      case 'int|Object?':
      case 'int|dynamic':
        return <int, Object?>{
          for (final e in source.entries) e.key as int: e.value,
        };
      case 'Object|Object':
      case 'Object?|Object?':
      case 'dynamic|dynamic':
        return Map<Object?, Object?>.of(source);
      default:
        return null;
    }
  }

  /// GEN-079: Try to resolve a value through registered generic type wrapper
  /// factories.
  ///
  /// When T is a parameterized generic (e.g., `TweenSequenceItem<double>`) and
  /// [value] has the right base type but wrong type arguments (e.g.,
  /// `TweenSequenceItem<dynamic>`), registered wrapper factories can create a
  /// properly typed proxy (e.g., `$RelaxedTweenSequenceItem<double>`).
  ///
  /// Returns the wrapped value if a factory succeeds, or `null` if no factory
  /// matched.
  static T? _tryGenericWrapperResolution<T>(Object? value) {
    if (value == null || _genericTypeWrappers.isEmpty) return null;
    final tStr = T.toString();
    // Strip trailing '?' for nullable generic types
    String baseT = tStr;
    while (baseT.endsWith('?')) {
      baseT = baseT.substring(0, baseT.length - 1);
    }
    if (!baseT.contains('<')) return null;
    final baseTypeName = baseT.substring(0, baseT.indexOf('<'));
    final innerTypeArg = baseT.substring(
      baseT.indexOf('<') + 1,
      baseT.lastIndexOf('>'),
    );

    // Try with the target base type name first, then with the value's
    // runtime base type name (e.g., WidgetStatePropertyAll when target is
    // WidgetStateProperty).
    final valueName = value.runtimeType.toString();
    final valueBaseName = valueName.contains('<')
        ? valueName.substring(0, valueName.indexOf('<'))
        : valueName;
    final typeNamesToTry = <String>{baseTypeName, valueBaseName};

    for (final typeName in typeNamesToTry) {
      final factories = _genericTypeWrappers[typeName];
      if (factories == null) continue;
      for (final factory in factories) {
        // Try exact innerTypeArg first (e.g., 'Color?').
        // Only accept non-null results: null means "not handled by this
        // factory" and the next factory should be tried.
        final wrapped = factory(value, innerTypeArg);
        if (wrapped != null && wrapped is T) {
          if (usageLogEnabled) recordUsageHit('relaxer', typeName, innerTypeArg);
          return wrapped as T;
        }
        // GEN-079b: If innerTypeArg is nullable (e.g., 'Color?'), also try
        // the non-nullable form (e.g., 'Color'). The wrapper created with
        // non-nullable T will still be assignable to the nullable target.
        if (innerTypeArg.endsWith('?')) {
          final nonNullableArg =
              innerTypeArg.substring(0, innerTypeArg.length - 1);
          final wrapped2 = factory(value, nonNullableArg);
          if (wrapped2 != null && wrapped2 is T) {
            if (usageLogEnabled) {
              recordUsageHit('relaxer', typeName, nonNullableArg);
            }
            return wrapped2 as T;
          }
        }
      }
    }
    return null;
  }

  /// P&R#3: Last-resort user-factory resolution, tried immediately before
  /// [extractBridgedArg] gives up and throws.
  ///
  /// The inlined relaxer lookup inside [extractBridgedArg] only consults
  /// [_genericTypeWrappers] when `T` is itself parameterized (its string form
  /// contains `<…>`). A relaxer registered for a *non-generic* user type — the
  /// common case when an embedder calls
  /// `D4rt.registerRelaxerFactory` / [registerGenericTypeWrapper] for one of
  /// its own classes — would therefore never be reached. This helper closes
  /// that gap: it looks the base type name up in [_genericTypeWrappers]
  /// (passing an empty inner type argument for non-generic `T`) and returns
  /// the first factory result that satisfies `T`.
  ///
  /// Strictly additive — it runs only on the path that would otherwise throw,
  /// so it can turn a previous failure into a success but can never change the
  /// result of an argument that already resolved.
  ///
  /// Returns the resolved value, or `null` if no user factory matched.
  static T? _tryUserFactoryResolution<T>(Object? value) {
    if (value == null || _genericTypeWrappers.isEmpty) return null;
    final tStr = T.toString();
    String baseT = tStr;
    while (baseT.endsWith('?')) {
      baseT = baseT.substring(0, baseT.length - 1);
    }
    final String baseTypeName;
    final String innerTypeArg;
    if (baseT.contains('<')) {
      baseTypeName = baseT.substring(0, baseT.indexOf('<'));
      innerTypeArg = baseT.substring(
        baseT.indexOf('<') + 1,
        baseT.lastIndexOf('>'),
      );
    } else {
      baseTypeName = baseT;
      innerTypeArg = '';
    }

    final valueName = value.runtimeType.toString();
    final valueBaseName = valueName.contains('<')
        ? valueName.substring(0, valueName.indexOf('<'))
        : valueName;
    final typeNamesToTry = <String>{baseTypeName, valueBaseName};

    for (final typeName in typeNamesToTry) {
      final factories = _genericTypeWrappers[typeName];
      if (factories == null) continue;
      for (final factory in factories) {
        final wrapped = factory(value, innerTypeArg);
        if (wrapped != null && wrapped is T) {
          if (usageLogEnabled) {
            recordUsageHit('relaxer', typeName, innerTypeArg);
          }
          return wrapped as T;
        }
      }
    }
    return null;
  }

  /// Coerce a List from D4rt, returning null if arg is null.
  static List<T>? coerceListOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceList<T>(arg, paramName);
  }

  /// Coerce a nested `List<List<T>>` from D4rt.
  ///
  /// For parameters like `List<List<Widget>>`, the outer list contains
  /// inner lists that each need element-level coercion. Standard
  /// `coerceList<List<T>>` can't handle this because inner lists are
  /// `List<dynamic>` which can't be cast to `List<T>` directly.
  static List<List<T>> coerceNestedList<T>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<List<$T>>, got null',
      );
    }

    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    if (value is! List) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<List<$T>>, '
        'got ${value.runtimeType}',
      );
    }

    if (value is List<List<T>>) return value;

    try {
      return value.map<List<T>>((row) {
        return coerceList<T>(row, paramName);
      }).toList();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert to '
        'List<List<$T>> - $e',
      );
    }
  }

  /// GEN-096 (D8g): nullable variant of [coerceNestedList]. Returns null if
  /// `arg` is null, otherwise delegates to [coerceNestedList]. Used by the
  /// bridge generator for parameters typed `List<List<T>>?`.
  static List<List<T>>? coerceNestedListOrNull<T>(
    Object? arg,
    String paramName,
  ) {
    if (arg == null) return null;
    return coerceNestedList<T>(arg, paramName);
  }

  // ==========================================================================
  // Set Coercion
  // ==========================================================================

  /// Coerce a Set from D4rt to a typed Set.
  ///
  /// D4rt creates `Set<Object?>` when evaluating set literals. This
  /// function coerces the set to the expected element type by unwrapping
  /// BridgedInstance, BridgedEnumValue, and InterpretedInstance elements.
  static Set<T> coerceSet<T>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Set<$T>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    // D4rt may produce Maps for set literals (e.g. `{}` defaults to Map,
    // or `{a, b}` can be misidentified). Coerce Map keys → Set elements.
    final Iterable<Object?> elements;
    if (value is Set) {
      if (value is Set<T>) return value;
      elements = value;
    } else if (value is Map) {
      elements = value.keys;
    } else if (value is List) {
      elements = value;
    } else {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Set<$T>, got ${value.runtimeType}',
      );
    }

    // Coerce each element to the expected type
    try {
      return elements.map<T>((e) {
        if (e is BridgedInstance) {
          final native = e.nativeObject;
          if (native is T) return native as T;
          // GEN-079: Try wrapper resolution before failing the cast.
          final wrapped = _tryGenericWrapperResolution<T>(native);
          if (wrapped != null) return wrapped;
          return native as T;
        }
        if (e is BridgedEnumValue) {
          return e.nativeValue as T;
        }
        if (e is InterpretedInstance) {
          if (e.bridgedSuperObject is T) {
            return e.bridgedSuperObject as T;
          }
          final effectiveVisitor = _activeVisitor;
          if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
            final proxy =
                tryCreateInterfaceProxyWithVisitor<T>(e, effectiveVisitor);
            if (proxy != null) return proxy;
          }
        }
        // GEN-079: Generic wrapper resolution for set elements.
        final unwrappedElem = e is BridgedInstance ? e.nativeObject : e;
        final wrapped = _tryGenericWrapperResolution<T>(unwrappedElem);
        if (wrapped != null) return wrapped;
        return e as T;
      }).toSet();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert to Set<$T> - $e',
      );
    }
  }

  /// Coerce a Set from D4rt, returning null if arg is null.
  static Set<T>? coerceSetOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceSet<T>(arg, paramName);
  }

  // ==========================================================================
  // Map Coercion
  // ==========================================================================

  /// Coerce a Map from D4rt to a typed Map.
  ///
  /// D4rt creates `Map<Object?, Object?>` when evaluating map literals. This
  /// function coerces the map to the expected key and value types.
  ///
  /// If [visitor] is provided and the value type V is a function type,
  /// InterpretedFunction values will be wrapped in proper callbacks.
  static Map<K, V> coerceMap<K, V>(
    Object? arg,
    String paramName, [
    InterpreterVisitor? visitor,
  ]) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Map<$K, $V>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    if (value is! Map) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Map<$K, $V>, got ${value.runtimeType}',
      );
    }

    // If already the correct type, return as-is
    if (value is Map<K, V>) {
      return value;
    }

    // Coerce each key-value pair to the expected types
    try {
      return value.map<K, V>((k, v) {
        final key = _coerceMapKey<K>(k, paramName, visitor);
        final val = _coerceMapValue<V>(v, paramName, visitor);
        return MapEntry(key, val);
      });
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert Map to Map<$K, $V> - $e',
      );
    }
  }

  /// Coerce a Map from D4rt, returning null if arg is null.
  ///
  /// If [visitor] is provided and the value type V is a function type,
  /// InterpretedFunction values will be wrapped in proper callbacks.
  static Map<K, V>? coerceMapOrNull<K, V>(
    Object? arg,
    String paramName, [
    InterpreterVisitor? visitor,
  ]) {
    if (arg == null) return null;
    return coerceMap<K, V>(arg, paramName, visitor);
  }

  /// Coerce a single map key.
  ///
  /// Handles BridgedInstance, BridgedEnumValue, BridgedClass, InterpretedClass
  /// and InterpretedInstance — the latter via bridgedSuperObject or an
  /// interface proxy (C20a follow-up: maps with user-defined classes
  /// implementing a bridged abstract type, e.g. WidgetStatesConstraint).
  static K _coerceMapKey<K>(
    Object? k,
    String paramName,
    InterpreterVisitor? visitor,
  ) {
    if (k is BridgedInstance) {
      return k.nativeObject as K;
    }
    if (k is BridgedEnumValue) {
      return k.nativeValue as K;
    }
    if (k is BridgedClass) {
      return k.nativeType as K; // ENG-002: class name → Type
    }
    if (k is InterpretedClass && k.bridgedSuperclass != null) {
      return k.bridgedSuperclass!.nativeType as K;
    }
    if (k is InterpretedInstance) {
      if (k.bridgedSuperObject is K) {
        return k.bridgedSuperObject as K;
      }
      final effectiveVisitor = visitor ?? _activeVisitor;
      if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
        final proxy = tryCreateInterfaceProxyWithVisitor<K>(
          k,
          effectiveVisitor,
        );
        if (proxy != null) return proxy;
      }
    }
    return k as K;
  }

  /// Coerce a single map value, handling function type wrapping.
  static V _coerceMapValue<V>(
    Object? v,
    String paramName,
    InterpreterVisitor? visitor,
  ) {
    final unwrapped = v is BridgedInstance ? v.nativeObject : v;

    // InterpretedInstance → native via bridgedSuperObject or interface proxy
    if (v is InterpretedInstance) {
      if (v.bridgedSuperObject is V) {
        return v.bridgedSuperObject as V;
      }
      final effectiveVisitor = visitor ?? _activeVisitor;
      if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
        final proxy = tryCreateInterfaceProxyWithVisitor<V>(
          v,
          effectiveVisitor,
        );
        if (proxy != null) return proxy;
      }
    }

    // If V is a function type and v is an InterpretedFunction, wrap it
    // We detect function types by checking the type name string
    final vTypeName = V.toString();
    if (_looksLikeFunctionType(vTypeName) &&
        (v is InterpretedFunction || v is NativeFunction || v is Callable)) {
      if (visitor == null) {
        throw ArgumentD4rtException(
          'Invalid parameter "$paramName": Map contains function values but '
          'visitor was not provided for callback wrapping',
        );
      }
      return _wrapCallableForMap<V>(v!, visitor) as V;
    }

    // Direct cast as fallback
    return unwrapped as V;
  }

  /// Check if a type string looks like a function type.
  static bool _looksLikeFunctionType(String typeName) {
    // Function types look like:
    // - "() => void"
    // - "(int) => String"
    // - "void Function()"
    // - "Widget Function(BuildContext)"
    return typeName.contains('=>') ||
        typeName.contains('Function(') ||
        typeName.contains('Function<');
  }

  /// Wrap an InterpretedFunction/Callable for use as a Map value function.
  ///
  /// Detects the expected return type from V and creates an appropriate wrapper.
  /// For common widget builder patterns like `Widget Function(BuildContext)`,
  /// returns the correctly typed wrapper.
  static dynamic _wrapCallableForMap<V>(
    Object callable,
    InterpreterVisitor visitor,
  ) {
    // Extract function signature info from V
    final vType = V.toString();

    // Check for common single-argument patterns like "Widget Function(BuildContext)"
    // Pattern: "ReturnType Function(ArgType)" or "(ArgType) => ReturnType"
    // Note: Using untyped parameters to get dynamic, which is assignable to any type
    if (_isSingleArgFunction(vType)) {
      // Return a wrapper with 1 required positional argument (untyped = dynamic)
      return (arg) {
        if (callable is Callable) {
          return unwrapInterpreterValue(callable.call(visitor, [arg], {}));
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Check for no-argument functions like "void Function()"
    if (_isNoArgFunction(vType)) {
      return () {
        if (callable is Callable) {
          return unwrapInterpreterValue(callable.call(visitor, [], {}));
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Check for two-argument functions (untyped = dynamic)
    if (_isTwoArgFunction(vType)) {
      return (arg1, arg2) {
        if (callable is Callable) {
          return unwrapInterpreterValue(
              callable.call(visitor, [arg1, arg2], {}));
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Fallback: variable-arity wrapper with dynamic params
    // Note: Using untyped optional params for flexibility
    return ([p0, p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
      final args = <Object?>[];
      if (p0 != null) args.add(p0);
      if (p1 != null) args.add(p1);
      if (p2 != null) args.add(p2);
      if (p3 != null) args.add(p3);
      if (p4 != null) args.add(p4);
      if (p5 != null) args.add(p5);
      if (p6 != null) args.add(p6);
      if (p7 != null) args.add(p7);
      if (p8 != null) args.add(p8);
      if (p9 != null) args.add(p9);

      if (callable is Callable) {
        return unwrapInterpreterValue(callable.call(visitor, args, {}));
      }
      throw ArgumentD4rtException(
        'Cannot call non-callable object in Map value: ${callable.runtimeType}',
      );
    };
  }

  /// Check if type is a single-argument function.
  /// Examples: "Widget Function(BuildContext)", "(BuildContext) => Widget",
  /// "Widget Function(BuildContext)?" (nullable function type).
  static bool _isSingleArgFunction(String typeName) {
    // Match "ReturnType Function(SingleType)" - no comma means single arg.
    // Bug-47 FIX: also match nullable function types ending in `)?`.
    final functionMatch =
        RegExp(r'Function\(([^,)]+)\)\??$').firstMatch(typeName);
    if (functionMatch != null) {
      return true;
    }
    // Match "(SingleType) => ReturnType"
    final arrowMatch = RegExp(r'\(([^,)]+)\)\s*=>\s*\S+$').firstMatch(typeName);
    if (arrowMatch != null) {
      return true;
    }
    return false;
  }

  /// Check if type is a no-argument function.
  /// Examples: "void Function()", "() => void", "void Function()?".
  static bool _isNoArgFunction(String typeName) {
    // Bug-47 FIX: match `Function()` and `Function()?` (nullable).
    return RegExp(r'Function\(\)\??').hasMatch(typeName) ||
        RegExp(r'\(\)\s*=>').hasMatch(typeName);
  }

  /// Check if type is a two-argument function.
  /// Examples: "Widget Function(BuildContext, Widget)", "(A, B) => R",
  /// "Widget Function(BuildContext, Widget)?" (nullable function type).
  static bool _isTwoArgFunction(String typeName) {
    // Match "Function(Type1, Type2)" - exactly one comma.
    // Bug-47 FIX: also match nullable function types ending in `)?`.
    final functionMatch = RegExp(
      r'Function\(([^,]+),\s*([^,)]+)\)\??$',
    ).firstMatch(typeName);
    if (functionMatch != null) {
      return true;
    }
    // Match "(Type1, Type2) => ReturnType"
    final arrowMatch = RegExp(
      r'\(([^,]+),\s*([^,)]+)\)\s*=>',
    ).firstMatch(typeName);
    if (arrowMatch != null) {
      return true;
    }
    return false;
  }

  // ==========================================================================
  // Bridged Argument Extraction
  // ==========================================================================

  /// Recursively unwrap [BridgedInstance] and [BridgedEnumValue] values that
  /// may be nested inside `Map`, `List`, or `Set` containers.
  ///
  /// Used by [extractBridgedArg] when the requested type `T` is unbounded
  /// (`dynamic`/`Object`/`Object?`). Native code receiving such values
  /// (e.g. `StandardMessageCodec.encodeMessage`, JSON codecs) cannot
  /// interpret the `BridgedInstance` wrapper and rejects it with
  /// `Invalid argument: Instance of 'BridgedInstance<...>'`.
  ///
  /// Typed parameters use [coerceMap]/[coerceList]/[coerceSet] instead, which
  /// recurse with element-type information.
  static Object? _deepUnwrap(Object? value) {
    if (value == null) return null;
    if (value is BridgedInstance) return _deepUnwrap(value.nativeObject);
    if (value is BridgedEnumValue) return value.nativeValue;
    // Preserve typed_data buffers as-is. `Uint8List`, `Int32List`,
    // `Float64List`, `ByteData`, … extend `List<int>`/`List<double>` so a
    // naive `value is List` branch would convert them to a plain
    // `List<Object?>` and break codec round-trips that rely on the runtime
    // type (StandardMessageCodec encodes typed buffers with dedicated tags).
    if (value is TypedData) return value;
    if (value is Map) {
      // Preserve as Map<Object?, Object?> — the codec contract for
      // StandardMessageCodec and JSON encoders is keyed on Object?.
      final out = <Object?, Object?>{};
      value.forEach((k, v) {
        out[_deepUnwrap(k)] = _deepUnwrap(v);
      });
      return out;
    }
    if (value is List) {
      return value.map<Object?>(_deepUnwrap).toList();
    }
    if (value is Set) {
      return value.map<Object?>(_deepUnwrap).toSet();
    }
    return value;
  }

  /// Extract a typed value from a BridgedInstance or native object.
  ///
  /// Handles both wrapped (BridgedInstance) and unwrapped (native) objects.
  /// Throws ArgumentError if the type doesn't match.
  ///
  /// If [visitor] is provided, interface proxy creation is enabled for
  /// InterpretedInstance values that implement bridged abstract types.
  ///
  /// INTER-003: Supports int→double promotion
  /// INTER-004: Supports collection type casting (List, Set, Map)
  static T extractBridgedArg<T>(Object? arg, String paramName,
      [InterpreterVisitor? visitor]) {
    // Unwrap BridgedInstance or BridgedEnumValue if needed
    final unwrapped = arg is BridgedInstance
        ? arg.nativeObject
        : arg is BridgedEnumValue
            ? arg.nativeValue
            : arg;

    if (unwrapped is T) {
      // GEN-C3: Deep-unwrap container contents for unbounded T.
      // When the bridge adapter requests `dynamic`, `Object`, or `Object?`
      // (typically because the underlying parameter is declared as such —
      // e.g. `MessageCodec.encodeMessage(dynamic message)`), nested
      // BridgedInstance/BridgedEnumValue values inside Map/List/Set
      // containers must be unwrapped before reaching native code. Native
      // receivers (StandardMessageCodec, JSON codecs, …) cannot interpret
      // BridgedInstance wrappers and reject them with `Invalid argument`.
      // Typed parameters (e.g. `Map<String, Widget>`) take a different
      // path via `coerceMap` and are unaffected by this branch.
      final tName = T.toString();
      if (tName == 'dynamic' ||
          tName == 'Object' ||
          tName == 'Object?') {
        final deep = _deepUnwrap(unwrapped);
        if (deep is T) return deep;
      }
      return unwrapped;
    }

    // ENG-007: Nullable type fallback.
    // When T is nullable (e.g., TextStyle?) and unwrapped is the non-nullable
    // base type (TextStyle), the `is T` check should succeed in Dart.
    // However, cross-package or reified generics edge cases may cause `is T`
    // to fail. This fallback uses a dynamic cast as a safety net.
    if (null is T && unwrapped != null) {
      try {
        return unwrapped as T;
      } catch (_) {
        // Fall through to subsequent checks
      }
    }

    // GEN-100: String-based nullable type check fallback.
    // In some Flutter test environments, `v is T?` can incorrectly return
    // false even when v's runtimeType matches the non-nullable base of T.
    // This check compares type names as strings as a last resort.
    if (null is T && unwrapped != null) {
      final tStr = T.toString();
      final unwrappedTypeStr = unwrapped.runtimeType.toString();
      // Check if T is "SomeType?" and unwrapped is "SomeType"
      if (tStr.endsWith('?') &&
          tStr.substring(0, tStr.length - 1) == unwrappedTypeStr) {
        // The types match semantically, force the return through dynamic.
        // GEN-100b (C07): When two classes share a simple name but live in
        // different libraries (e.g. painting.StrutStyle vs dart:ui.StrutStyle),
        // the `as T` cast still throws TypeError even though the simple-name
        // match succeeded. Wrap in try/catch so the subsequent RC-3
        // cross-package type-coercion path can fire on the same argument
        // instead of surfacing a raw TypeError out of the bridge.
        try {
          final dynamic temp = unwrapped;
          return temp as T;
        } catch (_) {
          // Fall through to RC-3 coercion or final ArgumentD4rtException.
        }
      }
    }

    // ENG-002: BridgedClass → Type conversion.
    // When a class name appears in expression position (e.g., as a map key
    // like `{ActivateIntent: ...}`), the interpreter resolves it to a
    // BridgedClass object. Convert to the native Type for bridges expecting Type.
    if (arg is BridgedClass && arg.nativeType is T) {
      return arg.nativeType as T;
    }

    // RC-6c: Callable → native function wrapping.
    // When T is a function type (e.g., void Function(), GestureTapCallback)
    // and the value is a Callable (InterpretedFunction or NativeFunction),
    // wrap it in a native closure so it can be assigned to typed function
    // properties. Uses the same pattern as _wrapCallableForMap.
    if (unwrapped is Callable) {
      final tStr = T.toString();
      if (tStr.contains('Function')) {
        final effectiveVisitor = visitor ?? _activeVisitor;
        if (effectiveVisitor != null) {
          final wrapped = _wrapCallableForMap<T>(unwrapped, effectiveVisitor);
          if (wrapped is T) return wrapped;
        }
      }
    }

    // GEN-079: Generic type wrapper resolution.
    // When T is a complex generic (e.g., WidgetStateProperty<Color?>?),
    // the `is T` check fails if the value was created with `<dynamic>`
    // (e.g., WidgetStatePropertyAll<dynamic>) because Dart's reified generics
    // require exact type argument matching for subtype checks.
    // Use registered wrapper factories to create properly typed proxy objects.
    // Factories are checked additively — each module contributes cases for
    // its own types, and the first factory to return non-null wins.
    //
    // IMPORTANT: Inlined (not via _tryGenericWrapperResolution helper) so that
    // when a factory returns null for an unrecognised innerTypeArg and T is
    // nullable, `null is T` returns the null directly — which is valid for
    // optional bridge parameters. The helper route checked `wrapperResult !=
    // null`, masking valid null-for-nullable returns and falling through to a
    // spurious ArgumentD4rtException.
    if (unwrapped != null && _genericTypeWrappers.isNotEmpty) {
      final tStr = T.toString();
      // Strip trailing '?' for nullable generic types
      String baseT = tStr;
      while (baseT.endsWith('?')) {
        baseT = baseT.substring(0, baseT.length - 1);
      }
      if (baseT.contains('<')) {
        final baseTypeName = baseT.substring(0, baseT.indexOf('<'));
        final innerTypeArg = baseT.substring(
          baseT.indexOf('<') + 1,
          baseT.lastIndexOf('>'),
        );

        // Try with the target base type name first, then with the value's
        // runtime base type name (e.g., WidgetStatePropertyAll when target is
        // WidgetStateProperty).
        final valueName = unwrapped.runtimeType.toString();
        final valueBaseName = valueName.contains('<')
            ? valueName.substring(0, valueName.indexOf('<'))
            : valueName;
        final typeNamesToTry = <String>{baseTypeName, valueBaseName};

        for (final typeName in typeNamesToTry) {
          final factories = _genericTypeWrappers[typeName];
          if (factories == null) continue;
          for (final factory in factories) {
            // Only accept non-null results: null means "not handled by this
            // factory, keep trying the next one".
            final wrapped = factory(unwrapped, innerTypeArg);
            if (wrapped != null && wrapped is T) {
              if (usageLogEnabled) {
                recordUsageHit('relaxer', typeName, innerTypeArg);
              }
              return wrapped as T;
            }
            // GEN-079b: If innerTypeArg is nullable (e.g., 'Color?'), also try
            // the non-nullable form. The wrapper created with non-nullable T
            // will still be assignable to the nullable target.
            if (innerTypeArg.endsWith('?')) {
              final nonNullableArg = innerTypeArg.substring(
                0,
                innerTypeArg.length - 1,
              );
              final wrapped2 = factory(unwrapped, nonNullableArg);
              if (wrapped2 != null && wrapped2 is T) {
                if (usageLogEnabled) {
                  recordUsageHit('relaxer', typeName, nonNullableArg);
                }
                return wrapped2 as T;
              }
            }
          }
        }
      }
    }

    // INTER-003: int→double promotion (handles both double and double?)
    if (_isDoubleType<T>() && unwrapped is int) {
      return unwrapped.toDouble() as T;
    }

    // INTER-003b: int→num promotion (handles both num and num?)
    if (_isNumType<T>() && unwrapped is int) {
      return unwrapped as T;
    }

    // INTER-004: Collection type casting
    // GEN-075: Unwrap BridgedInstance/BridgedEnumValue elements first
    final tStr = T.toString();

    // List<Object?> → List<T> (also handles Iterable<T>)
    if (unwrapped is List &&
        (tStr.startsWith('List<') || tStr.startsWith('Iterable<'))) {
      try {
        // Unwrap any BridgedInstance/BridgedEnumValue elements
        final unwrappedList = unwrapped.map(_unwrapElement).toList();
        // Extract element type from T string
        final prefixLen = tStr.startsWith('List<') ? 5 : 9;
        final elementType = tStr.substring(prefixLen, tStr.length - 1);
        final result = switch (elementType) {
          'int' => unwrappedList.cast<int>().toList(),
          'double' => unwrappedList
              .map((e) => e is int ? e.toDouble() : e)
              .cast<double>()
              .toList(),
          'String' => unwrappedList.cast<String>().toList(),
          'num' => unwrappedList.cast<num>().toList(),
          'bool' => unwrappedList.cast<bool>().toList(),
          'Object' || 'dynamic' => unwrappedList.cast<Object>().toList(),
          // ENG-001: For non-primitive types, use coerceList which handles
          // BridgedInstance/InterpretedInstance/BridgedEnumValue unwrapping
          // and produces a properly typed List<T> via element casting.
          _ => unwrappedList,
        };
        // ENG-001: Try typed cast; if it fails, try coerceList which creates
        // a properly-typed list using per-element casting.
        try {
          return result as T;
        } catch (_) {
          // Fall through — collection is right shape but wrong generic type
        }
      } catch (_) {
        // Fall through to error
      }
    }

    // C35: Iterator<Object?> → Iterator<T>.
    // Typed list literals (e.g. `<int>[1, 2, 3]`) lose their element type
    // inside the interpreter and produce a `List<Object?>`, whose `.iterator`
    // is `ListIterator<Object?>`. Bridge constructors that declare an
    // `Iterator<T>` parameter (e.g. `CachingIterable<T>(Iterator<T> source)`)
    // then reject the value via reified-generics TypeError. Wrap the source
    // iterator in a typed cast iterator that lazily casts each `current`
    // element, mirroring `Iterable.cast<T>().iterator`.
    if (unwrapped is Iterator && tStr.startsWith('Iterator<')) {
      final elementType = tStr.substring(9, tStr.length - 1);
      final source = unwrapped;
      final Iterator<Object?>? result = switch (elementType) {
        'int' => _CastIterator<int>(source),
        'double' => _PromotingDoubleIterator(source),
        'String' => _CastIterator<String>(source),
        'num' => _CastIterator<num>(source),
        'bool' => _CastIterator<bool>(source),
        'Object' ||
        'dynamic' ||
        'Object?' =>
          _CastIterator<Object?>(source),
        _ => null,
      };
      if (result != null) {
        try {
          return result as T;
        } catch (_) {
          // Fall through to error.
        }
      }
    }

    // Set<Object?> → Set<T>
    if ((unwrapped is Set || (unwrapped is Map && tStr.startsWith('Set<'))) &&
        tStr.startsWith('Set<')) {
      try {
        // D4rt may produce Maps for set literals (e.g., `{}` defaults to Map).
        // Coerce Map keys → Set elements.
        final source = unwrapped is Map ? unwrapped.keys : (unwrapped as Set);
        final unwrappedSet = source.map(_unwrapElement).toSet();
        final elementType = tStr.substring(4, tStr.length - 1);
        final result = switch (elementType) {
          'int' => unwrappedSet.cast<int>().toSet(),
          'double' => unwrappedSet
              .map((e) => e is int ? e.toDouble() : e)
              .cast<double>()
              .toSet(),
          'String' => unwrappedSet.cast<String>().toSet(),
          'num' => unwrappedSet.cast<num>().toSet(),
          'bool' => unwrappedSet.cast<bool>().toSet(),
          'Object' || 'dynamic' => unwrappedSet.cast<Object>().toSet(),
          // RC-7c: For non-primitive element types (e.g., Set<WidgetState>),
          // attempt Set.from() which uses runtime type coercion. Elements
          // are already unwrapped to native values, so the typed set
          // constructor can succeed if all elements are the correct type.
          _ => unwrappedSet,
        };
        try {
          return result as T;
        } catch (_) {
          // RC-7c: Direct cast failed (e.g., Set<Object?> as Set<EnumType>).
          // Non-primitive Set coercion requires coerceSet<ElementType>() at
          // the call site (bridge adapters). extractBridgedArg cannot create
          // typed sets without compile-time type parameters.
          // Fall through to error.
        }
      } catch (_) {
        // Fall through to error
      }
    }

    // Map casting support
    // When T is Map<K,V> and the value is Map<Object?, Object?>, unwrap
    // BridgedInstance/BridgedEnumValue keys and values, then try to cast
    // the resulting map. Uses coerceMap for proper typed map creation
    // when the basic unwrap+cast approach fails.
    if (unwrapped is Map && tStr.startsWith('Map<')) {
      try {
        // ENG-001: Try unwrapping map keys and values first
        final unwrappedMap = <Object?, Object?>{};
        for (final entry in unwrapped.entries) {
          unwrappedMap[_unwrapElement(entry.key)] = _unwrapElement(entry.value);
        }
        try {
          return unwrappedMap as T;
        } catch (_) {}
        // Fall back to original map
        try {
          return unwrapped as T;
        } catch (_) {}
        // MAP-COERCE: Rebuild as a typed Map<K, V> for common primitive
        // combinations. Reified generics defeat the bare casts above
        // (a Map<Object?, Object?> cannot be cast to Map<String, String>),
        // so parse K and V from the type string and dispatch through
        // _buildTypedMap. Mirrors the Set branch above and unblocks the
        // dcli `withEnvironmentAsync(environment: <String, String>{...})`
        // path (Cluster MAP-COERCE).
        final inner = tStr.substring(4, tStr.length - 1);
        final commaIdx = _splitTopLevelComma(inner);
        if (commaIdx > 0) {
          final keyType = inner.substring(0, commaIdx).trim();
          final valueType = inner.substring(commaIdx + 1).trim();
          final typed = _buildTypedMap(unwrappedMap, keyType, valueType);
          if (typed != null) {
            try {
              return typed as T;
            } catch (_) {}
          }
        }
        // GEN-079: Generic wrapper resolution for map values.
        // Try wrapping individual values through registered factories.
        final rewrappedMap = <Object?, Object?>{};
        for (final entry in unwrappedMap.entries) {
          rewrappedMap[entry.key] = entry.value;
        }
        return rewrappedMap as T;
      } catch (_) {
        // Fall through to error
      }
    }

    // RC-1: InterpretedInstance → bridgedSuperObject unwrapping.
    // When a D4rt script class extends a bridged class (e.g.,
    // `class _StatefulDemo extends StatefulWidget`), the InterpretedInstance
    // holds the native object in bridgedSuperObject.
    if (arg is InterpretedInstance) {
      // RC-5: Check nativeProxy first. When a native proxy (e.g.,
      // _InterpretedTickerProviderState) wraps the InterpretedInstance,
      // return it directly if it satisfies T. This avoids creating a new
      // delegation wrapper when the proxy already implements the interface.
      final proxy = arg.nativeProxy;
      if (proxy != null && proxy is T) {
        return proxy as T;
      }

      final superObj = arg.bridgedSuperObject;
      // RC-7: Check superObj != null before returning, otherwise a null
      // bridgedSuperObject (from abstract classes like CustomPainter) would
      // match nullable T (e.g., CustomPainter?) and skip proxy resolution.
      if (superObj != null && superObj is T) {
        // 1401-TODO #7 (F9): record the native↔interpreted mapping so
        // later property assignments on this native object can route
        // back to script-defined fields/setters. See
        // [_nativeToInterpreted].
        registerInterpretedForNative(superObj, arg);
        return superObj as T;
      }
      // RC-6b: After superObj fails the `is T` check (e.g., Tween<dynamic>
      // is not Animatable<double> due to reified generics), try the generic
      // wrapper resolution on superObj. The relaxer factory can wrap the
      // native object in a properly typed proxy.
      if (superObj != null && _genericTypeWrappers.isNotEmpty) {
        final wrapped = _tryGenericWrapperResolution<T>(superObj);
        if (wrapped != null) return wrapped;
      }
      // RC-1: Try registered interface proxy factories.
      // For abstract classes/interfaces (CustomClipper, TickerProvider),
      // bridgedSuperObject may be null. Use a proxy factory to create a
      // native delegate that calls back into the interpreter.
      final effectiveVisitor = visitor ?? _activeVisitor;
      if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
        final proxyResult =
            tryCreateInterfaceProxyWithVisitor<T>(arg, effectiveVisitor);
        if (proxyResult != null) {
          if (usageLogEnabled) {
            recordUsageHit('proxy', _baseTypeName(T.toString()), arg.klass.name);
          }
          return proxyResult;
        }
      }
    }

    // RC-3: Cross-package type coercion.
    // When the unwrapped value has the same conceptual type but from a
    // different package (e.g., painting.TextStyle vs dart:ui.TextStyle),
    // use a registered coercion to convert.
    if (unwrapped != null && _typeCoercionsByType.isNotEmpty) {
      final sourceType = unwrapped.runtimeType;
      for (final entry in _typeCoercionsByType.entries) {
        if (entry.key.sourceType == sourceType) {
          final coerced = entry.value(unwrapped);
          if (coerced is T) {
            if (usageLogEnabled) {
              recordUsageHit(
                'coercion',
                _baseTypeName(T.toString()),
                sourceType.toString(),
              );
            }
            return coerced;
          }
        }
      }
    }

    // P&R#3: last-resort lookup against user-registered relaxer factories,
    // covering non-generic target types the inlined relaxer path skips. Runs
    // only here on the about-to-throw path, so it is strictly additive.
    final userResolved = _tryUserFactoryResolution<T>(unwrapped);
    if (userResolved != null) return userResolved;

    if (usageLogEnabled) {
      final tStr = T.toString();
      recordUsageMiss(_baseTypeName(tStr), _innerTypeArg(tStr));
    }
    final actualType = arg is BridgedInstance
        ? arg.nativeObject.runtimeType
        : arg is InterpretedInstance
            ? 'InterpretedInstance(${arg.klass.name})'
            : arg.runtimeType;
    throw ArgumentD4rtException(
      _missingBridgeResolutionMessage(paramName, T.toString(), actualType),
    );
  }

  /// Extract a typed value from a BridgedInstance or native object,
  /// returning null if the argument is null.
  ///
  /// Handles both wrapped (BridgedInstance) and unwrapped (native) objects.
  /// Throws ArgumentError if the type doesn't match (and is non-null).
  static T? extractBridgedArgOrNull<T>(Object? arg, String paramName,
      [InterpreterVisitor? visitor]) {
    if (arg == null) return null;
    return extractBridgedArg<T>(arg, paramName, visitor);
  }

  // ==========================================================================
  // Positional Argument Helpers
  // ==========================================================================

  /// Get a required positional argument with type checking.
  ///
  /// Throws ArgumentError if the argument is missing or has wrong type.
  static T getRequiredArg<T>(
    List<Object?> positional,
    int index,
    String paramName,
    String methodName,
  ) {
    if (positional.length <= index) {
      throw ArgumentD4rtException(
        '$methodName: Missing required argument "$paramName" at position $index. '
        'Expected at least ${index + 1} arguments, got ${positional.length}',
      );
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Get an optional positional argument with type checking.
  ///
  /// Returns null if the argument is missing, throws if wrong type.
  static T? getOptionalArg<T>(
    List<Object?> positional,
    int index,
    String paramName,
  ) {
    if (positional.length <= index || positional[index] == null) {
      return null;
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Get an optional positional argument with default value.
  ///
  /// Returns defaultValue if missing, throws if present but wrong type.
  static T getOptionalArgWithDefault<T>(
    List<Object?> positional,
    int index,
    String paramName,
    T defaultValue,
  ) {
    if (positional.length <= index || positional[index] == null) {
      return defaultValue;
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  // ==========================================================================
  // Named Argument Helpers
  // ==========================================================================

  /// Get a required named argument with type checking.
  ///
  /// Throws [ArgumentD4rtException] if the argument is missing.
  /// For nullable required parameters (e.g., `required bool? value`),
  /// null is a valid value — only absence is an error.
  static T getRequiredNamedArg<T>(
    Map<String, Object?> named,
    String paramName,
    String methodName,
  ) {
    if (!named.containsKey(paramName)) {
      throw ArgumentD4rtException(
        '$methodName: Missing required named argument "$paramName"',
      );
    }
    final value = named[paramName];
    if (value == null) return null as T;
    return extractBridgedArg<T>(value, paramName);
  }

  /// Get an optional named argument with type checking.
  ///
  /// Returns null if missing, throws if present but wrong type.
  static T? getOptionalNamedArg<T>(
    Map<String, Object?> named,
    String paramName,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      return null;
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }

  /// Get an optional named argument with default value.
  ///
  /// Returns `defaultValue` only when the key is **absent** from `named`.
  /// When the key is present with an explicit `null`:
  ///   • if `T` is nullable, returns `null` (the script's intent — Flutter
  ///     uses `null` as a sentinel in several APIs, e.g. `TextField.maxLines:
  ///     null` meaning "grow without bound"). The constructor default must
  ///     not be substituted in that case.
  ///   • if `T` is non-nullable, falls back to `defaultValue` (an explicit
  ///     null on a non-nullable param is treated as an omission).
  /// Throws if present but the wrong runtime type.
  ///
  /// Bug §G1 (2026-05-04): the prior implementation treated "key absent"
  /// and "explicit null" identically — `!containsKey || value == null →
  /// defaultValue` — which silently rewrote `maxLines: null` to `1` and
  /// triggered Flutter's `(maxLines == null) || (minLines == null) ||
  /// (maxLines >= minLines)` assertion when paired with `minLines >= 2`.
  static T getNamedArgWithDefault<T>(
    Map<String, Object?> named,
    String paramName,
    T defaultValue,
  ) {
    if (!named.containsKey(paramName)) {
      return defaultValue;
    }
    final value = named[paramName];
    if (value == null) {
      // Distinguish nullable T from non-nullable T at runtime:
      // `null is T` is true iff T accepts null.
      if (null is T) {
        return null as T;
      }
      return defaultValue;
    }
    return extractBridgedArg<T>(value, paramName);
  }

  // ==========================================================================
  // Argument Count Validation
  // ==========================================================================

  /// Verify minimum positional arguments count.
  ///
  /// Throws ArgumentError if not enough arguments.
  static void requireMinArgs(
    List<Object?> positional,
    int minCount,
    String methodName,
  ) {
    if (positional.length < minCount) {
      throw ArgumentD4rtException(
        '$methodName expects at least $minCount argument(s), got ${positional.length}',
      );
    }
  }

  /// Verify exact positional arguments count.
  ///
  /// Throws ArgumentError if wrong number of arguments.
  static void requireExactArgs(
    List<Object?> positional,
    int count,
    String methodName,
  ) {
    if (positional.length != count) {
      throw ArgumentD4rtException(
        '$methodName expects exactly $count argument(s), got ${positional.length}',
      );
    }
  }

  // ==========================================================================
  // Target Validation
  // ==========================================================================

  /// Validate target type for instance methods/getters.
  ///
  /// Throws ArgumentError if target is not the expected type.
  static T validateTarget<T>(Object? target, String typeName) {
    if (target is T) {
      return target;
    }
    throw ArgumentD4rtException(
      'Invalid target: expected $typeName, got ${target?.runtimeType}',
    );
  }

  // ==========================================================================
  // Non-Wrappable Default Helpers
  // ==========================================================================

  /// Helper for parameters with non-wrappable defaults.
  ///
  /// The original Dart code has a default value that cannot be expressed in the
  /// bridge (e.g., class static members, private constants, complex expressions).
  /// This forces the caller to provide a value at runtime.
  ///
  /// Throws ArgumentError if the value is null.
  static T getRequiredArgTodoDefault<T>(
    List<Object?> positional,
    int index,
    String paramName,
    String methodName,
    String originalDefault,
  ) {
    if (positional.length <= index || positional[index] == null) {
      throw ArgumentD4rtException(
        '$methodName: Parameter "$paramName" has non-wrappable default ($originalDefault). '
        'Value must be specified but was null.',
      );
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Helper for named parameters with non-wrappable defaults.
  ///
  /// The original Dart code has a default value that cannot be expressed in the
  /// bridge (e.g., class static members, private constants, complex expressions).
  /// This forces the caller to provide a value at runtime.
  ///
  /// Throws ArgumentError if the value is null.
  static T getRequiredNamedArgTodoDefault<T>(
    Map<String, Object?> named,
    String paramName,
    String methodName,
    String originalDefault,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      throw ArgumentD4rtException(
        '$methodName: Parameter "$paramName" has non-wrappable default ($originalDefault). '
        'Value must be specified but was null.',
      );
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }

  // ==========================================================================
  // Callback Invocation
  // ==========================================================================

  /// GEN-110: Wrap a [Callable] (typically an [InterpretedFunction]) as a
  /// native Dart function value, so it can be passed to native code that
  /// expects a typed `Function` argument — e.g. `VoidCallback`,
  /// `ValueChanged<T>`, `StateSetter`, `(BuildContext) => Widget`.
  ///
  /// Used by `visitMethodInvocation` / `visitFunctionExpressionInvocation`
  /// at the `Function.apply(...)` fallback. Without this wrapping the
  /// underlying Dart runtime throws
  ///   `type 'InterpretedFunction' is not a subtype of type '() => void'`
  /// because the interpreter's `Callable.call` signature
  /// (`(visitor, positional, [named, typeArgs])`) doesn't match any
  /// native function type. The arity of the wrapper matches the
  /// Callable's declared required-positional count.
  ///
  /// Returns the value unchanged when it isn't a Callable, so callers can
  /// pass every positional arg through this without case-checking.
  static Object? coerceCallableToFunction(
      InterpreterVisitor visitor, Object? value) {
    if (value is! Callable) return value;
    final n = value.arity;
    switch (n) {
      case 0:
        return () => callInterpreterCallback(visitor, value, const []);
      case 1:
        return (a) => callInterpreterCallback(visitor, value, [a]);
      case 2:
        return (a, b) => callInterpreterCallback(visitor, value, [a, b]);
      case 3:
        return (a, b, c) =>
            callInterpreterCallback(visitor, value, [a, b, c]);
      case 4:
        return (a, b, c, d) =>
            callInterpreterCallback(visitor, value, [a, b, c, d]);
      default:
        // Best-effort variable-arity fallback. Most Flutter callbacks top
        // out at 4 args; this branch keeps less common 5+-arg signatures
        // working at the cost of nullable parameter types.
        return ([p0, p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
          final args = <Object?>[];
          for (final p in [p0, p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
            if (p == null) break;
            args.add(p);
          }
          return callInterpreterCallback(visitor, value, args);
        };
    }
  }

  /// Call an interpreter callback that may be either an InterpretedFunction
  /// or a NativeFunction.
  ///
  /// G-DCLI-07 FIX: When bridge code needs to invoke a callback parameter
  /// (e.g., `forEach(print)`), the callback may be a NativeFunction (like `print`)
  /// or an InterpretedFunction (user-defined lambda). This method handles both.
  ///
  /// The result is automatically unwrapped: [BridgedInstance] returns its
  /// [BridgedInstance.nativeObject], [BridgedEnumValue] returns its
  /// [BridgedEnumValue.nativeValue], and all other values pass through.
  /// This ensures generated bridge code casts (e.g., `as Widget`) succeed
  /// when the interpreter returns wrapped bridge values.
  ///
  /// Returns the unwrapped native result of calling the callback.
  static Object? callInterpreterCallback(
    InterpreterVisitor visitor,
    Object? callback,
    List<Object?> args, [
    Map<String, Object?> namedArgs = const {},
  ]) {
    final Object? result;
    if (callback is InterpretedFunction) {
      result = callback.call(visitor, args, namedArgs);
    } else if (callback is NativeFunction) {
      result = callback.call(visitor, args, namedArgs);
    } else if (callback is Callable) {
      result = callback.call(visitor, args, namedArgs);
    } else if (callback is Function) {
      // 1401-TODO #8 (F5/F6): plain native Dart function. Happens when
      // the framework hands a typed callback (e.g. `TickerCallback =
      // void Function(Duration)`) to a script method via the bridge,
      // and the script forwards it unchanged to another bridge
      // constructor (e.g. `Ticker(onTick)`). The Ticker bridge wraps
      // it in `callInterpreterCallback`, which at tick time receives
      // the original native Dart closure — not wrapped as
      // InterpretedFunction/NativeFunction/Callable. `Function.apply`
      // dispatches by Dart Function signature; named args are
      // re-keyed to Symbols (Dart's `Function.apply` requires
      // `Map<Symbol, dynamic>?`).
      final Map<Symbol, dynamic>? symbolNamedArgs;
      if (namedArgs.isEmpty) {
        symbolNamedArgs = null;
      } else {
        symbolNamedArgs = {
          for (final entry in namedArgs.entries) Symbol(entry.key): entry.value,
        };
      }
      result = Function.apply(callback, args, symbolNamedArgs);
    } else {
      throw ArgumentD4rtException(
        'Expected a callable function, got ${callback?.runtimeType}',
      );
    }
    return unwrapInterpreterValue(result);
  }

  /// ENG-011: Safely cast a callback result to the expected type [R].
  ///
  /// This handles the case where a generic method callback may return null
  /// but the expected type [R] may or may not be nullable. For example,
  /// `SynchronousFuture.then<R>()` where `R` could be `String` (non-nullable)
  /// or `String?` (nullable).
  ///
  /// Usage in generated bridge code:
  /// ```dart
  /// return t.then((p0) {
  ///   final result = D4.callInterpreterCallback(visitor!, fn, [p0]);
  ///   return D4.castCallbackResult<R>(result);
  /// });
  /// ```
  static R castCallbackResult<R>(Object? result) {
    if (result == null) {
      // Check if R accepts null (i.e., R is nullable like `String?`)
      // The `null is R` test returns true for nullable types.
      if (null is R) {
        return null as R;
      }
      throw ArgumentD4rtException(
        'Callback returned null but expected non-nullable type',
      );
    }
    // Attempt to cast to R - explicit cast needed for AOT
    if (result is R) {
      return result as R;
    }
    // If direct cast fails, try unwrapping bridge values
    final unwrapped = unwrapInterpreterValue(result);
    if (unwrapped is R) {
      // ignore: unnecessary_cast
      return unwrapped as R; // Explicit cast for AOT
    }
    throw ArgumentD4rtException(
      'Callback returned ${result.runtimeType}, expected $R',
    );
  }

  /// Unwrap an interpreter value to its native representation.
  ///
  /// - [BridgedInstance] → [BridgedInstance.nativeObject]
  /// - [BridgedEnumValue] → [BridgedEnumValue.nativeValue]
  /// - All other values (null, String, num, bool, List, Map, etc.)
  ///   pass through unchanged.
  ///
  /// Note: Lists and Maps are NOT recursively unwrapped because doing so
  /// destroys Dart's reified generic type information. For example,
  /// `Map<String, String>` would become `Map<Object?, Object?>` after
  /// `.map()`. If a callback returns a List/Map containing BridgedInstance
  /// values, the generated bridge code must handle the element-level
  /// unwrapping explicitly.
  static Object? unwrapInterpreterValue(Object? value) {
    if (value is BridgedInstance) {
      return value.nativeObject;
    }
    if (value is BridgedEnumValue) {
      return value.nativeValue;
    }
    return value;
  }

  /// Unwrap an interpreter result to the requested native type [T].
  ///
  /// This is the canonical lift-and-cast helper used by embedders that need
  /// a typed native value out of a value produced by `executeBundle`,
  /// `eval`, or any bridge-boundary callback. It consolidates the three
  /// scattered unwrap paths previously open-coded in `FlutterD4rt._unwrap`,
  /// generated bridge adapters, and ad-hoc embedder code.
  ///
  /// Behaviour:
  /// 1. `null` → returned as-is when `null is T` (i.e. `T` is nullable);
  ///    otherwise throws [D4UnwrapException].
  /// 2. [BridgedInstance] → returns [BridgedInstance.nativeObject] cast to
  ///    [T] when assignable; otherwise throws [D4UnwrapException].
  /// 3. [BridgedEnumValue] → returns [BridgedEnumValue.nativeValue] cast to
  ///    [T] when assignable; otherwise throws [D4UnwrapException].
  /// 4. [InterpretedInstance] → returns
  ///    [InterpretedInstance.bridgedSuperObject] when it is a `T`, or asks
  ///    the active visitor to construct an interface proxy via
  ///    [tryCreateInterfaceProxyWithVisitor]. Falls back to
  ///    [D4.activeVisitor] when [visitor] is null. Throws
  ///    [D4UnwrapException] when no proxy can be produced.
  /// 5. Any other value that already `is T` is returned as-is.
  /// 6. Otherwise throws [D4UnwrapException].
  ///
  /// [expectedDescription] overrides the default `T.toString()` in
  /// generated error messages — useful when the calling context already
  /// knows a more specific description than the type system can express
  /// (e.g. `'Widget (top-level build result)'`).
  static T unwrapAs<T>(
    Object? value, {
    InterpreterVisitor? visitor,
    String? expectedDescription,
  }) {
    final expected = expectedDescription ?? T.toString();

    if (value == null) {
      if (null is T) return null as T;
      throw D4UnwrapException(
        expectedType: expected,
        actualType: 'null',
      );
    }

    if (value is BridgedInstance) {
      final native = value.nativeObject;
      if (native is T) return native as T;
      throw D4UnwrapException(
        expectedType: expected,
        actualType: native.runtimeType.toString(),
        source: 'BridgedInstance<${value.bridgedClass.name}>',
      );
    }

    if (value is BridgedEnumValue) {
      final native = value.nativeValue;
      if (native is T) return native as T;
      throw D4UnwrapException(
        expectedType: expected,
        actualType: native.runtimeType.toString(),
        source: 'BridgedEnumValue',
      );
    }

    if (value is T) return value as T;

    if (value is InterpretedInstance) {
      final bridgedSuper = value.bridgedSuperObject;
      if (bridgedSuper is T) return bridgedSuper;
      final effectiveVisitor = visitor ?? _activeVisitor;
      if (effectiveVisitor != null) {
        final proxy =
            tryCreateInterfaceProxyWithVisitor<T>(value, effectiveVisitor);
        if (proxy != null) return proxy;
      }
      throw D4UnwrapException(
        expectedType: expected,
        actualType: 'InterpretedInstance(${value.klass.name})',
        source: 'InterpretedInstance',
        extra: 'no registered interface proxy for its bridged '
            'superclass/interfaces',
      );
    }

    throw D4UnwrapException(
      expectedType: expected,
      actualType: value.runtimeType.toString(),
    );
  }

  // ==========================================================================
  // RC-1: Interface Proxy Helpers
  // ==========================================================================

  /// Try to create an interface proxy with a visitor context.
  ///
  /// This is the full version that can actually create proxies.
  /// Called from contexts where the visitor is available.
  static T? tryCreateInterfaceProxyWithVisitor<T>(
    InterpretedInstance instance,
    InterpreterVisitor visitor,
  ) {
    // Walk the interpreted superclass chain plus all interpreted mixins and
    // interpreted interfaces, collecting bridgedSuperclass / bridgedInterfaces
    // / bridgedMixins plus transitively-registered supertypes at every level.
    // Mirrors tom_d4rt_ast (Bug-102b/c, Cluster-18).
    //
    // Cluster-18 (bucket #8): scripts may use an interpreted mixin to satisfy
    // a bridged interface, e.g.
    //   mixin _TickerProviderShim<T extends StatefulWidget> on State<T>
    //       implements TickerProvider { ... }
    //   class _DemoState extends State<...> with _TickerProviderShim
    // Without recursing into `walk.mixins` and `walk.interfaces`, the bridged
    // contributions of the interpreted mixin (here TickerProvider) are
    // invisible to proxy resolution.
    final seen = <String>{};
    final candidates = <String>[];
    void add(String n) {
      if (seen.add(n)) candidates.add(n);
    }
    void addBridged(BridgedClass bc) {
      add(bc.name);
      for (final s in BridgedClass.transitiveSupertypeNames(bc.name)) {
        add(s);
      }
    }

    final visitedClasses = <InterpretedClass>{};
    void collectFromInterpreted(InterpretedClass? c) {
      if (c == null) return;
      if (!visitedClasses.add(c)) return;
      if (c.bridgedSuperclass != null) {
        addBridged(c.bridgedSuperclass!);
      }
      for (final iface in c.bridgedInterfaces) {
        addBridged(iface);
      }
      for (final mixin in c.bridgedMixins) {
        addBridged(mixin);
      }
      // Recurse into interpreted ancestors so an interpreted mixin's or
      // interface's bridged contributions are also discovered.
      collectFromInterpreted(c.superclass);
      for (final m in c.mixins) {
        collectFromInterpreted(m);
      }
      for (final i in c.interfaces) {
        collectFromInterpreted(i);
      }
    }

    collectFromInterpreted(instance.klass);

    for (final name in candidates) {
      final factory = _interfaceProxies[name];
      if (factory != null) {
        final proxy = factory(visitor, instance);
        if (proxy is T) return proxy;
      }
    }

    return null;
  }

  /// Try to create an interface proxy keyed by the bridged-type name.
  ///
  /// Step 3 (1449 plan): bridged-mixin dispatch needs a way to obtain a
  /// native shadow for the *specific* mixin being dispatched, without
  /// type-driven inference. The dispatcher knows `bridgedMixinName` as a
  /// string (e.g. `'DiagnosticableTreeMixin'`) — this helper looks up the
  /// factory registered with that exact name and invokes it. The caller is
  /// responsible for any subsequent `is`/`as` check against the expected
  /// native type.
  ///
  /// Returns the proxy if a factory is registered, otherwise `null`.
  static Object? tryCreateInterfaceProxyByName(
    String bridgedTypeName,
    InterpretedInstance instance,
    InterpreterVisitor visitor,
  ) {
    final factory = _interfaceProxies[bridgedTypeName];
    if (factory == null) return null;
    return factory(visitor, instance);
  }
}

// =============================================================================
// D4UserBridge Base Class
// =============================================================================

/// Base class for user-defined bridge overrides.
///
/// Extend this class to provide custom implementations for specific bridge
/// members that the generator cannot handle correctly (e.g., operators,
/// complex generics, or classes needing `nativeNames`).
///
/// This is a marker class - extending it tells the generator:
/// 1. This class should be excluded from bridge generation
/// 2. Static methods matching the override naming convention should be used
///
/// ## Naming Convention
///
/// Create a class named `{ClassName}UserBridge` that extends `D4UserBridge`:
///
/// ```dart
/// class MyListUserBridge extends D4UserBridge {
///   // Static override methods...
/// }
/// ```
///
/// ## Override Methods (all must be static)
///
/// | Member Type | Static Override Method |
/// |-------------|------------------------|
/// | Constructor `Foo()` | `static overrideConstructor(...)` |
/// | Constructor `Foo.named()` | `static overrideConstructorNamed(...)` |
/// | Getter `value` | `static overrideGetterValue(...)` |
/// | Setter `value=` | `static overrideSetterValue(...)` |
/// | Method `doWork()` | `static overrideMethodDoWork(...)` |
/// | Static getter | `static overrideStaticGetterName(...)` |
/// | Static setter | `static overrideStaticSetterName(...)` |
/// | Static method | `static overrideStaticMethodName(...)` |
/// | Operator `[]` | `static overrideOperatorIndex(...)` |
/// | Operator `[]=` | `static overrideOperatorIndexAssign(...)` |
/// | Operator `+` | `static overrideOperatorPlus(...)` |
///
/// ## Special Properties
///
/// - `nativeNames`: Define as a static getter to provide internal type names
///
/// ## Example
///
/// ```dart
/// class MyListUserBridge extends D4UserBridge {
///   /// Map internal List implementations to this bridge.
///   static List<String> get nativeNames => ['_GrowableList', '_FixedLengthList'];
///
///   /// Override operator[] - not auto-generated.
///   static Object? overrideOperatorIndex(
///     Object? visitor,
///     Object? target,
///     List<Object?> positional,
///     Map<String, Object?> named,
///   ) {
///     final list = D4.validateTarget<MyList>(target, 'MyList');
///     final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
///     return list[index];
///   }
/// }
/// ```
///
/// The generator will:
/// 1. Detect `MyListUserBridge` extending `D4UserBridge`
/// 2. Skip `MyListUserBridge` from bridge generation
/// 3. For class `MyList`, check if `MyListUserBridge` exists
/// 4. Use `MyListUserBridge.overrideOperatorIndex` instead of generating `[]`
/// 5. Use `MyListUserBridge.nativeNames` in the generated `BridgedClass`
abstract class D4UserBridge {
  // Empty marker class - all override methods in subclasses must be static
}

/// Base class for user-provided relaxer factories.
///
/// Extend this class to add type argument cases to existing auto-generated
/// relaxer wrappers, or to register entirely new wrapper classes for generic
/// types not covered by generation.
///
/// Classes extending [D4UserRelaxer] are automatically excluded from bridge
/// generation (same as [D4UserBridge]).
///
/// Example:
/// ```dart
/// class ValueNotifierUserRelaxer extends D4UserRelaxer {
///   @override
///   String get baseTypeName => 'ValueNotifier';
///
///   static Object? relaxFactory(Object value, String innerTypeArg) {
///     if (value is! ValueNotifier) return null;
///     return switch (innerTypeArg) {
///       'MyCustomModel' => $RelaxedValueNotifier<MyCustomModel>(value),
///       _ => null,
///     };
///   }
/// }
/// ```
abstract class D4UserRelaxer {
  /// The unparameterized base type name this relaxer targets.
  /// E.g., 'ValueNotifier', 'Animation', 'ReactiveStream'.
  String get baseTypeName;
}

// =============================================================================
// C35: Typed-Cast Iterator helpers used by extractBridgedArg<Iterator<T>>.
// =============================================================================

/// Lazy element-wise cast wrapper around an arbitrary [Iterator].
///
/// The interpreter materializes typed list literals as `List<Object?>` so
/// `<int>[1, 2, 3].iterator` arrives at a bridge constructor as
/// `ListIterator<Object?>`. Reified generics then reject it against
/// `Iterator<int>`. [_CastIterator] satisfies the strict type without copying
/// by casting each `current` element on access — same idea as
/// `Iterable.cast<T>().iterator`, but for a bare iterator.
class _CastIterator<T> implements Iterator<T> {
  final Iterator _source;
  _CastIterator(this._source);

  @override
  T get current => _source.current as T;

  @override
  bool moveNext() => _source.moveNext();
}

/// `Iterator<Object?> → Iterator<double>` with `int → double` promotion
/// on the fly. Mirrors the int-to-double promotion the List branch already
/// performs for `<double>[1, 2, 3]`-style literals.
class _PromotingDoubleIterator implements Iterator<double> {
  final Iterator _source;
  _PromotingDoubleIterator(this._source);

  @override
  double get current {
    final value = _source.current;
    return value is int ? value.toDouble() : value as double;
  }

  @override
  bool moveNext() => _source.moveNext();
}

// =============================================================================
// RC-3: Type Pair Key for Coercion Map
// =============================================================================

/// Key for the type coercion map, pairing source and target [Type] objects.
class _TypePair {
  final Type sourceType;
  final Type targetType;

  const _TypePair(this.sourceType, this.targetType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TypePair &&
          sourceType == other.sourceType &&
          targetType == other.targetType;

  @override
  int get hashCode => Object.hash(sourceType, targetType);
}
