// ignore_for_file: avoid_print
// ============================================================================
// PERFORMANCE OVERLAY — DEEP VISUAL DEMONSTRATION
// ============================================================================
//
// PerformanceOverlay is a powerful debugging widget that displays real-time
// performance statistics as an overlay on your app. It shows frame timing
// information from both the UI thread (Dart code) and the raster thread
// (GPU rendering), helping developers identify performance bottlenecks.
//
// Key features demonstrated:
// - Basic overlay construction with optionsMask
// - PerformanceOverlay.allEnabled() convenience constructor
// - Individual option flags (display vs visualize, rasterizer vs engine)
// - Integration patterns in app layouts
// - Understanding the performance metrics
//
// The overlay displays bar graphs showing frame times:
// - GREEN bars = frames completed within budget (16ms for 60fps)
// - RED bars = frames that exceeded the budget (janky frames)
//
// ============================================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================================
// MAIN BUILD FUNCTION
// ============================================================================

dynamic build(BuildContext context) {
  print('[PerformanceOverlay Demo] Building comprehensive visual demonstration');
  print('[PerformanceOverlay Demo] Scenes: Observatory, Pipeline Lab, Frame Budget, Integration, Profiling');
  
  return const MaterialApp(
    title: 'PerformanceOverlay Deep Demo',
    debugShowCheckedModeBanner: false,
    home: _PerformanceOverlayShowcase(),
  );
}

// ============================================================================
// MAIN SHOWCASE SCAFFOLD
// ============================================================================

class _PerformanceOverlayShowcase extends StatefulWidget {
  const _PerformanceOverlayShowcase();

  @override
  State<_PerformanceOverlayShowcase> createState() => _PerformanceOverlayShowcaseState();
}

class _PerformanceOverlayShowcaseState extends State<_PerformanceOverlayShowcase> {
  int _activeSceneIndex = 0;

  static const List<String> _sceneTitles = [
    'Overlay Observatory',
    'Render Pipeline Lab',
    'Frame Budget Dashboard',
    'Integration Showcase',
    'Profiling Patterns',
  ];

  static const List<IconData> _sceneIcons = [
    Icons.visibility,
    Icons.memory,
    Icons.timer,
    Icons.layers,
    Icons.analytics,
  ];

