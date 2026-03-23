// D4rt test script: Deep demo for PlatformViewLayer from rendering
//
// PlatformViewLayer is a specialized layer for embedding native platform views
// within Flutter's rendering layer tree. It represents a region where a
// native platform view (Android View, iOS UIView, or web element) is composited.
//
// Key characteristics:
//   - Embeds native platform views in Flutter's layer tree
//   - Defines position and size via rect property
//   - Identifies the platform view via viewId
//   - Participates in z-ordering with Flutter content
//   - Enables hybrid UI with native and Flutter widgets
//
// Related classes:
//   - Layer: Base class for compositing layers
//   - ContainerLayer: Parent class that can contain children
//   - TextureLayer: Similar layer for texture-based content
//   - RenderAndroidView: Render object for Android platform views
//   - RenderUiKitView: Render object for iOS platform views
//
// Use cases:
//   - Embedding maps (Google Maps, Apple Maps)
//   - Displaying native ad views
//   - Integrating video players
//   - Using platform-specific UI components
//   - Embedding WebViews in Flutter apps
//
// This demo visualizes PlatformViewLayer structure and composition patterns.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00695C).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.view_in_ar, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF00695C), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF00695C),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF00796B),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(
  String label,
  Color color, {
  IconData? icon,
  double width = 100,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: color, size: 20),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color color = Colors.grey}) {
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 20, color: color),
        Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 20, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: PLATFORM VIEW LAYER OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('PlatformViewLayer Overview', Icons.layers),
        Text(
          'PlatformViewLayer is a leaf layer in Flutter\'s compositing tree that '
          'reserves a rectangular region for a native platform view. It enables '
          'seamless integration of native components within Flutter applications.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'PlatformViewLayer Architecture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00695C),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              _buildDiagramBox(
                'ContainerLayer\n(Parent)',
                Color(0xFF5D4037),
                icon: Icons.folder,
                width: 140,
              ),
              SizedBox(height: 8),
              _buildArrow(vertical: true, color: Color(0xFF795548)),
              SizedBox(height: 4),
              Container(
                width: 180,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF00897B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00695C).withAlpha(80),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.view_in_ar, color: Colors.white, size: 28),
                    SizedBox(height: 8),
                    Text(
                      'PlatformViewLayer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Native View Placeholder',
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              _buildArrow(vertical: true, color: Color(0xFF00897B)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPlatformBox(
                    'Android\nView',
                    Color(0xFF4CAF50),
                    Icons.android,
                  ),
                  _buildPlatformBox(
                    'iOS\nUIView',
                    Color(0xFF9E9E9E),
                    Icons.phone_iphone,
                  ),
                  _buildPlatformBox(
                    'Web\nElement',
                    Color(0xFF2196F3),
                    Icons.web,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Type', 'Leaf layer (no children in layer tree)'),
        _buildInfoRow('Purpose', 'Embed native platform views'),
        _buildInfoRow('Inheritance', 'Layer → PlatformViewLayer'),
        _buildInfoRow('Compositing', 'Creates platform view composite'),
      ],
    ),
  );
}

Widget _buildPlatformBox(String label, Color color, IconData icon) {
  return Container(
    width: 85,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(150), width: 1.5),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: VIEW ID PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildViewIdSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('viewId Property', Icons.fingerprint),
        Text(
          'The viewId uniquely identifies the platform view within the Flutter '
          'engine. Each platform view controller generates a unique ID that links '
          'the layer to its native counterpart on the platform.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'View ID Registration Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3949AB),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildIdFlowStep(
                '1',
                'Platform creates native view',
                Icons.add_box,
                Color(0xFF3949AB),
              ),
              _buildIdConnector(Color(0xFF5C6BC0)),
              _buildIdFlowStep(
                '2',
                'Engine assigns unique viewId',
                Icons.tag,
                Color(0xFF5C6BC0),
              ),
              _buildIdConnector(Color(0xFF5C6BC0)),
              _buildIdFlowStep(
                '3',
                'PlatformViewLayer stores viewId',
                Icons.layers,
                Color(0xFF7986CB),
              ),
              _buildIdConnector(Color(0xFF5C6BC0)),
              _buildIdFlowStep(
                '4',
                'Scene builder references viewId',
                Icons.movie,
                Color(0xFF9FA8DA),
              ),
              _buildIdConnector(Color(0xFF5C6BC0)),
              _buildIdFlowStep(
                '5',
                'Compositor links to native view',
                Icons.link,
                Color(0xFFC5CAE9),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFF57F17), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'viewId Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF57F17),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildViewIdDetail('Type', 'int'),
              _buildViewIdDetail('Scope', 'Unique per engine instance'),
              _buildViewIdDetail('Lifetime', 'Valid until view disposed'),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Property', 'final int viewId'),
        _buildInfoRow('Assignment', 'Set by platform view controller'),
        _buildInfoRow('Usage', 'Links layer to native view'),
        _buildInfoRow('Validation', 'Must reference existing view'),
      ],
    ),
  );
}

