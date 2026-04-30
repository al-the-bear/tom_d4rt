// ignore_for_file: avoid_print
// Deep demo: AnimatedModalBarrier - Animated barrier that blocks user interaction
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


// D4rt bridge workaround: bridged TickerProvider mixins cannot be used as mixin
mixin _TickerProviderShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedModalBarrierDemo(),
  );
}

class AnimatedModalBarrierDemo extends StatefulWidget {
  const AnimatedModalBarrierDemo({super.key});

  @override
  State<AnimatedModalBarrierDemo> createState() => _AnimatedModalBarrierDemoState();
}

class _AnimatedModalBarrierDemoState extends State<AnimatedModalBarrierDemo> 
    with _TickerProviderShim {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Modal Barrier Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showBasicBarrier = false;
  late AnimationController _basicController;
  late Animation<Color?> _basicColorAnimation;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Barrier Color Variations
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showColorBarrier = false;
  late AnimationController _colorController;
  int _selectedColorIndex = 0;
  final List<Color> _barrierColors = [
    Colors.black54,
    Colors.black87,
    Colors.blue.withValues(alpha: 0.5),
    Colors.red.withValues(alpha: 0.5),
    Colors.purple.withValues(alpha: 0.5),
    Colors.green.withValues(alpha: 0.3),
    Colors.white.withValues(alpha: 0.8),
  ];
  final List<String> _colorNames = [
    'Black 54%', 'Black 87%', 'Blue', 'Red', 'Purple', 'Green', 'White'
  ];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Dismissibility Settings
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showDismissibleBarrier = false;
  late AnimationController _dismissController;
  bool _isDismissible = true;
  int _dismissCount = 0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Duration and Curve Control
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showDurationBarrier = false;
  late AnimationController _durationController;
  Duration _selectedDuration = const Duration(milliseconds: 300);
  Curve _selectedCurve = Curves.easeInOut;
  final List<Duration> _durations = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 300),
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
  ];
  final List<MapEntry<String, Curve>> _curves = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('easeIn', Curves.easeIn),
    const MapEntry('easeOut', Curves.easeOut),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('bounceIn', Curves.bounceIn),
    const MapEntry('bounceOut', Curves.bounceOut),
  ];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Semantics Configuration
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showSemanticsBarrier = false;
  late AnimationController _semanticsController;
  String _semanticsLabel = 'Close dialog';
  bool _barrierSemanticsDismissible = true;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Loading Overlay Use Case
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isLoading = false;
  late AnimationController _loadingController;
  double _loadingProgress = 0.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Stacked Barriers
  // ═══════════════════════════════════════════════════════════════════════════
  int _barrierStackCount = 0;
  final List<AnimationController> _stackControllers = [];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Custom Barrier Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showPulsingBarrier = false;
  late AnimationController _pulsingController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }
  
  void _initializeControllers() {
    // Basic controller
    _basicController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _basicColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black54,
    ).animate(_basicController);
    
    // Color controller
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Dismiss controller
    _dismissController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Duration controller
    _durationController = AnimationController(
      duration: _selectedDuration,
      vsync: this,
    );
    
    // Semantics controller
    _semanticsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Loading controller
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Pulsing controller
    _pulsingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulsingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulsingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (_showPulsingBarrier) {
          _pulsingController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _basicController.dispose();
    _colorController.dispose();
    _dismissController.dispose();
    _durationController.dispose();
    _semanticsController.dispose();
    _loadingController.dispose();
    _pulsingController.dispose();
    for (final controller in _stackControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedModalBarrier Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Modal Barrier Fundamentals
            _buildSectionHeader('1. Basic Modal Barrier Fundamentals'),
            _buildBasicBarrierSection(),
            const SizedBox(height: 32),
            
            // Section 2: Barrier Color Variations
            _buildSectionHeader('2. Barrier Color Variations'),
            _buildColorVariationsSection(),
            const SizedBox(height: 32),
            
            // Section 3: Dismissibility Settings
            _buildSectionHeader('3. Dismissibility Settings'),
            _buildDismissibilitySection(),
            const SizedBox(height: 32),
            
            // Section 4: Duration and Curve Control
            _buildSectionHeader('4. Duration and Curve Control'),
            _buildDurationCurveSection(),
            const SizedBox(height: 32),
            
            // Section 5: Semantics Configuration
            _buildSectionHeader('5. Semantics Configuration'),
            _buildSemanticsSection(),
            const SizedBox(height: 32),
            
            // Section 6: Loading Overlay Use Case
            _buildSectionHeader('6. Loading Overlay Use Case'),
            _buildLoadingOverlaySection(),
            const SizedBox(height: 32),
            
            // Section 7: Stacked Barriers
            _buildSectionHeader('7. Stacked Barriers'),
            _buildStackedBarriersSection(),
            const SizedBox(height: 32),
            
            // Section 8: Custom Barrier Patterns
            _buildSectionHeader('8. Custom Barrier Patterns'),
            _buildCustomPatternsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Modal Barrier Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicBarrierSection() {
    print('=== Section 1: Basic Modal Barrier Fundamentals ===');
    print('Show basic barrier: $_showBasicBarrier');
    print('AnimatedModalBarrier blocks interaction with animated color transition');
    print('Commonly used with dialogs, drawers, and overlays');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedModalBarrier creates a barrier that blocks interaction '
              'and animates its color. Commonly used behind dialogs.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container with barrier
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  // Background content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _showBasicBarrier ? null : () {
                            print('Background button pressed (barrier not active)');
                          },
                          child: const Text('Background Button'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _showBasicBarrier ? 'Button blocked by barrier' : 'Button is clickable',
                          style: TextStyle(
                            color: _showBasicBarrier ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Animated modal barrier
                  if (_showBasicBarrier)
                    AnimatedBuilder(
                      animation: _basicController,
                      builder: (context, child) {
                        return AnimatedModalBarrier(
                          color: _basicColorAnimation,
                          dismissible: true,
                          onDismiss: () {
                            print('Basic barrier dismissed');
                            setState(() {
                              _showBasicBarrier = false;
                            });
                            _basicController.reverse();
                          },
                        );
                      },
                    ),
                  // Overlay content on top of barrier
                  if (_showBasicBarrier)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info, color: Colors.indigo, size: 32),
                            SizedBox(height: 8),
                            Text('Dialog Content', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Tap barrier to dismiss'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showBasicBarrier = true;
                });
                _basicController.forward();
                print('Basic barrier shown');
              },
              icon: const Icon(Icons.layers),
              label: const Text('Show Barrier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Barrier Color Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildColorVariationsSection() {
    print('=== Section 2: Barrier Color Variations ===');
    print('Selected color index: $_selectedColorIndex');
    print('Color: ${_colorNames[_selectedColorIndex]}');
    print('Show color barrier: $_showColorBarrier');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The barrier color can be customized and animated with different opacity levels.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Color selection chips
            const Text('Select Barrier Color:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_barrierColors.length, (index) {
                final isSelected = _selectedColorIndex == index;
                return ChoiceChip(
                  label: Text(_colorNames[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                      print('Barrier color changed to: ${_colorNames[index]}');
                    }
                  },
                  avatar: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _barrierColors[index],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Checkerboard background to show transparency
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _CheckerboardPainter(),
                    ),
                  ),
                  // Content
                  const Center(
                    child: Text('Background Content', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  // Barrier
                  if (_showColorBarrier)
                    AnimatedModalBarrier(
                      color: ColorTween(
                        begin: Colors.transparent,
                        end: _barrierColors[_selectedColorIndex],
                      ).animate(_colorController),
                      dismissible: true,
                      onDismiss: () {
                        print('Color barrier dismissed');
                        _colorController.reverse().then((_) {
                          setState(() {
                            _showColorBarrier = false;
                          });
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showColorBarrier = true;
                });
                _colorController.forward();
                print('Color barrier shown with: ${_colorNames[_selectedColorIndex]}');
              },
              icon: const Icon(Icons.palette),
              label: const Text('Show Color Barrier'),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Dismissibility Settings
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDismissibilitySection() {
    print('=== Section 3: Dismissibility Settings ===');
    print('Is dismissible: $_isDismissible');
    print('Dismiss count: $_dismissCount');
    print('Show dismissible barrier: $_showDismissibleBarrier');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control whether tapping the barrier dismisses it. '
              'Non-dismissible barriers require explicit close actions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            SwitchListTile(
              title: const Text('Dismissible'),
              subtitle: Text(_isDismissible 
                  ? 'Tap barrier to close' 
                  : 'Must use close button'),
              value: _isDismissible,
              onChanged: (value) {
                setState(() {
                  _isDismissible = value;
                });
                print('Dismissible changed to: $value');
              },
            ),
            const SizedBox(height: 8),
            Text('Dismiss count: $_dismissCount', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, size: 48, color: Colors.orange),
                        Text('Background Content'),
                      ],
                    ),
                  ),
                  if (_showDismissibleBarrier)
                    AnimatedModalBarrier(
                      color: ColorTween(
                        begin: Colors.transparent,
                        end: Colors.orange.withValues(alpha: 0.5),
                      ).animate(_dismissController),
                      dismissible: _isDismissible,
                      onDismiss: _isDismissible ? () {
                        print('Dismissible barrier dismissed by tap');
                        setState(() {
                          _dismissCount++;
                        });
                        _dismissController.reverse().then((_) {
                          setState(() {
                            _showDismissibleBarrier = false;
                          });
                        });
                      } : null,
                    ),
                  if (_showDismissibleBarrier)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isDismissible ? 'Tap outside to dismiss' : 'Use button to close',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            if (!_isDismissible) ...[
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  print('Close button pressed');
                                  _dismissController.reverse().then((_) {
                                    setState(() {
                                      _showDismissibleBarrier = false;
                                    });
                                  });
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showDismissibleBarrier = true;
                });
                _dismissController.forward();
                print('Dismissible barrier shown (dismissible: $_isDismissible)');
              },
              icon: const Icon(Icons.back_hand),
              label: const Text('Show Barrier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Duration and Curve Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationCurveSection() {
    print('=== Section 4: Duration and Curve Control ===');
    print('Selected duration: ${_selectedDuration.inMilliseconds}ms');
    print('Selected curve: ${_curves.firstWhere((c) => c.value == _selectedCurve).key}');
    print('Show duration barrier: $_showDurationBarrier');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control animation duration and easing curve for the color transition.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Duration selector
            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: _durations.map((duration) {
                final isSelected = _selectedDuration == duration;
                return ChoiceChip(
                  label: Text('${duration.inMilliseconds}ms'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedDuration = duration;
                        _durationController.duration = duration;
                      });
                      print('Duration changed to: ${duration.inMilliseconds}ms');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            
            // Curve selector
            const Text('Curve:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _curves.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCurve == _curves[index].value;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_curves[index].key),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCurve = _curves[index].value;
                          });
                          print('Curve changed to: ${_curves[index].key}');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text('Watch the animation timing', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  if (_showDurationBarrier)
                    AnimatedModalBarrier(
                      color: CurvedAnimation(
                        parent: _durationController,
                        curve: _selectedCurve,
                      ).drive(ColorTween(
                        begin: Colors.transparent,
                        end: Colors.green.withValues(alpha: 0.6),
                      )),
                      dismissible: true,
                      onDismiss: () {
                        print('Duration demo barrier dismissed');
                        _durationController.reverse().then((_) {
                          setState(() {
                            _showDurationBarrier = false;
                          });
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showDurationBarrier = true;
                });
                _durationController.forward();
                print('Duration barrier shown');
              },
              icon: const Icon(Icons.timer),
              label: const Text('Show Barrier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Semantics Configuration
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSemanticsSection() {
    print('=== Section 5: Semantics Configuration ===');
    print('Semantics label: $_semanticsLabel');
    print('Semantics dismissible: $_barrierSemanticsDismissible');
    print('Show semantics barrier: $_showSemanticsBarrier');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configure accessibility semantics for screen readers.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Semantics label input
            TextField(
              decoration: const InputDecoration(
                labelText: 'Semantics Label',
                hintText: 'e.g., Close dialog',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: _semanticsLabel),
              onChanged: (value) {
                setState(() {
                  _semanticsLabel = value;
                });
                print('Semantics label changed to: $value');
              },
            ),
            const SizedBox(height: 12),
            
            SwitchListTile(
              title: const Text('Semantics Dismissible'),
              subtitle: const Text('Announce as dismissible to screen readers'),
              value: _barrierSemanticsDismissible,
              onChanged: (value) {
                setState(() {
                  _barrierSemanticsDismissible = value;
                });
                print('Semantics dismissible changed to: $value');
              },
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.accessibility_new, size: 32, color: Colors.purple),
                        Text('Accessibility Demo'),
                      ],
                    ),
                  ),
                  if (_showSemanticsBarrier)
                    AnimatedModalBarrier(
                      color: ColorTween(
                        begin: Colors.transparent,
                        end: Colors.purple.withValues(alpha: 0.5),
                      ).animate(_semanticsController),
                      dismissible: true,
                      semanticsLabel: _semanticsLabel,
                      barrierSemanticsDismissible: _barrierSemanticsDismissible,
                      onDismiss: () {
                        print('Semantics barrier dismissed');
                        _semanticsController.reverse().then((_) {
                          setState(() {
                            _showSemanticsBarrier = false;
                          });
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showSemanticsBarrier = true;
                });
                _semanticsController.forward();
                print('Semantics barrier shown with label: $_semanticsLabel');
              },
              icon: const Icon(Icons.speaker_notes),
              label: const Text('Show Barrier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Loading Overlay Use Case
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLoadingOverlaySection() {
    print('=== Section 6: Loading Overlay Use Case ===');
    print('Is loading: $_isLoading');
    print('Loading progress: ${(_loadingProgress * 100).toStringAsFixed(0)}%');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common use case: blocking interaction during async operations.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Form content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : () {
                              _startLoading();
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Loading barrier
                  if (_isLoading)
                    AnimatedModalBarrier(
                      color: ColorTween(
                        begin: Colors.transparent,
                        end: Colors.black54,
                      ).animate(_loadingController),
                      dismissible: false,
                    ),
                  // Loading indicator
                  if (_isLoading)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text('Loading... ${(_loadingProgress * 100).toStringAsFixed(0)}%'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _startLoading() {
    print('Starting loading simulation');
    setState(() {
      _isLoading = true;
      _loadingProgress = 0.0;
    });
    _loadingController.forward();
    
    // Simulate progress
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted || !_isLoading) return false;
      
      setState(() {
        _loadingProgress += 0.05;
      });
      print('Loading progress: ${(_loadingProgress * 100).toStringAsFixed(0)}%');
      
      if (_loadingProgress >= 1.0) {
        _loadingController.reverse().then((_) {
          setState(() {
            _isLoading = false;
          });
          print('Loading complete');
        });
        return false;
      }
      return true;
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Stacked Barriers
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStackedBarriersSection() {
    print('=== Section 7: Stacked Barriers ===');
    print('Barrier stack count: $_barrierStackCount');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Multiple barriers can be stacked for nested modal interactions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            Text(
              'Active barriers: $_barrierStackCount',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text('Base Content', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  // Render stacked barriers
                  ...List.generate(_barrierStackCount, (index) {
                    final opacity = 0.2 + (index * 0.1);
                    return Positioned.fill(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black.withValues(alpha: opacity.clamp(0.0, 1.0)),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: index * 20.0),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [BoxShadow(blurRadius: 4)],
                              ),
                              child: Text('Layer ${index + 1}'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _barrierStackCount++;
                    });
                    print('Added barrier layer: $_barrierStackCount');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Layer'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _barrierStackCount > 0 ? () {
                    setState(() {
                      _barrierStackCount--;
                    });
                    print('Removed barrier layer: $_barrierStackCount');
                  } : null,
                  icon: const Icon(Icons.remove),
                  label: const Text('Remove Layer'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _barrierStackCount > 0 ? () {
                    setState(() {
                      _barrierStackCount = 0;
                    });
                    print('All barriers cleared');
                  } : null,
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Custom Barrier Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCustomPatternsSection() {
    print('=== Section 8: Custom Barrier Patterns ===');
    print('Show pulsing barrier: $_showPulsingBarrier');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom animation patterns for unique visual effects.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Pulsing barrier demo
            const Text('Pulsing Barrier Effect', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty, size: 32, color: Colors.cyan),
                        Text('Processing...'),
                      ],
                    ),
                  ),
                  if (_showPulsingBarrier)
                    AnimatedBuilder(
                      animation: _pulsingController,
                      builder: (context, child) {
                        return AnimatedModalBarrier(
                          color: AlwaysStoppedAnimation(
                            Colors.cyan.withValues(alpha: 0.2 + (_pulsingController.value * 0.3)),
                          ),
                          dismissible: true,
                          onDismiss: () {
                            print('Pulsing barrier dismissed');
                            setState(() {
                              _showPulsingBarrier = false;
                            });
                            _pulsingController.stop();
                            _pulsingController.reset();
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showPulsingBarrier = !_showPulsingBarrier;
                });
                if (_showPulsingBarrier) {
                  _pulsingController.forward();
                  print('Pulsing barrier started');
                } else {
                  _pulsingController.stop();
                  _pulsingController.reset();
                  print('Pulsing barrier stopped');
                }
              },
              icon: Icon(_showPulsingBarrier ? Icons.stop : Icons.play_arrow),
              label: Text(_showPulsingBarrier ? 'Stop Pulsing' : 'Start Pulsing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            
            // Edge cases documentation
            const Text('Edge Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEdgeCaseItem('Null color animation', 'Results in transparent barrier'),
            _buildEdgeCaseItem('Simultaneous barriers', 'Multiple barriers can overlap'),
            _buildEdgeCaseItem('Controller disposal', 'Always dispose controllers in dispose()'),
            _buildEdgeCaseItem('onDismiss with dismissible=false', 'Callback is never called'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEdgeCaseItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSectionHeader(String title) {
    print('');
    print('════════════════════════════════════════════════════════════');
    print(title);
    print('════════════════════════════════════════════════════════════');
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const Divider(thickness: 2, color: Colors.indigo),
        ],
      ),
    );
  }
}

// Checkerboard painter to visualize transparency
class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 10.0;
    final lightPaint = Paint()..color = Colors.grey.shade200;
    final darkPaint = Paint()..color = Colors.grey.shade300;
    
    for (var y = 0.0; y < size.height; y += cellSize) {
      for (var x = 0.0; x < size.width; x += cellSize) {
        final isLight = ((x ~/ cellSize) + (y ~/ cellSize)) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          isLight ? lightPaint : darkPaint,
        );
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
