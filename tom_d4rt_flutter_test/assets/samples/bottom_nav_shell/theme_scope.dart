// Cross-tab theme state.
//
// The plan calls for an `InheritedNotifier` to broadcast theme
// changes across tabs. Pragmatically we split that into two pieces:
//
//   • `ThemeNotifier` — a `ChangeNotifier` carrying the bool flag.
//     Any tab can call `.toggle()` and the owner state in `app.dart`
//     listens, calling `setState(() {})` to rebuild.
//
//   • `ThemeScope` — a plain `InheritedWidget` that exposes both the
//     notifier (for action calls) and a *snapshot* `isDark` bool (so
//     `updateShouldNotify` can decide cheaply whether dependents
//     need to rebuild). The snapshot is refreshed on every
//     owner-state rebuild.
//
// This pattern gives us the same observable behaviour as
// `InheritedNotifier` — descendants that call `ThemeScope.of(ctx)`
// are auto-rebuilt when the bool flips — without depending on the
// notifier-listening subscription that lives only inside the native
// `InheritedNotifier` element.
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier({bool dark = false}) : _dark = dark;

  bool _dark;
  bool get isDark => _dark;

  void toggle() {
    _dark = !_dark;
    notifyListeners();
  }
}

class ThemeScope extends InheritedWidget {
  const ThemeScope({
    super.key,
    required this.notifier,
    required this.isDark,
    required super.child,
  });

  final ThemeNotifier notifier;
  final bool isDark;

  static ThemeScope of(BuildContext context) {
    final ThemeScope? scope =
        context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    if (scope == null) {
      throw FlutterError('ThemeScope.of: no ThemeScope ancestor found.');
    }
    return scope;
  }

  @override
  bool updateShouldNotify(ThemeScope oldWidget) =>
      oldWidget.isDark != isDark;
}
