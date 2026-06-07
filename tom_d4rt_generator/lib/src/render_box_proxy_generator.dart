/// D4rt RenderBox-proxy variant generator (MCI#3 / A4 — RenderBox family).
///
/// Some interpreted `RenderBox` subclasses declare a real Flutter container
/// mixin (`ContainerRenderObjectMixin` + `RenderBoxContainerDefaultsMixin`, or
/// `SlottedContainerRenderObjectMixin`). Those mixins carry native plumbing
/// (`defaultPaint`/`defaultHitTestChildren`, the `_slotToChild` machinery,
/// `attach`/`detach`/`redepthChildren`/`visitChildren`) that *must* run on the
/// real `RenderObject` — Dart cannot graft a mixin onto a class at runtime. So
/// the native proxy that the framework mounts has to actually `with`-mix the
/// corresponding mixin, and the runtime factory has to choose the right proxy
/// shape by walking the script class's mixin chain
/// ([generateClassChainHasBridgedMixin]).
///
/// Historically each variant was hand-written as a ~150-line near-verbatim
/// copy of the plain `_InterpretedRenderBox` proxy (differing only in the
/// `with` clause and the `paint`/`hitTestChildren`/`setupParentData` bodies),
/// once in `tom_d4rt_flutter` and again in `tom_d4rt_flutter_ast`. This emitter
/// replaces all of them with a single parameterized template: the common
/// forwarding skeleton (`performLayout`, `paint`, `hitTest{,Self,Children}`,
/// `setupParentData`) plus per-variant body selection and a slotted-only
/// intrinsic-dimension slot.
///
/// The emitter is a pure function over [RenderBoxProxyVariantSpec] /
/// [ProxyClassConfig] so its output can be golden-pinned in unit tests. It is
/// dormant by default ([ProxyClassConfig.mixinVariants] defaults empty); wiring
/// the regenerated output into the twins, registering the runtime factory
/// selector, and removing the hand-written classes is a separate,
/// serially-gated step (see `todo_impossible.md`).
library;

import 'bridge_config.dart' show ProxyClassConfig;

/// Which RenderBox-proxy variant to emit. Each selects the `with` clause and
/// the `paint` / `hitTestChildren` / `setupParentData` bodies.
enum RenderBoxProxyVariant {
  /// Plain `RenderBox` proxy — no container mixin. Falls back to
  /// `super.paint` / `super.hitTestChildren` / `super.setupParentData`.
  plain,

  /// `ContainerRenderObjectMixin` + `RenderBoxContainerDefaultsMixin` proxy.
  /// Falls back to the mixin defaults (`defaultPaint` /
  /// `defaultHitTestChildren`).
  container,

  /// `SlottedContainerRenderObjectMixin` proxy. Falls back to a manual
  /// slot-child paint/hit-test walk and carries the intrinsic-dimension
  /// forwarders.
  slotted,
}

/// Describes one generated RenderBox-proxy variant: the class name and which
/// variant body/`with`-clause to emit.
class RenderBoxProxyVariantSpec {
  /// The generated proxy class name (e.g. `_InterpretedRenderBox`).
  final String className;

  /// Which variant body and mixin clause to emit.
  final RenderBoxProxyVariant variant;

  const RenderBoxProxyVariantSpec({
    required this.className,
    required this.variant,
  });

  /// The plain `RenderBox` proxy carrying no container mixin.
  static const RenderBoxProxyVariantSpec plain = RenderBoxProxyVariantSpec(
    className: '_InterpretedRenderBox',
    variant: RenderBoxProxyVariant.plain,
  );

  /// The `ContainerRenderObjectMixin` + `RenderBoxContainerDefaultsMixin`
  /// proxy.
  static const RenderBoxProxyVariantSpec container = RenderBoxProxyVariantSpec(
    className: '_InterpretedRenderBoxContainer',
    variant: RenderBoxProxyVariant.container,
  );

  /// The `SlottedContainerRenderObjectMixin` proxy.
  static const RenderBoxProxyVariantSpec slotted = RenderBoxProxyVariantSpec(
    className: '_InterpretedSlottedRenderBox',
    variant: RenderBoxProxyVariant.slotted,
  );
}

