// D4rt test script: Comprehensive demo for LayerHandle<T extends Layer>
//
// LayerHandle<T extends Layer> provides deterministic disposal of compositing
// layers. In Flutter's rendering pipeline, compositing layers form a tree that
// is sent to the engine for GPU-accelerated rendering. LayerHandle ensures
// that layers are properly disposed when no longer needed, preventing leaks.
//
// Key concepts:
//   - Compositing layers: GPU-rendered visual operations (clip, transform, opacity)
//   - LayerHandle.layer: setter that disposes old layer when replaced
//   - dispose(): releases the held layer
//   - Layer lifecycle: create → attach → paint → detach → dispose
//   - Relationship with OffsetLayer, ContainerLayer, PictureLayer
//
// This demo shows:
//   1. What compositing layers are and why they exist
//   2. Why handles are needed for layer lifecycle management
//   3. How LayerHandle.layer getter/setter works
//   4. Dispose semantics and ownership transfer
//   5. Relationship with OffsetLayer, ContainerLayer, and PictureLayer
//   6. Practical CustomPainter layer caching
//   7. Visual diagrams of layer tree management
//   8. Common pitfalls and best practices
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Purple/Green theme
// ═══════════════════════════════════════════════════════════════════════════

const _kPurple50 = Color(0xFFFAF5FF);
const _kPurple100 = Color(0xFFF3E8FF);
const _kPurple200 = Color(0xFFE9D5FF);
const _kPurple300 = Color(0xFFD8B4FE);
const _kPurple400 = Color(0xFFC084FC);
const _kPurple500 = Color(0xFFA855F7);
const _kPurple600 = Color(0xFF9333EA);
const _kPurple700 = Color(0xFF7E22CE);
const _kPurple800 = Color(0xFF6B21A8);
const _kPurple900 = Color(0xFF581C87);

const _kGreen500 = Color(0xFF22C55E);
const _kGreen600 = Color(0xFF16A34A);

const _kNeutral100 = Color(0xFFF5F5F5);
const _kNeutral200 = Color(0xFFE5E5E5);
const _kNeutral600 = Color(0xFF525252);
const _kNeutral800 = Color(0xFF262626);
const _kWhite = Color(0xFFFFFFFF);
const _kAmber500 = Color(0xFFF59E0B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a section title with purple accent icon
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kPurple700, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kPurple900,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(
  String title,
  String description,
  IconData icon, {
  Color accentColor = _kPurple500,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: accentColor.withAlpha(20),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kNeutral800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet block
Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kNeutral800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: _kPurple300,
        height: 1.5,
      ),
    ),
  );
}

