// GEN-076: Fixture for required nullable parameter bridging
// Tests that required nullable parameters generate correct extraction code

/// A widget with required nullable value (like CupertinoCheckbox)
class TristateCheckbox {
  final bool? value;
  final bool tristate;
  final void Function(bool?)? onChanged;

  const TristateCheckbox({
    required this.value,
    this.tristate = false,
    this.onChanged,
  });
}

/// A class with required nullable object parameter
class NullableKeyWidget {
  final String? label;
  final int? priority;

  const NullableKeyWidget({
    required this.label,
    required this.priority,
  });
}

/// Static const defaults that cannot be evaluated at generation time
class ScrollbarWidget {
  /// A static const default thickness
  static const double defaultThickness = 3.0;
  static const double defaultThicknessWhileDragging = 6.0;

  final double thickness;
  final double thicknessWhileDragging;
  final Widget child;

  const ScrollbarWidget({
    this.thickness = defaultThickness,
    this.thicknessWhileDragging = defaultThicknessWhileDragging,
    required this.child,
  });
}

/// Private constant defaults
const double _kDefaultPadding = 8.0;

class PaddedWidget {
  final double padding;
  final Widget child;

  const PaddedWidget({
    this.padding = _kDefaultPadding,
    required this.child,
  });
}

/// Placeholder for Widget type
class Widget {
  const Widget();
}
