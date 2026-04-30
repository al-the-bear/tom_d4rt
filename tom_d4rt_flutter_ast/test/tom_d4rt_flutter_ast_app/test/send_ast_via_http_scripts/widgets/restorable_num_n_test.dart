import 'package:flutter/material.dart';

// =============================================================================
// RestorableNumN<T extends num?> — Sensor Dashboard Demo
// =============================================================================
//
// This file is a deep, teaching-grade demo for `RestorableNumN<T extends num?>`
// from `package:flutter/widgets.dart` (re-exported via material.dart). The demo
// wraps the abstract-ish generic base together with its two concrete typed
// subclasses (`RestorableIntN` and `RestorableDoubleN`) inside a single cool-
// palette Sensor Dashboard screen.
//
// The story is as follows:
//
//   A remote weather station exposes six field sensors. Each sensor may go
//   offline at any moment, which in our state model is represented by `null`
//   rather than `0`. The dashboard lets the operator select a sensor, bring
//   it on- or off-line, change the numeric reporting mode for temperature,
//   and inspect a small sparkline of recent readings. All sensor state is
//   held in `RestorableNumN`-family properties and registered through
//   `RestorationMixin`, so a UI restart restores the exact field state.
//
// Why `RestorableNumN<num?>` and not just `RestorableIntN` / `RestorableDoubleN`?
//   - `RestorableNumN<num?>` accepts nullable int OR nullable double as the
//     same field without committing to a concrete numeric subtype.
//   - `RestorableIntN`/`RestorableDoubleN` give you a narrower compile-time
//     contract when you know the reading unit never changes shape.
//   - The demo shows both in the same screen so learners can see the seam.
//
// Strict analyzer contract:
//   - No `// ignore_for_file:` anywhere.
//   - `debugPrint` instead of `print`; no `foundation.dart` import.
//   - `withValues(alpha: x)` instead of the deprecated `.withOpacity(x)`.
//   - Zero unused imports / locals / dead code.
//   - No `CustomPaint` — dashed ring is built from `Transform.rotate` + dots.
//
// =============================================================================

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------
//
// Cool palette: deep slate, steel blue, mint for online. Dusty slate-grey for
// offline dashed outlines. We intentionally avoid amber / red primary hues so
// the demo does not collide with another parallel subagent's style brief.

const Color _slate900 = Color(0xFF0F1720);
const Color _slate700 = Color(0xFF283241);
const Color _slate500 = Color(0xFF4A5A6E);
const Color _slate300 = Color(0xFF93A2B4);
const Color _slate200 = Color(0xFFB9C3D0);
const Color _slate100 = Color(0xFFD7DEE7);
const Color _slate050 = Color(0xFFEDF1F6);
const Color _steelBlue = Color(0xFF3E7CB1);
const Color _steelDeep = Color(0xFF264F78);
const Color _mint500 = Color(0xFF2FBF9F);
const Color _mint300 = Color(0xFF7ED9C3);
const Color _mint100 = Color(0xFFD6F1E8);

// -----------------------------------------------------------------------------
// Sensor metadata
// -----------------------------------------------------------------------------

/// Identifies one sensor slot on the dashboard. Ordering matters — this is
/// the order in which pills and gauges are laid out.
enum SensorSlot {
  temperature,
  humidity,
  wind,
  pressure,
  uv,
  rain,
}

/// Display and formatting info for each sensor slot. Kept as a plain map so
/// that the State class can stay focused on the restorable properties.
class _SensorInfo {
  const _SensorInfo({
    required this.title,
    required this.shortLabel,
    required this.unit,
    required this.accent,
    required this.maxExpected,
    required this.defaultReading,
    required this.isIntegerSensor,
  });

  final String title;
  final String shortLabel;
  final String unit;
  final Color accent;
  final double maxExpected;
  final num defaultReading;
  final bool isIntegerSensor;
}

