// D4rt test script: Deep demo for FloatingHeaderSnapConfiguration
// FloatingHeaderSnapConfiguration - snapping behavior for floating headers
//
// FloatingHeaderSnapConfiguration controls how floating SliverPersistentHeader
// widgets snap between their collapsed and expanded states when scrolling stops.
// This class configures the animation parameters for the smooth snapping motion.
//
// ════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
// SECTION 1: FloatingHeaderSnapConfiguration Constructor
// ════════════════════════════════════════════════════════════════════════════
//
// The FloatingHeaderSnapConfiguration constructor accepts three parameters:
//   - vsync: A TickerProvider that drives the snap animation
//   - curve: The easing curve for the snap transition (defaults to Curves.ease)
//   - duration: How long the snap animation takes (defaults to 300ms)
//
// Example instantiation:
//   FloatingHeaderSnapConfiguration(
//     vsync: tickerProvider,
//     curve: Curves.easeOutCubic,
//     duration: Duration(milliseconds: 250),
//   )
//
// ════════════════════════════════════════════════════════════════════════════

class ConstructorDemoWidget extends StatefulWidget {
  ConstructorDemoWidget({Key? key}) : super(key: key);

  @override
  State<ConstructorDemoWidget> createState() => _ConstructorDemoWidgetState();
}

class _ConstructorDemoWidgetState extends State<ConstructorDemoWidget>
    with TickerProviderStateMixin {
  String _statusMessage = 'Ready to create configuration';
  int _configCounter = 0;
  String _lastConfigType = 'none';
  Curve _lastCurve = Curves.ease;
  Duration _lastDuration = Duration(milliseconds: 300);

  void _createDefaultConfig() {
    // FloatingHeaderSnapConfiguration(this) creates with defaults
    // Just demonstrating the pattern - actual config created at scroll time
    _configCounter++;
    _lastConfigType = 'default';
    _lastCurve = Curves.ease;
    _lastDuration = Duration(milliseconds: 300);
    setState(() {
      _statusMessage = 'Created config #$_configCounter with defaults';
    });
  }

  void _createCustomConfig() {
    // FloatingHeaderSnapConfiguration(this, curve: x, duration: y)
    _configCounter++;
    _lastConfigType = 'custom';
    _lastCurve = Curves.easeOutBack;
    _lastDuration = Duration(milliseconds: 400);
    setState(() {
      _statusMessage = 'Created config #$_configCounter with custom params';
    });
  }

  void _createBounceConfig() {
    // FloatingHeaderSnapConfiguration(this, curve: x, duration: y)
    _configCounter++;
    _lastConfigType = 'bounce';
    _lastCurve = Curves.bounceOut;
    _lastDuration = Duration(milliseconds: 600);
    setState(() {
      _statusMessage = 'Created config #$_configCounter with bounce effect';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFE082)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.build_circle, color: Color(0xFFFF6F00), size: 24),
              SizedBox(width: 8),
              Text(
                'Constructor Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'FloatingHeaderSnapConfiguration(\n'
              '  vsync: TickerProvider,\n'
              '  curve: Curve = Curves.ease,\n'
              '  duration: Duration = 300ms,\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFFFE0B2),
              ),
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: _createDefaultConfig,
                icon: Icon(Icons.settings_outlined),
                label: Text('Default'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB300),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _createCustomConfig,
                icon: Icon(Icons.tune),
                label: Text('Custom'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA000),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _createBounceConfig,
                icon: Icon(Icons.bubble_chart),
                label: Text('Bounce'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8F00),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFFECB3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFFFF6F00), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: TextStyle(fontSize: 13, color: Color(0xFFE65100)),
                  ),
                ),
              ],
            ),
          ),
          if (_configCounter > 0)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF3E2723),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Last Config: $_lastConfigType\n'
                  'Curve: ${_lastCurve.toString().split(".").last}\n'
                  'Duration: ${_lastDuration.inMilliseconds}ms',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFFFE0B2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 2: Vsync Parameter
