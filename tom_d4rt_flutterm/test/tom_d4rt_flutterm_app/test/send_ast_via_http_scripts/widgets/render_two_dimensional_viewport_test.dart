// Deep visual test for RenderTwoDimensionalViewport
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show CacheExtentStyle;

/// Deep visual exploration of RenderTwoDimensionalViewport
/// An abstract viewport that scrolls in two dimensions simultaneously.
///
/// RenderTwoDimensionalViewport extends RenderBox and implements RenderAbstractViewport:
/// - horizontalOffset and verticalOffset for independent scroll positions
/// - horizontalAxisDirection and verticalAxisDirection for scroll direction
/// - TwoDimensionalChildDelegate provides children on demand
/// - mainAxis determines primary scroll axis
/// - Lazy child instantiation via TwoDimensionalChildManager
/// - cacheExtent for preloading off-screen children
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RenderTwoDimensionalViewportDemo(),
  );
}

// =============================================================================
// PALETTE: DeepPurple 700 / Cyan 300
// =============================================================================
const Color _kPrimary = Color(0xFF512DA8); // DeepPurple 700
const Color _kAccent = Color(0xFF4DD0E1); // Cyan 300
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kHorizontal = Color(0xFF66BB6A);
const Color _kVertical = Color(0xFFFFCA28);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RenderTwoDimensionalViewportDemo extends StatefulWidget {
  @override
  State<_RenderTwoDimensionalViewportDemo> createState() =>
      _RenderTwoDimensionalViewportDemoState();
}

