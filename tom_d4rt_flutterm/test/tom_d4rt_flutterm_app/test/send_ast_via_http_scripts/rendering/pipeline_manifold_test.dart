// D4rt test script: Deep demo for PipelineManifold from rendering
//
// PipelineManifold manages pipeline owner connections for rendering.
// It serves as the connection point between pipeline owners and the
// rendering system, coordinating visual updates, semantic changes,
// and layout boundaries across multiple render trees.
//
// Key responsibilities:
//   - Manages requestVisualUpdate flow
//   - Coordinates semantic update propagation
//   - Tracks layout boundary relationships
//   - Maintains pipeline tree structure
//   - Connects pipeline owners to the rendering system
//
// Related classes:
//   - PipelineOwner: Owns a render tree and manages dirty nodes
//   - RenderView: Root render object for a view
//   - SemanticsOwner: Manages semantics for accessibility
//   - RenderObject: Base class for render tree nodes
//
// Use cases:
//   - Multi-window Flutter applications
//   - Embedded Flutter views in native apps
//   - Complex rendering scenarios with multiple views
//   - Accessibility and semantics coordination
//
// This demo visualizes the PipelineManifold coordination architecture.

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
        colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0D47A1).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.account_tree, size: 48, color: Colors.white),
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
            color: Color(0xFF1976D2).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF0D47A1), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
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
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D47A1),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF1565C0),
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
// SECTION 1: PIPELINE MANIFOLD OVERVIEW DIAGRAM
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewDiagramSection() {
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
        _buildSectionTitle('PipelineManifold Overview', Icons.schema),
        Text(
          'PipelineManifold is the bridge between PipelineOwner instances and '
          'the rendering infrastructure. It manages connections, coordinates '
          'visual updates, and ensures proper synchronization across views.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'PipelineManifold Architecture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              // Top layer - RendererBinding
              _buildDiagramBox(
                'RendererBinding',
                Color(0xFF6A1B9A),
                icon: Icons.merge_type,
                width: 140,
              ),
              SizedBox(height: 8),
              _buildArrow(vertical: true, color: Color(0xFF8E24AA)),
              SizedBox(height: 4),
              // Middle layer - PipelineManifold
              Container(
                width: 200,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0D47A1).withAlpha(80),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.account_tree, color: Colors.white, size: 28),
                    SizedBox(height: 8),
                    Text(
                      'PipelineManifold',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pipeline Connection Hub',
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Connection lines
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrow(vertical: true, color: Color(0xFF1976D2)),
                  SizedBox(width: 50),
                  _buildArrow(vertical: true, color: Color(0xFF1976D2)),
                  SizedBox(width: 50),
                  _buildArrow(vertical: true, color: Color(0xFF1976D2)),
                ],
              ),
              SizedBox(height: 4),
              // Bottom layer - PipelineOwners
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDiagramBox(
                    'PipelineOwner\n(View 1)',
                    Color(0xFF388E3C),
                    icon: Icons.layers,
                  ),
                  _buildDiagramBox(
                    'PipelineOwner\n(View 2)',
                    Color(0xFF388E3C),
                    icon: Icons.layers,
                  ),
                  _buildDiagramBox(
                    'PipelineOwner\n(View 3)',
                    Color(0xFF388E3C),
                    icon: Icons.layers,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Interface', 'Abstract class defining manifold contract'),
        _buildInfoRow(
          'Primary Purpose',
          'Coordinate pipeline owners with rendering',
        ),
        _buildInfoRow(
          'Implementation',
          'RendererBinding mixin provides default',
        ),
        _buildInfoRow('Scope', 'Application-wide rendering coordination'),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: REQUEST VISUAL UPDATE CONCEPT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildRequestVisualUpdateSection() {
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
        _buildSectionTitle('requestVisualUpdate Concept', Icons.refresh),
        Text(
          'The requestVisualUpdate method is the primary mechanism for '
          'PipelineOwner to signal that visual changes need to be flushed. '
          'It triggers the rendering pipeline to schedule a new frame.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Visual Update Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildUpdateFlowStep(
                '1',
                'RenderObject marks dirty',
                Icons.flag,
                Color(0xFFE65100),
              ),
              _buildFlowConnector(Color(0xFFFF9800)),
              _buildUpdateFlowStep(
                '2',
                'PipelineOwner records node',
                Icons.note_add,
                Color(0xFFF57C00),
              ),
              _buildFlowConnector(Color(0xFFFF9800)),
              _buildUpdateFlowStep(
                '3',
                'requestVisualUpdate() called',
                Icons.send,
                Color(0xFFFFB300),
              ),
              _buildFlowConnector(Color(0xFFFF9800)),
              _buildUpdateFlowStep(
                '4',
                'onNeedVisualUpdate invoked',
                Icons.notification_important,
                Color(0xFFFFC107),
              ),
              _buildFlowConnector(Color(0xFFFF9800)),
              _buildUpdateFlowStep(
                '5',
                'Frame scheduled',
                Icons.schedule,
                Color(0xFFFFD54F),
              ),
              _buildFlowConnector(Color(0xFFFF9800)),
              _buildUpdateFlowStep(
                '6',
                'Flush methods called',
                Icons.cleaning_services,
                Color(0xFFFFE082),
              ),
            ],
          ),
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
                    'Key Insight',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'requestVisualUpdate batches multiple dirty marks into a single frame. '
                'No matter how many RenderObjects are marked dirty, only one frame '
                'is scheduled until the next vsync.',
                style: TextStyle(color: Color(0xFF388E3C), fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Method', 'requestVisualUpdate()'),
        _buildInfoRow('Callback', 'onNeedVisualUpdate - notifies binding'),
        _buildInfoRow('Batching', 'Multiple calls coalesce into one frame'),
        _buildInfoRow('Trigger', 'Any dirty state in PipelineOwner'),
      ],
    ),
  );
}

