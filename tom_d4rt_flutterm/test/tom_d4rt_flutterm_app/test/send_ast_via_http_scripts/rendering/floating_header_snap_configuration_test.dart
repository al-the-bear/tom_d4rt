// D4rt test script: Comprehensive demo for FloatingHeaderSnapConfiguration
//
// FloatingHeaderSnapConfiguration controls the snapping behavior of floating
// SliverPersistentHeader widgets. When a user scrolls and releases, the
// floating header can snap fully open or fully closed based on this config.
//
// Key properties:
//   - vsync: TickerProvider that drives the snap animation
//   - curve: The animation curve used for the snap transition
//   - duration: How long the snap animation takes
//
// This demo shows:
//   1. What FloatingHeaderSnapConfiguration is and its role in slivers
//   2. Configuration properties and their effects
//   3. Snap behavior visualization (collapsed ↔ expanded)
//   4. Curve types and their visual impact on snapping
//   5. Duration impact on animation speed
//   6. SliverAppBar integration patterns
//   7. Best practices for production use
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Warm Orange/Amber palette
// ═══════════════════════════════════════════════════════════════════════════

const _kAmber50 = Color(0xFFFFF8E1);
const _kAmber100 = Color(0xFFFFECB3);
const _kAmber200 = Color(0xFFFFE082);
const _kAmber300 = Color(0xFFFFD54F);
const _kAmber400 = Color(0xFFFFCA28);
const _kAmber500 = Color(0xFFFFC107);
const _kAmber600 = Color(0xFFFFB300);
const _kAmber700 = Color(0xFFFFA000);
const _kAmber800 = Color(0xFFFF8F00);
const _kAmber900 = Color(0xFFFF6F00);
const _kDeepOrange = Color(0xFFE65100);
const _kCodeBg = Color(0xFF3E2723);
const _kCodeBorder = Color(0xFF5D4037);
const _kCodeText = Color(0xFFFFE0B2);
const _kCardBg = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a decorated section title with icon and label
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kAmber900, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kDeepOrange,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds an informational card with icon, title, and description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kAmber50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kAmber800, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kDeepOrange,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _kAmber900.withAlpha(200),
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

/// Builds a styled code snippet block with title bar
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCodeBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF4E342E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kAmber300, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kAmber200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kCodeText,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a property row with label, type, and description
Widget _buildPropertyRow(
  String name,
  String type,
  String description, {
  Color? valueColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4, right: 8),
          decoration: BoxDecoration(
            color: _kAmber600,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? _kDeepOrange,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11,
              color: _kAmber700.withAlpha(180),
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: _kAmber900.withAlpha(200)),
          ),
        ),
      ],
    ),
  );
}

/// Builds the header banner for the demo
Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kAmber900, _kAmber700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kAmber900.withAlpha(80),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCardBg.withAlpha(30),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.swipe_up, color: _kCardBg, size: 40),
        ),
        const SizedBox(height: 16),
        const Text(
          'FloatingHeaderSnapConfiguration',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _kCardBg,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Controls snapping behavior for floating persistent headers\n'
          'in sliver scroll views',
          style: TextStyle(
            fontSize: 13,
            color: _kCardBg.withAlpha(220),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeaderChip('rendering.dart'),
            const SizedBox(width: 8),
            _buildHeaderChip('Slivers'),
            const SizedBox(width: 8),
            _buildHeaderChip('Snap'),
          ],
        ),
      ],
    ),
  );
}

/// Builds a small chip for the header area
Widget _buildHeaderChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: _kCardBg.withAlpha(40),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCardBg.withAlpha(60)),
    ),
    child: Text(label, style: const TextStyle(fontSize: 11, color: _kCardBg)),
  );
}

