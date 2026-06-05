// Fixture for the MCI#4 / A6 premise-lock-in test.
//
// A6 proposed automating "@protected supplementary adapters" on the assumption
// that the generator *skips* @protected / @visibleForTesting members. That
// premise is stale: the generator emits these members into the bridge directly,
// so interpreted subclasses reach them through the normal generated bridge
// adapter (which the runtime dispatch consults before the supplementary
// registry). This fixture exercises that policy so a future regression that
// re-introduces a @protected skip is caught.
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

/// A subclassable base mirroring the shape of `ChangeNotifier`: a public API
/// surface plus @protected members that subclasses legitimately call via
/// `super.*`.
class Notifier {
  bool _dirty = false;

  /// Public member — always emitted.
  void addObserver(void Function() observer) {}

  /// @protected method — interpreted subclasses call `super.notify()`.
  @protected
  void notify() {
    _dirty = true;
  }

  /// @protected getter.
  @protected
  bool get isDirty => _dirty;

  /// @visibleForTesting method.
  @visibleForTesting
  void resetForTest() {
    _dirty = false;
  }
}