/// Maps a known bridged RenderBox container-mixin name to its variant spec.
/// Returns `null` for an unrecognised mixin name (the caller should warn and
/// skip — emitting an arbitrary mixin clause risks an uncompilable proxy).
RenderBoxProxyVariantSpec? renderBoxProxyVariantSpecFor(String mixinName) {
  switch (mixinName) {
    case 'ContainerRenderObjectMixin':
    case 'RenderBoxContainerDefaultsMixin':
      return RenderBoxProxyVariantSpec.container;
    case 'SlottedContainerRenderObjectMixin':
      return RenderBoxProxyVariantSpec.slotted;
    default:
      return null;
  }
}

/// Emits the full RenderBox-proxy family for a `RenderBox` [ProxyClassConfig]:
/// the plain variant followed by one variant per recognised name in
/// [ProxyClassConfig.mixinVariants], in declaration order, then the
/// `_classChainHasBridgedMixin` runtime selector helper when any container or
/// slotted variant was emitted (the factory uses it to pick the proxy shape).
///
/// Duplicate variant names (e.g. both `ContainerRenderObjectMixin` and
/// `RenderBoxContainerDefaultsMixin` mapping to the container variant) are
/// de-duplicated so the same class is emitted at most once. Unrecognised mixin
/// names are reported through [warn] and skipped.
String generateRenderBoxProxyFamily(
  ProxyClassConfig config, {
  void Function(String message)? warn,
}) {
  final buffer = StringBuffer();
  buffer.write(generateRenderBoxProxyVariant(RenderBoxProxyVariantSpec.plain));

  final emitted = <RenderBoxProxyVariant>{RenderBoxProxyVariant.plain};
  for (final mixinName in config.mixinVariants) {
    final spec = renderBoxProxyVariantSpecFor(mixinName);
    if (spec == null) {
      warn?.call(
        'Unknown RenderBox mixinVariant "$mixinName" — no proxy variant '
        'emitted. Add a mapping in renderBoxProxyVariantSpecFor to support it.',
      );
      continue;
    }
    if (!emitted.add(spec.variant)) continue;
    buffer.writeln();
    buffer.write(generateRenderBoxProxyVariant(spec));
  }

  // The runtime factory selector is only needed when a non-plain variant
  // exists (it walks the script class's mixin chain to choose between the
  // plain and container/slotted proxy at first instantiation).
  if (emitted.length > 1) {
    buffer.writeln();
    buffer.write(generateClassChainHasBridgedMixin());
  }
  return buffer.toString();
}

/// Emits a single RenderBox-proxy variant class for [spec].
///
/// Every variant carries the same forwarding skeleton (`_maybeInvoke`,
/// `performLayout`, `hitTest`, `hitTestSelf`); [spec] selects the `with`
/// clause and the `paint` / `hitTestChildren` / `setupParentData` bodies, and
/// the slotted variant additionally carries the intrinsic-dimension
/// forwarders.
String generateRenderBoxProxyVariant(RenderBoxProxyVariantSpec spec) {
  final b = StringBuffer();
  _writeClassHeader(b, spec);
  b.writeln('  ${spec.className}(this._visitor, this._instance);');
  b.writeln();
  b.writeln('  final InterpreterVisitor _visitor;');
  b.writeln('  final InterpretedInstance _instance;');
  b.writeln();
  b.writeln('  static const Object _kNotImplemented = Object();');
  b.writeln();
  b.writeln('  @override');
  b.writeln('  Object get d4rtInstance => _instance;');
  b.writeln();
  _writeMaybeInvoke(b);
  b.writeln();
  _writePerformLayout(b);
  b.writeln();
  _writePaint(b, spec.variant);
  b.writeln();
  _writeHitTest(b);
  b.writeln();
  _writeHitTestSelf(b);
  b.writeln();
  _writeHitTestChildren(b, spec.variant);
  b.writeln();
  _writeSetupParentData(b, spec.variant);
  if (spec.variant == RenderBoxProxyVariant.slotted) {
    b.writeln();
    _writeIntrinsics(b);
  }
  b.writeln('}');
  return b.toString();
}