/// Builds the properties card showing constructor parameters
Widget _buildPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
      boxShadow: [
        BoxShadow(
          color: _kAmber300.withAlpha(40),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Constructor Parameters',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'FloatingHeaderSnapConfiguration({vsync, curve, duration})',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: _kAmber800.withAlpha(180),
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow(
          'vsync',
          'TickerProvider',
          'Provides the Ticker for the snap animation. '
              'Typically comes from TickerProviderStateMixin.',
        ),
        const Divider(color: _kAmber100, height: 16),
        _buildPropertyRow(
          'curve',
          'Curve',
          'The animation curve controlling snap easing. '
              'Defaults to Curves.ease.',
        ),
        const Divider(color: _kAmber100, height: 16),
        _buildPropertyRow(
          'duration',
          'Duration',
          'Total time for the snap animation. '
              'Defaults to const Duration(milliseconds: 300).',
        ),
      ],
    ),
  );
}

/// Builds a visual snap state card (collapsed or expanded)
Widget _buildSnapStateCard({
  required String label,
  required double heightFraction,
  required String description,
  required IconData icon,
  required bool isExpanded,
}) {
  final barHeight = 20.0 + (heightFraction * 80.0);
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded ? _kAmber500 : _kAmber200,
          width: isExpanded ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: _kAmber800, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: _kDeepOrange,
            ),
          ),
          const SizedBox(height: 8),
          // Visual bar representing header height
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _kAmber100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: barHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kAmber600, _kAmber400],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${(heightFraction * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _kCardBg,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100 - barHeight,
                  decoration: BoxDecoration(
                    color: _kAmber50,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'content',
                      style: TextStyle(
                        fontSize: 10,
                        color: _kAmber300.withAlpha(180),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: _kAmber800.withAlpha(180),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

/// Builds the snap behavior visualization showing before/after states
Widget _buildSnapBehaviorVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kAmber50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Snap Behavior: Header snaps to nearest full state',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSnapStateCard(
              label: 'Collapsed',
              heightFraction: 0.0,
              description: 'Header fully hidden\nafter scroll down',
              icon: Icons.unfold_less,
              isExpanded: false,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.compare_arrows, color: _kAmber600, size: 24),
            ),
            _buildSnapStateCard(
              label: 'Mid-scroll',
              heightFraction: 0.45,
              description: 'User releases finger\nsnap decides direction',
              icon: Icons.swap_vert,
              isExpanded: false,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, color: _kAmber600, size: 24),
            ),
            _buildSnapStateCard(
              label: 'Expanded',
              heightFraction: 1.0,
              description: 'Header fully visible\nafter snap open',
              icon: Icons.unfold_more,
              isExpanded: true,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: _kAmber800, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'When the user stops scrolling, the floating header checks its '
                  'current extent. If > 50% visible, it snaps open; otherwise '
                  'it snaps closed. The snap animation uses the configured curve '
                  'and duration.',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kAmber900.withAlpha(200),
                    height: 1.4,
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

/// Builds a single curve demo tile showing the curve's visual shape
Widget _buildCurveTile(String name, String description, List<double> points) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAmber200),
    ),
    child: Row(
      children: [
        // Visual curve representation
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: _kAmber50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: CustomPaint(painter: _CurvePreviewPainter(points)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kDeepOrange,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: _kAmber800.withAlpha(190),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds the curve comparison section
Widget _buildCurveComparisonSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kAmber50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Curve Types & Their Snap Feel',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 12),
        _buildCurveTile(
          'Curves.ease',
          'Default. Smooth start and end — feels natural and polished.',
          [0.0, 0.25, 0.50, 0.75, 0.87, 0.95, 0.99, 1.0],
        ),
        _buildCurveTile(
          'Curves.easeOut',
          'Fast start, slow end — header decelerates gently into place.',
          [0.0, 0.50, 0.72, 0.85, 0.92, 0.96, 0.99, 1.0],
        ),
        _buildCurveTile(
          'Curves.easeInOut',
          'Gentle start and end — smooth, symmetrical transition.',
          [0.0, 0.08, 0.25, 0.50, 0.75, 0.92, 0.98, 1.0],
        ),
        _buildCurveTile(
          'Curves.bounceOut',
          'Playful bounce at the end — header overshoots then settles.',
          [0.0, 0.55, 0.85, 1.0, 0.92, 1.0, 0.97, 1.0],
        ),
        _buildCurveTile(
          'Curves.elasticOut',
          'Springy overshoot — dramatic, good for attention-grabbing headers.',
          [0.0, 0.65, 1.1, 0.95, 1.02, 0.99, 1.0, 1.0],
        ),
        _buildCurveTile(
          'Curves.linear',
          'Constant speed — mechanical feel, rarely ideal for UI snapping.',
          [0.0, 0.14, 0.28, 0.43, 0.57, 0.71, 0.86, 1.0],
        ),
      ],
    ),
  );
}