Widget _buildIdFlowStep(
  String number,
  String label,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Icon(icon, color: color, size: 20),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF283593),
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget _buildIdConnector(Color color) {
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Row(
      children: [Container(width: 2, height: 10, color: color.withAlpha(150))],
    ),
  );
}

Widget _buildViewIdDetail(String name, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.chevron_right, size: 16, color: Color(0xFFFF8F00)),
        Text(
          '$name: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFFF57F17),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 12, color: Color(0xFFFF8F00))),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: RECT PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildRectSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('rect Property', Icons.crop_square),
        Text(
          'The rect property defines the rectangular bounds where the platform '
          'view will be composited. It specifies position and size in logical '
          'pixels relative to the layer\'s coordinate system.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Rect Visualization',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildRectVisualization(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildRectPropertyCard('left', '100.0', Color(0xFFE91E63)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildRectPropertyCard('top', '200.0', Color(0xFF9C27B0)),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildRectPropertyCard(
                'width',
                '300.0',
                Color(0xFF673AB7),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildRectPropertyCard(
                'height',
                '250.0',
                Color(0xFF3F51B5),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Coordinate System',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'The rect is in the layer\'s local coordinate space. Parent transforms '
                '(offset, scale, rotation) are applied during compositing to position '
                'the platform view in screen coordinates.',
                style: TextStyle(color: Color(0xFF388E3C), fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Property', 'final Rect rect'),
        _buildInfoRow('Type', 'Rect (left, top, width, height)'),
        _buildInfoRow('Units', 'Logical pixels'),
        _buildInfoRow('Coordinate', 'Layer-local (0,0 at layer origin)'),
      ],
    ),
  );
}

Widget _buildRectVisualization() {
  return Container(
    width: 280,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFC2185B).withAlpha(100), width: 1),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 8,
          top: 8,
          child: Text(
            'Layer Bounds (0,0)',
            style: TextStyle(fontSize: 9, color: Color(0xFF78909C)),
          ),
        ),
        Positioned(
          left: 40,
          top: 50,
          child: Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00695C).withAlpha(50),
                  Color(0xFF00897B).withAlpha(50),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFF00695C), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.view_in_ar, color: Color(0xFF00695C), size: 24),
                  SizedBox(height: 4),
                  Text(
                    'PlatformView\nRect',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 35,
          child: _buildDimensionLine(true, 180, '300.0'),
        ),
        Positioned(
          left: 25,
          top: 50,
          child: _buildDimensionLine(false, 100, '250.0'),
        ),
      ],
    ),
  );
}