const Map<SensorSlot, _SensorInfo> _sensorCatalogue = <SensorSlot, _SensorInfo>{
  SensorSlot.temperature: _SensorInfo(
    title: 'Air Temperature',
    shortLabel: 'TEMP',
    unit: 'C',
    accent: _steelBlue,
    maxExpected: 45,
    defaultReading: 22.4,
    isIntegerSensor: false,
  ),
  SensorSlot.humidity: _SensorInfo(
    title: 'Relative Humidity',
    shortLabel: 'HUM',
    unit: '%',
    accent: _mint500,
    maxExpected: 100,
    defaultReading: 57.0,
    isIntegerSensor: false,
  ),
  SensorSlot.wind: _SensorInfo(
    title: 'Wind Speed',
    shortLabel: 'WIND',
    unit: 'm/s',
    accent: _steelDeep,
    maxExpected: 30,
    defaultReading: 3.2,
    isIntegerSensor: false,
  ),
  SensorSlot.pressure: _SensorInfo(
    title: 'Barometric Pressure',
    shortLabel: 'PRES',
    unit: 'hPa',
    accent: _mint300,
    maxExpected: 1100,
    defaultReading: 1013,
    isIntegerSensor: true,
  ),
  SensorSlot.uv: _SensorInfo(
    title: 'UV Index',
    shortLabel: 'UV',
    unit: 'idx',
    accent: _steelBlue,
    maxExpected: 12,
    defaultReading: 4,
    isIntegerSensor: true,
  ),
  SensorSlot.rain: _SensorInfo(
    title: 'Rainfall (1h)',
    shortLabel: 'RAIN',
    unit: 'mm',
    accent: _mint500,
    maxExpected: 50,
    defaultReading: 1.4,
    isIntegerSensor: false,
  ),
};

/// Numeric reporting mode for the temperature sensor. This exists to teach
/// that `RestorableNumN<num?>` can hold int, double, or null — the same
/// property, different runtime shapes.
enum _TempMode { integer, decimal, offline }

// -----------------------------------------------------------------------------
// Top-level entry used by the test harness.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('=== RestorableNumN Deep Demo — Sensor Dashboard ===');
  return MaterialApp(
    title: 'RestorableNumN Sensor Dashboard',
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'restorable_num_n_demo_root',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: _steelBlue,
        secondary: _mint500,
        surface: _slate050,
      ),
      scaffoldBackgroundColor: _slate050,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _slate900, fontSize: 14),
        bodySmall: TextStyle(color: _slate500, fontSize: 12),
        titleMedium: TextStyle(
          color: _slate900,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: _slate900,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    home: const SensorDashboardDemo(),
  );
}

// -----------------------------------------------------------------------------
// SensorDashboardDemo — the StatefulWidget hosting all restorable state.
// -----------------------------------------------------------------------------

class SensorDashboardDemo extends StatefulWidget {
  const SensorDashboardDemo({super.key});

  @override
  State<SensorDashboardDemo> createState() => _SensorDashboardDemoState();
}

