// D4rt test script: Comprehensive demo for AnnotationResult from rendering
//
// AnnotationResult<T> collects annotation entries from hit testing.
// It maintains:
//   - entries: List of AnnotationEntry<T> that were hit
//   - Each entry contains annotation data and local position
//
// This demo shows:
//   1. How AnnotationResult collects entries
//   2. Working with the entries list
//   3. Relationship with AnnotatedRegionLayer
//   4. Practical hit testing scenarios
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kDeepOrange50 = Color(0xFFFBE9E7);
const _kDeepOrange100 = Color(0xFFFFCCBC);
const _kDeepOrange200 = Color(0xFFFFAB91);
const _kDeepOrange300 = Color(0xFFFF8A65);
const _kDeepOrange400 = Color(0xFFFF7043);
const _kDeepOrange500 = Color(0xFFFF5722);
const _kDeepOrange600 = Color(0xFFF4511E);
const _kDeepOrange700 = Color(0xFFE64A19);
const _kDeepOrange800 = Color(0xFFD84315);
const _kDeepOrange900 = Color(0xFFBF360C);

// ═══════════════════════════════════════════════════════════════════════════
// SAMPLE ANNOTATION TYPES
// ═══════════════════════════════════════════════════════════════════════════

class LayerAnnotation {
  final String id;
  final int zIndex;
  final bool isInteractive;

  LayerAnnotation(this.id, this.zIndex, {this.isInteractive = true});

  @override
  String toString() => 'Layer($id, z:$zIndex)';
}

class ButtonData {
  final String buttonId;
  final String action;
  final Color color;

  ButtonData(this.buttonId, this.action, this.color);

  @override
  String toString() => 'Button($buttonId: $action)';
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kDeepOrange700, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kDeepOrange50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepOrange200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kDeepOrange100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kDeepOrange700, size: 24),
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
                  color: _kDeepOrange900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kDeepOrange700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kDeepOrange900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kDeepOrange800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kDeepOrange200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kDeepOrange100,
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
              color: Color(0xFFFFE0B2),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// AnnotationResult structure visualization
Widget _buildResultStructureCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepOrange400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnnotationResult<T> Structure',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
        const SizedBox(height: 16),
        _buildStructureDiagram(),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kDeepOrange50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: _kDeepOrange700, size: 16),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Result collects multiple entries from overlapping regions.',
                  style: TextStyle(fontSize: 11, color: _kDeepOrange800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStructureDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kDeepOrange100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _kDeepOrange600,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'AnnotationResult<T>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyLine('entries', 'Iterable<AnnotationEntry<T>>'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.only(left: 30),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kDeepOrange200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Each AnnotationEntry<T>:',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _kDeepOrange900,
                ),
              ),
              const SizedBox(height: 4),
              _buildPropertyLine('annotation', 'T'),
              _buildPropertyLine('localPosition', 'Offset'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyLine(String name, String type) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        const Text(
          '├── ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: _kDeepOrange700,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: _kDeepOrange700,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: _kDeepOrange500,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Hit test flow visualization
Widget _buildHitTestFlowCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepOrange300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hit Test Flow',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
        const SizedBox(height: 16),
        _buildFlowStep(
          1,
          'Hit Test Initiated',
          'User taps at position (x, y)',
          Icons.touch_app,
        ),
        _buildFlowArrow(),
        _buildFlowStep(
          2,
          'Layer Tree Traversal',
          'System checks AnnotatedRegionLayers',
          Icons.account_tree,
        ),
        _buildFlowArrow(),
        _buildFlowStep(
          3,
          'Entries Collected',
          'Matching regions create AnnotationEntry',
          Icons.playlist_add,
        ),
        _buildFlowArrow(),
        _buildFlowStep(
          4,
          'Result Returned',
          'AnnotationResult with all entries',
          Icons.check_circle,
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(int number, String title, String desc, IconData icon) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _kDeepOrange500,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _kDeepOrange100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _kDeepOrange700, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kDeepOrange900,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 10, color: _kDeepOrange600),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: const EdgeInsets.only(left: 17),
    child: Container(width: 6, height: 20, color: _kDeepOrange300),
  );
}

/// Multiple entries simulation
Widget _buildMultipleEntriesDemo() {
  return _MultipleEntriesWidget();
}