/// Builds a duration comparison bar
Widget _buildDurationBar(String label, int ms, double relativeWidth) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 55,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _kDeepOrange,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: _kAmber100,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FractionallySizedBox(
                widthFactor: relativeWidth,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [_kAmber600, _kAmber400]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${ms}ms',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _kCardBg,
                      ),
                    ),
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

/// Builds the duration impact visualization
Widget _buildDurationVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Duration Impact on Snap Speed',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Shorter = snappier feel  •  Longer = smoother feel',
          style: TextStyle(fontSize: 11, color: _kAmber700.withAlpha(180)),
        ),
        const SizedBox(height: 12),
        _buildDurationBar('100ms', 100, 0.15),
        _buildDurationBar('200ms', 200, 0.30),
        _buildDurationBar('300ms', 300, 0.45),
        _buildDurationBar('500ms', 500, 0.70),
        _buildDurationBar('800ms', 800, 1.0),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAmber50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.recommend, color: _kAmber800, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Recommended: 200–400ms. The default 300ms strikes a good '
                  'balance for most use cases. Values below 150ms feel abrupt; '
                  'above 600ms feel sluggish.',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kAmber900.withAlpha(200),
                    height: 1.3,
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

/// Builds the SliverAppBar integration flow diagram
Widget _buildSliverAppBarIntegration() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kAmber50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SliverAppBar + Snap Integration',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'FloatingHeaderSnapConfiguration is used internally by '
          'SliverAppBar when floating: true and snap: true are set. '
          'SliverAppBar creates the configuration automatically.',
          style: TextStyle(
            fontSize: 12,
            color: _kAmber900.withAlpha(200),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        // Flow diagram
        _buildFlowStep('1', 'SliverAppBar', 'floating: true, snap: true'),
        _buildFlowArrow(),
        _buildFlowStep('2', 'SliverPersistentHeader', 'creates delegate'),
        _buildFlowArrow(),
        _buildFlowStep(
          '3',
          'FloatingHeaderSnapConfiguration',
          'vsync + curve + duration',
        ),
        _buildFlowArrow(),
        _buildFlowStep('4', 'Snap Animation', 'animate to 0% or 100%'),
      ],
    ),
  );
}

/// Builds a numbered flow step box
Widget _buildFlowStep(String number, String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAmber300),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kAmber600,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _kCardBg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kDeepOrange,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: _kAmber800.withAlpha(180),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a downward arrow between flow steps
Widget _buildFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Center(
      child: Icon(Icons.arrow_downward, color: _kAmber400, size: 20),
    ),
  );
}

