/// D4rt State-proxy variant generator (`mixinVariants`).
///
/// Some interpreted `State` subclasses declare a real Flutter mixin
/// (`SingleTickerProviderStateMixin`, `TickerProviderStateMixin`,
/// `RestorationMixin`, `AutomaticKeepAliveClientMixin`). Those mixins carry
/// native overrides (`createTicker`, `didChangeDependencies`/`restoreState`,
/// the `KeepAliveNotification` dispatch in `build`) that *must* run on the
/// real `State` object — Dart cannot graft a mixin onto a class at runtime.
/// So the native proxy that the framework mounts has to actually
/// `with`-mix the corresponding mixin.
///
/// Historically each variant was hand-written as a ~150-line near-verbatim
/// copy of the plain `_InterpretedState` proxy (differing only in the `with`
/// clause and a small per-mixin extra-override slot), once in
/// `tom_d4rt_flutter` and again in `tom_d4rt_flutter_ast` — and the web twin
/// had drifted (it was missing the `AutomaticKeepAliveClientMixin` variant).
/// This emitter replaces all of them with a single parameterized template:
/// the Bug-46 re-entrancy-guarded lifecycle set plus a per-mixin
/// extra-override slot.
///
/// The emitter is a pure function over [StateProxyVariantSpec] so its output
/// can be golden-pinned in unit tests. It is dormant by default
/// ([ProxyClassConfig.mixinVariants] defaults empty); wiring the regenerated
/// output into the twins and removing the hand-written classes is a separate,
/// serially-gated step (see `deferred.d4rt.md`).
library;

import 'bridge_config.dart' show ProxyClassConfig;

/// The per-mixin extra overrides a State proxy variant must carry on top of
/// the common lifecycle skeleton.
enum StateProxyExtra {
  /// No extra overrides — the plain `_InterpretedState` shape.
  none,

  /// `RestorationMixin` → `restorationId` getter + `restoreState` override.
  restoration,

  /// `AutomaticKeepAliveClientMixin` → `wantKeepAlive` getter and a
  /// `super.build(context)` prefix inside `build` so the mixin can dispatch
  /// its `KeepAliveNotification`.
  keepAlive,
}

/// Describes one generated State-proxy variant: the class name, the optional
/// `with` mixin clause, and which per-mixin extra overrides to emit.
class StateProxyVariantSpec {
  /// The generated proxy class name (e.g. `_InterpretedState`).
  final String className;

  /// The `with` clause body, or `null` for the plain (no-mixin) variant.
  /// E.g. `SingleTickerProviderStateMixin` or
  /// `RestorationMixin<_InterpretedStatefulWidget>`.
  final String? mixinClause;

  /// Which per-mixin extra overrides to emit.
  final StateProxyExtra extra;

  const StateProxyVariantSpec({
    required this.className,
    this.mixinClause,
    this.extra = StateProxyExtra.none,
  });

  /// The plain `State` proxy carrying no mixin.
  static const StateProxyVariantSpec plain = StateProxyVariantSpec(
    className: '_InterpretedState',
  );
}

/// Maps a known bridged State-mixin name to its variant spec. Returns `null`
/// for an unrecognised mixin name (the caller should warn and skip — emitting
/// an arbitrary mixin clause risks an uncompilable proxy).
StateProxyVariantSpec? stateProxyVariantSpecFor(String mixinName) {
  switch (mixinName) {
    case 'SingleTickerProviderStateMixin':
      return const StateProxyVariantSpec(
        className: '_InterpretedSingleTickerProviderState',
        mixinClause: 'SingleTickerProviderStateMixin',
      );
    case 'TickerProviderStateMixin':
      return const StateProxyVariantSpec(
        className: '_InterpretedMultiTickerProviderState',
        mixinClause: 'TickerProviderStateMixin',
      );
    case 'RestorationMixin':
      return const StateProxyVariantSpec(
        className: '_InterpretedRestorationMixinState',
        mixinClause: 'RestorationMixin<_InterpretedStatefulWidget>',
        extra: StateProxyExtra.restoration,
      );
    case 'AutomaticKeepAliveClientMixin':
      return const StateProxyVariantSpec(
        className: '_InterpretedKeepAliveState',
        mixinClause: 'AutomaticKeepAliveClientMixin',
        extra: StateProxyExtra.keepAlive,
      );
    default:
      return null;
  }
}

/// Emits the full State-proxy family for a `State` [ProxyClassConfig]: the
/// plain variant followed by one variant per recognised name in
/// [ProxyClassConfig.mixinVariants], in declaration order.
///
/// Unrecognised mixin names are reported through [warn] and skipped.
String generateStateProxyFamily(
  ProxyClassConfig config, {
  void Function(String message)? warn,
}) {
  final buffer = StringBuffer();
  buffer.write(generateStateProxyVariant(StateProxyVariantSpec.plain));
  for (final mixinName in config.mixinVariants) {
    final spec = stateProxyVariantSpecFor(mixinName);
    if (spec == null) {
      warn?.call(
        'Unknown State mixinVariant "$mixinName" — no proxy variant emitted. '
        'Add a mapping in stateProxyVariantSpecFor to support it.',
      );
      continue;
    }
    buffer.writeln();
    buffer.write(generateStateProxyVariant(spec));
  }
  return buffer.toString();
}