class _MultipleEntriesWidget extends StatefulWidget {
  @override
  State<_MultipleEntriesWidget> createState() => _MultipleEntriesWidgetState();
}

class _MultipleEntriesWidgetState extends State<_MultipleEntriesWidget> {
  final List<AnnotationEntry<LayerAnnotation>> _collectedEntries = [];
  bool _isHitTesting = false;

  void _simulateHitTest() {
    setState(() {
      _isHitTesting = true;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _collectedEntries.clear();
          // Simulate collecting entries from overlapping layers
          _collectedEntries.add(
            AnnotationEntry<LayerAnnotation>(
              annotation: LayerAnnotation('background', 0),
              localPosition: const Offset(150, 100),
            ),
          );
          _collectedEntries.add(
            AnnotationEntry<LayerAnnotation>(
              annotation: LayerAnnotation('content', 1),
              localPosition: const Offset(120, 70),
            ),
          );
          _collectedEntries.add(
            AnnotationEntry<LayerAnnotation>(
              annotation: LayerAnnotation('button', 2, isInteractive: true),
              localPosition: const Offset(45, 25),
            ),
          );
          _isHitTesting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDeepOrange400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Multiple Entries Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kDeepOrange900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hit testing overlapping layers returns multiple entries:',
            style: TextStyle(fontSize: 12, color: _kDeepOrange700),
          ),
          const SizedBox(height: 16),
          // Visual layers
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Background layer
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _kDeepOrange200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Background (z:0)',
                      style: TextStyle(fontSize: 10, color: _kDeepOrange800),
                    ),
                  ),
                ),
                // Content layer
                Positioned(
                  left: 30,
                  top: 30,
                  right: 50,
                  bottom: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kDeepOrange400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Content (z:1)',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                // Button layer
                Positioned(
                  left: 60,
                  top: 60,
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _kDeepOrange700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Button (z:2)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Hit point indicator
                Positioned(
                  left: 100,
                  top: 75,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Simulate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isHitTesting ? null : _simulateHitTest,
              icon: _isHitTesting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(_isHitTesting ? 'Testing...' : 'Simulate Hit Test'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kDeepOrange600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Results
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kDeepOrange50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDeepOrange200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'result.entries: ',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _kDeepOrange900,
                      ),
                    ),
                    Text(
                      '${_collectedEntries.length} entries',
                      style: const TextStyle(
                        fontSize: 11,
                        color: _kDeepOrange700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ..._collectedEntries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _kDeepOrange300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _kDeepOrange500,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${entry.annotation.zIndex}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.annotation.id,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: _kDeepOrange900,
                                  ),
                                ),
                                Text(
                                  'pos: (${entry.localPosition.dx.toInt()}, ${entry.localPosition.dy.toInt()})',
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: _kDeepOrange600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
}

/// Interactive region tapping
Widget _buildInteractiveRegionDemo() {
  return _InteractiveRegionWidget();
}

class _InteractiveRegionWidget extends StatefulWidget {
  @override
  State<_InteractiveRegionWidget> createState() =>
      _InteractiveRegionWidgetState();
}

class _InteractiveRegionWidgetState extends State<_InteractiveRegionWidget> {
  final List<AnnotationEntry<ButtonData>> _hitEntries = [];

  void _handleTap(
    String buttonId,
    String action,
    Color color,
    Offset position,
  ) {
    setState(() {
      _hitEntries.insert(
        0,
        AnnotationEntry<ButtonData>(
          annotation: ButtonData(buttonId, action, color),
          localPosition: position,
        ),
      );
      if (_hitEntries.length > 4) {
        _hitEntries.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDeepOrange400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Region Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kDeepOrange900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap annotated buttons to collect entries:',
            style: TextStyle(fontSize: 12, color: _kDeepOrange700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildAnnotatedButton(
                'btn-save',
                'Save',
                _kDeepOrange400,
                Icons.save,
              ),
              const SizedBox(width: 8),
              _buildAnnotatedButton(
                'btn-load',
                'Load',
                _kDeepOrange600,
                Icons.folder_open,
              ),
              const SizedBox(width: 8),
              _buildAnnotatedButton(
                'btn-delete',
                'Delete',
                _kDeepOrange800,
                Icons.delete,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildEntriesList(),
        ],
      ),
    );
  }

  Widget _buildAnnotatedButton(
    String id,
    String action,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: GestureDetector(
        onTapUp: (details) =>
            _handleTap(id, action, color, details.localPosition),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 4),
              Text(
                action,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntriesList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kDeepOrange50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _hitEntries.isEmpty
          ? const Center(
              child: Text(
                'No entries yet - tap buttons above',
                style: TextStyle(color: _kDeepOrange500),
              ),
            )
          : ListView.builder(
              itemCount: _hitEntries.length,
              itemBuilder: (context, index) {
                final entry = _hitEntries[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: entry.annotation.color.withAlpha(150),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 40,
                        decoration: BoxDecoration(
                          color: entry.annotation.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Button: ${entry.annotation.buttonId}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _kDeepOrange900,
                              ),
                            ),
                            Text(
                              'Action: ${entry.annotation.action}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: _kDeepOrange700,
                              ),
                            ),
                            Text(
                              'Position: (${entry.localPosition.dx.toStringAsFixed(0)}, ${entry.localPosition.dy.toStringAsFixed(0)})',
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: _kDeepOrange600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

/// Entries iteration demo
Widget _buildEntriesIterationCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kDeepOrange100, _kDeepOrange50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working with Entries',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
        const SizedBox(height: 16),
        _buildOperationCard(
          'Iterate All',
          'for (final entry in result.entries) { ... }',
          Icons.loop,
        ),
        _buildOperationCard(
          'Filter by Type',
          'entries.where((e) => e.annotation is Button)',
          Icons.filter_list,
        ),
        _buildOperationCard(
          'First Match',
          'entries.firstWhere((e) => e.annotation.id == x)',
          Icons.first_page,
        ),
        _buildOperationCard(
          'Check Empty',
          'if (entries.isNotEmpty) { handle() }',
          Icons.check_box,
        ),
      ],
    ),
  );
}

Widget _buildOperationCard(String title, String code, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: _kDeepOrange600, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _kDeepOrange900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kDeepOrange700,
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

/// Visual layer overlap demo
Widget _buildLayerOverlapVisual() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepOrange300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Layer Overlap Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kDeepOrange900,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _LayerOverlapPainter(),
            size: const Size(double.infinity, 200),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kDeepOrange50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Hit testing at overlapping regions returns entries from all layers.',
            style: TextStyle(fontSize: 11, color: _kDeepOrange800),
          ),
        ),
      ],
    ),
  );
}