/// Emits the `_classChainHasBridgedMixin` runtime selector free function used
/// by the `RenderBox` proxy factory to choose between the plain proxy and a
/// container/slotted proxy before `instance.nativeProxy` is cached.
String generateClassChainHasBridgedMixin() {
  final b = StringBuffer();
  b.writeln('/// Walk an [InterpretedClass]\'s ancestor chain looking for a');
  b.writeln('/// bridged mixin whose name matches [mixinName]. Used by the');
  b.writeln("/// 'RenderBox' proxy factory to choose between the plain proxy");
  b.writeln('/// and a container/slotted proxy at first instantiation.');
  b.writeln('///');
  b.writeln('/// Generated by the d4rtgen proxy generator (MCI#3 A4).');
  b.writeln(
      'bool _classChainHasBridgedMixin(InterpretedClass? klass, String mixinName) {');
  b.writeln('  var cursor = klass;');
  b.writeln('  final visited = <InterpretedClass>{};');
  b.writeln('  while (cursor != null && visited.add(cursor)) {');
  b.writeln('    for (final mixin in cursor.bridgedMixins) {');
  b.writeln('      if (mixin.name == mixinName) return true;');
  b.writeln('    }');
  b.writeln('    if (cursor.bridgedSuperclass?.name == mixinName) return true;');
  b.writeln('    for (final interpretedMixin in cursor.mixins) {');
  b.writeln(
      '      if (_classChainHasBridgedMixin(interpretedMixin, mixinName)) return true;');
  b.writeln('    }');
  b.writeln('    cursor = cursor.superclass;');
  b.writeln('  }');
  b.writeln('  return false;');
  b.writeln('}');
  return b.toString();
}

/// Writes the variant class header doc comment, `class` line, and `with`
/// clause.
void _writeClassHeader(StringBuffer b, RenderBoxProxyVariantSpec spec) {
  final mixinNote = switch (spec.variant) {
    RenderBoxProxyVariant.plain => '.',
    RenderBoxProxyVariant.container =>
      ', mixing in [ContainerRenderObjectMixin] + '
          '[RenderBoxContainerDefaultsMixin].',
    RenderBoxProxyVariant.slotted =>
      ', mixing in [SlottedContainerRenderObjectMixin].',
  };
  b.writeln('/// A native [RenderBox] proxy backed by an interpreted D4rt');
  b.writeln('/// RenderBox subclass$mixinNote');
  b.writeln('///');
  b.writeln('/// Generated by the d4rtgen proxy generator (MCI#3 A4).');
  b.writeln('/// The most common interpreted overrides are forwarded; anything');
  b.writeln('/// not overridden inherits the RenderBox (or mixin) default.');
  switch (spec.variant) {
    case RenderBoxProxyVariant.plain:
      b.writeln('class ${spec.className} extends RenderBox');
      b.writeln('    implements D4InterpretedProxy {');
    case RenderBoxProxyVariant.container:
      b.writeln('class ${spec.className} extends RenderBox');
      b.writeln('    with');
      b.writeln(
          '        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,');
      b.writeln('        RenderBoxContainerDefaultsMixin<RenderBox,');
      b.writeln('            ContainerBoxParentData<RenderBox>>');
      b.writeln('    implements D4InterpretedProxy {');
    case RenderBoxProxyVariant.slotted:
      b.writeln('class ${spec.className} extends RenderBox');
      b.writeln(
          '    with SlottedContainerRenderObjectMixin<dynamic, RenderBox>');
      b.writeln('    implements D4InterpretedProxy {');
  }
}

/// Writes the `_maybeInvoke` helper: invoke an interpreted method by name,
/// returning `_kNotImplemented` when the class doesn't define it (so callers
/// fall through to the native default).
void _writeMaybeInvoke(StringBuffer b) {
  b.writeln('  Object? _maybeInvoke(String methodName, List<Object?> args,');
  b.writeln('      [Map<String, Object?> named = const {}]) {');
  b.writeln('    final method = _instance.klass.findInstanceMethod(methodName);');
  b.writeln('    if (method == null) return _kNotImplemented;');
  b.writeln('    return method.bind(_instance).call(_visitor, args, named);');
  b.writeln('  }');
}

