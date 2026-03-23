// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for TileMode from dart:ui
//
// TileMode defines how a shader or gradient tiles beyond its bounds.
// Four values exist:
//   - TileMode.clamp — extends the edge color beyond bounds
//   - TileMode.repeated — repeats the shader/gradient pattern
//   - TileMode.mirror — mirrors/reflects the pattern at each boundary
//   - TileMode.decal — renders transparent beyond bounds
//
// This demo visually demonstrates each tile mode using gradient decorations
// in Containers to simulate the different tiling behaviors.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TileMode Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: ENUM VALUES OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TileMode Enum Values ---');
  final allModes = TileMode.values;
  print('TileMode.values: $allModes');
  print('Count: ${allModes.length}');

  for (final mode in allModes) {
    print('  ${mode.name}: index=${mode.index}, toString=${mode.toString()}');
  }

  // Descriptions for each mode
  final modeDescriptions = <TileMode, String>{
    TileMode.clamp: 'Edge color extends beyond bounds',
    TileMode.repeated: 'Pattern repeats seamlessly',
    TileMode.mirror: 'Pattern reflects at boundaries',
    TileMode.decal: 'Transparent beyond bounds',
  };

  // Colors for visualization
  final modeColors = <TileMode, Color>{
    TileMode.clamp: const Color(0xFF1565C0),
    TileMode.repeated: const Color(0xFF2E7D32),
    TileMode.mirror: const Color(0xFF6A1B9A),
    TileMode.decal: const Color(0xFFC62828),
  };

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CLAMP MODE DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TileMode.clamp Section ---');

  Widget buildClampDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TileMode.clamp — Edge Color Extension',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'The edge color of the gradient extends to fill remaining space.',
        ),
        const SizedBox(height: 12),
        // Linear gradient with clamp behavior
        Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              begin: Alignment.centerLeft,
              end: Alignment(0.3, 0), // Gradient ends early, edge extends
              tileMode: TileMode.clamp,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Linear Clamp', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8),
        // Vertical gradient clamped
        Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF64B5F6)],
              begin: Alignment.topCenter,
              end: Alignment(0, -0.2),
              tileMode: TileMode.clamp,
            ),
          ),
          child: const Center(
            child: Text(
              'Vertical Clamp',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Radial gradient showing clamp
        Container(
          width: 200,
          height: 100,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
              center: Alignment(-0.5, 0),
              radius: 0.5,
              tileMode: TileMode.clamp,
            ),
          ),
          child: const Center(
            child: Text('Radial Clamp', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE3F2FD),
          child: const Text(
            'Use case: Smooth color transitions that fade to solid edge colors',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: REPEATED MODE DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TileMode.repeated Section ---');

  Widget buildRepeatedDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TileMode.repeated — Seamless Pattern Repetition',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('The gradient pattern repeats to fill the space.'),
        const SizedBox(height: 12),
        // Repeated linear gradient
        Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF81C784), Color(0xFF2E7D32)],
              begin: Alignment.centerLeft,
              end: Alignment(-0.6, 0),
              tileMode: TileMode.repeated,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Linear Repeated',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Simulated stripe pattern (using multiple gradients)
        Container(
          width: double.infinity,
          height: 60,
          child: Row(
            children: List.generate(8, (i) {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: i.isEven
                          ? [const Color(0xFF388E3C), const Color(0xFF66BB6A)]
                          : [const Color(0xFF66BB6A), const Color(0xFF388E3C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Simulated repeating pattern',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 12),
        // Checkerboard-like pattern simulation
        Container(
          width: 200,
          height: 80,
          child: CustomPaint(
            painter: _CheckerboardPainter(
              const Color(0xFF2E7D32),
              const Color(0xFFA5D6A7),
            ),
            size: const Size(200, 80),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Checkerboard simulation',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE8F5E9),
          child: const Text(
            'Use case: Wallpapers, textures, seamless backgrounds',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: MIRROR MODE DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TileMode.mirror Section ---');

  Widget buildMirrorDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TileMode.mirror — Reflected Pattern',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('The pattern mirrors/reflects at each boundary.'),
        const SizedBox(height: 12),
        // Mirror gradient horizontal
        Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A1B9A), Color(0xFFBA68C8)],
              begin: Alignment.centerLeft,
              end: Alignment(-0.5, 0),
              tileMode: TileMode.mirror,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Mirror Horizontal',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Mirrored wave simulation
        Container(
          width: double.infinity,
          height: 60,
          child: Row(
            children: List.generate(6, (i) {
              final isForward = i % 2 == 0;
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isForward
                          ? [const Color(0xFF7B1FA2), const Color(0xFFCE93D8)]
                          : [const Color(0xFFCE93D8), const Color(0xFF7B1FA2)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Simulated mirror wave effect',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 12),
        // Radial mirror effect
        Container(
          width: 200,
          height: 100,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFFBA68C8), Color(0xFF6A1B9A), Color(0xFFBA68C8)],
              center: Alignment.center,
              radius: 0.3,
              tileMode: TileMode.mirror,
            ),
          ),
          child: const Center(
            child: Text('Radial Mirror', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFF3E5F5),
          child: const Text(
            'Use case: Symmetric patterns, wave effects, reflective surfaces',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DECAL MODE DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TileMode.decal Section ---');

  Widget buildDecalDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TileMode.decal — Transparent Beyond Bounds',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Content outside gradient bounds becomes transparent.'),
        const SizedBox(height: 12),
        // Decal gradient on patterned background
        Stack(
          children: [
            // Background pattern to show transparency
            Container(
              width: double.infinity,
              height: 80,
              child: CustomPaint(painter: _GridPainter(Colors.grey.shade300)),
            ),
            // Decal gradient overlay
            Container(
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC62828), Color(0xFFEF5350)],
                  begin: Alignment(-0.3, 0),
                  end: Alignment(0.3, 0),
                  tileMode: TileMode.decal,
                ),
              ),
              child: const Center(
                child: Text(
                  'Decal Linear',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Radial decal
        Stack(
          children: [
            Container(
              width: 200,
              height: 100,
              child: CustomPaint(painter: _GridPainter(Colors.grey.shade300)),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFFD32F2F), Color(0xFFEF9A9A)],
                  center: Alignment.center,
                  radius: 0.4,
                  tileMode: TileMode.decal,
                ),
              ),
              child: const Center(
                child: Text(
                  'Radial Decal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFFFEBEE),
          child: const Text(
            'Use case: Spotlight effects, vignettes, isolated gradient regions',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SIDE-BY-SIDE COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Side-by-Side Comparison ---');

  Widget buildComparisonGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Side-by-Side TileMode Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                        begin: Alignment.centerLeft,
                        end: Alignment(-0.3, 0),
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Clamp',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2E7D32),
                          Color(0xFF81C784),
                          Color(0xFF2E7D32),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment(-0.5, 0),
                        tileMode: TileMode.repeated,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Repeated',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6A1B9A), Color(0xFFBA68C8)],
                        begin: Alignment.centerLeft,
                        end: Alignment(-0.3, 0),
                        tileMode: TileMode.mirror,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mirror',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 80,
                        child: CustomPaint(
                          painter: _GridPainter(Colors.grey.shade300),
                        ),
                      ),
                      Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFC62828), Color(0xFFEF5350)],
                            begin: Alignment(-0.2, 0),
                            end: Alignment(0.2, 0),
                            tileMode: TileMode.decal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Decal',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: LINEAR VS RADIAL GRADIENT TILING
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Linear vs Radial Tiling ---');

  Widget buildGradientTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Linear vs Radial Gradient Tiling',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // Headers
        Row(
          children: [
            const SizedBox(width: 60),
            const Expanded(
              child: Center(
                child: Text(
                  'Linear',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Radial',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Clamp row
        Row(
          children: [
            const SizedBox(width: 60, child: Text('Clamp')),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF90CAF9)],
                    begin: Alignment.centerLeft,
                    end: Alignment(-0.2, 0),
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF90CAF9)],
                    radius: 0.4,
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Repeated row
        Row(
          children: [
            const SizedBox(width: 60, child: Text('Repeated')),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2E7D32),
                      Color(0xFFA5D6A7),
                      Color(0xFF2E7D32),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment(-0.5, 0),
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFF2E7D32),
                      Color(0xFFA5D6A7),
                      Color(0xFF2E7D32),
                    ],
                    radius: 0.25,
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Mirror row
        Row(
          children: [
            const SizedBox(width: 60, child: Text('Mirror')),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFFE1BEE7)],
                    begin: Alignment.centerLeft,
                    end: Alignment(-0.3, 0),
                    tileMode: TileMode.mirror,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFFE1BEE7)],
                    radius: 0.3,
                    tileMode: TileMode.mirror,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: SWEEP GRADIENT TILING
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Sweep Gradient Tiling ---');

  Widget buildSweepSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sweep Gradient with TileMode',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: SweepGradient(
                        colors: [
                          Color(0xFF1565C0),
                          Color(0xFF42A5F5),
                          Color(0xFF1565C0),
                        ],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Clamp', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: SweepGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF81C784)],
                        startAngle: 0.0,
                        endAngle: 3.14 / 2,
                        tileMode: TileMode.repeated,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Repeated', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: SweepGradient(
                        colors: [Color(0xFF6A1B9A), Color(0xFFCE93D8)],
                        startAngle: 0.0,
                        endAngle: 3.14 / 3,
                        tileMode: TileMode.mirror,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Mirror', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ENUM OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Enum Operations ---');

  final mode1 = TileMode.clamp;
  final mode2 = TileMode.clamp;
  final mode3 = TileMode.repeated;

  print('mode1 == mode2: ${mode1 == mode2}');
  print('identical(mode1, mode2): ${identical(mode1, mode2)}');
  print('mode1 == mode3: ${mode1 == mode3}');
  print('mode1.hashCode: ${mode1.hashCode}');

  Widget buildEnumOpsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enum Operations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('clamp == clamp: ${mode1 == mode2}'),
              Text('identical(clamp, clamp): ${identical(mode1, mode2)}'),
              Text('clamp == repeated: ${mode1 == mode3}'),
              const SizedBox(height: 8),
              Text('clamp.index: ${TileMode.clamp.index}'),
              Text('repeated.index: ${TileMode.repeated.index}'),
              Text('mirror.index: ${TileMode.mirror.index}'),
              Text('decal.index: ${TileMode.decal.index}'),
              const SizedBox(height: 8),
              Text('clamp.hashCode: ${mode1.hashCode}'),
              Text('repeated.hashCode: ${mode3.hashCode}'),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: PRACTICAL APPLICATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Applications ---');

  Widget buildPracticalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practical Applications',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // App bar gradient (clamp)
        const Text(
          'App Header (clamp):',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 56,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Background pattern (repeated)
        const Text(
          'Background Pattern (repeated):',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 80,
          child: CustomPaint(
            painter: _StripePainter(
              const Color(0xFFE8F5E9),
              const Color(0xFFC8E6C9),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Reflection effect (mirror)
        const Text(
          'Water Reflection (mirror):',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              color: const Color(0xFF6A1B9A),
              child: const Center(
                child: Text('Sky', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Text(
                  'Reflection',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Spotlight (decal)
        const Text(
          'Spotlight Effect (decal):',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: const Color(0xFF212121),
            ),
            Container(
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0x80FFEB3B), Colors.transparent],
                  center: Alignment(-0.3, 0),
                  radius: 0.5,
                  tileMode: TileMode.decal,
                ),
              ),
              child: const Center(
                child: Text('Spotlight', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER CLASSES FOR CUSTOM PAINTING
  // ═══════════════════════════════════════════════════════════════════════════

  // Note: In D4rt scripts, classes are not allowed at the top level.
  // These painters are defined inline using closures/functions.

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD VISUAL OUTPUT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building Visual Output ---');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Text(
          'TileMode Deep Demo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Demonstrates how shaders and gradients tile beyond their bounds.',
        ),
        const SizedBox(height: 16),

        // Enum overview card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TileMode Values',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ...allModes.map((mode) {
                  final color = modeColors[mode] ?? Colors.grey;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color.withValues(alpha: 0.3), color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          mode.name,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            modeDescriptions[mode] ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Clamp section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildClampDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Repeated section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildRepeatedDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Mirror section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildMirrorDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Decal section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildDecalDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Comparison grid
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildComparisonGrid(),
          ),
        ),
        const SizedBox(height: 16),

        // Linear vs Radial
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildGradientTypeSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Sweep gradient
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildSweepSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Enum operations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildEnumOpsSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Practical applications
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildPracticalSection(),
          ),
        ),
        const SizedBox(height: 32),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• TileMode.clamp: Edge color extends to fill space'),
              Text('• TileMode.repeated: Pattern tiles seamlessly'),
              Text('• TileMode.mirror: Pattern reflects at boundaries'),
              Text('• TileMode.decal: Transparent beyond gradient bounds'),
              SizedBox(height: 8),
              Text('Used with LinearGradient, RadialGradient, SweepGradient.'),
              Text('Also applies to ImageShader and other shader types.'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER PAINTERS (defined as classes outside build due to D4rt constraints)
// Note: In pure D4rt, we use inline widget building. These simulate patterns.
// ═══════════════════════════════════════════════════════════════════════════

/// Draws a checkerboard pattern
class _CheckerboardPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  _CheckerboardPainter(this.color1, this.color2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color1;
    final paint2 = Paint()..color = color2;
    const cellSize = 20.0;

    for (var y = 0.0; y < size.height; y += cellSize) {
      for (var x = 0.0; x < size.width; x += cellSize) {
        final isEven = ((x ~/ cellSize) + (y ~/ cellSize)) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          isEven ? paint1 : paint2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws a grid pattern
class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;
    const spacing = 10.0;

    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws diagonal stripes
class _StripePainter extends CustomPainter {
  final Color color1;
  final Color color2;

  _StripePainter(this.color1, this.color2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color1;
    final paint2 = Paint()..color = color2;
    const stripeWidth = 20.0;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint1);

    final stripeCount = (size.width + size.height) ~/ stripeWidth + 1;
    for (var i = 0; i < stripeCount; i += 2) {
      final path = Path();
      final startX = i * stripeWidth - size.height;
      path.moveTo(startX, 0);
      path.lineTo(startX + stripeWidth, 0);
      path.lineTo(startX + stripeWidth + size.height, size.height);
      path.lineTo(startX + size.height, size.height);
      path.close();
      canvas.drawPath(path, paint2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
