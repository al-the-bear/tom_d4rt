// D4rt Deep Demo: AppLifecycleState - Application Lifecycle States
// This demo comprehensively explores AppLifecycleState enum which represents
// the various states an application can be in during its lifecycle.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: AppLifecycleState Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: State Transitions
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Platform Differences
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: WidgetsBindingObserver Implementation
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Resource Management Guidelines
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: State Comparison
  // ═══════════════════════════════════════════════════════════════════════════════
  final states = AppLifecycleState.values;
  for (var i = 0; i < states.length; i++) {
    for (var j = i + 1; j < states.length; j++) {
    }
  }


  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.purple.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.refresh, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'AppLifecycleState',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Application Lifecycle Management',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // State Cards
          Text(
            'Lifecycle States',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          _buildStateCard(
            'resumed',
            'App is visible, has focus, user interacting',
            Icons.play_circle_fill,
            Colors.green,
            ['Animations run', 'Full resources', 'User input active'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'inactive',
            'Visible but lost focus - transitional',
            Icons.pause_circle_outline,
            Colors.orange,
            ['System dialog shown', 'Phone call incoming', 'Switching apps'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'hidden',
            'All views hidden, still running',
            Icons.visibility_off,
            Colors.blueGrey,
            ['Window minimized', 'Desktop platforms', 'Background tasks ok'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'paused',
            'Not visible, running in background',
            Icons.stop_circle_outlined,
            Colors.red,
            ['In background', 'Save state now', 'May be killed'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'detached',
            'Engine running, no host views',
            Icons.link_off,
            Colors.grey,
            ['App starting/stopping', 'No UI possible', 'Minimal operations'],
          ),

          SizedBox(height: 24),

          // Lifecycle Flow
          Text(
            'Lifecycle Flow',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFlowRow('📲 App Launch:', 'detached → resumed'),
                Divider(),
                _buildFlowRow(
                  '📴 To Background:',
                  'resumed → inactive → hidden → paused',
                ),
                Divider(),
                _buildFlowRow(
                  '📲 To Foreground:',
                  'paused → hidden → inactive → resumed',
                ),
                Divider(),
                _buildFlowRow('📞 Phone Call:', 'resumed → inactive → resumed'),
                Divider(),
                _buildFlowRow(
                  '❌ App Close:',
                  'resumed → inactive → paused → detached',
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Resource Management Matrix
          Text(
            'Resource Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildResourceRow('Resource', [
                  'resumed',
                  'inactive',
                  'paused',
                ], true),
                Divider(height: 1),
                _buildResourceRow('Animations', [
                  '▶️ Run',
                  '⏸️ Pause',
                  '⏹️ Stop',
                ], false),
                _buildResourceRow('Audio', [
                  '🔊 Play',
                  '🔉 Pause',
                  '🔇 Stop',
                ], false),
                _buildResourceRow('Camera', [
                  '📷 Active',
                  '❌ Release',
                  '❌ Release',
                ], false),
                _buildResourceRow('Network', [
                  '🌐 Active',
                  '🌐 Active',
                  '📉 Reduce',
                ], false),
                _buildResourceRow('Location', [
                  '📍 Active',
                  '📍 Active',
                  '❌ Stop',
                ], false),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Platform Comparison
          Text(
            'Platform Behavior',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildPlatformBox(
                  'Mobile',
                  Icons.phone_android,
                  Colors.green,
                  ['All states used', 'paused = background', 'May be killed'],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPlatformBox(
                  'Desktop',
                  Icons.desktop_mac,
                  Colors.blue,
                  ['hidden common', 'Window minimize', 'Rarely paused'],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPlatformBox('Web', Icons.web, Colors.orange, [
                  'Limited support',
                  'Tab visibility',
                  'Page API',
                ]),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🔄 AppLifecycleState Deep Demo',
                style: TextStyle(
                  color: Colors.indigo.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStateCard(
  String name,
  String description,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: points
                    .map(
                      (p) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          p,
                          style: TextStyle(fontSize: 10, color: color),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowRow(String label, String flow) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(flow, style: TextStyle(color: Colors.indigo.shade700)),
        ),
      ],
    ),
  );
}

Widget _buildResourceRow(String resource, List<String> values, bool isHeader) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            resource,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
        ...values.map(
          (v) => Expanded(
            child: Text(
              v,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformBox(
  String platform,
  IconData icon,
  Color color,
  List<String> features,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 6),
        Text(
          platform,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        ...features.map(
          (f) => Text(
            f,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
