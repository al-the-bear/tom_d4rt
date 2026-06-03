/// UserBridge override for `State.setState`.
///
/// **Why:** Several Flutter test scripts in this corpus invoke `setState`
/// from inside `RenderBox.performLayout`, `paint`, and `hitTestChildren`
/// (snapshot callbacks that bubble up through interpreted State.) In real
/// Flutter the same pattern would also throw `Build scheduled during frame.`
/// The bridge generator's auto-emitted `setState` adapter calls
/// `t.setState(() { ... })` synchronously with no scheduler-phase check,
/// so the throw happens via the bridge and surfaces as a framework error
/// even before the script's logic gets a chance to recover.
///
/// **Workaround:** When `SchedulerBinding.instance.schedulerPhase` indicates
/// the framework is mid-frame (`transientCallbacks`,
/// `midFrameMicrotasks`, `persistentCallbacks`), this override defers the
/// callback to a `WidgetsBinding.instance.addPostFrameCallback`, exactly
/// matching the pattern Flutter recommends in the error message itself.
/// In any other phase, the bridge calls `setState` synchronously, preserving
/// the historical behaviour.
///
/// This is a behavioural deviation from real Flutter — a script that calls
/// `setState` during layout/paint will see the rebuild on the next frame
/// rather than a thrown error. See
/// `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (C20d) for the script-
/// level fix (use `LayoutBuilder` or `addPostFrameCallback` directly) that
/// would remove the need for this deviation.
library;

import 'package:flutter/scheduler.dart' show SchedulerBinding, SchedulerPhase;
import 'package:flutter/widgets.dart' show State, WidgetsBinding;
import 'package:tom_d4rt_ast/d4rt.dart';

/// Replaces the auto-generated `State.setState` adapter with a scheduler-phase
/// aware variant that defers via `addPostFrameCallback` when called mid-frame.
@D4rtUserBridge('package:flutter/src/widgets/framework.dart', 'State')
class StateUserBridge extends D4UserBridge {
  /// Override for `setState(VoidCallback fn)`.
  static Object? overrideMethodSetState(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArguments,
  ) {
    final state = D4.validateTarget<State>(target, 'State');
    D4.requireMinArgs(positional, 1, 'setState');
    final fnRaw = positional[0];

    void invokeNative() {
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        D4.callInterpreterCallback(visitor, fnRaw, []);
      });
    }

    final phase = SchedulerBinding.instance.schedulerPhase;
    final mustDefer = phase == SchedulerPhase.transientCallbacks ||
        phase == SchedulerPhase.midFrameMicrotasks ||
        phase == SchedulerPhase.persistentCallbacks;
    if (mustDefer && state.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.mounted) {
          invokeNative();
        }
      });
    } else {
      invokeNative();
    }
    return null;
  }
}
