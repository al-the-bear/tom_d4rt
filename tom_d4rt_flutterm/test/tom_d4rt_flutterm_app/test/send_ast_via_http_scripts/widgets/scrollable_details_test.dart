// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ScrollableDetails.
///
/// ScrollableDetails is an immutable class that describes the properties of a
/// Scrollable widget. Used by ScrollBehavior to configure scrollbar decorators
/// and overscroll indicators.
///
/// Demonstrates:
/// - Tab 1 (Constructors): Default constructor, .vertical(), .horizontal()
///   convenience factories, interactive direction picker with live preview
/// - Tab 2 (Direction): AxisDirection compass, reverse mapping, axis extraction,
///   and how direction affects scroll behavior
/// - Tab 3 (Decorators): ScrollBehavior integration, decorationClipBehavior,
///   how ScrollableDetails flows into buildScrollbar/buildOverscrollIndicator

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF00838F); // Cyan 800
const Color _kAccent = Color(0xFFFFD180); // Orange A100
const Color _kSurface = Color(0xFF1A1C1E);
const Color _kCard = Color(0xFF282A2C);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3C3E);
const Color _kUp = Color(0xFF42A5F5);
const Color _kDown = Color(0xFF66BB6A);
const Color _kLeft = Color(0xFFEF5350);
const Color _kRight = Color(0xFFAB47BC);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _ScrollableDetailsDemo(),
  );
}

class _ScrollableDetailsDemo extends StatefulWidget {
  const _ScrollableDetailsDemo();
  @override
  State<_ScrollableDetailsDemo> createState() => _ScrollableDetailsDemoState();
}