  @override
  Widget build(BuildContext context) {
    print('[Showcase] Active scene: ${_sceneTitles[_activeSceneIndex]}');
    
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Column(
        children: [
          // Header with scene navigation
          _HeaderNavigation(
            sceneTitles: _sceneTitles,
            sceneIcons: _sceneIcons,
            activeIndex: _activeSceneIndex,
            onSceneSelected: (index) {
              setState(() {
                _activeSceneIndex = index;
              });
              print('[Showcase] Switched to scene: ${_sceneTitles[index]}');
            },
          ),
          
          // Main content area
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildSceneContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSceneContent() {
    switch (_activeSceneIndex) {
      case 0:
        return const _OverlayObservatoryScene(key: ValueKey('observatory'));
      case 1:
        return const _RenderPipelineLabScene(key: ValueKey('pipeline'));
      case 2:
        return const _FrameBudgetDashboardScene(key: ValueKey('budget'));
      case 3:
        return const _IntegrationShowcaseScene(key: ValueKey('integration'));
      case 4:
        return const _ProfilingPatternsScene(key: ValueKey('profiling'));
      default:
        return const SizedBox.shrink();
    }
  }
}

// ============================================================================
// HEADER NAVIGATION
// ============================================================================

class _HeaderNavigation extends StatelessWidget {
  final List<String> sceneTitles;
  final List<IconData> sceneIcons;
  final int activeIndex;
  final ValueChanged<int> onSceneSelected;

  const _HeaderNavigation({
    required this.sceneTitles,
    required this.sceneIcons,
    required this.activeIndex,
    required this.onSceneSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(
          bottom: BorderSide(color: Color(0xFF30363D), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D9FF), Color(0xFF00FF88)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.speed,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PerformanceOverlay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Real-time frame timing visualization for debugging',
                      style: TextStyle(
                        color: Color(0xFF8B949E),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Scene tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(sceneTitles.length, (index) {
                final isActive = index == activeIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => onSceneSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive 
                            ? const Color(0xFF00D9FF).withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActive 
                              ? const Color(0xFF00D9FF)
                              : const Color(0xFF30363D),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            sceneIcons[index],
                            color: isActive 
                                ? const Color(0xFF00D9FF)
                                : const Color(0xFF8B949E),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            sceneTitles[index],
                            style: TextStyle(
                              color: isActive 
                                  ? const Color(0xFF00D9FF)
                                  : const Color(0xFF8B949E),
                              fontSize: 13,
                              fontWeight: isActive 
                                  ? FontWeight.w600 
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SCENE 1: OVERLAY OBSERVATORY
// ============================================================================
//
// This scene provides an interactive exploration of PerformanceOverlay's
// option flags. Users can toggle each option to understand what it controls
// and observe the resulting bitmask value.

class _OverlayObservatoryScene extends StatefulWidget {
  const _OverlayObservatoryScene({super.key});

  @override
  State<_OverlayObservatoryScene> createState() => _OverlayObservatorySceneState();
}

class _OverlayObservatorySceneState extends State<_OverlayObservatoryScene> {
  // Track which options are enabled
  bool _displayRasterizer = false;
  bool _visualizeRasterizer = false;
  bool _displayEngine = false;
  bool _visualizeEngine = false;

  // Compute the options mask from individual flags
  int get _computedMask {
    int mask = 0;
    if (_displayRasterizer) mask |= PerformanceOverlayOption.displayRasterizerStatistics.index;
    if (_visualizeRasterizer) mask |= PerformanceOverlayOption.visualizeRasterizerStatistics.index;
    if (_displayEngine) mask |= PerformanceOverlayOption.displayEngineStatistics.index;
    if (_visualizeEngine) mask |= PerformanceOverlayOption.visualizeEngineStatistics.index;
    return mask;
  }

  bool get _hasAnyOption => _displayRasterizer || _visualizeRasterizer || _displayEngine || _visualizeEngine;

  @override
  Widget build(BuildContext context) {
    print('[Observatory] Building with mask: $_computedMask');
    print('[Observatory] Options - displayRaster:$_displayRasterizer visualizeRaster:$_visualizeRasterizer displayEngine:$_displayEngine visualizeEngine:$_visualizeEngine');

    return Row(
      children: [
        // Left panel: Option controls
        Expanded(
          flex: 2,
          child: _buildControlPanel(),
        ),
        
        // Right panel: Live overlay preview
        Expanded(
          flex: 3,
          child: _buildPreviewPanel(),
        ),
      ],
    );
  }

  Widget _buildControlPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Color(0xFF00D9FF),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Option Flags',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Toggle individual performance overlay options to see their effect. The optionsMask is a bitmask combining these flags.',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 13,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Option toggles
            _buildOptionCard(
              title: 'displayRasterizerStatistics',
              description: 'Shows numeric statistics for the GPU rasterizer thread, displaying frame times and performance metrics.',
              color: const Color(0xFF58A6FF),
              bitValue: PerformanceOverlayOption.displayRasterizerStatistics.index,
              isEnabled: _displayRasterizer,
              onChanged: (v) => setState(() => _displayRasterizer = v),
            ),
            
            const SizedBox(height: 12),
            
            _buildOptionCard(
              title: 'visualizeRasterizerStatistics',
              description: 'Displays a real-time bar graph of rasterizer frame times. Green = within budget, Red = over budget.',
              color: const Color(0xFF3FB950),
              bitValue: PerformanceOverlayOption.visualizeRasterizerStatistics.index,
              isEnabled: _visualizeRasterizer,
              onChanged: (v) => setState(() => _visualizeRasterizer = v),
            ),
            
            const SizedBox(height: 12),
            
            _buildOptionCard(
              title: 'displayEngineStatistics',
              description: 'Shows numeric statistics for the engine/UI thread, including Dart code execution times.',
              color: const Color(0xFFF78166),
              bitValue: PerformanceOverlayOption.displayEngineStatistics.index,
              isEnabled: _displayEngine,
              onChanged: (v) => setState(() => _displayEngine = v),
            ),
            
            const SizedBox(height: 12),
            
            _buildOptionCard(
              title: 'visualizeEngineStatistics',
              description: 'Displays a real-time bar graph of engine/UI frame times, showing Dart execution performance.',
              color: const Color(0xFFD29922),
              bitValue: PerformanceOverlayOption.visualizeEngineStatistics.index,
              isEnabled: _visualizeEngine,
              onChanged: (v) => setState(() => _visualizeEngine = v),
            ),
            
            const SizedBox(height: 24),
            
            // Computed mask display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF21262D),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF30363D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Computed optionsMask',
                    style: TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$_computedMask',
                          style: const TextStyle(
                            color: Color(0xFF00D9FF),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Binary: ${_computedMask.toRadixString(2).padLeft(4, '0')}',
                          style: const TextStyle(
                            color: Color(0xFF8B949E),
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1117),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'PerformanceOverlay(optionsMask: $_computedMask)',
                      style: const TextStyle(
                        color: Color(0xFF79C0FF),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Quick presets
            const Text(
              'Quick Presets',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetChip('None', () {
                  setState(() {
                    _displayRasterizer = false;
                    _visualizeRasterizer = false;
                    _displayEngine = false;
                    _visualizeEngine = false;
                  });
                }),
                _buildPresetChip('All Enabled', () {
                  setState(() {
                    _displayRasterizer = true;
                    _visualizeRasterizer = true;
                    _displayEngine = true;
                    _visualizeEngine = true;
                  });
                }),
                _buildPresetChip('Visualize Only', () {
                  setState(() {
                    _displayRasterizer = false;
                    _visualizeRasterizer = true;
                    _displayEngine = false;
                    _visualizeEngine = true;
                  });
                }),
                _buildPresetChip('Rasterizer Only', () {
                  setState(() {
                    _displayRasterizer = true;
                    _visualizeRasterizer = true;
                    _displayEngine = false;
                    _visualizeEngine = false;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String description,
    required Color color,
    required int bitValue,
    required bool isEnabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isEnabled 
            ? color.withValues(alpha: 0.1) 
            : const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEnabled ? color : const Color(0xFF30363D),
          width: isEnabled ? 2 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isEnabled ? color : const Color(0xFF484F58),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isEnabled ? color : Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF8B949E),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1117),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Bit value: $bitValue (${bitValue.toRadixString(2).padLeft(4, '0')})',
                    style: const TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeThumbColor: color,
            activeTrackColor: color.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF21262D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF30363D)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8B949E),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background content
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A1F35), Color(0xFF0D1117)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated demo content
                    const _AnimatedDemoContent(),
                    
                    const SizedBox(height: 24),
                    
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF21262D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _hasAnyOption ? Icons.visibility : Icons.visibility_off,
                            color: _hasAnyOption 
                                ? const Color(0xFF3FB950) 
                                : const Color(0xFF8B949E),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _hasAnyOption 
                                ? 'Overlay Active (mask: $_computedMask)'
                                : 'Overlay Disabled',
                            style: TextStyle(
                              color: _hasAnyOption 
                                  ? const Color(0xFF3FB950)
                                  : const Color(0xFF8B949E),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Performance overlay positioned at top
            if (_hasAnyOption)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PerformanceOverlay(optionsMask: _computedMask),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ANIMATED DEMO CONTENT (used across scenes)
// ============================================================================

class _AnimatedDemoContent extends StatefulWidget {
  const _AnimatedDemoContent();

  @override
  State<_AnimatedDemoContent> createState() => _AnimatedDemoContentState();
}

class _AnimatedDemoContentState extends State<_AnimatedDemoContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer rotating ring
              Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: List.generate(8, (i) {
                      final angle = (i / 8) * 2 * math.pi;
                      return Positioned(
                        left: 90 + 80 * math.cos(angle) - 8,
                        top: 90 + 80 * math.sin(angle) - 8,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              const Color(0xFF00D9FF),
                              const Color(0xFF00FF88),
                              i / 8,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              
              // Inner counter-rotating ring
              Transform.rotate(
                angle: -_controller.value * 2 * math.pi * 0.5,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00D9FF).withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFF00FF88).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              // Center pulsing dot
              Transform.scale(
                scale: 0.8 + 0.2 * math.sin(_controller.value * 4 * math.pi),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF00D9FF), Color(0xFF00FF88)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================================
// SCENE 2: RENDER PIPELINE LAB
// ============================================================================
//
// This scene demonstrates how PerformanceOverlay relates to Flutter's
// rendering pipeline. It shows UI thread vs Raster thread and has
// animated content to generate real rendering work.

class _RenderPipelineLabScene extends StatefulWidget {
  const _RenderPipelineLabScene({super.key});

  @override
  State<_RenderPipelineLabScene> createState() => _RenderPipelineLabSceneState();
}

class _RenderPipelineLabSceneState extends State<_RenderPipelineLabScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showOverlay = true;
  int _workloadLevel = 1; // 1=light, 2=medium, 3=heavy

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
    print('[PipelineLab] Initialized with workload level: $_workloadLevel');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[PipelineLab] Building with overlay:$_showOverlay workload:$_workloadLevel');
    
    return Row(
      children: [
        // Left: Pipeline explanation
        Expanded(
          flex: 2,
          child: _buildPipelineExplanation(),
        ),
        
        // Right: Live demo area
        Expanded(
          flex: 3,
          child: _buildDemoArea(),
        ),
      ],
    );
  }

  Widget _buildPipelineExplanation() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              children: [
                Icon(Icons.memory, color: Color(0xFF00D9FF), size: 24),
                SizedBox(width: 12),
                Text(
                  'Render Pipeline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // UI Thread section
            _buildThreadCard(
              title: 'UI Thread (Engine)',
              subtitle: 'Dart code execution',
              color: const Color(0xFFF78166),
              items: [
                'Executes your Dart code',
                'Builds the widget tree',
                'Performs layout calculations',
                'Handles animations & state',
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Arrow down
            const Center(
              child: Column(
                children: [
                  Icon(Icons.arrow_downward, color: Color(0xFF484F58), size: 20),
                  Text(
                    'Layer tree',
                    style: TextStyle(color: Color(0xFF484F58), fontSize: 11),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Raster Thread section
            _buildThreadCard(
              title: 'Raster Thread (GPU)',
              subtitle: 'Graphics rendering',
              color: const Color(0xFF3FB950),
              items: [
                'Receives layer tree from UI',
                'Rasterizes layers to pixels',
                'Uploads textures to GPU',
                'Composites final image',
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Workload control
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF21262D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rendering Workload',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Increase workload to see the overlay show more frame time',
                    style: TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildWorkloadButton(1, 'Light'),
                      const SizedBox(width: 8),
                      _buildWorkloadButton(2, 'Medium'),
                      const SizedBox(width: 8),
                      _buildWorkloadButton(3, 'Heavy'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Overlay toggle
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF21262D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Performance Overlay',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _showOverlay ? 'Currently visible' : 'Currently hidden',
                          style: const TextStyle(
                            color: Color(0xFF8B949E),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _showOverlay,
                    onChanged: (v) => setState(() => _showOverlay = v),
                    activeThumbColor: const Color(0xFF3FB950),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThreadCard({
    required String title,
    required String subtitle,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF8B949E),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(color: Color(0xFF8B949E), fontSize: 12),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWorkloadButton(int level, String label) {
    final isActive = _workloadLevel == level;
    final color = level == 1 
        ? const Color(0xFF3FB950)
        : level == 2 
            ? const Color(0xFFD29922)
            : const Color(0xFFF85149);
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _workloadLevel = level),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? color.withValues(alpha: 0.2) : const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? color : const Color(0xFF30363D),
              width: isActive ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isActive ? color : const Color(0xFF8B949E),
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                level == 1 ? '~1ms' : level == 2 ? '~5ms' : '~10ms+',
                style: TextStyle(
                  color: isActive ? color.withValues(alpha: 0.8) : const Color(0xFF484F58),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoArea() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background with animated workload
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A1F35), Color(0xFF0D1117)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _buildAnimatedWorkload();
                },
              ),
            ),
            
            // Performance overlay at top
            if (_showOverlay)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PerformanceOverlay.allEnabled(),
              ),
            
            // Workload indicator badge
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF21262D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.speed,
                      color: _workloadLevel == 1 
                          ? const Color(0xFF3FB950)
                          : _workloadLevel == 2 
                              ? const Color(0xFFD29922)
                              : const Color(0xFFF85149),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Workload: ${_workloadLevel == 1 ? 'Light' : _workloadLevel == 2 ? 'Medium' : 'Heavy'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWorkload() {
    final itemCount = _workloadLevel == 1 ? 12 : _workloadLevel == 2 ? 30 : 60;
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _workloadLevel == 1 ? 3 : _workloadLevel == 2 ? 5 : 8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final progress = (_controller.value + index / itemCount) % 1.0;
        final hue = (progress * 360) % 360;
        
        return Transform.rotate(
          angle: progress * 2 * math.pi,
          child: Transform.scale(
            scale: 0.7 + 0.3 * math.sin(progress * 2 * math.pi),
            child: Container(
              decoration: BoxDecoration(
                color: HSVColor.fromAHSV(1, hue, 0.7, 0.8).toColor(),
                borderRadius: BorderRadius.circular(_workloadLevel == 3 ? 4 : 8),
                boxShadow: _workloadLevel >= 2
                    ? [
                        BoxShadow(
                          color: HSVColor.fromAHSV(0.4, hue, 0.7, 0.8).toColor(),
                          blurRadius: _workloadLevel == 3 ? 12 : 6,
                          spreadRadius: _workloadLevel == 3 ? 2 : 0,
                        ),
                      ]
                    : null,
              ),
              child: _workloadLevel == 3
                  ? Center(
                      child: Icon(
                        Icons.star,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 16,
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// SCENE 3: FRAME BUDGET DASHBOARD
// ============================================================================
//
// This scene visualizes the concept of frame budgets and demonstrates
// the PerformanceOverlay.allEnabled() convenience constructor.

class _FrameBudgetDashboardScene extends StatefulWidget {
  const _FrameBudgetDashboardScene({super.key});

  @override
  State<_FrameBudgetDashboardScene> createState() => _FrameBudgetDashboardSceneState();
}

class _FrameBudgetDashboardSceneState extends State<_FrameBudgetDashboardScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    print('[FrameBudget] Initialized frame budget dashboard');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[FrameBudget] Building dashboard');
    
    return Row(
      children: [
        // Left: Frame budget education
        Expanded(
          flex: 2,
          child: _buildEducationPanel(),
        ),
        
        // Right: Live demo with allEnabled
        Expanded(
          flex: 3,
          child: _buildLiveDemoPanel(),
        ),
      ],
    );
  }

  Widget _buildEducationPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              children: [
                Icon(Icons.timer, color: Color(0xFFD29922), size: 24),
                SizedBox(width: 12),
                Text(
                  'Frame Budget',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Understanding the 16ms target for smooth 60fps rendering',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 13,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Frame budget visualization
            _buildFrameBudgetVisual(),
            
            const SizedBox(height: 20),
            
            // Color legend
            _buildColorLegend(),
            
            const SizedBox(height: 20),
            
            // The allEnabled constructor
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF21262D),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF30363D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.code, color: Color(0xFF58A6FF), size: 18),
                      SizedBox(width: 8),
                      Text(
                        'PerformanceOverlay.allEnabled()',
                        style: TextStyle(
                          color: Color(0xFF58A6FF),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Convenience constructor that enables all four performance overlay options at once. Equivalent to:',
                    style: TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1117),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'PerformanceOverlay(\n'
                      '  optionsMask: 15, // 0b1111\n'
                      ')',
                      style: TextStyle(
                        color: Color(0xFF79C0FF),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Performance tips
            _buildPerformanceTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildFrameBudgetVisual() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          const Row(
            children: [
              Text(
                '60 FPS Frame Budget',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '16.67ms per frame',
                style: TextStyle(
                  color: Color(0xFFD29922),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Animated budget gauge
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Simulate varying frame times
              final frameTime = 8 + 10 * math.sin(_controller.value * 2 * math.pi).abs();
              final percentage = (frameTime / 16.67).clamp(0.0, 1.5);
              final isOverBudget = percentage > 1.0;
              
              return Column(
                children: [
                  // Time display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        frameTime.toStringAsFixed(2),
                        style: TextStyle(
                          color: isOverBudget 
                              ? const Color(0xFFF85149) 
                              : const Color(0xFF3FB950),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'ms',
                        style: TextStyle(
                          color: Color(0xFF8B949E),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Budget bar
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1117),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Fill
                        FractionallySizedBox(
                          widthFactor: percentage.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isOverBudget 
                                  ? const Color(0xFFF85149)
                                  : const Color(0xFF3FB950),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        // 16ms marker
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Align(
                            alignment: const Alignment(0.33, 0),
                            child: Container(
                              width: 2,
                              color: const Color(0xFFD29922),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Labels
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0ms',
                        style: TextStyle(color: Color(0xFF8B949E), fontSize: 10),
                      ),
                      Text(
                        '16ms budget',
                        style: TextStyle(color: Color(0xFFD29922), fontSize: 10),
                      ),
                      Text(
                        '24ms+',
                        style: TextStyle(color: Color(0xFF8B949E), fontSize: 10),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isOverBudget 
                          ? const Color(0xFFF85149).withValues(alpha: 0.2)
                          : const Color(0xFF3FB950).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isOverBudget 
                          ? 'Frame dropped! Over budget'
                          : 'Frame on time',
                      style: TextStyle(
                        color: isOverBudget 
                            ? const Color(0xFFF85149)
                            : const Color(0xFF3FB950),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorLegend() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overlay Bar Colors',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildLegendItem(
            color: const Color(0xFF3FB950),
            label: 'Green Bar',
            description: 'Frame completed within the 16ms budget. Smooth animation.',
          ),
          const SizedBox(height: 10),
          _buildLegendItem(
            color: const Color(0xFFF85149),
            label: 'Red Bar',
            description: 'Frame exceeded budget. May cause visible jank.',
          ),
          const SizedBox(height: 10),
          _buildLegendItem(
            color: const Color(0xFFD29922),
            label: 'Tall Red Bar',
            description: 'Significantly over budget. Definite frame drop.',
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceTips() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF58A6FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF58A6FF).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF58A6FF), size: 18),
              SizedBox(width: 8),
              Text(
                'Optimization Tips',
                style: TextStyle(
                  color: Color(0xFF58A6FF),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...[
            'Use const constructors where possible',
            'Avoid rebuilding the entire tree',
            'Use RepaintBoundary for isolated repaints',
            'Cache expensive computations',
            'Profile release builds, not debug',
          ].map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: Color(0xFF58A6FF), fontSize: 12)),
                Expanded(
                  child: Text(
                    tip,
                    style: const TextStyle(color: Color(0xFF8B949E), fontSize: 12),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildLiveDemoPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Animated background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A2332), Color(0xFF0D1117)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: _buildAnimatedDemo(),
              ),
            ),
            
            // Performance overlay - allEnabled
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PerformanceOverlay.allEnabled(),
            ),
            
            // Badge
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF21262D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF3FB950), size: 16),
                    SizedBox(width: 8),
                    Text(
                      'PerformanceOverlay.allEnabled()',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedDemo() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated circular progress gauge
            SizedBox(
              width: 180,
              height: 180,
              child: CustomPaint(
                painter: _CircularGaugePainter(
                  progress: _controller.value,
                  strokeWidth: 12,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(_controller.value * 60).toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'FPS',
                        style: TextStyle(
                          color: Color(0xFF8B949E),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Frame time bars simulation
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(20, (i) {
                  final barProgress = (_controller.value + i / 20) % 1.0;
                  final barHeight = 20 + 35 * math.sin(barProgress * math.pi);
                  final isOverBudget = barHeight > 45;
                  
                  return Container(
                    width: 8,
                    height: barHeight,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isOverBudget 
                          ? const Color(0xFFF85149) 
                          : const Color(0xFF3FB950),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'Simulated frame time histogram',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// CIRCULAR GAUGE PAINTER
// ============================================================================

class _CircularGaugePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _CircularGaugePainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFF30363D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, bgPaint);
    
    // Progress arc with gradient effect
    final sweepAngle = 2 * math.pi * progress;
    
    for (var i = 0.0; i < sweepAngle; i += 0.02) {
      final color = Color.lerp(
        const Color(0xFF00D9FF),
        const Color(0xFF00FF88),
        i / (2 * math.pi),
      )!;
      
      final arcPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + i,
        0.04,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ============================================================================
// SCENE 4: INTEGRATION SHOWCASE
// ============================================================================
//
// This scene demonstrates various integration patterns for PerformanceOverlay
// in different app layouts and contexts.

class _IntegrationShowcaseScene extends StatefulWidget {
  const _IntegrationShowcaseScene({super.key});

  @override
  State<_IntegrationShowcaseScene> createState() => _IntegrationShowcaseSceneState();
}

class _IntegrationShowcaseSceneState extends State<_IntegrationShowcaseScene> {
  int _selectedPattern = 0;

  static const List<String> _patternNames = [
    'Stack Overlay',
    'Positioned Top',
    'Positioned Bottom',
    'Full Screen',
  ];

  @override
  Widget build(BuildContext context) {
    print('[Integration] Building with pattern: ${_patternNames[_selectedPattern]}');
    
    return Row(
      children: [
        // Left: Pattern selector
        Expanded(
          flex: 2,
          child: _buildPatternSelector(),
        ),
        
        // Right: Live preview
        Expanded(
          flex: 3,
          child: _buildPreview(),
        ),
      ],
    );
  }

  Widget _buildPatternSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              children: [
                Icon(Icons.layers, color: Color(0xFF00FF88), size: 24),
                SizedBox(width: 12),
                Text(
                  'Integration Patterns',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Different ways to add PerformanceOverlay to your app',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 13,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Pattern cards
            ...List.generate(_patternNames.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPatternCard(index),
              );
            }),
            
            const SizedBox(height: 16),
            
            // Code snippet for selected pattern
            _buildCodeSnippet(),
            
            const SizedBox(height: 16),
            
            // MaterialApp integration note
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFD29922).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD29922).withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFFD29922), size: 18),
                      SizedBox(width: 8),
                      Text(
                        'MaterialApp Integration',
                        style: TextStyle(
                          color: Color(0xFFD29922),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'MaterialApp and WidgetsApp have a built-in showPerformanceOverlay property:',
                    style: TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1117),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'MaterialApp(\n'
                      '  showPerformanceOverlay: true,\n'
                      '  home: MyHomePage(),\n'
                      ')',
                      style: TextStyle(
                        color: Color(0xFF79C0FF),
                        fontSize: 11,
                        fontFamily: 'monospace',
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

  Widget _buildPatternCard(int index) {
    final isSelected = _selectedPattern == index;
    final patterns = [
      {
        'icon': Icons.layers_outlined,
        'color': const Color(0xFF58A6FF),
        'description': 'Use Stack to position overlay above content',
      },
      {
        'icon': Icons.vertical_align_top,
        'color': const Color(0xFF3FB950),
        'description': 'Pin overlay to top of screen',
      },
      {
        'icon': Icons.vertical_align_bottom,
        'color': const Color(0xFFF78166),
        'description': 'Pin overlay to bottom of screen',
      },
      {
        'icon': Icons.fullscreen,
        'color': const Color(0xFFD29922),
        'description': 'Cover entire screen area',
      },
    ];
    
    final pattern = patterns[index];
    final color = pattern['color'] as Color;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPattern = index),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withValues(alpha: 0.15)
              : const Color(0xFF21262D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF30363D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? color.withValues(alpha: 0.2)
                    : const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                pattern['icon'] as IconData,
                color: isSelected ? color : const Color(0xFF8B949E),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _patternNames[index],
                    style: TextStyle(
                      color: isSelected ? color : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    pattern['description'] as String,
                    style: const TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeSnippet() {
    final snippets = [
      // Stack Overlay
      'Stack(\n'
      '  children: [\n'
      '    MyContent(),\n'
      '    PerformanceOverlay.allEnabled(),\n'
      '  ],\n'
      ')',
      // Positioned Top
      'Stack(\n'
      '  children: [\n'
      '    MyContent(),\n'
      '    Positioned(\n'
      '      top: 0, left: 0, right: 0,\n'
      '      child: PerformanceOverlay.allEnabled(),\n'
      '    ),\n'
      '  ],\n'
      ')',
      // Positioned Bottom
      'Stack(\n'
      '  children: [\n'
      '    MyContent(),\n'
      '    Positioned(\n'
      '      bottom: 0, left: 0, right: 0,\n'
      '      child: PerformanceOverlay.allEnabled(),\n'
      '    ),\n'
      '  ],\n'
      ')',
      // Full Screen
      'Stack(\n'
      '  children: [\n'
      '    MyContent(),\n'
      '    Positioned.fill(\n'
      '      child: PerformanceOverlay.allEnabled(),\n'
      '    ),\n'
      '  ],\n'
      ')',
    ];
    
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.code, color: Color(0xFF8B949E), size: 16),
              SizedBox(width: 8),
              Text(
                'Code Example',
                style: TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1117),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              snippets[_selectedPattern],
              style: const TextStyle(
                color: Color(0xFF79C0FF),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: _buildSelectedPatternPreview(),
      ),
    );
  }

  Widget _buildSelectedPatternPreview() {
    // Content to display
    Widget content = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A2332), Color(0xFF0D1117)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: _AnimatedDemoContent(),
      ),
    );
    
    switch (_selectedPattern) {
      case 0: // Stack Overlay
        return Stack(
          children: [
            content,
            PerformanceOverlay.allEnabled(),
          ],
        );
      
      case 1: // Positioned Top
        return Stack(
          children: [
            content,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PerformanceOverlay.allEnabled(),
            ),
          ],
        );
      
      case 2: // Positioned Bottom
        return Stack(
          children: [
            content,
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PerformanceOverlay.allEnabled(),
            ),
          ],
        );
      
      case 3: // Full Screen
        return Stack(
          children: [
            content,
            Positioned.fill(
              child: PerformanceOverlay.allEnabled(),
            ),
          ],
        );
      
      default:
        return content;
    }
  }
}

// ============================================================================
// SCENE 5: PROFILING PATTERNS
// ============================================================================
//
// This scene demonstrates real-world profiling scenarios and how to 
// interpret the performance overlay in different situations.

class _ProfilingPatternsScene extends StatefulWidget {
  const _ProfilingPatternsScene({super.key});

  @override
  State<_ProfilingPatternsScene> createState() => _ProfilingPatternsSceneState();
}

class _ProfilingPatternsSceneState extends State<_ProfilingPatternsScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedScenario = 0;
  bool _isRunning = false;

  static const List<Map<String, dynamic>> _scenarios = [
    {
      'name': 'Smooth Scrolling',
      'icon': Icons.swap_vert,
      'color': Color(0xFF3FB950),
      'description': 'ListView with efficient items - bars should stay green',
      'complexity': 1,
    },
    {
      'name': 'Heavy Computation',
      'icon': Icons.calculate,
      'color': Color(0xFFD29922),
      'description': 'Expensive synchronous work - watch for red spikes',
      'complexity': 2,
    },
    {
      'name': 'Animation Stress',
      'icon': Icons.animation,
      'color': Color(0xFFF78166),
      'description': 'Many animated elements - tests GPU rasterizer',
      'complexity': 3,
    },
    {
      'name': 'Widget Rebuild Storm',
      'icon': Icons.refresh,
      'color': Color(0xFFF85149),
      'description': 'Frequent setState calls - UI thread stress test',
      'complexity': 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    print('[Profiling] Initialized profiling patterns scene');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[Profiling] Building with scenario: ${_scenarios[_selectedScenario]['name']}');
    
    return Row(
      children: [
        // Left: Scenario selector
        Expanded(
          flex: 2,
          child: _buildScenarioPanel(),
        ),
        
        // Right: Live demo
        Expanded(
          flex: 3,
          child: _buildDemoPanel(),
        ),
      ],
    );
  }

  Widget _buildScenarioPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              children: [
                Icon(Icons.analytics, color: Color(0xFFF78166), size: 24),
                SizedBox(width: 12),
                Text(
                  'Profiling Scenarios',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Test different workloads and observe the performance overlay',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 13,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Scenario cards
            ...List.generate(_scenarios.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildScenarioCard(index),
              );
            }),
            
            const SizedBox(height: 16),
            
            // Start/Stop button
            GestureDetector(
              onTap: () => setState(() => _isRunning = !_isRunning),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _isRunning 
                      ? const Color(0xFFF85149).withValues(alpha: 0.2)
                      : const Color(0xFF3FB950).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isRunning 
                        ? const Color(0xFFF85149)
                        : const Color(0xFF3FB950),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isRunning ? Icons.stop : Icons.play_arrow,
                      color: _isRunning 
                          ? const Color(0xFFF85149)
                          : const Color(0xFF3FB950),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isRunning ? 'Stop Scenario' : 'Run Scenario',
                      style: TextStyle(
                        color: _isRunning 
                            ? const Color(0xFFF85149)
                            : const Color(0xFF3FB950),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Interpreting the overlay
            _buildInterpretationGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(int index) {
    final scenario = _scenarios[index];
    final isSelected = _selectedScenario == index;
    final color = scenario['color'] as Color;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedScenario = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withValues(alpha: 0.15)
              : const Color(0xFF21262D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF30363D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                scenario['icon'] as IconData,
                color: color,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        scenario['name'] as String,
                        style: TextStyle(
                          color: isSelected ? color : Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      // Complexity indicator
                      Row(
                        children: List.generate(4, (i) {
                          return Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(left: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i < (scenario['complexity'] as int)
                                  ? color
                                  : const Color(0xFF30363D),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scenario['description'] as String,
                    style: const TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 11,
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

  Widget _buildInterpretationGuide() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reading the Overlay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildGuideRow(
            'Consistent green',
            'Excellent performance',
            const Color(0xFF3FB950),
          ),
          const SizedBox(height: 8),
          _buildGuideRow(
            'Occasional red',
            'Minor hitches, acceptable',
            const Color(0xFFD29922),
          ),
          const SizedBox(height: 8),
          _buildGuideRow(
            'Frequent red',
            'Performance issue, needs attention',
            const Color(0xFFF78166),
          ),
          const SizedBox(height: 8),
          _buildGuideRow(
            'Mostly red spikes',
            'Severe jank, optimize immediately',
            const Color(0xFFF85149),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideRow(String pattern, String meaning, Color color) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pattern,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                meaning,
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDemoPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Scenario content
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A2332), Color(0xFF0D1117)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: _isRunning 
                  ? _buildScenarioContent()
                  : _buildIdleContent(),
            ),
            
            // Performance overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PerformanceOverlay.allEnabled(),
            ),
            
            // Status badge
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF21262D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isRunning 
                            ? const Color(0xFF3FB950)
                            : const Color(0xFF8B949E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isRunning 
                          ? 'Running: ${_scenarios[_selectedScenario]['name']}'
                          : 'Idle - Press play to start',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdleContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            color: Color(0xFF8B949E),
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Select a scenario and press play',
            style: TextStyle(
              color: Color(0xFF8B949E),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Watch the performance overlay react',
            style: TextStyle(
              color: Color(0xFF484F58),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioContent() {
    switch (_selectedScenario) {
      case 0:
        return _buildSmoothScrolling();
      case 1:
        return _buildHeavyComputation();
      case 2:
        return _buildAnimationStress();
      case 3:
        return _buildWidgetRebuildStorm();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSmoothScrolling() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 80, bottom: 16, left: 16, right: 16),
      itemCount: 100,
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF21262D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                decoration: BoxDecoration(
                  color: Color.lerp(
                    const Color(0xFF00D9FF),
                    const Color(0xFF00FF88),
                    index / 100,
                  )?.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'List Item $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Smooth scrolling test',
                      style: TextStyle(
                        color: Color(0xFF8B949E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeavyComputation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Simulate heavy computation
        double result = 0;
        for (var i = 0; i < 50000; i++) {
          result += math.sin(i * _controller.value) * math.cos(i);
        }
        
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calculate,
                color: Color(0xFFD29922),
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Heavy Computation Running',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Result: ${result.toStringAsFixed(4)}',
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '50,000 sin/cos calculations per frame',
                style: TextStyle(
                  color: Color(0xFFD29922),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimationStress() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(40, (index) {
            final angle = (index / 40) * 2 * math.pi + _controller.value * 4 * math.pi;
            final radius = 80 + 60 * math.sin(_controller.value * 2 * math.pi + index);
            final centerX = 150.0;
            final centerY = 200.0;
            
            return Positioned(
              left: centerX + radius * math.cos(angle) - 15,
              top: centerY + radius * math.sin(angle) - 15,
              child: Transform.rotate(
                angle: angle * 2,
                child: Transform.scale(
                  scale: 0.5 + 0.5 * math.sin(_controller.value * 4 * math.pi + index),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: HSVColor.fromAHSV(
                        0.8,
                        (index / 40 * 360 + _controller.value * 360) % 360,
                        0.8,
                        0.9,
                      ).toColor(),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: HSVColor.fromAHSV(
                            0.4,
                            (index / 40 * 360 + _controller.value * 360) % 360,
                            0.8,
                            0.9,
                          ).toColor(),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildWidgetRebuildStorm() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Force frequent rebuilds with changing keys
        return GridView.builder(
          padding: const EdgeInsets.only(top: 80, bottom: 16, left: 16, right: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 50,
          itemBuilder: (context, index) {
            // Force new widget keys to trigger rebuilds
            return Container(
              key: ValueKey('${index}_${(_controller.value * 1000).toInt()}'),
              decoration: BoxDecoration(
                color: Color.lerp(
                  const Color(0xFFF85149),
                  const Color(0xFFD29922),
                  _controller.value,
                )?.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFF85149).withValues(alpha: 0.5),
                ),
              ),
              child: Center(
                child: Text(
                  '${(_controller.value * 100).toInt()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ============================================================================
// END OF DEEP VISUAL DEMONSTRATION
// ============================================================================
//
// This demo covers:
// 1. All four PerformanceOverlayOption flags
// 2. The optionsMask bitmask system
// 3. PerformanceOverlay.allEnabled() convenience constructor
// 4. UI thread vs Raster thread concepts
// 5. The 16ms frame budget for 60fps
// 6. Green/red bar interpretation
// 7. Multiple integration patterns (Stack, Positioned, MaterialApp)
// 8. Real-world profiling scenarios
//
// ============================================================================
