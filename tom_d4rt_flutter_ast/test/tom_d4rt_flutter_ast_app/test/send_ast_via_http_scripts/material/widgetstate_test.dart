// D4rt test script: Deep Demo - WidgetState / WidgetStateProperty Family
// Comprehensive demonstration of WidgetState, WidgetStateProperty.resolveWith,
// WidgetStateProperty.fromMap, WidgetStateProperty.all, WidgetStateColor,
// WidgetStateMouseCursor, WidgetStateBorderSide, WidgetStateTextStyle,
// WidgetStateOutlinedBorder and the legacy MaterialState* aliases.
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1: THE EIGHT WIDGET STATES
  // ===========================================================================
  // WidgetState is the canonical enum used by Material widgets to describe
  // visual conditions. Every widget that has a "state-driven" property (color,
  // border, mouse cursor, text style, shape) ultimately resolves against a
  // Set<WidgetState>. The eight canonical states cover every interactive
  // situation a Material widget might appear in.

  final List<WidgetState> canonicalStates = <WidgetState>[
    WidgetState.hovered,
    WidgetState.focused,
    WidgetState.pressed,
    WidgetState.dragged,
    WidgetState.selected,
    WidgetState.scrolledUnder,
    WidgetState.disabled,
    WidgetState.error,
  ];

  // Each canonical state has a human-friendly name and a small narrative
  // about when the framework places it into a widget's state set.
  final List<Map<String, dynamic>> stateNarratives = <Map<String, dynamic>>[
    <String, dynamic>{
      'state': WidgetState.hovered,
      'label': 'hovered',
      'icon': Icons.mouse,
      'color': const Color(0xFF1976D2),
      'narrative': 'Pointer is over the widget but no buttons are pressed.',
    },
    <String, dynamic>{
      'state': WidgetState.focused,
      'label': 'focused',
      'icon': Icons.center_focus_strong,
      'color': const Color(0xFF7B1FA2),
      'narrative': 'Widget is the current focus target of the focus tree.',
    },
    <String, dynamic>{
      'state': WidgetState.pressed,
      'label': 'pressed',
      'icon': Icons.touch_app,
      'color': const Color(0xFFD84315),
      'narrative': 'A pointer is actively pressing the widget.',
    },
    <String, dynamic>{
      'state': WidgetState.dragged,
      'label': 'dragged',
      'icon': Icons.drag_indicator,
      'color': const Color(0xFFF57F17),
      'narrative': 'Widget is currently being dragged by the user.',
    },
    <String, dynamic>{
      'state': WidgetState.selected,
      'label': 'selected',
      'icon': Icons.check_circle,
      'color': const Color(0xFF2E7D32),
      'narrative': 'Widget represents a currently selected value.',
    },
    <String, dynamic>{
      'state': WidgetState.scrolledUnder,
      'label': 'scrolledUnder',
      'icon': Icons.layers,
      'color': const Color(0xFF00838F),
      'narrative': 'Content has scrolled beneath the widget (e.g. AppBar).',
    },
    <String, dynamic>{
      'state': WidgetState.disabled,
      'label': 'disabled',
      'icon': Icons.block,
      'color': const Color(0xFF616161),
      'narrative': 'Widget is intentionally inert and non-interactive.',
    },
    <String, dynamic>{
      'state': WidgetState.error,
      'label': 'error',
      'icon': Icons.error_outline,
      'color': const Color(0xFFC62828),
      'narrative': 'Widget is in an error / invalid condition.',
    },
  ];

  // ===========================================================================
  // SECTION 2: WidgetStateProperty.all
  // ===========================================================================
  // The simplest WidgetStateProperty: returns the same value regardless of
  // the resolved state set. Useful when a value is genuinely state-invariant
  // (padding, shape, etc.) but the API still demands a WidgetStateProperty.

  final WidgetStateProperty<Color> constantBackground =
      WidgetStateProperty.all<Color>(const Color(0xFF3949AB));
  final WidgetStateProperty<double> constantElevation =
      WidgetStateProperty.all<double>(3.0);
  final WidgetStateProperty<EdgeInsetsGeometry> constantPadding =
      WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      );

  final List<Map<String, dynamic>> allSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'empty {}',
      'states': <WidgetState>{},
      'resolved': constantBackground.resolve(<WidgetState>{}),
    },
    <String, dynamic>{
      'label': '{hovered}',
      'states': <WidgetState>{WidgetState.hovered},
      'resolved': constantBackground.resolve(<WidgetState>{WidgetState.hovered}),
    },
    <String, dynamic>{
      'label': '{pressed}',
      'states': <WidgetState>{WidgetState.pressed},
      'resolved': constantBackground.resolve(<WidgetState>{WidgetState.pressed}),
    },
    <String, dynamic>{
      'label': '{disabled}',
      'states': <WidgetState>{WidgetState.disabled},
      'resolved':
          constantBackground.resolve(<WidgetState>{WidgetState.disabled}),
    },
    <String, dynamic>{
      'label': '{error,focused}',
      'states': <WidgetState>{WidgetState.error, WidgetState.focused},
      'resolved': constantBackground.resolve(
        <WidgetState>{WidgetState.error, WidgetState.focused},
      ),
    },
  ];

  // ===========================================================================
  // SECTION 3: WidgetStateProperty.resolveWith
  // ===========================================================================
  // The workhorse constructor. A callback receives the live state set and
  // returns whatever value is appropriate. Used for color, double, EdgeInsets,
  // BorderSide, TextStyle, OutlinedBorder, MouseCursor, etc.

  final WidgetStateProperty<Color> resolvedBackground =
      WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return const Color(0xFFBDBDBD);
    }
    if (states.contains(WidgetState.error)) {
      return const Color(0xFFC62828);
    }
    if (states.contains(WidgetState.pressed)) {
      return const Color(0xFF1A237E);
    }
    if (states.contains(WidgetState.hovered)) {
      return const Color(0xFF283593);
    }
    if (states.contains(WidgetState.focused)) {
      return const Color(0xFF303F9F);
    }
    if (states.contains(WidgetState.selected)) {
      return const Color(0xFF3949AB);
    }
    return const Color(0xFF5C6BC0);
  });

  final WidgetStateProperty<double> resolvedElevation =
      WidgetStateProperty.resolveWith<double>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) return 0.0;
    if (states.contains(WidgetState.pressed)) return 1.0;
    if (states.contains(WidgetState.hovered)) return 6.0;
    if (states.contains(WidgetState.focused)) return 4.0;
    return 2.0;
  });

  // Probe the resolveWith property against every canonical single-state set
  // and a few interesting combinations.
  final List<Map<String, dynamic>> resolveWithSamples = canonicalStates
      .map<Map<String, dynamic>>((WidgetState s) => <String, dynamic>{
            'label': '{${s.name}}',
            'background': resolvedBackground.resolve(<WidgetState>{s}),
            'elevation': resolvedElevation.resolve(<WidgetState>{s}),
          })
      .toList();
  resolveWithSamples.add(<String, dynamic>{
    'label': 'empty {}',
    'background': resolvedBackground.resolve(<WidgetState>{}),
    'elevation': resolvedElevation.resolve(<WidgetState>{}),
  });
  resolveWithSamples.add(<String, dynamic>{
    'label': '{hovered,focused}',
    'background': resolvedBackground
        .resolve(<WidgetState>{WidgetState.hovered, WidgetState.focused}),
    'elevation': resolvedElevation
        .resolve(<WidgetState>{WidgetState.hovered, WidgetState.focused}),
  });
  resolveWithSamples.add(<String, dynamic>{
    'label': '{selected,pressed}',
    'background': resolvedBackground
        .resolve(<WidgetState>{WidgetState.selected, WidgetState.pressed}),
    'elevation': resolvedElevation
        .resolve(<WidgetState>{WidgetState.selected, WidgetState.pressed}),
  });

  // ===========================================================================
  // SECTION 4: WidgetStateProperty.fromMap
  // ===========================================================================
  // A declarative alternative to resolveWith: a Map from
  // WidgetStatesConstraint to value. The first matching entry wins, so
  // ordering matters - put the more specific constraints first.

  final WidgetStateProperty<Color> mapBackground =
      WidgetStateProperty<Color>.fromMap(<WidgetStatesConstraint, Color>{
    WidgetState.disabled: const Color(0xFFE0E0E0),
    WidgetState.error: const Color(0xFFEF5350),
    WidgetState.pressed: const Color(0xFF00695C),
    WidgetState.hovered: const Color(0xFF00897B),
    WidgetState.focused: const Color(0xFF009688),
    WidgetState.selected: const Color(0xFF26A69A),
    WidgetState.any: const Color(0xFF4DB6AC),
  });

  final List<Map<String, dynamic>> fromMapSamples = canonicalStates
      .map<Map<String, dynamic>>((WidgetState s) => <String, dynamic>{
            'label': '{${s.name}}',
            'background': mapBackground.resolve(<WidgetState>{s}),
          })
      .toList();
  fromMapSamples.add(<String, dynamic>{
    'label': 'empty {} (any)',
    'background': mapBackground.resolve(<WidgetState>{}),
  });

  // ===========================================================================
  // SECTION 5: WidgetStateColor
  // ===========================================================================
  // A Color that is also a WidgetStateProperty<Color>. The default color
  // (the empty-state value) is what you get if you just use it as a Color.

  final WidgetStateColor stateColor =
      WidgetStateColor.resolveWith((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return const Color(0xFFBDBDBD);
    }
    if (states.contains(WidgetState.pressed)) {
      return const Color(0xFFAD1457);
    }
    if (states.contains(WidgetState.hovered)) {
      return const Color(0xFFC2185B);
    }
    if (states.contains(WidgetState.focused)) {
      return const Color(0xFFD81B60);
    }
    return const Color(0xFFEC407A);
  });

  final List<Map<String, dynamic>> stateColorSamples = canonicalStates
      .map<Map<String, dynamic>>((WidgetState s) => <String, dynamic>{
            'label': s.name,
            'color': stateColor.resolve(<WidgetState>{s}),
          })
      .toList();

  // ===========================================================================
  // SECTION 6: WidgetStateMouseCursor
  // ===========================================================================
  // Drives the system mouse cursor based on the widget's current states.

  final WidgetStateMouseCursor cursor = WidgetStateMouseCursor.clickable;
  final List<Map<String, dynamic>> cursorSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'empty',
      'cursor': cursor.resolve(<WidgetState>{}).debugDescription,
    },
    <String, dynamic>{
      'label': 'hovered',
      'cursor':
          cursor.resolve(<WidgetState>{WidgetState.hovered}).debugDescription,
    },
    <String, dynamic>{
      'label': 'disabled',
      'cursor':
          cursor.resolve(<WidgetState>{WidgetState.disabled}).debugDescription,
    },
    <String, dynamic>{
      'label': 'pressed',
      'cursor':
          cursor.resolve(<WidgetState>{WidgetState.pressed}).debugDescription,
    },
    <String, dynamic>{
      'label': 'focused',
      'cursor':
          cursor.resolve(<WidgetState>{WidgetState.focused}).debugDescription,
    },
  ];

  // Custom cursor that picks based on multiple factors.
  final WidgetStateProperty<MouseCursor> customCursor =
      WidgetStateProperty.resolveWith<MouseCursor>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return SystemMouseCursors.forbidden;
    }
    if (states.contains(WidgetState.dragged)) {
      return SystemMouseCursors.grabbing;
    }
    if (states.contains(WidgetState.hovered)) {
      return SystemMouseCursors.click;
    }
    return SystemMouseCursors.basic;
  });
  final List<Map<String, dynamic>> customCursorSamples =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'empty',
      'cursor': customCursor.resolve(<WidgetState>{}).debugDescription,
    },
    <String, dynamic>{
      'label': 'hovered',
      'cursor': customCursor
          .resolve(<WidgetState>{WidgetState.hovered})
          .debugDescription,
    },
    <String, dynamic>{
      'label': 'dragged',
      'cursor': customCursor
          .resolve(<WidgetState>{WidgetState.dragged})
          .debugDescription,
    },
    <String, dynamic>{
      'label': 'disabled',
      'cursor': customCursor
          .resolve(<WidgetState>{WidgetState.disabled})
          .debugDescription,
    },
  ];

  // ===========================================================================
  // SECTION 7: WidgetStateBorderSide
  // ===========================================================================
  // BorderSide-flavored WidgetStateProperty. Used by Chip, OutlinedButton,
  // ToggleButtons and similar widgets to drive border thickness/color/style
  // per state.

  final WidgetStateBorderSide stateBorderSide =
      WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
    if (states.contains(WidgetState.error)) {
      return const BorderSide(color: Color(0xFFC62828), width: 2.5);
    }
    if (states.contains(WidgetState.disabled)) {
      return const BorderSide(color: Color(0xFFBDBDBD), width: 1.0);
    }
    if (states.contains(WidgetState.pressed)) {
      return const BorderSide(color: Color(0xFF1B5E20), width: 2.0);
    }
    if (states.contains(WidgetState.hovered)) {
      return const BorderSide(color: Color(0xFF2E7D32), width: 1.8);
    }
    if (states.contains(WidgetState.focused)) {
      return const BorderSide(color: Color(0xFF388E3C), width: 2.0);
    }
    if (states.contains(WidgetState.selected)) {
      return const BorderSide(color: Color(0xFF43A047), width: 2.0);
    }
    return const BorderSide(color: Color(0xFF81C784), width: 1.0);
  });

  final List<Map<String, dynamic>> borderSamples = canonicalStates
      .map<Map<String, dynamic>>((WidgetState s) {
    final BorderSide? side = stateBorderSide.resolve(<WidgetState>{s});
    return <String, dynamic>{
      'label': s.name,
      'color': side?.color ?? const Color(0xFF000000),
      'width': side?.width ?? 0.0,
    };
  }).toList();
  borderSamples.add(<String, dynamic>{
    'label': 'default',
    'color': stateBorderSide.resolve(<WidgetState>{})?.color ??
        const Color(0xFF000000),
    'width': stateBorderSide.resolve(<WidgetState>{})?.width ?? 0.0,
  });

  // ===========================================================================
  // SECTION 8: WidgetStateTextStyle
  // ===========================================================================
  // Text style that can change per state. Used by labelStyle on Chip, by
  // InputDecorationTheme, etc.

  final WidgetStateTextStyle stateTextStyle =
      WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(
        color: Color(0xFF9E9E9E),
        fontStyle: FontStyle.italic,
        fontSize: 14.0,
      );
    }
    if (states.contains(WidgetState.error)) {
      return const TextStyle(
        color: Color(0xFFC62828),
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      );
    }
    if (states.contains(WidgetState.selected)) {
      return const TextStyle(
        color: Color(0xFF0D47A1),
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const TextStyle(
        color: Color(0xFF1565C0),
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return const TextStyle(
        color: Color(0xFF1976D2),
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
    }
    return const TextStyle(
      color: Color(0xFF424242),
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    );
  });

  final List<Map<String, dynamic>> textStyleSamples = canonicalStates
      .map<Map<String, dynamic>>((WidgetState s) {
    final TextStyle style = stateTextStyle.resolve(<WidgetState>{s});
    return <String, dynamic>{
      'label': s.name,
      'color': style.color ?? const Color(0xFF000000),
      'weight': style.fontWeight ?? FontWeight.normal,
      'fontStyle': style.fontStyle ?? FontStyle.normal,
    };
  }).toList();

  // ===========================================================================
  // SECTION 9: Shape as WidgetStateProperty<OutlinedBorder>
  // ===========================================================================
  // OutlinedBorder that varies per state. Used to give shapes a state-driven
  // appearance (e.g. rounded when normal, stadium when selected).

  final WidgetStateProperty<OutlinedBorder> shapeProperty =
      WidgetStateProperty.resolveWith<OutlinedBorder>(
          (Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return const StadiumBorder();
    }
    if (states.contains(WidgetState.pressed)) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));
    }
    if (states.contains(WidgetState.hovered)) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
    }
    if (states.contains(WidgetState.disabled)) {
      return const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      );
    }
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
  });

  double radiusOf(OutlinedBorder b) {
    if (b is RoundedRectangleBorder) {
      final BorderRadiusGeometry r = b.borderRadius;
      if (r is BorderRadius) return r.topLeft.x;
    }
    if (b is StadiumBorder) return 999.0;
    return 0.0;
  }

  final List<Map<String, dynamic>> shapeSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'default',
      'radius': radiusOf(shapeProperty.resolve(<WidgetState>{})),
    },
    <String, dynamic>{
      'label': 'hovered',
      'radius': radiusOf(
          shapeProperty.resolve(<WidgetState>{WidgetState.hovered})),
    },
    <String, dynamic>{
      'label': 'pressed',
      'radius': radiusOf(
          shapeProperty.resolve(<WidgetState>{WidgetState.pressed})),
    },
    <String, dynamic>{
      'label': 'selected',
      'radius': radiusOf(
          shapeProperty.resolve(<WidgetState>{WidgetState.selected})),
    },
    <String, dynamic>{
      'label': 'disabled',
      'radius': radiusOf(
          shapeProperty.resolve(<WidgetState>{WidgetState.disabled})),
    },
  ];

  // ===========================================================================
  // SECTION 10: Legacy MaterialState* aliases - documented, not invoked
  // ===========================================================================
  // Before WidgetState was introduced, the same concepts lived under the
  // MaterialState* names. Those typedefs are still valid but are now flagged
  // as deprecated, so we document the relationship rather than calling the
  // deprecated APIs directly. Each row below shows the legacy name and the
  // WidgetState* name it now resolves through.

  final List<Map<String, dynamic>> legacySamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'MaterialState',
      'color': const Color(0xFF6A1B9A),
      'note': 'is now WidgetState',
    },
    <String, dynamic>{
      'label': 'MaterialStateProperty<T>',
      'color': const Color(0xFF8E24AA),
      'note': 'is now WidgetStateProperty<T>',
    },
    <String, dynamic>{
      'label': 'MaterialStateColor',
      'color': const Color(0xFFAB47BC),
      'note': 'is now WidgetStateColor',
    },
    <String, dynamic>{
      'label': 'MaterialStateBorderSide',
      'color': const Color(0xFFBA68C8),
      'note': 'is now WidgetStateBorderSide',
    },
    <String, dynamic>{
      'label': 'MaterialStateTextStyle',
      'color': const Color(0xFFCE93D8),
      'note': 'is now WidgetStateTextStyle',
    },
    <String, dynamic>{
      'label': 'MaterialStateMouseCursor',
      'color': const Color(0xFFE1BEE7),
      'note': 'is now WidgetStateMouseCursor',
    },
  ];

  // ===========================================================================
  // SECTION 11: COMPOSITE BUTTON STYLE
  // ===========================================================================
  // The headline use case: combine many WidgetStateProperty values into a
  // single ButtonStyle that drives an ElevatedButton across every state.

  final ButtonStyle compositeButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0xFFE0E0E0);
      }
      if (states.contains(WidgetState.pressed)) {
        return const Color(0xFF0D47A1);
      }
      if (states.contains(WidgetState.hovered)) {
        return const Color(0xFF1565C0);
      }
      if (states.contains(WidgetState.focused)) {
        return const Color(0xFF1976D2);
      }
      return const Color(0xFF1E88E5);
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0xFF9E9E9E);
      }
      return const Color(0xFFFFFFFF);
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return const Color(0xFFFFFFFF).withValues(alpha: 0.24);
      }
      if (states.contains(WidgetState.hovered)) {
        return const Color(0xFFFFFFFF).withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.focused)) {
        return const Color(0xFFFFFFFF).withValues(alpha: 0.16);
      }
      return const Color(0x00000000);
    }),
    elevation: WidgetStateProperty.resolveWith<double>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return 0.0;
      if (states.contains(WidgetState.pressed)) return 1.0;
      if (states.contains(WidgetState.hovered)) return 6.0;
      if (states.contains(WidgetState.focused)) return 4.0;
      return 2.0;
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        );
      }
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      );
    }),
    side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: Color(0xFF82B1FF), width: 2.0);
      }
      return BorderSide.none;
    }),
    mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return SystemMouseCursors.forbidden;
      }
      return SystemMouseCursors.click;
    }),
  );

  // Confirm the composite style resolves into sensible values for the four
  // most common live states a button might be in.
  final List<Map<String, dynamic>> compositeSamples =
      <Map<String, dynamic>>[
    _resolveAll('idle', <WidgetState>{}, compositeButtonStyle),
    _resolveAll('hovered', <WidgetState>{WidgetState.hovered},
        compositeButtonStyle),
    _resolveAll('focused', <WidgetState>{WidgetState.focused},
        compositeButtonStyle),
    _resolveAll('pressed', <WidgetState>{WidgetState.pressed},
        compositeButtonStyle),
    _resolveAll('disabled', <WidgetState>{WidgetState.disabled},
        compositeButtonStyle),
  ];

  // ===========================================================================
  // SECTION 12: STATE MATRIX
  // ===========================================================================
  // Show every state vs every state-driven property in a single matrix so it
  // is obvious how the lookup behaves. Each cell shows the resolved value as
  // a tiny color/elevation swatch.

  final List<List<Map<String, dynamic>>> stateMatrix = canonicalStates
      .map<List<Map<String, dynamic>>>((WidgetState s) {
    final Set<WidgetState> set = <WidgetState>{s};
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'kind': 'background',
        'value': resolvedBackground.resolve(set),
      },
      <String, dynamic>{
        'kind': 'elevation',
        'value': resolvedElevation.resolve(set),
      },
      <String, dynamic>{
        'kind': 'border-color',
        'value': stateBorderSide.resolve(set)?.color ??
            const Color(0xFF000000),
      },
      <String, dynamic>{
        'kind': 'border-width',
        'value': stateBorderSide.resolve(set)?.width ?? 0.0,
      },
      <String, dynamic>{
        'kind': 'text-color',
        'value':
            stateTextStyle.resolve(set).color ?? const Color(0xFF000000),
      },
      <String, dynamic>{
        'kind': 'shape-r',
        'value': radiusOf(shapeProperty.resolve(set)),
      },
    ];
  }).toList();

  // ===========================================================================
  // SECTION 13: WidgetStatesController
  // ===========================================================================
  // The controller side of the API: a Listenable<Set<WidgetState>> that
  // widgets can read or write into. Driving a controller manually shows how
  // the state set evolves.

  final WidgetStatesController controller = WidgetStatesController();
  final List<Map<String, dynamic>> controllerSnapshots =
      <Map<String, dynamic>>[];
  controllerSnapshots.add(<String, dynamic>{
    'step': 'initial',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.update(WidgetState.hovered, true);
  controllerSnapshots.add(<String, dynamic>{
    'step': '+hovered',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.update(WidgetState.focused, true);
  controllerSnapshots.add(<String, dynamic>{
    'step': '+focused',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.update(WidgetState.pressed, true);
  controllerSnapshots.add(<String, dynamic>{
    'step': '+pressed',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.update(WidgetState.hovered, false);
  controllerSnapshots.add(<String, dynamic>{
    'step': '-hovered',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.update(WidgetState.disabled, true);
  controllerSnapshots.add(<String, dynamic>{
    'step': '+disabled',
    'states': controller.value.map((WidgetState s) => s.name).toList(),
  });
  controller.dispose();

  final WidgetStatesController seeded = WidgetStatesController(
    <WidgetState>{WidgetState.selected, WidgetState.focused},
  );
  controllerSnapshots.add(<String, dynamic>{
    'step': 'seeded({selected,focused})',
    'states': seeded.value.map((WidgetState s) => s.name).toList(),
  });
  seeded.update(WidgetState.error, true);
  controllerSnapshots.add(<String, dynamic>{
    'step': '+error',
    'states': seeded.value.map((WidgetState s) => s.name).toList(),
  });
  seeded.update(WidgetState.selected, false);
  controllerSnapshots.add(<String, dynamic>{
    'step': '-selected',
    'states': seeded.value.map((WidgetState s) => s.name).toList(),
  });
  seeded.dispose();

  // ===========================================================================
  // SECTION 14: COLOR LADDER (visual)
  // ===========================================================================
  // For a fixed resolveWith property, render a tall ladder of swatches, one
  // per canonical state plus a few combinations, to make the behaviour
  // unmistakable at a glance.

  final List<Map<String, dynamic>> ladder = <Map<String, dynamic>>[];
  ladder.add(<String, dynamic>{
    'name': 'idle',
    'color': resolvedBackground.resolve(<WidgetState>{}),
  });
  for (int i = 0; i < canonicalStates.length; i++) {
    final WidgetState s = canonicalStates[i];
    ladder.add(<String, dynamic>{
      'name': s.name,
      'color': resolvedBackground.resolve(<WidgetState>{s}),
    });
  }
  final List<Set<WidgetState>> combos = <Set<WidgetState>>[
    <WidgetState>{WidgetState.hovered, WidgetState.focused},
    <WidgetState>{WidgetState.pressed, WidgetState.selected},
    <WidgetState>{WidgetState.disabled, WidgetState.error},
    <WidgetState>{WidgetState.dragged, WidgetState.pressed},
  ];
  for (int i = 0; i < combos.length; i++) {
    final Set<WidgetState> c = combos[i];
    final String name = c.map((WidgetState s) => s.name).join('+');
    ladder.add(<String, dynamic>{
      'name': name,
      'color': resolvedBackground.resolve(c),
    });
  }

  // Use dart:math to demonstrate the import has a real role: scatter a row
  // of decorative dots whose hues sweep across the resolved palette.
  final List<Color> sweep = List<Color>.generate(12, (int i) {
    final double t = i / 11.0;
    final int hue = (240.0 - 240.0 * t).round();
    final double sat = 0.55 + 0.35 * math.sin(t * math.pi);
    return HSVColor.fromAHSV(1.0, hue.toDouble(), sat.clamp(0.0, 1.0), 0.85)
        .toColor();
  });

  // ===========================================================================
  // SECTION 15: SUMMARY COUNTS
  // ===========================================================================

  final int totalStates = canonicalStates.length;
  final int totalSamples = resolveWithSamples.length +
      fromMapSamples.length +
      stateColorSamples.length +
      cursorSamples.length +
      customCursorSamples.length +
      borderSamples.length +
      textStyleSamples.length +
      shapeSamples.length +
      legacySamples.length +
      compositeSamples.length;
  final int controllerSteps = controllerSnapshots.length;

  // Reference [constantElevation] and [constantPadding] so the analyzer
  // recognises them as used; they're also part of the narrative.
  final double demoElevation = constantElevation.resolve(<WidgetState>{});
  final EdgeInsetsGeometry demoPadding =
      constantPadding.resolve(<WidgetState>{});

  // ===========================================================================
  // BUILD THE UI
  // ===========================================================================
  // Visual idiom: gradient header, concept overview, then one card per
  // section with side-by-side per-state swatches. No interactive triggers -
  // each card shows the *resolved* values that the framework would pick if
  // the widget were in that state.

  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFC),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildHeader(totalStates, totalSamples, controllerSteps),
              const SizedBox(height: 24.0),
              _buildConceptOverview(),
              const SizedBox(height: 24.0),
              _buildStateGallery(stateNarratives),
              const SizedBox(height: 24.0),
              _buildAllSection(allSamples, demoElevation, demoPadding),
              const SizedBox(height: 24.0),
              _buildResolveWithSection(resolveWithSamples),
              const SizedBox(height: 24.0),
              _buildFromMapSection(fromMapSamples),
              const SizedBox(height: 24.0),
              _buildStateColorSection(stateColorSamples),
              const SizedBox(height: 24.0),
              _buildCursorSection(cursorSamples, customCursorSamples),
              const SizedBox(height: 24.0),
              _buildBorderSection(borderSamples),
              const SizedBox(height: 24.0),
              _buildTextStyleSection(textStyleSamples),
              const SizedBox(height: 24.0),
              _buildShapeSection(shapeSamples),
              const SizedBox(height: 24.0),
              _buildLegacySection(legacySamples),
              const SizedBox(height: 24.0),
              _buildCompositeButtonStyleSection(
                compositeSamples,
                compositeButtonStyle,
              ),
              const SizedBox(height: 24.0),
              _buildStateMatrix(canonicalStates, stateMatrix),
              const SizedBox(height: 24.0),
              _buildControllerSection(controllerSnapshots),
              const SizedBox(height: 24.0),
              _buildColorLadder(ladder, sweep),
              const SizedBox(height: 24.0),
              _buildSummaryCard(totalStates, totalSamples, controllerSteps),
              const SizedBox(height: 16.0),
              const Center(
                child: Text(
                  'Deep Demo - WidgetState Family - Flutter Material',
                  style:
                      TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS - resolved-style snapshot for the composite ButtonStyle.
// =============================================================================
Map<String, dynamic> _resolveAll(
  String label,
  Set<WidgetState> states,
  ButtonStyle style,
) {
  return <String, dynamic>{
    'label': label,
    'background':
        style.backgroundColor?.resolve(states) ?? const Color(0xFF000000),
    'foreground':
        style.foregroundColor?.resolve(states) ?? const Color(0xFFFFFFFF),
    'elevation': style.elevation?.resolve(states) ?? 0.0,
    'overlay': style.overlayColor?.resolve(states) ?? const Color(0x00000000),
    'borderWidth': style.side?.resolve(states)?.width ?? 0.0,
    'borderColor':
        style.side?.resolve(states)?.color ?? const Color(0x00000000),
  };
}

// =============================================================================
// HELPER WIDGETS - UI building blocks for the demo cards.
// =============================================================================

Widget _buildHeader(int totalStates, int totalSamples, int controllerSteps) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF311B92), Color(0xFF1A237E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'WidgetState Family',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Deep Demo: WidgetStateProperty, WidgetStateColor, WidgetStateBorderSide,'
          ' WidgetStateMouseCursor, WidgetStateTextStyle, WidgetStateOutlinedBorder',
          style: TextStyle(fontSize: 14.0, color: Color(0xFFC5CAE9)),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            _headerChip('$totalStates canonical states', const Color(0xFF7E57C2)),
            const SizedBox(width: 8.0),
            _headerChip('$totalSamples resolution samples',
                const Color(0xFF5E35B1)),
            const SizedBox(width: 8.0),
            _headerChip('$controllerSteps controller steps',
                const Color(0xFF512DA8)),
          ],
        ),
      ],
    ),
  );
}

Widget _headerChip(String text, Color background) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: background.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildConceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFB39DDB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFF5E35B1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.palette,
                color: Color(0xFFFFFFFF),
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'How resolution works',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'A WidgetStateProperty<T> is a function from Set<WidgetState> to T. '
          'When a Material widget paints itself it builds a state set from '
          'the live conditions (hover, focus, press, drag, selection, '
          'disability, error, scrolled-under) and asks every state-driven '
          'property to resolve against that set. Properties differ only in '
          'how the function is supplied:',
          style: TextStyle(fontSize: 13.5, height: 1.55),
        ),
        const SizedBox(height: 12.0),
        _bullet('WidgetStateProperty.all(value) - constant function.'),
        _bullet(
            'WidgetStateProperty.resolveWith((states) => value) - imperative.'),
        _bullet(
            'WidgetStateProperty.fromMap({constraint: value, ...}) - declarative.'),
        _bullet(
            'WidgetStateColor / WidgetStateBorderSide / WidgetStateTextStyle '
            '/ WidgetStateOutlinedBorder / WidgetStateMouseCursor - typed sugar.'),
        _bullet(
            'MaterialState* - legacy typedefs; resolve identically to WidgetState*.'),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '- ',
          style: TextStyle(fontSize: 13.5, color: Color(0xFF5E35B1)),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.0, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color accent,
  required Color background,
  required Widget child,
  IconData? icon,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                icon ?? Icons.bolt,
                color: const Color(0xFFFFFFFF),
                size: 18.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _buildStateGallery(List<Map<String, dynamic>> narratives) {
  return _sectionShell(
    title: '1. The eight canonical WidgetState values',
    subtitle: 'Every state-driven property resolves against this set',
    accent: const Color(0xFF1976D2),
    background: const Color(0xFFE3F2FD),
    icon: Icons.dashboard,
    child: Column(
      children: narratives
          .map<Widget>((Map<String, dynamic> n) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: (n['color'] as Color).withValues(alpha: 0.35),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 42.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: n['color'] as Color,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          n['icon'] as IconData,
                          color: const Color(0xFFFFFFFF),
                          size: 22.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'WidgetState.${n['label'] as String}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: n['color'] as Color,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              n['narrative'] as String,
                              style: const TextStyle(
                                fontSize: 12.5,
                                height: 1.4,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildAllSection(
  List<Map<String, dynamic>> samples,
  double demoElevation,
  EdgeInsetsGeometry demoPadding,
) {
  return _sectionShell(
    title: '2. WidgetStateProperty.all',
    subtitle: 'Constant resolver - same value for every state set',
    accent: const Color(0xFF3949AB),
    background: const Color(0xFFE8EAF6),
    icon: Icons.lock_outline,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: samples
              .map<Widget>((Map<String, dynamic> s) => _swatchTile(
                    label: s['label'] as String,
                    color: s['resolved'] as Color,
                  ))
              .toList(),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFF9FA8DA),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: demoPadding,
            child: Row(
              children: <Widget>[
                Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3949AB),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  'constantElevation = ${demoElevation.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                    color: Color(0xFF1A237E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swatchTile({required String label, required Color color}) {
  return Container(
    width: 130.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: const Color(0xFF000000).withValues(alpha: 0.08),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          _hex(color),
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF757575),
          ),
        ),
      ],
    ),
  );
}

String _hex(Color c) {
  final int r = (c.r * 255.0).round() & 0xFF;
  final int g = (c.g * 255.0).round() & 0xFF;
  final int b = (c.b * 255.0).round() & 0xFF;
  return '#${_pad(r)}${_pad(g)}${_pad(b)}';
}

String _pad(int v) {
  final String s = v.toRadixString(16).toUpperCase();
  return s.length == 1 ? '0$s' : s;
}

Widget _buildResolveWithSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '3. WidgetStateProperty.resolveWith',
    subtitle: 'Imperative resolver - inspect the state set in code',
    accent: const Color(0xFF6A1B9A),
    background: const Color(0xFFF3E5F5),
    icon: Icons.functions,
    child: Column(
      children: samples
          .map<Widget>((Map<String, dynamic> s) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 140.0,
                        child: Text(
                          s['label'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 28.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          color: s['background'] as Color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        width: 80.0,
                        child: Text(
                          _hex(s['background'] as Color),
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _elevationBar(s['elevation'] as double),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'e=${(s['elevation'] as double).toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _elevationBar(double elevation) {
  return Container(
    height: 6.0,
    decoration: BoxDecoration(
      color: const Color(0xFFE1BEE7),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: (elevation / 8.0).clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF6A1B9A),
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    ),
  );
}

Widget _buildFromMapSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '4. WidgetStateProperty.fromMap',
    subtitle: 'Declarative resolver - first matching constraint wins',
    accent: const Color(0xFF00695C),
    background: const Color(0xFFE0F2F1),
    icon: Icons.account_tree,
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: samples
          .map<Widget>((Map<String, dynamic> s) => _swatchTile(
                label: s['label'] as String,
                color: s['background'] as Color,
              ))
          .toList(),
    ),
  );
}

Widget _buildStateColorSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '5. WidgetStateColor',
    subtitle: 'A Color that is also a WidgetStateProperty<Color>',
    accent: const Color(0xFFC2185B),
    background: const Color(0xFFFCE4EC),
    icon: Icons.color_lens,
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: samples
          .map<Widget>((Map<String, dynamic> s) => _swatchTile(
                label: s['label'] as String,
                color: s['color'] as Color,
              ))
          .toList(),
    ),
  );
}

Widget _buildCursorSection(
  List<Map<String, dynamic>> clickable,
  List<Map<String, dynamic>> custom,
) {
  return _sectionShell(
    title: '6. WidgetStateMouseCursor',
    subtitle: 'System cursor changes with the resolved state set',
    accent: const Color(0xFFD84315),
    background: const Color(0xFFFBE9E7),
    icon: Icons.mouse,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'WidgetStateMouseCursor.clickable',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFBF360C),
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          children: clickable
              .map<Widget>((Map<String, dynamic> s) => _cursorRow(s))
              .toList(),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Custom resolver',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFBF360C),
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          children: custom
              .map<Widget>((Map<String, dynamic> s) => _cursorRow(s))
              .toList(),
        ),
      ],
    ),
  );
}

