import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _Pal {
  final String name;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color ink;
  final Color accent;
  final Color muted;

  const _Pal({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.ink,
    required this.accent,
    required this.muted,
  });
}

const _pals = <_Pal>[
  _Pal(
    name: 'Teal / Amber',
    primary: Color(0xFF00695C),
    secondary: Color(0xFFFFA000),
    surface: Color(0xFFE0F2F1),
    ink: Color(0xFF1B2A2A),
    accent: Color(0xFF00BFA5),
    muted: Color(0xFF6B7C7C),
  ),
  _Pal(
    name: 'Orange / Blue Grey',
    primary: Color(0xFFE65100),
    secondary: Color(0xFF455A64),
    surface: Color(0xFFFBE9E7),
    ink: Color(0xFF2C2623),
    accent: Color(0xFFFF6D00),
    muted: Color(0xFF7D6F67),
  ),
  _Pal(
    name: 'Indigo / Lime',
    primary: Color(0xFF283593),
    secondary: Color(0xFF9E9D24),
    surface: Color(0xFFE8EAF6),
    ink: Color(0xFF1E2240),
    accent: Color(0xFF536DFE),
    muted: Color(0xFF6C719B),
  ),
];

dynamic build(BuildContext context) {
  return const _ShrinkWrapWorkshop();
}

class _ShrinkWrapWorkshop extends StatefulWidget {
  const _ShrinkWrapWorkshop();

  @override
  State<_ShrinkWrapWorkshop> createState() => _ShrinkWrapWorkshopState();
}

class _ShrinkWrapWorkshopState extends State<_ShrinkWrapWorkshop> {
  int _scenario = 0;
  int _palette = 0;
  bool _verbose = false;

  int _compareItemCount = 6;
  int _nestedGroupCount = 3;
  int _galleryListCount = 5;
  int _dialogItemCount = 5;
  int _sheetItemCount = 7;
  int _dynamicItemCount = 4;

  bool _showGridInGallery = true;
  bool _showFooterSliver = true;
  bool _useListViewVariant = true;

  double _normalViewportHeight = 0;
  double _shrinkViewportHeight = 0;
  double _dynamicShrinkHeight = 0;