/// Writes the `performLayout` override (identical across variants): forward to
/// the interpreted body, else size to `constraints.smallest`, reflecting back
/// a `size` the script set via its field map.
void _writePerformLayout(StringBuffer b) {
  b.writeln('  @override');
  b.writeln('  void performLayout() {');
  b.writeln("    final result = _maybeInvoke('performLayout', const []);");
  b.writeln('    if (identical(result, _kNotImplemented)) {');
  b.writeln('      size = constraints.smallest;');
  b.writeln('      return;');
  b.writeln('    }');
  b.writeln('    if (!hasSize) {');
  b.writeln('      try {');
  b.writeln("        final reflected = _instance.get('size', visitor: _visitor);");
  b.writeln('        if (reflected is Size) size = reflected;');
  b.writeln('      } catch (_) {}');
  b.writeln('    }');
  b.writeln('    if (!hasSize) size = constraints.smallest;');
  b.writeln('  }');
}

/// Writes the `paint` override; the fallback body varies per variant.
void _writePaint(StringBuffer b, RenderBoxProxyVariant variant) {
  b.writeln('  @override');
  b.writeln('  void paint(PaintingContext context, Offset offset) {');
  b.writeln("    final result = _maybeInvoke('paint', [context, offset]);");
  switch (variant) {
    case RenderBoxProxyVariant.plain:
      b.writeln(
          '    if (identical(result, _kNotImplemented)) super.paint(context, offset);');
    case RenderBoxProxyVariant.container:
      b.writeln('    if (identical(result, _kNotImplemented)) {');
      b.writeln('      defaultPaint(context, offset);');
      b.writeln('    }');
    case RenderBoxProxyVariant.slotted:
      b.writeln('    if (identical(result, _kNotImplemented)) {');
      b.writeln('      // Default: paint each slot child at its parent-data offset.');
      b.writeln('      for (final child in children) {');
      b.writeln('        final parentData = child.parentData;');
      b.writeln('        final childOffset = parentData is BoxParentData');
      b.writeln('            ? parentData.offset + offset');
      b.writeln('            : offset;');
      b.writeln('        context.paintChild(child, childOffset);');
      b.writeln('      }');
      b.writeln('    }');
  }
  b.writeln('  }');
}

/// Writes the `hitTest` override (identical across variants).
void _writeHitTest(StringBuffer b) {
  b.writeln('  @override');
  b.writeln('  bool hitTest(BoxHitTestResult result, {required Offset position}) {');
  b.writeln("    final method = _instance.klass.findInstanceMethod('hitTest');");
  b.writeln('    if (method == null) return super.hitTest(result, position: position);');
  b.writeln('    final raw = method');
  b.writeln('        .bind(_instance)');
  b.writeln("        .call(_visitor, [result], {'position': position});");
  b.writeln('    if (raw is bool) return raw;');
  b.writeln('    return false;');
  b.writeln('  }');
}

/// Writes the `hitTestSelf` override (identical across variants).
void _writeHitTestSelf(StringBuffer b) {
  b.writeln('  @override');
  b.writeln('  bool hitTestSelf(Offset position) {');
  b.writeln("    final method = _instance.klass.findInstanceMethod('hitTestSelf');");
  b.writeln('    if (method == null) return super.hitTestSelf(position);');
  b.writeln('    try {');
  b.writeln('      final raw = method.bind(_instance).call(_visitor, [position], const {});');
  b.writeln('      if (raw is bool) return raw;');
  b.writeln('    } catch (_) {}');
  b.writeln('    return false;');
  b.writeln('  }');
}