Widget _buildDimensionLine(bool horizontal, double length, String label) {
  if (horizontal) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: length, height: 1, color: Color(0xFFE91E63)),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Color(0xFFE91E63),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 1, height: length, color: Color(0xFFE91E63)),
        ],
      ),
      SizedBox(width: 2),
      RotatedBox(
        quarterTurns: 3,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Color(0xFFE91E63),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

Widget _buildRectPropertyCard(String name, String value, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: LAYER TREE VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLayerTreeSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Layer Tree Visualization', Icons.account_tree),
        Text(
          'PlatformViewLayer appears as a leaf node in the layer tree. It '
          'does not have child layers but represents a placeholder where '
          'native content will be composited by the platform.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Layer Tree Structure',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF512DA8),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildLayerTreeVisualization(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_tree, color: Color(0xFF7B1FA2), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Layer Types',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildLayerTypeRow(
                'TransformLayer',
                'Applies matrix transform',
                Color(0xFF1565C0),
              ),
              _buildLayerTypeRow(
                'ClipRectLayer',
                'Clips content to rect',
                Color(0xFF2E7D32),
              ),
              _buildLayerTypeRow(
                'OpacityLayer',
                'Applies opacity',
                Color(0xFFE65100),
              ),
              _buildLayerTypeRow(
                'PlatformViewLayer',
                'Native view placeholder',
                Color(0xFF00695C),
              ),
              _buildLayerTypeRow(
                'PictureLayer',
                'Flutter-drawn content',
                Color(0xFFC2185B),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Parent Layers', 'ContainerLayer or subclasses'),
        _buildInfoRow('Child Layers', 'None (leaf layer)'),
        _buildInfoRow('Traversal', 'depth-first preorder'),
        _buildInfoRow('Scene Build', 'Adds platform view to scene'),
      ],
    ),
  );
}