class _LayerOverlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Layer 3 (bottom)
    paint.color = _kDeepOrange200;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 30, 180, 140),
        const Radius.circular(12),
      ),
      paint,
    );
    _drawLabel(canvas, 'Layer 3 (z:0)', const Offset(25, 160), _kDeepOrange700);

    // Layer 2
    paint.color = _kDeepOrange400;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(60, 50, 160, 120),
        const Radius.circular(10),
      ),
      paint,
    );
    _drawLabel(canvas, 'Layer 2 (z:1)', const Offset(65, 160), _kDeepOrange800);

    // Layer 1 (top)
    paint.color = _kDeepOrange700;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(100, 70, 120, 80),
        const Radius.circular(8),
      ),
      paint,
    );
    _drawLabel(canvas, 'Layer 1 (z:2)', const Offset(105, 135), Colors.white);

    // Hit point
    paint.color = Colors.red;
    canvas.drawCircle(const Offset(140, 100), 12, paint);
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawCircle(const Offset(140, 100), 12, paint);

    // Result arrow
    paint.style = PaintingStyle.fill;
    paint.color = _kDeepOrange600;

    final arrowPath = Path()
      ..moveTo(230, 90)
      ..lineTo(260, 100)
      ..lineTo(230, 110)
      ..close();
    canvas.drawPath(arrowPath, paint);

    // Result box
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(270, 40, 100, 120),
        const Radius.circular(8),
      ),
      paint,
    );

    _drawLabel(canvas, 'Result:', const Offset(280, 55), Colors.white);
    _drawLabel(canvas, '• Layer 1', const Offset(285, 75), Colors.white);
    _drawLabel(canvas, '• Layer 2', const Offset(285, 95), Colors.white);
    _drawLabel(canvas, '• Layer 3', const Offset(285, 115), Colors.white);
    _drawLabel(canvas, '3 entries', const Offset(285, 140), _kDeepOrange200);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Build results card
