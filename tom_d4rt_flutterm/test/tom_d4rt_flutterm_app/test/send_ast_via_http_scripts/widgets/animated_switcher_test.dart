// ignore_for_file: avoid_print
// Deep demo: AnimatedSwitcher - Animated transitions between child widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedSwitcherDemo(),
  );
}

class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({super.key});

  @override
  State<AnimatedSwitcherDemo> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Switcher Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  int _basicCounter = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Transition Builder Variations
  // ═══════════════════════════════════════════════════════════════════════════
  int _transitionIndex = 0;
  String _selectedTransition = 'fade';

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration and Curve
  // ═══════════════════════════════════════════════════════════════════════════
  int _durationCounter = 0;
  Duration _selectedDuration = const Duration(milliseconds: 300);
  Curve _selectedCurve = Curves.easeInOut;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Layout Builder
  // ═══════════════════════════════════════════════════════════════════════════
  int _layoutCounter = 0;
  int _layoutType = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Key-based Switching
  // ═══════════════════════════════════════════════════════════════════════════
  int _keyIndex = 0;
  final _keyColors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Multiple Children Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  int _multiIndex = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Custom Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  int _customIndex = 0;
  int _customTransitionType = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  int _tabIndex = 0;
  bool _isLoading = true;
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSwitcher Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Fundamentals
            _buildSectionHeader('1. Basic Switcher Fundamentals'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            // Section 2: Transition Builder Variations
            _buildSectionHeader('2. Transition Builder Variations'),
            _buildTransitionBuilderSection(),
            const SizedBox(height: 32),

            // Section 3: Duration and Curve
            _buildSectionHeader('3. Duration and Curve'),
            _buildDurationCurveSection(),
            const SizedBox(height: 32),

            // Section 4: Layout Builder
            _buildSectionHeader('4. Layout Builder'),
            _buildLayoutBuilderSection(),
            const SizedBox(height: 32),

            // Section 5: Key-based Switching
            _buildSectionHeader('5. Key-based Switching'),
            _buildKeyBasedSection(),
            const SizedBox(height: 32),

            // Section 6: Multiple Children Transitions
            _buildSectionHeader('6. Multiple Children Transitions'),
            _buildMultipleChildrenSection(),
            const SizedBox(height: 32),

            // Section 7: Custom Transitions
            _buildSectionHeader('7. Custom Transitions'),
            _buildCustomTransitionsSection(),
            const SizedBox(height: 32),

            // Section 8: Practical Use Cases
            _buildSectionHeader('8. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),

            // API Reference
            _buildSectionHeader('API Reference'),
            _buildApiReference(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Switcher Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== SECTION 1: Basic Switcher Fundamentals ===');
    print('AnimatedSwitcher animates between different child widgets');
    print('Key is required for AnimatedSwitcher to detect changes');
    print('Default transition is FadeTransition');
    print('Current counter: $_basicCounter');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic counter with fade transition:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Basic animated counter
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  '$_basicCounter',
                  key: ValueKey<int>(_basicCounter),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _basicCounter--);
                    print('Counter decreased to: $_basicCounter');
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrease'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _basicCounter++);
                    print('Counter increased to: $_basicCounter');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Increase'),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Text(
              'Note: Each number needs a unique key (ValueKey) to trigger the animation.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Basic section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Transition Builder Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTransitionBuilderSection() {
    print('=== SECTION 2: Transition Builder Variations ===');
    print('transitionBuilder defines the animation used');
    print('Common builders: FadeTransition, ScaleTransition, SlideTransition, RotationTransition');
    print('Selected transition: $_selectedTransition');

    final transitions = <String, Widget Function(Widget, Animation<double>)>{
      'fade': (child, animation) => FadeTransition(opacity: animation, child: child),
      'scale': (child, animation) => ScaleTransition(scale: animation, child: child),
      'rotation': (child, animation) => RotationTransition(turns: animation, child: child),
      'slide (up)': (child, animation) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
            child: child,
          ),
      'slide (down)': (child, animation) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation),
            child: child,
          ),
      'slide (left)': (child, animation) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          ),
      'slide (right)': (child, animation) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
            child: child,
          ),
      'size': (child, animation) => SizeTransition(sizeFactor: animation, child: child),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a transition type:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Transition selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: transitions.keys.map((name) {
                return ChoiceChip(
                  label: Text(name),
                  selected: _selectedTransition == name,
                  onSelected: (_) {
                    setState(() => _selectedTransition = name);
                    print('Transition changed to: $name');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Demo area
            Center(
              child: Container(
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: transitions[_selectedTransition]!,
                    child: Container(
                      key: ValueKey<int>(_transitionIndex),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.primaries[_transitionIndex % Colors.primaries.length],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${_transitionIndex + 1}',
                          style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _transitionIndex++);
                  print('Transition demo: index $_transitionIndex, type: $_selectedTransition');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Next'),
              ),
            ),

            print('Transition builder section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration and Curve
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationCurveSection() {
    print('=== SECTION 3: Duration and Curve ===');
    print('duration: Controls animation length');
    print('reverseDuration: Optional separate duration for reverse');
    print('switchInCurve/switchOutCurve: Animation curves');
    print('Selected duration: ${_selectedDuration.inMilliseconds}ms');
    print('Selected curve: $_selectedCurve');

    final durations = [100, 200, 400, 800, 1500];
    final curves = <String, Curve>{
      'linear': Curves.linear,
      'easeIn': Curves.easeIn,
      'easeOut': Curves.easeOut,
      'easeInOut': Curves.easeInOut,
      'bounceIn': Curves.bounceIn,
      'bounceOut': Curves.bounceOut,
      'elasticIn': Curves.elasticIn,
      'elasticOut': Curves.elasticOut,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configure timing:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Duration selector
            const Text('Duration:', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: durations.map((ms) {
                return ChoiceChip(
                  label: Text('${ms}ms'),
                  selected: _selectedDuration.inMilliseconds == ms,
                  onSelected: (_) {
                    setState(() => _selectedDuration = Duration(milliseconds: ms));
                    print('Duration changed to: ${ms}ms');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Curve selector
            const Text('Curve:', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: curves.entries.map((entry) {
                return ChoiceChip(
                  label: Text(entry.key),
                  selected: _selectedCurve == entry.value,
                  onSelected: (_) {
                    setState(() => _selectedCurve = entry.value);
                    print('Curve changed to: ${entry.key}');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Demo
            Center(
              child: AnimatedSwitcher(
                duration: _selectedDuration,
                switchInCurve: _selectedCurve,
                switchOutCurve: _selectedCurve,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Icon(
                  _durationCounter.isEven ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey<int>(_durationCounter),
                  size: 80,
                  color: Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _durationCounter++);
                  print('Duration demo toggled: $_durationCounter');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Toggle'),
              ),
            ),

            print('Duration and curve section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Layout Builder
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLayoutBuilderSection() {
    print('=== SECTION 4: Layout Builder ===');
    print('layoutBuilder controls how current and previous children are stacked');
    print('Default uses Stack with Alignment.center');
    print('Custom layouts allow different positioning strategies');
    print('Current layout type: $_layoutType');

    Widget Function(Widget?, List<Widget>) layoutBuilder;
    String layoutName;

    switch (_layoutType) {
      case 0:
        layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder;
        layoutName = 'Default (Stack centered)';
        break;
      case 1:
        layoutBuilder = (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topLeft,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        };
        layoutName = 'Top-Left aligned';
        break;
      case 2:
        layoutBuilder = (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        };
        layoutName = 'Bottom-Right aligned';
        break;
      default:
        layoutBuilder = (currentChild, previousChildren) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentChild != null) currentChild,
            ],
          );
        };
        layoutName = 'Column (no overlap)';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom layout builders:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Default'),
                  selected: _layoutType == 0,
                  onSelected: (_) {
                    setState(() => _layoutType = 0);
                    print('Layout: Default');
                  },
                ),
                ChoiceChip(
                  label: const Text('Top-Left'),
                  selected: _layoutType == 1,
                  onSelected: (_) {
                    setState(() => _layoutType = 1);
                    print('Layout: Top-Left');
                  },
                ),
                ChoiceChip(
                  label: const Text('Bottom-Right'),
                  selected: _layoutType == 2,
                  onSelected: (_) {
                    setState(() => _layoutType = 2);
                    print('Layout: Bottom-Right');
                  },
                ),
                ChoiceChip(
                  label: const Text('Column'),
                  selected: _layoutType == 3,
                  onSelected: (_) {
                    setState(() => _layoutType = 3);
                    print('Layout: Column');
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text('Current: $layoutName', style: const TextStyle(fontStyle: FontStyle.italic)),

            const SizedBox(height: 16),

            // Demo
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                layoutBuilder: layoutBuilder,
                child: Container(
                  key: ValueKey<int>(_layoutCounter),
                  width: 60 + (_layoutCounter % 3) * 20.0,
                  height: 40 + (_layoutCounter % 3) * 15.0,
                  decoration: BoxDecoration(
                    color: Colors.primaries[_layoutCounter % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${_layoutCounter + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _layoutCounter++);
                  print('Layout demo: $_layoutCounter');
                },
                icon: const Icon(Icons.grid_view),
                label: const Text('Switch'),
              ),
            ),

            print('Layout builder section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Key-based Switching
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildKeyBasedSection() {
    print('=== SECTION 5: Key-based Switching ===');
    print('AnimatedSwitcher uses keys to determine when to animate');
    print('Without unique keys, no animation occurs');
    print('ValueKey is commonly used for simple values');
    print('ObjectKey for complex objects');
    print('Current key index: $_keyIndex');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Key importance in AnimatedSwitcher:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // With key (animates)
            Row(
              children: [
                const SizedBox(width: 100, child: Text('With Key:')),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey<Color>(_keyColors[_keyIndex]),
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _keyColors[_keyIndex],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Key ${_keyIndex + 1}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Without key (no animation)
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Without Key:')),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      // Note: No key! Animation won't trigger
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _keyColors[_keyIndex],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'No Key',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Color selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_keyColors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _keyIndex = index);
                    print('Key index changed to: $index, color: ${_keyColors[index]}');
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _keyColors[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _keyIndex == index ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            const Text(
              'Notice: The "With Key" version animates, while "Without Key" just changes instantly.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Key-based section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Multiple Children Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMultipleChildrenSection() {
    print('=== SECTION 6: Multiple Children Transitions ===');
    print('AnimatedSwitcher manages outgoing children during transitions');
    print('Previous children fade out while new child fades in');
    print('Current index: $_multiIndex');

    final items = [
      {'icon': Icons.home, 'label': 'Home', 'color': Colors.blue},
      {'icon': Icons.search, 'label': 'Search', 'color': Colors.green},
      {'icon': Icons.notifications, 'label': 'Alerts', 'color': Colors.orange},
      {'icon': Icons.settings, 'label': 'Settings', 'color': Colors.purple},
      {'icon': Icons.person, 'label': 'Profile', 'color': Colors.teal},
    ];

    final item = items[_multiIndex % items.length];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Switching between multiple children:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Main display
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey<int>(_multiIndex),
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: item['color'] as Color, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'] as IconData, size: 40, color: item['color'] as Color),
                      const SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: item['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Navigation dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(items.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _multiIndex = index);
                    print('Multi index: $index');
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _multiIndex % items.length == index
                          ? items[index]['color'] as Color
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _multiIndex = (_multiIndex - 1 + items.length) % items.length);
                    print('Multi prev: $_multiIndex');
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Prev'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _multiIndex = (_multiIndex + 1) % items.length);
                    print('Multi next: $_multiIndex');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
              ],
            ),

            print('Multiple children section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Custom Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCustomTransitionsSection() {
    print('=== SECTION 7: Custom Transitions ===');
    print('transitionBuilder can combine multiple animations');
    print('Create complex effects by layering transitions');
    print('Custom transition type: $_customTransitionType');

    Widget Function(Widget, Animation<double>) customTransition;
    String transitionName;

    switch (_customTransitionType) {
      case 0:
        customTransition = (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        };
        transitionName = 'Fade + Scale';
        break;
      case 1:
        customTransition = (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        };
        transitionName = 'Slide + Fade';
        break;
      case 2:
        customTransition = (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 0.0).animate(animation),
            child: ScaleTransition(scale: animation, child: child),
          );
        };
        transitionName = 'Rotate + Scale';
        break;
      case 3:
        customTransition = (child, animation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          );
          return ScaleTransition(
            scale: curvedAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        };
        transitionName = 'Elastic Scale';
        break;
      default:
        customTransition = (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.bounceOut))
                .animate(animation),
            child: child,
          );
        };
        transitionName = 'Bounce Slide';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combined custom transitions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Transition type selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Fade+Scale'),
                  selected: _customTransitionType == 0,
                  onSelected: (_) {
                    setState(() => _customTransitionType = 0);
                    print('Custom: Fade+Scale');
                  },
                ),
                ChoiceChip(
                  label: const Text('Slide+Fade'),
                  selected: _customTransitionType == 1,
                  onSelected: (_) {
                    setState(() => _customTransitionType = 1);
                    print('Custom: Slide+Fade');
                  },
                ),
                ChoiceChip(
                  label: const Text('Rotate+Scale'),
                  selected: _customTransitionType == 2,
                  onSelected: (_) {
                    setState(() => _customTransitionType = 2);
                    print('Custom: Rotate+Scale');
                  },
                ),
                ChoiceChip(
                  label: const Text('Elastic'),
                  selected: _customTransitionType == 3,
                  onSelected: (_) {
                    setState(() => _customTransitionType = 3);
                    print('Custom: Elastic');
                  },
                ),
                ChoiceChip(
                  label: const Text('Bounce'),
                  selected: _customTransitionType == 4,
                  onSelected: (_) {
                    setState(() => _customTransitionType = 4);
                    print('Custom: Bounce');
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text('Current: $transitionName', style: const TextStyle(fontStyle: FontStyle.italic)),

            const SizedBox(height: 16),

            // Demo
            Center(
              child: Container(
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: customTransition,
                    child: Container(
                      key: ValueKey<int>(_customIndex),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.primaries[_customIndex % Colors.primaries.length],
                            Colors.primaries[(_customIndex + 3) % Colors.primaries.length],
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Item ${_customIndex + 1}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _customIndex++);
                  print('Custom demo: $_customIndex');
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Animate'),
              ),
            ),

            print('Custom transitions section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== SECTION 8: Practical Use Cases ===');
    print('AnimatedSwitcher is ideal for:');
    print('  - Tab content transitions');
    print('  - Loading to content states');
    print('  - Multi-step wizards');
    print('  - Dynamic content updates');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world applications:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Use Case 1: Tab Content
            const Text('1. Tab Content Transition:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Tab bar
                  Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _tabIndex = index);
                            print('Tab changed to: $index');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _tabIndex == index ? Colors.deepPurple : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
                                topRight: index == 2 ? const Radius.circular(12) : Radius.zero,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                ['Home', 'Products', 'About'][index],
                                style: TextStyle(
                                  color: _tabIndex == index ? Colors.white : Colors.grey,
                                  fontWeight: _tabIndex == index ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  // Tab content
                  SizedBox(
                    height: 100,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildTabContent(_tabIndex),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Use Case 2: Loading State
            const Text('2. Loading to Content:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _isLoading
                        ? Container(
                            key: const ValueKey('loading'),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                                  SizedBox(width: 12),
                                  Text('Loading data...'),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            key: const ValueKey('content'),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('Data loaded successfully!', style: TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _isLoading = !_isLoading);
                    print('Loading state: $_isLoading');
                  },
                  child: Text(_isLoading ? 'Load' : 'Reset'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Use Case 3: Wizard Steps
            const Text('3. Multi-step Wizard:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Step indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index <= _step ? Colors.blue : Colors.grey.shade300,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: index <= _step ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (index < 3)
                            Container(
                              width: 40,
                              height: 2,
                              color: index < _step ? Colors.blue : Colors.grey.shade300,
                            ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  // Step content
                  SizedBox(
                    height: 80,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(opacity: animation, child: child),
                        );
                      },
                      child: Container(
                        key: ValueKey<int>(_step),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              [Icons.person, Icons.payment, Icons.local_shipping, Icons.check_circle][_step],
                              color: Colors.blue,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ['Personal Info', 'Payment', 'Shipping', 'Complete'][_step],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _step > 0
                            ? () {
                                setState(() => _step--);
                                print('Wizard step: $_step');
                              }
                            : null,
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: _step < 3
                            ? () {
                                setState(() => _step++);
                                print('Wizard step: $_step');
                              }
                            : null,
                        child: Text(_step < 3 ? 'Next' : 'Done'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            print('Practical use cases section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    final contents = [
      {'icon': Icons.home, 'title': 'Welcome Home', 'color': Colors.blue},
      {'icon': Icons.store, 'title': 'Our Products', 'color': Colors.green},
      {'icon': Icons.info, 'title': 'About Us', 'color': Colors.orange},
    ];
    final content = contents[index];

    return Container(
      key: ValueKey<int>(index),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(content['icon'] as IconData, size: 48, color: content['color'] as Color),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content['title'] as String,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: content['color'] as Color),
              ),
              const Text('Content for this tab section', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // API Reference
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildApiReference() {
    print('=== API Reference Summary ===');
    print('AnimatedSwitcher Properties:');
    print('  - child: Widget - Current child widget');
    print('  - duration: Duration - Transition duration');
    print('  - reverseDuration: Duration? - Reverse transition duration');
    print('  - switchInCurve: Curve - Curve for incoming widget');
    print('  - switchOutCurve: Curve - Curve for outgoing widget');
    print('  - transitionBuilder: Function - Animation builder');
    print('  - layoutBuilder: Function - Layout for stacking widgets');

    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedSwitcher API',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),

            _buildApiRow('child', 'Widget?', 'Current child to display'),
            _buildApiRow('duration', 'Duration', 'Transition animation duration'),
            _buildApiRow('reverseDuration', 'Duration?', 'Optional reverse duration'),
            _buildApiRow('switchInCurve', 'Curve', 'Incoming widget curve (default: linear)'),
            _buildApiRow('switchOutCurve', 'Curve', 'Outgoing widget curve (default: linear)'),
            _buildApiRow('transitionBuilder', 'Function', 'Builds the transition animation'),
            _buildApiRow('layoutBuilder', 'Function', 'Positions current and previous children'),

            const SizedBox(height: 12),
            const Text(
              'Key Requirements:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Child must have a unique key to trigger animation'),
            const Text('• Use ValueKey for simple values'),
            const Text('• Use ObjectKey for complex object identity'),
            const Text('• Use UniqueKey for always-different identity'),

            const SizedBox(height: 12),
            const Text(
              'Default Transition:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• FadeTransition with the given duration'),
            const Text('• Override with transitionBuilder for custom effects'),

            const SizedBox(height: 12),
            const Text(
              'Key Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Previous children animate out while new child animates in'),
            const Text('• Both children visible during transition'),
            const Text('• Handles null children (animates away)'),
            const Text('• Great for content that changes frequently'),
          ],
        ),
      ),
    );
  }

  Widget _buildApiRow(String name, String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 100,
            child: Text(type, style: const TextStyle(fontFamily: 'monospace', color: Colors.blue, fontSize: 12)),
          ),
          Expanded(child: Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey))),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
