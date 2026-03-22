// D4rt test script: Deep demo for PipelineManifold from rendering
//
// PipelineManifold coordinates rendering pipelines for multiple views.
// It serves as the central orchestrator for Flutter's rendering system,
// managing frame scheduling, view lifecycles, and pipeline synchronization.
//
// Key responsibilities:
//   - Coordinates multiple rendering views
//   - Manages frame scheduling callbacks
//   - Handles view creation and destruction
//   - Synchronizes pipeline phases across views
//   - Provides unified semantic tree management
//
// Related classes:
//   - RenderView: Individual view in the pipeline
//   - PipelineOwner: Owns a specific render pipeline
//   - RendererBinding: Binding that uses PipelineManifold
//   - SemanticsOwner: Manages semantics across views
//
// Use cases:
//   - Multi-window applications
//   - Embedded Flutter views
//   - Complex compositor scenarios
//   - Cross-view semantic coordination
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
        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1565C0).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.hub, size: 48, color: Colors.white),
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
            color: Color(0xFF42A5F5).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF1565C0), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
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
              color: Color(0xFF1565C0),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF1976D2),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(String label, Color color, {IconData? icon, double width = 100}) {
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
// SECTION 1: PIPELINE MANIFOLD CONCEPT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildManifoldConceptSection() {
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
        _buildSectionTitle('Pipeline Manifold Concept', Icons.account_tree),
        Text(
          'A PipelineManifold acts as a central coordinator that manages '
          'multiple rendering pipelines. It provides the infrastructure '
          'for multi-view applications and ensures synchronized frame '
          'processing across all active views.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // Manifold architecture diagram
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Manifold Architecture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 16),
              // Central manifold
              _buildDiagramBox(
                'PipelineManifold',
                Color(0xFF1565C0),
                icon: Icons.hub,
                width: 140,
              ),
              SizedBox(height: 8),
              // Connector lines
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrow(vertical: true, color: Color(0xFF42A5F5)),
                  SizedBox(width: 40),
                  _buildArrow(vertical: true, color: Color(0xFF42A5F5)),
                  SizedBox(width: 40),
                  _buildArrow(vertical: true, color: Color(0xFF42A5F5)),
                ],
              ),
              // Pipeline owners
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox('PipelineOwner 1', Color(0xFF43A047), icon: Icons.view_agenda),
                  SizedBox(width: 12),
                  _buildDiagramBox('PipelineOwner 2', Color(0xFF43A047), icon: Icons.view_agenda),
                  SizedBox(width: 12),
                  _buildDiagramBox('PipelineOwner 3', Color(0xFF43A047), icon: Icons.view_agenda),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrow(vertical: true, color: Color(0xFF66BB6A)),
                  SizedBox(width: 112),
                  _buildArrow(vertical: true, color: Color(0xFF66BB6A)),
                  SizedBox(width: 112),
                  _buildArrow(vertical: true, color: Color(0xFF66BB6A)),
                ],
              ),
              // Render views
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox('RenderView A', Color(0xFFFF7043), icon: Icons.desktop_windows),
                  SizedBox(width: 12),
                  _buildDiagramBox('RenderView B', Color(0xFFFF7043), icon: Icons.desktop_windows),
                  SizedBox(width: 12),
                  _buildDiagramBox('RenderView C', Color(0xFFFF7043), icon: Icons.desktop_windows),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Interface Type', 'Abstract class for pipeline coordination'),
        _buildInfoRow('Primary Role', 'Multi-view rendering orchestration'),
        _buildInfoRow('Key Consumer', 'RendererBinding implementation'),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: RENDER PIPELINE COORDINATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPipelineCoordinationSection() {
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
        _buildSectionTitle('Pipeline Coordination Flow', Icons.sync_alt),
        Text(
          'The manifold coordinates the rendering pipeline phases: layout, '
          'compositing, painting, and semantics updates. Each phase is '
          'executed across all registered views in proper sequence.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // Pipeline phases diagram
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Pipeline Phase Sequence',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 16),
              _buildPhaseRow('1', 'Schedule Frame', Icons.schedule, Color(0xFF7B1FA2)),
              _buildPhaseConnector(),
              _buildPhaseRow('2', 'Begin Frame', Icons.play_arrow, Color(0xFF1976D2)),
              _buildPhaseConnector(),
              _buildPhaseRow('3', 'Flush Layout', Icons.grid_view, Color(0xFF388E3C)),
              _buildPhaseConnector(),
              _buildPhaseRow('4', 'Flush Compositing', Icons.layers, Color(0xFFF57C00)),
              _buildPhaseConnector(),
              _buildPhaseRow('5', 'Flush Paint', Icons.brush, Color(0xFFD32F2F)),
              _buildPhaseConnector(),
              _buildPhaseRow('6', 'Flush Semantics', Icons.accessibility, Color(0xFF5D4037)),
              _buildPhaseConnector(),
              _buildPhaseRow('7', 'End Frame', Icons.stop, Color(0xFF455A64)),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('flushLayout()', 'Processes dirty layout nodes'),
        _buildInfoRow('flushCompositingBits()', 'Updates compositing requirements'),
        _buildInfoRow('flushPaint()', 'Paints dirty render objects'),
        _buildInfoRow('flushSemantics()', 'Updates accessibility tree'),
      ],
    ),
  );
}

