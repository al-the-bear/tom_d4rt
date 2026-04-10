// Deep visual test for RestorableInt
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, unintended_html_in_doc_comment, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableInt
/// A restorable property that holds a non-null integer value.
///
/// RestorableInt:
/// - Always contains a valid int (never null)
/// - Extends RestorableNum<int>
/// - Perfect for counters, indices, and required numeric settings
///
/// The most common Restorable type for state that needs an integer.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableIntDemo(),
  );
}

// =============================================================================
// PALETTE: DeepPurple 700 / Orange A400
// =============================================================================
const Color _kPrimary = Color(0xFF512DA8); // DeepPurple 700
const Color _kAccent = Color(0xFFFF9100); // Orange A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kTab = Color(0xFF42A5F5);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableIntDemo extends StatefulWidget {
  @override
  State<_RestorableIntDemo> createState() => _RestorableIntDemoState();
}

class _RestorableIntDemoState extends State<_RestorableIntDemo>
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
        title: Text('RestorableInt Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.tab), text: 'Index Lab'),
            Tab(icon: Icon(Icons.add), text: 'Counter'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _IndexLabTab(),
          _CounterTab(),
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
          _buildNonNullSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildCommonPatternsSection(),
          SizedBox(height: 24),
          _buildSerializationSection(),
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
              Icon(Icons.numbers, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableInt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A restorable property for non-nullable integer values. Always contains '
            'a valid int—the workhorse for counters, indices, and numeric state.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.numbers, label: 'int'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.check_circle, label: 'Non-null'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.bolt, label: 'Direct'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNonNullSection() {
    return _TheoryCard(
      title: 'Always Has Value',
      icon: Icons.shield,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableInt guarantees a valid integer at all times:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kSuccess.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: _kSuccess, size: 32),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Non-null Guarantee',
                        style: TextStyle(color: _kSuccess, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'No null checks needed. Value always accessible via .value property.',
                        style: TextStyle(color: _kTextPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Safe direct access:',
            code: '''final counter = RestorableInt(0);

// Direct access - no null check!
int current = counter.value;
counter.value = current + 1;

// Safe in expressions
Text('Count: \${counter.value}')''',
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableInt vs RestorableIntN',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableInt',
                  color: _kAccent,
                  items: [
                    'Type: int',
                    'Never null',
                    'Default required',
                    'Direct .value',
                    'For counters/indices',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableIntN',
                  color: _kWarning,
                  items: [
                    'Type: int?',
                    'Can be null',
                    'null default OK',
                    'Needs ?. check',
                    'For optional values',
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: _kAccent, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Use RestorableInt for counts, indices, and required settings. '
                    'Use RestorableIntN when "not set" is meaningful.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 11),
                  ),
                ),
              ],
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
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'RestorableProperty<int>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<int>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableNum<int>', desc: 'Numeric'),
                _HierarchyItem(level: 3, name: 'RestorableInt', desc: 'Non-null int', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableIntN', 'Nullable'),
              _RelatedChip('RestorableDouble', 'Floating'),
              _RelatedChip('RestorableNum', 'Generic'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommonPatternsSection() {
    return _TheoryCard(
      title: 'Common Use Patterns',
      icon: Icons.pattern,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PatternItem(
            icon: Icons.add,
            title: 'Counter Pattern',
            code: 'final _counter = RestorableInt(0);',
            desc: 'The Flutter counter app pattern',
          ),
          SizedBox(height: 12),
          _PatternItem(
            icon: Icons.tab,
            title: 'Tab Index',
            code: 'final _tabIndex = RestorableInt(0);',
            desc: 'Persisting selected tab',
          ),
          SizedBox(height: 12),
          _PatternItem(
            icon: Icons.pages,
            title: 'Page Index',
            code: 'final _page = RestorableInt(1);',
            desc: 'Pagination position',
          ),
          SizedBox(height: 12),
          _PatternItem(
            icon: Icons.bookmark,
            title: 'Selected Index',
            code: 'final _selected = RestorableInt(-1);',
            desc: '-1 for none selected',
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationSection() {
    return _TheoryCard(
      title: 'Serialization',
      icon: Icons.save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableInt stores values directly as primitives:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('toPrimitives()', style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11)),
                    ),
                    SizedBox(width: 8),
                    Text('→ value (int)', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('fromPrimitives()', style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11)),
                    ),
                    SizedBox(width: 8),
                    Text('← data as int', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: _kSuccess, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'No conversion overhead—values stored directly.',
                    style: TextStyle(color: _kSuccess, fontSize: 11),
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

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _kAccent, size: 14),
          SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> items;

  const _ComparisonCard({required this.title, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
          SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check, color: color, size: 12),
                SizedBox(width: 6),
                Flexible(child: Text(item, style: TextStyle(color: _kTextPrimary, fontSize: 10))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _PatternItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String code;
  final String desc;

  const _PatternItem({required this.icon, required this.title, required this.code, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kAccent, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
                Text(code, style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 10)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: INDEX LAB
// =============================================================================
class _IndexLabTab extends StatefulWidget {
  @override
  State<_IndexLabTab> createState() => _IndexLabTabState();
}

class _IndexLabTabState extends State<_IndexLabTab> with SingleTickerProviderStateMixin {
  // Simulated RestorableInt for tab index
  int _selectedTab = 0;
  int _selectedItem = -1;
  int _currentPage = 1;
  final int _totalPages = 10;
  final List<String> _log = [];

  void _setTab(int index) {
    setState(() {
      _selectedTab = index;
      _addLog('Tab index: $index');
    });
  }

  void _setItem(int index) {
    setState(() {
      _selectedItem = index;
      _addLog('Item selected: ${index == -1 ? "none" : index}');
    });
  }

  void _setPage(int page) {
    setState(() {
      _currentPage = page.clamp(1, _totalPages);
      _addLog('Page: $_currentPage');
    });
  }

  void _addLog(String msg) {
    _log.insert(0, '${DateTime.now().toString().substring(11, 19)}: $msg');
    if (_log.length > 10) _log.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tab, color: _kAccent, size: 20),
                  SizedBox(width: 8),
                  Text('Index Management Lab', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              SizedBox(height: 4),
              Text('Common RestorableInt index patterns', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Tab Index Section
                _IndexCard(
                  title: 'Tab Index',
                  icon: Icons.tab,
                  description: 'RestorableInt for tab controller index',
                  value: _selectedTab,
                  child: Row(
                    children: List.generate(4, (i) => Expanded(
                      child: GestureDetector(
                        onTap: () => _setTab(i),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTab == i ? _kTab : _kSurface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _selectedTab == i ? _kTab : _kDivider),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                [Icons.home, Icons.search, Icons.person, Icons.settings][i],
                                color: _selectedTab == i ? Colors.white : _kTextSecondary,
                                size: 22,
                              ),
                              SizedBox(height: 4),
                              Text(
                                ['Home', 'Search', 'Profile', 'Settings'][i],
                                style: TextStyle(
                                  color: _selectedTab == i ? Colors.white : _kTextSecondary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                ),
                SizedBox(height: 16),
                // List Selection Section
                _IndexCard(
                  title: 'Selected Item Index',
                  icon: Icons.list,
                  description: 'RestorableInt(-1) for list selection (-1 = none)',
                  value: _selectedItem,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _setItem(-1),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _selectedItem == -1 ? _kWarning.withOpacity(0.2) : _kSurface,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _selectedItem == -1 ? _kWarning : _kDivider),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.deselect, color: _kWarning, size: 18),
                              SizedBox(width: 8),
                              Text('Clear Selection', style: TextStyle(color: _kWarning, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(8, (i) => GestureDetector(
                          onTap: () => _setItem(i),
                          child: Container(
                            width: 50,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedItem == i ? _kAccent.withOpacity(0.3) : _kSurface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _selectedItem == i ? _kAccent : _kDivider,
                                width: _selectedItem == i ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Item $i',
                                style: TextStyle(
                                  color: _selectedItem == i ? _kAccent : _kTextPrimary,
                                  fontSize: 10,
                                  fontWeight: _selectedItem == i ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Page Navigation Section
                _IndexCard(
                  title: 'Page Index',
                  icon: Icons.pages,
                  description: 'RestorableInt(1) for 1-based pagination',
                  value: _currentPage,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PageButton(label: '«', onTap: () => _setPage(1), enabled: _currentPage > 1),
                          _PageButton(label: '‹', onTap: () => _setPage(_currentPage - 1), enabled: _currentPage > 1),
                          SizedBox(width: 16),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _kAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _kAccent),
                            ),
                            child: Text(
                              '$_currentPage / $_totalPages',
                              style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 16),
                          _PageButton(label: '›', onTap: () => _setPage(_currentPage + 1), enabled: _currentPage < _totalPages),
                          _PageButton(label: '»', onTap: () => _setPage(_totalPages), enabled: _currentPage < _totalPages),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: _kSurface,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: _currentPage / _totalPages,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kAccent,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Log
        Container(
          height: 80,
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Index Changes:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 6),
              Expanded(
                child: ListView(
                  children: _log.map((l) => Text(l, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10))).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IndexCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final int value;
  final Widget child;

  const _IndexCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _kAccent, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    Text(description, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'value: $value',
                  style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool enabled;

  const _PageButton({required this.label, required this.onTap, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: enabled ? _kSurface : _kSurface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: enabled ? _kDivider : _kDivider.withOpacity(0.5)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: enabled ? _kTextPrimary : _kTextSecondary.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 3: COUNTER
// =============================================================================
class _CounterTab extends StatefulWidget {
  @override
  State<_CounterTab> createState() => _CounterTabState();
}

class _CounterTabState extends State<_CounterTab> {
  // Simulated RestorableInt counters
  int _clicks = 0;
  int _score = 0;
  int _level = 1;
  int _streak = 0;
  final List<String> _history = [];

  void _incrementClicks() {
    setState(() {
      _clicks++;
      _streak++;
      if (_streak % 5 == 0) {
        _score += 10;
        _addHistory('Bonus! +10 score');
      }
      if (_clicks % 10 == 0) {
        _level++;
        _addHistory('Level up! Now level $_level');
      }
      _addHistory('Click $_clicks');
    });
  }

  void _decrementClicks() {
    setState(() {
      if (_clicks > 0) {
        _clicks--;
        _streak = 0;
        _addHistory('Click decremented to $_clicks');
      }
    });
  }

  void _reset() {
    setState(() {
      _clicks = 0;
      _score = 0;
      _level = 1;
      _streak = 0;
      _history.clear();
      _addHistory('All counters reset');
    });
  }

  void _addHistory(String msg) {
    _history.insert(0, '${DateTime.now().toString().substring(11, 19)}: $msg');
    if (_history.length > 15) _history.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Row(
            children: [
              Icon(Icons.add, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RestorableInt Counter Demo', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    Text('Classic Flutter counter pattern', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _reset,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kWarning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Reset', style: TextStyle(color: _kWarning, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
        // Main counter display
        Expanded(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatBox(label: 'Score', value: _score, color: _kSuccess),
                    _StatBox(label: 'Level', value: _level, color: _kAccent),
                    _StatBox(label: 'Streak', value: _streak, color: _kTab),
                  ],
                ),
                SizedBox(height: 40),
                // Main counter
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                  decoration: BoxDecoration(
                    color: _kCardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _kPrimary, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: _kPrimary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'You have clicked',
                        style: TextStyle(color: _kTextSecondary, fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$_clicks',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _clicks == 1 ? 'time' : 'times',
                        style: TextStyle(color: _kTextSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CounterButton(
                      icon: Icons.remove,
                      onTap: _decrementClicks,
                      color: _kWarning,
                    ),
                    SizedBox(width: 24),
                    _CounterButton(
                      icon: Icons.add,
                      onTap: _incrementClicks,
                      color: _kAccent,
                      isLarge: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // History
        Container(
          height: 100,
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event History:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 6),
              Expanded(
                child: ListView(
                  children: _history.map((h) => Text(
                    h,
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 11)),
          SizedBox(height: 4),
          Text(
            '$value',
            style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool isLarge;

  const _CounterButton({
    required this.icon,
    required this.onTap,
    required this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 70.0 : 50.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: isLarge ? 36 : 24),
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

  const _TheoryCard({required this.title, required this.icon, required this.child});

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
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
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

  const _HierarchyItem({required this.level, required this.name, required this.desc, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 14.0, top: level > 0 ? 6 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: _kDivider), bottom: BorderSide(color: _kDivider)),
              ),
            ),
            SizedBox(width: 6),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isHighlighted ? _kAccent : _kDivider),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: isHighlighted ? _kAccent : _kTextPrimary,
                  fontFamily: 'monospace',
                  fontSize: 9,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(width: 6),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _RelatedChip extends StatelessWidget {
  final String name;
  final String desc;
  const _RelatedChip(this.name, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace')),
          SizedBox(width: 4),
          Text('($desc)', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _CodeExample extends StatelessWidget {
  final String title;
  final String code;

  const _CodeExample({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withOpacity(0.2)),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