Widget _buildLayerTreeVisualization() {
  return Column(
    children: [
      _buildTreeLayerNode(
        'TransformLayer',
        Color(0xFF1565C0),
        Icons.transform,
        true,
      ),
      _buildTreeLayerConnector(),
      _buildTreeLayerNode('ClipRectLayer', Color(0xFF2E7D32), Icons.crop, true),
      _buildTreeLayerConnector(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _buildTreeLayerNode(
                'PictureLayer',
                Color(0xFFC2185B),
                Icons.image,
                false,
              ),
              Text(
                'Flutter UI',
                style: TextStyle(fontSize: 8, color: Color(0xFF78909C)),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF00897B)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00695C).withAlpha(60),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.view_in_ar, color: Colors.white, size: 16),
                    Text(
                      'PlatformViewLayer',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Native View',
                style: TextStyle(fontSize: 8, color: Color(0xFF78909C)),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              _buildTreeLayerNode(
                'PictureLayer',
                Color(0xFFC2185B),
                Icons.image,
                false,
              ),
              Text(
                'Flutter UI',
                style: TextStyle(fontSize: 8, color: Color(0xFF78909C)),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildTreeLayerNode(
  String label,
  Color color,
  IconData icon,
  bool hasChildren,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(hasChildren ? 40 : 25),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: hasChildren ? 2 : 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeLayerConnector() {
  return Container(width: 2, height: 12, color: Color(0xFF9575CD));
}

Widget _buildLayerTypeRow(String name, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: color,
          ),
        ),
        Text(
          ' - $description',
          style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: COMPOSITION WITH FLUTTER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCompositionSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Composition with Flutter Widgets', Icons.widgets),
        Text(
          'Platform views can be composed with Flutter widgets, allowing native '
          'components to be embedded within Flutter UI. This enables hybrid apps '
          'that leverage both Flutter and native platform features.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Hybrid Composition',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildHybridCompositionDiagram(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCompositionModeCard(
                'Virtual Display',
                'Android only',
                Color(0xFF4CAF50),
                Icons.android,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildCompositionModeCard(
                'Hybrid Composition',
                'iOS & Android',
                Color(0xFF2196F3),
                Icons.layers,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFFDE7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: Color(0xFFF57F17), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Performance Considerations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF57F17),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Platform views have performance overhead due to texture synchronization '
                'and compositor complexity. Use sparingly for best performance.',
                style: TextStyle(color: Color(0xFFF9A825), fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Widget', 'AndroidView / UiKitView'),
        _buildInfoRow('Render Object', 'RenderAndroidView / RenderUiKitView'),
        _buildInfoRow('Layer', 'PlatformViewLayer'),
        _buildInfoRow('Integration', 'Seamless with transforms'),
      ],
    ),
  );
}

Widget _buildHybridCompositionDiagram() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCompositionBox('AppBar', Color(0xFF1976D2), isFlutter: true),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCompositionBox(
              'Flutter\nContent',
              Color(0xFF1976D2),
              isFlutter: true,
            ),
            SizedBox(width: 4),
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00695C), Color(0xFF00897B)],
                ),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(0xFF00695C), width: 2),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map, color: Colors.white, size: 20),
                    Text(
                      'Native Map',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 4),
            _buildCompositionBox(
              'Flutter\nContent',
              Color(0xFF1976D2),
              isFlutter: true,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCompositionBox(
              'BottomNavigation',
              Color(0xFF1976D2),
              isFlutter: true,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCompositionBox(
  String label,
  Color color, {
  bool isFlutter = true,
}) {
  return Container(
    width: 100,
    height: isFlutter ? 35 : 60,
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildCompositionModeCard(
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 9, color: color.withAlpha(180)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: Z-ORDERING
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildZOrderingSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Z-Ordering', Icons.layers_outlined),
        Text(
          'Z-ordering determines the stacking order of layers during composition. '
          'Platform views can appear above or below Flutter content depending on '
          'their position in the layer tree.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Layer Stacking Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildZOrderVisualization(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildZOrderCard(
                'Below Flutter',
                'Z-index: 0',
                Color(0xFFAB47BC),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildZOrderCard(
                'Above Flutter',
                'Z-index: 1',
                Color(0xFF7B1FA2),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers, color: Color(0xFF3949AB), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Stacking Behavior',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3949AB),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildStackingRow('Tree order', 'Earlier sibling below later'),
              _buildStackingRow('Platform view', 'Composited in tree order'),
              _buildStackingRow('Picture layer', 'Flutter content above/below'),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Stack Order', 'Determined by layer tree position'),
        _buildInfoRow('Traversal', 'depth-first preorder painting'),
        _buildInfoRow('Overlay', 'Flutter can draw over platform views'),
        _buildInfoRow('Underlay', 'Flutter can draw behind platform views'),
      ],
    ),
  );
}

Widget _buildZOrderVisualization() {
  return SizedBox(
    width: 240,
    height: 140,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          child: _buildZOrderLayer(
            'Flutter Background',
            Color(0xFF1976D2),
            220,
            30,
          ),
        ),
        Positioned(
          bottom: 35,
          child: _buildZOrderLayer(
            'PlatformViewLayer',
            Color(0xFF00695C),
            200,
            50,
          ),
        ),
        Positioned(
          bottom: 90,
          child: _buildZOrderLayer(
            'Flutter Overlay',
            Color(0xFFC2185B),
            180,
            30,
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Top',
                style: TextStyle(fontSize: 8, color: Color(0xFF78909C)),
              ),
              Container(width: 1, height: 100, color: Color(0xFFBDBDBD)),
              Icon(Icons.arrow_drop_down, color: Color(0xFF78909C), size: 16),
              Text(
                'Bottom',
                style: TextStyle(fontSize: 8, color: Color(0xFF78909C)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildZOrderLayer(
  String label,
  Color color,
  double width,
  double height,
) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color.withAlpha(80),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ),
  );
}

Widget _buildZOrderCard(String title, String subtitle, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 10, color: color.withAlpha(180)),
        ),
      ],
    ),
  );
}

Widget _buildStackingRow(String scenario, String behavior) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.chevron_right, size: 14, color: Color(0xFF5C6BC0)),
        Text(
          '$scenario: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: Color(0xFF3949AB),
          ),
        ),
        Expanded(
          child: Text(
            behavior,
            style: TextStyle(fontSize: 10, color: Color(0xFF5C6BC0)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(
              'PlatformViewLayer',
              'Layer for embedding native platform views in Flutter',
            ),
        SizedBox(height: 20),
        _buildOverviewSection(),
        SizedBox(height: 16),
        _buildViewIdSection(),
        SizedBox(height: 16),
        _buildRectSection(),
        SizedBox(height: 16),
        _buildLayerTreeSection(),
        SizedBox(height: 16),
        _buildCompositionSection(),
        SizedBox(height: 16),
        _buildZOrderingSection(),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF00695C), size: 36),
              SizedBox(height: 8),
              Text(
                'PlatformViewLayer Deep Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Native platform view embedding and composition visualized',
                style: TextStyle(fontSize: 12, color: Color(0xFF00796B)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
        ),
      ),
    ),
  );
}
