/// UserBridge override for `dart:ui` `SceneBuilder.pushOpacity`.
///
/// **Why:** `SceneBuilder.pushOpacity` has a VM↔web signature skew. On the VM
/// the `offset` parameter is `Offset? offset = Offset.zero` (nullable); on web
/// it is `Offset offset = Offset.zero` (non-nullable). The auto-generated
/// adapter extracts `offset` as `Offset?` and forwards it directly, which
/// compiles on the VM but fails dart2js with
/// "The argument type 'Offset?' can't be assigned to the parameter type
/// 'Offset'." That single member is the only thing keeping the whole bridge
/// set from building for the web.
///
/// `SceneBuilder` itself is exercised by `scene_builder_test.dart` (it calls
/// `pushOpacity` directly), so the class must stay bridged — excluding it
/// would regress the corpus. This override replaces just the `pushOpacity`
/// adapter with a web-safe variant that coerces `offset` to a non-null
/// `Offset` (`offset ?? Offset.zero`), which satisfies both the VM (nullable
/// accepts non-null) and web (non-null required) signatures. The runtime
/// behaviour is unchanged: the VM default for an omitted `offset` is already
/// `Offset.zero`, so mapping an explicit `null` to `Offset.zero` matches it.
library;

import 'dart:ui' as ui;

import 'package:tom_d4rt_ast/d4rt.dart';

/// Replaces the auto-generated `SceneBuilder.pushOpacity` adapter with a
/// web-safe variant (non-nullable `offset`) so the bridge set compiles under
/// dart2js while keeping `SceneBuilder` fully bridged for the corpus.
@D4rtUserBridge('dart:ui', 'SceneBuilder')
class SceneBuilderUserBridge extends D4UserBridge {
  /// Override for
  /// `OpacityEngineLayer pushOpacity(int alpha, {Offset offset, OpacityEngineLayer? oldLayer})`.
  static Object? overrideMethodPushOpacity(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArguments,
  ) {
    final t = D4.validateTarget<ui.SceneBuilder>(target, 'SceneBuilder');
    D4.requireMinArgs(positional, 1, 'pushOpacity');
    final alpha = D4.getRequiredArg<int>(positional, 0, 'alpha', 'pushOpacity');
    // Web-safe: keep `offset` non-nullable so dart2js accepts the call.
    final ui.Offset offset =
        D4.getNamedArgWithDefault<ui.Offset?>(named, 'offset', ui.Offset.zero) ??
            ui.Offset.zero;
    final oldLayer =
        D4.getOptionalNamedArg<ui.OpacityEngineLayer?>(named, 'oldLayer');
    return t.pushOpacity(alpha, offset: offset, oldLayer: oldLayer);
  }
}