class _RenderTwoDimensionalViewportDemoState
    extends State<_RenderTwoDimensionalViewportDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RenderTwoDimensionalViewport Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.grid_view), text: '2D Grid Lab'),
            Tab(icon: Icon(Icons.settings), text: 'Configuration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _TwoDGridLabTab(),
          _ConfigurationTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildScrollOffsetsSection(),
          SizedBox(height: 24),
          _buildAxisDirectionsSection(),
          SizedBox(height: 24),
          _buildDelegateSection(),
          SizedBox(height: 24),
          _buildCacheExtentSection(),
          SizedBox(height: 24),
          _buildUseCasesSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.view_quilt, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'RenderTwoDimensionalViewport',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'An abstract viewport that scrolls in two dimensions simultaneously, '
            'enabling efficient rendering of large 2D grids like spreadsheets, '
            'calendars, and game worlds with lazy child instantiation.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Capabilities:',
                  style: TextStyle(
                    color: _kAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildFeatureRow(Icons.swap_horiz, 'Independent horizontal & vertical scrolling'),
                _buildFeatureRow(Icons.view_module, 'Lazy child instantiation on demand'),
                _buildFeatureRow(Icons.cached, 'Cache extent for preloading'),
                _buildFeatureRow(Icons.directions, 'Configurable axis directions'),
                _buildFeatureRow(Icons.settings, 'Delegate pattern for child provision'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchySection() {
    return _TheoryCard(
      title: 'Class Hierarchy',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RenderTwoDimensionalViewport extends RenderBox and implements RenderAbstractViewport:',
            style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'RenderObject', desc: 'Base render tree node'),
                _HierarchyItem(level: 1, name: 'RenderBox', desc: 'Box protocol'),
                _HierarchyItem(level: 2, name: 'RenderTwoDimensionalViewport', desc: '2D scrolling viewport', isHighlighted: true),
                SizedBox(height: 12),
                Text(
                  'Implements:',
                  style: TextStyle(color: _kTextSecondary, fontSize: 12),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'RenderAbstractViewport',
                    style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildInfoBox(
            'RenderAbstractViewport provides methods for revealing children '
            '(getOffsetToReveal) and finding child offset from parent coordinates.',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorSection() {
    return _TheoryCard(
      title: 'Constructor Parameters',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Text(
              '''RenderTwoDimensionalViewport({
  required ViewportOffset horizontalOffset,
  required AxisDirection horizontalAxisDirection,
  required ViewportOffset verticalOffset,
  required AxisDirection verticalAxisDirection,
  required TwoDimensionalChildDelegate delegate,
  required Axis mainAxis,
  required TwoDimensionalChildManager childManager,
  double? cacheExtent,
  CacheExtentStyle? cacheExtentStyle,
  Clip clipBehavior = Clip.hardEdge,
})''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 16),
          _ParameterTable(
            parameters: [
              _ParameterInfo('horizontalOffset', 'ViewportOffset', 'Controls horizontal scroll position'),
              _ParameterInfo('horizontalAxisDirection', 'AxisDirection', 'Direction of horizontal axis (left/right)'),
              _ParameterInfo('verticalOffset', 'ViewportOffset', 'Controls vertical scroll position'),
              _ParameterInfo('verticalAxisDirection', 'AxisDirection', 'Direction of vertical axis (up/down)'),
              _ParameterInfo('delegate', 'TwoDimensionalChildDelegate', 'Provides children for indices'),
              _ParameterInfo('mainAxis', 'Axis', 'Primary scroll axis'),
              _ParameterInfo('childManager', 'TwoDimensionalChildManager', 'Creates/removes child RenderObjects'),
              _ParameterInfo('cacheExtent', 'double?', 'Off-screen preload buffer in pixels'),
              _ParameterInfo('cacheExtentStyle', 'CacheExtentStyle?', 'How cacheExtent is interpreted'),
              _ParameterInfo('clipBehavior', 'Clip', 'How to clip children at viewport edges'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollOffsetsSection() {
    return _TheoryCard(
      title: 'Scroll Offsets',
      icon: Icons.swap_calls,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _OffsetCard(
                  title: 'horizontalOffset',
                  icon: Icons.swap_horiz,
                  color: _kHorizontal,
                  description: 'ViewportOffset controlling left-right scroll position. '
                      'Listen for changes via addListener.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _OffsetCard(
                  title: 'verticalOffset',
                  icon: Icons.swap_vert,
                  color: _kVertical,
                  description: 'ViewportOffset controlling up-down scroll position. '
                      'Each offset can be scrolled independently.',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ViewportOffset Properties:',
                  style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _PropertyRow('pixels', 'Current scroll position in pixels'),
                _PropertyRow('minScrollExtent', 'Minimum scrollable position'),
                _PropertyRow('maxScrollExtent', 'Maximum scrollable position'),
                _PropertyRow('userScrollDirection', 'Direction user is scrolling'),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildInfoBox(
            'When either offset changes, the viewport relays out to show '
            'different children. Implement with ScrollController or custom ViewportOffset.',
            Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildAxisDirectionsSection() {
    return _TheoryCard(
      title: 'Axis Directions',
      icon: Icons.compass_calibration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Axis directions control which way content flows:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _AxisDirectionCard(
                  title: 'Horizontal',
                  directions: [
                    _DirectionInfo('AxisDirection.right', 'Content flows left-to-right', Icons.arrow_forward),
                    _DirectionInfo('AxisDirection.left', 'Content flows right-to-left', Icons.arrow_back),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _AxisDirectionCard(
                  title: 'Vertical',
                  directions: [
                    _DirectionInfo('AxisDirection.down', 'Content flows top-to-bottom', Icons.arrow_downward),
                    _DirectionInfo('AxisDirection.up', 'Content flows bottom-to-top', Icons.arrow_upward),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: _kAccent, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Assertions ensure horizontal uses left/right and vertical uses up/down.',
                    style: TextStyle(color: _kTextSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDelegateSection() {
    return _TheoryCard(
      title: 'TwoDimensionalChildDelegate',
      icon: Icons.extension,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The delegate provides children on demand during layout:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''abstract class TwoDimensionalChildDelegate {
  /// Build widget for the given row/column index
  Widget? build(BuildContext context, ChildVicinity vicinity);
  
  /// Maximum row index (exclusive)
  int? get maxYIndex;
  
  /// Maximum column index (exclusive)  
  int? get maxXIndex;
  
  /// Called when delegate should rebuild
  bool shouldRebuild(TwoDimensionalChildDelegate oldDelegate);
}''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16),
          _DelegateMethodRow(
            name: 'build()',
            description: 'Returns widget for cell at (xIndex, yIndex). Return null for no child.',
          ),
          _DelegateMethodRow(
            name: 'maxXIndex / maxYIndex',
            description: 'Bounds of the 2D grid. null means infinite.',
          ),
          _DelegateMethodRow(
            name: 'shouldRebuild()',
            description: 'Return true if delegate data changed and children need rebuild.',
          ),
          SizedBox(height: 12),
          _buildInfoBox(
            'ChildVicinity contains xIndex and yIndex, representing the cell position. '
            'The viewport calls build() only for visible cells plus cache extent.',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildCacheExtentSection() {
    return _TheoryCard(
      title: 'Cache Extent & Child Management',
      icon: Icons.cached,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertyExplainer(
            name: 'cacheExtent',
            type: 'double?',
            description: 'Number of pixels beyond visible area to preload children. '
                'Improves scrolling smoothness by preparing off-screen content.',
            codeExample: '''// Preload 250 pixels in each direction
viewport.cacheExtent = 250.0;
// Children just outside viewport are built''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'cacheExtentStyle',
            type: 'CacheExtentStyle',
            description: 'How to interpret cacheExtent value:',
            codeExample: '''CacheExtentStyle.pixel
  // cacheExtent is raw pixel count

CacheExtentStyle.viewport
  // cacheExtent is multiplied by viewport size''',
          ),
          Divider(color: _kDivider, height: 32),
          Text(
            'TwoDimensionalChildManager',
            style: TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Manages lifecycle of child RenderBoxes. Creates children when they '
            'enter cache/visible area, removes them when they leave. Supports '
            'keep-alive to prevent disposal of expensive children.',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Common Use Cases',
      icon: Icons.apps,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.table_chart,
            title: 'Spreadsheets',
            description: 'Large tables with thousands of rows and columns '
                'that scroll smoothly in both directions.',
          ),
          _UseCaseItem(
            icon: Icons.calendar_month,
            title: 'Calendar Views',
            description: 'Year/month grids with horizontal days and vertical '
                'weeks/months, supporting drag selection.',
          ),
          _UseCaseItem(
            icon: Icons.map,
            title: 'Tile-Based Maps',
            description: 'Infinite scrolling worlds where tiles are loaded '
                'on demand as the user navigates.',
          ),
          _UseCaseItem(
            icon: Icons.image,
            title: 'Photo Grids',
            description: 'Large image galleries with efficient memory usage '
                'via lazy loading and cache extent.',
          ),
          _UseCaseItem(
            icon: Icons.dashboard,
            title: 'Dashboards',
            description: 'Complex dashboard layouts with fixed headers and '
                'scrollable content areas.',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kAccent, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: 2D GRID LAB
// =============================================================================
class _TwoDGridLabTab extends StatefulWidget {
  @override
  State<_TwoDGridLabTab> createState() => _TwoDGridLabTabState();
}

class _TwoDGridLabTabState extends State<_TwoDGridLabTab> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  int _rows = 100;
  int _columns = 100;
  double _cellSize = 80;

  @override
  void initState() {
    super.initState();
    _horizontalController.addListener(_onHorizontalScroll);
    _verticalController.addListener(_onVerticalScroll);
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  double _hOffset = 0;
  double _vOffset = 0;

  void _onHorizontalScroll() {
    setState(() => _hOffset = _horizontalController.offset);
  }

  void _onVerticalScroll() {
    setState(() => _vOffset = _verticalController.offset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stats bar
        Container(
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Row(
            children: [
              _StatBadge('Rows', '$_rows', _kVertical),
              SizedBox(width: 12),
              _StatBadge('Cols', '$_columns', _kHorizontal),
              SizedBox(width: 12),
              _StatBadge('Cell', '${_cellSize.toInt()}px', _kAccent),
              Spacer(),
              _StatBadge('H', '${_hOffset.toInt()}', _kHorizontal),
              SizedBox(width: 8),
              _StatBadge('V', '${_vOffset.toInt()}', _kVertical),
            ],
          ),
        ),
        // Sliders
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: _kCardBg,
          child: Row(
            children: [
              Text('Size:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              Expanded(
                child: Slider(
                  value: _cellSize,
                  min: 40,
                  max: 150,
                  activeColor: _kAccent,
                  onChanged: (v) => setState(() => _cellSize = v),
                ),
              ),
              SizedBox(width: 16),
              Text('Grid:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              Expanded(
                child: Slider(
                  value: _rows.toDouble(),
                  min: 10,
                  max: 500,
                  activeColor: _kPrimary,
                  onChanged: (v) => setState(() {
                    _rows = v.toInt();
                    _columns = v.toInt();
                  }),
                ),
              ),
            ],
          ),
        ),
        // 2D scrollable grid simulation
        Expanded(
          child: _build2DGrid(),
        ),
        // Legend
        Container(
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: _kAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'Scroll horizontally & vertically. Cell colors indicate position.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _build2DGrid() {
    return Container(
      color: _kCardBg,
      child: Scrollbar(
        controller: _verticalController,
        child: Scrollbar(
          controller: _horizontalController,
          notificationPredicate: (notification) => notification.depth == 1,
          child: SingleChildScrollView(
            controller: _verticalController,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: _buildGridContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_rows, (row) {
        return Row(
          children: List.generate(_columns, (col) {
            return _GridCell(
              row: row,
              col: col,
              size: _cellSize,
            );
          }),
        );
      }),
    );
  }
}

class _GridCell extends StatelessWidget {
  final int row;
  final int col;
  final double size;

  const _GridCell({
    required this.row,
    required this.col,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Color based on position
    final hue = ((row * 3 + col * 5) % 360).toDouble();
    final color = HSLColor.fromAHSL(1, hue, 0.6, 0.4).toColor();

    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '$row,$col',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBadge(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: color.withOpacity(0.8), fontSize: 11),
          ),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: CONFIGURATION
// =============================================================================
class _ConfigurationTab extends StatefulWidget {
  @override
  State<_ConfigurationTab> createState() => _ConfigurationTabState();
}

class _ConfigurationTabState extends State<_ConfigurationTab> {
  AxisDirection _hDirection = AxisDirection.right;
  AxisDirection _vDirection = AxisDirection.down;
  Axis _mainAxis = Axis.vertical;
  double _cacheExtent = 250;
  CacheExtentStyle _cacheStyle = CacheExtentStyle.pixel;
  Clip _clipBehavior = Clip.hardEdge;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAxisDirectionConfig(),
          SizedBox(height: 16),
          _buildMainAxisConfig(),
          SizedBox(height: 16),
          _buildCacheExtentConfig(),
          SizedBox(height: 16),
          _buildClipBehaviorConfig(),
          SizedBox(height: 24),
          _buildConfigPreview(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAxisDirectionConfig() {
    return _ConfigCard(
      title: 'Axis Directions',
      icon: Icons.compass_calibration,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DirectionSelector(
                  label: 'Horizontal',
                  value: _hDirection,
                  options: [AxisDirection.left, AxisDirection.right],
                  onChanged: (v) => setState(() => _hDirection = v),
                  color: _kHorizontal,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _DirectionSelector(
                  label: 'Vertical',
                  value: _vDirection,
                  options: [AxisDirection.up, AxisDirection.down],
                  onChanged: (v) => setState(() => _vDirection = v),
                  color: _kVertical,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _DirectionIndicator(
                  horizontal: _hDirection,
                  vertical: _vDirection,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Content flows ${_hDirection.name} horizontally and '
                    '${_vDirection.name} vertically.',
                    style: TextStyle(color: _kTextSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainAxisConfig() {
    return _ConfigCard(
      title: 'Main Axis',
      icon: Icons.straighten,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Primary scroll axis determines layout priority:',
            style: TextStyle(color: _kTextPrimary),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _AxisButton(
                  label: 'Vertical',
                  icon: Icons.swap_vert,
                  isSelected: _mainAxis == Axis.vertical,
                  onTap: () => setState(() => _mainAxis = Axis.vertical),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _AxisButton(
                  label: 'Horizontal',
                  icon: Icons.swap_horiz,
                  isSelected: _mainAxis == Axis.horizontal,
                  onTap: () => setState(() => _mainAxis = Axis.horizontal),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _mainAxis == Axis.vertical
                  ? 'Vertical main axis: Layout fills rows first, then columns.'
                  : 'Horizontal main axis: Layout fills columns first, then rows.',
              style: TextStyle(color: _kTextSecondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheExtentConfig() {
    return _ConfigCard(
      title: 'Cache Extent',
      icon: Icons.cached,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Extent: ${_cacheExtent.toInt()}',
                      style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _cacheExtent,
                      min: 0,
                      max: 500,
                      activeColor: _kAccent,
                      onChanged: (v) => setState(() => _cacheExtent = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Cache Extent Style:',
            style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _StyleButton(
                  label: 'Pixel',
                  description: 'Raw pixels',
                  isSelected: _cacheStyle == CacheExtentStyle.pixel,
                  onTap: () => setState(() => _cacheStyle = CacheExtentStyle.pixel),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StyleButton(
                  label: 'Viewport',
                  description: '× viewport size',
                  isSelected: _cacheStyle == CacheExtentStyle.viewport,
                  onTap: () => setState(() => _cacheStyle = CacheExtentStyle.viewport),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClipBehaviorConfig() {
    return _ConfigCard(
      title: 'Clip Behavior',
      icon: Icons.crop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How to clip children at viewport edges:',
            style: TextStyle(color: _kTextPrimary),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: Clip.values.map((clip) {
              final isSelected = _clipBehavior == clip;
              return GestureDetector(
                onTap: () => setState(() => _clipBehavior = clip),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? _kPrimary : _kSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? _kAccent : _kDivider,
                    ),
                  ),
                  child: Text(
                    clip.name,
                    style: TextStyle(
                      color: isSelected ? _kAccent : _kTextSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12),
          _ClipDescription(clip: _clipBehavior),
        ],
      ),
    );
  }

  Widget _buildConfigPreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Configuration Code',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''RenderTwoDimensionalViewport(
  horizontalAxisDirection: AxisDirection.${_hDirection.name},
  verticalAxisDirection: AxisDirection.${_vDirection.name},
  mainAxis: Axis.${_mainAxis.name},
  cacheExtent: ${_cacheExtent.toInt()}.0,
  cacheExtentStyle: CacheExtentStyle.${_cacheStyle.name},
  clipBehavior: Clip.${_clipBehavior.name},
  // ... other required params
)''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfigCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _ConfigCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _DirectionSelector extends StatelessWidget {
  final String label;
  final AxisDirection value;
  final List<AxisDirection> options;
  final ValueChanged<AxisDirection> onChanged;
  final Color color;

  const _DirectionSelector({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        ...options.map((dir) {
          final isSelected = value == dir;
          return GestureDetector(
            onTap: () => onChanged(dir),
            child: Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.2) : _kSurface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? color : _kDivider,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getDirectionIcon(dir),
                    color: isSelected ? color : _kTextSecondary,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    dir.name,
                    style: TextStyle(
                      color: isSelected ? color : _kTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  IconData _getDirectionIcon(AxisDirection dir) {
    switch (dir) {
      case AxisDirection.up:
        return Icons.arrow_upward;
      case AxisDirection.down:
        return Icons.arrow_downward;
      case AxisDirection.left:
        return Icons.arrow_back;
      case AxisDirection.right:
        return Icons.arrow_forward;
    }
  }
}

class _DirectionIndicator extends StatelessWidget {
  final AxisDirection horizontal;
  final AxisDirection vertical;

  const _DirectionIndicator({
    required this.horizontal,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Stack(
        children: [
          // Center dot
          Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _kAccent,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          // Horizontal arrow
          Positioned(
            left: horizontal == AxisDirection.right ? 48 : 8,
            top: 32,
            child: Icon(
              horizontal == AxisDirection.right ? Icons.arrow_forward : Icons.arrow_back,
              color: _kHorizontal,
              size: 20,
            ),
          ),
          // Vertical arrow
          Positioned(
            left: 32,
            top: vertical == AxisDirection.down ? 48 : 8,
            child: Icon(
              vertical == AxisDirection.down ? Icons.arrow_downward : Icons.arrow_upward,
              color: _kVertical,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _AxisButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? _kPrimary.withOpacity(0.3) : _kSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? _kAccent : _kDivider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? _kAccent : _kTextSecondary,
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _kAccent : _kTextSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StyleButton extends StatelessWidget {
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _StyleButton({
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? _kPrimary.withOpacity(0.3) : _kSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? _kAccent : _kDivider,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _kAccent : _kTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: _kTextSecondary, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClipDescription extends StatelessWidget {
  final Clip clip;

  const _ClipDescription({required this.clip});

  String get _description {
    switch (clip) {
      case Clip.none:
        return 'No clipping. Children may paint outside viewport bounds. Fastest option.';
      case Clip.hardEdge:
        return 'Sharp clipping at viewport edges. Fast and commonly used.';
      case Clip.antiAlias:
        return 'Anti-aliased clipping. Smoother edges but slightly slower.';
      case Clip.antiAliasWithSaveLayer:
        return 'Anti-aliased with save layer. Smoothest but slowest, needed for opacity.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: _kAccent, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              _description,
              style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _kTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _HierarchyItem extends StatelessWidget {
  final int level;
  final String name;
  final String desc;
  final bool isHighlighted;

  const _HierarchyItem({
    required this.level,
    required this.name,
    required this.desc,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: level > 0 ? 8 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: _kDivider),
                  bottom: BorderSide(color: _kDivider),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isHighlighted ? _kAccent : _kDivider,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              desc,
              style: TextStyle(color: _kTextSecondary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParameterInfo {
  final String name;
  final String type;
  final String desc;

  _ParameterInfo(this.name, this.type, this.desc);
}

class _ParameterTable extends StatelessWidget {
  final List<_ParameterInfo> parameters;

  const _ParameterTable({required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parameters
          .map((p) => Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: _kDivider.withOpacity(0.5))),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              color: _kAccent,
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            p.type,
                            style: TextStyle(
                              color: _kTextSecondary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p.desc,
                        style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _OffsetCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  const _OffsetCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _PropertyRow extends StatelessWidget {
  final String name;
  final String description;

  const _PropertyRow(this.name, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              name,
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(color: _kTextSecondary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectionInfo {
  final String name;
  final String description;
  final IconData icon;

  _DirectionInfo(this.name, this.description, this.icon);
}

class _AxisDirectionCard extends StatelessWidget {
  final String title;
  final List<_DirectionInfo> directions;

  const _AxisDirectionCard({
    required this.title,
    required this.directions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8),
          ...directions.map((d) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(d.icon, color: _kTextSecondary, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.name,
                            style: TextStyle(
                              color: _kTextPrimary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            d.description,
                            style: TextStyle(color: _kTextSecondary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _DelegateMethodRow extends StatelessWidget {
  final String name;
  final String description;

  const _DelegateMethodRow({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                description,
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyExplainer extends StatelessWidget {
  final String name;
  final String type;
  final String description;
  final String codeExample;

  const _PropertyExplainer({
    required this.name,
    required this.type,
    required this.description,
    required this.codeExample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: _kAccent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                color: _kTextSecondary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: _kTextPrimary, height: 1.5),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            codeExample,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isLast;

  const _UseCaseItem({
    required this.icon,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kAccent, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