Widget _buildUpdateFlowStep(
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
            color: Color(0xFF5D4037),
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget _buildFlowConnector(Color color) {
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Row(
      children: [Container(width: 2, height: 10, color: color.withAlpha(150))],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: SEMANTIC UPDATES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSemanticUpdatesSection() {
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
        _buildSectionTitle('Semantic Updates', Icons.accessibility_new),
        Text(
          'PipelineManifold coordinates semantic updates for accessibility. '
          'When semantics are enabled, it manages the SemanticsOwner and '
          'ensures semantic information flows to the platform.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Semantics Pipeline',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSemanticNode(
                    'RenderObject\nmarkNeedsSemanticsUpdate',
                    Color(0xFF7B1FA2),
                  ),
                  Icon(Icons.arrow_forward, color: Color(0xFF9C27B0)),
                  _buildSemanticNode(
                    'PipelineOwner\nsemantics dirty list',
                    Color(0xFF8E24AA),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Icon(Icons.arrow_downward, color: Color(0xFF9C27B0), size: 28),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSemanticNode(
                    'flushSemantics()\ncompute changes',
                    Color(0xFFAB47BC),
                  ),
                  Icon(Icons.arrow_forward, color: Color(0xFF9C27B0)),
                  _buildSemanticNode(
                    'SemanticsOwner\nsend to platform',
                    Color(0xFFBA68C8),
                  ),
                ],
              ),
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
                  Icon(
                    Icons.settings_accessibility,
                    color: Color(0xFF6A1B9A),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Semantics Enablement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildSemanticInfoRow(
                'ensureSemantics',
                'Enables semantic collection',
              ),
              _buildSemanticInfoRow(
                'SemanticsHandle',
                'Keep-alive reference for semantics',
              ),
              _buildSemanticInfoRow(
                'onSemanticsUpdate',
                'Callback when semantics change',
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Semantics Owner', 'Manages semantic tree for a view'),
        _buildInfoRow(
          'Semantic Nodes',
          'Derived from RenderObject annotations',
        ),
        _buildInfoRow(
          'Platform Bridge',
          'Delivers to iOS/Android accessibility',
        ),
        _buildInfoRow(
          'Update Frequency',
          'Batched per frame with visual updates',
        ),
      ],
    ),
  );
}

Widget _buildSemanticNode(String label, Color color) {
  return Container(
    width: 120,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(40),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildSemanticInfoRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.chevron_right, size: 16, color: Color(0xFF9C27B0)),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF6A1B9A),
          ),
        ),
        Text(
          ' - $description',
          style: TextStyle(fontSize: 11, color: Color(0xFF8E24AA)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: LAYOUT BOUNDARY VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLayoutBoundarySection() {
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
        _buildSectionTitle('Layout Boundary Visualization', Icons.crop_square),
        Text(
          'Layout boundaries define regions where layout changes are isolated. '
          'These boundaries prevent layout invalidation from propagating through '
          'the entire tree, improving performance significantly.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Layout Boundary Tree',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              _buildLayoutBoundaryTree(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.speed, color: Color(0xFFE65100), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Performance Impact',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildPerformanceRow(
                'Without Boundary',
                'Full tree relayout',
                Color(0xFFD84315),
              ),
              _buildPerformanceRow(
                'With Boundary',
                'Subtree relayout only',
                Color(0xFF388E3C),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildBoundaryTypeCard(
                'Relayout\nBoundary',
                Color(0xFF43A047),
                Icons.check_box,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildBoundaryTypeCard(
                'Repaint\nBoundary',
                Color(0xFF1E88E5),
                Icons.brush,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildInfoRow('sizedByParent', 'Enables relayout boundary'),
        _buildInfoRow('isRepaintBoundary', 'Enables repaint boundary'),
        _buildInfoRow('markNeedsLayout', 'Stops at relayout boundary'),
        _buildInfoRow('Layer isolation', 'Repaint boundary has own layer'),
      ],
    ),
  );
}

Widget _buildLayoutBoundaryTree() {
  return Column(
    children: [
      _buildTreeNode('RenderView (Root)', Color(0xFF1B5E20), true, 0),
      _buildTreeConnector(),
      _buildTreeNode('RenderFlex', Color(0xFF2E7D32), false, 1),
      _buildTreeConnector(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _buildTreeNode('LayoutBoundary', Color(0xFF43A047), true, 2),
              _buildTreeConnector(),
              _buildTreeNode('Child A', Color(0xFF66BB6A), false, 3),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              _buildTreeNode('LayoutBoundary', Color(0xFF43A047), true, 2),
              _buildTreeConnector(),
              _buildTreeNode('Child B', Color(0xFF66BB6A), false, 3),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildTreeNode(String label, Color color, bool isBoundary, int indent) {
  return Container(
    margin: EdgeInsets.only(left: indent * 8.0),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(isBoundary ? 60 : 30),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: color,
        width: isBoundary ? 2.5 : 1.5,
        style: isBoundary ? BorderStyle.solid : BorderStyle.solid,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isBoundary) Icon(Icons.shield, color: color, size: 14),
        if (isBoundary) SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isBoundary ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeConnector() {
  return Container(width: 2, height: 12, color: Color(0xFF81C784));
}

Widget _buildPerformanceRow(String scenario, String result, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(
          '$scenario: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF5D4037),
          ),
        ),
        Text(
          result,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoundaryTypeCard(String label, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
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
// SECTION 5: PIPELINE TREE STRUCTURE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPipelineTreeSection() {
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
        _buildSectionTitle(
          'Pipeline Tree Structure',
          Icons.account_tree_rounded,
        ),
        Text(
          'The pipeline tree structure shows how PipelineManifold connects to '
          'multiple PipelineOwner instances, each managing their own render '
          'tree with dirty lists for layout, paint, and semantics.',
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
                'Pipeline Ownership Hierarchy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              _buildPipelineHierarchy(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDirtyListCard(
                'Layout\nDirty List',
                Color(0xFFE53935),
                Icons.grid_view,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildDirtyListCard(
                'Paint\nDirty List',
                Color(0xFF8E24AA),
                Icons.format_paint,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildDirtyListCard(
                'Semantics\nDirty List',
                Color(0xFF1976D2),
                Icons.accessibility,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sync, color: Color(0xFF455A64), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Flush Order',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF455A64),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildFlushOrderRow('1', 'flushLayout', Color(0xFFE53935)),
              _buildFlushOrderRow(
                '2',
                'flushCompositingBits',
                Color(0xFFFF9800),
              ),
              _buildFlushOrderRow('3', 'flushPaint', Color(0xFF8E24AA)),
              _buildFlushOrderRow('4', 'flushSemantics', Color(0xFF1976D2)),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Root Node', 'RenderView serves as pipeline root'),
        _buildInfoRow(
          'Dirty Tracking',
          'Each PipelineOwner tracks its dirty nodes',
        ),
        _buildInfoRow(
          'Flush Coordination',
          'Manifold coordinates flush across owners',
        ),
        _buildInfoRow('Isolation', 'Each owner flushes independently'),
      ],
    ),
  );
}

Widget _buildPipelineHierarchy() {
  return Column(
    children: [
      _buildPipelineBox('PipelineManifold', Color(0xFF0D47A1), Icons.hub, true),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 60, height: 2, color: Color(0xFF1976D2)),
          Container(width: 2, height: 20, color: Color(0xFF1976D2)),
          Container(width: 60, height: 2, color: Color(0xFF1976D2)),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOwnerColumn('Owner A', Color(0xFF388E3C)),
          _buildOwnerColumn('Owner B', Color(0xFF7B1FA2)),
        ],
      ),
    ],
  );
}

Widget _buildPipelineBox(String label, Color color, IconData icon, bool large) {
  return Container(
    width: large ? 160 : 100,
    padding: EdgeInsets.all(large ? 14 : 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(large ? 12 : 8),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(40),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: large ? 24 : 18),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: large ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildOwnerColumn(String name, Color color) {
  return Column(
    children: [
      _buildPipelineBox('PipelineOwner\n$name', color, Icons.layers, false),
      SizedBox(height: 6),
      Container(width: 2, height: 15, color: color.withAlpha(150)),
      SizedBox(height: 6),
      _buildPipelineBox(
        'RenderView',
        color.withAlpha(180),
        Icons.desktop_windows,
        false,
      ),
      SizedBox(height: 4),
      Container(width: 2, height: 10, color: color.withAlpha(100)),
      SizedBox(height: 4),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text('Render Tree', style: TextStyle(fontSize: 9, color: color)),
      ),
    ],
  );
}

Widget _buildDirtyListCard(String label, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20),
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

Widget _buildFlushOrderRow(String number, String name, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: API REFERENCE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildApiReferenceSection() {
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
        _buildSectionTitle('API Reference', Icons.api),
        _buildApiGroup('Properties', [
          ApiEntry(
            'renderViews',
            'Iterable<RenderView>',
            'All active render views',
          ),
          ApiEntry(
            'onNeedVisualUpdate',
            'VoidCallback?',
            'Visual update callback',
          ),
          ApiEntry(
            'onSemanticsUpdate',
            'SemanticsUpdateCallback?',
            'Semantics callback',
          ),
        ], Color(0xFF1976D2)),
        SizedBox(height: 12),
        _buildApiGroup('Methods', [
          ApiEntry('requestVisualUpdate()', 'void', 'Request frame scheduling'),
          ApiEntry('ensureSemantics()', 'SemanticsHandle', 'Enable semantics'),
          ApiEntry('attach(RenderView)', 'void', 'Attach a view'),
          ApiEntry('detach(RenderView)', 'void', 'Detach a view'),
        ], Color(0xFF388E3C)),
        SizedBox(height: 12),
        _buildApiGroup('Related Types', [
          ApiEntry('PipelineOwner', 'class', 'Manages pipeline for a tree'),
          ApiEntry('RenderView', 'class', 'Root render object'),
          ApiEntry('SemanticsOwner', 'class', 'Manages semantics tree'),
        ], Color(0xFFE65100)),
      ],
    ),
  );
}

Widget _buildApiGroup(String title, List<ApiEntry> entries, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: color, size: 16),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ...entries.map((entry) => _buildApiEntryRow(entry, color)),
      ],
    ),
  );
}

Widget _buildApiEntryRow(ApiEntry entry, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 4,
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    entry.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFF37474F),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    entry.type,
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Text(
                entry.description,
                style: TextStyle(fontSize: 11, color: Color(0xFF78909C)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ApiEntry {
  String name;
  String type;
  String description;

  ApiEntry(this.name, this.type, this.description);
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'PipelineManifold',
          'Manages pipeline owner connections for rendering',
        ),
        SizedBox(height: 20),
        _buildOverviewDiagramSection(),
        SizedBox(height: 16),
        _buildRequestVisualUpdateSection(),
        SizedBox(height: 16),
        _buildSemanticUpdatesSection(),
        SizedBox(height: 16),
        _buildLayoutBoundarySection(),
        SizedBox(height: 16),
        _buildPipelineTreeSection(),
        SizedBox(height: 16),
        _buildApiReferenceSection(),
        SizedBox(height: 24),
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
              Icon(Icons.check_circle, color: Color(0xFF0D47A1), size: 36),
              SizedBox(height: 8),
              Text(
                'PipelineManifold Deep Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Pipeline owner connections and rendering coordination visualized',
                style: TextStyle(fontSize: 12, color: Color(0xFF1976D2)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