  static const _scenarioTitles = <String>[
    '1 · Normal vs Shrink-Wrap',
    '2 · Nested Scroll Contexts',
    '3 · Sliver Types Gallery',
    '4 · Dialog & Bottom Sheet',
    '5 · Dynamic Content Growth',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _pals[_palette];

  void _log(String msg) {
    if (_verbose) {
      debugPrint('[ShrinkWrapWorkshop] $msg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildControlRail(),
            Expanded(child: _buildScenarioBody()),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_p.primary, _p.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.height_rounded, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Text(
                'Shrink-Wrap Workshop',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              _badge(
                text: 'RenderShrinkWrappingViewport',
                bg: Colors.white.withValues(alpha: 0.22),
                fg: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This demo shows when and why shrinkWrap changes viewport sizing. '
            'A normal viewport expands to max constraints; a shrink-wrapping '
            'viewport sizes itself to its slivers. Explore nested scrollables, '
            'sliver composition, constrained layouts, and dynamic growth behavior.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlRail() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Scenario',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: _p.ink,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _scenarioTitles.length; i++)
            ChoiceChip(
              label: Text('${i + 1}'),
              selected: _scenario == i,
              onSelected: (_) {
                setState(() => _scenario = i);
                _log('scenario changed to $i');
              },
              labelStyle: TextStyle(
                color: _scenario == i ? Colors.white : _p.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
            ),
          const SizedBox(width: 8),
          Text(
            'Palette',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: _p.ink,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _pals.length; i++)
            GestureDetector(
              onTap: () {
                setState(() => _palette = i);
                _log('palette changed to $i');
              },
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _pals[i].primary,
                  border: Border.all(
                    color: _palette == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Verbose log',
                style: TextStyle(fontSize: 12, color: _p.ink),
              ),
              Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioBody() {
    switch (_scenario) {
      case 0:
        return _scenarioNormalVsShrinkWrap();
      case 1:
        return _scenarioNestedContexts();
      case 2:
        return _scenarioSliverGallery();
      case 3:
        return _scenarioDialogAndBottomSheet();
      case 4:
        return _scenarioDynamicGrowth();
      case 5:
        return _scenarioVerification();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _scenarioNormalVsShrinkWrap() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Normal Viewport vs Shrink-Wrapping Viewport'),
          const SizedBox(height: 8),
          Text(
            'A normal CustomScrollView consumes maximum vertical space from '
            'its parent constraints. With shrinkWrap: true, it asks slivers '
            'for their geometry and then uses only the required extent.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Compare Item Count',
            subtitle: 'Adjust sliver content size and observe measured heights.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _compareItemCount.toDouble(),
                        min: 2,
                        max: 12,
                        divisions: 10,
                        label: '$_compareItemCount items',
                        activeColor: _p.primary,
                        onChanged: (v) {
                          setState(() => _compareItemCount = v.round());
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    _metricPill(
                      label: 'Items',
                      value: '$_compareItemCount',
                      color: _p.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: _metricPill(
                        label: 'Normal Height',
                        value: _normalViewportHeight.toStringAsFixed(1),
                        color: _p.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _metricPill(
                        label: 'Shrink Height',
                        value: _shrinkViewportHeight.toStringAsFixed(1),
                        color: _p.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _card(
                  title: 'Normal Viewport',
                  subtitle: 'Constrained parent forces full height usage.',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: _SizeReporter(
                    onSize: (s) {
                      if (_normalViewportHeight != s.height) {
                        setState(() => _normalViewportHeight = s.height);
                      }
                    },
                    child: Container(
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _p.secondary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: _sliverBanner('Header (fixed sliver box)', _p.secondary),
                          ),
                          SliverList.builder(
                            itemCount: _compareItemCount,
                            itemBuilder: (context, index) {
                              return _tile(
                                label: 'Normal item ${index + 1}',
                                color: _p.secondary.withValues(alpha: 0.14),
                                icon: Icons.view_agenda,
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: _sliverBanner('Footer sliver', _p.secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _card(
                  title: 'Shrink-Wrap Viewport',
                  subtitle: 'Uses only sliver extents; ideal for nested sections.',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: _SizeReporter(
                    onSize: (s) {
                      if (_shrinkViewportHeight != s.height) {
                        setState(() => _shrinkViewportHeight = s.height);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _p.primary.withValues(alpha: 0.35),
                        ),
                      ),
                      child: CustomScrollView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: _sliverBanner('Header (same content)', _p.primary),
                          ),
                          SliverList.builder(
                            itemCount: _compareItemCount,
                            itemBuilder: (context, index) {
                              return _tile(
                                label: 'Shrink item ${index + 1}',
                                color: _p.primary.withValues(alpha: 0.13),
                                icon: Icons.fit_screen,
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: _sliverBanner('Footer sliver', _p.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _card(
            title: 'Interpretation',
            subtitle: 'Why this matters in real UI hierarchies.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'When parent constraints are loose (for example inside a '
                  'Column in a scrolling page), a normal viewport cannot infer '
                  'its height from children. shrinkWrap instructs the viewport '
                  'to perform extra layout work and use sliver geometry as size.',
                  style: TextStyle(fontSize: 12, color: _p.ink, height: 1.35),
                ),
                const SizedBox(height: 8),
                _bullet('Use shrinkWrap for short, embedded scroll sections.'),
                _bullet('Avoid it for large lists when performance is critical.'),
                _bullet('Prefer one primary scrollable when possible.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioNestedContexts() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Scroll Contexts'),
          const SizedBox(height: 8),
          Text(
            'Nested lists are a common source of layout conflicts. '
            'Shrink-wrapping viewports allow small inner collections to '
            'fit naturally inside a larger scrolling document.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Group Count',
            subtitle: 'Controls how many inner groups are embedded.',
            child: Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _nestedGroupCount.toDouble(),
                    min: 2,
                    max: 6,
                    divisions: 4,
                    label: '$_nestedGroupCount groups',
                    activeColor: _p.primary,
                    onChanged: (v) {
                      setState(() => _nestedGroupCount = v.round());
                    },
                  ),
                ),
                const SizedBox(width: 8),
                _metricPill(
                  label: 'Groups',
                  value: '$_nestedGroupCount',
                  color: _p.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Parent Article Feed With Embedded Collections',
            subtitle: 'Each group below is a shrink-wrapped embedded scroll view.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  _articleIntroCard('Top headline section', _p.primary),
                  for (var g = 0; g < _nestedGroupCount; g++)
                    _embeddedCollectionBlock(groupIndex: g),
                  _articleIntroCard('Closing summary section', _p.secondary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'ListView Variant (Also Uses ShrinkWrappingViewport)',
            subtitle: 'ListView with shrinkWrap:true is another practical path.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Show ListView shrinkWrap sample',
                      style: TextStyle(fontSize: 12, color: _p.ink),
                    ),
                    const Spacer(),
                    Switch(
                      value: _useListViewVariant,
                      activeTrackColor: _p.accent,
                      onChanged: (v) => setState(() => _useListViewVariant = v),
                    ),
                  ],
                ),
                if (_useListViewVariant)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _p.secondary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'ListView shrinkWrap item ${index + 1}',
                          color: _p.secondary.withValues(alpha: 0.12),
                          icon: Icons.list_alt,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'In nested content, set inner scroll physics to '
            'NeverScrollableScrollPhysics so the parent handles scroll '
            'gestures consistently. This keeps interactions predictable.',
          ),
        ],
      ),
    );
  }

  Widget _embeddedCollectionBlock({required int groupIndex}) {
    final hue = groupIndex.isEven ? _p.primary : _p.secondary;
    final title = 'Embedded Group ${groupIndex + 1}';
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: hue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: hue.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: hue.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: _p.ink,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    'This sliver section is embedded in a larger feed. '
                    'Its viewport wraps to content height.',
                    style: TextStyle(fontSize: 11, color: _p.ink.withValues(alpha: 0.8)),
                  ),
                ),
                SliverList.builder(
                  itemCount: 3 + groupIndex,
                  itemBuilder: (context, index) {
                    return _tile(
                      label: 'Group ${groupIndex + 1} row ${index + 1}',
                      color: hue.withValues(alpha: 0.14),
                      icon: Icons.layers,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioSliverGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Sliver Types Gallery in Shrink-Wrap Mode'),
          const SizedBox(height: 8),
          Text(
            'RenderShrinkWrappingViewport computes total extent from every '
            'sliver in sequence. This gallery mixes adapters, grids, lists, '
            'padding, and optional footer slivers to show compound sizing.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Controls',
            subtitle: 'Toggle sliver sections and adjust list density.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _galleryListCount.toDouble(),
                        min: 3,
                        max: 10,
                        divisions: 7,
                        label: '$_galleryListCount rows',
                        activeColor: _p.primary,
                        onChanged: (v) {
                          setState(() => _galleryListCount = v.round());
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    _metricPill(
                      label: 'List rows',
                      value: '$_galleryListCount',
                      color: _p.primary,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _showGridInGallery,
                            activeColor: _p.primary,
                            onChanged: (v) {
                              setState(() => _showGridInGallery = v ?? true);
                            },
                          ),
                          Text(
                            'Include SliverGrid',
                            style: TextStyle(fontSize: 12, color: _p.ink),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _showFooterSliver,
                            activeColor: _p.primary,
                            onChanged: (v) {
                              setState(() => _showFooterSliver = v ?? true);
                            },
                          ),
                          Text(
                            'Include Footer Sliver',
                            style: TextStyle(fontSize: 12, color: _p.ink),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Composite Shrink-Wrap CustomScrollView',
            subtitle: 'All sections below contribute to viewport extent.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.34)),
              ),
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _p.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.view_stream, color: _p.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'SliverToBoxAdapter: regular box content in sliver world.',
                              style: TextStyle(fontSize: 12, color: _p.ink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showGridInGallery)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final c = index.isEven
                                ? _p.primary.withValues(alpha: 0.16)
                                : _p.secondary.withValues(alpha: 0.16);
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: c,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Grid ${index + 1}',
                                style: TextStyle(fontSize: 11, color: _p.ink),
                              ),
                            );
                          },
                          childCount: 6,
                        ),
                      ),
                    ),
                  SliverList.builder(
                    itemCount: _galleryListCount,
                    itemBuilder: (context, index) {
                      return _tile(
                        label: 'SliverList row ${index + 1}',
                        color: _p.secondary.withValues(alpha: 0.12),
                        icon: Icons.table_rows,
                      );
                    },
                  ),
                  if (_showFooterSliver)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _p.secondary.withValues(alpha: 0.22),
                              _p.primary.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Footer SliverToBoxAdapter: toggling this modifies total viewport extent.',
                          style: TextStyle(fontSize: 12, color: _p.ink),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Why Sliver Coverage Matters',
            subtitle: 'Each sliver participates in final shrink-wrap extent.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('SliverToBoxAdapter adds direct box height.'),
                _bullet('SliverGrid contributes row-based geometry.'),
                _bullet('SliverPadding changes viewport extent by insets.'),
                _bullet('SliverList contributes item extents cumulatively.'),
                _bullet('Optional slivers still impact total size when enabled.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioDialogAndBottomSheet() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Dialog & Bottom Sheet Patterns'),
          const SizedBox(height: 8),
          Text(
            'Constrained overlays often need content-sized scroll sections. '
            'Shrink wrapping lets the inner scroll view fit available content '
            'without greedily occupying all vertical space.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Overlay Content Controls',
            subtitle: 'Tune item counts in dialog and sheet independently.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Dialog items: $_dialogItemCount',
                        style: TextStyle(fontSize: 12, color: _p.ink),
                      ),
                    ),
                    SizedBox(
                      width: 210,
                      child: Slider(
                        value: _dialogItemCount.toDouble(),
                        min: 2,
                        max: 10,
                        divisions: 8,
                        activeColor: _p.primary,
                        onChanged: (v) {
                          setState(() => _dialogItemCount = v.round());
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sheet items: $_sheetItemCount',
                        style: TextStyle(fontSize: 12, color: _p.ink),
                      ),
                    ),
                    SizedBox(
                      width: 210,
                      child: Slider(
                        value: _sheetItemCount.toDouble(),
                        min: 3,
                        max: 12,
                        divisions: 9,
                        activeColor: _p.secondary,
                        onChanged: (v) {
                          setState(() => _sheetItemCount = v.round());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _dialogSimulation()),
              const SizedBox(width: 12),
              Expanded(child: _bottomSheetSimulation()),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Practical Guidance',
            subtitle: 'Choosing constraints and physics in overlays.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Dialogs usually use maxHeight constraints and shrinkWrap lists.'),
                _bullet('Bottom sheets can cap height, then allow internal scrolling if needed.'),
                _bullet('Use NeverScrollableScrollPhysics for tiny sections inside larger scrollers.'),
                _bullet('When content can exceed cap, enable inner scrolling intentionally.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dialogSimulation() {
    return _card(
      title: 'Dialog Pattern',
      subtitle: 'Constrained width, content-sized vertical extent.',
      tint: _p.primary.withValues(alpha: 0.04),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320, maxHeight: 420),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _p.primary.withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.tune, color: _p.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Filter dialog',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _p.ink,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.close, color: _p.muted, size: 18),
                ],
              ),
              const SizedBox(height: 8),
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverList.builder(
                    itemCount: _dialogItemCount,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                        decoration: BoxDecoration(
                          color: _p.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline,
                                color: _p.primary, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Filter option ${index + 1}',
                                style: TextStyle(fontSize: 12, color: _p.ink),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _p.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetSimulation() {
    return _card(
      title: 'Bottom Sheet Pattern',
      subtitle: 'Capped container with shrink-wrapped content sections.',
      tint: _p.secondary.withValues(alpha: 0.04),
      child: Container(
        width: double.infinity,
        height: 430,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _p.secondary.withValues(alpha: 0.32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: _p.muted.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.restaurant_menu, color: _p.secondary),
                  const SizedBox(width: 6),
                  Text(
                    'Choose extras',
                    style: TextStyle(fontWeight: FontWeight.w700, color: _p.ink),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        'Sections below are shrink-wrapped slivers within '
                        'a sheet body.',
                        style: TextStyle(fontSize: 12, color: _p.muted),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: _sheetItemCount,
                      itemBuilder: (context, index) {
                        final c = index.isEven
                            ? _p.secondary.withValues(alpha: 0.12)
                            : _p.primary.withValues(alpha: 0.12);
                        return _tile(
                          label: 'Extra option ${index + 1}',
                          color: c,
                          icon: Icons.add_box_rounded,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _p.secondary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scenarioDynamicGrowth() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Dynamic Content Growth / Shrink'),
          const SizedBox(height: 8),
          Text(
            'Shrink-wrapped viewports re-measure when sliver extents change. '
            'This scenario updates item count interactively to demonstrate '
            'runtime resizing behavior in the interpreter.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Interactive Controls',
            subtitle: 'Add/remove items and inspect measured viewport height.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _p.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _dynamicItemCount += 1);
                    _log('dynamic item++ => $_dynamicItemCount');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add item'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _p.secondary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_dynamicItemCount > 1) {
                      setState(() => _dynamicItemCount -= 1);
                      _log('dynamic item-- => $_dynamicItemCount');
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Remove item'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() => _dynamicItemCount = 4);
                    _log('dynamic reset');
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
                _metricPill(
                  label: 'Current items',
                  value: '$_dynamicItemCount',
                  color: _p.accent,
                ),
                _metricPill(
                  label: 'Measured height',
                  value: _dynamicShrinkHeight.toStringAsFixed(1),
                  color: _p.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Live Shrink-Wrap List',
            subtitle: 'Container re-sizes as sliver content changes.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: _SizeReporter(
              onSize: (s) {
                if (_dynamicShrinkHeight != s.height) {
                  setState(() => _dynamicShrinkHeight = s.height);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.primary.withValues(alpha: 0.35)),
                ),
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _sliverBanner('Dynamic header', _p.primary),
                    ),
                    SliverList.builder(
                      itemCount: _dynamicItemCount,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'Dynamic row ${index + 1}',
                          color: _p.primary.withValues(alpha: 0.12),
                          icon: Icons.animation,
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: _sliverBanner('Dynamic footer', _p.secondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Behavior Notes',
            subtitle: 'How growth updates are propagated.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Changing itemCount alters sliver geometry.'),
                _bullet('Shrink-wrapped viewport recomputes total extent.'),
                _bullet('Parent layout updates with the new measured height.'),
                _bullet('Use this carefully for long/rapidly-changing lists.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Performance reminder: shrinkWrap requires extra layout passes '
            'because extent depends on sliver content. For very long lists '
            'or highly animated content, prefer non-shrink primary viewports '
            'when feasible.',
          ),
        ],
      ),
    );
  }

  Widget _scenarioVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Guide'),
          const SizedBox(height: 12),
          _card(
            title: 'API Snapshot',
            subtitle: 'How RenderShrinkWrappingViewport is reached from widgets.',
            child: Column(
              children: [
                _apiRow(
                  layer: 'Widget',
                  type: 'CustomScrollView(shrinkWrap: true)',
                  note: 'Requests content-sized viewport behavior.',
                ),
                _apiRow(
                  layer: 'ScrollView',
                  type: 'buildViewport(...)',
                  note: 'Chooses shrink-wrapping viewport variant.',
                ),
                _apiRow(
                  layer: 'Render object',
                  type: 'RenderShrinkWrappingViewport',
                  note: 'Computes size from sliver geometry.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Decision Matrix',
            subtitle: 'When to use shrinkWrap and when to avoid it.',
            child: Column(
              children: [
                _decisionRow(
                  scenario: 'Short embedded list inside article',
                  choice: 'Use shrinkWrap',
                  reason: 'Natural height integration with surrounding content.',
                  good: true,
                ),
                _decisionRow(
                  scenario: 'Primary long feed screen',
                  choice: 'Avoid shrinkWrap',
                  reason: 'Standard viewport is cheaper and scales better.',
                  good: false,
                ),
                _decisionRow(
                  scenario: 'Dialog with variable options',
                  choice: 'Use shrinkWrap + constraints',
                  reason: 'Overlay fits content without over-expanding.',
                  good: true,
                ),
                _decisionRow(
                  scenario: 'Large animated list with frequent mutations',
                  choice: 'Prefer non-shrink',
                  reason: 'Repeated extent recomputation can be expensive.',
                  good: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Checklist',
            subtitle: 'Deep demo validation points for this component.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Demonstrated normal vs shrink-wrap sizing differences.'),
                _check('Included nested scroll integration patterns.'),
                _check('Covered multiple sliver types in one shrink-wrapped viewport.'),
                _check('Showed dialog and bottom sheet constrained usage.'),
                _check('Validated dynamic growth and re-layout behavior.'),
                _check('Provided guidance on performance and trade-offs.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common confusion points and practical answers.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _qa(
                  q: 'Why does shrinkWrap often need NeverScrollableScrollPhysics?',
                  a: 'In nested contexts, you usually want the parent scrollable '
                      'to own gestures. Inner sections become content-sized blocks '
                      'instead of independent scroll regions.',
                ),
                _qa(
                  q: 'Does ListView(shrinkWrap: true) use the same render concept?',
                  a: 'Yes. The underlying viewport behavior maps to '
                      'RenderShrinkWrappingViewport when shrink wrapping is active.',
                ),
                _qa(
                  q: 'Can I use shrinkWrap everywhere for convenience?',
                  a: 'Technically yes, but not recommended. For long primary '
                      'lists it can hurt performance due to extra layout work.',
                ),
                _qa(
                  q: 'How do I cap growth in overlays?',
                  a: 'Wrap with constraints (for example maxHeight), then decide '
                      'if inner scrolling should be enabled or disabled.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Summary: RenderShrinkWrappingViewport is a precision tool for '
            'content-sized scrolling sections. It solves real nested-layout '
            'problems, but should be used intentionally due to layout cost.',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _scenarioTitles[_scenario],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _p.muted,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_p.name}',
            style: TextStyle(fontSize: 11, color: _p.muted),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: _p.ink,
          ),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _p.ink,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11.5, color: _p.muted),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _tile({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _p.ink),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: _p.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.view_day, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              color: _p.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _articleIntroCard(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.article, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: _p.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _p.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: _p.ink, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: _p.ink, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge({required String text, required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _metricPill({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 11, color: _p.ink),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: _p.ink,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiRow({
    required String layer,
    required String type,
    required String note,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              layer,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: _p.primary,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: _p.ink,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: TextStyle(fontSize: 11.5, color: _p.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _decisionRow({
    required String scenario,
    required String choice,
    required String reason,
    required bool good,
  }) {
    final c = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel, color: c, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _p.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  choice,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: c,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: TextStyle(fontSize: 11.5, color: _p.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: _p.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              fontSize: 12,
              color: _p.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(fontSize: 11.5, color: _p.muted, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _SizeReporter extends SingleChildRenderObjectWidget {
  final ValueChanged<Size> onSize;

  const _SizeReporter({required this.onSize, required Widget child})
      : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeReporterRenderObject(onSize);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SizeReporterRenderObject renderObject) {
    renderObject.onSize = onSize;
  }
}

class _SizeReporterRenderObject extends RenderProxyBox {
  _SizeReporterRenderObject(this.onSize);

  ValueChanged<Size> onSize;
  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    final newSize = child?.size;
    if (newSize == null) {
      return;
    }
    if (_oldSize == newSize) {
      return;
    }
    _oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSize(newSize);
    });
  }
}