// ════════════════════════════════════════════════════════════════════════════
//
// The vsync parameter is a TickerProvider that creates Ticker objects for
// driving animations. In Flutter widgets, this typically comes from:
//   - TickerProviderStateMixin (for single ticker)
//   - SingleTickerProviderStateMixin (optimized for one ticker)
//
// The vsync ensures animations are synchronized with the screen refresh rate,
// preventing jank and ensuring smooth visual transitions.
//
// Without a valid vsync, the snap animation cannot be driven properly.
//
// ════════════════════════════════════════════════════════════════════════════

class VsyncDemoWidget extends StatefulWidget {
  VsyncDemoWidget({Key? key}) : super(key: key);

  @override
  State<VsyncDemoWidget> createState() => _VsyncDemoWidgetState();
}

class _VsyncDemoWidgetState extends State<VsyncDemoWidget>
    with TickerProviderStateMixin {
  AnimationController? _animController;
  double _animationValue = 0.0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animController!.addListener(() {
      setState(() {
        _animationValue = _animController!.value;
      });
    });
  }

  void _startAnimation() {
    if (_animController == null) return;
    setState(() {
      _isAnimating = true;
    });
    _animController!.forward(from: 0.0).then((_) {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  void _reverseAnimation() {
    if (_animController == null) return;
    setState(() {
      _isAnimating = true;
    });
    _animController!.reverse(from: 1.0).then((_) {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF90CAF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sync, color: Color(0xFF1976D2), size: 24),
              SizedBox(width: 8),
              Text(
                'Vsync Parameter Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The vsync parameter provides a TickerProvider that synchronizes '
            'animations with the display refresh rate. This ensures smooth, '
            'jank-free animation playback.',
            style: TextStyle(fontSize: 13, color: Color(0xFF1565C0)),
          ),
          SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFBBDEFB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10 + (_animationValue * 200),
                  top: 10,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF1976D2).withAlpha(80),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFFBBDEFB),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _animationValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '${(_animationValue * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _isAnimating ? null : _startAnimation,
                icon: Icon(Icons.play_arrow),
                label: Text('Forward'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _isAnimating ? null : _reverseAnimation,
                icon: Icon(Icons.replay),
                label: Text('Reverse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF42A5F5),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'FloatingHeaderSnapConfiguration(\n'
              '  vsync: this,  // TickerProviderStateMixin\n'
              '  ...\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFBBDEFB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 3: Curve Parameter
// ════════════════════════════════════════════════════════════════════════════
//
// The curve parameter defines the easing function for the snap animation.
// Different curves create different visual effects:
//   - Curves.ease: Smooth acceleration and deceleration
//   - Curves.easeIn: Slow start, fast finish
//   - Curves.easeOut: Fast start, slow finish
//   - Curves.easeInOut: Slow start and finish
//   - Curves.bounceOut: Bouncy effect at the end
//   - Curves.elasticOut: Spring-like elastic effect
//   - Curves.linear: Constant speed (no easing)
//
// The curve affects how the header position changes over time during the snap.
//
// ════════════════════════════════════════════════════════════════════════════

class CurveData {
  String name;
  Curve curve;
  Color color;
  IconData icon;

  CurveData({
    required this.name,
    required this.curve,
    required this.color,
    required this.icon,
  });
}

class CurveDemoWidget extends StatefulWidget {
  CurveDemoWidget({Key? key}) : super(key: key);

  @override
  State<CurveDemoWidget> createState() => _CurveDemoWidgetState();
}

class _CurveDemoWidgetState extends State<CurveDemoWidget>
    with TickerProviderStateMixin {
  AnimationController? _animController;
  List<CurveData> _curvesList = [];
  int _selectedCurveIndex = 0;
  double _animProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _initCurves();
    _initAnimation();
  }

  void _initCurves() {
    _curvesList = [
      CurveData(
        name: 'ease',
        curve: Curves.ease,
        color: Color(0xFF4CAF50),
        icon: Icons.trending_flat,
      ),
      CurveData(
        name: 'easeIn',
        curve: Curves.easeIn,
        color: Color(0xFF2196F3),
        icon: Icons.trending_up,
      ),
      CurveData(
        name: 'easeOut',
        curve: Curves.easeOut,
        color: Color(0xFFFF9800),
        icon: Icons.trending_down,
      ),
      CurveData(
        name: 'easeInOut',
        curve: Curves.easeInOut,
        color: Color(0xFF9C27B0),
        icon: Icons.swap_vert,
      ),
      CurveData(
        name: 'bounceOut',
        curve: Curves.bounceOut,
        color: Color(0xFFE91E63),
        icon: Icons.sports_basketball,
      ),
      CurveData(
        name: 'elasticOut',
        curve: Curves.elasticOut,
        color: Color(0xFF00BCD4),
        icon: Icons.waves,
      ),
      CurveData(
        name: 'linear',
        curve: Curves.linear,
        color: Color(0xFF607D8B),
        icon: Icons.straighten,
      ),
    ];
  }

  void _initAnimation() {
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animController!.addListener(_onAnimationTick);
  }

  void _onAnimationTick() {
    if (_selectedCurveIndex < _curvesList.length) {
      var curveData = _curvesList[_selectedCurveIndex];
      var curvedValue = curveData.curve.transform(_animController!.value);
      setState(() {
        _animProgress = curvedValue;
      });
    }
  }

  void _selectCurve(int index) {
    setState(() {
      _selectedCurveIndex = index;
    });
    _animController!.reset();
  }

  void _playCurveAnimation() {
    _animController!.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedCurve = _curvesList.isNotEmpty && _selectedCurveIndex < _curvesList.length
        ? _curvesList[_selectedCurveIndex]
        : null;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCE93D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: Color(0xFF7B1FA2), size: 24),
              SizedBox(width: 8),
              Text(
                'Curve Parameter Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The curve parameter controls the easing function for snap animations. '
            'Select a curve below to see how it affects motion.',
            style: TextStyle(fontSize: 13, color: Color(0xFF6A1B9A)),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(_curvesList.length, (index) {
              var curveData = _curvesList[index];
              var isSelected = index == _selectedCurveIndex;
              return GestureDetector(
                onTap: () => _selectCurve(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? curveData.color : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: curveData.color, width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        curveData.icon,
                        size: 16,
                        color: isSelected ? Colors.white : curveData.color,
                      ),
                      SizedBox(width: 4),
                      Text(
                        curveData.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : curveData.color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          if (selectedCurve != null)
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selectedCurve.color.withAlpha(100)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 35,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: selectedCurve.color.withAlpha(50),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20 + (_animProgress * 200),
                    top: 20,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: selectedCurve.color,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: selectedCurve.color.withAlpha(100),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        selectedCurve.icon,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: _playCurveAnimation,
              icon: Icon(Icons.play_circle_fill),
              label: Text('Play Animation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedCurve?.color ?? Color(0xFF9C27B0),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'FloatingHeaderSnapConfiguration(\n'
              '  vsync: this,\n'
              '  curve: Curves.${selectedCurve?.name ?? "ease"},\n'
              '  ...\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFF3E5F5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 4: Duration Parameter
// ════════════════════════════════════════════════════════════════════════════
//
// The duration parameter specifies how long the snap animation takes to complete.
// Typical values range from 100ms to 500ms:
//   - 100-150ms: Very fast, snappy feel
//   - 200-300ms: Standard, balanced timing (default is 300ms)
//   - 400-500ms: Slower, more deliberate transitions
//   - 600ms+: Dramatic, noticeable animation
//
// The duration affects user perception of responsiveness and polish.
//
// ════════════════════════════════════════════════════════════════════════════

class DurationDemoWidget extends StatefulWidget {
  DurationDemoWidget({Key? key}) : super(key: key);

  @override
  State<DurationDemoWidget> createState() => _DurationDemoWidgetState();
}

class _DurationDemoWidgetState extends State<DurationDemoWidget>
    with TickerProviderStateMixin {
  AnimationController? _animController;
  double _currentDurationMs = 300;
  double _animValue = 0.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  void _setupController() {
    _animController?.dispose();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _currentDurationMs.toInt()),
    );
    _animController!.addListener(() {
      setState(() {
        _animValue = _animController!.value;
      });
    });
    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _updateDuration(double value) {
    setState(() {
      _currentDurationMs = value;
    });
    _setupController();
  }

  void _playAnimation() {
    setState(() {
      _isPlaying = true;
    });
    _animController!.forward(from: 0.0);
  }

  String _getDurationLabel() {
    if (_currentDurationMs <= 150) return 'Fast';
    if (_currentDurationMs <= 300) return 'Standard';
    if (_currentDurationMs <= 450) return 'Moderate';
    return 'Slow';
  }

  Color _getDurationColor() {
    if (_currentDurationMs <= 150) return Color(0xFF4CAF50);
    if (_currentDurationMs <= 300) return Color(0xFF2196F3);
    if (_currentDurationMs <= 450) return Color(0xFFFF9800);
    return Color(0xFFF44336);
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var durationColor = _getDurationColor();
    var durationLabel = _getDurationLabel();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFA5D6A7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: Color(0xFF388E3C), size: 24),
              SizedBox(width: 8),
              Text(
                'Duration Parameter Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The duration parameter controls how long the snap animation takes. '
            'Adjust the slider to see different animation speeds.',
            style: TextStyle(fontSize: 13, color: Color(0xFF2E7D32)),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                '100ms',
                style: TextStyle(fontSize: 11, color: Color(0xFF388E3C)),
              ),
              Expanded(
                child: Slider(
                  value: _currentDurationMs,
                  min: 100,
                  max: 600,
                  divisions: 10,
                  activeColor: durationColor,
                  inactiveColor: durationColor.withAlpha(60),
                  onChanged: _updateDuration,
                ),
              ),
              Text(
                '600ms',
                style: TextStyle(fontSize: 11, color: Color(0xFF388E3C)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: durationColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentDurationMs.toInt()}ms ($durationLabel)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: durationColor.withAlpha(100)),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  right: 10,
                  top: 27,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: durationColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                Positioned(
                  left: 10 + (_animValue * 220),
                  top: 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: durationColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: durationColor.withAlpha(100),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.flash_on, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: _isPlaying ? null : _playAnimation,
              icon: Icon(Icons.play_arrow),
              label: Text('Play'),
              style: ElevatedButton.styleFrom(
                backgroundColor: durationColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'FloatingHeaderSnapConfiguration(\n'
              '  vsync: this,\n'
              '  curve: Curves.ease,\n'
              '  duration: Duration(milliseconds: ${_currentDurationMs.toInt()}),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFE8F5E9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 5: Snap Behavior Visualization
// ════════════════════════════════════════════════════════════════════════════
//
// This section visualizes how FloatingHeaderSnapConfiguration affects the
// snapping behavior of floating headers in a CustomScrollView context.
//
// Key concepts:
//   - Floating headers can be in collapsed or expanded states
//   - When scroll stops between states, snap animation activates
//   - The configuration determines how smoothly the snap occurs
//   - Threshold typically at 50% determines snap direction
//
// ════════════════════════════════════════════════════════════════════════════

class SnapBehaviorVisualization extends StatefulWidget {
  SnapBehaviorVisualization({Key? key}) : super(key: key);

  @override
  State<SnapBehaviorVisualization> createState() =>
      _SnapBehaviorVisualizationState();
}

class _SnapBehaviorVisualizationState extends State<SnapBehaviorVisualization>
    with TickerProviderStateMixin {
  AnimationController? _headerAnimController;
  double _headerExpansion = 1.0;
  bool _isSnapping = false;
  String _snapDirection = 'none';
  Curve _selectedCurve = Curves.ease;
  int _durationMs = 300;

  @override
  void initState() {
    super.initState();
    _initHeaderAnimation();
  }

  void _initHeaderAnimation() {
    _headerAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationMs),
    );
    _headerAnimController!.addListener(_onHeaderAnimationTick);
    _headerAnimController!.addStatusListener(_onHeaderAnimationStatus);
  }

  void _onHeaderAnimationTick() {
    var curvedValue = _selectedCurve.transform(_headerAnimController!.value);
    setState(() {
      if (_snapDirection == 'expand') {
        _headerExpansion = _headerExpansion + (1.0 - _headerExpansion) * curvedValue / 10;
        if (_headerExpansion > 0.99) _headerExpansion = 1.0;
      } else if (_snapDirection == 'collapse') {
        _headerExpansion = _headerExpansion - _headerExpansion * curvedValue / 10;
        if (_headerExpansion < 0.01) _headerExpansion = 0.0;
      }
    });
  }

  void _onHeaderAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isSnapping = false;
        _snapDirection = 'none';
      });
    }
  }

  void _simulateSnapToExpand() {
    if (_isSnapping) return;
    setState(() {
      _headerExpansion = 0.6;
      _isSnapping = true;
      _snapDirection = 'expand';
    });
    _headerAnimController!.forward(from: 0.0);
  }

  void _simulateSnapToCollapse() {
    if (_isSnapping) return;
    setState(() {
      _headerExpansion = 0.4;
      _isSnapping = true;
      _snapDirection = 'collapse';
    });
    _headerAnimController!.forward(from: 0.0);
  }

  void _setHeaderPosition(double value) {
    if (_isSnapping) return;
    setState(() {
      _headerExpansion = value;
    });
  }

  void _triggerSnap() {
    if (_isSnapping) return;
    setState(() {
      _isSnapping = true;
      _snapDirection = _headerExpansion >= 0.5 ? 'expand' : 'collapse';
    });
    _headerAnimController!.forward(from: 0.0);
  }

  @override
  void dispose() {
    _headerAnimController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var headerHeight = 60.0 + (_headerExpansion * 120.0);
    var percentExpanded = (_headerExpansion * 100).toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFF48FB1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swipe_vertical, color: Color(0xFFC2185B), size: 24),
              SizedBox(width: 8),
              Text(
                'Snap Behavior Visualization',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'This simulates how a floating header snaps to fully expanded or '
            'collapsed based on its current position when scrolling stops.',
            style: TextStyle(fontSize: 13, color: Color(0xFFAD1457)),
          ),
          SizedBox(height: 16),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFFF8BBD0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFF06292)),
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 16),
                  height: headerHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(11),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _headerExpansion > 0.7
                              ? Icons.unfold_less
                              : Icons.unfold_more,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Header $percentExpanded%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (_headerExpansion > 0.5)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              _isSnapping
                                  ? 'Snapping to ${_snapDirection}...'
                                  : 'Expanded State',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(11),
                      ),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFFCE4EC)),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF8BBD0),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFC2185B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'List item ${index + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF880E4F),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Position:',
                style: TextStyle(fontSize: 12, color: Color(0xFFC2185B)),
              ),
              Expanded(
                child: Slider(
                  value: _headerExpansion,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Color(0xFFE91E63),
                  inactiveColor: Color(0xFFF48FB1),
                  onChanged: _isSnapping ? null : _setHeaderPosition,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isSnapping ? null : _simulateSnapToExpand,
                icon: Icon(Icons.arrow_upward, size: 16),
                label: Text('Snap Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isSnapping ? null : _triggerSnap,
                icon: Icon(Icons.flash_on, size: 16),
                label: Text('Auto Snap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE91E63),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isSnapping ? null : _simulateSnapToCollapse,
                icon: Icon(Icons.arrow_downward, size: 16),
                label: Text('Snap Down'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF44336),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SliverAppBar Usage Example:',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF48FB1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'SliverAppBar(\n'
                  '  floating: true,\n'
                  '  snap: true,  // Enables snapping\n'
                  '  expandedHeight: 180.0,\n'
                  '  flexibleSpace: FlexibleSpaceBar(...),\n'
                  ')\n\n'
                  '// FloatingHeaderSnapConfiguration is\n'
                  '// created internally by SliverAppBar',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFFCE4EC),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ADDITIONAL DEMO: Complete Integration Example
// ════════════════════════════════════════════════════════════════════════════

class IntegrationExampleWidget extends StatefulWidget {
  IntegrationExampleWidget({Key? key}) : super(key: key);

  @override
  State<IntegrationExampleWidget> createState() =>
      _IntegrationExampleWidgetState();
}

class _IntegrationExampleWidgetState extends State<IntegrationExampleWidget> {
  bool _showFloating = true;
  bool _showSnap = true;
  bool _showPinned = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF80DEEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.integration_instructions, color: Color(0xFF00838F), size: 24),
              SizedBox(width: 8),
              Text(
                'Integration Example',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Configure SliverAppBar properties that affect FloatingHeaderSnapConfiguration:',
            style: TextStyle(fontSize: 13, color: Color(0xFF00838F)),
          ),
          SizedBox(height: 16),
          _buildToggleRow('floating', _showFloating, (val) {
            setState(() {
              _showFloating = val;
              if (!val) _showSnap = false;
            });
          }),
          _buildToggleRow('snap', _showSnap, _showFloating ? (val) {
            setState(() {
              _showSnap = val;
            });
          } : null),
          _buildToggleRow('pinned', _showPinned, (val) {
            setState(() {
              _showPinned = val;
            });
          }),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'SliverAppBar(\n'
              '  floating: $_showFloating,\n'
              '  snap: $_showSnap,\n'
              '  pinned: $_showPinned,\n'
              '  expandedHeight: 200.0,\n'
              '  flexibleSpace: FlexibleSpaceBar(\n'
              '    title: Text("App Title"),\n'
              '    background: Image(...),\n'
              '  ),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFE0F7FA),
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _showSnap ? Color(0xFF4CAF50).withAlpha(40) : Color(0xFFFF9800).withAlpha(40),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _showSnap ? Color(0xFF4CAF50) : Color(0xFFFF9800),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _showSnap ? Icons.check_circle : Icons.info,
                  color: _showSnap ? Color(0xFF4CAF50) : Color(0xFFFF9800),
                  size: 20,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _showSnap
                        ? 'FloatingHeaderSnapConfiguration is active. Header will snap to expanded/collapsed state.'
                        : 'Snap is disabled. Header will stay at current scroll position.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _showSnap ? Color(0xFF2E7D32) : Color(0xFFE65100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String label, bool value, void Function(bool)? onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF006064),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF00BCD4),
          ),
          SizedBox(width: 8),
          Text(
            value ? 'true' : 'false',
            style: TextStyle(
              fontSize: 12,
              color: value ? Color(0xFF00838F) : Color(0xFF90A4AE),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// MAIN DEMO APP WIDGET
// ════════════════════════════════════════════════════════════════════════════

class FloatingHeaderSnapConfigurationDemo extends StatelessWidget {
  FloatingHeaderSnapConfigurationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('FloatingHeaderSnapConfiguration'),
        backgroundColor: Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderBanner(),
            SizedBox(height: 20),
            _buildSectionHeader('1. Constructor', Icons.build_circle),
            SizedBox(height: 8),
            ConstructorDemoWidget(),
            SizedBox(height: 20),
            _buildSectionHeader('2. Vsync Parameter', Icons.sync),
            SizedBox(height: 8),
            VsyncDemoWidget(),
            SizedBox(height: 20),
            _buildSectionHeader('3. Curve Parameter', Icons.show_chart),
            SizedBox(height: 8),
            CurveDemoWidget(),
            SizedBox(height: 20),
            _buildSectionHeader('4. Duration Parameter', Icons.timer),
            SizedBox(height: 8),
            DurationDemoWidget(),
            SizedBox(height: 20),
            _buildSectionHeader('5. Snap Behavior', Icons.swipe_vertical),
            SizedBox(height: 8),
            SnapBehaviorVisualization(),
            SizedBox(height: 20),
            _buildSectionHeader('6. Integration', Icons.integration_instructions),
            SizedBox(height: 8),
            IntegrationExampleWidget(),
            SizedBox(height: 20),
            _buildFooterInfo(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6F00), Color(0xFFFFA000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF6F00).withAlpha(80),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(Icons.swipe_up, color: Colors.white, size: 40),
          ),
          SizedBox(height: 16),
          Text(
            'FloatingHeaderSnapConfiguration',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Controls snapping behavior for floating persistent headers\n'
            'in sliver scroll views',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withAlpha(220),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBannerChip('rendering.dart'),
              SizedBox(width: 8),
              _buildBannerChip('Slivers'),
              SizedBox(width: 8),
              _buildBannerChip('Animation'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(60)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFECB3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFFFF6F00), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFE082)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFFF6F00), size: 22),
              SizedBox(width: 8),
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildSummaryItem(
            'FloatingHeaderSnapConfiguration is created internally by '
            'SliverAppBar when floating and snap are both true.',
          ),
          _buildSummaryItem(
            'The vsync parameter provides animation synchronization '
            'with the display refresh rate.',
          ),
          _buildSummaryItem(
            'The curve parameter controls easing (e.g., Curves.ease, '
            'Curves.bounceOut, Curves.elasticOut).',
          ),
          _buildSummaryItem(
            'The duration parameter sets animation length '
            '(default 300ms, typical range 100-500ms).',
          ),
          _buildSummaryItem(
            'When scrolling stops with header partially visible, '
            'snap animation triggers based on threshold.',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFFB300),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE65100),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// MAIN FUNCTION
// ════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(MaterialApp(
    title: 'FloatingHeaderSnapConfiguration Demo',
    theme: ThemeData(
      primarySwatch: Colors.orange,
      useMaterial3: true,
    ),
    home: FloatingHeaderSnapConfigurationDemo(),
    debugShowCheckedModeBanner: false,
  ));

  print('');
  print('╔═══════════════════════════════════════════════════════════════════╗');
  print('║     FloatingHeaderSnapConfiguration Deep Demo                     ║');
  print('╚═══════════════════════════════════════════════════════════════════╝');
  print('');
  print('FloatingHeaderSnapConfiguration controls the snapping behavior of');
  print('floating SliverPersistentHeader widgets in a CustomScrollView.');
  print('');
  print('Key Parameters:');
  print('  • vsync: TickerProvider for animation synchronization');
  print('  • curve: Easing function (default: Curves.ease)');
  print('  • duration: Animation length (default: 300ms)');
  print('');
  print('Usage Context:');
  print('  - Created internally by SliverAppBar when floating=true, snap=true');
  print('  - Used by RenderSliverFloatingPersistentHeader for snap animation');
  print('  - Determines smooth transition between collapsed/expanded states');
  print('');
  print('Common Curve Options:');
  print('  • Curves.ease         - Smooth acceleration/deceleration');
  print('  • Curves.easeIn       - Slow start, fast finish');
  print('  • Curves.easeOut      - Fast start, slow finish');
  print('  • Curves.easeInOut    - Slow start and finish');
  print('  • Curves.bounceOut    - Bouncy effect at end');
  print('  • Curves.elasticOut   - Spring-like elastic effect');
  print('');
  print('Duration Recommendations:');
  print('  • 100-150ms: Very snappy, instant feel');
  print('  • 200-300ms: Standard, balanced (default)');
  print('  • 400-500ms: Slower, deliberate');
  print('  • 600ms+:    Dramatic, noticeable');
  print('');
  print('FloatingHeaderSnapConfiguration demo completed.');
}
