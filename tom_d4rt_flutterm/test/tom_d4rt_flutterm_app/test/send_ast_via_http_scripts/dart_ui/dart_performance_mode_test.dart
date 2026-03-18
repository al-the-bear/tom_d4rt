// D4rt test script: Deep Demo for DartPerformanceMode from dart:ui
// DartPerformanceMode controls Dart VM runtime behavior for performance tuning
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DartPerformanceMode Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = ui.DartPerformanceMode.values;
  print('DartPerformanceMode values: $values');
  print('Count: ${values.length}');

  for (final mode in values) {
    print('DartPerformanceMode.${mode.name}: index=${mode.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL MODES
  // ═══════════════════════════════════════════════════════════════════════════

  final balanced = ui.DartPerformanceMode.balanced;
  final latency = ui.DartPerformanceMode.latency;
  final throughput = ui.DartPerformanceMode.throughput;
  final memory = ui.DartPerformanceMode.memory;

  print('balanced: $balanced');
  print('latency: $latency');
  print('throughput: $throughput');
  print('memory: $memory');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('balanced == balanced: ${balanced == ui.DartPerformanceMode.balanced}');
  print('balanced == latency: ${balanced == latency}');
  print('balanced.index: ${balanced.index}');
  print('latency.index: ${latency.index}');
  print('throughput.index: ${throughput.index}');
  print('memory.index: ${memory.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: NAME ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  for (final mode in values) {
    print('name: ${mode.name}, toString: $mode');
  }

  print('DartPerformanceMode demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF263238), Color(0xFF546E7A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.blueGrey.withValues(alpha: 0.3),
                      blurRadius: 12, offset: Offset(0, 6)),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.speed, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text('DartPerformanceMode',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    SizedBox(height: 6),
                    Text('Dart VM runtime performance tuning',
                      style: TextStyle(fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85))),
                  ],
                ),
              ),

              // ── Demo 1: Mode Cards ──
              _sectionTitle('1. PERFORMANCE MODES'),
              _modeCard(
                balanced, 'balanced',
                'Default mode. VM balances latency, throughput, and memory.',
                Icons.balance, Color(0xFF00695C),
                {'Latency': 0.5, 'Throughput': 0.5, 'Memory': 0.5},
              ),
              _modeCard(
                latency, 'latency',
                'Optimizes for low-latency responses. Reduces GC pauses, '
                'smaller heap, more frequent collections.',
                Icons.flash_on, Color(0xFFE65100),
                {'Latency': 0.9, 'Throughput': 0.3, 'Memory': 0.4},
              ),
              _modeCard(
                throughput, 'throughput',
                'Optimizes for maximum throughput. Larger heap, less frequent '
                'GC, longer pauses acceptable.',
                Icons.trending_up, Color(0xFF1565C0),
                {'Latency': 0.3, 'Throughput': 0.9, 'Memory': 0.3},
              ),
              _modeCard(
                memory, 'memory',
                'Optimizes for low memory usage. Aggressive GC, smaller heap, '
                'may reduce throughput.',
                Icons.memory, Color(0xFF6A1B9A),
                {'Latency': 0.4, 'Throughput': 0.3, 'Memory': 0.9},
              ),

              // ── Demo 2: Radar Comparison ──
              _sectionTitle('2. MODE COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _comparisonHeader(),
                    SizedBox(height: 8),
                    _comparisonRow('balanced', 0.5, 0.5, 0.5, Color(0xFF00695C)),
                    _comparisonRow('latency', 0.9, 0.3, 0.4, Color(0xFFE65100)),
                    _comparisonRow('throughput', 0.3, 0.9, 0.3, Color(0xFF1565C0)),
                    _comparisonRow('memory', 0.4, 0.3, 0.9, Color(0xFF6A1B9A)),
                  ],
                ),
              ),

              // ── Demo 3: Use Cases ──
              _sectionTitle('3. RECOMMENDED USE CASES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _useCaseRow(Icons.animation, 'UI Animations',
                      'latency — smooth 60fps rendering', Color(0xFFE65100)),
                    Divider(height: 20),
                    _useCaseRow(Icons.import_export, 'Data Processing',
                      'throughput — batch operations', Color(0xFF1565C0)),
                    Divider(height: 20),
                    _useCaseRow(Icons.phone_android, 'Low-end Devices',
                      'memory — constrained resources', Color(0xFF6A1B9A)),
                    Divider(height: 20),
                    _useCaseRow(Icons.apps, 'General App',
                      'balanced — good default', Color(0xFF00695C)),
                    Divider(height: 20),
                    _useCaseRow(Icons.videogame_asset, 'Games',
                      'latency — consistent frame times', Color(0xFFE65100)),
                    Divider(height: 20),
                    _useCaseRow(Icons.cloud_download, 'Background Sync',
                      'throughput — max data rate', Color(0xFF1565C0)),
                  ],
                ),
              ),

              // ── Demo 4: Enum Properties ──
              _sectionTitle('4. ENUM PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: values.map((mode) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              color: _modeColor(mode),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('${mode.index}', style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(mode.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('index: ${mode.index}',
                              style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ── Demo 5: Equality ──
              _sectionTitle('5. EQUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow('balanced == balanced', balanced == ui.DartPerformanceMode.balanced, true),
                    SizedBox(height: 8),
                    _equalityRow('balanced == latency', balanced == latency, false),
                    SizedBox(height: 8),
                    _equalityRow('latency == latency', latency == ui.DartPerformanceMode.latency, true),
                  ],
                ),
              ),

              // ── Demo 6: GC Impact ──
              _sectionTitle('6. GC BEHAVIOR IMPACT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _gcRow('GC Frequency', [0.5, 0.8, 0.3, 0.9]),
                    SizedBox(height: 12),
                    _gcRow('GC Pause Duration', [0.5, 0.2, 0.8, 0.3]),
                    SizedBox(height: 12),
                    _gcRow('Heap Size', [0.5, 0.3, 0.8, 0.2]),
                    SizedBox(height: 12),
                    _gcRow('Allocation Speed', [0.5, 0.7, 0.8, 0.4]),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _legendDot(Color(0xFF00695C), 'balanced'),
                        _legendDot(Color(0xFFE65100), 'latency'),
                        _legendDot(Color(0xFF1565C0), 'throughput'),
                        _legendDot(Color(0xFF6A1B9A), 'memory'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(title, style: TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700,
      color: Color(0xFF455A64), letterSpacing: 1.0,
    )),
  );
}