class _SensorDashboardDemoState extends State<SensorDashboardDemo>
    with RestorationMixin {
  // ------------- Restorable field sensors -------------------------------

  // Demonstrates using `RestorableNumN<num?>` directly — can hold int OR
  // double. Starts with a double reading.
  final RestorableNumN<num?> _temperatureC =
      RestorableNumN<num?>(22.4);

  // Starts offline. `null` is the explicit "no signal" state.
  final RestorableNumN<num?> _humidityPct = RestorableNumN<num?>(null);

  // Uses the concrete `RestorableDoubleN` subtype, showing that the
  // typed subclasses are still `RestorableNumN` instances underneath.
  final RestorableDoubleN _windMs = RestorableDoubleN(3.2);

  // Int-valued reading held in the base class.
  final RestorableNumN<num?> _pressureHpa = RestorableNumN<num?>(1013);

  // Concrete int subtype, narrower contract.
  final RestorableIntN _uvIndex = RestorableIntN(4);

  // Starts offline.
  final RestorableNumN<num?> _rainMm = RestorableNumN<num?>(null);

  // Whether the `_temperatureC` sensor is interpreted in "demo" (double)
  // mode or not. Combined with `_tempMode` this is how we teach the
  // int / double / null seam.
  final RestorableBool _demoMode = RestorableBool(true);

  // Currently selected sensor in the detail pane, stored as the enum index.
  final RestorableInt _selectedSensor = RestorableInt(0);

  // Recent reading history for the currently selected sensor, for the
  // sparkline strip. Not restorable — it is recomputed on first build.
  final List<double> _recentHistory = <double>[];

  // Tick counter purely for the "last reading time" badge.
  int _tickCounter = 0;

  // ------------- Lifecycle ---------------------------------------------

  @override
  String? get restorationId => 'sensor_dashboard_demo';

  @override
  void initState() {
    super.initState();
    debugPrint('SensorDashboardDemo: initState — preparing restorable sensors');
    _seedHistoryFor(SensorSlot.values[_selectedSensor.value]);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint(
      'SensorDashboardDemo: restoreState initial=$initialRestore '
      'hasOldBucket=${oldBucket != null}',
    );
    registerForRestoration(_temperatureC, 'temperature_c');
    registerForRestoration(_humidityPct, 'humidity_pct');
    registerForRestoration(_windMs, 'wind_ms');
    registerForRestoration(_pressureHpa, 'pressure_hpa');
    registerForRestoration(_uvIndex, 'uv_index');
    registerForRestoration(_rainMm, 'rain_mm');
    registerForRestoration(_demoMode, 'demo_mode');
    registerForRestoration(_selectedSensor, 'selected_sensor');
  }

  @override
  void dispose() {
    debugPrint('SensorDashboardDemo: dispose — releasing restorable sensors');
    _temperatureC.dispose();
    _humidityPct.dispose();
    _windMs.dispose();
    _pressureHpa.dispose();
    _uvIndex.dispose();
    _rainMm.dispose();
    _demoMode.dispose();
    _selectedSensor.dispose();
    super.dispose();
  }

  // ------------- Helpers ------------------------------------------------

  /// Returns the current value of a sensor slot as a nullable num. This is
  /// the single accessor used by all section builders.
  num? _readingFor(SensorSlot slot) {
    switch (slot) {
      case SensorSlot.temperature:
        return _temperatureC.value;
      case SensorSlot.humidity:
        return _humidityPct.value;
      case SensorSlot.wind:
        return _windMs.value;
      case SensorSlot.pressure:
        return _pressureHpa.value;
      case SensorSlot.uv:
        return _uvIndex.value;
      case SensorSlot.rain:
        return _rainMm.value;
    }
  }

  bool _isOnline(SensorSlot slot) => _readingFor(slot) != null;

  /// Toggle a sensor between its default-reading and `null` state.
  void _toggleOnline(SensorSlot slot) {
    final bool nowOnline = _isOnline(slot);
    final _SensorInfo info = _sensorCatalogue[slot]!;
    setState(() {
      switch (slot) {
        case SensorSlot.temperature:
          _temperatureC.value = nowOnline ? null : info.defaultReading;
          break;
        case SensorSlot.humidity:
          _humidityPct.value = nowOnline ? null : info.defaultReading;
          break;
        case SensorSlot.wind:
          _windMs.value = nowOnline ? null : info.defaultReading.toDouble();
          break;
        case SensorSlot.pressure:
          _pressureHpa.value = nowOnline ? null : info.defaultReading;
          break;
        case SensorSlot.uv:
          _uvIndex.value = nowOnline ? null : info.defaultReading.toInt();
          break;
        case SensorSlot.rain:
          _rainMm.value = nowOnline ? null : info.defaultReading;
          break;
      }
      _tickCounter++;
      _seedHistoryFor(SensorSlot.values[_selectedSensor.value]);
    });
    debugPrint(
      'SensorDashboardDemo: toggled ${info.shortLabel} '
      '-> ${nowOnline ? 'offline' : 'online'}',
    );
  }

  /// Change the temperature sensor's reporting mode. Demonstrates that
  /// `RestorableNumN<num?>` can hold an int, a double, or `null`.
  void _applyTempMode(_TempMode mode) {
    setState(() {
      switch (mode) {
        case _TempMode.integer:
          final num current = _temperatureC.value ??
              _sensorCatalogue[SensorSlot.temperature]!.defaultReading;
          _temperatureC.value = current.toInt();
          _demoMode.value = false;
          break;
        case _TempMode.decimal:
          final num current = _temperatureC.value ??
              _sensorCatalogue[SensorSlot.temperature]!.defaultReading;
          _temperatureC.value = current.toDouble();
          _demoMode.value = true;
          break;
        case _TempMode.offline:
          _temperatureC.value = null;
          _demoMode.value = false;
          break;
      }
      _tickCounter++;
      if (SensorSlot.values[_selectedSensor.value] == SensorSlot.temperature) {
        _seedHistoryFor(SensorSlot.temperature);
      }
    });
    debugPrint('SensorDashboardDemo: temperature mode -> $mode');
  }

  _TempMode get _currentTempMode {
    final num? v = _temperatureC.value;
    if (v == null) return _TempMode.offline;
    if (v is int) return _TempMode.integer;
    return _TempMode.decimal;
  }

  /// Pick a new sensor in the detail pane.
  void _selectSensor(SensorSlot slot) {
    if (_selectedSensor.value == slot.index) return;
    setState(() {
      _selectedSensor.value = slot.index;
      _seedHistoryFor(slot);
    });
    debugPrint(
      'SensorDashboardDemo: selected sensor -> ${_sensorCatalogue[slot]!.shortLabel}',
    );
  }

  /// Seed the sparkline history with deterministic pseudo-readings derived
  /// from the current sensor value. Not cryptographic — purely visual.
  void _seedHistoryFor(SensorSlot slot) {
    _recentHistory.clear();
    final num? current = _readingFor(slot);
    if (current == null) {
      for (int i = 0; i < 8; i++) {
        _recentHistory.add(0);
      }
      return;
    }
    final double base = current.toDouble();
    final double max = _sensorCatalogue[slot]!.maxExpected;
    for (int i = 0; i < 8; i++) {
      // Gentle zigzag around the base reading, clipped into [0, max].
      final double wobble = ((i * 7) % 5 - 2) * (max * 0.03);
      final double sample = (base + wobble).clamp(0, max);
      _recentHistory.add(sample);
    }
  }

  String _formatReading(SensorSlot slot, num? value) {
    if (value == null) return '—';
    final _SensorInfo info = _sensorCatalogue[slot]!;
    if (info.isIntegerSensor || value is int) {
      return value.toInt().toString();
    }
    return value.toDouble().toStringAsFixed(1);
  }

  // -------------- Build tree -------------------------------------------

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SensorSlot selectedSlot = SensorSlot.values[_selectedSensor.value];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _slate900,
        foregroundColor: Colors.white,
        title: const Text('RestorableNumN — Sensor Dashboard'),
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildTickBadge(),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext _, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(theme),
                    const SizedBox(height: 20),
                    _buildPillRow(),
                    const SizedBox(height: 24),
                    _buildGaugeGrid(),
                    const SizedBox(height: 24),
                    _buildDetailCard(selectedSlot),
                    const SizedBox(height: 24),
                    _buildTypeToggle(),
                    const SizedBox(height: 24),
                    _buildHierarchyBox(),
                    const SizedBox(height: 24),
                    _buildProseSection(),
                    const SizedBox(height: 24),
                    _buildFooter(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------- App bar live badge ---------------------------------------

  Widget _buildTickBadge() {
    final int onlineCount = SensorSlot.values.where(_isOnline).length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: _mint300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$onlineCount / ${SensorSlot.values.length} online  ·  tick $_tickCounter',
            style: const TextStyle(
              color: Colors.white,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Header ----------------------------------------------------

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_slate900, _slate700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate900.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: const Icon(
              Icons.sensors_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Field station · six nullable-num sensors',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Every reading is held in a RestorableNumN family '
                  'property. `null` means "offline", never "zero". The '
                  'whole page state survives a restart via RestorationMixin.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Pill row --------------------------------------------------

  Widget _buildPillRow() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: SensorSlot.values.map(_buildSensorPill).toList(),
    );
  }

  Widget _buildSensorPill(SensorSlot slot) {
    final _SensorInfo info = _sensorCatalogue[slot]!;
    final bool online = _isOnline(slot);
    final bool selected = slot.index == _selectedSensor.value;
    final Color fill = online
        ? info.accent.withValues(alpha: selected ? 1.0 : 0.85)
        : Colors.transparent;
    final Color textColor = online ? Colors.white : _slate500;
    final BorderSide side = online
        ? BorderSide(
            color: info.accent.withValues(alpha: 0.9),
            width: selected ? 2 : 1,
          )
        : const BorderSide(color: _slate300, width: 1);
    return InkWell(
      onTap: () => _selectSensor(slot),
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: ShapeDecoration(
          color: fill,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: side,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (online)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )
            else
              _DashedCircle(
                diameter: 10,
                color: _slate500,
                dashCount: 8,
              ),
            const SizedBox(width: 8),
            Text(
              info.shortLabel,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              online ? _formatReading(slot, _readingFor(slot)) : 'off',
              style: TextStyle(
                color: textColor.withValues(alpha: 0.85),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Gauge grid ------------------------------------------------

  Widget _buildGaugeGrid() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      childAspectRatio: 0.9,
      physics: const NeverScrollableScrollPhysics(),
      children: SensorSlot.values.map(_buildGaugeCell).toList(),
    );
  }

  Widget _buildGaugeCell(SensorSlot slot) {
    final _SensorInfo info = _sensorCatalogue[slot]!;
    final num? value = _readingFor(slot);
    final bool online = value != null;
    final double ratio = online ? (value.toDouble() / info.maxExpected).clamp(0.0, 1.0) : 0.0;
    final bool selected = slot.index == _selectedSensor.value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _selectSensor(slot),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? info.accent : _slate100,
              width: selected ? 2 : 1,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _slate500.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    info.shortLabel,
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                      color: _slate500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    online ? Icons.bolt_outlined : Icons.power_off_outlined,
                    size: 14,
                    color: online ? info.accent : _slate300,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _GaugeRing(
                      ratio: ratio,
                      color: info.accent,
                      online: online,
                      centerText: online
                          ? _formatReading(slot, value)
                          : '—',
                      subText: online ? info.unit : 'offline',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Detail card ----------------------------------------------

  Widget _buildDetailCard(SensorSlot slot) {
    final _SensorInfo info = _sensorCatalogue[slot]!;
    final num? value = _readingFor(slot);
    final bool online = value != null;
    final double ratio = online
        ? (value.toDouble() / info.maxExpected).clamp(0.0, 1.0)
        : 0.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _slate100),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _slate500.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Detail · ${info.title}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _slate900,
                ),
              ),
              const Spacer(),
              _buildTimeBadge(online),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 140,
                height: 140,
                child: _GaugeRing(
                  ratio: ratio,
                  color: info.accent,
                  online: online,
                  centerText: online ? _formatReading(slot, value) : '—',
                  subText: online ? info.unit : 'offline',
                  large: true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          online ? _formatReading(slot, value) : '—',
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w800,
                            color: _slate900,
                            fontFeatures: <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          info.unit,
                          style: const TextStyle(
                            fontSize: 14,
                            color: _slate500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _describeRuntimeShape(slot, value),
                      style: const TextStyle(
                        fontSize: 12,
                        color: _slate500,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildOnlineToggleButton(slot, online),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Recent readings',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
              color: _slate500,
            ),
          ),
          const SizedBox(height: 8),
          _buildSparkline(info, online),
          const SizedBox(height: 14),
          _buildFieldFacts(slot, value),
        ],
      ),
    );
  }

  Widget _buildTimeBadge(bool online) {
    final String label = online
        ? 'last read · tick $_tickCounter'
        : 'last read · never';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: online ? _mint100 : _slate050,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: online ? _mint300 : _slate200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            online ? Icons.schedule : Icons.signal_wifi_off_outlined,
            size: 14,
            color: online ? _steelDeep : _slate500,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: online ? _steelDeep : _slate500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineToggleButton(SensorSlot slot, bool online) {
    final _SensorInfo info = _sensorCatalogue[slot]!;
    return ElevatedButton.icon(
      onPressed: () => _toggleOnline(slot),
      icon: Icon(
        online ? Icons.wifi_off_outlined : Icons.wifi,
        size: 16,
      ),
      label: Text(
        online ? 'Take ${info.shortLabel} offline' : 'Bring ${info.shortLabel} online',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: online ? _slate700 : info.accent,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }

  Widget _buildSparkline(_SensorInfo info, bool online) {
    if (!online) {
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: _slate050,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _slate200),
        ),
        alignment: Alignment.center,
        child: const Text(
          '— offline: no history —',
          style: TextStyle(color: _slate500, fontSize: 12),
        ),
      );
    }
    final double maxSample = _recentHistory.fold<double>(
      0.01,
      (double acc, double v) => v > acc ? v : acc,
    );
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List<Widget>.generate(_recentHistory.length, (int i) {
          final double sample = _recentHistory[i];
          final double frac = (sample / maxSample).clamp(0.0, 1.0);
          final double height = 8 + frac * 50;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          info.accent.withValues(alpha: 0.4),
                          info.accent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sample.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 9,
                      color: _slate500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFieldFacts(SensorSlot slot, num? value) {
    final _SensorInfo info = _sensorCatalogue[slot]!;
    final String typeName = _describeFieldType(slot);
    final String valueRepr = value == null
        ? 'null'
        : value is int
            ? 'int(${value.toString()})'
            : 'double(${value.toStringAsFixed(3)})';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _slate050,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildFactLine('field type', typeName),
          _buildFactLine('restoration id', _restorationIdFor(slot)),
          _buildFactLine('default reading', info.defaultReading.toString()),
          _buildFactLine('current .value', valueRepr),
        ],
      ),
    );
  }

  Widget _buildFactLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _slate500,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: _slate900,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _describeFieldType(SensorSlot slot) {
    switch (slot) {
      case SensorSlot.temperature:
        return 'RestorableNumN<num?>';
      case SensorSlot.humidity:
        return 'RestorableNumN<num?>';
      case SensorSlot.wind:
        return 'RestorableDoubleN (extends RestorableNumN<double?>)';
      case SensorSlot.pressure:
        return 'RestorableNumN<num?>';
      case SensorSlot.uv:
        return 'RestorableIntN (extends RestorableNumN<int?>)';
      case SensorSlot.rain:
        return 'RestorableNumN<num?>';
    }
  }

  String _restorationIdFor(SensorSlot slot) {
    switch (slot) {
      case SensorSlot.temperature:
        return 'temperature_c';
      case SensorSlot.humidity:
        return 'humidity_pct';
      case SensorSlot.wind:
        return 'wind_ms';
      case SensorSlot.pressure:
        return 'pressure_hpa';
      case SensorSlot.uv:
        return 'uv_index';
      case SensorSlot.rain:
        return 'rain_mm';
    }
  }

  String _describeRuntimeShape(SensorSlot slot, num? value) {
    if (value == null) {
      return 'runtime: null (the sensor is offline — distinct from zero)';
    }
    if (value is int) {
      return 'runtime: int — this very property is holding an int today';
    }
    return 'runtime: double — a fractional reading is currently stored';
  }

  // ---------- Type toggle card -----------------------------------------

  Widget _buildTypeToggle() {
    final _TempMode mode = _currentTempMode;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Temperature · numeric mode',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _slate900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'RestorableNumN<num?> can hold an int, a double, or null. Flip '
            'the mode to watch the same property change its runtime shape.',
            style: TextStyle(
              fontSize: 13,
              color: _slate500,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _buildModeButton('int',
                  'toInt()', _TempMode.integer, mode == _TempMode.integer),
              const SizedBox(width: 10),
              _buildModeButton('double',
                  'toDouble()', _TempMode.decimal, mode == _TempMode.decimal),
              const SizedBox(width: 10),
              _buildModeButton('num?',
                  '= null', _TempMode.offline, mode == _TempMode.offline),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _slate050,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _slate100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: _steelBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _modeExplanation(mode),
                    style: const TextStyle(
                      fontSize: 12,
                      color: _slate700,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'demoMode=${_demoMode.value}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _slate500,
                    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(
    String title,
    String subtitle,
    _TempMode mode,
    bool active,
  ) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _applyTempMode(mode),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: active ? _steelBlue : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: active ? _steelBlue : _slate200,
              width: active ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : _slate900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: active
                      ? Colors.white.withValues(alpha: 0.8)
                      : _slate500,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _modeExplanation(_TempMode mode) {
    switch (mode) {
      case _TempMode.integer:
        return 'Holding an int: low-bandwidth telemetry sends whole degrees. '
            'RestorableNumN<num?> keeps accepting it because num? covers int.';
      case _TempMode.decimal:
        return 'Holding a double: high-resolution station reports fractions. '
            'Same field, same restoration id — the type widens automatically.';
      case _TempMode.offline:
        return 'Holding null: the sensor has no signal. `null` is NOT 0 — '
            'it means "unknown reading", which a zero would silently lie about.';
    }
  }

  // ---------- Hierarchy box --------------------------------------------

  Widget _buildHierarchyBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Class hierarchy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _slate900,
            ),
          ),
          const SizedBox(height: 14),
          _buildHierarchyRow('RestorableProperty<T>',
              'abstract base — lifecycle + bucket wiring'),
          _buildHierarchyArrow(),
          _buildHierarchyRow('RestorableValue<T>',
              'adds a mutable .value with didUpdateValue hook'),
          _buildHierarchyArrow(),
          _buildHierarchyRow('RestorableNumN<T extends num?>',
              'nullable numeric — stores int OR double OR null'),
          _buildHierarchyArrow(),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildHierarchyRow('RestorableIntN',
                    'T = int? — whole-number sensors', indent: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildHierarchyRow('RestorableDoubleN',
                    'T = double? — fractional readings', indent: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyRow(String title, String sub, {bool indent = false}) {
    return Container(
      margin: EdgeInsets.only(left: indent ? 24 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _slate050,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _steelDeep,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 11,
              color: _slate500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Icon(
        Icons.arrow_downward_rounded,
        size: 16,
        color: _slate300,
      ),
    );
  }

  // ---------- Prose section --------------------------------------------

  Widget _buildProseSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _slate900,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nullable ≠ zero',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 10),
          _buildProseRow(
            '01',
            'A `null` reading is a first-class state that means "we do '
                'not know". Substituting 0 would silently claim the field '
                'read zero, which is an entirely different fact.',
          ),
          _buildProseRow(
            '02',
            'RestorableNumN widens the typed subclasses into a single '
                'storage seam: the restoration bucket can round-trip '
                'int OR double under the same id, because its T is `num?`.',
          ),
          _buildProseRow(
            '03',
            'The typed children (`RestorableIntN`, `RestorableDoubleN`) '
                'tighten the API when the shape is stable — prefer them '
                'in production; keep `RestorableNumN<num?>` for the '
                'elastic case, such as heterogeneous sensor feeds.',
          ),
        ],
      ),
    );
  }

  Widget _buildProseRow(String tag, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _mint500.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _mint300.withValues(alpha: 0.6)),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: _mint300,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              body,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Colors.white.withValues(alpha: 0.88),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Footer ----------------------------------------------------

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _slate100),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.memory_outlined, size: 16, color: _slate500),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'All six sensor values AND the selected-sensor index, mode, '
              'and demoMode flag are registered for restoration. Restart '
              'the app under the test harness to witness exact recovery.',
              style: TextStyle(fontSize: 12, color: _slate500, height: 1.4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'tick $_tickCounter',
            style: const TextStyle(
              fontSize: 12,
              color: _slate500,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// _GaugeRing — circular background ring + colored foreground arc + center text
// =============================================================================
//
// No CustomPaint anywhere. The foreground arc is approximated with a ring of
// small dots positioned with `Transform.rotate`, activated proportional to
// the `ratio` value. Offline state draws the dashed ring style.
// =============================================================================

class _GaugeRing extends StatelessWidget {
  const _GaugeRing({
    required this.ratio,
    required this.color,
    required this.online,
    required this.centerText,
    required this.subText,
    this.large = false,
  });

  final double ratio;
  final Color color;
  final bool online;
  final String centerText;
  final String subText;
  final bool large;

  @override
  Widget build(BuildContext context) {
    const int totalDots = 40;
    final int activeDots = online ? (ratio * totalDots).round() : 0;
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        final double d = constraints.biggest.shortestSide;
        final double dotSize = large ? 5.0 : 3.5;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Faint background ring — always present.
            SizedBox(
              width: d,
              height: d,
              child: _RingDots(
                diameter: d,
                count: totalDots,
                dotSize: dotSize,
                color: _slate200,
              ),
            ),
            // Foreground coloured arc — proportional active dots.
            if (online)
              SizedBox(
                width: d,
                height: d,
                child: _RingDots(
                  diameter: d,
                  count: totalDots,
                  dotSize: dotSize + 0.5,
                  color: color,
                  maxIndex: activeDots,
                ),
              )
            else
              SizedBox(
                width: d,
                height: d,
                child: _DashedRing(
                  diameter: d,
                  dashCount: 24,
                  color: _slate300,
                ),
              ),
            // Inner faint disc to give the ring space.
            Container(
              width: d * 0.68,
              height: d * 0.68,
              decoration: BoxDecoration(
                color: online
                    ? color.withValues(alpha: 0.06)
                    : _slate050,
                shape: BoxShape.circle,
              ),
            ),
            // Centre text stack.
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  centerText,
                  style: TextStyle(
                    fontSize: large ? 30 : 20,
                    fontWeight: FontWeight.w800,
                    color: online ? _slate900 : _slate500,
                    fontFeatures: const <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subText,
                  style: TextStyle(
                    fontSize: large ? 12 : 10,
                    letterSpacing: 0.5,
                    color: online ? color : _slate500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// =============================================================================
// _RingDots — lays out a ring of N small circle dots using Transform.rotate.
// =============================================================================

class _RingDots extends StatelessWidget {
  const _RingDots({
    required this.diameter,
    required this.count,
    required this.dotSize,
    required this.color,
    this.maxIndex,
  });

  final double diameter;
  final int count;
  final double dotSize;
  final Color color;

  /// If non-null, only dots with index strictly less than `maxIndex` are
  /// drawn. Used to approximate a filling arc.
  final int? maxIndex;

  @override
  Widget build(BuildContext context) {
    final double radius = (diameter / 2) - (dotSize + 2);
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: List<Widget>.generate(count, (int i) {
          final bool active = maxIndex == null || i < maxIndex!;
          if (!active) return const SizedBox.shrink();
          // Rotate about the centre, then translate upward by `radius` to
          // place a dot on the ring at angle (i / count) * 2π.
          final double turns = i / count;
          return Transform.rotate(
            angle: turns * 2 * 3.1415926535,
            child: Transform.translate(
              offset: Offset(0, -radius),
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// =============================================================================
// _DashedRing — decorative dashed ring for offline gauges.
// =============================================================================

class _DashedRing extends StatelessWidget {
  const _DashedRing({
    required this.diameter,
    required this.dashCount,
    required this.color,
  });

  final double diameter;
  final int dashCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double radius = (diameter / 2) - 4;
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: List<Widget>.generate(dashCount, (int i) {
          final double turns = i / dashCount;
          return Transform.rotate(
            angle: turns * 2 * 3.1415926535,
            child: Transform.translate(
              offset: Offset(0, -radius),
              child: Container(
                width: 2,
                height: 6,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// =============================================================================
// _DashedCircle — tiny dashed circle used inside offline pills.
// =============================================================================

class _DashedCircle extends StatelessWidget {
  const _DashedCircle({
    required this.diameter,
    required this.color,
    required this.dashCount,
  });

  final double diameter;
  final Color color;
  final int dashCount;

  @override
  Widget build(BuildContext context) {
    final double radius = diameter / 2 - 1;
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: List<Widget>.generate(dashCount, (int i) {
          final double turns = i / dashCount;
          return Transform.rotate(
            angle: turns * 2 * 3.1415926535,
            child: Transform.translate(
              offset: Offset(0, -radius),
              child: Container(
                width: 1.5,
                height: 2.5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
