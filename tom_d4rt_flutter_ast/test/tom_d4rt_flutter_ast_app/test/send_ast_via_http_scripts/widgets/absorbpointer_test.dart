// D4rt visual demo: AbsorbPointer (widgets)
// Deep, narrative tour of pointer absorption — toggles, comparisons,
// busy-state overlays, modal blockers, and semantic implications.
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1 — Section header banner & narrative introduction.
  // ===========================================================================
  final headerBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF283593),
          Color(0xFF3949AB),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.4,
                ),
              ),
              child: Icon(
                Icons.touch_app_outlined,
                size: 36.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AbsorbPointer',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Swallowing hit-tests inside its subtree.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'AbsorbPointer prevents its child from receiving any pointer '
                'events. Unlike IgnorePointer, it ALSO blocks events from '
                'reaching widgets beneath it — it is a hit-test sponge. Use '
                'it to mask interactivity while preserving layout, opacity, '
                'and visual presence of the child subtree.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.95),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 — Basic toggle gallery.
  // ===========================================================================
  final basicGalleryTiles = <Widget>[];

  // Tile A: absorbing = false (button is live).
  basicGalleryTiles.add(
    Container(
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.lightGreen.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.green.shade400, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: Colors.green.shade700,
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'absorbing: false',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'The AbsorbPointer is transparent to events. The child button '
                'is live and would respond normally.',
            style: TextStyle(fontSize: 12.0, color: Colors.green.shade900),
          ),
          SizedBox(height: 14.0),
          AbsorbPointer(
            absorbing: false,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.check_circle_outline),
              label: Text('Live button'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Tile B: absorbing = true (button is blocked).
  basicGalleryTiles.add(
    Container(
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.deepOrange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.red.shade400, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, color: Colors.red.shade700, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'absorbing: true',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Taps land on the AbsorbPointer and stop there. The button is '
                'visually present but functionally inert.',
            style: TextStyle(fontSize: 12.0, color: Colors.red.shade900),
          ),
          SizedBox(height: 14.0),
          AbsorbPointer(
            absorbing: true,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.do_not_disturb_alt),
              label: Text('Inert button'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Tile C: dynamic toggle illustration.
  basicGalleryTiles.add(
    Container(
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.indigo.shade400, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.toggle_on_outlined,
                color: Colors.indigo.shade700,
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'absorbing: <bool expr>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Bind absorbing to a state flag like isLoading or '
                'isReadOnly. Toggling rebuilds the subtree without '
                'replacing widgets.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade900),
          ),
          SizedBox(height: 14.0),
          Row(
            children: List.generate(3, (i) {
              final flag = i == 0;
              return Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: AbsorbPointer(
                  absorbing: !flag,
                  child: Chip(
                    label: Text('btn $i'),
                    backgroundColor: flag
                        ? Colors.indigo.shade200
                        : Colors.grey.shade300,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );

  // Tile D: nested AbsorbPointer behavior.
  basicGalleryTiles.add(
    Container(
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.deepPurple.shade400, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_tree_outlined,
                color: Colors.deepPurple.shade700,
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'nested AbsorbPointer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'An inner AbsorbPointer(absorbing:false) does NOT unblock an '
                'outer absorbing:true ancestor. The outer wins.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 14.0),
          AbsorbPointer(
            absorbing: true,
            child: AbsorbPointer(
              absorbing: false,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  foregroundColor: Colors.white,
                ),
                child: Text('Still absorbed'),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final basicGalleryGrid = Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14.0,
      mainAxisSpacing: 14.0,
      childAspectRatio: 1.05,
      children: basicGalleryTiles,
    ),
  );

  // ===========================================================================
  // SECTION 3 — ignoringSemantics demonstration.
  // ===========================================================================
  final semanticTiles = <Widget>[];

  semanticTiles.add(
    _semanticCard(
      title: 'ignoringSemantics: null (default)',
      description:
          'When null, the semantic tree mirrors the absorbing flag. A '
              'screen reader treats the subtree as disabled if absorbing '
              'is true.',
      accent: Colors.teal,
      icon: Icons.accessibility_new,
      sample: AbsorbPointer(
        absorbing: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.keyboard, color: Colors.teal.shade700),
            SizedBox(width: 8.0),
            Text('Inert + semantically blocked'),
          ],
        ),
      ),
    ),
  );

  semanticTiles.add(
    _semanticCard(
      title: 'ignoringSemantics: false',
      description:
          'Force the semantic tree to keep exposing the subtree even '
              'while pointer events are absorbed. Useful for read-only '
              'forms that still announce their content.',
      accent: Colors.amber.shade800,
      icon: Icons.record_voice_over,
      sample: AbsorbPointer(
        absorbing: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.text_snippet, color: Colors.amber.shade900),
            SizedBox(width: 8.0),
            Text('Inert but readable'),
          ],
        ),
      ),
    ),
  );

  semanticTiles.add(
    _semanticCard(
      title: 'ignoringSemantics: true',
      description:
          'Both pointer and semantic trees are silenced. The subtree is '
              'effectively invisible to assistive technology.',
      accent: Colors.brown,
      icon: Icons.volume_off,
      sample: ExcludeSemantics(
        excluding: true,
        child: AbsorbPointer(
          absorbing: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hearing_disabled, color: Colors.brown.shade700),
              SizedBox(width: 8.0),
              Text('Silenced subtree'),
            ],
          ),
        ),
      ),
    ),
  );

  final semanticsSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: semanticTiles,
  );

  // ===========================================================================
  // SECTION 4 — AbsorbPointer vs IgnorePointer.
  // ===========================================================================
  final comparisonRows = <Widget>[];

  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'AbsorbPointer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'IgnorePointer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );

  final comparisonRowData = <Map<String, String>>[
    {
      'aspect': 'Hit-test behavior',
      'absorb': 'Consumes the pointer event itself.',
      'ignore': 'Hides itself from hit testing entirely.',
    },
    {
      'aspect': 'Sibling beneath',
      'absorb': 'NOT reached — sponge.',
      'ignore': 'Receives the pointer event.',
    },
    {
      'aspect': 'Visual',
      'absorb': 'Subtree fully visible.',
      'ignore': 'Subtree fully visible.',
    },
    {
      'aspect': 'Common use',
      'absorb': 'Modal overlays, busy shrouds.',
      'ignore': 'Click-through decorative layers.',
    },
    {
      'aspect': 'Semantics',
      'absorb': 'Hidden by default, configurable.',
      'ignore': 'Always hidden when ignoring.',
    },
    {
      'aspect': 'Typical pitfall',
      'absorb': 'Forgetting to toggle off.',
      'ignore': 'Letting clicks reach unwanted layers.',
    },
  ];

  for (int i = 0; i < comparisonRowData.length; i++) {
    final r = comparisonRowData[i];
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        color: i.isEven ? Colors.grey.shade100 : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                r['aspect'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                r['absorb'] ?? '',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 12.5,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                r['ignore'] ?? '',
                style: TextStyle(
                  color: Colors.orange.shade900,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [comparisonHeader, ...comparisonRows],
    ),
  );

  // Side-by-side live demo of AbsorbPointer vs IgnorePointer.
  final liveCompareCards = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _liveCompareCard(asAbsorber: true)),
      SizedBox(width: 14.0),
      Expanded(child: _liveCompareCard(asAbsorber: false)),
    ],
  );

  // ===========================================================================
  // SECTION 5 — Real-world overlay patterns: loading shroud.
  // ===========================================================================
  final loadingShroudDemo = Container(
    height: 320.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.4),
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        // Underlying form content.
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cloud_sync, color: Colors.blueGrey.shade700),
                  SizedBox(width: 8.0),
                  Text(
                    'Syncing your workspace...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _fakeTextField('Workspace name', Icons.workspaces_outline),
              SizedBox(height: 10.0),
              _fakeTextField('Repository URL', Icons.link),
              SizedBox(height: 10.0),
              _fakeTextField('Branch', Icons.alt_route),
              SizedBox(height: 14.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.refresh),
                      label: Text('Resync'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.cancel_outlined),
                    label: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Loading shroud layer.
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: Container(
              color: Colors.white.withValues(alpha: 0.78),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 56.0,
                    height: 56.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 5.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.indigo.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade700,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_clock,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Form locked while syncing',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
  );

  // ===========================================================================
  // SECTION 6 — Disabled form pattern (read-only).
  // ===========================================================================
  final readOnlyFormDemo = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.visibility, color: Colors.amber.shade900),
            SizedBox(width: 8.0),
            Text(
              'Read-only invoice preview',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Wrap the editor in AbsorbPointer(absorbing: true, '
              'ignoringSemantics: false) — users still see the structure '
              'and assistive tech still reads it; only mutation is '
              'forbidden.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.amber.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        AbsorbPointer(
          absorbing: true,
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _readOnlyRow('Customer', 'Aurora Robotics, Ltd.'),
                _readOnlyRow('Invoice #', 'INV-2026-0517'),
                _readOnlyRow('Subtotal', 'EUR 3,420.00'),
                _readOnlyRow('VAT (19%)', 'EUR 649.80'),
                Divider(),
                _readOnlyRow('Total', 'EUR 4,069.80', emphasize: true),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit_off),
                      label: Text('Edit (locked)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.print_outlined),
                      label: Text('Print'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — Modal blocker pattern.
  // ===========================================================================
  final modalBlockerDemo = Container(
    height: 360.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.4),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        // Background app shell.
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(4, (i) {
                  final names = [
                    'Inbox',
                    'Pipelines',
                    'Releases',
                    'Settings',
                  ];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? Colors.deepPurple.shade400
                            : Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        names[i],
                        style: TextStyle(
                          color: i == 0
                              ? Colors.white
                              : Colors.deepPurple.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(5, (i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.deepPurple.shade100,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.deepPurple.shade200,
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: Colors.deepPurple.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              'Build #${980 + i} — main — green',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.deepPurple.shade900,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.deepPurple.shade400,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        // Modal blocker — AbsorbPointer over the entire app shell.
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: Container(
              color: Colors.black.withValues(alpha: 0.45),
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(24.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 24.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.deepOrange.shade600,
                      size: 44.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Confirm release?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'The application beneath is blocked from interaction.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange.shade600,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — Busy state row of cards (Stack layering demo).
  // ===========================================================================
  final busyCardsRow = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.teal.shade300, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard_customize, color: Colors.teal.shade800),
            SizedBox(width: 8.0),
            Text(
              'Per-card busy shrouds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Each card individually toggles a Stack-layered '
              'AbsorbPointer(absorbing: card.isBusy) so only one card is '
              'frozen at a time. The rest of the screen stays usable.',
          style: TextStyle(fontSize: 12.5, color: Colors.teal.shade900),
        ),
        SizedBox(height: 16.0),
        Row(
          children: List.generate(3, (i) {
            final busyStates = [false, true, false];
            final palettes = <List<Color>>[
              [Colors.lightBlue.shade400, Colors.blue.shade700],
              [Colors.pink.shade300, Colors.deepOrange.shade400],
              [Colors.lightGreen.shade400, Colors.green.shade700],
            ];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: _busyCard(
                  title: 'Service ${i + 1}',
                  isBusy: busyStates[i],
                  colors: palettes[i],
                  index: i,
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 — Layered Stack of cards with translucent absorbing overlay.
  // ===========================================================================
  final layeredStackDemo = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.layers_outlined,
              color: Colors.deepOrange.shade700,
            ),
            SizedBox(width: 8.0),
            Text(
              'Layered Stack with translucent absorber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'AbsorbPointer wraps a Stack of cards. A translucent overlay '
              'on top swallows every tap before it can reach the cards.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 240.0,
          child: AbsorbPointer(
            absorbing: true,
            child: Stack(
              children: List.generate(4, (i) {
                final offset = (i * 16.0).toDouble();
                final hueShift = (i * 38) % 360;
                return Positioned(
                  left: offset,
                  top: offset,
                  right: offset,
                  bottom: offset,
                  child: _shadowCard(
                    title: 'Layer ${i + 1}',
                    hueShift: hueShift,
                    depth: i,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — Semantic implications spotlight.
  // ===========================================================================
  final semanticImplications = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 16.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.psychology_outlined, color: Colors.cyanAccent),
            SizedBox(width: 8.0),
            Text(
              'Semantic implications',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _bulletLine(
          color: Colors.cyanAccent,
          text:
              'AbsorbPointer is NOT just a visual trick — it is a structural '
              'gate. Screen readers, focus traversal, and keyboard '
              'navigation all observe the gate.',
        ),
        _bulletLine(
          color: Colors.amberAccent,
          text:
              'Use ignoringSemantics: false for read-only mode where the '
              'value should still be announced.',
        ),
        _bulletLine(
          color: Colors.lightGreenAccent,
          text:
              'For purely decorative overlays (e.g. an artistic graphic), '
              'prefer IgnorePointer — clicks can fall through to the live '
              'content beneath.',
        ),
        _bulletLine(
          color: Colors.pinkAccent,
          text:
              'When you want the user to BE STOPPED (modal confirmation, '
              'progress, paywall), AbsorbPointer is the right tool.',
        ),
        _bulletLine(
          color: Colors.orangeAccent,
          text:
              'Nesting an AbsorbPointer(absorbing: false) inside an '
              'absorbing: true ancestor does NOT punch a hole — the '
              'outer absorber still wins.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 — Animated dial of absorbing flag transitions.
  // ===========================================================================
  final dialTiles = <Widget>[];
  for (int i = 0; i < 8; i++) {
    final absorbing = (i % 2 == 0);
    final angle = (i * math.pi / 4);
    dialTiles.add(
      Transform.rotate(
        angle: angle * 0.05,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(12.0),
          width: 110.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: absorbing
                  ? [Colors.red.shade400, Colors.deepOrange.shade700]
                  : [Colors.green.shade400, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: (absorbing ? Colors.red : Colors.green).withValues(
                  alpha: 0.40,
                ),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                absorbing ? Icons.block : Icons.check_circle_outline,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(height: 6.0),
              Text(
                absorbing ? 'absorb' : 'pass',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'phase $i',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final dialRow = Wrap(alignment: WrapAlignment.center, children: dialTiles);

  // ===========================================================================
  // SECTION 12 — Timeline narrative of an absorbing button click.
  // ===========================================================================
  final timelineSteps = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'User taps the screen',
      'description':
          'The framework dispatches a PointerDownEvent and walks the '
              'render tree, performing hit testing.',
      'color': Colors.blue.shade600,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Hit test reaches AbsorbPointer',
      'description':
          'AbsorbPointer.hitTestSelf returns true when absorbing is true. '
              'The pointer is considered handled by the AbsorbPointer.',
      'color': Colors.deepPurple.shade600,
    },
    {
      'icon': Icons.shield_outlined,
      'title': 'Children are skipped',
      'description':
          'The hit-test walk stops at the AbsorbPointer. No descendant '
              'RenderObject is asked about the event.',
      'color': Colors.red.shade600,
    },
    {
      'icon': Icons.layers_clear,
      'title': 'Siblings beneath are skipped too',
      'description':
          'Unlike an InkWell sitting beside a transparent overlay, the '
              'AbsorbPointer also blocks downward propagation, so any '
              'underlying widgets stay dormant.',
      'color': Colors.deepOrange.shade600,
    },
    {
      'icon': Icons.event_busy,
      'title': 'No callback fires',
      'description':
          'Buttons, GestureDetectors, and ink wells inside the subtree '
              'never see the event. The UI looks present but inert.',
      'color': Colors.brown.shade700,
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'Semantics observe the gate',
      'description':
          'Unless ignoringSemantics is explicitly false, screen readers '
              'are also told the subtree is unavailable.',
      'color': Colors.teal.shade700,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineSteps.length; i++) {
    final step = timelineSteps[i];
    final isLast = i == timelineSteps.length - 1;
    timelineWidgets.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: step['color'] as Color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (step['color'] as Color).withValues(
                          alpha: 0.40,
                        ),
                        blurRadius: 8.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    step['icon'] as IconData,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: (step['color'] as Color).withValues(alpha: 0.45),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: step['color'] as Color,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        step['description'] as String,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade800,
                          height: 1.45,
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
    );
  }
  final timelineSection = Column(children: timelineWidgets);

  // ===========================================================================
  // SECTION 13 — Pseudo-code panel.
  // ===========================================================================
  final codeBlocks = <Widget>[];
  final codeSamples = <Map<String, String>>[
    {
      'title': 'Loading shroud',
      'code':
          'Stack(\n'
              '  children: [\n'
              '    MyForm(),\n'
              '    if (isBusy)\n'
              '      Positioned.fill(\n'
              '        child: AbsorbPointer(\n'
              '          absorbing: true,\n'
              '          child: ColoredBox(\n'
              '            color: Colors.white.withValues(alpha: 0.7),\n'
              '            child: Center(child: CircularProgressIndicator()),\n'
              '          ),\n'
              '        ),\n'
              '      ),\n'
              '  ],\n'
              ')',
    },
    {
      'title': 'Read-only mode',
      'code':
          'AbsorbPointer(\n'
              '  absorbing: isReadOnly,\n'
              '  ignoringSemantics: false,\n'
              '  child: InvoiceEditor(...),\n'
              ');',
    },
    {
      'title': 'Modal blocker',
      'code':
          'AbsorbPointer(\n'
              '  absorbing: true,\n'
              '  child: ColoredBox(\n'
              '    color: Colors.black.withValues(alpha: 0.45),\n'
              '    child: Center(child: ConfirmDialog(...)),\n'
              '  ),\n'
              ');',
    },
    {
      'title': 'Per-card busy',
      'code':
          'Stack(\n'
              '  children: [\n'
              '    ServiceCard(...),\n'
              '    if (card.isBusy)\n'
              '      Positioned.fill(\n'
              '        child: AbsorbPointer(\n'
              '          absorbing: true,\n'
              '          child: BusyShroud(),\n'
              '        ),\n'
              '      ),\n'
              '  ],\n'
              ');',
    },
  ];
  for (final c in codeSamples) {
    codeBlocks.add(
      Container(
        margin: EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xFF1E1E2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              color: Color(0xFF2A2A40),
              child: Row(
                children: [
                  Icon(
                    Icons.code,
                    color: Colors.cyanAccent.shade100,
                    size: 16.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    c['title'] ?? '',
                    style: TextStyle(
                      color: Colors.cyanAccent.shade100,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                c['code'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final codePanel = Column(children: codeBlocks);

  // ===========================================================================
  // SECTION 14 — Pitfalls panel.
  // ===========================================================================
  final pitfallTiles = <Widget>[
    _pitfallTile(
      icon: Icons.warning_amber,
      title: 'Stuck absorber',
      detail:
          'Forgetting to flip absorbing back to false leaves the UI '
              'forever inert. Always tie absorbing to a state machine '
              'with explicit transitions.',
      color: Colors.deepOrange,
    ),
    _pitfallTile(
      icon: Icons.touch_app,
      title: 'Wrong tool for click-through',
      detail:
          'If you wanted decorative overlay clicks to PASS THROUGH, '
              'AbsorbPointer is wrong — IgnorePointer is what you want.',
      color: Colors.purple,
    ),
    _pitfallTile(
      icon: Icons.accessibility,
      title: 'Silenced semantics',
      detail:
          'Default ignoringSemantics hides the subtree from screen '
              'readers. For read-only data displays, set '
              'ignoringSemantics: false.',
      color: Colors.indigo,
    ),
    _pitfallTile(
      icon: Icons.layers,
      title: 'Layer order',
      detail:
          'The overlay must be ABOVE the protected widgets in the Stack '
              '— otherwise the hit test reaches them first.',
      color: Colors.teal,
    ),
  ];

  final pitfallsPanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.yellow.shade50,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade500, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem, color: Colors.amber.shade900),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & footguns',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...pitfallTiles,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 — Final summary banner.
  // ===========================================================================
  final summaryBanner = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF004D40),
          Color(0xFF00695C),
          Color(0xFF00897B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF004D40).withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: Colors.tealAccent),
            SizedBox(width: 10.0),
            Text(
              'Summary — when to reach for AbsorbPointer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _summaryRow(
          icon: Icons.lock_clock,
          tint: Colors.lightBlueAccent,
          title: 'Lock during long operations',
          detail:
              'Form syncs, network calls, transactional pipelines.',
        ),
        _summaryRow(
          icon: Icons.visibility,
          tint: Colors.amberAccent,
          title: 'Read-only displays',
          detail:
              'Show structure and values without accidental edits.',
        ),
        _summaryRow(
          icon: Icons.shield_moon,
          tint: Colors.purpleAccent,
          title: 'Modal & paywall blockers',
          detail:
              'Force a confirmation moment before anything underneath '
              'can be touched.',
        ),
        _summaryRow(
          icon: Icons.dashboard_customize,
          tint: Colors.greenAccent,
          title: 'Card-scoped busy states',
          detail:
              'Freeze ONE card while the rest of the dashboard keeps '
              'working.',
        ),
        _summaryRow(
          icon: Icons.accessibility_new,
          tint: Colors.pinkAccent,
          title: 'Tune semantics deliberately',
          detail:
              'Hide or expose the subtree to assistive technology via '
              'ignoringSemantics.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // FINAL SCAFFOLD — assemble all sections.
  // ===========================================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    appBar: AppBar(
      title: Text('AbsorbPointer — Deep Visual Tour'),
      backgroundColor: Color(0xFF1A237E),
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerBanner,
          SizedBox(height: 28.0),
          _sectionHeader(
            number: '1',
            title: 'Basic toggle gallery',
            subtitle:
                'absorbing: false, true, expression-bound, and nested.',
            tint: Colors.indigo,
          ),
          SizedBox(height: 14.0),
          basicGalleryGrid,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '2',
            title: 'ignoringSemantics',
            subtitle:
                'How the semantic tree is preserved or stripped along '
                    'with pointer events.',
            tint: Colors.teal,
          ),
          SizedBox(height: 14.0),
          semanticsSection,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '3',
            title: 'AbsorbPointer vs IgnorePointer',
            subtitle:
                'A line-by-line comparison plus a side-by-side live demo.',
            tint: Colors.deepPurple,
          ),
          SizedBox(height: 14.0),
          comparisonTable,
          SizedBox(height: 18.0),
          liveCompareCards,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '4',
            title: 'Loading shroud',
            subtitle:
                'A full-form lockout during a network call.',
            tint: Colors.blueGrey,
          ),
          SizedBox(height: 14.0),
          loadingShroudDemo,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '5',
            title: 'Read-only form',
            subtitle:
                'AbsorbPointer + ignoringSemantics: false for accessible '
                    'read-only views.',
            tint: Colors.amber.shade800,
          ),
          SizedBox(height: 14.0),
          readOnlyFormDemo,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '6',
            title: 'Modal blocker',
            subtitle:
                'A confirmation dialog that freezes the entire app behind.',
            tint: Colors.deepPurple,
          ),
          SizedBox(height: 14.0),
          modalBlockerDemo,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '7',
            title: 'Per-card busy state',
            subtitle:
                'A Stack-layered shroud freezes ONE card without affecting '
                    'the rest.',
            tint: Colors.teal,
          ),
          SizedBox(height: 14.0),
          busyCardsRow,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '8',
            title: 'Layered Stack absorber',
            subtitle:
                'A translucent overlay swallows taps before any layer can '
                    'react.',
            tint: Colors.deepOrange,
          ),
          SizedBox(height: 14.0),
          layeredStackDemo,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '9',
            title: 'Semantic implications',
            subtitle:
                'Why pointer absorption is also an accessibility decision.',
            tint: Colors.blueGrey,
          ),
          SizedBox(height: 14.0),
          semanticImplications,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '10',
            title: 'Phase dial',
            subtitle:
                'A wrap of phase tiles toggling absorbing on and off.',
            tint: Colors.red,
          ),
          SizedBox(height: 14.0),
          dialRow,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '11',
            title: 'Timeline of an absorbed tap',
            subtitle:
                'Step-by-step narrative of how a PointerDownEvent is stopped.',
            tint: Colors.indigo,
          ),
          SizedBox(height: 14.0),
          timelineSection,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '12',
            title: 'Code patterns',
            subtitle:
                'Cheat-sheet recipes you can copy into production code.',
            tint: Colors.deepPurple,
          ),
          SizedBox(height: 14.0),
          codePanel,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '13',
            title: 'Pitfalls & footguns',
            subtitle:
                'Common mistakes that turn AbsorbPointer into a bug source.',
            tint: Colors.amber.shade900,
          ),
          SizedBox(height: 14.0),
          pitfallsPanel,
          SizedBox(height: 32.0),
          _sectionHeader(
            number: '14',
            title: 'Summary',
            subtitle: 'When and why to choose AbsorbPointer.',
            tint: Colors.teal,
          ),
          SizedBox(height: 14.0),
          summaryBanner,
          SizedBox(height: 40.0),
        ],
      ),
    ),
  );
}

// =============================================================================
// HELPERS
// =============================================================================

Widget _sectionHeader({
  required String number,
  required String title,
  required String subtitle,
  required Color tint,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(14.0),
      border: Border(
        left: BorderSide(color: tint, width: 6.0),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: 0.45),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: tint,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _semanticCard({
  required String title,
  required String description,
  required Color accent,
  required IconData icon,
  required Widget sample,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: accent, size: 26.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: accent,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: sample,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _liveCompareCard({required bool asAbsorber}) {
  final accent = asAbsorber ? Colors.blue.shade700 : Colors.orange.shade700;
  final title = asAbsorber ? 'AbsorbPointer' : 'IgnorePointer';
  final caption = asAbsorber
      ? 'Hit-test stops here; the button beneath is ALSO blocked.'
      : 'Hit-test passes through; the button beneath IS reachable.';
  final overlay = asAbsorber
      ? AbsorbPointer(
          absorbing: true,
          child: Container(
            color: Colors.blue.withValues(alpha: 0.25),
            alignment: Alignment.center,
            child: Text(
              'AbsorbPointer overlay',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      : IgnorePointer(
          ignoring: true,
          child: Container(
            color: Colors.orange.withValues(alpha: 0.25),
            alignment: Alignment.center,
            child: Text(
              'IgnorePointer overlay',
              style: TextStyle(
                color: Colors.orange.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

  return Container(
    height: 220.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          color: accent,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.touch_app),
                  label: Text('Underlying button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent.withValues(alpha: 0.85),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Positioned.fill(child: overlay),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            caption,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fakeTextField(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.blueGrey.shade400, size: 18.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 13.0),
        ),
      ],
    ),
  );
}

Widget _readOnlyRow(String label, String value, {bool emphasize = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: emphasize ? FontWeight.bold : FontWeight.w500,
              fontSize: emphasize ? 16.0 : 13.0,
              color: emphasize ? Colors.amber.shade900 : Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _busyCard({
  required String title,
  required bool isBusy,
  required List<Color> colors,
  required int index,
}) {
  return Container(
    height: 160.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: colors.first.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cloud_outlined,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'tap to ping\n#$index',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 11.5,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'Ping',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isBusy)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.45),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 28.0,
                      height: 28.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'busy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _shadowCard({
  required String title,
  required int hueShift,
  required int depth,
}) {
  final hue = (220 + hueShift) % 360;
  final base = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.6, 0.55).toColor();
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          base.withValues(alpha: 0.88),
          base.withValues(alpha: 0.65),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15 + depth * 0.04),
          blurRadius: 12.0 + depth * 2.0,
          offset: Offset(0, 6.0 + depth.toDouble()),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.layers, color: Colors.white, size: 32.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'depth $depth',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletLine({required Color color, required String text}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile({
  required IconData icon,
  required String title,
  required String detail,
  required MaterialColor color,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color.shade800, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _summaryRow({
  required IconData icon,
  required Color tint,
  required String title,
  required String detail,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: tint, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                detail,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
