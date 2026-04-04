// ignore_for_file: avoid_print
// Deep demo test file: align_transition_test.dart
// AlignTransition - Animated version of Align that animates alignment changes
//
// AlignTransition is a widget that animates the alignment of its child within
// its parent container. It works with AnimationController and AlignmentTween
// to smoothly transition between different alignment positions. This is
// particularly useful for:
// - Floating action button animations
// - Menu item entrance/exit effects
// - Card sliding transitions
// - Dynamic UI element repositioning
// - Attention-grabbing animations
//
// Key properties:
// - alignment: Animation<AlignmentGeometry> controlling the position
// - child: The widget to align
// - widthFactor/heightFactor: Constrain size relative to child
//
// This deep demo demonstrates various alignment animation patterns and
// practical applications of AlignTransition in Flutter applications.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


// D4rt bridge workaround: bridged TickerProvider mixins cannot be used as mixin
mixin _TickerProviderShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

/// Main demo widget showcasing AlignTransition capabilities
class AlignTransitionDeepDemo extends StatefulWidget {
  const AlignTransitionDeepDemo({super.key});

  @override
  State<AlignTransitionDeepDemo> createState() => _AlignTransitionDeepDemoState();
}

class _AlignTransitionDeepDemoState extends State<AlignTransitionDeepDemo> {
  int _currentSection = 0;
  
  final List<String> _sectionTitles = [
    '1. Basic Alignment Animation',
    '2. Horizontal Alignment',
    '3. Vertical Alignment',
    '4. Diagonal Movement',
    '5. Alignment Tween Types',
    '6. Curves and Duration',
    '7. Size Factors',
    '8. Practical Use Cases',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlignTransition Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Section navigation
          Container(
            height: 60,
            color: Colors.indigo.shade50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sectionTitles.length,
              itemBuilder: (context, index) {
                final isSelected = index == _currentSection;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: ChoiceChip(
                    label: Text(_sectionTitles[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _currentSection = index);
                        print('AlignTransition Demo: Navigated to section ${index + 1}');
                      }
                    },
                    selectedColor: Colors.indigo,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.indigo.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Section content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildSectionContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_currentSection) {
      case 0:
        return const BasicAlignmentSection();
      case 1:
        return const HorizontalAlignmentSection();
      case 2:
        return const VerticalAlignmentSection();
      case 3:
        return const DiagonalMovementSection();
      case 4:
        return const AlignmentTweenTypesSection();
      case 5:
        return const CurvesAndDurationSection();
      case 6:
        return const SizeFactorsSection();
      case 7:
        return const PracticalUseCasesSection();
      default:
        return const BasicAlignmentSection();
    }
  }
}

// =============================================================================
// SECTION 1: Basic Alignment Animation
// =============================================================================
// This section demonstrates the fundamental use of AlignTransition to animate
// a widget from one alignment position to another. AlignTransition requires
// an Animation<AlignmentGeometry> which is typically created using an
// AnimationController and AlignmentTween.

class BasicAlignmentSection extends StatefulWidget {
  const BasicAlignmentSection({super.key});

  @override
  State<BasicAlignmentSection> createState() => _BasicAlignmentSectionState();
}

class _BasicAlignmentSectionState extends State<BasicAlignmentSection>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    print('BasicAlignmentSection: Initializing animation controller');
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // Animate from top-left to bottom-right
    _alignmentAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    print('BasicAlignmentSection: Alignment animation configured from topLeft to bottomRight');
  }

  @override
  void dispose() {
    _controller.dispose();
    print('BasicAlignmentSection: Animation controller disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Alignment Animation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'AlignTransition animates the alignment of its child within the parent container. '
          'The animation below moves a box from the top-left corner to the bottom-right corner.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        
        // Animation controls
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _controller.forward();
                print('BasicAlignmentSection: Animation started forward');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Forward'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                _controller.reverse();
                print('BasicAlignmentSection: Animation started reverse');
              },
              icon: const Icon(Icons.replay),
              label: const Text('Reverse'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                _controller.reset();
                print('BasicAlignmentSection: Animation reset');
              },
              icon: const Icon(Icons.stop),
              label: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Animation container
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            border: Border.all(color: Colors.indigo.shade200, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Corner indicators
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('TopLeft', style: TextStyle(fontSize: 10)),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('BottomRight', style: TextStyle(fontSize: 10)),
                ),
              ),
              
              // AlignTransition with animated child
              AlignTransition(
                alignment: _alignmentAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.indigo.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Code explanation
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How it works:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. Create an AnimationController with desired duration\n'
                '2. Create an AlignmentTween from begin to end positions\n'
                '3. Apply a Curve using CurvedAnimation (optional)\n'
                '4. Pass the animation to AlignTransition\'s alignment property\n'
                '5. Control with forward(), reverse(), repeat()',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Repeat animation demo
        const Text(
          'Continuous Animation (repeat)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const RepeatAnimationDemo(),
      ],
    );
  }
}

/// Demonstrates continuous repeating alignment animation
class RepeatAnimationDemo extends StatefulWidget {
  const RepeatAnimationDemo({super.key});

  @override
  State<RepeatAnimationDemo> createState() => _RepeatAnimationDemoState();
}