/// Emits a single State-proxy variant class for [spec].
///
/// Every variant carries the same Bug-46 re-entrancy-guarded lifecycle set
/// (`initState`, `didChangeDependencies`, `didUpdateWidget`, `deactivate`,
/// `dispose`) and the interpreted `build` delegation; [spec] selects the
/// `with` clause and the per-mixin extra overrides.
String generateStateProxyVariant(StateProxyVariantSpec spec) {
  final b = StringBuffer();
  final mixinNote = spec.mixinClause == null
      ? '.'
      : ', mixing in [${spec.mixinClause!.split('<').first}].';

  b.writeln('/// A native [State] proxy that delegates lifecycle methods to an');
  b.writeln('/// interpreted D4rt State subclass$mixinNote');
  b.writeln('///');
  b.writeln('/// Generated by the d4rtgen proxy generator (mixinVariants).');
  b.writeln('/// Each lifecycle override is wrapped in a Bug-46 re-entrancy guard');
  b.writeln('/// so a script body that calls `super.initState()` (etc.) does not');
  b.writeln('/// recurse back into the proxy indefinitely.');

  if (spec.mixinClause == null) {
    b.writeln('class ${spec.className} extends State<_InterpretedStatefulWidget>');
    b.writeln('    implements D4InterpretedProxy {');
  } else {
    b.writeln('class ${spec.className}');
    b.writeln('    extends State<_InterpretedStatefulWidget>');
    b.writeln('    with ${spec.mixinClause}');
    b.writeln('    implements D4InterpretedProxy {');
  }

  b.writeln('  final InterpreterVisitor _visitor;');
  b.writeln('  final InterpretedInstance _stateInstance;');
  b.writeln();
  b.writeln('  ${spec.className}(this._visitor, this._stateInstance);');
  b.writeln();
  b.writeln('  @override');
  b.writeln('  Object get d4rtInstance => _stateInstance;');
  b.writeln();

  if (spec.extra == StateProxyExtra.restoration) {
    _writeRestorationExtras(b);
  }
  if (spec.extra == StateProxyExtra.keepAlive) {
    _writeKeepAliveGetter(b);
  }

  _writeGuardedVoidLifecycle(b, 'initState', superFirst: true);
  b.writeln();
  _writeGuardedVoidLifecycle(b, 'didChangeDependencies', superFirst: true);
  b.writeln();
  _writeBuild(b, callSuperFirst: spec.extra == StateProxyExtra.keepAlive);
  b.writeln();
  _writeDidUpdateWidget(b);
  b.writeln();
  _writeGuardedVoidLifecycle(b, 'deactivate', superFirst: false);
  b.writeln();
  _writeGuardedVoidLifecycle(b, 'dispose', superFirst: false);
  b.writeln();
  _writeCallVoidMethod(b);
  b.writeln();
  b.writeln('  final Set<String> _lifecycleInProgress = <String>{};');
  b.writeln('}');

  return b.toString();
}

/// Writes a Bug-46-guarded `void` lifecycle override. When [superFirst] the
/// native `super.<name>()` runs before the interpreted body (the framework
/// posture for `initState`/`didChangeDependencies`); otherwise the
/// interpreted body runs before `super` (the teardown posture for
/// `deactivate`/`dispose`).
void _writeGuardedVoidLifecycle(
  StringBuffer b,
  String name, {
  required bool superFirst,
}) {
  b.writeln('  @override');
  b.writeln('  void $name() {');
  b.writeln("    if (_lifecycleInProgress.contains('$name')) return;");
  b.writeln("    _lifecycleInProgress.add('$name');");
  b.writeln('    try {');
  if (superFirst) {
    b.writeln('      super.$name();');
    b.writeln("      _callVoidMethod('$name');");
  } else {
    b.writeln("      _callVoidMethod('$name');");
    b.writeln('      super.$name();');
  }
  b.writeln('    } finally {');
  b.writeln("      _lifecycleInProgress.remove('$name');");
  b.writeln('    }');
  b.writeln('  }');
}

/// Writes the interpreted `build` delegation. When [callSuperFirst] (the
/// `AutomaticKeepAliveClientMixin` variant), `super.build(context)` runs first
/// so the mixin can dispatch its `KeepAliveNotification`.
void _writeBuild(StringBuffer b, {required bool callSuperFirst}) {
  b.writeln('  @override');
  b.writeln('  Widget build(BuildContext context) {');
  if (callSuperFirst) {
    b.writeln('    super.build(context);');
  }
  b.writeln("    final method = _stateInstance.klass.findInstanceMethod('build');");
  b.writeln('    if (method != null) {');
  b.writeln('      final bound = method.bind(_stateInstance);');
  b.writeln('      final result = bound.call(_visitor, [context], {});');
  b.writeln("      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);");
  b.writeln('    }');
  b.writeln('    throw StateError(');
  b.writeln(
      "      'Interpreted State \${_stateInstance.klass.name} does not implement build()',");
  b.writeln('    );');
  b.writeln('  }');
}