/// Builds a layer tree node for the visual diagram
Widget _buildLayerNode(
  String label,
  Color color, {
  int indent = 0,
  bool isDisposed = false,
  bool hasHandle = false,
}) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 24.0, bottom: 6),
    child: Row(
      children: [
        if (indent > 0)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '└─',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kNeutral600,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isDisposed ? _kNeutral100 : color.withAlpha(25),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDisposed ? _kNeutral200 : color.withAlpha(80),
              width: hasHandle ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDisposed) Icon(Icons.close, size: 14, color: _kNeutral600),
              if (!isDisposed && hasHandle)
                Icon(Icons.lock, size: 14, color: color),
              if (!isDisposed && !hasHandle)
                Icon(Icons.layers, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDisposed ? _kNeutral600 : color,
                  decoration: isDisposed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a lifecycle step in a numbered sequence
Widget _buildLifecycleStep(
  int step,
  String title,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
            border: Border.all(color: color.withAlpha(80)),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: _kNeutral800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a warning/pitfall card
Widget _buildWarningCard(String title, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kAmber500.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAmber500.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber, color: _kAmber500, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _kNeutral800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a layer type card for the overview section
Widget _buildLayerTypeCard(
  String name,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: color,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// BUILD — entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // ── Data exploration prints ──────────────────────────────────────────
  print('=== LayerHandle<T extends Layer> Deep Demo ===');
  print('LayerHandle: provides deterministic disposal of compositing layers');
  print('Generic parameter: T extends Layer');
  print('Key property: .layer (getter/setter)');
  print('Key method: .dispose() → releases the held layer');
  print('Setter behavior: disposes OLD layer when assigning NEW layer');
  print('Used in: RenderObject.layer, CustomPainter caching');
  print(
    'Layer types: OffsetLayer, ContainerLayer, PictureLayer, ClipRectLayer',
  );
  print('Compositing pipeline: RenderObject → Layer → Scene → Engine');
  print('=== End exploration ===');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPurple600, _kPurple800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kPurple700.withAlpha(60),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers, color: _kPurple200, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'LayerHandle<T extends Layer>',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _kWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'A handle that provides deterministic disposal of '
                'compositing layers. Ensures layers are properly cleaned up '
                'when replaced or no longer needed.',
                style: TextStyle(fontSize: 14, color: _kPurple100, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Section 1: What Are Compositing Layers? ──────────────────
        _buildSectionTitle(
          '1. What Are Compositing Layers?',
          Icons.layers_outlined,
        ),
        _buildInfoCard(
          'The Compositing Tree',
          'Flutter\'s rendering pipeline has two trees: the render tree '
              '(RenderObjects) and the compositing layer tree (Layers). '
              'The layer tree is sent to the engine for GPU-accelerated '
              'rendering of clips, transforms, opacity, and more.',
          Icons.account_tree,
        ),
        _buildLayerTypeCard(
          'OffsetLayer',
          'Applies a 2D offset translation to its children',
          Icons.open_with,
          _kPurple500,
        ),
        _buildLayerTypeCard(
          'ContainerLayer',
          'Base class for layers that can have children',
          Icons.folder_open,
          _kGreen500,
        ),
        _buildLayerTypeCard(
          'PictureLayer',
          'Holds a pre-recorded Picture for display',
          Icons.image,
          _kPurple600,
        ),
        _buildLayerTypeCard(
          'ClipRectLayer',
          'Clips children to a rectangular region',
          Icons.crop,
          _kGreen600,
        ),
        _buildLayerTypeCard(
          'OpacityLayer',
          'Applies an alpha/opacity value to its children',
          Icons.opacity,
          _kPurple400,
        ),
        const SizedBox(height: 20),

        // ── Section 2: Why Handles Are Needed ────────────────────────
        _buildSectionTitle('2. Why Handles Are Needed', Icons.help_outline),
        _buildInfoCard(
          'The Problem',
          'Compositing layers hold GPU resources. If a RenderObject '
              'creates a new layer each frame without disposing the old one, '
              'GPU memory leaks occur. Manual tracking is error-prone.',
          Icons.memory,
          accentColor: _kAmber500,
        ),
        _buildInfoCard(
          'The Solution',
          'LayerHandle wraps a layer reference. When you assign a new '
              'layer to the handle, it automatically disposes the old one. '
              'Calling handle.dispose() releases the current layer.',
          Icons.shield,
          accentColor: _kGreen500,
        ),
        _buildCodeBlock(
          '// Without LayerHandle — potential leak:\n'
          'Layer? _oldLayer; // must manually track & dispose\n'
          '\n'
          '// With LayerHandle — automatic disposal:\n'
          'final _handle = LayerHandle<ClipRectLayer>();\n'
          '_handle.layer = ClipRectLayer(); // old auto-disposed\n'
          '_handle.dispose(); // current layer disposed',
        ),
        const SizedBox(height: 20),

        // ── Section 3: How LayerHandle.layer Works ───────────────────
        _buildSectionTitle('3. How LayerHandle.layer Works', Icons.settings),
        _buildLifecycleStep(
          1,
          'Create Handle',
          'LayerHandle<T>() creates an empty handle with layer = null',
          _kPurple500,
          Icons.add_circle_outline,
        ),
        _buildLifecycleStep(
          2,
          'Assign Layer',
          'handle.layer = MyLayer() stores the reference',
          _kPurple600,
          Icons.link,
        ),
        _buildLifecycleStep(
          3,
          'Replace Layer',
          'handle.layer = newLayer disposes old layer, stores new one',
          _kGreen500,
          Icons.swap_horiz,
        ),
        _buildLifecycleStep(
          4,
          'Read Layer',
          'handle.layer returns current T? for painting operations',
          _kPurple400,
          Icons.visibility,
        ),
        _buildLifecycleStep(
          5,
          'Dispose Handle',
          'handle.dispose() disposes current layer and sets reference to null',
          _kGreen600,
          Icons.delete_outline,
        ),
        _buildCodeBlock(
          '// LayerHandle internals (simplified)\n'
          'class LayerHandle<T extends Layer> {\n'
          '  T? _layer;\n'
          '\n'
          '  T? get layer => _layer;\n'
          '\n'
          '  set layer(T? newLayer) {\n'
          '    if (identical(_layer, newLayer)) return;\n'
          '    _layer?.dispose();  // dispose OLD layer\n'
          '    _layer = newLayer;\n'
          '  }\n'
          '\n'
          '  void dispose() {\n'
          '    layer = null;  // triggers disposal via setter\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 20),

        // ── Section 4: Dispose Semantics ─────────────────────────────
        _buildSectionTitle('4. Dispose Semantics', Icons.cleaning_services),
        _buildInfoCard(
          'Ownership Model',
          'A LayerHandle OWNS its layer. Only one handle should own a '
              'given layer at a time. Sharing layers between handles leads '
              'to double-dispose crashes.',
          Icons.person,
        ),
        _buildInfoCard(
          'Null Assignment',
          'Setting handle.layer = null disposes the current layer. '
              'This is exactly what handle.dispose() does internally.',
          Icons.not_interested,
        ),
        _buildInfoCard(
          'Self-Assignment Check',
          'Assigning the same layer instance again is a no-op. '
              'The handle checks identity before disposing.',
          Icons.compare,
          accentColor: _kGreen500,
        ),
        const SizedBox(height: 20),

        // ── Section 5: Layer Tree Diagram ────────────────────────────
        _buildSectionTitle(
          '5. Layer Tree Management',
          Icons.account_tree_outlined,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kNeutral100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kNeutral200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Active Layer Tree',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _kPurple800,
                ),
              ),
              const SizedBox(height: 10),
              _buildLayerNode(
                'TransformLayer (root)',
                _kPurple600,
                hasHandle: true,
              ),
              _buildLayerNode(
                'OffsetLayer',
                _kPurple500,
                indent: 1,
                hasHandle: true,
              ),
              _buildLayerNode(
                'ClipRectLayer',
                _kGreen500,
                indent: 2,
                hasHandle: true,
              ),
              _buildLayerNode('PictureLayer', _kPurple400, indent: 3),
              _buildLayerNode(
                'OpacityLayer',
                _kGreen600,
                indent: 2,
                hasHandle: true,
              ),
              _buildLayerNode('PictureLayer', _kPurple400, indent: 3),
              const SizedBox(height: 16),
              const Text(
                'After Replacing ClipRectLayer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _kPurple800,
                ),
              ),
              const SizedBox(height: 10),
              _buildLayerNode(
                'TransformLayer (root)',
                _kPurple600,
                hasHandle: true,
              ),
              _buildLayerNode(
                'OffsetLayer',
                _kPurple500,
                indent: 1,
                hasHandle: true,
              ),
              _buildLayerNode(
                'ClipRectLayer (OLD)',
                _kPurple400,
                indent: 2,
                isDisposed: true,
              ),
              _buildLayerNode(
                'ClipRRectLayer (NEW)',
                _kGreen500,
                indent: 2,
                hasHandle: true,
              ),
              _buildLayerNode('PictureLayer', _kPurple400, indent: 3),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Section 6: CustomPainter Layer Caching ───────────────────
        _buildSectionTitle('6. CustomPainter Layer Caching', Icons.brush),
        _buildInfoCard(
          'Why Cache Layers?',
          'When a CustomPainter paints complex content, the resulting '
              'PictureLayer can be cached. On repaint, the cached layer is '
              'reused if the content has not changed, avoiding re-recording.',
          Icons.cached,
          accentColor: _kGreen500,
        ),
        _buildCodeBlock(
          '// CustomPainter with layer caching (conceptual)\n'
          'class CachedPainter extends CustomPainter {\n'
          '  // The handle manages layer lifecycle\n'
          '  final LayerHandle<PictureLayer> _layerHandle =\n'
          '      LayerHandle<PictureLayer>();\n'
          '\n'
          '  @override\n'
          '  void paint(Canvas canvas, Size size) {\n'
          '    // Paint operations recorded by the canvas\n'
          '    // are stored in the layer held by _layerHandle\n'
          '    canvas.drawRect(\n'
          '      Rect.fromLTWH(0, 0, size.width, size.height),\n'
          '      Paint()..color = Colors.purple,\n'
          '    );\n'
          '  }\n'
          '\n'
          '  // Dispose must clean up the layer handle\n'
          '  void dispose() {\n'
          '    _layerHandle.dispose();\n'
          '  }\n'
          '}',
        ),
        _buildInfoCard(
          'RenderObject.layer',
          'RenderObject internally uses a LayerHandle for its "layer" '
              'property. When you set renderObject.layer = newLayer, the '
              'old one is automatically disposed via LayerHandle.',
          Icons.account_tree,
        ),
        const SizedBox(height: 20),

        // ── Section 7: Common Pitfalls ───────────────────────────────
        _buildSectionTitle('7. Common Pitfalls', Icons.bug_report),
        _buildWarningCard(
          'Double Dispose',
          'Never share one layer between two LayerHandles. When either '
              'handle disposes the layer, the other handle holds a dangling '
              'reference that will crash on its next dispose.',
        ),
        _buildWarningCard(
          'Forgotten Dispose',
          'Always call handle.dispose() in your RenderObject.dispose() '
              'override. Failing to do so leaks the GPU layer resource.',
        ),
        _buildWarningCard(
          'Using Disposed Layer',
          'After calling handle.dispose(), handle.layer returns null. '
              'Attempting to paint with a disposed layer throws an error.',
        ),
        _buildWarningCard(
          'Creating Layers Without Handles',
          'If you create a layer outside a LayerHandle, you are responsible '
              'for calling layer.dispose() manually. Prefer handles.',
        ),
        const SizedBox(height: 20),

        // ── Section 8: Best Practices ────────────────────────────────
        _buildSectionTitle('8. Best Practices', Icons.star),
        _buildInfoCard(
          'Always Use LayerHandle',
          'Wrap every layer you create in a LayerHandle. This guarantees '
              'deterministic disposal without manual bookkeeping.',
          Icons.verified,
          accentColor: _kGreen500,
        ),
        _buildInfoCard(
          'Dispose in RenderObject.dispose()',
          'Override dispose() in your RenderObject and call '
              '_myHandle.dispose(). This is the standard cleanup pattern.',
          Icons.cleaning_services,
          accentColor: _kPurple500,
        ),
        _buildInfoCard(
          'Prefer Replacement Over Recreation',
          'If the layer configuration changes, update properties on the '
              'existing layer instead of creating a new one when possible.',
          Icons.autorenew,
          accentColor: _kGreen600,
        ),
        _buildCodeBlock(
          '// Best-practice pattern in a RenderObject\n'
          'class MyRenderBox extends RenderBox {\n'
          '  final _clipHandle = LayerHandle<ClipRectLayer>();\n'
          '\n'
          '  @override\n'
          '  void paint(PaintingContext context, Offset offset) {\n'
          '    _clipHandle.layer = context.pushClipRect(\n'
          '      needsCompositing,\n'
          '      offset,\n'
          '      Offset.zero & size,\n'
          '      super.paint,\n'
          '      oldLayer: _clipHandle.layer,\n'
          '    );\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _clipHandle.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── Footer ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPurple200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kPurple600, size: 32),
              const SizedBox(height: 8),
              const Text(
                'LayerHandle Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: _kPurple800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'LayerHandle brings RAII-style deterministic cleanup to '
                'Flutter\'s compositing layer tree.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