class _RepeatAnimationDemoState extends State<RepeatAnimationDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  bool _isRepeating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _animation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));
    
    print('RepeatAnimationDemo: Initialized with left-right animation');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRepeat() {
    setState(() {
      _isRepeating = !_isRepeating;
      if (_isRepeating) {
        _controller.repeat(reverse: true);
        print('RepeatAnimationDemo: Started repeating animation');
      } else {
        _controller.stop();
        print('RepeatAnimationDemo: Stopped animation');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _toggleRepeat,
          icon: Icon(_isRepeating ? Icons.pause : Icons.repeat),
          label: Text(_isRepeating ? 'Stop Repeat' : 'Start Repeat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isRepeating ? Colors.orange : Colors.indigo,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: AlignTransition(
            alignment: _animation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.circle, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 2: Horizontal Alignment Transitions
// =============================================================================
// Demonstrates alignment animations that move horizontally across the container,
// useful for slide-in effects, tab transitions, and horizontal carousels.

class HorizontalAlignmentSection extends StatefulWidget {
  const HorizontalAlignmentSection({super.key});

  @override
  State<HorizontalAlignmentSection> createState() => _HorizontalAlignmentSectionState();
}

class _HorizontalAlignmentSectionState extends State<HorizontalAlignmentSection>
    with _TickerProviderShim {
  late AnimationController _leftRightController;
  late AnimationController _slideInController;
  late AnimationController _bounceController;
  
  late Animation<AlignmentGeometry> _leftRightAnimation;
  late Animation<AlignmentGeometry> _slideInAnimation;
  late Animation<AlignmentGeometry> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    print('HorizontalAlignmentSection: Setting up three horizontal animations');
    
    // Left to right animation
    _leftRightController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _leftRightAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _leftRightController,
      curve: Curves.linear,
    ));
    
    // Slide-in from off-screen
    _slideInController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideInAnimation = AlignmentTween(
      begin: const Alignment(-2.0, 0.0), // Off-screen left
      end: Alignment.center,
    ).animate(CurvedAnimation(
      parent: _slideInController,
      curve: Curves.easeOutBack,
    ));
    
    // Bounce animation
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _bounceAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _leftRightController.dispose();
    _slideInController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horizontal Alignment Transitions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Horizontal transitions are common in UI animations for slide-in effects, '
          'tab indicators, and horizontal navigation patterns.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // Linear left-right
        const Text(
          'Linear Left → Right',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _leftRightController.forward(from: 0);
                print('HorizontalSection: Linear left-right started');
              },
              child: const Text('Animate'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildHorizontalContainer(
          animation: _leftRightAnimation,
          color: Colors.blue,
          icon: Icons.arrow_forward,
        ),
        const SizedBox(height: 24),
        
        // Slide-in effect
        const Text(
          'Slide-In from Off-Screen (easeOutBack)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _slideInController.forward(from: 0);
                print('HorizontalSection: Slide-in animation started');
              },
              child: const Text('Slide In'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _slideInController.reverse();
                print('HorizontalSection: Slide-out animation started');
              },
              child: const Text('Slide Out'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 80,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: AlignTransition(
            alignment: _slideInAnimation,
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Slide In!',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Bounce effect
        const Text(
          'Elastic/Bounce Effect (elasticOut)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _bounceController.forward(from: 0);
                print('HorizontalSection: Bounce animation started');
              },
              child: const Text('Bounce'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildHorizontalContainer(
          animation: _bounceAnimation,
          color: Colors.orange,
          icon: Icons.sports_basketball,
        ),
        const SizedBox(height: 24),
        
        // Multiple items sliding
        const Text(
          'Multiple Items Horizontal Slide',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const MultiItemHorizontalDemo(),
      ],
    );
  }

  Widget _buildHorizontalContainer({
    required Animation<AlignmentGeometry> animation,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Stack(
        children: [
          // Track line
          Positioned.fill(
            child: Center(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          AlignTransition(
            alignment: animation,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Demonstrates multiple items sliding horizontally with staggered timing
class MultiItemHorizontalDemo extends StatefulWidget {
  const MultiItemHorizontalDemo({super.key});

  @override
  State<MultiItemHorizontalDemo> createState() => _MultiItemHorizontalDemoState();
}

class _MultiItemHorizontalDemoState extends State<MultiItemHorizontalDemo>
    with _TickerProviderShim {
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;
  final List<Color> _colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });
    
    _animations = List.generate(4, (index) {
      return AlignmentTween(
        begin: const Alignment(-1.5, 0),
        end: Alignment.center,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOutCubic,
      ));
    });
    
    print('MultiItemHorizontalDemo: Created 4 staggered animations');
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _animateAll() async {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].forward(from: 0);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    print('MultiItemHorizontalDemo: Staggered animation sequence complete');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _animateAll,
          child: const Text('Animate All (Staggered)'),
        ),
        const SizedBox(height: 12),
        ...List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: _colors[index].withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AlignTransition(
                alignment: _animations[index],
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _colors[index],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// =============================================================================
// SECTION 3: Vertical Alignment Transitions
// =============================================================================
// Demonstrates vertical alignment animations for dropdown effects, expanding
// panels, notification banners, and vertical navigation patterns.

class VerticalAlignmentSection extends StatefulWidget {
  const VerticalAlignmentSection({super.key});

  @override
  State<VerticalAlignmentSection> createState() => _VerticalAlignmentSectionState();
}

class _VerticalAlignmentSectionState extends State<VerticalAlignmentSection>
    with _TickerProviderShim {
  late AnimationController _dropDownController;
  late AnimationController _riseUpController;
  late AnimationController _notificationController;
  
  late Animation<AlignmentGeometry> _dropDownAnimation;
  late Animation<AlignmentGeometry> _riseUpAnimation;
  late Animation<AlignmentGeometry> _notificationAnimation;

  @override
  void initState() {
    super.initState();
    print('VerticalAlignmentSection: Initializing vertical animations');
    
    // Drop-down effect
    _dropDownController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _dropDownAnimation = AlignmentTween(
      begin: const Alignment(0, -1.5), // Above the container
      end: Alignment.center,
    ).animate(CurvedAnimation(
      parent: _dropDownController,
      curve: Curves.bounceOut,
    ));
    
    // Rise-up effect
    _riseUpController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _riseUpAnimation = AlignmentTween(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(
      parent: _riseUpController,
      curve: Curves.easeOutQuint,
    ));
    
    // Notification banner
    _notificationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _notificationAnimation = AlignmentTween(
      begin: const Alignment(0, -2), // Off-screen top
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(
      parent: _notificationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _dropDownController.dispose();
    _riseUpController.dispose();
    _notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vertical Alignment Transitions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Vertical transitions are essential for dropdown menus, notification banners, '
          'bottom sheets, and vertical reveal animations.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // Drop-down with bounce
        const Text(
          'Drop-Down with Bounce',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _dropDownController.forward(from: 0);
            print('VerticalSection: Drop-down animation started');
          },
          child: const Text('Drop It!'),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: AlignTransition(
            alignment: _dropDownAnimation,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Rise-up effect
        const Text(
          'Rise-Up Effect',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _riseUpController.forward();
                print('VerticalSection: Rise-up animation forward');
              },
              child: const Text('Rise Up'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _riseUpController.reverse();
                print('VerticalSection: Rise-up animation reverse');
              },
              child: const Text('Fall Down'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade50, Colors.cyan.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: AlignTransition(
            alignment: _riseUpAnimation,
            child: Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.air, color: Colors.white),
                  SizedBox(width: 4),
                  Text('Rise', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Notification banner
        const Text(
          'Notification Banner Slide',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _notificationController.forward();
                print('VerticalSection: Notification shown');
              },
              child: const Text('Show'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _notificationController.reverse();
                print('VerticalSection: Notification hidden');
              },
              child: const Text('Hide'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            children: [
              const Center(
                child: Text(
                  'App Content Area',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              AlignTransition(
                alignment: _notificationAnimation,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Success! Operation completed.',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Vertical stack demo
        const Text(
          'Vertical Stack Animation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const VerticalStackDemo(),
      ],
    );
  }
}

/// Demonstrates a vertical stack that expands/collapses
class VerticalStackDemo extends StatefulWidget {
  const VerticalStackDemo({super.key});

  @override
  State<VerticalStackDemo> createState() => _VerticalStackDemoState();
}

class _VerticalStackDemoState extends State<VerticalStackDemo>
    with _TickerProviderShim {
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: Duration(milliseconds: 300 + (index * 100)),
        vsync: this,
      );
    });
    
    // Stack cards that spread vertically
    _animations = [
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.topCenter,
      ).animate(CurvedAnimation(parent: _controllers[0], curve: Curves.easeOut)),
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.center,
      ).animate(_controllers[1]), // This one stays in place
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
      ).animate(CurvedAnimation(parent: _controllers[2], curve: Curves.easeOut)),
    ];
    
    print('VerticalStackDemo: Stack animation setup complete');
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    for (final c in _controllers) {
      if (_isExpanded) {
        c.forward();
      } else {
        c.reverse();
      }
    }
    print('VerticalStackDemo: Stack ${_isExpanded ? "expanded" : "collapsed"}');
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.orange, Colors.amber];
    
    return Column(
      children: [
        ElevatedButton(
          onPressed: _toggleExpand,
          child: Text(_isExpanded ? 'Collapse Stack' : 'Expand Stack'),
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: List.generate(3, (index) {
              return AlignTransition(
                alignment: _animations[index],
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: colors[index].withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Card ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 4: Diagonal Movement Patterns
// =============================================================================
// Demonstrates diagonal alignment transitions combining both x and y axis
// movement for complex animation paths.

class DiagonalMovementSection extends StatefulWidget {
  const DiagonalMovementSection({super.key});

  @override
  State<DiagonalMovementSection> createState() => _DiagonalMovementSectionState();
}

class _DiagonalMovementSectionState extends State<DiagonalMovementSection>
    with _TickerProviderShim {
  late AnimationController _cornerController;
  late AnimationController _zigzagController;
  late AnimationController _spiralController;
  
  late Animation<AlignmentGeometry> _cornerAnimation;
  late Animation<AlignmentGeometry> _zigzagAnimation;
  
  int _currentCorner = 0;
  final List<Alignment> _corners = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
  ];

  @override
  void initState() {
    super.initState();
    print('DiagonalMovementSection: Setting up diagonal animations');
    
    _cornerController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _cornerAnimation = AlignmentTween(
      begin: _corners[0],
      end: _corners[1],
    ).animate(CurvedAnimation(
      parent: _cornerController,
      curve: Curves.easeInOutCubic,
    ));
    
    _zigzagController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // Zigzag pattern using TweenSequence
    _zigzagAnimation = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem(
        tween: AlignmentTween(begin: Alignment.topLeft, end: Alignment.centerRight),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(begin: Alignment.centerRight, end: Alignment.centerLeft),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(begin: Alignment.centerLeft, end: Alignment.bottomRight),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(begin: Alignment.bottomRight, end: Alignment.topLeft),
        weight: 25,
      ),
    ]).animate(_zigzagController);
    
    _spiralController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cornerController.dispose();
    _zigzagController.dispose();
    _spiralController.dispose();
    super.dispose();
  }

  void _moveToNextCorner() {
    final nextCorner = (_currentCorner + 1) % 4;
    setState(() {
      _cornerAnimation = AlignmentTween(
        begin: _corners[_currentCorner],
        end: _corners[nextCorner],
      ).animate(CurvedAnimation(
        parent: _cornerController,
        curve: Curves.easeInOutCubic,
      ));
      _currentCorner = nextCorner;
    });
    _cornerController.forward(from: 0);
    print('DiagonalMovement: Moving to corner $_currentCorner (${_corners[_currentCorner]})');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diagonal Movement Patterns',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Diagonal movements combine horizontal and vertical transitions for more complex '
          'animation paths like corner-to-corner, zigzag, and circular patterns.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // Corner-to-corner
        const Text(
          'Corner to Corner Navigation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _moveToNextCorner,
          child: const Text('Move to Next Corner'),
        ),
        const SizedBox(height: 8),
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200, width: 2),
          ),
          child: Stack(
            children: [
              // Corner labels
              ..._buildCornerLabels(),
              
              // Animated element
              AlignTransition(
                alignment: _cornerAnimation,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.teal, Colors.cyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withValues(alpha: 0.5),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.navigation, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Zigzag pattern
        const Text(
          'Zigzag Pattern (TweenSequence)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _zigzagController.forward(from: 0);
                print('DiagonalMovement: Zigzag animation started');
              },
              child: const Text('Start Zigzag'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _zigzagController.repeat();
                print('DiagonalMovement: Zigzag repeating');
              },
              child: const Text('Repeat'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _zigzagController.stop();
                print('DiagonalMovement: Zigzag stopped');
              },
              child: const Text('Stop'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: AlignTransition(
            alignment: _zigzagAnimation,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Circular path approximation
        const Text(
          'Circular Path Approximation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const CircularPathDemo(),
      ],
    );
  }

  List<Widget> _buildCornerLabels() {
    const labels = ['TL', 'TR', 'BR', 'BL'];
    const positions = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomRight,
      Alignment.bottomLeft,
    ];
    
    return List.generate(4, (index) {
      return Align(
        alignment: positions[index],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _currentCorner == index ? Colors.teal : Colors.teal.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              labels[index],
              style: TextStyle(
                color: _currentCorner == index ? Colors.white : Colors.teal.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// Demonstrates a circular path using multiple alignment points
class CircularPathDemo extends StatefulWidget {
  const CircularPathDemo({super.key});

  @override
  State<CircularPathDemo> createState() => _CircularPathDemoState();
}

class _CircularPathDemoState extends State<CircularPathDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    // Approximate circular motion with 8 points
    _animation = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(0, -1), end: const Alignment(0.7, -0.7)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(0.7, -0.7), end: const Alignment(1, 0)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(1, 0), end: const Alignment(0.7, 0.7)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(0.7, 0.7), end: const Alignment(0, 1)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(0, 1), end: const Alignment(-0.7, 0.7)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(-0.7, 0.7), end: const Alignment(-1, 0)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(-1, 0), end: const Alignment(-0.7, -0.7)), weight: 12.5),
      TweenSequenceItem(tween: AlignmentTween(begin: const Alignment(-0.7, -0.7), end: const Alignment(0, -1)), weight: 12.5),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    
    print('CircularPathDemo: 8-point circular approximation setup');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.repeat();
                print('CircularPathDemo: Started circular motion');
              },
              child: const Text('Start Orbit'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _controller.stop();
                print('CircularPathDemo: Stopped');
              },
              child: const Text('Stop'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.indigo.shade200, width: 2),
          ),
          child: Stack(
            children: [
              // Center dot
              const Center(
                child: Icon(Icons.sunny, color: Colors.amber, size: 30),
              ),
              // Orbiting planet
              AlignTransition(
                alignment: _animation,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.public, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 5: Alignment Tween Types
// =============================================================================
// Explores different tween types: AlignmentTween, AlignmentGeometryTween,
// and custom alignment interpolations.

class AlignmentTweenTypesSection extends StatefulWidget {
  const AlignmentTweenTypesSection({super.key});

  @override
  State<AlignmentTweenTypesSection> createState() => _AlignmentTweenTypesSectionState();
}

class _AlignmentTweenTypesSectionState extends State<AlignmentTweenTypesSection>
    with _TickerProviderShim {
  late AnimationController _alignmentTweenController;
  late AnimationController _geometryTweenController;
  late AnimationController _directionalController;
  
  late Animation<AlignmentGeometry> _alignmentAnimation;
  late Animation<AlignmentGeometry> _geometryAnimation;
  late Animation<AlignmentGeometry> _directionalAnimation;

  @override
  void initState() {
    super.initState();
    print('AlignmentTweenTypesSection: Comparing different tween types');
    
    // Standard AlignmentTween
    _alignmentTweenController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _alignmentAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _alignmentTweenController,
      curve: Curves.easeInOut,
    ));
    
    // AlignmentGeometryTween (can handle AlignmentDirectional)
    _geometryTweenController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _geometryAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(
      parent: _geometryTweenController,
      curve: Curves.easeInOut,
    ));
    
    // AlignmentDirectional tween
    _directionalController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _directionalAnimation = AlignmentTween(
      begin: const Alignment(-1, 0),
      end: const Alignment(1, 0),
    ).animate(CurvedAnimation(
      parent: _directionalController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _alignmentTweenController.dispose();
    _geometryTweenController.dispose();
    _directionalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Alignment Tween Types',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter provides multiple tween types for alignment animations. Each has its '
          'own use case depending on whether you need simple, geometrical, or directional alignments.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // AlignmentTween
        _buildTweenDemo(
          title: 'AlignmentTween',
          subtitle: 'Standard tween for Alignment values',
          description: 'Interpolates between two Alignment values. Best for simple, '
              'non-directional alignment animations.',
          controller: _alignmentTweenController,
          animation: _alignmentAnimation,
          color: Colors.blue,
        ),
        const SizedBox(height: 24),
        
        // AlignmentGeometryTween
        _buildTweenDemo(
          title: 'AlignmentGeometryTween',
          subtitle: 'Generic tween for AlignmentGeometry values',
          description: 'Can interpolate between any AlignmentGeometry values, including '
              'Alignment and AlignmentDirectional. More flexible.',
          controller: _geometryTweenController,
          animation: _geometryAnimation,
          color: Colors.green,
        ),
        const SizedBox(height: 24),
        
        // AlignmentDirectional
        _buildTweenDemo(
          title: 'AlignmentDirectional (via AlignmentGeometryTween)',
          subtitle: 'Text-direction aware alignment',
          description: 'Uses start/end instead of left/right, making it automatically '
              'adapt to RTL languages. Essential for internationalization.',
          controller: _directionalController,
          animation: _directionalAnimation,
          color: Colors.purple,
        ),
        const SizedBox(height: 24),
        
        // RTL vs LTR comparison
        const Text(
          'RTL vs LTR with AlignmentDirectional',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const DirectionalComparisonDemo(),
        const SizedBox(height: 24),
        
        // Comparison table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'When to Use Each Type:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildComparisonRow('AlignmentTween', 
                'Simple left/right/top/bottom animations', 
                Colors.blue),
              const SizedBox(height: 8),
              _buildComparisonRow('AlignmentGeometryTween', 
                'When mixing Alignment types or need flexibility', 
                Colors.green),
              const SizedBox(height: 8),
              _buildComparisonRow('AlignmentDirectional', 
                'RTL-aware apps, localized UI', 
                Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTweenDemo({
    required String title,
    required String subtitle,
    required String description,
    required AnimationController controller,
    required Animation<AlignmentGeometry> animation,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                controller.forward(from: 0);
                print('TweenTypesSection: $title animation started');
              },
              style: ElevatedButton.styleFrom(backgroundColor: color),
              child: const Text('Animate', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => controller.reverse(),
              child: const Text('Reverse'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: AlignTransition(
            alignment: animation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.swap_horiz, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonRow(String type, String useCase, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 13),
              children: [
                TextSpan(
                  text: '$type: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: useCase),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Demonstrates AlignmentDirectional behavior in RTL vs LTR contexts
class DirectionalComparisonDemo extends StatefulWidget {
  const DirectionalComparisonDemo({super.key});

  @override
  State<DirectionalComparisonDemo> createState() => _DirectionalComparisonDemoState();
}

class _DirectionalComparisonDemoState extends State<DirectionalComparisonDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = AlignmentTween(
      begin: const Alignment(-1, 0),
      end: const Alignment(1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    print('DirectionalComparisonDemo: Showing RTL vs LTR behavior');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    print('DirectionalComparisonDemo: Animation toggled');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _animate,
          child: const Text('Toggle Start → End'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // LTR context
            Expanded(
              child: Column(
                children: [
                  const Text('LTR (Left-to-Right)', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: AlignTransition(
                        alignment: _animation,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward, 
                            color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // RTL context
            Expanded(
              child: Column(
                children: [
                  const Text('RTL (Right-to-Left)', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlignTransition(
                        alignment: _animation,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward, 
                            color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Notice: Same animation code, but "start" is left in LTR and right in RTL!',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 6: Curves and Duration Control
// =============================================================================
// Demonstrates how different animation curves and durations affect the
// appearance and feel of alignment transitions.

class CurvesAndDurationSection extends StatefulWidget {
  const CurvesAndDurationSection({super.key});

  @override
  State<CurvesAndDurationSection> createState() => _CurvesAndDurationSectionState();
}

class _CurvesAndDurationSectionState extends State<CurvesAndDurationSection>
    with _TickerProviderShim {
  final List<CurveInfo> _curves = [
    CurveInfo('linear', Curves.linear, Colors.grey),
    CurveInfo('easeIn', Curves.easeIn, Colors.blue),
    CurveInfo('easeOut', Curves.easeOut, Colors.green),
    CurveInfo('easeInOut', Curves.easeInOut, Colors.purple),
    CurveInfo('bounceOut', Curves.bounceOut, Colors.orange),
    CurveInfo('elasticOut', Curves.elasticOut, Colors.red),
    CurveInfo('fastOutSlowIn', Curves.fastOutSlowIn, Colors.teal),
    CurveInfo('decelerate', Curves.decelerate, Colors.indigo),
  ];
  
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;

  @override
  void initState() {
    super.initState();
    print('CurvesAndDurationSection: Setting up ${_curves.length} curve demonstrations');
    
    _controllers = _curves.map((_) {
      return AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );
    }).toList();
    
    _animations = List.generate(_curves.length, (index) {
      return AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: _curves[index].curve,
      ));
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _animateAll() {
    for (final c in _controllers) {
      c.forward(from: 0);
    }
    print('CurvesAndDurationSection: All curve animations started simultaneously');
  }

  void _resetAll() {
    for (final c in _controllers) {
      c.reset();
    }
    print('CurvesAndDurationSection: All animations reset');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Curves and Duration',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Animation curves define the rate of change over time. Compare how different '
          'curves affect the feel of alignment transitions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _animateAll,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Race All Curves'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _resetAll,
              icon: const Icon(Icons.replay),
              label: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // All curves side by side
        ...List.generate(_curves.length, (index) {
          final curveInfo = _curves[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    curveInfo.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: curveInfo.color,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: curveInfo.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AlignTransition(
                      alignment: _animations[index],
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: curveInfo.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        
        const SizedBox(height: 24),
        
        // Duration comparison
        const Text(
          'Duration Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const DurationComparisonDemo(),
        
        const SizedBox(height: 24),
        
        // Curve selector demo
        const Text(
          'Interactive Curve Selector',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const CurveSelectorDemo(),
      ],
    );
  }
}

class CurveInfo {
  final String name;
  final Curve curve;
  final Color color;
  
  CurveInfo(this.name, this.curve, this.color);
}

/// Compares animations with different durations
class DurationComparisonDemo extends StatefulWidget {
  const DurationComparisonDemo({super.key});

  @override
  State<DurationComparisonDemo> createState() => _DurationComparisonDemoState();
}

class _DurationComparisonDemoState extends State<DurationComparisonDemo>
    with _TickerProviderShim {
  final durations = [200, 500, 1000, 2000];
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = durations.map((ms) {
      return AnimationController(
        duration: Duration(milliseconds: ms),
        vsync: this,
      );
    }).toList();
    
    _animations = _controllers.map((controller) {
      return AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();
    
    print('DurationComparisonDemo: Created animations with durations ${durations}ms');
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _startAll() {
    for (final c in _controllers) {
      c.forward(from: 0);
    }
    print('DurationComparisonDemo: Started all duration comparisons');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _startAll,
          child: const Text('Start Duration Race'),
        ),
        const SizedBox(height: 12),
        ...List.generate(durations.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '${durations[index]}ms',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: AlignTransition(
                      alignment: _animations[index],
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color.lerp(Colors.indigo.shade200, Colors.indigo.shade900, index / 3),
                          borderRadius: BorderRadius.circular(6),
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
    );
  }
}

/// Interactive curve selector with live preview
class CurveSelectorDemo extends StatefulWidget {
  const CurveSelectorDemo({super.key});

  @override
  State<CurveSelectorDemo> createState() => _CurveSelectorDemoState();
}

class _CurveSelectorDemoState extends State<CurveSelectorDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  Animation<AlignmentGeometry>? _animation;
  
  final Map<String, Curve> _availableCurves = {
    'linear': Curves.linear,
    'ease': Curves.ease,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'easeInSine': Curves.easeInSine,
    'easeOutSine': Curves.easeOutSine,
    'easeInQuad': Curves.easeInQuad,
    'easeOutQuad': Curves.easeOutQuad,
    'easeInCubic': Curves.easeInCubic,
    'easeOutCubic': Curves.easeOutCubic,
    'easeInQuart': Curves.easeInQuart,
    'easeOutQuart': Curves.easeOutQuart,
    'bounceIn': Curves.bounceIn,
    'bounceOut': Curves.bounceOut,
    'bounceInOut': Curves.bounceInOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
    'elasticInOut': Curves.elasticInOut,
    'slowMiddle': Curves.slowMiddle,
  };
  
  String _selectedCurve = 'easeInOut';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _updateAnimation();
  }

  void _updateAnimation() {
    _animation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: _availableCurves[_selectedCurve]!,
    ));
    print('CurveSelectorDemo: Selected curve: $_selectedCurve');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Curve dropdown
        Row(
          children: [
            const Text('Curve: '),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<String>(
                value: _selectedCurve,
                isExpanded: true,
                items: _availableCurves.keys.map((name) {
                  return DropdownMenuItem(value: name, child: Text(name));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCurve = value;
                      _updateAnimation();
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _controller.forward(from: 0),
              child: const Text('Play'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _controller.reverse(),
              child: const Text('Reverse'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _controller.repeat(reverse: true),
              child: const Text('Loop'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _controller.stop(),
              child: const Text('Stop'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: _animation != null
              ? AlignTransition(
                  alignment: _animation!,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 7: Size Factors with Alignment
// =============================================================================
// Demonstrates the use of widthFactor and heightFactor properties in
// combination with alignment transitions.

class SizeFactorsSection extends StatefulWidget {
  const SizeFactorsSection({super.key});

  @override
  State<SizeFactorsSection> createState() => _SizeFactorsSectionState();
}

class _SizeFactorsSectionState extends State<SizeFactorsSection>
    with _TickerProviderShim {
  late AnimationController _basicController;
  late AnimationController _widthFactorController;
  late AnimationController _bothFactorsController;
  
  late Animation<AlignmentGeometry> _basicAnimation;
  late Animation<AlignmentGeometry> _widthFactorAnimation;
  late Animation<AlignmentGeometry> _bothFactorsAnimation;

  double _widthFactor = 0.5;
  double _heightFactor = 0.5;

  @override
  void initState() {
    super.initState();
    print('SizeFactorsSection: Demonstrating width/height factors');
    
    _basicController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _basicAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _basicController, curve: Curves.easeInOut));
    
    _widthFactorController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _widthFactorAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(parent: _widthFactorController, curve: Curves.easeInOut));
    
    _bothFactorsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _bothFactorsAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _bothFactorsController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _basicController.dispose();
    _widthFactorController.dispose();
    _bothFactorsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size Factors with Alignment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'AlignTransition inherits widthFactor and heightFactor from Align. These properties '
          'constrain the parent size relative to the child, useful for responsive layouts.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // Basic (no factors)
        const Text(
          'Without Size Factors (parent fills available space)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _basicController.forward(from: 0);
            print('SizeFactorsSection: Basic animation (no factors)');
          },
          child: const Text('Animate'),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          color: Colors.amber.shade50,
          child: AlignTransition(
            alignment: _basicAnimation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('60x60')),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.amber.shade100,
          child: const Text(
            'Without factors: AlignTransition takes full available space',
            style: TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        
        // With widthFactor
        const Text(
          'With widthFactor: 2.0 (parent width = 2× child width)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _widthFactorController.forward(from: 0);
            print('SizeFactorsSection: Animation with widthFactor');
          },
          child: const Text('Animate'),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          color: Colors.green.shade50,
          child: Center(
            child: AlignTransition(
              alignment: _widthFactorAnimation,
              widthFactor: 2.0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('60x60', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.green.shade100,
          child: const Text(
            'widthFactor: 2.0 means parent width = 120px (60×2), centered in container',
            style: TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        
        // Interactive factors
        const Text(
          'Interactive Size Factors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Width Factor: '),
            Expanded(
              child: Slider(
                value: _widthFactor,
                min: 1.0,
                max: 5.0,
                divisions: 8,
                label: _widthFactor.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() => _widthFactor = value);
                  print('SizeFactorsSection: widthFactor = $_widthFactor');
                },
              ),
            ),
            Text(_widthFactor.toStringAsFixed(1)),
          ],
        ),
        Row(
          children: [
            const Text('Height Factor: '),
            Expanded(
              child: Slider(
                value: _heightFactor,
                min: 1.0,
                max: 5.0,
                divisions: 8,
                label: _heightFactor.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() => _heightFactor = value);
                  print('SizeFactorsSection: heightFactor = $_heightFactor');
                },
              ),
            ),
            Text(_heightFactor.toStringAsFixed(1)),
          ],
        ),
        ElevatedButton(
          onPressed: () => _bothFactorsController.forward(from: 0),
          child: const Text('Animate with Current Factors'),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          color: Colors.blue.shade50,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: AlignTransition(
                alignment: _bothFactorsAnimation,
                widthFactor: _widthFactor,
                heightFactor: _heightFactor,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('50', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue.shade100,
          child: Text(
            'Parent size: ${(50 * _widthFactor).toStringAsFixed(0)}×${(50 * _heightFactor).toStringAsFixed(0)} pixels (blue border shows parent bounds)',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 8: Practical Use Cases
// =============================================================================
// Demonstrates real-world applications of AlignTransition in UI design.

class PracticalUseCasesSection extends StatefulWidget {
  const PracticalUseCasesSection({super.key});

  @override
  State<PracticalUseCasesSection> createState() => _PracticalUseCasesSectionState();
}

class _PracticalUseCasesSectionState extends State<PracticalUseCasesSection> {
  @override
  void initState() {
    super.initState();
    print('PracticalUseCasesSection: Showing real-world applications');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practical Use Cases',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Real-world applications of AlignTransition in common UI patterns.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        
        // FAB position toggle
        const Text(
          '1. Floating Action Button Position Toggle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const FABPositionDemo(),
        const SizedBox(height: 32),
        
        // Menu item reveal
        const Text(
          '2. Menu Item Staggered Reveal',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const MenuRevealDemo(),
        const SizedBox(height: 32),
        
        // Card highlight
        const Text(
          '3. Featured Card Highlight',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const CardHighlightDemo(),
        const SizedBox(height: 32),
        
        // Loading indicator
        const Text(
          '4. Animated Loading Indicator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const LoadingIndicatorDemo(),
        const SizedBox(height: 32),
        
        // Onboarding pointer
        const Text(
          '5. Onboarding Feature Pointer',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const OnboardingPointerDemo(),
      ],
    );
  }
}

/// Demonstrates FAB that toggles between bottom-right and bottom-center
class FABPositionDemo extends StatefulWidget {
  const FABPositionDemo({super.key});

  @override
  State<FABPositionDemo> createState() => _FABPositionDemoState();
}

class _FABPositionDemoState extends State<FABPositionDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = AlignmentTween(
      begin: Alignment.bottomRight,
      end: Alignment.bottomCenter,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    print('FABPositionDemo: FAB toggle animation ready');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePosition() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    print('FABPositionDemo: FAB moved to ${_isExpanded ? "center" : "corner"}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Fake app content
          const Positioned.fill(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('App Content Area', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          
          // Animated FAB
          Padding(
            padding: const EdgeInsets.all(16),
            child: AlignTransition(
              alignment: _animation,
              child: GestureDetector(
                onTap: _togglePosition,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isExpanded ? 160 : 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(_isExpanded ? 28 : 16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: Colors.white),
                      if (_isExpanded) ...[
                        const SizedBox(width: 8),
                        const Text('Create New', style: TextStyle(color: Colors.white)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Demonstrates staggered menu item reveal
class MenuRevealDemo extends StatefulWidget {
  const MenuRevealDemo({super.key});

  @override
  State<MenuRevealDemo> createState() => _MenuRevealDemoState();
}

class _MenuRevealDemoState extends State<MenuRevealDemo>
    with _TickerProviderShim {
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;
  bool _isVisible = false;

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
    });
    
    _animations = List.generate(4, (index) {
      return AlignmentTween(
        begin: const Alignment(-2, 0),
        end: Alignment.center,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOutBack,
      ));
    });
    
    print('MenuRevealDemo: Staggered menu animations ready');
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleMenu() async {
    setState(() => _isVisible = !_isVisible);
    
    if (_isVisible) {
      for (int i = 0; i < _controllers.length; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        _controllers[i].forward();
      }
      print('MenuRevealDemo: Menu revealed');
    } else {
      for (int i = _controllers.length - 1; i >= 0; i--) {
        await Future.delayed(const Duration(milliseconds: 50));
        _controllers[i].reverse();
      }
      print('MenuRevealDemo: Menu hidden');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _toggleMenu,
          child: Text(_isVisible ? 'Hide Menu' : 'Show Menu'),
        ),
        const SizedBox(height: 12),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: AlignTransition(
                  alignment: _animations[index],
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_icons[index], color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// Demonstrates card that moves to highlight
class CardHighlightDemo extends StatefulWidget {
  const CardHighlightDemo({super.key});

  @override
  State<CardHighlightDemo> createState() => _CardHighlightDemoState();
}

class _CardHighlightDemoState extends State<CardHighlightDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  int _highlightedIndex = 0;
  
  late List<Animation<AlignmentGeometry>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _updateAnimations();
    print('CardHighlightDemo: Card highlight system ready');
  }

  void _updateAnimations() {
    _animations = List.generate(3, (index) {
      final isHighlighted = index == _highlightedIndex;
      return AlignmentTween(
        begin: Alignment.center,
        end: isHighlighted ? const Alignment(0, -0.3) : Alignment.center,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _highlightCard(int index) {
    setState(() {
      _highlightedIndex = index;
      _updateAnimations();
    });
    _controller.forward(from: 0);
    print('CardHighlightDemo: Card $index highlighted');
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.blue];
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: () => _highlightCard(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _highlightedIndex == index ? colors[index] : Colors.grey,
                ),
                child: Text('Card ${index + 1}', 
                  style: const TextStyle(color: Colors.white)),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: List.generate(3, (index) {
              final isHighlighted = index == _highlightedIndex;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: AlignTransition(
                    alignment: _animations[index],
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isHighlighted ? 120 : 100,
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isHighlighted
                            ? [
                                BoxShadow(
                                  color: colors[index].withValues(alpha: 0.5),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          'Card ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// Demonstrates animated loading indicator using alignment
class LoadingIndicatorDemo extends StatefulWidget {
  const LoadingIndicatorDemo({super.key});

  @override
  State<LoadingIndicatorDemo> createState() => _LoadingIndicatorDemoState();
}

class _LoadingIndicatorDemoState extends State<LoadingIndicatorDemo>
    with _TickerProviderShim {
  late List<AnimationController> _controllers;
  late List<Animation<AlignmentGeometry>> _animations;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });
    
    _animations = List.generate(3, (index) {
      return AlignmentTween(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });
    
    print('LoadingIndicatorDemo: Custom loading indicator ready');
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleLoading() {
    setState(() => _isLoading = !_isLoading);
    
    if (_isLoading) {
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 200), () {
          if (_isLoading) {
            _controllers[i].repeat(reverse: true);
          }
        });
      }
      print('LoadingIndicatorDemo: Loading started');
    } else {
      for (final c in _controllers) {
        c.stop();
        c.reset();
      }
      print('LoadingIndicatorDemo: Loading stopped');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _toggleLoading,
          child: Text(_isLoading ? 'Stop Loading' : 'Start Loading'),
        ),
        const SizedBox(height: 12),
        Container(
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 16,
                  height: 40,
                  child: AlignTransition(
                    alignment: _animations[index],
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// Demonstrates onboarding feature pointer
class OnboardingPointerDemo extends StatefulWidget {
  const OnboardingPointerDemo({super.key});

  @override
  State<OnboardingPointerDemo> createState() => _OnboardingPointerDemoState();
}

class _OnboardingPointerDemoState extends State<OnboardingPointerDemo>
    with _TickerProviderShim {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  int _currentStep = 0;
  
  final List<Alignment> _positions = [
    const Alignment(-0.8, -0.7),
    const Alignment(0.8, -0.7),
    const Alignment(0, 0.5),
  ];
  
  final List<String> _labels = [
    'Tap here to open menu',
    'Search for items here',
    'Your profile is here',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = AlignmentTween(
      begin: _positions[0],
      end: _positions[0],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    // Pulsing animation
    _controller.repeat(reverse: true);
    
    print('OnboardingPointerDemo: Onboarding pointer ready');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _currentStep = (_currentStep + 1) % _positions.length;
      _animation = AlignmentTween(
        begin: _positions[_currentStep],
        end: _positions[_currentStep] + const Alignment(0, 0.05),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    });
    print('OnboardingPointerDemo: Moved to step $_currentStep');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _nextStep,
          child: const Text('Next Feature'),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Fake UI elements
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.menu, color: Colors.grey),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.search, color: Colors.grey),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
              
              // Animated pointer
              AlignTransition(
                alignment: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        _labels[_currentStep],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_downward, color: Colors.amber, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Entry Point
// =============================================================================

dynamic build(BuildContext context) {
  print('AlignTransition Deep Demo: Building main widget');
  print('AlignTransition Deep Demo: 8 sections covering alignment animations');
  print('AlignTransition Deep Demo: Demonstrates basic, horizontal, vertical, diagonal');
  print('AlignTransition Deep Demo: Shows tween types, curves, size factors, practical uses');
  
  return MaterialApp(
    title: 'AlignTransition Deep Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    home: const AlignTransitionDeepDemo(),
  );
}