Widget _buildResultsCard(bool success, String className) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: success ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: success ? Colors.green[300]! : Colors.red[300]!,
      ),
    ),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.green[700] : Colors.red[700],
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                success ? 'Demo Successful' : 'Demo Failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
              Text(
                '$className concepts demonstrated',
                style: TextStyle(
                  fontSize: 12,
                  color: success ? Colors.green[600] : Colors.red[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kDeepOrange600,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about AnnotationResult
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║          AnnotationResult<T> Deep Demo                           ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- AnnotationResult Overview ---');
  print('Collects annotation entries from hit testing.');
  print('Contains entries list with annotation + localPosition.');

  // Create sample entries
  print('\n--- Working with Entries ---');
  final entries = <AnnotationEntry<String>>[
    AnnotationEntry<String>(
      annotation: 'layer-1',
      localPosition: const Offset(10, 20),
    ),
    AnnotationEntry<String>(
      annotation: 'layer-2',
      localPosition: const Offset(50, 30),
    ),
    AnnotationEntry<String>(
      annotation: 'layer-3',
      localPosition: const Offset(100, 40),
    ),
  ];

  print('Sample entries:');
  for (final entry in entries) {
    print('  ${entry.annotation} at ${entry.localPosition}');
  }

  // Demonstrate entry operations
  print('\n--- Entry Operations ---');
  print('entries.length: ${entries.length}');
  print('entries.isNotEmpty: ${entries.isNotEmpty}');
  print('entries.first: ${entries.first.annotation}');
  print('entries.last: ${entries.last.annotation}');

  print('\nAnnotationResult test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE8D6)],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kDeepOrange700, _kDeepOrange900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kDeepOrange800.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AnnotationResult<T>',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Collects annotation entries from hit testing, providing '
                    'all matched annotations with their local positions.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Overview cards
          _buildInfoCard(
            'Entry Collection',
            'Collects AnnotationEntry instances from all matching regions during hit test.',
            Icons.playlist_add,
          ),
          _buildInfoCard(
            'Overlapping Regions',
            'When regions overlap, all are included with their local positions.',
            Icons.layers,
          ),

          // Structure
          _buildSectionTitle('Result Structure', Icons.schema),
          _buildResultStructureCard(),
          const SizedBox(height: 20),

          // Hit test flow
          _buildSectionTitle('Hit Test Flow', Icons.account_tree),
          _buildHitTestFlowCard(),
          const SizedBox(height: 20),

          // Multiple entries
          _buildSectionTitle('Multiple Entries', Icons.format_list_numbered),
          _buildMultipleEntriesDemo(),
          const SizedBox(height: 20),

          // Interactive regions
          _buildSectionTitle('Interactive Regions', Icons.touch_app),
          _buildInteractiveRegionDemo(),
          const SizedBox(height: 20),

          // Layer overlap
          _buildSectionTitle('Layer Overlap', Icons.stacked_bar_chart),
          _buildLayerOverlapVisual(),
          const SizedBox(height: 20),

          // Working with entries
          _buildSectionTitle('Entry Operations', Icons.settings),
          _buildEntriesIterationCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'Processing AnnotationResult',
            '''// Get result from hit test
final result = AnnotationResult<String>();

// Check if any entries
if (result.entries.isNotEmpty) {
  // Process all entries
  for (final entry in result.entries) {
    print('Hit: \${entry.annotation}');
    print('At: \${entry.localPosition}');
  }
}''',
          ),
          _buildCodeSnippet(
            'Finding Specific Entries',
            '''// Find first matching entry
final button = result.entries
  .whereType<AnnotationEntry<ButtonData>>()
  .firstWhere(
    (e) => e.annotation.isInteractive,
    orElse: () => null,
  );

if (button != null) {
  handleButtonTap(button.annotation, button.localPosition);
}''',
          ),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'AnnotationResult<T>'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kDeepOrange100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kDeepOrange700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kDeepOrange900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'AnnotationResult<T> collects all matching AnnotationEntry instances '
                  'from hit testing, enabling detection of multiple overlapping '
                  'annotated regions with their precise local positions.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kDeepOrange800,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('collection', Icons.library_add),
                    const SizedBox(width: 8),
                    _buildSummaryChip('hit test', Icons.touch_app),
                    const SizedBox(width: 8),
                    _buildSummaryChip('entries', Icons.list),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
