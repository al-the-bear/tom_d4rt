// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_locals
// D4rt test script: Deep Demo - ExpansionPanel / ExpansionPanelList from Flutter Material
// Comprehensive demonstration of accordion-style disclosure widgets with live state
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 1: DOSSIER — When to choose what
  // ==========================================================================
  //
  // ExpansionPanelList    : accordion of independently expandable panels
  // ExpansionPanelList.radio : single-open accordion (mutually exclusive)
  // ExpansionTile         : single-tile disclosure, simpler API, less control
  // Stepper               : sequential, progress-aware, vertical or horizontal
  //
  // Choose ExpansionPanelList when you want a Material-styled stack of
  // collapsible cards with explicit per-panel expansion state.
  // Choose ExpansionPanelList.radio when only one section should be open at
  // a time (FAQs, settings categories, wizard-like browsing).

  final dossierItems = <Map<String, String>>[
    {
      'widget': 'ExpansionPanelList',
      'when': 'Multiple panels may be open simultaneously',
      'state': 'Caller-owned per panel (isExpanded)',
    },
    {
      'widget': 'ExpansionPanelList.radio',
      'when': 'Only one panel open at any time',
      'state': 'Internal — keyed by ExpansionPanelRadio.value',
    },
    {
      'widget': 'ExpansionTile',
      'when': 'A single disclosure without surrounding card chrome',
      'state': 'Internal or via controller',
    },
    {
      'widget': 'Stepper',
      'when': 'Linear, progress-driven flows',
      'state': 'Controlled via currentStep',
    },
  ];

  // ==========================================================================
  // SECTION 2: ANATOMY — Constructor parameter reference
  // ==========================================================================

  final panelAnatomy = <Map<String, String>>[
    {
      'param': 'headerBuilder',
      'type': 'ExpansionPanelHeaderBuilder',
      'note': 'Builds the always-visible header; receives isExpanded',
    },
    {
      'param': 'body',
      'type': 'Widget',
      'note': 'Shown only when isExpanded == true',
    },
    {
      'param': 'isExpanded',
      'type': 'bool',
      'note': 'Per-panel expansion flag (default false)',
    },
    {
      'param': 'canTapOnHeader',
      'type': 'bool',
      'note': 'If true, the entire header is the toggle hit-target',
    },
    {
      'param': 'backgroundColor',
      'type': 'Color?',
      'note': 'Background color for the panel material',
    },
  ];

  final listAnatomy = <Map<String, String>>[
    {
      'param': 'children',
      'type': 'List<ExpansionPanel>',
      'note': 'The panels rendered, in order',
    },
    {
      'param': 'expansionCallback',
      'type': 'ExpansionPanelCallback?',
      'note': 'Fired when a header is tapped — (index, isExpanded)',
    },
    {
      'param': 'animationDuration',
      'type': 'Duration',
      'note': 'Open/close animation length (default 200ms)',
    },
    {
      'param': 'expandedHeaderPadding',
      'type': 'EdgeInsets',
      'note': 'Padding around the expanded header content',
    },
    {
      'param': 'dividerColor',
      'type': 'Color?',
      'note': 'Color of the dividers between panels',
    },
    {
      'param': 'elevation',
      'type': 'double',
      'note': 'Material elevation (drop shadow depth)',
    },
    {
      'param': 'materialGapSize',
      'type': 'double',
      'note': 'Vertical gap between panels (default 16)',
    },
    {
      'param': 'expandIconColor',
      'type': 'Color?',
      'note': 'Tint for the chevron icon',
    },
  ];

  // ==========================================================================
  // SECTION 3: STANDARD LIST — Three FAQ panels with live toggle
  // ==========================================================================

  final faqExpanded = <bool>[true, false, false];

  final faq = <Map<String, String>>[
    {
      'q': 'What is an ExpansionPanel?',
      'a':
          'A Material disclosure container with a header (always shown) and '
          'a body (shown only when expanded). Use it inside an '
          'ExpansionPanelList to get accordion-style behavior.',
    },
    {
      'q': 'Why do I have to manage isExpanded myself?',
      'a':
          'ExpansionPanelList is intentionally stateless. The parent owns the '
          'truth — your callback updates the bool list, and a setState rebuild '
          'pushes the new state back into the list.',
    },
    {
      'q': 'When should I use the .radio constructor?',
      'a':
          'When mutual exclusion is desired — only one panel open at a time. '
          'Each child becomes an ExpansionPanelRadio with a unique value, and '
          'the list tracks the currently-open value internally.',
    },
  ];

  Widget standardList = StatefulBuilder(
    builder: (ctx, setLocal) {
      return ExpansionPanelList(
        elevation: 2,
        dividerColor: Color(0xFFCFD8DC),
        animationDuration: Duration(milliseconds: 250),
        expandedHeaderPadding: EdgeInsets.symmetric(vertical: 12),
        expansionCallback: (index, isExpanded) {
          // Bounds-check defensively: d4rt's ExpansionPanelList
          // bridge has been observed firing the callback during
          // build with index == children.length (one past the
          // last valid index). Without the guard this raises a
          // Runtime Error: Index out of range banner that the
          // host test does not assert on.
          if (index < 0 || index >= faqExpanded.length) {
            return;
          }
          setLocal(() {
            faqExpanded[index] = isExpanded;
          });
        },
        // d4rt I1: a C-style `for (int i = 0; i < .length; i++)`
        // reuses a single `i` slot across iterations, so the
        // `headerBuilder` / `body` closures below would all see
        // `i == faq.length` when they fire during build, raising
        // `Index out of range: 3` on `faq[i]['q']`. `List.generate`
        // gives each iteration a fresh function-parameter `i`.
        children: List<ExpansionPanel>.generate(faq.length, (int i) {
          return ExpansionPanel(
            isExpanded: faqExpanded[i],
            canTapOnHeader: true,
            headerBuilder: (c, isExpanded) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isExpanded
                      ? Color(0xFF1E88E5)
                      : Color(0xFFB0BEC5),
                  foregroundColor: Color(0xFFFFFFFF),
                  child: Text('Q${i + 1}'),
                ),
                title: Text(
                  faq[i]['q'] ?? '',
                  style: TextStyle(
                    fontWeight: isExpanded
                        ? FontWeight.bold
                        : FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  isExpanded ? 'Tap to collapse' : 'Tap to expand',
                  style: TextStyle(fontSize: 11.0),
                ),
              );
            },
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 4, 20, 20),
              color: Color(0xFFF1F8FF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Answer',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    faq[i]['a'] ?? '',
                    style: TextStyle(fontSize: 13.0, height: 1.45),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    },
  );

  // ==========================================================================
  // SECTION 4: RADIO VARIANT — Single-open accordion with rich bodies
  // ==========================================================================

  Widget radioList = ExpansionPanelList.radio(
    elevation: 3,
    initialOpenPanelValue: 'cat-account',
    animationDuration: Duration(milliseconds: 350),
    dividerColor: Color(0xFFB39DDB),
    expansionCallback: (index, isExpanded) {
      print('radio panel $index → $isExpanded');
    },
    children: [
      ExpansionPanelRadio(
        value: 'cat-account',
        canTapOnHeader: true,
        headerBuilder: (c, isExpanded) => ListTile(
          leading: Icon(Icons.person, color: Color(0xFF5E35B1)),
          title: Text('Account settings'),
          subtitle: Text('Profile, email, password'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFD1C4E9),
                    child: FlutterLogo(size: 32),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alex Doe',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'alex.doe@example.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _formField('Display name', 'Alex'),
              SizedBox(height: 8),
              _formField('Phone', '+1 (555) 123-0001'),
            ],
          ),
        ),
      ),
      ExpansionPanelRadio(
        value: 'cat-notifications',
        canTapOnHeader: true,
        headerBuilder: (c, isExpanded) => ListTile(
          leading: Icon(Icons.notifications, color: Color(0xFF5E35B1)),
          title: Text('Notifications'),
          subtitle: Text('Email, push, frequency'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _toggleRow('Email notifications', true),
              _toggleRow('Push notifications', false),
              _toggleRow('Weekly digest', true),
              _toggleRow('Promotional updates', false),
              SizedBox(height: 8),
              Text(
                'Frequency',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: [
                  _chip('Immediate', selected: false),
                  _chip('Hourly', selected: false),
                  _chip('Daily', selected: true),
                  _chip('Weekly', selected: false),
                ],
              ),
            ],
          ),
        ),
      ),
      ExpansionPanelRadio(
        value: 'cat-privacy',
        canTapOnHeader: true,
        headerBuilder: (c, isExpanded) => ListTile(
          leading: Icon(Icons.lock, color: Color(0xFF5E35B1)),
          title: Text('Privacy & data'),
          subtitle: Text('Visibility, exports, deletion'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose who can see your profile:',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 8),
              _radioRow('Everyone', selected: false),
              _radioRow('Connections only', selected: true),
              _radioRow('Only me', selected: false),
              SizedBox(height: 12),
              Row(
                children: [
                  _outlinedButton('Export data'),
                  SizedBox(width: 8),
                  _outlinedButton('Delete account', danger: true),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 5: STYLED VARIANTS — elevation, dividerColor, gapSize
  // ==========================================================================

  Widget styledVariant({
    required String label,
    required double elevation,
    required Color divider,
    required double gap,
    required Color accent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        ExpansionPanelList(
          elevation: elevation,
          dividerColor: divider,
          materialGapSize: gap,
          expansionCallback: (i, e) => print('$label panel $i → $e'),
          children: [
            ExpansionPanel(
              isExpanded: true,
              headerBuilder: (c, isExpanded) =>
                  ListTile(title: Text('Header A'), dense: true),
              body: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Body content for variant: $label'),
              ),
            ),
            ExpansionPanel(
              isExpanded: false,
              headerBuilder: (c, isExpanded) =>
                  ListTile(title: Text('Header B'), dense: true),
              body: Text('Hidden until expanded'),
            ),
          ],
        ),
      ],
    );
  }

  final styledVariants = <Widget>[
    styledVariant(
      label: 'elev 0 • thin gap',
      elevation: 0,
      divider: Color(0xFFB0BEC5),
      gap: 4,
      accent: Color(0xFF607D8B),
    ),
    styledVariant(
      label: 'elev 2 • teal divider',
      elevation: 2,
      divider: Color(0xFF26A69A),
      gap: 16,
      accent: Color(0xFF00897B),
    ),
    styledVariant(
      label: 'elev 6 • amber divider',
      elevation: 6,
      divider: Color(0xFFFFB300),
      gap: 24,
      accent: Color(0xFFEF6C00),
    ),
  ];

  // ==========================================================================
  // SECTION 6: canTapOnHeader true vs false
  // ==========================================================================

  Widget canTapTrue = ExpansionPanelList(
    elevation: 1,
    expansionCallback: (i, e) {},
    children: [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: true,
        headerBuilder: (c, isExpanded) => ListTile(
          leading: Icon(Icons.touch_app, color: Color(0xFF43A047)),
          title: Text('canTapOnHeader: true'),
          subtitle: Text('Entire header row is the tap-target'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Friendlier for touch — users can press anywhere on the header.',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    ],
  );

  Widget canTapFalse = ExpansionPanelList(
    elevation: 1,
    expansionCallback: (i, e) {},
    children: [
      ExpansionPanel(
        canTapOnHeader: false,
        isExpanded: true,
        headerBuilder: (c, isExpanded) => ListTile(
          leading: Icon(Icons.expand_more, color: Color(0xFFE53935)),
          title: Text('canTapOnHeader: false'),
          subtitle: Text('Only the chevron icon toggles'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Useful when the header itself contains interactive controls '
            '(buttons, switches) that should not steal the tap.',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 7: animationDuration variation
  // ==========================================================================

  Widget animationVariant(int ms, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${ms}ms',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 6),
        ExpansionPanelList(
          elevation: 1,
          animationDuration: Duration(milliseconds: ms),
          expansionCallback: (i, e) {},
          children: [
            ExpansionPanel(
              isExpanded: true,
              headerBuilder: (c, isExpanded) =>
                  ListTile(title: Text('Duration $ms'), dense: true),
              body: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  ms < 200
                      ? 'Snappy — almost instant'
                      : (ms < 600 ? 'Default-ish feel' : 'Slow, dramatic'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // SECTION 8: Recipe cards
  // ==========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Recipe 1: Single-open FAQ',
      'use': 'When users should focus on one answer at a time',
      'snippet':
          'ExpansionPanelList.radio(\n  children: [\n    ExpansionPanelRadio(value: "q1", ...),\n    ExpansionPanelRadio(value: "q2", ...),\n  ],\n);',
    },
    {
      'title': 'Recipe 2: Multi-open settings groups',
      'use': 'When users may want to compare panels side-by-side',
      'snippet':
          'ExpansionPanelList(\n  expansionCallback: (i, e) => setState(() => _open[i] = e),\n  children: [...],\n);',
    },
    {
      'title': 'Recipe 3: Header with interactive controls',
      'use':
          'When the header has its own switch/button — disable canTapOnHeader',
      'snippet': 'ExpansionPanel(canTapOnHeader: false, ...)',
    },
    {
      'title': 'Recipe 4: Auto-collapse on selection',
      'use': 'Close panel after a body action by calling setState',
      'snippet':
          'onTap: () => setState(() => _open[index] = false)',
    },
    {
      'title': 'Recipe 5: Custom divider color',
      'use': 'Match dividers to your brand or theme',
      'snippet':
          'ExpansionPanelList(\n  dividerColor: Theme.of(context).primaryColor,\n  ...\n)',
    },
    {
      'title': 'Recipe 6: Compact list with materialGapSize: 0',
      'use': 'Eliminate the gap between cards for dense UIs',
      'snippet': 'ExpansionPanelList(materialGapSize: 0, ...)',
    },
    {
      'title': 'Recipe 7: Initial open panel for radio',
      'use': 'Pre-open one section on page load',
      'snippet':
          'ExpansionPanelList.radio(\n  initialOpenPanelValue: "section-a",\n  ...\n)',
    },
    {
      'title': 'Recipe 8: Highlight the open panel header',
      'use': 'Style the header differently using isExpanded',
      'snippet':
          'headerBuilder: (ctx, e) => ColoredBox(\n  color: e ? accent : neutral,\n  child: ...,\n);',
    },
  ];

  // ==========================================================================
  // SECTION 9: Comparison table
  // ==========================================================================

  final comparison = <Map<String, String>>[
    {
      'feature': 'Multiple open',
      'panelList': 'Yes (any combination)',
      'radio': 'No (one only)',
      'tile': 'N/A (single tile)',
      'stepper': 'No (one active)',
    },
    {
      'feature': 'State ownership',
      'panelList': 'Caller',
      'radio': 'Widget-internal',
      'tile': 'Widget-internal',
      'stepper': 'Caller',
    },
    {
      'feature': 'Visual style',
      'panelList': 'Card stack',
      'radio': 'Card stack',
      'tile': 'In-flow list item',
      'stepper': 'Numbered steps',
    },
    {
      'feature': 'Has indicator',
      'panelList': 'Chevron',
      'radio': 'Chevron',
      'tile': 'Chevron',
      'stepper': 'Number + state icon',
    },
    {
      'feature': 'Animation duration',
      'panelList': 'Configurable',
      'radio': 'Configurable',
      'tile': 'Configurable',
      'stepper': 'Fixed-ish',
    },
    {
      'feature': 'Tap-on-header control',
      'panelList': 'canTapOnHeader bool',
      'radio': 'canTapOnHeader bool',
      'tile': 'Always',
      'stepper': 'onStepTapped callback',
    },
  ];

  // ==========================================================================
  // SECTION 10: Glossary
  // ==========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'ExpansionPanel',
      'def':
          'A single header+body pair living inside an ExpansionPanelList. '
          'Not directly placeable in the widget tree.',
    },
    {
      'term': 'ExpansionPanelList',
      'def':
          'Stateless layout widget that stacks ExpansionPanels with Material '
          'styling, animations, and a tap callback.',
    },
    {
      'term': 'ExpansionPanelRadio',
      'def':
          'A panel variant carrying a unique value, used inside '
          'ExpansionPanelList.radio for mutual-exclusion behavior.',
    },
    {
      'term': 'ExpansionPanelHeaderBuilder',
      'def':
          'A typedef: Widget Function(BuildContext, bool isExpanded). Lets '
          'the header react to its own expanded state.',
    },
    {
      'term': 'isExpanded',
      'def':
          'Per-panel bool flag determining whether the body is rendered. '
          'You own this state on the standard list.',
    },
    {
      'term': 'canTapOnHeader',
      'def':
          'When true the whole header is the toggle target; when false only '
          'the chevron icon toggles the panel.',
    },
    {
      'term': 'expansionCallback',
      'def':
          'Signature (int index, bool isExpanded). Fires when a header is '
          'tapped — the second arg is the new state after the tap.',
    },
    {
      'term': 'dividerColor',
      'def':
          'Color of the thin lines drawn between consecutive panels in the '
          'list.',
    },
    {
      'term': 'elevation',
      'def':
          'Material elevation (drop-shadow depth) applied to each panel card.',
    },
    {
      'term': 'materialGapSize',
      'def':
          'Vertical gap (logical pixels) between panels. Defaults to 16.',
    },
    {
      'term': 'animationDuration',
      'def':
          'Length of the expand/collapse motion. Defaults to ~200ms.',
    },
    {
      'term': 'initialOpenPanelValue',
      'def':
          'Radio-list only: the value of the panel that should be open on '
          'first render.',
    },
  ];

  // ==========================================================================
  // SECTION 11: Final composed widget tree
  // ==========================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ExpansionPanel & ExpansionPanelList',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo • Material Accordion Widgets',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFE3F2FD)),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _headerChip('headerBuilder'),
                    _headerChip('body'),
                    _headerChip('isExpanded'),
                    _headerChip('canTapOnHeader'),
                    _headerChip('dividerColor'),
                    _headerChip('elevation'),
                    _headerChip('expansionCallback'),
                    _headerChip('animationDuration'),
                    _headerChip('.radio'),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: DOSSIER =====
          _sectionHeader(
            number: '1',
            title: 'Dossier — When to choose what',
            color: Color(0xFF1976D2),
            background: Color(0xFFE3F2FD),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF90CAF9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in dossierItems)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['widget'] ?? '',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Use when: ${item['when']}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'State: ${item['state']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF616161),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 2: ANATOMY =====
          _sectionHeader(
            number: '2',
            title: 'Anatomy — Constructor parameters',
            color: Color(0xFF388E3C),
            background: Color(0xFFE8F5E9),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFA5D6A7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ExpansionPanel',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 8),
                for (final p in panelAnatomy) _paramRow(p),
                SizedBox(height: 12),
                Text(
                  'ExpansionPanelList',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 8),
                for (final p in listAnatomy) _paramRow(p),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 3: STANDARD LIST =====
          _sectionHeader(
            number: '3',
            title: 'Standard ExpansionPanelList — Live toggle',
            color: Color(0xFF7B1FA2),
            background: Color(0xFFF3E5F5),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFCE93D8)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Tap a header — state is held by a StatefulBuilder.',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ),
                standardList,
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 4: RADIO VARIANT =====
          _sectionHeader(
            number: '4',
            title: 'ExpansionPanelList.radio — Single-open mode',
            color: Color(0xFF512DA8),
            background: Color(0xFFEDE7F6),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFB39DDB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Open one category — opening another auto-collapses the previous.',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF311B92),
                    ),
                  ),
                ),
                radioList,
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 5: STYLED VARIANTS =====
          _sectionHeader(
            number: '5',
            title: 'Styled variants — elevation, divider, gap',
            color: Color(0xFFEF6C00),
            background: Color(0xFFFFF3E0),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFFFB74D)),
            ),
            child: Column(
              children: [
                for (int i = 0; i < styledVariants.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: styledVariants[i],
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 6: canTapOnHeader =====
          _sectionHeader(
            number: '6',
            title: 'canTapOnHeader — true vs false',
            color: Color(0xFF00838F),
            background: Color(0xFFE0F7FA),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF4DD0E1)),
            ),
            child: Column(
              children: [
                canTapTrue,
                SizedBox(height: 12),
                canTapFalse,
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Rule of thumb: keep canTapOnHeader: true for plain '
                    'informational panels, set it false when the header '
                    'embeds interactive widgets.',
                    style: TextStyle(fontSize: 12, height: 1.5),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 7: animationDuration =====
          _sectionHeader(
            number: '7',
            title: 'animationDuration — 100 / 400 / 1000 ms',
            color: Color(0xFFC2185B),
            background: Color(0xFFFCE4EC),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFF06292)),
            ),
            child: Column(
              children: [
                animationVariant(100, Color(0xFFAD1457)),
                SizedBox(height: 12),
                animationVariant(400, Color(0xFFC2185B)),
                SizedBox(height: 12),
                animationVariant(1000, Color(0xFFD81B60)),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 8: RECIPES =====
          _sectionHeader(
            number: '8',
            title: 'Recipe cards',
            color: Color(0xFF455A64),
            background: Color(0xFFECEFF1),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFECEFF1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFB0BEC5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final r in recipes)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: _recipeCard(r),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 9: COMPARISON =====
          _sectionHeader(
            number: '9',
            title: 'Comparison — Panel vs Tile vs Stepper',
            color: Color(0xFF6A1B9A),
            background: Color(0xFFF3E5F5),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFBA68C8)),
            ),
            child: Column(
              children: [
                _comparisonHeader(),
                Divider(color: Color(0xFFBA68C8)),
                for (final row in comparison) _comparisonRow(row),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 10: GLOSSARY =====
          _sectionHeader(
            number: '10',
            title: 'Glossary',
            color: Color(0xFF5D4037),
            background: Color(0xFFEFEBE9),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFA1887F)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final g in glossary)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g['term'] ?? '',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E342E),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            g['def'] ?? '',
                            style: TextStyle(fontSize: 12, height: 1.45),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ===== SECTION 11: FOOTER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coverage summary',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                _summary('headerBuilder receives isExpanded'),
                _summary('body rendered conditionally'),
                _summary('isExpanded driven by StatefulBuilder'),
                _summary('canTapOnHeader true & false demoed'),
                _summary('dividerColor & elevation variants'),
                _summary('materialGapSize varied per row'),
                _summary('expansionCallback wired with print + setState'),
                _summary('animationDuration: 100 / 400 / 1000 ms'),
                _summary('ExpansionPanelList.radio single-open'),
                _summary('initialOpenPanelValue preset'),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    'ExpansionPanel · ExpansionPanelList · ExpansionPanelRadio',
                    style: TextStyle(
                      color: Color(0xFFE3F2FD),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          Center(
            child: Text(
              'Deep Demo • Flutter Material Accordion Widgets',
              style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SUPPORT WIDGETS — top-level helpers used by the build() above
// ============================================================================

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionHeader({
  required String number,
  required String title,
  required Color color,
  required Color background,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 4)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _paramRow(Map<String, String> p) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFC8E6C9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  p['param'] ?? '',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ),
              SizedBox(width: 6),
              Text(
                p['type'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF388E3C),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(p['note'] ?? '', style: TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );
}

Widget _formField(String label, String value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFB39DDB)),
      borderRadius: BorderRadius.circular(6),
      color: Color(0xFFFFFFFF),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4527A0),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _toggleRow(String label, bool on) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(fontSize: 13))),
        Container(
          width: 36,
          height: 20,
          decoration: BoxDecoration(
            color: on ? Color(0xFF7E57C2) : Color(0xFFCFD8DC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: on ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, {required bool selected}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: selected ? Color(0xFF7E57C2) : Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF7E57C2)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        color: selected ? Color(0xFFFFFFFF) : Color(0xFF4527A0),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _radioRow(String label, {required bool selected}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFF5E35B1), width: 2),
            color: Color(0xFFFFFFFF),
          ),
          child: selected
              ? Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF5E35B1),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _outlinedButton(String label, {bool danger = false}) {
  final color = danger ? Color(0xFFC62828) : Color(0xFF5E35B1);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _recipeCard(Map<String, String> r) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: Color(0xFF455A64), width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          r['title'] ?? '',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 4),
        Text(
          r['use'] ?? '',
          style: TextStyle(fontSize: 11.5, color: Color(0xFF546E7A)),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            r['snippet'] ?? '',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFB2DFDB),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonHeader() {
  return Row(
    children: [
      Expanded(flex: 3, child: _hCell('Feature')),
      Expanded(flex: 2, child: _hCell('PanelList')),
      Expanded(flex: 2, child: _hCell('.radio')),
      Expanded(flex: 2, child: _hCell('Tile')),
      Expanded(flex: 2, child: _hCell('Stepper')),
    ],
  );
}

Widget _hCell(String label) {
  return Text(
    label,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: Color(0xFF4A148C),
    ),
  );
}

Widget _comparisonRow(Map<String, String> row) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            row['feature'] ?? '',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A1B9A),
            ),
          ),
        ),
        Expanded(flex: 2, child: _cCell(row['panelList'] ?? '')),
        Expanded(flex: 2, child: _cCell(row['radio'] ?? '')),
        Expanded(flex: 2, child: _cCell(row['tile'] ?? '')),
        Expanded(flex: 2, child: _cCell(row['stepper'] ?? '')),
      ],
    ),
  );
}

Widget _cCell(String value) {
  return Text(value, style: TextStyle(fontSize: 10.5, height: 1.35));
}

Widget _summary(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '✓',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