class _ScrollableDetailsDemoState extends State<_ScrollableDetailsDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ScrollableDetails',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Constructors'),
            Tab(text: 'Direction'),
            Tab(text: 'Decorators'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConstructorsTab(),
          _DirectionTab(),
          _DecoratorsTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Constructors
// ═══════════════════════════════════════════════════════════════════════════════

class _ConstructorsTab extends StatefulWidget {
  const _ConstructorsTab();
  @override
  State<_ConstructorsTab> createState() => _ConstructorsTabState();
}

class _ConstructorsTabState extends State<_ConstructorsTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedCtor = 'default';
  AxisDirection _chosenDirection = AxisDirection.down;
  bool _reverse = false;
  bool _hasController = false;
  bool _hasPhysics = false;
  Clip _clip = Clip.hardEdge;

  @override
  bool get wantKeepAlive => true;

  ScrollableDetails _buildDetails() {
    switch (_selectedCtor) {
      case 'vertical':
        return ScrollableDetails.vertical(
          reverse: _reverse,
          controller: _hasController ? ScrollController() : null,
          physics: _hasPhysics ? const BouncingScrollPhysics() : null,
          decorationClipBehavior: _clip,
        );
      case 'horizontal':
        return ScrollableDetails.horizontal(
          reverse: _reverse,
          controller: _hasController ? ScrollController() : null,
          physics: _hasPhysics ? const ClampingScrollPhysics() : null,
          decorationClipBehavior: _clip,
        );
      default:
        return ScrollableDetails(
          direction: _chosenDirection,
          controller: _hasController ? ScrollController() : null,
          physics: _hasPhysics ? const BouncingScrollPhysics() : null,
          decorationClipBehavior: _clip,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final details = _buildDetails();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Constructor selector ──
          _buildSectionTitle('Choose Constructor'),
          const SizedBox(height: 8),
          Row(
            children: [
              _ctorChip('Default', 'default'),
              const SizedBox(width: 8),
              _ctorChip('.vertical', 'vertical'),
              const SizedBox(width: 8),
              _ctorChip('.horizontal', 'horizontal'),
            ],
          ),
          const SizedBox(height: 16),

          // ── Constructor signature ──
          _buildSectionTitle('Signature'),
          const SizedBox(height: 8),
          _buildCodeBlock(_ctorSignature()),
          const SizedBox(height: 16),

          // ── Parameters ──
          if (_selectedCtor == 'default') ...[
            _buildSectionTitle('direction: AxisDirection'),
            const SizedBox(height: 8),
            _buildDirectionPicker(),
            const SizedBox(height: 12),
          ] else ...[
            _buildSectionTitle('reverse'),
            const SizedBox(height: 8),
            _buildReverseSwitch(),
            const SizedBox(height: 12),
          ],

          _buildSectionTitle('Optional Parameters'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _switchRow(
                  'controller',
                  'ScrollController',
                  _hasController,
                  (v) => setState(() => _hasController = v),
                ),
                const SizedBox(height: 8),
                _switchRow(
                  'physics',
                  _selectedCtor == 'horizontal'
                      ? 'ClampingScrollPhysics'
                      : 'BouncingScrollPhysics',
                  _hasPhysics,
                  (v) => setState(() => _hasPhysics = v),
                ),
                const SizedBox(height: 8),
                _clipSelector(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Result display ──
          _buildSectionTitle('Resulting ScrollableDetails'),
          const SizedBox(height: 8),
          _buildDetailsCard(details),
          const SizedBox(height: 16),

          // ── Live preview ──
          _buildSectionTitle('Live Scrollable Preview'),
          const SizedBox(height: 8),
          _buildLivePreview(details),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'ScrollableDetails is @immutable — once created, its properties '
            'cannot change. Convenience constructors .vertical() and '
            '.horizontal() derive the AxisDirection from a reverse flag.',
          ),
        ],
      ),
    );
  }

  Widget _ctorChip(String label, String value) {
    final selected = _selectedCtor == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedCtor = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  String _ctorSignature() {
    switch (_selectedCtor) {
      case 'vertical':
        return 'const ScrollableDetails.vertical({\n'
            '  bool reverse = false,\n'
            '  ScrollController? controller,\n'
            '  ScrollPhysics? physics,\n'
            '  Clip? decorationClipBehavior,\n'
            '})';
      case 'horizontal':
        return 'const ScrollableDetails.horizontal({\n'
            '  bool reverse = false,\n'
            '  ScrollController? controller,\n'
            '  ScrollPhysics? physics,\n'
            '  Clip? decorationClipBehavior,\n'
            '})';
      default:
        return 'const ScrollableDetails({\n'
            '  required AxisDirection direction,\n'
            '  ScrollController? controller,\n'
            '  ScrollPhysics? physics,\n'
            '  Clip? decorationClipBehavior,\n'
            '})';
    }
  }

  Widget _buildDirectionPicker() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: AxisDirection.values.map((d) {
          final selected = _chosenDirection == d;
          final color = _dirColor(d);
          return GestureDetector(
            onTap: () => setState(() => _chosenDirection = d),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? color.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: selected ? color : _kSubtle),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_dirIcon(d), size: 14, color: color),
                  const SizedBox(width: 4),
                  Text(
                    d.name,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReverseSwitch() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Row(
        children: [
          Text(
            'reverse: $_reverse',
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          Switch(
            value: _reverse,
            onChanged: (v) => setState(() => _reverse = v),
            activeTrackColor: _kPrimary,
          ),
        ],
      ),
    );
  }

  Widget _switchRow(
    String name,
    String typeName,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value ? typeName : 'null',
                style: TextStyle(
                  color: value ? _kPrimary : _kDimText,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: _kPrimary,
        ),
      ],
    );
  }

  Widget _clipSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'decorationClipBehavior',
          style: TextStyle(
            color: _kAccent,
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          children: Clip.values.map((c) {
            final selected = _clip == c;
            return GestureDetector(
              onTap: () => setState(() => _clip = c),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: selected
                      ? _kPrimary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: selected ? _kAccent : _kSubtle,
                  ),
                ),
                child: Text(
                  c.name,
                  style: TextStyle(
                    color: selected ? _kAccent : _kDimText,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(ScrollableDetails details) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kPrimary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          _detailRow(
            'direction',
            details.direction.name,
            _dirColor(details.direction),
          ),
          _detailRow(
            'controller',
            details.controller != null ? 'ScrollController' : 'null',
            details.controller != null ? _kAccent : _kDimText,
          ),
          _detailRow(
            'physics',
            details.physics?.runtimeType.toString() ?? 'null',
            details.physics != null ? _kAccent : _kDimText,
          ),
          _detailRow(
            'clipBehavior',
            details.decorationClipBehavior?.name ?? 'null',
            _kDimText,
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLivePreview(ScrollableDetails details) {
    final isHorizontal = details.direction == AxisDirection.left ||
        details.direction == AxisDirection.right;
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            color: _kPrimary.withValues(alpha: 0.15),
            child: Row(
              children: [
                Icon(
                  _dirIcon(details.direction),
                  size: 14,
                  color: _dirColor(details.direction),
                ),
                const SizedBox(width: 6),
                Text(
                  '${isHorizontal ? "Horizontal" : "Vertical"} scroll '
                  '(${details.direction.name})',
                  style: const TextStyle(color: _kDimText, fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: isHorizontal
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: details.direction == AxisDirection.left,
                    controller: ScrollController(),
                    physics: details.physics,
                    itemCount: 20,
                    itemBuilder: (_, i) => Container(
                      width: 80,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _dirColor(details.direction)
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _dirColor(details.direction)
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: _dirColor(details.direction),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: details.direction == AxisDirection.up,
                    controller: ScrollController(),
                    physics: details.physics,
                    itemCount: 30,
                    itemBuilder: (_, i) => Container(
                      height: 32,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _dirColor(details.direction)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Item $i',
                        style: TextStyle(
                          color: _dirColor(details.direction),
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Direction
// ═══════════════════════════════════════════════════════════════════════════════

class _DirectionTab extends StatefulWidget {
  const _DirectionTab();
  @override
  State<_DirectionTab> createState() => _DirectionTabState();
}

class _DirectionTabState extends State<_DirectionTab>
    with AutomaticKeepAliveClientMixin {
  AxisDirection _highlighted = AxisDirection.down;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Compass ──
          _buildSectionTitle('AxisDirection Compass'),
          const SizedBox(height: 8),
          _buildCompass(),
          const SizedBox(height: 16),

          // ── Direction details ──
          _buildSectionTitle('Direction Properties'),
          const SizedBox(height: 8),
          _buildDirectionDetail(_highlighted),
          const SizedBox(height: 16),

          // ── Axis mapping ──
          _buildSectionTitle('Direction → Axis Mapping'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _mappingRow('AxisDirection.up', 'Axis.vertical', _kUp),
                _mappingRow('AxisDirection.down', 'Axis.vertical', _kDown),
                _mappingRow('AxisDirection.left', 'Axis.horizontal', _kLeft),
                _mappingRow('AxisDirection.right', 'Axis.horizontal', _kRight),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Reverse mapping ──
          _buildSectionTitle('Reverse Direction Logic'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Convenience constructors derive direction:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _reverseRow(
                  '.vertical(reverse: false)',
                  'AxisDirection.down',
                  _kDown,
                ),
                _reverseRow(
                  '.vertical(reverse: true)',
                  'AxisDirection.up',
                  _kUp,
                ),
                _reverseRow(
                  '.horizontal(reverse: false)',
                  'AxisDirection.right',
                  _kRight,
                ),
                _reverseRow(
                  '.horizontal(reverse: true)',
                  'AxisDirection.left',
                  _kLeft,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Growth direction ──
          _buildSectionTitle('Direction & Growth'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _growthRow(
                  'down / right',
                  'GrowthDirection.forward',
                  'Content grows in reading direction',
                  _kDown,
                ),
                const SizedBox(height: 6),
                _growthRow(
                  'up / left',
                  'GrowthDirection.reverse',
                  'Content grows against reading direction',
                  _kUp,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Interactive scroll test ──
          _buildSectionTitle('Interactive Scroll Test'),
          const SizedBox(height: 8),
          _buildScrollTest(),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'axisDirectionToAxis() converts AxisDirection to Axis. '
            'flipAxisDirection() returns the opposite direction. '
            'These utilities simplify direction-aware layout logic.',
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          // Up
          _compassButton(AxisDirection.up),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _compassButton(AxisDirection.left),
              const SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _dirColor(_highlighted).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _dirColor(_highlighted),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  _dirIcon(_highlighted),
                  color: _dirColor(_highlighted),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              _compassButton(AxisDirection.right),
            ],
          ),
          const SizedBox(height: 4),
          _compassButton(AxisDirection.down),
        ],
      ),
    );
  }

  Widget _compassButton(AxisDirection dir) {
    final selected = _highlighted == dir;
    final color = _dirColor(dir);
    return GestureDetector(
      onTap: () => setState(() => _highlighted = dir),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: 36,
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? color : _kSubtle,
            width: selected ? 2 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          dir.name,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _buildDirectionDetail(AxisDirection dir) {
    final color = _dirColor(dir);
    final isVertical =
        dir == AxisDirection.up || dir == AxisDirection.down;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(_dirIcon(dir), color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                'AxisDirection.${dir.name}',
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _propRow('axis', isVertical ? 'Axis.vertical' : 'Axis.horizontal'),
          _propRow('isReverse', (dir == AxisDirection.up || dir == AxisDirection.left).toString()),
          _propRow(
            'flipDirection',
            _flipDir(dir).name,
          ),
          _propRow(
            'growthDirection',
            (dir == AxisDirection.down || dir == AxisDirection.right)
                ? 'forward'
                : 'reverse',
          ),
        ],
      ),
    );
  }

  AxisDirection _flipDir(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return AxisDirection.down;
      case AxisDirection.down:
        return AxisDirection.up;
      case AxisDirection.left:
        return AxisDirection.right;
      case AxisDirection.right:
        return AxisDirection.left;
    }
  }

  Widget _mappingRow(String from, String to, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              from,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 12, color: _kDimText),
          const SizedBox(width: 8),
          Text(
            to,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reverseRow(String ctor, String result, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              ctor,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 10, color: _kDimText),
          const SizedBox(width: 6),
          Expanded(
            flex: 2,
            child: Text(
              result,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _growthRow(String dirs, String growth, String desc, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$dirs → $growth',
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScrollTest() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: _kSubtle),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _miniScroll('down', AxisDirection.down, _kDown),
          _miniScroll('up', AxisDirection.up, _kUp),
          _miniScroll('right', AxisDirection.right, _kRight),
          _miniScroll('left', AxisDirection.left, _kLeft),
        ],
      ),
    );
  }

  Widget _miniScroll(String label, AxisDirection dir, Color color) {
    final isH =
        dir == AxisDirection.left || dir == AxisDirection.right;
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            color: color.withValues(alpha: 0.1),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: isH
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: dir == AxisDirection.left,
                    itemCount: 15,
                    itemBuilder: (_, i) => Container(
                      width: 28,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: dir == AxisDirection.up,
                    itemCount: 20,
                    itemBuilder: (_, i) => Container(
                      height: 18,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      color: color.withValues(alpha: 0.08),
                      alignment: Alignment.center,
                      child: Text(
                        '$i',
                        style: TextStyle(color: color, fontSize: 8),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Decorators
// ═══════════════════════════════════════════════════════════════════════════════

class _DecoratorsTab extends StatefulWidget {
  const _DecoratorsTab();
  @override
  State<_DecoratorsTab> createState() => _DecoratorsTabState();
}

class _DecoratorsTabState extends State<_DecoratorsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── ScrollBehavior integration ──
          _buildSectionTitle('ScrollBehavior Integration'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ScrollBehavior uses ScrollableDetails to configure:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _decoratorRow(
                  Icons.swap_vert,
                  'buildScrollbar()',
                  'Adds platform scrollbar with correct axis',
                  _kDown,
                ),
                const SizedBox(height: 6),
                _decoratorRow(
                  Icons.flare,
                  'buildOverscrollIndicator()',
                  'Adds overscroll glow/stretch effect',
                  _kUp,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Code flow ──
          _buildSectionTitle('Data Flow'),
          const SizedBox(height: 8),
          _buildFlowDiagram(),
          const SizedBox(height: 16),

          // ── decorationClipBehavior ──
          _buildSectionTitle('decorationClipBehavior'),
          const SizedBox(height: 8),
          _buildClipExplainer(),
          const SizedBox(height: 16),

          // ── Clip comparison ──
          _buildSectionTitle('Clip Behavior Visual'),
          const SizedBox(height: 8),
          _buildClipComparison(),
          const SizedBox(height: 16),

          // ── Two-dimensional scrolling ──
          _buildSectionTitle('TwoDimensionalScrollable Usage'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TwoDimensionalScrollable creates two ScrollableDetails:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _twoScrollRow(
                  'Vertical',
                  'ScrollableDetails.vertical()',
                  _kDown,
                ),
                _twoScrollRow(
                  'Horizontal',
                  'ScrollableDetails.horizontal()',
                  _kRight,
                ),
                const SizedBox(height: 8),
                _buildCodeBlock(
                  'TwoDimensionalScrollable(\n'
                  '  // verticalDetails used for vertical\n'
                  '  // scrollbar and overscroll\n'
                  '  verticalDetails: ScrollableDetails\n'
                  '    .vertical(),\n'
                  '  // horizontalDetails for horizontal\n'
                  '  horizontalDetails: ScrollableDetails\n'
                  '    .horizontal(),\n'
                  '  viewportBuilder: (context,\n'
                  '    verticalPosition,\n'
                  '    horizontalPosition) {\n'
                  '    return myViewport;\n'
                  '  },\n'
                  ')',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Properties summary ──
          _buildSectionTitle('Properties Summary'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _summaryRow('direction', 'AxisDirection',
                    'required — which way scrolling goes'),
                _summaryRow('controller', 'ScrollController?',
                    'optional — position management'),
                _summaryRow('physics', 'ScrollPhysics?',
                    'optional — bounce/clamp behavior'),
                _summaryRow('decorationClipBehavior', 'Clip?',
                    'optional — clip for decorators'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'ScrollableDetails is the bridge between Scrollable and '
            'ScrollBehavior. When CustomScrollView creates its Scrollable, '
            'it packages direction, controller, and physics into '
            'ScrollableDetails for the behavior to decorate.',
          ),
        ],
      ),
    );
  }

  Widget _decoratorRow(
    IconData icon,
    String method,
    String desc,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                method,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlowDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _flowRow('Scrollable widget', _kDimText),
          _flowArrow(),
          _flowRow('Creates ScrollableDetails', _kPrimary),
          _flowArrow(),
          _flowRow('ScrollBehavior.buildScrollbar(details)', _kAccent),
          _flowArrow(),
          _flowRow('ScrollBehavior.buildOverscrollIndicator(details)', _kAccent),
          _flowArrow(),
          _flowRow('Decorated child widget', _kDown),
        ],
      ),
    );
  }

  Widget _flowRow(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 12,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildClipExplainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controls how scroll decorators clip their content:',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          _clipRow('Clip.none', 'No clipping — overscroll visible'),
          _clipRow('Clip.hardEdge', 'Sharp clip — fast'),
          _clipRow('Clip.antiAlias', 'Smooth clip — slower'),
          _clipRow('Clip.antiAliasWithSaveLayer', 'Full quality — slowest'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: _kRight.withValues(alpha: 0.08),
            child: const Text(
              'Note: This does NOT affect Viewport.clipBehavior. '
              'It only applies to overscroll indicators and scrollbars.',
              style: TextStyle(color: _kDimText, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipRow(String name, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              name,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: _kDimText, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClipComparison() {
    return Row(
      children: [
        _clipDemo('hardEdge', Clip.hardEdge),
        const SizedBox(width: 8),
        _clipDemo('antiAlias', Clip.antiAlias),
      ],
    );
  }

  Widget _clipDemo(String label, Clip clip) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kSubtle),
        ),
        clipBehavior: clip,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              color: _kPrimary.withValues(alpha: 0.15),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (_, i) => Container(
                  height: 20,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  color: _kPrimary.withValues(alpha: 0.1),
                  alignment: Alignment.center,
                  child: Text(
                    'Row $i',
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _twoScrollRow(String axis, String ctor, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: Text(
              axis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ctor,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              name,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    color: _kPrimary,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: _kDimText, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Color _dirColor(AxisDirection d) {
  switch (d) {
    case AxisDirection.up:
      return _kUp;
    case AxisDirection.down:
      return _kDown;
    case AxisDirection.left:
      return _kLeft;
    case AxisDirection.right:
      return _kRight;
  }
}

IconData _dirIcon(AxisDirection d) {
  switch (d) {
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

Widget _propRow(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: const TextStyle(
              color: _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