/// Builds a best practice tip card
Widget _buildBestPracticeTip(
  String title,
  String description,
  IconData icon,
  bool doThis,
) {
  final color = doThis ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
  final bgColor = doThis ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
  final borderColor = doThis
      ? const Color(0xFFA5D6A7)
      : const Color(0xFFEF9A9A);
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: borderColor),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: color.withAlpha(200),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds the best practices section
Widget _buildBestPracticesSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Best Practices',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 12),
        _buildBestPracticeTip(
          'Use TickerProviderStateMixin',
          'Always use TickerProviderStateMixin or '
              'SingleTickerProviderStateMixin on the State class that '
              'provides vsync.',
          Icons.check_circle,
          true,
        ),
        _buildBestPracticeTip(
          'Prefer easeOut curves',
          'Curves.easeOut gives the most natural deceleration feel when '
              'a header snaps into place.',
          Icons.check_circle,
          true,
        ),
        _buildBestPracticeTip(
          'Keep duration between 200–400ms',
          'This range feels responsive without being jarring. '
              'Match your app\'s overall animation timing.',
          Icons.check_circle,
          true,
        ),
        _buildBestPracticeTip(
          'Avoid very long durations',
          'Durations above 600ms make the header feel sluggish and '
              'unresponsive to user interaction.',
          Icons.cancel,
          false,
        ),
        _buildBestPracticeTip(
          'Don\'t mix snap with pinned without floating',
          'snap: true requires floating: true on SliverAppBar. '
              'Setting snap without floating throws an assertion error.',
          Icons.cancel,
          false,
        ),
        _buildBestPracticeTip(
          'Don\'t ignore vsync lifecycle',
          'If the TickerProvider is disposed while a snap is animating, '
              'it causes errors. Ensure proper lifecycle management.',
          Icons.cancel,
          false,
        ),
      ],
    ),
  );
}

/// Builds a real-world use case card
Widget _buildUseCaseCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAmber200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kAmber800, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kDeepOrange,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: _kAmber900.withAlpha(200),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds the real-world use cases section
Widget _buildUseCasesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildUseCaseCard(
        'Social Media Feed',
        'A search bar that snaps open when the user scrolls up slightly. '
            'Uses easeOut with 250ms for a quick, responsive feel.',
        Icons.feed,
      ),
      _buildUseCaseCard(
        'E-Commerce Product Listing',
        'Filter bar that snaps into view on upward scroll. '
            'Uses easeInOut with 300ms for smooth reveal over product grid.',
        Icons.shopping_bag,
      ),
      _buildUseCaseCard(
        'News Reader App',
        'Navigation toolbar with category chips. Snaps with bounceOut '
            'at 350ms for a playful, engaging interaction.',
        Icons.newspaper,
      ),
      _buildUseCaseCard(
        'Music Player Queue',
        'Now-playing mini bar that snaps open on scroll-up. '
            'Uses elasticOut at 400ms for a springy, premium feel.',
        Icons.music_note,
      ),
    ],
  );
}

/// Builds the summary footer section
Widget _buildSummaryCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kAmber100, _kAmber50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber300),
    ),
    child: Column(
      children: [
        const Icon(Icons.summarize, color: _kAmber900, size: 32),
        const SizedBox(height: 12),
        const Text(
          'Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'FloatingHeaderSnapConfiguration provides fine-grained control '
          'over how floating persistent headers animate to their open or '
          'closed state after scrolling. By configuring vsync, curve, and '
          'duration, you shape the tactile feel of your scroll experience.',
          style: TextStyle(
            fontSize: 12,
            color: _kAmber900.withAlpha(210),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSummaryChip('vsync', Icons.timer),
            const SizedBox(width: 8),
            _buildSummaryChip('curve', Icons.show_chart),
            const SizedBox(width: 8),
            _buildSummaryChip('duration', Icons.hourglass_bottom),
          ],
        ),
      ],
    ),
  );
}

/// Small summary tag chip
Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kAmber200,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _kAmber900, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _kDeepOrange,
          ),
        ),
      ],
    ),
  );
}