Widget _cursorRow(Map<String, dynamic> s) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: const Color(0xFFFFCCBC), width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90.0,
            child: Text(
              s['label'] as String,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.arrow_right_alt,
              size: 16.0, color: Color(0xFFD84315)),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              s['cursor'] as String,
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFFBF360C),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBorderSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '7. WidgetStateBorderSide',
    subtitle: 'BorderSide that varies per state',
    accent: const Color(0xFF2E7D32),
    background: const Color(0xFFE8F5E9),
    icon: Icons.border_outer,
    child: Column(
      children: samples
          .map<Widget>((Map<String, dynamic> s) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: s['color'] as Color,
                      width: (s['width'] as double).clamp(0.5, 4.0),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 120.0,
                        child: Text(
                          s['label'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 14.0,
                        height: 14.0,
                        decoration: BoxDecoration(
                          color: s['color'] as Color,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${_hex(s['color'] as Color)}  '
                        'width=${(s['width'] as double).toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildTextStyleSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '8. WidgetStateTextStyle',
    subtitle: 'TextStyle that varies per state',
    accent: const Color(0xFF1565C0),
    background: const Color(0xFFE3F2FD),
    icon: Icons.text_fields,
    child: Column(
      children: samples
          .map<Widget>((Map<String, dynamic> s) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 110.0,
                        child: Text(
                          s['label'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'The quick brown fox',
                          style: TextStyle(
                            color: s['color'] as Color,
                            fontWeight: s['weight'] as FontWeight,
                            fontStyle: s['fontStyle'] as FontStyle,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildShapeSection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '9. WidgetStateProperty<OutlinedBorder>',
    subtitle: 'Shape that varies per state',
    accent: const Color(0xFFE65100),
    background: const Color(0xFFFFF3E0),
    icon: Icons.crop_square,
    child: Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: samples
          .map<Widget>((Map<String, dynamic> s) => Container(
                width: 130.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(
                    ((s['radius'] as double) > 100.0)
                        ? 40.0
                        : (s['radius'] as double),
                  ),
                  border: Border.all(
                    color: const Color(0xFFE65100),
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      s['label'] as String,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFBF360C),
                      ),
                    ),
                    Text(
                      'r=${(s['radius'] as double).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildLegacySection(List<Map<String, dynamic>> samples) {
  return _sectionShell(
    title: '10. Legacy MaterialState aliases',
    subtitle: 'MaterialState* still works and resolves identically',
    accent: const Color(0xFF455A64),
    background: const Color(0xFFECEFF1),
    icon: Icons.history,
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: samples
          .map<Widget>((Map<String, dynamic> s) => _swatchTile(
                label: s['label'] as String,
                color: s['color'] as Color,
              ))
          .toList(),
    ),
  );
}

Widget _buildCompositeButtonStyleSection(
  List<Map<String, dynamic>> samples,
  ButtonStyle style,
) {
  return _sectionShell(
    title: '11. Composite ButtonStyle',
    subtitle:
        'background + foreground + overlay + elevation + shape + side + cursor',
    accent: const Color(0xFF0D47A1),
    background: const Color(0xFFE3F2FD),
    icon: Icons.smart_button,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: samples
              .map<Widget>((Map<String, dynamic> s) => _compositeCard(s))
              .toList(),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: const Color(0xFFBBDEFB),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Live buttons (visual state shown via onPressed)',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Enabled'),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: null,
                    child: const Text('Disabled'),
                  ),
                  OutlinedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                  FilledButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Filled'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _compositeCard(Map<String, dynamic> s) {
  final Color bg = s['background'] as Color;
  final Color fg = s['foreground'] as Color;
  final double elev = s['elevation'] as double;
  final Color overlay = s['overlay'] as Color;
  return Container(
    width: 170.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFF90CAF9), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.06),
          blurRadius: elev * 1.5,
          offset: Offset(0.0, elev * 0.6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: overlay,
                width: double.infinity,
                height: 28.0,
              ),
              Text(
                'Button',
                style: TextStyle(
                  color: fg,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          s['label'] as String,
          style: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        Text(
          'bg=${_hex(bg)}',
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF757575),
          ),
        ),
        Text(
          'fg=${_hex(fg)}',
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF757575),
          ),
        ),
        Text(
          'elev=${elev.toStringAsFixed(1)}',
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF757575),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateMatrix(
  List<WidgetState> states,
  List<List<Map<String, dynamic>>> matrix,
) {
  const List<String> headers = <String>[
    'state',
    'bg',
    'elev',
    'border',
    'b-w',
    'text',
    'shape-r',
  ];
  return _sectionShell(
    title: '12. State x property matrix',
    subtitle: 'Every canonical state resolved against every property',
    accent: const Color(0xFF4527A0),
    background: const Color(0xFFEDE7F6),
    icon: Icons.grid_on,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: headers
                .map<Widget>((String h) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          h,
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: Color(0xFF311B92),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const Divider(height: 6.0, color: Color(0xFFD1C4E9)),
          Column(
            children: List<Widget>.generate(states.length, (int i) {
              final WidgetState s = states[i];
              final List<Map<String, dynamic>> row = matrix[i];
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: i.isEven
                      ? const Color(0xFFFAFAFC)
                      : const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          s.name,
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Color(0xFF4527A0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: _matrixCell(row[0])),
                    Expanded(child: _matrixCell(row[1])),
                    Expanded(child: _matrixCell(row[2])),
                    Expanded(child: _matrixCell(row[3])),
                    Expanded(child: _matrixCell(row[4])),
                    Expanded(child: _matrixCell(row[5])),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}

Widget _matrixCell(Map<String, dynamic> cell) {
  final String kind = cell['kind'] as String;
  final dynamic value = cell['value'];
  if (value is Color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 16.0,
        decoration: BoxDecoration(
          color: value,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(
            color: const Color(0xFF000000).withValues(alpha: 0.08),
            width: 0.5,
          ),
        ),
      ),
    );
  }
  if (value is double) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        kind == 'shape-r' && value > 100.0
            ? 'stadium'
            : value.toStringAsFixed(1),
        style: const TextStyle(
          fontSize: 10.5,
          fontFamily: 'monospace',
          color: Color(0xFF311B92),
        ),
      ),
    );
  }
  return const SizedBox.shrink();
}

Widget _buildControllerSection(List<Map<String, dynamic>> snapshots) {
  return _sectionShell(
    title: '13. WidgetStatesController',
    subtitle: 'Listenable<Set<WidgetState>> - mutate state and observe',
    accent: const Color(0xFF00838F),
    background: const Color(0xFFE0F7FA),
    icon: Icons.timeline,
    child: Column(
      children: snapshots
          .map<Widget>((Map<String, dynamic> s) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 160.0,
                        child: Text(
                          s['step'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006064),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: (s['states'] as List<dynamic>)
                              .map<Widget>((dynamic name) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00838F),
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      name as String,
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildColorLadder(
  List<Map<String, dynamic>> ladder,
  List<Color> sweep,
) {
  return _sectionShell(
    title: '14. Resolved color ladder',
    subtitle: 'Visual sweep through every canonical state and combination',
    accent: const Color(0xFF1B5E20),
    background: const Color(0xFFE8F5E9),
    icon: Icons.stairs,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: ladder
              .map<Widget>((Map<String, dynamic> entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 160.0,
                          child: Text(
                            entry['name'] as String,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: entry['color'] as Color,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          _hex(entry['color'] as Color),
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Decorative HSV sweep (dart:math)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: sweep
              .map<Widget>((Color c) => Expanded(
                    child: Container(
                      height: 22.0,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        color: c,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildSummaryCard(
  int totalStates,
  int totalSamples,
  int controllerSteps,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Demo Summary',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 12.0),
        _summaryRow('Canonical WidgetState values', '$totalStates'),
        _summaryRow('Resolution samples computed', '$totalSamples'),
        _summaryRow('Controller mutation steps', '$controllerSteps'),
        _summaryRow('WidgetStateProperty constructors', '3'),
        _summaryRow('Typed sugar classes shown', '5'),
        _summaryRow('Legacy MaterialState aliases', 'all'),
        const SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              'WidgetState family resolved successfully',
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
