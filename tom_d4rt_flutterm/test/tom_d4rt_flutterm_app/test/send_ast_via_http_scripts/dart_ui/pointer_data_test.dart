import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class _PointerScenario {
  const _PointerScenario({
    required this.title,
    required this.purpose,
    required this.icon,
    required this.swatch,
    required this.data,
  });

  final String title;
  final String purpose;
  final IconData icon;
  final Color swatch;
  final ui.PointerData data;
}

class _ProbeFlag {
  const _ProbeFlag({
    required this.label,
    required this.isHealthy,
    required this.description,
  });

  final String label;
  final bool isHealthy;
  final String description;
}

dynamic build(BuildContext context) {
  final List<_PointerScenario> timeline = <_PointerScenario>[];
  final DateTime sessionStarted = DateTime.now();

  double x = 180;
  double y = 180;
  double deltaX = 0;
  double deltaY = 0;
  double pressure = 0.5;
  double distance = 0;
  double size = 18;
  double radiusMajor = 16;
  double radiusMinor = 10;
  double orientation = 0;
  double tilt = 0;
  double scrollX = 0;
  double scrollY = 0;

  int buttons = 1;
  int device = 1;
  int pointerIdentifier = 42;
  int platformData = 0;
  int viewId = 0;

  bool synthesized = false;
  bool obscured = false;

  ui.PointerChange change = ui.PointerChange.move;
  ui.PointerDeviceKind kind = ui.PointerDeviceKind.touch;

  final List<_PointerScenario> scenarioLibrary = <_PointerScenario>[
    _PointerScenario(
      title: 'Finger Tap Start',
      purpose:
          'A touch-down event with medium pressure. Use for button press interactions and tap recognizers.',
      icon: Icons.touch_app,
      swatch: const Color(0xFF2667FF),
      data: const ui.PointerData(
        change: ui.PointerChange.down,
        kind: ui.PointerDeviceKind.touch,
        physicalX: 140,
        physicalY: 210,
        pressure: 0.62,
        pressureMin: 0,
        pressureMax: 1,
        size: 24,
        radiusMajor: 18,
        radiusMinor: 12,
        buttons: 1,
        device: 11,
        pointerIdentifier: 300,
      ),
    ),
    _PointerScenario(
      title: 'Finger Drag',
      purpose:
          'A move event with deltas. Use to feed drag gestures and custom canvas interactions.',
      icon: Icons.swipe,
      swatch: const Color(0xFF0F9D58),
      data: const ui.PointerData(
        change: ui.PointerChange.move,
        kind: ui.PointerDeviceKind.touch,
        physicalX: 240,
        physicalY: 160,
        physicalDeltaX: 34,
        physicalDeltaY: -16,
        pressure: 0.71,
        pressureMin: 0,
        pressureMax: 1,
        size: 27,
        radiusMajor: 21,
        radiusMinor: 14,
        buttons: 1,
        device: 11,
        pointerIdentifier: 300,
      ),
    ),
    _PointerScenario(
      title: 'Mouse Hover',
      purpose:
          'A hover event without button presses. Useful for hover tooltips and desktop affordances.',
      icon: Icons.mouse,
      swatch: const Color(0xFF7C4DFF),
      data: const ui.PointerData(
        change: ui.PointerChange.hover,
        kind: ui.PointerDeviceKind.mouse,
        physicalX: 310,
        physicalY: 90,
        physicalDeltaX: 6,
        physicalDeltaY: -4,
        buttons: 0,
        device: 2,
        pointerIdentifier: 88,
      ),
    ),
    _PointerScenario(
      title: 'Stylus Sketch Stroke',
      purpose:
          'Stylus move with pressure and tilt/orientation. Essential for drawing tools and handwriting UIs.',
      icon: Icons.edit,
      swatch: const Color(0xFFE65100),
      data: const ui.PointerData(
        change: ui.PointerChange.move,
        kind: ui.PointerDeviceKind.stylus,
        physicalX: 80,
        physicalY: 280,
        physicalDeltaX: 18,
        physicalDeltaY: 9,
        pressure: 0.94,
        pressureMin: 0,
        pressureMax: 1,
        size: 10,
        radiusMajor: 8,
        radiusMinor: 4,
        tilt: 0.53,
        orientation: 0.89,
        buttons: 1,
        device: 21,
        pointerIdentifier: 501,
      ),
    ),
    _PointerScenario(
      title: 'Trackpad Scroll Signal',
      purpose:
          'Signal event carrying scroll delta values. Use for zoom or list scrolling behavior.',
      icon: Icons.swap_vert_circle,
      swatch: const Color(0xFF00838F),
      data: const ui.PointerData(
        change: ui.PointerChange.move,
        kind: ui.PointerDeviceKind.trackpad,
        physicalX: 210,
        physicalY: 300,
        scrollDeltaX: -12,
        scrollDeltaY: 36,
        buttons: 0,
        device: 5,
        pointerIdentifier: 900,
      ),
    ),
    _PointerScenario(
      title: 'Synthesized Accessibility Nudge',
      purpose:
          'A synthesized event resembles generated input; useful to validate semantics-driven interactions.',
      icon: Icons.accessibility_new,
      swatch: const Color(0xFF455A64),
      data: const ui.PointerData(
        change: ui.PointerChange.up,
        kind: ui.PointerDeviceKind.touch,
        physicalX: 100,
        physicalY: 120,
        synthesized: true,
        obscured: false,
        buttons: 0,
        device: 55,
        pointerIdentifier: 1337,
      ),
    ),
  ];

  ui.PointerData buildLiveData() {
    return ui.PointerData(
      timeStamp: DateTime.now().difference(sessionStarted),
      change: change,
      kind: kind,
      physicalX: x,
      physicalY: y,
      physicalDeltaX: deltaX,
      physicalDeltaY: deltaY,
      pressure: pressure,
      pressureMin: 0,
      pressureMax: 1,
      distance: distance,
      distanceMax: 1,
      size: size,
      radiusMajor: radiusMajor,
      radiusMinor: radiusMinor,
      radiusMin: 0,
      radiusMax: 50,
      orientation: orientation,
      tilt: tilt,
      scrollDeltaX: scrollX,
      scrollDeltaY: scrollY,
      buttons: buttons,
      device: device,
      pointerIdentifier: pointerIdentifier,
      platformData: platformData,
      viewId: viewId,
      synthesized: synthesized,
      obscured: obscured,
    );
  }

  void loadScenario(_PointerScenario scenario) {
    final ui.PointerData data = scenario.data;
    change = data.change;
    kind = data.kind;
    x = data.physicalX;
    y = data.physicalY;
    deltaX = data.physicalDeltaX;
    deltaY = data.physicalDeltaY;
    pressure = data.pressure;
    distance = data.distance;
    size = data.size;
    radiusMajor = data.radiusMajor;
    radiusMinor = data.radiusMinor;
    orientation = data.orientation;
    tilt = data.tilt;
    scrollX = data.scrollDeltaX;
    scrollY = data.scrollDeltaY;
    buttons = data.buttons;
    device = data.device;
    pointerIdentifier = data.pointerIdentifier;
    platformData = data.platformData;
    viewId = data.viewId;
    synthesized = data.synthesized;
    obscured = data.obscured;
  }

  List<_ProbeFlag> buildProbeFlags(ui.PointerData data) {
    final List<_ProbeFlag> flags = <_ProbeFlag>[
      _ProbeFlag(
        label: 'Coordinate In Stage',
        isHealthy: data.physicalX >= 0 &&
            data.physicalX <= 360 &&
            data.physicalY >= 0 &&
            data.physicalY <= 360,
        description:
            'Coordinates should map to your render box. Out-of-range values often indicate wrong transform space.',
      ),
      _ProbeFlag(
        label: 'Pressure Normalized',
        isHealthy: data.pressure >= data.pressureMin &&
            data.pressure <= math.max(data.pressureMax, 1),
        description:
            'Pressure should stay within [pressureMin, pressureMax] for reliable brush dynamics.',
      ),
      _ProbeFlag(
        label: 'Scroll Context',
        isHealthy: data.kind != ui.PointerDeviceKind.touch ||
            (data.scrollDeltaX == 0 && data.scrollDeltaY == 0),
        description:
            'Touch streams usually use move deltas, while wheel/trackpad interactions populate scroll deltas.',
      ),
      _ProbeFlag(
        label: 'Button Semantics',
        isHealthy:
            data.change == ui.PointerChange.hover ? data.buttons == 0 : true,
        description:
            'Hover should typically not have pressed buttons; down/move can carry non-zero button masks.',
      ),
      _ProbeFlag(
        label: 'Stylus Detail Completeness',
        isHealthy: data.kind != ui.PointerDeviceKind.stylus ||
            data.tilt.abs() > 0 ||
            data.orientation.abs() > 0 ||
            data.pressure > 0,
        description:
            'Stylus interactions are richer when tilt, orientation, or pressure values are populated.',
      ),
    ];
    return flags;
  }

  Color colorForChange(ui.PointerChange value) {
    switch (value) {
      case ui.PointerChange.cancel:
        return const Color(0xFFD32F2F);
      case ui.PointerChange.add:
        return const Color(0xFF5D4037);
      case ui.PointerChange.remove:
        return const Color(0xFF6D4C41);
      case ui.PointerChange.hover:
        return const Color(0xFF5E35B1);
      case ui.PointerChange.down:
        return const Color(0xFF1E88E5);
      case ui.PointerChange.move:
        return const Color(0xFF43A047);
      case ui.PointerChange.up:
        return const Color(0xFF00897B);
      case ui.PointerChange.panZoomStart:
        return const Color(0xFFFB8C00);
      case ui.PointerChange.panZoomUpdate:
        return const Color(0xFFF57C00);
      case ui.PointerChange.panZoomEnd:
        return const Color(0xFFEF6C00);
    }
  }

  IconData iconForKind(ui.PointerDeviceKind value) {
    switch (value) {
      case ui.PointerDeviceKind.touch:
        return Icons.touch_app;
      case ui.PointerDeviceKind.mouse:
        return Icons.mouse;
      case ui.PointerDeviceKind.stylus:
        return Icons.edit;
      case ui.PointerDeviceKind.invertedStylus:
        return Icons.brush;
      case ui.PointerDeviceKind.trackpad:
        return Icons.laptop_mac;
      case ui.PointerDeviceKind.unknown:
        return Icons.help_outline;
    }
  }

  Widget metricTile({
    required String label,
    required String value,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: accent.withValues(alpha: 0.82),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget buildFieldSectionTitle(String title, String subtitle, IconData icon) {
    return Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final ui.PointerData liveData = buildLiveData();
      final Color accent = colorForChange(liveData.change);
      final List<_ProbeFlag> probes = buildProbeFlags(liveData);

      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF061A40), Color(0xFF0353A4)],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'PointerData Interaction Lab',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'PointerData is the low-level engine packet that carries physical pointer details '
                    '(position, deltas, pressure, buttons, tilt, and scroll). '
                    'This deep demo shows how each field changes interaction behavior in an interpreter-run Flutter script.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        side: BorderSide.none,
                        avatar: Icon(iconForKind(liveData.kind), color: Colors.white),
                        label: Text(
                          'Kind: ${liveData.kind.name}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        side: BorderSide.none,
                        avatar:
                            const Icon(Icons.track_changes, color: Colors.white),
                        label: Text(
                          'Change: ${liveData.change.name}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        side: BorderSide.none,
                        avatar:
                            const Icon(Icons.speed, color: Colors.white),
                        label: Text(
                          'Pressure ${liveData.pressure.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Live Constructor Controls',
              'Compose real PointerData packets and inspect the resulting values.',
              Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 14,
                    runSpacing: 12,
                    children: <Widget>[
                      SizedBox(
                        width: 220,
                        child: DropdownButtonFormField<ui.PointerChange>(
                          initialValue: change,
                          decoration: const InputDecoration(
                            labelText: 'PointerChange',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: ui.PointerChange.values
                              .map((ui.PointerChange value) {
                            return DropdownMenuItem<ui.PointerChange>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (ui.PointerChange? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: DropdownButtonFormField<ui.PointerDeviceKind>(
                          initialValue: kind,
                          decoration: const InputDecoration(
                            labelText: 'PointerDeviceKind',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: ui.PointerDeviceKind.values
                              .map((ui.PointerDeviceKind value) {
                            return DropdownMenuItem<ui.PointerDeviceKind>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (ui.PointerDeviceKind? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              kind = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          initialValue: buttons.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Buttons',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            setState(() {
                              buttons = int.tryParse(value) ?? buttons;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          initialValue: device.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Device Id',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            setState(() {
                              device = int.tryParse(value) ?? device;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Coordinate + Delta Controls',
                      style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w700)),
                  Slider(
                    value: x,
                    min: 0,
                    max: 360,
                    label: 'physicalX ${x.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => x = value),
                  ),
                  Slider(
                    value: y,
                    min: 0,
                    max: 360,
                    label: 'physicalY ${y.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => y = value),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          value: deltaX,
                          min: -60,
                          max: 60,
                          label: 'deltaX ${deltaX.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => deltaX = value),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: deltaY,
                          min: -60,
                          max: 60,
                          label: 'deltaY ${deltaY.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => deltaY = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Touch Geometry + Stylus Metrics',
                      style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w700)),
                  Slider(
                    value: pressure,
                    min: 0,
                    max: 1,
                    label: 'pressure ${pressure.toStringAsFixed(2)}',
                    onChanged: (double value) =>
                        setState(() => pressure = value),
                  ),
                  Slider(
                    value: size,
                    min: 0,
                    max: 60,
                    label: 'size ${size.toStringAsFixed(1)}',
                    onChanged: (double value) => setState(() => size = value),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          value: radiusMajor,
                          min: 0,
                          max: 60,
                          label: 'radiusMajor ${radiusMajor.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => radiusMajor = value),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: radiusMinor,
                          min: 0,
                          max: 60,
                          label: 'radiusMinor ${radiusMinor.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => radiusMinor = value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          value: tilt,
                          min: -1,
                          max: 1,
                          label: 'tilt ${tilt.toStringAsFixed(2)}',
                          onChanged: (double value) => setState(() => tilt = value),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: orientation,
                          min: -math.pi,
                          max: math.pi,
                          label:
                              'orientation ${orientation.toStringAsFixed(2)}',
                          onChanged: (double value) =>
                              setState(() => orientation = value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          value: scrollX,
                          min: -60,
                          max: 60,
                          label: 'scrollDeltaX ${scrollX.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => scrollX = value),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: scrollY,
                          min: -60,
                          max: 60,
                          label: 'scrollDeltaY ${scrollY.toStringAsFixed(1)}',
                          onChanged: (double value) =>
                              setState(() => scrollY = value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: CheckboxListTile(
                          value: synthesized,
                          dense: true,
                          title: const Text('Synthesized'),
                          subtitle: const Text('Generated event stream'),
                          onChanged: (bool? value) {
                            setState(() {
                              synthesized = value ?? false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          value: obscured,
                          dense: true,
                          title: const Text('Obscured'),
                          subtitle: const Text('Input is visually hidden'),
                          onChanged: (bool? value) {
                            setState(() {
                              obscured = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            final ui.PointerData snapshot = buildLiveData();
                            timeline.insert(
                              0,
                              _PointerScenario(
                                title:
                                    'Recorded ${snapshot.change.name} • ${snapshot.kind.name}',
                                purpose:
                                    'Snapshot captured from live control values.',
                                icon: iconForKind(snapshot.kind),
                                swatch: colorForChange(snapshot.change),
                                data: snapshot,
                              ),
                            );
                            if (timeline.length > 18) {
                              timeline.removeLast();
                            }
                          });
                        },
                        icon: const Icon(Icons.add_chart),
                        label: const Text('Record Snapshot'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            timeline.clear();
                          });
                        },
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('Clear Timeline'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            distance = 0;
                            scrollX = 0;
                            scrollY = 0;
                            synthesized = false;
                            obscured = false;
                          });
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Normalize Signals'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Pointer Stage Visualizer',
              'A canvas that plots live coordinates, deltas, pressure radius, and timeline breadcrumbs.',
              Icons.grid_on,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: SizedBox(
                height: 360,
                child: CustomPaint(
                  painter: _PointerStagePainter(
                    liveData: liveData,
                    accent: accent,
                    history: timeline.map((_PointerScenario e) => e.data).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Property Inspector',
              'Read the resulting fields exactly as they would be forwarded from engine packets.',
              Icons.analytics,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'physicalX / physicalY',
                    value:
                        '${liveData.physicalX.toStringAsFixed(1)}, ${liveData.physicalY.toStringAsFixed(1)}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'physicalDelta',
                    value:
                        '${liveData.physicalDeltaX.toStringAsFixed(1)}, ${liveData.physicalDeltaY.toStringAsFixed(1)}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'pressure',
                    value:
                        '${liveData.pressure.toStringAsFixed(2)} (range ${liveData.pressureMin.toStringAsFixed(1)}..${liveData.pressureMax.toStringAsFixed(1)})',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'radiusMajor / radiusMinor',
                    value:
                        '${liveData.radiusMajor.toStringAsFixed(1)} / ${liveData.radiusMinor.toStringAsFixed(1)}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'scrollDelta',
                    value:
                        '${liveData.scrollDeltaX.toStringAsFixed(1)}, ${liveData.scrollDeltaY.toStringAsFixed(1)}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'orientation / tilt',
                    value:
                        '${liveData.orientation.toStringAsFixed(2)} / ${liveData.tilt.toStringAsFixed(2)}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'buttons / device',
                    value: '${liveData.buttons} / ${liveData.device}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'pointerIdentifier',
                    value: liveData.pointerIdentifier.toString(),
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'viewId / platformData',
                    value: '${liveData.viewId} / ${liveData.platformData}',
                    accent: accent,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: metricTile(
                    label: 'flags',
                    value:
                        'synthesized=${liveData.synthesized}, obscured=${liveData.obscured}',
                    accent: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Scenario Gallery',
              'Load curated examples showing different PointerData intents and device classes.',
              Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarioLibrary.map((_PointerScenario scenario) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scenario.swatch.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: scenario.swatch.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scenario.swatch.withValues(alpha: 0.25),
                        ),
                        child: Icon(scenario.icon, color: scenario.swatch, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              scenario.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: scenario.swatch,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scenario.purpose,
                              style: TextStyle(
                                height: 1.3,
                                color: Colors.blueGrey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '(${scenario.data.physicalX.toStringAsFixed(1)}, ${scenario.data.physicalY.toStringAsFixed(1)}) '
                              'delta(${scenario.data.physicalDeltaX.toStringAsFixed(1)}, ${scenario.data.physicalDeltaY.toStringAsFixed(1)}) '
                              'pressure ${scenario.data.pressure.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            loadScenario(scenario);
                            timeline.insert(0, scenario);
                            if (timeline.length > 18) {
                              timeline.removeLast();
                            }
                          });
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Load'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Interpreter Probe Dashboard',
              'Quick quality checks for values that commonly break custom gesture logic.',
              Icons.health_and_safety,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: Column(
                children: probes.map((_ProbeFlag flag) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: flag.isHealthy
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: flag.isHealthy
                            ? const Color(0xFFA5D6A7)
                            : const Color(0xFFEF9A9A),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          flag.isHealthy ? Icons.check_circle : Icons.warning,
                          color: flag.isHealthy
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFC62828),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                flag.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: flag.isHealthy
                                      ? const Color(0xFF1B5E20)
                                      : const Color(0xFFB71C1C),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                flag.description,
                                style: TextStyle(
                                  height: 1.25,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Timeline Replay',
              'Recent PointerData packets captured from controls or loaded scenarios.',
              Icons.timeline,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No timeline entries yet. Record snapshots or load scenarios to build a stream.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _PointerScenario> entry) {
                        final int index = entry.key;
                        final _PointerScenario item = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: item.swatch.withValues(alpha: 0.08),
                            border: Border.all(
                                color: item.swatch.withValues(alpha: 0.35)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '#${index + 1}',
                                style: TextStyle(
                                  color: item.swatch,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(item.icon, color: item.swatch),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.data.change.name} · ${item.data.kind.name} · '
                                      '(${item.data.physicalX.toStringAsFixed(1)}, ${item.data.physicalY.toStringAsFixed(1)}) · '
                                      'pressure ${item.data.pressure.toStringAsFixed(2)} · '
                                      'scroll ${item.data.scrollDeltaX.toStringAsFixed(1)}/${item.data.scrollDeltaY.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Field Usage Guide',
              'What each PointerData group is for when wiring engine packets to interaction logic.',
              Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade100),
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Column(
                children: const <Widget>[
                  _GuideRow(
                    label: 'physicalX / physicalY',
                    detail:
                        'Absolute physical coordinates in logical pixels. Use after applying transform and device pixel ratio assumptions.',
                  ),
                  _GuideRow(
                    label: 'physicalDeltaX / physicalDeltaY',
                    detail:
                        'Movement between packets; ideal for drag velocity and delta-based drawing updates.',
                  ),
                  _GuideRow(
                    label: 'pressure / size / radius*',
                    detail:
                        'Finger or stylus contact richness. Drives brush width, opacity, or pressure-sensitive controls.',
                  ),
                  _GuideRow(
                    label: 'orientation / tilt',
                    detail:
                        'Stylus angle information, useful for calligraphy and directional tool responses.',
                  ),
                  _GuideRow(
                    label: 'scrollDeltaX / scrollDeltaY',
                    detail:
                        'Signal-style movement (wheel/trackpad), often consumed by scroll or zoom systems instead of drag handlers.',
                  ),
                  _GuideRow(
                    label: 'change / kind / buttons',
                    detail:
                        'Event semantics: lifecycle stage, device source, and pressed-button bitmask.',
                  ),
                  _GuideRow(
                    label: 'device / pointerIdentifier / viewId',
                    detail:
                        'Routing metadata to keep multi-device and multi-view streams separated and stable.',
                  ),
                  _GuideRow(
                    label: 'synthesized / obscured',
                    detail:
                        'Flags for generated packets or hidden input channels; helpful for accessibility and secure-entry behavior.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            buildFieldSectionTitle(
              'Reference Constructor',
              'A direct snippet matching the fields you can manipulate above.',
              Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'final packet = ui.PointerData(\n'
                '  change: ui.PointerChange.${liveData.change.name},\n'
                '  kind: ui.PointerDeviceKind.${liveData.kind.name},\n'
                '  physicalX: ${liveData.physicalX.toStringAsFixed(1)},\n'
                '  physicalY: ${liveData.physicalY.toStringAsFixed(1)},\n'
                '  physicalDeltaX: ${liveData.physicalDeltaX.toStringAsFixed(1)},\n'
                '  physicalDeltaY: ${liveData.physicalDeltaY.toStringAsFixed(1)},\n'
                '  pressure: ${liveData.pressure.toStringAsFixed(2)},\n'
                '  scrollDeltaX: ${liveData.scrollDeltaX.toStringAsFixed(1)},\n'
                '  scrollDeltaY: ${liveData.scrollDeltaY.toStringAsFixed(1)},\n'
                '  buttons: ${liveData.buttons},\n'
                '  device: ${liveData.device},\n'
                '  pointerIdentifier: ${liveData.pointerIdentifier},\n'
                '  synthesized: ${liveData.synthesized},\n'
                ');',
                style: const TextStyle(
                  color: Color(0xFFCEE8FF),
                  fontFamily: 'monospace',
                  height: 1.4,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFF1F8E9), Color(0xFFE3F2FD)],
                ),
                border: Border.all(color: const Color(0xFFB2DFDB)),
              ),
              child: Text(
                'Summary: This script demonstrates PointerData as a low-level event packet and visualizes '
                'how position, movement, force, geometry, scroll, and metadata fields shape runtime interaction behavior. '
                'Use the controls and scenario gallery to quickly prototype packet streams before wiring custom recognizers.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _GuideRow extends StatelessWidget {
  const _GuideRow({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey.shade50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PointerStagePainter extends CustomPainter {
  _PointerStagePainter({
    required this.liveData,
    required this.accent,
    required this.history,
  });

  final ui.PointerData liveData;
  final Color accent;
  final List<ui.PointerData> history;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF8FBFF), Color(0xFFE8F1FF)],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      background,
    );

    final Paint gridPaint = Paint()
      ..color = const Color(0x22000000)
      ..strokeWidth = 1;
    for (double gx = 0; gx <= size.width; gx += 40) {
      canvas.drawLine(Offset(gx, 0), Offset(gx, size.height), gridPaint);
    }
    for (double gy = 0; gy <= size.height; gy += 40) {
      canvas.drawLine(Offset(0, gy), Offset(size.width, gy), gridPaint);
    }

    final Paint historyPaint = Paint()..strokeWidth = 2.4;
    for (int i = 0; i < history.length; i++) {
      final ui.PointerData item = history[i];
      historyPaint.color = const Color(0xFF607D8B)
          .withValues(alpha: math.max(0.1, 0.8 - (i * 0.08)));
      final Offset point = Offset(
        item.physicalX.clamp(0, size.width),
        item.physicalY.clamp(0, size.height),
      );
      canvas.drawCircle(point, 4 + math.max(0, 4 - (i * 0.3)), historyPaint);
    }

    final Offset livePoint = Offset(
      liveData.physicalX.clamp(0, size.width),
      liveData.physicalY.clamp(0, size.height),
    );

    final Paint radiusPaint = Paint()
      ..color = accent.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: livePoint,
        width: math.max(6, liveData.radiusMajor * 2),
        height: math.max(6, liveData.radiusMinor * 2),
      ),
      radiusPaint,
    );

    final Paint pointerPaint = Paint()
      ..color = accent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(livePoint, math.max(5, 8 + (liveData.pressure * 10)), pointerPaint);

    final Paint vectorPaint = Paint()
      ..color = const Color(0xFF263238)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      livePoint,
      livePoint + Offset(liveData.physicalDeltaX, liveData.physicalDeltaY),
      vectorPaint,
    );

    final Paint scrollPaint = Paint()
      ..color = const Color(0xFF006064)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      livePoint,
      livePoint + Offset(liveData.scrollDeltaX, liveData.scrollDeltaY),
      scrollPaint,
    );

    final Offset orientationTip = Offset(
      livePoint.dx + math.cos(liveData.orientation) * 30,
      livePoint.dy + math.sin(liveData.orientation) * 30,
    );
    final Paint orientationPaint = Paint()
      ..color = const Color(0xFFFF6F00)
      ..strokeWidth = 2.4;
    canvas.drawLine(livePoint, orientationTip, orientationPaint);

    final TextPainter legend = TextPainter(
      text: TextSpan(
        text: 'Live ${liveData.change.name}/${liveData.kind.name} '
            'at (${liveData.physicalX.toStringAsFixed(1)}, ${liveData.physicalY.toStringAsFixed(1)})',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    legend.paint(canvas, const Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _PointerStagePainter oldDelegate) {
    return oldDelegate.liveData != liveData ||
        oldDelegate.history.length != history.length ||
        oldDelegate.accent != accent;
  }
}