Color _modeColor(ui.DartPerformanceMode mode) {
  switch (mode) {
    case ui.DartPerformanceMode.balanced: return Color(0xFF00695C);
    case ui.DartPerformanceMode.latency: return Color(0xFFE65100);
    case ui.DartPerformanceMode.throughput: return Color(0xFF1565C0);
    case ui.DartPerformanceMode.memory: return Color(0xFF6A1B9A);
  }
}

Widget _modeCard(ui.DartPerformanceMode mode, String name, String desc,
    IconData icon, Color color, Map<String, double> metrics) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('index: ${mode.index}',
                    style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        SizedBox(height: 12),
        ...metrics.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text(entry.key, style: TextStyle(fontSize: 11)),
                ),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xFFEEEEEE),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: entry.value,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _comparisonHeader() {
  return Row(
    children: [
      Container(width: 90, child: Text('Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
      Expanded(child: Text('Latency', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
      Expanded(child: Text('Throughput', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
      Expanded(child: Text('Memory', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
    ],
  );
}

Widget _comparisonRow(String name, double lat, double tp, double mem, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 90,
          child: Row(
            children: [
              Container(width: 8, height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              SizedBox(width: 6),
              Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Expanded(child: _miniBar(lat, color)),
        SizedBox(width: 4),
        Expanded(child: _miniBar(tp, color)),
        SizedBox(width: 4),
        Expanded(child: _miniBar(mem, color)),
      ],
    ),
  );
}

Widget _miniBar(double value, Color color) {
  return Container(
    height: 12,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Color(0xFFEEEEEE),
    ),
    child: FractionallySizedBox(
      widthFactor: value,
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
      ),
    ),
  );
}

Widget _useCaseRow(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _equalityRow(String label, bool result, bool expected) {
  return Row(
    children: [
      Icon(result == expected ? Icons.check_circle : Icons.cancel,
        color: result == expected ? Colors.green : Colors.red, size: 20),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 13, fontFamily: 'monospace')),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('$result', style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 12,
          color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
        )),
      ),
    ],
  );
}

Widget _gcRow(String label, List<double> values) {
  final colors = [Color(0xFF00695C), Color(0xFFE65100), Color(0xFF1565C0), Color(0xFF6A1B9A)];
  return Row(
    children: [
      Container(
        width: 130,
        child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ),
      ...values.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: colors[entry.key].withValues(alpha: entry.value),
              ),
            ),
          ),
        );
      }),
    ],
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 8, height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 9)),
    ],
  );
}