Widget _buildPhaseRow(String number, String label, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
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
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

Widget _buildPhaseConnector() {
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Row(
      children: [
        Container(
          width: 2,
          height: 12,
          color: Color(0xFFBDBDBD),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: VIEW MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildViewManagementSection() {
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
        _buildSectionTitle('View Management', Icons.view_carousel),
        Text(
          'PipelineManifold manages multiple FlutterViews, each backed by '
          'a RenderView. Views can be added or removed dynamically, enabling '
          'scenarios like multi-window support and embedded views.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // View states diagram
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'View Lifecycle States',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildViewStateBox('Created', Color(0xFF4CAF50), Icons.add_circle),
                  _buildArrow(color: Color(0xFFFFB74D)),
                  _buildViewStateBox('Attached', Color(0xFF2196F3), Icons.link),
                  _buildArrow(color: Color(0xFFFFB74D)),
                  _buildViewStateBox('Active', Color(0xFF9C27B0), Icons.play_circle),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildViewStateBox('Detached', Color(0xFFFF5722), Icons.link_off),
                  SizedBox(width: 20),
                  _buildArrow(color: Color(0xFFFFB74D)),
                  SizedBox(width: 20),
                  _buildViewStateBox('Disposed', Color(0xFF607D8B), Icons.delete),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        // View registry info
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
                  Icon(Icons.inventory_2, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'View Registry',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('renderViews', 'Iterable of active RenderViews'),
              _buildInfoRow('addView()', 'Registers a new view'),
              _buildInfoRow('removeView()', 'Unregisters an existing view'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildViewStateBox(String label, Color color, IconData icon) {
  return Container(
    width: 80,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: SCHEDULING AND LIFECYCLE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSchedulingLifecycleSection() {
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
        _buildSectionTitle('Scheduling & Lifecycle', Icons.timer),
        Text(
          'Frame scheduling integrates with the platform vsync signal. '
          'The manifold requests frame callbacks and coordinates rendering '
          'across all views within a single frame.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // Frame timeline diagram
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Frame Timeline',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B),
                ),
              ),
              SizedBox(height: 16),
              _buildTimelineRow(),
              SizedBox(height: 16),
              _buildTimelineLabels(),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Scheduling callbacks
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
                  Icon(Icons.notifications_active, color: Color(0xFF6A1B9A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Scheduling Callbacks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildCallbackRow('requestVisualUpdate()', 'Requests a new frame'),
              _buildCallbackRow('onNeedVisualUpdate', 'Callback when update needed'),
              _buildCallbackRow('onSemanticsUpdate', 'Callback for semantics changes'),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Lifecycle hooks
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.loop, color: Color(0xFF00695C), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Lifecycle Integration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('ensureSemantics', 'Semantics enabled state'),
              _buildInfoRow('createSemanticsHandle', 'Creates semantics owner'),
              _buildInfoRow('attach/detach', 'View attachment lifecycle'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineRow() {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7B1FA2),
                Color(0xFF1976D2),
                Color(0xFF388E3C),
                Color(0xFFF57C00),
                Color(0xFFD32F2F),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ],
  );
}

Widget _buildTimelineLabels() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildTimelineLabel('VSync', Color(0xFF7B1FA2)),
      _buildTimelineLabel('Build', Color(0xFF1976D2)),
      _buildTimelineLabel('Layout', Color(0xFF388E3C)),
      _buildTimelineLabel('Paint', Color(0xFFF57C00)),
      _buildTimelineLabel('Raster', Color(0xFFD32F2F)),
    ],
  );
}

Widget _buildTimelineLabel(String text, Color color) {
  return Column(
    children: [
      Container(
        width: 2,
        height: 8,
        color: color,
      ),
      SizedBox(height: 4),
      Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget _buildCallbackRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(Icons.arrow_right, size: 16, color: Color(0xFF8E24AA)),
        SizedBox(width: 4),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9C27B0),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: SEMANTICS COORDINATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSemanticsCoordinationSection() {
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
        _buildSectionTitle('Semantics Coordination', Icons.accessibility_new),
        Text(
          'The manifold coordinates semantics trees across multiple views, '
          'ensuring accessibility information is properly synchronized and '
          'delivered to assistive technologies.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // Semantics flow diagram
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Semantics Update Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                ),
              ),
              SizedBox(height: 16),
              // Flow diagram
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSemanticNode('RenderObject\nmarkNeedsSemanticsUpdate'),
                  _buildArrow(color: Color(0xFFE91E63)),
                  _buildSemanticNode('PipelineOwner\nflushSemantics'),
                ],
              ),
              SizedBox(height: 8),
              _buildArrow(vertical: true, color: Color(0xFFE91E63)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSemanticNode('SemanticsOwner\ncompute tree'),
                  _buildArrow(color: Color(0xFFE91E63)),
                  _buildSemanticNode('Platform\nAccessibility'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('SemanticsOwner', 'Manages semantics for a view'),
        _buildInfoRow('ensureSemantics', 'Enables semantic collection'),
        _buildInfoRow('semanticsHandle', 'Reference to keep semantics active'),
      ],
    ),
  );
}

Widget _buildSemanticNode(String label) {
  return Container(
    width: 110,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE91E63), width: 1.5),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFFC2185B),
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: MULTI-VIEW SCENARIO
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMultiViewScenarioSection() {
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
        _buildSectionTitle('Multi-View Scenario', Icons.window),
        Text(
          'In desktop or embedded scenarios, multiple FlutterViews can be '
          'active simultaneously. The manifold ensures they share frame '
          'timing while maintaining independent render trees.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        // Multi-view layout
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Desktop Multi-Window Example',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWindowBox('Main Window', Color(0xFF1976D2), 100, 70),
                  _buildWindowBox('Settings', Color(0xFF388E3C), 70, 50),
                  _buildWindowBox('Popup', Color(0xFFE64A19), 50, 40),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Each window has its own RenderView but shares the PipelineManifold',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF78909C),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Window 1', 'Primary application view'),
        _buildInfoRow('Window 2', 'Settings dialog view'),
        _buildInfoRow('Window 3', 'Floating popup view'),
      ],
    ),
  );
}

Widget _buildWindowBox(String label, Color color, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      children: [
        Container(
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(180),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 6,
                height: 6,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(180),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 7: API SUMMARY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildApiSummarySection() {
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
        _buildSectionTitle('API Summary', Icons.code),
        _buildApiCard(
          'Properties',
          [
            'renderViews - Iterable<RenderView>',
            'onNeedVisualUpdate - VoidCallback?',
            'onSemanticsUpdate - SemanticsUpdateCallback?',
          ],
          Color(0xFF1E88E5),
        ),
        SizedBox(height: 12),
        _buildApiCard(
          'Methods',
          [
            'requestVisualUpdate() - Triggers frame',
            'ensureSemantics(listener) - Enables semantics',
            'createSemanticsHandle() - Creates semantic ref',
          ],
          Color(0xFF43A047),
        ),
        SizedBox(height: 12),
        _buildApiCard(
          'Implementations',
          [
            'RendererBinding - Default implementation',
            'TestRenderingFlutterBinding - For tests',
          ],
          Color(0xFFE53935),
        ),
      ],
    ),
  );
}

Widget _buildApiCard(String title, List<String> items, Color color) {
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
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(color: color)),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
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
          'Coordinates rendering pipelines for multi-view applications',
        ),
        SizedBox(height: 20),
        _buildManifoldConceptSection(),
        SizedBox(height: 16),
        _buildPipelineCoordinationSection(),
        SizedBox(height: 16),
        _buildViewManagementSection(),
        SizedBox(height: 16),
        _buildSchedulingLifecycleSection(),
        SizedBox(height: 16),
        _buildSemanticsCoordinationSection(),
        SizedBox(height: 16),
        _buildMultiViewScenarioSection(),
        SizedBox(height: 16),
        _buildApiSummarySection(),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF1565C0), size: 32),
              SizedBox(height: 8),
              Text(
                'PipelineManifold Deep Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Pipeline coordination architecture visualized',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