/// Writes the `hitTestChildren` override; the fallback body varies per variant.
void _writeHitTestChildren(StringBuffer b, RenderBoxProxyVariant variant) {
  b.writeln('  @override');
  b.writeln(
      '  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {');
  b.writeln(
      "    final method = _instance.klass.findInstanceMethod('hitTestChildren');");
  switch (variant) {
    case RenderBoxProxyVariant.plain:
      b.writeln('    if (method == null) {');
      b.writeln('      return super.hitTestChildren(result, position: position);');
      b.writeln('    }');
    case RenderBoxProxyVariant.container:
      b.writeln('    if (method == null) {');
      b.writeln('      return defaultHitTestChildren(result, position: position);');
      b.writeln('    }');
    case RenderBoxProxyVariant.slotted:
      b.writeln('    if (method == null) {');
      b.writeln('      // Default: walk slot children in reverse paint order.');
      b.writeln('      for (final child in children.toList().reversed) {');
      b.writeln('        final parentData = child.parentData;');
      b.writeln('        final childOffset =');
      b.writeln('            parentData is BoxParentData ? parentData.offset : Offset.zero;');
      b.writeln('        final hit = result.addWithPaintOffset(');
      b.writeln('          offset: childOffset,');
      b.writeln('          position: position,');
      b.writeln('          hitTest: (BoxHitTestResult r, Offset p) =>');
      b.writeln('              child.hitTest(r, position: p),');
      b.writeln('        );');
      b.writeln('        if (hit) return true;');
      b.writeln('      }');
      b.writeln('      return false;');
      b.writeln('    }');
  }
  b.writeln('    try {');
  b.writeln('      final raw = method');
  b.writeln('          .bind(_instance)');
  b.writeln("          .call(_visitor, [result], {'position': position});");
  b.writeln('      if (raw is bool) return raw;');
  b.writeln('    } catch (_) {}');
  b.writeln('    return false;');
  b.writeln('  }');
}

/// Writes the `setupParentData` override; the signature and fallback body vary
/// per variant (slotted takes a `RenderBox` child and assigns a default
/// `BoxParentData`; plain/container take a `RenderObject` child and defer to
/// `super`).
void _writeSetupParentData(StringBuffer b, RenderBoxProxyVariant variant) {
  b.writeln('  @override');
  if (variant == RenderBoxProxyVariant.slotted) {
    b.writeln('  void setupParentData(RenderBox child) {');
    b.writeln("    final result = _maybeInvoke('setupParentData', [child]);");
    b.writeln('    if (identical(result, _kNotImplemented)) {');
    b.writeln('      // The mixin doesn\'t ship a default setupParentData — fall back to a');
    b.writeln('      // BoxParentData so children that store offsets still work.');
    b.writeln('      if (child.parentData is! BoxParentData) {');
    b.writeln('        child.parentData = BoxParentData();');
    b.writeln('      }');
    b.writeln('    }');
    b.writeln('  }');
  } else {
    b.writeln('  void setupParentData(RenderObject child) {');
    b.writeln("    final result = _maybeInvoke('setupParentData', [child]);");
    b.writeln(
        '    if (identical(result, _kNotImplemented)) super.setupParentData(child);');
    b.writeln('  }');
  }
}

/// Writes the four intrinsic-dimension forwarders carried only by the slotted
/// variant (the slot mixin doesn't compute intrinsics, so scripts that lay out
/// by intrinsics need these forwarded).
void _writeIntrinsics(StringBuffer b) {
  const dims = [
    ('computeMinIntrinsicWidth', 'height'),
    ('computeMaxIntrinsicWidth', 'height'),
    ('computeMinIntrinsicHeight', 'width'),
    ('computeMaxIntrinsicHeight', 'width'),
  ];
  for (var i = 0; i < dims.length; i++) {
    final (name, param) = dims[i];
    if (i > 0) b.writeln();
    b.writeln('  @override');
    b.writeln('  double $name(double $param) {');
    b.writeln('    final method =');
    b.writeln("        _instance.klass.findInstanceMethod('$name');");
    b.writeln('    if (method == null) return super.$name($param);');
    b.writeln('    try {');
    b.writeln('      final raw = method.bind(_instance).call(_visitor, [$param], const {});');
    b.writeln('      if (raw is num) return raw.toDouble();');
    b.writeln('    } catch (_) {}');
    b.writeln('    return super.$name($param);');
    b.writeln('  }');
  }
}