/// Writes the Bug-46-guarded `didUpdateWidget` override. Refreshes the
/// `interpretedStatefulWidget` shortcut and re-dispatches the interpreted
/// `didUpdateWidget` with the previous widget's interpreted instance.
void _writeDidUpdateWidget(StringBuffer b) {
  b.writeln('  @override');
  b.writeln('  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {');
  b.writeln("    if (_lifecycleInProgress.contains('didUpdateWidget')) return;");
  b.writeln("    _lifecycleInProgress.add('didUpdateWidget');");
  b.writeln('    try {');
  b.writeln('      super.didUpdateWidget(oldWidget);');
  b.writeln('      _stateInstance.interpretedStatefulWidget = widget._instance;');
  b.writeln('      final didUpdateMethod =');
  b.writeln("          _stateInstance.klass.findInstanceMethod('didUpdateWidget');");
  b.writeln('      if (didUpdateMethod != null) {');
  b.writeln('        try {');
  b.writeln('          didUpdateMethod');
  b.writeln('              .bind(_stateInstance)');
  b.writeln('              .call(_visitor, <Object?>[oldWidget._instance], {});');
  b.writeln('        } catch (_) {');
  b.writeln("          // Lifecycle methods may call super which isn't available in proxy.");
  b.writeln('        }');
  b.writeln('      }');
  b.writeln('    } finally {');
  b.writeln("      _lifecycleInProgress.remove('didUpdateWidget');");
  b.writeln('    }');
  b.writeln('  }');
}

/// Writes the `_callVoidMethod` helper used by the guarded lifecycle overrides.
void _writeCallVoidMethod(StringBuffer b) {
  b.writeln('  void _callVoidMethod(String name) {');
  b.writeln('    final method = _stateInstance.klass.findInstanceMethod(name);');
  b.writeln('    if (method != null) {');
  b.writeln('      try {');
  b.writeln('        method.bind(_stateInstance).call(_visitor, [], {});');
  b.writeln('      } catch (_) {');
  b.writeln("        // Lifecycle methods may call super which isn't available in proxy.");
  b.writeln('      }');
  b.writeln('    }');
  b.writeln('  }');
}

/// Writes the `RestorationMixin` extra overrides: the `restorationId` getter
/// (delegating to the interpreted getter/field) and the `restoreState`
/// override (dispatching to the interpreted `restoreState`, which calls
/// `registerForRestoration`).
void _writeRestorationExtras(StringBuffer b) {
  b.writeln('  @override');
  b.writeln('  String? get restorationId {');
  b.writeln("    final getter = _stateInstance.klass.findInstanceGetter('restorationId');");
  b.writeln('    if (getter != null) {');
  b.writeln('      try {');
  b.writeln('        final result = getter.bind(_stateInstance).call(_visitor, [], {});');
  b.writeln('        return result as String?;');
  b.writeln('      } catch (_) {');
  b.writeln('        // Fall through to field read.');
  b.writeln('      }');
  b.writeln('    }');
  b.writeln('    try {');
  b.writeln("      final value = _stateInstance.get('restorationId', visitor: _visitor);");
  b.writeln('      return value as String?;');
  b.writeln('    } catch (_) {');
  b.writeln('      return null;');
  b.writeln('    }');
  b.writeln('  }');
  b.writeln();
  b.writeln('  @override');
  b.writeln('  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {');
  b.writeln("    if (_lifecycleInProgress.contains('restoreState')) return;");
  b.writeln("    _lifecycleInProgress.add('restoreState');");
  b.writeln('    try {');
  b.writeln("      final method = _stateInstance.klass.findInstanceMethod('restoreState');");
  b.writeln('      if (method != null) {');
  b.writeln('        method');
  b.writeln('            .bind(_stateInstance)');
  b.writeln('            .call(_visitor, [oldBucket, initialRestore], {});');
  b.writeln('      }');
  b.writeln('    } finally {');
  b.writeln("      _lifecycleInProgress.remove('restoreState');");
  b.writeln('    }');
  b.writeln('  }');
  b.writeln();
}

/// Writes the `AutomaticKeepAliveClientMixin` `wantKeepAlive` getter. The
/// mixin declares it abstract, so the analyzer does not treat this as an
/// override (no `@override`). Defaults to `true` when the script declares the
/// mixin without overriding the getter.
void _writeKeepAliveGetter(StringBuffer b) {
  b.writeln('  bool get wantKeepAlive {');
  b.writeln("    final getter = _stateInstance.klass.findInstanceGetter('wantKeepAlive');");
  b.writeln('    if (getter != null) {');
  b.writeln('      try {');
  b.writeln('        final result = getter.bind(_stateInstance).call(_visitor, [], {});');
  b.writeln('        if (result is bool) return result;');
  b.writeln('      } catch (_) {');
  b.writeln('        // Fall through to default.');
  b.writeln('      }');
  b.writeln('    }');
  b.writeln('    return true;');
  b.writeln('  }');
  b.writeln();
}