/// Builds a test result badge
Widget _buildResultBadge(bool passed, String label) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: passed ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: passed ? const Color(0xFFA5D6A7) : const Color(0xFFEF9A9A),
      ),
    ),
    child: Row(
      children: [
        Icon(
          passed ? Icons.check_circle : Icons.error,
          color: passed ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
          size: 28,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                passed ? 'All Checks Passed' : 'Issues Found',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: passed
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: passed
                      ? const Color(0xFF388E3C)
                      : const Color(0xFFD32F2F),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER — Curve preview
// ═══════════════════════════════════════════════════════════════════════════

class _CurvePreviewPainter extends CustomPainter {
  final List<double> points;
  _CurvePreviewPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kAmber700
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final bgPaint = Paint()
      ..color = _kAmber200.withAlpha(80)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw baseline
    canvas.drawLine(
      Offset(4, size.height - 4),
      Offset(size.width - 4, size.height - 4),
      bgPaint,
    );

    if (points.length < 2) return;

    final path = Path();
    final usableWidth = size.width - 8;
    final usableHeight = size.height - 8;
    final step = usableWidth / (points.length - 1);

    for (var i = 0; i < points.length; i++) {
      final x = 4.0 + i * step;
      final y = (size.height - 4) - (points[i] * usableHeight);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Draw start and end dots
    final dotPaint = Paint()
      ..color = _kAmber900
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(4, (size.height - 4) - (points.first * usableHeight)),
      3,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(
        4 + (points.length - 1) * step,
        (size.height - 4) - (points.last * usableHeight),
      ),
      3,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about FloatingHeaderSnapConfiguration
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║     FloatingHeaderSnapConfiguration Deep Demo                  ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- Overview ---');
  print('FloatingHeaderSnapConfiguration controls the snapping behavior of');
  print(
    'floating SliverPersistentHeader widgets. When a user stops scrolling,',
  );
  print('the floating header animates to fully open or fully closed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Properties ---');
  print('vsync (TickerProvider):');
  print('  - Provides the Ticker object that drives the snap animation.');
  print('  - Typically from TickerProviderStateMixin or');
  print('    SingleTickerProviderStateMixin.');
  print('curve (Curve):');
  print('  - Animation curve for snap easing. Default: Curves.ease');
  print('  - Controls acceleration profile of the snap.');
  print('duration (Duration):');
  print('  - Total time for the snap animation.');
  print('  - Default: Duration(milliseconds: 300)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SNAP BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Snap Behavior ---');
  print('1. User scrolls → floating header partially visible');
  print('2. User lifts finger → snap evaluates current extent');
  print('3. If extent > 50% → snap open (animate to maxExtent)');
  print('4. If extent <= 50% → snap closed (animate to 0)');
  print('5. Animation uses configured curve and duration');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CURVE TYPES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Curve Types ---');
  print('Curves.ease       → Smooth start and end (default)');
  print('Curves.easeOut    → Fast start, gentle deceleration');
  print('Curves.easeInOut  → Symmetric gentle ease');
  print('Curves.bounceOut  → Playful bounce effect');
  print('Curves.elasticOut → Springy overshoot');
  print('Curves.linear     → Constant speed (mechanical)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DURATION IMPACT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Duration Impact ---');
  print('100ms → Very snappy, possibly abrupt');
  print('200ms → Quick and responsive');
  print('300ms → Default, balanced feel');
  print('500ms → Smooth, deliberate');
  print('800ms → Slow, potentially sluggish');
  print('Recommended range: 200-400ms');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SLIVERAPPBAR INTEGRATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SliverAppBar Integration ---');
  print('SliverAppBar(floating: true, snap: true) automatically creates');
  print('a FloatingHeaderSnapConfiguration internally.');
  print('The vsync comes from the State\'s TickerProviderStateMixin.');
  print(
    'Custom configuration requires building a custom SliverPersistentHeader.',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BEST PRACTICES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Best Practices ---');
  print('✓ Use TickerProviderStateMixin for vsync');
  print('✓ Prefer easeOut curves for natural feel');
  print('✓ Keep duration between 200-400ms');
  print('✗ Avoid durations above 600ms');
  print('✗ Don\'t set snap:true without floating:true');
  print('✗ Don\'t ignore vsync lifecycle management');

  print('\nFloatingHeaderSnapConfiguration test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header ──
        _buildHeader(),
        const SizedBox(height: 24),

        // ── Section 1: What It Is ──
        _buildSectionTitle(
          'What is FloatingHeaderSnapConfiguration?',
          Icons.help_outline,
        ),
        _buildInfoCard(
          'Snap Configuration Object',
          'FloatingHeaderSnapConfiguration is a simple configuration class '
              'from rendering.dart that defines HOW a floating persistent '
              'header should snap after the user stops scrolling. It bundles '
              'the TickerProvider, animation curve, and duration into one '
              'configuration that the rendering layer uses to drive the snap.',
          Icons.settings,
        ),
        _buildInfoCard(
          'Part of the Sliver System',
          'Slivers power scrollable layouts in Flutter. Floating persistent '
              'headers appear when the user scrolls up. Snap makes them '
              'animate to fully-open or fully-closed — no half-visible '
              'header left behind.',
          Icons.view_day,
        ),
        _buildInfoCard(
          'Used Internally',
          'You rarely create FloatingHeaderSnapConfiguration directly. '
              'SliverAppBar with floating: true and snap: true creates '
              'one for you. Understanding it helps debug scroll behavior '
              'and build custom sliver headers.',
          Icons.build_circle,
        ),
        const SizedBox(height: 20),

        // ── Section 2: Properties ──
        _buildSectionTitle('Configuration Properties', Icons.tune),
        _buildPropertiesCard(),
        const SizedBox(height: 20),

        // ── Section 3: Snap Behavior Visual ──
        _buildSectionTitle('Snap Behavior Visualization', Icons.animation),
        _buildSnapBehaviorVisualization(),
        const SizedBox(height: 20),

        // ── Section 4: Curve Types ──
        _buildSectionTitle('Curve Types & Effects', Icons.show_chart),
        _buildCurveComparisonSection(),
        const SizedBox(height: 20),

        // ── Section 5: Duration Impact ──
        _buildSectionTitle('Duration Impact', Icons.timer),
        _buildDurationVisualization(),
        const SizedBox(height: 20),

        // ── Section 6: SliverAppBar Integration ──
        _buildSectionTitle(
          'SliverAppBar Integration',
          Icons.integration_instructions,
        ),
        _buildSliverAppBarIntegration(),
        const SizedBox(height: 16),

        // Code examples
        _buildCodeSnippet('Basic SliverAppBar with snap', '''Scaffold(
  body: CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: true,   // Required for snap
        snap: true,       // Enables snap behavior
        title: Text('My App'),
        expandedHeight: 120.0,
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(
            title: Text('Item \$index'),
          ),
          childCount: 50,
        ),
      ),
    ],
  ),
)'''),
        _buildCodeSnippet(
          'Custom SliverPersistentHeader with snap',
          '''class _MySliverDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 120.0;

  @override
  double get minExtent => 0.0;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        // vsync from TickerProviderStateMixin
        vsync: vsync,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
      );

  @override
  Widget build(BuildContext context,
      double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.orange,
      child: Center(child: Text('Floating Header')),
    );
  }

  @override
  bool shouldRebuild(covariant _MySliverDelegate old)
      => false;
}''',
        ),
        _buildCodeSnippet(
          'Providing vsync with StatefulWidget',
          '''class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with TickerProviderStateMixin {

  // 'this' provides the TickerProvider for vsync
  late final snapConfig =
      FloatingHeaderSnapConfiguration(
        vsync: this,
        curve: Curves.easeOut,
        duration: const Duration(
          milliseconds: 300,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: MyDelegate(snapConfig),
        ),
        // ... sliver list
      ],
    );
  }
}''',
        ),
        const SizedBox(height: 20),

        // ── Section 7: Real-World Use Cases ──
        _buildSectionTitle('Real-World Use Cases', Icons.cases),
        _buildUseCasesSection(),
        const SizedBox(height: 20),

        // ── Section 8: Best Practices ──
        _buildSectionTitle('Best Practices', Icons.verified),
        _buildBestPracticesSection(),
        const SizedBox(height: 20),

        // ── Test Result ──
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultBadge(
          true,
          'FloatingHeaderSnapConfiguration demo rendered successfully. '
          'All visual sections displayed.',
        ),
        const SizedBox(height: 20),

        // ── Summary ──
        _buildSummaryCard(),
        const SizedBox(height: 20),
      ],
    ),
  );
}
