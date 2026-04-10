// Deep visual test for RepeatMode
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// Deep visual exploration of RepeatMode
/// An enum that configures animation repeat behavior.
///
/// RepeatMode is used with RepeatingAnimationBuilder to control how
/// animations repeat:
/// - restart: Animation jumps back to start (0→1, 0→1, ...)
/// - reverse: Animation plays back and forth (0→1→0→1→0→...)
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RepeatModeDemo(),
  );
}

// =============================================================================
// PALETTE: Green 700 / Orange 400
// =============================================================================
const Color _kPrimary = Color(0xFF388E3C); // Green 700
const Color _kAccent = Color(0xFFFFA726); // Orange 400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kRestart = Color(0xFF42A5F5);
const Color _kReverse = Color(0xFFAB47BC);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RepeatModeDemo extends StatefulWidget {
  @override
  State<_RepeatModeDemo> createState() => _RepeatModeDemoState();
}

class _RepeatModeDemoState extends State<_RepeatModeDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RepeatMode Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.compare), text: 'Compare Modes'),
            Tab(icon: Icon(Icons.animation), text: 'Animation Lab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _CompareModesTab(),
          _AnimationLabTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildEnumValuesSection(),
          SizedBox(height: 24),
          _buildPatternVisualization(),
          SizedBox(height: 24),
          _buildDurationBehaviorSection(),
          SizedBox(height: 24),
          _buildUsageSection(),
          SizedBox(height: 24),
          _buildUseCasesSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.repeat, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RepeatMode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'An enumeration that controls how animations repeat when using '
            'RepeatingAnimationBuilder or AnimationController.repeat().',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'enum RepeatMode { restart, reverse }',
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnumValuesSection() {
    return _TheoryCard(
      title: 'Enum Values',
      icon: Icons.list,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EnumValueCard(
            name: 'restart',
            icon: Icons.replay,
            color: _kRestart,
            description: 'Animation jumps back to the starting value when '
                'it completes. Creates a sharp discontinuity at the loop point.',
            pattern: '0 → 1 → 0 → 1 → 0 → 1 ...',
            patternNote: 'Jump at each cycle end',
          ),
          SizedBox(height: 16),
          _EnumValueCard(
            name: 'reverse',
            icon: Icons.swap_horiz,
            color: _kReverse,
            description: 'Animation smoothly reverses direction at each end. '
                'Creates a ping-pong effect with no discontinuity.',
            pattern: '0 → 1 → 0 → 1 → 0 → 1 ...',
            patternNote: 'Smooth reversal',
          ),
        ],
      ),
    );
  }

  Widget _buildPatternVisualization() {
    return _TheoryCard(
      title: 'Value Pattern Over Time',
      icon: Icons.timeline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How animation value changes over time for each mode:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _PatternGraph(mode: 'restart')),
              SizedBox(width: 16),
              Expanded(child: _PatternGraph(mode: 'reverse')),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'restart shows sawtooth pattern (instant reset), while '
                    'reverse shows triangle wave (smooth direction change)',
                    style: TextStyle(color: _kTextSecondary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationBehaviorSection() {
    return _TheoryCard(
      title: 'Duration Behavior',
      icon: Icons.timer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _DurationCard(
                  mode: 'restart',
                  color: _kRestart,
                  fullCycle: '1 × duration',
                  description: 'One complete cycle equals the specified duration. '
                      'Animation goes 0→1 in that time, then resets.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _DurationCard(
                  mode: 'reverse',
                  color: _kReverse,
                  fullCycle: '2 × duration',
                  description: 'Full cycle = forward + backward. '
                      '0→1 takes duration, 1→0 takes another duration.',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Example with 1 second duration:',
            code: '''// restart mode: 1s per cycle
// t=0s: value=0, t=1s: value=1, t=1.01s: value=0, ...

// reverse mode: 2s per full cycle
// t=0s: value=0, t=1s: value=1, t=2s: value=0, ...''',
          ),
        ],
      ),
    );
  }

  Widget _buildUsageSection() {
    return _TheoryCard(
      title: 'Usage with RepeatingAnimationBuilder',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CodeExample(
            title: 'Basic usage:',
            code: '''RepeatingAnimationBuilder<double>(
  animatable: Tween(begin: 0.0, end: 1.0),
  duration: Duration(seconds: 1),
  repeatMode: RepeatMode.reverse, // or .restart
  builder: (context, value, child) {
    return Opacity(opacity: value, child: child);
  },
  child: Text('Fading text'),
)''',
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'With AnimationController:',
            code: '''// RepeatMode.restart equivalent:
controller.repeat(reverse: false);

// RepeatMode.reverse equivalent:
controller.repeat(reverse: true);''',
          ),
        ],
      ),
    );
  }

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Common Use Cases',
      icon: Icons.category,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose the right mode for your animation:',
            style: TextStyle(color: _kTextPrimary),
          ),
          SizedBox(height: 16),
          _UseCaseRow(
            mode: 'restart',
            color: _kRestart,
            useCases: [
              'Loading spinners (continuous rotation)',
              'Scrolling marquee text',
              'Progress indicators',
              'Heartbeat monitors',
            ],
          ),
          SizedBox(height: 12),
          _UseCaseRow(
            mode: 'reverse',
            color: _kReverse,
            useCases: [
              'Pulse/glow effects',
              'Breathing animations',
              'Gentle shake effects',
              'Fade in/out loops',
            ],
          ),
        ],
      ),
    );
  }
}

