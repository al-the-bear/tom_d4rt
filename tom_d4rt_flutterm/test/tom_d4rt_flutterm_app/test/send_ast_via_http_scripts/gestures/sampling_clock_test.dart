// ignore_for_file: avoid_print
// D4rt test script: Tests SamplingClock concepts from package:flutter/gestures.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== SamplingClock Visual Demo ===');
  debugPrint(
    'Demonstrating clock sampling, timing concepts, and frequency visualization',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('SamplingClock Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Clock Displays'),
            SizedBox(height: 8),
            _buildClockDisplays(),
            SizedBox(height: 24),
            _buildSectionHeader('Sampling Intervals'),
            SizedBox(height: 8),
            _buildSamplingIntervals(),
            SizedBox(height: 24),
            _buildSectionHeader('Time Resolution Comparison'),
            SizedBox(height: 8),
            _buildTimeResolution(),
            SizedBox(height: 24),
            _buildSectionHeader('Visual Sampling Timeline'),
            SizedBox(height: 8),
            _buildSamplingTimeline(),
            SizedBox(height: 24),
            _buildSectionHeader('Frequency Indicators'),
            SizedBox(height: 8),
            _buildFrequencyIndicators(),
            SizedBox(height: 24),
            _buildSectionHeader('Clock Source Comparison'),
            SizedBox(height: 8),
            _buildClockSourceComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('Event Timing Visualization'),
            SizedBox(height: 8),
            _buildEventTimingVis(),
            SizedBox(height: 24),
            _buildSectionHeader('Jitter Display'),
            SizedBox(height: 8),
            _buildJitterDisplay(),
            SizedBox(height: 24),
            _buildSectionHeader('Clock Properties'),
            SizedBox(height: 8),
            _buildClockProperties(),
            SizedBox(height: 24),
            _buildSectionHeader('Duration Concepts'),
            SizedBox(height: 8),
            _buildDurationConcepts(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  debugPrint('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF00695C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildClockDisplays() {
  debugPrint('Building clock displays');
  List<Map<String, dynamic>> clocks = [
    {
      'label': 'System Clock',
      'time': '14:32:05.123',
      'icon': Icons.access_time,
      'color': Color(0xFF2196F3),
      'desc': 'Wall clock time from the OS',
    },
    {
      'label': 'Monotonic Clock',
      'time': '00:45:12.456',
      'icon': Icons.timer,
      'color': Color(0xFF4CAF50),
      'desc': 'Steady clock since boot',
    },
    {
      'label': 'Sampling Clock',
      'time': '00:45:12.448',
      'icon': Icons.shutter_speed,
      'color': Color(0xFFFF9800),
      'desc': 'Used for pointer event sampling',
    },
  ];
  return Column(
    children: clocks.map((c) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c['color'] as Color, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (c['color'] as Color).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                c['icon'] as IconData,
                color: c['color'] as Color,
                size: 32,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['label'] as String,
                    style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    c['time'] as String,
                    style: TextStyle(
                      color: c['color'] as Color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    c['desc'] as String,
                    style: TextStyle(color: Color(0xFF78909C), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildSamplingIntervals() {
  debugPrint('Building sampling intervals');
  List<Map<String, dynamic>> intervals = [
    {'label': '60 Hz', 'ms': 16.67, 'color': Color(0xFF4CAF50)},
    {'label': '120 Hz', 'ms': 8.33, 'color': Color(0xFF2196F3)},
    {'label': '240 Hz', 'ms': 4.17, 'color': Color(0xFF9C27B0)},
    {'label': '360 Hz', 'ms': 2.78, 'color': Color(0xFFFF9800)},
    {'label': '1000 Hz', 'ms': 1.0, 'color': Color(0xFFF44336)},
  ];
  double maxMs = 16.67;
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: intervals.map((i) {
        double fraction = (i['ms'] as double) / maxMs;
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  i['label'] as String,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Expanded(
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: fraction,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: i['color'] as Color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '${i['ms']}ms',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

Widget _buildTimeResolution() {
  debugPrint('Building time resolution comparison');
  List<Map<String, dynamic>> resolutions = [
    {
      'name': 'Milliseconds',
      'example': '16ms',
      'blocks': 1,
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Microseconds',
      'example': '16667us',
      'blocks': 3,
      'color': Color(0xFF2196F3),
    },
    {
      'name': 'Nanoseconds',
      'example': '16666666ns',
      'blocks': 9,
      'color': Color(0xFF9C27B0),
    },
  ];
  return Column(
    children: resolutions.map((r) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: r['color'] as Color, width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text(
                r['name'] as String,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Row(
                children: List.generate(r['blocks'] as int, (i) {
                  return Container(
                    margin: EdgeInsets.only(right: 3),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: r['color'] as Color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                r['example'] as String,
                style: TextStyle(
                  color: Color(0xFF00E676),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildSamplingTimeline() {
  debugPrint('Building sampling timeline');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sample Points at Different Frequencies',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildTimelineRow('10 Hz', 3, Color(0xFFF44336)),
        SizedBox(height: 10),
        _buildTimelineRow('30 Hz', 7, Color(0xFFFF9800)),
        SizedBox(height: 10),
        _buildTimelineRow('60 Hz', 14, Color(0xFF4CAF50)),
        SizedBox(height: 10),
        _buildTimelineRow('120 Hz', 28, Color(0xFF2196F3)),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F3460), Color(0xFF00E676), Color(0xFF0F3460)],
            ),
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0ms',
              style: TextStyle(
                color: Color(0xFF546E7A),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              '100ms',
              style: TextStyle(
                color: Color(0xFF546E7A),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              '200ms',
              style: TextStyle(
                color: Color(0xFF546E7A),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTimelineRow(String label, int points, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 50,
        child: Text(
          label,
          style: TextStyle(color: color, fontSize: 11, fontFamily: 'monospace'),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(points > 30 ? 30 : points, (i) {
              return Container(
                width: 4,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
      ),
    ],
  );
}

Widget _buildFrequencyIndicators() {
  debugPrint('Building frequency indicators');
  List<Map<String, dynamic>> frequencies = [
    {
      'hz': 10,
      'label': 'Low',
      'color': Color(0xFFF44336),
      'use': 'Legacy devices',
    },
    {
      'hz': 60,
      'label': 'Standard',
      'color': Color(0xFF4CAF50),
      'use': 'Most phones/monitors',
    },
    {
      'hz': 120,
      'label': 'High',
      'color': Color(0xFF2196F3),
      'use': 'ProMotion, gaming',
    },
    {
      'hz': 240,
      'label': 'Ultra',
      'color': Color(0xFF9C27B0),
      'use': 'Gaming monitors',
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: frequencies.map((f) {
      return Container(
        width: 170,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: f['color'] as Color, width: 2),
          boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
        ),
        child: Column(
          children: [
            Text(
              '${f['hz']}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: f['color'] as Color,
              ),
            ),
            Text(
              'Hz',
              style: TextStyle(fontSize: 14, color: f['color'] as Color),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (f['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                f['label'] as String,
                style: TextStyle(
                  color: f['color'] as Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              f['use'] as String,
              style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildClockSourceComparison() {
  debugPrint('Building clock source comparison');
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Property',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'System',
                  style: TextStyle(
                    color: Color(0xFF90CAF9),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Monotonic',
                  style: TextStyle(
                    color: Color(0xFFA5D6A7),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Sampling',
                  style: TextStyle(
                    color: Color(0xFFFFCC80),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildComparisonRow('Jumps on NTP', 'Yes', 'No', 'No', false),
        _buildComparisonRow('Monotonic', 'No', 'Yes', 'Yes', true),
        _buildComparisonRow('Resolution', 'ms', 'us', 'us', false),
        _buildComparisonRow('Purpose', 'Display', 'Timing', 'Events', true),
        _buildComparisonRow('Epoch-based', 'Yes', 'No', 'No', false),
        _buildComparisonRow('Pauses in sleep', 'No', 'Maybe', 'Maybe', true),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String prop,
  String sys,
  String mono,
  String samp,
  bool alt,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: alt ? Color(0xFFF5F5F5) : Color(0xFFFFFFFF),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            prop,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            sys,
            style: TextStyle(fontSize: 12, color: Color(0xFF1565C0)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            mono,
            style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            samp,
            style: TextStyle(fontSize: 12, color: Color(0xFFE65100)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEventTimingVis() {
  debugPrint('Building event timing visualization');
  List<Map<String, dynamic>> eventSlots = [
    {
      'event': 'vsync',
      'start': 0.0,
      'width': 0.05,
      'color': Color(0xFF4CAF50),
      'row': 0,
    },
    {
      'event': 'input',
      'start': 0.05,
      'width': 0.08,
      'color': Color(0xFF2196F3),
      'row': 1,
    },
    {
      'event': 'build',
      'start': 0.13,
      'width': 0.20,
      'color': Color(0xFFFF9800),
      'row': 2,
    },
    {
      'event': 'layout',
      'start': 0.33,
      'width': 0.15,
      'color': Color(0xFF9C27B0),
      'row': 2,
    },
    {
      'event': 'paint',
      'start': 0.48,
      'width': 0.18,
      'color': Color(0xFFF44336),
      'row': 2,
    },
    {
      'event': 'composite',
      'start': 0.66,
      'width': 0.10,
      'color': Color(0xFF00BCD4),
      'row': 3,
    },
    {
      'event': 'vsync',
      'start': 1.0,
      'width': 0.05,
      'color': Color(0xFF4CAF50),
      'row': 0,
    },
  ];
  List<String> rowLabels = ['VSync', 'Input', 'Framework', 'GPU'];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frame Timeline (16.67ms budget)',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        ...List.generate(4, (rowIdx) {
          List<Map<String, dynamic>> rowEvents = eventSlots
              .where((e) => e['row'] == rowIdx)
              .toList();
          return Container(
            margin: EdgeInsets.only(bottom: 6),
            height: 30,
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    rowLabels[rowIdx],
                    style: TextStyle(color: Color(0xFF78909C), fontSize: 11),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFF16213E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      ...rowEvents.map((e) {
                        return Positioned(
                          left: (e['start'] as double) * 250,
                          width: (e['width'] as double) * 250,
                          top: 2,
                          bottom: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: e['color'] as Color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                e['event'] as String,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 9,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
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

Widget _buildJitterDisplay() {
  debugPrint('Building jitter display');
  List<double> jitterValues = [
    0.5,
    1.2,
    0.3,
    2.1,
    0.8,
    1.5,
    0.4,
    3.0,
    0.6,
    1.1,
    0.7,
    0.2,
    1.8,
    0.9,
    0.5,
  ];
  double maxJitter = 3.0;
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sample-to-Sample Jitter (ms)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: jitterValues.map((j) {
                  double fraction = j / maxJitter;
                  Color barColor = j < 1.0
                      ? Color(0xFF4CAF50)
                      : (j < 2.0 ? Color(0xFFFF9800) : Color(0xFFF44336));
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      height: fraction * 120,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildJitterLegend(Color(0xFF4CAF50), '< 1ms (Good)'),
                _buildJitterLegend(Color(0xFFFF9800), '1-2ms (Fair)'),
                _buildJitterLegend(Color(0xFFF44336), '> 2ms (Poor)'),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Row(
        children: [
          _buildJitterStatCard('Mean', '1.04ms', Color(0xFF2196F3)),
          SizedBox(width: 8),
          _buildJitterStatCard('Max', '3.0ms', Color(0xFFF44336)),
          SizedBox(width: 8),
          _buildJitterStatCard('Min', '0.2ms', Color(0xFF4CAF50)),
          SizedBox(width: 8),
          _buildJitterStatCard('Std Dev', '0.72ms', Color(0xFF9C27B0)),
        ],
      ),
    ],
  );
}

Widget _buildJitterLegend(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
    ],
  );
}

Widget _buildJitterStatCard(String label, String value, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildClockProperties() {
  debugPrint('Building clock properties');
  List<Map<String, dynamic>> props = [
    {
      'prop': 'now()',
      'type': 'DateTime',
      'desc': 'Returns the current wall clock time',
      'icon': Icons.access_time,
    },
    {
      'prop': 'stopwatch()',
      'type': 'Stopwatch',
      'desc': 'Creates a new stopwatch using this clock',
      'icon': Icons.timer,
    },
    {
      'prop': 'elapsed',
      'type': 'Duration',
      'desc': 'Time since clock was started',
      'icon': Icons.timelapse,
    },
    {
      'prop': 'elapsedMicroseconds',
      'type': 'int',
      'desc': 'Microseconds since clock start',
      'icon': Icons.speed,
    },
  ];
  return Column(
    children: props.map((p) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [BoxShadow(color: Color(0x08000000), blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                p['icon'] as IconData,
                color: Color(0xFF00695C),
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        p['prop'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          p['type'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF1565C0),
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildDurationConcepts() {
  debugPrint('Building duration concepts');
  List<Map<String, dynamic>> durations = [
    {'label': '1 frame @60Hz', 'ms': 16.67, 'color': Color(0xFF4CAF50)},
    {'label': '1 frame @120Hz', 'ms': 8.33, 'color': Color(0xFF2196F3)},
    {'label': 'Touch latency (typ)', 'ms': 50.0, 'color': Color(0xFFFF9800)},
    {'label': 'Human reaction', 'ms': 200.0, 'color': Color(0xFF9C27B0)},
    {'label': 'Animation (typical)', 'ms': 300.0, 'color': Color(0xFFF44336)},
    {'label': 'Page transition', 'ms': 500.0, 'color': Color(0xFF795548)},
  ];
  double maxMs = 500.0;
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        ...durations.map((d) {
          double fraction = (d['ms'] as double) / maxMs;
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      d['label'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${d['ms']}ms',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: d['color'] as Color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: fraction,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: d['color'] as Color,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF4CAF50)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF2E7D32)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'SamplingClock provides the timestamp source for pointer event resampling. It allows gesture detection to work with consistent time values, reducing jitter in input processing.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