class _EnumValueCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final String pattern;
  final String patternNote;

  const _EnumValueCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.pattern,
    required this.patternNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                'RepeatMode.$name',
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Text(
                  'Pattern: ',
                  style: TextStyle(color: _kTextSecondary, fontSize: 12),
                ),
                Text(
                  pattern,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            patternNote,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _PatternGraph extends StatelessWidget {
  final String mode;

  const _PatternGraph({required this.mode});

  @override
  Widget build(BuildContext context) {
    final isRestart = mode == 'restart';
    final color = isRestart ? _kRestart : _kReverse;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            mode,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: CustomPaint(
              size: Size(double.infinity, 60),
              painter: _WavePatternPainter(
                isRestart: isRestart,
                color: color,
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              Text('time →', style: TextStyle(color: _kTextSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

class _WavePatternPainter extends CustomPainter {
  final bool isRestart;
  final Color color;

  _WavePatternPainter({required this.isRestart, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = _kDivider
      ..strokeWidth = 1;

    // Draw axes
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, 0),
      Offset(0, size.height),
      axisPaint,
    );

    // Draw wave pattern
    final path = Path();
    final cycleWidth = size.width / 3;

    if (isRestart) {
      // Sawtooth pattern
      path.moveTo(0, size.height);
      for (var i = 0; i < 3; i++) {
        path.lineTo((i + 1) * cycleWidth, 0);
        if (i < 2) {
          path.moveTo((i + 1) * cycleWidth, size.height);
        }
      }
    } else {
      // Triangle wave pattern
      path.moveTo(0, size.height);
      path.lineTo(cycleWidth / 2, 0);
      path.lineTo(cycleWidth, size.height);
      path.lineTo(cycleWidth * 1.5, 0);
      path.lineTo(cycleWidth * 2, size.height);
      path.lineTo(cycleWidth * 2.5, 0);
      path.lineTo(cycleWidth * 3, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DurationCard extends StatelessWidget {
  final String mode;
  final Color color;
  final String fullCycle;
  final String description;

  const _DurationCard({
    required this.mode,
    required this.color,
    required this.fullCycle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mode,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Full cycle: $fullCycle',
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _UseCaseRow extends StatelessWidget {
  final String mode;
  final Color color;
  final List<String> useCases;

  const _UseCaseRow({
    required this.mode,
    required this.color,
    required this.useCases,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              mode,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: useCases
                  .map((uc) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _kCardBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          uc,
                          style: TextStyle(color: _kTextSecondary, fontSize: 11),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: COMPARE MODES
// =============================================================================
class _CompareModesTab extends StatefulWidget {
  @override
  State<_CompareModesTab> createState() => _CompareModesTabState();
}

class _CompareModesTabState extends State<_CompareModesTab>
    with TickerProviderStateMixin {
  late AnimationController _restartController;
  late AnimationController _reverseController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _restartController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _reverseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _restartController.dispose();
    _reverseController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _restartController.repeat(reverse: false);
      _reverseController.repeat(reverse: true);
    } else {
      _restartController.stop();
      _reverseController.stop();
    }
  }

  void _reset() {
    _restartController.reset();
    _reverseController.reset();
    setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control bar
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _toggleAnimation,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                label: Text(_isPlaying ? 'Pause' : 'Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimary,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: _reset,
                icon: Icon(Icons.replay),
                label: Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kAccent,
                  side: BorderSide(color: _kAccent),
                ),
              ),
            ],
          ),
        ),
        // Side-by-side comparison
        Expanded(
          child: Row(
            children: [
              // Restart column
              Expanded(
                child: _ModeColumn(
                  title: 'restart',
                  color: _kRestart,
                  controller: _restartController,
                  description: 'Jumps back to 0',
                ),
              ),
              Container(width: 1, color: _kDivider),
              // Reverse column
              Expanded(
                child: _ModeColumn(
                  title: 'reverse',
                  color: _kReverse,
                  controller: _reverseController,
                  description: 'Smoothly reverses',
                ),
              ),
            ],
          ),
        ),
        // Value indicators
        AnimatedBuilder(
          animation: Listenable.merge([_restartController, _reverseController]),
          builder: (context, _) {
            return Container(
              padding: EdgeInsets.all(16),
              color: _kCardBg,
              child: Row(
                children: [
                  Expanded(
                    child: _ValueIndicator(
                      label: 'restart',
                      value: _restartController.value,
                      color: _kRestart,
                    ),
                  ),
                  Container(width: 1, height: 40, color: _kDivider),
                  Expanded(
                    child: _ValueIndicator(
                      label: 'reverse',
                      value: _reverseController.value,
                      color: _kReverse,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ModeColumn extends StatelessWidget {
  final String title;
  final Color color;
  final AnimationController controller;
  final String description;

  const _ModeColumn({
    required this.title,
    required this.color,
    required this.controller,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kSurface,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              border: Border(bottom: BorderSide(color: color.withOpacity(0.3))),
            ),
            child: Column(
              children: [
                Text(
                  'RepeatMode.$title',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: _kTextSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          // Animations
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _AnimatedBox(
                    label: 'Position',
                    controller: controller,
                    color: color,
                    buildAnimation: (value) => Transform.translate(
                      offset: Offset(value * 100 - 50, 0),
                      child: _sampleBox(color),
                    ),
                  ),
                  SizedBox(height: 24),
                  _AnimatedBox(
                    label: 'Opacity',
                    controller: controller,
                    color: color,
                    buildAnimation: (value) => Opacity(
                      opacity: value,
                      child: _sampleBox(color),
                    ),
                  ),
                  SizedBox(height: 24),
                  _AnimatedBox(
                    label: 'Scale',
                    controller: controller,
                    color: color,
                    buildAnimation: (value) => Transform.scale(
                      scale: 0.5 + value * 0.5,
                      child: _sampleBox(color),
                    ),
                  ),
                  SizedBox(height: 24),
                  _AnimatedBox(
                    label: 'Rotation',
                    controller: controller,
                    color: color,
                    buildAnimation: (value) => Transform.rotate(
                      angle: value * 3.14159,
                      child: _sampleBox(color),
                    ),
                  ),
                  SizedBox(height: 24),
                  _AnimatedBox(
                    label: 'Color',
                    controller: controller,
                    color: color,
                    buildAnimation: (value) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.lerp(color, _kAccent, value),
                        borderRadius: BorderRadius.circular(8),
                      ),
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

  Widget _sampleBox(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class _AnimatedBox extends StatelessWidget {
  final String label;
  final AnimationController controller;
  final Color color;
  final Widget Function(double value) buildAnimation;

  const _AnimatedBox({
    required this.label,
    required this.controller,
    required this.color,
    required this.buildAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Center(child: buildAnimation(controller.value));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueIndicator extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ValueIndicator({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: color, fontSize: 12)),
              Text(
                value.toStringAsFixed(3),
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: value,
            backgroundColor: _kSurface,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: ANIMATION LAB
// =============================================================================
class _AnimationLabTab extends StatefulWidget {
  @override
  State<_AnimationLabTab> createState() => _AnimationLabTabState();
}

class _AnimationLabTabState extends State<_AnimationLabTab>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  String _selectedMode = 'reverse';
  double _duration = 1.0;
  String _selectedAnimation = 'pulse';
  bool _isPlaying = false;
  final List<String> _eventLog = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (_duration * 1000).round()),
      vsync: this,
    );
    _controller.addStatusListener(_onStatusChange);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatusChange);
    _controller.dispose();
    super.dispose();
  }

  void _onStatusChange(AnimationStatus status) {
    setState(() {
      _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $status');
      if (_eventLog.length > 10) _eventLog.removeLast();
    });
  }

  void _updateMode(String mode) {
    final wasPlaying = _isPlaying;
    _controller.stop();
    setState(() {
      _selectedMode = mode;
      _isPlaying = false;
    });
    if (wasPlaying) {
      Future.microtask(() {
        _controller.repeat(reverse: _selectedMode == 'reverse');
        setState(() => _isPlaying = true);
      });
    }
  }

  void _updateDuration(double seconds) {
    setState(() => _duration = seconds);
    _controller.duration = Duration(milliseconds: (seconds * 1000).round());
    if (_isPlaying) {
      _controller.repeat(reverse: _selectedMode == 'reverse');
    }
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _controller.repeat(reverse: _selectedMode == 'reverse');
    } else {
      _controller.stop();
    }
  }

  void _reset() {
    _controller.reset();
    setState(() {
      _isPlaying = false;
      _eventLog.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            children: [
              // Mode selector
              Row(
                children: [
                  Text('Mode:', style: TextStyle(color: _kTextSecondary)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        _ModeButton(
                          label: 'restart',
                          isSelected: _selectedMode == 'restart',
                          color: _kRestart,
                          onTap: () => _updateMode('restart'),
                        ),
                        SizedBox(width: 8),
                        _ModeButton(
                          label: 'reverse',
                          isSelected: _selectedMode == 'reverse',
                          color: _kReverse,
                          onTap: () => _updateMode('reverse'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Duration slider
              Row(
                children: [
                  Text('Duration:', style: TextStyle(color: _kTextSecondary)),
                  Expanded(
                    child: Slider(
                      value: _duration,
                      min: 0.2,
                      max: 3.0,
                      onChanged: _updateDuration,
                      activeColor: _kAccent,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '${_duration.toStringAsFixed(1)}s',
                      style: TextStyle(color: _kAccent, fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Animation type
              Row(
                children: [
                  Text('Animation:', style: TextStyle(color: _kTextSecondary)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      children: ['pulse', 'slide', 'spin', 'fade'].map((anim) {
                        final isSelected = _selectedAnimation == anim;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedAnimation = anim),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? _kPrimary : _kSurface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? _kAccent : _kDivider,
                              ),
                            ),
                            child: Text(
                              anim,
                              style: TextStyle(
                                color: isSelected ? _kAccent : _kTextSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Play controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _togglePlay,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Pause' : 'Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kPrimary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: Icon(Icons.replay),
                    label: Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _kAccent,
                      side: BorderSide(color: _kAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Animation preview
        Expanded(
          flex: 2,
          child: Container(
            color: _kSurface,
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return _buildAnimation(_controller.value);
                },
              ),
            ),
          ),
        ),
        // Value & event log
        Container(
          height: 150,
          color: _kCardBg,
          child: Row(
            children: [
              // Current value
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Value',
                            style: TextStyle(color: _kTextSecondary, fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _controller.value.toStringAsFixed(4),
                            style: TextStyle(
                              color: _kAccent,
                              fontSize: 28,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: _controller.value,
                            backgroundColor: _kSurface,
                            valueColor: AlwaysStoppedAnimation(
                              _selectedMode == 'restart' ? _kRestart : _kReverse,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Status: ${_controller.status.toString().split('.').last}',
                            style: TextStyle(color: _kTextSecondary, fontSize: 11),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(width: 1, color: _kDivider),
              // Event log
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Events',
                        style: TextStyle(color: _kTextSecondary, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          children: _eventLog
                              .map((e) => Text(
                                    e,
                                    style: TextStyle(
                                      color: _kTextPrimary,
                                      fontFamily: 'monospace',
                                      fontSize: 10,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimation(double value) {
    final color = _selectedMode == 'restart' ? _kRestart : _kReverse;
    final box = Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 16,
            spreadRadius: value * 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${(value * 100).toInt()}%',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    switch (_selectedAnimation) {
      case 'pulse':
        return Transform.scale(scale: 0.8 + value * 0.4, child: box);
      case 'slide':
        return Transform.translate(
          offset: Offset(value * 150 - 75, 0),
          child: box,
        );
      case 'spin':
        return Transform.rotate(angle: value * 6.28, child: box);
      case 'fade':
        return Opacity(opacity: 0.2 + value * 0.8, child: box);
      default:
        return box;
    }
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _ModeButton({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : _kSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : _kDivider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : _kTextSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _CodeExample extends StatelessWidget {
  final String title;
  final String code;

  const _CodeExample({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: _kTextSecondary, fontSize: 12),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withOpacity(0.2)),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
